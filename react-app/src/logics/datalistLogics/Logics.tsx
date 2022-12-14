import type { Covids } from "../../store/datalistSlices/DataSlice";
import { ItemsFilters } from "../../store/datalistSlices/FilteringSlice";
import { ItemsSorts } from "../../store/datalistSlices/SortingSlice";





// set unique select year list from covid database
export const uniqueList = (prop: Covids[], field: string, type: string) => {
    if (field === "date" && type === "dateselect") {
        const mapped = prop.map((item, index) => item.date ? item.date.split('-')[0] : null);
        const filtered = mapped.filter((date, index) => mapped.indexOf(date) === index)
        return ["..."].concat(filtered as string[]);
    }
    else {
        const mapped = prop.map((item, index) => item[field as keyof Covids] ? item[field as keyof Covids] : null);
        const filtered = mapped.filter((field, index) => mapped.indexOf(field) === index);
        return filtered;
    }
};


// Multiple Sorting
export const sortedDataField = (prop: Covids[], isInitial: boolean, sorts: ItemsSorts[]) => {
    const copySorts = [...prop];

    const multipleSort = () => {
        return function (a: Covids, b: Covids) {
            return sorts.map(item => {
                let sortfield = item.sortfield;
                if (sortfield) {
                    let ascdesc = item.sorttype === "asc" ? 1 : -1;
                    return a[sortfield as keyof Covids] > b[sortfield as keyof Covids] ? ascdesc : a[sortfield as keyof Covids] < b[sortfield as keyof Covids] ? -ascdesc : 0;
                } else return 0;
            }).reduce((p, n) => p ? p : n, 0);
            // return first non zero value;
        };
    }
    // Initial descending date and time sort for Map Data
    if (isInitial) {

        return copySorts.sort(function (a, b) {
            return b.date.localeCompare(a.date) || b.time.localeCompare(a.time);
        });
    } else return copySorts.sort(multipleSort());

};


export const compareItemDate = (prop: string, date: string, comp: boolean) => {
    if (getYear(prop) === "..." && getMonth(prop) === "..." && getDay(prop) === "...")
        return true
    //000
    if (getYear(prop) !== "..." && getMonth(prop) !== "..." && getDay(prop) !== "...")
        return comp ? new Date(prop) <= new Date(date)
            : new Date(prop) >= new Date(date)
    //111
    if (getYear(prop) !== "..." && getMonth(prop) !== "..." && getDay(prop) === "...")
        return comp ? getYear(prop).concat(getMonth(prop)) <= getYear(date).concat(getMonth(date))
            : getYear(prop).concat(getMonth(prop)) >= getYear(date).concat(getMonth(date))
    //110
    if (getYear(prop) === "..." && getMonth(prop) !== "..." && getDay(prop) !== "...")
        return comp ? getMonth(prop).concat(getDay(prop)) <= getMonth(date).concat(getDay(date))
            : getMonth(prop).concat(getDay(prop)) >= getMonth(date).concat(getDay(date))
    //011
    if (getYear(prop) !== "..." && getMonth(prop) === "..." && getDay(prop) !== "...")
        return comp ? getYear(prop) <= getYear(date) && getDay(prop) <= getDay(date)
            : getYear(prop) >= getYear(date) && getDay(prop) >= getDay(date)
    //101
    if (getYear(prop) !== "..." && getMonth(prop) === "..." && getDay(prop) === "...")
        return comp ? getYear(prop) <= getYear(date)
            : getYear(prop) >= getYear(date)
    //100
    if (getYear(prop) === "..." && getMonth(prop) !== "..." && getDay(prop) === "...")
        return comp ? getMonth(prop) <= getMonth(date)
            : getMonth(prop) >= getMonth(date)
    //010
    if (getYear(prop) === "..." && getMonth(prop) === "..." && getDay(prop) !== "...")
        return comp ? getDay(prop) <= getDay(date)
            : getDay(prop) >= getDay(date)
    //001
    return false;
};


// Filtering
export const filteredDataField = (data: Covids[], filters: ItemsFilters[]) => {
    return (
        data.filter(itemCovid => {
            let filterPass = true;
            filters.map((item) => {

                // Date filtering
                if (item.type === "date" && (item.min || item.max)) {
                    // Not dateselect
                    if (item.listtype !== "dateselect") {
                        const newdatefilter = new Date(itemCovid.date);
                        if (item.notequal === false) {
                            if (item.min) filterPass = filterPass && (new Date(item.min) <= newdatefilter);
                            if (item.max) filterPass = filterPass && (new Date(item.max) >= newdatefilter);
                        }
                        else {
                            if (item.min && item.max) filterPass = filterPass && (
                                !(new Date(item.min) <= newdatefilter) || !(new Date(item.max) >= newdatefilter))
                            else {
                                if (item.min) filterPass = filterPass && !(new Date(item.min) <= newdatefilter);
                                if (item.max) filterPass = filterPass && !(new Date(item.max) >= newdatefilter);
                            }
                        }
                    }
                    // Dateselect
                    else {
                        if (item.notequal === false) {
                            if (item.min) filterPass = filterPass && compareItemDate(item.min, itemCovid.date, true);
                            if (item.max) filterPass = filterPass && compareItemDate(item.max, itemCovid.date, false);
                        }
                        else {
                            if (item.min && item.max) filterPass = filterPass && (
                                !compareItemDate(item.min, itemCovid.date, true) || !compareItemDate(item.max, itemCovid.date, false))
                            else {
                                if (item.min) filterPass = filterPass && !compareItemDate(item.min, itemCovid.date, true);
                                if (item.max) filterPass = filterPass && !compareItemDate(item.max, itemCovid.date, false);
                            }
                        }
                    }
                }
                // Time filtering
                else if (item.type === "time" && (item.min || item.max)) {
                    const newtimefilter = (itemCovid.time);
                    if (item.notequal === false) {
                        if (item.min) filterPass = filterPass && (item.min) <= (newtimefilter);
                        if (item.max) filterPass = filterPass && (item.max) >= (newtimefilter);
                    }
                    else {
                        if (item.min && item.max) filterPass = filterPass && (
                            !(item.min <= newtimefilter) || !(item.max >= newtimefilter))
                        else {
                            if (item.min) filterPass = filterPass && !(item.min <= newtimefilter);
                            if (item.max) filterPass = filterPass && !(item.max >= newtimefilter);
                        }
                    }
                }
                // Other fields filtering
                else if (item.min || item.max) {
                    const newnumberfilter = itemCovid[item.fieldname as keyof Covids];
                    if (item.notequal === false) {
                        if (item.min) filterPass = filterPass && (parseInt(item.min, 10) <= newnumberfilter);
                        if (item.max) filterPass = filterPass && (parseInt(item.max, 10) >= newnumberfilter);
                    }
                    else {
                        if (item.min && item.max) filterPass = filterPass && (
                            !(parseInt(item.min, 10) <= newnumberfilter) || !(parseInt(item.max, 10) >= newnumberfilter))
                        else {
                            if (item.min) filterPass = filterPass && !(parseInt(item.min, 10) <= newnumberfilter);
                            if (item.max) filterPass = filterPass && !(parseInt(item.max, 10) >= newnumberfilter);
                        }
                    }
                }
                return filterPass;
            });
            return filterPass;
        }));
};


// Set Unique Sort list 
export const uniqueListSort = (field: string, sortsCopy: ItemsSorts[]) => {
    let sortSelected = false;
    sortsCopy.forEach(item => {
        if (item["sortfield"] === field) sortSelected = true
    });
    return sortSelected;
};


// Sorting button color style if selected
export const addColorButtonSorts = (prop: string, sorts: ItemsSorts[]) => {
    let colorbutton = '';
    sorts.forEach(item => {
        if (item.colorprop === prop) {
            colorbutton = prop;
        }
    });
    if (colorbutton === prop) { return { backgroundColor: '#11a3ab', color: '#dff7f7' } }
    else return
};


// Sorting button rank if selected
export const addRankButton = (prop: string, sorts: ItemsSorts[]) => {
    let rank = '';
    sorts.forEach(item => {
        if (item.colorprop === prop) {
            rank = item.id
        }
    });
    return rank;
};


export const getYear = (prop: string) => {
    if (prop) {
        const year = prop.split('-')[0];
        return year.toString();
    }
    else {
        const year = '';
        return year
    }
};


export const setYear = (item: string, eTargetValue: string) => {
    if (item) {
        const itemsplit = item.split('-');
        const month = itemsplit[1];
        const day = itemsplit[2];
        const newitem = eTargetValue.concat('-', month, '-', day)
        return newitem.toString();
    }
    else {
        return eTargetValue.concat('-...-...');;
    }
};


export const getMonth = (prop: string) => {
    if (prop) {
        const month = prop.split('-')[1];
        return month.toString();
    }
    else {
        const month = '';
        return month
    }
};


export const setMonth = (item: string, eTargetValue: string) => {
    if (item) {
        const itemsplit = item.split('-');
        const year = itemsplit[0];
        const day = itemsplit[2];
        const newitem = year.concat('-', eTargetValue, '-', day)
        return newitem.toString();
    }
    else {
        return ('...-').concat(eTargetValue, '-...');
    }
};


export const getDay = (prop: string) => {
    if (prop) {
        const day = prop.split('-')[2];
        return day.toString();
    }
    else {
        const day = '';
        return day
    }
};


export const setDay = (item: string, eTargetValue: string) => {
    if (item) {
        const itemsplit = item.split('-');
        const year = itemsplit[0];
        const month = itemsplit[1];
        const newitem = year.concat('-', month, '-', eTargetValue)
        return newitem.toString();
    }
    else {
        return ('...-...-').concat(eTargetValue);
    }
};


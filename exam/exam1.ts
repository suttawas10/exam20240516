const listA : number[]  = [1,2,3,5,6,8,9]
const listB : number[]  = [3,2,1,5,6,0]
let listDup : number[] = []

for(let i=0;i < listA.length;i++){
    for(let j=0;j < listB.length;j++){
        if(listA[i]==listB[j]){
            listDup.push(listA[i])
        }
    }
}
console.log(listDup)
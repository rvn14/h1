#include <stdio.h>
#include <stdlib.h>
#include <string.h>


//Sorting ----------------------------------


// Selection Sorting

void selectionSort(int arr[], int n) {
    int i, j, min, temp;
    for (i = 0; i < n - 1; i++) {
        min = i;
        for (j = i + 1; j < n; j++)
            if (arr[j] < arr[min])
                min = j;
        if (min != i) {
            temp = arr[i];
            arr[i] = arr[min];
            arr[min] = temp;
        }
    }
}


//bubble sorting

void bubbleSort(int arr[], int n) {
    int i, j, temp;
    for (i = 0; i < n - 1; i++)
        for (j = 0; j < n - i - 1; j++)
            if (arr[j] > arr[j + 1]) {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
}   


//INSERTION SORTING

void insertionSort(int arr[], int n) {
    int i, key, j;
    for (i = 1; i < n; i++) {
        key = arr[i];
        j = i - 1;
        while (j >= 0 && arr[j] > key) {
            arr[j + 1] = arr[j];
            j = j - 1;
        }
        arr[j + 1] = key;
    }
}


  


//Searching ----------------------------------

//LINEAR SEARCH

int linearSearch(int arr[], int n, int x) {
    for (int i = 0; i < n; i++)
        if (arr[i] == x)
            return i;
    return -1;
}



//BINARY SEARCH


int binarySearch(int arr[], int l, int r, int x) {
    if (r >= l) {
        int mid = (r + l) / 2;
        if (arr[mid] == x)
            return mid;
        if (arr[mid] > x)
            return binarySearch(arr, l, mid - 1, x);
        return binarySearch(arr, mid + 1, r, x);
    }
    return -1;
}


// Traverse ----------------------------------

//Preorder Traversal

void preorder(int arr[], int n, int i) {
    if (i >= n)
        return;
    printf("%d ", arr[i]);
    preorder(arr, n, 2 * i + 1);
    preorder(arr, n, 2 * i + 2);
}


//Inorder Traversal


void inorder(int arr[], int n, int i) {
    if (i >= n)
        return;
    inorder(arr, n, 2 * i + 1);
    printf("%d ", arr[i]);
    inorder(arr, n, 2 * i + 2);
}


//Postorder Traversal


void postorder(int arr[], int n, int i) {
    if (i >= n)
        return;
    postorder(arr, n, 2 * i + 1);
    postorder(arr, n, 2 * i + 2);
    printf("%d ", arr[i]);
}



//binary search tree ----------------------------------

struct node {
    int key;
    struct node *left, *right;
};

struct node *newNode(int item) {
    struct node *temp = (struct node *)malloc(sizeof(struct node));
    temp->key = item;
    temp->left = temp->right = NULL;
    return temp;
}

void inorderBST(struct node *root) {
    if (root != NULL) {
        inorderBST(root->left);
        printf("%d \n", root->key);
        inorderBST(root->right);
    }
}

struct node *insert(struct node *node, int key) {
    if (node == NULL) return newNode(key);
    if (key < node->key)
        node->left = insert(node->left, key);
    else if (key > node->key)
        node->right = insert(node->right, key);
    return node;
}

// Abstract Data Types --------------------

// queue ----------------------------------

#define MAX 100

typedef enum {false, true} bool;

typedef struct {
    int front, rear, count;
    int items[];
}Queue;

void createQueue(Queue *q){
    q->front = 0;
    q->rear = -1;
    q->count = 0;
}

int isQueuefull(Queue *q){
    if (q->rear == MAX - 1)
    {
        return true;
    }else
        return false;
}


int isQueueEmpty(Queue *q){
    if (q->rear < q-> front)
    {
        return true;
    }else{
        return false;
    }
}

void append(Queue *q, int x){
    if (isQueuefull)
    {
        printf("queue full");
    }else{
        q->items[++q->rear] = x;
        q->count++;
    }
};

void serve(Queue *q, int *x){
    if (isQueueEmpty)
    {
        printf("Queue is empty");
    }else
        *x = q->items[q->front++];
        q->count--;
};

//stack ----------------------------------

typedef struct
{
    int top;
    int items[MAX];
}Stack;

void createStack(Stack* s) {
    s->top = -1;
}

int isFull(Stack* s) {
    return s->top == MAX -1; 
}

int isEmpty(Stack* s) {
    return s->top == -1;
}

void push(int x, Stack *s){
    if (isFull(s))
    {
        printf("Stack is full");
    }else{
        s->items[++(s->top)] = x;
    }
    
};

int pop(Stack *s){
    if (isEmpty)
    {
        printf("Stack is Empty");
    }else{
        int x = s->items[s->top--];
        return x;
    }
};


//-------------------------------------------------

typedef struct
{
    int item;
    Node *next;
}Node;


typedef struct 
{
    Node *top;
    bool isfull;
    int no_ele;

}StackLinked;

void createStack(StackLinked *s){
    s->top = NULL;
    s->isfull = false;
    s->no_ele = 0;
};

void linkedpush(StackLinked *s, int x){
    Node *np;
    np = (Node*)malloc(sizeof(Node));
    if (np == NULL)
    {
        printf("Failed");
    }else
    {
        np->item = x;
        np->next = s->top;
        s->top = np;
        s->no_ele++;     
    }
    
};

void linkedpop(StackLinked *s, int *item){
    Node *np;
    *item = np->item;
    np = s->top;
    s->top = s->top->next;
    s->no_ele--;
    free(np);
};


// lists ----------------------------------


typedef struct pp1
{
    int count;
    int items[MAX];
}List;


void createList(List *l){
    l->count = 0;
}

int isListFull(List *l){
    if (l->count == MAX)
    {
        return 1;
    }else{
        return 0;
    }
}

int isListEmpty(List *l){
    if (l->count == 0)
    {
        return 1;
    }else{
        return 0;
    }
}

void append(List *l, int x){
    if (isListFull(l))
    {
        printf("List is full");
    }
    else{
        l->items[++l->count] = x;

    }
}

void serve(List *l, int *x){
    if (isListEmpty(l))
    {
        printf("List is empty");
    }else{
        *x = l->items[l->count--];
    }
}

int main(int argc, char const *argv[])
{
    List l;
    createList(&l);
    append(&l, 5);
    append(&l, 6);
    append(&l, 7);
    int x;
    serve(&l, &x);
    printf("%d", x);
    return 0;
}






int main(int argc, char const *argv[])
{
    int arr[] = {12, 11, 13, 5, 6, 7};

    int res = binarySearch(arr, 0, 5, 13);
    printf("Binary Search: %d\n", res);
    return 0;
}


//stack ----------------------------------

#define MAX 1000

struct Stack {
    int top;
    int items[MAX];
};


void push(struct Stack *ps, int x) {
    if (ps->top == (MAX - 1)) {
        printf("Stack is full");
    } else {
        ps->items[++(ps->top)] = x;
    }
}


int pop(struct Stack *ps) {
    if (ps->top == -1) {
        printf("Stack is empty");
        return -1;
    } else {
        int x = ps->items[ps->top];
        ps->top = ps->top - 1;
        return x;
    }
}

int peek(struct Stack *ps) {
    if (ps->top == -1) {
        printf("Stack is empty");
        return -1;
    } else {
        return ps->items[ps->top];
    }
}

int isEmpty(struct Stack *ps) {
    return ps->top == -1;
    
}


//stackLinked----------------------------
typedef enum {false, true} bool;

typedef struct
{
    int item;
    Node *next;
}Node;


typedef struct 
{
    Node *top;
    bool isfull;
    int no_ele;

}StackLinked;

void createStack(StackLinked *s){
    s->top = NULL;
    s->isfull = false;
    s->no_ele = 0;
};

void linkedpush(StackLinked *s, int x){
    Node *np;
    np = (Node*)malloc(sizeof(Node));
    if (np == NULL)
    {
        printf("Failed");
    }else
    {
        np->item = x;
        np->next = s->top;
        s->top = np;
        s->no_ele++;     
    }
    
};

void linkedpop(StackLinked *s, int *item){
    Node *np;
    *item = np->item;
    np = s->top;
    s->top = s->top->next;
    s->no_ele--;
    free(np);
};




//-LIST----------------------------------

typedef struct pp1
{
    int count;
    int items[MAX];
}List;


void createList(List *l){
    l->count = 0;
}

int isListFull(List *l){
    if (l->count == MAX)
    {
        return 1;
    }else{
        return 0;
    }
}

int isListEmpty(List *l){
    if (l->count == 0)
    {
        return 1;
    }else{
        return 0;
    }
}

void append(List *l, int x){
    if (isListFull(l))
    {
        printf("List is full");
    }
    else{
        l->items[++l->count] = x;

    }
}

void posappend(List *l, int x, int pos){
    if (isListFull(l))
    {
        printf("List is full");
    }
    else{
        for (int i = l->count; i >= pos; i--)
        {
            l->items[i + 1] = l->items[i];
        }
        l->items[pos] = x;
        l->count++;
    }
}

void posserve(List *l, int *x, int pos){
    if (isListEmpty(l))
    {
        printf("List is empty");
    }else{
        *x = l->items[pos];
        for (int i = pos; i < l->count; i++)
        {
            l->items[i] = l->items[i + 1];
        }
        l->count--;
    }
}

void serve(List *l, int *x){
    if (isListEmpty(l))
    {
        printf("List is empty");
    }else{
        *x = l->items[l->count--];
    }
}

int main(int argc, char const *argv[])
{
    List l;
    createList(&l);
    append(&l, 5);
    append(&l, 6);
    append(&l, 7);
    int x;
    serve(&l, &x);
    printf("%d", x);
    return 0;
}


//-----------------------------------------------------

void bubblesort(List *l){
    for (int i = 0; i < l->count; i++)
    {
        for (int j = 0; j < l->count - 1; j++)
        {
            if (l->items[j] > l->items[j + 1])
            {
                float temp = l->items[j];
                l->items[j] = l->items[j + 1];
                l->items[j + 1] = temp;
            }
            
        }
        
    }
}

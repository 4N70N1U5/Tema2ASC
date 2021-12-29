#include <iostream>

using namespace std;

int n, m, a[91], b[91], c[31], pos = 0, afis = 0;

bool solutie(int k) {
    return k == n * 3;
}

bool ok(int k) {
    //return c[a[k]] < 3 && (d[a[k]] >= m || c[a[k]] == 0);
    int i = k - 1, d = 0;
    while (i >= 1 && a[k] != a[i])
    {
        d++;
        i--;
    }
    return c[a[k]] < 3 && (d >= m || i == 0);
}

void afisare() {
    //afis = pos = 1;
    pos = 1; afis++;
    for (int i = 1; i <= n * 3; i++)
        cout << a[i] << " ";
    cout << endl;
}

void back(int k) {
    if (!afis) {
        if (b[k]) {
            a[k] = b[k];
            c[a[k]]--;
            bool ver = ok(k);
            c[a[k]]++;
            if (ver) {
                /*for (int j = 1; j <= n; j++)
                    d[j]++;
                d[a[k]] = 0;*/
                if (solutie(k)) {
                    afisare();
                }
                else {
                    //c[a[k]]++;
                    back(k + 1);
                    //c[a[k]]--;
                }
            }
        }
        else {
            for (int i = 1; i <= n; i++) {
                a[k] = i;
                if (ok(k)) {
                    if (solutie(k)) {
                        afisare();
                    }
                    else {
                        /*for (int j = 1; j <= n; j++)
                            d[j]++;
                        int bck = d[i];
                        d[i] = 0;*/
                        c[i]++;
                        back(k + 1);
                        c[i]--;
                        /*for (int j = 1; j <= n; j++)
                            d[j]--;
                        d[i] = bck;*/
                    }
                }
            }
        }
    }
}

int main() {
    cin >> n >> m;
    /*for (int i = 1; i <= n; i++)
    {
        d[i] = m;
    }*/
    for (int i = 1; i <= n * 3; i++) {
        cin >> b[i];
        if (b[i])
            c[b[i]]++;
    }
    back(1);
    if (!pos)
        cout << -1;
    return 0;
}


/// trebuie sa stiu dinainte de cate ori apar valorile de la punctele fixate pt a nu mi consuma prea devreme
/// aparitiile unui anumit numar! exemplu: 1 2 1 2 1 2 3 4 3 4 3 5 5 4 5
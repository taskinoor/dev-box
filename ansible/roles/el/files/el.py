#!/usr/bin/env python

from datetime import date
from dateutil import relativedelta


def main():
    d1 = date(2013, 10, 12)
    d2 = date.today()
    d = relativedelta.relativedelta(d2, d1)

    print ''
    print 'EL:', d.years, d.months, d.days
    print ''


if __name__ == '__main__':
    main()

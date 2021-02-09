Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC2F3155CA
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 19:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhBISXJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 13:23:09 -0500
Received: from smtp-18.italiaonline.it ([213.209.10.18]:51014 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233149AbhBISTb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 13:19:31 -0500
Received: from venice.bhome ([84.220.127.28])
        by smtp-18.iol.local with ESMTPA
        id 9XVWlzPY1Xeai9XVWloEiy; Tue, 09 Feb 2021 19:13:02 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1612894382; bh=7Sx8F9IAP9BajunUSdk2amCo1bPV5ZhOgvkH1ciSCkA=;
        h=From;
        b=LCpBcpKsJzdosC0tn3J6Es8Zo2RNVIooear5/uaBgxlEojDn+nSpr+gi9fXtJd+FT
         itvy9UTjBJf4zg6DJbBkJSh/NiNtaGIH043wG+3EbVdDSz7I2n59lc1OXv6rD/njvE
         akL8DmMaemEAYEXxu5aMfmjkDXM74sOGFVMZKSCwZcWjVwwiyJoWs7c1AJlAkKLvJT
         YO7eP7dNDZyWfKCG28lJBj+kSGYUqWARUqOvQeO7ayOv75+4yYOJnUUb9XsC5kBQ9H
         fUaEuqapcVCjZVc3AZQw1rZWuRgtKVMzYeq2f6LTYwaxbNUvPPcSW+Cv9nhDlf8WsM
         0dc2NElC9Jn0Q==
X-CNFS-Analysis: v=2.4 cv=fb5od2cF c=1 sm=1 tr=0 ts=6022d0ae cx=a_exe
 a=SUIjhvt/dGIB6E4Cd4GQUg==:117 a=SUIjhvt/dGIB6E4Cd4GQUg==:17
 a=IkcTkHD0fZMA:10 a=fGO4tVQLAAAA:8 a=GGiZyqZrzHsT86AyG7IA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: is BTRFS_IOC_DEFRAG behavior optimal?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSx=HcCRMiE0eganPWJVTB+b4zfb_mnd68L2VapGGKi7Q@mail.gmail.com>
 <3897f126-e977-d842-f91d-b48b74958f3d@libero.it>
 <CAJCQCtScUYMoMpw==HTbBB6s0BFnXuT=MvSuVJYEVBrA7-RbHA@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <839d9baa-8df5-7efd-94ee-b28f282ef9ec@inwind.it>
Date:   Tue, 9 Feb 2021 19:13:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtScUYMoMpw==HTbBB6s0BFnXuT=MvSuVJYEVBrA7-RbHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfO8+AYJH1k4IWptkVILqrl300OuuVh4mBdITg3iQeNLgR0f4JX10R7JnzwAF9Xae4O6YHYp/WKhISUWLVaxIv7BnEPHMzmrflnZPD0RUknC0BcpJB9ga
 heA3MYvJfr8uREuOj6JYkiTX2XaA58GN3U5Ut7lHRpOuIbMLFA+AvM1nox1I0qIPI+9GtRus7/NQ0WF71Rnvy2CZQc7Uyp2WJn9aBSkWiT8hq2L2tLlSytZp
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/9/21 1:42 AM, Chris Murphy wrote:
> Perhaps. Attach strace to journald before --rotate, and then --rotate
> 
> https://pastebin.com/UGihfCG9

I looked to this strace.

in line 115: it is called a ioctl(<BTRFS-DEFRAG>)
in line 123: it is called a ioctl(<BTRFS-DEFRAG>)

However the two descriptors for which the defrag is invoked are never sync-ed before.

I was expecting is to see a sync (flush the data on the platters) and then a
ioctl(<BTRFS-defrag>. This doesn't seems to be looking from the strace.

I wrote a script (see below) which basically:
- create a fragmented file
- run filefrag on it
- optionally sync the file             <-----
- run btrfs fi defrag on it
- run filefrag on it

If I don't perform the sync, the defrag is ineffective. But if I sync the
file BEFORE doing the defrag, I got only one extent.
Now my hypothesis is: the journal log files are bad de-fragmented because these
are not sync-ed before.
This could be tested quite easily putting an fsync() before the
ioctl(<BTRFS_DEFRAG>).

Any thought ?

Regards
Goffredo

-----

$ cat test.py

import os, time, sys

def create_file(nf):
     """
         Create a fragmented file
     """

     # the data below are from a real case
     data= [(0, 0), (1, 1599), (1600, 1607), (1608, 1689), (1690, 1690),
     (1691, 1693), (1694, 1694), (1695, 1722), (1723, 1723), (1724, 1955),
     (1956, 1956), (1957, 2047), (2048, 2417), (2418, 2420), (2421, 2478),
     (2479, 2479), (2480, 2482), (2483, 2483), (2484, 2523), (2524, 2527),
     (2528, 2598), (2599, 2599), (2600, 2607), (2608, 2608), (2609, 2611),
     (2612, 2612), (2613, 2615), (2616, 2616), (2617, 2691), (2692, 2696)]

     blocksize=4096

     f = os.open(fn, os.O_RDWR+os.O_TRUNC+os.O_CREAT)
     os.close(f)
     ldata = len(data)
     i = 1
     f = os.open(fn, os.O_RDWR)
     while i < ldata:
         (from_, to_) = data[ldata - i -1]
         l = (to_ - from_  + 1) * blocksize
         pos = from_ * blocksize

         os.lseek(f, pos, os.SEEK_SET)

         os.write(f, b"X"*l)
         i += 2
     os.fsync(f)
     os.fsync(f)
     os.close(f)
     os.system("sync")
     os.system("sync")
     print("sleep 5s")
     #time.sleep(5)
     os.system("sync")
     os.system("sync")

     i = 0
     f = os.open(fn, os.O_RDWR)
     while i < ldata:
         (from_, to_) = data[ldata - i -1]
         l = (to_ - from_  + 1) * blocksize
         pos = from_ * blocksize

         os.lseek(f, pos, os.SEEK_SET)

         os.write(f, b"X"*l)
         i += 2

     os.close(f)

def test_without_sync(fn):
     create_file(fn)

     print("\nCreated fragmented file")
     os.system("sudo filefrag -v "+fn)
     print("\nStart defrag without sync\n", end="")
     os.system("btrfs fi defra "+fn)
     print("End defrag")
     os.system("sync")
     os.system("sync")
     print("End sync")
     os.system("sudo filefrag -v "+fn)

def test_with_sync(fn):
     create_file(fn)

     print("\nCreated fragmented file")
     os.system("sync")
     os.system("sync")
     os.system("sudo filefrag -v "+fn)
     print("\nStart defrag with sync\n", end="")
     os.system("btrfs fi defra "+fn)
     print("End defrag")
     os.system("sync")
     os.system("sync")
     print("End sync")
     os.system("sudo filefrag -v "+fn)





fn = sys.argv[1]
assert(len(fn))
os.system("sudo true") # to start sudo
test_without_sync(fn)
test_with_sync(fn)

-----

$ python3 test.py /mnt/btrfs-raid1/home/ghigo/data.txt
sleep 5s

Created fragmented file
Filesystem type is: 9123683e
File size of /mnt/btrfs-raid1/home/ghigo/data.txt is 11046912 (2697 blocks of 4096 bytes)
  ext:     logical_offset:        physical_offset: length:   expected: flags:
    0:        0..       0:    1596416..   1596416:      1:
    1:        1..    1599:          0..      1598:   1599:    1596417: unknown_loc,delalloc
    2:     1600..    1607:    1597465..   1597472:      8:       1599:
    3:     1608..    1689:          0..        81:     82:    1597473: unknown_loc,delalloc
    4:     1690..    1690:    1596854..   1596854:      1:         82:
    5:     1691..    1693:          0..         2:      3:    1596855: unknown_loc,delalloc
    6:     1694..    1694:    1596858..   1596858:      1:          3:
    7:     1695..    1722:          0..        27:     28:    1596859: unknown_loc,delalloc
    8:     1723..    1723:    1596863..   1596863:      1:         28:
    9:     1724..    1955:          0..       231:    232:    1596864: unknown_loc,delalloc
   10:     1956..    1956:    1596864..   1596864:      1:        232:
   11:     1957..    2047:          0..        90:     91:    1596865: unknown_loc,delalloc
   12:     2048..    2417:    1648394..   1648763:    370:         91:
   13:     2418..    2420:          0..         2:      3:    1648764: unknown_loc,delalloc
   14:     2421..    2478:    1600795..   1600852:     58:          3:
   15:     2479..    2479:          0..         0:      1:    1600853: unknown_loc,delalloc
   16:     2480..    2482:    1597473..   1597475:      3:          1:
   17:     2483..    2483:          0..         0:      1:    1597476: unknown_loc,delalloc
   18:     2484..    2523:    1600927..   1600966:     40:          1:
   19:     2524..    2527:          0..         3:      4:    1600967: unknown_loc,delalloc
   20:     2528..    2598:    1624667..   1624737:     71:          4:
   21:     2599..    2599:          0..         0:      1:    1624738: unknown_loc,delalloc
   22:     2600..    2607:    1597476..   1597483:      8:          1:
   23:     2608..    2608:          0..         0:      1:    1597484: unknown_loc,delalloc
   24:     2609..    2611:    1599231..   1599233:      3:          1:
   25:     2612..    2612:          0..         0:      1:    1599234: unknown_loc,delalloc
   26:     2613..    2615:    1599234..   1599236:      3:          1:
   27:     2616..    2616:          0..         0:      1:    1599237: unknown_loc,delalloc
   28:     2617..    2691:    1624738..   1624812:     75:          1:
   29:     2692..    2696:          0..         4:      5:    1624813: last,unknown_loc,delalloc,eof
/mnt/btrfs-raid1/home/ghigo/data.txt: 30 extents found

Start defrag without sync
End defrag
End sync
Filesystem type is: 9123683e
File size of /mnt/btrfs-raid1/home/ghigo/data.txt is 11046912 (2697 blocks of 4096 bytes)
  ext:     logical_offset:        physical_offset: length:   expected: flags:
    0:        0..       0:    1596416..   1596416:      1:
    1:        1..    1599:  163433285.. 163434883:   1599:    1596417:
    2:     1600..    1607:    1597465..   1597472:      8:  163434884:
    3:     1608..    1689:    1604137..   1604218:     82:    1597473:
    4:     1690..    1690:    1596854..   1596854:      1:    1604219:
    5:     1691..    1693:    1599237..   1599239:      3:    1596855:
    6:     1694..    1694:    1596858..   1596858:      1:    1599240:
    7:     1695..    1722:    1599557..   1599584:     28:    1596859:
    8:     1723..    1723:    1596863..   1596863:      1:    1599585:
    9:     1724..    1955:    1651669..   1651900:    232:    1596864:
   10:     1956..    1956:    1596864..   1596864:      1:    1651901:
   11:     1957..    2047:    1850859..   1850949:     91:    1596865:
   12:     2048..    2417:    1648394..   1648763:    370:    1850950:
   13:     2418..    2420:    1599240..   1599242:      3:    1648764:
   14:     2421..    2478:    1600795..   1600852:     58:    1599243:
   15:     2479..    2479:    1596981..   1596981:      1:    1600853:
   16:     2480..    2482:    1597473..   1597475:      3:    1596982:
   17:     2483..    2483:    1597038..   1597038:      1:    1597476:
   18:     2484..    2523:    1600927..   1600966:     40:    1597039:
   19:     2524..    2527:    1599290..   1599293:      4:    1600967:
   20:     2528..    2598:    1624667..   1624737:     71:    1599294:
   21:     2599..    2599:    1597045..   1597045:      1:    1624738:
   22:     2600..    2607:    1597476..   1597483:      8:    1597046:
   23:     2608..    2608:    1597056..   1597056:      1:    1597484:
   24:     2609..    2611:    1599231..   1599233:      3:    1597057:
   25:     2612..    2612:    1597059..   1597059:      1:    1599234:
   26:     2613..    2615:    1599234..   1599236:      3:    1597060:
   27:     2616..    2616:    1597100..   1597100:      1:    1599237:
   28:     2617..    2691:    1624738..   1624812:     75:    1597101:
   29:     2692..    2696:    1599294..   1599298:      5:    1624813: last,eof
/mnt/btrfs-raid1/home/ghigo/data.txt: 30 extents found
sleep 5s

Created fragmented file
Filesystem type is: 9123683e
File size of /mnt/btrfs-raid1/home/ghigo/data.txt is 11046912 (2697 blocks of 4096 bytes)
  ext:     logical_offset:        physical_offset: length:   expected: flags:
    0:        0..       0:    1597109..   1597109:      1:
    1:        1..    1599:          0..      1598:   1599:    1597110: unknown_loc,delalloc
    2:     1600..    1607:    1599299..   1599306:      8:       1599:
    3:     1608..    1689:          0..        81:     82:    1599307: unknown_loc,delalloc
    4:     1690..    1690:    1597124..   1597124:      1:         82:
    5:     1691..    1693:          0..         2:      3:    1597125: unknown_loc,delalloc
    6:     1694..    1694:    1597129..   1597129:      1:          3:
    7:     1695..    1722:          0..        27:     28:    1597130: unknown_loc,delalloc
    8:     1723..    1723:    1597134..   1597134:      1:         28:
    9:     1724..    1955:          0..       231:    232:    1597135: unknown_loc,delalloc
   10:     1956..    1956:    1597137..   1597137:      1:        232:
   11:     1957..    2047:          0..        90:     91:    1597138: unknown_loc,delalloc
   12:     2048..    2417:   88373891..  88374260:    370:         91:
   13:     2418..    2420:          0..         2:      3:   88374261: unknown_loc,delalloc
   14:     2421..    2478:    1600987..   1601044:     58:          3:
   15:     2479..    2479:          0..         0:      1:    1601045: unknown_loc,delalloc
   16:     2480..    2482:    1599585..   1599587:      3:          1:
   17:     2483..    2483:          0..         0:      1:    1599588: unknown_loc,delalloc
   18:     2484..    2523:    1601650..   1601689:     40:          1:
   19:     2524..    2527:          0..         3:      4:    1601690: unknown_loc,delalloc
   20:     2528..    2598:    1625881..   1625951:     71:          4:
   21:     2599..    2599:          0..         0:      1:    1625952: unknown_loc,delalloc
   22:     2600..    2607:    1600717..   1600724:      8:          1:
   23:     2608..    2608:          0..         0:      1:    1600725: unknown_loc,delalloc
   24:     2609..    2611:    1599692..   1599694:      3:          1:
   25:     2612..    2612:          0..         0:      1:    1599695: unknown_loc,delalloc
   26:     2613..    2615:    1599821..   1599823:      3:          1:
   27:     2616..    2616:          0..         0:      1:    1599824: unknown_loc,delalloc
   28:     2617..    2691:    1629466..   1629540:     75:          1:
   29:     2692..    2696:          0..         4:      5:    1629541: last,unknown_loc,delalloc,eof
/mnt/btrfs-raid1/home/ghigo/data.txt: 30 extents found

Start defrag with sync
End defrag
End sync
Filesystem type is: 9123683e
File size of /mnt/btrfs-raid1/home/ghigo/data.txt is 11046912 (2697 blocks of 4096 bytes)
  ext:     logical_offset:        physical_offset: length:   expected: flags:
    0:        0..    2696:  163503187.. 163505883:   2697:             last,eof
/mnt/btrfs-raid1/home/ghigo/data.txt: 1 extent found



----

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

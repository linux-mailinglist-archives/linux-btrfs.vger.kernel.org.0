Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46ABD315744
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Feb 2021 21:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhBITzG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Feb 2021 14:55:06 -0500
Received: from smtp-36.italiaonline.it ([213.209.10.36]:60926 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233534AbhBITp5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Feb 2021 14:45:57 -0500
Received: from venice.bhome ([78.12.10.35])
        by smtp-36.iol.local with ESMTPA
        id 9YwalCR6IQTiR9YwalI0wT; Tue, 09 Feb 2021 20:45:05 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1612899905; bh=44He0HtCnQ5aKQ0gqeEUSOrrBCv0eNUM3TSODr0J2yE=;
        h=From;
        b=lh+ycKfmj+EhGj3SXtrEzAfIdZb8S8BtZZH1ApGNt1SV39Q3D2NTDyf40TxBzc7Lh
         pD5GHFYWidytZZ1jeAUI2D4SyNxRt8K/2h900rBgbjexJbQLjtRyJqUPo9KoHibVaO
         1thjH3rPLZA24J3pVSO+XzXmUjOg+AnFBlhWRx9HiI/kizJPsnKCNw3waT+IX4gAsE
         k3TonE1A1b8AYzB6viVY2FtWiyBIdvHiWFJ+AsWgSfmX/UZYeDAh2Tlpa+wtgfcei3
         Xo5dyEBEjPauNuFYATIEVOM1TNkufz0J7W1FklXHgRp9c5vBnZkMjXlkW7u1JGL7fF
         nJDMnTg4FbgVA==
X-CNFS-Analysis: v=2.4 cv=TeVTCTch c=1 sm=1 tr=0 ts=6022e641 cx=a_exe
 a=6WEAkDuu1msTEfj6gKuMOg==:117 a=6WEAkDuu1msTEfj6gKuMOg==:17
 a=IkcTkHD0fZMA:10 a=fGO4tVQLAAAA:8 a=xK28olTTglL5eUA3GRUA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: is BTRFS_IOC_DEFRAG behavior optimal?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJCQCtSx=HcCRMiE0eganPWJVTB+b4zfb_mnd68L2VapGGKi7Q@mail.gmail.com>
 <3897f126-e977-d842-f91d-b48b74958f3d@libero.it>
 <CAJCQCtScUYMoMpw==HTbBB6s0BFnXuT=MvSuVJYEVBrA7-RbHA@mail.gmail.com>
 <839d9baa-8df5-7efd-94ee-b28f282ef9ec@inwind.it>
 <CAJCQCtSqESuYawuh6E8b6Xd=z4D13J2=v-6rn8+0mwuThXNtkg@mail.gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <7650c455-297a-f746-c59e-3104fdbf8896@inwind.it>
Date:   Tue, 9 Feb 2021 20:45:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSqESuYawuh6E8b6Xd=z4D13J2=v-6rn8+0mwuThXNtkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGjV3J8+LyRhPGvQp0Ah6phc5F1s/VZ4aC73LSic4leS6kGBjDDexRISk3zViijNa+4fs9To5y80Av+1AgieKiGtfaSlMC1JpXbYQMP4ZtNJuODxJCSd
 +A14zC7YMa7LKealqxloAOoudN1dTUKdk8l67KZMe37BCwsJaS6Kvj13ee4bmArETzIPAnQm2cbsOfh8DMoOvvYGU9izcrRh1KVCLIPuqS4ZCERs3kCfR3JS
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/9/21 8:01 PM, Chris Murphy wrote:
> On Tue, Feb 9, 2021 at 11:13 AM Goffredo Baroncelli <kreijack@inwind.it> wrote:
>>
>> On 2/9/21 1:42 AM, Chris Murphy wrote:
>>> Perhaps. Attach strace to journald before --rotate, and then --rotate
>>>
>>> https://pastebin.com/UGihfCG9
>>
>> I looked to this strace.
>>
>> in line 115: it is called a ioctl(<BTRFS-DEFRAG>)
>> in line 123: it is called a ioctl(<BTRFS-DEFRAG>)
>>
>> However the two descriptors for which the defrag is invoked are never sync-ed before.
>>
>> I was expecting is to see a sync (flush the data on the platters) and then a
>> ioctl(<BTRFS-defrag>. This doesn't seems to be looking from the strace.
>>
>> I wrote a script (see below) which basically:
>> - create a fragmented file
>> - run filefrag on it
>> - optionally sync the file             <-----
>> - run btrfs fi defrag on it
>> - run filefrag on it
>>
>> If I don't perform the sync, the defrag is ineffective. But if I sync the
>> file BEFORE doing the defrag, I got only one extent.
>> Now my hypothesis is: the journal log files are bad de-fragmented because these
>> are not sync-ed before.
>> This could be tested quite easily putting an fsync() before the
>> ioctl(<BTRFS_DEFRAG>).
>>
>> Any thought ?
> 
> No idea. If it's a full sync then it could be expensive on either
> slower devices or heavier workloads. On the one hand, there's no point
> of doing an ineffective defrag so maybe the defrag ioctl should  just
> do the sync first? On the other hand, this would effectively make the
> defrag ioctl a full file system sync which might be unexpected. It's a
> set of tradeoffs and I don't know what the expectation is.
> 
> What about fdatasync() on the journal file rather than a full sync?

I tried a fsync(2) call, and the results is the same.
Only after reading your reply I realized that I used a sync(2), when
I meant to use fsync(2).

I update my python test code
----
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

     # write the odd extents...

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

     # ... sync and then write the even extents
     os.fsync(f)
     os.close(f)

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

def fsync(nf):
     f = os.open(nf, os.O_RDWR)
     os.fsync(f)
     os.close(f)

def test_without_sync(fn):
     create_file(fn)

     print("\nCreated fragmented file")
     os.system("sudo filefrag -v "+fn)
     print("\nStart defrag without sync\n", end="")
     os.system("btrfs fi defra "+fn)
     print("End defrag")
     fsync(fn)
     print("End sync")
     os.system("sudo filefrag -v "+fn)

def test_with_sync(fn):
     create_file(fn)

     print("\nCreated fragmented file")
     fsync(fn)
     os.system("sudo filefrag -v "+fn)
     print("\nStart defrag with sync\n", end="")
     os.system("btrfs fi defra "+fn)
     print("End defrag")
     fsync(fn)
     print("End sync")
     os.system("sudo filefrag -v "+fn)





fn = sys.argv[1]
assert(len(fn))
os.system("sudo true") # to start sudo
test_without_sync(fn)
test_with_sync(fn)
----

> 
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

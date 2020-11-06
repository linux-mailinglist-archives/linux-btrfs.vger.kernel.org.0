Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9152A945F
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 11:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgKFKab (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 05:30:31 -0500
Received: from smtp.radex.nl ([178.250.146.7]:59232 "EHLO radex-web.radex.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgKFKaa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 05:30:30 -0500
Received: from [192.168.1.158] (cust-178-250-146-69.breedbanddelft.nl [178.250.146.69])
        by radex-web.radex.nl (Postfix) with ESMTPS id 8D62D2406A;
        Fri,  6 Nov 2020 11:30:20 +0100 (CET)
Subject: Re: Fwd: Read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN1+AQR-irSbaH8f7HGj=rDN4+uUCyqjvtezGewQkQoDpg@mail.gmail.com>
 <5346c4af-c73e-84b3-ec4f-8f169c0a732a@gmx.com>
 <CAJheHN0NmgVoGF+AsnUNQkQnEJ46JCmpg4o5nwAkqi+VoGMjfw@mail.gmail.com>
 <e04680b4-f4c0-254f-24ba-f2053e4ad8b3@gmx.com>
 <CAJheHN0THhKcqKY3cGtJqUGaub=E0tuCmi6wuNeCGBxyAHmecQ@mail.gmail.com>
 <e2c8eaaf-6adb-374f-4005-a1edcbcb8f79@gmx.com>
 <CAJheHN1U4j1KsD96oFuCVwP+6RVP6V6oAZP-aGOTtfm7tDL3BA@mail.gmail.com>
 <CAJheHN3pTj-6dOQZVKqA_r38F+WVNrjVO6-Z_hFeq96uTNK5zw@mail.gmail.com>
 <1f26ff53-f7c7-c497-b69f-8a3e5d8ce959@gmx.com>
 <b7383762-4a86-fdb9-12f3-89470808f4e6@gmail.com>
 <0d6a0602-897a-b170-f1a2-007cff1f23fb@gmx.com>
 <134e61b5-ecf7-bc1a-e16b-c95b14876e6e@gmail.com>
 <5b757c2b-6dbf-cbec-6c66-e4b14897f53c@gmx.com>
 <838490cf-fc40-0008-88bb-eeede1e8d873@gmail.com>
 <50e0ef4d-061e-d02d-9dbf-61f83dfa7b3e@suse.com>
 <117797ff-c28b-c755-da17-fb7ce3169f0f@gmail.com>
 <51578ec7-f2e5-a09a-520e-f0577300d5ce@gmx.com>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <ca811ad9-5ae4-602e-98a4-5d4d6c860a1c@gmail.com>
Date:   Fri, 6 Nov 2020 11:30:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <51578ec7-f2e5-a09a-520e-f0577300d5ce@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi

Op 06-11-2020 om 11:24 schreef Qu Wenruo:
>
> On 2020/11/6 下午6:09, Ferry Toth wrote:
>> Hi Qu
>>
>> Op 06-11-2020 om 00:40 schreef Qu Wenruo:
>>> On 2020/11/6 上午7:37, Ferry Toth wrote:
>>>> Hi
>>>>
>>>> Op 06-11-2020 om 00:32 schreef Qu Wenruo:
>>>>> On 2020/11/6 上午7:12, Ferry Toth wrote:
>>>>>> Hi,
>>>>>>
>>>>>> Op 06-11-2020 om 00:00 schreef Qu Wenruo:
>>>>>>> On 2020/11/6 上午4:08, Ferry Toth wrote:
>>>>>>>> I am in a similar spot, during updating my distro (Kubuntu), I am
>>>>>>>> unable
>>>>>>>> to update a certain package. I know which file it is:
>>>>>>>>
>>>>>>>> ~$ ls -l /usr/share/doc/libatk1.0-data
>>>>>>>> ls: kan geen toegang krijgen tot '/usr/share/doc/libatk1.0-data':
>>>>>>>> Invoer-/uitvoerfout
>>>>>>>>
>>>>>>>> This creates the following in journal:
>>>>>>>>
>>>>>>>> kernel: BTRFS critical (device sda2): corrupt leaf: root=294
>>>>>>>> block=1169152675840 slot=1 ino=915987, invalid inode generation: has
>>>>>>>> 18446744073709551492 expect [0, 5851353]
>>>>>>>> kernel: BTRFS error (device sda2): block=1169152675840 read time
>>>>>>>> tree
>>>>>>>> block corruption detected
>>>>>>>>
>>>>>>>> Now, the problem: this file is on my rootfs, which is mounted. apt
>>>>>>>> (distribution updated) installed all packages but can't continue
>>>>>>>> configuring, because libatk is a dependancy. I can't delete the file
>>>>>>>> because of the I/O error. And btrfs check complains (I tried
>>>>>>>> running RO)
>>>>>>>> because the file system is mounted.
>>>>>>>>
>>>>>>>> But, on the sunny side, the file system is not RO.
>>>>>>>>
>>>>>>>> Is there any way to forcefully remove the file? Or do you have a
>>>>>>>> recommendation how to proceed?
>>>>>>> Newer kernel will reject to even read the item, thus will not be
>>>>>>> able to
>>>>>>> remove it.
>>>>>> That's already the case. (input / output error)
>>>>>>> I guess you have to use some distro ISO to fix the fs.
>>>>>> And then? btrfs check --repair the disk offline?
>>>>> Yep.
>>>>>
>>>>> You would want the latest btrfs-progs though.
>>>> Groovy has 5.7. Would that be good enough? Otherwise will be difficult
>>>> to build on/for live usb image.
>>> For your particular case, the fix are already in btrfs-progs v5.4.
>>>
>>> Although newer is always better, just in case you have extent item
>>> generation corruption, you may want v5.4.1.
>>>
>>> So your v5.7 should be good enough.
>>>
>>> Thanks,
>>> Qu
>> I made a live usb and performed:
>>
>> btrfs check --repair /dev/sda2
>>
>> It found errors and fixed them. However, it did not fix the corrupt
>> leaf. The file is actually a directory:
>>
>> ~$ stat /usr/share/doc/libatk1.0-data
>> stat: cannot statx '/usr/share/doc/libatk1.0-data': Invoer-/uitvoerfout
>>
>> in journal:
>>
>> BTRFS critical (device sda2): corrupt leaf: root=294 block=1169152675840
>> slot=1 ino=915987, invalid inode generation: has 18446744073709551492
>> expect [0, 5852829]
>> BTRFS error (device sda2): block=1169152675840 read time tree block
>> corruption detected
>>
>> So how do I repair this? Am I doing something wrong?
> Please provide the following dump:
> btrfs ins dump-tree -b 1169152675840 /dev/sda2
>
> Feel free to remove the filenames in the dump.
sudo btrfs ins dump-tree -b 1169152675840 /dev/sda2
btrfs-progs v5.3-rc1
leaf 1169152675840 items 36 free space 966 generation 5431733 owner 294
leaf 1169152675840 flags 0x1(WRITTEN) backref revision 1
fs uuid 27155120-9ef8-47fb-b248-eaac2b7c8375
chunk uuid 5704f1ba-08fd-4f6b-9117-0e080b4e9ef0
         item 0 key (915986 DIR_INDEX 2) itemoff 3957 itemsize 38
                 location key (915987 INODE_ITEM 0) type FILE
                 transid 7782235549259005952 data_len 0 name_len 8
                 name: smb.conf
         item 1 key (915987 INODE_ITEM 0) itemoff 3797 itemsize 160
                 generation 1 transid 18446744073709551492 size 12464 
nbytes 16384
                 block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
                 sequence 0 flags 0x0(none)
                 atime 1350489744.0 (2012-10-17 18:02:24)
                 ctime 1353328654.0 (2012-11-19 13:37:34)
                 mtime 1350489744.0 (2012-10-17 18:02:24)
                 otime 0.0 (1970-01-01 01:00:00)
         item 2 key (915987 INODE_REF 915986) itemoff 3779 itemsize 18
                 index 2 namelen 8 name: smb.conf
         item 3 key (915987 EXTENT_DATA 0) itemoff 3726 itemsize 53
                 generation 18 type 1 (regular)
                 extent data disk byte 1110664871936 nr 16384
                 extent data offset 0 nr 16384 ram 16384
                 extent compression 0 (none)
         item 4 key (915989 INODE_ITEM 0) itemoff 3566 itemsize 160
                 generation 1 transid 5431733 size 56 nbytes 0
                 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
                 sequence 160 flags 0x0(none)
                 atime 1571487761.716511096 (2019-10-19 14:22:41)
                 ctime 1588235951.582838139 (2020-04-30 10:39:11)
                 mtime 1588235951.582838139 (2020-04-30 10:39:11)
                 otime 0.0 (1970-01-01 01:00:00)
         item 5 key (915989 INODE_REF 659081) itemoff 3546 itemsize 20
                 index 1101 namelen 10 name: libassuan0
         item 6 key (915989 DIR_ITEM 653215628) itemoff 3497 itemsize 49
                 location key (72402032 INODE_ITEM 0) type FILE
                 transid 5431729 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 7 key (915989 DIR_ITEM 1600214284) itemoff 3458 itemsize 39
                 location key (72402033 INODE_ITEM 0) type FILE
                 transid 5431729 data_len 0 name_len 9
                 name: copyright
         item 8 key (915989 DIR_INDEX 62) itemoff 3409 itemsize 49
                 location key (72402032 INODE_ITEM 0) type FILE
                 transid 5431729 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 9 key (915989 DIR_INDEX 63) itemoff 3370 itemsize 39
                 location key (72402033 INODE_ITEM 0) type FILE
                 transid 5431729 data_len 0 name_len 9
                 name: copyright
         item 10 key (915990 INODE_ITEM 0) itemoff 3210 itemsize 160
                 generation 1 transid 4933124 size 56 nbytes 0
                 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
                 sequence 96 flags 0x0(none)
                 atime 1571487761.720511096 (2019-10-19 14:22:41)
                 ctime 1477470910.249847328 (2016-10-26 10:35:10)
                 mtime 1477470910.249847328 (2016-10-26 10:35:10)
                 otime 0.0 (1970-01-01 01:00:00)
         item 11 key (915990 INODE_REF 659081) itemoff 3189 itemsize 21
                 index 1343 namelen 11 name: libasyncns0
         item 12 key (915990 DIR_ITEM 653215628) itemoff 3140 itemsize 49
                 location key (25762857 INODE_ITEM 0) type FILE
                 transid 2068663 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 13 key (915990 DIR_ITEM 1600214284) itemoff 3101 itemsize 39
                 location key (25762858 INODE_ITEM 0) type FILE
                 transid 2068663 data_len 0 name_len 9
                 name: copyright
         item 14 key (915990 DIR_INDEX 38) itemoff 3052 itemsize 49
                 location key (25762857 INODE_ITEM 0) type FILE
                 transid 2068663 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 15 key (915990 DIR_INDEX 39) itemoff 3013 itemsize 39
                 location key (25762858 INODE_ITEM 0) type FILE
                 transid 2068663 data_len 0 name_len 9
                 name: copyright
         item 16 key (915991 INODE_ITEM 0) itemoff 2853 itemsize 160
                 generation 1 transid 4933124 size 68 nbytes 0
                 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
                 sequence 48 flags 0x0(none)
                 atime 1571487761.720511096 (2019-10-19 14:22:41)
                 ctime 1540813807.330187853 (2018-10-29 12:50:07)
                 mtime 1540813807.330187853 (2018-10-29 12:50:07)
                 otime 0.0 (1970-01-01 01:00:00)
         item 17 key (915991 INODE_REF 659081) itemoff 2831 itemsize 22
                 index 1545 namelen 12 name: libatasmart4
         item 18 key (915991 DIR_ITEM 653215628) itemoff 2782 itemsize 49
                 location key (52273681 INODE_ITEM 0) type FILE
                 transid 4036682 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 19 key (915991 DIR_ITEM 1600214284) itemoff 2743 itemsize 39
                 location key (52273682 INODE_ITEM 0) type FILE
                 transid 4036682 data_len 0 name_len 9
                 name: copyright
         item 20 key (915991 DIR_ITEM 3650993379) itemoff 2707 itemsize 36
                 location key (52273680 INODE_ITEM 0) type FILE
                 transid 4036682 data_len 0 name_len 6
                 name: README
         item 21 key (915991 DIR_INDEX 20) itemoff 2671 itemsize 36
                 location key (52273680 INODE_ITEM 0) type FILE
                 transid 4036682 data_len 0 name_len 6
                 name: README
         item 22 key (915991 DIR_INDEX 21) itemoff 2622 itemsize 49
                 location key (52273681 INODE_ITEM 0) type FILE
                 transid 4036682 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 23 key (915991 DIR_INDEX 22) itemoff 2583 itemsize 39
                 location key (52273682 INODE_ITEM 0) type FILE
                 transid 4036682 data_len 0 name_len 9
                 name: copyright
         item 24 key (915992 INODE_ITEM 0) itemoff 2423 itemsize 160
                 generation 1 transid 5431717 size 56 nbytes 0
                 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
                 sequence 611 flags 0x0(none)
                 atime 1571487761.728511097 (2019-10-19 14:22:41)
                 ctime 1588235951.295254395 (2020-04-30 10:39:11)
                 mtime 1588235951.295254395 (2020-04-30 10:39:11)
                 otime 0.0 (1970-01-01 01:00:00)
         item 25 key (915992 INODE_REF 659081) itemoff 2402 itemsize 21
                 index 2141 namelen 11 name: libatk1.0-0
         item 26 key (915992 DIR_ITEM 653215628) itemoff 2353 itemsize 49
                 location key (72401999 INODE_ITEM 0) type FILE
                 transid 5431713 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 27 key (915992 DIR_ITEM 1600214284) itemoff 2314 itemsize 39
                 location key (72402000 INODE_ITEM 0) type FILE
                 transid 5431713 data_len 0 name_len 9
                 name: copyright
         item 28 key (915992 DIR_INDEX 233) itemoff 2265 itemsize 49
                 location key (72401999 INODE_ITEM 0) type FILE
                 transid 5431713 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 29 key (915992 DIR_INDEX 234) itemoff 2226 itemsize 39
                 location key (72402000 INODE_ITEM 0) type FILE
                 transid 5431713 data_len 0 name_len 9
                 name: copyright
         item 30 key (915993 INODE_ITEM 0) itemoff 2066 itemsize 160
                 generation 1 transid 5431708 size 56 nbytes 0
                 block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
                 sequence 315 flags 0x0(none)
                 atime 1571487761.720511096 (2019-10-19 14:22:41)
                 ctime 1588235951.95543462 (2020-04-30 10:39:11)
                 mtime 1588235951.95543462 (2020-04-30 10:39:11)
                 otime 0.0 (1970-01-01 01:00:00)
         item 31 key (915993 INODE_REF 659081) itemoff 2042 itemsize 24
                 index 1639 namelen 14 name: libatk1.0-data
         item 32 key (915993 DIR_ITEM 653215628) itemoff 1993 itemsize 49
                 location key (72401982 INODE_ITEM 0) type FILE
                 transid 5431704 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 33 key (915993 DIR_ITEM 1600214284) itemoff 1954 itemsize 39
                 location key (72401983 INODE_ITEM 0) type FILE
                 transid 5431704 data_len 0 name_len 9
                 name: copyright
         item 34 key (915993 DIR_INDEX 122) itemoff 1905 itemsize 49
                 location key (72401982 INODE_ITEM 0) type FILE
                 transid 5431704 data_len 0 name_len 19
                 name: changelog.Debian.gz
         item 35 key (915993 DIR_INDEX 123) itemoff 1866 itemsize 39
                 location key (72401983 INODE_ITEM 0) type FILE
                 transid 5431704 data_len 0 name_len 9
                 name: copyright
> And 'btrfs check /dev/sda2' output after the repair.
There were no errors after the repair.
> As a workaround, you can use older kernel (v5.2 at most) to temporary
> ignore the problem.

My collegue had the brilliant idea to move  /usr/share/doc to 
/usr/share/dog, then cp back dog to doc.

So at least I was now able to finish the dist-upgrade.

Now question remains how to clean up /usr/share/dog

> Thanks,
> Qu
>
>>>>> THanks,
>>>>> Qu
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>
>>>>>>>> Linux = 5.6.0-1032-oem
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Ferry
>>>>>>>>
>>>>>>>> Op 05-11-2020 om 08:19 schreef Qu Wenruo:
>>>>>>>>> On 2020/11/5 下午3:01, Tyler Richmond wrote:
>>>>>>>>>> Qu,
>>>>>>>>>>
>>>>>>>>>> I'm wondering, was a fix for this ever implemented?
>>>>>>>>> Already implemented the --repair ability in latest btrfs-progs.
>>>>>>>>>
>>>>>>>>>> I recently added a
>>>>>>>>>> new drive to expand the array, and during the rebalance it dropped
>>>>>>>>>> itself back to a read only filesystem. I suspect it's related
>>>>>>>>>> to the
>>>>>>>>>> issues discussed earlier in this thread. Is there anything I can
>>>>>>>>>> do to
>>>>>>>>>> complete the balance? The error that caused it to drop to read
>>>>>>>>>> only is
>>>>>>>>>> here: https://pastebin.com/GGYVMaiG
>>>>>>>>> Yep, the same cause.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Qu
>>>>>>>>>> Thanks!
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On Tue, Aug 25, 2020 at 9:43 AM Tyler Richmond
>>>>>>>>>> <t.d.richmond@gmail.com> wrote:
>>>>>>>>>>> Great, glad we got somewhere! I'll look forward to the fix!
>>>>>>>>>>>
>>>>>>>>>>> On Tue, Aug 25, 2020 at 9:38 AM Qu Wenruo
>>>>>>>>>>> <quwenruo.btrfs@gmx.com>
>>>>>>>>>>> wrote:
>>>>>>>>>>>> On 2020/8/25 下午9:30, Tyler Richmond wrote:
>>>>>>>>>>>>> Qu,
>>>>>>>>>>>>>
>>>>>>>>>>>>> The dump of the block is:
>>>>>>>>>>>>>
>>>>>>>>>>>>> https://pastebin.com/ran85JJv
>>>>>>>>>>>>>
>>>>>>>>>>>>> I've also completed the btrfs-image, but it's almost 50gb.
>>>>>>>>>>>>> What's the
>>>>>>>>>>>>> best way to get it to you? Also, does it work with -ss or
>>>>>>>>>>>>> are the
>>>>>>>>>>>>> original filenames important?
>>>>>>>>>>>> 50G is too big for me to even receive.
>>>>>>>>>>>>
>>>>>>>>>>>> But your dump shows the problem!
>>>>>>>>>>>>
>>>>>>>>>>>> It's not inode generation, but inode transid, which would affect
>>>>>>>>>>>> send.
>>>>>>>>>>>>
>>>>>>>>>>>> This is not even checked in btrfs-progs, thus no wonder why it
>>>>>>>>>>>> doesn't
>>>>>>>>>>>> detect them.
>>>>>>>>>>>>
>>>>>>>>>>>> And copy-pasted kernel message shares the same "generation"
>>>>>>>>>>>> word,
>>>>>>>>>>>> not
>>>>>>>>>>>> using proper transid to show the problem.
>>>>>>>>>>>>
>>>>>>>>>>>> Your dump really saved the day!
>>>>>>>>>>>>
>>>>>>>>>>>> The fix for kernel and btrfs-progs would come in next few days.
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>> Qu
>>>>>>>>>>>>> Thanks again!
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On Tue, Aug 25, 2020 at 2:37 AM Qu Wenruo
>>>>>>>>>>>>> <quwenruo.btrfs@gmx.com>
>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>> On 2020/8/25 下午1:25, Tyler Richmond wrote:
>>>>>>>>>>>>>>> Qu,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Yes, it's btrfs-progs 5.7. Here is the result of the lowmem
>>>>>>>>>>>>>>> check:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> https://pastebin.com/8Tzx23EX
>>>>>>>>>>>>>> That doesn't detect any inode generation problem at all,
>>>>>>>>>>>>>> which is
>>>>>>>>>>>>>> not a
>>>>>>>>>>>>>> good sign.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Would you also pvode the dump for the offending block?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> block=203510940835840 slot=4 ino=1311670, invalid inode
>>>>>>>>>>>>>>> generation:
>>>>>>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> For this case, would you please provide the tree dump of
>>>>>>>>>>>>>> "203510940835840" ?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> # btrfs ins dump-tree -b 203510940835840 <device>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> And, since btrfs-image can't dump with regular extent tree,
>>>>>>>>>>>>>> the
>>>>>>>>>>>>>> "-w"
>>>>>>>>>>>>>> dump would also help.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks!
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Mon, Aug 24, 2020 at 4:26 AM Qu Wenruo
>>>>>>>>>>>>>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>>>>>>> On 2020/8/24 上午10:47, Tyler Richmond wrote:
>>>>>>>>>>>>>>>>> Qu,
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Finally finished another repair and captured the output.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> https://pastebin.com/ffcbwvd8
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Does that show you what you need? Or should I still do
>>>>>>>>>>>>>>>>> one in
>>>>>>>>>>>>>>>>> lowmem mode?
>>>>>>>>>>>>>>>> Lowmem mode (no need for --repair) is recommended since
>>>>>>>>>>>>>>>> original mode
>>>>>>>>>>>>>>>> doesn't detect the inode generation problem.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> And it's already btrfs-progs v5.7 right?
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> THanks,
>>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>>> Thanks for your help!
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On Sun, Aug 23, 2020 at 12:28 AM Qu Wenruo
>>>>>>>>>>>>>>>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>>>>>>>>> On 2020/8/23 上午10:49, Tyler Richmond wrote:
>>>>>>>>>>>>>>>>>>> Well, I can guarantee that I didn't create this fs before
>>>>>>>>>>>>>>>>>>> 2015 (just
>>>>>>>>>>>>>>>>>>> checked the order confirmation from when I bought the
>>>>>>>>>>>>>>>>>>> server), but I
>>>>>>>>>>>>>>>>>>> may have just used whatever was in the Ubuntu package
>>>>>>>>>>>>>>>>>>> manager at the
>>>>>>>>>>>>>>>>>>> time. So maybe I don't have a v0 ref?
>>>>>>>>>>>>>>>>>> Then btrfs-image shouldn't report that.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> There is an item smaller than any valid btrfs item,
>>>>>>>>>>>>>>>>>> normally
>>>>>>>>>>>>>>>>>> it means
>>>>>>>>>>>>>>>>>> it's a v0 ref.
>>>>>>>>>>>>>>>>>> If not, then it could be a bigger problem.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Could you please provide the full btrfs-check output?
>>>>>>>>>>>>>>>>>> Also, if possible result from "btrfs check --mode=lowmem"
>>>>>>>>>>>>>>>>>> would also help.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Also, if you really go "--repair", then the full output
>>>>>>>>>>>>>>>>>> would
>>>>>>>>>>>>>>>>>> also be
>>>>>>>>>>>>>>>>>> needed to determine what's going wrong.
>>>>>>>>>>>>>>>>>> There is a report about "btrfs check --repair" didn't
>>>>>>>>>>>>>>>>>> repair
>>>>>>>>>>>>>>>>>> the inode
>>>>>>>>>>>>>>>>>> generation, if that's the case we must have a bug then.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>>>>> On Sat, Aug 22, 2020 at 10:31 PM Qu Wenruo
>>>>>>>>>>>>>>>>>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>>>>>>>>>>> On 2020/8/23 上午9:51, Qu Wenruo wrote:
>>>>>>>>>>>>>>>>>>>>> On 2020/8/23 上午9:15, Tyler Richmond wrote:
>>>>>>>>>>>>>>>>>>>>>> Is my best bet just to downgrade the kernel and
>>>>>>>>>>>>>>>>>>>>>> then try
>>>>>>>>>>>>>>>>>>>>>> to delete the
>>>>>>>>>>>>>>>>>>>>>> broken files? Or should I rebuild from scratch? Just
>>>>>>>>>>>>>>>>>>>>>> don't know
>>>>>>>>>>>>>>>>>>>>>> whether it's worth the time to try and figure this
>>>>>>>>>>>>>>>>>>>>>> out or
>>>>>>>>>>>>>>>>>>>>>> if the
>>>>>>>>>>>>>>>>>>>>>> problems stem from the FS being too old and it's
>>>>>>>>>>>>>>>>>>>>>> beyond
>>>>>>>>>>>>>>>>>>>>>> trying to
>>>>>>>>>>>>>>>>>>>>>> repair.
>>>>>>>>>>>>>>>>>>>>> All invalid inode generations, should be able to be
>>>>>>>>>>>>>>>>>>>>> repaired by latest
>>>>>>>>>>>>>>>>>>>>> btrfs-check.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> If not, please provide the btrfs-image dump for us to
>>>>>>>>>>>>>>>>>>>>> determine what's
>>>>>>>>>>>>>>>>>>>>> going wrong.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>>>>>>>> On Tue, Aug 18, 2020 at 8:18 AM Tyler Richmond
>>>>>>>>>>>>>>>>>>>>>> <t.d.richmond@gmail.com> wrote:
>>>>>>>>>>>>>>>>>>>>>>> I didn't check dmesg during the btrfs check, but that
>>>>>>>>>>>>>>>>>>>>>>> was the only
>>>>>>>>>>>>>>>>>>>>>>> output during the rm -f before it was forced
>>>>>>>>>>>>>>>>>>>>>>> readonly. I
>>>>>>>>>>>>>>>>>>>>>>> just checked
>>>>>>>>>>>>>>>>>>>>>>> dmesg for inode generation values, and there are a
>>>>>>>>>>>>>>>>>>>>>>> lot
>>>>>>>>>>>>>>>>>>>>>>> of them.
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> https://pastebin.com/stZdN0ta
>>>>>>>>>>>>>>>>>>>>>>> The dmesg output had 990 lines containing inode
>>>>>>>>>>>>>>>>>>>>>>> generation.
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> However, these were at least later. I tried to do a
>>>>>>>>>>>>>>>>>>>>>>> btrfs balance
>>>>>>>>>>>>>>>>>>>>>>> -mconvert raid1 and it failed with an I/O error.
>>>>>>>>>>>>>>>>>>>>>>> That is
>>>>>>>>>>>>>>>>>>>>>>> probably what
>>>>>>>>>>>>>>>>>>>>>>> generated these specific errors, but maybe they were
>>>>>>>>>>>>>>>>>>>>>>> also happening
>>>>>>>>>>>>>>>>>>>>>>> during the btrfs repair.
>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> The FS is ~45TB, but the btrfs-image -c9 failed anway
>>>>>>>>>>>>>>>>>>>>>>> with:
>>>>>>>>>>>>>>>>>>>>>>> ERROR: either extent tree is corrupted or deprecated
>>>>>>>>>>>>>>>>>>>>>>> extent ref format
>>>>>>>>>>>>>>>>>>>>>>> ERROR: create failed: -5
>>>>>>>>>>>>>>>>>>>> Oh, forgot this part.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> This means you have v0 ref?!
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Then the fs is too old, no progs/kernel support after
>>>>>>>>>>>>>>>>>>>> all.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> In that case, please rollback to the last working kernel
>>>>>>>>>>>>>>>>>>>> and copy your data.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> In fact, that v0 ref should only be in the code base for
>>>>>>>>>>>>>>>>>>>> several weeks
>>>>>>>>>>>>>>>>>>>> before 2010, thus it's really too old.
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> The good news is, with tree-checker, we should never
>>>>>>>>>>>>>>>>>>>> experience such
>>>>>>>>>>>>>>>>>>>> too-old-to-be-usable problem (at least I hope so)
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>> On Tue, Aug 18, 2020 at 2:07 AM Qu Wenruo
>>>>>>>>>>>>>>>>>>>>>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>>>>>>>>>>>>>>> On 2020/8/18 上午11:35, Tyler Richmond wrote:
>>>>>>>>>>>>>>>>>>>>>>>>> Qu,
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>> Sorry to resurrect this thread, but I just ran into
>>>>>>>>>>>>>>>>>>>>>>>>> something that I
>>>>>>>>>>>>>>>>>>>>>>>>> can't really just ignore. I've found a folder
>>>>>>>>>>>>>>>>>>>>>>>>> that is
>>>>>>>>>>>>>>>>>>>>>>>>> full of files
>>>>>>>>>>>>>>>>>>>>>>>>> which I guess have been broken somehow. I found a
>>>>>>>>>>>>>>>>>>>>>>>>> backup and restored
>>>>>>>>>>>>>>>>>>>>>>>>> them, but I want to delete this folder of broken
>>>>>>>>>>>>>>>>>>>>>>>>> files. But whenever I
>>>>>>>>>>>>>>>>>>>>>>>>> try, the fs is forced into readonly mode again. I
>>>>>>>>>>>>>>>>>>>>>>>>> just
>>>>>>>>>>>>>>>>>>>>>>>>> finished another
>>>>>>>>>>>>>>>>>>>>>>>>> btrfs check --repair but it didn't fix the problem.
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>> https://pastebin.com/eTV3s3fr
>>>>>>>>>>>>>>>>>>>>>>>> Is that the full output?
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> No inode generation bugs?
>>>>>>>>>>>>>>>>>>>>>>>>>       I'm already on btrfs-progs v5.7. Any new
>>>>>>>>>>>>>>>>>>>>>>>>> suggestions?
>>>>>>>>>>>>>>>>>>>>>>>> Strange.
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> The detection and repair should have been merged
>>>>>>>>>>>>>>>>>>>>>>>> into
>>>>>>>>>>>>>>>>>>>>>>>> v5.5.
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> If your fs is small enough, would you please provide
>>>>>>>>>>>>>>>>>>>>>>>> the "btrfs-image
>>>>>>>>>>>>>>>>>>>>>>>> -c9" dump?
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> It would contain the filenames and directories
>>>>>>>>>>>>>>>>>>>>>>>> names,
>>>>>>>>>>>>>>>>>>>>>>>> but doesn't
>>>>>>>>>>>>>>>>>>>>>>>> contain file contents.
>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>>>>>>>>>>> On Fri, May 8, 2020 at 9:52 AM Tyler Richmond
>>>>>>>>>>>>>>>>>>>>>>>>> <t.d.richmond@gmail.com
>>>>>>>>>>>>>>>>>>>>>>>>> <mailto:t.d.richmond@gmail.com>> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          5.6.1 also failed the same way. Here's the
>>>>>>>>>>>>>>>>>>>>>>>>> usage
>>>>>>>>>>>>>>>>>>>>>>>>> output. This is the
>>>>>>>>>>>>>>>>>>>>>>>>>          part where you see I've been using RAID5
>>>>>>>>>>>>>>>>>>>>>>>>> haha
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          WARNING: RAID56 detected, not implemented
>>>>>>>>>>>>>>>>>>>>>>>>>          Overall:
>>>>>>>>>>>>>>>>>>>>>>>>>              Device size:                  60.03TiB
>>>>>>>>>>>>>>>>>>>>>>>>>              Device allocated:             98.06GiB
>>>>>>>>>>>>>>>>>>>>>>>>>              Device unallocated:           59.93TiB
>>>>>>>>>>>>>>>>>>>>>>>>>              Device missing:                  0.00B
>>>>>>>>>>>>>>>>>>>>>>>>>              Used:                         92.56GiB
>>>>>>>>>>>>>>>>>>>>>>>>>              Free (estimated):                0.00B
>>>>>>>>>>>>>>>>>>>>>>>>> (min: 8.00EiB)
>>>>>>>>>>>>>>>>>>>>>>>>>              Data ratio:                       0.00
>>>>>>>>>>>>>>>>>>>>>>>>>              Metadata ratio:                   2.00
>>>>>>>>>>>>>>>>>>>>>>>>>              Global reserve:              512.00MiB
>>>>>>>>>>>>>>>>>>>>>>>>> (used: 0.00B)
>>>>>>>>>>>>>>>>>>>>>>>>>              Multiple profiles:                  no
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          Data,RAID5: Size:40.35TiB, Used:40.12TiB
>>>>>>>>>>>>>>>>>>>>>>>>> (99.42%)
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sdh        8.07TiB
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sdf        8.07TiB
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sdg        8.07TiB
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sdd        8.07TiB
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sdc        8.07TiB
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sde        8.07TiB
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          Metadata,RAID1: Size:49.00GiB,
>>>>>>>>>>>>>>>>>>>>>>>>> Used:46.28GiB
>>>>>>>>>>>>>>>>>>>>>>>>> (94.44%)
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sdh       34.00GiB
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sdf       32.00GiB
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sdg       32.00GiB
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          System,RAID1: Size:32.00MiB, Used:2.20MiB
>>>>>>>>>>>>>>>>>>>>>>>>> (6.87%)
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sdf       32.00MiB
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sdg       32.00MiB
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          Unallocated:
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sdh        2.81TiB
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sdf        2.81TiB
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sdg        2.81TiB
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sdd        1.03TiB
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sdc        1.03TiB
>>>>>>>>>>>>>>>>>>>>>>>>>             /dev/sde        1.03TiB
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          On Fri, May 8, 2020 at 1:47 AM Qu Wenruo
>>>>>>>>>>>>>>>>>>>>>>>>> <quwenruo.btrfs@gmx.com
>>>>>>>>>>>>>>>>>>>>>>>>>          <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>          > On 2020/5/8 下午1:12, Tyler Richmond
>>>>>>>>>>>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>          > > If this is saying there's no extra
>>>>>>>>>>>>>>>>>>>>>>>>> space for
>>>>>>>>>>>>>>>>>>>>>>>>> metadata, is that why
>>>>>>>>>>>>>>>>>>>>>>>>>          > > adding more files often makes the
>>>>>>>>>>>>>>>>>>>>>>>>> system hang
>>>>>>>>>>>>>>>>>>>>>>>>> for 30-90s? Is there
>>>>>>>>>>>>>>>>>>>>>>>>>          > > anything I should do about that?
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>          > I'm not sure about the hang though.
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>          > It would be nice to give more info to
>>>>>>>>>>>>>>>>>>>>>>>>> diagnosis.
>>>>>>>>>>>>>>>>>>>>>>>>>          > The output of 'btrfs fi usage' is
>>>>>>>>>>>>>>>>>>>>>>>>> useful for
>>>>>>>>>>>>>>>>>>>>>>>>> space usage problem.
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>          > But the common idea is, to keep at 1~2 Gi
>>>>>>>>>>>>>>>>>>>>>>>>> unallocated (not avaiable
>>>>>>>>>>>>>>>>>>>>>>>>>          > space in vanilla df command) space for
>>>>>>>>>>>>>>>>>>>>>>>>> btrfs.
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>          > Thanks,
>>>>>>>>>>>>>>>>>>>>>>>>>          > Qu
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>          > >
>>>>>>>>>>>>>>>>>>>>>>>>>          > > Thank you so much for all of your
>>>>>>>>>>>>>>>>>>>>>>>>> help. I
>>>>>>>>>>>>>>>>>>>>>>>>> love how flexible BTRFS is
>>>>>>>>>>>>>>>>>>>>>>>>>          > > but when things go wrong it's very hard
>>>>>>>>>>>>>>>>>>>>>>>>> for
>>>>>>>>>>>>>>>>>>>>>>>>> me to troubleshoot.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >
>>>>>>>>>>>>>>>>>>>>>>>>>          > > On Fri, May 8, 2020 at 1:07 AM Qu
>>>>>>>>>>>>>>>>>>>>>>>>> Wenruo
>>>>>>>>>>>>>>>>>>>>>>>>> <quwenruo.btrfs@gmx.com
>>>>>>>>>>>>>>>>>>>>>>>>>          <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >> On 2020/5/8 下午12:23, Tyler Richmond
>>>>>>>>>>>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>> Something went wrong:
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>> Reinitialize checksum tree
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>> Unable to find block group for 0
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>> Unable to find block group for 0
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>> Unable to find block group for 0
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>> ctree.c:2272: split_leaf: BUG_ON `1`
>>>>>>>>>>>>>>>>>>>>>>>>> triggered, value 1
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>> btrfs(+0x6dd94)[0x55a933af7d94]
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>> btrfs(+0x71b94)[0x55a933afbb94]
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>
>>>>>>>>>>>>>>>>>>>>>>>>> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>
>>>>>>>>>>>>>>>>>>>>>>>>> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09]
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>> btrfs(+0x360b2)[0x55a933ac00b2]
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>> btrfs(+0x46a3e)[0x55a933ad0a3e]
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>> btrfs(main+0x98)[0x55a933a9fe88]
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>
>>>>>>>>>>>>>>>>>>>>>>>>>      
>>>>>>>>>>>>>>>>>>>>>>>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf3)[0x7f263ed550b3]
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>> btrfs(_start+0x2e)[0x55a933a9fa0e]
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>> Aborted
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >> This means no space for extra
>>>>>>>>>>>>>>>>>>>>>>>>> metadata...
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >> Anyway the csum tree problem shouldn't
>>>>>>>>>>>>>>>>>>>>>>>>> be a
>>>>>>>>>>>>>>>>>>>>>>>>> big thing, you
>>>>>>>>>>>>>>>>>>>>>>>>>          could leave
>>>>>>>>>>>>>>>>>>>>>>>>>          > >> it and call it a day.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >> BTW, as long as btrfs check reports no
>>>>>>>>>>>>>>>>>>>>>>>>> extra
>>>>>>>>>>>>>>>>>>>>>>>>> problem for the inode
>>>>>>>>>>>>>>>>>>>>>>>>>          > >> generation, it should be pretty safe
>>>>>>>>>>>>>>>>>>>>>>>>> to use
>>>>>>>>>>>>>>>>>>>>>>>>> the fs.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >> Thanks,
>>>>>>>>>>>>>>>>>>>>>>>>>          > >> Qu
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>> I just noticed I have btrfs-progs 5.6
>>>>>>>>>>>>>>>>>>>>>>>>> installed and 5.6.1 is
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>> available. I'll let that try
>>>>>>>>>>>>>>>>>>>>>>>>> overnight?
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>> On Thu, May 7, 2020 at 8:11 PM Qu
>>>>>>>>>>>>>>>>>>>>>>>>> Wenruo
>>>>>>>>>>>>>>>>>>>>>>>>>          <quwenruo.btrfs@gmx.com
>>>>>>>>>>>>>>>>>>>>>>>>> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>> On 2020/5/7 下午11:52, Tyler
>>>>>>>>>>>>>>>>>>>>>>>>> Richmond
>>>>>>>>>>>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> Thank you for helping. The end
>>>>>>>>>>>>>>>>>>>>>>>>> result of
>>>>>>>>>>>>>>>>>>>>>>>>> the scan was:
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> [1/7] checking root items
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> [2/7] checking extents
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> [3/7] checking free space cache
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> [4/7] checking fs roots
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>> Good news is, your fs is still
>>>>>>>>>>>>>>>>>>>>>>>>> mostly
>>>>>>>>>>>>>>>>>>>>>>>>> fine.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> [5/7] checking only csums items
>>>>>>>>>>>>>>>>>>>>>>>>> (without
>>>>>>>>>>>>>>>>>>>>>>>>> verifying data)
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> there are no extents for csum range
>>>>>>>>>>>>>>>>>>>>>>>>> 0-69632
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> csum exists for 0-69632 but there
>>>>>>>>>>>>>>>>>>>>>>>>> is no
>>>>>>>>>>>>>>>>>>>>>>>>> extent record
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> ...
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> ...
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> there are no extents for csum range
>>>>>>>>>>>>>>>>>>>>>>>>> 946692096-946827264
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> csum exists for 946692096-946827264
>>>>>>>>>>>>>>>>>>>>>>>>> but
>>>>>>>>>>>>>>>>>>>>>>>>> there is no extent
>>>>>>>>>>>>>>>>>>>>>>>>>          record
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> there are no extents for csum range
>>>>>>>>>>>>>>>>>>>>>>>>> 946831360-947912704
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> csum exists for 946831360-947912704
>>>>>>>>>>>>>>>>>>>>>>>>> but
>>>>>>>>>>>>>>>>>>>>>>>>> there is no extent
>>>>>>>>>>>>>>>>>>>>>>>>>          record
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> ERROR: errors found in csum tree
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>> Only extent tree is corrupted.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>> Normally btrfs check
>>>>>>>>>>>>>>>>>>>>>>>>> --init-csum-tree
>>>>>>>>>>>>>>>>>>>>>>>>> should be able to
>>>>>>>>>>>>>>>>>>>>>>>>>          handle it.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>> But still, please be sure you're
>>>>>>>>>>>>>>>>>>>>>>>>> using the
>>>>>>>>>>>>>>>>>>>>>>>>> latest btrfs-progs
>>>>>>>>>>>>>>>>>>>>>>>>>          to fix it.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>> Thanks,
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>> Qu
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> [6/7] checking root refs
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> [7/7] checking quota groups skipped
>>>>>>>>>>>>>>>>>>>>>>>>> (not
>>>>>>>>>>>>>>>>>>>>>>>>> enabled on this FS)
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> found 44157956026368 bytes used,
>>>>>>>>>>>>>>>>>>>>>>>>> error(s)
>>>>>>>>>>>>>>>>>>>>>>>>> found
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> total csum bytes: 42038602716
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> total tree bytes: 49688616960
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> total fs tree bytes: 1256427520
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> total extent tree bytes: 1709105152
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> btree space waste bytes: 3172727316
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> file data blocks allocated:
>>>>>>>>>>>>>>>>>>>>>>>>> 261625653436416
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>  referenced 47477768499200
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> What do I need to do to fix all of
>>>>>>>>>>>>>>>>>>>>>>>>> this?
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>> On Thu, May 7, 2020 at 1:52 AM Qu
>>>>>>>>>>>>>>>>>>>>>>>>> Wenruo
>>>>>>>>>>>>>>>>>>>>>>>>>          <quwenruo.btrfs@gmx.com
>>>>>>>>>>>>>>>>>>>>>>>>> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>> On 2020/5/7 下午1:43, Tyler
>>>>>>>>>>>>>>>>>>>>>>>>> Richmond
>>>>>>>>>>>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> Well, the repair doesn't look
>>>>>>>>>>>>>>>>>>>>>>>>> terribly
>>>>>>>>>>>>>>>>>>>>>>>>> successful.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent transid verify failed on
>>>>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>>>>>          6875841 found 6876224
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent transid verify failed on
>>>>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>>>>>          6875841 found 6876224
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent transid verify failed on
>>>>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>>>>>          6875841 found 6876224
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> ERROR: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>>>>> bytenr=225049956061184
>>>>>>>>>>>>>>>>>>>>>>>>>          item=84
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                                
>>>>>>>>>>>>>>>>>>>>>>>>> child level=4
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>> This means there are more
>>>>>>>>>>>>>>>>>>>>>>>>> problems, not
>>>>>>>>>>>>>>>>>>>>>>>>> only the hash name
>>>>>>>>>>>>>>>>>>>>>>>>>          mismatch.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>> This means the fs is already
>>>>>>>>>>>>>>>>>>>>>>>>> corrupted,
>>>>>>>>>>>>>>>>>>>>>>>>> the name hash is
>>>>>>>>>>>>>>>>>>>>>>>>>          just one
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>> unrelated symptom.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>> The only good news is, btrfs-progs
>>>>>>>>>>>>>>>>>>>>>>>>> abort
>>>>>>>>>>>>>>>>>>>>>>>>> the transaction,
>>>>>>>>>>>>>>>>>>>>>>>>>          thus no
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>> further damage to the fs.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>> Please run a plain btrfs-check to
>>>>>>>>>>>>>>>>>>>>>>>>> show
>>>>>>>>>>>>>>>>>>>>>>>>> what's the problem
>>>>>>>>>>>>>>>>>>>>>>>>>          first.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>> Thanks,
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>> Qu
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent transid verify failed on
>>>>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>>>>>          6875841 found 6876224
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> ERROR: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>>>>> bytenr=225049956061184
>>>>>>>>>>>>>>>>>>>>>>>>>          item=84
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                                
>>>>>>>>>>>>>>>>>>>>>>>>> child level=4
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent transid verify failed on
>>>>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>>>>>          6875841 found 6876224
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> ERROR: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>>>>> bytenr=225049956061184
>>>>>>>>>>>>>>>>>>>>>>>>>          item=84
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                                
>>>>>>>>>>>>>>>>>>>>>>>>> child level=4
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent transid verify failed on
>>>>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>>>>>          6875841 found 6876224
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> ERROR: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>>>>> bytenr=225049956061184
>>>>>>>>>>>>>>>>>>>>>>>>>          item=84
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                                
>>>>>>>>>>>>>>>>>>>>>>>>> child level=4
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent transid verify failed on
>>>>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>>>>>          6875841 found 6876224
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> ERROR: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>>>>> bytenr=225049956061184
>>>>>>>>>>>>>>>>>>>>>>>>>          item=84
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                                
>>>>>>>>>>>>>>>>>>>>>>>>> child level=4
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent transid verify failed on
>>>>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>>>>>          6875841 found 6876224
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> ERROR: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>>>>> bytenr=225049956061184
>>>>>>>>>>>>>>>>>>>>>>>>>          item=84
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                                
>>>>>>>>>>>>>>>>>>>>>>>>> child level=4
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent transid verify failed on
>>>>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>>>>>          6875841 found 6876224
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> ERROR: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>>>>> bytenr=225049956061184
>>>>>>>>>>>>>>>>>>>>>>>>>          item=84
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                                
>>>>>>>>>>>>>>>>>>>>>>>>> child level=4
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent transid verify failed on
>>>>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>>>>>          6875841 found 6876224
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> ERROR: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>>>>> bytenr=225049956061184
>>>>>>>>>>>>>>>>>>>>>>>>>          item=84
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                                
>>>>>>>>>>>>>>>>>>>>>>>>> child level=4
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent transid verify failed on
>>>>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>>>>>          6875841 found 6876224
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> ERROR: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>>>>> bytenr=225049956061184
>>>>>>>>>>>>>>>>>>>>>>>>>          item=84
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                                
>>>>>>>>>>>>>>>>>>>>>>>>> child level=4
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent transid verify failed on
>>>>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>>>>>          6875841 found 6876224
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> ERROR: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>>>>> bytenr=225049956061184
>>>>>>>>>>>>>>>>>>>>>>>>>          item=84
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                                
>>>>>>>>>>>>>>>>>>>>>>>>> child level=4
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent transid verify failed on
>>>>>>>>>>>>>>>>>>>>>>>>> 218620880703488 wanted
>>>>>>>>>>>>>>>>>>>>>>>>>          6875841 found 6876224
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> ERROR: child eb corrupted: parent
>>>>>>>>>>>>>>>>>>>>>>>>> bytenr=225049956061184
>>>>>>>>>>>>>>>>>>>>>>>>>          item=84
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>                                                
>>>>>>>>>>>>>>>>>>>>>>>>> child level=4
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> ERROR: failed to zero log
>>>>>>>>>>>>>>>>>>>>>>>>> tree: -17
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> ERROR: attempt to start
>>>>>>>>>>>>>>>>>>>>>>>>> transaction
>>>>>>>>>>>>>>>>>>>>>>>>> over already running one
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> WARNING: reserved space leaked,
>>>>>>>>>>>>>>>>>>>>>>>>> flag=0x4 bytes_reserved=4096
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> extent buffer leak: start
>>>>>>>>>>>>>>>>>>>>>>>>> 225049066086400 len 4096
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> extent buffer leak: start
>>>>>>>>>>>>>>>>>>>>>>>>> 225049066086400 len 4096
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> WARNING: dirty eb leak (aborted
>>>>>>>>>>>>>>>>>>>>>>>>> trans):
>>>>>>>>>>>>>>>>>>>>>>>>> start
>>>>>>>>>>>>>>>>>>>>>>>>>          225049066086400 len 4096
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> extent buffer leak: start
>>>>>>>>>>>>>>>>>>>>>>>>> 225049066094592 len 4096
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> extent buffer leak: start
>>>>>>>>>>>>>>>>>>>>>>>>> 225049066094592 len 4096
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> WARNING: dirty eb leak (aborted
>>>>>>>>>>>>>>>>>>>>>>>>> trans):
>>>>>>>>>>>>>>>>>>>>>>>>> start
>>>>>>>>>>>>>>>>>>>>>>>>>          225049066094592 len 4096
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> extent buffer leak: start
>>>>>>>>>>>>>>>>>>>>>>>>> 225049066102784 len 4096
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> extent buffer leak: start
>>>>>>>>>>>>>>>>>>>>>>>>> 225049066102784 len 4096
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> WARNING: dirty eb leak (aborted
>>>>>>>>>>>>>>>>>>>>>>>>> trans):
>>>>>>>>>>>>>>>>>>>>>>>>> start
>>>>>>>>>>>>>>>>>>>>>>>>>          225049066102784 len 4096
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> extent buffer leak: start
>>>>>>>>>>>>>>>>>>>>>>>>> 225049066131456 len 4096
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> extent buffer leak: start
>>>>>>>>>>>>>>>>>>>>>>>>> 225049066131456 len 4096
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> WARNING: dirty eb leak (aborted
>>>>>>>>>>>>>>>>>>>>>>>>> trans):
>>>>>>>>>>>>>>>>>>>>>>>>> start
>>>>>>>>>>>>>>>>>>>>>>>>>          225049066131456 len 4096
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> What is going on?
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>> On Wed, May 6, 2020 at 9:30 PM
>>>>>>>>>>>>>>>>>>>>>>>>> Tyler
>>>>>>>>>>>>>>>>>>>>>>>>> Richmond
>>>>>>>>>>>>>>>>>>>>>>>>>          <t.d.richmond@gmail.com
>>>>>>>>>>>>>>>>>>>>>>>>> <mailto:t.d.richmond@gmail.com>> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>> Chris, I had used the correct
>>>>>>>>>>>>>>>>>>>>>>>>> mountpoint in the command.
>>>>>>>>>>>>>>>>>>>>>>>>>          I just edited
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>> it in the email to be
>>>>>>>>>>>>>>>>>>>>>>>>> /mountpoint for
>>>>>>>>>>>>>>>>>>>>>>>>> consistency.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>> Qu, I'll try the repair. Fingers
>>>>>>>>>>>>>>>>>>>>>>>>> crossed!
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>> On Wed, May 6, 2020 at 9:13
>>>>>>>>>>>>>>>>>>>>>>>>> PM Qu
>>>>>>>>>>>>>>>>>>>>>>>>> Wenruo
>>>>>>>>>>>>>>>>>>>>>>>>>          <quwenruo.btrfs@gmx.com
>>>>>>>>>>>>>>>>>>>>>>>>> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>> On 2020/5/7 上午5:54, Tyler
>>>>>>>>>>>>>>>>>>>>>>>>> Richmond
>>>>>>>>>>>>>>>>>>>>>>>>> wrote:
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> Hello,
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> I looked up this error and it
>>>>>>>>>>>>>>>>>>>>>>>>> basically says ask a
>>>>>>>>>>>>>>>>>>>>>>>>>          developer to
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> determine if it's a false
>>>>>>>>>>>>>>>>>>>>>>>>> error or
>>>>>>>>>>>>>>>>>>>>>>>>> not. I just started
>>>>>>>>>>>>>>>>>>>>>>>>>          getting some
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> slow response times, and
>>>>>>>>>>>>>>>>>>>>>>>>> looked at
>>>>>>>>>>>>>>>>>>>>>>>>> the dmesg log to
>>>>>>>>>>>>>>>>>>>>>>>>>          find a ton of
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> these errors.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> [192088.446299] BTRFS critical
>>>>>>>>>>>>>>>>>>>>>>>>> (device sdh): corrupt
>>>>>>>>>>>>>>>>>>>>>>>>>          leaf: root=5
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> block=203510940835840 slot=4
>>>>>>>>>>>>>>>>>>>>>>>>> ino=1311670, invalid inode
>>>>>>>>>>>>>>>>>>>>>>>>>          generation:
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> has 18446744073709551492
>>>>>>>>>>>>>>>>>>>>>>>>> expect [0,
>>>>>>>>>>>>>>>>>>>>>>>>> 6875827]
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> [192088.449823] BTRFS error
>>>>>>>>>>>>>>>>>>>>>>>>> (device
>>>>>>>>>>>>>>>>>>>>>>>>> sdh):
>>>>>>>>>>>>>>>>>>>>>>>>>          block=203510940835840 read
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> time tree block corruption
>>>>>>>>>>>>>>>>>>>>>>>>> detected
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> [192088.459238] BTRFS critical
>>>>>>>>>>>>>>>>>>>>>>>>> (device sdh): corrupt
>>>>>>>>>>>>>>>>>>>>>>>>>          leaf: root=5
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> block=203510940835840 slot=4
>>>>>>>>>>>>>>>>>>>>>>>>> ino=1311670, invalid inode
>>>>>>>>>>>>>>>>>>>>>>>>>          generation:
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> has 18446744073709551492
>>>>>>>>>>>>>>>>>>>>>>>>> expect [0,
>>>>>>>>>>>>>>>>>>>>>>>>> 6875827]
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> [192088.462773] BTRFS error
>>>>>>>>>>>>>>>>>>>>>>>>> (device
>>>>>>>>>>>>>>>>>>>>>>>>> sdh):
>>>>>>>>>>>>>>>>>>>>>>>>>          block=203510940835840 read
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> time tree block corruption
>>>>>>>>>>>>>>>>>>>>>>>>> detected
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> [192088.464711] BTRFS critical
>>>>>>>>>>>>>>>>>>>>>>>>> (device sdh): corrupt
>>>>>>>>>>>>>>>>>>>>>>>>>          leaf: root=5
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> block=203510940835840 slot=4
>>>>>>>>>>>>>>>>>>>>>>>>> ino=1311670, invalid inode
>>>>>>>>>>>>>>>>>>>>>>>>>          generation:
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> has 18446744073709551492
>>>>>>>>>>>>>>>>>>>>>>>>> expect [0,
>>>>>>>>>>>>>>>>>>>>>>>>> 6875827]
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> [192088.468457] BTRFS error
>>>>>>>>>>>>>>>>>>>>>>>>> (device
>>>>>>>>>>>>>>>>>>>>>>>>> sdh):
>>>>>>>>>>>>>>>>>>>>>>>>>          block=203510940835840 read
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> time tree block corruption
>>>>>>>>>>>>>>>>>>>>>>>>> detected
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> btrfs device stats, however,
>>>>>>>>>>>>>>>>>>>>>>>>> doesn't
>>>>>>>>>>>>>>>>>>>>>>>>> show any errors.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> Is there anything I should do
>>>>>>>>>>>>>>>>>>>>>>>>> about
>>>>>>>>>>>>>>>>>>>>>>>>> this, or should I
>>>>>>>>>>>>>>>>>>>>>>>>>          just continue
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> using my array as normal?
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>> This is caused by older kernel
>>>>>>>>>>>>>>>>>>>>>>>>> underflow inode generation.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>> Latest btrfs-progs can fix it,
>>>>>>>>>>>>>>>>>>>>>>>>> using
>>>>>>>>>>>>>>>>>>>>>>>>> btrfs check --repair.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>> Or you can go safer, by
>>>>>>>>>>>>>>>>>>>>>>>>> manually
>>>>>>>>>>>>>>>>>>>>>>>>> locating the inode
>>>>>>>>>>>>>>>>>>>>>>>>>          using its inode
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>> number (1311670), and copy it
>>>>>>>>>>>>>>>>>>>>>>>>> to some
>>>>>>>>>>>>>>>>>>>>>>>>> new location using
>>>>>>>>>>>>>>>>>>>>>>>>>          previous
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>> working kernel, then delete the
>>>>>>>>>>>>>>>>>>>>>>>>> old
>>>>>>>>>>>>>>>>>>>>>>>>> file, copy the new
>>>>>>>>>>>>>>>>>>>>>>>>>          one back to fix it.
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>> Qu
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>> Thank you!
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>>>
>>>>>>>>>>>>>>>>>>>>>>>>>          > >>
>>>>>>>>>>>>>>>>>>>>>>>>>          >
>>>>>>>>>>>>>>>>>>>>>>>>>

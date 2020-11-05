Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C700E2A87D2
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 21:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbgKEUOS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 15:14:18 -0500
Received: from smtp.radex.nl ([178.250.146.7]:59198 "EHLO radex-web.radex.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgKEUOS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Nov 2020 15:14:18 -0500
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Nov 2020 15:14:15 EST
Received: from [10.8.0.6] (cust-178-250-146-69.breedbanddelft.nl [178.250.146.69])
        by radex-web.radex.nl (Postfix) with ESMTPS id 5767B2406A;
        Thu,  5 Nov 2020 21:08:27 +0100 (CET)
Subject: Re: Fwd: Read time tree block corruption detected
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Tyler Richmond <t.d.richmond@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN2kY7kVyfo+kv0=DymXfnjiacX_a=rg7oXkeNV4x_XvHw@mail.gmail.com>
 <CAJheHN0qqOn2u4Rks6u+Epsr+L+ijs0E=G=AUCV3F-yLvsLasA@mail.gmail.com>
 <98c633bc-658c-d8d9-a2cd-4c9b9e477552@gmx.com>
 <6bc0816e-b58c-1d74-7c0e-e07a38a5a027@gmx.com>
 <CAJheHN25gNo-jgykeQ6=ZQAm1ZHG9+-rWhBp3S-x2c1xi5j-og@mail.gmail.com>
 <4d1bb444-921c-9773-ff68-b6ea074ff35d@gmx.com>
 <CAJheHN1+AQR-irSbaH8f7HGj=rDN4+uUCyqjvtezGewQkQoDpg@mail.gmail.com>
 <5346c4af-c73e-84b3-ec4f-8f169c0a732a@gmx.com>
 <CAJheHN0NmgVoGF+AsnUNQkQnEJ46JCmpg4o5nwAkqi+VoGMjfw@mail.gmail.com>
 <e04680b4-f4c0-254f-24ba-f2053e4ad8b3@gmx.com>
 <CAJheHN0THhKcqKY3cGtJqUGaub=E0tuCmi6wuNeCGBxyAHmecQ@mail.gmail.com>
 <e2c8eaaf-6adb-374f-4005-a1edcbcb8f79@gmx.com>
 <CAJheHN1U4j1KsD96oFuCVwP+6RVP6V6oAZP-aGOTtfm7tDL3BA@mail.gmail.com>
 <CAJheHN3pTj-6dOQZVKqA_r38F+WVNrjVO6-Z_hFeq96uTNK5zw@mail.gmail.com>
 <1f26ff53-f7c7-c497-b69f-8a3e5d8ce959@gmx.com>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <b7383762-4a86-fdb9-12f3-89470808f4e6@gmail.com>
Date:   Thu, 5 Nov 2020 21:08:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <1f26ff53-f7c7-c497-b69f-8a3e5d8ce959@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I am in a similar spot, during updating my distro (Kubuntu), I am unable 
to update a certain package. I know which file it is:

~$ ls -l /usr/share/doc/libatk1.0-data
ls: kan geen toegang krijgen tot '/usr/share/doc/libatk1.0-data': 
Invoer-/uitvoerfout

This creates the following in journal:

kernel: BTRFS critical (device sda2): corrupt leaf: root=294 
block=1169152675840 slot=1 ino=915987, invalid inode generation: has 
18446744073709551492 expect [0, 5851353]
kernel: BTRFS error (device sda2): block=1169152675840 read time tree 
block corruption detected

Now, the problem: this file is on my rootfs, which is mounted. apt 
(distribution updated) installed all packages but can't continue 
configuring, because libatk is a dependancy. I can't delete the file 
because of the I/O error. And btrfs check complains (I tried running RO) 
because the file system is mounted.

But, on the sunny side, the file system is not RO.

Is there any way to forcefully remove the file? Or do you have a 
recommendation how to proceed?

Linux = 5.6.0-1032-oem

Thanks,
Ferry

Op 05-11-2020 om 08:19 schreef Qu Wenruo:
> 
> 
> On 2020/11/5 下午3:01, Tyler Richmond wrote:
>> Qu,
>>
>> I'm wondering, was a fix for this ever implemented?
> 
> Already implemented the --repair ability in latest btrfs-progs.
> 
>> I recently added a
>> new drive to expand the array, and during the rebalance it dropped
>> itself back to a read only filesystem. I suspect it's related to the
>> issues discussed earlier in this thread. Is there anything I can do to
>> complete the balance? The error that caused it to drop to read only is
>> here: https://pastebin.com/GGYVMaiG
> 
> Yep, the same cause.
> 
> Thanks,
> Qu
>>
>> Thanks!
>>
>>
>> On Tue, Aug 25, 2020 at 9:43 AM Tyler Richmond <t.d.richmond@gmail.com> wrote:
>>>
>>> Great, glad we got somewhere! I'll look forward to the fix!
>>>
>>> On Tue, Aug 25, 2020 at 9:38 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2020/8/25 下午9:30, Tyler Richmond wrote:
>>>>> Qu,
>>>>>
>>>>> The dump of the block is:
>>>>>
>>>>> https://pastebin.com/ran85JJv
>>>>>
>>>>> I've also completed the btrfs-image, but it's almost 50gb. What's the
>>>>> best way to get it to you? Also, does it work with -ss or are the
>>>>> original filenames important?
>>>>
>>>> 50G is too big for me to even receive.
>>>>
>>>> But your dump shows the problem!
>>>>
>>>> It's not inode generation, but inode transid, which would affect send.
>>>>
>>>> This is not even checked in btrfs-progs, thus no wonder why it doesn't
>>>> detect them.
>>>>
>>>> And copy-pasted kernel message shares the same "generation" word, not
>>>> using proper transid to show the problem.
>>>>
>>>> Your dump really saved the day!
>>>>
>>>> The fix for kernel and btrfs-progs would come in next few days.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> Thanks again!
>>>>>
>>>>>
>>>>> On Tue, Aug 25, 2020 at 2:37 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 2020/8/25 下午1:25, Tyler Richmond wrote:
>>>>>>> Qu,
>>>>>>>
>>>>>>> Yes, it's btrfs-progs 5.7. Here is the result of the lowmem check:
>>>>>>>
>>>>>>> https://pastebin.com/8Tzx23EX
>>>>>>
>>>>>> That doesn't detect any inode generation problem at all, which is not a
>>>>>> good sign.
>>>>>>
>>>>>> Would you also pvode the dump for the offending block?
>>>>>>
>>>>>>> block=203510940835840 slot=4 ino=1311670, invalid inode generation:
>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>
>>>>>> For this case, would you please provide the tree dump of "203510940835840" ?
>>>>>>
>>>>>> # btrfs ins dump-tree -b 203510940835840 <device>
>>>>>>
>>>>>> And, since btrfs-image can't dump with regular extent tree, the "-w"
>>>>>> dump would also help.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>
>>>>>>> Thanks!
>>>>>>>
>>>>>>> On Mon, Aug 24, 2020 at 4:26 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2020/8/24 上午10:47, Tyler Richmond wrote:
>>>>>>>>> Qu,
>>>>>>>>>
>>>>>>>>> Finally finished another repair and captured the output.
>>>>>>>>>
>>>>>>>>> https://pastebin.com/ffcbwvd8
>>>>>>>>>
>>>>>>>>> Does that show you what you need? Or should I still do one in lowmem mode?
>>>>>>>>
>>>>>>>> Lowmem mode (no need for --repair) is recommended since original mode
>>>>>>>> doesn't detect the inode generation problem.
>>>>>>>>
>>>>>>>> And it's already btrfs-progs v5.7 right?
>>>>>>>>
>>>>>>>> THanks,
>>>>>>>> Qu
>>>>>>>>>
>>>>>>>>> Thanks for your help!
>>>>>>>>>
>>>>>>>>> On Sun, Aug 23, 2020 at 12:28 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2020/8/23 上午10:49, Tyler Richmond wrote:
>>>>>>>>>>> Well, I can guarantee that I didn't create this fs before 2015 (just
>>>>>>>>>>> checked the order confirmation from when I bought the server), but I
>>>>>>>>>>> may have just used whatever was in the Ubuntu package manager at the
>>>>>>>>>>> time. So maybe I don't have a v0 ref?
>>>>>>>>>>
>>>>>>>>>> Then btrfs-image shouldn't report that.
>>>>>>>>>>
>>>>>>>>>> There is an item smaller than any valid btrfs item, normally it means
>>>>>>>>>> it's a v0 ref.
>>>>>>>>>> If not, then it could be a bigger problem.
>>>>>>>>>>
>>>>>>>>>> Could you please provide the full btrfs-check output?
>>>>>>>>>> Also, if possible result from "btrfs check --mode=lowmem" would also help.
>>>>>>>>>>
>>>>>>>>>> Also, if you really go "--repair", then the full output would also be
>>>>>>>>>> needed to determine what's going wrong.
>>>>>>>>>> There is a report about "btrfs check --repair" didn't repair the inode
>>>>>>>>>> generation, if that's the case we must have a bug then.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Qu
>>>>>>>>>>>
>>>>>>>>>>> On Sat, Aug 22, 2020 at 10:31 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> On 2020/8/23 上午9:51, Qu Wenruo wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 2020/8/23 上午9:15, Tyler Richmond wrote:
>>>>>>>>>>>>>> Is my best bet just to downgrade the kernel and then try to delete the
>>>>>>>>>>>>>> broken files? Or should I rebuild from scratch? Just don't know
>>>>>>>>>>>>>> whether it's worth the time to try and figure this out or if the
>>>>>>>>>>>>>> problems stem from the FS being too old and it's beyond trying to
>>>>>>>>>>>>>> repair.
>>>>>>>>>>>>>
>>>>>>>>>>>>> All invalid inode generations, should be able to be repaired by latest
>>>>>>>>>>>>> btrfs-check.
>>>>>>>>>>>>>
>>>>>>>>>>>>> If not, please provide the btrfs-image dump for us to determine what's
>>>>>>>>>>>>> going wrong.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> On Tue, Aug 18, 2020 at 8:18 AM Tyler Richmond <t.d.richmond@gmail.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I didn't check dmesg during the btrfs check, but that was the only
>>>>>>>>>>>>>>> output during the rm -f before it was forced readonly. I just checked
>>>>>>>>>>>>>>> dmesg for inode generation values, and there are a lot of them.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> https://pastebin.com/stZdN0ta
>>>>>>>>>>>>>>> The dmesg output had 990 lines containing inode generation.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> However, these were at least later. I tried to do a btrfs balance
>>>>>>>>>>>>>>> -mconvert raid1 and it failed with an I/O error. That is probably what
>>>>>>>>>>>>>>> generated these specific errors, but maybe they were also happening
>>>>>>>>>>>>>>> during the btrfs repair.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> The FS is ~45TB, but the btrfs-image -c9 failed anway with:
>>>>>>>>>>>>>>> ERROR: either extent tree is corrupted or deprecated extent ref format
>>>>>>>>>>>>>>> ERROR: create failed: -5
>>>>>>>>>>>>
>>>>>>>>>>>> Oh, forgot this part.
>>>>>>>>>>>>
>>>>>>>>>>>> This means you have v0 ref?!
>>>>>>>>>>>>
>>>>>>>>>>>> Then the fs is too old, no progs/kernel support after all.
>>>>>>>>>>>>
>>>>>>>>>>>> In that case, please rollback to the last working kernel and copy your data.
>>>>>>>>>>>>
>>>>>>>>>>>> In fact, that v0 ref should only be in the code base for several weeks
>>>>>>>>>>>> before 2010, thus it's really too old.
>>>>>>>>>>>>
>>>>>>>>>>>> The good news is, with tree-checker, we should never experience such
>>>>>>>>>>>> too-old-to-be-usable problem (at least I hope so)
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks,
>>>>>>>>>>>> Qu
>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Tue, Aug 18, 2020 at 2:07 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On 2020/8/18 上午11:35, Tyler Richmond wrote:
>>>>>>>>>>>>>>>>> Qu,
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Sorry to resurrect this thread, but I just ran into something that I
>>>>>>>>>>>>>>>>> can't really just ignore. I've found a folder that is full of files
>>>>>>>>>>>>>>>>> which I guess have been broken somehow. I found a backup and restored
>>>>>>>>>>>>>>>>> them, but I want to delete this folder of broken files. But whenever I
>>>>>>>>>>>>>>>>> try, the fs is forced into readonly mode again. I just finished another
>>>>>>>>>>>>>>>>> btrfs check --repair but it didn't fix the problem.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> https://pastebin.com/eTV3s3fr
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Is that the full output?
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> No inode generation bugs?
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>   I'm already on btrfs-progs v5.7. Any new suggestions?
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Strange.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> The detection and repair should have been merged into v5.5.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> If your fs is small enough, would you please provide the "btrfs-image
>>>>>>>>>>>>>>>> -c9" dump?
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> It would contain the filenames and directories names, but doesn't
>>>>>>>>>>>>>>>> contain file contents.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>>> Qu
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On Fri, May 8, 2020 at 9:52 AM Tyler Richmond <t.d.richmond@gmail.com
>>>>>>>>>>>>>>>>> <mailto:t.d.richmond@gmail.com>> wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>      5.6.1 also failed the same way. Here's the usage output. This is the
>>>>>>>>>>>>>>>>>      part where you see I've been using RAID5 haha
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>      WARNING: RAID56 detected, not implemented
>>>>>>>>>>>>>>>>>      Overall:
>>>>>>>>>>>>>>>>>          Device size:                  60.03TiB
>>>>>>>>>>>>>>>>>          Device allocated:             98.06GiB
>>>>>>>>>>>>>>>>>          Device unallocated:           59.93TiB
>>>>>>>>>>>>>>>>>          Device missing:                  0.00B
>>>>>>>>>>>>>>>>>          Used:                         92.56GiB
>>>>>>>>>>>>>>>>>          Free (estimated):                0.00B      (min: 8.00EiB)
>>>>>>>>>>>>>>>>>          Data ratio:                       0.00
>>>>>>>>>>>>>>>>>          Metadata ratio:                   2.00
>>>>>>>>>>>>>>>>>          Global reserve:              512.00MiB      (used: 0.00B)
>>>>>>>>>>>>>>>>>          Multiple profiles:                  no
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>      Data,RAID5: Size:40.35TiB, Used:40.12TiB (99.42%)
>>>>>>>>>>>>>>>>>         /dev/sdh        8.07TiB
>>>>>>>>>>>>>>>>>         /dev/sdf        8.07TiB
>>>>>>>>>>>>>>>>>         /dev/sdg        8.07TiB
>>>>>>>>>>>>>>>>>         /dev/sdd        8.07TiB
>>>>>>>>>>>>>>>>>         /dev/sdc        8.07TiB
>>>>>>>>>>>>>>>>>         /dev/sde        8.07TiB
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>      Metadata,RAID1: Size:49.00GiB, Used:46.28GiB (94.44%)
>>>>>>>>>>>>>>>>>         /dev/sdh       34.00GiB
>>>>>>>>>>>>>>>>>         /dev/sdf       32.00GiB
>>>>>>>>>>>>>>>>>         /dev/sdg       32.00GiB
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>      System,RAID1: Size:32.00MiB, Used:2.20MiB (6.87%)
>>>>>>>>>>>>>>>>>         /dev/sdf       32.00MiB
>>>>>>>>>>>>>>>>>         /dev/sdg       32.00MiB
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>      Unallocated:
>>>>>>>>>>>>>>>>>         /dev/sdh        2.81TiB
>>>>>>>>>>>>>>>>>         /dev/sdf        2.81TiB
>>>>>>>>>>>>>>>>>         /dev/sdg        2.81TiB
>>>>>>>>>>>>>>>>>         /dev/sdd        1.03TiB
>>>>>>>>>>>>>>>>>         /dev/sdc        1.03TiB
>>>>>>>>>>>>>>>>>         /dev/sde        1.03TiB
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>      On Fri, May 8, 2020 at 1:47 AM Qu Wenruo <quwenruo.btrfs@gmx.com
>>>>>>>>>>>>>>>>>      <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>      >
>>>>>>>>>>>>>>>>>      >
>>>>>>>>>>>>>>>>>      >
>>>>>>>>>>>>>>>>>      > On 2020/5/8 下午1:12, Tyler Richmond wrote:
>>>>>>>>>>>>>>>>>      > > If this is saying there's no extra space for metadata, is that why
>>>>>>>>>>>>>>>>>      > > adding more files often makes the system hang for 30-90s? Is there
>>>>>>>>>>>>>>>>>      > > anything I should do about that?
>>>>>>>>>>>>>>>>>      >
>>>>>>>>>>>>>>>>>      > I'm not sure about the hang though.
>>>>>>>>>>>>>>>>>      >
>>>>>>>>>>>>>>>>>      > It would be nice to give more info to diagnosis.
>>>>>>>>>>>>>>>>>      > The output of 'btrfs fi usage' is useful for space usage problem.
>>>>>>>>>>>>>>>>>      >
>>>>>>>>>>>>>>>>>      > But the common idea is, to keep at 1~2 Gi unallocated (not avaiable
>>>>>>>>>>>>>>>>>      > space in vanilla df command) space for btrfs.
>>>>>>>>>>>>>>>>>      >
>>>>>>>>>>>>>>>>>      > Thanks,
>>>>>>>>>>>>>>>>>      > Qu
>>>>>>>>>>>>>>>>>      >
>>>>>>>>>>>>>>>>>      > >
>>>>>>>>>>>>>>>>>      > > Thank you so much for all of your help. I love how flexible BTRFS is
>>>>>>>>>>>>>>>>>      > > but when things go wrong it's very hard for me to troubleshoot.
>>>>>>>>>>>>>>>>>      > >
>>>>>>>>>>>>>>>>>      > > On Fri, May 8, 2020 at 1:07 AM Qu Wenruo <quwenruo.btrfs@gmx.com
>>>>>>>>>>>>>>>>>      <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>      > >>
>>>>>>>>>>>>>>>>>      > >>
>>>>>>>>>>>>>>>>>      > >>
>>>>>>>>>>>>>>>>>      > >> On 2020/5/8 下午12:23, Tyler Richmond wrote:
>>>>>>>>>>>>>>>>>      > >>> Something went wrong:
>>>>>>>>>>>>>>>>>      > >>>
>>>>>>>>>>>>>>>>>      > >>> Reinitialize checksum tree
>>>>>>>>>>>>>>>>>      > >>> Unable to find block group for 0
>>>>>>>>>>>>>>>>>      > >>> Unable to find block group for 0
>>>>>>>>>>>>>>>>>      > >>> Unable to find block group for 0
>>>>>>>>>>>>>>>>>      > >>> ctree.c:2272: split_leaf: BUG_ON `1` triggered, value 1
>>>>>>>>>>>>>>>>>      > >>> btrfs(+0x6dd94)[0x55a933af7d94]
>>>>>>>>>>>>>>>>>      > >>> btrfs(+0x71b94)[0x55a933afbb94]
>>>>>>>>>>>>>>>>>      > >>> btrfs(btrfs_search_slot+0x11f0)[0x55a933afd6c8]
>>>>>>>>>>>>>>>>>      > >>> btrfs(btrfs_csum_file_block+0x432)[0x55a933b19d09]
>>>>>>>>>>>>>>>>>      > >>> btrfs(+0x360b2)[0x55a933ac00b2]
>>>>>>>>>>>>>>>>>      > >>> btrfs(+0x46a3e)[0x55a933ad0a3e]
>>>>>>>>>>>>>>>>>      > >>> btrfs(main+0x98)[0x55a933a9fe88]
>>>>>>>>>>>>>>>>>      > >>>
>>>>>>>>>>>>>>>>>      /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf3)[0x7f263ed550b3]
>>>>>>>>>>>>>>>>>      > >>> btrfs(_start+0x2e)[0x55a933a9fa0e]
>>>>>>>>>>>>>>>>>      > >>> Aborted
>>>>>>>>>>>>>>>>>      > >>
>>>>>>>>>>>>>>>>>      > >> This means no space for extra metadata...
>>>>>>>>>>>>>>>>>      > >>
>>>>>>>>>>>>>>>>>      > >> Anyway the csum tree problem shouldn't be a big thing, you
>>>>>>>>>>>>>>>>>      could leave
>>>>>>>>>>>>>>>>>      > >> it and call it a day.
>>>>>>>>>>>>>>>>>      > >>
>>>>>>>>>>>>>>>>>      > >> BTW, as long as btrfs check reports no extra problem for the inode
>>>>>>>>>>>>>>>>>      > >> generation, it should be pretty safe to use the fs.
>>>>>>>>>>>>>>>>>      > >>
>>>>>>>>>>>>>>>>>      > >> Thanks,
>>>>>>>>>>>>>>>>>      > >> Qu
>>>>>>>>>>>>>>>>>      > >>>
>>>>>>>>>>>>>>>>>      > >>> I just noticed I have btrfs-progs 5.6 installed and 5.6.1 is
>>>>>>>>>>>>>>>>>      > >>> available. I'll let that try overnight?
>>>>>>>>>>>>>>>>>      > >>>
>>>>>>>>>>>>>>>>>      > >>> On Thu, May 7, 2020 at 8:11 PM Qu Wenruo
>>>>>>>>>>>>>>>>>      <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>      > >>>>
>>>>>>>>>>>>>>>>>      > >>>>
>>>>>>>>>>>>>>>>>      > >>>>
>>>>>>>>>>>>>>>>>      > >>>> On 2020/5/7 下午11:52, Tyler Richmond wrote:
>>>>>>>>>>>>>>>>>      > >>>>> Thank you for helping. The end result of the scan was:
>>>>>>>>>>>>>>>>>      > >>>>>
>>>>>>>>>>>>>>>>>      > >>>>>
>>>>>>>>>>>>>>>>>      > >>>>> [1/7] checking root items
>>>>>>>>>>>>>>>>>      > >>>>> [2/7] checking extents
>>>>>>>>>>>>>>>>>      > >>>>> [3/7] checking free space cache
>>>>>>>>>>>>>>>>>      > >>>>> [4/7] checking fs roots
>>>>>>>>>>>>>>>>>      > >>>>
>>>>>>>>>>>>>>>>>      > >>>> Good news is, your fs is still mostly fine.
>>>>>>>>>>>>>>>>>      > >>>>
>>>>>>>>>>>>>>>>>      > >>>>> [5/7] checking only csums items (without verifying data)
>>>>>>>>>>>>>>>>>      > >>>>> there are no extents for csum range 0-69632
>>>>>>>>>>>>>>>>>      > >>>>> csum exists for 0-69632 but there is no extent record
>>>>>>>>>>>>>>>>>      > >>>>> ...
>>>>>>>>>>>>>>>>>      > >>>>> ...
>>>>>>>>>>>>>>>>>      > >>>>> there are no extents for csum range 946692096-946827264
>>>>>>>>>>>>>>>>>      > >>>>> csum exists for 946692096-946827264 but there is no extent
>>>>>>>>>>>>>>>>>      record
>>>>>>>>>>>>>>>>>      > >>>>> there are no extents for csum range 946831360-947912704
>>>>>>>>>>>>>>>>>      > >>>>> csum exists for 946831360-947912704 but there is no extent
>>>>>>>>>>>>>>>>>      record
>>>>>>>>>>>>>>>>>      > >>>>> ERROR: errors found in csum tree
>>>>>>>>>>>>>>>>>      > >>>>
>>>>>>>>>>>>>>>>>      > >>>> Only extent tree is corrupted.
>>>>>>>>>>>>>>>>>      > >>>>
>>>>>>>>>>>>>>>>>      > >>>> Normally btrfs check --init-csum-tree should be able to
>>>>>>>>>>>>>>>>>      handle it.
>>>>>>>>>>>>>>>>>      > >>>>
>>>>>>>>>>>>>>>>>      > >>>> But still, please be sure you're using the latest btrfs-progs
>>>>>>>>>>>>>>>>>      to fix it.
>>>>>>>>>>>>>>>>>      > >>>>
>>>>>>>>>>>>>>>>>      > >>>> Thanks,
>>>>>>>>>>>>>>>>>      > >>>> Qu
>>>>>>>>>>>>>>>>>      > >>>>
>>>>>>>>>>>>>>>>>      > >>>>> [6/7] checking root refs
>>>>>>>>>>>>>>>>>      > >>>>> [7/7] checking quota groups skipped (not enabled on this FS)
>>>>>>>>>>>>>>>>>      > >>>>> found 44157956026368 bytes used, error(s) found
>>>>>>>>>>>>>>>>>      > >>>>> total csum bytes: 42038602716
>>>>>>>>>>>>>>>>>      > >>>>> total tree bytes: 49688616960
>>>>>>>>>>>>>>>>>      > >>>>> total fs tree bytes: 1256427520
>>>>>>>>>>>>>>>>>      > >>>>> total extent tree bytes: 1709105152
>>>>>>>>>>>>>>>>>      > >>>>> btree space waste bytes: 3172727316
>>>>>>>>>>>>>>>>>      > >>>>> file data blocks allocated: 261625653436416
>>>>>>>>>>>>>>>>>      > >>>>>  referenced 47477768499200
>>>>>>>>>>>>>>>>>      > >>>>>
>>>>>>>>>>>>>>>>>      > >>>>> What do I need to do to fix all of this?
>>>>>>>>>>>>>>>>>      > >>>>>
>>>>>>>>>>>>>>>>>      > >>>>> On Thu, May 7, 2020 at 1:52 AM Qu Wenruo
>>>>>>>>>>>>>>>>>      <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>      > >>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>> On 2020/5/7 下午1:43, Tyler Richmond wrote:
>>>>>>>>>>>>>>>>>      > >>>>>>> Well, the repair doesn't look terribly successful.
>>>>>>>>>>>>>>>>>      > >>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>> parent transid verify failed on 218620880703488 wanted
>>>>>>>>>>>>>>>>>      6875841 found 6876224
>>>>>>>>>>>>>>>>>      > >>>>>>> parent transid verify failed on 218620880703488 wanted
>>>>>>>>>>>>>>>>>      6875841 found 6876224
>>>>>>>>>>>>>>>>>      > >>>>>>> parent transid verify failed on 218620880703488 wanted
>>>>>>>>>>>>>>>>>      6875841 found 6876224
>>>>>>>>>>>>>>>>>      > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>      > >>>>>>> ERROR: child eb corrupted: parent bytenr=225049956061184
>>>>>>>>>>>>>>>>>      item=84
>>>>>>>>>>>>>>>>>      > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>      > >>>>>>>                                             child level=4
>>>>>>>>>>>>>>>>>      > >>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>> This means there are more problems, not only the hash name
>>>>>>>>>>>>>>>>>      mismatch.
>>>>>>>>>>>>>>>>>      > >>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>> This means the fs is already corrupted, the name hash is
>>>>>>>>>>>>>>>>>      just one
>>>>>>>>>>>>>>>>>      > >>>>>> unrelated symptom.
>>>>>>>>>>>>>>>>>      > >>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>> The only good news is, btrfs-progs abort the transaction,
>>>>>>>>>>>>>>>>>      thus no
>>>>>>>>>>>>>>>>>      > >>>>>> further damage to the fs.
>>>>>>>>>>>>>>>>>      > >>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>> Please run a plain btrfs-check to show what's the problem
>>>>>>>>>>>>>>>>>      first.
>>>>>>>>>>>>>>>>>      > >>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>> Thanks,
>>>>>>>>>>>>>>>>>      > >>>>>> Qu
>>>>>>>>>>>>>>>>>      > >>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>> parent transid verify failed on 218620880703488 wanted
>>>>>>>>>>>>>>>>>      6875841 found 6876224
>>>>>>>>>>>>>>>>>      > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>      > >>>>>>> ERROR: child eb corrupted: parent bytenr=225049956061184
>>>>>>>>>>>>>>>>>      item=84
>>>>>>>>>>>>>>>>>      > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>      > >>>>>>>                                             child level=4
>>>>>>>>>>>>>>>>>      > >>>>>>> parent transid verify failed on 218620880703488 wanted
>>>>>>>>>>>>>>>>>      6875841 found 6876224
>>>>>>>>>>>>>>>>>      > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>      > >>>>>>> ERROR: child eb corrupted: parent bytenr=225049956061184
>>>>>>>>>>>>>>>>>      item=84
>>>>>>>>>>>>>>>>>      > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>      > >>>>>>>                                             child level=4
>>>>>>>>>>>>>>>>>      > >>>>>>> parent transid verify failed on 218620880703488 wanted
>>>>>>>>>>>>>>>>>      6875841 found 6876224
>>>>>>>>>>>>>>>>>      > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>      > >>>>>>> ERROR: child eb corrupted: parent bytenr=225049956061184
>>>>>>>>>>>>>>>>>      item=84
>>>>>>>>>>>>>>>>>      > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>      > >>>>>>>                                             child level=4
>>>>>>>>>>>>>>>>>      > >>>>>>> parent transid verify failed on 218620880703488 wanted
>>>>>>>>>>>>>>>>>      6875841 found 6876224
>>>>>>>>>>>>>>>>>      > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>      > >>>>>>> ERROR: child eb corrupted: parent bytenr=225049956061184
>>>>>>>>>>>>>>>>>      item=84
>>>>>>>>>>>>>>>>>      > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>      > >>>>>>>                                             child level=4
>>>>>>>>>>>>>>>>>      > >>>>>>> parent transid verify failed on 218620880703488 wanted
>>>>>>>>>>>>>>>>>      6875841 found 6876224
>>>>>>>>>>>>>>>>>      > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>      > >>>>>>> ERROR: child eb corrupted: parent bytenr=225049956061184
>>>>>>>>>>>>>>>>>      item=84
>>>>>>>>>>>>>>>>>      > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>      > >>>>>>>                                             child level=4
>>>>>>>>>>>>>>>>>      > >>>>>>> parent transid verify failed on 218620880703488 wanted
>>>>>>>>>>>>>>>>>      6875841 found 6876224
>>>>>>>>>>>>>>>>>      > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>      > >>>>>>> ERROR: child eb corrupted: parent bytenr=225049956061184
>>>>>>>>>>>>>>>>>      item=84
>>>>>>>>>>>>>>>>>      > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>      > >>>>>>>                                             child level=4
>>>>>>>>>>>>>>>>>      > >>>>>>> parent transid verify failed on 218620880703488 wanted
>>>>>>>>>>>>>>>>>      6875841 found 6876224
>>>>>>>>>>>>>>>>>      > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>      > >>>>>>> ERROR: child eb corrupted: parent bytenr=225049956061184
>>>>>>>>>>>>>>>>>      item=84
>>>>>>>>>>>>>>>>>      > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>      > >>>>>>>                                             child level=4
>>>>>>>>>>>>>>>>>      > >>>>>>> parent transid verify failed on 218620880703488 wanted
>>>>>>>>>>>>>>>>>      6875841 found 6876224
>>>>>>>>>>>>>>>>>      > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>      > >>>>>>> ERROR: child eb corrupted: parent bytenr=225049956061184
>>>>>>>>>>>>>>>>>      item=84
>>>>>>>>>>>>>>>>>      > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>      > >>>>>>>                                             child level=4
>>>>>>>>>>>>>>>>>      > >>>>>>> parent transid verify failed on 218620880703488 wanted
>>>>>>>>>>>>>>>>>      6875841 found 6876224
>>>>>>>>>>>>>>>>>      > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>      > >>>>>>> ERROR: child eb corrupted: parent bytenr=225049956061184
>>>>>>>>>>>>>>>>>      item=84
>>>>>>>>>>>>>>>>>      > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>      > >>>>>>>                                             child level=4
>>>>>>>>>>>>>>>>>      > >>>>>>> parent transid verify failed on 218620880703488 wanted
>>>>>>>>>>>>>>>>>      6875841 found 6876224
>>>>>>>>>>>>>>>>>      > >>>>>>> Ignoring transid failure
>>>>>>>>>>>>>>>>>      > >>>>>>> ERROR: child eb corrupted: parent bytenr=225049956061184
>>>>>>>>>>>>>>>>>      item=84
>>>>>>>>>>>>>>>>>      > >>>>>>> parent level=1
>>>>>>>>>>>>>>>>>      > >>>>>>>                                             child level=4
>>>>>>>>>>>>>>>>>      > >>>>>>> ERROR: failed to zero log tree: -17
>>>>>>>>>>>>>>>>>      > >>>>>>> ERROR: attempt to start transaction over already running one
>>>>>>>>>>>>>>>>>      > >>>>>>> WARNING: reserved space leaked, flag=0x4 bytes_reserved=4096
>>>>>>>>>>>>>>>>>      > >>>>>>> extent buffer leak: start 225049066086400 len 4096
>>>>>>>>>>>>>>>>>      > >>>>>>> extent buffer leak: start 225049066086400 len 4096
>>>>>>>>>>>>>>>>>      > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>>>>>>>>>>>>>>>>>      225049066086400 len 4096
>>>>>>>>>>>>>>>>>      > >>>>>>> extent buffer leak: start 225049066094592 len 4096
>>>>>>>>>>>>>>>>>      > >>>>>>> extent buffer leak: start 225049066094592 len 4096
>>>>>>>>>>>>>>>>>      > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>>>>>>>>>>>>>>>>>      225049066094592 len 4096
>>>>>>>>>>>>>>>>>      > >>>>>>> extent buffer leak: start 225049066102784 len 4096
>>>>>>>>>>>>>>>>>      > >>>>>>> extent buffer leak: start 225049066102784 len 4096
>>>>>>>>>>>>>>>>>      > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>>>>>>>>>>>>>>>>>      225049066102784 len 4096
>>>>>>>>>>>>>>>>>      > >>>>>>> extent buffer leak: start 225049066131456 len 4096
>>>>>>>>>>>>>>>>>      > >>>>>>> extent buffer leak: start 225049066131456 len 4096
>>>>>>>>>>>>>>>>>      > >>>>>>> WARNING: dirty eb leak (aborted trans): start
>>>>>>>>>>>>>>>>>      225049066131456 len 4096
>>>>>>>>>>>>>>>>>      > >>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>> What is going on?
>>>>>>>>>>>>>>>>>      > >>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>> On Wed, May 6, 2020 at 9:30 PM Tyler Richmond
>>>>>>>>>>>>>>>>>      <t.d.richmond@gmail.com <mailto:t.d.richmond@gmail.com>> wrote:
>>>>>>>>>>>>>>>>>      > >>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>> Chris, I had used the correct mountpoint in the command.
>>>>>>>>>>>>>>>>>      I just edited
>>>>>>>>>>>>>>>>>      > >>>>>>>> it in the email to be /mountpoint for consistency.
>>>>>>>>>>>>>>>>>      > >>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>> Qu, I'll try the repair. Fingers crossed!
>>>>>>>>>>>>>>>>>      > >>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>> On Wed, May 6, 2020 at 9:13 PM Qu Wenruo
>>>>>>>>>>>>>>>>>      <quwenruo.btrfs@gmx.com <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>>>>>>>>>>>>>>>      > >>>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>>> On 2020/5/7 上午5:54, Tyler Richmond wrote:
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> Hello,
>>>>>>>>>>>>>>>>>      > >>>>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> I looked up this error and it basically says ask a
>>>>>>>>>>>>>>>>>      developer to
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> determine if it's a false error or not. I just started
>>>>>>>>>>>>>>>>>      getting some
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> slow response times, and looked at the dmesg log to
>>>>>>>>>>>>>>>>>      find a ton of
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> these errors.
>>>>>>>>>>>>>>>>>      > >>>>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> [192088.446299] BTRFS critical (device sdh): corrupt
>>>>>>>>>>>>>>>>>      leaf: root=5
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> block=203510940835840 slot=4 ino=1311670, invalid inode
>>>>>>>>>>>>>>>>>      generation:
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> [192088.449823] BTRFS error (device sdh):
>>>>>>>>>>>>>>>>>      block=203510940835840 read
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> time tree block corruption detected
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> [192088.459238] BTRFS critical (device sdh): corrupt
>>>>>>>>>>>>>>>>>      leaf: root=5
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> block=203510940835840 slot=4 ino=1311670, invalid inode
>>>>>>>>>>>>>>>>>      generation:
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> [192088.462773] BTRFS error (device sdh):
>>>>>>>>>>>>>>>>>      block=203510940835840 read
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> time tree block corruption detected
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> [192088.464711] BTRFS critical (device sdh): corrupt
>>>>>>>>>>>>>>>>>      leaf: root=5
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> block=203510940835840 slot=4 ino=1311670, invalid inode
>>>>>>>>>>>>>>>>>      generation:
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> has 18446744073709551492 expect [0, 6875827]
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> [192088.468457] BTRFS error (device sdh):
>>>>>>>>>>>>>>>>>      block=203510940835840 read
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> time tree block corruption detected
>>>>>>>>>>>>>>>>>      > >>>>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> btrfs device stats, however, doesn't show any errors.
>>>>>>>>>>>>>>>>>      > >>>>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> Is there anything I should do about this, or should I
>>>>>>>>>>>>>>>>>      just continue
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> using my array as normal?
>>>>>>>>>>>>>>>>>      > >>>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>>> This is caused by older kernel underflow inode generation.
>>>>>>>>>>>>>>>>>      > >>>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>>> Latest btrfs-progs can fix it, using btrfs check --repair.
>>>>>>>>>>>>>>>>>      > >>>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>>> Or you can go safer, by manually locating the inode
>>>>>>>>>>>>>>>>>      using its inode
>>>>>>>>>>>>>>>>>      > >>>>>>>>> number (1311670), and copy it to some new location using
>>>>>>>>>>>>>>>>>      previous
>>>>>>>>>>>>>>>>>      > >>>>>>>>> working kernel, then delete the old file, copy the new
>>>>>>>>>>>>>>>>>      one back to fix it.
>>>>>>>>>>>>>>>>>      > >>>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>>> Thanks,
>>>>>>>>>>>>>>>>>      > >>>>>>>>> Qu
>>>>>>>>>>>>>>>>>      > >>>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>>>> Thank you!
>>>>>>>>>>>>>>>>>      > >>>>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>>>>
>>>>>>>>>>>>>>>>>      > >>>>>>
>>>>>>>>>>>>>>>>>      > >>>>
>>>>>>>>>>>>>>>>>      > >>
>>>>>>>>>>>>>>>>>      >
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>
>>>>>>
>>>>
> 


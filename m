Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3D267FF2
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2019 17:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfGNPpH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 14 Jul 2019 11:45:07 -0400
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:50329 "EHLO
        6.mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbfGNPpH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 14 Jul 2019 11:45:07 -0400
X-Greylist: delayed 4200 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jul 2019 11:45:06 EDT
Received: from player715.ha.ovh.net (unknown [10.108.35.12])
        by mo5.mail-out.ovh.net (Postfix) with ESMTP id 214B9243506
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Jul 2019 14:07:40 +0200 (CEST)
Received: from awhome.eu (p4FF91F5A.dip0.t-ipconnect.de [79.249.31.90])
        (Authenticated sender: postmaster@awhome.eu)
        by player715.ha.ovh.net (Postfix) with ESMTPSA id 48AC77BB4826;
        Sun, 14 Jul 2019 12:07:37 +0000 (UTC)
Subject: Re: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
        wqu@suse.com
References: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
 <23f33860-9630-2045-483c-f59ebf91b043@gmx.com>
 <057a7561-f691-d7ee-1dea-27acc5ea79cc@web.de>
 <6e764f38-a8dd-19e2-e885-3d7561479681@gmx.com>
From:   Alexander Wetzel <alexander.wetzel@web.de>
Message-ID: <e2776741-3554-e9a6-440a-4bfe8a839cbb@web.de>
Date:   Sun, 14 Jul 2019 14:07:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6e764f38-a8dd-19e2-e885-3d7561479681@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 1948651267023389934
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrheehgdehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 14.07.19 um 11:49 schrieb Qu Wenruo:
> 
> 
> On 2019/7/14 下午5:25, Alexander Wetzel wrote:
>>
>>>>
>>>> filtering for btrfs and removing duplicate lines just shows three uniq
>>>> error messages:
>>>>    BTRFS critical (device vda3): corrupt leaf: root=300 block=8645398528
>>>> slot=4 ino=259223, invalid inode generation: has 139737289170944 expect
>>>> [0, 1425224]
>>>>    BTRFS critical (device vda3): corrupt leaf: root=300 block=8645398528
>>>> slot=4 ino=259223, invalid inode generation: has 139737289170944 expect
>>>> [0, 1425225]
>>>>    BTRFS critical (device vda3): corrupt leaf: root=300 block=8645398528
>>>> slot=4 ino=259223, invalid inode generation: has 139737289170944 expect
>>>> [0, 1425227]
>>>
>>> The generation number is 0x7f171f7ba000, I see no reason why it would
>>> make any sense.
>>>
>>> I see no problem rejecting obviously corrupted item.
>>>
>>> The problem is:
>>> - Is that corrupted item?
>>>     At least to me, it looks corrupted just from the dmesg.
>>>
>>> - How and when this happens
>>>     Obviously happened on some older kernel.
>>>     V5.2 will report such problem before writing corrupted data back to
>>>     disk, at least prevent such problem from happening.
>>
>> It's probably useless information at that point, but the FS was created
>> with a boot image from Debian 8 around Dec 1st 2016 by migrating an also
>> freshly created ext4 filesystem to btrfs.
> 
> Migrated image could has something unexpected, but according to the
> owner id, it's definitely not the converted subvolume. But newly created
> subvolume/snapshot.
> 

Yes, I'm using snapshots and I've added subvolumes after the migration. 
Basically I moved everything from root into a subvolume. But not sure 
which procedure I used back then... I think I created a snapshot of old 
root and then deleted all files/dirs in root with the exception of the 
snapshot. Now I would have said that I did that under the 4.7.10 kernel, 
but it's long ago and there may have been some complications.

>> I'm pretty sure the migration failed with the newer gentoo kernel
>> intended for operation - which was sys-kernel/hardened-sources-4.7.10 -
>> and a used the Debian boot image for that. (I can piece together all
>> kernel versions used from wtmp, but the Debian boot kernel would be
>> "guess only".)
>>
>> The time stamps like "2016-12-01 21:51:27" in the dump below are
>> matching very well to the time I was setting up the system based on the
>> few remaining log evidence I have.
> 
> I just did a quick grep and blame for inode transid related code.
> The latest direct modification to inode_transid is 6e17d30bfaf4 ("Btrfs:
> fill ->last_trans for delayed inode in btrfs_fill_inode."), which is
> upstreamed in v4.1.
> 
> Furthermore, at that time, we don't have good enough practice for
> backport, thus that commit lacks fixes tag, and won't be backported to
> most stable branches.
> I don't believe Debian backport team would pick this into their kernels,
> so if the fs is modified by kernel older than v4.1, then that may be the
> cause.

Sounds plausible, the Debian 8 boot image used for migration probably 
was using a 3.16 kernel. So this version did touch the FS and this may 
be some left overs.
Especially since I have multiple very similar VMs which are working 
fine. (The broken one is the only one hosted in a VPS, forcing me to use 
whatever the provider had at the time to jump start the system. All the 
other VMs - most of them older by some years - are working with 5.2.)

Long story short: I guess we can assume it was something I did on the FS 
while running a 3.16 kernel and the new checks are now complaining about.

> 
>>
>>> Please provide the following dump:
>>>    # btrfs ins dump-tree -b 8645398528 /dev/vda3
>>>
>>
>> xar /home/alex # btrfs ins dump-tree -b 8645398528 /dev/vda3
>> btrfs-progs v4.19
>> leaf 8645398528 items 48 free space 509 generation 1425074 owner 300
>> leaf 8645398528 flags 0x1(WRITTEN) backref revision 1
>> fs uuid 668c885e-50b9-41d0-a3ce-b653a4d3f87a
>> chunk uuid 54c6809b-e261-423f-b4a1-362304e887bd
>>          item 0 key (259222 DIR_ITEM 2504220146) itemoff 3960 itemsize 35
>>                  location key (259223 INODE_ITEM 0) type FILE
>>                  transid 8119256875011 data_len 0 name_len 5
>>                  name: .keep
> 
> If we're checking DIR_ITEM/DIR_INDEX transid, it kernel should fail even
> easier.
> 
> Those transid makes no sense at all.
> 
>>          item 1 key (259222 DIR_INDEX 2) itemoff 3925 itemsize 35
>>                  location key (259223 INODE_ITEM 0) type FILE
>>                  transid 8119256875011 data_len 0 name_len 5
>>                  name: .keep
>>          item 2 key (259222 DIR_INDEX 3) itemoff 3888 itemsize 37
>>                  location key (258830 INODE_ITEM 0) type DIR
>>                  transid 2673440063491 data_len 0 name_len 7
>>                  name: portage
>>          item 3 key (259222 DIR_INDEX 4) itemoff 3851 itemsize 37
>>                  location key (3632036 INODE_ITEM 0) type DIR
>>                  transid 169620 data_len 0 name_len 7
>>                  name: binpkgs
>>          item 4 key (259223 INODE_ITEM 0) itemoff 3691 itemsize 160
>>                  generation 1 transid 139737289170944 size 0 nbytes 0
>>                  block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
>>                  sequence 139737289225400 flags 0x0(none)
> 
> Either the reported transid makes sense.
> 
>>                  atime 1480625487.0 (2016-12-01 21:51:27)
>>                  ctime 1480625487.0 (2016-12-01 21:51:27)
>>                  mtime 1480015482.0 (2016-11-24 20:24:42)
>>                  otime 0.0 (1970-01-01 01:00:00)
>>          item 5 key (259223 INODE_REF 259222) itemoff 3676 itemsize 15
>>                  index 2 namelen 5 name: .keep
>>          item 6 key (259224 INODE_ITEM 0) itemoff 3516 itemsize 160
>>                  generation 1 transid 1733 size 4 nbytes 5
> 
> This transid shold be correct.
> 
> According to the leaf geneartion, any transid larger than 1425074 should
> be incorrect.
> 
> So, the are a lot of transid error, not limited to the reported item 4.
> There may be so many transid error that most of your tree blocks may get
> modified to update the transid.
> 
> To fix this, I believe it's possible to reset all these inodes' transid
> to leaf transid, but I'm not 100% sure if such fix won't affect things
> like send.
> 
> 
> I totally understand that the solution I'm going to provide sounds
> aweful, but I'd recommend to use a newer enough kernel but without that
> check, to copy all the data to another btrfs fs.
>  > It could be more safe than waiting for a btrfs check to repair it.

No problem for me. This report here was created for science only:-)
I just wanted to your attention prior to destroying the broken FS and 
shredding potential useful data useful to track down what went wrong.
With that now concluded I'll just do that!

But maybe one additional remark: The snapshots transferred via btrfs 
send/receive to another PC are working fine on a system using a 5.2 
kernel. Since the "moved" subvolume also does not have the block 
8645398528 I assume I don't really have to copy the files but restoring 
the subvolume with btrfs receive on a new btrfs image will also get rid 
of the errors.

Thanks for your time, the incredible fast feedback and your help,

Alexander

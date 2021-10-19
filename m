Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9589143347D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Oct 2021 13:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbhJSLSL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Oct 2021 07:18:11 -0400
Received: from 17.mo561.mail-out.ovh.net ([87.98.178.58]:55215 "EHLO
        17.mo561.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbhJSLSK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Oct 2021 07:18:10 -0400
X-Greylist: delayed 1095 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Oct 2021 07:18:10 EDT
Received: from player791.ha.ovh.net (unknown [10.109.156.29])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 379CA23195
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Oct 2021 10:57:41 +0000 (UTC)
Received: from RCM-web2.webmail.mail.ovh.net (89-64-40-92.dynamic.chello.pl [89.64.40.92])
        (Authenticated sender: mailing@dmilz.net)
        by player791.ha.ovh.net (Postfix) with ESMTPSA id 09C8C234FF9A3;
        Tue, 19 Oct 2021 10:57:39 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 19 Oct 2021 12:57:39 +0200
From:   mailing@dmilz.net
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Filesystem Read Only due to errno=-28 during metadata allocation
In-Reply-To: <20211018140936.GA1208@hungrycats.org>
References: <f2ed8b05b03db6a4fec4cba7ed17222a@dmilz.net>
 <20211018140936.GA1208@hungrycats.org>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <aefefca716de925195a0190a8d583a1d@dmilz.net>
X-Sender: mailing@dmilz.net
X-Originating-IP: 89.64.40.92
X-Webmail-UserID: mailing@dmilz.net
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11863888797645929077
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvvddgfedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeggfffhvffujghffgfkgihitgfgsehtjehjtddtredvnecuhfhrohhmpehmrghilhhinhhgsegumhhilhiirdhnvghtnecuggftrfgrthhtvghrnhepueekveetkeelgefgjeekheekteeugefgvedtgfehudfggeelkeeuuddugfeugfelnecukfhppedtrddtrddtrddtpdekledrieegrdegtddrledvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeluddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehmrghilhhinhhgsegumhhilhiirdhnvghtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 18.10.2021 16:09, Zygo Blaxell wrote:
> On Wed, Oct 13, 2021 at 02:35:39PM +0200, mailing@dmilz.net wrote:
>> Hello,
>> 
>> I faced issue with btrfs FS /var forced to RO due to errno=-28 (no 
>> space
>> left).
>> 
>> The server was restarted to bring back FS in RW.
>> 
>> Before reboot:
>> $ btrfs fi usage /var -m
>> Overall:
>>     Device size:         2560.00MiB
>>     Device allocated:         2559.00MiB
>>     Device unallocated:            1.00MiB
>>     Device missing:            0.00MiB
>>     Used:         1116.00MiB
>>     Free (estimated):          451.25MiB (min: 451.25MiB)
>>     Data ratio:               1.00
>>     Metadata ratio:               2.00
>>     Global reserve:           13.00MiB (used: 0.00MiB)
>> 
>> Data,single: Size:1559.25MiB, Used:1108.00MiB
>>    /dev/mapper/rootvg-varvol 1559.25MiB
>> 
>> Metadata,DUP: Size:467.88MiB, Used:3.94MiB
>>    /dev/mapper/rootvg-varvol  935.75MiB
>> 
>> System,DUP: Size:32.00MiB, Used:0.06MiB
>>    /dev/mapper/rootvg-varvol   64.00MiB
>> 
>> Unallocated:
>>    /dev/mapper/rootvg-varvol    1.00MiB
> 
> This is a tiny filesystem, below the minimum practical size for 
> separate
> data and metadata block groups, but above the size for mixed block
> groups to be the mkfs default.  It might be better to format it with
> the mixed-bg option.
> 
>> The FS went RO on Sunday, with this trace:
>> 2021-10-10T00:13:12.790042+02:00 SERVERNAME kernel: BTRFS: Transaction
>> aborted (error -28)
> [...]
>> 2021-10-10T00:13:12.790124+02:00 SERVERNAME kernel: BTRFS: error 
>> (device
>> dm-22) in btrfs_run_delayed_refs:2353: errno=-28 No space left
>> 2021-10-10T00:13:12.790125+02:00 SERVERNAME kernel: btrfs_printk: 12
>> callbacks suppressed
>> 2021-10-10T00:13:12.790127+02:00 SERVERNAME kernel: BTRFS info (device
>> dm-22): forced readonly
>> 
>> $ btrfs --version
>> btrfs-progs v4.5.3+20160729
>> 
>> $ btrfs fi show /var
>> Label: none  uuid: f96f4980-4682-4d2d-8d7a-3c0e2c1c6680
>>         Total devices 1 FS bytes used 1.06GiB
>>         devid    1 size 2.50GiB used 2.50GiB path 
>> /dev/mapper/rootvg-varvol
>> 
>> uname -a
>> Linux SERVERNAME 4.12.14-122.83-default #1 SMP Tue Aug 3 08:37:22 UTC 
>> 2021
>> (c86c48c) ppc64le ppc64le ppc64le GNU/Linux
> 
> This kernel is 4 years old.  It may have additional practical problems 
> in
> the implementation beyond the design-level issues I've described here.
> 
>> On the previous Friday after weekly balance:
>> btrfs fi usage /var
>> Overall:
>>     Device size:                   2.50GiB
>>     Device allocated:              1.73GiB
>>     Device unallocated:          792.75MiB
>>     Device missing:                  0.00B
>>     Used:                          1.09GiB
>>     Free (estimated):              1.11GiB      (min: 739.62MiB)
>>     Data ratio:                       1.00
>>     Metadata ratio:                   2.00
>>     Global reserve:               13.00MiB      (used: 0.00B)
>> 
>> Data,single: Size:1.41GiB, Used:1.08GiB
>>    /dev/mapper/rootvg-varvol       1.41GiB
>> 
>> Metadata,DUP: Size:128.00MiB, Used:3.94MiB
>>    /dev/mapper/rootvg-varvol     256.00MiB
>> 
>> System,DUP: Size:32.00MiB, Used:64.00KiB
>>    /dev/mapper/rootvg-varvol      64.00MiB
>> 
>> Unallocated:
>>    /dev/mapper/rootvg-varvol     792.75MiB
>> 
>> 
>> I don't have extract of btrfs fi usage /var command during the 
>> weekend, but
>> a script is extracting the Space allocated ("Size") and Used in Data 
>> and
>> Metadata. I observed twice during the weekend space allocated to 
>> metadata is
>> suddenly growing while the metadata used remains the same. The first 
>> time I
>> had enough "Device unallocated" and no problem was observed, the 
>> second (on
>> Sunday after midnight), it leads to FS RO (no space left).
>> 
>> Is there any situation that can lead to metadata allocation but 
>> without
>> actual usage of metadata?
> 
> Some btrfs maintenance operations lock block groups to prevent 
> concurrent
> modification, such as balance, scrub, and discard.  When this occurs,
> any free space that has been allocated in the metadata block groups
> is temporarily unavailable, and if there's no free space in any other
> block group, then btrfs will need to allocate another metadata block
> group to continue.  (The same happens with data block groups but the
> impact is smaller due to the much larger data sizes.)  The worst case
> for metadata on a normal filesystem is:
> 
> 	raid_profile_redundancy (2 for dup metadata) * (
> 		chunk_size (usually 1GB) * (
> 			number_of_disks (for scrub) +
> 			1 (for discard) +
> 			1 (for balance)
> 		) + global_reserve (up to 512MB)
> 	)
> 
> i.e. on a single-disk filesystem with dup metadata, there should be at
> least 7GB allocated or available for metadata (3.5GB dup metadata takes
> 7GB of raw space, you can have either the 3.5GB allocated-but-free
> metadata or 7GB unallocated, or any combination totalling at least 
> 7GB).
> 
> Obviously, keeping 7GB reserved for metadata doesn't work on a device
> that is only 2.5GB to start with.  Even if you elect not to use discard
> or scrub, you'd still need 2.5GB for dup metadata.
> 

Since this incident, the FS has been extended to 5GB.

But in our case the chunk size for metadata is 128MB, so:
2 [dup metadata] * ( 128 * ( 1 [disk] + 1 [discard] + 1 [balance] ) + 
512 [Global Reserve] ) = 1792 MB ?

> btrfs has two ways to deal with this: mixed block groups (mixed-bg mkfs
> option), which puts all the space into a single pool with no 
> distinction
> between data and metadata, and reducing block group chunk size for
> non-mixed-bg filesystems.
> 
> On a filesystem this size, the block groups use 128MB chunks instead
> of 1GB.  Global reserve is also reduced (it is computed based on device
> size and capped at 512MB).  In this case, the worst case metadata free
> space requirement is 128MB chunk size * (1 disk + 2) + global_reserve
> which works out to 397MB of free metadata space or 794MB of unallocated
> space with dup metadata.
> 
> You have 467MB allocated to metadata and most of it is free space, 
> which
> is theoretically enough, but if you count space in terms of block 
> groups,
> it's exactly full--if the first 3 block groups are locked, the 4th 
> block
> group is the last one where space might be allocated, and it's an odd
> size so it might not be large enough.
> 

 From obervation the last chunk allocated is not reported as totally 
used, so I see size for data/metdata as "odd size" (not an integer 
number of chunks).

> Mixed block groups (mixed-bg mkfs option) put all the space is in a
> single pot that can be allocated to metadata or data blocks as needed.
> This is the default for filesystems below 1GB, but it's a good idea to
> use mixed-bg for larger filesystems as well because the metadata block
> group locking cost is so high relative to the filesystem size.
> 
> While it's possible to use non-mixed block groups on a filesystem that
> has only a few GB, it's not possible to use a significant number of
> btrfs features, including scrub, balance, RAID disk replacement, online
> conversion to other RAID profiles, device shrink, or discard, due to
> the requirement to have an extra unlocked block group with available
> free space during these operations.

Last weekend I had the same behavior, the size allocated to metadata 
went from 128MB to up to 768MB, so up to 6 * 12* MB metadata but the 
metdata usage didn't grow:

### Sat Oct 16 23:59:57 CEST 2021
Overall:
     Device size:                        5120.00MiB
     Device allocated:                   2647.25MiB
     Device unallocated:                 2472.75MiB
     Device missing:                        0.00MiB
     Used:                               1097.75MiB
     Free (estimated):                   2942.38MiB      (min: 
1706.00MiB)
     Data ratio:                               1.00
     Metadata ratio:                           2.00
     Global reserve:                       13.00MiB      (used: 0.00MiB)

Data,single: Size:1559.25MiB, Used:1089.62MiB
    /dev/mapper/rootvg-varvol    1559.25MiB

Metadata,DUP: Size:512.00MiB, Used:4.00MiB
    /dev/mapper/rootvg-varvol    1024.00MiB

System,DUP: Size:32.00MiB, Used:0.06MiB
    /dev/mapper/rootvg-varvol      64.00MiB

Unallocated:
    /dev/mapper/rootvg-varvol    2472.75MiB



### Sun Oct 17 00:00:32 CEST 2021
Overall:
     Device size:                        5120.00MiB
     Device allocated:                   2903.25MiB
     Device unallocated:                 2216.75MiB
     Device missing:                        0.00MiB
     Used:                               1097.44MiB
     Free (estimated):                   2686.69MiB      (min: 
1578.31MiB)
     Data ratio:                               1.00
     Metadata ratio:                           2.00
     Global reserve:                       13.00MiB      (used: 0.00MiB)

Data,single: Size:1559.25MiB, Used:1089.31MiB
    /dev/mapper/rootvg-varvol    1559.25MiB

Metadata,DUP: Size:640.00MiB, Used:4.00MiB
    /dev/mapper/rootvg-varvol    1280.00MiB

System,DUP: Size:32.00MiB, Used:0.06MiB
    /dev/mapper/rootvg-varvol      64.00MiB

Unallocated:
    /dev/mapper/rootvg-varvol    2216.75MiB


### Sun Oct 17 00:05:27 CEST 2021
Overall:
     Device size:                        5120.00MiB
     Device allocated:                   2903.25MiB
     Device unallocated:                 2216.75MiB
     Device missing:                        0.00MiB
     Used:                               1099.69MiB
     Free (estimated):                   2684.44MiB      (min: 
1576.06MiB)
     Data ratio:                               1.00
     Metadata ratio:                           2.00
     Global reserve:                       13.00MiB      (used: 0.00MiB)

Data,single: Size:1559.25MiB, Used:1091.56MiB
    /dev/mapper/rootvg-varvol    1559.25MiB

Metadata,DUP: Size:640.00MiB, Used:4.00MiB
    /dev/mapper/rootvg-varvol    1280.00MiB

System,DUP: Size:32.00MiB, Used:0.06MiB
    /dev/mapper/rootvg-varvol      64.00MiB

Unallocated:
    /dev/mapper/rootvg-varvol    2216.75MiB


### Sun Oct 17 00:05:32 CEST 2021
Overall:
     Device size:                        5120.00MiB
     Device allocated:                   3159.25MiB
     Device unallocated:                 1960.75MiB
     Device missing:                        0.00MiB
     Used:                               1100.25MiB
     Free (estimated):                   2427.88MiB      (min: 
1447.50MiB)
     Data ratio:                               1.00
     Metadata ratio:                           2.00
     Global reserve:                       13.00MiB      (used: 0.00MiB)

Data,single: Size:1559.25MiB, Used:1092.12MiB
    /dev/mapper/rootvg-varvol    1559.25MiB

Metadata,DUP: Size:768.00MiB, Used:4.00MiB
    /dev/mapper/rootvg-varvol    1536.00MiB

System,DUP: Size:32.00MiB, Used:0.06MiB
    /dev/mapper/rootvg-varvol      64.00MiB

Unallocated:
    /dev/mapper/rootvg-varvol    1960.75MiB

### Sun Oct 17 00:12:53 CEST 2021
Overall:
     Device size:                        5120.00MiB
     Device allocated:                   3159.25MiB
     Device unallocated:                 1960.75MiB
     Device missing:                        0.00MiB
     Used:                               1100.62MiB
     Free (estimated):                   2427.50MiB      (min: 
1447.12MiB)
     Data ratio:                               1.00
     Metadata ratio:                           2.00
     Global reserve:                       13.00MiB      (used: 0.00MiB)

Data,single: Size:1559.25MiB, Used:1092.50MiB
    /dev/mapper/rootvg-varvol    1559.25MiB

Metadata,DUP: Size:768.00MiB, Used:4.00MiB
    /dev/mapper/rootvg-varvol    1536.00MiB

System,DUP: Size:32.00MiB, Used:0.06MiB
    /dev/mapper/rootvg-varvol      64.00MiB

Unallocated:
    /dev/mapper/rootvg-varvol    1960.75MiB
### Sun Oct 17 00:12:58 CEST 2021
Overall:
     Device size:                        5120.00MiB
     Device allocated:                   2903.25MiB
     Device unallocated:                 2216.75MiB
     Device missing:                        0.00MiB
     Used:                               1100.69MiB
     Free (estimated):                   2683.44MiB      (min: 
1575.06MiB)
     Data ratio:                               1.00
     Metadata ratio:                           2.00
     Global reserve:                       13.00MiB      (used: 0.12MiB)

Data,single: Size:1559.25MiB, Used:1092.56MiB
    /dev/mapper/rootvg-varvol    1559.25MiB

Metadata,DUP: Size:640.00MiB, Used:4.00MiB
    /dev/mapper/rootvg-varvol    1280.00MiB

System,DUP: Size:32.00MiB, Used:0.06MiB
    /dev/mapper/rootvg-varvol      64.00MiB

Unallocated:
    /dev/mapper/rootvg-varvol    2216.75MiB

So if I understand properly it might be due to chunk being needed for 
balance/discard or scrub.
Is there 3rd party tools which are also able to lock metadata block 
group as well? It seems to happens at the same time, when backup is 
running (spectrum), and/or HANA backup and/or ReaR backup as well.




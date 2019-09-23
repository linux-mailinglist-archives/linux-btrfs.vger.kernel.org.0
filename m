Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3E97BBBDD
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 20:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbfIWS4N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 14:56:13 -0400
Received: from know-smtprelay-omd-9.server.virginmedia.net ([81.104.62.41]:33704
        "EHLO know-smtprelay-omd-9.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbfIWS4N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 14:56:13 -0400
Received: from [172.16.100.1] ([86.12.75.74])
        by cmsmtp with ESMTPA
        id CTVJieSkTVaV8CTVKisu87; Mon, 23 Sep 2019 19:56:10 +0100
X-Originating-IP: [86.12.75.74]
X-Authenticated-User: peter.chant@ntlworld.com
X-Spam: 0
X-Authority: v=2.3 cv=PcnReBpd c=1 sm=1 tr=0 a=RxXffCTTaIU9mOmmEQ6aGA==:117
 a=RxXffCTTaIU9mOmmEQ6aGA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=OLL_FvSJAAAA:8 a=7BunF_TbynmGij1BKzgA:9
 a=Hjecdt89-2UVzRmS:21 a=QjRQJXjTdHx5F5Ra:21 a=lsCnGvpLBvaM-972:21
 a=QEXdDO2ut3YA:10 a=tT5tHwf8VHgA:10 a=UXlsAf7V2cMA:10
 a=oIrB72frpwYPwTMnlWqB:22
Subject: Re: Balance ENOSPC during balance despite additional storage added
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <94ebf95b-c8c2-e2d5-8db6-77a74c19644a@petezilla.co.uk>
 <CAJCQCtRAnJR+Z8Z8Bq91YXiMpfmwOiHK0tQ+9zAJvSVvexHnxg@mail.gmail.com>
 <54fa8ba3-0d02-7153-ce47-80f10732ef14@petezilla.co.uk>
 <CAJCQCtQLk1m8yAxPPDLVZBr3MehdDD3EpNZ6O_OCRsO-FFzRNw@mail.gmail.com>
From:   Pete <pete@petezilla.co.uk>
Message-ID: <eb9fdaee-ec76-5285-4384-7a615d3cd5c1@petezilla.co.uk>
Date:   Mon, 23 Sep 2019 19:55:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtQLk1m8yAxPPDLVZBr3MehdDD3EpNZ6O_OCRsO-FFzRNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGtX9VBh1mbQEuWz9Eza1X87Ly355zBVRSgdF9JDtZYzRfUDQXJC+iiNXNOcnZYzEmPiEzWpKkRzWcqcAf6/QEw21ekwLq4U0EoFIQaaGBdjLr+rcxXi
 A/Cen57dhbLurpY2RWJYEDpXeyuohpdW60H1kdVFsjQdNxXHwRvrrvlVKU1wCAPtj9ZPjbUgswAx/Nl5u+i6lnqv1wO25dC8PyQ=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/22/19 10:25 PM, Chris Murphy wrote:

>> OK, I'm building 5.2.17 now.  Keen to avoid the corruption errors I was
>> hit by a few weeks back...  May take a time as I'm in the middle of a
>> slow backup.
> 
> Did you see corruption on this same file system? The 5.2 corruption
> bug has been fixed in 5.2.15.
> https://www.spinics.net/lists/stable-commits/msg129532.html
> 
> I'm not aware of a way to fix it though.

I had, what I believe is this issue, in late August/early Sept on my hdd
based filesystem. I was not aware that my nvme drive (/var/lib/lxc etc)
or my ssd, /, were affected.  No obvious clues unlike the hdd filesystem
which threw checksum errors and went ro after a few minutes.


> 
> 
>> I note that a filtered balance, though not hitting enospc and not
>> reporting any errors did seemed to relocate a chunk/extent (sorry, I
>> forget the terminology) but running it a second, third and so on time
>> got the same result.  As if the balance reported doing some work, but
>> did not actually do it.  I also had to reboot at one point as it seemed
>> to get stuck in a loop but alas I can't repeat this.  With the extra
>> logical volume added there is certainly no lack of space relative to the
>> size of the filesystem.
> 
> For sure you're running into some kind of bug.

OK, I broadly did as you suggested, with the filesystem in question
mounted with enospc_debug and a 5.2.17 kernel.  'script' seemed to put a
few odd characters in, but you get my gist.  Not sure what the first
line is?!  Some garbage from somewhere.

Script started on Mon 23 Sep 2019 07:38:55 PM BST
root@phoenix:~# rebootmount | grep
lxcint-http-copy/umount_rootfs          
                  btrfs bal
staRT  rt -dusage=1 /var/lib/lxc
Done, had to relocate 0 out of 89 chunks
root@phoenix:~# btrfs bal start
-dusage=1 /var/lib/lxc1[1P[1@1[1P[1@2
Done, had to relocate 0 out of 89 chunks
root@phoenix:~# btrfs bal start -dusage=2
/var/lib/lxc[1P[1@3
Done, had to relocate 0 out of 89 chunks
root@phoenix:~# btrfs bal start -dusage=3
/var/lib/lxc[1P[1@4
Done, had to relocate 0 out of 89 chunks
root@phoenix:~# btrfs bal start -dusage=4
/var/lib/lxc[1P[1@5
Done, had to relocate 0 out of 89 chunks
root@phoenix:~# btrfs bal start
-dusage=5 /var/lib/lxc[1P[1@1[1@0
Done, had to relocate 0 out of 89 chunks
root@phoenix:~# btrfs bal start
-dusage=10 /var/lib/lxc[1P[1@2
Done, had to relocate 0 out of 89 chunks
root@phoenix:~# btrfs bal start
-dusage=20 /var/lib/lxc[1P[1@3
Done, had to relocate 0 out of 89 chunks
root@phoenix:~# btrfs bal start
-dusage=30 /var/lib/lxc[1P[1@4
Done, had to relocate 0 out of 89 chunks
root@phoenix:~# btrfs bal start
-dusage=40 /var/lib/lxc[1P[1@5
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start
-dusage=50 /var/lib/lxc[1P[1@6
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start
-dusage=60 /var/lib/lxc[1P[1P[1@7[1@0
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start -dusage=70 /var/lib/lxc
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start -dusage=70 /var/lib/lxc70[1P[1P[1P[1P[1P[1P[1P[1P[1P[1@m[1@u[1@s[1@a[1@g[1@e[1@=[1@1
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start
-musage=1 /var/lib/lxc1[1P[1@2
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start -musage=2
/var/lib/lxc[1P[1@3
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start -musage=3
/var/lib/lxc[1P[1@4
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start -musage=4
/var/lib/lxc[1P[1@5
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start
-musage=5 /var/lib/lxc[1P[1@1[1@0
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start -musage=10
/var/lib/lxc[1P[1@5
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start
-musage=15 /var/lib/lxc[1P[1P[1@2[1@0
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start -musage=20
/var/lib/lxc[1P[1@5
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal
start -musage=25 /var/lib/lxc[1P[1P[1@3[1P[1@3[1@0
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start -musage=30
/var/lib/lxc[1P[1@5
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start
-musage=35 /var/lib/lxc[1P[1P[1@4[1@0
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start
-musage=40 /var/lib/lxc0[1P[1@5
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start
-musage=45 /var/lib/lxc[1P[1P[1@5[1@0
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start -musage=50
/var/lib/lxc[1P[1@5
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start
-musage=55 /var/lib/lxc5[1P[1P[1@6[1@0
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start
-musage=60 /var/lib/lxc[1P[1P[1@6[1@5
Done, had to relocate 2 out of 89 chunks
root@phoenix:~# btrfs bal
start -musage=65 /var/lib/lxc[1P[1P[1@5[1P[1@7[1@0
Done, had to relocate 2 out of 89 chunks
root@phoenix:~# btrfs bal start -musage=70 /var/lib/lxc
Done, had to relocate 2 out of 89 chunks
root@phoenix:~# btrfs bal start -musage=70 /var/lib/lxc
Done, had to relocate 2 out of 89 chunks
root@phoenix:~# btrfs bal start -musage=70 /var/lib/lxc
Done, had to relocate 2 out of 89 chunks
root@phoenix:~# btrfs
bal start -musage=70 /var/lib/lxc[1P[1@d
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# btrfs bal start -dusage=70 /var/lib/lxc
Done, had to relocate 1 out of 89 chunks
root@phoenix:~# exit
exit

Script done on Mon 23 Sep 2019 07:45:40 PM BST

dmesg showed this sort of thing:
root@phoenix:~# dmesg | tail -n 40
[  724.387061] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
[  724.387062] BTRFS info (device dm-4): chunk_block_rsv: size 0 reserved 0
[  724.387063] BTRFS info (device dm-4): delayed_block_rsv: size 0
reserved 0
[  724.387064] BTRFS info (device dm-4): delayed_refs_rsv: size 4194304
reserved 1523712
[  724.387093] BTRFS info (device dm-4): relocating block group
1942181904384 flags system
[  724.412338] BTRFS info (device dm-4): found 1 extents
[  724.438117] BTRFS info (device dm-4): balance: ended with status: 0
[  725.144408] BTRFS info (device dm-4): balance: start -musage=70
-susage=70
[  725.144453] BTRFS info (device dm-4): unable to make block group
1944362942464 ro
[  725.144455] BTRFS info (device dm-4): sinfo_used=16384
bg_num_bytes=33538048 min_allocable=1048576
[  725.144456] BTRFS info (device dm-4): space_info 2 has 33538048 free,
is not full
[  725.144458] BTRFS info (device dm-4): space_info total=33554432,
used=16384, pinned=0, reserved=0, may_use=0, readonly=0
[  725.144459] BTRFS info (device dm-4): global_block_rsv: size
536870912 reserved 536870912
[  725.144460] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
[  725.144461] BTRFS info (device dm-4): chunk_block_rsv: size 0 reserved 0
[  725.144462] BTRFS info (device dm-4): delayed_block_rsv: size 0
reserved 0
[  725.144463] BTRFS info (device dm-4): delayed_refs_rsv: size 0 reserved 0
[  725.144547] BTRFS info (device dm-4): relocating block group
1944362942464 flags system
[  725.172398] BTRFS info (device dm-4): unable to make block group
1943289200640 ro
[  725.172400] BTRFS info (device dm-4): sinfo_used=11051237376
bg_num_bytes=1073741824 min_allocable=1048576
[  725.172402] BTRFS info (device dm-4): space_info 4 has 759922688
free, is not full
[  725.172404] BTRFS info (device dm-4): space_info total=11811160064,
used=10512777216, pinned=0, reserved=114688, may_use=538345472, readonly=0
[  725.172405] BTRFS info (device dm-4): global_block_rsv: size
536870912 reserved 536821760
[  725.172406] BTRFS info (device dm-4): trans_block_rsv: size 0 reserved 0
[  725.172407] BTRFS info (device dm-4): chunk_block_rsv: size 0 reserved 0
[  725.172408] BTRFS info (device dm-4): delayed_block_rsv: size 0
reserved 0
[  725.172409] BTRFS info (device dm-4): delayed_refs_rsv: size 4194304
reserved 1523712
[  725.172441] BTRFS info (device dm-4): relocating block group
1943289200640 flags metadata
[  725.198714] BTRFS info (device dm-4): balance: ended with status: 0
[  728.945125] BTRFS info (device dm-4): balance: start -dusage=70
[  728.945261] BTRFS info (device dm-4): relocating block group
1938356699136 flags data
[  729.822341] BTRFS info (device dm-4): found 9991 extents
[  730.012601] BTRFS info (device dm-4): found 9990 extents
[  730.160436] BTRFS info (device dm-4): balance: ended with status: 0
[  732.697352] BTRFS info (device dm-4): balance: start -dusage=70
[  732.697513] BTRFS info (device dm-4): relocating block group
1945503793152 flags data
[  733.573416] BTRFS info (device dm-4): found 9820 extents
[  733.738592] BTRFS info (device dm-4): found 9817 extents
[  733.882864] BTRFS info (device dm-4): balance: ended with status: 0
[  833.204449] radeon_dp_aux_transfer_native: 32 callbacks suppressed
root@phoenix:~#

I'm not sure the balance is resolving anything.  The filesystem has not
gone read only.  I'll try an unfiltered balance now to see how that goes.

Pete





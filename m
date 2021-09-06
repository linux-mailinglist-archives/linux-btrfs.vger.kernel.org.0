Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F0940125C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Sep 2021 03:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbhIFBJY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Sep 2021 21:09:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:50375 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238699AbhIFBJU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 5 Sep 2021 21:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630890493;
        bh=sACzQin+LYvMceDl4/BfomqjAZBKKi9S6IvNGRd5Xnk=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=PKhzQWIsxPWj1Q1AKYwHnnGqnF4feM27k9E81zimp2A5K/Etg0PikNHK0KAOkklAM
         tXCGULHr9ja0MDEF4yJex3rKH1p5iVpB2zW3Jn3BLJoL05xcBhOq4cfIMnsooTD3Sq
         GPaoK5443QPdteHhoWH5qazHr0dlL3pRpJrzA5wU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MOREi-1mbqPC3QP0-00PqeX; Mon, 06
 Sep 2021 03:08:13 +0200
To:     ahipp0 <ahipp0@pm.me>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <IZ0izVVsQVN4TIg_nsujavw6xz3UG-k0C53QTbeghmAryLDm5vf13M_UyrvBZ9tgDT5Mh8VXrMKBfGNju1_FBaCksUTcqZRnfuRydexvfvA=@pm.me>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: BTRFS critical: corrupt leaf; BTRFS warning csum failed, expected
 csum 0x00000000 on AMD Ryzen 7 4800H, Samsung SSD 970 EVO Plus
Message-ID: <01bb7749-eccd-5a3e-eee3-3320c89ce075@gmx.com>
Date:   Mon, 6 Sep 2021 09:08:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <IZ0izVVsQVN4TIg_nsujavw6xz3UG-k0C53QTbeghmAryLDm5vf13M_UyrvBZ9tgDT5Mh8VXrMKBfGNju1_FBaCksUTcqZRnfuRydexvfvA=@pm.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EL8NymxNNGPI7RenB+FUaNwbV0px6mIqI8n9J61E69D3zSgx5wy
 J/0pk9zeH4CKjLW5R/tIkU4UKrWIuBrDIE4V+2LxPNWyuwcXCbWoBsFN1NQg8Bw5smhygMp
 iIhb+dHQxabw7FtAjHIS9l6LbuqpETZdNKiEEzPuB5j4lyEjPT62wg/3X6HK8ygwJ38AWSl
 4jTrmpLtq6wUyjL+e3j0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:10eQ/ZE/jX4=:HCj6yBOmlA742nBKkJ44VJ
 blbp7cWeVn5vkFd+rQ8UTVF8Sdrx3yN3uMOMoEgBvno9+DH6kTs/oTxrvBpWT+ads49BiQfIc
 57iD1wmsyvAIfMxq1zAda4Or65E5N0/PqaJM/6p6SPo4jQD75ABx4dlbe/5LCJUo6PTcWI7Vw
 Een3gZNffjWEKQwmDD5mqc4V6IsqotpI0Vkv0ABfR1Ngb6ADNt7sSWwbLLkzKGskpYlgnPOMX
 FvxsxSP6zH1FDY4YKMMxllKTUd/LDsY8w9flBvc/2pEdFxA1Cnq52zgvQbVD5p/M75QoG7mS2
 KuhzFk5b+02CZm0H4EsVgyXDElyJG+JskxoEx6nOzFtVV42nkfH+7KyPzulJ5q5VfUjpkJugZ
 eb00Y8nnbCb/r5D/vEa6rTeMQGcNeULLZCJSryCclWfzD4A+T8+BRJ5mKVgEAFzIonEA/P3yz
 Ypp3WaIqST1HELuh7kWDcXQ3bjC+pWzt0sfxPh2NjqCTRgFxVpIp3SIH440aiXWPzgZxbuEBR
 zv6kHEO87Yht0UTI0bmNgjojlG7iVZER3dHMEF+k0XEBa/CJ9mlp6sv/eegcZdxGSZGo1Thdi
 VpjaGsmadM0/LKEwWVTW3BYX9IMovDBdAxaLsfhVzTjbCo5EIBKxYqENuupO2sOpCVDx0YHYX
 Gz4qzwX7+699zfY6w9RTH1wpgYWhbTl6wt9n0/xYH6xVsJXBAM+sjGZe7uCsZtpzcxdTw41PL
 67/zKKbGkP723MDU2mJBCGImZaPMIC5NL0dVZmDZKV+Vj6o1aqk5SfU4sfidKHeV8bgEy8bGe
 tZf/X6BO3vPPBXU2zQzY4xfbghvaYcb+PCaCKrcMOs8Sefe6GKqdSpDETe2NrnXYRmLd7rKWd
 BgWsFHCwHVu6xcLZl/UYSjjhaVdN0rHo4xgvbwppuZ9ON1KvMKmcFmTNGEmWM0wlxodO4Y77W
 beUz5VMDZ7S5N9yoQfblBzquQVSJzGGWzX8xQq9D+o+C/4WVLgQEYHFcVz39VMOZqQRcdzlGH
 3AGGigVZ8VW5ECTop5S1KlbSJziUYX5Yb43MPZdPhEaQTdfXTRaD0qk0uJb6K4bwR2zDOe8HT
 u2FJIa+4CemcUP1llmyYFgamDe9pjhfAgi4B7Pm8HVPPY7zCQ76lSNiAA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/5 =E4=B8=8B=E5=8D=883:34, ahipp0 wrote:
> Hi!
>
> I started having various fun BTRFS warnings/errors/critical messages all=
 of a sudden
> after downloading and extracting linux-5.14.1.tar.xz on a fairly new (~1=
TiB read/written) Samsung SSD 970 EVO Plus 500GB. >
> The laptop was resumed from suspend-to-disk ~30 minutes prior to that, I=
 think.
>
> Hardware:
> TUXEDO Pulse 14 - Gen1
> CPU: AMD Ryzen 7 4800H
>
> RAM: 32GiB
> Disk: Samsung SSD 970 EVO Plus 500GB
> Distro: Kubuntu 20.04.2
> Kernel: 5.11.x

I'm pretty sure you have used the btrfs partition for a while, as the
corrupted tree block would be rejected by kernel starting from v5.11.

Thus such corrupted tree block should not be written to disk, thus the
problem must be there for a while before you upgrading to v5.11 kernel.

>
> BTRFS is used on top of a regular GPT partition.
> (luckily, not the rootfs, otherwise I wouldn't be able to write this ema=
il that easily)
> No LVM, no dm-crypt.
>
> Please, see more information below.
> Full kernel log for the past day is attached.
>
> In the past, I also noticed odd things like ldconfig hanging or not pick=
ing up updated libraries are suspend-to-disk.
> Simply rebooting helped in such cases.
> The swap partition is on the same disk. (as a separate partition, not a =
file)
>
> I also started using a new power profile recently, which disables half o=
f the CPU cores when on battery power.
> (but hibernation also offlines all non-boot CPUs while preparing for sus=
pend-to-disk)
>
> What could have caused the filesystem corruption?

 From the dmesg, at least one block group for metadata is corrupted, it
may explain why one tree block can't be read, as it may point to some
invalid location thus got all zero.

I believe the problem exists way before v5.11.x, as in v5.11, btrfs has
the ability to detect tons of new problems and reject such incorrect
metadata from reaching disk.

Thus it should be a problem/bug caused by old kernel.

Furthermore, I didn't see any obvious bitflip, thus bad memory is less
possible.

> Is there a way to repair the filesystem?

As expected, from the btrfs-check output, extent tree is corrupted.

But thankfully, the data should be all safe.

So the first thing is to backup all your important data.

Then try "btrfs check --mode=3Dlowmem" to get a more human readable error
report, and we can start from that to determine if it can be repaired.

But so far, I'm a little optimistic about a working repair.

> How safe is it to continue using this particular filesystem after/if it'=
s repaired on this drive?

It's safe to mount it read-only.

It's not going to work well to read-write mount it, as btrfs will abort
transaction just as you already see in the dmesg.


Thankfully with more and more sanity check introduced in recent kernels,
btrfs can handle such corrupted fs without crashing the whole kernel.

So at least you can try to grab the data without crashing the kernel.

> How safe is it to keep using BTRFS on this drive going forward (even aft=
er creating a new filesystem)?

As long as you're using v5.11 and newer kernel, btrfs is very strict on
any data it writes back to disk, thus it can even detect quite some
memory bitflips.

So unless there is a proof of the SSD is bad, you're pretty safe to
continue use the disk.

And I don't see anything special related to the SSD, thus you're pretty
safe to go.

>
> I've backed up important files,
> so I'll be glad to try various suggestions.
> Also, I'll keep using ext4 on this drive for now and will keep an eye on=
 it.
>
> I think I was able to resolve the "corrupt leaf" issue by deleting affec=
ted files

Nope, there is no way to solve it just using the btrfs kernel module.

Btrfs refuses to read such corrupted tree block at all, thus no way to
modify it.

Unless you're using a much older kernel, but then you lost all the new
sanity checks in v5.11, thus not recommended.

Thanks,
Qu

> (the Linux kernel sources I was unpacking while I hit the issue),
> because "btrfs ins logical-resolve" can't find the file anymore:
> $ btrfs ins logical-resolve 1376043008 /mnt/hippo/
> ERROR: logical ino ioctl: No such file or directory
>
> However, checksum and "btrfs check" errors make me seriously worried.
>
> This is the earliest BTRFS warning I see in the logs:
>
> Sep  4 14:04:51 hippo-tuxedo kernel: [   19.338196] BTRFS warning (devic=
e nvme0n1p4): block group 2169503744 has wrong amount of free space
> Sep  4 14:04:51 hippo-tuxedo kernel: [   19.338202] BTRFS warning (devic=
e nvme0n1p4): failed to load free space cache for block group 2169503744, =
rebuilding it now
>
>
> Here's the first "corrupt leaf" error:
>
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151911] BTRFS critical (devi=
ce nvme0n1p4): corrupt leaf: root=3D2 block=3D1376043008 slot=3D7 bg_start=
=3D2169503744 bg_len=3D1073741824, invalid block group used, have 10737909=
76 expect [0, 1073741824)
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151925] BTRFS info (device n=
vme0n1p4): leaf 1376043008 gen 24254 total ptrs 121 free space 6994 owner =
2
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151929]     item 0 key (2169=
339904 169 0) itemoff 16250 itemsize 33
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151932]             extent r=
efs 1 gen 20692 flags 2
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151933]             ref#0: t=
ree block backref root 7
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151936]     item 1 key (2169=
356288 169 0) itemoff 16217 itemsize 33
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151938]             extent r=
efs 1 gen 20692 flags 2
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151939]             ref#0: t=
ree block backref root 7
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151940]     item 2 key (2169=
372672 169 0) itemoff 16184 itemsize 33
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151942]             extent r=
efs 1 gen 20692 flags 2
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151943]             ref#0: t=
ree block backref root 7
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151945]     item 3 key (2169=
405440 169 0) itemoff 16151 itemsize 33
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151946]             extent r=
efs 1 gen 20692 flags 2
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151947]             ref#0: t=
ree block backref root 7
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151949]     item 4 key (2169=
421824 169 0) itemoff 16118 itemsize 33
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151950]             extent r=
efs 1 gen 20692 flags 2
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151951]             ref#0: t=
ree block backref root 7
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151953]     item 5 key (2169=
470976 169 0) itemoff 16085 itemsize 33
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151954]             extent r=
efs 1 gen 24164 flags 2
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151955]             ref#0: t=
ree block backref root 2
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151957]     item 6 key (2169=
503744 168 16429056) itemoff 16032 itemsize 53
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151959]             extent r=
efs 1 gen 47 flags 1
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151960]             ref#0: e=
xtent data backref root 257 objectid 20379 offset 0 count 1
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151962]     item 7 key (2169=
503744 192 1073741824) itemoff 16008 itemsize 24
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151964]             block gr=
oup used 1073790976 chunk_objectid 256 flags 1
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151966]     item 8 key (2185=
932800 168 241664) itemoff 15955 itemsize 53
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151968]             extent r=
efs 1 gen 47 flags 1
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151969]             ref#0: e=
xtent data backref root 257 objectid 20417 offset 0 count 1
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151971]     item 9 key (2186=
174464 168 299008) itemoff 15902 itemsize 53
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151973]             extent r=
efs 1 gen 47 flags 1
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151974]             ref#0: e=
xtent data backref root 257 objectid 20418 offset 0 count 1
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151976]     item 10 key (218=
6473472 168 135168) itemoff 15849 itemsize 53
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151977]             extent r=
efs 1 gen 47 flags 1
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.151978]             ref#0: e=
xtent data backref root 257 objectid 20419 offset 0 count 1
> ...
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.152480]     item 120 key (21=
95210240 168 4096) itemoff 10019 itemsize 53
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.152481]             extent r=
efs 1 gen 47 flags 1
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.152482]             ref#0: e=
xtent data backref root 257 objectid 20558 offset 0 count 1
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.152484] BTRFS error (device =
nvme0n1p4): block=3D1376043008 write time tree block corruption detected
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.152661] BTRFS: error (device=
 nvme0n1p4) in btrfs_commit_transaction:2339: errno=3D-5 IO failure (Error=
 while writing out transaction)
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.152663] BTRFS info (device n=
vme0n1p4): forced readonly
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.152664] BTRFS warning (devic=
e nvme0n1p4): Skipping commit of aborted transaction.
> Sep  4 23:44:25 hippo-tuxedo kernel: [ 9855.152665] BTRFS: error (device=
 nvme0n1p4) in cleanup_transaction:1939: errno=3D-5 IO failure
>
>
> I hit these csum 0x00000000 errors while trying to backup the files to e=
xt4 partition on the same disk:
>
> Sep  5 00:12:26 hippo-tuxedo kernel: [  891.475516] BTRFS info (device n=
vme0n1p4): disk space caching is enabled
> Sep  5 00:12:26 hippo-tuxedo kernel: [  891.475523] BTRFS info (device n=
vme0n1p4): has skinny extents
> Sep  5 00:12:26 hippo-tuxedo kernel: [  891.494832] BTRFS info (device n=
vme0n1p4): enabling ssd optimizations
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.627577] BTRFS warning (devic=
e nvme0n1p4): csum hole found for disk bytenr range [3111845888, 311184998=
4)
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.627805] BTRFS warning (devic=
e nvme0n1p4): csum failed root 257 ino 31924 off 5726208 csum 0x55271056 e=
xpected csum 0x00000000 mirror 1
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.627814] BTRFS error (device =
nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 1, gen =
0
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.628316] BTRFS warning (devic=
e nvme0n1p4): csum hole found for disk bytenr range [3112013824, 311201792=
0)
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.628931] BTRFS warning (devic=
e nvme0n1p4): csum hole found for disk bytenr range [3112058880, 311206297=
6)
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.628943] BTRFS warning (devic=
e nvme0n1p4): csum hole found for disk bytenr range [3112083456, 311208755=
2)
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.629210] BTRFS warning (devic=
e nvme0n1p4): csum failed root 257 ino 31924 off 5894144 csum 0x45d7e010 e=
xpected csum 0x00000000 mirror 1
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.629214] BTRFS error (device =
nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 2, gen =
0
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.629238] BTRFS warning (devic=
e nvme0n1p4): csum failed root 257 ino 31924 off 5963776 csum 0x95b8b716 e=
xpected csum 0x00000000 mirror 1
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.630311] BTRFS error (device =
nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 3, gen =
0
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.648130] BTRFS warning (devic=
e nvme0n1p4): csum hole found for disk bytenr range [3111845888, 311184998=
4)
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.648226] BTRFS warning (devic=
e nvme0n1p4): csum failed root 257 ino 31924 off 5726208 csum 0x55271056 e=
xpected csum 0x00000000 mirror 1
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.648234] BTRFS error (device =
nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 4, gen =
0
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.649275] BTRFS warning (devic=
e nvme0n1p4): csum hole found for disk bytenr range [3111845888, 311184998=
4)
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.649353] BTRFS warning (devic=
e nvme0n1p4): csum failed root 257 ino 31924 off 5726208 csum 0x55271056 e=
xpected csum 0x00000000 mirror 1
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.649357] BTRFS error (device =
nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 5, gen =
0
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.650397] BTRFS warning (devic=
e nvme0n1p4): csum hole found for disk bytenr range [3111845888, 311184998=
4)
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.650475] BTRFS warning (devic=
e nvme0n1p4): csum failed root 257 ino 31924 off 5726208 csum 0x55271056 e=
xpected csum 0x00000000 mirror 1
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.650478] BTRFS error (device =
nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 6, gen =
0
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.678142] BTRFS warning (devic=
e nvme0n1p4): csum hole found for disk bytenr range [3111124992, 311112908=
8)
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.678149] BTRFS warning (devic=
e nvme0n1p4): csum hole found for disk bytenr range [3111276544, 311128064=
0)
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.678151] BTRFS warning (devic=
e nvme0n1p4): csum hole found for disk bytenr range [3111346176, 311135027=
2)
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.680593] BTRFS warning (devic=
e nvme0n1p4): csum failed root 257 ino 32063 off 39395328 csum 0xeeab29ce =
expected csum 0x00000000 mirror 1
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.680604] BTRFS error (device =
nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 7, gen =
0
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.686438] BTRFS warning (devic=
e nvme0n1p4): csum failed root 257 ino 32063 off 39395328 csum 0xeeab29ce =
expected csum 0x00000000 mirror 1
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.686449] BTRFS error (device =
nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 8, gen =
0
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.687671] BTRFS warning (devic=
e nvme0n1p4): csum failed root 257 ino 32063 off 39395328 csum 0xeeab29ce =
expected csum 0x00000000 mirror 1
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.687683] BTRFS error (device =
nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 9, gen =
0
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.688871] BTRFS warning (devic=
e nvme0n1p4): csum failed root 257 ino 32063 off 39395328 csum 0xeeab29ce =
expected csum 0x00000000 mirror 1
> Sep  5 00:16:42 hippo-tuxedo kernel: [ 1147.688876] BTRFS error (device =
nvme0n1p4): bdev /dev/nvme0n1p4 errs: wr 0, rd 0, flush 0, corrupt 10, gen=
 0
> Sep  5 00:17:05 hippo-tuxedo kernel: [ 1170.527686] BTRFS warning (devic=
e nvme0n1p4): block group 2169503744 has wrong amount of free space
> Sep  5 00:17:05 hippo-tuxedo kernel: [ 1170.527695] BTRFS warning (devic=
e nvme0n1p4): failed to load free space cache for block group 2169503744, =
rebuilding it now
>
>
> $ uname -a
> Linux hippo-tuxedo 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11 1=
5:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
>
> $ btrfs --version
> btrfs-progs v5.4.1
>
> $ btrfs fi show
> Label: 'HIPPO'  uuid: 2b69016b-e03b-478a-84cd-f794eddfebd5
> Total devices 1 FS bytes used 66.32GiB
> devid    1 size 256.00GiB used 95.02GiB path /dev/nvme0n1p4
>
> $ btrfs fi df /mnt/hippo/
> Data, single: total=3D94.01GiB, used=3D66.12GiB
> System, single: total=3D4.00MiB, used=3D16.00KiB
> Metadata, single: total=3D1.01GiB, used=3D203.09MiB
> GlobalReserve, single: total=3D94.59MiB, used=3D0.00B
>
> $ cat /etc/lsb-release
> DISTRIB_ID=3DUbuntu
> DISTRIB_RELEASE=3D20.04
> DISTRIB_CODENAME=3Dfocal
> DISTRIB_DESCRIPTION=3D"Ubuntu 20.04.2 LTS"
>
> Mount options:
> relatime,ssd,space_cache,subvolid=3D5,subvol=3Dandrey
>
> $ btrfs check --readonly /dev/nvme0n1p4
> Opening filesystem to check...
> Checking filesystem on /dev/nvme0n1p4
> UUID: 2b69016b-e03b-478a-84cd-f794eddfebd5
> [1/7] checking root items
> [2/7] checking extents
> extent item 3109511168 has multiple extent items
> ref mismatch on [3109511168 2105344] extent item 1, found 5
> backref disk bytenr does not match extent record, bytenr=3D3109511168, r=
ef bytenr=3D3111489536
> backref bytes do not match extent backref, bytenr=3D3109511168, ref byte=
s=3D2105344, backref bytes=3D8192
> backref disk bytenr does not match extent record, bytenr=3D3109511168, r=
ef bytenr=3D3111436288
> backref bytes do not match extent backref, bytenr=3D3109511168, ref byte=
s=3D2105344, backref bytes=3D16384
> backref disk bytenr does not match extent record, bytenr=3D3109511168, r=
ef bytenr=3D3111260160
> backref bytes do not match extent backref, bytenr=3D3109511168, ref byte=
s=3D2105344, backref bytes=3D8192
> backref disk bytenr does not match extent record, bytenr=3D3109511168, r=
ef bytenr=3D3111411712
> backref bytes do not match extent backref, bytenr=3D3109511168, ref byte=
s=3D2105344, backref bytes=3D12288
> backpointer mismatch on [3109511168 2105344]
> extent item 3111616512 has multiple extent items
> ref mismatch on [3111616512 638976] extent item 25, found 26
> backref disk bytenr does not match extent record, bytenr=3D3111616512, r=
ef bytenr=3D3112091648
> backref bytes do not match extent backref, bytenr=3D3111616512, ref byte=
s=3D638976, backref bytes=3D8192
> backpointer mismatch on [3111616512 638976]
> extent item 3121950720 has multiple extent items
> ref mismatch on [3121950720 2220032] extent item 1, found 4
> backref disk bytenr does not match extent record, bytenr=3D3121950720, r=
ef bytenr=3D3124080640
> backref bytes do not match extent backref, bytenr=3D3121950720, ref byte=
s=3D2220032, backref bytes=3D8192
> backref disk bytenr does not match extent record, bytenr=3D3121950720, r=
ef bytenr=3D3124051968
> backref bytes do not match extent backref, bytenr=3D3121950720, ref byte=
s=3D2220032, backref bytes=3D12288
> backref disk bytenr does not match extent record, bytenr=3D3121950720, r=
ef bytenr=3D3123773440
> backref bytes do not match extent backref, bytenr=3D3121950720, ref byte=
s=3D2220032, backref bytes=3D8192
> backpointer mismatch on [3121950720 2220032]
> extent item 3124252672 has multiple extent items
> ref mismatch on [3124252672 208896] extent item 12, found 13
> backref disk bytenr does not match extent record, bytenr=3D3124252672, r=
ef bytenr=3D3124428800
> backref bytes do not match extent backref, bytenr=3D3124252672, ref byte=
s=3D208896, backref bytes=3D12288
> backpointer mismatch on [3124252672 208896]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> block group 2169503744 has wrong amount of free space, free space cache =
has 10440704 block group has 10346496
> ERROR: free space cache has more free space than block group item, this =
could leads to serious corruption, please contact btrfs developers
> failed to load free space cache for block group 2169503744
> [4/7] checking fs roots
> root 257 inode 31924 errors 1000, some csum missing
> ERROR: errors found in fs roots
> found 71205822464 bytes used, error(s) found
> total csum bytes: 69299516
> total tree bytes: 212975616
> total fs tree bytes: 113672192
> total extent tree bytes: 14909440
> btree space waste bytes: 42172819
> file data blocks allocated: 86083526656
>   referenced 70815563776
>
> $ smartctl --all /dev/nvme0
> smartctl 7.1 2019-12-30 r5022 [x86_64-linux-5.11.0-27-generic] (local bu=
ild)
> Copyright (C) 2002-19, Bruce Allen, Christian Franke, www.smartmontools.=
org
>
> =3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
> Model Number:                       Samsung SSD 970 EVO Plus 500GB
> Serial Number:                      S4EVNX0NB29088Y
> Firmware Version:                   2B2QEXM7
> PCI Vendor/Subsystem ID:            0x144d
> IEEE OUI Identifier:                0x002538
> Total NVM Capacity:                 500,107,862,016 [500 GB]
> Unallocated NVM Capacity:           0
> Controller ID:                      4
> Number of Namespaces:               1
> Namespace 1 Size/Capacity:          500,107,862,016 [500 GB]
> Namespace 1 Utilization:            133,526,691,840 [133 GB]
> Namespace 1 Formatted LBA Size:     512
> Namespace 1 IEEE EUI-64:            002538 5b01b07633
> Local Time is:                      Sun Sep  5 03:08:29 2021 EDT
> Firmware Updates (0x16):            3 Slots, no Reset required
> Optional Admin Commands (0x0017):   Security Format Frmw_DL Self_Test
> Optional NVM Commands (0x005f):     Comp Wr_Unc DS_Mngmt Wr_Zero Sav/Sel=
_Feat Timestmp
> Maximum Data Transfer Size:         512 Pages
> Warning  Comp. Temp. Threshold:     85 Celsius
> Critical Comp. Temp. Threshold:     85 Celsius
>
> Supported Power States
> St Op     Max   Active     Idle   RL RT WL WT  Ent_Lat  Ex_Lat
> 0 +     7.80W       -        -    0  0  0  0        0       0
> 1 +     6.00W       -        -    1  1  1  1        0       0
> 2 +     3.40W       -        -    2  2  2  2        0       0
> 3 -   0.0700W       -        -    3  3  3  3      210    1200
> 4 -   0.0100W       -        -    4  4  4  4     2000    8000
>
> Supported LBA Sizes (NSID 0x1)
> Id Fmt  Data  Metadt  Rel_Perf
> 0 +     512       0         0
>
> =3D=3D=3D START OF SMART DATA SECTION =3D=3D=3D
> SMART overall-health self-assessment test result: PASSED
>
> SMART/Health Information (NVMe Log 0x02)
> Critical Warning:                   0x00
> Temperature:                        33 Celsius
> Available Spare:                    100%
> Available Spare Threshold:          10%
> Percentage Used:                    0%
> Data Units Read:                    1,263,056 [646 GB]
> Data Units Written:                 1,381,709 [707 GB]
> Host Read Commands:                 27,814,722
> Host Write Commands:                29,580,959
> Controller Busy Time:               37
> Power Cycles:                       132
> Power On Hours:                     47
> Unsafe Shutdowns:                   13
> Media and Data Integrity Errors:    0
> Error Information Log Entries:      35
> Warning  Comp. Temperature Time:    0
> Critical Comp. Temperature Time:    0
> Temperature Sensor 1:               33 Celsius
> Temperature Sensor 2:               30 Celsius
>
> Error Information (NVMe Log 0x01, max 64 entries)
> No Errors Logged
>
>
> Thank you,
> Andrey
>

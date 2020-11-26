Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B302C527E
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Nov 2020 11:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbgKZKxZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Nov 2020 05:53:25 -0500
Received: from so254-5.mailgun.net ([198.61.254.5]:56068 "EHLO
        so254-5.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbgKZKxY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Nov 2020 05:53:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=monoid.al; q=dns/txt; s=mx;
 t=1606388002; h=Content-Transfer-Encoding: Content-Type: Cc: To:
 Subject: Message-ID: Date: From: In-Reply-To: References: MIME-Version:
 Sender; bh=KpqFu+R+VsqGq3vyG+nLARBbEwy+x2yX1OgfIWqSLQU=; b=eMiqRNPDAQRbvVWEONxPYTByZq0mQoxswdUm1jzJ6mchxL5BNmOENBMCjKFamSDKPzVxn/dV
 iUgSM3qMegWR2k3O0YyKa9Tdp3V6r6SHbRNRWcyb5k36s98tctp1gthc0AnjMSyJymufj0Fs
 tmWnKAP5uMJ5DBUiKt4pyOSrZKs=
X-Mailgun-Sending-Ip: 198.61.254.5
X-Mailgun-Sid: WyJiMGVhZCIsICJsaW51eC1idHJmc0B2Z2VyLmtlcm5lbC5vcmciLCAiNmViNjQ4Il0=
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173]) by smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5fbf892177b63cdb342541ec (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Thu, 26 Nov 2020 10:53:21 GMT
Sender: joe@monoid.al
Received: by mail-pl1-f173.google.com with SMTP id b23so957860pls.11
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Nov 2020 02:53:21 -0800 (PST)
X-Gm-Message-State: AOAM531iXJDOZgmU4hG0RNqELQ3PLi4K5DUn3yYse6YJ9PHFIWRh7ux3
        690qihIq4ZPE5l6AuSRDt63G//iVfngtqAj1C0g=
X-Google-Smtp-Source: ABdhPJyoK2fIuLExWndDS7WanDhSE2N+hy2DZeqhR0ypOLenbs7a9UXnfuxHuZW21ZZfoHh9TMwJ6BNCkrYOq7ia/4s=
X-Received: by 2002:a17:902:b688:b029:d9:d374:68d with SMTP id
 c8-20020a170902b688b02900d9d374068dmr2324684pls.9.1606388001195; Thu, 26 Nov
 2020 02:53:21 -0800 (PST)
MIME-Version: 1.0
References: <CA+4cVr95GJvSPuMDmACe6kiZEBvArWcBFkLL8Q1HsOV8DRkUHQ@mail.gmail.com>
 <1f5cf01f-0f5e-8691-541d-efb763919577@gmx.com>
In-Reply-To: <1f5cf01f-0f5e-8691-541d-efb763919577@gmx.com>
From:   Joe Hermaszewski <joe@monoid.al>
Date:   Thu, 26 Nov 2020 18:53:09 +0800
X-Gmail-Original-Message-ID: <CA+4cVr8XEJwyccvAhfgJUZyTcjubkava_1h+9+3BggN6XpH3iA@mail.gmail.com>
Message-ID: <CA+4cVr8XEJwyccvAhfgJUZyTcjubkava_1h+9+3BggN6XpH3iA@mail.gmail.com>
Subject: Re: btrfs crash on armv7
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

This is the output of btrfs check with the device unmounted:

```
[root@nixos:~]# btrfs check --readonly /dev/sda1
Opening filesystem to check...
Checking filesystem on /dev/sda1
UUID: b8f4ad49-29c8-4d19-a886-cef9c487f124
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
[4/7] checking fs roots
root 294 inode 24665 errors 100, file extent discount
Found file extent holes:
        start: 3709534208, len: 163840
root 294 inode 406548 errors 100, file extent discount
Found file extent holes:
        start: 0, len: 99450880
ERROR: errors found in fs roots
found 11279251902464 bytes used, error(s) found
total csum bytes: 10935906504
total tree bytes: 18455740416
total fs tree bytes: 5798936576
total extent tree bytes: 532250624
btree space waste bytes: 2308849707
file data blocks allocated: 17243418611712
 referenced 14210256932864
```

Looks the same as before...

I'm afraid I don't have the precise details of the transid error
saved. I think I meant to write earlier that the message that comes up
now and then is the "errno=3D-5 IO failure (Error while writing out
transaction)". I've not seen the transid mismatch one since the first
incident, sorry for that slip-up.

I'll try and attach to a known good system, will I have to attach the
whole array because I don't think I have that many enclosures for the
drives.

I'll also run a memtest on this box.

Thank you for the helpful response.

Best,
Joe

On Thu, Nov 26, 2020 at 2:15 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/11/25 =E4=B8=8B=E5=8D=8811:28, Joe Hermaszewski wrote:
> > Hi,
> >
> > I have a arm32 machine with four drives with a btrfs fs spanning then i=
n RAID1.
> > The filesystem has started behaving badly recently and I'm writing to:
> >
> > - Solicit advice on how best to get the system back to a stable state
> > - Report a potential bug
> >
> > ## What happened:
> >
> > A couple of days ago I could no longer ssh into it, and on the serial
> > connection there were heaps of messages (and new ones appearing with gr=
eat
> > frequency) along the lines of: `parent transid verify failed on blah...=
 wanted
> > x got y`.
> >
> > Although I don't have a record of the precise messages I do remember th=
at there
> > was a difference of `15` between x and y.
>
> This normally can be a sign of unreliable HDD, which lies on FLUSH,
> killing metadata COW.
>
> But, your btrfs check doesn't report the same problem, thus I'm confused.
>
> Would you please try to run a "btrfs check --readonly /dev/sda1" with
> the fs unmounted?
>
> And, would you provide the full dmesg of that mismatch?
> The reason for the exact number is, I'm suspecting hardware memory
> corruption.
>
> >
> > I power-cycled system and started a scrub after it rebooted, this was
> > interrupted quite promptly by several more errors in btrfs, and the dis=
k
> > remounted RO.
> >
> > Every now and then in the kernel log I get messages like:
> >
> > `parent transid verify failed on blah... wanted x got y`
>
> Not showing up in the gist dmesg though.
>
> >
> > ## Important info
> >
> > The dev stats are all zero.
> >
> > Here are the outputs of some btrfs commands, dmesg and the kernel log f=
rom the
> > previous two boots: https://gist.github.com/b1beab134403c5047e2efbceb98=
985f9
> >
> > The "cut here" portion of the kernel log is as follows
> >
> > ```
> > [  409.158097] ------------[ cut here ]------------
> > [  409.158205] WARNING: CPU: 1 PID: 217 at fs/btrfs/disk-io.c:531
> > btree_csum_one_bio+0x208/0x248 [btrfs]
>
> The line number shows, the tree bytenr doesn't match with the one in memo=
ry.
> This is really too rare to be seen, especially when we have no other
> error reported from btrfs (at least in the gist)
>
> Since there is no other problems showing up in the gist, it means it
> could be a bit flip, considering the magic generation gap you mention is
> 15, I'm more suspicious about memory bit flip.
>
> If you can provide the full parent transid mismatch error message, it
> may help to determine the possibility of hardware memory corruption.
>
> Thanks,
> Qu
>
> > [  409.158208] Modules linked in: cfg80211 rfkill 8021q ip6table_nat
> > iptable_nat nf_nat xt_conntrack nf_conntrack nf_defrag_ipv6
> > nf_defrag_ipv4 ip6t_rpfilter ipt_rpfilter ip6table_raw iptable_raw
> > xt_pkttype nf_log_ipv6 nf_log_ipv4 nf_log_common xt_LOG xt_tcpudp
> > ftdi_sio usbserial phy_generic uio_pdrv_genirq uio ip6table_filter
> > ip6_tables iptable_filter sch_fq_codel loop tun tap macvlan bridge stp
> > llc lm75 ip_tables x_tables autofs4 dm_mod dax btrfs libcrc32c xor
> > raid6_pq
> > [  409.158258] CPU: 1 PID: 217 Comm: btrfs-transacti Not tainted 5.4.77=
 #1-NixOS
> > [  409.158260] Hardware name: Marvell Armada 380/385 (Device Tree)
> > [  409.158261] Backtrace:
> > [  409.158272] [<c010f698>] (dump_backtrace) from [<c010f938>]
> > (show_stack+0x20/0x24)
> > [  409.158277]  r7:00000213 r6:600f0013 r5:00000000 r4:c0f8c044
> > [  409.158283] [<c010f918>] (show_stack) from [<c0a1b388>]
> > (dump_stack+0x98/0xac)
> > [  409.158288] [<c0a1b2f0>] (dump_stack) from [<c012a998>] (__warn+0xe0=
/0x108)
> > [  409.158292]  r7:00000213 r6:bf058ec8 r5:00000009 r4:bf120990
> > [  409.158296] [<c012a8b8>] (__warn) from [<c012ad24>]
> > (warn_slowpath_fmt+0x74/0xc4)
> > [  409.158300]  r7:00000213 r6:bf120990 r5:00000000 r4:e2392000
> > [  409.158358] [<c012acb4>] (warn_slowpath_fmt) from [<bf058ec8>]
> > (btree_csum_one_bio+0x208/0x248 [btrfs])
> > [  409.158363]  r9:e277abe0 r8:00000001 r7:e2392000 r6:ea3d17f0
> > r5:00000000 r4:eefd2d3c
> > [  409.158465] [<bf058cc0>] (btree_csum_one_bio [btrfs]) from
> > [<bf059ef4>] (btree_submit_bio_hook+0xe8/0x100 [btrfs])
> > [  409.158470]  r10:e32ce170 r9:ecc45fc0 r8:ecc45f70 r7:ec82b000
> > r6:00000000 r5:ea3d17f0
> > [  409.158472]  r4:bf059e0c
> > [  409.158575] [<bf059e0c>] (btree_submit_bio_hook [btrfs]) from
> > [<bf08b11c>] (submit_one_bio+0x44/0x5c [btrfs])
> > [  409.158578]  r7:ef36c048 r6:e2393cac r5:00000000 r4:bf059e0c
> > [  409.158683] [<bf08b0d8>] (submit_one_bio [btrfs]) from [<bf0965d4>]
> > (btree_write_cache_pages+0x380/0x408 [btrfs])
> > [  409.158686]  r5:00000000 r4:00000000
> > [  409.158788] [<bf096254>] (btree_write_cache_pages [btrfs]) from
> > [<bf059028>] (btree_writepages+0x7c/0x84 [btrfs])
> > [  409.158793]  r10:00000001 r9:4fd00000 r8:c0280c94 r7:e2392000
> > r6:e2393d80 r5:ecc45f70
> > [  409.158794]  r4:e2393d80
> > [  409.158850] [<bf058fac>] (btree_writepages [btrfs]) from
> > [<c0284748>] (do_writepages+0x58/0xf4)
> > [  409.158852]  r5:ecc45f70 r4:ecc45e68
> > [  409.158860] [<c02846f0>] (do_writepages) from [<c0278c30>]
> > (__filemap_fdatawrite_range+0xf8/0x130)
> > [  409.158864]  r8:ecc45f70 r7:00001000 r6:4fd0bfff r5:e2392000 r4:ecc4=
5e68
> > [  409.158869] [<c0278b38>] (__filemap_fdatawrite_range) from
> > [<c0278db8>] (filemap_fdatawrite_range+0x2c/0x34)
> > [  409.158874]  r10:ecc45f70 r9:00001000 r8:4fd0bfff r7:e2393e4c
> > r6:c73bc628 r5:00001000
> > [  409.158875]  r4:4fd0bfff
> > [  409.158929] [<c0278d8c>] (filemap_fdatawrite_range) from
> > [<bf0604b4>] (btrfs_write_marked_extents+0x9c/0x1b0 [btrfs])
> > [  409.158931]  r5:00000001 r4:00000000
> > [  409.159033] [<bf060418>] (btrfs_write_marked_extents [btrfs]) from
> > [<bf060660>] (btrfs_write_and_wait_transaction+0x54/0xa4 [btrfs])
> > [  409.159038]  r10:e2392000 r9:ec82b010 r8:ec82b000 r7:c73bc628
> > r6:ec82b000 r5:e2392000
> > [  409.159040]  r4:c8b81ca8
> > [  409.159141] [<bf06060c>] (btrfs_write_and_wait_transaction [btrfs])
> > from [<bf062398>] (btrfs_commit_transaction+0x75c/0xc94 [btrfs])
> > [  409.159145]  r8:ec82b418 r7:c73bc600 r6:ec82b000 r5:c8b81ca8 r4:0000=
0000
> > [  409.159248] [<bf061c3c>] (btrfs_commit_transaction [btrfs]) from
> > [<bf05cd08>] (transaction_kthread+0x19c/0x1e0 [btrfs])
> > [  409.159253]  r10:ec82b28c r9:00000000 r8:001aaafa r7:00000064
> > r6:ec82b414 r5:00000bb8
> > [  409.159254]  r4:ec82b000
> > [  409.159309] [<bf05cb6c>] (transaction_kthread [btrfs]) from
> > [<c014fabc>] (kthread+0x170/0x174)
> > [  409.159313]  r10:eca87bfc r9:bf05cb6c r8:ed619000 r7:e2392000
> > r6:00000000 r5:ed5ee700
> > [  409.159315]  r4:ed5ee1c0
> > [  409.159320] [<c014f94c>] (kthread) from [<c01010e8>]
> > (ret_from_fork+0x14/0x2c)
> > [  409.159322] Exception stack(0xe2393fb0 to 0xe2393ff8)
> > [  409.159326] 3fa0:                                     00000000
> > 00000000 00000000 00000000
> > [  409.159331] 3fc0: 00000000 00000000 00000000 00000000 00000000
> > 00000000 00000000 00000000
> > [  409.159334] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000=
000
> > [  409.159338]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
> > r6:00000000 r5:c014f94c
> > [  409.159340]  r4:ed5ee700
> > [  409.159342] ---[ end trace eea59ced12fa7859 ]---
> > [  409.165084] BTRFS: error (device sda1) in
> > btrfs_commit_transaction:2279: errno=3D-5 IO failure (Error while
> > writing out transaction)
> > [  409.176920] BTRFS info (device sda1): forced readonly
> > [  409.176947] BTRFS warning (device sda1): Skipping commit of aborted
> > transaction.
> > [  409.176952] BTRFS: error (device sda1) in cleanup_transaction:1832:
> > errno=3D-5 IO failure
> > [  409.185049] BTRFS info (device sda1): delayed_refs has NO entry
> > [  409.310199] BTRFS info (device sda1): scrub: not finished on devid
> > 3 with status: -125
> > [  409.664880] BTRFS info (device sda1): scrub: not finished on devid
> > 4 with status: -125
> > [  410.106791] BTRFS info (device sda1): scrub: not finished on devid
> > 1 with status: -125
> > [  411.268585] BTRFS warning (device sda1): failed setting block group =
ro: -30
> > [  411.268594] BTRFS info (device sda1): scrub: not finished on devid
> > 2 with status: -30
> > [  411.268605] BTRFS info (device sda1): delayed_refs has NO entry
> > ```
> >
> > Information requested here
> > (https://btrfs.wiki.kernel.org/index.php/Btrfs_mailing_list):
> >
> > ```
> >  $ uname -a
> > Linux thanos 5.4.77 #1-NixOS SMP Tue Nov 10 20:13:20 UTC 2020 armv7l GN=
U/Linux
> >
> >  $ btrfs --version
> > btrfs-progs v5.7
> >
> >  $ sudo btrfs fi show
> > Label: none  uuid: b8f4ad49-29c8-4d19-a886-cef9c487f124
> >         Total devices 4 FS bytes used 10.26TiB
> >         devid    1 size 3.64TiB used 2.40TiB path /dev/sda1
> >         devid    2 size 3.64TiB used 2.40TiB path /dev/sdc1
> >         devid    3 size 9.09TiB used 7.86TiB path /dev/sdd1
> >         devid    4 size 9.09TiB used 7.86TiB path /dev/sdb1
> >
> > Label: none  uuid: d02a3067-0a23-4c1f-96ac-80dbc26622f2
> >         Total devices 1 FS bytes used 116.35MiB
> >         devid    1 size 399.82MiB used 224.00MiB path /dev/sda2
> >
> >  $ sudo btrfs fi df /
> > Data, RAID1: total=3D10.25TiB, used=3D10.24TiB
> > System, RAID1: total=3D64.00MiB, used=3D1.45MiB
> > Metadata, RAID1: total=3D18.00GiB, used=3D17.19GiB
> > GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
> > ```
> >
> > Thanks to demfloro and multicore on #btrfs for prompting this email.
> >
> > Best wishes,
> > Joe
> >
>

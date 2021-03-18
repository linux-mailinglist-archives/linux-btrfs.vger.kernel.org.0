Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B207340488
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 12:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhCRLYu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Mar 2021 07:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhCRLYc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Mar 2021 07:24:32 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF177C06174A
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Mar 2021 04:24:31 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id s2so3720497qtx.10
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Mar 2021 04:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=UtP3GWQNQ/4n3ZIILcqS2Cv2O+xRH1VlM4uw06plXJ0=;
        b=S3rw6mWmdjRuhEsocwcn04fHmrzWeH9mBMk6OmiJ0CLCnNWzPp4MtdVelsZqT+zV1N
         MR93rYo1G08EODZQ/3OVDMKX/+O7RFotuKcJMF0CsABIO+rzqQmAWV24BBe3J8GtEszc
         qkGrYhBkTdEI0iCNVt7k9N7UdDLMBDFZYHF9rU1v4EfWqkLj4jyiqu1Wj9mZ44siD6RU
         xiUzUU4/W6lqa5oMaDWkWJjgm/TPeeDtRnJ2prcCWdsDkV7GNeCtl5qv2te7gtXIBFu5
         8c5KH5XkCagmE8h1U7LzRmWC4YgAKZ5wtVwEHY5ud09178EVMndy6EdAz8VtH52FQHmZ
         P2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=UtP3GWQNQ/4n3ZIILcqS2Cv2O+xRH1VlM4uw06plXJ0=;
        b=ojJxg6JQAB6luaD81aHxhIwkWAS00lC3G2qGxm2w+BVd088TWaGGAVKlyMAE7FHQaK
         uk2Swlk127G39xM7E4Cz9fWhhxiVLYQAotBzhUKJDO3HUs8JQXMdNBUyEqS+WHs6fvU3
         NpLpy2vR2NpKWVk0BLqbzJFkTIiaOtmBBIqvpvNJb9p2Zaehz8EDoPAHaPJwDUgsCcFW
         JruP/YSl9+gEN6ejWGClpm1KKeETbt55c/nbu3aXwku0AtsCsac5rg4EC7W3snGYYaAa
         u6THkWGvqlxIXJtSfkhv60H01vg3X6WLihQvKmiZPk65BZWQTTiOWts9x4VvmPQVay9i
         o/LQ==
X-Gm-Message-State: AOAM530TA21Y2DSWosC0bz7f2C5L4q9K7J+3e5SqSeZq9Lot5tHI7ZBx
        GfiPEiwK6RpHNkavTnG65PZsjRUPlDSCZqrqUTzrqXAbhvyK6A==
X-Google-Smtp-Source: ABdhPJxkZB4K+iW7Y6pyWsB27bKz9pMFQ+9DUcq3oiDtAunwxNFH8JVqPIufkOLc+OlApXKB1Rt1YLT7wvetr99xb+w=
X-Received: by 2002:ac8:7490:: with SMTP id v16mr3155514qtq.259.1616066671031;
 Thu, 18 Mar 2021 04:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <7A5485BB-0628-419D-A4D3-27B1AF47E25A@gmail.com>
In-Reply-To: <7A5485BB-0628-419D-A4D3-27B1AF47E25A@gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 18 Mar 2021 11:24:19 +0000
Message-ID: <CAL3q7H52fD5c=8qz1MgOV-816hvTk034t7xbq0suF0PsLn=qOQ@mail.gmail.com>
Subject: Re: kernel 5.11.x: BUG: sleeping function called from invalid context
 at kernel/locking/mutex.c:281
To:     Stuart Shelton <srcshelton@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 18, 2021 at 10:53 AM Stuart Shelton <srcshelton@gmail.com> wrot=
e:
>
> Hi all,
>
> I recently migrated an existing ext4 fs using btrfs-convert (setting node=
size to 32k and enabling optional features `extref`, `skinny-metadata` and =
`no-holes` - the first two of which I believe are now the default in any ca=
se?), but I=E2=80=99m subsequently seeing very frequent BUGs being output b=
y the kernel:
>
> [  821.843637] BUG: sleeping function called from invalid context at kern=
el/locking/mutex.c:281
> [  821.843641] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 282=
14, name: podman
> [  821.843644] CPU: 3 PID: 28214 Comm: podman Tainted: G        W        =
 5.11.6 #15
> [  821.843646] Hardware name: Dell Inc. PowerEdge R330/084XW4, BIOS 2.11.=
0 12/08/2020
> [  821.843647] Call Trace:
> [  821.843650]  dump_stack+0xa1/0xfb
> [  821.843656]  ___might_sleep+0x144/0x160
> [  821.843659]  mutex_lock+0x17/0x40
> [  821.843662]  kernfs_remove_by_name_ns+0x1f/0x80
> [  821.843666]  sysfs_remove_group+0x7d/0xe0
> [  821.843668]  sysfs_remove_groups+0x28/0x40
> [  821.843670]  kobject_del+0x2a/0x80
> [  821.843672]  btrfs_sysfs_del_one_qgroup+0x2b/0x40 [btrfs]
> [  821.843685]  __del_qgroup_rb+0x12/0x150 [btrfs]
> [  821.843696]  btrfs_remove_qgroup+0x288/0x2a0 [btrfs]
> [  821.843707]  btrfs_ioctl+0x3129/0x36a0 [btrfs]
> [  821.843717]  ? __mod_lruvec_page_state+0x5e/0xb0
> [  821.843719]  ? page_add_new_anon_rmap+0xbc/0x150
> [  821.843723]  ? kfree+0x1b4/0x300
> [  821.843725]  ? mntput_no_expire+0x55/0x330
> [  821.843728]  __x64_sys_ioctl+0x5a/0xa0
> [  821.843731]  do_syscall_64+0x33/0x70
> [  821.843733]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  821.843736] RIP: 0033:0x4cd3fb
> [  821.843739] Code: fa ff eb bd e8 86 8b fa ff e9 61 ff ff ff cc e8 fb 5=
5 fa ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05 <=
48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
> [  821.843741] RSP: 002b:000000c000906b20 EFLAGS: 00000206 ORIG_RAX: 0000=
000000000010
> [  821.843744] RAX: ffffffffffffffda RBX: 000000c000050000 RCX: 000000000=
04cd3fb
> [  821.843745] RDX: 000000c000906b98 RSI: 000000004010942a RDI: 000000000=
000000f
> [  821.843747] RBP: 000000c000907cd0 R08: 000000c000622901 R09: 000000000=
0000000
> [  821.843748] R10: 000000c000d992c0 R11: 0000000000000206 R12: 000000000=
000012d
> [  821.843749] R13: 000000000000012c R14: 0000000000000200 R15: 000000000=
0000049
>
> The system starts 24 containers on boot via `podman`, and by the time thi=
s process is complete there were (on the last power-cycle) 10 such BUG repo=
rts logged.
>
> Is this a recognised issue?

Ah, it's taking a mutex while holding a spinlock.
I just sent a fix for this:
https://lore.kernel.org/linux-btrfs/206d121e2e2b609ffe31217e6d90bfabe1c4e12=
1.1616066404.git.fdmanana@suse.com/

Thanks for the report.

>
>
> Support information:
>
> uname:
> Linux dellr330 5.11.6 #15 SMP Wed Mar 17 15:18:52 GMT 2021 x86_64 Intel(R=
) Xeon(R) CPU E3-1240L v5 @ 2.10GHz GenuineIntel GNU/Linux
>
> version:
> btrfs-progs v5.10.1
>
> btrfs fi:
> Label: 'space'  uuid: 94cc0dca-4a1f-4d18-bdf8-943982d1b6ff
>         Total devices 1 FS bytes used 163.44GiB
>         devid    1 size 1.56TiB used 231.24GiB path /dev/mapper/storage-s=
pace
>
> btrfs df:
> Data, single: total=3D221.16GiB, used=3D154.74GiB
> System, single: total=3D4.00MiB, used=3D384.00KiB
> Metadata, single: total=3D10.08GiB, used=3D8.70GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
> fstab entry:
> LABEL=3Dspace /space btrfs noatime,compress-force=3Dzstd:2,user_subvol_rm=
_allowed,nofail 0 2
>
> Other dmesg entries:
> [   61.973985] Btrfs loaded, crc32c=3Dcrc32c-intel, zoned=3Dyes
> [   63.310454] BTRFS: device label space devid 1 transid 24453 /dev/mappe=
r/storage-space scanned by btrfs (6546)
> [   64.471111] BTRFS info (device dm-1): force zstd compression, level 2
> [   64.471126] BTRFS info (device dm-1): disk space caching is enabled
> [   64.471130] BTRFS info (device dm-1): has skinny extents
> [   81.247002] BTRFS info (device dm-1): checking UUID tree
> [  104.987371] BTRFS error (device dm-1): qgroup scan failed with -4
> [  106.615043] BTRFS error (device dm-1): qgroup scan failed with -4
> [  107.258435] BTRFS error (device dm-1): qgroup scan failed with -4
> [  107.962191] BTRFS error (device dm-1): qgroup scan failed with -4
> [  118.289293] BUG: sleeping function called from invalid context at kern=
el/locking/mutex.c:281
> [  118.289296] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 900=
3, name: podman
> [  118.289298] CPU: 4 PID: 9003 Comm: podman Not tainted 5.11.6 #15
> [  118.289301] Hardware name: Dell Inc. PowerEdge R330/084XW4, BIOS 2.11.=
0 12/08/2020
> [  118.289301] Call Trace:
> [  118.289303]  dump_stack+0xa1/0xfb
> [  118.289308]  ___might_sleep+0x144/0x160
> [  118.289310]  mutex_lock+0x17/0x40
> [  118.289313]  kernfs_remove_by_name_ns+0x1f/0x80
> [  118.289317]  sysfs_remove_group+0x7d/0xe0
> [  118.289319]  sysfs_remove_groups+0x28/0x40
> [  118.289320]  kobject_del+0x2a/0x80
> [  118.289322]  btrfs_sysfs_del_one_qgroup+0x2b/0x40 [btrfs]
> [  118.289334]  __del_qgroup_rb+0x12/0x150 [btrfs]
> [  118.289343]  btrfs_remove_qgroup+0x288/0x2a0 [btrfs]
> [  118.289352]  btrfs_ioctl+0x3129/0x36a0 [btrfs]
> [  118.289361]  ? __mod_lruvec_page_state+0x5e/0xb0
> [  118.289363]  ? page_add_new_anon_rmap+0xbc/0x150
> [  118.289366]  ? kfree+0x1b4/0x300
> [  118.289368]  ? mntput_no_expire+0x55/0x330
> [  118.289371]  __x64_sys_ioctl+0x5a/0xa0
> [  118.289374]  do_syscall_64+0x33/0x70
> [  118.289375]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  118.289378] RIP: 0033:0x4cd3fb
> [  118.289380] Code: fa ff eb bd e8 86 8b fa ff e9 61 ff ff ff cc e8 fb 5=
5 fa ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05 <=
48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
> [  118.289382] RSP: 002b:000000c0005e2b20 EFLAGS: 00000206 ORIG_RAX: 0000=
000000000010
> [  118.289384] RAX: ffffffffffffffda RBX: 000000c000050000 RCX: 000000000=
04cd3fb
> [  118.289385] RDX: 000000c0005e2b98 RSI: 000000004010942a RDI: 000000000=
0000012
> [  118.289386] RBP: 000000c0005e3cd0 R08: 000000c000582c01 R09: 000000000=
0000000
> [  118.289387] R10: 000000c000708b70 R11: 0000000000000206 R12: 000000000=
00000b8
> [  118.289388] R13: 00000000000000b7 R14: 0000000000000200 R15: 000000000=
0000049
> [  498.003691] BTRFS info (device dm-1): qgroup scan completed (inconsist=
ency flag cleared)
> [  499.522376] BTRFS error (device dm-1): qgroup scan failed with -4
> [  499.975886] BTRFS error (device dm-1): qgroup scan failed with -4
>
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871FA3403DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Mar 2021 11:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhCRKuk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Mar 2021 06:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhCRKuI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Mar 2021 06:50:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E439BC06174A
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Mar 2021 03:50:07 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z2so4978313wrl.5
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Mar 2021 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=BSqwuIC3f70GVzLVqyqAk403XqjiXVYn1ImgCduDJs0=;
        b=bBunUnQShA6g+a3el571R2i1a5sccgL3b2RN8bfgV4BbtKDhSZ1Dw2ac0V3C6v7dz6
         MWY7iUW4rXFmAN3jg7LvP2Yp1++O/M5nTq9HuRYe/e5m/uipOuPmO0pYX6S7db63FeCv
         QHtRdsxgxySZqKAqzA3H0Dda0PdXp2CsMARDpOhS3eEYQVmclZLOGKN7NDY95PeWIkpK
         6smfRIpQPPH0wkuMmNcsm+FU94GzHilj1ql65ND6gLZCk0sd+PwgsYh/zUJiLnfILLwH
         KW4mBDGWrWL1sAVbRcuPxb6oSRafc/lwCdvYHEMgqkCwOJZHHfIObKv3Q7kHi+id9hKp
         QGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=BSqwuIC3f70GVzLVqyqAk403XqjiXVYn1ImgCduDJs0=;
        b=cAxDErxu+AIDcrtACPoO8pSuF25F31jximB4i2JkoY1PmM9hoTlDlRZm7h0mtzraCz
         Hrb1Mef15mRBz0HScziDYk7+OsvspBJFmVWe8LZXX7GuVkbuvVtNxTHxGFFoqO8iqMh1
         3pkZ1pHaY8AfKNBXs1+oyFpRHW25KMen7CoiZjV1k39Mx08RgOiPV1INvxjLNVUhthzG
         EBX5iee5sKTBqyS+pLaPKdaaESfLnqNNwn3Q7LXYdGTGMwpF3XO9A4t9NQxiLX06mU6q
         8O9NhOhYZ8Kb1TpWq8J+DUGgguxvgMhirvOIMwe1N72Pa02xciv3So0+SlULozoJBZYX
         sJ8Q==
X-Gm-Message-State: AOAM530mr5URfirGCVsBkFYt+4ogGJMvXzEYZ9xdkodYA2wL3RVtZxtD
        v7gT3w3Fj+QOO1HA1eRrnHYQaL9jn4h+
X-Google-Smtp-Source: ABdhPJyg8+TWyGzuhBdDFkngasKz5BYGPWKWQpQOvOWdWz9BL+AG0A4APy3xZ6UVYIHehrBrjFuocg==
X-Received: by 2002:a5d:44c5:: with SMTP id z5mr8599195wrr.319.1616064606129;
        Thu, 18 Mar 2021 03:50:06 -0700 (PDT)
Received: from ip-10-1-67-67.eu-west-2.compute.internal ([81.187.77.182])
        by smtp.gmail.com with ESMTPSA id o13sm2831188wro.15.2021.03.18.03.50.05
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Mar 2021 03:50:05 -0700 (PDT)
From:   Stuart Shelton <srcshelton@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: kernel 5.11.x: BUG: sleeping function called from invalid context at
 kernel/locking/mutex.c:281
Message-Id: <7A5485BB-0628-419D-A4D3-27B1AF47E25A@gmail.com>
Date:   Thu, 18 Mar 2021 10:50:04 +0000
To:     linux-btrfs@vger.kernel.org
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

I recently migrated an existing ext4 fs using btrfs-convert (setting =
nodesize to 32k and enabling optional features `extref`, =
`skinny-metadata` and `no-holes` - the first two of which I believe are =
now the default in any case?), but I=E2=80=99m subsequently seeing very =
frequent BUGs being output by the kernel:

[  821.843637] BUG: sleeping function called from invalid context at =
kernel/locking/mutex.c:281
[  821.843641] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: =
28214, name: podman
[  821.843644] CPU: 3 PID: 28214 Comm: podman Tainted: G        W        =
 5.11.6 #15
[  821.843646] Hardware name: Dell Inc. PowerEdge R330/084XW4, BIOS =
2.11.0 12/08/2020
[  821.843647] Call Trace:
[  821.843650]  dump_stack+0xa1/0xfb
[  821.843656]  ___might_sleep+0x144/0x160
[  821.843659]  mutex_lock+0x17/0x40
[  821.843662]  kernfs_remove_by_name_ns+0x1f/0x80
[  821.843666]  sysfs_remove_group+0x7d/0xe0
[  821.843668]  sysfs_remove_groups+0x28/0x40
[  821.843670]  kobject_del+0x2a/0x80
[  821.843672]  btrfs_sysfs_del_one_qgroup+0x2b/0x40 [btrfs]
[  821.843685]  __del_qgroup_rb+0x12/0x150 [btrfs]
[  821.843696]  btrfs_remove_qgroup+0x288/0x2a0 [btrfs]
[  821.843707]  btrfs_ioctl+0x3129/0x36a0 [btrfs]
[  821.843717]  ? __mod_lruvec_page_state+0x5e/0xb0
[  821.843719]  ? page_add_new_anon_rmap+0xbc/0x150
[  821.843723]  ? kfree+0x1b4/0x300
[  821.843725]  ? mntput_no_expire+0x55/0x330
[  821.843728]  __x64_sys_ioctl+0x5a/0xa0
[  821.843731]  do_syscall_64+0x33/0x70
[  821.843733]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  821.843736] RIP: 0033:0x4cd3fb
[  821.843739] Code: fa ff eb bd e8 86 8b fa ff e9 61 ff ff ff cc e8 fb =
55 fa ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f =
05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
[  821.843741] RSP: 002b:000000c000906b20 EFLAGS: 00000206 ORIG_RAX: =
0000000000000010
[  821.843744] RAX: ffffffffffffffda RBX: 000000c000050000 RCX: =
00000000004cd3fb
[  821.843745] RDX: 000000c000906b98 RSI: 000000004010942a RDI: =
000000000000000f
[  821.843747] RBP: 000000c000907cd0 R08: 000000c000622901 R09: =
0000000000000000
[  821.843748] R10: 000000c000d992c0 R11: 0000000000000206 R12: =
000000000000012d
[  821.843749] R13: 000000000000012c R14: 0000000000000200 R15: =
0000000000000049

The system starts 24 containers on boot via `podman`, and by the time =
this process is complete there were (on the last power-cycle) 10 such =
BUG reports logged.

Is this a recognised issue?


Support information:

uname:
Linux dellr330 5.11.6 #15 SMP Wed Mar 17 15:18:52 GMT 2021 x86_64 =
Intel(R) Xeon(R) CPU E3-1240L v5 @ 2.10GHz GenuineIntel GNU/Linux

version:
btrfs-progs v5.10.1=20

btrfs fi:
Label: 'space'  uuid: 94cc0dca-4a1f-4d18-bdf8-943982d1b6ff
        Total devices 1 FS bytes used 163.44GiB
        devid    1 size 1.56TiB used 231.24GiB path =
/dev/mapper/storage-space

btrfs df:
Data, single: total=3D221.16GiB, used=3D154.74GiB
System, single: total=3D4.00MiB, used=3D384.00KiB
Metadata, single: total=3D10.08GiB, used=3D8.70GiB
GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

fstab entry:
LABEL=3Dspace /space btrfs =
noatime,compress-force=3Dzstd:2,user_subvol_rm_allowed,nofail 0 2

Other dmesg entries:
[   61.973985] Btrfs loaded, crc32c=3Dcrc32c-intel, zoned=3Dyes
[   63.310454] BTRFS: device label space devid 1 transid 24453 =
/dev/mapper/storage-space scanned by btrfs (6546)
[   64.471111] BTRFS info (device dm-1): force zstd compression, level 2
[   64.471126] BTRFS info (device dm-1): disk space caching is enabled
[   64.471130] BTRFS info (device dm-1): has skinny extents
[   81.247002] BTRFS info (device dm-1): checking UUID tree
[  104.987371] BTRFS error (device dm-1): qgroup scan failed with -4
[  106.615043] BTRFS error (device dm-1): qgroup scan failed with -4
[  107.258435] BTRFS error (device dm-1): qgroup scan failed with -4
[  107.962191] BTRFS error (device dm-1): qgroup scan failed with -4
[  118.289293] BUG: sleeping function called from invalid context at =
kernel/locking/mutex.c:281
[  118.289296] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: =
9003, name: podman
[  118.289298] CPU: 4 PID: 9003 Comm: podman Not tainted 5.11.6 #15
[  118.289301] Hardware name: Dell Inc. PowerEdge R330/084XW4, BIOS =
2.11.0 12/08/2020
[  118.289301] Call Trace:
[  118.289303]  dump_stack+0xa1/0xfb
[  118.289308]  ___might_sleep+0x144/0x160
[  118.289310]  mutex_lock+0x17/0x40
[  118.289313]  kernfs_remove_by_name_ns+0x1f/0x80
[  118.289317]  sysfs_remove_group+0x7d/0xe0
[  118.289319]  sysfs_remove_groups+0x28/0x40
[  118.289320]  kobject_del+0x2a/0x80
[  118.289322]  btrfs_sysfs_del_one_qgroup+0x2b/0x40 [btrfs]
[  118.289334]  __del_qgroup_rb+0x12/0x150 [btrfs]
[  118.289343]  btrfs_remove_qgroup+0x288/0x2a0 [btrfs]
[  118.289352]  btrfs_ioctl+0x3129/0x36a0 [btrfs]
[  118.289361]  ? __mod_lruvec_page_state+0x5e/0xb0
[  118.289363]  ? page_add_new_anon_rmap+0xbc/0x150
[  118.289366]  ? kfree+0x1b4/0x300
[  118.289368]  ? mntput_no_expire+0x55/0x330
[  118.289371]  __x64_sys_ioctl+0x5a/0xa0
[  118.289374]  do_syscall_64+0x33/0x70
[  118.289375]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  118.289378] RIP: 0033:0x4cd3fb
[  118.289380] Code: fa ff eb bd e8 86 8b fa ff e9 61 ff ff ff cc e8 fb =
55 fa ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f =
05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
[  118.289382] RSP: 002b:000000c0005e2b20 EFLAGS: 00000206 ORIG_RAX: =
0000000000000010
[  118.289384] RAX: ffffffffffffffda RBX: 000000c000050000 RCX: =
00000000004cd3fb
[  118.289385] RDX: 000000c0005e2b98 RSI: 000000004010942a RDI: =
0000000000000012
[  118.289386] RBP: 000000c0005e3cd0 R08: 000000c000582c01 R09: =
0000000000000000
[  118.289387] R10: 000000c000708b70 R11: 0000000000000206 R12: =
00000000000000b8
[  118.289388] R13: 00000000000000b7 R14: 0000000000000200 R15: =
0000000000000049
[  498.003691] BTRFS info (device dm-1): qgroup scan completed =
(inconsistency flag cleared)
[  499.522376] BTRFS error (device dm-1): qgroup scan failed with -4
[  499.975886] BTRFS error (device dm-1): qgroup scan failed with -4



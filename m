Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A538413B23D
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 19:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgANSkO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 13:40:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:54746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANSkO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 13:40:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4C832AEC4;
        Tue, 14 Jan 2020 18:40:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5EA8BDA795; Tue, 14 Jan 2020 19:39:58 +0100 (CET)
Date:   Tue, 14 Jan 2020 19:39:58 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs, sysfs cleanup and add dev_state
Message-ID: <20200114183958.GJ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191205112706.8125-1-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 05, 2019 at 07:27:02PM +0800, Anand Jain wrote:
> Patch 1/4 is a cleanup patch.
> Patch 2/4 adds the kobject devinfo which is a preparatory to patch 4/4.
> Patch 3/4 was sent before, no functional changes, change log is updated.
> Patch 4/4 creates the attribute dev_state.
> 
> Anand Jain (4):
>   btrfs: sysfs, use btrfs_sysfs_remove_fsid in fail return in add_fsid
>   btrfs: sysfs, add UUID/devinfo kobject
>   btrfs: sysfs, rename device_link add,remove functions
>   btrfs: sysfs, add devid/dev_state kobject and attribute

I'm not sure which patch causes that but there are more problems, from test
btrfs/064. The log is full of it, the create part for device id 0 and
when the filesystem is unmounted, refcount for the object is wrong and
sysfs complains.

[ 1839.514008] kobject: '(null)' (00000000167bb824): is not initialized, yet kobject_put() is being called.                                                                                                     │··
[ 1839.517437] WARNING: CPU: 3 PID: 2487 at lib/kobject.c:736 kobject_put+0x40/0xb0                                                                                                                             │··
[ 1839.520253] Modules linked in: dm_flakey dm_mod dax xxhash_generic btrfs blake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop           │··
[ 1839.524566] CPU: 3 PID: 2487 Comm: umount Tainted: G        W         5.5.0-rc5-default+ #932                                                                                                                │··
[ 1839.527075] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014                                                                               │··
[ 1839.529898] RIP: 0010:kobject_put+0x40/0xb0                                                                                                                                                                  │··
 0c 80                                                                                                                                                                                                          │··
[ 1839.535471] RSP: 0018:ffffac040741fdc0 EFLAGS: 00010282                                                                                                                                                      │··
[ 1839.537134] RAX: 0000000000000000 RBX: ffff93422bc0f000 RCX: 0000000000000001                                                                                                                                │··
[ 1839.539236] RDX: 0000000000000000 RSI: ffffffff9f100899 RDI: ffffffff9f100971                                                                                                                                │··
[ 1839.541299] RBP: ffff93422bc0f2f8 R08: 0000000000000000 R09: 0000000000000000                                                                                                                                │··
[ 1839.543132] R10: 0000000000000000 R11: 0000000000000000 R12: ffff934239959a00                                                                                                                                │··
[ 1839.545114] R13: ffff934239959b18 R14: 0000000000000000 R15: ffff934235b23fc8                                                                                                                                │··
[ 1839.547131] FS:  00007f9d2c233800(0000) GS:ffff93423dc00000(0000) knlGS:0000000000000000                                                                                                                     │··
[ 1839.549219] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033                                                                                                                                                │··
[ 1839.550380] CR2: 00007fff85c8cff8 CR3: 000000001ff3f006 CR4: 0000000000160ee0                                                                                                                                │··
[ 1839.551841] Call Trace:                                                                                                                                                                                      │··
[ 1839.553050]  btrfs_sysfs_rm_device_link+0xb8/0xe0 [btrfs]                                                                                                                                                    │··
[ 1839.554862]  close_ctree+0x23a/0x334 [btrfs]                                                                                                                                                                 │··
[ 1839.556429]  generic_shutdown_super+0x69/0x100                                                                                                                                                               │··
[ 1839.558030]  kill_anon_super+0x14/0x30                                                                                                                                                                       │··
[ 1839.559461]  btrfs_kill_super+0x12/0xa0 [btrfs]                                                                                                                                                              │··
[ 1839.560894]  deactivate_locked_super+0x2c/0x70                                                                                                                                                               │··
[ 1839.562375]  cleanup_mnt+0x100/0x160                                                                                                                                                                         │··
[ 1839.563682]  task_work_run+0x90/0xc0                                                                                                                                                                         │··
[ 1839.564991]  exit_to_usermode_loop+0x96/0xa0                                                                                                                                                                 │··
[ 1839.566438]  do_syscall_64+0x1df/0x210                                                                                                                                                                       │··
[ 1839.567792]  entry_SYSCALL_64_after_hwframe+0x49/0xbe                                                                                                                                                        │··
[ 1839.569416] RIP: 0033:0x7f9d2c4774e7                                                                                                                                                                         │··
 01 48                                                                                                                                                                                                          │··
[ 1839.576283] RSP: 002b:00007fff85c8e388 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6                                                                                                                           │··
[ 1839.578849] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f9d2c4774e7                                                                                                                                │··
[ 1839.581006] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055e08e9dab80                                                                                                                                │··
[ 1839.583132] RBP: 000055e08e9da970 R08: 0000000000000000 R09: 00007fff85c8d100                                                                                                                                │··
[ 1839.585271] R10: 000055e08e9daba0 R11: 0000000000000246 R12: 000055e08e9dab80                                                                                                                                │··
[ 1839.587420] R13: 0000000000000000 R14: 000055e08e9daa68 R15: 0000000000000000                                                                                                                                │··
[ 1839.589528] irq event stamp: 0                                                                                                                                                                               │··
[ 1839.590731] hardirqs last  enabled at (0): [<0000000000000000>] 0x0                                                                                                                                          │··
[ 1839.592667] hardirqs last disabled at (0): [<ffffffff9f07efb0>] copy_process+0x680/0x1b70                                                                                                                    │··
[ 1839.595447] softirqs last  enabled at (0): [<ffffffff9f07efb0>] copy_process+0x680/0x1b70                                                                                                                    │··
[ 1839.598216] softirqs last disabled at (0): [<0000000000000000>] 0x0                                                                                                                                          │··
[ 1839.600178] ---[ end trace d7fb083174aa2eaf ]---

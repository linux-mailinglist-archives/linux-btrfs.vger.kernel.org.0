Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2968F5D43
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Nov 2019 04:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfKIDpW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 22:45:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:42978 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbfKIDpW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Nov 2019 22:45:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 47D22B250;
        Sat,  9 Nov 2019 03:45:20 +0000 (UTC)
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Subject: [next-20191108] Assertion failure in
 space-info.c:btrfs_update_space_info()
Organization: SUSE Software Solutions Germany GmbH
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Message-ID: <ebde863f-51f2-d761-4bae-1722ea256e08@suse.de>
Date:   Sat, 9 Nov 2019 04:45:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

On arm64 I'm seeing a regression between next-20191031 and next-20191105
that breaks boot from my btrfs rootfs: next-20191105 and later oopses on
found->lock, or with CONFIG_BTRFS_ASSERT asserts on a NULL "found"
variable in btrfs_update_space_info().

According to git-blame that code hasn't changed in months, and I didn't
spot an obvious cause among the fs/btrfs/ commis between those two tags.

[    3.512280] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.520043] BTRFS: device label rootfs devid 1 transid 490 /dev/root
scanned by swapper/0 (1)
[    3.529701] BTRFS info (device sda3): disk space caching is enabled
[    3.536182] BTRFS info (device sda3): has skinny extents
[    3.547836] assertion failed: found, in fs/btrfs/space-info.c:124
[    3.554171] ------------[ cut here ]------------
[    3.558923] kernel BUG at fs/btrfs/ctree.h:3118!
[    3.563673] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[    3.569312] Modules linked in:
[    3.572465] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.4.0-rc6-next-20191105+ #110
[    3.580335] Hardware name: Zidoo X9S (DT)
[    3.584463] pstate: 40000005 (nZcv daif -PAN -UAO)
[    3.589401] pc : assfail.constprop.0+0x24/0x28
[    3.593975] lr : assfail.constprop.0+0x24/0x28
[    3.598543] sp : ffff80001002b7d0
[    3.601954] x29: ffff80001002b7d0 x28: 0000000000000000
[    3.607420] x27: 0000000000000001 x26: 0000000000000001
[    3.612885] x25: 0000000000000000 x24: ffff80001002b890
[    3.618350] x23: 0000000000000000 x22: ffff00007c7d0000
[    3.623815] x21: 0000000000800000 x20: 0000000000000001
[    3.629281] x19: 0000000000000000 x18: 0000000000000000
[    3.634746] x17: 000000009b04d1f2 x16: 0000000000000014
[    3.640211] x15: 000000000000000a x14: 0720072007200720
[    3.645676] x13: 0720072007200720 x12: 0720072007200720
[    3.651141] x11: 073407320731073a x10: 0763072e076f0766
[    3.656606] x9 : 076e0769072d0765 x8 : 0000000000000000
[    3.662071] x7 : 0000000000000007 x6 : 0000000000000000
[    3.667536] x5 : 0000000000000000 x4 : 0000000000000000
[    3.673000] x3 : 0000000000000000 x2 : 00e5bec8376cfb00
[    3.678465] x1 : 0000000000000000 x0 : 0000000000000035
[    3.683930] Call trace:
[    3.686455]  assfail.constprop.0+0x24/0x28
[    3.690672]  btrfs_update_space_info+0x5c/0xe4
[    3.695248]  btrfs_read_block_groups+0x470/0x620
[    3.700001]  open_ctree+0x1500/0x1ae8
[    3.703775]  btrfs_mount_root+0x38c/0x450
[    3.707904]  legacy_get_tree+0x2c/0x54
[    3.711766]  vfs_get_tree+0x28/0xd4
[    3.715361]  fc_mount+0x14/0x44
[    3.718599]  vfs_kern_mount.part.0+0x74/0x98
[    3.722994]  vfs_kern_mount+0x10/0x20
[    3.726767]  btrfs_mount+0x624/0x6cc
[    3.730450]  legacy_get_tree+0x2c/0x54
[    3.734312]  vfs_get_tree+0x28/0xd4
[    3.737904]  do_mount+0x52c/0x728
[    3.741318]  ksys_mount+0xb4/0xc4
[    3.744734]  mount_block_root+0x12c/0x2d8
[    3.748861]  mount_root+0x7c/0x88
[    3.752275]  prepare_namespace+0x15c/0x16c
[    3.756491]  kernel_init_freeable+0x1e0/0x224
[    3.760977]  kernel_init+0x10/0xf8
[    3.764483]  ret_from_fork+0x10/0x18
[    3.768171] Code: 913f6842 b0003260 91337800 97f6e0d0 (d4210000)
[    3.774446] ---[ end trace 21d95ef2db268f8d ]---
[    3.779221] note: swapper/0[1] exited with preempt_count 1
[    3.784910] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    3.792786] SMP: stopping secondary CPUs
[    3.796824] Kernel Offset: disabled
[    3.800415] CPU features: 0x00002,20002004
[    3.804626] Memory Limit: none
[    3.807780] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---

Kindly revert the tree to some working state again.

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAF1513B22E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2020 19:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgANSdQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jan 2020 13:33:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:50586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgANSdP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jan 2020 13:33:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5FABEADBE;
        Tue, 14 Jan 2020 18:33:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 464B1DA795; Tue, 14 Jan 2020 19:32:58 +0100 (CET)
Date:   Tue, 14 Jan 2020 19:32:57 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: sysfs, add UUID/devinfo kobject
Message-ID: <20200114183257.GI3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        linux-btrfs@vger.kernel.org
References: <20191205112706.8125-1-anand.jain@oracle.com>
 <20191205112706.8125-3-anand.jain@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191205112706.8125-3-anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 05, 2019 at 07:27:04PM +0800, Anand Jain wrote:
> Preparatory patch creates kobject /sys/fs/btrfs/UUID/devinfo to hold
> btrfs_fs_devices::dev_state attribute.
> 
> This is being added in the mount context, that means we don't see
> UUID/devinfo before the mount (yet).
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

There's a report about duplicate directory created:

btrfs/064

[ 1782.480622] sysfs: cannot create duplicate filename '/fs/btrfs/3f26615b-afcd-4008-8aed-44e714be257c/devices/0'                                                                                               │··
[ 1782.486942] CPU: 1 PID: 1983 Comm: btrfs Not tainted 5.5.0-rc5-default+ #932                                                                                                                                 │··
[ 1782.490425] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014                                                                               │··
[ 1782.494584] Call Trace:                                                                                                                                                                                      │··
[ 1782.495588]  dump_stack+0x71/0xa0                                                                                                                                                                            │··
[ 1782.497531]  sysfs_warn_dup.cold+0x17/0x2d                                                                                                                                                                   │··
[ 1782.499626]  sysfs_create_dir_ns+0xb6/0xd0                                                                                                                                                                   │··
[ 1782.501732]  kobject_add_internal+0xbb/0x2d0                                                                                                                                                                 │··
[ 1782.504346]  kobject_init_and_add+0x71/0xa0                                                                                                                                                                  │··
[ 1782.505694]  ? lockdep_init_map+0x43/0x1d0                                                                                                                                                                   │··
[ 1782.506800]  btrfs_sysfs_add_device_link+0xb5/0x100 [btrfs]                                                                                                                                                  │··
[ 1782.508356]  ? rwsem_wake.isra.0+0x6c/0x90                                                                                                                                                                   │··
[ 1782.510070]  btrfs_dev_replace_start+0x2cf/0x380 [btrfs]                                                                                                                                                     │··
[ 1782.511663]  btrfs_dev_replace_by_ioctl+0x35/0x60 [btrfs]                                                                                                                                                    │··
[ 1782.513177]  btrfs_ioctl+0x1d72/0x2560 [btrfs]                                                                                                                                                               │··
[ 1782.514375]  ? do_sigaction+0x5f/0x240                                                                                                                                                                       │··
[ 1782.515867]  ? do_vfs_ioctl+0x56e/0x770                                                                                                                                                                      │··
[ 1782.517276]  do_vfs_ioctl+0x56e/0x770                                                                                                                                                                        │··
[ 1782.518577]  ? do_sigaction+0xf8/0x240                                                                                                                                                                       │··
[ 1782.519898]  ksys_ioctl+0x3a/0x70                                                                                                                                                                            │··
[ 1782.521171]  ? trace_hardirqs_off_thunk+0x1a/0x1c                                                                                                                                                            │··
[ 1782.522783]  __x64_sys_ioctl+0x16/0x20                                                                                                                                                                       │··
[ 1782.524064]  do_syscall_64+0x50/0x210                                                                                                                                                                        │··
[ 1782.525313]  entry_SYSCALL_64_after_hwframe+0x49/0xbe                                                                                                                                                        │··
[ 1782.526818] RIP: 0033:0x7feafcbd5387                                                                                                                                                                         │··
[ 1782.528154] Code: 00 00 90 48 8b 05 f9 9a 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c9 9a 0c 00 f7 d8 64 89│··
 01 48                                                                                                                                                                                                          │··
[ 1782.533927] RSP: 002b:00007ffcb14eea88 EFLAGS: 00000246 ORIG_RAX: 0000000000000010                                                                                                                           │··
[ 1782.536483] RAX: ffffffffffffffda RBX: 00007ffcb14f11b0 RCX: 00007feafcbd5387                                                                                                                                │··
[ 1782.538983] RDX: 00007ffcb14ef8f0 RSI: 00000000ca289435 RDI: 0000000000000003                                                                                                                                │··
[ 1782.541339] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000                                                                                                                                │··
[ 1782.543809] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000003                                                                                                                                │··
[ 1782.545906] R13: 0000000000000001 R14: 0000000000000000 R15: 00005641a71d02e0                                                                                                                                │··
[ 1782.548347] kobject_add_internal failed for 0 with -EEXIST, don't try to register things with the same name in the same directory.

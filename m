Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9299512B64
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2019 12:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfECKWD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 May 2019 06:22:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:56392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfECKWD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 May 2019 06:22:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 680A3AD36
        for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2019 10:22:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8EC01DA885; Fri,  3 May 2019 12:23:02 +0200 (CEST)
Date:   Fri, 3 May 2019 12:23:02 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 02/15] btrfs: combine device update operations during
 transaction commit
Message-ID: <20190503102302.GF20156@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190327122418.24027-1-nborisov@suse.com>
 <20190327122418.24027-3-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327122418.24027-3-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 27, 2019 at 02:24:05PM +0200, Nikolay Borisov wrote:
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -662,7 +662,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
>  	btrfs_device_set_disk_total_bytes(tgt_device,
>  					  src_device->disk_total_bytes);
>  	btrfs_device_set_bytes_used(tgt_device, src_device->bytes_used);
> -	ASSERT(list_empty(&src_device->resized_list));
> +	ASSERT(list_empty(&src_device->post_commit_list));

I've just caught this assertion to fail at btrfs/071. It's for the first
time but this could also explain the infrequent failures of umount after
btrfs/011 test that caused other tests to fail.

btrfs/071               [10:10:22][ 2348.888263] run fstests btrfs/071 at 2019-05-03 10:10:22
[ 2349.018607] BTRFS info (device vda): disk space caching is enabled
[ 2349.021433] BTRFS info (device vda): has skinny extents
[ 2349.958749] BTRFS: device fsid 1e913c80-9d7f-4e42-95e6-55f207ef0c79 devid 1 transid 5 /dev/vdb
[ 2349.962961] BTRFS: device fsid 1e913c80-9d7f-4e42-95e6-55f207ef0c79 devid 2 transid 5 /dev/vdc
[ 2349.966961] BTRFS: device fsid 1e913c80-9d7f-4e42-95e6-55f207ef0c79 devid 3 transid 5 /dev/vdd
[ 2349.970983] BTRFS: device fsid 1e913c80-9d7f-4e42-95e6-55f207ef0c79 devid 4 transid 5 /dev/vde
[ 2349.974966] BTRFS: device fsid 1e913c80-9d7f-4e42-95e6-55f207ef0c79 devid 5 transid 5 /dev/vdf
[ 2349.978829] BTRFS: device fsid 1e913c80-9d7f-4e42-95e6-55f207ef0c79 devid 6 transid 5 /dev/vdg
[ 2349.993612] BTRFS info (device vdb): disk space caching is enabled
[ 2349.996386] BTRFS info (device vdb): has skinny extents
[ 2349.998780] BTRFS info (device vdb): flagging fs with big metadata feature
[ 2350.018398] BTRFS info (device vdb): checking UUID tree
[ 2350.123817] BTRFS info (device vdb): dev_replace from /dev/vdc (devid 2) to /dev/vdh started
[ 2350.275831] BTRFS info (device vdb): use no compression, level 0
[ 2350.279478] BTRFS info (device vdb): disk space caching is enabled
[ 2351.586031] BTRFS info (device vdb): use zlib compression, level 3
[ 2351.588935] BTRFS info (device vdb): disk space caching is enabled
[ 2351.757525] BTRFS info (device vdb): dev_replace from /dev/vdc (devid 2) to /dev/vdh finished
[ 2351.761606] assertion failed: list_empty(&src_device->post_commit_list), file: fs/btrfs/dev-replace.c, line: 665
[ 2351.766222] ------------[ cut here ]------------
[ 2351.768904] kernel BUG at fs/btrfs/ctree.h:3518!
[ 2351.771982] invalid opcode: 0000 [#1] PREEMPT SMP
[ 2351.774878] CPU: 6 PID: 26220 Comm: btrfs Not tainted 5.1.0-rc7-default+ #16
[ 2351.778992] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-prebuilt.qemu.org 04/01/2014
[ 2351.785773] RIP: 0010:assfail.constprop.14+0x18/0x1a [btrfs]
[ 2351.789143] Code: c6 80 1f 37 c0 48 89 d1 48 89 c2 e8 7f e8 ff ff 58 c3 89 f1 48 c7 c2 f0 7d 36 c0 48 89 fe 48 c7 c7 50 23 37 c0 e8 e2 25 d7 d6 <0f> 0b 89 f1 48 c7 c2 61 7e 36 c0 48 89 fe 48 c7 c7 80 28 37 c0 e8
[ 2351.800167] RSP: 0018:ffffb6af0c07fc58 EFLAGS: 00010282
[ 2351.803316] RAX: 0000000000000064 RBX: ffff8fbfa065c000 RCX: 0000000000000000
[ 2351.807407] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff970c9e13
[ 2351.811676] RBP: ffffb6af0c07fcc0 R08: 0000000000000001 R09: 0000000000000000
[ 2351.815868] R10: ffff8fbfa1a57c00 R11: 0000000000000000 R12: ffff8fbfa065f658
[ 2351.820078] R13: ffff8fbfa065f5b8 R14: 0000000000000002 R15: ffff8fbfa1dc7000
[ 2351.824435] FS:  00007f07984a48c0(0000) GS:ffff8fbfb7800000(0000) knlGS:0000000000000000
[ 2351.829613] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2351.833253] CR2: 00007fb27c8e330c CR3: 000000021bfe7000 CR4: 00000000000006e0
[ 2351.836535] Call Trace:
[ 2351.837705]  btrfs_dev_replace_finishing+0x585/0x600 [btrfs]
[ 2351.840662]  ? btrfs_dev_replace_by_ioctl+0x502/0x7f0 [btrfs]
[ 2351.843173]  btrfs_dev_replace_by_ioctl+0x502/0x7f0 [btrfs]
[ 2351.846375]  btrfs_ioctl+0x24d9/0x2e40 [btrfs]
[ 2351.849004]  ? writeback_single_inode+0xbe/0x110
[ 2351.851664]  ? do_sigaction+0x63/0x250
[ 2351.853477]  ? do_vfs_ioctl+0xa2/0x6f0
[ 2351.855295]  do_vfs_ioctl+0xa2/0x6f0
[ 2351.857691]  ? do_sigaction+0xfc/0x250
[ 2351.860046]  ksys_ioctl+0x3a/0x70
[ 2351.862109]  __x64_sys_ioctl+0x16/0x20
[ 2351.864235]  do_syscall_64+0x54/0x190
[ 2351.865969]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 2351.868919] RIP: 0033:0x7f079859c607
[ 2351.871253] Code: 00 00 90 48 8b 05 91 88 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 61 88 0c 00 f7 d8 64 89 01 48
[ 2351.882057] RSP: 002b:00007ffe865db768 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 2351.886691] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f079859c607
[ 2351.890792] RDX: 00007ffe865dbba0 RSI: 00000000ca289435 RDI: 0000000000000003
[ 2351.894822] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 2351.898903] R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffe865df280
[ 2351.903036] R13: 0000000000000001 R14: 0000000000000004 R15: 00005622c7bc32a0

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B69EA10B41D
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 18:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfK0RHz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 12:07:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:35886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbfK0RHz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 12:07:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A29A5B2B7;
        Wed, 27 Nov 2019 17:07:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 05374DA733; Wed, 27 Nov 2019 18:07:50 +0100 (CET)
Date:   Wed, 27 Nov 2019 18:07:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] btrfs: reset device back to allocation state when
 removing
Message-ID: <20191127170749.GW2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20191126084006.23262-1-jthumshirn@suse.de>
 <20191126084006.23262-3-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126084006.23262-3-jthumshirn@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 26, 2019 at 09:40:06AM +0100, Johannes Thumshirn wrote:
> +	ASSERT(atomic_read(&device->dev_stats_ccnt) == 0);

btrfs/020               [16:59:58][ 3477.975072] run fstests btrfs/020 at 2019-11-27 16:59:58
[ 3478.974314] kworker/dying (5607) used greatest stack depth: 10792 bytes left
[ 3479.206988] BTRFS: device fsid 818a4909-467d-4599-979c-3b258fb4fc41 devid 1 transid 5 /dev/loop0 scanned by mkfs.btrfs (27347)
[ 3479.234212] BTRFS: device fsid 818a4909-467d-4599-979c-3b258fb4fc41 devid 2 transid 5 /dev/loop1 scanned by mkfs.btrfs (27347)
[ 3479.343996] BTRFS info (device loop0): disk space caching is enabled
[ 3479.349590] BTRFS info (device loop0): has skinny extents
[ 3479.352721] BTRFS info (device loop0): flagging fs with big metadata feature
[ 3479.360793] BTRFS info (device loop0): enabling ssd optimizations
[ 3479.614065] assertion failed: atomic_read(&device->dev_stats_ccnt) == 0, in fs/btrfs/volumes.c:1093
[ 3479.622041] ------------[ cut here ]------------
[ 3479.625272] kernel BUG at fs/btrfs/ctree.h:3118!
[ 3479.628555] invalid opcode: 0000 [#1] SMP
[ 3479.631350] CPU: 1 PID: 27375 Comm: umount Not tainted 5.4.0-rc8-default+ #882
[ 3479.633838] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-rebuilt.opensuse.org 04/01/2014
[ 3479.637681] RIP: 0010:assfail.constprop.0+0x18/0x26 [btrfs]
[ 3479.646004] RSP: 0018:ffff9f4444a6fd98 EFLAGS: 00010246
[ 3479.647947] RAX: 0000000000000057 RBX: ffff9e0e6bb64c00 RCX: 0000000000000006
[ 3479.650343] RDX: 0000000000000000 RSI: ffff9e0e71352408 RDI: ffff9e0e71351bc0
[ 3479.652838] RBP: ffff9e0e6bb64c60 R08: 0000032a29a25ac1 R09: 0000000000000000
[ 3479.654766] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9e0e746e0200
[ 3479.656866] R13: ffff9e0e746e0200 R14: ffff9e0e746e0318 R15: ffff9e0e6bb61000
[ 3479.658852] FS:  00007fabe5d8a800(0000) GS:ffff9e0e7d800000(0000) knlGS:0000000000000000
[ 3479.661542] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3479.663642] CR2: 00007ffeb8101f68 CR3: 000000004e979002 CR4: 0000000000160ee0
[ 3479.666132] Call Trace:
[ 3479.667333]  close_fs_devices.cold+0x66/0x77 [btrfs]
[ 3479.669143]  btrfs_close_devices+0x22/0x90 [btrfs]
[ 3479.670733]  close_ctree+0x2b9/0x32c [btrfs]
[ 3479.672296]  generic_shutdown_super+0x69/0x100
[ 3479.673662]  kill_anon_super+0x14/0x30
[ 3479.675045]  btrfs_kill_super+0x12/0xa0 [btrfs]
[ 3479.676550]  deactivate_locked_super+0x2c/0x70
[ 3479.678056]  cleanup_mnt+0x100/0x160
[ 3479.679245]  task_work_run+0x90/0xc0
[ 3479.680582]  exit_to_usermode_loop+0x96/0xa0
[ 3479.681945]  do_syscall_64+0x19d/0x1f0
[ 3479.683243]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 3479.684908] RIP: 0033:0x7fabe5fce4e7
[ 3479.691687] RSP: 002b:00007ffeb81037c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
[ 3479.694285] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fabe5fce4e7
[ 3479.696603] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000056236d27cb80
[ 3479.698989] RBP: 000056236d27c970 R08: 0000000000000000 R09: 00007ffeb8102540
[ 3479.701220] R10: 000056236d27cba0 R11: 0000000000000246 R12: 000056236d27cb80
[ 3479.703416] R13: 0000000000000000 R14: 000056236d27ca68 R15: 0000000000000000
[ 3479.705272] Modules linked in: xxhash_generic btrfs libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
[ 3479.709315] ---[ end trace 6a6ab278b1509a6f ]---
[ 3479.710971] RIP: 0010:assfail.constprop.0+0x18/0x26 [btrfs]
[ 3479.718120] RSP: 0018:ffff9f4444a6fd98 EFLAGS: 00010246
[ 3479.719761] RAX: 0000000000000057 RBX: ffff9e0e6bb64c00 RCX: 0000000000000006
[ 3479.721828] RDX: 0000000000000000 RSI: ffff9e0e71352408 RDI: ffff9e0e71351bc0
[ 3479.723586] RBP: ffff9e0e6bb64c60 R08: 0000032a29a25ac1 R09: 0000000000000000
[ 3479.725770] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9e0e746e0200
[ 3479.727906] R13: ffff9e0e746e0200 R14: ffff9e0e746e0318 R15: ffff9e0e6bb61000
[ 3479.739121] FS:  00007fabe5d8a800(0000) GS:ffff9e0e7d800000(0000) knlGS:0000000000000000
[ 3479.741653] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3479.743411] CR2: 00007ffeb8101f68 CR3: 000000004e979002 CR4: 0000000000160ee0

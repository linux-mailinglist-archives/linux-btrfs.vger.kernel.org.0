Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6B8148A36
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbgAXOoa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:44:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:41524 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgAXOo3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:44:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3E117AFBF;
        Fri, 24 Jan 2020 14:44:26 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5BC0CDA730; Fri, 24 Jan 2020 15:44:09 +0100 (CET)
Date:   Fri, 24 Jan 2020 15:44:09 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.cz,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: scrub: Require mandatory block group RO for
 dev-replace
Message-ID: <20200124144409.GM3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <20200123235820.20764-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123235820.20764-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On current master branch (4703d9119972bf58) with this patch btrfs/011
prints a warning from this code:

 502         ret = btrfs_dev_replace_finishing(fs_info, ret);
 503         if (ret == -EINPROGRESS) {
 504                 ret = BTRFS_IOCTL_DEV_REPLACE_RESULT_SCRUB_INPROGRESS;
 505         } else if (ret != -ECANCELED) {
 506                 WARN_ON(ret);
 507         }

with ret == -ENOSPC

The purpose seems to be to catch generic error codes other than
EINPROGRESS and ECNACELED, I don't see much point printing a warning in
that case. But it' a new ENOSPC problem, likely caused by the
read-only status switching.

My test devices are 12G, there's full log of the test to see at which
phase it happened.

[ 1891.998975] BTRFS warning (device vdd): failed setting block group ro: -28
[ 1892.038338] BTRFS error (device vdd): btrfs_scrub_dev(/dev/vdd, 1, /dev/vdb) failed -28
[ 1892.059993] ------------[ cut here ]------------
[ 1892.063032] WARNING: CPU: 2 PID: 2244 at fs/btrfs/dev-replace.c:506 btrfs_dev_replace_start.cold+0xf9/0x140 [btrfs]
[ 1892.068628] Modules linked in: xxhash_generic btrfs blake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
[ 1892.074346] CPU: 2 PID: 2244 Comm: btrfs Not tainted 5.5.0-rc7-default+ #942
[ 1892.076559] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[ 1892.079956] RIP: 0010:btrfs_dev_replace_start.cold+0xf9/0x140 [btrfs]
[ 1892.096576] RSP: 0018:ffffbb58c7b3fd10 EFLAGS: 00010286
[ 1892.098311] RAX: 00000000ffffffe4 RBX: 0000000000000001 RCX: 8888888888888889
[ 1892.100342] RDX: 0000000000000001 RSI: ffff9e889645f5d8 RDI: ffffffff92821080
[ 1892.102291] RBP: ffff9e889645c000 R08: 000001b8878fe1f6 R09: 0000000000000000
[ 1892.104239] R10: ffffbb58c7b3fd08 R11: 0000000000000000 R12: ffff9e88a0017000
[ 1892.106434] R13: ffff9e889645f608 R14: ffff9e88794e1000 R15: ffff9e88a07b5200
[ 1892.108642] FS:  00007fcaed3f18c0(0000) GS:ffff9e88bda00000(0000) knlGS:0000000000000000
[ 1892.111558] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1892.113492] CR2: 00007f52509ff420 CR3: 00000000603dd002 CR4: 0000000000160ee0
[ 1892.115814] Call Trace:
[ 1892.116896]  btrfs_dev_replace_by_ioctl+0x35/0x60 [btrfs]
[ 1892.118962]  btrfs_ioctl+0x1d62/0x2550 [btrfs]
[ 1892.120633]  ? __lock_acquire+0x272/0x1320
[ 1892.122177]  ? kvm_sched_clock_read+0x14/0x30
[ 1892.123629]  ? do_sigaction+0xf8/0x240
[ 1892.124919]  ? kvm_sched_clock_read+0x14/0x30
[ 1892.126418]  ? sched_clock+0x5/0x10
[ 1892.127534]  ? sched_clock_cpu+0x10/0x120
[ 1892.129096]  ? do_sigaction+0xf8/0x240
[ 1892.130525]  ? do_vfs_ioctl+0x56e/0x770
[ 1892.131818]  do_vfs_ioctl+0x56e/0x770
[ 1892.133012]  ? do_sigaction+0xf8/0x240
[ 1892.134228]  ksys_ioctl+0x3a/0x70
[ 1892.135447]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[ 1892.137148]  __x64_sys_ioctl+0x16/0x20
[ 1892.138702]  do_syscall_64+0x50/0x210
[ 1892.140095]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 1892.141911] RIP: 0033:0x7fcaed61e387
[ 1892.149247] RSP: 002b:00007ffcb47fc2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1892.151839] RAX: ffffffffffffffda RBX: 00007ffcb47ff12d RCX: 00007fcaed61e387
[ 1892.154060] RDX: 00007ffcb47fd160 RSI: 00000000ca289435 RDI: 0000000000000003
[ 1892.156191] RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
[ 1892.158317] R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000003
[ 1892.160564] R13: 0000000000000001 R14: 0000000000000000 R15: 00005624ff1602e0
[ 1892.162736] irq event stamp: 244626
[ 1892.164191] hardirqs last  enabled at (244625): [<ffffffff9178860e>] _raw_spin_unlock_irqrestore+0x3e/0x50
[ 1892.167531] hardirqs last disabled at (244626): [<ffffffff91002aeb>] trace_hardirqs_off_thunk+0x1a/0x1c
[ 1892.170875] softirqs last  enabled at (244482): [<ffffffff91a00358>] __do_softirq+0x358/0x52b
[ 1892.174005] softirqs last disabled at (244471): [<ffffffff9108ac1d>] irq_exit+0x9d/0xb0
[ 1892.176555] ---[ end trace d72b653b61eb7d20 ]---
[failed, exit status 1] [14:22:59]- output mismatch (see /tmp/fstests/results//btrfs/011.out.bad)
    --- tests/btrfs/011.out     2018-04-12 16:57:00.608225550 +0000
    +++ /tmp/fstests/results//btrfs/011.out.bad 2020-01-24 14:22:59.248000000 +0000
    @@ -1,3 +1,4 @@
     QA output created by 011
     *** test btrfs replace
    -*** done
    +failed: '/sbin/btrfs replace start -Bf -r /dev/vdd /dev/vdb /tmp/scratch'
    +(see /tmp/fstests/results//btrfs/011.full for details)
    ...
    (Run 'diff -u /tmp/fstests/tests/btrfs/011.out /tmp/fstests/results//btrfs/011.out.bad'  to see the entire diff)

btrfs/011               [13:59:50][  504.570047] run fstests btrfs/011 at 2020-01-24 13:59:50
[  505.710501] BTRFS: device fsid cd48459b-2332-425b-9d4e-324021eb0f2a devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (20824)
[  505.740305] BTRFS info (device vdb): turning on discard
[  505.742954] BTRFS info (device vdb): disk space caching is enabled
[  505.745007] BTRFS info (device vdb): has skinny extents
[  505.747096] BTRFS info (device vdb): flagging fs with big metadata feature
[  505.755093] BTRFS info (device vdb): checking UUID tree
[  521.548385] BTRFS info (device vdb): dev_replace from /dev/vdb (devid 1) to /dev/vdc started
[  525.294200] BTRFS info (device vdb): dev_replace from /dev/vdb (devid 1) to /dev/vdc finished
[  526.798086] BTRFS info (device vdb): scrub: started on devid 1
[  528.104425] BTRFS info (device vdb): scrub: finished on devid 1 with status: 0
[  528.393736] BTRFS info (device vdc): turning on discard
[  528.396009] BTRFS info (device vdc): disk space caching is enabled
[  528.398144] BTRFS info (device vdc): has skinny extents
[  528.597381] BTRFS: device fsid 20fd7216-ce75-4761-bb61-a5819aef05b6 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (27027)
[  528.626562] BTRFS info (device vdb): turning on discard
[  528.629852] BTRFS info (device vdb): disk space caching is enabled
[  528.633442] BTRFS info (device vdb): has skinny extents
[  528.640914] BTRFS info (device vdb): checking UUID tree
[  548.785255] BTRFS info (device vdb): dev_replace from /dev/vdb (devid 1) to /dev/vdc started
[  551.256550] BTRFS info (device vdb): dev_replace from /dev/vdb (devid 1) to /dev/vdc finished
[  557.620409] BTRFS info (device vdb): scrub: started on devid 1
[  559.258036] BTRFS info (device vdb): scrub: finished on devid 1 with status: 0
[  559.646237] BTRFS info (device vdc): turning on discard
[  559.649237] BTRFS info (device vdc): disk space caching is enabled
[  559.652122] BTRFS info (device vdc): has skinny extents
[  561.076431] BTRFS: device fsid e8c0f848-fd83-4401-95ff-503d3bba3c08 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (750)
[  561.103870] BTRFS info (device vdb): turning on discard
[  561.106896] BTRFS info (device vdb): disk space caching is enabled
[  561.110432] BTRFS info (device vdb): has skinny extents
[  561.113446] BTRFS info (device vdb): flagging fs with big metadata feature
[  561.121762] BTRFS info (device vdb): checking UUID tree
[  576.690406] BTRFS info (device vdb): dev_replace from /dev/vdb (devid 1) to /dev/vdc started
[  581.249317] BTRFS info (device vdb): dev_replace from /dev/vdb (devid 1) to /dev/vdc finished
[  584.252317] BTRFS info (device vdb): scrub: started on devid 1
[  585.192576] BTRFS info (device vdb): scrub: finished on devid 1 with status: 0
[  586.225905] BTRFS info (device vdc): turning on discard
[  586.229054] BTRFS info (device vdc): disk space caching is enabled
[  586.231819] BTRFS info (device vdc): has skinny extents
[  586.599308] BTRFS: device fsid dd789d35-4d2f-428c-aa03-88ffd5a734cb devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (6931)
[  586.628325] BTRFS info (device vdb): turning on discard
[  586.630954] BTRFS info (device vdb): disk space caching is enabled
[  586.634146] BTRFS info (device vdb): has skinny extents
[  586.636859] BTRFS info (device vdb): flagging fs with big metadata feature
[  586.645020] BTRFS info (device vdb): checking UUID tree
[  608.342513] BTRFS info (device vdb): dev_replace from /dev/vdb (devid 1) to /dev/vdc started
[  611.869495] BTRFS info (device vdb): dev_replace from /dev/vdb (devid 1) to /dev/vdc canceled
[  646.226962] BTRFS info (device vdb): scrub: started on devid 1
[  652.537808] BTRFS info (device vdb): scrub: finished on devid 1 with status: 0
[  654.148332] BTRFS info (device vdb): turning on discard
[  654.152563] BTRFS info (device vdb): disk space caching is enabled
[  654.157499] BTRFS info (device vdb): has skinny extents
[  655.318709] BTRFS: device fsid cc2a56c5-5371-4b14-88af-527515683491 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (14080)
[  655.341656] BTRFS info (device vdb): turning on discard
[  655.344075] BTRFS info (device vdb): disk space caching is enabled
[  655.346723] BTRFS info (device vdb): has skinny extents
[  655.355368] BTRFS info (device vdb): checking UUID tree
[  688.140556] BTRFS info (device vdb): dev_replace from /dev/vdb (devid 1) to /dev/vdc started
[  696.723022] BTRFS info (device vdb): dev_replace from /dev/vdb (devid 1) to /dev/vdc finished
[  707.940962] BTRFS info (device vdb): scrub: started on devid 1
[  711.456414] BTRFS info (device vdb): scrub: finished on devid 1 with status: 0
[  719.263299] BTRFS info (device vdc): turning on discard
[  719.266339] BTRFS info (device vdc): disk space caching is enabled
[  719.269694] BTRFS info (device vdc): has skinny extents
[  722.816437] BTRFS: device fsid 9d18355e-3861-4506-a847-b18a0f36a046 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (20268)
[  722.821079] BTRFS: device fsid 9d18355e-3861-4506-a847-b18a0f36a046 devid 2 transid 5 /dev/vdc scanned by mkfs.btrfs (20268)
[  722.821079] BTRFS: device fsid 9d18355e-3861-4506-a847-b18a0f36a046 devid 2 transid 5 /dev/vdc scanned by mkfs.btrfs (20268)
[  722.850081] BTRFS info (device vdb): turning on discard
[  722.853321] BTRFS info (device vdb): disk space caching is enabled
[  722.855710] BTRFS info (device vdb): has skinny extents
[  722.857894] BTRFS info (device vdb): flagging fs with big metadata feature
[  722.866879] BTRFS info (device vdb): checking UUID tree
[  738.622392] BTRFS info (device vdb): dev_replace from /dev/vdb (devid 1) to /dev/vdd started
[  739.728325] BTRFS info (device vdb): dev_replace from /dev/vdb (devid 1) to /dev/vdd finished
[  740.017266] BTRFS info (device vdb): scrub: started on devid 1
[  740.017277] BTRFS info (device vdb): scrub: started on devid 2
[  740.714789] BTRFS info (device vdb): scrub: finished on devid 2 with status: 0
[  740.714965] BTRFS info (device vdb): scrub: finished on devid 1 with status: 0
[  741.234158] BTRFS info (device vdd): turning on discard
[  741.237294] BTRFS info (device vdd): disk space caching is enabled
[  741.240088] BTRFS info (device vdd): has skinny extents
[  741.485130] BTRFS: device fsid ad5bec99-e695-4960-b622-18a890a2a566 devid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (26509)
[  741.489012] BTRFS: device fsid ad5bec99-e695-4960-b622-18a890a2a566 devid 2 transid 5 /dev/vdc scanned by mkfs.btrfs (26509)
[  741.517997] BTRFS info (device vdb): turning on discard
[  741.522388] BTRFS info (device vdb): disk space caching is enabled
[  741.527084] BTRFS info (device vdb): has skinny extents
[  741.528865] BTRFS info (device vdb): flagging fs with big metadata feature
[  741.536809] BTRFS info (device vdb): checking UUID tree
[  803.614447] BTRFS info (device vdb): dev_replace from /dev/vdb (devid 1) to /dev/vdd started
[ 1561.888757] BTRFS info (device vdb): dev_replace from /dev/vdb (devid 1) to /dev/vdd finished
[ 1563.133038] BTRFS info (device vdb): scrub: started on devid 2
[ 1563.133043] BTRFS info (device vdb): scrub: started on devid 1
[ 1851.421233] BTRFS info (device vdb): scrub: finished on devid 2 with status: 0
[ 1857.639294] BTRFS info (device vdb): scrub: finished on devid 1 with status: 0
[ 1869.454605] BTRFS info (device vdd): turning on discard
[ 1869.458972] BTRFS info (device vdd): disk space caching is enabled
[ 1869.461062] BTRFS info (device vdd): has skinny extents
[ 1891.972499] BTRFS info (device vdd): dev_replace from /dev/vdd (devid 1) to /dev/vdb started
[ 1891.998975] BTRFS warning (device vdd): failed setting block group ro: -28
[ 1892.038338] BTRFS error (device vdd): btrfs_scrub_dev(/dev/vdd, 1, /dev/vdb) failed -28
(stacktrace)

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53F699624C
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 16:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfHTOUz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 10:20:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:48132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728770AbfHTOUz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 10:20:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 59341AE82;
        Tue, 20 Aug 2019 14:20:53 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B0ACFDA7DA; Tue, 20 Aug 2019 16:21:19 +0200 (CEST)
Date:   Tue, 20 Aug 2019 16:21:19 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix use-after-free when using the tree
 modification log
Message-ID: <20190820142119.GQ24086@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190812181429.11444-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812181429.11444-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 12, 2019 at 07:14:29PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At ctree.c:get_old_root(), we are accessing a root's header owner field
> after we have freed the respective extent buffer. This results in an
> use-after-free that can lead to crashes, and when CONFIG_DEBUG_PAGEALLOC
> is set, results in a stack trace like the following:
> 
>   [ 3876.799331] stack segment: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
>   [ 3876.799363] CPU: 0 PID: 15436 Comm: pool Not tainted 5.3.0-rc3-btrfs-next-54 #1
>   [ 3876.799385] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
>   [ 3876.799433] RIP: 0010:btrfs_search_old_slot+0x652/0xd80 [btrfs]
>   (...)
>   [ 3876.799502] RSP: 0018:ffff9f08c1a2f9f0 EFLAGS: 00010286
>   [ 3876.799518] RAX: ffff8dd300000000 RBX: ffff8dd85a7a9348 RCX: 000000038da26000
>   [ 3876.799538] RDX: 0000000000000000 RSI: ffffe522ce368980 RDI: 0000000000000246
>   [ 3876.799559] RBP: dae1922adadad000 R08: 0000000008020000 R09: ffffe522c0000000
>   [ 3876.799579] R10: ffff8dd57fd788c8 R11: 000000007511b030 R12: ffff8dd781ddc000
>   [ 3876.799599] R13: ffff8dd9e6240578 R14: ffff8dd6896f7a88 R15: ffff8dd688cf90b8
>   [ 3876.799620] FS:  00007f23ddd97700(0000) GS:ffff8dda20200000(0000) knlGS:0000000000000000
>   [ 3876.799643] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [ 3876.799660] CR2: 00007f23d4024000 CR3: 0000000710bb0005 CR4: 00000000003606f0
>   [ 3876.799682] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [ 3876.799703] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [ 3876.799723] Call Trace:
>   [ 3876.799735]  ? do_raw_spin_unlock+0x49/0xc0
>   [ 3876.799749]  ? _raw_spin_unlock+0x24/0x30
>   [ 3876.799779]  resolve_indirect_refs+0x1eb/0xc80 [btrfs]
>   [ 3876.799810]  find_parent_nodes+0x38d/0x1180 [btrfs]
>   [ 3876.799841]  btrfs_check_shared+0x11a/0x1d0 [btrfs]
>   [ 3876.799870]  ? extent_fiemap+0x598/0x6e0 [btrfs]
>   [ 3876.799895]  extent_fiemap+0x598/0x6e0 [btrfs]
>   [ 3876.799913]  do_vfs_ioctl+0x45a/0x700
>   [ 3876.799926]  ksys_ioctl+0x70/0x80
>   [ 3876.799938]  ? trace_hardirqs_off_thunk+0x1a/0x20
>   [ 3876.799953]  __x64_sys_ioctl+0x16/0x20
>   [ 3876.799965]  do_syscall_64+0x62/0x220
>   [ 3876.799977]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>   [ 3876.799993] RIP: 0033:0x7f23e0013dd7
>   (...)
>   [ 3876.800056] RSP: 002b:00007f23ddd96ca8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>   [ 3876.800078] RAX: ffffffffffffffda RBX: 00007f23d80210f8 RCX: 00007f23e0013dd7
>   [ 3876.800099] RDX: 00007f23d80210f8 RSI: 00000000c020660b RDI: 0000000000000003
>   [ 3876.800626] RBP: 000055fa2a2a2440 R08: 0000000000000000 R09: 00007f23ddd96d7c
>   [ 3876.801143] R10: 00007f23d8022000 R11: 0000000000000246 R12: 00007f23ddd96d80
>   [ 3876.801662] R13: 00007f23ddd96d78 R14: 00007f23d80210f0 R15: 00007f23ddd96d80
>   (...)
>   [ 3876.805107] ---[ end trace e53161e179ef04f9 ]---
> 
> Fix that by saving the root's header owner field into a local variable
> before freeing the root's extent buffer, and then use that local variable
> when needed.
> 
> Fixes: 30b0463a9394d9 ("Btrfs: fix accessing the root pointer in tree mod log functions")
> CC: stable@vger.kernel.org # 3.10+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Added to 5.3 queue, thanks.

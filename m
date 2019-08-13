Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 456408B02D
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2019 08:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfHMGyQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 02:54:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:48824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbfHMGyP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 02:54:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 48864ACBD;
        Tue, 13 Aug 2019 06:54:14 +0000 (UTC)
Subject: Re: [PATCH] Btrfs: fix use-after-free when using the tree
 modification log
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20190812181429.11444-1-fdmanana@kernel.org>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b15a1f35-f07c-cbb8-d60b-4bbed5c32209@suse.com>
Date:   Tue, 13 Aug 2019 09:54:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812181429.11444-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 12.08.19 г. 21:14 ч., fdmanana@kernel.org wrote:
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

Reviewed-by: Nikolay Borisov <nborisov@suse.com>


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABECB64D4E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Dec 2022 02:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiLOBFP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Dec 2022 20:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOBFN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Dec 2022 20:05:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB3443845
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Dec 2022 17:05:11 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MOzSu-1pHeJV1pq0-00POPy; Thu, 15
 Dec 2022 02:05:02 +0100
Message-ID: <46d2d0fb-0065-c61c-8429-453a4cbc833c@gmx.com>
Date:   Thu, 15 Dec 2022 09:04:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] btrfs: fix logical_ino ioctl panic
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <80f01f297721481fd0d4cbf03fd2550e25b578fb.1671058852.git.boris@bur.io>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <80f01f297721481fd0d4cbf03fd2550e25b578fb.1671058852.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3e235+lS9wQGX4yA4l2iBAbFF/Gv3d2/kExN/faCgGpw+gbl/FS
 XREysenrnTxCLDq3+X8B4KU3uwdAoIjRJfSr1yToYfERiln+mPZq/i7WtgrdaFG+cQkLO1Y
 VIAuBVDpmpWHCzsN/Uvzz6WRhWi90IU/ZISU85MvfDge+EeGGLjXuHFIaC5GAHyrdHloax0
 ZRiqpJuas8GDdzQOxHvOw==
UI-OutboundReport: notjunk:1;M01:P0:Et1Q5Tv3xeI=;JbfelGGfMka0y/rPCgS+PWMxuDo
 hVNCwl249l2Ik56s/3DGJBourA9Ta4APvuazLgJASDjn9EECBHHKDRaSEpA1t+0J2XO8cjwID
 kUzQNcZsrh9vFabEo09j4EtDBKo0In+Az8f98Pgm1ax+QVxe2QeuY6D1XGC37kH281F42DuRi
 6vwUimI0iO+iVR0tdZCzZo6F4ZMJ8M8bF9CsXVYN2wEqwUgt7s2UismH5pULK0lNDVCycD4b1
 xjwUn/c59X8LUaZ00HSP6L7ckB5e8ZX5UOCNN6pUmgLVC7z9ahXb/VIGqXbGiy3HcOtnAVO8z
 7cOxmbYu+ctVpEW3OlqKn7kQzrIJp5u7tuqYj9isirhVxRrbkVw3fAMjn7ZSiy1kZdsIQ+syO
 Yr6IJ3Mi65VBb4Nz7+noa8neScD28AVXkPm8K0WpJ0/WNF4/PRJeICn6LOQcgmfnvP9psirDV
 YfpYieEPQqfpLLamBu5AFttHu4mroY+jKPGPM6Ffwu0PsxoAADu7itHmB1R7YoOFuzzgxXU2n
 X9n+ESBWaI0zXvFWkDPCOpzWRDRJEqpwYSq/F3Dq+JGIQD05CdEuA3c1W7vbeNbUi29p5fl12
 cRS4LS3yVKImg+zok41YmZTPodXpCub3TCglI8qTX0RPiHNbzG7aiGONcUwUK2Buc/XFGJzue
 AAShQaTQvabzJDkH3njY1isUOpTDbmqa9dXtuG3l8tGPuki/R1wBGRfuZPyrA0ya6gbqCvQL3
 SXdmUIQn9X+Dh8b0Dyp+lA6nnm6KThsSA0eH8uardTVm5KqHYYcfyvb+mnc/kdiXnzVaWtaLE
 5Y6SmTi9bGE8cP254ufHXO2nDUg0KNQxU1qBIafVXlIkUVC1hl0mKfnRDcWAT5W9sYkSYfqZ7
 jXlAsb/UBl+/yCeRjCwq1HELzRnu8fDUEr+33x499qQNQghARf/rJv6PlZg/PS2qbjZd0Asoz
 zWJ3nt4e2um0UvLhqwnujhGHTog=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/15 07:05, Boris Burkov wrote:
> If a file consists of an inline extent followed by a regular or prealloc
> extent, then a legitimate attempt to resolve a logical address in the
> non-inline region will result in add_all_parents reading the invalid
> offset field of the inline extent. If the inline extent item is placed
> in the leaf eb s.t. it is the first item, attempting to access the
> offset field will not only be meaningless, it will go past the end of
> the eb and cause this panic:
> 
> [   17.626048] BTRFS warning (device dm-2): bad eb member end: ptr
> 0x3fd4 start 30834688 member offset 16377 size 8
> [   17.631693] general protection fault, probably for non-canonical
> address 0x5088000000000: 0000 [#1] SMP PTI
> [   17.635041] CPU: 2 PID: 1267 Comm: btrfs Not tainted
> 5.12.0-07246-g75175d5adc74-dirty #199
> [   17.637969] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [   17.641995] RIP: 0010:btrfs_get_64+0xe7/0x110
> [   17.643544] Code: 78 bf 08 00 00 00 48 b8 00 00 00 00 80 88 ff ff 4a
> 8d 34 04 48 c1 fa 06 48 c1 e2 0c 48 01 c2 29 cf 74 14 31 c0 89 c1 83 c0
> 01 <44> 0f b6 04 0a 39 f8 44 88 04 0e 72 ee 48 8b 04 24 e9 7a ff ff ff
> [   17.649890] RSP: 0018:ffffc90001f73a08 EFLAGS: 00010202
> [   17.651652] RAX: 0000000000000001 RBX: ffff88810c42d000 RCX:
> 0000000000000000
> [   17.653921] RDX: 0005088000000000 RSI: ffffc90001f73a0f RDI:
> 0000000000000001
> [   17.656174] RBP: 0000000000000ff9 R08: 0000000000000007 R09:
> c0000000fffeffff
> [   17.658441] R10: ffffc90001f73790 R11: ffffc90001f73788 R12:
> ffff888106afe918
> [   17.661070] R13: 0000000000003fd4 R14: 0000000000003f6f R15:
> cdcdcdcdcdcdcdcd
> [   17.663617] FS:  00007f64e7627d80(0000) GS:ffff888237c80000(0000)
> knlGS:0000000000000000
> [   17.666525] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   17.668664] CR2: 000055d4a39152e8 CR3: 000000010c596002 CR4:
> 0000000000770ee0
> [   17.671253] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [   17.673634] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [   17.676034] PKRU: 55555554
> [   17.677004] Call Trace:
> [   17.677877]  add_all_parents+0x276/0x480
> [   17.679325]  find_parent_nodes+0xfae/0x1590
> [   17.680771]  btrfs_find_all_leafs+0x5e/0xa0
> [   17.682217]  iterate_extent_inodes+0xce/0x260
> [   17.683809]  ? btrfs_inode_flags_to_xflags+0x50/0x50
> [   17.685597]  ? iterate_inodes_from_logical+0xa1/0xd0
> [   17.687404]  iterate_inodes_from_logical+0xa1/0xd0
> [   17.689121]  ? btrfs_inode_flags_to_xflags+0x50/0x50
> [   17.691010]  btrfs_ioctl_logical_to_ino+0x131/0x190
> [   17.692946]  btrfs_ioctl+0x104a/0x2f60
> [   17.694384]  ? selinux_file_ioctl+0x182/0x220
> [   17.695995]  ? __x64_sys_ioctl+0x84/0xc0
> [   17.697394]  __x64_sys_ioctl+0x84/0xc0
> [   17.698697]  do_syscall_64+0x33/0x40
> [   17.700017]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   17.701753] RIP: 0033:0x7f64e72761b7
> [   17.703011] Code: 3c 1c 48 f7 d8 49 39 c4 72 b9 e8 24 ff ff ff 85 c0
> 78 be 4c 89 e0 5b 5d 41 5c c3 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 89 9c 0c 00 f7 d8 64 89 01 48
> [   17.709355] RSP: 002b:00007ffefb067f58 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [   17.712088] RAX: ffffffffffffffda RBX: 0000000000000003 RCX:
> 00007f64e72761b7
> [   17.714667] RDX: 00007ffefb067fb0 RSI: 00000000c0389424 RDI:
> 0000000000000003
> [   17.717386] RBP: 00007ffefb06d188 R08: 000055d4a390d2b0 R09:
> 00007f64e7340a60
> [   17.719938] R10: 0000000000000231 R11: 0000000000000246 R12:
> 0000000000000001
> [   17.722383] R13: 0000000000000000 R14: 00000000c0389424 R15:
> 000055d4a38fd2a0
> [   17.724839] Modules linked in:
> [   17.726094] ---[ end trace e97f925b39774256 ]---
> 
> Fix the bug by detecting the inline extent item in add_all_parents and
> skipping to the next extent item.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Indeed a solid fix.

> ---
>   fs/btrfs/backref.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 21c92c74bf71..46851511b661 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -484,6 +484,7 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
>   	u64 wanted_disk_byte = ref->wanted_disk_byte;
>   	u64 count = 0;
>   	u64 data_offset;
> +	u8 type;
>   
>   	if (level != 0) {
>   		eb = path->nodes[level];
> @@ -538,6 +539,9 @@ static int add_all_parents(struct btrfs_backref_walk_ctx *ctx,
>   			continue;
>   		}
>   		fi = btrfs_item_ptr(eb, slot, struct btrfs_file_extent_item);
> +		type = btrfs_file_extent_type(eb, fi);
> +		if (type == BTRFS_FILE_EXTENT_INLINE)
> +			goto next;

Initially I thought we can not just skip to the next one, but 
considering we're called from iterate_inodes_from_logical(), and there 
will be no logical bytenr for any inlined extent at all, this is 
completely correct.

Maybe add a line of comment to explain the fact would be a little better?

Thanks,
Qu

>   		disk_byte = btrfs_file_extent_disk_bytenr(eb, fi);
>   		data_offset = btrfs_file_extent_offset(eb, fi);
>   

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 893719AE44
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Aug 2019 13:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392776AbfHWLlm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Aug 2019 07:41:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:41876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731551AbfHWLlm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Aug 2019 07:41:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3A1BFB06B
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Aug 2019 11:41:39 +0000 (UTC)
Subject: Re: [PATCH v2.1] btrfs: Detect unbalanced tree with empty leaf before
 crashing btree operations
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20190822021415.9425-1-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1e9bd953-8041-ce26-62f4-8a318334beaf@suse.com>
Date:   Fri, 23 Aug 2019 14:41:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822021415.9425-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.08.19 г. 5:14 ч., Qu Wenruo wrote:
> [BUG]
> With crafted image, btrfs will panic at btree operations:
>   kernel BUG at fs/btrfs/ctree.c:3894!
>   invalid opcode: 0000 [#1] SMP PTI
>   CPU: 0 PID: 1138 Comm: btrfs-transacti Not tainted 5.0.0-rc8+ #9
>   RIP: 0010:__push_leaf_left+0x6b6/0x6e0
>   Code: 00 00 48 98 48 8d 04 80 48 8d 74 80 65 e8 42 5a 04 00 48 8b bd 78 ff ff ff 8b bf 90 d0 00 00 89 7d 98 83 ef 65 e9 06 ff ff ff <0f> 0b 0f 0b 48 8b 85 78 ff ff ff 8b 90 90 d0 00 00 e9 eb fe ff ff
>   RSP: 0018:ffffc0bd4128b990 EFLAGS: 00010246
>   RAX: 0000000000000000 RBX: ffffa0a4ab8f0e38 RCX: 0000000000000000
>   RDX: ffffa0a280000000 RSI: 0000000000000000 RDI: ffffa0a4b3814000
>   RBP: ffffc0bd4128ba38 R08: 0000000000001000 R09: ffffc0bd4128b948
>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000240
>   R13: ffffa0a4b556fb60 R14: ffffa0a4ab8f0af0 R15: ffffa0a4ab8f0af0
>   FS: 0000000000000000(0000) GS:ffffa0a4b7a00000(0000) knlGS:0000000000000000
>   CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   CR2: 00007f2461c80020 CR3: 000000022b32a006 CR4: 00000000000206f0
>   Call Trace:
>   ? _cond_resched+0x1a/0x50
>   push_leaf_left+0x179/0x190
>   btrfs_del_items+0x316/0x470
>   btrfs_del_csums+0x215/0x3a0
>   __btrfs_free_extent.isra.72+0x5a7/0xbe0
>   __btrfs_run_delayed_refs+0x539/0x1120
>   btrfs_run_delayed_refs+0xdb/0x1b0
>   btrfs_commit_transaction+0x52/0x950
>   ? start_transaction+0x94/0x450
>   transaction_kthread+0x163/0x190
>   kthread+0x105/0x140
>   ? btrfs_cleanup_transaction+0x560/0x560
>   ? kthread_destroy_worker+0x50/0x50
>   ret_from_fork+0x35/0x40
>   Modules linked in:
>   ---[ end trace c2425e6e89b5558f ]---
> 
> [CAUSE]
> The offending csum tree looks like this:
> checksum tree key (CSUM_TREE ROOT_ITEM 0)
> node 29741056 level 1 items 14 free 107 generation 19 owner CSUM_TREE
>         ...
>         key (EXTENT_CSUM EXTENT_CSUM 85975040) block 29630464 gen 17
>         key (EXTENT_CSUM EXTENT_CSUM 89911296) block 29642752 gen 17 <<<
>         key (EXTENT_CSUM EXTENT_CSUM 92274688) block 29646848 gen 17
>         ...
> 
> leaf 29630464 items 6 free space 1 generation 17 owner CSUM_TREE
>         item 0 key (EXTENT_CSUM EXTENT_CSUM 85975040) itemoff 3987 itemsize 8
>                 range start 85975040 end 85983232 length 8192
>         ...
> leaf 29642752 items 0 free space 3995 generation 17 owner 0
>                     ^ empty leaf            invalid owner ^
> 
> leaf 29646848 items 1 free space 602 generation 17 owner CSUM_TREE
>         item 0 key (EXTENT_CSUM EXTENT_CSUM 92274688) itemoff 627 itemsize 3368
>                 range start 92274688 end 95723520 length 3448832
> 
> So we have a corrupted csum tree where one tree leaf is completely
> empty, causing unbalanced btree, thus leading to unexpected btree
> balance error.
> 
> [FIX]
> For this particular case, we handle it in two directions to catch it:
> - Check if the tree block is empty through btrfs_verify_level_key()
>   So that invalid tree blocks won't be read out through
>   btrfs_search_slot() and its variants.
> 
> - Check 0 tree owner in tree checker
>   NO tree is using 0 as its tree owner, detect it and reject at tree
>   block read time.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202821
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
> Changelog:
> v2:
> - Updated with patchset
>   "[PATCH v2 0/5] btrfs: Enhanced runtime defence against fuzzed images"
> v2.1:
> - Move the nritems check after generation check.
>   As we have reports of random false alert for new tree blocks of a
>   running transaction.
> ---
>  fs/btrfs/disk-io.c      | 10 ++++++++++
>  fs/btrfs/tree-checker.c |  6 ++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5f7ee70b3d1a..45725117ff74 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -416,6 +416,16 @@ int btrfs_verify_level_key(struct extent_buffer *eb, int level,
>  	 */
>  	if (btrfs_header_generation(eb) > fs_info->last_trans_committed)
>  		return 0;
> +
> +	/* We have @first_key, so this @eb must have at least one item */
> +	if (btrfs_header_nritems(eb) == 0) {
> +		btrfs_err(fs_info,
> +		"invalid tree nritems, bytenr=%llu nritems=0 expect >0",
> +			  eb->start);
> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> +		return -EUCLEAN;
> +	}
> +
>  	if (found_level)
>  		btrfs_node_key_to_cpu(eb, &found_key, 0);
>  	else
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index ccd5706199d7..cb6f43be69d4 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -899,6 +899,12 @@ static int check_leaf(struct extent_buffer *leaf, bool check_item_data)
>  				    owner);
>  			return -EUCLEAN;
>  		}
> +		/* Unknown tree */
> +		if (owner == 0) {
> +			generic_err(leaf, 0,
> +				"invalid owner, root 0 is not defined");
> +			return -EUCLEAN;
> +		}
>  		return 0;
>  	}
>  
> 

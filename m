Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B50124CF5A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 09:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgHUHfl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 03:35:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:45988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbgHUHfk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 03:35:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B8CAABED;
        Fri, 21 Aug 2020 07:36:06 +0000 (UTC)
Subject: Re: [PATCH 2/2] btrfs: pretty print leaked root name
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1597953516.git.josef@toxicpanda.com>
 <461693e5c015857e684878e99e5e65075bb97c13.1597953516.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d98bb04e-1bcf-80c7-26ae-e91f3ecfd818@suse.com>
Date:   Fri, 21 Aug 2020 10:35:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <461693e5c015857e684878e99e5e65075bb97c13.1597953516.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 20.08.20 г. 23:00 ч., Josef Bacik wrote:
> I'm a actual human being so am incapable of converting u64 to s64 in my
> head, so add a helper to get the pretty name of a root objectid and use
> that helper to spit out the name for any special roots for leaked roots,
> so I don't have to scratch my head and figure out which root I messed up
> the refs for.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/disk-io.c    |  8 +++++---
>  fs/btrfs/print-tree.c | 37 +++++++++++++++++++++++++++++++++++++
>  fs/btrfs/print-tree.h |  1 +
>  3 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index ac6d6fddd5f4..a7358e0f59de 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1506,11 +1506,13 @@ void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
>  	struct btrfs_root *root;
>  
>  	while (!list_empty(&fs_info->allocated_roots)) {
> +		const char *name = btrfs_root_name(root->root_key.objectid);
> +
>  		root = list_first_entry(&fs_info->allocated_roots,
>  					struct btrfs_root, leak_list);
> -		btrfs_err(fs_info, "leaked root %llu-%llu refcount %d",
> -			  root->root_key.objectid, root->root_key.offset,
> -			  refcount_read(&root->refs));
> +		btrfs_err(fs_info, "leaked root %s%lld-%llu refcount %d",

nit: Won't this string result in some rather awkward looking strings,
such as:

"leaked root ROOT_TREE<objectid>-<offset>..." i.e shouldn't the
(objectid,offset) pair be marked with parentheses?

> +			  name ? name : "", root->root_key.objectid,
> +			  root->root_key.offset, refcount_read(&root->refs));
>  		while (refcount_read(&root->refs) > 1)
>  			btrfs_put_root(root);
>  		btrfs_put_root(root);
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index 61f44e78e3c9..c633aec8973d 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -7,6 +7,43 @@
>  #include "disk-io.h"
>  #include "print-tree.h"
>  
> +struct name_map {
> +	u64 id;
> +	const char *name;
> +};
> +
> +static const struct name_map root_map[] = {
> +	{ BTRFS_ROOT_TREE_OBJECTID,		"ROOT_TREE"		},
> +	{ BTRFS_EXTENT_TREE_OBJECTID,		"EXTENT_TREE"		},
> +	{ BTRFS_CHUNK_TREE_OBJECTID,		"CHUNK_TREE"		},
> +	{ BTRFS_DEV_TREE_OBJECTID,		"DEV_TREE"		},
> +	{ BTRFS_FS_TREE_OBJECTID,		"FS_TREE"		},
> +	{ BTRFS_ROOT_TREE_DIR_OBJECTID,		"ROOT_TREE_DIR"		},
> +	{ BTRFS_CSUM_TREE_OBJECTID,		"CSUM_TREE"		},
> +	{ BTRFS_TREE_LOG_OBJECTID,		"TREE_LOG"		},
> +	{ BTRFS_QUOTA_TREE_OBJECTID,		"QUOTA_TREE"		},
> +	{ BTRFS_TREE_RELOC_OBJECTID,		"TREE_RELOC"		},
> +	{ BTRFS_UUID_TREE_OBJECTID,		"UUID_TREE"		},
> +	{ BTRFS_FREE_SPACE_TREE_OBJECTID,	"FREE_SPACE_TREE"	},
> +	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},
> +};
> +
> +const char *btrfs_root_name(u64 objectid)
> +{
> +	int i;
> +
> +	if (objectid >= BTRFS_FIRST_FREE_OBJECTID &&
> +	    objectid <= BTRFS_LAST_FREE_OBJECTID)
> +		return NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(root_map); i++) {
> +		if (root_map[i].id == objectid)
> +			return root_map[i].name;
> +	}
> +
> +	return NULL;
> +}
> +
>  static void print_chunk(struct extent_buffer *eb, struct btrfs_chunk *chunk)
>  {
>  	int num_stripes = btrfs_chunk_num_stripes(eb, chunk);
> diff --git a/fs/btrfs/print-tree.h b/fs/btrfs/print-tree.h
> index e6bb38fd75ad..dffdfa495297 100644
> --- a/fs/btrfs/print-tree.h
> +++ b/fs/btrfs/print-tree.h
> @@ -8,5 +8,6 @@
>  
>  void btrfs_print_leaf(struct extent_buffer *l);
>  void btrfs_print_tree(struct extent_buffer *c, bool follow);
> +const char *btrfs_root_name(u64 objectid);
>  
>  #endif
> 

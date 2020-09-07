Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A86925FA87
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Sep 2020 14:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgIGMbJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Sep 2020 08:31:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:53892 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbgIGMaU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Sep 2020 08:30:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23035B5D8;
        Mon,  7 Sep 2020 12:30:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5EB2FDA7C8; Mon,  7 Sep 2020 14:28:54 +0200 (CEST)
Date:   Mon, 7 Sep 2020 14:28:54 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/2] btrfs: pretty print leaked root name
Message-ID: <20200907122853.GZ28318@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1599157686.git.josef@toxicpanda.com>
 <d749b9482370c5c32d32fb9e8e2a6d4671b19732.1599157686.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d749b9482370c5c32d32fb9e8e2a6d4671b19732.1599157686.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 03, 2020 at 02:29:51PM -0400, Josef Bacik wrote:
> I'm a actual human being so am incapable of converting u64 to s64 in my
> head, so add a helper to get the pretty name of a root objectid and use
> that helper to spit out the name for any special roots for leaked roots,
> so I don't have to scratch my head and figure out which root I messed up
> the refs for.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/disk-io.c    |  6 ++++--
>  fs/btrfs/print-tree.c | 39 +++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/print-tree.h |  3 +++
>  3 files changed, 46 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 7147237d9bf0..71beb9493ab4 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1504,10 +1504,12 @@ void btrfs_check_leaked_roots(struct btrfs_fs_info *fs_info)
>  	struct btrfs_root *root;
>  
>  	while (!list_empty(&fs_info->allocated_roots)) {
> +		char buf[BTRFS_ROOT_NAME_BUF_LEN];
> +
>  		root = list_first_entry(&fs_info->allocated_roots,
>  					struct btrfs_root, leak_list);
> -		btrfs_err(fs_info, "leaked root %llu-%llu refcount %d",
> -			  root->root_key.objectid, root->root_key.offset,
> +		btrfs_err(fs_info, "leaked root %s refcount %d",
> +			  btrfs_root_name(root->root_key.objectid, buf),
>  			  refcount_read(&root->refs));
>  		while (refcount_read(&root->refs) > 1)
>  			btrfs_put_root(root);
> diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
> index 80567c11ec12..d0370075a719 100644
> --- a/fs/btrfs/print-tree.c
> +++ b/fs/btrfs/print-tree.c
> @@ -7,6 +7,45 @@
>  #include "disk-io.h"
>  #include "print-tree.h"
>  
> +struct name_map {
> +	u64 id;
> +	char *name;

	const char* or maybe even a fixed length string, removing the
	_TREE suffix

> +};
> +
> +static const struct name_map root_map[] = {
> +	{ BTRFS_ROOT_TREE_OBJECTID,		"ROOT_TREE"		},
> +	{ BTRFS_EXTENT_TREE_OBJECTID,		"EXTENT_TREE"		},
> +	{ BTRFS_CHUNK_TREE_OBJECTID,		"CHUNK_TREE"		},
> +	{ BTRFS_DEV_TREE_OBJECTID,		"DEV_TREE"		},
> +	{ BTRFS_FS_TREE_OBJECTID,		"FS_TREE"		},
> +	{ BTRFS_ROOT_TREE_DIR_OBJECTID,		"ROOT_TREE_DIR"		},

This is not a tree id

> +	{ BTRFS_CSUM_TREE_OBJECTID,		"CSUM_TREE"		},
> +	{ BTRFS_TREE_LOG_OBJECTID,		"TREE_LOG"		},
> +	{ BTRFS_QUOTA_TREE_OBJECTID,		"QUOTA_TREE"		},
> +	{ BTRFS_UUID_TREE_OBJECTID,		"UUID_TREE"		},
> +	{ BTRFS_FREE_SPACE_TREE_OBJECTID,	"FREE_SPACE_TREE"	},
> +	{ BTRFS_DATA_RELOC_TREE_OBJECTID,	"DATA_RELOC_TREE"	},

I've noticed we have the id -> str mapping already in
btrfs_lockdep_keysets, so there could be just one such structure and
we'd add wrappers around that.

Also the C99 initializers should be used.

> +};
> +
> +char *btrfs_root_name(u64 objectid, char *buf)
> +{
> +	int i;
> +
> +	if (objectid == BTRFS_TREE_RELOC_OBJECTID) {
> +		snprintf(buf, BTRFS_ROOT_NAME_BUF_LEN,
> +			 "TREE_RELOC offset=%llu", objectid);

The reloc tree is an outlier here so I wonder if we'd rather have a nice
pretty printer of the tree root name and deal with the oddities where
required rather than inside the helper. In this case there would have to
be some conditionals in btrfs_check_leaked_roots, as we can't do that in
the format string.

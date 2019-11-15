Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA72FE209
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2019 16:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfKOPwH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Nov 2019 10:52:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:45250 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727423AbfKOPwH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Nov 2019 10:52:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5FE08BECF;
        Fri, 15 Nov 2019 15:52:04 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 51391DA7D3; Fri, 15 Nov 2019 16:52:07 +0100 (CET)
Date:   Fri, 15 Nov 2019 16:52:07 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: dump-tree: Introduce --nofilename option
Message-ID: <20191115155207.GW3001@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191111072435.28677-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111072435.28677-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 11, 2019 at 03:24:35PM +0800, Qu Wenruo wrote:
> In the mail list, it's pretty common that a developer is asking dump tree
> output from the reporter, it's better to protect those kind reporters by
> hiding the filename if the reporter wants.

That's useful. Can we name it '--hide-filenames' ? You describe it in
the text and I think this expresses what it does and hopefully will be
clear to random users what the options does.

> This option will skip @name/@data output for the following items:
> - DIR_INDEX
> - DIR_ITEM
> - INODE_REF
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  Documentation/btrfs-inspect-internal.asciidoc |  3 ++
>  cmds/inspect-dump-tree.c                      |  7 +++-
>  ctree.h                                       |  1 +
>  disk-io.c                                     |  2 +
>  disk-io.h                                     |  3 ++
>  print-tree.c                                  | 40 ++++++++++++-------
>  6 files changed, 41 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/btrfs-inspect-internal.asciidoc b/Documentation/btrfs-inspect-internal.asciidoc
> index 2abf044a3e99..878ab0a31887 100644
> --- a/Documentation/btrfs-inspect-internal.asciidoc
> +++ b/Documentation/btrfs-inspect-internal.asciidoc
> @@ -99,6 +99,9 @@ intermixed in the output
>  +
>  use breadth-first search to print trees, the nodes are printed before all
>  leaves
> +--nofilename::::
> +do not print any filename of the filesystem. Useful for developer to inspect
> +the filesystem while keep confidential info hiden.
>  --noscan::::
>  do not automatically scan the system for other devices from the same
>  filesystem, only use the devices provided as the arguments
> diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
> index e5efe2470111..2a7f94f4f09b 100644
> --- a/cmds/inspect-dump-tree.c
> +++ b/cmds/inspect-dump-tree.c
> @@ -330,7 +330,7 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
>  	while (1) {
>  		int c;
>  		enum { GETOPT_VAL_FOLLOW = 256, GETOPT_VAL_DFS, GETOPT_VAL_BFS,
> -		       GETOPT_VAL_NOSCAN};
> +		       GETOPT_VAL_NOSCAN, GETOPT_VAL_NOFILENAME };
>  		static const struct option long_options[] = {
>  			{ "extents", no_argument, NULL, 'e'},
>  			{ "device", no_argument, NULL, 'd'},
> @@ -343,6 +343,8 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
>  			{ "bfs", no_argument, NULL, GETOPT_VAL_BFS },
>  			{ "dfs", no_argument, NULL, GETOPT_VAL_DFS },
>  			{ "noscan", no_argument, NULL, GETOPT_VAL_NOSCAN },
> +			{ "nofilename", no_argument, NULL,
> +				GETOPT_VAL_NOFILENAME },
>  			{ NULL, 0, NULL, 0 }
>  		};
>  
> @@ -410,6 +412,9 @@ static int cmd_inspect_dump_tree(const struct cmd_struct *cmd,
>  		case GETOPT_VAL_NOSCAN:
>  			open_ctree_flags |= OPEN_CTREE_NO_DEVICES;
>  			break;
> +		case GETOPT_VAL_NOFILENAME:
> +			open_ctree_flags |= OPEN_CTREE_DONT_PRINT_FILENAME;
> +			break;
>  		default:
>  			usage_unknown_option(cmd, argv);
>  		}
> diff --git a/ctree.h b/ctree.h
> index b2745e1e8f13..00e7747d1266 100644
> --- a/ctree.h
> +++ b/ctree.h
> @@ -1173,6 +1173,7 @@ struct btrfs_fs_info {
>  	unsigned int avoid_meta_chunk_alloc:1;
>  	unsigned int avoid_sys_chunk_alloc:1;
>  	unsigned int finalize_on_close:1;
> +	unsigned int dont_print_filename:1;
>  
>  	int transaction_aborted;
>  
> diff --git a/disk-io.c b/disk-io.c
> index c3e85c0ee06e..42f0026a6d2f 100644
> --- a/disk-io.c
> +++ b/disk-io.c
> @@ -1190,6 +1190,8 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, const char *path,
>  		fs_info->ignore_fsid_mismatch = 1;
>  	if (flags & OPEN_CTREE_IGNORE_CHUNK_TREE_ERROR)
>  		fs_info->ignore_chunk_tree_error = 1;
> +	if (flags & OPEN_CTREE_DONT_PRINT_FILENAME)
> +		fs_info->dont_print_filename = 1;
>  
>  	if ((flags & OPEN_CTREE_RECOVER_SUPER)
>  	     && (flags & OPEN_CTREE_TEMPORARY_SUPER)) {
> diff --git a/disk-io.h b/disk-io.h
> index 545cacda9a79..fc25627c6b80 100644
> --- a/disk-io.h
> +++ b/disk-io.h
> @@ -85,6 +85,9 @@ enum btrfs_open_ctree_flags {
>  	 * compat_ro bit).
>  	 */
>  	OPEN_CTREE_INVALIDATE_FST = (1U << 13),
> +
> +	/* For print-tree only, skip filename output */
> +	OPEN_CTREE_DONT_PRINT_FILENAME = (1U << 14),

I don't think you need to make it a global open_ctree flag, just set
fs_info->dont_print_filenames in cmds/inspect-dump-tree.c, that's the
only place where we care about it.

>  };
>  
>  /*
> diff --git a/print-tree.c b/print-tree.c
> index f70ce6844a7e..e035cec9e110 100644
> --- a/print-tree.c
> +++ b/print-tree.c
> @@ -67,16 +67,20 @@ static void print_dir_item(struct extent_buffer *eb, u32 size,
>  		name_len = btrfs_dir_name_len(eb, di);
>  		data_len = btrfs_dir_data_len(eb, di);
>  		len = (name_len <= sizeof(namebuf))? name_len: sizeof(namebuf);
> -		read_extent_buffer(eb, namebuf, (unsigned long)(di + 1), len);
>  		printf("\t\ttransid %llu data_len %u name_len %u\n",
>  				btrfs_dir_transid(eb, di),
>  				data_len, name_len);
> -		printf("\t\tname: %.*s\n", len, namebuf);
> -		if (data_len) {
> -			len = (data_len <= sizeof(namebuf))? data_len: sizeof(namebuf);
> +		if (!(eb->fs_info && eb->fs_info->dont_print_filename)) {
>  			read_extent_buffer(eb, namebuf,
> -				(unsigned long)(di + 1) + name_len, len);
> -			printf("\t\tdata %.*s\n", len, namebuf);
> +					(unsigned long)(di + 1), len);
> +			printf("\t\tname: %.*s\n", len, namebuf);
> +			if (data_len) {
> +				len = (data_len <= sizeof(namebuf))? data_len:
> +					sizeof(namebuf);
> +				read_extent_buffer(eb, namebuf,
> +					(unsigned long)(di + 1) + name_len, len);
> +				printf("\t\tdata %.*s\n", len, namebuf);
> +			}

Idea to consider: print a placeholder, like "name: HIDDEN", to keep the
format of dump the same. It can also simplify the code.

>  		}
>  		len = sizeof(*di) + name_len + data_len;
>  		di = (struct btrfs_dir_item *)((char *)di + len);
> @@ -101,12 +105,16 @@ static void print_inode_extref_item(struct extent_buffer *eb, u32 size,
>  
>  		len = (name_len <= sizeof(namebuf))? name_len: sizeof(namebuf);
>  
> -		read_extent_buffer(eb, namebuf, (unsigned long)(extref->name), len);
> -
> -		printf("\t\tindex %llu parent %llu namelen %u name: %.*s\n",
> -		       (unsigned long long)index,
> -		       (unsigned long long)parent_objid,
> -		       name_len, len, namebuf);
> +		if (eb->fs_info && eb->fs_info->dont_print_filename) {
> +			printf("\t\tindex %llu [arent %llu namelen %u\n",
> +				index, parent_objid, name_len);
> +		} else {
> +			read_extent_buffer(eb, namebuf,
> +					(unsigned long)extref->name, len);
> +			printf(
> +			"\t\tindex %llu parent %llu namelen %u name: %.*s\n",
> +				index, parent_objid, name_len, len, namebuf);
> +		}
>  
>  		len = sizeof(*extref) + name_len;
>  		extref = (struct btrfs_inode_extref *)((char *)extref + len);
> @@ -127,9 +135,13 @@ static void print_inode_ref_item(struct extent_buffer *eb, u32 size,
>  		name_len = btrfs_inode_ref_name_len(eb, ref);
>  		index = btrfs_inode_ref_index(eb, ref);
>  		len = (name_len <= sizeof(namebuf))? name_len: sizeof(namebuf);
> -		read_extent_buffer(eb, namebuf, (unsigned long)(ref + 1), len);
> -		printf("\t\tindex %llu namelen %u name: %.*s\n",
> +		if (eb->fs_info && eb->fs_info->dont_print_filename) {
> +			printf("\t\tindex %llu namelen %u\n", index, name_len);
> +		} else {
> +			read_extent_buffer(eb, namebuf, (unsigned long)(ref + 1), len);
> +			printf("\t\tindex %llu namelen %u name: %.*s\n",
>  		       (unsigned long long)index, name_len, len, namebuf);
> +		}
>  		len = sizeof(*ref) + name_len;
>  		ref = (struct btrfs_inode_ref *)((char *)ref + len);
>  		cur += len;
> -- 
> 2.24.0

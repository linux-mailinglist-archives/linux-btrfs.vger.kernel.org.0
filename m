Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C803AA2086
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2019 18:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfH2QPu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Aug 2019 12:15:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:48132 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727161AbfH2QPu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Aug 2019 12:15:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 603B7AE2D;
        Thu, 29 Aug 2019 16:15:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 986E3DA809; Thu, 29 Aug 2019 18:16:10 +0200 (CEST)
Date:   Thu, 29 Aug 2019 18:16:10 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs-progs: add a --check-bg-usage option to fsck
Message-ID: <20190829161610.GL2752@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190802130635.3698-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802130635.3698-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 02, 2019 at 09:06:35AM -0400, Josef Bacik wrote:
> Sometimes when messing with the chunk allocator code we can end up
> over-allocating chunks.  Generally speaking I'll notice this when a
> random xfstest fails with ENOSPC when it shouldn't, but I'm super
> worried that I won't catch a problem until somebody has a fs completely
> filled up with empty block groups.  Add a fsck option to check for too
> many empty block groups.  This way I can set FSCK_OPTIONS="-B" to catch
> cases where we're too aggressive with the chunk allocator but not so
> aggressive that it causes problems in xfstests.
> 
> Thankfully this doesn't trip up currently, so this will just keep me
> from regressing us.  Thanks,
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  btrfsck.h    |  1 +
>  check/main.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/btrfsck.h b/btrfsck.h
> index ac7f5d48..5e779075 100644
> --- a/btrfsck.h
> +++ b/btrfsck.h
> @@ -44,6 +44,7 @@ struct block_group_record {
>  	u64 offset;
>  
>  	u64 flags;
> +	u64 used;
>  };
>  
>  struct block_group_tree {
> diff --git a/check/main.c b/check/main.c
> index 0cc6fdba..a3ff3791 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -62,6 +62,7 @@ int no_holes = 0;
>  static int is_free_space_tree = 0;
>  int init_extent_tree = 0;
>  int check_data_csum = 0;
> +int check_bg_usage = 0;
>  struct btrfs_fs_info *global_info;
>  struct task_ctx ctx = { 0 };
>  struct cache_tree *roots_info_cache = NULL;
> @@ -5126,6 +5127,7 @@ btrfs_new_block_group_record(struct extent_buffer *leaf, struct btrfs_key *key,
>  
>  	ptr = btrfs_item_ptr(leaf, slot, struct btrfs_block_group_item);
>  	rec->flags = btrfs_disk_block_group_flags(leaf, ptr);
> +	rec->used = btrfs_disk_block_group_used(leaf, ptr);
>  
>  	INIT_LIST_HEAD(&rec->list);
>  
> @@ -8522,6 +8524,41 @@ out:
>  	return ret;
>  }
>  
> +static int check_block_group_usage(struct block_group_tree *block_group_cache)
> +{
> +	struct block_group_record *bg_rec;
> +	int empty_data = 0, empty_metadata = 0, empty_system = 0;
> +	int ret = 0;
> +
> +	list_for_each_entry(bg_rec, &block_group_cache->block_groups, list) {
> +		if (bg_rec->used)
> +			continue;
> +		if (bg_rec->flags & BTRFS_BLOCK_GROUP_DATA)
> +			empty_data++;
> +		else if (bg_rec->flags & BTRFS_BLOCK_GROUP_METADATA)
> +			empty_metadata++;
> +		else
> +			empty_system++;
> +	}
> +
> +	if (empty_data > 1) {
> +		ret = -EINVAL;
> +		fprintf(stderr, "Too many empty data block groups: %d\n",
> +			empty_data);
> +	}
> +	if (empty_metadata > 1) {
> +		ret = -EINVAL;
> +		fprintf(stderr, "Too many empty metadata block groups: %d\n",
> +			empty_metadata);
> +	}
> +	if (empty_system > 1) {
> +		ret = -EINVAL;
> +		fprintf(stderr, "Too many empty system block groups: %d\n",
> +			empty_system);
> +	}
> +	return ret;
> +}
> +
>  static int check_chunks_and_extents(struct btrfs_fs_info *fs_info)
>  {
>  	struct rb_root dev_cache;
> @@ -8630,6 +8667,12 @@ again:
>  		err = ret;
>  	}
>  
> +	if (check_bg_usage) {
> +		ret = check_block_group_usage(&block_group_cache);
> +		if (ret)
> +			err = ret;
> +	}
> +
>  	ret = check_extent_refs(root, &extent_cache);
>  	if (ret < 0) {
>  		if (ret == -EAGAIN)
> @@ -9810,6 +9853,7 @@ static const char * const cmd_check_usage[] = {
>  	"       -E|--subvol-extents <subvolid>",
>  	"                                   print subvolume extents and sharing state",
>  	"       -p|--progress               indicate progress",
> +	"       -B|--check-bg-usage         check for too many empty block groups",

The option name does not match the description, it could be something
like --check-empty-bg-count and certainly should not use the short
option. That are reserved for most common usecases, I don't think
this is the case.

>  	NULL
>  };
>  
> @@ -9841,7 +9885,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  			GETOPT_VAL_INIT_EXTENT, GETOPT_VAL_CHECK_CSUM,
>  			GETOPT_VAL_READONLY, GETOPT_VAL_CHUNK_TREE,
>  			GETOPT_VAL_MODE, GETOPT_VAL_CLEAR_SPACE_CACHE,
> -			GETOPT_VAL_FORCE };
> +			GETOPT_VAL_FORCE};
>  		static const struct option long_options[] = {
>  			{ "super", required_argument, NULL, 's' },
>  			{ "repair", no_argument, NULL, GETOPT_VAL_REPAIR },
> @@ -9864,10 +9908,11 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  			{ "clear-space-cache", required_argument, NULL,
>  				GETOPT_VAL_CLEAR_SPACE_CACHE},
>  			{ "force", no_argument, NULL, GETOPT_VAL_FORCE },
> +			{ "check-bg-usage", no_argument, NULL, 'B' },
>  			{ NULL, 0, NULL, 0}
>  		};
>  
> -		c = getopt_long(argc, argv, "as:br:pEQ", long_options, NULL);
> +		c = getopt_long(argc, argv, "as:br:pEQB", long_options, NULL);
>  		if (c < 0)
>  			break;
>  		switch(c) {
> @@ -9875,6 +9920,9 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  			case 'b':
>  				ctree_flags |= OPEN_CTREE_BACKUP_ROOT;
>  				break;
> +			case 'B':
> +				check_bg_usage = 1;
> +				break;
>  			case 's':
>  				num = arg_strtou64(optarg);
>  				if (num >= BTRFS_SUPER_MIRROR_MAX) {
> -- 
> 2.21.0

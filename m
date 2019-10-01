Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6BFC3FDC
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 20:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfJASaF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 14:30:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:42556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbfJASaF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 1 Oct 2019 14:30:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 337BAAE6D;
        Tue,  1 Oct 2019 18:30:03 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1815DA88C; Tue,  1 Oct 2019 20:30:20 +0200 (CEST)
Date:   Tue, 1 Oct 2019 20:30:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH][v2] btrfs-progs: add a --check-bg-usage option to fsck
Message-ID: <20191001183020.GI2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20190802160953.18312-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802160953.18312-1-josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 02, 2019 at 12:09:53PM -0400, Josef Bacik wrote:
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
> v1->v2:
> - tested with my alloc chunk ioctl, realized the chunk checker removes the bg
>   recs from the list, so this wasn't actually doing anything.  Moved the check
>   so now it properly fails on a bad fs.

I sent some comments to v1 that seem to apply to v2 as well.

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

Can you please add images that trigger each of the above problems?

> +	}
> +	return ret;
> +}
> +
>  static int check_chunks_and_extents(struct btrfs_fs_info *fs_info)
>  {
>  	struct rb_root dev_cache;
> @@ -8622,6 +8659,13 @@ again:
>  		goto out;
>  	}
>  
> +	if (check_bg_usage) {
> +		ret = check_block_group_usage(&block_group_cache);
> +		if (ret)
> +			err = ret;
> +		goto out;
> +	}
> +
>  	ret = check_chunks(&chunk_cache, &block_group_cache,
>  			   &dev_extent_cache, NULL, NULL, NULL, 0);
>  	if (ret) {
> @@ -9810,6 +9854,7 @@ static const char * const cmd_check_usage[] = {
>  	"       -E|--subvol-extents <subvolid>",
>  	"                                   print subvolume extents and sharing state",
>  	"       -p|--progress               indicate progress",
> +	"       -B|--check-bg-usage         check for too many empty block groups",
>  	NULL
>  };
>  
> @@ -9841,7 +9886,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  			GETOPT_VAL_INIT_EXTENT, GETOPT_VAL_CHECK_CSUM,
>  			GETOPT_VAL_READONLY, GETOPT_VAL_CHUNK_TREE,
>  			GETOPT_VAL_MODE, GETOPT_VAL_CLEAR_SPACE_CACHE,
> -			GETOPT_VAL_FORCE };
> +			GETOPT_VAL_FORCE};
>  		static const struct option long_options[] = {
>  			{ "super", required_argument, NULL, 's' },
>  			{ "repair", no_argument, NULL, GETOPT_VAL_REPAIR },
> @@ -9864,10 +9909,11 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>  			{ "clear-space-cache", required_argument, NULL,
>  				GETOPT_VAL_CLEAR_SPACE_CACHE},
>  			{ "force", no_argument, NULL, GETOPT_VAL_FORCE },
> +			{ "check-bg-usage", no_argument, NULL, 'B' },

The option name does not match the description, it could be something
like --check-empty-bg-count and certainly should not use the short
option. That are reserved for most common usecases, I don't think
this is the case.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6F91AE091
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgDQPI6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 11:08:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:52904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728308AbgDQPI6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 11:08:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DEC8BAD09;
        Fri, 17 Apr 2020 15:08:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 531D1DA727; Fri, 17 Apr 2020 17:08:15 +0200 (CEST)
Date:   Fri, 17 Apr 2020 17:08:15 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Marek Behun <marek.behun@nic.cz>
Subject: Re: [PATCH] btrfs: Remove the duplicated @level parameter for
 btrfs_bin_search()
Message-ID: <20200417150815.GP5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Marek Behun <marek.behun@nic.cz>
References: <20200417070821.65806-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417070821.65806-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 17, 2020 at 03:08:21PM +0800, Qu Wenruo wrote:
> We can easily get the level from @eb parameter, thus the level is not
> needed.
> 
> This is inspired by the work of Marek in U-boot.
> 
> Cc: Marek Behun <marek.behun@nic.cz>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks. Please don't use the @ formatting in the
subject, this is for the docs.

> ---
>  fs/btrfs/ctree.c      | 14 +++++++-------
>  fs/btrfs/ctree.h      |  2 +-
>  fs/btrfs/relocation.c |  8 +++-----
>  fs/btrfs/tree-log.c   |  3 +--
>  4 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index bfedbbe2311f..6c28efe5b14a 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -1733,9 +1733,9 @@ static noinline int generic_bin_search(struct extent_buffer *eb,
>   * leaves vs nodes
>   */
>  int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
> -		     int level, int *slot)
> +		     int *slot)
>  {
> -	if (level == 0)
> +	if (btrfs_header_level(eb) == 0)
>  		return generic_bin_search(eb,
>  					  offsetof(struct btrfs_leaf, items),
>  					  sizeof(struct btrfs_item),
> @@ -2502,10 +2502,10 @@ setup_nodes_for_search(struct btrfs_trans_handle *trans,
>  }
>  
>  static int key_search(struct extent_buffer *b, const struct btrfs_key *key,
> -		      int level, int *prev_cmp, int *slot)
> +		      int *prev_cmp, int *slot)
>  {
>  	if (*prev_cmp != 0) {
> -		*prev_cmp = btrfs_bin_search(b, key, level, slot);
> +		*prev_cmp = btrfs_bin_search(b, key, slot);
>  		return *prev_cmp;
>  	}
>  
> @@ -2783,7 +2783,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>  			}
>  		}
>  
> -		ret = key_search(b, key, level, &prev_cmp, &slot);
> +		ret = key_search(b, key, &prev_cmp, &slot);
>  		if (ret < 0)
>  			goto done;
>  
> @@ -2947,7 +2947,7 @@ int btrfs_search_old_slot(struct btrfs_root *root, const struct btrfs_key *key,
>  		 * time.
>  		 */
>  		prev_cmp = -1;
> -		ret = key_search(b, key, level, &prev_cmp, &slot);
> +		ret = key_search(b, key, &prev_cmp, &slot);
>  		if (ret < 0)
>  			goto done;
>  
> @@ -5103,7 +5103,7 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
>  	while (1) {
>  		nritems = btrfs_header_nritems(cur);
>  		level = btrfs_header_level(cur);
> -		sret = btrfs_bin_search(cur, min_key, level, &slot);
> +		sret = btrfs_bin_search(cur, min_key, &slot);
>  		if (sret < 0) {
>  			ret = sret;
>  			goto out;
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 4d787d749315..dfbcf794d895 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2305,7 +2305,7 @@ void btrfs_wait_for_snapshot_creation(struct btrfs_root *root);
>  
>  /* ctree.c */
>  int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
> -		     int level, int *slot);
> +		     int *slot);
>  int __pure btrfs_comp_cpu_keys(const struct btrfs_key *k1, const struct btrfs_key *k2);
>  int btrfs_previous_item(struct btrfs_root *root,
>  			struct btrfs_path *path, u64 min_objectid,
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index f65595602aa8..6f2dd203a1c6 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -1925,7 +1925,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
>  		level = btrfs_header_level(parent);
>  		BUG_ON(level < lowest_level);
>  
> -		ret = btrfs_bin_search(parent, &key, level, &slot);
> +		ret = btrfs_bin_search(parent, &key, &slot);
>  		if (ret < 0)
>  			break;
>  		if (ret && slot > 0)
> @@ -2914,8 +2914,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
>  
>  		if (upper->eb && !upper->locked) {
>  			if (!lowest) {
> -				ret = btrfs_bin_search(upper->eb, key,
> -						       upper->level, &slot);
> +				ret = btrfs_bin_search(upper->eb, key, &slot);
>  				if (ret < 0) {
>  					err = ret;
>  					goto next;
> @@ -2953,8 +2952,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
>  			slot = path->slots[upper->level];
>  			btrfs_release_path(path);
>  		} else {
> -			ret = btrfs_bin_search(upper->eb, key, upper->level,
> -					       &slot);
> +			ret = btrfs_bin_search(upper->eb, key, &slot);
>  			if (ret < 0) {
>  				err = ret;
>  				goto next;
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 58c111474ba5..981a3df9c7ff 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3816,8 +3816,7 @@ static int drop_objectid_items(struct btrfs_trans_handle *trans,
>  
>  		found_key.offset = 0;
>  		found_key.type = 0;
> -		ret = btrfs_bin_search(path->nodes[0], &found_key, 0,
> -				       &start_slot);
> +		ret = btrfs_bin_search(path->nodes[0], &found_key, &start_slot);
>  		if (ret < 0)
>  			break;
>  
> -- 
> 2.26.0

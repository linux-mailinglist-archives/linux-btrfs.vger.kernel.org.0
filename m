Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5EB38C6AF
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 14:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbhEUMmW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 08:42:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:49588 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231627AbhEUMmU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 08:42:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8A56DAAFD;
        Fri, 21 May 2021 12:40:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2C64FDA734; Fri, 21 May 2021 14:38:21 +0200 (CEST)
Date:   Fri, 21 May 2021 14:38:21 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fixup error handling in fixup_inode_link_counts
Message-ID: <20210521123820.GI7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <3490883fc4ea908bcefbf2507ba4c7235c2464e4.1621444381.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3490883fc4ea908bcefbf2507ba4c7235c2464e4.1621444381.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 19, 2021 at 01:13:15PM -0400, Josef Bacik wrote:
> This function has the following pattern
> 
> 	while (1) {
> 		ret = whatever();
> 		if (ret)
> 			goto out;
> 	}
> 	ret = 0
> out:
> 	return ret;
> 
> However several places in this while loop we simply break; when there's
> a problem, thus clearing the return value, and in one case we do a
> return -EIO, and leak the memory for the path.
> 
> Fix this by re-arranging the loop to deal with ret == 1 coming from
> btrfs_search_slot, and then simply delete the
> 
> 	ret = 0;
> out:
> 
> bit so everybody can break if there is an error, which will allow for
> proper error handling to occur.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/tree-log.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 18009095908b..f8f708c02462 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -1778,7 +1778,7 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
>  					    struct btrfs_root *root,
>  					    struct btrfs_path *path)
>  {
> -	int ret;
> +	int ret = 0;
>  	struct btrfs_key key;
>  	struct inode *inode;
>  
> @@ -1791,6 +1791,7 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
>  			break;
>  
>  		if (ret == 1) {
> +			ret = 0;
>  			if (path->slots[0] == 0)
>  				break;
>  			path->slots[0]--;
> @@ -1803,17 +1804,19 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
>  
>  		ret = btrfs_del_item(trans, root, path);
>  		if (ret)
> -			goto out;
> +			break;
>  
>  		btrfs_release_path(path);
>  		inode = read_one_inode(root, key.offset);
> -		if (!inode)
> -			return -EIO;
> +		if (!inode) {
> +			ret = -EIO;

Not related to your patch, but forcing EIO does not seem to be
right. read_one_inode is a simple wrapper around read_one_inode that
returns ERR_PTR so we should perhaps return that

> +			break;
> +		}
>  
>  		ret = fixup_inode_link_count(trans, root, inode);
>  		iput(inode);
>  		if (ret)
> -			goto out;
> +			break;
>  
>  		/*
>  		 * fixup on a directory may create new entries,
> @@ -1822,8 +1825,6 @@ static noinline int fixup_inode_link_counts(struct btrfs_trans_handle *trans,
>  		 */
>  		key.offset = (u64)-1;
>  	}
> -	ret = 0;
> -out:
>  	btrfs_release_path(path);
>  	return ret;
>  }
> -- 
> 2.26.3

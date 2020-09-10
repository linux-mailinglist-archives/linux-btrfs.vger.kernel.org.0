Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B985C2647D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 16:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbgIJOQM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 10:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731124AbgIJOK6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 10:10:58 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934F8C061344
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:07:36 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id h1so3372337qvo.9
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=urey7VA8zHjsv2fZvyxI50aWGy5fBhdXhnHZjw5DeDo=;
        b=RxJB0pzMWst2Ik07nIP2OjmDil4BaCgu9g9UzX3J2c12+vlWt9pvjecm05ysHyko8T
         a6GNfy023Z5rC+oduIcH29siT9Fc+rtvZGHiy5/JU3J1kczfJGpbZDopZVlYvDkxwJ//
         vaMzGY2L2Y5jdw1ngq9UoXSbespFBWcWNy/jqEfz7cpqov7HG1rS8tpDk5QkkS+tAgFc
         wbCUO2x/3J+o5tOAfcllDrcv6T3b3SIIfRYf1x5rszcQolc3mYbzLXs5Cko0d1aQ0Vff
         xHnsKfLr2Fi6hZ+C4xx6H84WvMZyGdqSoOyKxJu/zj8cnrEGo5UIPICi7URGizwPJIec
         cY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=urey7VA8zHjsv2fZvyxI50aWGy5fBhdXhnHZjw5DeDo=;
        b=hQkfpTCTMuXHtKXp5hNcp0GtIunz48xzcOPwf0sxPhhU8IEBWlXir0UUFfK+nfbDYW
         5pwitobDYtjhkhgQ+LABQ9oDfm8NN+0Il0JE4EhsUIYbmlm/PJo0zDwmephE3gP+2EJH
         do0bARcPBQiX5ajhiJURADP61ZsUc0I+/FDbehzWsb7SCP8ZV+9io3f8P340B1Cb9Ahm
         xgnpDJKSvmBGwo8whPGWg47QwqyijRFFGpUGcqJumcNguTkODgCNP6VNmvwmLIZwcV1z
         Yic1GASov9yziKUPnp/O/J1CwOwpeAb9/QPUTs+Fa25qC8hX+orhpP5e7Ujpvy6ZhkuO
         /NgQ==
X-Gm-Message-State: AOAM531R4UMIjN1DN2EoU2O0HldpR6sZlWBpi+b5qqkOAohm5bxo7Tt2
        xnuaI5qs/32LS7giknQeTgpZfQ==
X-Google-Smtp-Source: ABdhPJwiVw716ry61YMn0FduvQjzcWJeZGSTB+YZcSIHpdzZ5nRszfVU0FMCudbZ40k3GGnc/fJ2mw==
X-Received: by 2002:a0c:fa07:: with SMTP id q7mr8901711qvn.41.1599746854246;
        Thu, 10 Sep 2020 07:07:34 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u15sm7306664qtj.3.2020.09.10.07.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:07:33 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] btrfs: remove free space items when creating free
 space tree
To:     Boris Burkov <boris@bur.io>, Dave Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1599686801.git.boris@bur.io>
 <ca7009f0e52c804f85e96f75b54a408a2de8b260.1599686801.git.boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <acff3e36-059d-a167-91d4-11ae9933a96d@toxicpanda.com>
Date:   Thu, 10 Sep 2020 10:07:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <ca7009f0e52c804f85e96f75b54a408a2de8b260.1599686801.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/9/20 5:45 PM, Boris Burkov wrote:
> When the file system transitions from space cache v1 to v2 it removes
> the old cached data, but does not remove the FREE_SPACE items nor the
> free space inodes they point to. This doesn't cause any issues besides
> being a bit inefficient, since these items no longer do anything useful.
> 
> To fix it, as part of populating the free space tree, destroy each block
> group's free space item and free space inode. This code is lifted from
> the existing code for removing them when removing the block group.
> 
> References: https://github.com/btrfs/btrfs-todo/issues/5
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> v2:
> - remove_free_space_inode -> btrfs_remove_free_space_inode
> - undo sinful whitespace change
> 
>   fs/btrfs/block-group.c      | 39 ++----------------------------
>   fs/btrfs/free-space-cache.c | 48 +++++++++++++++++++++++++++++++++++++
>   fs/btrfs/free-space-cache.h |  2 ++
>   fs/btrfs/free-space-tree.c  |  3 +++
>   4 files changed, 55 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 01e8ba1da1d3..e5e5baad88d8 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -892,8 +892,6 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>   	struct btrfs_path *path;
>   	struct btrfs_block_group *block_group;
>   	struct btrfs_free_cluster *cluster;
> -	struct btrfs_root *tree_root = fs_info->tree_root;
> -	struct btrfs_key key;
>   	struct inode *inode;
>   	struct kobject *kobj = NULL;
>   	int ret;
> @@ -971,42 +969,9 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>   	spin_unlock(&trans->transaction->dirty_bgs_lock);
>   	mutex_unlock(&trans->transaction->cache_write_mutex);
>   
> -	if (!IS_ERR(inode)) {
> -		ret = btrfs_orphan_add(trans, BTRFS_I(inode));
> -		if (ret) {
> -			btrfs_add_delayed_iput(inode);
> -			goto out;
> -		}
> -		clear_nlink(inode);
> -		/* One for the block groups ref */
> -		spin_lock(&block_group->lock);
> -		if (block_group->iref) {
> -			block_group->iref = 0;
> -			block_group->inode = NULL;
> -			spin_unlock(&block_group->lock);
> -			iput(inode);
> -		} else {
> -			spin_unlock(&block_group->lock);
> -		}
> -		/* One for our lookup ref */
> -		btrfs_add_delayed_iput(inode);
> -	}
> -
> -	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
> -	key.type = 0;
> -	key.offset = block_group->start;
> -
> -	ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
> -	if (ret < 0)
> +	ret = btrfs_remove_free_space_inode(trans, block_group);
> +	if (ret)
>   		goto out;
> -	if (ret > 0)
> -		btrfs_release_path(path);
> -	if (ret == 0) {
> -		ret = btrfs_del_item(trans, tree_root, path);
> -		if (ret)
> -			goto out;
> -		btrfs_release_path(path);
> -	}
>   
>   	spin_lock(&fs_info->block_group_cache_lock);
>   	rb_erase(&block_group->cache_node,
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 8759f5a1d6a0..da6d436c58fa 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -207,6 +207,54 @@ int create_free_space_inode(struct btrfs_trans_handle *trans,
>   					 ino, block_group->start);
>   }
>   
> +int btrfs_remove_free_space_inode(struct btrfs_trans_handle *trans,
> +				  struct btrfs_block_group *block_group)
> +{
> +	struct btrfs_path *path;
> +	struct inode *inode;
> +	struct btrfs_key key;
> +	int ret = 0;
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	inode = lookup_free_space_inode(block_group, path);
> +	if (IS_ERR(inode)) {
> +		if (PTR_ERR(inode) != -ENOENT)
> +			ret = PTR_ERR(inode);
> +		goto out;
> +	}
> +	ret = btrfs_orphan_add(trans, BTRFS_I(inode));
> +	if (ret) {
> +		btrfs_add_delayed_iput(inode);
> +		goto out;
> +	}
> +	clear_nlink(inode);
> +	/* One for the block groups ref */
> +	spin_lock(&block_group->lock);
> +	if (block_group->iref) {
> +		block_group->iref = 0;
> +		block_group->inode = NULL;
> +		spin_unlock(&block_group->lock);
> +		iput(inode);
> +	} else {
> +		spin_unlock(&block_group->lock);
> +	}
> +	/* One for our lookup ref */
> +	btrfs_add_delayed_iput(inode);
> +
> +	key.objectid = BTRFS_FREE_SPACE_OBJECTID;
> +	key.type = 0;
> +	key.offset = block_group->start;
> +	ret = btrfs_search_slot(trans, trans->fs_info->tree_root, &key, path, -1, 1);
> +	if (ret != 0)
> +		goto out;

This leaks the ret == 1 if we don't have a free space cache objectid.  This 
needs to be

if (ret) {
	if (ret > 0)
		ret = 0;
	goto out;
}

or something like that.  Thanks,

Josef

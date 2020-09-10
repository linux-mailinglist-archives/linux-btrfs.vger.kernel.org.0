Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14265264801
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 16:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbgIJO3w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 10:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731019AbgIJO2b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 10:28:31 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F7BC0617A0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:18:18 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k25so4954897qtu.4
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 07:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S8qCGAUew6KDYaUUtYMU93ZyX8GMVrbuURtayarq2rY=;
        b=1WFf4oo1UZYaIWaBnxRDPXeqogWxYMoTgaihiIqZqSuSaANVdaZSSicHkhYcilXr0q
         yxfoL81vrt8LSJHagKag7u9Yfo3Zor9JqVVdA2kT1teiAcps5r7Ll+SwV47J9f4a7hvz
         XWvVro103SfNHervqybHxvXiGZAxht1Bh3M6TUmoT9nknHC2iLDZelsNJiJ7TfeEIKzB
         KF1fN6PreE3fkoz7QPhjV9arjpvto7QqAr3LYHHTi194NJYKGuZHF4MeGwJbzT5ecZtv
         Sv2+KH7IFmmTA+P79O+ShPnpqd4T8OZdrT5jgSfsOvHTE4PuYw0c/3HdQSYIV4btxRrj
         m4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S8qCGAUew6KDYaUUtYMU93ZyX8GMVrbuURtayarq2rY=;
        b=sQ+VLTS7Qc/W+DEI+eeGGdmPO1rxQ3UBgY+9C9ODKAlsc82XesWv0qyQaaQaF2Ydl1
         65bayn6ToHh8XIN/mR0wyoit9/tOmp5j3Eutae08YI7z/MpXYkTP5R9iDTs0gm9kosql
         DUbP83xRaAI85caebFGKkVX4+HTUNdeUt6KcsvPSl8y+prhyV5VoekGE+t/hC6mdzODC
         GIYf+JfYnevaHEPq7xRUE9uSg3mtInnP1SlLyIXBg/oOUhDKrnIQEMPclhxj85/s72yJ
         LMhiCPDA7x+sVJJKzcxxmpfQA3ZSCgRy5YhWJ/KqTttU8rOyb2BkCm2vdjTmbotiTP6n
         9pZQ==
X-Gm-Message-State: AOAM5306zJzBr+XsFAMaFp4uy3Emz6N3o6VPCUBAzqQpSy0BwI34yibq
        FE4/iWAyJcsuqnBTVNM2JOZafA==
X-Google-Smtp-Source: ABdhPJyDxc9IX/lkDPv3AQfeXfOmX0gZe/H5bfimvbp6cAzegCn/olD7StsdtBJt2TTThLYv5RDKyQ==
X-Received: by 2002:ac8:22da:: with SMTP id g26mr7898394qta.218.1599747497233;
        Thu, 10 Sep 2020 07:18:17 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z74sm6757015qkb.11.2020.09.10.07.18.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:18:16 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] btrfs: remove free space items when creating free
 space tree
To:     Boris Burkov <boris@bur.io>, Dave Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1599686801.git.boris@bur.io>
 <ca7009f0e52c804f85e96f75b54a408a2de8b260.1599686801.git.boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <18b6dfff-94e7-d62e-6279-53a3973623ed@toxicpanda.com>
Date:   Thu, 10 Sep 2020 10:18:15 -0400
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

Dave also noticed we're leaking the inode with these patches, that's because 
here you do the remove_free_space_inode thing instead, which is good, but we've 
already done our own lookup, and we're no longer dropping our reference here.  I 
would probalby make btrfs_remove_free_space_inode() take the inode itself so you 
don't have to do two lookups, and then add the lookup to create_free_space_tree 
in a helper that deal's with this.  Then btrfs_remove_free_space_inode() _only_ 
drops the ref for ->iref, and then the caller has to drop their own ref from 
their lookup.  Thanks,

Josef

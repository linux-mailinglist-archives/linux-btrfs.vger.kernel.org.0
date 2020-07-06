Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6709721526E
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 08:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgGFGNs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 02:13:48 -0400
Received: from mail.synology.com ([211.23.38.101]:33326 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728828AbgGFGNs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jul 2020 02:13:48 -0400
Subject: Re: [PATCH] btrfs: speedup mount time with force readahead chunk tree
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1594016025; bh=C0NEDavYnBj6fMGimUMhF+UC0dZgU1GeX3vtuGYaQa0=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=HQ5Gjlj+CLQAVRVNYoZn3LJ8QzjHdocXyMvu48qbFS/bRpCS9XPQk3xeS4fQcNvMt
         Cwg91/lsYqQf0AMmCrgpVy1gBcZzMp/QS7e4uVZRjsyF9VejduU+SHliuf6/SXDBZd
         anNdjxxB5MZ2O9xFeqeUhz/Lc8PdZbZ4Bwx0VVk8=
To:     linux-btrfs@vger.kernel.org
References: <20200701092957.20870-1-robbieko@synology.com>
From:   Robbie Ko <robbieko@synology.com>
Message-ID: <aeb651c8-0739-100b-90ad-9f36ecdc26e6@synology.com>
Date:   Mon, 6 Jul 2020 14:13:45 +0800
MIME-Version: 1.0
In-Reply-To: <20200701092957.20870-1-robbieko@synology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Does anyone have any suggestions?

robbieko 於 2020/7/1 下午5:29 寫道:
> From: Robbie Ko <robbieko@synology.com>
>
> When mounting, we always need to read the whole chunk tree,
> when there are too many chunk items, most of the time is
> spent on btrfs_read_chunk_tree, because we only read one
> leaf at a time.
>
> We fix this by adding a new readahead mode READA_FORWARD_FORCE,
> which reads all the leaves after the key in the node when
> reading a level 1 node.
>
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>   fs/btrfs/ctree.c   | 7 +++++--
>   fs/btrfs/ctree.h   | 2 +-
>   fs/btrfs/volumes.c | 1 +
>   3 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 3a7648bff42c..abb9108e2d7d 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2194,7 +2194,7 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
>   			if (nr == 0)
>   				break;
>   			nr--;
> -		} else if (path->reada == READA_FORWARD) {
> +		} else if (path->reada == READA_FORWARD || path->reada == READA_FORWARD_FORCE) {
>   			nr++;
>   			if (nr >= nritems)
>   				break;
> @@ -2205,12 +2205,15 @@ static void reada_for_search(struct btrfs_fs_info *fs_info,
>   				break;
>   		}
>   		search = btrfs_node_blockptr(node, nr);
> -		if ((search <= target && target - search <= 65536) ||
> +		if ((path->reada == READA_FORWARD_FORCE) ||
> +		    (search <= target && target - search <= 65536) ||
>   		    (search > target && search - target <= 65536)) {
>   			readahead_tree_block(fs_info, search);
>   			nread += blocksize;
>   		}
>   		nscan++;
> +		if (path->reada == READA_FORWARD_FORCE)
> +			continue;
>   		if ((nread > 65536 || nscan > 32))
>   			break;
>   	}
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index d404cce8ae40..808bcbdc9530 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -353,7 +353,7 @@ struct btrfs_node {
>    * The slots array records the index of the item or block pointer
>    * used while walking the tree.
>    */
> -enum { READA_NONE, READA_BACK, READA_FORWARD };
> +enum { READA_NONE, READA_BACK, READA_FORWARD, READA_FORWARD_FORCE };
>   struct btrfs_path {
>   	struct extent_buffer *nodes[BTRFS_MAX_LEVEL];
>   	int slots[BTRFS_MAX_LEVEL];
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 0d6e785bcb98..78fd65abff69 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7043,6 +7043,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>   	path = btrfs_alloc_path();
>   	if (!path)
>   		return -ENOMEM;
> +	path->reada = READA_FORWARD_FORCE;
>   
>   	/*
>   	 * uuid_mutex is needed only if we are mounting a sprout FS

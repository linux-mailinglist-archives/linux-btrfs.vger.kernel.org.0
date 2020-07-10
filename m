Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E7621B8A9
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 16:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGJO35 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 10:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgGJO3z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 10:29:55 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CD5C08C5CE
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 07:29:55 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l6so5371260qkc.6
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JvilHTQgwDhBAyrxZdzpWmNwLuzh5KKhhaNB8VK23CQ=;
        b=iTqc6cPhPrmBM5HkF5qMO0P/1hnE1Jad9p8S/JobheNpW1HSS2B5GMgApC0o3Ocvio
         eMPoRUbNnOajSk3CeReTqFLMyh9Bs/mVMDiJYZYBxiZDvUnyKvkkNe606LUA6xi6/rcb
         HE6v7FLc7pd8ljwmuOtWvrKlMmCh5dcefb5v3I02rFJmNszH0OCCRjwIJJnb/v8ircyL
         9qkP+n8MkE4blmwhNRVf4ub7JZ4ojxjpMFI5k26S+ECSPBuFb8/Ac73nXzrd164mOPYJ
         v+601aDrsJdZWhV7PovEnwqUeM5BtcSXGOehY7HJtagSW33EczqDT15QPLILky4lA3aM
         keUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JvilHTQgwDhBAyrxZdzpWmNwLuzh5KKhhaNB8VK23CQ=;
        b=jpDCKJkHuoO6kdwjm6ZRxDtYRTr8sSLB/PW2mB6AYH3KDIqxg+d1R1FsvvCMTlNh0Q
         1gECxl4NJnNZ8A4EPx9pw/TDGv+HrfhG4xWD7iSwNpv6MowFD3Kx4XogZKNzhuJrLge9
         cCMCSSV+XX4J2Z1/4EGVpEvbt91R9ay2C++GFlb02ILDxy5pTb+rrF4J+C9LgJEmMuXe
         yDCWy1drXv8waBcNo5AZImpFGq4OOtMvQsBbkTFzzyaQLxFno3AxTPl4y3uZhkT2Qb05
         OiariExTiTxbO4lywxhZujYXe6Pr8tCsyF65/XWjkaH4Wl/QRMowAxIa6147KA5bPi9m
         ovgA==
X-Gm-Message-State: AOAM530Pe+Wn/ct9EfsvgGkfsQnJ5dDlDTr1lBt3uDx1uKg+ea/g5slx
        ojt8v40bc0KfwsVpZAuKEyBVKA==
X-Google-Smtp-Source: ABdhPJxzpQvi4qAKrpin63NpAY6ZnNEHLJMKXBKnsm2DlH5RbcSGE4J986VXTQeN7+jiZxY9GAcsaQ==
X-Received: by 2002:a37:5c7:: with SMTP id 190mr67429427qkf.479.1594391394220;
        Fri, 10 Jul 2020 07:29:54 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c25sm7238232qka.63.2020.07.10.07.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:29:53 -0700 (PDT)
Subject: Re: [PATCH] btrfs: prefetch chunk tree leaves at mount
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Robbie Ko <robbieko@synology.com>
References: <20200710131928.7187-1-dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <52b7c8df-9c9f-a9b4-0df7-abcb6442e7e1@toxicpanda.com>
Date:   Fri, 10 Jul 2020 10:29:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200710131928.7187-1-dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/10/20 9:19 AM, David Sterba wrote:
> The whole chunk tree is read at mount time so we can utilize readahead
> to get the tree blocks to memory before we read the items. The idea is
> from Robbie, but instead of updating search slot readahead, this patch
> implements the chunk tree readahead manually from nodes on level 1.
> 
> We've decided to do specific readahead optimizations and then unify them
> under a common API so we don't break everything by changing the search
> slot readahead logic.
> 

So this is just for now, and then will be replaced with a bigger rework of the 
readahead logic?

> Higher chunk trees grow on large filesystems (many terabytes), and
> prefetching just level 1 seems to be sufficient. Provided example was
> from a 200TiB filesystem with chunk tree level 2.
> 
> CC: Robbie Ko <robbieko@synology.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/volumes.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c7a3d4d730a3..e19891243199 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7013,6 +7013,19 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
>   	return ret;
>   }
>   
> +void readahead_tree_node_children(struct extent_buffer *node)
> +{
> +	int i;
> +	const int nr_items = btrfs_header_nritems(node);
> +
> +	for (i = 0; i < nr_items; i++) {
> +		u64 start;
> +
> +		start = btrfs_node_blockptr(node, i);
> +		readahead_tree_block(node->fs_info, start);
> +	}
> +}
> +
>   int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>   {
>   	struct btrfs_root *root = fs_info->chunk_root;
> @@ -7023,6 +7036,7 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>   	int ret;
>   	int slot;
>   	u64 total_dev = 0;
> +	u64 last_ra_node = 0;
>   
>   	path = btrfs_alloc_path();
>   	if (!path)
> @@ -7048,6 +7062,8 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>   	if (ret < 0)
>   		goto error;
>   	while (1) {
> +		struct extent_buffer *node;
> +
>   		leaf = path->nodes[0];
>   		slot = path->slots[0];
>   		if (slot >= btrfs_header_nritems(leaf)) {
> @@ -7058,6 +7074,13 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>   				goto error;
>   			break;
>   		}
> +		node = path->nodes[1];
> +		if (node) {
> +			if (last_ra_node != node->start) {
> +				readahead_tree_node_children(node);
> +				last_ra_node = node->start;
> +			}
> +		}

We're doing a read search, path->nodes[1] won't be read locked here, so this 
isn't technically safe.  I realize that nobody else is going to be messing with 
stuff here, so maybe just a comment.  Thanks,

Josef

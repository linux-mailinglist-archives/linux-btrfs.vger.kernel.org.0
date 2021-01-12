Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7772F33D4
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 16:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404081AbhALPMs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 10:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404035AbhALPMr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 10:12:47 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EC4C061795
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 07:12:06 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id w79so2070946qkb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 07:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p6nHs722LNtVQng6i1tmK1s3mfSjyGnq6ztlToZAdRA=;
        b=scr4TGHzdHczFRrYhZ7Nlh31hLiOrzB8ocqsCJQX3r0j9E7YCREF18h/ZH8Pn3jkOl
         pSZCnBJzKBqI9RPSoXQoYANJanvKtirASGCHtkMbn442gMsImcpfdQsdAfoT33/wnBFe
         0WV4UCb+4o1eD7ZIVHFdjq4gIg4NDIlI9fMNajIpssAWhXiNqBa/PrAYDpKy3ilOSYiT
         Zr0Z7VDqsLrQkFX13xa+wSbnfjZP2PXa56HVbKzRvsGbA24bkBV5PyEkUwjHf4iDRhhY
         RnFQJ5G0wXuZ/X241rp7/09LnjVuRXMygeugJ1epuVed8IkIe5BmkHPoR/OYCsE2ru5E
         87vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p6nHs722LNtVQng6i1tmK1s3mfSjyGnq6ztlToZAdRA=;
        b=SgfyaaSu0qME2CIsqOnaEga8wCZ4wki8id8W7G/+1bqGR1MIfWmvb0QMCNFepbwDr/
         7m16xU9usG7S7e3kSJAGzBcJcJi4jpQQN/zFPGupQUj1wvjC13iKMvevXTGy6MSYOoUn
         JlB0clHynq4th4OwnVaOg/o7fNa5j/pxKYX+l6LxLoEovD+a8g1Ptib+RvLkfFVyuQrv
         0xkyCgqwWzmOmn7hCa62fZ6+3JR4l2WltcCH+ZAsIxB9PCl4+/Fe4HMuCaRn7DSiAH+P
         RgH8MWxnjcM7KaGcffxCsqjE9UAxVmjpFJLe857zcZ6E4WD2lBdiCAQjB/xs8cEgW46L
         nyUQ==
X-Gm-Message-State: AOAM530gyRGjGjc1rKg6Q9NpkAavbkgq8EZZqnQYD8VXLwdRqzRviL5h
        9NEmvwOUXKd4aooglSAo1aEFNA==
X-Google-Smtp-Source: ABdhPJzmfdQ/+KPWjiltm/rc7shUyKIBVveksHVyJ0h6SWy+mOH2UdbkWYdCHWNj6gF+6nT/1qDuOA==
X-Received: by 2002:a37:9583:: with SMTP id x125mr5134431qkd.75.1610464325540;
        Tue, 12 Jan 2021 07:12:05 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p6sm1174596qtl.21.2021.01.12.07.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 07:12:04 -0800 (PST)
Subject: Re: [PATCH v11 12/40] btrfs: calculate allocation offset for
 conventional zones
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <5101ed472a046b3fc691aeb90f84bb55790d4fc0.1608608848.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <95f5ef2f-ab89-9907-5c34-f9d9f7f88a9d@toxicpanda.com>
Date:   Tue, 12 Jan 2021 10:12:03 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5101ed472a046b3fc691aeb90f84bb55790d4fc0.1608608848.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/21/20 10:49 PM, Naohiro Aota wrote:
> Conventional zones do not have a write pointer, so we cannot use it to
> determine the allocation offset if a block group contains a conventional
> zone.
> 
> But instead, we can consider the end of the last allocated extent in the
> block group as an allocation offset.
> 
> For new block group, we cannot calculate the allocation offset by
> consulting the extent tree, because it can cause deadlock by taking extent
> buffer lock after chunk mutex (which is already taken in
> btrfs_make_block_group()). Since it is a new block group, we can simply set
> the allocation offset to 0, anyway.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   fs/btrfs/block-group.c |  4 +-
>   fs/btrfs/zoned.c       | 93 +++++++++++++++++++++++++++++++++++++++---
>   fs/btrfs/zoned.h       |  4 +-
>   3 files changed, 92 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 8c029e45a573..9eb1e3aa5e0f 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1867,7 +1867,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
>   			goto error;
>   	}
>   
> -	ret = btrfs_load_block_group_zone_info(cache);
> +	ret = btrfs_load_block_group_zone_info(cache, false);
>   	if (ret) {
>   		btrfs_err(info, "zoned: failed to load zone info of bg %llu",
>   			  cache->start);
> @@ -2150,7 +2150,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
>   	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
>   		cache->needs_free_space = 1;
>   
> -	ret = btrfs_load_block_group_zone_info(cache);
> +	ret = btrfs_load_block_group_zone_info(cache, true);
>   	if (ret) {
>   		btrfs_put_block_group(cache);
>   		return ret;
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index adca89a5ebc1..ceb6d0d7d33b 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -897,7 +897,62 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
>   	return 0;
>   }
>   
> -int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
> +static int calculate_alloc_pointer(struct btrfs_block_group *cache,
> +				   u64 *offset_ret)
> +{
> +	struct btrfs_fs_info *fs_info = cache->fs_info;
> +	struct btrfs_root *root = fs_info->extent_root;
> +	struct btrfs_path *path;
> +	struct btrfs_key key;
> +	struct btrfs_key found_key;
> +	int ret;
> +	u64 length;
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	key.objectid = cache->start + cache->length;
> +	key.type = 0;
> +	key.offset = 0;
> +
> +	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +	/* We should not find the exact match */
> +	if (ret <= 0) {
> +		ret = -EUCLEAN;
> +		goto out;
> +	}

We're eating the return value here if ret < 0, so I'd rather we do something like

if (!ret)
	ret = -EUCLEAN;
if (ret < 0)
	goto out;

Thanks,

Josef

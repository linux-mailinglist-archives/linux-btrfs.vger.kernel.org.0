Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3443425CC81
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 23:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgICVn2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 17:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgICVn1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Sep 2020 17:43:27 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B45C061244
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Sep 2020 14:43:27 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w16so4556009qkj.7
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Sep 2020 14:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TjHHYmIBA2d3NmlsQp/oEei/WnENPX18h1dgLpIvfCI=;
        b=oR5ydt/AcP3nUDRTskpWjE6uIZTEd/LnPGWafRm3rBI9br851PmYKi8HfvE/qtIwjX
         rFMRGVC1URByIWIQABaPN5rk4a4GhNnTKaUN2g3MOy1Tm5VPcKrg7hR89Bi4CUDeuiXu
         DiJwHbyYVFiC2LscWdRyswBXnc1jAtFGRCmWXEFErwZdDwk1F3Z7xKLwN+LE4FmhWH0L
         hVr0tuY/fxDQqsLIyciGQ+9TvD5OaZbFvoHE2/6Ce7gp8bVNVS1DsEqslWgI/sySuEsa
         coBaciQ0qpKdCqHFYBOXeT3YyvpYJwjgV+z/IsplWqnpqVoFQil9tuDC0Wv4i0tlZi3Y
         dBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TjHHYmIBA2d3NmlsQp/oEei/WnENPX18h1dgLpIvfCI=;
        b=ViLLypQ0JE/074K0tz68N5L9QIPirbj0CwwrievyTSPV8ZXc+JA9jryZSG3nImtyAe
         gCVjki7+NZDGcNtyBlAkpIUKvqVHU/Jrdqs9QjnS43yZCrogv04bUX58JCUQgxMY92S3
         WO1IKCi+4ewRs4GPPUPL0QCCB3gzz8Dxj7dVek7OJwa9b2sIV5i6dHEdbE9km6qNVrDo
         vOjT6TYwXGHkJR+vzLV1NLbnJHio5qKOrEJBvYLGSrQZZK/McvPeeM+qpQgPkNNiKrbr
         F07Um8lDTIQFKnqP46qHPEHv3Jxvw6eJEgJrAEFIMPdSJCie1uxrsJZpwRwDSIHyaRU0
         7Drg==
X-Gm-Message-State: AOAM532SZUJigPLTy9yCYfnF/OhRMGfHqapcZlt9406m1Tw5oKjsLK3H
        l4fWgJn6OdvUjKLbrTk9sCusRQ==
X-Google-Smtp-Source: ABdhPJw0xaOFkoAfMDM5j9N3q+NGAl7La8VUkY4kGF9W40JPt56FiCDThxT9E65ptsV5xmudOf4f8Q==
X-Received: by 2002:a05:620a:4090:: with SMTP id f16mr4969469qko.402.1599169406527;
        Thu, 03 Sep 2020 14:43:26 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::11a2? ([2620:10d:c091:480::1:9e05])
        by smtp.gmail.com with ESMTPSA id j88sm867068qte.96.2020.09.03.14.43.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 14:43:25 -0700 (PDT)
Subject: Re: [PATCH 2/2] btrfs: remove free space items when creating free
 space tree
To:     Boris Burkov <boris@bur.io>, Dave Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1599164377.git.boris@bur.io>
 <c52c3edb5927356a33a3aa7af2adea69f7361576.1599164377.git.boris@bur.io>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <a4e6d3da-50ee-28e4-d7c4-661396a0f53a@toxicpanda.com>
Date:   Thu, 3 Sep 2020 17:43:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c52c3edb5927356a33a3aa7af2adea69f7361576.1599164377.git.boris@bur.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/3/20 4:33 PM, Boris Burkov wrote:
> When the file system transitions from space cache v1 to v2 it removes
> the old cached data, but does not remove the FREE_SPACE items nor the
> free space inodes they point to. This doesn't cause any issues besides
> being a bit inefficient, since these items no longer do anything useful.
> 
> To fix it, as part of populating the free space tree, destroy each block
> group's free space item and free space inode. This code is lifted from
> the existing code for removing them when removing the block group.
> 
> Furthermore, cache_save_setup is called unconditionally from transaction
> commit on dirty block groups, so we must also stop creating these items
> when we are not using SPACE_CACHE.
> 
> References: https://github.com/btrfs/btrfs-todo/issues/5
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>   fs/btrfs/block-group.c      | 42 ++++---------------------------
>   fs/btrfs/free-space-cache.c | 49 ++++++++++++++++++++++++++++++++++++-
>   fs/btrfs/free-space-cache.h |  2 ++
>   fs/btrfs/free-space-tree.c  |  3 +++
>   4 files changed, 58 insertions(+), 38 deletions(-)
> 
<snip>

>   
> +	if (!btrfs_test_opt(fs_info, SPACE_CACHE))
> +		return 0;
> +

This is functionally unrelated, so it needs to be it's own patch.

>   	/*
>   	 * If this block group is smaller than 100 megs don't bother caching the
>   	 * block group.
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 8759f5a1d6a0..52612d99a842 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -207,6 +207,54 @@ int create_free_space_inode(struct btrfs_trans_handle *trans,
>   					 ino, block_group->start);
>   }
>   
> +int remove_free_space_inode(struct btrfs_trans_handle *trans,
> +			    struct btrfs_block_group *block_group)
> +{

It's public, lets call this btrfs_remove_free_space_inode().

<snip>

> @@ -2806,7 +2854,6 @@ void btrfs_remove_free_space_cache(struct btrfs_block_group *block_group)
>   	__btrfs_remove_free_space_cache_locked(ctl);
>   	btrfs_discard_update_discardable(block_group, ctl);
>   	spin_unlock(&ctl->tree_lock);
> -
>   }

Thou shall not change random whitespace that's not anywhere near the code you're 
modifying.  Thanks,

Josef

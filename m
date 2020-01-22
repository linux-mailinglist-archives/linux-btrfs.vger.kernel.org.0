Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C44D3145CEB
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 21:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgAVUMG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 15:12:06 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39215 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVUMG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 15:12:06 -0500
Received: by mail-qk1-f195.google.com with SMTP id c16so1037978qko.6
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 12:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=x53ii8/++8ZdtKTy7mp8p0/hX6jVTutknHCJBQwOc0U=;
        b=LRqyraB05kpokG2al5uepZJpG6HDSy4PhVw4cpQkjteF2RmZfEAoxvrzzjBdk3dBoh
         JXfAjJjFDFOJ2jAdCF0CMndR5i00vtiMOtrgb+q1RiPymrQ9j72mKmk+Ssl5+rarja5S
         jvUX8AzWhU++nbPaLRMjMG8H2wMkS+5LddZzq9FRTjUJft/E3rPcsyk+MC56xHz2XVnj
         n7imckDBRAJR86TpQ5nR927C/KKjZj8hAdPzwW48Z8dRFnzwpND+76zbOKgT/uKCnNpM
         D6iJCUGYs5YCrTKXozp6hVsEpoG9hUlkuUsN+J1kcO+zd0QAG99D8+OeOt59m5jgMExl
         ZszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x53ii8/++8ZdtKTy7mp8p0/hX6jVTutknHCJBQwOc0U=;
        b=Pnmbm1eQRpVOujViIG18vHQg7U3JZ6sHWiUA6j28drjjzrdxTRL0AfBK005WATXZAx
         KbQt/RBpqnR8vLpdqUnZSZlZRNSBNj2JeWCeTtOtKQkWFcsWfcWEYlGJ+6x6UFy45FGD
         BVJf8yQyLClKsbBC3j3G3C1wHSeia24FkyRMiwDHHX1741xWoIq81ZBsNdFVrp8QiTZq
         iVb7d7fvG9YgknvgT2k0m+mJC3K/bXTcKDhvOdTUlz/GapDZWDe4qmAA+fJKLqDviCFG
         TaPc20OGQCtH/eszAtV+oidCoOSb/dKxnrmNFNnHbJycIxVDA6y+Y+ztacBV/0I8Yx11
         bsCg==
X-Gm-Message-State: APjAAAWEAj4UYmdJnYKoWVz1L/WYaflkqY9XzvXEFhhKDaEmlF4JcOzK
        w6ZKJVxgQXYSxy440iKKCnzMbHv9GlpK8w==
X-Google-Smtp-Source: APXvYqxpN47i8ti1Q58MrtyS2LIHFqOt4sJIx2cFSO2++BBJYkOceaG32tpXeomPkZXHg7mTsI53Cg==
X-Received: by 2002:a37:6716:: with SMTP id b22mr11842601qkc.109.1579723924964;
        Wed, 22 Jan 2020 12:12:04 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id l184sm19479412qkc.107.2020.01.22.12.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 12:12:04 -0800 (PST)
Subject: Re: [PATCH 09/11] btrfs: Mark pinned log extents as excluded
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200120140918.15647-1-nborisov@suse.com>
 <20200120140918.15647-10-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <295cc04d-8267-c1b6-206b-2ee3a9332ac5@toxicpanda.com>
Date:   Wed, 22 Jan 2020 15:12:02 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120140918.15647-10-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/20/20 9:09 AM, Nikolay Borisov wrote:
> In preparation to making pinned extents per-transaction ensure that
> log such extents are always excluded from caching. To achieve this in
> addition to marking them via btrfs_pin_extent_for_log_replay they also
> need to be marked with btrfs_add_excluded_extent to prevent log tree
> extent buffer being loaded by the free space caching thread. That's
> required since log treeblocks are not recorded in the extent tree, hence
> they always look free.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>   fs/btrfs/extent-tree.c | 8 ++++++++
>   fs/btrfs/tree-log.c    | 2 +-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 7dcf9217a622..d680f2ac336b 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -2634,6 +2634,8 @@ int btrfs_pin_extent_for_log_replay(struct btrfs_trans_handle *trans,
>   	struct btrfs_block_group *cache;
>   	int ret;
>   
> +	btrfs_add_excluded_extent(trans->fs_info, bytenr, num_bytes);
> +
>   	cache = btrfs_lookup_block_group(trans->fs_info, bytenr);
>   	if (!cache)
>   		return -EINVAL;
> @@ -2920,6 +2922,12 @@ int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>   			mutex_unlock(&fs_info->unused_bg_unpin_mutex);
>   			break;
>   		}
> +		if (test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags)) {
> +			clear_extent_bits(&fs_info->freed_extents[0], start,
> +					  end, EXTENT_UPTODATE);
> +			clear_extent_bits(&fs_info->freed_extents[1], start,
> +					  end, EXTENT_UPTODATE);
> +		}
>   
>   		if (btrfs_test_opt(fs_info, DISCARD_SYNC))
>   			ret = btrfs_discard_extent(fs_info, start,
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index b535d409a728..f89de24838d5 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -2994,7 +2994,7 @@ static inline void btrfs_remove_log_ctx(struct btrfs_root *root,
>   	mutex_unlock(&root->log_mutex);
>   }
>   
> -/*
> +/*

nit: this part needs to be dropped.  Other than that

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

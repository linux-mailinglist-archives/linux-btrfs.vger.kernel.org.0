Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9C5145D00
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 21:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgAVUVO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 15:21:14 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38840 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVUVO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 15:21:14 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so1079128qki.5
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 12:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EoUpQPIhUuSL2hrUpihRHb7PiDGRmfLMXdwOxFiDopo=;
        b=WiVXoQnec1KVgudBH7o0mNSit6iYL0JRcoVvvGW3YRySu0uvkj9vkB0q5utcMEHHbW
         ic9nr8KsqVCtyXg8IZDRg11Z87t6gBqH/ki/hYUiG2cDeyxYRlakTnWz+EAgddLhj561
         zQGU1VODM2Lash4ome7qZjuTY0NcUsvWkSLYpnS23OhuDdPRoA55QB3K3dsFlC6nwWeZ
         tTRQipb2flp+kkrHWmpDADNQMaHcZejQ5fPWCE+g7BTw0/ejugKua0oELz1e/ethY3/J
         bfYa4bQHxKcukxoUfimWq5MpvzcS+leevTxjn4WFsze2ox8KQVYQADfuGLXOGnE6A35U
         igOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EoUpQPIhUuSL2hrUpihRHb7PiDGRmfLMXdwOxFiDopo=;
        b=PxAj9ehy4UaV62PhcGMUkPRLngMd3gD0p7sKS3lhm/RSVlbi++5FU7vCw9TCQdeugu
         W7luApEOCHe9kO/N7Ki72xIv9XrITTqA3Xru3qCXWkEzsULLGr536Bmi1wccGHhTUKQ4
         GILnKo3E6tiz5T8SRex5kItP5YdiK6jf2kElJPijEh213YifFrspZ8uBZOKv+q+5uVCv
         GktKGW5fVL6tsS2tnUZSVJ6Lzjc/CgA4e/RRHl9AT6Uzfzl31WIGnrOlzl7f7vh3Xapz
         RB4CBU1WLWJG6jeCMs9msfn0fo2WgvRy7Qj8OHbJ4s5+AO9eR+cdeoF07wObj9vbErLV
         juxQ==
X-Gm-Message-State: APjAAAXmSr1Wy85npPqFMX9N8Ah5rCbsyfSFQ/+AW0bWhopnQV0G/ASx
        0BANRujBuyfYrbodiTVFoDJdklyFqqwJOg==
X-Google-Smtp-Source: APXvYqxLSRIoqbOzijdm62asRiyyk/PKY4z3vt5jEoE3qPiU8kj6CaWCSBu4aw8vuiaPbC8AebUDLA==
X-Received: by 2002:a05:620a:133a:: with SMTP id p26mr11935974qkj.233.1579724472646;
        Wed, 22 Jan 2020 12:21:12 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id j4sm20707734qtv.53.2020.01.22.12.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 12:21:11 -0800 (PST)
Subject: Re: [PATCH 11/11] btrfs: Use btrfs_transaction::pinned_extents
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200120140918.15647-1-nborisov@suse.com>
 <20200120140918.15647-12-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b98bb8f2-2f3f-748b-793a-b9772f9f3569@toxicpanda.com>
Date:   Wed, 22 Jan 2020 15:21:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120140918.15647-12-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/20/20 9:09 AM, Nikolay Borisov wrote:
> This commit flips the switch to start tracking/processing pinned
> extents on a per-transaction basis. It mostly replaces all references
> from btrfs_fs_info::(pinned_extents|freed_extents[]) to
> btrfs_transaction::pinned_extents. Two notable modifications that
> warrant explicit mention are changing clean_pinned_extents to get a
> reference to the previously running transaction. The other one is
> removal of call to btrfs_destroy_pinned_extent since transactions are
> going to be cleaned in btrfs_cleanup_one_transaction.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

I'd prefer if the excluded extent changes were separate from the pinned extent 
changes.

> ---
>   fs/btrfs/block-group.c       | 38 ++++++++++++++++++++++++------------
>   fs/btrfs/ctree.h             |  4 ++--
>   fs/btrfs/disk-io.c           | 30 +++++-----------------------
>   fs/btrfs/extent-io-tree.h    |  3 +--
>   fs/btrfs/extent-tree.c       | 31 ++++++++---------------------
>   fs/btrfs/free-space-cache.c  |  2 +-
>   fs/btrfs/tests/btrfs-tests.c |  7 ++-----
>   fs/btrfs/transaction.c       |  1 +
>   fs/btrfs/transaction.h       |  1 +
>   include/trace/events/btrfs.h |  3 +--
>   10 files changed, 47 insertions(+), 73 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 48bb9e08f2e8..562dfb7dc77f 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -460,7 +460,7 @@ u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end
>   	int ret;
>   
>   	while (start < end) {
> -		ret = find_first_extent_bit(info->pinned_extents, start,
> +		ret = find_first_extent_bit(&info->excluded_extents, start,
>   					    &extent_start, &extent_end,
>   					    EXTENT_DIRTY | EXTENT_UPTODATE,
>   					    NULL);

We're no longer doing EXTENT_DIRTY in excluded_extents, so we don't need this part.

> @@ -1233,32 +1233,44 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
>   	return ret;
>   }
>   
> -static bool clean_pinned_extents(struct btrfs_block_group *bg)
> +static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
> +				 struct btrfs_block_group *bg)
>   {
>   	struct btrfs_fs_info *fs_info = bg->fs_info;
> +	struct btrfs_transaction *prev_trans = NULL;
>   	u64 start = bg->start;
>   	u64 end = start + bg->length - 1;
>   	int ret;
>   
> +	spin_lock(&fs_info->trans_lock);
> +	if (trans->transaction->list.prev != &fs_info->trans_list) {
> +		prev_trans = list_entry(trans->transaction->list.prev,
> +					struct btrfs_transaction, list);
> +		refcount_inc(&prev_trans->use_count);
> +	}
> +	spin_unlock(&fs_info->trans_lock);
> +
>   	/*
>   	 * Hold the unused_bg_unpin_mutex lock to avoid racing with
>   	 * btrfs_finish_extent_commit(). If we are at transaction N,
>   	 * another task might be running finish_extent_commit() for the
>   	 * previous transaction N - 1, and have seen a range belonging
> -	 * to the block group in freed_extents[] before we were able to
> -	 * clear the whole block group range from freed_extents[]. This
> +	 * to the block group in pinned_extents before we were able to
> +	 * clear the whole block group range from pinned_extents. This
>   	 * means that task can lookup for the block group after we
> -	 * unpinned it from freed_extents[] and removed it, leading to
> +	 * unpinned it from pinned_extents[] and removed it, leading to
>   	 * a BUG_ON() at unpin_extent_range().
>   	 */
>   	mutex_lock(&fs_info->unused_bg_unpin_mutex);
> -	ret = clear_extent_bits(&fs_info->freed_extents[0], start, end,
> -			  EXTENT_DIRTY);
> -	if (ret)
> -		goto failure;
> +	if (prev_trans) {
> +		ret = clear_extent_bits(&prev_trans->pinned_extents, start, end,
> +					EXTENT_DIRTY);
> +		if (ret)
> +			goto failure;
> +	}

You are leaking a ref to prev_trans here.

<snip>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 9209c7b0997c..3cb786463eb2 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2021,10 +2021,8 @@ void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info)
>   			btrfs_drop_and_free_fs_root(fs_info, gang[i]);
>   	}
>   
> -	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
> +	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
>   		btrfs_free_log_root_tree(NULL, fs_info);
> -		btrfs_destroy_pinned_extent(fs_info, fs_info->pinned_extents);
> -	}

What about the excluded extents?  We may never cache the block group with one of 
the super mirrors in it, and thus we would leak the excluded extent for it.  Thanks,

Josef

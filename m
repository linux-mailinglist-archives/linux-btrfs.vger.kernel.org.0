Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA199148663
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 14:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389974AbgAXNvE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 08:51:04 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42745 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387592AbgAXNvE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 08:51:04 -0500
Received: by mail-qk1-f193.google.com with SMTP id q15so2034651qke.9
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 05:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=i4oXlWEjvTnGhTzC2B+ysx5I0OOdymBRZm5G17lGDnA=;
        b=1nvhbiT19+YPD5+ufzN7IpF1n1cshCTW1kJ1jTkEbZEVBrDhmxi6oxT/EHL5/kAHtN
         Ime3vVSSrlNBB/q49oIXYFXRqHJZfmTfWaEZCjpv4xVIPIV+XaOmOsWl/dhOkJg48esD
         RHJg/H8SBbIgxQif291uS3OaE7rNYcWQEdW8G6pBupzPocsr2Ix1B3RBFEGN+wHmhirj
         FoU+GXigmOaOQKVmxBSelqb2k9p0kn390hQF0T+ciDz8utrjfsV5DC9Eq5f46zl5SKnS
         TDeAb6HbnM3bT63be1gJTOwcWNpR2vaySI65VWTi/7lhkJpWa8CTO7vADSfff3Q4LhWg
         irVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i4oXlWEjvTnGhTzC2B+ysx5I0OOdymBRZm5G17lGDnA=;
        b=E323TBTBSi4CmhwS1Aghb3gdGdW6rLk7EylFhSZKWNAs4zOv0zPfXUEgLrZ2yaBnbq
         2g2wmVhHhQoUi3q0FfLzBC9TPZmgUSUIqFDLuJnCFhFLvFprgDhu9HCed+z5+gYWUZx6
         8HOgqf1P8sgeoqGrr8/LCWaW4HPwuk7fDJ1aVqjXVq6SdsjzMlCiKSAQYrl9Gy5BdzwM
         PhvFPPUJGwCRsJgdHCOEr6tEIlEMVQsotHNUcC5OakzyuZAbts4AWlG1AVLnmi4Nos/z
         z+2dFIL+LXMxEhhqSKVqsnW4tKUwgg7iDJh33Tc47rUwv3PMI5+Jm6la2TYKY51Gtken
         tbjQ==
X-Gm-Message-State: APjAAAVAkNaJV1GPjk3oDc7v3WGF9YExd6dGy4pm/fHwpRapz01G6Ifk
        e9bBWXo96y3uOGhIGyiCfYQ2vajKlS6Y4Q==
X-Google-Smtp-Source: APXvYqzcxkcpisfF+ksshYDK8jfmPw6E+OUK//opHsCfnK6LtIL11cXCPZCsClYnvJroMtgbRNzCvQ==
X-Received: by 2002:ae9:f009:: with SMTP id l9mr2577369qkg.259.1579873862392;
        Fri, 24 Jan 2020 05:51:02 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::68b4])
        by smtp.gmail.com with ESMTPSA id g16sm3021438qkk.61.2020.01.24.05.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 05:51:01 -0800 (PST)
Subject: Re: [PATCH v2] btrfs: Use btrfs_transaction::pinned_extents
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200120140918.15647-12-nborisov@suse.com>
 <20200124103541.6415-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7b0cd11e-b001-02b8-a4d3-b592d9924f5e@toxicpanda.com>
Date:   Fri, 24 Jan 2020 08:51:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124103541.6415-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/24/20 5:35 AM, Nikolay Borisov wrote:
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
> ---
> 
> V2:
>   * Properly release transaction in clean_pinned_extents [Josef]
>   * Only check for EXTENT_UPTODATE in add_new_free_space [Josef]
> 
>   fs/btrfs/block-group.c       | 43 +++++++++++++++++++++++-------------
>   fs/btrfs/ctree.h             |  4 ++--
>   fs/btrfs/disk-io.c           | 30 +++++--------------------
>   fs/btrfs/extent-io-tree.h    |  3 +--
>   fs/btrfs/extent-tree.c       | 31 +++++++-------------------
>   fs/btrfs/free-space-cache.c  |  2 +-
>   fs/btrfs/tests/btrfs-tests.c |  7 ++----
>   fs/btrfs/transaction.c       |  1 +
>   fs/btrfs/transaction.h       |  1 +
>   include/trace/events/btrfs.h |  3 +--
>   10 files changed, 50 insertions(+), 75 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 48bb9e08f2e8..91054c32d88a 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -460,10 +460,9 @@ u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end
>   	int ret;
> 
>   	while (start < end) {
> -		ret = find_first_extent_bit(info->pinned_extents, start,
> +		ret = find_first_extent_bit(&info->excluded_extents, start,
>   					    &extent_start, &extent_end,
> -					    EXTENT_DIRTY | EXTENT_UPTODATE,
> -					    NULL);
> +					    EXTENT_UPTODATE, NULL);
>   		if (ret)
>   			break;
> 
> @@ -1233,32 +1232,46 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
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
> +
> +	btrfs_put_transaction(prev_trans);

The failure case is missing the put.  Thanks,

Josef

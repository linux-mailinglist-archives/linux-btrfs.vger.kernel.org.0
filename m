Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79AF238C7BA
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbhEUNXG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 09:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhEUNXA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 09:23:00 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42D0C06138B
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:21:32 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id a7so6022749qvf.11
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Xmlw8tB6R8KbjDVzJ49sXzY4GwE98g2CRz/AS2+sjFE=;
        b=OTGxkMKOWgt7XFKPRdRmJpSmpELFKzHDS3vPmsq3zvJFcvOkwtAY644Cf7J0E0IyIB
         tginSz2uw/8ytpP3fx31okGBNHsk4r7OJcibjyILpvJKEOtxf2l5KxPn122WqHFieIM2
         ktRh3B7xDlpUeH2yAraAcsL6FT1zqThPxRIC6FYS77PBwGhg4cA8PiIv0PArEDo5YcAX
         35p5C3VxXdK+PavR53U/OeU8CyY4LlkVj4a680wjFKuaAVgrW1UPVcwLNxMo4p/J3BqX
         etsJOqergOp1pjNdWq5K4KGnLEtGL/4NO5ESibxxERvd4UThv47RzxNHGj7mOQjuHS4R
         0NyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xmlw8tB6R8KbjDVzJ49sXzY4GwE98g2CRz/AS2+sjFE=;
        b=Eo+nrzq1GdKCQ8fmG4sm0dBGzr6QCAxdjfpqROSBaJCtG2c28pHAU9EZX4NsBWp9px
         4lqFFMk+6bukU2zY7q/o5u4iTscl8deJEPRAsfOmutWJGYx2urJecD1ssEypRDESeIHK
         3FR+lJMpLU9B3ICGzMmVB5fthxiOrtKqArJgTA7F73wR8J3HN0i+uLY9n4dGsVnPedDz
         bafWj9QDA2n7j95wwCWPS7W4TV50NixyCeOzoIk9/iipq+Gw+cc6c0tzlW1S98KJLWZ9
         CVeD82l2PkatG9A3PrUt++NeWilRQt9FKPzIPFNWl1qdI2TvQHS1qRKDN3j9QrIZGJiJ
         KPoQ==
X-Gm-Message-State: AOAM53340hEehnlV/VId5uJJwi9TGRUv2VVFJYhZh+ZLxkGZFJBZNUnT
        pL2zbMqrZRHWQR9fhUJlgEPSd2ddg5WsXw==
X-Google-Smtp-Source: ABdhPJxoO/9YigUiCMmJbVmzHmP1zgdBfajYh21Iy+vjRFKHBlRK44S37t4hEg0fKooZl4AmOkdjAQ==
X-Received: by 2002:a0c:a9db:: with SMTP id c27mr12930111qvb.50.1621603291456;
        Fri, 21 May 2021 06:21:31 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::114c? ([2620:10d:c091:480::1:e74])
        by smtp.gmail.com with ESMTPSA id a14sm4337244qtj.57.2021.05.21.06.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 06:21:30 -0700 (PDT)
Subject: Re: [PATCH 2/6] btrfs: add cancelable chunk relocation support
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621526221.git.dsterba@suse.com>
 <79a09502c532bc9939645d2711c72ebad5fce2e7.1621526221.git.dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b470465d-a608-b170-bd05-2d88dc9b1e45@toxicpanda.com>
Date:   Fri, 21 May 2021 09:21:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <79a09502c532bc9939645d2711c72ebad5fce2e7.1621526221.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/21/21 8:06 AM, David Sterba wrote:
> Add support code that will allow canceling relocation on the chunk
> granularity. This is different and independent of balance, that also
> uses relocation but is a higher level operation and manages it's own
> state and pause/cancelation requests.
> 
> Relocation is used for resize (shrink) and device deletion so this will
> be a common point to implement cancelation for both. The context is
> entirely in btrfs_relocate_block_group and btrfs_recover_relocation,
> enclosing one chunk relocation. The status bit is set and unset between
> the chunks. As relocation can take long, the effects may not be
> immediate and the request and actual action can slightly race.
> 
> The fs_info::reloc_cancel_req is only supposed to be increased and does
> not pair with decrement like fs_info::balance_cancel_req.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/ctree.h      |  9 +++++++
>   fs/btrfs/disk-io.c    |  1 +
>   fs/btrfs/relocation.c | 60 ++++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index a142e56b6b9a..3dfc32a3ebab 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -565,6 +565,12 @@ enum {
>   	 */
>   	BTRFS_FS_BALANCE_RUNNING,
>   
> +	/*
> +	 * Indicate that relocation of a chunk has started, it's set per chunk
> +	 * and is toggled between chunks.
> +	 */
> +	BTRFS_FS_RELOC_RUNNING,
> +
>   	/* Indicate that the cleaner thread is awake and doing something. */
>   	BTRFS_FS_CLEANER_RUNNING,
>   
> @@ -871,6 +877,9 @@ struct btrfs_fs_info {
>   	struct btrfs_balance_control *balance_ctl;
>   	wait_queue_head_t balance_wait_q;
>   
> +	/* Cancelation requests for chunk relocation */
> +	atomic_t reloc_cancel_req;
> +
>   	u32 data_chunk_allocations;
>   	u32 metadata_ratio;
>   
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 8c3db9076988..93c994b78d61 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2251,6 +2251,7 @@ static void btrfs_init_balance(struct btrfs_fs_info *fs_info)
>   	atomic_set(&fs_info->balance_cancel_req, 0);
>   	fs_info->balance_ctl = NULL;
>   	init_waitqueue_head(&fs_info->balance_wait_q);
> +	atomic_set(&fs_info->reloc_cancel_req, 0);
>   }
>   
>   static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index b70be2ac2e9e..9b84eb86e426 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2876,11 +2876,12 @@ int setup_extent_mapping(struct inode *inode, u64 start, u64 end,
>   }
>   
>   /*
> - * Allow error injection to test balance cancellation
> + * Allow error injection to test balance/relocation cancellation
>    */
>   noinline int btrfs_should_cancel_balance(struct btrfs_fs_info *fs_info)
>   {
>   	return atomic_read(&fs_info->balance_cancel_req) ||
> +		atomic_read(&fs_info->reloc_cancel_req) ||
>   		fatal_signal_pending(current);
>   }
>   ALLOW_ERROR_INJECTION(btrfs_should_cancel_balance, TRUE);
> @@ -3780,6 +3781,47 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
>   	return inode;
>   }
>   
> +/*
> + * Mark start of chunk relocation that is cancelable. Check if the cancelation
> + * has been requested meanwhile and don't start in that case.
> + *
> + * Return:
> + *   0             success
> + *   -EINPROGRESS  operation is already in progress, that's probably a bug
> + *   -ECANCELED    cancelation request was set before the operation started
> + */
> +static int reloc_chunk_start(struct btrfs_fs_info *fs_info)
> +{
> +	if (test_and_set_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags)) {
> +		/* This should not happen */
> +		btrfs_err(fs_info, "reloc already running, cannot start");
> +		return -EINPROGRESS;
> +	}
> +
> +	if (atomic_read(&fs_info->reloc_cancel_req) > 0) {
> +		btrfs_info(fs_info, "chunk relocation canceled on start");
> +		/*
> +		 * On cancel, clear all requests but let the caller mark
> +		 * the end after cleanup operations.
> +		 */
> +		atomic_set(&fs_info->reloc_cancel_req, 0);
> +		return -ECANCELED;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Mark end of chunk relocation that is cancelable and wake any waiters.
> + */
> +static void reloc_chunk_end(struct btrfs_fs_info *fs_info)
> +{
> +	/* Requested after start, clear bit first so any waiters can continue */
> +	if (atomic_read(&fs_info->reloc_cancel_req) > 0)
> +		btrfs_info(fs_info, "chunk relocation canceled during operation");
> +	clear_and_wake_up_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags);
> +	atomic_set(&fs_info->reloc_cancel_req, 0);
> +}
> +
>   static struct reloc_control *alloc_reloc_control(struct btrfs_fs_info *fs_info)
>   {
>   	struct reloc_control *rc;
> @@ -3862,6 +3904,12 @@ int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group_start)
>   		return -ENOMEM;
>   	}
>   
> +	ret = reloc_chunk_start(fs_info);
> +	if (ret < 0) {
> +		err = ret;
> +		goto out_end;
> +	}

This needs a btrfs_put_block_group(bg) so we don't leak the bg.  Thanks,

Josef

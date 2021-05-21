Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8555638C80F
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 15:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhEUNav (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 09:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbhEUNao (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 09:30:44 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD14C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:29:19 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id k4so8561570qkd.0
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 06:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=KOlIgJUU7Vk+G+HLMH7RqvW3rghMWsnIglsxtxplTq0=;
        b=uj7Hl1hyXBJ0wLJ7htt7Kp5dMGndGpv1m261fMbMfOdFl+8ZmAWzp2l4+hqgdtrcPR
         Wi0tNB3XnvDibwVEfYXNNk+DSfBAZGTS2T1Ds/nA3EeyU+QsGfvt8A74O33PMxrCXSwV
         Q1dlIqZQjniUbKy9S2Uj4nUYyL94fYGiKsRU5NbWV+qmL/rIwPLHUD/Y01/QLfcNZNaU
         BFtLoqQM0rUsDehRLldST+3o9cn8WMVAm1cZAOmof1xqkDSTOfrvhKY1vu9hRJG15BiH
         hfPIO4Mw5XiMTBzunNgOcjHCTk5ZM0WLPQNoQjynmtUOqajXCjoC6488dbuwMP4/FhtG
         HkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KOlIgJUU7Vk+G+HLMH7RqvW3rghMWsnIglsxtxplTq0=;
        b=HWCDa7s/ljHt23dFkjxW2r11y/Y/TNscoOJQL1Q45m4iL4pJcbl8q62Vs5KvlhhlZN
         2qbLOIwUSw0YUJ7XDnFtGVVTOtC1Fz24uRBRiNiUkUh9sZzuzPt64JiubkN9cJRw5Gyt
         s34h3x7kzzFib8WdhjdvLqp1/E68ZbQIokipWnOMELoOjK27KTIH9NetB5SbRKiBXBcu
         XrPjEOaMzZit0xte7sDYTQCpppUeYYPRy9JvPIQEzVWWccWeQbb3NRYX0ckUWtkMb/so
         NZzYIMeSH+fJVCK3GkJq00CEM/ikGwbmRnjPjI0aBIzlhR2Yh9qj2nukpznhQLbs/LUM
         FcDA==
X-Gm-Message-State: AOAM5327XQimZbJC4xjLdu+HNsmLaUOG0jeNRO+t7cDK4e63uHEH6Y9a
        jZGl6AMyvUzBavLLtzGAdiU7K1cLhQervQ==
X-Google-Smtp-Source: ABdhPJwnAex+kCWnvADQUzQoBtXM/OJBl5UmSq2tk9parKJwAbKVgxwU8jVKsokfhvJ+v2nbSf96dg==
X-Received: by 2002:ae9:c219:: with SMTP id j25mr9402527qkg.235.1621603758335;
        Fri, 21 May 2021 06:29:18 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::114c? ([2620:10d:c091:480::1:e74])
        by smtp.gmail.com with ESMTPSA id a131sm5035738qkg.99.2021.05.21.06.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 06:29:17 -0700 (PDT)
Subject: Re: [PATCH 4/6] btrfs: add wrapper for conditional start of exclusive
 operation
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1621526221.git.dsterba@suse.com>
 <fe9738eb5db055e06eafb178bf6aea41c48b2890.1621526221.git.dsterba@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <80f75399-9dee-e26c-6433-6e361bc9136b@toxicpanda.com>
Date:   Fri, 21 May 2021 09:29:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <fe9738eb5db055e06eafb178bf6aea41c48b2890.1621526221.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/21/21 8:06 AM, David Sterba wrote:
> To support optional cancelation of some operations, add helper that will
> wrap all the combinations. In normal mode it's same as
> btrfs_exclop_start, in cancelation mode it checks if it's already
> running and request cancelation and waits until completion.
> 
> The error codes can be returned to to user space and semantics is not
> changed, adding ECANCELED. This should be evaluated as an error and that
> the operation has not completed and the operation should be restarted
> or the filesystem status reviewed.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/ioctl.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index cacd6ee17d8e..c75ccadf23dc 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1600,6 +1600,48 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
>   	return ret;
>   }
>   
> +/*
> + * Try to start exclusive operation @type or cancel it if it's running.
> + *
> + * Return:
> + *   0        - normal mode, newly claimed op started
> + *  >0        - normal mode, something else is running,
> + *              return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS to user space
> + * ECANCELED  - cancel mode, successful cancel
> + * ENOTCONN   - cancel mode, operation not running anymore
> + */
> +static int exclop_start_or_cancel_reloc(struct btrfs_fs_info *fs_info,
> +			enum btrfs_exclusive_operation type, bool cancel)
> +{
> +	if (!cancel) {
> +		/* Start normal op */
> +		if (!btrfs_exclop_start(fs_info, type))
> +			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
> +		/* Exclusive operation is now claimed */
> +		return 0;
> +	}
> +
> +	/* Cancel running op */
> +	if (btrfs_exclop_start_try_lock(fs_info, type)) {
> +		/*
> +		 * This blocks any exclop finish from setting it to NONE, so we
> +		 * request cancelation. Either it runs and we will wait for it,
> +		 * or it has finished and no waiting will happen.
> +		 */
> +		atomic_inc(&fs_info->reloc_cancel_req);
> +		btrfs_exclop_start_unlock(fs_info);
> +
> +		if (test_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags))
> +			wait_on_bit(&fs_info->flags, BTRFS_FS_RELOC_RUNNING,
> +				    TASK_INTERRUPTIBLE);

Do we want to capture the return value here, in case the user hit's ctrl+c we 
can return -EINTR instead so we don't think it succeeded?  Thanks,

Josef

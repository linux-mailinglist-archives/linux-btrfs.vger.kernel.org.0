Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861FE64B9C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 17:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiLMQa4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 11:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbiLMQay (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 11:30:54 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FCFE0CC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 08:30:53 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id d131so18293617ybh.4
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 08:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q/AImeUERZ/tTWRNwMDAiHilJvK01WYMqR2Qsjs2lgY=;
        b=PyguHsWfOMkI2u/NFIfqimD4lc/hRtgaoovx+JKPiA6ua+cUiSivwQyCS1+07KRLwW
         goy77LwOKk4jKO66Zuq9VBwHsxiqIjXgLFX2DQFn18w/eX4zJ/ZibA3STVMkR1VuABze
         jeGF0NpsimFgEl2Kdj88ie8ykLpQr6porK9HPwAManDG5lLIfxgABC1PQoZSVuHWQJUr
         2OBWJaqpqnCdevuZX4NFSdkydMlZwAO0CzomoJXuQtyKVQtjb6H2ek7wVjEPbHBAS6M3
         8ZOpv2AGO6Pz8fqaiwud32HDCmCKub8ekuXgBnL26CV5Aj7ndnxnHtMGJodNYLUBVXVo
         4Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/AImeUERZ/tTWRNwMDAiHilJvK01WYMqR2Qsjs2lgY=;
        b=HWs8RYZxLycT1JQbtwk50PgiLJTPsHvv43Sdy6PPXgOY/JpUkydwb/zhyo/juuIjjM
         VY+Kl0Nc7AMCQ/kxHQG6J09bYj6GKZxwh7CtMXmuqGHNJBP1Wm3RCe9m7nqW6Suqp3pO
         nf7IVjXocY5VeAqJ7GSjjeRWIPM0Oi34du/Bntdb9VU6eIdFYcwdh/i44Zu5A6apvXm5
         uYMO02PYLNeG/s0VgUqpalfb9/OfXt15FP9DXuABS6tnW/yC1Dhagxmk4oJBcL9YTpT4
         fggfLsQ9FPtADBWNbaXGMqFiWpq2EY1u2OggzrNGRircbu6ag15afk56WBpK2yJXrh2z
         9XGw==
X-Gm-Message-State: ANoB5pmrIuOceskgSHZc0zFbI+VYyPGbcmGjmdVj66egnE4z40BIq5aG
        hBa2WCghf4OzMfR6sm/ZGOLR8Q==
X-Google-Smtp-Source: AA0mqf5yhPqO3P/5QAo5HggNB7s5A5NQgvv4zNn2Fer9SjJDxaU4wQd09NJNaGZcNEP0j5uY8LflLw==
X-Received: by 2002:a25:f813:0:b0:703:8452:eeb3 with SMTP id u19-20020a25f813000000b007038452eeb3mr22430860ybd.55.1670949052201;
        Tue, 13 Dec 2022 08:30:52 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006fef157c8aesm8277929qko.36.2022.12.13.08.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 08:30:51 -0800 (PST)
Date:   Tue, 13 Dec 2022 11:30:50 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 02/16] btrfs: qgroup flush responsibility of the caller
Message-ID: <Y5iouuUBYRXN5Zu4@localhost.localdomain>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <b5ea2b71e950e0452053cc7ceaade4b96ead6103.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ea2b71e950e0452053cc7ceaade4b96ead6103.1668530684.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 12:00:20PM -0600, Goldwyn Rodrigues wrote:
> Qgroup reservation will be performed under extent locks. If qgroup runs
> low, btrfs starts a flush to squeeze out the last available space from
> over-reserved uncommitted extents. Move the flush outside of the
> reserve function so it can be called by the callee of the
> reserving function.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/block-group.c    |  2 +-
>  fs/btrfs/delalloc-space.c | 17 +++++++----------
>  fs/btrfs/delalloc-space.h |  5 ++---
>  fs/btrfs/file.c           | 19 ++++++++++++++++---
>  fs/btrfs/inode.c          | 23 +++++++++++++----------
>  fs/btrfs/qgroup.c         | 27 +--------------------------
>  fs/btrfs/qgroup.h         | 16 ++++++----------
>  fs/btrfs/relocation.c     |  3 +--
>  fs/btrfs/root-tree.c      |  3 +--
>  9 files changed, 48 insertions(+), 67 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 708d843daa72..578c6cbdef3b 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2945,7 +2945,7 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
>  	cache_size *= fs_info->sectorsize;
>  
>  	ret = btrfs_check_data_free_space(BTRFS_I(inode), &data_reserved, 0,
> -					  cache_size, false);
> +					  cache_size);
>  	if (ret)
>  		goto out_put;
>  
> diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
> index 7ddb1d104e8e..b46614bec817 100644
> --- a/fs/btrfs/delalloc-space.c
> +++ b/fs/btrfs/delalloc-space.c
> @@ -130,7 +130,7 @@ int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
>  
>  int btrfs_check_data_free_space(struct btrfs_inode *inode,
>  				struct extent_changeset **reserved, u64 start,
> -				u64 len, bool noflush)
> +				u64 len)
>  {
>  	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_FLUSH_DATA;
> @@ -141,9 +141,7 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
>  	      round_down(start, fs_info->sectorsize);
>  	start = round_down(start, fs_info->sectorsize);
>  
> -	if (noflush)
> -		flush = BTRFS_RESERVE_NO_FLUSH;
> -	else if (btrfs_is_free_space_inode(inode))
> +	if (btrfs_is_free_space_inode(inode))
>  		flush = BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE;
> 

You can't do this, because we also use this path for the nowait stuff, so we
need to be able to do this noflush thing.  Additionally this patch changes a
bunch of different things at once, tho tbf it's changing this and that has
cascading effects.  Take this particular change out and see what the patch looks
like and then you can decide if it needs to be split more.  Thanks,

Josef 

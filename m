Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF815782FCC
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 20:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbjHUSAL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 14:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjHUSAL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 14:00:11 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345A810E
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:00:08 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-58ca499456dso41243497b3.1
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 11:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692640807; x=1693245607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JWuUT8SlXVDlGa9A7KR+e73cBOlTresG28RuRcRbhQU=;
        b=ez8BcWXZbQUz3OTy3B3t9GzRZcf0Yit5H5nV/d2eLzO0sHCUkzuFab2zauUreULIhp
         abqNrYkfQNuzpB2vM5Jl4OnShitLpPuO5C5ZYZEUd/aTYq+D6cbkj/EHpa6lR1UEcOOq
         uxT49BM4RHBsVhUvcELvxEbV3niuTokVfPfJVYng9w4Z+Iv+swJCgeDEuMldJuQjw7tU
         RLOrBW9oDUGKlBfD+Xmm1KlWtuRZsCJt1863KWxqkpMEGsVqOHosCPw5HxmmTDrMNuL3
         +j850+3PJ7gRyJ4wGjuWV3GhTEkhrwpscji4y3S2900cZ2Hygw5mY/rGyV4C5xlGHLCV
         qI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692640807; x=1693245607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWuUT8SlXVDlGa9A7KR+e73cBOlTresG28RuRcRbhQU=;
        b=Ep4R8G5gV0QZbTNG3GO7JG9xi7Uxwa5dzdKDnFH6ZrcUQJQhdFmev5d/oK9Ut1L2/T
         HiqfFYvQi8RNkOAC7wHPEbgFExTmxYXam/MVaPyz/GZ9j7OlO1mPJgMxONCrdvxz3ljU
         zmCtDbH52p6E37J5DrLPJ1t0WBmr5Dn/iksZFB+G7mLKQO+rPzClTo6xWphiZScDwZi3
         Y7GaOx0oHdvEcKUk1nI4UV8YydqBDJsTlp2j2Lub3OIHb47U71obvpSXVvl+D0xpyfJI
         pu2wv/jM4+wzyqr40/5LBv2k/YtATNLZ0whrLK+EVUS3Chm3H4ystuuGfBUrrWg1/Oqw
         qtHA==
X-Gm-Message-State: AOJu0YwEW6L1Y0eqz6xo0kci38XhEdnpXUN7qUy8/IibfBzBQA3WuycR
        RpIPQi6Re2nlLgCdoMErWRKdrGRgf/OlQiCbbGk=
X-Google-Smtp-Source: AGHT+IEOiynwAGlDkOecc3WiBv025viuyW/78M1iHgdJAZ+T9JDCHmCExJvV298n7mgER4qAPCwZrQ==
X-Received: by 2002:a0d:dd47:0:b0:589:f8c7:244 with SMTP id g68-20020a0ddd47000000b00589f8c70244mr7567993ywe.33.1692640807148;
        Mon, 21 Aug 2023 11:00:07 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id w4-20020a817b04000000b00583b144fe51sm986962ywc.118.2023.08.21.11.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:00:06 -0700 (PDT)
Date:   Mon, 21 Aug 2023 14:00:05 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 02/18] btrfs: add new quota mode for simple quotas
Message-ID: <20230821180005.GA2990654@perftesting>
References: <cover.1690495785.git.boris@bur.io>
 <f202a99129b673a2dae686d2421f50995d00d2f9.1690495785.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f202a99129b673a2dae686d2421f50995d00d2f9.1690495785.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 27, 2023 at 03:12:49PM -0700, Boris Burkov wrote:
> Add a new quota mode called "simple quotas". It can be enabled by the
> existing quota enable ioctl via a new command, and sets an incompat
> bit, as the implementation of simple quotas will make backwards
> incompatible changes to the disk format of the extent tree.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/delayed-ref.c          |  4 +-
>  fs/btrfs/fs.h                   |  5 +-
>  fs/btrfs/ioctl.c                |  3 +-
>  fs/btrfs/qgroup.c               | 91 +++++++++++++++++++++++----------
>  fs/btrfs/qgroup.h               |  4 +-
>  fs/btrfs/root-tree.c            |  2 +-
>  fs/btrfs/transaction.c          |  4 +-
>  include/uapi/linux/btrfs.h      |  2 +
>  include/uapi/linux/btrfs_tree.h | 14 ++++-
>  9 files changed, 91 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 6a13cf00218b..a9b938d3a531 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -898,7 +898,7 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
>  		return -ENOMEM;
>  	}
>  
> -	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) &&
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_DISABLED &&
>  	    !generic_ref->skip_qgroup) {
>  		record = kzalloc(sizeof(*record), GFP_NOFS);
>  		if (!record) {
> @@ -1002,7 +1002,7 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
>  		return -ENOMEM;
>  	}
>  
> -	if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags) &&
> +	if (btrfs_qgroup_mode(fs_info) != BTRFS_QGROUP_MODE_DISABLED &&
>  	    !generic_ref->skip_qgroup) {
>  		record = kzalloc(sizeof(*record), GFP_NOFS);
>  		if (!record) {
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 203d2a267828..f76f450c2abf 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -218,7 +218,8 @@ enum {
>  	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
>  	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
>  	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
> -	 BTRFS_FEATURE_INCOMPAT_ZONED)
> +	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
> +	 BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA)
>  
>  #ifdef CONFIG_BTRFS_DEBUG
>  	/*
> @@ -233,7 +234,6 @@ enum {
>  
>  #define BTRFS_FEATURE_INCOMPAT_SUPP		\
>  	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE)
> -

Extraneous newline change.

>  #endif
>  
>  #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
> @@ -790,7 +790,6 @@ struct btrfs_fs_info {
>  	struct lockdep_map btrfs_state_change_map[4];
>  	struct lockdep_map btrfs_trans_pending_ordered_map;
>  	struct lockdep_map btrfs_ordered_extent_map;
> -

Same here.  Once you fix it up you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

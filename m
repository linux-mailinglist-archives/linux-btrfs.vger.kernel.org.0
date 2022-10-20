Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA33606434
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 17:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJTPVr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 11:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiJTPVM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 11:21:12 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939362F387
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:21:10 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id z30so63853qkz.13
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 08:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zzf6EKndYNPyp3/AHMjDli7i/Flk7hDbvcS5/Tbyrsk=;
        b=GJJdrfemsuCJsw0XYmyVdnVRq7DuBeE+6zB8OA6uf/8AZRhWk4fjeGRww8bilziy7g
         txNuWjqAYNQVmKh4SwLYTkoATx5jl6HthIYHrLdTjnsoCH7JLlcoGCz+OicLceYgWHzS
         EEZ97jfrAX+Lea+WQOHraGQbvfs6M+FK3UVSZxbih5gxnb+i0HOVQOXviw4/yOLvW0R3
         lylfqkA8lkSO9jYeV1h4cgjbc1tEXto2fbPu9mDoIEwH/xhtEZIyf0zGt7KIW+eSJ8nx
         PWGpkmAnefAzJg0qXwWX9l6ddPWkn8k5QIZ4M9Ar8fLTz4ACDKlxnRI7IZwvAi+vITy2
         W54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zzf6EKndYNPyp3/AHMjDli7i/Flk7hDbvcS5/Tbyrsk=;
        b=m08FGlYXIwJZPgawFKmgyDtDoSHxtm8QPwhPmfb0fh5Fw/zbGYO/kzNuR6rErBSAK8
         QB58pgeTYjAzKrN8GXLGQh/XOVpaznjzctM1yPXRm+OWw+AJBju3D9h5v9yjcrqxI/4k
         1Cr1Ze6ZW2TyQlIdlY348luC6XHPSdDlju6P2zUzkdAjcZXAJy/xWKf6qPlCoLOJkix2
         w+1qG7B8KUwX1tqLtgFt4086jzhG/UYXSQz4MBOvLHDjI/d45MzvmxPKB75nU+rTy2TP
         v+EGhsFM5irLdxo6R0GEOZ6pczqu8b8U0HPJ0a7i0kSPh40xnDAr0isAhWb6y3Hlri6O
         oQWw==
X-Gm-Message-State: ACrzQf2Ix5a2wb4Osabe2QGZ/L/f40AYsyPndNdP4s9xXUtBSsbyDsoF
        sGL4Xoz4v3Mjgz4tech6138PdlUYelXx5A==
X-Google-Smtp-Source: AMsMyM7Q89SpwSvHFMNeMMpQj/ldNRNSCgNWrOrcu84+94AD/cWyTYfIJCp3yx0rzqyaj3Hv640kkQ==
X-Received: by 2002:a05:620a:1505:b0:6e9:168f:76a5 with SMTP id i5-20020a05620a150500b006e9168f76a5mr9652651qkk.142.1666279269073;
        Thu, 20 Oct 2022 08:21:09 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id bk41-20020a05620a1a2900b006eeaf9160d6sm7274081qkb.24.2022.10.20.08.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:21:08 -0700 (PDT)
Date:   Thu, 20 Oct 2022 11:21:07 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [RFC v3 01/11] btrfs: add raid stripe tree definitions
Message-ID: <Y1FnY2PAe14ClUNm@localhost.localdomain>
References: <cover.1666007330.git.johannes.thumshirn@wdc.com>
 <6ca9b49af62a15f7a3482aca3f2566cc10ce8330.1666007330.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ca9b49af62a15f7a3482aca3f2566cc10ce8330.1666007330.git.johannes.thumshirn@wdc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 04:55:19AM -0700, Johannes Thumshirn wrote:
> Add definitions for the raid stripe tree. This tree will hold information
> about the on-disk layout of the stripes in a RAID set.
> 
> Each stripe extent has a 1:1 relationship with an on-disk extent item and
> is doing the logical to per-drive physical address translation for the
> extent item in question.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/ctree.h                | 29 +++++++++++++++++++++++++++++
>  include/uapi/linux/btrfs_tree.h | 20 ++++++++++++++++++--
>  2 files changed, 47 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 87bb4218276b..80ead27299dc 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1992,6 +1992,35 @@ BTRFS_SETGET_FUNCS(timespec_nsec, struct btrfs_timespec, nsec, 32);
>  BTRFS_SETGET_STACK_FUNCS(stack_timespec_sec, struct btrfs_timespec, sec, 64);
>  BTRFS_SETGET_STACK_FUNCS(stack_timespec_nsec, struct btrfs_timespec, nsec, 32);
>  
> +BTRFS_SETGET_FUNCS(stripe_extent_devid, struct btrfs_stripe_extent, devid, 64);
> +BTRFS_SETGET_FUNCS(stripe_extent_physical, struct btrfs_stripe_extent, physical, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_devid, struct btrfs_stripe_extent, devid, 64);
> +BTRFS_SETGET_STACK_FUNCS(stack_stripe_extent_physical, struct btrfs_stripe_extent, physical, 64);
> +
> +static inline struct btrfs_stripe_extent *btrfs_stripe_extent_nr(
> +					 struct btrfs_dp_stripe *dps, int nr)
> +{
> +	unsigned long offset = (unsigned long)dps;
> +
> +	offset += offsetof(struct btrfs_dp_stripe, extents);
> +	offset += nr * sizeof(struct btrfs_stripe_extent);
> +	return (struct btrfs_stripe_extent *)offset;
> +}
> +
> +static inline u64 btrfs_stripe_extent_devid_nr(const struct extent_buffer *eb,
> +					       struct btrfs_dp_stripe *dps,
> +					       int nr)
> +{
> +	return btrfs_stripe_extent_devid(eb, btrfs_stripe_extent_nr(dps, nr));
> +}
> +
> +static inline u64 btrfs_stripe_extent_physical_nr(const struct extent_buffer *eb,
> +						  struct btrfs_dp_stripe *dps,
> +						  int nr)
> +{
> +	return btrfs_stripe_extent_physical(eb, btrfs_stripe_extent_nr(dps, nr));
> +}
> +
>  /* struct btrfs_dev_extent */
>  BTRFS_SETGET_FUNCS(dev_extent_chunk_tree, struct btrfs_dev_extent,
>  		   chunk_tree, 64);
> diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
> index 5f32a2a495dc..047e1d0b2ff6 100644
> --- a/include/uapi/linux/btrfs_tree.h
> +++ b/include/uapi/linux/btrfs_tree.h
> @@ -4,9 +4,8 @@
>  
>  #include <linux/btrfs.h>
>  #include <linux/types.h>
> -#ifdef __KERNEL__
>  #include <linux/stddef.h>
> -#else
> +#ifndef __KERNEL__
>  #include <stddef.h>
>  #endif
> 

Gotta act like I did something, this is unrelated and should probably be it's
own thing separate from the raid stripe tree.  Thanks,

Josef

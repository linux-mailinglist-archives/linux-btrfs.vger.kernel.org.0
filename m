Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53715184EBF
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 19:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgCMSg5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 14:36:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39602 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgCMSg4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 14:36:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id w65so5738440pfb.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 11:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q5dwsz2IwtgHSQoZq6tchWTniKWViGN4sCw8tRdk6ck=;
        b=d6B8Mik84ybmAiGbPTWwWhjIxTsFc7PwGQPEBv3XdLV0lzAqMZgc+mRQ2JlN3d7LM8
         U5ZGB5inpX4w9pdHjoLOM/sY8vwzuYYXIqY1IgiEojz5evbwRCAy/S6zvpFinH8Gu1lf
         PSoN+xopRDPL8eBT5Yli9i8bSxaaeQUhqNSdYjg5QFLe/30ZxePcZke0xq0AFm4835KU
         hDqQ5Y8eEy5sCi8RvKGScwBAT6BhmW7jXJBZo5m8tqwi1ZB+g+r9lYZhAmjc00zcq2vS
         t8oNya9TdcdrkJAYZHeyEsSPrjXpM/tescQGUWP3Lt3FK9K1NROF+3s92r10rwFYb1dG
         dFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q5dwsz2IwtgHSQoZq6tchWTniKWViGN4sCw8tRdk6ck=;
        b=lEBeyhNG+IJBPpn05mm7/Y2gu/j8UwAadoweu/pgPWEUGt3L6PFzjHKfy+qb1bru4o
         dJgbmwoO3pjCjSffJke4KzXO8tZV2Fpc/ByuZt7ippvYydKtVF8ZgGWxg+l78ZtKxbgt
         a/9bFEmoWt9OkNW4cokl7PnAmbvXLJDdODeVfwsc3D2JDc51dsAqdJLLkqGldzkzGpOU
         usz46HkU4mDeM9JujJjAE8FObbqjMq0X1imjfQjDLo73GGB4WE/YkmsClpcjrhMUXDNM
         nxwtgXewK7HO14yom57mQV8cmdhDerp8fwMJFGOjeolDTCISa91iqfnCJH1S4/lrQYP4
         AFzw==
X-Gm-Message-State: ANhLgQ1WwYLeu+qK76eQIUdCgB8O2nOY5f0JnyZLd8DkG8MM9qNwqsQw
        rU7RKkViconrfN9E+331Ff7XfA==
X-Google-Smtp-Source: ADFU+vsqKGOOKAANCliEve5DsTemTE6GfKm5d2SpCazLWZA7UFzrJtGoWuyIlbLF5xFcBozXcDu+bA==
X-Received: by 2002:a63:36cd:: with SMTP id d196mr14455218pga.280.1584124615060;
        Fri, 13 Mar 2020 11:36:55 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:5d5d])
        by smtp.gmail.com with ESMTPSA id w27sm8285583pfq.211.2020.03.13.11.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 11:36:54 -0700 (PDT)
Date:   Fri, 13 Mar 2020 11:36:53 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: Remove support for BTRFS_SUBVOL_CREATE_ASYNC
Message-ID: <20200313183653.GB26442@vader>
References: <20200313153143.23613-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313153143.23613-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 13, 2020 at 05:31:43PM +0200, Nikolay Borisov wrote:
> Kernel has removed support for this feature in 5.7 so let's remove
> support from progs as well.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  ioctl.h                  | 4 +---
>  libbtrfsutil/btrfs.h     | 4 +---
>  libbtrfsutil/subvolume.c | 4 ----
>  3 files changed, 2 insertions(+), 10 deletions(-)

We should also update the docs in libbtrfsutil/btrfsutil.h and
libbtrfsutil/python/module.c to note that async_transid/async_ is now
ignored, remove the mentions of asynchronous creation from
libbtrfsutil/README.md, and remove the async_ tests in
libbtrfsutil/python/tests/test_subvolume.py.

> diff --git a/ioctl.h b/ioctl.h
> index d3dfd6375de1..93a19a5789b6 100644
> --- a/ioctl.h
> +++ b/ioctl.h
> @@ -49,14 +49,12 @@ BUILD_ASSERT(sizeof(struct btrfs_ioctl_vol_args) == 4096);
>  
>  #define BTRFS_DEVICE_PATH_NAME_MAX 1024
>  
> -#define BTRFS_SUBVOL_CREATE_ASYNC	(1ULL << 0)
>  #define BTRFS_SUBVOL_RDONLY		(1ULL << 1)
>  #define BTRFS_SUBVOL_QGROUP_INHERIT	(1ULL << 2)
>  #define BTRFS_DEVICE_SPEC_BY_ID		(1ULL << 3)
>  
>  #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
> -			(BTRFS_SUBVOL_CREATE_ASYNC |	\
> -			BTRFS_SUBVOL_RDONLY |		\
> +			(BTRFS_SUBVOL_RDONLY |		\
>  			BTRFS_SUBVOL_QGROUP_INHERIT |	\
>  			BTRFS_DEVICE_SPEC_BY_ID)
>  
> diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
> index 944d50132456..03ac58372104 100644
> --- a/libbtrfsutil/btrfs.h
> +++ b/libbtrfsutil/btrfs.h
> @@ -38,8 +38,7 @@ struct btrfs_ioctl_vol_args {
>  #define BTRFS_DEVICE_SPEC_BY_ID		(1ULL << 3)
>  
>  #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
> -			(BTRFS_SUBVOL_CREATE_ASYNC |	\
> -			BTRFS_SUBVOL_RDONLY |		\
> +			(BTRFS_SUBVOL_RDONLY |		\
>  			BTRFS_SUBVOL_QGROUP_INHERIT |	\
>  			BTRFS_DEVICE_SPEC_BY_ID)
>  
> @@ -101,7 +100,6 @@ struct btrfs_ioctl_qgroup_limit_args {
>   * - BTRFS_IOC_SUBVOL_GETFLAGS
>   * - BTRFS_IOC_SUBVOL_SETFLAGS
>   */
> -#define BTRFS_SUBVOL_CREATE_ASYNC	(1ULL << 0)
>  #define BTRFS_SUBVOL_RDONLY		(1ULL << 1)
>  #define BTRFS_SUBVOL_QGROUP_INHERIT	(1ULL << 2)
>  
> diff --git a/libbtrfsutil/subvolume.c b/libbtrfsutil/subvolume.c
> index 3f8343a245e9..27a6bb8130ed 100644
> --- a/libbtrfsutil/subvolume.c
> +++ b/libbtrfsutil/subvolume.c
> @@ -716,8 +716,6 @@ PUBLIC enum btrfs_util_error btrfs_util_create_subvolume_fd(int parent_fd,
>  		return BTRFS_UTIL_ERROR_INVALID_ARGUMENT;
>  	}
>  
> -	if (async_transid)
> -		args.flags |= BTRFS_SUBVOL_CREATE_ASYNC;
>  	if (qgroup_inherit) {
>  		args.flags |= BTRFS_SUBVOL_QGROUP_INHERIT;
>  		args.qgroup_inherit = (struct btrfs_qgroup_inherit *)qgroup_inherit;
> @@ -1153,8 +1151,6 @@ PUBLIC enum btrfs_util_error btrfs_util_create_snapshot_fd2(int fd,
>  
>  	if (flags & BTRFS_UTIL_CREATE_SNAPSHOT_READ_ONLY)
>  		args.flags |= BTRFS_SUBVOL_RDONLY;
> -	if (async_transid)
> -		args.flags |= BTRFS_SUBVOL_CREATE_ASYNC;
>  	if (qgroup_inherit) {
>  		args.flags |= BTRFS_SUBVOL_QGROUP_INHERIT;
>  		args.qgroup_inherit = (struct btrfs_qgroup_inherit *)qgroup_inherit;

Please remove all of the handling for async_transid from this file.

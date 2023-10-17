Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564357CC539
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Oct 2023 15:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343892AbjJQNye (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 09:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343584AbjJQNyd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 09:54:33 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68301ED
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 06:54:32 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7c7262d5eso72024327b3.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 06:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1697550871; x=1698155671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cy6FOaCUU0ckseasar9yfGgGDiBCGI1o602L1ckHnq0=;
        b=lq44u6ksOAdgek7qrSzRGqe/jQiT/Ecb5O69TZqMb6lYg84kwW2wE+ZyKsmy6W+bKB
         r9cwj6SQIb2b5Bx4b9socQkBWp/dqVDITgpftf4vQ4JKg5ZJcfmsDxxL6vU3M4Egjcns
         4eatxE7KA/pbuRRfDQH48qYH+9Pio87mPViU+PXngT4+RuIXZU211wGdYSWpWQzMSm7d
         w6Mran7N1gEO8hEvqYLl1gG0tfkD+Nwlvntr10+UHxPcm6jZtITJN/+CNcv3msEeLniH
         n6zwxOr3tMygqOeKqzcdJx+6AbOZNjNMPO4T8XDqtrxhjevo4k8XPjHlXRcxlbMlkMC1
         0GMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697550871; x=1698155671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cy6FOaCUU0ckseasar9yfGgGDiBCGI1o602L1ckHnq0=;
        b=DpHNsmOCHagFZMqqV9wRpcGtHIvYAzy+dLPvhPzAK3ULc522e51pE0cA+JuwNU/Ese
         c3W+BLofTgv0hn3Uu/onyQw1i2RiMloY5dNoaZoJSg0zLOvuGBxDieBzOJ2qnoBjb3jF
         nckGCU41JZBM4F/4iPeFs7Up+0VdsYeNQ23hLnGlxMLJHLvhfLkcVSuy+GpESdrP0amc
         Sqew0b6VWNL8+nsj/OWdnlup1qQcHopX1C2hkAsudVh4DWifQWVT6H4bFEQFXk6eR5vd
         /plT+yTf22e+v7jAXC9w6PMFIkWwI5H/wCHRbgKx5vWyTCkYyGm2bvYsUWJnL25mJ73p
         q8qQ==
X-Gm-Message-State: AOJu0Yw0MA04651/2K9erAqS67H5Lj7vY8cKufVRqVkfNh6U/fqO8jJp
        uLTdpvjQhMsCeJbgV9XU2j4EqocnCxqmdD43Sz8dug==
X-Google-Smtp-Source: AGHT+IHi0IpYkXfZN+HD9AATkZJ3vafkohL1sGdm3gfdb6uNLp9VakjN56nSe6oiFLfiFTMRDk+rTw==
X-Received: by 2002:a81:8341:0:b0:5a7:c6bd:7ac0 with SMTP id t62-20020a818341000000b005a7c6bd7ac0mr2775449ywf.13.1697550871513;
        Tue, 17 Oct 2023 06:54:31 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id n189-20020a0de4c6000000b005777a2c356asm623080ywe.65.2023.10.17.06.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 06:54:30 -0700 (PDT)
Date:   Tue, 17 Oct 2023 09:54:30 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 5/6] btrfs-progs: mkfs: introduce experimental --subvol
 option
Message-ID: <20231017135430.GB2350212@perftesting>
References: <cover.1697430866.git.wqu@suse.com>
 <bcb175042cb8b4036f532269235af02e10a69de5.1697430866.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb175042cb8b4036f532269235af02e10a69de5.1697430866.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 16, 2023 at 03:08:51PM +1030, Qu Wenruo wrote:
> Although mkfs.btrfs supports --rootdir to fill the target filesystem, it
> doesn't have the ability to create any subvolume.
> 
> This patch introduce a very basic version of --subvol for mkfs.btrfs,
> the limits are:
> 
> - No co-operation with --rootdir
>   This requires --rootdir to have extra handling for any existing
>   inodes.
>   (Currently --rootdir assumes the fs tree is completely empty)
> 
> - No multiple --subvol options supports
>   This requires us to collect and sort all the paths and start creating
>   subvolumes from the shortest path.
>   Furthermore this requires us to create subvolume under another
>   subvolume.
> 
> For now, this patch focus on the basic checks on the provided subvolume
> path, to wipe out any invalid things like ".." or something like "//////".
> 
> We support something like "//dir1/dir2///subvol///" just like VFS path
> (duplicated '/' would just be ignored).
> 
> Issue: #42
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  mkfs/main.c    |  23 ++++++++
>  mkfs/rootdir.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++
>  mkfs/rootdir.h |   1 +
>  3 files changed, 181 insertions(+)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 42aa68b7ecf4..6bf30b758572 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -434,6 +434,9 @@ static const char * const mkfs_usage[] = {
>  	"Creation:",
>  	OPTLINE("-b|--byte-count SIZE", "set size of each device to SIZE (filesystem size is sum of all device sizes)"),
>  	OPTLINE("-r|--rootdir DIR", "copy files from DIR to the image root directory"),
> +#if EXPERIMENTAL

I assume you're doing EXPERIMENTAL because you want to un-gate it once you
remove all the restrictions?  Thanks,

Josef

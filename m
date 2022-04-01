Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740B24EF77B
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349136AbiDAP5e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241700AbiDAPa7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 11:30:59 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF4F295266
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 08:05:26 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d142so2316762qkc.4
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 08:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RQLsV0SIRztdThAD+ux89YOcicJAc6Igu+MGiwMJ/PI=;
        b=5ItzTpfnNUeFP+bx2+WSbO5+jllVBLdJbrE79cXRU4i0kLYxn93BTr08F5fyGg0XDW
         Caokf+3T7gUN095Cb/9LwJ5pGiXn4aBKzFR6X1Bdikazsa29SUfKleDabsFlZ9gV23iE
         gVyVHKq+t8ZDIrymHMYsYlbczxHyRwBsH4XjtaGxR9dhXIKcp239DIdZEmPnn9oIkfvn
         nW7F4y5aol2E3+qru+5B+wJWGfhXNjAqwLEVo9VIJ0WE8PIzJmsJyRa8pwP7Oz5YdJwO
         zUdLbo07n4sSS7vxARLdS0v1/Iy1WyEjFSbpby/7elNEituDOhgPa4Vn5SMy73jX2VAN
         +J6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RQLsV0SIRztdThAD+ux89YOcicJAc6Igu+MGiwMJ/PI=;
        b=fzdxBN1GRQlQl2JRvJfU3hvRs4ls92+g1qjqMZlnrbE0rlBSzJRr8bNwl7WSQjccxC
         Fn6sthoIkq6DGDqL00vble2uZABqoFHrtzc1JmvNvVolg7fhHZqdU4nv7vtaGRTwlhUv
         7aiTa3w7HNwKGL4F6i0Xlal8+qLClwKeFAsWCLkGGvH6GfOyYO3Q2uO3qp2FfWHVHbMD
         io00zHXhNTALn4SZc3pkQiS6FcNjIvvIDJSrXKyqPHlElokJd7JhD2DbnmDSEbAqWWRQ
         WQC5/vwbe/xUqfVHBzV7dMticUdG6cP34FxmEldDf5I8gf4wstXkOb8mhw07j3r/zCwP
         n+eA==
X-Gm-Message-State: AOAM533LAvHD7w+z6GFBCi5Q6wz4xF0EifFjw154ejQPq7wO7/DoD15t
        YEEcLsH/dvKk6twGCsybWOrbFw==
X-Google-Smtp-Source: ABdhPJwXBnkl8c+vNHrub4dLiH8CWISfkXVXQKR5PdDea/OxUMoJy8nhFgT2b9Dykk6fZ4UOjUEq3A==
X-Received: by 2002:a05:620a:2912:b0:680:9c3d:b806 with SMTP id m18-20020a05620a291200b006809c3db806mr6889012qkp.462.1648825524772;
        Fri, 01 Apr 2022 08:05:24 -0700 (PDT)
Received: from localhost ([204.85.209.207])
        by smtp.gmail.com with ESMTPSA id x12-20020a05620a12ac00b0067d4bfffc59sm1359685qki.118.2022.04.01.08.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 08:05:24 -0700 (PDT)
Date:   Fri, 1 Apr 2022 11:05:23 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Matt Corallo <blnxfsl@bluematt.me>,
        stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: force v2 space cache usage for subpage mount
Message-ID: <YkcUs8ZsUHDj6vYF@localhost.localdomain>
References: <1f622305ee7ecb3b6ec09f878c26ad0446e18311.1648798164.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f622305ee7ecb3b6ec09f878c26ad0446e18311.1648798164.git.wqu@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 01, 2022 at 03:29:37PM +0800, Qu Wenruo wrote:
> [BUG]
> For a 4K sector sized btrfs with v1 cache enabled and only mounted on
> systems with 4K page size, if it's mounted on subpage (64K page size)
> systems, it can cause the following warning on v1 space cache:
> 
>  BTRFS error (device dm-1): csum mismatch on free space cache
>  BTRFS warning (device dm-1): failed to load free space cache for block group 84082688, rebuilding it now
> 
> Although not a big deal, as kernel can rebuild it without problem, such
> warning will bother end users, especially if they want to switch the
> same btrfs seamlessly between different page sized systems.
> 
> [CAUSE]
> V1 free space cache is still using fixed PAGE_SIZE for various bitmap,
> like BITS_PER_BITMAP.
> 
> Such hard-coded PAGE_SIZE usage will cause various mismatch, from v1
> cache size to checksum.
> 
> Thus kernel will always reject v1 cache with a different PAGE_SIZE with
> csum mismatch.
> 
> [FIX]
> Although we should fix v1 cache, it's already going to be marked
> deprecated soon.
> 
> And we have v2 cache based on metadata (which is already fully subpage
> compatible), and it has almost everything superior than v1 cache.
> 
> So just force subpage mount to use v2 cache on mount.
> 
> Reported-by: Matt Corallo <blnxfsl@bluematt.me>
> CC: stable@vger.kernel.org # 5.15+
> Link: https://lore.kernel.org/linux-btrfs/61aa27d1-30fc-c1a9-f0f4-9df544395ec3@bluematt.me/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

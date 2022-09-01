Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7426B5A99B5
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 16:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiIAOGV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 10:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiIAOGU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 10:06:20 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BC929803
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 07:06:19 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a22so10766191qtw.10
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Sep 2022 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=sMCAcUYRQJP1iE12TDrGYyGBQUVeYIHoVh4IUQr0KnQ=;
        b=4azSfFm679CVE8Vv5zq+Iw2T7r/9QzP7FWvN8r6/0kn4NmlMmN7HdrPLWPoCSCtWeg
         1aMzdHFfSrj8B3RnpkxRBhuyxlhCBuSF/hAZvcISirXmNnPrjccYjLr4fejA/IuUz2NF
         5IBT6aCrTe8Y6eo7KHCYQOxW/MpDOE0JIS3afTI6O1aUsSpgZFC0QjOH87oGE+ZrHjUl
         G+soXw/od0FzF89KfkCPzyhoUWn0rRctJTmNrLtPPaWAtRIXsh2M1hZcrn/HbwDs8098
         wMgAfWzwfWiI/hFb4Hz6d9QD93NdKCfovvpSRqgubak1PSUrSsu0wyPanhpotq54xKQf
         irYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=sMCAcUYRQJP1iE12TDrGYyGBQUVeYIHoVh4IUQr0KnQ=;
        b=at2zT1KD5z8fxx5FjmaSzpAWfYQ/YwIyHSWONjY98sUk6G9FW6XffaoU7ZxWdenbiS
         eX9RN7BryNmt1EZJ2qT3nnU7YtnvE2heUT2XGR31TUTpPW/VuN46GOoX3QhLmfYsELTM
         v6Z0p1dKkQ10PWp9HagDjMJHnmmfXfVB70jTevs8WmV/mrFeM35/X4ukyfalsXXnN8sR
         9UYa+DkKuupD+fRlj6XwBIyJdR0y8AcNO4UU5Suv99Uy44IAOmRMEOW97Vi4KoRLGJ74
         IwtrEyA/ghBtF5AEGQRvIc9c5yoeQ44YaTnjWxPTtsoczeQuscKFGHLjBjiNKgohllLR
         orow==
X-Gm-Message-State: ACgBeo2STGfXIBcMsvHyg/bk7jy5alPxYMBMDgtBdSZFdWbPcaVG+T7r
        yyVxu3ZTaqamPABLumefwK2wl4hu6ZX3qg==
X-Google-Smtp-Source: AA6agR4sCmt7E2WWZQU3VVw035+qdH0snRhVQIPq8ejCc6BF0+dQ64UYfjxGGgrxomRytvfNPaDACg==
X-Received: by 2002:a05:622a:181c:b0:344:6399:d8c0 with SMTP id t28-20020a05622a181c00b003446399d8c0mr23704649qtc.334.1662041178899;
        Thu, 01 Sep 2022 07:06:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bp6-20020a05620a458600b006bbda80595asm12123262qkb.5.2022.09.01.07.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:06:18 -0700 (PDT)
Date:   Thu, 1 Sep 2022 10:06:17 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 05/10] btrfs: properly flush delalloc when entering fiemap
Message-ID: <YxC8Wa76TtEPY1o/@localhost.localdomain>
References: <cover.1662022922.git.fdmanana@suse.com>
 <dd926ea5086a8c5d0bd627bb07d8f83eb492a2f6.1662022922.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd926ea5086a8c5d0bd627bb07d8f83eb492a2f6.1662022922.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 02:18:25PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If the flag FIEMAP_FLAG_SYNC is passed to fiemap, it means all delalloc
> should be flushed and writeback complete. We call the generic helper
> fiemap_prep() which does a filemap_write_and_wait() in case that flag is
> given, however that is not enough if we have compression. Because a
> single filemap_fdatawrite_range() only starts compression (in an async
> thread) and therefore returns before the compression is done and writeback
> is started.
> 
> So make btrfs_fiemap(), actually wait for all writeback to start and
> complete if FIEMAP_FLAG_SYNC is set. We start and wait for writeback
> on the whole possible file range, from 0 to LLONG_MAX, because that is
> what the generic code at fiemap_prep() does.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

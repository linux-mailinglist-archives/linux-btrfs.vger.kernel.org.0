Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A90D64BC97
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Dec 2022 20:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiLMTBS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Dec 2022 14:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236108AbiLMTBR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Dec 2022 14:01:17 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412BF23149
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:01:16 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id j16so652609qtv.4
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Dec 2022 11:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0gRl9kKaTcHGIAjyeyyQMnc3TUeghQZlXaoTBDauwQw=;
        b=BTtPinKPsjxv2rScWjp6Eux+A4e4UJGtajBXeUkaKcrDPf/j+8Ax+9EokCZ1Kh1Q++
         RvnHkU70c+hmh+fGW5Q0Bcj+amvdh8e4t2QVD6L/nTupcYcMvLOIhuQIJJ1VAlbqScSN
         3Z90AI2DJ6poD4HYkWqqgnEHTGPU4c57qHvXZACq4fsgrZYZxXdBJrKzs83jKV0q6daz
         M6+pZYM7yJyJt5ndRvpqkCBI+3/Z42us1d67eWAozvpE2W3Yc8sDymKwGtLc1OKSruKZ
         /DKgU4ah5IfBy8T3rO/RsuaeVfQiNXCzhHWEXFN4NByScbkVnuYPFa0UnJuYA/fKvxhj
         qFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gRl9kKaTcHGIAjyeyyQMnc3TUeghQZlXaoTBDauwQw=;
        b=o3nSNtGh7wzaLeiUwPTNpU5iUkDNd+aNv319WL+IEreDU9iaRR4kDj+NlLGU8l2vng
         2V/Jc5t01MmY4aPyq2iQhO9alQWDGXy92wzKXfOieQ7wuh+xgwWd9tLSBvDTSgBtMk2w
         AcYSU9PZJP0ZwwxEdHZECnvzEWUSDFEsRpL6PONWw1/0HV9aN8Da0HH6/BaxjgOzmOJN
         mfT4j9ZNmcMJJ1zY0CwLJfdAu61b+VXb2xGbBntYFhY5y0wmVV7UuJ9hjgf23Sdo5pSH
         6p75SFNk7G7V1E5u8nSruXxenoJm0OdJrWr+AzRL06FyxrRczSnS3+Jb3d5/+AKMfm4o
         JHWw==
X-Gm-Message-State: ANoB5pkArOjqENPVHpE1JRdNlscp18kQl54JCkafbruumoNeih+DRq7S
        3DlGMHSXO9C361Qt/WoMr3VkLQ==
X-Google-Smtp-Source: AA0mqf6xVVNpzOwnHJqxYnOO0gzP53JAiXL+C+fX8pyAGE0laxIpweBzuBeqR25CFtmC14LJVGDHCQ==
X-Received: by 2002:ac8:4983:0:b0:3a5:4a20:3096 with SMTP id f3-20020ac84983000000b003a54a203096mr24053443qtq.6.1670958075149;
        Tue, 13 Dec 2022 11:01:15 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id l11-20020ac848cb000000b003a689a5b177sm353686qtr.8.2022.12.13.11.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:01:14 -0800 (PST)
Date:   Tue, 13 Dec 2022 14:01:13 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 08/16] btrfs: Lock extents before pages for buffered
 write()
Message-ID: <Y5jL+dU/M6pmy1l5@localhost.localdomain>
References: <cover.1668530684.git.rgoldwyn@suse.com>
 <387d15a567d7c56ceb2408783ebe31e431cb537f.1668530684.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <387d15a567d7c56ceb2408783ebe31e431cb537f.1668530684.git.rgoldwyn@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 15, 2022 at 12:00:26PM -0600, Goldwyn Rodrigues wrote:
> While performing writes, lock the extents before locking the pages.
> 
> Ideally, this should be done before  space reservations. However,
> This is performed after check for space because qgroup initiates
> writeback which may cause deadlocks.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

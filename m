Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4383275248B
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 16:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjGMOCH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 10:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjGMOCG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 10:02:06 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD101995
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:02:05 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1b059dd7c0cso650931fac.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689256924; x=1691848924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8t3Sqe3xGIQNTwQEORtGPtbccxqV61guS8EJ/xv76lA=;
        b=QrgGMDgk+kyZ9TuCM00ksnGkWi+PJ2QkV2yCZ44chG+IpaVhOmRHC+noO5A3EklqFi
         1akaaqdY1p17aOptjrFzhaQE/r4DeqDS5REwat/ssMyYGQ+ij1ZLEclKk3c/dqRFxWeN
         sXayaKRxMVShYDvwqny95hBasCSnaZXuXCNOo3BI3j01hNe1S7gxAiUz5miAUd9U+NSx
         svdbq3wxoujkjivSKL1naJuhpI/R/qrA2RSPJPKP2ckeKSOU8MBOjwlsT7ZhY8xtmtpq
         siXZvTO/08zu+cClLvUdQzYDSbxtB8ZABFVhdhJZ2b8Gjyd/NSe4pD8bwJqTFZQQ1MpA
         rVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689256924; x=1691848924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8t3Sqe3xGIQNTwQEORtGPtbccxqV61guS8EJ/xv76lA=;
        b=QWRi5+fElRqyQkKVSPbn0pyk+VE6l92C4DaFwhfrKzzD0f4Tj/kOQd1kMMWeWaORU8
         b1/fAFWTmnFNKpHJvLpkd7JnHnb9C+1JzFAQpCFfOKUufOVvIM5JySxT/vgbSU2Icmns
         LOJA4OV9ISW4u53jVGBi/tCbIK0SHIYJLF1oqh6E7JvUuvSpXk/bcCEW9/xFJ1UFmBy6
         +zzvjKf4y+mVbZLfY0Lv++48BP+7C0pZGoTL+Fu0TwuT5jkAJIYp58uSlO1w5MvXD53b
         yXhLbrDg30Pd90AlccV4RmWFUInfwmZfmcwLh7ZvZLuiaWVGh/lQyEI+yJEOBuIgoWj5
         9J5Q==
X-Gm-Message-State: ABy/qLZxG/iYoc6v8FMSzL95kVfVYuEEjacsfh/2Yr93HDVc0XkvdW5p
        iPqMQqxD+tt4j+Tr1bQXoST40fsIIJWOgbZVFPMwTw==
X-Google-Smtp-Source: APBJJlHebVgOiqTDdr75u0kgH6yv+HomTO328m/HR/uLR3x08Z7FazoaF1y5qYeEX2AhRQhfntyFIg==
X-Received: by 2002:a05:6870:f586:b0:1b0:2de8:f140 with SMTP id eh6-20020a056870f58600b001b02de8f140mr2595365oab.15.1689256924333;
        Thu, 13 Jul 2023 07:02:04 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x201-20020a0dd5d2000000b005768a634f5bsm1760610ywd.99.2023.07.13.07.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:02:03 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:02:02 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 02/18] btrfs: fix start transaction qgroup rsv double free
Message-ID: <20230713140202.GB207541@perftesting>
References: <cover.1688597211.git.boris@bur.io>
 <90d1a33e3722d5533a8bb595b658aae81d1e6c21.1688597211.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90d1a33e3722d5533a8bb595b658aae81d1e6c21.1688597211.git.boris@bur.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 05, 2023 at 04:20:39PM -0700, Boris Burkov wrote:
> btrfs_start_transaction reserves metadata space of the PERTRANS type
> before it identifies a transaction to start/join. This allows flushing
> when reserving that space without a deadlock. However, it results in a
> race which temporarily breaks qgroup rsv accounting.
> 
> T1                                              T2
> start_transaction
> do_stuff
>                                             start_transaction
>                                                 qgroup_reserve_meta_pertrans
> commit_transaction
>     qgroup_free_meta_all_pertrans
>                                             hit an error starting txn
>                                             goto reserve_fail
>                                             qgroup_free_meta_pertrans (already freed!)
> 
> The basic issue is that there is nothing preventing another commit from
> committing before start_transaction finishes (in fact sometimes we
> intentionally wait for it..) so any error path that frees the reserve is
> at risk of this race.
> 
> While this exact space was getting freed anyway, and it's not a huge
> deal to double free it (just a warning, the free code catches this), it
> can result in incorrectly freeing some other pertrans reservation in
> this same reservation, which could then lead to spuriously granting
> reservations we might not have the space for. Therefore, I do believe it
> is worth fixing.
> 
> To fix it, use the existing prealloc->pertrans conversion mechanism.
> When we first reserve the space, we reserve prealloc space and only when
> we are sure we have a transaction do we convert it to pertrans. This way
> any racing commits do not blow away our reservation, but we still get a
> pertrans reservation that is freed when _this_ transaction gets committed.
> 
> This issue can be reproduced by running generic/269 with either qgroups
> or squotas enabled via mkfs on the scratch device.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

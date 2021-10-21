Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4811F436115
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 14:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhJUMLR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 08:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhJUMLQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 08:11:16 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7FFC06161C
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 05:09:01 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id i1so219476qtr.6
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 05:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iYV5+S8GCypJCRo6lOTdOe6JJJCQaxonClrCPF8H2/Q=;
        b=UhgncykvM1hpVN4KIroq4VOEyVdk0wfsckEFX6ENNP9vyn1rp3H9mPoWu4rLi6jDXz
         ki29jckkchK3UPfH8udfLwni2sMghcEni6owPrAVsdHmTVabBoqxYZ7if6v1K1RIQ+vU
         +ND6pLL7FltoEWbqmw3HiRR2xfotg9fhhX2STvUI+onRPphIn6OqSgyJpKCSGREkNOQr
         4NEakbR3MGFxOfWXn1Xx+NhjEcUuI9nCyu7wCo7kWcFd/voYjS1fDrl6a29UTAtBPhVJ
         fHqcKdaz18r/Iq+QL6Xho+uM2VYFcXS3A7wNnokC0FIGZOJsP14oAnuNcMZFF4qr+44q
         IfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iYV5+S8GCypJCRo6lOTdOe6JJJCQaxonClrCPF8H2/Q=;
        b=t7ooI6oyV90m796UAnCcaPfcuQTw0uG6GZfIwD01DpflFlpHrv+NdX3sUo0EfHKAQS
         ph8oqO98m0egwyYgDTQhLHrElqXCL9y0WW8+EmpwCQ5397uIbp8QdQ9V9BaJWRvtEuwV
         4sRWAinnhtVrn+JsOQtzo0g41mA2YQIxthRsfX2ZcG+OBrkOEE5dZruCU7VBsNDjAgWA
         RdrKarI7UT94u68xms9gI58YoA03pL/o6rXv79906DYTwTxvr+TDUknL1FVEVnGhJVAH
         cD78gajOHZpmP9EW5y9NNg+lC/gUSfwC9euJvKbxRRqWG/Q5pDt8mBH66sorhRZ28uZK
         7RVQ==
X-Gm-Message-State: AOAM530HoUZKVeyAyXRirAPSogjYiUKKv3WtSG/2s1JuPfNn30BodO3k
        acJssdxqv5coq2k0N4yp604y3w==
X-Google-Smtp-Source: ABdhPJyahtqPBjOHKt389eM3l/vZ9IemcnDiHBav9dpA4UNTyMsl6DGAfomTHPGVOuj84MPSolcmIg==
X-Received: by 2002:ac8:5f4f:: with SMTP id y15mr5291976qta.326.1634818140161;
        Thu, 21 Oct 2021 05:09:00 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g12sm2546977qtb.3.2021.10.21.05.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 05:08:59 -0700 (PDT)
Date:   Thu, 21 Oct 2021 08:08:58 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: make sizeof(struct btrfs_super_block) to match
 BTRFS_SUPER_INFO_SIZE
Message-ID: <YXFYWmMghbR0gMrC@localhost.localdomain>
References: <20211020234447.5578-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020234447.5578-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 21, 2021 at 07:44:47AM +0800, Qu Wenruo wrote:
> It's a common practice to avoid use sizeof(struct btrfs_super_block)
> (3531), but to use BTRFS_SUPER_INFO_SIZE (4096).
> 
> The problem is that, sizeof(struct btrfs_super_block) doesn't match
> BTRFS_SUPER_INFO_SIZE from the very beginning.
> 
> Furthermore, for all call sites except selftest, we always allocate
> BTRFS_SUPER_INFO_SIZE space for btrfs super block, there isn't any real
> reason to use the smaller value, and it doesn't really save any space.
> 
> So let's get rid of such confusing behavior, and unify those two values.
> 
> This modification also adds a new static_assert() to verify the size,
> and moves the BTRFS_SUPER_INFO_* macros to the definition of
> btrfs_super_block for the static_assert().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

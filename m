Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1264D3E07
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 01:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiCJAVX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 19:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiCJAVW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 19:21:22 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6F9123BD4
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 16:20:23 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id t2so982145pfj.10
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 16:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DxoylUu2jtdoMtY2Rsg9cLmkzcY9HkMxrJPMrlcsmZc=;
        b=Vo37YtoY0yotMFQU3ZxDGQWhJEO9jNLC3U+DO8QWYpq9RsS34u/kZjWjyc/M32OM1C
         ddpBvyNd2ZBPMuhyJM01SjT6H1K7ML8YCKHlpA5n4tlQ3IF2lwKBNJAPmWP9AC66W2NN
         EVzNUmVuCfs+yNEuVWl5a7w7dcKL6vo1fQwaOYrIl0b4Z4h7+8yLNDu8mMKpT8NRdJyX
         pY0KxIzMihPKJCQ62DG/OjL2eqrmsaRbJC4eEXYwgnjQkLyp59s6RWus5KcYCJTsnoqK
         OSP7Prf+zl3q3vzdrbV2p9WS8yg4/mHC44W0JWLBZrczrH5e4eVM5JVYLaWatZc1Zr6O
         t0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DxoylUu2jtdoMtY2Rsg9cLmkzcY9HkMxrJPMrlcsmZc=;
        b=lJS3Ybn7k197jE45WMj9zzDyOB2ZA4C/4phe9mSLlXdpdmwGXcPFTz0taNufLliTAv
         k7mzXDpK/BEJhe3GkXCGWyc25sILP93T8xHueTJvApZ3Y7QpwbOBW3HaPh09apZ5UOmB
         p8UzcAIqQS0REZCaSPCHujVJEcs2CpY2y6XGcEC67fr7WLqBfkfvXyPAB2OAYsFIod4J
         j5JbkwLHYbYZ6neTSO2ac+GxdJhoDdOu5k919EhBi+p0hj8WCdPwSPxBX8yFYh2g2rhl
         Zzkd5z3ax+xZoPvQr36/azfLZxR5TvbuACIXJrYp6IdVYDYrJ74i5M2RkWmusk5/eMoY
         bc5Q==
X-Gm-Message-State: AOAM531W3/9ZnG53crezF3QJGk3qpz4jH4GB30j8RMWxBp+ijwg/e+a1
        6Vu9HNbJvbRlkbYXySapLu84f6zVJmgXtg==
X-Google-Smtp-Source: ABdhPJwmbGHAZQlOh8i7VSs5cmMov5PgkrE9FXSjHLtXmL8BdT8jwkcCI3oaknhhtWvaFoiIQC768w==
X-Received: by 2002:a05:6a00:16d3:b0:4cb:51e2:1923 with SMTP id l19-20020a056a0016d300b004cb51e21923mr2077824pfc.7.1646871622809;
        Wed, 09 Mar 2022 16:20:22 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:8b4])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00245000b004f7728a4346sm384072pfj.79.2022.03.09.16.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 16:20:22 -0800 (PST)
Date:   Wed, 9 Mar 2022 16:20:21 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 12/12] btrfs: rework inode creation to fix several issues
Message-ID: <YilERfTblg+9XgbA@relinquished.localdomain>
References: <cover.1646348486.git.osandov@fb.com>
 <c7edee49c1935f66c07c5c2c1aa98a599e4a11ad.1646348486.git.osandov@fb.com>
 <20f632c6-f263-40d9-3c56-9ebfa59b51c7@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20f632c6-f263-40d9-3c56-9ebfa59b51c7@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 07, 2022 at 08:25:01AM -0500, Sweet Tea Dorminy wrote:
> I like the changes overall. However, I was hoping:
> 
> a) would it be possible to just refactor to use btrfs_new_inode_prepare()
> first and then fixup the non-refactoring parts?

Yup, I managed to split that part out.

> b) the naming is a bit confusing to me: I don't usually think of ..free() as
> the inverse action of ...prepare(). Also, ...free() feels weird to be taking
> a stack pointer. Perhaps _{init,uninit}() or _{prepare,destroy}() might be a
> clearer set of names?

I like the _{prepare,destroy}() naming, I'll go with that.

Thanks!

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2E926BFB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 10:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgIPIsi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 04:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgIPIse (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 04:48:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04A8C061788;
        Wed, 16 Sep 2020 01:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zkDLxhq3ExbTfk+r0z7F7YPIpcLsGT2h6q/f53LrBqs=; b=VjiIW+S5mYOvePRcTHr4e0bMdB
        OLQbwGWcZtEdJnipfq7KzYukg8H9VIOSqJOzfugbyS0+zSsfVWbugK2CLBiWgsmC2eb4CdDjRdP0H
        qMvKcY3Ux9RDoB5mcDoTghSETFAa4XSGEQBsqeKY3nNBnbGrhvS2I9hAG7ixso0JLWasO4LTZ9vyj
        eZIr8JXKaiKifRCpYTOGMwPRbNnhyiPTvAYFd+nw/Om5lfitGBODfDQfCongaJYE82F0gWXbxIBm+
        x/vFfRA8jXtyjYexrp4cIpmwzL0igff2VQxwnT+3HuMg+RiHtmwozUfnR36iGMQawK2hicLsxqPSy
        0M/u3qjQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIT77-0008Ib-JM; Wed, 16 Sep 2020 08:48:29 +0000
Date:   Wed, 16 Sep 2020 09:48:29 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Terrell <nickrterrell@gmail.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
        squashfs-devel@lists.sourceforge.net,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Petr Malat <oss@malat.biz>, Johannes Weiner <jweiner@fb.com>,
        Niket Agarwal <niketa@fb.com>, Yann Collet <cyan@fb.com>
Subject: Re: [PATCH 1/9] lib: zstd: Add zstd compatibility wrapper
Message-ID: <20200916084829.GA31608@infradead.org>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
 <20200916034307.2092020-2-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916034307.2092020-2-nickrterrell@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 15, 2020 at 08:42:54PM -0700, Nick Terrell wrote:
> From: Nick Terrell <terrelln@fb.com>
> 
> Adds zstd_compat.h which provides the necessary functions from the
> current zstd.h API. It is only active for zstd versions 1.4.6 and newer.
> That means it is disabled currently, but will become active when a later
> patch in this series updates the zstd library in the kernel to 1.4.6.
> 
> This header allows the zstd upgrade to 1.4.6 without changing any
> callers, since they all include zstd through the compatibility wrapper.
> Later patches in this series transition each caller away from the
> compatibility wrapper. After all the callers have been transitioned away
> from the compatibility wrapper, the final patch in this series deletes
> it.

Please just add wrappes to the main header instead of causing all
this churn.

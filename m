Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A50926BFB8
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 10:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgIPItM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 04:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgIPItL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 04:49:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BA7C06174A;
        Wed, 16 Sep 2020 01:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yFjrMsePDJlQkzG4d2Vn8z/692IKzJ049uA8PvEMcO4=; b=Ncdb8mKIyo2jzNf/4eaE4LnpE4
        vFj38ShjIXOy8kyLU7yoLOGb+kFF78Rsm0VwpmpGVyTX3s306CGrpGaxuvnR2qMJRP/c+7onbjD2o
        xlf88CQo90s+kNfDXNdGx9DpBk2YXjtyBEKR057ZhUmbPSKKoohMzOxPdp7lOD776J/L8ar5x3vPr
        tCur5rOtVXOE1W9N7ysn155eEtqs8hrBxog4BoZUqAD++P78ZzqZzJWUKHLBbQ7CHtoPIBSnVqexZ
        2weYDIUQokHvqdlyaP1xT/gi4Ao0WZ/BebOnYeahK2Pb4/KNNOKj97cffPeG/WKbGYSFx+5AdAQky
        jzrMrnIw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIT7l-0008Lu-46; Wed, 16 Sep 2020 08:49:09 +0000
Date:   Wed, 16 Sep 2020 09:49:09 +0100
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
Subject: Re: [PATCH 4/9] crypto: zstd: Switch to zstd-1.4.6 API
Message-ID: <20200916084909.GB31608@infradead.org>
References: <20200916034307.2092020-1-nickrterrell@gmail.com>
 <20200916034307.2092020-5-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916034307.2092020-5-nickrterrell@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> +	const size_t wksp_size = ZSTD_estimateCCtxSize(ZSTD_DEF_LEVEL);
> +
> +	if (ZSTD_isError(wksp_size)) {
> +		ret = -EINVAL;
> +		goto out_free;
> +	}

Pleas switch to properly named functions when you touch this.

The API names here look like a cat threw up on the keyboard.

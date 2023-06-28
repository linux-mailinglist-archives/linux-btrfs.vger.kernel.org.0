Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6A5740A34
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 10:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjF1IAk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 04:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjF1H5p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 03:57:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2157B30D5
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 00:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZLR/TKD2sHw9+Crz3YujK7tw6Cb61k/mF2tmt9jOO4w=; b=dc/4KFGbinq41GlQ7BBsgbtyYL
        vloRJAaOGL/ltVnY8+iRmMpDHejD4wAru5oBrcvHzxTNnQpPVcv0SKcbOTn3IKUb/Uad4ZNkDueM5
        ATyYFNX0+tggrSVQtTydT+cId5d4J+8Em9m2CqXb7QWiav+mfm2t+9w7zkV3QikmG2GOTXqnB8Pfe
        ocaTbjqN9hq8ZlBVuinbXLsywZHdxwoQscDczLOJqJPcBffEhK9eQZsgd9Dp3oEgse8CaLcyNDT1V
        /7yEpETrqyao9E/KJHX0I+Df2dlVi597y8VrlbFSfaKXizqv1aBP/6yvZUymQA/bAjilFuaQ/a2Wh
        wvinetuA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qENMO-00EqND-1v;
        Wed, 28 Jun 2023 05:04:56 +0000
Date:   Tue, 27 Jun 2023 22:04:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: do not enable async discard
Message-ID: <ZJu/eL8jn7i0nFEu@infradead.org>
References: <87c887259bfb49878be9990f4dd559ee90d273ec.1687913519.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87c887259bfb49878be9990f4dd559ee90d273ec.1687913519.git.naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 28, 2023 at 09:53:25AM +0900, Naohiro Aota wrote:
> The zoned mode need to reset a zone before using it. We rely on btrfs's
> original discard functionality (discarding unused block group range) to do
> the resetting.
> 
> While the commit 63a7cb130718 ("btrfs: auto enable discard=async when
> possible") made the discard done in an async manner, a zoned reset do not
> need to be async, as it is fast enough.
> 
> Even worth, delaying zone rests prevents using those zones again. So, let's
> disable async discard on the zoned mode.

Agreed.  But I find some of the logic here rather confusing.  Is there
a chance we could just decouple the ZONE_RESET logic from looking at
the discard options as they are a very fundamental part of the zoned
model and thus we should not rely on otherwise optional mount options?

> +	if (btrfs_test_opt(info, DISCARD_ASYNC)) {
> +		btrfs_err(info, "zoned: async discard not supported");
> +		return -EINVAL;
> +	}

I'd probably only warn about ignoring the option here and clear it
as users might have the option in their fstab by now and you'd
break mounting the file system and thus potentially booting entirely.


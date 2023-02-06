Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5905068B5B9
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 07:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjBFGoQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 01:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBFGoP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 01:44:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD16612F3E
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 22:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Kbq/hBmQcsG1Ou0TUzmDUgNXTe411++1FiHXGLNRNn0=; b=ZCR4BJnkp6a+YazgURlUP7DGWU
        4BClnZS3Z+UA+90jN2uOUjQz6oM+EDF0S2ZFA6dZSOB2huIGBBANVdv1r/DNU2P6FAoStJRieAQ4U
        4s1jNnmK13glAvKZk99jWowgp1x/rVpHPk1iEiKUGpbSQgpZ+k+jGGiDS4qCQxVhpdhSFNiGjsIsU
        EyiUuDpT6aINheeC1A3r7R51oYxssBfa3lQDDmIE86288Uv6I2gP9/pl2sZxnR1eebTwkjthbE3jK
        KFvQ/iM3SHeNoA6LVGX+fV4SPhvwV15huyHq8wdjg/nnuK4A6ON9nQQYptpFff61wf3g9XMStXBKF
        6n4MONAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOvEc-007Twl-Em; Mon, 06 Feb 2023 06:44:14 +0000
Date:   Sun, 5 Feb 2023 22:44:14 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: reduce div64 calls by limiting the number of
 stripes of a chunk to u32
Message-ID: <Y+ChvlcfOGHB7gd0@infradead.org>
References: <cover.1675586554.git.wqu@suse.com>
 <275da997c70615256bed3cff8e74ab2b3fecbafc.1675586554.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <275da997c70615256bed3cff8e74ab2b3fecbafc.1675586554.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> +	if (unlikely(((u64)U32_MAX << BTRFS_STRIPE_LEN_SHIFT) <= length)) {

Nit, at least to me this order reads weird and I had to stop and think
a while.   This version:

	if (unlikely(length >= ((u64)U32_MAX << BTRFS_STRIPE_LEN_SHIFT))) {

would be more obvious.

> @@ -6344,7 +6345,7 @@ int btrfs_get_io_geometry(struct btrfs_fs_info *fs_info, struct extent_map *em,
>  
>  	io_geom->len = len;
>  	io_geom->offset = offset;
> -	io_geom->stripe_len = stripe_len;
> +	io_geom->stripe_len = BTRFS_STRIPE_LEN;

This conflicts with the bio split series that has been in for-next
for a few weeks (but not in misc-next yet).

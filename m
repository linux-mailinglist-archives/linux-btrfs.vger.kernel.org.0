Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF8D76AA57
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 09:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjHAHza (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 03:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbjHAHz3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 03:55:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30C01BF0
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 00:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mbOeqjCeOLwC1zzscrGVBi9JXqYh1DKhi+UctQQQtqg=; b=XLif940ugLlU/jj9KxqBwHe63m
        mzR7l4wHfHTmfnsYER69Bon6Tyv1a9N8jKCXG7u34dRgNWanWcQZ43awiN3WtcOkuQObO52Gxo4El
        pyoRK9VGO7a2j3A9LyUVvDvyl2ij8eGoNdhSF4ujcvizKFrgFgEb5Klq/8ur/HA0XrDMpcw6E1LZM
        op4rJSohEWONdvcZFx2fwCsAcYd+rCHvUKVIm+SlBFN1oKel4kPh7GKbEFt21YnX2o20IVaySINgb
        hFherswAUXJVrAKG49hKtKADq9HXR/geOb7Ez0YOj/XldPvlXIhCjRwMu2iV8MyAgUkTG7LK3sc6c
        O4P3uCVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQkE2-000awp-28;
        Tue, 01 Aug 2023 07:55:26 +0000
Date:   Tue, 1 Aug 2023 00:55:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org,
        josef@toxicpanda.com, dsterba@suse.cz
Subject: Re: [PATCH v2 02/10] btrfs: zoned: introduce block_group context to
 btrfs_eb_write_context
Message-ID: <ZMi6bhTOP1Bmdw2A@infradead.org>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
 <31cfb11cd71edc3513f0d65d1da6a2b6d3b959e7.1690823282.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31cfb11cd71edc3513f0d65d1da6a2b6d3b959e7.1690823282.git.naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

>  	struct btrfs_eb_write_context ctx = {
>  		.wbc = wbc,
>  		.eb = NULL,
> +		.block_group = NULL,

Same comment as for the last patch.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

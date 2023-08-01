Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E256976AA51
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Aug 2023 09:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjHAHxM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Aug 2023 03:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjHAHxL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Aug 2023 03:53:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E52D3
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Aug 2023 00:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G6zUJw5hj0HCGluUha3R6TE6nsAx6vUgtTzQzk2zJ6U=; b=dgn+f2VwKSKin5RtilLNbvMOQF
        YoMVxWVuD/kyS4JoMz7P8TGfvD6ZiVscUkiGHIexP3zhKDwEZrJAFzkSM4440lrivwIx0m9HvGUpc
        4dFpgCy9m7Put5633+vaPdAmGFvjt1PsX8pGt3qmAD8CZyYhqV0A6+ibjtT0HGiV59ju3Nm7wD38L
        eAxdScDWTgyhe3Cv2f+aCUhQD4+erh2VxztWBw9ZjuV6KyMvkTP/Srg7IymMSiCg5kxLaHPQnCB/n
        lTMA4SomSTlGMgb2JUlsN5nkuOHtGQOIpDfCbbqTUZiReK7AZD8kOucDxqgGT2ZgNGXqTBy2VSh2W
        kJNYkRtA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQkBq-000ahA-0F;
        Tue, 01 Aug 2023 07:53:10 +0000
Date:   Tue, 1 Aug 2023 00:53:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, hch@infradead.org,
        josef@toxicpanda.com, dsterba@suse.cz
Subject: Re: [PATCH v2 01/10] btrfs: introduce struct to consolidate extent
 buffer write context
Message-ID: <ZMi55lL1r7G1ebMt@infradead.org>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
 <1cc8f3a21680d196751171f09ddb77b9c14a5b9a.1690823282.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cc8f3a21680d196751171f09ddb77b9c14a5b9a.1690823282.git.naohiro.aota@wdc.com>
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

> +	struct btrfs_eb_write_context ctx = {
> +		.wbc = wbc,
> +		.eb = NULL,

You can drop the eb initilization here, as all not named fiels are
implicitly zeroed.

With that:

Reviewed-by: Christoph Hellwig <hch@lst.de>

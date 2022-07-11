Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC7656D50E
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jul 2022 09:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiGKHAW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jul 2022 03:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGKHAV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jul 2022 03:00:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8EF140F5;
        Mon, 11 Jul 2022 00:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=1cevLNLxQe8lDC09kuEaNwAUu4
        R/6N/NuRdQn5UQHWMazfvsTe9CDKQuvtk0m9mLhIdPAqY1MVje1SrUFH+6bGKfE2TjZcCw8vrNgwX
        iyE2C1AcJCZkfZ3st8xwe8uRGzhPrvRdhs0iXXrwKdFaTRSN8Twd/oz58kyY2lKFLQaecfNDClRqJ
        2BAvN6iTGUwbOIY98yG6jl20XRjntCQTnSO/HeEl+IK/5QIlCNwk7C2bhtLq6zOQdWbBKjV019fGC
        TIn3LyLpqixRsFU1MiYIBe5TtdwesX5tDwl2BwHqoiVt09uO6C8T8QEP0CyJLqYU5Plt8kBfsLFP6
        2KlVIjwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oAnP1-00GZDb-GH; Mon, 11 Jul 2022 07:00:19 +0000
Date:   Mon, 11 Jul 2022 00:00:19 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 01/13] block: add bdev_max_segments() helper
Message-ID: <YsvKg96VEXj61bpU@infradead.org>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
 <b4401816e33a90b1f05a1e32b420f073a8438591.1657321126.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4401816e33a90b1f05a1e32b420f073a8438591.1657321126.git.naohiro.aota@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

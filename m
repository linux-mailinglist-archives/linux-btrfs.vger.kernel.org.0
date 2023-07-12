Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C759750E6E
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 18:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjGLQZS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 12:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjGLQY7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 12:24:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FB2E69
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 09:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Ha6uNzO2BJeuyLW1F0CiSB7d/C
        y3pjXuNwqej4j0w5mOt5JZa035oihrfy7DtmJSx7PT2pgCyQD0cPB8qjcBjQzqmqKC8utl5xLY1mf
        plSqY4OlRvsiErXZuFvaElblC7XYKAJQy0TeulgGRtiIOB6YQuedhLWxquKajifgs282RYHqAROYY
        Ff/l3QABaHuz6bwykBQvzyVWrQPnROcPBz99b5kYTtjGLq5/n443vyo+5KuUMEM6aV2rWR3uNju3h
        udU2VYVUR8i/ldC6LDz7R2hF0MbvYWipYPV2rfqOoJeKYIDt8WPYnTmKq62eYTXS26iZ6h8PDQ5aU
        dNpeDvtQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJce0-000ZgI-2i;
        Wed, 12 Jul 2023 16:24:48 +0000
Date:   Wed, 12 Jul 2023 09:24:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/14] btrfs: raid56: allow scrub operation to update
 both P and Q stripes
Message-ID: <ZK7T0CeUhedtsTai@infradead.org>
References: <cover.1688368617.git.wqu@suse.com>
 <af2b86a9089423882813409531e3bcd1d8479b38.1688368617.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af2b86a9089423882813409531e3bcd1d8479b38.1688368617.git.wqu@suse.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

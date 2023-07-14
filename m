Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D3B753DEE
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jul 2023 16:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbjGNOpF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jul 2023 10:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbjGNOpD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jul 2023 10:45:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074F12680
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jul 2023 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=c7chS1a/G0mp+SHb2d4N0BoQ09
        pyvUUd0U6ehColY7ffECtSHoh3x6hEq8dpi3Qp11YSm3tenMeAjkubsEIYHHhS46WCO8A+liP6kdU
        INkXCcUQx7/Hzdgp0U4uKZIXwrwMkg3X48qAKte3vqVjhV/8YjLXTV7H7KaivOKCXAJB1rhgl6jaJ
        Z5lGzSH2z7aqjTBRdXUb127ND6O8hyo2b/sz/Ji9c2yqT3mjPtdRZarFIasE+T1CB1QfYu4UILiM4
        SPRQMRkopBvtpHmG28PAdvhkmCQI/5qKp81aBU7yEWNls2pL+xINkbxGlSEEP5fYxRJIzVL361hu6
        o2E/xcGg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qKK2Y-006Qdw-25;
        Fri, 14 Jul 2023 14:45:02 +0000
Date:   Fri, 14 Jul 2023 07:45:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: use helper sizeof_field in struct accessors
Message-ID: <ZLFfbpwSoOQK7dpT@infradead.org>
References: <cover.1689257327.git.dsterba@suse.com>
 <5922093fedaf0c9225188b3502b6bbc46f367930.1689257327.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5922093fedaf0c9225188b3502b6bbc46f367930.1689257327.git.dsterba@suse.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


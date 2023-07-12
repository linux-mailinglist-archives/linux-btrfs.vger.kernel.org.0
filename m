Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279F2750E66
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jul 2023 18:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjGLQYj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jul 2023 12:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjGLQYG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jul 2023 12:24:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150E01FCA
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jul 2023 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=giV1Wc0QrLW07o7I76cxxxIimm
        T6dDmQGJp0X0K+Pb8XiiOtOoo6PiZL0nNO2Ix/nRP45hRZCd/p5W6J0WM42RCZGZusHWALHD9fdZc
        sgtSSzbTie0MZPRJFHdshLgUypC3KyehSqVmkEGaBpFVS6JZIIVUuT8h2Hlex8qW1ho8lUQSLNL3Z
        iPiBblCnstmFCLbQj8n3/+xNPmYpGPxKoiH6TX67paKeV/mrIM4SSchxQB3s/B239zQKH0e8aE4lv
        6HMtqM4TPV7qh06SfIYbH1cTvXCvduJ3Sbg9w3Kb3Fgjiw1luTym8PjV0W2S5yAsXKacc2eFJ0tVw
        G2di0GGw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qJccu-000ZTX-2Y;
        Wed, 12 Jul 2023 16:23:40 +0000
Date:   Wed, 12 Jul 2023 09:23:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/14] btrfs: raid56: remove unnecessary parameter for
 raid56_parity_alloc_scrub_rbio()
Message-ID: <ZK7TjGpSAH+Xruyi@infradead.org>
References: <cover.1688368617.git.wqu@suse.com>
 <1f848dbf2089ca42a3c17e2f361e7aabe3e91507.1688368617.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f848dbf2089ca42a3c17e2f361e7aabe3e91507.1688368617.git.wqu@suse.com>
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

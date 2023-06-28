Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79391740C26
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jun 2023 11:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjF1I71 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jun 2023 04:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbjF1Ipr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jun 2023 04:45:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1934B113
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Jun 2023 01:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=I2tQThRZCO32ejQIEVnFe3EIwx
        +jRBxoXQvVofSJYOPe0HdAO+xs5Gt5S9JVFse/0xuOsKdhk6ICzzqNrhihSpVTg2l3ZPB5xrD8Dyo
        Ej4023GMpsss+DyrAIS+Yz82SXa80wmqFBP2SzWZ+gKW6WxDgoJf9PM7k9SKcoG8Q2h2GhbTccZhn
        jZAuOKDtsE0bFbf8LXa3F3j4ru3SUw8hbKBf8SPo2azxT6eaLaa1gmZSAzUSz24TgOEEEFF6Guuaq
        0hbEBhxAhOfk459AM3W5Sl5noHHD7xkoO0Yui8AluJooBCJXQs56y4OM3oOcj2xe96GHL2UL65/Vd
        1kZuskMQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qEQfr-00FB3J-2r;
        Wed, 28 Jun 2023 08:37:15 +0000
Date:   Wed, 28 Jun 2023 01:37:15 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: avoid duplicated chunk lookup during
 btrfs_map_block()
Message-ID: <ZJvxO8QID8JLK1m8@infradead.org>
References: <39b29e7b3b11bf19eb5ac4ce3276c6e218b59e21.1687927850.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b29e7b3b11bf19eb5ac4ce3276c6e218b59e21.1687927850.git.wqu@suse.com>
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

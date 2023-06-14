Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1EA72F538
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jun 2023 08:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242499AbjFNGxV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jun 2023 02:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242435AbjFNGxS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jun 2023 02:53:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6BD1985
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 23:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=iczwZBjscpfkMJEh3xtHVbiGU1
        Ei/iUGOOtE081hZ0f8xFS3kvSxqSaSJNkzeaRgekGTqYS+AWxKZ3S2wFyYLzq2WIKJkrd/ayv6ZaV
        QB5UcszdNSSeo9aju0na7chV7lRkc5zA342Rl1FkPpczbr4la+SJetNTMB7ZeE227Vk918q3NUcgx
        E/YnH45Fk1Q8GNmKx34iMgehnVzYOjd3L/GF06p6lEa3fhGOtHaAD96xQyYewo/QB7MRKqPLy9WCS
        awUH7el2jNLK5/DPselOpaxqEYat3WOMEgnT2MEZktwwgf289camXgWDNwyxDD3Fa2q909oG5Uym4
        Yt8DLFRA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9KNZ-00AXGm-1T;
        Wed, 14 Jun 2023 06:53:17 +0000
Date:   Tue, 13 Jun 2023 23:53:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: fix a return value overwrite in
 scrub_stripe()
Message-ID: <ZIlj3egV3KqEdbTY@infradead.org>
References: <846cb6c0ad0ba87026f2d0b1ac3dfc4e1ddde21c.1686725373.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <846cb6c0ad0ba87026f2d0b1ac3dfc4e1ddde21c.1686725373.git.wqu@suse.com>
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

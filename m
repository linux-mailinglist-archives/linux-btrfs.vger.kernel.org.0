Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AA26958AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 06:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBNFvR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Feb 2023 00:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjBNFvP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Feb 2023 00:51:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4335518152
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 21:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y9vFFyKO8up2zILORX2Yli/zIFSzzWR+iUHA+Mb+MP4=; b=CKXa2Ju/EFjyj0jxcCxxQ5vzbS
        zDZzvV+4TYzB5HcM41uZf2U34Do1x78xzmwBgZSLatjfN4WBIDQ0hCW/wBm+eCj4vvU1mHWt9nb61
        KDN4XYHHBrJF59E4A54LISFcqycv+FPNWJDZzO6UGh+GrTWdz8D5TAq6MOOgRZQhL0hHXe+PtvXJr
        kq+ODHD4cg3zjbadgcWyRuWvY5jG6PqXu0jg8jLuTRxuObqX22OF0M812rpKToj5Z/F4wTq+ulk4Z
        BoifHyxYvb9qclesJ0SKqGFjnLC+koAkKh9lPK1INlS2w9IpTUJCg0L0i+vIdFkeJ0pCczCu8gBSi
        fdWFeiNw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRoDb-00Ha8U-TE; Tue, 14 Feb 2023 05:51:07 +0000
Date:   Mon, 13 Feb 2023 21:51:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Phillip Susi <phill@thesusis.net>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v5 00/13] btrfs: introduce RAID stripe tree
Message-ID: <Y+shS59nCm/trlp8@infradead.org>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <874jrun7zl.fsf@vps.thesusis.net>
 <bee7c8f2-4500-2458-ff40-782a54ae1c17@wdc.com>
 <873579y0kr.fsf@vps.thesusis.net>
 <6564fc09-3dcb-4224-d4d9-0a20a37efd64@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6564fc09-3dcb-4224-d4d9-0a20a37efd64@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 13, 2023 at 05:44:38PM +0000, Johannes Thumshirn wrote:
> I unfortunately can't remember the exact reasons why the block layer
> cannot be made in a way that it can't re-order the IO. I'd have to defer
> that question to Christoph.

That block layer can avoid reordering, but it's very costly and limits
you to a single queue instead of the multiple queues that blk-mq has.

Similarly the protocol and device can reorder or more typically just
not preserve order (e.g. multiple queues, multiple connections, error
handling).


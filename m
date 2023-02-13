Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B5A693E80
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 07:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBMGue (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 01:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBMGud (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 01:50:33 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6258486A9
        for <linux-btrfs@vger.kernel.org>; Sun, 12 Feb 2023 22:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JIx1AXrkBD6Qpqbja8QduT7ovSu4bLJZceghjJalhrE=; b=3qywWXDSkYdNt407T9iZKtwJxo
        CHWepuB8OBzdXz9F5GDiL3EH7HEb57F+twA+TXby9U2PEc6c4NwY7pdAMz1JoIedLKJIiCQJcIJRk
        Rkao3sO1EEdxS6Bg9fcjQ96flrmOn50zh/Y1Gh9W8iV+6OTpmzdScahUK/3ScbM6gF6+7nogViL/1
        eVx+qWuNYQeZRLsgUfKiJs+c393Ym557vgyZL0i3rUPHEiFRQ9k5Gqczy0gAFk9d8FOxWp3zEY+UZ
        v8oyBLj9byvPWfpEea22Y/BTf6hOQuofSGfKDVHdFC7VJE+ca2cG9QjasNcmA4W5aSYkRhePbHm/t
        sW/Oa6ZQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRSfW-00DO3S-Uk; Mon, 13 Feb 2023 06:50:30 +0000
Date:   Sun, 12 Feb 2023 22:50:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v5 02/13] btrfs: add raid stripe tree definitions
Message-ID: <Y+ndtmQuRsLLm7Ke@infradead.org>
References: <cover.1675853489.git.johannes.thumshirn@wdc.com>
 <c9979f47d503ce623e9e8b8d1fb32188844c1990.1675853489.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9979f47d503ce623e9e8b8d1fb32188844c1990.1675853489.git.johannes.thumshirn@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 08, 2023 at 02:57:39AM -0800, Johannes Thumshirn wrote:
> Add definitions for the raid stripe tree. This tree will hold information
> about the on-disk layout of the stripes in a RAID set.
> 
> Each stripe extent has a 1:1 relationship with an on-disk extent item and
> is doing the logical to per-drive physical address translation for the
> extent item in question.

So this basially removes the need to trak the physical address in
the chunk tree.  Is there any way to stop maintaining it at all?
If not, why?  


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FE06976DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 08:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjBOHAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 02:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233709AbjBOG72 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 01:59:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E273527E
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Feb 2023 22:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QgfjoY1gHHrKt69eJslxeNt7SdLYTzAno8BOU7Fg7vg=; b=v43e1H1MC8mYDRwT7qCdCBodTe
        dHSfjXw/2Ry5v0KygLMz8VWlfCTmhYPM2UCbde6dEk0Mt3kZBbtKQM2MISFP8NkhvrhcARLbHzWkl
        C+0bw7fBrypDapBeMfrFKFNhTwMfSZQLQbObSYY7ub7FZ7B262U+cXXCmcyTPoFLwvvZ5mv0iU5nz
        2/PI8S867U23uNVEf0CCwUIPG2EgJJx6WOgsRHkK6qiHfOxYyKt3rODsaWZyP5Fk08XYSmpVwKxRU
        wrz9s2GxE3tDPup4sdf8x7ISXe7F+qFm+wAysjKY9D9Se5hCjHNGwklW6+EAhaO3MDELxDVqc+cQR
        e8cQEIMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSBkT-0050c9-BF; Wed, 15 Feb 2023 06:58:37 +0000
Date:   Tue, 14 Feb 2023 22:58:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Stefan Behrens <sbehrens@giantdisaster.de>
Subject: Re: [PATCH RFC] btrfs: do not use the replace target device as an
 extra mirror
Message-ID: <Y+yCncfD0EyfsxTe@infradead.org>
References: <2902738be4657ec16e5b5dd38eac1fb53aa5cc44.1675918006.git.wqu@suse.com>
 <Y+sy5xHfz6S16/oc@infradead.org>
 <e7a2cb06-d6b1-f40b-477a-dca130a4a5d2@gmx.com>
 <Y+x+GjgREMyYe5pP@infradead.org>
 <d2f73a10-7ec8-0b42-1a4e-eb86b0740741@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2f73a10-7ec8-0b42-1a4e-eb86b0740741@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 15, 2023 at 02:56:39PM +0800, Qu Wenruo wrote:
> Meanwhile replace hasn't yet reached that bytenr, thus we're reading garbage
> from target device.
> And since NODATASUM, we trust the garbage, thus corrupting the data.

Yes, for a read from the target device to be useful, the progress
needs to be tracked, and the read only needs to happen on data
that actually was written.

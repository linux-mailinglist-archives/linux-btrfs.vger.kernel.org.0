Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4211CF823
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 16:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgELO6I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 10:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgELO6H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 10:58:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D38BC061A0C
        for <linux-btrfs@vger.kernel.org>; Tue, 12 May 2020 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=141qtMojYAAKBNeyQ8FyYOol4vvkjtB8nZhW0tCt9WU=; b=F7QIVxgWkbYozOxq54RMkP81Jg
        wzRQbY3de9jgHil+xO1bEVNMtYIWJa7EGBUE4QQLJCJB8L0aKv+VVZfbLtYIfqFvGp7fsIGZUpp6j
        0YDhNPRb4Cgl22JR+cMbg2k0plWnxDylpY+OTeK5dnRZahepBELoGMTjYatJlDVuMaA1gm2nA+iBR
        PcQeQAvtt51AfkBhEeb0qWYQjZQgJAoiu+JuRj7qtOQRZ240g47dDJ0vfLy1HVhJnKAriFRQ0zQ4q
        IsBErJcyRwV4VBz39MVgvocpWYFC7h+z9oDbUCUa0EBlj1GefWqhQxoXypzlVE13NJeIli+Hp149a
        boeN+mpQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYWMB-00063W-Ez; Tue, 12 May 2020 14:58:07 +0000
Date:   Tue, 12 May 2020 07:58:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/9] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200512145807.GA23409@infradead.org>
References: <20200326210254.17647-1-rgoldwyn@suse.de>
 <20200326210254.17647-5-rgoldwyn@suse.de>
 <20200327081024.GA24827@infradead.org>
 <20200327161348.to4upflzczkbbpfo@fiona>
 <20200507061430.GA8939@infradead.org>
 <20200507113741.GJ18421@twin.jikos.cz>
 <20200507121037.GA25363@infradead.org>
 <20200508031405.br4dcibcyuoluxum@fiona>
 <20200509135914.GA4962@infradead.org>
 <20200510040601.bub3du7g5kepeakw@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510040601.bub3du7g5kepeakw@fiona>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 09, 2020 at 11:06:01PM -0500, Goldwyn Rodrigues wrote:
> > > We cannot perform data reservations and release in iomap_begin() and
> > > iomap_end() for performance and accounting issues.
> > 
> > So just drop "btrfs: Use ->iomap_end() instead of btrfs_dio_data"
> > from the series and be done with it?
> 
> We are using current->journal_info for fdatawrite sequence hence using
> that as a temporary pointer does not work since iomap_dio_rw() performs
> the fdatawrite sequence.

Ok. but in that case they never really should have been separate patches.

Can someone help me to understand who consumes the reservation create by
btrfs_delalloc_reserve_space?  Most importantly if this is done by
something called from btrfs_dio_iomap_begin or from btrfs_submit_direct.

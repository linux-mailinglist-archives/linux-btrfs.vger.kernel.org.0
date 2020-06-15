Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4C71F9589
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jun 2020 13:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgFOLqF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 07:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgFOLqF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 07:46:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102FFC061A0E;
        Mon, 15 Jun 2020 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2+5KKKYAybPWvnpSduNmazy8gDbBrDB/3AUFWj3RxVg=; b=OrO3AIR0LYrc3xDQJ+6khMrgfs
        VWa3oMImXrPjGMWeWpBcnrPsqPHEkYyIkKO5UklD1QTapLP13irYRX8cCkYkdP73cp/kDI5Au+RsP
        xRnjU7g49USsDNDW86PPCSFumRFyWnkEJWsyC2yW4IoO/hsB0BFoN94U1B1uuak7gOVyHoSrN6UV/
        iDgyWR27tjs3S6zZWEsZN9Awwaf2NTMFmwcd5sOOWPeKkMW76Vs92j8pNMTvLBKkvI6L5GlopVoDd
        q9VzmuwOuaHxq+JPY2hGOO51RIeCa0h9BIBPBK0QG+1dmsF5KF1LRPbh3SGB1hWZcRw8q2olLKbre
        F/CJk1iw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jknYv-0007F6-03; Mon, 15 Jun 2020 11:46:01 +0000
Date:   Mon, 15 Jun 2020 04:46:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Btrfs updates for 5.8, part 2
Message-ID: <20200615114600.GA32631@infradead.org>
References: <cover.1592135316.git.dsterba@suse.com>
 <CAHk-=whbO-6zmwfQaX2=cDfsq_sN1PZ6_CAbqLgw3DUptnFrPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whbO-6zmwfQaX2=cDfsq_sN1PZ6_CAbqLgw3DUptnFrPg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 14, 2020 at 09:50:17AM -0700, Linus Torvalds wrote:
> On Sun, Jun 14, 2020 at 4:56 AM David Sterba <dsterba@suse.com> wrote:
> >
> > Reverts are not great, but under current circumstances I don't see
> > better options.
> 
> Pulled. Are people discussing how to make iomap work for everybody?
> It's a bit sad if we can't have the major filesystems move away from
> the old buffer head interfaces to a common more modern one..

As far as I know it basically works.  There are a few issues which I
think we could actually trivially fix for 5.8.

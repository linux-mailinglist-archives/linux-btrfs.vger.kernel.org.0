Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CE91D5020
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 16:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgEOONI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 10:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOONI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 10:13:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6535EC061A0C
        for <linux-btrfs@vger.kernel.org>; Fri, 15 May 2020 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SYiOEG4RpCc+sSS6zGQlt+aBhRGjuh1rCk2X9unuJ9E=; b=Df//A9NZsdIdYAqTJDVsNO9ok5
        a2uRq164/ogrQSG/IoE2kpNu3RvC3qBuFdXmG0TDyfBLpCgSrDsExWjZSa7muBIVGKCYyUs2eH7Af
        uXJXI7vAmJ8ryBzjfTtV+5JXVpJPU8/mAUjUmdyH4pg+l+s19a8AlA/mdMzTdKUayf+nITIVEogUU
        Uam7kLQsoivh+cTX/S3yUqoH2TcRBEQAsCSY68pudY0RB+dVSJGEub4c+BZ7dIRPez0HhMP9MizvA
        6xgciTYVyJYOFzOv74VhIjzfhgFdi0ScC5LysPzeSdG3tc+m1xD7SI5rMJBmm8SwEdoh2ab0bvLF/
        g5zYz9/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZb5F-0002tW-GP; Fri, 15 May 2020 14:13:05 +0000
Date:   Fri, 15 May 2020 07:13:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/9] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20200515141305.GA27936@infradead.org>
References: <20200327081024.GA24827@infradead.org>
 <20200327161348.to4upflzczkbbpfo@fiona>
 <20200507061430.GA8939@infradead.org>
 <20200507113741.GJ18421@twin.jikos.cz>
 <20200507121037.GA25363@infradead.org>
 <20200508031405.br4dcibcyuoluxum@fiona>
 <20200509135914.GA4962@infradead.org>
 <20200510040601.bub3du7g5kepeakw@fiona>
 <20200512145807.GA23409@infradead.org>
 <20200512171927.tk46sbriqvhasvsq@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512171927.tk46sbriqvhasvsq@fiona>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


FYI, generic/475 always fail on me for btrfs, due to the warnings on
transaction abort.

Anyway, I have come up with a version that seems to mostly work.

The main change is that btrfs_sync_file stashes away the journal handle.
I also had to merge parts of the ->iomap_end patch into the main iomap
one.  I also did some cleanups to my iomap changes while looking over it.
Let me know what you thing, the tree is here:

    git://git.infradead.org/users/hch/misc.git btrfs-dio

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/btrfs-dio

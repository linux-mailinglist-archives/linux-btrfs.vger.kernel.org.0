Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4965F243949
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 13:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHMLXV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 07:23:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:36008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgHMLXU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 07:23:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ABA28B700;
        Thu, 13 Aug 2020 11:23:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 54BF8DA6EF; Thu, 13 Aug 2020 13:22:17 +0200 (CEST)
Date:   Thu, 13 Aug 2020 13:22:16 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: refactor how we prepare pages for
 btrfs_buffered_write()
Message-ID: <20200813112216.GF2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200807072753.68285-1-wqu@suse.com>
 <c0f45593-5733-29f1-e86e-cfa18091f470@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0f45593-5733-29f1-e86e-cfa18091f470@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 13, 2020 at 07:16:48PM +0800, Qu Wenruo wrote:
> > @@ -1763,11 +1771,9 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
> >  			nrptrs = 1;
> >  
> >  		if (copied == 0) {
> > -			force_page_uptodate = true;
> 
> This is here to prevent the following problem:
> 
> One page is completely covered by write range, but the write range
> inside the page is split into two iov.
> 
> In that case, if the later part failed to be copied, we will hit a short
> write.
> Originally we will set force_page_uptodate, then falls back to nrptrs =
> 1; with force_page_uptodate = true;
> 
> Then in the next loop, we will force to read that full page to avoid
> garbage in the partial written page.
> 
> This is indeed super rare, thus all my fstests run haven't triggered it.
> But in theory, as long as we have differnt iovs supported, it should
> still be possible.

I wouldn't count on fstests to trigger corner cases, for that we need
long running stress tests. Good that you can identify the rare cases
while the patch is still in development, catching such bugs later is
much harder.

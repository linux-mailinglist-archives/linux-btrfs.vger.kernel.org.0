Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250E73C9DE0
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 13:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhGOLln (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 07:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhGOLln (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 07:41:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506BFC06175F
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jul 2021 04:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ln1tYOB95I1nl0+YHuYYYYxxqHXe1WyYXPaBQhSf5iI=; b=S8V4q0VWzsIxgqTpzYOL4tOuBg
        /Yz6q8FiRZPbntmBzjmBccjE9ElknqN6iArraKnIYyKMIQK50/kvWVI2lrXbtpHABMgVgjWXhKMya
        PJMQtmMJOMkj+rb7B48/6iC3NEwaiv6iQBYGMBNiP7wRzeBivgrcrRg/9uQ3CVGq1jmnDHnL+A4td
        aS3trH/AFzNluy8F8KQwzeDeSv0uy3Dj2Y7QaJ+nLuhP7lPNprXqApGP54TOX6QahkLCTEOFL8sSP
        jGGPBxKpMp4gQ7CMyY0+R5R+7nnuT2ko7n32BxiYkCkPc4+OQUzqNcU4j1PgAebOQrV70rEYazwYI
        Ct64zwXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3zgo-003IWA-TE; Thu, 15 Jul 2021 11:38:12 +0000
Date:   Thu, 15 Jul 2021 12:38:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Neal Gompa <ngompa13@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: Memory folios and Btrfs
Message-ID: <YPAeGmTitJ+hXDxp@casper.infradead.org>
References: <CAEg-Je-JDyoWvcHZjVh-Wm-KOcV_qt3R+m-ObDzCR2kByft_2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEg-Je-JDyoWvcHZjVh-Wm-KOcV_qt3R+m-ObDzCR2kByft_2g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 15, 2021 at 06:26:42AM -0400, Neal Gompa wrote:
> I've been peripherally following the work on memory folios that
> Matthew Wilcox has been doing[1], and I started wondering if Btrfs
> would benefit from it after the subpage stuff is done? It seems like
> adopting this would be an opportunity to decouple Btrfs from mm page
> size entirely, while allowing us to pick more optimal settings for
> Btrfs regardless of architecture.

All filesystems will benefit from using folios.  Once the initial
~92 patches have landed, using folios throughout means fewer calls
to compound_head() and so smaller code size and presumably slightly
faster code.  All filesystems should be converted to use folios rather
than pages.

Supporting multi-page folios should also benefit every filesystem.  The VM
gets to manage file-backed memory in larger units, so filesystems will
have less work to do (eg readahead will bring in fewer, larger folios,
writeback will also write out fewer, larger folios).

I look forward to working with btrfs people to figure out how to track
the per-block state without using buffer_heads.  I have that working for
XFS with iomap, but XFS tracks much less state (just uptodate, which is
presumed to all be dirty if any of it is dirty).  Looking at the btrfs
subpage state (in Linus' current tree), it tracks 4 bits of information
per block; uptodate, error, dirty and writeback.

As far asa supporting block sizes > PAGE_SIZE, this is something I've
had in mind for a long time.  My current thinking is that we can take a
few bits in mapping->flags to set the minimum folio order to allocate.
There will be a few places to change, but it should be doable.  Some are
concerned that we won't be able to allocate high-order folios, but my
thinking is that if the page cache is using high-order folios, then
we'll be able to reclaim high-order folios from the page cache.
There's only one way to know what will happen.

Return-Path: <linux-btrfs+bounces-2441-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1554A856FBF
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 23:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F221C213C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 22:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BDE14532C;
	Thu, 15 Feb 2024 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nDswFkqG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193831420DD
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Feb 2024 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034694; cv=none; b=SzLhJKOCbOVbD28B/REJtzv3dQFN+/ombR/KZqtOf4FJzOh8xrdoW67HnvANok5TANxTEk+Fkj2GnGHB4eAVYrG+Mn85pQ5SR5yJnaZVYtbsXPCbvSQ7XcPzH2pvipcbjAHQBeEP4fzsBAYQ9WgjtKsQmrIUu9SrpBnT2lkeb70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034694; c=relaxed/simple;
	bh=RKw5e0R0L9saSpIRyocTYGMRIOMYc1hv8WeIhBIp2Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E766a3LLBh8lHVv4RnbCNZo7PpsA6fPPc3wjFz/TWslP3/q/84oOWFp3JtrvsrzTgMfYIsuJBiAfdMXOyhY9DcsXWmXPSALZR9EqvHjX2JvPyhGgTxkAVcU1y14tnzw9w79U3uHBJa2wmjEeH3bj3sVx1w6T/tywcrc7nZs49U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nDswFkqG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Hg29LMRcpkZ1PQ2R4QMZoMBgSlLkWayMpheDsVpEu1k=; b=nDswFkqGXUOWe5WgLIgU9NKhvp
	wy0Nx3FeHwmXwRbpMbat1zCve7o+kkXvDE4gLA3yEC/xBQ9LIcwdCOnhBk0h1TCrKm3DAcsvT2CFk
	VpfVARxF3+oKPkMlYLHFPUBbuMi1XiDUQ9duziU0sYcfH1/A3kNX9s4MSD6jDMvINf9gKvlSUBVUU
	F+Gt/P/dov6H/PqquDySxwhyPVUOIDI2twYja7AnI1kk6gRI8NtupbaYZtMbpvfuqVtU7uG69af8b
	5rrS9NuYHGw+k7LotiHiJ4hloPJK9xM7mAKITif5402VcjeqdcqXEROayRD0n7b/AfxFaPl3cKybY
	+mfQRQhg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rajqW-00000002yJo-0a2R;
	Thu, 15 Feb 2024 22:04:44 +0000
Date: Thu, 15 Feb 2024 22:04:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Convert add_ra_bio_pages() to use a folio
Message-ID: <Zc6KfL1r-dxoAyVh@casper.infradead.org>
References: <20240126065631.3055974-1-willy@infradead.org>
 <cead7376-a45b-41af-8dbd-cbe9dfaee8f3@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cead7376-a45b-41af-8dbd-cbe9dfaee8f3@wdc.com>

On Mon, Jan 29, 2024 at 02:55:23PM +0000, Johannes Thumshirn wrote:
> On 26.01.24 09:53, Matthew Wilcox (Oracle) wrote:
> > Allocate order-0 folios instead of pages.  Saves twelve hidden calls
> > to compound_head().
> 
> Hey Willy,
> 
> Do you have some kind of "Reviewer Documentation" for folio conversion 
> patches?
> 
> I'd really like to review this one and the others Qu sent out, but I 
> fear my knowledge of folios is only scratching the surface.

Sorry for the long delay in response.  You deserve a better response
than this, but ... I don't have one.  Partly because the things you need
to be concerned about are very different between filesystem patches and
mm patches.  In filesystems, it's going to depend on whether the
filesystem intends to support large folios; obviously btrfs does, but
many filesystems (eg adfs, efs, iso9660) will not, because the reward
will not be worth the risk.

Essentially you're asking for me to predict what mistakes other people
are going to make, and that's a tall order.  I can barely predict what
mistakes I'm going to make ;-)  So we've seen the mistake of shifting
file position by folio_shift(), which is honestly a new one to me.
I've never seen it before.  Something that's worth commenting on is
if there are unnecessary conversions from folios back to pages, eg
lock_page(&folio->page) instead of folio_lock(folio).

Really any conversion back from folio to page is an indication of a
problem.  It might be necessary as a temporary step, but we _should_
have enough infrastructure in place now that filesystems don't need to
convert back to pages at any point.  Although there's still
write_begin/write_end and some of the functions in buffer.c.


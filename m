Return-Path: <linux-btrfs+bounces-2843-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C0186A1BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 22:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FA71C2316A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Feb 2024 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4768214EFED;
	Tue, 27 Feb 2024 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hJlba0W/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8BA4DA0C
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Feb 2024 21:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069569; cv=none; b=Z2/IP2sSCnFKVLGc9wPC2Rpo0GEncc3yVvg0XK6C7zHvm4mJDhfFOJ8qGd4szcgo7o9l99NQwk6woNGsf1fOuHFmKFQ8bvFiVpHvtabxKEixf2wYzX4Qxk+3Ky5rPmpwuO331T39qiYmd3zxiR+vIoqMWUa+70CEsx4/a0GnsPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069569; c=relaxed/simple;
	bh=oCj0tN9x+1eH5UebNFaZuFJ09V00E5Fmdvj/bye6/K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQa6bOSqngSVlxy74L2WD/kVNok/uV6W964TR7sb/cqFayQDhmwOweBnW4E58UIemWsLZEWU0GcQVK1UiTwotFBm0JfvIHU9W6xuiPsdp3qnebg96usfSsyus7oAbHLmoieQNlqyWnR2m0wkxN9JwTPUilZQA+K6xOdox7DCuaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hJlba0W/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=QgmUhHXJfA2qg6FNpwCwzSFEwTcl+PDccGm+ZrtjjsA=; b=hJlba0W/zUyTmcqEo5Rl/uOAYx
	C3pM4XXxNqy3SQ/9enA6lmpRbJaDHXvJAlSSKCjTkmCrI4uzkQhfu8gFcfU2BU8xxELui6a/tNo+5
	k5M2N7NHtRZJCSf7pVIwZobgKRT5Xc0+X2SM568xe0xD0Olhi0AbTlYXs8M0afyiuLC0ukdIqf8ll
	W+B0mKy6LxYDdRDzXqMmeFDXK2q7OBa4X2nC1rJJa1VIKWdnHvn6tKVED4tnPMY/JcAtGiiUxWd/U
	t1sfl1fOlramiP8dL/Ef1/uveii/vgCXoRcOPjYPhM4QHYFAFFHwbcyYw3WVDyeLLkTUxTaGZxWRA
	BvpnY6oA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rf549-00000003QlA-2vIX;
	Tue, 27 Feb 2024 21:32:45 +0000
Date: Tue, 27 Feb 2024 21:32:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH RFC 2/2] btrfs: defrag: prepare defrag for larger data
 folio size
Message-ID: <Zd5U_bSQabhuc4iv@casper.infradead.org>
References: <cover.1706068026.git.wqu@suse.com>
 <5708df27430cdeaf472266b5c13dc8c4315f539c.1706068026.git.wqu@suse.com>
 <Zc5y0IRJdqjmstvp@casper.infradead.org>
 <fedffe54-abfe-4ef7-a66e-a5a60bb59576@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fedffe54-abfe-4ef7-a66e-a5a60bb59576@gmx.com>

On Fri, Feb 16, 2024 at 09:37:01AM +1030, Qu Wenruo wrote:
> 在 2024/2/16 06:53, Matthew Wilcox 写道:
> > On Wed, Jan 24, 2024 at 02:29:08PM +1030, Qu Wenruo wrote:
> > > Although we have migrated defrag to use the folio interface, we can
> > > still further enhance it for the future larger data folio size.
> > 
> > This patch is wrong.  Please drop it.
> > 
> > >   {
> > >   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> > >   	struct extent_changeset *data_reserved = NULL;
> > >   	const u64 start = target->start;
> > >   	const u64 len = target->len;
> > > -	unsigned long last_index = (start + len - 1) >> PAGE_SHIFT;
> > > -	unsigned long start_index = start >> PAGE_SHIFT;
> > > +	unsigned long last_index = (start + len - 1) >> fs_info->folio_shift;
> > > +	unsigned long start_index = start >> fs_info->folio_shift;
> > 
> > indices are always in multiples of PAGE_SIZE.
> 
> So is the fs_info->folio_shift. It would always be >= PAGE_SHIFT.

No, you don't understand.  folio->index * PAGE_SIZE == byte offset of folio
in the file.  What you've done here breaks that.

> > >   	unsigned long first_index = folios[0]->index;
> > 
> > ... so if you've shifted a file position by some "folio_shift" and then
> > subtracted it from folio->index, you have garbage.
> 
> For the future larger folio support, all folio would be in the size of
> sectorsize.

Yes, folios are always an integer multiple of sector size.  But their
_index_ is expressed as a multiple of the page size.



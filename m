Return-Path: <linux-btrfs+bounces-20611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A867D2DDF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 09:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66719300A52E
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jan 2026 08:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5BC2FE060;
	Fri, 16 Jan 2026 08:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0XNnnbnl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236142F1FED
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Jan 2026 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551459; cv=none; b=gLYFh3uZjVHuopdkL/24SzvgkSdY3sFsLK9XeWF9vrSBk6ZqbPfecgv5hGuJYBpg403YSTxR2T46PdfDmZ73sXeV11YZy2y7aTsJt6shI1jrLd84QmfF+2lfQeoOWcfbYhm8MPjiNAlZPOKhPjslmSDK9wRnsqtoOy9yFhfIYU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551459; c=relaxed/simple;
	bh=nQQvLLREuonkR0kh3kbLV3i2ePfeE6U37ZPGoMoPHHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ku3Nkp3KGn2uf92haKMYHoHw1YWCgCbzbjVHFTz+myfsn5GeEeCBdT0PNgXbeamJOwAtok03wvQtc7Ao43idV5VufoK0CfcNnBa6vU2p5rTrfZlxCMhfudv0OwER0wUr7bJVssbbXIEf0TqbBzNO64lhsEbofe0gfPx8zbCo5HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0XNnnbnl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0dlbXlyfMrQYY0UyVelizvQDg33riLmpyJioNzCT46I=; b=0XNnnbnl7xPCMVV2+nMtNcNa/b
	2MEAW0Js2IkMquvEc8/rVOM+3OMS+xQZaNQot3bXjeMZGJ8jslGceXRoNmKoG2r4ugmEmUNzGSxE5
	NNMhTc849aH8ZWN4qsAv/PgRMD4HF18vYbiczs1cf4E83KnRPVw6bSG42p5Ul7E+dLmB2EkF54GaP
	tqczMNzsnulNy4WdyA8vB6RGhyWN5QLDkTMAciHxyVQuG51NFmAY44YGbKOG7Biph3T063GnjAFbo
	C80jhetd73uIsG9PUnA1b6Y0FTnn3BpQKpDlCshK/zFauKXMB1yd0Pz7ggtZkJlQI4S1h5wU2A73T
	rcz+Co+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vge2w-0000000DgYN-3cku;
	Fri, 16 Jan 2026 07:15:02 +0000
Date: Thu, 15 Jan 2026 23:15:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Boris Burkov <boris@bur.io>,
	"fdmanana@kernel.org" <fdmanana@kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: add and use helper to compute the free space
 for a block group
Message-ID: <aWnldkx-jTBlnIhv@infradead.org>
References: <2ba3b023e186d4eec78b8515bb375f310b4b2390.1768512027.git.fdmanana@suse.com>
 <9f70166505b58147e580c51d0ea498b0e9f30ea2.1768513901.git.fdmanana@suse.com>
 <20260115222309.GA2118372@zen.localdomain>
 <04469920-1dbb-46d4-ba8a-b4ac986ffff1@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04469920-1dbb-46d4-ba8a-b4ac986ffff1@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jan 16, 2026 at 07:10:04AM +0000, Johannes Thumshirn wrote:
> > FWIW, I personally kind of prefer a name involving "available", as I
> > think "free" is less descriptive of the zone_unusable aspect, for
> > example. And generally evokes some kind of correlation to the state of
> > the free space entries.
> 
> Well this depends on how you interpret free I guess. I'd interpret is as 
> a free (or available) to allocate from.
> 
> And for zone_unusable this is stale/old generations of data, which we 
> can't overwrite due to device constraints. So it essentially is not free 
> to allocate from.

Free doesn't imply available to me.  For that reason, in zoned XFS we
ended up with

  free: not used to store data at the moment
  available: actually available for new allocations

I'm not going to try to force this on btrfs, but we ended up with that
after quite a few iterations because it seemed least confusing.


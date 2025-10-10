Return-Path: <linux-btrfs+bounces-17606-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7C6BCBB5F
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 07:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FE9189F8AD
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 05:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAFC238C3A;
	Fri, 10 Oct 2025 05:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G0aTLxsN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6021E9B3D
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760073917; cv=none; b=rIcswAcdP6CzmYoF/18BfcuOWHfUlQeFN+4+FJ+OWEOeV8SoSQuzSTnPQ0qJAeEjUq22eghh8nkA/xwnhl+0sh85FR8bKZqCpxEE5swX4/9exK1fyS+zPnQNjbAoNI2volSiM/YXWKdx0tzscVj55XzrDA5LZK4xsN359Z1MgGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760073917; c=relaxed/simple;
	bh=pyHRQjnOCh58LYLkARziq43YuapFO7Nx5OZ3AymDn78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/BFb2I5OtVYPggGrhOrSIxqbINJ/q3sm4uw8nuvYeORLP0IGmueupJjtCxgfDD7l7axHDnOoUoqNhTjwZpSuqJFCpQJJL/FYniDk8RfVLCCwAVt3/h7Cbu8hbwJV/YyHRyHNclFMCqG5fA80i8KtrnzzYovBihdPlZgtPWjNHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G0aTLxsN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+b6adjzBlQ4buMu6IkbFD3dPd/KvXh0u9OF7kGDSBbE=; b=G0aTLxsNv1AlxjXzODranoe5+3
	+MFuqmHcNkypP/LWegqkb/fvMrynLrOstnDI8EEbbaebZayFPVBO6o8rzaARDGFwxMFg9Y0zT+k9J
	2euq3j5yvLscDbPjAVk+VGOgrR5g5P7lXlWjSnyRtI3q1myaFwXgvnEmqW6uZU3S2hiZGTXUICl6s
	bqeyIZwPek5tg5ZRkVGd24I3lBQsswWTDGE4zpzeFisTTOnGWmqeyoOK4UeH9o8qRyYPx9NnBBl4+
	LdDM7qRhi4cvIqhGHsdGq+30Rn02RlVgmqcuZMjHuKpAoB1OGGiRVCReX3XXeP9bWL8LSZEuJc/xv
	WM8u79Lw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v75cw-00000007hoL-3WqD;
	Fri, 10 Oct 2025 05:25:14 +0000
Date: Thu, 9 Oct 2025 22:25:14 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Message-ID: <aOiYuoecduyQbxwl@infradead.org>
References: <aOSxbkdrEFMSMn5O@infradead.org>
 <e0640c83-e600-410e-bbcc-4885852389c2@wdc.com>
 <aOX-g97die1kbVY7@infradead.org>
 <c5b15471-5a8a-4e0b-a7d5-ad682785b581@wdc.com>
 <a2c698cf-5735-4ef4-859b-057fece29c9d@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2c698cf-5735-4ef4-859b-057fece29c9d@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 08, 2025 at 02:09:00PM +0000, Johannes Thumshirn wrote:
> On 10/8/25 8:07 AM, Johannes Thumshirn wrote:
> > On 10/8/25 8:02 AM, hch@infradead.org wrote:
> >> On Tue, Oct 07, 2025 at 11:16:08AM +0000, Johannes Thumshirn wrote:
> >>> hmm how reproducible is it on your side? I cannot reproduce it (yet)
> >> 100% over about a dozen runs, a few of those including unrelated
> >> patches.
> >>
> >> My kernel .config and qemu command line are attached.
> >>
> > OK I'll give it a shot. For my config + qemu it survived 250 runs of
> > zbd/009 yesterday without a hang :(
> >
> >
> Nope, even with your kconfig no success on recreating the bug.

Weird.  I'll see if I can find some time to bisect it.



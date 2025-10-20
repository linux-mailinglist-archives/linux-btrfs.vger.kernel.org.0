Return-Path: <linux-btrfs+bounces-18024-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52585BEF835
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 08:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2F9F4EC99B
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 06:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041B62D7DFC;
	Mon, 20 Oct 2025 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hhJNuPEh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DD435950
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 06:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760942843; cv=none; b=oNv7uvDpYZsMRB9YjAn1q7VVfBP0urFRtbbdpit2icws71Ya2hp2xfCnR0+rEqO7AOZg5Ez2fwZiDO95BVqf3FlkFArnh5iIA5fA6pfjcUjFkq28GvZQ/kJfZmMHZUttD4JAo7yXbhFmQrxNQMdf5Iq8etFiHlbJIq44EPM8Uko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760942843; c=relaxed/simple;
	bh=ZE+tY81nODVg/5mUsEZwlVE6qAARMDjUbPQSOv4q4V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMeRzzrT5iMe6l9KjvxXETYidohBThWay5ivOSpmTMpj1AKcJz1kwACf31sE4duaEiJq6e/CmqTkutFHKq0pQFlETgftFS/X7z96bZuKAJ4LOVklcMQ6TVgFHi1DauG8xs8jXSs0K4+WgTj3YPkScUAOsVmuNH7x+kdh4+XWtyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hhJNuPEh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=54cW99h/3yb7ebat8I8DmbXKlNSRs3MdwUEgBSitOrg=; b=hhJNuPEh4kEqbjfnlKDAc2MDLq
	HbgDq3d/qz4jfGkz4SpiRVydRIeaZU8KE9xGv6UzSlFjSiOSiAQujO4XZvnuHS7LROqV575TYCvhI
	kO/GaJOJh/eRi7B46hRyZp3IdFG51N4eCG0gc8pFbpHn6eYEchabXyFgpUJWAtmG5183z3m1sK5DE
	pUaHRSSlokTKos8Iq62XT0uL8uTTzUEwwJ+BiMdnyAPkEDjGvIUGxJQE3hsgGjs6/J60CR9qaWVjy
	GjsLWpK8uQsEpMuPR3FIyzkHXifNBscC+SHX1730HPJzG4PII/c5OmjMrLbYnZX15ztBlZdw3TimV
	7n3XTndA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAjfq-0000000C5Em-2xXV;
	Mon, 20 Oct 2025 06:47:18 +0000
Date: Sun, 19 Oct 2025 23:47:18 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Message-ID: <aPXa9gR4l3WnI8kh@infradead.org>
References: <aOSxbkdrEFMSMn5O@infradead.org>
 <e0640c83-e600-410e-bbcc-4885852389c2@wdc.com>
 <aOX-g97die1kbVY7@infradead.org>
 <c5b15471-5a8a-4e0b-a7d5-ad682785b581@wdc.com>
 <a2c698cf-5735-4ef4-859b-057fece29c9d@wdc.com>
 <aPCXz7ktsyE8BLeG@infradead.org>
 <f141df1c-1d91-40f8-853a-f423ea4a452f@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f141df1c-1d91-40f8-853a-f423ea4a452f@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 17, 2025 at 01:33:08PM +0000, Johannes Thumshirn wrote:
> On 10/16/25 8:59 AM, Christoph Hellwig wrote:
> > I've bisected the hang to:
> >
> > commit 04147d8394e80acaaebf0365f112339e8b606c05 (HEAD)
> > Author: Naohiro Aota <naohiro.aota@wdc.com>
> > Date:   Wed Jul 16 16:59:55 2025 +0900
> >
> >      btrfs: zoned: limit active zones to max_open_zones
> >
> > with that patch zbd/009 hangs 100% for my config, and without it,
> > it works fine 100%.
> 
> I still can't reproduce it. We seen a mount error as fallout of it 
> though, can you check if you have 53de7ee4e28f ("btrfs: zoned: don't 
> fail mount needlessly due to too many active zones")?

Still hanging on -rc2 that has it.



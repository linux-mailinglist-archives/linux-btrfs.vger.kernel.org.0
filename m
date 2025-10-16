Return-Path: <linux-btrfs+bounces-17870-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE97BE1D73
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 08:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9FED480C8D
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 06:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEF32F659C;
	Thu, 16 Oct 2025 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qP6D1LVq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EF12E8B7D
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597969; cv=none; b=SFgqRtuMJnHRFw6WVMFk7otrOwCutQwAnDHxfuUuHSoZN4AWMtKmjKcDsIyf09T8WPTOyI1h9i7OY3Nc94JSXSPFs2HklVJe8mU2dWblhuEU8ibv/DZQp37HKSlLZ9l1Hugh7GOFRYJ0qn8UaxxU4dj02EUgHPfNLwzVXrrueos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597969; c=relaxed/simple;
	bh=cvu+uenW22QfiV62dQCnsabMbavdJ06/e4yhzKH8mks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLjT5cPeuZLeXlt7oeiX+NzaROPkqNQoyl6/v/K4ZWOdIS+DZBGEG4Kp8gTmHh03mpjRsWr6/bB8SGQRN5EL8ae1yehVRNH13ESGlAgDJRN257APTxLovNU4umht0IRlhIpAdTvX/be8Q5qfSxKLeArYVZzg6NGQ5uiOgZJNY5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qP6D1LVq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nr3yqyKsaca/JdfCaxMOz58xWmylzoios5yMz2cVGBI=; b=qP6D1LVqVMIj/o52WJdfvCMazz
	ZM0kzqUghod0uEUgC8kNkSi8RJ5Ahv7nEmEPH4yVd0pXbObl2DIvyECDbh6XvxTy9qtM+pf7xS/hw
	mCCksSSF+1D4AXMWB2Qx8mbDhGy3FSCxxYc+rPomH9nnJLG95d+mME4Fd3FBIstLpsIH4rPB4NMiI
	FgH+kBgrzeEmCDnjpwWurRytjwDgzWyKAgenivsGFjdQ12rEIkv8elbg6q/5NBohEQKX+Ce5wVmrl
	/x1S6sqRfXPEaSyZHEHiua69E/tgLrm9rdyFoFYDoaIu7Myw8+4M8P9RIUmQR0/OCfnZh14AHCoqT
	EUybRmkQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9HxP-00000003hwt-2Yzl;
	Thu, 16 Oct 2025 06:59:27 +0000
Date: Wed, 15 Oct 2025 23:59:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: Re: zbd/009 (btrfs on zone gaps) fail on current Linus tree
Message-ID: <aPCXz7ktsyE8BLeG@infradead.org>
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

I've bisected the hang to:

commit 04147d8394e80acaaebf0365f112339e8b606c05 (HEAD)
Author: Naohiro Aota <naohiro.aota@wdc.com>
Date:   Wed Jul 16 16:59:55 2025 +0900

    btrfs: zoned: limit active zones to max_open_zones

with that patch zbd/009 hangs 100% for my config, and without it,
it works fine 100%.

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
> 
---end quoted text---


Return-Path: <linux-btrfs+bounces-10465-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F239F45C5
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 09:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBFB7164BFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F771DAC92;
	Tue, 17 Dec 2024 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HLiRjPVs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9A1D63C4;
	Tue, 17 Dec 2024 08:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423268; cv=none; b=C9Zbz/6dSsBrX9KV+FylJ2Rq/nYGoVyQ54CSjuTFcmtpAXp9ZTsJNnRM02D9MfjjxYbEubK7/jlE76pt7zdpWiysBpvoRwihvvl19i2wlSGNtY6nlz5WxhxHXU6R1KRTbIDrSi71W1HuqDQuvB7ZKeQY6tkxHFEfYABcPhRWSLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423268; c=relaxed/simple;
	bh=1jzs4CCZnnPCBGDGkVIwc5KZKcCTy9vxY3xTwj1HoKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KY7uDnDv/DEeNKbd6VXBeRYwp9XUGNrV/kRP2KG23OMG9LWNwcPJJunWyp6tIMdJmG6e4oo7m4m2VBYN3+SSQRPGIAPOx+zSGK5WCcw9CBAStdCRFMNPBxefoKhyQEXRTTMmXzPYjFWeFHSewHFVlyuScmzJ9VHAvYvXfJ9IfKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HLiRjPVs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p4y98tcSPeoLkykAKnvlDiZ1Lgbu2Ly9/9lzAx/jDgQ=; b=HLiRjPVs+VcW1Tc15HKSrp+e11
	lIMSdKYFt3NyeKqg2n7ovF1HWmFUy3tfaVLg3kDqQ0h2YaLh7ljtI0TbEO6RLvu/x8P9nA691J9v8
	uH3hlwQCGKjqzhtClqvBmkKe4T3uIpLIplFtCZjoMlhGuAe6ZiaBXr7l4cIcAf3iRHR5aYbMy1/N9
	momEfYp5A/It61kCOTimw3K1h7Nbx4ERX6xH9l4tSoiyMDhjMXEG+MuxKOKX75lOHmc7KRWssIXUD
	kz3EFECxr0nc2RMUcPPSNivmSaTwissxAL6hx2P9HQzS4Uaz1VMTdnZKDS3dFRvQ7rHYE/ShHKHd1
	O1OPtp+g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNSip-0000000Cg4k-1lCj;
	Tue, 17 Dec 2024 08:14:27 +0000
Date: Tue, 17 Dec 2024 00:14:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test swap activation on file that used to have
 clones
Message-ID: <Z2Ey4yQywOEYqEOI@infradead.org>
References: <dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dca49a16a7aacdab831b8895bdecbbb52c0e609c.1733928765.git.fdmanana@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Dec 11, 2024 at 03:09:40PM +0000, fdmanana@kernel.org wrote:
> The test also fails sporadically on xfs and the bug was already reported
> to the xfs mailing list:
> 
>    https://lore.kernel.org/linux-xfs/CAL3q7H7cURmnkJfUUx44HM3q=xKmqHb80eRdisErD_x8rU4+0Q@mail.gmail.com/
> 

This version still doesn't seem to have the fs freeze/unfreeze that Darrick
asked for in that thread.



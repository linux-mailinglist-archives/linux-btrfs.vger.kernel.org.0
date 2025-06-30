Return-Path: <linux-btrfs+bounces-15085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB007AED417
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 07:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136653A744D
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 05:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27B819F137;
	Mon, 30 Jun 2025 05:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mQaU63iD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C114A23
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751262572; cv=none; b=gBTrmaMfR1TpXYnkYX0adZ4gC3Oa+lhTIKjGkvgeI07FVgKG+hSMcFa/1caWxzYF8Bv1u5mTqkSUI9vEIwxUUCrjE5tIgQ1aZYcX8Vibsc6VoB7zFgMKSyXOG+5bPHAZPLwcNIKhsmiXDYgaIDmkRGrJ9oN+qJJVCW/NmLuOzrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751262572; c=relaxed/simple;
	bh=JsfS8Wl1XrREMocPalThvdKppx90e2nJ0DEMdXXK6h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADZyR6mH0nZDM5dvIvJ21cwYOrRqeDJwjEmr0uH9uBq/epg+a9nO4BVBVAxpHKgSa97GJfj1PwS4cTtfnicDOP88voqjM8bM7iicOlzhOatkGJJmpE6a+quTz/W/0NhTtE4lQaLCL7xdtmOW3pQxXILyPUXrFCMdoW/PQTwSFJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mQaU63iD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=PlS3DOu6s5fsp0auZQjO79xIT8e2BjeSJdKj5vwdvY4=; b=mQaU63iDJ8U/JXBusWD2ThMM2s
	5KZs9+aslFr7nYnYPvmb8rJ/UJT0aN4906Llirfg9xhFqpnQbSaQBuyKGqhxjLrgaIKkPQ/RtJrtL
	SsJUVHkTgf3Qve/9AWj4w9bCn6V1f9bwrpPXbPmaOhvxF79qQTh5LANLLOkIhyz7gsNzntkU2pfNt
	2opGYfg0uqVfN4FrrNrIYOeBs6G6o/DBkG/IzwMYMFWvqA4B0+eXOyGVBRm8gajWW4ji5R57IwdMY
	OgxOFmGGWT+1Hj13goathc+n7wseAYoSgUEW6O2ctmFiR8WtpbLU09STkN8yb+1Zhl87zzKzHib2G
	zUG9/WKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW7OS-00000001HyW-0nwz;
	Mon, 30 Jun 2025 05:49:28 +0000
Date: Sun, 29 Jun 2025 22:49:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 0/8] btrfs: use fs_holder_ops for btrfs
Message-ID: <aGIlaA3wxb6b7Ea7@infradead.org>
References: <cover.1751261286.git.wqu@suse.com>
 <aGIjUs7rVy05sQXd@infradead.org>
 <2ddf32ff-7411-4325-9ce2-116f4c5f6362@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ddf32ff-7411-4325-9ce2-116f4c5f6362@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 30, 2025 at 03:13:11PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/6/30 15:10, Christoph Hellwig 写道:
> > Looks like this doesn't add the remove_dev method and thus does the
> > wrong thing when a device underlying a raid configuration gets removed?
> > 
> 
> The remove_bdev() callback is a completely different patchset, which depends
> on the btrfs shutdown support.
> 
> This series is only for the blk_holder_ops, and will be the basis for the
> remove_bdev() series.

Oh, right.  Without ->shutdown we're not getting any shutdown at all
so things should be fine.  Sorry for the noise.



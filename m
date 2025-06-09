Return-Path: <linux-btrfs+bounces-14557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE142AD1864
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 07:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0E016A5A5
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 05:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59784280A38;
	Mon,  9 Jun 2025 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="34mPwoEX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C428002D
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 05:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749447505; cv=none; b=f7jkQosmxc8Uuy3N34VI9kVSKA+fHuWLuXSjRB3OxGHSOdYx1ExDNaUEMUwU6MKBMc3gO8XjkB/ujevuMIrb6+YFif8iSud4a7uxeN9gXLeXHX+hMYMWzUbAUrDzmma3J9nMDbsFIbwrS/iAUCcIrQnokKcDz88yiCWhW85BtgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749447505; c=relaxed/simple;
	bh=U2f0y/Bms0NmipAvXPhPBMyghhwRT9Rm2PozrvtrYdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qr5hHOT7axqbsnBygF+dcFI2LJU0i1ABTZAzjd7rVLfd1vEnUX4T0+ne4JpEgaKSdXQdJkyF1GtQev+X5xVKN5CaSX8QI8l4f5BbBY9XswVJDnwTgYphVVSfXTwv6jKnQ0TIF/Ud+OBc9bzPRcqBm73EqYFM2nYj9ArrmwaEzYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=34mPwoEX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=u3wX/tZZOhL5HM/hjGzYcS3PRDl6UzgfsoSxyA2ZfBM=; b=34mPwoEXDxfSblACVMYiY8oDyX
	N4JsSTEBn2hEyb1BVgXXTPJMMnGfOT+y6Xq8r8Zopayveefz11qARXGNFoQIypedZDfUA0nJC6fXm
	QCUa7dKNcqGtY5oPDG3SpJLm+30wb1PM/x+0iH4ZYnPF1XTL03hwoyh8uaX5ah4/Edbbd6Fxq4e2L
	Ao3ksDJRuvFNxkCdF9WDdh25WNcN0pgkACFn/LtyVEphVoyY1dhC76sx0BgTnvIXMCcg1l+Xy/BAd
	x4jKfyvVvry6HgjdvxvXOc1bP8FpeWXaksa53CxD6aJxes95ULZwa/JXFtafY+TyOYzu3MzaKrN0t
	vwsjhruA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOVDD-00000003TQJ-3O4I;
	Mon, 09 Jun 2025 05:38:23 +0000
Date: Sun, 8 Jun 2025 22:38:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs: introduce btrfs specific bdev holder ops
 and implement mark_dead() call back
Message-ID: <aEZzTyBsj7x-4g5l@infradead.org>
References: <cover.1749446257.git.wqu@suse.com>
 <aEZvaqtkM6JvLtLL@infradead.org>
 <e2a5a99c-3da8-4b2a-acd1-b892b4f67073@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2a5a99c-3da8-4b2a-acd1-b892b4f67073@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 09, 2025 at 03:01:32PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/6/9 14:51, Christoph Hellwig 写道:
> > No full reivew yet, but I think in the long run your maintainance
> > burdern will be a lot lower if you implement my suggestion of using
> > the generic code and adding a new devloss super_uperation.
> 
> The main problem here is, we didn't go through setup_bdev_super() at all,
> and the super_block structure itself only supports one bdev.
> 
> Thus even if we implement a devloss call back in super ops, it will still
> require quite some extra works to make btrfs to go through the
> setup_bdev_super().

Why do you need setup_bdev_super?  Everything relevant is already
open coded in btrfs, you'll just need to use fs_holder_ops and ensure
the sb is stored as holder in every block device.

The other nice thing is that you can also stage the changes, i.e.
first resurrect the old holder cleanups, then support ->shutdown,
then add the new ->devloss callback to not shut down the entire file
system if there is enough redundancy.

> Although I have to admit, if all btrfs bdevs go through fs_holder_ops, it
> indeed solves a lot of extra races more easily (freeze ioctl vs bdev freeze
> call back races).
> 
> > 
> > This might require resurrecting my old holder cleanup that Johannes
> > reposted about a year ago.
> > 
> Maybe it's time to revive that series, mind to share the link to that
> series?

My original posting:

https://lore.kernel.org/linux-btrfs/b083ae24-2273-479f-8c9e-96cb9ef083b8@wdc.com/

Rebase from Johannes:

https://lore.kernel.org/linux-btrfs/20240214-hch-device-open-v1-0-b153428b4f72@wdc.com/



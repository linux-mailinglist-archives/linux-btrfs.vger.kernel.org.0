Return-Path: <linux-btrfs+bounces-13421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C99A9CA8A
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 15:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EC43A9917
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 13:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A62C24A06D;
	Fri, 25 Apr 2025 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M80CKTdp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE1042A9B
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745588147; cv=none; b=SVEJrHN9hWF4a9Av/wo1ZiMbZQCZpTZSAt08lN+KxUFN8O1mvq+BPhYx1QPo7EneTxZ14Ra1OTnYI80EZcJBdLePMHB+/dYmtfMmYD7WGYf7SM3P9U4TcbKOBsP5qE7mswGh65LKIdHRDrNvNSidQDpALNWAQE5k/dxw9hxOpPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745588147; c=relaxed/simple;
	bh=P6HXRmZgk2tecSQfPRg7xgJ0srtZ0XAJ6Dp/UIpX6dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ST1bMj6sM1ZDPBngVl8g3DZf3XtWh/BVD6oQsaezP3agLLI1K42mWA9JWmEkMLfWnQYbAQdxLzkE3hbyKOduazMWTmQrG5/0iYsKAV8QNZZ0Lc5L7YG0P9QnGBWnc7oV0qgN2xarlr4QG4Rp3//Anf1/YGhwU9AE0fh9TUkewgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M80CKTdp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OrbZf4kqBTcLh+fyOuJx+UhBaNKPNsorgaJqaQqHbm8=; b=M80CKTdpZymC/yrYrubvJDKlMX
	UYVYqRm7wrfFTyBP45ACxG8nYpDt5KomK5lhDptpDHG+GbKomlMReDm4LfphTuxylYQ+faHAZa5lc
	H6y/xOHKN+VsuNQ9MEzZTC6qqkhAZuyS+iU1nUeCy+7yj0UOWbd83vl39QmzyODsjuI95LELNBCcu
	UWTbz/D9ClGLcT5DKCDWOhDaeBuGQXtlYleQKlrGaTtVpm6Gm8oNkydKTWbw9WEOvAgDhSzzkiq9w
	Q1wiyN9VPTi/cDsp2o61B+nq5UGQGmf8WliR9VPAEZn0ljV08oEA61haF2c+id7S51grkP4nmZvDM
	NxT4og9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8JDT-0000000HJ4w-2dKN;
	Fri, 25 Apr 2025 13:35:43 +0000
Date: Fri, 25 Apr 2025 06:35:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v3 1/3] btrfs: convert the buffer_radix to an xarray
Message-ID: <aAuPr5r1AT-uT4B5@infradead.org>
References: <cover.1744984487.git.josef@toxicpanda.com>
 <bb6d4199948b4822a837fd2b9716fbb660e2ada6.1744984487.git.josef@toxicpanda.com>
 <CAL3q7H4Y0r7rLbNEv-QdN7_tCHh4grh2XJez=qD2nO-DTFs4ug@mail.gmail.com>
 <20250424154719.GA311510@perftesting>
 <CAL3q7H6Nbar_o0GVGuTr5BVmCRsDUgAJfnOz-hSi5OEi86jejg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6Nbar_o0GVGuTr5BVmCRsDUgAJfnOz-hSi5OEi86jejg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 24, 2025 at 05:07:29PM +0100, Filipe Manana wrote:
> > Because we have to do the atomic_inc_not_zero() under the rcu_lock(), so we have
> > have to open code the retry logic.
> 
> Sure, but xa_load() can still be called while we are under the rcu
> read section, can't it?

Yes, and that's the usual pattern.  The double rcu critical section
still irks me, but willy correctly says that it can't really matter
for performance given how cheap it is.



Return-Path: <linux-btrfs+bounces-19778-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3B7CC1A3B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 09:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E33B2306A053
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 08:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352A2344023;
	Tue, 16 Dec 2025 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GoJFfe6v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A6A343207;
	Tue, 16 Dec 2025 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872108; cv=none; b=eZBmkbczY62iwlDEyHaELQ5TygVbglgKwOwpe+eecQUuTyoi3I4vpsvylwHLsR1GJfHO3zmkRczAa0PkNS93mybkkr05CgXjCSRTFddRYxgmT7HJ2MFF4EVpBStKllJz+kalSczX/HdV8iHfyVao7FLgQiT/6losi4mzkpgPOQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872108; c=relaxed/simple;
	bh=cJ1/cd1GkaswNdFbXZHo97/g/Mk6AXJlqZcKJEA9j/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKK6P7Pw8m0aYnIg8RjTA0OFsQGlkvtjAWOHcRY/rFbLIXojnYBR/4xwtHWFTtAGETKcwf4TcOA6JRj5pdRsGynP4Mcn75UyEKmJm8JECK321NKsWEf/e11XdEMhJYp26VsD/WW8OVFy/F2Ev1p1ABCgAN56gzuwnPvKnFm8R34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GoJFfe6v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cJ1/cd1GkaswNdFbXZHo97/g/Mk6AXJlqZcKJEA9j/I=; b=GoJFfe6vJQk065jCcos4k4LYLn
	pGxidu+xNFslzsD2Yd/ZmcZMHvGMyh1kz+UIBfBky45Bk6aPkeBxAG7OY13/xzFrLmPdeGAJk94Gv
	TmeJwfi1VVy3WcO0hu4lbPuWIaZBs0CMTAuVZDBg4VLN0FpWFCfQZv4Rlpe0gkYr6iAqU/oG78JzB
	+fuLHsTR7ESS99IRVCkhhjg+XE77HIe4eNn3566ot8jVrtGF1vHpjNeiEiMJnbUONiAzChJjpuHU7
	Z5IT06WDAfiZs/7fQ04KfiCq3PwJTNZZ7q0FIrl0MTCgqboT6F5MxsbOdv8KA+bXOg+8ysTGVnlvt
	iII620QA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVQ09-00000004tEc-15G8;
	Tue, 16 Dec 2025 08:01:45 +0000
Date: Tue, 16 Dec 2025 00:01:45 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 12/12] bio: add bio_endio_status
Message-ID: <aUER6ZMrar0xMunp@infradead.org>
References: <20251208121020.1780402-1-agruenba@redhat.com>
 <20251208121020.1780402-13-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208121020.1780402-13-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 08, 2025 at 12:10:19PM +0000, Andreas Gruenbacher wrote:
> Add a bio_endio_status() helper as a shortcut for calling
> bio_set_status() and bio_endio() in sequence. Use the new helper
> throughout the code.

Looks fine, although you probably want to either feed the users through
the subsystems or did a scripted one right after the next -rc1.


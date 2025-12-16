Return-Path: <linux-btrfs+bounces-19776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1465CCC16E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 09:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A93130117B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 08:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A96933A019;
	Tue, 16 Dec 2025 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JILpkSH/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAAB339B5A;
	Tue, 16 Dec 2025 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872004; cv=none; b=Igi0sBrcIJzQMSBEVeIDf1xb3IzRai7Aamd6pzuLUgBY4YCurnxOnAjHN8iLeGMB4zQuJw2QqkNIPfzgEdbB5XUSFyDtexHkZ9JxzTJUbSJe7ESBCw9qYnyNgTCRNcJbR5JhuPv4lcbJtOFKNMdMblajkJEgVCUho0NxNbebtT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872004; c=relaxed/simple;
	bh=v0ygWbfCRKw6OYvtsyuLGvyt4s8+gVMQijGUXQtfAfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2f91b0AxFegv++x1xIqS4/L5WfJZJEwHt+IxqoZc5wrTqdxR0gFhPALvJ2HL60kr+BLJIqYeZ1fZBAWnsPFaEacjaIvv/KM0I9uMg7GQ5pkm9OLseo5BH2OzCjg9cL17Cspbvr7DBUqvzcUPjkFDDO5ooKBZrKjteuclTpszDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JILpkSH/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V/H3+oYrJMchGU028iIDFJHVviO8NUh2RvIph9SX79o=; b=JILpkSH//0z6bNZjNe8DcNQ5Hz
	bP1OIPaJOLyUj93gKGxiwcHlA5Zx6SmkBpa1zTQg+rCfR34fTeZUaOougiiOG5vhgYO0xsfHTC8NK
	wTAOZzH4thSTKUIc+vx04eA3cLhHg4zvHVbx7QpS09iQqGHAYQTHw1uK799dmTIRhW90/BK+6Yxq0
	RclAOvI2lmZ5Ooi5cEp9KiTt6oAxTriDVyJzz7R6Lkoursi6Dr/cMxqv04Eax9Vp9hFRfAwz2c8oX
	PUNOSs43FYrY0jcX1ARv1EbMubYvoKiBH9kd/X0NN2YmMBOkrw+DgO9hZfcCuLwY+VTJ9udPW5S5P
	WM3IZvww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVPyQ-00000004t3G-3NDe;
	Tue, 16 Dec 2025 07:59:58 +0000
Date: Mon, 15 Dec 2025 23:59:58 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 05/12] bio: add bio_set_status
Message-ID: <aUERfrewTvjoy0K-@infradead.org>
References: <20251208121020.1780402-1-agruenba@redhat.com>
 <20251208121020.1780402-6-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208121020.1780402-6-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 08, 2025 at 12:10:12PM +0000, Andreas Gruenbacher wrote:
> Add a bio_set_status(bio, status) helper that sets bio->bi_status to
> status if status != BLK_STS_OK.  Replace instances of this pattern in
> the code with a call to the new helper.

Why?  Also the name suggest it is the canonical way to set a
status, and not just a helper to set it conditionally.



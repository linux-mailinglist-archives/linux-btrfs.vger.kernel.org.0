Return-Path: <linux-btrfs+bounces-19774-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D94D4CC1699
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 08:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4AC06300775F
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 07:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A803093AC;
	Tue, 16 Dec 2025 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vvxqjVzy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65871339716;
	Tue, 16 Dec 2025 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871896; cv=none; b=bBFCYNX6yA5FtR2KbbmFhWeRT5UeIqOVdngMpPA/UXGeqsu8oj1k5nfps14jOT//dEs/Bp/nwYyS1kyfR9nBjSEHh97NtasE7kuq7//q/Cd9CH00Zb2kL6jS0CAuv9cMIsiqukZbXt7gEgodjcDnZ0nrXBIRx4QOJfJ1J0BUi/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871896; c=relaxed/simple;
	bh=n4Sm2yvCLEI213C12wWVeQ3WNj8XOVaRGPE+ccFj0q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpUu/TW7OS9ge4VT5OQkJwBO8v6P7Y5tjRwgzkOAWbTpRz0GwYrNbtj8XuqmmuPdVyOpnN2ofl5aF0T50vWF2pDpFtstnnQz0mwnjyDls8UewDzD7K1lngvXZoLNElERoJ1SHd3juRbB7Zl4hA7MZiwnluk4Xc/e0osxO+D98Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vvxqjVzy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BSBKXp9qM/FlzOdk8G2t4Ih6r2MzYo5fVVW13bA7MNM=; b=vvxqjVzy+MzezpVLqjioeLAvti
	vV8tr5iQvAsaIj2paFO1CdxraiW+K+G/V6s7yS0+7OVgRwleQXNdL4UE7wUHko6aT3QCoBN8P9g7L
	dlwSqMhsxQi08OkUU97WsU7N6Dt1ud9H4wgc2Ljc/W5nDq4oicP2Fv4YZm2wO+VF90OAYCWtwRJ6A
	dawi9I/V/v+5wyKhxwJgqnhcjU9e6S4UkDP6ZsuR/0vQZG8MND9UWy/6aN++Tp2RgpeIJxOcPb0Cr
	t2DExQS4MMLBK7zTOYe/JFnTT8fqVmqPFNGNL4y5yjbynlSZc6ovd3UIU9yvcz7p1bCnXUzL2ayfl
	MaN4AbOg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVPwh-00000004syD-0vd8;
	Tue, 16 Dec 2025 07:58:11 +0000
Date: Mon, 15 Dec 2025 23:58:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 03/12] bio: add bio_set_errno
Message-ID: <aUERE4HJN_ek4Eba@infradead.org>
References: <20251208121020.1780402-1-agruenba@redhat.com>
 <20251208121020.1780402-4-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208121020.1780402-4-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 08, 2025 at 12:10:10PM +0000, Andreas Gruenbacher wrote:
> Add a bio_set_errno(bio, errno) helper that sets bio->bi_status to
> errno_to_blk_status(errno) if errno != 0.  Replace instances of this
> pattern in the code with a call to the new helper.
> 
> The WRITE_ONCE() in bio_set_errno() ensures that the compiler won't
> reorder things in a weird way, but it isn't needed to prevent tearing
> because a single-byte field like bi_status cannot tear.

Not a fan of this.  We should not be doing that very often (and as
seen by the diff don't), so don't add a helper for it that makes
people do it more often.



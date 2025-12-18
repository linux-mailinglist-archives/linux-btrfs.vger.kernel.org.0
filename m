Return-Path: <linux-btrfs+bounces-19855-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E7CCCB044
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 09:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48BF4306DCB2
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 08:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8076628850C;
	Thu, 18 Dec 2025 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HzPXdY1E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC5E3A1E88;
	Thu, 18 Dec 2025 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766047679; cv=none; b=IGtdUIuterZj2204OuGarwjNCjX/PIZXg+sdd2ZLUMFkRRbte495qWDqdJNkctng9/xxm/vwgpjpDFzTpdFVQe0SnBp00tetDSZdBZfrk1tqkosPg4doIHjECEmOpoiQISNju4M1q0O16/6ZxrwIuZ7imlCxT5AcpK3iVcKLUps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766047679; c=relaxed/simple;
	bh=S9m2zboCLwOViAtMp05VLj0OKcnpua60sdXGdiJmv4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiR19qLE+pRRMklUD2Ml1ADwArGv2oEtUKd2mnbODWH85nYxILw1AxparW23nTSYz/OXB3/SnkFcP+pqmN5uBSYPKoRJhoLH2qrMfgGZQCnF5wnpUZZj9nXLUfKB8GlRM0hRstjEZgB436EpZAfre/YWqvYj2Zr7f3RcIDXkbgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HzPXdY1E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rCQQPidAxdKKerSDTyfXQFaHt7qwdYyK9WOnuxBnaW8=; b=HzPXdY1EmDxlbqXcSXLgDelxN1
	1DpWP+/VdWzLkvwNVphiNXdykRZcyAxngokvBdZdmeMhLpDdb6IDnoBiTYm+ohsAew7/uPJ87tpZS
	y4M8zcfzjlezbo6JgKCd6J3SgmNCkrECuQT2AZlbC+RCRvVa19ev9xYbmk2hlfXzUyG7vngDQy+AL
	CFyjyBMTZTFvTIGxSr9hgXUUTQlfPqSoV6unpF92hqGA2PwfietvG7fZ25io5XTIihEF0l7YrNU9z
	XjydrU1ijVUV16tcaBs9u+mVrNzcJcQ5SLTSv6mOHR0vS6ZA0HOIcRt9olgL1druq+VvMK8iHNiH7
	HiErgalg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW9fv-000000085jq-0pIy;
	Thu, 18 Dec 2025 08:47:55 +0000
Date: Thu, 18 Dec 2025 00:47:55 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 06/12] bio: don't check target->bi_status on error
Message-ID: <aUO_u7x-4oIfKMei@infradead.org>
References: <20251208121020.1780402-1-agruenba@redhat.com>
 <20251208121020.1780402-7-agruenba@redhat.com>
 <aUERRp7S1A5YXCm4@infradead.org>
 <CAHc6FU6QCfqTM9zCREdp3o0UzFX99q2QqXgOiNkN8OtnhWYZVQ@mail.gmail.com>
 <aUE3_ubz172iThdl@infradead.org>
 <CAHc6FU4OeAYgvXGE+QZrAJPqERLS3v7q64uSoVtxJjG0AdZvCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU4OeAYgvXGE+QZrAJPqERLS3v7q64uSoVtxJjG0AdZvCA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 16, 2025 at 12:20:07PM +0100, Andreas Gruenbacher wrote:
> > I still don't understand what you're saying here at all, or what this is
> > trying to fix or optimize.
> 
> When we have this construct in the code and we know that status is not 0:
> 
>   if (!bio->bi_status)
>     bio->bi_status = status;
> 
> we can just do this instead:
> 
>   bio>bi_status = status;

But this now overrides the previous status instead of preserving the
first error?




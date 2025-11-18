Return-Path: <linux-btrfs+bounces-19085-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F3FC6A3AA
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 16:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE0ED380FAE
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3FD35C1A4;
	Tue, 18 Nov 2025 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qQSO2w7b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7743254A5;
	Tue, 18 Nov 2025 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478511; cv=none; b=Y5JjFGmkfU/JSTpHHsFJa8DnpkxRlphRJIDsPJ5qo4jb+rZCvLrcF00gor+t6KHzcyl3jU2VUZapceKxH5ZfjF24+XlZck/5QAwlxm16G35y8lfOgNcrVKXT65kE5piuTEGFuX4D7qI1deQ1RTANvfWPwS4HYGSwBUk5jRgNev8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478511; c=relaxed/simple;
	bh=xjhJIscbzEXNqtd3VktCrcCPprNkcq2+MArvyEgsFEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oO2kVCKSz5mGPAP1XgqOWFOS5GRtgk186yeFBbH+NBcDdKMQGzfSjkJMa1souLJx/cprCsWa1YZpH9PT64f8UaD76F8zeyT/vqtHgxb3t7DPmyKg2B7+R/zuUEILOE81UxPUYEyHccGrYqr/SAH1K/io1kmCG1srHRhYIBn3rKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qQSO2w7b; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ISfjYzm+3RexgEyAPFvlNzALDBS8EfH9HPw17pecoME=; b=qQSO2w7bGGC2i+htf6qrAobNgX
	nwNy1HzRZ7pNssde6dLrElY+P4GgrWcMgn/KUBpsNDTMA4Nr5Q3mU3Nd9R6IFx8NgGTBVFivW5jya
	dPBD0RN17gYyG+x+ftgAgWgIfA+GAvmdL5deEuOR0u4MnjXZGHd38fvPiPL1P7FQskEiKK+S51jF0
	OLWpFDnBR4sSvVD04sZno71BECXrvWDzDkfR4LgL5zGX8yLMXvZ4VAPwAoay6N4xDDEyDUqKtvPB/
	3JlRPko8MHotwx320gxSH5q9T15mR8WD/1kEiv16BEVflnFXuEVCbus3wkKA5v4qR0ocJypMHODAf
	rLIr2fNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLNJh-00000000bKl-253O;
	Tue, 18 Nov 2025 15:08:25 +0000
Date: Tue, 18 Nov 2025 07:08:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Vacek <neelx@suse.com>
Cc: Qu Wenruo <wqu@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/8] btrfs: add a bio argument to btrfs_csum_one_bio
Message-ID: <aRyL6aw9rxqdVssl@infradead.org>
References: <20251112193611.2536093-1-neelx@suse.com>
 <20251112193611.2536093-4-neelx@suse.com>
 <7de34b24-f189-402a-98f9-83e595b53244@suse.com>
 <CAPjX3FfMaOWtCZ8mjVTbBQ9yt0O-mAistyDsVq7Q1aR-65R_hA@mail.gmail.com>
 <492ac26f-5eb4-49bf-855a-11f021d9e937@suse.com>
 <CAPjX3Fec=qAtWjPNvszKdww=giCUEgoMULc1Zvd37k03VUaUmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3Fec=qAtWjPNvszKdww=giCUEgoMULc1Zvd37k03VUaUmw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 18, 2025 at 03:05:25PM +0100, Daniel Vacek wrote:
> But giving it another thought and checking the related fscrypt code,
> the encrypted bio is allocated in  blk_crypto_fallback_encrypt_bio()
> and freed in blk_crypto_fallback_encrypt_endio() before calling
> bio_endio() on our original plaintext bio.

That code is getting major refactoring right now, and allowing the
file system to hook into the submission is a possibility.

The problem is that I have no idea what you're trying to do as the
context is missing.

In general prep serious should be self contained and at least borderline
useful by themselves.  Adding random dead code checks or weird arguments
as done here are not useful in a prep series without context, they
should be close to the code making use of them to be understandable.


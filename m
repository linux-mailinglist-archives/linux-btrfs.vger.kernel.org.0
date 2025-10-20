Return-Path: <linux-btrfs+bounces-18064-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF08BBF1F06
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 16:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E6C40834D
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2677422A1D4;
	Mon, 20 Oct 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnP8j0Q5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6075A225397;
	Mon, 20 Oct 2025 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972089; cv=none; b=i4+psIGnOEvlJVXDVwxOzfMLbzlGPEHFRYKO4K3XikoCyp2vONpd6IU5pS6FhFiS1X700Aa7JPtkj7VfJe69O0TRv7mKvXaTDSc0jAfNrKWhIW+qSSQnWUksnN/YiQrbQdUJTfdzFsmFvgbWBB8b1scr2SgBPTUn82qumVPEfwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972089; c=relaxed/simple;
	bh=rcPPjejAyHVhu1UE3Ij+4ExIsOnooCq7sabSXauPhsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdnDS8xBwdnENOLjQNkU+aqVuhwPvhysrb3sgFoR2v50OpdQXDoWzrMyGPiGgAzc5080nP58vgdFVKAMPSn/JdlcSOoZjMhPmEr6pVMfPCCrKE+FtTTaNHzuVy2cUXeuz2u1fVxcqwbEdYt8ImSxETZG+qXlCua2ZtZcrRa6oYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnP8j0Q5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98629C4CEF9;
	Mon, 20 Oct 2025 14:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760972089;
	bh=rcPPjejAyHVhu1UE3Ij+4ExIsOnooCq7sabSXauPhsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnP8j0Q5pYG0o96FflixfPcogUdK99h8jXJobHG2bktJnsKoDccKBrqygEYrRT9wr
	 A1MxXL6jV+dGFbrJkCs+ovYXU+UKXqkA5NGlGQ65BzlAUZEbyVWKJFAq7GjeWk6lc0
	 aOjahCOo3i8wYjZ7QyuoocX9qUSSC3QH9VVuIXAjC++R193geJSqmgpcRJWJk1yrPt
	 o1b3cgwVdoAd0eI991tU8ZhO4u4dj2Ye4VOZS7VUSuri5KOIU+jUDWlrobRiEjEuh+
	 2mstM1DUgvtk0xT62Y7U8CZzGkBPEKBmzHUh5F25vvxcnPVMCJWqyvd8PlEhimX9xi
	 TO2axZRH9kDUg==
Date: Mon, 20 Oct 2025 08:54:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, dsterba@suse.com, cem@kernel.org,
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
	Chris Mason <clm@fb.com>
Subject: Re: [PATCH 1/2] xfs: handle bio split errors during gc
Message-ID: <aPZNNkSOYr88-8VF@kbusch-mbp>
References: <20251020144356.693288-1-kbusch@meta.com>
 <20251020144522.GB30487@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020144522.GB30487@lst.de>

On Mon, Oct 20, 2025 at 04:45:22PM +0200, Christoph Hellwig wrote:
> On Mon, Oct 20, 2025 at 07:43:55AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > bio_split_rw_at may return a negative error value if the bio can not be
> > split into anything that adheres to the block device's queue limits.
> > Check for that condition and fail the bio accordingly.
> 
> Ugg, how?  If that actually happens we're toast, so we should find a
> way to ensure it does not happen.

You'd have to attempt sending an invalid bvec, like something that can't
DMA map because you have a byte aligned offset, or the total size is
smaller than the block device's.

Not that you're doing anything like that here. This condition should
never occur in this path because the bio vectors are all nicely aligned.
It's just for completeness to ensure it doesn't go uncaught for every
bio split caller.


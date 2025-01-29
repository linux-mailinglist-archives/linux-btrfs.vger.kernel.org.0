Return-Path: <linux-btrfs+bounces-11151-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0078BA2207F
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 16:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B99718882AB
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 15:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18BA1DE2AA;
	Wed, 29 Jan 2025 15:35:32 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D561487D5;
	Wed, 29 Jan 2025 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164932; cv=none; b=dEkGeN/ahB6/TWlIqVP5JldporkOBpl9x9o96G9EXGesLQXoO/ZwSfSwjDc602a/Cu8j3DxSsYbrfPVQi7Dz+upuLCEeEAxPmjLlRbp3ZuRx9JiiTx4IgElRN6yywR9omNZTYk2LnNDqTXDrwpRntXuvT7mGreVw9hr+vGM/H8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164932; c=relaxed/simple;
	bh=Hg2K/eseLEZRWgc7c/Nmp80AODYFehs5no2eUBYax1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTeOshVIDWeyIaEow1/0kJ591QmTI3HIi/gGByeUh+L3xHwt3ElIQXp+9VogAAUuyA2npwujY2EHgxI/Mf6uRmnQbTzrSktxQrYVZDEF++yYy/2v6c/h0SugLu08GQ8zTWqePNBj5gOvWgOXjBCewBtk5B4j2qkHfxLdrVYw8V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DE6EF68D07; Wed, 29 Jan 2025 16:35:24 +0100 (CET)
Date: Wed, 29 Jan 2025 16:35:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <20250129153524.GB5356@lst.de>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com> <20250129140207.22718-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129140207.22718-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 29, 2025 at 07:32:04PM +0530, Kanchan Joshi wrote:
> End-to-end data protection (E2EDP)-capable drives require the transfer
> of integrity metadata (PI).
> This is currently handled by the block layer, without filesystem
> involvement/awareness.
> The block layer attaches the metadata buffer, generates the checksum
> (and reftag) for write I/O, and verifies it during read I/O.

That's not quite true.  The block layer automatically adds a PI
payload if not is added by the caller.  The caller can add it's own
PI payload, but currently no file system does this - only the block
device fops as of 6.13 and the nvme and scsi targets.  But file systems
can do that, and I have (hacky and outdated patches) wiring this up
in XFS.

Note that the "auto-PI" vs "caller-PI" isn't very cleanly split
currently, which causes some confusion.  I have a series almost
ready to clean that up a bit.

> There is value in avoiding Copy-on-write (COW) checksum tree on
> a device that can anyway store checksums inline (as part of PI).

Yes.

> This patch series: (a) adds checksum offload awareness to the
> block layer (patch #1),

I've skipped over the patches and don't understand what this offload
awareness concept does compared the file system simply attaching PI
metadata.

> (c) introduces an opt-in (datasum_offload mount option) in Btrfs to
> apply checksum offload for data (patch #3).

Not really important for an initial prototype, but incompatible on-disk
format changes like this need feature flags and not just a mount
option.


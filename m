Return-Path: <linux-btrfs+bounces-19513-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CF7CA2FB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 10:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C55CD3033CB3
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 09:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F76B2C028F;
	Thu,  4 Dec 2025 09:26:57 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D6398FAB
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764840417; cv=none; b=vFaT5OrZ4l1VTateuQFCL7qDtZ84tyUSDVD4PZQR+mGz34m6cbWazIqAUDUQsyznxlRIvHPyTyxygeRcYNmNB+1bQAVGNwIKvgaA3M9UYdXq93+Nwz2CrCFLl5mwPHxhhhRbQMXlmZrFoqTAn1Lracyq1FI1cXzUohuZW7nCBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764840417; c=relaxed/simple;
	bh=F76ZkLWEtSNFT7n8fM4Fjy2s+Y+0YYsN7gad5hW5RBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBnMWc2RNrTZz02XftLlxJf8kjpnpf9Ko9MmlnYfa1QW2Js9rQPhJP60KgaeJplueGA5rMmf5g9yEQjfXrdT25uQx4Pfp4dbOc+2UMmEfM27bGGjAEHUITQcZX673TU4SpMGN2FAFZDE2+ifoN6Hl4KXfEe+eDvyW86Wil+00BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 16D2F227AAE; Thu,  4 Dec 2025 10:26:50 +0100 (CET)
Date: Thu, 4 Dec 2025 10:26:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] btrfs: zoned: don't zone append to conventional zone
Message-ID: <20251204092649.GB19866@lst.de>
References: <20251203133132.274038-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203133132.274038-1-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Dec 03, 2025 at 02:31:32PM +0100, Johannes Thumshirn wrote:
> +++ b/fs/btrfs/bio.h
> @@ -92,6 +92,9 @@ struct btrfs_bio {
>  	/* Whether the csum generation for data write is async. */
>  	bool async_csum;
>  
> +	/* Whether the bio is written using zone append. */
> +	bool use_append;

The code I'm looking at doesn't have async_csum yet, but with that and
the existing bool + blk_status_tthis would grow the structure, which is
a bit unfortunate.  Either make these bool bitfields by adding : 1, or
just pass the flag on and stash it into async_submit_bio for the async
case.

Also given that this doesn't always use append, maybe rename it to
"can_use_append" ?


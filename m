Return-Path: <linux-btrfs+bounces-14444-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4573ACD9A9
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 10:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 130BB172F73
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 08:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FBC28C2B8;
	Wed,  4 Jun 2025 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wWkXLDnw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5328C2A5;
	Wed,  4 Jun 2025 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025511; cv=none; b=JKzbsrTZQxSr1EvHNPGSTPtENmd+tmHg3e55qvv8qC+SPNaz9rYJ8f3CHvjMKtNylx/xSXohZ8iLcY1XVsggXLkc/l/X+HDb5GIkAyWOei1owExmII49no4gNFfb0Tnv+fag6ZePjklFK6uQ5B7BmAlCQmuQKD469AqGmJnlEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025511; c=relaxed/simple;
	bh=3ywT3RoV+xLWUG8Cr2/ett8G8XgAP9+g45c/12j+2vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1eMdecDL91Dp6gvokcq3TiNvbfPSIbwfgYD/IxdL02efEAusG8UzpKBrjTusAzCUw087H/ePfD6+oeDFwRuSXFrMt1M5bCUPvzw/EjXC6ZhlAMFtJmrsZF2yZ15lAIUp9hd4vjy0vNobA1vJZ3E11a//3XoDCdYAlMo4+GeoJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wWkXLDnw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vdGSCIYGV/Pkvjqz+zH80qyfgX8EPfu2SxA5W7Box24=; b=wWkXLDnwtOzp1S2iKoFw3JuvwI
	VIRZjG9o6gaAJ/H6nmDbgPhElTt/i0NzkMVEAjGrXk/0e3k+ov5hpEgthjRf9xusg/WmKtqitYNz2
	0FEh1zDyC195YspfmrwkIsfmu3XASGEcSHMEQKLCRAhAcql23XLbSbxT2dzuXFOUyTt07J7geSgfm
	xdGsHRQv4NVsIdKB1cyGygHbjiJtC90JmizclmapNiQJUeYzjOGT6h5K1zLApLZRee470vG300euT
	k0Bve/zy/VkuacWl+KlvNYKUh4HORL+4ZoERwczUfV7g2aVZY/GR8ZuisDBOS01/+mC3SGxrW4bIG
	+QhrT4Wg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMjQr-0000000CtK0-1RWn;
	Wed, 04 Jun 2025 08:25:09 +0000
Date: Wed, 4 Jun 2025 01:25:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/730: exclude btrfs for now
Message-ID: <aEAC5WTF_tGh_RpN@infradead.org>
References: <20250604062509.227462-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604062509.227462-1-wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 04, 2025 at 03:55:09PM +0930, Qu Wenruo wrote:
> - Btrfs doesn't support shutdown callbacks
> 
> - The current shutdown callbacks are per-fs

The callsbacks are per-block device.

>   Meanwhile btrfs is a multi-device fs, it needs to know which block
>   device is triggerring shutdown, and needs to do extra evaluation
>   (e.g. can the remaining devices support RW operations) before
>   triggering a full fs shutdown.

Exactly for that reason.

> +++ b/tests/generic/730
> @@ -26,6 +26,10 @@ _require_test
>  _require_block_device $TEST_DEV
>  _require_scsi_debug
>  
> +if [ "$FSTYP" = "btrfs" ]; then
> +	_notrun "btrfs doesn't support per-fs shutdown yet"
> +fi

Please don't add these horrible fs excludes to tests.  Add a helper
in common to check if something is supported.


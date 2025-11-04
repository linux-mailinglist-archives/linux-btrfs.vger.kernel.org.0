Return-Path: <linux-btrfs+bounces-18671-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D56BBC31999
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 15:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B1B14E8D53
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 14:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0434932F75C;
	Tue,  4 Nov 2025 14:42:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB232E694;
	Tue,  4 Nov 2025 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267325; cv=none; b=qwh4+WzIBe6Bpno/XhWcFplW48jsKGWwr4kbC7hOCFvMg1mM522SzPGt6/J3MmnAPAVxnyTM0wLw4QYhj6Qi/cW4zobxH23S274XSMyZgxfDyGcmE5VCA6L1DtT9a6+DzFE6J6h4S01FqV+dTOMvGIgh+TcCb8/+AR8guFoj98o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267325; c=relaxed/simple;
	bh=tCfDuD4tZdVerUe1Dhm+w5PrK+7s8k6DKAyP3vf9Eo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKSlZfh16dotceP6ArqhScR/kdbv6ybMXFb9Urmu0iKsCIprvAzDdfpzdrPVZB+jeK7RIUAdaeGKwCkzqE/rFUwmXbuDatQI1zRF0mezfdk6ub56p+oKFok93NKHThXgeG+TIwuEUrEycldZmDI/egZ/+5gYgTTmbX667OX7JlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ECAAF227A87; Tue,  4 Nov 2025 15:41:58 +0100 (CET)
Date: Tue, 4 Nov 2025 15:41:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>, dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v3 00/15] Introduce cached report zones
Message-ID: <20251104144158.GA27416@lst.de>
References: <20251104013147.913802-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104013147.913802-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

I just threw this into my xfstests setup, and it seems this version
is broken somehow.  Running on emulated ZNS devices with XFS I get
a lot of failures with warnings like this:

[   30.068652] XFS (nvme1n1): empty zone 1 has non-zero used counter (0x1).

[   49.316873] XFS (nvme0n1): empty zone 2 has non-zero used counter (0x10).

so it seems like it's not tracking WPs correctly, probably when using
zone append and unmount/remounting.


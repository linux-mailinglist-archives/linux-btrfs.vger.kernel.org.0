Return-Path: <linux-btrfs+bounces-12364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D464AA66D61
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 09:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947DD188C577
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 08:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DAA1EF379;
	Tue, 18 Mar 2025 08:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ROdvSX8J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217241DF727;
	Tue, 18 Mar 2025 08:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742285045; cv=none; b=DbPlIsWCC8+PTfibhY5spAUV4B+ZVnB3YEmFuXnF1d2Vd4Gk+yVsvYEfPBg89XfDByBikUuf7xWClOK44upRj2+/VvAfkH/JmhpK3m4oKbLo3dD5W0iynloAnDcVzaZ8hg7JMGVCXEHl7R9f3gPfsIM59uD0waccIqW9e9SmW8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742285045; c=relaxed/simple;
	bh=FxCRW54eSixUHQ6nWtAzbj001cbTNF9ZD7hu+tcX6Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfEWbrhHKcpwAikqA0/64KttAFcXYKfE1yp9E8UzooJDNKUqttEHy4hw75slvuLZRVrxd0WFcfVyrh5HDHIkcABFUVEfrDd96HyrMoJZtY7l+XRGOpzruW8NfCAnLRQqgvPHk3gkk1qEmSKr9wL6PZCnjOYAft1JWP4Ua+QuR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ROdvSX8J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yhR7OSLVPuMDeiJkl3i+sVda17o7SAUZihv+epgJtas=; b=ROdvSX8JL4P7SZKDbzgGKd43Bb
	oIDV9xtmsybTouzx+YsRKlCFRKQfiPbla91EHtHM2mD2XJOZTNphU6Tw3ApEzkvUMxreHE+f7/uPg
	67jS3foq4oC1na1xVjQOI3MzqK7rrxoqkmCltVWfieWNdqCxNnVgQhhXQGXTkZE3N/BcBHdXqvZF1
	a51U5YMslg7/apTYAfUVSmrjtm8Ntgw2y3zAs4qBGMemIUNiwstRcHydY+GzhmsIMdaZMBwxbR6Ne
	MHIJW/ToNpilubAUpZ6CrvjY5wKlEqenXpKn4kanmVo4i56QtnQr4LAcHXzwADJ6ZXrUYu0mX6V3/
	96dZt27g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tuRvf-000000055D5-39zo;
	Tue, 18 Mar 2025 08:04:03 +0000
Date: Tue, 18 Mar 2025 01:04:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/2] block: introduce zone capacity helper
Message-ID: <Z9ko8wB1dc8vTHKw@infradead.org>
References: <cover.1742259006.git.naohiro.aota@wdc.com>
 <e0fa06613d4f39f85a64c75e5b4413ccfd725c4b.1742259006.git.naohiro.aota@wdc.com>
 <2a641d02-1d59-4e0b-9dcc-defb64548d1b@kernel.org>
 <Z9kKfpY0E-phdJ5G@infradead.org>
 <b527143b-6528-4817-9f48-9ee7ab874989@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b527143b-6528-4817-9f48-9ee7ab874989@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 18, 2025 at 04:57:45PM +0900, Damien Le Moal wrote:
> Given that this is not a number of sectors, "sector" would be the right name
> then :)

Yes.  That's what I meant, but I obviously can't type before the
first three coffees of the day.



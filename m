Return-Path: <linux-btrfs+bounces-4415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BED968A9D7F
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 16:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3671C21B0B
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 14:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A49165FCC;
	Thu, 18 Apr 2024 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hXkvGczq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1011411E4
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451648; cv=none; b=oL3AqHnOb2ohpWbfnk1s3iYpTWUaTd8/+yc7US8olbeZveV2YFobPQn8kQ/QnxORhBkhmo2Fq14nvcA9mN+ccNtOByMJx0VVlcpGx9g0Henk18oB4Jl9rQzfEP3VDi7C0Y3r4K9X1iwfPxIlzgVUFkr9TJ6ridhssPC9GW0wDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451648; c=relaxed/simple;
	bh=apbDxdWo5kASX1D3Av38T4/cp7gpkBUZjNzEiwR/gkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDwxkxlAjI1Fum7ahxBgcX6TGApHZ7jPWqjtbJfxO10QTg7SuFv0grEUEC52d5eEZWH4yIrin3sXlRCEhpFr/mPR42Kx3CVzNHonKOkwXYMZ6zqc49nyp01wwC58x5MJ97Do2HmrNu2IS1uMBuX51lY1tRf7XWcQ/EcEVFdfG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hXkvGczq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UmUsfUPLD+U3hE6JS7/7xpVxj6/uofJbyDE/XttdpFc=; b=hXkvGczq7e3iZxyDpjZvspIiqV
	x+366m/AlzyKeKodUtgercynLtsJyD9ruqirJ8tmB3ZHP7swXXLfVkMGvnKK09LwcTKCLQwqJZXQG
	o/wflr9iSAKcwGuIc+EVwiXy0LaG0D3PzD3shx8JYSvH/LlhPKQZ4W+3ZDb6il5f4r7lm9E1w4SIv
	0SFwsf37w9uA8H7wqA11RKLd/8NWu8zA9oCDPSCVcFIrm06/tjg+4ZScz5FT5PIRhTHEBMmEUgCAF
	64PAJIYUm1mDxCOM0mD3NHGeQgeyhwOCRoVvxBHunw7WCI02Zm0g9aqLrGz98YOXWIUwg4bmVqUgD
	eCDrlDRg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxT2s-00000002gb3-43QC;
	Thu, 18 Apr 2024 14:47:26 +0000
Date: Thu, 18 Apr 2024 07:47:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH 00/17] btrfs: restrain lock extent usage during writeback
Message-ID: <ZiEyfvCOrlsIgtiR@infradead.org>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <ZiC1hbcG4rFFz1BM@infradead.org>
 <qjy6xzmwpggluuwbgu4aljweoiwnrowvgklw6trn6tvwyk4wqi@akofzgx2tnms>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qjy6xzmwpggluuwbgu4aljweoiwnrowvgklw6trn6tvwyk4wqi@akofzgx2tnms>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 18, 2024 at 08:45:35AM -0500, Goldwyn Rodrigues wrote:
> The only reason I have encountered for taking extent locks during reads
> is for checksums. read()s collects checksums before submitting the bio
> where as writeback() adds the checksums during bio completion.
> 
> So, there is a small window where a read() performed immediately after
> writeback+truncate pages would give an EIO because the checksum is
> not in the checksum tree and does not match the calculated checksum.
> 
> If we can delay retrieving the checksum or wait for ordered extents to
> complete before performing the read, I think avoiding extent locks
> during read is possible.

And the fix for that is to only clear the writeback bit once the
ordered extent processing has finished, which is the other bit
making btrfs I/O so different from the core kernels expectations.
It is highly coupled with the extent lock semantics as far as I
can tell.



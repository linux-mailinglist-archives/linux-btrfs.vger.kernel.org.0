Return-Path: <linux-btrfs+bounces-17249-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C8DBA873C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 10:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A12277AAED7
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 08:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE3527A925;
	Mon, 29 Sep 2025 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="heEYOVJO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F11C4502F
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135786; cv=none; b=cKZeE1M4Md9LfpbcTeG1BlGZBYqfS8ors/F/EwORVbQZJilNbKPF54fqGtEW87j+Lx8M3ucVUFa6307Myn5UG4+H0FHlXf1kYHEMdkcDBXzCIT0H5/jMnrvVpkfc/nDoJ3mmIbxhNCQaFRqGVPI9htJXM2BY5ouDTBRoAYnCZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135786; c=relaxed/simple;
	bh=3OQT1RR5R7jWsyet02FY10AiuKpuv4HxZ5rRhly5nOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NORMdsl8QhBzJcSHFPRPyQIZbffZQ2Ro8lWkMXBfMmV2l2BvXgrJS164U/nphUdbOBDi83HCsoQT9SiWRr+WgNfwNdAkjgZfr6aUJn/1yaSc3fgxcfXbgvKpvhcG8tu3CHP29wfC9xyHzaHwE1Gu9DXeIrNzzu15Gb5fJYOpwyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=heEYOVJO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NDaaw2jg+VwPaw7hCGmTgs6c1VDwKlyHe3GIyHrKCfQ=; b=heEYOVJOMT82Fd8Xjio4j/Jpy6
	/On45E4C01m2hjgydK8uWLC9LAjiDuUzffUdHQqRBraHMYX/Cgzy8iupMiqD/iAqOHHd/V5h42V/o
	9bt9lRXNP1HCgk0S+QGpEZeylftCJ/vWVjsUgVkcsSxJ+wgfL300rzwXVmP32htnUvhW61iuEiO+k
	dDPmkmImDcPsaXpvcDzQMcDhMJQACstDFkWGww6/6NOgU+jNrb/wMRmCmc/ry1KtyzbL+JOJ1Jihj
	7MKfVFWtMQcEc+UDuvMEVorevbVTQZfEIQ0w11bLoy8UwSE0i7QrvtXpFCrjnCN26axUa43RH+ZyZ
	fDkxdGFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v39Zo-00000001pT3-3rhm;
	Mon, 29 Sep 2025 08:49:44 +0000
Date: Mon, 29 Sep 2025 01:49:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chris Laprise <tasket@posteo.net>
Cc: Christoph Hellwig <hch@infradead.org>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: Can the output of FIEMAP on BTRFS be used to check if a file and
 its reflink copy might have diverged?
Message-ID: <aNpIKB7cc7lCUy7j@infradead.org>
References: <a697548b-cc40-4275-9da1-3b29351654f0@gmail.com>
 <aNF9xH30pAEq5y4r@infradead.org>
 <38f350b0-9a71-4627-9d36-57bf2f85e67a@gmail.com>
 <aNGFdxq6Xqduoj6w@infradead.org>
 <d14d26ce-3176-4cd4-989e-cdbda30be98e@posteo.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d14d26ce-3176-4cd4-989e-cdbda30be98e@posteo.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 22, 2025 at 11:25:48PM +0000, Chris Laprise wrote:
> The overall procedure is:
> 
> 1. Get subvolume's Generation ID
> 
> 2. Read FIEMAP data
> 
> 3. Get subvolume's Generation ID again
> 
> 4. Check that the Generation ID hasn't changed: No match skips the file or
> raises an error

I'll let the btrfs developers answer this as it's clearly not about
XFS.

> I should clarify that in this application we are not interested in physical
> mappings, but the logical representation of data.

And that's not what FIEMAP provides.

> It is also understood that
> for some other applications FIEMAP would not be sufficient; however Wyng is
> not fetching or manipulating data at a low level.  Also, there is a lack of
> accuracy in the form of false positives, where unchanged data show up as
> deltas, but this only results in longer processing time not data corruption;
> false negatives are the only thing that must be avoided.

I think what you want/need is a way to look at the delta between two
reflinked files.  At least for XFS (and I'm pretty sure for btrfs as
well) the low-level data structures could provide this, but building an
actually safe interface to that is unfortunately hard.


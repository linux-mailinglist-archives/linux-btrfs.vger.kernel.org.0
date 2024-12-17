Return-Path: <linux-btrfs+bounces-10464-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE279F45C9
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 09:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B93F47A6522
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853221DC18B;
	Tue, 17 Dec 2024 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Io4ycCCn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A41B1DB938;
	Tue, 17 Dec 2024 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423220; cv=none; b=N5ISP6WljZlaFbloaTbD/dTjHY55lEOYVMZ+0ibPyyCFGlijoI8DMq7+Vm2ZCr7VHYVsD+WkTmSXGtaCVLeoKI60HFI9ggHPtVZ+ZA8zvhRPnoA8ZcuTwayQY9ZSwf/LB49MoX6L4ajmXvKGqb9vk9Uw1xDCTxcm0RrjAmDij8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423220; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHE0cA7E/gui+XV07n9HAxBNN+2f8vIyXgdlJU2K3Dj9W63WneTFQ8+yv2coIN5g4jBeowFZiI7TbZV2RpdaHllW1HSiE+2cKVwpHGLv0cKq2HO4tELai6ZtceuJS7md1UOLWFV+x0Gw3vpRAYeEnCalptzqoZ8YVH9aBlJR7tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Io4ycCCn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Io4ycCCnSYNS/clfhcx9K0/XzE
	PgvnZcnFk8ZzT7ev8mY4slHOU30pYFpOXb8wglF0HeLVi1Q0RyYGDHfqSUCTJdiiV3largZ9Jp6Jc
	/DMVE1SwYwkVfjpiRWGluCSSZxAG/jER+Qd17MayIK2rgHCbaPLZ4T9ONYKn2/Hi9f34pb1i8hi7/
	TlI7LKXwfh/z3eYqILDRFQsAycrHWRIudy30jd+BbWIg2+8IO/6qat0r7X4oqumy4C1t8cVcN8ZJ6
	nv+2HT85X4hp9uS86Lw4BO0fhqittMEKWJ8U/51cRa0T1TiS0rxsRacgn7fwB2J+3/it0dnBPUyOr
	LmD/6PYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNSi3-0000000CfyX-0phh;
	Tue, 17 Dec 2024 08:13:39 +0000
Date: Tue, 17 Dec 2024 00:13:39 -0800
From: Christoph Hellwig <hch@infradead.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	dchinner@redhat.com, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/590: fix test failure when running against fs
 other than xfs
Message-ID: <Z2Eys1ZjdDZEaKiR@infradead.org>
References: <bcb3d3adeb36c732e807d876b82219c3c1350e2e.1733914512.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcb3d3adeb36c732e807d876b82219c3c1350e2e.1733914512.git.fdmanana@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



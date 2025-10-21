Return-Path: <linux-btrfs+bounces-18090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A35BF4A3E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 07:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BC264ED020
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 05:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95215256C76;
	Tue, 21 Oct 2025 05:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iOemN27i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEF054918
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761024418; cv=none; b=RqdKNP48fHbJKmdpTyYzlA9PsY1iApRsI5PAC4aSq71ALFSJS+TNLdr7tX1IevDhZj1StESyHU+mU7ZCPmnxFnpgj0SX2IPCuK59E6TGBpH57jj1T1GW3fZ6DmxGfm3JyWbwo5cnSP5LYK8yQP5YfU6zN6ASJBhoqxzRwDKJlpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761024418; c=relaxed/simple;
	bh=vwX52R/bTs27UYautq0c62im+BZ121PiWQ8jPSL48oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwmU+508mBLSJ76/S8a/fS5YmZ+oFcCeW9QgGk5d/Ikjt9lhRmv4Mq5Mj4hOXM7HEv7jDnxAqpetJuFYBcyy9RT9q0FK230gXNzdEWmXXDYfcCqd3zXcxAmm1vjeFbT3ue20Jg5yzGrFw65x02LV5v8WXipmwrWzQiMPI+KTtt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iOemN27i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vwX52R/bTs27UYautq0c62im+BZ121PiWQ8jPSL48oI=; b=iOemN27i8+SEN/g5KPkcs6gx5o
	/9VTaQqAscuh5vaeujuXHCcJh6NnpafQ95W3w9FcRBhsXGhWFqAdrrLcz2YYvLRkoR4PPsjGoggWX
	R/5IiHQiJgIvKa1aUKLgktY+iIaZKSm4LeGYDLjKFGdWOlH8C1x5bDnDkceDYdZi8mJ0kmPP28+/M
	ORxx3vTeFjfzo5bHhgmRWBSgxpQc0p3Ak7xzioOPE5QSkAzVzj9VdCWbCGm3UVkII5nhC5UVdMNsT
	9guPXAMjTcylwRyVZE5Rc99IvSmQMiCPtpQBk2cm0ef58ShlNOhHsiECGxOP9EnHqmtcCq7pMaNft
	l140Vl3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB4tZ-0000000Fqwn-1L7f;
	Tue, 21 Oct 2025 05:26:53 +0000
Date: Mon, 20 Oct 2025 22:26:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix delayed_node ref_tracker use after free
Message-ID: <aPcZnUICwvlZXwsq@infradead.org>
References: <e5d6dd45f720f2543ca4ea7ee3e66454ef55f639.1761001854.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d6dd45f720f2543ca4ea7ee3e66454ef55f639.1761001854.git.loemra.dev@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This fixes the use after free I saw in xfstests btrfs/071:

Tested-by: Christoph Hellwig <hch@lst.de>



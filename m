Return-Path: <linux-btrfs+bounces-15043-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF54BAEB690
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 13:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CA03AB740
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDAD29DB6C;
	Fri, 27 Jun 2025 11:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="glbhpkuM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C111EDA3C
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751024178; cv=none; b=I9tVg1aJyBhRKNWPi5K6L1geaZEJdqhIO7yF6Nor80YM6hqkThzBlSCEASSKr0V7FX6Tw8fMiTbW6Y7sWAwJB7KSOWUbJ6QNKHfpJLi2ddG32Fs2Xk7WQYZ7xPS5eiNvJmFst5E6EnwYH4G5efbuupX4gnocbVsMSO7hcRGxZ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751024178; c=relaxed/simple;
	bh=cfrXBzqB2SQTcwSeiB25R4pASURvSjafNnMMULfDv0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugUOEfDDN/y6fHb/YRcZyxSvfME346NRCVFZMuKmeChy+t24fCpud0QX1KgJ/9vc7GU/ndOlUinrhQ8kO4TjUWuGBREjtxnZ+bF5h3ioKVIch2qI0HORJVzMoD320Zmoo8FqAGY/g8PzYuC/M5RdXsJ+ny7T2OJDXCLza1wgzcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=glbhpkuM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bFF1Ih5Oo4pT9cyue6ZVkB4BcEaQsPS8oJWGYxAB/uA=; b=glbhpkuMLhJhU3DchFu+drqEYV
	Lzwjb4TZZxwoQUW6cAQwOGjSX4pLkVLin4udx8CzrmrYgg4R4f0o97066EVik29+SeDwdQIvGA2DA
	c9Fogdh9jvWoG6vGtZfWIiwl00Y7QeFiwAb9FGCbAij55SWpbPxLuWWYkotPAIUQEnd2qDeYtKeuG
	Db8xtDG8BIPddvkCZSx/zV52+kTLbhUbegtxozgUAp66Nkv3ovUPHWkNIJzF7MVkyeQaEAq4gXtKf
	gEsOFPKYfhH5xH+oPuRpc4rQKDkGNVHnOcniZW4j/gPJyQOTDBLwKAJOgFaWS6mpLklEj6oi4CjCY
	zGdOZbMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV7NR-0000000EVdl-0BOC;
	Fri, 27 Jun 2025 11:36:17 +0000
Date: Fri, 27 Jun 2025 04:36:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH RFC 8/9] btrfs: lower log level of relocation messages
Message-ID: <aF6CMTakzmTXWhAH@infradead.org>
References: <20250627091914.100715-1-jth@kernel.org>
 <20250627091914.100715-9-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627091914.100715-9-jth@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 27, 2025 at 11:19:13AM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> When running a system with automatic reclaim/balancing enabled, there are
> lots of info level messages like the following in the kernel log:
> 
>  BTRFS info (device nvme2n1): relocating block group 629212708864 flags data
>  BTRFS info (device nvme2n1): found 510 extents, stage: move data extents
> 
> Lower the log level to debug for these messages.

Same here.  This is useful debug information, but I'd expect something
like this to be a trace event that is enabled as needed, and not
something going into the kernel log.



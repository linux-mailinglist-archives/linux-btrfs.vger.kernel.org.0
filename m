Return-Path: <linux-btrfs+bounces-15041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B40E1AEB686
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 13:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EAB87AA86D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABC129B218;
	Fri, 27 Jun 2025 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gC/3j+FP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA4293C67
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751024091; cv=none; b=CCypX/dCb6IFi4LccRtntzny14jw4CbP0Hh9+RKfRljjxr8kULBgqJv0ObeWI/42hjYM9nFBWpZ+5DEcBjy9fvyxZey71ckI7dyhmquuAjqz3fJg8hAZtJNUVNU6j8nypEqnZye5CENBQLsAdBY6v2C9x2dHqN+ExujoGSbUZCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751024091; c=relaxed/simple;
	bh=2qeqVEB1NUn1FXHyTsSCU1wVSwT0T2V8aQX6dHdRzXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9wUk1fZQgAhvEsqJY9dnWneEXokrfiF4bLUjnwsxDVM4b4ZcOFccfXRbefLYO7iWDPeRQbeUV1skaO5YDb+5e5DrQ/hwNXJKAFSc+k3cshBFyJ7T5/F/kCbwUeN66NXdT0VNt5IimosLPFK+xCHirs4weim7MWqr3TVm1da2g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gC/3j+FP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mrKOxGyMtY3LzEeKLBjZydJxqtQBSphcdi/+RwXJS+A=; b=gC/3j+FPU1ooqYnlkc/kQ5ffuc
	+1FkTb5X8IkxGKjG6EzlmsUN8aisnc38tP9iGqpBP8cvF5Cc+4OMkW46wOrWMFSG1d40Jd2iKnASq
	pY2xs7rEr+Bx4SqbUAiYL2LcpJHLBSndxHRcWvTDiyo7G8yoSAVpHrVqrg3sCDMp3FZxyrM7LkjlK
	9IuGhiEVIm/UYRtQ3SE6b4NTAdXQQDV/zEeHt8s8qC1kp5TmAinrfKg0cBJWPEgSPsy/ssZf8ZKwt
	SKfUfzQ60OmL/BdfkIWanYDqYsS01DRASthHxaRAqa+OWRTor4zz83TOGBkWjEA7QokZr0bR3XggK
	eihtNyzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV7M0-0000000EVIZ-42yh;
	Fri, 27 Jun 2025 11:34:48 +0000
Date: Fri, 27 Jun 2025 04:34:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH RFC 1/9] btrfs: zoned: do not select metadata BG as
 finish target
Message-ID: <aF6B2CJpduXwbdyh@infradead.org>
References: <20250627091914.100715-1-jth@kernel.org>
 <20250627091914.100715-2-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627091914.100715-2-jth@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 27, 2025 at 11:19:06AM +0200, Johannes Thumshirn wrote:
> From: Naohiro Aota <naohiro.aota@wdc.com>
> 
> We call btrfs_zone_finish_one_bg() to zone finish one block group and make
> a room to activate another block group. Currently, we can choose a metadata
> block group as a target. But, as we reserve an active metadata block group,
> we no longer want to select a metadata block group. So, skip it in the
> loop.

Q: why do you finish a currently open zone to start with?  If you add
an extra zones worth of over provisioning, you have enough slack to
always be able to fill to the advertized capacity, and never need to
finish an open zone before it is fully filled.  Which simplifies the
implementation and reduces P/E cycles.

> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

You'll also need to add your signoff here when sending the patch on.



Return-Path: <linux-btrfs+bounces-11323-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFD4A2AAC2
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 15:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5542E3A50E4
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 14:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C8A1FECB9;
	Thu,  6 Feb 2025 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OHOPRQrf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F861C6FF0;
	Thu,  6 Feb 2025 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738851079; cv=none; b=cvMZ1pPNRV583j6lpna3x5MKu02dhIjg35/+n3VAOD96O4LZ2SNUN4s8Fq8a5ZJO4VphOOO5x2EVgc0ROThTYipvk9JEDcmjTVX1ojpIuErMtQplodWDuvnmMwpmo1mMsktSPBx/Ju0qpsbtsyXDQYZLI6d9cVwHgsfxEmiOOY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738851079; c=relaxed/simple;
	bh=fwM8XCayycdmpCNGu9+P9KBsXIYnKKz38VOXuw4nHBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJ7Y6Nx5j5WCO/VHLsBCUJQBEBw5ER+V4P57o/H4iGdNysbFAQ3equWWGGNqQ3AHTdJAorERjK2Bb2oLxBSH4Cs/bmIycNOUJCiQw/7wdGH3/MMC8jpFcTXI14qynplx4TwUTv+QEmafSJqYxZx+aVzYXX0p+TOdBp34vqbLHfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OHOPRQrf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DMHYJGgXinhUVK75yEvjm9BeAevAAKNfuxoNzcLrV5E=; b=OHOPRQrfZzQgtLrszdR5YXrIAK
	rrt0HrHjL/rC0BLxuLtZt8sC0D6TGbnS31SXxK8Gfm/Ip6FoRsfLrMCkYeWR6R8FydpIWFyrCooS2
	goriNfws3Z0MXpB/WjuKWnFeJk8AlJ8h4xYCl55TLncuwvhuB36YE3je9xlODOmK+9Tnna5RoYQWc
	ICdNDETzRsK/hxAGatlcJdStruzLOVJSzieWwIVD/1GSjc+wVZ+pIKziVFV68GgbXo15YXbqYu6gT
	nNSGnfC2yxnY1UzQTHWXGOAitnEmnoc7J411qxBg79ejDdkp9/COky7CymXpVj6B4pBWgZgL59IC/
	+KQ50jOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tg2b1-00000006Wui-077O;
	Thu, 06 Feb 2025 14:11:11 +0000
Date: Thu, 6 Feb 2025 06:11:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: suggest fs specific fix only if the tested
 filesystem matches
Message-ID: <Z6TC_yP7pTlzDOH4@infradead.org>
References: <8c64ba21953b44b682c72b448bebe273dba64013.1738847088.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c64ba21953b44b682c72b448bebe273dba64013.1738847088.git.fdmanana@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Feb 06, 2025 at 01:05:06PM +0000, fdmanana@kernel.org wrote:
> +if [ "$FSTYP" = "xfs" ]; then
> +	_fixed_by_kernel_commit 68415b349f3f \
> +		"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
> +	_fixed_by_kernel_commit ca6448aed4f1 \
> +		"xfs: Fix missing interval for missing_owner in xfs fsmap"
> +fi

How about you add a new helper instead of the boilerplate, something
like

_fixed_by_fs_kernel_commit xfs 68415b349f3f \
	"xfs: Fix the owner setting issue for rmap query in xfs fsmap"

?


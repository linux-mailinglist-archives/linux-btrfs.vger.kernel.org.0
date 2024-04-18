Return-Path: <linux-btrfs+bounces-4392-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BEE8A92A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 07:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C277A1F21E10
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 05:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60876A00B;
	Thu, 18 Apr 2024 05:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FIvGDap0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79811657D5
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 05:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713419656; cv=none; b=KVJFgTqkxyRaIxNV3fkhev2uRMVdUoBQt/l4fAOL6B/rHGU79Wg4Vcj+j30DFbpQ7vQMnJpC/ZhWQJGqqXZ8QwhKJczTXgCJe+WyuG/OUOLtVmi9P4ppQjNoV4y7FKpjay8doxtWCQKqhRW/blBSq81qCbwTQIMYqCuWI0KetOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713419656; c=relaxed/simple;
	bh=1yRnMN9DWsrPzxF71guFZl+e/vud9KdMs8rXRiNdCyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCT4ohLoi3gMu208VWGK1V3VDoTmG0kai0pEFBCzuzybQs1b0jEBTQKm2w1wSl1ElzJtYzgGXsUjsYGvLn3sW3UgbZ2Xz5D6MnoNjGAP2OrILbbFZN2JJAYHN+zbH/qGbcGAWru8NK+7MEcmkLAaTrQMLBnilb9kKYp1rLA6nsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FIvGDap0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mOjbWiJkCVhjOqH3EHwI/mdaj9EBJVLPmqfYCKa2U90=; b=FIvGDap0TDoj2Kyc8ACcWzRHhI
	4DZj+tLNBuzlGZ48qke6B4KdWx7zsn6u2CtJvdC6isK7rJdkg4rEiWV3ejpL4uu91qJUrnWXwkzqz
	8WwOUGYOKqYR56Tre6Xle0qw35tco6v1ytMrK7NSnolXG0p6Ipjzc8jqZ2GBrRVNPjlVUyCSRqX8t
	q/or8CTJEL7rauGz28B7c9CRXvTqDblf8fBp0ik4rT1HQLJS66XStSqI3lFXIRsIFgn/ib8AsnSuM
	Q0vu9AbjYSWNwnniHvwOsZAke95h4xxYQLaENtN89VbOy1J2h1OofLtLqZHoTjgurrQ/nhrKdbvBC
	dBpuK2vA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxKir-000000012d0-40Hx;
	Thu, 18 Apr 2024 05:54:13 +0000
Date: Wed, 17 Apr 2024 22:54:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/17] btrfs: restrain lock extent usage during writeback
Message-ID: <ZiC1hbcG4rFFz1BM@infradead.org>
References: <cover.1713363472.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1713363472.git.josef@toxicpanda.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 17, 2024 at 10:35:44AM -0400, Josef Bacik wrote:
> discreet set of operations.  Being able to clearly define what the extent lock
> is protecting will give us a better idea of how to reduce it's usage or possibly
> replace it in the future.

It should also allow to stop taking it in ->read_folio and ->readahead,
which is what is making the btrfs I/O path so weird and incompatbile
with the rest of the kernel.  I tried to get rid of just that a while
ago but spectacularly failed.  Maybe doing this in smaller steps and
by someone knowning the code better is going to be more successful.



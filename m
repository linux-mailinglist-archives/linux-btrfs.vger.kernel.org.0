Return-Path: <linux-btrfs+bounces-14555-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EBAAD1849
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 07:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75353A4AAE
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 05:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D641DDC2A;
	Mon,  9 Jun 2025 05:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CVMYChh5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2EC2F4A
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749446508; cv=none; b=WBWcS8V6gxYP+BYthPpVNOurjejT6hzwjH6ouK2EpQYMMenUb4YY4EjpQt9Qm9Ldl1Ovcy0HSf+qFPpv4TGDiEJTcUoNKXcrZrdYOtZftV5SN67LOzwUK9alyW6wD+HOACb0N4H56rdFzcebhsJK/kgKNi10ssvMnOKWhtcL76g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749446508; c=relaxed/simple;
	bh=EbjSOoWmFcrwymkRjDC1qtcDw1DyMdkIx/PRuxLLsDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxO1u3J0Jq6liF4CMTv4P1Gkhp8PfR/TFR+87DutA6OpuHurqTxCa7t6/XN2m4CBtheHWHqJ9HMcDiYyMwISPBN1CQc8PanWdsv4tms+Ak1U7JyJlOwNfG6IlsBtjgdbumZviuxMTHIy3dt1zmO7dK36klhwDvGAyN5+MHfx6f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CVMYChh5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EbjSOoWmFcrwymkRjDC1qtcDw1DyMdkIx/PRuxLLsDo=; b=CVMYChh5FlbWCyjHVtqhFUJ5DL
	81RCsuhAHMk9ZInYGJZlpQ56xdu8LfykW04ehhLnUSdFQ7lLwV9Prg7OMQ52GNR6+tZHE8E9urUX2
	6snawRdlJ5OS/TEOpJhMywM8+7gX6UIMlPf4ZQv484ST6SJuxySpNOtviZpfflKyRKm+rjFHd4zIW
	AsXUEURO6TbfwT9XPGcDLVCwLnDsdPvh8q97ir4wLgILvZZOgU88P2Om49+/aRVGetCyp8gqSLrcY
	b+657eFf+G/YBznPPRMaxYRHRJh8zczO5T3rYth+SDvvM+Lm/AOLLC4wV5ibpAm4JGTnttHBk/6dn
	ML6m/xlw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOUx8-00000003Sbc-11YK;
	Mon, 09 Jun 2025 05:21:46 +0000
Date: Sun, 8 Jun 2025 22:21:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] btrfs: introduce btrfs specific bdev holder ops
 and implement mark_dead() call back
Message-ID: <aEZvaqtkM6JvLtLL@infradead.org>
References: <cover.1749446257.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1749446257.git.wqu@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

No full reivew yet, but I think in the long run your maintainance
burdern will be a lot lower if you implement my suggestion of using
the generic code and adding a new devloss super_uperation.

This might require resurrecting my old holder cleanup that Johannes
reposted about a year ago.



Return-Path: <linux-btrfs+bounces-9122-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC129ADB82
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 07:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1859B1F260F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 05:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578EB17335E;
	Thu, 24 Oct 2024 05:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="trrmWGTs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCF042048;
	Thu, 24 Oct 2024 05:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747628; cv=none; b=W1Iclz/JXnYBQ7bsBLayQtZDz2S8083KIM4fAdLfXmGPf/FWu83AiTwL2LzcOL6TvQT1p4RZ0Pp3VrURP54Su/4aYckeVGufhQz13ieeaNTWsinSi0Q2r8u3ELg5j3LdoXwFP1n0Cly0Til/vokbMy/LYuGCAjXJbbmgBo9Xd5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747628; c=relaxed/simple;
	bh=GjeYBnlGMSDGCbPKBFFHXYjam4sY6mpjXqvslED2hRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eSEvT+mDAF46PQCdcaeiXh6xTNJ0LzutVpou66d6DKq9HP4jyUbJgCCoXi95bgdDNR/PbPUpFH108wOHXYZRROD17ctImMeWEMpM8Ab5PlTR/B7t95E9+WOezvE/0uuBV6nTZOdYqr4l72zg87G60STpu2WqtIfdpBLiXIis7Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=trrmWGTs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m3LHcUrHFSvbGNGLV3ynNE921dROklyIQPvNBlaNu/M=; b=trrmWGTsTkRDy4I6eOlmSg3cYy
	jn1Sn0VuAMq+LtgHLa8Ft6A9ctxpgmcDQU8xXtM1SuZzxldSc+GFmy1OkaEoqPTk4Q1DPrw18f8jX
	0GGeDk//NzTh9CBkvyHUQ8ye/FchwJKQQ5AVsLbiCeHCGgcxcy3UhSLFQCbiefs6Xm5CxOmrqkWEW
	SZAEMfRMGGRWUyihngv3JZiC+aqJjjc4vWdU8T7jpwO6JTy0AGGD+req1ps9NQn8F0KhCshzkHwd7
	E8YXD+ULNhrVFNYKJZdq53QRk2vVQEoanQrACz+3gBAvrLrMcxeCLarhk/e+LBNggMdEnvYiDGJdZ
	68E6mG9Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t3qNG-0000000Go7G-1xTm;
	Thu, 24 Oct 2024 05:27:06 +0000
Date: Wed, 23 Oct 2024 22:27:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: avoid deadlock when reading a partial uptodate
 folio
Message-ID: <ZxnaqgJrYFjGxPEn@infradead.org>
References: <62bf73ada7be2888d45a787c2b6fd252103a5d25.1729725088.git.wqu@suse.com>
 <ZxnXtI_6HCwvCvLT@infradead.org>
 <d373ef6a-956e-4319-ad2c-36f67a887a58@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d373ef6a-956e-4319-ad2c-36f67a887a58@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 24, 2024 at 03:54:54PM +1030, Qu Wenruo wrote:
> And generic/095 has a much higher chance to trigger it than the minimal one.
> The minimal one is only easier to debug and faster to finish one run.
> 
> Do I still need to add the minimal one to fstests?

If I have bug with a well known isolated reproducer I love
having it in xfstests.  I don't know if everyone agrees, though.



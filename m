Return-Path: <linux-btrfs+bounces-7806-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F04F96AFAD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 06:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA26284AA2
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 04:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C896BB46;
	Wed,  4 Sep 2024 04:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I26nldO4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF79535D4;
	Wed,  4 Sep 2024 04:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725423201; cv=none; b=YkNMvEEJ9IDdlYL+ddGgZLk5CnwdYaxoNxMQyHG6o3zgeL1oWuwCD0425XM40U27LGcUudEq6aw3BgY4IZiwMqhssq8IhlvfsoHdgWUDnCTMDdjfFjJlGyrRvafhnDP8QrlbHOB4t28Kpb/HyRiEjJNUpPzVldANs1f08mmtGHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725423201; c=relaxed/simple;
	bh=YnjDYRGjkDMHHnHASIFpaM2SeBHqmhLnXcfbSafMHM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNFFO+fEAS9+CmsZqXcTDZZNAhDsH/Je2JBIDtn/bEoOSZV41fp11PxUxxt1Sh36EEqh0xjMuTBB3TJwt/oq5gGr4MtzFsJBKfwM71EQt4Yl9OVrkIUtp0VBeyqkZRB1Qd6KztYHBkwqP/AIGVl4evW+iDKoIjztmpNWDpw6mvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I26nldO4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=bf2CZyN5mQgV/X6CFXW7hB5Y6GAMnpi/vhBUgDn81og=; b=I26nldO4VeBAcDpaYh3EsAcsvg
	QiS6Ujs1db8hwZRhod2kMZPrsKSsyEPsw/FapW1udicFi7lW3at8LaZekPdjlbCx/iZ79pXH28Syl
	9LhVMDcaqa0eQvmg9BLVzdVyc4Da+U1avADxojKA85VcI6vO2n0K6JDNf5DD7v640n4vsrbXmErWr
	2MIH0vUN8N2TxFCW/Y1mLpTeIjT1zpBow/QhZ5yWms5C8ejcmdARjdZ2z9hM8gli1JsTy0JEopPlw
	V26uWk8A37z3EwuRSvmymWpiT/TJgmF+ePbejGpWFBmtLLkJM6+gL+7XJpUnG43JB21ffwL/Z0298
	Wo4oP8BA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slhON-00000002lCq-3Wxr;
	Wed, 04 Sep 2024 04:13:15 +0000
Date: Tue, 3 Sep 2024 21:13:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Luca Stefani <luca.stefani.ge1@gmail.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] btrfs: Split remaining space to discard in chunks
Message-ID: <ZtfeWyP2zYawbFCZ@infradead.org>
References: <20240903071625.957275-1-luca.stefani.ge1@gmail.com>
 <20240903071625.957275-3-luca.stefani.ge1@gmail.com>
 <Zta6RR1gXPi7cRH3@infradead.org>
 <e5d765e8-e294-465f-adfc-ad4787116959@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5d765e8-e294-465f-adfc-ad4787116959@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Sep 03, 2024 at 07:13:29PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/9/3 16:57, Christoph Hellwig 写道:
> > You'll also need add a EXPORT_SYMBOL_GPL for blk_alloc_discard_bio.
> 
> Just curious, shouldn't blk_ioctl_discard() also check frozen status to
> prevent block device trim from block suspension?

Someone needs to explain what 'block suspension' is for that first.

> And if that's the case, would it make more sense to move the signal and
> freezing checks into blk_alloc_discard_bio()?

No.  Look at that the recent history of the dicard support.  We tried
that and it badly breaks callers not expecting the signal handling.



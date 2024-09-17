Return-Path: <linux-btrfs+bounces-8078-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E68997AAF5
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 07:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1491F24039
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 05:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA2849659;
	Tue, 17 Sep 2024 05:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rk7Lwrec"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A64482EF;
	Tue, 17 Sep 2024 05:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726550449; cv=none; b=tEDwFeetKb3TLRva201JkKtsFNLa5YR2hn22tKRkWGHhXgDF3vn8cwDzbb/BFoIcC858L/ZBiGMGeMIU1ha05WB4Na71kYGOMbd+TEZ7u/PxtXIHgKPMCJSvH2cJ0VA9I2Wv6UKRvmH3FpXlg8bdtbXsPQqjnsrsx3IVFvTLyws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726550449; c=relaxed/simple;
	bh=POmRjhI16tEvwmVBsJJfa86IwaoLWe1lae7yRelAbSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGd0EVVK6xEY2gwgw1OIbguvZhcCmZ9dTDmy964xA/3t7LzyQAKiLloox45WrwEkoVoNkrg95Yg/YfJk8xjOwL/XYosKvSOjvsWHYDuN0UnMaeAjRHtSkgJMUmN5mvQV8NneOikgdQGSGPI4rqV+xo4nQ6zfOaAWLRk/7HZ/RQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rk7Lwrec; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gKc7eNctAPQNgV6aPTpA/drZBkrkMJyFK0gpRH9y/rU=; b=rk7LwrecXZ7VkcnksNosFEjF6F
	QqQGO1UsRSNxyM1jk3I6SdCdhY0f2Wya+e4woNFKFy6VPDY0AWQHIxsPErlN8v08BekCpzmTMFt/Q
	M3SatfR5uE29AIEH76xitXcv2ZfGknKoE+5vE6piRUic9D1vBHncLSvx7N2Ad30j+oXRML1kWDecg
	fOU2KieGxijUIZ92Hi1lWshIaxVx3+76UDbcZQ8alICHUiM6geEb67bJ1FlK4Xq50M5N+rW2LFWj+
	8ucxl+Meh+DUfMczWDFMNCdkm6HxAxAfFJ98nGgB8/D55v0sv/iRud5UR/+xQKwZ0BMpyc22A8Uwj
	0f8XwAtA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqQdp-00000005OaD-1yMG;
	Tue, 17 Sep 2024 05:20:45 +0000
Date: Mon, 16 Sep 2024 22:20:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: fix min_dio_alignment logic for getting device
 block size
Message-ID: <ZukRreQ--325baAG@infradead.org>
References: <0d6ec0b588b578b9f9aabef91b8ecdf9950b682a.1726488132.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d6ec0b588b578b9f9aabef91b8ecdf9950b682a.1726488132.git.fdmanana@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 16, 2024 at 01:03:12PM +0100, fdmanana@kernel.org wrote:
> Fix this by checking that the ioctl succeeded.

The fixes look good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

What file do you manage to open but fail BLKSSZGET on here?  This smells
like we have an issue in high level logic.

And btrfs really should implement STATX_DIOALIGN with it's multi-device
setup that doesn't make the fallback very useful.

> 


Return-Path: <linux-btrfs+bounces-10463-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A4E9F45C1
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 09:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED1B188F622
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 08:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2721DB377;
	Tue, 17 Dec 2024 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DHv1OJR4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EE41DA0ED;
	Tue, 17 Dec 2024 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734423183; cv=none; b=Du/n0Z1MIx7VUOElhbv1xW0HaKncdowbWUfM/9QXAq40y5Q7du6nRRXDO/CV1jhINvCrDMJERRka1Ztmc3B7sRWjHe0AgA/IXTnvUblfgVu0MnhNcgdOHi7/WMQlkd7MOaQJ+pPalyCbVhngbCcufIKxX1E9GQ9R3rX2mOTT0fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734423183; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iT/ZH8FHhj3b9QYbg0LP4YdXrZX8uMG+nfLWSVPyH7GPb40DsJra9n3Ve6fopV6/h+4uvbPdy3AzD0gYTRN613qD6zQA5yEzaeFRNDMdMCYczztaN01nz+t6x/MA0p0Xw+++DQ9EKF9TMdmjDwRxd+GEMtMu3mXLOEhxgVVnxXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DHv1OJR4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=DHv1OJR4EyrQD4sG55ZH+FixnH
	lKaxCbMq2pLIn4MxwXlV6pvLBEXCfA9bhlEg6//VX2Xkca6wtAgT1RHXKgbdwikOj1V1Gv16PRapL
	VuEwnG3zLn4Wz4VX0pNLRPYfEeFq2eMjBaIMZwHRVqYdGE0MRuwyBkaCJ8VEuYapbcsQrHxsNTlFJ
	PqKP31qCR5e9dznbaFmRSo2HoBiK6a7KmvcB2Y+rIGAvOcEN7sFN4oG+i3kMJyWK/i+RuezYzpwLM
	e5BVa/gepEKs/nGTJ34FHMVsn9Qoo2l/eIJu3UA1LHMrh372KINHhRdO2SW0f1Eal33EDObw6yMBg
	xrcX5ytA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNShR-0000000Cfsl-1ARo;
	Tue, 17 Dec 2024 08:13:01 +0000
Date: Tue, 17 Dec 2024 00:13:01 -0800
From: Christoph Hellwig <hch@infradead.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	dchinner@redhat.com, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/442: fix failure due to missing test number
 argument for fsync-err
Message-ID: <Z2EyjQ7LG7P2vwfj@infradead.org>
References: <407b633354417bbadeb3e665246f5c5f8000e1e6.1733852293.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407b633354417bbadeb3e665246f5c5f8000e1e6.1733852293.git.fdmanana@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



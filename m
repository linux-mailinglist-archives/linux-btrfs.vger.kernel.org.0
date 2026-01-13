Return-Path: <linux-btrfs+bounces-20450-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D19DAD1A103
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 17:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1A223032137
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jan 2026 16:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB5B332EBE;
	Tue, 13 Jan 2026 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="djYwGuIG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709EE221F0A;
	Tue, 13 Jan 2026 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320134; cv=none; b=g0rzT3WebOFeQZUhD45Ar3zdcr0Vqiapayg+/7s9HrxN42rbw5Qu71msOVj3gnkw7qBKVipAPH9Qo4/ipfInw58UMw5BfbEj4z7XfqzXxf2P9hC3vDdjkvtcEMYQdabOZlC7hcoYOnF3Bp2cXhWoMGPCa3JqK7ed+US1UUbceBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320134; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7GEr3vZDBLHpr1VCYlNsemVJ94StFj0LrIUbBaOubzCSxOOny8aEMHgQY+xFXSNW/VfSV+0f+3qPd/S6Oe3QM/F6Kyprc9mGxtlbMeuuU2y9vP5SaHYZm8KStdDQinSAymg/LzndfbnTf0cTexrucsU/ZgajzbVaVp0yyeXfzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=djYwGuIG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=djYwGuIGTafOzPYMOKUUbdIrLa
	ILYy0/8tsChJZBBu1FerweqUvnWZ3JPq1voC+wbY7tsz4YFZwokf0N0NvkwtlNx3gViG6VmLBYGMJ
	anviHlCDEMvleUK3Aj9kXyiQGQdujbZUdS438AGSjpAcPRpC1wYs2VyRa89z3fUsa/QFOHsdRD/lQ
	nIJdvrlmY3hMaS06k3lhxmcpmm0KpvXvIlPaKMzdnyg+eL9i5u61azZRzT1isVyWI5AWkyyxfQDhQ
	RAIb/hsXx08IEeeLg2Gzr5WeraArY+TYBIeNgJlQ06/h+azvJq20wqMSrgmCVrVW2wG3nRqM3z5OI
	vAt+/Bdg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfgqR-00000007R4x-3mcK;
	Tue, 13 Jan 2026 16:02:11 +0000
Date: Tue, 13 Jan 2026 08:02:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fsx: add missing -T option to getopt_long()
Message-ID: <aWZsg2N06upcVfq9@infradead.org>
References: <dcbecbe996375e0f04962aa2e1a97ade927ecf74.1768225429.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcbecbe996375e0f04962aa2e1a97ade927ecf74.1768225429.git.fdmanana@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



Return-Path: <linux-btrfs+bounces-19773-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC67DCC171B
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 09:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 727C1308A8B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AAE338F5E;
	Tue, 16 Dec 2025 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lUDNy1tw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9008733121F;
	Tue, 16 Dec 2025 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871847; cv=none; b=a6vP69Tl5obUprwIdFWDE4EaO0Q20ilZacQeEPpzJnFa0/xQ+dSkdXPEOgM6Og0ZObb8AUUQeQwJnsP/mzQycrFSgAkJHpgNcu30+PZwsTTwlm5oI3zX8ncCXqWlmRfK34G0WfhFtIKOv3dSP1ftbY7K//3Z8Cdt7U7SbsJnAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871847; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcEwH1WS1hCItthlzc1DSQeBrlRecL9REua0an3WZQ9RYO4F4a2Xbm+iVZzpD7Q9/a0yQGrHP6VjBLJkBylKti7t2AWyC1XmsVFSyJ3eBWOFSd0YRRHqXSSwdajWLuZDyY4mjev+mk8oXDJlBOZRGVFnO2xRdjL6Ux4tTm4CRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lUDNy1tw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=lUDNy1twS0TvHa1DM50LyW/t0w
	surDu5ajzAsvJ7fQMcooHuuowIOVzGF/MayGWpIQl8j/qPz3F0nVO80SjZl143zBQYt8cjro/9/wO
	Y3xUShZlqySXKM3CeUCQ/Sjh445a5kawr9cF7AFX9HovMPRbcrvn0iWvjSRmss0dNk8Ozdb6PyRLM
	afxdklMhUfrdJGWaVW9cVPvQVUGm0pnOPdnlqS6+jp2b85gpYZR+XqmhJ+vthGJdoFQoyVBItDQDb
	nYb/bSwB1Q+C0T+3VVFFPlJ0dpRovaG4oV7FqG64ikov0omukgFFZopNCRiM9/ScsYHv3Yug7v0r7
	+0OGI+/Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVPvt-00000004svr-0p33;
	Tue, 16 Dec 2025 07:57:21 +0000
Date: Mon, 15 Dec 2025 23:57:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 02/12] bio: use bio_io_error more often
Message-ID: <aUEQ4UycMqHNB2qQ@infradead.org>
References: <20251208121020.1780402-1-agruenba@redhat.com>
 <20251208121020.1780402-3-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208121020.1780402-3-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



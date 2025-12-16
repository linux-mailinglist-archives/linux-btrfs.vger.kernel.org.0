Return-Path: <linux-btrfs+bounces-19772-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 377C6CC1723
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 09:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34D0C3035268
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 07:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751F1338900;
	Tue, 16 Dec 2025 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z49jf/LE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B7335577;
	Tue, 16 Dec 2025 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871830; cv=none; b=OCnRfY3QANRhp4r13Csctv/nbS6VHrxBbwgfK98DoDyoDZrxHAZsMCJIg3XK1rSm+J1e5IjHjSuTbgWLvGEXMPJWxYxaDCdv4oHCsJ1Q6+CUhWWD1NhXxPFk98SEgNl7+33zJBv+D2VTohU9WM+IeAdcEDDuzvZd3+r5M1WDgBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871830; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0BC05SzZeAw7nV+JDJNsM68TLChnBjhppMNUdFc1oOYhDSBfIH5AJyXHS8V8kZ12afgba1IKRqSHH0NakahPMqDkGny8jXix10jG6YA5JAWk/MxzNvkB8mjjOKnLbXrnTvA1WgsoM5ewrcR1WadDjPzA09pAJNvOLvj1jv4OWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z49jf/LE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=z49jf/LEoh8WLHEy1OF2xWQuGy
	xFMQAkCl1YWpjlFk4tKgrRGvCwD5uCnDzMXXX4r908YDR1mVg/lfZXL308kyMudBQ6GLqfS6guQ5H
	mUQgqhvzOZFm97m3eG1WZFQ8t81JSRFMBCGAUXORIpz6OBPsuS/25w07C0lFP7USZlGbUCFy/Ucuc
	+oSAcSWjCVVTl0sIGFzhArA5KCkBUqbBzKPicNOjf/QYM9F8PI63Upi/CMYziOrWgmo3j57mZbtpV
	slLoawwORNQWpQc2yDnvrhmox+HydbpkJ4i3NCHbIxXkE4b44RoQRKLxqPB/UFNAOtrKbZAdYC3F0
	rG54Qe5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVPvb-00000004su1-1wfx;
	Tue, 16 Dec 2025 07:57:03 +0000
Date: Mon, 15 Dec 2025 23:57:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 01/12] bio: rename bio_chain arguments
Message-ID: <aUEQz49wCNHeT8Dw@infradead.org>
References: <20251208121020.1780402-1-agruenba@redhat.com>
 <20251208121020.1780402-2-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208121020.1780402-2-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



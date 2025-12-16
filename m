Return-Path: <linux-btrfs+bounces-19775-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C5CCC16D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 09:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C140301B955
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 07:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CCC320A0F;
	Tue, 16 Dec 2025 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r53+/7ZN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2736B339B34;
	Tue, 16 Dec 2025 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765871951; cv=none; b=gqCdgVZX695jlc0bQ/KZ8xse0MXsZ+XvcWOJqljqN77X22tqwa0TQ/jlgPihZvciSlubQnV1I57cIcBG1Ce6vSLA+bavZl+5gpBZbxenNMhT4g23K8xRKRd0ovRHFx8kPlgCWnioNBVZ1jsrZ9ZiodCDMVtqN8b42iKdUob8Grc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765871951; c=relaxed/simple;
	bh=gJvLbkvDTUZXY9SVzgqsd2iEO3FttMmyvi14Ives83Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4vH0ffSB6iBvyIkoIXmYUOxqXJ4Egvp+bCosHb1RdiL3iKbdRP89eX2AckMJ+hmTTkG7w6T8/9M1GlICU4n1DypKHHIiyLADu/F9WXSGJF8IVP6ZlOGBvenoFl2PQ1annVxprEzBME01ooW+LEq+dqblFgUZHFecVURqFo6loI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r53+/7ZN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QaPD/RSw6jqqHGAyLD1usshNhF3txnQCeIuMfknltJc=; b=r53+/7ZNiK0KYQUR023H4GIvy6
	bFaDTbejvDE2B+PQeje8nhf5zoDLlsB0y57e8K4XeKSRsgXlJyAMXEEs4KZJQVtHjBG26Dydzi8gl
	jp8GTL1U5MUSk5aoPqRIyqj1ooX8Jn3jNSKtIKRFbf7yfW24FIvtAXZWnXPm9FYYBlaNQfkjVmaiS
	uVUiH8hqE3AUWtKlquiYQGWQ12Wqt1UNF0vuBzsyBJD57f+evRMXw7cWnlG2YGnxge4OnQge82Y5O
	eeNEctwqrKAfRDOagrJfmZ5m5uvyxWrXan5xiDHkr7WP1fAJM94F0Ew7lStRbzC5AGMCHrbNPHZtL
	uGsLHKUQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVPxW-00000004t0r-3qLM;
	Tue, 16 Dec 2025 07:59:02 +0000
Date: Mon, 15 Dec 2025 23:59:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-raid@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 06/12] bio: don't check target->bi_status on error
Message-ID: <aUERRp7S1A5YXCm4@infradead.org>
References: <20251208121020.1780402-1-agruenba@redhat.com>
 <20251208121020.1780402-7-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208121020.1780402-7-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Dec 08, 2025 at 12:10:13PM +0000, Andreas Gruenbacher wrote:
> In a few places, target->bi_status is set to source->bi_status only if
> source->bi_status is not 0 and target->bi_status is (still) 0.  Here,
> checking the value of target->bi_status before setting it is an
> unnecessary micro optimization because we are already on an error path.

What is source and target here?  I have a hard time trying to follow
what this is trying to do.



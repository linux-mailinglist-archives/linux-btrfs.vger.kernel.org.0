Return-Path: <linux-btrfs+bounces-13422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC86A9CA89
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 15:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926031B80E36
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 13:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921192522B5;
	Fri, 25 Apr 2025 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H1GNp05i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9078B101DE
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745588286; cv=none; b=OztMOpqwYvjYM+3iw8GbuGJf/sW5jzRtMTalIAuiVGkJlBo01fxo7840xtkUdamlpH5TA+3YH7F7LoEG6eRlBbRd3vSzsa+3C56z+qb4O6FNPvuvXo8VirrElXBSf+FmOlhlsz0n51EJdiinxxh/lYUylgEZFcSwfKKNuBjNAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745588286; c=relaxed/simple;
	bh=C6ffzFXC3CdMt6mHiX0gruJ9kVRvsAs2mBksS+m5hUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXUoz09NE+6KkqCZ7LyM5qBQIaq5mXHQMnY6TDtqb79eX1ipVgoe1gbooApr9v8xFG6TbZlFUO6sfppl/0l0hvtAISUQlFD58Jay181E9Se8jLCzgs3pZp3u72yyxB9KZNuGSfchIeYRrnS5CVT7v4oxz4T7Ln8x3QS6ICz4y7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H1GNp05i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lvzRfSCBBdnETr/ud2MQjELWBSzxODMmCTpJTVzSm88=; b=H1GNp05irbMmLUtjRLmyAuF/LI
	R8izf+PF6ISNiXX4o22M6s2AjtQaM6oHSEy444spKuAhQbRIZMcMxDeSyFqio167/hroCgbsUwwZG
	n6QMj+VfR6OdTi3VSIbI56XtybEltpKH01c1GjZoQg/3mZlMNKCSwKTj6X6KQ1gtuQZxC4K9R1uq3
	U39otvLbWBOBRyhxkeMNqZc+naNUvEepoxsuu2VsQ5hWAHZtbpAklv5tEKk1k5kVeF0Eir/zJwGAP
	/di92SAyhYmUrPrmvjeWWcOv/COtc30+UH5lvYeXPLETUHBJ+xGxmeozWo3VkNZYSz8s0Xj7Wtevp
	p7rMSR9w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8JFl-0000000HJQR-0ptg;
	Fri, 25 Apr 2025 13:38:05 +0000
Date: Fri, 25 Apr 2025 06:38:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Sterba <dsterba@suse.cz>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] Cleanups of blk_status_t use
Message-ID: <aAuQPY8dxXPSpTIg@infradead.org>
References: <cover.1745422901.git.dsterba@suse.com>
 <1142ff0f-4296-4877-b8b6-1be2f78ff9ad@gmx.com>
 <20250424060959.GI3659@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424060959.GI3659@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 24, 2025 at 08:09:59AM +0200, David Sterba wrote:
> There already is forced type for the non-zero values
> 
> https://elixir.bootlin.com/linux/v6.14.3/source/include/linux/blk_types.h#L96
> typedef u8 __bitwise blk_status_t;
> typedef u16 blk_short_t;
> #define	BLK_STS_OK 0
> #define BLK_STS_NOTSUPP		((__force blk_status_t)1)
> #define BLK_STS_TIMEOUT		((__force blk_status_t)2)
> #define BLK_STS_NOSPC		((__force blk_status_t)3)
> ...
> 
> and from what I've seen there were no type mismatches.

Note that you'll need to run sparse to perform __bitwise checking, it
is not supported by gcc or clang.



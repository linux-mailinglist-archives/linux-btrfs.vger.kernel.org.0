Return-Path: <linux-btrfs+bounces-17250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 855FABA8745
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 10:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96321897BE9
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 08:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ADA27CB31;
	Mon, 29 Sep 2025 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PuL/togi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848202773FD
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135849; cv=none; b=A+QO6pEfZkyaC85O8TMaGund6HAGCP1zlRTZ9hztAPqGNb0yiPwzU6Pv2EDwHymrPKFMrb1fS4xE+7CLSjAqxlaDnpy76qDkuxdEFbmqZGRscIuWzSxTWSjkAPCRpIHi9mCdPDhMk6Z3+0rI6/LpVzYSHtJhz2iHzMHW+w7DMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135849; c=relaxed/simple;
	bh=1e3OXyqYVtTOrH4/RKLiNO/x1SmRRQX28kSMnCTUu0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WILBndgs0mM2xIiYC0Nj6VgkX9cMrmDl9gutFxmuWM2IcPbtal/qWcdkhSxEZWdkITvTSmELKIO0syhlDCAztu9/OmkGHUrN6QK7r2RB8Yu7vTDbmwIy9BmvQ5X6yUT0DWKBajn3A9OOY0RDdGsuEd01CizYWc3CshsCe4cL7tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PuL/togi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dZ45+WyHj8eXGCdFjwCn6mLQX15JZ+wkjQPct1edF0Y=; b=PuL/togieHe62l25RDwugdWUeK
	g2rj+Th1ELmtCqePUMJ5mbrhG3WpkDZ0Vyl6yf8BXZmdDa/eg7JFuZFEtktPFNoEZsC1YBckDP0N7
	gXCgz/VzEH2ZIuD/rsanZ0WIwAj8PA8Dayd24VsYu68KsxdifcUFD+mnyqGRelK/yY+l6eUOFKzG6
	UYVd0ip8gARAaBDpHTqKMOILG0m13hsrSFTe3+7FZ8B13BOMrkFv1MbEauus4UKTmtv2msyBBWVz+
	6HQGjGvpdvOWBsXOne6Wb5tObs/EcTxRY7CZYRqIXFKvY4dCl4GqpmTibgVAF16Xp0FPfwZmwyd/J
	j15WBAzQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v39ap-00000001pez-0lPt;
	Mon, 29 Sep 2025 08:50:47 +0000
Date: Mon, 29 Sep 2025 01:50:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
Subject: Re: Can the output of FIEMAP on BTRFS be used to check if a file and
 its reflink copy might have diverged?
Message-ID: <aNpIZ2iMChSUzD3y@infradead.org>
References: <a697548b-cc40-4275-9da1-3b29351654f0@gmail.com>
 <aNF9xH30pAEq5y4r@infradead.org>
 <38f350b0-9a71-4627-9d36-57bf2f85e67a@gmail.com>
 <aNGFdxq6Xqduoj6w@infradead.org>
 <7b756bc3-fae4-4cbb-99a1-117880269269@gmail.com>
 <aNGH9s0xoIg9Isk5@infradead.org>
 <0b428deb-3711-4671-96dd-69c149fd8ccb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b428deb-3711-4671-96dd-69c149fd8ccb@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 22, 2025 at 01:54:56PM -0400, Demi Marie Obenour wrote:
> This leaves the question of whether the needed information is in the
> filesystem metadata.  If so, xfsprogs and/or btrfsprogs could obtain
> it from a block-layer snapshot offline without needing kernel changes.
> Otherwise, kernel changes will be needed.  I don't know if the changes
> to the userspace tools will be accepted, though.  Until then, btrfs
> send/receive will be the only way to efficiently back up a BTRFS
> filesystem, and XFS will only be able to be efficiently backed up
> at the block level.

Using userspace tools that poke at the block-level mapping is
fundamentally unsafe because it is not synchronized with the file
system.



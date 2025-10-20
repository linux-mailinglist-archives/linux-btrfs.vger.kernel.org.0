Return-Path: <linux-btrfs+bounces-18041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59648BF04AE
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 11:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B5C1882A3A
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 09:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088AF239E97;
	Mon, 20 Oct 2025 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fBygj14s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D822E004
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953620; cv=none; b=n1mvQ/aaLv5O9XJXNTtdoNe5Lq7f+5fk+1cz9QhWjqMPbHxzBGR363ugbXPsesJGuAEc254tDhGbbTBZWt/IvT0AIjCyQbnE8UJr6jBpQpjMgOO3doOJvb13N/npaBJSJXmmO/yM6XLVvvX6iRsJRh/yvIwhZXNmDc6/apzhgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953620; c=relaxed/simple;
	bh=5Ti4oaGDr7BMgIGsGfBHr4Cm/LTv0OGSCVmc2DHNObg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjBIDX4J2cRO4bMv008I7nonzCEgOUzZy9bkMheUH0iROxvn9nOWlSHRPShbbgmui0ZWslBtWdjd/PzrQvs4ufnh0ygURT6RDwG7R11ybLAKCsUxeULdvRhmelOm8BjkZOl91ws6PMCyspy9qylSo46i6HdFYBx93yatTlkrUlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fBygj14s; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mLlW52WQwnR8Ku5ZhfthVU2d5Wjnm9yOxqzyUNX+c/0=; b=fBygj14sKHNKN759Wy38QPU71q
	qZdojvmzOtjQSBU9e1Y+6CZbB7A+9BhuVQDUYH13efLxWBUuBg9tjWkaIdn34H77Q/bHK++W+Rllj
	F5riqZOfJMgELOhJVumXAXxyik7xPWUPPOv/joDe9C0PWoz3bFskJQavFwdbRJBuUC2k6gra7VlL5
	U0dAF1CeMb8ab/SMMAI51w20UxQX/AlFEMLFnVhSjwlNw3xYpj9QmvQH5skfrt0E+AQWhIeUaDpGm
	AEEJ6fjQ2hz08kH7HcY51pcS6/VfvMk7HNwsO1fKwMhHviiZplUrWkfPyB2MSX2OiWkErPkWPPXAT
	Vu4+3NAQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAmTg-0000000CeRR-1tfy;
	Mon, 20 Oct 2025 09:46:56 +0000
Date: Mon, 20 Oct 2025 02:46:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs/071 is unhappy on 6.18-rc2
Message-ID: <aPYFECiBrh36AwtB@infradead.org>
References: <aPXjTw8WN5Jlv2ho@infradead.org>
 <9093d4c3-b707-4ef1-be48-36578ac1d2f3@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9093d4c3-b707-4ef1-be48-36578ac1d2f3@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 20, 2025 at 07:41:03PM +1030, Qu Wenruo wrote:
> > [  279.247651] Oops: general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b6d73:I
> > [  279.250656] CPU: 1 UID: 0 PID: 82037 Comm: btrfs-cleaner Tainted: GN  6.18.0-rc2
> > [  279.250656] Tainted: [N]=TEST
> > [  279.250656] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/4
> > [  279.250656] RIP: 0010:btrfs_kill_all_delayed_nodes+0x145/0x1e0
> 
> Any line number/context

Nope, that's it.  Last lines before are:

[   62.492209] BTRFS info (device nvme1n1): first mount of filesystem 975f6fd4-b50f-4f3d-8112-319c
[   62.492520] BTRFS info (device nvme1n1): using crc32c (crc32c-lib) checksum algorithm
[   62.510951] BTRFS info (device nvme1n1): checking UUID tree
[   62.511230] BTRFS info (device nvme1n1): enabling ssd optimizations
[   62.511452] BTRFS info (device nvme1n1): turning on async discard
[   62.511728] BTRFS info (device nvme1n1): enabling free space tree
[   62.642011] BTRFS info (device nvme1n1 state M): use zlib compression, level 3

> and reproducibility?

100% over a few runs.

> If you're able to reproduce, mind to try KASAN?
> As I just checked my logs, no failures on btrfs/071 recorded yet (but not on
> upstream rc2 yet)

A bit busy right now, but I'll try to do a KASAN run later.



Return-Path: <linux-btrfs+bounces-17093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A90B92704
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 19:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A1744392A
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 17:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56287314D36;
	Mon, 22 Sep 2025 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LV176z1x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B656314A7B
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562296; cv=none; b=W5TXE+kU1YgFkyWrL2yWZqlwODCCaG6TGeJCwG1b7djaZAfekUC+hXNLmptxhrpJSMcQirgmJ7BEbY6t/aL1GyhNhLweBjQBzhUpaZM7VZ0vZSbJE5tpp4Dv49WgUdJQDHj1k0yPN7OAC8mK0yQHicE99rfTmLP9+d9IvTu3kx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562296; c=relaxed/simple;
	bh=9X3HIFWoMW0efuWAFJk3YL3ql+zt2jp+Evi1LwK4MzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGiazhQiVlYZJlUpOY/Hq6X8fr7Ai52K2rX/VV6xR7Z6GstIcso9mON2fh+m4uRoUEWx5BIVVMvQzk02BPcsShWGyo3ut9aKtXzacDVjc3jz2eYDMjubecWdjB22+JrtsLJ5I6JXSy3x2jUypNoJb7hx2Z4ChxeDADd/hxTsPro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LV176z1x; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cFRu9LRJ9u7T4jTtD0EysBHyD33KCYxpzN1vu9LJ7qM=; b=LV176z1x3JIaZiIiX67onp1CXo
	Wmb5nCbQnTxPFl49w+CM4RXbA2L0MlqabhAf8NBaZDnTxdh6eMOnQbhQe/PRBpQv00tj/nAawi2s8
	trA8oSaMzxxlmp3EHCvVw9lG7anf+9FG1ezZsxI9awtViUZmXfu+x4JNYaZV3+k9tI0wFX5ALqvJd
	FAZvH/bAZ0MFB7JjEptP1kc0x9XJj9e+M0ptpG0sL6TjHJ+Hv2EbMHDUX3VtPB4o/ZuelJ+jm/bDT
	TkaJg/JZu4CnusCq15c+eRBs1nYWiJuTrulzO0K5HW7hoUxLeZWdJhwBIiACyPOgF5563s4pO7+j2
	Kj4EYsWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kNy-0000000B8Do-2kh6;
	Mon, 22 Sep 2025 17:31:34 +0000
Date: Mon, 22 Sep 2025 10:31:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-btrfs@vger.kernel.org
Subject: Re: Can the output of FIEMAP on BTRFS be used to check if a file and
 its reflink copy might have diverged?
Message-ID: <aNGH9s0xoIg9Isk5@infradead.org>
References: <a697548b-cc40-4275-9da1-3b29351654f0@gmail.com>
 <aNF9xH30pAEq5y4r@infradead.org>
 <38f350b0-9a71-4627-9d36-57bf2f85e67a@gmail.com>
 <aNGFdxq6Xqduoj6w@infradead.org>
 <7b756bc3-fae4-4cbb-99a1-117880269269@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b756bc3-fae4-4cbb-99a1-117880269269@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 22, 2025 at 01:30:36PM -0400, Demi Marie Obenour wrote:
> On 9/22/25 13:20, Christoph Hellwig wrote:
> > On Mon, Sep 22, 2025 at 01:18:52PM -0400, Demi Marie Obenour wrote:
> >> Is it safe on XFS if there is no RT device and both files have been
> >> fsync'd and are not modified by userspace?  I believe this is the case
> >> here: reflinks are used to snapshot the files before they are looked at.
> > 
> > No.  Yo ucan still have defragementation or garbage collection going on
> > underneath.
> 
> Can these be prevented by mounting a read-only device-mapper snapshot,
> replaying the journal, and then doing processing in userspace on the
> block device?

Which part of "looking at FIEMAP output except for debugging the file
system is highly dangerous" did you not understand?  Don't do it, you
will lose data eventually.



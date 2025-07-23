Return-Path: <linux-btrfs+bounces-15640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BB9B0EA2B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 07:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80A96C52C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 05:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB406248897;
	Wed, 23 Jul 2025 05:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YES4dGLh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67648248191;
	Wed, 23 Jul 2025 05:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753249718; cv=none; b=NhfC/B4HuvTlH5W9poCHHNLDKaFNGyFTAq7PRvSxDWEylwGy2NuYH0a98LEReSM7kw+lKTkXK9neapQL6X4+DJjBwMT+VWU7AxOgrMsGRhvIVoRnGjr9SU4PGgpoFIt2u3eTZlTwOjXbGcVUft05qw0ZZWK/HLysqn1ZpUpebD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753249718; c=relaxed/simple;
	bh=GCCdN+4xXs5pyJ3ICNKfeKo0nGQua79dkNsvR4PDyHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zm9bmJ+o3DeX7cfPqTs/b3Tp2JUjh/t89gduI/fzky/gbKCftFbUdqn5mKI1nJz1fZMj8D+Ct1xVg6lYLw91c/jsMaKIpeMvDdQBrhPh06ibgLX5+E5f2Ug0VCdcEB2lT0eO2M4Ql0WTBf7vSE2p4d3pMyUnN7RnTF+Xmtq91U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YES4dGLh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5KeNhxScBa51TRCYXf2rX8zFv3I4AcNdg+aKuejBzKQ=; b=YES4dGLhJYdD+tlHhjvdv6jMwd
	/pFBS1ErLEaH62R328Lsb8lfSdwGsWQbsH6mDgHsE7CtAkMdUphb5u1jqLidMAZO/47yn/8fPcPZW
	U70Xq14DMYgvIQoVQq102WhdapmQwtIr/yD2DUPj6S+nIOo3NpdoBRBIK/1Ltjml40ofF7x9tLgdM
	rD4xidfYUQU0dSWWZY+nUjZxwfQNdR8SVb+jgEdsB8PjwsHgW0lAEY/tiGBkvsp87QJ5HlAd/F8+Z
	TnHrXNy7O8CDhUOvyAqXNKSar7csgXtTFTLvsjtxWoYmnbppZGBo0ZhdyzWj6RCxHFNKJpXLtwBrR
	5VujQKig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueSLD-000000044yA-3CZJ;
	Wed, 23 Jul 2025 05:48:35 +0000
Date: Tue, 22 Jul 2025 22:48:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	linux-xfs@vger.kernel.org, johannes.thumshirn@wdc.com,
	naohiro.aota@wdc.com
Subject: Re: [PATCH v2] generic: test overwriting file with mmap on a full
 filesystem
Message-ID: <aIB3s2z84mjGGAQM@infradead.org>
References: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
 <681c9dcaca0bf16a694d8f56449618001cf20df6.1752166696.git.fdmanana@suse.com>
 <aH81_3bxZZrG4R2b@infradead.org>
 <CAL3q7H4_Pc8F6QA4qY420MZzpF8gyEXsr8Dg83UksSBG2mmWCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4_Pc8F6QA4qY420MZzpF8gyEXsr8Dg83UksSBG2mmWCw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 22, 2025 at 11:27:35AM +0100, Filipe Manana wrote:
> > Can you please rework the patch to see that setting the nocow flag
> > works first and only try with that or something like that?
> 
> Reworking it is late as it's already in for-next, but we can add a
> patch to skip it on zoned xfs:

It though I explained it before, but let me try again.

This is not about zoned xfs, zoned xfs is just the canary in the coal
mine.

The test fundamentally assumes file systems can overwrite without
space allocations.  And then noticed that this isn't true with a weird
btrfs hack.

It needs to be reworked to only run when that is known to be true.

> 
> 1) The quickest way would be to add to the test:
> _require_non_zoned_device $SCRATCH_DEV

That test is not relevant here.  While zoned device require out of place
updates, they are also common for many other cases.

> 2) Or add a "_require_nocow_data_writes" helper to check we can write
> in place and skip the test if not, as you suggest, as it's more
> generic in case there are other filesystems or configurations where
> data writes are always COWed.

That's the only thing that works.  Only run on file systems that are
known to do in-place updates, or in the odd btrfs case can be forced to
even if they don't normally do it.

To be honest the hardcoded btrfs hack should have been a big red flag,
those almost always means the test is fishy.



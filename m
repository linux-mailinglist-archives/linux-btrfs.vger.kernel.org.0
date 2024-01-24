Return-Path: <linux-btrfs+bounces-1673-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D6E83A0B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 05:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9561C21752
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jan 2024 04:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181ECC2D9;
	Wed, 24 Jan 2024 04:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d4Tot6wT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED67617D2
	for <linux-btrfs@vger.kernel.org>; Wed, 24 Jan 2024 04:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706071701; cv=none; b=GM7fsDUW3l1ZiAkzxVg+GL0RTU1JNpyE4bTPKLmBKBWlFI6ezMXkFNNfnMGm0UWq53drv67pn+fnB66s7F40ulL0BSkWe07k/bq0iKDBwWJ/46gcobgE3JM6Q/0VyAg96xvaF1kPSZ22itmuHz5hLHarL7NoAvJaoLOtasc2+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706071701; c=relaxed/simple;
	bh=AZNqS074S2TOubyaW4/N4ZiRzbb7D7OFdSprjx+gBp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyqoE5PCk56OdgKDH0eRmR9ANQFT+MgCuQwbchKciRZLp/8859jI1mY5joQTWuOXUjC37y4AJh4ugSJVqXIh2/Xfwx/XUayytAGdN99VqfPlz+aNSWW9NzUVGY9QLusQ7rQ8VvXFVMn2CU/Krz5kV0Q59YUaZeR4dec1fGqzV3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d4Tot6wT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h364op/wN+x/5kgi8QRjNE+YgsoLEstC8wc8aGpK/4o=; b=d4Tot6wTR4I8xxBTa9w/8AD8HU
	hmUaf0l7DiAAFv92nLRz01QIOPF+QrVFFkCtPOT4sX3nIYttSkCwhYkEZRnpe5OuYOmAVXSEuS6OX
	i6IPSSEmcf/503eiIsqAdJgqysF62DWy3iIiCT0ta97c5/Q0GkWlD5GkiQ6mJGunH6kwVLXRsNP5I
	B3tOGKSQarNtFsgzuWd8EeraBGJP2XgvB9jiDLlj9I+mSeNohxSd05eekR0v9i589NVtCHmZIOVfI
	e8DLLtMeFrTbw9+BEQbJbBF0IpU5qDCCprX59sckn+joLPeMHaE7072O/hiPp4niQoOAHNP1ZsfCI
	YuLDQ21g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSVBL-00000005PdC-3Vtv;
	Wed, 24 Jan 2024 04:48:11 +0000
Date: Wed, 24 Jan 2024 04:48:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 0/2] btrfs: defrag: further preparation for
 multi-page sector size
Message-ID: <ZbCWi98hWKnIW1zq@casper.infradead.org>
References: <cover.1706068026.git.wqu@suse.com>
 <b521e943-ae86-4a6c-a470-072268b254a0@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b521e943-ae86-4a6c-a470-072268b254a0@suse.com>

On Wed, Jan 24, 2024 at 02:33:22PM +1030, Qu Wenruo wrote:
> I'm pretty sure we would have some filesystems go utilizing larger folios to
> implement their multi-page block size support.
> 
> Thus in that case, can we have an interface change to make all folio
> versions of filemap_*() to accept a file offset instead of page index?

You're confused.  There's no change needed to the filemap API to support
large folios used by large block sizes.  Quite possibly more of btrfs
is confused, but it's really very simple.  index == pos / PAGE_SIZE.
That's all.  Even if you have a 64kB block size device on a 4kB PAGE_SIZE
machine.

That implies that folios must be at least order-4, but you can still
look up a folio at index 23 and get back the folio which was stored at
index 16 (range 16-31).

hugetlbfs made the mistake of 'hstate->order' and it's still not fixed.
It's a little better than it was (thanks to Sid), but more work is needed.
Just use the same approach as THPs or you're going to end up hurt.


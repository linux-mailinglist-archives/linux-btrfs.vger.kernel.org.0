Return-Path: <linux-btrfs+bounces-12165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA51A5AD9B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 00:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E77174561
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 23:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE40221730;
	Mon, 10 Mar 2025 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="MYNZiAdy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yaqnIHl2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF56199FBA
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741649510; cv=none; b=Qr9P2+3zAneJDiOfsoH5RQe60zJmDtsN4eo0VcTz6nHDaG3Luf/br3+sfokJqJmPOHxsZ6iHOzrxkW/j+PJ+NtwEkIFnyxxKbbG34lGKSwxkw7pp9OVpULI2cBRLCvfvJPOXKQDpTdaitiIhMY5Y7yQAsI8NZPjWhVkt5ehq6p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741649510; c=relaxed/simple;
	bh=KwHLyyjNlS1blywuyogrTPBEr6fiU/GxDsw4/ihLAfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhLdb4N2JZ97HFhgKLjvpHAETKF33X4et9b4cVw7dMkIpci+SbMK0udJVs9ap/2doJjYPu5JIbxXxZFT6iUFQVznQFUDYC75oJBrtVmn4xvVEGbMJDxQoyealcAEFiOYm9+l/wp/aYU7sB+pZQq5tLnuuyZ9afR/cDSpE6O2aq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=MYNZiAdy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yaqnIHl2; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8DFB6254026D;
	Mon, 10 Mar 2025 19:31:47 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 10 Mar 2025 19:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1741649507; x=1741735907; bh=ghUMQLk26Q
	+QQD6CasYy1U91HSX7aTuFN7onQMYfGq0=; b=MYNZiAdyhc7xHDQyR0OLPqi9de
	2455tb/6hoB9R3xE4+VvyCBPvHg46JmOyRX9MDrNe58bdRpvqKlVSyNDUL3KsLP0
	4AQ3RdfRL/gtDfbqcE8/9jP2mRRiz7A/PH9mNIQCnxIcoHgKXK4l54Psj6XS5FKK
	P3mPQykbyg4qiM4KUxEj/y5IbROKhfFfxY8s99im3NZ2DEtgSuNgLBR4224oE4sr
	6S6OggR+sa6fA7Mwt6/sLz40Uz5AhOUvUUKpEpKq8HkJhqOB2aU9lQ6rDW1idJKM
	QRY1OJS5S7lOBJnCJAid8wNj3NHz6gEOKcP2BAnuk7u+13iCKIQ40NpDWBjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741649507; x=1741735907; bh=ghUMQLk26Q+QQD6CasYy1U91HSX7aTuFN7o
	nQMYfGq0=; b=yaqnIHl23tuhfzVX9hNghghlsJTECDBp40bG1avhWCw2TISdvnT
	U6A6r2WW4ZTqwL4GCeA0NobCC8SSQXbDe+i6ONTR6fFsthxKD9Iwlhjtpl5EpMlN
	0D8GbsWORJpzg7wwHJVjS9sdXiGCWwfnHlE7fqxWjXUcS/DQIgWXHJ9jie3ORMIb
	sw6FPK9BGC5lTPcLrdvlQwnN2YwW0fsl7abnsteVWjjwayIAWLNTE7NQA2E16ofn
	h4gIiMJ8ipkjEVAHO2AKa9aCfs8YDPbEC6l5egQuyKpmpXsL84g/v75qCfcNpXne
	uaeaesn2b5u6jmHorWu1dUJLDRQwDIg0HYw==
X-ME-Sender: <xms:Y3bPZ3UlLM_IIwhi1TatXXmA9fjynhzhEFyCi7KKRMiEb294MatnlA>
    <xme:Y3bPZ_ksRSWFJhMwrdRytNKQyRlnzmaaYPrP5EJIB2XzD3NnWGFyopbm4KWlYuKmG
    67xfLGk2_G6A4v3RJs>
X-ME-Received: <xmr:Y3bPZzY0yF8BzbPG4jqK3mXp65buW23YnxYgVeRjpWNSXBR2Y7Kz5fqz9p3qI4Wqff2i_dO7ifpJ0i7pG387UEsmW18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedu
    gfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Y3bPZyUr0uHmm-bsvAxEvhS3wKZNSDG2CXmoPzqYEFnWsRNzmaIC1A>
    <xmx:Y3bPZxlhnxExAqJkw5SLhAsU5Xavzq4gGoiZ8GUnG4etsHajWyKXLQ>
    <xmx:Y3bPZ_dpC2SBxJsRhZ1Wfy4-7MLWEaHRaO1KioleDVhhcsYRrwxe6g>
    <xmx:Y3bPZ7GZYS5SmJrG6Wa3PrPCdt5d5JErhqMSus6EKp7jwKuciHc11g>
    <xmx:Y3bPZ2wYQo9aQHC4FYSuFq66qxt2jakB_V1kCeUJYmhSs8dBz6CAdle8>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 19:31:46 -0400 (EDT)
Date: Mon, 10 Mar 2025 16:32:35 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/6] btrfs: prepare for larger folios support
Message-ID: <20250310233235.GB967114@zen.localdomain>
References: <cover.1741591823.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1741591823.git.wqu@suse.com>

On Mon, Mar 10, 2025 at 06:05:56PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Split the subpage.[ch] modification into 3 patches

I found the way you split it to be a little confusing, honestly. I would
have preferred splitting it by operation (alloc_subpage, is_subpage,
etc..), rather than a basically incorrect prep patch and then a sed patch
on the subpage file.

You already iterated on this, so I absolutely don't want to hold
anything up on this observation, haha. If it's something others agree
on, I wouldn't mind seeing it before the patches go in.

I asked a question on patch 5 that I think is interesting, but please
feel free to add:
Reviewed-by: Boris Burkov <boris@bur.io>

> - Rebased the latest for-next branch
>   Now all dependency are in for-next.
> 
> This means:
> 
> - Our subpage routine should check against the folio size other than
>   PAGE_SIZE
> 
> - Make functions handling filemap folios to use folio_size() other than
>   PAGE_SIZE
> 
>   The most common paths are:
>   * Buffered reads/writes
>   * Uncompressed folio writeback
>     Already handled pretty well
> 
>   * Compressed read
>   * Compressed write
>     To take full advantage of larger folios, we should use folio_iter
>     other than bvec_iter.
>     This will be a dedicated patchset, and the existing bvec_iter can
>     still handle larger folios.
> 
>   Internal usages can still use page sized folios, or even pages,
>   including:
>   * Encoded reads/writes
>   * Compressed folios
>   * RAID56 internal pages
>   * Scrub internal pages
> 
> This patchset will handle the above mentioned points by:
> 
> - Prepare the subpage routine to handle larger folios
>   This will introduce a small overhead, as all checks are against folio
>   sizes, even on x86_64 we can no longer skip subpage completely.
> 
>   This is done in the first patch.
> 
> - Convert straightforward PAGE_SIZE users to use folio_size()
>   This is done in the remaining patches.
> 
> Currently this patchset is not a exhaustive conversion, I'm pretty sure
> there are other complex situations which can cause problems.
> Those problems can only be exposed and fixed after switching on the
> experimental larger folios support later.
> 
> Qu Wenruo (6):
>   btrfs: subpage: make btrfs_is_subpage() check against a folio
>   btrfs: add a @fsize parameter to btrfs_alloc_subpage()
>   btrfs: replace PAGE_SIZE with folio_size for subpage.[ch]
>   btrfs: prepare btrfs_launcher_folio() for larger folios support
>   btrfs: prepare extent_io.c for future larger folio support
>   btrfs: prepare btrfs_page_mkwrite() for larger folios
> 
>  fs/btrfs/extent_io.c | 49 ++++++++++++++++++++++++--------------------
>  fs/btrfs/file.c      | 19 +++++++++--------
>  fs/btrfs/inode.c     |  4 ++--
>  fs/btrfs/subpage.c   | 38 +++++++++++++++++-----------------
>  fs/btrfs/subpage.h   | 16 +++++++--------
>  5 files changed, 66 insertions(+), 60 deletions(-)
> 
> -- 
> 2.48.1
> 


Return-Path: <linux-btrfs+bounces-7399-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5A695ABBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 05:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8610D1F2A981
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 03:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C1923775;
	Thu, 22 Aug 2024 03:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DkjUvQVw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3714277
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 03:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295939; cv=none; b=D41M/FBz/iemQLwMD1Eer6xADO8aw6H2Csmvk4A/QHqr2qLEGf1EKveKvSvlNK53XT93xPJ7KziTnKFheTbDGcaqa/D1eHg4HCHKCwDU95mIuuFtYuAX+SFp6OkvJ/nhkMZW2HVzrwEbnoOmSZ00kErGELR+ruRDgs5G6MYV3tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295939; c=relaxed/simple;
	bh=PJkr1PJZGUNFRHyP6zmavCPdv/thitrEA0t1wl2X48M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCg2XgbR5UK6sNiI+vy1wcShedPYJYfoCggIeWBUqJCetBl3CNJ29BoIMSB5w3/0schsIijtjjqZSrQTuKaF+cpxQTjnj5pFek9kWXvc4DODxuSEGy1WXhBX+BQx+A/pe4ZHGcXAT80jg6HKQQJW5mzc86nfmGnRMkGqMU+tPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DkjUvQVw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/39cXkFQGxlaFd0Pa67D2DLMvy/gj6d8MFLoE30g3zQ=; b=DkjUvQVwSOMWvwftwO2L7k0+H/
	K0eMeRkzxxIFu25jCjiOAKwGKBrMfrgMlB65XjSoZotPwvwqppZPsM2NMOHduHlaGlqfbxbAi0sPG
	3k0L/uFoCbD4W9uRVvDuK7KRigMwbebQJTlKSlbkZOnkufEhFasrnP0qSEIXNHKwJuFIj6mncPd7d
	c1WMTyYhmB4rhrXHRh60IxNGUJs+ufrTqFAX4M5R/CPnj9U80zSJ5Owpz1jit5EkcRXTAHAXQquqD
	+e9ISWApA7e8vRqnwxFrZjS5iO03ye/FRk7T1Erx5BDH7IzuEga86Hf/BadfuoDCLgMa/qFnEdWop
	dJ8zZ2KA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgy8j-0000000A0xp-1qAc;
	Thu, 22 Aug 2024 03:05:33 +0000
Date: Thu, 22 Aug 2024 04:05:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, terrelln@fb.com,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 02/14] btrfs: convert get_next_extent_buffer() to take a
 folio
Message-ID: <Zsaq_QkyQIhGsvTj@casper.infradead.org>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240822013714.3278193-3-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822013714.3278193-3-lizetao1@huawei.com>

On Thu, Aug 22, 2024 at 09:37:02AM +0800, Li Zetao wrote:
>  static struct extent_buffer *get_next_extent_buffer(
> -		const struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
> +		const struct btrfs_fs_info *fs_info, struct folio *folio, u64 bytenr)
>  {
>  	struct extent_buffer *gang[GANG_LOOKUP_SIZE];
>  	struct extent_buffer *found = NULL;
> -	u64 page_start = page_offset(page);
> -	u64 cur = page_start;
> +	u64 folio_start = folio_pos(folio);
> +	u64 cur = folio_start;
>  
> -	ASSERT(in_range(bytenr, page_start, PAGE_SIZE));
> +	ASSERT(in_range(bytenr, folio_start, PAGE_SIZE));
>  	lockdep_assert_held(&fs_info->buffer_lock);
>  
> -	while (cur < page_start + PAGE_SIZE) {
> +	while (cur < folio_start + PAGE_SIZE) {

Presumably we want to support large folios in btrfs at some point?
I certainly want to remove CONFIG_READ_ONLY_THP_FOR_FS soon and that'll
be a bit of a regression for btrfs if it doesn't have large folio
support.  So shouldn't we also s/PAGE_SIZE/folio_size(folio)/ ?



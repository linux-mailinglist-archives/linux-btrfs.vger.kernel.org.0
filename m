Return-Path: <linux-btrfs+bounces-7398-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2126795ABB6
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 05:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F2A28D064
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 03:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0253F16C854;
	Thu, 22 Aug 2024 03:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tsP+Ivm4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7931531D2
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 03:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295750; cv=none; b=XOM5DmrMPq1kOs6jxQdk+Q1TXldMcqHW2UPYBcJQyiiSvY7Q8bp4b60aWnLgkYvo/0Pa/cVPJ2v6LllLPOS1FrxK4ZF/dNh0zTHatgXuOrylvzox1FecjqSW9rqjudkJn13/U2oVY8aGPPEKikRLy0R2Pso90iE9v4qfPwBMhtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295750; c=relaxed/simple;
	bh=YP2WB9dywIKVl9Gv1GKu83gWXpOmL4vFmjgq2eXETAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ejow+8RBmHjk0yCPAolGW+7wNDmslfporl0zEe9Cf5kJKjuNVz/FdJ4VgVjmq8xS/MZJPq8jfKxRdQda9Hc2FXniPwgU0UMcVFPrXPJaEXclbNMLgiqtLUnAFTnbro8j915E7QpFc9WA5EPhIQESQSfDw75T1t8XR3t/mfO9aRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tsP+Ivm4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YP2WB9dywIKVl9Gv1GKu83gWXpOmL4vFmjgq2eXETAs=; b=tsP+Ivm4NO+sSJwPyA2wMNQNG2
	huv4hwou6iHRS8RadzEzCt/gdHsr37RMgLucOon9zavHKgQ4uxBF4hqb9O2rKhwlWZtCH33FaxNrX
	L1DN9elxnbBXr5dSACoaSNu6GV7TJ2h+Ho80Pxo0av6CnZDs8TnA9xmdAWvfXcyKNxLOPrsdvYzIh
	MQoPrVSeGcBDQVqsmCYzG9pl7GwVLWpR4JAMY4+Qgb4Fwvg4/EO93V6uCAi6Jty03kYnwnUC/r0/9
	107GuRyRqxeS12obIE+QbR4GqiZiBbJ3WHrXsmGH+PPrDbL9vWX0ANVfu7snBP8gpCBJ7BoZxY7Qw
	ZgM6MEVg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgy5g-0000000A0kZ-07wC;
	Thu, 22 Aug 2024 03:02:24 +0000
Date: Thu, 22 Aug 2024 04:02:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, terrelln@fb.com,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 01/14] btrfs: convert clear_page_extent_mapped() to take
 a folio
Message-ID: <ZsaqPwOVA216C9Av@casper.infradead.org>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240822013714.3278193-2-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822013714.3278193-2-lizetao1@huawei.com>

On Thu, Aug 22, 2024 at 09:37:01AM +0800, Li Zetao wrote:
> -void clear_page_extent_mapped(struct page *page)
> +void clear_page_extent_mapped(struct folio *folio)

Rename it to clear_folio_extent_mapped()?



Return-Path: <linux-btrfs+bounces-7400-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E98795ABE3
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 05:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4F01C21550
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 03:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4091CD16;
	Thu, 22 Aug 2024 03:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cg4y9nZ4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8092B175AE
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 03:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724297305; cv=none; b=MsPvHmPPTNUL1XOzAp0hwoOpb7yfeIQyhubwMwu+bY02gOd+rS9TDXnujcdqahMRZQm7bDDPa8/9i7CUOIUU/ostv/gXWcOOBj3POyNDLOmg6uDQ+jNnl0jFsOGlNXd2FLFJmpkJGksXRnBoqukYd7FmFV2DsLeVEnLz4XigNgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724297305; c=relaxed/simple;
	bh=iRRgqI5aMW7IAFfbFglRq1b7t7s9iWxcrgtOm2yMg0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3SkcGW/vVyMopjaAtrX4YSbyOpKzw+7/u2w79IvEeMEiqNsx+ppcgKI7fTZMV9cOX/GJpK2uaEJsNLZnOdQtvNnzO41ZCqaAKJxmxLl5V0RSGhDZNceyye0uKN5S81s023yPkcpSMxMvjiGqb4FnFH1ugjUR1MgaOOFtfA7vPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cg4y9nZ4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kssEsSuP13aZFqShrbOpvQvO30ul38vY5Tx7vPFUp3s=; b=Cg4y9nZ4qFrl/ncgnUKfZRN3o2
	gbFTXFDPS0tZtjgl3r/lBdSV8vafgujyuZG1OMKY56r/8OXarQOwa831CpF29c9CL/8Xc6KaS7nCp
	7DsEZ/Wig8/obDK5DV9KaXASEvTdlRxskNE37uf2hgIqndSvZb5fMJUUoangj9OntqWdWNf/eyDLv
	AINeazPwAhye5oShyuZIsIpYo7C3ELbufnFlb9pUxgA7Nw4qiZMzVo2ONiMLOKE5OBQo/ij+t2u+g
	KSaS75B+LnPiWo1AJgsJl+gcGKWh0NvUhsKviyVz0iEgOk4IgXcdflmJhM3ixCGOV0zIJe8lZ9i+7
	sx7DDrGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgyUj-0000000A27l-42sW;
	Thu, 22 Aug 2024 03:28:18 +0000
Date: Thu, 22 Aug 2024 04:28:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Li Zetao <lizetao1@huawei.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, terrelln@fb.com,
	linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 05/14] btrfs: convert read_key_bytes() to take a folio
Message-ID: <ZsawUY25UW07__4G@casper.infradead.org>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240822013714.3278193-6-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822013714.3278193-6-lizetao1@huawei.com>

On Thu, Aug 22, 2024 at 09:37:05AM +0800, Li Zetao wrote:
> @@ -762,7 +762,7 @@ static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
>  	 * [ inode objectid, BTRFS_MERKLE_ITEM_KEY, offset in bytes ]
>  	 */
>  	ret = read_key_bytes(BTRFS_I(inode), BTRFS_VERITY_MERKLE_ITEM_KEY, off,
> -			     folio_address(folio), PAGE_SIZE, &folio->page);
> +			     folio_address(folio), PAGE_SIZE, folio);

So how are we going to read into folios larger than PAGE_SIZE?


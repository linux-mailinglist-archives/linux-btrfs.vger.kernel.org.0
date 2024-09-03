Return-Path: <linux-btrfs+bounces-7778-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAF796954F
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A8A1F22B77
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 07:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8081D6DA2;
	Tue,  3 Sep 2024 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g11HHWJR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C27171C9;
	Tue,  3 Sep 2024 07:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348426; cv=none; b=Bl7bScmh0o7Xfp0KMc8u3JNy0MNcxAij/2ekBbIZIeC4sYHPoPzBNOtvfTaeFBQtkRi0+qUzKFSWkLxkUY8rRe3sZGvCSJFlFjmZc0JAmmOtCieBZ4G2Of5C4uI3Kkjsl8yvNADKM4LZH+GM+gBrLkQ6gToBIOwpwlIPzbPrh+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348426; c=relaxed/simple;
	bh=jhW0yYL+2uh4u2g/AOaKqUZwRHHRZqogyS9yHkIIxa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H7YcFtnBw7+TrzGwpxgGv1QZpFDuh1rDPHy0cKvAqbtMO0kyyCXfF21KvV74+z5ujeRw1yaX68IU/ZhYglqbK+7JOe/127h7kgve9gp5cXwfi8RP75ZC8LgqysOGNFyjJwNlO56e6yhUnaFtfAwvr9GahIabFMA81fvp+3HxDow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g11HHWJR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jhW0yYL+2uh4u2g/AOaKqUZwRHHRZqogyS9yHkIIxa8=; b=g11HHWJRfirP3RjMl/0ZIQ2DJj
	xGGZiS1SKFS2HKImLXCwIJfdY79qLyNfhhH7MeorSHwhjQ94KjmiRh65QzWLe1fXSXy29pCW0zwXB
	YjQ45TKAwtRKQm21g7U1L3XFKH9TblaBiAkeJ0fVCo+RhtoLNmq3yG3VMW4YtgE+n9khum9LBSGMw
	3FhTBYqXLYKDZh5sfEXITBJyLw+sMy8pIQZXtvTUKDSQZD1i+/0pDQMrM9ktdT9nNnDN7dNfjZQ29
	NiqtyOYXXSgZzIfkfYtBerM7fgPvhQSY2m2aO0mTq4WpW+i3/5KUpNpeqHK3hQ0M0thVvsww+PZrx
	crVE40Eg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slNwL-0000000GfiE-3vNI;
	Tue, 03 Sep 2024 07:27:01 +0000
Date: Tue, 3 Sep 2024 00:27:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] btrfs: Split remaining space to discard in chunks
Message-ID: <Zta6RR1gXPi7cRH3@infradead.org>
References: <20240903071625.957275-1-luca.stefani.ge1@gmail.com>
 <20240903071625.957275-3-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903071625.957275-3-luca.stefani.ge1@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

You'll also need add a EXPORT_SYMBOL_GPL for blk_alloc_discard_bio.



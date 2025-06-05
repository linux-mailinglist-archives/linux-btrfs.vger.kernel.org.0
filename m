Return-Path: <linux-btrfs+bounces-14473-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4171CACE903
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 06:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB631720FB
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 04:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782071A7264;
	Thu,  5 Jun 2025 04:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CsOVqZ5e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2AE143748
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Jun 2025 04:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749098168; cv=none; b=o6ybWxCz7dMNBZlqc3ALS2+KTLKmO04IvXlncBn4MmZpafzhIQGWDKmcuitPJlGhhrCgG+BxjyD4D+fOd1qK6dU+pIwIlQgPNc1jc6xxFufiyLN8FiFoLZZ8d0Lqsd82dfsxyfcjjvgFE9xMQdutpkbiF+8uBK/ylsw8lbeE+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749098168; c=relaxed/simple;
	bh=9Cu0u3xBIsgTaHpA47oFNFJjre15II7326K+t5Gh3mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1JydRdxgyzbnweLiW7N+dJpGu8AlENcNNIWMgi+zjIEjMbqv24OgNAcUP4EnA+jNd5g/gQCCSXSm5cB3Sb+6hHKzo+g/0OI7xDCu1MtZ31eX9BCpngyxQAyw+OJS7sbL4bg/folYT3Xq4FXoa4+b7DvXP6eOWorrChM/kS3Pzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CsOVqZ5e; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SRQNMIG3fEC11g8weFFiocLgv9syfllJC2DrTkgBlUM=; b=CsOVqZ5eb97yji3vXAd8Tvbys6
	YK1KMFsyEHPKd7xGwcIFVsl0fhS6uk4uuHQUavPbin5KhyZEEMmG6c89B/XpNgzV+l46nJ1e15l8Y
	8vorvSLu0d3/f+KehYuU2mw6qD8+uY++0oUMFymRiavp5OTk9SHLE/QxSoq0A1QpZspINT7hpif6C
	OF8KbUXpaTf7L6AuKB0hX9c32RTMdbB2ptfX66fat1Z+rDgDIScMw0lQ9bJbUbkt6ae+Yi0ZlyVVl
	JMhf5VMx4+97f8HSnPdnErqJsWdmZuRwI+Jcs6oYr4rWCxhyqSh1k1Pg86b6AQwjWPLLgYD7odjt1
	8+fD0F4g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN2KZ-0000000EiHb-2Ext;
	Thu, 05 Jun 2025 04:35:55 +0000
Date: Wed, 4 Jun 2025 21:35:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Boris Burkov <boris@bur.io>
Cc: Christoph Hellwig <hch@infradead.org>,
	Dimitrios Apostolou <jimis@gmx.net>, linux-btrfs@vger.kernel.org,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Anand Jain <anand.jain@oracle.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: Sequential read(8K) from compressed files are very slow
Message-ID: <aEEeq700fw8T_lB4@infradead.org>
References: <34601559-6c16-6ccc-1793-20a97ca0dbba@gmx.net>
 <20250604013611.GA485082@zen.localdomain>
 <aD_mE1n1fmQ09klP@infradead.org>
 <20250604180303.GA978719@zen.localdomain>
 <20250604214919.GA1123965@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604214919.GA1123965@zen.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 04, 2025 at 02:49:19PM -0700, Boris Burkov wrote:
> unlocked the perf on the compressed 8k (and 4k) case without regressing
> 128k or bs=1M for a file with enormous extents. I get 1.4GB/s on both.
> Still less on the incompressible file (though higher than without the
> patch. 900MB/s vs 600MB/s)
> 
> I don't think this really perfectly makes sense for an actually proper
> version, as readahead_folio() will advance the index and we will keep
> "expanding" it to be the size of the compressed extent_map. On the other
> hand, if it is stupid and it works, is it stupid?

The way readahead_expand works is that it should basically be no-op
in that case as the two while loops doing the actual work are skipped.
But it might be worth double checking that this is really the case.

You'll probably also want to remove add_ra_bio_pages entirely.

> Very promising... I'm going to study this API further and try to make
> a real version. Very open to ideas/advice on how the API is best meant
> to be used and if this result might be "cheating" in some way.

As far as I can tell this is how it is intended to be used.



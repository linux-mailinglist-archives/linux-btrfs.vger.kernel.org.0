Return-Path: <linux-btrfs+bounces-15042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F201DAEB68C
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 13:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EC11C46605
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 11:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3212BEFF2;
	Fri, 27 Jun 2025 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bleLO5Ff"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB212BEC32
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751024140; cv=none; b=sJNtnwsy+so2wXxK2GicT5LMqINZTIqucK+LxciVHPMoE0uDxR8IQYcFJGyBePQobLnUGRv+76FuZeIDMdQPhzZMh14K/XqXR+8WgO/zPeV/jpv9UXSAFsJLcgJ+eHPBk7yW4tDJ/MF3yhm18WKPRS/I4a9aUUAcUDqwZvpREGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751024140; c=relaxed/simple;
	bh=djjOUJ/TlXsLC2RZVfUucHGQIjUB93W8aHRGqpto8vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fResy9A3MqQkwetPoiI71AUYR5/1lav8bX/zJO/QHk03Ck8tTGwDx7eEJMhz9XrZUtHQEXDi9d2uZAkfzgY7k726fjObZkDFA5KLa94GmhZlV+sLFYb6u/PxhKb4ne2NL7vP43Bo2VlgKXDZq77TuJ7r+G6FLm9IHBNFSETQuwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bleLO5Ff; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kVGNlxaIx5sMjtjk6YjS79pRLwjFoX7ZI7xJyVFx9h0=; b=bleLO5Ff4OjEmHyF9AxmOxNzhg
	xD79mv91riMTQWXrCfh+yqBLNNOV+Y/vtqpAN/LB3KqqHXmhi9RKq4bW5+GQI3hYnyAilovmL1QfX
	Qt/ZRCQqk+05R//GAlP9/nrbYTmPjgBWGKpozuBt1SS2Y7qQFsDUnvHJDIBjo+dcGWpEP370ff6Kd
	QVTrzqxFoRYL+Mbd4bXWf6peKWbKwPaUWh//GrmfltFf9eXgS5nlAzZFeCbJKWbD4qv4hJnaGavhF
	+dbHY3AAFHJ59c6a01g/gXTwR0Z4GKGVIAkkfelp/mHChWhVl04vIfKiWs7RalyMZfmrpsuPQFmJN
	gcu9lMtw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV7Mm-0000000EVU1-3ntn;
	Fri, 27 Jun 2025 11:35:36 +0000
Date: Fri, 27 Jun 2025 04:35:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
	Boris Burkov <boris@bur.io>, Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH RFC 7/9] btrfs: lower auto-reclaim message log level
Message-ID: <aF6CCLNDpSVEyrfv@infradead.org>
References: <20250627091914.100715-1-jth@kernel.org>
 <20250627091914.100715-8-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627091914.100715-8-jth@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 27, 2025 at 11:19:12AM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> When running a system with automatic reclaim/balancing enabled, there are
> lots of info level messages like the following in the kernel log:
> 
>  BTRFS info (device nvme2n1): reclaiming chunk 1138166333440 with 10% used 0% reserved 89% unusable
> 
> Lower the log level to debug for these messages.

Wouldn't a trace even be an even better choice for this?


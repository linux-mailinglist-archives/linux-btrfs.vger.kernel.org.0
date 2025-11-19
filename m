Return-Path: <linux-btrfs+bounces-19130-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 785DFC6D95A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 10:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3039C2D6BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 09:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC7E335558;
	Wed, 19 Nov 2025 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QjzlPd8z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB47F33508B;
	Wed, 19 Nov 2025 09:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543202; cv=none; b=YMekT8nO95FWJIAaMESVgI3US+usju0B0QLHHWYklQrHeg/CdgUFgekTl8M1NgxhLGasakVC62lgdKb7qeMUoPD2Q8j9loppzY9SBRXA3wQfA+Ola7JwY8tf/rNqQ0c0ndYYl9N+LQxeqXtGEkQ+dLD+TipSROUtYd5MaB6Mme0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543202; c=relaxed/simple;
	bh=FNDvPq0a8mjHfsQh1kC66n5mUk/3lPaz6eDEVGtKbFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIhljtKcN5+2XAhEVUCqlVkBku42rh6giqDy7GCGgdQYX7Q4aX4lTeAaG+Y5VskKhjz3famR2GhIgR/tsMbxkl3ZEgkWhEcn1raRY3fbQ/yy2U+gOqYRgQBix/G98lWVTid7xNGT41X1yZCI6uqBv9pBN/I+33+0UYJUHp2V/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QjzlPd8z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QZgTPd0r4q6B7QI65lP4dOcLA6hoq2AZfxZpgBqCS9g=; b=QjzlPd8zL9daaEGQIcGB6id1wY
	uPb7YcsJ6SDEIoAncs9zkinuSw+oblYgBVVqIfj2DNWWdAZrqnan4CH3EuaFByJdDE5jFBZ17SAQV
	xq5Yek14d4ICQhhyLox5kdccvXIDfNbnsXRoFRdYNY6LykF5cwBJyOGsDCrsbJd+gVCJ8veRQ2Xcl
	PFrSwNF9wvLblMCRM3LCIiOviUvftKQFbb+nAoGWLFZFNErZMQP6RDLk5bOB5GVP2iqB2gRXIN6j0
	Tw8TzKS8Ncyouf+tLPED9hec6WR15bhytwSK4YCRD56jfGTnfTS16BE745JdWOMbTBRbNwwnBy0hB
	cr36DC+Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLe96-00000002q1U-2GvZ;
	Wed, 19 Nov 2025 09:06:36 +0000
Date: Wed, 19 Nov 2025 01:06:36 -0800
From: Christoph Hellwig <hch@infradead.org>
To: David Sterba <dsterba@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Daniel Vacek <neelx@suse.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/6] btrfs: add fscrypt support, PART 1
Message-ID: <aR2InP3qFS19AFrx@infradead.org>
References: <20251118160845.3006733-1-neelx@suse.com>
 <aR1-h75CvzMHmsJQ@infradead.org>
 <20251119085941.GC13846@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119085941.GC13846@twin.jikos.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 19, 2025 at 09:59:41AM +0100, David Sterba wrote:
> On Wed, Nov 19, 2025 at 12:23:35AM -0800, Christoph Hellwig wrote:
> > Patches 1 to 3 just add dead code without the actual fscrypt support,
> > which you've not even posted anywhere never mind having queued it up.
> > Please don't add this kind of code without the user in the same series.
> 
> The fscrypt series is about 50 patches, last v5 iteration is at [1] and
> I suggested to pick any independent patches we could ahead of time.

Getting any independent work in first is always a good idea.  Patches 4-6
fit that, but patches 1-3 are everything but.



Return-Path: <linux-btrfs+bounces-12353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC22A669E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 06:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43031749EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 05:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95061A316D;
	Tue, 18 Mar 2025 05:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fp+SR/Uw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C091C36;
	Tue, 18 Mar 2025 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742277252; cv=none; b=Ys69FTJbc/H1QJpTcOKZj5ijl9/PA3yvf9cGPnin4SiQKtk+zW3tm07oJhj451HFvUGs+cQaGL9rqJdb8IDmP2UFeQp45WNFmrs3XziJTCi2Ycgot5JepvNJ5mfDXBVAwOrOjtRRRNs340wFLDWLxk4LUCmmVXBifJoUw4XOU8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742277252; c=relaxed/simple;
	bh=HZmM70UzyNNsCSmyWME8Ov95gLfQI08bUvM1i8S/Ayc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpZjkX+Brc6n+82icqySaPgZjiOoAOv9HWrJLDz52IEtnLqnAqTBoQtduwpOi53k9VHYry9tL8DQVaRNoCT+wxJOw5M/u6LdTwN7TnkxezthqojbF0SXjYq+vnjCWVyI2DwbeMEb8Uy/jbQVvsBuNwhlaeTnnTKjq3HlFte6YB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fp+SR/Uw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zs1eyB2m8bxqxR1fuDPMRDnq5aX98Uzg8ixNEBfOvRY=; b=fp+SR/UwWPNp1oNYVw0IvBHShn
	A1Gp4sh/5RDiunmYi9JxdX7HqwIlnGHm0eLfZ1TjwSP3+8b47n2QuiUzSnW2gLwLbJmefEwNhjdUO
	xF2U6XopG5eG1BWIyMZ+fZya6Ot7AI5HIhqOqk9Cb5Aaqnyu8DrDuijRpIew237M5m7oKGyEyQkyo
	yamTfRNDirgP2ZDH88y7gg9CBLEmUtqvIm1NwV1K6lv9XTGRrwDXRkI4iTtJBhBslmUc0mkhkxdSx
	XYFAO5yNJwsMniILhCW6OKUN45L/oVB91NxkLMOVYcZB0yWrFItkP4BAVn7L4fQrjP2dX57gwL3wM
	+oM3kJgw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tuPtu-00000004lVH-47XV;
	Tue, 18 Mar 2025 05:54:06 +0000
Date: Mon, 17 Mar 2025 22:54:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	axboe@kernel.dk, linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH v2 1/2] block: introduce zone capacity helper
Message-ID: <Z9kKfpY0E-phdJ5G@infradead.org>
References: <cover.1742259006.git.naohiro.aota@wdc.com>
 <e0fa06613d4f39f85a64c75e5b4413ccfd725c4b.1742259006.git.naohiro.aota@wdc.com>
 <2a641d02-1d59-4e0b-9dcc-defb64548d1b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a641d02-1d59-4e0b-9dcc-defb64548d1b@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 18, 2025 at 02:14:29PM +0900, Damien Le Moal wrote:
> @pos is not the start of the zone, so this should be:
> 
>  * disk_zone_capacity - returns the capacity of the zone containing @sect
> 
> And rename pos to sect.

While we're nitpicking:  sect is a bit weird, the block layer usually
spells it out as sectors (sect sounds too close to the german word for
sparkling wine anyway :))



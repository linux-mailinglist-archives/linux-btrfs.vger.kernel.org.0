Return-Path: <linux-btrfs+bounces-10045-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0552C9E3048
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 01:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D621644A1
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Dec 2024 00:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9882119;
	Wed,  4 Dec 2024 00:17:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D5624;
	Wed,  4 Dec 2024 00:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733271447; cv=none; b=dxqGPkh5WjX7uolJAJdmUie/YDYDpHh7Ck0dbWdiA4sqGdmaH/4YuLoWAnhftRf4SO/g4LLNsVWuzh8IvRDr1Y1/0t3jiWGrw/xtz1ZJZinsP+2q/Sp7DkEs2omtGW4A2/MiZTTb1ptw3JjLOVGnilHmDOa/TfP1OOtw5MuP8Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733271447; c=relaxed/simple;
	bh=v2OuiCWTQl9JZwh9rwsj0C/IzMtcYs2XzPC7TlPCysk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qw67Y0s/cACNjxCMQRGofdAqIUiK1dzzjXPjcwNYItnguW09nkm1ctrkQ2jiZs8+cpgUZAuOcPTMzUL5kXc7KhKaFwISGVWiODrxxo/+HeTA4zex+InCbHPXwp14uhVfrIskRp1cLUq+Gr3ASOD+xEmksTnwgb88AUozzyuvjf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9734768D07; Wed,  4 Dec 2024 01:17:18 +0100 (CET)
Date: Wed, 4 Dec 2024 01:17:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: David Sterba <dsterba@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: fix a few zoned append issues v2 (now with Ccs)
Message-ID: <20241204001718.GA22411@lst.de>
References: <20241104062647.91160-1-hch@lst.de> <20241108144857.GA8543@lst.de> <20241203170120.GE31418@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203170120.GE31418@twin.jikos.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Dec 03, 2024 at 06:01:20PM +0100, David Sterba wrote:
> On Fri, Nov 08, 2024 at 03:48:57PM +0100, Christoph Hellwig wrote:
> > On Mon, Nov 04, 2024 at 07:26:28AM +0100, Christoph Hellwig wrote:
> > > Hi Jens, hi Damien, hi btrfs maintainers,
> > 
> > How should we proceed with this?  Should Jens just pick up the block
> > bits and the btrfs maintainers pick up the btrfs once they are
> > ready and the block bits made it upstream?
> 
> The block layer patches are now in master, I'm adding the remaining
> patches to btrfs for-next.

Thanks.  I wanted to resend them, but my baseline testing still showed
crashes in generic/475 so I was looking into an expunge config to
check if there are no regressions first (there really shouldn't, but
I wanted to double check).



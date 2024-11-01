Return-Path: <linux-btrfs+bounces-9291-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB02C9B8AC2
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 06:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F341F22160
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 05:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D08C14A60F;
	Fri,  1 Nov 2024 05:48:53 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C22142623;
	Fri,  1 Nov 2024 05:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730440133; cv=none; b=sylEdhKKALH+yTOuyVVMo6ya/1E4hGZu4Rs8/jhSYUrZ6y9Cgj6B47kDwUV32me5ay27x65HbEzMD8zcKngE4pmcabfkX3aOfs2ng2Fde0DIWGMYjTdDB4Z+DPSvbyAbr75VZex1XwsZQwvOZNTw/bzu95wAkmClhFMJ/c3rQAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730440133; c=relaxed/simple;
	bh=Qhg1ePt6bI7vC06KC8D9a1xSNzp4aHzxpV/8S+8WCz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgiyCkDrfO8biwUwaIsP5LBVBfqJzf0+eAEf967RCwijAlASyrZrXsLmPEAtoWdst+dthVFPgnurLsmvlXpjwBFqsSoi+68DdcTvD6QSjPPv/R1KHVPbOGgu8B3KCakrGjcY9C1cOmryRtbuTdrOD1cWjpqw7BlbAjkUc4jRY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0FE3368BFE; Fri,  1 Nov 2024 06:48:47 +0100 (CET)
Date: Fri, 1 Nov 2024 06:48:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] block: lift bio_is_zone_append to bio.h
Message-ID: <20241101054846.GB13514@lst.de>
References: <20241101052206.437530-1-hch@lst.de> <20241101052206.437530-3-hch@lst.de> <f376f179-0173-49b4-b4c6-0cabb8720dfd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f376f179-0173-49b4-b4c6-0cabb8720dfd@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 01, 2024 at 02:37:29PM +0900, Damien Le Moal wrote:
> > +static inline bool bio_is_zone_append(struct bio *bio)
> > +{
> > +	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
> > +		return false;
> 
> Nit: this "if" is probably not needed. But it does not hurt either. Since we
> should never be seeing this function being called for the
> !IS_ENABLED(CONFIG_BLK_DEV_ZONED) case, should we add a WARN_ON_ONCE() ?

The point of the IS_ENALBED is to optimize away the code when it can't
be used.  The WARN_ON_ONCE would generate worse code than just leaving
the check in.



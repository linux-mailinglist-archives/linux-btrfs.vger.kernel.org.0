Return-Path: <linux-btrfs+bounces-9290-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E779B8ABD
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 06:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35ACD28311C
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Nov 2024 05:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C1314A4E7;
	Fri,  1 Nov 2024 05:48:13 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA2C36B;
	Fri,  1 Nov 2024 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730440093; cv=none; b=r2Grm2eVofYxEmhAmDGdSSJB2Bx8dKe3k1wtiAG4Q+ebG8g19plKh3xNAsM654NULRcZLdiqL8praLwdyUSe4rVsgzuOaZbhmxOrQ8y4RhIzoNNLmTu/KlXo0rwZv4DxoGW/WQgYDIKsT1nsB2FlclkNXgLiRFvYD9O3A42jAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730440093; c=relaxed/simple;
	bh=2+p9S04MnfsE4Qq7aCwKKlwQCyi+HdVNuNWlezcIlYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHEe+f6ioI1FD36BmvGQg5wb/IuiL96/wURXxYe3UbyvHw+vSXVWZZiVj1NHGdibfYy16n2ZK8XEqVnaOJ+4da9WWTPPO1178dq5sW6dIyvhaSh2/pXCpJX72tGRPYi5QxoQhGHIPtDiRgLf45t0ZkKrEq0YXXxk5mAMP53r2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7818F68BFE; Fri,  1 Nov 2024 06:47:59 +0100 (CET)
Date: Fri, 1 Nov 2024 06:47:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/4] block: fix bio_split_rw_at to take
 zone_write_granularity into account
Message-ID: <20241101054759.GA13514@lst.de>
References: <20241101052206.437530-1-hch@lst.de> <20241101052206.437530-2-hch@lst.de> <a7b87e01-045e-423e-854d-4707f9102c75@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7b87e01-045e-423e-854d-4707f9102c75@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 01, 2024 at 02:34:31PM +0900, Damien Le Moal wrote:
> > -	bytes = ALIGN_DOWN(bytes, lim->logical_block_size);
> > +	bytes = ALIGN_DOWN(bytes, lim->zone_write_granularity ?
> > +			lim->zone_write_granularity : lim->logical_block_size);
> 
> Nit: we could also do:
> 
> 	bytes = ALIGN_DOWN(bytes,
> 		max(lim->logical_block_size, lim->zone_write_granularity));

That's what I had first.  It is a little odd as zone_write_granularity
is defined to be >= logical_block_size, though.

> Also, I wonder if we should leave read split as is based on the logical block
> size only ? Probably does not matter much...

Good point.  Probably doesn't matter much, but randomly forcing it on
reads seems odd.



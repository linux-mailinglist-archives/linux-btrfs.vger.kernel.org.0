Return-Path: <linux-btrfs+bounces-4720-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B14578BAA7A
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 12:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BF822850CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 10:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4576C14F9FF;
	Fri,  3 May 2024 10:05:12 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2B14F13D;
	Fri,  3 May 2024 10:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730711; cv=none; b=TfHt1x6NPwtRk5vtSbVKfLWjmz1FObhj1KF5xyCX09gosyTtyPbfDvvJoJ7XoP38og66XbZq5Tq9WWO8ecZoqvpUufqJSfzapPjWHFRDEMDQVdEP8m7f6EnX9NRkHI1vzgC6ZZew+YmeiWDz114pA+eBRxwFWesdiYnoocjm1JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730711; c=relaxed/simple;
	bh=e22x0eqZxRWRqz9PfvdKnLsarqtsA1Yl0XOD+CZqttw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSO3VWK2bayV8dkmdeHaECpST0w76+ORiAq1XKI47aKkYKhE8764nbTO3qH9JSw7H097KY+D7QELtvx1DdDFo+jVlBcB6/sRTt9Z7tBLLWkakboTLwFTcDwuBdS6yY4+qEG/DY5paqzRSBxrFxAEl9y0jMtAVAnfyt5Jy2GTNiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s2pmk-009tz8-2L;
	Fri, 03 May 2024 18:04:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 03 May 2024 18:04:58 +0800
Date: Fri, 3 May 2024 18:04:58 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
Cc: Josef Bacik <josef@toxicpanda.com>, clm@fb.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org,
	qat-linux@intel.com, embg@meta.com, cyan@meta.com,
	brian.will@intel.com, weigang.li@intel.com
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate
 through acomp
Message-ID: <ZjS2yjWQHYSSEldZ@gondor.apana.org.au>
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
 <20240426110941.5456-7-giovanni.cabiddu@intel.com>
 <20240429135645.GA3288472@perftesting>
 <Zi+7CnWeF9+DUXpK@gcabiddu-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi+7CnWeF9+DUXpK@gcabiddu-mobl.ger.corp.intel.com>

On Mon, Apr 29, 2024 at 04:21:46PM +0100, Cabiddu, Giovanni wrote:
>
> @Herbert, do you have any objection if we add the compression level to
> the acomp tfm and we add an API to set it? Example:
> 
>     tfm = crypto_alloc_acomp("deflate", 0, 0);
>     acomp_set_level(tfm, compression_level);

Yes I think that's fine.  I'd make it a more generic interface
and model it after setkey so that you can set any parameter for
the given algorithm.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


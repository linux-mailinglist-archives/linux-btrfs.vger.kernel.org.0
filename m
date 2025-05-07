Return-Path: <linux-btrfs+bounces-13758-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEC8AAD341
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 04:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F5E79830E5
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 02:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C5519066D;
	Wed,  7 May 2025 02:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="b5worlEq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1921BA38;
	Wed,  7 May 2025 02:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746584648; cv=none; b=CM4Bc/DyMewoMmyVCcvUXBbAlGjtBB3RPpFSu+87HerLCjquk0+vqwKiNsuW6jVfCUIkdcrNd9qUOcXzbnhWJ6799rbd4XCC/R6NGDqy6DLbYgNImb22oQmjuz26TS19W5FmzXiIJquU45TJlKQ4V92TAyBklxAhjFn6UfDx+Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746584648; c=relaxed/simple;
	bh=oxVwR6k7jtHXBxy+y8dD5QPIH1Jzp6vp9TS+uJ4sHj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNnn2k/YmLVFWTJan5uLCDKfs2o8EcABLweCw+AEZF1YzajneopTJW6WnJGDo9hZ4rHbhg+gtpqRYrtqbXdFb4g5QYyJErvg9zgJjsZIXaYQ2OU+K6ezV3HmfvCjnp+c+If7HgHW9OaTeETBw9+WgzeRGEkpQbEVE5FlJ6/Z8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=b5worlEq; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mjQpoPzciVzeraBHDbJpOZa1vh7CWFxORP0jPzBi4cE=; b=b5worlEqzPvOEQPGBb8vPTY0w9
	XchtEOvTtexqwL88pfI/pnAbpOKmfEHdg/1kJxHao0yUAAWNqNcTxDNbR/CLlGWesDPJIbq1zX2pE
	SkHe8IA7YDEQFF/Fl6cVP0vCH8XhkIceb5v7E6r98kfx6+pfo/wrcK8AR7QwKlyqZHmxVbGBm58H3
	KqBZjlA7J1XpQ0mb6vF7s8DBiUFmuS6ZFtFQ13LP4aoHL3+tZQWXBUW1A4Zx8ShmA1Ne5Vw/b9C03
	NA4h3vfpw8gbyvFZZIoAd6bO6QMPEUIcAhc8BpJXCS1DjZsaVK1TpZdnz0sRRqSjqMZ586MUgvcSN
	F1E5GULw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uCURt-00474U-1Q;
	Wed, 07 May 2025 10:23:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 07 May 2025 10:23:53 +0800
Date: Wed, 7 May 2025 10:23:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>
Cc: "dsterba@suse.cz" <dsterba@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	"clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	qat-linux <qat-linux@intel.com>, "embg@meta.com" <embg@meta.com>,
	"Collet, Yann" <cyan@meta.com>,
	"Will, Brian" <brian.will@intel.com>,
	"Li, Weigang" <weigang.li@intel.com>
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate
 through acomp
Message-ID: <aBrEOXWy8ldv93Ym@gondor.apana.org.au>
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
 <20240426110941.5456-7-giovanni.cabiddu@intel.com>
 <20240429135645.GA3288472@perftesting>
 <20240429154129.GD2585@twin.jikos.cz>
 <aBos48ctZExFqgXt@gcabiddu-mobl.ger.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBos48ctZExFqgXt@gcabiddu-mobl.ger.corp.intel.com>

On Tue, May 06, 2025 at 04:38:11PM +0100, Cabiddu, Giovanni wrote:
>
> > We'd have to enhance the compression format specifier to make it
> > configurable in the sense: if accelerator is available use it, otherwise
> > do CPU and synchronous compression.
> For usability, wouldn't it be better to have a transparent solution? If
> an accelerator is present, use it, rather than having a configuration
> knob.

If you go through the Crypto API you won't need to add a new knob
at all.

The Crypto API is already configurable and comes with a knob
pre-installed.  Just download crconf and you can configure which
algorithm will be used by default:

https://git.code.sf.net/p/crconf/code

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


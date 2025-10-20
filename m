Return-Path: <linux-btrfs+bounces-18075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C72BF2CA1
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 19:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B31EA4F930A
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 17:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D3D332908;
	Mon, 20 Oct 2025 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YZ8T1a4o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376B526B755;
	Mon, 20 Oct 2025 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982260; cv=none; b=J0w+8SeeIpL/M3iESarTwuYvobn/G6bt5TyC42HeXqBkM4J2cohAH7zOX0q2qm/hjPQo3ouYhyR9DrTzLfC/gyHDqSNE+l4XFP3O17cyITskh0XdfslgXA0ANeQUfWbp0d37o1n8KTlF8yxot04ZDTMRwIneD8MA6M7+kx/OuZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982260; c=relaxed/simple;
	bh=16sgzFk1cntQsUCQDvlwtn5r06wejinqXhOCoj9sMxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMQxs4+r2pOWQm5oBYA8uZQy1SrGQWtMHcZWWTs/lwylxObDKdfeYuP7kdUk2t+cKGFfa63Varmbh/Wepqnoih9UnO19vIOvo6tdNBbVbwBJwINCrm1WBIRITkrRaMkCVBkJB9aDbRwc3vp1CiiUVEkRWe9yQvVkWJubgEWSr0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=YZ8T1a4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048D2C4CEFE;
	Mon, 20 Oct 2025 17:44:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YZ8T1a4o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1760982257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qxyQGLFJiDfo9EbmIoP7N27VSgBp0AMlllTAAYrklG4=;
	b=YZ8T1a4oUMWrj+x0InaaoJC7QwohPIHM/oqgsXcNnhFikzBW5pdNCQ+OkZmI7PTDLwwB3j
	2eerl5yZ7sP1Xvm1HlB3ah6lk0cewWUi0Fh8dNijlcf2aWfoWRwyh//gUG37MAY4kZ+FAj
	QnEF1HeHczvHxDYGVKxHa0PA03T7mlw=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f88f6c01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Oct 2025 17:44:16 +0000 (UTC)
Date: Mon, 20 Oct 2025 19:44:13 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 01/10] lib/crypto: blake2s: Adjust parameter order of
 blake2s()
Message-ID: <aPZ0OU75EuC3tlxn@zx2c4.com>
References: <20251018043106.375964-1-ebiggers@kernel.org>
 <20251018043106.375964-2-ebiggers@kernel.org>
 <aPT3dImhaI6Dpqs7@zx2c4.com>
 <20251019160729.GA1604@sol>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251019160729.GA1604@sol>

Hi Eric,

On Sun, Oct 19, 2025 at 09:07:29AM -0700, Eric Biggers wrote:
> On Sun, Oct 19, 2025 at 04:36:36PM +0200, Jason A. Donenfeld wrote:
> > On Fri, Oct 17, 2025 at 09:30:57PM -0700, Eric Biggers wrote:
> > > Reorder the parameters of blake2s() from (out, in, key, outlen, inlen,
> > > keylen) to (key, keylen, in, inlen, out, outlen).
> > 
> > No objections to putting the size next to the argument. That makes
> > sense. But the order really should be:
> > 
> >     out, outlen, in, inlen, key, keylen
> > 
> > in order to match normal APIs that output data. The output argument goes
> > first. The input argument goes next. Auxiliary information goes after.
> 
> In general, both conventions are common.  But in the other hashing
> functions in the kernel, we've been using output last.  I'd like to
> prioritize making it consistent with:

Hm. I don't like that. But I guess if that's what
every-single-other-hash-function-does, then blake2s should follow the
convention, to avoid churn of adding something new? 

I went looking at C crypto libraries to see what generally the trend is,
and I saw that crypto_hash from nacl and libsodium and supercop do `out,
in`, as does cryptlib, but beyond that, most libraries don't provide an
all-in-one-interface but only have init/update/final. So however you see
fit, I guess; I don't want to hold up progress.

Jason


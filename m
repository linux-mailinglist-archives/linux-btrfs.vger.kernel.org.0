Return-Path: <linux-btrfs+bounces-13821-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F696AAF210
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 06:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4586B1B66B7A
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 04:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5B8204090;
	Thu,  8 May 2025 04:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY0zu2oz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C978F37;
	Thu,  8 May 2025 04:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746677960; cv=none; b=V1O7bypNaSYWXdg6oTKvUltooCdyFC997WSqTS7CA14YNrYLi6fzVBa1tvpJRVrPj3a7okh4k7uS/aM+Pzbd9G+KR2BEAPV85v0s67WsHO/PyEiqP3LFAOw1yeSQdjf/9g7vqveDXzYac8f1ELlc1QKujxF4R97BUEJO6lhUfu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746677960; c=relaxed/simple;
	bh=Hu8NY9n961A/FBCHtTw8bjxVHEHWxXZ0tidmYP4RCZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnl6UefbbwjIUNRL22CqdVEJLxfsLh8NJ4Fjs4eJTtaymWI0QOTGdX5e77vKEU8cSPngRlbCccnU4bbcx0KBeHtwgU3yypXCEK2SkVZKcCQvd6L+0Rv64R1Df09/m9U8gTJ92fvRLP3DFwAKvMYf4JfZRk8Rd0+mLjOR7TxnMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY0zu2oz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F67C4CEE8;
	Thu,  8 May 2025 04:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746677960;
	bh=Hu8NY9n961A/FBCHtTw8bjxVHEHWxXZ0tidmYP4RCZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CY0zu2ozYym4TdyWzRLtc1OkyRiFi8gJyrx1RmEdIo/TwdMXhmv/o1AqF/g18Vb4W
	 Pn2HKxPp3xDZrQFCbYHQ90Hn+5r1rmhKmMOtPlT/Qsk+PnEwwPZHUcLBHnJ3rxlYil
	 pRecnrgksWkx0rO135zsad4FhdqlhHCEq5yjvUgSQVuHITxtxRMHN1fmD3zXvwdtDM
	 4nsb4cU0fUw6PsMWVS1d0VovXhg5bhRKiPsESUR6K+MzyHeliBh5p8hUqK06N0WBDa
	 +1wA0a5KG+ZJyDypCVZ49KtReV4cq8Dc0Z0K+M7HfjbV+GpbCaLPtirpByOv4jYSTw
	 kqZTTc/H7tFlQ==
Date: Wed, 7 May 2025 21:19:14 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
	Josef Bacik <josef@toxicpanda.com>, "clm@fb.com" <clm@fb.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	qat-linux <qat-linux@intel.com>, "embg@meta.com" <embg@meta.com>,
	"Collet, Yann" <cyan@meta.com>,
	"Will, Brian" <brian.will@intel.com>,
	"Li, Weigang" <weigang.li@intel.com>
Subject: Re: [RFC PATCH 6/6] btrfs: zlib: add support for zlib-deflate
 through acomp
Message-ID: <20250508041914.GA669573@sol>
References: <20240426110941.5456-1-giovanni.cabiddu@intel.com>
 <20240426110941.5456-7-giovanni.cabiddu@intel.com>
 <20240429135645.GA3288472@perftesting>
 <20240429154129.GD2585@twin.jikos.cz>
 <aBos48ctZExFqgXt@gcabiddu-mobl.ger.corp.intel.com>
 <aBrEOXWy8ldv93Ym@gondor.apana.org.au>
 <20250507121754.GE9140@suse.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507121754.GE9140@suse.cz>

On Wed, May 07, 2025 at 02:17:54PM +0200, David Sterba wrote:
> Anyway, assuming there will be a maintained, packaged in distros and
> user friendly tool to tweak the linux crypto subsystem I agree we don't
> have to do it in the filesystem or other subsystems.

I don't think there ever will be.  NETLINK_CRYPTO is obscure and hardly anyone
uses it.  The kernel's generic crypto infrastructure is also really cumbersome
to use, so the trend in the kernel overall has been a move away from the generic
crypto infrastructure and towards straightforward library APIs (e.g.
lib/crypto/) that just do the right thing with no configuration needed.

btrfs already uses the compression library APIs.  Considering how disastrous
crypto_acomp has been so far when other people tried to use it, most likely the
right decision will be to keep using the library APIs for the vast majority of
btrfs users, and have an alternative code path that uses crypto_acomp only when
hardware offload is actually being used.

There may also be a way to rework things so that the compression library APIs
can use hardware offload, in which case the crypto API would play no role at
all.  I understand the Zstandard library in userspace can use Intel QAT as an
external sequence provider, so it's been proven that this can be done.

BTW, I also have to wonder why this patchset is proposing accelerating zlib
instead of Zstandard.  Zstandard is a much more modern algorithm.

- Eric


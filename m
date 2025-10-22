Return-Path: <linux-btrfs+bounces-18170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1384EBFDBF7
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 19:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7751883026
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 18:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8AB2E7161;
	Wed, 22 Oct 2025 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNZ/D84O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A3B35B131;
	Wed, 22 Oct 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761155976; cv=none; b=F6M6bgy2HhKYTi5mZnkFqQN4gbauS5PVdF6rUFWz8MLC3vI+Nk0dNPl9o+VDJ4BVl6lMwtkn5ho/Hf5bc/OiFoVrsAKgiOvhD2z6u3C1K8d/c7LzPfMXs033DHqhNnuB/RjK4G1xo9seufIVukM1kuyMJN6MBuUr+g9vsgn+KRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761155976; c=relaxed/simple;
	bh=9gx3OGdb0uIusRT1OUkumJNGerW8QboTuA02KwXp8SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALtrFHDsqceMXKlmjnW/nI/dfR9t112PMVdyGiqaFzCihy0PGF84OeQxMxwlIS0MK8eq4qSbd6LVhaezojhr0mDeuWhjGH6UFzhGD2HzLoRr6pDf1bsrjaZ4Db71ZHxM81TcHXu5aJ3qFeoVAmkQaJYq/1wOOQVUKDcVepo/ax4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNZ/D84O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEF8C4CEE7;
	Wed, 22 Oct 2025 17:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761155976;
	bh=9gx3OGdb0uIusRT1OUkumJNGerW8QboTuA02KwXp8SA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNZ/D84OnEvWq0hPHRa2JfYwECvRchIFPwxWBOcwmcTyOTRVtou0qZVOs0Hzqtt55
	 bmhRtjKgQLPobPbaWutj5XMInarn6n3p0Ci7nSAAhvZol1PyIZz4FlhCO5Xzybk5Ap
	 p5PPk5+QbMfgNKZVTQwB/ah5K80YdWgL2/CcqClk9T2bsGuUHE7Le1JA0Z27yGsPoC
	 131sA5lcua4B/QAOwg2wm1MFmn0xbE9nejABosRPJ6wXpLVFtI3oNq5rVu4k6JTrQQ
	 Zh9fn3pfxrHxaregnyfdSIH+VrcbN5/sPU78OnCS1/MJ/8Ygd7tPpcmt1gMWISTFxL
	 iTbRaCRExEjXw==
Date: Wed, 22 Oct 2025 10:59:34 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 10/10] btrfs: switch to library APIs for checksums
Message-ID: <20251022175934.GA1646@quark>
References: <20251018043106.375964-1-ebiggers@kernel.org>
 <20251018043106.375964-11-ebiggers@kernel.org>
 <20251022071141.GV13776@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022071141.GV13776@twin.jikos.cz>

On Wed, Oct 22, 2025 at 09:11:41AM +0200, David Sterba wrote:
> On Fri, Oct 17, 2025 at 09:31:06PM -0700, Eric Biggers wrote:
> > Make btrfs use the library APIs instead of crypto_shash, for all
> > checksum computations.  This has many benefits:
> > 
> > - Allows future checksum types, e.g. XXH3 or CRC64, to be more easily
> >   supported.  Only a library API will be needed, not crypto_shash too.
> > 
> > - Eliminates the overhead of the generic crypto layer, including an
> >   indirect call for every function call and other API overhead.  A
> >   microbenchmark of btrfs_check_read_bio() with crc32c checksums shows a
> >   speedup from 658 cycles to 608 cycles per 4096-byte block.
> > 
> > - Decreases the stack usage of btrfs by reducing the size of checksum
> >   contexts from 384 bytes to 240 bytes, and by eliminating the need for
> >   some functions to declare a checksum context at all.
> > 
> > - Increases reliability.  The library functions always succeed and
> >   return void.  In contrast, crypto_shash can fail and return errors.
> >   Also, the library functions are guaranteed to be available when btrfs
> >   is loaded; there's no longer any need to use module softdeps to try to
> >   work around the crypto modules sometimes not being loaded.
> > 
> > - Fixes a bug where blake2b checksums didn't work on kernels booted with
> >   fips=1.  Since btrfs checksums are for integrity only, it's fine for
> >   them to use non-FIPS-approved algorithms.
> > 
> > Note that with having to handle 4 algorithms instead of just 1-2, this
> > commit does result in a slightly positive diffstat.  That being said,
> > this wouldn't have been the case if btrfs had actually checked for
> > errors from crypto_shash, which technically it should have been doing.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> 
> Thanks, this simplifies quite a few things. I'd like to take it via the
> btrfs tree as there may be the hash additions (XXH3, BLAKE3) but
> currently I'm not sure if it won't make things more complicated. I
> haven't started the kernel part yet so I can use this patchset for
> development and rebase once it's merged. 

Great.  I'm planning to take patches 1-9 through libcrypto-next for
6.19.  You can then take patch 10 through the btrfs tree for 6.20.  Does
that sound good?  We can work out the XXH3 and BLAKE3 support later.  If
you'd like to add another checksum algorithm, I'd suggest picking just
one.  btrfs already supports an awful lot of choices for the checksum.
But we can discuss that later.

- Eric


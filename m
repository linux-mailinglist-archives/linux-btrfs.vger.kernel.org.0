Return-Path: <linux-btrfs+bounces-18015-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 991BCBEEA24
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 18:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D33094E7D43
	for <lists+linux-btrfs@lfdr.de>; Sun, 19 Oct 2025 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56592EAB6A;
	Sun, 19 Oct 2025 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoZUXiWm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845B18DB1E;
	Sun, 19 Oct 2025 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760891663; cv=none; b=JtIdAnzlI1KP1dVIbgD2W1Dy7zi9o9iqFrhMHx+388xOaYIauG7Yf3IxmjSW6vg4uhogKHPvOtm8Tt5jWHg7/tjpR42ACqhV9nkpaxv3itxfOQWJ/LvJFgXWFwa0whLFxIYLeqRtdAxTSGywf91OktMAlpo+Q5hFFlhaVdG4oEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760891663; c=relaxed/simple;
	bh=/NRRdUmhRaH39Ejf4m2sUH6ftZqYfftBYvCOeLeAB+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcA7IBKR6xM0HJ/860tjDe/2KEqiuQn1FQ0A1GbkzRImVUYjyP8eCKnS684cARjk+jWr4amf/HTCuARqmXorsmgVUpbLOdTqCaUJi4QXycjIqiPIbjtuO5VZrsN0lTmhybY0vxQ6RVb9KT2LE3F3vOosoTg84oO+2kmmiGze5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoZUXiWm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332D9C4CEE7;
	Sun, 19 Oct 2025 16:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760891661;
	bh=/NRRdUmhRaH39Ejf4m2sUH6ftZqYfftBYvCOeLeAB+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uoZUXiWmUFW10a1JTRZpdih6o4vHlP6bLJG6+06VXJktkSRm5Cd1TCmTxS16rNd3r
	 ALWQjIRSV0xCsBZEgp/pOMiuYIm8CFcgfzYYWFPjb4Nlx9f91YPKQdbnXnZPJ7Awdt
	 GGsuTRrvl8QYJGVpKaOH4muF2nAt0BVsJpCdyay7gdd2r/qC7ct6zdwfMc1HF4ELBU
	 TubNBemLY6OZIWcDwHOLWFmlDg/38Nhg///DHb4PkvMqBn35EwzpwTl2Rti+H5cw6q
	 Ci8iYFVrH1ttyCOQcvjnOEOs9Z3G4rHqYVpkYpsdNg9COpzB/0XFwcT5W6VEGN71Qq
	 EfSnAFK+zQuoA==
Date: Sun, 19 Oct 2025 09:32:49 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 07/10] lib/crypto: arm/blake2b: Migrate optimized code
 into library
Message-ID: <20251019163249.GD1604@sol>
References: <20251018043106.375964-1-ebiggers@kernel.org>
 <20251018043106.375964-8-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018043106.375964-8-ebiggers@kernel.org>

On Fri, Oct 17, 2025 at 09:31:03PM -0700, Eric Biggers wrote:
> diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
> index f863417b16817..5c9a933928188 100644
> --- a/lib/crypto/Makefile
> +++ b/lib/crypto/Makefile
> @@ -34,10 +34,11 @@ obj-$(CONFIG_CRYPTO_LIB_GF128MUL)		+= gf128mul.o
>  obj-$(CONFIG_CRYPTO_LIB_BLAKE2B) += libblake2b.o
>  libblake2b-y := blake2b.o
>  CFLAGS_blake2b.o := -Wframe-larger-than=4096 #  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105930
>  ifeq ($(CONFIG_CRYPTO_LIB_BLAKE2B_ARCH),y)
>  CFLAGS_blake2b.o += -I$(src)/$(SRCARCH)
> +obj-$(CONFIG_ARM) += arm/blake2b-neon-core.o
>  endif # CONFIG_CRYPTO_LIB_BLAKE2B_ARCH

Correction: it should be

    libblake2b-$(CONFIG_ARM) += arm/blake2b-neon-core.o

- Eric


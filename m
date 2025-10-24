Return-Path: <linux-btrfs+bounces-18314-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AC9C07E3C
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 21:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597DB19A7EA2
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 19:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C805728C849;
	Fri, 24 Oct 2025 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYE4+xI7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08778286430;
	Fri, 24 Oct 2025 19:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333715; cv=none; b=NlkMUvzcr63jVmo6ZPfoNPB+rBz3ecdT8DXCTmEOoCg/o4E2Yl8cCgGdGna57VZkKyi49cRsQEyyibSd03dGgtNJPu7bIux9L9mMzVm4HVltJTnYO2ABEMRLVScH8hnZKmDtBwDmovM616N0Ic1RqyE/Z8FzJPS94r1F9Q7t3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333715; c=relaxed/simple;
	bh=zajPlJnvLIMbpj18tt9XU5F6klgXeRifknETT3f00Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQlASLxDsQSBkdiCOX6KtuX/nYE5KDDYS714umhJVflO3hul7rwO8YP1u7cPA8jJ7tD1oFOlAg5V+P+qQVnyi4WYlrzSpi43es5aYczO/JSFp4PcSfK2M4djt/j/lE6JK/tSbzLlT7ThyNDzLA7vGfD5XzNNg72sbruJ6jnlVxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYE4+xI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D9DC4CEF1;
	Fri, 24 Oct 2025 19:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761333714;
	bh=zajPlJnvLIMbpj18tt9XU5F6klgXeRifknETT3f00Yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gYE4+xI7/IgZhpd7y0gND/WB2m9og01WSNl8xqVgmsKloP8wozlAsva8mAXNLOLhj
	 +n06GmuvHtqMxpASGF78jb6nC8nF7fzU0gO7d1tWMFPBsjv7LPSa9L2vbzLPfDbACz
	 zNjm/0XNRz0G7Pk2+YW8tMZRevxOYMhFXzG4txrul0hxn4ITKe0+hvMY2u0zDiCKme
	 I6lc9edBxfmWJuX9hOL1lUnMOsAmIUdgdGJfRACwha5AjkgcrUFjCfDUFZR8wlRi29
	 MPbqftOf51ATChWK2hvnE7Zed+gIcFXlVGCjwiKcDgZc3AQu1gb8g86XbRfs/Am7uf
	 TAdNdCZD9JRMQ==
Date: Fri, 24 Oct 2025 12:21:52 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 00/10] BLAKE2b library API
Message-ID: <20251024192152.GB2068@quark>
References: <20251018043106.375964-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018043106.375964-1-ebiggers@kernel.org>

On Fri, Oct 17, 2025 at 09:30:56PM -0700, Eric Biggers wrote:
> This series can also be retrieved from:
> 
>     git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git blake2b-lib-v1
> 
> This series adds BLAKE2b support to lib/crypto/ and reimplements the
> blake2b-* crypto_shash algorithms on top of it.
> 
> To prepare for that, patches 1-4 clean up the BLAKE2s library code a
> bit, and patch 5 adds some missing 64-bit byteorder helper functions.
> Patches 6-8 add the BLAKE2b library API (closely mirroring the BLAKE2s
> one), and patch 9 makes crypto_shash use it.  As usual, the library APIs
> are documented (with kerneldoc) and tested (with KUnit).
> 
> With that done, all of btrfs's checksum algorithms have library APIs.
> So patch 10 converts btrfs to use the library APIs instead of shash.
> This has quite a few benefits, as detailed in that patch.
> 
> Patches 1-9 are targeting libcrypto-next for 6.19.  Patch 10 can go
> through the btrfs tree later.
> 
> Eric Biggers (10):
>   lib/crypto: blake2s: Adjust parameter order of blake2s()
>   lib/crypto: blake2s: Rename blake2s_state to blake2s_ctx
>   lib/crypto: blake2s: Drop excessive const & rename block => data
>   lib/crypto: blake2s: Document the BLAKE2s library API
>   byteorder: Add le64_to_cpu_array() and cpu_to_le64_array()
>   lib/crypto: blake2b: Add BLAKE2b library functions
>   lib/crypto: arm/blake2b: Migrate optimized code into library
>   lib/crypto: tests: Add KUnit tests for BLAKE2b
>   crypto: blake2b - Reimplement using library API
>   btrfs: switch to library APIs for checksums

Applied patches 1-9 (i.e., all except the btrfs patch) to
https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next

I folded the following fixup into patch 7 to address
https://lore.kernel.org/r/20251019163249.GD1604@sol/ and
https://lore.kernel.org/r/202510221007.WnlC6PmP-lkp@intel.com/

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 5c9a933928188..bc26777d08e97 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -37,5 +37,5 @@ CFLAGS_blake2b.o := -Wframe-larger-than=4096 #  https://gcc.gnu.org/bugzilla/sho
 ifeq ($(CONFIG_CRYPTO_LIB_BLAKE2B_ARCH),y)
 CFLAGS_blake2b.o += -I$(src)/$(SRCARCH)
-obj-$(CONFIG_ARM) += arm/blake2b-neon-core.o
+libblake2b-$(CONFIG_ARM) += arm/blake2b-neon-core.o
 endif # CONFIG_CRYPTO_LIB_BLAKE2B_ARCH
 


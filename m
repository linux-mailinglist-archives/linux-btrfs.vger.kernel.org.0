Return-Path: <linux-btrfs+bounces-18163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B995BBFB4C9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 12:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A392400B98
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 10:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F196E31AF0E;
	Wed, 22 Oct 2025 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ3RRgau"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6343164B1
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127576; cv=none; b=OTKmGciXEnsLvNzi06nvqwy0T6ueP/Y/YZrO5Oqzn+1Xnmyfldk8Gr4u4lvFaYRgzcJ8dAhkWdf4ZtmzJc5rm9yG1lEReqE32fGFbgxrQ1sd4Vq3aoAdIALRvMNrvIKrimhUzZV963DsNnI7PEcHBTIJjd4+xBXtQ08H61uItIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127576; c=relaxed/simple;
	bh=YjoTV+qcYnMvMR+XsIYNmyvY6Y1XWrBQdEZTQ1QtXaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Al0pDvbJ6F7VxOyJV6ouD4xp9j41VariSySQI52Hiti2yAPO0EBGvEbYhBxnPeRtAp7nW7KdFv5sCYs4FW7Vz+YXuWx5wEL0rytsZIcgxiybDLRwTwVDgesautfv4nbgYCnGydCKOHZQUylh1bz5UFjRbhNwGeCs29TW7JrZefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ3RRgau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB73FC4CEE7
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 10:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761127575;
	bh=YjoTV+qcYnMvMR+XsIYNmyvY6Y1XWrBQdEZTQ1QtXaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lJ3RRgauYL2s1q2mrj02T4mhG/3jEuS3L47Y2Ptl8NII5BooZQVEual2l0fPnJnV/
	 Ivbdm4cyPvZuGOIJ2X/NyLN7wAz1RSRUUfZgUxBBHXFyAsCMxx400RsrP8xdWd7XpM
	 EDtq/sivF/R/BhCUYuW87jhA92jAd3Y+p0Os7nEe8EBDqOBZRmBZIb/gtwlHU48a4O
	 7j7Q7umK4JwbokbOtCjigXyev8DnYEQ3hhTuJ1gLIC7lHVHq9bBchiUx6SM0jV8Qch
	 nTDxQVrPB/S7TpBv6LBpE0cZSr7HZiJZ4xsa4fB17+4uAj61+puaDZitBj0OPkj10q
	 dGQA1g9yKmysQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57992ba129eso7855732e87.3
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 03:06:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWnOAZZJz/KxOCMzBHwmH+9EufKw6j6xQXiBiaUaSoOuXbe5pIC1twdtc27YxaL7+qTZzu2y7PDsYpCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKDPR64JQ2wBD0tsNfPePMut7BciChtDfkdOd4o0AgCtjiNsUM
	LSEuHLiwTe0MShh61PTwsvEKlqr4Od897neSxgSz/nAyQR/tONqlqp8yc/Eqzflc/FKNab/L1Tp
	U8MbEM38A6kCV9CtT0zmbnr3wNCYXfdk=
X-Google-Smtp-Source: AGHT+IEz0x//kso/iNTS21v0xmTCFoU040wkVDk2FAWrns4i2WZvwnraWiRmT9a7dZUqlR2yjlPI5muBgbBSVJSiBMU=
X-Received: by 2002:a05:6512:ea3:b0:592:ee1f:227a with SMTP id
 2adb3069b0e04-592ee1f25e8mr889209e87.43.1761127574241; Wed, 22 Oct 2025
 03:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018043106.375964-1-ebiggers@kernel.org>
In-Reply-To: <20251018043106.375964-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 22 Oct 2025 12:06:02 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFNw73j2F2QQJQ8CDXj1qfpK-xE+TRnRZoak5OhVDPA3w@mail.gmail.com>
X-Gm-Features: AS18NWBgd42L4tDl9i3Mf7M4zRNkrg9sTyvbPU9kg_gjKmxPKesRTrDlO8EAPyY
Message-ID: <CAMj1kXFNw73j2F2QQJQ8CDXj1qfpK-xE+TRnRZoak5OhVDPA3w@mail.gmail.com>
Subject: Re: [PATCH 00/10] BLAKE2b library API
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 Oct 2025 at 06:36, Eric Biggers <ebiggers@kernel.org> wrote:
>
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
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


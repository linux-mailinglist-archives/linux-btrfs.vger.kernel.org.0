Return-Path: <linux-btrfs+bounces-19543-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 317F9CA7AFC
	for <lists+linux-btrfs@lfdr.de>; Fri, 05 Dec 2025 14:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EDE3304DA1F
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Dec 2025 13:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFE533FE08;
	Fri,  5 Dec 2025 13:06:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E38D2F49EC
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Dec 2025 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764940002; cv=none; b=cvER0wJddkwnVyBcwbsaOpna21hapDYW2DjhIJcgdBBvsvkGmwgRxzulzywzBIlnGbLlNiLivtIAHv27XhsF534O0cQ1fQbtUWwHWB3oLlB8tflj2Su7Qeo/HyPZKIWQH501cFo7YA6B/N3HMOciPkWhUHKtSFWlC5pt7O0dqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764940002; c=relaxed/simple;
	bh=1EBb19I7TXyr0Wc23Pl3IU7EwdnF5SMRtXHCjSD0p9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngmJ1ToQE1xBnQffn015P5KmhxFcOYuz1GCiuv0lIXnhLmQ26vxtL+phtHDCYVtluLHnc9l9ffcAsr1CRGAZXpEUxoXbT1tRGSwgUxWelwPQ0Tm1Lg5/qn02xkk8jYr8HabqSPUqiafc8H/TYQu9zOvXVoRSvd/sBe5cuDGNPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3f0c93ecf42so2314841fac.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Dec 2025 05:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764939997; x=1765544797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aMjf00fvZ2LGfiVehlweJ/JHTaRsyCeBS7wev6/MCNc=;
        b=PkX8qGP5LnOZktRNpYdvjZeYRjpEAnd/KBC9SPH1i9eC0kD/xtLRvifvn2JBK0aO2b
         6/jwTWJq5bcxkfmKcKdtWZNUeGQVSEIP6va3tJx/OUtp7dfrnnpyo2HVG8kab/WyR1zN
         Jh4ELATEqOrORoJSEB1GWhB4/4RlKzaX1Ffnf1rydDNEIz1+hZkOcVo0E8Dacu26WH3c
         6gb929A7RCVT9ia8hyGD5THLCDBMiYEwnPqPTpElqx1SJemp+ddhj7FK3f8K7DZHNyth
         2enjtemkLX6QjZ+l8VqDkPwXMKFzEahgpSTC+4q4a1ZBEjP+0QPSspeK32kqwJSGaD2C
         Wv8A==
X-Gm-Message-State: AOJu0YwUe+9j3y7prBDEAI2Zj8XHQ7Ll+lTLml00jrBysA18E2lvYaPF
	/DrkLNivvWyVw3oqL9g3lBlVcEwkXeRM4PO3aG6n7G2xJbdGqmc7y+37AfS7Tw==
X-Gm-Gg: ASbGncumFWFCMrXwaH1w40wXx6013iy9MVRr5gLqFj9I2aWs2Wx0YfVDxn4H8xfdZdg
	XOnaVB+uvTLAbTZ9IPGA8rPu3KQ614FEVps1fOi2v4FG/bFgy0/Qbdbf9qCdaBDv3CVUfaEklbm
	hjgKYu09l7YptMsOJXvz4vr9ALlo2RDfeOLWA33pimSaXp/bbUt3SAc3uw6ea4dbawbfBW264I5
	zlidVE14ORBrexD1+WuSK5JKQ9j7XouSsaRz4jf2LpOYtGlZpngO1YdkjdQnXJ1fKCUyOcEh117
	2Q2fXfmBgwzyl175rD8u+oBFD6li2qq/ooX8T05lJvlWzuBFilNPp5Mufx7iaOZK5A324Wdfcum
	kRZ7CMO/+LT421kufcyuGW33GcuJ6sbOFY6tCb3QBtvwFXF9RZtYKq/kCsMmjozZs1SvSVZ3yFF
	V6UJD4Plse+4E/TgORZJNUzbRFJFjH6S+xQyACbs8H1efu8W6+c3QBwDfg8nDNWcss6dYIgpGi
X-Google-Smtp-Source: AGHT+IFqnn2SI738nSnMgwefaFgNAn8OXCrD61SJ7KPC+iZN0R9t/bRNl7rr1BKYyEbKdWJ1ke80aQ==
X-Received: by 2002:a05:6808:1481:b0:450:c7dc:d7f6 with SMTP id 5614622812f47-45378f735camr3713318b6e.25.1764939997280;
        Fri, 05 Dec 2025 05:06:37 -0800 (PST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f50aa31534sm3417876fac.2.2025.12.05.05.06.37
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 05:06:37 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c6d13986f8so1949863a34.0
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Dec 2025 05:06:37 -0800 (PST)
X-Received: by 2002:a05:6830:310c:b0:7c7:26e:4686 with SMTP id
 46e09a7af769-7c957c0afe7mr6091417a34.5.1764939996182; Fri, 05 Dec 2025
 05:06:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205070454.118592-1-ebiggers@kernel.org>
In-Reply-To: <20251205070454.118592-1-ebiggers@kernel.org>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 5 Dec 2025 08:05:59 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_4-vcyTg+aYA3nTsQ9ekBBZ1h89u9Qk_ZGQ_mGS_5Y4A@mail.gmail.com>
X-Gm-Features: AWmQ_bnWVIauyhohzQgsmdPw2A8fSpbERJ7LqNlJnEyvjZSg3WiSLOfT0DPM3mM
Message-ID: <CAEg-Je_4-vcyTg+aYA3nTsQ9ekBBZ1h89u9Qk_ZGQ_mGS_5Y4A@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: switch to library APIs for checksums
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 2:21=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> w=
rote:
>
> Make btrfs use the library APIs instead of crypto_shash, for all
> checksum computations.  This has many benefits:
>
> - Allows future checksum types, e.g. XXH3 or CRC64, to be more easily
>   supported.  Only a library API will be needed, not crypto_shash too.
>
> - Eliminates the overhead of the generic crypto layer, including an
>   indirect call for every function call and other API overhead.  A
>   microbenchmark of btrfs_check_read_bio() with crc32c checksums shows a
>   speedup from 658 cycles to 608 cycles per 4096-byte block.
>
> - Decreases the stack usage of btrfs by reducing the size of checksum
>   contexts from 384 bytes to 240 bytes, and by eliminating the need for
>   some functions to declare a checksum context at all.
>
> - Increases reliability.  The library functions always succeed and
>   return void.  In contrast, crypto_shash can fail and return errors.
>   Also, the library functions are guaranteed to be available when btrfs
>   is loaded; there's no longer any need to use module softdeps to try to
>   work around the crypto modules sometimes not being loaded.
>
> - Fixes a bug where blake2b checksums didn't work on kernels booted with
>   fips=3D1.  Since btrfs checksums are for integrity only, it's fine for
>   them to use non-FIPS-approved algorithms.
>
> Note that with having to handle 4 algorithms instead of just 1-2, this
> commit does result in a slightly positive diffstat.  That being said,
> this wouldn't have been the case if btrfs had actually checked for
> errors from crypto_shash, which technically it should have been doing.
>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>
> v2: rebased onto latest mainline, now that both the crypto library and
>     btrfs pull requests for 6.19 have been merged
>
>  fs/btrfs/Kconfig       |  8 ++--
>  fs/btrfs/compression.c |  1 -
>  fs/btrfs/disk-io.c     | 68 ++++++++----------------------
>  fs/btrfs/file-item.c   |  4 --
>  fs/btrfs/fs.c          | 96 ++++++++++++++++++++++++++++++++++++------
>  fs/btrfs/fs.h          | 23 +++++++---
>  fs/btrfs/inode.c       | 10 ++---
>  fs/btrfs/scrub.c       | 16 +++----
>  fs/btrfs/super.c       |  4 --
>  fs/btrfs/sysfs.c       |  6 +--
>  10 files changed, 133 insertions(+), 103 deletions(-)
>

This patch looks reasonable to me and seems to work as expected.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


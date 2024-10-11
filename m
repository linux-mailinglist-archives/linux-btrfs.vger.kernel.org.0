Return-Path: <linux-btrfs+bounces-8833-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F358999A09
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 04:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1536C1F241AE
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 02:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A362D1E906A;
	Fri, 11 Oct 2024 02:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti/J1EnJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2F51E8834;
	Fri, 11 Oct 2024 02:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612561; cv=none; b=UnXF+U9ANqZN4lANGIGby8Z+V+Ht6BJ22HvfeqJgc5I1r3I7f6YlLP2/BHJXKYOr768rfCpi70tiYUd4YDuRta2kagBSa7NtfAvVqvMgqtG8hxBqCmq8gSspNCStpWdtHr/3iHw2yUXdtSFTmTQstyKCiQXTlo+kp/ras7w7tQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612561; c=relaxed/simple;
	bh=aI+kVo3JrrNJ7YGaRvYFfYl3G/dHWG/G4ayXbq9TxyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqOsac9DA5KDjqKUq0VYiNVHyVvkqn4lcTjUBFxfb8r0rfSiSd6j5o4LqOTdCWm8AqtYOFwpPx6QRUI1Qd8dRSPjXuATejOZm2DQ2ROaPvDN2UIKrYUvy66/L73l8acSyvMbYVo5lXtvxHQqx/XH6hir9zf1ldEFuMDtycP7ffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ti/J1EnJ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2dc61bc41so841549a91.1;
        Thu, 10 Oct 2024 19:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728612560; x=1729217360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HjWeD9HT47zkfpKbRTMi6no6+ST4z9rpRHbcw/ft7DA=;
        b=Ti/J1EnJFmmN3EUfT4PdVSULJVCHRUqG2nqNKFPDB9VVX3BJWeTaSk5fIUURqI+WnE
         oRZVPIiMFoOyNfvk6rIuQBGEyAhDb2O8dzQDZH1k+M8SwSJnfu37gid2kIQl1DbJh+5P
         roqj/hNrWBZv+3NraYSMvnX3USsPrUBvVIdDlw0XH/LaL44ZAX+gdOvx2AbTWqOrv6LV
         6lgk54Mpw+iR4bcmTeXmJKuj6ocMu+3iWX2qt7yqiKk+slAfzcWSxPX42oExxrHhZqmo
         ikII3Haz6HRUhMLCKLAjnVAVefFuoDgl5vi3LAHfs4lRhJ2SGdSfULGf2d4VX4BbEqzd
         9BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612560; x=1729217360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjWeD9HT47zkfpKbRTMi6no6+ST4z9rpRHbcw/ft7DA=;
        b=pEJ/Aj6gb0aXQCEBFn2x+njlYHqWbwNH4aIyRvm4uCgVa466hxNtMn8EQIyhynhRhR
         q9+FGjLnbzsjE4fcP1ugRcSY96xv/klkzyNwgQXzmKLU5q4/JiRMI4EPu89M/s6I8gP9
         7pWnWSChQjtk9wFAmR53bmR6Br6Ocr1UVarCTOfbfpRrKnsVGTxz3Csp5E3mA7goETlZ
         FqBYAAKzRx0F9PR8PUl2cPI7tLpECdyqVyWawpsiOSZF+d4X+otLUW6Hn/GKp65Gc7EB
         Sl6j/u9S7pJg944NQTFPzzb1pcV9tKaSijK2ZUWxEs+NeA7etnkx9ULg6dB4YJ1A4T9f
         I4NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUL5r9kIaWQ50QizSDYsVlx77vqcFL0ZZPRqvC5vDXPEC+f8ETwT28NiflZ+ShRrsCW052YCKS1v0yY1jk1@vger.kernel.org, AJvYcCV2TUSzil7V+hrizbukKFbfKBi7fSBNgTKv7JqCz/IBrDn5LHxCLFKl9sQqtLZtkcc94Ky/De9ItEjphQ==@vger.kernel.org, AJvYcCW5rfafEYP0EKZJjWGPjTmIlhJygp6bsDXAgHhTjOUH4DeSAKNybwWrGp8+H4/oaE25PdpR/eqwnyEj@vger.kernel.org, AJvYcCWHpXdM0t+4BGGUqiRPdoJHNqw6Ztq/YoMAe3PDo1wQkk4A9D8+XASlxat1uY9vpTKb+luHUYpcu6Lm@vger.kernel.org
X-Gm-Message-State: AOJu0YzA7DZARP9TIz1/+LObdDFQ8xeOZLTwueUPRl21jqRZu8+QRv7L
	fhvdfSy/bqHcw8eIhS8qsYw416LCgfuEzqheEz09a/PAGlcgwslr
X-Google-Smtp-Source: AGHT+IGmMxiC+DaNWneEaWUXbx942+3srxh6SQiQYR1Tc2s2HP0uHw5IXb6QSGrhhTUBncneke8Rzw==
X-Received: by 2002:a17:90a:db15:b0:2e2:ba35:3574 with SMTP id 98e67ed59e1d1-2e2f0a7afecmr1668241a91.11.1728612559763;
        Thu, 10 Oct 2024 19:09:19 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5df1ed0sm2122410a91.19.2024.10.10.19.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 19:09:19 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3BB5C4374224; Fri, 11 Oct 2024 09:09:16 +0700 (WIB)
Date: Fri, 11 Oct 2024 09:09:15 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4 02/28] printk: Add print format (%pra) for struct range
Message-ID: <ZwiIy-pIo_BPLtua@archie.me>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-2-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KmiAZmKUS8OFkhKJ"
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-2-c261ee6eeded@intel.com>


--KmiAZmKUS8OFkhKJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2024 at 06:16:08PM -0500, Ira Weiny wrote:
> +Struct Range
> +------------
> +
> +::
> +
> +	%pra    [range 0x0000000060000000-0x000000006fffffff]
> +	%pra    [range 0x0000000060000000]
> +
> +For printing struct range.  struct range holds an arbitrary range of u64
> +values.  If start is equal to end only 1 value is printed.

Do you mean printing only start value in start=3Dequal case?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--KmiAZmKUS8OFkhKJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZwiIxwAKCRD2uYlJVVFO
oxaVAP9PfgNhSqeNCS9x8Z3GR7wEInL1UyyJGOr6Rl+q58Kj0wEAl3ide8qht2EY
rGtPL8e03mtewkj3HecVC3pCWmSy/gc=
=a0GV
-----END PGP SIGNATURE-----

--KmiAZmKUS8OFkhKJ--


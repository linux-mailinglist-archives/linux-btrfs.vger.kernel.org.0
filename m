Return-Path: <linux-btrfs+bounces-9166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA90B9B02AD
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 14:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F211C2124A
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 12:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742221F7573;
	Fri, 25 Oct 2024 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kE0o9vTC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD751F7549;
	Fri, 25 Oct 2024 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729860177; cv=none; b=NcnbGqZHxoYeYyWpqzRcbmr+eJGBTkoPBrKNzcyC88ifFv+9GyiCn/pdQIxyNj0lJYY3dw1gOYexTjQiozlMIQAm8EeKrdLiYeWkKOKHSp5zyKNhlpKJFuIac0+Hxhv68YsAboC4DAn+WOgA5A3ifYe78ersiSrQ3lrNkHKw3s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729860177; c=relaxed/simple;
	bh=+tqTq/G1/ysY58iREiKY56dAmZ2o9or0upQiNmVDoqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGCx7KzUqdaNAciqTJ6tx+rTTBTPIhysAlmsnVwnQn/98JU0H4d3wnv88xjoRFXmdLvzQJ2eNJo5ktb3oaMdPyOgxyRDMKUQn97KXARw9rkiHQ6s/i1mj075aLZ8P/smUmeO1mL2f3tTI1P2pmFfK1Jz09iishyUILW+xEXlgWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kE0o9vTC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cbca51687so17408545ad.1;
        Fri, 25 Oct 2024 05:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729860175; x=1730464975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXTiO9n5CgwqjEtYBHWc1ytJOpeHUyS3SdTPf/Kt7Nc=;
        b=kE0o9vTCTGAb0wRlyORF0jgmkrbJkmoWtriIDBEdSdlzzLtJCeXdH4sdbX7RcPKOSU
         YrJb6OUo5BdJXjnLycPOqBeI7M8iJHjvN77hn02q+T12vULa2Ign9aqY3uEDd+jpHShw
         squDagl9hoVDnzL5dg5QnK/4aBpH+z0uCh+vefQscDkc9VBMeQGBy/RXG20iL31ugeu9
         B8dsHyS78Y4WJW9AMVfqvJ81k5hmrCZcVKqiTDm3M+IpwCylci5Q7AN6t88esD7Z6flL
         cx7qDYwiY3oRUk9mbiliQqp07cTAD6rIYLt+tPlRgYxq0JdQJlGDfxR+FbNTdmzMGdHL
         bJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729860175; x=1730464975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXTiO9n5CgwqjEtYBHWc1ytJOpeHUyS3SdTPf/Kt7Nc=;
        b=qikLw9Uc0QYVAmtb51bO9d/+buOxFDPTcme2KCkliax7i0OVzgvRL3nu6Hq2dPuf3E
         /rh/64jt3ruJh+Xl3Jp4soNEOHJ992V1Wd9fejhAEEaQ3jDzDHLHK95b0bsunzCS4dzH
         ABAmfKxIV09C6J9mv7+h3hQ0SYjcOonSCxJmUKqPGrerzyJonm3dWClFlTfxLjSsl1zL
         eBthn7imxmel+i4v3idjSvrABe9uIEJG8gMH2dl9O54+tFBA61Nc9fCP49pgRWZBCSG2
         CWRCoDLuvKJ3+b2CIGEvq93TpDZAQXOCaA41I8iFdR8ARjeGn+Ld4bGU0s+8ysM49EFu
         Z2Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVinuQ8mLB5EuszjSIwLD9eRImTGxX5JwtembggMpN4SURa06qlsLdyM5f2zBGmCyTIq6Em6uxW48Ni@vger.kernel.org, AJvYcCVrMJh5A278Watq1fv+yX3laGtESHZfEJBeQ4cv5Ibeb038jkUhc0dQOTlDj0Y+7aQr0tCbj0VUVsu3mg==@vger.kernel.org, AJvYcCVrlWaIuGvSB0HCsGPSoSMBPGI7HZV/vXEgeTHv4C+Zt2/rDDX7OZHWOP0FpP52tX/aDqtB9P/XxCcg@vger.kernel.org, AJvYcCWQ1pKQ11OfbQt5M1nqY1D13wC4f6LICeb9inHuCxYsU7d3xW38Y0WMhXsiWX/7SjbYZJpWpZZg6vDm7oK3@vger.kernel.org
X-Gm-Message-State: AOJu0YzPlHrfMw/CFaJ62HUQzzSWzPawVm/pNS/5vY9wDbbcHRijfnJZ
	DFsG6W1jJ/K2LU00hmgq+SwBLExT8MGq9bSH5wpvpzHhoM06/rl4
X-Google-Smtp-Source: AGHT+IFugZWGDU61tJUvNQ7vNEQVOF43NuD6yJ1b66g5NnSDW8T63LnxQXz5w07qCPMB6kK0Aauktg==
X-Received: by 2002:a17:902:f54c:b0:20c:8dff:b4ed with SMTP id d9443c01a7336-20fa9e09978mr128430245ad.16.1729860174882;
        Fri, 25 Oct 2024 05:42:54 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc044f00sm8753685ad.260.2024.10.25.05.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 05:42:53 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B1BDB442B53F; Fri, 25 Oct 2024 19:42:51 +0700 (WIB)
Date: Fri, 25 Oct 2024 19:42:51 +0700
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
Message-ID: <ZxuSS2L6RsaQ4bFJ@archie.me>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-2-c261ee6eeded@intel.com>
 <ZwiIy-pIo_BPLtua@archie.me>
 <67117a4de6083_37703294fb@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Cc/Ioko7b9fu/7q"
Content-Disposition: inline
In-Reply-To: <67117a4de6083_37703294fb@iweiny-mobl.notmuch>


--9Cc/Ioko7b9fu/7q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 03:57:50PM -0500, Ira Weiny wrote:
> Bagas Sanjaya wrote:
> > On Mon, Oct 07, 2024 at 06:16:08PM -0500, Ira Weiny wrote:
> > > +Struct Range
> > > +------------
> > > +
> > > +::
> > > +
> > > +	%pra    [range 0x0000000060000000-0x000000006fffffff]
> > > +	%pra    [range 0x0000000060000000]
> > > +
> > > +For printing struct range.  struct range holds an arbitrary range of=
 u64
> > > +values.  If start is equal to end only 1 value is printed.
> >=20
> > Do you mean printing only start value in start=3Dequal case?
>=20
> Yes I'll change the verbiage.
>=20
> Ira
>=20
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/co=
re-api/printk-formats.rst
> index 03b102fc60bb..e1ebf0376154 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -240,7 +240,7 @@ Struct Range
>         %pra    [range 0x0000000060000000]
>=20
>  For printing struct range.  struct range holds an arbitrary range of u64
> -values.  If start is equal to end only 1 value is printed.
> +values.  If start is equal to end only print the start value.
>=20
>  Passed by reference.

That's nice, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--9Cc/Ioko7b9fu/7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZxuSRQAKCRD2uYlJVVFO
o5iXAP9xrOjWpF4wyXjCWIt8cPZkXj4PRmYPrb4rdo1tJKdsaQD/YSgjVnNC9gAL
Uwspgtau9BhYzixhiBXjAblLFPAHiQ8=
=+JhN
-----END PGP SIGNATURE-----

--9Cc/Ioko7b9fu/7q--


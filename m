Return-Path: <linux-btrfs+bounces-8834-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74B1999A42
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 04:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EC91F246E8
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 02:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B884A1F9434;
	Fri, 11 Oct 2024 02:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBzk3v/B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FA41F8F16;
	Fri, 11 Oct 2024 02:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612932; cv=none; b=QCmLZmgzA3IXeb40vufKCZAy0olw4WCIHQRwf23pRRxuAe50PKSVmspi+iezlNmYjSccFGiBrtDbkomDwbbEkiSaVKLlsz46ufIt9sFWtQxHKYbvN/Jzsmndf++XBTsYEmFyFYumMlFAeo1bC+Ug+nAKTQWw7TR2x79yDAwFUxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612932; c=relaxed/simple;
	bh=gKiPKrKK60BJmsa5junoqJcObDYTvmnASwTlUEIPmT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4gBlF8S0yp7Mv51+3XzwFjwg/2BBvVqh/1am+0CfAzk8qmx3Gln+nOry8BbmpGhdAjFmZHDsTRtc22LGBWq0RJ2aegWRjdbr6TfCrTqvBEiDZNxZ5U2DjQtCTCwQ3/qqpy45PaxxniKS3Riku7UCnDu0W0+lmUa0KM4xgE9teI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBzk3v/B; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b7259be6fso16491805ad.0;
        Thu, 10 Oct 2024 19:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728612930; x=1729217730; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G70sgRbW5zVDibTqLQGClZ8RjbVJyvgKa5ojU/Ri918=;
        b=OBzk3v/B9RuhNBUTEH7jFTurJY2cDiar41HEcLcU6PWRoA8jUIjrX2jVz0v27AELY3
         zxzFeD+hT73MwnVmsnlivRf/zcl5ApJi/cKi6VIKoA/9vefM53mPj4KbmoWf/4GQPe1i
         /8QieYDAoK5fpmdMFeI78T6uAdv9lWfB3mbf6k3Q+zXWUW1Zuzd58/f4V5EHrlsOkoAE
         iLJF16twSPddzdYdur6kHPJnjvKpIe4ZQx54QfkkTP2ptbjEY/LKcrXJEiJ5RbTmAlig
         cLmgrDw3NyhCMHqv5VS83ycUPqAJc+MQMLVqLsoxov9G4ywlaIamJVoPMNNmFF4r/rCV
         cs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612930; x=1729217730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G70sgRbW5zVDibTqLQGClZ8RjbVJyvgKa5ojU/Ri918=;
        b=Z98+kWOdAr1MpG92kr20QJUELAjW+GM68FGunGx0KGGl+CasJs8jDT8iX6XO47Fxzo
         dbM40f+XbqJu/VhhIwxXXs7hCjLuHZBcnwLP23YAVhnSghBgJb4guF875N7Gp87CrOxG
         /ahr7a1j00eGfIMsGlYA9Gx3Up3T16vB0bgzCGqlyKKt5ZjWYwXUlS1Io1xNqMkKQhWf
         BBqr8flwRxsSJ/rg0KQGhQeAgLDoFNdx8FLVThgkAcw3SwstVSFWWSc3vby7l2O7BAYF
         1rQxSJIxgvxyAK+ca3WTOXoU9I+BRdVeG3FYEHx9Vh4BdJTVLGNLp9GSnyTL8vYhggaw
         /KkA==
X-Forwarded-Encrypted: i=1; AJvYcCU96iDsmObkdWUCJEpVN63Wg+KX729Iesvofp3Gk/Oub6H9/ezmS5NSSSlcttOH9guL2aSCOKxyNWLZoX6n@vger.kernel.org, AJvYcCVBuPoWchl2i78Xc0degEp7dh0Ox2EZiAqabZtzQxih9nwjCePhQBMUucKBfhUt4WURVjM2HzC7abPA/g==@vger.kernel.org, AJvYcCW2C7U9Jel80OkzvDSQpVbqKMCtHy3CVQU8SRE8hwqwccDFPgp/OdpXyKiMSIMm2kS8Rp9m6YRGS9TP@vger.kernel.org, AJvYcCXLM+P0cD9EpXVoJWyh02ro3b+3pL3XhLsI7WPsQ13DwBkiH+htrHd2oJLts/d51+ClvB1qTw1WWvWs@vger.kernel.org
X-Gm-Message-State: AOJu0YzsDgac/jlxVMyyC4rFXTeNDdFMTAMUxDEOZJ/ZM2MG2uCYP4Y7
	tgUAkACCV9jrLj2lvRU5FRJEUtve+EodoWd1DL5Q1dX6Qou8nat+
X-Google-Smtp-Source: AGHT+IE+MmEO12vUoLLKgbmMkNfIYHaPi9xzVe//y2m2AiK1pGN+UkN2eoeP1RMMb86Uy/RRTG6kzw==
X-Received: by 2002:a17:902:f789:b0:20c:9821:69a9 with SMTP id d9443c01a7336-20ca169e77dmr10577485ad.37.1728612929724;
        Thu, 10 Oct 2024 19:15:29 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c350ee8sm15532475ad.295.2024.10.10.19.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 19:15:29 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 99E6E4374224; Fri, 11 Oct 2024 09:15:23 +0700 (WIB)
Date: Fri, 11 Oct 2024 09:15:23 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: ira.weiny@intel.com, Dave Jiang <dave.jiang@intel.com>,
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/28] cxl/mem: Expose DCD partition capabilities in
 sysfs
Message-ID: <ZwiKOyvXFXfAiOOU@archie.me>
References: <20241007-dcd-type2-upstream-v4-0-c261ee6eeded@intel.com>
 <20241007-dcd-type2-upstream-v4-13-c261ee6eeded@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oaAeGPAZ1RHcucEh"
Content-Disposition: inline
In-Reply-To: <20241007-dcd-type2-upstream-v4-13-c261ee6eeded@intel.com>


--oaAeGPAZ1RHcucEh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2024 at 06:16:19PM -0500, ira.weiny@intel.com wrote:
> +What:		/sys/bus/cxl/devices/memX/dcY/qos_class
> +Date:		December, 2024
> +KernelVersion:	v6.13
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Dynamic Capacity (DC) region information.  Devices only
> +		export dcY if DCD partition Y is supported.  For CXL host
> +		platforms that support "QoS Telemmetry" this attribute conveys
> +		a comma delimited list of platform specific cookies that
> +		identifies a QoS performance class for the persistent partition
> +		of the CXL mem device. These class-ids can be compared against
> +		a similar "qos_class" published for a root decoder. While it is
> +		not required that the endpoints map their local memory-class to
> +		a matching platform class, mismatches are not recommended and
> +		there are platform specific performance related side-effects
"... mismatches are not recommended as there are ..."
> +		that may result. First class-id is displayed.
> =20

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--oaAeGPAZ1RHcucEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZwiKOwAKCRD2uYlJVVFO
o8NIAQCZrs5IPtJRWJ3wy4dqN3eWUxQgLyspoOpH7V3EXTsEbwEAuEOVomNyr5Hp
JxCkGB4XGrygV0ZUzfdlEEXL1qkYYgo=
=v9WZ
-----END PGP SIGNATURE-----

--oaAeGPAZ1RHcucEh--


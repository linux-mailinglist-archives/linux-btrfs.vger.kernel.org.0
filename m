Return-Path: <linux-btrfs+bounces-1566-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFCA8324CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 07:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A27EB22969
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 06:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087E46FD7;
	Fri, 19 Jan 2024 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuiNchqB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3FF4A34;
	Fri, 19 Jan 2024 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705647542; cv=none; b=V4jCtRNxogZeH8EPEOtbKQMYITHaf3/6yk9R6FSHrFAhrKFxDA7UTyEMFXeJbCxGahG2ZONRvU+6bvGAekOmf3LnebigeOZA/hwaR2Vf2IeSlYDF4fDWR+5mRVO8qogInAR38NE8jdOcUFPpBgVSlw2mpALwD3iXTfImrnaLLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705647542; c=relaxed/simple;
	bh=hogej2Hq/Ar9DF2BDUWIkWyiEHi3+d77JUjEQDh5/MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVPpLAjTKzCUhIrg0LbRNuAWZkiE70HTjTNsgFIcS7nINwEkQjRPHzy2+tx2zTgvOHqNJ64r8SH7upiV5eParke46asB+k4mz3DUmyjM3ntTGAWt6a7ckHj2S5DVJN32j1lGlWcMkfzXw4hcu8Qb4XcFLrILOflasbR3KfXCrrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuiNchqB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d5d736cdcdso3134655ad.1;
        Thu, 18 Jan 2024 22:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705647540; x=1706252340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hogej2Hq/Ar9DF2BDUWIkWyiEHi3+d77JUjEQDh5/MU=;
        b=PuiNchqB0d2DLWZ3Tl+Xy6HVTmvilTdlmZhtiZ+m5QFY/7jab6yfREsPr3sC5JezqG
         e0nvDACLQnUJ9PkzN62fyzL98YQKMYbz2UDklQSYn8cXJ5nNr5jqyLz478KlngzfcQy+
         1n03fBLwy18ci1+EEYTHPYjrV6PGKVDezs9ccFKEEjb0Xablr8HkIBhQJ8QSOGsa2xl4
         kr3nQTt7b9pIop3kyaKnKFcIfkw6IIz7nhghjLKvTAwq59yCLABvl3lh8A3w3bo+oRgJ
         Iq+aFRAuo3lp+6ySDaMBw7Cc3lB9PNomct6ZVFZfRWPIlskPC/eSujZY/h1UPs63MD9n
         WQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705647540; x=1706252340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hogej2Hq/Ar9DF2BDUWIkWyiEHi3+d77JUjEQDh5/MU=;
        b=TiqxubosvN3ObqgbxcPiNHqNkuzGOI7WUhjADWSeg9ZSY49I+jLEt2uexa8fdDO4D+
         LoKf4bZlqglGP1Ykm5rap/QKyZEEdISQAE7k6QPFb2OOJjPczT+os7wOxDo5j5EeKLTV
         8Y8wWipkzuT84G98RyxjRx0MNzy2jUPR8tjBksZOzMPOyeF8w+DC0mG4DI5jyvPRJ3wl
         q75fioGyitRTZ7SZBmJ98NAED1m0JVm8dkH0q9yXUPWiLz4ZsfVfjnk0RgZ2jF3mKNTe
         ws7hcQKdPqut9FA5ZRdQrhM09Z++okfPHBQ8pS3Lm4L8su3w2TqU+1xytvZx2Wmw1GSl
         BkFA==
X-Gm-Message-State: AOJu0Yyl9HaEbj5BH4YFsGKYtWcn3a1b/zXMhlTUC1eJNN/xcZSSI19Z
	buW4TWO+YAHoLVlBgzVL0PcG/FmG8W4UZPCUa9ed8G36Lb4AhFPY
X-Google-Smtp-Source: AGHT+IHJixHYo3krLzziz+R41+iMji7GYGWIRRNcbflClYK6OAWpT5zGOMdo53Qx2VNmbGi2ULd9tw==
X-Received: by 2002:a17:902:7c94:b0:1d4:3d04:cdd with SMTP id y20-20020a1709027c9400b001d43d040cddmr1795857pll.32.1705647540466;
        Thu, 18 Jan 2024 22:59:00 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id kq11-20020a170903284b00b001d6efcefadfsm2370127plb.202.2024.01.18.22.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 22:58:59 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id D0B251854A1A0; Fri, 19 Jan 2024 13:58:52 +0700 (WIB)
Date: Fri, 19 Jan 2024 13:58:52 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gowtham <trgowtham123@gmail.com>,
	Linux btrfs <linux-btrfs@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: Disk write deterioration in 5.x kernel
Message-ID: <ZaodrO8QjCqSXPHe@archie.me>
References: <CA+XNQ=j6re4bhRDUebzPLDvMtZecqtx+GRRPgpd9apss+vOaBg@mail.gmail.com>
 <CA+XNQ=hGxYsMAo6Gc+Up5QctbWjkER17uK97YXWc9uyx_7+3uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W9V2F+uscCUe8eop"
Content-Disposition: inline
In-Reply-To: <CA+XNQ=hGxYsMAo6Gc+Up5QctbWjkER17uK97YXWc9uyx_7+3uw@mail.gmail.com>


--W9V2F+uscCUe8eop
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[also Cc: btrfs maintainers]

On Fri, Jan 19, 2024 at 09:37:50AM +0530, Gowtham wrote:
> Hi
>=20
> Is there anything I can collect to debug what is the problem in the new k=
ernel?
>=20

Please don't top-post, reply inline with appropriate context instead.

Since you have regression w.r.t. old LTS kernel (v5.4.y), can you check
current mainline (v6.7) to confirm or deny the regression? If the
regression still happens there, can you perform bisection (see
Documentation/admin-guide/bug-bisect.rst in the kernel sources for details)?

Also, it is also helpful to list SSD devices that you've tested.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--W9V2F+uscCUe8eop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZaodqAAKCRD2uYlJVVFO
oznlAPsGd2k4lotRybEZil8Cr95NHCC5FGqwT4eW7L0FIBO0fwEAq6D/v+fULtZx
aM0klFefbcFQsJK+aywrUR+bbsgMVwM=
=RXeF
-----END PGP SIGNATURE-----

--W9V2F+uscCUe8eop--


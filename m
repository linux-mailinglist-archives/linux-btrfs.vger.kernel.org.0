Return-Path: <linux-btrfs+bounces-428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 760547FCFB7
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 08:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53311C209C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Nov 2023 07:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBDA107B5;
	Wed, 29 Nov 2023 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUbSsiCi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED36310F4;
	Tue, 28 Nov 2023 23:08:19 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cff3a03dfaso15130105ad.3;
        Tue, 28 Nov 2023 23:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701241699; x=1701846499; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zGeQs6K6JZs7HzSAt9g8E46vii3UWtn7mk9WYlHcgCc=;
        b=cUbSsiCiR/F0uIgucIJdjmSkPGaGdrwY6e0Xc/GCD3VX0SnkRDuRfmQVQ71TNFscmV
         3MEnSPyOw5ijrIbfjVfpavNzmtBHuZf37uYBH288NJ4WZpWCiEK2NaehG8uykw3i9fip
         3FCRU6FGKjHG9LtARa+rpRYbSubLViBW1Y6oeJwK3sHMpRV7VVVqJr5pyPvs6CWoJerw
         N0CipaiyGQIULkGJhCqnXds1mZXWL7SZh9V7nUISi1gZwpyEDRy/tiuIg1k8hmdTcKej
         Hw3+NxLL6own1/V4cmuDU3Gr5ThOC56qp+KVRxuiMEwNtGSF27eHmTAbus+PFeIBs3Be
         yWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701241699; x=1701846499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGeQs6K6JZs7HzSAt9g8E46vii3UWtn7mk9WYlHcgCc=;
        b=twZtbvUAEVU6mzPn3swJjQTd2juh2RfC3AirUQ4cDCB4ULO1OhYnVXmCWIE3d6iQ9V
         PUTbV42llw/7aB8ADRt9NqYk4hemz/bxynfLfYREsxQom0OK9vn1UUui568cWguFK3FW
         U4HbSck7eWxliCRxUV5BFfes67qRA73NCedHhsT/cHsIjMphmvZEKhYaZ2u0lF/6HSEH
         UE9c0dhq5NahhhJBNurah1Qdfx5J5gAiXHntJ1IfNZuM8i6LegLYyqQORiXQVrpwYy3V
         iAMD+l3EYk/cEVgmBTnZGj8vjQmJdNQm7twXCYje1WQB9A6kv3K11vJmcjNM//WJPKow
         zF3Q==
X-Gm-Message-State: AOJu0Ywb0C39msCD0yA3327Lv/sntu0G6a/x4brDxV63mc8Ye2E3+DBy
	FS6oInQy6+u3qvBr/nDJ+t4=
X-Google-Smtp-Source: AGHT+IEmtE4d2YHUZP8MvCwwcIJmwTKIdukzqmgpzHn2Y8zqkaylHrbzGhsPwsdGJsq45PisO4mpEA==
X-Received: by 2002:a17:902:c1cb:b0:1cc:6a09:a489 with SMTP id c11-20020a170902c1cb00b001cc6a09a489mr15604676plc.33.1701241699281;
        Tue, 28 Nov 2023 23:08:19 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c14200b001c755810f89sm11423722plj.181.2023.11.28.23.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 23:08:17 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 2040C10205C74; Wed, 29 Nov 2023 14:08:13 +0700 (WIB)
Date: Wed, 29 Nov 2023 14:08:13 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux btrfs <linux-btrfs@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Chris Mason <clm@fb.com>, Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: btrfs: super.c:416:25: error: 'ret' undeclared (first use in
 this function); did you mean 'net'?
Message-ID: <ZWbjXV85zDXen_YH@archie.me>
References: <CA+G9fYvbCBUCkt-NdJ7HCETCFrzMWGnjnRBjCsw39Z_aUOaTDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IDRMR4pqBVuyAaoB"
Content-Disposition: inline
In-Reply-To: <CA+G9fYvbCBUCkt-NdJ7HCETCFrzMWGnjnRBjCsw39Z_aUOaTDQ@mail.gmail.com>


--IDRMR4pqBVuyAaoB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 05:55:51PM +0530, Naresh Kamboju wrote:
> Following x86 and i386 build regressions noticed on Linux next-20231128 t=
ag.
>=20
> Build log:
> -----------
> fs/btrfs/super.c: In function 'btrfs_parse_param':
> fs/btrfs/super.c:416:25: error: 'ret' undeclared (first use in this
> function); did you mean 'net'?
>   416 |                         ret =3D -EINVAL;
>       |                         ^~~
>       |                         net
> fs/btrfs/super.c:416:25: note: each undeclared identifier is reported
> only once for each function it appears in
> fs/btrfs/super.c:417:25: error: label 'out' used but not defined
>   417 |                         goto out;
>       |                         ^~~~
> make[5]: *** [scripts/Makefile.build:243: fs/btrfs/super.o] Error 1
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202311=
28/testrun/21349057/suite/build/test/gcc-13-lkftconfig-kselftest/log
>=20
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202311=
28/testrun/21349057/suite/build/test/gcc-13-lkftconfig-kselftest/details/
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2Ymoxor9n54ID51=
BFjRBS06YQ3U/
> - https://storage.tuxsuite.com/public/linaro/lkft/builds/2Ymoxor9n54ID51B=
FjRBS06YQ3U/config
>=20

Is it W=3D1 build? I can't reproduce on btrfs tree with
CONFIG_BTRFS_FS_POSIX_ACL=3Dy and without W=3D1.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--IDRMR4pqBVuyAaoB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZWbjWQAKCRD2uYlJVVFO
o/9PAQCExT+hJHio+2zC8X6ghL5ooF1kKAJVuc2D/2Vtwh3/hgEA45wQKlrh9VU2
WWNUC4riNE+70XRP2h8xpQoiRBv84Qs=
=fwJk
-----END PGP SIGNATURE-----

--IDRMR4pqBVuyAaoB--


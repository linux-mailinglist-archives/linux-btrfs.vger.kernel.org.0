Return-Path: <linux-btrfs+bounces-6335-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3006E92C9C3
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 06:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C43D1C21D30
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 04:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597683BBF5;
	Wed, 10 Jul 2024 04:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="QGAH6WVb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C582A171C9
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jul 2024 04:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720586136; cv=none; b=qEminp7OXTpVnU/atfUd9f9UYXacVOO5HWJ27bzcgiJAqXU6EHAd39ilGe+8+jWiwCFbH3lUHLOx0DAaUbihcbe5WzzwDwjwR2//LKJ2rKzcxhee6KNYk5sqYrt+TeJDr5EPee+KMltuPa0UzoiOkY5qLtp0yIvxvkSKJIKqbnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720586136; c=relaxed/simple;
	bh=MlAo2BJHS5LxCOm1+xYKG0YEDCfc+xnF8luu1updl1Y=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=nKH/Rki5N0DuOfPHb3dFOzEDqS45MUVoaw60RLnUk7/dRVfw4PFffU/EMHUhJIXMksofL3Qf/gjnSQLgON5+a3kXPc7eWqoxXmJbh23w6hzQHjLpmnsizoIsVJhxfQtmKB/0sID4dbOW3PYnXNkNYrrJBYyX1FNFnRPfyp+OcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=QGAH6WVb; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab63so8764503a12.3
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Jul 2024 21:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1720586131; x=1721190931; darn=vger.kernel.org;
        h=mime-version:user-agent:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRFG6FzfhpX9ymrSVt8ELhhigyXayg378aas5u4PmkA=;
        b=QGAH6WVbF8NQg219cg21G0RC1fNM9eG5aU9VMx1KTGhr0oS7xPfehjLLAjBvi8jxJ7
         bhK/uKpscSaydIpR6WoW+cIoHQuGVtBYUNO+JjBmXKISs2b5/oxtHWUT5fDzNCXkM9NY
         60Jw2EDzeu1vbMuwFsu9zBzDOW1aEuVpTVoh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720586131; x=1721190931;
        h=mime-version:user-agent:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRFG6FzfhpX9ymrSVt8ELhhigyXayg378aas5u4PmkA=;
        b=A+m3lTydfVSUGeDuh5aZYdQ0y2uVmeBKHSM1S1MECTsnbKvUPswEf69RrsSI/2+dqD
         ikGPQFX6S689e3IvIeTNk7HTOPdDpNwTzc/DIjHfG23bDxUnwXUkaln1TNtC4vqHdY8E
         NcTQrMPElHfxRB3jt1MwAHz3mAk7JKiSPk5ZSuP9LSRKr+strvJ86gOjLBYr+QQHznG3
         q/WMcdmQu7Upweg/stQx1DZmWxzb03uoCTgEzUTQhakewFoA6nEM0MlHC2BWuV67aSN6
         BEBHqPhdiT2W6/geCsdJ1QTCRGn9nhA6N+LYhzmfrfBQujyuaXUdYGQ63DRgmwkPWY3E
         mSZw==
X-Gm-Message-State: AOJu0Yzf/Gv2nLY0axopEqZBEPn9SWrcBNQqzH6Dr6iaEHuRfOhiDZWA
	FKByx79zJFgjivmBbU+1014p3ERqOBGIpP/+/erTrXVCOFlxuADsG2oSNkP51n/YIBqg+9QRGd3
	rG5g=
X-Google-Smtp-Source: AGHT+IEo0lZYQP9KrWi4ArBHBzl9Vl+rPeLp+C2yRSe25FJxBe6vs8rFJrbI+W/5YDOOCBlL8ApUtA==
X-Received: by 2002:a05:6402:2696:b0:57d:61a:7f20 with SMTP id 4fb4d7f45d1cf-594b9b06d83mr3648333a12.3.1720586131445;
        Tue, 09 Jul 2024 21:35:31 -0700 (PDT)
Received: from [172.20.10.4] ([91.151.136.249])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd459abbsm1754380a12.71.2024.07.09.21.35.30
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 21:35:30 -0700 (PDT)
Message-ID: <1a4f5b2e4bb24978e8839e943faf364c1232757e.camel@intelfx.name>
Subject: "Replacing" a subvolume in presence of nested subvolumes
From: intelfx@intelfx.name
To: linux-btrfs@vger.kernel.org
Date: Wed, 10 Jul 2024 06:35:27 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Q5imeFETsOBdNZTk0unq"
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Q5imeFETsOBdNZTk0unq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm currently developing a sort of high-level management CLI for btrfs
(loosely modeled after zfs CLI) and I believe I've hit a pretty crucial
missing feature in btrfs.

Given a subvolume tree like this:

FS_ROOT
=E2=94=9C=E2=94=80=E2=94=80 foo
=E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 baz
=E2=94=82   =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 foosub1
=E2=94=82   =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 foosub2
=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 foosub3
=E2=94=94=E2=94=80=E2=94=80 bar

Does there exist a way to atomically replace (or exchange) `foo` with
`bar`, preserving the nested subvolumes at their logical places (i.e.
beneath the new `foo`?

I'm pretty sure the answer right now is "no", but what I'm wondering
is: what would it take to implement something like it in btrfs? Or can
it be emulated with a clever sequence of VFS operations?

I tried to mess around with bind mounts to "emulate" this
functionality, but I don't see a way around it =E2=80=94 if a directory is =
a
mountpoint, there is very little you can do with it.

This feature (or, rather, its absence) is in the way of implementing a
sort of "rollback" feature (in the hierarchy above, imagine that `bar`
is a snapshot of `foo` that the user wants to restore).

Now of course it is possible to take an easy way out by saying that
nested subvolumes are broken, but I don't think that would fly: nested,
user-creatable subvolumes are a very useful concept, docker/podman
creates them when used with a corresponding driver, etc. While for
system-wide docker/podman you can get around this by creating a top-
level `/docker` or `/podman` subvolume and mounting it into `/var/lib`,
this won't work for rootless podman.

Thoughts? Ideas?

--=20
Ivan Shapovalov / intelfx /

--=-Q5imeFETsOBdNZTk0unq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJJBAABCgAzFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAmaOD48VHGludGVsZnhA
aW50ZWxmeC5uYW1lAAoJEHveF8jk4w6dEpEQALTfjTvfRwc8s5kG/X9OWe0F4bE2
Qr7Wr7DMxeYpIII3k01qCCOwJ/fX5MPe4g0jo5cwVx/z9pcDAuhlVVHYgaN/iLIx
yIbTla0J+ahGWeWfWJymNcXlGEg0f1KqSEEsiR2sAIfI0ssd2VBPbKLP6r22qyG2
MRmD6sTN75CC+xFXOCgWEo54vcGEIaJd/kueQgRdGx2FUxXwULY64Xr7dtzrNb9k
60o9ndrQ25mIPDte1R6QScBYR1rmd8z/mIdaMYwY9ZYCsKU38W6CH+4symF5q64i
aEgMqsQPENIEQiVr26QE83AN74IkhkgSASmd19OYmZBMSEziw/Q/YM4lEyCN09iC
RieMFcamXOsay7gU9vIc43jtPAEl5UFDzgg6NhZIIM4aIYVwa5aNsvCayeSUvEiL
QPz+ITTM14A6qO9PHfq951Slpr872v6Kk8pz+asItO9Zpnz1GmxyLDeTRcV+eroY
XWyP2r4uyenj3QoA/SuopslN8SzJYLqhMtcsjS/NV/TEEFE+0Y6d/wEcCjlNhJy0
WrhwgpXHAVYoGwBSjdRRAeus802L3glDz56UQ1slAOXiX8poWt7HT1HS+C4NuTrs
pb4S102dkXYFOXr1K0cRCmm4YivjdrZWx5dUakXleSZLaok3lQ2I6q1jYQux6pJL
y3DGJLuafFwrGmWf
=ABQl
-----END PGP SIGNATURE-----

--=-Q5imeFETsOBdNZTk0unq--


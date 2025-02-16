Return-Path: <linux-btrfs+bounces-11484-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF3FA3743A
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2025 13:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154A916F366
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2025 12:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954131917E7;
	Sun, 16 Feb 2025 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="Uv7PNvWI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A263A18DB08
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Feb 2025 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739709712; cv=none; b=Cmz9JZ4/XFUGcXJ602uQT+IxzNKbM/Y9ycMYMkPgfhgO/MeDHdaUNmYNpLni71fKYpHAVDoiAORPHfHn3CpSc9FcfleqphVvzxwS6ygWwcUDxxn1Q4YyhiUe62Rsg9NE5uIlJd3H24lLaLeIQ+GzgnDDq30vXNJm3rL1br7X5ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739709712; c=relaxed/simple;
	bh=lHGRS8xqEgRvMKlIc0964gAzRPspmvPWJ/JTJj7unGM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OiR3QtBCEQOa/c/brN8HajUmOdZkLtLT81Y7aUkiHX7gZEwgFmdvfxHLXDbxIl5oaoz2u/b9HJwb1LHUZ+fe/1d/s7lmvJJMf7DXzfzM9k8idOFFHeoi8FAOw65P2uelofX3AWwsOdeJenw8cUTEmSsmB4GllZnaie/ITNLa87k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=Uv7PNvWI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2193109f8f.0
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Feb 2025 04:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1739709709; x=1740314509; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3WLc2qFfeHEHO5UGj4XzU+mnA5ReZleNQV5not/XFHc=;
        b=Uv7PNvWIUtm+PjO7Hio8fAGCtFknt3M42zn1BLAVITd8FdTCrHNJxeMBEXgUKaRsWJ
         /E1kJ+wUalSjmf7MC4oFaqEdg+7Gqn/7PgCdQ7tSiGC51CCUVy0bsWY+wTaPUi4FotGv
         PvZ6L3093WLyeHPQKjkOUvneten1deGq68+/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739709709; x=1740314509;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WLc2qFfeHEHO5UGj4XzU+mnA5ReZleNQV5not/XFHc=;
        b=Or8qDLEQJyidZ5x9CRO8kYiC2wzuYkgx9BIvhgwUlhd31E4yr7Lovis+7qpAhqoJAN
         KPbmbmvgc4JxuEZLYTbUp1XHQYXsp0lgqA1H4O78sG+h2s0GTouPHcXr6A8eevVbBlVx
         zw32xQVX1y5I9ENs32nVUzoQ17AyStQERrTZN6TD5LrMAOVqQ2jhCkUoBqNFg2DxCiFl
         xoWHrbZUGiN4TBrws6NOnOEJV8Xr5n/d5LHhyWAWA9C40nnrSl5NCQ+oWmawVgjOcfQ9
         aVRl0lI6cW4uzebELBprRRoL+HTUULPTkJ+JnzsJZEhnRaQ+bBX7WJRsW66Xo6xjloEn
         5L/Q==
X-Gm-Message-State: AOJu0Yw7LMEtZxkXGnPflIzHaSnfZL0xKqdll/tUOar6OkSjNz2u4Zmj
	4uz6tFDBf0xXW7C9FvUPuuZbefXb30V/4DCVLaAkqN9FxB3wXqOKKWGHX2rkjF8nFQqLmGXILvM
	3jTQ=
X-Gm-Gg: ASbGncvm+Yn91+u/H9K90FY7P4DbmWv3YiqUDBf3Qyo3TizsvVNTX16JD1D+JmzJ2Dp
	1riJHm/P73zFL5EO+sKomt+/7H7iEPp+TMbTSjqJ/CIELhuOeXACaDcdWhitTzy7oLCn3CdiDSz
	ViOQVBWxyXgicLVc7xzltG9l/ZRdcAF1jkwUxlD8ajJKlTxuRv6lxlPUVGDz2iWxr+DwEiKl1h6
	6LB7Xq/gxYDc+fD6dV6pUmBRKdUlL9angHc/joT2mlKdwsVj+mfP8qiagVfmA5A4uHZ1g7NfjMm
	W45E9nu2jbMTaBs83boHof7ZPoXeWzO0umWeIUtwXDhAXeSJAQ==
X-Google-Smtp-Source: AGHT+IH5ITw1Kk8NFXcBPn5ETts70DeVwGatE4VChE/GrL7RO4sudStWxA58q9LYlYbxePrhlFjxCg==
X-Received: by 2002:a05:6000:2cc:b0:38d:da79:c27 with SMTP id ffacd0b85a97d-38f33f37449mr4152772f8f.2.1739709708677;
        Sun, 16 Feb 2025 04:41:48 -0800 (PST)
Received: from able.exile.i.intelfx.name ([188.129.244.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259fdb19sm9803404f8f.95.2025.02.16.04.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 04:41:48 -0800 (PST)
Message-ID: <1e872bd9f90b6d99f04042d6af3fdba8f7e619a0.camel@intelfx.name>
Subject: Re: Linux 6.13: excessive CPU usage by btrfs-cleaner/kswapd (again?)
From: Ivan Shapovalov <intelfx@intelfx.name>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Date: Sun, 16 Feb 2025 16:41:45 +0400
In-Reply-To: <ce2829b58eb23b13c5f0feef835b9bba99b9d03f.camel@intelfx.name>
References: <0414d690ac5680d0d77dfc930606cdc36e42e12f.camel@intelfx.name>
		 <CAL3q7H6Luh-LkX2tiuVwd8y-K6mfmjdJ9OOqjwcOEJ6SJCGysA@mail.gmail.com>
	 <ce2829b58eb23b13c5f0feef835b9bba99b9d03f.camel@intelfx.name>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-ako8UvS7Lm/IDnVzzYmi"
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ako8UvS7Lm/IDnVzzYmi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2025-02-16 at 16:24 +0400, Ivan Shapovalov wrote:
> On 2025-02-15 at 18:53 +0000, Filipe Manana wrote:
> > On Fri, Feb 14, 2025 at 9:40=E2=80=AFPM Ivan Shapovalov <intelfx@intelf=
x.name> wrote:
> > >=20
> > > Hi,
> > >=20
> > > On Linux 6.13.2 (+the pf-kernel patchset at 6.13-pf4, but I don't see
> > > any relevant patches in there), I'm seeing excessive CPU usage by the
> > > btrfs-cleaner and kswapd threads during batch "snapshot backup" runs
> > > (involving mounting historical snapshots one by one and running borg =
on
> > > them, which is basically lots of stat and open+close pairs):
> >=20
> > So that's lots of inodes without extent maps that are being grabbed
> > and getting a delayed iput delegated to the cleaner.
> >=20
> > >=20
> > > ```
> > >     PID CPU USER       PRI  NI  VIRT   RES   SHR  SWAP      MINFLT   =
   MAJFLT   DISK READ  DISK WRITE    DISK R/W S  CPU% MEM%   TIME+ =E2=96=
=BDCommand
> > >     423   1 root        20   0     0     0     0     0           0   =
        0         N/A         N/A         N/A R  53.4  0.0 51:12.81 btrfs-c=
leaner
> > >      97   3 root        20   0     0     0     0     0           0   =
        0         N/A         N/A         N/A S  17.0  0.0 49:42.98 kswapd0
> > >    2065   5 intelfx     20   0 5812M  158M 74588     0     2548068   =
   602311         N/A         N/A         N/A S  14.5  1.0 46:34.02 /usr/bi=
n/gnome-shell
> > > ```
> > >=20
> > > (these are the top 3 processes by cumulative CPU time on my work
> > > laptop, after a few hours of uptime.)
> > >=20
> > > perf top on btrfs-cleaner (which is the best I know how to do... I su=
ck
> > > at investigative profiling) says:
> > >=20
> > > ```
> > >   Children      Self  Shared Object     Symbol
> > > +  100,00%     0,68%  [kernel]          [k] cleaner_kthread
> > > +   94,22%     1,71%  [kernel]          [k] btrfs_run_delayed_iputs
> > > +   75,88%    23,45%  [kernel]          [k] run_delayed_iput_locked
> > > +   50,63%     4,15%  [kernel]          [k] iput
> > > +   25,27%     2,48%  [kernel]          [k] list_lru_add_obj
> > > +   24,18%    22,77%  [kernel]          [k] _raw_spin_lock
> > > +   20,36%     4,38%  [kernel]          [k] _atomic_dec_and_lock
> > > +   16,70%    11,57%  [kernel]          [k] _raw_spin_lock_irq
> > > +   15,48%     1,76%  [kernel]          [k] list_lru_add
> > > +    6,82%     6,78%  [kernel]          [k] mem_cgroup_from_slab_obj
> > > +    6,39%     6,22%  [kernel]          [k] native_queued_spin_lock_s=
lowpath
> > > +    5,29%     0,88%  [kernel]          [k] xa_load
> > > ```
> > >=20
> >=20
> > And here this shows the cleaner is running a lot of delayed iputs.
> >=20
> > > perf top on kswapd0 is inconclusive, all of it is shrink_folio_list a=
nd
> > > zswap from there, but I don't remember seeing that kind of CPU usage
> > > before. All of it is bursty, with kswapd0 eating CPU at the same time
> > > as btrfs-cleaner.
> > >=20
> > > Any ideas? Anything I can do to profile better?
> >=20
> > Please try the 3 patches on the following git branch, which is based on=
 6.13.2:
> >=20
> > https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/=
?h=3Dem-shrinker-6.13.2
> >=20
> > That should dramatically reduce the amount of iputs.
> >=20
>=20
> Appreciate the quick response! Yes, that seems to work. I no longer
> observe elevated CPU time in either btrfs-cleaner or kswapd threads.

Oh, I forgot: there's no formal bug report for this, so I'm not sure it
applies, but if it does, then:

Tested-by: Ivan Shapovalov <intelfx@intelfx.name>

Thanks again!

--=-ako8UvS7Lm/IDnVzzYmi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJJBAABCgAzFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAmex3QkVHGludGVsZnhA
aW50ZWxmeC5uYW1lAAoJEHveF8jk4w6daOgQAJFQQTIImPK17dxbKKe0UVar0Wqo
rI4j8mymEWfvLE1L/1Y8aIpsMgXuXhMVFpFVv/2u2qZU/Fw+9xg5sqxM5KqjmViT
GurCm3BNdm9xGT5X4hBFd0gU7gnHkJlHHXSTA5f7vWlNf4L4VWD9q1Jl/Xl+7sMy
L81y7NxmfRRelcllZElTvYVoMegzRjafuESdloPQH1/2u532Y7pCRXFF4lDD+3qt
IGK553q7yEa8yVllgqn80HP7P0ETBauh6rtz1MZATZKUGgCGz/LQd5rtQsfmpyXa
AUubmDwukJcuXu6M1HdQpHva7z4a9t7jRrLVjUfmPYMIz4gtMabO/0sf3klj4z8X
UxIOFpaae+N59nZ3OR9SxZhjgQ2kcMvMEJAxw3ZZCiEVfQz4AK0G570AnLAqi9B2
DwFeGhGrivpDX7JYuo1aH9Si2IrVQFoRvVs2vamNsW/p1gapeGhVKKgKWo3YAnKj
JSCx2b4f7Mcj+CI8oTQTRQAKiFSGjwdUtbvbAQLxo8byNQ/+Nd4zHJfU/s08sBGp
oDOWivBHtFshMMPxB5W0R4lWuA0S9GX1vW2PDsymEF/S8jP2CR2wAQrOBBEmQLN4
duPtAZRaggd6fx5mOTSUBq0ATim9LnFjgfnf/1hvjJZO93iV1cKayYxcRFmQch+z
u7xNPMcOusecOlsT
=+dXD
-----END PGP SIGNATURE-----

--=-ako8UvS7Lm/IDnVzzYmi--


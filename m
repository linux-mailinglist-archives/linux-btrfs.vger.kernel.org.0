Return-Path: <linux-btrfs+bounces-11483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B98A3741A
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2025 13:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CDE816E2B6
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Feb 2025 12:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CDB18FDBE;
	Sun, 16 Feb 2025 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="Cr7+/kSd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32EE78F35
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Feb 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739708694; cv=none; b=f1gRySKf86k9jCvGnRqEEGZUssf9oexyRAkMvoDcBrii5Hz2DlM2JtA2ozAr2Vq3TcfznMV8hCbaynL7RZ0hD2rIsuRoHwKXLAojywvx4LaXrGJ6QPwvZGNMf0jirv9hJ6IUBMHcRH/4R/77/SdHrZQoaSJUGAPfmtwYw13jJd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739708694; c=relaxed/simple;
	bh=iIXE4HkXN0f7bEILQQ7dNE/ZkfuEl0vZSBSUT2cFVDo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s/CbKo9VIKBxYQgbOIywY7jKsjLv8qnelRThA7c5tv30JQWjT+Kk7TFh/FCmrUma040/VotHP44+sncieu+Jpbdmjw1HHwNQ1Is+UAjKU7+GdgVBJW4TgSojbPtMcG3chqRW9gTmJUqlcDhp97NczKSQ5RmRQUDLZIY3ECCBKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=Cr7+/kSd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f1e8efef5so1782939f8f.1
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Feb 2025 04:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1739708690; x=1740313490; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EkFN8+K5jl1ozXSVb9s9CAaCiHUiu9wVfHv92/svS8A=;
        b=Cr7+/kSdfMXTppQ0QqDE6TFn8xlA9/i5nTnQmSvF7ztjlVdOxula44uExl9g4m2JBX
         4dLaZc0FR4t7CFqOQ7TmN81xVY5mMpeXzPmZN76HyMx7YhCSSjuXaNKOpbushHQkdRpf
         KxNnS4OhjqxbQqxh94F9S9NWQ5lGGqR5v/WT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739708690; x=1740313490;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkFN8+K5jl1ozXSVb9s9CAaCiHUiu9wVfHv92/svS8A=;
        b=RUxKVDJZEa8eerWcwIdHS1SLefwh3q8oqVNz3mgtQtusuRjqZMHGy08hvh/rzF2dKf
         68jFTBWnjvUtWAuR24ugAkPoXArTPP1kj0/dSbaO4Km/GB59xTFFE4sm3X5Kh4K4O3Cl
         JK0iZZDlwbk7knmt8Arsf2DKFoVElfUmOpVNmWNr3b+Z90eU/g0F+2od2oXDbHDNnYW1
         zgW6dOOLzCBXfHtJ6LS30ThcZCgZylxp0+mEn/sgOkD+N0TphD+Q+Jhuvt4yBqeAhEaR
         3repcUP8SKYDU5x1m9l9ze3VIzlm345o4HzE3kE0ZUiIhxWHtIsSq4Jr0tt0KMC37Tpa
         vBEQ==
X-Gm-Message-State: AOJu0YzhMi+7FeJEYUrKrWsf+grLA14/4hVgMtVELQC5J3ueVFAcP2zG
	DhnC8/uOW4kjtXLKHNNljs4SvoEhrbCyGcQijdsot7aH3D8N6cRV00V1CH65Lr44NWyVsf9lAIy
	qYTc=
X-Gm-Gg: ASbGnctu9+EgnlHiaBr0UgfNwkvQyz5bt5+pS3RZmJkRHLLaWN6XCrWs7/Tew5slje0
	RGkdzSb1P06RVZH/28frcdXICz7c2novIcjHYhvKORnm62YHrhpSIh4SHL8K/7FwnlcxvrCoKw7
	mAxJDbt3VskpnUowZ7rPvUZ6XVJ+Dl/g45SNRwKkhQj9SmzQQI7bvVGoLDoR5m0WN/XEHYPDcq4
	rIxBopvy7jm0Xzt4bzCX7pOk3whBHFX3dAqo7IJsM0b/bgRtIQkAZsxZyjpZ3R17ggr5h5/t9fp
	Avd/71YsqOAlBdkg70gV1R4BQq3tRHwPp20/P/wxUhPa7M1vVw==
X-Google-Smtp-Source: AGHT+IHj2emvoOFmybGy+zFCmgMxKJS8AlEZHHIT+NP7HIBRM39e/CRWdHQO++/eg9grPxub5bg3yg==
X-Received: by 2002:adf:f84f:0:b0:38f:2bee:e13c with SMTP id ffacd0b85a97d-38f33f58e2bmr5374232f8f.53.1739708689791;
        Sun, 16 Feb 2025 04:24:49 -0800 (PST)
Received: from able.exile.i.intelfx.name ([188.129.244.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258f8ddbsm9563092f8f.47.2025.02.16.04.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 04:24:49 -0800 (PST)
Message-ID: <ce2829b58eb23b13c5f0feef835b9bba99b9d03f.camel@intelfx.name>
Subject: Re: Linux 6.13: excessive CPU usage by btrfs-cleaner/kswapd (again?)
From: Ivan Shapovalov <intelfx@intelfx.name>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Date: Sun, 16 Feb 2025 16:24:46 +0400
In-Reply-To: <CAL3q7H6Luh-LkX2tiuVwd8y-K6mfmjdJ9OOqjwcOEJ6SJCGysA@mail.gmail.com>
References: <0414d690ac5680d0d77dfc930606cdc36e42e12f.camel@intelfx.name>
	 <CAL3q7H6Luh-LkX2tiuVwd8y-K6mfmjdJ9OOqjwcOEJ6SJCGysA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Rk2r/ieCG95uInr+kcA5"
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Rk2r/ieCG95uInr+kcA5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 2025-02-15 at 18:53 +0000, Filipe Manana wrote:
> On Fri, Feb 14, 2025 at 9:40=E2=80=AFPM Ivan Shapovalov <intelfx@intelfx.=
name> wrote:
> >=20
> > Hi,
> >=20
> > On Linux 6.13.2 (+the pf-kernel patchset at 6.13-pf4, but I don't see
> > any relevant patches in there), I'm seeing excessive CPU usage by the
> > btrfs-cleaner and kswapd threads during batch "snapshot backup" runs
> > (involving mounting historical snapshots one by one and running borg on
> > them, which is basically lots of stat and open+close pairs):
>=20
> So that's lots of inodes without extent maps that are being grabbed
> and getting a delayed iput delegated to the cleaner.
>=20
> >=20
> > ```
> >     PID CPU USER       PRI  NI  VIRT   RES   SHR  SWAP      MINFLT     =
 MAJFLT   DISK READ  DISK WRITE    DISK R/W S  CPU% MEM%   TIME+ =E2=96=BDC=
ommand
> >     423   1 root        20   0     0     0     0     0           0     =
      0         N/A         N/A         N/A R  53.4  0.0 51:12.81 btrfs-cle=
aner
> >      97   3 root        20   0     0     0     0     0           0     =
      0         N/A         N/A         N/A S  17.0  0.0 49:42.98 kswapd0
> >    2065   5 intelfx     20   0 5812M  158M 74588     0     2548068     =
 602311         N/A         N/A         N/A S  14.5  1.0 46:34.02 /usr/bin/=
gnome-shell
> > ```
> >=20
> > (these are the top 3 processes by cumulative CPU time on my work
> > laptop, after a few hours of uptime.)
> >=20
> > perf top on btrfs-cleaner (which is the best I know how to do... I suck
> > at investigative profiling) says:
> >=20
> > ```
> >   Children      Self  Shared Object     Symbol
> > +  100,00%     0,68%  [kernel]          [k] cleaner_kthread
> > +   94,22%     1,71%  [kernel]          [k] btrfs_run_delayed_iputs
> > +   75,88%    23,45%  [kernel]          [k] run_delayed_iput_locked
> > +   50,63%     4,15%  [kernel]          [k] iput
> > +   25,27%     2,48%  [kernel]          [k] list_lru_add_obj
> > +   24,18%    22,77%  [kernel]          [k] _raw_spin_lock
> > +   20,36%     4,38%  [kernel]          [k] _atomic_dec_and_lock
> > +   16,70%    11,57%  [kernel]          [k] _raw_spin_lock_irq
> > +   15,48%     1,76%  [kernel]          [k] list_lru_add
> > +    6,82%     6,78%  [kernel]          [k] mem_cgroup_from_slab_obj
> > +    6,39%     6,22%  [kernel]          [k] native_queued_spin_lock_slo=
wpath
> > +    5,29%     0,88%  [kernel]          [k] xa_load
> > ```
> >=20
>=20
> And here this shows the cleaner is running a lot of delayed iputs.
>=20
> > perf top on kswapd0 is inconclusive, all of it is shrink_folio_list and
> > zswap from there, but I don't remember seeing that kind of CPU usage
> > before. All of it is bursty, with kswapd0 eating CPU at the same time
> > as btrfs-cleaner.
> >=20
> > Any ideas? Anything I can do to profile better?
>=20
> Please try the 3 patches on the following git branch, which is based on 6=
.13.2:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/fdmanana/linux.git/log/?h=
=3Dem-shrinker-6.13.2
>=20
> That should dramatically reduce the amount of iputs.
>=20

Appreciate the quick response! Yes, that seems to work. I no longer
observe elevated CPU time in either btrfs-cleaner or kswapd threads.

Thanks,
--=20
Ivan Shapovalov / intelfx /

--=-Rk2r/ieCG95uInr+kcA5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJJBAABCgAzFiEE5N8nvImcx2nJlFGce94XyOTjDp0FAmex2Q4VHGludGVsZnhA
aW50ZWxmeC5uYW1lAAoJEHveF8jk4w6dJxwP/1Y/QR7lL8LVBxOtnv+y6YYPWBgt
tgy/5GiBjlACLXt4FpVBBpNYoj/RjQpKC9tp2dsYjsuHVzjeuZoMVeFZJGYIZUJd
SyNM/DxsueD5Vo3U3CAcfj9RRxqbBb4ngCNeTVGSQbwYWsrLmbJE/7yvfF8ax6qQ
WEXOXI2ZSGgVZ437Z5XZh6gh2lRGDySJ6HU9FaT00xXCGw4yc9iGJXAVZGAAiE+E
uxX2Bn5LFwbdBgvDsED7pYUyoCALbE+19CS4hNDCzw7ub8VxxKRBzY8grWgQT0uk
DCjZ4UMeELAchvhxd9388vlu/m0KFcp4gFJmxGR8Ubx2tMqhhEtCoZMdQGk0yc+W
fdHv0jAqtCY491rumkxohqjABsCQGxmuM22YnhS1A4WgJn1cIkGIC4Pu/5t8UVKz
0YjOZxaCcqRGdP6K5BY6zEI4oKUlJTW7m1n484cOiOxS7VoJti43SLerKDsZpwwH
CxL2peZzAT4p97gF8CteGsCB5fRaA2wgCqninFJhWB7QmdhiJGcqpC48TFHV4B2O
ZgTedpu7S6AmS67KuaGByHN/ZhXKEfDGXFxMaFVZUgBWqxhr67O1aeacRl3q8X8A
xOmzALfyZzXB3ynnkAO54KxzMRBZTsN4LWc0WtBir6wm8qlFHcOYNjoq1wB4O9ys
sDx2HEy0AsqI6x7e
=Acdi
-----END PGP SIGNATURE-----

--=-Rk2r/ieCG95uInr+kcA5--


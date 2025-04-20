Return-Path: <linux-btrfs+bounces-13179-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D26A946CA
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Apr 2025 08:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2AD173D51
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Apr 2025 06:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB4A19580B;
	Sun, 20 Apr 2025 06:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZ9sYzuL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0311373;
	Sun, 20 Apr 2025 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745128943; cv=none; b=n3+dxsZ0ABfRQLJHP1X+JrND+9iWQJcJwDbi0iSwDBfjFiccH8dobv7ptXjkNr1qOxH05opct5e24k6nVNJznbhT2QyxeOhwxZs6ciii8ysz5UoN0g2mr9Po8IyG1u5vk1DHeUPGah77YSskSuNymYs069NxZ6avf2ClVpqT1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745128943; c=relaxed/simple;
	bh=JSuUGNtyFzLs94xKHQ9qkBmn7WHYHV2YFBeq7vqHugM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/Z3q/bt9TJ+mjZAJ1vSM3QCmkREz9cfr/F7+fsj61LxQOJotxgvK+EO5g+ZWPSUgb5zivo4/eL92NEBGzTcTPUX1DC+rpmVFLMmIH9vL82PYlZoVIFnxEw1xe1p8SvG0vIHDppIjWHleI5LvaArsGBJ0l9fHvvAT3wiYGaRbAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZ9sYzuL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso7539500a12.1;
        Sat, 19 Apr 2025 23:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745128939; x=1745733739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JSuUGNtyFzLs94xKHQ9qkBmn7WHYHV2YFBeq7vqHugM=;
        b=hZ9sYzuLJVkEJvqyanCBHzCTDh1S3gZ5qfxB9rP/i8e93ZfiWm9NIOdcucxr/IATEM
         8WYrVCuUXo+K21EsmZWgZgtp/+Ortmy8yWvpZjPvMIMSWER9EBcNWYxsvYrM6Th34v6G
         k5Cs8RKXP6RfLpbh9UuJrPElUFA2K9xq7/LmKkpyMas9ytONN2v4g7Az3d/I1fAmMRWv
         NAdzItEuxe/AtodBkK3+4keIIsF61ixtP1ueIFnXig7kH6GoxM0ky2Pud94TSOXZnJnj
         aL7DiWsqwqerGCw+RFX50Pg/F0FxYZxIro24e88nEFbCgdkWg0TANZYp85RkKKXoJiJP
         H3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745128939; x=1745733739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSuUGNtyFzLs94xKHQ9qkBmn7WHYHV2YFBeq7vqHugM=;
        b=bnpxYe4g6oNDh1M+twSQ93h1EU62YAmnN7kiNwkKHfEqvjLgMc1t0a8Dq29Ot+fkid
         sEDEn3YYDTJBImbwCg1W0CIOMWw1P7DLUOtEmHKpgAhCFjjyN3+hteEwTaZMQsTvDal8
         +PtejmlLYhx6BPS8xOMGNmo8x9zRYV7seYUKV8fTaN2yG3HkeHBVUO7/0gdGYzTWxzxT
         to6vCHYWqMyjEQj8NrDWo+aR5U3WbBZY5Amw0OkpihsSlr9iztIxJUJNNB18HYvgN/Bi
         avvVcBFrpGorc4s/owzJ5o9p41YnAZ83H8AzIWaELAluHvD6D+jhETsOmpg0gSNb6GRw
         9oCA==
X-Forwarded-Encrypted: i=1; AJvYcCUiqK+9YNVzbLnQXdJRLuQcnLthayoxV8sHyVonMWooX7gOOLfiuOMcreK9XM+DZhWAavt7qFN056hCOg==@vger.kernel.org, AJvYcCWCIbezdPtJ+YEMysJkeNvs1oyLADPWVkM1sfKB862/Cv9ia/Zk4kcPiga//pkkuftEiRwNj89ckrD9IXHy@vger.kernel.org
X-Gm-Message-State: AOJu0YzsSN6FynVtVEqJ336p0s8c/XHPBlKosLoyrBZSsoc8OidKORRt
	11//Fwk2Fmg18lsqRA5OjB/W4EWgDziLbswDCVmYyODQb1VDT1Uufn7sEzmDaU0Px656ToMaadQ
	qf0IuijLXkGDCl4rn4i7Vlga9f5M=
X-Gm-Gg: ASbGnctQBYtTcbTn+dKhXAfj2Ey3YsXtdpGUDqsx4O4IaCKVXYE7LGAdAXN6KS0iShv
	bZ5TlsOGGUcu1PcJppS2JgnpUbBfyNjFTJxFUZ46q+tSJ55ckZPq+3Jyt08tM7zky5iyLGZSnwg
	Cdr5VZ6FY5oSc+YYVMMwd86w==
X-Google-Smtp-Source: AGHT+IGFv/JgCy2eATFnZ4b3gX6YDtd0QNoBpyDm4hIE+rVuB7SJ/Au8ExHV6bc4mATOD3QaDLTtRCODnM51svpN+J8=
X-Received: by 2002:a17:907:9494:b0:ac3:8895:2775 with SMTP id
 a640c23a62f3a-acb7516cafamr819560166b.13.1745128939141; Sat, 19 Apr 2025
 23:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8c2e5d04-dbda-4b12-992e-34f0e70c7218@archlinuxcn.org> <20250416100634.GB13877@suse.cz>
In-Reply-To: <20250416100634.GB13877@suse.cz>
From: Neal Gompa <ngompa13@gmail.com>
Date: Sun, 20 Apr 2025 02:01:42 -0400
X-Gm-Features: ATxdqUHssIgA0M7EWOXFt3QMDHaFXDeQig5SM5zPj-sl1VdEAeGdqIVStWPPmxw
Message-ID: <CAEg-Je88eTaqMpVK-b92HHQgdEK0bF=RysOVcyVWRUpeOsbp-Q@mail.gmail.com>
Subject: Re: Maybe we can set default zstd compression level to 1 when SSD detected?
To: dsterba@suse.cz
Cc: Integral <integral@archlinuxcn.org>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 6:06=E2=80=AFAM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Sun, Apr 13, 2025 at 12:07:26PM +0800, Integral wrote:
> > Hi,
> >
> > When SSD is detected, maybe we can set default zstd compression level t=
o 1.
> >
> > Current default compression level for zstd is 3, which is not optimal
> > for SSDs.
> >
> > This GitHub Gist [1] can serve as a reference.
>
> Well, while the linked gist is thorough I don't see that zstd:1 clearly
> wins against zstd:3. The compression brings overhead (more extents, CPU
> cost) so the preferred criteria should be space savings. The runtimes of
> read and write seem to be roughly the same.
>
> I haven't found any description or classification of the input data
> (other than known to be incompressible). This is an important factor.
>
> > An example is Fedora Workstation [2], which uses `zstd:1` as default
> > compression option.
> >
> > [1] Link:
> > https://gist.github.com/braindevices/fde49c6a8f6b9aaf563fb977562aafec
> >
> > [2] Link: https://fedoraproject.org/wiki/Changes/BtrfsTransparentCompre=
ssion
>
> Unfortunately the Fedora evaluation disqualifies itself because it uses
> /dev/urandom (practically incompressible) and /dev/zero (trivially
> compressible). I would not select the default based on that benchmark
> for the wole distro, it's IMHO flawed or incomplete at best.
>

You didn't read it properly. There were two factors being tested:
compression ratio and CPU load.

The compression ratio was tested with a typical Fedora install and
produced different rates of compression based on the different
compression levels selected. The /dev/urandom and /dev/zero tests were
for testing the CPU load at different extremes across those levels.

There was not enough gain to warrant zstd:2 or zstd:3 for the
increased CPU load on average or at the extremes.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


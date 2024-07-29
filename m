Return-Path: <linux-btrfs+bounces-6823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E791393F22F
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 12:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219AC1C21A93
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 10:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF4A1422D5;
	Mon, 29 Jul 2024 10:08:03 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242978C63;
	Mon, 29 Jul 2024 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722247683; cv=none; b=YArqHhvNT9m7Z1OkMjKzvlsQDnq63VAxSkid1P4HtfUg78ry5LUlY/v7eWiVZFIFCjxSFzmW/WZN90t7Nv4iQ8aDduRn4h11oayFqOEos/SBIqXczEDSdU8Cwb03WqHSXA/dbdTA4I6ZF2x1b5bfX3Ioh37INnVq3RUuNZmS5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722247683; c=relaxed/simple;
	bh=0Tuyx2oDUruZZ6uxuzgbNaLiuh970dbec3fFyh+TDOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hd2kkqvc3zwL0N88c3xdW++HGQzE165OTvi2fslj/0xItcob/92qOO7hvcS0oyxs+qBMLqjgwiqEId7ZSIxHFCv74+O0vZDjXnwnpzXo1qYZSoHShhRsvsbRAIOMw+Ug8IloJ+HEfZQDZehfmdYrYrxf2RRNfmJR/AK2fb8NkRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-66a1842b452so12816527b3.3;
        Mon, 29 Jul 2024 03:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722247680; x=1722852480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwTfVYSGl0qov4UkTwnmIUGjC6ZGnXwHCwIWbd4QwcU=;
        b=n2yE8Fd7AatJR97GcdM/s5N4WzI7eG4qIXN7W9VkJjgNeaZYZR3ifvz/7cwtXdQro7
         WtIGyLdzR4s3/etYoCHGwGpwBTupIPTTlNvaoHfdx8wfIVoI3sLcpwAhRq6o//7JrUZG
         Zv19vhz/oE4g0tm4B4Xgx9+BsZVxARLcvScq4jdkyzws/xYHP3OmBW+5bGrswNQpmSDl
         87fGvaRIQpttmuxsFMf7dnxA1xICmUkK52km32Qmdau6rL4gIDwV7xHXV/HpbZ38oWvs
         OttWSmubbKwwmQmucIO62+VlOCSjCgQez3+Q1olv3yhhoXD2nikgFwgWZfiRUhRiFkKq
         YbiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX733nCqTYGy5SY5baNpVqIWnI25OOsE6pT5Qw0nFPJ0lc8MClONyusvZ11r1ptBBtb+EQr+6jgcaYL13OxTWLq7CoXLt2EvOFxK7XRuBvksEwTN9il+//FHF9aJYFVn21qn+zrJ2hkfOKsDKpQhdpUR5A1e7OdFmmgqtY06bW2RMr0vgm/ReacFbcoAADKcd4TiV+UPxoT5CndsevcDPGv3M+RvO01v1dKIGvg2CvNrBfZXabarIw4aDiKOw==
X-Gm-Message-State: AOJu0YwMUnpeo3QZaSOeU6CAxjhBPheLRmLFYJ8kozym10X2BQTdFqwK
	I5/APySoHgyDnkGblk2653Kr0MKfYvMHH5AWP8u+H4bDLSkAZK+nACQG4e06
X-Google-Smtp-Source: AGHT+IHuGIFdF4MYQWkuPVYvjNmXA34CxX7/h08kyuYp4PshcrVBeg1jQOj218EjBLyE+qiDy9jP7Q==
X-Received: by 2002:a05:690c:6892:b0:64a:7040:2d8e with SMTP id 00721157ae682-67a0978408emr86609937b3.33.1722247679623;
        Mon, 29 Jul 2024 03:07:59 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756b024a32sm19886107b3.97.2024.07.29.03.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 03:07:58 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-65faa0614dbso19023387b3.2;
        Mon, 29 Jul 2024 03:07:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUcnm/9IO1kqhZRdCVjnJC2nzipnZmsCp0x2VIwIAShY6LgfbU2x52hDtoQR4mi2bJwt29dg2g3VBko+fLQNuIsPPXN6bOdRRIBhq57Xaq07zN9tMRD3a85xzWrTt4QdriTDVPsNfhOOLtqSdBaNqAjh6iL7PXy703Or00vVH1rIyicl+FZDQVVArT9Mvlcl+vezXhNcv/TTFScYu79pCFJb1TQZw2h3k4wt+S87lzJkJjlkN1CAuzR1LgPiQ==
X-Received: by 2002:a05:690c:6203:b0:664:7b3d:a53f with SMTP id
 00721157ae682-67a0a7fba7cmr91084297b3.45.1722247678607; Mon, 29 Jul 2024
 03:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <20240729092807.2235937-1-geert@linux-m68k.org> <bd4e9928-17b3-9257-8ba7-6b7f9bbb639a@linux-m68k.org>
 <502ee081-8e09-422a-a1f9-be40aeaa84fb@app.fastmail.com>
In-Reply-To: <502ee081-8e09-422a-a1f9-be40aeaa84fb@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jul 2024 12:07:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUepTM9v7Oyakv6XQg9iw7t08ggGX=K90zRXxm4Ffpjg@mail.gmail.com>
Message-ID: <CAMuHMdUUepTM9v7Oyakv6XQg9iw7t08ggGX=K90zRXxm4Ffpjg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.11-rc1
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mips@vger.kernel.org, 
	dm-devel@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-btrfs@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-hexagon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Mon, Jul 29, 2024 at 11:55=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
> On Mon, Jul 29, 2024, at 11:35, Geert Uytterhoeven wrote:
> >>  + /kisskb/src/kernel/fork.c: error: #warning clone3() entry point is =
missing, please fix [-Werror=3Dcpp]:  =3D> 3072:2
> >
> > sh4-gcc13/se{7619,7750}_defconfig
> > sh4-gcc13/sh-all{mod,no,yes}config
> > sh4-gcc13/sh-defconfig
> > sparc64-gcc5/sparc-allnoconfig
> > sparc64-gcc{5,13}/sparc32_defconfig
> > sparc64-gcc{5,13}/sparc64-{allno,def}config
> > sparc64-gcc13/sparc-all{mod,no}config
> > sparc64-gcc13/sparc64-allmodconfig
>
> Hexagon and NIOS2 as well, but this is expected. I really just
> moved the warning into the actual implementation, the warning
> is the same as before. hexagon and sh look like they should be
> trivial, it's just that nobody seems to care. I'm sure the
> patches were posted before and never applied.
>
> sparc and nios2 do need some real work to write and test
> the wrappers.
>
> It does look like CONFIG_WERROR did not fail the build before
> 505d66d1abfb ("clone3: drop __ARCH_WANT_SYS_CLONE3 macro")
> as it probably was intended.

Indeed. The actual regression is that this turned into a fatal error
with -Werror.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


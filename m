Return-Path: <linux-btrfs+bounces-2801-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D713D867B4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 17:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 842A7B299A5
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 15:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C53212BF3C;
	Mon, 26 Feb 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b="u+JhL9OG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC0012BEB6
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962594; cv=none; b=U27weXILXTzC3X1H6D9Rg2cUCSGGA6/4fAH7WBPYfAjwcSQQyCyQ+0fP70yLWQrTKsxtF7bCwI5o4x7ezw9qBKhKGZkP+EMHGBNRujl2EeSSfxeGlnt938gscAo1s3su6cYdKs3M+ofaIkb12whCqZoppFoD1gC24CFsEKJ7qOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962594; c=relaxed/simple;
	bh=VvVRiEnfDR5vCf2cGbldtoUwolItUXvz8xjX4afT0v0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uWRNnTUQSnDl7kroh9YAWiFoy7PsTC1smAXPtjgbKoduPmCfup4Xz2ODSKCH3ULkiFnOhucDxDjOC6/QZOAUfxUDFxkATkzkmCTZu5w9Ko2n5Q5lz0uFUr67Oxsg1p1nTEC4C0NHz6D2wuGCVXZj2sK/IFfVTbjdb9lrV/Ou/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b=u+JhL9OG; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68ff93c5a15so14687046d6.1
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Feb 2024 07:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tavianator.com; s=google; t=1708962591; x=1709567391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGL5IqVANxCO281kvgGKaaKrighcx/1HjvKyXedik18=;
        b=u+JhL9OGWLOT7uxx9ipZP+A9b1x/4azpCQJphshU0ZFcEtQYqkP79qcSdbg/GfLmhb
         oEsIF1gOScDrDu34Fz+xYfmmaKdL5cSMitnrdszBkZk/lyY/8Wbu1i0HkzpcW/IgSk6x
         ui7Nxhiy9PvPJ+FplZyiRvb/lqY6ZVoACP7NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962591; x=1709567391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGL5IqVANxCO281kvgGKaaKrighcx/1HjvKyXedik18=;
        b=KclSoY3FVMELgBp3+3h6DwUW/UvTjthqhoEl/ZxW6mu2GmRmrG/T6mZAyzw7+mWL9X
         /8ForZQ+UtxuoUZIKk3RB+xanV4+4Xm5RsDFZCUg0YI4/m3Afu1kVPNmB76SuGJsBag4
         1MdBjd0nmTWoKK56SVyB6rGnNVTQDU6r+FPPSRi2/xoGE+FF4vJFdkzPRHcCGn9iIOCK
         xh9sGNnVRBHz815LmZ+Vk++l5xNJ0ualosqncC9ubulFGdxsI6yELEHDAFFSLmks61SZ
         I0kKRGssnhVO4LqAqZtTT4SfPovvybSO7AFkLJo9V4sJSupJhGG6f9MCpreH2BIyWt3T
         ixiA==
X-Gm-Message-State: AOJu0Yxt6ecSGZbzkGZJ6b3i9Lkn/GN5dg7u9s8/cpRAl9yIVgyCaHRV
	fCWYRSXJuSDuB/IwAkjnmpfbhNOA01+fcgaeX1bhU7JFPpbKUArhRfPGNXxGiQtGtlwCzM9K/fB
	CBBpLX502qYwLlcEzrT61X3+VEnFbF41xU1g=
X-Google-Smtp-Source: AGHT+IEQCHTAkXGd2QhlPLrzCTZtTl0f6r5Mn0SIjCLDcFlCNZ6SlW5cteiWyi0dn3a/3K8p9+vicIMb8/TYHOW/5A8=
X-Received: by 2002:a05:6214:1ccb:b0:68f:e19a:7519 with SMTP id
 g11-20020a0562141ccb00b0068fe19a7519mr8147788qvd.21.1708962591150; Mon, 26
 Feb 2024 07:49:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABg4E-=u7m_g3HCFUYHS-+RC==pefkUZXiTT2Aor86jruHSF9Q@mail.gmail.com>
 <f9296554-9c90-4991-a67e-d1a8defafca3@gmx.com>
In-Reply-To: <f9296554-9c90-4991-a67e-d1a8defafca3@gmx.com>
From: Tavian Barnes <tavianator@tavianator.com>
Date: Mon, 26 Feb 2024 10:49:40 -0500
Message-ID: <CABg4E-nWKrpS+BVuiPosikO1ZSotcfqLo0BFjF7h-_G70G2KBg@mail.gmail.com>
Subject: Re: Corruption while bisecting (was: [PATCH] btrfs: tree-checker:
 dump the page status if hit something wrong)
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 3:30=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
> =E5=9C=A8 2024/2/26 06:00, Tavian Barnes =E5=86=99=E9=81=93:
> > Well, bad news: I started bisecting from v6.0 and after a couple
> > rounds, my root fs is really corrupted:
> >
> > UUID:             e1902620-c206-4e34-9f24-e66cdb6b8872
> > Scrub started:    Sun Feb 25 18:47:29 2024
> > Status:           finished
> > Duration:         0:20:18
> > Total to scrub:   2.72TiB
> > Rate:             2.29GiB/s
> > Error summary:    csum=3D2073625
> >    Corrected:      0
> >    Uncorrectable:  2073625
> >    Unverified:     0
> >
> > All the errors seem confined to one of the four disks which is strange:
>
> Mind to share which commit you're at when hitting the scrub errors?

The corruption seemed to start while testing a kernel somewhere around
6.4.  I'm not sure exactly because lots of the corruption is affecting
the kernel tree I was bisecting from.

> And have you tried with offline scrub (aka, "btrfs check
> --check-data-csum")?

Yes, it also reports a vast number of errors.  But plain btrfs check succee=
ds.

> IIRC during the rework of scrub, there are several regression caused by
> the rework (e02ee89baa66 ("btrfs: scrub: switch scrub_simple_mirror() to
> scrub_stripe infrastructure"), which is around 6.4).

I did the scrub from 6.7.2.  I also mounted with -o
ro,rescue=3Dignoredatacsums and checked the file contents.  The data
really is corrupt in these files, so it's not a problem with the
checksums.

> So if "btrfs check --check-data-csum" shows no error, it would be a
> false alert and you can just ignore them for now.
>
> Thanks,
> Qu
> >
> > BTRFS error (device dm-0): unable to fixup (regular) error at logical
> > 7242230988800 on dev /dev/mapper/slash3 physical 914556321792
> > BTRFS error (device dm-0): unable to fixup (regular) error at logical
> > 7242227580928 on dev /dev/mapper/slash3 physical 914555469824
> > ...

So looking at this closer, a lot of the corruption seemed to be around
the same LBA (~7242...).  It seems like a couple chunks on slash3 are
corrupt.  E.g. this one is in the middle of an .svg file, so it should
be human readable, yet it contains seemingly random bytes:

root@archiso ~ # dmesg | grep svg
[ 2967.927789] BTRFS warning (device dm-0): checksum error at logical
7270571376640 on dev /dev/mapper/slash3, physical 920567676928, root
136483, inode 60843632, offset 110592, length 4096, links 1 (path:
usr/share/inkscape/tutorials/tutorial-shapes.nl.svg)
root@archiso ~ # xxd -s 920567676928 -l 32 /dev/mapper/slash3
d6561c0000: 1a9c a774 a62d 61dc 96e6 fca8 0070 2326  ...t.-a......p#&
d6561c0010: 7579 99b0 096d d4f2 453d 54e1 ec76 81e0  uy...m..E=3DT..v..

That matches the file contents at the beginning of the corruption.  At
first I thought maybe the device tree was corrupt, pointing the stripe
to the wrong disk offset and reading something random, but then I
thought to check the raw encrypted bytes as the corresponding offset:

root@archiso ~ # cryptsetup luksDump /dev/nvme3n1p2 | grep -B2 offset
Data segments:
 0: crypt
       offset: 16777216 [bytes]
root@archiso ~ # xxd -s $((920567676928 + 16777216)) -l 32 /dev/nvme3n1p2
d6571c0000: 0000 0000 0000 0000 0000 0000 0000 0000  ................
d6571c0010: 0000 0000 0000 0000 0000 0000 0000 0000  ................

So what I'm seeing is basically a whole stripe that has been zeroed
out, and LUKS is decrypting those zeros to random bytes.

I wonder if I got hit by some miscalculated DISCARD or something that
wiped the wrong area of the disk.  It could also be a hardware
failure, but I see nothing relevant in nvme {smart,error}-log.

--=20
Tavian Barnes


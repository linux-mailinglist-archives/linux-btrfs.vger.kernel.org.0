Return-Path: <linux-btrfs+bounces-18039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E39BF0302
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 11:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 601B14F2A11
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 09:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913E92F6160;
	Mon, 20 Oct 2025 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0xWh28C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6953E2EC0A1
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952694; cv=none; b=t6z5gPBUbq+tdoo6bTtY+21RGI926PAa0c87HAsImm1VRWUg/KqUMMAuVvPBJd1WUm0PmgXkLCtmzOw7CWUJUche7qNl06oRhJksZeEivy4GPfxuXLBuHoQ7D3+JYYTZrDlBIoKU1YirbUdkYKDd04aK1NNA8jFK9E+qyiWiccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952694; c=relaxed/simple;
	bh=U8CcipM6Z67Ahue4ia0ZUhA+CivhMsdT0HOJNFK/z4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bMPpETvGpGEkmXEM9KiuQA8/zMl9p2DkJDv7jsZsI0k7rxCi8CW9hlcKZFcC70vQijPP4LpCSV8ZD/zx2ch/emiCXrYsezoRb21Se9rJxQm6dUaVyANqf8sPAngqrz+s+NshL24/JLQYN3Mdo4MnvwTm+3NiAkivxnWF4ThiHzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0xWh28C; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33bafd5d2adso3596038a91.3
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 02:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760952692; x=1761557492; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8CcipM6Z67Ahue4ia0ZUhA+CivhMsdT0HOJNFK/z4w=;
        b=d0xWh28CTdBcKu3ww/lDxTj5opph6wppY4ytpIfgym7xhw4YD2WaOX27dgm/bB3fej
         dsinELMajN3EUs6cIsovQ4V0VgDFjhHemrohdxFLM72YKngBGrBGhzknGe3PEZVnEgd6
         HIOzEHq6WzJ91HnR2GmOC+U7MhE3QR4aAB+qkLA9v9+rtRU3CWsYlUmCmc0m6OmTwqXU
         USEwRum/1uoUhPXwHXubY46tl4G/IHZCzl2dcW/QEbBqcxwaQ56SyMbObrXqHFbj+ICr
         SuG+B+QbLqHhFvxkfx2WLiZOUfqsViS4UJV85Yv9uJrp+NihEyKQj9PodQNo74hUfqKI
         WWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760952692; x=1761557492;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8CcipM6Z67Ahue4ia0ZUhA+CivhMsdT0HOJNFK/z4w=;
        b=YJdT3zPkSVsZkJyyiuwNVpcNwyVTWvtEj+BEH0VSAWdzeLTrqqxqMIX8qbWQE3tOfu
         d0QRPi2lb9lJAj/SAHLQt/0B5ybx1dHw2/BXPgao6S/GlsGPePbnCydBVMSEJKGLJFtj
         gUR9vcl20KWzbyRUwiJcYnrg9edKEPnwWrLwrel/coNot0gZIwbtUZt9BZbWGPZCalRe
         NP2VYT+iTJZEXKIZHNtds1NtdzzztTI6bzJtaw3R8oeB5UVi1SJ5Ri4SFrnqmqloJr3G
         nfE2Oh6AePSkAjp9re5xT7WqQ3v9RmHF/0OYyMunU383BhTeWxAofaxWPkGbxdAMe6Ic
         kg2g==
X-Gm-Message-State: AOJu0YyPI9VuZ7AVpRJxDuxrrEB8uze7qCC64l+13QE0tIHeHGZRBrDH
	q8Mwu0Wx3Ugh4nXOJHgJxutXkVrR0pUOyzBRumT8jLVCn12I9/Iy2oFZcE6Cz5wG2EBkGHKNWYM
	DgKN0oLLbz4JudhZy6Yi4RuFu6LylEgJ/mg==
X-Gm-Gg: ASbGncvNfnZdmCYbDvojzPTAGXbrlSPvbGdJghBTqmK5R1M7ETOnmwb4kS168c4/w4v
	bePT6FsGO3AUwXK9vFZWE2jjLxp7M4wxLNG/UTQOd6+7E+7sP1T8GczrLZG7fp223E3U2IRWUX1
	9ycREy7xuUZ3iyxbLSvNMz1N4n1J8bdmuCQlMW7sB17rAmkCwL+BsHxTT4/fH7B8zeHebc+e72G
	Wd8haYmyZB0jJr2Zoq8lWgy8+adIsJ8ISWjtb/F7tiSMpzGrKGDTsUM4QKZWmFQAC+0+p4=
X-Google-Smtp-Source: AGHT+IGY+qZ9XwtudqqSRHueqdNHh8cmIb6n7cb/BlS6Dr1p5aVHwrgNmRdX1+YlGve9a5/gtNuFCHmIRIiuWeDw+kw=
X-Received: by 2002:a17:90b:4f:b0:33b:bf8d:6172 with SMTP id
 98e67ed59e1d1-33bcf92aae9mr16023003a91.34.1760952692068; Mon, 20 Oct 2025
 02:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
 <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com> <20250922082854.GD2624931@tik.uni-stuttgart.de>
 <95ece5d8-0e5a-4db9-8603-c819980c3a3b@suse.com> <20250922092300.GA2634184@tik.uni-stuttgart.de>
 <1e4baff2-1310-437a-be62-5e9b72784a54@gmx.com> <20251020090018.GA1446208@tik.uni-stuttgart.de>
In-Reply-To: <20251020090018.GA1446208@tik.uni-stuttgart.de>
From: Andrei Borzenkov <arvidjaar@gmail.com>
Date: Mon, 20 Oct 2025 12:31:20 +0300
X-Gm-Features: AS18NWDkoVf7jKNWtAuwxEE3L3wC9bH7_4krNd6Ac9hHBicI7UrYXbBxav1_gRw
Message-ID: <CAA91j0UczP5WpCM2ZDqCEAy-6gSFzWgBE4aGVLxLCJ90H77A+w@mail.gmail.com>
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 12:07=E2=80=AFPM Ulli Horlacher
<framstag@rus.uni-stuttgart.de> wrote:
>
>
> Resuming this discussion...
>
> On Mon 2025-09-22 (18:57), Qu Wenruo wrote:
>
> > >>>> So you either run RAID5 for data only
> > >>>
> > >>> This is a mkfs.btrfs option?
> > >>> Shall I use "mkfs.btrfs -m dup" or "mkfs.btrfs -m raid1"?
> > >>
> > >> For RAID5, RAID1 is preferred for data.
> > >
> > > Then the real usable capacity of this volume is only the half?
> >
> > No, metadata is really a small part of the fs.
> >
> > The majority of usable space really depends on the data profile.
> >
> > If you use RAID1 metadata + RAID5 data, I believe only less than 10% of
> > real space is used on RAID1, the remaining is still RAID5.
>
> Sounds like a good compromise solution!
>
> Asuming I have 4 partitions with equal size, then the suggested command t=
o
> create the filesystem would be:
>
> mkfs.btrfs -m raid1 -d raid5 /dev/sda4 /dev/sdb4 /dev/sdc4 /dev/sdd4
>
> Does this setup help to protect against write hole?
>

No. It simply reduces the damage caused by the write hole. Only the
content of individual files is affected, not the metadata.


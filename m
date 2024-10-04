Return-Path: <linux-btrfs+bounces-8540-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 361B098FE66
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 10:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9CE1C231E4
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2024 08:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA5513AD2A;
	Fri,  4 Oct 2024 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T32VUK23"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4751D13957C
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Oct 2024 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028937; cv=none; b=k1mIEpESVJypFNOcVigbj1P/1l49A1HqNdQcaN6l69ZxBNMJu1EY1o4/1apv2YCiPsbkEvgVjyi0xJ2cjkqfXP1V/5xEuaeTXDyAFp75TsIlmNN/gd2oL4Kqmq7VXTHCss0LYm6wPS01Yvv0Phpf8r/1O7uTE3E+rsBS7yC9Jso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028937; c=relaxed/simple;
	bh=jEqsPPNVmuUfFAQgNb1ddEZ/0T9mzGZ8272lCwnXxtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hY96xNJl2VshrHIkkc9HyuPvjxlMJ8bpeOQoVIJXT3iGAa4WaAre80cYFkoWs7XlQLlJ+yFKUKyUC+zwVwXwVQcTTK+aM1UAt+3PO2hA7SY3vEaWOIBZk8MS37qXeZg3E8xUAcRBkd5yXJYFzF3joWyrPnDF9XDTmztYaQbVIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T32VUK23; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fada911953so27711881fa.0
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Oct 2024 01:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728028932; x=1728633732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LkALpbu5OFiEhXaRMZOUcWTxVNPZFxeCEMUkozP3/zE=;
        b=T32VUK23vNan2vHM9fapAkNivBlf2Gg0V6BxxeDbb3jgR8NVJDDPjvYxrTh10OciDy
         /8DzqKPG/cvQ/r48/yoN3j6Fzllm83nGxAkE0U8aFT3Bj8w5xftduxSryQI795Q2CoeI
         9yM9p1zW8rejM0hqujZ6OrlgmxJJh5oEA8PWd4LalrJYaai3tY6cYKzxgToQ15DfP9A5
         KA8Ufjqd+v+YB0d3QIjEQ6jvak/N0d6pE6W9mBAzWPJRsmiZrS7DEKTzqyc0Cm18y7O5
         gjy5m+7svxAKpoF2OKIVsivb6pADJ5MUDsZqv+IYp+7fjDXTRYXmAFngaAs0Oyt0dJ3j
         jERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728028932; x=1728633732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LkALpbu5OFiEhXaRMZOUcWTxVNPZFxeCEMUkozP3/zE=;
        b=i8ITxLyiAl0rnqzJGZOLO99DKldeEV9YjrBreDMTkxASOUSBEpBDoaCvwPegOZtfSo
         P0x83up34s4i+p77iSzQMztY+bznMwUD2yAB1MX+JWR5+2fz27XPFaM6cIs1rT/sPakT
         /n0XuxNwZYuRZ5/4x5BrvRYaUR4tlV1VJJxMfI9OedHxiPKyLr5z1l0spAuUxLXvZUFg
         m9Mape1VFNXaUTkJfpLNOsuvsDuX5QPupxKAAAr8WaYOPkdYIGtOaaKAWSWl/qh/hS6y
         PjuergLLKH3zqRNncuh6jRwUyV5FHkIXsCdLfhU7GEGyo9J/UGtPE2btlxa+ZtZ4Y6He
         6/vg==
X-Forwarded-Encrypted: i=1; AJvYcCX9JB+nwXK3TIKd1OSulVW/6PXfkUnNkEFUaPFWw3XgqUErtgEVqZM9cOni7HRuxs5K5c+Yn6gpKiHGrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZJ9ovYbFiulhgggsTRoOVlnzWh1f5LIJhA62n5lchM9BgZujN
	p7tEHoJH81lnxS1yd/unpbvJy67gsH0O3Gkczw5tehq4lXHzyUT4G7imNJk4httQB5yJuQAYprE
	VB+1u1MAi6kwDWtzWM/ZfUxqU0DM=
X-Google-Smtp-Source: AGHT+IGNJr/c9hZ/BsmTorGA1YwbWwLwQMET1OmdAZ3jJ9+xxPAcHdW0CFA2CZ24peSk1xM/P9dSSEWZYobdBeLiqQI=
X-Received: by 2002:a05:6512:230e:b0:539:9088:240a with SMTP id
 2adb3069b0e04-539a6260713mr1955521e87.10.1728028932087; Fri, 04 Oct 2024
 01:02:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE+k_g+XFhkRBF0ErnRCBVaXAwUb3Tf9rm+Yny8u6aOLDQqihA@mail.gmail.com>
 <20241001150941.GB28777@twin.jikos.cz> <CAE+k_gJETiAtToyw9LoG3QWj-5Govupt9Shp9TFuqevSbt_RbA@mail.gmail.com>
 <094b3ff1-05f4-4557-80db-947a8224b671@suse.com>
In-Reply-To: <094b3ff1-05f4-4557-80db-947a8224b671@suse.com>
From: Peter Volkov <peter.volkov@gmail.com>
Date: Fri, 4 Oct 2024 08:01:59 +0000
Message-ID: <CAE+k_gJcO=T=2amNoNWUEjq8hssmXxZw_KaOTUCqqJ_XvaBpYQ@mail.gmail.com>
Subject: Re: BTRFS critical (device dm-0): corrupt node: root=256
 block=1035372494848 slot=364, bad key order, current (8796143471049 108 0)
 next (50450969 1 0)
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 1:12=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> =E5=9C=A8 2024/10/2 02:40, Peter Volkov =E5=86=99=E9=81=93:
> > On Tue, Oct 1, 2024 at 3:09=E2=80=AFPM David Sterba <dsterba@suse.cz> w=
rote:
> >> On Tue, Oct 01, 2024 at 02:15:51PM +0000, Peter Volkov wrote:
> >>> Hi! I've been using this system with this kernel (6.10.10) for a few
> >>> months already and today out of nowhere btrfs broke with this error
> >>> message:
> >>>
> >>> [53923.816740] page dumped because: eb page dump
> >>> [53923.816743] BTRFS critical (device dm-0): corrupt node: root=3D256
> >>> block=3D1035372494848 slot=3D364, bad key order, current (87961434710=
49
> >>> 108 0) next (50450969 1 0)
> >>
> >> Quite obvious memory bitflip:
> >>
> >> 8796143471049 =3D 0x8000301c9c9
> >>       50450969 =3D 0x301d219
> >>
> >> The first one should probably be 0x301c9c9, but it's impossible to tel=
l
> >> how many other data/metadata could have been hit by this or another
> >> memory bitflip so check can detect the things but not fix.
> >
> > Thank you David! Is my understanding correct, that btrfs catches
> > memory problems,
> > so this bitflip most probably means that my drive is failing?
>
> In this particular case, it's your hardware memory, not the drive.

Thank you, guys! You are right. memtest showed memory errors.

> The error is happening at write time, so the metadata read from disk is
> fine, thus not your driver returning some weird data.
>
> Furthermore, it's pretty hard that a simple bitflip can pass the
> internal checksums of the storage device, thus it's very unlikely it's
> your drive.
>
> So, please do a full memtest of your system before doing anything else.
>
> And considering your fsck result is already bad, it's no doubt that some
> bitflip has already corrupted extent tree, and I believe the csum tree
> is also corrupted.

So I have to start over from last backup. Or is it possible to fix
some of this bitflips to read at least part of tree?

--
Peter.


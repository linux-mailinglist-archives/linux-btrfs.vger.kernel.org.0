Return-Path: <linux-btrfs+bounces-6961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBD2945E85
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 15:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8721C218B4
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323371E4853;
	Fri,  2 Aug 2024 13:18:30 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFF3481AA
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2024 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722604709; cv=none; b=MYje5o/0aJ1Nh91QTlOPzY6kye8B+33tEiBBx8GWx2w19pZd1x2DfOBZxb2hQ+7yEiFrPia4yqgzZXWWGOGaUj92hxzG8c3kgw7ZfxIpCat//d3J+mMZ+04FuV7kSSOrPBwvqKYgyCEP0JodZ/ZfFAjInU4qwn3eHun+gEBpaeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722604709; c=relaxed/simple;
	bh=rby3lyrrgVykqmRonCD8sv/qRt/HzwJznw4DZOnAvMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBEmEYGbmYnBCD9fA3vPD9LEbqe+qRnELp32vmqH7YnbIb5JPWBJpe/Gb+fLd9zYV8iBD44AT6NRGjnbz0TjxxG4PdrV1wUTy3AXY8fmXRlPIOeLqMRYpR//+8jTr6bub9ahTtSmq8e7oY7ecu/hewd6vPLc4NTc698Gkp4ThIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52efc60a6e6so12693751e87.1
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2024 06:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722604705; x=1723209505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFgLbh2c+9Ff40sMfbqxs6Sdchj9W8PixHQxdBbOf5c=;
        b=kxGPe0vAK18SLBNz40rgg8CUP3wrEFrDaiWVzK0SclyHhMLbK3lTD9WDEq/o3UV/yV
         Ekq9SdGQEr7L5vMDifE6UnqGAwIxVl1bk4psmAqyEqBsS4g8th/p20Pmxh6Zbud5qtnn
         ZsWB8vZb81Wcu53zEBOkXniAFEQ6x4b0t/pj9jOKHlK3CCpLWMaiIOYZGFQ4ghcrTnjh
         wN+zYFsPFg727+yIEKuoGneTwmm2BaNGaAubdb1woGNZrPk0JurCEbOkCkQ4OE8Sy5/S
         vhqFTWISahUF6RXdR/NrPOD6VLpeZFZtkxxHonMOvfblW+6WTXwoDn0gohC1TqSxeGyg
         5HHw==
X-Gm-Message-State: AOJu0YylgSmNxVXhzQUdT8jz84Uq4W48u38BsvTkJeqv6H/xdJaZXOgp
	6AXyXRFQuoEugFxAUbTUV3r0GMqHFcsyNYZSdxsZxpgl9Cv2WY3wLpzZQ/Tu
X-Google-Smtp-Source: AGHT+IFADz1eW6no1EhL8fifAWA/q8TXS/q06D8RRuHuz+KT6vA0ZG8HgbrYtd9u9hfR8TJfLmDwtQ==
X-Received: by 2002:a05:6512:3d20:b0:52c:dcab:6738 with SMTP id 2adb3069b0e04-530bb36686fmr2459797e87.1.1722604703791;
        Fri, 02 Aug 2024 06:18:23 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3c9asm99818966b.37.2024.08.02.06.18.23
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 06:18:23 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7abf92f57bso1055997066b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2024 06:18:23 -0700 (PDT)
X-Received: by 2002:a17:906:794d:b0:a7d:2429:dc16 with SMTP id
 a640c23a62f3a-a7dc5107ce6mr198974766b.65.1722604703360; Fri, 02 Aug 2024
 06:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802112730.3575159-1-maharmstone@fb.com>
In-Reply-To: <20240802112730.3575159-1-maharmstone@fb.com>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 2 Aug 2024 09:17:45 -0400
X-Gmail-Original-Message-ID: <CAEg-Je9Z2LFK_rcttHvvXOJ89m9FSBK4k5ThuE5sUAbsqhUxGg@mail.gmail.com>
Message-ID: <CAEg-Je9Z2LFK_rcttHvvXOJ89m9FSBK4k5ThuE5sUAbsqhUxGg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] btrfs-progs: use libbtrfsutil for subvolume creation
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 7:27=E2=80=AFAM Mark Harmstone <maharmstone@fb.com> =
wrote:
>
> These patches are a resending of Omar Sandoval's patch from 2018, which
> appears to have been overlooked [0], split up and rebased against the
> current code.
>
> We change btrfs subvol create and btrfs subvol snapshot so that they use
> libbtrfsutil rather than calling the ioctl directly.
>
> [0] https://lore.kernel.org/linux-btrfs/ab09ba595157b7fb6606814730508cae4=
da48caf.1516991902.git.osandov@fb.com/
>
> Changelog:
> * Fixed deprecated function names
> * Fixed test failures (now returns correct return value on failure)
> * Fixed this breaking fstest btrfs/300 (thanks Boris)
>
> Mark Harmstone (3):
>   btrfs-progs: use libbtrfsutil for btrfs subvolume create
>   btrfs-progs: use libbtrfsutil for btrfs subvolume snapshot
>   btrfs-progs: remove unused qgroup functions
>
>  cmds/qgroup.c    |  64 ----------------
>  cmds/qgroup.h    |   2 -
>  cmds/subvolume.c | 194 +++++++++++++++++++----------------------------
>  3 files changed, 76 insertions(+), 184 deletions(-)
>
> --
> 2.44.2
>
>

Series looks good to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


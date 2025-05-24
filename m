Return-Path: <linux-btrfs+bounces-14196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE12AC2D01
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 04:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4054A08A4
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 02:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36B916A956;
	Sat, 24 May 2025 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUGOzsVy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAE026ACC
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748052024; cv=none; b=n3W+BhcRomDucIcXgShHLrMivLX2SAI6B7UWMyFgTDjGTIXu55QnYshMiSNNbobVfRl6dTL/slBkzSbYeNP6sKwSZpx+Jna1KJXfEBG3RcvapGxMRqfqVk8aFDFikbOGySgYC0fRT8nbVLTuuzt7Fbhi/ITxUia0yK1fddoKtKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748052024; c=relaxed/simple;
	bh=Nc+3s8mtfKiQMLrosU+4riwLqtu+WQhaw+bscU8KY1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhSzNm77EvQJRB6NhDLIpo960qoMC0bj44XFnVxPiJXCXYYWKCa9JZAqzJ8jf/wI4tvTER06GjK/9a32GiHpJvbE6dXKH88ZjMYrNlGiwoCJzjvDeU5RWWVfpft33gNvutYR+5aS63wmQLNWplztnyw8Lut/qPi687nVouae6JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUGOzsVy; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-52617ceae0dso172762e0c.0
        for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 19:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748052021; x=1748656821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvqlzXT8t2KcNOL1dmWh/BRvLjOhpWpgW08jw5DPcG4=;
        b=SUGOzsVy7XPkctMbNpk02UlKfdJTHeUC25PRlgY1h+qqt8zgomTrhk6LAb2RREwhhL
         mU1YPmkFlDjM6RnBytxNxbJrp+lg/jQEvYiRtpqx9vPHNMjPN8fmQaoi4Iarec7gjc/L
         OzDXgdGLAStgH/EMctFvQwyYpE+bFeM6b8gopY2DyeGi5MzPHC6qMbrpdBQmJZCoJX/7
         cvsiCHDlcKBL4M2pWq6H3tnq6DgpcGcyRZpQyE0DVvXmDA/y4RpHq4RAHc//IM+g4XwI
         GLoGvtvxXN/LOhtIuB6DLXjtxlbEtrI0QBb8D6iIxi2C/PwKrkWjre/13e7exgurc+tr
         hW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748052021; x=1748656821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvqlzXT8t2KcNOL1dmWh/BRvLjOhpWpgW08jw5DPcG4=;
        b=ILL373NusBtt3/dIHfxkkl+iFL5U5pYebtsiyrPoGq6ZY35NCFzQywaBSwCxfgDFgj
         LHKQQzzEda+vLNa1LpMARSljn+wBG5AKG9guPvXjZjrT1akPCDAyUwV1JIZXuL2GHVfE
         667X4TztZXXb/i+gD7rxLYItHuPuZb727rH4DSnuSWAHPbX596oT5zdSOLWfa/xWyHMK
         Nz0neqSZZzUS6lrpKWBLpTpbkydIUWI4A5Jfeg3tmJSnZKC7lBPaHyCf4f8qvjfXTrOW
         vhp7bE6PvfLB/BeN58AILsYHkszbRQhOumJ6ycr43CRphDaez8jmVcCfIRYfNziep9X8
         wSLw==
X-Forwarded-Encrypted: i=1; AJvYcCWmDHhwrDTNq0Zt9D2HZlfcgC9d+DprMcgZ79aPze7cyh/vik+yH2DhPE2mdGg+MAqrEq/8OvBoZ6uLNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPRi2T4EmT/MLorSt9T++77Tu9o7iizKJK8QMH/rux2whCq19o
	Qwkx3K4W9udadEEHO3kafbmkqSTR/INO5ojXM0Tvz2Z+n4LioAQlbKCvWuNaC5rktyiekF1Birs
	N0t2Y18FG+bYO5TXcAJvJVz3ryr7OvAIs2CLy
X-Gm-Gg: ASbGnctCndGUfp4Qvl7IlSgSUNiA4Ys8ugqwQhpYxuAxXu9ZCSdMsxf7/nCBResNBip
	0OK5Ginad/cz8J79r129D5kr67nFDdfRHOc9hXudrUQIdCUsDRzp8HjnIqwpZiiwWrAv56ElzNU
	DWBoVdN8NmKmKQL6l9FTUp49rbrBbQfT5F
X-Google-Smtp-Source: AGHT+IF7ie8InFxTNOmyBIXayqWue/8P1BSpddKCNdEd9cjUAJ+k1qxglNXlDRrzy5Q7t17JaFGOsv6w/5uZYATNFwk=
X-Received: by 2002:a05:6122:1822:b0:526:7f3:16e0 with SMTP id
 71dfb90a1353d-52f2c4aff40mr1270458e0c.1.1748052021120; Fri, 23 May 2025
 19:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521032713.7552-1-sawara04.o@gmail.com> <20250521032713.7552-3-sawara04.o@gmail.com>
 <e508301e-4474-4490-93ad-bbea3e6ed04d@gmx.com>
In-Reply-To: <e508301e-4474-4490-93ad-bbea3e6ed04d@gmx.com>
From: Kyoji Ogasawara <sawara04.o@gmail.com>
Date: Sat, 24 May 2025 11:00:10 +0900
X-Gm-Features: AX0GCFuDvCXtm_QoeiuVLGnXS88p7Ac1yA56dGEIRztl6ywPiKFd09h0w2gRptI
Message-ID: <CAKNDObAZHiqromZUimS_V3mfDT5CJaBN91rhOYr7b4nLTh-__w@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: Fix incorrect log message related barrier
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review.

Regarding the Fixes tag, would you prefer I resubmit the patch with
Fixes: eddb1a433f26 ("btrfs: add reconfigure callback for fs_context")?

2025=E5=B9=B45=E6=9C=8821=E6=97=A5(=E6=B0=B4) 13:15 Qu Wenruo <quwenruo.btr=
fs@gmx.com>:
>
>
>
> =E5=9C=A8 2025/5/21 12:57, sawara04.o@gmail.com =E5=86=99=E9=81=93:
> > From: Kyoji Ogasawara <sawara04.o@gmail.com>
> >
> > Fix a wrong log message that appears when the "nobarrier" mount
> > option is unset.
> > When "nobarrier" is unset, barrier is actually enabled. However,
> > the log incorrectly stated "turning off barriers".
> >
> > Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> This is definitely a copy-paste-error.
>
> And we can add a fixes tag when merging:
>
> Fixes: eddb1a433f26 ("btrfs: add reconfigure callback for fs_context")
>
> Thanks,
> Qu
>
> > ---
> >   fs/btrfs/super.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 012b63a07ab1..0e8e978519d8 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -1462,7 +1462,7 @@ static void btrfs_emit_options(struct btrfs_fs_in=
fo *info,
> >       btrfs_info_if_unset(info, old, NODATACOW, "setting datacow");
> >       btrfs_info_if_unset(info, old, SSD, "not using ssd optimizations"=
);
> >       btrfs_info_if_unset(info, old, SSD_SPREAD, "not using spread ssd =
allocation scheme");
> > -     btrfs_info_if_unset(info, old, NOBARRIER, "turning off barriers")=
;
> > +     btrfs_info_if_unset(info, old, NOBARRIER, "turning on barriers");
> >       btrfs_info_if_unset(info, old, NOTREELOG, "enabling tree log");
> >       btrfs_info_if_unset(info, old, SPACE_CACHE, "disabling disk space=
 caching");
> >       btrfs_info_if_unset(info, old, FREE_SPACE_TREE, "disabling free s=
pace tree");
>


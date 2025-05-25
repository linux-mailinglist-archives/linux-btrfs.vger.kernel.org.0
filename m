Return-Path: <linux-btrfs+bounces-14223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0234AC3227
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 May 2025 04:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C3C1898A70
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 May 2025 02:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532073D984;
	Sun, 25 May 2025 02:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5t3MQXU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C1C120
	for <linux-btrfs@vger.kernel.org>; Sun, 25 May 2025 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748140354; cv=none; b=kzsOqvX949gCVC9w2g43a/q6nFfIp3tJDHKrfCPnYKQOCQ3kUFScWwMHFUBQZE/d/bMesv7w1SUuWDzAaNq8q1TM/ya3605oXCYdfN08GsId+MqfkD4u8TvaEBcuwC0CRcdNZWp2yNEJT+HVQCbZFfvSpjyh7g+9cb/WKJuBy6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748140354; c=relaxed/simple;
	bh=gldz0hHg7+Kauzzxlw6ODqwzc8IuFQkwiQllKuvaK6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsVl7MO/Y09WzHpvcJhxaALeHErjilO1moXZbATDs7olsYogyc96CiY+Gvsyc3QJOdOzIdTQe8M7TeTI0hjl5VIy3TWPah/zMHo1SjBaVgwXWzuAXOUl77HxylMenTqOIDBT8UYp2cVS+oGa0B/07Z/7Dyo73Kr15POrJpUlTXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5t3MQXU; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4dfa2aeec86so388416137.1
        for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 19:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748140352; x=1748745152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9ueiHJSs1CpWx4cwtZbF+8/veTFuh+bTxWx13HN/IY=;
        b=L5t3MQXUqxPB0Bh07hfUuA339w7R+XN3uYb0Uez4QYaSroIprOqyU5Jy4cl6U0+t2u
         0sUlaW6SgCD6rz/nQTDkKeN8//2+WnEmyTx49MyNMbvP2GkTMjZD/iX2ZDiEWYKpE4oy
         zLu+6eiFExI3nSd4b/LuNLLMD1EdW1mvuLzIWsnjmkfkWwXgwKeX2RNU4XxQwhduGyYS
         AGz7+Ty/sT7DCMlOmImCObfW2o02fOK4f6Ep23KOV4kMp3jQ5FjK7h4ybKdqYk+BVvr2
         rMm+jd9T6NeOJOJaedrI7RHO/NeS9n1eVsOnJboODj4t/Woa/Bxb2dwK5Fxtdu1CwCZt
         3A5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748140352; x=1748745152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9ueiHJSs1CpWx4cwtZbF+8/veTFuh+bTxWx13HN/IY=;
        b=GQl80lii1bIs+HNditukm4FYdrULli2jpyVsnNdkXgo5l0idKmYcjyfvBlIEcSnL/I
         uvfOV8shR0DNpDhqpDff2UJfD9gULrvE93iK3wyPsW3e9EBzXtVCSIGVA0Oog1YG7DKN
         sEcY3htFxO5agsZPu9UKqQfmgEdPSWyJ9rFerTEQ1LqGtLcvQrwhkmXAd1SZxZWa6pbS
         1paEdml4l6kN2XnNZcBV9/HjcZsjiqcnfabWXZmhNFiAttegEPZWIwo3svBvwNL2pCGd
         uxkfQCXwTB2Xn9J2J7okLdnPGLCOqyV2FPGvyKK5tjppUs8jdym9qsO1gHzTz2priVRF
         /l4A==
X-Forwarded-Encrypted: i=1; AJvYcCXriMKGdeCLR3FygNPiRhQtwuEehCwWw/XBewPuuZeQY8bus55dxyKWGBQV73P7zBnwLMBQT6exkAboWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwTpna4vxMdT85WgySndVhpjXEW4EcAL4pzlaWlUbd4ujDlAPHT
	DmA+Hl2jV0BTBICaHpxzmF1hQ/n4/2wiw5GWUaAuh6KqP7QkqjIlVt2JYrFVax8m9eos093YpnR
	+CeFYjqGc+8G49Bml3a+eaKGRT2WfP+Q=
X-Gm-Gg: ASbGncuPPIz2WVZlcH7D3inUhj1XJzU7fdGrrQFueCUk898TVRTresA3tCxoSmxseKR
	o/QcHui6BDORIullRG5d7Xui/VuTmXvdx0Z/CNT7+pECev9/QDmAofb2akuxk3IDIdmLk/fHEzF
	lesIMzKp45PtkfZUaJ3rVNA7CyFsyBaRDp
X-Google-Smtp-Source: AGHT+IHOna4Rq0S650iI69hqkLNkwAV+0CCAGeIBxWoFA8RgOCJR4qFLgAikroUyCjxxEAHcx4ARyEQcIkaul0eqNTw=
X-Received: by 2002:a05:6122:2207:b0:520:61ee:c814 with SMTP id
 71dfb90a1353d-52f2c4a88f3mr3247168e0c.1.1748140351748; Sat, 24 May 2025
 19:32:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521032713.7552-1-sawara04.o@gmail.com> <20250521032713.7552-2-sawara04.o@gmail.com>
 <68a7d14b-913b-48e0-be12-5bba0d17ea2b@gmx.com> <CAKNDObChsMqFAYK-QT8DmFEitFX+Pmi7ifGDbYe2GfnPnUr1FQ@mail.gmail.com>
 <af00227c-c301-4311-b570-47f4d404c499@suse.com>
In-Reply-To: <af00227c-c301-4311-b570-47f4d404c499@suse.com>
From: Kyoji Ogasawara <sawara04.o@gmail.com>
Date: Sun, 25 May 2025 11:32:20 +0900
X-Gm-Features: AX0GCFtFS9DBk3bq37tNkXBMQ0oc2-3A7Ue_AG-zJH-b-7N8DbyD1c1oPLUbBIQ
Message-ID: <CAKNDObAwjpNv1rJJ1LWis2Eh18QBi8O4Kfje45YZvsqiJa78sA@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: Raise nobarrier log level to warn
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it, thanks.

I'll add the "turning off barriers, use with care" log at the info
level in btrfs_emit_options().

Since this is part of a patch set and "[2/2] btrfs: Fix incorrect log
message related barrier"
doesn't need a Fixes tag, should I just resubmit the corrected version
of this patch?

Thanks,
Kyoji

2025=E5=B9=B45=E6=9C=8824=E6=97=A5(=E5=9C=9F) 12:49 Qu Wenruo <wqu@suse.com=
>:
>
>
>
> =E5=9C=A8 2025/5/24 11:51, Kyoji Ogasawara =E5=86=99=E9=81=93:
> > Thanks for the explanation. I understand the issue with btrfs_parse_par=
am()
> > being triggered multiple times.
> >
> > If I move the log into btrfs_parse_param(), it would currently use
> > btrfs_info_if_set(),
> > resulting in an info level log.
> >
> > Is an info level acceptable for this warning, or would you prefer a
> > warn level log?
>
> I think info level is good enough.
>
> As the main purpose of that message line is still just to show we're
> using barrier or not, the extra "use with care" is just something good
> to have.
>
> Thus no need to go warning IMHO.
>
> Thanks,
> Qu
>
>
> >
> > If so, should I create a new helper function like btrfs_warn_if_set()?
> >
> > 2025=E5=B9=B45=E6=9C=8821=E6=97=A5(=E6=B0=B4) 13:13 Qu Wenruo <quwenruo=
.btrfs@gmx.com>:
> >>
> >>
> >>
> >> =E5=9C=A8 2025/5/21 12:57, sawara04.o@gmail.com =E5=86=99=E9=81=93:
> >>> From: Kyoji Ogasawara <sawara04.o@gmail.com>
> >>>
> >>> The nobarrier option disables barriers, improving performance at the =
cost
> >>> of potential data loss during crashes or power failures especially on=
 devices
> >>> without reliable write-back caching.
> >>> To better reflect this risk, the log level has been raised to warn.
> >>>
> >>> Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
> >>> ---
> >>>    fs/btrfs/super.c | 7 ++++---
> >>>    1 file changed, 4 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> >>> index 7310e2fa8526..012b63a07ab1 100644
> >>> --- a/fs/btrfs/super.c
> >>> +++ b/fs/btrfs/super.c
> >>> @@ -407,10 +407,12 @@ static int btrfs_parse_param(struct fs_context =
*fc, struct fs_parameter *param)
> >>>                }
> >>>                break;
> >>>        case Opt_barrier:
> >>> -             if (result.negated)
> >>> +             if (result.negated) {
> >>>                        btrfs_set_opt(ctx->mount_opt, NOBARRIER);
> >>> -             else
> >>> +                     btrfs_warn(NULL, "turning off barriers, use wit=
h care");
> >>> +             } else {
> >>>                        btrfs_clear_opt(ctx->mount_opt, NOBARRIER);
> >>> +             }
> >>>                break;
> >>>        case Opt_thread_pool:
> >>>                if (result.uint_32 =3D=3D 0) {
> >>> @@ -1439,7 +1441,6 @@ static void btrfs_emit_options(struct btrfs_fs_=
info *info,
> >>>        btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
> >>>        btrfs_info_if_set(info, old, SSD, "enabling ssd optimizations"=
);
> >>>        btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd all=
ocation scheme");
> >>> -     btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers")=
;
> >>
> >> I know you want to avoid duplicated messages about the nobarrier.
> >>
> >> But it is better to use btrfs_emit_options() to add the warning.
> >>
> >> The problem of showing the error in btrfs_parse_param() is, it can be
> >> triggered multiple times.
> >>
> >> E.g. mount -o nobarrier,nobarrier,nobarrier $dev $mnt
> >>
> >> Then there will be 3 lines of "turning of barrier, use with care".
> >> But inside btrfs_emit_options() it will be only once.
> >>
> >> In fact this also affect the warning for excessive commit mount option=
,
> >> but there is no better solution for that option, but we can do better =
here.
> >>
> >> Thanks,
> >> Qu
> >
>


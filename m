Return-Path: <linux-btrfs+bounces-14227-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E548EAC35FF
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 May 2025 19:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393033B14C2
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 May 2025 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ED6246326;
	Sun, 25 May 2025 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jkqo64cf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E442192E1
	for <linux-btrfs@vger.kernel.org>; Sun, 25 May 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748195118; cv=none; b=T31Hf4PhV2AVFjwdTKC2BN7zfcZQ0TqpK2Eei4XXJTa4hV0rWsByML6HpYdgTKVERzac5JKJH5jThtPBHLXIm4j4kms+kQSJJaE6KfvoKpke8hAqvm8vukhZPegZvnk2HBzLiVGhimOnNc8YQc4S9xQkDJY9qQu97tSefMW1D4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748195118; c=relaxed/simple;
	bh=iblzUvJamoP0C3WPqFopEb2plbAh4QtD48Qn/n+vRMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbDPKHVQidkG/a28wzTe8iWmzRLxT6VBBRlOHKi3UCyHKG5mstU/RHRhEqWg5aoV0pk0dRY1cGY2sQAMz9gpj6MY5jYRVWYvLOpbyB4SUfMNstElx2vekQ54l5jG5LxVcOFTWOuHGK1YK+e87ddKse3toFcmyjeOFeQyj5/bmLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jkqo64cf; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-52e728960c3so596121e0c.2
        for <linux-btrfs@vger.kernel.org>; Sun, 25 May 2025 10:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748195115; x=1748799915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3KGgG8M5GmPN7zzynyOpgb8/LYfqOlPzMawVv7AqTM=;
        b=Jkqo64cf6k4FB6mM7WSXaFzDiksDESDvqMA3IO9teHyGLcxYqsuorg7m6PVReWQWKQ
         uUrEllwy5Wq7SahAGUGqBpknS9RWCn0jtdG/h01j5Mf3OQW3B8WOwmIPKx6ABGD2Jtkx
         KjTwgFUDnRezwLGoxkppTaUl5i6UBTOpNwJRojceocnlHwtWT16+pydKKF9Lbn1TDvgp
         6hBO9jvhGMfLiqwzrPlg/W5wW1y9lCqEirrBMSl15O0h5QVxVLUybX96MNuJxUwUnHKm
         v9gMxA/PYgPgzU8DDWlwwp1+rpshGWt6aaG15S8JtHoji0RPTEjcryMotY95Pv2U9QCN
         Rasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748195115; x=1748799915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3KGgG8M5GmPN7zzynyOpgb8/LYfqOlPzMawVv7AqTM=;
        b=rhuNkGCT956zZlVdl2XwrBIQFAfX2F3GJihGqlyBabFkMP5w7kdsKNfXPufHaihZvx
         Iu8rHvQTUI38pD1Prw48uovbXsm7+BcK72iQaX4ys/X0tyDPTj15sdwn+q43Pbap0yXw
         /vIB8ledt8OZwZ7y9T9N4erHqkie2qrcMqaWNKqWSILRpMyC9QrvzcEv+GZTDaR8EWsw
         mzzz345h6waXHAG/hE3pfRz6okfGewygh4duZXeWX2gFo25P6yo6JVqSgcPT/nJWUaxT
         2dybkdcDfQ9P1rzPCVm7wbfmTXmqXeqUGpGCeccgGR35MJtnbkjYjbjioU6pmE9NbJSG
         qPSA==
X-Forwarded-Encrypted: i=1; AJvYcCW4LCgyJAjYZsDoRnidwCucs379PkLKRVOiK4t+heFq0noQcxDnvBhYVcwAOV9SxWZy3JaFoFHqGTTuXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3B39Ead/JZIRjMD8dQ9OzsPEREh7h3BWgXRaB9vfGRvWrUcUv
	XnmkqL3YYpep31Qmh87fQXG0dtmbAuA/2sxEbqzqZuuAhZna0uM0xzkqJyR8hGmqmRQ5QDY610a
	rTZjwV2KPK/NrRHBj3a/xDitHpFrLOFI=
X-Gm-Gg: ASbGncvjUvpmLAHuxj6VK7V4cVA7YRDnGaRarIuABRag7YCNDgxQh0f8S0mZi/qsuJU
	8l3WlMeAnndFKLVYPatpoKNJLGq1tQ54FzPbvQnu3PI1pmZsyM3tPORFRYgPsYtmuqYaZgw8P/n
	/KhkexO2Qiieio73Pt6N4BgjNYEPFxjtbr
X-Google-Smtp-Source: AGHT+IHWsKuMVWXQ1BqBR4j5PIVrfvrt2/aLFp3qEhMuCmgnPePEl6IsNG9O+LlsgOht8V6x6kckJVuxP9r1GrJQkPY=
X-Received: by 2002:a05:6122:82a6:b0:520:5185:1c31 with SMTP id
 71dfb90a1353d-52f2c590417mr5177165e0c.9.1748195115544; Sun, 25 May 2025
 10:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521032713.7552-1-sawara04.o@gmail.com> <20250521032713.7552-2-sawara04.o@gmail.com>
 <68a7d14b-913b-48e0-be12-5bba0d17ea2b@gmx.com> <CAKNDObChsMqFAYK-QT8DmFEitFX+Pmi7ifGDbYe2GfnPnUr1FQ@mail.gmail.com>
 <af00227c-c301-4311-b570-47f4d404c499@suse.com> <CAKNDObAwjpNv1rJJ1LWis2Eh18QBi8O4Kfje45YZvsqiJa78sA@mail.gmail.com>
In-Reply-To: <CAKNDObAwjpNv1rJJ1LWis2Eh18QBi8O4Kfje45YZvsqiJa78sA@mail.gmail.com>
From: Kyoji Ogasawara <sawara04.o@gmail.com>
Date: Mon, 26 May 2025 02:45:04 +0900
X-Gm-Features: AX0GCFt7FFfSTtoHPYGp1m2tPSB09C0NHn3hFmEoxH_NeJ9O7EKQ-NIjQKegasg
Message-ID: <CAKNDObB25gQHWQEHQCQ1J6SOCY3KPH9VEpDdPjicvEveF8s+vA@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: Raise nobarrier log level to warn
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com, josef@toxicpanda.com, 
	dsterba@suse.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for sending piecemeal updates.

I've realized that if the log goes into btrfs_emit_options(), it'll
only show up during remount operations.

So, I was thinking of adding the following code to open_ctree(), right
after the btrfs_check_options() call.

       if (btrfs_test_opt(fs_info, NOBARRIER))
               btrfs_info(fs_info, "turning off barriers, use with care");

What do you think of this approach?

We could also set the log level to warning if that's preferred.

2025=E5=B9=B45=E6=9C=8825=E6=97=A5(=E6=97=A5) 11:32 Kyoji Ogasawara <sawara=
04.o@gmail.com>:
>
> Got it, thanks.
>
> I'll add the "turning off barriers, use with care" log at the info
> level in btrfs_emit_options().
>
> Since this is part of a patch set and "[2/2] btrfs: Fix incorrect log
> message related barrier"
> doesn't need a Fixes tag, should I just resubmit the corrected version
> of this patch?
>
> Thanks,
> Kyoji
>
> 2025=E5=B9=B45=E6=9C=8824=E6=97=A5(=E5=9C=9F) 12:49 Qu Wenruo <wqu@suse.c=
om>:
> >
> >
> >
> > =E5=9C=A8 2025/5/24 11:51, Kyoji Ogasawara =E5=86=99=E9=81=93:
> > > Thanks for the explanation. I understand the issue with btrfs_parse_p=
aram()
> > > being triggered multiple times.
> > >
> > > If I move the log into btrfs_parse_param(), it would currently use
> > > btrfs_info_if_set(),
> > > resulting in an info level log.
> > >
> > > Is an info level acceptable for this warning, or would you prefer a
> > > warn level log?
> >
> > I think info level is good enough.
> >
> > As the main purpose of that message line is still just to show we're
> > using barrier or not, the extra "use with care" is just something good
> > to have.
> >
> > Thus no need to go warning IMHO.
> >
> > Thanks,
> > Qu
> >
> >
> > >
> > > If so, should I create a new helper function like btrfs_warn_if_set()=
?
> > >
> > > 2025=E5=B9=B45=E6=9C=8821=E6=97=A5(=E6=B0=B4) 13:13 Qu Wenruo <quwenr=
uo.btrfs@gmx.com>:
> > >>
> > >>
> > >>
> > >> =E5=9C=A8 2025/5/21 12:57, sawara04.o@gmail.com =E5=86=99=E9=81=93:
> > >>> From: Kyoji Ogasawara <sawara04.o@gmail.com>
> > >>>
> > >>> The nobarrier option disables barriers, improving performance at th=
e cost
> > >>> of potential data loss during crashes or power failures especially =
on devices
> > >>> without reliable write-back caching.
> > >>> To better reflect this risk, the log level has been raised to warn.
> > >>>
> > >>> Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
> > >>> ---
> > >>>    fs/btrfs/super.c | 7 ++++---
> > >>>    1 file changed, 4 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > >>> index 7310e2fa8526..012b63a07ab1 100644
> > >>> --- a/fs/btrfs/super.c
> > >>> +++ b/fs/btrfs/super.c
> > >>> @@ -407,10 +407,12 @@ static int btrfs_parse_param(struct fs_contex=
t *fc, struct fs_parameter *param)
> > >>>                }
> > >>>                break;
> > >>>        case Opt_barrier:
> > >>> -             if (result.negated)
> > >>> +             if (result.negated) {
> > >>>                        btrfs_set_opt(ctx->mount_opt, NOBARRIER);
> > >>> -             else
> > >>> +                     btrfs_warn(NULL, "turning off barriers, use w=
ith care");
> > >>> +             } else {
> > >>>                        btrfs_clear_opt(ctx->mount_opt, NOBARRIER);
> > >>> +             }
> > >>>                break;
> > >>>        case Opt_thread_pool:
> > >>>                if (result.uint_32 =3D=3D 0) {
> > >>> @@ -1439,7 +1441,6 @@ static void btrfs_emit_options(struct btrfs_f=
s_info *info,
> > >>>        btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum")=
;
> > >>>        btrfs_info_if_set(info, old, SSD, "enabling ssd optimization=
s");
> > >>>        btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd a=
llocation scheme");
> > >>> -     btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers=
");
> > >>
> > >> I know you want to avoid duplicated messages about the nobarrier.
> > >>
> > >> But it is better to use btrfs_emit_options() to add the warning.
> > >>
> > >> The problem of showing the error in btrfs_parse_param() is, it can b=
e
> > >> triggered multiple times.
> > >>
> > >> E.g. mount -o nobarrier,nobarrier,nobarrier $dev $mnt
> > >>
> > >> Then there will be 3 lines of "turning of barrier, use with care".
> > >> But inside btrfs_emit_options() it will be only once.
> > >>
> > >> In fact this also affect the warning for excessive commit mount opti=
on,
> > >> but there is no better solution for that option, but we can do bette=
r here.
> > >>
> > >> Thanks,
> > >> Qu
> > >
> >


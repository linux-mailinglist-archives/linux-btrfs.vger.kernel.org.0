Return-Path: <linux-btrfs+bounces-12886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0330AA813D0
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 19:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B183ACE93
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 17:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8628923E22A;
	Tue,  8 Apr 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bUIFGgtY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275F23C8CF
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744133811; cv=none; b=PlwwCV4lzARWSdAtXu82bgpsDnAcsv8olRtAhMcMUSkRlLk+KpLAfwL/Lxs6ZneqdKU7oSQgQKuDyiFrSuL8XWtUCqQfXjGjxArXnWF4GjgrC3Avyozw1b3Z7MsPKMT+l+1rYF03AqA3crRIihmB3UpU7FD7gBDEwc+ZG1Wri5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744133811; c=relaxed/simple;
	bh=Rv7zOuACo6PGkjONa/rGcG49ntJyvTgEc7rzdn4cZuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fkm+y0MaQtU2OsX/vDOmQbam/f91tyLTmY48yrILOJYwP/s51BiDfZPSzYNPdKXmfPNnX/nyJ3u/wMfcnqO+FIi+bikEwN8O3Zwml9JXHnfl6Et1sj+6RwmKLBWu69R2nscBMxKXsB8A+22ltAtFFfsPGuSbqlWRPHbj6j+lATg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bUIFGgtY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abbd96bef64so1137453466b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Apr 2025 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744133806; x=1744738606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnCEslMdaS7r7+0ovfJH0qTPww6j0X72ov4ejqDicq4=;
        b=bUIFGgtYbf3w92ADjWQ4f7WRca6K3ZEY8UiXiXAXgloAfvSRiP8SsFjM0msy80a6VF
         0jWp6r1/MAUK1u8+6g6S+PNKcxtxU/lgmp4+mO8hYc556gh5Kj6XaAw4b3cSn+tKjPYX
         MYTsXnH8fl1NXgwqKSwf0IHi7EvP06D4h5m26TEkL3wJTV+7Eg7lehQctJTBVPabwhPo
         O3hAyO0sTV3Vvvhiwz1C+j7G9NdTEwv+5vUoBEG0njg2FNdLJnIV55kP93+tOLyl91C2
         055Kq9AD5GNYbtije4ZNJu1ifeb0FQTBwAtWCSCVcRFnVrBFEBxU70maAGD/vVr+WWAC
         V5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744133806; x=1744738606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnCEslMdaS7r7+0ovfJH0qTPww6j0X72ov4ejqDicq4=;
        b=VGgp3evzSx+b72KYr/WYucsBZT7UxzEAQxdRKX2lu6fjikC3SpQ5S2PbLcc0Z11/H6
         wrXvEYHzK0N1hymmpmHpaXysysFVm0LCpvMrCPoJQVqAT9oblHlyp5lcQjRIfJgl0jMi
         t+Bv9lU1IVewUrxSImMjIjewKO3EaPyhMXxQbT3r/DIW+xv/P2riKIia3Ba1hR2pGepa
         FPEluq1Uasm2H5UZsTgRMqOmr4eYON/cgJZ1/Xu52n2h0V3KtYi92qAlr3it6zRyI9WQ
         TwsDh47d4K9V/AbA+plq43dWnQ2B3q+2ova9SitU5b6Afyybrh3KEOzYL/EIPEmaNynC
         47fA==
X-Forwarded-Encrypted: i=1; AJvYcCX+cG0P6JNAUGn4++aiz4E+cXsiffH4ICl/yPltF/3JWjAMDQJCeKj3/4QRuwyv15EHqmVgYQlACmy/nQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLcxedYO9TPDnH6rz6QGmrOKwdPuAQ+2/6qtHe8vmBD2bP/EAF
	phIt2fVJ7CrUdWoZKkyIMt9IM0SPd/ZsvllrVjskeNvZZRLDUQ7t+K1e+vTCd46Mp3DsZx3prmI
	6mqYgsVCFyic78meyIE2FadnweUrywTUnE2dgz7JG4RDJfuGv
X-Gm-Gg: ASbGnctq26R5/z2YxkjkFLjp6CjwDRbMQuRZuOHwbgBvpL67x2SoRVxrbxh7Q76RAsJ
	ugnDqEPAkIxFIKTQOUASFQ8lsiHvqvUVvQRHopIyu/+dqk0o0cLSNBveBmNFQ2Cx890CBnTcFkz
	QJWrH3YGjHhe2YgtsO7vx2KU+r
X-Google-Smtp-Source: AGHT+IEkTbXSqpjpy5g2WeVo6FwMfmliuiqhfm7k8iUa3JhTvmOLLVbJgYSK1ykiL/VVL+p8TiSkmAgbb7pJBrb9HcM=
X-Received: by 2002:a17:907:6e8e:b0:ac2:a4ec:46c2 with SMTP id
 a640c23a62f3a-aca9b739f8dmr6478466b.49.1744133806505; Tue, 08 Apr 2025
 10:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408122933.121056-1-frank.li@vivo.com> <CAL3q7H6ysGxpXs8P9iPY-Y1KNKPggGSFHR_tMv-34Q+Qf6PZTQ@mail.gmail.com>
In-Reply-To: <CAL3q7H6ysGxpXs8P9iPY-Y1KNKPggGSFHR_tMv-34Q+Qf6PZTQ@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 8 Apr 2025 19:36:35 +0200
X-Gm-Features: ATxdqUGLRfmMmZczeT5xlV_PYtK4N7BX4DdaIbSfYs5obzYvbCGTwKIxP6LDtmA
Message-ID: <CAPjX3Fem5E26+Fj537zcOXk9YZum2pDdcY9SAwCOr12wrGrroA@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: use BTRFS_PATH_AUTO_FREE in insert_balance_item()
To: Filipe Manana <fdmanana@kernel.org>
Cc: Yangtao Li <frank.li@vivo.com>, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Apr 2025 at 16:47, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Tue, Apr 8, 2025 at 1:18=E2=80=AFPM Yangtao Li <frank.li@vivo.com> wro=
te:
> >
> > All cleanup paths lead to btrfs_path_free so we can define path with th=
e
> > automatic free callback.
> >
> > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > ---
> >  fs/btrfs/volumes.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index c8c21c55be53..a962efaec4ea 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -3730,7 +3730,7 @@ static int insert_balance_item(struct btrfs_fs_in=
fo *fs_info,
> >         struct btrfs_trans_handle *trans;
> >         struct btrfs_balance_item *item;
> >         struct btrfs_disk_balance_args disk_bargs;
> > -       struct btrfs_path *path;
> > +       BTRFS_PATH_AUTO_FREE(path);
> >         struct extent_buffer *leaf;
> >         struct btrfs_key key;
> >         int ret, err;
> > @@ -3740,10 +3740,8 @@ static int insert_balance_item(struct btrfs_fs_i=
nfo *fs_info,
> >                 return -ENOMEM;
> >
> >         trans =3D btrfs_start_transaction(root, 0);
> > -       if (IS_ERR(trans)) {
> > -               btrfs_free_path(path);
> > +       if (IS_ERR(trans))
> >                 return PTR_ERR(trans);
> > -       }
> >
> >         key.objectid =3D BTRFS_BALANCE_OBJECTID;
> >         key.type =3D BTRFS_TEMPORARY_ITEM_KEY;
> > @@ -3767,7 +3765,6 @@ static int insert_balance_item(struct btrfs_fs_in=
fo *fs_info,
> >         btrfs_set_balance_sys(leaf, item, &disk_bargs);
> >         btrfs_set_balance_flags(leaf, item, bctl->flags);
> >  out:
> > -       btrfs_free_path(path);
> >         err =3D btrfs_commit_transaction(trans);
>
> This isn't a good idea at all.
> We're now committing a transaction while holding a write lock on some
> leaf of the tree root - this can result in a deadlock as the
> transaction commit needs to update the tree root (see
> update_cowonly_root()).

I do not follow. This actually looks good to me.
Is there really any functional change? What am I missing?

--nX

> Thanks.
>
>
> >         if (err && !ret)
> >                 ret =3D err;
> > --
> > 2.39.0
> >
> >
>


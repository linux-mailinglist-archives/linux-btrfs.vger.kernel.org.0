Return-Path: <linux-btrfs+bounces-13047-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E4EA8A6A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 20:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FE43B8B84
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 18:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51D3229B32;
	Tue, 15 Apr 2025 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYJKuI0l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D33224896
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744741350; cv=none; b=Ghom8784ufEtRLD/QqUTLRVCD8DfM4Ntmd+hDFR22o5CXCzLOXPA/Y+Jl3JNR9AIKl/yVtrn0Oestm8IUCzOrWBMi5gAhYuEZw5izfP0sdt9hy+9QrPM3QFgyVvPkz0BqDgNdYss0xfcx+zIC8Kg89rYnv5PVMrFftcwp+4oTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744741350; c=relaxed/simple;
	bh=hN7fnH7/sB6BTqgxrID3BnkvIKUhjqMrNstefwJ63H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnbzJ+8zLHAIdJISIURArGU9XK41mqvxXfS7wyieaxvvdxppKxR8xego8EN1zVinHkU8gpLI2sx0M9pwFAIh80TsBaaduCdesmMfpyHf1R5tDn2SrFPdI9NJGxMBtMgqVGfrtB8LyVn13MT5ETHN6Rq2v1IEY+qC2k0IgueJoAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYJKuI0l; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso1019685766b.3
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 11:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744741347; x=1745346147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLYY4wfD1GpZ0xsXR1vxvhH5zBpALgpAYqIHQB70Jqg=;
        b=SYJKuI0lijjyCaKnQejW0hoD2zYKdYyCHi/Iwckzu0YDmbDy3uCCVVgnwgjM9W7l5M
         JeJHaxjyHULJma5gElkfLJQ+AEgCIegpnRaISR2+ntb8sBmAxTRqy/Ehs7ouQrPrPcc/
         CcPm2Oy+kSz9Nzs2l7HKX0R5/cRT3+ooniCVCJSXSdIoQ2eM2bsj6dxF8TcrKBw0igQp
         BZy+nXdsfYrEBlFa2LMRNVs0HqDRecrdL6f6wNCIsS71bR+Tda/uUuJlBA6+WFrTGtUx
         7u72k3BztczjdcfUaZ9R+ieu9q8KpV9c/jx8ZaIPUb9MiN3Brlz0/14wjxPs2y1XWoJX
         6BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744741347; x=1745346147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLYY4wfD1GpZ0xsXR1vxvhH5zBpALgpAYqIHQB70Jqg=;
        b=BtBrWxh1qaCqjgYFWZA0/ggTu+RjRqDFaKDuMD294Xi0nCLbgXG0EILWW70cw0nEkV
         tX7HHF3QhkL5c+NelBszIrQCd0FFzMClri4ddlA8JwmYfd0Fy9XA6mdft4iJh3JPb5mR
         /J82gGnvefPNbed93Og62bzIyrZziy51dUxIMTOwUFB+iBzTxOzhi4yuvPwiu7p2w7JL
         WvqzVThaEfu8zunzRPG+OAunhm+T/9MO2dlOqEEG4dY+0h83pgN4BC4dQGgud5jjTUys
         7Ceae0IfhGtrjSpjYxgTMtqB+Bdt9bOdnkEKV9rCUpLZ7D6RQORQ6aZwCYZLMX3xxYiQ
         DW5A==
X-Forwarded-Encrypted: i=1; AJvYcCUiKw7oOOknTB6wQjq/LgHNW8x9utAh3085e/YNpuWmnil+UiErfxWQQQ9dtCDTUlW6SHA28D6RYd21Kg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCxQVC8e49eCx/wQMTDxPt7V09yLXADFDVwOEn25FuwEobx6zv
	N54NUERlnF2TmSl41zFtqJ0rojAQ0TXXns8D+MAljj4b4FPQdM/bgCyX7eQ9jHJjIBgqo1AVfB7
	m3NKfOkbj3Lo9mqKOXaPDvlyCSgk=
X-Gm-Gg: ASbGncuzudAfGdCUBNktyqfneVjvrgsc1jh6Kk4vFaFldg8276KSJXmYL+sFrcVEOtl
	mKstnvUtd/ruykD77GPXqVM+nnl9RyHOSL8ISGNtAVRl7Fwhy6P9PaPBYRWz3KmkcVbIXhadwZm
	7mwklnc4iP9Hfgt87b2iWhzt1ODYSEo5ye
X-Google-Smtp-Source: AGHT+IFAkxc47B72OZOAav8wVARVJOgMW7E7viVE808ZTes1yNvWeiT4TsXSDVzMys4t6MH34i5GH3Jer241CBnYDyY=
X-Received: by 2002:a17:906:c14a:b0:acb:34b2:cb5b with SMTP id
 a640c23a62f3a-acb38529cfamr4404866b.58.1744741346624; Tue, 15 Apr 2025
 11:22:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744344865.git.wqu@suse.com> <d66c922e591b3a57a230ca357b9085fe6ae53812.1744344865.git.wqu@suse.com>
 <Z_qycnlLXbCgd7uF@surfacebook.localdomain> <37e556c8-d7a4-4d65-81d7-44821d92603e@gmx.com>
 <CAHp75VdyLRQrnByZtPPL2sn9ucGWVkyZu-kBvZvvpr4P_tOTpw@mail.gmail.com> <20250415181841.GN16750@twin.jikos.cz>
In-Reply-To: <20250415181841.GN16750@twin.jikos.cz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 15 Apr 2025 21:21:50 +0300
X-Gm-Features: ATxdqUG6L0Tr5Ys6sbiR-SBSGsvoqcpL7i6sRB2O5YzS9N84X6exVgccLAGJF0Q
Message-ID: <CAHp75Vf3Z=qQPKkALhCbSSCd9VYiYYZ4xVJ9aT=sYKW7tbPd2A@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: make btrfs_truncate_block() zero folio range
 for certain subpage corner cases
To: dsterba@suse.cz
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 9:18=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
> On Mon, Apr 14, 2025 at 01:40:11PM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 14, 2025 at 4:20=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
> > > =E5=9C=A8 2025/4/13 04:05, Andy Shevchenko =E5=86=99=E9=81=93:
> > > > Fri, Apr 11, 2025 at 02:44:01PM +0930, Qu Wenruo kirjoitti:

[...]

> > > >> +    block_start =3D round_down(clamp_start, block_size);
> > > >> +    block_end =3D round_up(clamp_end + 1, block_size) - 1;
> > > >
> > > > LKP rightfully complains, I believe you want to use ALIGN*() macros=
 instead.
> > >
> > > Personally speaking I really want to explicitly show whether it's
> > > rounding up or down.
> > >
> > > And unfortunately the ALIGN() itself doesn't show that (meanwhile the
> > > ALIGN_DOWN() is pretty fine).
> > >
> > > Can I just do a forced conversion on the @blocksize to fix the warnin=
g?
> >
> > ALIGN*() are for pointers, the round_*() are for integers. So, please
> > use ALIGN*().
>
> clamp_start and blocksize are integers and there's a lot of use of ALIGN
> with integers too. There's no documentation saying it should be used for
> pointers, I can see PTR_ALIGN that does the explicit cast to unsigned
> logn and then passes it to ALIGN (as integer).

Yes, because the unsigned long is natural holder for the addresses and
due to some APIs use it instead of pointers (for whatever reasons) the
PTR_ALIGN() does that. But you see the difference? round_*() expect
_the same_ types of the arguments, while ALIGN*() do not. That is what
makes it so.

> Historically in the btrfs code the use of ALIGN and round_* is basically
> 50/50 so we don't have a consistent style, although we'd like to. As the
> round_up and round_down are clear I'd rather keep using them in new
> code.

And how do you suggest avoiding the warning, please?

--=20
With Best Regards,
Andy Shevchenko


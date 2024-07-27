Return-Path: <linux-btrfs+bounces-6794-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B777A93DCC8
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2024 02:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796F528341B
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2024 00:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC8B1878;
	Sat, 27 Jul 2024 00:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTIlSaYn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747FF110A
	for <linux-btrfs@vger.kernel.org>; Sat, 27 Jul 2024 00:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722041794; cv=none; b=nlAiv/R8zlq6mm5xoZ2vUi36Qnt9g2HRnQXQNsK7De3dM6PgyacZ8IT+PTJuxd9y+KtxFx9YNPMlg6W2XzPOnmouwJWmmn7tquQEOGt6pJyz8x4JwDLEX0d9KLXahawbsJifk0vuh/hz6JVo//OfnLdS2eeALDhoVPZ/ngA0w08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722041794; c=relaxed/simple;
	bh=jb24Hrcg5heWQVedlOrLq1dInG3MHb6TijVT3kP2AJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ia3D1lWCST/87Scsb/3nefMTANj7MScqWf5lGnB4aaBCfq5f2ruqnxcF/x1XV+BBcDbESyyYOObpJIObV83LFgsJEWxvophrv4DZqGq7HnNgGQUIECRvggMQngWZhzIPDn59mZU/dmQIWh0uoXp9Pl+b1eP5VVXOhSvflhTWzx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTIlSaYn; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so3682744a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 17:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722041791; x=1722646591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAsY37xIDM3uzxqVkJ54mAHquafx8T9VjiOoApbVHPE=;
        b=HTIlSaYnrdwEAy1Bq6K800u0qprNX1GeYE38QkbWzv5G5Yw6uDBwfoVBon9RKrpBEM
         8EKKiQE3N9J4bv5TySI16EgGMxfCC2hZIfcM4YMybYj5vqVOBTHq9E8GYCxIfA6Q6F/U
         qYJbRw4wdhi1v525g7gW94LI/hawwdHQZDsZGSBeFOGH4eSddQmaCWMX6rl7MIaHwXFi
         a3j5Mfde0EwwOm0EaayNBNVZKqXweZYJIwYOiQRW3Fb2UulXGvRT0RHq2szk5xvFXLtx
         umLKCG8ldcTIsI+54CctVPmhlXjH8EaEpCleFQ9TmIY2S72NOF5i6azxbtYbjSwtLbiB
         4E2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722041791; x=1722646591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAsY37xIDM3uzxqVkJ54mAHquafx8T9VjiOoApbVHPE=;
        b=beLCBEe/mngoKE9DtjsoNpQubjOOghhMXzKMmFHlx6z7SOUbn4yL8vCSkJQ3V4mmAR
         vAbtCm+yduyk80ENhDjTWVgHFFXcr5R+3JoHCDCjccS2lhJ/Zqve29uBIjaszpYVrBOb
         RdZ09vaftn5IPehKe907TEuWdOWX0ioW1zodpdTexoAsxrE4/SGAhrWPn8uhl8BfoC+O
         fdW56nrczxGE9tOn6TKmRkBkuZB/sf3i/gLXXXYzxn7//QA4eLN4QAfyA0oqO8QAOyM2
         +qcymW0bTVFWLxWQflpH1xZoQm7D9Kdpvqcj1IsITAAJV7/hJ1lpThR+dqQcap+c5153
         tviw==
X-Forwarded-Encrypted: i=1; AJvYcCVllG5cDHp7tinC4YksjuG8VoKh6gIWiuLe2L6h+ylCYN/MqB3zEXwdX1ROhg9R6zZLZK1z1q+OZIcGiQXpVA5obwvLH0xUTrF9XuU=
X-Gm-Message-State: AOJu0YxBADvCvcYToZsdkdEahLUqOh0/UfkkW6IuwEA8EWgU3XEd/P4N
	XmTFZzA+sdBkKWgO36l2q2W3AWVxK0upaAEEubD+02n71wsyQyDI/UBJimHbzU5s/mJe811nVql
	OZRjolX5BWRgwt+pPXfrHU+jHXbo=
X-Google-Smtp-Source: AGHT+IHJPUfyHbT6yebeXfh/NuZqqO1esN+xL0U6XNgH27EGprIz8wHkicsxcxeeidlitCLsS1i3ae94K6lWGeRfg04=
X-Received: by 2002:a50:d7d5:0:b0:572:9962:7f0 with SMTP id
 4fb4d7f45d1cf-5b0221f0b07mr489612a12.34.1722041790418; Fri, 26 Jul 2024
 17:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1722022376.git.josef@toxicpanda.com> <b98b2b61-8b56-4a92-8de8-a75a645c3dc3@gmx.com>
In-Reply-To: <b98b2b61-8b56-4a92-8de8-a75a645c3dc3@gmx.com>
From: Neal Gompa <ngompa13@gmail.com>
Date: Fri, 26 Jul 2024 20:55:54 -0400
Message-ID: <CAEg-Je99b+8MghQOJfJGO0eramosOi+8zoeqD6zfO-DK4TRq+g@mail.gmail.com>
Subject: Re: [PATCH 00/46] btrfs: convert most of the data path to use folios
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 6:58=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/7/27 05:05, Josef Bacik =E5=86=99=E9=81=93:
> > Hello,
> >
> > Willy indicated that he wants to get rid of page->index in the next mer=
ge
> > window, so I went to look at what that would entail for btrfs, and I go=
t a
> > little carried away.
> >
> > This patch series does in fact accomplish that, but it takes almost the=
 entirety
> > of the data write path and makes it work with only folios.  I was going=
 to
> > convert everything, but there's some weird gaps that need to be handled=
 in their
> > own chunk.
> >
> > 1. Scrub.  We're still passing around page pointers.  Not a huge deal, =
it was
> >     just another 10ish patches just for that work, so I decided against=
 it.
> >
> > 2. Buffered writes.  Again, I did most of this work and it wasn't bad, =
but then
> >     I realized that the free space cache uses some of this code, and I =
really
> >     don't want to convert that code, I want to delete it, so I'll do th=
at first.
>
> Totally agree, v1 is better to be deprecated.
>

Didn't we already deprecate it? We should just announce the removal schedul=
e.

> >
> > 3. Metadata.  Qu has been doing this consistently and I didn't want to =
get in
> >     the way of his work so I just left most of that.
>
> I guess there are still metadata codes switching between page and folios.
>
> I'm totally fine if you feel like to convert them to use folios.
> The only focus for me is to enable larger folios.
> So the conversion part is totally fine.
>
> >
> > This has run through the CI and didn't cause any issues.  I've made eve=
rything
> > as easy to review as possible and as small as possible.  My eyes starte=
d to
> > glaze over a little bit with the changelogs, so let me know if there's =
anything
> > you want changed.  Thanks,
>
> Just give us some time to review the whole series though, the pure
> amount of patches is already making my eyes glazing.
>

I'm impressed, but my eyes are glazing over reading it patch by patch
through emails, do you happen to have a branch on GitHub/GitLab/etc.
that I could look at it through instead?


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


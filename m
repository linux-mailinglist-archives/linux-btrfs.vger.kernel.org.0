Return-Path: <linux-btrfs+bounces-11060-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E818A1B8A1
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 16:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6C716ABB9
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2025 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5277D1531EF;
	Fri, 24 Jan 2025 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X1DYkPv4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508C512F399
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731636; cv=none; b=G+MpDk1UnjvU9eVnRCNkMFDcCb98t6sZFjq7j9BN7vB7rHuK97+V/pgql38GN/3GarOLCUcwetaIf38Qf5VHcyNlnZ54K5F+cc+gR5Qx73YH30sD+QRCIxCybqxKSvgDU37+9VBHjQfaIgmsh4dQ4tRLyGoYwpaUPAloGGHOr9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731636; c=relaxed/simple;
	bh=4JrijojVhLctKE3ampJI97KI16jZGkQwPoBu/3SZszw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pjgf0Zo8BI1COHRUX/kXhcNb5GwCqUEvf71a2WrQAIzLtqeMq8f3PCIHIbmtvhZFb4gSCWTOAlfYD+NAl4meNBmzZmc1m2vynqzvhcvFtd0m1zsQMitG6dvJfAIkM4U8f/9pz3ZPcVcQqiKrL0upClwXiVBTTp1XHYeFyHg7GSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X1DYkPv4; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso453265266b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2025 07:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737731632; x=1738336432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LieE3WDn9p2LzcTw9dOfUq/eJdzziO2uIes678NDYqo=;
        b=X1DYkPv4750R3BdWCcbfPigVekbQG1xpOPRERiGsd86BYvytMytlrPHFjoZSjzbsSp
         vHzAUh7vgrH7wkXOb5PmxBrx0Gs0BmZA+04V4Ra6kExYmIB6x2Z9R5GphK66/Qs1+glF
         BJNjpJgFDc8NrJBLA9JNCljR66prUbJuHv0wW98JLd4yLoentLZvQV+q8gtJvaRTzHHc
         rZHYMpRfPGWl/dP3iRki9bMLd1ko+cTw9cN3vjXCnqcy5vb92w5wnAyjfjUbUo3VxFJ6
         67hm1f88Yx3im57OZl2iLNXY/N2WHCmwhaTJKjAKTQrgGryfj37fz0ofbhHISoRGaey4
         uRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737731632; x=1738336432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LieE3WDn9p2LzcTw9dOfUq/eJdzziO2uIes678NDYqo=;
        b=M644A4r/1WvU/zm4ToKRpnsTn0vHjiCOoKpc6Jzc31auMTZg9KZ+AjnkBUBZywTZDz
         EvTjS1nmP+qwBQsiy3Sgm+0Czx28oQf8uakj5/J+6Mpr9gBm4v+ONtGWOAd0d9HEOgTV
         wk223vZD3vzDKrTIj0E5p/S70exxZykBZVHOY454SRNIKWNQIKo6jcNH73WwK7L6HknL
         CYtRsmB+L6bCTNUs2MqqLlinweeQiI4GoBfV84cl8DOC61FmGhCxtsv0SiONo/R77oa2
         iJBFJqdYv9l71tIhd5ohhYCkNRIy+SR2nTwClbsdzP3TCNiMp4K0fSDvkXijtsUj7rOm
         MnhA==
X-Forwarded-Encrypted: i=1; AJvYcCX0X7Go55BZFn51QdjIbYY0aQ+qdg7OcFDuB2/1jiN0J5jvHIXxU/mtotUyMFm45pxICfOlwwfJFECCWA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6IU4Le8lNNBH9xJJ12EyUb+3NEhwtKirBTTfTLuwH1+ve2OwV
	qY5YCKZfnDje2YuMXLb8A+xu9hAcnCNp0ymYR6/f5T7fED+1pua9fF0uaXGtS6dKVs/0TVFnySq
	99bfTmTLu6cYuwmaOJ9dEQ5sv8ZTnTqwPu04sPg==
X-Gm-Gg: ASbGncvqbaasoHu4QuaQs7bb5D56GSFYeop7CpnB83Q9dLNFM1Ry9GsukO9YrpLiRy0
	WulD6K+0Qll+eRBL7uv059DmM8MR/UQZ7lKXL8NXtKYTujEHn1Q1Toc41FQgL
X-Google-Smtp-Source: AGHT+IE0NHd1HwpfAtfMtJxk3o68ITvgXZMX879N8ntmdGZaPJ3p/0IHZH5xtlez6/3PBel4sNT549W/HOoMdbxnxTY=
X-Received: by 2002:a17:907:6ea6:b0:aab:740f:e467 with SMTP id
 a640c23a62f3a-ab38b0b941bmr3095149066b.8.1737731632495; Fri, 24 Jan 2025
 07:13:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122122459.1148668-1-maharmstone@fb.com> <CAL3q7H4tB3Cb-djYhh_bGB-BRJ7EahjUZec2qfbhH7QHP2iSUw@mail.gmail.com>
 <CAPjX3Fd+-510YrvpxR1GcK2F+XKDVknxes2sj=Eat1Un1zvEkQ@mail.gmail.com>
 <20250123215955.GN5777@twin.jikos.cz> <CAPjX3Ffb2sz9aiWoyx73Bp7cFSDu3+d5WM-9PWW9UBRaHp0yzg@mail.gmail.com>
 <CAL3q7H7+UZcXPefg-_8R=eZj42P2UkV2=yE1dSv8BQZagEOhyQ@mail.gmail.com>
In-Reply-To: <CAL3q7H7+UZcXPefg-_8R=eZj42P2UkV2=yE1dSv8BQZagEOhyQ@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 24 Jan 2025 16:13:40 +0100
X-Gm-Features: AWEUYZnfGNi1Rk3ndvYY-mdLVFGoS1TdxF_aBu-qUWnYP4-03hbexSQWtxZZadY
Message-ID: <CAPjX3FciZUpMvHe55=Gg2ZhacZ=BiySitNEc9P5vvz0-5nchBA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use atomic64_t for free_objectid
To: Filipe Manana <fdmanana@kernel.org>
Cc: dsterba@suse.cz, Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Jan 2025 at 13:26, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Fri, Jan 24, 2025 at 8:22=E2=80=AFAM Daniel Vacek <neelx@suse.com> wro=
te:
> >
> > On Thu, 23 Jan 2025 at 23:00, David Sterba <dsterba@suse.cz> wrote:
> > >
> > > On Wed, Jan 22, 2025 at 02:51:10PM +0100, Daniel Vacek wrote:
> > > > On Wed, 22 Jan 2025 at 13:40, Filipe Manana <fdmanana@kernel.org> w=
rote:
> > > > > > -       if (unlikely(root->free_objectid >=3D BTRFS_LAST_FREE_O=
BJECTID)) {
> > > > > > +       if (unlikely(val >=3D BTRFS_LAST_FREE_OBJECTID)) {
> > > > > >                 btrfs_warn(root->fs_info,
> > > > > >                            "the objectid of root %llu reaches i=
ts highest value",
> > > > > >                            btrfs_root_id(root));
> > > > > > -               ret =3D -ENOSPC;
> > > > > > -               goto out;
> > > > > > +               return -ENOSPC;
> > > > > >         }
> > > > > >
> > > > > > -       *objectid =3D root->free_objectid++;
> > > > > > -       ret =3D 0;
> > > > >
> > > > > So this gives different semantics now.
> > > > >
> > > > > Before we increment free_objectid only if it's less than
> > > > > BTRFS_LAST_FREE_OBJECTID, so once we reach that value we can't as=
sign
> > > > > more object IDs and must return -ENOSPC.
> > > > >
> > > > > But now we always increment and then do the check, so after some =
calls
> > > > > to btrfs_get_free_objectid() we wrap around the counter due to
> > > > > overflow and eventually allow reusing already assigned object IDs=
.
> > > > >
> > > > > I'm afraid the lock is still needed because of that. To make it m=
ore
> > > > > lightweight maybe switch the mutex to a spinlock.
> > > >
> > > > How about this?
> > > >
> > > > ```
> > > > retry:  val =3D atomic64_read(&root->free_objectid);
> > > >         ....;
> > > >         if (atomic64_cmpxchg(&root->free_objectid, val, val+1) !=3D=
 val)
> > > >                 goto retry;
> > > >         *objectid =3D val;
> > > >         return 0;
> > > > ```
> > >
> > > Doesn't this waste some ids when there are many concurrent requests?
> >
> > Quite the opposite, it's meant to prevent that. That's why I suggested
> > it as the original patch was wasting them and that's what Filipe
> > pointed out.
>
> Not wasting, but allowing the counter to wrap around and return
> already in use object IDs, far more serious than wasting.
> And besides that, the counter wrap-around would allow the return of
> invalid object IDs, in the range from 0 to BTRFS_FIRST_FREE_OBJECTID
> (256).

Oh, sorry about the confusion. Those three dots ... were meant as a
placeholder for the original -ENOSPC condition. Again, keeping the
original logic without any changes other than getting rid of the lock.

> >
> > It will only retry precisely when more concurrent requests race here.
> > And thanks to cmpxchg only one of them wins and increments. The others
> > retry in another iteration of the loop.
> >
> > I think this way no lock is needed and the previous behavior is preserv=
ed.
>
> That looks fine to me. But under heavy concurrency, there's the
> potential to loop too much, so I would at least add a cond_resched()
> call before doing the goto.

Possibly.

> With the mutex there's the advantage of not looping and wasting CPU if
> such high concurrency happens, tasks will be blocked and yield the cpu
> for other tasks.

Right. My understanding was that if this function is heavily
contended, the mutex would be a major bottleneck. Which you would be
likely aware of. Otherwise this is just a protection against rare
races. Anyways, `cond_resched()` should not hurt even if not strictly
needed. Better safe than sorry.

> Any improvements in performance could also be measured easily with
> fs_mark, which will heavily hit this code path.
> I would prefer if the patch adds fs_mark numbers (or from any other
> test) in the changelogs.
>
> Thanks.


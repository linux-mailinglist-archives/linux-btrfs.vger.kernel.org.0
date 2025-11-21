Return-Path: <linux-btrfs+bounces-19258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F816C7BA1E
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 21:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A17F4EC24E
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 20:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FA72FFFBF;
	Fri, 21 Nov 2025 20:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZJeahZBy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A62302CD5
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763756731; cv=none; b=MSmDa986m2omS5xbbjIhL6J0TS6/LVCHGtNruSbvTDDVeqggcaHGejKhdwx2F4HGz/q5UprFJS5GnN5GHBwmNtGsDT9fU5q2v/SxIG5bhw6CxStVOI5AaLi6rM/SGwrNWjNYjAdL6j48Xe59dFnqBMd/YCMn5zk3LmkYgfLR5fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763756731; c=relaxed/simple;
	bh=Jj/KA6tSgAOVZVTh+6ncGnip9BxoHKH1pDId5N32FLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AR3aXf/n50XXd7gbax7tF+UGA9SXAwGHGg+F7mjeP0PGyx0MrqKbf4VPtbS7ihRLKmPQ4j1vQwS143sYWRLFbEEMyUFYR0LOwzL+4uIN5keBkMoBKJ06gLT74YHpEJQbj4F3If+93bxe8/MlMl3f7nLEhms+W7RJKqggm2dY8gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZJeahZBy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b32a5494dso1399180f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 12:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763756727; x=1764361527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/kq0NmCTRi/mBVuu1XtmYgGnaF1bjRBMXhgI9Omki0=;
        b=ZJeahZByxVHYpPjKKPWNk5y+Rkf7fHT3ISKu10GluvxVaKNEIwcHP3Nw5+YCSS3eQP
         h2kcRKpdn+m89QSV0H3VEyNlDWy0PRO8Y38oV0WZsZpEm/PT7vgXL1SUZlDbooeFGKLM
         n/ZvQ0ccfitxHpBy3oXdQmPwV5/tf5M4Mw1H6xR2K+rnYPjiS1coHJymaBEMeQ/jEGsT
         LUhcpfgWEJSFH9Ey5VXXfotEmx0tY5wom3vix+53/Zn05xUStc9OYChtYxJAFqxqDjdV
         hmObdkqGIXAPM7lxyWaNjAFyl4BDpY32jh3TAkEwBfYgo8eDauwdOt5et4ZmJImqZAC3
         KxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763756727; x=1764361527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0/kq0NmCTRi/mBVuu1XtmYgGnaF1bjRBMXhgI9Omki0=;
        b=A3IJyxYJK6usHnC97gXRu15fFDtam3s156SW3yF570VqI4Sx277hdodYy04NEXw6YM
         KpN/yOs6EkmvOVM3BhwLqbU4/wQYjgaGn74csvQ8e6Iyd8WHW5DWfq+93psvJXb1qAQI
         RilcLMX9vxltz3/+H+8UeByLKtaVs0j+dE8rTARGyGvVVvu/B8BDeGWjEL/mMk+44zvh
         dFgK0X78QIkB4jyGMp7xvmvG+q7+8pZ/PULLlao7UlOKjy6xjIRarJnDEY65nAkW05l6
         FD+m0Cq1dbI1bRyAFL9kl9aiIfkmjvfsEO1keGYkCoo+n3rAp/M4YxCejbhY7eN/cBOL
         A9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8YW2sLhFKggRktYXRoQ3Q4yn9pY1pV0V0o937E/IehMIyDsNUwd+ajroDw7jNTlvB0f7yue1uw9LplQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcBb7OZJfVcTx6ouw1LlDQCM5xiGNogLK2VhDAEncEjX++KQDk
	GJndNaF9nbogs0BwM+Nqns+vbeUhj6wbDI/7N4XFIBolD0gdmGRaO4n4UZxUnnGELfZSFnoq0Vn
	mz9hrGlZRALRHDO8ezfXU1ovdwgFJi0p2ezhKiGg/jQ==
X-Gm-Gg: ASbGncsGBC6YHSxUE4/lprc1tXArfynm4eNSxUTckjKdhir79vDLnNwUJcukzeWiTZ5
	KT1gV8quXtcumQuLpTMK/R0vb5P8tXclZoQar6hwDdy8fVjlQZRRdrVug2pG8eKiDSMlCg+uIhu
	boxPPOnD9fPXOWxHrFd+H8lRnFyfaeSEy0kPFhl5y/gqasFhW7Zoo9Tb/wGhm67ibQjFiIGuqpN
	Fms0bTwOXq8ecx+LNwn16cnO73TDMe4KtyOn+r4w/caj8ggCDxibXwIkHvfqERycotZ9Lt//dKt
	iNvM5/8ZmLVsQu1mJ5GGbl0egeqYZk0VlvnO+ObtrHA9j81v+G53q8WTTqImDkacIEf9
X-Google-Smtp-Source: AGHT+IE42QWT9/Twiv8G/D2URSmuiHhgTH8jX+O3e3KPr/IQPtjGxUONqF40YUdmGZbM2lwS/AarV+GUysHxtr5e6J8=
X-Received: by 2002:a5d:480a:0:b0:42b:39d0:638d with SMTP id
 ffacd0b85a97d-42cc1d2e2c2mr3102057f8f.28.1763756727218; Fri, 21 Nov 2025
 12:25:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1763629982.git.wqu@suse.com> <5960f3429b90311423a57beff157494698ab1395.1763629982.git.wqu@suse.com>
 <CAL3q7H6pV-pb6T70aOATXc2VBvA0PJZJcoo+B-SzK48qxzyqbg@mail.gmail.com>
 <20251121153850.GP13846@twin.jikos.cz> <94236c69-10ed-494f-8895-39a8b4a443b6@gmx.com>
In-Reply-To: <94236c69-10ed-494f-8895-39a8b4a443b6@gmx.com>
From: Daniel Vacek <neelx@suse.com>
Date: Fri, 21 Nov 2025 21:25:15 +0100
X-Gm-Features: AWmQ_bk3ot55o1jltAucl8Ln09v8-v8lzncQmJaRqImdmdu6TOHXLnjCx8eiDYo
Message-ID: <CAPjX3FdrTZwzuObrERxP=pLmSMjYt6Drqfxn4S5ENmL_JQhkzw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] btrfs: make sure all ordered extents beyond EOF is
 properly truncated
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Nov 2025 at 20:28, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> =E5=9C=A8 2025/11/22 02:08, David Sterba =E5=86=99=E9=81=93:
> > On Fri, Nov 21, 2025 at 11:55:58AM +0000, Filipe Manana wrote:
> >>> +               /*
> >>> +                * We have just run delalloc before getting here, so =
there must
> >>> +                * be an ordered extent.
> >>> +                */
> >>> +               ASSERT(ordered !=3D NULL);
> >>> +               scoped_guard(spinlock, &inode->ordered_tree_lock) {
> >>> +                       set_bit(BTRFS_ORDERED_TRUNCATED, &ordered->fl=
ags);
> >>> +                       ordered->truncated_len =3D min(ordered->trunc=
ated_len,
> >>> +                                                    cur - ordered->f=
ile_offset);
> >>> +               }
> >>
> >> I thought we had not made a decision yet to not use this new fancy loc=
king yet.
> >> In this case where it's a very short critical section, it doesn't
> >> bring any advantage over using explicit spin_lock/unlock, and adds one
> >> extra level of indentation.
> >
> > Agreed, this looks like an anti-pattern of the scoped locking.
> >
>
> I think one is free to use whatever style as long as there is no mixed
> style in the same function.

I've got a hard objection here. If there is(?) any granularity using
guards vs. explicit locking then, IMO, it should be per given lock.

Ie, given `ordered_tree_lock` - either it should always use the RAII
style *OR* it should always use the explicit style. But it should
never mix one style in one function and the other style in another
function. That would only make it really messy looking for
interactions and race bugs / missing/misplaced locking - simply
general debugging.

> Sure, we're not yet settled on the style, but I can not see anything
> damaging readability either.
> That extra indent is clearly showing the critical section, and we have
> enough space in this particular case.
> It's more clear than spinlock() pair, and unlike guard() this won't
> cause problems for future modifications.
>
>
> And I didn't get the point of anti-pattern.
>
> You only want to use the guard for the longest critical section with
> multiple exit? And leave the simplest ones using the old style?
> That doesn't looks sane to me.
>
>
> I'm not saying we should change to the new RAII style immediately with a
> huge patch nor everyone should accept it immediately, but to gradually
> use the new style in new codes, with the usual proper review/testing
> procedures to keep the correctness.

I would understand if you introduced a _new_ lock and started using it
with the RAII style - setting the example. But if you're grabbing a
lock which is always acquired using the explicit style, just stick to
it and keep the style consistent throughout all the callsites, the
whole code base. This makes it _easier_ to crosscheck, IMO.

-just my 2c

> If one doesn't like the RAII, sure one doesn't need to use, and I'm not
> going to force anyone to use that style either.
>
> But if this step-by-step new-code-only approach is also rejected, it
> will going to be a closed-loop:
>
>    Not settled -> No new style code to get any feedback -> No motivation
>    to change
>
> Thanks,
> Qu
>


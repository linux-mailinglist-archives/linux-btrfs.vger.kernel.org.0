Return-Path: <linux-btrfs+bounces-14043-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35038AB8B0E
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 17:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EF03B12C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 May 2025 15:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D1221ABA2;
	Thu, 15 May 2025 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu6Vs8qD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886AC216E2A;
	Thu, 15 May 2025 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747323297; cv=none; b=WO3K7cyDk51HJtdxRcl4UX5xslSPNMxq04ehKPC9eSlPM1rZv+5WzPYags1ZrmAT8LCbqwZhi63PWO6n6zQjyyFr56TgNWpGwO5Dgg0XYozPbATNmRghZuUdqIe+//OQxbTdrn5FifMdlLy28Dw0DMJzYCs7nxXArNbQ2m63IaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747323297; c=relaxed/simple;
	bh=P6ScC2/7WF6jnaD9TTlKPlBPqJHqEYcoEx+YtmceAQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRn9KnN+aAdZf14+UQxhDsDcLs9p05ywqZvo0ZoCF+PW7lU7jB4m8JTLNb/MomjVZ0Gs+ICWMCE1X698LZelACD6UREstuzCmB9r9BRr2cVNSQkW21T5V+CGOJhjAzKJGbKWskCoeLxjq8olA0CpLm66dUU12ajETJVHXqUa8cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu6Vs8qD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D757EC4CEF6;
	Thu, 15 May 2025 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747323295;
	bh=P6ScC2/7WF6jnaD9TTlKPlBPqJHqEYcoEx+YtmceAQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bu6Vs8qDpy6kUm2wDLB5/DrUVT+WjDIisgTEWLYcQdzpZYWLMjosrXuuFaIF0jKgF
	 8WXbn5t07csgzAYH3CHXxiTkG8YXBwVoiUurukmSZuRB0cwjDvgwdag1j5OqgBc8Vx
	 YlzsiuxNxCsMx4QV05Eb1fQS/kD9I9eLyURKj6KGFCRaw82S+55gX80kcHhOPD1PkI
	 jJC5hVsBmLo25NEPoZWyOxnkH7E477TccpgFq0adEKZELwFmGM2cOfRNLOEcaKJ1oh
	 J7rk0iUDwGucEAnDv1kdq4A0KRvqO2CAXHm2kddA2TDsg+RApNsj5Z+qFYpjucaW4/
	 5WRejOnZkSOSA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5fbee322ddaso2310077a12.0;
        Thu, 15 May 2025 08:34:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBvcjertSzoaCMa0hNjduSwtK6hwHdlW/Vsmjzcyj89wTOCH+qnDedd4UndWHpTnURu+phk4S0Jk1+Ow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8T1KugDl7iiP8fyOATn+mXxgX7JNg/4Uui4Dh7COdgzbSL0Ts
	f13HValTBlnuihWxm6ayZ9/hFyoXzS6+vReLqAYEDBXCj8+xcKrmOFoycxdSPLgG41iM8uRaHYX
	lZ4discgxJONdb1R1SlKSgR+DolTSDeI=
X-Google-Smtp-Source: AGHT+IHjKVO9pzpVylIOdAbC581c17+QlkcHl2mg5s7plk/UBKpU7DRoXWbefaxJa6fdvmP+k76C9UKqlghtBg8kBGE=
X-Received: by 2002:a17:907:1b19:b0:aca:c38d:fef0 with SMTP id
 a640c23a62f3a-ad52d08120dmr23092366b.0.1747323294355; Thu, 15 May 2025
 08:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747309685.git.fdmanana@suse.com> <29bf7308d67eca82e564956f381dfe983696fbf9.1747309685.git.fdmanana@suse.com>
 <a312562d-f09e-41e5-87cf-fd55186d0871@wdc.com>
In-Reply-To: <a312562d-f09e-41e5-87cf-fd55186d0871@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 15 May 2025 16:34:17 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4RC9f+hp28vCe06xzETJUG4mrRckk8J8AO3EvH05NLJw@mail.gmail.com>
X-Gm-Features: AX0GCFu6Eb_Ljp6AgU4bjKKV4HToi1NH1zxPq5nTe3YVRYyn2nWp1VG_2R5Mbbs
Message-ID: <CAL3q7H4RC9f+hp28vCe06xzETJUG4mrRckk8J8AO3EvH05NLJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs/023: add to the quick group
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 4:22=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 15.05.25 13:51, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > This is a very quick test, so add it to the quick group.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   tests/btrfs/023 | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/btrfs/023 b/tests/btrfs/023
> > index 52fe0dfb..f09d11ed 100755
> > --- a/tests/btrfs/023
> > +++ b/tests/btrfs/023
> > @@ -9,7 +9,7 @@
> >   # The test aims to create the raid and verify that its created
> >   #
> >   . ./common/preamble
> > -_begin_fstest auto raid
> > +_begin_fstest auto quick raid
> >
> >   . ./common/filter
> >
>
> But why did you delete it from the raid group?

What do you mean?

line before:  _begin_fstest auto raid
line after:    _begin_fstest auto quick raid

It's still there.


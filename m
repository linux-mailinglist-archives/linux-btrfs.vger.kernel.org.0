Return-Path: <linux-btrfs+bounces-17007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFF8B8C00F
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Sep 2025 07:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A101C0322F
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Sep 2025 05:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01745239E8A;
	Sat, 20 Sep 2025 05:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvFQtz/e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7BD19A288
	for <linux-btrfs@vger.kernel.org>; Sat, 20 Sep 2025 05:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758347283; cv=none; b=ZSt4wEw1bwlusqqb9q/3EjyycFTWcuQ5Bdtv3cvekqAJepeXoSHxZo8ut/8tP9SXDyP4yjFhOgwFKKj4M7i7H6fPYqIwgJhK7Mwhs39s/o86gDSGoww8Fb+KNueB7x0flcwqaWJc/1TCG0cLe2O68YuL7sho+1n6ETB/C6AS6L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758347283; c=relaxed/simple;
	bh=o437aCkcf1xCxm+rv0mPwnGQtCoz+9QjMvmAbd5CG3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsIF7sXnC6FETL2g8z29+vnEEVF/6RwQxElBRjjlMuPIzewgWusbINMMQussUydzx2HP0rEw+cN9Ng9KZcXL7JWNmR37OYmq0DMKFlPz5azbToDQNVZFhIhho1ZCxzmT7hcJz33uIoySUfHWQPlP6ni0JzGoAnxv4s1kDLpnKS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvFQtz/e; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fa062a1abso4466308a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 22:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758347279; x=1758952079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyN9RcfnRhBee1hQgE+lsezNr/j9kdfLGgOBZcxycjE=;
        b=jvFQtz/eYM+NLGU5wKQz8AH8+J1N6i7yiK70ybgHeyj1Nqt3MpUnt0ptB0V5rqNNdx
         y9FCHiVC4NzIj4m/dqvUSDf5Ay7MA6YPbem+VbXf2aZ0NWpkzKgfjdRZZx0qc+lJjsEw
         KAvK+Pum6jWrqeQMgjhX+xnQz8SaKlMj3bdzaQ4YFGLqThdG8cQMiriMz9AX/WwdePxH
         VSIt6PWxgmFAwad3XxwSL0FMZB4cr8xZ/cdU8oBWLpOix39fJYgBXTFjH1sNNnLsowm1
         lNDp+A1teDRrWiE+un0tv30D/PKCul57wt6iJ+dl+oycDfEYGKivtfb8s8kpAJb7b/vY
         vowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758347279; x=1758952079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyN9RcfnRhBee1hQgE+lsezNr/j9kdfLGgOBZcxycjE=;
        b=Pgwf4FapljnzRavZKQA8qEHNqSU1FwZhZWZGHORlac8KXUAYA7ZPctgKstr8IsaGa4
         /N/E9AN++UkIlooycLp+0g4apS1AXrJux1cniV/SntIER+JkChOMRUAY8CmAeAiPOQE6
         jX4S6zQ+kw4W8udmxrtdtn7/3s+06FH3FQdcNaKvvNJTAGekGIYlgLv7/zBT5GEYcp/w
         eBimsGLp1inO2wbn64uvev0mTUZY+jFxwXu1oYRSgQ0BvI5SQw/5B4+c7mUvNWeYi7Zl
         lwYn4gyR6Xq6pYq6gGohugFMVK6JaQvqHzK3mvSGoTUAgWZob04jWydT0palZSZMcQ2w
         Uyow==
X-Forwarded-Encrypted: i=1; AJvYcCUC3Ul90HVpSaQkq7a44+VKktXM8N8XrulBXwSx8jLYK/C+YMkXujzxNKygEWyupQhjcrWNsxvplWyWFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqGrSgrB1HvIw64hsrhXa+4qEhPU4AYrLcF+eAS3KIIs5pyobF
	i5q73+6Kj19l/ODk7k0mi5dahlpVOVfARgZB+6zx1imVuEw6sm9a6utrwgREBuoD3j82ximJ+pr
	JQvFxjR1y8q+YKa4d1bMUja+u7Eb43fQ=
X-Gm-Gg: ASbGncs0tDH30UYBmjisOqh4nfscsSBvbICj99rymnZyMRduTE/821X1Roc62WCYaXJ
	YkLFsSY06a5q/gySS916gncdFrAYX/8Q9fLBVfKVVvTGfc/u4CRz3VrlIzjJZrXuO4/xP/ZHidh
	j6cNrvMBhqXWGB0RoQ9jeNdhSzvExLUYomstJ/9omHAbJSE+gQXqbuQ4++KmWX1uL7TC1ZftlD1
	k9jCa+0cEhRmO1G4kvN5EjPc7HyPX8zHb2OTBE=
X-Google-Smtp-Source: AGHT+IGXjKiqqwRe65Vudg38Ap/YqUkQCp5A7+RF7b7HLmhZNE/B/g21D2F70GxNir3tx2mYIaHz6z79YrnZKfqUJP8=
X-Received: by 2002:a05:6402:23d2:b0:62f:9cfb:7d76 with SMTP id
 4fb4d7f45d1cf-62fc0a8376bmr4633977a12.37.1758347278669; Fri, 19 Sep 2025
 22:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919154905.2592318-1-mjguzik@gmail.com> <73885a08-f255-4638-8a53-f136537f4b4c@gmail.com>
In-Reply-To: <73885a08-f255-4638-8a53-f136537f4b4c@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 20 Sep 2025 07:47:46 +0200
X-Gm-Features: AS18NWCzvbrmV0HH3sAfFvM4WSZtLcuzJvUuWZCgEFT-KVn1SkU22A6rQ1aMITw
Message-ID: <CAGudoHHnhej-jxkSBG5im+QXh5GZfp1KsO40EV=PPDxuGbco8Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] hide ->i_state behind accessors
To: Russell Haley <yumpusamongus@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 6:31=E2=80=AFAM Russell Haley <yumpusamongus@gmail.=
com> wrote:
>
> On 9/19/25 10:49 AM, Mateusz Guzik wrote:
> > This is generated against:
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=
=3Dvfs-6.18.inode.refcount.preliminaries
> >
> > First commit message quoted verbatim with rationable + API:
> >
> > [quote]
> > Open-coded accesses prevent asserting they are done correctly. One
> > obvious aspect is locking, but significantly more can checked. For
> > example it can be detected when the code is clearing flags which are
> > already missing, or is setting flags when it is illegal (e.g., I_FREEIN=
G
> > when ->i_count > 0).
> >
> > Given the late stage of the release cycle this patchset only aims to
> > hide access, it does not provide any of the checks.
> >
> > Consumers can be trivially converted. Suppose flags I_A and I_B are to
> > be handled, then:
> >
> > state =3D inode->i_state        =3D> state =3D inode_state_read(inode)
> > inode->i_state |=3D (I_A | I_B)         =3D> inode_state_add(inode, I_A=
 | I_B)
> > inode->i_state &=3D ~(I_A | I_B)        =3D> inode_state_del(inode, I_A=
 | I_B)
> > inode->i_state =3D I_A | I_B    =3D> inode_state_set(inode, I_A | I_B)
> > [/quote]
>
> Drive-by bikeshedding: s/set/replace/g
>
> "replace" removes ambiguity with the concept of setting a bit ( |=3D ). A=
n
> alternative would be "set_only".
>

I agree _set may be ambiguous here. I was considering something like
_assign or _set_value instead.

I'm not that fond of _replace but I'm not going to really going to
argue about any particular variant.

The good news is that whatever the naming, sed indeed can be used to
adjust the patchset. :)


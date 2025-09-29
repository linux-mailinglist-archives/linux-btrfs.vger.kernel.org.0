Return-Path: <linux-btrfs+bounces-17247-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68E3BA867F
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 10:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D63189BAA4
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 08:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD86223958A;
	Mon, 29 Sep 2025 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEIdp+58"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9641BD9C9
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 08:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759134778; cv=none; b=sQBA6nQ5/QobIFmnBMjPKK/KgENlLUUSd9temTp57plbHTKrXlSPx6iijCywp+3zhYJZFgMMNRjqLRdHOGztQnT6lCQeoI/x32DoTZrlDr/uAIgz0CvPx9MYKVsJB4DhzBG7sL0AzpcS8Nlw4N8Pl1QRoWu2j/ppFROUGYGtWGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759134778; c=relaxed/simple;
	bh=hOH6IakUvN4FIYY0SyJiPKza7NhHOVUZOE1csnBlTf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pH2L+ulcPONSt3Hy36C7/QHuWQIqyTfiJzhVxuW7VcMi1Js8ZtQelKLhs/5W7Ly7oek73BdyQPK1IS16naCQNEFlS5DrrnGIyV1MDKXpR5POcSbYVI9/uZIuCPDOHoP4BwSqS+1V51mkannKuxMsWBeqG0/TdREexxbvkJTkE+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEIdp+58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BD8C4CEF4
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 08:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759134777;
	bh=hOH6IakUvN4FIYY0SyJiPKza7NhHOVUZOE1csnBlTf8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VEIdp+58bSyfbax4nuVpKUdGso3FVwxVf5onQSndJ5aTGSWTuAngWAOmGLoMfOZcv
	 uIy8+75fTTLLyc8bmDASk1f/aGt9HpJyHKwjCT+ifh9QodzGSKXCfIL74iGAZP3q4F
	 T0bhle5vbUErRuLIoM2tdqAGgKIcA5mmgtO4uqasU3LsFZ/5bU+0lAI+gHsez+hplh
	 xFR4gG+yldqrKnU/eOqjW5OWjAyY/OIJ10WlTHlqQbqtBEErhJnot6+hvPdKTJ5VSB
	 +SLSXG2b9r6S8vMIOGWNIR5R0J4KMPD7ex9g7Wu6EMi3euTvAFCzjBJjlWLNWdMZHL
	 zIGcCaxWDXf0g==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so8536976a12.2
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 01:32:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKLt8xg8s99emDn+lqvqlZXXqF4F3nx9MJREU+C91em9UcZ3mfyRIA0ZCfOPtNszZYGjdcE+AtcTR9Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxTWf6Q77DfXy/o2rjkBBC+nCOwfyaAMwAMhmGw8f01cO4tFHn
	e5rLqmq1Yhm9SXo/CDtk/7TO0NiNmegT6FkmyihPh0QH6Fvh71DA0OY9UHcJwxGdEl+RKyt+ARs
	BA2WZthtUwXqMVaBZuXMhpNvyYtnKsLs=
X-Google-Smtp-Source: AGHT+IFqoK1UqyFf21wSFa4vmIK9j+6HWruXEb7yJJ6I/pr8sU8X/l8Z+B+xPasYSj3niDydsPlKkvWgrG9C00pVB10=
X-Received: by 2002:a17:907:1c10:b0:afe:cbee:7660 with SMTP id
 a640c23a62f3a-b34b84a4404mr1684091366b.21.1759134776323; Mon, 29 Sep 2025
 01:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eb37da47-2a32-4ff1-9c63-b97a69cc019d@suse.com> <2394265.ElGaqSPkdT@saltykitkat>
In-Reply-To: <2394265.ElGaqSPkdT@saltykitkat>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 29 Sep 2025 09:32:18 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5aYJPeUtBJtmsA_TSSqR8BTaHifbabBCjn_jWS5An8og@mail.gmail.com>
X-Gm-Features: AS18NWAS9xK2e_GQS1eAh_jzy2ogwIuAl80CMf4BmR7_AUA_Li6NZhZbUMy9UOs
Message-ID: <CAL3q7H5aYJPeUtBJtmsA_TSSqR8BTaHifbabBCjn_jWS5An8og@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reorganize error handling in btrfs_tree_mod_log_insert_key
To: Sun YangKai <sunk67188@gmail.com>
Cc: wqu@suse.com, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 9:29=E2=80=AFAM Sun YangKai <sunk67188@gmail.com> w=
rote:
>
> > > -   ret =3D tree_mod_log_insert(eb->fs_info, tm);
> > > -out_unlock:
> > > +   /* Deal with allocation error. */
> > > +   if (tm)
> > > +           ret =3D tree_mod_log_insert(eb->fs_info, tm);
> >
> > Sorry, I don't think this is really that better.
> >
> > In fact I'm wondering why we don't delay the allocation after
> > tree_mod_dont_log()?
>
> That's what I want to do at first. However, after looking further into
> tree_mod_dont_log(), I found that it trys to get the tree_mod_log_lock. I=
'm
> not sure if it's better or worse to do the allocation things after gettin=
g the
> lock.

You can't do a GFP_NOFS allocation after acquiring a rw lock... The
only allocation that can be done is a GFP_ATOMIC in that context, and
we want to avoid them.

>
> >
> > That would be way more straightforward.
> >
> > Thanks,
> > Qu
> >
> > > +   else
> > > +           ret =3D -ENOMEM;
> > > +
> > >
>
> Thanks,
> Sun YangKai
>
>
>
>
>


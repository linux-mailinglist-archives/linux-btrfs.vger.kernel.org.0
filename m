Return-Path: <linux-btrfs+bounces-1823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D757783DDF5
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 16:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F91D2883F0
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jan 2024 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DCB1D531;
	Fri, 26 Jan 2024 15:51:23 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CFD1D529
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284282; cv=none; b=D6ujnoYpPXZTSI+EsSQkvW1/yE8W6ETtP2c9oHD11VbhDHqZNR9INp7o4pNFjo+9FZJIbstQKT/hUJHn52UaBIG1nqnNMoqMjTtECm50DPvHEke8Ydwi5Cw4/MFYbGzt5vhGX5sZW0wMujgCUl14WkWIqFAXE6B2dsPhVvhADHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284282; c=relaxed/simple;
	bh=wPzeGGU2GU0UKESijenDPjx3iTRx+djuO1iznUcgM+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msffSw2lQkaIM3zqHM2UPb2VTO8vFY4UiLG5jTFMvQLt3G6+8mhWcY9nKMaqp0qp68bmMR3MVfqJTqEAVYzvq7amNQh0r22GSp0cXlvqoErP+/vQ/x3dvJesPWEWNEILrjCQAMzgAthU7aFUb3gOQxxaV287RnmGOhiUzKQayq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55c1ac8d2f2so396892a12.2
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 07:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706284278; x=1706889078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPzeGGU2GU0UKESijenDPjx3iTRx+djuO1iznUcgM+U=;
        b=t4+RFlo73lUX5HtMvCgCh1tIx4SQPZnRu0HZqqTP1JTvHeysE5eBpTCccoZmKD3mBu
         IgI3XV9afPfaqSgQthW4HHWzhS6i3a1c/gEjzRbP02c5EaxkNPyBPzyf1eeLt37QHBLg
         TO5pJdaR3wYTabiE+Db8UYSuzHRConEnkXHWvHp91/vNd5rG3Vv2Lrj89Fd0sJEfhzDl
         R14vMhKybsSYyS1vimDC4TB0sWSOjxNWLCLtYmgkMs59yxTFi9zHm+6hfW0bvkrEcVIS
         KRfsg21wmgC6heS1Ic6MsbOrSL+1gE7c188Un84WKSCOdTPr42Zd5Osnke9RW6KFiuRc
         sKWA==
X-Gm-Message-State: AOJu0Ywz80T6e6yjuRPfZrDeDoWiAy+TMY9qpQbTMja/j8y4khOp+jOi
	nlP2QLSo/mY4Fi1VctZsuDn6IVvJajO+/zT+mDihHNaf8Ept+0oW+SBKYxO3A8c=
X-Google-Smtp-Source: AGHT+IGsowx4YjxXRCaRcjkuMEaq/b6dnpJqJtC7CwdM4SqyznyKvYkcZu5c9lyX8WNcRwW2gU8t9Q==
X-Received: by 2002:a17:906:68d8:b0:a31:3a85:c5dc with SMTP id y24-20020a17090668d800b00a313a85c5dcmr1014709ejr.51.1706284278256;
        Fri, 26 Jan 2024 07:51:18 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id vx9-20020a170907a78900b00a3517093ae2sm228303ejc.101.2024.01.26.07.51.18
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 07:51:18 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55c2c90c67dso349916a12.1
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jan 2024 07:51:18 -0800 (PST)
X-Received: by 2002:aa7:d69a:0:b0:559:d04b:dad2 with SMTP id
 d26-20020aa7d69a000000b00559d04bdad2mr1059921edr.34.1706284277838; Fri, 26
 Jan 2024 07:51:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705711967.git.boris@bur.io> <eb79dcbe0cbfa7459b249f76818a5e5a08a42ea4.1705711967.git.boris@bur.io>
 <CAEg-Je_6RNUoFg-+btbBtrCZRE1uZ77g_1mdbCqtyGiSZ0vhMw@mail.gmail.com>
 <20240124163649.GL31555@twin.jikos.cz> <CAEg-Je8tyVCw5CnMiPfWC9td0FaOKTkRxVg4wQyk8TiLT2SPwA@mail.gmail.com>
 <20240125231242.GB1851005@zen.localdomain>
In-Reply-To: <20240125231242.GB1851005@zen.localdomain>
From: Neal Gompa <neal@gompa.dev>
Date: Fri, 26 Jan 2024 10:50:40 -0500
X-Gmail-Original-Message-ID: <CAEg-Je8h8mm1Fq6UmQqv3wHJcKXso_Y+tM7jGFToO7ix0jd99Q@mail.gmail.com>
Message-ID: <CAEg-Je8h8mm1Fq6UmQqv3wHJcKXso_Y+tM7jGFToO7ix0jd99Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: forbid creating subvol qgroups
To: Boris Burkov <boris@bur.io>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 6:11=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Wed, Jan 24, 2024 at 10:32:54PM -0500, Neal Gompa wrote:
> > On Wed, Jan 24, 2024 at 11:37=E2=80=AFAM David Sterba <dsterba@suse.cz>=
 wrote:
> > >
> > > On Wed, Jan 24, 2024 at 07:52:28AM -0500, Neal Gompa wrote:
> > > > On Fri, Jan 19, 2024 at 7:55=E2=80=AFPM Boris Burkov <boris@bur.io>=
 wrote:
> > > > >
> > > > > This leads to various races and it isn't helpful, because you can=
't
> > > > > specify a subvol id when creating a subvol, so you can't be sure =
it
> > > > > will be the right one. Any requirements on the automatic subvol c=
an
> > > > > be gratified by using a higher level qgroup and the inheritance
> > > > > parameters of subvol creation.
> > > >
> > > > Hold up, does this mean that qgroups can't be used *at all* on Fedo=
ra,
> > > > where we use subvolumes for both the root and user home directory
> > > > hierarchies?
> > >
> > > How do you imply that from the patch? This is about preventing creati=
ng
> > > the subvolume qgroups, i.e. with the level 0 and referred to as 0/123=
4
> > > where 1234 is a subvolume id. Such qgroups are supposed to be created
> > > only at the time the subvolume is created.
> > >
> >
> > Because I don't really understand what the description of this patch
> > implies. It is not clear to me what is actually changing here, that's
> > why I'm asking.
>
> Sorry for the unclear patch description!
>
> If Fedora is creating/snapshotting subvolumes but not explicitly
> creating subvolume qgroups (qg id of the form 0/X), that is fully
> supported and there should be no issue.
>
> More details, just to be extra thorough to make up for the bad initial
> description:
>
> In the qgroup hierarchy, level 0 is special, these are the so called
> "subvolume qgroups". The qgroup with id 0/X is the qgroup for the
> subvolume with id X. When that subvolume accumulates usage, it will
> always be reported into that qgroup (in a hard-coded fashion in
> fs/btrfs/qgroup.c).
>
> This patch prevents users from explicitly creating subvolume qgroups
> with BTRFS_IOC_QGROUP_CREATE.
>
> This does not affect the existing behavior that creating a subvolume
> also creates the corresponding subvolume qgroup.
>
> examples using the btrfs cli to illustrate:
> # create a subvol qgroup explicitly; EINVAL
> btrfs qgroup create 0/1234 <mnt>
> # create a higher level qgroup explicitly; OK
> btrfs qgroup create 1/1234 <mnt>
> # create sv with id X and qgroup with id 0/X
> btrfs subvol create <mnt>/<sv>
>
> The basic motivation for both of the patches in this series is that
> qgroup lifetime is more complicated in simple quotas and these are
> relatively unobtrusive changes that make it (a lot) easier to manage
> without affecting any known useful classic qgroups use case.
>

Okay, that makes sense! Can you put some of this into the initial
patch description then, assuming David hasn't already checked it in?



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!


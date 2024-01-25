Return-Path: <linux-btrfs+bounces-1792-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A8683C196
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 13:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E74C9B23794
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 12:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261753A27E;
	Thu, 25 Jan 2024 12:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6fXlnf7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B3435884;
	Thu, 25 Jan 2024 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184235; cv=none; b=lV4NXcLcr0SpO+C6jvxPflnTQjiOt/emR9moGRc4AbWXC0IZc5l2xjSg4Y4ch14FPcebJql7dQcHnpAnGJpYbg87XUBjvqezKqrx1OTYa2Ei1isG4s7O12HBHjZVREbeLWBGEcSDF0xiM58adoAYnmEnYGNF6ulkHnX/nnKR+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184235; c=relaxed/simple;
	bh=psYX4/5X6RLAL/KdYv+nxFIPS4yrn6TfAN4y/VwbXS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOCj2g07Oonor3REUYCOduU8sL2XsMlKh9pbzSpWXQuEFI2Wg9Z62mOQI/XEwOzxXZkonhG0DLx63eLvejWhPg6Mrg54aeXdH5b1eUm0eZg3cnQwFfO9hLcCR9OfmlZ1ViPfvgB/ggdBevdYLAGXDVl3Gckh1ZGwOeFyJ5/yDU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6fXlnf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2507FC433A6;
	Thu, 25 Jan 2024 12:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706184235;
	bh=psYX4/5X6RLAL/KdYv+nxFIPS4yrn6TfAN4y/VwbXS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p6fXlnf71OSAoH9Ns2mSi0lgCFb9ITd8/VUXEQGOcUjq6tq6jv6akaerChTbqPbDq
	 xEYRIDRMv7dIUqOM1NpPT0XUUxo4SPtXMgY8Gcdlqf9hIBXC/9F8JprQoM5rE9o5Uj
	 Z+7cQhZqhrun+5jm8DFaO83lm5RNcj145KIBb8ZpMZUoipi3Wly/jYTIWQMqbnd5S/
	 iv+4ipy6dCGu9Gs6bT4xU+2SPlbCSGzEkcCYMFKJpMKZOjSciIJX2Nsfvn4SZHkYWF
	 3TI8XZzfhr6xUMS05+Qn6BofE9MCIy/B75ET8sl1wSBjiqGd54XV8gh1F4ObhzLuig
	 NaHZipW2lgZwA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55783b7b47aso7408430a12.0;
        Thu, 25 Jan 2024 04:03:55 -0800 (PST)
X-Gm-Message-State: AOJu0Yx7h7EnBeSCuBVvnNkfKtDjTSQi27pBmbfLe4lo13mpHidNNX4u
	A2QndiOPlEtsE9NUqu6MBOcP3Zri+TmCILTG1Mub2mf4R5ygwx2egub4sx64q0kXtz6VWWqUFUW
	VLDAGZ7CbGJWdUB2JNqQ0ZaXeMsw=
X-Google-Smtp-Source: AGHT+IGlEjAMTwuIebq2Xeqa88h3TYikET/dihyPGBbOM2v7rnP5VM9ZPT7EIiUupPPVK6sFIFFNyJx4zgiJJjKCG3o=
X-Received: by 2002:a17:907:a70d:b0:a31:4f4c:9f20 with SMTP id
 vw13-20020a170907a70d00b00a314f4c9f20mr714296ejc.78.1706184233484; Thu, 25
 Jan 2024 04:03:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1ae6e30a71112e07c727f9e93ff32032051bbce7.1706176168.git.wqu@suse.com>
 <CAL3q7H77i3kv7C352k2R6nr-m-cgh_cdCCeTkXna+v1yjpMuoA@mail.gmail.com> <20240125113354.GA2629056@lxhi-087>
In-Reply-To: <20240125113354.GA2629056@lxhi-087>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 25 Jan 2024 12:03:16 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4H7Cw2YPrzFdZRWfBDU+ZmDEqiR4sCiP44=CNVx5fLJw@mail.gmail.com>
Message-ID: <CAL3q7H4H7Cw2YPrzFdZRWfBDU+ZmDEqiR4sCiP44=CNVx5fLJw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix infinite directory reads
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, Rob Landley <rob@landley.net>, stable@vger.kernel.org, 
	David Sterba <dsterba@suse.com>, Maksim.Paimushkin@se.bosch.com, Eugeniu.Rosca@bosch.com, 
	Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 11:34=E2=80=AFAM Eugeniu Rosca <erosca@de.adit-jv.c=
om> wrote:
>
> Hi Filipe and Qu,
>
> On Thu, Jan 25, 2024 at 10:02:01AM +0000, Filipe Manana wrote:
> > On Thu, Jan 25, 2024 at 9:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> > >
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > [ Upstream commit 9b378f6ad48cfa195ed868db9123c09ee7ec5ea2 ]
> > >
> > > The readdir implementation currently processes always up to the last =
index
> > > it finds. This however can result in an infinite loop if the director=
y has
>
> [..]
>
> > Thanks for the backport, and running the corresponding test case from
> > fstests to verify it's working.
> >
> > However when backporting a commit, one should also check if there are
> > fixes for that commit, as they
> > often introduce regressions or have some other bug -
>
> +1. Good to see this best practice applied here.
>
> > and that's the
> > case here. We also need to backport
> > the following 3 commits:
> >
> > https:// git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D357950361cbc6d54fb68ed878265c647384684ae
> > https:// git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3De60aa5da14d01fed8411202dbe4adf6c44bd2a57
> > https:// git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D8e7f82deb0c0386a03b62e30082574347f8b57d5
>
> Good catch. I get the same list thanks to the reference of the culprit:
>
> $ git log --oneline --grep 9b378f6ad linux/master
> 8e7f82deb0c038 btrfs: fix race between reading a directory and adding ent=
ries to it
> e60aa5da14d01f btrfs: refresh dir last index during a rewinddir(3) call
> 357950361cbc6d btrfs: set last dir index to the current last index when o=
pening dir
>
> > One regression, the one regarding rewinddir(3), even has a test case
> > in fstests too (generic/471) and would have been caught
> > when running the "dir" group tests in fstests:
> >
> > https:// git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=3Dfor=
-next&id=3D68b958f5dc4ab13cfd86f7fb82621f9f022b7626
> >
> > I'll work on making backports of those 3 other patches on top of your
> > backport, and then send all of them in a series,
> > including your patch, to make it easier to follow and apply all at once=
.
>
> Thanks for your support. Looking forward.

It's here now:
https://lore.kernel.org/linux-btrfs/cover.1706183427.git.fdmanana@suse.com/

>
> BR, Eugeniu


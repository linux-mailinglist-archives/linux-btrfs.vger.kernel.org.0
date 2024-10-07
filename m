Return-Path: <linux-btrfs+bounces-8587-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E25992ADE
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 13:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F75282D58
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 11:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6A11D2215;
	Mon,  7 Oct 2024 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2VcCdqy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84FB1BA285
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302309; cv=none; b=oQnkksdm4tvGJgyu04CwpoeOmPDIRdXm5hZhlu5o4k8WZyqoA6TE5qchT92kOgcESayTmEry8OVquye0126da4oZaJ/nrvzZV+MpUnNw6PnmyaxYYr44pHhFQy8rcB1QahlY/HMfvN2gw6rFUKPGqJFG7mCztG4UUN/G63QmbL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302309; c=relaxed/simple;
	bh=5c9Q9CU+Iaw7kaSh6WjDI9Baoyg5uEn4q8mMeJsuFfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4ca/RXLkWMDtoGnG26oyraGqYR9k0JWFEkOONotYvL7iWjzpQNTrNjXC/dH5ezjE/5agxBj+D91+nB1aVNdYdtkn8a+oueKA7LeZDLloi08hKnmCEzcFXKI/U007XaQG5oymdx9eoAC+fDNlmKQsNe60KbyuRLPYOE3pVb7bDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2VcCdqy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D201C4CEC6
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 11:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728302309;
	bh=5c9Q9CU+Iaw7kaSh6WjDI9Baoyg5uEn4q8mMeJsuFfI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=c2VcCdqyycST81A0z8mBReoGgzRGCDvMKnueop+VALb6fkELJgpeHLFASTNHy0J8W
	 XTJM799K997EimpvuAuC/1A97mOZtnKVrhXTKADqK5DoBIP0dqVK7bKR81t617f59T
	 RaKR4rlZBtuSYDHlfXUO6Lz2u4jYjkHGEohbREqRuOFbDCNLQJiRpstGnhimGheoit
	 HUqFU/Xy2GhtRoKO0XH0LZi+FS3Vvh1eX6BrPE3O6gj2X2MOvKGuqAn/A784o5VHJJ
	 /mNVwh0eMPaO8GGAPRB7H+2Wn2t/HCdatPJRF/nNclC7VsYzmyXt+RTsWA6JqiT9O5
	 OLOpm6P7VC4PQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso56533881fa.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2024 04:58:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YwBnXp0AGzXko1hzZptthZvrUSGhCTaGI25YT+6fWqFAKMV1lu2
	7QkUSbtEq3bM+HodHuF47fndhJsFeLR9KZ6fUM3ZAfritEdnk0raWYEsnEUBpxhidm9HJ2vd+ce
	z4ZjSVGVlwEzfjv2zCGufQW/nI+I=
X-Google-Smtp-Source: AGHT+IFqSW/SDMJ90oFihka6FtCsj5WM7wgeAbzvMAuwQ/hhrW1hOkgpm9dYQ112PCUEyWsDPNrq+8uTATn3V7MrNKs=
X-Received: by 2002:a05:651c:1545:b0:2f7:6653:8053 with SMTP id
 38308e7fff4ca-2faf3c2bf63mr60443601fa.18.1728302307857; Mon, 07 Oct 2024
 04:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f7ca5e8c-7771-430a-92d5-52a80184040e@dubielvitrum.pl>
 <CAL3q7H6Pm-5=qGZfAyvawVes-hgm61hKz4tsXWAw2vguGL0vWw@mail.gmail.com> <fda83046-98b0-408f-a1d5-0fc2f35c8dfb@dubielvitrum.pl>
In-Reply-To: <fda83046-98b0-408f-a1d5-0fc2f35c8dfb@dubielvitrum.pl>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 7 Oct 2024 12:57:50 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6QPE_Ksyt18zQkbWr1VpcFW0BA4jMWj_R6Q1c=gQN_3w@mail.gmail.com>
Message-ID: <CAL3q7H6QPE_Ksyt18zQkbWr1VpcFW0BA4jMWj_R6Q1c=gQN_3w@mail.gmail.com>
Subject: Re: failed to clone extents ... Invalid argument
To: Leszek Dubiel <leszek.dubiel@dubielvitrum.pl>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 12:50=E2=80=AFPM Leszek Dubiel
<leszek.dubiel@dubielvitrum.pl> wrote:
>
>
>
> Thank you for support.
>
>
> > This is probably the same issue recently reported here:
> >
> > https://lore.kernel.org/linux-btrfs/CAJhrHS2z+WViO2h=3DojYvBPDLsATwLbg+=
7JaNCyYomv0fUxEpQQ@mail.gmail.com/
> >
> > The corresponding fix was merged last friday to Linus' tree, and now
> > in 6.12-rc2 as of yesterday.
> > It will probably take some more days until it gets to the next 6.1
> > stable release.
> >
> > In the meanwhile you can either use a v6.1.106 kernel or older, if
> > it's an option for you, or apply the patch yourself to a kernel and
> > build it.
> > Or do a full send instead of an incremental send.
> >
>
>
> Do you think standard Debian kernel as below wolud be okey to solve the
> problem? Its "106-3"...

That probably matches upstream/vanilla v6.1.106, so it should be ok.
I'm not familiar with the Debian kernel trees, so I can't quickly verify.

>
>
> root@gamma:~/Admin# uname -a
>
> Linux gamma 6.1.0-25-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.106-3
> (2024-08-26) x86_64 GNU/Linux
>
>
>
>
>
>
>
>


Return-Path: <linux-btrfs+bounces-8580-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05F79929BE
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 12:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1C41F23B24
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2024 10:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2AC1D1E64;
	Mon,  7 Oct 2024 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8Ows08e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1D81D0F78
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298746; cv=none; b=agY9OSQtQ/wpC1n3rd+bG3FMNWCyL1CZKn9QryNFf5dG3wOh7lVc8KDaWTF7fazM/NCb6LpCRvSmycnhUDS+4wlHi49dFHvFu3qNzJJOK2s8FePKlibctbcWl8PiDb1/x9NocbK/2ta2fxCZMtAT8dvwynI1Ev3hHYSOLxwk0dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298746; c=relaxed/simple;
	bh=lFAMmr05LXOn3xLnoDl4MZ9BTyrGrl7Q3RC8HBvj1Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOffzXT/56rN0jJ0NxTZAHWnaD9VbEuS3IiS4Ape/I/G9KHfLiILm1Brb4RvWloJ0RNyf4H5K+j0wv/u31ob27RLmkpIC1wxKVry2q+LGHXd7zZ0AV6O2mjCRj5n+WmWMdsr+BKahG5BZ+VhC7WBTUAjnoGdtbKJa8ZHNHaykRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8Ows08e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE00C4CECC
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Oct 2024 10:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728298746;
	bh=lFAMmr05LXOn3xLnoDl4MZ9BTyrGrl7Q3RC8HBvj1Fo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=X8Ows08enP59/2wy01RWvLUaXwMG7lE3MeiWBameJbb8bFtua0g7mLXC97Jif1qrK
	 MXnBbWgoQ9mGbTMBlTn1wM1htFpMSexZVLzbg4JzYyDyMgH+jZqPg/gwQrBHXYjr4+
	 hS8nM3j3oxksp0LOA/WWiNS2eLWFUkN65yG6q9UiqFMkE2NXY2/DdZXYV+f3T8/664
	 3K58M4cZAAV9SC9MYOdx6BSt1yiEp/c+Mi3TDwb8Ofk+UZE33azj1qGMvGh9iBzJ2p
	 JtuMCu63dufNsksiGSSHL7dx9jCRENR+blCx9g+cv3e0FqS3scQY9oRCSZJF8Y1tqR
	 ZxihQFw1Izg7w==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d446adf6eso725456466b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Oct 2024 03:59:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YwQkWmkwqyEVYNlY+qyTNuInQqYoZ1HpsXmBmuahuQYV5+9UTrE
	UIx+F3OqBXw8yljvYpFdMG4r5gMUbF1wUbV4iIb84l7ylftHmsBVr+kvajRXlPz00+7ODP0e7rh
	I/Qnr0Be0hKocqMPc4WQqDsHsAjo=
X-Google-Smtp-Source: AGHT+IEvTA95virWpsD92KF0080Eu7yHHVaPvRQAVKaVixFwVyXWUmIZnOympoWDvuqDvN/RoGlhaTw4GKZtwqTeS1w=
X-Received: by 2002:a17:907:72ca:b0:a99:5ea9:ad50 with SMTP id
 a640c23a62f3a-a995ea9afcdmr122970066b.11.1728298745292; Mon, 07 Oct 2024
 03:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f7ca5e8c-7771-430a-92d5-52a80184040e@dubielvitrum.pl>
In-Reply-To: <f7ca5e8c-7771-430a-92d5-52a80184040e@dubielvitrum.pl>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 7 Oct 2024 11:58:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Pm-5=qGZfAyvawVes-hgm61hKz4tsXWAw2vguGL0vWw@mail.gmail.com>
Message-ID: <CAL3q7H6Pm-5=qGZfAyvawVes-hgm61hKz4tsXWAw2vguGL0vWw@mail.gmail.com>
Subject: Re: failed to clone extents ... Invalid argument
To: Leszek Dubiel <leszek.dubiel@dubielvitrum.pl>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 11:17=E2=80=AFAM Leszek Dubiel
<leszek.dubiel@dubielvitrum.pl> wrote:
>
>
>
> Backup system failed with error:
>
> ERROR: failed to clone extents to
> root/Metki/Repository/Dyspozycje/etykiety_transportowe_rozkroj.csv:
> Invalid argument
>
>
>
> I moved serwer to new one =E2=80=94 new hardware, new disk, restored serv=
er from
> backups.
>
>
>
> It was running few hours, and again fails with that errors.

This is probably the same issue recently reported here:

https://lore.kernel.org/linux-btrfs/CAJhrHS2z+WViO2h=3DojYvBPDLsATwLbg+7JaN=
CyYomv0fUxEpQQ@mail.gmail.com/

The corresponding fix was merged last friday to Linus' tree, and now
in 6.12-rc2 as of yesterday.
It will probably take some more days until it gets to the next 6.1
stable release.

In the meanwhile you can either use a v6.1.106 kernel or older, if
it's an option for you, or apply the patch yourself to a kernel and
build it.
Or do a full send instead of an incremental send.

Thanks.

>
>
>
>
> Source system:
>
> root@orion:~/Admin# uname -a; btrfs --version
> Linux orion 6.1.0-26-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.112-1
> (2024-09-30) x86_64 GNU/Linux
> btrfs-progs v6.6.3
>
>
>
>
> Target system:
>
>
> root@zefir:/mnt/root/orion_recznie# uname -a; btrfs --version
> Linux zefir 6.1.0-26-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.112-1
> (2024-09-30) x86_64 GNU/Linux
> btrfs-progs v6.6.3
>
>
>


Return-Path: <linux-btrfs+bounces-1793-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D0483C19B
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 13:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E5D1F25A0D
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 12:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EF13A27E;
	Thu, 25 Jan 2024 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Avi8iMJ5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E534439A;
	Thu, 25 Jan 2024 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184303; cv=none; b=PDqM4uWoiDYZgz/tY5/3fRLNYFocvsu+5ESWK32rBG8ERkJqsZOjAabFjGfLZxQGelXQ4PstVtechG2oZO108xQvvrfHN9f3FnYv+ytY9dX5ohFDchzuebtcTfLnxJSRdK9SRsGIPs15I00d7ut7UFtv4XgG2B0qr/Wg/wapQLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184303; c=relaxed/simple;
	bh=LC6oBHi1gCQWZEP6+MUf/eaL02r3GflX2lWuFjrYHWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6T5yFYzMAcP6L5q7nYkuCYQFHuePywZ5S4pc6y83VamXNd9VVk90Cl7QxfljvUOaW9SmEC0PPbsEFFhJm3waIa6QOpjdo4q6tOmpDFcKsuV/RMSUWcp7IlA/ETXE2PeY48XIwvDOO0FIwGJXODYcbDkgO/EkK6pKauMI96Jspc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Avi8iMJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15274C433A6;
	Thu, 25 Jan 2024 12:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706184303;
	bh=LC6oBHi1gCQWZEP6+MUf/eaL02r3GflX2lWuFjrYHWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Avi8iMJ57iM3qQ6ICUAUeuEyx9rLqOoqyFRz3DdM1ruhHMXo02FIfsRfWqt/BeO5Q
	 i+5G4qSJatjQ9WcuHFfTJLuvn85SYgY1jiSU++8tm3MVSP8RKXGGXjOaco7GOQbUxj
	 9xxgwuuueWlmN3mzBAsAYBCoYDguwZgwIKgyLfc/ZP9+m51XRb+/EfOij/2OLGbshR
	 Cap/Kb9TMQd9gdFJiPij8X6qMkqlB50FxSfpC1yoqdtMq//gosfowK/Ziuym1yo5dK
	 /H2AHItoNIMlXbcNRTYXkN82idBNzH6AMPWsw4O3XknpLxAhU73uhM/qreIdUjuBAZ
	 bw9fklA90ddyg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so6042598a12.1;
        Thu, 25 Jan 2024 04:05:03 -0800 (PST)
X-Gm-Message-State: AOJu0YztMEyqqFjPF3G2llj62Ds21FuTBsJYF3RftoaQeRt5o+fmk2KA
	cx+wqBuJsN0u2ppifIi6pWz5FTCeSoF/sMgr/47LbUIJSraYqIJHLMi3miJfTQAccCBzlQ6S5Zt
	yTEkFVIpsYfjFKN24u+YhDFq1+Fg=
X-Google-Smtp-Source: AGHT+IGZ0MEjsoJTIiA+e0vUod784xPlxW8+1QOmOs0/gN3N78dMifuQN68FyzjkZ+wbjBLOhQnUWOD7NFwl+/J7tF8=
X-Received: by 2002:a17:906:1156:b0:a30:9eba:4da7 with SMTP id
 i22-20020a170906115600b00a309eba4da7mr526244eja.23.1706184301432; Thu, 25 Jan
 2024 04:05:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c9ceb0e15d92d0634600603b38965d9b6d986b6d.1691923900.git.fdmanana@suse.com>
 <20240124225522.GA2614102@lxhi-087>
In-Reply-To: <20240124225522.GA2614102@lxhi-087>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 25 Jan 2024 12:04:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H43=iZxwcXw543TieNz_XadbNgC+_9+tUy6NnsA63TaYQ@mail.gmail.com>
Message-ID: <CAL3q7H43=iZxwcXw543TieNz_XadbNgC+_9+tUy6NnsA63TaYQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix infinite directory reads
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-btrfs@vger.kernel.org, 
	stable@vger.kernel.org, Maksim Paimushkin <Maksim.Paimushkin@se.bosch.com>, 
	Matthias Thomae <Matthias.Thomae@de.bosch.com>, Sebastian Unger <Sebastian.Unger@bosch.com>, 
	Dirk Behme <Dirk.Behme@de.bosch.com>, Eugeniu Rosca <Eugeniu.Rosca@bosch.com>, 
	Eugeniu Rosca <roscaeugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 10:55=E2=80=AFPM Eugeniu Rosca <erosca@de.adit-jv.c=
om> wrote:
>
> Hello Greg,
> Hello Filipe,
>
> On Sun, Aug 13, 2023 at 12:34:08PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > The readdir implementation currently processes always up to the last in=
dex
> > it finds. This however can result in an infinite loop if the directory =
has
> > a large number of entries such that they won't all fit in the given buf=
fer
> > passed to the readdir callback, that is, dir_emit() returns a non-zero
> > value. Because in that case readdir() will be called again and if in th=
e
> > meanwhile new directory entries were added and we still can't put all t=
he
> > remaining entries in the buffer, we keep repeating this over and over.
> >
> > The following C program and test script reproduce the problem:
>
> This crucial fix successfully landed into vanilla v6.5 [1] and stable
> v6.4.12 [2], but unfortunately not into the older stable trees.
>
> Consequently, the fix is missing on the popular Ubuntu versions like
> 20.04 (KNL v5.15.x) and 22.04.3 (KNL v6.2.x). For that reason, people
> still experience infinite loops when building Linux on those systems.
>
> To overcome the issue, people fall back to workarounds [3-4].
>
> The patch seems to apply cleanly to v6.2, but not to v5.15
> (v5.15 backport attempt failed miserably).
>
> Is there a chance for:
>  - Stable maintainers to accept the clean backport to v6.2?
>  - BTRFS experts to suggest a conflict resolution for v5.15?

As mentioned in another thread, here's the backport for 5.15 stable
along with other needed patches:

https://lore.kernel.org/linux-btrfs/cover.1706183427.git.fdmanana@suse.com/

>
> [1] https:// git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/c=
ommit/?id=3D9b378f6ad48cfa
> [2] https:// git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/com=
mit/?id=3D5441532ffc9c8c
> [3] https:// android-review.googlesource.com/c/kernel/build/+/2708835
> [4] https:// android-review.googlesource.com/c/kernel/build/+/2715296
>
> Best Regards
> Eugeniu


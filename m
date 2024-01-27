Return-Path: <linux-btrfs+bounces-1855-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9C883EF74
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 19:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD20928403A
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jan 2024 18:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2651C2E40B;
	Sat, 27 Jan 2024 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmpFFT0h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7362D60B;
	Sat, 27 Jan 2024 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706379568; cv=none; b=cJvo+7bWz6BxHmys/mrNJNvMU6/73dAHN/qX3P4xem+0otbBstVIvuRQaM9h2SdMwnvfSsb1aAqYe69wO021PIzspWi8MtMp+e/K8FmeKKsgL33/zETeCTROx/xSfJkOgVQc3LgJOOTtHZJU1tST9vG3LzL2iWno41SG12CTtig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706379568; c=relaxed/simple;
	bh=DKIOW5L12aovtX3SolJxO2bnwk4o54VSLredvKyOm0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HphNkktbw8d+GilfT1Zn9KUbXBGAUyZ5ofaxVguaeeGsipyioEjDeRivsbBgodYO9Q6kSpLkpEa1H/NYGtXyQO/txC8IbrMUgBFHj3KT1RJclZh5iaAabpIbm0gY+03IAWJwsurx8NncQWC4/aLQUcYfJoEO+quOYXpxx2iYVYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmpFFT0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AC6C433F1;
	Sat, 27 Jan 2024 18:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706379567;
	bh=DKIOW5L12aovtX3SolJxO2bnwk4o54VSLredvKyOm0w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NmpFFT0hc+fJJ2Af1RykMTP+vyOdre0XqIH3tdHdOaWTtHAu37GhwfI9/wV4YgNKC
	 mtQtCopObkJk11ZqQGrOZMMmsXHPT4hg83/6c0MDDNkdSgUslOlzJ2TtuNh4h+XS+r
	 wvxy8R1+LJFA2xQ8ofZmgjSxuRtv+cEJ4dk4As/3nIfcTJbBQdFlEqnIT0Vv6l82jt
	 waDJsf+cJDnBJaafEahERbFsUdW+dylXe0Ny4ehbmyvK+/4rLoqVoXXXTb8q4dl5Ha
	 /8Po8MmIBe6pTBaPm3cg8RzjbpcJ4v6JUeEFmvWF5db2bee4OwFjOtkmR6qoj1+nfI
	 JnGs+WWQzuGYw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28a6cef709so147634166b.1;
        Sat, 27 Jan 2024 10:19:27 -0800 (PST)
X-Gm-Message-State: AOJu0Yzc6S3fE5N7OmxxNX0VqtZJaoQU5SV7PLkBTBxIW36IRQFjW5YZ
	v+gIuPPf9X3vSpHlW/CeiBC+Hn8PjhukrpGvyV3QTrUO3V9fKlMvmrnDwLr6nYF02W0iQMijyK4
	1AYRHsIaNM6c8Dnc6ZfRcFo6Mgxo=
X-Google-Smtp-Source: AGHT+IHvaXjpVp8e3c6wWSKRu7HwHihUffsa4KCOetO2QBBDTmn+53Fgf4pTCYh1kAXaUmTGlGcaSBPhv4VtCCaBXbk=
X-Received: by 2002:a17:906:390d:b0:a27:be67:1743 with SMTP id
 f13-20020a170906390d00b00a27be671743mr1401686eje.40.1706379566232; Sat, 27
 Jan 2024 10:19:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706183427.git.fdmanana@suse.com> <2024012633-retold-avid-8113@gregkh>
 <CAL3q7H5ZXmN32iYx9LjMh7arcp+tyLdn1zDHZCT+8hGhMfAA9A@mail.gmail.com>
In-Reply-To: <CAL3q7H5ZXmN32iYx9LjMh7arcp+tyLdn1zDHZCT+8hGhMfAA9A@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 27 Jan 2024 18:18:49 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4xi0t1QZ1JTGxvMSPLFpK7YiN_=ui9XDe8qnqjpUhgnw@mail.gmail.com>
Message-ID: <CAL3q7H4xi0t1QZ1JTGxvMSPLFpK7YiN_=ui9XDe8qnqjpUhgnw@mail.gmail.com>
Subject: Re: [PATCH 0/4 for 5.15 stable] btrfs: some directory fixes for
 stable 5.15
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-btrfs@vger.kernel.org, erosca@de.adit-jv.com, 
	Maksim.Paimushkin@se.bosch.com, Matthias.Thomae@de.bosch.com, 
	Sebastian.Unger@bosch.com, Dirk.Behme@de.bosch.com, Eugeniu.Rosca@bosch.com, 
	wqu@suse.com, dsterba@suse.com, stable@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 5:58=E2=80=AFPM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Sat, Jan 27, 2024 at 1:15=E2=80=AFAM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Thu, Jan 25, 2024 at 11:59:34AM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Here follows the backport of some directory related fixes for the sta=
ble
> > > 5.15 tree. I tested these on top of 5.15.147.
> >
> > As these are not also in 6.1.y, we can't take these as you do not want
> > to upgrade and have regressions, right?
> >
> > If you can provide a working set of 6.1.y changes for these, we will be
> > glad to queue them all up, thanks.
>
> Ok, here the version for 6.1, tested against 6.1.75:
>
> https://lore.kernel.org/linux-btrfs/cover.1706377319.git.fdmanana@suse.co=
m/

Sorry, there's a change I forgot to git add and amend to patch 1/4, so
fixed in a v2 at:

https://lore.kernel.org/linux-btrfs/cover.1706379057.git.fdmanana@suse.com/

Thanks.
>
> Thanks.
>
> >
> > greg k-h


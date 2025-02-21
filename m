Return-Path: <linux-btrfs+bounces-11697-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA66A3F48B
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 13:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109064225EE
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Feb 2025 12:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C34720AF99;
	Fri, 21 Feb 2025 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjVyhDKo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3BD2066E3
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740141303; cv=none; b=AClFycGIpSzWIfqBjrpG/qblxhKt4pM82FjpNHgWk4zos79AIDB7Yx61hMoa6fQpWDqB3F9GxqsS19DGyKtSSgZuM90itn9Y22sPEncRuP8i9iUs8hxQ/MK/3QthK9nJ4kc6dAao4lPZIvoftuez8b9KveSnaxsf7d5qDHCfN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740141303; c=relaxed/simple;
	bh=S6JiEK1AkGOZU5mzaqpeUNNTkAwMy5OQushDfzxO78M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMrpoT8WsNffTiQpn/J3nlijF+4yRqD0v7i4fWaRX1PiRujmr7jjNKDCkOkmpJwGunf4pacM/RSuhE2ASRCwwaysetro1LGobjgRb3IyyYacYB+SL8H2OuqRR1ZOz3vKlAKbFR6IVMMFFl42Qy4xeRbUO3v+KKHJvRY+1LtuVEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjVyhDKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C78C4CED6
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740141302;
	bh=S6JiEK1AkGOZU5mzaqpeUNNTkAwMy5OQushDfzxO78M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VjVyhDKoIcoD4XY1o6rrGQ/Zsh2FxfNfdNkP2nakpbSaJZYFK8eApRNTyzPyDkFvO
	 WSl+tjuakr/OTI5fw3phxmuEQS7JkNVyo3O/UpF60oreb2LgVztSDaGPSCjVNaXWsu
	 G4Y0DFVEmbmU78AUKxzSGBB/onVYj1UYmma/EblBJgaZWMu2c/Xvm14gn/cOs9Iu2g
	 ayUiHlB+q6rQ99IpiqDXg6NkC8kjVrjMw0Hv36Jep18hOtGk0eiKIjG6lYSp31Ed6o
	 Q7+2fhH8GjFsPEndUEgfoYQFE1St/BYkDM1yzuHPaipUWj1pgbhjpFWtOI3X0+wupp
	 a+aMLjxle2bvg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-abba1b74586so311624666b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Feb 2025 04:35:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTllksdqrR7DEl+NDtpfpuUCyi9/kE2Zg9l1AzX/y+S1CdIOQvBdms5hVPgHROdgRscDYovvXv1ZYekA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKFWZxKK6e1P4B/s3UeCqHrHncSUU/MfaJGOxbcnYr32hdYWO3
	EdDcfiG02yeGDbEGXiHnjR2/SjimDpXdJccWT0dT5nPxylq0emuWBEbPq3z5bA12YZlfeW2tOzb
	PgBFieIQfDGMVztO4V8NplakCeUU=
X-Google-Smtp-Source: AGHT+IGgltIJ0xxEenI8MfB0KcX9fyjmYHMNhPDEmWu7oKmsCSmD54/sUG0EMuhn81cG0OMIB+YwhXXpLJyHXsbkUpY=
X-Received: by 2002:a17:907:9446:b0:ab7:ed56:a780 with SMTP id
 a640c23a62f3a-abc09a97abbmr311198766b.27.1740141301300; Fri, 21 Feb 2025
 04:35:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740043233.git.wqu@suse.com> <c9e1a407-6562-4564-a87a-e449d36b4b97@wdc.com>
In-Reply-To: <c9e1a407-6562-4564-a87a-e449d36b4b97@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 21 Feb 2025 12:34:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4j7u=EJBAirbO0pCyf0kTfbAVe-9EkqtDMfxPm0e0yjg@mail.gmail.com>
X-Gm-Features: AWEUYZnPhtuhzUh_kqFQB2GsNuPJNY6-hlWegsqAI1h3Kg9lY04HSd2HIJmL09c
Message-ID: <CAL3q7H4j7u=EJBAirbO0pCyf0kTfbAVe-9EkqtDMfxPm0e0yjg@mail.gmail.com>
Subject: Re: [PATCH 0/5] btrfs: prepare for larger folios support
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: WenRuo Qu <wqu@suse.com>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 11:23=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 20.02.25 10:26, Qu Wenruo wrote:
> > Qu Wenruo (5):
> >    btrfs: prepare subpage.c for larger folios support
> >    btrfs: remove the PAGE_SIZE usage inside inline extent reads
> >    btrfs: prepare btrfs_launcher_folio() for larger folios support
> >    btrfs: prepare extent_io.c for future larger folio support
> >    btrfs: prepare btrfs_page_mkwrite() for larger folios
> >
> >   fs/btrfs/extent_io.c | 50 +++++++++++++++++++++++++------------------=
-
> >   fs/btrfs/file.c      | 19 +++++++++--------
> >   fs/btrfs/inode.c     |  8 +++----
> >   fs/btrfs/subpage.c   | 36 +++++++++++++++----------------
> >   fs/btrfs/subpage.h   | 24 ++++++++-------------
> >   5 files changed, 69 insertions(+), 68 deletions(-)
> >
>
> Hi Qu,
> What am I doing wrong?
>
> Applying: btrfs: prepare subpage.c for larger folios support
> Applying: btrfs: remove the PAGE_SIZE usage inside inline extent reads
> In file included from ./include/linux/kernel.h:28,
>                   from ./include/linux/cpumask.h:11,
>                   from ./include/linux/smp.h:13,
>                   from ./include/linux/lockdep.h:14,
>                   from ./include/linux/spinlock.h:63,
>                   from ./include/linux/swait.h:7,
>                   from ./include/linux/completion.h:12,
>                   from ./include/linux/crypto.h:15,
>                   from ./include/crypto/hash.h:12,
>                   from fs/btrfs/inode.c:6:
> fs/btrfs/inode.c: In function =E2=80=98uncompress_inline=E2=80=99:
> fs/btrfs/inode.c:6807:41: error: =E2=80=98sectorsize=E2=80=99 undeclared =
(first use in
> this function); did you mean =E2=80=98sector_t=E2=80=99?

So this seems to depend on this patchset which introduces that variable:

https://lore.kernel.org/linux-btrfs/cover.1739608189.git.wqu@suse.com/

But that patset depends on other unmerged patches, so not easy to
follow and review.
I was just trying to review that patchset.

>   6807 |         max_size =3D min_t(unsigned long, sectorsize, max_size);
>        |                                         ^~~~~~~~~~
> ./include/linux/minmax.h:86:23: note: in definition of macro
> =E2=80=98__cmp_once_unique=E2=80=99
>     86 |         ({ type ux =3D (x); type uy =3D (y); __cmp(op, ux, uy); =
})
>        |                       ^
> ./include/linux/minmax.h:161:27: note: in expansion of macro =E2=80=98__c=
mp_once=E2=80=99
>    161 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
>        |                           ^~~~~~~~~~
> fs/btrfs/inode.c:6807:20: note: in expansion of macro =E2=80=98min_t=E2=
=80=99
>   6807 |         max_size =3D min_t(unsigned long, sectorsize, max_size);
>        |                    ^~~~~
> fs/btrfs/inode.c:6807:41: note: each undeclared identifier is reported
> only once for each function it appears in
>   6807 |         max_size =3D min_t(unsigned long, sectorsize, max_size);
>        |                                         ^~~~~~~~~~
> ./include/linux/minmax.h:86:23: note: in definition of macro
> =E2=80=98__cmp_once_unique=E2=80=99
>     86 |         ({ type ux =3D (x); type uy =3D (y); __cmp(op, ux, uy); =
})
>        |                       ^
> ./include/linux/minmax.h:161:27: note: in expansion of macro =E2=80=98__c=
mp_once=E2=80=99
>    161 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
>        |                           ^~~~~~~~~~
> fs/btrfs/inode.c:6807:20: note: in expansion of macro =E2=80=98min_t=E2=
=80=99
>   6807 |         max_size =3D min_t(unsigned long, sectorsize, max_size);
>        |                    ^~~~~
> fs/btrfs/inode.c: In function =E2=80=98read_inline_extent=E2=80=99:
> fs/btrfs/inode.c:6841:32: error: =E2=80=98sectorsize=E2=80=99 undeclared =
(first use in
> this function); did you mean =E2=80=98sector_t=E2=80=99?
>   6841 |         copy_size =3D min_t(u64, sectorsize,
>        |                                ^~~~~~~~~~
> ./include/linux/minmax.h:86:23: note: in definition of macro
> =E2=80=98__cmp_once_unique=E2=80=99
>     86 |         ({ type ux =3D (x); type uy =3D (y); __cmp(op, ux, uy); =
})
>        |                       ^
> ./include/linux/minmax.h:161:27: note: in expansion of macro =E2=80=98__c=
mp_once=E2=80=99
>    161 | #define min_t(type, x, y) __cmp_once(min, type, x, y)
>        |                           ^~~~~~~~~~
> fs/btrfs/inode.c:6841:21: note: in expansion of macro =E2=80=98min_t=E2=
=80=99
>   6841 |         copy_size =3D min_t(u64, sectorsize,
>        |                     ^~~~~
> make[4]: *** [scripts/Makefile.build:207: fs/btrfs/inode.o] Error 1
> make[3]: *** [scripts/Makefile.build:465: fs/btrfs] Error 2
> make[2]: *** [scripts/Makefile.build:465: fs] Error 2
> make[1]: *** [/home/johannes/src/linux/Makefile:1989: .] Error 2


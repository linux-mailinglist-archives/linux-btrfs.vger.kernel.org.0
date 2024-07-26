Return-Path: <linux-btrfs+bounces-6740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DA893D80F
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 20:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C0D285B7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 18:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB1B17CA06;
	Fri, 26 Jul 2024 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTyboDdz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E307217C211;
	Fri, 26 Jul 2024 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017594; cv=none; b=P6/QrBOsA/o6XvptC5o29jYQgMXGrRoMYRrbGn6SpbDhqXXWHjiZXGp7/WJzpQtpfR1EX0cq1GXueP57J2/WZVVxh0GfR0PRn+hBDWylrRytnKaLZBvmHOz0jc+7fszkG8hs3zfdTZTHYY6AYqI8PaIZxTpR/ca92Vp10t+gHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017594; c=relaxed/simple;
	bh=cp86BvEonxQez5lRvQ5RTlIM70/Q4yEyrZzDOo3TN4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGHZgrlFWmjqKRcS6hbEPLCtSnyDudC1iCBPLPhHUFJKa+JyQfiWLcf/ejlIbxNVnccOygGDDiaWMuQQxB0bl2qKIHijHzbBdohq9ZGXFCIRl6t9/O8fI/rUVlClt46eiBSfrlkLtYHoekPe5lyX6HtpwCJ6LJQOaUspbn1pKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTyboDdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66107C32782;
	Fri, 26 Jul 2024 18:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722017593;
	bh=cp86BvEonxQez5lRvQ5RTlIM70/Q4yEyrZzDOo3TN4Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NTyboDdzlE3JQKnS7V88M+ix00cp2zJT/7Z3pvUtsZx7xuahNf2MmRL1+0lesbSq2
	 BAxi46jHp/KIITpF6et8xFg3XL5wei9tSK2t1Vqkb/19CHFkCLEufDLSBYdpZg/9mU
	 muQ/JZe8fTgnr2Wi7hRKj6pD+bJOfnXAwH3AnL+J0LABnKuPTrfMwEHnw8saGrTOXI
	 M0DBgFGAACwu5NlM8eixJvQYAy6V2cV/TPWN0RLha+u4xjKg/9kqSbQfKD4fRk2e89
	 I8DW2PVi9TaHluuSL769iVgFXKG7YPRcvpGORgztiEYmZki1QthPRPNHqweVJ3jyfB
	 HQVSqZOhyktOQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so21439441fa.1;
        Fri, 26 Jul 2024 11:13:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmG7OTH6N7XKApJyOfb4VnKiRRdjth1e+gK6um/6lIQeX2q4QnQh9QxozHmTVsk9XMV+JfpSODewkOjhQeA/v63qEK3miK/4EpdBE=
X-Gm-Message-State: AOJu0YwpByJzYHOlMkkTHFXBekerWCBoEX+AfUnqi1LSYx+hqzeTGlnb
	/JcMxt67S0YvC5cwMvy/wtLH+TDCCTTJQGCW0Za6UwnGc0o/BgIsfk9rNNrV1UVPopKrgSRAhp8
	HdhTbY4hC4uEGCRNZUGO9xmEx7Wo=
X-Google-Smtp-Source: AGHT+IHgILvbPF9zzjUPSf3gj8vzsKaBHStep+/Ox4Ieh7ZbxpmxWk3hQVldiUNvbjHUAK9Puh1RXBVQt+/FeeqJWxw=
X-Received: by 2002:a05:6512:606:b0:52c:83c7:936a with SMTP id
 2adb3069b0e04-5309b2cac07mr478191e87.42.1722017591706; Fri, 26 Jul 2024
 11:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <652ec55049e94a59f66f4112fb8707629db3001d.1722008942.git.fdmanana@suse.com>
 <20240726175837.jtq4df4u7rol3qac@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240726175837.jtq4df4u7rol3qac@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 26 Jul 2024 19:12:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6RMX=1EPCESDc5-OXB=dF4W56u6PY72Dv2wN78TdGw3w@mail.gmail.com>
Message-ID: <CAL3q7H6RMX=1EPCESDc5-OXB=dF4W56u6PY72Dv2wN78TdGw3w@mail.gmail.com>
Subject: Re: [PATCH] generic: test page fault during direct IO write with O_APPEND
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 6:58=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Fri, Jul 26, 2024 at 04:55:46PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that doing a direct IO append write to a file when the input buffe=
r
> > was not yet faulted in, does not result in an incorrect file size.
> >
> > This exercises a bug on btrfs reported by users and which is fixed by
> > the following kernel patch:
> >
> >    "btrfs: fix corruption after buffer fault in during direct IO append=
 write"
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  .gitignore                 |   1 +
> >  src/Makefile               |   2 +-
> >  src/dio-append-buf-fault.c | 131 +++++++++++++++++++++++++++++++++++++
> >  tests/generic/362          |  28 ++++++++
> >  tests/generic/362.out      |   2 +
> >  5 files changed, 163 insertions(+), 1 deletion(-)
> >  create mode 100644 src/dio-append-buf-fault.c
> >  create mode 100755 tests/generic/362
> >  create mode 100644 tests/generic/362.out
> >
> > diff --git a/.gitignore b/.gitignore
> > index b5f15162..97c7e001 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -72,6 +72,7 @@ tags
> >  /src/deduperace
> >  /src/detached_mounts_propagation
> >  /src/devzero
> > +/src/dio-append-buf-fault
> >  /src/dio-buf-fault
> >  /src/dio-interleaved
> >  /src/dio-invalidate-cache
> > diff --git a/src/Makefile b/src/Makefile
> > index 99796137..559209be 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -20,7 +20,7 @@ TARGETS =3D dirstress fill fill2 getpagesize holes ls=
tat64 \
> >       t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> >       t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale=
 \
> >       t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewindd=
ir-test \
> > -     readdir-while-renames
> > +     readdir-while-renames dio-append-buf-fault
> >
> >  LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize preallo_rw_pattern=
_reader \
> >       preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > diff --git a/src/dio-append-buf-fault.c b/src/dio-append-buf-fault.c
> > new file mode 100644
> > index 00000000..f4be4845
> > --- /dev/null
> > +++ b/src/dio-append-buf-fault.c
> > @@ -0,0 +1,131 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2024 SUSE Linux Products GmbH.  All Rights Reserved.
> > + */
> > +
> > +/*
> > + * Test a direct IO write in append mode with a buffer that was not fa=
ulted in
> > + * (or just partially) before the write.
> > + */
> > +
> > +/* Get the O_DIRECT definition. */
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <stdint.h>
> > +#include <fcntl.h>
> > +#include <errno.h>
> > +#include <string.h>
> > +#include <sys/mman.h>
> > +#include <sys/stat.h>
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     struct stat stbuf;
> > +     int fd;
> > +     long pagesize;
> > +     void *buf;
> > +     ssize_t ret;
> > +
> > +     if (argc !=3D 2) {
> > +             fprintf(stderr, "Use: %s <file path>\n", argv[0]);
> > +             return 1;
> > +     }
> > +
> > +     /*
> > +      * First try an append write against an empty file of a buffer wi=
th a
> > +      * size matching the page size. The buffer is not faulted in befo=
re
> > +      * attempting the write.
> > +      */
> > +
> > +     fd =3D open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT | O_=
APPEND, 0666);
> > +     if (fd =3D=3D -1) {
> > +             perror("Failed to open/create file");
> > +             return 2;
> > +     }
> > +
> > +     pagesize =3D sysconf(_SC_PAGE_SIZE);
> > +     if (pagesize =3D=3D -1) {
> > +             perror("Failed to get page size");
> > +             return 3;
> > +     }
> > +
> > +     buf =3D mmap(NULL, pagesize, PROT_READ | PROT_WRITE,
> > +                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +     if (buf =3D=3D MAP_FAILED) {
> > +             perror("Failed to allocate first buffer");
> > +             return 4;
> > +     }
> > +
> > +     ret =3D write(fd, buf, pagesize);
> > +     if (ret < 0) {
> > +             perror("First write failed");
> > +             return 5;
> > +     }
> > +
> > +     ret =3D fstat(fd, &stbuf);
> > +     if (ret < 0) {
> > +             perror("First stat failed");
> > +             return 6;
> > +     }
> > +
> > +     if (stbuf.st_size !=3D pagesize) {
> > +             fprintf(stderr,
> > +                     "Wrong file size after first write, got %jd expec=
ted %ld\n",
> > +                     (intmax_t)stbuf.st_size, pagesize);
> > +             return 7;
> > +     }
> > +
> > +     munmap(buf, pagesize);
> > +     close(fd);
> > +
> > +     /*
> > +      * Now try an append write against an empty file of a buffer with=
 a
> > +      * size matching twice the page size. Only the first page of the =
buffer
> > +      * is faulted in before attempting the write, so that the second =
page
> > +      * should be faulted in during the write.
> > +      */
> > +     fd =3D open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT | O_=
APPEND, 0666);
> > +     if (fd =3D=3D -1) {
> > +             perror("Failed to open/create file");
> > +             return 8;
> > +     }
> > +
> > +     buf =3D mmap(NULL, pagesize * 2, PROT_READ | PROT_WRITE,
> > +                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +     if (buf =3D=3D MAP_FAILED) {
> > +             perror("Failed to allocate second buffer");
> > +             return 9;
> > +     }
> > +
> > +     /* Fault in first page of the buffer before the write. */
> > +     memset(buf, 0, 1);
> > +
> > +     ret =3D write(fd, buf, pagesize * 2);
> > +     if (ret < 0) {
> > +             perror("Second write failed");
>
> Hi Filipe,
>
> This patch looks good to me, just a question about this part. Is it possi=
ble
> to get (0 < ret < pagesize * 2) at here? Is so, should we report fail too=
?

It is possible, if a short write happens.
If that's the case, we detect the failure below when checking the file
size with the stat call.

>
> > +             return 10;
> > +     }
> > +
> > +     ret =3D fstat(fd, &stbuf);
> > +     if (ret < 0) {
> > +             perror("Second stat failed");
> > +             return 11;
> > +     }
> > +
> > +     if (stbuf.st_size !=3D pagesize * 2) {
> > +             fprintf(stderr,
> > +                     "Wrong file size after second write, got %jd expe=
cted %ld\n",
> > +                     (intmax_t)stbuf.st_size, pagesize * 2);
>
> Does this try to check the stbuf.st_size isn't equal to the write(2) retu=
rn
> value? Or checks stbuf.st_size !=3D pagesize * 2, when the return value i=
s
> good (equal to pagesize * 2) ?

It checks if it is equals to pagesize * 2, which is supposed to be the
final file size, meaning the write succeeded and wrote all the
expected data (pagesize * 2).

Thanks.


>
> Thanks,
> Zorro
>
> > +             return 12;
> > +     }
> > +
> > +     munmap(buf, pagesize * 2);
> > +     close(fd);
> > +
> > +     return 0;
> > +}
>
> [snip]
>


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CC57AA2CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 23:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjIUVea (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 17:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjIUVeF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 17:34:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5577446A2;
        Thu, 21 Sep 2023 10:22:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B33C193E8;
        Thu, 21 Sep 2023 09:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695287158;
        bh=7iGRP0Te8BQrkv3ugWrdAtmFNQSsZNKGzyjjRhXwezU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mL0hKpzBfI3KsVpVsxGoA/OJYJvVVRCQkAZUr8isRmK7JoSP7xNOjPLfUxsE4lUfP
         Xr235pvFbAJPmQT6/0ychSUN1tBSBgGspg181EJU5OFOm7AGK5cEg0ZEejtJBisJNa
         6zdFvuJBIQzCTm5RcVafAK3wh64oYG2RRmSPYTy9MHMXlh22wh+Pb11C7mIZrch1ba
         J4GCFBMnNriaGy5gqygb62fsTjkq7aEVUIuQa6yp9L+YEn+tNLoRsehFWT4ICinazV
         icsp/P4Ad0VKOytTiSnZ4qlTz3aTbIixcXs2IGCNQH2kuwv6jKVFA5jId21CLBHwgA
         2tHQfBiHpCHxw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-57b5ef5b947so74632eaf.0;
        Thu, 21 Sep 2023 02:05:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YyD1SoJSAI9M658PsvNTNRFTH6I9tTh1releY7B+rFOHKuDGZIS
        m5tguN6TvJkJzt1XYedu8j2LIGF38570/3UsYzQ=
X-Google-Smtp-Source: AGHT+IF2Z9XncYAzeLzIhqKMkgRCz+bYmKv6XecT1HHYJteTmKGnDYKP3vgaHgb59xNrftIE4LL8xpM2ZNI1Ca2ROTc=
X-Received: by 2002:a05:6870:c207:b0:1bf:4a66:d54f with SMTP id
 z7-20020a056870c20700b001bf4a66d54fmr4846399oae.56.1695287157411; Thu, 21 Sep
 2023 02:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <1888d81c5fad8204dd4948d36291d24f00354b22.1694705838.git.fdmanana@suse.com>
In-Reply-To: <1888d81c5fad8204dd4948d36291d24f00354b22.1694705838.git.fdmanana@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 21 Sep 2023 10:05:21 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4xMFiSCj=A4b-CEMo_-ce_O_ZRHN4FjcjKHS65cZHtVA@mail.gmail.com>
Message-ID: <CAL3q7H4xMFiSCj=A4b-CEMo_-ce_O_ZRHN4FjcjKHS65cZHtVA@mail.gmail.com>
Subject: Re: [PATCH] generic: test new directory entries are returned after
 rewinding directory
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 14, 2023 at 4:44=E2=80=AFPM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> Test that if names are added to a directory after an opendir(3) call and
> before a rewinddir(3) call, future readdir(3) calls will return the names=
.
> This is mandated by POSIX:
>
>   https://pubs.opengroup.org/onlinepubs/007904875/functions/rewinddir.htm=
l
>
> This exercises a regression in btrfs which is fixed by a kernel patch tha=
t
> has the following subject:
>
>   ""btrfs: refresh dir last index during a rewinddir(3) call""
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  .gitignore            |   1 +
>  src/Makefile          |   2 +-
>  src/rewinddir-test.c  | 159 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/471     |  39 +++++++++++
>  tests/generic/471.out |   2 +
>  5 files changed, 202 insertions(+), 1 deletion(-)
>  create mode 100644 src/rewinddir-test.c
>  create mode 100755 tests/generic/471
>  create mode 100644 tests/generic/471.out
>
> diff --git a/.gitignore b/.gitignore
> index 644290f0..4c32ac42 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -124,6 +124,7 @@ tags
>  /src/rename
>  /src/renameat2
>  /src/resvtest
> +/src/rewinddir-test
>  /src/runas
>  /src/seek_copy_test
>  /src/seek_sanity_test
> diff --git a/src/Makefile b/src/Makefile
> index aff871d0..2815f919 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -19,7 +19,7 @@ TARGETS =3D dirstress fill fill2 getpagesize holes lsta=
t64 \
>         t_ofd_locks t_mmap_collision mmap-write-concurrent \
>         t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>         t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale=
 \
> -       t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault
> +       t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewindd=
ir-test
>
>  LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_r=
eader \
>         preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/rewinddir-test.c b/src/rewinddir-test.c
> new file mode 100644
> index 00000000..9f7505a2
> --- /dev/null
> +++ b/src/rewinddir-test.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 SUSE Linux Products GmbH.  All Rights Reserved.
> + */
> +#include <dirent.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +
> +/*
> + * Number of files we add to the test directory after calling opendir(3)=
 and
> + * before calling rewinddir(3).
> + */
> +#define NUM_FILES 10000
> +
> +int main(int argc, char *argv[])
> +{
> +       int file_counters[NUM_FILES] =3D { 0 };
> +       int dot_count =3D 0;
> +       int dot_dot_count =3D 0;
> +       struct dirent *entry;
> +       DIR *dir =3D NULL;
> +       char *dir_path =3D NULL;
> +       char *file_path =3D NULL;
> +       int ret =3D 0;
> +       int i;
> +
> +       if (argc !=3D 2) {
> +               fprintf(stderr, "Usage:  %s <directory>\n", argv[0]);
> +               ret =3D 1;
> +               goto out;
> +       }
> +
> +       dir_path =3D malloc(strlen(argv[1]) + strlen("/testdir") + 1);
> +       if (!dir_path) {
> +               fprintf(stderr, "malloc failure\n");
> +               ret =3D ENOMEM;
> +               goto out;
> +       }
> +       i =3D strlen(argv[1]);
> +       memcpy(dir_path, argv[1], i);
> +       memcpy(dir_path + i, "/testdir", strlen("/testdir"));
> +       dir_path[i + strlen("/testdir")] =3D '\0';
> +
> +       /* More than enough to contain any full file path. */
> +       file_path =3D malloc(strlen(dir_path) + 12);
> +       if (!file_path) {
> +               fprintf(stderr, "malloc failure\n");
> +               ret =3D ENOMEM;
> +               goto out;
> +       }
> +
> +       ret =3D mkdir(dir_path, 0700);
> +       if (ret =3D=3D -1) {
> +               fprintf(stderr, "Failed to create test directory: %d\n", =
errno);
> +               ret =3D errno;
> +               goto out;
> +       }
> +
> +       /* Open the directory first. */
> +       dir =3D opendir(dir_path);
> +       if (dir =3D=3D NULL) {
> +               fprintf(stderr, "Failed to open directory: %d\n", errno);
> +               ret =3D errno;
> +               goto out;
> +       }
> +
> +       /*
> +        * Now create all files inside the directory.
> +        * File names go from 1 to NUM_FILES, 0 is unused as it's the ret=
urn
> +        * value for atoi(3) when an error happens.
> +        */
> +       for (i =3D 1; i <=3D NUM_FILES; i++) {
> +               FILE *f;
> +
> +               sprintf(file_path, "%s/%d", dir_path, i);
> +               f =3D fopen(file_path, "w");
> +               if (f =3D=3D NULL) {
> +                       fprintf(stderr, "Failed to create file number %d:=
 %d\n",
> +                               i, errno);
> +                       ret =3D errno;
> +                       goto out;
> +               }
> +               fclose(f);
> +       }
> +
> +       /*
> +        * Rewind the directory and read it.
> +        * POSIX requires that after a rewind, any new names added to the
> +        * directory after the openddir(3) call and before the rewinddir(=
3)
> +        * call, must be returned by readdir(3) calls
> +        */
> +       rewinddir(dir);
> +
> +       /*
> +        * readdir(3) returns NULL when it reaches the end of the directo=
ry or
> +        * when an error happens, so reset errno to 0 to distinguish betw=
een
> +        * both cases later.
> +        */
> +       errno =3D 0;
> +       while ((entry =3D readdir(dir)) !=3D NULL) {
> +               if (strcmp(entry->d_name, ".") =3D=3D 0) {
> +                       dot_count++;
> +                       continue;
> +               }
> +               if (strcmp(entry->d_name, "..") =3D=3D 0) {
> +                       dot_dot_count++;
> +                       continue;
> +               }
> +               i =3D atoi(entry->d_name);
> +               if (i =3D=3D 0) {
> +                       fprintf(stderr,
> +                               "Failed to parse name '%s' to integer: %d=
\n",
> +                               entry->d_name, errno);
> +                       ret =3D errno;
> +                       goto out;
> +               }
> +               /* File names go from 1 to NUM_FILES, so subtract 1. */
> +               file_counters[i - 1]++;
> +       }
> +
> +       if (errno) {
> +               fprintf(stderr, "Failed to read directory: %d\n", errno);
> +               ret =3D errno;
> +               goto out;
> +       }
> +
> +       /*
> +        * Now check that the readdir() calls return every single file na=
me
> +        * and without repeating any of them. If any name is missing or
> +        * repeated, don't exit immediatelly, so that we print a message =
for
> +        * all missing or repeated names.
> +        */
> +       for (i =3D 0; i < NUM_FILES; i++) {
> +               if (file_counters[i] !=3D 1) {
> +                       fprintf(stderr, "File name %d appeared %d times\n=
",
> +                               i + 1,  file_counters[i]);
> +                       ret =3D EINVAL;
> +               }
> +       }
> +       if (dot_count !=3D 1) {
> +               fprintf(stderr, "File name . appeared %d times\n", dot_co=
unt);
> +               ret =3D EINVAL;
> +       }
> +       if (dot_dot_count !=3D 1) {
> +               fprintf(stderr, "File name .. appeared %d times\n", dot_d=
ot_count);
> +               ret =3D EINVAL;
> +       }
> +out:
> +       free(dir_path);
> +       free(file_path);
> +       if (dir !=3D NULL)
> +               closedir(dir);
> +
> +       return ret;
> +}
> diff --git a/tests/generic/471 b/tests/generic/471
> new file mode 100755
> index 00000000..15dc89f3
> --- /dev/null
> +++ b/tests/generic/471
> @@ -0,0 +1,39 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 471
> +#
> +# Test that if names are added to a directory after an opendir(3) call a=
nd
> +# before a rewinddir(3) call, future readdir(3) calls will return the na=
mes.
> +# This is mandated by POSIX:
> +#
> +# https://pubs.opengroup.org/onlinepubs/007904875/functions/rewinddir.ht=
ml
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_cleanup()
> +{
> +       cd /
> +       rm -fr $tmp.*
> +       [ -n "$target_dir" ] && rm -fr $target_dir
> +}
> +
> +_supported_fs generic
> +_require_test
> +_require_test_program rewinddir-test
> +
> +[ $FSTYP =3D=3D "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: refresh dir last index during a rewinddir(3) call"

This landed yesterday in Linus' tree, the commit id is e60aa5da14d0.
If needed I'll send a v2 with just that change.

> +
> +target_dir=3D"$TEST_DIR/test-$seq"
> +rm -fr $target_dir
> +mkdir $target_dir
> +
> +$here/src/rewinddir-test $target_dir
> +
> +# success, all done
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/generic/471.out b/tests/generic/471.out
> new file mode 100644
> index 00000000..260f629e
> --- /dev/null
> +++ b/tests/generic/471.out
> @@ -0,0 +1,2 @@
> +QA output created by 471
> +Silence is golden
> --
> 2.40.1
>

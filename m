Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30016A0636
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Feb 2023 11:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjBWK2W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 05:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjBWK2P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 05:28:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3388F2ED52;
        Thu, 23 Feb 2023 02:28:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA544B81988;
        Thu, 23 Feb 2023 10:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFB9C4339E;
        Thu, 23 Feb 2023 10:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677148086;
        bh=KJqe5+g6aX0j4/Capg1ZtCaaodH5rF7vMg2dc4xuWQA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pEUBqs2bLpf+0q0hLYqq2Sx3bcgiq3zAnrowzrCaOqdF5LGaR8iRR5fL55v0tb0WW
         rBASU+MVwd+VtvsgUUKz2GbDmd+76U0bp7TemN9VY3VxHu+h/AJtc0/Q/r1IF4y3qt
         9xlcrWmRrostfyiqyEcOU7pIf8VCub2nf9sUUe9CcoTdAW/6GQBwkmS1/ekifQZj/Y
         93hUyTT90wXVIEGLzHqGNz/H4BmzAFKyW2OSEHkjaQ1aI99jOp576cWuh02XKYaqZZ
         rcuJ31NsEy5hU/6ESz7eYatbivx1bqTmBgjCCRer9900JfCk3esOBlMiQPl3Lzp0xM
         Z4dEIK+st/OxQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-172334d5c8aso11032329fac.8;
        Thu, 23 Feb 2023 02:28:06 -0800 (PST)
X-Gm-Message-State: AO0yUKVchCZTYG2L9SiyHIaxwo1Vo4uQGYsN5h8x5MziXlp4Zzw5E2af
        Jk3U8ZHyfTUTgMqIEaRyRrza0Looiin2HvslW7Y=
X-Google-Smtp-Source: AK7set9p8pVo9Nex3Gask8lFz0xfEKFKiDCIW1EYg8eIfXlSX/pbtL4F/EkYsgKV1tP/acrRtiKb72K+63LAJ7F3MXo=
X-Received: by 2002:a05:6870:d248:b0:16e:11dc:2513 with SMTP id
 h8-20020a056870d24800b0016e11dc2513mr2516793oac.98.1677148085573; Thu, 23 Feb
 2023 02:28:05 -0800 (PST)
MIME-Version: 1.0
References: <eba2cc47c628ce065e742decac7bc1ef5a91ae54.1677094146.git.boris@bur.io>
In-Reply-To: <eba2cc47c628ce065e742decac7bc1ef5a91ae54.1677094146.git.boris@bur.io>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 23 Feb 2023 10:27:29 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7_qTkgnbaP1PWDFKj+d6OrSYJKuTd9dcLV_6gRH_yMFA@mail.gmail.com>
Message-ID: <CAL3q7H7_qTkgnbaP1PWDFKj+d6OrSYJKuTd9dcLV_6gRH_yMFA@mail.gmail.com>
Subject: Re: [PATCH] generic: add test for direct io partial writes
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 22, 2023 at 7:40 PM Boris Burkov <boris@bur.io> wrote:
>
> btrfs recently had a bug where a direct io partial write resulted in a
> hole in the file. Add a new generic test which creates a 2MiB file,
> mmaps it, touches the first byte, then does an O_DIRECT write of the
> mmapped buffer into a new file. This should result in the mapped pages
> being a mix of in and out of page cache and thus a partial write, for
> filesystems using iomap and IOMAP_DIO_PARTIAL.
>
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/dio-buf-fault.c   | 83 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/708     | 48 +++++++++++++++++++++++++
>  tests/generic/708.out |  2 ++
>  5 files changed, 135 insertions(+), 1 deletion(-)
>  create mode 100644 src/dio-buf-fault.c
>  create mode 100755 tests/generic/708
>  create mode 100644 tests/generic/708.out
>
> diff --git a/.gitignore b/.gitignore
> index cfff8f85..644290f0 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -72,6 +72,7 @@ tags
>  /src/deduperace
>  /src/detached_mounts_propagation
>  /src/devzero
> +/src/dio-buf-fault
>  /src/dio-interleaved
>  /src/dio-invalidate-cache
>  /src/dirhash_collide
> diff --git a/src/Makefile b/src/Makefile
> index a574f7bd..24cd4747 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -19,7 +19,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>         t_ofd_locks t_mmap_collision mmap-write-concurrent \
>         t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>         t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> -       t_mmap_cow_memory_failure fake-dump-rootino
> +       t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault
>
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>         preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/dio-buf-fault.c b/src/dio-buf-fault.c
> new file mode 100644
> index 00000000..36ff6710
> --- /dev/null
> +++ b/src/dio-buf-fault.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> + */
> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE /* to get definition of O_DIRECT flag. */
> +#endif
> +
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <err.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +
> +/*
> + * mmap a source file, then do a direct write of that mmapped region to a
> + * destination file.
> + */
> +
> +int prep_mmap_buffer(char *src_filename, int *fd, void **addr)
> +{
> +       struct stat st;
> +       int ret;
> +
> +       *fd = open(src_filename, O_RDWR, 0666);
> +       if (*fd == -1)
> +               err(1, "failed to open %s", src_filename);
> +
> +       ret = fstat(*fd, &st);
> +       if (ret)
> +               err(1, "failed to stat %d", *fd);
> +
> +       *addr = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, *fd, 0);
> +       if (*addr == MAP_FAILED)
> +               err(1, "failed to mmap %d", *fd);
> +
> +       return st.st_size;
> +}
> +
> +int do_dio(char *dst_filename, void *buf, size_t sz)
> +{
> +       int fd;
> +       ssize_t ret;
> +
> +       fd = open(dst_filename, O_CREAT | O_TRUNC | O_WRONLY | O_DIRECT, 0666);
> +       if (fd == -1)
> +               err(1, "failed to open %s", dst_filename);
> +       while (sz) {
> +               ret = write(fd, buf, sz);
> +               if (ret < 0) {
> +                       if (errno == -EINTR)
> +                               continue;
> +                       else
> +                               err(1, "failed to write %lu bytes to %d", sz, fd);
> +               } else if (ret == 0) {
> +                       break;
> +               }
> +               buf += ret;
> +               sz -= ret;
> +       }
> +       return sz;
> +}
> +
> +int main(int argc, char *argv[]) {
> +       size_t sz;
> +       int fd;
> +       void *buf = NULL;
> +       char c;
> +
> +       if (argc != 3)
> +               errx(1, "no in and out file name arguments given");
> +       sz = prep_mmap_buffer(argv[1], &fd, &buf);

Minor thing: fd is not used by this function at all, can be moved to
prep_mmap_buffer().

> +
> +       /* touch the first page of the mapping to bring it into cache */
> +       c = ((char *)buf)[0];
> +       printf("%u\n", c);
> +
> +       do_dio(argv[2], buf, sz);
> +}
> diff --git a/tests/generic/708 b/tests/generic/708
> new file mode 100755
> index 00000000..ff2e162b
> --- /dev/null
> +++ b/tests/generic/708
> @@ -0,0 +1,48 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 708
> +#
> +# Test iomap direct_io partial writes.
> +#
> +# Create a reasonably large file, then run a program which mmaps it,
> +# touches the first page, then dio writes it to a second file. This
> +# can result in a page fault reading from the mmapped dio write buffer and
> +# thus the iompap direct_io partial write codepath.
> +#
> +. ./common/preamble
> +_begin_fstest quick auto
> +_fixed_by_kernel_commit XXXX 'btrfs: fix dio continue after short write due to buffer page fault'

It would be odd if the test fails on another fs and then fstests
suggests that commit as a potential fix.
So just do the following as we do in other generic tests:

[ $FSTYP == "btrfs" ] && \
     _fixed_by_kernel_commit ....

> +
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +       cd /
> +       rm -r -f $tmp.*
> +       rm -f $TEST_DIR/dio-buf-fault.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_require_test
> +_require_odirect
> +_require_test_program dio-buf-fault
> +src=$TEST_DIR/dio-buf-fault.src
> +dst=$TEST_DIR/dio-buf-fault.dst
> +
> +echo "Silence is golden"
> +
> +$XFS_IO_PROG -fc "pwrite -q 0 $((2 * 1024 * 1024))" $src

This is fine for the purpose of detecting that we don't leave a hole
in the file as long as xfs_io decides to write bytes with a value
different than 0x00.
It happens to be that the default is 0xcd - it's not obvious and maybe
one day it changes to 0x00 - making it explicit by passing -S 0xcd,
or whatever value, makes it more clear IMO.

> +sync

Is the sync needed? Why? There should be a comment if it's needed.

Otherwise it looks fine to me. Thanks.

> +$here/src/dio-buf-fault $src $dst >> $seqres.full || _fail "failed doing the dio copy"
> +diff $src $dst
> +
> +# success, all done
> +status=$?
> +exit
> diff --git a/tests/generic/708.out b/tests/generic/708.out
> new file mode 100644
> index 00000000..33c478ad
> --- /dev/null
> +++ b/tests/generic/708.out
> @@ -0,0 +1,2 @@
> +QA output created by 708
> +Silence is golden
> --
> 2.39.1
>

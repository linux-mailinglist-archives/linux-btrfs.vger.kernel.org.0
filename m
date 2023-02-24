Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A4D6A1901
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Feb 2023 10:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBXJpJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Feb 2023 04:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBXJpI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Feb 2023 04:45:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D419A5EEF8;
        Fri, 24 Feb 2023 01:45:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 658BC61879;
        Fri, 24 Feb 2023 09:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5D8C4339B;
        Fri, 24 Feb 2023 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677231901;
        bh=oAorq9A1twnx497fgEUIFPMUWwkEcrNjyBa1by8762M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AXP2k6m+QMqrW6LBHYANHqx2A/soAGDpMmlZpl3zbNlgQ5qrymU/ZCSjWF81d9Juq
         Sv9IOEvxhzf+M72vbJU2p8Z7GS1VymGDI5WnPLOzaNAvNUjSlqa9lILan/nZ6rHaqb
         mU+zZ4aEv3XOi5UFkigANgcHaVIspAVD+34sOHavSTByHI9D7dNsitN8VqucuG2qAM
         fj2Cyd5kMSE7k4MDCDRjXpHeknTLfY9SUNuTbWBDr7BUZ4Owx+NivauRJ4/OJYKlTn
         KdAOmBLv6lYvRXADP3XtHtJTNnHmeSZeO/j933y+PwDWULsXRhsLRbfQll9zF1261X
         nZbtHlaaQ3cNg==
Received: by mail-ot1-f53.google.com with SMTP id e18-20020a0568301e5200b00690e6abbf3fso3727880otj.13;
        Fri, 24 Feb 2023 01:45:01 -0800 (PST)
X-Gm-Message-State: AO0yUKXTD58LqkjgJK06MXeiuLD7xEpl3SJYql3JVPUAWYF9V3G9foQ0
        6TdGfe+yyVyp/8RbwR+xRKSlXEkquQi8a8HwIP0=
X-Google-Smtp-Source: AK7set9OlFZwXE8lhaj8yFtph9gp2Jc/wjlSblGw7AWf0dqS8jTSy+ggHWVlSjR2eNclWkui2/oJDfwiFJuOaHjP2nw=
X-Received: by 2002:a05:6830:4094:b0:690:e606:268 with SMTP id
 x20-20020a056830409400b00690e6060268mr1499512ott.7.1677231900877; Fri, 24 Feb
 2023 01:45:00 -0800 (PST)
MIME-Version: 1.0
References: <0ea9fe850ad355e20f668a5faff9f9181a3317c8.1677175084.git.boris@bur.io>
In-Reply-To: <0ea9fe850ad355e20f668a5faff9f9181a3317c8.1677175084.git.boris@bur.io>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 24 Feb 2023 09:44:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H59Q1YgBMxiTDcJB0wAbSkGhQ_WFhv1hsdkw2mOSK--Rw@mail.gmail.com>
Message-ID: <CAL3q7H59Q1YgBMxiTDcJB0wAbSkGhQ_WFhv1hsdkw2mOSK--Rw@mail.gmail.com>
Subject: Re: [PATCH v2] generic: add test for direct io partial writes
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 23, 2023 at 6:06 PM Boris Burkov <boris@bur.io> wrote:
>
> btrfs recently had a bug where a direct io partial write resulted in a
> hole in the file. Add a new generic test which creates a 2MiB file,
> mmaps it, touches the first byte, then does an O_DIRECT write of the
> mmapped buffer into a new file. This should result in the mapped pages
> being a mix of in and out of page cache and thus a partial write, for
> filesystems using iomap and IOMAP_DIO_PARTIAL.
>
> Signed-off-by: Boris Burkov <boris@bur.io>

Looks good now, thanks.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
> Changelog:
> v2:
> - hide fd in prep_mmap_buffer, we weren't closing it in main
> - get rid of unneeded filters/cleanup in test script
> - make pwrite pattern explicit
> - send random mmapped char to /dev/null
> - gate _fixed_by_kernel_commit by FSTYP
> - remove extra sync after writing file
> - use $seq in test filenames
>
>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/dio-buf-fault.c   | 83 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/708     | 37 +++++++++++++++++++
>  tests/generic/708.out |  2 ++
>  5 files changed, 124 insertions(+), 1 deletion(-)
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
> index 00000000..911c3e1f
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
> +int prep_mmap_buffer(char *src_filename, void **addr)
> +{
> +       struct stat st;
> +       int fd;
> +       int ret;
> +
> +       fd = open(src_filename, O_RDWR, 0666);
> +       if (fd == -1)
> +               err(1, "failed to open %s", src_filename);
> +
> +       ret = fstat(fd, &st);
> +       if (ret)
> +               err(1, "failed to stat %d", fd);
> +
> +       *addr = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +       if (*addr == MAP_FAILED)
> +               err(1, "failed to mmap %d", fd);
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
> +       void *buf = NULL;
> +       char c;
> +
> +       if (argc != 3)
> +               errx(1, "no in and out file name arguments given");
> +       sz = prep_mmap_buffer(argv[1], &buf);
> +
> +       /* touch the first page of the mapping to bring it into cache */
> +       c = ((char *)buf)[0];
> +       printf("%u\n", c);
> +
> +       do_dio(argv[2], buf, sz);
> +}
> diff --git a/tests/generic/708 b/tests/generic/708
> new file mode 100755
> index 00000000..1f0843c7
> --- /dev/null
> +++ b/tests/generic/708
> @@ -0,0 +1,37 @@
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
> +# thus the iomap direct_io partial write codepath.
> +#
> +. ./common/preamble
> +_begin_fstest quick auto
> +[ $FSTYP == "btrfs" ] && \
> +       _fixed_by_kernel_commit XXXX 'btrfs: fix dio continue after short write due to buffer page fault'
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_odirect
> +_require_test_program dio-buf-fault
> +src=$TEST_DIR/dio-buf-fault-$seq.src
> +dst=$TEST_DIR/dio-buf-fault-$seq.dst
> +
> +rm -rf "$src" "$dst"
> +
> +echo "Silence is golden"
> +
> +$XFS_IO_PROG -fc "pwrite -q -S 0xcd 0 $((2 * 1024 * 1024))" $src
> +$here/src/dio-buf-fault $src $dst > /dev/null || _fail "failed doing the dio copy"
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

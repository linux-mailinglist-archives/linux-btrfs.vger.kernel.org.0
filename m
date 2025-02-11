Return-Path: <linux-btrfs+bounces-11373-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606ADA309ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 12:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51C617A391F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Feb 2025 11:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF061F754A;
	Tue, 11 Feb 2025 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sl3mQqFI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F91B2182
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739273428; cv=none; b=a5/eDM2PGcLhGVhsbyBibIc4OF+7wEG2nF0s7KXYaZePjAl1dtEqsF6zjkbH12INk787IZx5kDWhIv61EkRwDdRE/m7ZrNwc3A3FNdv8U9hpESzp3mg3LHyC3hIM1Kz0rjHjIHzidLzUCR8lVzVP9d5RmjhmNh0h/5EenfwGYZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739273428; c=relaxed/simple;
	bh=5k7M9auZ6qgNw3/emQbthSwY6Z4RvmuIHhVZT6b3cD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwhT5/aHJbXxjOzgsL66hvdhyDO70IavpzbtLBsxvSuG2SVshNfbtuf0dgWpvMYZIN6+LxoE6qEXeKAdTq8T8Wu23w8GbS/qykTeFhwfJA8NcbKO1ppb6BmamE0pGVhoj+Y0+GpPRD1l7xr1wJrC0V9h1B0qMPYfPqTdiVdcoRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sl3mQqFI; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de849a0b6cso3644822a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 03:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739273423; x=1739878223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4BBRdIuN+HiUAMRffYXV+vGu49/W4Gv2G/DcKsFcCpE=;
        b=Sl3mQqFIyIiBdw07f6AsCwpQF86ODepBbYZ92jaqIl7ciCBqcQ02/znO4gQPQMZeZm
         aZS3Q6/qUYfsCbYUwv/WIVB0zsOxESu/4TSuZgXeO1PWh2tHn2QBFemsHhkaLYAKTEiR
         GgHLSQ+iySc4WocYem/80/221SPNF78xx9YdDxf9X3RuoLGoVNHq8KOnbHyNJl/Y5Wo3
         DMFswiaqECnbroNY6e8OCOEWriQNMsayNLdA/RKkku/yduhuCGLWxeZ4nnCFCb2i6upA
         arIG7jx1AQEN6H1suUkhCRK0v6WSl5hu0hBs9hybTdyQkENIXOlVMLltNJ2mizoIi2sS
         Oyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739273423; x=1739878223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4BBRdIuN+HiUAMRffYXV+vGu49/W4Gv2G/DcKsFcCpE=;
        b=SmVdcVnaTrmpsaObHRlnKF6E+n/Gb+RonONL7bMVXFChSrB9cqc4O5nvyEgnKAY4LJ
         62Sd4t9Jea+CPFtCdxrWJQdAwDOSeNnGHZhOtyoVW3gb4lMWIzwZlF9nCJpgi6XZP31V
         mfRsyrvbFhChDYAD7gqaeWGmF0lETJu+L0o//f6ClU5IDgod7SrMpEpDE0h7lRBo14in
         V4xP4L+58huo6sdaACpQ3ZZtkfjIvSGt3IXcTb4wyb/wvNYyqjkF9mzXSoNF9ZrAx8zv
         pR9K0J+0Ig0mvXRdSczDEZePL0ckEz9h6W3Yq/pjVb9/qZp2ijHn5mds+9AeqAiAyB+P
         Pigw==
X-Gm-Message-State: AOJu0YyKLq+3/l40M/6musxGjQOGzI/n5ISWQVnfxf0gpZ28xmQRFXBO
	3iuixuJokPUSjPqDQBLHM/J4EYsjIXKPq/K9xZrC2BHo4hCtYd4yFgMcObp9Kmc6CaLKyXdH24h
	xdHObAycNGo26hHnrxe7CfXdin1OnOc49PqT+zw==
X-Gm-Gg: ASbGncs2FXNAnKJhphJ8unapQ98mJLHDBM7PIGUqOAA2FVZFb+9k3N7eBzlen1ZyF04
	4EyPA3+/bY19KSQ3S89GHEeKk7SUHS2gx0c86dhwgXGYbNGEgLc+gatiS/rLotCSoxMroWpc=
X-Google-Smtp-Source: AGHT+IHv+I2p5zHxKdni7uy+cH8KbgWqgaOjWl1JHMLqSs/2/6dVKfb4uVrcDOL/pGfbcmGa35RKqU9KhK48dGI0PTU=
X-Received: by 2002:a17:906:6a13:b0:ab7:e8d6:3b21 with SMTP id
 a640c23a62f3a-ab7e8d64337mr108240266b.28.1739273422571; Tue, 11 Feb 2025
 03:30:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d9c50aa0df6cde2cb39cb7c9f978dbc27dadb770.1739241217.git.wqu@suse.com>
In-Reply-To: <d9c50aa0df6cde2cb39cb7c9f978dbc27dadb770.1739241217.git.wqu@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 11 Feb 2025 12:30:11 +0100
X-Gm-Features: AWEUYZlqoHqEh_KUm4BSgZFoywDjftk9b4FFryAVxQSNHIqwufLSXLM4UevZzUo
Message-ID: <CAPjX3FefNiRqkbamYrJ1ZQjihLxNxT48zC_Q6kja2e1oVmFvRg@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: add a generic test to verify direct IO writes
 with buffer contents change
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 11:16, Qu Wenruo <wqu@suse.com> wrote:
>
> There is a long existing btrfs problem that if some one is modifying the
> buffer of an on-going direct IO write, it has a very high chance causing
> permanent data checksum mismatch.
>
> This is caused by the following factors:
>
> - Direct IO buffer is out of the control of filesystem
>   Thus user space can modify the contents during writeback.
>
> - Btrfs generate its data checksum just before submitting the bio
>   This means if the contents happens after the checksum is generated,
>   the data written to disk will no longer match the checksum.
>
> Btrfs later fixes the problem by forcing the direct IO to fallback to
> buffered IO (if the inode requires data checksum), so that btrfs can
> have a consistent view of the buffer.

Would it be a bad idea if btrfs remapped the page read-only for the
duration of the writeback instead? Eventual page fault could either
block until the writeback is finished (which may be an unwanted
behavior) or it could map another copy of the data. This would keep
the direct IO behavior for applications which do not change the data
after submitting the IO.

Also, I'd maybe add a tracepoint or dynamic debug print (-once?) when
falling back to buffered IO.

> This test case will verify the behavior by:
>
> - Create a helper program 'dio-writeback-race'
>   Which does direct IO writes block-by-block, and the buffer is always
>   initialized to all 0xff before write,
>   Then starting two threads:
>   - One to submit the direct IO
>   - One to modify the buffer to 0x00
>
>   The program uses 4K as default block size, and 64MiB as the default
>   file size.
>   Which is more than enough to trigger tons of btrfs checksum errors
>   on unpatched kernels.
>
> - New test case generic/761
>   Which will:
>
>   * Use above program to create a 64MiB file
>
>   * Do buffered read on that file
>     Since above program is doing direct IO, there is no page cache
>     populated.
>     And the buffered read will need to read out all data from the disk,
>     and if the filesystem supports data checksum, then the data checksum
>     will also be verified against the data.
>
> The test case passes on the following fses:
> - ext4
> - xfs
> - btrfs with "nodatasum" mount option
>   No data checksum to bother.
>
> - btrfs with default "datasum" mount option and the fix "btrfs: always
>   fallback to buffered write if the inode requires checksum"
>   This makes btrfs to fallback on buffered IO so the contents won't
>   change during writeback of page cache.
>
> And fails on the following fses:
>
> - btrfs with default "datasum" mount option and without the fix
>   Expected.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix the comment on the default block size of dio-writeback-race
> - Use proper type for pthread_exit() of do_io() function
> - Fix the error message when filesize is invalid
> - Fix the error message when unknown option is parsed
> - Catch the thread return value correctly for pthread_join() on IO thread
> - Always update @ret
> - Return EXIT_SUCCESS/FAILURE based on @ret at error: tag
> - Check the return value of pthread_join() correctly
> - Remove unused cleanup override/include comments from the test case
> - Add the missing fixed-by tag
> ---
>  .gitignore               |   1 +
>  src/Makefile             |   3 +-
>  src/dio-writeback-race.c | 148 +++++++++++++++++++++++++++++++++++++++
>  tests/generic/761        |  41 +++++++++++
>  tests/generic/761.out    |   2 +
>  5 files changed, 194 insertions(+), 1 deletion(-)
>  create mode 100644 src/dio-writeback-race.c
>  create mode 100755 tests/generic/761
>  create mode 100644 tests/generic/761.out
>
> diff --git a/.gitignore b/.gitignore
> index efd477738e1e..7060f52cf6b8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -210,6 +210,7 @@ tags
>  /src/perf/*.pyc
>  /src/fiemap-fault
>  /src/min_dio_alignment
> +/src/dio-writeback-race
>
>  # Symlinked files
>  /tests/generic/035.out
> diff --git a/src/Makefile b/src/Makefile
> index 1417c383863e..6ac72b366257 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -20,7 +20,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>         t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>         t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
>         t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> -       readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd
> +       readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
> +       dio-writeback-race
>
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>         preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/dio-writeback-race.c b/src/dio-writeback-race.c
> new file mode 100644
> index 000000000000..f0a2f6de531b
> --- /dev/null
> +++ b/src/dio-writeback-race.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * dio_writeback_race -- test direct IO writes with the contents of
> + * the buffer changed during writeback.
> + *
> + * Copyright (C) 2025 SUSE Linux Products GmbH.
> + */
> +
> +/*
> + * dio_writeback_race
> + *
> + * Compile:
> + *
> + *   gcc -Wall -pthread -o dio_writeback_race dio_writeback_race.c
> + *
> + * Make sure filesystems with explicit data checksum can handle direct IO
> + * writes correctly, so that even the contents of the direct IO buffer changes
> + * during writeback, the fs should still work fine without data checksum mismatch.
> + * (Normally by falling back to buffer IO to keep the checksum and contents
> + *  consistent)
> + *
> + * Usage:
> + *
> + *   dio_writeback_race [-b <buffersize>] [-s <filesize>] <filename>
> + *
> + * Where:
> + *
> + *   <filename> is the name of the test file to create, if the file exists
> + *   it will be overwritten.
> + *
> + *   <buffersize> is the buffer size for direct IO. Users are responsible to
> + *   probe the correct direct IO size and alignment requirement.
> + *   If not specified, the default value will be 4096.
> + *
> + *   <filesize> is the total size of the test file. If not aligned to <blocksize>
> + *   the result file size will be rounded up to <blocksize>.
> + *   If not specified, the default value will be 64MiB.
> + */
> +
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <pthread.h>
> +#include <unistd.h>
> +#include <getopt.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <sys/stat.h>
> +
> +static int fd = -1;
> +static void *buf = NULL;
> +static unsigned long long filesize = 64 * 1024 * 1024;
> +static int blocksize = 4096;
> +
> +const int orig_pattern = 0xff;
> +const int modify_pattern = 0x00;
> +
> +static void *do_io(void *arg)
> +{
> +       ssize_t ret;
> +
> +       ret = write(fd, buf, blocksize);
> +       pthread_exit((void *)ret);
> +}
> +
> +static void *do_modify(void *arg)
> +{
> +       memset(buf, modify_pattern, blocksize);
> +       pthread_exit(NULL);
> +}
> +
> +int main (int argc, char *argv[])
> +{
> +       pthread_t io_thread;
> +       pthread_t modify_thread;
> +       unsigned long long filepos;
> +       int opt;
> +       int ret = -EINVAL;
> +
> +       while ((opt = getopt(argc, argv, "b:s:")) > 0) {
> +               switch (opt) {
> +               case 'b':
> +                       blocksize = atoi(optarg);
> +                       if (blocksize == 0) {
> +                               fprintf(stderr, "invalid blocksize '%s'\n", optarg);
> +                               goto error;
> +                       }
> +                       break;
> +               case 's':
> +                       filesize = atoll(optarg);
> +                       if (filesize == 0) {
> +                               fprintf(stderr, "invalid filesize '%s'\n", optarg);
> +                               goto error;
> +                       }
> +                       break;
> +               default:
> +                       fprintf(stderr, "unknown option '%c'\n", opt);
> +                       goto error;
> +               }
> +       }
> +       if (optind >= argc) {
> +               fprintf(stderr, "missing argument\n");
> +               goto error;
> +       }
> +       ret = posix_memalign(&buf, blocksize, blocksize);
> +       if (!buf) {
> +               fprintf(stderr, "failed to allocate aligned memory\n");
> +               exit(EXIT_FAILURE);
> +       }
> +       fd = open(argv[optind], O_DIRECT | O_WRONLY | O_CREAT);
> +       if (fd < 0) {
> +               fprintf(stderr, "failed to open file '%s': %m\n", argv[2]);
> +               goto error;
> +       }
> +
> +       for (filepos = 0; filepos < filesize; filepos += blocksize) {
> +               void *retval = NULL;
> +
> +               memset(buf, orig_pattern, blocksize);
> +               pthread_create(&io_thread, NULL, do_io, NULL);
> +               pthread_create(&modify_thread, NULL, do_modify, NULL);
> +               ret = pthread_join(io_thread, &retval);
> +               if (ret) {
> +                       errno = ret;
> +                       ret = -ret;
> +                       fprintf(stderr, "failed to join io thread: %m\n");
> +                       goto error;
> +               }
> +               if ((ssize_t )retval < blocksize) {
> +                       ret = -EIO;
> +                       fprintf(stderr, "io thread failed\n");
> +                       goto error;
> +               }
> +               ret = pthread_join(modify_thread, NULL);
> +               if (ret) {
> +                       errno = ret;
> +                       ret = -ret;
> +                       fprintf(stderr, "failed to join modify thread: %m\n");
> +                       goto error;
> +               }
> +       }
> +error:
> +       close(fd);
> +       free(buf);
> +       if (ret < 0)
> +               return EXIT_FAILURE;
> +       return EXIT_SUCCESS;
> +}
> diff --git a/tests/generic/761 b/tests/generic/761
> new file mode 100755
> index 000000000000..422b716d31b6
> --- /dev/null
> +++ b/tests/generic/761
> @@ -0,0 +1,41 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 761
> +#
> +# Making sure direct IO (O_DIRECT) writes won't cause any data checksum mismatch,
> +# even if the contents of the buffer changes during writeback.
> +#
> +# This is mostly for filesystems with data checksum support, which should fallback
> +# to buffer IO to avoid inconsistency.
> +# For filesystems without data checksum support, nothing needs to be bothered.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_require_scratch
> +_require_odirect
> +_require_test_program dio-writeback-race
> +_fixed_by_kernel_commit XXXXXXXX \
> +       "btrfs: always fallback to buffered write if the inode requires checksum"
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount
> +
> +blocksize=$(_get_block_size $SCRATCH_MNT)
> +filesize=$(( 64 * 1024 * 1024))
> +
> +echo "blocksize=$blocksize filesize=$filesize" >> $seqres.full
> +
> +$here/src/dio-writeback-race -b $blocksize -s $filesize $SCRATCH_MNT/foobar
> +
> +# Read out the file, which should trigger checksum verification
> +cat $SCRATCH_MNT/foobar > /dev/null
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/761.out b/tests/generic/761.out
> new file mode 100644
> index 000000000000..72ebba4cb426
> --- /dev/null
> +++ b/tests/generic/761.out
> @@ -0,0 +1,2 @@
> +QA output created by 761
> +Silence is golden
> --
> 2.48.1
>
>


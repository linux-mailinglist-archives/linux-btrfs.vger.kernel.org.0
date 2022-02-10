Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A06A4B1309
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Feb 2022 17:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244435AbiBJQiN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Feb 2022 11:38:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244399AbiBJQh6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Feb 2022 11:37:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B6A137;
        Thu, 10 Feb 2022 08:37:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0861861D63;
        Thu, 10 Feb 2022 16:37:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5C1C340EF;
        Thu, 10 Feb 2022 16:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644511078;
        bh=ltv+bAqUY+8G8nIXg4dQuD16LkOGhqnLVdUGa7eG+go=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JgZY0bVVL5OAJLMuG41cuyCfVSVd0nxRTRekws0+kwrfPk/u6MPbhV43/QZ8bbxHc
         DTUuxfTMpka93vlj7vCssiquzqFmTvxqOC3dxnTdqoNEBS2z0COb/MlPAZhL3P+C/r
         wggWCv5ZVkrK3PSVzfkKFJbqIFWRvA6H54jgDFs0ZK7a0/w7jep4W6eEb8ePqf5dtu
         3jBcF5kIUphU5CR/eHEvKltIPQF24+9MqbOluMz7jOLGOUN4uOqzbwC1wG1At8dz7P
         mYH8Hyfw1nu83fr/0NSy88f6FPn9bBPJKx57lBmKHYQCSZXR+LcsUvlTu3mioNcAvd
         L8/C6bjq/Ajyw==
Received: by mail-qt1-f180.google.com with SMTP id g4so5218278qto.1;
        Thu, 10 Feb 2022 08:37:58 -0800 (PST)
X-Gm-Message-State: AOAM532czNtNaptRJ8fjixcyUhj2eUz9jkH/P5k75hfz3LX9JE36F6A6
        lYnsI+SQmRiYTs7/viq9TKyOMks0DVLT6nW4Ims=
X-Google-Smtp-Source: ABdhPJzXjTAXYEb6zXQ/MuIskaw/t9SKIL0dv2El+IYXURHA3uP7COOmBeUFpr3U2ptYS6spItHqkxO211FBZBFr/XM=
X-Received: by 2002:ac8:6605:: with SMTP id c5mr5418996qtp.522.1644511077427;
 Thu, 10 Feb 2022 08:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20220208071427.19171-1-wqu@suse.com>
In-Reply-To: <20220208071427.19171-1-wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 10 Feb 2022 16:37:21 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5TSOMDpgP0FNbP_TqOgY_zjgsthjAo6iDnZS+g2FJk8w@mail.gmail.com>
Message-ID: <CAL3q7H5TSOMDpgP0FNbP_TqOgY_zjgsthjAo6iDnZS+g2FJk8w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add test case to make sure autodefrag works even
 the extent maps are read from disk
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 8, 2022 at 12:00 PM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a long existing problem that extent_map::generation is not
> populated (thus always 0) if its read from disk.
>
> This can prevent btrfs autodefrag from working as it relies on
> extent_map::generation.
> If it's always 0, then autodefrag will not consider the range as a
> defrag target.
>
> The test case itself will verify the behavior by:
>
> - Create a fragmented file
>   By writing backwards with OSYNC
>   This will also queue the file for autodefrag.
>
> - Drop all cache
>   Including the extent map cache, meaning later read will
>   all get extent map by reading from on-disk file extent items.
>
> - Trigger autodefrag and verify the file layout
>   If defrag works, the new file layout should differ from the original
>   one.
>
> The kernel fix is titled:
>
>   btrfs: populate extent_map::generation when reading from disk
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/259     | 64 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/259.out |  2 ++
>  2 files changed, 66 insertions(+)
>  create mode 100755 tests/btrfs/259
>  create mode 100644 tests/btrfs/259.out
>
> diff --git a/tests/btrfs/259 b/tests/btrfs/259
> new file mode 100755
> index 00000000..577e4ce4
> --- /dev/null
> +++ b/tests/btrfs/259
> @@ -0,0 +1,64 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 259
> +#
> +# Make sure autodefrag can still defrag the file even their extent maps are
> +# read from disk
> +#
> +. ./common/preamble
> +_begin_fstest auto quick defrag
> +
> +# Override the default cleanup function.
> +# _cleanup()
> +# {
> +#      cd /
> +#      rm -r -f $tmp.*
> +# }
> +
> +# Import common functions.
> +# . ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +
> +# Need 4K sectorsize, as the autodefrag threshold is only 64K,
> +# thus 64K sectorsize will not work.
> +_require_btrfs_support_sectorsize 4096

Missing a:

_require_xfs_io_command fiemap

> +_scratch_mkfs -s 4k >> $seqres.full
> +_scratch_mount -o datacow,autodefrag
> +
> +# Create fragmented write
> +$XFS_IO_PROG -f -s -c "pwrite 24k 8k" -c "pwrite 16k 8k" \
> +               -c "pwrite 8k 8k" -c "pwrite 0 8k" \
> +               "$SCRATCH_MNT/foobar" >> $seqres.full
> +sync

A comment on why this sync is needed would be good to have.
It may be confusing to the reader since we were doing synchronous writes before.

> +
> +echo "=== Before autodefrag ===" >> $seqres.full
> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $tmp.before
> +cat $tmp.before >> $seqres.full
> +
> +# Drop the cache (including extent map cache per-inode)
> +echo 3 > /proc/sys/vm/drop_caches
> +
> +# Now trigger autodefrag

A bit more explanation would be useful.

Set the commit interval to 1 second, so that 1 second after the
remount the transaction kthread runs
and wakes up the cleaner kthread, which in turn will run autodefrag.

> +_scratch_remount commit=1
> +sleep 3
> +sync

This sync is useless, so it should go away.

Otherwise, it looks good and the test works as expected.

Thanks for doing it.

> +
> +echo "=== After autodefrag ===" >> $seqres.full
> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $tmp.after
> +cat $tmp.after >> $seqres.full
> +
> +# The layout should differ if autodefrag is working
> +diff $tmp.before $tmp.after > /dev/null && echo "autodefrag didn't defrag the file"
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/259.out b/tests/btrfs/259.out
> new file mode 100644
> index 00000000..bfbd2dea
> --- /dev/null
> +++ b/tests/btrfs/259.out
> @@ -0,0 +1,2 @@
> +QA output created by 259
> +Silence is golden
> --
> 2.34.1
>

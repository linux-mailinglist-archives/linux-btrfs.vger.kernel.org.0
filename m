Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A45B2B2F54
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2019 11:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfIOJV1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Sep 2019 05:21:27 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41945 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfIOJV0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Sep 2019 05:21:26 -0400
Received: by mail-ua1-f67.google.com with SMTP id l13so335363uap.8;
        Sun, 15 Sep 2019 02:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=uzrH8wnj/ai4OKUtoNWmqwMtPVbq9uMoHCm8MPCqtIY=;
        b=WQ9WZs0TSG75NEG71PtZUq0LfPmE+CZgSsSZ8V7qND3Ajn/+rWJIZ5K3Gnwor+Rr63
         rXGCtSMXe3Bv0+lPp1vHHf9OA0qZ3ZCsfdfz//H7ZzwIIsypBmFyoms0oDueGRAthAYN
         nUFkVHDUKr7Uue4IDJUMKxpraLzMB8Cqe1cDWVhc232XGJIuch/8YljKBgbirk31Lfpa
         Tkb8xByQcOpSjR/FOzFNOS095kHYTuQafd7SJed7ejLHk1HpeURgyw34O3PqUVlJx05o
         6UVEUUo8HobTkcjDOvY6xs5bu2DQCx8sLNDvGfSWSnzeYO0WRSMvtznXvhW6eRE6eZSF
         uTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=uzrH8wnj/ai4OKUtoNWmqwMtPVbq9uMoHCm8MPCqtIY=;
        b=fkQ0ud2AjMzGC8/KBdePZCrCp/aGTWLs94hnbPHDWNyO7navvNhbgQNVKAbrDMyIUB
         aWxVwCH/wjj+kBJQv6mv3LZgiJL4W1ci8LikNm13L88NiFzfLuP1T64j6exLn+u1Impt
         Xt4TkoDR/nsOWsfnp9B46qHMd/T4p2ZJGJZdR2TPfz0mZTHa4cRAWa5EaRScgkKuqpbf
         CWca21uC8MNC5WFmV4op4wrV/nC2royt+BSMyMWQ8Bnc0cCjU9LaQHUUsBwlwSfiZShf
         TMLZVAXiDCGfgvqd1titQo4HPQa99r/ya1bdncJXgLfw+4QfL0E28wMb2JqWWtjIj208
         Wtww==
X-Gm-Message-State: APjAAAXAWYdsn/IamKh8qjm1fHwEvKTAx/9VQUteCBqEPIFQXuZamiPr
        YUvhoMuWUlGgufsbdy6sTcFMXORdCG1JIbfz4UNcdA==
X-Google-Smtp-Source: APXvYqyop14VDFmsfHRuKVzunaUu+rmNZN4IxUjUcTJxvdMYFBaSlJi1twfyUtBPnOR/aEXi/A8I5y0Zaf56G0+M5Gc=
X-Received: by 2002:ab0:2eab:: with SMTP id y11mr28449600uay.0.1568539285181;
 Sun, 15 Sep 2019 02:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190915072230.25732-1-wqu@suse.com>
In-Reply-To: <20190915072230.25732-1-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Sun, 15 Sep 2019 10:21:14 +0100
Message-ID: <CAL3q7H5w03tHwMa2-yv3A3zXdavhF=Ej0xEM++VReoSxX+NaEA@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs: Verify falloc on multiple holes won't
 cause qgroup reserved data space leak
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Sep 15, 2019 at 8:32 AM Qu Wenruo <wqu@suse.com> wrote:
>
> Add a test case where falloc is called on multiple holes with qgroup
> enabled.
>
> This can cause qgroup reserved data space leak and false EDQUOT error
> even we're not reaching the limit.
>
> The fix is titled:
> "btrfs: qgroup: Fix the wrong target io_tree when freeing
>  reserved data space"
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> changelog:
> v2:
> - Remove the unnecessary loop
>   The loop itself is just to ensure we leak as much space as possible.
>   However even one loop is already enough to fail the final
>   verification write, so remove the loop and modify the golden output.
> ---
>  tests/btrfs/192     | 70 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/192.out |  8 ++++++
>  tests/btrfs/group   |  1 +
>  3 files changed, 79 insertions(+)
>  create mode 100755 tests/btrfs/192
>  create mode 100644 tests/btrfs/192.out
>
> diff --git a/tests/btrfs/192 b/tests/btrfs/192
> new file mode 100755
> index 00000000..1abd7838
> --- /dev/null
> +++ b/tests/btrfs/192
> @@ -0,0 +1,70 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 192
> +#
> +# Test if btrfs is going to leak qgroup reserved data space when
> +# falloc on multiple holes fails.
> +# The fix is titled:
> +# "btrfs: qgroup: Fix the wrong target io_tree when freeing reserved dat=
a space"
> +#
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       cd /
> +       rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_supported_os Linux
> +_require_scratch
> +_require_xfs_io_command falloc
> +
> +_scratch_mkfs > /dev/null
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" > /dev/null
> +$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
> +$BTRFS_UTIL_PROG qgroup limit -e 256M "$SCRATCH_MNT"
> +
> +# Create a file with the following layout:
> +# 0         128M      256M      384M
> +# |  Hole   |4K| Hole |4K| Hole |
> +# The total hole size will be 384M - 8k
> +truncate -s 384m "$SCRATCH_MNT/file"
> +$XFS_IO_PROG -c "pwrite 128m 4k" -c "pwrite 256m 4k" \
> +       "$SCRATCH_MNT/file" | _filter_xfs_io
> +
> +# Falloc 0~384M range, it's going to fail due to the qgroup limit
> +$XFS_IO_PROG -c "falloc 0 384m" "$SCRATCH_MNT/file" |\
> +       _filter_xfs_io_error

This can be in a single line, as it doesn't go beyond 80 characters.
It doesn't hurt, but the use of the error filter isn't necessary here
at the moment.

> +rm "$SCRATCH_MNT/file"

rm -f, in case one has  " alias rm=3D'rm -i' " in its environment.

> +
> +# Ensure above delete reaches disk and free some space
> +sync
> +
> +# We should be able to write at least 3/4 of the limit
> +$XFS_IO_PROG -f -c "pwrite 0 192m" "$SCRATCH_MNT/file" | _filter_xfs_io
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/192.out b/tests/btrfs/192.out
> new file mode 100644
> index 00000000..654adf48
> --- /dev/null
> +++ b/tests/btrfs/192.out
> @@ -0,0 +1,8 @@
> +QA output created by 192
> +wrote 4096/4096 bytes at offset 134217728
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 4096/4096 bytes at offset 268435456
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +fallocate: Disk quota exceeded
> +wrote 201326592/201326592 bytes at offset 0
> +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 2474d43e..160fe927 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -194,3 +194,4 @@
>  189 auto quick send clone
>  190 auto quick replay balance qgroup
>  191 auto quick send dedupe
> +192 auto qgroup fast enospc limit

fast -> quick?
(we don't have a group named "fast" yet)

Anyway, small things that can be fixed at commit time.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks

> --
> 2.22.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4A341DA4B
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 14:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351124AbhI3MzZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 08:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351051AbhI3MzY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 08:55:24 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66FAC06176A
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 05:53:41 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 138so5592996qko.10
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 05:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=DQFuUXlpV52lKCkydR2nzm0+RWeFeRWH7np48yVqgCU=;
        b=QRfH4ec/OscBPNkGRjQ3GbTeXmiI3ua0Uio3HxQDGCfUxQH3TbvlaT9jzahTneN+aL
         BGbq3MkH2znUEmqbD4liwu0iOcdV/wjU3ch+BBy6PFUN5wiKOfymZyl/vLEjBZvnXqpx
         1paAzg7IPfJU39ZIKBiNkMq4jwWBxuot1txCmgPqVRwSgaRakHfmpQSYTttH9GOg+f66
         whQVrsjEekE1HppsA3t/35jZ6AT6BSWSd40tIGNXJLBOtRGwVa9f2rYG1SBKG3Hxric5
         SmhsLIkz7lN3LLCLj2TZAcimTC3e/+MfUvvax+RGYEnHy5Pw/fXDEXkFchi44kXweaOW
         5l8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=DQFuUXlpV52lKCkydR2nzm0+RWeFeRWH7np48yVqgCU=;
        b=gqXk+5RigaclGPeplKmy/JdSFWd3GwezcXj1Ery4K7wrcgOOnVlM5TLc1VXonJZRWk
         CDNt7J01ADKgmXq3IRZscYb1wtN0m6iN8isWID4BF5EtiK6tQv0LBi0LuhVaogMiqOFc
         uzbclnDNTNDgRQarSw5yzCv4MU/EUADimab15OwjUSbO0UMmiAiJid5yW5al6twoQaAe
         lLqVOYRgXpgOwtKKYl1KhF0YbM+MISX4bA7LVi6YUSSD9gIo8ITN9M3tXaAlO35STa9A
         OYrb57DU3QBuuTCIfpd9ixtQSZXlV4PLF/OY6TziARg7SB1z6CRUZMcSSu6SnX0rZ2kI
         u8JQ==
X-Gm-Message-State: AOAM533uynszmQPgPXP9uZcA+WAysdCVIXNtIibhYd0qMfcE34pf+EtV
        f/M2bhvv7+yfdU4o0jiUwiq9K3rOJu8MOjjgFCTWQpyS8nA=
X-Google-Smtp-Source: ABdhPJysbk66e8xqBGUremHv+r8llVoNbO9v3haJJkcSNA1sHwWf7WjFbz2Yhuwq8wEA0jy9Vwb4BifbdrKVBiTjD/8=
X-Received: by 2002:a37:8287:: with SMTP id e129mr4756592qkd.415.1633006420872;
 Thu, 30 Sep 2021 05:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210930114855.39225-1-wqu@suse.com> <20210930114855.39225-3-wqu@suse.com>
In-Reply-To: <20210930114855.39225-3-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 30 Sep 2021 13:53:04 +0100
Message-ID: <CAL3q7H7EvzXiA2fvhKkNT4ifpb0daxCoE68VOQ0H4UVfjSYNsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] btrfs-progs: misc-tests: add test case for receive --clone-fallback
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 30, 2021 at 12:51 PM Qu Wenruo <wqu@suse.com> wrote:
>
> The new test case will create two send streams:
>
> - parent_stream
>   A full send stream.
>   Contains one file, as clone source.
>
> - clone_stream
>   An incremental send stream.
>   Contains one clone operation.
>
> Then we will receive the parent_stream with default mount options, while
> try to receive the clone_stream with nodatasum mount option.
>
> This should result clone failure due to nodatasum flag mismatch.
>
> Then check if the receive can continue with --clone-fallback option.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  tests/common                                  |  9 +++
>  .../049-receive-clone-fallback/test.sh        | 58 +++++++++++++++++++
>  2 files changed, 67 insertions(+)
>  create mode 100755 tests/misc-tests/049-receive-clone-fallback/test.sh
>
> diff --git a/tests/common b/tests/common
> index 253071025db2..0423af4231a8 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -633,6 +633,15 @@ run_check_mount_test_dev()
>         run_check $SUDO_HELPER mount -t btrfs $loop_opt "$@" "$TEST_DEV" =
"$TEST_MNT"
>  }
>
> +run_check_remount_test_dev()
> +{
> +       setup_root_helper
> +
> +       local opts=3D"$1"
> +
> +       run_check $SUDO_HELPER mount -o "remount,$opts" "$TEST_MNT"
> +}
> +
>  # $1-$n: optional paths to unmount, otherwise fallback to TEST_DEV
>  run_check_umount_test_dev()
>  {
> diff --git a/tests/misc-tests/049-receive-clone-fallback/test.sh b/tests/=
misc-tests/049-receive-clone-fallback/test.sh
> new file mode 100755
> index 000000000000..18136a9e63ee
> --- /dev/null
> +++ b/tests/misc-tests/049-receive-clone-fallback/test.sh
> @@ -0,0 +1,58 @@
> +#!/bin/bash
> +# Verify that btrfs receive can fallback to buffered copy when clone
> +# failed
> +
> +source "$TEST_TOP/common"
> +
> +check_prereq mkfs.btrfs
> +check_prereq btrfs
> +setup_root_helper
> +prepare_test_dev
> +
> +tmp=3D$(mktemp -d --tmpdir btrfs-progs-send-stream.XXXXXX)
> +
> +# Create two sends stream, one as the parent and the other as an increme=
ntal
> +# stream with one clone operation.
> +run_check_mkfs_test_dev
> +run_check_mount_test_dev -o datacow,datasum
> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv"
> +run_check $SUDO_HELPER dd if=3D/dev/zero bs=3D1M count=3D1 of=3D"$TEST_M=
NT/subv/file1"
> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "$TEST_MNT/sub=
v" \
> +       "$TEST_MNT/snap1"
> +run_check $SUDO_HELPER cp --reflink=3Dalways "$TEST_MNT/subv/file1" \
> +       "$TEST_MNT/subv/file2"
> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume snapshot -r "$TEST_MNT/sub=
v" \
> +       "$TEST_MNT/snap2"
> +
> +run_check $SUDO_HELPER "$TOP/btrfs" send -f "$tmp/parent_stream" \
> +       "$TEST_MNT/snap1"
> +run_check $SUDO_HELPER "$TOP/btrfs" send -f "$tmp/clone_stream" \
> +       -p "$TEST_MNT/snap1" "$TEST_MNT/snap2"
> +
> +run_check_umount_test_dev
> +run_check_mkfs_test_dev
> +
> +# Receive the first stream with the same mount option
> +run_check_mount_test_dev -o datacow -o datasum
> +
> +# Receiving the full stream should not fail
> +run_check $SUDO_HELPER "$TOP/btrfs" receive -f "$tmp/parent_stream" "$TE=
ST_MNT"
> +
> +# Remount the fs with nodatasum mount option, so that the new file recei=
ved
> +# through the incremental stream will end up with the nodatasum flag set=
.
> +run_check_remount_test_dev nodatasum
> +
> +# Receiving incremental send stream without --clone-fallback should fail=
.
> +# As the clone source and destination have different NODATASUM flags
> +run_mustfail "receiving clone with different NODATASUM should fail" \
> +       $SUDO_HELPER "$TOP/btrfs" receive -f "$tmp/clone_stream" "$TEST_M=
NT"
> +
> +# Firstly we need to cleanup the partially received subvolume
> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume delete "$TEST_MNT/snap2"
> +
> +# With --clone-fallback specified, the receive should finish without pro=
blem
> +run_check $SUDO_HELPER "$TOP/btrfs" receive --clone-fallback \
> +       -f "$tmp/clone_stream" "$TEST_MNT"
> +run_check_umount_test_dev
> +
> +rm -rf -- "$tmp"
> --
> 2.33.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

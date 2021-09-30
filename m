Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7CD41D711
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 12:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349567AbhI3KFY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 06:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbhI3KFX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 06:05:23 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D26CC06176A
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 03:03:41 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id e16so5059865qte.13
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 03:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=sX2X73EEAhdZLlV3YZghDNbZTDQJLZCq69U7peNBhiU=;
        b=EDKdEQCdQk2I6g7zGIYeD0C1HEP65eafnw1uwKIOgYIRo+W6kMhsa6M1De8I2juoyo
         iEr8+mrQ4ml0yR+3u0QJO49eeQEEFJZ7xOE6BtbfKnKVn6fqC/rFgVR08gQNUQqus+Yz
         tZNepmeaWapqSfZLjTo3DxN+UP8f+VeswcfbtG5UyGOhbZhQxwRufdAQ8BCGptZxEq1c
         YkDGxFYq/l87NfzVzX4GGg+QDyJN4yQAZUzmymSqR0tT74BtOqxXYoblNVp5GJxgWahT
         h3UrTf273WsSc6/QF3ekV6Ai2jxLjXEt22Pv46T88z9i5u9K1xM3ybDTVoplviKvQ40M
         XDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=sX2X73EEAhdZLlV3YZghDNbZTDQJLZCq69U7peNBhiU=;
        b=JADbqyjJvZWwuuRhq+biF0QyyLp6dmgkMSKBpDkyS95fekETWVSjeQzqUjASrMCuDf
         cSVnCO2pKsr5NnldSbSj+k01l/0yYzrvZDTvDEZVkW/i01gv5kQmgu8KWC60V7UGKlP0
         LPot9J6aJng27MAhGKjtmEhDhflG9LqOqzAPRvo/ddmOfTjejirEyb6wPWnryBj3iwNy
         SIr2sL7Gi5sTew9wcVKHPCWhhERwpOY4XqnqGv7TzQA+IhJQuJpk2/5yfbuAwHi4Eyr0
         FdE/KcTnP9jvweF+2G7MLeRYblNNL4szF3WIQMIuNmCul8DTtVvf7UweyQEgfmWH237N
         3SfQ==
X-Gm-Message-State: AOAM530b7xt+A3EifFXIxcE17QOmFGSy2xi9R5rUhPGA61wbT4djz9G3
        RBLsFtNPePuWPykJ1Ab3JjnJtq1SrOHYweCLOp0eV7Ie
X-Google-Smtp-Source: ABdhPJy2N/Y6tToJcgAuw10yWGgpuH+oqAXCx+AuBQAaQ3xyvfZ8pCOwwY6RMCUwhNTbdLkfq81hnx3C872/OiU+YhU=
X-Received: by 2002:ac8:4f0b:: with SMTP id b11mr5509920qte.124.1632996220626;
 Thu, 30 Sep 2021 03:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210930000042.10147-1-wqu@suse.com> <20210930000042.10147-3-wqu@suse.com>
In-Reply-To: <20210930000042.10147-3-wqu@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 30 Sep 2021 11:03:04 +0100
Message-ID: <CAL3q7H7ccjnLQM9Hawe3VtRkcYVM__jCqJRZ-BjaYJzfYQ+2Yg@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs-progs: misc-tests: add test case for receive --clone-fallback
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 30, 2021 at 1:06 AM Qu Wenruo <wqu@suse.com> wrote:
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
> ---
>  .../049-receive-clone-fallback/test.sh        | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100755 tests/misc-tests/049-receive-clone-fallback/test.sh
>
> diff --git a/tests/misc-tests/049-receive-clone-fallback/test.sh b/tests/=
misc-tests/049-receive-clone-fallback/test.sh
> new file mode 100755
> index 000000000000..d383c0e08a68
> --- /dev/null
> +++ b/tests/misc-tests/049-receive-clone-fallback/test.sh
> @@ -0,0 +1,60 @@
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
> +# Create two send stream, one as the parent and the other as an incremen=
tal

stream -> streams

> +# stream with one clone operation.
> +run_check_mkfs_test_dev
> +run_check_mount_test_dev -o datacow,datasum
> +run_check $SUDO_HELPER "$TOP/btrfs" subvolume create "$TEST_MNT/subv"

You can use the default subvolume and therefore avoid creating a
subvolume and making the test longer than needed.
Your call.

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
> +# Now we have the needed stream, try to receive them with different moun=
t

Reading this is confusing, it mentions receiving them with different
mount options, but they are the same for the first receive.

> +# options
> +run_check_mount_test_dev -o datacow -o datasum
> +
> +# Receiving the full stream should not fail
> +run_check $SUDO_HELPER "$TOP/btrfs" receive -f "$tmp/parent_stream" "$TE=
ST_MNT"
> +
> +# No remount helper, so here we manually unmoutn and re-mount with diffe=
rent
> +# nodatasum option

Seems pointless to mention there's a lack of a remount helper in the
test framework.
Just say that now we mount the filesystem with nodatasum so that the
new file received through the incremental stream ends up with the
nodatasum flag set.

Thanks.

> +run_check_umount_test_dev
> +run_check_mount_test_dev -o datacow,nodatasum
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

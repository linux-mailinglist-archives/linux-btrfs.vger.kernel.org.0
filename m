Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722807DBDD6
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 17:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjJ3Q3s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 12:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3Q3r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 12:29:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DFCA6
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 09:29:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75E2C433C7;
        Mon, 30 Oct 2023 16:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698683384;
        bh=+VHDQAuS4jsUfAzNxGSKlf52N+CBInpKmN8pRsFZxE8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KOZonAGXboe78lbhp6NXQ19c00N6HWIImbLEuXPWXLyFA7xDaX8rEI6JtCkD1QKOg
         HZbKT0/pamB2Emj3idGUpdI49/3zouONvyx62tAtWqg09jJNxv5ul4IPsY4Rtku8Uq
         t4b3Q4/Z0srGqeTgBh8tCaXYWaMZ1e2e1B3gqjM9CAg5Hu7zRySghumdWPdtlS9hiI
         NYGrwv+fY3BJFuGPBQSe5MO5YgJ0Ax6fPLmZdP388Mh2uXneNcBKQumbYAOGRzyNE7
         lffPTGykvgk9QguK7DYXNz9O4Kds4fGmCHLqGo59jDOcLVwHyfzzZmdWHWLMtSG5dU
         7f4edFe/LalIA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9d34b2b51a5so221630266b.2;
        Mon, 30 Oct 2023 09:29:44 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzjk1dDquvcRWnGL/BveCJ2pHgqJvN0tlGsj0+4/w+UN1EQDKE1
        /k+/SNlfAuIxGheHz4Dx8OcSFTHC+ZKmCUF8Q8k=
X-Google-Smtp-Source: AGHT+IElQ6EOrH7CuecwONgz91QGBucZlbv7rFjxkklLbsRxotKOarrW/0YASa6RHN34psEjNXdhVri6DxPn5KhWIB8=
X-Received: by 2002:a17:907:3f8f:b0:9bf:60f9:9b7c with SMTP id
 hr15-20020a1709073f8f00b009bf60f99b7cmr9592127ejc.62.1698683383244; Mon, 30
 Oct 2023 09:29:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698674332.git.anand.jain@oracle.com> <3559a441f8dfb450881001b7f4cbf780d7fa178e.1698674332.git.anand.jain@oracle.com>
In-Reply-To: <3559a441f8dfb450881001b7f4cbf780d7fa178e.1698674332.git.anand.jain@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 30 Oct 2023 16:29:06 +0000
X-Gmail-Original-Message-ID: <CAL3q7H427WL6mF-kc8gcfi6bYNHkZH4vyvUzHZR_nsgxK3_+CQ@mail.gmail.com>
Message-ID: <CAL3q7H427WL6mF-kc8gcfi6bYNHkZH4vyvUzHZR_nsgxK3_+CQ@mail.gmail.com>
Subject: Re: [PATCH 4/6 v3] btrfs/219: fix _cleanup() to successful release
 the loop-device
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 30, 2023 at 2:15=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> When we fail with the message 'We were allowed to mount when we should
> have failed,' it will fail to clean up the loop devices, making it
> difficult to run further test cases or the same test case again.
>
> Before temp-fsid support, the last mount would fail, so there is no need
> to free the last 2nd loop device, and there is no local variable to
> release it. However, with temp-fsid, the mount shall be successful, so we
> need a 2nd loop device local variable to release it. Let's reorganize the
> local variables to clean them up in the _cleanup() function.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>
> v3: a split from the patch 5/6
>
>  tests/btrfs/219 | 63 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 36 insertions(+), 27 deletions(-)
>
> diff --git a/tests/btrfs/219 b/tests/btrfs/219
> index b747ce34fcc4..44a4c79dc05d 100755
> --- a/tests/btrfs/219
> +++ b/tests/btrfs/219
> @@ -19,14 +19,19 @@ _cleanup()
>  {
>         cd /
>         rm -f $tmp.*
> -       if [ ! -z "$loop_mnt" ]; then
> -               $UMOUNT_PROG $loop_mnt
> -               rm -rf $loop_mnt
> -       fi
> -       [ ! -z "$loop_mnt1" ] && rm -rf $loop_mnt1
> -       [ ! -z "$fs_img1" ] && rm -rf $fs_img1
> -       [ ! -z "$fs_img2" ] && rm -rf $fs_img2
> -       [ ! -z "$loop_dev" ] && _destroy_loop_device $loop_dev
> +
> +       # The variables are set before the test case can fail.
> +       $UMOUNT_PROG ${loop_mnt1} &> /dev/null
> +       $UMOUNT_PROG ${loop_mnt2} &> /dev/null
> +       rm -rf $loop_mnt1 &> /dev/null
> +       rm -rf $loop_mnt2 &> /dev/null

No need for the redirection when calling rm with -f.
rm doesn't print anything to stdout or stderr if the target file/dir
does not exist.

> +
> +       _destroy_loop_device $loop_dev1 &> /dev/null
> +       _destroy_loop_device $loop_dev2 &> /dev/null

Rather than making _destroy_loop_device() ignore a missing device
argument, it's cleaner to
avoid calling it if $loop_dev1 and $loop_dev2 are not defined / are
empty strings, as commented before.

> +
> +       rm -rf $fs_img1 &> /dev/null
> +       rm -rf $fs_img2 &> /dev/null

Same here.

Thanks.

> +
>         _btrfs_rescan_devices
>  }
>
> @@ -36,56 +41,60 @@ _cleanup()
>  # real QA test starts here
>
>  _supported_fs btrfs
> +
> +loop_mnt1=3D$TEST_DIR/$seq/mnt1
> +loop_mnt2=3D$TEST_DIR/$seq/mnt2
> +fs_img1=3D$TEST_DIR/$seq/img1
> +fs_img2=3D$TEST_DIR/$seq/img2
> +loop_dev1=3D""
> +loop_dev2=3D""
> +
>  _require_test
>  _require_loop
>  _require_btrfs_forget_or_module_loadable
>  _fixed_by_kernel_commit 5f58d783fd78 \
>         "btrfs: free device in btrfs_close_devices for a single device fi=
lesystem"
>
> -loop_mnt=3D$TEST_DIR/$seq.mnt
> -loop_mnt1=3D$TEST_DIR/$seq.mnt1
> -fs_img1=3D$TEST_DIR/$seq.img1
> -fs_img2=3D$TEST_DIR/$seq.img2
> -
> -mkdir $loop_mnt
> -mkdir $loop_mnt1
> +mkdir -p $loop_mnt1
> +mkdir -p $loop_mnt2
>
>  $XFS_IO_PROG -f -c "truncate 256m" $fs_img1 >>$seqres.full 2>&1
>
>  _mkfs_dev $fs_img1 >>$seqres.full 2>&1
>  cp $fs_img1 $fs_img2
>
> +loop_dev1=3D`_create_loop_device $fs_img1`
> +loop_dev2=3D`_create_loop_device $fs_img2`
> +
>  # Normal single device case, should pass just fine
> -_mount -o loop $fs_img1 $loop_mnt > /dev/null  2>&1 || \
> +_mount $loop_dev1 $loop_mnt1 > /dev/null  2>&1 || \
>         _fail "Couldn't do initial mount"
> -$UMOUNT_PROG $loop_mnt
> +$UMOUNT_PROG $loop_mnt1
>
>  _btrfs_forget_or_module_reload
>
>  # Now mount the new version again to get the higher generation cached, u=
mount
>  # and try to mount the old version.  Mount the new version again just fo=
r good
>  # measure.
> -loop_dev=3D`_create_loop_device $fs_img1`
> -
> -_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
> +_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
>         _fail "Failed to mount the second time"
> -$UMOUNT_PROG $loop_mnt
> +$UMOUNT_PROG $loop_mnt1
>
> -_mount -o loop $fs_img2 $loop_mnt > /dev/null 2>&1 || \
> +_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 || \
>         _fail "We couldn't mount the old generation"
> -$UMOUNT_PROG $loop_mnt
> +$UMOUNT_PROG $loop_mnt2
>
> -_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
> +_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
>         _fail "Failed to mount the second time"
> -$UMOUNT_PROG $loop_mnt
> +$UMOUNT_PROG $loop_mnt1
>
>  # Now we definitely can't mount them at the same time, because we're sti=
ll tied
>  # to the limitation of one fs_devices per fsid.
>  _btrfs_forget_or_module_reload
>
> -_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
> +_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
>         _fail "Failed to mount the third time"
> -_mount -o loop $fs_img2 $loop_mnt1 > /dev/null 2>&1 && \
> +_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 && \
>         _fail "We were allowed to mount when we should have failed"
>
>  _btrfs_rescan_devices
> --
> 2.39.3
>

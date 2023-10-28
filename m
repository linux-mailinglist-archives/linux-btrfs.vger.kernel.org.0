Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9867DA6AF
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Oct 2023 13:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjJ1LRK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 28 Oct 2023 07:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1LRF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 28 Oct 2023 07:17:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35135E0
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Oct 2023 04:17:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB34AC433CA;
        Sat, 28 Oct 2023 11:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698491821;
        bh=yuyAEKbUMllqlpHIBHDDGsD6HPA59TRQoPFtoZsJVS4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RS6d5h35199hgGEWo/1wniPwwIG5LoiUUHn62Hjafwx7v/MnQI5PvfrZ7JFuNN7dT
         s7yTF4AhjZrwqYWdOflo2MU1oimAuLG9zsdrEWxS/gX819pBvakJ4FbZTA01QIB6N/
         8wDQvYdAqS9Xz50tb4Wi2cRJi4qu6uqLX+mHs4HEiJrPv+AuRaaa6fIdFNebcqgrFb
         ON8AMnxHz1OXkh3wDHpoae3JiuD5OUSweouiL83qIZmNV3IyTQN/OrqsScs8G82Kc4
         HrTa7FwFUmQyjZcgVVwXO8OBOE7DgBErOlyrOe/zZAv8r15655JATqVk/WmVSqidi1
         NpcWvBUAjcwqA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5406c099cebso4423199a12.2;
        Sat, 28 Oct 2023 04:17:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YxzDpwE6fbXxwEVGpQxHp/tA7VFZnIXR5RUSR6pHFQrreKqrReO
        E2LXdfMOmW1dEl0cDsYqd7u7Yzn6dUUZVgRH4Eg=
X-Google-Smtp-Source: AGHT+IHDS/lsqW8Dl2N9BmriuvnW5377XK84GzVJ6cA0b5wAmP1N95QAX9hIaHQDpau/ROL8OWaAU8czRnljxIMcMgQ=
X-Received: by 2002:a17:907:3e1a:b0:9bf:4e0b:fb08 with SMTP id
 hp26-20020a1709073e1a00b009bf4e0bfb08mr5394007ejc.16.1698491820106; Sat, 28
 Oct 2023 04:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698418886.git.anand.jain@oracle.com> <cf97bf909b5a67464f5dcf2a802b7d80c79c472e.1698418886.git.anand.jain@oracle.com>
In-Reply-To: <cf97bf909b5a67464f5dcf2a802b7d80c79c472e.1698418886.git.anand.jain@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Sat, 28 Oct 2023 12:16:23 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5d7MHHJFKkkcpg0Nt7naDbURVTpfzXDa8yMTVjxFy=hg@mail.gmail.com>
Message-ID: <CAL3q7H5d7MHHJFKkkcpg0Nt7naDbURVTpfzXDa8yMTVjxFy=hg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] fstests: btrfs/219 cloned-device mount capability update
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 27, 2023 at 4:14=E2=80=AFPM Anand Jain <anand.jain@oracle.com> =
wrote:
>
> This test case originally checked for failed cloned device mounts, which
> is no longer relevant after the commit a5b8a5f9f835 ("btrfs: support
> cloned-device mount capability"). So removing the obsolete part.
>
> Additionally, add this test case back to the auto group which reverts the
> commit e2e7b549380a ("fstests: btrfs/219: remove it from auto group") sin=
ce
> the previously missing kernel commit 5f58d783fd78 ("btrfs: free device in
> btrfs_close_devices for a single device filesystem") has already been
> integrated.
>
> Add cleanups of the local variables and the _cleanup() function.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202310251645.5fe5495a-oliver.sang@=
intel.com
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Restores the code where it tests clone-devices.
>
>  tests/btrfs/219 | 79 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 49 insertions(+), 30 deletions(-)
>
> diff --git a/tests/btrfs/219 b/tests/btrfs/219
> index b747ce34fcc4..eb3e0487aa74 100755
> --- a/tests/btrfs/219
> +++ b/tests/btrfs/219
> @@ -12,21 +12,27 @@
>  #
>
>  . ./common/preamble
> -_begin_fstest quick volume
> +_begin_fstest auto quick volume
>
>  # Override the default cleanup function.
>  _cleanup()
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

What if the _require_* statements fail?
Then the variables won't be defined...

> +       $UMOUNT_PROG ${loop_mnt1} &> /dev/null
> +       $UMOUNT_PROG ${loop_mnt2} &> /dev/null
> +
> +       _destroy_loop_device $loop_dev1 &> /dev/null
> +       _destroy_loop_device $loop_dev2 &> /dev/null
> +
> +       rm -rf $fs_img1 &> /dev/null
> +       rm -rf $fs_img2 &> /dev/null
> +
> +       rm -rf $loop_mnt1 &> /dev/null
> +       rm -rf $loop_mnt2 &> /dev/null

Also please for simplicity and clarity don't mix this type of change
with the actual purpose of the patch,
to make the test succeed on a kernel with the temp-fsid feature.

You're mixing 3 different changes in the same patch...

> +
>         _btrfs_rescan_devices
>  }
>
> @@ -38,55 +44,68 @@ _cleanup()
>  _supported_fs btrfs
>  _require_test
>  _require_loop
> +_require_btrfs_fs_sysfs
>  _require_btrfs_forget_or_module_loadable
>  _fixed_by_kernel_commit 5f58d783fd78 \
>         "btrfs: free device in btrfs_close_devices for a single device fi=
lesystem"
>
> -loop_mnt=3D$TEST_DIR/$seq.mnt
> -loop_mnt1=3D$TEST_DIR/$seq.mnt1
> -fs_img1=3D$TEST_DIR/$seq.img1
> -fs_img2=3D$TEST_DIR/$seq.img2
> +loop_mnt1=3D$TEST_DIR/$seq/mnt1
> +loop_mnt2=3D$TEST_DIR/$seq/mnt2
> +fs_img1=3D$TEST_DIR/$seq/img1
> +fs_img2=3D$TEST_DIR/$seq/img2

So this is the other unrelated change, renaming all these variables...
This is making the diff larger to follow as this has nothing to do
with the goal of making the test succeed on a kernel with the
temp-fsid feature.

>
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
> -# Now we definitely can't mount them at the same time, because we're sti=
ll tied
> -# to the limitation of one fs_devices per fsid.
> +# Now try mount them at the same time, if kernel does not support
> +# temp-fsid feature then mount should fail.
>  _btrfs_forget_or_module_reload
>
> -_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
> +_mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
>         _fail "Failed to mount the third time"
> -_mount -o loop $fs_img2 $loop_mnt1 > /dev/null 2>&1 && \
> -       _fail "We were allowed to mount when we should have failed"
> +_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1
> +
> +if [ $? =3D=3D 0 ]; then
> +       # On temp-fsid supported kernels, mounting cloned device will be =
successfull.
> +       if _has_fs_sysfs_attr $loop_dev2 temp_fsid; then
> +               temp_fsid=3D$(_get_fs_sysfs_attr ${loop_dev2} temp_fsid)
> +               if [ $temp_fsid =3D=3D 0 ]; then
> +                       _fail "Cloned devices mounted without temp_fsid"
> +               fi

This is too complex. Why not just surround the existing code in an if
statement like this:

if "sysfs-file-for-temp-fsid  does not exist" then
     run this code that fails with a temp-fsid enabled kernel
fi

Thanks.

> +       else
> +               _fail "We were allowed to mount when we should have faile=
d"
> +       fi
> +fi
>
>  _btrfs_rescan_devices
>  # success, all done
> --
> 2.39.3
>

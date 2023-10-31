Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3BA7DCC02
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 12:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343833AbjJaLl5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 07:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343751AbjJaLl4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 07:41:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB4491
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 04:41:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DC8C433C9;
        Tue, 31 Oct 2023 11:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698752513;
        bh=JuxmoNQt9b9nMo/D5J5WC2Km3s5UvYzOCUpeegChWeg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NL4GhBTktue4Wk3fEqsrsv5IASCQoo8Ky+OY6yVfdl9bbXCNUN21pj7NXzPXIlLw5
         87n+s2Rs8eBsen40sj3DhKHD9uQthvCp0NTqLYLhBhb8NlcqIpZYLMfoP7TLKbUmDy
         XEIwmKGNbno4s+MooJLh8bRYc026LC4rl6Hst1O1rJtCdsv6har23VU5tLDvDPUKpO
         hVZyhnk6G8eJmAYHbBAKZ+SySJED0aypTxNJ3YfWbdllH17jyS9CNXn9B7KA2gbCbh
         eVCdLbOVkQadbeJlN5VDZVS6duqMf4PQPDZqA5lqExHEDjwd2HuF6L6OMepX8P+LCK
         ZpvQaE5sXsgMw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9c2a0725825so884221166b.2;
        Tue, 31 Oct 2023 04:41:53 -0700 (PDT)
X-Gm-Message-State: AOJu0YwlIhM8THhnwtueoid8grs0Hi5I2NwEvIbO3wxeM8RWyxejxaqv
        O/p1WsTrKdo4ox4VH5z8S/tBieOtBkN8N04MRws=
X-Google-Smtp-Source: AGHT+IGHrxVkFB2Mr/mAl/KgHsgrrLprWevC2aQxcw6n+5Bw63J+LTPDzmjr7jmrTg8o+22F+xF1tRxQosB3hdRhqqk=
X-Received: by 2002:a17:907:7283:b0:9c3:cefa:93c6 with SMTP id
 dt3-20020a170907728300b009c3cefa93c6mr10544818ejc.10.1698752512000; Tue, 31
 Oct 2023 04:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698712764.git.anand.jain@oracle.com> <77a360863a5d41d4e849fdb829145c6591d4e955.1698712764.git.anand.jain@oracle.com>
In-Reply-To: <77a360863a5d41d4e849fdb829145c6591d4e955.1698712764.git.anand.jain@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 31 Oct 2023 11:41:15 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4uK=WO=RcmpJHAUzQTyAGkoHu8-m2Ax0DE3bZxuGVWuQ@mail.gmail.com>
Message-ID: <CAL3q7H4uK=WO=RcmpJHAUzQTyAGkoHu8-m2Ax0DE3bZxuGVWuQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] btrfs/219: fix _cleanup() to successful release
 the loop-device
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 31, 2023 at 12:54=E2=80=AFAM Anand Jain <anand.jain@oracle.com>=
 wrote:
>
> When we fail with the message 'We were allowed to mount when we should
> have failed,' it will fail to clean up the loop devices, making it
> difficult to run further test cases or the same test case again.
>
> So we need a 2nd loop device local variable to release it. Let's
> reorganize the local variables to clean them up in the _cleanup() functio=
n.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>
> v4: rm -f, removed error/output redirection
>     rm, -r removed for file image
>     Check for the initialization of the local variable loop_dev[1-2]
>      before calling  _destroy_loop_device().
>
> v3: a split from the patch 5/6

One patch has a v4, others remain as v3 and one from v3 is dropped. A
bit hard to follow, as the common practice is usually to send a new
version of the whole patchset.

Nevertheless, unless I missed something, it looks good now:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

>
>  tests/btrfs/219 | 63 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 36 insertions(+), 27 deletions(-)
>
> diff --git a/tests/btrfs/219 b/tests/btrfs/219
> index b747ce34fcc4..35824df2baaa 100755
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
> +       rm -rf $loop_mnt1
> +       rm -rf $loop_mnt2
> +
> +       [ ! -z $loop_dev1 ] && _destroy_loop_device $loop_dev1
> +       [ ! -z $loop_dev1 ] && _destroy_loop_device $loop_dev2
> +
> +       rm -f $fs_img1
> +       rm -f $fs_img2
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
> 2.31.1
>

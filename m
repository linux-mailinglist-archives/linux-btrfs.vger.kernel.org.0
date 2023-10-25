Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DE67D70F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Oct 2023 17:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbjJYPcY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Oct 2023 11:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjJYPcW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Oct 2023 11:32:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F12184;
        Wed, 25 Oct 2023 08:32:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E660C433C9;
        Wed, 25 Oct 2023 15:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698247940;
        bh=AVTx5lQPYgHLSGJTavoq8CVU+uCf50DO877w8nwruKw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IDiW4LCq64gwOm+NPf+IdH3/9FQ7h8d1HEV/pMTrn3hEOHM/hizw/2uNax/tWaIkF
         Eeo+7pX+QI4CPV4RTlkfr6+3CwkO2vXWsnN2diDyVx3y7rs8Oc+sgoMn6IJdt6dgcf
         3vEmmfr0tw4KWMBYURBVvbxEFdO9938DuhJzkC0C5ws1gGKcT45LcqWAuAFnAZk16a
         9wgKk9mVTEOewdthjFnljrRu3kqmp1iWTf1pC6tAkoPTKPboD0Iatp0Q8ZksrwyIbN
         h9fPGJulCjCybjbBupfHm/1YeZg4ajkdDATl3lqPXBFB9k8H3cecW1qH/wgLA+rMdr
         z9p26TrVjnP5A==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9ba081173a3so919042966b.1;
        Wed, 25 Oct 2023 08:32:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YzyUJNjQS+WjmKenurqQ95r+v4xpOJPsvlhM7KPMrcAZqq/66y4
        kYZda0ToOtor8IZdTcHrmgp2950pNqqBkWj4XJ0=
X-Google-Smtp-Source: AGHT+IFBjoUUVvhkSZ016wtYSOPQNixEa20PoYMyEiijmi/iAUFVe89Ix6wUtRlXO1ywRbbWhMNwsORR5UjYc7NkhuI=
X-Received: by 2002:a17:907:d86:b0:9be:b7da:72d6 with SMTP id
 go6-20020a1709070d8600b009beb7da72d6mr12752191ejc.63.1698247938904; Wed, 25
 Oct 2023 08:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <39311089b30f9250ff7f7a0aabb70547616a4b3a.1698230869.git.anand.jain@oracle.com>
In-Reply-To: <39311089b30f9250ff7f7a0aabb70547616a4b3a.1698230869.git.anand.jain@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 25 Oct 2023 16:31:42 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Yg6bv1pKjA6dVjgr45Z=-YkDzcr3RzaV284d8uLxAdg@mail.gmail.com>
Message-ID: <CAL3q7H6Yg6bv1pKjA6dVjgr45Z=-YkDzcr3RzaV284d8uLxAdg@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/219 cloned-device mount capability update
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 25, 2023 at 11:51=E2=80=AFAM Anand Jain <anand.jain@oracle.com>=
 wrote:
>
> This test case originally checked for failed cloned device mounts, which
> is no longer relevant after the commit a5b8a5f9f835 ("btrfs: support
> cloned-device mount capability"). So removing the obsolete part.
>
> For older kernels without this commit, the test case still serves its cor=
e
> purpose.
>
> Additionally, add this test case back to the auto group which reverts the
> commit e2e7b549380a ("fstests: btrfs/219: remove it from auto group") sin=
ce
> the previously missing kernel commit 5f58d783fd78 ("btrfs: free device in
> btrfs_close_devices for a single device filesystem") has already been
> integrated.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202310251645.5fe5495a-oliver.sang@=
intel.com
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/219 | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/tests/btrfs/219 b/tests/btrfs/219
> index b747ce34fcc4..44296c119b0a 100755
> --- a/tests/btrfs/219
> +++ b/tests/btrfs/219
> @@ -12,7 +12,7 @@
>  #
>
>  . ./common/preamble
> -_begin_fstest quick volume
> +_begin_fstest auto quick volume
>
>  # Override the default cleanup function.
>  _cleanup()
> @@ -79,15 +79,6 @@ _mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
>         _fail "Failed to mount the second time"
>  $UMOUNT_PROG $loop_mnt
>
> -# Now we definitely can't mount them at the same time, because we're sti=
ll tied
> -# to the limitation of one fs_devices per fsid.
> -_btrfs_forget_or_module_reload
> -
> -_mount $loop_dev $loop_mnt > /dev/null 2>&1 || \
> -       _fail "Failed to mount the third time"
> -_mount -o loop $fs_img2 $loop_mnt1 > /dev/null 2>&1 && \
> -       _fail "We were allowed to mount when we should have failed"
> -

For kernels without the cloned-device feature, it's useful to still
test this... We want to catch regressions on stable releases and
downstream (distros).
Rather than removing this code, I would rather run the code only if
the kernel does not support the feature (file
/sys/fs/btrfs/features/temp_fsid does not exist).

Thanks.

>  _btrfs_rescan_devices
>  # success, all done
>  echo "Silence is golden"
> --
> 2.31.1
>

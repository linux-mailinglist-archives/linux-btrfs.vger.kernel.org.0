Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0764A7DBDE4
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 17:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjJ3QcV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbjJ3QcU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 12:32:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AFA98
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 09:32:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3E2C433C8;
        Mon, 30 Oct 2023 16:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698683538;
        bh=xoxfKa9y63niUeggGxXd1IegRB6k2cPicO5WzBVYPjw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bbG91XNH6girzMkjvtN7HwfEo9e5/X5f3iXXA+gmPtQbgypensVW6/lnfIBTtQclv
         cLKGqNF0lbHn395FxfualyYtR05E2c9hd4N+Tuyfe1OT18oJkgRC/8I0AWRCzAAAXm
         k0hvBHBps0QPbZqDpSIrd0hHCnyGZdo1M4x7wb0LhGhFyDWw/La+OBDD0dP5EOuJUz
         URjR+jzXRMyqCg0+XzLZoAo5pPIzxngy6D6Fyo33ET87bBuGLPFtMeziYuELiJaz2z
         JeyP+8sl5cxuex7hHlR98hhbeVabVbC7KrFWieSbF+En9i6k8afdsrRv2ROJZFysW4
         rZH7ND1dv1pZg==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso455016866b.1;
        Mon, 30 Oct 2023 09:32:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YwI+WOT/yCx1UaLydsCCLZJn5K5dxO0J8QGpVHekBNLEkZMjrjP
        fJyhf3c3pXvgqMzl9pJPtMBo+FYyPwfCnXmqtOg=
X-Google-Smtp-Source: AGHT+IFFfCc4cfSKyaAXA/i+hg7/RIvIk2aqu1nLF19WjA7UInPPUffiJWMsrfREHdowkFAzV5ineTA1mdf/naruT7A=
X-Received: by 2002:a17:907:7b96:b0:9bd:fc4b:6c9b with SMTP id
 ne22-20020a1709077b9600b009bdfc4b6c9bmr9564370ejc.36.1698683536501; Mon, 30
 Oct 2023 09:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698674332.git.anand.jain@oracle.com> <63f926ab53abb279fa0a836bd1391baaf308afc4.1698674332.git.anand.jain@oracle.com>
In-Reply-To: <63f926ab53abb279fa0a836bd1391baaf308afc4.1698674332.git.anand.jain@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 30 Oct 2023 16:31:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5ozNpdrzMBWttj=Zu1gdbWHWZ0hYPK75_qmoiHP3C-Fw@mail.gmail.com>
Message-ID: <CAL3q7H5ozNpdrzMBWttj=Zu1gdbWHWZ0hYPK75_qmoiHP3C-Fw@mail.gmail.com>
Subject: Re: [PATCH 5/6 v3] btrfs/219: cloned-device mount capability update
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
> This test case checks for failure of the cloned device mounts, which
> is no longer true after the commit a5b8a5f9f835 ("btrfs: support
> cloned-device mount capability"). So check for the non-presence the
> temp-fsid feature and do not test for the failure of the cloned device
> mount.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202310251645.5fe5495a-oliver.sang@=
intel.com
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>
> v3: check only that mount of clone device fails if temp-fsid is not
> supported.
>
>  tests/btrfs/219 | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/tests/btrfs/219 b/tests/btrfs/219
> index 44a4c79dc05d..3c414dd9c2e0 100755
> --- a/tests/btrfs/219
> +++ b/tests/btrfs/219
> @@ -51,6 +51,7 @@ loop_dev2=3D""
>
>  _require_test
>  _require_loop
> +_require_btrfs_fs_sysfs
>  _require_btrfs_forget_or_module_loadable
>  _fixed_by_kernel_commit 5f58d783fd78 \
>         "btrfs: free device in btrfs_close_devices for a single device fi=
lesystem"
> @@ -88,14 +89,16 @@ _mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
>         _fail "Failed to mount the second time"
>  $UMOUNT_PROG $loop_mnt1
>
> -# Now we definitely can't mount them at the same time, because we're sti=
ll tied
> -# to the limitation of one fs_devices per fsid.
> +# Now try mount them at the same time, if kernel does not support
> +# temp-fsid feature then mount will fail.
>  _btrfs_forget_or_module_reload
>
>  _mount $loop_dev1 $loop_mnt1 > /dev/null 2>&1 || \
>         _fail "Failed to mount the third time"
> -_mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 && \
> -       _fail "We were allowed to mount when we should have failed"
> +if ! _has_btrfs_sysfs_feature_attr temp_fsid; then
> +       _mount $loop_dev2 $loop_mnt2 > /dev/null 2>&1 && \
> +               _fail "We were allowed to mount when we should have faile=
d"
> +fi
>
>  _btrfs_rescan_devices
>  # success, all done
> --
> 2.39.3
>

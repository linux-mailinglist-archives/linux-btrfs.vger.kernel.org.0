Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789E0697A46
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 11:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbjBOK4J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 05:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjBOK4J (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 05:56:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918402594D;
        Wed, 15 Feb 2023 02:56:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D67961B2D;
        Wed, 15 Feb 2023 10:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9279FC4339B;
        Wed, 15 Feb 2023 10:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676458565;
        bh=pTfJ1BvekKgRdtYZqsmJvdhXW7vJyQgwsJknSkCETwA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=shGoIv0Ymt2Br9BMo8UcyA40b/FqVEoOsxyB9FTZcaQ3MZY2ZIPYcElScRZMqUOx+
         VoimOpDbkFwA/0WK4HyM/p1ZEQhoH4ucggJ3HhLGHWwg9s25IhP01LUAbMMpgtSQzn
         tGtLqFwvaM6behMswMEE+zJnzvlVLdSfUxudhrxFXFADJWxuWePBLWlM3mXByWif6D
         YNWu4pu0E+OjMI+pt7vAsgpgEXQGjBgqeS8IbZEzlc9PZAT/cbz2dRjZlCqpfe0k4C
         7vLOtibR2kL1jdzMddejX/DfgaK8TTQSHKa9grPsPcb0Ye/rq3t3YryFtL8pIdyDRU
         FjkqxT8fiHqYw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-169ba826189so22473462fac.2;
        Wed, 15 Feb 2023 02:56:05 -0800 (PST)
X-Gm-Message-State: AO0yUKV/R+QpUdTu1r9eExrUt7+Zx56Av38TK6NglQj10+UEJpvgLjiU
        2qW7NBEJtsWY6nX3Foo1rc//t+WfqgVS+uytmsQ=
X-Google-Smtp-Source: AK7set9YagfAin1VUUtzpUw0twQe5ryJf01OHxUzGD9QRIsA5gwDBQ9nFgW1PM3hBDqa1/BC/Vw2ue0G9/i8tUCNX4A=
X-Received: by 2002:a05:6871:a817:b0:16d:c3e5:9a5a with SMTP id
 wl23-20020a056871a81700b0016dc3e59a5amr141964oab.117.1676458564680; Wed, 15
 Feb 2023 02:56:04 -0800 (PST)
MIME-Version: 1.0
References: <a9970cfc5eef360f6eff8cd24b41f50c07c1d744.1676207936.git.anand.jain@oracle.com>
 <75cbde02c45a75268b19dc8091a3af13ca1c2903.1676393253.git.anand.jain@oracle.com>
In-Reply-To: <75cbde02c45a75268b19dc8091a3af13ca1c2903.1676393253.git.anand.jain@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 15 Feb 2023 10:55:28 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6e0aPfx32q847X4jfH6BS6ox_rTY=ypT9f7jaFRTU6-A@mail.gmail.com>
Message-ID: <CAL3q7H6e0aPfx32q847X4jfH6BS6ox_rTY=ypT9f7jaFRTU6-A@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs/249: add _wants_kernel_commit
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, zlang@redhat.com,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 15, 2023 at 7:54 AM Anand Jain <anand.jain@oracle.com> wrote:
>
> Add the _wants_kernel_commit tag for the benifit of testing on the older
> kernels.

And the _fixed_by_git_commit tag for btrfs-progs too.
The subject is also no longer up to date too.

s/benifit/benefit/

Otherwise looks good, thanks

Reviewed-by: Filipe Manana <fdmanana@suse.com>


>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v2: Include the necessary btrfs-progs patch.
>
>  tests/btrfs/249 | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tests/btrfs/249 b/tests/btrfs/249
> index 7cc4996e387b..06cc444b5d7a 100755
> --- a/tests/btrfs/249
> +++ b/tests/btrfs/249
> @@ -12,9 +12,6 @@
>  #  Create a sprout filesystem (an rw device on top of a seed device)
>  #  Dump 'btrfs filesystem usage', check it didn't fail
>  #
> -# Tests btrfs-progs bug fixed by the kernel patch and a btrfs-prog patch
> -#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
> -#   btrfs-progs: read fsid from the sysfs in device_is_seed
>
>  . ./common/preamble
>  _begin_fstest auto quick seed volume
> @@ -29,6 +26,10 @@ _supported_fs btrfs
>  _require_scratch_dev_pool 3
>  _require_command "$WIPEFS_PROG" wipefs
>  _require_btrfs_forget_or_module_loadable
> +_wants_kernel_commit a26d60dedf9a \
> +       "btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device"
> +_fixed_by_git_commit btrfs-progs xxxxxxxxxxxx \
> +       "btrfs-progs: read fsid from the sysfs in device_is_seed"
>
>  _scratch_dev_pool_get 2
>  # use the scratch devices as seed devices
> --
> 2.31.1
>

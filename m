Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6986944EB
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Feb 2023 12:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjBML5e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Feb 2023 06:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBML5d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Feb 2023 06:57:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BDA13D45;
        Mon, 13 Feb 2023 03:57:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A5F4B811A1;
        Mon, 13 Feb 2023 11:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3B7C433EF;
        Mon, 13 Feb 2023 11:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676289449;
        bh=ITlg5a26rbe4LZGTydmCKHk7uPqfMEri3iYSlpcB7Eo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XUTbavavSUfBpa6dsV2kyfcrtqEWpRZYp+DjkNrkL6Ot5RLeJfBnFgK+VjgyYafzM
         okOwJNAmqCgXePk81MuZrcPAbAv1/PgsAGycxBBI792vE9BvgSZ9rBOR3oxhah2NZt
         RbA4eg1VTmmVNmSsdm6qdfuzQ90rBlyVpOnovbeKmyfzpk/Qb36KM+/BBTTG7i7RdR
         lmRI5eRhZk+8f6w56wJEJcgACEzsciJysRo9qgtNzpUNKD89Q26Su9+T6nWtfI5NOI
         w9OF5IJtEFo8BH9PCztvVeQvHGAtHQ1vjWbkygI5bq6BMB2GJwAF1EDwJ3OHtdxHQg
         7fJlvTHiPtWkQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-16346330067so14879316fac.3;
        Mon, 13 Feb 2023 03:57:29 -0800 (PST)
X-Gm-Message-State: AO0yUKUXEIbiXTLHuV8pNM4w9CX4+SLgE0FSJ9EiqoW1T8Ylq8GsOSeg
        zeKaW1BBLILT3tk1P36Qozg5GXLLWBuQdBQsvY0=
X-Google-Smtp-Source: AK7set8p7O9L/ozo7j5KneKYDitUtwTkYtMuiHXlGO9NZw8tI74bj9dzIDrBJIANMmnGX6eOQI68cBLs/gj1SCzx0oQ=
X-Received: by 2002:a05:6870:3288:b0:16e:11dc:2513 with SMTP id
 q8-20020a056870328800b0016e11dc2513mr186935oac.98.1676289448890; Mon, 13 Feb
 2023 03:57:28 -0800 (PST)
MIME-Version: 1.0
References: <a9970cfc5eef360f6eff8cd24b41f50c07c1d744.1676207936.git.anand.jain@oracle.com>
In-Reply-To: <a9970cfc5eef360f6eff8cd24b41f50c07c1d744.1676207936.git.anand.jain@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 13 Feb 2023 11:56:52 +0000
X-Gmail-Original-Message-ID: <CAL3q7H59UW_=wBo0HW97+RNUHPt0+3FxEN7aCT_dx6bzarFDyg@mail.gmail.com>
Message-ID: <CAL3q7H59UW_=wBo0HW97+RNUHPt0+3FxEN7aCT_dx6bzarFDyg@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/249, add _wants_kernel_commit
To:     Anand Jain <anand.jain@oracle.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 13, 2023 at 9:58 AM Anand Jain <anand.jain@oracle.com> wrote:
>
> Add the _wants_kernel_commit tag for the benifit of testing on the older
> kernels.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/249 | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/249 b/tests/btrfs/249
> index 7cc4996e387b..1b79e52dbe05 100755
> --- a/tests/btrfs/249
> +++ b/tests/btrfs/249
> @@ -13,7 +13,7 @@
>  #  Dump 'btrfs filesystem usage', check it didn't fail
>  #
>  # Tests btrfs-progs bug fixed by the kernel patch and a btrfs-prog patch
> -#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
> +#   btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device
>  #   btrfs-progs: read fsid from the sysfs in device_is_seed
>
>  . ./common/preamble
> @@ -29,6 +29,8 @@ _supported_fs btrfs
>  _require_scratch_dev_pool 3
>  _require_command "$WIPEFS_PROG" wipefs
>  _require_btrfs_forget_or_module_loadable
> +_wants_kernel_commit a26d60dedf9a \
> +       "btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device"

There's a btrfs-progs patch listed above, so you can also add a:

 _fixed_by_git_commit btrfs-progs xxxxxxxxxxxx "btrfs-progs: read fsid
from the sysfs in device_is_seed"

And with that, you can then remove the comment above with the patch
subjects, as it becomes redundant and pointless.

Thanks.

>
>  _scratch_dev_pool_get 2
>  # use the scratch devices as seed devices
> --
> 2.31.1
>

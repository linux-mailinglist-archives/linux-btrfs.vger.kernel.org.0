Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC85836D981
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 16:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbhD1OYI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 10:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbhD1OYF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 10:24:05 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2006EC061573
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 07:23:20 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id j84so4450508ybj.9
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A1kDfbi8lY+rx92PDuX6gzpOkuWJoEPhRwo4qmLKzxQ=;
        b=PliGppYaPkZgG2FhXiQPCeO5oikC+InYg2n5TRz/2xvRtv97gsp+Cu9Qd6JnK1B+8P
         DXH0PDA9mItSjDD1lNJq6I8QeVQD2sgiMqOlXJiop/ibsSLoeqIrfQgcltqdcrSrTsKI
         nCV9/p5CcJwS+iDJi2k/cHndfDrF5p7B1j81xn90xPzLyjaWWug0brSyMWk8AYC8KeSs
         CmJ3yC/3G5pse7T8W3akpa2wUD+/pAfcN19v/SSTg+qam9zxst2NAze6/XESA1gHwCOA
         TjVPvyVhkx9DoNl9qMHytkQAswUlKVgiG1zOldGyuZzcbrHCCDwMpQ44iM8XZIrgNNdb
         aiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A1kDfbi8lY+rx92PDuX6gzpOkuWJoEPhRwo4qmLKzxQ=;
        b=Xrtcg1+5tYulNTWinJiBIjfhOIGLm+pGXvMndbZSuBv9gsAFd4dsABtgETMNHharlf
         P2l0r8tLfbhShjpVfYTbHCo1MWtF6b8u//7yE9jd151Sqpdh+GT2zGr9O364e/Wl+fOG
         xR5p2La26eZEnsVpk+qovQvkS+dILonirXD1rcNPqKw4bq8mJ9vaa+7hoYwc78tDBwL+
         Mt+MqI4cyedxDsRkzDML+nqEhYaGmfyny8YELSRYVqLrdfysjZ8maNjTzkiIxi/czebE
         JFM7FGcQSyEzmE8mUnaxO3+ttcyHsvjFDKJgJrQgkYOCljYCjyHRBkxScFA7aI3Y4rGT
         hauA==
X-Gm-Message-State: AOAM532z9vAwWCB+45iixFr5nNFdZU+9UitjO6/1Nez0N7dtaYNCAoUY
        qUjRe5IudCOTfmd+6lCsYnrZYRgj/TiaO0fiIsc/PEliWI4=
X-Google-Smtp-Source: ABdhPJx1527bPYL54wOTU4wHxAhu5YYSNQlY1G7CCVg9X2Cyz6ZmIRmXomttX8oeUUnnL7bp/gu+jfLj5IjqGIpWoco=
X-Received: by 2002:a25:32c6:: with SMTP id y189mr41378700yby.184.1619619799222;
 Wed, 28 Apr 2021 07:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210427230349.369603-1-wqu@suse.com> <20210427230349.369603-40-wqu@suse.com>
In-Reply-To: <20210427230349.369603-40-wqu@suse.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 28 Apr 2021 10:22:43 -0400
Message-ID: <CAEg-Je-Q4FfbjipyxZnHVrhyzx9kp_gv=s3Cb1v3q0LkRevqvQ@mail.gmail.com>
Subject: Re: [Patch v2 39/42] btrfs: reject raid5/6 fs for subpage
To:     Qu Wenruo <wqu@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 27, 2021 at 7:06 PM Qu Wenruo <wqu@suse.com> wrote:
>
> Raid5/6 is not only unsafe due to its write-hole problem, but also has
> tons of hardcoded PAGE_SIZE.
>
> So disable it for subpage support for now.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/disk-io.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c9a3036c23bf..e6b941932a2b 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3407,6 +3407,16 @@ int __cold open_ctree(struct super_block *sb, stru=
ct btrfs_fs_devices *fs_device
>                         goto fail_alloc;
>                 }
>         }
> +       if (sectorsize !=3D PAGE_SIZE) {
> +               if (btrfs_super_incompat_flags(fs_info->super_copy) &
> +                       BTRFS_FEATURE_INCOMPAT_RAID56) {
> +                       btrfs_err(fs_info,
> +       "raid5/6 is not yet supported for sector size %u with page size %=
lu",
> +                               sectorsize, PAGE_SIZE);
> +                       err =3D -EINVAL;
> +                       goto fail_alloc;
> +               }
> +       }
>
>         ret =3D btrfs_init_workqueues(fs_info, fs_devices);
>         if (ret) {
> --
> 2.31.1
>

Couldn't this be restricted to ro-only safely?


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

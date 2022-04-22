Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15CB50B5F0
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Apr 2022 13:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447006AbiDVLOu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Apr 2022 07:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446686AbiDVLOr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Apr 2022 07:14:47 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FDF53A77;
        Fri, 22 Apr 2022 04:11:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u15so15647242ejf.11;
        Fri, 22 Apr 2022 04:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ckJ2PtJm72g5syOBFNN3wDr8qwL96QcVpgUdvrmCb5Q=;
        b=jF4PE8PMvQysZcf0u96ctJK61CELY4ARRb1CVixpIo826b7nq3oah72n8D2iIdybjm
         bVfXngBH+WIdwjYFPqS7mJvx8ymDfT7bnFg/gN2TOoLG1gHaBLjudte7zYJxOF7lpegH
         aHf4sLWvKNV6ejVZtBhK8V4NEtQgWxQNqHkXr2sgVVeJ+VqLlCgW4aGMfDQItSCD+2k5
         Dya1o+iWHwgXnzhBbzVJqyKxD3fxG6iu2R+L2f3SaUvVH+nouHZznptDVi5EbsEdS3jy
         4lEfMjqMLxt45bSqBh/F7GETJKF0Htyc0woBU4aW211of+Fx3GFfcJgSyo3mMKbhLaEO
         tVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ckJ2PtJm72g5syOBFNN3wDr8qwL96QcVpgUdvrmCb5Q=;
        b=zlIKhm+vEBBv/sliMbJQfD4C+x4pcom9Pd+cRC8tUBxqZHJ4cluy2WUOenZMzHVSiT
         QLwzZjZsa/mHDFufgtV5kI9Dw3S2fypi1N8jpCwKFbzxiZZ85x6gsz3LcwPQ6wlwJ9Sw
         cunMiSA6z+UeTjpO0+30b+aRh+eSsjJMdYBqVFgzDBwHsDewNm/Xyz2dGsvGp2DAcuyj
         mL979aAaM6Gf29yQBfI/r+dKnfAHueF+IP7X+pVhDvJX2FpvP7v3xshMAOlyEuXdjfz/
         YFkJXaweGyv4Fk2IRS9OCXaIniO8h17WrimDyBewAwNhi4gHTJmljb1lF9+L7TV2EmRc
         vaDA==
X-Gm-Message-State: AOAM532LoepxdSlDZ+Y+W+yB+SWOczLysP6YjFYh57qHj4PQjhj2ix2S
        Q9OzsznBPhTpc7x4kMPXZK8Sq5vOXLmuZXsr9k4=
X-Google-Smtp-Source: ABdhPJzRaD40/rBGnWxl6FisIhHH9AbO0EkjHvg7QHEsCq7aDbibc8MoppDsPgnTEfIxQF7vpX7h3hUYqfLYrB/xLl0=
X-Received: by 2002:a17:907:209c:b0:6e8:807c:cdf0 with SMTP id
 pv28-20020a170907209c00b006e8807ccdf0mr3773078ejb.256.1650625912967; Fri, 22
 Apr 2022 04:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220418075430.484158-1-cccheng@synology.com> <Yl7MsVxpaYWfIEZH@debian9.Home>
In-Reply-To: <Yl7MsVxpaYWfIEZH@debian9.Home>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Fri, 22 Apr 2022 19:11:42 +0800
Message-ID: <CAHuHWtnCxSgh+JOOHhPQc_4A0f9O6DCXUz3vBVZg6riOQg01FA@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: test setting compression via xattr on
 nodatacow files
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>, fstests@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>, nborisov@suse.com,
        David Sterba <dsterba@suse.com>, kernel@cccheng.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Filipe,

> > +_require_scratch
> > +_require_chattr C
> > +_require_chattr c
>
> This require, for chattr c, is not needed, since the test never calls
> chattr with +c or -c.
>
> It also misses a call to:
>
> _require_attrs
>
> Due to the calls to setfattr and lsattr.

Thanks for your notification. I'll fix these issues.


> root 15:43:50 /home/fdmanana/git/hub/xfstests (master)> diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/264.out /home/fdmanana/git/hub/xfstests/results//btrfs/264.out.bad
> --- /home/fdmanana/git/hub/xfstests/tests/btrfs/264.out 2022-04-19 14:49:03.845696283 +0100
> +++ /home/fdmanana/git/hub/xfstests/results//btrfs/264.out.bad  2022-04-19 15:43:50.413816742 +0100
> @@ -1,9 +1,9 @@
>  QA output created by 264
>  SCRATCH_MNT/foo ---
>  SCRATCH_MNT/foo Compression_Requested
> -SCRATCH_MNT/foo ---
> +SCRATCH_MNT/foo Dont_Compress
>  SCRATCH_MNT/foo Compression_Requested
> -SCRATCH_MNT/foo ---
> +SCRATCH_MNT/foo Dont_Compress
>  SCRATCH_MNT/foo Compression_Requested
>  SCRATCH_MNT/bar No_COW
>  setfattr: SCRATCH_MNT/bar: Invalid argument
> root 15:43:52 /home/fdmanana/git/hub/xfstests (master)>
>
> So the test needs to be updated and tested on a recent kernel.
> Other than that, it looks fine to me.

I can see why my output is different from yours. I tested this item with
the latest upstream kernel, but my `chattr` comes from e2fsprogs-1.45.5,
which does not yet support Dont_Compress. This test relies on a recent
chattr, but `_require_attrs` does not check its version. In any case, I
will send a v2 patch based on the latest chattr.

Thanks.

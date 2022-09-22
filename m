Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9DA5E5F36
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 12:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiIVKCK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 06:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiIVKBu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 06:01:50 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54131B5A65
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 03:01:36 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id l7-20020a056830154700b0065563d564dfso5887271otp.0
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 03:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date;
        bh=Js/9fDmlYiF51DNvS/MFYC/rhe6gmRIk17hlA52PAaU=;
        b=NqaZEh5NeRtPR/Yn3WMzSS3cpE9jh83IpRprkCVtKeE3+r89ou6rdM8VX4nz/L8saD
         bf9ZrdpcrsAfZ2K0lKQ+iPYXvf0/+6oAoIASW75VuINOyHgzD0gXrEO3hVXSvQj2CYZ4
         k81pL7sFs6w+ar+ITyMPNj4NvFDU9Wu7NAlXRhpaNIdcXAQBVDAUTJHeCH32rYfq8oVY
         wWZ4YCMgK7jZqeGApD3SraC6wRf5rHxP+vDt8O3r+W6YMkB7CVsrmYAfLsDHOTPdZvDk
         PfJUOtdslKr8IHy6uGKcpj/fJzBvdpUSHtWTbgQLHHZmRsJowQZfdFPn5Hc/xVLbxGwp
         Xgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Js/9fDmlYiF51DNvS/MFYC/rhe6gmRIk17hlA52PAaU=;
        b=N7bxa2JivXHh94SQxtxn2Si0hkT1LxO5IJ8TCOppn/kLneFmR/BO90eZ3ZxnISxGeC
         KA7So4nhS9edNamB0W5ntXB5/E+fvpbBPmYxPm1f7SXq6zKvzqSsWmT26Hkjb136KuK1
         7gpyVY8DPVddVfm0nU9qGvV/7o+WUIajq/vAgWvuALapn4LC5QrZvMRWvvpJTU1YDYxH
         H/EGso57XRW6t6pgMqRPrREYIfc8gF6G4gsqW7/XpwNjyKawzDJGPHeJVnrWat90tQyx
         ULp0unF7wO1cN8mLmeKOze7+QplNbCy3WCrlxQBONaFr3xagj+Y7R290pkgv2O7pkStL
         JgZw==
X-Gm-Message-State: ACrzQf2PIBDDSb5GVYmKjvwIcE2nvkbxIMj7eYSWk2HMJwKy2GgK0+gX
        jJM7XuEJpdu+Rk600I5SFXRIyUh+FHTS1IJH8mY+MfWE
X-Google-Smtp-Source: AMsMyM4lL54a3YTIvxXL2n+RV21vC2nIQ4BzbWPXQMqAfNuRm+Q42J7hM5kaz3zDvMzuxbzdKoL3DnptqLsNYv6HxE4=
X-Received: by 2002:a05:6830:651c:b0:659:185a:10d7 with SMTP id
 cm28-20020a056830651c00b00659185a10d7mr1232659otb.363.1663840895500; Thu, 22
 Sep 2022 03:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660299977.git.anand.jain@oracle.com> <3eb88dc3914667123ebb0823bbab9e07b24cf099.1660299977.git.anand.jain@oracle.com>
In-Reply-To: <3eb88dc3914667123ebb0823bbab9e07b24cf099.1660299977.git.anand.jain@oracle.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 22 Sep 2022 11:00:59 +0100
Message-ID: <CAL3q7H4ro3zAzt8vY3XEd-tO4XdxjgnMageeeoLX29=bewGpyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix assert during replace-cancel of suspended replace-operation
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 12, 2022 at 11:56 AM Anand Jain <anand.jain@oracle.com> wrote:
>
> If the filesystem mounts with the replace-operation in a suspended state
> and try to cancel the suspended replace-operation, we hit the assert. The
> assert came from the commit fe97e2e173af ("btrfs: dev-replace: replace's
> scrub must not be running in suspended state") that was actually not
> required. So just remove it.
>
>  $ mount /dev/sda5 /btrfs
>
>     BTRFS info (device sda5): cannot continue dev_replace, tgtdev is miss=
ing
>     BTRFS info (device sda5): you may cancel the operation after 'mount -=
o degraded'
>
>  $ mount -o degraded /dev/sda5 /btrfs <-- success.
>
>  $ btrfs replace cancel /btrfs
>
>     kernel: assertion failed: ret !=3D -ENOTCONN, in fs/btrfs/dev-replace=
.c:1131
>     kernel: ------------[ cut here ]------------
>     kernel: kernel BUG at fs/btrfs/ctree.h:3750!
>
> After the patch:
>
>  $ btrfs replace cancel /btrfs
>
>     BTRFS info (device sda5): suspended dev_replace from /dev/sda5 (devid=
 1) to <missing disk> canceled

Anand, can you please add a test case to fstests?
This is a scenario with no coverage at all in fstests, therefore
specially useful to have it there.

Thanks.

>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/dev-replace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 488f2105c5d0..9d46a702bc11 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -1124,8 +1124,7 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *=
fs_info)
>                 up_write(&dev_replace->rwsem);
>
>                 /* Scrub for replace must not be running in suspended sta=
te */
> -               ret =3D btrfs_scrub_cancel(fs_info);
> -               ASSERT(ret !=3D -ENOTCONN);
> +               btrfs_scrub_cancel(fs_info);
>
>                 trans =3D btrfs_start_transaction(root, 0);
>                 if (IS_ERR(trans)) {
> --
> 2.33.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068E47DCBE3
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 12:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343766AbjJaLes (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Oct 2023 07:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343751AbjJaLer (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Oct 2023 07:34:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E2EC2
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Oct 2023 04:34:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144E6C433C9;
        Tue, 31 Oct 2023 11:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698752083;
        bh=PhQNq2XVIR+wGCY7x8vRbmP8syUCby8FlsitCoVSvVE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RRL++muWvTD00V2U0A4JAArjBIo5ZmFY6HR7I4mhNdv3uKAeehUKkhL6gBvMC1llQ
         R8HtvBD2F/LoNhPuDCnlvhJNAyzZfOwh9u148X36m7d7qHUHQ07/UVOZUHW/8Nupeq
         gh50yS6Iop5XyeHGw+auTgbreT7aAEFNgM7vvlRilJbXKgZ7hgogwc9DCiU4m7qBka
         TX5k+oKFfNupiRLVYR9wLo4GnwxO6YyL9h6absTm9V+CPFFhZ5+xj5xfIvj7Wkkqj6
         /uUxC22bxPPGDlfe0p53EUASUuZI9jB7zpq/AmVDiwxhHlox2lKmLJfUc86D4ntd6h
         Xuc1o23RAHB9Q==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso9064872a12.2;
        Tue, 31 Oct 2023 04:34:42 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx6RKAfNl29V91pnXmr5QRoia3PB3OJq008diFEA+DrnqeKaXwx
        KaPDc114N/t0sYawrFln0bnyPS9ekZb86QjvOTM=
X-Google-Smtp-Source: AGHT+IGTQz+O47doMB+bRP19+Y137xdGNJR8IQsPVj7U/5hBf7CVZbcpAkpRoI8OZMJgUVc3CT/ZQRqUvMfZVsx2cdk=
X-Received: by 2002:a17:907:a49:b0:9be:834a:f80b with SMTP id
 be9-20020a1709070a4900b009be834af80bmr10805539ejc.75.1698752081512; Tue, 31
 Oct 2023 04:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698674332.git.anand.jain@oracle.com> <077b252e8affc50ad3d7826d57ba42a2a8746d13.1698674332.git.anand.jain@oracle.com>
 <CAL3q7H7zgJ68UpK3+CiJBtFJC5JoUiXGV6rcpEMVg9ae=omByw@mail.gmail.com> <3fef3451-2a09-4c1d-a096-5b55a9245107@oracle.com>
In-Reply-To: <3fef3451-2a09-4c1d-a096-5b55a9245107@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 31 Oct 2023 11:34:04 +0000
X-Gmail-Original-Message-ID: <CAL3q7H76Ookt_0cDNDMHLgbBSe3bwQnDAxYKZsRJvTdMonmB7Q@mail.gmail.com>
Message-ID: <CAL3q7H76Ookt_0cDNDMHLgbBSe3bwQnDAxYKZsRJvTdMonmB7Q@mail.gmail.com>
Subject: Re: [PATCH 3/6 v3] common/btrfs: add helper _has_btrfs_sysfs_feature_attr
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

On Mon, Oct 30, 2023 at 11:30=E2=80=AFPM Anand Jain <anand.jain@oracle.com>=
 wrote:
>
>
> >> +_has_btrfs_sysfs_feature_attr()
> >> +{
> >> +       local feature_attr=3D$1
> >> +
> >> +       [ -z $feature_attr ] && \
> >> +               _fail "Missing feature name argument for _has_btrfs_sy=
sfs_attr"
> >> +
> >> +       modprobe btrfs &> /dev/null
> >> +
> >> +       test -e /sys/fs/btrfs/features/$feature_attr
> >> +}
> >
> > We already have _require_btrfs_fs_feature() to do exactly this.
> > Tried it in patch 5/6 and it works perfectly...
>
> I noticed that. But, _require_btrfs_fs_feature() triggers _notrun()
> when the feature is absent in the kernel. Given our need to run the
> testcase with and without temp-fsid, it is not suitable.

Yes, nevermind. It's fine then.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

>
> Thanks, Anand
>

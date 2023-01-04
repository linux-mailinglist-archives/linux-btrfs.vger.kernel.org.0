Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4828265D497
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jan 2023 14:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjADNmc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Jan 2023 08:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239305AbjADNma (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Jan 2023 08:42:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A74101F4
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Jan 2023 05:42:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C24836173B
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Jan 2023 13:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EDDC433D2
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Jan 2023 13:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672839748;
        bh=BODX/38UB+T/HJqPkLqmiWIaxzo2xATo09Q+G39/Vzk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NBDfN4cT4550BMgJ4ZSI+9EW+3bR4wDCHlcRPp8+68KAaqHJYgNXkySZcxsjwbayY
         XYGuZ+ljfR9ASGPmi0fE3gofiMFOmI5UQnjiLTaOi4JwG/UgbA2CENwhNeXHgxiJ/p
         D0OL4mZc4gEU706A+PGv8ah4j2873NzVap9H1dlxVTBRyfw+2JW0LQGtpMHXX1tRfx
         DrnJ9rNfwJiODEIctSQoghxKveDVIa5lugMKCvekhi/O9KQjDVSaP/Hzd+Ti6Pq0Tz
         DI5oipOdjvG7svNuJNgWARMDDLFHU7EetUSNZvCtglbUMLJsrIu7io1Lkp3gvfuQDa
         izYSAdThI5b0g==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-14fb3809eaeso33900350fac.1
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Jan 2023 05:42:28 -0800 (PST)
X-Gm-Message-State: AFqh2kqukG9d/N7kec/suPVe2MvjgonsITTsx3/waM7MdkzYZdR+Uze+
        +ZG7bH2tx+a4g+R8mBaYQN0jEx7LbRuYlCsYWWA=
X-Google-Smtp-Source: AMrXdXv7CEf2Wi0DFo63tJX3dwQ00kLVvUZ6tZbouAH5orT0QgpEq2V9BrlTwkgwo0SzjDzbq7++IRackTAWUJSlhms=
X-Received: by 2002:a05:6870:9f86:b0:14c:667e:4620 with SMTP id
 xm6-20020a0568709f8600b0014c667e4620mr2204521oab.92.1672839747254; Wed, 04
 Jan 2023 05:42:27 -0800 (PST)
MIME-Version: 1.0
References: <b732e1e7-7b3a-cfa7-1345-d39feaa6a7a8@posteo.de>
In-Reply-To: <b732e1e7-7b3a-cfa7-1345-d39feaa6a7a8@posteo.de>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 4 Jan 2023 13:41:51 +0000
X-Gmail-Original-Message-ID: <CAL3q7H72Z7v038psf9rPSjfWn96WDbxpbRx_73HAPvzzV4SB8g@mail.gmail.com>
Message-ID: <CAL3q7H72Z7v038psf9rPSjfWn96WDbxpbRx_73HAPvzzV4SB8g@mail.gmail.com>
Subject: Re: btrfs send and receive showing errors
To:     =?UTF-8?Q?Randy_N=C3=BCrnberger?= <ranuberger@posteo.de>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 4, 2023 at 1:05 PM Randy N=C3=BCrnberger <ranuberger@posteo.de>=
 wrote:
>
> Hello,
>
> I=E2=80=99m in the process of copying a btrfs filesystem (a couple years =
old)
> from one disk to another by using btrfs send and receive on all
> snapshots. The snapshots were created by a tool every hour on the hour
> as one backup measure and automatically removed as they became older.
>
> I got errors like the following and when I compare the copied snapshots
> with the originals, some files are missing:
>
> ERROR: unlink =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88 failed: No su=
ch file or directory
> ERROR: link =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88 -> =E2=96=88=E2=
=96=88=E2=96=88=E2=96=88=E2=96=88 failed: No such file or directory
> ERROR: utimes =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88 failed: No su=
ch file or directory
> ERROR: rmdir =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88 failed: No suc=
h file or directory
>
> Is this a known bug and how can I help diagnosing and fixing this?

So this is a problem caused by the sender issuing commands with outdated pa=
ths.

First, try doing the send operation again with a 6.1 kernel - there
was at least one fix here that may be relevant.

To actual debug things, in case it's not working with 6.1:

1) Show how you invoked send and receive. I.e. the full command lines
for 'btrfs send ...' and 'btrfs receive ...'

2) Provide the whole output of 'btrfs receive' with the -vvv command
line option.
    This will reveal all path names, but it's necessary to debug things.
    You've hidden path names above, so I suppose that's not acceptable for =
you.

Thanks.

>
>
> # uname -a  # this is the kernel on which this originally happend
> Linux arktos 5.10.0-20-amd64 #1 SMP Debian 5.10.158-2 (2022-12-13)
> x86_64 GNU/Linux
>
>
> # uname -a  # I already retried everything on the latest Debian
> backports kernel with the same results
> Linux arktos 6.0.0-0.deb11.6-amd64 #1 SMP PREEMPT_DYNAMIC Debian
> 6.0.12-1~bpo11+1 (2022-12-19) x86_64 GNU/Linux
>
> # btrfs --version
> btrfs-progs v5.10.1
>
> # btrfs fi sh /mnt/randy  # this is the source
> Label: none  uuid: 84bba855-578d-48db-80eb-49f1029c7543
>          Total devices 2 FS bytes used 2.04TiB
>          devid    1 size 4.00TiB used 2.05TiB path /dev/mapper/randy_1_cr=
ypt
>          devid    2 size 4.00TiB used 2.05TiB path /dev/mapper/randy_2_cr=
ypt
>
> # btrfs fi df /mnt/randy
> Data, RAID1: total=3D2.02TiB, used=3D2.02TiB
> System, RAID1: total=3D8.00MiB, used=3D320.00KiB
> Metadata, RAID1: total=3D25.00GiB, used=3D22.99GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>
>
> # btrfs fi sh /mnt/intern  # this is the target
> Label: none  uuid: ebb94498-644c-42cd-892f-37886173523c
>          Total devices 2 FS bytes used 1.91TiB
>          devid    1 size 8.00TiB used 1.91TiB path
> /dev/mapper/vg_arktos_hdd_b-lv_randy_1
>          devid    2 size 8.00TiB used 1.91TiB path
> /dev/mapper/vg_arktos_hdd_b-lv_randy_2
>
> # btrfs fi df /mnt/intern
> Data, RAID1: total=3D1.89TiB, used=3D1.89TiB
> System, RAID1: total=3D8.00MiB, used=3D288.00KiB
> Metadata, RAID1: total=3D21.00GiB, used=3D20.76GiB
> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058B63EA953
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 19:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhHLRS7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhHLRS7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 13:18:59 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70E2C061756;
        Thu, 12 Aug 2021 10:18:33 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id b7so3147523uav.11;
        Thu, 12 Aug 2021 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QdEoiEm2g87WEk1R+kcH8dP+gD3NMDBzItDtGLAECqQ=;
        b=Maj5ogTMuXE9JhrNZ11AhIMsp5tTxLz/V8yVKh30hYxE4fUTz1uiJNsZSuq74Devir
         Jwp4TdxQdNyrPi8GcGIsnhXSr7DhK5ZWIkf2RsxpMGdNucjO9DvDUvA1hIlcyYJIYxeI
         9ei4AdEYACvrlpE155zly+Rhe9OvVoyQq4JSL6hoVFMYPj8v1i582Ykdg9ScA2ILLlrN
         ZkJIhdNkV6qmS/pVfBMSjG7DtrF00R2GVo3Rzjw3nOnOWHF83ewr87+zgpuNB+g0P5cI
         JivWira21RuWKhYIgbbBNU5+KPxXT4jiS/PFA16iOZlDKg9PXD6s+I2027WfIn3x6lW8
         svIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QdEoiEm2g87WEk1R+kcH8dP+gD3NMDBzItDtGLAECqQ=;
        b=LTnmlY4ioruyBc/4tvqqxw+0wvIjCghfaTzQ7dUfrP6lqb2w0mncEZJZIP099tPGD1
         M9r3EbFmknKJd/ZTcb7T61h7llaQmD+Q+68pn7CGIElwvntUosxvBeowhzpoYHpYohN7
         oh2eJs/XcjnvpsPZzXNxq7n0jJz0M94VztWDGYmUieiu1780ko41gWYfP0lGviBgt9je
         H0hZlO6JguUskHmNRFeSgZu4fbl5yr91dUu6Mp1mNIR4YJrkZ5HYvGCydojMXCmTR9B3
         skpUjDc82Keyvxzb4MiHNwz4RRxRXrUr6uhxzBVqmBLpI0LxOQRTe4IoHhBLJPx8Jni0
         4Slg==
X-Gm-Message-State: AOAM531PDjMLBXnviKofG5OhvPofI3eQiWMNBIU/3nkJAQvQqcQXJckS
        933RMfueFml6J5I4MyaBHZpTEgT29qPVp8UPU4c=
X-Google-Smtp-Source: ABdhPJyMNVmeBiPIR+zewL1EcXlBuiKdVqN6+pG8Ga6QfOvVWjmSsa3RuqLALtDIUzOpYZBvfgq9vA1PV7KQY0PnRM0=
X-Received: by 2002:ab0:3ca7:: with SMTP id a39mr3519098uax.127.1628788712864;
 Thu, 12 Aug 2021 10:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210811200717.48344-1-davispuh@gmail.com> <ccd23bbb-1404-0727-383f-2412a5d4df36@toxicpanda.com>
In-Reply-To: <ccd23bbb-1404-0727-383f-2412a5d4df36@toxicpanda.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Thu, 12 Aug 2021 20:18:21 +0300
Message-ID: <CAOE4rSwuW4uZR5kBhmctdUqLnyE9Vpcj19qibeLUxWoB4B6opQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Allow read-only mount with corrupted extent tree
To:     Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

tre=C5=A1d., 2021. g. 11. aug., plkst. 23:41 =E2=80=94 lietot=C4=81js Josef=
 Bacik
(<josef@toxicpanda.com>) rakst=C4=ABja:
>
> On 8/11/21 4:07 PM, D=C4=81vis Mos=C4=81ns wrote:
> > Currently if there's any corruption at all in extent tree
> > (eg. even single bit) then mounting will fail with:
> > "failed to read block groups: -5" (-EIO)
> > It happens because we immediately abort on first error when
> > searching in extent tree for block groups.
> >
> > Now with this patch if `ignorebadroots` option is specified
> > then we handle such case and continue by removing already
> > created block groups and creating dummy block groups.
> >
>
> Already done and queue'ed up for the next release
>
> btrfs: rescue: allow ibadroots to skip bad extent tree when reading block=
 group
> items

Nice!
Originally I submitted this patch in March, but it went nowhere so resent.
Anyway I tested that other patch and it has limitation that it won't
handle log replay error so need to use both
rescue=3Dignorebadroots,nologreplay
But other than it seems to work fine.

Here's output when not using nologreplay

[ 1886.281376] BTRFS info (device sde): ignoring bad roots
[ 1886.281381] BTRFS info (device sde): disk space caching is enabled
[ 1886.281383] BTRFS info (device sde): has skinny extents
[ 1886.365608] BTRFS info (device sde): bdev /dev/sdq errs: wr 0, rd
0, flush 0, corrupt 473, gen 0
[ 1886.365618] BTRFS info (device sde): bdev /dev/sdi errs: wr 31626,
rd 18765, flush 178, corrupt 5841, gen 0
[ 1886.365623] BTRFS info (device sde): bdev /dev/sdo errs: wr 6867,
rd 2640, flush 178, corrupt 1066, gen 0
[ 1900.249267] BTRFS warning (device sde): checksum verify failed on
21057125941248 wanted 0x5a4526a7 found 0x25949991 level 0
[ 1902.323362] BTRFS error (device sde): parent transid verify failed
on 21057111523328 wanted 2262739 found 2262698
[ 1902.519338] BTRFS error (device sde): bad tree block start, want
21057108836352 have 524288
[ 1902.940022] BTRFS warning (device sde): checksum verify failed on
21057097302016 wanted 0x8b2501e9 found 0x5b8ab9a3 level 0
[ 1902.946715] BTRFS error (device sde): parent transid verify failed
on 21057097302016 wanted 2262739 found 2262696
[ 1902.950727] BTRFS info (device sde): start tree-log replay
[ 1911.289738] BTRFS warning (device sde): checksum verify failed on
21057127661568 wanted 0xd1506ed9 found 0x22ab750a level 0
[ 1911.293266] BTRFS warning (device sde): checksum verify failed on
21057107017728 wanted 0x9120eaee found 0x35b2df28 level 0
[ 1911.326093] BTRFS: error (device sde) in __btrfs_free_extent:3069:
errno=3D-5 IO failure
[ 1911.326101] BTRFS: error (device sde) in
btrfs_run_delayed_refs:2150: errno=3D-5 IO failure
[ 1911.326106] BTRFS warning (device sde): Skipping commit of aborted
transaction.
[ 1911.326108] BTRFS: error (device sde) in cleanup_transaction:1945:
errno=3D-5 IO failure
[ 1911.326190] BTRFS warning (device sde): checksum verify failed on
21057107017728 wanted 0x9120eaee found 0xd00e16cf level 0
[ 1911.326317] BTRFS warning (device sde): checksum verify failed on
21057107017728 wanted 0x9120eaee found 0xd00e16cf level 0
[ 1911.326922] BTRFS: error (device sde) in btrfs_replay_log:2417:
errno=3D-5 IO failure (Failed to recover log tree)
[ 1912.160913] BTRFS error (device sde): parent transid verify failed
on 21057111736320 wanted 2262739 found 2262698
[ 1914.666177] BTRFS error (device sde): open_ctree failed

Best regards,
D=C4=81vis

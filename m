Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE36933E62B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 02:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhCQB34 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 21:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhCQB3i (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 21:29:38 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C30C06174A;
        Tue, 16 Mar 2021 18:29:38 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 130so37349454qkh.11;
        Tue, 16 Mar 2021 18:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vK6w6Y188j7PtwuhViCoYrourMldbwVA3dovNdE8N40=;
        b=r10+Yb4pgBdcizibkIfKkaywAgl4ptZYGzbsmWCYgZopaDI7qjsAVVvP4vPC+CMl7X
         +Ml3rl0RpPX4M8MmOKdCviswzQLGk7JUpCmA93wVksPMsHW/R3zfCeOHaibsMc1cOxe6
         8u4ICBe6ro5iQMLbwzTqNu+BDihXRjsyomAp22PwxiMKzqU+l83eFQmaeN6wPid96uPq
         fecXS1Wg7qvy8k9PWKf/sx/OU1GL6JJLXNc94+WeBHgpPmqktH1qN4w1HnwWwwjycckb
         csLB2j/fwjj+bwS31A/yUXzgMBadu7+49BdZSAOvtGm/OOXqOMRvvoEXqeYbyWZcchUY
         +F5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vK6w6Y188j7PtwuhViCoYrourMldbwVA3dovNdE8N40=;
        b=Ygued1el9VCKarJoUk7aIXVP1NJPiZQ4L5taC1zZqeTlIaLcbJJycWJ6MPJjqmusGp
         9pX1iZMX6pI0A/KhAv4GDC1Kh37gwWAbHkf6TKenSmgmSgagi6NqHlftSN6g6am/i3oE
         kDOb8hBMEgH3S8fLCkSatZT4sTlw0+akgNVAubr/9wY8fou/FAohnjWuqzZhZ4/Glif4
         bHlijGaCMGRNmi2Ba73VBKXvwCEkU5hBht19kEWr2J1MgkXknugq1JDuPxAnhpTF5oto
         ExKg9bWBc7hPho3otkvzQV8dLj9kmWrSYtelH2SGesyDMgFI91kXR6NDXtvzYitdUpfb
         jQKQ==
X-Gm-Message-State: AOAM5329yxQ4amprn4lwL/q/d7nYHOtcX+9mEsmXehgjozJZ5zod/pk7
        DTVF0gjsNu4oDUqyz6YdhKLLNUrdYhoObnN41bSafPA39a6aE/Up
X-Google-Smtp-Source: ABdhPJwsh5qFe3qDfSfYLvRP8kZmnSEjEkbALPF8K1fgbPSXSy29I6k0woyl/tgcGXGLEP7qD3zagx7nVir9edbYRTg=
X-Received: by 2002:a37:596:: with SMTP id 144mr2169848qkf.387.1615944577156;
 Tue, 16 Mar 2021 18:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210317012054.238334-1-davispuh@gmail.com>
In-Reply-To: <20210317012054.238334-1-davispuh@gmail.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Wed, 17 Mar 2021 03:29:24 +0200
Message-ID: <CAOE4rSwj9_DMWLszPE5adiTsQeK+G_Hqya_HkDR=uEC7L4Fj3A@mail.gmail.com>
Subject: Re: [RFC] btrfs: Allow read-only mount with corrupted extent tree
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

tre=C5=A1d., 2021. g. 17. marts, plkst. 03:18 =E2=80=94 lietot=C4=81js D=C4=
=81vis Mos=C4=81ns
(<davispuh@gmail.com>) rakst=C4=ABja:
>
> Currently if there's any corruption at all in extent tree
> (eg. even single bit) then mounting will fail with:
> "failed to read block groups: -5" (-EIO)
> It happens because we immediately abort on first error when
> searching in extent tree for block groups.
>
> Now with this patch if `ignorebadroots` option is specified
> then we handle such case and continue by removing already
> created block groups and creating dummy block groups.
>
> Signed-off-by: D=C4=81vis Mos=C4=81ns <davispuh@gmail.com>
> ---
>  fs/btrfs/block-group.c | 14 ++++++++++++++
>  fs/btrfs/disk-io.c     |  4 ++--
>  fs/btrfs/disk-io.h     |  2 ++
>  3 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 48ebc106a606..827a977614b3 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2048,6 +2048,20 @@ int btrfs_read_block_groups(struct btrfs_fs_info *=
info)
>         ret =3D check_chunk_block_group_mappings(info);
>  error:
>         btrfs_free_path(path);
> +
> +       if (ret =3D=3D -EIO && btrfs_test_opt(info, IGNOREBADROOTS)) {
> +               btrfs_put_block_group_cache(info);
> +               btrfs_stop_all_workers(info);
> +               btrfs_free_block_groups(info);
> +               ret =3D btrfs_init_workqueues(info, NULL);
> +               if (ret)
> +                       return ret;
> +               ret =3D btrfs_init_space_info(info);
> +               if (ret)
> +                       return ret;
> +               return fill_dummy_bgs(info);

This isn't that nice, but I don't really know how to properly clean up
everything related to already created block groups so this was easiest
way. It seems to work fine.
But looks like need to do something about replay log aswell because if
it's not disabled then it fails with:

[ 1397.246869] BTRFS info (device sde): start tree-log replay
[ 1398.218685] BTRFS warning (device sde): sde checksum verify failed
on 21057127661568 wanted 0xd1506ed9 found 0x22ab750a level 0
[ 1398.218803] BTRFS warning (device sde): sde checksum verify failed
on 21057127661568 wanted 0xd1506ed9 found 0x7dd54bb9 level 0
[ 1398.218813] BTRFS: error (device sde) in __btrfs_free_extent:3054:
errno=3D-5 IO failure
[ 1398.218828] BTRFS: error (device sde) in
btrfs_run_delayed_refs:2124: errno=3D-5 IO failure
[ 1398.219002] BTRFS: error (device sde) in btrfs_replay_log:2254:
errno=3D-5 IO failure (Failed to recover log tree)
[ 1398.229048] BTRFS error (device sde): open_ctree failed

Ideally it should replay everything except extent refs.


I also noticed that after unmount there is:

[11000.562504] BTRFS warning (device sde): page private not zero on
page 21057098481664
[11000.562510] BTRFS warning (device sde): page private not zero on
page 21057098485760

not sure what it means.


Best regards,
D=C4=81vis

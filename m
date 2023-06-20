Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D4F736C01
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jun 2023 14:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjFTMfq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jun 2023 08:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjFTMfp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jun 2023 08:35:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B87610DD
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 05:35:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D00B560FA8
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 12:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3544CC433C8
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 12:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687264542;
        bh=aXhnEFuO6hc9EW8Ymlt//gTwE9d5xDCVkD57DdjOnFU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pEvsVOa9TR9O9D8r8yRD4mdS7c4ZTRsdoN3gU15cnUy38YSmM6njIaQ7BWp3VDoOD
         xTMDQHhzfwTOV3lKiGZO9Ku4TuMJBLZQzFle0dhc/UKdy0jdH+6GQLJsuwIx23qziB
         H6Bb63r09O0j7wolHYvF/K6KkMlCJOBkj/COKQNoXiW4pkQU0b74B0r6+fh7vfmqKq
         3y03sP+HDTggee4u80tL1MPS37RYnd4dZnm3WeSb8x6n/ex+P22z/HeJYFDJ3p5EPS
         NXtvM2nzLxM6FgVg1EhdqQ+RaCVmMFsiX66MacxAUzLuQkqEWg0krm93Ei5fb8hMap
         yFe/c+nfnt/cw==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6b46e61638eso2239282a34.0
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Jun 2023 05:35:42 -0700 (PDT)
X-Gm-Message-State: AC+VfDxlSlBC17OyPKtGeC5DkheIV+Ab/okC1fH/0pHMtSL3bDQ405js
        D1H0m6rwT72MnkhFGwcfJLB0ONz42nCTmu8QuYs=
X-Google-Smtp-Source: ACHHUZ7YRX9n6M2Fkr7967O98/5Yt3CyEiGjZnq6dkIhJ27ZBs1txyR2yDVadSEHc5CTd7lTTSv2Y0bdq+1A7S3JoEY=
X-Received: by 2002:a05:6870:1846:b0:1a6:9788:c8dc with SMTP id
 u6-20020a056870184600b001a69788c8dcmr3064976oaf.47.1687264541372; Tue, 20 Jun
 2023 05:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230609175341.1618652-1-clm@fb.com>
In-Reply-To: <20230609175341.1618652-1-clm@fb.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 20 Jun 2023 13:35:05 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6sUuph5MUMjwq=vguHj8bkwn+eMRS89Xb+L1u=Lmqc9g@mail.gmail.com>
Message-ID: <CAL3q7H6sUuph5MUMjwq=vguHj8bkwn+eMRS89Xb+L1u=Lmqc9g@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: can_nocow_file_extent should pass down
 args->strict from callers
To:     Chris Mason <clm@fb.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        josef@toxicpanda.com, fdmanana@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 9, 2023 at 7:17=E2=80=AFPM Chris Mason <clm@fb.com> wrote:
>
> 619104ba453ad0 changed our call to btrfs_cross_ref_exist() to always
> pass false for the 'strict' parameter.  We're passing this down through
> the stack so that we can do a full check for cross references during
> swapfile activation.
>
> With strict always false, this test fails:
>
> btrfs subvol create swappy
> chattr +C swappy
> fallocate -l1G swappy/swapfile
> chmod 600 swappy/swapfile
> mkswap swappy/swapfile
>
> btrfs subvol snap swappy swapsnap
> btrfs subvol del -C swapsnap
>
> btrfs fi sync /
> sync;sync;sync
>
> swapon swappy/swapfile

Btw, I just sent a test case for this and to verify as well that we
can't activate swap files if there are snapshots.

https://lore.kernel.org/linux-btrfs/5417083e8e23a1553f428608d02a07aae21b9e5=
3.1687262391.git.fdmanana@suse.com/

Clearly something we lacked test coverage.

>
> The fix is to just use args->strict, and everyone except swapfile
> activation is passing false.
>
> Fixes: 619104ba453ad0 ("btrfs: move common NOCOW checks against a file ex=
tent into a helper")
> Signed-off-by: Chris Mason <clm@fb.com>
> ---
>  fs/btrfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 19c707bc8801..e57d9969bd71 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1864,7 +1864,7 @@ static int can_nocow_file_extent(struct btrfs_path =
*path,
>
>         ret =3D btrfs_cross_ref_exist(root, btrfs_ino(inode),
>                                     key->offset - args->extent_offset,
> -                                   args->disk_bytenr, false, path);
> +                                   args->disk_bytenr, args->strict, path=
);
>         WARN_ON_ONCE(ret > 0 && is_freespace_inode);
>         if (ret !=3D 0)
>                 goto out;
> --
> 2.34.1
>

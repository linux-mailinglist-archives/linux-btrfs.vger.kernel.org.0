Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E4A627A94
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 11:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiKNKeI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 05:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiKNKdr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 05:33:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7164495BE;
        Mon, 14 Nov 2022 02:33:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADF1E60F90;
        Mon, 14 Nov 2022 10:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224F1C433D7;
        Mon, 14 Nov 2022 10:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668422025;
        bh=CI37u/5LEqV2+tZvwiYbhW+9EBEurhbGV3GIC+/ZIik=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CDL1h6qsrZtjYbQlFfY7z2ohBg/Hy/CnsNghsJFYFw59p2+lqKmQvkd7o3mYR38+j
         kGWhU2vasVH+mocgIRZuOl+QQNwg/Zg3uq7Zn7lYwWryexms8BDuz8ywJEOKDu/gOu
         cuBjlnjzHKSYWxfEsk8zlVFqrD4icgsfMtV79rhcLNtPZMtSLiG3cPGztrLKqrbwv6
         Ma7uFaAJ6w7iwidXoO0R3CrZxfmBDgyVyaM9oHUl3DceZfJCxeU7OqHbsOJAfNuHa7
         PT+p7LbKKRMUChARWS5xSdsvjxcCwbC+IYLEoA1vfYVstOsXUsm+kp7Y78oAgwDVrk
         kdwcEqz56OECQ==
Received: by mail-oi1-f171.google.com with SMTP id v81so10955537oie.5;
        Mon, 14 Nov 2022 02:33:45 -0800 (PST)
X-Gm-Message-State: ANoB5pknH78xDb4mG1NMD4A2/Vg7vIMYxyfwuVlJLrntAJX22C0woYxK
        ZjJKOxrV+vHhgmi6UW9tIaqEVouw7GS0s3tC0o0=
X-Google-Smtp-Source: AA0mqf6W/SGDhsqKiFchsiX4hU78fJBsYoSt9SQ1jvs91WusG0UxSvNFqCPxY7D1hQNsSzpiaOjRPE/pz6ur/BAYef0=
X-Received: by 2002:a54:4889:0:b0:359:dc32:4f9e with SMTP id
 r9-20020a544889000000b00359dc324f9emr5266540oic.92.1668422024269; Mon, 14 Nov
 2022 02:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20221113020841.40180-1-wqu@suse.com>
In-Reply-To: <20221113020841.40180-1-wqu@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 14 Nov 2022 10:33:08 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5wbQHyAU8nkvwj0gwWDpgt_x=cT0EJ_GXkU7j7JfYmiA@mail.gmail.com>
Message-ID: <CAL3q7H5wbQHyAU8nkvwj0gwWDpgt_x=cT0EJ_GXkU7j7JfYmiA@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs/021: redirect the output of defrag command
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Nov 13, 2022 at 2:31 AM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Test case btrfs/021 will fail with v6.0 btrfs-progs, with the extra
> output:
>
>      QA output created by 021
>     +/mnt/scratch/padding-0
>     +/mnt/scratch/padding-1
>     +/mnt/scratch/padding-2
>     +/mnt/scratch/padding-3
>     +/mnt/scratch/padding-4
>     +/mnt/scratch/padding-5
>     ...
>
> [CAUSE]
> In fact this is a btrfs-progs bug, btrfs-progs commit db2f85c8751c
> ("btrfs-progs: fi defrag: add global verbose option") changed the output
> level of defrag command.
>
> [FIX]
> This will be fixed in btrfs-progs, while as a workaround we can redirect
> the stdout into $seqres.full.
>
> If we hit some error, the stderr will still pollute the golden output
> and be caught by the test case.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/021 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/btrfs/021 b/tests/btrfs/021
> index 5943da2f..6b6383cb 100755
> --- a/tests/btrfs/021
> +++ b/tests/btrfs/021
> @@ -23,7 +23,7 @@ run_test()
>         sleep 0.5
>
>         find $SCRATCH_MNT -type f -print0 | xargs -0 \
> -       $BTRFS_UTIL_PROG filesystem defrag -f
> +       $BTRFS_UTIL_PROG filesystem defrag -f >> $seqres.full

Already sent a fix for this last week (plus this misses btrfs/256):

https://lore.kernel.org/fstests/e393451cb53b6b81804eaa41c6461b07a910eb62.1668011769.git.fdmanana@suse.com/

Thanks.

>
>         sync
>         wait
> --
> 2.38.0
>

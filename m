Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB8B7AA576
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 01:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjIUXF7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 19:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjIUXFt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 19:05:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D145133;
        Thu, 21 Sep 2023 16:05:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8EDC433CA;
        Thu, 21 Sep 2023 23:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695337541;
        bh=w52bxHynGdgXuyLTw6Zv7bVi39Ag06bx7oZrC7NUDnw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k59lDyobMXM/awCcfkZSboMaJsoSV0tY++ZEc69u83OUYXqPmK06NuC3IUKsQaiB5
         iP+FM/368+vqcJ7KYBoYiLXq7sRMPF4pmRfwEvHYsvszvXyWAUDbilxKb9Viwpk+iA
         e1Wzb5Q+UtE+95cMHNp1EXBqJgjeY2Yn4UyGek5x4e2ApNW8NiVZ65qAjBnL7/iCLq
         QHuX96Nnl2RoUSy5yB5OXUaNcq78E4lSaOz4ImMDwHiEWDpSsC0sHZXe7yBBvb3pSw
         imsgW9yTefOQ/S8mudo723yLnhOLfx2JX2CTyRkmcGrulFdt/7/Yy045xIVNRBXSYW
         16Gdgx46daRHw==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1dc9c2b2b79so442155fac.0;
        Thu, 21 Sep 2023 16:05:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YxiJ9MbR1ml2K7+2N733vgUTq5xMy0EP1E92IJX0VtSqDDjiHgX
        K3MaFpV2HEuRej09y2NlEVk1gtBSiWwj4qHv6l4=
X-Google-Smtp-Source: AGHT+IGLLeJh1qCr+W9Uwmc4P+YuncreqqkipAd9StB+Ho4gVgkRDd8w1mY2aqTynypEsbZPVCYVMW7GA4vjTLMs3ZU=
X-Received: by 2002:a05:6870:b506:b0:1d5:a6ac:ac8d with SMTP id
 v6-20020a056870b50600b001d5a6acac8dmr7310862oap.47.1695337540982; Thu, 21 Sep
 2023 16:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230921094158.1391328-1-naohiro.aota@wdc.com>
In-Reply-To: <20230921094158.1391328-1-naohiro.aota@wdc.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 22 Sep 2023 00:05:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7oPfpBY72SXkkBMn1BQNxMeGdVt8=bof=vjmRoXYG0sQ@mail.gmail.com>
Message-ID: <CAL3q7H7oPfpBY72SXkkBMn1BQNxMeGdVt8=bof=vjmRoXYG0sQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs/239: call fsync to create tree-log dedicated block
 group for zoned mode
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 21, 2023 at 8:39=E2=80=AFPM Naohiro Aota <naohiro.aota@wdc.com>=
 wrote:
>
> Running btrfs/239 on a zoned device often fails with the following error.
>
>   btrfs/239 5s ... - output mismatch (see /host/btrfs/239.out.bad)
>       --- tests/btrfs/239.out     2023-09-21 16:56:37.735204924 +0900
>       +++ /host/btrfs/239.out.bad  2023-09-21 18:22:45.401433408 +0900
>       @@ -1,4 +1,6 @@
>        QA output created by 239
>       +/testdir/dira still exists
>       +/dira does not exists
>        File SCRATCH_MNT/testdir/file1 data:
>        0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
>        *
>       ...
>
> This happens because "testdir" and "dira" are not logged on the first fsy=
nc
> (fsync $SCRATCH_MNT/testdir), but are written as a full commit. That
> prevents updating the log on "mv" time, leaving them pre-mv state.
>
> The full commit is induced by the creation of a new block group. On the
> zoned mode, we use a dedicated block group for tree-log. That block group
> is created on-demand or assigned to a metadata block group if there is
> none. On the first mount of a file system, we need to create one because
> there is only one metadata block group available for the regular
> metadata. That creation of a new block group forces tree-log to be a full
> commit on that transaction, which prevents logging "testdir" and "dira".
>
> Fix the issue by calling fsync before the first "sync", which creates the
> dedicated block group and let the files be properly logged.
>
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks reasonable, thanks.

> ---
>  tests/btrfs/239 | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tests/btrfs/239 b/tests/btrfs/239
> index 3fbeaedd2c39..5a2dbe58d5fb 100755
> --- a/tests/btrfs/239
> +++ b/tests/btrfs/239
> @@ -83,6 +83,18 @@ done
>  #
>  mkdir $SCRATCH_MNT/testdir/dira
>
> +# This fsync is for the zoned mode. On the zoned mode, we use a dedicate=
d block
> +# group for tree-log. That block group is created on-demand or assigned =
to a
> +# metadata block group if there is none. On the first mount of a file sy=
stem, we
> +# need to create one because there is only one metadata block group avai=
lable
> +# for the regular metadata. That creation of a new block group forces tr=
ee-log
> +# to be a full commit on that transaction, which prevents logging "testd=
ir" and
> +# "dira" and screws up the result.
> +#
> +# Calling fsync here will create the dedicated block group, and let them=
 be
> +# logged.
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT
> +
>  # Make sure everything done so far is durably persisted.
>  sync
>
> --
> 2.42.0
>

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE4E6553A5
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Dec 2022 19:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiLWSci (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Dec 2022 13:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiLWSch (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Dec 2022 13:32:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FECF192BF
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Dec 2022 10:32:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EB32B820F0
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Dec 2022 18:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B115DC433F0
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Dec 2022 18:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671820353;
        bh=bC7gi1/AfadZ6q+hKM3V5cRjAm+8t+tNdyAKyCz2lDc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q1gu4uiRzdRtyWYuO1Nrir1veYL08MYMFR1PUZNU5O+LYlnMixGs30kkfsGhx/rSN
         QybwVLyGOp4bABDJLblrcjvpueO++4ua3xhuMUiwGV/jDPyydLHw4qrAAAVKmcyW9N
         2NZE4HvZhYnND7Rbqr8Z4dbDJukKJkq21Bad/eCY6ZMIwrS17t9JWXvVVieDQKT9RW
         CiPq+gg6rTE+ifbzlgXW4xE3bN7YSRacUMlBTMRki10dZ9ngbTvkd85vO11Fv7CIMf
         l+rRml+PftryFTIFJfUkmLcEIibRyCuodNxjPpIEbRKmOaq+rKKiWdqiauLJvopcNW
         45P4quK+nxKiQ==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-14fb3809eaeso802401fac.1
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Dec 2022 10:32:33 -0800 (PST)
X-Gm-Message-State: AFqh2kogYkTf6/gUj6YNO6b+1lUUTxIrjhJXlUDEsQP2M2nyexhR8OGP
        rJE0/RLri/K/0QeXErPmcSiergGcta/bvR3cPWk=
X-Google-Smtp-Source: AMrXdXsRknCwnF/LcLe+ISYL10L9RaPc456Qz5FoespaVH7gAoi96cmPqrtc1MbJzMtisd0QjOlzd/zAppEJHqTxwNk=
X-Received: by 2002:a05:6871:1d5:b0:144:6d8b:c318 with SMTP id
 q21-20020a05687101d500b001446d8bc318mr738244oad.98.1671820352751; Fri, 23 Dec
 2022 10:32:32 -0800 (PST)
MIME-Version: 1.0
References: <20221223020509.457113-1-joanbrugueram@gmail.com>
In-Reply-To: <20221223020509.457113-1-joanbrugueram@gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 23 Dec 2022 18:31:56 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6x6C_faBu_G5nn+-gUtZ_ri6ZxQbXD2sMz-KcrtCSw0A@mail.gmail.com>
Message-ID: <CAL3q7H6x6C_faBu_G5nn+-gUtZ_ri6ZxQbXD2sMz-KcrtCSw0A@mail.gmail.com>
Subject: Re: Repression on lseek (holes) on 1-byte files since Linux 6.1-rc1
To:     Joan Bruguera <joanbrugueram@gmail.com>
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

On Fri, Dec 23, 2022 at 2:12 AM Joan Bruguera <joanbrugueram@gmail.com> wro=
te:
>
> From: Joan Bruguera Mic=C3=B3 <joanbrugueram@gmail.com>
>
> Hello,
>
> I believe I have found a regression related to seeking file data and hole=
s on
> 1-byte files since Linux 6.1-rc1:
>
> Since Linux 6.1-rc1 I observe that, if I create a (non-sparse) 1-byte fil=
e and
> immediately run `lseek(SEEK_DATA, 0)` or `lseek(SEEK_HOLE, 0)` on it, it =
will
> act as if it was a sparse file, i.e. as if it had a hole from offset 0 to=
 1.
>
> If I wait a while or run `sync`, the results are what I expect, i.e. no h=
ole.
>
> A simple reproducer is:
>     #!/usr/bin/env sh
>     set -eu
>
>     rm -f test.bin
>     echo "-----BEFORE SYNC-----"
>     printf "x" > test.bin
>     xfs_io -c "seek -d 0" test.bin
>     echo "-----AFTER SYNC-----"
>     sync
>     xfs_io -c "seek -d 0" test.bin
>
> Expected results (Linux <6.1-rc1):
>     -----BEFORE SYNC-----
>     Whence  Result
>     DATA    0
>     -----AFTER SYNC-----
>     Whence  Result
>     DATA    0
>
> Actual results (Linux >=3D6.1-rc1):
>     -----BEFORE SYNC-----
>     Whence  Result
>     DATA    EOF
>     -----AFTER SYNC-----
>     Whence  Result
>     DATA    0

Thanks for the report.
I sent out a fix for that some minutes ago:

https://lore.kernel.org/linux-btrfs/da314182610b43632ca81ba78ff73fac5ae1bf0=
6.1671820088.git.fdmanana@suse.com/

Cheers.

>
> It doesn't reproduce 100% of the time due to the race between lseek and
> background sync, but it's consistent and also reproduces on a clean VM or=
 UML.
> It also doesn't reproduce on larger (e.g. 2 bytes) files.
>
> I've bisected the change in behaviour to commit
> b6e833567ea12bc47d91e4b6497d49ba60d4f95f
> "btrfs: make hole and data seeking a lot more efficient".
>
> I tried to see if I could figure out the cause by looking at the btrfs ke=
rnel
> code for lseek in fs/btrfs/file.c.
>
> I believe everything is fine until this snippet (line 3947 in v6.1),
> which is supposed to find whether there's a hole at the last extent:
>
>     /* We have an implicit hole from the last extent found up to i_size. =
*/
>     if (!found && start < i_size) {
>         found =3D find_desired_extent_in_hole(inode, whence, start,
>                             i_size - 1, &start);
>         if (!found)
>             start =3D i_size;
>     }
>
> Here it calls `find_desired_extent_in_hole`, which immediately calls
> `btrfs_find_delalloc_in_range` with a range of start=3D0 and end=3D0 (inc=
lusive).
> Supposedly it should find that there's a delalloc extent, but one can eas=
ily
> see by looking at the function that it always returns false if start=3D=
=3Dend.
> This explains why it only happens with 1-byte files, as on e.g. a 2 byte =
file
> start=3D0 and end=3D1 (inclusive) and the function loops and finds the de=
lalloc.
>
> I'm not sure what the right fix is since I'm not very familiar with the b=
trfs
> code base, but both replacing `i_size - 1` with `lockend` in the snippet =
above,
> OR tightening the conditionals in `btrfs_find_delalloc_in_range` (and
> `count_range_bits`) for the `start=3D=3Dend` case seem to work.
>
> Regards,
> - Joan Bruguera

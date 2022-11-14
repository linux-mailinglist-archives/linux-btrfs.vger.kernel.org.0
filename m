Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F1562833D
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Nov 2022 15:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbiKNOwk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Nov 2022 09:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiKNOwj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Nov 2022 09:52:39 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7B022B2C
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 06:52:38 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso6774128otb.6
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Nov 2022 06:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjuJFfCe44M98sdlYLEqWbXQSMfQdtrG7x0cM/9mC2c=;
        b=pOGGI9QZYsHS9SDNSXjH+ZvbzJwmuXZO84H+W0ee9u/Tc4MrFeUG/PIgpyzUYto5JM
         EkKCoYJVHO8ZXvqO9+d54+5AX8aR1y8tJ2WjCE1XuVBTeFDsY9aOROrYWrWvRe0h1Vvy
         N7W2AhrT8WIYgjzuAeCqkUSOM5l/AFlspPsGB2Gvy6e0Xqs9BA1z22kXdWWSyo4/P3SB
         wp69tx2oSMlwCWHZolKenYzLlZkLRmkFI/1iRvTNzqx7UR3lraLRhKFfYlkHlm7+BTh+
         epmLibqkzwCXF1iahH9jdlk9b4zPkBtyfbOAVVqRj2fMIb5fULP6qQKbmQN83hGfESBp
         HCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjuJFfCe44M98sdlYLEqWbXQSMfQdtrG7x0cM/9mC2c=;
        b=1GRnMdVGkKPmbMMEocSZq5EEq7upzSDAo0CluEH8rdHut8BoJJTEPgVQgSW1wqMfdF
         HoRMfFROdgcrAktFjvrQk4Qu6TKYc/vAz9wTEbQfFO2TBQDIuF3h7kK4WtqDAl5SpmsR
         0jgSUM0b3GwfcKrGyhVNQ5BAH5cesctaHlisON4aUeZM8NVids4rZ/frTC5wP0vRwVjq
         BhJpnw0AP/ULF/wsNS/qrnvl7Wyzf3Ng3aRB/9MaysQzCdKqXFgXSe6YRzLtSepe4q6Z
         9nkoL4WQet7q0fJUDNcaYl2ASo6mxt4XPSliHscSEGApdgcvMPVRDWrWtuQaYjjqmUbc
         StCg==
X-Gm-Message-State: ANoB5pnZmWjhXG3eHfpEFTrHihXzUtnxEMtfMbS2iFBVFTxoEfHasoYX
        PXO16Zy2j0fky1BdsX1++HDsSWIpbE0HLBTnP9yvBjGz1to=
X-Google-Smtp-Source: AA0mqf4AteD+EjbWZL8S1Y0hyuDnHeZfj43iv1rP9xijdKbxaWNYBKry8yJsmTJo9zJg6SNtQeLDkDK+A5PbsrYIyrA=
X-Received: by 2002:a9d:c4a:0:b0:66c:80bb:d3a2 with SMTP id
 68-20020a9d0c4a000000b0066c80bbd3a2mr6682135otr.117.1668437557566; Mon, 14
 Nov 2022 06:52:37 -0800 (PST)
MIME-Version: 1.0
References: <1668353728-22636-1-git-send-email-zhanglikernel@gmail.com> <f5cceda5-e887-0807-7331-12382b45ea29@gmx.com>
In-Reply-To: <f5cceda5-e887-0807-7331-12382b45ea29@gmx.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Mon, 14 Nov 2022 22:52:26 +0800
Message-ID: <CAAa-AGnySE_U_64jC3Mkog9GgM5tHNd3dgjv=P9K5L-SVD3WaA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: scrub: expand scrub block size for data range scrub
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
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

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8814=E6=
=97=A5=E5=91=A8=E4=B8=80 06:58=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2022/11/13 23:35, Li Zhang wrote:
>
> A small description here on the problem would help on the context.
>
> > [implement]
> > 1. Add the member checksum_error to the scrub_sector,
> > which indicates the checksum error of the sector
> >
> > 2. Use scrub_find_btrfs_ordered_sum to find the desired
>
> Please don't put "_btrfs_" in the middle.
>
> Just "scrub_find_ordered_sum()" is good enough.
>
> > btrfs_ordered_sum containing address logic, in
> > scrub_sectors_for_parity and scrub_sectors, call
> > Scrub_find_btrfs_ordered_sum finds the
> > btrfs_ordered_sum containing the current logical address, and
> > Calculate the exact checksum later.
> >
> > 3. In the scrub_checksum_data function,
> > we should check all sectors in the scrub_block.
> >
> > 4. The job of the scrub_handle_errored_block
> > function is to count the number of error and
> > repair sectors if they can be repaired.
>
> The idea is good.
>
> And I hope it can also unify the error accounting of data and metadata.
>
> Currently for metadata csum mismatch, we only report one csum error even
> if the metadata is 4 sectors.
> While for data, we always report the number of corrupted sectors.
>

Because only one checksum is calculated for all sectors of the
metadata block.

In this case the checksum count is ambiguous if
checksum_error means sector error, it should count all sectors, but if
checksum_error indicates that the checksum does not match and can only be
incremented by 1.

Also, since the metadata data block is a complete block, it cannot be
Fix sector by sector, the patch doesn't take this case into account.
So the patch still has bugs.

> >
> > The function enters the wrong scrub_block, and
> > the overall process is as follows
> >
> > 1) Check the scrub_block again, check again if the error is gone.
> >
> > 2) Check the corresponding mirror scrub_block, if there is no error,
> > Fix bad sblocks with mirror scrub_block.
> >
> > 3) If no error-free scrub_block is found, repair it sector by sector.
> >
> > One difficulty with this function is rechecking the scrub_block.
> >
> > Imagine this situation, if a sector is checked the first time
> > without errors, butthe recheck returns an error.
>
> If you mean the interleaved corrupted sectors like the following:
>              0 1 2 3
>   Mirror 1: |X| |X| |
>   Mirror 2: | |X| |X|
>
> Then it's pretty simple, when doing re-check, we should only bother the
> one with errors.
> You do not always treat the scrub_block all together.
>
> Thus if you're handling mirror 1, then you should only need to fix
> sector 0 and sector 2, not bothering fixing the good sectors (1 and 3).
>

Consider the following

The results of the first checking are as follows:
           0 1 2 3
  Mirror 1: |X| |X| |
  Mirror 2: | |X| | |

The result of the recheck is:
           0 1 2 3
  Mirror 1: |X| |X|X|
  Mirror 2: | |X| | |
An additional error was reported, what should we do,
recheck (which means it would recheck twice or more)?
Or just check only bad sectors during recheck.


>
> > What should
> > we do, this patch only fixes the bug that the sector first
> > appeared (As in the case where the scrub_block
> > contains only one scrub_sector).
> >
> > Another reason to only handle the first error is,
> > If the device goes bad, the recheck function will report more and
> > more errors,if we want to deal with the errors in the recheck,
> > you need to recheck again and again, which may lead to
> > Stuck in scrub_handle_errored_block for a long time.
>
> Taking longer time is not a problem, compared to corrupted data.
>
> Although I totally understand that the existing scrub is complex in its
> design, that's exactly why I'm trying to implement a better scrub_fs
> interface:
>
> https://lwn.net/Articles/907058/
>
> RAID56 has a similiar problem until recent big refactor, changing it to
> a more streamlined flow.
>
> But the per-sector repair is still there, you can not avoid that, no
> matter if scrub_block contains single or multiple sectors.
> (Although single sector scrub_block make is much easier)
>
> [...]
> > @@ -1054,7 +1056,8 @@ static int scrub_handle_errored_block(struct scru=
b_block *sblock_to_check)
> >               if (ret =3D=3D -ENOMEM)
> >                       sctx->stat.malloc_errors++;
> >               sctx->stat.read_errors++;
> > -             sctx->stat.uncorrectable_errors++;
> > +             sctx->stat.uncorrectable_errors +=3D scrub_get_sblock_che=
cksum_error(sblock_to_check);
> > +             sctx->stat.uncorrectable_errors +=3D sblock_to_check->hea=
der_error;
>
> Do we double accout the header_error for metadata?
>
> Thanks,
> Qu

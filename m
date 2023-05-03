Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A066F5829
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjECMt4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 08:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjECMtz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 08:49:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8C6EE
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 05:49:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A874B60FA2
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 12:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC2DC4339B
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 12:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683118193;
        bh=l84pNEbWH/qgvJRpaSYQqgTsq/C49byAfceTEpmEwm8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i3V913w+31/NKxd/n6jRMHlK2AxqEUPAfuz3DxbChR6gHZejXhAStttInUnObuZGH
         7iZSBUeHNp9LStMiAYmfgiKNzYGt1FLR1nt1JW7A9L1AIzSjEw90t/QIxj5n4qJ0zG
         oEXDjbc4woCWTFMEQDcBzIOyoG86vlhofIaVmYSasie+vlQrn+6pCzLd7hIwlwlOb3
         qiYAzIQtnjSRrKkEGQkYmgKqqTa+nT5PF20t8bRw57wLxV6mhM0MR+lEjha3ku/ISs
         0vMIYFqDcSsCInG8VL0qFQX3uzL+YMGKppRYbgzHAdUou2JCjlDRWILwjVFExjbECZ
         hEB6f/uD3qp0w==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-38e692c0918so2921143b6e.1
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 05:49:52 -0700 (PDT)
X-Gm-Message-State: AC+VfDz4sDi5DFI1JzfaFHewuwLKo2Viu/oRI5OeuLVDSolNlU+Vabiq
        WeKkIjFiQWG2CT15EehyMn2WbujLDerv8pvqOcM=
X-Google-Smtp-Source: ACHHUZ4MrTzHM7lfnfdOg2WzgjafkObTp6q7DQttwiyCT6pGzoT2KVHzonTqv4IneI7XC6lHNlAK07gXe/Nz3WCmJrA=
X-Received: by 2002:aca:100d:0:b0:38e:6a7f:194d with SMTP id
 13-20020aca100d000000b0038e6a7f194dmr9580685oiq.54.1683118192107; Wed, 03 May
 2023 05:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com>
 <CAL3q7H5yKd1=WuZaU-s7hQ-MwzWONsOtVNoA6cjpLW0-3DDEEQ@mail.gmail.com>
In-Reply-To: <CAL3q7H5yKd1=WuZaU-s7hQ-MwzWONsOtVNoA6cjpLW0-3DDEEQ@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 3 May 2023 13:49:16 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7FyF6YYuMbz0GTBb9G3WYxy9Pr9xQ11rde7jR3zVXuwA@mail.gmail.com>
Message-ID: <CAL3q7H7FyF6YYuMbz0GTBb9G3WYxy9Pr9xQ11rde7jR3zVXuwA@mail.gmail.com>
Subject: Re: 6.2 regression: BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET broken
To:     Vladimir Panteleev <git@vladimir.panteleev.md>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 3, 2023 at 1:37=E2=80=AFPM Filipe Manana <fdmanana@kernel.org> =
wrote:
>
> On Wed, May 3, 2023 at 1:33=E2=80=AFPM Vladimir Panteleev
> <git@vladimir.panteleev.md> wrote:
> >
> > Hi,
> >
> > Commit 6ce6ba534418132f4c727d5707fe2794c797299c appears to have broken
> > the BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET flag to
> > BTRFS_IOC_LOGICAL_INO_V2. The ioctl now always seems to return zero
> > inodes with the flag, if the same happened without the flag, thus
> > making it not very useful.
> >
> > Context: I maintain btdu, a disk usage profiler for btrfs. It uses
> > BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET to help users estimate the amount
> > of space wasted by bookend extents, and identify files / applications
> > / IO patterns which create excessive amounts of them.
>
> Are you able to apply and test a kernel patch?
>
> If so, try the following one (also at:
> https://gist.github.com/fdmanana/9ae7f6c62779aacf4bfd3b155d175792)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index e54f0884802a..c4c5784e897a 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -45,7 +45,8 @@ static int check_extent_in_eb(struct
> btrfs_backref_walk_ctx *ctx,
>         int root_count;
>         bool cached;
>
> -       if (!btrfs_file_extent_compression(eb, fi) &&
> +       if (!ctx->ignore_extent_item_pos &&

This misses a:

.. && ctx->extent_item_pos > 0 &&

I've updated the gist with it:
https://gist.githubusercontent.com/fdmanana/9ae7f6c62779aacf4bfd3b155d17579=
2/raw/3f41c8486eb73a038f026c8bfe767bd763a016c9/logical_ino2_fix.patch

Thanks.

> +           !btrfs_file_extent_compression(eb, fi) &&
>             !btrfs_file_extent_encryption(eb, fi) &&
>             !btrfs_file_extent_other_encoding(eb, fi)) {
>                 u64 data_offset;
> @@ -552,13 +553,10 @@ static int add_all_parents(struct
> btrfs_backref_walk_ctx *ctx,
>                                 count++;
>                         else
>                                 goto next;
> -                       if (!ctx->ignore_extent_item_pos) {
> -                               ret =3D check_extent_in_eb(ctx, &key,
> eb, fi, &eie);
> -                               if (ret =3D=3D BTRFS_ITERATE_EXTENT_INODE=
S_STOP ||
> -                                   ret < 0)
> -                                       break;
> -                       }
> -                       if (ret > 0)
> +                       ret =3D check_extent_in_eb(ctx, &key, eb, fi, &ei=
e);
> +                       if (ret =3D=3D BTRFS_ITERATE_EXTENT_INODES_STOP |=
| ret < 0)
> +                               break;
> +                       else if (ret > 0)
>                                 goto next;
>                         ret =3D ulist_add_merge_ptr(parents, eb->start,
>                                                   eie, (void **)&old, GFP=
_NOFS);
>
> Thanks.
> >
> > Thanks!

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2AC6F68ED
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 12:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjEDKOZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 06:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEDKOX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 06:14:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3360C2128;
        Thu,  4 May 2023 03:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74EE661724;
        Thu,  4 May 2023 10:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF169C433EF;
        Thu,  4 May 2023 10:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683195258;
        bh=CyFrcoXV1ArJAmol5dgwUGVF/D8IaZ8XeL06Rqjlqhs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lnm8ITFfnVKUa25+2bNNRWx1SSIrGJBHGo3bw+z+tbQ0w11mgyjxer0+Ds5Fj4xmo
         V73m9HMeVkf3KyLLwDuIdVvkxWaDlmKi/JTz4svTQG/m5A0W7jbFqGD0M2cxanqp6Z
         E+/RvokZEDP+fuqaJWG3luLmVD1HDpfND7cZ30XopJDkhxt0WmFbOXul9LOqzLKW18
         uQyo2FHMPoHhM6pbaYsK7JgHhRD5vRf7mwbB/Xx6IWjg77fHMrqYtlFA9o0Eqm8GQu
         iCVFJAxDhqRA/fNM+nmtQA9pDotZNbiWwPpFc6QWqoBiQHsHLCC9p1ZqaBq9HlV943
         g+FXVGiWqpUOg==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6a5f6349ec3so68439a34.0;
        Thu, 04 May 2023 03:14:18 -0700 (PDT)
X-Gm-Message-State: AC+VfDyTNukw/bUlRSvhVa5tHLuVXWcjzMqBp/sjvDAPZPu37APwIalS
        nLUYGAJR/T40WRE70Q6qN8foYibN36bOCjiQNpM=
X-Google-Smtp-Source: ACHHUZ4WN8+8AQ5toPzUi6g99K87lNKXo2jfEnD4NOhv0/IfX5bGVqKPEj7uoqr8t9IZ2EHajYQUheD9mLULDcgWtZw=
X-Received: by 2002:a05:6808:1247:b0:38b:efe8:dfa8 with SMTP id
 o7-20020a056808124700b0038befe8dfa8mr1476886oiv.51.1683195257897; Thu, 04 May
 2023 03:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <77994dd9ede2084d45dd0a36938c67de70d8e859.1683123587.git.fdmanana@suse.com>
 <20230504174118.4D5F.409509F4@e16-tech.com>
In-Reply-To: <20230504174118.4D5F.409509F4@e16-tech.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 4 May 2023 11:13:41 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4UtPrtu4mjyF5Q1LtfGUYULZfGH4EwjXm9wdmFix_b4Q@mail.gmail.com>
Message-ID: <CAL3q7H4UtPrtu4mjyF5Q1LtfGUYULZfGH4EwjXm9wdmFix_b4Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix backref walking not returning all inode refs
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org, git@vladimir.panteleev.md,
        Filipe Manana <fdmanana@suse.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 4, 2023 at 10:41=E2=80=AFAM Wang Yugui <wangyugui@e16-tech.com>=
 wrote:
>
> Hi,
>
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When using the logical to ino ioctl v2, if the flag to ignore offsets o=
f
> > file extent items (BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET) is given, the
> > backref walking code ends up not returning references for all file offs=
ets
> > of an inode that point to the given logical bytenr. This happens since
> > kernel 6.2, commit 6ce6ba534418 ("btrfs: use a single argument for exte=
nt
> > offset in backref walking functions"), as it mistakenly skipped the sea=
rch
> > for file extent items in a leaf that point to the target extent if that
> > flag is given. Instead it should only skip the filtering done by
> > check_extent_in_eb() - that is, it should not avoid the calls to that
> > function.
> >
> > So fix this by always calling check_extent_in_eb() and have this functi=
on
> > do the filtering only if an extent offset is given and the flag to igno=
re
> > offsets is not set.
> > Fixes: 6ce6ba534418 ("btrfs: use a single argument for extent offset in=
 backref walking functions")
> > Reported-by: Vladimir Panteleev <git@vladimir.panteleev.md>
> > Link: https://lore.kernel.org/linux-btrfs/CAHhfkvwo=3DnmzrJSqZ2qMfF-rZB=
-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com/
> > Tested-by: Vladimir Panteleev <git@vladimir.panteleev.md>
> > CC: stable@vger.kernel.org # 6.2+
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> fstests(btrfs/299) will fail with this patch.

Yes, I noticed it later, and it is fixed in v2.
Thanks.

>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2023/05/04
>
> > ---
> >  fs/btrfs/backref.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > index e54f0884802a..8e61be3fe9a8 100644
> > --- a/fs/btrfs/backref.c
> > +++ b/fs/btrfs/backref.c
> > @@ -45,7 +45,9 @@ static int check_extent_in_eb(struct btrfs_backref_wa=
lk_ctx *ctx,
> >       int root_count;
> >       bool cached;
> >
> > -     if (!btrfs_file_extent_compression(eb, fi) &&
> > +     if (!ctx->ignore_extent_item_pos &&
> > +         ctx->extent_item_pos > 0 &&
> > +         !btrfs_file_extent_compression(eb, fi) &&
> >           !btrfs_file_extent_encryption(eb, fi) &&
> >           !btrfs_file_extent_other_encoding(eb, fi)) {
> >               u64 data_offset;
> > @@ -552,13 +554,10 @@ static int add_all_parents(struct btrfs_backref_w=
alk_ctx *ctx,
> >                               count++;
> >                       else
> >                               goto next;
> > -                     if (!ctx->ignore_extent_item_pos) {
> > -                             ret =3D check_extent_in_eb(ctx, &key, eb,=
 fi, &eie);
> > -                             if (ret =3D=3D BTRFS_ITERATE_EXTENT_INODE=
S_STOP ||
> > -                                 ret < 0)
> > -                                     break;
> > -                     }
> > -                     if (ret > 0)
> > +                     ret =3D check_extent_in_eb(ctx, &key, eb, fi, &ei=
e);
> > +                     if (ret =3D=3D BTRFS_ITERATE_EXTENT_INODES_STOP |=
| ret < 0)
> > +                             break;
> > +                     else if (ret > 0)
> >                               goto next;
> >                       ret =3D ulist_add_merge_ptr(parents, eb->start,
> >                                                 eie, (void **)&old, GFP=
_NOFS);
> > --
> > 2.35.1
>
>

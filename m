Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B6D6F5B9E
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 17:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjECP5T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 11:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjECP5S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 11:57:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F464EE3
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 08:57:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C194462E35
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 15:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A97C4339B
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 15:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683129436;
        bh=6mhH7EQiC5cNxrffDB4e9Yrd7+WfBgQN+U+s5t7hcLg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D4ALxGskF6ZzgBdQ2c1PXJiJm8JaijtzdFd+EqTTaTz02G1EgUuTm2wv5SlQ5arGh
         RAXj5h5ApNla/tnA0rX3FGrKQYmYxidTzgx8dNs+bVOW2m48n5uADJyZHbDgjnzJUk
         wUZ3IRqiUM0SnLE1BKA6QZzxbhvnexRpkrFbV+C0imKm81Rs52ojLX4tXO3lz+iA/p
         yQYbF6+LkEU69eljEya9tWk11e2JT02pdRMqN3CNNdeZ91NElU+/cX/gFyVjy6hg2z
         BxfoHCFVVfBcLywORQj+fbbrd5n62WzglNPYnvAOUoTSsf+SP9qt12GIMI+UGJ4n/X
         C/YMSC4yx1mpw==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-38dfdc1daa9so3146895b6e.1
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 08:57:16 -0700 (PDT)
X-Gm-Message-State: AC+VfDyru/2Ry+o6sv8+yzRViFPOzzj39kKwoXWrCtnCgNjNVZzLv+DE
        98LYh2b4EWdYNcXvKIDHkMJBiKZbdUfaLxJBv78=
X-Google-Smtp-Source: ACHHUZ4nanAm1m1Dm2c49fAtM+IwsO3HTxmpWag+fKxpMrdfhVJmUGi1LlqJCcAdKbnHIs7YcR9UlDYX8Ydh7dPZIpI=
X-Received: by 2002:a05:6808:23c9:b0:38e:334:d0ce with SMTP id
 bq9-20020a05680823c900b0038e0334d0cemr354123oib.27.1683129435321; Wed, 03 May
 2023 08:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com>
 <CAL3q7H5yKd1=WuZaU-s7hQ-MwzWONsOtVNoA6cjpLW0-3DDEEQ@mail.gmail.com>
 <CAL3q7H7FyF6YYuMbz0GTBb9G3WYxy9Pr9xQ11rde7jR3zVXuwA@mail.gmail.com> <ZFKAT6u7XEY1Y4yQ@hungrycats.org>
In-Reply-To: <ZFKAT6u7XEY1Y4yQ@hungrycats.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 3 May 2023 16:56:39 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4idLr3VNB_UG30BMoW9=HcZmWotgnfue4QuQtSHnGJ9w@mail.gmail.com>
Message-ID: <CAL3q7H4idLr3VNB_UG30BMoW9=HcZmWotgnfue4QuQtSHnGJ9w@mail.gmail.com>
Subject: Re: 6.2 regression: BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET broken
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Vladimir Panteleev <git@vladimir.panteleev.md>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 3, 2023 at 4:40=E2=80=AFPM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Wed, May 03, 2023 at 01:49:16PM +0100, Filipe Manana wrote:
> > On Wed, May 3, 2023 at 1:37=E2=80=AFPM Filipe Manana <fdmanana@kernel.o=
rg> wrote:
> > >
> > > On Wed, May 3, 2023 at 1:33=E2=80=AFPM Vladimir Panteleev
> > > <git@vladimir.panteleev.md> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Commit 6ce6ba534418132f4c727d5707fe2794c797299c appears to have bro=
ken
> > > > the BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET flag to
> > > > BTRFS_IOC_LOGICAL_INO_V2. The ioctl now always seems to return zero
> > > > inodes with the flag, if the same happened without the flag, thus
> > > > making it not very useful.
> > > >
> > > > Context: I maintain btdu, a disk usage profiler for btrfs. It uses
> > > > BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET to help users estimate the amo=
unt
> > > > of space wasted by bookend extents, and identify files / applicatio=
ns
> > > > / IO patterns which create excessive amounts of them.
> > >
> > > Are you able to apply and test a kernel patch?
> > >
> > > If so, try the following one (also at:
> > > https://gist.github.com/fdmanana/9ae7f6c62779aacf4bfd3b155d175792)
> > >
> > > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > > index e54f0884802a..c4c5784e897a 100644
> > > --- a/fs/btrfs/backref.c
> > > +++ b/fs/btrfs/backref.c
> > > @@ -45,7 +45,8 @@ static int check_extent_in_eb(struct
> > > btrfs_backref_walk_ctx *ctx,
> > >         int root_count;
> > >         bool cached;
> > >
> > > -       if (!btrfs_file_extent_compression(eb, fi) &&
> > > +       if (!ctx->ignore_extent_item_pos &&
> >
> > This misses a:
> >
> > .. && ctx->extent_item_pos > 0 &&
>
> Ummm...why?

Because if it's 0 it will trigger an underflow at check_extent_in_eb():

offset +=3D ctx->extent_item_pos - data_offset;

if the file extent item's data offset is > 0.
So the filtering must happen only if the offset is not zero, and it was com=
puted
earlier at iterate_inodes_from_logical().

>
> With IGNORE_OFFSET set, we want to ignore the offset on the candidate
> matching extent and on the original search bytenr, so we get matches in
> cases where the search bytenr happens to be at offset 0 in the extent.

And that's what happens with the patch.
Any file extent item that points to the target bytenr, will be
considered when the ignore flag is given.

>
> I think your first patch was the better one.  What am I missing?

I think the above explains it.

>
> > I've updated the gist with it:
> > https://gist.githubusercontent.com/fdmanana/9ae7f6c62779aacf4bfd3b155d1=
75792/raw/3f41c8486eb73a038f026c8bfe767bd763a016c9/logical_ino2_fix.patch
> >
> > Thanks.
> >
> > > +           !btrfs_file_extent_compression(eb, fi) &&
> > >             !btrfs_file_extent_encryption(eb, fi) &&
> > >             !btrfs_file_extent_other_encoding(eb, fi)) {
> > >                 u64 data_offset;
> > > @@ -552,13 +553,10 @@ static int add_all_parents(struct
> > > btrfs_backref_walk_ctx *ctx,
> > >                                 count++;
> > >                         else
> > >                                 goto next;
> > > -                       if (!ctx->ignore_extent_item_pos) {
> > > -                               ret =3D check_extent_in_eb(ctx, &key,
> > > eb, fi, &eie);
> > > -                               if (ret =3D=3D BTRFS_ITERATE_EXTENT_I=
NODES_STOP ||
> > > -                                   ret < 0)
> > > -                                       break;
> > > -                       }
> > > -                       if (ret > 0)
> > > +                       ret =3D check_extent_in_eb(ctx, &key, eb, fi,=
 &eie);
> > > +                       if (ret =3D=3D BTRFS_ITERATE_EXTENT_INODES_ST=
OP || ret < 0)
> > > +                               break;
> > > +                       else if (ret > 0)
> > >                                 goto next;
> > >                         ret =3D ulist_add_merge_ptr(parents, eb->star=
t,
> > >                                                   eie, (void **)&old,=
 GFP_NOFS);
> > >
> > > Thanks.
> > > >
> > > > Thanks!

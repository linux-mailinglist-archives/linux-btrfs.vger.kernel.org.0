Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7FD6F68E8
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 May 2023 12:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjEDKMb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 4 May 2023 06:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjEDKMY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 4 May 2023 06:12:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FB84C2D
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 03:12:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9324663304
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 10:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B49C4339B
        for <linux-btrfs@vger.kernel.org>; Thu,  4 May 2023 10:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683195140;
        bh=qYI7PkIp9EgQJ/t+SGRtMJ1Yfi3gvIz/i7mZt0jagks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M9fAWb398McVD1ZjonXhg7zEmIKPEI12r8QVOdHRLFzjwdL7NRjnCLgD0YYhUTGBC
         Sr2YOLjGbAN089IJ0jfxEsgnMU1IuvmvyT+LnFAz6C5FoYzZmQi9OGGX0CZi2rS/7q
         JTTfj6EkehYijsxC58zcergdwn0fhgiKfnAClWS2nmmzoTO0oyJAH+cC5NPMACm9rh
         C0eeqrpGxBKZkdC/hkjY8csLd83Yo8ePYJPx7x68hl51eMxlQXDDsAxDDw8CyTmTfd
         AqZ/IXpyc+2Zv0sweS3xSQ2P5/9QjAUaGXyL6ls+l1u7MTqAwSKCxxdnrNHIsvaVfH
         gJpFq97sOMXtw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5475e0147c9so81360eaf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 04 May 2023 03:12:19 -0700 (PDT)
X-Gm-Message-State: AC+VfDyr5V0jcjtKkM3VuZ1YbEVey64/wcTMmtjBOl7u7pOWpx8B96GJ
        8E3yW7Ye8ShjOtPo980P6UHQ2Pkv+q2Nq5qYrq0=
X-Google-Smtp-Source: ACHHUZ5XnZ5agwrCnvZmFa4wtJIk7SkPG6dU1D5awLeqDwwCynJCxw/ke6kKIiKBYP60Vk+ukn38hmpXwqYOk9Hr9ZY=
X-Received: by 2002:a05:6808:2215:b0:38e:6933:e761 with SMTP id
 bd21-20020a056808221500b0038e6933e761mr1562778oib.6.1683195139126; Thu, 04
 May 2023 03:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com>
 <CAL3q7H5yKd1=WuZaU-s7hQ-MwzWONsOtVNoA6cjpLW0-3DDEEQ@mail.gmail.com>
 <CAL3q7H7FyF6YYuMbz0GTBb9G3WYxy9Pr9xQ11rde7jR3zVXuwA@mail.gmail.com>
 <ZFKAT6u7XEY1Y4yQ@hungrycats.org> <CAL3q7H4idLr3VNB_UG30BMoW9=HcZmWotgnfue4QuQtSHnGJ9w@mail.gmail.com>
 <ZFLYv8rawcgDfymY@hungrycats.org>
In-Reply-To: <ZFLYv8rawcgDfymY@hungrycats.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 4 May 2023 11:11:43 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6jY487q9_BAgwMfCXYW0tVSL+15ZZGLykE+j-O3kxqgw@mail.gmail.com>
Message-ID: <CAL3q7H6jY487q9_BAgwMfCXYW0tVSL+15ZZGLykE+j-O3kxqgw@mail.gmail.com>
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

On Wed, May 3, 2023 at 10:57=E2=80=AFPM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Wed, May 03, 2023 at 04:56:39PM +0100, Filipe Manana wrote:
> > On Wed, May 3, 2023 at 4:40=E2=80=AFPM Zygo Blaxell
> > <ce3g8jdj@umail.furryterror.org> wrote:
> > >
> > > On Wed, May 03, 2023 at 01:49:16PM +0100, Filipe Manana wrote:
> > > > On Wed, May 3, 2023 at 1:37=E2=80=AFPM Filipe Manana <fdmanana@kern=
el.org> wrote:
> > > > >
> > > > > On Wed, May 3, 2023 at 1:33=E2=80=AFPM Vladimir Panteleev
> > > > > <git@vladimir.panteleev.md> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Commit 6ce6ba534418132f4c727d5707fe2794c797299c appears to have=
 broken
> > > > > > the BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET flag to
> > > > > > BTRFS_IOC_LOGICAL_INO_V2. The ioctl now always seems to return =
zero
> > > > > > inodes with the flag, if the same happened without the flag, th=
us
> > > > > > making it not very useful.
> > > > > >
> > > > > > Context: I maintain btdu, a disk usage profiler for btrfs. It u=
ses
> > > > > > BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET to help users estimate the=
 amount
> > > > > > of space wasted by bookend extents, and identify files / applic=
ations
> > > > > > / IO patterns which create excessive amounts of them.
> > > > >
> > > > > Are you able to apply and test a kernel patch?
> > > > >
> > > > > If so, try the following one (also at:
> > > > > https://gist.github.com/fdmanana/9ae7f6c62779aacf4bfd3b155d175792=
)
> > > > >
> > > > > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > > > > index e54f0884802a..c4c5784e897a 100644
> > > > > --- a/fs/btrfs/backref.c
> > > > > +++ b/fs/btrfs/backref.c
> > > > > @@ -45,7 +45,8 @@ static int check_extent_in_eb(struct
> > > > > btrfs_backref_walk_ctx *ctx,
> > > > >         int root_count;
> > > > >         bool cached;
> > > > >
> > > > > -       if (!btrfs_file_extent_compression(eb, fi) &&
> > > > > +       if (!ctx->ignore_extent_item_pos &&
> > > >
> > > > This misses a:
> > > >
> > > > .. && ctx->extent_item_pos > 0 &&
> > >
> > > Ummm...why?
> >
> > Because if it's 0 it will trigger an underflow at check_extent_in_eb():
> >
> > offset +=3D ctx->extent_item_pos - data_offset;
> >
> > if the file extent item's data offset is > 0.
> > So the filtering must happen only if the offset is not zero, and it was=
 computed
> > earlier at iterate_inodes_from_logical().
> >
> > > With IGNORE_OFFSET set, we want to ignore the offset on the candidate
> > > matching extent and on the original search bytenr, so we get matches =
in
> > > cases where the search bytenr happens to be at offset 0 in the extent=
.
> >
> > And that's what happens with the patch.
>
> That's true, but the real reason why it works for the IGNORE_OFFSET case
> is that I misread the condition:
>
>         if (!ctx->ignore_extent_item_pos &&
>                 // nothing else matters
>                 // because !ctx->ignore_extent_item_pos is false,
>                 // so the rest of the && aren't evaluated, or the
>                 // if true branch
>
> so the rest of the code carries on using the extent's bytenr as 'offset'.
>
> The true branch of the 'if' is only relevant if we are _not_ ignoring
> the offset, since that is where the offset gets checked against the
> file extent item.  In that case, the target block could be on either
> side of the file extent item's reference range (below data_offset,
> or above data_offset + data_length) as well as inside the range.
> The outside-the-range case is handled here:
>
>                 data_offset =3D btrfs_file_extent_offset(eb, fi);
>
>                 if (ctx->extent_item_pos < data_offset ||
>                     ctx->extent_item_pos >=3D data_offset + data_len)
>                         return 1;
>
> so we don't get to the line you mentioned:
>
>         offset +=3D ctx->extent_item_pos - data_offset;

Yes.
I realized that later and left tests running overnight after removing
that and integrating Vladimir's patch.

I think I was originally confused by looking at the old code where
there was an "extent_item_pos" which was a u64 pointer in some
functions and a plain u64 in others.

I removed it from v2.

I'm also writing a test case for fstests to exercise the logical to
ino ioctl, to cover these cases and many others, as unfortunately we
don't have any coverage for it in fstests.

Thanks.

>
> ctx->extent_item_pos >=3D data_offset and
> ctx->extent_item_pos < data_offset + data_len, so
> offset + ctx->extent_item_pos - data_offset must be within the extent
> (assuming the referencing file_extent_item isn't busted).
>
> > Any file extent item that points to the target bytenr, will be
> > considered when the ignore flag is given.
> >
> > > I think your first patch was the better one.  What am I missing?
> >
> > I think the above explains it.
> >
> > >
> > > > I've updated the gist with it:
> > > > https://gist.githubusercontent.com/fdmanana/9ae7f6c62779aacf4bfd3b1=
55d175792/raw/3f41c8486eb73a038f026c8bfe767bd763a016c9/logical_ino2_fix.pat=
ch
> > > >
> > > > Thanks.
> > > >
> > > > > +           !btrfs_file_extent_compression(eb, fi) &&
> > > > >             !btrfs_file_extent_encryption(eb, fi) &&
> > > > >             !btrfs_file_extent_other_encoding(eb, fi)) {
> > > > >                 u64 data_offset;
> > > > > @@ -552,13 +553,10 @@ static int add_all_parents(struct
> > > > > btrfs_backref_walk_ctx *ctx,
> > > > >                                 count++;
> > > > >                         else
> > > > >                                 goto next;
> > > > > -                       if (!ctx->ignore_extent_item_pos) {
> > > > > -                               ret =3D check_extent_in_eb(ctx, &=
key,
> > > > > eb, fi, &eie);
> > > > > -                               if (ret =3D=3D BTRFS_ITERATE_EXTE=
NT_INODES_STOP ||
> > > > > -                                   ret < 0)
> > > > > -                                       break;
> > > > > -                       }
> > > > > -                       if (ret > 0)
> > > > > +                       ret =3D check_extent_in_eb(ctx, &key, eb,=
 fi, &eie);
> > > > > +                       if (ret =3D=3D BTRFS_ITERATE_EXTENT_INODE=
S_STOP || ret < 0)
> > > > > +                               break;
> > > > > +                       else if (ret > 0)
> > > > >                                 goto next;
> > > > >                         ret =3D ulist_add_merge_ptr(parents, eb->=
start,
> > > > >                                                   eie, (void **)&=
old, GFP_NOFS);
> > > > >
> > > > > Thanks.
> > > > > >
> > > > > > Thanks!

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD606F588B
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 15:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjECNGt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 09:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjECNGs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 09:06:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854A6DF
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:06:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22EE96152D
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 13:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89226C433D2
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 13:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683119206;
        bh=Ov9+iugcaJkncWlEdvhI9E1Sp2oGUs6WkGVX5G4IKMg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H55dm49RHW7iNNtTcKtmQhzwU9Wrh/oFgl4CD1lTS6OoCNX96iAAmKcZoYB3qgn9B
         o3SU9habydfXTvlJ74V7fYc/u2AvFx4ep41rfOWfdw0kFWpzE0jobnbtpGlJtH3U9h
         QD3ISeXNHowZJ4l0tvCv0PNc/9qO1qa0Mp39PH11QrwZuLzHq/oCOjnnaL7OKooYyB
         Dd0d0PooF2AbhTs5Dlu2UiYo9CUPOEblmrP5bfniaQ5+8uXWWSbRzVtsjX4OSq9jlX
         VHug/mqCqLGHfutG5GzoU0WjspDULyszXGJKdphrp5XgmPJiz49tuwpO3o2bigTDKK
         CrzPzDvm27WEw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-54974b6851fso2713141eaf.3
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 06:06:46 -0700 (PDT)
X-Gm-Message-State: AC+VfDwIZp0+i/wypI6VdCQF2PP84xutX7NJezlA93HnQCPLD1MTHfiF
        adLyDZ4smikl0MBSjnAtzl7s+dXrZscoC/ZtUoQ=
X-Google-Smtp-Source: ACHHUZ6LSHvEn0mfwuCB5JWx5B5I+5lVTyZCsXVrg6eBuLw58hC02MPJF6r07UCjMpn+7JkYUE7Q/RlrKBuv4ywWmxg=
X-Received: by 2002:aca:a897:0:b0:392:593f:bb1c with SMTP id
 r145-20020acaa897000000b00392593fbb1cmr26145oie.20.1683119205701; Wed, 03 May
 2023 06:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com>
 <CAL3q7H5yKd1=WuZaU-s7hQ-MwzWONsOtVNoA6cjpLW0-3DDEEQ@mail.gmail.com>
 <CAL3q7H7FyF6YYuMbz0GTBb9G3WYxy9Pr9xQ11rde7jR3zVXuwA@mail.gmail.com> <CAHhfkvzQaRtxBqSKodAj2Gy21TMRC_fOd0cq9ECcxnU4QeuV_w@mail.gmail.com>
In-Reply-To: <CAHhfkvzQaRtxBqSKodAj2Gy21TMRC_fOd0cq9ECcxnU4QeuV_w@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 3 May 2023 14:06:09 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6255X42N1gMy78ViXuPw4GExyhv-fptOwi_K3yJvAk1Q@mail.gmail.com>
Message-ID: <CAL3q7H6255X42N1gMy78ViXuPw4GExyhv-fptOwi_K3yJvAk1Q@mail.gmail.com>
Subject: Re: 6.2 regression: BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET broken
To:     Vladimir Panteleev <git@vladimir.panteleev.md>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
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

On Wed, May 3, 2023 at 2:01=E2=80=AFPM Vladimir Panteleev
<git@vladimir.panteleev.md> wrote:
>
> On Wed, 3 May 2023 at 12:49, Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > On Wed, May 3, 2023 at 1:37=E2=80=AFPM Filipe Manana <fdmanana@kernel.o=
rg> wrote:
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
> >
> > I've updated the gist with it:
> > https://gist.githubusercontent.com/fdmanana/9ae7f6c62779aacf4bfd3b155d1=
75792/raw/3f41c8486eb73a038f026c8bfe767bd763a016c9/logical_ino2_fix.patch
> >
> > Thanks.
>
> Yes, it works!

Ok, great.
I'll add a changelog and send it to the list.

Thanks for the testing and report.

>
> The first version of the patch seemed to work too.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FDA6C761D
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 04:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjCXDHM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Mar 2023 23:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCXDHK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Mar 2023 23:07:10 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF82822DFD;
        Thu, 23 Mar 2023 20:07:07 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-536af432ee5so11334847b3.0;
        Thu, 23 Mar 2023 20:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679627227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7RNJJiJSbbm61ako0ahXT1mMaetjoSMCe2fUbURFbM=;
        b=MHIq/T/sZywtbB6IQ63GEjU0+JbCKBvi4IPTkFI4pnK4pFWTvELJvDXEDZ3wSQaTpE
         uzNS5PXLVrLi02YT45QoSMb0CqOT2bKpbwnRyqjNLXzRHyFldfJcFivAczcicuIcp2aw
         6hpV2nHu8qOTB9AgWSiRd4icdhQcnjZB2tMlmFQN9kBypcy44PvHk73FdF3fYJfOJRrf
         HszJQBFxRycBBRVYAP/N4zkIaSQK2ZG//2p3WY/w5mbLxNoDlfF4fnoOFnRMGH0kamtc
         Q4EFKTynB66yzDG4KGJh+MX9waaC1+ykvVXEkdOb5+NE/gAMGIQcPh88FTbqB7LGbMLb
         ubCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679627227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7RNJJiJSbbm61ako0ahXT1mMaetjoSMCe2fUbURFbM=;
        b=IbcpyZsP2JxwF4RMP2DIQr2xlsKpIGaTboEOJl5GiWcwEu8gMPukdEX/9wjPOYc3qG
         AmeA1pF4SIXV/mZ9fNF10ZTFEi03s4GB/s9+cfNFFHx1AeWCqdggNQ8vZpnftRMZ0S7e
         J0Nzvr1WgjgoEr91HTBcEeXTK8q7dw9X8lrVTt66O3rZGuRegki1ho0BpylDsVBFJG7X
         Eorfxh5Ilqgx1PKVoCaAmVgiFtz+kb1Qa/k6NEJVDeMrsIgVyMPcWelKACwA21uzBV/1
         +o1vN7fnmd1yehg3PCHaWiW/zx4KthiEeGMWuC+FRBTXR9p+sc3SWpidQveb4USG7nmC
         ks3Q==
X-Gm-Message-State: AAQBX9cvLnf+f3nLcWU7Keu/kSfe2rt5yUFDMO0cNq14vVHZDOnmHemc
        KGcCjRi+tW1zUoEuMurixLZpTYH+8oHCHe/orrA=
X-Google-Smtp-Source: AKy350akO/8gynR9i9Zupi7i9uPniMy4SvNfYuOxDnZOdAB4ryI/XbixJCdUuhc9B0+icYnhV5QaomleaN9zm+dygeQ=
X-Received: by 2002:a81:b247:0:b0:544:51f7:83c5 with SMTP id
 q68-20020a81b247000000b0054451f783c5mr368075ywh.1.1679627227025; Thu, 23 Mar
 2023 20:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230324020838.67149-1-zhanggenjian@kylinos.cn>
 <78422b96-52ed-b48a-27d0-1cfaa89a6608@gmx.com> <20230324022904.GD10580@twin.jikos.cz>
In-Reply-To: <20230324022904.GD10580@twin.jikos.cz>
From:   genjian zhang <zhanggenjian123@gmail.com>
Date:   Fri, 24 Mar 2023 11:05:57 +0800
Message-ID: <CAOd03yQUD1ehcfApW++7buVDOiWzggnvjTzsgiWGqf+pdrL9sA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix uninitialized variable warning
To:     dsterba@suse.cz
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 24, 2023 at 10:35=E2=80=AFAM David Sterba <dsterba@suse.cz> wro=
te:
>
> On Fri, Mar 24, 2023 at 10:24:55AM +0800, Qu Wenruo wrote:
> > On 2023/3/24 10:08, Genjian wrote:
> > > From: Genjian Zhang <zhanggenjian@kylinos.cn>
> > >
> > > compiler warning:
> >
> > Compiler version please.
> >
> > >
> > > ../fs/btrfs/volumes.c: In function =E2=80=98btrfs_init_new_device=E2=
=80=99:
> > > ../fs/btrfs/volumes.c:2703:3: error: =E2=80=98seed_devices=E2=80=99 m=
ay be used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> > >   2703 |   btrfs_setup_sprout(fs_info, seed_devices);
> > >        |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > ../fs/btrfs/send.c: In function =E2=80=98get_cur_inode_state=E2=80=99=
:
> > > ../include/linux/compiler.h:70:32: error: =E2=80=98right_gen=E2=80=99=
 may be used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> > >     70 |   (__if_trace.miss_hit[1]++,1) :  \
> > >        |                                ^
> > > ../fs/btrfs/send.c:1878:6: note: =E2=80=98right_gen=E2=80=99 was decl=
ared here
> > >   1878 |  u64 right_gen;
> > >        |      ^~~~~~~~~
> > >
> > > Initialize the uninitialized variables.
> > >
> > > Reported-by: k2ci <kernel-bot@kylinos.cn>
> > > Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
> > > ---
> > >   fs/btrfs/send.c    | 2 +-
> > >   fs/btrfs/volumes.c | 2 +-
> > >   2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > > index e5c963bb873d..af2e153543a5 100644
> > > --- a/fs/btrfs/send.c
> > > +++ b/fs/btrfs/send.c
> > > @@ -1875,7 +1875,7 @@ static int get_cur_inode_state(struct send_ctx =
*sctx, u64 ino, u64 gen,
> > >     int left_ret;
> > >     int right_ret;
> > >     u64 left_gen;
> > > -   u64 right_gen;
> > > +   u64 right_gen =3D 0;
> >
> > IIRC this is not my first time explaining why this is a false alert.
> >
> > Thus please report your compiler version first.
>
> This is probably because of the -Wmaybe-uninitialized we enabled, on
> some combination of architecture and compiler. While I'm also interested
> in the compiler and version we need to fix the warnings before 6.3 final.
> We'd be gettting the warnings and reports/patches, which is wasting
> peoples' time, it's not a big deal to initialize the variables. But
> still I also want to know which version reports that.

aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 and
aarch64-linux-gnu-gcc (7.3.0-20190804.h30.ky10.aarch64 )

Thanks,

Genjian.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F221D76EFDD
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 18:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjHCQpm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 12:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbjHCQpk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 12:45:40 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71281B2
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 09:45:39 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-63cf4827630so6336026d6.2
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Aug 2023 09:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691081138; x=1691685938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFCXH3mOUSq8MqtZtOkQkRghp8S2GIqMkOlbsQ4LQ88=;
        b=wfeHYOHqmHJelbVa+gQR2GNMF3c7du1yNFbQnLx+lyJh7yqP9ritrv9FPFxzAeYXPg
         8B7AtnMU3r1Dn4wIeAoo198vyCUdPH4ORPUiSoKuyZGSp9CAp3s+Lu1bwi7+5yUtVjng
         QrmJfckWzDEu25adx7RQealFqD+elITU5E0XQ1RsVvD7Q7pM0N1A1WgXqbPnHpUmiNhP
         Sx9xRu7EAwfgWardS1x8jk5u3pOUqJLXa8lj2Ftajf6hRM/Jl1mUv0StYqeIce51dYXc
         W1bhpBh1H20IOuYNJclN1E9blwfW9ssmMF5Y+nyJSdig9lbTYtL7P1uJ1dEbvMR0MztN
         TVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691081138; x=1691685938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFCXH3mOUSq8MqtZtOkQkRghp8S2GIqMkOlbsQ4LQ88=;
        b=FQaN1KfhGGiBrF8UJH7B0f7urvqctIhEtlDS7raSZv4nxZCbRJ61q9exCQg0eqGXuJ
         ccsB2Q/74CBFNlnx7nnP0VF4fUHY7KlIUMY8GHD/hYGUgjkmj5GdSw7chKZdayvQjxRA
         D9r3QgR/iWqKhEfXpZE35sC6/b9sU3Hu4gnCSBQDSURt3N1tdVrRpvx0V4XwDdlqEkcD
         gKOsCqTgvzJIgIKrymoWbAFYtYq57XriyNeOvuwNpTkMUQ+q/8OTsXdo6CXUN+UPHfnN
         +4w5FK9oqEZ6RGVyDorVoyQwEVoseCBRJH0XxVGsnpqauk3nj5+nnO81uutgrmpqoh53
         YLvQ==
X-Gm-Message-State: ABy/qLYibCKd8v+HE0nhOHjH7++UwbHAkpZokPKPaOk8VJt+c/TGDy2Z
        Fwxj5R4hN9Y6bD6aQ/ekR41LChYftxkElbsQ7DyXG5fYOQjsjGibbkiZ6g==
X-Google-Smtp-Source: APBJJlEcCFgjfRr1EdUfBbKP0P3BUkZYFIfhXUreDbb22A4nsuS+4fUvEhOfBF1s9aXjsXcKsTSP757Bg0MoXBc12FQ=
X-Received: by 2002:ad4:4149:0:b0:63c:fbe9:6837 with SMTP id
 z9-20020ad44149000000b0063cfbe96837mr15576127qvp.11.1691081138436; Thu, 03
 Aug 2023 09:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230724121934.1406807-1-arnd@kernel.org> <ZMBDWbHiJVOt03u5@google.com>
In-Reply-To: <ZMBDWbHiJVOt03u5@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 3 Aug 2023 09:45:27 -0700
Message-ID: <CAKwvOdm9CS0FRrWA9LaWw74enydbTMFUk_WYWXJvNxgLwQBzOQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: remove unused pages_processed variable
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Anand Jain <anand.jain@oracle.com>,
        Filipe Manana <fdmanana@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Arnd Bergmann <arnd@kernel.org>, linux@leemhuis.info
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 25, 2023 at 2:49=E2=80=AFPM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jul 24, 2023 at 02:19:15PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The only user of pages_processed was removed, so it's now a local write=
-only
> > variable that can be eliminated as well:
> >
> > fs/btrfs/extent_io.c:214:16: error: variable 'pages_processed' set but =
not used [-Werror,-Wunused-but-set-variable]
> >
> > Fixes: 9480af8687200 ("btrfs: split page locking out of __process_pages=
_contig")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202307241541.8w52nEnt-lkp=
@intel.com/
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for the patch!
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Link: https://lore.kernel.org/llvm/64c00cd4.630a0220.6ad79.0eac@mx.google=
.com/
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Friendly ping the btrfs maintainers to please pick this up.  Our CI
for linux-next has been red over this for longer than I like, and it's
giving me nausea, heartburn, indigestion, upset stomach, and...well...
https://youtu.be/d8InOVEsMlU

>
> > ---
> >  fs/btrfs/extent_io.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index c0440a0988c9a..121edea2cfe85 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -211,7 +211,6 @@ static void __process_pages_contig(struct address_s=
pace *mapping,
> >       pgoff_t start_index =3D start >> PAGE_SHIFT;
> >       pgoff_t end_index =3D end >> PAGE_SHIFT;
> >       pgoff_t index =3D start_index;
> > -     unsigned long pages_processed =3D 0;
> >       struct folio_batch fbatch;
> >       int i;
> >
> > @@ -226,7 +225,6 @@ static void __process_pages_contig(struct address_s=
pace *mapping,
> >
> >                       process_one_page(fs_info, &folio->page, locked_pa=
ge,
> >                                        page_ops, start, end);
> > -                     pages_processed +=3D folio_nr_pages(folio);
> >               }
> >               folio_batch_release(&fbatch);
> >               cond_resched();
> > --
> > 2.39.2
> >



--=20
Thanks,
~Nick Desaulniers

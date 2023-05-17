Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230D3706398
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 11:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjEQJIf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 05:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEQJIe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 05:08:34 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005CE3C30;
        Wed, 17 May 2023 02:08:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-965e4be7541so81493066b.1;
        Wed, 17 May 2023 02:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684314511; x=1686906511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL7BGTgvbcXLLhRtnWhTpR+x2jZEtE39qWgJtMXMaFc=;
        b=Mz/DvUKotTKbF5QagNkD+Uf7jiFeTonP4iUetNndVHwkdKTffMbyxbwZEdEPPROC9/
         W+Ym7T5SX9kKryIozA9nZHPP0KlryHChLH4IogWBeQ/U2Bz4PgKuNf/tI5TSx/ml5OZo
         i0X1QpJC0j7UgtxQfmAo+jGP/EQWrM1tc/qqdDRzprH7nh5D8XlYHdDDdaDhbrYv2gEX
         LlxEVp1KTaz2cH72zTxpqCNIHn7kECSQv+7TNv06O4VfTMV4pNqyzSV78B+bDZ8T6Qlt
         Yg2mgmgE7fcGPSnNu9BsWemfvua1E1hzL0KssYAC7uC0P5Z3Nw7NdM7WSFs/pJKHD/LF
         zS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684314511; x=1686906511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL7BGTgvbcXLLhRtnWhTpR+x2jZEtE39qWgJtMXMaFc=;
        b=SHb0JPAgecLHXyksutIfkc0F2nnD++3bTOy54VQI8F3OHItTrDeYC7EqY/tYwvcrR2
         A0rzTUCGK1SUYhpuKuFo+D+EmMbx7Mu8tM6GOcYeis9pwDiJNmOH5FUHr9cCamE4mNu0
         J3zxK98HfRHyGcwcQL7rYWBPQDWvhEwsgoIMUrfh372az4VHkq5cuiEGL6NWerCeJRbP
         1bS+oIHKkA3H+l0yqXiva7wNT7SluBSpxQOEUtQ4iDBszS2LKfGTfUPr81WrRBcnR5Pm
         /9nKnXlYwav1MZTdbYU4rdRPRetqTuuQNkb8rU6JNXUU1ZPRhX+ZR1Al4VB0pfhEaCTW
         TRbA==
X-Gm-Message-State: AC+VfDznTQZrx786iu7CfDSj2dk1yJ39HoYLmDwQ+OW0Y5i6wiWf9MiN
        fp+w2Kajj1FecCIk5EcGLfC5cMLAkZp+VIDmbSM=
X-Google-Smtp-Source: ACHHUZ6Vk1jUQlhcdWdTJWB3VTdnzITOru4fSKSRiNlm0aTh+TM+paDxV5YqLyvJLhuk0F3unkjyRW4/RUPacqxjePE=
X-Received: by 2002:a17:907:98e:b0:962:9ffa:be02 with SMTP id
 bf14-20020a170907098e00b009629ffabe02mr36316016ejc.36.1684314511110; Wed, 17
 May 2023 02:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230516013430.2712449-1-zhangshida@kylinos.cn> <f90eb6c1-4491-ecd2-1fdd-56580088c993@gmx.com>
In-Reply-To: <f90eb6c1-4491-ecd2-1fdd-56580088c993@gmx.com>
From:   Stephen Zhang <starzhangzsd@gmail.com>
Date:   Wed, 17 May 2023 17:07:55 +0800
Message-ID: <CANubcdVZ4tUZo=HDytwYFTZiQwo8QSABskBfZXL+y_swXvb_DA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix uninitialized warning in btrfs_log_inode
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangshida@kylinos.cn, k2ci <kernel-bot@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2023=E5=B9=B45=E6=9C=8817=E6=97=
=A5=E5=91=A8=E4=B8=89 15:47=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2023/5/16 09:34, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > This fixes the following warning reported by gcc 10 under x86_64:
>
> Full gcc version please.

it's "gcc (Debian 10.2.1-6) 10.2.1 20210110".

> Especially you need to check if your gcc10 is the latest release.
>
> If newer gcc (12.2.1) tested without such error, it may very possible to
> be a false alert.
>
> And in fact it is.
>
> @first_dir_index would only be assigned to @last_range_start if
> last_range_end !=3D 0.
>
> Thus the loop must have to be executed once, and @last_range_start won't
> be zero.
>

Yup, I know it's a false positive. What I don't know is the criterion
that decides whether it is a good patch.
That is,
it doesn't look so good because it is a false alert and the latest gcc
can get rid of such warnings, based on what you said( if I understand
correctly).
Or,
It looks okay because the patch can make some older gcc get a cleaner
build and do no harm to the original code logic.
In fact, I've seen Linus complaining about the warning generated by
some gcc version in another thread.

https://lore.kernel.org/linux-xfs/168384265493.22863.2683852857659893778.pr=
-tracker-bot@kernel.org/T/#t

so it kinda make me feel confused :<

Nonetheless, I appreciate your review.

Thanks,
Shida

> Please do check your environment (especially your gcc version and
> backports), before sending such trivial patches.
> Under most cases, it helps nobody.
>
> Thanks,
> Qu
>
> >
> > ../fs/btrfs/tree-log.c: In function =E2=80=98btrfs_log_inode=E2=80=99:
> > ../fs/btrfs/tree-log.c:6211:9: error: =E2=80=98last_range_start=E2=80=
=99 may be used uninitialized in this function [-Werror=3Dmaybe-uninitializ=
ed]
> >   6211 |   ret =3D insert_dir_log_key(trans, log, path, key.objectid,
> >        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   6212 |       first_dir_index, last_dir_index);
> >        |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ../fs/btrfs/tree-log.c:6161:6: note: =E2=80=98last_range_start=E2=80=99=
 was declared here
> >   6161 |  u64 last_range_start;
> >        |      ^~~~~~~~~~~~~~~~
> >
> > Reported-by: k2ci <kernel-bot@kylinos.cn>
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >   fs/btrfs/tree-log.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 9b212e8c70cc..d2755d5e338b 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -6158,7 +6158,7 @@ static int log_delayed_deletions_incremental(stru=
ct btrfs_trans_handle *trans,
> >   {
> >       struct btrfs_root *log =3D inode->root->log_root;
> >       const struct btrfs_delayed_item *curr;
> > -     u64 last_range_start;
> > +     u64 last_range_start =3D 0;
> >       u64 last_range_end =3D 0;
> >       struct btrfs_key key;
> >

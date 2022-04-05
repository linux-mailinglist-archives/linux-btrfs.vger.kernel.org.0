Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCA04F543A
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 06:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346040AbiDFEpb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 00:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449188AbiDEWYg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 18:24:36 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016B74EF7E
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 14:20:09 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id 14so503261ily.11
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 14:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ecBxQi6QVuJkMHcK9pzAJnLxzVo3sgRcDGD+vPZLmjc=;
        b=nkw7T55qbf2aOOUEQa6A0lov6QhZj9a9oWnTOAWiuaTFkfIXVP/SKn4bw5xl9alFS3
         Vr64JkoHakukfKoXViBU2bqG3IOHriqD4rl2WWX8pGbT7bO2TEzetu2ANZJ6CtLvRj1Q
         COqFNrG+FYPkPM4YoNqXBJASvQs9HbkG1PoUcSowtLFdtryvBeFwqqSOMLePxwoTN/g/
         sTjpvN0S38MXa0lvPP7vi5Xo6mw8JCFMI+IEw9yA+PEiAefMIoWMdMZDDjFMzTdorH6p
         6BBhnLnuVrabW0IGEUiJ9LWKjduPYD+bEOK4iOJsYkyPQB8NDr3d50JwM2/aK9omxKvH
         tiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ecBxQi6QVuJkMHcK9pzAJnLxzVo3sgRcDGD+vPZLmjc=;
        b=1lo33TxTODl3t38T49F8aQzowmyikK8yTq2j7x1N1yeDv7HTLXl+BLJEZCaLf+oD8p
         se8v8oB/VKqRPMFKc2t6PNWpCJmMsuesEceFcIqYHyTWJ6IHx9auhODcOkmPQejCBrjD
         Ej6/8KM4OLXq51zmFrEPFiPmEAmPFa1gbxwwo9kIkOg/oLs7pU35Aw7tIl0NQFmWKGEE
         mCHQUooJr8+f8LM/RliSzj4banv75JZyuGBbWm1tOd2zyY4zwExx80DSqbRLwaxjhUhD
         T9Brrq/ZKMiUwXyPlTd3yQZh0/jmL5loYm87dMcCooBSsbGRvJRU1FLiyQXSA3b1WYj9
         Us2A==
X-Gm-Message-State: AOAM530PjGT92WfxjgWI4Be2uVwiAPMhDoPW1est2eBkPBdzCQBYvs09
        D1nhCYP24S3AkiN9X7zfdGrUrfaKMhZxFQRZ/rOnXZRacck=
X-Google-Smtp-Source: ABdhPJzMfrv/SmHafH4h2VxBX1Soypen3T1inJArc4oYjdjd5J5mBk55vYwew7aVJ6O6jM5q+kcjl40wze68z1RE/cU=
X-Received: by 2002:a05:6e02:170a:b0:2c9:f038:7f2e with SMTP id
 u10-20020a056e02170a00b002c9f0387f2emr2711028ill.127.1649193608300; Tue, 05
 Apr 2022 14:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220405181108.GA28707@merlins.org> <CAEzrpqc=h2A42nnHzeo_DwHik8Lu0xfkuNm2mhd=Ygams6aj=w@mail.gmail.com>
 <20220405195157.GA3307770@merlins.org> <CAEzrpqeQ=Q8u+Kgy6r+axYdbrZKs9=9cvMwEfKr=O2urgZTXHw@mail.gmail.com>
 <20220405195901.GC28707@merlins.org> <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
 <20220405200805.GD28707@merlins.org> <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <20220405203737.GE28707@merlins.org> <CAEzrpqemQ2Uzi+ZJHtQtbF62=hZMTmuPT3HxwkYedUvAsXhdvQ@mail.gmail.com>
 <20220405211412.GF28707@merlins.org>
In-Reply-To: <20220405211412.GF28707@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 5 Apr 2022 17:19:57 -0400
Message-ID: <CAEzrpqeZoUF3+Pgyaup1DGFENs6zDKtRqHiJQ6sx_CoXE2HOOA@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 5, 2022 at 5:14 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Apr 05, 2022 at 05:07:27PM -0400, Josef Bacik wrote:
> > Heh, except it's because I forgot to tell it to treat transid
> > mismatch's as a real problem.  Added some more code, lets give that a
> > whirl, thanks,
>
> Looks better
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 1 /dev/mapper/dshelf1a 2>&1 |tee /tmp/out
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> FS_INFO IS 0x559090e392a0
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> parent transid verify failed on 13577821667328 wanted 1602089 found 1602242
> Couldn't find the last root for 4
> Couldn't setup device tree
> FS_INFO AFTER IS 0x559090e392a0
> Superblock thinks the generation is 1602089
> Superblock thinks the level is 1
> Found tree root at 13577814573056 gen 1602089 level 1

Otra vez por favor,

Josef

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632994F5449
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 06:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443343AbiDFErE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 00:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1589013AbiDFASJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 20:18:09 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE61D179B37
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 15:41:14 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id x4so936358iop.7
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 15:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=33pTq7Eu9kMdEMBWRIzdWY75qJ31wP0mnLk0t/nBCls=;
        b=gS7TbbcsyUGBrnTpH9GEETtexSyvAUuxBeKNnekH6Dyhxt94SkuxcyYzav9zHAkqaF
         I2aw1I7k9aUN/flSR1WEX7ZQX3UjviLDQB/n/OyEAhgPZfUhef3jcM2kq7KlkgSysrjf
         fGuPYI6ooL9/IZEUP3RHyQSyKL/yTMIEYdZw3c1bFXTLUmFo/DltvteUnjFyffU18Ecp
         RsdNnowWczvpqvmqwfcRcb900ehUZf+OjVv6MChQQz8VlCDkxSGHgG1Mw/+zlh3lo1zo
         BF4dfQTtpzJ/w8Vnvo4NqGkraW1hSkNWo6B0VNxse1ECzOPTva8GtnlBhZaAPa45zlCy
         63xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=33pTq7Eu9kMdEMBWRIzdWY75qJ31wP0mnLk0t/nBCls=;
        b=TCdKA2zdUqR1o+Ywtt8cs0K44m+QUTXHIhcxV9hf5OTfyAwsBMCMWImt5ZhLn2YOtv
         38U60VWd4WBlJjQ5sPdzCz4e8o6W7VRvzPWghrfBS4C9oH90ilD7aObSzf69Ue8/pEOL
         v5MLn9qtvf21KNlb1oqZ2Sey16IMBmyiJFZSp0zKkvxl3mQnDjbtqw8BT6Ieil+1BQaT
         bvdhQwakhfUVpM1E9jMnTwv73xURfCqTnwNG5hqFEGbSh3bdCVu9vI41dO2yCZEOh3Ny
         oI1k46mFYDTd5aSKPNloy6gcEVxKuSh2t2NmfzFiPz0tz8CaxaLGBfGXqK/bEC0/GZhV
         mlRA==
X-Gm-Message-State: AOAM5318MR7+v5iDXV2AqQb+it5hQ3dOLeA9Y7frLJKV9RioQUPuBsqU
        1PQpbvjW3Q8ypLFGDfhc0alAjL3BCXqvpth9WezelbNJirE=
X-Google-Smtp-Source: ABdhPJzo2PGUdp0H45yAnJi15/ykjR7zARaAwqkDpscvnn4mnVVa0AJk2hZFETEBccbo7JFZoBXiymJjL1UeOQudEzY=
X-Received: by 2002:a02:b10f:0:b0:323:9bba:a956 with SMTP id
 r15-20020a02b10f000000b003239bbaa956mr3121051jah.313.1649198473781; Tue, 05
 Apr 2022 15:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220405195901.GC28707@merlins.org> <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
 <20220405200805.GD28707@merlins.org> <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <20220405203737.GE28707@merlins.org> <CAEzrpqemQ2Uzi+ZJHtQtbF62=hZMTmuPT3HxwkYedUvAsXhdvQ@mail.gmail.com>
 <20220405211412.GF28707@merlins.org> <CAEzrpqeZoUF3+Pgyaup1DGFENs6zDKtRqHiJQ6sx_CoXE2HOOA@mail.gmail.com>
 <20220405212655.GH28707@merlins.org> <CAEzrpqc0Ss+J6oTqNPfTgWOwyhPAF2uHnRELmc6AO6je6Ht88w@mail.gmail.com>
 <20220405214309.GI28707@merlins.org>
In-Reply-To: <20220405214309.GI28707@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 5 Apr 2022 18:41:02 -0400
Message-ID: <CAEzrpqeDZxjbis5kPWH3khiOALyFqUoTuh5eojFtWHPcwj-Ygw@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Apr 5, 2022 at 5:43 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Apr 05, 2022 at 05:35:02PM -0400, Josef Bacik wrote:
> > On Tue, Apr 5, 2022 at 5:26 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Tue, Apr 05, 2022 at 05:19:57PM -0400, Josef Bacik wrote:
> > > > Otra vez por favor,
> > >
> > > (gdb) run -o 1 /dev/mapper/dshelf1a
> > > Starting program: /var/local/src/btrfs-progs-josefbacik/btrfs-find-ro=
ot -o 1 /dev/mapper/dshelf1a
> > > [Thread debugging using libthread_db enabled]
> > > Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.s=
o.1".
> > > parent transid verify failed on 22216704 wanted 1600938 found 1602177
> > > parent transid verify failed on 22216704 wanted 1600938 found 1602177
> > > parent transid verify failed on 22216704 wanted 1600938 found 1602177
> > > FS_INFO IS 0x5555555cf2a0
> > > parent transid verify failed on 13577821667328 wanted 1602089 found 1=
602242
> > > parent transid verify failed on 13577821667328 wanted 1602089 found 1=
602242
> > > parent transid verify failed on 13577821667328 wanted 1602089 found 1=
602242
> > > parent transid verify failed on 13577821667328 wanted 1602089 found 1=
602242
> > > parent transid verify failed on 13577821667328 wanted 1602089 found 1=
602242
> > > parent transid verify failed on 13577821667328 wanted 1602089 found 1=
602242
> > > Couldn't find the last root for 4
> > > Couldn't setup device tree
> > > FS_INFO AFTER IS 0x5555555cf2a0
> > > Superblock thinks the generation is 1602089
> > > Superblock thinks the level is 1
> > >
> > > Program received signal SIGSEGV, Segmentation fault.
> >
> > Ugh sorry, try again.  Thanks,
>
>
> Thanks. Note that you still have 2 functions to comment out
> From https://github.com/josefbacik/btrfs-progs
>    ce32ea15..914c9847  for-marc   -> origin/for-marc
> Updating ce32ea15..914c9847
> Fast-forward
>  btrfs-find-root.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> sauron:/var/local/src/btrfs-progs-josefbacik# make
>     [CC]     btrfs-find-root.o
> btrfs-find-root.c:383:13: warning: =E2=80=98print_find_root_result=E2=80=
=99 defined but not used [-Wunused-function]
>   383 | static void print_find_root_result(struct cache_tree *result,
>
>
> New version after I fixed the build warnings that were errors for me
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 1 /d=
ev/mapper/dshelf1a 2>&1 |tee /tmp/out
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> FS_INFO IS 0x564897ec32a0
> parent transid verify failed on 13577821667328 wanted 1602089 found 16022=
42
> parent transid verify failed on 13577821667328 wanted 1602089 found 16022=
42
> parent transid verify failed on 13577821667328 wanted 1602089 found 16022=
42
> parent transid verify failed on 13577821667328 wanted 1602089 found 16022=
42
> parent transid verify failed on 13577821667328 wanted 1602089 found 16022=
42
> parent transid verify failed on 13577821667328 wanted 1602089 found 16022=
42
> Couldn't find the last root for 4
> Couldn't setup device tree
> FS_INFO AFTER IS 0x564897ec32a0
> Superblock thinks the generation is 1602089
> Superblock thinks the level is 1
> Found tree root at 13577814573056 gen 1602089 level 1
> gargamel:/var/local/src/btrfs-progs-josefbacik#
>

I'm wandering down this rabbit hole because if I'm able to read the
blocks fine, wtf is the device root not being found.  I've pushed more
printfs, lets see what that says.  Thanks,

Josef

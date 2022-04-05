Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14274F544D
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 06:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358601AbiDFErR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 00:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353648AbiDEVwJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Apr 2022 17:52:09 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3D299688
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Apr 2022 14:07:39 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 125so661286iov.10
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Apr 2022 14:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0qwdQpUH5Agy8G1+HoXyuebb2hgux2Tnh5K8MWj7qSs=;
        b=2Q050B48LH1jUaSyojeTlUpPMmVvkMWLir4NyRnnT7SZEsEf/nG0BONtekJAf23AIv
         KoW8y8OFmecV2of18huTqGJjgrpddLpiXzxKWN9Q4J/+SkFTM9l/POv4jbVF2mKMM3WV
         Z++oEfPMgtnAVPbpd9yTjDWUeaaZgT3HFEFGwi8xOoHbYU/fxXDyiVVP5HGc4m6tQXnI
         jXwS6Hy3lPnyRfKUK6FXIP/Rml0vVzGw2NX3I4bvXln0JjJf/P7hm+QbMv9h/11PKmgE
         3lxpeXh18KhQFSTdBRHH5tsq56ELPZNOm6gfGN+8Y0xvryxcpNdqrDAWKV0HdwClWKF8
         G7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0qwdQpUH5Agy8G1+HoXyuebb2hgux2Tnh5K8MWj7qSs=;
        b=hm/OzbDLPJ8JuVwxVm7qJVqzOr1pBLm3j5BFl+Y5P9dYs9rFOWouagNxH6Peqg/aJY
         QowDo3dNH9bjzCkMFfkdn1SUGpAV+LACjXE58dzpFmw9HhvfUWUH0jEDSkcohLPepgA1
         K+jj3lPH2Loo5zMoK3HuxkS/rIOvzm+06u3X0IuP+03Nz48rfNwM2qwAXmAf7S5CwhH7
         7QIvtI2fQVF1apvDGgkjA+Khb4dZY+WWUY3YEgsGjnPIn22OOVh3NHO11vfZNvw9vzZK
         udlmMxb1CqYzSD2VkNd598/skPujKUzgWf5L/4ADkv54Jjfu2YBYFtJbjU/dFU6T8q+L
         2udw==
X-Gm-Message-State: AOAM5333L8iokpHFxljZJYiJqKOnn2TDtEexoYJVbXlyiKnA3oU1lU9E
        dgMaefgtm3UUphUWKbkRlmeFvIwe9LIq3ExgNPq1OkqQ1AE=
X-Google-Smtp-Source: ABdhPJyBnvZGuIh/X7ozKeZ+PAqXMNf4PPXoTJLW5qGineJuJuTmlG68io0BxCoYNaIAULxQvDyLdJhey1uf5UpoS60=
X-Received: by 2002:a05:6638:270b:b0:323:8ff0:a5e4 with SMTP id
 m11-20020a056638270b00b003238ff0a5e4mr2811354jav.102.1649192858607; Tue, 05
 Apr 2022 14:07:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqehq1tt5O_6jarggYK4dvyWCJ8O=_ps_qXuQbVJ9_bC6g@mail.gmail.com>
 <CAEzrpqdjTRc2VQBGGRB3Dcsk=BzN2ru-fA2=fMz__QnFubR7VQ@mail.gmail.com>
 <20220405181108.GA28707@merlins.org> <CAEzrpqc=h2A42nnHzeo_DwHik8Lu0xfkuNm2mhd=Ygams6aj=w@mail.gmail.com>
 <20220405195157.GA3307770@merlins.org> <CAEzrpqeQ=Q8u+Kgy6r+axYdbrZKs9=9cvMwEfKr=O2urgZTXHw@mail.gmail.com>
 <20220405195901.GC28707@merlins.org> <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
 <20220405200805.GD28707@merlins.org> <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <20220405203737.GE28707@merlins.org>
In-Reply-To: <20220405203737.GE28707@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 5 Apr 2022 17:07:27 -0400
Message-ID: <CAEzrpqemQ2Uzi+ZJHtQtbF62=hZMTmuPT3HxwkYedUvAsXhdvQ@mail.gmail.com>
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

On Tue, Apr 5, 2022 at 4:37 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Apr 05, 2022 at 04:24:16PM -0400, Josef Bacik wrote:
> > On Tue, Apr 5, 2022 at 4:08 PM Marc MERLIN <marc@merlins.org> wrote:
> > >
> > > On Tue, Apr 05, 2022 at 04:05:05PM -0400, Josef Bacik wrote:
> > > > Well it's still the same, and this thing is 20mib into your fs so I=
DK
> > > > how it would be screwing up now.  Can you do
> > > >
> > > > ./btrfs inspect-internal dump-tree -b 21069824
> > > >
> > > > and see what that spits out?  IDK why it would suddenly start
> > > > complaining about your chunk root.  Thanks,
> > >
> > > Thanks for your patience and sticking with me
> > > gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs inspect-inter=
nal dump-tree -b 21069824 /dev/mapper/dshelf1a >/dev/null
> >
> > Ok well that worked, which means it found the chunk tree fine, I'm
> > going to chalk this up to it just fucking with me and ignore it for
> > now.  I pushed some changes for the find root thing, can you re-run
>
>
> Typo I fixed:
> kernel-shared/disk-io.c: In function =E2=80=98verify_parent_transid=E2=80=
=99:
> kernel-shared/disk-io.c:278:35: error: =E2=80=98struct btrfs_fs_info=E2=
=80=99 has no member named =E2=80=98suppress_check_block_errrs=E2=80=99; di=
d you mean =E2=80=98suppress_check_block_errors=E2=80=99?
>   278 |   if (eb->fs_info && eb->fs_info->suppress_check_block_errrs)
>       |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                   suppress_check_block_errors
>
> > ./btrfs-find-root -o 1 /dev/whatever
> >
> > it should be less noisy and spit out one line at the end, "Found tree
> > root at blah blah".  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# l btrfs-find-root
> -rwxr-xr-x 1 root staff 3375608 Apr  5 13:29 btrfs-find-root*
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-find-root -o 1 /d=
ev/mapper/dshelf1a 2>&1 |tee /tmp/out
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> parent transid verify failed on 22216704 wanted 1600938 found 1602177
> FS_INFO IS 0x56289ce172a0
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
> FS_INFO AFTER IS 0x56289ce172a0
> Ignoring transid failure
> Ignoring transid failure
> Ignoring transid failure
> Ignoring transid failure
> (many deleted)
> Ignoring transid failure
> Superblock thinks the generation is 1602089
> Superblock thinks the level is 1
> Found tree root at 13577814573056 gen 1602089 level 1
>
> Good news :)

Heh, except it's because I forgot to tell it to treat transid
mismatch's as a real problem.  Added some more code, lets give that a
whirl, thanks,

Josef

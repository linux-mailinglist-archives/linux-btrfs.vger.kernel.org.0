Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B85798B72
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbjIHRWG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235888AbjIHRWG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:22:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD18D1FC1
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:22:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C51C433CA
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193722;
        bh=ZTPEU9P+pKqx7wyicBp7qRrcWWE+9BP6uYsS7/M7cf8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MIPv1S4K+7hgJEsVoJJOZeiuJvbxf4BKYGbHDmKaU2f9g67dFsI/6zdBqKo02gVdf
         2MnJzgKRfFumpYlwKnEPN22UIjuxLNVMVea9O3QmlvwXui4cfTeG51Ctgjgb7m6e0d
         khSeEQV97UTuWKkUN/7bhyOYBajQQdAQIg6QInndG+W7XhRw4QsdfpN/vQFk7yoicT
         NdzPDQZe5HyThg4Hb1AoeAkyax52r3mXYj21fOizloBDmBO/lpx1ziU3pYruWk1Mjd
         pv2+RK+1oD942drgL61q85dwqYkgBVllEmhEYw3sjWDuetypAFNFRfWZt3geJ0iY4d
         9VN8q6cbvCpDQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1c50438636fso1570305fac.1
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 10:22:02 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy+jic9UAoI2cICiuSScK6cmI4oLDMSaxMoymmaX7FtTQ9qX7uj
        ny4Sn7XoLzkSnghgEqqUo9uOO8yPGstLfUY/NeA=
X-Google-Smtp-Source: AGHT+IFpn5t9dOxyKfj4mSgv6dC4aDTYi1QJ00N3g7U41o/Pv9Otp9KhhicTgTFKdyydmYtK9Bo4Z+i5DyxWNprxUh0=
X-Received: by 2002:a05:6870:b50d:b0:1bf:e1e9:a320 with SMTP id
 v13-20020a056870b50d00b001bfe1e9a320mr3453845oap.13.1694193721740; Fri, 08
 Sep 2023 10:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694174371.git.fdmanana@suse.com> <ad77c4035370a5db4e0b813da9eff73e52fd30c0.1694174371.git.fdmanana@suse.com>
 <20230908144611.GB1977092@perftesting>
In-Reply-To: <20230908144611.GB1977092@perftesting>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 8 Sep 2023 18:21:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6eOr_JptWEoZN0RLcbKjSK2fo90PvZ-oWQSMGXsyyrrw@mail.gmail.com>
Message-ID: <CAL3q7H6eOr_JptWEoZN0RLcbKjSK2fo90PvZ-oWQSMGXsyyrrw@mail.gmail.com>
Subject: Re: [PATCH 01/21] btrfs: fix race when refilling delayed refs block reserve
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 8, 2023 at 3:46=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> w=
rote:
>
> On Fri, Sep 08, 2023 at 01:09:03PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > If we have two (or more) tasks attempting to refill the delayed refs bl=
ock
> > reserve we can end up with the delayed block reserve being over reserve=
d,
> > that is, with a reserved space greater than its size. If this happens, =
we
> > are holding to more reserved space than necessary, however it may or ma=
y
> > not be harmless. In case the delayed refs block reserve size later
> > increases to match or go beyond the reserved space, then nothing bad
> > happens, we end up simply avoiding doing a space reservation later at t=
he
> > expense of doing it now. However if the delayed refs block reserve size
> > never increases to match its reserved size, then at unmount time we wil=
l
> > trigger the following warning from btrfs_release_global_block_rsv():
> >
> >    WARN_ON(fs_info->delayed_block_rsv.reserved > 0);
> >
> > The race happens like this:
> >
> > 1) The delayed refs block reserve has a size of 8M and a reserved space=
 of
> >    6M for example;
> >
> > 2) Task A calls btrfs_delayed_refs_rsv_refill();
> >
> > 3) Task B also calls btrfs_delayed_refs_rsv_refill();
> >
> > 4) Task A sees there's a 2M difference between the size and the reserve=
d
> >    space of the delayed refs rsv, so it will reserve 2M of space by
> >    calling btrfs_reserve_metadata_bytes();
> >
> > 5) Task B also sees that 2M difference, and like task A, it reserves
> >    another 2M of metadata space;
> >
> > 6) Both task A and task B increase the reserved space of block reserve
> >    by 2M, by calling btrfs_block_rsv_add_bytes(), so the block reserve
> >    ends up with a size of 8M and a reserved space of 10M;
> >
> > 7) As delayed refs are run and their space released, the delayed refs
> >    block reserve ends up with a size of 0 and a reserved space of 2M;
> >
>
> This part shouldn't happen, delayed refs space only manipulates
> delayed_refs_rsv->size, so when we drop their space, we do
>
> btrfs_delayed_refs_rsv_release
>  -> btrfs_block_rsv_release
>   -> block_rsv_release_bytes
>
> which does
>
>         spin_lock(&block_rsv->lock);
>         if (num_bytes =3D=3D (u64)-1) {
>                 num_bytes =3D block_rsv->size;
>                 qgroup_to_release =3D block_rsv->qgroup_rsv_size;
>         }
>         block_rsv->size -=3D num_bytes;
>         if (block_rsv->reserved >=3D block_rsv->size) {
>                 num_bytes =3D block_rsv->reserved - block_rsv->size;
>                 block_rsv->reserved =3D block_rsv->size;
>                 block_rsv->full =3D true;
>         }
>
> so if A and B race and the reservation is now much larger than size, the =
extra
> will be cut off at the end when we call btrfs_delayed_refs_rsv_release.
>
> Now I'm all for not holding the over-reserve for that long, but this anal=
ysis is
> incorrect, we would have to somehow do the btrfs_delayed_refs_rsv_refill(=
) and
> then not call btrfs_delayed_refs_rsv_release() at some point.
>
> This *could* happen I suppose by starting a trans handle and not modifyin=
g
> anything while the delayed refs are run and finish before we do our reser=
ve, and
> in that case we didn't generate a delayed ref that could later on call
> btrfs_delayed_refs_rsv_release() to clear the excess reservation, but tha=
t's a
> decidedly different problem with a different solution.  Thanks,

Oh yes, let me fix that. Holding the extra space for longer than
necessary was actually the thing I noticed first.

Fixed in v2 thanks.
>
> Josef

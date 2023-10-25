Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929D07D7848
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Oct 2023 00:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjJYW5y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Oct 2023 18:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYW5x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Oct 2023 18:57:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E4D115
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Oct 2023 15:57:51 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53ebf429b4fso357556a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Oct 2023 15:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698274670; x=1698879470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=au+FPuig5k+lPrQlpRTaaMDYkgX5B4VtECHua21n4XI=;
        b=D3oU4ES6g2Ih4+0S0BkQ43d5+3ZQa9to/3JaXFjKocJlfTgGAchbEPuY7cRiXBvbJh
         GWrWbSbCOtlv6CydGRMnwnpV/DWNoT4C6iQ7Uz7M+TfYcS4dNNZES/yBzX6KEQwCj77a
         9paZhLNjEG6i/59N1UCZ85omKQCe0m1IxvCI5I2YWD6L9d27Eu4XX51otIlJGWVzFK4h
         RPl+YP1acDMeYBRzbNYV5UtmG/Yh3CNkPquK973nq2Rpn7mqgbGs2Wb64TWzIYP0QXBE
         Z/kpbXkeVJ0HQcjg9PHFfQ9p79P6Sw9UVPVij/Q1AzIZaIPdG4YSJV82F3oc1owYn+yS
         haYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698274670; x=1698879470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=au+FPuig5k+lPrQlpRTaaMDYkgX5B4VtECHua21n4XI=;
        b=CjZ2HLOJ6bFTd79iWjjFMb0jE8f5kAtvTVd+TnxSXMnui+LiE9uyrXAWfXYwdVInBF
         YZRdTrMGsx5r5rA30PnA1+ExrP/SzfZoxheF2oNY9XHDFMFweKNa3rfO+oOlf90k2A24
         un7ML7Py16DZJ3X8QXPwDwVxFvvZhS9YJ34aXdWV8JhgYx9Om2PFgU0ws9UMrPBPHPqX
         5RaEvRjDNS0mCnq2WTkYk0e+mTzjC5Xq2BWFgcLYsZReQ2Jw9AuTeCOHzoSmakMgWb3p
         Y6TB7NTEBZybr7bSM0FrXM3WzK6cmNbU5jHTAzQH1rJrWc9nQtRFOH8GQZkJJcQ66qND
         HJYg==
X-Gm-Message-State: AOJu0YwC544ncM2LO6LT7aVQNiM85TxM2hZhXfyvnCF8iP8JpCi/Ml6V
        aj/GwSDAdIgO+177RJW2lNyJMBqr2CUC+kTaAiE=
X-Google-Smtp-Source: AGHT+IGU47JdMqos7fO6p5imxOdLw4B74QAjLAOxf+u0z6b8pjBuqRSaQG2hW/4pCt9lDCL0gjNUb8PHcjne7NHWbIw=
X-Received: by 2002:a50:d094:0:b0:53e:df4:fe72 with SMTP id
 v20-20020a50d094000000b0053e0df4fe72mr11126100edd.32.1698274669569; Wed, 25
 Oct 2023 15:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697430866.git.wqu@suse.com> <7b951f3a0619880f35f2490e2e251eb35e2f2292.1697430866.git.wqu@suse.com>
 <20231017134929.GA2350212@perftesting> <3df53251-41f6-4655-a0fe-a7baecb2a66d@gmx.com>
 <20231017231128.GA26353@twin.jikos.cz> <fd864ecf-5887-4b3f-94be-352b87fe29df@suse.com>
 <20231024173806.GR26353@suse.cz> <136e8bf5-3b77-4e66-be24-54cd7e14b83a@gmx.com>
 <20231025161832.GA21328@suse.cz>
In-Reply-To: <20231025161832.GA21328@suse.cz>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Wed, 25 Oct 2023 18:57:12 -0400
Message-ID: <CAEg-Je-za+TuA07H1qdKcnMfMBBUw7hb7-zhXgtg=KXgKr_XRQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] btrfs-progs: use a unified btrfs_make_subvol() implementation
To:     dsterba@suse.cz
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 25, 2023 at 12:26=E2=80=AFPM David Sterba <dsterba@suse.cz> wro=
te:
>
> On Wed, Oct 25, 2023 at 07:14:58AM +1030, Qu Wenruo wrote:
> >
> >
> > On 2023/10/25 04:08, David Sterba wrote:
> > > On Wed, Oct 18, 2023 at 10:20:57AM +1030, Qu Wenruo wrote:
> > >>>>> We're moving towards a world where kernel-shared will be an exact=
-ish copy of
> > >>>>> the kernel code.  Please put helpers like this in common/, I did =
this for
> > >>>>> several of the extent tree related helpers we need for fsck, this=
 is a good fit
> > >>>>> for that.  Thanks,
> > >>>>
> > >>>> Sure, and this also reminds me to copy whatever we can from kernel=
.
> > >>>
> > >>> I do syncs from kernel before a release but all the low hanging fru=
it is
> > >>> probably gone so it needs targeted updates.
> > >>
> > >> For the immediate target it's btrfs_inode and involved VFS structure=
s
> > >> for inodes/dir entries.
> > >>
> > >> In progs we don't have a structure to locate a unique inode (need bo=
th
> > >> rootid and ino number), nor to do any path resolution.
> > >>
> > >> This makes it almost impossible to proper sync the code.
> > >>
> > >> But introduce btrfs_inode to btrfs-progs would also be a little
> > >> overkilled, as we don't have that many users.
> > >> (Only the new --rootdir with --subvol combination).
> > >
> > > I have an idea for using this functionality, but you may not like it =
-
> > > we could implement FUSE.
> >
> > In fact I really like it.
> >
> > > The missing code is exactly about inodes, path
> > > resolution and subvolumes. You have the other project, with a differe=
nt
> > > license, although there's a lot shared code. You can keep it so u-boo=
t
> > > can do the sync and keep the read-only support. I'd like to have full
> > > read-write support with subvolumes and devices (if there's ioctl pass
> > > through), but it's not urgent. Having the basic inode/path support wo=
uld
> > > be good for mkfs even in a smaller scope.
> >
> > The existing blockage would be fsck.
> > If we want FUSE, inode is super handy, but for fsck doing super low
> > level fixes, it can be a burden instead.
> > As it needs to repair INODE_REF/DIR_INDEX/DIR_ITEMs, sometimes even
> > missing INODE_ITEMs, not sure how hard it would be to maintain both
> > btrfs_inode and low-level code.
>
> I'd have to look what exactly are the problems but yes check is special
> in many ways. It could be possible to have an "enhanced" inode used in
> check and regular inode everywhere else.
>
> > There are one big limiting factor in FUSE, we can not control the devic=
e
> > number, unlike kernel.
> > This means even we implemented the subvolume code (like my btrfs-fuse
> > project), there is no way to detect subvolume boundary.
>
> This could be a problem. We can set the inode number to 256 but
> comparing two random files if they're in the same subvolume would
> require traversing the whole path. This would not work with 'find -xdev'
> and similar.
>

Couldn't you use CUSE to create a btrfs-fuse device that could give
you that information?

> > Then comes with some other super personal concerns:
> >
> > - Can we go Rust instead of C?
>
> I know rust on the very beginner level, and I don't think we have enough
> rust knowledge in the developers group.  The language syntax or features
> are still evolving, we'd lose the build support on any older distros or
> distros that don't keep up with the versions. The C-rust
> interoperability is good but it can become a burden. I'm peeking to the
> kernel rust support from time to time and I can't comprehend what it's
> doing.
>
> > - Can we have a less restrict license to maximize the possibility of
> >    code share?
>
> The way it's now it's next to impossible. Sharing GPL code works among
> GPL projects, anything else must be written from scratch. I don't know
> how much you did that in the btrfs-fuse project
>
> >    Well, I should ask this question to GRUB....
> >    But a more hand-free license like MIT may really help for bootloader=
s.
>
> You can keep your btrfs-fuse to be the code base with loose license for
> bootloaders, but you can't copy any code.

There's also an independent implementation that's LGPLv3 (admittedly
targeted at Windows, but it could still be useful):
https://github.com/maharmstone/btrfs

But even a full-fledged GPLv2 implementation would be fine if we could
wrap it in FUSE+CUSE and as an EFI module.

Most of the freakout is with the GNU v3 licenses (though I disagree
with those who don't like them), and our stack is basically GNU v2.



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

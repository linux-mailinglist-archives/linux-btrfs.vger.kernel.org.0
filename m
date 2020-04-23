Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC451B5AC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Apr 2020 13:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgDWLvq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Apr 2020 07:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727081AbgDWLvq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Apr 2020 07:51:46 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92D4C035494
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Apr 2020 04:51:44 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 10so1640912vkr.7
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Apr 2020 04:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=IyRLkEDOOZqTpsDVREsBz/AP4byOpRZ5taObET1Df78=;
        b=Ftck4/RHUivWAlaIMzNOJa9zcMQlqeLA+XJIGVJKWXXtWU/00qa2sVDr+jp2fe6mIG
         7EVo9FCzezhPStZfU2/t1kPc84GkOt6DIz4njNOoPA2ZzpuKsnzAjNuighk8p+9KBHdO
         XJJGzudeu/6QRAeAn/23BE6fvmi3g5wcNH4eCl0Bv+JwhY7UoowW2nkD/YlwHUVfky5e
         1iblRpjDaa3Sl8xqcQ9M+l5kWHnBzoy6zf7U/FbdpbHr0YAm9OEDy9aI8C9S9jVQB49i
         +xb629BApSEdwUAvRtxB+5QOkIHKeKDo3Ks6ULP/ChxJyn4tNfOrKlzLOhAXXDLOSoYh
         8jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=IyRLkEDOOZqTpsDVREsBz/AP4byOpRZ5taObET1Df78=;
        b=DcX0OuHYkFRbvNy95HYrou8GSNtvlsc9yIiTpzaG1seio6wiMF1CvzgFyteUJMZ35J
         r25WdVVjp018qjxYVcYOkqxtYyXp+yq5F0IPk5kIdScfGStSpPIjkVKdFhuOCNi1abG9
         +4MoPGxhTuwmRcCVdSMvYMLVXYrHrrTBlbuDeCD2/Hbjty0s7XeOPWYaeK1w4kt+CJwO
         2cZ0ZPUO7u5LEjHEHqxn9rkuVfqZMPAjvnw25C6A1J1dJAYYDzmyuj5xvt8pTe9ncRRQ
         HMwwEKyMp6SxH2FCbDh5L/vdDMtatDXRl+nDOp/KkM0xt1zM6vYE9zzeLsA1EaW9drOI
         uN3Q==
X-Gm-Message-State: AGi0Puab7c5m5d0MPO15UMpvCnCBzyjwpFEcdCz5zpQvJypq7856bs91
        npLPDMDAevckiySWBU37kMz1IVaDO5Cxa9vWRx3Jwg==
X-Google-Smtp-Source: APiQypK7Eo6+1uTjY3M93ZuprnHygLhzwrgu8dwaPzP4HuNElAu4gKZLuW322s+I8f2dlpbLJ7i0hT61C3GY73Rbq/E=
X-Received: by 2002:a1f:d841:: with SMTP id p62mr2997406vkg.13.1587642703483;
 Thu, 23 Apr 2020 04:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200422205209.0e2efd53@nic.cz> <CAJCQCtTDGb1hAAdp1-ph0wzFcfQNyAh-+hNMipdRmK0iTZA8Xw@mail.gmail.com>
 <CAJCQCtTEY347CwHGz3QKaBfxvPg0pTz_CF+OaiZNaCEGcnLfYA@mail.gmail.com>
 <20200422225851.3d031d88@nic.cz> <CAL3q7H7eE4wFi95JaTYRPOrTQiihOSEqV-W4hT1t-9-ptUHGrg@mail.gmail.com>
 <20200423134248.458cd87c@nic.cz>
In-Reply-To: <20200423134248.458cd87c@nic.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 23 Apr 2020 12:51:32 +0100
Message-ID: <CAL3q7H41C6do6SdBCfCmA==TT1nPJQ4dB0vTi_jsm0tYuvvsUA@mail.gmail.com>
Subject: Re: when does btrfs create sparse extents?
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 23, 2020 at 12:42 PM Marek Behun <marek.behun@nic.cz> wrote:
>
> On Thu, 23 Apr 2020 11:49:16 +0100
> Filipe Manana <fdmanana@gmail.com> wrote:
>
> > On Wed, Apr 22, 2020 at 10:00 PM Marek Behun <marek.behun@nic.cz> wrote=
:
> > >
> > > On Wed, 22 Apr 2020 14:44:46 -0600
> > > Chris Murphy <lists@colorremedies.com> wrote:
> > >
> > > > e.g. from a 10m file created with truncate on two Btrfs file system=
s
> > > >
> > > > original holes format (default)
> > > >
> > > >     item 6 key (257 EXTENT_DATA 0) itemoff 15768 itemsize 53
> > > >         generation 7412 type 1 (regular)
> > > >         extent data disk byte 0 nr 0
> > > >         extent data offset 0 nr 10485760 ram 10485760
> > > >         extent compression 0 (none)
> > > >
> > > > On a file system with no-holes feature set, this item simply doesn'=
t
> > > > exist. I think basically it works by inference. Both kinds of files
> > > > have size in the INODE_ITEM, e.g.
> > > >
> > > >     item 4 key (257 INODE_ITEM 0) itemoff 32245 itemsize 160
> > > >         generation 889509 transid 889509 size 10485760 nbytes 0
> > > >
> > > > Sparse extents are explicitly stated in the original format with di=
sk
> > > > byte 0 in an EXTENT_DATA item; whereas in the newer format, sparse
> > > > extents exist whenever EXTENT_DATA items don't completely describe =
the
> > > > file's size.
> > >
> > > Ok this means that U-Boot currently gained support for the original
> > > sparse extents.
> >
> > To clear any confusion, what you mean by sparse extents is actually hol=
es.
> > The concept of sparse files exists (files with holes, regions of a
> > file for which there is no allocated extent), but not sparse extents.
> >
> > >
> > > I fear that current u-boot does not handle the new no-holes feature.
> >
> > The no-holes feature has been around since 2013, not exactly new, but
> > it's not the default yet when creating a new filesystem.
> >
> > As it has been mentioned earlier by Chris, it just removes the need
> > for explicitly having metadata representing holes.
> > When not using the no-holes feature, there is an explicit file extent
> > item pointing to a disk location of 0 (disk_bytenr field has a value
> > of 0) for each file hole.
> > When using no-holes, there's no such file extent item - btrfs knows
> > about the hole by checking that there is a gap between two consecutive
> > file extent items (both having a disk_bytenr > 0).
>
> This I already understand. My main question though is: does kernel or
> btrfs do checking (at least sometimes) when writing a block of data onto
> disk if this block is all zero, and if yes, then this block is written
> as a hole (either by writing hole item or not writing anything)?
>
> Or does this happen ONLY when requested by userspace?

There's nothing in btrfs that converts a sequence of zeroes
automatically to a hole.

It always has to be done by user space, either by writes that leave
holes intentionally (e.g. create file, write 64K to offset 0, write 4K
to offset 128, leaves a hole from range 64K to 128K) or by hole
punching through fallocate().

>
> Because for the love of god I cannot find why our kernel is being
> written this way onto disk - the installer doesn't explicitly request
> for PUNCH_HOLES nor anything, as far as I looked.
>
> Marek
>
> Marek



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

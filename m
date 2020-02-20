Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE0FE1661E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2020 17:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgBTQJc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Feb 2020 11:09:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbgBTQJc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Feb 2020 11:09:32 -0500
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C8E524670
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 16:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582214971;
        bh=6/yxuPNEvYTP4tklP601Czr9EYylkhvSDyH1uzMwrII=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bc9fMOgFPx0LG4utN/7F+MEJ/k7RrrlYxDDChiHTAcLMiDaRyXfdXSrUT26nluaND
         DIN+HHEjQvXHSxtXsp3Mnrtg97V/e+Lt9ugN4wdQBRD8Mc82B9TEUi5TBVP64LxH8+
         dLEm+LotH07RwztEUzadBmUYuZWmpASvsNTBgYLE=
Received: by mail-vs1-f46.google.com with SMTP id k188so3003736vsc.8
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2020 08:09:31 -0800 (PST)
X-Gm-Message-State: APjAAAXk2oCGic+cH/eCnP7MF30dqmourN2OS23zgBx42pZUZ3sLJCJK
        g/hUP9cppxGYf/28Z+Oiq0E0JCE9kjKiAyZrM1A=
X-Google-Smtp-Source: APXvYqzlzuaWhgde+tS6XZYmIlTGA79Z/3Ob38SxBDhJkL76EQhjExppnS0vVWlIxYZXF/tU0k/EfEhSYhk14DeOGOI=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr17375214vsq.206.1582214970101;
 Thu, 20 Feb 2020 08:09:30 -0800 (PST)
MIME-Version: 1.0
References: <20200219140615.1641680-1-fdmanana@kernel.org> <4ac11008-d118-1877-151d-3e7da3e9a73a@toxicpanda.com>
In-Reply-To: <4ac11008-d118-1877-151d-3e7da3e9a73a@toxicpanda.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 20 Feb 2020 16:09:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5buWQjhR2JTNyPVhZStJui8DKpUBhv1J_m8FVsbBWZ=Q@mail.gmail.com>
Message-ID: <CAL3q7H5buWQjhR2JTNyPVhZStJui8DKpUBhv1J_m8FVsbBWZ=Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] Btrfs: implement full reflink support for inline extents
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 20, 2020 at 3:30 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 2/19/20 9:06 AM, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > There are a few cases where we don't allow cloning an inline extent into
> > the destination inode, returning -EOPNOTSUPP to user space. This was done
> > to prevent several types of file corruption and because it's not very
> > straightforward to deal with these cases, as they can't rely on simply
> > copying the inline extent between leaves. Such cases require copying the
> > inline extent's data into the respective page of the destination inode.
> >
> > Not supporting these cases makes it harder and more cumbersome to write
> > applications/libraries that work on any filesystem with reflink support,
> > since all these cases for which btrfs fails with -EOPNOTSUPP work just
> > fine on xfs for example. These unsupported cases are also not documented
> > anywhere and explaining which exact cases fail require a bit of too
> > technical understanding of btrfs's internal (inline extents and when and
> > where can they exist in a file), so it's not really user friendly.
> >
> > Also some test cases from fstests that use fsx, such as generic/522 for
> > example, can sporadically fail because they trigger one of these cases,
> > and fsx expects all operations to succeed.
> >
> > This change adds supports for cloning all these cases by copying the
> > inline extent's data into the respective page of the destination inode.
> >
> > With this change test case btrfs/112 from fstests fails because it
> > expects some clone operations to fail, so it will be updated. Also a
> > new test case that exercises all these previously unsupported cases
> > will be added to fstests.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/reflink.c | 212 ++++++++++++++++++++++++++++++++-------------
> >   1 file changed, 152 insertions(+), 60 deletions(-)
> >
> > diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> > index 7e7f46116db3..c19c87de6d4a 100644
> > --- a/fs/btrfs/reflink.c
> > +++ b/fs/btrfs/reflink.c
> > @@ -1,8 +1,12 @@
> >   // SPDX-License-Identifier: GPL-2.0
> >
> >   #include <linux/iversion.h>
> > +#include <linux/blkdev.h>
> >   #include "misc.h"
> >   #include "ctree.h"
> > +#include "btrfs_inode.h"
> > +#include "compression.h"
> > +#include "delalloc-space.h"
> >   #include "transaction.h"
> >
> >   #define BTRFS_MAX_DEDUPE_LEN        SZ_16M
> > @@ -43,30 +47,121 @@ static int clone_finish_inode_update(struct btrfs_trans_handle *trans,
> >       return ret;
> >   }
> >
> > +static int copy_inline_to_page(struct inode *inode,
> > +                            const u64 file_offset,
> > +                            char *inline_data,
> > +                            const u64 size,
> > +                            const u64 datal,
> > +                            const u8 comp_type)
> > +{
> > +     const u64 block_size = btrfs_inode_sectorsize(inode);
> > +     const u64 range_end = file_offset + block_size - 1;
> > +     const size_t inline_size = size - btrfs_file_extent_calc_inline_size(0);
> > +     char *data_start = inline_data + btrfs_file_extent_calc_inline_size(0);
> > +     struct extent_changeset *data_reserved = NULL;
> > +     struct page *page = NULL;
> > +     bool page_locked = false;
> > +     int ret;
> > +
> > +     ASSERT(IS_ALIGNED(file_offset, block_size));
> > +
> > +     ret = btrfs_delalloc_reserve_space(inode, &data_reserved, file_offset,
> > +                                        block_size);
>
> This could potentially deadlock, as we could need to flush delalloc for this
> inode that we've dirtied pages for and not be able to make progress because we
> have this range locked.

But we have already flushed the range before, after locking the inode
and waiting for dio requests,
so during the reflink operation no one should be able to dirty pages
in the range. Or did I miss some edge case?

thanks

>
> Josef

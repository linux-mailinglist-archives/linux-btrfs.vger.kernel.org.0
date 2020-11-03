Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B7C2A5009
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 20:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgKCTXj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 14:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgKCTXi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 14:23:38 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13189C0613D1
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 11:23:37 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id i18so12321853ots.0
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Nov 2020 11:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=7Z+do9bruyxlUgBG0zhbnZo9zC6m19RC63h5up2d4Yo=;
        b=kvRIiBQvLEr2M6f6DwvPupVRELPcf7FStSN/MeYDVhwvxd3Xw/wUE9Ty/0mKSR3TGk
         jS+V/5dLxfjTtPzTl0JanM8sSjdjUD+k5L1P6yEND84NvCZc6I0TY3mTuKm053UDIJmn
         4vETW3tLTTORs+t6IE0dM9ZDtcaZ7qu80cnCG2weDzDiczqJmr/C5JcOBO0LLiPU1RYk
         gccu9N66D5zZUvqF7nhXOBl2ZHsbGk1PiDY7qNPw/kA2BEjgyVMvVndc16YWSIbh1yFY
         s7/QWTLJ7wilgq23HyDU3opYBRkJlUdYuZXbTqqGPM9RaNn2JX/ZXDTvjgRQR5dL6Tly
         kM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7Z+do9bruyxlUgBG0zhbnZo9zC6m19RC63h5up2d4Yo=;
        b=MPObO+yPxpCHQ2gclCddd6u8Gb4WroCL19sKOPOmFjau1ajtnPErGMNJIf1J475Pvp
         nwY5jjeFY3tEiEOy6P3edFpKQogSo9PxNBCktmrCwGwzgetDcywKgfc2W/ZYw/z/AoQ6
         1ajfZCxffSoDnkIFdTu5UIK762tLfznwtLZLZQiq7HZYVfMrH/KYxX1NydG7GWFzl2Z0
         X3/n7gQm+9g7RMhpODHN/njz7D77OYcAFFNOtrAKOflZa43zs4hzrqiTMwkWkeJjahR6
         yHJEjqSY2c9EGpwdcOyXF9SxwUUYw6YvMGGwvZsH1j9pEvpNBeTny0Uw58YBKDBgBlT6
         hHLw==
X-Gm-Message-State: AOAM530oAaRy8R5TkzrvI5zdbRhz7k/5WqcmLsyXlfhIuWfyWGauZokw
        qu+WLvA9RILq8+Tbw+fanFPJgrXDBNWfY0zIeqzDilrFw/Y=
X-Google-Smtp-Source: ABdhPJyYQ7gviBgZvchvjEkL1D6bJuVKAqz8nxT2og9q/bGfV+JZdNtZPb3PYtk/ASWz9OG/e/itN5yZmvBqv4G5F0Q=
X-Received: by 2002:a05:6830:1644:: with SMTP id h4mr4889394otr.185.1604431416528;
 Tue, 03 Nov 2020 11:23:36 -0800 (PST)
MIME-Version: 1.0
References: <20201028072432.86907-1-wqu@suse.com> <20201028072432.86907-3-wqu@suse.com>
 <20201103191609.GC6756@twin.jikos.cz>
In-Reply-To: <20201103191609.GC6756@twin.jikos.cz>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 3 Nov 2020 11:23:25 -0800
Message-ID: <CAE1WUT75ZSbnb=VVONYbreVOjzZs6_ZhL+RKf9Zot0QYp3jtsw@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: ordered-data: rename parameter @len to @nr_sectors
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 3, 2020 at 11:18 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Oct 28, 2020 at 03:24:31PM +0800, Qu Wenruo wrote:
> > The parameter is the number of sectors of the range to search.
> > While most "len" we used in other locations are in byte size, this can
> > lead to confusion.
> >
> > Rename @len to @nr_sectors to make it more clear and avoid confusion.
> >
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >  fs/btrfs/ordered-data.c | 9 ++++++---
> >  fs/btrfs/ordered-data.h | 2 +-
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> > index ebac13389e7e..10c13f8a1603 100644
> > --- a/fs/btrfs/ordered-data.c
> > +++ b/fs/btrfs/ordered-data.c
> > @@ -802,9 +802,11 @@ btrfs_lookup_first_ordered_extent(struct inode *inode, u64 file_offset)
> >   * search the ordered extents for one corresponding to 'offset' and
> >   * try to find a checksum.  This is used because we allow pages to
> >   * be reclaimed before their checksum is actually put into the btree
> > + *
> > + * @nr_sectors:      The length of the search range, in sectors.
>
> Please add all parameters

Yeah, having all parameters will be important for documentation
purposes. Shouldn't need too much effort, just quick descriptions
of the parameters.

Best regards,
Amy Parker
(they/them)

>
> >   */
> >  int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
> > -                        u8 *sum, int len)
> > +                        u8 *sum, int nr_sectors)

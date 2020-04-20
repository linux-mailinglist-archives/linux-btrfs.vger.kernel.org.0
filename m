Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0FE1B129F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 19:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgDTRHU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 13:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgDTRHU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 13:07:20 -0400
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC6322145D;
        Mon, 20 Apr 2020 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587402439;
        bh=5+DhJHjU4Yd1UDtcQq7boJrEorrJHmIHlSdtCaXrCaM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lk5PTWul/M9pQOjNKFXcKmWMYIukxTb29+8LKz9OHAhiZqJTf1HkkdwW+8w+dI/5G
         mrRAnl23iY2myzT+xOiCCe7yZnJ8r9b7cD+QnB+VWKEshfT+uCFnVK4j8o6TX21s8s
         pa8ty9+I+SsVHkpWj8AuG1mvqvy2B+FMKHSz8IPM=
Received: by mail-ua1-f41.google.com with SMTP id v24so3942881uak.0;
        Mon, 20 Apr 2020 10:07:19 -0700 (PDT)
X-Gm-Message-State: AGi0PuYJl833toSHcw/Wv+dWvxDkNTukVYsT1ezCwhTM418JaT30g2Lw
        aQ1BssoElHBg/scw+5up/r0migf1id0yrrpOInM=
X-Google-Smtp-Source: APiQypIieetyUEir5DH5riE5ff5N5Hlm3yeznUN2e0Ap4O2kdJdTniNCFt+/5QbBoa3oMtbyxHF4uQf/EbRmxc6VJcw=
X-Received: by 2002:ab0:6949:: with SMTP id c9mr1608902uas.27.1587402438757;
 Mon, 20 Apr 2020 10:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200408103552.11339-1-fdmanana@kernel.org> <20200417171020.GB13463@bfoster>
 <CAL3q7H5nxP5tt8i=i0uQoG7VBs94O=ZkcAz8khS-DGCTTQG1=g@mail.gmail.com>
 <20200417172606.GF13463@bfoster> <CAL3q7H5YSrV6Z+aB=ncSQiUfbACWgMArVRB9xu0Dhx0mTp3bZA@mail.gmail.com>
 <20200417174752.GG13463@bfoster> <CAL3q7H6bS1dL2pUawmc0z3ZXop7xg0P5O8rBkqbP11V9D+295Q@mail.gmail.com>
 <20200417182534.GH13463@bfoster>
In-Reply-To: <20200417182534.GH13463@bfoster>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 20 Apr 2020 18:07:07 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4d7uirPTgmkfXzYKBm3L4TntbKOm_S1snCxcjzji9=vQ@mail.gmail.com>
Message-ID: <CAL3q7H4d7uirPTgmkfXzYKBm3L4TntbKOm_S1snCxcjzji9=vQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] fsx: add missing file size update on zero range operations
To:     Brian Foster <bfoster@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 17, 2020 at 7:25 PM Brian Foster <bfoster@redhat.com> wrote:
>
> On Fri, Apr 17, 2020 at 06:53:27PM +0100, Filipe Manana wrote:
> > On Fri, Apr 17, 2020 at 6:48 PM Brian Foster <bfoster@redhat.com> wrote:
> > >
> > > On Fri, Apr 17, 2020 at 06:32:03PM +0100, Filipe Manana wrote:
> > > > On Fri, Apr 17, 2020 at 6:26 PM Brian Foster <bfoster@redhat.com> wrote:
> > > > >
> > > > > On Fri, Apr 17, 2020 at 06:20:24PM +0100, Filipe Manana wrote:
> > > > > > On Fri, Apr 17, 2020 at 6:10 PM Brian Foster <bfoster@redhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Apr 08, 2020 at 11:35:52AM +0100, fdmanana@kernel.org wrote:
> > > > > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > > > > >
> > > > > > > > When a zero range operation increases the size of the test file we were
> > > > > > > > not updating the global variable 'file_size' which tracks the current
> > > > > > > > size of the test file. This variable is used to for example compute the
> > > > > > > > offset for a source range of clone, dedupe and copy file range operations.
> > > > > > > >
> > > > > > > > So just fix it by updating the 'file_size' global variable whenever a zero
> > > > > > > > range operation does not use the keep size flag and its range goes beyond
> > > > > > > > the current file size.
> > > > > > > >
> > > > > > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > > > > > ---
> > > > > > > >  ltp/fsx.c | 2 ++
> > > > > > > >  1 file changed, 2 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > > > > > index 9d598a4f..fa383c94 100644
> > > > > > > > --- a/ltp/fsx.c
> > > > > > > > +++ b/ltp/fsx.c
> > > > > > > > @@ -1212,6 +1212,8 @@ do_zero_range(unsigned offset, unsigned length, int keep_size)
> > > > > > > >       }
> > > > > > > >
> > > > > > > >       end_offset = keep_size ? 0 : offset + length;
> > > > > > > > +     if (!keep_size && end_offset > file_size)
> > > > > > > > +             file_size = end_offset;
> > > > > > >
> > > > > > > Should this ever happen if the caller uses TRIM_OFF_LEN() on the
> > > > > > > offset and length?
> > > > > >
> > > > > > TRIM_OFF_LEN only trims the range, not the file_size.
> > > > > > Or did I miss something?
> > > > > >
> > > > >
> > > > > Right, but TRIM_LEN() does:
> > > > >
> > > > >         if ((off) + (len) > (size))             \
> > > > >                 (len) = (size) - (off);         \
> > > > >
> > > > > ... where size is file_size. Hm?
> > > >
> > > > That only updates the range's length, not the file_size.
> > > >
> > >
> > > Yes, but it caps the range to within file_size.
> >
> > Yes.
> >
> > The problem I'm trying to solve is that because the file_size is not
> > updated by zero range operations,
> > a following clone/dedupe/copy_range call will not be able to use a
> > range that crosses the old file size and goes up to the new file size.
> >
> > I.e. I'm not solving a problem where the range for those operations
> > (or any others) incorrectly crosses eof - that doesn't happen because
> > of the TRIM_* macros.
> >
> > Does it make sense now?
> >
>
> Not really. When is end_offset > file_size ever true in do_zero_range()?

Ok, I see what you mean now. It's the trimming before calling the zero
range function.
So we have a different type of problem - we never exercise zero range
operations that cross the current eof.

Patch updated in the next verson.

Thanks.

>
> Brian
>
> > Thanks.
> >
> >
> > >
> > > > Also, if you check the global style, you'll see that in the function
> > > > for every operation that can change file size we do update file_size
> > > > explicitly (e.g. do_preallocate(), and we call TRIM_OFF_LEN before
> > > > calling it as well).
> > > >
> > >
> > > do_preallocate() (fallocate) passes maxfilelen instead of file_size, as
> > > does write and mapwrite. Insert range uses TRIM_LEN() directly but also
> > > passes maxfilelen.
> > >
> > > Brian
> > >
> > > > Thanks.
> > > >
> > > > >
> > > > > Brian
> > > > >
> > > > > > Thanks.
> > > > > >
> > > > > > >
> > > > > > > Brian
> > > > > > >
> > > > > > > >
> > > > > > > >       if (end_offset > biggest) {
> > > > > > > >               biggest = end_offset;
> > > > > > > > --
> > > > > > > > 2.11.0
> > > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>

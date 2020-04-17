Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55E01AE3D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 19:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgDQRcQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 13:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728602AbgDQRcQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 13:32:16 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E6AB208E4;
        Fri, 17 Apr 2020 17:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587144735;
        bh=+gLEtmxGpMJDt7gNbvlK3Ej15VaM5j4DQBKXCE4SCdA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Megzn2Ay5+J/8TwTmRw/hUYTxztVEMnKTEYzrgPGgU7M6osbHhi1XBy3FfMHI9Xdu
         ZUYfrGQgsEmwbexGN0HXB+rZc3DJzCUvlMl1R6GJwUmDbkGM5l98hMoch6em4BI2hF
         0x4uXrUW9yxzXAHkJFwkpO7CVgTbbyt5TUI48/Z8=
Received: by mail-vs1-f43.google.com with SMTP id s2so1654797vsm.10;
        Fri, 17 Apr 2020 10:32:15 -0700 (PDT)
X-Gm-Message-State: AGi0Pua3ntYoGcLLP+unKCqs7bmN5YzhCHJ+Komt/eyJbPSyq0UJb4D1
        8/sHeoRzlMsQv1Z7BDkeVvopnZnXeXolqiA3S0s=
X-Google-Smtp-Source: APiQypLfftZP5l4WPKb9V9LKrQM8cqkrLT1tQ8Qd0+1PB49ov8NDCiVf/LIiiG2u+nu29g0bb82SN3vvLoEOfHojHFM=
X-Received: by 2002:a05:6102:2414:: with SMTP id j20mr3538511vsi.206.1587144734299;
 Fri, 17 Apr 2020 10:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200408103552.11339-1-fdmanana@kernel.org> <20200417171020.GB13463@bfoster>
 <CAL3q7H5nxP5tt8i=i0uQoG7VBs94O=ZkcAz8khS-DGCTTQG1=g@mail.gmail.com> <20200417172606.GF13463@bfoster>
In-Reply-To: <20200417172606.GF13463@bfoster>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 17 Apr 2020 18:32:03 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5YSrV6Z+aB=ncSQiUfbACWgMArVRB9xu0Dhx0mTp3bZA@mail.gmail.com>
Message-ID: <CAL3q7H5YSrV6Z+aB=ncSQiUfbACWgMArVRB9xu0Dhx0mTp3bZA@mail.gmail.com>
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

On Fri, Apr 17, 2020 at 6:26 PM Brian Foster <bfoster@redhat.com> wrote:
>
> On Fri, Apr 17, 2020 at 06:20:24PM +0100, Filipe Manana wrote:
> > On Fri, Apr 17, 2020 at 6:10 PM Brian Foster <bfoster@redhat.com> wrote:
> > >
> > > On Wed, Apr 08, 2020 at 11:35:52AM +0100, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > When a zero range operation increases the size of the test file we were
> > > > not updating the global variable 'file_size' which tracks the current
> > > > size of the test file. This variable is used to for example compute the
> > > > offset for a source range of clone, dedupe and copy file range operations.
> > > >
> > > > So just fix it by updating the 'file_size' global variable whenever a zero
> > > > range operation does not use the keep size flag and its range goes beyond
> > > > the current file size.
> > > >
> > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > ---
> > > >  ltp/fsx.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > > > index 9d598a4f..fa383c94 100644
> > > > --- a/ltp/fsx.c
> > > > +++ b/ltp/fsx.c
> > > > @@ -1212,6 +1212,8 @@ do_zero_range(unsigned offset, unsigned length, int keep_size)
> > > >       }
> > > >
> > > >       end_offset = keep_size ? 0 : offset + length;
> > > > +     if (!keep_size && end_offset > file_size)
> > > > +             file_size = end_offset;
> > >
> > > Should this ever happen if the caller uses TRIM_OFF_LEN() on the
> > > offset and length?
> >
> > TRIM_OFF_LEN only trims the range, not the file_size.
> > Or did I miss something?
> >
>
> Right, but TRIM_LEN() does:
>
>         if ((off) + (len) > (size))             \
>                 (len) = (size) - (off);         \
>
> ... where size is file_size. Hm?

That only updates the range's length, not the file_size.

Also, if you check the global style, you'll see that in the function
for every operation that can change file size we do update file_size
explicitly (e.g. do_preallocate(), and we call TRIM_OFF_LEN before
calling it as well).

Thanks.

>
> Brian
>
> > Thanks.
> >
> > >
> > > Brian
> > >
> > > >
> > > >       if (end_offset > biggest) {
> > > >               biggest = end_offset;
> > > > --
> > > > 2.11.0
> > > >
> > >
> >
>

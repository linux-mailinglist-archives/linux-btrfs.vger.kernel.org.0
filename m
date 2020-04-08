Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2961A2798
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 18:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgDHQ5k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 12:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729351AbgDHQ5k (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Apr 2020 12:57:40 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AEE520820;
        Wed,  8 Apr 2020 16:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586365059;
        bh=BRD273af1MK98HEdIRlcgnk66Hcq6LUG8gt5c9bhaMo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DMT5/FQltR3fiQHfgy49YIaeNBVfaf3d9tMArDa9viDaJMjs2ofK8DnoEZbL9IIke
         fc1zx3Ztct+gCkEBDk4WZE4afCqzTJQtb8OiptdbsQhzxYqlU+8u9NhVtsdD+oxEIK
         lADHI5F0JxPbyPGDSUA9OelYgPMKfDIfSqYi73Qo=
Received: by mail-vs1-f47.google.com with SMTP id x206so5121846vsx.5;
        Wed, 08 Apr 2020 09:57:38 -0700 (PDT)
X-Gm-Message-State: AGi0PuYxOCUEWVFo9QsUYlENBX65kA+j1Ip5RxXXg5XURgmGct+pyIcy
        0POgYlx4n0xLcDSKDpsMAb0SVZSyJx5CvGO2H3A=
X-Google-Smtp-Source: APiQypID0J7RzVX76xYTcA55YDV77wFN7fHmAuFCacntWlG5/YPUSWfDbaoB4ouDaJxytBhCfROnatIWJxBd745iob0=
X-Received: by 2002:a67:c594:: with SMTP id h20mr4502891vsk.95.1586365058035;
 Wed, 08 Apr 2020 09:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200408103627.11514-1-fdmanana@kernel.org> <20200408154843.GC6740@magnolia>
In-Reply-To: <20200408154843.GC6740@magnolia>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 8 Apr 2020 17:57:26 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6cSUibGXCKnOUge8+C5i6qFZB8m-SquHwXqMBjBZdLCg@mail.gmail.com>
Message-ID: <CAL3q7H6cSUibGXCKnOUge8+C5i6qFZB8m-SquHwXqMBjBZdLCg@mail.gmail.com>
Subject: Re: [PATCH 4/4] fsx: move range generation logic into a common helper
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 8, 2020 at 4:48 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Wed, Apr 08, 2020 at 11:36:27AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > We have very similar code that generates the destination range for clone,
> > dedupe and copy_file_range operations, so avoid duplicating the code three
> > times and move it into a helper function.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  ltp/fsx.c | 91 +++++++++++++++++++++++++--------------------------------------
> >  1 file changed, 36 insertions(+), 55 deletions(-)
> >
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index 89a5f60e..8873cd01 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > @@ -1930,6 +1930,36 @@ range_overlaps(
> >       return llabs((unsigned long long)off1 - off0) < size;
> >  }
> >
> > +static void generate_dest_range(unsigned long op,
> > +                             unsigned long max_range_end,
> > +                             unsigned long *src_offset,
> > +                             unsigned long *size,
> > +                             unsigned long *dst_offset)
> > +{
> > +     int tries = 0;
> > +
> > +     TRIM_OFF_LEN(*src_offset, *size, file_size);
> > +     if (op == OP_COPY_RANGE) {
>
> It feels funny that we pass in @op just to let COPY RANGE relax the
> block size alignment requirements.  How about passing a block_align
> parameter (instead of op) which would be the subject of the if test?
> This way we concentrate the alignment requirement knowlege of each type
> of call in the "case OP_FOO" part of the code instead of scattering it?

You mean something like the following:

https://pastebin.com/e2NZKbZV

?

>
> --D
>
> > +             *src_offset -= *src_offset % readbdy;
> > +             if (o_direct)
> > +                     *size -= *size % readbdy;
> > +     } else {
> > +             *src_offset = *src_offset & ~(block_size - 1);
> > +             *size = *size & ~(block_size - 1);
> > +     }
> > +
> > +     do {
> > +             if (tries++ >= 30) {
> > +                     *size = 0;
> > +                     break;
> > +             }
> > +             *dst_offset = random();
> > +             TRIM_OFF(*dst_offset, max_range_end);
> > +             *dst_offset = *dst_offset & ~(block_size - 1);
> > +     } while (range_overlaps(*src_offset, *dst_offset, *size) ||
> > +              *dst_offset + *size > max_range_end);
> > +}
> > +
> >  int
> >  test(void)
> >  {
> > @@ -2004,63 +2034,14 @@ test(void)
> >                       keep_size = random() % 2;
> >               break;
> >       case OP_CLONE_RANGE:
> > -             {
> > -                     int tries = 0;
> > -
> > -                     TRIM_OFF_LEN(offset, size, file_size);
> > -                     offset = offset & ~(block_size - 1);
> > -                     size = size & ~(block_size - 1);
> > -                     do {
> > -                             if (tries++ >= 30) {
> > -                                     size = 0;
> > -                                     break;
> > -                             }
> > -                             offset2 = random();
> > -                             TRIM_OFF(offset2, maxfilelen);
> > -                             offset2 = offset2 & ~(block_size - 1);
> > -                     } while (range_overlaps(offset, offset2, size) ||
> > -                              offset2 + size > maxfilelen);
> > -                     break;
> > -             }
> > +             generate_dest_range(op, maxfilelen, &offset, &size, &offset2);
> > +             break;
> >       case OP_DEDUPE_RANGE:
> > -             {
> > -                     int tries = 0;
> > -
> > -                     TRIM_OFF_LEN(offset, size, file_size);
> > -                     offset = offset & ~(block_size - 1);
> > -                     size = size & ~(block_size - 1);
> > -                     do {
> > -                             if (tries++ >= 30) {
> > -                                     size = 0;
> > -                                     break;
> > -                             }
> > -                             offset2 = random();
> > -                             TRIM_OFF(offset2, file_size);
> > -                             offset2 = offset2 & ~(block_size - 1);
> > -                     } while (range_overlaps(offset, offset2, size) ||
> > -                              offset2 + size > file_size);
> > -                     break;
> > -             }
> > +             generate_dest_range(op, file_size, &offset, &size, &offset2);
> > +             break;
> >       case OP_COPY_RANGE:
> > -             {
> > -                     int tries = 0;
> > -
> > -                     TRIM_OFF_LEN(offset, size, file_size);
> > -                     offset -= offset % readbdy;
> > -                     if (o_direct)
> > -                             size -= size % readbdy;
> > -                     do {
> > -                             if (tries++ >= 30) {
> > -                                     size = 0;
> > -                                     break;
> > -                             }
> > -                             offset2 = random();
> > -                             TRIM_OFF(offset2, maxfilelen);
> > -                             offset2 -= offset2 % writebdy;
> > -                     } while (range_overlaps(offset, offset2, size) ||
> > -                              offset2 + size > maxfilelen);
> > -                     break;
> > -             }
> > +             generate_dest_range(op, maxfilelen, &offset, &size, &offset2);
> > +             break;
> >       }
> >
> >  have_op:
> > --
> > 2.11.0
> >

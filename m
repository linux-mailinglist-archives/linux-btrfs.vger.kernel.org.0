Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6419B1B1287
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Apr 2020 19:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDTRFh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Apr 2020 13:05:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgDTRFh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Apr 2020 13:05:37 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB7E2145D;
        Mon, 20 Apr 2020 17:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587402336;
        bh=wBuTLo8pa4/NCx51YN+XQ6ONYhGJIme3rK3P42kS9y4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LROWB/+mEDV8WAme8ewNrG+vpzq4WYC9EAh4xQwOlpgfPmW1DNsCT+xBI47uaSMBD
         DFa2zMc/SuG5VA7sqQIe/hfUtAg6w5opVz3VZLbKHhKjGpaAsvB3McBQpTVU/rspo7
         fp4WpINrPR9GQwLn4st7T0goLX20iFmYwJ7qY6cQ=
Received: by mail-vs1-f52.google.com with SMTP id l25so3790218vso.6;
        Mon, 20 Apr 2020 10:05:36 -0700 (PDT)
X-Gm-Message-State: AGi0PuaZOzXVYRRlNldVPeeJiXwZfzZ483ftnLehPUAJk3t45s7BOLLt
        vkDDMxJzRiInmCEkkbIIEyptFGzxlKEn4KCs/Bs=
X-Google-Smtp-Source: APiQypJkbRU5FNoPkyPxvXkx4jBhqnUPvV6RNBaAqqNNSzrboie8wKO4KqqMWaih13pl3EtxM9CVdVu28aSBCpIX2Do=
X-Received: by 2002:a67:fe0e:: with SMTP id l14mr11340191vsr.90.1587402335539;
 Mon, 20 Apr 2020 10:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200408103627.11514-1-fdmanana@kernel.org> <20200417173221.6380-1-fdmanana@kernel.org>
 <20200420143359.GL27516@bfoster>
In-Reply-To: <20200420143359.GL27516@bfoster>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 20 Apr 2020 18:05:24 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6z4Q5fR88200HqhAqKLvnH1e+kQw=xjKzihoUTm-TpjQ@mail.gmail.com>
Message-ID: <CAL3q7H6z4Q5fR88200HqhAqKLvnH1e+kQw=xjKzihoUTm-TpjQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] fsx: move range generation logic into a common helper
To:     Brian Foster <bfoster@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 20, 2020 at 3:34 PM Brian Foster <bfoster@redhat.com> wrote:
>
> On Fri, Apr 17, 2020 at 06:32:21PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > We have very similar code that generates the destination range for clone,
> > dedupe and copy_file_range operations, so avoid duplicating the code three
> > times and move it into a helper function.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >
> > V2: Turned the first parameter of the helper into a boolean as Darrick suggested.
> > V3: Added destination offset align by writebdy when bdy_align is true.
> >
> >  ltp/fsx.c | 94 ++++++++++++++++++++++++++-------------------------------------
> >  1 file changed, 39 insertions(+), 55 deletions(-)
> >
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index 89a5f60e..2e51169b 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > @@ -1930,6 +1930,39 @@ range_overlaps(
> >       return llabs((unsigned long long)off1 - off0) < size;
> >  }
> >
> > +static void generate_dest_range(bool bdy_align,
> > +                             unsigned long max_range_end,
> > +                             unsigned long *src_offset,
> > +                             unsigned long *size,
> > +                             unsigned long *dst_offset)
> > +{
> > +     int tries = 0;
> > +
> > +     TRIM_OFF_LEN(*src_offset, *size, file_size);
> > +     if (bdy_align) {
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
> > +             if (bdy_align)
> > +                     *dst_offset = *dst_offset & writebdy;
>
> That still doesn't look right (and either way we might as well use
> consistent logic for readbdy and writebdy).

Right, I made the mistakes of using & instead of % and = instead of
-=. They were not intentional, just a friday afternoon type of thing.
Thanks, correct in the next version.

>
> Brian
>
> > +             else
> > +                     *dst_offset = *dst_offset & ~(block_size - 1);
> > +     } while (range_overlaps(*src_offset, *dst_offset, *size) ||
> > +              *dst_offset + *size > max_range_end);
> > +}
> > +
> >  int
> >  test(void)
> >  {
> > @@ -2004,63 +2037,14 @@ test(void)
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
> > +             generate_dest_range(false, maxfilelen, &offset, &size, &offset2);
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
> > +             generate_dest_range(false, file_size, &offset, &size, &offset2);
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
> > +             generate_dest_range(true, maxfilelen, &offset, &size, &offset2);
> > +             break;
> >       }
> >
> >  have_op:
> > --
> > 2.11.0
> >
>

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283811AE3B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 19:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgDQRUh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 13:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbgDQRUh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 13:20:37 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BB0A2220A;
        Fri, 17 Apr 2020 17:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587144036;
        bh=5mn3qkEDquYu7MDOlaQUJuzkfYxdpXX7QLcA+PCWU6Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QM/bDmnIx5yBARUWGMPTDqQQsnxAdI0GD6V0tufd4UAYSwIQa3oBs5wRKeBaFOhJO
         3l67egkHUB26xGv+br0I1KQMMNJ/oQ/oDyCrCM2v0Am2vp1mbPri+fVRZKEcyg3xdl
         I/11Ml/NID5XkwbeO5aG3KVUaPdih8OuKGk+A7c0=
Received: by mail-vs1-f54.google.com with SMTP id y185so1637270vsy.8;
        Fri, 17 Apr 2020 10:20:36 -0700 (PDT)
X-Gm-Message-State: AGi0PuZn7+1Bkh2OpKDUFtrvQfLRSN9RJrvca6vTLYTU5lE8Q9fpXXy7
        ub8BgSq+msSeCdQN+S/r5Z8gXWskG+DVwEl9otk=
X-Google-Smtp-Source: APiQypLjw118BZltqiW/lmLeiA+5pqVIcY5m5hSispV2ndV8Dt4OEO+Hey+FIiLqIt/iDKyPTvv/WFK4tZv+7CxNI9Q=
X-Received: by 2002:a05:6102:5c4:: with SMTP id v4mr3107969vsf.95.1587144035303;
 Fri, 17 Apr 2020 10:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200408103552.11339-1-fdmanana@kernel.org> <20200417171020.GB13463@bfoster>
In-Reply-To: <20200417171020.GB13463@bfoster>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 17 Apr 2020 18:20:24 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5nxP5tt8i=i0uQoG7VBs94O=ZkcAz8khS-DGCTTQG1=g@mail.gmail.com>
Message-ID: <CAL3q7H5nxP5tt8i=i0uQoG7VBs94O=ZkcAz8khS-DGCTTQG1=g@mail.gmail.com>
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

On Fri, Apr 17, 2020 at 6:10 PM Brian Foster <bfoster@redhat.com> wrote:
>
> On Wed, Apr 08, 2020 at 11:35:52AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When a zero range operation increases the size of the test file we were
> > not updating the global variable 'file_size' which tracks the current
> > size of the test file. This variable is used to for example compute the
> > offset for a source range of clone, dedupe and copy file range operations.
> >
> > So just fix it by updating the 'file_size' global variable whenever a zero
> > range operation does not use the keep size flag and its range goes beyond
> > the current file size.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  ltp/fsx.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/ltp/fsx.c b/ltp/fsx.c
> > index 9d598a4f..fa383c94 100644
> > --- a/ltp/fsx.c
> > +++ b/ltp/fsx.c
> > @@ -1212,6 +1212,8 @@ do_zero_range(unsigned offset, unsigned length, int keep_size)
> >       }
> >
> >       end_offset = keep_size ? 0 : offset + length;
> > +     if (!keep_size && end_offset > file_size)
> > +             file_size = end_offset;
>
> Should this ever happen if the caller uses TRIM_OFF_LEN() on the
> offset and length?

TRIM_OFF_LEN only trims the range, not the file_size.
Or did I miss something?

Thanks.

>
> Brian
>
> >
> >       if (end_offset > biggest) {
> >               biggest = end_offset;
> > --
> > 2.11.0
> >
>

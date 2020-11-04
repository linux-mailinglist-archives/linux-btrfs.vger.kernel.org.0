Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FE82A5D3A
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 04:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgKDDzu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 22:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgKDDzt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 22:55:49 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF800C061A4D
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 19:55:49 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id g19so8696549otp.13
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Nov 2020 19:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jy8VfleHu+pD1+MS9EHzQVTEgh3wepSAEbnctiRLpcY=;
        b=qjqtABt1bN33oGDXM+MzpOr8m2Av8rl+J15zhv31W3fMsStuqltmdNFxV1DkbhvG3e
         D4z2XL69uF4jVtotto29dgXR585kzUkbeFhmcAOEntSOoWBJqh+R6dQk40nXg0fOc1N9
         IN2rBXGw7sGaaiHA2SS1KTPsYWVQaUD8opBS/PWKZ781dbNYrloJqgEqaDV6gzYwD0Is
         WDZvC7DpW39HjgkjVDQExYXG7pVEUu6ihyt+vCILXHLz+yIZ4HJxrW5NqWP3BZD09CNG
         dSPA48AZd1SDWyu5X+oiZmx8Uu04VYVfQiiIb7ygrgpSawcBHV6+NsXaayPEzYrEXKvR
         vOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jy8VfleHu+pD1+MS9EHzQVTEgh3wepSAEbnctiRLpcY=;
        b=LDBeqjQ6+KLyrEzpOYNcpoB5olkYLwpoBWvKuBch0wHRfV7Imu6Cxg36igWGjy8XYI
         fWZxqX9FBIxLrXhOoY5F6k8TlqId7kA66qQMVn6rUdCC3biKTpl88ixURxZmuZtrgDO+
         w+8dBTVRptsCMCure9gPcz02jeluvjJOiXwUwzdy6n++DVy8lJavP8LLnfmiXVB+XjjI
         wKL/f9jK0lb6LYyg7C5bT+56n2imJr22A95H+rHAV8Gh/lZ/h/GgIS9K2DgG5KGDPOGV
         u9BlUempyftFqVZv9dkWttj9uwFeL0BiQPDpOQhOHjcWiTUWP5f+JDVbLxNOxxxF7bgV
         89aA==
X-Gm-Message-State: AOAM5315BAp8T5r0EqcwzszZ7OsJd3Ja/2cBB9HQ/VGMdmXqL9hapJaO
        Aom9SqGT/CnQa0h4bhGwE1tO/FIi+sCnjfWxmeA=
X-Google-Smtp-Source: ABdhPJxnBG+sDvBUfx4ZwF7sk1a760yQJOJxk4Dv2qekyNlny+szAV3th2IeO527sB2y0XPQavEIOkdfkJI50paiwwM=
X-Received: by 2002:a9d:694e:: with SMTP id p14mr12571oto.254.1604462149174;
 Tue, 03 Nov 2020 19:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20201103211101.4221-1-dsterba@suse.com> <96d4080f-38cd-d49b-ebb1-72de8ae43c34@gmx.com>
In-Reply-To: <96d4080f-38cd-d49b-ebb1-72de8ae43c34@gmx.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 3 Nov 2020 19:55:38 -0800
Message-ID: <CAE1WUT41gA2TTF9=09+gPVjeVpLZDJ=R59rD20=X_rMeCnmsyg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reorder extent buffer members for better packing
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 3, 2020 at 3:45 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/11/4 =E4=B8=8A=E5=8D=885:11, David Sterba wrote:
> > After the rwsem replaced the tree lock implementation, the extent buffe=
r
> > got smaller but leaving some holes behind. By changing log_index type
> > and reordering, we can squeeze the size further to 240 bytes, measured =
on
> > release config on x86_64. Log_index spans only 3 values and needs to be
> > signed.
> >
> > Before:
> >
> > struct extent_buffer {
> >         u64                        start;                /*     0     8=
 */
> >         long unsigned int          len;                  /*     8     8=
 */
> >         long unsigned int          bflags;               /*    16     8=
 */
> >         struct btrfs_fs_info *     fs_info;              /*    24     8=
 */
> >         spinlock_t                 refs_lock;            /*    32     4=
 */
> >         atomic_t                   refs;                 /*    36     4=
 */
> >         atomic_t                   io_pages;             /*    40     4=
 */
> >         int                        read_mirror;          /*    44     4=
 */
> >         struct callback_head       callback_head __attribute__((__align=
ed__(8))); /*    48    16 */
> >         /* --- cacheline 1 boundary (64 bytes) --- */
> >         pid_t                      lock_owner;           /*    64     4=
 */
> >         bool                       lock_recursed;        /*    68     1=
 */
> >
> >         /* XXX 3 bytes hole, try to pack */
> >
> >         struct rw_semaphore        lock;                 /*    72    40=
 */
>
> An off-topic question, for things like aotmic_t/spinlock_t and
> rw_semaphore, wouldn't various DEBUG options change their size?

Yes, I believe they could.

>
> Do we need to consider such case, by moving them to the end of the
> structure, or we only consider production build for pa_hole?
>

I'd say we could go either way on this, but personally, if it builds, it bu=
ilds.
Let's just focus on pahole for now and potentially revisit this later.

> Thanks,
> Qu
>
> >         short int                  log_index;            /*   112     2=
 */
> >
> >         /* XXX 6 bytes hole, try to pack */
> >
> >         struct page *              pages[16];            /*   120   128=
 */
> >
> >         /* size: 248, cachelines: 4, members: 14 */
> >         /* sum members: 239, holes: 2, sum holes: 9 */
> >         /* forced alignments: 1 */
> >         /* last cacheline: 56 bytes */
> > } __attribute__((__aligned__(8)));
> >
> > After:
> >
> > struct extent_buffer {
> >         u64                        start;                /*     0     8=
 */
> >         long unsigned int          len;                  /*     8     8=
 */
> >         long unsigned int          bflags;               /*    16     8=
 */
> >         struct btrfs_fs_info *     fs_info;              /*    24     8=
 */
> >         spinlock_t                 refs_lock;            /*    32     4=
 */
> >         atomic_t                   refs;                 /*    36     4=
 */
> >         atomic_t                   io_pages;             /*    40     4=
 */
> >         int                        read_mirror;          /*    44     4=
 */
> >         struct callback_head       callback_head __attribute__((__align=
ed__(8))); /*    48    16 */
> >         /* --- cacheline 1 boundary (64 bytes) --- */
> >         pid_t                      lock_owner;           /*    64     4=
 */
> >         bool                       lock_recursed;        /*    68     1=
 */
> >         s8                         log_index;            /*    69     1=
 */
> >
> >         /* XXX 2 bytes hole, try to pack */
> >
> >         struct rw_semaphore        lock;                 /*    72    40=
 */
> >         struct page *              pages[16];            /*   112   128=
 */
> >
> >         /* size: 240, cachelines: 4, members: 14 */
> >         /* sum members: 238, holes: 1, sum holes: 2 */
> >         /* forced alignments: 1 */
> >         /* last cacheline: 48 bytes */
> > } __attribute__((__aligned__(8)));
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/extent_io.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> > index 5403354de0e1..3c2bf21c54eb 100644
> > --- a/fs/btrfs/extent_io.h
> > +++ b/fs/btrfs/extent_io.h
> > @@ -88,10 +88,10 @@ struct extent_buffer {
> >       struct rcu_head rcu_head;
> >       pid_t lock_owner;
> >       bool lock_recursed;
> > -     struct rw_semaphore lock;
> > -
> >       /* >=3D 0 if eb belongs to a log tree, -1 otherwise */
> > -     short log_index;
> > +     s8 log_index;
> > +
> > +     struct rw_semaphore lock;
> >
> >       struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
> >  #ifdef CONFIG_BTRFS_DEBUG
> >
>

Best regards,
Amy Parker
(they/them)

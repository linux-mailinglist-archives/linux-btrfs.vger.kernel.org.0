Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837F62BBA47
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Nov 2020 00:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgKTXlx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Nov 2020 18:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgKTXlv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Nov 2020 18:41:51 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41598C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Nov 2020 15:41:51 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id d17so15790463lfq.10
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Nov 2020 15:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4X3JgQ4RPxBwwWZDZkMawYKrU5kawZa5XwbccIiOlk=;
        b=fMuLwYClEdAadSzvWYkAP/jvTOpXw94bICx+OYCMzy7UTAGgcDRlygMInZIvEujlw2
         uv/jO22fk/2x23A21TbxXR1lpeCzfruKMg85wcwQ6Qps+47ypl8fig1EFQmgGwtYA1L2
         uFH2B+LfY62r2owvWlp4TX4A8YRTjV1T1jAQlHi36TDv+g7lAqFShqGtXVDHGFCeFrud
         ROTeIeG3xeXCnH/MOpYzlke00TgmBgw5yO4Z4b09PaOUnHEN2CltBfLjwTkDzUfprYE2
         SKB2jeQU834H6D73e8chfxDtpG5JszY4A0+lx6Gmh5QHYL9Y6H//Z0Sg4pMDSC5JHtP7
         RTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4X3JgQ4RPxBwwWZDZkMawYKrU5kawZa5XwbccIiOlk=;
        b=a/KwxF1NFhsEHL0g1QbJYNuoHQ/SclJzjPmsJYsTBc0JpT+UOmfNBif7Z3aIr/NdgY
         sFXZ3NmuhYVYyCsz5ltbX3T9WzTRGmnaHHAaZHC/2T4BinKRjVUJ/odt1CJlFFQuPkJB
         KaxxYcS7gyEGHB0WfbQtAdypQgYXZqQKDiMxVSmgXScPYvg19ZtJW8AeyXwaoH9ZoCWg
         5SxfLR79j4Wtv6e4bW2QXezzukLBGOnxP51olYJ0u2Lk1tl3xUBS7m3Xmf15lRYNwGDf
         uDJfs1+kpOSPuWlVB4beBJuQvXnwOQ6F0ix9Zelv6PhDDxWJpTqlvmrj/vSvSx4UjRid
         PIUA==
X-Gm-Message-State: AOAM531h8hrd/u+xPIiGbSy/iDz1zQ6mJ/5lqCOS80RG8e13f1/siwHA
        Ve99qqLMGJfw0VUmjvhr19DFpX6AzZ1b3hvkBCLdwA==
X-Google-Smtp-Source: ABdhPJwXPfmuHQziNQZcT5u300NF6Dhifvv4PZmdrQW14N8dBch+LNWZZeOwlsVTr0m1EgqrXrKk6uAQNaZdAB5bLdU=
X-Received: by 2002:a19:4b45:: with SMTP id y66mr8447196lfa.482.1605915709537;
 Fri, 20 Nov 2020 15:41:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605723568.git.osandov@fb.com> <977fd16687d8b0474fd9c442f79c23f53783e403.1605723568.git.osandov@fb.com>
 <CAOQ4uxiaWAT6kOkxgMgeYEcOBMsc=HtmSwssMXg0Nn=rbkZRGA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiaWAT6kOkxgMgeYEcOBMsc=HtmSwssMXg0Nn=rbkZRGA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 21 Nov 2020 00:41:23 +0100
Message-ID: <CAG48ez3rLFOWpaQcJxEE7BNXvxHvUQnvhhY-xyR2bZfhnmwQrg@mail.gmail.com>
Subject: Re: [PATCH v6 02/11] fs: add O_ALLOW_ENCODED open flag
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 19, 2020 at 8:03 AM Amir Goldstein <amir73il@gmail.com> wrote:
> On Wed, Nov 18, 2020 at 9:18 PM Omar Sandoval <osandov@osandov.com> wrote:
> > The upcoming RWF_ENCODED operation introduces some security concerns:
> >
> > 1. Compressed writes will pass arbitrary data to decompression
> >    algorithms in the kernel.
> > 2. Compressed reads can leak truncated/hole punched data.
> >
> > Therefore, we need to require privilege for RWF_ENCODED. It's not
> > possible to do the permissions checks at the time of the read or write
> > because, e.g., io_uring submits IO from a worker thread. So, add an open
> > flag which requires CAP_SYS_ADMIN. It can also be set and cleared with
> > fcntl(). The flag is not cleared in any way on fork or exec. It must be
> > combined with O_CLOEXEC when opening to avoid accidental leaks (if
> > needed, it may be set without O_CLOEXEC by using fnctl()).
> >
> > Note that the usual issue that unknown open flags are ignored doesn't
> > really matter for O_ALLOW_ENCODED; if the kernel doesn't support
> > O_ALLOW_ENCODED, then it doesn't support RWF_ENCODED, either.
[...]
> > diff --git a/fs/open.c b/fs/open.c
> > index 9af548fb841b..f2863aaf78e7 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -1040,6 +1040,13 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
> >                 acc_mode = 0;
> >         }
> >
> > +       /*
> > +        * O_ALLOW_ENCODED must be combined with O_CLOEXEC to avoid accidentally
> > +        * leaking encoded I/O privileges.
> > +        */
> > +       if ((how->flags & (O_ALLOW_ENCODED | O_CLOEXEC)) == O_ALLOW_ENCODED)
> > +               return -EINVAL;
> > +
>
>
> dup() can also result in accidental leak.
> We could fail dup() of fd without O_CLOEXEC. Should we?
>
> If we should than what error code should it be? We could return EPERM,
> but since we do allow to clear O_CLOEXEC or set O_ALLOW_ENCODED
> after open, EPERM seems a tad harsh.
> EINVAL seems inappropriate because the error has nothing to do with
> input args of dup() and EBADF would also be confusing.

This seems very arbitrary to me. Sure, leaking these file descriptors
wouldn't be great, but there are plenty of other types of file
descriptors that are probably more sensitive. (Writable file
descriptors to databases, to important configuration files, to
io_uring instances, and so on.) So I don't see why this specific
feature should impose such special rules on it.

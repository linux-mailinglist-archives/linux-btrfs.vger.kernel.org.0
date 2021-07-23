Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DCA3D362D
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jul 2021 10:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhGWHbQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jul 2021 03:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233619AbhGWHbP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jul 2021 03:31:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C68A160F12
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jul 2021 08:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627027909;
        bh=CF3+pyBUMhQAhxRk+R2opT7GgYEpXgEBgiVUcCj5D1k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZyDUDlrIy6WL8gBh5ZXWJwh9UAArvNATWwWBvd9Mf3ffvqJ8Xxzjixc6+TuFxCdnK
         hveTMZRpJfYb7J61HTtqrFKGVUUfOYEcnHm8hkRb+bOpL3rKwm7hrv4U0Cuirfb846
         sYxHBJplhPZMXwOhX+xlOLBIoyzHodT+0kBUG/jHOwu5nSNuSAjjYpxXmpWy8oy7Cs
         rsDhrV33e/ymf6bUIhHYASHgVTXyzYUEHY14CEZG7/NdkTGVOIM58+XgLcO1cJEHus
         4p7tYe+JMzVyRr2cIhYe6Bxp3PvVG55wGlrZsMY+Qp6MnP+jZpQ7fvI9amuRyzXzxi
         lIA3vw2ZQnlJg==
Received: by mail-qk1-f174.google.com with SMTP id t68so628761qkf.8
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Jul 2021 01:11:49 -0700 (PDT)
X-Gm-Message-State: AOAM53048dCZr2wWxYSytKNt4QvOOc6G1GkDHnT2WcLGh3boXdhgU/NJ
        wj52F5unVsMN8vA98wStL7ZouYEEWGnwrI3z8jQ=
X-Google-Smtp-Source: ABdhPJwQy1Dj88+u2eVLbxl/+7+njOvBQRJOb2/zFQGerW3xunPr0YJr5VoEFbY2NkAp7TJLt7DXoNkCieO3QOVx5pk=
X-Received: by 2002:a37:54f:: with SMTP id 76mr3303960qkf.479.1627027909035;
 Fri, 23 Jul 2021 01:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626791500.git.fdmanana@suse.com> <589f5a66b472b93df01e5e798acd5123b5582769.1626791500.git.fdmanana@suse.com>
 <a3595186-bab3-73d9-003e-cc1d58ce38d5@suse.com>
In-Reply-To: <a3595186-bab3-73d9-003e-cc1d58ce38d5@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 23 Jul 2021 09:11:38 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5X8=V9p_J8Ek46dxs3+_gdTgGjL42ukBpQ8+sYqeEB_w@mail.gmail.com>
Message-ID: <CAL3q7H5X8=V9p_J8Ek46dxs3+_gdTgGjL42ukBpQ8+sYqeEB_w@mail.gmail.com>
Subject: Re: [PATCH 3/4] btrfs: remove unnecessary list head initialization
 when syncing log
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 23, 2021 at 7:20 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 20.07.21 =D0=B3. 18:03, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > One of the last steps of syncing the log is to remove all log contextes
> > from the root's list of contextes, done at btrfs_remove_all_log_ctxs().
> > There we iterate over all the contextes in the list and delete each one
> > from the list, and after that we call INIT_LIST_HEAD() on the list. Tha=
t
> > is unnecessary since at that point the list is empty.
> >
> > So just remove the INIT_LIST_HEAD() call. It's not needed, increases co=
de
> nit: I assume you mean decreases code size
> > size (bloat-o-meter reported a delta of -122 for btrfs_sync_log() after
> > this change) and increases two critical sections delimited by log mutex=
es.
>
> nit: Here you also mean decreases two critsecs

No, in both cases I meant "increases".
The goal of the sentence is to list the negative consequences of
having the call, that's why the sentence starts with "It's not needed,
".

Thanks.

>
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/tree-log.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 90fb5a2fc60b..63f48715135c 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -3039,8 +3039,6 @@ static inline void btrfs_remove_all_log_ctxs(stru=
ct btrfs_root *root,
> >               list_del_init(&ctx->list);
> >               ctx->log_ret =3D error;
> >       }
> > -
> > -     INIT_LIST_HEAD(&root->log_ctxs[index]);
> >  }
> >
> >  /*
> >

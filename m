Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E0A2A5652
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 22:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbgKCV0I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 16:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388606AbgKCV0C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 16:26:02 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76561C0613D1
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:26:02 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id t16so2551669oie.11
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Nov 2020 13:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccx5+HrCJ+fYJ57tBxwZFr348bROpMJBjzsEfdiKCEs=;
        b=IlOQ2z1EvhAe8YEoZ7AuWiv2cLPzvjTFkIM/rostH/SeA419sDWkVCQWz0dTeegATB
         6fVcsY4PSbkTcUw5Tgg45ZBxVTn94NGowRzNEotkDFCfCrNg9IoCf+ZINXGJdwe/hWjP
         84ATVbsXcrqb9k7d2uHHfRWSaFpWuo1KW4dc+KVaw4wnavB/y1Hfribf2NgP13nBQjZV
         0ojKuziBwljgeAK/qbXjFszeUQMhuENv2rCVAyAiHBWQZxdXquzlRbC9WkPIxRvVv5wa
         3AkE+BOZVL8Ka+ejZA4/CDba+Q2sHYJPrZAJPnQMKelgBLuSiLOVICpxLbTCZIT7vuTv
         0M1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccx5+HrCJ+fYJ57tBxwZFr348bROpMJBjzsEfdiKCEs=;
        b=o0KpKg2mWIX0vxfnCsZwpapjb61C6jhHwmBXo+/weK2IlXLxyAyau8zW17RHm9sMO8
         4mrHnsedNTqV9vmLoCQ+UikrGtDNiWwj5tCnv9elYldsOOwd0T5/1r5hSAPq4KbxCTzT
         pAgwd3yDRYXexQr5Rli34Ky0L3HaTMHEoaUTvTQnyVTfrcJPf+lj16MsGXJRqr4wIEij
         v+21cxDYw0iK+apBwJ0EqJL+cIaoNqeh9RrXLGoVnvWJ+gX4BuwQqy1UVC5yA5d6kWvt
         CZCotYdPFZ1q4X8HYEIhIvhkPYPvmFEGzQTmfiN4LCxmhkK2p3Bfw3OAFEm3S+0jh3Zz
         hfTQ==
X-Gm-Message-State: AOAM5315JUfu+rFLAnSNmRNgb+zQ69tZCNNrL1g0xFd/y3cJXq6wWVCg
        xJDWNeVESHStLuguikTGmzhhiKD9qcGz7TncMmUoDd70LPI=
X-Google-Smtp-Source: ABdhPJz8DcaQTPE7kRP0w/8Ri19f03Az5qVFlPJwyak1QGndkaJfe9yFj9oZzgITKQiThgFBaZMTlZA0skSaS1z/x/k=
X-Received: by 2002:aca:2111:: with SMTP id 17mr684720oiz.139.1604438761916;
 Tue, 03 Nov 2020 13:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20201103211101.4221-1-dsterba@suse.com>
In-Reply-To: <20201103211101.4221-1-dsterba@suse.com>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Tue, 3 Nov 2020 13:25:50 -0800
Message-ID: <CAE1WUT7pS_T0AkV_KiTpnAXOPEP2-8e4+d6t9KgSqaMXUsEdaw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reorder extent buffer members for better packing
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 3, 2020 at 1:18 PM David Sterba <dsterba@suse.com> wrote:
>
> After the rwsem replaced the tree lock implementation, the extent buffer
> got smaller but leaving some holes behind. By changing log_index type
> and reordering, we can squeeze the size further to 240 bytes, measured on
> release config on x86_64. Log_index spans only 3 values and needs to be
> signed.
>

Sounds great!

> Before:
>
> struct extent_buffer {
>         u64                        start;                /*     0     8 */
>         long unsigned int          len;                  /*     8     8 */
>         long unsigned int          bflags;               /*    16     8 */
>         struct btrfs_fs_info *     fs_info;              /*    24     8 */
>         spinlock_t                 refs_lock;            /*    32     4 */
>         atomic_t                   refs;                 /*    36     4 */
>         atomic_t                   io_pages;             /*    40     4 */
>         int                        read_mirror;          /*    44     4 */
>         struct callback_head       callback_head __attribute__((__aligned__(8))); /*    48    16 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         pid_t                      lock_owner;           /*    64     4 */
>         bool                       lock_recursed;        /*    68     1 */
>
>         /* XXX 3 bytes hole, try to pack */
>
>         struct rw_semaphore        lock;                 /*    72    40 */
>         short int                  log_index;            /*   112     2 */
>
>         /* XXX 6 bytes hole, try to pack */
>
>         struct page *              pages[16];            /*   120   128 */
>
>         /* size: 248, cachelines: 4, members: 14 */
>         /* sum members: 239, holes: 2, sum holes: 9 */
>         /* forced alignments: 1 */
>         /* last cacheline: 56 bytes */
> } __attribute__((__aligned__(8)));
>
> After:
>
> struct extent_buffer {
>         u64                        start;                /*     0     8 */
>         long unsigned int          len;                  /*     8     8 */
>         long unsigned int          bflags;               /*    16     8 */
>         struct btrfs_fs_info *     fs_info;              /*    24     8 */
>         spinlock_t                 refs_lock;            /*    32     4 */
>         atomic_t                   refs;                 /*    36     4 */
>         atomic_t                   io_pages;             /*    40     4 */
>         int                        read_mirror;          /*    44     4 */
>         struct callback_head       callback_head __attribute__((__aligned__(8))); /*    48    16 */
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         pid_t                      lock_owner;           /*    64     4 */
>         bool                       lock_recursed;        /*    68     1 */
>         s8                         log_index;            /*    69     1 */
>
>         /* XXX 2 bytes hole, try to pack */
>
>         struct rw_semaphore        lock;                 /*    72    40 */
>         struct page *              pages[16];            /*   112   128 */
>
>         /* size: 240, cachelines: 4, members: 14 */
>         /* sum members: 238, holes: 1, sum holes: 2 */
>         /* forced alignments: 1 */
>         /* last cacheline: 48 bytes */
> } __attribute__((__aligned__(8)));

Looks alright, although based on the rest of the value types,
you may want to leave a comment for new btrfs devs about
the change, as well as a reference to this thread.

>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/extent_io.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 5403354de0e1..3c2bf21c54eb 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -88,10 +88,10 @@ struct extent_buffer {
>         struct rcu_head rcu_head;
>         pid_t lock_owner;
>         bool lock_recursed;
> -       struct rw_semaphore lock;
> -
>         /* >= 0 if eb belongs to a log tree, -1 otherwise */
> -       short log_index;
> +       s8 log_index;
> +
> +       struct rw_semaphore lock;
>
>         struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
>  #ifdef CONFIG_BTRFS_DEBUG
> --
> 2.25.0
>

Functional-wise, everything seems great here. Again, as mentioned,
you may want to include a comment explaining the change and the
divergence from other types used in the code above.

Best regards,
Amy Parker
(they/them)

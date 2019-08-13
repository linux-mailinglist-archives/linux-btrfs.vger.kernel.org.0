Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3560F8B35C
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2019 11:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfHMJHJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 05:07:09 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:44219 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727234AbfHMJHI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 05:07:08 -0400
Received: by mail-vk1-f196.google.com with SMTP id w186so12905242vkd.11
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Aug 2019 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=JXZ9agtJ7p2NkqBn4F49XX20E8cmp/W00aCHiP4CEt4=;
        b=tKEM3rwgnuDP5ht/yJQnF9wNGsLOiVmUkOJEwJ96Jxk/dBHyE6eFkim1FkdMia2zWn
         k+5ubyKzkEG/YyK4916PAHGk2bEfnZD5JeEqisDE/Snwd1/g6t6WiJZHN9BiLRNChmZg
         nFt+Y3lw5tKe1X8P7HzyibBBlOxNckV5OyUeYWOUSOXQCF7BOC9YWNnS7dDwTVmhiWcj
         kILNvsxv05LBzPTaQRHXeo4+KDOMJfoEU363r5cgSSWdx3lrzJF5noYRWJGInera6Z+H
         INv0k407W6XRFxEPs7x1/VKO8RjLiMqetiNih1Py71EVAEDMwHhS6ls1P72MjZyRYUEi
         eS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=JXZ9agtJ7p2NkqBn4F49XX20E8cmp/W00aCHiP4CEt4=;
        b=n35Psx4CaHdBH44QyBTF5XN0biGInqpT23I1EUjQ+8od+4GKa/ZO0i3OmEjWIokWWA
         5aUE3pCQ3hLnC5yUoU3W32Su/4yTGNDKY5yZu9Gl3nonsT9lcFcdwVO7SacysmaY7RIE
         +6eOScdkjU3OH1ydH7dIoZRc+jSeO+XCneB9B2ZApOGpq8pfmj3yQTOUjmdxYUcOW8WW
         v1FCDhFCDr2yQFTCCKDv981nFNAzV6JQEXA0ChIqrQS4MT+3JOHxknF9scDLn33BkPEr
         bINmWunEf8g1pF54QsRMOl+nA6dPVeVuhgk+iPGYDJyCOyakOTMrJSs0igRd7dIcT3sL
         q69A==
X-Gm-Message-State: APjAAAWYkVt7hWNzx1pcKy8KBy1/STH6WqKfMJiyu3r7kpWeV6DEqQig
        2+A7uNlUB5FU56wrydx+HUuURYk1Uc/dBMK/pMk=
X-Google-Smtp-Source: APXvYqyXAFIqsBDdiNeB875hnGTeUOIJ7wBIAj78gQD2j43kvtz9h3Jfdo9xSnQjs5jrIDL3Ojt9lGrlgIlxz/wddgQ=
X-Received: by 2002:a1f:29d5:: with SMTP id p204mr3532640vkp.31.1565687227099;
 Tue, 13 Aug 2019 02:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1565680721.git.osandov@fb.com> <958fe7c61896c82b35b5c552d3fb5bfd4df62627.1565680721.git.osandov@fb.com>
In-Reply-To: <958fe7c61896c82b35b5c552d3fb5bfd4df62627.1565680721.git.osandov@fb.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 13 Aug 2019 10:06:56 +0100
Message-ID: <CAL3q7H44_+TjbF0kOA_HgJGDHXGqykA_JG2iWTpKkUhZ84X=ww@mail.gmail.com>
Subject: Re: [PATCH 2/2] Btrfs: get rid of pointless wtag variable in async-thread.c
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 13, 2019 at 8:28 AM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> Commit ac0c7cf8be00 ("btrfs: fix crash when tracepoint arguments are
> freed by wq callbacks") added a void pointer, wtag, which is passed into
> trace_btrfs_all_work_done() instead of the freed work item. This is
> silly for a few reasons:
>
> 1. The freed work item still has the same address.
> 2. work is still in scope after it's freed, so assigning wtag doesn't
>    stop anyone from using it.
> 3. The tracepoint has always taken a void * argument, so assigning wtag
>    doesn't actually make things any more type-safe. (Note that the
>    original bug in commit bc074524e123 ("btrfs: prefix fsid to all trace
>    events") was that the void * was implicitly casted when it was passed
>    to btrfs_work_owner() in the trace point itself).
>
> Instead, let's add some clearer warnings as comments.
>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Looks good, just a double "that" word in a comment below.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

> ---
>  fs/btrfs/async-thread.c      | 21 ++++++++-------------
>  include/trace/events/btrfs.h |  6 +++---
>  2 files changed, 11 insertions(+), 16 deletions(-)
>
> diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
> index d105d3df6fa6..baeb4058e9dc 100644
> --- a/fs/btrfs/async-thread.c
> +++ b/fs/btrfs/async-thread.c
> @@ -226,7 +226,6 @@ static void run_ordered_work(struct btrfs_work *self)
>         struct btrfs_work *work;
>         spinlock_t *lock =3D &wq->list_lock;
>         unsigned long flags;
> -       void *wtag;
>         bool free_self =3D false;
>
>         while (1) {
> @@ -281,21 +280,19 @@ static void run_ordered_work(struct btrfs_work *sel=
f)
>                 } else {
>                         /*
>                          * We don't want to call the ordered free functio=
ns with
> -                        * the lock held though. Save the work as tag for=
 the
> -                        * trace event, because the callback could free t=
he
> -                        * structure.
> +                        * the lock held.
>                          */
> -                       wtag =3D work;
>                         work->ordered_free(work);
> -                       trace_btrfs_all_work_done(wq->fs_info, wtag);
> +                       /* work must not be dereferenced past this point.=
 */
> +                       trace_btrfs_all_work_done(wq->fs_info, work);
>                 }
>         }
>         spin_unlock_irqrestore(lock, flags);
>
>         if (free_self) {
> -               wtag =3D self;
>                 self->ordered_free(self);
> -               trace_btrfs_all_work_done(wq->fs_info, wtag);
> +               /* self must not be dereferenced past this point. */
> +               trace_btrfs_all_work_done(wq->fs_info, self);
>         }
>  }
>
> @@ -304,7 +301,6 @@ static void btrfs_work_helper(struct work_struct *nor=
mal_work)
>         struct btrfs_work *work =3D container_of(normal_work, struct btrf=
s_work,
>                                                normal_work);
>         struct __btrfs_workqueue *wq;
> -       void *wtag;
>         int need_order =3D 0;
>
>         /*
> @@ -318,8 +314,6 @@ static void btrfs_work_helper(struct work_struct *nor=
mal_work)
>         if (work->ordered_func)
>                 need_order =3D 1;
>         wq =3D work->wq;
> -       /* Safe for tracepoints in case work gets freed by the callback *=
/
> -       wtag =3D work;
>
>         trace_btrfs_work_sched(work);
>         thresh_exec_hook(wq);
> @@ -327,9 +321,10 @@ static void btrfs_work_helper(struct work_struct *no=
rmal_work)
>         if (need_order) {
>                 set_bit(WORK_DONE_BIT, &work->flags);
>                 run_ordered_work(work);
> +       } else {
> +               /* work must not be dereferenced past this point. */
> +               trace_btrfs_all_work_done(wq->fs_info, work);
>         }
> -       if (!need_order)
> -               trace_btrfs_all_work_done(wq->fs_info, wtag);
>  }
>
>  void btrfs_init_work(struct btrfs_work *work, btrfs_func_t func,
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 5cb95646b94e..3d61e80d3c6e 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -1388,9 +1388,9 @@ DECLARE_EVENT_CLASS(btrfs__work,
>  );
>
>  /*
> - * For situiations when the work is freed, we pass fs_info and a tag tha=
t that
> - * matches address of the work structure so it can be paired with the
> - * scheduling event.
> + * For situations when the work is freed, we pass fs_info and a tag that=
 that

"that" twice.

> + * matches address of the work structure so it can be paired with the sc=
heduling
> + * event. DO NOT add anything here that dereferences wtag.
>   */
>  DECLARE_EVENT_CLASS(btrfs__work__done,
>
> --
> 2.22.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

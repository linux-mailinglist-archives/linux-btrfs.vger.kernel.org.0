Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F56489D41
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 13:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfHLLjI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 07:39:08 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39987 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfHLLjI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 07:39:08 -0400
Received: by mail-ua1-f67.google.com with SMTP id s4so40066851uad.7
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2019 04:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=f6fhHV8aDNy5KBpWNbKmfN0j3LMtvqY5OjIHy0I+SpY=;
        b=ihAehqdSq0+wKxc/CC2mJsv6u1gBiSltXQK5zKKMyhDT6CaUuOhlkWxkd98EHETNKd
         /dUR4VkwDtrP32bxPrje9HrCoZZGTjkGtdgNd2ZAIU8ls0/fgYAQ1VPoub0JmdAz3tXw
         q/DifXZVJhxwtuSokkf1zORN5+MPpo95oJ+94HyX3P/Yr5BsHR/6IVaPhscvoLOTZQ3e
         VaI5EakySYC4svrUgeOCNhneylNl+ykSjnvXhRKphtGNmMquIro6QehSYfG2MQIDKKeH
         AoTdQ2wEfcAD4Gs3HYTYgB98KI00BTRadkRM2jINQtZf7ANPWJpkasprEabfE55w7DBi
         ggwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=f6fhHV8aDNy5KBpWNbKmfN0j3LMtvqY5OjIHy0I+SpY=;
        b=c+l+oSKgwcQy/FPSWBF9vzEl8WkHFrllcSUdYyCNKRZNOLhze12uvCj3AXq8DlxI9+
         2AZWn3m1JUbSHkvohEMl7gGqqKgu8GGg5JqzN1KjHGrRuND6C0rrEVptfVryfQXfvolV
         RqFMzp3K5X3vzpiVPveVHFDlO5ZxOPXnMTk9cV9KjzKTFPzGTa+6KhqIryE0KToF6IIi
         +DR+G/CW4i/5Em93MMX34HezeQ7S01U3zDAmgVMzKquj/QYCW970mnhnijS6n/D4eJNa
         hr5CSaFh9k+Nqwg2pBgBMJt9b3ovCeQF4asaD5Mm/0Lrw5GALUBP5fXBqc0j5kicFpSk
         iW0Q==
X-Gm-Message-State: APjAAAWfOYtFY803CK5/IeYzSjEly9D6x9siXhhNr2qMiBkEaU6UJ4/0
        m60cNbT9ubpQvbxayOzw+HlC1xXX6tM3c0qQsZdDZQgX
X-Google-Smtp-Source: APXvYqwZnuY3OcKbPqH+tNFQOy+E5q0nJzrp3pf2dgYszDeK+oD9Se/bIA0O3mYMVAztbhb8vxmAS8EuWZSQDmh6+40=
X-Received: by 2002:ab0:66:: with SMTP id 93mr19248869uai.135.1565609946992;
 Mon, 12 Aug 2019 04:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com>
In-Reply-To: <0bea516a54b26e4e1c42e6fe47548cb48cc4172b.1565112813.git.osandov@fb.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 12 Aug 2019 12:38:55 +0100
Message-ID: <CAL3q7H4cSMNSKfQKtFk9Q5Shw3VxMFZQ0E7uusL0efHzyN3MXw@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: fix workqueue deadlock on dependent filesystems
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 6, 2019 at 6:48 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> From: Omar Sandoval <osandov@fb.com>
>
> We hit a the following very strange deadlock on a system with Btrfs on a
> loop device backed by another Btrfs filesystem:
>
> 1. The top (loop device) filesystem queues an async_cow work item from
>    cow_file_range_async(). We'll call this work X.
> 2. Worker thread A starts work X (normal_work_helper()).
> 3. Worker thread A executes the ordered work for the top filesystem
>    (run_ordered_work()).
> 4. Worker thread A finishes the ordered work for work X and frees X
>    (work->ordered_free()).
> 5. Worker thread A executes another ordered work and gets blocked on I/O
>    to the bottom filesystem (still in run_ordered_work()).
> 6. Meanwhile, the bottom filesystem allocates and queues an async_cow
>    work item which happens to be the recently-freed X.
> 7. The workqueue code sees that X is already being executed by worker
>    thread A, so it schedules X to be executed _after_ worker thread A
>    finishes (see the find_worker_executing_work() call in
>    process_one_work()).
>
> Now, the top filesystem is waiting for I/O on the bottom filesystem, but
> the bottom filesystem is waiting for the top filesystem to finish, so we
> deadlock.
>
> This happens because we are breaking the workqueue assumption that a
> work item cannot be recycled while it still depends on other work. Fix
> it by waiting to free the work item until we are done with all of the
> related ordered work.
>
> P.S.:
>
> One might ask why the workqueue code doesn't try to detect a recycled
> work item. It actually does try by checking whether the work item has
> the same work function (find_worker_executing_work()), but in our case
> the function is the same. This is the only key that the workqueue code
> has available to compare, short of adding an additional, layer-violating
> "custom key". Considering that we're the only ones that have ever hit
> this, we should just play by the rules.
>
> Unfortunately, we haven't been able to create a minimal reproducer other
> than our full container setup using a compress-force=3Dzstd filesystem on
> top of another compress-force=3Dzstd filesystem.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Omar Sandoval <osandov@fb.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good to me, thanks.
Another variant of the problem Liu fixed back in 2014 (commit
9e0af23764344f7f1b68e4eefbe7dc865018b63d).

> ---
>  fs/btrfs/async-thread.c | 56 ++++++++++++++++++++++++++++++++---------
>  1 file changed, 44 insertions(+), 12 deletions(-)
>
> diff --git a/fs/btrfs/async-thread.c b/fs/btrfs/async-thread.c
> index 122cb97c7909..b2bfde560331 100644
> --- a/fs/btrfs/async-thread.c
> +++ b/fs/btrfs/async-thread.c
> @@ -250,16 +250,17 @@ static inline void thresh_exec_hook(struct __btrfs_=
workqueue *wq)
>         }
>  }
>
> -static void run_ordered_work(struct __btrfs_workqueue *wq)
> +static void run_ordered_work(struct btrfs_work *self)
>  {
> +       struct __btrfs_workqueue *wq =3D self->wq;
>         struct list_head *list =3D &wq->ordered_list;
>         struct btrfs_work *work;
>         spinlock_t *lock =3D &wq->list_lock;
>         unsigned long flags;
> +       void *wtag;
> +       bool free_self =3D false;
>
>         while (1) {
> -               void *wtag;
> -
>                 spin_lock_irqsave(lock, flags);
>                 if (list_empty(list))
>                         break;
> @@ -285,16 +286,47 @@ static void run_ordered_work(struct __btrfs_workque=
ue *wq)
>                 list_del(&work->ordered_list);
>                 spin_unlock_irqrestore(lock, flags);
>
> -               /*
> -                * We don't want to call the ordered free functions with =
the
> -                * lock held though. Save the work as tag for the trace e=
vent,
> -                * because the callback could free the structure.
> -                */
> -               wtag =3D work;
> -               work->ordered_free(work);
> -               trace_btrfs_all_work_done(wq->fs_info, wtag);
> +               if (work =3D=3D self) {
> +                       /*
> +                        * This is the work item that the worker is curre=
ntly
> +                        * executing.
> +                        *
> +                        * The kernel workqueue code guarantees non-reent=
rancy
> +                        * of work items. I.e., if a work item with the s=
ame
> +                        * address and work function is queued twice, the=
 second
> +                        * execution is blocked until the first one finis=
hes. A
> +                        * work item may be freed and recycled with the s=
ame
> +                        * work function; the workqueue code assumes that=
 the
> +                        * original work item cannot depend on the recycl=
ed work
> +                        * item in that case (see find_worker_executing_w=
ork()).
> +                        *
> +                        * Note that the work of one Btrfs filesystem may=
 depend
> +                        * on the work of another Btrfs filesystem via, e=
.g., a
> +                        * loop device. Therefore, we must not allow the =
current
> +                        * work item to be recycled until we are really d=
one,
> +                        * otherwise we break the above assumption and ca=
n
> +                        * deadlock.
> +                        */
> +                       free_self =3D true;
> +               } else {
> +                       /*
> +                        * We don't want to call the ordered free functio=
ns with
> +                        * the lock held though. Save the work as tag for=
 the
> +                        * trace event, because the callback could free t=
he
> +                        * structure.
> +                        */
> +                       wtag =3D work;
> +                       work->ordered_free(work);
> +                       trace_btrfs_all_work_done(wq->fs_info, wtag);
> +               }
>         }
>         spin_unlock_irqrestore(lock, flags);
> +
> +       if (free_self) {
> +               wtag =3D self;
> +               self->ordered_free(self);
> +               trace_btrfs_all_work_done(wq->fs_info, wtag);
> +       }
>  }
>
>  static void normal_work_helper(struct btrfs_work *work)
> @@ -322,7 +354,7 @@ static void normal_work_helper(struct btrfs_work *wor=
k)
>         work->func(work);
>         if (need_order) {
>                 set_bit(WORK_DONE_BIT, &work->flags);
> -               run_ordered_work(wq);
> +               run_ordered_work(work);
>         }
>         if (!need_order)
>                 trace_btrfs_all_work_done(wq->fs_info, wtag);
> --
> 2.22.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

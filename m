Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D30941ACE3
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 12:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbhI1KYo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 06:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbhI1KYo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 06:24:44 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545C3C061575
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 03:23:05 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id a14so13045126qvb.6
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Sep 2021 03:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=B4AEMcJw/dZzX//ZhlmSS6IKqP8XgEHOTtqZbidd2N4=;
        b=Xu1WycZclWmYgZKWFhhBaCMX0nm8JL5VytLJj4aIEF9Fe+9xm9a8kyWeMOs1wj7TtM
         /V0p1Xt+laILkmFcCsxk/pcjFhL4EEdVIYvjmRpGCGr7Ks0CT9ng7mkvzx3C7Mp6V7m1
         4/6Dnj9N8QcAP+/GXZBqf/fVEzQ8xpGv/DoyubQkDgom/SGAM+U5B9/Lj/k533mVIXZ9
         qETTIV8CenAi/rKb42Fd4W1nD1vwcqTO4A0erLqA8Z1zeVlHuzVSPusRaI3o0G083Zeg
         CXIMJd51eGqHTPpGwmjoIcFlK201DR1aTJ2NPptprzTLmk3zBNvJhJ2DFVnTnpFl36ew
         IgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=B4AEMcJw/dZzX//ZhlmSS6IKqP8XgEHOTtqZbidd2N4=;
        b=B8kKk7/9K5NMQU8Eptl1/j8UlIDMDYDowsBH2mcX24lqf+fWIoB0GuWMl2Qr1xsgZ5
         nP20TfwN3Lw+7yEkbKtCJJXH++iY6yFnrhzBnkeTLb40CEFhZk8ECtSx7OSmKfd82e+l
         awULd9LXX2G/IUDICcfvJ8WuSXGu46yU04O68UEZeIV0owe8EvN2XOeLfViSkIASygbg
         9z93ZNuOfvNroq3feE+ds1xLUNeipY1gi6Tqy0braCWuzE3/QUm2i1Dn5NDlZlW7FLk1
         W+fHlY9VHRZAQ3J/XH4+70SPKEPbuiJ6aC/5d1uQODJjNs1g+XdcMEv073GKkAjl5tHd
         7B2w==
X-Gm-Message-State: AOAM530iK4P8/7FK3wllporu9VfRm92ubmUAEumV4JyYQpCrqEYFQlAp
        9OboFeWlC2XRNtYY/aidfcX3567XxxQ8iQjxHOo=
X-Google-Smtp-Source: ABdhPJxnfktKLAZdP/do4DAARIVpf6fVMHlYpa/Nr7o/ezgUx4020sqXe8p3oKgWK7h/F/1r2oLmoSBw64TznqxtAu4=
X-Received: by 2002:a0c:df92:: with SMTP id w18mr4782036qvl.46.1632824584507;
 Tue, 28 Sep 2021 03:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1632765815.git.josef@toxicpanda.com> <03b2f64b3acc918b67c2fef6d4bfce70ab12ce3b.1632765815.git.josef@toxicpanda.com>
In-Reply-To: <03b2f64b3acc918b67c2fef6d4bfce70ab12ce3b.1632765815.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 28 Sep 2021 11:22:28 +0100
Message-ID: <CAL3q7H5jsdCY51xNP2x6exu_pzDwJxvvBJsAce4ZzemzNzF=Zw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] btrfs: do not infinite loop in data reclaim if we aborted
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 7:07 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Error injection stressing uncovered a busy loop in our data reclaim
> loop.  There are two cases here, one where we loop creating block groups
> until space_info->full is set, or in the main loop we will skip erroring
> out any tickets if space_info->full =3D=3D 0.  Unfortunately if we aborte=
d
> the transaction then we will never allocate chunks or reclaim any space
> and thus never get ->full, and you'll see stack traces like this
>
> watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [kworker/u4:4:139]
> CPU: 0 PID: 139 Comm: kworker/u4:4 Tainted: G        W         5.13.0-rc1=
+ #328
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04=
/01/2014
> Workqueue: events_unbound btrfs_async_reclaim_data_space
> RIP: 0010:btrfs_join_transaction+0x12/0x20
> RSP: 0018:ffffb2b780b77de0 EFLAGS: 00000246
> RAX: ffffb2b781863d58 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000801 RSI: ffff987952b57400 RDI: ffff987940aa3000
> RBP: ffff987954d55000 R08: 0000000000000001 R09: ffff98795539e8f0
> R10: 000000000000000f R11: 000000000000000f R12: ffffffffffffffff
> R13: ffff987952b574c8 R14: ffff987952b57400 R15: 0000000000000008
> FS:  0000000000000000(0000) GS:ffff9879bbc00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f0703da4000 CR3: 0000000113398004 CR4: 0000000000370ef0
> Call Trace:
>  flush_space+0x4a8/0x660
>  btrfs_async_reclaim_data_space+0x55/0x130
>  process_one_work+0x1e9/0x380
>  worker_thread+0x53/0x3e0
>  ? process_one_work+0x380/0x380
>  kthread+0x118/0x140
>  ? __kthread_bind_mask+0x60/0x60
>  ret_from_fork+0x1f/0x30
>
> Fix this by checking to see if we have a btrfs fs error in either of the
> reclaim loops, and if so fail the tickets and bail.  In addition to
> this, fix maybe_fail_all_tickets() to not try to grant tickets if we've
> aborted, simply fail everything.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/space-info.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index aa5be0b24987..63423f9729c5 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -885,6 +885,7 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_in=
fo *fs_info,
>  {
>         struct reserve_ticket *ticket;
>         u64 tickets_id =3D space_info->tickets_id;
> +       const bool aborted =3D btrfs_has_fs_error(fs_info);
>
>         trace_btrfs_fail_all_tickets(fs_info, space_info);
>
> @@ -898,16 +899,19 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_=
info *fs_info,
>                 ticket =3D list_first_entry(&space_info->tickets,
>                                           struct reserve_ticket, list);
>
> -               if (ticket->steal &&
> +               if (!aborted && ticket->steal &&
>                     steal_from_global_rsv(fs_info, space_info, ticket))
>                         return true;
>
> -               if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
> +               if (!aborted && btrfs_test_opt(fs_info, ENOSPC_DEBUG))
>                         btrfs_info(fs_info, "failing ticket with %llu byt=
es",
>                                    ticket->bytes);
>
>                 remove_ticket(space_info, ticket);
> -               ticket->error =3D -ENOSPC;
> +               if (aborted)
> +                       ticket->error =3D -EIO;
> +               else
> +                       ticket->error =3D -ENOSPC;
>                 wake_up(&ticket->wait);
>
>                 /*
> @@ -916,7 +920,8 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_in=
fo *fs_info,
>                  * here to see if we can make progress with the next tick=
et in
>                  * the list.
>                  */
> -               btrfs_try_granting_tickets(fs_info, space_info);
> +               if (!aborted)
> +                       btrfs_try_granting_tickets(fs_info, space_info);
>         }
>         return (tickets_id !=3D space_info->tickets_id);
>  }
> @@ -1172,6 +1177,10 @@ static void btrfs_async_reclaim_data_space(struct =
work_struct *work)
>                         spin_unlock(&space_info->lock);
>                         return;
>                 }
> +
> +               /* Something happened, fail everything and bail. */
> +               if (btrfs_has_fs_error(fs_info))
> +                       goto aborted_fs;
>                 last_tickets_id =3D space_info->tickets_id;
>                 spin_unlock(&space_info->lock);
>         }
> @@ -1202,9 +1211,19 @@ static void btrfs_async_reclaim_data_space(struct =
work_struct *work)
>                         } else {
>                                 flush_state =3D 0;
>                         }
> +
> +                       /* Something happened, fail everything and bail. =
*/
> +                       if (btrfs_has_fs_error(fs_info))
> +                               goto aborted_fs;
> +
>                 }
>                 spin_unlock(&space_info->lock);
>         }
> +       return;
> +aborted_fs:
> +       maybe_fail_all_tickets(fs_info, space_info);
> +       space_info->flush =3D 0;
> +       spin_unlock(&space_info->lock);
>  }
>
>  void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info)
> --
> 2.26.3
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D

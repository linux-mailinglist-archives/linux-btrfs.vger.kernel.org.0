Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423584243DE
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Oct 2021 19:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhJFRVd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Oct 2021 13:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhJFRVc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Oct 2021 13:21:32 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DBBC061746
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Oct 2021 10:19:40 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id t2so3366143qtx.8
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Oct 2021 10:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=IcpklievQYdkfFzQyvtxn/HPZ0S30Esl8TzrDc84Mqo=;
        b=LQssQ1vRY0VopDgQIlP24KaAfpcf9NnZVn2dfk+9V7FTU1EQnk06uIl6y7KBNlpiix
         MGF5xTZsk9nSZuNmbfZCmJT7aF4NLtD6dUTXCbNXEIkt8xiwPskp/zEIdNITaAoL77lE
         D4XZ1b72EvK5QBu3PW6z1JsBkBV175A3PuZaf0p261K9VSNFsyBvJ/ZkSOQXFHXP7ACz
         rd2xY7VaZhxxGJcXfzEOZN9yuzr+HXFKRqLs8aj2PX+SITcte+QZ4Z1S6O44NNetGZgZ
         vRrDXBmYf79yjHj44VD5J1qnCc28HNFA7FKzleEfJXMGGuye4YOl19MJRUSEoO3ts1qH
         Pn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=IcpklievQYdkfFzQyvtxn/HPZ0S30Esl8TzrDc84Mqo=;
        b=VtnduPNUgq6WygldVHUk1CVVjwYUPisPSQC7x1WZn6RwkygFBmuHXWbL9tm2eGI2dd
         f0byDE8n+/WeoYvlQgq9RyFPR285Bs8LIacEVlIFXaK4aHoo8lOeJEqPu+fbQ2RaolNS
         7y7vZH/9XJCyxhJV+jxaqhtYz40O2OUd0TV8tPJ/e9Ia7Lf54gAUeUqphjCwrNMuateG
         4HyajeYI8qEOE+LB2Jkmh0sC7EKCBseikp8KnubwoZ5/d6yNW50yKu1H0KFvlfsZF6FF
         WG/DUJbNHnyD+hSkOgOZX/nEMfuXgw/h+UPQgDQQqceKLx9VkYWAZP/QKfNqEblJTz6W
         MDEQ==
X-Gm-Message-State: AOAM532aedw6lJ8wrERAaqb1BqaRfRp+QIGZxRKfDlYFpq+JMRe1NVcC
        VXZnHsejvzL14xZVLvUseLyqEM4xcWSso+PDH1M=
X-Google-Smtp-Source: ABdhPJzZIIw9CL8ApQ1deWW5cGJe8F9CfeVSFa/TB3Y7y7Hs0PePFwSJditIvvphhEgMkpjwRf/ZMjBF4PbWwXu8HR0=
X-Received: by 2002:a05:622a:180c:: with SMTP id t12mr28286079qtc.304.1633540779561;
 Wed, 06 Oct 2021 10:19:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633465964.git.josef@toxicpanda.com> <105b3762cf4f8dfe4a2d97b17f2632a82612a1ee.1633465964.git.josef@toxicpanda.com>
In-Reply-To: <105b3762cf4f8dfe4a2d97b17f2632a82612a1ee.1633465964.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 6 Oct 2021 18:19:03 +0100
Message-ID: <CAL3q7H5oM4C9rER+OP7_3fSnrzYXyg+oMXnCrdRa2+XThxB9+A@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] btrfs: do not infinite loop in data reclaim if we aborted
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 5, 2021 at 9:37 PM Josef Bacik <josef@toxicpanda.com> wrote:
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

It's exactly the same as v1, which I had already reviewed, but the
reviewed tag is missing.
Thanks.

> ---
>  fs/btrfs/space-info.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index aa5be0b24987..d018bc1203f7 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -885,6 +885,7 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_in=
fo *fs_info,
>  {
>         struct reserve_ticket *ticket;
>         u64 tickets_id =3D space_info->tickets_id;
> +       const bool aborted =3D BTRFS_FS_ERROR(fs_info);
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
> +               if (BTRFS_FS_ERROR(fs_info))
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
> +                       if (BTRFS_FS_ERROR(fs_info))
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

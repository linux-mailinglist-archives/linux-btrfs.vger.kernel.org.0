Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C01D1A2810
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Apr 2020 19:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgDHRoj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Apr 2020 13:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:56770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbgDHRoj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Apr 2020 13:44:39 -0400
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 360AC20768
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Apr 2020 17:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586367878;
        bh=AGazN0gUkX0OnMFfeRfNeSxisltIqmKKTreC0xoQktg=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=Bu0vatpOKG8uKi/3bGqplorf8LhRf682OUprF6bKfWStACPHRnh8beaPrqaM6rATM
         i5Vm4EoTa4vUa8ZvpRRNMnN9nRpn+QHrr/TnKLZnL0QQBfUvtkB1AC5Ph14KM2UTPv
         C0zvOGBGrkNU2GLXQfG8fZs0Pj6qObOp1PqIC9NI=
Received: by mail-vk1-f169.google.com with SMTP id v129so2057338vkf.10
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Apr 2020 10:44:38 -0700 (PDT)
X-Gm-Message-State: AGi0PuZRb7lCzd0Estyu+aSWCK/Enjynd/nlEXLLGEkTdgLb3SlaC4cc
        4HNgCt10IpCROypU4OAmZkj1z5xBOQpCthl0T2k=
X-Google-Smtp-Source: APiQypIsMkP/TTRCMm6aB7j8SmfhUZKG6XRNSSDNvmhxcUgRI1APXwfxc5EOFxXd7EgPOpI5sybrDxjpRwG3t8Vg4t0=
X-Received: by 2002:a1f:2b09:: with SMTP id r9mr6269169vkr.24.1586367877243;
 Wed, 08 Apr 2020 10:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200407103849.28086-1-fdmanana@kernel.org> <20200408171836.GZ5920@twin.jikos.cz>
In-Reply-To: <20200408171836.GZ5920@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 8 Apr 2020 18:44:26 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5_QeUgZPL0_M0cvr+H3gO8asaJAV6AmUpMxVY63i=FKw@mail.gmail.com>
Message-ID: <CAL3q7H5_QeUgZPL0_M0cvr+H3gO8asaJAV6AmUpMxVY63i=FKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Btrfs: fix reclaim counter leak of space_info objects
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 8, 2020 at 6:19 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Apr 07, 2020 at 11:38:49AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Whenever we add a ticket to a space_info object we increment the object's
> > reclaim_size counter witht the ticket's bytes, and we decrement it with
> > the corresponding amount only when we are able to grant the requested
> > space to the ticket. When we are not able to grant the space to a ticket,
> > or when the ticket is removed due to a signal (e.g. an application has
> > received sigterm from the terminal) we never decrement the counter with
> > the corresponding bytes from the ticket. This leak can result in the
> > space reclaim code to later do much more work than necessary. So fix it
> > by decrementing the counter when those two cases happen as well.
> >
> > Fixes: db161806dc5615 ("btrfs: account ticket size at add/delete time")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> There's a minor conflict with Josef's patch "btrfs: run
> btrfs_try_granting_tickets if a priority ticket fails" so I'll apply
> yours to misc-5.7 as it's a regression fix.
>
> > @@ -1121,7 +1129,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
> >                * either the async reclaim job deletes the ticket from the list
> >                * or we delete it ourselves at wait_reserve_ticket().
> >                */
> > -             list_del_init(&ticket->list);
> > +             remove_ticket(space_info, ticket);
> >               if (!ret)
> >                       ret = -ENOSPC;
> >       }
>
> The conflicting hunk is:
>
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -1156,11 +1156,17 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
>         ret = ticket->error;
>         if (ticket->bytes || ticket->error) {
>                 /*
> -                * Need to delete here for priority tickets. For regular tickets
> -                * either the async reclaim job deletes the ticket from the list
> -                * or we delete it ourselves at wait_reserve_ticket().
> +                * We were a priority ticket, so we need to delete ourselves
> +                * from the list.  Because we could have other priority tickets
> +                * behind us that require less space, run
> +                * btrfs_try_granting_tickets() to see if their reservations can
> +                * now be made.
>                  */
> -               list_del_init(&ticket->list);
> +               if (!list_empty(&ticket->list)) {
> +                       list_del_init(&ticket->list);
> +                       btrfs_try_granting_tickets(fs_info, space_info);
> +               }
> +
>                 if (!ret)
>                         ret = -ENOSPC;
>         }
> ---
>
> so I assume the correct fixup is to replace list_del_init with
> remove_ticket.

Yes, correct.
Thanks.

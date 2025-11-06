Return-Path: <linux-btrfs+bounces-18774-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A87B3C3AC5E
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 13:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E52734E0FC
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 12:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86863322539;
	Thu,  6 Nov 2025 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMk+HnXz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59FF321F39
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430753; cv=none; b=BuAr5QsF5xfQwEEGT23uy4upu5m14M+s3ZRuexm3xDT1wliz9vll2PwI2Sh9lXEMMDevc2DFzlz/e9LbVItQgdb8PHM1XiOEbQnF+qyjjvVY0iZh5/0vkTiIT0XEGHPBDb85gC2Uo4LAXGNuRn6jkLAnSIw+tXL1/3nHN25X52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430753; c=relaxed/simple;
	bh=grxDsnTwDFrNUgQrcQJPTSSi00yd3X5uRIhJMSKcWvk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDhcy1XfmhIVqgKUtLQksQLbK305eg9+F8LdHkABv20YRn/v4RNxbLoONV/uogFMaMjJj2C/6zS/z2BZ5wu7PrwSJljcuTQnvNDGOHAobZHyG3zBDycTwq9On2qHlJrb08y/KEpi+XaS+ezVo22XpmAcpyBNZrMtdP4cPDclkw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMk+HnXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4046EC4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762430753;
	bh=grxDsnTwDFrNUgQrcQJPTSSi00yd3X5uRIhJMSKcWvk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EMk+HnXz56tuev2D1dIQ4PzzRfBdQpFB2Zi2E2W7WK9VWfA9Ssl95oQvszJOfe3Wk
	 31hEK7/JpE+man8ve0a7M6ZNxxmbPmRCpCfSHc7AnaZRQkq+39IE/5oMSQ/ZUAjKhC
	 bzaLqAjV5MdyFtf4a/pQE+wZdbGiz/e5sP6eo5C75yInvquotzCvXRYl9yv6UpVqAl
	 BGp87nRWUazqMZVlYbN+854SlnRlZvQmKPkKQcAC2p7Vj/KwzbA1lf5cCfVZ01W0aP
	 aFYoA+kEeFC2RMFIN8w7djhlNsUvVqlcome0WjB9Panj2OJKVzdT4yzu5sJo78G9XY
	 ip2m9s7WxL6+A==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b7277324054so135175666b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Nov 2025 04:05:53 -0800 (PST)
X-Gm-Message-State: AOJu0Yx95xi+NKm/mMYVN75oS8bTYCoPpI6ElD2gsq8nwZajsj3p62PV
	wuQrpuOZu5XkonzdvxVL6CJzZ0vif5pPhONXF1OEUHYKWIenVPQHcukOcMSjtbv4EcVBRsuVvef
	RXwxEaC7LVAwWV/XJYvif7Vbiu7kdCG8=
X-Google-Smtp-Source: AGHT+IF4mmKTipLoFJ0NV8R+9XvOrwL6JBjD7LM6xo86IAnkOImvFPGLIfZ9CiSnRGaLGEiLbsi/T4kWIG84khgjkiQ=
X-Received: by 2002:a17:907:701:b0:b72:6143:60c2 with SMTP id
 a640c23a62f3a-b726553bc14mr723821766b.51.1762430751792; Thu, 06 Nov 2025
 04:05:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761234580.git.fdmanana@suse.com> <078852f3ef7b95046eeca1c13cfb1bfa34ccac90.1761234581.git.fdmanana@suse.com>
 <CAPjX3Fd=oPSpLhDXY=nSK1aMW2fNdBiQW44viwt0QziCpprU5A@mail.gmail.com>
In-Reply-To: <CAPjX3Fd=oPSpLhDXY=nSK1aMW2fNdBiQW44viwt0QziCpprU5A@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 6 Nov 2025 12:05:13 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6YSaUOXXzp21SNF65j+ncggeevfphYfw8EqUhEf3XHdg@mail.gmail.com>
X-Gm-Features: AWmQ_bmbDQF3BCDiGKXDXEpzyLNeclxCMtG5w91JMPKRCHfauB9jomvnLCs9K5M
Message-ID: <CAL3q7H6YSaUOXXzp21SNF65j+ncggeevfphYfw8EqUhEf3XHdg@mail.gmail.com>
Subject: Re: [PATCH 27/28] btrfs: avoid space_info locking when checking if
 tickets are served
To: Daniel Vacek <neelx@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:29=E2=80=AFAM Daniel Vacek <neelx@suse.com> wrote=
:
>
> On Thu, 23 Oct 2025 at 18:02, <fdmanana@kernel.org> wrote:
> >
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When checking if a ticket was served, we take the space_info's spinlock=
.
> > If the ticket was served (its ->bytes is 0) or had an error (its ->erro=
r
> > it not 0) then we just unlock the space_info and return.
> >
> > This however causes contention on the space_info's spinlock, which is
> > heavily used (space reservation, space flushing, allocating and
> > deallocating an extent from a block group (btrfs_update_block_group()),
> > etc).
> >
> > Instead of using the space_info's spinlock to check if a ticket was
> > served, use a per ticket spinlock which isn't used by anyone other than
> > the task that created the ticket (stack allocated) and the task that
> > serves the ticket (a reclaim task or any task deallocating space that
> > ends up at btrfs_try_granting_tickets()).
> >
> > After applying this patch and all previous patches from the same patchs=
et
> > (many attempt to reduce space_info critical sections), lockstat showed
> > some improvements for a fs_mark test regarding the space_info's spinloc=
k
> > 'lock'. The lockstat results:
> >
> > Before patchset:
> >
> >   con-bounces:     13733858
> >   contentions:     15902322
> >   waittime-total:  264902529.72
> >   acq-bounces:     28161791
> >   acquisitions:    38679282
> >
> > After patchset:
> >
> >   con-bounces:     12032220
> >   contentions:     13598034
> >   waittime-total:  221806127.28
> >   acq-bounces:     24717947
> >   acquisitions:    34103281
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/space-info.c | 56 +++++++++++++++++++++++++------------------
> >  fs/btrfs/space-info.h |  1 +
> >  2 files changed, 34 insertions(+), 23 deletions(-)
> >
> > diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> > index 86cd87c5884a..cce53a452fd3 100644
> > --- a/fs/btrfs/space-info.c
> > +++ b/fs/btrfs/space-info.c
> > @@ -517,18 +517,22 @@ bool btrfs_can_overcommit(const struct btrfs_spac=
e_info *space_info, u64 bytes,
> >  static void remove_ticket(struct btrfs_space_info *space_info,
> >                           struct reserve_ticket *ticket, int error)
> >  {
> > +       lockdep_assert_held(&space_info->lock);
> > +
> >         if (!list_empty(&ticket->list)) {
> >                 list_del_init(&ticket->list);
> >                 ASSERT(space_info->reclaim_size >=3D ticket->bytes);
> >                 space_info->reclaim_size -=3D ticket->bytes;
> >         }
> >
> > +       spin_lock(&ticket->lock);
> >         if (error)
> >                 ticket->error =3D error;
> >         else
> >                 ticket->bytes =3D 0;
> >
> >         wake_up(&ticket->wait);
> > +       spin_unlock(&ticket->lock);
> >  }
> >
> >  /*
> > @@ -1495,6 +1499,17 @@ static const enum btrfs_flush_state evict_flush_=
states[] =3D {
> >         RESET_ZONES,
> >  };
> >
> > +static bool is_ticket_served(struct reserve_ticket *ticket)
> > +{
> > +       bool ret;
> > +
> > +       spin_lock(&ticket->lock);
> > +       ret =3D (ticket->bytes =3D=3D 0);
> > +       spin_unlock(&ticket->lock);
> > +
> > +       return ret;
> > +}
> > +
> >  static void priority_reclaim_metadata_space(struct btrfs_space_info *s=
pace_info,
> >                                             struct reserve_ticket *tick=
et,
> >                                             const enum btrfs_flush_stat=
e *states,
> > @@ -1504,29 +1519,25 @@ static void priority_reclaim_metadata_space(str=
uct btrfs_space_info *space_info,
> >         u64 to_reclaim;
> >         int flush_state =3D 0;
> >
> > -       spin_lock(&space_info->lock);
> >         /*
> >          * This is the priority reclaim path, so to_reclaim could be >0=
 still
> >          * because we may have only satisfied the priority tickets and =
still
> >          * left non priority tickets on the list.  We would then have
> >          * to_reclaim but ->bytes =3D=3D 0.
> >          */
> > -       if (ticket->bytes =3D=3D 0) {
> > -               spin_unlock(&space_info->lock);
> > +       if (is_ticket_served(ticket))
> >                 return;
> > -       }
> >
> > +       spin_lock(&space_info->lock);
> >         to_reclaim =3D btrfs_calc_reclaim_metadata_size(space_info);
> >
> >         while (flush_state < states_nr) {
> >                 spin_unlock(&space_info->lock);
> >                 flush_space(space_info, to_reclaim, states[flush_state]=
, false);
> > +               if (is_ticket_served(ticket))
> > +                       return;
> >                 flush_state++;
> >                 spin_lock(&space_info->lock);
> > -               if (ticket->bytes =3D=3D 0) {
> > -                       spin_unlock(&space_info->lock);
> > -                       return;
> > -               }
> >         }
>
> The space_info->lock should be unlocked before the loop and grabbed
> again only after it. There's no need to take that lock inside with
> your change.

Yes, I'll fold that change into the patch. Thanks.

>
> --nX
>
> >
> >         /*
> > @@ -1554,22 +1565,17 @@ static void priority_reclaim_metadata_space(str=
uct btrfs_space_info *space_info,
> >  static void priority_reclaim_data_space(struct btrfs_space_info *space=
_info,
> >                                         struct reserve_ticket *ticket)
> >  {
> > -       spin_lock(&space_info->lock);
> > -
> >         /* We could have been granted before we got here. */
> > -       if (ticket->bytes =3D=3D 0) {
> > -               spin_unlock(&space_info->lock);
> > +       if (is_ticket_served(ticket))
> >                 return;
> > -       }
> >
> > +       spin_lock(&space_info->lock);
> >         while (!space_info->full) {
> >                 spin_unlock(&space_info->lock);
> >                 flush_space(space_info, U64_MAX, ALLOC_CHUNK_FORCE, fal=
se);
> > -               spin_lock(&space_info->lock);
> > -               if (ticket->bytes =3D=3D 0) {
> > -                       spin_unlock(&space_info->lock);
> > +               if (is_ticket_served(ticket))
> >                         return;
> > -               }
> > +               spin_lock(&space_info->lock);
> >         }
> >
> >         remove_ticket(space_info, ticket, -ENOSPC);
> > @@ -1582,11 +1588,13 @@ static void wait_reserve_ticket(struct btrfs_sp=
ace_info *space_info,
> >
> >  {
> >         DEFINE_WAIT(wait);
> > -       int ret =3D 0;
> >
> > -       spin_lock(&space_info->lock);
> > +       spin_lock(&ticket->lock);
> >         while (ticket->bytes > 0 && ticket->error =3D=3D 0) {
> > +               int ret;
> > +
> >                 ret =3D prepare_to_wait_event(&ticket->wait, &wait, TAS=
K_KILLABLE);
> > +               spin_unlock(&ticket->lock);
> >                 if (ret) {
> >                         /*
> >                          * Delete us from the list. After we unlock the=
 space
> > @@ -1596,17 +1604,18 @@ static void wait_reserve_ticket(struct btrfs_sp=
ace_info *space_info,
> >                          * despite getting an error, resulting in a spa=
ce leak
> >                          * (bytes_may_use counter of our space_info).
> >                          */
> > +                       spin_lock(&space_info->lock);
> >                         remove_ticket(space_info, ticket, -EINTR);
> > -                       break;
> > +                       spin_unlock(&space_info->lock);
> > +                       return;
> >                 }
> > -               spin_unlock(&space_info->lock);
> >
> >                 schedule();
> >
> >                 finish_wait(&ticket->wait, &wait);
> > -               spin_lock(&space_info->lock);
> > +               spin_lock(&ticket->lock);
> >         }
> > -       spin_unlock(&space_info->lock);
> > +       spin_unlock(&ticket->lock);
> >  }
> >
> >  /*
> > @@ -1804,6 +1813,7 @@ static int reserve_bytes(struct btrfs_space_info =
*space_info, u64 orig_bytes,
> >                 ticket.error =3D 0;
> >                 space_info->reclaim_size +=3D ticket.bytes;
> >                 init_waitqueue_head(&ticket.wait);
> > +               spin_lock_init(&ticket.lock);
> >                 ticket.steal =3D can_steal(flush);
> >                 if (trace_btrfs_reserve_ticket_enabled())
> >                         start_ns =3D ktime_get_ns();
> > diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> > index 7e16d4c116c8..a4c2a3c8b388 100644
> > --- a/fs/btrfs/space-info.h
> > +++ b/fs/btrfs/space-info.h
> > @@ -230,6 +230,7 @@ struct reserve_ticket {
> >         bool steal;
> >         struct list_head list;
> >         wait_queue_head_t wait;
> > +       spinlock_t lock;
> >  };
> >
> >  static inline bool btrfs_mixed_space_info(const struct btrfs_space_inf=
o *space_info)
> > --
> > 2.47.2
> >
> >


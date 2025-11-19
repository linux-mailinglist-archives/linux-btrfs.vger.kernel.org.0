Return-Path: <linux-btrfs+bounces-19155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A144C6F7EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 16:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34C4D383C76
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E742435A95A;
	Wed, 19 Nov 2025 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/kPum5c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78A354AD3
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563658; cv=none; b=gCe484Qdsb6SKcvTZ0j6U9OnYsF8N2/L1mXUi9vfOSwk2J+KoApJR7vHWdeEt0MKXDzUpba8RfISK3pxDDNzmJ6dCKcRZ+j4bxuw3g5yO3DC0gPH9KAKD7ObNQGdymmbsh74e0p+jhLmgAxhSN4lSH8Uu8sVanEJInNdhoXzP6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563658; c=relaxed/simple;
	bh=RDIVxgrcag7gG2Gp3CCAzd1gQCOZ/IrbzWgQw3uxHzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2M39G3HIWg3JRorl2TUzwPUt/KsQjTgbAVGfY6Wa1xmkRxO76IrZ7BdC8wEtkpN/0SPMyTHuR8gA8rez2XyJAZw2d195AbV+7SFUkYibGRlGR54m34ohquM8lgTiQcbegf5oOUzyH377dKAl4appB9I8tKXNzwrPP1rKC+16ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/kPum5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0AAC116B1
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 14:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763563657;
	bh=RDIVxgrcag7gG2Gp3CCAzd1gQCOZ/IrbzWgQw3uxHzw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L/kPum5c+9+zFwWOsZVODaH6nju9mOcETcIix7Pz67EgHf9SiRWtouWUni0w9SWKh
	 MXG0lRMFOSpFao9obDVKaHUPNhdFwueKPo9KQt91u7YXzb5K8E/nqDXGrIadu/t+0i
	 EXA5VSnN3TQHMZjingoMKlmeelETSNuAEgoEL6+KjGhA9gsKVPGx8rBjEbi1iFtBmK
	 xf4kP9aKndu0wcQ1/BYgL4GcMX/29PcZ+I3AXpn4R+NhuMfxtj++lKVud3hwTah0q4
	 +ZHm9rc8G1ZeWLpF9QABhChkXbmduZkrIG2Ua8kzWQUAeKeCTbkIStysF5yTJpuIIG
	 ufGqzt0Gs0s0w==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7355f6ef12so1203132666b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 06:47:37 -0800 (PST)
X-Gm-Message-State: AOJu0YxdPGhNF1ID+Bl7XvYKPMTWiMCNqnCA+LPj2Y7DZorhwMbOkcN2
	7gCMkkNI3rpEe4HGI1TgEkS1nSFYcjYI9+Vl3QNm3snAJHTpd9zpgj8LbyfpsIZc1mA+NwAwhWK
	ceKY/JYDTXPv5C3eCOt8gPfzd7080UJA=
X-Google-Smtp-Source: AGHT+IEUnkuITLfQXz11o8dp/vQurX353vCur7pK6rejOFEIa/sn3yrxf5Gz8aCvy486UIMZusFPGYbDYpFVm3TjWEs=
X-Received: by 2002:a17:906:b205:b0:b73:7a44:b4d5 with SMTP id
 a640c23a62f3a-b737a44b692mr1504954266b.41.1763563655436; Wed, 19 Nov 2025
 06:47:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f03e80d62a824f4494335d2bb0dc217ec26a9e98.1763556089.git.fdmanana@suse.com>
 <2c984089-f13c-4a00-98aa-39c19927dd9b@wdc.com>
In-Reply-To: <2c984089-f13c-4a00-98aa-39c19927dd9b@wdc.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 19 Nov 2025 14:46:57 +0000
X-Gmail-Original-Message-ID: <CAL3q7H74Sxz9Q0BJkNHEzsqsDA+JdJmMMBw9SioCtH3Ex3EYzw@mail.gmail.com>
X-Gm-Features: AWmQ_bkDoGqUNk9CnlN5RLgjY8JUtdHbctCCyHL2cSoDEX46o7wyZRvGSj3ate4
Message-ID: <CAL3q7H74Sxz9Q0BJkNHEzsqsDA+JdJmMMBw9SioCtH3Ex3EYzw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: use test_and_set_bit() in btrfs_delayed_delete_inode_ref()
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 2:21=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 11/19/25 1:57 PM, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Instead of testing and setting the BTRFS_DELAYED_NODE_DEL_IREF bit in t=
he
> > delayed node's flags, use test_and_set_bit() which makes the code short=
er
> > without compromising readability and getting rid of the label and goto.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/delayed-inode.c | 11 ++++-------
> >   1 file changed, 4 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index e77a597580c5..ce6e9f8812e0 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -2008,13 +2008,10 @@ int btrfs_delayed_delete_inode_ref(struct btrfs=
_inode *inode)
> >        *   It is very rare.
> >        */
> >       mutex_lock(&delayed_node->mutex);
> > -     if (test_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags))
> > -             goto release_node;
> > -
> > -     set_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node->flags);
> > -     delayed_node->count++;
> > -     atomic_inc(&fs_info->delayed_root->items);
> > -release_node:
> > +     if (!test_and_set_bit(BTRFS_DELAYED_NODE_DEL_IREF, &delayed_node-=
>flags)) {
> > +             delayed_node->count++;
> > +             atomic_inc(&fs_info->delayed_root->items);
> > +     }
> >       mutex_unlock(&delayed_node->mutex);
> >       btrfs_release_delayed_node(delayed_node, &delayed_node_tracker);
> >       return 0;
>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
>
> Just a side note here, because there's been a discussion on linux-block
> [1] about it,
>
> this now unconditionally dirties a cacheline, whereas the old version
> did only if needed.

Yes, but that's irrelevant here since this code path is only called
when unlinking an inode with a single hard link.
So it's not expected for this function to be called when the bit is already=
 set.

Thanks.

>
> [1] https://lore.kernel.org/linux-block/20251106110058.GA30278@lst.de
>
>


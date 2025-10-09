Return-Path: <linux-btrfs+bounces-17595-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C75BC9B7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 09 Oct 2025 17:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F0DA3499CE
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Oct 2025 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF0218859B;
	Thu,  9 Oct 2025 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCuaqvzR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA6715D1
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023036; cv=none; b=fHcBrejLJuVvfbkvxH1EI5/ggSW1RCrf1FFYOnCP8MxUTrubTXFq5a+L0KMLS+tGuWzDRKhhx3FGSLObjGzu48i1fQk/zVv0kjjk+Wz4c5ZIOM5F+08JyNRa1abNyp2TpXw/98iCwZ3DEDJBfGwsAlAcPv/giExoU2PCAcaNBIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023036; c=relaxed/simple;
	bh=xbKRgUAoU0WA7SAqCHXNUWZubu/lqOmMRhWFQV3m62Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud8Jj7cL2KOwOYw9YSZhHN2HWCt3GcYNGf0G6m+zGDZOy+sUFPKe4q+m+mBGnxz2asSm5iFFFqmjmR9GNrYZreNrM/ioOWxIDLVyH44bl4Uh2mAEAf8yLD+RkyxZoA2Z7YEviLXuVxWHLU/9hy/ChNK3QaxOEelERXIEW6FBy7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCuaqvzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD57C4CEE7
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Oct 2025 15:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760023036;
	bh=xbKRgUAoU0WA7SAqCHXNUWZubu/lqOmMRhWFQV3m62Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KCuaqvzRopoadZlF4+YQiKanJoG3j1wl13o/p2NY0LWD+QQ2qe5L2+faGHlm03uld
	 bYVR8E9ocJQQO92UkoqNFYxoAm7uuUfaUUzqbzGHw3k8AumcxYTmGgQFdM6tjY0Enx
	 BFsiZUZG/AU9LpGab0hO1vRs+pE5sTw5BG+aOuBLlPrX+9zmPOwsB/evE0mg1AzIYG
	 V1RIeery18nHRd/3W2c5Y5rWMmIbiLzG1O8wgT+er/nXrXeeJLA69dZ/pF415iv15o
	 59Ze4oa9OHd24tJ44lMrmwIALZYnllnfZdCwdQpraCuFiuvwdBE7e1Gpj7pe5knnxq
	 4mJp/XMUTAcVw==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b4aed12cea3so171026366b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Oct 2025 08:17:16 -0700 (PDT)
X-Gm-Message-State: AOJu0YykAGwqhEK5xurH+Is88MxntIees4e/YRchUI6pJmEuRRWAC01z
	CTGXs08YhrRXe2ATUzEYt46IF4tP8XuaKTkbkRCBUexd41yjftQMUEnwvOxNiEZ/0vtYC7FZCaR
	hFcZfwuxkDRBBHAPkw4jBAQ7ZtC1gsVc=
X-Google-Smtp-Source: AGHT+IHg1xtm1B3NNSfrtgVLcDsEPXe7KmQzsh2xFgYfyIkWp+Xw81ow5SHWQ09SXot/ms7EuMa0lnSDepBYbOJRcys=
X-Received: by 2002:a17:907:68a2:b0:b54:858e:736f with SMTP id
 a640c23a62f3a-b54858e73a1mr307568666b.36.1760023034710; Thu, 09 Oct 2025
 08:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009112814.13942-1-mark@harmstone.com> <20251009112814.13942-10-mark@harmstone.com>
 <CAL3q7H6k9Uxy_aAN5VV8q9OQFUSiGtX_NhuV8C0TCgUQjAgu8A@mail.gmail.com> <9e72962e-3d4b-4e1a-b206-512904d701ff@harmstone.com>
In-Reply-To: <9e72962e-3d4b-4e1a-b206-512904d701ff@harmstone.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 9 Oct 2025 16:16:37 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5DhH6ZfDEvZ+Ax+zv824rF2X2qNKpC9iCiGXpJNacORg@mail.gmail.com>
X-Gm-Features: AS18NWC0jEB_OzFUYcYCT95hsyj5D3nGFcxz69w2FupLs_Sso9sUJFBC5l21hDo
Message-ID: <CAL3q7H5DhH6ZfDEvZ+Ax+zv824rF2X2qNKpC9iCiGXpJNacORg@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] btrfs: release BG lock before calling btrfs_link_bg_list()
To: Mark Harmstone <mark@harmstone.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 3:58=E2=80=AFPM Mark Harmstone <mark@harmstone.com> =
wrote:
>
> On 09/10/2025 12.56 pm, Filipe Manana wrote:
> > On Thu, Oct 9, 2025 at 12:29=E2=80=AFPM Mark Harmstone <mark@harmstone.=
com> wrote:
> >>
> >> Release block_group->lock before calling btrfs_link_bg_list() in
> >> btrfs_delete_unused_bgs(), as this was causing lockdep issues.
> >
> > I believe this was asked before:
> >
> > What issues?
> > Do we have for example any other place where we have a different
> > locking order and can cause a deadlock?
> >
> > Can you please paste the lockdep splat?
>
> I didn't take a copy the first time, and I've not been able to replicate =
it
> since.
>
> But you can see the issue in patch 4, "btrfs: remove remapped block group=
s
> from the free-space tree". In btrfs_discard_punt_unused_bgs_list() we acq=
uire
> unused_bgs_lock to loop through the unused_bgs list, then take the indivi=
dual
> BG lock so we can check its flags.

So then the problem is caused by patch 4, a potential ABBA deadlock.

In that case this change should be squashed into that patch or at
least come before and say it's preparation work to avoid a lockdep
splat and potential deadlock, without the Fixes tag since, as far as I
can see, we currently don't have any code where we take the locks in a
different order.

>
> In btrfs_delete_unused_bgs() we're acquiring the unused_bgs lock through
> btrfs_link_bg_list(), while still unnecessarily holding the BG lock.
>
> The reason it's in this patchset is that a minor existing bug (holding a
> spinlock longer than we strictly need to) becomes a potential deadlock be=
cause
> of patch 4.

I don't think we can call that an existing bug...
If before patch 4 of this patchset it didn't cause any problems as
mentioned before.

>
> >
> >>
> >> This lock isn't held in any other place that we call btrfs_link_bg_lis=
t(), as
> >> the block group lists are manipulated while holding fs_info->unused_bg=
s_lock.
> >>
> >> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> >> Fixes: 0497dfba98c0 ("btrfs: codify pattern for adding block_group to =
bg_list")
> >
> > Also as told before, this doesn't seem related to the rest of the
> > patchset (the new remap tree feature).
> > So instead of dragging this along in every new version of the
> > patchset, can you please make it a standalone patch and remove it from
> > future versions of the patchset?
> >
> > Thanks.
> >
> >> ---
> >>   fs/btrfs/block-group.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> >> index d3433a5b169f..a3c984f905fc 100644
> >> --- a/fs/btrfs/block-group.c
> >> +++ b/fs/btrfs/block-group.c
> >> @@ -1620,6 +1620,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_inf=
o *fs_info)
> >>                  if ((space_info->total_bytes - block_group->length < =
used &&
> >>                       block_group->zone_unusable < block_group->length=
) ||
> >>                      has_unwritten_metadata(block_group)) {
> >> +                       spin_unlock(&block_group->lock);
> >> +
> >>                          /*
> >>                           * Add a reference for the list, compensate f=
or the ref
> >>                           * drop under the "next" label for the
> >> @@ -1628,7 +1630,6 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_inf=
o *fs_info)
> >>                          btrfs_link_bg_list(block_group, &retry_list);
> >>
> >>                          trace_btrfs_skip_unused_block_group(block_gro=
up);
> >> -                       spin_unlock(&block_group->lock);
> >>                          spin_unlock(&space_info->lock);
> >>                          up_write(&space_info->groups_sem);
> >>                          goto next;
> >> --
> >> 2.49.1
> >>
> >>
>


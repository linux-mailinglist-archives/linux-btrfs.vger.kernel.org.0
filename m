Return-Path: <linux-btrfs+bounces-16448-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AE5B386F3
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 17:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B2C17AE94C
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C272DFA3B;
	Wed, 27 Aug 2025 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuxoSWM7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B402DAFB5
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309755; cv=none; b=LLNnhvG0LQKgzc4e8MPYp3wSObIsTL6x80TU3bMTJDgf/NtsIRURgJQJLverOtIJScfDGApPW3ZQtOpFqPDY4rY/RSdm2FzQkANMn+TdECSOqpwdlLOeHA3OpyC7MTvCWcHX38B/1ZnTqcK4zhRKPufIpU/a+dNVsYfEmqv3W8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309755; c=relaxed/simple;
	bh=E5sLzG+2kaltvqwjmjzNMDHd+dcDA2pjnFRFb4SlwSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fArf7ZdD63XjzqE5fxknyPj+8d+3O38gu3ZCZ4nK8FKgq3K1Gl2x10H7bRnaIXIn4qsOGeRBBSWb3TGwQXXRMOpnVLt2HaD/owgih/vYi/JyZ0Mpvt/NQLnBQQCfuZSoMThOxXPLjfynVREGwFtW1drLRswUuHOqPH2tldx+oPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuxoSWM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC47C4CEF7
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756309755;
	bh=E5sLzG+2kaltvqwjmjzNMDHd+dcDA2pjnFRFb4SlwSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YuxoSWM7gsiC/XNz0HSDPZ4fDrljdt8537QZu2ogNb6wboJ5jPumbWI/l6BAFThVi
	 +YzMICHA6ETDBqOr35laZZvutg6WT+uLbKbMoApeSU9FAztNcH7aI89uDXQQHnzkUo
	 2QkCWhYGvj7DIy1yT7EJmL180AnnhESb2i3Qpf9aFcktqkFcqKDl6q4alEOVjCioK4
	 nTutra6fVGf4+UNFP90FNpJ/7hzm7OLy5cOFL6aI0rAeq9UuwWetawE978koWn5z7r
	 Q0e1oNaHUwx8G/HcDiYJdjI3v/GiUyBOCPlurDPnf/nfSompqM/s4wvsESyi579WZA
	 NsNlvpmIOlrkA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afec56519c8so141829066b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 08:49:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBcMxJBr8CTyjcgUKKg98Sn7kPHnXA3Qhy6QIRfCuicCUgj9b9I/3fVqWtlf4XhBxvMPQUQKQvGiPsCA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyB86KYr3kDrigGG69PgH0VSdaLhYlIZseHlaau2tFUOpS01/C1
	s0F1WwyE1ELPDkSs+rhtsIz3sdvGOLcVdGX13m0k1ieRCth3KxsFFQ3lulFb/ERy+nkUYYG2u81
	D/l6P2C3ngJXfI7INDJCSrP9h++y+NcI=
X-Google-Smtp-Source: AGHT+IGLUbEtV7yk9Y2hA4Ol8FfV+XLv8wM5CNO7lmijuL9PivtSxUlQMkQVQ/uvphJPZurkWNC+YcK2y+FwjJXvr3k=
X-Received: by 2002:a17:907:e98a:b0:afd:d62d:980e with SMTP id
 a640c23a62f3a-afe29446dcbmr1902660266b.28.1756309753540; Wed, 27 Aug 2025
 08:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813143509.31073-1-mark@harmstone.com> <20250813143509.31073-10-mark@harmstone.com>
 <20250816003233.GF3042054@zen.localdomain> <b6df2e8e-121c-482f-92ec-b8abf74b8e03@harmstone.com>
In-Reply-To: <b6df2e8e-121c-482f-92ec-b8abf74b8e03@harmstone.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 27 Aug 2025 16:48:36 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6L4ydNheXdqczcHj9q9tLiDXKtqrk9XKfgt=tJfa9qjg@mail.gmail.com>
X-Gm-Features: Ac12FXxH9puNYWAiTJKf14LbUUKXLnfy31-GwvQPjhR2RZnleChi9mJ4JJS7a34
Message-ID: <CAL3q7H6L4ydNheXdqczcHj9q9tLiDXKtqrk9XKfgt=tJfa9qjg@mail.gmail.com>
Subject: Re: [PATCH v2 09/16] btrfs: release BG lock before calling btrfs_link_bg_list()
To: Mark Harmstone <mark@harmstone.com>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 4:36=E2=80=AFPM Mark Harmstone <mark@harmstone.com>=
 wrote:
>
> On 16/08/2025 1.32 am, Boris Burkov wrote:
> > On Wed, Aug 13, 2025 at 03:34:51PM +0100, Mark Harmstone wrote:
> >> Release block_group->lock before calling btrfs_link_bg_list() in
> >> btrfs_delete_unused_bgs(), as this was causing lockdep issues.
> >>
> >> This lock isn't held in any other place that we call btrfs_link_bg_lis=
t(), as
> >> the block group lists are manipulated while holding fs_info->unused_bg=
s_lock.
> >>
> >
> > Please include the offending lockdep output you are fixing.
>
> I didn't include it as lockdep was triggering on the second (correct) ins=
tance,
> while the problem was on the first (incorrect) instance, and thought it w=
ould
> confuse matters. And I stupidly didn't take a copy, and now I can't repro=
duce
> it.
>
> The issue is that in btrfs_discard_punt_unused_bgs_list() in "btrfs: remo=
ve
> remapped block groups from the free-space tree", we're holding unused_bgs=
_lock
> then looping through the list grabbing the individual block group list. I=
n
> btrfs_delete_unused_bgs() we're grabbing unused_bgs_lock while unnecessar=
ily
> holding the block group lock.
>
>
> > Is this a generic fix unrelated to your other changes? I think a
> > separate patch from the series is clearer in that case. And it would
> > need a Fixes: tag (probably my patch that added btrfs_link_bg_list, hah=
a)
>
> It looks like it's actually f4a9f219411f318ae60d6ff7f129082a75686c6c,
> "btrfs: do not delete unused block group if it may be used soon".

No, it's not.
In that commit we didn't acquire fs_info->unused_bgs_lock.

The locking that makes lockdep not happy was added in 0497dfba98c0
("btrfs: codify pattern for adding block_group to bg_list"),
as it replaced the open coded list_add_tail() with the call to the new
function btrfs_link_bg_list(), and this new function locks
fs_info->unused_bgs_lock.


>
> >
> > Thanks.
> >
> >> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> >> ---
> >>   fs/btrfs/block-group.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> >> index bed9c58b6cbc..8c28f829547e 100644
> >> --- a/fs/btrfs/block-group.c
> >> +++ b/fs/btrfs/block-group.c
> >> @@ -1620,6 +1620,8 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_inf=
o *fs_info)
> >>              if ((space_info->total_bytes - block_group->length < used=
 &&
> >>                   block_group->zone_unusable < block_group->length) ||
> >>                  has_unwritten_metadata(block_group)) {
> >> +                    spin_unlock(&block_group->lock);
> >> +
> >>                      /*
> >>                       * Add a reference for the list, compensate for t=
he ref
> >>                       * drop under the "next" label for the
> >> @@ -1628,7 +1630,6 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_inf=
o *fs_info)
> >>                      btrfs_link_bg_list(block_group, &retry_list);
> >>
> >>                      trace_btrfs_skip_unused_block_group(block_group);
> >> -                    spin_unlock(&block_group->lock);
> >>                      spin_unlock(&space_info->lock);
> >>                      up_write(&space_info->groups_sem);
> >>                      goto next;
> >> --
> >> 2.49.1
> >>
>
>


Return-Path: <linux-btrfs+bounces-2433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E585646A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 14:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F6F2884EA
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 13:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1B8130AE1;
	Thu, 15 Feb 2024 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1Un70Mb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7F3130AC4
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Feb 2024 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003878; cv=none; b=U1HXsnG+EQdDHvd8g7L9PrC86g+GHD3tAt68cXbvH/1S3r833azY6kw4O5RyCAdlhsb3hGnyJAZTcEk3OSpq0lKD4ROphaXdRy1flJBUcUciMega9hWcdKGzH+qGTeDEkvSnjRfUS1i4XXQIcI5unBTUx2fWHdWpt6vz1hoYiLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003878; c=relaxed/simple;
	bh=t608W+COzEH3PPfJooHlB8hfALcO3r8qQTUJZKXS97I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkIZcJS6uvLOni7WpK1fuTX3lcUMB/fCxAY7D1BggsWrWp40dLaao4xKV/LRH4aCa8gTquDCkk9PA/68g34JhVz1XQAC5sXH583VQK6IvETO7n8KkUOYgkBtKgNVYX76ujp0PEbbS3vdiFwiWfcl3vfr1b06bhi4+QftZoYL00E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1Un70Mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3385AC433F1
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Feb 2024 13:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708003878;
	bh=t608W+COzEH3PPfJooHlB8hfALcO3r8qQTUJZKXS97I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F1Un70MbHWZkcff7PTBa8ez9Jd0H8dkEnuFSV/5zA+TKCpCTNOIc+2qyi757k2FlG
	 nymHVBNG8xxRFWVXUPl8ha1xzJnZbPH5+BiHphYSVvA4ZQ7GuWFviqvuJ4C7Pgik+i
	 gVp7iUgOsLTnCp8EIW809MhB3idxHYbJbUvu7vEbgxJQ6E1nvNKhkQzsC+VEEsYzQi
	 nBrJC5V++zdeILKHFUz9Xf/iFBsAQDEEV3z9AjvU7/hQYSQ3bggvjxX+wI5+x1akgN
	 daw/92+1HOWflXXs6vkwmtdzetZ200okRteMuQznbvnSbJROFkLzKZacGUDBZdXWM2
	 E4Bgwztr3335w==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d10ad265d5so11502361fa.0
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Feb 2024 05:31:18 -0800 (PST)
X-Gm-Message-State: AOJu0YxxhYNKcUM699QXjyrFOVjBBaXD/92Vx7ksmSzCNgdiWvajiM3d
	pR9giGgs9E3fU+Offt48PUNNG8Wzv8ITdxKqxr2cC5P6FCjCb4A6o/+LHWQcK9yRIPAHuO/yVXP
	8XmfmzFq8VHkUgTxZAOjhFP/2Lg8=
X-Google-Smtp-Source: AGHT+IEQgFoyL5tfJvRXJr4vtiyLUKuyCkXcpAaocMDuRxrIwKAqahOczGkunD+HlW1LmMe4W8QCr4aiUJ4p0T4hu9k=
X-Received: by 2002:ac2:46ee:0:b0:511:9579:1be7 with SMTP id
 q14-20020ac246ee000000b0051195791be7mr1457950lfo.43.1708003876380; Thu, 15
 Feb 2024 05:31:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eba624e8cef9a1e84c9e1ba0c8f32347aa487e63.1706892030.git.fdmanana@suse.com>
 <20240213152144.GA4107730@perftesting>
In-Reply-To: <20240213152144.GA4107730@perftesting>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 15 Feb 2024 13:30:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6VszmT0Nb+tGbLD8kQ_ExOvieWjccPjRy5af_mKwVzGA@mail.gmail.com>
Message-ID: <CAL3q7H6VszmT0Nb+tGbLD8kQ_ExOvieWjccPjRy5af_mKwVzGA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: don't refill whole delayed refs block reserve when
 starting transaction
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 3:21=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Fri, Feb 02, 2024 at 04:42:32PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Since commit 28270e25c69a ("btrfs: always reserve space for delayed ref=
s
> > when starting transaction") we started not only to reserve metadata spa=
ce
> > for the delayed refs a caller of btrfs_start_transaction() might genera=
te
> > but also to try to fully refill the delayed refs block reserve, because
> > there are several case where we generate delayed refs and haven't reser=
ved
> > space for them, relying on the global block reserve. Relying too much o=
n
> > the global block reserve is not always safe, and can result in hitting
> > -ENOSPC during transaction commits or worst, in rare cases, being unabl=
e
> > to mount a filesystem that needs to do orphan cleanup or anything that
> > requires modifying the filesystem during mount, and has no more
> > unallocated space and the metadata space is nearly full. This was
> > explained in detail in that commit's change log.
> >
> > However the gap between the reserved amount and the size of the delayed
> > refs block reserve can be huge, so attempting to reserve space for such
> > a gap can result in allocating many metadata block groups that end up
> > not being used. After a recent patch, with the subject:
> >
> >   "btrfs: add new unused block groups to the list of unused block group=
s"
> >
> > We started to add new block groups that are unused to the list of unuse=
d
> > block groups, to avoid having them around for a very long time in case
> > they are never used, because a block group is only added to the list of
> > unused block groups when we deallocate the last extent or when mounting
> > the filesystem and the block group has 0 bytes used. This is not a prob=
lem
> > introduced by the commit mentioned earlier, it always existed as our
> > metadata space reservations are, most of the time, pessimistic and end =
up
> > not using all the space they reserved, so we can occasionally end up wi=
th
> > one or two unused metadata block groups for a long period. However afte=
r
> > that commit mentioned earlier, we are just more pessimistic in the
> > metadata space reservations when starting a transaction and therefore t=
he
> > issue is more likely to happen.
> >
> > This however is not always enough because we might create unused metada=
ta
> > block groups when reserving metadata space at a high rate if there's
> > always a gap in the delayed refs block reserve and the cleaner kthread
> > isn't triggered often enough or is busy with other work (running delaye=
d
> > iputs, cleaning deleted roots, etc), not to mention the block group's
> > allocated space is only usable for a new block group after the transact=
ion
> > used to remove it is committed.
>
> We should probably stop abusing the cleaner thread for this and just use =
work
> items for the different categories of cleanup operations.  But that's jus=
t an
> aside.

Exactly, and I have had that in mind for quite a while, to move
everything the cleaner
does into separate workqueue jobs, and then eventually get rid of the clean=
er.

Once I finish what I'm currently working on, I'll do that.

Thanks.

>
> >
> > A user reported that he's getting a lot of allocated metadata block gro=
ups
> > but the usage percentage of metadata space was very low compared to the
> > total allocated space, specially after running a series of block group
> > relocations.
> >
> > So for now stop trying to refill the gap in the delayed refs block rese=
rve
> > and reserve space only for the delayed refs we are expected to generate
> > when starting a transaction.
> >
> > CC: stable@vger.kernel.org # 6.7+
> > Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
> > Link: https://lore.kernel.org/linux-btrfs/9cdbf0ca9cdda1b4c84e15e548af7=
d7f9f926382.camel@intelfx.name/
> > Link: https://lore.kernel.org/linux-btrfs/CAL3q7H6802ayLHUJFztzZAVzBLJA=
GdFx=3D6FHNNy87+obZXXZpQ@mail.gmail.com/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> Thanks,
>
> Josef


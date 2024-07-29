Return-Path: <linux-btrfs+bounces-6844-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353CD93F8DB
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 16:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79732827C8
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AEB155A56;
	Mon, 29 Jul 2024 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CP85dTUl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41A3158DA7
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722265092; cv=none; b=pUtiGwHJCAvPbfW+6/cAJ3U1FrWucyjOzpqadfH2tMbhua40Q/saNCnk3W5tSieK+Y7Qk62DyngE6IGNCzB1TGuUVFCy0CfX9LvPotnRxRyDc3wg8XW6Rci/FWXwXw58yalmt8HAbS9quOCpGynKsHTXDEPkN+Q/LmdGOLQ5TUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722265092; c=relaxed/simple;
	bh=BG/PKqkxNFso+7Em32NJq9SnfluOzWU5OPBof9fv9gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4pO/Tf4kTMK7/KDhyuMmkay+OE+pWxnK9f7UYaOB+LAp5FxBfow0G9BtAAxXZqtkYK9DDjbSLKWAyv27vYxizB/A75EcunC6dB1dbCo93GBCmmFr1TQTC2EhY0sPIbyipURuFZDlWQX3fJB/9EwjemlGIyCxv3EuXvn0pQKEnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=CP85dTUl; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6659e81bc68so22739817b3.0
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 07:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722265089; x=1722869889; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fuXGMJBzSP7j8t9deaVTg6e3wDVCsetmnsIRW01Ktgg=;
        b=CP85dTUlJbrAkYo4Vnnx3Kj2KE096qOAmvJW9KXvtsvakIo7oqoeVfDvR2PJcdWT77
         /tEjT1jrNp0Yjnk/m+Mkg/5/U7w143Igx88EUvX8/fzGx2v1q6DXVP95Jb89d6EgBbTX
         KfcvLTehtOW8OxCiZ9Gru7HEbbBKAwQ43cr4uBx+JMT31cOFyF1wVqXW5OTDOhFHlQnQ
         n5o3IpA5M4aQVeFT5wVv24lbSg0Uf2SHympgvbsL5+hNUWzz5+54LeKYa93addaS3Wtr
         Qj2pmOLGQyGuaMbXJ4KJrwMyHXZMZ/Wj+tz5moQLnic7BLr4iVvxo+JpPtxxB7DareCv
         XfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722265089; x=1722869889;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuXGMJBzSP7j8t9deaVTg6e3wDVCsetmnsIRW01Ktgg=;
        b=NkPQUGpQi6eD6KlzEn6zcxAkSiJpFQpRDOBadYKJfwQEJJrQ1ezCMqAwmrhSL9XRZK
         ZMw6kqpgDijzeIpYry5J/nMRloDAHj44JHcV75VZ4iXdIEIAr8f92k4abN4pWdz4oMse
         vn1OgmzkB9USccAso1XZMG4Z8PulBY7OjTjPVarrPRuUv2I3zypKiOLs0o4sKyhwxrTj
         nq+Z7VeaHtos//lg0o84tnNdUW3vfQWgSXzX7F19SikaBU4h4MX/qOJgrp9ZdSZnIZ+6
         eHbAhQAeEymBx4UYhGyoulzNoUAGHH4KlgVY/DVNUZmeg5pT/g3nKMy51nrydZGGokA5
         1vXg==
X-Forwarded-Encrypted: i=1; AJvYcCXaVp/GJ80QW04OtNQVosVLH4uelVjqKiAeIur/zfaWTBzTo+a0qs1eM2CCq1jvqpndBdlHBahOqEKUVb8tB0E/braHwXn2WJZDX9U=
X-Gm-Message-State: AOJu0YxTIFXvOWMddjg8qakHohq0rn8JgH3A9GSjOq9CF9i9RlnyuE7P
	upFGxjbKj+0KrKUk1reItQL9qnXq7y9WDzbAZNWBn3jilZJVTaSKfob/nkSaIZc=
X-Google-Smtp-Source: AGHT+IGymmNvOXOe8/VEqE7nQsoBC5NqBhBlOkpHMatW4uat6qMIr2aFym8IbLFjGM8O8rQa1CH7nw==
X-Received: by 2002:a81:8847:0:b0:648:bca0:1e71 with SMTP id 00721157ae682-67a09595102mr83458597b3.35.1722265089616;
        Mon, 29 Jul 2024 07:58:09 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756795e992sm20881337b3.46.2024.07.29.07.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:58:09 -0700 (PDT)
Date: Mon, 29 Jul 2024 10:58:08 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: properly take lock to read/update BG's
 zoned variables
Message-ID: <20240729145808.GA3596468@perftesting>
References: <9eb249aedabfa6008cbf13706b7f3c03dc59855d.1722241885.git.naohiro.aota@wdc.com>
 <CAL3q7H6AZOGvYbf=BmEVEE_qWZYk86Li1s=jrfyOoUKAHhtDdw@mail.gmail.com>
 <20240729144150.GA3589837@perftesting>
 <CAL3q7H5Nbo=0=kM8-sWv3KO9Xbki+zwyD8gyVgDu87dESBwMbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5Nbo=0=kM8-sWv3KO9Xbki+zwyD8gyVgDu87dESBwMbw@mail.gmail.com>

On Mon, Jul 29, 2024 at 03:48:39PM +0100, Filipe Manana wrote:
> On Mon, Jul 29, 2024 at 3:41 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Mon, Jul 29, 2024 at 12:46:48PM +0100, Filipe Manana wrote:
> > > On Mon, Jul 29, 2024 at 9:33 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
> > > >
> > > > __btrfs_add_free_space_zoned() references and modifies BG's alloc_offset,
> > > > ro, and zone_unusable, but without taking the lock. It is mostly safe
> > > > because they monotonically increase (at least for now) and this function is
> > > > mostly called by a transaction commit, which is serialized by itself.
> > > >
> > > > Still, taking the lock is a safer and correct option and I'm going to add a
> > > > change to reset zone_unusable while a block group is still alive. So, add
> > > > locking around the operations.
> > > >
> > > > Fixes: 169e0da91a21 ("btrfs: zoned: track unusable bytes for zones")
> > > > CC: stable@vger.kernel.org # 5.15+
> > > > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > > > ---
> > > >  fs/btrfs/free-space-cache.c | 15 ++++++++-------
> > > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> > > > index f5996a43db24..51263d6dac36 100644
> > > > --- a/fs/btrfs/free-space-cache.c
> > > > +++ b/fs/btrfs/free-space-cache.c
> > > > @@ -2697,15 +2697,16 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
> > > >         u64 offset = bytenr - block_group->start;
> > > >         u64 to_free, to_unusable;
> > > >         int bg_reclaim_threshold = 0;
> > > > -       bool initial = ((size == block_group->length) && (block_group->alloc_offset == 0));
> > > > +       bool initial;
> > > >         u64 reclaimable_unusable;
> > > >
> > > > -       WARN_ON(!initial && offset + size > block_group->zone_capacity);
> > > > +       guard(spinlock)(&block_group->lock);
> > >
> > > What's this guard thing and why do we use it only here? We don't use
> > > it anywhere else in btrfs' code base.
> > > A quick search in the Documentation directory of the kernel and I
> > > can't find anything there.
> > > In the fs/ directory there's only two users of it.
> > >
> >
> > It's relatively new, it's like the C++ guards.  If you look in the VFS we've
> > started using it pretty heavily there.
> >
> > But it does need to be documented, if you look at include/linux/cleanup.h it has
> > documentation about it.
> >
> > > Why not the usual spin_lock(&block_group->lock) call?
> >
> > Because this is nice for error handling.  Here it doesn't look as helpful, but
> > look at d842379313a2 ("fs: use guard for namespace_sem in statmount()") for an
> > example of how much it cleans up the error paths.
> >
> > FWIW one of the tasks I have for one of our new people is to come through and
> > utilize some of this new infrastructure to cleanup our error paths, so while it
> > doesn't exist yet inside btrfs, I hope it gets used pretty liberally.  Thanks,
> 
> I see, I figured it was something to avoid repeating unlock calls.
> 
> But rather than fixing a bug and doing the migration in a single
> patch, I'd rather have 1 patch to fix the bug and another to the
> migration afterwards.
> 

Fair, agreed,

Josef


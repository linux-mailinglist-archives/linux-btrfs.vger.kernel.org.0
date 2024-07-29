Return-Path: <linux-btrfs+bounces-6838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 713F693F873
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 16:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C19BAB20996
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 14:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B711527AC;
	Mon, 29 Jul 2024 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="jSilv0wX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B387814AD19
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722264114; cv=none; b=Jrz+umlnhOUHpacyDUbV9GR0EB4bQvhEbDZIa33m5Y4mHnchcJPTmFoyAtV32N+IyVjnifzwITwkqxLZ2lmGmWhRZZT8Wa2T6vmMV+aWKoEhUuaVQmJuBXrhm1pImVL1wIdREVpOlT5tgjWTQcVlWaq0rvx5HdpW/H+zAvFf8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722264114; c=relaxed/simple;
	bh=EKmWilDzjf4hEYw+RsyjIWEELuGA8bc4iAffwtuDOck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9r2klWEGnjpbtNUED7oZG6/URA03aPU2kRvxCUMzBRF0VA775JYGyTUupHWfIN9oxACark3wfvymM22+1XJkdrnbrTtHEid8pODQd0CFVZDzQmc87I1erocDw620RfX11nMplwToP3RDkVb0b/r7D9AVsfYfbM1ZPdCmschFaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=jSilv0wX; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-66493332ebfso20249627b3.3
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2024 07:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1722264112; x=1722868912; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c3auTI3rvow29Pp1Jd327mEmLXjtywxBKuvkLGD2pj0=;
        b=jSilv0wXDbIznxlUEYVkVh7bWZvPUjB0j6gsaFWlDGvN9IAhOhoksWO6DK1IfydnML
         RGJBtvAQc3xIWsfIm4czq/vIlgryud879u8y+hynPNb2B+zAy+1VwgmG/tp+SehjEtdf
         6kTe01EYoFPTst576qKrTxa648WvcYOm0puhscM7AkI3wP0ABYknsBQxY7Xk2S0srbLA
         RvWXX1G93qhnZsrvY5We5mns4rplUbr0R0CNbpz4eUcC0RpAITAK385cUtog/fnClyNS
         NzrF34zaDDeaXGwFT5qJUKaooaySLkW9tDR6vtwdDhVgJsi1s8GzDcha3+yg3JPSiCkU
         jRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722264112; x=1722868912;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c3auTI3rvow29Pp1Jd327mEmLXjtywxBKuvkLGD2pj0=;
        b=V81cQyE932Rn9dI8Tb+YTJ00Ei6p8jcCab4qE+GaY1twDbQ+pEFh0CnGHPm8BJSi+5
         pE1WMA9L721MprFEcTVGH3axIMXd9Q9n5WabcT1O5I4MXSlGAEk2CzbHQ7hiadw9IOsY
         uy+v6iwbgzM50N8cqMCiZnVYh2XAOdBQg2fkBvIdSFlCgcw9/E8ruEDh3WQFg+pTvfsm
         a0T7L1Ov9dESsAQBHk3ODitLuOr698O7WgMcdBhZqVqQaLIBUVsHppPkEWLMBAdOuCyZ
         VbX8MpXwiF5/sGTth5Epl5cKnEmT1VZW87t5qmgGfmRuYW+7Zf5ThkgeLmor4zkkcxLA
         HjkA==
X-Forwarded-Encrypted: i=1; AJvYcCV/iQs84BXXrHCrXxquG3aldwis9MdyBiT3tIs5bR2wpz2VLPWMmYJ3E1AZ29FdPpbHR7oDasA3CcjTlPUinCrlCwGZTQmRarNsaoY=
X-Gm-Message-State: AOJu0YwQs1unRwUuljziAg7HpCYg9+ysIencxZr3O0kBc+dRWyxeBUJh
	6Izc/p59pmXWbgZ1PGnwxam5PQkzyBmB6g5qcKfa18d3Dlm6WSKuzwLffGIEdtnC4ndshBb5oqo
	/
X-Google-Smtp-Source: AGHT+IEUKw/fe8aC8hdqbO6Q67jsMb8FgAO9CiEgYgU5OCi2hegQK1g0m3Kn4g2oMadPa3bkjOHG/Q==
X-Received: by 2002:a0d:f746:0:b0:65f:80ed:683e with SMTP id 00721157ae682-67ac8d51744mr87661297b3.2.1722264111586;
        Mon, 29 Jul 2024 07:41:51 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-67567a537f8sm20906107b3.56.2024.07.29.07.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:41:51 -0700 (PDT)
Date: Mon, 29 Jul 2024 10:41:50 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: properly take lock to read/update BG's
 zoned variables
Message-ID: <20240729144150.GA3589837@perftesting>
References: <9eb249aedabfa6008cbf13706b7f3c03dc59855d.1722241885.git.naohiro.aota@wdc.com>
 <CAL3q7H6AZOGvYbf=BmEVEE_qWZYk86Li1s=jrfyOoUKAHhtDdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6AZOGvYbf=BmEVEE_qWZYk86Li1s=jrfyOoUKAHhtDdw@mail.gmail.com>

On Mon, Jul 29, 2024 at 12:46:48PM +0100, Filipe Manana wrote:
> On Mon, Jul 29, 2024 at 9:33 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
> >
> > __btrfs_add_free_space_zoned() references and modifies BG's alloc_offset,
> > ro, and zone_unusable, but without taking the lock. It is mostly safe
> > because they monotonically increase (at least for now) and this function is
> > mostly called by a transaction commit, which is serialized by itself.
> >
> > Still, taking the lock is a safer and correct option and I'm going to add a
> > change to reset zone_unusable while a block group is still alive. So, add
> > locking around the operations.
> >
> > Fixes: 169e0da91a21 ("btrfs: zoned: track unusable bytes for zones")
> > CC: stable@vger.kernel.org # 5.15+
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/free-space-cache.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> > index f5996a43db24..51263d6dac36 100644
> > --- a/fs/btrfs/free-space-cache.c
> > +++ b/fs/btrfs/free-space-cache.c
> > @@ -2697,15 +2697,16 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
> >         u64 offset = bytenr - block_group->start;
> >         u64 to_free, to_unusable;
> >         int bg_reclaim_threshold = 0;
> > -       bool initial = ((size == block_group->length) && (block_group->alloc_offset == 0));
> > +       bool initial;
> >         u64 reclaimable_unusable;
> >
> > -       WARN_ON(!initial && offset + size > block_group->zone_capacity);
> > +       guard(spinlock)(&block_group->lock);
> 
> What's this guard thing and why do we use it only here? We don't use
> it anywhere else in btrfs' code base.
> A quick search in the Documentation directory of the kernel and I
> can't find anything there.
> In the fs/ directory there's only two users of it.
> 

It's relatively new, it's like the C++ guards.  If you look in the VFS we've
started using it pretty heavily there.

But it does need to be documented, if you look at include/linux/cleanup.h it has
documentation about it.

> Why not the usual spin_lock(&block_group->lock) call?

Because this is nice for error handling.  Here it doesn't look as helpful, but
look at d842379313a2 ("fs: use guard for namespace_sem in statmount()") for an
example of how much it cleans up the error paths.

FWIW one of the tasks I have for one of our new people is to come through and
utilize some of this new infrastructure to cleanup our error paths, so while it
doesn't exist yet inside btrfs, I hope it gets used pretty liberally.  Thanks,

Josef


Return-Path: <linux-btrfs+bounces-10814-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF49A07033
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 09:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F274164EE4
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 08:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EE3215073;
	Thu,  9 Jan 2025 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IqbwEX2L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5A0206F3E
	for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2025 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412124; cv=none; b=Qp5s+xpJLPbcc0EiiOJxxEtSYpp0UGXldiF3+nXu1RrbyQ6fy+WQTVHvuCY3ZO6MxdKAasAL/bJhQ5fbcqDEub6QJptthQbbb1O/00J3duOoDh7nHbsJbgudyjYT2MuC6PkfaNv50SC2gobQqlIto8+Ik4spkqncg/LLecCL9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412124; c=relaxed/simple;
	bh=1REBbDpaPo+RYl9SJuM72wKzvy4O6Q343w06cU/vTDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rA5703j1dcUeSTnsyvXPktC9NrRqbqX2gJVEpyUGrt9UJE8AtRZJoVffP8t+SUKfUFcOXkNfWzv6+COESpEPG7WelgdhFhGpwJMJ7eXm6xOcNqz6Oj+qFLUBA5eeKq6O3MQmGgPCrMlZwjVuqMmMYjTL0Z0wUZNLAuUn8XAmUOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IqbwEX2L; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8e52so920332a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Jan 2025 00:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736412121; x=1737016921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1REBbDpaPo+RYl9SJuM72wKzvy4O6Q343w06cU/vTDw=;
        b=IqbwEX2LKNf4ZPqpaUWSSIM1cdyNI3oX3jpLP9fytk2YJrsJYxuukFa/DgdOzTZDU+
         MZNQxncgv12TYQ1ld0G5YvRAMfsDg3QfE49/jzbtyb1T19wY9VE0werpBEDwZqbgigBz
         wwLf2X4G1tW6/tTkRhgFJSCZuuKJu9Llpj3NJtGE2pEDpuDTXsTa+eqkvFkOswd4GliY
         4TiMifuExcano5X2Yo1F2vXw9FD7n0CUOiyqhHsyJO5O8ld4VESN88FtNIKqMc8RtwkH
         FbQferHF+fuSVw79Mr+L7+Ilte5/zIZ2QCLa++9hdtGNUp4a0tJCTkc/A6OBuGrasIPs
         9sQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736412121; x=1737016921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1REBbDpaPo+RYl9SJuM72wKzvy4O6Q343w06cU/vTDw=;
        b=lJwW8efP8tZk0Qf0r230thafZOUggdMdw9ql3S6GZ+QcBqiqbXk2Q85SYwLhmXsaaG
         KWgF+6PbkHI5GVDPKNO5BlEb5+McVeN4WL0O7oEiqOw85/NTmajp2BnGYFUsGd5vfzgI
         4P33lXc1irzaYrYMqcnnWtxjmqZ1xv3nx/IRcbQqdqWlYROO7C4yvkkG3NlbN4Dhbt3S
         NfIHXeWFaaM5AChof0IoYFR1kvNqqa+A7S3H0NyWeu0sgpDwn/wDXfor3PfLYt+KR5Ti
         zvMijmsQUE5gsd/7eCWhyKq5Amq8bw27FuU9NnWQ7Bo0bhVXgCYDCZGWAH4JlLUzBDQs
         00tw==
X-Forwarded-Encrypted: i=1; AJvYcCVCkuCjCdM2yvch5sicAAMlmrwVYDn/0qXbALmsLrejhFuDbOQT9yR4sjg96laI5DDlziKjFKw6COUNgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxX3lqWGtK7opjay7GB6sasP86ZnQHDuilkEo72pZXxqryQ2aa5
	9ZnlipfJ0Me1dNGCN/mq+lxBOptXkkQZGzIhW+wL/pasZ9prEEV+6JrUU7SP8xrTIyeI6pbiOUm
	DfXcw523Qw2Yt+shjG3SSEmyOW6aYzaq/B+8H/w==
X-Gm-Gg: ASbGncu2+xtFvE2KD6R2KQMueYx7ppZadQYJY7nODYqDrhyBt8M0T9uC9K84PyigOU+
	x/WJsSidnlPFNPS1gIUeluMy37kIROwDYYPjF
X-Google-Smtp-Source: AGHT+IEi0Q2KiVtSHKHlT3ovE+UkdE3D69IPuSqBIifLoBGLFqz9nHD2eI3g4QKAudK9WQ/bc7BzgbozeWYA7JSGWN0=
X-Received: by 2002:a17:906:d555:b0:aa6:7b34:c1a8 with SMTP id
 a640c23a62f3a-ab2ab70a5a8mr448299766b.55.1736412121166; Thu, 09 Jan 2025
 00:42:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108114326.1729250-1-neelx@suse.com> <9cca57da-3361-470d-83e5-0d78deffb673@wdc.com>
 <CAPjX3Feomu-=eBot9WRf3k3U+4BmbA0szH8cKHF6GdbKRBNZ1w@mail.gmail.com> <c51c6cc1-4bc5-48d0-adce-a8d8d63227ce@wdc.com>
In-Reply-To: <c51c6cc1-4bc5-48d0-adce-a8d8d63227ce@wdc.com>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 9 Jan 2025 09:41:51 +0100
X-Gm-Features: AbW1kvY6a0V0n6d9WgZbzb1RbTarxE0lnb123eqH19-Rh01G3gqE_Z52ENo2Qo4
Message-ID: <CAPjX3FdEZVHW-atYk3ufRj5=6TiiSvuL+=gNobv2biPJ0wuf=w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: keep `priv` struct on stack for sync reads in `btrfs_encoded_read_regular_fill_pages()`
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jan 2025 at 19:29, Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 08.01.25 16:25, Daniel Vacek wrote:
> > On Wed, 8 Jan 2025 at 13:42, Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> >>
> >> On 08.01.25 12:44, Daniel Vacek wrote:
> >>> Only allocate the `priv` struct from slab for asynchronous mode.
> >>>
> >>> There's no need to allocate an object from slab in the synchronous mode. In
> >>> such a case stack can be happily used as it used to be before 68d3b27e05c7
> >>> ("btrfs: move priv off stack in btrfs_encoded_read_regular_fill_pages()")
> >>> which was a preparation for the async mode.
> >>>
> >>> While at it, fix the comment to reflect the atomic => refcount change in
> >>> d29662695ed7 ("btrfs: fix use-after-free waiting for encoded read endios").
> >>
> >>
> >> Generally I'm not a huge fan of conditional allocation/freeing. It just
> >> complicates matters. I get it in case of the bio's bi_inline_vecs where
> >> it's a optimization, but I fail to see why it would make a difference in
> >> this case.
> >>
> >> If we're really going down that route, there should at least be a
> >> justification other than "no need" to.
> >
> > Well the main motivation was not to needlessly exercise the slab
> > allocator when IO uring is not used. It is a bit of an overhead,
> > though the object is not really big so I guess it's not a big deal
> > after all (the slab should manage just fine even under low memory
> > conditions).
> >
> > 68d3b27e05c7 added the allocation for the async mode but also changed
> > the original behavior of the sync mode which was using stack before.
> > The async mode indeed requires the allocation as the object's lifetime
> > extends over the function's one. The sync mode is perfectly contained
> > within as it always was.
> >
> > Simply, I tend not to do any allocations which are not strictly
> > needed. If you prefer to simply allocate the object unconditionally,
> > we can just drop this patch.
>
> At the end of the day it's David's call, he's the maintainer. I'm just
> not sure if skipping the allocator for a small short lived object is
> worth the special casing. Especially as I got bitten by this in the past
> when hunting down kmemleak reports. Conditional allocation is like
> conditional locking, sometimes OK but it raises suspicion.

Well in this case the scope is really limited just to those two
functions which you can fit on the screen. It looks quite readable to
me.

And the async/iouring case is already treated conditionally here.

In the end this patch only makes the sync case behave as it was before
introducing the async changes.

--nX


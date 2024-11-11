Return-Path: <linux-btrfs+bounces-9457-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C85429C494E
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 23:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5833B1F26A6C
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 22:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C131AD5D8;
	Mon, 11 Nov 2024 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="nyIh2cFy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2851A9B3A
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731365194; cv=none; b=ExgPkZl+EhuRoaIZziGr09m/M8c+tH9zisKVaPmyMHmZNUBwIb7UUNUpK8xFPbWkQMDtrD7LjleNp5bb4qUgEwdMw3q2vDbnAi+oviNjcASoPqpPs+uqLhEVaXthn1mTVhgYwgNIgIRWJkfOzLRY6SX9S4VoEvEcVsaEHItyaPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731365194; c=relaxed/simple;
	bh=71nZXfRIrYua2zlXrhTBQOHnk/s6a/TqNaszzlmcZg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWLsjduQALhTJcb83cjOEPfhm8YfwuyCt2cvDbr4pSqN3XQpjFSoFka0oVZ5ZgQFkSslP4JAOv/k7oV+lpqOqb6OXl6n+KYUp05Cmws4pMfFmZQrZ2/Xts8zF4PIA3myHpe/JN5iak6fJOgn3Cy6RF9hhi8LD0HglDssMi+ZUK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=nyIh2cFy; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e30db524c2so3998032a91.1
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 14:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731365192; x=1731969992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VRvtvNdmLIp8XU4kQFCBc6R99fU2D6h//Mc4Pu+ikI=;
        b=nyIh2cFyPK3S1CBucnj8tNIF2tpqToDFcdaOj8JXdN4h0s0crVDw+fAOVZXG7oGdF6
         4kewjbXpSYmX1X1Tr7qiZgCeIOh7UbBszjtZfQFx7xhY8fv3goTBPcLJ7773WZ7eLl1Y
         nLdi5lbmn2tkOCVqtsVjosjZZ574MU+ZZoDjPs/Z261242iYfn9uhzMLyKrb5979ITxi
         MJ2DHtkCYLf7fJWe42OpvkMqLiUyQcRp3R7lrhE/OSweVu7QMctuEzYfOCsLGexqjKzi
         QjgvRrjINqoCV6WP4majjHJN98FihlA4ZwSnTrjqRL+Q3PkkNUDk8uztkUmn7yDSouUs
         d52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731365192; x=1731969992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VRvtvNdmLIp8XU4kQFCBc6R99fU2D6h//Mc4Pu+ikI=;
        b=AF9eDJKTUIMMFBJ24HA/L80OxnwNZh8EQDrzaIXzLmWqdRg6P+AkPahb46d39Dav/E
         Jl3XOa2rgFj9aYGMhafVa4TWcAh2qSgFgF/fxNb8Tqtk8qcmef4v0o4W64ebNCFHYnWf
         gOFE2pcrD2U/GuaHQ35ktzEtZ+0rwGruQNQRfLSJekJsTZ3hr68xMhu2o1MJSzWtiSZq
         NXmYRBbrQdjLZ6kbIAeII6JFwff0pXVUhM7yzYHQOOk82gjdoYATjIyA/cQ3BHwwKBXY
         IvbeuIpRiAZ7hJAhWsvp9LmLwQg0aFWPdnHc3f6Z0TIB9gvCEGCc2QnUZ6SET3CcMXkj
         SSjw==
X-Forwarded-Encrypted: i=1; AJvYcCUm4+3UlWoRf2OQENA3uKuJoM4mzuxq7o6ckPPLngLNC3Pd9knRHW4VuqfpwQfxk6txVMb/hiMwruEZxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDiNZwm013UiVlwFzxEJ62AKxzJTnS0FaB54vBWAGW87PVovrC
	3pRjyoMsNMs8wtAZ96bdrQTh3joMJvdzE951ZyhDJjQCXikm3RnnNeAnMw1ZXNBel6ugrNcIGSb
	0LM2EiGhTN7nf8UVAmK7p2nzZmrVLbTHgeEIzXyNEgr4CI22EJbk=
X-Google-Smtp-Source: AGHT+IHlj8WrQJzuiGSkH3xRWL0oTsnn36a3+WxBSXTkf5/O40cJQXUinPav2r015Kam+qXJ0AB1o31VjfZfu7yIvkU=
X-Received: by 2002:a17:90b:4b84:b0:2cf:c9ab:e747 with SMTP id
 98e67ed59e1d1-2e9b16e26b2mr21506952a91.1.1731365192344; Mon, 11 Nov 2024
 14:46:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731355931.git.josef@toxicpanda.com> <b509ec78c045d67d4d7e31976eba4b708b238b66.1731355931.git.josef@toxicpanda.com>
 <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
In-Reply-To: <CAHk-=wh4BEjbfaO93hiZs3YXoNmV=YkWT4=OOhuxM3vD2S-1iA@mail.gmail.com>
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 11 Nov 2024 17:46:21 -0500
Message-ID: <CAEzrpqdtSAoS+p4i0EzWFr0Nrpw1Q2hphatV7Sk4VM49=L3kGw@mail.gmail.com>
Subject: Re: [PATCH v6 06/17] fsnotify: generate pre-content permission event
 on open
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 4:52=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 11 Nov 2024 at 12:19, Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -3782,7 +3782,15 @@ static int do_open(struct nameidata *nd,
> > +       /*
> > +        * This permission hook is different than fsnotify_open_perm() =
hook.
> > +        * This is a pre-content hook that is called without sb_writers=
 held
> > +        * and after the file was truncated.
> > +        */
> > +       return fsnotify_file_area_perm(file, MAY_OPEN, &file->f_pos, 0)=
;
> >  }
>
> Stop adding sh*t like this to the VFS layer.
>
> Seriously. I spend time and effort looking at profiles, and then
> people who do *not* seem to spend the time and effort just willy nilly
> add fsnotify and security events and show down basic paths.
>
> I'm going to NAK any new fsnotify and permission hooks unless people
> show that they don't add any overhead.
>
> Because I'm really really tired of having to wade through various
> permission hooks in the profiles that I can not fix or optimize,
> because those hoosk have no sane defined semantics, just "let user
> space know".
>
> Yes, right now it's mostly just the security layer. But this really
> looks to me like now fsnotify will be the same kind of pain.
>
> And that location is STUPID. Dammit, it is even *documented* to be
> stupid. It's a "pre-content" hook that happens after the contents have
> already been truncated. WTF? That's no "pre".
>
> I tried to follow the deep chain of inlines to see what actually ends
> up happening, and it looks like if the *whole* filesystem has no
> notify events at all, the fsnotify_sb_has_watchers() check will make
> this mostly go away, except for all the D$ accesses needed just to
> check for it.
>
> But even *one* entirely unrelated event will now force every single
> open to typically call __fsnotify_parent() (or possibly "just"
> fsnotify), because there's no sane "nobody cares about this dentry"
> kind of thing.
>
> So effectively this is a new hook that gets called on every single
> open call that nobody else cares about than you, and that people have
> lived without for three decades.
>
> Stop it, or at least add the code to not do this all completely pointless=
ly.
>
> Because otherwise I will not take this kind of stuff any more. I just
> spent time trying to figure out how to avoid the pointless cache
> misses we did for every path component traversal.
>
> So I *really* don't want to see another pointless stupid fsnotify hook
> in my profiles.

Did you see the patch that added the
fsnotify_file_has_pre_content_watches() thing?  It'll look at the
inode/sb/mnt to see if there are any watches and carry on if there's
nothing.  This will be the cheapest thing open/write/whatever does.
If there's no watches, nothing happens.  I'm not entirely sure what
else you want me to do here, other than not add the feature, which I
suppose is a position to take.

The overhead here is purely for people who use HSM.  I'm telling you
that in production, with real world workloads, the overhead is far
outweighed by having to copy bytes around we'll never use.  Your
argument is similar to the argument against adding compression to
btrfs, "but it costs CPU!?", sure, but the benefit of writing
significantly less waaaaay outweighed the CPU cost and was a huge net
positive.

This is going to cost something if it's on, it costs nothing if it's
off.  If you want performance numbers that's reasonable, I'll run
fsperf tomorrow and get you a side by side comparison.  Thanks,

Josef


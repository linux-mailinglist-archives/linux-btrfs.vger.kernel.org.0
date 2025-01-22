Return-Path: <linux-btrfs+bounces-11039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB5DA191FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 14:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE70164272
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2025 13:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773AC1C3BEA;
	Wed, 22 Jan 2025 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KOGUD11g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A583CC7
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737550975; cv=none; b=EB/yVOPryHg+dNPDrLzcF4zFCpyRes9OtLAw5WxMkxofCD5wBQru65nfxink/GBT/Iwgt4+TvQoobU/t5nYK5VtexpeEVy/Ac8xYvDmev53PGHlLAXHvTNayTGLVn3rmiEQrAqJvadWEXdfgAOqjnh+oHR9caSowBmhxyYL3ly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737550975; c=relaxed/simple;
	bh=HBcYt9TymarM2QkYOD/6to0RFC141xpjXZTpUZ5acvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1+STo9A2CYwSDA74FDh3VlKThriyFJKOfRiHemJRcURurULLZSWHgE3Y1A7bzqcwmyTlLLv3Zk+sBX5a8m/kWPKVi6kjTU8JbE31NaC+zPALO4FAjUVGLNLyKnMU3jRs9RYC0Rj0p7dsV38MaRfLvi+qBLwoc07W4in4ZnSzgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KOGUD11g; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so1168169766b.2
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2025 05:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737550972; x=1738155772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+wALp9gagfw5qCYIzRwvFwJrHdA3ceO62CL2snCjhnM=;
        b=KOGUD11g1GHSaCRICM5tN/GPRs0zRyLWTkESx4Ap7+3oCX8IgeRKGgTdhAOqBFR8o9
         NHrO01UTSa2e+Zguw/TAL5pNmZTFt9fiY6b57b/5CijgEZzmlaRCj7g9PID5Pb0oC8PC
         EVAVc4+6Xfur7hGnQVkEKXh22XeZioHnxJOWjUT08zK6iLzO4Om42Y2j1URhYORA6IK1
         JwA5mYVUOMQUz12NibkFUpElml16aVywsy5tUNGuaaTgsEwEtghxuVW/pBqJsMEDIK3G
         X84YQW2gtNd083fu96FR96fwvqrFcD+j2NwOz6iI9nkolnEoVthGzrzldVoHyieMuPLW
         i8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737550972; x=1738155772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wALp9gagfw5qCYIzRwvFwJrHdA3ceO62CL2snCjhnM=;
        b=JnjfPjripU96x7BKCfuk1jWD2XJhJIS38QHKbAbn+GDowbZ7XDUSPyQbC4ljD+Tv8B
         KVaYClzcHS4CiTtkreoRb41lRv0Ddaf6j5XOlxg+UC5QD+rJ0hZbPNR8T/xsfENgRBUj
         YyetJBqGkpPHNrf+tqv8BPZtVAYAgfKbN+XrH4onnASb0+sQKNjGt3NTDTF7atrHb9eH
         eQh43UxPGBE40IsR/QfXPWzR3km6FD/j8l85R6ykiE2y9g/3WeSMLOr/AnUAHysmqueP
         PcwPryP8k4MMcl+kB1dLYHxzdCcEjj09oIucI14JMPLdZnAe5V8Tw7VSb2T8RLtiRs4H
         gAWA==
X-Gm-Message-State: AOJu0Yz0EOqshGQg2CGZ1xhAfMweF3L7pek9tv9KpM5w4ZI24erIEZnJ
	JqNaDWmSIRrj/oAOwRLvxwjjs4QVyErgB+wsJdCQdcYVHYN+CMV2BuNqVpE3SFy/+8VIvQbcyUy
	l7N6hh9wy0pUe8qhDnl74e4pyZZwuJFHPiC0zWw==
X-Gm-Gg: ASbGncvD6CAz9dqBL7CbuC8yfa2zQkQT9mIH1D5WFpnkLWf+ig0xohJkLgT4s0Y38Mk
	zrMRs3qB3WjjmOSRcpgKlQ1CTnTwn2B+asDN8UxaKfaqbppWxcQ==
X-Google-Smtp-Source: AGHT+IH1xUA8XROfsCbpg7o5eQ0idDX3qkr9IRXvsFFijQwWBMIJpju3QmQZ1czNllpXvT4Y/R6AntF4Fsi9Y+kepyg=
X-Received: by 2002:a17:907:6d0a:b0:aa6:5eae:7ed6 with SMTP id
 a640c23a62f3a-ab38b0f2a50mr2118794966b.13.1737550971271; Wed, 22 Jan 2025
 05:02:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121183751.201556-1-maharmstone@fb.com> <CAPjX3FccHg8HUduLvOODAdj=SN3sNytOEx4TDhkKSJ+P_OVv7A@mail.gmail.com>
 <080dca03-dd09-488a-b98a-5a107dbb76a7@meta.com>
In-Reply-To: <080dca03-dd09-488a-b98a-5a107dbb76a7@meta.com>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 22 Jan 2025 14:02:40 +0100
X-Gm-Features: AbW1kvapZ4eTHgmnsQ0yHt87HRvtWYE6axfYTELS97jUgegBpBLJr4hkOypWH50
Message-ID: <CAPjX3Fe+LVLn5ghRUNGJt0=_gwjwKM+LT9qt_2S9-0c389kvmQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add io_stats to sysfs for dio fallbacks
To: Mark Harmstone <maharmstone@meta.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Jan 2025 at 12:35, Mark Harmstone <maharmstone@meta.com> wrote:
>
> Thanks Daniel.
>
> On 22/1/25 07:42, Daniel Vacek wrote:
>  > On Tue, 21 Jan 2025 at 19:38, Mark Harmstone <maharmstone@fb.com> wrote:
>  >>
>  >> For O_DIRECT reads and writes, both the buffer address and the file
> offset
>  >> need to be aligned to the block size. Otherwise, btrfs falls back to
>  >> doing buffered I/O, which is probably not what you want. It also creates
>  >> portability issues, as not all filesystems do this.
>  >>
>  >> Add a new sysfs entry io_stats, to record how many times DIO falls back
>  >> to doing buffered I/O. The intention is that once this is recorded, we
>  >> can investigate the programs running on any machine where this isn't 0.
>  >
>  > No one will understand what these stats actually mean unless this is
>  > well documented somewhere.
>  >
>  > And the more so these are not generic stats but btrfs specific.
>
> That's fine, I'll send a patch to Documentation/ch-sysfs.rst in
> btrfs-progs once this is in. That's what we have for commit_stats.
>
>  > So I'm wondering what other filesystems do in such a situation? Fail
>  > with -EINVALID? Or issue a ratelimited WARNING?
>
> O_DIRECT isn't part of POSIX, so there's no standard. Ext4 seems to do
> something similar to btrfs. XFS has xfs_file_dio_write_unaligned(),
> which appears to somehow do unaligned DIO. Bcachefs fails with -EINVAL.
> Nobody issues a warning as far as I can see.

I mean that also can be improved. Or btrfs can just do better than the others.

Maybe a warning is a bit too much in this case, I'm not really sure. I
just offered an idea to consider, coz silently falling back to cached
IO without letting the user know does not seem right.

Well, the question is - If you take it from the app developer point of
view. What's the reason to explicitly ask for DIO in the first place?
Would you like to know (would you care) it falled back to a cached
access because basically a wrong usage? I think that is the important
question here.

Imagine the developer wants to improve the performance so they change
to DIO. But btrfs will never actually end up doing DIO due to the
silent fallback. They benchmark. They get the same results. They
conclude that DIO won't make a difference and it is not worth pursuing
further. Just because not knowing they only missed an offset.

That's actually where we are right now and what you are trying to
improve, right?

What is more likely to be noticed? A warning in the log or some
counter some particular filesystem exposes somewhere no one even knows
exists.

And don't get me wrong, I'm not against the stats. I think both the
stats and the warning can be useful here. The warning can even guide
you to eventually check/monitor the stats.

>  > Logging a warning is a very good starting point for an investigation
>  > of the running program on a machine. Even more, the warning can point
>  > you exactly to the offending task which the stats won't do as they are
>  > anonymous in nature.
>
> But then you get a closed-source program that does unaligned O_DIRECT
> I/O, and now you have dmesg telling you about a problem you can't fix.

That's why I mentioned rate limiting. Actually in this case a
WARN_ONCE may be the best approach. I think that that is the usual
solution in various parts of the kernel. And I think it's always good
to know about a problem, even when you cannot fix it.

If you can't fix that problem the stat counters would be as useful as
the warning, IMO. Just more hidden.
And well, you can always reach out to the vendor of that closed source
app asking to address the issue.

The only problem would be some legacy SW where the original vendor no
longer exists. But in that case you can choose to ignore the warning,
especially if only issued once.

On the other hand, developing a new SW one may not even realize the
DIO is not aligned (by a mistake or by a bug) without getting a
warning. So being a bit more verbose seems really useful to me.

> I believe btrfs' DIO fallback is more or less what Jens' proposed
> RWF_UNCACHED patches allow you to do intentionally, so it's not that
> there's not a legitimate use case for it. It's just that it's nearly
> always a programmer mistake.

Agreed, and that's exactly where I think the warning is the most useful, IMO.
That's also why compilers shout warnings for many common mistakes,
right? Just my 2c.

> Mark
>


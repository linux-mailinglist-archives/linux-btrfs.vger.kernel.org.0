Return-Path: <linux-btrfs+bounces-7931-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CBE974DCB
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 11:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9B61F25978
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 09:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8341714A5;
	Wed, 11 Sep 2024 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcEYrSi/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A649C14A60E
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045285; cv=none; b=szZq1ciEWpHGv+vp3V4aqjFwXKnMbnJvtPQM+A4LlGbI1zUCpPJDM4AVeO8YOMnC0iyw4I/CcsguBpRgk3glsOC3zEY+pMXIBH8C1uTaG13LB+XRSM1+Qn/z04YiIsviaY6RI2KNUJeu06xKGHeYiQ6/Rx3tSGnMOOaKx33osk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045285; c=relaxed/simple;
	bh=mqDmLOo8ijroLQpK6YjKnqn5Zb7Zy39S0D3qCJVgQ+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dt26ZkJB8NU/cgRJNJ0Inw48G3D8W8ni7BY1v+psxhdx8ijiVGozNKMN+FtwjcHksy7ajefaIy6YXOixu3cGL+u+mkkFLJrZdwDABUwhBmb6z/ZJhKqCClqGhviT12N6Qaq5iUw6UJdRfICx+2lefo8PiHjBOOvvXtBcNQ+2czE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcEYrSi/; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a9b72749bcso248575185a.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726045282; x=1726650082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvb+GWc5qIVzyza9/qVIIAYaANt6nrf50wjiyVsber0=;
        b=XcEYrSi/iEMdvZ5TTOf8yFdOyAkytMW2eD4lqAdCW4v4Vt/i3Kddr+dZ0SMXvXOYIz
         51I8D8hRZGHmu8sRcE61CMsPg84Fqfks10TCICuRa+uJICOKGX/PubF/KHfdd5q75EZb
         o/kmbY8S3deh9WerGMsMrX/ScebP3s0eDc9JJ0U5jD5ZVZVjwLB2DneIU2dBc9attLSH
         Cb3toSsS5C7t8gzWakQqeGHIJ56UOl/NuOkwUv9f01CdV/fnyzqZjJSO9/n+6Mcmdl/w
         OIkvB0Yo4zzexHUJGpS8xZ4IeDC8ewoS6g39VJ5oJLQU9byPTnBqRiJDlzHQp5XD/EQG
         BnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726045282; x=1726650082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvb+GWc5qIVzyza9/qVIIAYaANt6nrf50wjiyVsber0=;
        b=WLTVxfyPMfTxxLeKUzuxr0r6+vjMzsibhAqonBJlO3aw07c/na0nMQGN1sVTRNfO6q
         ml5PdWvovbREn/PP19VrziJp4N/gJK/Uiw1VBvyXFeCrqNpc/T2e0HJx7EFbiI8912ZY
         lMyMSpvDOts+y07Ytwb5DYKv3ADO1VJ1LKUYpFdsUTihIBYnjJR5F2M3TjGbKRx1og3O
         i9t0VTHAUvMmct4qKdSF2YoIslo3PyRnkqM3/8tyNk9o6N7c01X8ZLcTcuWYMUZM+BOV
         LtVQMMAOe8EY5c1t1neL4Im6N9t/cvsuu0kH79GucGq0Nc1EBH0T+hSK6ROEsO5o7Bw0
         PSGA==
X-Forwarded-Encrypted: i=1; AJvYcCVJRGxP/FZEydbA2LtlwvmEZB7VYtCEwdd86/EAH19KNnwr3NC478Wnv7Lny4TwbPu6AkIqcztf/YkyCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgbMSMonXqMnAOCpyT4qVkK/2yV9q1HXLmnX1ce4R1Kw0xpUQp
	TDPe229u+kELf5z0Qul7AS7Ot7uF03SNdzZilh2R8ywzRuNSFDTqECydoNatfqBbT97rfwYuLy0
	MW0SCidjlFMwvMPJOqTUTJlMcMa8=
X-Google-Smtp-Source: AGHT+IHo/4YiNTxN7/NJXIHmIkt2LOeszevekz1rAfc0+UzHrqmj8EkCgEZa8m9g/aPbleEC0bOpFt38+hLUp1Ycj84=
X-Received: by 2002:a05:620a:4442:b0:79f:433:6e7f with SMTP id
 af79cd13be357-7a997333c51mr2267545885a.21.1726045282377; Wed, 11 Sep 2024
 02:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAYHqBbrrgmh6UmW3ANbysJX9qG9Pbg3ZwnKsV=5mOpv_qix_Q@mail.gmail.com>
 <89131a4f-5362-4002-9a55-d1a24428ef05@gmx.com> <CAAYHqBZ+-3GbDmQFGxMcYs3HpO-DUQA4pCG0xqWMZW+sbw-KJg@mail.gmail.com>
 <331b4034-7a6c-4fa8-a10d-6fa87b801d21@gmx.com> <CAAYHqBaEEq8_AWKtMv9RtH4ZNtTEheCjAZzBstkrECt775UzJA@mail.gmail.com>
 <72315446-3ad4-40d1-8cff-1ec25ae207bd@gmx.com> <CAAYHqBYKQVNOyNbVBw=Xg2K2rXK0KTT7XDx3Ayn=SbNHtf53Lw@mail.gmail.com>
 <d0a1012f-7485-4e34-9f6a-b03a1164f53f@suse.com>
In-Reply-To: <d0a1012f-7485-4e34-9f6a-b03a1164f53f@suse.com>
From: Neil Parton <njparton@gmail.com>
Date: Wed, 11 Sep 2024 10:01:11 +0100
Message-ID: <CAAYHqBbcDEuHQgG_iim84otLk-h9TioqNeT1BdiRSvEuwDJaZQ@mail.gmail.com>
Subject: Re: Tree corruption
To: Qu Wenruo <wqu@suse.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Many thanks Qu, I appear to be back up and running but I also had to
run 'btrfs rescue zero-log' to get rid of a superblock error.
super-recover said the superblock was fine.

On reboot and remount (as normal) I have a couple of residual transid
errors and I'm currently running a full scrub to try and clean things
up.

Hopefully though I'm back up and running, this is the longest the FS
has been mounted in 48 hours without it reverting to ro!

Can't thank you enough for your help. I hope I'm not premature in
thanking you / will report back with any more errors.

Regards

Neil

On Wed, 11 Sept 2024 at 09:55, Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2024/9/11 17:43, Neil Parton =E5=86=99=E9=81=93:
> > Is it safe to run 'btrfs rescue clear-ino-cache' on all 4 drives in
> > the array?
>
> Run it on any device of the fs.
>
> Most "btrfs rescue" sub-commands applies to a fs, not a device.
>
> And you must run the command with the fs unmounted.
>
> >  Reason I ask is when this first occurred it was one
> > particular drive reporting errors and now after switching out cables
> > and to a different hard drive controller it's a different drive
> > reporting errors.
> >
> > It's also worth noting that this array was originally created on a
> > Debian system some 6-8 years ago and I've gradually upgraded the
> > drives over time to increase capacity, I'm up to drive ID 16 now to
> > give you an idea.  Does that mean there are other gremlins potentially
> > lurking behind the scenes?
>
> Nope, this is really limited to that inode_cache mount option.
> I guess you mounted it once with inode_cache, but kernel never cleans
> that up, and until that feature is fully deprecated, and newer
> tree-checker consider it invalid, and trigger the problem.
>
> Thanks,
> Qu
>
> >
> > On Wed, 11 Sept 2024 at 09:04, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/9/11 17:24, Neil Parton =E5=86=99=E9=81=93:
> >>> btrfs check --readonly /dev/sda gives the following, I will run a
> >>> lowmem command next and report back once finished (takes a while)
> >>>
> >>> Opening filesystem to check...
> >>> Checking filesystem on /dev/sda
> >>> UUID: 75c9efec-6867-4c02-be5c-8d106b352286
> >>> [1/7] checking root items
> >>> [2/7] checking extents
> >>> [3/7] checking free space tree
> >>> [4/7] checking fs roots
> >>> [5/7] checking only csums items (without verifying data)
> >>> [6/7] checking root refs
> >>> [7/7] checking quota groups skipped (not enabled on this FS)
> >>> found 24251238731776 bytes used, no error found
> >>> total csum bytes: 23630850888
> >>> total tree bytes: 25387204608
> >>> total fs tree bytes: 586088448
> >>> total extent tree bytes: 446742528
> >>> btree space waste bytes: 751229234
> >>> file data blocks allocated: 132265579855872
> >>>    referenced 23958365622272
> >>>
> >>> When the error first occurred I didn't manage to capture what was in
> >>> dmesg, but far more info seemed to be printed to the screen when I
> >>> check on subsequent tries, I have some photos of these messages but n=
o
> >>> text output, but can try again with some mount commands after the
> >>> check has completed.
> >>>
> >>> dump as requested:
> >>>
> >> [...]
> >>>                   refs 1 gen 12567531 flags DATA
> >>>                   (178 0x674d52ffce820576) extent data backref root 2=
543
> >>> objectid 18446744073709551604 offset 0 count 1
> >>
> >> This is the cause of the tree-checker.
> >>
> >> The objectid is -12, used to be the FREE_INO_OBJECTID for inode cache.
> >>
> >> Unfortunately that feature is no longer supported, thus being rejected=
.
> >>
> >> I'm very surprised that someone has even used that feature.
> >>
> >> For now, it can be cleared by the following command:
> >>
> >>    # btrfs rescue clear-ino-cache /dev/sda
> >>
> >> Then kernel will no longer rejects it anymore.
> >>
> >> Thanks,
> >> Qu
> >


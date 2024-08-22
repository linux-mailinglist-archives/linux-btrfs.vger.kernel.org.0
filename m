Return-Path: <linux-btrfs+bounces-7406-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CC895B49B
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 14:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C27428479A
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2024 12:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6F81CB30F;
	Thu, 22 Aug 2024 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hu1cU+R/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3123E1C945E
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328316; cv=none; b=l5Xk8HZLRIgOMstNrh8H8my4nJ/QBq2WyROwqR2nQ6JOI3ygIiFv/l/oF44km+EcoEkAEhs6TXPGKaKkGvnvxZaPzO2npM+U/+CYiAYLhaqJcj+tq8KDEaVTF0luUItebjWyn3gnycB1tWKaZ0ZAnZ3OcvpxGn2kN7GcIysTZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328316; c=relaxed/simple;
	bh=vM6U0rJDH4rjPQJJR+eQnZ7rv7gCwT6oqq+gfOZp6oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRzaT+xXgN4eDYvyKV+x8eR7cAX4WfRfyL9CeecbS9Pt4jpDZFANbDkzsjlBFoYnPUkwH/4gm8R+rTqCa8fqgK8WXS3MVkuxTmN00COmRU9syCoPyuUSja9eWd8BiDTdUeHJh7FTi3MwosLo5URUqSJ+iEu7JxRE3xiNIRXD0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hu1cU+R/; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f3eabcd293so8317001fa.2
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2024 05:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724328313; x=1724933113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4lCpLojUke7FEPUwNdQISWPctpZ2wTINURDxZuAKRxw=;
        b=hu1cU+R/zBRXWPWHX7g14j+GcoCHd8giPeh1zzlVP3fQ+GbRzFKZ2aztWWr3WhLCkH
         JEj9TJLoeGnTtdsAA+nMXiaUtlIZy5IPC98SRJucdLNblU3SkAPkrP/yrg8CjAqliYbG
         N1tcAN9xr4GbFhjBVTtAzNSOGN21nKcPvzxCumgwwyIP8DnrWjJQaC539vnPatAbzeKN
         UNX11ysHOTEnqLKohtatl5M/7peZUDRI/a/GRgzeRlHgzRIeUDPk2sBDkHie0atY6F76
         i/SLaPAOBYcSm1vf2xutUxvrYfYv3tYxF5Vc0z3iYSs8SeBmhd72cvTdtHHwVJRHqmSg
         zq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724328313; x=1724933113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4lCpLojUke7FEPUwNdQISWPctpZ2wTINURDxZuAKRxw=;
        b=tiw7XHMaKJBtlYyhpEkpyr/4Xs26KZUwTKRk46/5ugpCC+sVOXYevaCQfoMB+0TMok
         mG0DVGfgeafAu8pecJj5iO3vavUqwLjJvZ+1LtXgq9VliWn1mpTAlJ5M8IAksOPWgtOX
         fdRgeRj14bP3M4IdgUoee4MbnRHbhFVIPiCw+wGWdPgaQjZdYTCjsEa148XLrBZs7q+I
         JMdLeRcp0pCZh1DZOhdVu9b/Gty92akFDkl7JVh6+0oft71n1DWHyEJplfXpuPONA5rf
         u59c4rmeJjxcAYWzoE3znWB314j4wfgCVUW4udnZ7aoKd4PJvMUkaxIHC7rmfQW3DJkT
         e5OA==
X-Forwarded-Encrypted: i=1; AJvYcCU7nPiqtZtlYBWhEKJU5K9lfhP1KgUTv86O/yojoTyt5GsdkQLYEdZD6Hxse7pCGMdemzJOqYaPc8c65A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyuQIyuEsjUgIsDg4oqcFzmhQfDwf8T8gvYLWa/wuF9W+xMJzfb
	7dgoGd+3P038vURMCh9ZjiTmhWo0kAZJBvSKbldSwQEP6vdo//AiUzbzJ9+94S0/pAeEaSUOMKz
	v3VszMH8vzvu8txsXknBBe9rJmYYx7dNULkhZ
X-Google-Smtp-Source: AGHT+IH6UsAJx60iCvxYEtAXlTkGKbfp3YurfUm/TwGKREsByVVpJ6KiMOxfvCANpcUSmKsh3f0TBmveTSSoxR2wn8Y=
X-Received: by 2002:a2e:b8c5:0:b0:2f3:e2f0:f79 with SMTP id
 38308e7fff4ca-2f405ee18e7mr11060721fa.38.1724328312961; Thu, 22 Aug 2024
 05:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000008f55e4062036c827@google.com> <20240821201338.GA2109582@perftesting>
In-Reply-To: <20240821201338.GA2109582@perftesting>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Thu, 22 Aug 2024 14:05:01 +0200
Message-ID: <CACT4Y+aSV8ZptNaLqVg+QgOyDn+tJ1WUyBxQ-9hk7joqbmT6GA@mail.gmail.com>
Subject: Re: [syzbot] [btrfs?] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (6)
To: Josef Bacik <josef@toxicpanda.com>, syzkaller <syzkaller@googlegroups.com>
Cc: syzbot <syzbot+dfb6eff2a68b42d557d3@syzkaller.appspotmail.com>, clm@fb.com, 
	dsterba@suse.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 10:57, Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Wed, Aug 21, 2024 at 12:45:25PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    5c43d43bad35 Merge branches 'for-next/acpi', 'for-next/mis..
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13471a05980000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c91f83ae59feaa1f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=dfb6eff2a68b42d557d3
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > userspace arch: arm64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10efded5980000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e94093980000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/cc2dd4be620e/disk-5c43d43b.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/81d40d99ddbf/vmlinux-5c43d43b.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/bc6aed0f2bc5/Image-5c43d43b.gz.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/d55321fffedc/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+dfb6eff2a68b42d557d3@syzkaller.appspotmail.com
> >
> > BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
>
> Can we disable syzbot issues for this specific error?  Btrfs uses lockdep
> annotations for our tree locks, so we _easily_ cross this threshold on the
> default configuration.  Our CI config requires the following settings to get
> lockdep to work longer than two or three tests
>
> CONFIG_LOCKDEP_BITS=20
> CONFIG_LOCKDEP_CHAINS_BITS=20
> CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
>
> but there's no way to require that in our config (nor do I think we should
> really be able to tbqh).  It makes more sense for syzbot to just ignore this
> particular error as it's not actually a bug.  Thanks,

Hi Josef,

We could bump these values, the last 3 are already this or higher on syzbot.
Do you know if increasing CONFIG_LOCKDEP_BITS and
CONFIG_LOCKDEP_CHAINS_BITS significantly increases memory usage?

Ignoring random bugs on unknown heuristics is really not scalable.
Consider: there are hundreds of kernel subsystems, if each of them
declares a random subset of bugs as not bugs. What's the maintenance
story here? And it's not syzbot specific, any automated and manual
testing will have the same problem.
The only scalable way to mark false reports is to not produce them.


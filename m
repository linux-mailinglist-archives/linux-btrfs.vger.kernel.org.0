Return-Path: <linux-btrfs+bounces-3360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A94487ED7F
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 17:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99CAFB20DC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 16:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EF0535A4;
	Mon, 18 Mar 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6JsZ8oD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442D1E48A
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 16:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779232; cv=none; b=gboBUcPZdEhJCpIFFx45L9EVGurTKenLRGR7rLdr8ZaoZ/Ier7TtwY0UEx6cQFE0tLJvxUa3dG6ORAfuUaIEq2PYQMM8m2pScB4FVvY0pUy7NosfXXfaBsCrFCrbqAajIBIj62I77nKh057Eam/b6YuWroAvZgLLQ3CzjzJTMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779232; c=relaxed/simple;
	bh=BZAtf5JC6l+fIJguKMh6mj4KDGeo9Y+Kfbr53Ux7wIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roN/dFR8nC9nQQeZsBAArAslT3ANJZZ0usN8LXFugjm3FybDse4/yZGezmKSYMRpiOzTeP65EEr2B1pRcFmZ4CxPPtwivnV0T8+nyoakF2FL+DtuNXyvLC7bD0B8DEZCNWk5SHXrTvMBC2NIkFK02ZVEmQ/yau8MIcOATz2Y8X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6JsZ8oD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68155C43390
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710779232;
	bh=BZAtf5JC6l+fIJguKMh6mj4KDGeo9Y+Kfbr53Ux7wIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n6JsZ8oDiRe0eDamvodX3IGbwV9BjwFD47186uZGpCjQuMmrJ/nObJW7VcGQyncHM
	 raZnQyGpfRwU/gTbwM4aRZlLw8671Po/XyyOnFJG5P7388z0/SAY+ratqGw6itVJJn
	 F0GR1Vd6IwrgE2rVl4eaXMS2UOkpAtsYRMnurTKAJM9XBePoGDrX5XKpapoGuJhQej
	 XiJXHSmHvxlaflqtEhWWQPtKTV+6ifYcoo4bBh0P5lKw99FM2nS7sgz2HDQz8Yho2E
	 Ir3WmvwYrVXC8NQvQqUki8PMFlDxL3u7JCsKRVnVZsi0zipXw/WS4nUk0fhOoVN77e
	 WcTYDEVdAphiQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a44f2d894b7so536270866b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 09:27:12 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz2OivbNk+7SoMBxL5GTSuVr0wP6aMM5pM7N22mW1zhQcDn+kz8
	hzlicXduzpUWWNvgOZF117c2VxmaViEHEn3scc06YtdMvEbNbGwhgBC+8tBKcg+VkW+RpuJUS9/
	5hPLBmw6UOZK9gylXnDbOJ1bmDMg=
X-Google-Smtp-Source: AGHT+IEC3hVczzC9P5Yb4B366Q1FbiL2jvAwAePQwJJ6/iLuurX8bnBxUQvlLF0IpUJjmauL4GCd2g6tnsAoEKn2H1g=
X-Received: by 2002:a17:907:7b06:b0:a46:3aa2:d452 with SMTP id
 mn6-20020a1709077b0600b00a463aa2d452mr8560719ejc.64.1710779230884; Mon, 18
 Mar 2024 09:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710409033.git.wqu@suse.com> <6ba44b940e4e3eea573cad667ab8c0b2dd8f2c06.1710409033.git.wqu@suse.com>
 <CAL3q7H7wLB4wp+H-BYv1zi0ReywAJ2aiKf7LWyysb2rH44BZfg@mail.gmail.com> <a645407f-4308-48cf-9c7b-6a2e5fc8501e@suse.com>
In-Reply-To: <a645407f-4308-48cf-9c7b-6a2e5fc8501e@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 18 Mar 2024 16:26:34 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4sBDKqaRO-xA0itaVN=b3ooOMQ7nfP3Ra4hY3er1jyDA@mail.gmail.com>
Message-ID: <CAL3q7H4sBDKqaRO-xA0itaVN=b3ooOMQ7nfP3Ra4hY3er1jyDA@mail.gmail.com>
Subject: Re: [PATCH 6/7] btrfs: scrub: unify and shorten the error message
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 8:56=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> =E5=9C=A8 2024/3/15 04:10, Filipe Manana =E5=86=99=E9=81=93:
> > On Thu, Mar 14, 2024 at 9:51=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> Currently the scrub error report is pretty long:
> >>
> >>   BTRFS error (device dm-2): unable to fixup (regular) error at logica=
l 13647872 on dev /dev/mapper/test-scratch1 physical 13647872
> >>   BTRFS warning (device dm-2): checksum error at logical 13647872 on d=
ev /dev/mapper/test-scratch1, physical 13647872, root 5, inode 257, offset =
16384, length 4096, links 1 (path: file1)
> >>
> >> Since we have so many things to output, it's not a surprise we got lon=
g
> >> error lines.
> >>
> >> To make the lines a little shorter, and make important info more
> >> obvious, change the unify output to something like this:
> >>
> >>   BTRFS error (device dm-2): unable to fixup (regular) error at logica=
l 13647872(1) physical 1(/dev/mapper/test-scratch1)13647872
> >>   BTRFS warning (device dm-2): checksum error at inode 5/257(file1) fi=
leoff 16384, logical 13647872(1) physical 1(/dev/mapper/test-scratch1)13647=
872
> >
> > I find that hard to read because:
> >
> > 1) Please leave spaces before opening parenthesis.
> >     That makes things less cluttered and easier to the eyes, more
> > consistent with what we generally do and it's the formal way to do
> > things in English (see
> > https://www.scribens.com/grammar-rules/typography/spacing.html);
>
> Yep, I can do that, but I also want to keep the involved members
> together thus closer.
>
> Not sure if adding spaces would still keep the close relationships
> between the values.
>
> E.g: inode 5/256 (file1) fileoff 16384, logical 123456 (1) physical 1
> (scratch1) 123456
>
> It makes it a little harder to indicate that "(1)" is related to logical
> address (thus mirror number).
>
> >
> > 2) Instead of "inode 5/257(file1)", something a lot easier to
> > understand like "inode 5 root 257 path \"file1\"", which leaves no
> > margin for doubt about what each number is;
> >
> > 3) Same with "logical 13647872(1)" - what is the 1? That will be the
> > question anyone reading such a log message will likely have.
> >      Something like "logical 13647872 mirror 1" makes it clear;
> >
> > 4) Same with "physical 1(/dev/mapper/test-scratch1)13647872".
> >      Something like "physical 13647872 device ID 1 device path
> > \"/dev/mapper/test-scratch1\"", makes it clear what each number is and
> > easier to read.
>
> I totally understand the original output format is much easier to read
> on its own.
>
> However if we have hundreds lines of similar output, it's a different
> story, a small change in any of the value is much harder to catch, and
> the extra helpful prompt is in fact a burden other than a bless.
>
> (That's why things like spreadsheet is much easier to reader for
> multiple similarly structured data, and in that case it's much better to
> craft a script to convert the lines into a csv)
>
> Unfortunately we don't have the benefit (at least yet) to structure all
> these info into a structured output.
>
>
> But what I'm doing here is to reduce the prompts to minimal (at most 4
> prompts, "inode", "fileoff", "logical", "physical"), so less duplicated
> strings for multiple lines of similar error messages.
>
> The patchset is in the middle ground between fully detailed output (the
> old one, focusing on single line) and the fully script orient output (no
> prompt at all, just all numbers/strings, focusing on CSV like output).
>
>
> Furthermore, I would also argue that, for entry level end users, they
> can still catch the critical info (like file path and device path)
> without much difficult, and those info is enough for them to take action.
> (E.g. deleting the file, or replace the disk)
>
> Yes, they would get confused on the devid or rootid, but that's fine and
> everyone can learn something new.
>
> For experienced users who understand basics of btrfs, or us developers,
> the split in values are already arranged in a way similar sized values
> are never close together (aka, string/large/small value split).

Well, I'm a developer and I can tell you if I ever see such log
messages, I'll have to go to the source code to figure out what each
value is supposed to be.
I'll be able to memorize for some hours or even a few days, but after
that I'll forget again and have to look at the source code again.


>
> Thanks,
> Qu
>
> >
> > Thanks.
> >


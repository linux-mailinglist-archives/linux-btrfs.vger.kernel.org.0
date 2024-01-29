Return-Path: <linux-btrfs+bounces-1920-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CF4841444
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 21:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36A7BB244D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 20:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4302613E204;
	Mon, 29 Jan 2024 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmltVKUW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3EE6F08E
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560144; cv=none; b=hHS2oWaEs5HUN8vR3hnLiQFyz5j3gKt/rGvaNkYIu/zaLJEaGzKRgpK5RnWxTC5NPylMLZQfh2YnVZqz9nDHAz4rl2KJ9OikJARe8+GceDMaVtzHGeWiF5dkyr2vCLxXqQzh3h26JOU3Vjv1sh/FDPpP0+fdhQMOJ6ONkLKfUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560144; c=relaxed/simple;
	bh=8xLJjulIxdkRVlS3sGcxiM36gv+9ZiuQcJmm5BO3hiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkiLJqWlwpVzWEbxqjhiJjviZ/wtdlqZmnPWraPsxgpq/lOGoch5P5qstgqwYAtkfIJyd/fLV2uf12vBmdeES+InCDOH3s4Rj2MKhymHv95ORbOBNkAQ7DIrM977gJY8244Y49rukGCNGHjHqdqkBlNoV8b1lzWItFDS6E6LL3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmltVKUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AF8C43390
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 20:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706560144;
	bh=8xLJjulIxdkRVlS3sGcxiM36gv+9ZiuQcJmm5BO3hiI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nmltVKUWtlDLPMlon0+HEe2zsNY6hUTCpbB9g9QkSIgh2fhZuDG+8bEun7Lhmf9t7
	 krJRLfUvz6CNUil+xq4CXYwzAJpO+Uw8H4b+dYB6IN6x2cZ/byGk3CS3lX/suOhBah
	 1L07507P1srF8DmtD6+ZRMzPv7o0UK+SYFHEU69GIGi9nrbzRDshXoDhU5Nw1ckGL1
	 H+jKyNtCTNb46cliZGw7ohtkt9JB3XEQxy/Q4zCZlKdbRdVgUP9EOMlmzwvUhdiqI8
	 gxVee7xgjEiO/L7X6wzFMZpHZKjqD9is+TUODC/PlgW045OtSm7ISR8Y8fcVEqdlvt
	 4XQHWOcZdfhXA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so600839866b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 12:29:04 -0800 (PST)
X-Gm-Message-State: AOJu0YyZILQHBdU1bb628xC59m7M1rqFuaUPqMfTnzRRFoxNKCnCx8H5
	733milrQU4yCK+C7Z3kt22erYX/glVhoL8STEyy6jT77HoQ4UI8fQtXsIXg9e639lYWe0+RDUBe
	PWUuXsJLeE2u7g1cRgROtIScYpbk=
X-Google-Smtp-Source: AGHT+IFpMSw63hlHg/U+ovDjLoJiBuOYl9NomL8Q0P/vvqGgItq1L+BioovY//yukcAYuxpRXwyM/m950AB/zrUSyks=
X-Received: by 2002:a17:906:d92:b0:a30:d35f:d3a5 with SMTP id
 m18-20020a1709060d9200b00a30d35fd3a5mr7189652eji.21.1706560142593; Mon, 29
 Jan 2024 12:29:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706177914.git.fdmanana@suse.com> <c0649a6d95144ca7040762efe467ac6ee707ac0b.camel@intelfx.name>
 <CAL3q7H6802ayLHUJFztzZAVzBLJAGdFx=6FHNNy87+obZXXZpQ@mail.gmail.com> <2c1c21479e8998953541708648d0c02e21d7fd6e.camel@intelfx.name>
In-Reply-To: <2c1c21479e8998953541708648d0c02e21d7fd6e.camel@intelfx.name>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 29 Jan 2024 20:28:25 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5qeUv9phjDq9=NJsH6i2FscUv48M37YSza-UeEVChoOQ@mail.gmail.com>
Message-ID: <CAL3q7H5qeUv9phjDq9=NJsH6i2FscUv48M37YSza-UeEVChoOQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] btrfs: some fixes around unused block deletion
To: Ivan Shapovalov <intelfx@intelfx.name>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:56=E2=80=AFPM Ivan Shapovalov <intelfx@intelfx.na=
me> wrote:
>
> On 2024-01-29 at 12:49 +0000, Filipe Manana wrote:
> > On Sat, Jan 27, 2024 at 9:39=E2=80=AFPM Ivan Shapovalov
> > <intelfx@intelfx.name> wrote:
> > >
> > > On 2024-01-25 at 10:26 +0000, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > These fix a couple issues regarding block group deletion, either
> > > > deleting
> > > > an unused block group when it shouldn't be deleted due to
> > > > outstanding
> > > > reservations relying on the block group, or unused block groups
> > > > never
> > > > getting deleted since they were created due to pessimistic space
> > > > reservation and ended up never being used. More details on the
> > > > change
> > > > logs of each patch.
> > > >
> > > > Filipe Manana (5):
> > > >   btrfs: add and use helper to check if block group is used
> > > >   btrfs: do not delete unused block group if it may be used soon
> > > >   btrfs: add new unused block groups to the list of unused block
> > > > groups
> > > >   btrfs: document what the spinlock unused_bgs_lock protects
> > > >   btrfs: add comment about list_is_singular() use at
> > > > btrfs_delete_unused_bgs()
> > > >
> > > >  fs/btrfs/block-group.c | 87
> > > > +++++++++++++++++++++++++++++++++++++++++-
> > > >  fs/btrfs/block-group.h |  7 ++++
> > > >  fs/btrfs/fs.h          |  3 ++
> > > >  3 files changed, 95 insertions(+), 2 deletions(-)
> > > >
> > >
> > > Still broken for me, unfortunately.
> >
> > I'm curious about your workload. Is it something like continuous,
> > non-stop deduplication or cloning for example?
> >
> > Did you actually experience -ENOSPC errors?
> >
> > Also, if you unmount and then mount again the fs, any unused block
> > groups should be scheduled for deletion once the cleaner thread runs,
> > at least if there's not a huge workload for a minute or two.
>
> Apologies, I must have clarified the workload.
>
> The easiest way to reproduce the original problem was to run a metadata
> balance, e. g. `btrfs balance start -m /` or
> `for u in {0..75..5}; do btrfs balance start -musage=3D$u /`.
>
> I originally spotted this regression by observing an abnormally low
> metadata space utilization and trying to run the above balance, only to
> discover that it makes overallocation even worse.
>
> So, with the patchset applied, the _metadata balance_ is still broken.
> I cannot say anything about normal usage, but any attempt to balance
> metadata immediately explodes the metadata allocation. I did not
> experience a -ENOSPC per se, but the balance (that I used as a
> reproducer) eventually consumed *all* unallocated space on the volume
> and stopped making progress. Attempting to cancel that balance RO'ed
> the filesystem and I had to reboot.

I tried that but I didn't see any problem.
Here's a sample test script:

https://pastebin.com/raw/vc70BqY5

>
> >
> > On top of this patchset, can you try the following patch?
> >
> > https://pastebin.com/raw/U7b0e03g
> >
> > If that still doesn't help, try the following the following patch on
> > top of this patchset:
> >
> > https://pastebin.com/raw/rKiSmG5w
>
> Should I still try these patches to see if they help with metadata
> balance, or is that a different problem then?

Yes. Please try them, given that I can't reproduce your issue with the bala=
nce.

I could trigger getting 1 or 2 at most unused metadata block groups
after having a bunch of tasks doing metadata operations, and patch 3/5
is to address that case.

So one thing I'm curious about, and I asked before, is that if you
unmount and mount again the fs, after a few minutes (without running
that balance), you should get space reclaimed,
as any empty block groups are scheduled for deletion at mount time,
and the next time the cleaner kthread runs, it deletes them.


>
> Thanks,
> --
> Ivan Shapovalov / intelfx /


Return-Path: <linux-btrfs+bounces-11765-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AE9A43DF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 12:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5E617B9ED
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 11:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB638267B91;
	Tue, 25 Feb 2025 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyNP3xaY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EBA4C80
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483638; cv=none; b=Iow0gTrXc1NWb2Q9bmCHOUcIYnS2qRs/J/l6Y6RKZ3ckMonqQY6BodOH1gLUp0LI5AjxL3M9GvVxkSexyXgt6KjYZ7i0sAX/g05BpPy1HD23drxoKiOQXVPT9EtzGwkQOGW4tqAdwLOtyVS6D6m0Mx6APlGu7Tqw9GWob4LpHkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483638; c=relaxed/simple;
	bh=rIxENfytLKrd2vOMzL34skp/A7jrc0wt74zqCT8vBVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpVr1N/ydQBBxN6hy90zhglovAJEq6RSTO3TKfQNQWfNDx9tgJxFF7+O07jsr0lv5yiSN1nB2RAve7SYUOTYWPmn83CYGB00xJDUOMXnK9qnbxsPqbyfgD64OY5edqSWLJLkKSQNZ7/tfzQVHFvI/jATZwfhNdWKmdft6n2U+Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyNP3xaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7728DC4CEE8
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 11:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740483637;
	bh=rIxENfytLKrd2vOMzL34skp/A7jrc0wt74zqCT8vBVY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WyNP3xaYp88lgUJqg5Rf7SRAxMGv256h1TrSJ+bkP20f4IW8HCQw6XldZfah40eWi
	 IcTjeQkrJIyJTi5JnJGTUIQybaZ81ewxd5vAbWN1ikhgQNOL+mgBspBQqDtUOX4DN5
	 hMYXeHAcli9YhY7Za+Hy/SQF1QxeZUsBU53ig8V1dU/i5pVMMvlkgLB2WS2zOq/OaC
	 aRsF9xj6LPuenhPqpHEx2D72tsLfvi0oMoP8OjjaRUs5MvQc6c5t0bhSoYQ6hZjfdG
	 7dMCUyrnlBgRY1f0iKq0RYZ0Ym8xMAxjSN8C11oqUTc3Lprq5Ltc6R9uuNd2RmoaXU
	 xqoueQ8KQMb3g==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso8850101a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 03:40:37 -0800 (PST)
X-Gm-Message-State: AOJu0Ywmbb5Zb/GQTKKsn+ByXrBPeFuIHkfnws089xHqEZTeVq1JF+6T
	qtFQMpIZEz1Fu8xhNSoc6gtg2x3pWZDSann1T56WRu+vsVeNs8rJr4CBciCPHWncWP9x9GpjMYt
	w/k4IcUwNttHqf+hMbeJH023/0To=
X-Google-Smtp-Source: AGHT+IHjaZzyF+A/ntNAnbHd+TnRybvktyKCfLtzkeaYsDnCfaklbPmSLRCQuJ2Jb2Vdm8zsRvhuSQ7JKauNSdSxWAg=
X-Received: by 2002:a17:907:3f09:b0:ab7:6c4b:796a with SMTP id
 a640c23a62f3a-abc09d33dffmr1722068866b.39.1740483636078; Tue, 25 Feb 2025
 03:40:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740427964.git.fdmanana@suse.com> <CAPjX3Fef=7GQxKc1oke5az043i9oea7ryH5W2hfCrKhtKfWCvQ@mail.gmail.com>
In-Reply-To: <CAPjX3Fef=7GQxKc1oke5az043i9oea7ryH5W2hfCrKhtKfWCvQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Feb 2025 11:39:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5S6A8Ckapb3Wfs4rrNg10XDF-O-GKOc=cQmndbj-uiNA@mail.gmail.com>
X-Gm-Features: AWEUYZmJAHB6u0PIucNyL59mJ0wwGjVwBJiguMGJCR6qNfG2j7bSJirleJQYfYQ
Message-ID: <CAL3q7H5S6A8Ckapb3Wfs4rrNg10XDF-O-GKOc=cQmndbj-uiNA@mail.gmail.com>
Subject: Re: [PATCH 0/3] btrfs: some fixes around automatic block group reclaim
To: Daniel Vacek <neelx@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 11:38=E2=80=AFAM Daniel Vacek <neelx@suse.com> wrot=
e:
>
> On Tue, 25 Feb 2025 at 11:58, <fdmanana@kernel.org> wrote:
> >
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Fix a couple races that should be mostly harmless but trigger KCSAN war=
nings
> > and fix the accounting of reclaimed bytes. More details in the change l=
ogs.
> >
> > Filipe Manana (3):
> >   btrfs: get zone unusable bytes while holding lock at btrfs_reclaim_bg=
s_work()
> >   btrfs: get used bytes while holding lock at btrfs_reclaim_bgs_work()
> >   btrfs: fix reclaimed bytes accounting after automatic block group rec=
laim
>
> I'd say 2 and 3 would better be folded into one patch. The split is a
> bit confusing.

I find it less confusing, because it's 2 different problems being
solved and easier to review and reason about.

>
> >
> >  fs/btrfs/block-group.c | 55 ++++++++++++++++++++++++++++++++----------
> >  1 file changed, 42 insertions(+), 13 deletions(-)
> >
> > --
> > 2.45.2
> >
> >


Return-Path: <linux-btrfs+bounces-5215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C359B8CC7A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 22:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596811F21622
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 20:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEE97E112;
	Wed, 22 May 2024 20:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAZoLcKK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DF528F0
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716409120; cv=none; b=abeyZpNh923KSX3vlbOum1SV7fQ9z0IaYA35bg3dUFwsoDkF/3v8OhG4IxZm5jupIzcbHANFgKdnTCUpVoDiHRO+IG0xe1tA9go1VDuUVe64UHtbTrYgnKGIAMAEa+9y9gHxKI3hzDGXbIMrnm8ZrRG7OSTKjrm0kYPQdVZOMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716409120; c=relaxed/simple;
	bh=8UNzT84aJxi0Hpj+83X2UpAyhDMmuCyUkmDFWQNwzd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxR5mxqhV2xVv3eGSvQpEWMKzfkdwjJC5T0Qsvj7ET4QpLccdMpLAkhug5dO6fyBYt7p8G2RHDzBedI4yExbvbLlYkloTi7mKnF89thCUh+mh+Uu/qJ5TuUkvG5wmE2sZnbPUaTZarGQHUvQMGe3m/1kzcZt9VoyTlBR+4wRJ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAZoLcKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7092BC3277B
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 20:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716409119;
	bh=8UNzT84aJxi0Hpj+83X2UpAyhDMmuCyUkmDFWQNwzd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DAZoLcKKEhut7cqVBN/CWswdJNWiLB5o6rjJCqxBigJ/vdbX2YwFbNhWxKSj9Xp8F
	 S8bC3XRCYWM3BYKhAD2DWHOnPULC/pt0Nd95WLBRVUH0set5ciWcMAMbUkBSGvJMJP
	 NPsYJeRjLWznyM817gh1iUJrxXg52jV4DfRnBBhZVBrLo47wy8cJUX6aSI7E7RJ7QG
	 23PQdxxU22q5bDO5Ma8eHQGEmEhOeqYWebdFyYRo1KVkExKi1FsdBCkAtsNbbDom+J
	 3ef30D5Lbj+u/zATrc+l5XzM/yB4KKUpHjNtz6Ozm3UObGEqaiw2hTJzuABAh3mKSU
	 SuQWU9Dd6+FZw==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so10945754a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 13:18:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YxHCIvfexLAtubMhyFX5jb/IWVbYy6Y5pLfQYJDPxtO0Y3GbzMd
	vxBU29gNjvedttI3TfMoXrEzJs2CbQtLfQtV6jgF1CbMdpf05Iv7BED5O8DMKvG635MRDVBx8T0
	M81jorX0rKN2I5QyppTTF8IryDXw=
X-Google-Smtp-Source: AGHT+IGV57EegwP4E9EPXmJe87uQE+ydHJuFYXcmUj5dA2InCZPn1BTt+mvYaSE5Y+xVO7Cs3efZ4sIafPLorAYFeVI=
X-Received: by 2002:a17:906:ce43:b0:a59:db0f:6be4 with SMTP id
 a640c23a62f3a-a622806b58cmr210589366b.5.1716409118037; Wed, 22 May 2024
 13:18:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b686d5a9dbccf9fbfafc5d805bdf463083c1544c.1716388860.git.fdmanana@suse.com>
 <20240522173345.GA17126@twin.jikos.cz>
In-Reply-To: <20240522173345.GA17126@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 22 May 2024 21:18:01 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5z232ZGrS1CgBDV_umv4zqYNeZwRCYJ4y4Yx+vgmso3A@mail.gmail.com>
Message-ID: <CAL3q7H5z232ZGrS1CgBDV_umv4zqYNeZwRCYJ4y4Yx+vgmso3A@mail.gmail.com>
Subject: Re: [PATCH] btrfs: move fiemap code from extent_io.c to inode.c
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 6:34=E2=80=AFPM David Sterba <dsterba@suse.cz> wrot=
e:
>
> On Wed, May 22, 2024 at 03:43:58PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently the core of the fiemap code lives in extent_io.c, which does
> > not make any sense because it's not related to extent IO at all (and it
> > was not as well before the big rewrite of fiemap I did some time ago).
> >
> > Fiemap is an inode operation and its entry point is defined at inode.c,
> > where it really belongs. So move all the fiemap code from extent_io.c
> > into inode.c. This is a simple move without any other changes, only
> > extent_fiemap() is made static after being moved to inode.c and its
> > prototype declaration removed from extent_io.h.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/extent_io.c | 871 ------------------------------------------
> >  fs/btrfs/extent_io.h |   2 -
> >  fs/btrfs/inode.c     | 872 +++++++++++++++++++++++++++++++++++++++++++
>
> With so much code moved and no dependencies, you could also move it to a
> new file so we don't bloat inode.c.

Sounds good, updated to:

https://lore.kernel.org/linux-btrfs/d7579e89a2926ae126ba42794de3e7c39726f6e=
b.1716408773.git.fdmanana@suse.com/

Thanks.
>


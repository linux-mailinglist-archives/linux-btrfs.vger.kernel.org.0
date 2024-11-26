Return-Path: <linux-btrfs+bounces-9904-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35369D9067
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 03:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8999D169D7C
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Nov 2024 02:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565351F5FA;
	Tue, 26 Nov 2024 02:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN7CrrTv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7050A9454;
	Tue, 26 Nov 2024 02:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732588395; cv=none; b=R6nfDsfJL5oLJBAtp5Hc7x4gu4OQ3B2FloZd5gyIwUn1lunfJIS8lHfi/GQNQV7PC8w3p4NTsGagpQeQGxBhdUQbFChkpCPgm/NDWsnJHsIAhTpShF0h2qTV7FmWW+r6N9pNZXL6QrIDVwMkQpxj/NZdz6nM9gaWcu9mvowR2Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732588395; c=relaxed/simple;
	bh=h2/5GOftG0OYXcw1yjUbii2ie2yHBv7jjaduTgfM7b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l4h1SCRdHY5h1nRlIBlmYAsYrTmJ7HnDeMfpO/QMSH+IuhVF3m22YpE3OnKZ2ONfQ08DEMg+M+OfFnu+BUtxLU+yIqFw1cPzzhTyM9cV1szVA2cXceF9Fix1KMv4tDnJT3E2WHbgKzxJebupQtf4JP7n4ORr+OKnH42bBAfm3rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN7CrrTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C16C4CECE;
	Tue, 26 Nov 2024 02:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732588394;
	bh=h2/5GOftG0OYXcw1yjUbii2ie2yHBv7jjaduTgfM7b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EN7CrrTvxBnDfv5wqp5CB4AuZzxwLQLNOMorJX0Zf20RtNG42ffzUQxrSUZ3KJgbx
	 KS8v5YKPachma08nLJR9dklq5dKgIAP4X58ZvqtWOYfcHUDZimfVD7+H9ehT+5JR7A
	 m5oQOHE0UWmg6jOK1RGbQSm+las/lCf1qmhJAYlD9Byy9oxKkFuM6N77Un3kctN4DD
	 YYn58l4wcG0JoIv95kYRfsiFXq3SjrErEsvuKyeDEZUrAAzYGwC5Xmw3KXv8qEAZNv
	 XrIU6991LSiI0NzGRy8Jwal3aFUvwB4VI1PROlD5XDW2uuBq5zNkaI6pL5mnfErALI
	 Ji6nC6yYVTnew==
Date: Tue, 26 Nov 2024 02:33:13 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Allison Karlitskaya <allison.karlitskaya@redhat.com>
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>, linux-btrfs@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: Re: [PATCH] btrfs: add FS_IOC_READ_VERITY_METADATA ioctl
Message-ID: <20241126023313.GA3095319@google.com>
References: <20241125084111.141386-1-allison.karlitskaya@redhat.com>
 <20241125181117.GB1242949@google.com>
 <CAOYeF9W0BUAkrAf0LTpKiD_Au5W8OUdeBZAdDOYxu=HLbC=jHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOYeF9W0BUAkrAf0LTpKiD_Au5W8OUdeBZAdDOYxu=HLbC=jHQ@mail.gmail.com>

On Mon, Nov 25, 2024 at 09:06:25PM +0100, Allison Karlitskaya wrote:
> hi Eric,
> 
> Thanks for the reply.
> 
> On Mon, 25 Nov 2024 at 19:11, Eric Biggers <ebiggers@kernel.org> wrote:
> > At the time, btrfs did not support fs-verity.
> 
> Oops.  I missed that detail. :)  I wonder why they did the
> implementation without the metadata ioctl, then...
> 
> Would you like me to change the commit message?  (or feel free to do
> it yourself...)

Please go ahead and update it.  Thanks!

BTW, I recommend that this be taken through the btrfs tree.

> > This ioctl isn't too useful, but I suppose adding it to btrfs can't hurt.
> 
> I ran into the missing implementation because I'm trying to use it here:
>   https://github.com/tytso/e2fsprogs/pull/203
> for the ultimate purpose of this:
>   https://github.com/containers/composefs-rs/blob/main/examples/uki/build
> 
> tl;dr: I'm trying to build filesystem images in user-space with
> fs-verity-enabled files inside of them, by copying the metadata up
> from the host filesystem.   I have btrfs on my work machine, so for me
> this ioctl is definitely very useful at the moment. :)

Hmm, interesting.  I guess that makes sense, though this wasn't an anticipated
use case for this ioctl.  Maybe the documentation for
FS_IOC_READ_VERITY_METADATA in Documentation/filesystems/fsverity.rst could use
an update to mention this use case.

> I guess it's not particularly relevant to verity the functioning of
> this API, though.
> 
> In its place, I've included some manual tests for querying the
> merkle_tree (both for a file that gets directly hashed into the
> descriptor, and also for one that requires a tree layer) plus the
> descriptors for those.  I'd really prefer if I didn't have to build
> another kernel: my laptop isn't so beefy and this one already took
> most of my work day...
> 
> Please let me know if you need any extra information.

Thanks for testing it!  It should be enough for now, but in the future for
kernel patches I'm afraid you need to get used to building kernels.

- Eric


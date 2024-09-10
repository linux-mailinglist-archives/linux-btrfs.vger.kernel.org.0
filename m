Return-Path: <linux-btrfs+bounces-7910-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B268973C52
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 17:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E683283BDA
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2024 15:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835E719CCED;
	Tue, 10 Sep 2024 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6urregG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9D6A022
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 15:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982722; cv=none; b=gjDnElY+1wX9u4+tmbB8B7qSqdTwunyqE6Ts69g03cUcCTA/5deaCWD2qkof7OVWJSrlA0wLfRmlgPeFcarMFzrlNUXDoYy87DH+TlPYNNh3TjK35TrRqyB9IaQUDvDtK7cl4Eu80MEiP8199RYXOD0ipo8bzDHA+K88av9fQ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982722; c=relaxed/simple;
	bh=6EwyWnAfEYW65Up4AYjJYg2aX0zcFBcmtCD3O5uuEio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kON2pULzE7pTSphqwbNcVXklJ4OFytvqdccyXMqKNxTO0o99u0Q8Ke7OgcK0FDlld5mTScAAvYzrxxcTRAt3Yzl7X3wSpUxefwqTf2cInzE+1xmpMyd9NrC83iFWudNJfsvCbMVcbZbtz4cwKDh16HFkjNtEorCc0aKd0oHM1uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6urregG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46290C4CEC4
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725982722;
	bh=6EwyWnAfEYW65Up4AYjJYg2aX0zcFBcmtCD3O5uuEio=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e6urregGF0sgcQ7tFqElIAWchtQ8zvsZ8oA7jveDPrslRt63tSYbbINmMonDcTl/8
	 98m4xBMv9c3wAurafqtWowtBcooDZKUcuLG597mAbkEhONiempU7m0v9ibrCLbaHKX
	 3JrTjr3qlSfUkJRp0oFk9yF5VSarX5+HolwEfZ+iLWsM2sS622TqARit1ZmHK+jy5v
	 d8xLOsezyeSPXxCocGKNtURz/Ah+gtN+NTcCFxHCyX1AH0VBG5uGqJ9CTGZ3CKxXDG
	 WRevMCMd448eRnoMwk1NgGx28866Y8eUtGOzdKp9wAlrrbMHDa/hjkpmEwvD4AyrvZ
	 Ha77L23AeP6DA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so466421566b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2024 08:38:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YwShsJ1yFQCTTG038UWEvba2pc/tNviihqc5BEsDZVqgP1mMItB
	/R4Rr06yDYa7LkuRnjptyQd8dY7ManHNVwvVBbKPoCEYsN2RYmzbDPgLS+3Dbtp4ON2JE32fT0q
	W+1YVihT89gkCtcNjoZStRW7x2I0=
X-Google-Smtp-Source: AGHT+IGE1JVOaL+nsTshVbSIdDyNOYRjpk8DyMEuBLcY6Mb58wQEgZ0Tn9rmP+g/d6VMfC3eMmHExe8U5cW/vWzJpDg=
X-Received: by 2002:a17:906:c148:b0:a86:7199:af37 with SMTP id
 a640c23a62f3a-a8ffae1e41cmr115047666b.58.1725982720859; Tue, 10 Sep 2024
 08:38:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a351fd3b0397b6fe8d94f11a6744e1655349d687.1725356877.git.fdmanana@suse.com>
 <20240910153559.GA3943310@perftesting>
In-Reply-To: <20240910153559.GA3943310@perftesting>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 10 Sep 2024 16:38:03 +0100
X-Gmail-Original-Message-ID: <CAL3q7H64rBXf7HNr2TdxYkqDj2A_YT70zXERY3HHmuMh8ixjWg@mail.gmail.com>
Message-ID: <CAL3q7H64rBXf7HNr2TdxYkqDj2A_YT70zXERY3HHmuMh8ixjWg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix race setting file private on concurrent lseek
 using same fd
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 4:36=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Tue, Sep 03, 2024 at 10:55:36AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When doing concurrent lseek(2) system calls against the same file
> > descriptor, using multiple threads belonging to the same process, we ha=
ve
> > a short time window where a race happens and can result in a memory lea=
k.
> >
> > The race happens like this:
> >
> > 1) A program opens a file descriptor for a file and then spawns two
> >    threads (with the pthreads library for example), lets call them
> >    task A and task B;
> >
> > 2) Task A calls lseek with SEEK_DATA or SEEK_HOLE and ends up at
> >    file.c:find_desired_extent() while holding a read lock on the inode;
> >
> > 3) At the start of find_desired_extent(), it extracts the file's
> >    private_data pointer into a local variable named 'private', which ha=
s
> >    a value of NULL;
> >
> > 4) Task B also calls lseek with SEEK_DATA or SEEK_HOLE, locks the inode
> >    in shared mode and enters file.c:find_desired_extent(), where it als=
o
> >    extracts file->private_data into its local variable 'private', which
> >    has a NULL value;
> >
> > 5) Because it saw a NULL file private, task A allocates a private
> >    structure and assigns to the file structure;
> >
> > 6) Task B also saw a NULL file private so it also allocates its own fil=
e
> >    private and then assigns it to the same file structure, since both
> >    tasks are using the same file descriptor.
> >
> >    At this point we leak the private structure allocated by task A.
> >
> > Besides the memory leak, there's also the detail that both tasks end up
> > using the same cached state record in the private structure (struct
> > btrfs_file_private::llseek_cached_state), which can result in a
> > use-after-free problem since one task can free it while the other is
> > still using it (only one task took a reference count on it). Also, shar=
ing
> > the cached state is not a good idea since it could result in incorrect
> > results in the future - right now it should not be a problem because it
> > end ups being used only in extent-io-tree.c:count_range_bits() where we=
 do
> > range validation before using the cached state.
> >
> > Fix this by protecting the private assignment and check of a file while
> > holding the inode's spinlock and keep track of the task that allocated
> > the private, so that it's used only by that task in order to prevent
> > user-after-free issues with the cached state record as well as potentia=
lly
> > using it incorrectly in the future.
> >
> > Fixes: 3c32c7212f16 ("btrfs: use cached state when looking for delalloc=
 ranges with lseek")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> We should maybe re-look at our useage of btrfs_file_private and see if we=
 can
> come up with a better solution for this style of problem.  I think the di=
rectory
> readdir stuff does the same sort of thing and we might end up with a simi=
lar
> issue if we have two tasks using the same fd to do readdir.

For the directory case, it's different because the private is
allocated and set when opening the directory/file, so it's not subject
to the same problem.
I did look at that.

Thanks.

>
> But these are just random other thoughts for future work, for this you ca=
n add
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
>
> Thanks,
>
> Josef


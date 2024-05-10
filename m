Return-Path: <linux-btrfs+bounces-4887-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC5F8C22B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 13:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8871C20CC8
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2024 11:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CD716D326;
	Fri, 10 May 2024 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i697miH4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA8116ABC3
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339129; cv=none; b=nRy0GJi3angvTNAQaD58EbRPKbiR/V92Pl9PSWJX9IxlXa4CUc2BGHeE++4nXunqiPYQmrJi0aiDOAGvpQKZoJ5KDTfUqBu/E1cyWFMEOr3uMMDPnwRzCB2xx9cESI2lemntOKiEzLdfkT/RfO00LTA7vkObrPcd7jAy8t5fgXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339129; c=relaxed/simple;
	bh=WAhMQQFNjoXO2DpEr3I5w54WT+3DTAm60ag380MTot4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iV6+AVKt5/oV/xH5b6C7UV7Ssuhu19x9CcnYi/Lz4WM57GUOcgaihKmIXsCjuVHXJQWQy6BfpYMtAl7s0wK3l5HrdHVxzQZYw8NuZsKrE+vT/Uu1W61YbtCYqoyW5pO+FBwn6TWeXua9ggMxZCCXS8Ctm7xHFYUTnro07hMNJYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i697miH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9254DC2BD11
	for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 11:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715339128;
	bh=WAhMQQFNjoXO2DpEr3I5w54WT+3DTAm60ag380MTot4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i697miH4GN1Wsf6odFSdV9lr7eorInA2yEHDH3M7oBUoamW7Yb5JJsunubm0UDo8l
	 XyHrnNyabSVwpqrARDGz4t3tdXk6J9tZvsO6SYt7qlTKOylHJ+2ohKVM7Cy5YvefXZ
	 L3AWlfkR0AEI9IotMha+aP3gXVzwJO2uUgqFnF/8sKtO94QvmDwppdnqAacYQX8jvF
	 H+BMbq+DzqSjXf9vTlaeilMJfxEgDrGAITYavsauLqxQM9VDeP3f/M1PDbazSIF70T
	 sZVxpL+MQUTlulmdMSQBp+70zfMcL4mr4SJhbHze3mVsIH8YQoFsLfLQCmDIvRcPCb
	 Lbdb6anY7KEcA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a17fcc6bso453900166b.1
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2024 04:05:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YxephCs3pDKCX0QqNSQgazoDRUfm52s0Jv+hYHuqUINaZWIPy1m
	PByiGfBB5ckeckr8Owkqx7odVZnkQvRTDSXzxDpKK23VTtF/flCzPg1esZwc4lxQHf/lTE3YMER
	7RkTVUXFAczm2gHaOlvkR/GgYGMo=
X-Google-Smtp-Source: AGHT+IEaQy1YQLVp7V2dHkGA68/wGyNMBY92H3vgaiDVFNcwI+2yyDzanNEIaVk+1Fq7N0Lb1puJFmTxJdnssL65gM4=
X-Received: by 2002:a17:906:c8c4:b0:a59:cf38:5345 with SMTP id
 a640c23a62f3a-a5a2d5cca4bmr139860966b.42.1715339127208; Fri, 10 May 2024
 04:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715169723.git.fdmanana@suse.com> <20240509175633.GO13977@twin.jikos.cz>
In-Reply-To: <20240509175633.GO13977@twin.jikos.cz>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 10 May 2024 12:04:50 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4EMvqHbYw+FRnM3eKf=AyFx7yNWdfDDw=4638-UTyk7A@mail.gmail.com>
Message-ID: <CAL3q7H4EMvqHbYw+FRnM3eKf=AyFx7yNWdfDDw=4638-UTyk7A@mail.gmail.com>
Subject: Re: [PATCH 0/8] btrfs: inode management and memory consumption improvements
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 6:56=E2=80=AFPM David Sterba <dsterba@suse.cz> wrote=
:
>
> On Wed, May 08, 2024 at 01:17:23PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Some inode related improvements, to use an xarray to track open inodes =
per
> > root instead of a red black tree, reduce lock contention and use less m=
emory
> > per btrfs inode, so now we can fit 4 inodes per 4K page instead of 3.
> > More details in the the change logs.
>
> Outstanding! You managed to reduce the size by 48 bytes, on my config
> from 1080 to 1032. Which unfortunately means it's still 3 inodes in a
> page. The config is maximal regarding the conditional features that
> affect size of struct inode. All of them could be enabled on distro
> kernels (checked on openSUSE):
>
> Ifdefs in include/linux/fs.h struct inode:
>
> #ifdef CONFIG_FS_POSIX_ACL
> #ifdef CONFIG_SECURITY
> #ifdef CONFIG_CGROUP_WRITEBACK
> #ifdef CONFIG_FSNOTIFY
> #ifdef CONFIG_FS_ENCRYPTION
> #ifdef CONFIG_FS_VERITY
>
> There's also #ifdef __NEED_I_SIZE_ORDERED but that's for 32bit only.
>
> This is the pahole diff summary before and after the patchset on
> for-next with my reference release config:
>
>  -       /* size: 1080, cachelines: 17, members: 39 */
>  -       /* sum members: 1075, holes: 2, sum holes: 5 */
>  -       /* forced alignments: 2 */
>  -       /* last cacheline: 56 bytes */
>  +       /* size: 1032, cachelines: 17, members: 36 */
>  +       /* sum members: 1026, holes: 2, sum holes: 6 */
>  +       /* forced alignments: 1 */
>  +       /* last cacheline: 8 bytes */
>
> The sum is still over 1024 so we'll need to find more tricks to reduce
> the space.  There are 2 holes, one is 4 bytes (after i_otime_nsec) so
> there's still some potential.

I'm seeing a reduction down to 1016 bytes because I don't have
CONFIG_FS_ENCRYPTION and CONFIG_FS_VERITY set.
It's a very old kernel config I keep reusing for several years, so
that explains it.


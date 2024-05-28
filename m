Return-Path: <linux-btrfs+bounces-5316-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4420B8D1868
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 12:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 757661C22738
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 May 2024 10:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C17D16B75D;
	Tue, 28 May 2024 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qfi0u7S2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394701667FE
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 10:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891664; cv=none; b=rEXBc89ARoRWFO6ysEBLnU8/oE6wF6QByxX7Ud4Uy6+BdiEpkTA+CyVt6mhs1SFKpSp0K2yvo5cIXNuwoXLg1wOq3ci5Mm4NHIpastgVNvGXrOngThv18/WSy0jYH3/09Qjj0WoiRh+C9e0fliis6aM79lXVhKkZtr0MHUJXtak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891664; c=relaxed/simple;
	bh=+KTCb2Tpb8FHSweb1paslvdxdVziKSXlrqSsHD3TcqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXM7uBJSoNUFuUJB3YExJs0Ow25LKYsbiAus/9Fs51CNJuMFPR6CHgxs3pw/3a3aIe/7JvXqO3/rQUi2zU2ffYtY1ftemTZEGeZHOiNidPbAJhG22OoZbTmkF+QlyXKiJuE97KwS11bcgOVyU+eSc/PzujinOou9dm1iMqLilFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qfi0u7S2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E2CC32781
	for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 10:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716891663;
	bh=+KTCb2Tpb8FHSweb1paslvdxdVziKSXlrqSsHD3TcqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qfi0u7S2BlrKfZf9ayjk7OLCfvHwTI0nossjIwwy8GYeGVhyPz00ttCpGbGTJ3+Ne
	 vwS3Y5fuf1d0b5ii3jHotpyrNm0Mcyun9MbR6THwqUVCuaped+KiY50V3npFDIK3I5
	 Ht1uafOITV81+Hq4jGNNEcipDKaMtCE2BQYZvIoi61h3KqLLTecmozaSVf1G/mq1oG
	 /gITzSc/98Hn3p+vssntiLL6wK3xdyIKvsCT9LyBW68S+qmPBvxpFAUHU8/QtA9OjG
	 p9gw+0Cv2Xo+bK5DP+zA/+eQGfShkvn5Hb+HlONMZDScArIc40Rix00OnNllWJpPb7
	 dz6eWrOt+IP9w==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6265d47c61so68189066b.0
        for <linux-btrfs@vger.kernel.org>; Tue, 28 May 2024 03:21:03 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx7LUdrBdiihNXM5RhJiZkGfdvhGazViLVbJrF/I0VzTBamyTWg
	6bH3UhFRjKg3gXwpg5WLJiXobOy71ZS8QCPcpjTgqQZHeEVNyQC6ESP3TCbcxvzpQ6Jm/m62vQu
	/rr5ihY+ltCzPTuE5oM+Fm0SJt0Y=
X-Google-Smtp-Source: AGHT+IHzRBLgQXCgi2Jbk5rwiH0YT2zdACabxzSUsgQ6SXk3aVtORBNIMnF9ZQatwRKiKEaHT7JNRVI/yNqXAlKFIyI=
X-Received: by 2002:a17:907:928c:b0:a59:fca5:ccaa with SMTP id
 a640c23a62f3a-a62641a3160mr921679266b.13.1716891662338; Tue, 28 May 2024
 03:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716874214.git.wqu@suse.com> <ee22eaba04729cf6452ed1223c5187e617cfa4c1.1716874214.git.wqu@suse.com>
In-Reply-To: <ee22eaba04729cf6452ed1223c5187e617cfa4c1.1716874214.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 28 May 2024 11:20:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6eviZPj0abhL_x+R=7Do23-JbOwJYpzpESacBpf4Z4NQ@mail.gmail.com>
Message-ID: <CAL3q7H6eviZPj0abhL_x+R=7Do23-JbOwJYpzpESacBpf4Z4NQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: cleanup recursive include of the same header
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 6:34=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> We have several headers that are including themselves, triggering clangd
> warnings.
>
> Just remove such unnecessary include.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Maybe add a

Fixes: 602035d7fecf ("btrfs: add forward declarations and headers, part 2")

Not sure how many people are using clangd or if it causes warnings
with other tools.

Anyway:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/btrfs_inode.h | 1 -
>  fs/btrfs/extent_map.h  | 1 -
>  fs/btrfs/fs.h          | 1 -
>  fs/btrfs/locking.h     | 1 -
>  fs/btrfs/lru_cache.h   | 1 -
>  5 files changed, 5 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 97ce56a60672..08828e1ea1f7 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -19,7 +19,6 @@
>  #include <uapi/linux/btrfs_tree.h>
>  #include <trace/events/btrfs.h>
>  #include "block-rsv.h"
> -#include "btrfs_inode.h"
>  #include "extent_map.h"
>  #include "extent_io.h"
>  #include "extent-io-tree.h"
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index 2bcf7149b44c..d3d1e5b7528d 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -9,7 +9,6 @@
>  #include <linux/list.h>
>  #include <linux/refcount.h>
>  #include "misc.h"
> -#include "extent_map.h"
>  #include "compression.h"
>
>  struct btrfs_inode;
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 89f0650631cd..e6b1903f6c32 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -29,7 +29,6 @@
>  #include "extent-io-tree.h"
>  #include "async-thread.h"
>  #include "block-rsv.h"
> -#include "fs.h"
>
>  struct inode;
>  struct super_block;
> diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
> index 1bc8e6738879..3c15c75e0582 100644
> --- a/fs/btrfs/locking.h
> +++ b/fs/btrfs/locking.h
> @@ -11,7 +11,6 @@
>  #include <linux/lockdep.h>
>  #include <linux/percpu_counter.h>
>  #include "extent_io.h"
> -#include "locking.h"
>
>  struct extent_buffer;
>  struct btrfs_path;
> diff --git a/fs/btrfs/lru_cache.h b/fs/btrfs/lru_cache.h
> index e32906ab6faa..07f1bb1c6aa3 100644
> --- a/fs/btrfs/lru_cache.h
> +++ b/fs/btrfs/lru_cache.h
> @@ -6,7 +6,6 @@
>  #include <linux/types.h>
>  #include <linux/maple_tree.h>
>  #include <linux/list.h>
> -#include "lru_cache.h"
>
>  /*
>   * A cache entry. This is meant to be embedded in a structure of a user =
of
> --
> 2.45.1
>
>


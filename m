Return-Path: <linux-btrfs+bounces-11788-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DFDA449F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 19:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79BB1866B86
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C891E19E804;
	Tue, 25 Feb 2025 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GntMDpe6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3511547F8
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507058; cv=none; b=b6EJrbh5RJAsO7wPcNRJS3hm/7IOy0WUNuu37d7UMFpi1e/4p/W1c8eLvVQXyzAFb3pzZuSraam5YsqR81UyDDgili2R9UHyukmo7aEX0Q76v7jwz3TeqouorDJ1/6arRS5iX3wvo32q4qbjf54StFQjes4q0nK5xuLPoIw27OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507058; c=relaxed/simple;
	bh=XgA9a+QVdWC6mLf51VWck3+D8N8e7BP6vIsw97pRGNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxBDT5XeFSi4Jjm4C+QLoJw+Rc9V0+37YPF9kg5+EStRNTYsfUYpjsF9HviQpUknufpyR3W6DQ3LCJ59G5AXbQIujhwgkFQueoDGj/4Kas8Be/rqK9wNnIOUmmx97XwSR6d9CDdZI+wS1lCKhRhcZG6piFhoJrE3cyi6ANM+nkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GntMDpe6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11BDC4CEE2
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 18:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740507057;
	bh=XgA9a+QVdWC6mLf51VWck3+D8N8e7BP6vIsw97pRGNs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GntMDpe6Nv8gOfJxfd9OXgC5vgmBNgYIrFNYqDztc5uDV0dIjtEMF+p9R75fP4V4v
	 GbMR/kBjrwrB6D6N7rzMn4sVf6qljN7RpueZiZrfWDoy8GtLlF+xX9FIqo5yIeChZp
	 S6U+PKfhXOpa0X3oj/rHbfI2wFhS4ZGE3c3iCeUqZ4fX4W6cIi5OseyZDXnkv5qxkL
	 +ntL1ZBDk2Q5FM5n3MIUtAck3ZH0iolyGKsC6w98UGFkqNy0bQLaXHfJh+hhXlhkIa
	 uwnDTNdwc+YlZPC4jt4OY6IJrHtjWVYjK6kM/uxHC0Dxcj35iZuo/sw+WB4IslYJ0u
	 oLl+K0dXwwhHQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abb9709b5b5so1082633266b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 10:10:57 -0800 (PST)
X-Gm-Message-State: AOJu0YyULWFK+ePkcrE6sbXzYNYm4/Q10TzlhJo7h8Gqf1TXRSwv3O5C
	R+hurNcfh19B6XcZZGCEtp2xTlj6rfTJ12He/e+oxjBV2Bayr2Y0S8EdB8+IHb6MoLNa1g5zJdb
	R8ndL3G6wDNwStE5evTJgGMVIu2M=
X-Google-Smtp-Source: AGHT+IFhsVD9E8JLW7tyMNL4oReRQKnUmVEDrqsQ9OqRcIZGVrCmeWAjldqPl1B/ZBdIOVL7PfhRJ/+FoFNVytAl+xU=
X-Received: by 2002:a17:906:328a:b0:abe:c3a8:7aa2 with SMTP id
 a640c23a62f3a-abed106852amr346664066b.46.1740507056359; Tue, 25 Feb 2025
 10:10:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740354271.git.wqu@suse.com> <7d10ddfc206a73909763f8a9addfef1e10e5fccf.1740354271.git.wqu@suse.com>
In-Reply-To: <7d10ddfc206a73909763f8a9addfef1e10e5fccf.1740354271.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Feb 2025 18:10:18 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5sT418ruX-s_V5F=5JiU6TthCq1O4K15Uc28oj0Xpv=Q@mail.gmail.com>
X-Gm-Features: AWEUYZnGz5Yw1hOUKH86wTzfA5cbX7QNovr9fvnxgmOKgD_907uQXAHfpG1DcnA
Message-ID: <CAL3q7H5sT418ruX-s_V5F=5JiU6TthCq1O4K15Uc28oj0Xpv=Q@mail.gmail.com>
Subject: Re: [PATCH 7/7] btrfs: remove the subpage related warning message
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 11:47=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>
> Since the initial enablement of block size < page size support for
> btrfs in v5.15, we have hit several milestones for block size < page
> size (subpage) support:
>
> - RAID56 subpage support
>   In v5.19
>
> - Refactored scrub support to support subpage better
>   In v6.4
>
> - Block perfect (previously requires page aligned ranges) compressed writ=
e
>   In v6.13
>
> - Various error handling fixes involving subpage
>   In v6.14
>
> Finally the only missing feature is the pretty simple and harmless
> inlined data extent creation, just done in previous patches.
>
> Now btrfs has all of its features ready for both regular and subpage
> cases, there is no reason to output a warning about the experimental
> subpage support, and we can finally remove it now.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I don't have a machine to test block size < page size, but I trust you
did all the testing besides being the expert on the code base for the
feature, so:

Acked-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> ---
>  fs/btrfs/disk-io.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a799216aa264..c0b40dedceb5 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3414,11 +3414,6 @@ int __cold open_ctree(struct super_block *sb, stru=
ct btrfs_fs_devices *fs_device
>          */
>         fs_info->max_inline =3D min_t(u64, fs_info->max_inline, fs_info->=
sectorsize);
>
> -       if (sectorsize < PAGE_SIZE)
> -               btrfs_warn(fs_info,
> -               "read-write for sector size %u with page size %lu is expe=
rimental",
> -                          sectorsize, PAGE_SIZE);
> -
>         ret =3D btrfs_init_workqueues(fs_info);
>         if (ret)
>                 goto fail_sb_buffer;
> --
> 2.48.1
>
>


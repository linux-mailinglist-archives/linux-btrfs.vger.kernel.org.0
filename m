Return-Path: <linux-btrfs+bounces-5989-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A9F917F83
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 13:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08072834D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 11:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3F517E448;
	Wed, 26 Jun 2024 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkJF4PnN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970B13AD11
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 11:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400958; cv=none; b=NFCUfeQoVCCr2FekBimRIlT5fIAglwqxlRZ7vePmHIPUd93ubOPx91N+d9BCzsD96933l7qh09dlifR+vz2KTZiD1WCi4wxtv/MfAfLnfVIzcOLXwnXvJ8g+7uaTojtrEYO5KSDWYBKiTklhW+bgXTS3ZrZq1phGgRP+ux8Sh5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400958; c=relaxed/simple;
	bh=br+55de2o9UR9Le/GmFGqVvQxxqHaHMGSTCbgFtT7p8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UklmPdU+E4iQcMRgsPTqNBMwZQNimd8QnJbTXnNjOZIUUbhd1JQEQsci7+2HVxFlou7J8N0ZM7KrRQbYmpol2s7QiD5Okqv/NfezIFtZfJHdvSRNRSyovbdoGGM6OfvqCQKxYMDLbEHP51AHOscJAEwtRpoFCk/KvwVLHxEK7gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkJF4PnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0F6C2BD10
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 11:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719400957;
	bh=br+55de2o9UR9Le/GmFGqVvQxxqHaHMGSTCbgFtT7p8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EkJF4PnNyf2UdI8iTpNyFc8TvoREEWaGyDP7zH0hKOSK20IctTVzVowqBL5ek2mC5
	 Mnz3pJKIcZbIZ2V5QMdRSR3e/Sjd2OUMiyalqWvckQmaO7GcS11Yk2e0XekP8c8un2
	 ClcoDL+rWu140jVUCgD6EP+BZ2GrVR9gMGrOZbVRAsqKqTmYGtk0OWusuq2YWTaKfQ
	 HVOWFelarj8jxjun4qsQFbLscn6O+UMChmw2KByIdOGBy7UP0UhTCJKsPdUKppWB1R
	 hMwWb4zVgxpIVJz31vMY3N1xwL8j7dpsSYalPBrKO24wjQ90aGzbBiIQmG0A6fp4xJ
	 zHI+GTnjemkPg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a724598cfe3so523889966b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 04:22:37 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxb2Ym72NRRu5ZqqLRnXPYPabuENc2KQ66fQKeSDHlBfVn/QzI9
	OXBCN8/hRO0F6fEWwui4pr29OTwb8c/wiCayICfuhpuqvy1khkAceGsB37pQl/xcu3phSrNOtaG
	0IxKhDlLae/mBQ0qnPM7UM95Jw/w=
X-Google-Smtp-Source: AGHT+IG57Iyt8CmDcOuDHdV+8q01m+MRTRs6f8ldsYU5pclyryBR97znYpeCFp3n7NgkJSE0t3u5OLLjGKgZPM8PiFQ=
X-Received: by 2002:a17:907:c085:b0:a72:4676:4f8 with SMTP id
 a640c23a62f3a-a7246760537mr918642566b.62.1719400956049; Wed, 26 Jun 2024
 04:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1719366258.git.wqu@suse.com>
In-Reply-To: <cover.1719366258.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 26 Jun 2024 12:21:59 +0100
X-Gmail-Original-Message-ID: <CAL3q7H77h=2pUTnXa20b3WkoFF6H-K0k==Mhj8nhXm9soBfvkA@mail.gmail.com>
Message-ID: <CAL3q7H77h=2pUTnXa20b3WkoFF6H-K0k==Mhj8nhXm9soBfvkA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] btrfs: detect and fix the ram_bytes mismatch
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 2:48=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [CHANGELOG]
> v2:
> - Add the missing patch fixing ram_bytes
>   Now the 2nd patch would ignore the incorrect value and use a correct
>   one from btrfs_file_extent_item::disk_num_bytes.
>
> - Update the commit messages to fix my usual "would" and other grammar
>   errors
>
> There is a long existing mismatch between ram_bytes and disk_num_bytes
> for regular non-compressed data extents.
>
> It turns out to be caused by truncated ordered extents, which modified
> ram_bytes unnecessarily.
>
> Thankfully this is not going to cause any data corruption or whatever,
> kernel can handle it correctly without any extra problem.
> It's only a small violation on the on-disk format.
>
> This series would fix by:
>
> - Cleanup the @bytenr usage inside btrfs_extent_item_to_extent_map()
> - Override the ram_bytes when reading file extent items from disk
>   So that we always get correct extent maps even if the on-disk one is
>   incorrect.
> - Add an extra check on extent_map members
> - Add the proper fix for the ram_bytes mismatch
> - Add a tree-checker for the ram_bytes mismatch
>   Since we can have on-disk ram_bytes incorrect already, this check is
>   only for DEBUG and ASSERT builds, and it won't report error but only
>   does a kernel warning for us to catch.
>
> Qu Wenruo (5):
>   btrfs: cleanup the bytenr usage inside
>     btrfs_extent_item_to_extent_map()
>   btrfs: ignore incorrect btrfs_file_extent_item::ram_bytes
>   btrfs: make validate_extent_map() to catch ram_bytes mismatch
>   btrfs: fix the ram_bytes assignment for truncated ordered extents
>   btrfs: tree-checker: add extra ram_bytes and disk_num_bytes check
>
>  fs/btrfs/extent_map.c   |  5 +++++
>  fs/btrfs/file-item.c    | 16 +++++++++++-----
>  fs/btrfs/inode.c        |  4 +---
>  fs/btrfs/tree-checker.c | 18 ++++++++++++++++++
>  4 files changed, 35 insertions(+), 8 deletions(-)

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

>
> --
> 2.45.2
>
>


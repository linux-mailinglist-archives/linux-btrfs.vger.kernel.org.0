Return-Path: <linux-btrfs+bounces-6337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7CC92CCCF
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 10:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623A21F21A8B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75DF12C52E;
	Wed, 10 Jul 2024 08:21:42 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDD5126F1A
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jul 2024 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599702; cv=none; b=dWLZfKf/O39wtwTKDtJiSAyPZ8qoCCJ18kUFT6xYPxtXV7XdJ8TLcY71ezOrUTMxiZwuG7/Di6Bo+HOg8wK+7NpoxmSrJGEkgN+vggodcS+VkdZBYAhCiZYHaieM7ac3BJb6XtNukXyMexpDWL00seHXXKpiT75NYnehAKA6ZR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599702; c=relaxed/simple;
	bh=fQn78b7Y5pXiJJo2nhJ0t+svcpU3GcY3feoe7WWM7/g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UHhjUfe5GILd2XS+OqhzkaeL/36I1cfu4ljXbUxHXF0M0tWLYIE3j2rUnEdk7ZNnXBX92W8InxRYl/DK1HO1mTwa5KiWRwGMKlZ+6gg+dkgGBEN0oXy2BIiP+1C5Iy3cO1AVBPQB/SHEqkgaRNoDCo8G06EnqZH3kDh18ri+TUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:2340:18a1:4138:37d2])
	by andre.telenet-ops.be with bizsmtp
	id lkMd2C0024znMfS01kMdmf; Wed, 10 Jul 2024 10:21:37 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sRSa1-001bN0-18;
	Wed, 10 Jul 2024 10:21:37 +0200
Date: Wed, 10 Jul 2024 10:21:37 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Qu Wenruo <wqu@suse.com>
cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] btrfs: introduce new "rescue=ignoresuperflags"
 mount option
In-Reply-To: <6e7b92ebb72f7e6e213f9cb601a3e5d246fdb594.1718338860.git.wqu@suse.com>
Message-ID: <84418761-54c9-9c56-1b17-7beb24db9cc4@linux-m68k.org>
References: <cover.1718338860.git.wqu@suse.com> <6e7b92ebb72f7e6e213f9cb601a3e5d246fdb594.1718338860.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

 	Hi Qu,

On Fri, 14 Jun 2024, Qu Wenruo wrote:
> This new mount option would allow the kernel to skip the super flags
> check, it's mostly to allow the kernel to do a rescue mount of an
> interrupted checksum conversion.
>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks for your patch, which is now commit cbc2bc70b8c22974 ("btrfs:
introduce new "rescue=ignoresuperflags" mount option") in next-20240709.

> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -226,6 +226,7 @@ enum {
> 	BTRFS_MOUNT_NODISCARD			= (1UL << 29),
> 	BTRFS_MOUNT_NOSPACECACHE		= (1UL << 30),
> 	BTRFS_MOUNT_IGNOREMETACSUMS		= (1UL << 31),
> +	BTRFS_MOUNT_IGNORESUPERFLAGS		= (1UL << 32),

"1UL" was changed to "1ULL" while applying, but that is not sufficient,
as all other mount flags handling still operates on "unsigned long",
which is 32-bit ont 32-bit platforms.

Hence noreply@ellerman.id.au reported several build failures on 32-bit
platforms (e.g. m68k[1]):

     fs/btrfs/super.c:666:48: error: conversion from 'enum <anonymous>' to 'long unsigned int' changes value from '4294967296' to '0' [-Werror=overflow]

[1] http://kisskb.ellerman.id.au/kisskb/buildresult/15197832/

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds


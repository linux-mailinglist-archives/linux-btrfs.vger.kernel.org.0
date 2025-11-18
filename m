Return-Path: <linux-btrfs+bounces-19108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E24A6C6A8F6
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 17:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B99C44F7825
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F29535A146;
	Tue, 18 Nov 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ahiS0vIY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D9B30EF74
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482239; cv=none; b=CMtkflR0mc2f+wpXVMOboHrD7yfxtGKps9fVwCDKvT/q7tzqbC4A/1VphESmiZvvPRC0Iq+oYlzt7/MH2A6V5kQJ8oYREu+uxisyFvJ1UUnhIg8q4jsH/eaq/BfoFlbu0XrvfR6Pn9wcP5HvGzpShfAXvxsYC9giY4aqrJZk+oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482239; c=relaxed/simple;
	bh=FmjnboM18uwvpaUTj+hxXjIpCu1EueT8ZIYc5RNaA18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ft9oJY24yVrsiEP4dtTrLdYzfaUuPRrESRKr5PVrYCj2t++I5kYCBZSBwodZ6RXtYEkjcQ+6hDiE9LJqwlgNiaWqTXt5QhQygm+jDl/ryIkyFC0wy80QymTM7kz+JWjL3+BJ2RfQBP6T5rehnl/lAdiOB8a0dztUYLaa1Idtj/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ahiS0vIY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so4097685f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 08:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763482236; x=1764087036; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4bWNd8lWFg11eTr/OuuaA/h3cuYtRQCTgxFKrVzJOYs=;
        b=ahiS0vIYKUHIVkY5UKXDrLd/Ild/3EYYdirKnDPSVdcboJWCGr+IriqWQ9xHL8jihI
         Axeu6TbFxjsbv5Uxdb/SKML/XAUOl1gc6GEY9ct3KdGAIeii0I9ZQKOv7irLNi+DUABr
         3SJp/7xGRl3h9cRPAveBY5SoT9AYswoGAblFqvQliud4MuGTEwftuYX8nZXHgRih0/x+
         4BwOdjhGM2VJpm3cAgH00dux+o2zSD1Kd0a7BsOkDWXoN4707MkU9hnoCYzarWFK1IYW
         efGKlPlw64Z8D4dzyzV74macWRPml/hh6rdpOwzIxVaI6p3e37mUD8zmGGBo1u0V2SYx
         Qnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763482236; x=1764087036;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bWNd8lWFg11eTr/OuuaA/h3cuYtRQCTgxFKrVzJOYs=;
        b=cBGpNbJ7Tzpd4S3u/dLKzbsdPLe4iAxdPx5eW0dHM9a5IOL3+0toJl3qhcanaNUb7k
         Lv/htGw7uB9I2yswva+o8b+ErwgEnxCs+H5X/8m+5lOn+/y1045EQIrOi+n2pItoddqm
         oo08vpHjUkAkYHtYiwBvxhoUr44HTJCnpHtZ7zCw1s/pjyyZTuto1y7I1Av2+Rk3a4JH
         5UhppiNw5P6pxtjOG99vn6g8UKO4oQJYLuSq7UYNORdPmNoTKS2++REd8AwjyLI1zsrf
         WLduH3c/iN6OfKG4c+qY0tlL4RsLI9eRF5s9szBAdicqdKWF2cIWaED2+ec8ewwqviwK
         onvg==
X-Gm-Message-State: AOJu0Yxqo7Dct4IcGiaD+NBIlalcIfFy9i50vrMyMKHUxVQzux4fw0+4
	VRUvw7QYCeZlF0SF75vkyayTN9xPth4UJ7jvNXVrKWyxPxfebKKAGdEzFtyubcVErG19eKTlioH
	iZTsjhHu7fh2LOSuLY9iQMVwTa0ZQHAfciVMYgD2gBw==
X-Gm-Gg: ASbGnct2iaH0p1JAOp8wcoy6mhXFcVRaWiTyqiBm2B8exC7l+Leslvg8fUfWmv5yApb
	KtOzzl9kjAMi/0uwzjdtE5F6tO5y62WQdkJcVcMbKxXbP9W1p43DBpn6qsdxojn9Bd+afRRPHBL
	4yEwJLpVXP6fQ6GTAyGBHJQ8yV37xLemra7yNTkxB4wnbkByJKpi66f9bvSSPSLSGXqveJpWdbs
	u31tZB/FcMIxveeqGMonQFSaps/N5KmtF0OFBPC5+g4JQ460YA3LlYc2qpfGMdQyN+2Dt++KKIn
	NaZVi+crrzAqlcEb65juBzfZBWLTvyRbLUkH1e0lTi+mGOqMhV8WCSv8t+lxUGTJpOI3
X-Google-Smtp-Source: AGHT+IGQzTI8VLnbu09XZnJUhYO5/hCYNBdwuHrP180Y8q2CVRAGZWLBiYs+Km926G2XP4HnDu8pnahIx5jl01OYlQg=
X-Received: by 2002:a05:6000:40c9:b0:42b:47ef:1d53 with SMTP id
 ffacd0b85a97d-42b59349121mr14421296f8f.16.1763482235931; Tue, 18 Nov 2025
 08:10:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118160043.3005684-1-neelx@suse.com>
In-Reply-To: <20251118160043.3005684-1-neelx@suse.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 18 Nov 2025 17:10:24 +0100
X-Gm-Features: AWmQ_bk7XY1nReDHTfD8BwlywqvOgsoedpHDqv-eBbUWEaV2umh9APwaD8qEHI4
Message-ID: <CAPjX3Fe+Bw8-FSZO-vw_7J-u8nC8ZTgvisZC8UieZqSS6o96AQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] btrfs: add fscrypt support, PART 1
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Please, disregard this v7. I misconfigured my email. I'm sorry about the noise.

--nX

On Tue, 18 Nov 2025 at 17:01, Daniel Vacek <neelx@suse.com> wrote:
>
> This is a revive of former work [1] of Omar, Sweet Tea and Josef to bring
> native encryption support to btrfs.
>
> It will come in more parts. The first part this time is splitting the simple
> and isolated stuff out first to reduce the size of the final patchset.
>
> Changes:
>  * v7 - Drop the checksum patch for now. It will make more sense later.
>       - Drop the btrfs/330 fix. It seems no longer needed after the years.
>  * v6 vs v5 [1] is mostly rebase to the latest for-next and cleaning up the
>    conflicts.
>
> The remaining part needs further cleanup and a bit of redesign and it will
> follow later.
>
> [1] https://lore.kernel.org/linux-btrfs/cover.1706116485.git.josef@toxicpanda.com/
>
> Josef Bacik (4):
>   btrfs: add orig_logical to btrfs_bio
>   btrfs: don't rewrite ret from inode_permission
>   btrfs: move inode_to_path higher in backref.c
>   btrfs: don't search back for dir inode item in INO_LOOKUP_USER
>
> Omar Sandoval (1):
>   btrfs: disable various operations on encrypted inodes
>
> Sweet Tea Dorminy (1):
>   btrfs: disable verity on encrypted inodes
>
>  fs/btrfs/backref.c   | 68 +++++++++++++++++++++-----------------------
>  fs/btrfs/bio.c       | 10 +++++++
>  fs/btrfs/bio.h       |  2 ++
>  fs/btrfs/file-item.c |  2 +-
>  fs/btrfs/inode.c     |  4 +++
>  fs/btrfs/ioctl.c     | 27 +++---------------
>  fs/btrfs/reflink.c   |  7 +++++
>  fs/btrfs/verity.c    |  3 ++
>  8 files changed, 63 insertions(+), 60 deletions(-)
>
> --
> 2.51.0
>


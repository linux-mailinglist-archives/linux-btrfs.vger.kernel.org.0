Return-Path: <linux-btrfs+bounces-8278-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ACD987C99
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 03:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F350B23D33
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 01:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860D5524B0;
	Fri, 27 Sep 2024 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGnQZ6sA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D92746D
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 01:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727400834; cv=none; b=UYxsEWZ76qvROXzVxYQ53rNd7zj5gIkKo554Zwmcn9/eSUlq2ZwKJNNIy6SyhljrpFIacOgnoQLOUrxo/phsD4IWb0RfrpaKYoaaPorf/cUY12Cp8eVk0bz1EkvWxf8n/O47Q3LDJcqHRTQf+SyvEivay96wn87E1pGAPsCjONo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727400834; c=relaxed/simple;
	bh=q/A1tQ6cvZrcOuAw2LiwyOB/iFyQoRL3yCqK2gzDuZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/6/snvP3l8IAET7pPpgU/O3ov9qnuMsp9/m6OQrgf/aoNek39gQuGZnvBQAL00uHuBq8c6gLGg97VzIWi95EY443mN9d+dzqeqvDsye6FIp8yM0E5F9vb+8iiJK/Vh2Td4kxqB0p/nIXr1xyKx9jl5gijKc6PI9scDKaufxOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGnQZ6sA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e07d85e956so1483036a91.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 18:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727400832; x=1728005632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g31OAGLwD5KJrq7dS7r6H5iUhX3g/yjd3TgwRzKRCZY=;
        b=BGnQZ6sAChp80eyH+ORDPaCibWLzh8P08qtJMJw1XCcAbJZBgjnjIbHZqxy98D2h1q
         3ytdiMjYFq7JEH3lNcEcEgMB6rTFwmBQC2pfid/TeTiWGBTGYSd9t0YtceM+z3kLr7Cq
         kVgcdliE+qZPBrNfsoucY9N0FDKowO984hquRyb2U96gABq/ydwv/eoxOY7EaXETq8zH
         LJvRdocIjAQIj1HfXdyGh9dhmYr/kar4bBYvui53nLKYwPPS4INx4l4FDdt6cp3Cj647
         bPsanp2POQSJlm2g9wUFNwOpKq6zrSOVlmc2GR1eTbVbDspMHy2sPLEclRRidXTdlDc5
         IUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727400832; x=1728005632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g31OAGLwD5KJrq7dS7r6H5iUhX3g/yjd3TgwRzKRCZY=;
        b=padGQfqK/E3hjiDDs4izA0wPXm1w2rUShTKwE01OGBLb/NrD65fNtfujzCWLbluakP
         d0YFonQpRdniCSUYJAcQwnFD9WmLwJsiMpmS11SASXKRCsAgvCdxaaw3xk+cc3nVGqSb
         Qgrwd/+uQCuot+gMBySOshqpmv6BOyXntFmO5VxZXUm+LMVrr0Wv4XYy9g+egVsoaywK
         TzSUW5Dm1HKaoEBW2HIY8Ya47KevVfWlq8AGWAm1C2O7rIkt3rg6R5n35dezMcG34y/A
         LJ/gUr8MtbUD9jGLbd9598k8crWbyVfzxCprBCapqzwBTZ58ogTQbyPi5OgcRcNZxl36
         Z5tA==
X-Gm-Message-State: AOJu0Yy3sjhMKhnT5pIIdeSxc2VCS1J1TmWfpA+8tJTKFd11l3DBFpq5
	0Fya1g+vOONJdgTiNj3RZVJRUq4zPXDYu3R9CM5uOFQg/l+UT5pfO0lQaFr6PtM6e8mC1mu8Lib
	nsuuiW3gCayxNTL64v/Uz6QtqxmM=
X-Google-Smtp-Source: AGHT+IGgbUSpg524boI6hc+S7J34cMz/YUo5XD4TYLjh6O9BmBomEArlCkefL3nrtZoUCAr+9TCNLzsQjpNhji2G6l4=
X-Received: by 2002:a05:6a21:6b0c:b0:1d3:e39:f69c with SMTP id
 adf61e73a8af0-1d4fa6876f4mr2113089637.15.1727400832300; Thu, 26 Sep 2024
 18:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJhrHS2z+WViO2h=ojYvBPDLsATwLbg+7JaNCyYomv0fUxEpQQ@mail.gmail.com>
 <1171b314-be9d-40cf-b3ab-b68b03a96aa2@gmx.com> <f9062d51-946c-4142-9be1-ea8a2701592a@gmx.com>
 <82386baf-1cff-4590-8c94-7a0ffb76aa07@gmx.com>
In-Reply-To: <82386baf-1cff-4590-8c94-7a0ffb76aa07@gmx.com>
From: Ben Millwood <thebenmachine@gmail.com>
Date: Fri, 27 Sep 2024 02:33:40 +0100
Message-ID: <CAJhrHS2n2Fjn+-5e1ukO2cCdH0etRf8Vh7nm-qPHtRYCzG2png@mail.gmail.com>
Subject: Re: ERROR: failed to clone extents to [...]: Invalid argument
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>
Content-Type: text/plain; charset="UTF-8"

I don't think this sounds right. I didn't manually touch the snapshot
after creation, and it's only two weeks old, so I don't think a kernel
that old can have touched it either.

I'm a bit confused about what you're calling "source snapshot" and
etc, so I'm going to suggest the snapshots be called "old local", "new
local", and "old remote", and we're trying to do btrfs send -p "old
local" "new local" | btrfs receive remote, in order to create "new
remote". The "old" snapshots are the ones with the 16:29 timestamp,
the "new" ones are the ones with the 17:04 timestamp.

There are two paths involved here, the home/ben/... path and the
etc/nixos/... path. In all three existing snapshots, the two files are
the same as each other. In both the local and remote old snapshots,
they are size 5026. In the local new snapshot, they are size 4985,
because of changes to the disk that occurred between the two
snapshots.

On Fri, 27 Sept 2024 at 01:12, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> Then create the file system-packages.nix:
>
>   write
> ./2024-09-12T17:04:17+00:00/etc/nixos/system-packages.nix offset=0 len=4985
>   truncate
> ./2024-09-12T17:04:17+00:00/etc/nixos/system-packages.nix size=4985
>
> Which has 4985 sized, so far so good.

I don't think we're creating the file here: it already exists in both
old local and old remote, with size 5026 in both places. We're just
writing it with new content and then truncating it to the new length.

> Now we do the clone, notice that there is no "mkfile" command, meaning
> there should be an existing file at "system-packages.nix":

Yep, the /home/ben file already exists at this location in old local
and old remote (with size 5026 in both places, like the /etc/nixos
one).

>   clone
> ./2024-09-12T17:04:17+00:00/home/ben/code/nix/noether/etc-nixos/system-packages.nix
> offset=0 len=4985
> from=./2024-09-12T17:04:17+00:00/etc/nixos/system-packages.nix
> clone_offset=0
>
> This clone can only happen if the existing file has the same size 4985,
> or the clone ioctl will fail.

That's odd. Given that the file had size 5026 in old local, I don't
see what operation in the send stream was going to make it the right
length before the clone ran. Indeed, it looks like the dump log has
the immediate *next* line setting the length correctly:

truncate
./2024-09-12T17:04:17+00:00/home/ben/code/nix/noether/etc-nixos/system-packages.nix
size=4985

Following a clone with a truncate seems like an odd thing to do if the
clone already required the length to be correct.

> Then according to your original mail, the original file in source
> subvolume indeed has a different size.
> The source subvolume is "2024-09-12T16:29:16+00:00", but the file has a
> different size:
>
> # stat
> /snap/root/2024-09-12T16\:29\:16+00\:00/home/ben/code/nix/noether/etc-nixos/system-packages.nix
>    File:
> /snap/root/2024-09-12T16:29:16+00:00/home/ben/code/nix/noether/etc-nixos/system-packages.nix
>    Size: 5026          Blocks: 16         IO Block: 4096   regular file
>
> This is the direct cause.
>
> The root cause is, the source subvolume has been modified:
>
>      Name:             2024-09-12T16:29:16+00:00
>      UUID:             cfa79865-0272-3845-b447-4d650c2f6d5a
>      Parent UUID:         3d45fbdc-7e4e-f044-83c3-32ad05b70441
>      Received UUID:         1640ca1d-94ca-f448-a89c-a3d83023744a
>      Creation time:         2024-09-26 14:00:31 +0100
>      Subvolume ID:         5842
>      Generation:         14268      <<<<
>      Gen at creation:     14255     <<<<
>      Parent ID:         5
>      Top level ID:         5
>      Flags:             readonly
>      Send transid:         63051
>      Send time:         2024-09-26 14:00:31 +0100
>      Receive transid:     14261
>      Receive time:         2024-09-26 14:09:52 +0100
>      Snapshot(s):
>      Quota group:        n/a
>
> And I believe the source subvolume has been changed to RW, then
> modified, causing above contents mismatch, failing the receive.

I'm not sure which subvolume you mean by "source subvolume", but the
subvolume you're showing there is what I'm calling the "old remote".
If what I'm saying about the send stream being incorrect is true, I
don't think we can blame the old remote, because the send stream is
only generated from the local snapshots, indeed I generated the dump
you asked for without the external disk even being plugged in.

As for the generation numbers indicating that it is modified, I'm no
expert, but aren't those just the modifications that occur during the
receive that created the subvolume, before it was set RO for the first
time?


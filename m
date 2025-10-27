Return-Path: <linux-btrfs+bounces-18353-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B21B7C0BAE6
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 03:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95090189EF9B
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 02:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C412C235B;
	Mon, 27 Oct 2025 02:17:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from drax.kayaks.hungrycats.org (drax.kayaks.hungrycats.org [174.142.148.226])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E7654652
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 02:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=174.142.148.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761531425; cv=none; b=Uzh1er48ELGFLEHj1aNvVWqd+BKi+6TyjYvq0KWl2GQpZ2TSq9A4dq8GDKWSzN6fjJy4EoZiz2HG+DIxpaGS2hxiFkCXG48NRHOC5rc2hxiGvFbK1KF2Q5gEfMFcqSmU5Ncl01nhcdwqumeOXJX6go5RY9jbQtPYg9NEK2lQOy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761531425; c=relaxed/simple;
	bh=am/x7CTgUwZW7rlbzOK3moZ2VpJ/d9KlQhcBVntXwAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V08r/MAD8iBJt5LdmxuF2eF/KjpxrEAzeNFAc1Lvy2Y9WYnz/h1h3uZniTDp/Xyl5m0+jrPYCFwjpBF+UtS5394/b0oCGnpbX5R7LxQzxlc6Hfc9OwCWz9LkXK6Gnhhm3bYlpmNLBoc+vX4SRsIMWHdyoVAUJS0Euiwy/4Wka6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org; spf=pass smtp.mailfrom=drax.hungrycats.org; arc=none smtp.client-ip=174.142.148.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umail.furryterror.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drax.hungrycats.org
Received: by drax.kayaks.hungrycats.org (Postfix, from userid 1002)
	id 1F3F91668A45; Sun, 26 Oct 2025 22:08:28 -0400 (EDT)
Date: Sun, 26 Oct 2025 22:08:28 -0400
From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To: Sandwich <sandwich@archworks.co>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [btrfs] ENOSPC during convert to RAID6/RAID1C4 -> forced RO
Message-ID: <aP7UHKYfgo_ROu_m@hungrycats.org>
References: <e03530c5-6af9-4f7a-9205-21d41dc092e5@archworks.co>
 <05308285-7660-4d9c-b1d5-0b59cf4f1986@archworks.co>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05308285-7660-4d9c-b1d5-0b59cf4f1986@archworks.co>

On Sun, Oct 26, 2025 at 10:37:02PM +0100, Sandwich wrote:
>  hi,
> 
> i hit an ENOSPC corner case converting a 6-disk btrfs from data=single
> to data=raid6 and metadata/system=raid1c4. after the failure, canceling
> the balance forces the fs read-only. there's plenty of unallocated space
> overall, but metadata reports "full" and delayed refs fail. attempts
> to add another (empty) device also immediately flip the fs to RO and
> the add does not proceed.
> 
> how the filesystem grew:
> i started with two disks, created btrfs (data=single), and filled
> it. i added two more disks and filled it again. after adding the
> final two disks i attempted the conversion to data=raid6 with
> metadata/system=raid1c4—that conversion is what triggered ENOSPC
> and the current RO behavior. when the convert began, usage was about
> 51 TiB used out of ~118 TiB total device size.
> 
> environment during the incident:
> 
> ```
> uname -r: 6.14.11-4-pve
[...]
> ```
> 
> operation that started it:
> 
> ```
> btrfs balance start -v -dconvert=raid6 -mconvert=raid1c4 -sconvert=raid1c4 /mnt/Data --force
> ```
> 
> current state:
> i can mount read-write only with `-o skip_balance`. running
> `btrfs balance cancel` immediately forces RO. mixed profiles remain
> (data=single+raid6, metadata=raid1+raid1c4, system=raid1+raid1c4). i
> tried clearing the free-space cache, afterward the free-space tree
> could not be rebuilt and subsequent operations hit backref errors
> (details below). adding a new device also forces RO and fails.
> 
> FS Info:
> 
> ```
> # btrfs fi usage -T /mnt/Data
> Device size:       118.24TiB
> Device allocated:   53.46TiB
> Device unallocated: 64.78TiB
> Used:               51.29TiB
> Free (estimated):   64.20TiB (min: 18.26TiB)
> Free (statfs, df):  33.20TiB
> Data ratio:          1.04
> Metadata ratio:      2.33
> Multiple profiles:   yes (data, metadata, system)
> ```

You left out the most important part of the `fi usage -T` information:
the table...

> ```
> # btrfs filesystem show /mnt/Data
> Label: 'Data'  uuid: 7aa7fdb3-b3de-421c-bc86-daba55fc46f6
> Total devices 6  FS bytes used 49.07TiB
> devid 1 size 18.19TiB used 16.23TiB path /dev/sdf
> devid 2 size 18.19TiB used 16.23TiB path /dev/sdg
> devid 3 size 16.37TiB used 14.54TiB path /dev/sdc
> devid 4 size 16.37TiB used  4.25TiB path /dev/sdb
> devid 5 size 16.37TiB used  1.10TiB path /dev/sdd
> devid 6 size 16.37TiB used  1.10TiB path /dev/sde
> ```

...but from here we can guess there's between 2 and 14 TiB on each device,
which should more than satisfy the requirements for raid1c4.

So this is _not_ the expected problem in this scenario, where the
filesystem fills up too many of the drives too soon, and legitimately
can't continue balancing.

It looks like an allocator bug.

> full incident kernel log:
> https://pastebin.com/KxP7Xa3g
> 
> i’m looking for a safe recovery path. is there a supported way to
> unwind or complete the in-flight convert first (for example, freeing
> metadata space or running a limited balance), or should i avoid that
> and take a different route? if proceeding is risky, given that there
> are no `Data,single` chunks on `/dev/sdd` and `/dev/sde`, is it safe
> to remove those two devices to free room and try again? if that’s
> reasonable, what exact sequence (device remove/replace vs zeroing;
> mount options) would you recommend to minimize further damage?

The safe recovery path is to get a fix for the allocator bug so that you
can finish the converting balance, either to raid1c4 or any other profile.

This operation (balance) is something you should be able to do with
current usage.  There's no other way to get out of this situation,
but a kernel bug is interfering with the balance.

Removing devices definitely won't help, and may trigger other issues
with raid6.  Don't try that.

You could try an up-to-date 6.6 or 6.12 LTS kernel, in case there's a
regression in newer kernels.  Don't use a kernel older than 6.6 with
raid6.

Mount options 'nossd,skip_balance,nodiscard,noatime' should minimize
the short-term metadata requirements, which might just be enough to
cancel the balance and start a convert in the other direction.

> thanks,
> sandwich
[...]


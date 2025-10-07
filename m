Return-Path: <linux-btrfs+bounces-17492-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 816AFBC0244
	for <lists+linux-btrfs@lfdr.de>; Tue, 07 Oct 2025 06:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 247AB4ED630
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Oct 2025 04:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FB521ADC5;
	Tue,  7 Oct 2025 04:15:13 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCD054652;
	Tue,  7 Oct 2025 04:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759810512; cv=none; b=ORdb1BrwGTW5wyeXkGyhLCFwwnuzq5X4ZIG8dnMFEQ7enYvbmQObbvVNx+KmNHjgFaNzuVi3sw9I/OHTsD+jEqlDsM17x98D7ccbweL+mEm5/fblsVObZhqKXd5zVGX6kjhm5Yl1+asvpxJcAI1fSRNhFolmtGoSm2WH+Vc9SDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759810512; c=relaxed/simple;
	bh=DWmz7biooTWA3u/5kIWTMNDbWMH6nHRoaHJJKMjHrbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/7bqN7mwkUrz5aw0G0vTxSgaq4o7jseEx0Q3P42PBzHDhk34Ko4YJwcHp93yxQ9cWkWDgfUG0b6ErlgqRwG2ZiTLUaM1tQcu+SqBm3Qb93on6Rvr1Uq40bTTMk5qBY4SJ16ZiUTX13X5q3CuALaLjxtQ3VzTIWGnaNsYg84wuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1FB16227AB1; Tue,  7 Oct 2025 06:15:06 +0200 (CEST)
Date: Tue, 7 Oct 2025 06:15:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] generic: basic smoke for filesystems on zoned block
 devices
Message-ID: <20251007041504.GB15727@lst.de>
References: <20251006132455.140149-1-johannes.thumshirn@wdc.com> <20251006132455.140149-3-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006132455.140149-3-johannes.thumshirn@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 06, 2025 at 03:24:55PM +0200, Johannes Thumshirn wrote:
> Add a basic smoke test for filesystems that support running on zoned
> block devices.
> 
> It creates a zloop device with 2 sequential and 62 sequential zones,
> mounts it and then runs fsx on it.

As Carlos pointed out this feels wrong.

> +last_id=$(ls /dev/zloop* 2> /dev/null | grep -E "zloop[0-9]+" | wc -l)
> +ID=$((last_id + 1))
> +
> +mnt="$SCRATCH_MNT/mnt"
> +zloopdir="$SCRATCH_MNT/zloop"
> +
> +zloop_args="add id=$ID,zone_size_mb=256,conv_zones=2,base_dir=$zloopdir"
> +
> +mkdir -p "$zloopdir/$ID"
> +mkdir -p $mnt
> +echo "$zloop_args" > /dev/zloop-control
> +zloop="/dev/zloop$ID"

And while thinking of the arguments in his reply, maybe all the zloop
magic should go into documented helpers, both to explain it and make it
reusable?

Otherwise this looks good to me.



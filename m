Return-Path: <linux-btrfs+bounces-1912-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E85841197
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 19:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A9F11F24842
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jan 2024 18:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0656876022;
	Mon, 29 Jan 2024 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strugglers.net header.i=@strugglers.net header.b="HJMwzdkH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.bitfolk.com (use.bitfolk.com [85.119.80.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0EA3F9CE
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Jan 2024 18:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.119.80.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551375; cv=none; b=IZBCn4oqpL/g9w32hT465I3GIFmoFDPom3sCOrB61fMpNmVqj1vZjiu4xPJgGQJkcn8FzIumeHHWCYFD/UCKXo1vUQ8VuJElB5fh5xqJZo+yFiiJLbd7m6lb7RPEAl6dfhfGlqv85v7FP4urAU+sTYjWFJTl2PqqQaj61B+z1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551375; c=relaxed/simple;
	bh=8k17gADV06ebj9aCxukf5/zCFEK3CUoFxBIE2FbPBXo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhJPI9hor6RfMMjJ57ud8BScKrmq4N3RkneKQjUrmcOAyyaYa0UUIcPg7+3f/VATfMHIDpGICuQqbjxDLQt9CjQVpncJIdWohPoFCEG5HozNl3FjiQ3CnzK/B+NLsQgsEYB3g2OwNGe2Jg4kvlTi80UGzWcsuVVRUl7OefVhO3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strugglers.net; spf=pass smtp.mailfrom=strugglers.net; dkim=pass (2048-bit key) header.d=strugglers.net header.i=@strugglers.net header.b=HJMwzdkH; arc=none smtp.client-ip=85.119.80.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strugglers.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strugglers.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=strugglers.net; s=alpha; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-To;
	bh=YGCqpTHmuMoHwGODuxWwsqhBKVVVuWVto72TkwOv7hM=; b=HJMwzdkHVu4WPVS8fB3U0SDV5A
	o6QJ2xzLEu+gZa7KrqDpf8kmDNZzpaKkIPs6HM8hzK3Uqg3aBBrI3LO4mQU3k8lxuECX9Vo8RgK8T
	8PFf1lNiMT+IfYrEjZmX8mCboymZo1wAWxTPVsN0wdzpRc8kYg49BfAs8A1sgKa72FHoiDpP1CAHb
	YI5GsgVpZgOW7JAHiLYcJAawP1q95EQ3E8Kd1OJXvaPAHAXqjRcI7WhXoBj4YMeHCeFnovXs2lN6t
	RIIy4BO0L2pnykMzSsP+4yLZ15Md8w3bh7eTyGbSrHvkdGAL/ecnkXgX3/U2+ayIwbwtueXgJR1J7
	YNh3bgOw==;
Received: from andy by mail.bitfolk.com with local (Exim 4.94.2)
	(envelope-from <andy@strugglers.net>)
	id 1rUVy7-0007KK-5V
	for linux-btrfs@vger.kernel.org; Mon, 29 Jan 2024 18:02:51 +0000
Date: Mon, 29 Jan 2024 18:02:51 +0000
From: Andy Smith <andy@strugglers.net>
To: linux-btrfs@vger.kernel.org
Subject: Re: One missing device = fs not detected; upgrade things first?
Message-ID: <ZbfoS8C0+WdTBfhl@mail.bitfolk.com>
References: <ZbfkaXaX0Wmef0VW@mail.bitfolk.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbfkaXaX0Wmef0VW@mail.bitfolk.com>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL: http://strugglers.net/wiki/User:Andy
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false

On Mon, Jan 29, 2024 at 05:46:17PM +0000, Andy Smith wrote:
> # btrfs check -p /dev/sde
> Opening filesystem to check...
> Checking filesystem on /dev/sde
> UUID: 472ee2b3-4dc3-4fc1-80bc-5ba967069ceb
> [1/7] checking root items                      (0:07:57 elapsed, 3055030 items checked)
> [2/7] checking extents                         (0:08:54 elapsed, 1334143 items checked)
> failed to load free space cache for block group 15011172843520d, 1 items checked)
> failed to load free space cache for block group 15012246585344
> [lots more of that]
> [3/7] checking free space cache                (0:05:04 elapsed, 4220 items checked)
> [4/7] checking fs roots                        (0:51:38 elapsed, 126792 items checked)
> [5/7] checking csums (without verifying data)  (0:13:45 elapsed, 2123139 items checked)
> 
> (still going)

It just finished. Here was the remaining output:

[5/7] checking csums (without verifying data)  (0:30:31 elapsed, 5327794 items checked)
[6/7] checking root refs                       (0:00:00 elapsed, 18 items checked)
[7/7] checking quota groups skipped (not enabled on this FS)
found 4088505802752 bytes used, no error found
total csum bytes: 3983137248
total tree bytes: 5464555520
total fs tree bytes: 526884864
total extent tree bytes: 364138496
btree space waste bytes: 525763765
file data blocks allocated: 4135503101952
 referenced 4101458530304

I didn't see anything bad except the mass of "failed to load free
space cache for block group …". Is there anything that is safe to
try without newer kernel and btrfs-progs?

Thanks,
Andy


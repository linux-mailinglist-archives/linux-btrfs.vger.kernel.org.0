Return-Path: <linux-btrfs+bounces-10067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C3C9E4D04
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 05:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CF8166696
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 04:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE15F191461;
	Thu,  5 Dec 2024 04:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strugglers.net header.i=@strugglers.net header.b="xwkMF3Nm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.bitfolk.com (use.bitfolk.com [85.119.80.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382ED4C83
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 04:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.119.80.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733372760; cv=none; b=hiovsK11nM2ABD8ATOgSD806WOaB4y2fT54Hl79NV6HcIU7vgf592jmt0UXfWUPy5/zotmwtcfMwo+pRf1omY2k7WNeM/Ffslqgmyra3slaySV3c7R2zF7J7L02ZrG8qEEEXRy9qtMqBjBTqjNmBaBTSaYuJjTmUMJx1//lUPA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733372760; c=relaxed/simple;
	bh=if7wpxXhGf47BaPsouRPgbwxJOTEJ5RhMjmbb6TWlGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXLngQe6daq1ufFH0cHukJxWCnkuwkUBQY3EPPi04VTawHhcFopxZBSrlbAEbydUPL6m8zfv39kBFXSUmZyBrVNVNCUVOe1fSljQCDNlYvWGNATuNCA9CeCL73aUe225WnsFq0YKHZA1maxpy0f/UuHCkig4Fc6AC3/YSYqujUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strugglers.net; spf=pass smtp.mailfrom=strugglers.net; dkim=pass (2048-bit key) header.d=strugglers.net header.i=@strugglers.net header.b=xwkMF3Nm; arc=none smtp.client-ip=85.119.80.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strugglers.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strugglers.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=strugglers.net; s=alpha; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-To;
	bh=p1FBshxNBdL1F7gol0BflFfPCeYac2QJBmg1edksaaw=; b=xwkMF3Nm+G0/lpzW0RAUs831Ty
	lI8mYgNkcAOLdb9wBOgrIxY4ElVuuUrlDssPU6sc967HkKAzrA5FchwvDnSa/yWuyBd+MqEMFdOFt
	CiQ14Bsc+1rv/NDhLjhOt7rJsGlT2zIQW0KqrLkTkbrz2ChHHm+UEOKV4Y3OxYDOJ1gS7sdC9RhaJ
	PX/gHMdcJ/3FX7tn7kCCDzFBAtYRBcktHsgb8wM7268qdujkcB7eCYoaxXCZ9C8bg7gjLWEp0Z1PQ
	XIgtKWVe9sGNQYdPVbffopHLf9zGRK0NPDIC8PsA/QEblJEYYjBwt8TY+tzUFeuqkKuQy2MVfFang
	6gVjiB1w==;
Received: from andy by mail.bitfolk.com with local (Exim 4.94.2)
	(envelope-from <andy@strugglers.net>)
	id 1tJ3R6-0001Vy-62; Thu, 05 Dec 2024 04:25:56 +0000
Date: Thu, 5 Dec 2024 04:25:56 +0000
From: Andy Smith <andy@strugglers.net>
To: Andrei Borzenkov <arvidjaar@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: Copying a btrfs filesystem from one host to another, reflinks,
 compression
Message-ID: <Z1ErVJYZJKMiFJb0@mail.bitfolk.com>
References: <Z1DWkM8wjak50NrG@mail.bitfolk.com>
 <f6470c12-6601-4776-a738-cf073e3bcffa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6470c12-6601-4776-a738-cf073e3bcffa@gmail.com>
OpenPGP: id=BF15490B; url=http://strugglers.net/~andy/pubkey.asc
X-URL: http://strugglers.net/wiki/User:Andy
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: andy@strugglers.net
X-SA-Exim-Scanned: No (on mail.bitfolk.com); SAEximRunCond expanded to false

Hi Andrei,

Thanks for your reply.

On Thu, Dec 05, 2024 at 07:11:59AM +0300, Andrei Borzenkov wrote:
> 05.12.2024 01:24, Andy Smith wrote:
> > rsync or tar | ssh | tar are not going to handle reflinked files,
> > are they?
> > 
> > Should I be using btrfs-send?
> 
> btrfs send/receive has better support for sharing data between files, yes.
> It is not guaranteed, that destination will have exactly the same data
> layout though; btrfs send may decide to send full data instead of sending
> clone request. I am not sure about exact conditions, IIRC one requirement
> for cloning is proper alignment.

Hmm. I don't mind if the destination has a  bit of a different layout
but I would not like if a significant number of the regions on the
source got deduplicated…

I guess I will have to try it and see what happens (time-consuming,
given the size).

If it expands too much I may have to try again with dd.

> > Would that preserve compression or would I have to go through and force
> > recompression of everything?
> > 
> > Source host's kernel is 5.10.0-32; btrfs-progs v5.10.1 (Debian 11).
> > Destination would be Debian 12 so kernel 6.1.0-28 and btrfs-progs v6.2
> > 
> 
> According to man btrfs-send, --compressed-data should preserve compression.

Looks like I would have to install a newer btrfs-progs on the sender as
I read in:

    https://btrfs.readthedocs.io/en/latest/btrfs-send.html

    --proto <N>

    Version 2 requires at least btrfs-progs 6.0 on both the sender and
    receiver and at least Linux 6.0 on the sender.

    --compressed-data

    This requires protocol version 2 or higher. If --proto was not used,
    then --compressed-data implies --proto 2.

Thanks,
Andy


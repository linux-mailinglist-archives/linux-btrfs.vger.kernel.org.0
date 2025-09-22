Return-Path: <linux-btrfs+bounces-17049-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 748B2B8FBD6
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 11:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6133A9794
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 09:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB4C285045;
	Mon, 22 Sep 2025 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="MkaaTAV3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex2.tik.uni-stuttgart.de (mxex2.tik.uni-stuttgart.de [129.69.192.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED781F936
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532987; cv=none; b=F3dTU4QsjFIMx5dyMP4bNDlV6UkMawscfiPFRIA1UTPnFaWv6EGlQJIMM0E9lDDhOS+n0VU2aLjpTQNnNxkm5NsSxBmj+w6py6HcXZTn++grMAtBbzI74dmiK+6D7W37LQ1mnitsBqlhKeKICOgiqr3UOfXN2RVceFtxr+QkJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532987; c=relaxed/simple;
	bh=LpWATPPCmincqD+COSUxjJdQg0Rek5DSTtjrJB5cqjA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AV5nlOZAqg+SrFC76PY7njHHFB1x3o/p9xegMB+vuANIxWHVZE4WFjpImRK1BNedJOKgCMvCgnIKHeJ9PWd8GRqUrYcuBgze230UZyUkDFscXx3+76ixeNvO85mcB3pZJG210JmQ+MuUI6m3IBG6ookmaa6Entsc5WD/EtdujxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=MkaaTAV3; arc=none smtp.client-ip=129.69.192.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTP id 31A186029B
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 11:23:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1758532980; x=1760271781; bh=LpWATPPCmi
	ncqD+COSUxjJdQg0Rek5DSTtjrJB5cqjA=; b=MkaaTAV3/uT3J3tivZMXBKrcuW
	iNRc1Z7CIOooh4wrTZkGyJpyEpFf8nugD8ROzvwGdLKhB6N0mH7vZCocj8tATI42
	bPWwepOurDikgJy0FgQDeuhbTTfXKxRYP+X/CizyQs4bsoBpv6Tn5js8fkPMJB7T
	jflAPPVUwadMVcHQYhs7db3GZfDSenXnv9ZQ6CCrWgwOSwEi5YaAM1ionfJBN0fY
	Wk7Ng7nlX82G0zbI/IYUOsGwE/OLsyqYXAJFs7WKcBVtAYyZgVU1jxmPeSmTNcKv
	zfvyKfgLtfpYuoUul0W0HUl8WNmX1DhAjGMQ9TW+KKBYG+ErGBhlTVu/qfrg==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex2.tik.uni-stuttgart.de
Received: from mxex2.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex2.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id dAtZTnXk-bAW for <linux-btrfs@vger.kernel.org>;
 Mon, 22 Sep 2025 11:23:00 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex2.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Mon, 22 Sep 2025 11:23:00 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
Message-ID: <20250922092300.GA2634184@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
 <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
 <20250922082854.GD2624931@tik.uni-stuttgart.de>
 <95ece5d8-0e5a-4db9-8603-c819980c3a3b@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ece5d8-0e5a-4db9-8603-c819980c3a3b@suse.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Mon 2025-09-22 (18:36), Qu Wenruo wrote:


> Write-hole means during a partial stripe update, a power loss happened,
> the parity may be out-of-sync.
> 
> This means that stripe will not get the full protection of RAID5.
> 
> E.g. after that power loss one device is lost, then btrfs may not be
> able to rebuild the correct data.

It must happens both, power loss and one device is lost?
Then this is a more rare situation: unlikly, but not impossible.


> >> So you either run RAID5 for data only
> >
> > This is a mkfs.btrfs option?
> > Shall I use "mkfs.btrfs -m dup" or "mkfs.btrfs -m raid1"?
> 
> For RAID5, RAID1 is preferred for data.

Then the real usable capacity of this volume is only the half?
With 4 x 4 TB disks I get 2 TB, in opposite to 3 TB with RAID5 data?


> >> and ran full scrub after every unexpected power loss (slow, and no
> >> further writes until scrub is done, which is further maintanance burden).
> >
> > Ubuntu has (like most Linux distributions) systemd.
> > How can I detect a previous power loss and force full scrub on booting?
> 
> Not sure. You may dig into systemd docs to find that out.

So, no recommandition from you. Difficult situation :-}


> >> Or just don't use RAID5 at all.
> >
> > You suggest btrfs RAID0?
> 
> I'd suggest RAID10. But that means you're "wasting" half of your capacity.

Ok, it is a trade off...


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<95ece5d8-0e5a-4db9-8603-c819980c3a3b@suse.com>


Return-Path: <linux-btrfs+bounces-18036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EECBF0173
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 11:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928B7189E75F
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Oct 2025 09:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C6172ED168;
	Mon, 20 Oct 2025 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="aqHGXmND"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078652ECE86
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760951245; cv=none; b=Md0Xl9UMyrN2a2gi+0T6cbgLX3Km1zLCBwySlxz7W6Cso3YYi0U3MHRnbk3oU8cwNqO2phgHCQRKJEevbLyY6UbGD6m8CpY/lBdoM2s+ZDhQyy1d21qga0GixMR381PMJH3nzF4+osGDObHxY6DA2f5sjSlJM0BUePBynQz1TOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760951245; c=relaxed/simple;
	bh=GG+W9pv6EOqicX5kEEPMO7LYfX5TEDr04gY0ErV+4Cc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtTQmYA4gNBj+8H+hOjkj9tdfRQOXIY/OC/I1wA8Q9J6vM3Pwz8kcyK7qoL6lHTMeF6iHYhNaLfvOkdgiWwblmoW55E5Rdyc+AYJgSDIGua5byGovW8Z+8FXNqyKDnSNZGMtbomkuNhKpC89AcpdIdB3KXNzMzTBlLe4G1wRbGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=aqHGXmND; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id 429CB60B6C
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Oct 2025 11:00:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1760950818; x=1762689619; bh=GG+W9pv6EO
	qicX5kEEPMO7LYfX5TEDr04gY0ErV+4Cc=; b=aqHGXmNDCWyH/jRCLKJNHHGwC9
	OetD+C6dixeYEY1n566SEdrZhSnH7bQJBoM3IzjkvI+Aa4zvdxowNrCdAFGI0gHp
	FGCd31zujOOI1SEvAKVKkh+xaVyl2Vg5+M0q/l9K9rQSRdZa2VLDj99Xh7ggK7pp
	z1m8YvRByB2GxbDoArfxmY4j54koFcv1h3fq4S3imnJeIHN35ByqXG3yt6qs+wWF
	LnhDS8gRvTMmU7MUWCYO4v7LLbnxlCtvhTP9nFnPoWtZ8GkzASIcM2qNRO3C+pqr
	IYvJ0R4kfqIze8kJdKVzSFyZZUWUXc7TtZ1hO6FYpSJOXTJyVWlVxCGCV+Dg==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id Y7-x7CZKSZUN for <linux-btrfs@vger.kernel.org>;
 Mon, 20 Oct 2025 11:00:18 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Mon, 20 Oct 2025 11:00:18 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: btrfs RAID5 or btrfs on md RAID5?
Message-ID: <20251020090018.GA1446208@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20250922070956.GA2624931@tik.uni-stuttgart.de>
 <d3a5e463-d00e-4428-ad7b-35f87f9a6550@gmx.com>
 <20250922082854.GD2624931@tik.uni-stuttgart.de>
 <95ece5d8-0e5a-4db9-8603-c819980c3a3b@suse.com>
 <20250922092300.GA2634184@tik.uni-stuttgart.de>
 <1e4baff2-1310-437a-be62-5e9b72784a54@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e4baff2-1310-437a-be62-5e9b72784a54@gmx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729


Resuming this discussion... 

On Mon 2025-09-22 (18:57), Qu Wenruo wrote:

> >>>> So you either run RAID5 for data only
> >>>
> >>> This is a mkfs.btrfs option?
> >>> Shall I use "mkfs.btrfs -m dup" or "mkfs.btrfs -m raid1"?
> >>
> >> For RAID5, RAID1 is preferred for data.
> >
> > Then the real usable capacity of this volume is only the half?
> 
> No, metadata is really a small part of the fs.
> 
> The majority of usable space really depends on the data profile.
> 
> If you use RAID1 metadata + RAID5 data, I believe only less than 10% of
> real space is used on RAID1, the remaining is still RAID5.

Sounds like a good compromise solution!

Asuming I have 4 partitions with equal size, then the suggested command to
create the filesystem would be:

mkfs.btrfs -m raid1 -d raid5 /dev/sda4 /dev/sdb4 /dev/sdc4 /dev/sdd4

Does this setup help to protect against write hole?


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<1e4baff2-1310-437a-be62-5e9b72784a54@gmx.com>


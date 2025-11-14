Return-Path: <linux-btrfs+bounces-19000-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC7DC5EE8E
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 19:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5793B1C06
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Nov 2025 18:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A972D595D;
	Fri, 14 Nov 2025 18:45:51 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBD02DC34E
	for <linux-btrfs@vger.kernel.org>; Fri, 14 Nov 2025 18:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763145951; cv=none; b=nMYzSfFwXuio1vLNt4X08aMt//j3MTyepsDhOtuoAibPkrTIPhOW71jXP+cQKhWnuVHgpuNbY+HfhARsHeN8g70zmE21mW3iTgK4cmsAJrCN/pnDLdOAleBHR+FNSegYvgrT3iDoHQBIby6Hw9EOGzJic+W+PuShvGXeyOeIZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763145951; c=relaxed/simple;
	bh=Cel/OWPTVWkeQoLyA2YaAt4AxfQbMBlSss9jr29kCs0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BKN8747PC6vlfUHpnU7r05Zw4Tpx5mdF/pUC/jGW5b+wc/WQrcUa6n1t1Skd2GziiT10lN8ckHsL1gqdhsknfs3SDvWQdCnC7E+PN6i6jY8BYdGx5XChtnrzARBKV7fWqgoE+EkPMW17hVH/GPqcjYc7I4bZhbB8PuQox93iJX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 2AFC7BD280; Fri, 14 Nov 2025 13:38:05 -0500 (EST)
From: Phillip Susi <phill@thesusis.net>
To: Ross Boylan <rossboylan@stanfordalumni.org>, Boris Burkov
 <boris@bur.io>, linux-btrfs@vger.kernel.org
Subject: Re: btrfs fragmentation
In-Reply-To: <CAK3NTRAhxaHU4Mh3vz9VWnonDS7dFjVvC0fnYhz0kH5Lrqorfg@mail.gmail.com>
References: <CAK3NTRCBV0jTPrHb_tmWzdrLqx9xnvKpcqA7-_Cxm9TfJAGGSQ@mail.gmail.com>
 <20251028001329.GA3148826@zen.localdomain>
 <CAK3NTRAhxaHU4Mh3vz9VWnonDS7dFjVvC0fnYhz0kH5Lrqorfg@mail.gmail.com>
Date: Fri, 14 Nov 2025 13:38:05 -0500
Message-ID: <875xbc5uk2.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ross Boylan <rossboylan@stanfordalumni.org> writes:

> I tried the following:
> # dd if=10501_20251028025900.ts of=test.tst bs=8 count=10000
> 10000+0 records in
> 10000+0 records out
> 80000 bytes (80 kB, 78 KiB) copied, 0.133328 s, 600 kB/s
> root@barley:/usr/local/myth26/media26# compsize test.tst
> Processed 1 file, 1 regular extents (1 refs), 0 inline.
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL      100%       80K          80K          80K
> none       100%       80K          80K          80K
>
> While that clearly shows no problems, doing something larger might
> With 100x bigger count, total 8MB, still ended up with "only" 3
> segments.  Although, scaled up
> to several GB that would be a pretty fragmented file.  Naively, 8GB ->
> 3000 segments, which is in line
> with what I'm seeing for the original files.

I'm guessing the problem is from writing the file slowly.  Check
/proc/sys/vm/dirty_writeback_centisecs.  It defaults to flushing dirty
pages to disk after 5 seconds, wich may not be giving enough time to
buffer up much data.

I don't know if btrfs tries to reserve some space after a file to have
room to continue to append to it without having to allocate space that
isn't contiguous.



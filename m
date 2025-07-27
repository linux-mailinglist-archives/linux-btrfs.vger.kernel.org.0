Return-Path: <linux-btrfs+bounces-15694-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE70B130A2
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jul 2025 18:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD643B6210
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jul 2025 16:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5290E21773F;
	Sun, 27 Jul 2025 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="Je2a9wTB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0A52F37
	for <linux-btrfs@vger.kernel.org>; Sun, 27 Jul 2025 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633943; cv=none; b=qaaeEKBxW735nqrIivFR6leCxwPh2NXur/os26ZnQJCQXo4o2ZIj8UnrvPoD0BkyBHyFj6XgY2Qr0duvLvy6JR9rQ6LQgrmHSkn6ndRu8I+dBC96OkTnE+5YqM7V0GLw7926BsvYIcB9oBVLecUFoyvygUHKIfn6Uvnwb7Q/EPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633943; c=relaxed/simple;
	bh=Uz3PDTtKhMECcwWep7AJECDWMYMVGFF2MojNCWpeJqE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbmh3YqtJKx9zerNRIITBsIkrgSk8fLkgZcxQMR+Z1+pUC4z27jHINH9Hst84Q1qhcdl952sniXSi2DjPqWIGp4OkBPpBVhjuWDJh06CHbszWkbfTe6+HWjS+tavaJoHcWYSkktq6nb21RUaJRMCj0A5PuX1XmuZa2CqnwkupDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=Je2a9wTB; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id B6E0F60DD4
	for <linux-btrfs@vger.kernel.org>; Sun, 27 Jul 2025 18:32:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:in-reply-to:content-disposition
	:content-type:content-type:mime-version:references:message-id
	:subject:subject:from:from:date:date; s=dkim; i=
	@rus.uni-stuttgart.de; t=1753633932; x=1755372733; bh=Uz3PDTtKhM
	ECcwWep7AJECDWMYMVGFF2MojNCWpeJqE=; b=Je2a9wTBJoEmQUeMzQLu1xVT5m
	i0/fjmL3klJQ6n240F9cicQh7871bg8OZpDFvgRgET5D65npdXHEwa3NweaedGrr
	dVN+OXC/LwQIw7FBvNwCmaaA8z3e+ASUBjyVjm49f2ymQ5Va2+rdkv1zbEM8W31r
	JSJab0EX/xqDUT/e0M7oPzYd+mrG+nttjWd4ZDVXtlojVkwBGgEcvOaMxULqMEiC
	v7WpvN+vuyoGY3PR2N/uE8iHuH7hWz67sjhINj4/I8DyCzaZNrX4hORJIDHJN54S
	7RXjxdFlDROJkHfjXBnupIRvrPDRvsknQC8Ye9TgsS44T9U6vrmKREcXAB6Q==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id NGclZIoJXc61 for <linux-btrfs@vger.kernel.org>;
 Sun, 27 Jul 2025 18:32:12 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Sun, 27 Jul 2025 18:32:12 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: Re: balance failed with checksum error
Message-ID: <20250727163212.GB842273@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
References: <20250726234755.GA842273@tik.uni-stuttgart.de>
 <4bf5d74c-910f-4cc9-b290-26bf5bcc8e47@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bf5d74c-910f-4cc9-b290-26bf5bcc8e47@gmx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729

On Sun 2025-07-27 (09:38), Qu Wenruo wrote:

> > root@mux22:~# btrfs balance start /
(...)
> > Starting balance without any filters.
> > ERROR: error during balancing '/': Input/output error
> > There may be more info in syslog - try dmesg | tail
> >
> > root@mux22:~# dmesg | tail
> > [22612.591075] BTRFS warning (device sda3): checksum error at logical 3450908672 mirror 1 root 806 inode 1509 offset 294912 length 4096 links 1 (path: tux/.cache/mesa_shader_cache/index)
> > [22612.591095] BTRFS warning (device sda3): checksum error at logical 3450908672 mirror 1 root 805 inode 1509 offset 294912 length 4096 links 1 (path: tux/.cache/mesa_shader_cache/index)

> So it's the same file with data checksum, but shared by tons of
> different subvolume.

Tons? Only 6:

root@mux22:~# btrfs subvolume list /
ID 256 gen 414 top level 5 path .snapshot/2025-07-27_0843--2025-07-30_0843.boot
ID 257 gen 414 top level 5 path .snapshot/2025-07-27_0849--2025-07-30_0849.boot
ID 258 gen 414 top level 5 path .snapshot/2025-07-27_0855--2025-07-30_0855.boot
ID 259 gen 414 top level 5 path .snapshot/2025-07-27_0856--2025-07-30_0856.boot
ID 260 gen 414 top level 5 path .snapshot/2025-07-27_0910--2025-07-30_0910.boot
ID 261 gen 414 top level 5 path .snapshot/2025-07-27_1816--2025-07-30_1816.boot


> Another possibility is, it's just a real corruption.

You mean a hardware (disk) failure?
This is very unlikely, because my VM runs on a high-end NetApp RAID.


> Either way the best solution is to remove all offending files.
> 
> > [22613.689939] BTRFS info (device sda3): balance: ended with status: -5
> >
> > root@mux22:~# btrfs version
> > btrfs-progs v6.6.3
> >
> > root@quak:~# sysinfo
> > System:        Linux quak 6.8.0-64-generic x86_64
> 
> This kernel is EOL, thus it will not that fix unless the vendor is
> actively doing backport.

Meanwhile I have upgraded the kernel:

root@mux22:~# uname -a
Linux mux22 6.14.0-24-generic #24~24.04.3-Ubuntu SMP PREEMPT_DYNAMIC Mon Jul  7 16:39:17 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

And now there are no more error(s):

root@mux22:~# btrfs balance start /
(...)
Starting balance without any filters.
Done, had to relocate 13 out of 13 chunks

root@mux22:~# dmesg | tail
[  163.838292] BTRFS info (device sda4): found 48242 extents, stage: update data pointers
[  164.806512] BTRFS info (device sda4): relocating block group 298844160 flags data
[  174.888393] BTRFS info (device sda4): found 2159 extents, stage: move data extents
[  175.554257] BTRFS info (device sda4): found 2159 extents, stage: update data pointers
[  176.008390] BTRFS info (device sda4): relocating block group 30408704 flags metadata|dup
[  179.472547] BTRFS info (device sda4): found 6326 extents, stage: move data extents
[  179.871047] BTRFS info (device sda4): relocating block group 13631488 flags data
[  180.078065] BTRFS info (device sda4): found 592 extents, stage: move data extents
[  180.226779] BTRFS info (device sda4): found 592 extents, stage: update data pointers
[  180.307905] BTRFS info (device sda4): balance: ended with status: 0

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<4bf5d74c-910f-4cc9-b290-26bf5bcc8e47@gmx.com>


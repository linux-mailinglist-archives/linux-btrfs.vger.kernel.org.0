Return-Path: <linux-btrfs+bounces-19628-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 630AFCB38AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 17:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81FAD307978D
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 16:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF873176E3;
	Wed, 10 Dec 2025 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="MuyO1Z4m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB0930DD22
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765385809; cv=none; b=OErtzSqBbkdGYoCASd85dtW3tFz8Tiahq/epeEcXrMF56sPa38oXY37E0fohNlVQO5c6aoZab3LJuFz1HXteslLsx3xalUrlwAoFdFqEYbhE03FQo0Lv43akK6Fe7ggOJQHF4d2ulG9h6R+KQVS3Dbl1GyaCluQ19bkShqdn1XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765385809; c=relaxed/simple;
	bh=d6znZNRqmW49gWBzIBgShd5mzVGNWzU6vsy5c1LhGfQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C+aQ8PQcJauGfYnhfE10jxUlDyxc+2YNRbqxiOfSmVxhOyrLsImYN8JrDrOFy8Gjk5Z37cyDnKQCJ/gPT/LRaFP6ZNI0fBrcE2NZvr6w1Uf6qdAoPBtnVdDb8yoRWHwDHelcVaZ8+QADTaw/zrs7W6CeQH3oFPrdq92/Fqifrrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=MuyO1Z4m; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id 6D06860B72
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 17:50:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1765385441; x=
	1767124242; bh=d6znZNRqmW49gWBzIBgShd5mzVGNWzU6vsy5c1LhGfQ=; b=M
	uyO1Z4mz/gbY4zM339YTjWdbWnv5eBmEmwQhwJnJYrAgnPsKMPxw/Hcf+iA/2Kly
	xo+yNDGuJiFUAlSoyUuIzStJN/JZs89LGLtgne1Dm2ST53CPYL7aIw/eBPCybSYk
	VOplw90mLymiSl9QBJMhkW0pIF4STJ7iG30H3Pn6qZd6cqBcjPmKQVuYCCN9KDBW
	6Uk1p0qPgrUzu4YfZ9wHghczvMSWKufIvVJ1jGe+aLYVEV/YDfwOM3GsvTd9KAaO
	+lUN6spgKn7rVrW2Ulwog/CetKZU861qfc6UMHvS4Z0f012nuqXRw2pZQI/Vro6E
	YXvNzislvCuLnDaJzTgfg==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id DJN7JYZlaQJy for <linux-btrfs@vger.kernel.org>;
 Wed, 10 Dec 2025 17:50:41 +0100 (CET)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Wed, 10 Dec 2025 17:50:41 +0100
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: booting from degraded RAID1?
Message-ID: <20251210165041.GA585304@tik.uni-stuttgart.de>
Mail-Followup-To: linux-btrfs@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Mailer: smtpsend-20240729


(I am using Ubuntu 24.04 with kernel 6.8)

I have read that booting from a degraded RAID1 filesystem (eg with one
dead disk) is not possible, because systemd waits forever for the second
partition.

Is there a HOWTO/best-practise what to do in this event?

I have create my root/boot filesystem this way:

root@mux22:~# mkfs.btrfs -m raid1 -d raid1 /dev/sda4 /dev/sdb4

root@mux22:~# btrfs filesystem show /dev/sda4
Label: 'M22'  uuid: 9329698e-bbb0-4047-bcef-863e584f314b
        Total devices 2 FS bytes used 144.00KiB
        devid    1 size 64.00GiB used 2.01GiB path /dev/sda4
        devid    2 size 64.00GiB used 2.01GiB path /dev/sdb4


-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20251210165041.GA585304@tik.uni-stuttgart.de>


Return-Path: <linux-btrfs+bounces-17042-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDFCB8F689
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 10:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43273BC6E3
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829852FCBF3;
	Mon, 22 Sep 2025 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b="KnChJWPz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mxex1.tik.uni-stuttgart.de (mxex1.tik.uni-stuttgart.de [129.69.192.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148EE223DD0
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 08:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.69.192.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528517; cv=none; b=T6Im3NGWW4OAFOHGPp53PeKSwH31jZ+B5FofnjTkyLxNREnwPDMYUc7SO+sxAaJLv+74gIyFuRWv1x6HAnQ9OUIqNJdvl2xKWwnQoxQfKZKnEv3IdDkUWvWHkNfBLyjqcUTI5YSpDmDb0bY46U4S4jAXsWtBKy3WiXL2MFuQeNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528517; c=relaxed/simple;
	bh=yAkcBVpqWLfwHE5sqv8C2lcs5IkYjvhQ6AQ17AQcxYo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ord5ojsWVl980H/tNEJD4JESMONiQRlHtOxmwEslPGUfPkXDUU8Tn4Uj8qeCsAxxqEr7LVnbcKYPG2XYX6T4B/Qic9nbCh2yKz7JHY66+Agdymp9hhuV+eNaXdXV6vUYK3lWq9XnEIM+AhalRPiZhLWMm8YeTgI8B9jUMaOl8/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de; spf=pass smtp.mailfrom=rus.uni-stuttgart.de; dkim=pass (2048-bit key) header.d=uni-stuttgart.de header.i=@rus.uni-stuttgart.de header.b=KnChJWPz; arc=none smtp.client-ip=129.69.192.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rus.uni-stuttgart.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rus.uni-stuttgart.de
Received: from localhost (localhost [127.0.0.1])
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTP id E3A6B6099F
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 10:02:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uni-stuttgart.de;
	 h=x-mailer:user-agent:content-disposition:content-type
	:content-type:mime-version:message-id:subject:subject:from:from
	:date:date; s=dkim; i=@rus.uni-stuttgart.de; t=1758528171; x=
	1760266972; bh=yAkcBVpqWLfwHE5sqv8C2lcs5IkYjvhQ6AQ17AQcxYo=; b=K
	nChJWPz+cWPCOrlaCNklkmLNLpyA3oCSyACwWWJ7yixt2d0egUPDxNnXhktChaPu
	xHrplZfcScJxAAl7Fz/b7sbKfstu9bNUlSyQiSezqnJk/81YfUoORbv8bwAzdNc6
	JHnpFrtZV9ZPsrDElhrlDnIvEJ/B9Zlwx2ifk9nO+4yA5JjnKJK4bYmlfFotJWsE
	2ZopqcYqU7qfDYOhTQ0b7vwY4L/tBo/VH28J8Zqw2+vo+wXIp4m7uGnHjLk+Tj1P
	PDwQ9Ss5mZ3WEwguVUcZbwplUU94D0rM08+ADLVGQ4TGy6AJbRRHHmT2FYBHn+tP
	Y/yiUwQ81eVoHfBzkOtvw==
X-Virus-Scanned: USTUTT mailrelay AV services at mxex1.tik.uni-stuttgart.de
Received: from mxex1.tik.uni-stuttgart.de ([127.0.0.1])
 by localhost (mxex1.tik.uni-stuttgart.de [127.0.0.1]) (amavis, port 10031)
 with ESMTP id T5h3fE80Do_K for <linux-btrfs@vger.kernel.org>;
 Mon, 22 Sep 2025 10:02:51 +0200 (CEST)
Received: from authenticated client
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxex1.tik.uni-stuttgart.de (Postfix) with ESMTPSA
Date: Mon, 22 Sep 2025 10:02:50 +0200
From: Ulli Horlacher <framstag@rus.uni-stuttgart.de>
To: linux-btrfs@vger.kernel.org
Subject: BTRFS errs: corrupt 9720
Message-ID: <20250922080250.GC2624931@tik.uni-stuttgart.de>
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


On a Ubuntu 24 system (Virtualbox VM) I see:

root@mux22:~# dmesg | grep BTRFS
[    3.431881] BTRFS: device fsid 13168cc9-1fde-4d4a-8af1-fc91da4f12db devid 1 transid 105840 /dev/sda3 (8:3) scanned by mount (198)
[    3.434291] BTRFS info (device sda3): first mount of filesystem 13168cc9-1fde-4d4a-8af1-fc91da4f12db
[    3.435119] BTRFS info (device sda3): using crc32c (crc32c-x86) checksum algorithm
[    3.435849] BTRFS info (device sda3): using free-space-tree
[    3.444593] BTRFS info (device sda3): bdev /dev/sda3 errs: wr 0, rd 0, flush 0, corrupt 9720, gen 0

corrupt 9720? What? Why? What to do?

root@mux22:~# uname -a
Linux mux22 6.14.0-29-generic #29~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Thu Aug 14 16:52:50 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

root@mux22:~# btrfs --version
btrfs-progs v6.6.3

-- 
Ullrich Horlacher              Server und Virtualisierung
Rechenzentrum TIK
Universitaet Stuttgart         E-Mail: horlacher@tik.uni-stuttgart.de
Allmandring 30a                Tel:    ++49-711-68565868
70569 Stuttgart (Germany)      WWW:    https://www.tik.uni-stuttgart.de/
REF:<20250922080250.GC2624931@tik.uni-stuttgart.de>


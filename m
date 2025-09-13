Return-Path: <linux-btrfs+bounces-16802-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC749B5635D
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Sep 2025 23:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936BF561E8C
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Sep 2025 21:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621BF298CAF;
	Sat, 13 Sep 2025 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="mG4AGc4x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PxbTmUNH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7C128134C
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Sep 2025 21:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757800685; cv=none; b=W2W9FTyHG56IbWpGOckBVbaKkH2p0XRjdTUcscYWv+/upzqBjG0Iz30RoqlEoJJhtFdx1F/+z8hsgmu29r9G5S6qfKKq8HGsvU7SvJ6bN/GPyVDsT1dflDM79m9RxToX75VYfSyvvGjXZsyiwY8ncbn0hw2K2v9ynx4ADcDlnYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757800685; c=relaxed/simple;
	bh=CGOrTuigmKkMJ4a8jxNkKkqtLdPJnsqGn4ICl2ChFRM=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=n0bEDr8jO7iO6aleRqVzRJHVz17CMVrppbay7wUh66iX1FpztY3Nq1Qdjby/O0lIFteeFBi/wGi90jcYBYjoGb6Q39Kiwe7D/VLI4OxKOsYsW2gFWuOs0Xp93IwCKHyTe5kTLdNRmk/SJXBJJDAlRHuSTwDESUF3p4xdw/LIsBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=mG4AGc4x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PxbTmUNH; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D9B61400057
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Sep 2025 17:58:00 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Sat, 13 Sep 2025 17:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm2; t=
	1757800680; x=1757887080; bh=yW2udOtOnhf3NrigsG0ULAwGwxu/89OnNaT
	dVig5igg=; b=mG4AGc4xIRqP8ZWWdrBh5olJ/F2H4k9DiAC8igxKM8EeplYhrIg
	E+6imuWoEfIyFk2zdzNNbT5xel6fOjzXmwuGox154x6iu112I/byeR3VQ62IjGJw
	GQMeq5Kmv3lVwL1U21vVISLMO3FP+y8p6DqVbEpqKFFM2Nw+kQwhgjCesciQJ9Hl
	HSCKdLopl+kBp9ay0FYQ2hoC5XlAAPk8+AkWw9wk5jGgjwDutxGKONY2dAUk9kOd
	BtNrDPz0JQ46ukgAHmUV+D2uBVp4qxUBdMDXHpQB5xMCnC7xRka0pMXEa4Fc+C4F
	L4WvMmm4Tk0Vw9eeL+fAz4bk/bEUZr2YWXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757800680; x=1757887080; bh=yW2udOtOnhf3NrigsG0ULAwGwxu/89OnNaT
	dVig5igg=; b=PxbTmUNHZizoDLV4le1tGaiToS+6jmZE0iA+fKJNxbMFdDRiKoV
	Dvx1iMON3n2MyLxwEmAmb/RwyxFZrV5DEl2ZMAyixOEJOnUMeY3rCa43+qcmREMf
	GVG3y53LeV/bK8vF58BxlqNG+0VzzAF7VKcjtO86w7J2HbdP8VeZoRvbk3DEj8I6
	yynkbjbHGyGI0nhjBXikf26I7bq5yqc1PNp9OQPyZSgxp8xA6laX2s4NIXvjH0yr
	UMnXxIitLqpPE5zOimkBrA4Brgb0Rje+q03bQgS88jRei1nV4LYrnXdC3n/1nBy6
	08ULk6cG4VTSGirPojdgOSNXuEkQT2GY28g==
X-ME-Sender: <xms:6OjFaFZWWGEPJpZwxyhJzlCQdS6f-lFd0-Rs6VhAivrC9dAiH7JaUQ>
    <xme:6OjFaMYibEOavguIK5i59v2Vdb4onZhMaDwtm_zaLdHCd21UgGzxS3MI6_lT-4OiV
    6XRGC7ut5LS-t_u8iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeffedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkffutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhrhhishcuofhu
    rhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenucggtf
    frrghtthgvrhhnpefgfffggefhfeekfeefhfejueevtdeikeehfefhfedvgffhtdfgudev
    gfdvgeelueenucffohhmrghinheprhgvughhrghtrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheplhhishhtshestgholhhorhhrvghm
    vgguihgvshdrtghomhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6OjFaHRYf1-bxTxDmmuy8rqubIZg0_-NhXg2Uu_8tC7Dy3egRUzXzw>
    <xmx:6OjFaNDWxdaND-qUz0gLs_j-npzKcRwShbYK3G3_d8L4C9Gxw8cUbw>
    <xmx:6OjFaH1DplqT9LTvgkxRPY-GuoS3Ha-Zqgo_rpJKRoYiTdlGve68HQ>
    <xmx:6OjFaLUTqKU4tv1Mz_hDVodfc-LAmSy7wxCuhJYlGYU6Y79vh7ah0g>
    <xmx:6OjFaOasijTKjcFWvQgWzU3mf0zEj3sMi7Lpu2utAhMEBWTIs233O_xc>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 410BA18C0067; Sat, 13 Sep 2025 17:58:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 13 Sep 2025 17:57:33 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <d93b2a2d-6ad9-4c49-809f-11d769a6f30a@app.fastmail.com>
Subject: 6.17rc5: btrfs scrub, Freezing user space processes failed
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

kernel 6.17.0-0.rc5.42.fc43.x86_64
btrfs-progs 6.16-1.fc42.x86_64


Scrub initiated, walked away,  and when I come back it appears hung with a black screen unresponsive. I gave it maybe 30 seconds, gave up and forced power off.  The journal preserved what was going on.

full dmesg is attached here:
https://bugzilla.redhat.com/show_bug.cgi?id=2394998

dmesg excerpt


[ 8088.052124] kernel: BTRFS info (device dm-1): scrub: started on devid 1
[ 9662.647055] kernel: Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
[ 9662.689046] kernel: Lockdown: systemd-logind: hibernation is restricted; see man kernel_lockdown.7
[ 9662.793052] kernel: wlp0s20f3: deauthenticating from a4:22:49:b2:cb:a6 by local choice (Reason: 3=DEAUTH_LEAVING)
[ 9727.984200] kernel: PM: suspend entry (deep)
[ 9727.991082] kernel: Filesystems sync: 0.007 seconds
[ 9748.172951] kernel: Freezing user space processes
[ 9748.173350] kernel: Freezing user space processes failed after 20.001 seconds (1 tasks refusing to freeze, wq_busy=0):
[ 9748.173520] kernel: task:btrfs           state:D stack:0     pid:15156 tgid:15155 ppid:4043   task_flags:0x440140 flags:0x00004006
[ 9748.173653] kernel: Call Trace:
[ 9748.173768] kernel:  <TASK>
[ 9748.173884] kernel:  __schedule+0x2f9/0x7b0
[ 9748.174026] kernel:  schedule+0x27/0x80
[ 9748.174166] kernel:  io_schedule+0x46/0x70
[ 9748.174295] kernel:  blk_mq_get_tag+0x11d/0x2d0
[ 9748.174444] kernel:  ? __pfx_autoremove_wake_function+0x10/0x10
[ 9748.174545] kernel:  __blk_mq_alloc_requests+0xb0/0x2b0
[ 9748.174651] kernel:  blk_mq_submit_bio+0x2c3/0x890
[ 9748.174764] kernel:  __submit_bio+0x74/0x280
[ 9748.174855] kernel:  __submit_bio_noacct+0x90/0x210
[ 9748.174925] kernel:  btrfs_submit_chunk+0x1a2/0x6c0
[ 9748.175027] kernel:  ? __pfx_scrub_read_endio+0x10/0x10
[ 9748.175118] kernel:  btrfs_submit_bbio+0x1a/0x30
[ 9748.175184] kernel:  submit_initial_group_read+0x8a/0x1d0
[ 9748.175264] kernel:  scrub_simple_mirror+0x26f/0x310
[ 9748.175372] kernel:  scrub_stripe+0x512/0x7a0
[ 9748.175445] kernel:  scrub_chunk+0xd0/0x170
[ 9748.175508] kernel:  scrub_enumerate_chunks+0x319/0x710
[ 9748.175571] kernel:  btrfs_scrub_dev+0x225/0x660
[ 9748.175641] kernel:  btrfs_ioctl+0xe77/0x15d0
[ 9748.175710] kernel:  __x64_sys_ioctl+0x94/0xe0
[ 9748.175779] kernel:  do_syscall_64+0x82/0x2c0
[ 9748.175848] kernel:  ? __lruvec_stat_mod_folio+0x85/0xd0
[ 9748.175919] kernel:  ? xas_load+0x11/0x100
[ 9748.176032] kernel:  ? xas_find+0x83/0x1b0
[ 9748.176116] kernel:  ? next_uptodate_folio+0xa0/0x350
[ 9748.176186] kernel:  ? filemap_map_pages+0x35c/0x5a0
[ 9748.176255] kernel:  ? memcg1_check_events+0x60/0x1d0
[ 9748.176325] kernel:  ? do_read_fault+0x107/0x260
[ 9748.176393] kernel:  ? handle_pte_fault+0x118/0x240
[ 9748.176461] kernel:  ? do_fault+0x150/0x260
[ 9748.176523] kernel:  ? __handle_mm_fault+0x551/0x6a0
[ 9748.176591] kernel:  ? count_memcg_events+0xd6/0x220
[ 9748.176670] kernel:  ? handle_mm_fault+0x248/0x360
[ 9748.176740] kernel:  ? do_user_addr_fault+0x21a/0x690
[ 9748.176803] kernel:  ? exc_page_fault+0x74/0x180
[ 9748.176873] kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 9748.176943] kernel: RIP: 0033:0x7f4a739060ed
[ 9748.176996] kernel: RSP: 002b:00007f4a737aec50 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 9748.177102] kernel: RAX: ffffffffffffffda RBX: 000055e4140b79e0 RCX: 00007f4a739060ed
[ 9748.177181] kernel: RDX: 000055e4140b79e0 RSI: 00000000c400941b RDI: 0000000000000003
[ 9748.177251] kernel: RBP: 00007f4a737aeca0 R08: 0000000000000020 R09: 31203a6b63617473
[ 9748.177330] kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00007f4a737af6c0
[ 9748.177399] kernel: R13: 00007ffe1aba7a10 R14: 00007f4a737afcdc R15: 00007ffe1aba7b17
[ 9748.177461] kernel:  </TASK>
[ 9748.177531] kernel: OOM killer enabled.
[ 9748.177593] kernel: Restarting tasks: Starting
[ 9748.177678] kernel: Restarting tasks: Done
[ 9748.177746] kernel: random: crng reseeded on system resumption
[ 9748.318065] kernel: PM: suspend exit
[ 9748.318375] kernel: PM: suspend entry (s2idle)
[ 9748.341048] kernel: Filesystems sync: 0.021 seconds
[ 9768.348446] kernel: Freezing user space processes





--
Chris Murphy


Return-Path: <linux-btrfs+bounces-8093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FF697B3E3
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 20:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C928D2856BF
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2024 18:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405F317C7A5;
	Tue, 17 Sep 2024 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="JNEEfY/N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mLpgPceY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCAF4D8AD
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726596320; cv=none; b=gKo7OW2IkymCRfeNn6TEvTx7ifxXXrQwRUs7t++0cm9Pmmj+yuiNU5O25jvmIDXz+z2QUtxiuNCAtexTlw2TZbpQ/iKlBKh9LY8ItKWu/bhqNMILnsT/M5ImB5SRmAu82nnP6UrfUFd5R0z86DxcJmEwMcazMxfPHAHoJD5/sA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726596320; c=relaxed/simple;
	bh=C3DK5Tu8ptTcBbBSUwA7VyJQ96AM0MWM+PdJORWUQrs=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=PHtRjNNZszJum98XWro7uHkwmf2Xp8oLNO2gAAiHdEXZbgdIsN4a5QQBK2LHapg6NuR68/vmaH+4GQQ8ZNEovdYhhmCd5DBkLpywLL9wYm681oo5f059Faf2XFuQcCTYTfjrD8gHkzcXdMuFJysyl1dv498pW3Sd8gGOA+2OY3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=JNEEfY/N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mLpgPceY; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D44551140135
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2024 14:05:17 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Tue, 17 Sep 2024 14:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm2; t=
	1726596317; x=1726682717; bh=C3DK5Tu8ptTcBbBSUwA7VyJQ96AM0MWM+Pd
	JORWUQrs=; b=JNEEfY/NjD3refYzEtByA1kVWcDwljsl5e9Cwb7msrfU0oU2UOK
	amieqz5g3DMCkDzDC3xnEZjuZAdjk9XYDHmPH+BIfNPkYvIDI7tFJhpMkC6F8zPC
	b32WJiBv+LECxoCBi4P7QWUjMYhZ/NYwd/j+y45p2pWoKiR20ipQbEJHsGEiATH9
	w3kimXn+c2kSGroQns79Qm037szJdQ9mUuRGUxOURxllhyrHoeYBQAj+Ir9WgX/H
	Z9biM5zM+35ZUlMqQiQfUyCAhnH08BzSwYIjT6IWY43WC5+1tVvKBOvxliiRItH6
	/aYSsUO1laFF89VmLjrpSAvN0sf6/6ne2HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726596317; x=1726682717; bh=C3DK5Tu8ptTcBbBSUwA7VyJQ96AM
	0MWM+PdJORWUQrs=; b=mLpgPceY9Vqt7N1IPa/UlbAeljuqbbR/0rodXQ6d48LW
	5UOIQS+ZOvguDv7CYqZZMlW+DfV5rFFNDkUzGWwP0YZMowWXaJ/cRrD3K7pHsQyO
	tY6rSiZZn7FcUEepP7yLUJnVj4MfXaK+kXkcjt7hxmdwx9uYACtn4vh0QzBzIlo0
	Hp2NCBQAzchTng/0tXKKYRKlebewWwznxGV2H2Ny08ea8bZ9qoomURXxugImHkn2
	Nre6vH/LEmgThT9CemCtE9kXyNYt7HSX5m3GyzAx789EsMKTS746OGTXflj5uHX+
	B4NoA8u75reN/nxKHkQSqmrk1A49/6z2Ne/DjCe5Lw==
X-ME-Sender: <xms:3cTpZlm_s8z0WscsljbJo5Z2B1lhBIOTZ0nFRj595BxbOLhnqMJZhg>
    <xme:3cTpZg2LdIKk8lh0EKBYiN2DkR1zimbkj8agN6-m08zqQIwkFWlXlvCgC9_xl-8fd
    6tVj9JhQzyNJ7u2idM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvkffutgfgsehtjeertdertddtnecu
    hfhrohhmpedfvehhrhhishcuofhurhhphhihfdcuoehlihhsthhssegtohhlohhrrhgvmh
    gvughivghsrdgtohhmqeenucggtffrrghtthgvrhhnpefgfffggefhfeekfeefhfejueev
    tdeikeehfefhfedvgffhtdfgudevgfdvgeelueenucffohhmrghinheprhgvughhrghtrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    lhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghpthhtohepud
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3cTpZro66a0JLPb9O49Whyb1C2AyRSfNdd0X0hRiqm1S-sqWMny0Yw>
    <xmx:3cTpZlmJbEtBFuFaH7B2r_nbLTpzHBJs97GBitc0J8mqr1cQttkSmw>
    <xmx:3cTpZj017KiJM1LEHNx3wSltSdP4x409hBI7pt7_Z6E8YfQd0lK91Q>
    <xmx:3cTpZksVip8GilWLFNomthxf2-L3N9-GxY7j2MgjANGYAhO44aYRtA>
    <xmx:3cTpZg81uXHhFWpjV6u9VtpsOxJNC2p5whr1t8eNPvY2aWlVrmLO3hZS>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 91BB21C20065; Tue, 17 Sep 2024 14:05:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 14:04:54 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <47636de6-8270-4a24-b97a-df9c267439c7@app.fastmail.com>
Subject: BTRFS critical, corrupt node, unaligned pointer, should be aligned to 4096
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Happens with 6.10.6-6.10.9, does not happen with 6.9.7.

Complete kernel messages are attached to the bug report
https://bugzilla.redhat.com/show_bug.cgi?id=2312886

kernel message excerpts:

Sep 17 00:55:42 kernel: page: refcount:4 mapcount:0 mapping:00000000339eecab index:0xef2f60 pfn:0x1528ae
Sep 17 00:55:42 kernel: memcg:ffff9a2180399000
Sep 17 00:55:42 kernel: aops:btree_aops ino:1
Sep 17 00:55:42 kernel: flags: 0x17ffffd600422e(referenced|uptodate|lru|workingset|private|writeback|node=0|zone=2|lastcpupid=0x1fffff)
Sep 17 00:55:42 kernel: raw: 0017ffffd600422e ffffe31e054a2bc8 ffffe31e054a2b48 ffff9a2180488338
Sep 17 00:55:42 kernel: raw: 0000000000ef2f60 ffff9a232a13c1e0 00000004ffffffff ffff9a2180399000
Sep 17 00:55:42 kernel: page dumped because: eb page dump
Sep 17 00:55:43 kernel: BTRFS critical (device vda3): corrupt node: root=2 block=64205750272 slot=121, unaligned pointer, have 64012238993 should be aligned to 4096
Sep 17 00:55:43 kernel: BTRFS info (device vda3): node 64205750272 level 1 gen 2593 total ptrs 206 free spc 287 owner 2
...
Sep 17 00:55:43 kernel: BTRFS error (device vda3): block=64205750272 write time tree block corruption detected
Sep 17 00:55:43 kernel: page: refcount:4 mapcount:0 mapping:00000000339eecab index:0xef3a90 pfn:0x1ce336
Sep 17 00:55:43 kernel: memcg:ffff9a2180399000
Sep 17 00:55:43 kernel: aops:btree_aops ino:1
Sep 17 00:55:43 kernel: flags: 0x17ffffd600422e(referenced|uptodate|lru|workingset|private|writeback|node=0|zone=2|lastcpupid=0x1fffff)
Sep 17 00:55:43 kernel: raw: 0017ffffd600422e ffffe31e04b94988 ffffe31e0738cdc8 ffff9a2180488338
Sep 17 00:55:43 kernel: raw: 0000000000ef3a90 ffff9a2192f701e0 00000004ffffffff ffff9a2180399000
Sep 17 00:55:43 kernel: page dumped because: eb page dump
Sep 17 00:55:43 kernel: BTRFS critical (device vda3): corrupt leaf: root=256 block=64217481216 slot=3 ino=16205860, invalid dir item type, have 33 expect (0, 9)

...
Sep 17 00:55:43 kernel: BTRFS error (device vda3): block=64217481216 write time tree block corruption detected
Sep 17 00:55:43 kernel: BTRFS: error (device vda3) in btrfs_commit_transaction:2505: errno=-5 IO failure (Error while writing out transaction)
Sep 17 00:55:43 kernel: BTRFS info (device vda3 state E): forced readonly


--
Chris Murphy


Return-Path: <linux-btrfs+bounces-8174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5FB983977
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2024 00:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91CC2824F3
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 22:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B9D83CD2;
	Mon, 23 Sep 2024 22:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="eNX31FWL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ci7s6ms+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA637407A
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2024 22:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727128975; cv=none; b=k447PbC9qJKB8jGNJAVkdw6Pv/bBSL57XeNWrEdf3SkyRLQbfqDT0n7D3lzXK+9B2Vi0oHcUpxYHDiJli4zoMdy0AOq7ayvZXlYd0i28mWIbLz88PKdMYkUC0+QaTAV44+eAnt0XZud2r3JBDuOh2dOQM5McYOCz/v5PMXZBFqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727128975; c=relaxed/simple;
	bh=PCuBSZ9vSf4DP/aXRIPCYr38NK8kkLL1GHIQa50rkpo=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VcDK/7IjpNMWhDaAvALcGev0uZs+ut4ZWt4icRZn4Ic+BZ6+v0qkBRcxtOkHH+PeVx2CxaXzmkqeCYUnElU5+gRjuWVVeRALFrnkfESS8WTMRScfyVEGWQG0AtmXqTsyOQHCC+eTEveLFhUjGLfAcLkYTBTuwtDNlI3YvmTg0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=eNX31FWL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ci7s6ms+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B5588114012A;
	Mon, 23 Sep 2024 18:02:52 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-03.internal (MEProxy); Mon, 23 Sep 2024 18:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm2; t=1727128972; x=1727215372; bh=fFrEP75WP91rPY9fvXrQS
	x1C7ctGHr9eN5E4SoMwtWw=; b=eNX31FWLrHaadQ2Yd2oginKwTZ4LNCTJ+Vt6s
	7IWZscztRi+mvmRF6dtdnXevrudDS6ci2GKW0xw23bP+E/6IE98HRmCzqwb97yYz
	/e0d6Bec3ecUQKttN97JrXF7Fim9C6jDshjUL+TINl44Rx989bY332sf/7gHDT7e
	HmNWgQ9uNwRHtQwYyD7oo3UlGH5BNq7mH6/0Qfa4qV0mPH+Clvb+m9Z5/1G+v2CR
	TgTFrpIK6waJFYdJ2Js0AKtVYx+T6xFzdRUiY14ZwY+T6oSCY1L75EJSmOnpuHxs
	oc9pKANlIRYi1QC7ftM5ft/zfauYm5jaOCniZIqnsP7v+t0rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727128972; x=
	1727215372; bh=fFrEP75WP91rPY9fvXrQSx1C7ctGHr9eN5E4SoMwtWw=; b=C
	i7s6ms+rESw4EyQjl8h4EKeiU4AqYsyi3zqaflb8nqNi9HLictBvC4/TWyp/4UBw
	4lI+848s6QmP9vDpdTSu+EgxCSbK9gXqd4dakmLD5N5iyhQvV96hPOaZCV7nOJ5D
	HcKuEl9JGccWg3KWv3fqiz+GrDLCnYUGgsan78707kiaiKy5cbV/9rLxwykrqBTk
	N6F7PJ9QckmVvS6bEVXmTIasf5sgmFPxpQQYkE75oPbTZFE+w8/r8zLP4rXheVfG
	VDEmbQ9kh17PI+XcRUOXTj4qbhrgDPKFzM0t9JQbEAmk3zNyJ9z7pi/MpHNcxz2c
	pDeoyss4POhQBFcd+9W0w==
X-ME-Sender: <xms:jOXxZozQrMFbqTDB_p1tZ5u7QRHaWGm4fqUymLhNM6cgTgK4nAYxLg>
    <xme:jOXxZsSv-KrMMFqkjfg96lnt44R_2aUc9rre1xOOXpoZ2m0e5wBi6rvfn5Vz5a7sw
    bE66vMaQlTXlsgCw5U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddttddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvffkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdevhhhrihhsucfouhhrphhhhidfuceolhhishhtshestgholhhorhhrvg
    hmvgguihgvshdrtghomheqnecuggftrfgrthhtvghrnhepvddtgfejffetieeihfdvudel
    gefghffggeeifefftdeigefgkeetgeekieefjeeinecuffhomhgrihhnpehrvgguhhgrth
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehlihhsthhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgtphhtthhope
    dvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehquhifvghnrhhuohdrsghtrhhf
    shesghhmgidrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jOXxZqVG3TEjnLaDzEPMH7No9W_N-bSrNeAO1Ekk62DGAipmFj_hIA>
    <xmx:jOXxZmi-roMm0QUpqfp8l_tOYXKh-o2nyg2ABeBQd15GKqTqVUSWBw>
    <xmx:jOXxZqBGnARjxVx8mbzQAtBCm-YyQ6e5WD5eKtRQ7tyal2GfQB_iuA>
    <xmx:jOXxZnJuZLrVCvUQw_a0TAEBbAzJTflOKMSVyCyBIzkzdXCKfVYkYg>
    <xmx:jOXxZr4uKLr8dOdPPNLFXNsVmPF8nu5xvmBLRt2Wn2o3D4DpyOoikJqt>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 662581C20066; Mon, 23 Sep 2024 18:02:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Sep 2024 18:02:31 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Qu Wenruo" <quwenruo.btrfs@gmx.com>,
 "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <8fcfe0e4-5db1-4cd1-8f94-5ce049086f9b@app.fastmail.com>
In-Reply-To: <2ffd987f-f767-4fd2-b684-0c95d418a977@gmx.com>
References: <47636de6-8270-4a24-b97a-df9c267439c7@app.fastmail.com>
 <2ffd987f-f767-4fd2-b684-0c95d418a977@gmx.com>
Subject: Re: BTRFS critical, corrupt node, unaligned pointer, should be aligned to 4096
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

New comment in the bug report: https://bugzilla.redhat.com/show_bug.cgi?id=2312886#c4

Except kernel messages. What's interesting:
-  multiple arches (also s390x but I don't have any kernel messages for it);
-  single workload (koji composes)
-  the btrfs error is different for each, this makes me think we're not dealing with a btrfs bug

But how can we get more information about why this is happening? Is running a KASAN enabled kernel useful?


6.10.5-200.fc40.aarch64

Sep 21 14:06:14  kernel: BTRFS critical (device vda3): corrupt leaf: root=256 block=553541238784 slot=9 ino=1551466593, name hash mismatch with key, have 0x00000000cb63b37b expect 0x00000000fec4d99b
Sep 21 14:06:14  kernel: BTRFS info (device vda3): leaf 553541238784 gen 623185 total ptrs 91 free space 5959 owner 256
Sep 21 14:06:14  kernel: BTRFS error (device vda3): block=553541238784 write time tree block corruption detected
Sep 21 14:06:14  kernel: BTRFS: error (device vda3) in btrfs_commit_transaction:2505: errno=-5 IO failure (Error while writing out transaction)
Sep 21 14:06:14  kernel: BTRFS info (device vda3 state E): forced readonly
Sep 21 14:06:14  kernel: BTRFS warning (device vda3 state E): Skipping commit of aborted transaction.
Sep 21 14:06:14  kernel: BTRFS error (device vda3 state EA): Transaction aborted (error -5)
Sep 21 14:06:14  kernel: BTRFS: error (device vda3 state EA) in cleanup_transaction:1999: errno=-5 IO failure
Sep 21 14:06:14  kernel: BTRFS: error (device vda3 state EA) in btrfs_sync_log:3174: errno=-5 IO failure


6.10.5-200.fc40.x86_64

Sep 23 05:17:20 kernel: BTRFS warning (device vda3): csum hole found for disk bytenr range [4880289792, 4880293888)
Sep 23 05:17:20 kernel: BTRFS warning (device vda3): csum hole found for disk bytenr range [4880293888, 4880297984)
Sep 23 05:17:20 kernel: BTRFS warning (device vda3): csum failed root 256 ino 281 off 66670592 csum 0xb85d0050 expected csum 0x00000000 mirror 1
Sep 23 05:17:20 kernel: BTRFS error (device vda3): bdev /dev/vda3 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
...
Sep 23 09:38:53 kernel: BTRFS info (device loop0p4): last unmount of filesystem 2cf58b61-2878-4bc4-b0b0-64e75d467fdf
Sep 23 09:39:30 kernel: BTRFS info (device loop2p4): last unmount of filesystem 57ad289b-2ac5-48ea-86bf-841e20af8720
Sep 23 10:24:52 kernel: BTRFS critical (device vda3): corrupt leaf: root=7 block=1374024122368 slot=150, unexpected item end, have 4706614063 expect 14527
Sep 23 10:24:52 kernel: BTRFS info (device vda3): leaf 1374024122368 gen 699790 total ptrs 346 free space 2909 owner 7

--
Chris Murphy


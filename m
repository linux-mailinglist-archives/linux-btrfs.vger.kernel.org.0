Return-Path: <linux-btrfs+bounces-17851-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1A4BDFD2C
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 19:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E487F3A3DC7
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 17:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F9A20296A;
	Wed, 15 Oct 2025 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="PUyYrbQD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ltWkDaKA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340AC12CD88
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760548530; cv=none; b=p4mbHreC4dnKNhfo1xprP4h3QSHgyJhS1n2kljMlZXqasUZ5F1xKqT7x23S4VhwhifjUz28n+QXJgE2mx4/A8TdLoyMFuXMZVnVEYTFgHCMFdyTjyNSu28a/S0M8+6gGNIq73APBFspB/nlCH452JkQamHHEx9YQ3Oa8lTXXWRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760548530; c=relaxed/simple;
	bh=BaJE4PnCI4HMKrkgv3ENM2+qc4lBS8tVE/EuVJcXayg=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=iFBdBqUHBPxnkA+mrj0iewJ8eUakd33ihkEYg8oHPHUuDARRKLfialAD1jCqfOaqK5Ix9mysHzBNCkn0nhVLPyiPtuqyFGce2wH1pDUIS3LUfDxTSAqQw/3eoGXLVhnObqluOn9r8P8zRPrcZ4OxI/nFouRLO9rM4lGAc8LHMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=PUyYrbQD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ltWkDaKA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1B5FB14000FE
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 13:15:27 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Wed, 15 Oct 2025 13:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm3; t=
	1760548527; x=1760634927; bh=BaJE4PnCI4HMKrkgv3ENM2+qc4lBS8tVE/E
	uVJcXayg=; b=PUyYrbQDVakse/6I8gjw3sV5vVTtTKz2bK9eI0T/rnjPQ8hNUJM
	I+WAC1Pcmg6VVouAncqa6tDuZJg7esciMsMfF2qxSj2uakvN22Tfltfvl24OjXt9
	qGKT1sTQqfgyTHI8h8pR+owzgICAYJd1BUi3AL79Ik9B7b4NTddv55u9v4yTp5II
	g/V7uC4t9z/JAUKMvNmVm0xOcOovj2NAPvHQMypBLVhFrj7gBdSjkKRbVlPTXqah
	uH6txastTtqNKsSO0OI4+Jw/n/JNLLXZncu4TmEficc7FCnpgvr8sbJm5EPgnLZs
	9OT1b7A1Lr4NTZTQj043Ky9Y+hoSdIfP6IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760548527; x=1760634927; bh=BaJE4PnCI4HMKrkgv3ENM2+qc4lBS8tVE/E
	uVJcXayg=; b=ltWkDaKACsrDJoXqTPuEFMCfzIqt7kXSraZEG729Dw6/4MGC8sK
	Yg5x/PQVKWF1aiy3dJJ2Sw0A4IAsDnltDr/eGy7aTuBjxap9mwiSuyGImxt8HaGV
	WFvaS0S6+JX56eh4AN6LI7nDIxtnIZFWwfay8JCy/YQD9Ku9f6MGScvGclYKee8E
	5QllyD3dABCdvVoWeCdyVpoJFnNiNNdB2ltnsoXjqezK4GKRGtUzsVc/I4gi7WdI
	p7biAHSOH2kJRAk8J+xDwo1vd/PqPtsyXLBnTzWtDAmewdJdMCxqEBWSc+6leIrH
	CjTqtFQSLFMBVKeJdz9Sc+cAL/NgR5IMu+g==
X-ME-Sender: <xms:rtbvaOlY_asShzW4STw10TKIJ9XZrFlEI4IdQDXairvrS7UChZLk3w>
    <xme:rtbvaAoFG7nbRKzO0QZ96JOsOIO_KBB13tGwN-LLK_qfwtKAoVFxkvtKkc9y-Bhn-
    kxWJhvD-CCBpa6rre6JJJwpznO3g6vHzkS3pdolRko7cvjiPXsk0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkufgtgfesthejredtredttdenucfhrhhomhepfdevhhhrihhsucfo
    uhhrphhhhidfuceolhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomheqnecugg
    ftrfgrthhtvghrnhepveejledtfeffgedvgeegtdevtdefffeflefftdetffegffejtddt
    jeekleevuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheplhhishhtshestgholhhorhhrvghmvgguihgvshdrtghomhdpnhgspghrtghpthht
    ohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rtbvaIXzOI1gFK3FcQb1whSFIIohpQ5YJK7XDK-ls3y0gdA_d8JIYQ>
    <xmx:rtbvaMiuGom2kACtoMp0Zi1pjjpdQrBIqlJrZOS40c2d4lfG8U-XsA>
    <xmx:rtbvaJQQ6YqVbX9HvBK7_1Sj9t04Pwp5j2WF0AXLMgl6i2d1ZE7NMA>
    <xmx:rtbvaPHzO-wqghWGsb2LFti90l2HJGyICNcQqB11p23jIXo-PD2mrg>
    <xmx:r9bvaOpgLoQciwQ-ocJzG-TloAAVJEmZFDR_9RT8QH9UkwM49r99h9N5>
Feedback-ID: i06494636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CD3D618C0066; Wed, 15 Oct 2025 13:15:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Oct 2025 13:15:06 -0400
From: "Chris Murphy" <lists@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <046467e4-a695-4181-8674-a1448f5a3896@app.fastmail.com>
Subject: bug - no kernel message when remounting with noflushoncommit
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

kernel 6.17.1-300.fc43.x86_64
btrfs-progs 6.17

# mount -o remount,notreelog,flushoncommit /
[226174.629964] BTRFS info (device dm-0 state M): disabling tree log
[226174.629982] BTRFS info (device dm-0 state M): turning on flush-on-commit
# mount | grep btrfs
/dev/mapper/luks-10d575f0-f041-48a2-b1ed-b1236e03d5e3 on / type btrfs (rw,noatime,seclabel,compress=zstd:1,ssd,notreelog,flushoncommit,space_cache=v2,subvolid=710,subvol=/root43)

# mount -o remount,treelog,noflushoncommit /
[226236.054536] BTRFS info (device dm-0 state M): enabling tree log
# mount | grep btrfs
/dev/mapper/luks-10d575f0-f041-48a2-b1ed-b1236e03d5e3 on / type btrfs (rw,noatime,seclabel,compress=zstd:1,ssd,space_cache=v2,subvolid=710,subvol=/root43)

Looks like flush on commit is turned off per mount options, but there's no kernel message indicating it.

--
Chris Murphy


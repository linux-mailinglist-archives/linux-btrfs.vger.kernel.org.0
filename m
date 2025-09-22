Return-Path: <linux-btrfs+bounces-17037-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 799F7B8F05B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 07:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF161896A1B
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 05:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FDA21ABC9;
	Mon, 22 Sep 2025 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b="AJpm1YNZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="obtvDtGi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE798F40
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 05:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758519390; cv=none; b=ogJkavIW9NHu/9F+rZQjpbyQzzGRSQ8VoQBz+eFTxf7Xu2VuEQAEOTzDVLQT/LNZcBmouctpYhJCvfK5a9p8ZxX5vCMH4+wZX/+BvQP2mjysLM8RUkFarOew3TTZm627gNAiG29d9pAIU0jtKFJBi0vJUBqVeWOt5jbYGk4AOkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758519390; c=relaxed/simple;
	bh=tCaOLvztb73Y0HsTxy6wgojR+cDkStugJXEA0RH+Gss=;
	h=MIME-Version:Date:From:To:Message-Id:Subject:Content-Type; b=LP10Kpp1seAUxpJDxufHTINFwCd9cXmx9kPnZzkUxkx01bx8peaJ/siMt06qIZM3PuRC/t2zCE/k6W1fZFHK8So7r+YlfwSDRoClkd5G0ejL45g7Q7F6lHzqB+GCQthPu6v/mss0lA1mGlQeKEBEMxU4kiHmQo13yJmef6RlXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com; spf=pass smtp.mailfrom=colorremedies.com; dkim=pass (2048-bit key) header.d=colorremedies.com header.i=@colorremedies.com header.b=AJpm1YNZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=obtvDtGi; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=colorremedies.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=colorremedies.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A43A1400056
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 01:36:26 -0400 (EDT)
Received: from phl-imap-01 ([10.202.2.91])
  by phl-compute-04.internal (MEProxy); Mon, 22 Sep 2025 01:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	colorremedies.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to; s=fm2; t=
	1758519386; x=1758605786; bh=mOdRaQug+su6LAgzLe+8KHtm10BEO8pMmL8
	0WJRU4HI=; b=AJpm1YNZvW/PphlKYbujsWkhFMijoLQ0PXu/lZpkpKIk04ZM6S4
	5aMX1CVv2GmPgsP/L1c/cbNxxkGeHk3E8FxqteYSdjETlAW4lx9sCetCPTarU6Po
	jyPY1lIPK/GlcPd3F+hh/2E4ilURB+8P89hwFLEqQjyxe7lkK3lvzVTvROzL824T
	tdV/P5OV4/g8DUQjgB7QuKSpefT6veyiLP/+yjKFFyyepn3qKmqhXpdilaCxR8/h
	dJ6vnVChSF4nvIZE3SxS5Ag8fSIFdemB7HWxUiuODU2Yt2Zs0f1uJ115f3O+qp1N
	rqWg+C1Dt5uHh12n49wO/NYj8PdDXigW4zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758519386; x=1758605786; bh=mOdRaQug+su6LAgzLe+8KHtm10BEO8pMmL8
	0WJRU4HI=; b=obtvDtGitVJwxOHq74IcKdOSs1RapRWPQb25gzApVJjEo6TR9YZ
	qMklrHeBW8qS1g24eiOw8RcBTA8jftGbzM2viwGJkzbzuglLXCWBVgE5ZOss7PRh
	z85O6tDTLRkkmWm3/RZp8VTl88s0VXXB3/cpGQ9xA4z7oOpFbUJPVHRFXUQiHvSN
	SdDIXcnYnE54OjW/FE8RChd0mXYxjkWKJSa+19NEGie+4wXgbuHPG5IkuS7Oqgwl
	oqBoiOEdYB8y1KgpTDZ/LTZ9fHgd8Vx6+NAm/RT4mi9t8qRPvXeBZG+erXiTB9bG
	uTR/iQarCY9MrT8ryIOoIhnb64onULDm6rA==
X-ME-Sender: <xms:WeDQaHyM6CsFwsdEBZ1Px_QsI8kY5CCs1Hk1Rt3HPMqcwfuiv2QsKQ>
    <xme:WeDQaPRUgfLf94LoGOwz7uh6lFdiy84KvHCLZwk4ZfoSvBR_p7oEC4-24xOpKcpuN
    TPO-n3U2cOAclT26MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjedtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkffutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhrhhishcuofhu
    rhhphhihfdcuoegthhhrihhssegtohhlohhrrhgvmhgvughivghsrdgtohhmqeenucggtf
    frrghtthgvrhhnpeejteejlefhledtgfdtgeejtdefleeugeduhfdujeegieetgedutdej
    keffteelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegthhhrihhssegtohhlohhrrhgvmhgvughivghsrdgtohhmpdhnsggprhgtphhtthho
    pedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WeDQaMpmc21wUxmDVzTSpoK2LVARfmyvMFfrVgsNxRDDPwmsvm85Nw>
    <xmx:WeDQaG412dcVA3TT0s81uaJGbTRQbkt9luhmdiZEmlXOUNfXl99D6Q>
    <xmx:WeDQaMOAj3Rw_gVGzE3l2K6W5ewLLXWCM4Yp22u5QKH4yVa2_KxvTQ>
    <xmx:WeDQaIMOjGuK5swVcnUuEcfbYuzrtGFzqPh6NvycKJwXc2gKuKokBg>
    <xmx:WuDQaLz8lmbMs05ekG4qdphx4LywtT0N_SapvARCgKSUmrN1h6ayFrSp>
Feedback-ID: i07814636:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D9F5318C0067; Mon, 22 Sep 2025 01:36:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Sep 2025 01:36:04 -0400
From: "Chris Murphy" <chris@colorremedies.com>
To: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
Message-Id: <8eb045b6-a621-4c72-9c9a-38da5029d499@app.fastmail.com>
Subject: init-csum-tree results in many extent tree problems
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

kernel 6.17.0-0.rc6.49.fc43.x86_64
btrfs-progs-6.16.1-1.fc43.x86_64

metadata and data are separate (not mixed bg) but both are DUP profile.

Small file system, scrub finds a file with csum issue with one file. Both mirrors affected *differently* which is strange but OK.  Btrfs check shows no problems. Btrfs check with check-data-csum  concurs with scrub, showing the same bytenr. Decide to init-csum-tree because I don't care about the affected file (samba.log) having 1 block with csum mismatch. After the init-csum-tree there are worse problems.

This file system doesn't need to be fixed or repaired - but seems like a useful bug report because it made things worse (or so it seems), so I'll keep it for a little while for further inspection.


root@fovo:~# btrfs check /dev/sda1
Opening filesystem to check...
Checking filesystem on /dev/sda1
UUID: 958beb6e-eadb-469f-9b33-a06db5a014e7
[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
[4/8] checking free space tree
[5/8] checking fs roots
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 520736768 bytes used, no error found
total csum bytes: 440832
total tree bytes: 8011776
total fs tree bytes: 6062080
total extent tree bytes: 1146880
btree space waste bytes: 2034263
file data blocks allocated: 3655413760
 referenced 956190720


root@fovo:~# btrfs check --check-data-csum /dev/sda1
Opening filesystem to check...
Checking filesystem on /dev/sda1
UUID: 958beb6e-eadb-469f-9b33-a06db5a014e7
[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
[4/8] checking free space tree
[5/8] checking fs roots
[6/8] checking csums against data
mirror 1 bytenr 13620559872 csum 0x388f70bc expected csum 0x8c76c28d
mirror 2 bytenr 13620559872 csum 0x5a4baf75 expected csum 0x8c76c28d
ERROR: errors found in csum tree
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 520736768 bytes used, error(s) found
total csum bytes: 440832
total tree bytes: 8011776
total fs tree bytes: 6062080
total extent tree bytes: 1146880
btree space waste bytes: 2034263
file data blocks allocated: 3655413760
 referenced 956190720


root@fovo:~# btrfs check --init-csum-tree /dev/sda1
Creating a new CRC tree
WARNING:

	Do not use --repair unless you are advised to do so by a developer
	or an experienced user, and then only after having accepted that no
	fsck can successfully repair all types of filesystem corruption. E.g.
	some software or hardware bugs can fatally damage a volume.
	The operation will start in 10 seconds.
	Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/sda1
UUID: 958beb6e-eadb-469f-9b33-a06db5a014e7
Reinitialize checksum tree
Fill checksum tree
[1/8] checking log skipped (none written)
[2/8] checking root items
Fixed 0 roots.
[3/8] checking extents
ref mismatch on [9159409664 16384] extent item 1, found 0
tree extent[9159409664, 16384] root 7 has no tree block found
incorrect global backref count on 9159409664 found 1 wanted 0
backpointer mismatch on [9159409664 16384]
owner ref check failed [9159409664 16384]
repair deleting extent record: key [9159409664,169,0]
Repaired extent references for 9159409664
ref mismatch on [9159426048 16384] extent item 1, found 0
tree extent[9159426048, 16384] root 7 has no tree block found
incorrect global backref count on 9159426048 found 1 wanted 0
backpointer mismatch on [9159426048 16384]
owner ref check failed [9159426048 16384]
repair deleting extent record: key [9159426048,169,0]
Repaired extent references for 9159426048
ref mismatch on [9159475200 16384] extent item 1, found 0
tree extent[9159475200, 16384] root 7 has no tree block found
incorrect global backref count on 9159475200 found 1 wanted 0
backpointer mismatch on [9159475200 16384]
owner ref check failed [9159475200 16384]
repair deleting extent record: key [9159475200,169,0]
Repaired extent references for 9159475200
ref mismatch on [9159491584 16384] extent item 1, found 0
tree extent[9159491584, 16384] root 7 has no tree block found
incorrect global backref count on 9159491584 found 1 wanted 0
backpointer mismatch on [9159491584 16384]
owner ref check failed [9159491584 16384]
repair deleting extent record: key [9159491584,169,0]
Repaired extent references for 9159491584
ref mismatch on [9159507968 16384] extent item 1, found 0
tree extent[9159507968, 16384] root 7 has no tree block found
incorrect global backref count on 9159507968 found 1 wanted 0
backpointer mismatch on [9159507968 16384]
owner ref check failed [9159507968 16384]
repair deleting extent record: key [9159507968,169,0]
Repaired extent references for 9159507968
ref mismatch on [9159524352 16384] extent item 1, found 0
tree extent[9159524352, 16384] root 7 has no tree block found
incorrect global backref count on 9159524352 found 1 wanted 0
backpointer mismatch on [9159524352 16384]
owner ref check failed [9159524352 16384]
repair deleting extent record: key [9159524352,169,0]
Repaired extent references for 9159524352
ref mismatch on [9159540736 16384] extent item 1, found 0
tree extent[9159540736, 16384] root 7 has no tree block found
incorrect global backref count on 9159540736 found 1 wanted 0
backpointer mismatch on [9159540736 16384]
owner ref check failed [9159540736 16384]
repair deleting extent record: key [9159540736,169,0]
Repaired extent references for 9159540736
ref mismatch on [9159573504 16384] extent item 1, found 0
tree extent[9159573504, 16384] root 7 has no tree block found
incorrect global backref count on 9159573504 found 1 wanted 0
backpointer mismatch on [9159573504 16384]
owner ref check failed [9159573504 16384]
repair deleting extent record: key [9159573504,169,0]
Repaired extent references for 9159573504
ref mismatch on [9159671808 16384] extent item 1, found 0
tree extent[9159671808, 16384] root 7 has no tree block found
incorrect global backref count on 9159671808 found 1 wanted 0
backpointer mismatch on [9159671808 16384]
owner ref check failed [9159671808 16384]
repair deleting extent record: key [9159671808,169,0]
Repaired extent references for 9159671808
ref mismatch on [9159704576 16384] extent item 1, found 0
tree extent[9159704576, 16384] root 7 has no tree block found
incorrect global backref count on 9159704576 found 1 wanted 0
backpointer mismatch on [9159704576 16384]
owner ref check failed [9159704576 16384]
repair deleting extent record: key [9159704576,169,0]
Repaired extent references for 9159704576
ref mismatch on [9161605120 16384] extent item 1, found 0
tree extent[9161605120, 16384] root 7 has no tree block found
incorrect global backref count on 9161605120 found 1 wanted 0
backpointer mismatch on [9161605120 16384]
owner ref check failed [9161605120 16384]
repair deleting extent record: key [9161605120,169,0]
Repaired extent references for 9161605120
ref mismatch on [9164095488 16384] extent item 1, found 0
tree extent[9164095488, 16384] root 7 has no tree block found
incorrect global backref count on 9164095488 found 1 wanted 0
backpointer mismatch on [9164095488 16384]
owner ref check failed [9164095488 16384]
repair deleting extent record: key [9164095488,169,0]
Repaired extent references for 9164095488
ref mismatch on [9164668928 16384] extent item 1, found 0
tree extent[9164668928, 16384] root 7 has no tree block found
incorrect global backref count on 9164668928 found 1 wanted 0
backpointer mismatch on [9164668928 16384]
owner ref check failed [9164668928 16384]
repair deleting extent record: key [9164668928,169,0]
Repaired extent references for 9164668928
ref mismatch on [9164734464 16384] extent item 1, found 0
tree extent[9164734464, 16384] root 7 has no tree block found
incorrect global backref count on 9164734464 found 1 wanted 0
backpointer mismatch on [9164734464 16384]
owner ref check failed [9164734464 16384]
repair deleting extent record: key [9164734464,169,0]
Repaired extent references for 9164734464
ref mismatch on [9164849152 16384] extent item 1, found 0
tree extent[9164849152, 16384] root 7 has no tree block found
incorrect global backref count on 9164849152 found 1 wanted 0
backpointer mismatch on [9164849152 16384]
owner ref check failed [9164849152 16384]
repair deleting extent record: key [9164849152,169,0]
Repaired extent references for 9164849152
ref mismatch on [9164865536 16384] extent item 1, found 0
tree extent[9164865536, 16384] root 7 has no tree block found
incorrect global backref count on 9164865536 found 1 wanted 0
backpointer mismatch on [9164865536 16384]
owner ref check failed [9164865536 16384]
repair deleting extent record: key [9164865536,169,0]
Repaired extent references for 9164865536
ref mismatch on [9164881920 16384] extent item 1, found 0
tree extent[9164881920, 16384] root 7 has no tree block found
incorrect global backref count on 9164881920 found 1 wanted 0
backpointer mismatch on [9164881920 16384]
owner ref check failed [9164881920 16384]
repair deleting extent record: key [9164881920,169,0]
Repaired extent references for 9164881920
ref mismatch on [9165193216 16384] extent item 1, found 0
tree extent[9165193216, 16384] root 7 has no tree block found
incorrect global backref count on 9165193216 found 1 wanted 0
backpointer mismatch on [9165193216 16384]
owner ref check failed [9165193216 16384]
repair deleting extent record: key [9165193216,169,0]
Repaired extent references for 9165193216
ref mismatch on [9165242368 16384] extent item 1, found 0
tree extent[9165242368, 16384] root 7 has no tree block found
incorrect global backref count on 9165242368 found 1 wanted 0
backpointer mismatch on [9165242368 16384]
owner ref check failed [9165242368 16384]
repair deleting extent record: key [9165242368,169,0]
Repaired extent references for 9165242368
ref mismatch on [9165275136 16384] extent item 1, found 0
tree extent[9165275136, 16384] root 7 has no tree block found
incorrect global backref count on 9165275136 found 1 wanted 0
backpointer mismatch on [9165275136 16384]
owner ref check failed [9165275136 16384]
repair deleting extent record: key [9165275136,169,0]
Repaired extent references for 9165275136
ref mismatch on [9165340672 16384] extent item 1, found 0
tree extent[9165340672, 16384] root 7 has no tree block found
incorrect global backref count on 9165340672 found 1 wanted 0
backpointer mismatch on [9165340672 16384]
owner ref check failed [9165340672 16384]
repair deleting extent record: key [9165340672,169,0]
Repaired extent references for 9165340672
ref mismatch on [9165438976 16384] extent item 1, found 0
tree extent[9165438976, 16384] root 7 has no tree block found
incorrect global backref count on 9165438976 found 1 wanted 0
backpointer mismatch on [9165438976 16384]
owner ref check failed [9165438976 16384]
repair deleting extent record: key [9165438976,169,0]
Repaired extent references for 9165438976
ref mismatch on [9165553664 16384] extent item 1, found 0
tree extent[9165553664, 16384] root 7 has no tree block found
incorrect global backref count on 9165553664 found 1 wanted 0
backpointer mismatch on [9165553664 16384]
owner ref check failed [9165553664 16384]
repair deleting extent record: key [9165553664,169,0]
Repaired extent references for 9165553664
ref mismatch on [9165586432 16384] extent item 1, found 0
tree extent[9165586432, 16384] root 7 has no tree block found
incorrect global backref count on 9165586432 found 1 wanted 0
backpointer mismatch on [9165586432 16384]
owner ref check failed [9165586432 16384]
repair deleting extent record: key [9165586432,169,0]
Repaired extent references for 9165586432
ref mismatch on [9165701120 16384] extent item 1, found 0
tree extent[9165701120, 16384] root 7 has no tree block found
incorrect global backref count on 9165701120 found 1 wanted 0
backpointer mismatch on [9165701120 16384]
owner ref check failed [9165701120 16384]
repair deleting extent record: key [9165701120,169,0]
Repaired extent references for 9165701120
ref mismatch on [9165717504 16384] extent item 1, found 0
tree extent[9165717504, 16384] root 7 has no tree block found
incorrect global backref count on 9165717504 found 1 wanted 0
backpointer mismatch on [9165717504 16384]
owner ref check failed [9165717504 16384]
repair deleting extent record: key [9165717504,169,0]
Repaired extent references for 9165717504
ref mismatch on [9165799424 16384] extent item 1, found 0
tree extent[9165799424, 16384] root 7 has no tree block found
incorrect global backref count on 9165799424 found 1 wanted 0
backpointer mismatch on [9165799424 16384]
owner ref check failed [9165799424 16384]
repair deleting extent record: key [9165799424,169,0]
Repaired extent references for 9165799424
metadata level mismatch on [9166143488, 16384]
ref mismatch on [9166143488 16384] extent item 1, found 0
tree extent[9166143488, 16384] root 7 has no tree block found
incorrect global backref count on 9166143488 found 1 wanted 0
backpointer mismatch on [9166143488 16384]
owner ref check failed [9166143488 16384]
repair deleting extent record: key [9166143488,169,1]
Repaired extent references for 9166143488
ref mismatch on [9166651392 16384] extent item 1, found 0
tree extent[9166651392, 16384] root 7 has no tree block found
incorrect global backref count on 9166651392 found 1 wanted 0
backpointer mismatch on [9166651392 16384]
owner ref check failed [9166651392 16384]
repair deleting extent record: key [9166651392,169,0]
Repaired extent references for 9166651392
ref mismatch on [9167028224 16384] extent item 1, found 0
tree extent[9167028224, 16384] root 7 has no tree block found
incorrect global backref count on 9167028224 found 1 wanted 0
backpointer mismatch on [9167028224 16384]
owner ref check failed [9167028224 16384]
repair deleting extent record: key [9167028224,169,0]
Repaired extent references for 9167028224
ref mismatch on [9167060992 16384] extent item 1, found 0
tree extent[9167060992, 16384] root 7 has no tree block found
incorrect global backref count on 9167060992 found 1 wanted 0
backpointer mismatch on [9167060992 16384]
owner ref check failed [9167060992 16384]
repair deleting extent record: key [9167060992,169,0]
Repaired extent references for 9167060992
ref mismatch on [9167912960 16384] extent item 1, found 0
tree extent[9167912960, 16384] root 7 has no tree block found
incorrect global backref count on 9167912960 found 1 wanted 0
backpointer mismatch on [9167912960 16384]
owner ref check failed [9167912960 16384]
repair deleting extent record: key [9167912960,169,0]
Repaired extent references for 9167912960
ref mismatch on [9168093184 16384] extent item 1, found 0
tree extent[9168093184, 16384] root 7 has no tree block found
incorrect global backref count on 9168093184 found 1 wanted 0
backpointer mismatch on [9168093184 16384]
owner ref check failed [9168093184 16384]
repair deleting extent record: key [9168093184,169,0]
Repaired extent references for 9168093184
ref mismatch on [9171910656 16384] extent item 1, found 0
tree extent[9171910656, 16384] root 7 has no tree block found
incorrect global backref count on 9171910656 found 1 wanted 0
backpointer mismatch on [9171910656 16384]
owner ref check failed [9171910656 16384]
repair deleting extent record: key [9171910656,169,0]
Repaired extent references for 9171910656
ref mismatch on [9177350144 16384] extent item 1, found 0
tree extent[9177350144, 16384] root 7 has no tree block found
incorrect global backref count on 9177350144 found 1 wanted 0
backpointer mismatch on [9177350144 16384]
owner ref check failed [9177350144 16384]
repair deleting extent record: key [9177350144,169,0]
Repaired extent references for 9177350144
ref mismatch on [12681756672 16384] extent item 1, found 0
tree extent[12681756672, 16384] root 7 has no tree block found
incorrect global backref count on 12681756672 found 1 wanted 0
backpointer mismatch on [12681756672 16384]
owner ref check failed [12681756672 16384]
repair deleting extent record: key [12681756672,169,0]
Repaired extent references for 12681756672
ref mismatch on [12682919936 16384] extent item 1, found 0
tree extent[12682919936, 16384] root 7 has no tree block found
incorrect global backref count on 12682919936 found 1 wanted 0
backpointer mismatch on [12682919936 16384]
owner ref check failed [12682919936 16384]
repair deleting extent record: key [12682919936,169,0]
Repaired extent references for 12682919936
ref mismatch on [12682936320 16384] extent item 1, found 0
tree extent[12682936320, 16384] root 7 has no tree block found
incorrect global backref count on 12682936320 found 1 wanted 0
backpointer mismatch on [12682936320 16384]
owner ref check failed [12682936320 16384]
repair deleting extent record: key [12682936320,169,0]
Repaired extent references for 12682936320
ref mismatch on [12684902400 16384] extent item 1, found 0
tree extent[12684902400, 16384] root 7 has no tree block found
incorrect global backref count on 12684902400 found 1 wanted 0
backpointer mismatch on [12684902400 16384]
owner ref check failed [12684902400 16384]
repair deleting extent record: key [12684902400,169,0]
Repaired extent references for 12684902400
ref mismatch on [12685279232 16384] extent item 1, found 0
tree extent[12685279232, 16384] root 7 has no tree block found
incorrect global backref count on 12685279232 found 1 wanted 0
backpointer mismatch on [12685279232 16384]
owner ref check failed [12685279232 16384]
repair deleting extent record: key [12685279232,169,0]
Repaired extent references for 12685279232
super bytes used 520687616 mismatches actual used 521342976
No device size related problem found
[4/8] checking free space tree
wanted bytes 950272, found 573440 for off 9158836224
cache appears valid but isn't 9157214208
wanted bytes 360448, found 147456 for off 12681609216
cache appears valid but isn't 12680429568
Clear free space cache v2
free space cache v2 cleared
[5/8] checking fs roots
Missing extent item in extent tree for disk_bytenr 13216854016, num_bytes 1150976
Missing extent item in extent tree for disk_bytenr 13023891456, num_bytes 1208320
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 1042030592 bytes used, no error found
total csum bytes: 886384
total tree bytes: 15925248
total fs tree bytes: 12124160
total extent tree bytes: 2293760
btree space waste bytes: 4037859
file data blocks allocated: 7310827520
 referenced 1912381440


root@fovo:~# btrfs check /dev/sda1
Opening filesystem to check...
Checking filesystem on /dev/sda1
UUID: 958beb6e-eadb-469f-9b33-a06db5a014e7
[1/8] checking log skipped (none written)
[2/8] checking root items
[3/8] checking extents
[4/8] checking free space tree
[5/8] checking fs roots
Missing extent item in extent tree for disk_bytenr 13216854016, num_bytes 1150976
Missing extent item in extent tree for disk_bytenr 13023891456, num_bytes 1208320
[6/8] checking only csums items (without verifying data)
[7/8] checking root refs
[8/8] checking quota groups skipped (not enabled on this FS)
found 520671232 bytes used, no error found
total csum bytes: 443192
total tree bytes: 7946240
total fs tree bytes: 6062080
total extent tree bytes: 1146880
btree space waste bytes: 2004460
file data blocks allocated: 3655413760
 referenced 956190720




--
Chris Murphy


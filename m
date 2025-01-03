Return-Path: <linux-btrfs+bounces-10704-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79189A00AFB
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 16:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2D83A4224
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 15:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDB71FA8F5;
	Fri,  3 Jan 2025 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dXEUXJzd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BB41B0F0A
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 15:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916565; cv=none; b=Nb9LdkKv5kXBYlzVne7TGVbBE7JECy/sAhd6PvAmnWDX4fLftrGAOjDSS5qNvf9sF6/cjb8xUy4Eg3tAs7diXIBP7VgpAOZBv1rHnE6QbVc7CSPFbG7PWogS1GytTs4XkD9ThkdhA8Tg+yVMc5IiWR1KZxL6dnxq5xdciAD6sso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916565; c=relaxed/simple;
	bh=GpZ8xC06ZbBsfoX/4KdSVipWPC8rkCodVOfd89bcyqM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jCrXCw6kwrpKqgwUMShImQyFEapK3uQZiTVECA5l6i/nE065VsRIkrX5d2Qeq0EcGHAJu0uMaEmJJvEwc8WvQSXCB+/ir2bS/gRXLuH1YsrFmmsHa+PbpIk6vUHizTvfCLjwWxn1Xf3gZZQvrLrEaJL3jv9VeRAs4ofISrPI2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=dXEUXJzd; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503F0cRV026329
	for <linux-btrfs@vger.kernel.org>; Fri, 3 Jan 2025 07:02:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=x/hxGO2bUBPF42nq9KPwLJl
	bU6S5SlNSAPHgYjPD5Ck=; b=dXEUXJzdF9g68JILWAsrEEXtkNOpjWLTvvL0JDi
	8U+RnBqH47DXHc6C80dJiMJAlu57OxmFX/LWG1NetWVvwmdKPCpaqvC92ccrISnf
	td17eJHXiXzWGPCC5uL50tfxdYL9Hp2OZL8StsjqpqlxdJlYj+hWXTW8jNS6efeg
	PtNY=
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43xf8f8vcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2025 07:02:42 -0800 (PST)
Received: from twshared3815.08.ash9.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 3 Jan 2025 15:02:41 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 641A7A240681; Fri,  3 Jan 2025 15:02:34 +0000 (GMT)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH v4 0/4] btrfs: fix reading from userspace in btrfs_uring_encoded_read()
Date: Fri, 3 Jan 2025 15:02:22 +0000
Message-ID: <20250103150233.2340306-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: QsO6OLwDDDbNTlBVPPbxcanu2LYZ788n
X-Proofpoint-GUID: QsO6OLwDDDbNTlBVPPbxcanu2LYZ788n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

Version 4 of mine and Jens' patches, to make sure that when our io_uring
function gets called a second time, it doesn't accidentally read
something from userspace that's gone out of scope or otherwise gotten
corrupted.

I sent a version 3 on December 17, but it looks like that got forgotten
about over Christmas (unsurprisingly). Version 4 fixes a problem that I
noticed, namely that we weren't taking a copy of the iovs, which also
necessitated creating a struct to store these things in. This does
simplify things by removing the need for the kmemdup, however.

I also have a patch for io_uring encoded writes ready to go, but it's
waiting on some of the stuff introduced here.

Jens Axboe (2):
  io_uring/cmd: rename struct uring_cache to io_uring_cmd_data
  io_uring/cmd: add per-op data to struct io_uring_cmd_data

Mark Harmstone (2):
  io_uring: add io_uring_cmd_get_async_data helper
  btrfs: don't read from userspace twice in btrfs_uring_encoded_read()

 fs/btrfs/ioctl.c             | 125 +++++++++++++++++++----------------
 include/linux/io_uring/cmd.h |  10 +++
 io_uring/io_uring.c          |   2 +-
 io_uring/opdef.c             |   3 +-
 io_uring/uring_cmd.c         |  23 +++++--
 io_uring/uring_cmd.h         |   4 --
 6 files changed, 97 insertions(+), 70 deletions(-)

--=20
2.45.2



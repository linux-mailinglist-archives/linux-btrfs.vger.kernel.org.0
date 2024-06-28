Return-Path: <linux-btrfs+bounces-6041-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 386F291C1F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 17:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7752834E7
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jun 2024 15:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130741CD5A7;
	Fri, 28 Jun 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IsNKkng+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBDE1C68A0
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586709; cv=none; b=E/acjMW4jmDbteThDb5JXE/g86hK2kDKm4qUPKHMdou1f2ayCw0EvBF/qkEKkXtLkPLpJVxUI6uffEo9nnx6TUQBxlHEyPiQ/Aab7DfIMMMN9ELtgkarbTHX+F+bH7IkW1Pz3ZoR4rYkqtwlaW/ZWdo4mEof2XcnXEOD8MrGzAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586709; c=relaxed/simple;
	bh=XO+Ubszo8euHYkiq4wwcSUgoXxSw3VcK3yUoqYnJ51o=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JBDwV8sGMZ0ylUT7nawftjtbB8HwxJZ85mRVQxM7qa+lSifiVZ0WLKlUS1+jnvyC5OZEVpohvqSGDFshds2H3FEXWTcYBoA+mmal+pG+i2eh6p+UpkRP7HYgpsg0/5/E2ajBMr4tNQY9UnHysnGmEsOzh6cBRsVD0mjAhivq69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=IsNKkng+; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SA2YbF010220
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 07:58:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=facebook; bh=8WMsxM99
	T1J3LOBPOBsy1wZySn6ER0Ae4GauWyUL4EM=; b=IsNKkng+qos8ZuxAUmXl8VYE
	x4kIr4ks1LvyoOJ/A/EBGUwe0o+NrHTB2KO3809L/Na5OGH2gEVIP8wIU4AMmBks
	pbWRZ0NpEtmQ5Ac3zNde8ldKmIujBK9fepoSGeopJ+QASV8yI5MzYx4Gjd6Sl8BW
	AQ8+mdqammIVBr3G5lk=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 401grkv7sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Jun 2024 07:58:26 -0700 (PDT)
Received: from twshared13822.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 28 Jun 2024 14:58:25 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 938CC3B266F1; Fri, 28 Jun 2024 15:58:13 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@meta.com>, Omar Sandoval <osandov@fb.com>
Subject: [PATCH 0/3] btrfs-progs: use libbtrfsutil for subvolume creation
Date: Fri, 28 Jun 2024 15:56:46 +0100
Message-ID: <20240628145807.1800474-1-maharmstone@fb.com>
X-Mailer: git-send-email 2.43.0
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -HOV6w3Z96NkUoNWfsawnkKP__lteigl
X-Proofpoint-ORIG-GUID: -HOV6w3Z96NkUoNWfsawnkKP__lteigl
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_10,2024-06-28_01,2024-05-17_01

From: Mark Harmstone <maharmstone@meta.com>

These patches are a resending of Omar Sandoval's patch from 2018, which
appears to have been overlooked [0], split up and rebased against the
current code.

We change btrfs subvol create and btrfs subvol snapshot so that they use
libbtrfsutil rather than calling the ioctl directly.

[0] https://lore.kernel.org/linux-btrfs/ab09ba595157b7fb6606814730508cae4da=
48caf.1516991902.git.osandov@fb.com/

Omar Sandoval (3):
  btrfs-progs: remove unused qgroup functions
  btrfs-progs: use libbtrfsutil for btrfs subvolume create
  btrfs-progs: use libbtrfsutil for btrfs subvolume snapshot

 cmds/qgroup.c    |  64 -------------
 cmds/qgroup.h    |   2 -
 cmds/subvolume.c | 227 ++++++++++++++++++-----------------------------
 3 files changed, 86 insertions(+), 207 deletions(-)

--=20
2.44.2



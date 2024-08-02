Return-Path: <linux-btrfs+bounces-6955-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E621945D3D
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 13:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26900B215E9
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2024 11:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DB11E2126;
	Fri,  2 Aug 2024 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="f9mmKhPt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654571DE871
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Aug 2024 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722598061; cv=none; b=O36S6npHoRTo5bxNWGLRDGzAR+WLk82M3TMnXroQSlTf1ekStbdDFc8AYG2mXsc0BLOdGFOucXYge7RVAOe3tnQpG3d69iyU4J3fMF0A4Q3Ad3q+H8ICXYvLn0NYO8mFtrTMyT4ym1FMbNpE7Y9ZdzBglX0w4Z1ojD2lbmE0kc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722598061; c=relaxed/simple;
	bh=3Ii1l8S7MwjsAzVtMbuDJu3Kji2XYdPtzkmQmacGAdY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cgjn4Km5B7dPA9x/nh7P9laSVe3GAjEcolknvbLl+YsgY2dlLdAPUJyxhulLhwVg3A9hsqh9CgCFe9wOSg8BwPSSwKi4HRxicz6AbGe9mpbtw7MAHPcX9ZxRyaD8j+kIgPTJoUyOmSfXZt0lTb0/VzsOXSDsbq4G24oEDZDkdIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=f9mmKhPt; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 472B3SGw024934
	for <linux-btrfs@vger.kernel.org>; Fri, 2 Aug 2024 04:27:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=facebook; bh=4a0FfByw
	wU7aivLBtj2FxygHHFjsKoV3ZE7RQYjiz9s=; b=f9mmKhPtIRt+7IYnPA0yK0xI
	cCHzgGhhiumxixKPCBUmE3iDdYSg2kpKMeWkkcj8gixmPJso6pPKDbS720rh/t/R
	iAZEhVUz4w32FLRrLB4IDveFBmMiidlwDqizGlg/8bhtleaLsXrJMbQON1QZNklf
	WR7XsfGD6RLz58ARyXs=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 40rjeym4e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Fri, 02 Aug 2024 04:27:38 -0700 (PDT)
Received: from twshared23930.07.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 2 Aug 2024 11:27:37 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id B2A904FE0C03; Fri,  2 Aug 2024 12:27:32 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH v2 0/3] btrfs-progs: use libbtrfsutil for subvolume creation
Date: Fri, 2 Aug 2024 12:27:21 +0100
Message-ID: <20240802112730.3575159-1-maharmstone@fb.com>
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
X-Proofpoint-GUID: SDCAJFbVUzs0WPCLfyhZOiFWiNbNYnJm
X-Proofpoint-ORIG-GUID: SDCAJFbVUzs0WPCLfyhZOiFWiNbNYnJm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_08,2024-08-01_01,2024-05-17_01

These patches are a resending of Omar Sandoval's patch from 2018, which
appears to have been overlooked [0], split up and rebased against the
current code.

We change btrfs subvol create and btrfs subvol snapshot so that they use
libbtrfsutil rather than calling the ioctl directly.

[0] https://lore.kernel.org/linux-btrfs/ab09ba595157b7fb6606814730508cae4=
da48caf.1516991902.git.osandov@fb.com/

Changelog:
* Fixed deprecated function names
* Fixed test failures (now returns correct return value on failure)
* Fixed this breaking fstest btrfs/300 (thanks Boris)

Mark Harmstone (3):
  btrfs-progs: use libbtrfsutil for btrfs subvolume create
  btrfs-progs: use libbtrfsutil for btrfs subvolume snapshot
  btrfs-progs: remove unused qgroup functions

 cmds/qgroup.c    |  64 ----------------
 cmds/qgroup.h    |   2 -
 cmds/subvolume.c | 194 +++++++++++++++++++----------------------------
 3 files changed, 76 insertions(+), 184 deletions(-)

--=20
2.44.2



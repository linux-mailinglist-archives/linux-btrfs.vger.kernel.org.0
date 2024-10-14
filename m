Return-Path: <linux-btrfs+bounces-8910-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08D399D574
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 19:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F407284B4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 17:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418AF1C3314;
	Mon, 14 Oct 2024 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KJAgfeC6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24311C3043
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926331; cv=none; b=YWE8UxtOgi0PPH1Sr+yCofqOcBFAJps0aweRR1exgdK2of/WcDP27JkQT/sDK0K/t9c88Rfl9/NO1A3a0YCDmWX79jsWIOa3UNfhlIaXPlLchog8N6xweidLRw4WNuPCriRQfswkI6Og5OFrE8pi9XWanJh1+pbQhxq9ZdlMJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926331; c=relaxed/simple;
	bh=VCgVUz/Cati/QVdcBwwnu7jUa79GXhANwhSx65+ufqU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W/HcET8fUnihcII1SPdoxEqhsmnKCWv379crk//AwM7QF1R2XXWOR7/DKSIlE2KGeGvnn6K8+GqbOaCsOpWxVsfT2lESA7NUdcfl5le1y7yYcq7FseiO6Ri6EDedFYXroUAfzw/2sL4TY6+U042iIyuUowWcEU0aHCLAaQaqIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=KJAgfeC6; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EFpshb005406
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 10:18:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=facebook; bh=yko252gGkhbcUWcqBiKIEpH
	mE656IkKgzIq3dx4I8yU=; b=KJAgfeC6jzVLD0XHf32xKx9RNvG3cYkQLlHFK9W
	coKh+ainxAONQl30r7rQqX9DyMyRGit8Yr9/U/ScbQdLMvVsuh9ynZT+W47hHVEg
	1kukHjuiNi3RUU+s3SMHpdyC6Guxt+zOzxhlm6IS3L1+JWwe50priDonB8uXuEb4
	fBx8=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 427re6te7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 10:18:49 -0700 (PDT)
Received: from twshared23455.15.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 14 Oct 2024 17:18:48 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 4D4DD7C37EF3; Mon, 14 Oct 2024 18:18:41 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH v3 0/5] btrfs: encoded reads via io_uring
Date: Mon, 14 Oct 2024 18:18:22 +0100
Message-ID: <20241014171838.304953-1-maharmstone@fb.com>
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
X-Proofpoint-ORIG-GUID: XSXK3xL7-M-TmyS_z7PcHkjNur6U79nv
X-Proofpoint-GUID: XSXK3xL7-M-TmyS_z7PcHkjNur6U79nv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

This is a re-do of my previous patchsets: I wasn't happy with how
synchronous the previous version was in many ways, nor quite how badly
it butchered the existing ioctl.

This adds an io_uring cmd to btrfs to match the behaviour of the
existing BTRFS_IOC_ENCODED_READ ioctl, which allows the reading of
potentially compressed extents directly from the disk.

Pavel mentioned on the previous patches whether we definitely need to
keep the inode and the extent locked while doing I/O; I think the answer
is probably yes, a) to prevent races with no-COW extents, and b) to
prevent the extent from being deallocated from under us. But I think
it's possible to resolve this, as a future optimization.

Mark Harmstone (5):
  btrfs: remove pointless addition in btrfs_encoded_read
  btrfs: change btrfs_encoded_read_regular_fill_pages to take a callback
  btrfs: change btrfs_encoded_read so that reading of extent is done by
    caller
  btrfs: add nowait parameter to btrfs_encoded_read
  btrfs: add io_uring command for encoded reads

 fs/btrfs/btrfs_inode.h |  23 ++-
 fs/btrfs/file.c        |   1 +
 fs/btrfs/inode.c       | 186 ++++++++++++++++--------
 fs/btrfs/ioctl.c       | 316 ++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/ioctl.h       |   1 +
 fs/btrfs/send.c        |  15 +-
 6 files changed, 476 insertions(+), 66 deletions(-)

--=20
2.44.2



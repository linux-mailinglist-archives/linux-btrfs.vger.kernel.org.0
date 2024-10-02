Return-Path: <linux-btrfs+bounces-8441-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 627B998E122
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 18:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144C21F2218E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 16:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7924D1D0F5A;
	Wed,  2 Oct 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TD18Ppdj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD704204F
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727887512; cv=none; b=SxCKvjBvI0YsdaaN4vxcYc735aLi9TUIPi2pcLFm9AVVf9LdRT6Nd4kvZKBZM4ihB7TbhIZ2G5SskM2Cimr4g/2H6i3eiPDxPqVHbGbaeftRVSftBZzPgjT51lAKmLWlOb9+A+PCbRN9XgAay5mWK7FamRixKV35BttW7UY/2Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727887512; c=relaxed/simple;
	bh=AzRB4nErVFgHE7LD/JH487Pw3WoLGeUCIi5vGw+hAm8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UKEDqztXUJn0Z5brBgTzo4/oJKn9t7ZYyGvI0jLkMxLpxuUq6BtjARa5meN8sJG9kK6s74YYkGHZsr/3/+DQdrj6Zt2WEPr4VHODPpBaQaQwcBbZWJfqWUKyaC4T+t3x30F9dkmovFJXpflRzN+Gpk2sVxgzJPNhU2se6/lZDuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b=TD18Ppdj; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492FToxx001810
	for <linux-btrfs@vger.kernel.org>; Wed, 2 Oct 2024 09:45:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=facebook; bh=GdjVAOQ3
	REhlqfH6cxT3YIA4i0ty4ZkaTBJO1icbgUo=; b=TD18Ppdj2PaEaHekIImq7WtE
	fhqddWCaeQbQoYNbapcdRU/LH6PIxjh0rEOLAqKvUSrjZNhghwY+dn3PV7qeKIbP
	Z6To1b8IvbI2oO8KlNfeEOZ/8gNM6LYY17nfoQL/hEtSwHwAr7RaUKJ1IDJop53V
	JL/FWHhRSOE5C5VccD0=
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42163x1p1u-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2024 09:45:09 -0700 (PDT)
Received: from twshared16035.07.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 2 Oct 2024 16:45:08 +0000
Received: by devbig276.nha1.facebook.com (Postfix, from userid 660015)
	id 3C421756BCD4; Wed,  2 Oct 2024 17:45:04 +0100 (BST)
From: Mark Harmstone <maharmstone@fb.com>
To: <linux-btrfs@vger.kernel.org>
CC: Mark Harmstone <maharmstone@fb.com>
Subject: [PATCH] btrfs: fix comments in definition of struct btrfs_file_extent_item
Date: Wed, 2 Oct 2024 17:44:45 +0100
Message-ID: <20241002164500.2775775-1-maharmstone@fb.com>
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
X-Proofpoint-GUID: ZMsnoJsjN1oR9yVPtG4ztKBE_PL4pIOc
X-Proofpoint-ORIG-GUID: ZMsnoJsjN1oR9yVPtG4ztKBE_PL4pIOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_17,2024-09-30_01,2024-09-30_01

The comments in the definition of struct btrfs_file_extent_item were
written while the FS was still in flux, and are no longer accurate.

The range [disk_bytenr, disk_num_bytes) is the same as the extent in the
extent tree. There's no difference here between csummed and non-csummed
extents, as the comments were implying. And the fields offset and
num_bytes are in bytes, not file blocks.

Signed-off-by: Mark Harmstone <maharmstone@fb.com>
---
 include/uapi/linux/btrfs_tree.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_t=
ree.h
index fc29d273845d..5df54a11c74c 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -1094,24 +1094,23 @@ struct btrfs_file_extent_item {
 	__u8 type;
=20
 	/*
-	 * disk space consumed by the extent, checksum blocks are included
-	 * in these numbers
+	 * The address and size of the referenced extent.  These should exactly
+	 * match an entry in the extent tree.
 	 *
 	 * At this offset in the structure, the inline extent data start.
 	 */
 	__le64 disk_bytenr;
 	__le64 disk_num_bytes;
 	/*
-	 * the logical offset in file blocks (no csums)
-	 * this extent record is for.  This allows a file extent to point
-	 * into the middle of an existing extent on disk, sharing it
-	 * between two snapshots (useful if some bytes in the middle of the
-	 * extent have changed
+	 * The logical offset in bytes this extent record is for.
+	 * This allows a file extent to point into the middle of an existing
+	 * extent on disk, sharing it between two snapshots (useful if some
+	 * bytes in the middle of the extent have changed)
 	 */
 	__le64 offset;
 	/*
-	 * the logical number of file blocks (no csums included).  This
-	 * always reflects the size uncompressed and without encoding.
+	 * The logical number of bytes.  This always reflects the size
+	 * uncompressed and without encoding.
 	 */
 	__le64 num_bytes;
=20
--=20
2.44.2



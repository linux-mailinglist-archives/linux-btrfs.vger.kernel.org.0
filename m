Return-Path: <linux-btrfs+bounces-10321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6602D9EE80D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 14:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BA81888F1F
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF3F213E97;
	Thu, 12 Dec 2024 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H//6lShw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96081F37A7;
	Thu, 12 Dec 2024 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734011411; cv=none; b=f+IVzel54lrAc03OlPQwq8q/IbyhkhiAiugqr6C2n0yCT+GqBhW/JDxOE6QffzvjtoY/Vey5ofOZJAVp4DXfZG68ATXktJUmKLHDPCsRUNYv4+MTCwaWlL4UBGepoFgyI/xV1c1KVW9L69+WCLH2wiDzbdBk4sfipwoc42qSjsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734011411; c=relaxed/simple;
	bh=2I+v4Av3PKtqFWbKALkbMXs3AKM5H21rbNE9smYARM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGOXw6ycu1gAsfvwC8YM0HRlC2OAONpvvhPk7XsZOh1pEFwOXyTn7UG3tr4nTKkiWVdEERK60/foiyQRP2G22IYWQPoNhPvSkZeTawqn8vz31YnwghDWMQDgex8qFly5fiqo0z+S0ZiQiuYYKOUV27hG0T1jQ06L4NpXOSj6tBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H//6lShw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7TUno029600;
	Thu, 12 Dec 2024 13:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pviqLTYdIKFGw7Fbyr5/B7TlIVvzxzq9ndJzPzhqH
	tU=; b=H//6lShwN9P/rph+9w2IKAVx4aGjgSSviJ55+yPFGlLWHID4FQE72JeFL
	LC8XJS9V2G1sQ9GhxPT7MHhrpcrwsKu2+bCrnak/zpsnV2qu4QDY3vXEF2hLmeRy
	XpSixho/kS6CkRU6g5hjMjOUtCWYPZ6SS68n5twWTyg439ppIIc+5NUULr4/xMfg
	RXE1EnV2GUEvhLkydwyhw6wLlcaIRmKEPFdJtF0MW3tVUD6KfuxdwtgIBfGOn5qL
	C7PViKRpnDNJbQs16ZPcwfwFgFCd/zsJk01b5t9r27jbpB0vZmgKczS4xcgHHb4R
	WhN+z7q2M809lIowjNB12o7PP9PJw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ccsjua9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 13:50:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCCGikr007865;
	Thu, 12 Dec 2024 13:50:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ft11t6h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 13:50:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BCDo0xA19857744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 13:50:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A184C20065;
	Thu, 12 Dec 2024 13:50:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 716D220063;
	Thu, 12 Dec 2024 13:50:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Dec 2024 13:50:00 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.cz>,
        linux-btrfs@vger.kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH] btrfs: Fix avail_in bytes for s390 zlib HW compression path
Date: Thu, 12 Dec 2024 14:50:00 +0100
Message-ID: <20241212135000.1926110-1-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VRiEwnmexwgtlC8v98iWQ8vCyDdX_hw3
X-Proofpoint-ORIG-GUID: VRiEwnmexwgtlC8v98iWQ8vCyDdX_hw3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412120093

Since the input data length passed to zlib_compress_folios() can be
arbitrary, always setting strm.avail_in to a multiple of PAGE_SIZE may
cause read-in bytes to exceed the input range. Currently this triggers
an assert in btrfs_compress_folios() on the debug kernel. But it may
potentially lead to data corruption.
Fix strm.avail_in calculation for S390 hardware acceleration path.

Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Fixes: fd1e75d0105d ("btrfs: make compression path to be subpage compatible")
---
 fs/btrfs/zlib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index ddf0d5a448a7..c9e92c6941ec 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -174,10 +174,10 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
 					copy_page(workspace->buf + i * PAGE_SIZE,
 						  data_in);
 					start += PAGE_SIZE;
-					workspace->strm.avail_in =
-						(in_buf_folios << PAGE_SHIFT);
 				}
 				workspace->strm.next_in = workspace->buf;
+				workspace->strm.avail_in = min(bytes_left,
+							       in_buf_folios << PAGE_SHIFT);
 			} else {
 				unsigned int pg_off;
 				unsigned int cur_len;
-- 
2.47.1



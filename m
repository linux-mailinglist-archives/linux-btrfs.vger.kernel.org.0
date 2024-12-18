Return-Path: <linux-btrfs+bounces-10551-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8409F633D
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 11:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22658188D763
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8E3199EB0;
	Wed, 18 Dec 2024 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ol5qgh78"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF06192B94;
	Wed, 18 Dec 2024 10:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517985; cv=none; b=J+JSgWDHeRdHNrLc5IjF655k8QFfGx9WwwAHyoMJbp6NaTitFmHf2HkRoLDmUSj3D+uuMPhw8Zwr4OWiOI/klMhejkK2+iAw3hgv6LCy1NVPd99jqkWHc1DeRTj9SAfrYdKGGW4HF8sXmNnygYD5Lvtphqfo1QMnRwAHiKQGkzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517985; c=relaxed/simple;
	bh=c5Uy1OydmqKjACvTX6VTVEgbiYrqyiypbgaMgDX27nI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SCvNHaCaX9chBKZa++vOTLxWOevc4KO1+qX9rPYUDAmQSm0LwmDYToYIS5s1Z0WeYkOrZ1jPiIBDosHTi39e841oibNokwr8r03v6Jznd77QRYb3NH6/VRIEi+X2/LgSFeGbvrFfY6+YO1ZqpnJ+g3QUUrE2J4XEWwX0qDUA24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ol5qgh78; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI85ejZ026872;
	Wed, 18 Dec 2024 10:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=D95hDIqy2TzdDmcchXwrGfN7XvooHZqCScoDnrrR6
	YY=; b=ol5qgh78M8WltY0Jx/ymGIcIoTtB9pz+vcRbjtpJHQzX2Y3jpPpQqio0R
	v0etb2GqWCcvog6a4gkrI+Z6GyPetVULCB1Ew2RZw7+fwYagjeNlNDgIhx01wvUN
	ioIUeGyRhSAfuve9Cqz9vFQEzdi+f/5WEoWyEgbPKxM6BUwvwNF/XE0caS3slrHx
	ghwrPqfXYUMfQw51l5p5aWkflifzpVyGzucCRD1JDL1J0Zj+9gSYrphIF+xNRUBC
	bPXuFNeSETkQ+tl62ial5oBz/nVPX8qrcZWi7pkDbMmvpI0tOuFrFKKQ6Fx1nra4
	8KM9G6XagSnB/+Jm1zxjL+9X8CXYA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ktk2gmja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:32:57 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI8rSP7024044;
	Wed, 18 Dec 2024 10:32:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnukfa2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 10:32:57 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BIAWqdd46924104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Dec 2024 10:32:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F265B2004B;
	Wed, 18 Dec 2024 10:32:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C934420043;
	Wed, 18 Dec 2024 10:32:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Dec 2024 10:32:51 +0000 (GMT)
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>, linux-btrfs@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH v2] btrfs: Fix avail_in bytes for s390 zlib HW compression path
Date: Wed, 18 Dec 2024 11:32:51 +0100
Message-ID: <20241218103251.3753503-1-zaslonko@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HXF_0mKXlQDXQa1L0evxHAIRp-MDO9bC
X-Proofpoint-ORIG-GUID: HXF_0mKXlQDXQa1L0evxHAIRp-MDO9bC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 impostorscore=0 clxscore=1011 mlxlogscore=999 adultscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180084

Since the input data length passed to zlib_compress_folios() can be
arbitrary, always setting strm.avail_in to a multiple of PAGE_SIZE may
cause read-in bytes to exceed the input range. Currently this triggers
an assert in btrfs_compress_folios() on the debug kernel (see below).
Fix strm.avail_in calculation for S390 hardware acceleration path.

 assertion failed: *total_in <= orig_len, in fs/btrfs/compression.c:1041
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/compression.c:1041!
 monitor event: 0040 ilc:2 [#1] PREEMPT SMP
 CPU: 16 UID: 0 PID: 325 Comm: kworker/u273:3 Not tainted 6.13.0-20241204.rc1.git6.fae3b21430ca.300.fc41.s390x+debug #1
 Hardware name: IBM 3931 A01 703 (z/VM 7.4.0)
 Workqueue: btrfs-delalloc btrfs_work_helper
 Krnl PSW : 0704d00180000000 0000021761df6538 (btrfs_compress_folios+0x198/0x1a0)
            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
 Krnl GPRS: 0000000080000000 0000000000000001 0000000000000047 0000000000000000
            0000000000000006 ffffff01757bb000 000001976232fcc0 000000000000130c
            000001976232fcd0 000001976232fcc8 00000118ff4a0e30 0000000000000001
            00000111821ab400 0000011100000000 0000021761df6534 000001976232fb58
 Krnl Code: 0000021761df6528: c020006f5ef4        larl    %r2,0000021762be2310
            0000021761df652e: c0e5ffbd09d5        brasl   %r14,00000217615978d8
           #0000021761df6534: af000000            mc      0,0
           >0000021761df6538: 0707                bcr     0,%r7
            0000021761df653a: 0707                bcr     0,%r7
            0000021761df653c: 0707                bcr     0,%r7
            0000021761df653e: 0707                bcr     0,%r7
            0000021761df6540: c004004bb7ec        brcl    0,000002176276d518
 Call Trace:
  [<0000021761df6538>] btrfs_compress_folios+0x198/0x1a0
 ([<0000021761df6534>] btrfs_compress_folios+0x194/0x1a0)
  [<0000021761d97788>] compress_file_range+0x3b8/0x6d0
  [<0000021761dcee7c>] btrfs_work_helper+0x10c/0x160
  [<0000021761645760>] process_one_work+0x2b0/0x5d0
  [<000002176164637e>] worker_thread+0x20e/0x3e0
  [<000002176165221a>] kthread+0x15a/0x170
  [<00000217615b859c>] __ret_from_fork+0x3c/0x60
  [<00000217626e72d2>] ret_from_fork+0xa/0x38
 INFO: lockdep is turned off.
 Last Breaking-Event-Address:
  [<0000021761597924>] _printk+0x4c/0x58
 Kernel panic - not syncing: Fatal exception: panic_on_oops

Fixes: fd1e75d0105d ("btrfs: make compression path to be subpage compatible")
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/zlib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Changes since v1
----------------
Call Trace added to the commit message 

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
2.45.2



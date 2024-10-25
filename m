Return-Path: <linux-btrfs+bounces-9153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5309AF75C
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 04:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272BE1F22CED
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 02:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C529913B294;
	Fri, 25 Oct 2024 02:24:05 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA279C8;
	Fri, 25 Oct 2024 02:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729823045; cv=none; b=FZFd55kGtlaTbfMsOPseRTCLSkPyQXLziJ85HLVLwdXeeWriiT8+7vMMR7rJ0PgxN0NTAWFrGKiF3NaitvefewK24lI8eOubG1xvYhCGFX0/2v6LYsYqdGBzCzGF5Sx9Q5wWk2hHeRdv4h9ENowO0hjigebYDOiQ/pLMAMki/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729823045; c=relaxed/simple;
	bh=l1qhUpsRfILc9gua6QCYo1/17WafQYRrt8hOzFiHIlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9/o2+dRzUFB6XBPqjbqE/24xa73b+DjxpH16ugR35Wvejud3TaY0XlA2E5gius2Ej9EDNJCxUtDZFlNqtCCiLMEEmO+tmM32CC4+OPH54kxQoMwpzQCz8sCq57Xhn2QX7Bqi8hZ0NrVbryJ3XMd0uWxkAIAVnuoO6j3xUSdoH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P0sMo8023119;
	Fri, 25 Oct 2024 02:23:52 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42f2g427y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 25 Oct 2024 02:23:52 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 19:23:51 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 19:23:49 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com>
CC: <clm@fb.com>, <dsterba@suse.com>, <josef@toxicpanda.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_search_slot
Date: Fri, 25 Oct 2024 10:23:48 +0800
Message-ID: <20241025022348.1255662-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6719c407.050a0220.10f4f4.01dc.GAE@google.com>
References: <6719c407.050a0220.10f4f4.01dc.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0CSmBXtuyEYCu_yM1qlq9IXqmwVwLZaM
X-Proofpoint-GUID: 0CSmBXtuyEYCu_yM1qlq9IXqmwVwLZaM
X-Authority-Analysis: v=2.4 cv=eoKNzZpX c=1 sm=1 tr=0 ts=671b0138 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=DAUX931o1VcA:10 a=g5S_A3WLY7ZMYIQGvTMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_02,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 bulkscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=721 spamscore=0 impostorscore=0 mlxscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410250017

use the input logical can't find the extent root, so add sanity check for
extent root before search slot.

#syz test

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index f8e1d5b2c512..87eaf5dd2d5d 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2213,6 +2213,9 @@ int extent_from_logical(struct btrfs_fs_info *fs_info, u64 logical,
 	key.objectid = logical;
 	key.offset = (u64)-1;
 
+	if (!extent_root)
+		return -ENOENT;
+
 	ret = btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
 	if (ret < 0)
 		return ret;


Return-Path: <linux-btrfs+bounces-9156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB8C9AF8F2
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 06:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F92C2825C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2024 04:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F5818C92B;
	Fri, 25 Oct 2024 04:39:12 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BE62C9A;
	Fri, 25 Oct 2024 04:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729831152; cv=none; b=tCNUKsZpI/mwckl5Hstd6TdqXt2mCQIJwtKQdQGPmN9qGjRvN5RplkUoL2iwHcx53+ia/JGRXgmFUS3irUfEK27za8HkHK5aCKQluYrF4hlbJtmEN4wrKfbq7BA/IGoWno2egDL/A1rcvDjmD9IJIXr5UR2xV1qpR68MW6/4LZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729831152; c=relaxed/simple;
	bh=raW+W/VdgdPktHDQqdkBZTpz4mAfcySaCUgn3Uv2FLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+Hpnp6gLCd6IQwRW6L7g4hX74Ub74JJvYvwG3XU3Ap1PqcNG9zO3zA6q8jT1OL8mZ68Wra5+QzZaJkaSqUOPfBO36846uE+cHA33bW/ES3+/KthbSvXH07w8n4iO4RG6LP8zeWefqesZ7vnejQhGSCMkqVUDiYZdpFkRrOVs64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P4M3XQ026415;
	Thu, 24 Oct 2024 21:38:53 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42c823yfr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 24 Oct 2024 21:38:52 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Oct 2024 21:38:52 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Thu, 24 Oct 2024 21:38:49 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <quwenruo.btrfs@gmx.com>
CC: <clm@fb.com>, <dsterba@suse.com>, <josef@toxicpanda.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lizhi.xu@windriver.com>,
        <syzbot+3030e17bd57a73d39bd7@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-use-after-free Read in bch2_reconstruct_alloc
Date: Fri, 25 Oct 2024 12:38:48 +0800
Message-ID: <20241025043848.1981317-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7f0a7b2d-369c-42ae-9054-7436bc98f7c1@gmx.com>
References: <7f0a7b2d-369c-42ae-9054-7436bc98f7c1@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=UrgxNPwB c=1 sm=1 tr=0 ts=671b20dc cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=DAUX931o1VcA:10 a=5ZRsO0AxQ23dNSJGzhEA:9
X-Proofpoint-ORIG-GUID: 7S4qNboe3fPfI-hMlC1YEehRzfULkObE
X-Proofpoint-GUID: 7S4qNboe3fPfI-hMlC1YEehRzfULkObE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_03,2024-10-24_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1011 adultscore=0 mlxlogscore=640
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 suspectscore=0
 phishscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2409260000 definitions=main-2410250032

On Fri, 25 Oct 2024 14:49:48 +1030, Qu Wenruo wrote:
> > use the input logical can't find the extent root, so add sanity check for
> > extent root before search slot.
> >
> > #syz test
> >
> > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > index f8e1d5b2c512..87eaf5dd2d5d 100644
> > --- a/fs/btrfs/backref.c
> > +++ b/fs/btrfs/backref.c
> > @@ -2213,6 +2213,9 @@ int extent_from_logical(struct btrfs_fs_info *fs_info, u64 logical,
> >       key.objectid = logical;
> >       key.offset = (u64)-1;
> >
> > +     if (!extent_root)
> > +             return -ENOENT;
> 
> Considering we have a lot of such btrfs_search_slot() without checking
> if the csum/extent root is NULL, can we move the check into
> btrfs_search_slot()?
Yes, judging in btrfs_search_slot can fix the current issue while also
avoiding similar problems.

#syz test

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 0cc919d15b14..9c05cab473f5 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2010,7 +2010,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		      const struct btrfs_key *key, struct btrfs_path *p,
 		      int ins_len, int cow)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
+	struct btrfs_fs_info *fs_info;
 	struct extent_buffer *b;
 	int slot;
 	int ret;
@@ -2023,6 +2023,10 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	int min_write_lock_level;
 	int prev_cmp;
 
+	if (!root)
+		return -EINVAL;
+
+	fs_info = root->fs_info;
 	might_sleep();
 
 	lowest_level = p->lowest_level;


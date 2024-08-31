Return-Path: <linux-btrfs+bounces-7707-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A58967199
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Aug 2024 14:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E36B20F1A
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Aug 2024 12:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F9417F4EC;
	Sat, 31 Aug 2024 12:42:01 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E9C42A9B;
	Sat, 31 Aug 2024 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725108121; cv=none; b=T5Cpfwv2rlIvvLAFJQ9hylsE/qxidcV+3mKJvWgtAHul72+4g7JKf6y79UnhVZrgSm0Ww48aaj1dPkaEF7BF5/so0tKHGsz/S8a72RuKaqb0Bpxfc272xyp4TGk32nPH3yBHkrDuDBx7ReVjzXLvb88YhSML9JTtutp9QF41YYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725108121; c=relaxed/simple;
	bh=hgqNuRNNLmJqkHbMU+uEJW1Tq28sul8/fyWaNX8wOrY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AyiLTfCoS/9kW4yFyyh8NKkI1jilUqQ2tS0M8/0zn5/9Mhd5DX69qRt6dbBOAUzraAOdCL3HN+9hcA8LLTtcy0Vpaq1bbDaZ1z/7vsG+5Jmk7LkT/Agms5Ew3ooPm1VvEC72LdOK3fkswIcYSbvIicitISYG0lAsj/Qr1tk5e84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47VCdiNo031781;
	Sat, 31 Aug 2024 05:41:45 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41c2pkg0ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 31 Aug 2024 05:41:44 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 31 Aug 2024 05:41:44 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sat, 31 Aug 2024 05:41:42 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <fdmanana@kernel.org>
CC: <clm@fb.com>, <dsterba@suse.com>, <josef@toxicpanda.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lizhi.xu@windriver.com>,
        <syzbot+4704b3cc972bd76024f1@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] btrfs: Add assert or condition
Date: Sat, 31 Aug 2024 20:41:41 +0800
Message-ID: <20240831124141.11022-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAL3q7H5p4vmBs-ES08dkY7z4sjE_k3970CkJRAjiy0MhpXjYWw@mail.gmail.com>
References: <CAL3q7H5p4vmBs-ES08dkY7z4sjE_k3970CkJRAjiy0MhpXjYWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=c+X5Qg9l c=1 sm=1 tr=0 ts=66d30f89 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=yoJbH4e0A30A:10 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=0qqOrUru9Iw2tnRzv3oA:9 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: CCYVnYbprWFbfOchVpEgVU2tgR651CNm
X-Proofpoint-GUID: CCYVnYbprWFbfOchVpEgVU2tgR651CNm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-31_02,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=512
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2407110000
 definitions=main-2408310105

On Sat, 31 Aug 2024 11:55:53 +0100, Filipe Manana wrote:
> > -       ASSERT(inode_is_locked(&inode->vfs_inode));
> > +       ASSERT(inode_is_locked(&inode->vfs_inode) ||
> > +              rwsem_is_locked(&inode->i_mmap_lock));
> 
> This definitely fixes the syzbot report, in the sense the assertion
> won't fail anymore.
> But it's wrong, very, very, very, very wrong.
> 
> The inode must be locked during the course of the fsync, that's why
> the assertion is there.
> 
> Why do you think it's ok to not have the inode locked?
> Have you done any analysis about that?
> 
> You mention "fsync_skip_inode_lock is true" in the changelog, but have
> you checked where and why it's set to true?
> 
> Where we set it to true, at btrfs_direct_write(), there's a comment
> which explains it's to avoid a deadlock on the inode lock at
> btrfs_sync_file().
> 
> This is a perfect example of trying a patch not only without having
> any idea how the code works but also being very lazy,
> as there's a very explicit comment in the code about why the variable
> is set to true, and even much more detailed in the
> change log of the commit that introduced it.
> 
> And btw, there's already a patch to fix this issue:
> 
> https://lore.kernel.org/linux-btrfs/717029440fe379747b9548a9c91eb7801bc5a813.1724972507.git.fdmanana@suse.com/
In your patch, I get what the mean of fsync_skip_inode_lock.

Thanks.


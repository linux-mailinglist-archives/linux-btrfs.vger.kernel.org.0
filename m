Return-Path: <linux-btrfs+bounces-10685-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BDB9FF79B
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 10:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE7A3A2ABC
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 09:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F8C1A08A6;
	Thu,  2 Jan 2025 09:45:46 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9119CC1C;
	Thu,  2 Jan 2025 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735811146; cv=none; b=PQdPYfI1IwrAxH9Gcp11imjW+RE3P7JuaL/x/QxmTZAWb1z2P/ikWTLblOi6xOEeTKgoMxdPMJn6NtWDtzI5DUJk8QG5mdt6n5dA0Ozhg/NV8biZotMrghGDGwK29zRJpju3oouCdQSoUMv24STHrmU+xiRtGMo6o0syyXd7Grg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735811146; c=relaxed/simple;
	bh=85DdWgyvV/gDQ8tT264cpXCK6CwSZlxz34uIirTBmkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMm1Qbv3y+6/MAxXJMCM+R6xpURpKbis3lz+ei9Zc4pW/QEcJFLUcQJgShrOi8m2WXPa28zCR9tIl5tt5YYAgnpekyas0NzjzaR10BwqyborVuVw2no1xDPb8mXOs/2AV468XE3vav0mh3krCbaKY/QfAwYXo7xdjtehMZquirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50295gea028257;
	Thu, 2 Jan 2025 09:45:36 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43t8a83wnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 02 Jan 2025 09:45:36 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 2 Jan 2025 01:45:34 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 2 Jan 2025 01:45:32 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <quwenruo.btrfs@gmx.com>
CC: <clm@fb.com>, <dsterba@suse.com>, <josef@toxicpanda.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lizhi.xu@windriver.com>,
        <syzbot+339e9dbe3a2ca419b85d@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V2] btrfs: btrfs can not be mounted with corrupted extent root
Date: Thu, 2 Jan 2025 17:45:31 +0800
Message-ID: <20250102094531.272226-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <de8702eb-b800-48bb-ab56-ce4f048c755c@gmx.com>
References: <de8702eb-b800-48bb-ab56-ce4f048c755c@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: vJLlSvcpF6Od_O4MeFJynpacp4Ch7DPO
X-Proofpoint-ORIG-GUID: vJLlSvcpF6Od_O4MeFJynpacp4Ch7DPO
X-Authority-Analysis: v=2.4 cv=f8qyBPyM c=1 sm=1 tr=0 ts=67766040 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=VdSt8ZQiCzkA:10 a=ADZqV38ZqapEVVttSm4A:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxlogscore=698 lowpriorityscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2501020083

On Thu, 2 Jan 2025 18:51:34 +1030, Qu Wenruo wrote:
> > syzbot reported a null-ptr-deref in find_first_extent_item. [1]
> >
> > The btrfs filesystem did not successfully initialize extent root to the
> > global root tree when mounted(as the mount options contain ignorebadroots),
> > this is because extent buffer is not uptodate,
> 
> The "not uptodate" is only the symptom, if you check the console output
> carefully enough, it's because the extent tree root (and must be extent
> tree root, any child node won't cause problem) is corrupted (csum mismatch).
> 
[   35.752834][ T3330] BTRFS warning (device loop0): checksum verify failed on logical 5337088 mirror 1 wanted 0x324c5e2d0cac2dc8f61cbfdfc8cd69d9816061b1498b9e1bff0
According to the above log, it is clear that the failure of btrfs_validate_extent_buffer()
causes the extent buffer to be not uptodate, and it can be judged that extent root is corrupted.

BR,
Lizhi


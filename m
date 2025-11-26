Return-Path: <linux-btrfs+bounces-19357-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 645A6C898AD
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 12:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B0BB4E2E55
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Nov 2025 11:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A063242BC;
	Wed, 26 Nov 2025 11:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lWiSsHpD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A52F83CB;
	Wed, 26 Nov 2025 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764156915; cv=none; b=YSErpRXO32R2OOIlRM1wy/gZ+NWM/ehPWMuDbb5JfcxEEZWASMDiZcPNOVFnU8xfqzxDFNeNHOG+XXyHE24JPW551Wuvgx2J4L/w2iBUlfRDCnTrQTyXgISDz6rvrffUQwpPd7HpeNGDnQ5xU9U6fYElODjAuohx2oV6EoTWfs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764156915; c=relaxed/simple;
	bh=n7d2rN4iFOONwjEwN9OQfpTg7hn6MKQsB7F1ImgX3S0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLyP9hcK8HWHza/HQG8HwpGhIkIu3qKqVjgKmfYE/F6r/KpNEtBgM0pwAn4M5yMDlVIw4xWtA7ZIkx/dKs4H/soRNIUhGmWdUfChdBkzDe8AZMLj7JgyqiypBQsqRmeCGFbyGPm+oaXi3ZQfxQlfh4GBkAsmSl640xKS4+jFdAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lWiSsHpD; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQAT2Pm1478413;
	Wed, 26 Nov 2025 11:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=ETgU1N4nIT4VZCeoj5mxwESuIUQqB
	lKMoFTerTF+aQ4=; b=lWiSsHpD4VDKDjPHaXHykBbrTkImOYjLmGpig+txFon4a
	oo+uhUfm/BopzMvRRitPeF1fmvAeqgltDJCjZ1sNbGPxtgYm++MHLp4WTG/cDtT0
	EjTdocOsaa90VqClLqoCprgal+jJojJtA1tLOVzT9RmYNWI/Re456bg1T/cE25AO
	nP8aVoN0tFXPx0jlQ3NX7w5kTma+H1iOnUSP5LHSXUkUS9REBjnjbluUo7GfKmQW
	tkCKZ/hkUnzsk5m8KJupxLf0nNPX3+2WajQDBGtAW+zcmSe0vCaTbRZ6UPK4GThc
	5vMG6xaZBrcGCuivUClvySXzwpb2AU/CveHdhqC+A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8fkkp5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 11:35:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQADjZj032029;
	Wed, 26 Nov 2025 11:35:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mavgtv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 11:35:08 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AQBZ8Xg007474;
	Wed, 26 Nov 2025 11:35:08 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4ak3mavgtg-1;
	Wed, 26 Nov 2025 11:35:08 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc: harshvardhan.j.jha@oracle.com, linux-btrfs@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 5.15.y 0/2] Backport fix of CVE-2024-37354 to 5.15.y
Date: Wed, 26 Nov 2025 03:35:05 -0800
Message-ID: <20251126113507.3836193-1-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=508 bulkscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511260095
X-Authority-Analysis: v=2.4 cv=f4RFxeyM c=1 sm=1 tr=0 ts=6926e5ed b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=h9qf7LEQhrqiMCnd8NIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA5NCBTYWx0ZWRfX1VkoSmiciHQs
 hHeYYqYiY4BuDEoVM9yJCTRwQv/t1aNSMI8jU0+A+SCBDMaD8a9I4Lf6d+SGsYY1+7h560cU4/I
 xtDHsIOAAZr8Oy7WlbT4QcCPxeoN2JDeMTyG02qGv4nfqN7LFqhy0AKkfGV8p4oOiHU7WKJnNzr
 +0rdcYo1IjxxlJGefmTPCq+tFKGm+YwvdOIHA0VW/dyNEmlnz/ktFIecrgDsJKRBMmFaPMHMVm9
 DyXd1t/E5SZVcHjbW6zrB6GrZDj/I81QbHDZlExvaL7GkR81+XVbmVwXVw0xzi1m3gB8icea6Ie
 AWTElNd4kTMiTDjTjHOSLBf3iFi9HtePOcfgegJs0QWAGPNRvIAGdCSbT635HG79weMhDmJoD0j
 aDUwDvLCpR5OoGI1wL/Vkd8dFGlP6g==
X-Proofpoint-ORIG-GUID: v8AdoTbyBBmw4yNI9mk_vFaTPhhi5WpE
X-Proofpoint-GUID: v8AdoTbyBBmw4yNI9mk_vFaTPhhi5WpE

The fix of CVE-2024-37354 1ff2bd566fbc doesn't apply cleanly to 5.15 as
it requires an extra prequisite patch `8a2b3da191e5a btrfs: add helper
to truncate inode items when logging inode` for the context to be the
same. Therefore two patches were brought back as part of this backport.

The prerequisite patch is part of a 10 patch patch series however
bringing all of them back felt more of a feature backport rather
than CVE fix. Please let me know if bringing the entire series back is
more preferrable then I shall re-send v2.

Some basic smoke testing and btrfs testing on inhouse test suite was
done and no regressions were observerd.


Filipe Manana (1):
  btrfs: add helper to truncate inode items when logging inode

Omar Sandoval (1):
  btrfs: fix crash on racing fsync and size-extending write into
    prealloc

 fs/btrfs/tree-log.c | 47 ++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 18 deletions(-)

-- 
2.50.1



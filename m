Return-Path: <linux-btrfs+bounces-2713-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD25A862610
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 17:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718511F21F73
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 16:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB408481BD;
	Sat, 24 Feb 2024 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="If6bTXUC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="djA+GozT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501847F59;
	Sat, 24 Feb 2024 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793037; cv=fail; b=Cmu9ME7AgV+BTYCPTTLnvkpZhcYjqQDsjKrKTVgoh08fFHYvdO1Vsb8pJHP0EKzZayX/EkmIBtHsi9FitpDaX8/PxuECCCp6QThBlR5Z7QDoBkCcRP2awxpK94ktr1WfgaJ6M3h54YJn9wZArOBbcW8SbV6Crhe4n4SYqKZ5Dbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793037; c=relaxed/simple;
	bh=NX3vikPGc82PRCqzvkpQrG5nbz6oFYvb4EGhOpht8p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B6aA0NPPLOnnLt+1MU6KH4VndOn0MINoGzNbgzUrKGdES/n2uRfbvo61b7STsD8HXH8sjs7NYKktskgghanvNHslOmqiCSXoVVhJDdnYXXbqRJ3d5iqbzac0dvIQFaO6SJJ+Fnl/OzfhIQ2X+cfyp0zlC+xMGh/16wFR4/AR+5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=If6bTXUC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=djA+GozT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41OFScko019824;
	Sat, 24 Feb 2024 16:43:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=KqZfs2Cuhn05K3pxfZ+pHqwGqAmJzWagtqO0UYIKn5Y=;
 b=If6bTXUCOMRBml0ViUXt70ODNpYHmSh7Yr09QpQtShTPNemuWmbGoq4xemB+JNuBNNBF
 nnRkVzYKHLS30QSyMW8dgfuPhSNqG7A7MQOa3+c4GYQy/pkmZVSZrY37MeIR+WXD0afJ
 Rwzt4VwH4oBlzZoh8tFuOYfPXT4uje7O6Cz72+JP1G8jgXaPl0aYgC1IcN3pYR4qQD+Z
 LxMgMxBfQb25wjwM3MetkTdyLnI/I2gXBbjXlfdkwMMeNxY6W+0GU+2e6SZzFHdmUIkb
 TCBFkLEm34302Oqpl1r9gPyUpstg4XotWbxTgW2tgfjsKTjQH7LUv0J27Ph6eur4ch5y nA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8gd943w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:43:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41OGRvjH012703;
	Sat, 24 Feb 2024 16:43:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w3skr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:43:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pl6Ty8qZKnrxBUJl6CQMUeAbZiKaahwAIE8t8+hllmrPHb/VsQEL4gIxHAz1aYXA/f8bV7nF9J62NyumlMKvvTON4m0gUuhW4dcg7kTGhba4wiGjabcLw7zmVjZkWbtdsl0icX/W6KFTmVHV+j+BW9QeBdRm08YcjpKcZYw3NOuNaxnuMs2f+HgXyWXy6WKoqaRuFmbv0Wk4bfL3AIpznZJF9CpeghiuZsFhwHIoFXuZGcN+xcuQ5f5Ju0BZTdO3RsluvQgH1VzF52lUXUddxGFWfLhdXd4htYWKKC79ehVnoeg+zaIbEBHUvu4nTYJhgMk1IqABlbkKmpxC7yJmFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqZfs2Cuhn05K3pxfZ+pHqwGqAmJzWagtqO0UYIKn5Y=;
 b=lir3dh0qebMLAu0vtEWeyUlUlUwAhEsWG3aMPWQhNIGMmKycdCK0WvahJIvpMnSAZKFMWDYmElGNUkfYMs2n1P1d/WR3HNcIxsimfY4mdgsNgrYoHwNv8ti07wKKhiiqWf3vmHuW+BaiXSpAQ0nCKO5C4H0g2YbEqAEV55UaCLJIQ5XfrDuQmvW44pk/xtwP6+RxbdGC7oHau2EzsmDyO5KQHDymf6T5wHRdE0WzRh5RaKm5IvjRYWWw7q+ZNDxAcz43qJBDLqTGfulcyO6csJXDruqW5wo3mWLX3ncfLMilXku3F3pjpMIjhc9jSUSFYxJPxNfEzEwHEjdZAWn4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqZfs2Cuhn05K3pxfZ+pHqwGqAmJzWagtqO0UYIKn5Y=;
 b=djA+GozTuvlk3BFgdU+L81WZDead7Qn9qHm+LLMiqVbnj82czN7FyMfCIYYL5Sf5VTgzCInoEQfIZEI2Oxmhg1RcGe/0gQpYn6VVyv3j87Xv4d0dB7FbAoea0keb7HqbvcUrpKXKEzPnTF/zNkzykNuPuUQrEccvJgpRiCOfA7I=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5750.namprd10.prod.outlook.com (2603:10b6:303:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.32; Sat, 24 Feb
 2024 16:43:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Sat, 24 Feb 2024
 16:43:49 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v3 03/10] btrfs: create a helper function, check_fsid(), to verify the tempfsid
Date: Sat, 24 Feb 2024 22:13:04 +0530
Message-ID: <3fe54b69910e811ad63b2f0e37bd806e28752e8a.1708772619.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1708772619.git.anand.jain@oracle.com>
References: <cover.1708772619.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 0efac4fc-c9fa-4959-99a6-08dc3557c6b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CIdMqFxtgeyMQ5mjm97rvDJbhezlhZ6mVVcq6U1VjNi7zAxo0RipC/BZGY1wM7E3XbxOP6i8eLwx2l46BCXh4+uteeCtX9jPh1JumOlU9fj67ccmewGmWjrronFoy8CH5ti8ZHWmuv77pOCPqSajQVIh4wKxJexjKK13R9WR/phuEapICzIIjSUScsDHm8q8TtziZNeFl3F0nMs2TVKaQQmp2OLW9WfHvRv1psl81BHqlvAj4B/yvJcpfoZ6NnxXAJY7X3Fb/ylJLa3L/Swod56wMQ2dxwssLMXWyOMEpihYiY4HsxJj0umrfkAkyBRuML73jLLF4VnB8t56/3OLShiQqoSzTMnURahIWDiZE3FLY2ZU2veHBNs0CCuI0E/U7QVJLjdu/vDOwbWo7d8DDci7tssHIanxl1idfBGWdGSUAMZA4CzzgzXGWUY0l2dBxGqJxAtoG1tT8LhP66w4HLcJjk/hCd9HxUvekqI6ga5HSt+0Y7UnHSmjUQEyTqWwFNUvm7lkHo6gVlH3syAKcXS7pHRlbI1qzeUkL/ePvOM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hNAvyJgyhlZ89P2t0W2vxTLzmDXrmMmSR2w0pvS9dYb4M7hK/fTLsuuxwYjD?=
 =?us-ascii?Q?BtpYaqHMZHRzR86rO6QRFY8q7KnfAJZhfIRniOI7YtiKrhYvUMgpyCfBaB6g?=
 =?us-ascii?Q?7JHVUQ2Ik5ECIT9p5nPslXBRQM7b3NFLuH9bd5jq0e0oQH2xgXqoBKdHFrw1?=
 =?us-ascii?Q?vQAw4sU/KytmO14pDramqK1em7d/mJgTxI8kuer6bW852w9EEsWvntZPWxro?=
 =?us-ascii?Q?elhpva7OmDgW8YX28122FirwmmSNK4iWna6bmO8sBjhFaeTR5LTyppckmDOX?=
 =?us-ascii?Q?GalcnqUh1aeejayPo08fDjSUYhDgFTb24KLGFVVGcgC1j6VF8wNc3pMlSgHd?=
 =?us-ascii?Q?ys3Ae5AweL/4wiHmkbQCwFpXd40JlqByyIFB7h4QisDKaQBCiJB/PoMtXSwZ?=
 =?us-ascii?Q?sMJCzvkWGgLKgu+xnefzrqxS9gu22buoYVNbsp1/1Xsd7i1IG93QJdr0avGk?=
 =?us-ascii?Q?CQmsLSDUG4r57lskudDaXpmo9MhzdCVS86Qd5lfrPgsgiNIImxmkiN7B8b7r?=
 =?us-ascii?Q?9VEq62RmUkD5k/GdM2Xqfp2wYGKGVN4XOMUP1WnSjn7CzfpChZaQh6aVlj8T?=
 =?us-ascii?Q?hSIAF537I3PsrO6QnK855rWenT4PWXu4GCes29EhMbAMQrKbFFXdl1flHPIT?=
 =?us-ascii?Q?syheb3gSFwpiP/WsHFa9UUU+4IAYmYm3IyvpQ+YhN2fOrKdARj17l1ea6ZsV?=
 =?us-ascii?Q?YDiRH9S6Rw9PaOo9IQ18mH0T4uD/xzirWCNSNLGGbtUC+qXYZD/WsuTCj0VT?=
 =?us-ascii?Q?v9+MQ8oMr4uJUcarqRFW1ItqnqL80bG8Jp3zsSYAGAUXmrs6i2WFsLpwwbuN?=
 =?us-ascii?Q?BHvIZlpzgwlw4uY0xkn9eRGsdWgwUEfEucCylDci3wuqkVdLlSFrjlCeCxCj?=
 =?us-ascii?Q?ddnWZgOCTIG51bMR2rXk9s7PxwJcZuv9fprni3fAoELHClvLtkz8W57EWL1A?=
 =?us-ascii?Q?JmAnA0stiDpq3G1JiZJvKVIlzSSpGIQtsgCtgp/Gy+LUA0b9cMl8tcEeMA6f?=
 =?us-ascii?Q?xMtHgyS3Am8mvUx6Bu1GegzimpCoRMz5JyqJwq1GkTRXEU3jZEAGQxYBX9hQ?=
 =?us-ascii?Q?3qeyANEeGlWorGvA/7egR5/nr7srwlEmFwLbmKhXlIoBgVMjQDZRwx53MvIy?=
 =?us-ascii?Q?MWfGfI7OtR7V2UKtb9/fLFuIk1jZVMmAtb0g3J43ifOUNXepvTf53NMoMYBK?=
 =?us-ascii?Q?R0IK92bZKjy14aThIjWgMDff3hO9eVkXs9jDWmmfjWlSqT2zU/wBh9hDNZPF?=
 =?us-ascii?Q?72aT2vQjxQsGp4kjDc/2l2OKyNTQYex+6Pw69bxuHZDGETx9jviLFEMFx3qN?=
 =?us-ascii?Q?vqmMIKSdCsO0eu2lbjc0MgJPOHEvCqzUIIilOkQgPw8+0BALlvRRdVwfMKN2?=
 =?us-ascii?Q?XQEfvHN2p7STfGAYEpfmTGisJye0ihWv/CLq+6GxBBHusmBg130Q6KYEp24i?=
 =?us-ascii?Q?Dq23M9lA9hi/7OSHygyxzORaIZbqpmhc0ClX2obd8MkQek0Ixpkw2bwv8+vK?=
 =?us-ascii?Q?bv+w5gotVzBzU+xG6nPGPc8CryffHSCZJzY9ReSk34166YXVnY00Wi4+VJT3?=
 =?us-ascii?Q?P4hp1QjZyb91maucFoLaZqcSUUX72dyK3FrHXina?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yaNWmSUQ1UVElZYBnsARTE4pZ1PcMcvUKYsD+/ldGB2Mu72Nv3RDnoHtuIzqgwUXMut9ybNp8WKNgGZp+BhmbQ5PwCNboQ4PqWcQQvUR9VRqhFZDvewVY+KFVUTUG8mhud3U0vbIw19Uj1dre7wNM/jozNg86qyi7CUxTYLCmHqjRhxWXJNVOBdqTxYHaFS8V4O7ja3TZox1rJApxyIidt9J/w2XZeGJn2HqZePKr3EyXHfUR5NTXmR0jQXP6MZBotLrp5ffrfh6y1Da1gJcv4+aYCkwGjQ+Fm6YshOcqfDMfFRRYPNIHH3OtlbpovscwIpHXSJy9PDPfcaWvMXAgkhfiM8A6ZInu8axBiA/FmVVJLVqNYmuYl3tEeI8rYyrMwWcWrtrVaU6tGe9Zwc4IRUizszpMJxA+Ci7ZEeZB+0ZnqwD3MnqrHAgDHvZFNcqna84ioQS3/5M2F/mt2WtaX75PmKKkEtNp3xBT4B/bKt2ARJg9vpu32QBoAqYNvrFrLHMbDN30i0kS1M4twjsJXYX8Sjt72KAwscnwUbOyA2AeotD65FMPxUHMJMjWcoFQOsDC8+6+QFneba/qVGw0G2Vr0ExS/xSPA8RTOY21ZU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efac4fc-c9fa-4959-99a6-08dc3557c6b5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 16:43:49.5319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxTteMQc4QA30/JszeCpuM2XP6SlWsnFgxvz1zLCkFFOXkYdjHQgO47tSrfK3xDmhFRKs8ZdNz6ng6FoJahceA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_12,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402240140
X-Proofpoint-ORIG-GUID: 78mzke8gJyoiPk8_udZvvRFM_ZmkBWHB
X-Proofpoint-GUID: 78mzke8gJyoiPk8_udZvvRFM_ZmkBWHB

check_fsid() provides a method to verify if the given device is mounted
with the tempfsid in the kernel. Function sb() is an internal only
function.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
v3: 
 add rb
 add  _require_btrfs_command inspect-internal dump-super
v2:
 Fix typo in the commit log.
 Fix array SCRATCH_DEV_POOL_SAVED handling.

 common/btrfs | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index e1b29c613767..406be9574e32 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -792,3 +792,40 @@ _has_btrfs_sysfs_feature_attr()
 
 	test -e /sys/fs/btrfs/features/$feature_attr
 }
+
+# Print the fsid and metadata uuid replaced with constant strings FSID and
+# METADATA_UUID. Compare temp_fsid with fsid and metadata_uuid, then echo what
+# it matches to or TEMP_FSID. This helps in comparing with the golden output.
+check_fsid()
+{
+	local dev1=$1
+	local fsid
+	local metadata_uuid
+
+	_require_btrfs_command inspect-internal dump-super
+
+	# on disk fsid
+	fsid=$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
+				grep ^fsid | $AWK_PROG -d" " '{print $2}')
+	echo -e "On disk fsid:\t\t$fsid" | sed -e "s/$fsid/FSID/g"
+
+	# Print FSID even if it is not the same as metadata_uuid because it has
+	# to match in the golden output.
+	metadata_uuid=$(cat /sys/fs/btrfs/$fsid/metadata_uuid)
+	echo -e "Metadata uuid:\t\tFSID"
+
+	# This returns the temp_fsid if set
+	tempfsid=$(_btrfs_get_fsid $dev1)
+	if [[ $tempfsid == $fsid ]]; then
+		echo -e "Temp fsid:\t\tFSID"
+	elif [[ $tempfsid == $metadata_uuid ]]; then
+		# If we are here, it means there is a bug; let it not match with
+		# the golden output.
+		echo -e "Temp fsid:\t\t$metadata_uuid"
+	else
+		echo -e "Temp fsid:\t\tTEMPFSID"
+	fi
+
+	echo -e -n "Tempfsid status:\t"
+	cat /sys/fs/btrfs/$tempfsid/temp_fsid
+}
-- 
2.39.3



Return-Path: <linux-btrfs+bounces-2536-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DC485AC6B
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 20:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106BF285935
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 19:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B46A57890;
	Mon, 19 Feb 2024 19:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nxjoi/g1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ihn0yoDb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902655731E;
	Mon, 19 Feb 2024 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372171; cv=fail; b=u9rDdAQOK2XmgkNa7AsDieLBdDI4c1o9GrueiAs7LkYO8XFiYQzALhSDxTwcMBqR5edFoOnx27XdSETmTig0KReKaGyWxq/r2uEDXZf5Yo+tLYpJXi+7PHpWcgqYDiI7cKO5uUEti7P6LpZ+VB2aO9nMBEIsi9qdHlKJlbWnDkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372171; c=relaxed/simple;
	bh=ZwiuERAYuVVM7VQa4PxqRYhCOWJVMcgJQyU50+4EEjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MeiRNK8I9LQEX+bjPqqwa2qiZZZMqk3SXtxP5e1Nw7apzdn3jE8G2UzU2D8jVIVHJC2ktkVc0cXiwTJb49TDXN3ucGKCFfGrgiwFSN8s9+8R9Xw88OLGrkYSYiSgvLxgWkwAdgmviYs/LSQaQ8dE15nbphwHec+9qoZ9LMp40D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nxjoi/g1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ihn0yoDb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIJ51m031793;
	Mon, 19 Feb 2024 19:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=lZA/jV7+IyGVI333q6w5k1r8VX26NW0R/SbQkcUahIg=;
 b=nxjoi/g1O7tn9xuDcTVGH/cILY+BDLYJog8MB4eTo4tWc9AzSfMMF3h6EKbeBcC79J3Z
 gSD8kg6L/CAeu04k5Y0/ITprhyyXjKcbOtjaxOjJXrsLEraO5kinzFGu91uwkEtTb1Sh
 2/qZKhr9vmUL5TNigdFbgZ+wQ/QMEBqeFPcE6tlxnrq/yBr5efwx1U2KQkoa/UqAby4B
 Pgm2bnc9UK1KxOIIFOEzcrPmxPLtAIRyIn4oN/t7Q9pqnc8tDbwYehYu8VewMydytRgV
 4YCC+f/Sh1nH8/c29qyULk4gDrDE1jNbdle+FjJqxH1REr1J2CBRr5/cF0YHkeWz1ocG Iw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wak7ed0pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JIPxFq006609;
	Mon, 19 Feb 2024 19:49:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak86hyrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 19:49:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aw2auVw9qmm7IJPE7d2KntZuZL1xx07Cubd/PJk068wrlOcUfWrvw8hk8WgCwnN5+o11qBLn5jt73NGQRQkSJOThKKnpPK7qhLM/OeWYERhQf1wwXsf/wVHt/QQDbynNrzlQVXwq7xmSCsSUdxVxRh/OdxG37ufnHSnB11xzNDWuJpKd8wZSXBBrEP/eAO02JUX3LXR4hFv/92lfnIbUyuy2MDxtRj64XxB84BkN3qHwrkJS5X6epjw/LhnpWy6CM7emoJ9kl5wIphev7vdC3rO9/NSnCZkC2zgZcZGWNHfLuUKCrnAcpwipYKveH6zhjh+qfNHS+kfN761UFKCEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZA/jV7+IyGVI333q6w5k1r8VX26NW0R/SbQkcUahIg=;
 b=cMy3PnvLuPMvtGs4Vp8BeGC46mgtsl/vAS1P9YDZXbKljPCmaCF2aTjj5F13KNcGDjKnoDqplZxyhlbLuX+dpikEV9We7iJxK4lG3iuT0R/aa/UWMwAOrnGCtBLz0oza0q9r4ogay1nKBiQZNOpldtVeOOTPfHrjX4bYD8F5l+bxAsFy+r8wIaR+ewf5TCOl9NuMvlK99Fm3ndCRmC1nSIRlpXYS6k/xyk9NhFKzbHqdVSZabmSW0jDtuLdsWARkMQu0aJC0Mbc5XSFcD2na77VR7j+1UqdWJGgGQEqySnKYY28Arpo8aCK6zOe6hB2mDB3tW3uPjoasIJq7Gm247w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZA/jV7+IyGVI333q6w5k1r8VX26NW0R/SbQkcUahIg=;
 b=Ihn0yoDbdj3g1nPAM2Au62Lrr0CsSKPumkPB0ydFUgGIYERN3Ww6nOkB87HQchUNVYL8RGxxapjNBbLazvjAB7gkPfOCRq9dWVwOd1XrmLSviGDA4pPij5i4Sgd/LM++YkS8FCIXCwGy7p1Gqwlqee/TOQELvXvwn6YkmsjwAyM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH3PR10MB7573.namprd10.prod.outlook.com (2603:10b6:610:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 19:49:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Mon, 19 Feb 2024
 19:49:21 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, fdmanana@kernel.org
Subject: [PATCH v2 03/10] btrfs: create a helper function, check_fsid(), to verify the tempfsid
Date: Tue, 20 Feb 2024 03:48:43 +0800
Message-Id: <265a0f1115d7f421aed9c87d52b07e3c9627f2c0.1708362842.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1708362842.git.anand.jain@oracle.com>
References: <cover.1708362842.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH3PR10MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: b792ca73-8617-4303-0c33-08dc3183de15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	x339sAL3vivNtS/kjB2IDIRu0Ru/FWJ7SKCG0G/U/Bf17yfKww6kaiTcsDVpXbfmulznSYd3GY1rZXqMC8tzodWXNQszKYixBa4XgnZYJyFzfshTuFWbIy3lWTQ0K+iqJcR+f+ikG1WPKAy9fWgbizn8NJmNW7EBqQ3mJ1gMoxX4IeLLXnBD8Th6LmVZBockvVvEmFHB//m2b879YWqR+xPt4UPyKu7Fx255sx4dNWXaQvQqsuPmq5QTKlpUJ3EcwhdesF/0ebSN/EONFlcz5Gj6aVPduS+ksi+vEM32ncPVmpKSUTPgI4HD+9WZrQzOVhLYFYst6vjRP73xg8Jf7n5DrCs/wp3/JZiJGpQVmrpoOdyGxYCFDTP7UxQAn9ZyYbqVaf/OQB3+dXE9ANj+OkXAZule5nFijPVtiEYCGslZeBdgVBAawFlt4qP8qs25BBrWIkd+cZfVCd1WgCotch6iUfbcgzdrnR8F2/H6m17HOidka2BMRJJ/RwEzbm0iDMpfSC695DTogWddSYvXOXHVCLOGAA0cnvMgZAIjGao=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?K2eNM2i5SYRqx3Qze+2PTyREipzXJFULzCWX3k7JzciKFDA+79EdneW++1rX?=
 =?us-ascii?Q?wi/EozUTEhX+iy13iS8jrh7gvi3ZwFITFpUW1Y/Y5iF3f91b31knfmRr8mac?=
 =?us-ascii?Q?DJJLrxNimD+mDyvIsQHYnEcrSvLk73Iuq25oJAG9EDAussdvjOJRmlDHfAYN?=
 =?us-ascii?Q?l9sWsbxxNxwc/p+4c1IvzGjgkX/iMlPfofgMJoiRtpTDo2YfnebGkjvSlGyx?=
 =?us-ascii?Q?Us9l6c4aO5um9b3yTdZXGkZAy3J3j4kbCy+F5iD8aMSgbB+ayiv1sXqc/GM+?=
 =?us-ascii?Q?w0GUlc2Qoa0AL2D0fe/jI8jYTAEXSO/7agT9SIHkohRIu9Xh+pha5+zXZx7D?=
 =?us-ascii?Q?iqhUJHzmt+QqdjCvOlfA+8NkFw/fFwkybDG3IHvzYUL/QDitT+a1B/SPQ94r?=
 =?us-ascii?Q?kJ6g0LMvaDXAFpxEM/WMHvwpj5WBWMYXVR874BLn/n+hAjJ6FNcHNvsWtr3x?=
 =?us-ascii?Q?HdrwSvCB0NqhAIXcTrViGnE47OZbb9fjeMdM4cx4hyZauVvUUxrgM6Y/xmXE?=
 =?us-ascii?Q?ShgSkltnX4u0QGAsjJperDBfeBJTNwwoYbQxZymApr78N4IrLpAyW0KoI/x2?=
 =?us-ascii?Q?aXbH2YeQtw2PkuD0t6mpfxDGF8tjCCnhvWDwMpHqJtjoYklIvFsxo8lCy4Hl?=
 =?us-ascii?Q?IAfRWfpot38t5BShMcgSC3ATtAdnx3J7ED7Doq1FBKpWuEziPZ/lLBLpzJaq?=
 =?us-ascii?Q?8LJAqwgQwq/rZkWRp7vOFOiO8zBC6tioRl3og3ctk5HtpEVWgJrs99PL69ah?=
 =?us-ascii?Q?KQEL6SvuVRXGzg14vy6OabT0vAuJ4XFbK4pAyoUj9EX/cTBd8WKBItCilYeZ?=
 =?us-ascii?Q?pcqIL3PK0heKM0KYsD0A+pnriwg9da5kBgh4EwEHNI4yldrgGPsDJQ0Rx26V?=
 =?us-ascii?Q?3OEbxYtggqdPPtSthn+xD+ufi9H+5T8GhnPMmktIA0V3odY0ZDvfC/LmhZCA?=
 =?us-ascii?Q?Qulh3+xp1ULfaYQ45fyXOtfwowG64wPvAORFjGWECB5SnS0vfNr53/PV5Ngn?=
 =?us-ascii?Q?vBEN5wsBj+UOxyjrjAQSAmc9OvFwNQdB4WUhfmKj6QXoPxx4b9QIz5fMQu9L?=
 =?us-ascii?Q?F0zCis+fnUWhiI9hagOU17y0b7NkbZPu4R6yZ0auTdvxDJ0WmdSza+bKXVEk?=
 =?us-ascii?Q?3i6NJv/pc9YEogLjzbRhmd95aJ0M+hY2qZvKE2TLVLrWDNe3VZj4NuwJrCXu?=
 =?us-ascii?Q?SZUKZIZl53F/RlI/w2Nz8epeW3XZmKdO9q3P1wRraCeH3gIBfI79mfW2rkBm?=
 =?us-ascii?Q?jui5svjdUJrdG0jRuI41Wsstb1IhoF2hpVQRO9ZxqG51FOqlJFUmQZG8hvUa?=
 =?us-ascii?Q?v690slF6RnuUNNqm0ipO4txnLJ1fngrLl3YDzz/sFC4Qe1Y8vIj+OzUcMAP8?=
 =?us-ascii?Q?wRDMKfnaa1sG0m60cj8iwBD1IKzCZ6Cw6H8KcMYIwZcvs32O7VkHK3mKdCH/?=
 =?us-ascii?Q?URZJzCk1nBp4JU0EL7VM2C9Vnc1vy0AQYFCOgP6Vw5/nwO8sCBFpuix2CCoG?=
 =?us-ascii?Q?u2NVSDQnu2ajXnZYsbVvLJK2gd2h7kpMOCuyT0gPrlUx7Pkpvg8nh0jfqUEl?=
 =?us-ascii?Q?mjpbFVdmJJZqgfC+JIrxFyTIZCUweZmYtGHifUpp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+KAk4EVoPOoInxdWb3t3F6vpYQPjhFK2hxKZVIiOMuyqcGK13aWSlZlByf5piK7S0BZ0ZrFWZpYGhg/FJqA0IWfj1xTCO+dNJle6wvGLqYjijWytV4M1iNDd7xZOZYhS9jCe/XG6seNEcXjZhazIHIvpcEILmgRySUunXbX8OWg8L+bvaifjKaElB3SlxbR7cjYJK78yi3TQoLNZGK5DiO7hTDSnfJtxWaI0zssqPXI44+EkIfAgDgGX/irl5vyDjoI3QLGNZ9S0p75m//fnYVwQ7P+2tE8wOV2hijbdGW5AptlRu8memqmjJePQ5C5KXdoujd2oYAvE+uFyA160xMG9ApLDUNtna2sfnBDhtakX2QMrathWQXaHtCzeybd2J0DxieAO9OIt/L0LFo2j2NwjAriBz/p+kLaXiff98RvyV0zQB2220glI5eq2GYJvtrAfKbLmkbTn16y3gLk5HVc6Gt2pnAO/qWQd4W9L+gMJjnESmalZadKNCAHMPi1PCzUkIpCeVLn/RelrRP9CvMTswsYkY9k0lQ5HERopzlAVxpaqcjuKPld4PJiOxfJWFU0Tlz825g7xzYpbH204Bk+bRSSidJkOk7GT3YSO+k8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b792ca73-8617-4303-0c33-08dc3183de15
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 19:49:21.9142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQBlGcTEhySmuOxFNorbwoI6ormkhtwYsYTC3iqMJ171+zM8r9owzSePH+QuNC8lqlQBY7NeX4wAvYdCGf6ESw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_18,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190150
X-Proofpoint-GUID: 2sXQB_fVrdhwcgL1MaCR44SpedGuIDU2
X-Proofpoint-ORIG-GUID: 2sXQB_fVrdhwcgL1MaCR44SpedGuIDU2

check_fsid() provides a method to verify if the given device is mounted
with the tempfsid in the kernel. Function sb() is an internal only
function.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
Drop the function sb()
Use $AWK_PROG  instead of awk.
egrep -> grep -E

 common/btrfs | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index e1b29c613767..797f6a794dfc 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -792,3 +792,38 @@ _has_btrfs_sysfs_feature_attr()
 
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



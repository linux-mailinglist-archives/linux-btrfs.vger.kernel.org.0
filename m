Return-Path: <linux-btrfs+bounces-2715-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F294A862612
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 17:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841CB1F21FE1
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 16:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFFF487B6;
	Sat, 24 Feb 2024 16:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hzPukpHf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Dr7v8oRQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084DA482FF;
	Sat, 24 Feb 2024 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793048; cv=fail; b=UG3L0IprtKfQR7z5MqpMUI/iAGnBzB7as6yBVJK/zKncoGHQ/nNWLhIsJdcnsNnuwnJPC241Tiy77FwSrgCAOP8e8Pge4wifhkZnEATvuFPQmS2XHBbhX3gmrhxF7h4RmVG1TyGmIOL37FJvNuQfQ7viJWnRgCfqvR+DC94e/lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793048; c=relaxed/simple;
	bh=Yg/IvnHhNjUU/Gm8ug44x9X0kVN/3qWZjIIWT9UsA/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AJRo25tVrnbJCSuBpIg9qKUHf8VXX6z3v5RbPFepFATrFmIkMauN8VtL5yeWLFaoCZcxGh0gXE745BZJmBCZdRz7pqWuaAXNFPudfEZ9YB1EOuow+i2NS+V8683FV4KpVsdA2fUQ1hb4RciUK3LPwGGbAPhi3d60+f6Qh0HGztk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hzPukpHf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Dr7v8oRQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41OFT6Ia020730;
	Sat, 24 Feb 2024 16:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=LBwhflSkOapFcuKVefg0SUWpVQfEZe1MrXNVtYWCiqY=;
 b=hzPukpHfxZqLALjm930h//GdSY6AzM4enjxpoRArJk0lYsW2WD5TL2E/HAeqWioQCJOr
 aUPMJQIl3IkNHWKVVUNY3Wfi1VLXX2tQ1z7Ln4ROzywamljMMUvGlKF8dYj6MTz403ig
 +MPXQIvmks8EYEHau/gAF5V3AT4q7fbARAovq2thOpF87mit6VDNro+BJfnZa6QNxsF+
 4IVmPEzoezsIEiohbDd728nV94c5jC1O0XS1NWAUQGWD5s9KKXpAB6EhUXJ6S+S+2P6z
 Ozxx8TpMtSh/5jL2/QDPeIc/CZeBjtBHeXkxe8rgcRkR7v6cDl+HH3AS+/1oSLTqcWS5 aQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90v1100-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:44:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41OFoujn040795;
	Sat, 24 Feb 2024 16:44:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w3tv0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:44:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a06z3eCqqDLGaE+Ri4RbkTfT0kgbn5EHNT+qmRvPWBdICcU7mdRtSxOwxZKssrgwMIJVU9QRs4QHYDJSwZd4e7MlNCvTESCJAy1ChJ1eAG1oDpVm1dYo1yC0oF3wTIrd/rxLkm56RftWQW6LFRdashm6BI8tpWHq0EMR29IlylilmWzMcdoX42FAu03DE5q3mIW09cm+2jUxm7QnpTnH4mmXuA0HpzKcX3yPp7aHl6Ke+VoucTzWutA3b5xn7DjcZJziLLAtQbOlvmG+Bzs/X25cC9KCakietjk2euNxCpufD9IvpRmDChqcL3slByOqzsmlAxOYL24MCczCbkf6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBwhflSkOapFcuKVefg0SUWpVQfEZe1MrXNVtYWCiqY=;
 b=Rfpi27f8kestXOVEkelnx4PbJU4rgsF1UhsY92jZAuVr1Ef2w73KMXSLKV7u84RqyQAVgxIb+8OnANW5rV/HyfoBUB7gnmxrENSHkkanzRFSnwOWY8Zg73Yw4NhSRzxE6u4bleK467mJ4/kYjYD/SMgLEJ/pJGE4skcDogk/N5ZOWEvetA7GZobnY22dga9a7Gi5nGMPlz44wFhmgY1Ux4IzrDw3/PG0x+tmuiR6baRFpf7DpRw2RD3sdiWk9U0PHUG6Li7IZ1+dHJYN03QQc2n5okjK5hi7LHM7lD6OqDCVP/pl7xrgG00GflJEM+1MmIZl2ZNLmLCZIQl/yre6bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBwhflSkOapFcuKVefg0SUWpVQfEZe1MrXNVtYWCiqY=;
 b=Dr7v8oRQ4u6YyDPNmPioRyz4j1WYZ9A31kiTVTkLp/9o5Umy5C29qM3Ajahm2s9q8tXMHyCu39tsKA+EwTKRaefTXQ/argiZg6yLy68+2PynIIU+5ywg+laGzxNZClopC1hgHzCCsCdpPzV/WU0rfigMBiw2WygAsGk/rQV/bKU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5750.namprd10.prod.outlook.com (2603:10b6:303:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.32; Sat, 24 Feb
 2024 16:44:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Sat, 24 Feb 2024
 16:44:01 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v3 05/10] btrfs: check if cloned device mounts with tempfsid
Date: Sat, 24 Feb 2024 22:13:06 +0530
Message-ID: <efb3d493d6ff44dbf87645669d4d363b0b83ecc3.1708772619.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1708772619.git.anand.jain@oracle.com>
References: <cover.1708772619.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::8) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 72afe81d-53c9-4b28-0c6e-08dc3557ce09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VyvPFdcSGN+RBWfXwaLbY846fDlpAc+vJm7ZI9MfXI3Kc4U2rtJqw4ULGd1RPmmcLX1hg3R4IPl7DAcEbNVDd6mv7qYhEkIzTxjhcwODZ3qDHsMU0vubzSetfo7v1kU1tWdyuOeoLe+RQNsZMvyFceNzaw96CBQrLsNWi3jK4GHmva9RcBrXc0YCXXMv5j4VQe4wtwf189L34743U1UfPBG2eG5ObQOQVOfTE80l2EsWySogrkjA+1GUwVaY1fnFK/Mk2jYMnRCXWFZA17kCTAFVLdo4gWiuJiKv7VwgfForBRI+g2cWszG0f3PVogkpnUS1euAHAbdXm0aRoW26ETgL7uSje5q8E2q+vCs1KhMPm9Wl+5EH7/KlbmBptitRzefywA8zFhJ23z3VkEd4a1EoG60P10Tkn0rc9mScYUgH5sU3cU2+IgGWhp6fN2NfmeBDPLznHH1uiEcp18+lUZ1v/GCjozKtwknIAWRuJNn1eG0qDfGP2MrNmNQoD9fSZ6UnMtypOvBsVgpe069ydarRMLL5sKpak7nwf5WP6xs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?g44nhpxPiiHHwcUYinX48nEEfmxGwyXF16b2B65IbT7/nO8knudezHMqMrNR?=
 =?us-ascii?Q?PqKqilF7+ekIX8W75AlZ6ZVYqnty/qOXZc2v9uv9vDHREsg61ccaxwtglbaJ?=
 =?us-ascii?Q?jrWoUFR3IWu/Y4xTpdj+wiuyYSzClNYoHLGbb20FXq243GKEkkeT/M88UfRP?=
 =?us-ascii?Q?GGr6sTOWmHXXgMkDVPM8I9drqEQVXMDiItyh8RkSA89B5QCxsJ+Nn+KLoa0x?=
 =?us-ascii?Q?+vDxw2sRsDndp8r4G59IHggcwUzEowedNf7F+7qpeCkenCIo5qU2dShkWyd4?=
 =?us-ascii?Q?TlqPZs3VQQ6tW5HdRhO4yidiBK8Z0fAeRQK2ro70zclBU4q+lRwF7AFM2Qrg?=
 =?us-ascii?Q?MCRBPp6crgMS8Qxois/5GpvWYeP4uu6532Fhdb4DxYH6Nq4bNia70me7E9FK?=
 =?us-ascii?Q?wIR6Pnzq3z0/LMeYYBHICBilq+FVxZ2uP2fBg5CazP1tCBiHVKr4Zy/waNlm?=
 =?us-ascii?Q?OKCu1w4LDGnTM8S15u3yzfKSGGqCgkrJLubppEhzEHwBVBCHFeWWglsxTj0X?=
 =?us-ascii?Q?DSd2H1Ekx/3mSv4/vujQQVzUCM+78aB0TFhEVh3WrrSAcuGg+XW5HWs0hCv8?=
 =?us-ascii?Q?vZsgh0W+6ta4U/JhA0sM9numu/kDPLx9m5E8sX/Qvaw5MyNzSuaZAfv6N4y5?=
 =?us-ascii?Q?8QtbLhVzrQ4657AgSkQKLqcLYVw4FurWvlcfLlMkD45nD6lZVhIyjhQLE/uU?=
 =?us-ascii?Q?U/ktaDZlc69QrBBVWYezMy2y7SUh8PBK3WLXffpdcJc4U9GUtx2tY2toalpH?=
 =?us-ascii?Q?WSISusvkV6amZGt0jmGi8el0uoWemRkgKzBseA9s08YsBw8nAZzEQMG0jH5K?=
 =?us-ascii?Q?1Lk1G/yMbW2HcV9IPliohdsqGEOAsWaKPGZwgnYq5y6SXe0RkQTSgBM9aIhB?=
 =?us-ascii?Q?98GxJXIGzDDAFt2ewWiY3iesduaC4t43i1Y51Wm2uxXlak2u/PjNCaK/tlqn?=
 =?us-ascii?Q?U7cPTPL5sgFv75ZhUan0+T6QoTHp9GDmUQivHrwy/j8/jzYhdmMkxs9BeKwz?=
 =?us-ascii?Q?OxpzPLsEahqoN1VZ9r54+HtbI2Tyvi5f/qLW2Y6KIAfp0VD4bZjR6uIn2m4u?=
 =?us-ascii?Q?yJFY25JVPn9x+dLYqDQrs0X9+sSe99KcDSYDzTir22yuHAKfeG7FO/rxCHx+?=
 =?us-ascii?Q?YYEZibK8dJahxdAQjLPPyIcT5HQuWg1WdcHZ1nm6aNU2qC2gXYVqOooe0G3L?=
 =?us-ascii?Q?mpI3aEi2nrsmjURTjJW60rbf2skAFzWqJ6lNHbNsVG4abqblcb96ATyljLNv?=
 =?us-ascii?Q?CCpIVvhiTb0m8izIJSxdPxZu2pndRjjhp8KW8GzK/hfbAHnb5PZa6G/scA8W?=
 =?us-ascii?Q?kbx33yQ7dNQwyqaGvXJ2IEnKOYbptqkBnYUhee8qW4x+7NAXuxDCN8ffU4DE?=
 =?us-ascii?Q?c6QHaGcQUjAHkkmUnCuoNml7LtFQcgKk08ikE5ikqQXylQNEYZS7G9eyW8wb?=
 =?us-ascii?Q?/SbEEzsBUorCwnj9CbLYSicSen4rS/4WITBJ8IdnB477pVJcrIz9l6t3eSEL?=
 =?us-ascii?Q?A/R70tS62dvqieav82BVGYyrfc+eqnJvgeK8gxTxlefruFqzSCYdP8xBEQas?=
 =?us-ascii?Q?aQk64kkpVh0WVKt3TiPNUmy86S9y3DPdm4KexdPU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fhKBt6Lw/XcFULzL+cCJLFfBx3zG/sEK4etjHwkDs7XhqLn1jdmrWI4xc0sgby3aoUJK7K1CYM/d78RM7wfwdq10QQZ+1rQ0auSMJvQH4JPjGXgw+5/OKcKWSUvSPkF5+bCvo/VmbAtcmXuj7qyri5SetjZ3KDcJHwiXl9se6nXRpZicZjlMfDIMdSEaxJBPHmrTWMwdCm5w4Wdti859yZyn9PS5OyLJ9ohvO6gZ7UHaJjR/aPdvvQVkwhCaUQLiV/ZJbqDUXwupBK7Zco6yLCQVM8/7FbSPvKrVrOw1cuAFgD/LyrJZPZw9+SenRpJCXmY6iaZVYIHUSeueNmxVR7uKOrYnxAACtYoJrv9iHXYd6iCaYioepO6eTJBiZYgh6eWz66XCYi9IpDCvJEM2pkp6gF0FvTZsYcHlBL3RdpbJ3KSEbvK5VQPdJ4L7cn30IRIGU4ZYjwWMBvuiloilajTK/oq6PS13tLfXzDvgubjHL0L+zdalLps1jJ4JlpG1EZ79D1Q5v0YvYIVAK0dL9VcyVHGje+y7Oy9OMBSxBYw92RzzzqXgIdbn/z1gO/MOb+0RWOQOUTYa5wkbcoY7quPNV1rOlPrFnKlCy7Zlk7w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72afe81d-53c9-4b28-0c6e-08dc3557ce09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 16:44:01.8102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOzHwMYvvfJESekwi87ijXB6Dxh9ivFrB88kjSUs39pg4ps0B5UJjqd+6S01/O3A2VAHzn2wxUNISfNseibMcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_12,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402240140
X-Proofpoint-GUID: u1xrKIjc1c18v4wA9T0YgrgL1edNlLmV
X-Proofpoint-ORIG-GUID: u1xrKIjc1c18v4wA9T0YgrgL1edNlLmV

If another device with the same fsid and uuid would mount then verify if
it mounts with a temporary fsid.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3:
add clone group
fix use $UMOUNT_PROG
remove (_require_btrfs_command inspect-internal dump-super)
v2:
Bring create_cloned_devices() into the testcase.
Just use _cp_reflink output to match with golden output.

 tests/btrfs/312     | 84 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/312.out | 19 ++++++++++
 2 files changed, 103 insertions(+)
 create mode 100755 tests/btrfs/312
 create mode 100644 tests/btrfs/312.out

diff --git a/tests/btrfs/312 b/tests/btrfs/312
new file mode 100755
index 000000000000..90ca7a30d3e2
--- /dev/null
+++ b/tests/btrfs/312
@@ -0,0 +1,84 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 312
+#
+# On a clone a device check to see if tempfsid is activated.
+#
+. ./common/preamble
+_begin_fstest auto quick clone tempfsid
+
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $mnt1 > /dev/null 2>&1
+	rm -r -f $tmp.*
+	rm -r -f $mnt1
+}
+
+. ./common/filter.btrfs
+. ./common/reflink
+
+_supported_fs btrfs
+_require_btrfs_sysfs_fsid
+_require_btrfs_fs_feature temp_fsid
+_require_scratch_dev_pool 2
+_scratch_dev_pool_get 2
+
+mnt1=$TEST_DIR/$seq/mnt1
+mkdir -p $mnt1
+
+create_cloned_devices()
+{
+	local dev1=$1
+	local dev2=$2
+
+	[[ -z $dev1 || -z $dev2 ]] && \
+		_fail "create_cloned_devices() requires two devices as arguments"
+
+	echo -n Creating cloned device...
+	_mkfs_dev -fq -b $((1024 * 1024 * 300)) $dev1
+
+	_mount $dev1 $SCRATCH_MNT
+
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+								_filter_xfs_io
+	$UMOUNT_PROG $SCRATCH_MNT
+	# device dump of $dev1 to $dev2
+	dd if=$dev1 of=$dev2 bs=300M count=1 conv=fsync status=none || \
+							_fail "dd failed: $?"
+	echo done
+}
+
+mount_cloned_device()
+{
+	local ret
+
+	echo ---- $FUNCNAME ----
+	create_cloned_devices ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
+
+	echo Mounting original device
+	_mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+								_filter_xfs_io
+	check_fsid ${SCRATCH_DEV_NAME[0]}
+
+	echo Mounting cloned device
+	_mount ${SCRATCH_DEV_NAME[1]} $mnt1 || \
+				_fail "mount failed, tempfsid didn't work"
+
+	echo cp reflink must fail
+	_cp_reflink $SCRATCH_MNT/foo $mnt1/bar 2>&1 | \
+						_filter_testdir_and_scratch
+
+	check_fsid ${SCRATCH_DEV_NAME[1]}
+}
+
+mount_cloned_device
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/312.out b/tests/btrfs/312.out
new file mode 100644
index 000000000000..b7de6ce3cc6e
--- /dev/null
+++ b/tests/btrfs/312.out
@@ -0,0 +1,19 @@
+QA output created by 312
+---- mount_cloned_device ----
+Creating cloned device...wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+done
+Mounting original device
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		FSID
+Tempfsid status:	0
+Mounting cloned device
+cp reflink must fail
+cp: failed to clone 'TEST_DIR/312/mnt1/bar' from 'SCRATCH_MNT/foo': Invalid cross-device link
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		TEMPFSID
+Tempfsid status:	1
-- 
2.39.3



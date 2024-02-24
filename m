Return-Path: <linux-btrfs+bounces-2714-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8920E862611
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 17:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A7F1F21FB0
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 16:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56759482E2;
	Sat, 24 Feb 2024 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P6+b3/Wy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I0iiPbJO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F19481D7;
	Sat, 24 Feb 2024 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708793042; cv=fail; b=kfKUq5CTF30eeq+Tyy0H2VIEkf5k78s72/wsbmONX586iyfC32TodODZ5BO7r/xkhFMcRM4WbcUhWtnWT3rC/GQc2ngCmESYUAbemeuigGO7JWHdwC3SdQiCr0aSr+o6tLVsRI9kDCSFW7GLZb3zVV/yTYe3KUoju6D9Fi3BZJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708793042; c=relaxed/simple;
	bh=JsPYkW1/cx691I7qnWr+uzWmyiis8O3UhcJ6Q4dHado=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sokjtVtJRqCuplCbx5SgSc3N/35ecJmEUjrLUT9wA/C2ZeDVEgUn12wlNAI9R1+LkTkdcv1uOZaxais+gocRxKO06zm1JslDGVfrCz39re8/VLLDJJvw0OS2IXua9mvLKzy+XV86tNbME3T6PKKJ7nGylfDHBVsgAny+o2T0bbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P6+b3/Wy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I0iiPbJO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41OFSnSi012218;
	Sat, 24 Feb 2024 16:43:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=6rCU65DVam2kOnnfctBoWLo2r4xBXuU8zHmjjfXlm10=;
 b=P6+b3/WyAbD2Xk/I6kDnzbgwAP5XdhbIGnQeeujVAnUro2HzSDbSUvXaocHEvILxkMle
 mdXmhGg72QLwXzyg9fruN+YV6zSd0dk8+4Tviz+k6i0WaoNH48MDIDxzGbYnqRPyd0dw
 WVS6GA9pKrsjt/D1ETNhpwJlU2m+AEFrJEURtEeKGdGxi/LVb8plflu2GNlmgxoWQm17
 b7zW6UfTR8aE0MsFDsGdxynu3o2sKTxwXfBEx5t5VvyUp/97+dHckf5uEceEXVVMXqfj
 pOP0I3z6mRRafI6lOf893TkWHsCwEcL/QLZ3dzlF5BUVWpUj6H7Af1AaSlU3/7vUtcy9 aA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf7cc93d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:43:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41ODUItk039321;
	Sat, 24 Feb 2024 16:43:57 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w3skfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Feb 2024 16:43:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqUNaaLUfpc4oUZG+WDgUCBAcUEfUxkBeaA9bzx0b0rNmLv5TAR9JelqSyEnLZU0E5hvH07qusxLB7DkjealXbb8J9aBK7r5SFPXjf3LZrHnCf0k3fjasbsEQDOsIvBlv6cT7ll1M+sqoWA9CrxTffm/IZiqn7ACSYsASQxC6wovd9orRRVKS1v6aajY7QugdOJx7juZ+snVqINk8PxTh7ZqQyItCO0LGfblhrkQH5cXjZ8VC8ULQQfQqM8E/FVTcenbRm6SOxs/JxMSi8HBhdjODzMLh6Oop8ZkC7VWYTYoORdGFtjh+9k3FMuaqc/Jv369SVEdq1s67McL62BZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rCU65DVam2kOnnfctBoWLo2r4xBXuU8zHmjjfXlm10=;
 b=BSWdw6i9FlIlxia62A1xTJm80N21bISxdNAqm8oEEOM9aiJsYQrmTj9/v2ugtDWtf1iCeoiK9PTkwhky6PgIHe24WlBM2h90DwtkcI12QSHnPOw5l26W1LUDLrMXhNOgs3eZBkRSBxPHWBZ6luDAqBX7xLX1He18PkWzvkSCGPI7DtH+/vBRjC9DY1EYmM7S1UIGQglHJ1DlCSeVnhGmfXnuAV8MnS99CQo5xJGqXcaZd4kra8V8nWc8X0M/9jkldCRmAK8wegk8yBgXwG/t8nBFKvh5TiZc3tStK9e2YJrhKdZlEnCx5SxpvydJPh30P/z5plaScqKBJQJSPwrPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rCU65DVam2kOnnfctBoWLo2r4xBXuU8zHmjjfXlm10=;
 b=I0iiPbJO6tvh60/VguT1XWLOW0UGiKQuO7U89TkwgC0dbJOwPgg/RI14uGHGbm3nh+r5ecr9Lmv99S4QkKA5PvS/FMPu7jrzWz4rDq7K4E/N3Vg7aeqfmcGIymgN95n7iIlZErH16yOnk2SG+RBueBJxY2dB6uN8wIxp+VzzsJU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB5750.namprd10.prod.outlook.com (2603:10b6:303:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.32; Sat, 24 Feb
 2024 16:43:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::9a3e:7f11:fbb:1690%3]) with mapi id 15.20.7292.029; Sat, 24 Feb 2024
 16:43:55 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v3 04/10] btrfs: verify that subvolume mounts are unaffected by tempfsid
Date: Sat, 24 Feb 2024 22:13:05 +0530
Message-ID: <0505c197e80e7f476c39a4a6ab31777c67ea818b.1708772619.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1708772619.git.anand.jain@oracle.com>
References: <cover.1708772619.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: a712f42c-34a5-406c-b2ee-08dc3557ca4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	V7GhgRYk068EJ9geq8QW/sykBqpatwt1a75JHhvtJeNK05k0TvGp4ZHXikLE7Qg5W38QE87fDR6kIxcxcb4xYE6itVz/pk4yitxYzebzAnaI6uFKK7Ig11z/o5frfg608eOqFkMLJY3maUAypgrY/S5MKdfYZq22cArM9CzPNl3iCS4enn1uDnENLa303NiKWgTH+RvgJkw9eHPScaCmKM8J403qmyHm7R1VidPTLeFZjqFBDwi66+vZG4+3nEJ0hjRddHARTXNORCBqqgoDFI3IKLJVU0QdGVlvKZUJ8eJCC8/smDRWLY63TXyoAD5UR3b/Z72HBmO6A8kFyu2AJERBmHD2+AloDqdanpD2QEk8WiZQw0ogjTeCM5AlqcnwS2JO+NUR3+5mAE4jL2onh4IDq0n5fzCIGkEQTeJyxTy42som9TlcZGxBqPMJ8qqq838PtSmuz+OtB+su9ejja1oLdXiy0L7HwJMG+xi6bPCj9bI6z7TN1pH1iMvEFcs6Rkp7Su2r0HFIMgn2dcdF+bIdmvxRpOwtjlTRAOQZrxE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ajkq24mbJr0PW4xWQ9GnOiPgKi3rIUMuw9OcqTgP3ykSc56tnFkqqmCcUEZw?=
 =?us-ascii?Q?+oB2rlm2So08nDC65ypsT+gqLyUf/kcBybHqfBG2Knux+jFM3p3UPDMyjyI9?=
 =?us-ascii?Q?PVhx6M7kTxOMMhH/fb6CYaLRBNhJoJ6T/BSuQuA7wnOEyopfGtQpNC24FPd6?=
 =?us-ascii?Q?gglPswyAEDr9abA8Pfbpu/VwfYLDr6MSfQ6yarsU0H9rHZ5hBB7FbKFVV/Te?=
 =?us-ascii?Q?mQTrNRHdWeGDeI+dCNtDTxCeuzv/KjE21bN6NKaVu8WdhrZO6lm14mOXobUv?=
 =?us-ascii?Q?mbg2YxHP1v6C93lUDNOLE5M90YWswZFja6YIGpcJbOmRWXPv1TQWx6Pl5fOu?=
 =?us-ascii?Q?9LhcAj1/NXqbpDqwKvtPsJWfHqEbTezY7y4MZVALuWt9fxMhH/ELAHqr8tkF?=
 =?us-ascii?Q?BXPhIpW5sQWtzjJrIDfM2pJpYbL1zxN8qorLF90sLEnow4dWiBvAd5d9aDL2?=
 =?us-ascii?Q?nYaGLYYuZSxQVUVHIld2rnAgPAxdRt0hBFJ2smOqqTXYOL4vHcpViB5mmraD?=
 =?us-ascii?Q?jjfGY0PQEWFPKDUfJtT+jBJV+buWNiSw+NCMzgC8QqqNCorx7epqFJUANVQO?=
 =?us-ascii?Q?i/g9gfHxV2O7BRfaa0yrpiOnEZ9cY9X8klYjynYntzrAvsKi2HB1Ms5Q10Qo?=
 =?us-ascii?Q?yPO27vd24LAVJ1ool/wjDwzBX3I4us1fYlLp12MnHfFltIyzcXkG6yR6hyF6?=
 =?us-ascii?Q?uVdWdARb9C2sOoiu+dCW5+A8qDTKxeJJingq/mOSMW6WcFRK1rJAN0qZYcbf?=
 =?us-ascii?Q?uSVovPBXB7xG4QsJoCfo0CFkVws0ED5PgFTXiM44zE1sh52nHdvN2uHV0pAg?=
 =?us-ascii?Q?saiaae4HbJCeNLIA4cLu/MaYYqJOR4lBzS4g1WZxnKm0KJn2El8fRfSvGU2p?=
 =?us-ascii?Q?tmT+vp+skTPAvcrhZWl52MmbqCNDakdG4l8EQTpu4Lg6N4di3EHNYQ+XA+wL?=
 =?us-ascii?Q?wZf0BWOVb/TzDDJLwO/ZXy5mnig+RGVNhPkUiGTIv1JSMetKGB9HfKmyrN8s?=
 =?us-ascii?Q?18kQnHGoMrqGBVeWMl3xS1ovRcj6yyflPZTqrF/Mz5ZRg0zl1BWFrcVPcsJ2?=
 =?us-ascii?Q?/Rb2Gmp8rWQbkXxSFqqe8wdNXCkOp8+WcAM2KQJ4SHfoMy7bzQ5NkKeeKbPd?=
 =?us-ascii?Q?HZD1dy7gQnrm/IuCyzqqTwEtLB08KOGQW8hEeLvHOVafvXUzL3wO7wBgShhz?=
 =?us-ascii?Q?8YZy/wI1Hhkf0cZgMOolmcIwNWh3xRFxBT51b7LTVStkgX8A5oHCe2aCKcrD?=
 =?us-ascii?Q?/gRCC3YYxTkzP0jzBQ+VNCj8AGJ5nCl2l+NCy639OJX7pCmnoic0Rtqngjqa?=
 =?us-ascii?Q?iietAv+lbvDYP9ztfwaDMcqmkve6e919EHVbZ0kd91ioTZqIA9uCvbVByn1R?=
 =?us-ascii?Q?oICnA+cBAUbTgc037s1AK6dF7e640GFUoFPcXMzILCguYz62+Utu/3OZhqDR?=
 =?us-ascii?Q?6KPEOEpDoZTXVB7MceFuEBLz20RmX/wMwQ2g/URZAZFLVFGitnZn5qUJ69zz?=
 =?us-ascii?Q?Fz4mz3Soo5drNRrlyZVY1FTQ3IEXlEM5mlHRWQLyKEav7fm3+wpEWWmit1nA?=
 =?us-ascii?Q?MEg/pnKsYHrEe1SPuvVtqi2t8/UkeLjT/dYJr6HA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0oW65qHJ8DuSIOfauxyC3oJUwbjzd/DX0XfKQRqPHuwCqP5VQ9H1xv1K1DGr7i1n6E2Gvi4yF3N/1cqe60OxRaI8lr8JafmU9cr604ZbuZbOFn0BT6cH6KA1+FcQl0x3ZpD7GdwYF4IUXT8wXQ3M0+VUQWt9KSVadGAOMC6lVATOhYPpCECGzitndo/vImCUtmS7LChtDdA73I4S1pymUymEnnycPwamAvkZktB2sQh4swsdKGElqb7CD9rV4akKWvc3GLFQCshmcRp7XqRI1UOJT0Ll//THcwiNH5Tr6LKck3a77elhx0zypZSax/6qx7Dj/RJE8JbODkEauBRsCo8xCADH222m77p+zhlBhVT7z/sjA08WhUoqoroxXdpgbXnf3Y0nSCD16TXfnG6chaCDXYMhk/P68kRgG1zfRP4NEU8/m411TiI37GbZ1rsWASCfjl9mh4pIgiyGTXqC/PWV6Fy9UgkK6G6r8tMxsCHFgVIL7/zOp6GcXamgwUaRM2RKRETPVPsLrB7Jxm0h3QQe4w1yVrqyS3lvDeH+1zYQbmmxL7uNcsJE3HBroASqzE4NWAjl9EnwczuM054hXv9SKdCywAS2uZ/AW0BOBZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a712f42c-34a5-406c-b2ee-08dc3557ca4f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 16:43:55.5418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRvleSrUopZXcdujd0sRkQQzZPSnXVow9v9xiOXMRIc1GtF4S8HA0qzTj6ww9G0DF1GakvlwefzBfPw62cmqTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5750
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-24_12,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402240140
X-Proofpoint-ORIG-GUID: P95VmmPrOyKFgGuIZHYgZaLXGAQ-s18r
X-Proofpoint-GUID: P95VmmPrOyKFgGuIZHYgZaLXGAQ-s18r

The tempfsid logic must determine whether the incoming mount request
is for a device already mounted or a new device mount. Verify that it
recognizes the device already mounted well by creating reflink across
the subvolume mount points.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v3:
Fix subvolume create output with _filter_scratch and its golden output
add rb
remove  _require_btrfs_command inspect-internal dump-super
v2:
add subvol group
use $UMOUNT_PROG 
remove _fail for _cp_reflink

 tests/btrfs/311     | 88 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/311.out | 24 +++++++++++++
 2 files changed, 112 insertions(+)
 create mode 100755 tests/btrfs/311
 create mode 100644 tests/btrfs/311.out

diff --git a/tests/btrfs/311 b/tests/btrfs/311
new file mode 100755
index 000000000000..bdabcf6a9814
--- /dev/null
+++ b/tests/btrfs/311
@@ -0,0 +1,88 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle. All Rights Reserved.
+#
+# FS QA Test 311
+#
+# Mount the device twice check if the reflink works, this helps to
+# ensure device is mounted as the same device.
+#
+. ./common/preamble
+_begin_fstest auto quick subvol tempfsid
+
+# Override the default cleanup function.
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
+# Modify as appropriate.
+_supported_fs btrfs
+_require_cp_reflink
+_require_btrfs_sysfs_fsid
+_require_btrfs_fs_feature temp_fsid
+_require_scratch
+
+mnt1=$TEST_DIR/$seq/mnt1
+mkdir -p $mnt1
+
+same_dev_mount()
+{
+	echo ---- $FUNCNAME ----
+
+	_scratch_mkfs >> $seqres.full 2>&1
+
+	_scratch_mount
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | \
+								_filter_xfs_io
+
+	echo Mount the device again to a different mount point
+	_mount $SCRATCH_DEV $mnt1
+
+	_cp_reflink $SCRATCH_MNT/foo $mnt1/bar
+	echo Checksum of reflinked files
+	md5sum $SCRATCH_MNT/foo | _filter_scratch
+	md5sum $mnt1/bar | _filter_test_dir
+
+	check_fsid $SCRATCH_DEV
+}
+
+same_dev_subvol_mount()
+{
+	echo ---- $FUNCNAME ----
+	_scratch_mkfs >> $seqres.full 2>&1
+
+	_scratch_mount
+	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subvol | _filter_scratch
+
+	$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/subvol/foo | \
+								_filter_xfs_io
+
+	echo Mounting a subvol
+	_mount -o subvol=subvol $SCRATCH_DEV $mnt1
+
+	_cp_reflink $SCRATCH_MNT/subvol/foo $mnt1/bar
+	echo Checksum of reflinked files
+	md5sum $SCRATCH_MNT/subvol/foo | _filter_scratch
+	md5sum $mnt1/bar | _filter_test_dir
+
+	check_fsid $SCRATCH_DEV
+}
+
+same_dev_mount
+
+_scratch_unmount
+_cleanup
+mkdir -p $mnt1
+
+same_dev_subvol_mount
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/311.out b/tests/btrfs/311.out
new file mode 100644
index 000000000000..4ea46eab3c72
--- /dev/null
+++ b/tests/btrfs/311.out
@@ -0,0 +1,24 @@
+QA output created by 311
+---- same_dev_mount ----
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Mount the device again to a different mount point
+Checksum of reflinked files
+42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/foo
+42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/311/mnt1/bar
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		FSID
+Tempfsid status:	0
+---- same_dev_subvol_mount ----
+Create subvolume 'SCRATCH_MNT/subvol'
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Mounting a subvol
+Checksum of reflinked files
+42d69d1a6d333a7ebdf64792a555e392  SCRATCH_MNT/subvol/foo
+42d69d1a6d333a7ebdf64792a555e392  TEST_DIR/311/mnt1/bar
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		FSID
+Tempfsid status:	0
-- 
2.39.3



Return-Path: <linux-btrfs+bounces-4404-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B47798A93C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 09:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18EAAB21B0F
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Apr 2024 07:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572D051C48;
	Thu, 18 Apr 2024 07:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZlbALx0g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e7yoc/0E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18A23B1AE
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424217; cv=fail; b=frl7lmQBvN7u9xTNundmLq337izNsH68xTPDdRsZVLvZHXgBtqXc/kUXj3mB9oK+Utj1iyswgxhclyy+wLz4C7mRoUhStGaY86EPMChwC7hHe7g8Bn5D/4TwoYArYeh5iNBNAMV6f7oM6EAbePe9WXjGQx/rKRBd8nvSx1mjdjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424217; c=relaxed/simple;
	bh=oTl2ruqGTK7vcqP96rLd8KHhwZzKQSTOAuJL6lT8OhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SARsnhhXjBfqsxElq9ht921zJeD+VhnQhiJevjl8HepmE77lcrCCKXeHr0rAOq4Ujh3usvnoKdQA+jQuydS9Z9wF2rGHa4u/J8JTrlEhePkNHDRcDiO+QuBukRU4tq2XV9lfVFBP5ZzsUpJCwq55br9b/h/jNa8ZhKxBX8/MngE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZlbALx0g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e7yoc/0E; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43I3wl2Z025247
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=XVPkwflEmkDL7OWBvWJtFU3JZez0zLbBbBaNYgLT85Q=;
 b=ZlbALx0gXqWRYtEUTKWVrEYXA9HfqMku+P2ctHaQhPir9OGncnbS/vUSwwScCrBUr5Js
 5TqMZ3g1/uB04D+/nKojrGo6CSXL5uWM7+2EH/XpxVR3DAJHhR5FJHiTX6DJ9K+DdsA4
 PaDYRrtv4Oo+vFEzx54+UlCHCvqlNQ//cZc1jj84T67itib+4XZN24Hmvl8ft6Kp6GlL
 oBjiyOvZHZ4pTxdKSb86NQn8s6GE4+SQtMkP0WohoRoMLSggvyJPkwYJ+c61DjHYX2dO
 5OjdSMpxKGSUpvWqlo5FK6YWozOA1DxuFy1E6dl10wf0KXsUT/jZKghW69xuY6l37ZMo 2g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xfgffhnyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43I6HG0P028852
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xfgg9y7ke-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Apr 2024 07:10:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWA95Z9p+Zwt10Jl0ZZlMHmhH1RIgfcV4CGkoyV21Ezphc4J5ELKGJMJvLgeLCMRpj5FHthzm907Wn4GpN4tGBp1whEkS5ylH2H9UbRD6qhQaU6fW0aX19j194Iu9z7RFnVa3hZYQW5Kk52K0t5PV2p/FLRyhoMaGmJhYn7wvt7erxC7Qkck8TuSR8zDDyWVEzkoXy9dsNYh7S1IK6wcyMySOeEnqxMBNDxkQbXjs4VsbN127iabxqQf0rWVag7jwbeZJS9QPxWGog7Lw0nbMg+AH65pXbxmAqFza/WbxxNP7tYWABEeTb1K/IB+aesHHcYjGX13EMg4K0w0wRAJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVPkwflEmkDL7OWBvWJtFU3JZez0zLbBbBaNYgLT85Q=;
 b=DEJthqjzPjPalUy9L8vUk9Ke0RwwCZu9wm4IpK7NSqoZ6BpKR80jXbb9lqxP0lBsZ1SaECDIaBhNBxFzdCof571QF7BkPSNEpWYOgLLYE3SsAIiKay+3YrFZdpnqUqxLypzDvXF1JiPpymIM2fwmSgojefOPslVev0QO2A7gKykxhiERRRJDFNBoIfCdlGpc/4sXJQYyr6Z92KzQIJX+/QYkyUVuJyX7K4U0QBGI+eQtpPyQvYtqsr2KFIG9vfJJZwrGz1v3U4YhSXG3FltGR++JulUXq/VYkI36Z8G7Jrs5P1Gkv9JCeuo+rVf+y5fTb0am+zqabviOmk9FSTDjBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVPkwflEmkDL7OWBvWJtFU3JZez0zLbBbBaNYgLT85Q=;
 b=e7yoc/0EHQKuy6OAf86+TzxeO917GWWPkR7il/Rn5PRcTJBNk1UC/G1Stb55XoTA+loSP/82D95pc//DROUOTbG3a1JByXrAKduYInHQnKJqMBuymPdr1PF7JZSUqC0LsyhfXfgyQZK6u2fa+dN0Eg3ZCmxJSJM805NKq6EGQcY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 07:10:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:10:10 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 08/11] btrfs: btrfs_qgroup_rescan_worker rename ret to ret2 and err to ret
Date: Thu, 18 Apr 2024 15:08:40 +0800
Message-ID: <ee42232d8f67e960edb1c67940d211b46b787489.1713370757.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1713370756.git.anand.jain@oracle.com>
References: <cover.1713370756.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 6595f016-4d79-4032-ecc5-08dc5f769568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VqyD0zv8D5rF+EFH55KbA5P31Q4y2tOSamECgRAQjIy4MIWaPSqbEs7mFCzKMze9KlexNAkoFKOmCyO5c0Sd0EBWHSHwrI06xHU83UUu5kbmNWI1DOIrO7i7WsjyOtmFIdlNx8eJqKVOE+aUxC4DBt50dsOCFAlG/5pKeItvduAEesL3BlsFq5z/p6Os/6K+nD3AScy63TMO56qN/FQW26gYC8YBa95IanrYJvPg4Y2P3Cra0Hv59YSSVL6zOXNHAzP6l6jRveRDoyo3PoG1EjLvS/8JRcU0Czo6vBcgtNvKNjYZbLZ6Ly1n/v8WsIe0pcsnK18OhsiMwmejYY+HIL/pwW8OOiZIoVnu6e2gM8p+BPATikCAx7hS1DvMkXM23utGf0CbCihBHK65leTnGzVOf7jfIFXrgf0wpFi8vVUvCaSuv+hwMzdCu18cq3EChDUh2UyJ37TbL9abUiFEJDo3et/0FAnuK+PupgXHgunPS47xliaoPyM2Frz3UEFBI6OtTuh5hhTHKjSUlRDFWmzzeazTK3GXGv5KXPpWwpq45bygBfEADwmbUrnrlYofw+2UQVwwPfEpmdyx8jtQnMvzhdb3Xp3DaGyW6GpAslHmixDhBoDw5+tSyD31TPhqgPXmCMspwVjQpVq86nFK5AIranu73cy21t+R1uKn9XA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mh72bwpbY+XIE1v4VhpY88L0re4t1T2gKjGwOnx7iYsTKsWwwW7P4qiWOxW+?=
 =?us-ascii?Q?I2T4/3BuEIj7b3v6AAN3FnAgMd65fqKygm/vkB053YVdjfncszspWIMAd384?=
 =?us-ascii?Q?pSiIuK1v8E6MTVzVzqALg1LQNOxgCohC9m/XOp8JssQaQWurvG25z4km6rwx?=
 =?us-ascii?Q?8zfXRY33kMDLFUe2eUGImZxU7ZNKCbFuAOo1Y8mcp4wPH5rsG6CJa8BRtvyb?=
 =?us-ascii?Q?RM5KLGoiBmSXhP5qsytoqxE/HB4xPXxpV3PS4aXBM0Rxcl9qgsilM6ivGt0d?=
 =?us-ascii?Q?xUzlWCblM4rS/c/Mu9CuXZVbAE9NGMIPmn4+p1CmFb4Gv0d5J7Wuq18wI0df?=
 =?us-ascii?Q?zhh8Kh6TZX63XInuFmWanzs+VRaYDsWHCkbmN+Vib8bgC1MQXUVl/orEHhjE?=
 =?us-ascii?Q?xAVIScJPxVKrzB2mIriyjDXgx2h3xJgtCO3QtgdYbayNZ2QybPucihLJEv8E?=
 =?us-ascii?Q?QNixdrIC9TmZTaXCC7vsET9ruZIDHLaCUPcQb9uk6imkCQQIKLs04uPvDWL4?=
 =?us-ascii?Q?IDEowqUrrd4yCsVGP0CFNf2UJz4b40s+YKUiZaTQ5pduas4gKQ/8Rsx9tuT7?=
 =?us-ascii?Q?6jodrBVrZdG1nB46f5cBH4b+XRh9ZMWxxKK/HhpnyFvCIsNVwHduhesB1jRv?=
 =?us-ascii?Q?1R+1Y15Do/CH/caB8A5S2unDfd8DscPu3geJcVFP5bLdm7dZYJWHBwYeJGqq?=
 =?us-ascii?Q?zs5uODK32iHzRNFXiBIFEshyIiL5RZzl1O4PLlOQ5kAyonRfXq26fmlGMVGx?=
 =?us-ascii?Q?aVEqWIHWV29+/0rWf3ivjJl+102CAK/rVUZc2pIv1d8NCEUgb4cU6dMgD4uC?=
 =?us-ascii?Q?7yZhIA+Kvc8DxDf+ICp1svI3Q1g64pkCB91KU7kY5yNJcQwLR0/haLTRssBC?=
 =?us-ascii?Q?2by1T6GsGxacd/pZtk65ZSX6xJGcCnwXW36PFlzB8wxC6mw+8ClYUQyZZxy8?=
 =?us-ascii?Q?gd8/NzZSwvAqnTsgLsG41qpfwmPTgZrzGthop+vQ/yAybdNL6b6yi+8M8jri?=
 =?us-ascii?Q?7BE8UYLeDVWWXH00kK4jhoFVt9TzB2TMQ0oxbzlzVnfjm6Yj0vbrHrpDY1hF?=
 =?us-ascii?Q?4g7Uot1v+fDeNRXFGpbbjmpnTB/mTjmnj6cTgPoex3mmB4Gj6KJ5jY9XSv0G?=
 =?us-ascii?Q?k7h3/LHpF7Wcld1X25LLPFv1zGvJGwcEGJJyHfMPYkw2mkG4xzrp7NIO5MjJ?=
 =?us-ascii?Q?sxUNORG91RR91Gbo0q/Q+1X18P7svaOxexEoDxsyZFcRuS2GIZC9GkGQZ511?=
 =?us-ascii?Q?PyqNEqIvpJYAOqbvTVUyhOqHSkzluJ9K3FzMilWIToyjniSoKK7VjuNfFRCo?=
 =?us-ascii?Q?Tvy7WGdKN0i30ueCv0a0m3KRh7w+dnChsRPRABj5ueBPQ0oJuv8joG6xJuy6?=
 =?us-ascii?Q?Is0JYREoClxYDxsPEfVZ6EI4JdBjg7Urlwgi/WkPMHkHtzqbPBzsBdfIaB8t?=
 =?us-ascii?Q?4Q3QmSdgqG3DlalAWwxD7lZaMQ5zDKzdD+DkdoT6nRnw+JsEteMn1RtcbArc?=
 =?us-ascii?Q?4UuUipMzdPp0il3entMwJQkBJfVbmaMXvebem/N7oDxkayPUE5VVyQxNtVE+?=
 =?us-ascii?Q?3RyG4MrFcJE51BDi+iBTBpzrvAyjWHhR9j4nS82m?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	axlOnSBZvJzzUIWK3B2aJey90crDOJl/ow6BrHfl5v0x6xr/VcRVir3R4lrgH3ZXSzrhTIiGbKEOBD5pep1mhvMR/LYGPCznYLfDm26YeMwZ/3aJFRKiEV/23Ih3W+61+lCVgw0WFYWRzd6c+y5JtbcSRSGu+hsjNAMAT/b5maVZLhmgvDviHdP+VpOFwCWuB+CGL9DkK6nU+1cKZN4ARd3qsJueblDVJXrlj+Jeb/AyNdvVlHg/ycaS4wTv3Lgb1WLHuHJAnCWi+zzhNaz2ryn9VVZSCCvE/59ei7JIHlJmB9O2FDwrXqHmM6rfjXdkGViepB6HvR+Fz7YhEOc5weNCp84c7CIYdumJc8elSH0d/ljivfZU/fMRHxMcIpwuIE8V/eVG26FljinSH4hOPIK+nRLPolB7VLfCK6lYgy0fnuakpMvsc+3qbRXeuTYSfGxzJ0h+msyNICjJUFol51NpHEi4V4gsnWpFGnOU5kEbVHTZgoZ4cfYSLnYRz7Ejpqo2+l3KG/PCrQjMUPKax1tgQLcR/35zZmKYDclAEwiIlFhClALUpLVWWWvrQI2t/VQSEL7BV9U2AnKuFaMouc3T0mZINe65o2/Q6AWdygI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6595f016-4d79-4032-ecc5-08dc5f769568
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 07:10:09.9819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVF7dZMevZGcDDVLPhioUgVnSjdwHDErn5KGna68UmNIbGHNztVtmOLTX0SIvzzORgKzu8dwdtNhPGtEMWLHOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_05,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404180049
X-Proofpoint-ORIG-GUID: jUr08shKn4Snk2y7L06rKB4onI-VCzUa
X-Proofpoint-GUID: jUr08shKn4Snk2y7L06rKB4onI-VCzUa

Rename ret to ret2 compile and then err to ret. Also, new ret2 is found to
be localized within the 'if (trans)' statement, so move its declaration there.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2: No change

 fs/btrfs/qgroup.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 9a0f47d0c6bf..8ae0e1048b23 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3703,8 +3703,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 						     qgroup_rescan_work);
 	struct btrfs_path *path;
 	struct btrfs_trans_handle *trans = NULL;
-	int err = -ENOMEM;
-	int ret = 0;
+	int ret = -ENOMEM;
 	bool stopped = false;
 	bool did_leaf_rescans = false;
 
@@ -3721,18 +3720,18 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	path->search_commit_root = 1;
 	path->skip_locking = 1;
 
-	err = 0;
-	while (!err && !(stopped = rescan_should_stop(fs_info))) {
+	ret = 0;
+	while (!ret && !(stopped = rescan_should_stop(fs_info))) {
 		trans = btrfs_start_transaction(fs_info->fs_root, 0);
 		if (IS_ERR(trans)) {
-			err = PTR_ERR(trans);
+			ret = PTR_ERR(trans);
 			break;
 		}
 
-		err = qgroup_rescan_leaf(trans, path);
+		ret = qgroup_rescan_leaf(trans, path);
 		did_leaf_rescans = true;
 
-		if (err > 0)
+		if (ret > 0)
 			btrfs_commit_transaction(trans);
 		else
 			btrfs_end_transaction(trans);
@@ -3742,10 +3741,10 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	btrfs_free_path(path);
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
-	if (err > 0 &&
+	if (ret > 0 &&
 	    fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT) {
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
-	} else if (err < 0 || stopped) {
+	} else if (ret < 0 || stopped) {
 		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
 	}
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
@@ -3760,11 +3759,11 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	if (did_leaf_rescans) {
 		trans = btrfs_start_transaction(fs_info->quota_root, 1);
 		if (IS_ERR(trans)) {
-			err = PTR_ERR(trans);
+			ret = PTR_ERR(trans);
 			trans = NULL;
 			btrfs_err(fs_info,
 				  "fail to start transaction for status update: %d",
-				  err);
+				  ret);
 		}
 	} else {
 		trans = NULL;
@@ -3775,11 +3774,12 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 	    fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN)
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
 	if (trans) {
-		ret = update_qgroup_status_item(trans);
-		if (ret < 0) {
-			err = ret;
+		int ret2 = update_qgroup_status_item(trans);
+
+		if (ret2 < 0) {
+			ret = ret2;
 			btrfs_err(fs_info, "fail to update qgroup status: %d",
-				  err);
+				  ret);
 		}
 	}
 	fs_info->qgroup_rescan_running = false;
@@ -3796,11 +3796,11 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 		btrfs_info(fs_info, "qgroup scan paused");
 	} else if (fs_info->qgroup_flags & BTRFS_QGROUP_RUNTIME_FLAG_CANCEL_RESCAN) {
 		btrfs_info(fs_info, "qgroup scan cancelled");
-	} else if (err >= 0) {
+	} else if (ret >= 0) {
 		btrfs_info(fs_info, "qgroup scan completed%s",
-			err > 0 ? " (inconsistency flag cleared)" : "");
+			ret > 0 ? " (inconsistency flag cleared)" : "");
 	} else {
-		btrfs_err(fs_info, "qgroup scan failed with %d", err);
+		btrfs_err(fs_info, "qgroup scan failed with %d", ret);
 	}
 }
 
-- 
2.41.0



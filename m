Return-Path: <linux-btrfs+bounces-3523-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A86D887D39
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Mar 2024 15:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AB45B20E99
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Mar 2024 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F615182DD;
	Sun, 24 Mar 2024 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fo5Utyh9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sxWNxh2m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53AA17BA5;
	Sun, 24 Mar 2024 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711291681; cv=fail; b=SDpXf8Olc3eHBCJpnMigk18wvR0MGIXcyTskR6YWh4bzxlwU3RWinCwQxmnEevP6ZQerlJh+wPBVXu0PQpoSF/cWe7W+EPecSu9XwKes5rhp6zcHvhrNB25iYBIcM2y1Sdn80adBjshJEyUMzZLvMnviVaOIukACNpqbRR7poUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711291681; c=relaxed/simple;
	bh=UpBJ3V5sB0/b86p3+rn33rTDL8jI/NAURPc9hiITz30=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=t16s5DRuiQeOnNBWcQc8HpeUVsn5/RxZQLQorhIasmJ4PTy0Sj4iKFUJVcXFMXG5NS5A/IpS8/dwmGoN4uawbVEBzNG9AcC9A6vBGEplobk/tmMfHeVx1RBrM8Pcy5YDSLLKt3Ye8K9UZApBaX8chhwcYkrQRDKeT1dbF1lek30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fo5Utyh9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sxWNxh2m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42OE1vNi016874;
	Sun, 24 Mar 2024 14:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=6ZBYfApjZ/oW4xsg0eRLzNqK/nAv0ulqc6n9eRIB1MM=;
 b=Fo5Utyh9gmR/0UYcK0GrZshKlZMFe4ZUlU5nj7W78q7miX/sBK9Tp2wOIcsr+b1WJ4Md
 VIcpK814iMD49109kvgmgf4R2g5jaFehxvURC/JdLdGUbPPI9dLTQSc9xvRmhOzsKufK
 ULUU1ugAP1tVBiTyXAy6uzT01dmQkv/gnh43skNTVWZeMpGK6YHLG5tpUsRLUYLCbVX5
 6yi137KHUEzNRX7Eac/+LQBqe/BoJiY3JKNJliCyA0UCfbWixh3bwuyBgdgcg3WPMJyn
 67CYjDIj51dMNQ5dpBGbVQUTHsUfbEIZo9RTAVnUuXZi/NVXd1QGhcif3q/QNgFDCTS9 Aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2f6h0b8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Mar 2024 14:47:49 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42OC2kNb039224;
	Sun, 24 Mar 2024 14:47:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh4mndt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 24 Mar 2024 14:47:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/AR6MlBKBDZwYpTBws9HI/+KtH5LhHl2L/Y9mDKF5KxQ5jFs59iuI65ihLQTStM/jHk1/IwlBgOHMm/NlPhl3kmc/0sn9TYZdteuJoJPZ6erSbDtmHWwiaB/AGVpaijetEWow1VlGy2q1Jyy6sjd9wIjCLrzRt2tzG/8IuRziIBOGBj9TRm4zWF+vV2hhHg36PXYme4JEq2qUkxrCByr8xg/2HRNtZZOxoFvI8rdY4rwdT1bsgq2bm4GirKWE+6jsIwfReCGxPmehE5z8isiG2LlcyaBEAWI5H4sbPbUbXuRgrfu2pFDXQrcIqXp7Lrxgx3lynOoc34VJKhsGwhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZBYfApjZ/oW4xsg0eRLzNqK/nAv0ulqc6n9eRIB1MM=;
 b=kFRLWUC+bsgeQxqHE6f464trmuFMgvi3ANIEQT4NR4IJdPPUNpJVEb1YeB4GgDk354dM+43dVW226N+NXRvgXYhqISkJfOsgUDYMXpgXEL4B2Z2eCRp98lF64vRBuhhqvb/j+ObBgyLFohCUgnL52Jq7ahDGh1jEyP1nyR3Z7IDUpLiteelIs1IwGYnPgQ7IPhWiJTXXHYuAmU7Lj71fThw1X+c90Ph6Feh61HRhP5s3SPygZ7aTWcsOSyxG0Sy9gLJ9VxjoDKtplwNI7CoLYLgIjq6qmffwnJ2UuicymGr9MI/rx9fP+fQ3Qt4mhaVML32MjRZ2rkS68yGp3o5pRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZBYfApjZ/oW4xsg0eRLzNqK/nAv0ulqc6n9eRIB1MM=;
 b=sxWNxh2msMXZ/m0X2YQUJtsYnfxYQ+4W/lukVrUFWQAkcLjl9CYl3bwtgdAFBLuVEPTE3zTvlA3DkT1D3UZPD9aFrdLlz3cD9cNpHHCnTWFNtvJ9ab9VIETKiFKTuK3BpSAI0/u5WKFe0K5pkQhM/3USaLd2JszH6ul37Kf5F6A=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4749.namprd10.prod.outlook.com (2603:10b6:a03:2da::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sun, 24 Mar
 2024 14:47:45 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.028; Sun, 24 Mar 2024
 14:47:39 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [GIT PULL] fstests: btrfs changes for for-next v2024.03.24
Date: Sun, 24 Mar 2024 20:15:42 +0530
Message-ID: <20240324144721.8343-1-anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4749:EE_
X-MS-Office365-Filtering-Correlation-Id: 815a7875-05ee-44a6-193c-08dc4c1159e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IJgOk48YX0rZ8o8+nS4cObZu9olOPwOLqFBRcpYsOEkvTn+a+sOYpdgTTfOoJBXZbi1h7zOJKy48ht/nWpntyQgG37oVf28hdL59/PjQKb3+5Sf8q1S+avPYrQz3R2jjIbx8bCfm/iEMF6FEGpSSJA1o97HSiTKke/QeLeTfFSe8tchCVDspUxB2HOAgmNKUGk5X9dzAgJu42Gl7aaIb+YV3VUb3ehDtlvAyCl4FQxijOumgpCuxYmz6+N3KSbxFpTg02CxZykvibZtCfcG3ooGn8mCfKmtGPmHV7Of5aABq1PVVGwhLxCedyDwOT5vCZxQVTXg4m6Q6wxS1oA0eOuZa/hbvVlS5KYkzfFGO+9EyRP1EyNUE4rlfYQc60lyjPwUlXZ1Yei8P35xhsfL5LeVSPYP6NBoAjblo8joJEQ8EFzpUJofo0eoZaEj2IHw0GoWOqhvokwQnPucJP94CxcJD3ISFVMieISXwsxEQCsHYKP9QtEi+zBPCHfJ/IgL4u8vBC3OoE4i28tr0HtFLhtdsgvDWIIvlV/fLely33McP1+u6g4djhpBMn0IfxVWY8zY5PojuTGdZGnSv7WxMkvxBROIzRq8qvNBRMteT8MQpwOyGyjXkllnSFDa/thz/kGAILqoMbM73Hm5BV21oze4yB6BfcN8lGAt7CAolDSA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VfzZC/uOEHm8+SBm9T+tOv3OvIfR2vv/dCNh6hNjAak6Zw3T98e2JTz2OjHQ?=
 =?us-ascii?Q?iL500fZbvVMrVyhiY1Kv0IxI6Cze5V5xG2mUqSCQrSHaiRqoYv45YcijDkq2?=
 =?us-ascii?Q?qxk5/z1nksnpcp6vpcpL5eIPPd/JVnx1eMZ26F/9GQMowKk8+IA822S2MbDS?=
 =?us-ascii?Q?pPkQQeM3ebHMf2H5R/CHqhqnHgUY33hvjRHV0rd/RFyoTnvW4UowT7PA6HVQ?=
 =?us-ascii?Q?MMAxQ7HPYG1CSUBvQ2aOPFz6AJK/m2RC1cf0EUKbtEBpQIaD3BW58cM4Nzhg?=
 =?us-ascii?Q?UegbxZo9ijbRPjQEd9Fbab7gfir581e+O8hotkuXoOHfPjMAHrpw/GJTotKG?=
 =?us-ascii?Q?9sNHC6pj4USXiSvi+TY2iBug9yD07wO8d1raXZEa9xHKEE2Rv8fAUVzcFhVU?=
 =?us-ascii?Q?Y0mW4i+qtMHViSGP/V1+/zXZVbYtT5/DFJKA025pJqh4HtqgOVpu9+far2V3?=
 =?us-ascii?Q?9VCwpBsuYeCuT4o20U54N5F9timmYCBhAaVNbfnZar7Y65JBH/KlHZdg5+Gf?=
 =?us-ascii?Q?CXoy8yCYV1zfIfi44UUPhdQku6Zti0JcaQr7zpYkIo/1wGH2Mu4fncZ2BEaC?=
 =?us-ascii?Q?SiHvbkAW8JdVYxHOSohw1AR/AT/CJdv+w5j2idWLgJ2hVu4WVz1MZsUNcucp?=
 =?us-ascii?Q?fkGWezJ3XgwGsNgYRZCAro9vdn0cAUXkRnGW5GT8Z39iSyFUJdbLgD4J3Ko+?=
 =?us-ascii?Q?7kXxXL7sDoKDWnSR206i65+v0vekg7mRNak0OSSHXj1Q2BxhRdL1zyT/WE1E?=
 =?us-ascii?Q?bq71n1tXOBYM7z9aRfFs2R9DgbpKHuwHQrFsD1o9NxA+CFzZoAQLokTjCoQi?=
 =?us-ascii?Q?Neyg7upAr881+k5K0YYpfmJfZpofti4LKbjLJpBdkFzNcb96qOnV7AZi5tHD?=
 =?us-ascii?Q?vARkeQfjHoB5CYVz11GVR44aZLba5W42vplg9LcOR4nw7huGitN8AvqF3Uhe?=
 =?us-ascii?Q?X9SFpdqfJjRh8TL1QfTZxXKO9bn1fpCC+QRFg7QwRvSCQCLMlyGVKYcT7bqP?=
 =?us-ascii?Q?MB/mRwYxC4tiinsK1XU6EzpVpPKOA1hgqLlWSqq9jdWdl6gnVWEXgS1a6Mpc?=
 =?us-ascii?Q?oO9vx+BAeYHriQr9a/AXiiFOiRRoNmBAvZ5oz0TGN3wx5j311hKBJjZy/PpE?=
 =?us-ascii?Q?w0uVyq1ruzuEKTJ4jhFFGhgKk8tM6N6VLfo0M9emDwMQabYSDkplI2RFjCj/?=
 =?us-ascii?Q?RwoseD7PBbFwlt27XQI+7BdKRZ2qDwlyvl+Gn2o/wnmw3JSVqAnRRofmRbcv?=
 =?us-ascii?Q?/PR0quu/hSEmnVKh9yYQKaueG/fCpN4xPRaSdl+OLk/UsNZEwHloBcEh2Pq5?=
 =?us-ascii?Q?m51BdcT7wigP7TTLi3+07wmSwJudspT/KXtvsKvaVXIkYsbSjIF68wizq9xo?=
 =?us-ascii?Q?u7rboqFylxPy8YYwyt0B9bupDrC8vpj/2yG3wCEiDlwFH3JHwDiKVn+4uwY8?=
 =?us-ascii?Q?0GJMIpWsGuXoAWP1cQexuTDWtgTLXaDKMkYSX6ZnYtAoM6ZlO+YxukHkNU5W?=
 =?us-ascii?Q?Ell9ekqzHnsDXYNf/y4Ot/TOPWkppOQb4uzsmqOrtg76n+MQF6c562SYcVWc?=
 =?us-ascii?Q?2eZQ6875Ro2H98rx3SmGhYdaVNWnku7ekoqoIu7SL27pMZ9L6iPKX2A53KDL?=
 =?us-ascii?Q?9qCuw/6HRXF1xAXdi6Ia7l1GeykbI8/cKT3x2tBCuziG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ussX98cOUd+vaP2NOk6EQJv5Bm0sebNcsfA0FdZOmtrRAZt4ZgExUElqK7/980zbIUmf6tipe1QMO8Ho4TpxsZ+CLPi3Yz07R3QDRMr/9t+rS62zU7KZC9mt/HlSXDPovoL5Q1uuToMezy/F0OPx96rBy4qP70CZUm2L2moMwKFfgtCqCMH5nzmbHw9fi3F5e8ftUtWu0N3xnEW8j/lphweuk0RAVP2NOw00/TV/U1ufyvisb2ISIqRs5aOovniVi03UBFqFEZDOgA4vYlyHN7Qrx5sdeALaMdLIfWH//4IW5QqWDVpL57dD8cu/kL3NODRtGLZKtdYzebZWvVGQg3MJUIDmH2YpCUTghLOJWSKZaXchr6pernKOECRv4exwi9Rq4+q2rw/4X8lGijNX0Qkqrt4WbAnny/JZAqVBgRNL3i99W/yxmZJCQTIgebFzVsVmyjHxQvOvAUUNOhUVX3uT84rxhMAN2Zsvn/uiBESEO7Q2CpwJ1ZqTAEfTCmdAQ4HhnK4UfZabXnaSf65vyPMKJui3xA8L4gZdf/ytVf304Brcpsl1AqlRksswzLWzpz2p3jEO5moldh8CT7wGZ4FoV1VmMe1Y+24uGWyYNDM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815a7875-05ee-44a6-193c-08dc4c1159e5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2024 14:47:38.9179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNOqfG1jXCIXpb0JA9yRDD9WBLGNGhv2rl9C8EfK1MYInKvOH0I477KjswGZ6KYOIdiiY4LewqRd+XYsK/qpAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4749
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-24_10,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403240094
X-Proofpoint-GUID: hklLEak7jCmjI6aeguUHFU-WZfD6VgO0
X-Proofpoint-ORIG-GUID: hklLEak7jCmjI6aeguUHFU-WZfD6VgO0

Zorro,

Some of the patches here were part of a group where other patches might
need revision. However, these patches are ready for integration.

Please pull.

Thank you.

The following changes since commit ec5b77f70e602b2312bd25ac9d6f7c507d47f2a6:

  fstests: add missing commit IDs to some tests (2024-03-13 23:56:38 +0800)

are available in the Git repository at:

  https://github.com/asj/fstests/tree/staged-20240324 

for you to fetch changes up to 805eeea406a7cd78ab76f91cb061bce7e9a3e83c:

  fstests: btrfs/195: skip raid setups not in the profile configs (2024-03-24 19:57:42 +0800)

----------------------------------------------------------------
Anand Jain (2):
      common/btrfs: introduce _require_btrfs_send_version
      generic: test mount fails on physical device with configured dm volume

Boris Burkov (3):
      btrfs/320: skip -O squota runs
      btrfs/277: specify protocol version 3 for verity send
      btrfs/316: use rescan wrapper

David Sterba (1):
      common/rc: use proper temporary file path in _repair_test_fs()

Josef Bacik (3):
      btrfs/131,btrfs/172,btrfs/206: add check for block-group-tree feature in btrfs
      btrfs/330: add test to validate ro/rw subvol mounting
      fstests: btrfs/195: skip raid setups not in the profile configs

 common/btrfs          | 20 +++++++++++++----
 common/rc             |  4 ++--
 tests/btrfs/131       |  2 ++
 tests/btrfs/172       |  3 +++
 tests/btrfs/195       |  8 +++++++
 tests/btrfs/206       |  3 +++
 tests/btrfs/277       |  3 ++-
 tests/btrfs/281       |  2 +-
 tests/btrfs/284       |  2 +-
 tests/btrfs/316       |  3 ++-
 tests/btrfs/320       |  6 ++++--
 tests/btrfs/330       | 53 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/330.out   |  6 ++++++
 tests/generic/741     | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/741.out |  3 +++
 15 files changed, 166 insertions(+), 12 deletions(-)
 create mode 100755 tests/btrfs/330
 create mode 100644 tests/btrfs/330.out
 create mode 100755 tests/generic/741
 create mode 100644 tests/generic/741.out


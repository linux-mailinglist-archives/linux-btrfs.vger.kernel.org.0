Return-Path: <linux-btrfs+bounces-3403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E314D880009
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5E0B222B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A77651B4;
	Tue, 19 Mar 2024 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TzVhds26";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S/926Gss"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3F454FA0
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860230; cv=fail; b=YXSKxv8KuN3qAhn0swCgPxLv3kxf9lfwN+XDxMzuS0sL8bEBDlLZC4P8plD+rBa8ZxqcjvoIeQlWcQgimEnFH+UhRj/p4s1QR1ik08Bwg5eiv/S2gJG0UnXBjpqYXrUnaWBfsh1e1cFKZLj5qxDgvhXZ6+pYSMRMFKvlneAHCZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860230; c=relaxed/simple;
	bh=wZwnBX4UgfUrMFynw5IukvUWkBxgL10B8p9SEuFZktY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j12P9mTB51dKfPlVWSjfqP4amhiteU5R+/3nnaIhJC8IPgvTiNahE5+JfsOvwziHXDpeynUetmO+1/I8Gyg59ktcZTpdYAqBmJn9RDuvQo1ozid9SB/iieHYOja8ecoe9rrZxKZa7ITdx/6ZSLXPQV3ZWCx4gzPBfE8m6+WYt+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TzVhds26; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S/926Gss; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHU0J021005
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=7XnEnGDHTSXFSBl0yBiKecok7eaf/76QZfkSnZQXXxE=;
 b=TzVhds26+DzK1KnMJ+oezVyxXy1oKel+jT3R4hOOhvTgxLf6rod1ruJXNWRnGoZ9MS/q
 8AeuHl9b1UJHlEt7VeYafF8FcPgdPqG8bCcGVo5r1FDToWVTop3OlCKP5XzMann/1TpC
 /qu3iDlvH5U/N+aIodokwgCxKIYEaylis7aS5NfUsO+m3uvBrDzojYYaAK6SWmR0LV8h
 +jjAwwqdrTe21RF7PpNfZ0gLX+QDWsn+NVBCui2c8j9SiiR8OvhWnrVcDoabICGivNLc
 S1bvKuhKnYN/MRKeEFsePRCR4yvLruURlcmid+/ZZYyyeAR4EfnFfJC24VFS4eqn19hj eQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww2bbns1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JEDZ4E024144
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:06 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6mrau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:57:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/isTdlyIQrtwRZCj/23vCowlevbA8dUAK70EKPXZdBNC1qei3DAcOdqaqX+768RfVr3VNEBF71Zi/RePb73uO+geE+z4T+AZXQqO3xd2dxGSCclP8WoQcj+QCXi8JPXyVbt1ZMjEqyrlgtHsjIZFK7Fg7YcY2N4aeC8MNZkPRiCzMeubzjlHprhdXpNib5Y2yoRWMgnBg2K8PyHX2efEz8cCChWqoTiJfvBJ3Oo504nIAOvLjoE0m33j594f2uylR+R7t4b79xsAETFLnCtADQf5/a1ZDIQ/KmwEG0FXa+vLyL2ytiIt63djVFBwK093KVkol/aScXVv05yRayYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XnEnGDHTSXFSBl0yBiKecok7eaf/76QZfkSnZQXXxE=;
 b=Y1YnkzOiau8yVoq4KJ329QE//zr8VyW2VP5qMDBfvB0n8EkzzpJstMTfAB6L+2zkufN0oSGPyiSlomtK95m0uqsvq1GOY1+KdEwnIaiShkhFwHcWZ5xpSy3sFpwLtGXMNVgEYEIuRXTAXj6KKLYQAIwyamj9LmtnaFd1jBUbhkJ6d1bSNGRQcbdG78opBn8EL67+30fM7Owa7j595kDFvur6p5ckMnjHVcwRov1TsqOSBXwzGG021SJ/XhgV9mSk5F29J9IKw2kW4DLajMvxZtU7T4UYgxSvWFau8oLfCs8qPI0WFEGAESNGFLfujocpkVZUli1hz/WyYH+hrds2eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XnEnGDHTSXFSBl0yBiKecok7eaf/76QZfkSnZQXXxE=;
 b=S/926GssKP01VJvJEOXYk/3C1V9SdFhG1C/usqZvbCBiQ+F94eeGtkssuP/oK5IG2YPYiTGl3usbzdndjC//VcOSE4osEmJFaMgpAwCtIIFKkqVAvOQj9n3rYBCcrAn+LtEnTflzIJzdomRFBq/uaNifhlULZknYGpHdgF2NOiw=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6479.namprd10.prod.outlook.com (2603:10b6:510:22d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Tue, 19 Mar
 2024 14:57:04 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:57:04 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 08/29] btrfs: btrfs_ioctl_snap_destroy rename err to ret
Date: Tue, 19 Mar 2024 20:25:16 +0530
Message-ID: <5c15288e61a39d24273b402721be934e2e400368.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::10) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6479:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GH74kYL2nNG37umYlWd/FBqIuBb78fi7AnefZZwcDpRwboc70vjii9q175pV/a/XgpQ8mWrj5hjjwTSYaywXQEMIIrE1EaufV8FQi+Iwv2Ml4CZh8RvhjpWh6Op26tONMzrhgA89+iP+9TGHPT6DZXlWD2XR7oULdqGf3oejsfOoI1yNEmhzw8orGadJpCht1Oa2xeRiDsU6uEmJQ3+ZXjatEBElj7BKStfa2tlaoa9cyakdoGY5lBzKROp/cv9MiBx29gXXPt4TckNezLeRsDSybrk6lxjZA2LJDG70Oi9Dc2OGqKWW8aPCRt1Nbd0WBeoWlsxrtUbs3hUWMxkICsPr+hHVak4TJmw5HH+Gb2O6yLoX9IpcD7iOGzqMqLtNDFTC+XHjyIcHWCC5G3wsZK1/VAhB6UQpvhOFp2Ch7rT74YzBJhnXGbA804vpnLxcurRaHHvqDi78kNYU8uTzlPTx0eUhKhX0cEECW70Sd/czXVvtebw2oveT1kCSJnem6ZLpPsqWP2A0w8KmoQv0+6F6Raz7b6k2lm9WQcByCX9qbJ5b9mIwx4Jme6QCPRd3oIKbr7CGPgT4urunYloq06zpmu6WaGtbWvx9XksNpOnKxMKQThAzEjaoXIX7dKKVIk22eEzXXvwmEaOhwlVL3nwheAI+vUABkkABG2G3bf0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JUZU6AkHPWtEUYe9Tdd17jt2hNf4JC33U2SmKnCEBgYnwc/8zsAZ7tLHODl/?=
 =?us-ascii?Q?By0Y1A8gzA1Hkza5U3CBgx2vd0v1oOQrNUm8hqPikipwjKrbbBR9Aro/JQCy?=
 =?us-ascii?Q?JSGGL4gQJ0GUz5mlcjGWcihyTgQ5S++DOVKAcLF66LakKXn6cJHmxHMg1ofk?=
 =?us-ascii?Q?OFZyGZK/3uE9U42AHP45UtitNPhH4qrSAdgkS6V6v9flCOAHeE8upiJxol7E?=
 =?us-ascii?Q?ZKC/70yYSO2JFQfCzwRA7IUF/PYInpoVA1xN3T+bc+SSHQn7kxZgV1vynkyt?=
 =?us-ascii?Q?nVM7h+0OhZ47M9asbKwuyRvvD7nFVwg6WD4Q8XggXyOJuFzBulULmgaU72lY?=
 =?us-ascii?Q?ie7GiKBxIgwHvXXvxd2A4g+LTn/LZVsblO53djdCQQd/40VzqZY5gG+xVIvj?=
 =?us-ascii?Q?Ta3mjznAEdiVYVjiGV5zP6Zh4I0izZD2Vd7qDpDdqE9gDIBr6X8zYa8G4bsd?=
 =?us-ascii?Q?FEsa5KmuL7hawQPnSCbanXkSp2Jafi64Ll4qi5xPuJWrQjnoJLTpMIw7rFPl?=
 =?us-ascii?Q?GfrcIt7IE4PZYm/go6Nx9edllOnhixG0xVV+AcePIJqmYDi2Nl0fhYuQqffC?=
 =?us-ascii?Q?c0V2fKOFrM+R2oiHAiNDzIdcy7OkNBeMMVGnY/NAXgXgq7crS9hikgD2/Skm?=
 =?us-ascii?Q?aObrcJlyVwHvnEJvIXhqE0YgvYljyWEyJGL4UMZuXDh8pgoyuCgs0HLK1LtU?=
 =?us-ascii?Q?A/2jBtG5UzGt456LuRqzJmG/eUBqm6xjpTFjTVCk4g7qMIg4unzkEfpvMKEk?=
 =?us-ascii?Q?uLEMPQJSFVt077euZZq/ahH3aUj+t3ZIXQKsvz6G2nGSwBp6q1moBVni1ynH?=
 =?us-ascii?Q?2BMoMKe0ojmUPlYnZtEEVwUQh2yq2ACDsQcX4Yil+YJKD+34Rk3r7GUW3xow?=
 =?us-ascii?Q?55/QpsjLHFTZFrYAROKoA/Q8oTJvgRDIjpLmbedlqqQ6e5jlIJVQR8BtMJGK?=
 =?us-ascii?Q?Il5DaivxxhVDRHjjFlqRftg9Tlz4fRpwyg/Kp5QFMTghZ2OMlBbnlzhJe4F/?=
 =?us-ascii?Q?sFlxjTxv5rgwJFvdwF44rjI560ulZTEX2rGuDlOinWuLlg2P5MmcPcnehec7?=
 =?us-ascii?Q?7C1vVVpRl0kxcAO27A23RJy3V5NLobseHe5BlImttFBbxCynKT6Y9Lwzs8c2?=
 =?us-ascii?Q?Io8uEP04Cz2OqjpRpLoEiL3FC6y8j7zLu7CSh4FFeKWq7i//VFEcJ2XIcWdP?=
 =?us-ascii?Q?ncpu3G5HCQQf+EiTH+MeO3smxJtX2a9OY89VJA6UoJRfuElMNWvBkEUAtjeN?=
 =?us-ascii?Q?6SC83QBfGUNqqlIQg79vCtOZ/Ru6R0ZAPB4OjoZQiJ55JhJSx3+wLizgw50K?=
 =?us-ascii?Q?mmyqKiBCi3z/7tWWPTIyez1urJocoqZfput+hHQfMUimS98mBNGORhKp5wD0?=
 =?us-ascii?Q?S+E9lJR1SlXoRFZcX6Qf4Mm92VTlwLzG9NDdP/3m8oN/hVCvmCWp+K2M/gb/?=
 =?us-ascii?Q?y5KqyXLoCGVFzHqIwD1NOVdnr7R2QehMjHAw7EdsCm1GLYTtRaEjAVcEfiP4?=
 =?us-ascii?Q?AIfeBc9dn+PoEx2xgYPHkQjWdBoFFZp3XUeHCjcwRtVuYOcRxhV1Fyx678P8?=
 =?us-ascii?Q?8cJFKQz8AddhCQDr9yfwKaq6DiiG+haRWiBiwGaxrrEt4YfhTmIn3QmQD5IW?=
 =?us-ascii?Q?FthWtIXrDV/vdZ9ERBDwbQwwRPo9/rEVblCF547XOVQO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aFY6Hgl5TWT+VgxfbN/n+8kf9dHh+vv/vBITXSF2MUeyKy3PBGaWRnKsOnvvcpxbIPMeZhZLwwhzJMXCJ0+5RDdurkSrpMtubGTWMKHiRag6k9g0RbaGBENMiM3X7C/5yLdZ5WLWVYe/TZWgVoQvQao97coqQXo4Tm2MPn8qIQyyyuzEJLeQGnA7hTAX1ycEAhziJ1MVsCo93/4/yj9UdIo9jTZ3VaM8U6yU/PYakGeH0tHOgJ4fl4nxHi+dredacYvfg+NDopSTDAZ5pi4XYm6kVmt/ZYVeZf6U4yQ/GabmhKDq0FnUhvUBlYKQicZbNYsMTb1IERXvGsMAZBEVUydRTD8WHHZwOVckhulmErU4mqRptk991V0N3Sb0mzEdnnovDFQWtDv5p3vornXoZLs7smfP3zC/htbBOXhNgftqtxARaOQRP/xp2ojhHWNsCb5/d8JTe3e+OwVw2M79+1fEbwQlq/d8M/1WbByz6JFRkpkSIocFd+s4oY7w28CQFxCASSFVTm2ziLBu0WDLNovO4OnUyEJ2205o8CzhIb9Mk6oyTN8K5C4Tmxt94gERphG82O0XnmfJGUpUwDkjAuxRlEJXYLUrxItOrkQkCQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963f0f67-da2d-4254-998d-08dc4824d6bc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:57:04.1686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7B1+0cp7bYN3Fpy/y6kGGsVKBTNZK6RB+HMP+/kbKBC+0N8UWc4f0CU5LYTdIp2qaCdhcT5LddlULfU295C9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190113
X-Proofpoint-ORIG-GUID: gU5Dp_ZQQ2HxQtq7Xfrs8-usDzke1A71
X-Proofpoint-GUID: gU5Dp_ZQQ2HxQtq7Xfrs8-usDzke1A71

Simple renaming of the local variable err to ret.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/ioctl.c | 66 ++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 38459a89b27c..692f6ca9f897 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2367,7 +2367,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	char *subvol_name, *subvol_name_ptr = NULL;
 	int subvol_namelen;
-	int err = 0;
+	int ret = 0;
 	bool destroy_parent = false;
 
 	/* We don't support snapshots with extent tree v2 yet. */
@@ -2383,7 +2383,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 			return PTR_ERR(vol_args2);
 
 		if (vol_args2->flags & ~BTRFS_SUBVOL_DELETE_ARGS_MASK) {
-			err = -EOPNOTSUPP;
+			ret = -EOPNOTSUPP;
 			goto out;
 		}
 
@@ -2392,31 +2392,31 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		 * name, same as v1 currently does.
 		 */
 		if (!(vol_args2->flags & BTRFS_SUBVOL_SPEC_BY_ID)) {
-			err = btrfs_check_ioctl_vol_args2_subvol_name(vol_args2);
-			if (err < 0)
+			ret = btrfs_check_ioctl_vol_args2_subvol_name(vol_args2);
+			if (ret < 0)
 				goto out;
 			subvol_name = vol_args2->name;
 
-			err = mnt_want_write_file(file);
-			if (err)
+			ret = mnt_want_write_file(file);
+			if (ret)
 				goto out;
 		} else {
 			struct inode *old_dir;
 
 			if (vol_args2->subvolid < BTRFS_FIRST_FREE_OBJECTID) {
-				err = -EINVAL;
+				ret = -EINVAL;
 				goto out;
 			}
 
-			err = mnt_want_write_file(file);
-			if (err)
+			ret = mnt_want_write_file(file);
+			if (ret)
 				goto out;
 
 			dentry = btrfs_get_dentry(fs_info->sb,
 					BTRFS_FIRST_FREE_OBJECTID,
 					vol_args2->subvolid, 0);
 			if (IS_ERR(dentry)) {
-				err = PTR_ERR(dentry);
+				ret = PTR_ERR(dentry);
 				goto out_drop_write;
 			}
 
@@ -2436,7 +2436,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 			 */
 			dput(dentry);
 			if (IS_ERR(parent)) {
-				err = PTR_ERR(parent);
+				ret = PTR_ERR(parent);
 				goto out_drop_write;
 			}
 			old_dir = dir;
@@ -2460,14 +2460,14 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 			 * to delete without an idmapped mount.
 			 */
 			if (old_dir != dir && idmap != &nop_mnt_idmap) {
-				err = -EOPNOTSUPP;
+				ret = -EOPNOTSUPP;
 				goto free_parent;
 			}
 
 			subvol_name_ptr = btrfs_get_subvol_name_from_objectid(
 						fs_info, vol_args2->subvolid);
 			if (IS_ERR(subvol_name_ptr)) {
-				err = PTR_ERR(subvol_name_ptr);
+				ret = PTR_ERR(subvol_name_ptr);
 				goto free_parent;
 			}
 			/* subvol_name_ptr is already nul terminated */
@@ -2478,14 +2478,14 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		if (IS_ERR(vol_args))
 			return PTR_ERR(vol_args);
 
-		err = btrfs_check_ioctl_vol_args_path(vol_args);
-		if (err < 0)
+		ret = btrfs_check_ioctl_vol_args_path(vol_args);
+		if (ret < 0)
 			goto out;
 
 		subvol_name = vol_args->name;
 
-		err = mnt_want_write_file(file);
-		if (err)
+		ret = mnt_want_write_file(file);
+		if (ret)
 			goto out;
 	}
 
@@ -2493,26 +2493,26 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 
 	if (strchr(subvol_name, '/') ||
 	    strncmp(subvol_name, "..", subvol_namelen) == 0) {
-		err = -EINVAL;
+		ret = -EINVAL;
 		goto free_subvol_name;
 	}
 
 	if (!S_ISDIR(dir->i_mode)) {
-		err = -ENOTDIR;
+		ret = -ENOTDIR;
 		goto free_subvol_name;
 	}
 
-	err = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
-	if (err == -EINTR)
+	ret = down_write_killable_nested(&dir->i_rwsem, I_MUTEX_PARENT);
+	if (ret == -EINTR)
 		goto free_subvol_name;
 	dentry = lookup_one(idmap, subvol_name, parent, subvol_namelen);
 	if (IS_ERR(dentry)) {
-		err = PTR_ERR(dentry);
+		ret = PTR_ERR(dentry);
 		goto out_unlock_dir;
 	}
 
 	if (d_really_is_negative(dentry)) {
-		err = -ENOENT;
+		ret = -ENOENT;
 		goto out_dput;
 	}
 
@@ -2532,7 +2532,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		 * Users who want to delete empty subvols should try
 		 * rmdir(2).
 		 */
-		err = -EPERM;
+		ret = -EPERM;
 		if (!btrfs_test_opt(fs_info, USER_SUBVOL_RM_ALLOWED))
 			goto out_dput;
 
@@ -2543,29 +2543,29 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 		 * of the subvol, not a random directory contained
 		 * within it.
 		 */
-		err = -EINVAL;
+		ret = -EINVAL;
 		if (root == dest)
 			goto out_dput;
 
-		err = inode_permission(idmap, inode, MAY_WRITE | MAY_EXEC);
-		if (err)
+		ret = inode_permission(idmap, inode, MAY_WRITE | MAY_EXEC);
+		if (ret)
 			goto out_dput;
 	}
 
 	/* check if subvolume may be deleted by a user */
-	err = btrfs_may_delete(idmap, dir, dentry, 1);
-	if (err)
+	ret = btrfs_may_delete(idmap, dir, dentry, 1);
+	if (ret)
 		goto out_dput;
 
 	if (btrfs_ino(BTRFS_I(inode)) != BTRFS_FIRST_FREE_OBJECTID) {
-		err = -EINVAL;
+		ret = -EINVAL;
 		goto out_dput;
 	}
 
 	btrfs_inode_lock(BTRFS_I(inode), 0);
-	err = btrfs_delete_subvolume(BTRFS_I(dir), dentry);
+	ret = btrfs_delete_subvolume(BTRFS_I(dir), dentry);
 	btrfs_inode_unlock(BTRFS_I(inode), 0);
-	if (!err)
+	if (!ret)
 		d_delete_notify(dir, dentry);
 
 out_dput:
@@ -2582,7 +2582,7 @@ static noinline int btrfs_ioctl_snap_destroy(struct file *file,
 out:
 	kfree(vol_args2);
 	kfree(vol_args);
-	return err;
+	return ret;
 }
 
 static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
-- 
2.38.1



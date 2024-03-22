Return-Path: <linux-btrfs+bounces-3510-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1211886B29
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 12:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE9D1F23B4F
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Mar 2024 11:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD6B3F8F0;
	Fri, 22 Mar 2024 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FR6DF3OS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aUL9CCCZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D103EA91;
	Fri, 22 Mar 2024 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711106247; cv=fail; b=n3IX3a/aKtna8Ju/DUJ1aDZQgkEI0gKkUMF2EIgL3qW0svVRABPXkvHb9XQ2usz7qJtCFtzUUeMEwikOZ44OVi6nvepgw3VoqfpXR4PTwcfj1NPxPsRlWqBM3ACnS5LhJmoipIXIF0qCqrMMP0Cu1NW2746fKZqpOjYcNrquuJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711106247; c=relaxed/simple;
	bh=NUrICeyLo575w71WZ84DhRB3YXOuBnsvyjjCtIpvj5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XxT6J2cGGCQEpZ9RiSav0GhO2cHc7xJN+05JTKcrwsRE4rHuLtQgyCk2XqmM1m5++/sVXsW/AIiwdVFv6SP0RF0oai/L7c1BkNJyVlniKvUIMoSOzR8nOemzkhM/1I6EeT1cIML9e5htuQQjOQND0Db6V6+oMTxsym3/zsvAuEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FR6DF3OS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aUL9CCCZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M7YfiW000995;
	Fri, 22 Mar 2024 11:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=SaCOMV0gK0DND1tUXoSdIfuYS6xjGWyQKObFXXZD11M=;
 b=FR6DF3OS55Wg9FmlzQNTJM4AlKPVFh1W5LCJRlxFFX+iBYAMJD0QDSpEdM81DSsovPcQ
 Y0YS4rXPRNy6UJP6VlvCL/TAuuf4rvazv3bNiuOgL8uI0tAz+Z0eMtZR+DQPWFR0i1zR
 GAk/J5MtYPF/CrxHp+VnyqYHuOkW/9pt275OgJms4nX1juAXZlrR3JHv41tYzsr61DAa
 2txu+8aGCMjPDcRkQShpTjNXd7LspgF+7yUnPtNjkFAdcFe+KJS5V4m+xJFDdQSpnjlh
 7bE2X5dS0M9HVnmgHm8gLX16yBKpFhdmc2FCmAdMR5STqltsNO34GSvD3tf1IyjalkKC 3A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x0wvpgukw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 11:17:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42MBDZlV014972;
	Fri, 22 Mar 2024 11:17:17 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x0wvk42uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 11:17:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hxn7ALGnhC447Y/QN8Bwmute3ftZTdCJLc3xWXYP5kke8i+ihwr1CloDmlZoZF6eMgA99ahVWByhAoHXFee/pBovrTsfCUa7VzOzpGKb3htaQaeSaIUC8jIavtDsyTEix3JSYLuvzw8HCWNIIH79KDnsVKjecvGvcI42Q478gtRAh1tGs5n2iG28JjBD5OHtgDhjs5YI/NXJE+WdhJ1hvs6wISoWXyS0VrhBxkiiTmusvOSl6zmggcE1wMe1IbDSrn/Z2VHi6wM9M7f95OVvMbYhpa+mHK9kQ+4AIDRPsthrjT+tVODp4mMr7CmI3dseuyeQ/jmWnkUGxQtlUHEY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaCOMV0gK0DND1tUXoSdIfuYS6xjGWyQKObFXXZD11M=;
 b=edUbe5QYDtMHxT08UATvMVjzkEd/BhL1NDZtSO4PY6pSxmXPwnRbaytOuNDVmCT14jc0vO8bfxDlSamA27ZQ1NRbm+Fbb5JhKZmViZ6uyOoL1bGv/7EVIGWOHqGr2yeZkS1mi4I82fIlUXibzoMaMrSaBpzEwr5K+YID5MrcnlJptoFZa/r7lstuO4Sr+MaAV/Js/Vi7dvubUQWx4rtjn+/TV9CXk9YirKHruBlWQW4tqeq++mA9chVcRepio9EwFgwDKzEGKNKaux7rKKnELxxAlDYpAG/kFgMcjBKkAJil4o7Agu0vkjlahv0VvVEqUUU1Vg0pUMI1buXCPQIi3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaCOMV0gK0DND1tUXoSdIfuYS6xjGWyQKObFXXZD11M=;
 b=aUL9CCCZbGEigE0sODQYLenDhQDV/dD5IhAl4R3Q52lhzWYxYtOBa5Sdfnf8K6JCw6O7/AAkl1wBlWuqBUPTVqZvUeIpF4U9+5SwxDzn4boYUMAJVemAWRL9RKaxiBes5n68mbXOzc3EXHUIGqAgMWfUiX8gB+WRHsP2ikZJ5K0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB6424.namprd10.prod.outlook.com (2603:10b6:a03:44e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Fri, 22 Mar
 2024 11:17:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 11:17:15 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v2 1/3] common/btrfs: refactor _require_btrfs_corrupt_block to check option
Date: Fri, 22 Mar 2024 16:46:39 +0530
Message-ID: <206f5635cffc0c923afd1a297058fa406bd8e43a.1711097698.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1711097698.git.anand.jain@oracle.com>
References: <cover.1711097698.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: a30a5378-0454-407b-b570-08dc4a61a0fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tvd9UXoWvM7MOM2JwKdhqrS48XLNK4wz2BkOtf247hUqYtQ0fg7XwSR3epR6micooE813uvkg4x+Mez8ChueR4m/msthOkbKIYUMFKzvvchL6O4NFlRmaIIN8kJIGtnEFeTLr7Z6ejRt7A/2my/QevmDKriFVaquuNdH0BfyU2B1S2aUHpE7Qmc5WvWHGPIVxZfQVVHl3Mh4QK2tPQZpPMT8L215Iv/KgZQlAgDC6JdCGwXLBKpGQ84vc4IfobiGo01jajQrKUTdC8uIZeDxQ5Qe3clKbDllLpYKzRQPfdN1fG87s/okwY3TiJRMiwW2n3KghEk2TzhayWUiLVY9StfzugDOt4M4AXfNXiEhxYfQpy1lKgWCFUoBnoDr1LxPjUCOsVFdTrg5bNTqPDrKbISizVN++ow4Unu4R7GckGuDDRBHbozLIUC37rbHhesiD6nIP7qmiCs032ITnQkANx9TgmZF7H/kE9OhM/vpygVwtxPugLYG3Ixj/a/tGYNjfbr4LYM59y0PwbK7wkPltLK344UgW6J89KYGmDvOPI7hYDMfP1lUqj3S1t8i9RHY6NKJ3mmWd/54EzgfjMMGCO2gc70CsliHu5BPgPyIv5ssKbJEygdTuVsiu25ApV+S2Y4gvlXCoZyJlD03XM0iHw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Z/EUxTr+UyFyMPSoLn4+95nF1lE/0fFdRtedZz2GboGR9s3eCtgxknKdZG6H?=
 =?us-ascii?Q?eLM5SRXH0mR8gnaPEe2DYfnT8S1IYtZRF3w3tmHZtQBXCqUXwDn71Ds2AhHa?=
 =?us-ascii?Q?0qDsOZ1vrq5jOOA7a7WG7UtMO9smdfTGdd1hpM9u2RK9c3+TApdjxi6SeKOW?=
 =?us-ascii?Q?rw8DVn8w2Z7H3aZGl71x0Y5mKmRUv4cRwgGGcw9IcZIRRkQ/N1pKPj8ekX9+?=
 =?us-ascii?Q?RL6kBup+HudglCtf1+akfz01qMXjGFznltW3jBDcqvRWY0HhczGheHbgNPIy?=
 =?us-ascii?Q?LtMXro9Q/9z7EB5JOlVKlZvpqFZDcZ2RhXIHMD4vnUHrXut9B5d1NFlIoMR8?=
 =?us-ascii?Q?rh+uECRruWNTNftbr6fzJw0urSZctrt35NQIZ9CIk5fvy1Eoo/TJ6ojPm/zK?=
 =?us-ascii?Q?4DKnDphAYS5EOprg8vqrL/sbAA5isLUNK0ICEgfsiJe9xWP2zoUi2dnAQ4ej?=
 =?us-ascii?Q?ajSkfM6xxy8r+mq7yotsPSXhRP1OzKoKEB0DLqSMjCnAdStViCdQTCSNHIRU?=
 =?us-ascii?Q?jFl1OtkI7eXntbFJO1t+IWm351wj0G0x4t1iUMtAw6glf847I1sx+3PxX5Od?=
 =?us-ascii?Q?wrgwj2BnoV7U6kKnJ+aLoz/1u+h84q2+ssNVq8wbgMyqVxGujzJv6taFqmGb?=
 =?us-ascii?Q?HQfXxMP77G4jGkMFmhO8CJgdPtdmUwyx60W+w42E7BeJbSwNNrRGeZAs/HJi?=
 =?us-ascii?Q?10RVTNYKa2W1LA+STvsXPFYqUiSOeknADBlb9pN1lJI5aGqRhleGwBYpw/hQ?=
 =?us-ascii?Q?8d2L56YsJ+au0nxmyNQxYeij7rWd0CFy7m58zFCfh3zWi3RuwPxIyY8AZ7/g?=
 =?us-ascii?Q?aZd5tIS55V8Pqo5xA3b2PLF1ZYOoInXeRT3bsHsFizUZUkr1BwV7bd/JgXfv?=
 =?us-ascii?Q?TzHIhHyuRz7mLlSEumK1D7fNxSaH6M6aciAv7Twc6gIDpGyeXDl4LTv0GNas?=
 =?us-ascii?Q?bmU+X/BAc72+PXiVo2OVFX/eii4kU89m0dp4VC66+7cIlj8riKFertFzfyup?=
 =?us-ascii?Q?2p+4mJP2xZo4NZ4+LbPlOkIB+Bv24XyFtNitc9t7fxYs52yCnkRgN3O4TxAh?=
 =?us-ascii?Q?luAkyj6p6fn/hAvEqQWWXGt7Q/VCOHYT2qJAT+gmz89n7GKVAfnk12gsv02u?=
 =?us-ascii?Q?oj+QMh48JQT8cZwrlUiOE3V1QtcmUy3BG3cHWsVuujA2r5y0sFf9Ji6K1xyZ?=
 =?us-ascii?Q?+uLP7DrOyNIlg1OI2FiHKu/8v01m1VPE+PmLka9v4K6VTYrHTUWcqyrzOvfC?=
 =?us-ascii?Q?z4MXKpXNI/6JFFMOqZemW3BZQACHF8liZGFoISB/dS++mXXhfUPXbkhI4D0T?=
 =?us-ascii?Q?AS0fwweTxNsY+jt5yPELf2t65d8qqf8/zoY//nK3h4JYyL6Zbe0o1eULWn22?=
 =?us-ascii?Q?BQeGl3SLr16rJ2Eu61nEMxTR6BZAxkhNPfDTs54TIFkX8S5IekeolIrV38Qx?=
 =?us-ascii?Q?iHHo0jHdbekzn2dQ0GQgIWxUtRac95TMD06invH3KnpK8IKDV8PefT1R/NKt?=
 =?us-ascii?Q?qLI90DaUi/mwfupPzTtX7sCq1dUZqwdAAHgw+MjNvV958+fh1BQ/2S4ul4OY?=
 =?us-ascii?Q?MFvta9g0TpY2ed7mv9C+vQnhWxJuMbwGBWp4aN/0cBAriNReZrauBXii3jfW?=
 =?us-ascii?Q?h/u2YAnU2jOi944l2z8z7qTAf5Ct5woYBN+dd/WV/Trn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+/4NVDU3x++xFH8ovKDjoT/1WVgQgPbfCUpZd5TV84rKFDgfQKiQtBShhIvqEogvBZO1Fb4TdRClM4VEpq8GDATscP+aDZ9CHuU+4/V8oj+aLmtKEDydc7qXYMybMiQpYZmvn2mrXegERI8tT2CHehD2Pc4ccMJTiTRnyrHTRcodTulU6c3wOe1D9y/LrnoEw7ZmUYqFQFvdW3Tv1V2zlta3F12SBsSQURVjk0ueaQE1rTsWRwJpGGqCTGmnPWtOqbMdJubjdKWjfFrp6Y/o7LtI6wsvJILpo/N4cEa8jPhmXmg8GMEz3/v5mOQ4O2+AQeOuCNwD+ts8B7fi+Xp3cKK/kIVgthSdyXVzTwipn+xzWDfecyYKGyCSILUlnbj0MeCOu/HqnY/w7q7aMe2kFqUuos2SCXFNQ58atSMHV7EZAainLnwZUiZBlr6M2FWguXQesxz7ucf0m1YE3kCnws5sGNvnmGFxOTdHMbbw+aEbV85Y9apyNlTbl9xHEfhaUPdDzQgS2FFUFKN4LC8HksEj/lkl1fjpfqImvlVJEbAUL9MA46bCarqjRjFs4FUlGIrLpJXnEJfz94lkbeJm95shHHQXB6FriP2+xX2f7eA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a30a5378-0454-407b-b570-08dc4a61a0fa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 11:17:15.5393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uz7TJwLgkEX8WlGDy1Vk+AMYxax5nuk5GUnWM374H3JVfqxxh/S9AyEGspj9YtjvYBfApLQe8XcOz7wYlmD4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6424
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_07,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403220080
X-Proofpoint-GUID: l3JBFGPPAKgNXOJTemgQMOS-HZ-JcuL_
X-Proofpoint-ORIG-GUID: l3JBFGPPAKgNXOJTemgQMOS-HZ-JcuL_

The -v and -o short options in btrfs-corrupt-block were introduced and
replaced with the long options --value and --offset in the same
btrfs-progs release 5.19 by the following commits:

  b2ada0594116 ("btrfs-progs: corrupt-block: corrupt generic item data")
  22ffee3c6cf2 ("btrfs-progs: corrupt-block: use only long options for value and offset")

We hope that if these commits are backported, they are both backported at
the same time.

Use only the long options of btrfs-corrupt-block in the test cases. Also,
check if btrfs-corrupt-block has the options --value and --offset.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index ae13fb55cbc6..a8340fdd4748 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -659,7 +659,22 @@ _btrfs_buffered_read_on_mirror()
 
 _require_btrfs_corrupt_block()
 {
+	# An optional arg1 argument to also check the option.
+	local opt=$1
+	local ret
+
 	_require_command "$BTRFS_CORRUPT_BLOCK_PROG" btrfs-corrupt-block
+
+	if [ -z "$opt" ]; then
+		return
+	fi
+
+	$BTRFS_CORRUPT_BLOCK_PROG -h 2>&1 | grep -q -- " --$opt "
+	ret=$?
+
+	if [ $ret != 0 ]; then
+		_notrun "Require $BTRFS_CORRUPT_BLOCK_PROG option --$opt"
+	fi
 }
 
 _require_btrfs_send_version()
-- 
2.39.3



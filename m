Return-Path: <linux-btrfs+bounces-3417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2921588001B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 15:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D4C1C21FFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 14:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C55657C5;
	Tue, 19 Mar 2024 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nbG34u87";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iEwD/rMW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904CD651B7
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710860314; cv=fail; b=KYcrSR3GUklhis7ctBqhNBFG0J1mz9cKgsscOLdIS5LsFoeQDux2wBrKftYzcjKCxDiOQmsKm/+UYnJe5hb3HnUiPrxgjPYHDTc1iT3ylZRgSFSrwM6Vub8vMoKm5miP/QxjPD1fKu0TsnrweCeGaxGSj5o459/Bbl0scu4LVAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710860314; c=relaxed/simple;
	bh=nA+3hVpi+JyW4IjuzuQXFPE71Hz0n7Dd3JUf4ucMY+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sY2b2or01m2GMZr1Pl5s2CN/YE4yzg1DZG1/lL+Yz3Q7bIRkOXu8iehacjZEQQfOiz4NiB78La0qkKHpzqig1CNq42MFDSkVPwqA3yZsnDRpxmrmvPvvdyaDfXxM1tC7Eb/W8vUjMAwZsAMNhaI34UePPiJAebx0bdCsOObrmqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nbG34u87; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iEwD/rMW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42JAHt64005358
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=1l4QVfni4oBgKNXlrusgxNBJMcmFaOodirHV3m3jzfw=;
 b=nbG34u87psJCgSNhXeYEQ6QBQVt0k7lXRv12gZbsA/E5JDskIIN4g3ruFxVBvZOKbXA4
 cCoHQV3DI20zQz/gSguRRcgbpM+9FYNGcLC0Q1jDhGfa+jnGA7yqmWik6j8UkQ3yHCuA
 1iUsBspl2rlQpI9XzsQj2D0kLwsTfQQTAywKLPNJ2b9Qn/szoN5HLpghDJrhwyaD25NQ
 zIhjfmIniTB+4e9KNvLIsttD3kjIR15978M1eaai0WRgM1XOzXgpSxCt11D62sKmuj2s
 fPL9D9/nAYvy9nzQG6dRJcubhXKbe9kvlm1yqb1O9EDS4n0Ki52EMFliaRRKh6IwAQ73 ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ww31tnskw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42JEKS6H028734
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ww1v6c2nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 14:58:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjJvz+o3LEGVDeKaqycMnhBwA2qYV17pRTVFAw7x/vhxDri/S0fDU5tEmuZ5wQsKgbGfHxhofNiCDksDU8d/ueXZOX+jdbAtIRrYVTo8ptmsciqCmaUi+5wv85go1vY61fGfgANkLQKRVIaUn8KcStys0TgEugvY7M3UcVwWVjThN/WejPsBHLjXFs/tHL03fwATAYqOGO8oWUsLArZuw9pU41oVHmXEPd1+w5P6wy3poEiuodgELZN+DqVZZ2YP6j934iQZchdx6D6P04g+nzOktS7QSn/0IytbrjYwuE+m1pQOECKNdv5n802YkE+Iv/e/srGWBuQEL0H/suunjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1l4QVfni4oBgKNXlrusgxNBJMcmFaOodirHV3m3jzfw=;
 b=cTEiaazscZ0p5Y5VzwSFy4OvTGWt1bqh0VVE8zpfxMBSfaie7eREB0W1dhJJoafUNor6AJzl9Zmq3SstOzOmsSJN5DMDuvhbuM54kUd4Ay7OxfFKiNxPRggvLZ8+gsycK8MD6EhtbNMeBVSzLI93MBER+g0J1qbQqEzEVAbj06zQhasOCjJEy6K4T76xCsusZKtQBUDivPL17Ql+/yS8wiFtBv8hrMPiMaffIMdo0thEm9uu4HbHw2Xd3oyovxbv1ep2kRrI0MeIzjJWIwkK/8JmXvdLx5cqMXLn/E81wZlHxaVaFHOTZ+otTLSwSoErRgs5jPj3uGIeVp/WGw4tVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1l4QVfni4oBgKNXlrusgxNBJMcmFaOodirHV3m3jzfw=;
 b=iEwD/rMW32bemdX/8TNoMe1FzRoS4R2nSqFf1clC2VsLlEtj/x+CXFVoLHHvNTcYejWcuecEn7dC4nvZHChgITKIAelPE/6C5KZu5umqzpsX+84uKZxrl3lZiItezm8r8bwDfZpJLKgWULT7ifFBMNY0k6JCxu8gUHNAgZVvETE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6479.namprd10.prod.outlook.com (2603:10b6:510:22d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Tue, 19 Mar
 2024 14:58:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 14:58:28 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH 22/29] btrfs: btrfs_qgroup_rescan_worker rename ret to ret2 and err to ret
Date: Tue, 19 Mar 2024 20:25:30 +0530
Message-ID: <c01a4746a01930d5a17bbade7074491b66c456b4.1710857863.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1710857863.git.anand.jain@oracle.com>
References: <cover.1710857863.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::19) To PH0PR10MB5706.namprd10.prod.outlook.com
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
	rOOLC1yQ6gpnKC6SLElwyGK6miAypvi2to+PryFB0QJZOYXi2wp7Xitm6rcGufhXOkfIy82VvT/9ReSAji+laKIOevx2eXOquHrSWVbgFA1znzSdLIX6g6SPZD9RKVHOD423Y7fDeZyiPzaZN3ZtRzs0Lcfwkzs8bcRXT2MUqvEeUPMbrg2165nByTJAcmjceJjAsMjF69iGmQrjayPlMr8GLm3eq5uqU50hq6WjU91f/XimX432LQroWTIkSC+kjR5g7S9iagUTXKlzVgDvnUtup+EkV1Ye99oFo1dCpggUfDObaKBg2DfioSFVvMDRaOtfVwF1J99sZDx9ceUwaz+DRxfbsr91Sn2fsMXq3wI19U2FfdoX8N6AFBJTBwYTGBj1AHH2kIL9r+11KF7x1K5DnTpTdF2Phyh0C8QDelWQSpzLZjbl5Fg3vJqx4e9/pLHrik/pUZsJtiBRAOCZXvJQ5JpAP46leZhKRjD27KEy4udROsEEesZzLtxNGk9Y3VHMIx494nud1EKT4+utjkYoCYW8aw1JISV9A0BQfnk52ht+wymrxYZg/w3RwIjYLeGDf78BeK88ax3BX/OjTXgPEAdHvGWKyEW99c9YlXzKEArsd5EtdAlOOqL7T6IapwE0RjBqEr+k08OEeln8AUIAfRJsnTDTx1zQfyczjrQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?V7cCrDb6m1HVGvxJPtKHzRSmF70y7DBuKPI7NGAjQC5ABA0c8gL8BL8yddw8?=
 =?us-ascii?Q?7UzwQXD2U1Dn9UbxvfHAC5zVKyn2uwtGfBD+PtPuCUS9plEidm/9tklN5yxk?=
 =?us-ascii?Q?EQ+OtjCSuuuCMY/jp4g7p+ic+EM4uadc8arh8yhYSMgEhT2WgC40zOWK2+54?=
 =?us-ascii?Q?l6+08DAi5RYib6/koU5qleO4haLj/yaamAuHsEqxZNlYso1XmBPm4Bb56cra?=
 =?us-ascii?Q?yB4aF5dCKaviejdBbBD01vNfXpLdf9qoa8U7NZzfi84yaQ6GZjaHVvQVba0k?=
 =?us-ascii?Q?W8VPv31ATyFr2OuQ81uYIkgqO6e10GH8m30maYdaeXMczcxV1NwUULDuW8lL?=
 =?us-ascii?Q?8wEmWvEXpg0ryOa0atDtHemfuHwxhpNStyeI1eBH42EjFJReLJOSy64EdgtW?=
 =?us-ascii?Q?5F97jRSyxd2KZRYdqTNKSkwvvvYgiiK5Upwn/u5e/08rKm/lzkeiHtNRPMBI?=
 =?us-ascii?Q?rG7ZSASigR0i5AyNuiV/gieJhRRhLSz1TxJiKkZ6+kjsEOWWUNlumMZkd3lw?=
 =?us-ascii?Q?66m4TIdXsyRnB0OfBEBGRYQX96fMU5Y0Dtjf9wC0fqW1vUHjeWhJME0pjxU6?=
 =?us-ascii?Q?vJYoItDy4tvTU93p/IXE94zK8moJmJ0Ofy/1u+mwJLxOgOM6ysoDj71OfWo4?=
 =?us-ascii?Q?tuBFXCJok1Vf/CMcA1mY1FnButnDx7PNT1hAWwmQ/ne4Z/PnrRFADiFG+YxX?=
 =?us-ascii?Q?HJMKlniq3hJY673Znd3FZ5Lp8jtfHf1gmexVVlKMogJDxart190rgu+qZR2g?=
 =?us-ascii?Q?STOWB1PFF/ecC0zYUP4/w0siOM8bIYVj09n4ef1v4buJ2FHEaezuVobYOBS+?=
 =?us-ascii?Q?Fxeq1mJh0DB26KAfHj3pLpiM1K84qv29BQt+1YliQ3+bwF0j6FHHYXlwuVkk?=
 =?us-ascii?Q?R6xbKHAPCle5jbX/IeMznX3LzZEpwzvjS3zlQyfYlTzXtpbZda1cXaDegYN3?=
 =?us-ascii?Q?P2RY1aCUSXeqLUIk1mFtNCEMcjxDSsUjs2Mg7/B1b2P/g3fxQ4gS8P1cZH0N?=
 =?us-ascii?Q?gVShRdL2w3kvfKrX9nN0ow/fJUxkGQKOQXElkjJ08p9JmQS4brrK0Al8173h?=
 =?us-ascii?Q?oyhQZuzw6QS2gnp+rlBMdSLQKWsDraG2SUukAskZXZKF5aFCsk1jOq9cHLyU?=
 =?us-ascii?Q?SxTtC3LZk4gRb3mADfm5PEd23/CBOfjzUb+awyUhUvqJknOUAfH5WMVepr8I?=
 =?us-ascii?Q?275O/ZlcrcIdEWJaq2mzqLtxvK43LJ7n+dYoi18YRKgFWY0PXKvFzNghSk47?=
 =?us-ascii?Q?J91QuyYYBTvFiAECp5xycGkXZjO2bD64ytoMfYl6bUL65r7ru9k5f/ggpVLC?=
 =?us-ascii?Q?IF7/4vE0WEpWwC3GoBmXejOc6Qkr7EjXQco3PlIXoq0YsIIanVwazsYMS0sk?=
 =?us-ascii?Q?RhAdGcWmyJDWsPjAQ3lROICnt//Ph3rWMQpxoZI1EAqsBn/gkmYKk6XMIyKk?=
 =?us-ascii?Q?4YT6UtmdI+JLMHfcsla2Mn/eHGQ0l8mspJalCuhFe2TnSaXb+GUvgbNawWBK?=
 =?us-ascii?Q?Nvy5+jOnJ501vqxakvVloA/HDE+ETrAitdDTXu4ZXPVlDhB30/fS3gCl62XI?=
 =?us-ascii?Q?LsWm/I0Z6hO1Wv/a1ESZbKgKO3ww2IW2ejbAU2MrbaMOBuGSUv5rTPaISkdp?=
 =?us-ascii?Q?bCgAFouU7G8wfC0kQ7FR4Ab7BjIfu8fHAft317scsRs5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cBxDzOj9Un7EmC59bEJADXzSmW/AtrC+7DjSdN21Z6OjITK0GiBZYIT0ahfToYtKLS1GQ16iN23aNGyrAFA5J26fpwTW8NQDQHA5g6bd5Glt9fM5xSbOv1qGiXfkCea50sHE3+A9K/YHr9eddbbF7h6HBDkqDJsOnN9z1z18SL0+ERZrJkn4nRqq1v34HULaRpwXfupuoYd4gx4QrDWVqHVOTbl8Bvr7pdB9vcyTjyiEMgNtIVppOFzGrmw28QYxDKpiweopdo8zacXWWAWFhKoELmSAjqS6/Ox3FgFDIZ35SmsFcNMc0xMxBVxqPPQdEkmDOvJ16enp/k8ccVCM2EvbX8sCtKJSIQC39y7VkYnYBFL/yrV0z6UMNkIFFUqf0OyLidkT9lACEDf8WfjPeETqJRdxbVRiXQFoUpgOxu/NSWjX1OXVbXAZle35htUuFYGH97E4gg82bq1gizbWvPQfWveCEhJ/g5rCHXwLTb93QiwLaEwRWmHI7iyRrp1MEUr/k+dsHBWMjTH1pWlfHSbDTtu+yRGrQF6Ag4xlpK1XEFwyAFGOx6BM8US2C9onBFO5+fegknZq0DB21hPdffQ70aF2vmqhQJZSJTk+NTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5990b9-3b86-4ea4-b68c-08dc482508c2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 14:58:28.0948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNDKnnwITn3Ij0EwUmVdXADVnog+RFeSMbC4DQrwt3TndG6btBz+4/kicZ1jA+5RKidRs6M8Aqqjk2gtRhLtWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403190114
X-Proofpoint-ORIG-GUID: 8Ux-54ia3RdMSz-lty4ZYxiw07qz0kpi
X-Proofpoint-GUID: 8Ux-54ia3RdMSz-lty4ZYxiw07qz0kpi

Rename ret to ret2 compile and then err to ret. Also, new ret2 is found to
be localized within the 'if (trans)' statement, so move its declaration there.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/qgroup.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 23a08910fa67..3ba4c4ddb627 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3709,8 +3709,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
 						     qgroup_rescan_work);
 	struct btrfs_path *path;
 	struct btrfs_trans_handle *trans = NULL;
-	int err = -ENOMEM;
-	int ret = 0;
+	int ret = -ENOMEM;
 	bool stopped = false;
 	bool did_leaf_rescans = false;
 
@@ -3727,18 +3726,18 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
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
@@ -3748,10 +3747,10 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
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
@@ -3766,11 +3765,11 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
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
@@ -3781,11 +3780,12 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
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
@@ -3802,11 +3802,11 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
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
2.38.1



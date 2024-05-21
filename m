Return-Path: <linux-btrfs+bounces-5172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 847518CB29D
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 19:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B71B223A9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 17:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD31147C92;
	Tue, 21 May 2024 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HE3AyEpc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sf9VLF2I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EE422F11
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311555; cv=fail; b=XWONBf0S52oATYgS3NxSV/To6CpfP26FzO3+nduOXCB6qgD4HKgtJons4WnKm6qyP2eh5BYr+lt5cnFRMwN0AC10Kq5K0J3LeaaAk+aC4oYLjTdpl86NDCExqWKGpPtMpXq3TaTNR6p4HSyRhKIjSXBDiLWsvpumY76x9Hg8PGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311555; c=relaxed/simple;
	bh=36Bj2DRqJVCJl5I/INGsMPXrqlrAryLMBY62TYJlpC4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kSfSGVcbTa66QaOyB2i5q+TcQ+J59dnM5sm6hPw9vDgWmjpnEkPRmR2OQw3z6CHoWr3gDC4yIWVh2cWAKRjapCgqMT4LDTIgzITqdYSftmvd0tliOxY99pVtT/B7v9KBYgQb8Hsrsp0WyAlXaebv/YIGtaD0h9UHSBAM4l06/yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HE3AyEpc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sf9VLF2I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LH3fbI017754
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=4n7P7p9Igp/oOSfVR3nBuIprmS8lksKKt+hQBDYQwI8=;
 b=HE3AyEpc1GO9tQW6jgvXOknnAi21T3H6aGhyP7QRk1igLtC5gRlKfZKoUx3t0kGgi1H9
 QVfuZKmf8RXtXq3+ue2vctosuggZ46M1yPQEZwZpA61EgD9sNiL5asiWJleSfI7NF5pD
 F6jzUyHPdBq/C+S8F1tK/cDVH1KRtLmKd5kkaUNo3plFXm3x7fR9bkhxVZd+E9UqGYVC
 XaWRglclUe329ApDpwaTjcR+1UZlvQrGT6F+N+YYj93W/THq/+czJbl6/vVlDXg79hi7
 O91dULBkkxWgSCwpt6Y61T+wmkus3NE+jzE6Fwb27OrgKXyryyDKvxHB49M+oeCjyVNL SQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6m7b5pwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LGDw35002774
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js811ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 17:12:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOoIoWeyF615+de8Qpmmi9mALyzsshmc/3rhIHp9Nn+QrbQaQl/O68Ml60LmHyPh8P/vI8Bwj4INcNJ0KWrThQjJ+7+Ff7Jb4uSeJ5mGC2Nv0usG0kqVigVMP4xhm6IWaGM9iOZY2bTUIBPUhk0FNAAiMCBgOEBJRQY6rNxP+bwXUApcubZ7gsFMc9r8TInbChmCwwSC0Ynl4AoaMwVEhef7DQRxXkcK0K/YOjuG+ki74n+HDJ+J8XzE3G1XRleBfZWpa9bJQhtz7f2o2Q3DccF2wXtJurzQ9mMbMvWnyQML1m8HSKSLzh1CIUYQaNka8BNCj96XzjgK7BbU4hKtbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4n7P7p9Igp/oOSfVR3nBuIprmS8lksKKt+hQBDYQwI8=;
 b=Dg13ioCSTz5gKiNSXEpRX4IK7d8bu9ZZb4QOSm9JFvGi4rHFF9wYi6a6GNzOCDl+OSbD1X2WMS2ytIFI7qc3K6HjmPaLpVwwjbmq2Lt2zjZQIQetC09EEY1K2JP1iSQ/2eosk/r5mnjkUXM3Yh9xcX9tzjdrfcRFfu87t/7h3Z0LLiQGOBmTQ+iS9illgZKPTbUF0ikrPqYKEFez5VvQWEBHcmZ1xG2TQk1L3pFp1A2TZg1e1N1Nu03Mtm16XzJN/JCOOeRp16Q3KOXG6nyvtX1qEpdE2JMnkOw3yerq8PXvYW/osvL/1P4sYT2UXMCIaUaeJfmTC6ZhnHKuxyNuug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4n7P7p9Igp/oOSfVR3nBuIprmS8lksKKt+hQBDYQwI8=;
 b=sf9VLF2IPdQAS1En6wJHgd00HLCBUFTLjKMHmRCPA2jC4riG0QypEwBT9gfVD0pARl6JXjL4YCFSqNNey9lEOoObV4JfKqzxgRyUtHdU41zC5z43ixudymgd31K/cyKhfPp5bRQob9VJSWujWp2QAnVhCByU44RERfvafl/Mvd0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MN6PR10MB7520.namprd10.prod.outlook.com (2603:10b6:208:478::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 17:12:26 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%6]) with mapi id 15.20.7587.028; Tue, 21 May 2024
 17:12:26 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v4 0/6] part3 trivial adjustments for return variable coding style
Date: Wed, 22 May 2024 01:11:06 +0800
Message-ID: <cover.1716310365.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MN6PR10MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: e05c47ba-6c80-4c1c-d1bf-08dc79b92fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?V1rf53aXvL83xFeDp+iin+rBmKi109sJJzlen1AExwJ6aOegZTLELEnY3N3N?=
 =?us-ascii?Q?5sicOr0UdKPk2a3Nst7XXz6KFZfo//veTJhOhKCkZxfJSObmMY5yrUGS7M1R?=
 =?us-ascii?Q?DQRV2qyevYAyfFzPb6odIAsHqD0Vj4cdwzU9LHrGfWb8cRXssidtkn0AZiQt?=
 =?us-ascii?Q?YVdO4guw2uzn6y1JAp5IM9D+ObqSCx9RjGkMd1UtxRqbAi/Ge+Ze/UjR8qR+?=
 =?us-ascii?Q?l4NXLORMqvWgXWkdsn7mYBKd78eb1CNdHJRFxt9+fWlsGgZ/7UVXdMevbjY3?=
 =?us-ascii?Q?NuEy0K1w//VEqj6+HbX38cbir7lseXWYsCKByHGKyeCDKaXt/9hcu/TozgQp?=
 =?us-ascii?Q?JMSFBrZt8voUFE1nxmcIuIh4GhnAZqdZwNG060kkWUqQKkqRObxE+bMDyAVP?=
 =?us-ascii?Q?SsQ5nzLInXL/njZLEEMdiSZuZ5Gk3J221aM/6OnKt1BRbJw/ZEtWgbdczXNH?=
 =?us-ascii?Q?xhalCyr9krT/3lIYCSkGD8ciFn9wtpA16ysJ2Ip2EMtdkzA2VnsWRqzJOhsF?=
 =?us-ascii?Q?VznumnBhvQtTAlZBTuSjvTi7xqQW/hgm1j7QsTx3KQgAJltUKCnKfPpofIcN?=
 =?us-ascii?Q?he34yrgmU/h00fwHUSc94UzicCB0wQ/orPUvA8vlJ9Joqkv6NtfzQCidsOR1?=
 =?us-ascii?Q?NZQRriU7knDikKmpgoaEF4iM4ItRBHMLfeqXNSTor1ZgvU6HUBiMSC74rcK3?=
 =?us-ascii?Q?U9cmqh62pPPQl95L4dK3sF5oVjYIzAYojdWM2BUPFxY+JPitsjyuOM/8YaEW?=
 =?us-ascii?Q?5/qFlKZaeP5tKGMwFe37r6uLUliU+23lsrteLVwTjNOIVZBOsU4PzxD2tA9g?=
 =?us-ascii?Q?Y2ajCusI0T6ZncipcFTIIAyP73vMvCXhGxDE2paUs4TbCQ1zPGEkjfUQIS6k?=
 =?us-ascii?Q?57ghJ4YEszYXn/bKzNlYBO3CrZKgU3kW64XdCx2Of19BE8rS/4ygo2oJVBt5?=
 =?us-ascii?Q?m2jo0eV2ETwbz/jqlFO/2w4U72wv0d5cGIBLei76iZrx88AiSXZKECgkm8nV?=
 =?us-ascii?Q?x6Z08EAyzv0miU13FCJWOa13U2Ux1DgW/7tPlIy8sd0eRFxhil4/UuVZ0JGb?=
 =?us-ascii?Q?Dtl69Q0WiPnyc8RdRMPnw7k8QM8t/aX9+DFqhgRFPDcPKbE5pWy3q6HNFtMm?=
 =?us-ascii?Q?zx0L2pNhXoU3kRRqswXMs7yTdq1YuIv3WDL71GdyhJ5kXEfe2UXDFOuRJmuK?=
 =?us-ascii?Q?rphq0mA1WGCT66Muj+VNv2Hlzfbry73vbvSpT6zOGiWE4c1hKexKrAsTXrU?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hWxz24VE6VonbQAFY5Zx8Zt5KprMmjF456IL48tdSqGx9RyKaTjf0HWpANOA?=
 =?us-ascii?Q?SRa9XiPl00ifrRa4iM0jiX+cnoJ8WEKigil5vh4/VScmDsLCnB842DYgXHVm?=
 =?us-ascii?Q?1orokC8XNsOCNvARO+y/QQK4LCeO3evseM/ej0q3PEsVZiEjrYzUGk4fw5Iy?=
 =?us-ascii?Q?9EslR8ibIrd9S9isIWyWIgV+nH7WyKzV7aY1I2fHi15Q6F0CYLEGYASuNRzv?=
 =?us-ascii?Q?kY7Vx1m6ZzFrFG5dzQVUlx7JAESgcKHaj7sAKjsbs5d6OOyU+dBvtb19MizQ?=
 =?us-ascii?Q?RZzJXuu68RKBhCpPsHEvMdJxgJthr4dIUW1Z8jEkVgEqmHG0Y25UQO7Q1fqc?=
 =?us-ascii?Q?Id/fclMHlhh3odExzBn5pFDhfyszwAydCY9u79eL8xARvDNCbTd0PC5Q2ULn?=
 =?us-ascii?Q?POBd/OdvWCSwOryXLz6KXgw+0uAHGqv3kVdXs6HfIew2S/O0nJnHVE/vWMGD?=
 =?us-ascii?Q?Z16A6yhn9ry6ub6XcRm33f0LWMs3VIP/Zne9sE+5qQ1m6i+XXrHyN3bzgBm4?=
 =?us-ascii?Q?0lrZDY6EQpLw94xWZZ2uYLl6xgxOa85lbgePaDMB6s13NkHomxO4iy8ZaL4K?=
 =?us-ascii?Q?RnNcY2vPPTZ+Qu6L9qr5g1p69KbkG9TaZUsPVxVCOkB+mQw2JEaKyTaEjlpN?=
 =?us-ascii?Q?2Tzr4OSFDSyBLJXMcPlj+BtOJvNxqgOKzVgBweCYu7oD2saT4bMEpcHfKEzm?=
 =?us-ascii?Q?YHEO7V8fkHz6k8KKJpH4/Ktmp6OghrcLXUh8o2k4zzakCurRciaZaKGXK7Lt?=
 =?us-ascii?Q?TqCQVMytC4PTrY4DbnPj9f4xrXXQThdsOFL37Ogv1Mchd/Cl1NKUexMA9BvR?=
 =?us-ascii?Q?QU8fGM/h7L0D5TjKJHeH69Ob3gEcrA0rWkjpYTH+uqtTwxtIlLW4Z9bF4sLk?=
 =?us-ascii?Q?JsU58wMTdpzMIluqYnpxxt0CcDnl7rkowwHW2LJeJj4dtU6bWk4gVRuDIS5u?=
 =?us-ascii?Q?OXxse/MPnNHhSq79YHjydxbxzFHkyfmwWGL9PX383jXsucxtZyMPhb39uhe9?=
 =?us-ascii?Q?MH26mmD58dcGd4o+9O+yeu28w5ZdZWCme8swu49xRxMSHEaOPWpcnEaUEY4w?=
 =?us-ascii?Q?JB7eyAYzRLTDeL+lQiPa4QQ/D1iU2Mdv3o1uG/XmlYhYrV6lblf7h4imjyom?=
 =?us-ascii?Q?p7+M8f20QBq13ShLuE5piPKUzIweIcY4IXrbKIdG/CqPtEK37hgprGc7R6zl?=
 =?us-ascii?Q?Knxsv6xBR6nqahrl+5iB2mvTXAS50s2IqbkmCeMYaJys9CJgQH6XfjXCEwHp?=
 =?us-ascii?Q?rcTGhfUduXjea0KLDyEG1fzlgiZxd5L+TfogE/ryuk7/3W56qIgfEI61xiJZ?=
 =?us-ascii?Q?tbPbm+Zdu/xy+dtdRCV2k32psaFDrMrJsF2ZAMMIRZQnhW3S0hJ91mFtnyvu?=
 =?us-ascii?Q?V6rxdo9MROq+ICA+P+C7Dl3uLONbH6EhR4iu5G/9sGkUzTpwB4ynSAsr2/j5?=
 =?us-ascii?Q?sTk2VKBGhwEeAQ2Civ8nsgBYTPAuCEmnAHErVgIBvbNxUq2VVKWJkujVBsrv?=
 =?us-ascii?Q?3Url2BFl6lZAP7UxwCUyiQ255z/vC3mLdS0etGgi3xGvQnUanc+pbljlBPeE?=
 =?us-ascii?Q?0tXIivqJ6mtY3j3ratP1KfBfE9y2ysFCvWGBLB3P1+ZxGUIif5WQ0aUMlpmN?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dzWfDJ01ms96PJtZawwzgymtwlUD4bx1FD2DDWKaFxUF+kkpg2XjTbXAleu4HBoQopw8eunByGDDlsn7LCRuJXpxaEn/FCWO++1mH2LfTgnvv44LEXVSV8Y+fwhQXbfzkAB5+Ir7mvPecyDqIAPEnLpNVgBSc1rpCQjxE3Ztmk/CQS87bqpsWMlGKM2LvSCEWpxEcET02NHnSOnlWrJ1c6hB93A/fYtU1zB0dWnelRuhRE2KepuKHz4NlX45kuUNEUNMu8crX3HM6kb1zwv8AFJ19Y3DiGdWZTtBSrhpXrFupKOEOLP+L/0j97qOlkcsQDrPcZ8+6HMoaFIkkvbBV0pPAbGDGJtK5OxQboyowiU6ZWN4NB5b2Ge3wMJenEQZcukf4Hy+hO0piaAXZJyNO0Lmtpxj/ibD26SN4PuLmPVV1dAw0Mzt6M1tyoj2EL50nY6WMlnmnf9fZFr3tkSvQzRt61wQLgK/vaF4U2EYkMaL4AAzzNE2vK+SEdB55TJABCOLp8SdUdjJ9VvJhxVu0tZ9D6uj/6/jTv4tlAOB9rfBaRXrP+6u676ChbG5GV1fMNuyTL4cip93A+t3vne49w3b4UunLIX0lnU2tyQufl0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05c47ba-6c80-4c1c-d1bf-08dc79b92fec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 17:12:26.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6nZVeurNSDNyBzOAbCVIVl+p6dzCX1ADW43RQVRMSbZqmowvuyYbNzeMtb+xiKxlrrLWKhV4rTejjOfMz+ryA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7520
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210130
X-Proofpoint-ORIG-GUID: 4FF9P0e5XhOKtrxQH4qcoHQGWkVFT_cP
X-Proofpoint-GUID: 4FF9P0e5XhOKtrxQH4qcoHQGWkVFT_cP

This is v4 of part 3 of the series, containing renaming with optimization of the
return variable.

v3 part3:
  https://lore.kernel.org/linux-btrfs/cover.1715783315.git.anand.jain@oracle.com/
v2 part2:
  https://lore.kernel.org/linux-btrfs/cover.1713370756.git.anand.jain@oracle.com/
v1:
  https://lore.kernel.org/linux-btrfs/cover.1710857863.git.anand.jain@oracle.com/

Anand Jain (6):
  btrfs: rename err to ret in btrfs_cleanup_fs_roots()
  btrfs: rename ret to err in btrfs_recover_relocation()
  btrfs: rename ret to ret2 in btrfs_recover_relocation()
  btrfs: rename err to ret in btrfs_recover_relocation()
  btrfs: rename err to ret in btrfs_drop_snapshot()
  btrfs: rename err to ret in btrfs_find_orphan_roots()

 fs/btrfs/disk-io.c     | 37 ++++++++++++++--------------
 fs/btrfs/extent-tree.c | 48 ++++++++++++++++++------------------
 fs/btrfs/relocation.c  | 56 +++++++++++++++++++-----------------------
 fs/btrfs/root-tree.c   | 33 +++++++++++++------------
 4 files changed, 85 insertions(+), 89 deletions(-)

-- 
2.41.0



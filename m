Return-Path: <linux-btrfs+bounces-2895-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF03686BE85
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943A9284121
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 01:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A75374C6;
	Thu, 29 Feb 2024 01:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O9UqZ6p+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pLUqZWzP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2953337155;
	Thu, 29 Feb 2024 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171471; cv=fail; b=UunBnmG9+UC1q8g9vVoyE2mHHVTNeQPVd08hWSy0wTON6mQ3fQDZR8w997qj8GY2l9+6/1x0abJsQoMDnlLMpXLzFW0lMAyto086Aq86y+4BuQlFiJnW949HNrJM1gBWMdOs6vV+uhlNfIo43J+ge8sE4Ct9ieCzwTs2wFajECc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171471; c=relaxed/simple;
	bh=EDrBnfzCSjNLK9BFR5Lgsd/3M04h9MgGiFh2XkC7W3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KEvaHmlYJAgQDXWeocz0LdNfHVzNRXeLjvfpLEyWD40bLqRGlUZyQIjYn7hW49WDvqJPAjCdNCR0Y5vfpqNMzh1+0nShI8wMMYUFjb0nZtgPBQcaLKbVS4NKN7jvfgpqKQYf5uSNiyOUxSq7iZsg+h/JHzpNYzCGkC1f2ogh3x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O9UqZ6p+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pLUqZWzP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SLJjWE016491;
	Thu, 29 Feb 2024 01:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=VierwXjWT0IYdahEerV/dH1etyBy/Q8DniUIZbaet+Q=;
 b=O9UqZ6p+p3WA0RleNJ07H1E9B7K0XlBymbR4MRG2dmje/0v640i4W8wkNfDZRK/2eWVQ
 yEN6WUiyBhRVFuCAIbMCaZxbuOOYdBVUUndvQs9OXKA1jGOpvH2WFS16p1nHS8j1Ql8h
 Gb6p5GWHFh1N2wQ0lkQPJKOz+weIaKy0OVrIV1ZuzSLx0SA65QyAG9SWM6CVksRfpMYB
 v/MACYbjxfyTts2bsrSIb56RZ/VcNf02bRTSx2ByqCKg2QL/2uk8Z9N46iiNXll6yz3T
 CodRrYb6ao6s9MzvKMBgV/j42qWQZgYDu3OzXZtLJgM9HBT5PsBk0M5nXUr8W4HItodi nw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf82ubm83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:51:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T0etME022403;
	Thu, 29 Feb 2024 01:51:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6wa4fyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:51:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCJvZYdtvUn1lGInVhimylEjm75QknmFpoz/cqNR3E18hTh1/vr9PHn5Dtp6ceySY95fa4pUXqGkvLOMvdTWGHsiH5YXp5PjRRw7ETgcDyw3yHM2I4o0lFH9xy5zBoho+m86LW0S22h6VeiwD4KBx1bDmaKW7QXyAiS+0gxI7WWnu+hzxf/wEkjyXVEOy8rc6Amc6cqDMu3Pnu8K3HOR3izb1vNvEQ6qH/f6wB86nwv+br0yFYLDtq0vQ+jg9Lxq0c4KCOX4IzdTxboaPYaLUumUFMnHikw3tOdzplUOEPQIUpL47hdJo9dw+n416lL8gcYdfXOlowTnqcQzwwQN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VierwXjWT0IYdahEerV/dH1etyBy/Q8DniUIZbaet+Q=;
 b=Gg00m2B9JiRs32/QT/M0tu16uE+TRaXcGfy7S3OK+YNlLG7tHkB37bDEsF9AdfCtlL2DHbsFf0+e8yQEZFFCaiWLwknIO7h1wx7FH5wT1N+v/hLbXGYmm++YVMPyjBe+6cinjxDvHL671MULPMMpxWw8Ssv4VTkcjdKKDunmNbFWOXi9JJPVf9s1PwiH0F95Jxx1JWY04zBKpYt6gp8xtNLyw/1DHni6iRjJFo6G1hcsItXe/D8kNH5p+aV2a/z0gJhwye9m5gZWvCmqVjI4K8V9/NntBiTnwMsjBlDCBea+B6w0grcdy3qQuSglMumU/qsVKVUPaokSRbIl3iu/OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VierwXjWT0IYdahEerV/dH1etyBy/Q8DniUIZbaet+Q=;
 b=pLUqZWzPdhwflnMQlx67Yfad0x5lq56cU8uQVOaK5Kjfpkc+fP/moTFZv4kyeN82Q4fQIXqY4IbG5rugcmdrYga1XHn/4AYA2LYrBb47JVFoz/GjHkKPmYoKONR/nnQfaZ+n98s7n7TStEFj0nvpI8ipCmQV/iGXAa31LhLA27E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY5PR10MB6239.namprd10.prod.outlook.com (2603:10b6:930:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 01:51:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 01:51:02 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v4 08/10] btrfs: verify tempfsid clones using mkfs
Date: Thu, 29 Feb 2024 07:19:25 +0530
Message-ID: <343786d75315f45e2bdd8cfb94d5bbf520f3df94.1709162170.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709162170.git.anand.jain@oracle.com>
References: <cover.1709162170.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY5PR10MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 15709fdc-fdf3-45ee-8f02-08dc38c8e263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vK/b0Q901gkNzGy60mCbSLJNRNFt4BsIf5ig6553WbmbtzYG4Zx6rhSji1Zt7PTfppjLiJqINK/Ao/iRwyT34plF+ryYUIAmvyz7E04490mPhBZguVzuE2GQgGK/YDJz7zQ74AwsOnoxc9X8Es2DtsgaK24BRxhl2Kl5ZX8BEMItGzhwy5skpbx0MsPY83p5em2Q5qRwwaXfaa3MD6q2/GOTjw4xOSDo5JnWsjcMLWjqs2Sv2DkpPQDhCtXcj0AXPrVgEjlZoiqVs8Hvb8XjnNQGqreBz96hG3R+lOAPoDVScr/7n/k2OJJE1g45+sAJJI/9Wed9/iQwiE0zP3b6AouI83ZqboQlSYRNvIRiXwLEjPkpxo4JrjJWDsj22t9znJGX5v1IX9Hgai0FEyFOJhp1IxiHHXESJy7O465v3Qyefjt/HWV72Rax8hL+GRZ81UjQ0Civ25rWT/OsBcyWVwTRwsfTYb0Si2b8BwupsTdPB801yLiv7uADIy0es+sCbspqvDRNJMm3/j5X59OZ53MdUxyM1rvVtq56sgGgPqzo1ukgZuuXeevhQ9FVzOod1fLLAY5A4hPg3gUCjEWIaB0OMx1uUu/S8LSF5BbB/hdkFJAXfBUVYgmqZ9L9B0R/ad1Q2hZUEFpeBOrhAgqNEg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LsGc3d5cgEfPZQExXiK6zccta/OcIvSXQGf4iDAnuHczgxqkzliC6BPha/JR?=
 =?us-ascii?Q?nr0BnCoUe/+ojZ8O/O3cLXEG88Du5JFAIWfCeuE4khERtoX1qLxQ7vn41IO1?=
 =?us-ascii?Q?Yx9dSVBSiDfqpLuNiGVDo0N3rW4d/AR4JyQnLgguG1Htvdfs7KV3IGhOGin3?=
 =?us-ascii?Q?uqt45Nnh4iGoZEwb8DFKEPYx0J0aJwjud3d3zk2wfWLSWUwmYqEWlY42NdY+?=
 =?us-ascii?Q?6eiQeDTVdWv5itsKUburHGErr8b4aTAKzndHlt9rh4Jc/v0e3MlcTX1VTaX+?=
 =?us-ascii?Q?gf571Eh6OB65WE5Q49GlZKK9n5d942ZjOq5ZBRanXBvAqxa0U52uGFYZuoSb?=
 =?us-ascii?Q?DVvKJmsMguJNgD4cST0QfchlgaID8ecGNmXVZM3z8QyQQ7yiI/L0ybW1Vv6i?=
 =?us-ascii?Q?TQXWJT2pnb9CNrFdQi//JZl1PKfc9E568efLC4FRbEtFPHFygiYN1csWuEKg?=
 =?us-ascii?Q?rZZ8mEIqMvk/xZMbciGRR/YkVzs4hrGhXMkLwYSdYBkec2l7/kFV0XzRJxhi?=
 =?us-ascii?Q?FvALy1zgK/ExGUQUq5uRaBN5aOB/snLMAXhS0esXRznkrlIAToo5ejXTfWdF?=
 =?us-ascii?Q?f/vzsKmAgk+x070Xhf5z/GIAiBtas+BBGnxQduVVWhh+TrPuT7QMQ+m6vxA4?=
 =?us-ascii?Q?y/URztQal70DNarALEjaamJX06XyV8Sfbnev61Hb+19TcS3r6ip22zgKWKpE?=
 =?us-ascii?Q?0h3YEzp3wi4OMbjBADMlhRUDmUwJGGvtcIlm/ncihq4DrYKaYyJI4hGheShG?=
 =?us-ascii?Q?1qZrvIsv7e1JMjbIoyqpQXx7J2EhPQqUzZWaw83YVtbzSTqxQKa0+ysyBzYN?=
 =?us-ascii?Q?jcXRN1HStiKCaUvrKab5FjJxOOjM6NJ9TGnRX+szroofQLwFCdqRn5gtOK8x?=
 =?us-ascii?Q?rxzR7qg/JlEWT56pR0Ni5caSdwdEVTxMLZnEyzay0AqJYU5c3SAhcQAcar9d?=
 =?us-ascii?Q?mBqykh/vKCSSJFA37ETK3HhKbx/KluRpqIauEQSCCwf7qi6vDzxGq1PWdYnN?=
 =?us-ascii?Q?XPghxDjzf1ZwGfrAF9YfGm2cIl0hAeOU938vsZZ6A1gV4KiSCVql+upxsBR3?=
 =?us-ascii?Q?oIUuxw7u0ZbS4CoQuiJx+iOMuMNNyfVyi6jkIVJnQ4zC8Q3fxHkDRIfJlTtv?=
 =?us-ascii?Q?ra6obmDE7++4fjwv1qjanIwbPHRysjVezMReGQwi4IK0BEResmMp/YznouGa?=
 =?us-ascii?Q?iAiqhFPTk3QrFu4miOEcoFsxZPfrPRJ+H32Z4AkrXJvopq2hsijFPMNw/5WZ?=
 =?us-ascii?Q?V+m+PsqixaDrpv7PsApSTIcCU9lwBRI4rrAJD8C9kIxbfx4An2xIXKUBZe2A?=
 =?us-ascii?Q?vHbmzJM76w7Zn3HgW8iyGaDbk9CUMrBJyPglX6IkenRTtkuovqqGCspu9tKI?=
 =?us-ascii?Q?FQvMj/pbU4wi/p5sSKVie71HpCEPdcT794Dp3PbSJ8V1seIPGhCGhyZ5QeeD?=
 =?us-ascii?Q?f+HCivWQqUJs/5GDwjcUX82oHdkht4e8N34vvc7FJpx81acT4CioEQZaGBcH?=
 =?us-ascii?Q?GU8pDoRqhFkJyaHU2Y7AkiInHbq9KlGE7gpsBwlbwdmacXD6/YHf4LKgET+/?=
 =?us-ascii?Q?G92cfaqcS3G6zoO34BPwqgHdSB9PiY0AYueKK/EI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	EhBa6Ckr8sxrfAsczzzzLsRz2NI6g0zQt/UIUVCkQpi6VnjsAYspec4PPjTTD44Nqro2cZhVYz49R+bU0Up1lM08XWdHmJ1d4BtHXjvR2QgBWAB15+gkHNF1rS3CrRS2SkQT/Iks83Tcnj3FN/g3Iz+aKMfVnWC7C3t7nhzqyhsQzcDSaua0jKLSJ6D2SALs44wV0QhveTk3bp87bN4twkyYM/vV0iluWKrwgRuXHtwOHX94Vj18vcuEKeeKZNv27OFWN/TdDyhjf56YMZg/XrYj6yUjWtyAjO6Oi7gAvk4D8RGYsa/ZCsQm8X0lWXOXj8ItgvOjS3k/8zbQHLIwmRjIhFB1E6LNmDwriFOINoN2V9ckObErOdmF/y3Cm2KinDIwoZi5MHHIX864VoX92TW7jo2zr/pnk0JKNOeNhuQlRu+tkjYtzMN/xHFU4oQ3um0xsI3rl7iaMXb1qvRTy5HVGsGSZl3Hs+U1rO/ncVD0FFgZJENVqTQ+meVOFCUl5J81bNoXxVAa+trz0nehSYtcxdgqkb3L+6xS4KYfE3JOCK+Pna0LL3SyhWrpuFXE10dA8L7TyOIGTqZWaKiAuKIbQR+ekO354OjXYRwkwuI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15709fdc-fdf3-45ee-8f02-08dc38c8e263
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 01:51:02.7921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ls7YzXhEtI6VQhFrRE/EsmI0BaULe0O0C06t/IicqmCtILP981Wh6xxwGTDie6is0GlAEP0w5y8mB8uavPborg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6239
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290013
X-Proofpoint-GUID: pB5XJUY-ibaJHcczV2YYj466U-AdRhtP
X-Proofpoint-ORIG-GUID: pB5XJUY-ibaJHcczV2YYj466U-AdRhtP

Create appearing to be a clone using the mkfs.btrfs option and test if
the tempfsid is active.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/313     | 52 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/313.out | 16 ++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100755 tests/btrfs/313
 create mode 100644 tests/btrfs/313.out

diff --git a/tests/btrfs/313 b/tests/btrfs/313
new file mode 100755
index 000000000000..5b8062f4f71a
--- /dev/null
+++ b/tests/btrfs/313
@@ -0,0 +1,52 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Oracle.  All Rights Reserved.
+#
+# FS QA Test 313
+#
+# Functional test for the tempfsid, clone devices created using the mkfs option.
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
+_require_cp_reflink
+_require_scratch_dev_pool 2
+_require_btrfs_fs_feature temp_fsid
+
+_scratch_dev_pool_get 2
+
+mnt1=$TEST_DIR/$seq/mnt1
+mkdir -p $mnt1
+
+echo ---- clone_uuids_verify_tempfsid ----
+mkfs_clone ${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]}
+
+echo Mounting original device
+_mount ${SCRATCH_DEV_NAME[0]} $SCRATCH_MNT
+check_fsid ${SCRATCH_DEV_NAME[0]}
+
+echo Mounting cloned device
+_mount ${SCRATCH_DEV_NAME[1]} $mnt1
+check_fsid ${SCRATCH_DEV_NAME[1]}
+
+$XFS_IO_PROG -fc 'pwrite -S 0x61 0 9000' $SCRATCH_MNT/foo | _filter_xfs_io
+echo cp reflink must fail
+_cp_reflink $SCRATCH_MNT/foo $mnt1/bar 2>&1 | _filter_testdir_and_scratch
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/313.out b/tests/btrfs/313.out
new file mode 100644
index 000000000000..7a089d2c29c5
--- /dev/null
+++ b/tests/btrfs/313.out
@@ -0,0 +1,16 @@
+QA output created by 313
+---- clone_uuids_verify_tempfsid ----
+Mounting original device
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		FSID
+Tempfsid status:	0
+Mounting cloned device
+On disk fsid:		FSID
+Metadata uuid:		FSID
+Temp fsid:		TEMPFSID
+Tempfsid status:	1
+wrote 9000/9000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+cp reflink must fail
+cp: failed to clone 'TEST_DIR/313/mnt1/bar' from 'SCRATCH_MNT/foo': Invalid cross-device link
-- 
2.39.3



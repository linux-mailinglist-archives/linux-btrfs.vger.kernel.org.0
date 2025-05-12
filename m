Return-Path: <linux-btrfs+bounces-13917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A38AB427D
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 060FE175338
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6539B293B6B;
	Mon, 12 May 2025 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a1LDkpDU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mk5o4Uub"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD312550D5
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073256; cv=fail; b=PBKJlqGV/I33qbmlpKZGnuaiiQoe1obmUchkxkJOUX2COixB0v1o1fcbnXH9Jqc2zP/Dk545IDz/CoBFnIKDcxKQBz6ppJEDiF3LmPKJ415N7TxnGStd0HaNMc17IQVODvBPl0lpNy+22UTTOWhXwPY/WEcxmVoqQm6q2kMLegY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073256; c=relaxed/simple;
	bh=0zORRD2KplDKQeolykbtJrcX7j3KSiDLftN6j+ZDP7w=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lUm0lMwF9L6S9SVoIHksQOsZNoW3tqSH9dIshwltr9dKp0oKKcq8lvZuTiRrxeQSw+4rJqTcATij+vYo+bP5XwoviK9iVR69n5mhZC4jpvt7/SXWioFnIWrkr1I9pgkvfiVBk3jdSpz+1dCjWOGJY4FTOLS05oP3440KMesKOCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a1LDkpDU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mk5o4Uub; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0uq3007075
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=0qMOwehXoD4xOEo3
	DhVkFNrFP3yzIz+8R+vZngzIoBA=; b=a1LDkpDUKPg4LSX0d06BULCcAnmdT0dj
	YlqAKZIQkC0qDV3BRwNiV9WL13B9kMjyZz68K8UlHCrsHS5U24syUB6bEegLLU/r
	qtINVe8Zr5nzaww13Jf7RpJ30k3aBuFKU2k3sWCwka0ZmL0zcJcXtzil4yLWCkrp
	HLV2pMP5nH4T4+6nvyD+MFXvqbUtMhWI70nBqAInADbGhSOcwTv5V+bPcOXIzpsL
	kG/jM2Qu1aM7/+W76B+TafFSrxlKs2yc5xrAwCbOv1OLIfY19V6kB5eEadDMMKv3
	Skq+345a/xfDhdTY0sad1sHXeLdsQ1hlNLSgGRLXyrlRiqyilSY2MQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j11c33h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHYHb4033157
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8dq3wg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JaXZn77GdjrGLUYlItD3+TAjWmDYBRfVUEciPZDF39AhswLYP98RZVQW3QRpS+55w0ewAgWmecMTS+Q7SHfe8uR+9fDQiWjKtyhd15vVO6+KL7g6nt263p9Y/uf670XQTrqKrEC2GFGzDL50mbZEMerg8+wL8TD4ByqKwagCTK7+WpnyZ4vUmS7XPSKQypdQb1dCfr/S4XojeuoCjpzawlOMPjyd/VDZGx8gPfSmJRwdDWiehG+eQiIVkirIymYxX0Ktec/gSCvqHQjtcD8CTJdvwerXT4F40lorZqFMIWi8LwMMeIMZ7bcldtqRYAogpxFYwBShFklsZ1VWsdswgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qMOwehXoD4xOEo3DhVkFNrFP3yzIz+8R+vZngzIoBA=;
 b=AF1YDFjHKZEAUpBtiNN5J06DAVHuxb4rwiW56bsqjgbA4OaQW65k9EiA4QhBAeYHExlEBKH0Y/4FsqRxu9pOvvPrEk08VZxBghcaKH8AMMTH/IIopLDyDQnTn1o9atORybw5/Mez+nSPG7flHHel3n9AHIja7lwgRJfsfBpcI0x8vT8gDQZwly7RVm+5I44H8QV9vZY3RLetpSasoyD4O9MaPC3bgOzhfKIRC5pF7gVOjVfoNESaHmNcBuXGHutNmz/jaKbkF8ORvlS7FnFRLy49H3BHzrkoHjGG60qRk/askc/QprcHLJi0xnnAAroakPsO7RzRdhzq83EPNVUBow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qMOwehXoD4xOEo3DhVkFNrFP3yzIz+8R+vZngzIoBA=;
 b=mk5o4UubnlqWw4gyF+vVEsXqdARJfG3wTmkT+qMiisKGq2Pidi1HduUDtKVLR/kuFVZ3lZ7H9EzE5xBKuOv6ZrSCFMAj0iwsGWO3XisE8J29yOr6AO79kXoGIvBlzeFoHRUuX2nApfI637D5LEEHPE8vH3dK7tBplW45lE2YdxI=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPF415C917DC.namprd10.prod.outlook.com (2603:10b6:f:fc00::d19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 18:07:30 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:07:30 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 00/10] btrfs: new performance-based chunk allocation using device roles
Date: Tue, 13 May 2025 02:07:06 +0800
Message-ID: <cover.1747070147.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0105.apcprd02.prod.outlook.com
 (2603:1096:4:92::21) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPF415C917DC:EE_
X-MS-Office365-Filtering-Correlation-Id: fa1f34ce-62fa-4695-c314-08dd917fdca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lLZDfzwUCXFS9Vdia97cnRARBHDbH9AaBfeneKOJ8X/q/fSZD7Vd0sB+cck5?=
 =?us-ascii?Q?hv5kfiFUVHi1mqYH9ZvQ4aYcnkOsJXKxRnW9XBYgvz2ZBoMMqV2qEI2cvRcO?=
 =?us-ascii?Q?fNmD/4SK8jrNHkB/Fplp5Q9Yq1NV0HsopIOU4Nt0OC+eJ40L+gaI0vgVuxGu?=
 =?us-ascii?Q?L3qnp7RZFPJGgDt+WvfNNn5RuIX1z/KVKsnVyGxBYVt+qThWugmcdJN/ULvP?=
 =?us-ascii?Q?7+PGeHBtEz0EYEAsc72faNFmT7DdyNo7Ye1j9PNSwm+igURkk7eA+y9NZqcz?=
 =?us-ascii?Q?Didz6t6yT4aR/g4K2SQ1R7E+gEzCSrMEgwYPHTR7zRQGb9pLdyxjz2OY8osi?=
 =?us-ascii?Q?cfEWePiJCdnv+QYOFAiWyF6iXZgj5X3gA53AGMwI4j/rKHLOW/S5VuIz+vtv?=
 =?us-ascii?Q?jfhhx3xRzPzp2sMY9As5TTEo8CMDb6an+Lo6uegfTW6kzkBPOtguhqk8zA18?=
 =?us-ascii?Q?QDodX+8xk0JafyTMXjqHuBBqTobIRqpuTp7gichc5cThJtqo+oCyDdzfGW13?=
 =?us-ascii?Q?UixC59ibE/tc6C/+RCQ9ejaaDp/tT+nYnxAU3CkA12l2ERghevjlnpTM7kIv?=
 =?us-ascii?Q?SpHtxkIqFDCX1YTu20rJU8NSwZjV9hHWOM3hcAndMfsIt92XmA0dZPicoNMI?=
 =?us-ascii?Q?y+bmtJP0aeVSWfNX/eq/O6X75seufFMcYMCpaF2G5nqJ3f4ABB2eEopmlS0e?=
 =?us-ascii?Q?wTaqgGtU4xpj+ppS2DC553913kjeg9DcA4oy358ikrVF5Ue5iaLEW6JMQ9Vi?=
 =?us-ascii?Q?y6IicLgz5oHmcIbTwGR9VA/v71kjLwj9k4aU75Tlb535/59sX7pIE17ASEph?=
 =?us-ascii?Q?Mib4PQ/WY1I+swqtwdEUebuSMep2Hpnge5c6RqtOHmPA07Qyqs9djEDMyngT?=
 =?us-ascii?Q?vN5xflj/js90oDIJvsZnBWnllXRaeqK/ImRlie/Cio4yGIadbKJYqp5tyRKM?=
 =?us-ascii?Q?fZB3u8AnTF5xXTwPMKZ3yvWicMZ2EDYZYRLlgJPfD89rxnf6r9Z6EOfVG06b?=
 =?us-ascii?Q?4CE2tw9b42as6wSOwwaTtq9OoDqgb2ear3OPWaz1hwvaiNImOZabWO5B1J47?=
 =?us-ascii?Q?OODlRztJrCxuL93OlNs2DayVzu/3nUtgG9EfIDG/7wZaSmZNTFc+YL1kWtdb?=
 =?us-ascii?Q?tZ7bQcBSqJudPvX3MsQDv4M74QkbvFOuLP8Xmjk73rf4cU1YdPtXRv2ih26r?=
 =?us-ascii?Q?nRHgv2EPD70VYvSHO0Ua6tBtlVnxlBnkQrVWYARAyzD8y2ZU/dHi7bFSNqoo?=
 =?us-ascii?Q?oa0APi7uYzf4ZyVc3vx5ioTQjsDgqPXwu9zIFF9yUikAigaPDx0EY7kgk/i6?=
 =?us-ascii?Q?TXSUT0NbdXS8qu/ROJevvOHLqHyCHlSUudM2ehzufpV3qJ9xfp2U/dihPXlf?=
 =?us-ascii?Q?GATFpdrBManGvlRlGRGU9Nj28qxu/CJzOMbG3AbOKWtyfINWh2ZnbPweMdEY?=
 =?us-ascii?Q?JiubAQHyLVM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Avf+3ivRw72AQ+xT9vULudJXWxMKYNkAJdQ6+tnz8ucxdjIiqa+cVCMqHdby?=
 =?us-ascii?Q?muukgXDbTbrhd0obizFWlVsUl6/WT37nYDu3z8AGU7HF6Y8hmaSg05PGa2M8?=
 =?us-ascii?Q?grqUcmpZ0Czx08PRb7ENQOUb3dqVH1IGOdWHWwKrUXAtcD84VBpowt4wAkI3?=
 =?us-ascii?Q?2USClAMkwKq4HdMn/WQuZq/xQQLMk6XrSgRzQDxvzQZGYKJUk+vB485JhUvc?=
 =?us-ascii?Q?0XXACVzsX5noVdHRT7uv05VIdHdOLjV9eSTzffpBr3nWI56bHydtzgC+xqiW?=
 =?us-ascii?Q?pBa5o9ur6lvnfQVDhSgTipKu/XeBwxZumO0QaFzSR+J6B6ZEKnVtuvyrfqh0?=
 =?us-ascii?Q?DXeeSih8kZLPp7GiYYrfEp2Y9i+z8seqh3mk0aodcMGCGu89O9bXn8SlSDWG?=
 =?us-ascii?Q?XYO3wh/01jpMckpMBxCdQ8nlE5j/EVW9kh3TmWcWuj58HHUWIzMOD5I4hMG3?=
 =?us-ascii?Q?64mNczYYjlbDWszaS8V2lWfVJiBwiuO9oQdSV2iqi6ulFyfzfAXjlexypm+Y?=
 =?us-ascii?Q?HCaCItXxyRvsLfIwZ6XvLOcEGsmHjfh6SBC47D7RK8CGXbZQ5JN68AbOorSr?=
 =?us-ascii?Q?vWmif/XjC/4JpNj3JZ+NFCCHfD7Ndd686pPWZprMpKP5F8NRqoh/pX8MvsOX?=
 =?us-ascii?Q?4oVQwC2FQeogBDN2r42SMB81EAgBQhXJ/25iWnCuemjipSgV1ru2LvMjtLEN?=
 =?us-ascii?Q?SFnYIVslUrnf074YecUv020N1boVszBcvQEsj4r9nvlZjd1j/+/5gBiSPyL5?=
 =?us-ascii?Q?bZYmF4V1gUk5GR5W01LswnzmGkjwJega+oRviJFUZgPgZjQpbKXDXrNTboBa?=
 =?us-ascii?Q?QGNP7VIvqq2c1DMDl0t40u/Waxpq2NC4e5JM7pYzp5qSglrSv9i/GDxzsRDa?=
 =?us-ascii?Q?FECh/MLSmmBkwmAmGGqkhePTiK07Q4LJgLk/DEky0V8fvQxwfTpr5uDM5Mqt?=
 =?us-ascii?Q?zd85+SGfoFNZgeTSyY1suU3sWaEDACBinU/FjWs+kl0XqL5jLbJ0EBm7/rMX?=
 =?us-ascii?Q?ifJUalLIBVqcn5b0DD1CheQ5eTh8q0oDTAlUmuKiCW9jKGS4e3khWNBdx92F?=
 =?us-ascii?Q?OFfETgf8mAKOAueHbamvknKN3Vw9r01ZJf6l1rZfYeYgftNtFv0b3M8AHniD?=
 =?us-ascii?Q?mHLwR09qsVZD9UVrFBbhAIBeKqe3cmlRj7V9e0uGFwnJ+ufgYybzFqQp0FRp?=
 =?us-ascii?Q?RKhI5+muzRvI83MmcXzTMJ+wyslUZ5bfmCZUK3SybF6H1F/sRBtsLEdG+bye?=
 =?us-ascii?Q?ZPA3Gy0SOkwHA9iAIxcaKB8aCVi1NIkr58cyk30E5aGcKb7YOLy0lLUHEQi9?=
 =?us-ascii?Q?Zd6Ms6r+rDmPJBXOAEbJw//bw4K7FDd4xygliWsi8UlYpSJy83GECG1Wmlx6?=
 =?us-ascii?Q?MfPzXKZCUZv5S0ZY2j5+bdinfVnPOpyjiK9E3lpoh3VdiQ5OAsMEumGgDmEj?=
 =?us-ascii?Q?FIDDdbLIh+IFgOCAS8viaGY0qaYQTvr7XD1hwsdscs+Mvm/6b0ysK0sAlHVL?=
 =?us-ascii?Q?xFF13nhZzeKQXoS28UkvZ5VDneHGM7IbfBaGIwUMgch+Lq1mbSxqvyG7dZC3?=
 =?us-ascii?Q?bu1bZzN2RHNklNJZmK5VhVbGBh7cr79Hz5AoNavf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N+DX/DCRTq7D2nOUjEsHjxz8f6Z116POBCuEUqLse+0Rj/gUZe/xA/S5QD/ffLfswpBhkjQQr60lKqPuJoVR+SFjgkKxWjZRfMIivu/8POlX5RQycGkKu6nw227jCrdFo+H5wxfLx5FxQHsDARz/8VYARatxMcoJniWKS+HIXAlJhfbaRyvGPoNdfpew867ByXDuw/heaB+CHHMGQ0YL4/u9Qg0D/Yy3d30dLwaoR1JiTmR6QP9ZP1FofobvappZBgaYCbVycfV0uum5sq38Mj/oBnfwLOEJm6ilNtNTaGw64gmC1zI1KRyRei4pCmLYaUzc7oSVVRS1/5nSDN0qtsEcxzf7lQgUcnFt7XuCG0kCOwmVNREOzrMZV2qgVEYmGZIMvbXBobWklXtpsmyKEPOncIHtWrJrp3svwJY4Wiyv1hJE3O/PTEk4oDQR9fUNIQ6E8q+HIJBME9whyz23we9dOq2QwBdGmnX6MLdiwmdSWm2wDqiGV1XUvcV8AsJmOogHUgn6hXqCKgvEh00ycCvSqFrTOJRgFBHXI2qmCvY+eB0y1z2YjTzV0Zv/gCXSFETag5QBjw4koFniJYgzaypJEALjChcAmq5/1bnhoO0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1f34ce-62fa-4695-c314-08dd917fdca0
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:07:30.6911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UC/jBZBJuxEZm6krR58zGK6ZADeAhLm9NbYpXZMKnj+bmqHpi9fhBTqTZegkWoYVZJtUIpon8UBzGiJWosjpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF415C917DC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX0bX6j6Mt98pm eujX5NQoUNtqLy4mYMa8oBN47oxzDkYc595PdO74TaZry+ZBCVm3sUWDynfkmHRk/DPjSrH6UQI znIiJe/zM3iMJbTkhHQ6a5qmiysgNKKFzjN6Ag+gUWEGiGMZdZey/atxtr3OqRnTHlj6ZbLoI2h
 g2uD20bGUgU6e1jyoVHX0q5tyWU2UnRyovXHF086MQ+FWSdBf3tkWD3zEkHTziR+BOQnXPkDMQl AmzOHEu3AM+2qZW2M9O+8Kurs2YXm/gjTd8kHZfu9UimHLWvIsa8MSmfSNMNb5eILakROI9fw2c bR3ZQBPOl+kCX/5HM5x12d3uiMSKOowCKyexEYEPPRTj9Bt0z6we/d55RsYWyOwPSPUG0PFFhAd
 P2fA8PJ9zLL6GFkcPyieuVJR1VDNNIa4NaHEl4742jXtDUccurXHBzrhRVCZoLggAIK0p2mZ
X-Authority-Analysis: v=2.4 cv=YJ2fyQGx c=1 sm=1 tr=0 ts=682238e5 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=H0-uSPfj0u51TC_qqLEA:9 cc=ntf awl=host:14694
X-Proofpoint-GUID: LMf1qWPTDSixQYdHvAOBjS46nnL3GkUV
X-Proofpoint-ORIG-GUID: LMf1qWPTDSixQYdHvAOBjS46nnL3GkUV

In host hardware, devices can have different speeds. Generally, faster
devices come with lesser capacity while slower devices come with larger
capacity. A typical configuration would expect that:

 - A filesystem's read/write performance is evenly distributed on average
 across the entire filesystem. This is not achievable with the current
 allocation method because chunks are allocated based only on device free
 space.

 - Typically, faster devices are assigned to metadata chunk allocations
 while slower devices are assigned to data chunk allocations.

Introducing Device Roles:

 Here I define 5 device roles in a specific order for metadata and in the
 reverse order for data: metadata_only, metadata, none, data, data_only.
 One or more devices may have the same role.

 The metadata and data roles indicate preference but not exclusivity for
 that role, whereas data_only and metadata_only are exclusive roles.

Introducing Role-then-Space allocation method:

 Metadata allocation can happen on devices with the roles metadata_only,
 metadata, none, and data in that order. If multiple devices share a role,
 they are arranged based on device free space.

 Similarly, data allocation can happen on devices with the roles data_only,
 data, none, and metadata in that order. If multiple devices share a role,
 they are arranged based on device free space.

Finding device speed automatically:

 Measuring device read/write latency for the allocaiton is not good idea,
 as the historical readings and may be misleading, as they could include
 iostat data from periods with issues that have since been fixed. Testing
 to determine relative latency and arranging in ascending order for metadata
 and descending for data is possible, but is better handled by an external
 tool that can still set device roles.

On-Disk Format changes:

 The following items are defined but are unused on-disk format:

	btrfs_dev_item::
	 __le64 type; // unused
	 __le64 start_offset; // unused
	 __le32 dev_group; // unused
	 __u8 seek_speed; // unused
	 __u8 bandwidth; // unused

 The device roles is using the dev_item::type 8-bit field to store each
 device's role.

Anand Jain (10):
  btrfs: fix thresh scope in should_alloc_chunk()
  btrfs: refactor should_alloc_chunk() arg type
  btrfs: introduce btrfs_split_sysfs_arg() for argument parsing
  btrfs: introduce device allocation method
  btrfs: sysfs: show device allocation method
  btrfs: skip device sorting when only one device is present
  btrfs: refactor chunk allocation device handling to use list_head
  btrfs: introduce explicit device roles for block groups
  btrfs: introduce ROLE_THEN_SPACE device allocation method
  btrfs: pass device roles through device add ioctl

 fs/btrfs/block-group.c |  11 +-
 fs/btrfs/ioctl.c       |  12 +-
 fs/btrfs/sysfs.c       | 130 ++++++++++++++++++++--
 fs/btrfs/volumes.c     | 242 +++++++++++++++++++++++++++++++++--------
 fs/btrfs/volumes.h     |  35 +++++-
 5 files changed, 366 insertions(+), 64 deletions(-)

-- 
2.49.0



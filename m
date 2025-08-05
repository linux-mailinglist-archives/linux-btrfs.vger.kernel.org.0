Return-Path: <linux-btrfs+bounces-15856-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 219FCB1B913
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 19:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4192A17B249
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 17:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4CF293B4C;
	Tue,  5 Aug 2025 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y22W4LRp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g40mug1d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C0328136B
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754414100; cv=fail; b=RUrOtB2qflwJDaRxhAID0lGJzz8HqXfNq1hb0LJRuUS+vcWEjUwTZHaxikSyT4st08D4A8ej0jUnDl7950oPO/57WEpMRkbCqzPGd3Pq0HqZ+LEo3M2mx2M7XuxQBu0WQT/d56A5QRYauBAQQAUpRO3qtcPbbsMo3/PIkVHptPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754414100; c=relaxed/simple;
	bh=6LEzSScUHoSPUGNwRToejczyWjLdsaq3i9q73fR2gxo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GcD/qS3r/ab+uDGQbGMK5cxQWb8O5Pprs9Zrb5s4F0VW9SZaSikJwb2CicTc33x9dAskxeu8YjUIiKzb+nDJcMpHu59dr80gE0ZwJQ1tnSP4HAauKXh5aFccfzZIGovXl7+hCTXXTpz5YKuNlE7kQlwUTrP7xsSztykGvz0MN3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y22W4LRp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g40mug1d; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575G1BuB014852
	for <linux-btrfs@vger.kernel.org>; Tue, 5 Aug 2025 17:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=KX65Gf4vNm7RuOJa
	rShurNcNwd35kC5SXqjBHNmo6oM=; b=Y22W4LRpuwJtJpb/fK8Wntp2O9N4rWzg
	fbANebCGBLJKioUGF3EEUiEW8zW6B45kc9sREFf0FYL+b0q7oolv3l19Sh7uyNaH
	5KjORDQHhGUKE/D3JNtPShKT4/JceZ3mAOJjLQ0fevooRlr4hchH+LzNzTuPRdR+
	3urEkk1M/7uGV/v4dBAwHPdPJc+ynQXK8cAkRS4+Kc7JfQ/ttOSzKq5utXQBK9yu
	GhoBhywE+eMyRfT8/Tqm2Bg/jXLh8UG2RGuOtpHT1+doD7d5sT81yAleZS4Q1zuW
	ofMnuyqZ+L19VgMvak1QAjQw99MgyEjEVSfCT7pBnsLjCWeKHZTFJg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489994naad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 05 Aug 2025 17:14:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575GNP2u025137
	for <linux-btrfs@vger.kernel.org>; Tue, 5 Aug 2025 17:14:56 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7mt1edk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 05 Aug 2025 17:14:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW0dCWwxjIrcD+1xiT+sOxl391EesTBFhUeYyrQukjdvWWWut1SHQ1hmQF84NGARS379PJ1OE89z4SluJRaKfVGxw9dgEpCLfPxH5SnjdFR37iDxyeChHHiwzq9ksQd9w7Qd13HjrjntvX/W83XBGh8ar4UHjZuRrwrpeHID0nDL804M7/8PFlndsPSYLVJN2EPMEipGnfQoXlTgbfO2/eP45A1MzYXY9JwpVVSAFEdVRNDFCqc+TzP8GGNunmkb2fYkq6SpK7eXRvbjJZ5Sx1KbUWnfnpqwIPoOtHsgLroijxrmhsDI2G1Inn70mvF2MirlsLcDMgYznxcE4Is2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX65Gf4vNm7RuOJarShurNcNwd35kC5SXqjBHNmo6oM=;
 b=aEg78olCDGokBjVKNoPTUSVdCRShoABcUi5XX2RSi4OI9RQ8Iyy6kDVgVw4jKlOwpe9QtPgHNpWaM3jQqGESVF8NmBO3AOwXaKaBrB7d9HKHjlruhwd6+eg+FfA6jvlfFM/veiwnpMoXKBz9YPb+aQ77wsWupYqkMADaeDKUYaQtfYlqxcaxJZ6vwKTwPZbOTubttD1kIFSxo+wuSZay0wnFTyLOOGzGQYMrx5YDcJcWkMm45ZrWXT9r+NKlTa+6kbzr7vltRjBbAiFR15Afz9igeFnEybHzaq/M2SmpTD6yHVMcfqB9ZIiA+1M7gleA5uV8X9C/26RZrESwey4+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX65Gf4vNm7RuOJarShurNcNwd35kC5SXqjBHNmo6oM=;
 b=g40mug1dap2jNkVqvU9DHJngpJVl2YrqWiH+ZyaOAsYi39YnwFPcB+uAhrWIlsENAXZBj4V9BPFTvibMwl6TolaNpjxrn44DhahZPLSIf/tYvp1xa5RGCDuKlaQ7jqJGeff6RCS8+3FmHpAegkqisQd8aHH7OESnJ1gS7u8fJJ0=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 DS0PR10MB8056.namprd10.prod.outlook.com (2603:10b6:8:204::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.13; Tue, 5 Aug 2025 17:14:54 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 17:14:54 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2] btrfs-progs: check discard_max_bytes in discard_supported()
Date: Wed,  6 Aug 2025 01:14:19 +0800
Message-ID: <614684a6dfeafb1e4d2fe721b2b89f564449d223.1754413755.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::18) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|DS0PR10MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 21571e3b-970e-4c1c-ec15-08ddd443981c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OihOcpzBlkSvOlHefcN1mclXAwYLlv48K0XBM1ilkrvvtfRTN4GChyZqhuJ+?=
 =?us-ascii?Q?CC0tLPu8lZzYfAZdhEeafcbMeWs8gi1prAOd1OKKJ2mygcpzv0LcOpIBTVYK?=
 =?us-ascii?Q?ke5Vc1LuyQfbAHj9paGQ5BdA4OU0uFupMFUa8uuHWtwjb685Dt/eJOnSrukA?=
 =?us-ascii?Q?E4peP4Yluo8ih+Jvpj1arzkmS94E8lclkEZJoSCBGLTwLg6n/wOlB0N1Blok?=
 =?us-ascii?Q?YjvcbV1B60WSFXjIQzPG6qqWLIj0UyMLIVd+tH0SzsXKLeEIQVPoizvU0SvF?=
 =?us-ascii?Q?ttBEGHWpDhz52H8AUDcWjYPKkfAMx2CSwsxkYQJsqEzolTSwKBqZlZ5v4Ebw?=
 =?us-ascii?Q?wfPPSlnZC/hXMOKzT0p/DRC/m6igMMMhaETmpIRh7E7pjmtcrpgUykaDn7cl?=
 =?us-ascii?Q?Dd4sft/smY64rzCLG+z6Y2WmoR2XKf+m0c65I3QWjgS9UCd/aW3a1fJoS0lm?=
 =?us-ascii?Q?gQIPJFsacmu5EtPl0ztXd6pDYSvma9IjNUaa7UWTRyM/SPky2/2aSqFvh6ji?=
 =?us-ascii?Q?aAeDWYb1dPNoG1SHnSUSvM5KFEAipWhQZkpsrv4mp305V0zWxr8Y53/Y80QD?=
 =?us-ascii?Q?DRLvisuqVBANEl6axppJzPtZIrsvTepio4rtjNCHx6jhpb8pgG33DxRkXnjP?=
 =?us-ascii?Q?8QgG9RecjXIxBcbLRRa1/5WfWPgnA9b2v7f2ooi5s3sm8/I0DSgq1yDObYH/?=
 =?us-ascii?Q?F3ciROPaI1wjSbXWwmZoXf63ogWdCgzudem/AgGDZj2MoR9Bl0g2rKNtr2Ab?=
 =?us-ascii?Q?D9h5nIwmt6r9bT3UYt0hiYeOVrNYOCqdaDJ+dzY6QmxsjbW3+W0TRooRVTy+?=
 =?us-ascii?Q?/EQj0eL+LHteENuq8tr+PjuNTtLsg1lpZSRLYTQYcuQaCAReZPJ/4RrK8pFp?=
 =?us-ascii?Q?l7q2DMIwMkXUhhZxgbnzWWTBttyI3oGajl9ggi0Sw6Dh6DhNaB3K78lgC+5y?=
 =?us-ascii?Q?+Ce8AP9+LWH650GfgMbtnPYfv1Cm/RdUuObcTigaB/5/srOl8VDIp50pu+2A?=
 =?us-ascii?Q?p77Uw3YqJIHrPI7WSKFcN7melgEX5vSy8pIIt6HDBKTpd+dmwMsq954v8s0n?=
 =?us-ascii?Q?8O3Ht5RQD2MqIBJIkVHbprSJgU8QAwlcMDLj8GAI4S5DLzVaA/Sgh9gq+39B?=
 =?us-ascii?Q?zadTU4fD58d/cRxQDNUfx2N+XlpjYCgj/g1YfUkq7N7Sw9Mehe+h0KO+waDb?=
 =?us-ascii?Q?9O8x2KIw9j2KpgDMplaLbH6G9OftBJVCYd5rIxLls6tHMJfpzubf1ZOytyed?=
 =?us-ascii?Q?9OUnhWyrNRgKQPwzk1ddF4JUaBdxxmrYnEjhZxiPRW73VeN0RHGlaYp2SUv7?=
 =?us-ascii?Q?MJHFZIqePqE2PHg1ofPlsca+aiihh2qKA57XRIXHQ3qjBpyy/oitK9W6nyjL?=
 =?us-ascii?Q?TvYfsX/ltBs0ydrTc6BaIz06jjhGoN+GirUyNop0uN9exV2Y0wQa0wgHmWjT?=
 =?us-ascii?Q?TpHiKJt/Iu4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z1wAiFfhcrNz/5KiN83x2hyammshj/jBUV4JnjzGzv3PhMjFC0fdKIqYHHpv?=
 =?us-ascii?Q?7e0KlBKTc10JdlZD6V88GSSQBJZbIkBr4874OPCGl1w1NAtXKFl/G5ou6gFy?=
 =?us-ascii?Q?C3S56nQqo/HxAY3pHkD1FRGdOxkZDqmc+oaW6cigkScisCSR2BugL2M79WBZ?=
 =?us-ascii?Q?Ys3lhvR/Zk2zQi3J3IqDtkRqNX8NAmDu8Z8zOPxbzH0fE+6UR585BKmQUM47?=
 =?us-ascii?Q?mtmLKj5+MmLwEH/2VSQILQTr6tdBi3+3tV76+Z+7NI2rC61M5wivSE2xhFtz?=
 =?us-ascii?Q?DysR/Se1ZR0G/kcg2xc0Aa70xne9BM32QUuAI2O4G/S1Uh1vtcVF3dwvbB0E?=
 =?us-ascii?Q?9VB+b+DWkehRo2E6iScrxHiIkSP1eDnqtNp2MvY/aJNrd9CKU0dHmc8cZiub?=
 =?us-ascii?Q?4hKbw7zwbCM+FBEUOZIlS4KoMleVxKxyXDf4k7DmE3nTPiV6dFyOc8Swv5iN?=
 =?us-ascii?Q?P4h7DY+aQ0LTY+LF+WfhRROyr6auvbNQXD0jODd53IlesstVKRFCAS3uEUW3?=
 =?us-ascii?Q?biM4zi545+1hdN2rUA2L0NZqpYPr5herA2lkpz/jlnXgSn64E9o1FQPrQu5W?=
 =?us-ascii?Q?yTDmWHVPWjX3oUw3tDErz9fl0doxkK4ao2t0G0E0omjnKIO21Br/45cWbRyc?=
 =?us-ascii?Q?F6gKaTTsmLFCaChS1zorqOi0AwEjAYrxnPmilioBEvAWMJto2/h1CrEIAcGY?=
 =?us-ascii?Q?MI/HnQduEjpWsUQ8J2Mp4UDZIwtG571m9NNczfx9uQkiUc9ffk+2vDytZqxR?=
 =?us-ascii?Q?gY7JiN+7f74VLRNqQpfThb53bPIQcLe/TVtF3uEOBRq8h35QMBarYtp1LQIi?=
 =?us-ascii?Q?SQqINrEM35oxMIH+T+Aq5BODAW0ZbHf8ekHtO7kScxPhsruGidec5TThOi2o?=
 =?us-ascii?Q?dcxAVs58r14EQr7z0z88C+gfab2yhYIZYmeaBgJ7YZedri+Qg/P7MDEXYgCi?=
 =?us-ascii?Q?h1TGdIpFTdCMc6TlselLiQRnL2BNguWpS6OsLmeR8scUjBeMPjM9jdajSC+y?=
 =?us-ascii?Q?WZ5gn0mwrDTlajNopAus6FxP3tSoXKgeimoov3quq5DQQNz2KsWNLfdyEaYW?=
 =?us-ascii?Q?L34OEInHxbh4RotV5vZjiEbpMKcFWQo4vZmRlTw4bswSAnnSN3Ug9KPSiSS0?=
 =?us-ascii?Q?0IL4x336osH8wY7gfDGBLLteqftrFcdQg9wQZ0KdvYHrzdS1uZYlEZ5QZ+K5?=
 =?us-ascii?Q?s6urp6o88f1eIv7yoCcIFX0WFjZ2A/n5y5NqW/0IH/Fcelm+rUfVnfUaONKe?=
 =?us-ascii?Q?teuMnMJ1Xth4pT04fsr05WLyQrup75Chjp7qGZxks09vNgKzqW597nYwWG29?=
 =?us-ascii?Q?VR3XcIpZlu2fFOgFbZ+eotRH3yto3g8R4/V8mEUBj9zqcBfdoKO4IsGHUMRD?=
 =?us-ascii?Q?GA5pO09qeoyeZX9/pUMKszGPULdBAbMmYE1Lfj2DGxaNVkO5rlefRsmj/A7s?=
 =?us-ascii?Q?x0zf/LgZQP4JwnS9SJCFXckezQ1YYGJAnL9tlhNPimf2tUb5Js6jyCFZNdXW?=
 =?us-ascii?Q?Ki4jHXSTBeYCYP4WyvQVoCNn0OPBhhKFZiYRJKEp5uUKo5C4MYjJ+R9ufNEo?=
 =?us-ascii?Q?miuzMdZW8NQX5the/vV/r6o34/7WVEV78FwQCmWo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4P/0NGLVgCkOnlrtVSDyCelBTHUb4ozbU6fymSbYJtsqqd4zy/Ji2qsz8ZtkCenlZt7l1SKSJx+lpfRtvbYpVc6CvRqIsrS/qtV0L9woq2y5UtYaEIjJv8q2eg21I8Pb/QXTbZxfvf8Zs4BX9ZhpctZBdNnx2zFExQwPEZLEd3VCmIjGfQctlCInjeB2flgCJrnPxfq3Dx2WxZHUaVlun3fUubRfuCtkvS9J0AYDWxRVbQ0vDXF+BNR159u44qiaJ4t4Ch/Ha3fPagJv8Dd9ok/kuRQ4f2XEW/rftwSceQ+9gFcVnP0DvP1p7N7mAEou+gmNbVAALXMrjwIcEOgGzRzMU5kdvloCSjGbpXDOtByEitysfR+B0XpmmCUSucPGWmL0Xmpa13NL0F/nR/BOTD+ZAszF8D/NDENhTTQrDMFfittf3BVqFo3fyQ0Tw/QBA0fSnxnbryfedEvHhmEvQmmCeJNd0zAEU0j9J00wXhAV1osNAUwyTZ2/pq4FqZjyJgzlX2Bo8bJqGlRUMWUMFSdUSCmfICr9TOp4A3CL+j4hiIk4NcCEDBvDEjmo68WogxbWXAqK7B+qV3adihNsMbwj0dOhGShkYsKfhga9uYo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21571e3b-970e-4c1c-ec15-08ddd443981c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 17:14:54.0476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82aWND75wFBiStuf9EbyOk3nx12KCi45y56EDdrthzydvpj3tmySO32xKyARgJgHUn0PLy93eD0rTaBcFymZTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508050121
X-Proofpoint-ORIG-GUID: I5x_M7Cw-fiEc1TYIaJ0Okn2K1qqcrsN
X-Authority-Analysis: v=2.4 cv=HY4UTjE8 c=1 sm=1 tr=0 ts=68923c11 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=jcevaN3JmUXjRgus77AA:9
 cc=ntf awl=host:13596
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEyMCBTYWx0ZWRfX7/ZqzRoyLs0T
 bPoD44CKBUGIKpYerLWLoG5s4Ta5YB8pyFHzeo5qMVHvIiKWjvWFaJCT4SsNipBIgJlMcF5aOoe
 QhKZSdErRImmJZtueWjwofQ67a1UvcgqCwF7XzkV+tOD0mMXF4PxsFGBF9D5mOjtGbfn3lw7BcY
 AjgAGZU7/eXbSp9kq0aJCurh0biPuFwubVKZEfMEVA1D0S5r15O2ZQRtGVEylb0qZh3uf10xLTV
 1b26t4oXfNwP15t+NTO60onL70Ee/4uA3F+VxmumZDpsXMByDflL1IHIi90hvtVOkaXQFVQWzZl
 5++gCeHQxCeYckHcslnn5x0K1/8yIsIOPWfxrn+UhYMHc3MZkwP3wjhhOZ6kDBcS7HY4zcWq30S
 qOgP7Tr/ZtwEIEGBrunKvX3xAuh9uNMqiJdEz3hPcUtespVst7khcQWwMUk/9v3QnwL6GTb4
X-Proofpoint-GUID: I5x_M7Cw-fiEc1TYIaJ0Okn2K1qqcrsN

Some devices may advertise discard support but have discard_max_bytes=0,
effectively disabling it. Add a check to read discard_max_bytes and
treat zero as no discard support.

Example:
$ cat /sys/block/sda/queue/discard_granularity
512

$ ./mkfs.btrfs -vvv -f /dev/sda
...
Performing full device TRIM /dev/sda (3.00GiB) ...
discard_range ret -1 errno Operation not supported
...

Fix is to also check discard_max_bytes for a non-zero value.

$ cat /sys/block/sda/queue/discard_max_bytes
0

Helps avoid false positives in discard capability detection.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v1: https://lore.kernel.org/linux-btrfs/2f9687740a9f9d60bdea8d24f215c6c0e2a9657b.1753713395.git.anand.jain@oracle.com/

v2: Checks for discard_max_bytes().

 common/device-utils.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/common/device-utils.c b/common/device-utils.c
index 783d79555446..d110292fe718 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -76,6 +76,17 @@ static int discard_supported(const char *device)
 		}
 	}
 
+	ret = device_get_queue_param(device, "discard_max_bytes", buf, sizeof(buf));
+	if (ret == 0) {
+		pr_verbose(3, "cannot read discard_max_bytes for %s\n", device);
+		return 0;
+	} else {
+		if (atoi(buf) == 0) {
+			pr_verbose(3, "%s: discard_max_bytes %s", device, buf);
+			return 0;
+		}
+	}
+
 	return 1;
 }
 
-- 
2.50.1



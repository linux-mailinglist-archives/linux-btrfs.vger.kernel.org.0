Return-Path: <linux-btrfs+bounces-13939-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DE5AB433E
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA7B8C720A
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D102A29AB05;
	Mon, 12 May 2025 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dxDXBsXn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W4WbMhNI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA129AB11
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073467; cv=fail; b=nUiWK/MqZpXW9WQ5XVYL6kPBDRgvuioRihrVDXbiuGiuBXzMcLgHRGE8b1yg15yZIkPvp8jFkLrf8GotWgT0TEz5MogiQnAHZ0oejo/FcF/2WM1XxzlJ7jNcRqWbbRTeHaFEnfICbgjFzCEXf+G8VNNgt2Pcx6LUvRhDSY0470Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073467; c=relaxed/simple;
	bh=rzmBmo2DgC/JotwPLkj6lO3iijkA3rtnjqLryuOhoko=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pxlDGd7jeix4Tuh+pKo0RmwlCl9V6SVtZK5W5WJiiZYRyg8iNGxd3WEfi3VHDeWm9O3C13Sw6BKfneg93GR71UYmms4TgMULyfmsi3lC2jymJzxYAKVKTSWf2//cKD4UAc7HmPnBq7XuroIRAsE0XlS04YVX+KYQYgRYZhUL89c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dxDXBsXn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W4WbMhNI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH189A028422
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Ksa8MhRFJ7ILGmhXo7eN5wBFETelc7x/n3uOpvUVJDA=; b=
	dxDXBsXncx4KKWtqznrr9cTDKycDOp20MDjwwGh0Lo8DN7EEvjAW/o/IIpK1xWtX
	7XiARqtP2uaXfXCo2x/JyDglaJTbgZOClu6Egu4fWcx6jck85hge4nZ993g9kK0L
	vIWCaW9URxRJIpV6uVzB92LGnhS2GMivV9DZiJULpy33tS8XVLK6DCi3OacuMYJH
	DrBCdFg6AG4G47r/2+yqA4lwYcm6qZxcSLxCZksNfPr/mJ2urru+NPwM3JjFSyWq
	6VcbhW0Uo7mAZ7lsGqXXQGZzVkZN2stiGZ750hhs5T6EumM1g9Pz6mdRD1cBmk7a
	alNbpmArVINIcnL2aT3y3Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j16637y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHVArC036287
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:03 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010020.outbound.protection.outlook.com [40.93.12.20])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw87q6sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:11:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J6KtXaVjqDrz0ouooK0+Xoq23vTPIVEwphFoE7YAqoPJ33rAgCdeOgLUqqDQwYLcCFVTunHm2e+chDgjb6bn7lFKWQt4FNK+9NLf7/U7eCUJnlsxEvwle5LWN2smHI0Z1WeD9jYErzMBvZmepau4cA24sN9UgenbSPjm/7IkNcuWBpCXtJpic/9e5HN7JIsaqFxQxZGmq6Ieco6MmvzqpVnjQZQQR8BOg/NOeosiZbho8LXl9gFD0HPHNHVrGY21KJDNnVnIAvhifPmEQfPwXrxuWwgdIWWiGyU5k63cgogeedVwmDCWXlSaHVjCOtFkazaI6kEXXozhAybg04jJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ksa8MhRFJ7ILGmhXo7eN5wBFETelc7x/n3uOpvUVJDA=;
 b=TcoXIsYZ1KBTFSZ5utpcWs3BiEhs4t+tK1DvqWjOWuUcDmWfwZjtGAbP7uuBbcA+VKKX7z4taDeaf/d5ExgqkuQ/vYRrJKEOg7qaicnxSIfhtod0H9px9SAgZfEPjoAwGjJ7fOu97jOmMuvoOy2qTH4ARoCVFcUz3lpGkARAf3WYsoQx+WhjcWWpz1aXTK9XbxFPGcm3w9JCW+tts+E0qg56Vcqhd0vZLqdoa43cWCjtTgXlq7s6RIn29Kd9/jPg+gNWpGjILrCLmTULf3k26eec346W5K83jqoBJe3KTPDMnqA8qGGB3y+EevJKwkqGYbFC1onQu9DtFz1X0xgMnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ksa8MhRFJ7ILGmhXo7eN5wBFETelc7x/n3uOpvUVJDA=;
 b=W4WbMhNI18HflROXs4sd65yw+xSDiOvRg7PEy0LvSWfyPPPwDw5XFn10x2p9/Q7R2T98sg3gFmLwYHDwm0oW6+Cv6krrEc8gMX5zwfzucqo/1+r4a3fZvkxhgIA4jP9uYWr/dWjvTbhf/SHaw6GHcIRnSzmFsXzs+FGHaAVp6HA=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS4PPFC7C4B0ED5.namprd10.prod.outlook.com (2603:10b6:f:fc00::d48) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Mon, 12 May
 2025 18:11:02 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:11:01 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 11/14] btrfs-progs: helper for the device role within dev_item::type
Date: Tue, 13 May 2025 02:09:28 +0800
Message-ID: <33932dbf0460e0c4eb658513774ef84de9ef98af.1747070450.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070450.git.anand.jain@oracle.com>
References: <cover.1747070450.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0094.apcprd03.prod.outlook.com
 (2603:1096:4:7c::22) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS4PPFC7C4B0ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e62dadb-f131-4e8e-0ddb-08dd91805a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P6z4iw1TBTVNAIWqBovjmvELBu7nEdw7oBQVzpHJcctXebnU2p4ri7SAxTdG?=
 =?us-ascii?Q?qBgGu3zzSnH4JUpk5SBoK/n2LfXGWaYmXPvA+wXkaxvlb5wR1lU8TL2v0r/Y?=
 =?us-ascii?Q?AGHa7wGPg5Ukx9+44d+784TXtgJgNAsXXngcNpLvkqvq4qgCqDskCfF0PgHW?=
 =?us-ascii?Q?lX7lK54I71qpIX5kW+2KnognSPLyuFST1qTDIv5aiIbT+yKckps3ClWQPcRT?=
 =?us-ascii?Q?fhBx17E0xD0qsaW3ARkXkwRI3oN0UVOWqZqmiYJgeJy5JTNd1PpPYM15999I?=
 =?us-ascii?Q?hZsDolEbPlyfnM4zneItAu8xGSSVqHSTX74Wct3fTxhV3vfLDwHwXvzHtpTN?=
 =?us-ascii?Q?ani9CPOuqQx3BzZSR6ynCw1z1GQhNj8xIIn6QohrSfH1YuWJDbtClNiMouHy?=
 =?us-ascii?Q?+cJpE4VMttTMfgwADrgG3syQxu9s5QIQsGnBuLbr02rVBf1yYTpjPMGFZxRs?=
 =?us-ascii?Q?immSfvrMfBCt4ACMlidjpQ6ewCHPBOGpAOLY3E06fK/j4iZBRe5HZDq8QLfH?=
 =?us-ascii?Q?NEFT6oIkJjuYns+qoC7cj7aBc+V0M+ohiaqwiEWGqcKpp5h9ecjy8OMyq0ZX?=
 =?us-ascii?Q?P9P3wWI6EowHEeDeYjNd72/RaAPsjrZNCqglySjMe3LWAzSkSXfv0U0uC4Jq?=
 =?us-ascii?Q?y6RwYaE5bq2faPx4+64t+yTJ7w/sFv/hTz4q2oxWMYU9B4+s7Wpc3YVRJxKt?=
 =?us-ascii?Q?EDPr4PKWnKNuZJ1uAEP7jYmBnvShK0aT3Sd42eq6IJCp4GE4Pl92jvyhlgrm?=
 =?us-ascii?Q?pMBs8K1v7mE2f8AxjHoA0KPKPW7b69y585Y7QkZsWOQ2aYALsEKz/cXU8uSp?=
 =?us-ascii?Q?Ib4FR2+6UWJ0ACsBjWxyTb0ugploC2FvFkuhg11UVvmX55A6CkJf+L3XrIRX?=
 =?us-ascii?Q?9VqGvarqHYP9nb8iBCLHA++2oHVlIvuWJMpakNnDUes0XxkigDNQ8ONKefe/?=
 =?us-ascii?Q?S8EMpp+yAlA/rK6NsRJHjP+uZU8+5H9HrUWOpzKaffM9czPf6DZ5DY61Kbe9?=
 =?us-ascii?Q?gVFlsWaOzITvKKN6E3irAUwHmFveWP6GrFTnsBL6nw9q9SsM1uejetvCJ3jU?=
 =?us-ascii?Q?0HWtZsAcGDx+IA5kpdccsFK2AbL04xvq/q4858tJBooLiP+SfPg4GGfeu4rh?=
 =?us-ascii?Q?tZ2/5pBEsWN5ryY9iVtLY8xIfxRp6k/vs+DM/KQlaF/MvA5182l2AfhS110+?=
 =?us-ascii?Q?dOTPEYzM2R0XgARh7uAol8jVvoqqrPlEg5eOYUGa99pQ8yHWMZjfKypDj7KL?=
 =?us-ascii?Q?JPJHIeaXPwq2uFVxpbQshfldatZHCRXSOyytxB5/sKI5Z6XpGuIycNHUfZst?=
 =?us-ascii?Q?7O88iTVboR8qORVen/pH8BeHZonVo6Pgp2IxYlPmRrVz6j5lG/BxlmAEeWe0?=
 =?us-ascii?Q?I/5VOunuWIwnn/nr0Tagt2BTb/Xb5BX4trZer1TtVvHRUN2WwWDI5PgMmsmK?=
 =?us-ascii?Q?nzj6iYf7m+0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IsR0Hn/+fp++IRnbgNmeXcZd+MDglDN2AZRxK5RKAvAv48E6SWssW6dXDgcm?=
 =?us-ascii?Q?BXgOE0yoU/h6eT75zHV5If3m09BvnKV3pNX8nuwxZQqgDXt2n7yj0iBW1vfK?=
 =?us-ascii?Q?w2UwM7wfE2eZBQkfMChefxb/oBAEq5iiDwRfbP7Nbl3MGFRu3O2nUSZLem5x?=
 =?us-ascii?Q?qOzm4u0klGaZqjOuo36L1FQcmKxuPokSs9Ck4ULzWDP6DbLA19pJxT2UHW15?=
 =?us-ascii?Q?imS9r/p+dKVrux+MywC2Y0LFFUhpo3DADEE4TILQ0EQQZ3aO98T7ouVUhYAE?=
 =?us-ascii?Q?KY9vDgJ8pGfLzKqcffyA+lfSiYhptOzo18DFDmYCPGhl4K2bCFa+uFffbZf9?=
 =?us-ascii?Q?wqo6FFb5jW8eAEeOdE9fZtNF2g951vBLHI2ivDfWaNHM2mFPMI2ZoG2vUknx?=
 =?us-ascii?Q?P1TTjTT+Ftl+BzNl9WNAv6ldIBwfRH9h5al6Uln2ZAt4l3NjcIRfSTsATchZ?=
 =?us-ascii?Q?aLZMPZ2mLQUr998PVmqfIPhZgZlFINTWS6zif/iP/mYa/9VGCmwrfjAuuBpR?=
 =?us-ascii?Q?GfepPBiAk2HYUqRXouOy9QH69aplHwX+F5XosFEUKrfxcC+cUh/zzhF+Qn4p?=
 =?us-ascii?Q?QKLXJNDrr6Fce2t++CjnZr7GNiAK3+LMUjXNR3qr3hUUQ0ZD4rQaw5CV4FCY?=
 =?us-ascii?Q?MGmXWtwCJmWIdSBRvw1ItK4NMAfy2DOMnE/NixETLxYWiqTzvlmblXjN+4gV?=
 =?us-ascii?Q?PN+s4fypbxmryGk4nm9rtjkOJO5DtqjQWxZDWjsK01Z5dwgbZO8gR6sbXasZ?=
 =?us-ascii?Q?mncOMb17KM9PctCSbPsBk3aRDD29V+UnEWq0VCBgtBBc9S3f0hAUQFyxzJM/?=
 =?us-ascii?Q?SXXrSkNuo6PWkN+eClRcWQDf1h1d4Q4OG/iarQ519+T2XursdSLOldrEk/PA?=
 =?us-ascii?Q?2m7Vp4nr9ZB8itkqNgJNUzkxFLLk2tqqVoihTx38C8QbGAw/W7qjKDGW7rWf?=
 =?us-ascii?Q?enplQphCjs2FOz3mtK3ep6Ve8RqMnyr/hBvXa0C6DZAiHacTKGUtyDTuSbKJ?=
 =?us-ascii?Q?VMQ37QEdvm6WMrbcurJ4bKLRU6hLQWpYevWWmSQb4zgjQ7XPRMhgBaZWF1MX?=
 =?us-ascii?Q?UrOrXAc4Ubv1CRFrTBAvnYvKt7JH8CEdWRidLLsu+FvTGwNL0YlQQ14rhtAh?=
 =?us-ascii?Q?lbbQ5DhUZV43MicLMxmatP4ppIXf5eplgrJFSkddLLv5R0q3O2bQGioJNLuq?=
 =?us-ascii?Q?UG/qKDMv4jAOcGujFYOK34LXKPwfK6Cf09EIB5vBF2QMmu4V220hOfAfPkkD?=
 =?us-ascii?Q?/FvyjLdSZB9VF4+fAiPmLdBbOFCSrhlar6eNcKuEc8wePvyGBvIQNOj35Qyp?=
 =?us-ascii?Q?fem8H88JwUlx3W7rdMAvaujo44OAPLlzB0JilTGBb+FoYA5Grlmjt3UvBioy?=
 =?us-ascii?Q?6IlfKPCGsGAjuvsG7AIW/mQPhDi0sbBXN7V5sRFbm53V513ikjwb4tR08Elr?=
 =?us-ascii?Q?dVZuuTuU1xgVyvDp4jhou1bhEYhdpOgqpNJAF6N5LDszW9pLMfYo3eUBspAM?=
 =?us-ascii?Q?/vLCM3kcdiR+p9FCmeYmZ6tTUgjyXNx3Cjl4ssQ8dgMgLygjY++YoNOKAr3z?=
 =?us-ascii?Q?+CovTecCRafs2m3JzzeG3+B6ttxrK4AuWInXgx8I?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xHVPVpcrkUMS8kMGL3te+PjWN8uq/egjS6JKsJxeJt6GxDDskF4hd2j22fAy/aXyzpV0AVv+u0uJBiHQnXy43049UwhHApRN5WPuon9CSfrCFTMIFMuz4dU3wgHDYQglrvfSnMwdbth6mBwYPCUb9DuS/vrefK9IF/YDZ9idquAUswLtUPF3AX0HGy3uJ7578po8cSnywHAvIlUikW0fCv+W/0TQyK/EJjZe3qRxprt5RGSzv7nNXHaPKzwAM3a3cRh8+ne7JtGFr2VmkHcp/3iW+90zIM6tIlZOtWOikyVn7bO1GK9iE4GCvcHaFRpPzCBoo/p/AA5nW/DXGkMRy3EQCtzMiDczBoKYQeZlznGHf2uxnWy1vxeO0y3CAimwDNNxCKAm1fx4pBmBQRaPP73df+5JvQijtdOqXVq/hTk3UjaQPTo4KkQhv9u1/pQqefnwS/120UuR82VpMlABPw6kiu3NXy+aUV4KvyceG37k6TkRlzFodGNPXtYBXSmgqBDZ6yLFUvMkZWKvI/xeV9B1ZmWEYIs1c0Y0p49tCQux0afy9ob7oOWeldRNkGjIq/W6HwvuWgsGWvDumJiLYVCOBp7x+P+WN0zL+OT71ak=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e62dadb-f131-4e8e-0ddb-08dd91805a85
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:11:01.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ldwyv+srXt61pK7hVY4987fFmDx3uh9oKvlQZp3OA69pPa9ipyR409dYWw6aTe+8ZoGHzclyTfPs2GDg/cNMyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFC7C4B0ED5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505120187
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfXy+wrFhKiMEGL ubHG8tD/6ag7056zpQjOTi1T/PajrEMymX7kb2sYaJrfXT3F1pZYnFfx6eY3ZD2GojRBHavbXWe gj3CvDkLh4tTVanLtQvVsBQ4EeMAt6jGH0it8ClPIzUBitgViKW/yCRpflsIqWP8a7dGuA9JPOA
 tq1u7DoBV8i0oTGTOM1hvLThzLUrny+u/oB5q+7Yr3h7cFEOU+VOg5CLsHNrT4PC1rMUKWjP0Ap /Hw/wuIgaorPHFpnoKjlX1rrz4yCaOhf1zfXQqjreFtINtKZ9sl/ktuPH+TYvbDYFHYi70uwcwf /77eP/3OpB++RMiJYDFU56ya/m4yncTV0KF2m+v4nnJnHOSZvSqxw1rqAXfgWhD10H4HyCV+Joo
 pzGkFmurGmcHwtyv3lLd/UywlbMz1RC0K4O1EUfWI1ms4m0BPCy/qTVaq4bp6geVtPLmDpU7
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=682239b8 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Q-pHZf2PI9YbNzmze4MA:9 cc=ntf awl=host:13186
X-Proofpoint-ORIG-GUID: y3sy47QOBxEFDLl21BQlWxj0eFRnCKCD
X-Proofpoint-GUID: y3sy47QOBxEFDLl21BQlWxj0eFRnCKCD

The device role information, is encoded within the lower 4 bits of the
dev_item::type field, this commit adds helper functions for reading and
writing these bits.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 mkfs/main.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index 2101e63c80e6..8248d8c4a287 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1047,6 +1047,44 @@ static struct device_arg *parse_device_arg(const char *path,
 	return device;
 }
 
+static inline u8 device_role(struct btrfs_device *device)
+{
+	u64 type = le64_to_cpu(device->type);
+
+	/*
+	 * The on-disk value `0` for `dev_item::type:8` maps to
+	 * `BTRFS_DEVICE_ROLE_NONE` in memory, which is defined as `80`.
+	 */
+	if ((type & BTRFS_DEVICE_ROLE_MASK) == 0)
+		return BTRFS_DEVICE_ROLE_NONE;
+	else
+		return (u8)(type & BTRFS_DEVICE_ROLE_MASK);
+}
+
+static inline int set_device_role(struct btrfs_device *device, u8 value)
+{
+	u64 type;
+
+	if (value > BTRFS_DEVICE_ROLE_MAX)
+		return -EINVAL;
+
+	type = le64_to_cpu(device->type);
+
+	/*
+	 * If roles aren't being set, we keep the on-disk value as zero so that
+	 * ondisk format remains compatible with the older kernels.
+	 */
+	if (value == BTRFS_DEVICE_ROLE_NONE)
+		value = 0;
+
+	type = (type & ~BTRFS_DEVICE_ROLE_MASK) | \
+		(value & BTRFS_DEVICE_ROLE_MASK);
+
+	device->type = cpu_to_le64(type);
+
+	return 0;
+}
+
 static int btrfs_device_update_role(struct btrfs_fs_info *fs_info,
 				    struct list_head *devices)
 {
-- 
2.49.0



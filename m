Return-Path: <linux-btrfs+bounces-9692-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 654EB9CE423
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 15:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 205A52865E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Nov 2024 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D60A1D435C;
	Fri, 15 Nov 2024 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="M6I14GID";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IL7vdODO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0488B1D434F
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Nov 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682497; cv=fail; b=R6AlhAUXyv5wDOnm/d2FEfcHqj9V2/wOCe57Fz5qkqUHX+xxFSr8vEB14Nt2sz9XMPeKQSoM4tG0Mkt+GEpzl35rPaLjQbeqPS8U1pHsV8FTNkmL2tNMDSfDzz5utkkA8VaLzQXizCPZe5VqTt/1l3zX3XAjHK4JTo4i4tPPBII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682497; c=relaxed/simple;
	bh=Lw2iDC7XXh+onZIOQTBiup5+qAibmxX7SsKdBBnhVzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cr/uiwApX5Tkr7o7I+WbJhZ2MNA0kJIIk3P1+B0c5t8DHoBQebgTMVTHQEvWuCfTstxjq/pCWpU7vpNlEUazXs5KYYT3e2Ojk6tFEvASaYI5k8aFMHJurpzyy61ubUhukkwoQBCbYoJsha7Kr51Kd7I5D3cPIPqbd+n8ggusdRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=M6I14GID; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IL7vdODO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFDCSq2020915;
	Fri, 15 Nov 2024 14:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=kXAh4z31vZlSM7vhXotBhdwi6/2Uix44w+DRpnRqKko=; b=
	M6I14GIDujgVUunQQ6W4N2vE69FCF2HO9zhpifsKRMPUZKHqea1XPNrjuFA6z2oE
	gVlT0gJL1LSRcquSnNdwNKCnZo8GJuCOmbWCBhzjdArkVdXaWG5w/ttoZPB54UWp
	GYIs4lRgR1XCFOyqu7cbEBWgHmFpt2JAN8Gj7ja/i9C05ozf0Xj1mHYLZns8jQNm
	nTvxxnq7gE0hKWy1ePIxLNBfLRHkFMXtQ6FFouvBoUpeyEPXplXuyUVOKGHAv34C
	lQ8KdNeJUXO7VZEzHZfL22CVpYo7WGfixEECVhf3Q24jWSBjrkWBL9o80YV2slym
	81Rcwi0ETM6WQVu/7/OtDw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc3mut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:54:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFEeTPh025914;
	Fri, 15 Nov 2024 14:54:45 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6ca3ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 14:54:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nj/4rTRND5RNRYIwzpc4ES1fiUgfz3hRcTqHgOFke11gDojIUcSxfGerEo4nO2dXlLi3tbrFk5CqXF15atbX2wRmOCfYKibpGclq47UEZIETxSFAyYTPcV1btgRY+JoT0+U1LXaWGLMYi1nAKf9YtzmEN11U+HOCrD7ukOKa+oQEKKLwJZAendEeB3ItwAX18B5QSwIIAHP8gH5tG1CVFY9SeemxPT2QQifG+6dy+8/TTzizW7coXmye+dFUO+Z8Wg/afpwIB4bJYw/OBwfRY5fKk5tmSY8nJcukEsNu/GkbhskZj8GrMAMe1acTisJLYLvJ4BGPz79tncp+xGtg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXAh4z31vZlSM7vhXotBhdwi6/2Uix44w+DRpnRqKko=;
 b=hEyypI5pENovrw2t+STEpwUB2zYh/6m1nLyGP5G9gsichygXL/Ejv5MPXisMuupb39ZU9ScT/Xi0rhbvltOwewuSGDygAMbHpWZSbymMVDisVDit+DhJeEMybgWIWnxBKQ8uaV+5HQ87/MZ/d1Yial+U/ScNWUiWnasfb1tGJrQvjRNUOzUis6vB2OMEjuC6R7ouYhdNwi0+F3hZXQSoLEyHqRQsjSRPo7QMvUS7O5AlBJpsNu1fTkJiOnZYOTaVwwwFC3pjkS0tpZPq+1QUtL44n0ZR5m+gocSqb2IfT3jOSHpAnt/a2xDfTVv4uQUB+7t7Jlg4fXaL3VKnRGrGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXAh4z31vZlSM7vhXotBhdwi6/2Uix44w+DRpnRqKko=;
 b=IL7vdODObj72bW4/aX/X/LtV/2Xa/CS+rsXIkwVEaBlw+Wn/uu+IXrvD5TS+5RsJEUrekzP8OOZQFtgMgyvAjU2p93PbnBuCsDTIcCzD5rf+DTlO8YcKz0eyjoKEASVtu+Vo0ZixodABQB4xfDxz3zF2yydSWrVOhZRHMplOFb0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA0PR10MB6913.namprd10.prod.outlook.com (2603:10b6:208:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 14:54:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%4]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:54:41 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v3 01/10] btrfs: initialize fs_devices->fs_info earlier
Date: Fri, 15 Nov 2024 22:54:01 +0800
Message-ID: <fff18098a26689521eaa3de3e6ff6be3dcc27d55.1731076425.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1731076425.git.anand.jain@oracle.com>
References: <cover.1731076425.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::22)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA0PR10MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: d43279d6-5be0-44ed-4642-08dd05856f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yQORdRL4h82v07Jodbi0KNzsdDPtVdoITVPyBdh9pjm5jJ93FS2XKteHgTWR?=
 =?us-ascii?Q?aoYbQcdRZpScF4f4KWoAioyT0eP4Jjqb2O9z4Pr/E4aQbpgCElAXf9MnPoay?=
 =?us-ascii?Q?UQGfm3lL5G34jExGDsam7RxDajXDRC12cnm+jcfv13aJaGwj1sRQGZYv1tn5?=
 =?us-ascii?Q?rb/V1AYhvIp+DCJ+Hf6uWcq1FislZ6vhQ6va7GQKX8QFsoKklFpROpnWnMIC?=
 =?us-ascii?Q?jkrx1WS8lVnWhvD/u/oPtKB2CuBogab6VuNprOfZREkBX7F68iDmFwY1OOwo?=
 =?us-ascii?Q?LPOMk+cH86HH1DqlWgxNKTGlPefdgPltPGtEK/S4x4nfCnPvNLrfwX1Es+ot?=
 =?us-ascii?Q?9Wb6bFYqyLKTFjo/GDQNSYJvGTKoA//K5l2Lmn2Oq39g3NTwS4FtwedPRJ7/?=
 =?us-ascii?Q?3/WILB/nQFDCay16sB8zBqkEXv0kZaZ0I2htnaeTxNpjuLvM502vuulHQgwd?=
 =?us-ascii?Q?TGpwIMjcpOQcOKpnSkGK7nBvkgSnvthXaB+rYsFSLmMPYSdJcJgF3lCU0oDP?=
 =?us-ascii?Q?tiplxDKTyhefNBrZurMqu6i7mMl54rKZ/CKY6sWIGrn8DP2BGN8vb5MJMW2Y?=
 =?us-ascii?Q?FK9+kyKfCD920FuI8LnXo1OzL/aWV0DmYHRlWB4EVS8nRBUL7Oovg5hvyleI?=
 =?us-ascii?Q?yxV8aYL4jTtum3ezzP+8D4cKeyi4Y2DlGruGplkyiEilJsJiuCKm7avRECiz?=
 =?us-ascii?Q?ttWekqcE8s4QvHPctKbzsGHU6aEYgl/d9JSWYuSEbBmtYK7Sfj479HLWzUmk?=
 =?us-ascii?Q?INhFX6jRWWy17dFOevVxfzElb5q07uHxcrUnKgU4e4/uKAI8Z29Anfe7wry1?=
 =?us-ascii?Q?TEm05OJRJN5HOIZ0NT8ynmnNvssYw0acAC1vG7hAQpYrkBpZAChE6W/+Zab/?=
 =?us-ascii?Q?R9sl1ynzFCnMcfakezdNXtYJnoqicWrmpPBOG1n6NxSFbfW5e9IE+YG2RsmJ?=
 =?us-ascii?Q?Anx7rK7M+0NavxvSN1lSx46ig+51XTBx3Gsz6C8maEFSdxnkI2SDJwkHaOhz?=
 =?us-ascii?Q?SzIF7xOV6e5B7fuBHGaubdzzVTyaVjrqOPKuRGH1L3nJvyizYy+RlC8LY0I0?=
 =?us-ascii?Q?/dkSe9Frut7X2mme/3PjfQcz0miV8fPw604lzxqIp2I9Sq9VVoNQbjCwkBF3?=
 =?us-ascii?Q?akYq6ke5RQXya4RjpuMP29xmE9xElMUnHUAU82aCGzxesyjakkDycd5bVabH?=
 =?us-ascii?Q?/JDUpDDSAI9anXuiUW5y7WJ/jNy1kOiqvyosN1LqmMwrOdjBofh0lxxxIesu?=
 =?us-ascii?Q?hYdARQYM3CecN1ZKGtyGAvHx+afhnQYjaxvLPoANWMXgML2er7bnvqLnH9Ek?=
 =?us-ascii?Q?Vv8Lnn7Z46qwU94t8vnlH43c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZxqIcoS3CzWyvEawjVhW2bc1JCHVQtWiXU8Ry4Ns9rNlYdRKbZstuyXVXe2H?=
 =?us-ascii?Q?gM+XPZXMyI5eyrIfpabE31iZLDv6A6Fo/iE5i+YMSCHiW2D0a+DPH3ofcdLJ?=
 =?us-ascii?Q?Yl/IZRd5c2Yns9LobJWHov6Vr+ibH4cWFcmoclnwx/HBxpRsgikZXzYpQohM?=
 =?us-ascii?Q?W3mBREt86ySfb9ksCSFiFAot9ai7APrsSxJawulmx7tN5swjDLIOFG8Lr3Ol?=
 =?us-ascii?Q?Sn5RvSa/enroAIbyUfD93ZUiRU8LnFlW9XZVX3/4cmTvp7wP47qeD0CtXbZd?=
 =?us-ascii?Q?2a6efabXLrHO9cFp1IfMoHO3v+Gz1KWmo18knMZkoCW+EnrPVfVcmiNibbdf?=
 =?us-ascii?Q?FQFHfNfYWpmiivdXorjEoBSFbukVkV4MMw1JjWehm5sUB7RhGTFMDBgRNC7u?=
 =?us-ascii?Q?NzVp2N5k/rLFWqIRvuVYMqq+Tk2M4ybIrBjzLqNI52NnbNEoZ81rm/x/LEPj?=
 =?us-ascii?Q?H/G75JXqlZ2eTq5hAveL52T0THmK/xmnaM+V4WgFhDnsh4jRxDoZYQdB4MpK?=
 =?us-ascii?Q?jkYLT9EsK6Xg+2FVzASm2P0QS0i5KYT3r5nC+/MT+3j6ngMi2n/zsNOPh2MW?=
 =?us-ascii?Q?XQavxY8kB04XW+2xB0NT43oE9yovy088KCfY9gbNnKm13MDZ4T5T4SAplppI?=
 =?us-ascii?Q?nbBaG8/MsQkrEX4is8jCJ58//MshKjspRqBNgxs/zzojXxgAIgiIf5SEFW/I?=
 =?us-ascii?Q?mmoDE96bTsN/aN5Yzoze1BW/tbMNP7kOM4bUmHXwnkcuq6i07POirmoYRM2Y?=
 =?us-ascii?Q?58Jn+XvEyVRPpa4c8v51QZGw+/+myrZGkNZu3ut+OItXxc+r+Lf0Cdn9Tcwe?=
 =?us-ascii?Q?o1dhH1Q4QrSrdtPQgLUmDmRR7WtRnJdD2fApGWfLI2fMw2qbszpWoWPo0Nuh?=
 =?us-ascii?Q?ydMltpqqwZ42ActGIeWWDUAL/8qrQVtgS5nv4OFUUA9frnWPkBdVa9riEf8d?=
 =?us-ascii?Q?rlqtcNqUsg4oQAPX+LEY/Evut1rcpDySXhocP9wB1UaM5rn+hsQJyQ9ENr4v?=
 =?us-ascii?Q?cr4RP2iyjCtAP5mySFPrP1yV6EJcfjd4kynzNa+tdzksu8Asa4X6hrov2Tv5?=
 =?us-ascii?Q?PrbnTjzXY245jjpQEn9+1mG+sQzsYqhjtdR80t5e7DndClhTDt8MHwhqHv3/?=
 =?us-ascii?Q?NBfyxQOSrkQ07s0KtCjfK9VXz745Tn9exsKdG1/glU0T9FsxtcxCEkkuCZ2Q?=
 =?us-ascii?Q?JMPE4pyD8AsDZF2m9PSD/NmNy8+ApmMHmN5tiBeCdN+PKSbvDhJ9CT3A0vCN?=
 =?us-ascii?Q?tBdp+vHennLEktXwJR8BPvTqKgm+ltMib2d8r9YW8pvt50rTAkOtQKb9prFl?=
 =?us-ascii?Q?VWFPD16Ea7ii9GunFylSaxmA0mFruq5q+/t8ADf4LUK/Po5JW2keh7lYW5lH?=
 =?us-ascii?Q?gXTjYyDW3rL5dxFxnIe53BiEa6QPEzUa2G0bRV8ZNllSEg8C5ZAxlxPcHLto?=
 =?us-ascii?Q?StyNhs7emqgNsR9GMEIjQIGDJrbdbRBOord6ftnjvjIQxGOJV1a7TSsT6WCD?=
 =?us-ascii?Q?sjb0IXeEc5j9+qBGXdzSuKrukjtXud9/EfyNgO9vdtslDak1i2K2HbcNwoX7?=
 =?us-ascii?Q?8ux/VVDCnXU5jBUf36ncBSWdbJrj8UfT+6GsjujM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g2BoJQ1CHnuL322JiKehg+ezvHMpKVmLz913VSxAZWcKHBuTKo12vIy7iDCrpneG2H8xx2+byHagt/c+1GpYlMlXStLVW43c5oaXTTQZww/aGHSZurB1UT9YIrjC8lksNaGjrlwu20h04ZvrFZVvfZtGJ0jHEW/WUXukdaicKr5tMUTYubhlk5imlXp20DMstjpKhZvAMeau5d11aVo4r8obRKhYqem7s8n0Xxbc1ODvkckYNFqPne3heBKg1hX69FbKAjyTOiGb4/vHwEU0zWFB+tdHHCMS10T56ORFWTatlBZNE4djNw3XK6xWJgCgOg3V3bUZcpQs8UcAj2BnKSBAObd+Au6kZKrPV8Htnp7y5CdVHc7YSdIOprS13tdOsspjmupw1UgJF6oCu1f/aXGbSbAs1q5ln1B3iwOTZM4+YSFyTFst7km86JK4XMg6VZRL8PmYp9leP3C+/E5o44l6q7hpHp4Kv5WLHT5jDxUWJ6KSRVtbozd1T75UXeHTzBiJmbhP41jb+ppOSpg6yofhO5V39kAkttzlOz3Rq4FY7lVbTaKKfyK67l4hBrccMGiyAKeEXOBNj2TWeE/DhfWLN0ISkDjHsMJ4IwsrOZM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43279d6-5be0-44ed-4642-08dd05856f7b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:54:41.8392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUQ5kPDgvMB5zj5XFzHdxFjHcAjpLmAMIcqrjEOxWOV8Wf6SBjimttzRFSKPuZ8+MM2rzMEIdXJrlEIcR4RjZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150127
X-Proofpoint-GUID: a9Z8aZbqBYbluGDuww95R2dJgnGh32tN
X-Proofpoint-ORIG-GUID: a9Z8aZbqBYbluGDuww95R2dJgnGh32tN

Currently, fs_devices->fs_info is initialized in btrfs_init_devices_late(),
but this occurs too late for find_live_mirror(), which is invoked by
load_super_root() much earlier than btrfs_init_devices_late().

Fix this by moving the initialization to open_ctree(), before load_super_root().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 1 +
 fs/btrfs/volumes.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 814320948645..ab45b02df957 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3321,6 +3321,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->sectors_per_page = (PAGE_SIZE >> fs_info->sectorsize_bits);
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
+	fs_info->fs_devices->fs_info = fs_info;
 
 	/*
 	 * Handle the space caching options appropriately now that we have the
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1cccaf9c2b0d..fe5ceea2ba0b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7568,8 +7568,6 @@ int btrfs_init_devices_late(struct btrfs_fs_info *fs_info)
 	struct btrfs_device *device;
 	int ret = 0;
 
-	fs_devices->fs_info = fs_info;
-
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_devices->devices, dev_list)
 		device->fs_info = fs_info;
-- 
2.46.1



Return-Path: <linux-btrfs+bounces-8287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B979881FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 11:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A372D282639
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C801BB69C;
	Fri, 27 Sep 2024 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TrY+WmDw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LVwuSdP+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DFB1BA886
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430964; cv=fail; b=KN1tsC7UUio98F8Bk4b7HsV2Nxx8ryUAsDJWD/PRUSjOX6YScTtH7mkhxiuy44d/e3ckRot/nFb8mbYofdrY0c0MGXjV0LOIMc+sMEFqHkZrBK+3HS7OLhKgP/5oc/ynuEhRibrCSewuhpEO6D8ktg7POAiZdwIgTPcFyO9evtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430964; c=relaxed/simple;
	bh=92xKHMDt6WPvJNqzSsVj9NxTydf5iCoGYqJytJJSjbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L24YFll1TXjYsxVjRE30T617ygcS1DndtMDcleEO3dWqlmdE9iztWZm9UeV4R3iVxpcoWkhxRMZ79NgWsS6xehEb0+d9wzcAF3p/CuF1BFggNKC4TwpBzpkwb1xGips0xPlWEQUrpjFsLnPUI5v4vsRIvRWGySudLjru3PUwavI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TrY+WmDw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LVwuSdP+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R5gdMn020797;
	Fri, 27 Sep 2024 09:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=VTJbyif4LS3g8SnNRgyssGWkd4St3/wt/cbZVkt008A=; b=
	TrY+WmDwI3YC35QgiAUWPuBs32+admEdpgAQ+BfqFmtl+aBMgx7hQWa6qZOQyayJ
	15m7QNXb2OjWUbRPsFW9MWlQ1gSZglEB57xr8U4Q9e9bVcy1Mwd4liqV7hMv2Avh
	EsXG+1z125FzSIdkwUIe96kPEaDkkHyf7UkxuehCSMmjtQnyA2iu/T0F+pRtMLjh
	XGe4pvMryBJXYCyOtUGmPZYvDHdXDYYMukpuXBpnNYCNTY0eiuFTPraeC3m5kaHI
	rtI4pvs57s3f4myCj/FJ6/qFshhj5Qi6F1vvKjUw2cKwfQiVPBrvaL1NZcJCHvSM
	rMUJ0AHaWtavXtGSCAAnkw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sppuf980-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 09:55:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48R7U8Qx026125;
	Fri, 27 Sep 2024 09:55:54 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smkd8vdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 09:55:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8//0y79oFYpYfMfC9RyS5LPHrbk6OCrlBriKT3y27xsPZ9NgAcxmVPY/4p+cg8ZqmbfCwFG/kyvRq2r4JZCzFObmQ3LLdw6JsqOvBZi2T0zPowNTVun7Z+hMGsuTOfrlJhUr29J0bUC8leO6QngIG6+ro5W2jwvKoiNMoYNL19SiYdb1GC7x5ZrtHKfTN5xeQp0ohW/zl64q/cMxzTJX7VxTFQjpV+cNsQ7GgETJlMAnxXtXQ8x3h5KwpMe+gRGM5+tBS4KhifqsEKfkPs8+czOrURs26BQ/UU7JAkNihlsN9kK8g0jiX3X6AUeYxSAI+GbHY5mXiv0PyDjqcQNLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTJbyif4LS3g8SnNRgyssGWkd4St3/wt/cbZVkt008A=;
 b=XryluxlU6rNY0u7D4RV99YuxcClVM+13bBFN0J+v1pndRB1oaf7kYMN2+GdSBQKoRX8px9Oc1w4KNSyCOifzPIyvxTxe9QSDs8z1xmV/jIaZH+ldYOQ7FpAe2uY5T6ZGismhNl/9CmNFyQXqtna1l5+3zP2oPfPwSH1e4V4J4AIq7LjclzOaVhoZxgNpB4IeKUkMygiEYL7BcBRt3sr8hxpXB56Sc2XQ87VoHZ6zp0dztnfdHDqizIIHMWzExZsJ3y8MEpcUKOgicYo2gG6f7uFVRcoptws0HAN+URDEvzywgaOnq7eQ6XPqsE37Dr6WF6fc0kjemg5bIai0PIaAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTJbyif4LS3g8SnNRgyssGWkd4St3/wt/cbZVkt008A=;
 b=LVwuSdP+8hWuSF2nlMGErMuqWXp5FKlfP2NfKc2VemFSmMT0/+BZPGB8B3Fch4m9bHC5qfh/eUFEq5ShUi5Cql2i07H/H+SfzAw37jYdK7vfkMtdHb8BjbjuIdDa2ofF78qrY0530FKxqdLSet+6mTnvoHQcorAF+YulfQuFhVY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6735.namprd10.prod.outlook.com (2603:10b6:208:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Fri, 27 Sep
 2024 09:55:52 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8005.010; Fri, 27 Sep 2024
 09:55:52 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, waxhead@dirtcellar.net
Subject: [PATCH 1/3] btrfs: introduce RAID1 round-robin read balancing
Date: Fri, 27 Sep 2024 17:55:20 +0800
Message-ID: <63676f15fe9b1ca6c10eb9021829b4666db6d021.1727368214.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727368214.git.anand.jain@oracle.com>
References: <cover.1727368214.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::28) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8c6c6c-0748-4d1b-48cc-08dcdeda924c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?edS2krot5JkMkmpWuGECZqhNBKK57RoWGSctEU8Syn0v1gaS7FA1dZoIkbe6?=
 =?us-ascii?Q?Ut6F+2Q6+USPqQz2YrLF11WkHdpdSibqnSBiX/dh3aWXATZidBWgN1dxSecu?=
 =?us-ascii?Q?LXDtKFc49WUVO0srq2XZaKze9rDAVmn2Jl3IfkMXB1fgr3GnJNseDgHufJm5?=
 =?us-ascii?Q?D8ffUnIKmZwsNhXRgzoMRgfQVa/VxzBMwlDYQPQQn7qjeZbrhzMBF0ZVsZHt?=
 =?us-ascii?Q?++zXzjL5zD3aDVvDI1XwblAJTPg9zHhDHt4s3ltVAxGF46Um2Y0yACg3713h?=
 =?us-ascii?Q?tE+vXgyKvXZS+er/jCb2jVX86pRBUUVMjwF0FhjUVmE0vE7W/HT8di9lGBMr?=
 =?us-ascii?Q?mUWgwexGc7edxkmgXgjANigWCXObHCglCLF3eAd8FrrxCWJ611A5JHGdX6oW?=
 =?us-ascii?Q?EPp4fzejMOB283FQCiA2qgsIZt/jTs0xggs33qKVwZErgEXCPEOVqYZ2xwkG?=
 =?us-ascii?Q?s3Hike0cR+N2wDt/653IBvl23ZD2AtjcFIPgxKQJd4UuMcgsQauMNNpXxIu2?=
 =?us-ascii?Q?EQLA54jRdsT9cU3CJ7mdyjFaDDMg0+3agg4jcp82Qat6A3XxKx+CtaOagOQw?=
 =?us-ascii?Q?MLxpCa75+J1SdiM4ATV3u5idpmmIZxhmVtxWBZ0Mjx8dF0UL/cYTSanK5P7p?=
 =?us-ascii?Q?H0io0bbB7jziwhxdlgxq8cCtGJSxLpQbuMLXYwHshVJjrrbBdAJT72Tb2j6n?=
 =?us-ascii?Q?FGCnfUhdF09vr0K9Rz+XL5LSG+hIAzT0flAlB65U9ete1bNrEbIXamW6OVt3?=
 =?us-ascii?Q?kA1EWBBOQu8wgY6vjOwDztE0+bD6XdjDkL1Z1nRudFMBrhdfRJxzLaU5/vfR?=
 =?us-ascii?Q?ftC984LXthgTu1uXjgxNamPfZAEccvPouw3ycdgogUCkw+9/RCpCveO/DdGE?=
 =?us-ascii?Q?zSQtYVaOaGm9wrFv8Ek+JQTT3spJ5TSBL8kIVqkgbWByZMN67FSaoXHVTqND?=
 =?us-ascii?Q?mwCDyCnqGwYaniTpN0Y61b5WwsYNUaku/sBb3LnIvPBGUiKeInKTdA1hVLBT?=
 =?us-ascii?Q?f69eXGhSLVAI8ceMc2RmTmwRXyIjCEoGivWIBQUAtUNAY9BVoMA2WbgfiP//?=
 =?us-ascii?Q?JLftotMFizEY2WKRiqGdBgmOPpnK2Lxuu+fqcH6YaKayk73SI/MZ3U3+y95h?=
 =?us-ascii?Q?qvRU+Lr2Qsdcob09qgRlk33bGpyGpKwGuOe3D2Iwa++IQtNtQG9Eab3TjNBt?=
 =?us-ascii?Q?jm9PEOlSmfEcFjhrK2Q9teF2jZLP9OVHVRxbuYMO7FwcymZ0lp3EvcCzFgWN?=
 =?us-ascii?Q?vAC4+9rbznEhOoNe5zIyC5W8vwxTXHePELb0IACI4qxOgNSppTOGnhX77HAT?=
 =?us-ascii?Q?8Rl39APe97TaN0hovb3JPhARTfbVhixgnEmr2+FGGiZiXQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e/LMpGIOy9BGqwu1SkaHsWyNrE6zhwleW53fQJy2A3V854Oc43htxxDEGSkh?=
 =?us-ascii?Q?R5r2tcBMQfWQ2ZJ2v8HJXpIa94alJh7mnvBFZNt+rETsybUHOtB6On29JDFz?=
 =?us-ascii?Q?XV5AJD4gJtDJFBagHd8bL38SRmCVB2jSnicOb3wAuq6zo02JnTWI71gpcdt5?=
 =?us-ascii?Q?h7zIoVrBCr7hfheaOtWVsXRUUeVWlNtE8RDdQPSzVPrZGWTXoYfcv0ArvXTz?=
 =?us-ascii?Q?3//m5xxzmHzhhPVRLOf8nlz4hk96I3bnvq0qkjqfe2v0Zp/g8udQjCRpaHmS?=
 =?us-ascii?Q?KSKhYQeK4XLoUfZNMlRvNzsVqpu1ZD0o79sk9lUgmWKTwKbvKyH25pcTV4A0?=
 =?us-ascii?Q?xZKz6Bmc3IpYd3mOquEuvuCP9BlCmFeVriCB4oXF02LQcB12RNjBKcy5pTVH?=
 =?us-ascii?Q?CFfKWIX1wPS4H8204CI8LaTrz07mjtrjBRKeCCcvcnfy6b4qwtKYSx0Eno7r?=
 =?us-ascii?Q?nXYD9/b5fb8YGOwsV4ynOOmbE9wHracyg3WWuwKFkbhWrmRx0mrlXqFHRExg?=
 =?us-ascii?Q?EmmtUEp/eYAbVNm8Suu4gwUcAGLEFtHW6uEjgpZDKoK9OsIi4QFxBc5H/vYf?=
 =?us-ascii?Q?Voi8iWs/uRVRDreIr6RPu9CneNQ0npRqbHyApJpxoI6GtbE76M9P17ZFQcWB?=
 =?us-ascii?Q?02yYYKnymJyUZEBmhkdnmMy1Dr6IF4zv6ScHj6LaczG7Nrwy64dFMbzQeEGC?=
 =?us-ascii?Q?c2GVlivYxrTbQji7oiSmYSK6Izonn2zZqliIv11sDbov7qwP+266bgQOp6yI?=
 =?us-ascii?Q?B1hLKLXxF/Us9wEqufZYV7zxMSmYqJ7WCtk30vqkWN84v3oUxWY9REF+5XHU?=
 =?us-ascii?Q?F2a4/J5f8qp/TNrm+Z9dRxTDFnVn+odGZwmD+SOPHmFzCPlM0zWt0psomMrh?=
 =?us-ascii?Q?QEY3K1bFGx2z9oVNtowWJkVWWTxaJEaHDi/BifmCSfdIJT4eF+P51L9uO2Qh?=
 =?us-ascii?Q?cS0M4LbC+GeZsgb5BZi9+EELMFUTCydHmCxeAodKElu2cQqUO6hllGY6aag6?=
 =?us-ascii?Q?oZBwnYexCnre749yceZZ9Hy/iZq1RBPkPg+wjSz0f54lWWopM2cELc7tD1YZ?=
 =?us-ascii?Q?AvjZeBwinsxTsp8FiTpxnT77d+8t+qoyyqyupYvcqQbjh1tj3QaWn1Ytzi2f?=
 =?us-ascii?Q?gJySf4ns8dVQUsMEsEV4zHZowYPMNtP5JzxM8f0m/DkAVKChdEc68/J1Jvbu?=
 =?us-ascii?Q?GewuOQLFe/p1eKz0aCAHB73Y04JBNIDQCW0TJGBdjSf6SAGeKlIFewCOBNvV?=
 =?us-ascii?Q?TCUzLUzLA4p0dxeAIF2AJ3jcVvoQh3s5DOZJVzKN5/g/trz7NdQQK+6GDPi2?=
 =?us-ascii?Q?5t7LajNnB+kkK9CzTu2hUj9WnqRlppCHl/VQ4KUd/enK+hGYVyGKGU8aRKMC?=
 =?us-ascii?Q?Z423dOoXZOB8JxyHzEvZK/4H3sSI26OPZIRMJHfauIyIx2WjqCCKCRU/sItr?=
 =?us-ascii?Q?KmulQZYvkNuW/1T/Tbr0yH6vnYKdin7T3ZXDJFrCy5bDtNHsVRWIz9iYgclH?=
 =?us-ascii?Q?nDzFis6Y+xgyegJGSrAydYd/cFZvdFogbA+zLiJZ0rcosTF/0DofCcNt8l96?=
 =?us-ascii?Q?bUoV5w+QHInv5QRQYIELl3mQOvRhz9Cg+UhVhwoJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WaoBuJusYsMN78bZmNJwF3KKF0JJIaNzCnPtzaWkGfvHfGJbQpD6AukUyjQoGs7eyPFwDtg27g/OH4oaDZpaCj0XDzt7dFViyBveiMCV19Yn/QCMJWmQQ06umEzdDxlnoTSEp8k9X/NPV33oicdeeeQmY1ob/OlvV3pjYx4LzebXorB6E87cyFRYcmSNgpv7k0pSdZPXDRAFH1Ogab3yKn2HiLmDCWn2hg/KEAe0mZqVWnlmNNrBq1fQM70c2rHoscalN5So7TxuNZB77jILYlwIiriGaZBq1ywvkIUbWPQNu8Y9nFbEosdIGXOI/21mrtY9FdGq8HuIDCF7oynueDa4R1icQaBM/r+XWW+pVTAq56F+Oj8T2sAUAFaIRW06VUm2Nf++070LetGeuiUDSbpyrZ2FGXqufitv03SaM77idHhAg4zt/DiuStOvniye3/cpPT6fE6PRjKF4Al6K/1Lfs/Q86NguPUPvlHHJHtNYJXuXvkc3xOBBW/zMH45l4qHmwEAWQJyWsKf+dIKwDBpneVf0b6qmELqfcwrUUNHb8M0zuGf/PZ8mNX0N7TC/Mu3OCGOrXLFE0RY20JzZwBBHCox1EgVTK6XMGBBKkJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8c6c6c-0748-4d1b-48cc-08dcdeda924c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 09:55:52.1845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqnMHMr84JBzVNJWyGHT8dZBdRrmelYHyQMWND1z3rT9BEMM8AzLgVWhuTG4wBYQa5o7IPNH+neHQD8ggtJWwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_04,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409270069
X-Proofpoint-GUID: We-7LOwJzhVDWenPEJ-suDk42G-7HTaI
X-Proofpoint-ORIG-GUID: We-7LOwJzhVDWenPEJ-suDk42G-7HTaI

This feature balances I/O across the striped devices when reading from
RAID1 blocks.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c   |  4 ++++
 fs/btrfs/volumes.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  7 ++++++
 3 files changed, 64 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 03926ad467c9..18fb35a887c6 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1305,7 +1305,11 @@ static ssize_t btrfs_temp_fsid_show(struct kobject *kobj,
 }
 BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
+#ifdef CONFIG_BTRFS_DEBUG
+static const char * const btrfs_read_policy_name[] = { "pid", "rotation" };
+#else
 static const char * const btrfs_read_policy_name[] = { "pid" };
+#endif
 
 static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 995b0647f538..c130a27386a7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5859,6 +5859,54 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 	return ret;
 }
 
+#ifdef CONFIG_BTRFS_DEBUG
+struct stripe_mirror {
+	u64 devid;
+	int map;
+};
+
+static int btrfs_cmp_devid(const void *a, const void *b)
+{
+	struct stripe_mirror *s1 = (struct stripe_mirror *)a;
+	struct stripe_mirror *s2 = (struct stripe_mirror *)b;
+
+	if (s1->devid < s2->devid)
+		return -1;
+	if (s1->devid > s2->devid)
+		return 1;
+	return 0;
+}
+
+static int btrfs_read_rotation(struct btrfs_chunk_map *map, int first,
+			       int num_stripe)
+{
+	struct stripe_mirror stripes[4] = {0}; //4: for testing, works for now.
+	struct btrfs_fs_devices *fs_devices;
+	u64 devid;
+	int index, j, cnt;
+	int next_stripe;
+
+	index = 0;
+	for (j = first; j < first + num_stripe; j++) {
+		devid = map->stripes[j].dev->devid;
+
+		stripes[index].devid = devid;
+		stripes[index].map = j;
+
+		index++;
+	}
+
+	sort(stripes, num_stripe, sizeof(struct stripe_mirror),
+	     btrfs_cmp_devid, NULL);
+
+	fs_devices = map->stripes[first].dev->fs_devices;
+	cnt = atomic_inc_return(&fs_devices->total_reads);
+	next_stripe = stripes[cnt % num_stripe].map;
+
+	return next_stripe;
+}
+#endif
+
 static int find_live_mirror(struct btrfs_fs_info *fs_info,
 			    struct btrfs_chunk_map *map, int first,
 			    int dev_replace_is_ongoing)
@@ -5888,6 +5936,11 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	case BTRFS_READ_POLICY_PID:
 		preferred_mirror = first + (current->pid % num_stripes);
 		break;
+#ifdef CONFIG_BTRFS_DEBUG
+	case BTRFS_READ_POLICY_ROTATION:
+		preferred_mirror = btrfs_read_rotation(map, first, num_stripes);
+		break;
+#endif
 	}
 
 	if (dev_replace_is_ongoing &&
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 4481575dd70f..81701217dbb9 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -303,6 +303,10 @@ enum btrfs_chunk_allocation_policy {
 enum btrfs_read_policy {
 	/* Use process PID to choose the stripe */
 	BTRFS_READ_POLICY_PID,
+#ifdef CONFIG_BTRFS_DEBUG
+	/* Balancing raid1 reads across all striped devices */
+	BTRFS_READ_POLICY_ROTATION,
+#endif
 	BTRFS_NR_READ_POLICY,
 };
 
@@ -431,6 +435,9 @@ struct btrfs_fs_devices {
 	enum btrfs_read_policy read_policy;
 
 #ifdef CONFIG_BTRFS_DEBUG
+	/* read counter for the filesystem */ 
+	atomic_t total_reads;
+
 	/* Checksum mode - offload it or do it synchronously. */
 	enum btrfs_offload_csum_mode offload_csum_mode;
 #endif
-- 
2.46.0



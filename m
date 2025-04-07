Return-Path: <linux-btrfs+bounces-12827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1595DA7D2AA
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 05:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAD9170F7D
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 03:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4133D221F01;
	Mon,  7 Apr 2025 03:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MU5sTILs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h4X6sDJf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23B6364BA;
	Mon,  7 Apr 2025 03:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743997782; cv=fail; b=qlNZdTX72KxHox9nsNd6qN7OvBN4n5pGOooQP1HPlsb32eDitJNPlcE4UyB9Jw5Zi0CeBj05Vrbq5Jc1Zc1BvXHlvFNutUkh3tsAGyPeqFEzpRc3MwdSoCz9LX13R9+4N77FKeMZhs/aNn/3q4g7HePNR8i24ALneCbnSVycZI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743997782; c=relaxed/simple;
	bh=Si5erAOZAojv9tBQ7JSvDpYwri8kYx6lSfVp7VJW/e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a6VRJFX1Q9z0X26FTfvbAnOEbxWtghTeH/EYNsxejI1Crl0FQIauAxYCQY+STeDSIQWEggzFB8KFga36m9+X1lm31HdkDPEj1rG83YBAwoHw5QGFtBYAw8ub7O506rN/8MbJG1G1WQ0rlrH2+/IJuLkGJJ3/PXqc+oCa7wzktZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MU5sTILs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h4X6sDJf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5371C9a3024669;
	Mon, 7 Apr 2025 03:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XGm+E6/nm3LfwaKWP+Uzuu3dASEZBiYLOFwffVohPo8=; b=
	MU5sTILsWoXUJbsulunAjomXuJd8++djZ+4pb+ejmy4E0exTI5Wj/XHJzVcqtze0
	y9equVYBugLX/3ceZtxuEitwSwZdHJtWqGkyb7CjBQu0f69e4HYVQBzNrDs7dej7
	BDxwRwDmhHZrlbA81OPyg6FYORotONIYN+ffUQjSINWN+67x7knbZW3Usm+j00KZ
	BRQuh7I4t0rvqgPRnUt0Smf1LOAicHTbr4ybbE4N1VwHhk7DCA5SO31NNea6YbFN
	pplAhL4Nm73Phq1YezQ8LxQEeoGy019erP+CbRP9YBPcD1T+t4ahNyDAGdHT6Bve
	rIMzmEwKVNV1NHtIJEQIYg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tv4sspfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 03:49:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53732HkH013776;
	Mon, 7 Apr 2025 03:49:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttydf0m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 03:49:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6uUPi6HlsQj71lWMWwJHs28OpACtfL40FYOANq4+FjBUtr0j7oqNd3dLnNgAPERwkQJ4aomaye4kBCmAhU9GqUREv6M98ZdaYMgG2//BccRG4gBMDIt5ck7kPSB60JAjssNr/tm7/MD1zwa8WA4XoWxUiXf5hvbCPMQeiaovioKa7kkaN+oiq32s3Ci9931FJNygfMdDqXK1TbogafHPtpcdXI3iyju7fzpqBDv3P0uTXL1nhHRSqxm7Mc6GbIgWpsv5TAQPqwAB3Vi/xbZUUyjiH+q2SOYWyeFUj0p4RvNQ5A5aqgNUNK6FS7wa0olRc8VYRGiLUV18wQQBlXraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGm+E6/nm3LfwaKWP+Uzuu3dASEZBiYLOFwffVohPo8=;
 b=s77FPv5VpmVXeey1zh64+mxVEiha2XG7IKRakt7OFbZQ7qq8ziwXIhSIBH1ySW4b7l+N0NtRJATtjeZOr2hrI3ymZUITu+sQf8KUXivxvaNtbq5eVONzUfzzhrFONolGOulLeuDkDSPFMWEv956qraNsgbqY9V+DweV7agM35lO6s/LF/23ZAJAYkOohpSgxQrbmCWkpNU2BH2KipYqY7SuGCq1adtbnXqweTLlsA23TvO+l1P9TEqqsEsmIHZX0BONwIw6snrQZVtNjdmbklXKdbRQHqoBxgCmhegEReGubHGl7qBflaZzmyPO+dI+BsjhD/V3e2MYBce1NwyEfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGm+E6/nm3LfwaKWP+Uzuu3dASEZBiYLOFwffVohPo8=;
 b=h4X6sDJfo8p3sCK2rkBpXD9xHtJN+qqfhFk9txBMH55OWUG+ZHoNrJE0JzRF9VMiK2StgPm7NJfqoNujbhroOv8b4wRaG88YO1yBZqekodfNlxVZPN3D4RBL2GlRoTPeu2YWRBzldNYI49KboRZWcPbJtHhBq+7vR9F01kFsSRo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7131.namprd10.prod.outlook.com (2603:10b6:8:e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 03:49:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Mon, 7 Apr 2025
 03:49:35 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: [PATCH v5 4/6] fstests: common/sysfs: add new file sysfs and helpers
Date: Mon,  7 Apr 2025 11:48:18 +0800
Message-ID: <ae857de1a41a1b2946c6ca83165308a13c043bba.1743996408.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1743996408.git.anand.jain@oracle.com>
References: <cover.1743996408.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0145.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::25) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bcb85b8-5900-4624-4daf-08dd7587369b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vWxxMHgqZaiBr/6+/dOArZZsmdsFacnVHuyOo5B/qFT2xDKa2dL72fjuDfgM?=
 =?us-ascii?Q?OlOuAWftnu3hheMM5muGXOH1eZccM7hBrf7i35mQP/3Uzp3madQNSe3qcaER?=
 =?us-ascii?Q?dFJlRa1kpZ15U6GVPvde6ZUKWPE5f9duzH7warcX1pYkjVWfuG0g0R0oRAEc?=
 =?us-ascii?Q?d2l1ODkBOulCpLACuCE59ywu7lXGDFe7KLWo3A2c8itqmNiJp4oieSs5ANVh?=
 =?us-ascii?Q?4Bv4MXZZcJ3PzViroipIHdIrb3AcXapqRnxvy1sUIBQP/9tJubfZOf8LbBNj?=
 =?us-ascii?Q?DpFqFBp6xg7HplzY2n7sP9rEISMIAE/Wnnp9EnGRxHbTk6ZTcJrxh/9O0Xoi?=
 =?us-ascii?Q?t5mrgL6pBeFiP4XOt/IPc0drshgBaox5+v7MPH3uweseRuI/8lbuzAWQSpe6?=
 =?us-ascii?Q?5S50CTuNx+9PaCjBCrESA4ef+Vx7Tr+LYfj6f32a732BhV+bHADJdklfL7RK?=
 =?us-ascii?Q?blcC0bcBm4aMy/BQy/eOWb/NSI2ckeBlrauTqcaXsFRWZRVTQOmMYbVMQzzY?=
 =?us-ascii?Q?prdA8H7j8WibhcsK+3UmYBOH08vBwrwMUSnWAK2OcTVMrVaQ0hd2ce0CI6Ba?=
 =?us-ascii?Q?MTirp+NheBwvrxl1ePjEUDuOsgQpBluA25AQOn43uQQihr06lk69Boc1XSHT?=
 =?us-ascii?Q?MdckFeXzn3alIkLuNQHnAxevA7uHoCpJHJ6X7H4onOUbY3/B7zoIRcfJth6X?=
 =?us-ascii?Q?IFStiGdVEIwbmyMto1S5JO+VtMpQCE11vtIWe+sGD3ht4yOpBai6998fvHfh?=
 =?us-ascii?Q?cXrGVH+LJ5dAcHOKyrIBq1+jMrKgQTZgr4qf4MC5Ej5FOWL0W+PerHom1S7i?=
 =?us-ascii?Q?eim2P1v0yDR7qLNV1/sEwohjQ1bt6ZvA6CutEd71Tau3ThNEU9oYPUcUV1gm?=
 =?us-ascii?Q?WbkZIHw2+acElzwM69HZR4mnUjtHKzEEEw75I1D6x2FnG8V6WmHpu6g9lwde?=
 =?us-ascii?Q?auFnkJ9h/k8Z0/GB1cniwGVIMzocEu452VKUcs+/EWZln8mWWycnTPIY4t7b?=
 =?us-ascii?Q?RaOpLPdoN/cPGFEYZ1S7IKxbHpEzx0DR7dLrWdH/nn+CAfSGJBiQfRl7dhc1?=
 =?us-ascii?Q?h9vM8Pk78YviO65CPHrjztcbliqf9E44CLNJ+/geNqz14n6THam6mjyXQZ05?=
 =?us-ascii?Q?TdzqM69U64+EtoutjuLzfSXN62Xqzj9qXTmcdBLRxNmdI8aPgPWyJX+OwRI6?=
 =?us-ascii?Q?yhD32Jxu/T7ediqX/ldk+EWFCVtFGCP0yERzwKh4w7QSKFBWMbUGjDmzEgNM?=
 =?us-ascii?Q?gksn9qvdIBtV5fH1qUY5S8J6uBLw54VHisLK/IBCMG/qpDrv3vOSv77xqzvC?=
 =?us-ascii?Q?zLoVZAyvfWLPV5bfNJkX+mB1Xd0AaeNS+kw47hqMvrTJY69D7albtsA3R8p1?=
 =?us-ascii?Q?TzA+SL4iw5NpVKAmVGq0/uq2GsFA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I90G9TuCHvY2vNxBbCyxXIkjFAdSxgxZ5IA55n09o2zfP2I+HoRMf2efQSMg?=
 =?us-ascii?Q?BuX9YnfaLRYxTwDPotvtnV3qHCJnXheezqRAqRtyo1F7W3EgZTe870hyRlb0?=
 =?us-ascii?Q?f7SF6VWFIF2WhMpikF1eEaZHnWY4PpDASgZP8i17blo1hg8Xt0eXMBBhgyXy?=
 =?us-ascii?Q?wgvWOhZKQLPQDsRWx9N36cW1R0zux70SpbqHJXbss+nr08xS5iWZr4PSXD8f?=
 =?us-ascii?Q?hIRhfr61/OOcHusTS/clCseAFwtpvPjHx7N2jHSqpslcpZlTY1QaHsZbDWjg?=
 =?us-ascii?Q?Cr/F8xToLs6LMrqa4I42pbGNjcIO5pHTWl+/6YciCK87fPryYaVUHRl0+uS8?=
 =?us-ascii?Q?vpmEqvRvFJ5vllFp91gZB/BvK4JibRvFVgw6Enjmd/UWdzV0CqEUEILdo8u3?=
 =?us-ascii?Q?CiNUTzgQxCRtWZSJPljz5gmR5PBvPv0itogKF4c1IinWciOxf+9WWUANc9N4?=
 =?us-ascii?Q?M0MACOCJ2i4v8GJsd2hh2s/oCS53YncvAa1C4pBPmqvkGyYkh0FxPceTve07?=
 =?us-ascii?Q?PNTabi0w31QXetrwlsMuaYT9NgtrWY1+hNVpjMC2hR/+EMbEPVc5SBZlYovN?=
 =?us-ascii?Q?mLVtsTmZFgzZVV2SHd84A0coazShktKFulwwQOOb3j95EnoUE0js+Tx4SoKM?=
 =?us-ascii?Q?SmOrq/SeR0+eO4ka2FUi87syXuwes21wDEo38ramO5Wp+0qIwCiOdPKxJ0q7?=
 =?us-ascii?Q?LWTNq1kP88DUUzkNib0cv048PQhbI0vQaQb/bGhU9XhH7Vbj3btq8wrq7CWE?=
 =?us-ascii?Q?Idg1rqGJUyn2EuUJneJQGaUIOssDh1yllmG8G9yr0nEfJ5kEn9if+7AgEGhi?=
 =?us-ascii?Q?TdH6ZDh5lxk1ri0eJz3oL1IyaTlfVx7DC6zsJcG1NnYNjV7QJYpHIlpMIZEO?=
 =?us-ascii?Q?hJAhJE9HghPw26dzAo5SaxbJzIOxxslWI9t5QdlLJcicUBqyhyQnWOYAS0/Y?=
 =?us-ascii?Q?6Q3xnkiBkLxvCwnIdEOXFOBz+TQGZVhtnYJHueSLKb9j7txsUc60glwWX7up?=
 =?us-ascii?Q?qY64cYzWvjIzsIJkcPyLZ/8nrf1cOy09B89Bj9ayFSSpUxDTwWc1YkTkbBqv?=
 =?us-ascii?Q?QSUi7tcyBhCNMpEwQdcjVwPSGn/o+VzLCZf4vBwjL4YSIPLn15abfvQY98pK?=
 =?us-ascii?Q?J5lfo9wxeV/f84Cblk+yvCnnlt0zkibxuSPqrZWuyOeV2LoJ0+Mwqd154AAl?=
 =?us-ascii?Q?sO3k34B5U0PKmA8CBuM3iptyctXCFYtsJo5wCOJEC/y8SPG/43KY2aHSNYV3?=
 =?us-ascii?Q?i6r09t7eEoOHclZxxU8pfqKet4bIFFMZFJE0iRKZuUW0URsH3qMPpcFbBl5k?=
 =?us-ascii?Q?7n+8wvFsAAh4TQfVoFkf6Gamia31dDXMIKTBRcFDFBzbzkPDEtsGNjig7FKb?=
 =?us-ascii?Q?5IqsRS3VTOsjuL2XhpqwrN3rcomqe2kO+LOn7E1r7AsDiDcMcP9ovEGdNTst?=
 =?us-ascii?Q?wyNk4M0Eq+jLvtLIounSv+0HWgEeUUDCePEm9OASy41AeTfAs3BCWLXSWhhP?=
 =?us-ascii?Q?yXO7WZft/v1UGLU6i1uUAigd8dHxFkYdQZkrTxWb3wAb1SmVppUD+FcqSqcY?=
 =?us-ascii?Q?vreYw47Y0U2nabzhDaivrFZ8NYSoNYHHf7dA6gK1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5cEKEQXrvG5tq/VtY1SWwOCCqstUyIvGLHrW50/2dFdMEHfdL3ppYFHnbbt/hwKhaaSS5Dtsl2DdPZrGX5wzFEK96YCvobChB1lUgtVm2QslAC6mCqHTGvyeMk9yUc3cvyMrj2gl/ohDCcW2Q/eHMPC3HWB0Epg+KxzqX1bDdyKvLBv02zXrJYAepcqJWUv2cFELuH6frXPu84YRzqYNj8008UzwLMbc3J2Q9+Ofe9enXAdKJX3NKRXwt9uGRFioVqXVG8CI14FKsUTwwIHb9gKkDDIfMWKdhicwV7pIMWiGt9UTxk5Pyo/5UW/OSSvSa6niGXsDDCEYO9At/pzR+PTAiEwCA4Mvt42qGw4oOMUuWRiAnVl7m+3W953IgK3Lqyqf8wtfDHXS/yfmYpZjjx9aCRZ2htIYH7jDD6FF7dtYvrdBkNBZ4zAey4x/oeJPyodR4WEIsj7vOxvGxIrCJ8KwmGeIB6ydNzAiEkpOuAQ6fS5LEWtq7GOH4jsSlIlDY1AC83TRSZ/8v1kQqyBUcxt54u+b0Aavjt+rjWrR/sY58B2cyB6V/X++C2Xuw900LJ+llXmDP8O6rzxelVEf8QYBberWAcL6u0piB2Cna5A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bcb85b8-5900-4624-4daf-08dd7587369b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 03:49:35.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63MDUsEoyReEfX7u8gDZ3YMVGUqXfDz2jAlLoNYIs9uictbegnP6KGPw+QdR1Q69ZdHbtTIr0dgDv4Kqsr3qvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504070025
X-Proofpoint-ORIG-GUID: OCLMvAUFujgZvX79M1J04USE6DyS9XWh
X-Proofpoint-GUID: OCLMvAUFujgZvX79M1J04USE6DyS9XWh

Introduce `verify_sysfs_syntax()` and `_require_fs_sysfs_attr_policy()`
to verify whether a sysfs attribute rejects invalid input arguments
during writes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/sysfs | 141 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)
 create mode 100644 common/sysfs

diff --git a/common/sysfs b/common/sysfs
new file mode 100644
index 000000000000..9f2d77c6b1f5
--- /dev/null
+++ b/common/sysfs
@@ -0,0 +1,141 @@
+##/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2025 Oracle.  All Rights Reserved.
+#
+# Common/sysfs file for the sysfs related helper functions.
+
+# Test for the existence of a policy at /sys/fs/$FSTYP/$DEV/$ATTR
+#
+# All arguments are necessary, and in this order:
+#  - dev: device name, e.g. $SCRATCH_DEV
+#  - attr: path name under /sys/fs/$FSTYP/$dev
+#  - policy: policy within /sys/fs/$FSTYP/$dev
+#
+# Usage example:
+#   _has_fs_sysfs_attr_policy /dev/mapper/scratch-dev read_policy round-robin
+_has_fs_sysfs_attr_policy()
+{
+	local dev=$1
+	local attr=$2
+	local policy=$3
+
+	if [ ! -b "$dev" -o -z "$attr" -o -z "$policy" ]; then
+		_fail \
+	     "Usage: _has_fs_sysfs_attr_policy <mounted_device> <attr> <policy>"
+	fi
+
+	local dname=$(_fs_sysfs_dname $dev)
+	test -e /sys/fs/${FSTYP}/${dname}/${attr}
+
+	cat /sys/fs/${FSTYP}/${dname}/${attr} | grep -q ${policy}
+}
+
+# Require the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ATTR
+# and value in it contains $policy
+# All arguments are necessary, and in this order:
+#  - dev: device name, e.g. $SCRATCH_DEV
+#  - attr: path name under /sys/fs/$FSTYP/$dev
+#  - policy: mentioned in /sys/fs/$FSTYP/$dev/$attr
+#
+# Usage example:
+#   _require_fs_sysfs_attr_policy /dev/mapper/scratch-dev read_policy round-robin
+_require_fs_sysfs_attr_policy()
+{
+	_has_fs_sysfs_attr_policy "$@" && return
+
+	local dev=$1
+	local attr=$2
+	local policy=$3
+	local dname=$(_fs_sysfs_dname $dev)
+
+	_notrun "This test requires /sys/fs/${FSTYP}/${dname}/${attr} ${policy}"
+}
+
+_set_sysfs_policy()
+{
+	local dev=$1
+	local attr=$2
+	shift
+	shift
+	local policy=$@
+
+	_set_fs_sysfs_attr $dev $attr ${policy}
+
+	case "$FSTYP" in
+	btrfs)
+		_get_fs_sysfs_attr $dev $attr | grep -q "[${policy}]"
+		if [[ $? != 0 ]]; then
+			echo "Setting sysfs $attr $policy failed"
+		fi
+		;;
+	*)
+		_fail \
+"sysfs syntax verification for '${attr}' '${policy}' for '${FSTYP}' is not implemented"
+		;;
+	esac
+}
+
+_set_sysfs_policy_must_fail()
+{
+	local dev=$1
+	local attr=$2
+	shift
+	shift
+	local policy=$@
+
+	_set_fs_sysfs_attr $dev $attr ${policy} | _filter_sysfs_error \
+							   | tee -a $seqres.full
+}
+
+# Verify sysfs attribute rejects invalid input.
+# Usage syntax:
+#   _verify_sysfs_syntax <$dev> <$attr> <$policy> [$value]
+# Examples:
+#   _verify_sysfs_syntax $TEST_DEV read_policy pid
+#   _verify_sysfs_syntax $TEST_DEV read_policy round-robin 4k
+# Note:
+#  Process must call . ./common/filter
+_verify_sysfs_syntax()
+{
+	local dev=$1
+	local attr=$2
+	local policy=$3
+	local value=$4
+
+	# Do this in the test case so that we know its prerequisites.
+	# '_require_fs_sysfs_attr_policy $TEST_DEV $attr $policy'
+
+	# Test policy specified wrongly. Must fail.
+	_set_sysfs_policy_must_fail $dev $attr "'$policy $policy'"
+	_set_sysfs_policy_must_fail $dev $attr "'$policy t'"
+	_set_sysfs_policy_must_fail $dev $attr "' '"
+	_set_sysfs_policy_must_fail $dev $attr "'${policy} n'"
+	_set_sysfs_policy_must_fail $dev $attr "'n ${policy}'"
+	_set_sysfs_policy_must_fail $dev $attr "' ${policy}'"
+	_set_sysfs_policy_must_fail $dev $attr "' ${policy} '"
+	_set_sysfs_policy_must_fail $dev $attr "'${policy} '"
+	_set_sysfs_policy_must_fail $dev $attr _${policy}
+	_set_sysfs_policy_must_fail $dev $attr ${policy}_
+	_set_sysfs_policy_must_fail $dev $attr _${policy}_
+	_set_sysfs_policy_must_fail $dev $attr ${policy}:
+	# Test policy longer than 32 chars fails stable.
+	_set_sysfs_policy_must_fail $dev $attr 'jfdkkkkjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjffjfjfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
+
+	# Test policy specified correctly. Must pass.
+	_set_sysfs_policy $dev $attr $policy
+
+	# If the policy has no value return
+	if [[ -z $value ]]; then
+		return
+	fi
+
+	# Test value specified wrongly. Must fail.
+	_set_sysfs_policy_must_fail $dev $attr "'$policy: $value'"
+	_set_sysfs_policy_must_fail $dev $attr "'$policy:$value '"
+	_set_sysfs_policy_must_fail $dev $attr "'$policy:$value typo'"
+	_set_sysfs_policy_must_fail $dev $attr "'$policy:${value}typo'"
+	_set_sysfs_policy_must_fail $dev $attr "'$policy :$value'"
+
+	# Test policy and value all specified correctly. Must pass.
+	_set_sysfs_policy $dev $attr $policy:$value
+}
-- 
2.47.0



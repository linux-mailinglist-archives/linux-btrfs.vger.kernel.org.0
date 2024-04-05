Return-Path: <linux-btrfs+bounces-3950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA91899851
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 10:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43422B21C85
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Apr 2024 08:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216EE15F323;
	Fri,  5 Apr 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dyvYKP/P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fU/YKGja"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8623DB97;
	Fri,  5 Apr 2024 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712306736; cv=fail; b=EvWkZXD1zYOColl+caGSu/Ypj7gpzpjVbUVsrvbXSL15WDUS+2oosFX47hNZcbQw6hqRg9mRTt8Go6PPMr007nGLDnEoDUkyISUpTzsZjjhv28Fioakd8iuR5iUXOlE4qhcbF9aiE3d4tHpQQLZNyouXTaO6Acg/gpD9bOnwXpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712306736; c=relaxed/simple;
	bh=BvAm4mtMeK3JlGKUWOSDicIz5Ze8SlONeG/LGWXY6VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PuHzNYSIEJmFioad0lQ8aPNaOgBCcTcN0u/r2ZMGtWMXP/GAN87jmq3OTkeu/ZRVGXoBBOkUGWVnaR4p/jjmnKjqI1KzoJMW8JyTL+DooATbxXMK16LUcF/RRhFaQILydM3kFuEAKE1whbKoih71B5XQfR7Zpol7F9/wc6vMFMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dyvYKP/P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fU/YKGja; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4358Xxb0024038;
	Fri, 5 Apr 2024 08:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=ki5mrWuVU+IefQh1cwbk51ayOvkHRxXaLB7IDhmF19A=;
 b=dyvYKP/Pp/B2mMIyO1PpZ+9aWjxMoJ4owCIoxfRfqOj199QUbXE6fzCT3nkzYsqaodFA
 WwytJSWg46brqhxxHFsCpghjjsF3h92HDs86mlwa9KEz97NfaHaT2Kaq8fbozirgmF2e
 8Nn2Qc1IlLseWXgpQeSh86cXHCe4yFf8CDJYUOAcioLsNpAMEroTfJFvnZiQx2Z2Gc9B
 d54Ak0Jekjc54vMwRfxHyNBP/CEd28+xKoBIW9PqxsYwiwjEO9i8wRFhFozrHJpFRwIb
 d5q/kK5oSsknsgrbuHRhz48Ft1uqMCh5LpwH1xwbb0RXcp9x8B+ntxdzJEGejHgUNLtA tg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9f8pay09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 08:45:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43572REP009227;
	Fri, 5 Apr 2024 08:45:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emmu17r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 08:45:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2C6YSaCnQVRh7CmRcgDdRLlEuga79EO+JVEzNaMc75MSMvE1c8IWYH8UxphU2QtfaArwCK3P69AbhGvJY50ZLB9/0sz+WLH7DZ5rBNAo8syFqCLTG9mFS/ILez5WUe7iCa61Cz+c4+CLa+DyaiPj/cvxPiwsRUo4vHcwQjFvjM8Qt7AacrgcbIBYWWvXCK6zr2VCXkX5aBX5FlUiYpqRRqA3cAEwKvOvglHEXTTW0//SNPbwGUKBuTnQJc/InRl9zzyEtogAuOATCs7jS7culDL/qeFwCqokbOVHMQIhJZfRkCaQs6mVF3emcNkKcd49E3lqKqUwLw9l+TMeXJ/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki5mrWuVU+IefQh1cwbk51ayOvkHRxXaLB7IDhmF19A=;
 b=jh4pvIJHtcQty64DL6AcM/WplCovInGjwo3fvel8X7YPrYUK/D8bbLhfI8KPa20FUUs/kO7RhkgeG2VgMATvW4Auoatq9adk/nOr5q1DW7Ut20WB1K80Zi/z9pThhPQ/CFRxe7PNp2izgRbiTnpOw986OJZ13pTTLhyqKYDN59oY/VCttNdakyPY5lhRjiAldCi74h49+oLWC0KtPOwUdfJyJ7K+ZlDf++7EBeLm2U/ejD6jVwYe4bI92O0AqHlbRmABnJ/Mrb6Hlmm37C1YzbFtvPEfIjS5MYycjnckSvWyeyScUwG1zuowjlU8jvczpQ891mGERYmarlADN/9csA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki5mrWuVU+IefQh1cwbk51ayOvkHRxXaLB7IDhmF19A=;
 b=fU/YKGja/moHjQezhrOYfhNJjwkJKFEdWdc2U+Bl2tuUKyRHRogi+2LeqXvVL5wJm9lihjwudKxUhwwK602zrX71xyOMNmjXxDeyl2MqbimyVnF1sKF0/x+ztEx1G/GFP68E0Hx0tEXGacxgxh6l6ZAHAxmxrL6OTd6f2Ru9384=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7323.namprd10.prod.outlook.com (2603:10b6:8:ec::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Fri, 5 Apr 2024 08:45:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%7]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 08:45:23 +0000
From: Anand Jain <anand.jain@oracle.com>
To: zlang@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, josef@toxicpanda.com,
        dsterba@suse.cz
Subject: [PATCH 1/2] common/filter.btrfs: add a new _filter_snapshot
Date: Fri,  5 Apr 2024 16:45:02 +0800
Message-ID: <3d035b4355abc0cf9e95da134d89e3fbb58939d0.1712306454.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1712306454.git.anand.jain@oracle.com>
References: <cover.1712306454.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0194.apcprd04.prod.outlook.com
 (2603:1096:4:14::32) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7323:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3x6sqTVlANQHjRIwPFs8d78C7qQR+jIsOLjmQOBNq0/avLCMc9qpZRvfL7+x2DPOi5Kr8cyJ1FEsK5LTpMxsTQueyakaNHohL1paDCTb41eyZkpJTshoPAikR+gZ4CjW3/thZyYA7qXoCQajkvi07zMJsTP24RhygUs+vvKJn4/ZAjlp2yvRbB4yW5DnkuBJ6vith03h4nZX1nZQDKQYm+th2Isjk6InhUyZ8ANiDu6045PBGg1pNFA+Ja2fgA8JZijGnQ+KukBPny/4FSzP3w9bbXtz/Yxwcj1vWXkhPHd9OC7i3qLOQIQtyXy157pVNrhV9vXrAeF/VTSqW9k7IhpUNAHTWVAK+8EIZmkp2txqOw5vFM4wHGf8RRNEBSHwH6TkL86WrRguw8fI2FoHTm7ct8riMgPNnpYR+KKxNad9Y9U9bV9nrQ3u3jYels0dgX3LjRZ72nUsgnapaE+I/7mYEYJ38qVzb9lm/vH0Wk24W3B7WtNu+EXMwOtqK8QnvrGROF0GWi3fyJHESYDIJFv8dnHGxD9YQeZgTW+iekX+6IXGHBHr/7PxeDDK17zE/NBqrBCP4846YiZmr3CCXh0NLVeZlE9/q6rxtey263haPjFxua3S7jWtbeyRugg5lJgcd1zyQgobIO/IYqTIcKymm3OxyHxMN6ZewmN2Gcs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?f1YIt8obw5JgY4XqJu1tEX8FlSQDsQlS036l7tzKwOhlKrd9jrGGGsiqYYW8?=
 =?us-ascii?Q?AqEsKWb+7R2Wcc5AcUIbSrd8p1ayw3xazxpNnJoLZQxdslX16EiLOMiTlcpQ?=
 =?us-ascii?Q?LGxtSZk1HE4uhv86OfXoDuZ4/SMh8UpMReMZQ3NAwfCTn7P4oRmM7QNkiViu?=
 =?us-ascii?Q?4q3ozc9e4HYeh5BuVGeSHX8OvnopNdm9ISy2akfqSM5dskLFBVEdSqVMaXhC?=
 =?us-ascii?Q?vOVHDoVF+ZqOijjuMp8oFu+AwDf9/CHcFmsyjTr8lZwtiB6nOINoMAExPSFj?=
 =?us-ascii?Q?WDXUGKjvzRvNrAmmAPSzoSv5E6mfHvTLel5pspF8p1cVc8CWRW4bDV2JkVS2?=
 =?us-ascii?Q?DTqUAomcUrc9SuBgF/9wzcU+n3OsaTAiAUPMVgHNk5DGUKGq32QEmQb+gXiD?=
 =?us-ascii?Q?t+a82GWPXmnnFgwf/TFY0Ujzy4YJVJG5odKNedalp9V02evKXcLNLJNx3A3N?=
 =?us-ascii?Q?i9JL9sIr/6RXvDGjN7/AX/nA3Bq54p0l9BE/Ij1R9sqOzORIJEMtMweD+hRp?=
 =?us-ascii?Q?wrxjEcGGnw67oOyye1ron1SPoYB6vW4/eS+HPPswGUS+e3ED2mKuu7vPk7w6?=
 =?us-ascii?Q?5/kyr3YPtXg/EK4KmMH1Rdg5S46LL7Tcyh6PbxoJv9wPbZcrqLLlcnktgE8p?=
 =?us-ascii?Q?a7dIu+Gfn0fpt3lqZRmvZNKVZuD5b9Zp7BH+V3ESnDsFq2LI3W0AlohosaQJ?=
 =?us-ascii?Q?I62khwjwGAXb9OEqY9Mu2DJu+TLVfGpjLTGKUSLj7hhgnS4g3A2b1bPmfbIw?=
 =?us-ascii?Q?9ce4NvMDBnVPsZnbD30nI/vxueLsyi+4HVKSGPCg0OJ89s67lAZ3wuezedPf?=
 =?us-ascii?Q?a8iIn/j1nCXLXlsZNlEp94FyvZG7ivnDsM7HkVp5yR5YPdWgT+CmdkBYC2UA?=
 =?us-ascii?Q?5JJcB0Yisg1WgyUGrxi/0KE2tt38WSRNhxfqet9argfMVMyUGFIdL8WywBze?=
 =?us-ascii?Q?H/5cqRack3jnSELxh3Uq3A0LFpJMz3E1vVi4E+J/qLehku3tC1G34axdVaoG?=
 =?us-ascii?Q?BN8LfoAwqi9YA5dihJl+7P7yR3bB/N0fQI6pLrWYkiUKOrV19hhcnVpB7nw0?=
 =?us-ascii?Q?e/ZrMU7Y+6M/GYqClsh2+8o5cLAoqro4W5B578XGEiBFtKcc3s1ztj+E3aJd?=
 =?us-ascii?Q?Lm/dWCUPWAk8ZnuMZO2bcgBbrRUMZbeg4R3nAysQpZEl0IxxpMAyfBxfTSiK?=
 =?us-ascii?Q?RaIaBvcWLkrG4lFjvWm7FTycjG0AAgkkXthrhaDrAYhTDSNkAD+c4v7a9ySy?=
 =?us-ascii?Q?iIbv6y8q4pk/Xnnqtij0ClQhaIYxKg1AEkuYXKD5GdyOIXVF2q1yqVrP5s0a?=
 =?us-ascii?Q?lpBN+8owtt7iVZGQcnFE9swl4PQRZkZ+TAz2/puqXSEJYV7N7eG+VCaCP+Rk?=
 =?us-ascii?Q?u0UtGymBhw12JisnjRpG0uVK9SrlsMwya7rR0QeKtyXNhIfmuNx8nBliz4d5?=
 =?us-ascii?Q?32bNKu/hrugLGu5PqTReWLq/mygVvbk+xkfmhX5BMgEHGFCk/9jt746hBBvw?=
 =?us-ascii?Q?s6lSkUJLt4Zlbaz4q5DCc12uzdWk8IAHHdRcteRUwFVTKfVIrh1132ESXD9+?=
 =?us-ascii?Q?FqyOTXa714afCEP+ChMqVR+xOT/SFshCtufPF36ue4NU1jJsQcWWXX1xeBOw?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eKRqbyUiyj/P1iLClVNgFdvuzoa4pziVrsBwla2BlWc/1YjPmDlqKyI83etHEZNX4vzXElDDeDGnY0pmSx/WGo238WSoXVSdb5a9ipt9xAxxeZCaG9wVAG7OU5v17j3HgQf7LYCwYfveYXnBL6UW44mXlxg6OBK9QzK7WTsf5cp4orBPTqzdY4IsBtMqY6KAPXk5Z78CIkt3VklfVAEzq+A3ZQw5Af8xwstY3UCSBp9bdTyP5ERazotLMxBfkZVggFeSdwiVFJva2UwExTKDFfeihzhWqGt9J6fqsBl0qQLijrA4e2Y1Kautdnq36yfU+sWCEmYDv1+RtazlsuAmXPfr7ZHAzD0PsVHWqS1UgAADB9Bn9qokBDdiSUnPKgix64UUtxLw3TpVDYK3vpT0lKMewUl3cMNxvffNYwRRzgNg0IKbJtwJs6rC4EWEMP841DlYvoPQJz6yjKjrQV6QdS/J8pagL2kKuP9d8Koz9hKpHPC5wv8UJhBkLF1l+cJY2eSYBi/VMnIgVoG4E22I4HLneFTYn5/WA/+W9AfU8bGGnnkkw683f7VHTHLWDsu+QCIV+KICF8V6BauB7LoH1+a87Tb7hrr0cdx+ZiqXNLE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b073c4-cfae-4cf5-2624-08dc554cbb5d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 08:45:23.2698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHHyPKqNuG0tZ+Rd1hdg+Fv40dnRvPbIo8jFU+PWaY/zyQvWbGNsSEKOiZHq0uR3qNwGNq++p+03hLo0ueWhHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_08,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404050063
X-Proofpoint-GUID: vvknCSHVh9ceO3AkHlRunDJvnHyzWbU_
X-Proofpoint-ORIG-GUID: vvknCSHVh9ceO3AkHlRunDJvnHyzWbU_

As the newer btrfs-progs have changed the output of the command
"btrfs subvolume snapshot," which is part of the golden output,
create a helper filter to ensure the test cases pass on older
btrfs-progs.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/filter.btrfs | 9 +++++++++
 tests/btrfs/001     | 3 ++-
 tests/btrfs/152     | 6 +++---
 tests/btrfs/168     | 6 +++---
 tests/btrfs/202     | 4 ++--
 tests/btrfs/302     | 4 ++--
 6 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index 9ef9676175c9..415ed6dfd088 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -156,5 +156,14 @@ _filter_device_add()
 
 }
 
+_filter_snapshot()
+{
+	# btrfs-progs commit 5f87b467a9e7 ("btrfs-progs: subvolume: output the
+	# prompt line only when the ioctl succeeded") changed the output for
+	# btrfs subvolume snapshot, ensure that the latest fstests continue to
+	# work on older btrfs-progs without the above commit.
+	_filter_scratch | sed -e "s/Create a/Create/g"
+}
+
 # make sure this script returns success
 /bin/true
diff --git a/tests/btrfs/001 b/tests/btrfs/001
index 6c2639990373..cfcf2ade4590 100755
--- a/tests/btrfs/001
+++ b/tests/btrfs/001
@@ -26,7 +26,8 @@ dd if=/dev/zero of=$SCRATCH_MNT/foo bs=1M count=1 &> /dev/null
 echo "List root dir"
 ls $SCRATCH_MNT
 echo "Creating snapshot of root dir"
-$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap | \
+							_filter_snapshot
 echo "List root dir after snapshot"
 ls $SCRATCH_MNT
 echo "List snapshot dir"
diff --git a/tests/btrfs/152 b/tests/btrfs/152
index 75f576c3cfca..b89fe361e84e 100755
--- a/tests/btrfs/152
+++ b/tests/btrfs/152
@@ -11,7 +11,7 @@
 _begin_fstest auto quick metadata qgroup send
 
 # Import common functions.
-. ./common/filter
+. ./common/filter.btrfs
 
 # real QA test starts here
 _supported_fs btrfs
@@ -32,9 +32,9 @@ touch $SCRATCH_MNT/subvol{1,2}/foo
 
 # Create base snapshots and send them
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol1 \
-	$SCRATCH_MNT/subvol1/.snapshots/1 | _filter_scratch
+	$SCRATCH_MNT/subvol1/.snapshots/1 | _filter_snapshot
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol2 \
-	$SCRATCH_MNT/subvol2/.snapshots/1 | _filter_scratch
+	$SCRATCH_MNT/subvol2/.snapshots/1 | _filter_snapshot
 for recv in recv1_1 recv1_2 recv2_1 recv2_2; do
 	$BTRFS_UTIL_PROG send $SCRATCH_MNT/subvol1/.snapshots/1 2> /dev/null | \
 		$BTRFS_UTIL_PROG receive $SCRATCH_MNT/${recv} | _filter_scratch
diff --git a/tests/btrfs/168 b/tests/btrfs/168
index acc58b51ee39..78bc9b8f81bb 100755
--- a/tests/btrfs/168
+++ b/tests/btrfs/168
@@ -20,7 +20,7 @@ _cleanup()
 }
 
 # Import common functions.
-. ./common/filter
+. ./common/filter.btrfs
 
 # real QA test starts here
 _supported_fs btrfs
@@ -74,7 +74,7 @@ $BTRFS_UTIL_PROG property set $SCRATCH_MNT/sv1 ro false
 # Create a snapshot of the subvolume, to be used later as the parent snapshot
 # for an incremental send operation.
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 $SCRATCH_MNT/snap1 \
-	| _filter_scratch
+							| _filter_snapshot
 
 # First do a full send of this snapshot.
 $FSSUM_PROG -A -f -w $send_files_dir/snap1.fssum $SCRATCH_MNT/snap1
@@ -88,7 +88,7 @@ $XFS_IO_PROG -c "pwrite -S 0x19 4K 8K" $SCRATCH_MNT/sv1/baz >>$seqres.full
 # Create a second snapshot of the subvolume, to be used later as the send
 # snapshot of an incremental send operation.
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/sv1 $SCRATCH_MNT/snap2 \
-	| _filter_scratch
+							| _filter_snapshot
 
 # Temporarily turn the second snapshot to read-write mode and then open a file
 # descriptor on its foo file.
diff --git a/tests/btrfs/202 b/tests/btrfs/202
index 5f0429f18bf9..57ecbe47c0bb 100755
--- a/tests/btrfs/202
+++ b/tests/btrfs/202
@@ -8,7 +8,7 @@
 . ./common/preamble
 _begin_fstest auto quick subvol snapshot
 
-. ./common/filter
+. ./common/filter.btrfs
 
 _supported_fs btrfs
 _require_scratch
@@ -28,7 +28,7 @@ _scratch_mount
 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a | _filter_scratch
 $BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a/b | _filter_scratch
 $BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT/a $SCRATCH_MNT/c \
-	| _filter_scratch
+							| _filter_snapshot
 
 # Need the dummy entry created so that we get the invalid removal when we rmdir
 ls $SCRATCH_MNT/c/b
diff --git a/tests/btrfs/302 b/tests/btrfs/302
index f3e6044b5251..52d712ac50de 100755
--- a/tests/btrfs/302
+++ b/tests/btrfs/302
@@ -15,7 +15,7 @@
 . ./common/preamble
 _begin_fstest auto quick snapshot subvol
 
-. ./common/filter
+. ./common/filter.btrfs
 
 _supported_fs btrfs
 _require_scratch
@@ -46,7 +46,7 @@ $FSSUM_PROG -A -f -w $fssum_file $SCRATCH_MNT/subvol
 # Now create a snapshot of the subvolume and make it accessible from within the
 # subvolume.
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT/subvol \
-		 $SCRATCH_MNT/subvol/snap | _filter_scratch
+				 $SCRATCH_MNT/subvol/snap | _filter_snapshot
 
 # Now unmount and mount again the fs. We want to verify we are able to read all
 # metadata for the snapshot from disk (no IO failures, etc).
-- 
2.39.3



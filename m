Return-Path: <linux-btrfs+bounces-2887-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5C786BE7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 02:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2C41C223DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 01:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54115364C7;
	Thu, 29 Feb 2024 01:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X09au5j8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yuaOV3C8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE4F3612E;
	Thu, 29 Feb 2024 01:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171427; cv=fail; b=czz+HtWCm4+OXUz1424yxRiqISdY7V+URpVn8Xea8FdHecrtkJOXNZyGmc/73oUG4j8l0sGsJ1113n9IL607cKXs4kMBO6PN+RcFHv5+6GBaytaqOcGPa2mWltOLauYhRHCtagdqti/9mVhp41Ox1fHNHcjlu5l9SBir5FRwYSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171427; c=relaxed/simple;
	bh=WrMBRabfHse9Apy0zNbhVilDYiF2S22ebShInyAy3RY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e8+amEMp41hbRfOWn6KeSefM4MMgJGVj/wWsJGQZGugkcXKcnYHUaRTSFexEyJRWuogyDVRWwGGJBae9r9oN7YwOPL51hmWEzSuxVmhAs4/Rg+6keyxkuilpGeB4ZWKKzVUuie9aqYCXM9u2s9vV1nwnzv4JUt/52bfrFgPnFjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X09au5j8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yuaOV3C8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SKP8ZN013132;
	Thu, 29 Feb 2024 01:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=WihQSDuEsBnDc7umj5Y79RmxT53uB8WQ55Jw3m00RJw=;
 b=X09au5j8vunQzVDitphmhYqYLifpAkhoUXt12ZIUu6lPQhJTY+RMpq9l1I/PJOKhhV83
 5+vN/FmtvT+cKx8EJz0aiyoJiN7iTV1iU7rI4K0itGXsps0WRzP+f5Yfq6NsxPiYUQPP
 5EsdcGkfwpOM28bqOquZBnzdBsWiYlrD9y2bkb3bkxAD7bw7cUinIvEVILoALhk3r8O6
 0aX5qYApDYm13FqWKEmviXsGBBejbDkYJjLBnafGFRzlgyiVlXtaVe7ypr2yeKUbeTA4
 nDI5vO8IEGf1v5zfsMXL40FHzxu6rwTcgJmq5yptkZ93B7O3+zrZwsL3k4oDdbhB59r4 dw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf90vbx4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41T0UxOu015351;
	Thu, 29 Feb 2024 01:50:23 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w9yxfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 01:50:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjfKW0l4d2G/g3FiQw8Zce+DI7Meh+UoiK0Yf6f0t6e2WNr6T2JeCCvsxiBEzUSzUXcsXoM2knjAIS2XALZD7m1UCXlLjb5Zs/4dLhqMiAu3nEUQctVEQ8FOhDYvDltzVQc/vbq0fDS8hqWtbTCBPf8lrbK+vjuKNETTUadZW0hZVPvgmNTHp/5qq7lfO1Q6NO3/J34UoCkdkFryRS6/JhCdnu6+OItP5WzDW40u1hqa6fvad1+bAqFKbu/5/PUhICijlDMEXdwQwGI6uifL2Y2ptf5XrQc0ti2Ei+ASvDcI9QUaDoAECWQXTIsX8mocHa59RLOZGm5aDpawoJbMoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WihQSDuEsBnDc7umj5Y79RmxT53uB8WQ55Jw3m00RJw=;
 b=FF/zuxbGqE922Ayd5cUdDMefcYRjQ4BwiO9aqyUneTaSQQdmX7KrxNdURlAXAdlhJz5B4FnUZiSpBnpr9RKUiTTZ4CHJpEwIdaYfJN+2e0zY9L4HGtxX8pqeYUTkPZLLU2T0GP2ipTXCaHtTaPpAsbU1b8L7oEKCT/4uQG6+JOF55ahPv1q++jU+SsgBpJ42nlAFnJIqNeW15YUmVJtk+Oq/1M4lzke7QMDc14AoRqrVrjiW7F6Pk2stJF3WjoSpZZTO/UZKQerhk/dOXIEYxZBIN2tuyqmwMhYcuUo8bE1SHukpxAl5OIo5bFC7p3kZ9Z3ppyiatjEnvHyoeWBmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WihQSDuEsBnDc7umj5Y79RmxT53uB8WQ55Jw3m00RJw=;
 b=yuaOV3C8Ytw4GdKydm8Q1H5xbpb+JLT2t+Hq0vV2UM0pwynx0OFprXWDh1Qw2T8RQrvvv518L5ZvXQvJnWoWNsHC7lMcwJcv3F2p6PvGhbSXNNY6NFmX0daw48wkO5IHdb/VHOEYHnegYQt7hWLmovYQyScx2Jt2DaFBvgSrJJA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CO6PR10MB5618.namprd10.prod.outlook.com (2603:10b6:303:149::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 01:50:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::814:3d5c:443b:17b%6]) with mapi id 15.20.7316.032; Thu, 29 Feb 2024
 01:50:21 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, fdmanana@kernel.org
Subject: [PATCH v4 01/10] assign SCRATCH_DEV_POOL to an array
Date: Thu, 29 Feb 2024 07:19:18 +0530
Message-ID: <79ceba6505fbf13ed731db3588bd7fd932dd9f5f.1709162170.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1709162170.git.anand.jain@oracle.com>
References: <cover.1709162170.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0025.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::30) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CO6PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ccf931-62f9-41df-2163-08dc38c8c9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	D9uco/kV8K5v3oqKNjG1F7kyK5L7ef7QirwGm060S6QiBDmUUbJbPHdU1PTs104kuy4cjVEJGGfdTmRxKOaH4EBPbcFH7tCf9CL8DZR5w/oAl1rOE7MiG74h4ZPpktedXJ61BAphka4uPzYQ4FNohkoDWMXe37GakVT93s3WMEKvfH5jBrq9J7+0Z98wy9hMEXKClh1mrXQdXoj3TV5gkO2KVF9LCo/dhmojy7WR9MjgpnDeZ2UdvcuRRc+MPQUkgl70Q9xbWUb0zbgJOLAOrnsMeZkCAnNefEMVyJroh37i58lLT9fZQ3FDxK9iVwx/QOrpVkA9s3g5ncfGof9xtjeTsyzTKinS+D/gyv1H9ogopAhuTZpz5BoX0VQOQ+D36wWs80nZciJSFhk0em3l036OEHWEsRuWju8Olcb6tN8PJtowpQUaKw5dhHKT8ORh56NMxAVMp8eVpfkB1HVEmXrS0oACAx0jUcOOlXOdoqcZlbFozVNIvAscXheeonz89k2VdG256Ew9AbdBMltKdjs7rdp5my7DzXkehwW9AYuE+M8kheicTwgxHdgdXjM4j+FYj8tlON2T2MjyBWGM2Skbxg9x7xMcPmkawPbnvFO2Tx7xq1y3+qH7HiQ/aLs173bDLCuAnF44dmxgvT2joQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8aCBN2Hg7bDq0t2/XU+p9Foot1SbPgZj62G+h/KGnXxVCZTnirtmAzefFXFs?=
 =?us-ascii?Q?KvSr+xp2croWGvwjk6Mv3LZm3Vh9rY2RLT8G4Koa2rOcec9Il8eK0pD3LjAN?=
 =?us-ascii?Q?6x1rC9tR/DxX0pdhVMOcQY9F3pQTC4M1JEIIPFMQJ1wptbjmSWLWPR8/PU7V?=
 =?us-ascii?Q?wxLurC2QYRcP8fGu0OY+ZEbVKvgvZ5QHz3+lM4N/FyW6goKPZc/rKfNmWay1?=
 =?us-ascii?Q?CF+lbROWFOcNyhO+rL53+H6Q+//YOUa0ynR6zsXcLPB4MEtUOwvcUMujurI8?=
 =?us-ascii?Q?/pXORU7ixRDY2qknmqoH3GqImu+hmA4MEYIe4JU5fX6eQmWxCMqZxXYxboXN?=
 =?us-ascii?Q?aFPweRpUoNVFtc/aCcMGtClCi6OtcqfUwMysNa2q+r67Iaa5nBmMAj0UKtWN?=
 =?us-ascii?Q?26SPpamJuFVaS4Mo+pR8zxTZzIOXJjn1bFlZ+ENstohUrQ55qkBMSIQNdfGK?=
 =?us-ascii?Q?zreazQ57u0hrBlbbYYlSjEwz1bmcrlX31OnnPVSk8dDaAt9Fu8HEdQOL8YCc?=
 =?us-ascii?Q?tW56c07SMdwPZ0NcAZI1Zg3DME+6MaYl1ZFfhwefAQpAi9JfIE2bLAGVzUhz?=
 =?us-ascii?Q?fca0TVoe49ixdJi57aheSNpDVdaCR4uzny3CsZFCIe9eGzrIAU7TvruGhafK?=
 =?us-ascii?Q?F+nblBk03UlptjCyjjGXGldqoecbB3T2tz9Bc/NrLBWhrMTXdkLzlIyRbE8P?=
 =?us-ascii?Q?G+qOsDHpplDKZBCwjQJl9U/mrK9JQz4DjWSmYQOwmRiwW0tG1DBA3zHOUEiB?=
 =?us-ascii?Q?ITHhOF3aa1iHNbIUZk7UnyW7rYSg5zyUFOgpMWJkjq0x9ChCXoA+xb5Z75i5?=
 =?us-ascii?Q?XHP7xiuoIjZ6QUPVrhnI012tZpeK5pKTJmgqnoiXx5HENqQQe4v6JEptTS96?=
 =?us-ascii?Q?N+xLcvpP3HYeIe8eEU4GZl2f8mCD4i2CIWNYsNH5w+fHT5ueEe+RKAzABQ7G?=
 =?us-ascii?Q?Ap490wuc17N3S2sxnJdvAzdmNCmZF2JFlDvQQq9JsIdDQBfDtBhyKnoEeRIh?=
 =?us-ascii?Q?hAuhXBotJo9SGL5dfyq70qDB9YKgK6M0+hD6vEkMtXgadYwqy5oZT3sPNv9j?=
 =?us-ascii?Q?IEVeMIGCBgUjSNQjjrdcgmGQFRkx28u7b5pbe/LPwD6FIhZWbKv3i4AmSEcT?=
 =?us-ascii?Q?wiNTC+g5OZtN9sU6Q6w9Og4JLZtMQDa9C/xFA+Pq/GCyDCT9TkzcvTvVjj/G?=
 =?us-ascii?Q?m59fOZJK/wTxAMwISpzPG4JOphpHQUByCFB/QmIqsDP/34Ai/9T8rXyOM2kD?=
 =?us-ascii?Q?w5LNSCjio4SOH9ydflbK5emWNPBGo1u3KLi3jxL/VUe8u9pP9xm2aNRt9ERX?=
 =?us-ascii?Q?Z4C3hiLvjkYV+x/oJfoSclTLXIF5+hBfs2W/t8yI6e//HL95PL8cLsqvl2oR?=
 =?us-ascii?Q?oJ8TmSICIpftRsE4jB2zFYHjKt6VOxkhGLuk7AOGPpVNM/E2oJfOZAbmhUY3?=
 =?us-ascii?Q?DcZUQqg5A6ko+Px/BFdOXE2lbcvfAXczaqFw1jaIjfzptTLfgqJ3ppEVbvgG?=
 =?us-ascii?Q?zJKroerTJlEl6tA/n1Ev8Qgugtae4tERO6TaEpUizblXVuBonX+P9zhXlvUw?=
 =?us-ascii?Q?cjKmpcsfwU4IGeKt+scBMmi8qq1TGhYfIAlVVrZI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Snrxz86YIAPXhvBNLCf40Eg8d99FAqV3B1yeREGu3gUbY8FM4wZVTACyMtwN5R7J0vI47kiCg65e/NJ38rPORnovls1qDhwbkJDw/419dg5yN8oPSrLkOnGp6stgRDX7ySfn3grzk/RuF5PjRb1S7LP9LvuWYEVzaJ9Yq/WemPEH35HsKnv97r83c1kRSKnMnmhcWO5CLrIiTfFzLpPWpzSLsnY38Nv9XXh2ACJvxg8wXWUrEuhhkZU4O0MHDi3gdaNtwOTEL5htphurEzh2kJktvhuvfylpVFu4dmMytsfOMANqGOd40XtqBioEFYaaOj6r6myoh3Ss+r8JmETm1zxyda+qkX6fSjBU6FNNwWWtW1xXQjK/eq6JjYuMRo/FRjUgm7MKj94T4BWh9MZl6Jea3oB9kQY4u06roFFnHIkBGhUxipy5KyZromY3aRs09VB7WMGlU2MfCIj6RS19sYZDA4Gp0LVK/8CpArByWRDZw4Dt6dd8YHb3gqKlJYlt6NaE7cHtITBhMv6M3nrtY2vxWadPyDasn3TToETNLqxFJ67ANtiVfrAhsu6oYJ7c0TKTTKGKdQERmtaHQWyJGmTvAXp+qSFB93d4FQFbfmU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ccf931-62f9-41df-2163-08dc38c8c9a4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 01:50:21.0482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKY/aIv+vwkxQme5yeLGN979u4ewARVqb3DyVdQvJEcVxSQxVogZ1D2vxz6OTLX35xmg/DbQWqkuyCjgQ0hl7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402290013
X-Proofpoint-GUID: ZocYzreEWidRwBS-4vyUaB3V81IMvqoi
X-Proofpoint-ORIG-GUID: ZocYzreEWidRwBS-4vyUaB3V81IMvqoi

Many test cases use local variables to manage the names of each device in
SCRATCH_DEV_POOL. Let _scratch_dev_pool_get set an array, SCRATCH_DEV_NAME,
for it.

Usage:

	_scratch_dev_pool_get <n>

	# device names are in the array SCRATCH_DEV_NAME.
	${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]} ...

	_scratch_dev_pool_put

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 common/rc | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 30c44dddd928..b53a1cbb59b0 100644
--- a/common/rc
+++ b/common/rc
@@ -835,8 +835,9 @@ _spare_dev_put()
 # to make sure it has the enough scratch devices including
 # replace-target and spare device. Now arg1 here is the
 # required number of scratch devices by a-test-case excluding
-# the replace-target and spare device. So this function will
-# set SCRATCH_DEV_POOL to the specified number of devices.
+# the replace-target and spare device. So, this function sets
+# SCRATCH_DEV_POOL to the specified number of devices and also
+# sets a SCRATCH_DEV_NAME array with the names of the devices.
 #
 # Usage:
 #  _scratch_dev_pool_get() <ndevs>
@@ -867,19 +868,28 @@ _scratch_dev_pool_get()
 	export SCRATCH_DEV_POOL_SAVED
 	SCRATCH_DEV_POOL=${devs[@]:0:$test_ndevs}
 	export SCRATCH_DEV_POOL
+	SCRATCH_DEV_NAME=( $SCRATCH_DEV_POOL )
+	export SCRATCH_DEV_NAME
 }
 
 _scratch_dev_pool_put()
 {
+	local ret1
+	local ret2
+
 	typeset -p SCRATCH_DEV_POOL_SAVED >/dev/null 2>&1
-	if [ $? -ne 0 ]; then
+	ret1=$?
+	typeset -p SCRATCH_DEV_NAME >/dev/null 2>&1
+	ret2=$?
+	if [[ $ret1 -ne 0 || $ret2 -ne 0 ]]; then
 		_fail "Bug: unset val, must call _scratch_dev_pool_get before _scratch_dev_pool_put"
 	fi
 
-	if [ -z "$SCRATCH_DEV_POOL_SAVED" ]; then
+	if [[ -z "$SCRATCH_DEV_POOL_SAVED" || -z "${SCRATCH_DEV_NAME[@]}" ]]; then
 		_fail "Bug: str empty, must call _scratch_dev_pool_get before _scratch_dev_pool_put"
 	fi
 
+	export SCRATCH_DEV_NAME=()
 	export SCRATCH_DEV_POOL=$SCRATCH_DEV_POOL_SAVED
 	export SCRATCH_DEV_POOL_SAVED=""
 }
-- 
2.39.3



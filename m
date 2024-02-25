Return-Path: <linux-btrfs+bounces-2729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ADF862995
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 07:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8481C20CC5
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Feb 2024 06:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5829AD527;
	Sun, 25 Feb 2024 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Np7rVvOQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tAA8iOwl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA4CA6F
	for <linux-btrfs@vger.kernel.org>; Sun, 25 Feb 2024 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708844367; cv=fail; b=QwrDZ9FY6hpr8bpwaap7Rfg+M/N/qmSHYxQfjQRm5DzjUDHSw9wQwPcw2yCOlUs08eokciWRlevYuBWJHVMwR4YbMaIUYsobNzfyLXrbzE/BX7LD+TFTC61FUocEUWKXGZF9Jg/VILljAt+1xmMf4YRpRKlFtxCK4IzjbPLJp8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708844367; c=relaxed/simple;
	bh=SfpFacoQUTG68N6wK2zEwKZe2njlecJRrOIRgaEiIzY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LpLD7UapLm5cgpu7OraB76HgMgG35kiH/6CnCfiIAPlAFP4BE4icWGNB2dsjVqbjD5A+Ia8Bc5D9k7LUljtekrJcjMH66Trb6XUnXdEl18ix0E/+FooLerclGDIkfQJru4Wm4EWQ3Soq9D2dPGXRr/HBsWje30VLmirs4y73Gcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Np7rVvOQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tAA8iOwl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41P4UdXI014339;
	Sun, 25 Feb 2024 06:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=HljqbRhEgQbYbIRrSGFkGTCczUZC/pfCCxuLXB1xc7M=;
 b=Np7rVvOQNq3EE6WCaC9hekV2NrOTArQez5TMcSt5HOSi04ql6SmbxlKj1WzrtQG+uPXu
 tiimpPO7VnSZLeJIPEFBGgBBGS9JZsrhY9W8KeGGeA5I2AgMMSC74EaQvPXUEAEx9Oof
 utYjIW9CiuRNPlxGzddbTZcZi4DdN0EpxtXR6TqTXicdso6xj6lbPFGH7nSs3kGjmhKl
 cWm9s7Qtax+7j3GEEi6FkBVbL98L20GwQbzcH3HspkkBJfRtuAfIrYLw+I5xbr0Fyz/G
 kusR7ApwGPo3nBbEtlBX7g8Ibl2zenScKt12+xpJP0QvX29E5rWL1GzTd2j3bCr3Qb15 xQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf722aard-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Feb 2024 06:59:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41P5nB2Q039416;
	Sun, 25 Feb 2024 06:59:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3wf6w484wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 25 Feb 2024 06:59:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y424SmPHdQzKQi9ebNYsHvgY6y1KnuFQQ6+QUy/42iupKutzYLFUXEEjxrBKybmFHTLX1ByzNZkyUxHSPwNOXgVrDpyRoCKew9RQUf+vDZzI2iZk9Q+tH6onY1srKsqNmdWwa25Hd8Voeo4PFcRtcZexm9ZVRb8oyuBytD601su00ibjg08nR2JT0KTrjlAO1IfjFXYyN5GoVCofU63cI/2xFdHY09vJQwsc9SL/oblsm7g6JOjP+xy6dE0U3uVKcBwYzd88X0JDdHh0K3D9Ee0GklrSLerhXn12A5kUitfTp+9OdntlT0D9nmwR8075lu/4U+W7opZ/Cj3Yl6lwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HljqbRhEgQbYbIRrSGFkGTCczUZC/pfCCxuLXB1xc7M=;
 b=fAErrAPL+HJBaz06DVzsJPzFeIH0pDudxoYQD48hZGHS9725VrjFHvVkE8/pMcAewWktXOMFshV1Vrt0ioUi9d39rKBHa4f83+XOvEVCAPV7jPwzgIAYdijIzSj6Ncx34NviWuYewY4R3lv7LRfh9tScPeKdK4isT1OpHO1fdmXHLqfNcbrpcf6Jk68ZCVzDN2P3bJFVWvsB7XDPo26owMfLxEVjjh+IAf9Hper9yWWzZsdjh/FqjL91hL67ix6ms4u9zgCt5MnD4KLMnGd1La7g9s8Rpotj5yyhlPJlqU4vHgMatS4IMMD0syxJH13DZMGOE4NJvKh39ELLh7CGNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HljqbRhEgQbYbIRrSGFkGTCczUZC/pfCCxuLXB1xc7M=;
 b=tAA8iOwlC79urv1ujkgATZrH7MMbLcyf6wTGSsnUnwhEHAj7S1qbQ9cVQMxW/viUDFWkYi0TKi5RXVj0XejXKgwXXR6yictfumNvYP/BcRrxUr+H03YK+giFdJeW5hKwlQUgM2WBM/oChKsg4NKsJ6O4C7Ucm5XM8s8jniHdX4Y=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by DS0PR10MB7320.namprd10.prod.outlook.com (2603:10b6:8:fe::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.33; Sun, 25 Feb 2024 06:58:59 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7292.036; Sun, 25 Feb 2024
 06:58:59 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>, Filipe Manana <fdmanana@suse.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH v2] btrfs: include device major and minor numbers in the device scan notice
Date: Sun, 25 Feb 2024 12:28:31 +0530
Message-ID: <aaad3aefc570103b68559984307658bd2dd3df1f.1708838672.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::18) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|DS0PR10MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d377816-9ba9-472f-32ee-08dc35cf3e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mbniijuTvZmsGDEIWoPzI2j3OFJehex+tMsd7WNt58eqUha9OKLENzZtK5KYGWZ85ykITcOTruy4AiQVaf+oev79jgvXMzYCx0VGDs6S7wn5O2HKkcyPK+hxLXjX/pdOQ5AQtKOsMrSXvIqhiNvvSHH/gA0XvAkGcaLJJ16MOnDaD4Kay/xRC8NzNZ3LMve6aLKtNDDCW3zXseM0wN2ZiYq0zhYECpsyeCfBgBe5tuXuV8s+VycVN4McuMkuUBC4RyPCsbYN7WYtdJR1iqkd49koCTB7zK5/zkOS7/4tuquX7mooWP0ol6QAhq+H76RA3HSNKrqmONQN6X9l5yG1F471z02D05yLPZyCn6Y6U49wKtk1OK8D2cVkVJVzUs2FCt9SmHHfzsvsVfg4lBWHCmL9D1YTJnG+Af1ZYJcqH721cXKLuvayRwypARFV0k7kJMvmWqD34+5KVT5WCKiQJI9WQslt8V7xkB4MAwR5ugQy5hcDGfaQsE9xNGWo7zLZWO0AsTj1LbyuCTRJNrRCC1L9olUON8SwUkYHYh3IC1E=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5U5x2Nh9y8pu0MXnmRbWqTY/yL+RqTTXGX/9XNjxD7Mm1IdoxULLFnBo8uuX?=
 =?us-ascii?Q?Ut1TJGwCoRifvLZ1mGWWt1buETaH7cEg3zzIv1WMSAWToAdPv3Suv6Jiwgm8?=
 =?us-ascii?Q?PSH3OrNqdeT3gjJmIUT3c+WD7YLjasoYrAaXi/HCIwOG6bbffDbT9LZdNqh5?=
 =?us-ascii?Q?l2njgtI7fJV5nRZvAf6r0W6YwFT1axEksa0wAh7pL1JW4GwVe82gHqq7Bz8g?=
 =?us-ascii?Q?beK5/ub8vA+EgQS/UCT1mRt9vFhGMWWqwMJbw1kprdCZlAvTaWp1WjPL6q6y?=
 =?us-ascii?Q?DKkXDva8Dz4Vg1IU4gLI7kAdvhXSCiDIimsHfpa8Vh/VJ4o24/ZRebf+qR5k?=
 =?us-ascii?Q?k/cvhRL5u9Wd9AXhhCPNU3jv6a6TV5QdEQL+Ux6rTJM00T1UQTPRlC6i0I+O?=
 =?us-ascii?Q?O0fhkumTa3dEh1EQS1/XR8Pcv1BH0HB0TqlqblQytgg5yZDjMeYYAAXOvubi?=
 =?us-ascii?Q?1GFX425kYTvEcAo/0alYiHwAg/l7ciHV7VwHylpR86819SBqQZScjWBbieht?=
 =?us-ascii?Q?RAuZNEVbV4SK7L1Y45BI5iaEU5kZLlz3ysZUMStEf5X3S37XYG0491i/cJEP?=
 =?us-ascii?Q?GoaaKIyjQ277RBFzjsYLRurP4bfFDjNub4CJGbjXf2XdpC+xH+Y69qDWmXx/?=
 =?us-ascii?Q?uhhApL3ihd4oCgfU/9wv6F2U12BLe3g9nlnAi44Gtq2V/lwDbZy2MMhvLqws?=
 =?us-ascii?Q?shzJMZnEzZrxBIiEBbuO/aYevvKyrpsL44slfsBhBC2rLSueFH0RZYl6Ey1y?=
 =?us-ascii?Q?93Yl2ta5Trw89zSx/Wt/i+cFUR7BB7S11aEMhoAuf4UpZqI/nuyF7FJEWCbE?=
 =?us-ascii?Q?zXe8hMdZfQqPfMPFHIBqSoLTd1ZsvhvcJ/7WZgliRgPwjc8eAkWIB8PM0pyp?=
 =?us-ascii?Q?LxHe5QMYxNMIhx2wqoAv89nBKV4tVILN4uVQrb9dwZsJO85nFcHUE4Ltx5M2?=
 =?us-ascii?Q?FNvq2FNoVuVRHd/bDpvDhw6uiPSj+iMQmmroJjxu3Y5A1pVaqsmdUsr1y4Rl?=
 =?us-ascii?Q?hUkCxYpxlnwwNnDGab4N8BT6ZoOl+BXX4luKbtJErFrtPVtfHrcOi+iZz5jQ?=
 =?us-ascii?Q?H7SYf4tIqqc0fTMBaAMrxOfVNjZQDJjl3GAlWnyiOE9G71zZOSoqGZXbEHTy?=
 =?us-ascii?Q?p8cj2vKZnMSj0OKfMsVnD4UTF+tiejarJOzAtNm8EKxojoGjje4OuJD0YeMX?=
 =?us-ascii?Q?3Jh8bkI1Q1SDsgAvr3YLiX9bYniUP3svQCQv0nVSdEDsmnIxLc1yMXlmYOlS?=
 =?us-ascii?Q?SUsEC2qTZdKouh9/DpbfDCqTp2Np61Tr9OoYTaVS8g7LM1t+5WkWcDNvE9hv?=
 =?us-ascii?Q?0igYF0hpCr8RxGsCLoJlgmr5zCvhigjUIbgr8ODNKvGwKCNL1ujN5EC/zFhH?=
 =?us-ascii?Q?6MoX0zJUBmfFNlufVQHu5XpZ3CXUiUvmxIHt0KTQMtenjop7YtT00Z5IlIn5?=
 =?us-ascii?Q?+T3mq17brNjEGZjOMwPcAMjDZJOZRxpV437Hx5aSrkN6d3a9TrdEymTRnE3R?=
 =?us-ascii?Q?eE6CgoS3Eg1gHI4AOeq+6on05sylwMd8rgoOoRgwfUPgWHLEKDCBk7yHgoDv?=
 =?us-ascii?Q?zLm8GivJxrcOAMIt7qVltpP1aD0YeqiMxYPFKHv+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6jNrwoP+QcGmoXB9LZA06USoKDIZWwyiJ/CuWo006gk1ijJzYJpDOg8xXZACdGUcD49hpovcFCrbW0T+sUqNSHRpHR0ORfFe3MCfhc+YCb1zwPguJBJEzKupwtc5q3xWbJ+qcvbFaE0TMu0j6VwzlqGtZuwQgGyCbqa2iZCZv0vAkk7xqtNTWKfjnBo+W8+2ofzYoVNSrPZDeiwJbx1DrUt6Xt9veaYVnw0nAtLDUh31XYnKUPUF3Uvwb/tY3zaMxh8p7tmEsUmlvMXE8zM8EFF4wkGWbk/Qsfrp3k9LSI2oRCK8swIVo7T+BCzmqtqjoLeDVoKiGlvwTTLLpArpISVIjJkX7De3tsKWJwg40VZsVtPYRBiGYEOfrYZJglbF2KnwKFW8HDNUcXux8CPojemQAW3RXZEewEMyf1kyG5nGQwCJkP6aCE4rt46mJrRax6xm/hQKdIV/zp6AWc3skd9GAn4z7Masme7Z1UdnmMrKIKt6U7q/5e3fBPtj9Q8uZjWBh7PoNTU461HXRLL123XX6e3H6tx08+YiL7h3YolkupoXalyFait05srBx3Z8CTofx6yzds+cW5OnrK8g/JcW+aqaNoHOIDPP6Lj3jF0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d377816-9ba9-472f-32ee-08dc35cf3e1f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2024 06:58:59.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctgMthxxNc/31iQxEsU/f0sloUbxJVvcs6X3+vK7ZNNxtcYNYLkJOpDaAlcSc2+NpLj0AcmmvKQ23Gca2c/uQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-25_05,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402250055
X-Proofpoint-ORIG-GUID: 6peG_45VEqhq2bZ8jdDpgoXV1qacWGdF
X-Proofpoint-GUID: 6peG_45VEqhq2bZ8jdDpgoXV1qacWGdF

To better debug issues surrounding device scans, include the device's
major and minor numbers in the device scan notice for btrfs.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
v2:
. Leave a space between device-path and device-maj:min number.
. Add all pre-mount (scan) messages to include the device MAJ:MIN
number.

 fs/btrfs/volumes.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 32312f0de2bb..6152e6a9baaa 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -767,8 +767,9 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		if (same_fsid_diff_dev) {
 			generate_random_uuid(fs_devices->fsid);
 			fs_devices->temp_fsid = true;
-			pr_info("BTRFS: device %s using temp-fsid %pU\n",
-				path, fs_devices->fsid);
+		pr_info("BTRFS: device %s (%d:%d) using temp-fsid %pU\n",
+				path, MAJOR(path_devt), MINOR(path_devt),
+				fs_devices->fsid);
 		}
 
 		mutex_lock(&fs_devices->device_list_mutex);
@@ -797,8 +798,9 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 
 		if (fs_devices->opened) {
 			btrfs_err(NULL,
-"device %s belongs to fsid %pU, and the fs is already mounted, scanned by %s (%d)",
-				  path, fs_devices->fsid, current->comm,
+"device %s (%d:%d) belongs to fsid %pU, and the fs is already mounted, scanned by %s (%d)",
+				  path, MAJOR(path_devt), MINOR(path_devt),
+				  fs_devices->fsid, current->comm,
 				  task_pid_nr(current));
 			mutex_unlock(&fs_devices->device_list_mutex);
 			return ERR_PTR(-EBUSY);
@@ -824,13 +826,15 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 
 		if (disk_super->label[0])
 			pr_info(
-	"BTRFS: device label %s devid %llu transid %llu %s scanned by %s (%d)\n",
+"BTRFS: device label %s devid %llu transid %llu %s (%d:%d) scanned by %s (%d)\n",
 				disk_super->label, devid, found_transid, path,
+				MAJOR(path_devt), MINOR(path_devt),
 				current->comm, task_pid_nr(current));
 		else
 			pr_info(
-	"BTRFS: device fsid %pU devid %llu transid %llu %s scanned by %s (%d)\n",
+"BTRFS: device fsid %pU devid %llu transid %llu %s (%d:%d) scanned by %s (%d)\n",
 				disk_super->fsid, devid, found_transid, path,
+				MAJOR(path_devt), MINOR(path_devt),
 				current->comm, task_pid_nr(current));
 
 	} else if (!device->name || strcmp(device->name->str, path)) {
@@ -1366,7 +1370,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		else
 			btrfs_free_stale_devices(devt, NULL);
 
-		pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
+	pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
+			path, MAJOR(devt), MINOR(devt));
 		device = NULL;
 		goto free_disk_super;
 	}
-- 
2.38.1



Return-Path: <linux-btrfs+bounces-2405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0247A855A7C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 07:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273881C23194
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 06:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA49BA3F;
	Thu, 15 Feb 2024 06:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VAgjh6Gw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y2wwa+Ck"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88DCC127;
	Thu, 15 Feb 2024 06:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707978898; cv=fail; b=MbOgdF2mIVAcHVq1yhvPoBJStvNNAUdkK4vZdI+bGaon+frupJfewr9OyBQq7dNka4P2DeM2hF+hxp4VMPTbkCJ+SOVSLMfZz/7zdlLv5pIVRCpt9ELUKWVs/FEVmXK2rTlbKQzEJU48/4NlsNydGiHNMA8ZsXhKGg/7nuwuyPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707978898; c=relaxed/simple;
	bh=tgiBEixFkmhQjPeoFESScogK05Uf1fn2ipHNISNk8y4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hfuzuL2V4PtnRayRncythwzvKsmbSnE1dueE08f6D3NtUmdC07XsAAFDek7HAH+r5jDoXdSwMjk+qwH9HqLoljtSgCkO7vFChEdCcfbwo9kU5lwHktiWY3MjmR7Ssr+MTpcj+8BmmAjiZjSLDRk8tlyovl+sMQO2EFkYhwuedYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VAgjh6Gw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y2wwa+Ck; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMiJfO027871;
	Thu, 15 Feb 2024 06:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=o8bRJLHig/pRItwNX+OvgR9hgZAc8F5xrruXUgZ+me8=;
 b=VAgjh6Gw/ggKpSuHHD9wxmKX5A5Dvi6KXvwoVKzF3jiWYxq8CTpAdravfm+LRyQqGmlM
 AuH47fs59pAqZyrjgQs7hlUcD+jFOiF7wg2A6csRHjTstWV6gax/VyMCUafYPuvvhd8q
 tNCcPJSh9qEGKWinq15itmo5R6iJmjEgt/IzaZrbasYnSSE5z30Ri0IyWXPldSO5fuSE
 JvNxGHUOdNn7eNj8hSVJbBWRw25fSRZiD1C+M0gsmruB/4FqcpL6DSt+Drq5q11v7PLU
 GGs9p+lQ5ai+AzwqGSP7F7PwOHQow9t39tZZvkLTRNH4n9G34AVhZ9lEQ1otEEEN2gU8 yA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92s714bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:34:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F5G6oQ024690;
	Thu, 15 Feb 2024 06:34:54 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykgbcjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:34:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3cjjJxhIWXtUDAMVOfZizdnIJ4qXr3vrHbpfosvdhy0+pLYoZvBbdKPlAi5b2Y9GiepAQsv29dAcrPLqVXoFdUQSLYr3nSVfMgfpD1osHtvEiW3ir3MMvdKA/9lganCv9VtOlE9DKAQ6V1QwjPJVo3KiDZF5V7JZHbzcUxguoNwEtXoex+Ru5pKhE2x7Y4u8/D43tBZ1RVeLdGDbH3zho9KyjU+rt0y3R/nnsLFbfHtYVvTyXg537vw4CF0wLkvs1FyF+wovMSQVmjl/WDqABzdEN0NPISi19CGLC9wmyL4QV1EiK/2mlsVOen7uong0rU+Z05qqu68sxGzjlxO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8bRJLHig/pRItwNX+OvgR9hgZAc8F5xrruXUgZ+me8=;
 b=GrKaxk1L0uxkmARQ2W+Wjsb3terq4znVin7NUQnbhbD5jw9h77M8DUl9mm7rEiwjxTMzHBdEHy+pcOrvSL8oZTF0Zi+bd7pltABDsJ2UWN0Su91ADHr7GBVCVxGK4UkxXv44/T+LwvYEGNoWQmQFEiwwrWOX/vbWuyha00JNQiz91cBGDu4kMC++l1EL6exefP7t5aLt2EOtLtecq4MK49MrjDhrC3tywWHssuRGsHVrV2hloDgskfWn8qafJRH0TZj1hGBXUxn8SIVoRiRc7b3Srxw2kfeUvCVixOAUbKlG07Y10K7O3vIQWc/yz9Ocs89OvuK3cfOmI0Bpl/Xh9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8bRJLHig/pRItwNX+OvgR9hgZAc8F5xrruXUgZ+me8=;
 b=Y2wwa+Ckofo+icaFunjrJvKzeKfrJgOzriGgr+PWRvVcowjJofBRIpEJNxr3t/TTUwFEXyxYTYBp147C8GY99PxXiLcvF/Q8gv8Yj9iK2xPDtmVn81WF/gIX9Tm/OVhPyO/e7qsvFNk5ngJ4k26iWTEVqrGS/KEhckxEv2QlmH4=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 06:34:53 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7249.047; Thu, 15 Feb 2024
 06:34:53 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 04/12] btrfs: create a helper function, check_fsid(), to verify the tempfsid
Date: Thu, 15 Feb 2024 14:34:07 +0800
Message-Id: <cd8342fb284a1983d7645698464debecf417e52a.1707969354.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1707969354.git.anand.jain@oracle.com>
References: <cover.1707969354.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0111.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a017a7c-ad9d-4ba2-e265-08dc2df0376b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	52nYSsw72sqOo9PruvzPxqj8E1kaJmG4z45cRFKSOuAYQdueSkwDhb+CCJVpmoZY9EtagwqNB7fKVLRaOuCUemGHI6H1gil9UupeIGfYcl8mi1g6K7NzNoKg3PGxLpQumOT7bqbKkBSy2l918Wr/3FmClbaPhOzCpIc+ka1l5kOGYbqqWQ+mzcLT8U2Xm1JsYJ7phJVmuB3FshMt1c/jOjdtswQ2pZ6iGUc/6uBOSB9bs1cgBPALrRbxq97PGeEFCKZEmFyKxH74Zq0qEkgSYD/NCOClQ6qo6ray/xIF0Ekpu9TGmNDOGCQ5cNi+GqZESKf+IwaKpN049g3BVnPGwQDu6z8L4/jJsOPpKjK8VJegUpcaQurhQsM+IzxFF60vIVpxVCQS7byDkjTJsv4+5lu5CiLPKkd0d6knmqps3HI7Mytg+3SHSyouZTlbfYOQkG6vwMw4bt/7cvplxnDYq+PbiU6abzYkSzENPBPDEqU0gidUgGwGHiIwTfSRPEV1LXpAC1kaTX7jYFZeupHNwvqUaqOyyHw/H6c41tJ8fh0yirlsbH3ep7MNazcZh7BA
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(5660300002)(41300700001)(2906002)(15650500001)(44832011)(86362001)(36756003)(26005)(2616005)(450100002)(478600001)(83380400001)(66476007)(66556008)(6486002)(66946007)(6916009)(8936002)(4326008)(6666004)(6506007)(8676002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yiT53YW8dhpKfbzmhD3PMfmeZcx5B7CdprVooLlb8EEHooi96TxMdxwWRJoj?=
 =?us-ascii?Q?7mtAFWGxz2lHnCZ3vrHjvFo3v9BbS3iOdlBwpbOz9Ah0upjfwdxAvITOdGeY?=
 =?us-ascii?Q?/ZuZzJ9SnNCdIRGqx/hE6FP3CgR45UOLzQgRY8/jpWVACt0FGeQI/k/kK2Oe?=
 =?us-ascii?Q?Y1wtSz5nHsGoFcaGb+uPZ4b4BtzBhgjmvm/oB5/Nfw4m5dKwyfVqjgZ6VUzy?=
 =?us-ascii?Q?bWIE+78369rVHppVWD246LzpzjIZfZcL2mdAChheu67LrEfTBK65lYLV387b?=
 =?us-ascii?Q?nF8n8ATh9/jnA6f8mb/EkoI5DV3IghRynd22/zcfXZmz74zBwF0c0+aoy8ta?=
 =?us-ascii?Q?Eo/GsoTKOZFN3s4Z56dXo3cQBRAuNIXIgiyC7apbOeTA14dozOP+VBewiyGs?=
 =?us-ascii?Q?EMvnKqQJnVCC1kw8uxYFQauHPyA+7Crj9ewWS4J3oqG079R+ggxPUdRkTiVH?=
 =?us-ascii?Q?GUWUT8lr/1jwYr58faZEj3kNdNgTmsqpzrK8W9HCJMwgBk4qUaDmvBWa7ZUE?=
 =?us-ascii?Q?dqbiENseBog3Se9MFWBFskf/KjM9EmQKzTe1bfrcslXwDmTtT3xDU/2AIdTv?=
 =?us-ascii?Q?RD6INS2GjiAXxXN20ue7B0mdzvBq2ZPgk/2usn0W1pf+F9VjGo+lWogT3te7?=
 =?us-ascii?Q?OX7gE8D6A0TxrQSAWHJZG1ahA0iiVepbFFtp/GIX1Y4ki37wXvknt1dpjH6b?=
 =?us-ascii?Q?MX3hrwVwPigopwmef+/Ap4mxfHptU+52hGoAIzW0vj9RMRq+l68isxu1qTFS?=
 =?us-ascii?Q?JTh5Wo//TlmYj6Qx55qnJfcJEF41cnU+5tI2wjLPckyFyCErnI3E7FdYEnZN?=
 =?us-ascii?Q?H/nqwxzXS4MqwdDQOYWJvWdFdoBoMeN+rIgAHHzDUc1yfPcGxl+S9YMRE53V?=
 =?us-ascii?Q?GxWyQL9AOGXDeqxRI9CFKsjlS+bFxt9sttuRLbQSYs76jYzo1gglyVfLOAgC?=
 =?us-ascii?Q?Y2yImyKzqMQJUC37GvYPZ9i++qePJa9M7jNqMr8F97MPxekFZO4hs51f+WWV?=
 =?us-ascii?Q?cFJBMApOlgVcjdqe/gLn3O4dKdoCEr2a897nOiR0m2r5ezQEoImpRldqhsVp?=
 =?us-ascii?Q?NRVvz3BMYVgieNxrzwnaPwUObiKRAQBJQnUSJ7ASR38FF/5kMMu0hswz1Jb7?=
 =?us-ascii?Q?tTqmk5UUYXfDFI6F5wQTUm+MMLAGyd3ViCx7OdNaeQU95wMgUfHWcD4zVF+c?=
 =?us-ascii?Q?4XmS6a+43SjUQF0DuN+ASdkyWv8kfjLwIsLdFxGukVaA+pDBZGTclIcwt22w?=
 =?us-ascii?Q?E51fAZjLicX11Z1bH2mCifS8t+WQdJpqTZlzKnhaS7rWUpKKgax7kpKuHGju?=
 =?us-ascii?Q?2QmW7O46C0rjgMll9RKJrmwJtDS1EP/GdEs746izlp1hd9HwRP4xd3tfam8k?=
 =?us-ascii?Q?SQhVnrGDKHJlDen3ICsf4QlhcqpQgZ51gzHcfPlhb5DjVm4C77kzKx+maq4T?=
 =?us-ascii?Q?CUkLtZJXrQn6/usYbPdBJ9xV/8z7fKtWvfZzQMeyzZVxKcaklA0LZoz5JL0b?=
 =?us-ascii?Q?COEHL4b2XkVc9IfyUE37QRQkTWGjF4HJL1+nnuiQoZukSMLofl7orFpQYWDk?=
 =?us-ascii?Q?Lm7qoLOSVneadO8YSk4HeYTjPmXdmiE4gRznQ0+4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DKNX5RDxssQJgsBARCJKpEF92ju2Jy5icsMB7eOfiwRYvZcL066mAyafm0IQPfOliy2JcfUohCfoy75HYtS4XkP9y1rO3SIJR5DLgsktiLtB33hIr4/4c5INoX1EjTAjHwu5CXlucf8ZdZBtMzM+3tC11fuoN9FGXfOeOjkSfg8FCLm0JyulCm/GuSW6T2wyPsa1zrGAxflVhdJu+ndr4KbBJN5aZg7NhG3vr0ALQdhmVRBXZbO8m5doCIbNhqHc03Misj6/K2fTkGslbn6PrpcQMg4Cj6fiP8ufhQ78gbTu5B9aBMjy8iOuag1K84IYGy78y9dueS6n/hZoMoNmTYrkJrdJU0Eis3AB+88qtTMy2L9zyNKYh2v2Zg3W+Jxi4dXCGJBKNxnvsoAHhUwZ1n3UszWoRdHuaIGmVRssqNVH7ijaR28JMrrlWgvZUa9dTPjMgVSjDSA6VDwoO6h2vXUu1pSkmwR4Zu443vhEnqSsPAYHx5hBvJbHXj0P+nNESdIet+PWqY7FyNqNknaw2OEYBXxlIk5GGTnTOtoRIZHQkuSr7Azhix6RY9PrX5vzwLhT5tiO9o/ZRi+aJskNYVltTuiwe5Dh/WT+EnVque0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a017a7c-ad9d-4ba2-e265-08dc2df0376b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 06:34:52.9718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQbu2dIJw9MzT/HrkzztuxfRXg5iqdtfdYSXkSiN8Pf8Q1haLabnSJZ6I45/b5BBNMss3dm/7rNvWMwLC1kbTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150049
X-Proofpoint-GUID: w5WfKkPj0a4zEmdlSyMA5bDr6c9kzjBB
X-Proofpoint-ORIG-GUID: w5WfKkPj0a4zEmdlSyMA5bDr6c9kzjBB

check_fsid() provides a method to verify if the given device is mounted
with the tempfsid in the kernel. Function sb() is an internal only
function.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index e1b29c613767..5cba9b16b4de 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -792,3 +792,37 @@ _has_btrfs_sysfs_feature_attr()
 
 	test -e /sys/fs/btrfs/features/$feature_attr
 }
+
+# Dump key members of the on-disk super-block from the given disk; helps debug
+sb()
+{
+	local dev1=$1
+	local parameters="device|devid|^metadata_uuid|^fsid|^incom|^generation|\
+		^flags| \|$| \)$|compat_flags|compat_ro_flags|dev_item.uuid"
+
+	$BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | egrep "$parameters"
+}
+
+check_fsid()
+{
+	local dev1=$1
+	local fsid
+
+	# on disk fsid
+	fsid=$(sb $dev1 | grep ^fsid | awk -d" " '{print $2}')
+	echo -e "On disk fsid:\t\t$fsid" | sed -e "s/$fsid/FSID/g"
+
+	echo -e -n "Metadata uuid:\t\t"
+	cat /sys/fs/btrfs/$fsid/metadata_uuid | sed -e "s/$fsid/FSID/g"
+
+	# This returns the temp_fsid if set
+	tempfsid=$(_btrfs_get_fsid $dev1)
+	if [[ $tempfsid == $fsid ]]; then
+		echo -e "Temp fsid:\t\tFSID"
+	else
+		echo -e "Temp fsid:\t\tTEMPFSID"
+	fi
+
+	echo -e -n "Tempfsid status:\t"
+	cat /sys/fs/btrfs/$tempfsid/temp_fsid
+}
-- 
2.39.3



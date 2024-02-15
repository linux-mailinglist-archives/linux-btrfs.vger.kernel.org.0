Return-Path: <linux-btrfs+bounces-2410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E459855A81
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 07:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0387628D153
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 06:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D22D2E0;
	Thu, 15 Feb 2024 06:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bchacB44";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CLPvv0IU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CB3B67E;
	Thu, 15 Feb 2024 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707978928; cv=fail; b=nXlrKrleW+Kr4SNAWcL4xNf6DSAGuBtYix5FzkL/ylWsB7rDVkh7EmbUzEqEHKNH1fCovv8NqBN6uZCkxLl3IvQgBDAmuZ2TsZLJD+9jxz4advmCFeeZMiNe2HKKj96rOe4q2Mbflr7iNx2Fr9V7Y10J+x52tg9LTbGQf3pcTHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707978928; c=relaxed/simple;
	bh=Ao2+rVDY7yOPU7mw8J33EBlxvnndTh3Z4e70BTiQLDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uqno1Ibj5cOZQJyB3i9/IRWiueYCTr/9eHdRS23o6Keod/tlrcDU8XTUnHo5CnBRpF81OOCAOqyNb8mgZl3l8XJmR8jX8HHh8LkaGRokA97F/vMwD/XXf2h2Wsxl5Ehr65JV0VMcMyLbNrV+W6uveMeAZaY2vzbqEyeB/8sjlRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bchacB44; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CLPvv0IU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMhuVp007343;
	Thu, 15 Feb 2024 06:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=PvUrBgyf41qto8bPSqUyEJgsdOV+H/t54e7csubINzE=;
 b=bchacB44sHrr/hc6Oyl9lYPF7cdXGHfRk1+B09JX8qkMVAlseQoxAPhtvZ/u6i6BwJe2
 jBul6MAydbIEiX5Cp5117L0ZhVRozeLLzTZvYZwR8wusDOaW7zeNp/OLIOeM6yO0Q4zT
 4o8kSzB7BqLHkI3CFSTLtsiEHbrLuAFAqFWRH/3Lwz6c1ffZrydYKr6QPXkMISylAdks
 zD+5m3oftdVwEADpDCDqf4ivDBdcJGDtUOm6hKTlm69SazUrO9YQ3bdu7iV87JuqGy01
 D8e2d+EPXrzuTHWd6a7wCvcEZuQ7NbZlNXoVskaPcPr9eNu0Ipk9LMQQwCzJz8ZJptej Ag== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92j0h5gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:35:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F50lSE015097;
	Thu, 15 Feb 2024 06:35:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yka290w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:35:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2JN4htuAZjPDIz3EnQqBqYSEFDNd/4tfmM7kQGrtu+Rcy1W93UVD6nCQbzg/+y7KPq+nxNqopZaPh8bs7LUoJQhnM3qyVcHtffevSGV7B1h6QEovbVW7P43MXNP0mhhhgltOGQE7zzCVwNkgjpWEQju/hTrwqkh0FzjLKZMo67wx1UOWD97gOBPSbrxVeIAUlqm0BrphCZ44+bDs2ZeAsULAi38p4EkicEzTsevtVXUOR0dSb4Het8oymcka5rWtOdT/UF2HG4kaQP9kh/D+eulgXzF3JZQs1am4ClPuDdwG3tEu2XCqy6JEhjQXb6GnBM8egZc/aCALC1TmBuxuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvUrBgyf41qto8bPSqUyEJgsdOV+H/t54e7csubINzE=;
 b=cYkbC2zGjkoNU8M50BCsSZAanYc7xWwySROrZlbtYcagkvLfJuqVij/aLFAiK/eYopbloOIpDnmDypQDh/wWa8tv9k3xVGHWMhHRxJtv28uJvptGkdQkoIJOPAWO9FDR7nHvglaC0GUEes0r3bW+6Op7qS4AejT/X9Vde2CLCYhwZyS1A7UzAKjrlenoCfYObMhnOmbXwNgNSLWPAkYQS3rUYBrnRfcxoor58vuY2odgk8IztA1nSrtRWDzEOOyOOJdoN390MBaVF3qUihuNj4+4eoYx4yCJk89Zbnoicr25C+mJU6wUjn8p6flbpmgkVv7WkgaVDNZJoBPLzLfoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvUrBgyf41qto8bPSqUyEJgsdOV+H/t54e7csubINzE=;
 b=CLPvv0IUplv5MD9olI30Vd97OzmvjBpvYqMfRLQklLnQK395W7xw9Z6SAb/3QyzOBpUbRIMJm3QlkLu+CvF7DItsrI3whWOxcn28+6NfgDvM8wP5YGRNNXWn80Z3AOmJbV/ANlPnAz3tuI3XXXhyIikkxV0Xlr+hSbVJaAZk0Pg=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 06:35:23 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7249.047; Thu, 15 Feb 2024
 06:35:23 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 09/12] btrfs: introduce helper for creating cloned devices with mkfs
Date: Thu, 15 Feb 2024 14:34:12 +0800
Message-Id: <b6026821942d5898dfc5f60d7a7c2b19574f764f.1707969354.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1707969354.git.anand.jain@oracle.com>
References: <cover.1707969354.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::10) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 092a0348-18d6-48d7-243e-08dc2df049e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	1aWB0MgnB6Pcd+N01Z0pq4ekwR6d3ihCz3RcAE6Dc9XgLrjNqWvxOEkckkHNgOTaRqrvmQPPGxRKGAvzvsl49G5Q28Ufu4JQc1mlX7rgL8t8QuhWx6hgNcCrDROabPyVavP1nF4X4iDNdF2ieteNGxj/Nga30WH8RxE8eYaY/D53C9h9R4Eo+JE7jalHPNg6CudLSuanV98lJ51+IP+nj5vAtEwpJUZPMtQN1vDjZTavIk+ATwwUy0UBDVj98tAHfHfvpCS2Y1cPAbmOScotoZo7wzuTxkM+B5Lnybu6tSCwg/LzcAZH4gRtXOm1/sLS8VDsWMkSsYxUQG19LlTyJRxOTgYW0oqHJ7C8cr+68zYNwKfNdOJlkz1DpYu/zJn3tQLreangjdvjPAmBedR+TxxYKkfB/VptRmUXPXjScottjB9KF0bHpqKCXlWeXdcEWtgRHNdpioHbBlA8POYuOW5YcbP5LZPcjqI5es5F6IQtFxaYmtHE6YQ/U+SpgSPtfHtS96ZQO/E/7lT+pxGc7NPGkUPNO0fEG8TVw5heVGMZV+ssYLuQ7AvjxSvlyxCZ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(5660300002)(41300700001)(2906002)(44832011)(86362001)(36756003)(26005)(2616005)(450100002)(478600001)(83380400001)(66476007)(66556008)(6486002)(66946007)(6916009)(8936002)(4326008)(6666004)(6506007)(8676002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?t4iMDK5r/cV9otCXZ8QYcGQieSrbwfS8i53oydd3C+o/P2y9KyfXWzn0x4bP?=
 =?us-ascii?Q?yWP22loKCQq885z1oViOfHaZDhpF3mfvtJeblJNyx1ltnX6oKOtTpswOCANf?=
 =?us-ascii?Q?U9FjdwGD+gpA8KllmQS/NrmUrLPdFR+xNOAPKJaOo6tr6igRC9QBo+92Et2T?=
 =?us-ascii?Q?p8Y+QDuETRguGE6JR5l8esVWnxbCg4x1XcMmPozyLhX0rfyjAOnwk9+GI7Bd?=
 =?us-ascii?Q?cET2Kbgis0LrsuT2SqYwGc/RcKKB2nOormC5VuO/I8s3/Jwp/yxZU0R+jubk?=
 =?us-ascii?Q?Jc5hEKFFtQt2fu5UT9RGUDjAWiqhuozGrYr94JsY9XQSXteeC8bitHeYQXYc?=
 =?us-ascii?Q?wjtG7+q7C0cvqtRWRHCxq6sI0K3L/NfAjwANrqIYS75cLcjOO9Q4NeUhvXKn?=
 =?us-ascii?Q?vC+4NtVkqLYSHtkEWBpPC299ORj+iZCvgGZDGyQKUYc+pOn50D3r6PN6I3rY?=
 =?us-ascii?Q?3wZVihQLdf3LajBNelLR6xRMZnZb08t2Z8uGK1+eP1IchtHW5mTJQcxps0Z+?=
 =?us-ascii?Q?r4OpYdPvl7zLJns0tvXJ+lHhGNeIDTZUuYwr9WSfyq2Usmw8vdOlibOJz2hu?=
 =?us-ascii?Q?Rxj8R+q8gdAwfm8kjDmpNEBAmOvGGf6R+n7scbPP4AKYV3D9Hn2zciBiqGC7?=
 =?us-ascii?Q?UgSO3DjIRw9aZgl2147/5/qkq/lHJinvR2ZbtVJb6K09M4vTro9Zb85hrcvq?=
 =?us-ascii?Q?G7x8glVFCO15TaVrqjdeS37AV3LKi41ITo4JSbSfA+gvQ2EvTo0nDX2kINeQ?=
 =?us-ascii?Q?i0bdMzox05bcpab6TPN9Pse5YrwKj+M9bPVYIUM3vaRe8AOTOHJ5b1enO+3M?=
 =?us-ascii?Q?0Ym3H7gfPzpnsOSqZUjp7SlCp3IOyXFmneOObYvAWZ0fXrMELU09dw9N4Ec6?=
 =?us-ascii?Q?0Aimy7C2nvTY+uPTFEPGWidtM1ySh9qpSRs0ljNMYb8FB3TJra5hS3F4qAnS?=
 =?us-ascii?Q?hJ0ShUF8EklN1bLPajQ8/+AJuhB8BHHrcffOEAOM4mDFv5Q+26AAVVwTHOHU?=
 =?us-ascii?Q?5CAceC6bXa6fk7Zk6yY20cG6yMdogT6szOw7+gzTAEry2CkRJlyKjBt2FHot?=
 =?us-ascii?Q?ZY7tO9KNJgvKdLIGy57Y+savnO+Bgu353dScB9B0qhO4Alzb0yYjdfKxWqxU?=
 =?us-ascii?Q?XgIXgMl/pkiLtvhFSMgm0XkdtOTTyKkYfalt/xApuAh3SnhL8CO+SUoHUuvp?=
 =?us-ascii?Q?XqyVbKKIOPYXzMgidwS6RvO5wDh/pt5U++Ghl1jJ+dwg1TVXQM8xoA+L6w9r?=
 =?us-ascii?Q?cfGVLJJA05QTR8ICGaJRi0Rxjla3S1NlJzKThZqe17peYNW6JV9DawZBlsOK?=
 =?us-ascii?Q?wbiOMT5UMKydelYp92qphG2bI997HQFIr/jANF20b8gNqyrcSMYs0syg/iTS?=
 =?us-ascii?Q?pfWKVXZ7tCVq6uarjD4bng9piqb1EoFAenEm8l54AHUk3MtV+GEPOWW6ueZa?=
 =?us-ascii?Q?YlesK4LGxbSfPfIxm4Upx8hOLoSo8ed0iqED1kZBA/nsKrNsce1zUMZoqriZ?=
 =?us-ascii?Q?VvCy/oFwK1xriJVssvvbFQY33SQSbwKDopM8xM6DPEP+i4UYSBlmolIK4EJY?=
 =?us-ascii?Q?DciF6OEdRA3TkS+z/PKnfZR0DBclA45Np3A5R+TB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nxp4lnx05C2hkw849s6avuOKIluHezpGvdl/iLDC4ZKa6Ry7a3btzpkKLLOwIcM8WtvHN0jyQCWeyzDW/g4qxk8tJ5rMljHcmKFhktoP17/qI2sMDsQ9NtOHBlS0jlLEqPXA7+842w0Vu3EUCop2AoqYAWaec2pPC8DBWSRfbe2gnlhJvsUi3NvYinMwxVWIVQCvo3Fbw+93zXAGZ5BughA3NOVxJ5AWgnqkE8oC0YH+LuOr8a4t5IrbQ+eP8UBCVNXuhno5bCEnT9BQqTnnShu0eZhTBt5SNMvEuZSaL4fYQShegCaMwso9ekt7RHFNuW6HiJFnqtxkA/Iv0EQFzYvoRoG9iNshrs3ZfNJw4/UPAxGktKmy0oNdf6uSeUsteefTfa7c3r7JTWPLM+bYz2X0ai1RkVFOTuGobZkVA9bD4LLvsIKzxlY/E45xphRAZ2mHkOmcQPimpIEjpEFz9XUxcP4nYzawCBs+QmHvlzD1VaOsxDkz3lPW4Kim8V4dPBLVJw+QxkmZ7iaSsV/1TeAK+8z9pSFNkcB230jsqNfpxE/zJHUid6eTkCRTAbxOm5bHjqLp4m+SmDGik0ddBE93z/Wn6YzzCjT4CVcc46I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092a0348-18d6-48d7-243e-08dc2df049e9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 06:35:23.8152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/0AwOWQw05jiF5aYGHeUCAZu+74WpcqhH1ryN0AyiFouhozxf0FlZmt0dUwLYxQ7bc6h3zW2nH4z9lT7Yo5dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150049
X-Proofpoint-GUID: XEowKuDuzojl-JkwTC7YNmh0vf0dH9IC
X-Proofpoint-ORIG-GUID: XEowKuDuzojl-JkwTC7YNmh0vf0dH9IC

Use newer mkfs.btrfs option to generate two cloned devices,
used in test cases.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 9a7fa2c71ec5..8ffce3c39695 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -91,13 +91,7 @@ _require_btrfs_mkfs_feature()
 _require_btrfs_mkfs_uuid_option()
 {
 	local cnt
-	local feature
 
-	if [ -z $1 ]; then
-		echo "Missing option name argument for _require_btrfs_mkfs_option"
-		exit 1
-	fi
-	feature=$1
 	cnt=$($MKFS_BTRFS_PROG --help 2>&1 |grep -E --count "\-\-uuid|\-\-device-uuid")
 	if [ $cnt != 2 ]; then
 		_notrun "Require $MKFS_BTRFS_PROG with --uuid and --device-uuid option"
@@ -864,3 +858,21 @@ create_cloned_devices()
 							_fail "dd failed: $?"
 	echo done
 }
+
+mkfs_clone()
+{
+	local dev1=$1
+	local dev2=$2
+
+	[[ -z $dev1 || -z $dev2 ]] && \
+		_fail "BUGGY code, mkfs_clone needs arg1 arg2"
+
+	_mkfs_dev -fq $dev1
+
+	fsid=$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
+					grep -E ^fsid | $AWK_PROG '{print $2}')
+	uuid=$($BTRFS_UTIL_PROG inspect-internal dump-super $dev1 | \
+				grep -E ^dev_item.uuid | $AWK_PROG '{print $2}')
+
+	_mkfs_dev -fq --uuid $fsid --device-uuid $uuid $dev2
+}
-- 
2.39.3



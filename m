Return-Path: <linux-btrfs+bounces-2403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CFD855A7A
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 07:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FEF1C22B30
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 06:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8BCBA3F;
	Thu, 15 Feb 2024 06:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JwodZoEg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iX/REay9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A68D29E;
	Thu, 15 Feb 2024 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707978887; cv=fail; b=NLWUL0Z2oStYBclslYWdwN+inGQGmdeEMvm3lqmfFI/uJMlx7vDuiz2NV5wwmTkqIonQnQxudbyn1AesxSi7XV75okms4bsI6Din0rO1jZFwYU9hr80j7g0bRKX/yQ4hd/hngUst907m4HYVyUhoLt47En6mLryUhU9eo5sJOaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707978887; c=relaxed/simple;
	bh=8qH7eqC+DlCXH2A3jvJl0Pwc9BWJKUukvNjlwUtfcHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ABojN+wu4MzfZjo3bR18EgvM80WwY5kCEDIoUIJJBT9p4ycUPem7IE+oGWHSaVEZWQNCQJY3RIMM8T3E9CNilp4oSl7mccCLI4X6+I9yw8+Y5Y5Yf3z9juZtE/qoCvR49FMdma97FwsTFnR91EKKyqTXBRqHcqvGrfuSx9g/RnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JwodZoEg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iX/REay9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EMiB13014085;
	Thu, 15 Feb 2024 06:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=OuJn2UjbCB+KMos5oiMI31/TgYsxyv1SVRVELjOzD6c=;
 b=JwodZoEgZb8gKGUYyI0sIJ16oqcttAbjVka03/0h+oDr4d07z4DMa4bBrjyOYSWdxciR
 yKYX238F68GVzAXow7zkxdlThgfyleWvDO+lr9KBZ3Rvg7wQE/q8zvU+/gBa++z7tlOs
 uz9hcdCwE4GB+Ej/N5hJs4ymwoSutKSphwLLF1BlV+pXQTE3P1cTx6TYbBka35W95tHX
 1EWWx4ZoChR314pC5ce+Cygje2RILX9L7MzwvoGpij8ytEEi9W+BSgmaF7r+hZkFBBOp
 zoO6ipUok3TkTb9Ge1yVRKH6c7R1U1h3lKdOcYH304Mz4hmt6XAZKQL9v1XctYGl81KC Ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w91f01d80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:34:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F53gEv024760;
	Thu, 15 Feb 2024 06:34:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykgbce5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:34:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+Vc5HqFnMw+zeEbU4I15Xok/HOgqJ7Uysy2nMyPi0wLZmyZw2iS5mfcB3EmhrzVQGa1YoOapNHQi9uvtclkNnRlBX3Rb6tRZwZZMfGGZ5qCTzkv9Fvyj9e/b7+pihHrsf3xCjWPiIBZTf0XuKLoAWTKgX/8VVE9TAEOR06fRE4+0pFQujwhZ8oV1Jk+tjNVFlZwwmAh9yblUM5FSXiXL8YSwB7WENrEZFc8OHHvNKb3xYyKW4CL8WmrsXkAcQzvmX/YEljzsJhCKnSDzGIAJizRejGuUKehryvqIWSKfNBltZb19As2DrmNjTJdUJlfo/pB4jrzZspdjyuZA3wf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuJn2UjbCB+KMos5oiMI31/TgYsxyv1SVRVELjOzD6c=;
 b=ClUN8QLb47wKipl+9dPDtO/dUm875vqZeN+LgQ5rcFovwGaA0ecKFESt3F0ZiGK9pG2jERGsB/vlWEALGNuDPlZ6H9P03WH4NhTRAtwDKYOhMfanSwKUmiO9z/RykclHiZDArU+cHK+BagMLi11C4jdDO13EPQ9aT+EkakPg1Md0QnnVb1dDZjXWPE2IOk962dya55YkgP6vkRI9j8bpV2y7/63DvwUY00uSb9pNDW/dq9xCGSMegrKBRtl/W/ThTw1glB53QooEAvn7EIwVR2qHzXhv6qUqD188QCKUdJ8CGOIallVkVt/FQPS1w7HKATJiBVYxyjkA9nSjk4YeUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuJn2UjbCB+KMos5oiMI31/TgYsxyv1SVRVELjOzD6c=;
 b=iX/REay9VE3X+jgufkOqbuz4hWEKaEsnLyjeIYrHEKMV7PZyvpfT8G35TdYYGKzhbjhtv4A2UX1K8Ij9K3el1rI8c0H/kVufe6bLmRAJW6LLHmpi75bMjs62jggM/SqbxbaQIc7xYHkJFuyVboowf8ppMc9TFqrekfCN37LVJ6Q=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 06:34:41 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7249.047; Thu, 15 Feb 2024
 06:34:41 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 02/12] assign SCRATCH_DEV_POOL to an array
Date: Thu, 15 Feb 2024 14:34:05 +0800
Message-Id: <366147ad0c29a6e4d4e0faa60231e66b81c7d678.1707969354.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1707969354.git.anand.jain@oracle.com>
References: <cover.1707969354.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::20) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: ee02952d-6434-4582-a786-08dc2df03058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6xNwzhQ5k93kUVB3JtYckaAjcr5v6OZZYBoQ+P7JzcPMc6vWv4DtgNUTQgDHQbWZvclAAs63PlKv/NhL23Owmu5FBDTbh4iZpSXhgnuIKEWOxgamHN5tQKwrUH4uIMgGHCoSNoCiQ7++f7O47njawGSeMvnpUmR82IlI40cvYLTuQO4GHcy1UaRDPN7CTv6pl8npC1H/00CHaKi/J/+vgef9HO5hv2GTb4pYpRXUVdRa3hI4qbuKXCIUxLwejFkMQrz183KKPuMA90l5Zv9e6Q87Iyx3ost/2DNbg7OX9s7fLN02l/1ReBeK45ew3wmapFYoh/D3Upbmztg/dZZm3Oz2M2yag23UtXyA96AlghMRzDxT9gv0c+eq0VM7Q2J6lgGpb2O4tZU5OD7cIWCC0gdHnK3dHeC0ToNBwX8/bpA3T1BQO7F49bZgZZBL72Njf05f8rk1iMiPw6oatkhauRyK/28Mxd0UVbQIPbf/knpzn1IvE+eIBg6CzdYe2SrYzdL6zxWq2Bolf2OZ7X4NFh0A3MUeHk5luoDnmZ7Xl71xx13BEXqq4VWLrpLASNna
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(5660300002)(41300700001)(2906002)(44832011)(86362001)(36756003)(26005)(2616005)(450100002)(478600001)(83380400001)(66476007)(66556008)(6486002)(66946007)(6916009)(8936002)(4326008)(6666004)(6506007)(8676002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HT//jCf+QWF+SvRXmqdpBeB27HarHnTtlvc+8rpOUtRhBpDO61sZcnD58kJG?=
 =?us-ascii?Q?gnfsHxHqO5BlMIwWMBOMH4PXkd3FT/5twWDDntmxwMT6yIm9ctEkKcCn2Ee8?=
 =?us-ascii?Q?dvnRWnwHknr+O16NFNKdt5UpRgiFKDGne7MwDcyjcCrki1hzAr6Kv6m4hgVv?=
 =?us-ascii?Q?mbx4x9EqGV1GIHbF/end6mdwIE4ivQtNFTGj6Hh7jksjPvolBnSQ+WICgaqS?=
 =?us-ascii?Q?UEAAZjSgVjGT0Tcgx3Uj+gFPjuu2MeiKMlnvZBXVq2aL/oXkY/hgzJzEDUCk?=
 =?us-ascii?Q?uu7uTSVG5MXi3/QZPyBzM92e2XrY6ePE7fBPtazj1p+Ww7q4eBGgaWEmrDEW?=
 =?us-ascii?Q?/xeL/1jZ3TPskNXZs9OgPvjY2FdjqxLrKjKxmDucJfw6SrXVGsX4GBdC3bsC?=
 =?us-ascii?Q?jdBMAp+9H+1VhoTqD9mEgOjwNqNpYu3t6K2JxJO9kurNwlO2YyXgOi1ImjX9?=
 =?us-ascii?Q?T3PxOh44eYXX94mZeUENyBFTPgKc+rBYxuRf8d5aIoCHJVK+tJRt4o6WrQNe?=
 =?us-ascii?Q?EoRMEway3jHf49eFCM0dB+CnF6AvCm+z0zb7eJx789+6wO34fVAVxlbV9me5?=
 =?us-ascii?Q?rj1GwOnk46jFkl4Z2UEN2nNyYXxUsJBZ6nkzkWeBRLEyoC3eRJ3GDHGSvcya?=
 =?us-ascii?Q?7M0WCRYs4Cr1ww+KCymliwq8j51qVt/Bx219b36dBQjApZIMqPYWRdvsK2gh?=
 =?us-ascii?Q?nW5P+EL6sJgassAUSOsj+X9uqxLjY5eFJhkrmVSchbATU4gQIRceS8/39cI+?=
 =?us-ascii?Q?1gxEpAxKO72GDgBVECFoJrvSnr0yXKM7kk6KjtLEeqOU7CLT5yJffzEV3oo4?=
 =?us-ascii?Q?kKBXl4/eSVMnUr0yjU2LFoOJh8xjgKkdBbipFdyzVWp4bi9X1sLOJWQDBdII?=
 =?us-ascii?Q?bVPGVl4LL+xvhE8JnCW2/mPJ6dVwKsbB+KltsJwSOWJ96Lhw+nFskxrX7ued?=
 =?us-ascii?Q?U/O+RdcHpy/CmDil7GMYauqhawUhl0EDNtkeBpxuoDjfaU5x85yHGMbcvyEI?=
 =?us-ascii?Q?4lZqw7g6OQRS0SC/95ZuijlW7+qX2zLiuY4RuVOQC/fuG5o2R9+Ug1DY79ZV?=
 =?us-ascii?Q?LOKb8mXfSC0PtJd4rvz6wGLJWbFGgNz1tztw8EAWj3XwWNpZXQT6wkLrRG6T?=
 =?us-ascii?Q?97A3WjrLvmoS17DROmA4jxsa4au4xP3WAnrWid92txVzb8qX165byoDKSQCI?=
 =?us-ascii?Q?sDOHBF9B0EBFe8eJCR5LyDUCP2wFuJpFWRcdtEDtNePUHvOnfZGLO8rMO88d?=
 =?us-ascii?Q?tA4fYGI7e+gtx+pdIWQ55dFf3+MEj/i1Qr1hSwSZc/mFU1zHaHdLIHg5sTfr?=
 =?us-ascii?Q?/tAB/buDfux2V3K2CW1cDC9QyK3DuE+pPWyBtA22HRUvIQep72ZRe6BA7Vsl?=
 =?us-ascii?Q?c5gLy4S47TpzvH+uvoTdKP5mkeOyscT8qnedYUSn5NxeCwgEtkoUOzNDMjiV?=
 =?us-ascii?Q?gazTvGSEe4x1M/g6y5ENMTv+7eUREGZ+TQwpGOSiS5Qis0ssiAzUJOyQoXJ4?=
 =?us-ascii?Q?LSn8aytDBRlcSwvnK7odFgQxuFh9aQRiO0aAXCDIQkajoF3V1qsMEtQaGd71?=
 =?us-ascii?Q?Q9X0AZsInmrC62/39iaXPeOwoBpKa6NqGg3wcoUU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QaGHacR+Wvb/60mXysMC0EMXPuZd3j8JPsuFkCUE66e7Di5ZS4I9I8hpl/WhMDClZxTOWjYALXG6X0qL7ChqBCsm/ZZuLTVlL4t2Ez4GnKFb83ZZq1QFY+9CcL6eOX9bOXvFlXWZ/qNADarmj9g6/gM9JS9jFSzbernY5FiEIyRoPuZgVIKSgeOoE1sUW8oft6GoxzF/SPwdAd+4QQHDwaCKbCisLivtTfO8lgMLVKTC21TV8kP8HmeUCLdgL+q1ySIah8BYi8KCqnmk6P2oIcvpnfldPxlu3bySXYBGxCJsqkcxrFxgnzhLj3a9d35ZupOexmNo3m2RU/27dA8Lw/IoUrkUUrKWg1F/DT57t1xZEVRQyBrFB8gWgnad6VaTeqmJyRzS35c2CJe8lr3dgybLukotY0hMNXXYciBhFHPiLIAAkfYpoNGf+Zd+lddZPR4ucjIGTuiYLR9nWvNCTkyFjDNOfMC0BA5bAm16J29EFuFydh78NipWuRqJCnPv0xhtq74MHAVZqVNyt/vkZO/J1PlMZKOEboskqwR0kuvWzgMnQMswxuBi4D7a3Sv3hOoqKS62JSxOVFVak+di/QCe/2LbCq7/75JuPpvhWBU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee02952d-6434-4582-a786-08dc2df03058
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 06:34:40.9521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QG0RPSnazXxEt1uabNXdxI36EOnVmnvUotY9Z6bs0xmHVjXgJ4AMoj9aLncLpsRF/FsnV5EG42WropZfu3Atjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150049
X-Proofpoint-ORIG-GUID: 10_e1B28NBL1Yex49BmSZ7vziX4Gf_Iu
X-Proofpoint-GUID: 10_e1B28NBL1Yex49BmSZ7vziX4Gf_Iu

Many test cases uses local variable to manage the names of each devices in
SCRATCH_DEV_POOL. Let _scratch_dev_pool_get set an array for it.

Usage:

	_scratch_dev_pool_get <n>

	# device names are in the array SCRATCH_DEV_NAME.
	${SCRATCH_DEV_NAME[0]} ${SCRATCH_DEV_NAME[1]} ...

	_scratch_dev_pool_put

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/rc | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 524ffa02aa6a..5e4afb2cd484 100644
--- a/common/rc
+++ b/common/rc
@@ -830,6 +830,8 @@ _spare_dev_put()
 # required number of scratch devices by a-test-case excluding
 # the replace-target and spare device. So this function will
 # set SCRATCH_DEV_POOL to the specified number of devices.
+# Also, this functions assigns array SCRATCH_DEV_NAME to the
+# array SCRATCH_DEV_POOL.
 #
 # Usage:
 #  _scratch_dev_pool_get() <ndevs>
@@ -860,19 +862,28 @@ _scratch_dev_pool_get()
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
+	if [[ -z "$SCRATCH_DEV_POOL_SAVED" || -z SCRATCH_DEV_NAME ]]; then
 		_fail "Bug: str empty, must call _scratch_dev_pool_get before _scratch_dev_pool_put"
 	fi
 
+	export SCRATCH_DEV_NAME=""
 	export SCRATCH_DEV_POOL=$SCRATCH_DEV_POOL_SAVED
 	export SCRATCH_DEV_POOL_SAVED=""
 }
-- 
2.39.3



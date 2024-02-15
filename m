Return-Path: <linux-btrfs+bounces-2409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29601855A80
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 07:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8201C22892
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Feb 2024 06:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE227C15B;
	Thu, 15 Feb 2024 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GLp2k/YJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P5cD3tdB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C69476;
	Thu, 15 Feb 2024 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707978928; cv=fail; b=NCdtOmu8HB7El556yGi/G5WfzmEa/JhWwu+44n932+64jq7iwKccjLQaQCrkga7/F28UgR9jSsoRy5lM/WzPl8muXpO3fO7OMWQhjqEKwg0DWsHrxvgOsFVVvYsn4NWCHnLunkIch0wkHI3RhVdTeqSFCuvewCMe9LAskUgj460=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707978928; c=relaxed/simple;
	bh=vcd8V4srDE9R+U1Rlb4pSByIK7oNJ6phKlsLLe9QEkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=evlxRChaTshD0IbEEE68ad/jgM1zDcYJuF8jT/YbvWYTeaECL8g5cwNilGy+3r8buQOHzKVcmfS6NsYaoFxXnni1FhtBc7PEpB25m9RHkcARNfMoDW+TrbOHlpw7Dp7YUfEAL+yBPhOlaymmo6O0o0mATFqIHfVxJ9CT7NfpFxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GLp2k/YJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P5cD3tdB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41F3MvJB030752;
	Thu, 15 Feb 2024 06:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=GGrBqCPJLTRmKIFT5WzDeLEsL7OjpyPAv2d/6LViwg0=;
 b=GLp2k/YJiUv6cVdvyocXYaziJlX09XGTOuKkeYXO/8yVSbCh8+sqwvkBWdJd36++6oy5
 gaFxYmkoomW9KAaCJTSl6dBEEvde6gef/DpnPnb4qREQWGResdxdZZR0S1aEVeMMt1qW
 wmdAfoLGF6oQTtBbHXDFwGBhto+rvl4p9/KCHN76DPWuh44xkZfW/Ad686Zp3y35EbDU
 2IyzEBk7oDf9Vpa6E/Oh79pqDdi0w6KLrvoN71UTgby0Swr3mEWsHn85LwrtcCqHgQRP
 JRDRaihm74IvWOZIjR4TNwhsSWjDrDLOEo0I9hzlmqn8vMh2GBMfsfEIrMH9pq4wC79n dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92db165x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:35:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41F50lSD015097;
	Thu, 15 Feb 2024 06:35:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yka290w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 06:35:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNNWCHp6tjqfDgcPupjMUozVOJOuyMRiHdkCBer3Qq7XlRtuQ2BbsKZ1UNwNXw/WjSSt/FSY2CFyucOJMjwSNBmJ0kjIhuXMFYwDGQlFKWcZhh92rnLurmufAym0yKa6XRd51YCDWCZ6XCtJWPDiHJsqoLRPCU7GHFXNf8cHl3a41BXrDrFZpKl7cIxjkTFk9qC8TXREPIHsFYNCqCQbN+qBgU/2r2iYRYh4ZDf9czrLvKYVeCz/q5EnHoWgKDmmAGB0ySd29SzQZjqXlo8kM9LPcMXRpNv8NXxaqTvWl6x8ZL2XleiRYK3F+F3JiKC7eqwIALYlEiu5/oZhp+/8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGrBqCPJLTRmKIFT5WzDeLEsL7OjpyPAv2d/6LViwg0=;
 b=XGUzyArtenRDCQXIvlr+oQfcPViye/Y11BVqGVrxbk7jj4TJ602xErbFxLrBZkVhkd2DX3DvzjaGqEiR9YSt4TLwERaKqlndNw4ymNGuA8uAdj7YFAn8a4E4dEYo9rem39Ar3KDU3XbHOlPYIkB55odEQS/axa8bacDXyBURGVsGlslSyTuX/TvsroXcCtnj72fxLlprqJOzg3kGfDUIImfQcDc/mEMxnMWMRnrfZKIyus+QYAHNeA1QrmnWnNYhFkmSM5RYCq+5IEgJSSS+pS9cEA7XQQmPrIvEU0lo/48DkTUK9mcnvp1F9scc8xWSts2SsD76t+TLTEYGqpi+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGrBqCPJLTRmKIFT5WzDeLEsL7OjpyPAv2d/6LViwg0=;
 b=P5cD3tdBM5yY4+N1XVUuXAqTG1bJHqIm+Yw6zaMK1t/Ao1E2tPP4bWYH2wgq/CRUvkFHtHBY5W/SPvMMozZ79xSjru3Kj6bU6tbYGf/T6z0IEScf5CjOgyKz11nqW6xtHbcY6Kjw3KxpCzz6rk/xNz4hLJDMXlDVTYG5QOdseOU=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SJ0PR10MB4544.namprd10.prod.outlook.com (2603:10b6:a03:2ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 06:35:17 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::8711:ada3:7a07:ec85%3]) with mapi id 15.20.7249.047; Thu, 15 Feb 2024
 06:35:17 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: [PATCH 08/12] btrfs: test case prerequisite _require_btrfs_mkfs_uuid_option
Date: Thu, 15 Feb 2024 14:34:11 +0800
Message-Id: <4d9c26252329f9cbbe48a77c58e8ff42d0b45275.1707969354.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1707969354.git.anand.jain@oracle.com>
References: <cover.1707969354.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::13) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SJ0PR10MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 8376abf3-da90-437a-5410-08dc2df04641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	q+FwmJ3VAF490y5yBedKK0HxKf9cIW5VXbXqMQEu0DPGxx+jaC6y/CXIYSDs96QgHMsLx30oZty/rfDmVVz+dci0TsOGr0FDR/D2oBqVLdwczjcYn1N30AtUGq4stRNZQ8mEJapZPdXvp3m0T9hlXs5Le5syRbkwT/nMAEdk5a4CajSH410lwwtlD91Q3GF0l5nWVDYMG/7ooHNAanmOhySEv40ikT2BIRdwv0+SuUL3sRwCvok4ORhS0GQkF5nl0rDLUNyR1qGdeP57OaqoBVMGHEGZyKPY6U0MKicYehGbDYrexMdGbEN4sos/90QKH/0RJvSqMcNrm/BW4Nf7ZOWCxnS8pHcyCax4gyEtEe0bkab8nl0/EehJL52FbUTQqIyvoUNKwqIu8+GO4QKgmdfhgwAO65iUA+RUU2MRG4vpbkkvtoEt7IX/DNTq4kiXU3CGK3noF5Iy909GKguXpUVc1nESV6jEekSTHY5uMt84jp6vUkH2ktLEcYfmFeFmCFxBIkMyc1l8EGUwW2n2rETLuzdMnbjUlDEGn5pveU4ps+poz0UjyKtsUf6CS5+L
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(316002)(5660300002)(41300700001)(2906002)(44832011)(4744005)(86362001)(36756003)(26005)(2616005)(450100002)(478600001)(66476007)(66556008)(6486002)(66946007)(6916009)(8936002)(4326008)(6666004)(6506007)(8676002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uvAWFHR/Ky3eDfmWqP+MPC3vH+F4s3RhbceSgw6jiOtaqPF9xn6gYISGww17?=
 =?us-ascii?Q?Awab5AmxQcnEpY8VuxnxjFUyGEL96sMIP1eJPqSx5w4c1uUJpQr1+oQkENcK?=
 =?us-ascii?Q?ANF4RGpw7uMRszTUtI5AT6EdFO7tNY2H2LokRc/HaJ8Oco7cIh2ZV5I2m3HX?=
 =?us-ascii?Q?MESOeet8sJDzI1pw4Woo1wmPErPys8lTbrCaFNwuTBWoxTM4kZ5LtiYa9zhs?=
 =?us-ascii?Q?2SaFNI8mArp5UVSSmyhU0PC4zDZ1W9zNf+QbDoPWEGJag/ahMzipT5UjLTeE?=
 =?us-ascii?Q?WtIhQP1BvGDYx0+ddtdLbSYTDTDaRnMFqSkNO4CnkIfIOksd/reez0mntqc8?=
 =?us-ascii?Q?rOdddI69jwfXxvYZttakgzVrjJVF+HIxNTA7Fzv5e40bH6fVjPKZMwKPok2L?=
 =?us-ascii?Q?aC3QCO9DWCPpufdE0beldDR+EWbRIfogmDQt6qO5pIpmlJfw92ei+wtz1Hy4?=
 =?us-ascii?Q?eVhgthZYxORDxz8gNw4dj9GNZuZ6WV+J9HEg/73Yu7tmf2t0yH9TiIBa6mhJ?=
 =?us-ascii?Q?j/D2WBOWQAOCpdCC8IUhzA9pVlUhj5i8Kt8mgHkf99ZWg1urqzb/v9TN/Kw4?=
 =?us-ascii?Q?5lKXaX6tWSfjDBgBGlTVpdOPXZoQqf5fh4qF875W+ci/wDmv9DRcKin50d3B?=
 =?us-ascii?Q?mIVyPZiZXR1iORlU3nbGFaoZJNeC0Ug6siNm4o7sbvUwBbSui5F6mA3gPzGK?=
 =?us-ascii?Q?Aid31BLGF5XAgNN1EwdQTaIjADWEgWTDnpRa4ycNdFWrM5onE3gHosoCUHn0?=
 =?us-ascii?Q?4W906ShGlB0JzPQmuIL2fUfqch3uzBg8h0zEirIYz8KYwJEw4JazZcldyMsw?=
 =?us-ascii?Q?+W+1qncJV/Vi4CFGOK8ZlfPm2YEdxjDml9TNH4kBLxmDSuY5jZ6oXMl97nW5?=
 =?us-ascii?Q?HlGLVahTbA6EWwJ4nIePgAEYClu1KAR333HyY1FovQ/jQ7TWnxh8lhQtdRZT?=
 =?us-ascii?Q?g3eZti8N8ooGaVnE+7K8fUJ333ci7ZMfjJATjonBBNcZpT8/0nfH5fi92tYS?=
 =?us-ascii?Q?hZBmJ2yP9M202ETJsXGyEXUNrS+2g9fQcXjIht1dSCYxUijwSnBle857G/pe?=
 =?us-ascii?Q?b+mNijzmirRcD7XSHM1Ue0zIZ3ebyD4oBHcJs8oclL1tPXVJzIgi6hJlVsxX?=
 =?us-ascii?Q?1E5TrXfV/vpOHD/R+AOno7WDt4kNqOABUTJxxKVIarcU62AjHUMHUebsb2Uf?=
 =?us-ascii?Q?HVqjbSb0Ij/l9q+Qc24yYt+faMwGN6lLEKvHscS+qxA9yRpytH9O26d9Ji8r?=
 =?us-ascii?Q?sn9ytEn8fTWHv2nORMp5YXacTyHhcXeQs76R36gPDbC+q7uZeD3IfbKL5WF5?=
 =?us-ascii?Q?t86mDjg667LAZBYgnxFgFAC/MIx3syfPlRCfSpEJT6curA87sCpjUIEHFi/9?=
 =?us-ascii?Q?MJnvxBYEzd9yuzEjM9hJUgtTZsUthltqk/9P/f9khg0PeWzKrfPu44BjVo5d?=
 =?us-ascii?Q?t2ynEi4csFF9Lkqv02zgzwdomNnMdpr/F2RmAm16Abcmr8NKzp3uUrSNliOU?=
 =?us-ascii?Q?T2MG+c1WUVCDHWOwzr+R4aqp8Oqfl+sTXEARaAspvh+EZ/xwl1Eltskt+dmB?=
 =?us-ascii?Q?KyjphObgMawWgFX2t3pPoorwAz4s4k0RIrXt7sPo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	oS3KBWyRGc3B7kC/qBbpscQIq09DuETRMATEgw72m743gm77nRUgPLpRR7qLBu+tMFxc/u7/9LmifEAvpybLPLzcfJtXxtkuZ2GpN9jnqFqLZ3q8Z30J2HsxiiaqERG9KkWOY6KernQtRv4SDGHteurw3oAIJ5khudW0u664PZt6DxizhH1IJzHNCy3Sz/nrV0oYGZv8SPr4x4RXU2hMeXmbUWmVNqD9rBiUO+6otc6BfiXBZtiaHxgTfw774sjkGX68WC2ZSm4m9q05qs9LaHzKY44EX9Qfl+L8+ymIO6F2MzRCyDec9+Zi0il3WL6ticazZmz1zmi/auBO4v9EjUoasz2PwioAS4WDBXFgp1Ldg96A+9WDGKV3bLpnWFvLhk22Nn/+uHHpcMtZhl+bogdz4T2NG5PxRmU/EVav1Fc+63nO0OxbnmgTf5nWrNkhIk4of1I7xCEMaiQkLPBfhpRato1VidAjCAkZE/qz08119MhAsiBDzKJfRTOM6fTYHR42KH/t5N+akJ0Y6tjA0dM+/wuKJ7440fUEijBRQlke9kSq3+rNo7TX2bElwsbpmR/wA5Z5AqmrFXJEIX+26LoxDPQPQut6ca8FK/61dJw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8376abf3-da90-437a-5410-08dc2df04641
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 06:35:17.6626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vwokzPB3Rau7fVkzxntii0aHRy4d5N7BxlWjIeNLthI+dSf0ubaii9ctkSOnfwqdt6B8KTZZ8Tg0S4e3JOCGuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150049
X-Proofpoint-GUID: bwdC5kTz8TBh5npYa5sC8P61Gh26vnPs
X-Proofpoint-ORIG-GUID: bwdC5kTz8TBh5npYa5sC8P61Gh26vnPs

For easier and more effective testing of btrfs tempfsid, newer versions
of mkfs.btrfs contain options such as --device-uuid. Check if the
currently running mkfs.btrfs contains this option.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/btrfs | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 61d5812d49d9..9a7fa2c71ec5 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -88,6 +88,22 @@ _require_btrfs_mkfs_feature()
 		_notrun "Feature $feat not supported in the available version of mkfs.btrfs"
 }
 
+_require_btrfs_mkfs_uuid_option()
+{
+	local cnt
+	local feature
+
+	if [ -z $1 ]; then
+		echo "Missing option name argument for _require_btrfs_mkfs_option"
+		exit 1
+	fi
+	feature=$1
+	cnt=$($MKFS_BTRFS_PROG --help 2>&1 |grep -E --count "\-\-uuid|\-\-device-uuid")
+	if [ $cnt != 2 ]; then
+		_notrun "Require $MKFS_BTRFS_PROG with --uuid and --device-uuid option"
+	fi
+}
+
 _require_btrfs_fs_feature()
 {
 	if [ -z $1 ]; then
-- 
2.39.3



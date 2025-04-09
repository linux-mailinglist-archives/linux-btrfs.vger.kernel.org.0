Return-Path: <linux-btrfs+bounces-12900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A63A81E8F
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 09:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8605A885CC1
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 07:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A5725A65F;
	Wed,  9 Apr 2025 07:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Irn/fuLi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yhIkljb6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137C825A33C;
	Wed,  9 Apr 2025 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744184680; cv=fail; b=uFW43ZfLjqYhu3ah7/hZ3IjuhBuSTBSjf4vsTLjz29Z+tiuInqMf0YUnNLINHfqOlFbCJhOargxZoWXa2vdazBK/uhGdzDnKEqRPx/zf9geWwtEhpR9rc/ajK1YUevQsPhuvgrJNeocKs5rFohPk0dIHQ0aJhhNtPn3g6cyaVTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744184680; c=relaxed/simple;
	bh=+9gCX7eezN35AddSa2I4yxvJ2L0gtCx2ioQRHGdOVz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iq57Zvb15L40adogeMr5mm684zgZaitCAstbasswysQrLy5bFgRT4XZabuDnQvVxlUdfK/Z3ZvBFQ8J4BHpOy7tnaAi9Jli7YMV2BEG4NFXN/Tn7aeJz2XXXpUvv9FW1HkI+Z9IWpGd0+X0hREOAvpqzXJywbIcLVN/ZHbUbE2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Irn/fuLi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yhIkljb6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538L9mAh005735;
	Wed, 9 Apr 2025 07:44:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mejIsCFMTDYGUBszxaDW0DJnn6FnvQaVOP4Bnjc6Spo=; b=
	Irn/fuLiqYnK84wlnwhizgew8h2dZQ6PbqOovwJ7oXDuHKxjFRA38mgyuQ6ksVJP
	8+vrtHJztXusMc2kvlqO+AHy7yLgKkTJTpxiQ72Of9dQ39LxDQeE4ZkWqmWvuZnc
	7IeOy9EsojKzTdY8AH4q6NXZLF5S8xfUrZPrYk0J2hN/qVjM2fEPJfaZVmzZfJT7
	lzIz4wbs/mOnCKyXaBYBPCck5kFubhJurhzI+JAvHMJVwEF92p4UGsnarb/k5Z6C
	wqysZUViyNfE/PIa4IpUfrx4REAWwl1EhViliURX3vrNjavu3EBK4nq2YzPGCJsX
	BSjxBq5UePPGN/ARg0cgqQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tvjcxgw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 07:44:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5396qA2A022488;
	Wed, 9 Apr 2025 07:44:33 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013061.outbound.protection.outlook.com [40.93.20.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyb6dsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Apr 2025 07:44:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QYLmpkg6kwvSLxm01Xd9kS3E5+dKn/QPrrcLIB5ZKpPQo1GICpf3gWSCY+9lAD27a9TtNVoVDA6N4woM6RAhzmQmr/MabB737s9RAs+9P4jBBdoD6V70c3+8riUv1tVMq6X0/FH4kn/GXmY+O3nR09z14WhjS/Ld4ZEsIysofnSW8eYC95SY5fseAikovcz6hHu6JdkWt5noh/DCNaVaIfw4qRYLKZkDBhsDS+bHVJoQuJibJz82pAv9eOtWs6bSI3sIfDURfqSAc0ZTtC7886T6pCc52gITwSeCpJh85BXgAbf7sZ4P1UfboQdEFVfTyZ+98DlZ/BH+Bm8wBHUkeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mejIsCFMTDYGUBszxaDW0DJnn6FnvQaVOP4Bnjc6Spo=;
 b=OJnqFvZY9I1a8b/eLQNR4G5Chif0N8EIV+6ZUjtqL6inYasITT8EX/qDQJIEgEMuwHdmpsz6n1+PmHnW940WfhmOqkM6KyoihMImSYdazH0UrcaYUqYQu9C2GyEp5a0lgzt7aWbZyj+YBmUHjBGxOirLWSOV6jOXmhbbKuBUKI976iGDftlknGx4TIUa273uGJRzOgDhiGbuspQuCqyzEHaVv7/2hzbXUfJmaG/WqVXAFWa8noNpsHCb97buN7Lo5Fcz+sFj8652+BXzuaXuNhVPCT0wDLQxljZwtCyiGZIEiRDCw9FtjdbdIQz9w5ZIiaV6mMruy5ipy6ogxk7Oog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mejIsCFMTDYGUBszxaDW0DJnn6FnvQaVOP4Bnjc6Spo=;
 b=yhIkljb68PqcC0bbuy8/Ltjg5UmVKse4iFrtnoCOd8LF38mpuw24HLy0YBWci/NTyBPqicObGGJ5Rj4I0S8rIjCq7305RgfY/ejbRgoP1yVu+MVS5sQR7KddZRlF60qF6SATNE/+XBNJCJzxDCKxouJXPSgb0+ixpab9AbpBVzs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4393.namprd10.prod.outlook.com (2603:10b6:5:223::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Wed, 9 Apr
 2025 07:44:31 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Wed, 9 Apr 2025
 07:44:31 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, djwong@kernel.org
Subject: [PATCH v6 2/6] fstests: check: fix unset seqres in run_section()
Date: Wed,  9 Apr 2025 15:43:14 +0800
Message-ID: <12a741fc7606f1b1e13524b9ee745456feade656.1744183008.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1744183008.git.anand.jain@oracle.com>
References: <cover.1744183008.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: c2106461-236a-4d8e-9b7a-08dd773a5d11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0ljeG9BaE1yQkhQVjdRYWtkaDhZTHNCSHBnRE5tNUVMMDJtbGxwcUcwUEFx?=
 =?utf-8?B?WmRJaytYRHM0V1NQUWk0WmIrOGdNTGd3QVRsam10Mk4zM051VUtWL2NKYjFt?=
 =?utf-8?B?dzU1cnYvcC9LcnZMUkM3enZrTDZsYVZQVTlFYWUvNUVrTjhsM3JJTE9aVFJE?=
 =?utf-8?B?ejVZbzg0Wlptczl5dVBlMHJidzFoYTg2cVZVR3VPelJsdFlUMWk3K1ZqV1Av?=
 =?utf-8?B?MSs0UURONkY0b3RuajNlU1lBWkZ0cEdDTXkxN2p3ajFybmhCNVFIbm5vOENt?=
 =?utf-8?B?L2tPSlovUlRkUm96Q3ozZ0F4NFgxZnB2dnFUd3JNbFpQMHhWNit0M1hpd0ky?=
 =?utf-8?B?bnVMSzBRVVNteHZmUDR2bW5kbDFsK1JmNWJnaWRudHFFOGdGTTkrZUNBaDBR?=
 =?utf-8?B?NXY4a3Q0d1UzZ0E0WlpiNDk3MisrL3pzc1FFNVVZR0hYV2sySHBtellSWXFI?=
 =?utf-8?B?RFJOM2NEblBLZmhMZExQN1hCSmZMSEV4dFJML0ZOQS9kbE1ha0xzb1hTMGlU?=
 =?utf-8?B?aDNZb09USlpXT0M5RUkzM1JrT1lWVUtFa2JYT05Ydzl1SmpYMjM3SDcxKy9u?=
 =?utf-8?B?TTFCaDV1V3creStoRktveU81Q2JhSXBOdGtHbUFWYlRaOUdrZllPUko1WDdw?=
 =?utf-8?B?aWJUQnBsamlpMGJoKytCdGw5N1JOYW1zVW5tamt5bmFyWFFBZlRlQ0xHTkpv?=
 =?utf-8?B?aVNYbFJFYUJKSHZSNW1FU3pybmZmc3hyNGFaVVM1WUZkalRlRkJ2MDdZNjVu?=
 =?utf-8?B?bDJyc0tSM2h4RUlFd1pOeTQzVVB2N25yZmU3MmJENGt4N1k5R29MLzRta0h6?=
 =?utf-8?B?UjR5TlJzOFQwLzh0cWZQcUlNd1JVSFcxdEd2a1dhaHhieGQwdUN5SkxnRjVn?=
 =?utf-8?B?MWVvWXhFQ0pheERvU2tma1Vacy9MTUVRangvN1RlR3Zhc2VhT3gvYndidHFp?=
 =?utf-8?B?L1IxT2paWFZONjFvNkVMYlFJc2RkNURaVVBFRU85UTVuUGpGVEZSUUptMENM?=
 =?utf-8?B?UWFvWWhwVkQvbVo1U08vN0JvdnlxRE1CdUIxNVdNcjVPVVFKenJ2MWtFQ2Jn?=
 =?utf-8?B?cUdlRldrZ2NXM09vcmFkMWhjNkUrSXpycU9nM25iR2x5RHdjRFIyM1hLcVRu?=
 =?utf-8?B?TUU1SGpLL2NnSGVETnFHdDlQVkdlbThOR3Z6TkRyUE9kVG5wMG1MT3J6ZmdX?=
 =?utf-8?B?OEZKcU56RWU5dzcrS1FMcm1oRENaQmtVNkgxeDAzblNUV09SUm4zNEJ4bDZw?=
 =?utf-8?B?NDlNY1VjV1JrdTFkeERFNUtIMDJmR2s2VXV5ZkJsbTZhWkVuZHBCajI1NUg1?=
 =?utf-8?B?SlN0a3RqTFlab2tVUW1CbXdlcUc0eWp4b1UzQ1ZaL1ZKd2NnYkI2K3QxS2R3?=
 =?utf-8?B?d2JxbVBsNlh1cU5JemZpeWFObXdJZStUd01BYVZJSzZOUEZBcDUxWHV1T3FK?=
 =?utf-8?B?bFEwZHp0TVpQejNiQmdmTmRzREp0K2UrWHRYakNtV2xpN0lkL0FKMjMxZ0pH?=
 =?utf-8?B?MFM2VUdSaUZyTS9jQzlzcW43RDAyT3locWdmR2tWSnRHS3doa0NZZnpUWXVp?=
 =?utf-8?B?Mis5RjcxalNMM1MxWC9sMnR5NXN1QzE3V3NJV1VkcGhJTTNYdEtsdG1vbzF6?=
 =?utf-8?B?VFIvMml4UVBMRCtCVkZyTjVDQ1hFTGZ1dVRIZzFMWEtqTjRQSnAvdGxmVDho?=
 =?utf-8?B?Y2MvWERZb1FXM0JnZDRIWEJmVDlOSjh6d0ZEMkdnc3hqd2Zqb0xTZWhJd3pt?=
 =?utf-8?B?UDY0YThpbUhTVUFkVitZL2NLeXhVUjUrOEtXRklGazhScmZjank4ZmE4WTAw?=
 =?utf-8?B?MndoeHhTSkJkTWtzdHgwQldzVmsrNGdLMmt2RUlpdWdmSVAydUxlWlowOHJR?=
 =?utf-8?Q?++1yMwYQfNTyw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0RKek1DeDBxczhWQ3FLcjhhZUF3R3Z6dTFnYmpFaDBwbFA2VUdDRlBrSFRl?=
 =?utf-8?B?UVFGdnhwbkdEMjBHZmVXWWxDM1hvemt2RnQxWDhUVGhMcDlldE15RjdSRTVG?=
 =?utf-8?B?TTFGL3FCYU00TDI5R3c2bzYvb1dtWVlUL25mSjhUTUNZYWRsV3Q0bXNNbUdU?=
 =?utf-8?B?a21hM29oZWQrZTdneFlKUC90ZGo0eU44bXU0WkVRMHcwc3drTFpxSWlna0Rh?=
 =?utf-8?B?emIwM3ZyR0gvWEd2TFF6NHJ0V2tLQjFoTkpKeGRCSkZjUUtybGZYZ09JU3hX?=
 =?utf-8?B?QTJrVmdjQjE0eHY2UzB5VTVETTV4cGR4bnlBdGhWa3hGelB2NFRjL1BVOEdJ?=
 =?utf-8?B?MzNJVExaaTArTWpySS8wdEZ2dnFzRDF6Qm9mQlh0eitoRUtoT1I3Z0NSeU5X?=
 =?utf-8?B?UHA3ZFI2RlZrZkJETDZ5RlkwbEcrYm1Relh0QVRpU3QxblI3blJJY1M5QXcw?=
 =?utf-8?B?NTZGbHhsYnBuRENjMWhtQWkzQk11dVNUYnkzQTlaWGpzV3pIdW9ON3FBZ0cx?=
 =?utf-8?B?NnQxWDM1U2RnR24vMDhDekx4SmRvMzNMODR3S3JPb2N5RDNuVjg5VXVLUGp4?=
 =?utf-8?B?NWkrMktlMS8vem5ON1hOS0FDRm9OcFRZNXlyejNvZ3h6ZkFsUDB1YUxQeVNq?=
 =?utf-8?B?b1dDSUxyZEVhUzBIbzZvU2NiZFJ5bGJCajljdDVoZkp4YkpUdFB1MjQ4dG5q?=
 =?utf-8?B?QjR4M1U4VmZ5djVLRDhvRmtFaHNpVzdGRjBFWXVRcnlCZ29ESWtmaUQrNGEz?=
 =?utf-8?B?S1B0d2hzV3oxcVY4bVo1c1Ruanh4U1A4ZVhFclpQTzFCNVhJNUFRRkhDdFFZ?=
 =?utf-8?B?aGMvRGs0dkNaZkdHaGpBUEtQRnFYdFNSc1BGWm92VHRjNFhvSVNJNXFiOGlR?=
 =?utf-8?B?NWk3b0R2cC8xVGdIYk1qOFFhUFRGckRsZnpMbUErT0xrMVV6RVNxT0w3QXhN?=
 =?utf-8?B?VjkrVGx4TDhnd0NZb0Jid1drVkE3Q0ZLeHAvdUJDR2xiT0hzNmxrdG5IV3ds?=
 =?utf-8?B?RHZ3Um0rbnBCZkMrWEwyUkJIbE4wcjBvemoyVzdFM1BlRFZpekttcWw4WkRy?=
 =?utf-8?B?S1NSTEl2SHZmNXJKNGNBS3dZY2NyRTljTTZ5T1hyK3JJZjM2UEM2TnVScE5w?=
 =?utf-8?B?MU5uREZaSTdiTjJZNXhjWm5FUytIczFZZ3hCOTV5akprTE1Lb05ZR3RBb2xQ?=
 =?utf-8?B?dzBnR2V1NUJEUDVGcW0zSVMzQ3hKdDFDUVpGUVdCL3NsYVk2WklpU2h3VTNU?=
 =?utf-8?B?clZ5VVNGb0ZuWGkyMWVhQ3lxdDdTN3M1OFNEYWRGckVRYVBzdHRUTFllZTZQ?=
 =?utf-8?B?ejRCOU5wTkQvZm93cC9QbGxnWG1sTGxMS0lKWkZqK0FpaWd1bFhDVW9aNklw?=
 =?utf-8?B?bkRNeUtGNEF5MkxjUWhieThnWDBTMlRRL1hNT3MzWUhPeUc0cjNNRUppa2h4?=
 =?utf-8?B?dWdnQ3NwZXVGOU0veW1kSDQ2RWtjSCtJTnI2MlQrb08xQmZoT01pbGQvb0pE?=
 =?utf-8?B?TVg5TmhOc3BXRHZadDdReXBKcTdiUGdsOTBMMjVrckoxeWtHMElYNTk3ejZ0?=
 =?utf-8?B?NUFiLzR6TGh4RmR4eDFiTWpkVDBYSG1iRlF5UVFaU0hxRHpVZ0pEZGE5VFFi?=
 =?utf-8?B?eHlqNEl5UER3L0dBVXNQS2FudlVZdEQrY2JXRFZlSVpCbUViVCtRUU0wZlE3?=
 =?utf-8?B?SzBGckZQUUsxQytnSGtkRnEreDExdTQzTHg1NHduN3NrajRJQVFXOTE3S0Jy?=
 =?utf-8?B?emVvdDNEYTlnZE13KzlLU2FMWkg3cDVBdDJMWWlqUXdTdWxSa0VPY3RWbzQ5?=
 =?utf-8?B?VlBSZzVwNUZrZXg4R0JjR1drM0VwVlFQMGhjcW5YM1QrUTVyc1o0K0xLZjA2?=
 =?utf-8?B?L1ZLdXBmQTE4OWpzNHJocjcxeklGTTNoZnA1bVgxQnAyU3I1QVpkSWlMaFZl?=
 =?utf-8?B?TEp6RXlUcVMwWEVLM3g5ejg4YUQyRjNxS0lIcHp1ZE51WDRKSWtENVRUNVYz?=
 =?utf-8?B?ZGFmSlMyVmJ2TERob201VTdjSlhXbFZhbUI3czhMalhJZThnZWFPbzkyUmxF?=
 =?utf-8?B?cVh3Umd6MUF3OWhEbFMwMGwwd3h1TjFCYk9BNGEwbUdiVlBYYUFoRW10UzBE?=
 =?utf-8?Q?9vhn+8wRDrCIaWQW9Cz9z11ed?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cNogIORCCOCBW8jlH0AnRf010Ul9TV1q71v2gd249lb8goiQuGWFSWhRc5dVg95zd5I/E6t3R+5fdiBgUEavqSEy5OLnMicnQPEdAUH0gCv9eYfHGChhpb8iitXXbBG2qoOXSEMPa1zEVaRECJwhn4kiNj5JBNaX9XzhV9aavUCDHFi6pZ61bJ08Rd6PQSyFuF9D2HUrPIVfVXFmvgqmZonVZImi7d/eSJvlWsUv86D1ps22Nlh0iCtEqA612YlNC4hNlFM3Z8gKyhsdPe56Ep0l5Q3rUFSYvn0kfAslIwuh6ikLvQgQttyVn8+UtD2fses9IVkXwUhZXkGeSRn60bjTk6SV6SSNyCDUd94Pljq8UJrkrBuVcMkT/w7qRpYdiysw4um2qjkH/JVY1a6+1d8ApgIqz9eBRjGAp1NpOrq2j02nTmuKV1vtJNHh7ePqeSfSLNY4NEbBvE23g3I8ABcLryHyBL8lgh9SzysH1TtQlh77Dn+FT121LMaJ/NaPwK6xD3O0jKLj16uUWpDGtHEwwIUm1+NNRzecWY3h06I5PvHX+A02Ybas/EdLauZAVvEx8cx2TgJc9hBf1k/HUCnzUzlmbk8M0Nec0Aon1DY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2106461-236a-4d8e-9b7a-08dd773a5d11
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 07:44:31.1065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92Zw6rqNRcYvAJdwjDtArHNeDRosOKIt9F3GaOHStP5AEBs8KJSFSlcM+rX6810N6rNIYTnWfWV/FE4Ti3xRdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504090035
X-Proofpoint-ORIG-GUID: RTa1881v8eOT9lf6EomdKdZ7ky69aXal
X-Proofpoint-GUID: RTa1881v8eOT9lf6EomdKdZ7ky69aXal

Ensure seqres is set early in run_section().

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index 32890470a020..16f695e9d75c 100755
--- a/check
+++ b/check
@@ -804,6 +804,7 @@ function run_section()
 
 	seq="check.$$"
 	check="$RESULT_BASE/check"
+	seqres="$check"
 
 	# don't leave old full output behind on a clean run
 	rm -f $check.full
@@ -849,7 +850,6 @@ function run_section()
 	  fi
 	fi
 
-	seqres="$check"
 	_check_test_fs
 
 	loop_status=()	# track rerun-on-failure state
-- 
2.47.0



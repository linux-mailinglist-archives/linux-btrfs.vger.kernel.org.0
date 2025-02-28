Return-Path: <linux-btrfs+bounces-11927-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69DAA49135
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 06:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D111116F20A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 05:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45731C3BE2;
	Fri, 28 Feb 2025 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eQ12MPnm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dNmxW6Vn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C7B1A8F98;
	Fri, 28 Feb 2025 05:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740722158; cv=fail; b=rCjCWJteGPEJZyyyS0SKsSUnqg20RJHc++ZYLsISg7Xq3eFmMIVYbJMVDSmuCm0fyxemUz6SQrme2IqiRVD0zxhq5e3+PQ4FKefp4ZLw5rjALR0TRW9zFbjRlz68oOB3ayItaDwCbQ86zRh5x24nfcieKzPCuIISDko9e5KTykw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740722158; c=relaxed/simple;
	bh=I7pfE6E5EMXB3nYykl5TtVAitgxkXl7LPNyCnN4O7/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KGl28fP5NbCOs+BB7/uD1bOdzE0cf11LYAtncVLj/0IZ2jh/idAAxTbD0mJGqxCs+vq0rvx0z+JQ/X9e4bvlYVidTLV/ywDSw0jFVGEMgWYCH4qc49xaMnbDPDAQvLphByvie/PieGcsPfWbNuUACIhHz2x90Iqe4w/9wHFuwis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eQ12MPnm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dNmxW6Vn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S1C6YB028845;
	Fri, 28 Feb 2025 05:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BPlbQG5GoKFKs9N6FmhSyDhAMyKTejnHpTip9auf8uk=; b=
	eQ12MPnmvQOKB+A9X0sA5voSFLIr7PHYD4E/+aBg/7ytBlrCes0tqc7EDpPvBp0k
	HlaErgangrSAqCJKVG41WsAsy9gptZUs+9IK+AR10Xt1abpqNUmKKudVuSb1r10a
	7tmKv8KvrBvdPFbn9lN90b77Ge2vmRc9xDFLFfRYD2IfUIKdeUCm9molBqhTW+g7
	050dHbjnaYFlrQhT8za+p9aa+k9iz+fvLzVZrfBb3mNvb6rOxCRxqPaDLKPeOPVX
	jv+rA5hYDUsMV+vWX8g0D01ocb7BwOstwYgp8NrHQFc9216Jx3hW01qP3yPVBugC
	jPZc16NNryi0cunOcGiiTQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psecw37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 05:55:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51S49RNa008445;
	Fri, 28 Feb 2025 05:55:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51k913c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 05:55:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3MrEAeWiLS0tIZ3REwmB7c5vHcNHYM9FWScgqEper9kdnJzUzqjEFEJy6e9WS+7Hj9hBC6qoMoFtdo+sK9ExhBzzWmUV1hmWiqTlfHesDgPng0oarssUx4XVMZ3lHFOSQ2AOhYCY7nz+1Y2ggSjPewCDIzcor2SrPgjANUbT+DlygnIMlHEVhSPLF4BIbOr6LcGnqnWJngsxM5wAvZWC095py8yU/XE97h8C1x63cu4GzlmcyVYvSrv2x/uzbJ7JQQApi8olVNIeLVnUzZYbX2DRGgeN+5B3WnMKgaTB8bl0yw/do64Lg6lcWsTGhKKQnmA7YO6Xz8L9mW5RdM0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPlbQG5GoKFKs9N6FmhSyDhAMyKTejnHpTip9auf8uk=;
 b=PLlkwtIz/Esuhqb5q4VwvqNliCAYcehgTt9GtC864UTGpjmRwJbOpHFblBdZUuehQ0Z33cNak7+7U7QMxuBXzut2tmhjYJ2RobSdI1hgP0rtjuUQRfX2lCv1cUpunRRSo/Bt7hPSIPPuXZyRZta6vvz8Lr+BZf7iyhiWdY7GmY4Az/fZtJQGq+R3885DqEhfLXCTRH54x+CtIp6NKXX6qkrM5gTFSOqABpQDU0ieO7U/pWMNw3sJvJe/Iir5TyCGMcFjBswVc6i9PLO+eSNfAzzQNTbIfUTuFtrGoxP/iycwKzwZ/PFlNX6rZiQ0wosFiXzhA/eN6tzZFlcPOtfvkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPlbQG5GoKFKs9N6FmhSyDhAMyKTejnHpTip9auf8uk=;
 b=dNmxW6VnLSF8Y+1CyjjRWqwUPJboDqyAKZWIqJcHtNbHcbAjYIk1mzRXRKg50rWM0eKA/m2Em/vgisGR+a9Sbm9m8LGBJxHsAJ/Y6wf0vb0ScbMzTgtmLVpnj8Y/0PZeP6vME9Xyse9fGDiElDo1LV9E0OMZ9Rf7eHPkuq5+4RY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6618.namprd10.prod.outlook.com (2603:10b6:806:2ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Fri, 28 Feb
 2025 05:55:48 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 05:55:48 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, david@fromorbit.com, djwong@kernel.org
Subject: [PATCH v4 3/5] fstests: common/rc: add sysfs argument verification helpers
Date: Fri, 28 Feb 2025 13:55:21 +0800
Message-ID: <4c40bdaf996d9b04c2bd8423815d52d930ee32a2.1740721626.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1740721626.git.anand.jain@oracle.com>
References: <cover.1740721626.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 72083d81-e6f4-4168-0e28-08dd57bc8cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jWfvvcPPhlg6XiketmxTk/CYLOUBLCCrullQRHDDOCZJA9wmuXECQRemub84?=
 =?us-ascii?Q?3Av7npiQ1bF5HOB/26wL4DegpToDi5HcPq0OpNhEpRQx+/mRc29Rs2VPtsxh?=
 =?us-ascii?Q?7leueg9bUHxVkZcycis7cJk0p/GDqXqHUmJVAAk8h1p9OIVUmAgLsizYtqVA?=
 =?us-ascii?Q?Ydwz41NwMbP3H7oVBKNBaWLdtvttctW+Gep/OwoU0zi+8pOLxGYepL9uGBK4?=
 =?us-ascii?Q?lHaKtAgGcv/xNPValGORs2/FUPeXipLk9GMwAkS56VSIZbz0cSAldP78dM74?=
 =?us-ascii?Q?hMONdPYX02r6fvXf4XeQB0qHQfKgnFL5xcWedRExf0lkVyxajFyU0+Z/auNp?=
 =?us-ascii?Q?/IlZO5tRZf5S8GhLNtvzsgxCt2nvky0vrU80omnZuSXPJQh1e1YA1H6yu23k?=
 =?us-ascii?Q?s5+R+2jsBlJUF8wy6ZQT8FF4e71Q2qH6Rfu27hpaAV50ab26TeW07EkhcffE?=
 =?us-ascii?Q?6UeCDNlIMobjcMs4fzMaQ3E7qVYSBIZ3Gxl4eMr5LGuRyCCMWheOp0NOpRe9?=
 =?us-ascii?Q?dcHIVVmPGwYlnk50qrlXSAQk8AY++a0Oh0+BEAf/bf1PjtPwlNfdZqszC6k1?=
 =?us-ascii?Q?e/8tU4GzyNqrrwXlwS5uymttQQEpD8cLzfth96b5ZKhsF3GK8OM2ToedDNHJ?=
 =?us-ascii?Q?WInh4KGN9mgh8PxMpkyokvm8YonLkpy6vDnyIYkGlqfXqJDZ0WBT7kj9h5Nf?=
 =?us-ascii?Q?Xep/POGEgnJ5BawMwFCplCZEtwJB8+uhZWvYzCSXRa3mlv2YQ7J5YmPkZ6/C?=
 =?us-ascii?Q?vxIaG0eJb72FEtqdY+P0rbpDgt5HyYvzfAxNrQ6KggnAj6UROEPvF/bTKjip?=
 =?us-ascii?Q?Edgw9awPqgzdsJd90GtRoRdWowQF2gks77sSVPMdGrPuQNT09i7AZ9zXYord?=
 =?us-ascii?Q?GZcZ3vUXXjzMQxOKyw88s4wonvoj/nqsFfkhLJo4vV5rmQuo9oKnOPwf3Bq7?=
 =?us-ascii?Q?O+5veUENsZv6Q5NTF1YPEprzkO6lkQ1+CIhZeMruY4wXjZ8xLc9lMDiDmoxN?=
 =?us-ascii?Q?mO+FPuIMWIi/zoGuWHcApTxoPg41wcCgRmYvftyjvEyi1hwN2dTB2DJLykdB?=
 =?us-ascii?Q?NFz/8Etz8aF4m99rR4fj4e2ALUWp8hMs0Uui5TDWD5tr2us6UcE/s0t4h5G8?=
 =?us-ascii?Q?h8/cYaemEB6P4g42HYKMfvdyhIwz+AaL7jD9+UHqOp7tAPTO5c6m3am9sASi?=
 =?us-ascii?Q?Q+L40URo4uaXyZMfjjBM4n4sZliRWtz826k9EH4cUy1iYdd24ibGILknA1r0?=
 =?us-ascii?Q?uCuiHXLeTSqlrR9zbrwRE+aGTIAht8o8PdfKtIvMDiZTpZWb7MS4ogWVXzhe?=
 =?us-ascii?Q?CywPQh6e3m1IUke/MO/QbDjTVwbKJAr5zl8qzbnuWxAV1ReFnJu9LpgWc8gJ?=
 =?us-ascii?Q?Z5p/jIWflY3q2SN2I/QYDyjyoSRd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R3g7THPMfrC++yfi27B/av566d8ubHoC9r86t7INYqqkTS9on9QGnF7yHL9o?=
 =?us-ascii?Q?ewgOFPMfd3hexXJtFK//X8dqjhzYY1n5qCUb6u5+vw8Ya6Y4BfTdpvBVMjYp?=
 =?us-ascii?Q?8TdhW4J7al5CDlEGdYo6C40dqgQOSavdmVuTkeH6+oRxTKqeZ16UIIAcdG10?=
 =?us-ascii?Q?EB6+QDfyV/Z+ciAOM2d2ykKU99r3m7i/pFFYYg5oiAL/eyWX06kQzlkhg1UI?=
 =?us-ascii?Q?5iDeh0bi2bh+VPsjVt+BAsH8MyzR4m/KoDFeSJX0WY8fQAcdCza3rNII6YeI?=
 =?us-ascii?Q?p4d7L4XNtJCaTuJRByuz1RXY+Ng64EVu4hQiS5wCahMeCfecqV7tub0waqa0?=
 =?us-ascii?Q?dhho+6PQY5Eu3VnwPX5haCBnr4nITcmLlcItjNYQBF0GKmyMJLirBC8AADte?=
 =?us-ascii?Q?xGlaUuNfGKjtmL0GIb2ln9Iz6t7f9fexxxEEUaeLS9mHWwdw8rcVKzOZerW7?=
 =?us-ascii?Q?RpozezGIzpjyGjISed+B8UWsXd9GahlQ4Zv7gTGdkAlGQLJvYLXCbzPrsX84?=
 =?us-ascii?Q?HF4zrKPntR2P/rjAvRL6m+DG5qZmDmvvXBH/7tcqttRM7+4bHF0e1nXZL7gp?=
 =?us-ascii?Q?AzLOzeUJljV2GMTmFnsJxc7KK/smrRAdenqjQ5bfYj8/6q9OsUU7mhg3vne7?=
 =?us-ascii?Q?XHpBWBqQtJvlpuOKlcQqiTdy9pTIcXu0ejC4OkyK6RVQkB8Nn2O3vSl5p3DL?=
 =?us-ascii?Q?xp0C/fNrxH3fqslbNID1Fa3eAdNY50TSxvxIYtJXqFIWoGU6uK2flDq7+9a7?=
 =?us-ascii?Q?F5W3symSwbwuwrX3yajuUs5wJbQr/SBBjkmDd3/Yn0YfeuuHL/br7hAmeTNb?=
 =?us-ascii?Q?qZipGZuqV7qJodw1xxx0s1bXEOqc1iq8jMhWROq2uzBnmDPGVgxp/Y9TmK65?=
 =?us-ascii?Q?HgTQOdOfJnhG+rGMc+a/fcjn5ERZAqnnEN8oDw3tMBvSM3H6aZXMiUIh5ZS3?=
 =?us-ascii?Q?8DXFI2DrhJTE5cdOvI2r/mZesKnxE+ZGabEAx46iMImDcwzC+xrnCyx9Fy0m?=
 =?us-ascii?Q?4jAOi5B2kYJgK0wRqpp2ueozc22kC6eDtgvU9W3wfY97CTIysiccR4XJ3w+F?=
 =?us-ascii?Q?TepjbKAxD5jczCB+D76+oJLr7v1njuMJz0m3ZVL/gfLV4GOcaa8cu+/Gbfo3?=
 =?us-ascii?Q?YE9oZzf2+sSnUapWNcdsnpD5LSVIvYBrpOUwUwtbBViCY+YXvrIFM9DEBVZO?=
 =?us-ascii?Q?1YqAOCZT+6qiJf7Qc80mryHnBoe1x1mj4Gp/Tp8wSDQEvaGAU+jpEdSmnCXJ?=
 =?us-ascii?Q?waUry6wHGsONHZJ6q0fF9prhHNhKHQRwqyW02PfN5Qepzg7Vii27XT+l05nQ?=
 =?us-ascii?Q?ZWtvQBBEBMah94nFnVkaoJ8KkSydEiOHim0FAGQDrw8nPWm4AIbIpMILJx/B?=
 =?us-ascii?Q?o5bF0oBfFYExqhahm8rz7HRWNs4/uRVzCYavIYdvEHd8C4reUN3xiFtUoLJZ?=
 =?us-ascii?Q?JVrLVrW8Ondp7nm2W55MaRdK/6ag1zpzNwXlrj7Jf9LoJVgQDRWxkEdVNcN7?=
 =?us-ascii?Q?vNX5jiu0/rXssKlSRlvWY58wfw6VsXVjhbzWXHvs1zI7cW1nHmZihKNMD76P?=
 =?us-ascii?Q?vOzC3Q86CT5PBBtLdgkWX2fjH09qqoThlrxYOjWF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0iS2es8xZV8QhXwE/5+57xlmfEPrJG55MrHkcW0N59eraqUiJgqqYBWvXhatj0hd/nNqUhbUDTvfSadAcwhFJH8CFEL8Gli2iRnHYaUsalVqshVtyJrTMzcw7V60OG6lfHku2KU3vG1VE5otCwzU1mnctm6GKuVJ/6rKelW4dbXfjcTaFcWjUlFbsu8Av1gzLxRrgXcQlJjTA0xoemaHkWa7UMl1qFj8UECvNGE8NgtocyiVwvTFFeYIQ2SDMek38rMSHrdVzxN9lGV90wzrPkaFv2P40lOEf0EkgNchJURH5/qI3orheqcjvuEcHvb5aUA5cqCq7j894AbGWkQPIdtwVi/9flDRDi7zcTaKBR+gdNdPU4kp89X/aLJxg3l/TRHdsr511cnIYPVPmL96YGbhNET9i0QjbHgRqhTcJESpjo9+EBSaNtcB1R+EmRjKrgP2zUDsRKFpaowuj2JTOo2PgEkyXPLKOX6QztZxgz3H++yPNM4YWUfhXVQZU/xyK/OycpGxt8cwN6ZXz/GlFigcnm8AsprMxntCxZwnye/21ljZUmH25LP57n0GLR5QCZZvVAZlcMfmF2vFU25J/noIVl23L3ubtb5d/AFr9gs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72083d81-e6f4-4168-0e28-08dd57bc8cca
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 05:55:48.6846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: toK8S/VbQ4hCFLCoIXTNa4PKU9EbTaxBmNJ3QpefPASXm0IVbvItti5gZhNk/eDImprimiexzeZxu5JbgcmPhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6618
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502280040
X-Proofpoint-GUID: JXVEasx85U20Tou13m0zv25J4oM6ppc-
X-Proofpoint-ORIG-GUID: JXVEasx85U20Tou13m0zv25J4oM6ppc-

Introduce `verify_sysfs_syntax()` and `_require_fs_sysfs_attr_policy()` to verify
whether a sysfs attribute rejects invalid input arguments during writes.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 common/sysfs | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 common/sysfs

diff --git a/common/sysfs b/common/sysfs
new file mode 100644
index 000000000000..1362a1261dfc
--- /dev/null
+++ b/common/sysfs
@@ -0,0 +1,142 @@
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
+set_sysfs_policy()
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
+set_sysfs_policy_must_fail()
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
+#   verify_sysfs_syntax <$dev> <$attr> <$policy> [$value]
+# Examples:
+#   verify_sysfs_syntax $TEST_DEV read_policy pid
+#   verify_sysfs_syntax $TEST_DEV read_policy round-robin 4k
+# Note:
+#  Process must call . ./common/filter
+verify_sysfs_syntax()
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
+	set_sysfs_policy_must_fail $dev $attr "'$policy $policy'"
+	set_sysfs_policy_must_fail $dev $attr "'$policy t'"
+	set_sysfs_policy_must_fail $dev $attr "' '"
+	set_sysfs_policy_must_fail $dev $attr "'${policy} n'"
+	set_sysfs_policy_must_fail $dev $attr "'n ${policy}'"
+	set_sysfs_policy_must_fail $dev $attr "' ${policy}'"
+	set_sysfs_policy_must_fail $dev $attr "' ${policy} '"
+	set_sysfs_policy_must_fail $dev $attr "'${policy} '"
+	set_sysfs_policy_must_fail $dev $attr _${policy}
+	set_sysfs_policy_must_fail $dev $attr ${policy}_
+	set_sysfs_policy_must_fail $dev $attr _${policy}_
+	set_sysfs_policy_must_fail $dev $attr ${policy}:
+	# Test policy longer than 32 chars fails stable.
+	set_sysfs_policy_must_fail $dev $attr 'jfdkkkkjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjffjfjfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'
+
+	# Test policy specified correctly. Must pass.
+	set_sysfs_policy $dev $attr $policy
+
+	# If the policy has no value return
+	if [[ -z $value ]]; then
+		return
+	fi
+
+	# Test value specified wrongly. Must fail.
+	set_sysfs_policy_must_fail $dev $attr "'$policy: $value'"
+	set_sysfs_policy_must_fail $dev $attr "'$policy:$value '"
+	set_sysfs_policy_must_fail $dev $attr "'$policy:$value typo'"
+	set_sysfs_policy_must_fail $dev $attr "'$policy:${value}typo'"
+	set_sysfs_policy_must_fail $dev $attr "'$policy :$value'"
+
+	# Test policy and value all specified correctly. Must pass.
+	set_sysfs_policy $dev $attr $policy:$value
+}
+
-- 
2.47.0



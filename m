Return-Path: <linux-btrfs+bounces-14212-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4172CAC2D45
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 05:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC9E1BC10CD
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 03:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB361A9B24;
	Sat, 24 May 2025 03:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ObwjLydA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EwLSzP/9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B867E1;
	Sat, 24 May 2025 03:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748059053; cv=fail; b=nemCjDgE2GyYgeRSw9lS8gwcmur8KTgYtzCDqPAfe/7YN1kfjwc8JhgQWVD2338BfEyaFYuY92FVEKnZr0Z+vNW51jRpti46PFGxDdCNnnyHAW/Q44COqYKXYveGZ3N71QC2+eYpr0EbJloEo1ruckoDvqYuOpfOKTwUIn9nhe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748059053; c=relaxed/simple;
	bh=UnWgxPEn9IEH26Wb86oHnQrIRvUauOHCH+f+bJU3dVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uOIH/0Y6rVxwqvJm8U9Lv3fvckEFxD/Zwvkmghy2xlm3cbluaTrTJGcjo44J5i8T+KIYfPHe51MoIoVfIwamBjgWyz9GdXF9aH0dwjxdn7IiN5UzdTsl4OIa1gOspiUk2vu/PMDwx2yyo08NKq3HnRwNB8cBcvXS9Xj6kexAHco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ObwjLydA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EwLSzP/9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54O3s1mt021498;
	Sat, 24 May 2025 03:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KhS9IbimM0VZu1bR8Exa4Zqf7ic216CUOZ/H/WsuOe4=; b=
	ObwjLydAO7eLTgRdnIVSB49MVxm7A1G/TplqNLaXjQF/9PQr8V3CSsOQMA0jo8D9
	EEz7bpxZrscXGMJ+0LdHSGGq/2h9FfHvouzhPj9LINJ/45efdqBGGI8AXek0DGwm
	3aonPx9RXo3K+2nsbZpUOuBVBqbmPaT+zheu6T+Uard5RU5NqKM/OpG0vtL7B68K
	I6AXlk7bVYEngmbfnPvK0Hfh36IPW6hDN/enX9d2NVpUAsf96Bzz+tJphBiC+hSA
	yn3A01tXyojskuKSsFEj5DJNx90zCFkWioOxgiy5FPusySZdmYldYAUWFJKlwWU8
	Lf21+daOe4gYS4mp9BTCmw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46u5qtr10s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 May 2025 03:57:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54O1Xmb6035857;
	Sat, 24 May 2025 03:57:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j72hnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 May 2025 03:57:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iB0AvJdeib49eP4GPRg0Ii6XDx+4kh1b3ISmNYwZyQ2oHqoqJ1pArrN6MSb5xA0PWSVx9+PR2SPr54QGEGLp9IC5a5V78/DaHJxehsZhHdhmqFj1XYlsohz8WZ0z5IikPgt1dWPCHb4BYx8DUdOe7KjpNTocr6Jy75eojPHShcgfrCs6bATjJd9Qf/+STtaQnl819qDlXlwjLPcm5h7KtYiSPJnA6qGJ1TvjzmT3gI4SrT+0iQ9HCFNlMHMbC6OxRsXGlRPaa2NEDWpdC9dNgj5BPvuVo/tD8z2RTic3YlbE6yAB0i/k8egGG81zIT8zSNjCu/FYN4GhN8KmWbFGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhS9IbimM0VZu1bR8Exa4Zqf7ic216CUOZ/H/WsuOe4=;
 b=ZtbbXHp3QDRrFj5Yc0Zl7YnruWVje6KUbINLx68ey3xOfckJaTgXWH/IOIlCVnd8YxvcEbOR2d9Df1vlufBvw+1+27EYVRWluE1hPdcSL5RzmpAqqYT13ssfIBB/Y4qJxIDDdR+w3Z/zvyeQxD9Ra5mRhJkufnNxdDy9lF8JF5i4cYFlsEhnpImCWHDYaVU4g8qfaMIbNRCx+hPwpvk1GgR0H6BNxb2THb6tJ8OiE913BOJBv534alg8nzNyjY7643UCwFullpISJ0CtJZ9auJu4RAwx47rcYFRvEt5UtFI50Fen4Y5mChYHN54IgE0KbfM4Lk+KJsVG7tigynMCQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhS9IbimM0VZu1bR8Exa4Zqf7ic216CUOZ/H/WsuOe4=;
 b=EwLSzP/9ACFasN1Zg/FWKZ4iZf09A6yQbnQW0HudzQrMLbbRoi1F2ujay7FK+5MlARyGbTfWa4m9RQamuddpMmcaodi0dYJUKHU6oDiz81Xv5OzHOIy7a9QW1bGcr+BkOCdNQtnIVH01J8kTz0lI/O62Akcumi19XaWI1+WPR0c=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by CH3PR10MB7679.namprd10.prod.outlook.com (2603:10b6:610:169::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Sat, 24 May
 2025 03:57:24 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Sat, 24 May 2025
 03:57:24 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com, djwong@kernel.org
Subject: [PATCH 1/2] fstests: remove duplicate initialization in the testcase
Date: Sat, 24 May 2025 11:57:13 +0800
Message-ID: <ef4d2dbb8d82020bc3eac655d03650bfbd77f9ff.1748058175.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748058175.git.anand.jain@oracle.com>
References: <cover.1748058175.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|CH3PR10MB7679:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c6d34d7-0c62-4b49-3e41-08dd9a771762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h3lskJZjX1xC56xxvo8Taq2RYIt71LsitrBVl19lUCO2fcTPm17tUAKRrvd6?=
 =?us-ascii?Q?TSmRs4cdOFoGImAKI7YZymoacCu3UcF6YR9jAI38tlcwHe+qoinBAis+SNFE?=
 =?us-ascii?Q?bxNRH/5Wv9Qln5cMN5DQ/MSBfa8rlkK9Si7/2kSUOtAnlPY2tR30YNwkzpFf?=
 =?us-ascii?Q?BSMOfvRH4Qkn32GohHQ+R1/TNpgMuRgH3x2tt2GKPW7MmdFvulLrPpHHrNjR?=
 =?us-ascii?Q?BwnvhSMKGcZd4rJ0ZREMSZkVpzEZF+lBiARO1fw1inT14k9zE5frJqv3rFCH?=
 =?us-ascii?Q?RgOWUFAEFUdi6E0ekYeYyC/to2J7prdnvKa50t/njzZQlq69lYcxriRixRXX?=
 =?us-ascii?Q?/vIR592B5qMtN7+jDeX3nBuxzrZidWHRY+EhqVsvrR8SKDKrkJK+JX2IHBvz?=
 =?us-ascii?Q?hIiCX3rD8Pq/036QFGpd1ZbXr7CGFh07eGVvly9lL/XS7y467Tk5QTFERR1N?=
 =?us-ascii?Q?Ht3x3SgY/caNvYMQsDkJsLH1Gip45eKYKyfRU4fgpDEyuB+Ig+olIvAinRDj?=
 =?us-ascii?Q?TgbvoXc9vq0exxE+tVJYSG2RC17BD6Q6iNb8IRxp72vbc6xb+qHiKkh2RHCv?=
 =?us-ascii?Q?2fThOe+ICQd5LUktjiE1zjZwvYZjp9D7wI5S6qtijRG1EmT6UpvYGa3fywjD?=
 =?us-ascii?Q?tjj41Sg7ukdrCItF5LYNO8cq2C8HJroblrcOmGfZ+HHnY0NHtscZM8jsbSXB?=
 =?us-ascii?Q?OsAyXEGCLAaQQhAOBx35QkD3iWGJPaq0lad7IO6wtz6qtSer6krtPSGkfPbM?=
 =?us-ascii?Q?t7rxDWNOxGXhoq7hWtV5kswTaHIGaFLSKc5/QCz5mKGBZwERhZQ1lORBspxE?=
 =?us-ascii?Q?e73zKyV2mXWL/r7hPUBcg+3PekOd+25xpFVlaUsbPfdIFQ7tzvE6YkMMmb2g?=
 =?us-ascii?Q?LUd2la3m8ywmhiDa1OTLJT/6LuKBOK9k5NNR0vUckADvxe9OcQFCBSeHUHol?=
 =?us-ascii?Q?V5zrMm5vq6n7Cdw+5J4xxlYq+QlP01B5HNKG0q172QncQDGkuacFqV+w+7kZ?=
 =?us-ascii?Q?salHFssChULKv0y9VA1MDCyIsx9kWFU0cviqkvyXyWzOkvzWANlDH2yn3/UN?=
 =?us-ascii?Q?5MdBY4uxnq8FCcbFZiLkdpseLyO2q1PWcAW1vPFVOXN+Fm9GjigUGyGfceJE?=
 =?us-ascii?Q?RXQ+qpZHUfSCyKOzPwjBGzR/h/gFKAYkuVUETAALQqCoCSDPQUcqhTBFmaMV?=
 =?us-ascii?Q?9n0Hwu2CpqUahRSqqBg3BGqBJmuA/zTNwKCfOAO45gFtiLI3jYsVqk5iSgIp?=
 =?us-ascii?Q?OfounIWAju9wme+/d78d15ATAiogM6mdHgGfjcOtXyKxsk2RFilFEMjIQyxt?=
 =?us-ascii?Q?vm2dWBG5EDBIbOIwSoDDv9JZEjQvolJUBxV/vYL5iOyi31yD46qX7+hkJtCA?=
 =?us-ascii?Q?A3qNyZ/Kd7a5lZ3ked0e2x5H3Rw1UPrhjCm1dYy4OI05mG2V21+diOTq/ILO?=
 =?us-ascii?Q?QxwG3o0qL+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8qhHe0BeUh2o6qnrfCPJ1IvLQobpww1YuOGwqYtdENVB9q3T/AG6f/lb3bfv?=
 =?us-ascii?Q?L4qug/SGxLgws7eQdTXkMWDz/C1SPxRv+nm1afVmYxXqrNh1YrMEmGefsI3n?=
 =?us-ascii?Q?wTrHnw+XHkdXDHXz7XwKh0atI2Fl62SUNz9ztA+0Ee+s3fOBbeHrhbsLfl11?=
 =?us-ascii?Q?yzZIpQ66WeymnOc39laPU68q0XV8C5Uz0CuO8EfsXEkX0BXxgRY4CqPIQFn9?=
 =?us-ascii?Q?CCJlkXgetIsIzNVvBYw9IZCfhkIgqtwUub/smXBqzE69UMdmP3hBC6MG0/mf?=
 =?us-ascii?Q?z3j62GyWvLbSev7w95tHzKY/nocd92qstcV3/BBkDyaqBCUPG02iRPi9klFI?=
 =?us-ascii?Q?+H2AFksSfH5NTS2hOh0l6eZg0sXIVPvfJvD3gsmec/Jq/ySSF1mcNuvPl9pd?=
 =?us-ascii?Q?w+jocq/bvvLAXyEHzqMjGYlT2iCav2oV/c6yEP7i2KHNpUlh3UCjnmj2ZfPA?=
 =?us-ascii?Q?rhwQfajBo/K7yq3Z4DVfevbH37EqRWnWgl070uOBxf7Zzh/cBqA9e3zOqTBi?=
 =?us-ascii?Q?ePs9LiWyIUXbzcJNhETIX2aCG+GwzCvtV0BhBRzNrUHTefCsA5QT3DvvpLsE?=
 =?us-ascii?Q?lR2neP5BVo3HMps1Di8nkqgs7FFNAN6RfNof98JdJi+IGxpNfMARCCH7l7FI?=
 =?us-ascii?Q?9j7broqp3Fi5OiitMBnPQeuT1IjlySaZMw0j47EzO1GpNgQSCUMCZwzoGMuQ?=
 =?us-ascii?Q?EQ7s1JfVZAbWC2nY8jJoXsANHbGsMVK5WkXGiAQn9J+tJecnAI9hCdBoSqxO?=
 =?us-ascii?Q?8lHlZ/ALSLPZalO36dV7KeIMqUY8f49KqzEqiaSmuVHPYUgHrldYFvM9XYno?=
 =?us-ascii?Q?1F5OXzJRyZNRNJsbM64+rAHyGhvGElW7o5oBIX4aghoGOqQmLGgtABGqEz57?=
 =?us-ascii?Q?40Z+NfWsHVGLNPeIs5avpVz6koAMejNM0Ixwb9HGyPr14ANJEKESQFnF0/ho?=
 =?us-ascii?Q?lRN/ObadIrhx7IPngdTY7CgpXQ2+rQNk7GFiC5ob/rsnWwaA6FNymE4SZG/c?=
 =?us-ascii?Q?7Ng9f9sTMeDORfGVO56F+eFxr3Tn7Cdiz95VafsUhTzqGwQVlq7fEWoo/jRr?=
 =?us-ascii?Q?teJdNCPBD3kj7AEhrideEYc+q+CpyUzG58YtnzTt63CTzcSmH3QS5A0wLUR/?=
 =?us-ascii?Q?z61S3E+/AP9gK6l9AYSqvGTTdQTQco93E519moOYiOg3d7+j8JCr+tPWRbZZ?=
 =?us-ascii?Q?fb5VpzrupcEYQrRxcBy6uKLZJeKB0aZQVQQlMPcwFtVAH3UjFeLtFcyvj/KZ?=
 =?us-ascii?Q?4XeBps9BrFb5uW3USwAq99hewkiWp6oS3gB19frBVTkGlwgHTHFjXG+s2qFO?=
 =?us-ascii?Q?mTSWn30J6OZe9Kwvx5e5AVbKJ/WLpUrcF2m6RqsDQn1xlb/tHCPtWwZRVb/C?=
 =?us-ascii?Q?7OkAEjVRgPj/ANV32pY043zKj7eL/67ZWAT9XVIplKBgltoERObxVFjq4wjA?=
 =?us-ascii?Q?V8LLkNVqmyaRQ6CUOHnGtz1ml7dPKODZQARdI9O+tV8Xkqskeho7UTQSFHO9?=
 =?us-ascii?Q?kVbJbMX0XC0e0hE1D9pixQsldNFfBSd+IiC/d4uhrey1U935akl2HBrtxrVS?=
 =?us-ascii?Q?P31muTs9wZjIDPQvWG7BkyflHF8xUCxf6To+IpGs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	85m+9s1zXMeu8XS9KXwcecnA4wu6EVA0gj5ZbGV8C9i2Sz4OxBS4FsdBlm6Mo6ZNQ9ZO241Rgz3kZtD7+MW3RK5z6ZQb9WeTG/+9kgE45ExaXtqwqXQYXwAFbiYwkMAnpoAz+y8frYpKpHZBsZlUEIM7gce0xcfuxmN9k5lKRG7/gTpyhR9yELCs/kkmtDYr3l3Fw/XnGFYC9hEk0zwwPWp63tMuOZYdJDOmH1gtJnHDNaDQ9Q/0VCiidtm8nb7FbhvvPIqlSPgcEY8/5N+zyIE5zOg00AvhbaG0w3qIORXp5EhzK3ItY9rT1XN6+XFxk5cY6ryjIeV/rgmgRbI9EqhI8xHjIoMURiC0KhE0iJ/X7F/hi5LCHmMbPUade2jKGSBMJfzfZ4Wa28kwjr+r7rLJYgitf+EZ08WGNqojVlhYWp6M4jcB/qhuF7qJw8/4GDxM+pjRhYXybSqQA8tXVt+3XVo1O2/nbtM8V5/uu+tO20yHBq68E8YpZklJVZ7PvdUSpJYehBxSfeX9FIz2LyN8N+N/OOYHGOBokRmvVqXRurHrHTVUZNsV7WWPP5264YdPkoq+vdEaof8Xvt564JEE7xqWT//lsyh1d332fQE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c6d34d7-0c62-4b49-3e41-08dd9a771762
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 03:57:24.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2GeiA+7Ks+QQ2zjAjSZRRx2ceUzXvPTOJ9GuG1H6X0Osocmn70goySr6J/6ncRedUBzpsm1iF1PXlYDcnLPsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-24_02,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505240034
X-Proofpoint-GUID: zcZZ2pmqD9176aIWyNFsl_p13lT8Qfeq
X-Proofpoint-ORIG-GUID: zcZZ2pmqD9176aIWyNFsl_p13lT8Qfeq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI0MDAzNCBTYWx0ZWRfX0EDx6mYYuiKj m3gL0Qw9Tr5lYcMsfWtrnlIwTW0QrYqyqqjoWEGG5o6MuR7oyA/s70m46j/0SpxdEEdJAp8oQUz R7hE1HRa/tnpBOgoPSg66j8loOE21gEkVcDbsBCUbEVEKLNeyH0/runjwwxft38E2wlQfNTWi42
 I9gtZFQhDNEhNTTgM6ECdLTwhfpBMx9tMb7CQ414TEEwyHSNtUeZ0LkqIG1Kh97EPVoKjG5kV2z z117azyNnifPrxeXi2AvHeoqddLR6869Ey0jxAR3FplSrXZ3GpgNnNYnliI975tkWkfaWunzEY6 7GveKkmt/epkZn8Ys3S8jS0J9FJ5Sq+XRz/3Q9fpleP29+1N2TC7rV52ZfIYWxwP6QbPXWGxKjT
 Z6Dk4Dv17je2ZcwnK28+3xZBcI3NoA/BqxRlWQJkmObhRzazC9AXwDV+by82YP/qJSAtt1O8
X-Authority-Analysis: v=2.4 cv=U+WSDfru c=1 sm=1 tr=0 ts=683143a7 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=M7XMAhpmyReqtWynpIMA:9

_begin_fstest() already initializes several variables, including `seq` and
`seqres`, so remove those redundant initializations from the testcase.

Also, ext4/053 unnecessarily re-initializes `here`, `tmp`, and `status`,
which `_begin_fstest` already handles. Remove those as well.

and remove template comment.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 tests/btrfs/253 |  3 ---
 tests/ext4/053  | 10 ----------
 2 files changed, 13 deletions(-)

diff --git a/tests/btrfs/253 b/tests/btrfs/253
index 96ab140f1780..a0cc9b55de69 100755
--- a/tests/btrfs/253
+++ b/tests/btrfs/253
@@ -28,9 +28,6 @@
 . ./common/sysfs
 _begin_fstest auto
 
-seq=`basename $0`
-seqres="${RESULT_DIR}/${seq}"
-
 # Parse a size string which is in the format "XX.XXMib".
 #
 # Parameters:
diff --git a/tests/ext4/053 b/tests/ext4/053
index 77b3ac8171f0..55f337b48355 100755
--- a/tests/ext4/053
+++ b/tests/ext4/053
@@ -9,12 +9,6 @@
 . ./common/preamble
 _begin_fstest auto mount
 
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _cleanup()
@@ -27,13 +21,9 @@ _cleanup()
 	rm -f $tmp.*
 }
 
-# get standard environment, filters and checks
 . ./common/filter
 . ./common/quota
 
-# remove previous $seqres.full before test
-rm -f $seqres.full
-
 echo "Silence is golden."
 
 SIZE=$((1024 * 1024))	# 1GB in KB
-- 
2.49.0



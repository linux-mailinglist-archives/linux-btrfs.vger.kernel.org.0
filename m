Return-Path: <linux-btrfs+bounces-8289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB60988200
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 11:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462801F21CD5
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 09:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AD71BB693;
	Fri, 27 Sep 2024 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DxqaM06E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dNx+ZS5H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F915F3FB
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Sep 2024 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430977; cv=fail; b=oxxLuPMn7bNlGvWRnNu9OcQZFZbz9nhhQOQpKwGRLhhnaenY0DAdyW03w38DBhoEpf1Uxm816y+T6IVU2srxR8ew3NExs++NwjHxv9ZGj6avcs5qJ4JOpRjDXCPdeNyna1AQOFaJBECuQhuCzAsWAbCkIlWDWxTH++rMqr2bNfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430977; c=relaxed/simple;
	bh=SidbuV+9Fysyvbd0dxRTrVjsmMde1LeQLy9QmL+lBdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qF0fhQNGBI0Wwdbm+H3eEnnCfMR0hYCjpR0ufsMAcewx5X+SWJo9rY0xjmofrRLD4ifWgVy+KcsJ2vg7ZkH0/R8o57sPIw/hZnEk9luEAYNBAMP9ZNNxFDlsPGVS//2Mv6plYBs1gAY+1QiYYaqvsIpDMgwV8ZTNZ2h8ESm9xgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DxqaM06E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dNx+ZS5H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R5ge7Z016199;
	Fri, 27 Sep 2024 09:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=Y3eiUWTHDk0llyofKQ6R3XClNBsHBe85hIM0kYFhds8=; b=
	DxqaM06EPRR6VneE3Q9jYwDwHNjfaeO3g+Rqr1UYCZUfdUO+rmVUYb88GaAxlLr/
	rUB4WFl5XLP9bDC3Rent8YujCucOfKWM4/p9/V/ET9Q0ghOX8E6OqZyv7uBa1Wnx
	5EmnR0AfPgBZUzhfA0UDyjqI7jH8OUYMB5LFYWGeL8n4MkKJhYPo8NH5sDcj+GoT
	mvJh5MstOGCe82bLK8u9NFh8Us9dnjRJU/+iK/sPROL3IioV5KOyk+EFfiofxgG9
	zrtPRSN07RdQgrPOge1qlxOHMGE5SUKFqVJcYn9V4HGqiCn9yRoO6zbFprqImguE
	SKm9F3KYe+SU068wXrUZxQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1aq4ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 09:56:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48R9DXEg025240;
	Fri, 27 Sep 2024 09:56:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkdc5ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 09:56:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKOu3Sa+8YRAbwffz4nlnX2AIoA87mSKN59hSI1LppfX7gCJi8aD9pwpxmm8IVo457c54JIcLddKn2mXYo2rPIRuu5eYZpVG8+3TSKaoMMw3ZXwI7J1vYb5IH1JIT5AV9C+cf6tWbKGvDS9Xo/ac/dfiBH0aFMNf17O/VQ1dcDJJGvOo06uf+cIgvAn6TCmEVTiEGNtkkLBdSTqQ3G8qd3qW2lCJE8ymjhN/vdSQhQaKnRVoGvjkiNzWb+on+OdQ1dNa0W7SZsqXrbKS3LObLjY8imgwh7Dt96838qJHRXU7Y4wpLa+TSXbR7yKbkSSnbdF8Y1a1a1QwBBJjGgFKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3eiUWTHDk0llyofKQ6R3XClNBsHBe85hIM0kYFhds8=;
 b=BHFWQPWhww8Hlb+lpWmlB1sybaTlKpOpF9G9hGTMQ3YYiC/LFOdItCArUYuifFU9xrzo+lvudXI6VOo3oDyTpC1pSQNg/TJPSGLuAzQlK8EX62zX1W6sbmwlzOWx0f/3pTP+fXNbBsMQvPKkiZbYiS9/+a9h1OncSnxtJSSPcHlOrT0nSJ9xSfw5XwnbofASzEpzZuAhTnpUZ/BZ2zLaog0zh4+KHe3YWRRWG89qwtCKx7dS/sJT/uEV3d+VhM9kjwdKV42pMVwM42mEoUnKJF2d0QMyRwBT0CtoLeOVmby/eS99x+LFOEOv0NekxhXcApRxPwE95SKKZDdgy912RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3eiUWTHDk0llyofKQ6R3XClNBsHBe85hIM0kYFhds8=;
 b=dNx+ZS5HhAk8Feez6dJyl+jsmsRKIxOKTbb52OsBW3ZhGoXYZl9VWMFigrZIa5NYLTP98ctuen9/IT7d9PQoj77tKPKRC/HtxkGx4NesciPVwex/tN+YJg6SLLnsgBY0RjVyZYUVMC1h/PJiVzsVlnIz2y4uGP0jsSg+6WrE3Bs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by IA1PR10MB6735.namprd10.prod.outlook.com (2603:10b6:208:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Fri, 27 Sep
 2024 09:56:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8005.010; Fri, 27 Sep 2024
 09:56:03 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, waxhead@dirtcellar.net
Subject: [PATCH 3/3] btrfs: add RAID1 preferred read device feature
Date: Fri, 27 Sep 2024 17:55:22 +0800
Message-ID: <6c2ae62fbae41873ebc52f89c4e506b897ebed82.1727368214.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1727368214.git.anand.jain@oracle.com>
References: <cover.1727368214.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|IA1PR10MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: b40df12b-7a00-407c-5f7a-08dcdeda98c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5FZIDbsgcXFjqGsvHNrT4JiMycfYvcYr5IwR6H1i2nN8uZTETSolmhsGLc/f?=
 =?us-ascii?Q?J4DeBjt/23AQFA/89wmirP1C86BTwTvG/FdGyQVXA7QFB553lSmHPYL6EyRd?=
 =?us-ascii?Q?NSDAfQtLTL/x/iZUUEcx/qMTIp/abPLI7AhiBfjnadmVPkq95ZbF6XVklwr6?=
 =?us-ascii?Q?MnnBHtLX36Fjf+Q3Ox6d3tiWHpsDjTurr8jTpLX9fdBqRfLk+Ey9LOpL5Djg?=
 =?us-ascii?Q?M0fl2w4P6O0kZHzGva7lY+NP86brdtxSPbYVAcoUreDOTJpXbVlxKqdZdFzw?=
 =?us-ascii?Q?0BpGhtoDpzM5zyqB5DOzcMQm2T5EH4dqdteqXaDdcoq39GmBB4JNEPoVZPRC?=
 =?us-ascii?Q?AsZAwTodz8pMsxtvagNs1ZQBN6/3K8LqukPPlV4qyXc9rptfIvsqi6sZyPJg?=
 =?us-ascii?Q?rvvxf4jA3wBP2IQkYSn00SMCHLQRn5+icO7fHgZwXpdCgh8jjXrKCAO6pQ++?=
 =?us-ascii?Q?AuH0lxvGzzEEOu7vi6gPBaYDFwqi7IreipgeUkRoRdMLvUSgF0DK0ISAnjuw?=
 =?us-ascii?Q?hxO4u7tmCY5HU1/ZAG0C828oCbMzKitumAOyF0FT80hoi/xM8bgmbogFJAfW?=
 =?us-ascii?Q?kcG7oOoPy7FjDQPS5PCswNdIfMaryjs3dEwdfTYICSGL+4kF9lPZWlbqGEY6?=
 =?us-ascii?Q?gq0yFjIEUt7qMRTFUTWANzbVtkbxjkECqA3boc4enwlovEdCQ767upFlTISa?=
 =?us-ascii?Q?S0RSr1SbSs/uFZZ2STgs/VIm8uqgJsb2Nb7isJe0sy+bducf99VEaLFY550G?=
 =?us-ascii?Q?QRRbU9/wgXfotzh+NkeXmQvVHh1kkfyoIbMnL25ifL2NhRCLlYlnbsLU/plg?=
 =?us-ascii?Q?fAoxOUzfxWDNangAhejKN6/8dzpBwWAnzDENcf1NkjSLxCKE7GyZXj0JxGEV?=
 =?us-ascii?Q?Hdv3igns9pDIf9o8llwLwacSq04k8fgHjoqY+GYBCT1bzaGRQbXZ7nVBxWSW?=
 =?us-ascii?Q?i9EIkPYqqCDIFgi0ebDLdTqcOFZelr4I7kH0T/w2S9Au4w6+itQerANEJYLn?=
 =?us-ascii?Q?UpQPTnqBLGJg29vLCx/2DdWrvjwbosUeTRqG9XhXPS9W66Ts9/lGCEJH6qYL?=
 =?us-ascii?Q?ylIie+t39BWE0k+pjQ4Yuy8+lgFCN52CCsEE3Ng5nQSA0GsGgXiYDhJBRiCg?=
 =?us-ascii?Q?WX/A1ynkeAjrjZGUdvQcQgsZa8usydTPDvIxkcXtRb/He6KLfOyKlnWVoJQR?=
 =?us-ascii?Q?UH3O6jsmr//u1rp5es9PupLIfDhImOc4CGx3aqkB3jDg+ufKog59H1aa5SSn?=
 =?us-ascii?Q?HJx/pLj4VwdFcOM+fQez7vW61ZZYGRgvFLm5BzH12lRN12K3AtVw7jZmIvTc?=
 =?us-ascii?Q?6QF6/gMCjsAZAW2JPAT0Lix6wAEHiZws5uFQ1pv4Kx+hKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lp7jLwQWtmxMmwSIxCbFhrlHghq2D+oZKIqq2/LASnn9Gq5fc0FrmOGdRuPu?=
 =?us-ascii?Q?PGjS90rgLc+E24WeErhHGJ3p11H5iqCXpGZPahTZC7Si4jFDUmmq0Rwyss35?=
 =?us-ascii?Q?gnDZa8HpksdBnm/iPd+7v8tbaxpDKN3/oFRRkXmZePSgdFQxuDLzsXUVpZ2w?=
 =?us-ascii?Q?7J55ttFNs8na7jkow3lRfpeF3Gwpnrom7T3TQZMWO8Mx77TZ44SA8s1AYZb0?=
 =?us-ascii?Q?yTVv3JgTi1DWYLKMZr9BNtZLL5p+RIEEi955lC8aTNHfC2kHa5nJJkrOaDLX?=
 =?us-ascii?Q?0bt+sAZr44lIx3D3RzyikJm82RlEK+5A4e9GJ06CcpQQ9VHWeaiCkGGz2kEf?=
 =?us-ascii?Q?qSiMEWdeNvurVldHkFStDkyN3Anye4U9tTHRwP6s+XL4wpigtKYoLjmIwDRN?=
 =?us-ascii?Q?+XtPv8/d5T0len+Lnb6AGjhLFsCgVAdeV6//EYWBP0oEaDAeOOvrBEMK0Zui?=
 =?us-ascii?Q?J5zvbGZYljXzh8DZIGLlnMdmWknIAZ/x+MZuCqU7JS3ff/eZX2NeDG6MjyIj?=
 =?us-ascii?Q?IzjE4myrqXlXE7fair5rd9jE9hdKd5mu8NVVZ2QWPjFBNCtcvFSKVh6potKL?=
 =?us-ascii?Q?AlYdFz0+d0RMd0uuDaiCKSJn9B/tZQ4N8xf5efR4P6m11v9z5A8/0ymJA8jW?=
 =?us-ascii?Q?yC2xy18YCYzaLli5euDl58lHupe5IVRVSXZB8orSu4pAkGL/0requtcdEhv5?=
 =?us-ascii?Q?nWgwhLhwjNAKLHTCX70vslREVOcPIQu3PZKjyWxnOZDM1S1d7sY8Y9RnZr4L?=
 =?us-ascii?Q?Gf+Pz6VYb0VNwW0ukVJJ27fYAQPTWEs79m+tE8kbRtpt9EPPNyIpKRD6/676?=
 =?us-ascii?Q?7jbMIT1rVntQMQ3rG2q+nu+5JyaGuzEd6bABYC0O0tvspZgiD+J4Mx7VuXD1?=
 =?us-ascii?Q?VF0WWVbpA7UjDoGZyN61wgKzpDMew/82Kh6rImisxblnu+yNbOsjmubrjYu4?=
 =?us-ascii?Q?CbVSW6uI8P3Gr+iMQASEVZDYQsCpSmgMQD9R3ImX9VwNxcHIeNkWNLzn2yqX?=
 =?us-ascii?Q?YxYhQUfVHfVLVi8JdmB0hpr8JF1/kkO5+i3TOsGgfH2an0BDA3mXJ4SkEjby?=
 =?us-ascii?Q?uNq580Ca8o9xPMu7KBRFLPTSEMpoJV5fEUNqUvywPWBWMsy+qCDeEhSdnmZS?=
 =?us-ascii?Q?7P7IOjeUSXfbhgwefNYDbhgQt3gHiHUXZ79jenCb5suEW633D9jdv+RgBKTg?=
 =?us-ascii?Q?RPvudVRLP6LTycwQEqP3Cm0B9wMQgu8kk5iqLDwu0akNPrvJzpUcNOMy+O0b?=
 =?us-ascii?Q?T/W5igD8xj1vKwIGsNe+KSQpqtPMpcns/s54jYd4e28tUVuEmA+qXZzK9qDg?=
 =?us-ascii?Q?+d1XwCTMOFuzg9H5X6E9IynzNyn30BEDHnhUfmzUwuOok5XjaMGDg/QhvRSZ?=
 =?us-ascii?Q?RQI2dQ5qKreWfuW2av6b/6qVKTEOj197kSz/sDVLClIGsk4jq9fktbxoGmfJ?=
 =?us-ascii?Q?bojAiRdkzRy1KfCYxRsI9lp9kKf+5k88Zah+yBy56nY4HSByitx1M1+IBXom?=
 =?us-ascii?Q?ONZ/E7CgVN5fZabqg13eZRl2SLn2GUQAuVKz7rsJ1dBsXte4FIoKAB98uZVg?=
 =?us-ascii?Q?yp0w1XweLKYE34OpIi2tsJYZCbA6ExQrj5sZMr7y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dJ135WDZs4+N/9id4GnXIUfrekBSMhHW0maioav7rVuO4GUHTGjzhpD26+YGldBKaD/T6DS2VPSeqEJmTntc/WOCE4X59iabIe3rXHti5hkkx5Yyh/n1CW0kghSuw76lOmbndrctbU/djZ3IQdsfNabm2032R+XFCITdrWZKeEQz7azL1Cr4Uluw+cLF5c+fsIPTOE/0vWjHEr7c3U3TBeXYM6OZxNBQT1hh9ljThsFdYDSPaolzPazIPrRZNxpAdXong5Rg1unmrYpIDNnk+KyDsm0/f2/uXIeGkhcqCTKfDvC9Dw7GZXyQwxsaAH1BpEIKSZcPtokyC42Q0WqeshxNhnwv+cN8CgoLzO49jnkg0+FybBTIzAErHsU7dPLIGjIeHISkqNyFTC03jQk1ltzoFUJfKqM71RKDexH0RHsasEQSHMa7nB1FpgKXNatfqvbfN+hxkHVhV/Xa95+9cWuuOfRczFQexlujs+VZPJZQETDrUZBgNn+/TmSs49R/GL/vERYSF84AChdSYyzpp0ZD6FpTkwjlT8ytDsM1svyi1ySa6LNhTOwM/ytnszmtthG3U2td14bwA791dEFz6Iv7TnOQMARElSsYVMTW1eg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40df12b-7a00-407c-5f7a-08dcdeda98c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 09:56:03.0262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLnGnEf9ElEKB0WWR0OgG6LmK/jb/QqIZDWAm+BZdEL/p/KdLTv1InlWPwKIEbc0tTya9dryf97J0RXE6mixOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_04,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409270069
X-Proofpoint-ORIG-GUID: LYHtf9ZMDinYXzt8qYUCw8rUlXUuscKK
X-Proofpoint-GUID: LYHtf9ZMDinYXzt8qYUCw8rUlXUuscKK

When there's stale data on a mirrored device, this feature lets you choose
which device to read from. Mainly used for testing.

echo "devid:2" > /sys/fs/btrfs/<UUID>/read_policy

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c   | 92 +++++++++++++++++++++++++++++++++++++---------
 fs/btrfs/volumes.c | 20 ++++++++++
 fs/btrfs/volumes.h |  5 +++
 3 files changed, 100 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 15abf931726c..e32999ea761d 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1306,7 +1306,7 @@ static ssize_t btrfs_temp_fsid_show(struct kobject *kobj,
 BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
 #ifdef CONFIG_BTRFS_DEBUG
-static const char * const btrfs_read_policy_name[] = { "pid", "rotation", "latency" };
+static const char * const btrfs_read_policy_name[] = { "pid", "rotation", "latency", "devid" };
 #else
 static const char * const btrfs_read_policy_name[] = { "pid" };
 #endif
@@ -1320,14 +1320,22 @@ static ssize_t btrfs_read_policy_show(struct kobject *kobj,
 	int i;
 
 	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
-		if (policy == i)
-			ret += sysfs_emit_at(buf, ret, "%s[%s]",
-					 (ret == 0 ? "" : " "),
-					 btrfs_read_policy_name[i]);
-		else
-			ret += sysfs_emit_at(buf, ret, "%s%s",
-					 (ret == 0 ? "" : " "),
-					 btrfs_read_policy_name[i]);
+		if (ret != 0)
+			ret += sysfs_emit_at(buf, ret, " ");
+
+		if (i == policy)
+			ret += sysfs_emit_at(buf, ret, "[");
+
+		ret += sysfs_emit_at(buf, ret, "%s", btrfs_read_policy_name[i]);
+
+#ifdef CONFIG_BTRFS_DEBUG
+		if (i == BTRFS_READ_POLICY_DEVID)
+			ret += sysfs_emit_at(buf, ret, ":%llu",
+							fs_devices->read_devid);
+#endif
+
+		if (i == policy)
+			ret += sysfs_emit_at(buf, ret, "]");
 	}
 
 	ret += sysfs_emit_at(buf, ret, "\n");
@@ -1340,21 +1348,71 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 				       const char *buf, size_t len)
 {
 	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+	char *value;
+#ifdef CONFIG_BTRFS_DEBUG
+	u64 devid = 0;
+#endif
+	int index = -1;
 	int i;
+	bool changed = false;
+
+	value = strchr(buf, ':');
+	if (value) {
+		*value = '\0';
+		value = value + 1;
+	}
 
 	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
 		if (sysfs_streq(buf, btrfs_read_policy_name[i])) {
-			if (i != READ_ONCE(fs_devices->read_policy)) {
-				WRITE_ONCE(fs_devices->read_policy, i);
-				btrfs_info(fs_devices->fs_info,
-					   "read policy set to '%s'",
-					   btrfs_read_policy_name[i]);
-			}
-			return len;
+			index = i;
+			break;
+		}
+	}
+
+	if (index == -1)
+		return -EINVAL;
+
+#ifdef CONFIG_BTRFS_DEBUG
+	/* Extract values from input in devid:value format */
+	if (index == BTRFS_READ_POLICY_DEVID) {
+		BTRFS_DEV_LOOKUP_ARGS(args);
+
+		if (value == NULL || kstrtou64(value, 10, &devid))
+			return -EINVAL;
+
+		args.devid = devid;
+		if (btrfs_find_device(fs_devices, &args) == NULL)
+			return -EINVAL;
+
+		if (READ_ONCE(fs_devices->read_devid) != devid) {
+			WRITE_ONCE(fs_devices->read_devid, devid);
+			changed = true;
 		}
 	}
+#endif
+
+	if (index != READ_ONCE(fs_devices->read_policy)) {
+		WRITE_ONCE(fs_devices->read_policy, index);
+		changed = true;
+	}
+
+	if (changed) {
+#ifdef CONFIG_BTRFS_DEBUG
+		if (devid)
+			btrfs_info(fs_devices->fs_info,
+				   "read policy set to '%s:%llu'",
+				   btrfs_read_policy_name[index], devid);
+		else
+			btrfs_info(fs_devices->fs_info,
+				   "read policy set to '%s'",
+				   btrfs_read_policy_name[index]);
+#else
+		btrfs_info(fs_devices->fs_info, "read policy set to '%s'",
+			   btrfs_read_policy_name[index]);
+#endif
+	}
 
-	return -EINVAL;
+	return len;
 }
 BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 20bc62d85b3b..c49ca48e7b2e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5863,6 +5863,23 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info, u64 logical, u64 len)
 }
 
 #ifdef CONFIG_BTRFS_DEBUG
+static int btrfs_read_preferred(struct btrfs_chunk_map *map, int first,
+				int num_stripe)
+{
+	int last = first + num_stripe;
+	int stripe_index;
+
+	for (stripe_index = first; stripe_index < last; stripe_index++) {
+		struct btrfs_device *device = map->stripes[stripe_index].dev;
+
+		if (device->devid == READ_ONCE(device->fs_devices->read_devid))
+			return stripe_index;
+	}
+
+	/* If no read-preferred device, use first stripe */
+	return first;
+}
+
 static int btrfs_best_stripe(struct btrfs_fs_info *fs_info,
 			     struct btrfs_chunk_map *map, int first,
 			     int num_stripe)
@@ -5980,6 +5997,9 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 		preferred_mirror = btrfs_best_stripe(fs_info, map, first,
 								num_stripes);
 		break;
+	case BTRFS_READ_POLICY_DEVID:
+		preferred_mirror = btrfs_read_preferred(map, first, num_stripes);
+		break;
 #endif
 	}
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 09920ef76a9b..9850edaafe8c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -308,6 +308,8 @@ enum btrfs_read_policy {
 	BTRFS_READ_POLICY_ROTATION,
 	/* Use the lowest-latency device dynamically */
 	BTRFS_READ_POLICY_LATENCY,
+	/* Read from the specific device */
+	BTRFS_READ_POLICY_DEVID,
 #endif
 	BTRFS_NR_READ_POLICY,
 };
@@ -440,6 +442,9 @@ struct btrfs_fs_devices {
 	/* read counter for the filesystem */ 
 	atomic_t total_reads;
 
+	/* Device to be used for reading in case of RAID1 */
+	u64 read_devid;
+
 	/* Checksum mode - offload it or do it synchronously. */
 	enum btrfs_offload_csum_mode offload_csum_mode;
 #endif
-- 
2.46.0



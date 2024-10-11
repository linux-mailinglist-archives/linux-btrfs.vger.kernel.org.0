Return-Path: <linux-btrfs+bounces-8838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD39999AB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 04:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBD61C23901
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13F71F1308;
	Fri, 11 Oct 2024 02:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MK/7OeUR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vSU3g7+b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BB41F8F1A
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728614999; cv=fail; b=fqTTVZl8xd76Pm72G0TWQFGguDu8USdhYV6Jqh0pKGPecSecG/nZk8GD112dYfQuP6rp+T20Q3xcw72XzI/jgHVE0RRQ7FF8AmEnI6f+M4m9X+SU14jfHQ72rMB9ONOBtIepmqt9/Nkv7G71ftRB2/pTJ9M2ssgJgme7unrwJJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728614999; c=relaxed/simple;
	bh=kG4OnVo0DyEuW3u8ZZtkBYz5re0TsqGKo1/qcOKWMKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bmn4zJ4yxWBdBHS8W1eRhgYPTn9PlPVViW+89XEX5+PM4CZY4iT2etLMEOoeJovt52qv7sdYZ6CZMrFsdrZkSYeVpcJEZY7pyLSmajZ5xP5+aDGhs5/3EQ3Mm9KnMUzEvQpXts68Lz4YEW64fc+kDk1KxmFg2Ut8OkpyGzehiaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MK/7OeUR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vSU3g7+b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AJtdl5012157;
	Fri, 11 Oct 2024 02:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BbLM7oq4Qly7ZOxJZJ2nNsrSMYfY+f02iyF3nrR1/Jg=; b=
	MK/7OeURDrPJOyY1ptJ8pSIj3w7toYHAPsPNqqGM1TCQ7UapLQSkwguMcJfMBn2P
	erXZez7AtzvyQnV8ongOVZP71Astv5JyU0ANUMHJlzGVivSp68n3ElGBR1tdtr1c
	MYvLFymuQtgdLtHTPpZErmZHNDhvrFGGqW2umev//0Kt8l9rqmVlc4Cj8h13Bx0r
	S09osqFrIIBVLrp3ntGTzbOaw42nQxGTihgG8TdeuyFmo7RRIwwVJXdJo7pmYJS0
	nsK4vdBQsMW7UYt4EJMWFmDelPXn8RBISC43kZpJRkQIIS3BymRsz5MUo1BFDVjB
	x8sYyyDZ0e+316fbBIK6Vw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pkvh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 02:49:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AN7SfH017546;
	Fri, 11 Oct 2024 02:49:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwawtnt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 02:49:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkB4mhS4okffKbS5lCk3g29EnGcvz+SGckT4RHgAoQdTOiVMahCeQJi4ekfLh1EAGovEGqZouqg10zmmJLPoDtvsBYZPHTEE0fVzM9Br3bdQ+Gci2V60jHW9qFDQuNva2/jhsEG3530BTyZaKE2JvHeOFd3g0G3t3Xe0sMNtItvpvSQwLe2GmLuUmO9DV89pB+Of3PfIzGzFLOjlLSXGc3zlMhs7YTh7dhA+XoZLkFACbW2rUIplUiNv35r3za1nt0NYa/L4jaJy5IzVEF0gW4ia5zg8MhfDlEO78ve/E4QcCUgtSCBDHRp1hTG8XSZ7C4YPboN0lf9HsS6IoHxuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbLM7oq4Qly7ZOxJZJ2nNsrSMYfY+f02iyF3nrR1/Jg=;
 b=D0nTYCiGss9pcsizhKZ+9THoG56Z1ZPzKiru0DEl9EhgMF5A8ZXraP+187FBIavAXK06A3Y/E1gk2biH2kAvYy5me9ZOkxsj6p9Bk8kNvg9v8bgdEQEDxjz9pDehW4w4UmWm4jRMCqfAQ3hKyeHDbGGmPpaEK5KNhbJRWxHjVmpzXWt/q3Mq4BM6Xz+QdYIP36L16E7ByT6FoKCYRilO9Z6A677TeDbgwYgmSOzNRT02AEKflffl6aAgTybwyhaH5YuYYIchL0EM3ORrtjCeeZ5RSm8FdcuEzSERmtDrNJ2+rkFI66LtwhU9H9Ff1E7zBHtILarbiTwFj/7QDmWOlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbLM7oq4Qly7ZOxJZJ2nNsrSMYfY+f02iyF3nrR1/Jg=;
 b=vSU3g7+bOayoYMJDFl2XgyktFuYCUHXs/XyzienYUa9xnF87AlmDecxGtofEr7HXMaDlhOseD5g4p1hwnlkhrMVvZ1WJzXe3buAhhGrNft0JppqWYk/trYgxA/tT3GIwOu4DW6WhDUyMh2JMJQFp7YZrWFNL1M1ATQMWQ+F3rdk=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7815.namprd10.prod.outlook.com (2603:10b6:806:3ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 02:49:39 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 02:49:39 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v2 2/3] btrfs: use the path with the lowest latency for RAID1 reads
Date: Fri, 11 Oct 2024 10:49:17 +0800
Message-ID: <5dc93c29ea3b5c8f6049d38bd968c8caf143ca7c.1728608421.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728608421.git.anand.jain@oracle.com>
References: <cover.1728608421.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: ea31fb1b-d7c4-46e4-71fb-08dce99f59ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iRbzvdTa+dnC+qcGH8sQbS/6RIKc+8bVjfCqCHqvM3ZMiZLBoR+W82gEo0rG?=
 =?us-ascii?Q?6VLSaKeosR9BnLTwHPfHH5fifHiHyGh91PSiRY1Fs457XB+EtG2TDsC9Q4AF?=
 =?us-ascii?Q?dangR/KY28Q6/ltkKW0G4KLQ8hZzFtcAoYOTPwUQzMl/JoRXo+b0ZhveL/HE?=
 =?us-ascii?Q?pnbcn3PhUYETS7EvX/EKgqN4nXf928Dk5Qt7o56WdhHWvvE4ZdquvCCThRQS?=
 =?us-ascii?Q?BrgKv4DqCouhO1igoVR7ZDAjBwrrDB5+cR73ZzT8cXH1Q+RVVy5Kk6X90q50?=
 =?us-ascii?Q?eCk3uvRK00pI+RqxCBoZIWofrceHVlKDUYiegrLlWwsngTSerkZZ3QyRVAsz?=
 =?us-ascii?Q?7SUzLr7Yn+ekNgsFIwxiCBT/p2NXcSdrxpWK0qrjZo5SXbNlsesZO+vb/U0X?=
 =?us-ascii?Q?rpP22ag4fa8vuck3+s+r+mcmEUsfCEC0t3qYL0e9Jn1MYeojlu54ZwTtuns7?=
 =?us-ascii?Q?fZTm1bM/NnWuowED+HogH06RWhZk4wMvNeC/IrTEG2OfLc89NNLZHPYylecw?=
 =?us-ascii?Q?5RdppmIfBqS195BlzE/0lCo7qd0aFDHd10fi3ls1zh9VqwAqOkCLYtANfCU5?=
 =?us-ascii?Q?ebGrDde8BArRhpHuJLNRB4CcNoHgquumhGS6ZY6Cjlr1/9c4ljO0FMmyd4HA?=
 =?us-ascii?Q?TlM6FXxIvbsvg5i6zH7zWBGcCXgPWvJ/U2cm4EzbL1lod5CD3Xr8YB/4iJTc?=
 =?us-ascii?Q?Rs7wp1mKFkBcLSgjgSfNY8lLxOqhBpYs8Zum5YR3sRORMJvdbXgBIqh1FBEa?=
 =?us-ascii?Q?Sbm0RBOTOKDkOm5eTLze0Uij+k1MfMsdf1/8w9EZKSsfH8PBguRr/ztzCP2W?=
 =?us-ascii?Q?C6vKo3TX+CIXxfCN3f5NgTDpparQfGXUruJsDJWBpHvHZyO8lgNciA664O5G?=
 =?us-ascii?Q?9/LTYzE9rk5CiNMi1oT1DzJQYJiyH5YY0LxGDdUbmGyVJqMV6qerTN7tXIm0?=
 =?us-ascii?Q?aWKredVLY1I1PWOclqel2elwSlZ8AmQhRZQ4TGMLGXvk/HXk5cxQ4gDUtlnB?=
 =?us-ascii?Q?JdkeWRM9BwE+Gn1oU/lYZzdQ8eZryE12DrBnnXVhq//qKrYiXLcMkOxGbn3f?=
 =?us-ascii?Q?f0hux8hDzt+q2FAzRArZ54brZ6CvBz6qGzcmkFr9LALI7wJ+S81TkXDAQ3my?=
 =?us-ascii?Q?bjk3yXRHA7FUBzY5GS2UdjF9a5uRoslSTDJcKwqrElOimaDDS2f1JmzVsnVQ?=
 =?us-ascii?Q?GBh9Wsr+p107VDRai9RDt9P7ZnNfDw5sejyMq6J4Hk/KeBTYiq2uWwD+K5+6?=
 =?us-ascii?Q?EfNFum+pIpZYn6IUT+xr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3OQO1QiL6SwiSb7zNKX1cEBUxlEp4b2SF5THqkWOEPa/4da5s6h2cqKvrLJ7?=
 =?us-ascii?Q?RQPMIfNAh3oyuihw4LdQ6Wqnw/cJzVJDd2Eqzc16Kjg2kxnO8OtDz6ssxg9N?=
 =?us-ascii?Q?Rjn2PMWfdvoHXSkxPvQsIh096TT7gUSgtbRNG4Y/TKhz9/K91ieNQIh2Hrbm?=
 =?us-ascii?Q?yEdyuRmVap2PTMf4f6fUoO1hnAF0IAVj+he1XIiKMNef7rYsuKYKN952+uMO?=
 =?us-ascii?Q?RmKnSr5Tqv4HAFPdnfjKjImGCKFCTTyYnxJAWRAEZ5yjWYXuncEzuv8yoD19?=
 =?us-ascii?Q?30YfAnwKJFowiv7kIP7rq5LxyaXwZtivYTESZ3Zuy42RvTIzbuGDfvya5pkg?=
 =?us-ascii?Q?Jrk/hYEpupY9q/DQw0Kk8iqSd5D5KLL24pjDiO4B2ZNaiIfUjuSg6gno2vZE?=
 =?us-ascii?Q?jC1FC8Zg+Mu4Yr8ShYsY1FRmXWcWmrYUFaCcm3MSgzHzxpuWT2wwsgKrbBLx?=
 =?us-ascii?Q?gEyfg4qSxI0o119cQiStTlOFYafndUJolMf3y+wQu9Q4tCHFx4X6Z2Yb2NJP?=
 =?us-ascii?Q?8uhaxhmMAmrt3KvLay7k1rk+Esg46wjC9jqiIG/bKBrhlysK00VcMVkcAH4U?=
 =?us-ascii?Q?CCz0gzamEbEhoEuYpc25LY5i1ueEueb3tpNcHJqKXCNMKhxNXZHS7YQWr1Cc?=
 =?us-ascii?Q?qmQ4fiKzx5EC5JUwz6LzbVlFjOpMwbjdKXzcs7B7VyvRgKyaDqPViRwA6pL8?=
 =?us-ascii?Q?TzwKjTHnqhIjbPHhre5Ky0ZOdJ+9Yy3dGt4CJNyuNapwDN06cv3gOlnB1xvO?=
 =?us-ascii?Q?2tU9vM0Pr31XAvuEcG+WdsZIc/xwyFhf1jlg6ZPBiOLBvIwZGWfX2bzKJirB?=
 =?us-ascii?Q?FMODZH+ipn6DMvtfyTI66Rnu3nyQV+osA1UlgvrqZI65UixzU834Q7IRbOag?=
 =?us-ascii?Q?v/h6YQCj1I3ds7e3y8nrDJ6hWbvxgpsX9EAc+kRl8iIXUdcCSYahAzDFPtaJ?=
 =?us-ascii?Q?RaUOQ2TxYR+y480m+RxGk1Co0X31PBJiS3XQtgGDd5A4BNivKaHGyJJNknga?=
 =?us-ascii?Q?6ADkYZotQQF9KAPDTXgsTCEmmkMwBjc90sxAgCkYpWBoGFMQxyyJSa8fXbR3?=
 =?us-ascii?Q?7nNKROYaiUtGDOV56faIsU66nvX6AZHRacz/iXeOPliOcEigzU+n6uzM5HGa?=
 =?us-ascii?Q?sL+ZgCVjbzABvyWJuPh2/DMmvD/6ARpAKCERJmh3Q6HHB/UOyyzRCA5rxk7w?=
 =?us-ascii?Q?gZkXDaTmkZjevZ+GxENeHbvNlnNL9IGKw+I0vrrpo9QTswZarL63+yP0ZC9u?=
 =?us-ascii?Q?QU9pJzubEhPIN5mOQZRFeC/JDbKxqkocztQ0W/fEe3wAtf98jBZq4bIZNuAO?=
 =?us-ascii?Q?AOTEq/2Fdm22OU63MFWQHrDNeY/vF2VdbTpkIwWes93ShgFKJMlfWmwMNtm8?=
 =?us-ascii?Q?kx8UsQWsVGO/hx4qpNwBaG5AM4sIQz7/3K2QpO9qFq46MmD+TDVJRBOKuCdX?=
 =?us-ascii?Q?yzxHIUq+3iowfo/Up3ZQScqzP+p14iFsDeD+2MayBSE/LNlrlHX4kDx9eaa1?=
 =?us-ascii?Q?D5Q3G6f4rlHfdeI14CwHp7HMxThfP6fXHRQyaJtXnzSfR3DwlhK5lQwbcXYF?=
 =?us-ascii?Q?yLF0+uOJPmCzNC6IHqwdtWrhCEK4rL5tiUG57RnV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LT9xU6h3vKvcRJjDHjCtfrICUEOBMt3++/s1FTSX3WVghU1cqiVKWmbeL3y15XMzr7WxWmF7izeYoWFvq19NJjlrs6L5wDfO/63kn9xkPCnEjGdzVnevrXFz6K5Hw9LVOcqZ1YaQ6Fc4Iwhz7A21do1KFm6CGiMPvNJzt3bFXBomlEBiDnOI31pfC6lCPH6QPcqweZkEqFxNBN0ulJyT1IEukVrrUCiQ/o+qHTzkEjd5JqQGDFKIte9DPbeDqY2ll0C/oEgW1Gv0h+MNEiIohFUPnC0RRYk1jzxRXAchQ0EZ7QLux8QCdAMtkJQr3jOQujxJKqBd803p9PlCKIv6I1QX4nPZzc9Qm3YqzWNaVcc1qLgysJYWb8hS5UFclpVCwkB5KNKh1rJjyvaCpupr9Cr0cPQS8uIatMsyiZ3j6WA6FmT1+mMWmtyUFvZ1kDF3copQk0gQ/KHF/TUTbCUprleJrUt/IgU+ocYERWKllhyp5TQXeE5Pw3C1uC07I53G7cnh3m8ZYFELHyHs3HHl4z+ZaCvRc/AAtaGuNm6Zqy/mNuahPb3BwxLozLJs1Cq/NhyQ3e8XhsZmCYckkRJCRYTOnJsaf+6FroXo4RePREw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea31fb1b-d7c4-46e4-71fb-08dce99f59ec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 02:49:39.8339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sR/mJQ8NWXmgDEPamSI5zggiktRcMNR8W7gkN96t0L2deoCbUqfeq6ESnf8mvplde3eo+KyTIMBf8gXtivLzcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_19,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110015
X-Proofpoint-ORIG-GUID: FRPdFSHA3kKuJItkIWyhB-pqRc69Wvhf
X-Proofpoint-GUID: FRPdFSHA3kKuJItkIWyhB-pqRc69Wvhf

This feature aims to direct the read I/O to the device with the lowest
known latency for reading RAID1 blocks.

echo "latency" > /sys/fs/btrfs/<UUID>/read_policy

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c   |  2 +-
 fs/btrfs/volumes.c | 36 ++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index bacb2871109b..9f506d46a94c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1306,7 +1306,7 @@ static ssize_t btrfs_temp_fsid_show(struct kobject *kobj,
 BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
-static const char * const btrfs_read_policy_name[] = { "pid", "rotation" };
+static const char * const btrfs_read_policy_name[] = { "pid", "rotation", "latency" };
 #else
 static const char * const btrfs_read_policy_name[] = { "pid" };
 #endif
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index ec5dbe69ba2c..8912ee1d8b54 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -12,6 +12,9 @@
 #include <linux/uuid.h>
 #include <linux/list_sort.h>
 #include <linux/namei.h>
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+#include <linux/part_stat.h>
+#endif
 #include "misc.h"
 #include "ctree.h"
 #include "disk-io.h"
@@ -5963,6 +5966,35 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 }
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
+static int btrfs_best_stripe(struct btrfs_fs_info *fs_info,
+			     struct btrfs_chunk_map *map, int first,
+			     int num_stripe)
+{
+	u64 best_wait = U64_MAX;
+	int best_stripe = 0;
+	int index;
+
+	for (index = first; index < first + num_stripe; index++) {
+		u64 read_wait;
+		u64 avg_wait = 0;
+		unsigned long read_ios;
+		struct btrfs_device *device = map->stripes[index].dev;
+
+		read_wait = part_stat_read(device->bdev, nsecs[READ]);
+		read_ios = part_stat_read(device->bdev, ios[READ]);
+
+		if (read_wait && read_ios && read_wait >= read_ios)
+			avg_wait = div_u64(read_wait, read_ios);
+
+		if (best_wait > avg_wait) {
+			best_wait = avg_wait;
+			best_stripe = index;
+		}
+	}
+
+	return best_stripe;
+}
+
 struct stripe_mirror {
 	u64 devid;
 	int num;
@@ -6043,6 +6075,10 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 	case BTRFS_READ_POLICY_ROTATION:
 		preferred_mirror = btrfs_read_rotation(map, first, num_stripes);
 		break;
+	case BTRFS_READ_POLICY_LATENCY:
+		preferred_mirror = btrfs_best_stripe(fs_info, map, first,
+								num_stripes);
+		break;
 #endif
 	}
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 0db754a4b13d..f9c744b87b61 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -306,6 +306,8 @@ enum btrfs_read_policy {
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	/* Balancing raid1 reads across all striped devices */
 	BTRFS_READ_POLICY_ROTATION,
+	/* Use the lowest-latency device dynamically */
+	BTRFS_READ_POLICY_LATENCY,
 #endif
 	BTRFS_NR_READ_POLICY,
 };
-- 
2.46.1



Return-Path: <linux-btrfs+bounces-15778-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94F3B16A98
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 04:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D015802FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 31 Jul 2025 02:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F1823771C;
	Thu, 31 Jul 2025 02:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k7TAFASc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cZbdOKnc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039A52367AF
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 02:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753930583; cv=fail; b=atX5OQyeM1Bnr0cjaNG33Bc9+ObE9JmWaK5YdCo5Cel+owxiHRTsyBrYCeW9QbeukY2dLSlYd6pIpewlv+H8szMors5duEmyG8FAowTvRaPQMwllxfGCNflgHTcXw59co5goSpX5qnzLsrIsoJDTZ8P6xlz9jvVS1jC9u4VE7PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753930583; c=relaxed/simple;
	bh=Y2ZeMzmTtTZAsTnJE6/tGKAPZQQirXoEx4dNb4YNnGw=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=Ytk1SJfw7Eylwm+3sllmGyWyOJu4p6v7NFqXzuEeQRxPtNuNdiPZav8yegcN1QA/8EdWOSIiLqJPqzYWmjSuPdGwNS3avO5M2FiqmSHrIVgEfVhXdSH2FgKG65tRrP6hJXhuJ5Fwe85XA43UToH/9sCZfGmVLvlzoeeDiUjoWUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k7TAFASc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cZbdOKnc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V2fw4K021475
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 02:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=lC2YMMg8JnpeWCbf/b
	5OiwHoVu+8b7Xs5fEWVqSCQ9Y=; b=k7TAFAScwpyVrBR/6SzSnwXuCYfuWw7BWJ
	kRVoGZIXlKVHN/Sko2mpdpfzHYuRimj/FG11L4YMRkNs24Mv4JPCm4tmua40mADF
	Kgtl8A4U2hnraRr9ZeiIwvftHAX5WiejR6ZCCSG49D5PKgH/aEKWRLQlkDXd/GQB
	Ln8u6N82n+72o/FVfMojRGpdkDs4GWGXmxnwy0TIEHlApbqXgWfsf7N5cU+RlS9I
	U8dxyFF6gBfeLow/gscn6pbOI09jHNLEX0MDkKWe9HUCU0byNB8nmYIeMlEDB6pL
	eKtOYEpkqm6Pt02+1QRis4oq/95oSkllVZJzJ48HKyDK5Kd5wbfg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q7336xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 02:56:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56UNkLkG021096
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 02:56:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfj8j64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Thu, 31 Jul 2025 02:56:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3kFApdkazCr0PDcfW8lY/ZalwUZIw0CB1UxgZoFN24urHzdHBqUKDtw/uYNISJvgRd0j+yVEgfW63X/5BoyrRc1ycRXIEiheUGqsq2E5KI90p40xgNth2hjs2aWO5VlLNg6skktPieH/1SwpFZB+/BPdNRpjf+l9HhBk3hrf4rxw3w5AMCo2lIWeyc1G6nBMUCGdF/Wxf/CBrRBy01SuMSpPzvzGqCFgKSFZK6gKMkXlJfhdMqPLLN0imDYvZybOIU+fx9aNj772YJbwXBR8+JN/+K0EUK2EeChS8EE620PdL8anEs/0SlTDyq0HCyk/+bwSWe93PZdprJ0XUvC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lC2YMMg8JnpeWCbf/b5OiwHoVu+8b7Xs5fEWVqSCQ9Y=;
 b=sftmQOGu59hjv/FEFNVJ6mTYatJEpBwbBaXaw4Y0CgQGV/woDtVb5W8EPUlNoChKQXgZXjAX3vRDYcCbUS/FTm2SrghO1ntUitjXRzum03tVlxR7ivneSVL7rU5OoXnFl1o2gJd2mCK9HMcXaQrM2ehzKzqVRZCC+Vv/BK2jZmw/mu+6My9phY7qCranmoryKatwaCUEnFYqVS54cdX3+jrgpmFMiFDiSYEwJKQ0PBySnv6dllw478z7ubCVNmvKY4ie15m1NrFoZ+xxi9dhwNkKVL/bxXyBwXpgb2HANF/QcBJj9a1W/s8XghqQuRqaBoaJ3Ua6pntF2KFhoyZULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lC2YMMg8JnpeWCbf/b5OiwHoVu+8b7Xs5fEWVqSCQ9Y=;
 b=cZbdOKnclbMWw7FQSdcihJUgLPCdJx7vVAg4hCNud1B8vWgEksiZW/Utsrlo0u8n1rdH/3j0znsaMkD37sjPK6LfAx1WC5tIxBRscI2ThLtu6ATePBV3ordI6evYQTmnCW6YEm+KtgEsUEydyQIv8IObYNMJVsY42Gyomt2ku3M=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SJ2PR10MB7059.namprd10.prod.outlook.com (2603:10b6:a03:4d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 31 Jul
 2025 02:56:15 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 02:56:15 +0000
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: use zero-range ioctl to verify discard
 support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <2f9687740a9f9d60bdea8d24f215c6c0e2a9657b.1753713395.git.anand.jain@oracle.com>
	(Anand Jain's message of "Mon, 28 Jul 2025 22:36:52 +0800")
Organization: Oracle Corporation
Message-ID: <yq1ldo5i0jn.fsf@ca-mkp.ca.oracle.com>
References: <2f9687740a9f9d60bdea8d24f215c6c0e2a9657b.1753713395.git.anand.jain@oracle.com>
Date: Wed, 30 Jul 2025 22:56:12 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH8PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::26) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SJ2PR10MB7059:EE_
X-MS-Office365-Filtering-Correlation-Id: a36ff3b8-f654-419d-56bc-08ddcfddd061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C63lrMpAYPOS8rmB9ytCPsZAOe/R4GuRHf+YlhsGjGSOg14bbU6Me+u7a34J?=
 =?us-ascii?Q?MwhwEwvokhuqz8eAc4fu+vBwH8H4Aa8yb5GSaaemVvHZNbYe+RTQV8ASGX/w?=
 =?us-ascii?Q?cxte1YwEpXdM+59um8iPKBM+Y+/R1dt0FcAhNWfwf0uULNJxm7bkQYAmxxmC?=
 =?us-ascii?Q?H7fl2Mli1+bosQ4ihZAbAF+m9y6xxeM6dylJTGmL7hECEE6OWJrVGtBQY0uy?=
 =?us-ascii?Q?JVXAzSP/R/GXy44kih/hyC9wegIuIFuSb8soy7KL5/Pcj/KfrgbGG2j6Q2l8?=
 =?us-ascii?Q?OGN4NijQPm0PG30UR7A5Oh4PU61wUekKfue1gVL7ek+HGIB321A7qvUQ0KsF?=
 =?us-ascii?Q?oTSA9F6pLHxWwXziiXPIspaJOOYAIY04yGK10Ow1Ob7Y1VhAJmeYx0rK1pv6?=
 =?us-ascii?Q?tEoTajp+aQWqqIcZK4vx4gCzTMBnQMx13C3H5wfEnapP6l1AU6/pi37lfWvi?=
 =?us-ascii?Q?jJAi5xzeHNRBuVGBAezP5ZvNd+/SGar0lCe9AkXDOdI0rGQg/z4KJmFykQpx?=
 =?us-ascii?Q?FOLUKU3uPQ+dQeqotDRDqvTODLAfRF6XgWseG7AT8zrtnTkKd2CKCEAjaCML?=
 =?us-ascii?Q?kR9Y+i19tO6u7q/GeJ4BKWdyamEHJ9DjnKVL9tAiICVTbrAkwj43Er37SDQ8?=
 =?us-ascii?Q?rFGpfZu77uwc/4JkbCh0Ak688T9g4ZFm7f7nw71HpayINANNsfoOuLxZsO9e?=
 =?us-ascii?Q?P4qHgDUvITYaz4aEyyROM73wyU9Bt2f3gQykrL5g+fzNc19MaPvfN+t7U6Q/?=
 =?us-ascii?Q?mJTHnlaUBz1qCb7EgqBioejsdwu0+9Vpbtg1Eh2SN7/ZIwxDAqn4v15eFJek?=
 =?us-ascii?Q?AX7euWzGChkC+9l47Vgmj2YOKcSwhT5lhIxeZUAgUeVcEm2U2Yigk6S99YEl?=
 =?us-ascii?Q?rm1aqVOXsSmVMpUzutRNv6SNAooMr1SUNmqqyM7RhJt1P66FlOicxNlOMoMY?=
 =?us-ascii?Q?7tQRugZvrDTYxpG2D2ST6f5D9qo4xX4mswjrAb1dfYyUm3r3hXpAs3nYdbWl?=
 =?us-ascii?Q?ZxTG0yiy3ir3+4C6WmXXr/zzBmvzJG58h9VbvKsqnJw8L4dIOwQnBxtvE5ZV?=
 =?us-ascii?Q?5YFMB/X0qhhMHK1m1mOmN//CuymPi//x2ljnaZk8kUWFS+iXD5AWJqT0AQDi?=
 =?us-ascii?Q?omAFJuIcWxDwd/DlPwH/c6tkEzh3LVqA2ttAm0SHDHEakQcyyekTPSBMcdLE?=
 =?us-ascii?Q?a2GksaoMEeVQ/smTjkIL3Mc8Bu3CM9b665c1TUunfUn1qUIVAEX1Uum0OBiz?=
 =?us-ascii?Q?65ckwrWv+VVvvVHnzv3mLS7Xp84Gqpw5kqiR+k0vgXlRUJxrbsNdK+gJudlm?=
 =?us-ascii?Q?1KmlQk6P2wd0q08p10TJc2hYgoT7JEfHHflT+lIwt6CusaZM0Ou5l8TqR0oL?=
 =?us-ascii?Q?RgqBvI71QaS4VA97WhiJMbO8Cu+jkX+qWB5ISv/RyZYYqQtNXqH2vgugGbSi?=
 =?us-ascii?Q?wxCiYSo3VFw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZeD40XDD1xptvd49ahOsB5SiQayP3wiL6v7WeRsrLPK5BJ8H+pfuKwB3ef7N?=
 =?us-ascii?Q?R3T75fvrCkDBdxViSuXvzfURJQtS/5HyPE+wvoTY979gvi6GRdke2h8qI7Zs?=
 =?us-ascii?Q?9cotPw0iXUC9Nzq9JKyMIB+VL0FpOZeHOcMi9Xy5lHEWLmbPK0R/vVvxIMLK?=
 =?us-ascii?Q?OQipI+y+0WENJduDdaTS0DG1fsSPTYqKBIxNisXdyYe195W/tmn+HGldlrty?=
 =?us-ascii?Q?ZpDmVhkER9Cyb00AfwK05dH63l67Z5NPJxHyHWVTvFRAaQEPBj1LtQFd1zCa?=
 =?us-ascii?Q?2YjNGjXyWV7y0hZMrgoG8DLnmMEuStmKogcoP+8NKEx1Y+0it7OAXok4wY3y?=
 =?us-ascii?Q?csS/H6bYIyzqHqzh8HpmgJpeM/49hCH2lDQ3wrxfXH7wRvg0LarhUIh4DQWo?=
 =?us-ascii?Q?MTE5OCS/ClVJtBrA1cYqpy+YLelBoTi3RoBjfoU0WqW9tRWHwen1pZ/Pjt+x?=
 =?us-ascii?Q?5y8leU2vUzlEG7sbdzMLkbVIbWghi9qJL12RqQS0D6DcYm4vrXHPtBCGYpNb?=
 =?us-ascii?Q?K6i+F6yQdR6AgZ2VOvMugWbXylz6YeXU/lPTVRBtA3InIWVhv6N0fAUUVdLn?=
 =?us-ascii?Q?uN35LR2CLqOGoiv/FBXrIuJf1EW67xnusDvzw94ylpM2nhUR4TjjStGBvoaS?=
 =?us-ascii?Q?ycR62LyfrtNXilW5U3y7/xS0JlDxAP+ulehZgDDu5IPXR9ljtUgoVoZMHFbc?=
 =?us-ascii?Q?5WornqhjJ+Bo5hN8QpGqqa3EIFwTBefUHIMoevM928Fjy/Mr7xakuah2Qti6?=
 =?us-ascii?Q?Hr5MttSnY7ykI0C52RJaBlznRUFhE5xAG62/7yU36l0BC6jc8z2N4zTzst0c?=
 =?us-ascii?Q?lON4A2w5CKY2XOndCxT3uTOLeG9SxOsFyyddsLlfBMQc8cZo3NBvUtErLrIJ?=
 =?us-ascii?Q?g/lkeUHemM5Fjfu160rwixk38uWIFHf5nIVA7dVo/xc4CiI4KhF6nt/6Whls?=
 =?us-ascii?Q?MC2jc11fvKbQiCl+Ps3lHYwOpJ+hsdYZLmuta03JamhPcTe7pCW48H4JtBgi?=
 =?us-ascii?Q?sdZQIarGWvHAeaycCba/hOD7L2IKBBrq4AQR7QvUH6pHFxtBA3WtPaVKkyw+?=
 =?us-ascii?Q?+F7bR7mS1gtJtXWD4Z1p+G7tRrcMU+Mk9yPpUuJCJBf2KxfMQaYFp5tW3Rbg?=
 =?us-ascii?Q?u2cgk6DPt998jSRXDGt2ESpqPXNTpqSPzqyLE6pIsP2YEwp3TYR7WAdDpgYs?=
 =?us-ascii?Q?2JGJKJtM2OfyzIjNdp75bSeYEjl7w57s+RPRjNd/nGptM7cOOS5YgXhpyrwX?=
 =?us-ascii?Q?C9mK9OzqOnVQn9K/otwxHlhKgqOwwISzMGQG0vvnpoLvHsFVw6Y1S1W1YZXU?=
 =?us-ascii?Q?RFQnrDIe/AZQXk98KIHnX8bzx0+zfVF8MoZAsWWZHcK90JVk+YWDX3GZToFV?=
 =?us-ascii?Q?tZpqtcFUW3PgFAMEDcySNn+E5DGaB/Ktsj5ykZ0DD/y8sjNxJwFuAF4KGLxl?=
 =?us-ascii?Q?lCNyshp9jD7M25p8G2/4+b47QuBw+B9VPxywX6HsR7rzmo952ySxPcLLxsyI?=
 =?us-ascii?Q?iHwGNJNv9n8PWuojRIpu6bXt5C8SGY3CkLnri2aVgGNSct4RdDRGoKVF45ee?=
 =?us-ascii?Q?39Fh1ilG1S5WXExLS2jR2LLM6S7Jf1sKXPFD207jsm+gve6ttMyuzCy5lCnN?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A/zWJWF//avURireRDvTGIyUdS3/onhTGlzMPF884sHQPTAMzC+BccoRCjCSEnUBja2LAeeAHQMPFZyQHqJ/CKQfkJ0M/7V1luYNyhuaNZRNQ58S/L5eeix/pJjhtZ1J/jCbOO7EDHMZy+c/kVrMD66zeTlmIh2kdgrmVToVrBOb4ODUdL5YB+K/QAt6gj/kavL16f51dh42DZ6FEsO9DFt/JG50giYFj4wzwRZfyCxUJdIrnXuiNg43GEFr3+aw/gAjItrH8rBxCwpZPazpxxGumhUvibuOA9Bi0eWl4EZBw3jrkbWXsN/L8FqVJ3F3iL1iZyckU2l9f1N34rBDCjqAfZPWr/Rp1cFVL1Gr0Q7y8MQSjKGRe/LFPkFcnPA2/qA7U4d1VbWj2dtGkB9YULWuDc53EBKa/5R6ip0+d6xVyufeB2ki662vfmTpAVQ2Vwxq8F8bmk6oWug/ENLCwpHh12+7QIMopDffD0JMPBGaMJWxgh5kU42UHbk/xYaArWRDGSnDUC9sZTpR301uqRrHQ4K7K+WD91q0n3L/coeelxPvcrTp0j5GrYi8kFzwNQq57lug5o4iDZK/NQDCGFZ0Bz65RDOofERj0rVKF7I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a36ff3b8-f654-419d-56bc-08ddcfddd061
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 02:56:15.0456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSmd9paWNAQjNCED+uxpf9sVRZwA8kYFRBxWk37IftkRy1pkmqanW+HGXvG7ta6TcJ4UbcelZdfNTCdQxV/wb2x0tgI3hxs+OOCYkWY/Vmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7059
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507310019
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAxOSBTYWx0ZWRfX/Oycx/Dx3ftG
 wZPX87vWhuMJLuMneyCf6QPTjSHg1KrdVod8hsLlzXnEGSCmfs5mwAzuECCC4QxKMQz7Arp1JLr
 b12A5030D2u5C3XRddvT98Up+n7JL/LUKzZHPqRYN0bTaF/U6fVruO/vFkqLDAweSS0MLxNdeRH
 nIy8yl+t87DQdBkHCNmzwgFQWZdYS7v0sVGq+V0EBowTLyrJMtfe/59vTppW8hxqNZ9zlaphyhF
 RRQXZl8LiEPCCDYd3PaTpw5ed4EUosmtIy0qIKG1/9EvIeYx5QQJDR4kvg2WrdpSp5htKx/KSpM
 TnlXp7Vv3jdDCulpEwmy1Ccl4vhnk7ccMywnhHqM2vx04ytcdQDcg4nEB+TCPAO8JJkkCgocQIG
 T0sGSwV/cRDhtNK/pJSx9waiwUh3XJqYuDmB2PsGfeA4ZsdHcj8CZBXcwhtMeutRtHPb/Jk1
X-Authority-Analysis: v=2.4 cv=ZO3XmW7b c=1 sm=1 tr=0 ts=688adb52 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=GoEa3M9JfhUA:10 a=P50r-DCbVM29UMe0Ze8A:9 a=Pt9jBVPitNqnk3i2:21 cc=ntf
 awl=host:12071
X-Proofpoint-GUID: zO9fQb3ZVnxtjlryhGTIxTPLXf2d57ln
X-Proofpoint-ORIG-GUID: zO9fQb3ZVnxtjlryhGTIxTPLXf2d57ln


Hi Anand!

> However, this isn't always reliable. For example, on a virtual device,
> discard_granularity may be non-zero (e.g., 512), but an actual
> ioctl(BLKDISCARD) call still fails with EOPNOTSUPP.

Regrettably this has changed as a result of block layer code shuffling.

Documentation/ABI/stable/sysfs-block states:

  What: /sys/block/<disk>/queue/discard_granularity
  [...]
  A discard_granularity of 0 means that the device does not support
  discard functionality.

The semantics visible to userspace were inadvertently changed and I
would actually like to see that addressed. Reporting a default
granularity of 512 when discard is unsupported has broken other apps
too.

> One workaround is to also check discard_max_bytes for a non-zero value.
>
> $ cat /sys/block/sda/queue/discard_max_bytes
> 0
>
> But a better and more direct way is to test discard support by issuing
> a BLKDISCARD ioctl with a zero-length range. If this call fails with
> EOPNOTSUPP, discard isn't supported.

In SCSI, a WRITE SAME operation with a transfer length of 0 translates
to "entire device". And in NVMe, a WRITE ZEROES block count of 0
translates to "1 logical block".

While we currently catch zero-length discards in the block layer before
they get passed down the stack, I am concerned about userland
applications relying on these operations being non-destructive in the
zero-length case. Something which can't be expressed at the storage
protocol level.

So I would prefer for you to validate that both discard_granularity and
discover_max_bytes are non-zero. Obviously we have no plans to remove
the existing check in blk_ioctl_discard(). But if we mess something up
by accident, data loss could result. A zero transfer length write
operation is not inherently safe. Whereas inspecting the queue topology
is entirely innocuous.

-- 
Martin K. Petersen


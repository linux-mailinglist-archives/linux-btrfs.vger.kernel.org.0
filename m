Return-Path: <linux-btrfs+bounces-10691-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C73C9FFC00
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 17:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8EEE7A046F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 16:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6585E156F5D;
	Thu,  2 Jan 2025 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WbruUWxN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iPD9/F0k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8088E1799B
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2025 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835947; cv=fail; b=gtAbt6XihzIWs9W+RkB1XzA5eN8LnyyrI2v5/yqrAJcrXEzb04K1pv/ozUNtWNAoyu+wGB431/AWaDBPiTCSpY13Af1C1sfhfwKlkYm/y6/Y1kOsBk43ubLz3jNOaVIlHNQUiYCvWngBQwacOd+rHRr+hJ5zIYSwNypJUWeQA6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835947; c=relaxed/simple;
	bh=6SA/kQSJzeEcVVELl2Ovx+nF+0YAHHgMrwjwN340y7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UScuznzOKQRIDaJyLBOvsHPWuzHQA3wvXkIHarZpCZ8kUAtu9I20WBHfCKDCoppcbcP9autcJB11UdwOGzuPqVYq1CgTr79G3xGIVNHjw0YyDIX4JYUpF5OfPjTcvlsi1+L2SCerdPubqg12wMDuioyq6tM9BT6eTEP0GrX5Yy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WbruUWxN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iPD9/F0k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502FtqrL016555;
	Thu, 2 Jan 2025 16:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=0htsMubASx9jyK298IfKVtc2gl7fUK41q5k2sR06Rlo=; b=
	WbruUWxNubcID79R+WvaJ8AiUFzjrlQpyQGVM/V9qyB0ulOvrGtzG96HJj7VreZ+
	ptWejN5q3KZxYINDJVVAut1ikKDp0IPynS6518l3qM30xePpWPQvnbegMCwG/GNA
	FkVBQtL4kRnQdGjIIlSE1pCKmPKrBoMUqGgQgvumXB22sutq47LzJ3UH3pZCHkw+
	Jp0GopsnbqxCBlZxAyYJQI2qg9OGw+rEzxmUPeKVfNlNkzWXxMfvtDWBgrqs+k4X
	bn3MTW3xoj0gOHkK04lu7vzSfbILo4MaOeGtfY9l8/NIVJY2j+Y4YLX4VjDQ+YOH
	tDG014KXNGoDOXrf3NDv6A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t9vt5q46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 16:38:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 502G4vWx034172;
	Thu, 2 Jan 2025 16:38:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8h1bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 16:38:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RiDd2u3TI6iJkUS7dWtFycg6C5Q0N/KsLMbAvvaa81HcUTOuhuusU8vrBT5wKaJUad5nLsvmjiqagMA+0goG7gj356mFwxvHwsyOqZCSneEnoBa8f58yeCULkhVR9dKpAN7DFQgLrtt9aD19qxyqbkflIyg4uqoMTd3eGNpaX6gt2ORZQ5fbja57TlzYhNsZrOW7uM0JEnGdJqrc2YqA+aVW+2PnxfOGswDw1pi97zQCVrEY3R9qA4n8drFfHB//ueqPwcWplTZCiN2QvizOfCDmgzqhOTwJiHGDH3kyM5jLfMf07mgBRKFsNhRdUSJW3QC/Akthl2fOPYW5YQygLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0htsMubASx9jyK298IfKVtc2gl7fUK41q5k2sR06Rlo=;
 b=sr7aJ0VgWNtE1oKAyTn3F2jxweThIOnS3j2bjH97U1He6sl1PSizdEK07uga/KbrXcvo5iu/gA4Ui1p4/d3poSZDQQtp0eutlj3V+AFPovRZu525wS2HRfWZK+hgOe7roVC+BSVEpUQhgVfgiq4pt39vbG8W1UIIuumLwUsj3AIBX/d1RLDzg4s4iJ6Xb9cM/WLsIrQSWAKy6W1jLCc6dYHCtNwOSmHTGs/G0pA7A1B+plS1fVUZcJ3ih7qS/yThpoOvW7mvi1GnrLrXZVHtN0IrWYs0diu8K9aGSyySdr4ncS33P/r2YshXPAMMyThxgHgtWw8aLXYt0toASCp5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0htsMubASx9jyK298IfKVtc2gl7fUK41q5k2sR06Rlo=;
 b=iPD9/F0k8ruUp2/g1UoZGk2naY18hsVrlUwJsMZYkONPvKsnOr1rpqvuzQpGMqv7mttFG9wxy8DJeir2mJhIZT75r4wR3RIPkWbBUl3Zfjm4Wnp1MVWUk9PJcDbL4hfZfNkxHtlKCA6Zn3wRv4qKAS/ay8OpdTZmYfZe17m7A8Q=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by IA1PR10MB5922.namprd10.prod.outlook.com (2603:10b6:208:3d6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 16:38:47 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a6fc:c6a3:7290:5d1d]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a6fc:c6a3:7290:5d1d%4]) with mapi id 15.20.8314.011; Thu, 2 Jan 2025
 16:38:47 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, Naohiro.Aota@wdc.com, wqu@suse.com, hrx@bupt.moe,
        waxhead@dirtcellar.net
Subject: [PATCH 1/1] fixup: btrfs: add read count tracking for filesystem stats
Date: Fri,  3 Jan 2025 00:37:47 +0800
Message-ID: <abf8061ae205c71936f60a22fab66503371be3bf.1735834884.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <c4010cee5398e35a695def3ad97d4de6f136ae2c.1735748715.git.anand.jain@oracle.com>
References: <c4010cee5398e35a695def3ad97d4de6f136ae2c.1735748715.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|IA1PR10MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 9557a5dc-881e-43ae-58fa-08dd2b4bed9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qx0cc/+yeFaNrqAWIQH69t4eAncYopoaXs015RE6X/YOss1Zu3E+HtCfFivx?=
 =?us-ascii?Q?5oYur4YR8VEkdTHmbLUbp5YUfXqCr39rmOAw1/Jqye6WMsSnVEQQroEHD9H7?=
 =?us-ascii?Q?3RS52NnQNIo+oCFs1Ea428GnskMRO9YplspslJjHuyh+3PXVvDcS68Y1LqHR?=
 =?us-ascii?Q?or3oXFoRoTXojN6e5pgiBjds5r1GrcyE1ccNh8UM0+T25JXPIRKHsfx8qQCV?=
 =?us-ascii?Q?wG+2jD9wuDg3EqywPTGYQftedY6PfwYieeIM0q2GzvZ/ubaDIUyx4VuqDmXo?=
 =?us-ascii?Q?ukmE0MYBT7lgcpugBm1npxJY0G5xD6GKRTF6YQZ05HvksEw+FuFl4T28ArWV?=
 =?us-ascii?Q?atNoxTAMTVuF6ZgvNf7ZTerESnmW5+yR+s6OIAKCu/NfZ0xFa9miL+qh1Bki?=
 =?us-ascii?Q?OKHaFNiqC3IYRKJs6obyybGxgJDGHas9Af6lWMm2hS5oVyxHzpF/AccF9rYz?=
 =?us-ascii?Q?QBIGlNVnctBsZyGMhM1YX1gYitDd/mfrheMoCNB+O0cVPJjbr3mE8AgDRx6m?=
 =?us-ascii?Q?vyBF9KaHSelOH+VJ6w5qTsT3qJVzpJ7qLeX+3V/zFwp+dx+kEpplnqZ0LMpu?=
 =?us-ascii?Q?hB+VxE6mHUM02bxTrBvt2p2Wp7sMLXhhuwupEKQ5S9RivmVsZroBh0rmarhR?=
 =?us-ascii?Q?xCbl7GSa2HFdP2VktSKp5z93+PViOmAo30eUKbVJoHmVfZb1sjvoRdKQ/jhA?=
 =?us-ascii?Q?dYVEkRncSfBWx9p5c7a8UgeOzM0tC7D2NQ0wipJey6A8nQcnnwqPQmNZ4RHY?=
 =?us-ascii?Q?c5/Bwtx7O2PlFgEb9WkJlCMiH0w9riFtcBSUCCT/+DSjaLZ0kMTtj3MHKW31?=
 =?us-ascii?Q?15FFLYV978Eatu6ORXT7B3Kdn2k6FgZXdBe255DmD1qU9A7vnfrz2WakGA+o?=
 =?us-ascii?Q?ARsy1CkwSAo/laf4VbpWgZuSoF4+siFS7Jx3hzTP5NJDcfguwzNNFbL3CGVl?=
 =?us-ascii?Q?pymTPdEV4tqb1jw2H9LrcOMz8QXowJNKeYpZbujAXQ67X7hcd5InidckfqiH?=
 =?us-ascii?Q?6wvTtXAAoOABlZHgtDMiHNbIeRNgC6gV54UMIdaOXggbRj4pdfePgCw7fvmc?=
 =?us-ascii?Q?APaSQEiDSMZdR6xXqCt5ElGo73JH4DkTDU3OR1ezl+UxJxSBnCvgWBBaxNks?=
 =?us-ascii?Q?BTnDP3K1HH8ZMfmbDnc7zWte+6sAX9xrpHntHXdQHa39mDquMltl8mBhlY2D?=
 =?us-ascii?Q?4MRsaQxPjO7l+2jehNw0L7JwACbLp0+wVURCEEv1SMKuRZn9tm5c6+3R41fM?=
 =?us-ascii?Q?ROVjGRNJNorHpcr2TPF4Z66YZakZfiwDzDtgXd1LaIHL++XedsgQV9kSw1Ps?=
 =?us-ascii?Q?e5Ij6ehhfN63R2TO9c9/OubzCYWlKK3RRhHDBVNy7oaj0m5vR6Nl3vaxVqKf?=
 =?us-ascii?Q?fDxelFlcBtODq4Eyof1/KzGciPiw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JhjGKk0NUf5pKt0AfFvs+l8uyoWn5r8BUsEOE1horu7DoD9edZ7d54fBNNsS?=
 =?us-ascii?Q?kr3iNVLc9ZIVcu0cnq020AOB2EjFVVV4Kasol6Zb3F/n9qdPdGAVqwiPqfwf?=
 =?us-ascii?Q?QRLu61ciMDbxVwXljYBcWUeYasXubOUVShqYrhjM5RvwR4P5DOa2zVTuFYX+?=
 =?us-ascii?Q?2pYqc9lcluCRUxBRXkZ1Ve5egEOy6DUJg+bG2lwDtXGXGsVkIM0lEUEhYIkZ?=
 =?us-ascii?Q?ChnnyaEF/685y9OUnTB6aKy+YfIP5hip36odcVh8f8V8xSS9Ysc8IoGRazHy?=
 =?us-ascii?Q?44A2izHUBLArfIDw7xr8rW8eCO9Wi+qoEHEeZrdEdkH5+81ttHLHLxODutlD?=
 =?us-ascii?Q?mehoEois9xb6ge8lkHy6eoUSIF1PuRPxeaMBZVv1MhcfUxvg+CEIAb3no6nH?=
 =?us-ascii?Q?OPaid+b/ogKLJXsjD/b3zPG27WuOCrsymEEHq3nK6uGQ8Pl3FZQdVosokWs9?=
 =?us-ascii?Q?ux52WBQnN165wu/Z7ifgeYzs/x3hDKbQ5vUKc0Jc7aioAY+mRjd1lnWbbCei?=
 =?us-ascii?Q?4WbdND3VHa71ByE2Zrqo7Pd9x7J8gUpjaS6mXj6EWCYy5BXJPb8Mv0WISo88?=
 =?us-ascii?Q?Kj2d/Zs/9EE2y5fGGEOZ8C3ddhBuLVETKy+9o5vJaQj1f0YDTNLpdTK4/luA?=
 =?us-ascii?Q?Oi2odY6aZ14g/EHwVfrKvBHG7e7fVe0HMUPWf1zQ+yQuiletjyIJHWowUvV6?=
 =?us-ascii?Q?GbGjwVeWVgEP8Q/ztISToVdxRbS3DDG+S8kt6ZpgoGhsMDiqw/4saU5RqyoJ?=
 =?us-ascii?Q?7G+oQsvbCQrBxI6HnffR0Ds/6tnG4URJSobufNiB7rKjx+pC7AZ4BgEKXy40?=
 =?us-ascii?Q?k08MzVsc2NqxAb/8D5nd0OZ6yhhMMZSHu48i7RIbGGLeNl4lKSCwjG/znVdN?=
 =?us-ascii?Q?SkzDGAWh3e1xs4x6pTtjXd/EHskuKFSba1AAFAKIVJ8nzLLm37ouQxavpaTc?=
 =?us-ascii?Q?jnPqvwbgLvCZ/nuRtvukXR0VUkA40xyAC9ycjBK+qH3B+8DdJMT4VwHNeZUt?=
 =?us-ascii?Q?SFiylNa+/mbTlw/Sw8e2ZvFoQE+CBiPghkU8fE0nOd/ztHRJ2u149ONhDEsT?=
 =?us-ascii?Q?3HknNqPqwBtZhrE3snpmNDYU5I0uW0+F4WBk2r52XHgxYwbeSKxRrSp6++bD?=
 =?us-ascii?Q?AN2VbYdnmWyJWdLIS62uxkKOuEi42SGXVMVoCMoh+7taQqfD+pcOxSY0GF6S?=
 =?us-ascii?Q?XJDQhlqe6whvLrRFyKge6ecgxElnP0XXw11Q+GpTdKO3LPSAdBGtxUhM94gE?=
 =?us-ascii?Q?ZzqoxSZo0jzXYldMkT28vYVT8AyYVy838EmUZB6HNrlc6FWFHKs4SnYGR+K3?=
 =?us-ascii?Q?bHCh4TddwRvxg28TmZEsc3iDFHvwuWir8oWvbLK2CBYqdYHCPRGLicYhuYjt?=
 =?us-ascii?Q?imTrz8xkrZCXcx4XIroBIB756BzgmTmyVdmFqmQwZnlbUjYIkEmQJIqWFXZ+?=
 =?us-ascii?Q?APRGXQ2SMkbZ1zY756W8OEC4fqsNy9vSByr+X5hB57CuEQLEoaLL39GbUXKC?=
 =?us-ascii?Q?/yhZxz51UgAxRIxnOuYijiF/SYY3mWiOJ4Z8z3/c77q8FWdHS5RWxeNXxZZN?=
 =?us-ascii?Q?Ql9/xTZiCty3CuqtR/41E4jlFw4/vfXRlQu/xgGF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9Lum7oiW8eZlVUUvLEa6BGCoW7Lvf1oA7QpOslp5mqBwPJXqPpl6G1By+GwjT2pDUdp+W8LfXxo/TiMxX9niykJbdEeybrMopBQr7qUOJbOgnD1vopKw6BhRHWBj3yh0xLDZ3ouqITRirp/eBjyj5u4lg13iAoeZBF/qIIcvpoP8Vyn+QghksFpkRVqKgCNHQBtO27HPGcveOnfqtLb6b7zLN4TnD1+/kkpQrTskjObOIM5npkALhkdkZPtAtxQN8REczBD86T2XBNr2OFB8cosYHj4Au+E6vk8BazLvtfbzahs2NXtUo23Sq4TivFFGDEANOdv94qvOeTKSG1zNgA8Bxw2UpFwJ2p7T/gR+WAz/RlFpodeu/umh8ONCSJ19TU+VCIv+xXgLJDJAhO136V7GcXYv1tP6nJNwyYjMD4ZDhxdKC8dv+9DnlzMz4btVuPFNunzTtfFKOtCl1fPBItOyBlBUttCmmp0ZWpqnAO9BYYAN28vpHWQOOc5ydIUcGgminMsuRipZGi83t4v+slMpDias9oUf8XZiUfeBkC4P8oY06lfHYXOSLw9+gnIKxcU956DqwHUklOtYl2jHcr4DGR339cVpkFUAJzuyDHQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9557a5dc-881e-43ae-58fa-08dd2b4bed9f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 16:38:46.9568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ffsaqdng/7SCrXFd9CNh3nqCxccW8OA82rWuQUS0TSd1mgqO6DGq/phdKM8g6stCEZoa3Tg6JkQz13pAqc4wJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5922
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020146
X-Proofpoint-GUID: KA93IdOyB30argwo3gAW0Mt41mku5zgU
X-Proofpoint-ORIG-GUID: KA93IdOyB30argwo3gAW0Mt41mku5zgU

fs_devices::fs_stats is disabled by default during allocation. Explicitly
disabling it in open_ctree() overrides this setting during device open.
So we dont' have to disable it in the open_ctree().

This patch should be merged with in the ML.
  btrfs: add read count tracking for filesystem stats

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/disk-io.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 79b859790e8c..ab45b02df957 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3481,9 +3481,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_sysfs;
 	}
 
-	/* Disable filesystem stats tracking unless required by a feature. */
-	fs_devices->fs_stats = false;
-
 	ret = btrfs_read_block_groups(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to read block groups: %d", ret);
-- 
2.47.0



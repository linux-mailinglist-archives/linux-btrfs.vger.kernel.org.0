Return-Path: <linux-btrfs+bounces-13922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B73AB42A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 20:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F419D188E2F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 18:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C672989A5;
	Mon, 12 May 2025 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eSXXHuzj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JII0By7u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD3298992
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073277; cv=fail; b=o076AyCq2ZxRABbzYzd9qB22QETFZ6vRC62IfT57LrVMKZzzzs97kGqgM621i56GHNtADdM3hilaPz7fGBPk3r4Pp9mh6PTghRW4Vw5ZkUtlccIbfk5TW2vPFqQdI1ytxuRVZFy6uop66F/gQA4TY2ELtUhBd6CaSsSAib1JOGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073277; c=relaxed/simple;
	bh=HygovkBkT1zR/PSlp6CkK1KYC9yitZ4y2XVoNkQ/F10=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tgIO6pYplZolxQwhwY4OTacgF28osW2KFY985Oah4jsXsHd3hOQohwv8UDSZwdD5SopRGVzf3uVhMTmqTZI2FlPOT/tPeItchd+15ezwMyQmBjpJloFkXI9LhyNNTx8U7l53wjkeFMBIK2BRq0b3CLFnuCJcKpewIt4DMiLLKWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eSXXHuzj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JII0By7u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CH0vkR026920
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vlQwBsyEk63s1UUqjKC/UgP67hGubVmXghUcoBr4K+k=; b=
	eSXXHuzjhY5N3kp2PmkMY1Rbge8pLalr/V59oAsP0WSJgFqFUxep2T1gJk78x/hX
	RPEkdPksa/SbUeTYjJruhjCrgPZWJK9GwIhJhAlFVEfQYkVKCdmZMVUVeVqh3+t+
	kuNzd1H5IW83rQF781ttWoz7+1od8dwGgX3uAc6+X0pM84ioaekYd6qnAu6cjIvY
	E7hG8sTu2vFe0ZulQVcDBR+28k2pXsoOYSojv/aYIluuKGjbDJf56pFnXvkGNa8u
	UWwSxaI/O4USoyyQf4w98OLlAzkJvcbO1eXzX63kOm29nXMsxtTdsi767vpF90TF
	H2uALi42ESpUwdMl2lhgjA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j16637r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54CHaIcr002469
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:54 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013075.outbound.protection.outlook.com [40.93.1.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46jwx3bubn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Mon, 12 May 2025 18:07:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7D8Hh8rWohuHj5b1fhVdgVx5CWCYyJ/jJVEUcPydpoCFAmZ5vwIum4VqkrdgR/Wl4+W8D5qcUXqYBk2X8T17kx+B6Z5FesGhRXeqxhXz2Jp+0j/wvMeok/rx7QfrBJoZxK28+dKma3ln5DJSYnhMdNy+VUJ3EOoFFs0YUx51zApDeOaajrt7yomjDwnVsqM165zz5KhIIbg/4jnk1DOV1NDdbLlb4FagjkJOgNtdTwbuImuFaOIxJDgUNmncBs+YJttAdT2/iCZTcA34N4joLSJtspGPBP0P+bfrJKKQ/gt0ivX4osnJIJetmyu/RRyy5I86bDNCsBZnr0HhEHrTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlQwBsyEk63s1UUqjKC/UgP67hGubVmXghUcoBr4K+k=;
 b=INyMUHaA6BHuqtLMONE+J6/Ja8kqQGZVJU7Tx+4dEzOcLrpvF+ZclAHwzpsiM9lzwdvR+ni3qKbt5i2zq9JASbMIqiOpFOkPsGBwTZEMuTSSwlk1/qy5TV8si75CBfXCry8z618aKklhaNaUmhxDO9xRcGXvS+5dU4HwzhSt0+t2adhzFKyYfVXvfxnsjMSlho0eJSujKJe9pNqbRpmyxhWxaKNmA97tG/huGvPybqdiTNCJh0t7Xhm1Vzqpk9wtSd6PgiunYW5X1S83jwjsjRiZffLv0ojCX0VmP3h/26+TnQrMQCgb8jgpLet1T0SheyviBqRr21lmcdJY415hOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlQwBsyEk63s1UUqjKC/UgP67hGubVmXghUcoBr4K+k=;
 b=JII0By7uehXKAi7WmCbZMJPgVoQ+LE1sKTU06j+2vNbOiAW1StPoCVRrdUdfK8kHP/6d7zmENsKr/8E8prYTCU9TxQjlL8s3tfaW8xAEJqL9od5zTrqPZr5wn4d8KPBzAV24cynqTLPEHi009b4ODflpfGsvhgj1YdXOmhWPDyY=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by DS0PR10MB8199.namprd10.prod.outlook.com (2603:10b6:8:1fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Mon, 12 May
 2025 18:07:52 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 18:07:52 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 05/10] btrfs: sysfs: show device allocation method
Date: Tue, 13 May 2025 02:07:11 +0800
Message-ID: <ae239bc6efcec1da5c600d459c18b7a37d505364.1747070147.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747070147.git.anand.jain@oracle.com>
References: <cover.1747070147.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0190.apcprd06.prod.outlook.com (2603:1096:4:1::22)
 To IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|DS0PR10MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0f6fea-5baf-4474-5aab-08dd917fe971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cM+2S/nB1c/IR77Fkg7tCXN68+s0+HNFtHKKq71sjRZluRyvhdW9/9gVn78b?=
 =?us-ascii?Q?EaRG+2GGJnw3PElKsbRjj9vea8r+SmyNcUIBMgchSTYRbme5HfebYW47GV5E?=
 =?us-ascii?Q?0s2LQgeKhWtrUgy62EVX6mFZP0tvx7HrkUB/oSSSNBv2Qy+AmPnSMESbhmzt?=
 =?us-ascii?Q?nOZP1iZtbSOWU/owXyT7ws4YYkAS2OkCHfdI1Fag0HRdFNB4hMvf9bs6lw9V?=
 =?us-ascii?Q?oVL3bj8aFwCr0Hjfb6Hf0Cce2zHXLXLis0urBH5ah5G9VIsq6o3aq3q0Jy3U?=
 =?us-ascii?Q?9uLIIpLGw+r5D098jg9/xoVcr4n5scsP/hMZf28e4ncfgw6r2CS5+vVjvdJ3?=
 =?us-ascii?Q?F8bkeZFJ27FXw0Zd4s9bqU0yefWWW1mjsr2Uw6Wg00klFBYR41n0dz8ftw3f?=
 =?us-ascii?Q?/LulrR+FUhJQ7Bc1T4fHK5QfiJwWlfTg6T9foMmHxur1sBYIEZvkpEcLoU7z?=
 =?us-ascii?Q?NX1OYzCPzslHldwSmkpMkTU6CWOx6LV6kicaswgiifCwnLClYuA+A1hAcAST?=
 =?us-ascii?Q?mnZPlSM3YBZpAyzu9NLtjw1hctkXM+EgzNC6Z3lsw9TXk9gB8cpIQUX9vGwf?=
 =?us-ascii?Q?OX+aQ/RIX7EJnon3fDGRESESezldk8RzXKdkAa700A4h9Lk4uCUkG35uGnZf?=
 =?us-ascii?Q?TYF7DAyeJvnxG2JUcQu8kJh7+LF2zfgiN8w7XyDtCjgxvZNQrde/J3X6Ye7u?=
 =?us-ascii?Q?GdRi8hf1i17TBmGVf2TSVi0oK4nJdmm31lXNG6wulrbgND6aS8RN6qVG/10a?=
 =?us-ascii?Q?o8NHfZAuoe6FSApSbhYSw5E9Y4ZQu+elD62iNAt8j6FLPBIt7TGJXSRN40YP?=
 =?us-ascii?Q?9lZJOGKF/cvv3dxPK80QDSba2BaSLaQkLM8cvd2cIG9kIcMz8uEVEvF87a6h?=
 =?us-ascii?Q?ScZwmrWJc0bLIv8AD5mIG1duV+xMyuAAk854AVTU5Efofc2+H79tgK5pNwGK?=
 =?us-ascii?Q?CyvlIhN6H5z/MzaqgKkgYam1RdZOcx+XC3f9Wh9y7CPQtEfmDWqvQ82wYkYH?=
 =?us-ascii?Q?QOIHbUGtMKHA5mQXciNJ10vSwnOMvySiXPQqfZZ0dV2klSRVcXBwM8LFBvVg?=
 =?us-ascii?Q?j5+6ThclM+Y9fApCzcYreo4HkrS3LlfFTLlUGoQX4FPViVrH0f9IeTSHQMPs?=
 =?us-ascii?Q?aKg91QdhECm/IGef7S8YF6VdBnaj6TkXBYqXfVIgr967em9iyQQSSid7W9RY?=
 =?us-ascii?Q?1T74SoYDz9qHWomdfvYJVo2qHxlcb46m4cM+d80JIcPR9HfJFjD2IuCxV1Br?=
 =?us-ascii?Q?wmitWo7eX2Ndg3JhZPDtLewZQ5Zcl1pdXR8EjwBARLUSk+5vObxzBaWcvLZE?=
 =?us-ascii?Q?ez7wn8YFb/0ruCgfgjJ0vgyhynswLz9q9FrEdx8tH+qhIpnFgV0Hedxqq/jX?=
 =?us-ascii?Q?2zlGJZuUqKm9k6oDZoPCZFEdI+hMZB4jlwbcqUhSohn4Cskc/AifoBHjaopV?=
 =?us-ascii?Q?iaZ5kMwm7Vc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZIqAvhbpawcOmKDvprcdrwdJiUDHFHC/eXXekx7/SYjh5q0CV1OBnUiAEc6E?=
 =?us-ascii?Q?BuA2PdeCKWIQ24fMzF2eErv8K2AWuLBGX+5iuFByuko+mX+PMaGjXJwz4FhH?=
 =?us-ascii?Q?FgsnXCtD/7ngDEHLDFK9k+Mu2o/cQNldX7Slsjw97O0UnSiV0deSr3b1rwr/?=
 =?us-ascii?Q?Qzc5qMrDrEux7YShv7Z5fWA4FjGiAcOKPf5hymxQ1fCdsnr/g0H+WV6lrnIx?=
 =?us-ascii?Q?GNRXYfdnEy+0H7Rem8EH2k/KEtRiqR90jBTlbKohR8I7h7Nmgyhbu4AG03Rg?=
 =?us-ascii?Q?n0xCirT+TVMuUeSo898QXR8v/gTf+GYjiJv5o+ekzpgYk1S7aNnuFZEleItK?=
 =?us-ascii?Q?6xV3ETUxiT8dKcFzWmm3BNV0Sc6EZ5QM7vTIxDI+gbovtwJYl+ziuARqnV7p?=
 =?us-ascii?Q?tKoLZNg0FaPYTxHA5Pt3iHurWn6WVUa8st61nOZejgqnyqYoU94R8TDxYx+j?=
 =?us-ascii?Q?paMcLYjkLMQwXiB1vlT3U84QIXYNijhMx8yLPn5S03WeKh6Lcp16I+LYPuXD?=
 =?us-ascii?Q?1bPURGH75Z5vTJVDzmaFk70p2ZnDZP/3iNAQNNHlfWHACSBn+SiTAO3k0rdf?=
 =?us-ascii?Q?CJR6mGA4HNJ0xUB/wO12DIX+H36SCK66WNBGm0nhMTT8YG5Yvhbjnu566+nE?=
 =?us-ascii?Q?srTJG3F5Tj7oZTy4aB76EYafIryI4GSkyGVbVKVqG9bzCISTJNcmLH9r0HZ9?=
 =?us-ascii?Q?WzLVSiLxEWnagEz4xworejkGhGyej4A2Wl+z/pNBFsRXHwSw2O3CSeAViJN+?=
 =?us-ascii?Q?ruALFZLtXK1j31MUgdxrz9Q57WmrVbmB34FaZEltUTl9/NDPSsmm/HTbb5PY?=
 =?us-ascii?Q?Z+VYqVWcCUZQb2z9Ol2a72QsSSq0hWqwdydMSXiSQPz2lRdz5AOykw493i3t?=
 =?us-ascii?Q?rs+emhmwsOXe0wTa14HlgvL01l6+lj6EPzEzeRudvoFU3zHqZFngqKnQaquj?=
 =?us-ascii?Q?i4+exwluOAO3NxtiAIveXhuO0e/+3jiu6ZhCMhNos1D36IfOQTVjZYYut4HI?=
 =?us-ascii?Q?oBCm7PpzMGpbRXPaLBLI+rxQ78i9DrpB9kS2yt+YUdHgdvFSCkaj8CbcdN0P?=
 =?us-ascii?Q?q2suDyDwz8j8z9IkTe4kAiTvUTdbNcVaCvdNh7CtIwOuAYkSA6y6YEHaZdOY?=
 =?us-ascii?Q?lumx7YFQJVBw1L3Ucq01ucljaNpnK3djFdHtp0qxB8g3XkGyEysl9LMHeXdF?=
 =?us-ascii?Q?Pifg3io1SR6FoxXPF3SloJS6PKLSFdw0mDHpNh9IAzZgbBCou06iB3lfkMTY?=
 =?us-ascii?Q?qKovwnW/Xb/OapmLoX+NsU6B6zB6xkoSQq3jIoCwNuLhGjmsYGh0U+aAhNUi?=
 =?us-ascii?Q?8dqv9za6Q71ORB3pI2Fy5RjDM7n2aMeFwtf5JpIMtqgxr6z1BVN46Dqzahji?=
 =?us-ascii?Q?5qr8Ugo2RUPa5R7/kFEAWPHBP1JMCt7oYwh6oCUDGsTRBVI5ptu6O625Wyye?=
 =?us-ascii?Q?HEODZQy0K3/XU4vNnZw+BFmxRLnvo2fulyXUM9IizfiWHIIC0tBDU/S8s7z/?=
 =?us-ascii?Q?P/lTgp+gusDT/j/sQNjxIH2A8YGHpeYQE7+pvghQKHJpgJJNCe68mUkc276B?=
 =?us-ascii?Q?pMD/0S3Laq+U9F8TjKAn7ze29Tx1KkJvByXKgkU2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w+xuDMbmG2IOOddYIHr6Wf2FLJ6BoeUFlsT40qANH2QHPJPe3hF9lRK+UuZNSZmaLp48cv82LIOE6hYCKD4TAvaN8/mVQrq+eQvZydEe3t0kKfZAykyf7AaO0AkjktvTEdnoDR19CJfNM6dVrgGBfqI56AX8W2+FldrWrymHEhW8B+8+T5V9xIFocb3B7IBiV5Am3DpIPTPxR4zJ/x7nvd+9IiozkFxjOw7rUx91caunLblZFDimXIRYxMV19LpQmWpGREh+1rq4j4TuJH8oisHLFoayLoc7l+viFF6Xx8KCo3S/djXIRF1lehgWf3vOEDjIwV+yFLrk6DOa4rXBMCubnL0ZC+1nr3b9gWB6xJdGBgRMMAr5rvWj/STjIT54WN6Acn+RXuEgDf/OU/N2BYVCFX1DWogpzqXcgqxMGDUWTQ6d6JAfQMTXSkMXEKJBhIidqGCfarDbcpeQ/DTG341cI8Bbm5Fdpo7bNZyYyRFoQ+oVi2gCE4Auryc+AcwN2UJskg5tXhL1rnmo4qnoVmBv5t86j3tIUlhOUJImba/gOZ/dn4EYTuK78BJP6LRR6cgsETyfmqT1B0ZKFkrLMyZ70Ac88YSWHN+rbKfacYk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0f6fea-5baf-4474-5aab-08dd917fe971
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 18:07:52.1396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5atyXho/fXgsQ5PXAjTN2kQ10B0/lxqiC2G5jSLJFYI/5kl+W13fyHzH+jIaplcBWbhSuqhb93yLqXjDTzl0Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE4NiBTYWx0ZWRfX5l3ErueXnYY1 6ThG39yq5rEr40g4KAsSWsjnULNcluaJMK8akcGaBCbxndA9ZZnpdKNDfVgouv0ktkHa1cYF1cm sQehEBQaxxBKMl3ktu/vpUQAOX/Wd9O/7YCzR4qdbb7squIVpS2fMqw973vBY8+whwQiESe5466
 tjyaH37nNJgBvPQowmKo9jWtyt/F2Bfir/JS/Stepx4wu8UHOfmZIv83F57xwtjklCfhX6FPDac nkHZszvfJ5DVHM+ka7ABQzxFaHRrCd5VmWdrS0qZOr/1gWwppttqPkfL5OMIETixZCypFUV0ICG FtSXFCBdxJ+fKCZQ855jRE9LZLot7V399w1Ncu+GWlsLpu0suf7ooHpqmI+AsCSFHH6Gcyw82/D
 iqsJg566TaPN7gux0HtZ/R8Yv9AJwBItVWKWcuM4bIBhSZ1G5jhFokdvxC9Wt6Gy9tKjiHC8
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=682238fa b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pHefiBfVNq6AOY43BAIA:9
X-Proofpoint-ORIG-GUID: 82hgl4H3pOj7KHL8VgOJYDb1oTosgMyK
X-Proofpoint-GUID: 82hgl4H3pOj7KHL8VgOJYDb1oTosgMyK

As a preparation to add more device allocation methods, bring the
exisiting device space based allocation method under the sysfs. So that
at any time we should be able to know how the kernel is allocating the
chunks using the command such as:

	$ cat /sys/fs/btrfs/<FSID>/device_allocation
	[space]

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/sysfs.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 6ba118d45a92..d07c22e05088 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -435,6 +435,15 @@ static ssize_t temp_fsid_supported_show(struct kobject *kobj,
 }
 BTRFS_ATTR(static_feature, temp_fsid, temp_fsid_supported_show);
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+static ssize_t device_alloc_supported_show(struct kobject *kobj,
+					   struct kobj_attribute *a, char *buf)
+{
+	return sysfs_emit(buf, "0\n");
+}
+BTRFS_ATTR(static_feature, device_allocation, device_alloc_supported_show);
+#endif
+
 /*
  * Features which only depend on kernel version.
  *
@@ -449,6 +458,9 @@ static struct attribute *btrfs_supported_static_feature_attrs[] = {
 	BTRFS_ATTR_PTR(static_feature, supported_rescue_options),
 	BTRFS_ATTR_PTR(static_feature, supported_sectorsizes),
 	BTRFS_ATTR_PTR(static_feature, temp_fsid),
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	BTRFS_ATTR_PTR(static_feature, device_allocation),
+#endif
 	NULL
 };
 
@@ -1506,6 +1518,88 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
 }
 BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_store);
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+/*
+ * We only need sys/fs/btrfs/UUID/device_allocation for testing.
+ * Promote this to be under CONFIG_BTRFS_DEBUG when appropriate.
+ */
+static const char *btrfs_dev_alloc_name[] = {
+	"space",
+};
+
+static int btrfs_dev_alloc_name_to_enum(const char *str, s64 *value_ret)
+{
+	int ret;
+	char param[32] = { 0 };
+
+	/* If the policy is empty, point to the default at index 0. */
+	if (!str || strlen(str) == 0)
+		return 0;
+
+	strncpy(param, str, sizeof(param) - 1);
+
+	ret = btrfs_split_sysfs_arg(param, value_ret);
+	if (ret < 0)
+		return ret;
+
+	return sysfs_match_string(btrfs_dev_alloc_name, param);
+}
+
+static ssize_t btrfs_device_alloc_show(struct kobject *kobj,
+				       struct kobj_attribute *a, char *buf)
+{
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+	enum btrfs_device_allocation_method dev_alloc;
+	ssize_t ret = 0;
+	int i;
+
+	dev_alloc = READ_ONCE(fs_devices->device_alloc_method);
+
+	for (i = 0; i < BTRFS_DEV_ALLOC_NR; i++) {
+		if (ret != 0)
+			ret += sysfs_emit_at(buf, ret, " ");
+
+		if (i == dev_alloc)
+			ret += sysfs_emit_at(buf, ret, "[");
+
+		ret += sysfs_emit_at(buf, ret, "%s", btrfs_dev_alloc_name[i]);
+
+		if (i == dev_alloc)
+			ret += sysfs_emit_at(buf, ret, "]");
+	}
+
+	ret += sysfs_emit_at(buf, ret, "\n");
+
+	return ret;
+
+}
+
+static ssize_t btrfs_device_alloc_store(struct kobject *kobj,
+					struct kobj_attribute *a,
+					const char *buf, size_t len)
+{
+	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
+	int index;
+	s64 value = -1;
+
+	index = btrfs_dev_alloc_name_to_enum(buf, &value);
+	if (index < 0)
+		return -EINVAL;
+
+	if (index != READ_ONCE(fs_devices->device_alloc_method)) {
+		WRITE_ONCE(fs_devices->device_alloc_method, index);
+		btrfs_info(fs_devices->fs_info,
+			   "device allocation method set to: '%s'",
+			   btrfs_dev_alloc_name[index]);
+	}
+
+	return len;
+
+}
+BTRFS_ATTR_RW(, device_allocation, btrfs_device_alloc_show,
+	      btrfs_device_alloc_store);
+#endif
+
 static ssize_t btrfs_bg_reclaim_threshold_show(struct kobject *kobj,
 					       struct kobj_attribute *a,
 					       char *buf)
@@ -1604,6 +1698,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, temp_fsid),
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	BTRFS_ATTR_PTR(, offload_csum),
+	BTRFS_ATTR_PTR(, device_allocation),
 #endif
 	NULL,
 };
-- 
2.49.0



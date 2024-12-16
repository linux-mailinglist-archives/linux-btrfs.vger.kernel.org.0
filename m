Return-Path: <linux-btrfs+bounces-10429-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D249F38AD
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 19:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A4316EC95
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE082208970;
	Mon, 16 Dec 2024 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g3tU2FNm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TM9XwTcd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F327207669
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372881; cv=fail; b=agVD/URC+9Li3WHLIsMsdqXBJpeXlmYPj4FZukUGVhKnq5Zv78ikm6sqBy4AgZ042BymE2jDpz4hVFdIqO9NXvmknAdCLbfTO97dO5BsCQJXv3f6ekJdYoWm7Q/2k3W+VdB+ume+3fC4pjKQg+mhRx/drS6fedTJ0dJtph09mdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372881; c=relaxed/simple;
	bh=8vgfFShkER6knPnhAas0XZX9pVV+P7Rar21OrcpqY1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cKZE9XrkxTqGzGovj32ARtAkL9qVx+ZSuBe63Ov6QYryDNdxn9fjciBRkGBzYgYzLUmn5VByEL4vXv02ILMHiKbBwsQ/Dguy5+il3pRAOSixZXf66oy6FoWGzRtuRZ2yr1kiOKM86rlJnaKqm7aSIMcj15SKcCrKfHYhxLDLIUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g3tU2FNm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TM9XwTcd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHQjLr010956;
	Mon, 16 Dec 2024 18:14:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=x8+ucNLNelxAC10lgEUUfWVe8+nwNo4COFZdA+b69Yw=; b=
	g3tU2FNm4/gcLrqtkKBEoqwMj4KVRB3JLOYkj88HURj3wuViQFhJWGECqyIbOCaD
	D06In6CR6nZjh0FTxSsVk2fUtqIMFG+CN8hfoqMUSE3SI9qw+Sb0oFkZWG5mCFTq
	0NvKbZCdPfeHvrW26NpFv/11GZKDnMp7bKU49Ygx8cgWdYJ5RKzEeDSpr6wZmQST
	dGc7lnTU2K2Xmyq6XrA1W5/AopCQb+Bx8+UvcxfFv9+M9ErZLfoBsdY2jadH5UfF
	y8GiORGHktpxUx1BCZhID8q6kxBCt3wSll15x1ZGX1DWn5k16DB1GP8qbpDWBy44
	mv3evrPKXcc+vyV7nLwMDw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h2jt403e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:14:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHP9C8011058;
	Mon, 16 Dec 2024 18:14:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0f7b8et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 18:14:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdLd5cj7FIFP4DqKKS4u9DWIlqfmFY/3FKGxEq3KzYZfGOZ+6Max6/Vs7cW6R6pvUcdCmI8Ca4SP8aBVMRCwdXrWnMHNLqEK/3s9sGUjnqKeJPpdBPgTkdWNnJfKbVBWDdL5esCUog4KPQOsf/ay293r5n8QquaFvSJhT1DgYjqR/p5bJY9GPTV6C9eNAz24kv6d9krooadnwEOvNt/GEvA+B4u8f5p/fUBg+hoVP3QzQ+Vl7gZtYv46UNlZnBsdEljW2goh9peHYQHMZjlMCSC45mtJSo8uFlGGH0h3jBFw4INLVpFXSUcpdMl+xzXqszZp+Mu2cMwFO7LiPag7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8+ucNLNelxAC10lgEUUfWVe8+nwNo4COFZdA+b69Yw=;
 b=gJpfqraGa/zIx1+yZ2UZNB4rrtZl3bHvmZm6KxR6oLj/G9nK1gUn0dd3Dq0oDAfurdBrg4xiYBEYgqrO/uBtukXbnIiAhmim8h1VOHY/VLEf0aR0nFy2bB3bCe3Z3QHkYylLiVqMmNpZ/L+fRxvxR0ZvVfDH0wQH6JEbrB9AEEQMpVZ40SzsRN0T44P8sFnVP7K7Uolz5rMV1LEtnsit+AGGyEE8frpZ7EmZL40RMgcYPIUTyCg8kBZpnZL01uibPaHOSePNW99CQ6vNKtNJZEBj8xvJ7Cm3Ld1B9+aeBj+ZAgvxyHkqrygabcdadDU/F/XUReJ0Epr/isjeg0hwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8+ucNLNelxAC10lgEUUfWVe8+nwNo4COFZdA+b69Yw=;
 b=TM9XwTcdFSZJ+b8KEn6VKu53ECIwtW8PEEaddFRdVLTreAUxbm6Yg2+4DxndtnGmQD7RcLLkf0Mx6i47eGE1GFMCeai5UB9HcZwtdyeM0cQA0rRUhpLWoDyo31lCRMTnM8tufE8l3JhlAv84i1LjyiSHDb2TIHreqkizCjH7n38=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB8220.namprd10.prod.outlook.com (2603:10b6:8:1cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Mon, 16 Dec
 2024 18:14:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 18:14:27 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: [PATCH v4 7/9] btrfs: expose experimental mode in module information
Date: Tue, 17 Dec 2024 02:13:15 +0800
Message-ID: <d96c13e43373179f936f7eee3786c29727b8b0c6.1734370093.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1734370092.git.anand.jain@oracle.com>
References: <cover.1734370092.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::28) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5cd3c6-93e2-4c3b-f652-08dd1dfd7a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yHzFny0ZAvvvifOQTPJU8oVEv4HgR0PTDUvtUXoxeGZ5yc8rBT8zvODUpB0P?=
 =?us-ascii?Q?y3hpexkktudM8veXmXudEJg2+sOYLS/vSmrpiAZj/KETW+wD2Ywnu7qA7i1Y?=
 =?us-ascii?Q?78gvKU0DaYHwzBkSectEaqP2/MizxwmTOlluj/DsL/r7Hxbzqx6EGJt3cGux?=
 =?us-ascii?Q?of1/Z+aSkzspQd01UJFbDyecf9KnN4m+2gypb65kxUempzf3A5sCcmPvfWW2?=
 =?us-ascii?Q?3p0XgNdDyNczqjYbdFFmbl+0YroVGCBzzKq6LKKdRbcWcJO6QNTKW34/mQMZ?=
 =?us-ascii?Q?+bezqsudIAzlsL+dtz+f+qy4HtaUYXtDP+OKpjDfjJjMue+BQ31+H1wkqaKb?=
 =?us-ascii?Q?6UVJoA1ioMuikicB9yCTI6fTLumQIB37gEt5FU/1EyoW3Qs/c8XXckFk0Lrv?=
 =?us-ascii?Q?Qt3NABUXqzv3Ztpy2PQI+tgI0LhRnuIq+xS2YIbUjSZIrzOolIrEudC/PYsY?=
 =?us-ascii?Q?6Vj+2ecFnVGo9iiZ2R476e1MXmXlnasbwUOO5BaJqcBK1Shgv8ux4Ye1mJLc?=
 =?us-ascii?Q?g7yPveVYFlhDgllxwNJiwUEuhBv2KJ7WrQ9ScxF16Wj48sSsnIF7lvPxJbY2?=
 =?us-ascii?Q?e9uk+r6ZXdhfzcFUb6coxWIAx5zgk5rmTPf4Yvw2bw2K5H3ti+pnM/jtmVLq?=
 =?us-ascii?Q?z8TA3cReyIoSvOVukyvxwRZclqdBp/0PS+QIfGGz8H3lTtgoCcF2TOweyJop?=
 =?us-ascii?Q?rf8ncmwTRdY2CCBqLv5O7ZZ8M+/s/26Hxlyt+08u9MXxrENz3oyYUE2BPJjy?=
 =?us-ascii?Q?zEF25e0IeVlU9Y+YojpaNOISkjOP51+wPPSWRYwqcr3N09baK2/TIcvmEc0j?=
 =?us-ascii?Q?ut75rmyoXYOmx3Ar9AZPLwoUBl6InZXKKOsZ8OuMLYfV+DpdJAaq2hOEC3nc?=
 =?us-ascii?Q?+UI0nWX8brSbm0NfjE3t/uCn8pa8PXGbX7iuORVaoKcKd2qC9CZoxmtArCX+?=
 =?us-ascii?Q?1oq1rtZsTayUdA8JECpP2sZCb1RRZ5LmUwXPS4E0EkrECr8xj9dEbPF+dANa?=
 =?us-ascii?Q?pjrnGgNTKPabxHYdWCcuEsoQhVdGG8XN6SGwCVvU2AF81ojKKsS/goZytJ+D?=
 =?us-ascii?Q?GmeoccfHMQnkax22QFsaPJgpOaObhP5pmXumDFP71S4XQTSiZOZn+Il7xlKX?=
 =?us-ascii?Q?gV3qmTdrCOFMG4mqdAgdak3Od7yfI6Z4PVU3FKjCuTKvF4H82nchGR/irSQV?=
 =?us-ascii?Q?WU2AxYM+ODHWiiwZ5YkOYG3Y1XloMqPBNVlltg1UmM5sHqYiXJJFTB+yrIaT?=
 =?us-ascii?Q?DAneziSB5XYkh9jNbSvMTFJ/rRsWXdy8qTwFxQsgXqixtGqNIhdTopC2ZSvE?=
 =?us-ascii?Q?zLljGaKvkMZPMjXW4oj1NXVjK1gBOGY+P5xeiuReefxu5XzeWYZCrU65soO8?=
 =?us-ascii?Q?T1SbYE72pSaxk8AHrBLZqKKu++nk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nnBF/INf98MmtaINOOCPGedsvhxRO1VImhxE+NmgExLRJKR9IWbld1eD793M?=
 =?us-ascii?Q?JP3xwPEg2+xlD9zVv5TQ4boxeYZqCdEHF0n7rbPUnzDto5o+UNffc0QHrBPt?=
 =?us-ascii?Q?6R4Snya2YNgsZQD6xFK7rEEo04w9/CNFlM+vXlwNYa99jKvnL7CE14WtaUAf?=
 =?us-ascii?Q?W+ELtZWU+h0CP/9eKVkvp/PYLctepGmX/LPPjK8aMxMN+A3S0BxTbwYYUJFW?=
 =?us-ascii?Q?wQdUhpFr831OBnbxeU7UmYjrGDVV71xV2Z+7MOJzaSWdGwTnAsW1lacSUIet?=
 =?us-ascii?Q?FQr4AU4TmPNmVqMc6zm26PJzYqNI/c6YlVBXdYwOM3mpUahgHtHSqWIj7Tz8?=
 =?us-ascii?Q?4GcjaKJs8tQSFDBdzJ4eHnTb51+01/QU9OQHBLAgsr37o3qGYtt9x3wkKGoI?=
 =?us-ascii?Q?y/m1LCLkT/n371/LN+mFxWqaiCROpUCjH06Cysgud1BFG/ZkU03yivZtBGxq?=
 =?us-ascii?Q?bLAd6mR7cEDY7Jl6Kl9NtEQ00fRLnCfR8XNgEFiarfh85/dM2FhVAHYt7kUM?=
 =?us-ascii?Q?/KLHQLUUPiiQYnYIDeIfp9KAivGdmwaNbXhVrx3LQAEX+qyKfjsgeZCtkUqM?=
 =?us-ascii?Q?McdAv9gtlnRpeO7fKpU804VulielErey5iX4yE30QDyV0RMWpe7QWcbF9zN/?=
 =?us-ascii?Q?fRI/dRzAKGlOtYSI6d2lj6I6Kgrc8r/CtX8zD0rSmqRiFysW3R8xltB2Emq5?=
 =?us-ascii?Q?Tr/Tfp9RD785WXVuAilZgrwy6In2AIHDzYH+DUpIMC5SqFuWLMa2BFyvqWpf?=
 =?us-ascii?Q?fT/181h1IVowCKQOz+Zc5kVVN1uU/pfcS3b3gNwQEALU5clIZDQrn1Ck/+Oj?=
 =?us-ascii?Q?ag58IVTQCn+XHsg+Wp2hm9Ps0qQ/Aksx2rKj8AiGoQ7149ZkIqPcWA1VnYzk?=
 =?us-ascii?Q?BPqxQKh9C7F3BPKcS98CKN7hPbE3pVl2kW5l30tLkz7CtQlHQxm4BxcoGxIj?=
 =?us-ascii?Q?wvef7AuGCnwrFj+fv5fuFr76+I/+kuRNWnDHlf2g6gWO5RAKC4hc5PwBms/x?=
 =?us-ascii?Q?BvOf63OO2jC82SmaE/A65ROKw/9curqYA67MxFBbd5KPHI3HEh3eFkIhJvLz?=
 =?us-ascii?Q?g3SEuV9lXZtBe1o3XAj2r5/ZyTOoHqpp/vfPKEYnWiTCHOdHKDQw+e+1wGUE?=
 =?us-ascii?Q?iJOYT3VaM3qp+6xKOX+z9ULyAaxwS0vZxTaNS8ZY3YvYm9+waFf1F6bmdC09?=
 =?us-ascii?Q?C/OwZw7/Ij9ZF+OgHb/YRjv6ZTzn3YHobVGTc+Yw7zO9EGgpuqkYOf6ppr+z?=
 =?us-ascii?Q?SCqWQAVlwDXfEZ0BzR64sTdgYS9hZgvXJaZBxvGZwjkF8PXzGeTvgxLz61lX?=
 =?us-ascii?Q?5xOmkS50Ec73Js654/hBXcNvrTzStxv6iCxZonUMzesiTKDauDzMh+oEcFsZ?=
 =?us-ascii?Q?IwOxrlM7mRG/gCneKg9tL/CVfiNJt5crwDbGlALPI2SbL7taGBkryiQ/fyFZ?=
 =?us-ascii?Q?XL8X3Qi7d6kGoU5r+TrnXJc9La/cpbIoZ9drZdFTtqPkCsF3EkwZ6TvIhJKz?=
 =?us-ascii?Q?yO8Etcfh21UrA1ca+GdueHFWTvmx7mt8XlI7CKjua1p4CTxH69+l1++WUZjX?=
 =?us-ascii?Q?G/fxGBnE0LVOTniHIDthFCFqEovMHfCjy0Mnxkib?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	twj+x+cbqNN/YuHK7wMgzH//Rd7sZwu5Xsf7ERz1IPyj6lj3K+I+r3j21fnreqhNLL4yXasUjuMVfoeZwayIaqjtynENFxUyWTxVFkvbcjUHRgIwmLgbsiv99BQ0SylDZ5M2AMGKvSB+TZ0XbeiIsgX9FDviDCpnpKO/N3Mcuqe2ZW0xdq0UX9jaod/8cj4my5r/5pRyIkgnMAMCbTKFntvsnlDlhYYGNIw8VnWj+KWT3PuYq1bRvW+adhcOoRYaodknvKqQ8dfbLTwcvE9U4n+9IWCbQaBK7T3misJZegQlRvjWMCnaBVFWuwfTxTQz+rItRSPm8gSATaavgfNrJwuQLyLFP7ovwSzcixu1MCBkx+OKjAK2KXcx+SLeQlYsL9LbdOwWk30K+QgXRoWiaR+uhQNAPoSLmpSyWCyIbg5neRT/NoyPUo50+QzYcNkEl0zjN0wuK1ulgZ1qnzY4YFw7P2wT/yz/6h4+M6nbQt64OHy0GMp9z4yRMQhHWaMXE5khU0iIc00bQ9DRdvgt9BZkZHR4wDkf/iTqbEyPhtpkWq6fg1mU191IFDpYGdmAwjOAHtVQ4Bnd+wCLS7zciCQgxPGrgeBxBCPUian+lNw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5cd3c6-93e2-4c3b-f652-08dd1dfd7a6b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 18:14:27.5241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YtlduAWpUwui00K5cX9pOsJ+LEz0iCgF5OmXd0fs1esCyYG30uTCYMO8ASUWmvI0ajkIoMvibHPvhrcmN834Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB8220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160152
X-Proofpoint-GUID: 2FU46wfsV-9UOeuA7OKZaaiiiDGxpJWr
X-Proofpoint-ORIG-GUID: 2FU46wfsV-9UOeuA7OKZaaiiiDGxpJWr

Commit c9c49e8f157e ("btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from
CONFIG_BTRFS_DEBUG") introduces a way to enable or disable experimental
features, print its status during module load, like so:

   Btrfs loaded, experimental=on, debug=on, assert=on, zoned=yes, fsverity=yes

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3381389ab93a..fb6a009c72ae 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2457,6 +2457,9 @@ static __cold void btrfs_interface_exit(void)
 static int __init btrfs_print_mod_info(void)
 {
 	static const char options[] = ""
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+			", experimental=on"
+#endif
 #ifdef CONFIG_BTRFS_DEBUG
 			", debug=on"
 #endif
-- 
2.47.0



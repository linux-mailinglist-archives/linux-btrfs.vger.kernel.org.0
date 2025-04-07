Return-Path: <linux-btrfs+bounces-12824-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1DCA7D2A0
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 05:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A1457A4589
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Apr 2025 03:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8714B221F21;
	Mon,  7 Apr 2025 03:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UMHjtVbS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HG/UKh7c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25183212FA6;
	Mon,  7 Apr 2025 03:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743997762; cv=fail; b=c7wIKyypbre5zpML+BTMkX42AjeAHtO+LLi45I4a2CdjyBfeqM2mqLCaU5yCgH/mdzZe+zHB4gIRWz8S9jPGHvX7Zxc5PNXkel0M8bpY20Z5Dk9Pv8FEjqCLnFFpJUBFIGR92WSCSAIYWrjdFV0FIVCoynL+flKS+so3PRuAouU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743997762; c=relaxed/simple;
	bh=SqiB8d4rti/+pleOCMNS8hKoo9Ya+juNu9Y9V5hjPZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=haLCaoYe0cajxiFPvVZheVeTsz+syl+3olbETOYz0wX6aDIRUWlwFBWOsOmF71bKCComdcJ7lrafDOEboEA6uHYsvLlNl66qHXHJnzMNarMzaq35VfACKpssKdAoO2a625VBl/KoCAOzpylVpvvVbn0wuTK2L4cL3hMZM1RH80g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UMHjtVbS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HG/UKh7c; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5371ECn3007567;
	Mon, 7 Apr 2025 03:49:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/QGeqF9X2MNsvLQ8t49xLkX7UFSoJiA2Dv6VcLp+xL8=; b=
	UMHjtVbSaKO5QH6SawToGjyh38W/obwbFL75qmHPyLlbZoiLAsvvHUu5c9L6K1bz
	/Yr5x36TSUlvLtm7y0x2cMchikSy9d7MMoBk2wvD/g1hWqu5OU4oBjZI56v8NWto
	XKZrq69W3VMn49mzBJkySe6i+Q5pumwB4fAnAPEqnyPFjdWEGLYWug5kCbuSvW/z
	O4SD6mSh5bP26wUqVmplkfX75185AEheg078yZcm5bhKz4cq1CJOqNZUyOMrQJgv
	jxeaQLOTn4LteQN0I6EVFkKbr/VsphnUW5VfsyG1OgPaFxCwO5yiP3tV6JUAO+9c
	9HOCTuOdMsS/oioEYkCqdQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tu419qsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 03:49:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5371rlLa022469;
	Mon, 7 Apr 2025 03:49:17 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty7xu65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 03:49:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bptZ34YUgwk7mXjFZW3YlZIsne6AMr/kpD0PlRZ0UQmWZ2ijrJ5YThCGLziDjIkQ7MmqxP+8tks/BNyG6LwBQLSeBXfhqJeEBFSacZfVI0ecJUI75f5rHFWgFJyqexFapCzUfrSjy/0y93wENhav407S2iNxhK95GtU6tG7jyg/2mkyoz3XXjQHbOsLg5Ul5yihdysKmyZoR7I5LpTpwKRq6166YMzzqqjitXtYSiVSHLbgqW7DFFBWI+IjrwD5HivEd4ICqCiSkbBAUoJuyac+r0xhOgibiCZL3Boj/GiKYrcnNIrY+Fqy/GhcpqGVv1IPWxE6I97lTK0klcK+0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QGeqF9X2MNsvLQ8t49xLkX7UFSoJiA2Dv6VcLp+xL8=;
 b=jcxW/HLY5DpsNv2XQ8SXr3qFS6T5+O1lmaNxkWb2brqOEd+fSfqLsmXbR+uR71PtuxvJGf2BUf5gDcmUV/XZJJlwzveGG3/LH2NHNrkxisS1KRPiLrUa01KwBegxHOCrmbAeu0NcX7dyTiakgCxvvYqEl3PMKPlvDu/TVnYtB6jVcM0zfoEQ7BQUpHZ9NAY16njKzRWRUotXwh1mh2vH7MLkBwS20tMKYH8KXN6SlZcmh6ARcL8SqTmDWqFwxqfq0f1Wnl5CPUdMRBw28ac/IDF0wpq2FP686UgpL4IEmPJKSRyfK6u+9dDb+R45t1lKdcHtYqwedP3WUlZ1EXLacQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QGeqF9X2MNsvLQ8t49xLkX7UFSoJiA2Dv6VcLp+xL8=;
 b=HG/UKh7cvWX4b5pYfoflpGJJHiRWtQQ/GgyX191ldLs9rn/vynPFqlUDfg0VLtw4zhC5uHhS6188Tt7Z+bAcAAhq0aIC8JziVO5YoaBwtOawgoUu7y3FOJhXxqc1INZknrlW/bF50nmSIjGyO7Sga0ziE7UQIpnc0cGONvwEQkM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7131.namprd10.prod.outlook.com (2603:10b6:8:e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 03:49:15 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8606.027; Mon, 7 Apr 2025
 03:49:15 +0000
From: Anand Jain <anand.jain@oracle.com>
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, zlang@redhat.com
Subject: [PATCH v5 1/6] fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout
Date: Mon,  7 Apr 2025 11:48:15 +0800
Message-ID: <2315054fa51c78d933570d7a0be00570d5d7ab1f.1743996408.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1743996408.git.anand.jain@oracle.com>
References: <cover.1743996408.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0215.apcprd04.prod.outlook.com
 (2603:1096:4:187::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 2770773c-b307-43cc-482e-08dd75872a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G9IcWaSY7M6TD3vFXjuOXKYaFeO+yiDSJ8r5wd9ogKQzSbi41MdJWHL+1Mxs?=
 =?us-ascii?Q?DIBh1cXyRH4RI+DEooXHJIlYZEgLV5uN/KIBXIREvXxSSdEDZj0+vZKizVZ2?=
 =?us-ascii?Q?RVzUsTaMiojjaKDQVJXFBRVVfUcgfeoBKcn/uzpOkc7NFlkpibYKRtgh+AIZ?=
 =?us-ascii?Q?spm5Hra7fLiiS7ex1kfRkE6tiHFiF6d6aBMXlg8/77KNsIOAzhBm2rZZNIsd?=
 =?us-ascii?Q?RHStVALXkeXApn7ZzbMvz80mDfUL85dS//B2FkDN9+hQ8QynfErbBhSWjhay?=
 =?us-ascii?Q?u/AgwFsXWBohif4wbCRIpUbmjOdQY+u5J3T0vwWwsch/n29K0fgPyOyrww4b?=
 =?us-ascii?Q?yLyoD7lfwooACrPRYSWwfssh6rxltPUIECndKiBjt7opLp7zrKvjMnMfwJ6K?=
 =?us-ascii?Q?jTra3IVdM0w4ojX744VM3RfJZgSwkfABcy4sVIcK3nlcPEzvLOLGXuTa3eyg?=
 =?us-ascii?Q?4ZDCTklLLNQB1JDw7kIPcLxAohbGfUMU8iNgv0izQ0cmizszmPLpbF4f1acH?=
 =?us-ascii?Q?mP3VYpE/k4DHCpr7r1Z2+Oqrtkyivs0RnzeFnV9H0gxlNBRRBZK+uZpEFRkj?=
 =?us-ascii?Q?iO1UE81j4n9DZ8tgsKWAqg0RacLf4aBMmYH9gCg9H/Re8SFSFp1k7JwRNgL/?=
 =?us-ascii?Q?W35nY8pi76Pr64e5BYJbVaO8byMADpNjzI+ch+LaVUksGb95/LtPr1Ef6Ps5?=
 =?us-ascii?Q?VOmSnVX8ZEVEC/sIAz9jqSeyPEzKhJAXMGAvzyc23Txtz22LYOEhhjcUkRTZ?=
 =?us-ascii?Q?XwgfeSWqCgZFdaxB/C7/o5NY3UYHXkVG13q0PS4Ibo0aKX200jO7rjIOHovX?=
 =?us-ascii?Q?TaWZV4wpRPJkm1abBq8tnYw20WTKBXPyHQx2mPWvRJQNQiEf2AbMAsFFTr7o?=
 =?us-ascii?Q?k6xbZcySHL6sHx4sooohXzM33uwGaKGFwjoZ10W0g9Z2JVNARiUpbRW1XDbn?=
 =?us-ascii?Q?/Ve+XaSnGse4rsPhUt/LShne24e+XwFDqsck6ZU+Muowab1QNn2ebvlSyxmb?=
 =?us-ascii?Q?x7bXBHdP5I9ajPLqLVO8vyuSSBaTR4cgsc7Tfj7nZ+DWrydpnrin5VJxX9K6?=
 =?us-ascii?Q?Q7BnCKr3Rj+tqIzMvBncbQCE4N61dAvc43zknAiyAzUtvAiCjqhNn2AJhigB?=
 =?us-ascii?Q?kBggLzW7TV5AKqNdBmY4mnycs00SG2IaSE0SCzkqnz778IuuvrA7k6CYq+Ka?=
 =?us-ascii?Q?LgE2utZKoTNUGZVrJoU52QfKkQIt3VSF1U2cPuaSz8GPKhOnGfResAb/pnCO?=
 =?us-ascii?Q?3FWSTMYe2hsEYl3xGOeQTj/J+jdj7477T6PHJ0knuIrPCT0XOlmjKpZeZ0ci?=
 =?us-ascii?Q?uzlEEKvm1DRebCPjbUQkwM/U7bGk+L6kHOHLoyVFNO6wEc5hssbP4OphnU0Q?=
 =?us-ascii?Q?EPyNkr46blZJRieaRWPHl2JAyXv8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YjFTd+Pa2B/vwAil5H66omgh6bOHRO6w4yjIwTf8kNN+BNYBOurYsxkF5zMw?=
 =?us-ascii?Q?id2+PYibbfDLX7qKpirbnoXU7ZGiPdnS/GNQoNopfHpiC9nZMtSarszl4rkZ?=
 =?us-ascii?Q?Lf0FnjlUNitSSG6UuXQ0zBwkgYWM0Xw8/yvsouNEzBuE3j6GQhB1Ms1vS0O8?=
 =?us-ascii?Q?HLuYNMffgFFES8hdkIemK3OxI7nZvgDL2H24hfMm0qUyXa0VRVeaxpCvzd7+?=
 =?us-ascii?Q?j/E1x0EZuhPhWAZ+uoReVPQlcUeXRr6obbAHRwAUOikb92DxYaMYp1kCOifk?=
 =?us-ascii?Q?aoahUKrTXqlU7y1ISQtzjKnzhs3Dt1tEhhWF5ynwad7nK1wV+HG02kGYb9fc?=
 =?us-ascii?Q?+TsrBEV5WvnNL0owILy1EOhyuWL4lhPZ6+unfx268gDRUPsQsII/iqwv6FGv?=
 =?us-ascii?Q?mNmdwxihjQ+4sCmtPlGqO+NSH8Y1pjNWjJc/3oyWShthw52nHdrhI5a7XJTy?=
 =?us-ascii?Q?4YtbleQ/DegRh/7z+07QyNa0PuZwGskYXoTVya+e8TC+z3po0RnUwUOcJ4w+?=
 =?us-ascii?Q?b58B36VC0SttD26PyNiEy/T1My4xUbhAHzsBS/35vLqti/p/dtWAxTXRyUAR?=
 =?us-ascii?Q?k/JYvFh9wzjJaJ9i1P6GZG2MpZupSJMFkp3xSnuHKaZwrdysM4BLXyzsBG89?=
 =?us-ascii?Q?/3zQpxUZWWDRiQII36nHNNOw6bm7/CLd2Q2RCKB0foukG69ggKQKt4tGexCt?=
 =?us-ascii?Q?q6KC6QSbwE34C3bBrDWKJ+R4autikhq0V4WqzERPgzu9GlSQmDl0PN8ig+jd?=
 =?us-ascii?Q?ssITs/zDsncMrB8VOdJgcojvXQUgyKfAHP0Fh1suti5NvjBLYSGuh1kcesqF?=
 =?us-ascii?Q?BY+o52xXLtL9jCFafXyef/abtYv0DpTJPuvVOoK7dHF/nW2OqP7/gU2NPCWO?=
 =?us-ascii?Q?9+FpCnx+POFTk4JkQYDWOxqzP/kSxdSJjNslpDvG+KSgCQO2TAckrbDLm7dA?=
 =?us-ascii?Q?ZO2YjE1x+PGOx9Cv/J7QQE+Y9jUtHgSENNVmERX5PFZcW+HFpBkl6r9saWQf?=
 =?us-ascii?Q?fJgENHpUUAxZ8VQww2Qgy5tbfjd6fVeFKSHJbHNdAWiBPAoP7H8KPnA4dj2q?=
 =?us-ascii?Q?oEl+W5QKuUgAzCyclGSMCW7rTkST3oi7M60+t0hJZ4en6LOZRwpvVOnafk6c?=
 =?us-ascii?Q?qOhM6LnESaVlg4i0lvgY97QZ71lwrtJSWmqrhleAIyAvl69ZjfCo7p928HbT?=
 =?us-ascii?Q?bclsxyNcGSplTDQRY8iIEfOSxIkdjsB0HOgpT1paAp045lhl8np6Z+meqQq0?=
 =?us-ascii?Q?61knFNyV/3E0f4AfxkhlGoWENVP3wTsBtgbMs4oWnKqzKiCU+DG/nIymN368?=
 =?us-ascii?Q?b94+TxAF41rzp7Z5c+F7wZh6PH8++1B9G2v9PF+4FFYnu+CkzrNKR6r4ZFGR?=
 =?us-ascii?Q?xn+wg4WW9h9uUMpwkF6KvFPpEJ8QbaXeoMbbhDvKkZ+sWm0HVWGRrpIWNYqH?=
 =?us-ascii?Q?12JnKhopGcDeg6cc+jHLqS39HE7N3WqLhWRCO4L+OMt8Ufc9nlcNW+AGZ7Vx?=
 =?us-ascii?Q?J19l2sPP2Q3OjYWKZzpDBm2Che4Lujk/3wAQU4AzczDE3ZhN7Bq6qNmZSDnf?=
 =?us-ascii?Q?bVJ/5Z1F8Onieoq5wHAIa73Rjqk0G+hPPLGcF4BS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ze8voH0ijKa68BX7UOnoAAttz3cNyHksacB6TG9BtpV+tVqh42XQb9uFuSBf4CmBEL+G4SqHQor/79bOt2jFZTKFCgCpeKVlow5UW71LeUaBigLzbz9tzoFfkSsTgUlaLAanusWMEb3Y2HOvOhx9OjByiBF451ONIgdipHejheo2bExX1Vc+X8miwCU8u1C67p6+4r6l79vDcK+o6GrjhqAPmHY8f7hqd9ee/YyfOVJp1hBcPqLPSusL/LJykSJOnhow3Hs1vIYsxl3SC2EMpPLu6ZVvnNDKq90qJAdOLl+kd9r/Dxi5cmNZQeCMUuiq+jjOj/8Z2X5llca/jBw5o/osZwtUrBSytIqgC2T4LqbwFh1oYHI1Nf5QODAPWvxnUqahyS8D0g1m+xbY7jkn44LeWqyv9KTtM2wob5+1ukLsOxrRGHj+yVgMml283kAC0OqrxYE8ct9UqG3eWGWBmOcF8x56x2VRw27txeaH3or674dVanKt36KEhk5VtPsx+8ECX5WZlwOuYruZM7TqW0rexWudfmq8TrUhANUOOyBzWzeCU+3hx/I9mDML9tZfw+Ohws2E2R9h6ZheVsxE4zaM+xyrOc/F3YXyuXrotG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2770773c-b307-43cc-482e-08dd75872a78
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 03:49:15.2621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8BbOOugGdkBaEZvY2IqsJY0F/il3ETnNviinFf18j6jI/bd5CyzfmHagQlox2vC0KUSDfFfbgHsDv4AxXLhOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_01,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504070025
X-Proofpoint-ORIG-GUID: TXqnwtsoNEuz22W6sxUXWtMflb6D-cUj
X-Proofpoint-GUID: TXqnwtsoNEuz22W6sxUXWtMflb6D-cUj

Redirect sysfs write errors to stdout as a preparatory patch to enable
testing of expected sysfs write failures. Also, log the executed
sysfs write command and its failure if any to seqres.full for better
debugging and traceability.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
 common/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 16d627e1bdd4..e89eee5de840 100644
--- a/common/rc
+++ b/common/rc
@@ -5208,7 +5208,8 @@ _set_fs_sysfs_attr()
 
 	local dname=$(_fs_sysfs_dname $dev)
 
-	echo "$content" > /sys/fs/${FSTYP}/${dname}/${attr}
+	echo "echo '$content' 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr}" >> $seqres.full
+	echo "$content" 2>&1 > /sys/fs/${FSTYP}/${dname}/${attr} | tee -a $seqres.full
 }
 
 # Print the content of /sys/fs/$FSTYP/$DEV/$ATTR
-- 
2.47.0



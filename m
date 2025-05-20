Return-Path: <linux-btrfs+bounces-14136-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6365ABD720
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 13:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A984E17E1B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 11:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C40227C84B;
	Tue, 20 May 2025 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BFKivxxM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fQke2Knv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20E627B50C
	for <linux-btrfs@vger.kernel.org>; Tue, 20 May 2025 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741428; cv=fail; b=ch8cJuKXWdfDscZcfHGct/pZuMVPMrm34IIwME8cMcG9Ze8b3DGkP4bAgubcAn+0jOqZ9/zujtR8tuZuku85vVmd0DgOEZe/MPpq92kC6RgtvmTKjfEYtvOJZMM6qLnt6G9BoBb+SJyb76w68d/CcXWLevLkARQcYLVRuieDXCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741428; c=relaxed/simple;
	bh=6D4mmGSbt1oExr69l8OofGIWMv66Tq3AFCkRz0zsDhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kIu6eoTb15wnexynSBxGWMBzw20B93OHZ1Pwi7roVh2jlRNJ9U7S8Ao66K5lIfqhqSDxJsttNpMpJHceA1oNjS++fZAeDdnXG4bauCUUPuE+pMiBU/R8rVxbBDAC7lw40IjYZt04YABGCnMGr3Teg6hNM337Q8lrwUabCnLCId0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BFKivxxM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fQke2Knv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9MvT4011176;
	Tue, 20 May 2025 11:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=w92OHx8UF/tk1uPBzcpQPYk6/DoLd0WDOFXMdEsG0UY=; b=
	BFKivxxM6d4EW/jMzA3XUM2uBzxUT8T3UVzRxA1sGkuj0xYBDvYbm5CNsieHFjPw
	P+g5wXpg8UNVh1/rrV1o9K9CZhV49fRSIl33l3IvTMZ8V5VE52qNRBsrNgXwjior
	nKElcwQaotzdEREzPwt9Y58ryTl1UlGVJDROAlmKSYuyRe6uhyuEIiJiWpCokY2S
	GwaQNlwuHand+j+Gn2+oH0/OepU+vizg3yGtwn6PxGArtU0oNx+trJpuP4YiEKnx
	v/B7RkHduf2ldkcPay8WV07Pl8PQMQYNs8Y0cQ97bccScfs2Itr+ZCNjQyXVKie2
	8Rf6gF18tLpqiBftTsOg8w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rdceh3fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 11:43:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54KAQIuS002535;
	Tue, 20 May 2025 11:43:40 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011030.outbound.protection.outlook.com [40.93.6.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7n11q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 11:43:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0M2cIpLLYtDN3kZTg6kcKb7szCGRaIYuRbJ91uvyCoIkmI//+0D+BzZGoa0qPRtwkbn2N8ikJdi/7XaOyHtJ5U+Xi/bNVouDvDGVF67k95briNfiDRB8nWjhEpZ8qbS/1kr6l6ki5C31JKqcxQLMmTfhVe2dcncGHA0BUydp7Vu3jG963c8b6U5kI0nVGSHmp2S1rBOlZgdbxz1xHyRLBTprwg+kWEClie/7BGI1Q7Qwq8Q+MwhpjSZe2xSRQ+1w7sz3pVDvDkVVSZxi+G382DORs888iQCZlKvXZXMSfftuUSyfJOVDRwEPWCTh3qEjIryTRtgj/5PrM1Yeg5BZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w92OHx8UF/tk1uPBzcpQPYk6/DoLd0WDOFXMdEsG0UY=;
 b=W2Ptp5/lo6LrnnQvyRdBdMKkELneZrM+n6twMNDjXF3HlXJ35WfDP0q1O4znLh5CcvpAOXAp9ojVi7ZBpl4eEAEMQo5kZtyt7PoM7BGhCc17hEsbrEtFIG2H3pgKyPrgYZvXwFfl2+fccfetHvnh4ZjHiesn6RyBn69H+nWGKnuMfGdBKn3hHFoQ/TPkMKxASLMDH9iV8482tPS2jQBZr8QlOUYsFVcYYQO4ghnYC8lB9VU4xt5WpcgYN6DPVj2uycxH7IZbSsIFzNlPD9tByuhn8269g2117YxJLqBi67HTR1dFsKTrnbh5dhifojCl6f4QX6olnnf+NnJ0WTo0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w92OHx8UF/tk1uPBzcpQPYk6/DoLd0WDOFXMdEsG0UY=;
 b=fQke2KnvD5HnejwV9MunOdkF5HDKSgRCXSz93pM4aDq1frEfR71PwvIVnmwTGpZKyFJ6k/WmT+UbaEZmfkTegQG23BDp5kvy9rjJu8QyT3kJARZ//YxkdeKKPOAvuq4WfCKoUpzVs7SSFr85pT/n64IDrYmAtwUo/XfYrOKt6ac=
Received: from IA4PR10MB8710.namprd10.prod.outlook.com (2603:10b6:208:569::5)
 by IA3PR10MB8044.namprd10.prod.outlook.com (2603:10b6:208:515::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Tue, 20 May
 2025 11:43:33 +0000
Received: from IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5]) by IA4PR10MB8710.namprd10.prod.outlook.com
 ([fe80::997b:17f9:80e3:b5%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 11:43:32 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Cc: fdmanana@kernel.org, wqu@suse.com
Subject: [PATCH v2] btrfs: add prefix for the scrub error message
Date: Tue, 20 May 2025 19:42:23 +0800
Message-ID: <48119a4a4f85402b34f337d1660c08c29de9aaeb.1747741149.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <7cb4279a93d2a3c244e18db8e5c778795f24c884.1747187092.git.anand.jain@oracle.com>
References: <7cb4279a93d2a3c244e18db8e5c778795f24c884.1747187092.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0118.apcprd03.prod.outlook.com
 (2603:1096:4:91::22) To IA4PR10MB8710.namprd10.prod.outlook.com
 (2603:10b6:208:569::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8710:EE_|IA3PR10MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: 5105f2d9-b744-4c74-43f4-08dd97938c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h2G9pE3nwsm/JWyxa28rBquaLDADJBThQFmbUEqTJqqnlUnhBNViYl/Mlx2f?=
 =?us-ascii?Q?nbUe+j8PBUeBMCWoHzEyZYboF5hGIIgKOWrw+wKB2EUKRGZdTk/c5z7JGyIU?=
 =?us-ascii?Q?9iliaHNkW+YppJQSNoQx/5/plKxOTCD3xY/XT9q9nbZ9oRWCInLbhEMuJXBL?=
 =?us-ascii?Q?lXl9q69PyeEj8ic+/eDCU/QDkEWw19nT3Q5e4JlQXsfUuWiZqCFsBXYfQBHT?=
 =?us-ascii?Q?bmp5tAeajwjcedYpJ1M0D/xQq3l/ytO9DyW0hVfduGwneghBKYlM4tpFEN+9?=
 =?us-ascii?Q?9zxwdTErSDtWQn48efJ3+I8TLi87gwWudeaI8dvDvGClT19LnlBd0UmJKFUL?=
 =?us-ascii?Q?vaoUX3ViAoECTMCdGLvRGIKU8gAvBlgo9oCaTfyfJ0xqlENRYTctdkNZp9xl?=
 =?us-ascii?Q?rjbwXDN7fkU7QX78Fpmlst/NwOkt6auXYyhomnhrvwgpB+Lxv85X7dU4Z4nD?=
 =?us-ascii?Q?SdBImzeaSvJK3F5/4h5mNFS/C9mdZgwfgQdSUJvhqkXXxFUDZ1fMKMQFG1m2?=
 =?us-ascii?Q?b2dIipPWHdGrPVsVn/SBg+Fxo2ctFLzzsR2w1WK4eTIQM/udIRiTeXGZhbTS?=
 =?us-ascii?Q?JGJdCzpgzz1lizYnqFuZ8e55AGDVHVcNBCRAWsFOK0WSkOwae5x3tagv4vuT?=
 =?us-ascii?Q?pCvrVdQpaFOFlnquWR3ZpQ26Axj/3XJ9CowaDRLq/rCDAF0etBIA7St9IxJZ?=
 =?us-ascii?Q?uJjjAsKCv2JfFL2iYXXemae4Fr2lRcfQd06giWKMyG5QfU5htLfALRVaVWME?=
 =?us-ascii?Q?UIKMidtg7l52R9HXcbZXWjG+KIy1JpsJ2Zi56RPSonRccaNyjmhpjVvvyjDe?=
 =?us-ascii?Q?B8Tv4WGJSFH1rd/WbIfP+khVM0IFjwqpj08brbrKbnEerF4yfWFSXibqUt+D?=
 =?us-ascii?Q?jtWX2NLnd7G7Ug1YT4c+oD2K61hIHGupNUmMqYUmqMlXfD619BQRKGXhhTYR?=
 =?us-ascii?Q?T73fOwQpzzYgfhQ7VSyFsLdyl8GOl8VGLWkJ/NGz0GI1cJTs9lEVBXem4OEU?=
 =?us-ascii?Q?H8LwCa4nBZNEeRW/YODG4mZcY0UaKcrmTL6XJBCpqTn8XlvjgLDTYVTVoxVI?=
 =?us-ascii?Q?v5W3M8NfyMiyMugUlG1NOZ25apDgffwvvZW0cCu+D/1rHcWZeGTcR/ZjGTP5?=
 =?us-ascii?Q?KVSO8ecbsmoG/QJ800LyHGgebUOWWOWoWbAyEQYm0P6/xSwTRHI/ewtkvbrN?=
 =?us-ascii?Q?BISacgi1xd5eiEANVi2GZqwo8MqI3RD/jCLUbDn6tcDXkebr7sVPlQaLik81?=
 =?us-ascii?Q?8yWTW6i9IHuNnYjUiUWmXJu33a8NSjP/wAQeM68t5/iibR33LHZWC3lamlJs?=
 =?us-ascii?Q?P8OPPnGLD0wr+mAIEBPJxKWtdI6fhcfF0p9aN+Akno8YLtQtu+p70Ud0mWQ0?=
 =?us-ascii?Q?PR8Hp5FSQW/9CvwujH2J/I7mT2Vqjz+stVvDyPvlRS1qSEFcUgPUldudxYve?=
 =?us-ascii?Q?ABj2HQPakv4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8710.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/AV+9fMxFJ9ptQgqUWywVbob1Samx0PozJwWlQJlweIx8y+koyaUrGZnXIIC?=
 =?us-ascii?Q?a41UVufxjK+Ew3S2WM1I0PNNVcUG5VljJs0//WHIaxKNiWv581dSozlOwXdd?=
 =?us-ascii?Q?Ti8GBZLLpg+DWFGUYYJskzHsdr52ozRSmpgJQMHOc8PG+qTJAB7LqpTvzzLo?=
 =?us-ascii?Q?4Ci8GRAA3+YOCOJEPNUI4RCiXnmXWDGqfm3977auDzIwPl8LligumBtkdPV3?=
 =?us-ascii?Q?gFe52q1crJ+Xa4X4bAnDG40vb0JSzeqL91GerE68sp754a+bV/Vo20GFOUV4?=
 =?us-ascii?Q?FMYE8cog80YfWtzzZn3CpaoocmzXBJMqOKce90ep8GOOaPrty+T6PwH318FV?=
 =?us-ascii?Q?p6cB2B9XFN/q9uZbwMAOJCdraDMnuCbPGh/RVNhyLLxTSOR5WWrYQGvQeoVq?=
 =?us-ascii?Q?GdTRaczVMLhmQno+UVolpHnF3t2JN9jaeq72gFx5kINbKr9lEdIyivelOf8F?=
 =?us-ascii?Q?ng6cZAcoQyDhHlHkqzpPkCKpDNMgdeEzFjzBaUq2+4VdR6Zj9mE39b2XAHlg?=
 =?us-ascii?Q?pvtWBpwDFSHJN4Da7R03HmkJgk0bfMHYepCv+WKh/BkniwnnMehC1405FCG5?=
 =?us-ascii?Q?o1yrpb4FZRQ1a7a8MnXmPePSljYZrLjLY/16N4cGB/CmkuHg0TmoQF737amS?=
 =?us-ascii?Q?bWaS9G46bdCG/1pUU0GEqav79moIqw3gR1NgO9ZRCHu2fChJmJXmEnC7p78c?=
 =?us-ascii?Q?fCeY21A/07q65fZ+dy0YVgFMpGq2B9miA9rjgKM8A6glJNb1HmFThrwk745a?=
 =?us-ascii?Q?eYB05tuYoHNYHMWrCiOPgoVcd/zZl9s6yfZmBpbYhEqqihN10xR+iLb6wktI?=
 =?us-ascii?Q?AIOdapRXR1Ku6KjCyVvR5l8c0t14FB6nHrH/rAdEQRyv6YKrhAgPpa6XUMXr?=
 =?us-ascii?Q?qNScLr+bFJSYlKjwQTU1duHLOk6iafkB5VC6BzYzndsc8w2BwMm3ou6ECedS?=
 =?us-ascii?Q?YybYF7Fy8u2B4ixI1SoUR0i2D9vgTyC9TLEqgejgjRbfUkRA7FIiZ+tbv7H/?=
 =?us-ascii?Q?2l5BT3zF/Hdw9MxxGEfno9coUDdaNKQh9jW0iVlonFitlzP7YEAJWq+KTraA?=
 =?us-ascii?Q?J7AmMduWUn0DyOSUVchdpoQtO2vHGg5sgGiiJYy0zy02XpbEzunO9A4alych?=
 =?us-ascii?Q?3W43xI5B8d+u21lTigevmkPXx/nWXa3zGi+ho3dRbz0StJfKiJeO/C0jn1bw?=
 =?us-ascii?Q?wY3zI9nPdffHh2+SOmOBv47/oDumBCR0wxIOQuYFV+k6EJ94zt+nCkC1AAj1?=
 =?us-ascii?Q?xwLOAr9fe0fmJs7xFcXXx65FbzN0VSGvOxAWSvr7OoQuvfOzNMSjXa0uWrit?=
 =?us-ascii?Q?c0xlx3j3pfnmXAURnCWUsZ45UNhwTAmZC+Mrs2HDTo15sqshYJiZrJXlJA9I?=
 =?us-ascii?Q?v8Hb2/4Pzqox6UK3FCdSJCcw+on54lOAULWXgTsD7/Q9mVmqnEETENHdExs4?=
 =?us-ascii?Q?mUhZi6NR01agnWTYsyW6SLfMAc6De1Gh+58LVFCflLVtSe15UD3elqbr3eTy?=
 =?us-ascii?Q?3gld0LzwfUUTk14kkQ8S6V2Cckb0S/x35+Aya+1OAGkU+22pCLpAW7/xoyJx?=
 =?us-ascii?Q?OnXGiukW/43KPZMKS1dTPakpXIMvuI7h6NlfsxGc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WfNochUTbVqK4OoEIUloELP3PGSlscTvfUF4/dxZpqPRwApW1FGqTzeCCe+DjELDUZZ7WmNialpsHqU+nDq+D3CRPwFMS5TBJrDogTtopAIr0Mc6yMUv9Y670gPYNGrfQCHBkQmDfrc3FzTnZQ7aOycAnJup9IOJEQxN9wfbCRtlxaKQzBOs0NJ/+bI2yobXP9jM5H/NM/NkttDKdpmh9hMvVjDOKj4Kwy0/MQtVHOvdGKSQMHbEMN/oCijBu+3X0kk99eZYeyCXOKosOEpQLtA7IdC2TPzX+ssU2g/eTC8YaH1NMEEc/MysHPaVYfe01Gx0L2GTegPhxkTKhBvlyiOCSOc6yXyxOZTjVm/jfhhBVStc+E3JHwY/rykeaeKNCs4J5Q/epZoOW5QDVEJlGQzY5atPriXlKuYY76PbnBC/QAfUNwYsN6JnmFmvP4Rw+cjyeUFmbIgUxk+HjWgc/CDbYyc+3Ix5RaiqzcQErpMdaLbEtt3deZOo1BF1GN0EdUkxEOko0YtX2jmQ6S5+ywY5auVqiZnUNvK/yOa7j4VFiSB7k69jQK2WSb/BNNyBmLNmvykXexDBp9ApmHuy1D2aIhEDz8Ztru7Cmd1Uf9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5105f2d9-b744-4c74-43f4-08dd97938c32
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8710.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 11:43:32.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hNGaZE62T9UWIvnNgUH2VxHzw+tEDO3yuyMPJBBkGMuNu4IrszOJojdNA4i7ch3G7vpL4Vkti7iCXE2qVTicQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505200095
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA5NSBTYWx0ZWRfX0B/pMZ0tl4Rn tQeg1PoHpn1MkiFVXSdDSvFGvUL25nfIAkYLQmhmLS/cOO9qYIedbB9Npei/SAlglOqUAt4dZwx KBtOunVtWDW12Uu+nqdCvJ0PibtT4V66kBKPE2VjNge+re/kz4RSQa/azkt/FZyy6wZ3n5ItRmA
 +Mk0rrYHpZqS4AD0NXHvXNB69p1Vb0P8nRdMOP4hX1804WXl17X7aK6MHx6kAddejjWmBUBkPaP nuUUqfgwmPl+t11ikgKFfRZKYMHPQvufKz/OmGrpYsZP9I8vubSRe4KLmso7DB7emeHa83nSHrz myT8VQ6Fwhns8VY7vomeLNsQei+9/+8Sg8ppSAFOZz2wrORcutOUNZ6hwdaBMjxN9EG6Hg4T6GW
 DOSqrsNy103rxaFCo/ssgqEQOcaGw8B60Yj4eGhNUeK82K9MxUlszXtDm5PNRz+nXSyfAmie
X-Authority-Analysis: v=2.4 cv=WO5/XmsR c=1 sm=1 tr=0 ts=682c6aed cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=fb6UV-2jo9ACTw7WTvsA:9 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: INo0rQvwe7O0XP_lF-iBuCNohgYdrCGs
X-Proofpoint-ORIG-GUID: INo0rQvwe7O0XP_lF-iBuCNohgYdrCGs

Add a "scrub: " prefix to all messages logged by scrub so that it's
easy to filter them from dmesg for analysis.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
v2: Improve scrub messages in ioctl.c (suggested by Qu).
    Update commit log (suggested by Filipe).

 fs/btrfs/ioctl.c |  2 +-
 fs/btrfs/scrub.c | 53 +++++++++++++++++++++++++-----------------------
 2 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a498fe524c90..1e8f7082239c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3142,7 +3142,7 @@ static long btrfs_ioctl_scrub(struct file *file, void __user *arg)
 		return -EPERM;
 
 	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
-		btrfs_err(fs_info, "scrub is not supported on extent tree v2 yet");
+		btrfs_err(fs_info, "scrub: extent tree v2 not yet supported");
 		return -EINVAL;
 	}
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ed120621021b..558f0d249dcf 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -557,7 +557,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	 */
 	for (i = 0; i < ipath->fspath->elem_cnt; ++i)
 		btrfs_warn_in_rcu(fs_info,
-"%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu, length %u, links %u (path: %s)",
+"scrub: %s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu, length %u, links %u (path: %s)",
 				  swarn->errstr, swarn->logical,
 				  btrfs_dev_name(swarn->dev),
 				  swarn->physical,
@@ -571,7 +571,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 
 err:
 	btrfs_warn_in_rcu(fs_info,
-			  "%s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu: path resolving failed with ret=%d",
+			  "scrub: %s at logical %llu on dev %s, physical %llu, root %llu, inode %llu, offset %llu: path resolving failed with ret=%d",
 			  swarn->errstr, swarn->logical,
 			  btrfs_dev_name(swarn->dev),
 			  swarn->physical,
@@ -596,7 +596,8 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 
 	/* Super block error, no need to search extent tree. */
 	if (is_super) {
-		btrfs_warn_in_rcu(fs_info, "%s on device %s, physical %llu",
+		btrfs_warn_in_rcu(fs_info,
+				  "scrub: %s on device %s, physical %llu",
 				  errstr, btrfs_dev_name(dev), physical);
 		return;
 	}
@@ -631,14 +632,14 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 						      &ref_level);
 			if (ret < 0) {
 				btrfs_warn(fs_info,
-				"failed to resolve tree backref for logical %llu: %d",
-						  swarn.logical, ret);
+		   "scrub: failed to resolve tree backref for logical %llu: %d",
+					   swarn.logical, ret);
 				break;
 			}
 			if (ret > 0)
 				break;
 			btrfs_warn_in_rcu(fs_info,
-"%s at logical %llu on dev %s, physical %llu: metadata %s (level %d) in tree %llu",
+"scrub: %s at logical %llu on dev %s, physical %llu: metadata %s (level %d) in tree %llu",
 				errstr, swarn.logical, btrfs_dev_name(dev),
 				swarn.physical, (ref_level ? "node" : "leaf"),
 				ref_level, ref_root);
@@ -718,7 +719,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 		scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
 		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad bytenr, has %llu want %llu",
+	  "scrub: tree block %llu mirror %u has bad bytenr, has %llu want %llu",
 			      logical, stripe->mirror_num,
 			      btrfs_stack_header_bytenr(header), logical);
 		return;
@@ -728,7 +729,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 		scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
 		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad fsid, has %pU want %pU",
+	      "scrub: tree block %llu mirror %u has bad fsid, has %pU want %pU",
 			      logical, stripe->mirror_num,
 			      header->fsid, fs_info->fs_devices->fsid);
 		return;
@@ -738,7 +739,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 		scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
 		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad chunk tree uuid, has %pU want %pU",
+   "scrub: tree block %llu mirror %u has bad chunk tree uuid, has %pU want %pU",
 			      logical, stripe->mirror_num,
 			      header->chunk_tree_uuid, fs_info->chunk_tree_uuid);
 		return;
@@ -760,7 +761,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 		scrub_bitmap_set_meta_error(stripe, sector_nr, sectors_per_tree);
 		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad csum, has " CSUM_FMT " want " CSUM_FMT,
+"scrub: tree block %llu mirror %u has bad csum, has " CSUM_FMT " want " CSUM_FMT,
 			      logical, stripe->mirror_num,
 			      CSUM_FMT_VALUE(fs_info->csum_size, on_disk_csum),
 			      CSUM_FMT_VALUE(fs_info->csum_size, calculated_csum));
@@ -771,7 +772,7 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
 		scrub_bitmap_set_meta_gen_error(stripe, sector_nr, sectors_per_tree);
 		scrub_bitmap_set_error(stripe, sector_nr, sectors_per_tree);
 		btrfs_warn_rl(fs_info,
-		"tree block %llu mirror %u has bad generation, has %llu want %llu",
+      "scrub: tree block %llu mirror %u has bad generation, has %llu want %llu",
 			      logical, stripe->mirror_num,
 			      btrfs_stack_header_generation(header),
 			      stripe->sectors[sector_nr].generation);
@@ -814,7 +815,7 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
 		 */
 		if (unlikely(sector_nr + sectors_per_tree > stripe->nr_sectors)) {
 			btrfs_warn_rl(fs_info,
-			"tree block at %llu crosses stripe boundary %llu",
+		       "scrub: tree block at %llu crosses stripe boundary %llu",
 				      stripe->logical +
 				      (sector_nr << fs_info->sectorsize_bits),
 				      stripe->logical);
@@ -1046,12 +1047,12 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 		if (repaired) {
 			if (dev) {
 				btrfs_err_rl_in_rcu(fs_info,
-			"fixed up error at logical %llu on dev %s physical %llu",
+		"scrub: fixed up error at logical %llu on dev %s physical %llu",
 					    stripe->logical, btrfs_dev_name(dev),
 					    physical);
 			} else {
 				btrfs_err_rl_in_rcu(fs_info,
-			"fixed up error at logical %llu on mirror %u",
+			   "scrub: fixed up error at logical %llu on mirror %u",
 					    stripe->logical, stripe->mirror_num);
 			}
 			continue;
@@ -1060,12 +1061,12 @@ static void scrub_stripe_report_errors(struct scrub_ctx *sctx,
 		/* The remaining are all for unrepaired. */
 		if (dev) {
 			btrfs_err_rl_in_rcu(fs_info,
-	"unable to fixup (regular) error at logical %llu on dev %s physical %llu",
+"scrub: unable to fixup (regular) error at logical %llu on dev %s physical %llu",
 					    stripe->logical, btrfs_dev_name(dev),
 					    physical);
 		} else {
 			btrfs_err_rl_in_rcu(fs_info,
-	"unable to fixup (regular) error at logical %llu on mirror %u",
+	  "scrub: unable to fixup (regular) error at logical %llu on mirror %u",
 					    stripe->logical, stripe->mirror_num);
 		}
 
@@ -1594,7 +1595,7 @@ static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
 						    sctx->write_pointer);
 		if (ret)
 			btrfs_err(fs_info,
-				  "zoned: failed to recover write pointer");
+			       "scrub: zoned: failed to recover write pointer");
 	}
 	mutex_unlock(&sctx->wr_lock);
 	btrfs_dev_clear_zone_empty(sctx->wr_tgtdev, physical);
@@ -1658,7 +1659,8 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	int ret;
 
 	if (unlikely(!extent_root || !csum_root)) {
-		btrfs_err(fs_info, "no valid extent or csum root for scrub");
+		btrfs_err(fs_info,
+			  "scrub: no valid extent or csum root found");
 		return -EUCLEAN;
 	}
 	memset(stripe->sectors, 0, sizeof(struct scrub_sector_verification) *
@@ -1907,7 +1909,7 @@ static bool stripe_has_metadata_error(struct scrub_stripe *stripe)
 			struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
 
 			btrfs_err(fs_info,
-			"stripe %llu has unrepaired metadata sector at %llu",
+		    "scrub: stripe %llu has unrepaired metadata sector at %llu",
 				  stripe->logical,
 				  stripe->logical + (i << fs_info->sectorsize_bits));
 			return true;
@@ -2167,7 +2169,7 @@ static int scrub_raid56_parity_stripe(struct scrub_ctx *sctx,
 		bitmap_and(&error, &error, &has_extent, stripe->nr_sectors);
 		if (!bitmap_empty(&error, stripe->nr_sectors)) {
 			btrfs_err(fs_info,
-"unrepaired sectors detected, full stripe %llu data stripe %u errors %*pbl",
+"scrub: unrepaired sectors detected, full stripe %llu data stripe %u errors %*pbl",
 				  full_stripe_start, i, stripe->nr_sectors,
 				  &error);
 			ret = -EIO;
@@ -2789,14 +2791,15 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			ro_set = 0;
 		} else if (ret == -ETXTBSY) {
 			btrfs_warn(fs_info,
-		   "skipping scrub of block group %llu due to active swapfile",
+	     "scrub: skipping scrub of block group %llu due to active swapfile",
 				   cache->start);
 			scrub_pause_off(fs_info);
 			ret = 0;
 			goto skip_unfreeze;
 		} else {
 			btrfs_warn(fs_info,
-				   "failed setting block group ro: %d", ret);
+				   "scrub: failed setting block group ro: %d",
+				   ret);
 			btrfs_unfreeze_block_group(cache);
 			btrfs_put_block_group(cache);
 			scrub_pause_off(fs_info);
@@ -2898,13 +2901,13 @@ static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
 	ret = btrfs_check_super_csum(fs_info, sb);
 	if (ret != 0) {
 		btrfs_err_rl(fs_info,
-			"super block at physical %llu devid %llu has bad csum",
+		  "scrub: super block at physical %llu devid %llu has bad csum",
 			physical, dev->devid);
 		return -EIO;
 	}
 	if (btrfs_super_generation(sb) != generation) {
 		btrfs_err_rl(fs_info,
-"super block at physical %llu devid %llu has bad generation %llu expect %llu",
+"scrub: super block at physical %llu devid %llu has bad generation %llu expect %llu",
 			     physical, dev->devid,
 			     btrfs_super_generation(sb), generation);
 		return -EUCLEAN;
@@ -3065,7 +3068,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	    !test_bit(BTRFS_DEV_STATE_WRITEABLE, &dev->dev_state)) {
 		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 		btrfs_err_in_rcu(fs_info,
-			"scrub on devid %llu: filesystem on %s is not writable",
+			"scrub: devid %llu: filesystem on %s is not writable",
 				 devid, btrfs_dev_name(dev));
 		ret = -EROFS;
 		goto out;
-- 
2.49.0



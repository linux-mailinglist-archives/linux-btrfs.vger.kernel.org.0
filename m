Return-Path: <linux-btrfs+bounces-9760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C542A9D207C
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 07:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E5DB20DC8
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2024 06:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313D31531D2;
	Tue, 19 Nov 2024 06:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AX3SM7wf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yYp8FNpz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3C314F9E7
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731999408; cv=fail; b=kghBZRD9PY8aviRpe2Z2zDkJCs8GsehmLlbWI1dk69phfSGg8n8u1NzdTD9Kg1JQ1FJXe7x/A07nz+zhzEkmkWCnvBkJx+YzMBunXX4JFJ4NT4LmvxxXA5OGppBGjL/0XVw1AIrsPgmbIeVBJy4SgToBU3EROGg97DcUrM9pa38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731999408; c=relaxed/simple;
	bh=cSTpgQvv6Rvw6XItteq/5ikBxsj+b7toTALIFYIYEcg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VcmsGEKMGpvvvZT1qysfvAyo59SogN7rJuz2XBTUqwjiGO8cRYaXzFVtYn5z+nhAGRzCe8I1s5Vv+tREUI+Mx956dq7jxYJfkDHeC5NyAgcO80OoXHFyGIRpT0d63q9ZbEjU2+Nsf0WYG8JXIs833ZyTFgp0WpFlHG7CZ5XhN48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AX3SM7wf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yYp8FNpz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ6Beg7021305
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=28TyyX50DylaJKRWcUcdKNRfgJOM73j0VwaU/iTuq6E=; b=
	AX3SM7wfUywjCEng9Tt4y6xcUVnwxTmMZR1l7a4sLHZP41H0XcHSUQkX55fYXmmQ
	Mu7fzHl/3fdJhBB1hqz3VhSfu0fC/XSwB34jNHFwV+q24uUNVQoj2ptpHINWBufl
	IxxCbTGERmuYCV5zI70QYuoXhvw4e825BxifcvqehA15GutS1CGrYEW/jbtWKsRY
	yseRkXab/jE3prOS6xsANS0s0n0Nhbx4qp5j2lV4Nig6vhYIIjWunz6lTSh12Gqd
	1R151bxL9sDMm09/ZG7MbMLI5pOZGD7s7P+n8TCYOkBecCX7TNLt6SquVl0ZgMCf
	5xazURo3M2WW1wamJFdXeg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkxsv6m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ57hvM008935
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu8b4ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2024 06:56:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFu/K56iQbSJT3dBTqJ1dFOSYiVF6cXXk2Ln3uGiIImjiOtXcouNuDOWWLCFXS3JNjHF1XZR+xkz9NDOp5bu9TSrcHoGbCI/rhWkkOsnxr8XmSKe53+Ho2OyAGiP5nMov+u6TfVM93BjhUQpZNSPQiD73riiEnACShHyKhvTksYw5h77F15ft1/P/lQ3YRAkjfMWTHK23JoZvriGEOdS6tPxi5EbcfZJCQGcE76Uz5f/JWSwqO8jqMCht5gkno2LhOBHomehIsgPGmOpTpYUpPPqlrI7I2AJNkMuT7f65X67HRNlMmmkDM206TeBGv1W4hR7Mb2h+meQ5XQ7tX64Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28TyyX50DylaJKRWcUcdKNRfgJOM73j0VwaU/iTuq6E=;
 b=LzXGoAjIDKURRl7ghVry83oPGiOyaAMSuWWJEC2Xwy3HxOJCdDo4Y0ULqiO+c2+VLH4sVuPC8VFPPUHd62I7DQvCyfOpcPArigjAF0um7ldFmIDkMzVNHYxluh0cvAxlsU8rkk1K9XBF/gXlIvfy4ageMsb4ZZ7es9WjVlRtSry2fedD/Z9yxT5EqOZjtgVVPIrcyA6KJkt+byjcNyn1EMTOMrnTlSKgZukFUKyq529KBCc4a+m6ZpVm7ypsM8jRzrx5rlFxLgpGKVMDOc/SIemtjrMiXZbORD+T+tmnKBsMJJXtvBoK3y7sL4+RchEZFPaf9QrIT8lnHhXcZ0VAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28TyyX50DylaJKRWcUcdKNRfgJOM73j0VwaU/iTuq6E=;
 b=yYp8FNpzUntS0Y4tZeAIhm3ypVc+ue7PcKxIFakoQGJU92blFXLfaicpIWHBMssf/9d6sY9RSwR1OtYMDvC1DMTFbw6nBVJeExgF1YE7g4sr29r9mfnfbDc5+OuTTruO+DHysdZJWkCrXjjO6giqnL9sRQqnS+PPd9P423CHne4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4606.namprd10.prod.outlook.com (2603:10b6:a03:2da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 06:56:43 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%2]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 06:56:43 +0000
From: Anand Jain <anand.jain@oracle.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: fix doc build issue caused by confusion between BTRFS_ and target
Date: Tue, 19 Nov 2024 14:56:16 +0800
Message-ID: <7012a74c15837c8efe1675bb38fe404556835537.1731998908.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731998908.git.anand.jain@oracle.com>
References: <cover.1731998908.git.anand.jain@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SJ0PR10MB4606:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1805d7-51c0-4a21-4184-08dd08675358
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2UUsmdw4XjmHwznRY8MyKrTC/3qOS3NKhSN6DzJe20M40j/hUeFvK/l5QdUM?=
 =?us-ascii?Q?GDIFVg1IRNRp6MIENKYHM1zMPg209x1KwFdVjPdiy1jdTgRlMLjmfBQbk5Ir?=
 =?us-ascii?Q?pyV1+arbsH4GZ+DnNO1KQZkPWk5cRZwkeKsKOJ7fNdEN9QAwbnrIgeG6K8tc?=
 =?us-ascii?Q?g2SL9TysPFj4mnT2ZmbUXs9kqUPE6HdaiCvi4IjoOb1re/ExW1V//P+6iGIg?=
 =?us-ascii?Q?/fiY7XG8QXLyRNvyVY3PC4UOjdCKytEpnKV6O92N2DrTPmau783HIVQhd/fk?=
 =?us-ascii?Q?o3jjw5N9Y+SgFyJClnolikUIWgecmImOzS5kqhcH7LSyBhgvUmOSMgH5ULXv?=
 =?us-ascii?Q?WcFftI82a0gw1QrD13SVp0iLg4uJi7lm5QDEGv05jRLityOL1+UZNzH//66W?=
 =?us-ascii?Q?zBJKoeHQsZLWf/5kuGCDQBpA8OtwIBJayRq/Is9XLb78a2gApeXv6jKwvkGt?=
 =?us-ascii?Q?Bu82InX+/blF5gKHJfrB/5A3LD3ljOt9Ov2265JrcIuCUeYi0trMOU/pAMDf?=
 =?us-ascii?Q?Ir0WilyyxZVXD6Av9kTotkgsCJtAi5op6+um5bPJjckeTGKwaNiEnd/11a+9?=
 =?us-ascii?Q?QopR/GhoOyjK/5g9E+sq2pUu9bcqU+mrDC594l0mqwWeQvk9ONBHUFF6/yHj?=
 =?us-ascii?Q?CeMxSL0PkXNRk7Jr02x/5bQ6OD3AkUafyZgYJlBKr2l0cCik1AzhmutW+aB8?=
 =?us-ascii?Q?aAwb2ZGQLd0JKmkttc0LDjIx/wPZQHiTO7MBU+9GXvzfIjXLxw3Th7wPUUGI?=
 =?us-ascii?Q?eNZrgbcyxEwo8twV+QLxzjpxGKeFrjAxqbd9cDNUL8oO+itK6URWaf8tpcaI?=
 =?us-ascii?Q?f7m9XH152MPWUNjWcROHufoBA9fbqTfTgD9QeYO31cmA9+9z0QI3AMaJuHMb?=
 =?us-ascii?Q?jmYlCdMud52JHilQu+KvMrMExCL+r3uBjO9IM6qDCxhu+aGHsCEE1cnkzQ51?=
 =?us-ascii?Q?JEexPzz2Etgpg/740ehXCYSmqvSEEyZFi0cSwCvlgMiWIKBK2kZ8x/kHArGA?=
 =?us-ascii?Q?47SbJxWSwzwPyWu1l7a0IBcZWKWNIvl6wYezsPDsGnK18CywUXb+IUNJCPKW?=
 =?us-ascii?Q?2HeN89RFsePxCZzVaGW3rTcjdRpnTc05corvgRBu4kpKudkqQe4L4qahL4Nj?=
 =?us-ascii?Q?2uz5hGfd3d8NNqjMXk8VFFpKXrcaNr95hS19aFx71sE7fpbiho3qyAu2K8V0?=
 =?us-ascii?Q?vCKdAyKRNujokJT2ufM2NAppARtHlAgl34z5g5o36X9yubt7gV18+ersEwna?=
 =?us-ascii?Q?QSj9P9g1jrSPX1/DsG7g2wxyOx1bdQM5lA7RaJzGKtpDLzpNxnlxIJIPhacR?=
 =?us-ascii?Q?4UGvETxKxKwYCYrjJrMvHAM+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rZV1e4Fi5+MR/GGeDHaX8JNEN5bpBGZrl9bJRBeR/9ttR0jWplI+oR9zw236?=
 =?us-ascii?Q?oAijSyz/KtBPaRIECOtRKMHICf5WIYj7LaKlBDtYbgdPFMIp5eCM7LWQYXVM?=
 =?us-ascii?Q?myn+6xYFBBnVIUKpj35e7p7XjY5xdzWquTMBoIXQCjc8Ji/U8Kb7v+z5ZLp+?=
 =?us-ascii?Q?0z3PAJHBrtCpBIb0PWnFC69id5sHW+b9WEoJ12bcRsC+iGoYt6TlS+dQ/3u7?=
 =?us-ascii?Q?F/jZNSy4ozWPqpr5SqqiJ1nOYouKMsHrgcb/UJGouZxtBX9DECdI0Hg1zuzR?=
 =?us-ascii?Q?L5kvARC1u7dRRdSzsNqu/5FA9ogx0lrFou87nq2D1HllJgFV4ExFwrsV5Sak?=
 =?us-ascii?Q?UrPdQRflGiwEHrV1Tfrc7CIoghjObIhInoHoqaTbQ4vix/qVkveVdbO7AR5y?=
 =?us-ascii?Q?duFN/Fe1Iqz7h2PftsR3ToUP9pdpWiiEAaWzjc/xpcX8AkTKE4PuH1RaHgM7?=
 =?us-ascii?Q?q9VXQHB96uxTJt2yLjeoEvs4oIu4Wh3SfkFJpQtkcEVs2qaTMR2BK60XpDig?=
 =?us-ascii?Q?hqtjcXW4an5FBebI1UxKPMcOvBFnpt9GVUIYWqq9L1WPTmimSQQjDlpYbrz8?=
 =?us-ascii?Q?P/ZXX77K/zBkTIz1DrwEKONj6M+TQPFAFzpO/y/hhQZ4yFf23u3nvR+w9NEW?=
 =?us-ascii?Q?H3swEOT/N0o7MpyPdL3tn5jvfm9kwoW5QhItkbezLGRB+n7EM/ZaDRoqhlvm?=
 =?us-ascii?Q?LKmZ4Fimh2Z9UzrywxLj4d825xejGkdTkxSLKgNlPRM4nP80iL7qR/DmSrB/?=
 =?us-ascii?Q?22B8W+XwkRYKSV1eAQ+4RuqJycnfwzQr3k91q4nu/YQ3UtdjIpwyOhAQ9HTg?=
 =?us-ascii?Q?98PW7uxmrc7AiPWiwNW1UYX8IsgI2FaukZb/FEfCk0DTC6M/P3eQ4Y9hno1t?=
 =?us-ascii?Q?ABcoDeYvkXYLvSxM/p2yOgiAal6Iurf7T8lm0WQ05iTTAxWgCKA58sO/SglO?=
 =?us-ascii?Q?+dGFMRCsTOjZyqo8Q9w+6/fFbsgDbyXbxJLWq11wS5bUxz4AF1ki8xyCo5IF?=
 =?us-ascii?Q?fOExpGWc3N5cj1Kv7uHm37bq0k4FEL27601+bjKWii09nHnL9+tKy//nuqd5?=
 =?us-ascii?Q?TAWWlwZHqx589iQTsA1LKrSqznd1AEbC85YpXSb5dRokLjOD9EriyiSYfa96?=
 =?us-ascii?Q?xnScVFONDfVetVOI8LH3fV/VWhl7NvQv0FheWybA7PCfJu0Kus4b292y8Sz1?=
 =?us-ascii?Q?NHUnEczb9hNfEZCldS2wLibWUOHaUaMeHdMIuawRR+Df/h2dft2V83dMIhK4?=
 =?us-ascii?Q?SlQGBwUeVUkzhIqFZRjMAbtyw/R2BZ6S8iQfxjh+zfl/tcRgVO3B4hWwQA+Y?=
 =?us-ascii?Q?gLHEBozydwRh22bldjI018OGo0irhi8h+O1PblLlSDiYLEgw8a/c7QcbvBON?=
 =?us-ascii?Q?4TEmxU4uAV1EsSivzemjUa8hX5M9pEbrHl5PlCb0rMkadgf3zgUaJiIyA7FR?=
 =?us-ascii?Q?x/+2WB+5F8eQwuB4Y9ojBQPqYMAYXOF3QQS5gxrMwrrpTJILOg728JyMWLgY?=
 =?us-ascii?Q?VW+rwOvJAf6EVrceA5k23A86NLuFRTWkQLlOV7QWZs6lQqZFT74lk63+omK6?=
 =?us-ascii?Q?+6HMAi0pSw6LHjS5GLCQQLfdHBtjjUvTk4ANjbWg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6orX35byDRTXaB4fdurijNucjKe04g99M0l4K6B5wEvrOOicFh5AOTQtGcJ9/hZbe/UgpTLyvRGyyRvBgqYG/RMMoLQ56R1761rEa5r9PNILO9fGTh5GA4Zv4Jllhy17AX1IWyVM3iMdVM4Nj8sMgGjwn/zXHqgEmGQVCc/36v6iF6kHrHSumOIhNWzdiYVJUJTwlHAp31amNM880T+WU5N+CJr8EeKSiWjNr5+1LglFdn3vPSEWJz1VQdxY6xuuotgM7VbBb+Zlx3stbjKaRbGpjAwLujql861fg2Ac9NZR9WUzt2Z7zSeAQh0qprPoILCecpxBcgskG7WKE3nCuRTdZBxnpOCcvQ+a+2CUtfXblvLknShGSwjOcfyC5vfxoPykI4/zthn3fugpAMU+jBnDpI3V2kE8BDJDKS940voN1GVqOe0whSUams+F9p/D/q3vcT0MdzNwbzDPjgOozlWlW+nPlP65EMBWCgWzMVZrecGHGnhV5y9PCg8ARnkYgfQOWbonHBIb0bCLFVJo+3oIyaN9xNizYo7MhgGVgQWqyjKHZofezIp6xIO+fB7vjA/9bx2P+4kFmFAbLTW3pG+dzW+qpHa0UJ5/oU4csZw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1805d7-51c0-4a21-4184-08dd08675358
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 06:56:43.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nul0g4yvEX+iO+qFmCdoDVs7kobnaiXVQm43UOX9S/FHHw6FyKlILkiZzvNHT8XcLGQ8+dtJw3LcGn2Evf6bQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4606
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_17,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411190051
X-Proofpoint-GUID: qbJmYN25HFlwP6Y_ecGmTAhrwYeW2t9i
X-Proofpoint-ORIG-GUID: qbJmYN25HFlwP6Y_ecGmTAhrwYeW2t9i

Text ending with `_` is treated as an anonymous hyperlink. Use an escape
character `\` to prevent this.

Making all in Documentation
    [SPHINX] man
btrfs-progs/Documentation/dev/On-disk-format.rst:32: ERROR: Unknown target name: "btrfs".

Signed-off-by: Anand Jain <anand.jain@oracle.com>
---
 Documentation/dev/On-disk-format.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev/On-disk-format.rst b/Documentation/dev/On-disk-format.rst
index b3304032651b..39fdaf09b98b 100644
--- a/Documentation/dev/On-disk-format.rst
+++ b/Documentation/dev/On-disk-format.rst
@@ -30,7 +30,7 @@ also contains a logical reference to root nodes in the root and chunk trees,
 which can then be used to locate all the other trees and data stored.
 
 To avoid duplicated suffixes/prefixes, sometimes the macro name will have
-the "BTRFS_" prefix and "_OBJECTID" suffix removed.
+the "BTRFS\_" prefix and "_OBJECTID" suffix removed.
 
 E.g. "BTRFS_DEV_ITEMS_OBJECTID" (0x1) can be shown as "DEV_ITEMS" for short,
 this matches the output of "btrfs inspect-internal dump-tree".
-- 
2.47.0



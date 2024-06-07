Return-Path: <linux-btrfs+bounces-5559-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D19900949
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 17:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5751C20C6D
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E49197544;
	Fri,  7 Jun 2024 15:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SuFhjiBu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D319C4C65
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774664; cv=fail; b=d9rDZk21PD0EJejRyJC2biMn3sBMqVL1InhSRPcw8wAYHS04jP2wSuS3BZ9afpIbHoXSw62AAQqGB/U8dU8nvZOtA4Y1K61/ERipSUqJzF2MiZsyTOpXnJXt+XZHGUdAe7AiTqVOUnPEzZz6cxRPsD5BNVcTru0p3d/I0CINklw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774664; c=relaxed/simple;
	bh=cr1puG3dAWWSvlF1Uxd0tOt/5ytqMyLYFPHofjX54HU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tc/a21lPfqm4Ut9DGP6vO4WHZDs/2DcRjqGoB5F6kdfkOPDoX6HLgSRRiA7ukXxiSFh8m4bruEX/YjUbZn4ifgAGJ9wiwV3dJXLZCgjGdzXsCdVKFrNqCZ65RF63EW88BipGuxmXwMnkpZB1RJr/UCHVspmUAsPL3RnCb87FVGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SuFhjiBu; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 457Cj11Y029880;
	Fri, 7 Jun 2024 08:37:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=fvCsAH8WttgDEgIg9DBjwQOKKgd8/PI4VukEg9sduco=;
 b=SuFhjiBuqYrxzxECnjP8eRQyhRgu7uj9rVeN8LajbYJVVGiklTnUjlGar2R1icSyDQ20
 B9fP8JXDDZOQ5eLIsT8/u9MANEK+5sQPUr8t73Xsd18WAwYLfgTdPU8pqC8Yb0RwqKsi
 LcyQlOHB0nV8A8W+UAVFifksxCQTqSgg8r0rtjDk/LF4xFpObg9EhEfJDOQhLJZVhFat
 9A2yDFQ2yf11SS2NLdkxFztiIQe807kyC4QDfxMd7PYeh94eLbFGXs7anLmPvfxqgeMq
 vaBojw7hD+aY4bQl2FgNRJRxWUBzrFFKd76Q1DQwUgJsCP49xLlZYApZiYSg58h46ixZ 4Q== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by m0089730.ppops.net (PPS) with ESMTPS id 3yk87j2r0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 08:37:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgMAMR8PEjV7ZlAg5TcOeftfTRYbgluP1bBBh17QQj5lkBlbF/k4ScDCOofIRgHM5TeRrIMzHj0qlYmgJQsKyQZClCZOwehXfGAIc1d3Y7LiW58eO0gqnOgr8piAFvFfs3M1Gy33cvzD18X7JN4K1HDiKivC4eyTP76ldHUa+r8THjoTi5BwmuvAiggTESPNUbRHUsyNgq89/blX4NtnX9sEdxU+2lRmTHp0wKUwzaMbl9bv1UGT1Cq8/P7+smCVZEZn0KQ4/uzv5T5S/vWn3IsoaF5Kx/3fu6dIKuxOeoXJAWTmFKkBeumUBOv73OidQjjYBh5xFTNjHc4f9XR5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvCsAH8WttgDEgIg9DBjwQOKKgd8/PI4VukEg9sduco=;
 b=nkiOzhxq6/9niO/cVJVhv1Vne8nD+alLbSD6rB2olnAqJGLMJP63kTSSgkPIlKRNe+Z8+1PnTCE2g0rXlcENiSz3mfAEE88ua3SEHsv0mrePAS/evv8ZVC4oE+pxKFQn+OVCWNohMfA1nF4hzVStDCA9t95FmAu33EhRuBx4+6wAdmLk7Ar/bBijTI6yL/YNju/gm5puLeOuz9mM2NbYdlnq+nGRFDwb9hjhQUtV4s8giCKWLFFSDhRqhFEDFIjXSLXNQdDjc5Cnq96UAYVkNxxn7rI5DQdmS0zkge82IYXtzDnr7pM6qYFSLekRIE4l/II0c+EQePsqC8jfff0lQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SA1PR15MB4577.namprd15.prod.outlook.com (2603:10b6:806:199::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 15:37:34 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::1ebe:a628:f42a:65a2]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::1ebe:a628:f42a:65a2%4]) with mapi id 15.20.7611.025; Fri, 7 Jun 2024
 15:37:33 +0000
Message-ID: <2d3d6ffc-d3a2-4219-a496-75307f2ff83a@meta.com>
Date: Fri, 7 Jun 2024 11:37:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix a possible race window when allocating new
 extent buffers
To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Chris Mason <clm@fb.com>
References: <0f003d96bcb54c9c1afd5512739645bbdddb701b.1717637062.git.wqu@suse.com>
 <20240606192722.GF18508@twin.jikos.cz>
 <c3197ead-6393-4a80-9e7b-ed8eb9b8a298@gmx.com>
 <20240607135603.GG18508@twin.jikos.cz>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20240607135603.GG18508@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BL1PR13CA0241.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::6) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SA1PR15MB4577:EE_
X-MS-Office365-Filtering-Correlation-Id: 8538c697-49df-4b99-0b35-08dc8707c018
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dTk2VjZqVzVNK3RZcGFyV3Q2ZklYOURXLzlxYk9KNklMM3FycVN1d1FrM2pQ?=
 =?utf-8?B?bVNsMm1mVzE0bGxaeHh6Q25YSUZDU09GVzBoeldMdEdGWWg0WDA5QlNja2E3?=
 =?utf-8?B?cUEvRlYyMlFJVTR5TSt0VStrbHFWWmJSWUhZaGZBSzhhWVV5MnZydTB6ZVFt?=
 =?utf-8?B?RkU1V1pnRDkwMUF2RHkzekFscnZ4TlkyQ1VPVDV4S2J4bVJWdkE0bnlVNUM2?=
 =?utf-8?B?QmJMQkUzMUZ4ZWlESGo3bEh0R0FUUnJyVFdWaFNOUmdoVW1DOTczNi9PQ3Rr?=
 =?utf-8?B?UmFtYXRuNit3bVhJMFBsK1pSWElBK1BTYmNXNm9SbHRGTzc0bFQ5MXNDeWIv?=
 =?utf-8?B?ZEF5bUtYeFpIeFZ1ZmtrQUYrY1pnOGhKUmJ5VVRrWHU5aElVNFFsNStCN3I2?=
 =?utf-8?B?d1NyUkZ1NENMUGdpVXpmZCtwcTR5eXFOTnphV2NBc0FKYjg2ZDNkcmV1TU9r?=
 =?utf-8?B?VkJ3MnF5S1ZxOUNyam50N1R0SmdTZERVSFcxVm45Mm1oWS8wcmpiemlMRERh?=
 =?utf-8?B?Wk04bmJNOXo4R3RFbEJ6YytrMlBtK1R0aXZiamd3b1FwaEpnRUZ6dlQ1UXZt?=
 =?utf-8?B?OWhWaFhkUjEremUrQzNkbUVHZFZmajhleUhSS0pqMjZ4SWdLenhPdms3UHhl?=
 =?utf-8?B?em1NQmJYOUFpd0RKYnhtbFJkQ1V1Rms5ZmVxZUU0MngyMnBrR0preHpLUHJv?=
 =?utf-8?B?MHVMUFBhaVR4OEptc1cyUkVGYjVoczNvdXI1ZEdCdmJTODdJVlRvK0xXdUYz?=
 =?utf-8?B?b25hTjMzNEQ2dk5wNUI1b2d1NmgyRUtOZEFFNlByQklkOTZNdTMrUkdoRmRV?=
 =?utf-8?B?RzNCWFpHRElBY0VIWlBtSXRqRDNWK1VxcFVqeTNjY3YzaXhvWTlxK3M4Q25G?=
 =?utf-8?B?c210K3o1b1lGV0REQktFTnUyNlhHNHc2MkNkMWdpbm1WQUhrTHUwMmhxTU1Q?=
 =?utf-8?B?NDNlWDBHQUZ4WjNxMUdRdno5eXFNY0lJc1NlTkZHcnFpYzdrdTJ4ZjRmTk9C?=
 =?utf-8?B?RDI0ZDFoekNOSThJdEhiNDBnV1NFdm5ucGV4ZDBUNTBjNWdIcSsrTU1hRGk0?=
 =?utf-8?B?Z1NpZGw4STlLMVkrdEhyN3liU0RaZVBPa3p2MkVNd1ZYRTBqVGxkSjhTcklv?=
 =?utf-8?B?Zlh6dDhoZDJwaXZYbW95TEpBWW4yUnBRdjI2bUdFakM1YVRBcnQ2WEZOdnZH?=
 =?utf-8?B?WW5yOFgrcnZZaEhKdzVzZ1RaNEppdndYY25uWVVEVUJaUWR6ZDMwYXZnRCtR?=
 =?utf-8?B?U1NTTWVJR2xLMk1QRlNLUFlNWWg3OXAwT09jT0NwcjI5RkRLZkhva2xDV2ZF?=
 =?utf-8?B?Rzc2UGVoakwrd3hPcmlZdlJQK2lHRjVXc3Zja2oxdXptSDg1bUdUenFxaGh6?=
 =?utf-8?B?YVN4SlpwYkZoeGg2TmVZOE1UL0NvRDVVcFJyd2tlMFB0cEQrSTVTeDRLczE2?=
 =?utf-8?B?RTNYVVNqNWxodDdLMFNWUDZoSmZ5T0Z1TEEwSVZuS3pzNEJWVVRsK1Z4bWVi?=
 =?utf-8?B?SEx3SlQ2VGVaaFJxaTh3cEtqUDRsM1o5aHR2ekowMW9wSzBqbXJGSCtUWGlH?=
 =?utf-8?B?clhxeHJVMEppZVY4VzJLYnJIbUNuazJMS0xsNHY0SVBvY1lsN256NmMxampI?=
 =?utf-8?B?eWZDVUZaQVdISVh5amxHd1h0Wk9qS0hKTE84cjRUYzFSY0krYW1EMGNHZitH?=
 =?utf-8?Q?i/jXrrzwTN0HVOg29jIY?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UnV6bVBsd3hNbkZ3WityUEhQZWYrNlZXZHBSakpzTVF3N1c2ZmtDS3VDc2pi?=
 =?utf-8?B?UzRCVUgvdmZNRlF4TFlML2F3MjJvQTNMeE5meC94Mk5STU5yb3haY0NMMDdx?=
 =?utf-8?B?Sk5pemY2aWtzTTZpdzNFYkh0ZHdBWnRqdDhWdXdwOUVVeUhZcVZITGN1Qjdn?=
 =?utf-8?B?dXgxc1JxUzFGQkUxWWYwVEpEY3dDL2UrSDZZZVp1a003QkJqbDZrMEpRNU1H?=
 =?utf-8?B?aWZiMlVJNFdUcUdRZEJucDNBY0Y0NkpONDcvWDl4WHJ6aDNUODg1QWNWakZ5?=
 =?utf-8?B?RWIwcE1NdFpIWTRjWmFVTXUyZE5PNGUvQmVUbDFweFZXT29DbXN0WnpBUGZk?=
 =?utf-8?B?aGtnQ1FuNDBlYjd6WmhrTko2NjBaUVU1Q2hwUnNhQTduZzlJQkltLzYzVnRo?=
 =?utf-8?B?OFYzditDZUU1dm55MjhaRVVKZGRuRHZEUWpqQldZKzNqblAzb0hmdWlMS2RX?=
 =?utf-8?B?OVViSS9aamk5TXVyZFpHcDlEbXpNV0hRbDRZR0R5eWNKZHdMUzMxUnV4YzNI?=
 =?utf-8?B?bjlxanpnQklGcU1HWVA4bE56M1YwelY5ZWtlV2lRaHEzakY2OUlKWTRPT2VK?=
 =?utf-8?B?UTFLTE11cURLbFZaTlEvVTlBUTU2SFc2RXdrMDRwQyswMWkwbWhVakNUVm1z?=
 =?utf-8?B?bjN0dm1tYjV3NEJjeEx3d3BPcFUrc3BiUkplN3djL0NFZlU0bXl5SllBT3ZT?=
 =?utf-8?B?cHQxNDV0QlhpcXVEK3JzUVhVM2tmeWRxY0FIYkpQdWZqOThvSE1uT3dyVnAy?=
 =?utf-8?B?dTY4M3VNVmY1YXE1bGZRTDFWUDNjaDV5UEdockZoeGE3RlVoOGhOSjNyeW92?=
 =?utf-8?B?WmJicmVTd0o2dFF5ZTEwd3ppZU9vbTFERmYxNGV4TmtWQUh2Q0tiMmFGc1NC?=
 =?utf-8?B?ZjZCRTdOclNJQVFVd2ptYWU4eWpaMDRtQWI0TmlVR2JUMFc1L3dUcTE5K3Jn?=
 =?utf-8?B?Zm53bXNyMkoxQUc5azd5dG00MHRHS2RrK3NBLy9KdlZCeUpCTHhlZTJZYlF3?=
 =?utf-8?B?SnFQaTdYeTRvOUR3R1psOEJwdTVJeXNrSGFCSGVWM3A1MnNCVWN4RDlEcEpm?=
 =?utf-8?B?d01MeUdtdkJTQml3WXJrNjZhMTB4VzJsTVRlbGt5MFdtY1BKaU51WVhVMlpv?=
 =?utf-8?B?YTJKZUhTeWJXZUwvcXRxMmZzRlZodk5pYzRHU2ZEcEx5MkJLMnlFT01SVG9B?=
 =?utf-8?B?bWpRTFF2dCtDWmdIdTJoYUVSTXJUL0tkNkQzYzRSOStjaldZZDhJdm1EU05J?=
 =?utf-8?B?bVRqemtlc28rck4xZ0JGT2s0RFQxeVlORVhqWi8xZ2FhNFNuSG1vLzd6RFZt?=
 =?utf-8?B?RXI5NVIzTkd0QnVNeW5SSUNaaGRxNU4zRjFWaE1ISy9ta1VlQm1ENlJoalA4?=
 =?utf-8?B?NnF6VVZXZHh5eDdpTlNaNmdPYXoyYitNSFFHbHloM1RmUCtLL2NOc0poNlYy?=
 =?utf-8?B?VkY1TzdsMm12OUdQVHNUSWVwQzhhazZsMDNmVGFNYUowS2dhTkd2RnlYSCtH?=
 =?utf-8?B?Q2pwWWR2RUtlQnVHbkZFbkhkZk9PakhFdER0UVNMNUI5ZldyT0VYY3pFRERD?=
 =?utf-8?B?TVdCVUFZOHJmQkZuQ2FpSkJqTjlOaG83aTd2OVM4SDhHUlhXaHk5ZXkrR0pE?=
 =?utf-8?B?Zlk5dFd1Mmk4WUUvY3laUlFTTGY0VjdySjllbzkxZS96S1grUGhUWXdIamho?=
 =?utf-8?B?YVdGRWp3MDREaFk3MzNGcnVtWGZUTUM1L1NUL3lSMU1taWRNS0lST2VvbnNK?=
 =?utf-8?B?WXg4VE5YK1FzLzBmUDlFOEJkaGtENXNHVCt1TDByVnJ1bTFsOHk1bjlGNGo5?=
 =?utf-8?B?bUp2ckZuWTJRS2NWcm9ZTHhibTg5c1RtVng1VVlFZHNjRklidndjWGE5cjE3?=
 =?utf-8?B?NzQycWExT0tWSEN6QWltUnVDejQ5RVB5YWJwaFhCQnZobGpZVjNud3Z4Z2p6?=
 =?utf-8?B?TU5WekNzeUs0LzZnVS9GdHBNZVRuNGttWUU4VFNSTUlRRWVnZUw1ZjFBb3ZQ?=
 =?utf-8?B?ZzlQNXdjaGpVTnBMQWUzcnZkZnU3bmNKcEJUNXcyakxYUk11ZTZNS0Vqc3V3?=
 =?utf-8?B?TndvZGF5aGxydG9GQjhRTDdtT0JnRUNhVFF0Nk5FZUp4MVZETE44RENjSXRz?=
 =?utf-8?Q?N62M=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8538c697-49df-4b99-0b35-08dc8707c018
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 15:37:33.8315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/MuwQYD/sVez+7LzlDZukWu2gX/c6QMdtalwT6MXIBUIuhvwfrVl/fhbRQDJudL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4577
X-Proofpoint-ORIG-GUID: C99VSR7VO8WltGwU4iMY2q_LR8C4kd6g
X-Proofpoint-GUID: C99VSR7VO8WltGwU4iMY2q_LR8C4kd6g
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_09,2024-06-06_02,2024-05-17_01

On 6/7/24 9:56 AM, David Sterba wrote:
> On Fri, Jun 07, 2024 at 01:57:38PM +0930, Qu Wenruo wrote:
>>
>>
>> 在 2024/6/7 04:57, David Sterba 写道:
>> [...]
>>>
>>> Thanks. I'll pick the patch to branch for the next pull request, the fix has
>>> survived enough testing and we should get it to stable without further delays.
>>> I've edited the subject and changelog a bit, the problem is really the folio
>>> private protection, it is a race window fix but that does not tell much what is
>>> the cause. I've also added the reproducer script from Chris.
>>>
>>
>> Mind to push the updated version to for-next?
> 
> Now updated, otherwise if you need to find it the branch is
> https://github.com/kdave/btrfs-devel/tree/misc-6.10 or it's in the
> linux-next source branch
> https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git/log/?h=next-fixes
> 
>> I'd like to restart the test of larger metadata folios.
>> Ironically if we force larger metadata folios (one folio one metadata),
>> the race can also be solved, as now folio lock would kick in to prevent
>> the race.
> 
> Yeah, but this would be an accidental fix. If we didn't understand that
> the bug was in our implementation I'm guessing large folios would be
> blamed and this won't make finding the problem easier. We need to be
> sure that the easy page->folio conversion is solid. You can start
> testing it but the actual switch may take a release or two.

I was going to suggest that we wait a bit as well.  The new code is
holding up well to testing, and we're going to roll it to prod w/our 6.9
kernel, so it'll end up with lots of validation over the next 10 weeks
or so.

I'd definitely start on the large folios now, but also give the code we
have today a chance to soak before making the switch.

-chris


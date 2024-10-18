Return-Path: <linux-btrfs+bounces-9003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA15B9A498D
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2024 00:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 978E828471F
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 22:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8244318FC9D;
	Fri, 18 Oct 2024 22:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bht9j7yA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rzVgaPnQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0614900E;
	Fri, 18 Oct 2024 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729289731; cv=fail; b=M1q4KVVp8GtoQEWFMmS7MFgbK/nv39Y2Fo7HWiqOWvFp+KJnCipJANwtfVMK1a1PDHhkpZxUt0Z8tZIK/lM3D0yi4dMCf1ruodTQUhZ27RllgPNvUTjA7GiV5Qic6sNCgaGF5arEbubXV63S4NWEMNkTdAqihDCaebuGjQpRxl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729289731; c=relaxed/simple;
	bh=WaupwKl+lO2qyhBAW/fq1zmltKGkl8DfjpdzibsOUvQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YVd3avzWujgH7Wksk3rMxzApUVtmlCf6QxdDPG7QuN3n04z81V/l3lWZ0CkiGy8FwuVRxXr8Bx89xw2pQfbfW2c8UwNZaIDM8gtQSZGxaGQA3ixK0Lu6BWmS+EU7dAiZBvxQrHlwoSRIkCGEVQ4OoU2YGrn3NgyoeolC3Zu5lcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bht9j7yA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rzVgaPnQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ILuJRN009586;
	Fri, 18 Oct 2024 22:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pKLleljCFWq8SBe9P6pbSFI6CP0OS1E6ptHsJf8Tr9k=; b=
	Bht9j7yArhIbWKcl5PVrttvWHg+MM2cdJGSJZGneQWRSFnIsJcPiJ6dU6t84TL/i
	l3zhDEqv3qZAsrhGw9aq2mZSW4NrlgnZw+d/iszEqvZf7t/l8VDui56DWEoCW9bz
	Tr/o5rWqfj4jX1Nn7PC1emjjc4G2nrEmUAuA9QiU6DYZY5nGdAfcSy1DNiRPXW+G
	LLAefIQFikK6XoqnAi1PA1kg2wl0rspXvDdSuhMN2OeO5PIrULz7rDzOrB87OxUl
	aubSlyVthVBu3mTPesxKaB2+vUUyWugIJ4nyiyTSpijiOUz2Wc6b2unYscjLjeXT
	gHN44b0EmQnvyReBNRP5vg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1ask8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 22:15:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IL85sU019899;
	Fri, 18 Oct 2024 22:15:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjc4pk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 22:15:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFilb9jukscMtuegGdf4d3CRcNWuFPezPaJnAOyamk0vksLNMBSmMR2xlLBsQMm9+PLF2eTctbma/pWcA+DaxKhIXnqKCYXgbwhZ/uotC7Fp30Wjk1Y3Rm5iWEANhsYpNb3wyH34qWF8dFQK2ozV1K4Tuqo6ClC7OBYZlFlNiRU2etjzgk/6RtfTVzO5DkAOhLtuutweXmZJ3WXEkEPlRs/J7k04arXgsjOxqubJSX3S4vLinTKGoQVUbSMJffOlwPTiTFmxGABZiE/2g2gJi31xWy46O5RmLsIVXZJ2LUh5/oanC5NAhqbXEmoS8p+ygX2PxOXiDwNlD0BuGU/d4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKLleljCFWq8SBe9P6pbSFI6CP0OS1E6ptHsJf8Tr9k=;
 b=pn3UrbPf+IqqJu1r2hsENnAeGWDN+NK7ZiGQZffi3QC8C/sfIOSMA0JjtIVg/huy9zt15nkwt5xcgklVpSmt2h+uxux462M05OxQvMJRpFvJ96Fvg7t3Y/iM8NRRzvkwzHX5q7Fs65Eo6wp6ZyJWVyD76dJICKiS61v/k2fjyhaIumpT9N/UH+NGD8A4H+ZJEspx5d0RyExEfm7HoTi4MWRFE8E6kWzwz1dodebUPePXxgos8mJymPonL26WRuB9mBLD4p5+n+RPRlKWlnU0AJMdtPlcNWe1QeEIvdHwSAhFV60yME8rQgdbzhZ/LsajFzyxIb6PmXMZOZrdTk3ERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKLleljCFWq8SBe9P6pbSFI6CP0OS1E6ptHsJf8Tr9k=;
 b=rzVgaPnQPdntsw/bNmbdHufbAVU1m5UKmXnbUEgtAgxCpwHtPfFFcLj6I9nXdrUMb3GYR5GeHVsp81v7N+PHXMeRIcd9IAy0h6JE0pblMXASVjA3XCCozIOUQ2pbTGFxMtddYc1q0kPuy9yPGAJH3/3wGFPS3Ir/psPUJlQHbtU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5713.namprd10.prod.outlook.com (2603:10b6:303:19a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Fri, 18 Oct
 2024 22:15:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 22:15:22 +0000
Message-ID: <96e09109-1b9c-4f15-a07d-26501ed891a3@oracle.com>
Date: Sat, 19 Oct 2024 06:15:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/012: fix false alerts when SELinux is enabled
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Cc: Long An <lan@suse.com>
References: <5538c72ca7c1bf2eb0ff3dbaa73903869ba47e95.1729209889.git.wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5538c72ca7c1bf2eb0ff3dbaa73903869ba47e95.1729209889.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW5PR10MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f86aa8-787b-4cf6-847d-08dcefc25bd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEF6dmRSRTRrMTY4QmNOcG9KSU1OVmNPck5Yd3JFdW9vbVg5ejRwTFlFaXZj?=
 =?utf-8?B?Q1p2Um5lTU1uSldqYWE5WFRQRHRHZndQV0JQaFppbWxOeE9Lcmk2K2lMNGFJ?=
 =?utf-8?B?UXV4WTIyUGV0VnluK3I4WkU0aXkzbFdPUEJXQUtvK3RRMldlYXY3UlpVUS9K?=
 =?utf-8?B?Ymw0U1NVTy9pSnVLWDZjZDhWQzlFYjhiR0xHcGkrTzZtbzR0Z3VLaVRITk5s?=
 =?utf-8?B?SVByQ29lNjZXY0U1cC83YXltd05sMnh2RmcyOVlpcWF0bG42K25XTU82eDk0?=
 =?utf-8?B?RENkZitNdGhwN0o2VmlwOVJtTVprV0VaVGhUNUx1Z1ltT0xVWEl3YnBiVmlZ?=
 =?utf-8?B?WmN1Z0VSSlRjS0xJczJCNG1qaUdqODZhbytRQUJBdXVaL3BwMnZTM0NXL0Vv?=
 =?utf-8?B?eEhTeE5hdDl0MEZsWlVZRytKS1g4OHJ2djRlSStzYjdBSk1IOFdXSzdQRmph?=
 =?utf-8?B?dEZ0cDBteE5OQVM3MjRqZmtMbVAyR3NJd21mOE5VZSs2U2cxQXBmVzFwNUg3?=
 =?utf-8?B?b2JKUzZIcFN0aXV0a2ZqNldiU05jL25YRlQ2VXlCenlDU2Vrd1VDdXFDYTZ0?=
 =?utf-8?B?aVRWVFlZRlczY0NCeS9CV1FRUXllVEprNG5OYkZuTDRmazN6dVpQZXF5TDd0?=
 =?utf-8?B?amJMY2RmKzhXejM0UXJFYUVKdjlEbkFSaHFUYm1DZ2RJSWpwaFgwN09lMVFG?=
 =?utf-8?B?QnhuakhvdDZtdkwvL3gxU0kwdjVEbTJxY0RWTldocTgxQS9MMUVRbnJjN2JH?=
 =?utf-8?B?ak81YUl2eDRqZmQ0MDN4cW9EaHFld2o1MzM3Y08xcWhCQ1BrRGpWeGFVZXNH?=
 =?utf-8?B?OC9wZVJBemRCRWlpYUtGNmlqb2UrMklIQWlpOGFYU01xM1NTUTU4NCsvZXZk?=
 =?utf-8?B?emJCc3BjeGwrNnVKOWNsdEJta29NZzVJOEMwUXRNS1ovMkNIVTUvOW1nbGdk?=
 =?utf-8?B?VGl1alBZV08ycnkwM0VTZ1dzcFhMVmcxTE8yRTEySmt0aXpMNTgxajd1RFRh?=
 =?utf-8?B?RGh2S1VpT2V2NUQzMDFEVzZLMDRodit6dWxxc21VeHpkUjcrMTNDUDl4eUY1?=
 =?utf-8?B?cHpJa3VVajJxMWVDM1REcUVpMjA1TEJsMDVtQmg2d0k5VUJYNlhGQWJHUTEv?=
 =?utf-8?B?c0dHS0liTkhhaGNudjlOMVVJQnJEcHg5S2wzd2xxeVF1ZXkzWEJlYnBzTW83?=
 =?utf-8?B?SXRqOTJTWG1EZkloek0wMVBRd2czMFVScC9JYlFzZnBTSlNWSzJjNzJ4QzV1?=
 =?utf-8?B?ZXpyQjZYdG10UWFtNU9qYVU5UFN1UkYvaGpRUHNTbFI5dlp4aUFWRlFtQksv?=
 =?utf-8?B?c0hnQzR2aG1ia09vTXRYWnZZcUR1OHlwWmVQcTVQN0JXdWVNcVFVUW9KWC9E?=
 =?utf-8?B?WFJXVnFGRmVrNmtLVmRER0FTWGFCSUI1RnNwbnFCZmorZmFBL2hZcCtpUjlL?=
 =?utf-8?B?ME50UXlQNDUzUkY1Wm9vOUdyNVYrTkMrNFQ5eW91bDhsSC83OUZVRGtETDh1?=
 =?utf-8?B?bmJkYUFNc2Y0aDBKMXBZMWF6QVYzQUFMVUVmdlVYRlhPMGFOcjdBeFhXSmQ2?=
 =?utf-8?B?Z3VVNDRZUmtaQjhVYkJUV0ljSjVVSXVTOE52OWpOK1R4U2lRZEN6WEU4eE9E?=
 =?utf-8?B?UnBhUi85UTJvd052R2V4ekZ4WG9YVlMwK3h1ZWZnS3UySlNpdVk2M0ttSThv?=
 =?utf-8?B?eGo3dDRLeXRzK29LSmYwWDhLdTBFZTVkZHA5cStNWFZhZ3oxT1NlZ09kUHd2?=
 =?utf-8?Q?inUyfCi9gRwrnCze11aEMMQyY4E+WAF34cuHCqO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHFMaTlqblZmekhXekIxVFdjSHJRZVFnTmpOTTZoWFhtOHcxL3owVHlHT2dG?=
 =?utf-8?B?cXlNQ09YZUU1VGp6KzhhdDdIcktsOGpsazgycjdhZTQzNWhrOVVrQk1XR3FY?=
 =?utf-8?B?UGhpSmZOWkZxSXcxQTg4RHdRMkJOYzJ4Zyt0UWxBVlFuUGRtOHBXZVlxaWYr?=
 =?utf-8?B?N3FRVjlscVRGN0lSN0VhN24rTFpwVWJ0SUpuK3BjcHI4ZTB6UFdCMzlZTmMv?=
 =?utf-8?B?Lzc5T0J6VnVSaEVSYndGaXRzVThxdmttdk83aGlGc3ZuaTIxL24yZEVVd2J4?=
 =?utf-8?B?WGt4bnJSNnBiS2hvcXNzV0RMYU1CcU4rcVJPVVlOM29lRE9XWG82YTdBb0hw?=
 =?utf-8?B?TzhaWEJrNFZBRS9LSEo4dUZ0NldFN3pRZlFoVG5QcVFuY2hiUFcwektidzNV?=
 =?utf-8?B?VlVKb0tjL3RpVWtWR0NyMjMyZVhvbkh2Zktyc1l1RjRpUlUwWkREQm9RWjdy?=
 =?utf-8?B?RytLQXZGb1AzRWRQVVZ5RkZKS1NSVEtuVlByeW45aDFwNGF1NFIyQjYwaTFk?=
 =?utf-8?B?ZWk3TitVZGloSG1zME43bmw1MGlURWVzMDRaQk81aFpLejZIcVdMVlRpK0JP?=
 =?utf-8?B?TStKWU5RUXJBbHR4NDJ4UnlKTDlQMjRFckV2b1dkdXlKbFo4OC8zNnFXVVU4?=
 =?utf-8?B?cCtUQytmeXFWakpva012L1NVVUQxZE9Ea2FjU2twVjNmMlMzdzJ1Vmx4a2R0?=
 =?utf-8?B?c2puSEs3MEc1Z1FtOTEwN1ZYemtxb21LV2Njd2phT1VKS1lPTjJDNWI5TEFk?=
 =?utf-8?B?NkJwb2k4VzQ1QnV4RU5FRkthSmVQMDh6RWZseFVPZlQwK25OQ3RLNWdFbWwv?=
 =?utf-8?B?Y25zM005aG8vbFlvVGlscS9WZUNhRjdxbFdjd0MxOXhKaGE3TGI0d1JqRnVZ?=
 =?utf-8?B?YkdSbzEvR0NPd3E3ZlJiMXc1Zlo3UWJDNG1SUS9RaXE2UlhvOUZuc2g1eVpF?=
 =?utf-8?B?cWxKSDhudXBmNWhKUW42a0trSUIxRVV1UnA0ZEVpUzhaS3l0VHU1dENpb1VI?=
 =?utf-8?B?bGUvLzR6NkpLbnFpSjVaSFlEa3Q2S1RNbHhuaWVJclNPZjFnT0hSTExrOWZD?=
 =?utf-8?B?YWpiSmU1RUV0cmpsZ2w0YWhuTzJyZ1pzbk02SkVXVjhXMFNjcVIzWGhCNlUy?=
 =?utf-8?B?eWIxeFlzWHZOeWdmT3JsK1lueVEzTEdWK2VXQndBNHBRY0EvM1BmQ3FTeGN5?=
 =?utf-8?B?MHliZnNYNmRBeERJdFo4dTlyL1FkajUvMUpEbXFVNEw0TU9Sa0tWcXZGUXJh?=
 =?utf-8?B?Q1pPZ24wVDl4QytQdlBMa1diZHJXb2s0T1hXM1hrQVdBaGFBVUpBaXNOQTVv?=
 =?utf-8?B?TVdpZ3RVcXRxZS85VWJkZmZTcEJ0Y3lRS3U1V3VhbzM4UjRiNWgyTlBYdXJi?=
 =?utf-8?B?Q0l2OWxkVkpES2szTVNBcVNaU1FKS29zRXV1ZEwvWTdsV0hUOGtucUcvb1V0?=
 =?utf-8?B?bzdRS0NwRENpRFBjSGFTMDBxQUNIZmdFemRKRjJ4M0htZ2t6NGJyeC83Qkwx?=
 =?utf-8?B?ZDJsV3A0OVkrYWdNVnZBUndiUEdsZTJaMUIyOTArN0tSSDRtb0FkQkZSSHBN?=
 =?utf-8?B?Znc4M2RkRnh5d1R5bFhvaWswSk5PamRXVW13ajlvS2d3UkZId21LUkZPYW8r?=
 =?utf-8?B?MDdia1dBenRmVGw2RHBBT2k2MzREMlR5dWVReU5lMEJhaFpib0NMa3ZqOWZO?=
 =?utf-8?B?cWlCeDRFZnVEak5NTXFxck1tYTNVTzNjeUY5TmxaTHN0SloxUTdaSmtXV2ov?=
 =?utf-8?B?bG1nNkRYdEJONk9IRHRXM055emFRU0FxUEpqam96Ulh4QTM5VjZRN3NQQng1?=
 =?utf-8?B?SGpKYW1wOFhRMzRVekJqQXMwTkloMUdML3AwcVdoZ2JWU2xUZldLQ0JnTGRI?=
 =?utf-8?B?VS9YS3dIRzZaQ1UvUnJRTVU4eEdmV1FkWi9OcmhjeEJ6cjBHc081V0pSeXJh?=
 =?utf-8?B?ZUxkS1ZzeldFa0h3OXFyOVNMTG5MTWF0SS83UmdIZ0JIU2tLSnB6VWI4U0ho?=
 =?utf-8?B?MlFCRGczTVJoN3lVd2hOc3A5M2R6L1ZVN2Q4Zkw4MUZmVlUvcjhLVmEyZkhR?=
 =?utf-8?B?bmdMWURuN2svd3FWdWFZTGV3Z2txYXRaQTFZRVlpNkV2bFZoZFI1ZTBBWlFj?=
 =?utf-8?Q?tUIXWuhls9Zs3SSBTkoaN1Ab3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LKJ7lA/GSjCQMvT3UrFqdJ+Z9JABqEjr2Odf2aOhX73Xrqkm5hr6PC+4LI6W0eb9m382/BcxK45h7Zkm18nAZd9cD4dkZh5k7HbwPD7q3Wg6ysYZCr9UVRawZs0rmxUGiq+EJxLLT8Q+yTO5vsSBm66k/xx+opu+VCwhqzKD+2mCu/ikq8T2XehdXH41Lj9Uj/hbIkREFwL0IjXT2AqjPSdo4FteLhtzn3ab7T1VT59YSH0GO3kaXxCCaCwxKa9Sv2QcCRoIaYfCnkybziZzqHqndVM2Cn/pL5svOZgWIvCk9laKllQteTKjyIyzo6LqNl372GIbSXzHTpcGIsCR3xxc3LyErkJlYDxURUXqLUtu7I6GuC1MWljBxoG/gQPiwrou6M3btoSkYdsls774+IIK2aZVLeA35xnnFvT5FiO9qlcW9lrD+Ws71c/XeCvMvOzyNl6rLr9VzZcRp3Kmy+RYfhX5oRNMZO8eAUf6fgXMC+XhyJC9+hm8eg7KQpxqEs6/TX2qGRULDJZssCkDGbt9v6YyNvzipzesEfkuYu5iSRXn/HtHrJVk8LO9Sd1aynPQwrQutWV9H6qvGHbvmJJLLiobWdoyt9s03aJhdNM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f86aa8-787b-4cf6-847d-08dcefc25bd1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 22:15:22.7514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MXQHqpdWAEzHbuDdnWIVKUMSFlsozDVI0rPsAq6YGfEDVJL+0XxDTL2rPwOfDr+2y6jKeVie4yW1LfqSyedpww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_17,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180142
X-Proofpoint-GUID: WNHLc2bzHDH5zdpiyTKGWCHN1RqLlvPR
X-Proofpoint-ORIG-GUID: WNHLc2bzHDH5zdpiyTKGWCHN1RqLlvPR

On 18/10/24 08:04, Qu Wenruo wrote:
> [FALSE FAILURE]
> If SELinux is enabled, the test btrfs/012 will fail due to metadata
> mismatch:
> 
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 localhost 6.4.0-150600.23.25-default #1 SMP PREEMPT_DYNAMIC Tue Oct  1 10:54:01 UTC 2024 (ea7c56d)
> MKFS_OPTIONS  -- /dev/loop1
> MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/scratch
> 
> btrfs/012       - output mismatch (see /home/adam/xfstests-dev/results//btrfs/012.out.bad)
>      --- tests/btrfs/012.out	2024-10-18 10:15:29.132894338 +1030
>      +++ /home/adam/xfstests-dev/results//btrfs/012.out.bad	2024-10-18 10:25:51.834819708 +1030
>      @@ -1,6 +1,1390 @@
>       QA output created by 012
>       Checking converted btrfs against the original one:
>      -OK
>      +metadata mismatch in /p0/d2/f4
>      +metadata mismatch in /p0/d2/f5
>      +metadata and data mismatch in /p0/d2/
>      +metadata and data mismatch in /p0/
>      ...
> 
> [CAUSE]
> All the mismatch happens in the metadata, to be more especific, it's the
> security xattrs.
> 
> Although btrfs-convert properly convert all xattrs including the
> security ones, at mount time we will get new SELinux labels, causing the
> mismatch between the converted and original fs.
> 
> [FIX]
> Override SELINUX_MOUNT_OPTIONS so that we will not touch the security
> xattrs, and that should fix the false alert.
> 
> Reported-by: Long An <lan@suse.com>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1231524
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/012 | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tests/btrfs/012 b/tests/btrfs/012
> index b23e039f4c9f..5811b3b339cb 100755
> --- a/tests/btrfs/012
> +++ b/tests/btrfs/012
> @@ -32,6 +32,11 @@ _require_extra_fs ext4
>   BASENAME="stressdir"
>   BLOCK_SIZE=`_get_block_size $TEST_DIR`
>   
> +# Override the SELinux mount options, or it will lead to unexpected
> +# different security.selinux between the original and converted fs,
> +# causing false metadata mismatch during fssum.
> +export SELINUX_MOUNT_OPTIONS=""
> +

SELINUX_MOUNT_OPTIONS is set only when SELinux is enabled on the system,
so disabling SELinux will suffice.

-------
fstests/common/config:
if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
         : ${SELINUX_MOUNT_OPTIONS:="-o context=$(stat -c %C /)"}
         export SELINUX_MOUNT_OPTIONS
fi
----------

Thanks, Anand

>   # Create & populate an ext4 filesystem
>   $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
>   	_notrun "Could not create ext4 filesystem"



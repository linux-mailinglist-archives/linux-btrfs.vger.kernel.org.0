Return-Path: <linux-btrfs+bounces-9378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675C59BF967
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 23:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CBB283A97
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 22:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D21420C49C;
	Wed,  6 Nov 2024 22:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DCfSz9Kw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QfRKQE3H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944DB18FDD0
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 22:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730933017; cv=fail; b=XOKoaknyw5pZbJYdy8Qxy2PNF9ZptDmp3dd2QolKw1BzD31wUNQeUR+pv9jJa2uCoeHAdRZPkH6Zeib53D5qvK2s7ypugx5iUFAJ49hxtmzjuykQ3XAiVJk6Cfi0jyUBuaxmKn0lTp6i7Uy2ijK8c3B7MoGo3KT9w6Wh6zM10Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730933017; c=relaxed/simple;
	bh=pZU1F2xbJAMI8AA1+ui6oVLLDvz8ah8uRRzQFrb7REI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U0etjg2N0vTV9jspUN58ZDl28umFIyhn+nBhkW1NV/fxZDdSMTZ2qHUZDPYUmcTlC/FPMpbOW9NQkVp9rst6b2nW6TFtYOc/6M3tYm9FLPYYps9Bn4f01BdJD9rtjRfxzyIi1xUOgi+6jDXKlETupo3K89cRoAbtJBLrkWnSR7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DCfSz9Kw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QfRKQE3H; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6MSh7K027554;
	Wed, 6 Nov 2024 22:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=mojOiPA75vXVodPzT17IvCcpc8/Qaaylz51glqWvewc=; b=
	DCfSz9Kw0rewyc3vjhJug1RQAx955l8YGP1XS3cLbxEWuNdWYyAh0ne2+EKSvs5u
	ltrOLZY7kW0pjBOvvNWK4jvoh9Ki2tLO4gzdvOfDRpA4zajKTR2O7yb3GtoR5OQi
	xKjnxsNqH7jQtGgLwnN72k/+B314ww3E7edh97lTLExvBlmA2gbHWpCPbcEK2U3y
	cfUa4d+pOiWdHYia0P1XqGbTDMTXLPfJz/G4TWe2BXvRncw67IoaD0PUsbOvD0nN
	JC/jR4tIDAh+D0L+d3/SR1jSz/qaAIzrTnAl5o4M8rqWfJ5CVRZlkqNDgdhElepf
	h+732o7tNL7PDAWlK+0pjQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nb0ch9hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 22:43:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6LPuur005124;
	Wed, 6 Nov 2024 22:43:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p87cjxjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 22:43:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpmFJY5x/v+It5C9kMhx19yAuD9ikAQjNMm4eXA6idNIrtjU2lvg1X2D1sP6VaadToXB46EQJhyR7kj6HaMmS3ENFyqJTvtnw/FVZT4vZn/jpooKYzPiRFhZnU8Mm9EqLQKz/eUHS8PgR+W4I8Kyv2OqvTzo5C5NFt+4fbSsXpE3knkNo8WXqX478fndDrBEsG3K8874Vb48QUdjbd3V+vLbGPJZrTbzrtGZquBUxBJhy/0zWbdjkqz7YZ0hRFSp8Alnwg1x+vvb3oPX236qHTC1yDkLROVVetULhfGpW8zQ8ssDky6PDMwcZ94yoC1hpyJMzOX1i/qVRCEmyAfpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mojOiPA75vXVodPzT17IvCcpc8/Qaaylz51glqWvewc=;
 b=s99bWh69uqJwYGVmCGepSmLDeYmbUBqDkuvR372bORijFatywE8vEXsgEuPrUthz+lF9S1LFB5WxgLwlnbqhKhUGESYvw+bSsxpYQvKGJQNPxFZM/Bg5UE7H2jLYvEz1a6TLsaCFKHmflPxn1436bcwLt8tYRKzPjP0ewTKPa7nspmg9AySfiiaeJQmyOk4vUovkTvrJQxnizhImCfe9gTO7POsMequqozU4WJ4iL02QnP4R46IhaUrKGH/mQ42AhWjaIYsYk+uJgTEFnsbedgPJtqlDF6RAO//aFMEx2dM0L/tTmP31EDAW7/XuNN5NZwJAx8jVr64IYSaLYkJX0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mojOiPA75vXVodPzT17IvCcpc8/Qaaylz51glqWvewc=;
 b=QfRKQE3HLXjjguAfW/ogELeFFwj3VhKzP62c+FVb2fpHqPGIwfT2P4AgESjKL/TyvK/kj3rTaogXkswpMLmAgYEzV9o9oWzmUldAChh7ze9dnT3th+mLdYdEFQ8/Ltl6JrX8ExI6ACFzQXuk/EdQkFBTl21RXj4HOxc9E76RGio=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by SJ0PR10MB5765.namprd10.prod.outlook.com (2603:10b6:a03:3ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 22:43:28 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a6fc:c6a3:7290:5d1d]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a6fc:c6a3:7290:5d1d%4]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 22:43:28 +0000
Message-ID: <226fa1dd-8660-4478-a931-d8e4f15eeb4c@oracle.com>
Date: Thu, 7 Nov 2024 06:43:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: avoid superfluous calls to free_extent_map() in
 btrfs_encoded_read()
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
References: <20241031115210.1965033-1-maharmstone@fb.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20241031115210.1965033-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|SJ0PR10MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: e2be4e5d-bf38-4d41-3a84-08dcfeb46e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEI3MVFtcjBBVTlIVXdZSzAyWE5vZkhKZFYranlzelpuNXlIN0ZsK3M3MEtL?=
 =?utf-8?B?NzhrdEFucUttanZVeHpYVEt6eEthMHpEVVpNbEZmaTB1NWxiNEplalhaeGZn?=
 =?utf-8?B?K0NtaEFQRE9aWXZ2YzV3MzI5bXNhMThHaUp5Uk9jQ0JGSWQ1dmRLSllJVk85?=
 =?utf-8?B?UklvNGdHbUlhN0dENWIyMTN4aEtVVnNCNHdRMzRPZUtraHRJcFc3OEZ5QkhG?=
 =?utf-8?B?QzFoN05iU0NLeTRicjI4eWQyUEI3aEg1R1RpWlJ0THJZNFA0OEduOURIMk10?=
 =?utf-8?B?WklFQStGZ3pYRHNSMzNFcUVtUkdXZ1M0Z1FyNjdVQlJBYVEvUnZLYmQvdWtk?=
 =?utf-8?B?V0RDR0N0ZkFnbmc3azJJYXVzWUE1aGxkUjdRbGxrdXNpUzRJcm5yckRseUxy?=
 =?utf-8?B?Y0FkNFlDWjFibmlaTllEeWFOckFGMCtsdWltNG9FckNlcksveWZPMSs5M0g1?=
 =?utf-8?B?TlV6bFQ2RmdMMGh3Q3lLd1RRdFNLRnB3K1RFdmkxdFB3K1RqUWZIZ0d6MGVr?=
 =?utf-8?B?UGZxNDFvQUhtMlRYZjVLeWw0VTMrZlNqOStOUnU3K0VldnhjN2lTaXRrWWl3?=
 =?utf-8?B?aE9TTkRTb294RllKMDFVSldFUngwSXZ6Z2FlRzRYbHlDam9QNXJySmZGYmZh?=
 =?utf-8?B?U0k2SVlqYmpLcTF4TTlhdXRuKyt0WmxnTytxU21LSHlRL08xV3pST2cxaDBR?=
 =?utf-8?B?TjZFdERRS0xDelNMTFJVVjRGVk5CV3pxMWFsWkVDcHJheGIxMHpOL0FRUlF3?=
 =?utf-8?B?NTJOMWUwNkZzSWpGbGY4cklmVkNTeTlQWUdJTmFlNHVORGRZWkxQaTZZQW1s?=
 =?utf-8?B?RHdTaTdJMUVDdmxieXVzSDI5VVBHZWNTV1pWSit0bVNhSXlJWnVwdFBnOEdW?=
 =?utf-8?B?eFVLQm8yQkp5ZjBoSi8vWWQ4bGN4S2Y4NGNGTVBDV1NVUDFLKzdDZUY4eGZw?=
 =?utf-8?B?RXRjQ0pWU3lxdlkxeE4xZllma1pQWlN6dWZtQWN4WnR3ZmNJME4xcWdENXdm?=
 =?utf-8?B?MEhqVXdXOXpIc0pwdERHVk1KenRFaXVqOXZVTFFreEpra1FnYUR5bGVURWFp?=
 =?utf-8?B?R3dwM1BqbVlWUCtYNENhT2I5NG5SMGZGY0FNenFIcng2M0Y4NklpVmZZSUhU?=
 =?utf-8?B?SURHejVwRzJFZXJLaitlNVdPZWQ4cE83S3Y2d21wVEhjcTJrR2daYWYrWlkx?=
 =?utf-8?B?ZzAwZjlkS2JsQ0dkeUpQL1orYVhFR0lGejZRTmcwc2ZhSWZXMDZicjRXcjZO?=
 =?utf-8?B?UElHWWczU0R0Q1ZiNjVNQzdLcU1WcFUrTVBUMkx6Q0VCS1Mra2gvY0wraDZi?=
 =?utf-8?B?SE83cnh2M0ZWdGRVVWN6U1I3V1ZZVTVyeUtWMEwrMUtLNzNQTEh4RTcxTlFZ?=
 =?utf-8?B?b0hLeWNOVklJamZjMTZWeEJxN21xVU1mSDN6YjI1TCtra3pTZWU3Yk9sTGdy?=
 =?utf-8?B?ZDBkZ3dXZ1lXWGdSY2QvdUp3K1VPSUhsZncvRDgvckE1WCtFRmwvRnJxQllV?=
 =?utf-8?B?eWd3Z1NYNi83V2Z3ejBMc21WOVdNTVQrVmxzUyt4c256VHNMTE1GL0hiTUJT?=
 =?utf-8?B?R09FYlFRWWpPRTNmdmQ0ZmpoalVEd2pHVG9BaUlaMXc2eFN4d2dBTmFyengz?=
 =?utf-8?B?aVE5ekpLMmJUTGtuL1N4TVVKZlJKSUdQN0pacmNDbDd1bWRkd05uV0J4dVly?=
 =?utf-8?B?SllnK3J0MjdvTCtpR2pUQ2hkNndlVFJKd3lQZ3NjWFYzT2lOSS9ZUUdZNis4?=
 =?utf-8?Q?xNyfjMAbXw4h0Z97eLYm0WLey5MQ0XHuNE8rdVx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWtOQUNOWGVQVitERms5WkFBL2J5UERvb2FhbGM1UklpM1ZBSnJKYnF4R29s?=
 =?utf-8?B?NlRyS1lqUTg1ZUFDbmxSQXdvYWxEdDBVTGF5OU8vNmpPMmZlVmtPNTBaa2s2?=
 =?utf-8?B?cERGU1F0MmJSZ2Z5Z0FxZG92Nm9JQTVrZ0YxNGd2K3J0VXhDcFVmRVVvcjBx?=
 =?utf-8?B?RXg4TGQ3UmZwVkYvK1FEbU94UlFYR3pDdEQ1bWpSYkJCV1dTODUzOGpsWkZ4?=
 =?utf-8?B?YmM4a0xaUGM5ek1iYTB4eGNrL2xFVkVWakg4THBVUVRkUlBNMDJNMXl3bFMr?=
 =?utf-8?B?MFFUVVA3ZXpVMXdPNWZrekhUWlFwZFFOMktHRmViY1RkNExxeUFTSW9BREtJ?=
 =?utf-8?B?NWRHekRkUTBWZkpFdHAzUHlhKzg4VGxCcXhtL24zVkc1cVdXMytmQ3o1YkdL?=
 =?utf-8?B?Rmx0WUdoTjBBWkNWdS9jM0NkaE11Rm93elprY0lvcXVjNXpvMUwzTU9mQXJi?=
 =?utf-8?B?WHVtUXVZbEh2Z2I5RWliOTZOUmlQeE12TzA3K3JIU0M0YjFSZVNaZ3Y2RFF0?=
 =?utf-8?B?VXV1M0xrdWZzU1p6U01OZS8yRDlhQzRpNDExTG1BeUNnbTR0YzFrMGhsd2R4?=
 =?utf-8?B?ZVhlRFhuZ1JsampSdXRHRXR2OTV2N2Mzc2lzVHFCMzA2WURUNGZoZUttVmNY?=
 =?utf-8?B?UGJGcDFrS2MxVWozbHUvNUdRTGJPbHdJSmpDS1lVczQ1UGFsOUFDZjQvb3dr?=
 =?utf-8?B?RGgrdFNkL25na3lHQnZWS3R2dUtBKzZ4c3czekpiM3ljck91TmhoMDFNTmNY?=
 =?utf-8?B?ekh6T2o1ZGZZbXVtNEw4RTRIM1gxT0ZWazY4TkRSSlJUMXpjS1puU2wyWExS?=
 =?utf-8?B?aHhRdktMYjM3UW9COHN6QzMrTWtKaGh0eVQzWmx4WmdFQ0RGWlo2VjhzS3pl?=
 =?utf-8?B?QWtXT2dMZGZlMmJuTTlDMTE2K2ZHUU9CVUVSUC81eFFpanJPRnJmYmhXUXpB?=
 =?utf-8?B?SG9XWnAwb3dhZHhndDgvK3FJYnE2Lzk3YXZTbFdnYytVQUtsLzJ3ZXE1Nm5H?=
 =?utf-8?B?MGx3ajZsZlk3TUlNOUM0MVFlaGxDMDA5M3hQOEROV1hVdk9yR05rOGppRlEy?=
 =?utf-8?B?NUFjNHhRdnZxRTZiWnJyQ21iT3NTRHd2N2hBQTZxdjM2OGE5Y3ZSdnFhV0k0?=
 =?utf-8?B?c2N4enBSMWtBUTl1MGU1eEwrUUJRRW9aeXcveWJZMTMzUlZJNWx6dzEwZTAx?=
 =?utf-8?B?Q2paV2VXbXNIOTJkMVgwVWtiU2dOODNGelJYSThqMml4WHJVUVRqWUFTZVBV?=
 =?utf-8?B?Q0F0UERCVVdjaERCSXZ4aEJsVjFvQXFzR2pjS2JObHVOWnZ6MUwzTmZ6TGRN?=
 =?utf-8?B?T2V6TTBOSFFxSVZjelJvOGlZUGx5cU9paGg4Z1JOalcwVU5kWmE3NmZ1VGpi?=
 =?utf-8?B?MksrMTJKaENUVFVvQ3cvYkhVT0dMc2xBQ0hqalhJS1orOFV3NVFkMGxVQWQ3?=
 =?utf-8?B?YUhLbmFENjdsUS9VRzVyQjJZZkFhNWV1UGRpV0xZRE1HUytuazh2QmkvN0lQ?=
 =?utf-8?B?SVBuK0hCKzY3Q3hCeWVKeFkvZUhrWmxUUERHMFZZV01YZmFaWE9qZVAzaDFI?=
 =?utf-8?B?TXYvaC8zbkQ5ejJDUU5XODNqUlFETE01Y2d5ay9UaDRSY0o4Y3NqR3N1dEVw?=
 =?utf-8?B?WFlBTmdOT2pqdHk2Smcwb05Wclk5ekprTUxSTnh2cnFOd1creWx6NmlKbmdV?=
 =?utf-8?B?WnFkcDM2YXJxcTFBcEtSK0pJZmxTVE1aeStvQzhEdzVWazhaOWxJTGpJSXc0?=
 =?utf-8?B?SFpPL25VMTlhY01mdE5BbkhPOGNQUkJPRmZSaGJCbG95a29ZQ0NHWW5wVm1D?=
 =?utf-8?B?NEZpZTViNUNHQjQ1REttWXd4bTF2enpZSWRsaU1FYlNJV1NCYVdQRW84V2ls?=
 =?utf-8?B?U2FkQjRSaFJtWS84ZytyK29pWEtFL3lYc1hxRFRON09sSHozYk1IaWFWQXhw?=
 =?utf-8?B?NWY4UTFrMGFqbnVQL2g2OW0yNitUQjAreUhqTVFLSkdRZEVnc29lRnF3Ky9P?=
 =?utf-8?B?WWNxWWhMN2k4MkZ6Y3RmZHlXcDRSZkU0VGhhc0ZDUklxbU1tSDRkWUtEZ3hQ?=
 =?utf-8?B?bi9qWHIyWkI5bUZoVEt1NXVTaDlrVVZUM0lyNE84M2RvMUhKS3V1ZlAyTW9S?=
 =?utf-8?Q?pxAB/Zv9qouUkmLfIGJ7Gf/xZ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IYvrHUJOVbXTIlNtH4GXH4qW9O0KI2AnG+8gDuFLC6xyuKroMKSmPvFTVzzw4ZPFlINi7xu1Vt/0rRIeitO+P4OhPyZit/AdwcBrLPOuKTomm0uVaFEAZmoR7tcU9hZilYWQv4Hp0T6Ih2Bu0ucWFfdNQt3PxjAnzc7dXo0svy6gfV8jsP4F5dS++oX9EKLKJD5W9D2bao+Xinn1tFPh+yM5VRJ9Tl4Mvux7tRrEZVTB3ItCWUwLF8HKURuT1jm4WGZI2PFKxj/+JCP9I3wu/PiUUVsjQnSSIfdctQJ8VKXkCiD+MPK0QBOAQX2SPq2k1Yin6pm42hQ/h4F7qwSE0DiFiVNRuOW+3717OhP2x6rpDwmjd4XOFbLvePQk9MM7iqBPxRJdfZ7b3trK2XP0T+N5Cmdl2AqF9t6eHzrq4azJYN+CjgF5ImcdVa3RHFoH8NwfGTiUtcbXVBf2sy/SBguuhNER3VwPeeSHDawSD265IcpgbdoVbJQlM8xGw1OL/gTkV6IssnuVzIsDOU4kmfPbJzSWniJvlp1Dst48UxgMYWqq1Jk62BL35aNce+5aLzdm+DtZvmPpXFuRAXxZVHz1EJHARCssVfnqBWOnWss=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2be4e5d-bf38-4d41-3a84-08dcfeb46e5e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 22:43:28.2723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7i67JkEFtgda7XjuUsz8ROEbG90yWdTm7q5LkBYkq+3s+n+uNDywFuaRB6omYSyw9MajEV2winH6sblUc0rDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_16,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060174
X-Proofpoint-ORIG-GUID: moDEH0dXHXSXAR5NPgudFOGv65IQ-y-W
X-Proofpoint-GUID: moDEH0dXHXSXAR5NPgudFOGv65IQ-y-W




On 31/10/24 19:52, Mark Harmstone wrote:
> Change the control flow of btrfs_encoded_read() so that it doesn't call
> free_extent_map() when we know that this has already been done.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> Suggested-by: Anand Jain <anand.jain@oracle.com>

Sorry for the late rb.
Reviewed-by: Anand Jain <anand.jain@oracle.com>



> ---
>   fs/btrfs/inode.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 40f278821144..fc21e8519efe 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9324,7 +9324,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
>   		ret = btrfs_encoded_read_inline(iocb, iter, start, lockend,
>   						cached_state, extent_start,
>   						count, encoded, &unlocked);
> -		goto out_em;
> +		goto out_unlock_extent;
>   	}
>   
>   	/*
> @@ -9384,7 +9384,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
>   			ret = -EFAULT;
>   	} else {
>   		ret = -EIOCBQUEUED;
> -		goto out_em;
> +		goto out_unlock_extent;
>   	}
>   
>   out_em:



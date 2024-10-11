Return-Path: <linux-btrfs+bounces-8831-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A59199991E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 03:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0691C2434F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 01:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0565DDDA9;
	Fri, 11 Oct 2024 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZNnVyaFk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gEv48Ene"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629DD8BE5
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 01:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609677; cv=fail; b=Drm1C9XJOD/dW48+2I0+RRPg+yXWEPccSM6aIpNriNoq0qiNozm807ljqzpHingElTtCiXigEpNFrHE9pW5H+zLTMBBzSKDEO2We70zWyVlqhJ2Y6YtnY3SAVhz4wGmSYt4Ygsm/+rjvBbJ7/wQvisOfiUw/PqW1slv60wGsHOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609677; c=relaxed/simple;
	bh=XZmDyBqyx1vCY6dZfpAyP2bPMTddyauvAgz0ccM1z6E=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uRtCoAXqDOYP4vQn+EP484zvyhY/AcJ700Q5OHybCRJo0u4SGvuJWGwb4MgOXsvNcgmBoLvkIRXuRfxkXdt5Ad/SGc4jYuz4vA/j5le4RXoFMLUIx1Cp/R8rq2p95DyZUfecrwM2XY08i1buLommjjXeEr5gWeH5R+ymQGfAbu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZNnVyaFk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gEv48Ene; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AJtblb005094;
	Fri, 11 Oct 2024 01:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bQikHAnCWgJj7lRz/g9WqvLweEhC5+ZxnOF54ji9pWg=; b=
	ZNnVyaFkxVi7u7Jf/l2zHV98QUhaJZL1GgJPz3EYTQ1wWFExD6p6N2k5CbzxdrtV
	ItdcSKdF8Eh1l0WFC8Iax6L6vZbX6SuCjlWB+0P3i7Ll10uqqcDU40fiW9szGwqZ
	YxmCXvjBYKuW2mvd3fdQ9BdvEqkYiI07bupU+lUPseJiVj+xEf7P2CN42QKtzvMo
	b992i6CNYy+pQZ1S9DboLy3rvGvEGNv5nitAgR+d3W3HPz6VvLkdIezn/RupU0su
	+sQA3IHyTC+t5ZjIdsB2v1Eb9ncFkYtsFTuycup9kxZEFfkmn2lwUN/vHttiYqQO
	FqTbFhu1g2KcEa8JMUgT/A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034vcrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 01:21:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49ANUBwf017132;
	Fri, 11 Oct 2024 01:21:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwh4erb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 01:21:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVLQsvk9YqcUY8AAhdxu9yg7Uka1i5TFh4Xr64xUfP9H/AaKUCXAkTaRg82zgenQuMYMTDJKxmgN35J1FBwZc4uzNTABXU6aG7XpAc0k58Ji2vs8IcoKt4NJgfYxEIBTx+b4fSuPRp2Key57yNR+RKNIOzJ3ACFbH4pI+2z3UcgWRU1TmZe5jl7k1ZUMFJYCqMPNKSbpQAQcn7Mq63d273qeOjwH9A/1kTsO07+gioIvmIBbnmfqViToZ0gS0qTnRELyPrthDN+RX8QTZpvkD4i6/loUTThRF9gngCBBSO8JraiyM6CZmY79AkjGzynHThJH4xgjJLjFk8LYZ95JMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQikHAnCWgJj7lRz/g9WqvLweEhC5+ZxnOF54ji9pWg=;
 b=gcp7SgJyRPbAGuSPPJ3uFlOwCbSclnKAGsh08nHsCcNv9FZ3wxPWpe8YwdCzBsTd3bqO+ii/AkjVuSEsLRScRhrIVXgz3tQYHRclYCvz6h8W+uCb0ETh9/V5GiqJurJDYyNKzqZ/e/J6A+e2gu0WCBq+qu200q692fJ/NiagNpL8R/M6A6wf6sqkhHkMD1bnpNWAbSk8S6yOydq8nz7lOkmi80jg/ghGehNqsytGHtlpdEXljo0xbY5c0B1DDjd0Ms1BJgOKCshL9OXdwmogZxi7je3OsWqV6hrjM5gEaFgS7fWHAp3beFGa7b1gjbX1ejTs8ZIVEqSh7klZcGdrvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQikHAnCWgJj7lRz/g9WqvLweEhC5+ZxnOF54ji9pWg=;
 b=gEv48EneYZjc3t8elfUUYvbm11l1nCY6pue8JuXFZWeawYCCvVYcwYtoUH9y7KH5eSSEQwEZ6cBwsBnBTmQDYIW/s5jgyjH6D1SVPog5U7A2RtGuPzZW1RUtwsauhP8n42PXutYiufCiIWaOYtJ9idy/BgkhqmMQ9Xwm4jHGwbQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 01:21:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 01:21:03 +0000
Message-ID: <c2a8edc6-ccb2-43d4-9cac-51a9ee223237@oracle.com>
Date: Fri, 11 Oct 2024 09:21:02 +0800
User-Agent: Mozilla Thunderbird
From: Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH 2/3] btrfs: use the path with the lowest latency for RAID1
 reads
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, waxhead@dirtcellar.net
References: <cover.1727368214.git.anand.jain@oracle.com>
 <f284d932a61c293ac1c350ac11730b11b651300c.1727368214.git.anand.jain@oracle.com>
 <4c631f0d-1040-496f-b86d-710ad2a37a37@gmx.com>
Content-Language: en-US
In-Reply-To: <4c631f0d-1040-496f-b86d-710ad2a37a37@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB4647:EE_
X-MS-Office365-Filtering-Correlation-Id: df95f271-5a65-4cd2-1997-08dce992f93c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1k4TlI1VWMvK1EyeGJmeTRVTU1wQTAzUGdsNDhSMTJmbVlJbW1rU0NKaGhQ?=
 =?utf-8?B?cFdLRmRmTVlqYlgzekJaNWZEMUpCRXB4cW1JNDdYSzlORjhYbDgreDhtcXUz?=
 =?utf-8?B?cnNRMkRnM3VDcW1nc3AvRHV6TjBSNEtoUjdpdURLRitzN3RsdWt3Z05MTWF1?=
 =?utf-8?B?aE1XYlF5RExVS3dlWEFNVFZoc3VJaWtCc0xWMVlhRytLVnZwVkY5MGVvNWZl?=
 =?utf-8?B?WklBVHZGZ2QreU5XRDc2T3lmd2RPcGtOT3p3Z0JydkFTOUR3TzMrTjlpRWsr?=
 =?utf-8?B?QVh6SXkzWDY2OW53c3V1ZFNLcTAzTm9raEpuNmJzMERDS3htcyswcVNmR0pj?=
 =?utf-8?B?MUFVMWdHSmVQcTliWHh3a0NNaXI5VlRqQ0lISU9wcjNDaUttSXJjcWd0RzZk?=
 =?utf-8?B?UHZjVmRiNE56STFkRTV4eGhlcXBIMDQ0bGlHOVZ0NmNRbG4vcC9kbGlHWURD?=
 =?utf-8?B?WHptS2IwY2NkNWpIYWFwSE5qZlFFQitFZWo5cnZwYnpaM1hsY25BMFZqRWY0?=
 =?utf-8?B?L25TNUNiTjlPZ1B3TW14V1EwenB3QmRYVWpyTGNaeHZxcERLVkRvdzllOGJW?=
 =?utf-8?B?Qm1IM3VsMGtDOGxzcFdzM0thUE1pZ3hDemJ2N2lqeHl4U1MyYU5YS1k2K2gy?=
 =?utf-8?B?by8zNnFRY3VWWTJmUVYzUGlxY2o3N1NvUnJKOUFNd1JRYjlBcHlTRUVvb2Fv?=
 =?utf-8?B?UGZOeDBoa1NCVlVqVGtoY1lsbCt5WmNVTFNnRDQ1TktRUTNsclg2ZVdpTndN?=
 =?utf-8?B?STdZUXk5TU9yU0IyWnYzdjl5WTIwYU4xU2lRWW4xZWpvRkZRb2JCV2R1Z25y?=
 =?utf-8?B?SDZSeGNWV1dXQURpSTRDVHA3d3didHNZL0RYSS9lUjkrQnM1cDlRMklnUklN?=
 =?utf-8?B?d3YvdHhOcW1QeXdjQXVJcnVBeUp0aHNBMnFRSDd6TEM3eTBVdmVTZTJWUHdV?=
 =?utf-8?B?SXZZOUI0MWFpQ3VSV3Z5ekxjdE9kYnBhTE9YYVdQUjZ4WjFIcStZV1FkTXJ6?=
 =?utf-8?B?K0FITDJFOUxUT2NpWHJuZHA3NkRIUUZIenkzNFhvYno3VkpSdEhnMTBySG5h?=
 =?utf-8?B?TWEwejJXakJ3RWV3WmxZa2NDVVcyeEczb0lrbUZkYkNleTJhTHlLUy9MUXpN?=
 =?utf-8?B?YkRHbW50djh3U0NGQ2g0Y1dEWUsreGtFbFYvYmdHaEg0TXpTVUhNTDBIdWZo?=
 =?utf-8?B?VjF0YThBZkdxeFN0blBhemhIZHh4SUV0ZXBtOEl2U2Y2Ri95alB5UDNHejVX?=
 =?utf-8?B?R3QxUWh5SjltRHhSNlo3UVV5dVc4emN6TGFZWkNMaWxWRWt6UndZdnlScGpr?=
 =?utf-8?B?RVZXS0RFVWdnQ2I4RUxaZVdiU0pVbzRPVUJmL2JZNXkzSjVUNk5zZDU0aEsz?=
 =?utf-8?B?NmFBOWcwd1RiWUlXdFJqT0JnS0xMOXNMMjQ0VVkvUnhZNTBSMDdSa0FQRGVv?=
 =?utf-8?B?RUtYN3dBeTdxVlpzc0hiOXBHWkwzZzJsWWFBVFNUNDJkSWZRd0E0cE8rbWEz?=
 =?utf-8?B?Z0NEVXdEQTZCS2VqR3VqMG14cW41ZkxvbnlXbEdrdVBsOEl0V0tkT1p4c0Ju?=
 =?utf-8?B?ZWFmNURCK29yUE0vYnlUdVFzVmwwWHU4eDRhTzM5S3BDVm5BUVpFRElOOXhT?=
 =?utf-8?B?YmpncDZqU2w1eXpBVmpXRitSSFFzdm81MnBvSUNoWFlZSWJkK2hxOHY5UXIz?=
 =?utf-8?B?b1BVRzRwTmN2YUdVVmJ2blR6VDdQL2V1MVgwUG1WYTBLTUxsbkRQM1pBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akVTd1BBZHhrRE54YW5ld3ozemRuVWRubFNQQmh5M2wyL2RvZkhsYTJPVmwy?=
 =?utf-8?B?WFZqMkRUeVk2dFRtWFFXN0h5eDN6SlNsZmJoNkg0dVRoVVJhQXJUT3gySm9i?=
 =?utf-8?B?Mk10cDlFckU4alRhbzkvUEhndTRwY2dnaUJ1S2UzQWVybGpBdHBKdzk3U1Np?=
 =?utf-8?B?YUQxSHRnQVc5K0djOW9QK0xndmVaR1o3cWdrbzVzSFJhck02Y2hqcGNvWTZm?=
 =?utf-8?B?Q3JCWm9sTVlCQnVXRVdHeGhYQkNBSzNhMHpjcVdBS29uM29KTXJXdy9vcFV1?=
 =?utf-8?B?Z1BaaUZoOHpLZlVtRThRVlZGVi9JNnZ3NXFGdStiZzJNOTNqTTFHMEgxN08w?=
 =?utf-8?B?amR2MktPY2RzMmRFK1p1cDRkREFkSUNoTk5tZjBDZkE0bWMxNEVoNWErZ2xT?=
 =?utf-8?B?UXN0eEwyMVNUUm5rOENHVGxhR1JXWHgxa1pBNWN2TXRjemxvTktLbERkL1Z2?=
 =?utf-8?B?eGY4UkxTdDMra2xoOVRTMlRIU2hmTXhSN1EyYVByaHNaU3FCNmpUcHlkVDM2?=
 =?utf-8?B?enJMcEdVek5vTVk2YVpkcXdxejFPRlBZaW14VGV6dWZGRzRzZEdRR0MybThs?=
 =?utf-8?B?TEZCSjNYdCtkd0NmN0liT043WWpwSm1PZXNRMFJzUnZUeUMwTGJRQW5YVENi?=
 =?utf-8?B?SmY1WWhxOGpjNVZwOE1vSTJyd0dXZE5nU1QxV0ExMkN3VlJoYU5GbjRwZEVz?=
 =?utf-8?B?K0hKMEwreDRmbHdhZFR0a1Q1RjQrdGk0M3VVWm5ONnlWdUsxdHBQbnlXaHdU?=
 =?utf-8?B?Wk9yYjZrM0d2RWprR1lGWnBYV2o4NzFaT2F0TmFvZ3ExcU1OSU9BY2l5cjVG?=
 =?utf-8?B?OWVScDZhVkYwclJZOVIwMU90VWlRaWcvTUZScmJKckNqUy8rRjZod2RjQlE4?=
 =?utf-8?B?REZkVkt5Z0pscEFXaTRTZjFDWGlaa3JPMmRBYUFhd1RDT29wd0w3VmNHVEsw?=
 =?utf-8?B?VHpzbG9udko5dUJDbTJVMk4xeE9pUEJWK2VmekE0WVNGSUVrODNZWERoYVZu?=
 =?utf-8?B?RWk4bmlVRDJ3NDFLMjA1dVVPU2JVQUdIMDl2Z0MxaWx3WmNqYTRCczBueUYx?=
 =?utf-8?B?UjducDQrd21pamlzcUh1QThvUE5xQUJOSUpWeVRVUFNEQ0dnQ1pROWU2MFp2?=
 =?utf-8?B?Y3g0UDdoeEVzbmtBMzJ0d3pGdVpvQndUU2FCdlVKaTRTckh4V2lhbmVab2dH?=
 =?utf-8?B?S0Q4V3FIVUlnTTFtam82SW9oTncxSm1BTDh4Q043d0JDRkFEMFV6a05rRDJC?=
 =?utf-8?B?RzBHRVhLNGlJTzBZUzhNRDBib2lQcXpyS2FrN0VzTVl3NWxJVHJSbTlRRGs5?=
 =?utf-8?B?NW9sL0FHVW5xOUROYzl3emEwRFJydDJHRU1INnVWZUpvUjR2TW8xcndBSVgr?=
 =?utf-8?B?eHN6WGc1L0pCWmZlVDhiY2V1bU9VdlVQZHJaWkt4MjhXRFNHTm5hN2tBTEJH?=
 =?utf-8?B?Z2xZRUNnWkptSy9YeDZrb01uMnd1WE5HYStRZ2hhR1lPRXQzNWI1VWc5NG9L?=
 =?utf-8?B?ZzY3WTdsdWt2N1oyM3ZiTG84RkhmSHlheFI5enA1WlREcTBYOWlueG85Mnpm?=
 =?utf-8?B?NndJWk1xT0RxcnZ3enpNUEJCd2FmaVFkSnRDM1JKQUJ2bDliOFh3ZnpWc2po?=
 =?utf-8?B?ZUtRQWNkRExPMEZGeHRWMHZZaW00blhORExYZElCRnBoaDJodDE5NGRlb3FL?=
 =?utf-8?B?NzNpekhJbE1xRmJGZHhVc3FWM3ZzN1B4TDk2RlVldERjNkFrSnVQQ2lpRTJk?=
 =?utf-8?B?aUJHMWNJbmNnRFQ0ZGY1akc5ZzZvd0hzMGt5SmNpU1ZsMkV6Vk9ZaG5ZZXNI?=
 =?utf-8?B?UzV0QVJEUjlrbEhlK1JnUERmS2txTnBkZXRRc09BWE1jaHAwQ0tIUDEydE95?=
 =?utf-8?B?RVdqRFdCUytuMEhTbHcySlpxcFJ4bjdtakZGRXZFKzF6VHdrcUtvK29ETnQ3?=
 =?utf-8?B?YVMvQUU0cGptNGdLSFJBZTNiYlppYVptVG9hTTRPRkRyRXpNZkloM1Q3R09B?=
 =?utf-8?B?a3FZeEZpcVR0Q0IzZmlyem04UVlxSjdPZzlVSmkrTVdJbk5GRTdKbyt0cUox?=
 =?utf-8?B?aEVyWi9UMjlVQ0Y5eWZUdXUyRTZDbDk2clNMR3VQeHhhWE9hRk1MRDMrWG5y?=
 =?utf-8?Q?JHI2EBH/5fuXMAbkA2qHxOvzK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WcuW/enEVwYobeTN4ti0rHQvnl277HqkgWWG1V1u7kWcN8R3bkAasm0LA5PzYNQjubFvWUr5BxI2qkxOP+uu/lW7CDOom/db3z7BFl+HNSvjhGfqJ6pFIVIhieK8a3ZKHw0VcEgZlwQA0XK4oSEX85PwoLLtAF1NnV57PPPaKgDbMOIIPiJVWOoRK8NFykoC+aVY2vYVsmh1PzobPKxtgksGXu//oAr4ih8jHOycyCLvRLp/hy3g0BnnEXL9PYpJRsLu8PT4Ji6fIKs4TEKj4n+bp76Z3mwIjBG7KBbnApSc6VGv30TheAJxkUKMnAdQVp83mMisuVPgXFq9usZ1yX2auKvXQm5xXjXddGfsvgOXUb35JhKWdpAVsniVIRLaVi5fuEZ0c9OQ8agxiG+m74OaDmP0gZLL/xFFoSICxf5Wn5g65617gnhFJHYoX6L52QYeTBMc6ds6ndcIeVYDs4/Nhz3Osc8AAuQy3/udR3BJxWF4NMQDRB7/KAwzXQbIJhpf04wSwNLtSm9LTercPSaVRS3eDqmgLvcpfjurLc+rIa+8jdrLhI4E8fm3lOmtX6DEwt9xMEBwp+isb+i4OcUrQATR5TZjaXPi9g4+RFY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df95f271-5a65-4cd2-1997-08dce992f93c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 01:21:03.8471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: om3Hp4LQ6U5oTHfwkROqb3ACXgB5gwN9b7fjbhaleYRaRObSPoRWYm5ikGjTG83FHoDHLxY3ed+8Su9q9ER+Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_19,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110007
X-Proofpoint-GUID: -_izBU-wp1cXN9RPs7rtv5iwncfYahfL
X-Proofpoint-ORIG-GUID: -_izBU-wp1cXN9RPs7rtv5iwncfYahfL



>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index c130a27386a7..20bc62d85b3b 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -12,6 +12,9 @@
>>   #include <linux/uuid.h>
>>   #include <linux/list_sort.h>
>>   #include <linux/namei.h>
>> +#ifdef CONFIG_BTRFS_DEBUG
>> +#include <linux/part_stat.h>
>> +#endif
>>   #include "misc.h"
>>   #include "ctree.h"
>>   #include "disk-io.h"
>> @@ -5860,6 +5863,39 @@ int btrfs_is_parity_mirror(struct btrfs_fs_info 
>> *fs_info, u64 logical, u64 len)
>>   }
>>
>>   #ifdef CONFIG_BTRFS_DEBUG
>> +static int btrfs_best_stripe(struct btrfs_fs_info *fs_info,
>> +                 struct btrfs_chunk_map *map, int first,
>> +                 int num_stripe)
>> +{
>> +    u64 est_wait = 0;
> 
> Is this a typo of best_wait? Or do you mean estimated wait?
> 

It is best_wait. Fixed in v2.


>> +    int best_stripe = 0;
>> +    int index;
>> +
>> +    for (index = first; index < first + num_stripe; index++) {
>> +        u64 read_wait;
>> +        u64 avg_wait = 0;
>> +        unsigned long read_ios;
>> +        struct btrfs_device *device = map->stripes[index].dev;
>> +
>> +        read_wait = part_stat_read(device->bdev, nsecs[READ]);
>> +        read_ios = part_stat_read(device->bdev, ios[READ]);
>> +
>> +        if (read_wait && read_ios && read_wait >= read_ios)
>> +            avg_wait = div_u64(read_wait, read_ios);
>> +        else
>> +            btrfs_debug_rl(fs_info,
>> +            "devid: %llu avg_wait ZERO read_wait %llu read_ios %lu",
>> +                       device->devid, read_wait, read_ios);
> 
> I do not think we need this debug messages.
> 
> The device can have no read so far.
> 

Um. Yeah, we can remove it.

>> +
>> +        if (est_wait == 0 || est_wait > avg_wait) {
> 
> You can give @est_wait a default value of U64_MAX, so that you do not
> need to check for 0, just est_wait > avg_wait is enough.
> 

Fixed in v2.

Thanks for the review.

- Anand


> Thanks,
> Qu


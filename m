Return-Path: <linux-btrfs+bounces-8832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D60E99991F
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 03:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0311C24394
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Oct 2024 01:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8FBD299;
	Fri, 11 Oct 2024 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="URCzBSzY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YcFO9yEX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFE2EADA
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Oct 2024 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728609680; cv=fail; b=KV7talg7hJPI2TRcS6HIVviu2apSTVRyXLUDqp0LSubvbkfMpnySqzzIMaq9xxtt53RhsbbvblSs4k+08zj9VPtcn6ctFjTxOl2zGnDiU1p3vt3ER2NHMhS/FtIqHAmU5VmgQe/gQq2/HOmJlE9qz54VFe+1RI7NHUnFVGXhtkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728609680; c=relaxed/simple;
	bh=MIV4l5ADGS+6XOZNIF6zUwZBTBXVa+cyQUKQZPvBgoQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s8U1APv5Ag8YsSL1H3LJMHU8TTFgBn1THYD0gWtHXl644umhuVxwkakPtIP2hAJbXjEttVoJHuG+xdijAA6Rgp/q/ao1N4LYSY1mQ2+QRv7P6yEZUcgb2cTE4ZietYxufsN0AiapqGSJv/ce6ToLVJ+BUvb7jyfDoeTjnjZKNXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=URCzBSzY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YcFO9yEX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AJtaZ0005091;
	Fri, 11 Oct 2024 01:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UeqPh/ibH/8AafiYeQRV6HV9zs1nHJHzkZQgrusTQqs=; b=
	URCzBSzYNAXO7rYVIH/DNQyOhuZ4Sx1eyCW+KPjmX47/YIBtu5+qGvypyl1xZf9l
	A7mrQqM+pxtWc9BT2NvX30p920hZDxAz6HS6Iixxw2tk0OmNGI4bcxmhsi/1lg1I
	cG7EMjtJ/b3JOX/JnB90nZjGTIcCCkmukynKRYuns+iZ9gt3J5rzPjCh2hd8de7P
	5h99EXeeu9Wi+hXciyhAXpSM1JfuM/bOfq0MxcCyXLolN2OH+1u2UWfM5fUMww53
	9OBSKqoNS/9slqoqg62FiTgXS1svxynQBvlpSUatSrOx/DVkwYyP1a5trNjxnIQO
	lyHm9Ym7jSO9Ux7wV5Qldg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034vcrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 01:21:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49ANYPEU034317;
	Fri, 11 Oct 2024 01:21:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwasdbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 01:21:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEJg97qG/hQHD4QBneIIp4dFekZb84b9x8mrq+6x8reba21rs+DwEgdYSGoVimCkpdHdf5jckQJLLZ2XNNCq7ORyO+tdm9wEJn55NU1lEooIOyhKn4eyYMHABK6LX8Y9Ilr74zgP6/uBf0ocaSeakG8m4uRoSGuK4fH80r2RGDcqDQyNkzl7Ar6BQZsKmo0aJg2BWxfwVD117XHJCno+Mam4/Dw3+VUl+fwwl71bOtW/7/NCU1zabbQjN3XleeLgcbOE5g965jXWmAVbk1/geN52iSPbr6cvJAHJecOXoEcFN9qO3G0TdDb++XbQhO4VINgrRJF1ys1PXg9qRbnpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UeqPh/ibH/8AafiYeQRV6HV9zs1nHJHzkZQgrusTQqs=;
 b=B7yZGoREJFtcKs2/7KYTR4r2+MIo0Dh33ERqIdicGTEr95KuauY4TPLqlidvIzBMLble3HEobFdfYkq9sX79mmt2ROIe6+rYMtTMNRLkIUd5gX5/1AER+Z4k43c6H3LsY4REAuzCe3s67lYKE9UPWsHhYL7I+NlcTzyTZQyUoGFN271X27+uSMKhjTFWUy7eNSDfI12VnjTtHkXcBtDkTcDDU0qBToeV9Ou1jiLRkra2WV+eQLUOKpjM/vbVMUJH5F4pAgIT/OCN1+a89oz+yBBonEI/vZDj3OST99k7awHKG8nSIdXgBD53kHCew9T6xnoz0xRM19uXppEqGDSMfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UeqPh/ibH/8AafiYeQRV6HV9zs1nHJHzkZQgrusTQqs=;
 b=YcFO9yEXyM5AnIkN54F6DG6b/OmxzdqO1R1fu03fdRNaClvPs4rkUcxzsiEZ2UikfMVvetmWi31BTWidh0RqNMeKhq5Jkh79w8vi572VXoEsG8x26stQ2vaUXM0BNfMl8VRW4TKbzlUGbgJgsCxoxHzQNuBYcSyhSkuZQO9miqI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Fri, 11 Oct
 2024 01:21:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 01:21:07 +0000
Message-ID: <b3efd54e-b19e-4eed-a353-a5135390584f@oracle.com>
Date: Fri, 11 Oct 2024 09:21:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: introduce RAID1 round-robin read balancing
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc: dsterba@suse.com, waxhead@dirtcellar.net
References: <cover.1727368214.git.anand.jain@oracle.com>
 <63676f15fe9b1ca6c10eb9021829b4666db6d021.1727368214.git.anand.jain@oracle.com>
 <7cf92eb7-98ad-4968-bbe8-2fa0c35f1e9c@gmx.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <7cf92eb7-98ad-4968-bbe8-2fa0c35f1e9c@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-MS-Office365-Filtering-Correlation-Id: ed48bde7-da6f-4e87-fdc1-08dce992fb3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUkyOXRRR1dzMVkyV094WGpjUTZLNHhDY0ZpcHFiaGRVeHZDalliSGphcVJk?=
 =?utf-8?B?Z05hcWZCeStHN3NlSXVsMGRhenVpTmNsNWJROVBOTy9oVlQybHl0a25ORkpK?=
 =?utf-8?B?bGUwcEM5bVlnMmp5TmhoOFBybENYUnpmTTB5Ulp4MmRGdndyK0l5NHQ5ZURr?=
 =?utf-8?B?eXJYeG54MEs3YUpVdXFUeDRBSVVnT0dydHJqUmtWQW56TlY2ckY2dmtGWDc1?=
 =?utf-8?B?OUs2bDlpcGxmTXBiVUJQSEpkbTdnT25XWkdBZ2JldW1iaXJrL0NNZlVJeHc3?=
 =?utf-8?B?c0laaUpsQkVOTmYyRzgveUp4UGE0RHV6Qm1ocC9wUllJelRjMkNINHZqZjVx?=
 =?utf-8?B?YWx3OFIrUzZVVmpLcWY1YkluU1cwT1AyQXNsK1dUSTJKbUp2MVBVK090WnhC?=
 =?utf-8?B?QmFyb2NTazhLUnNwenNZaEZrKzJpQi9ZVWxHd2tzaWRxZHdUZHpueG1sd2Fp?=
 =?utf-8?B?bHhLRDJxakhTMWFHMG9DZ1lhUHNySzJQWitpOUFIMjE5Wlc1Uy8zT2VtNXhG?=
 =?utf-8?B?ZnJmdld1NlNQS2FxbVU1bmpVTThlMmhiOWJ5TDI2cHpEOFZ0eFhRdmFhSlA5?=
 =?utf-8?B?b3dWdlhzVnpTUXFtZE9qRGVrakl6OUN5Y056Z3czbGtiK05sdHRxQWFiaUJ2?=
 =?utf-8?B?OWo2b3FWcktjRGJ1ZmxFemd2UVJRY0JnNjh1N1NOZzZzT1pyYmxRSVQ3Z29H?=
 =?utf-8?B?ZUpNaUlwd2ZVR1d1R3hXbmNnZGZRZkpiSjZFWHdVdkNYbmg0OUVzSUMvQjVO?=
 =?utf-8?B?dHJ3dFhVQUZENDczSGVCN0puZW1wUTNXcjhwQTNmUXRiWHR4Zm5PcTBFQ1hm?=
 =?utf-8?B?K1J2L2hrbU0wU2NjZlA3Z0tpcFVRZHBTTFcyUnlEbGZFSGdNcWRneUdxNmpD?=
 =?utf-8?B?Qk9lWGsxaklaak41OG9UUkk5T1R6TUxYRzd3Wm5COEdPK2VKYk5uV01oQ3Q4?=
 =?utf-8?B?N01NcVNtTUJVQ1BCR2k5cUNjL3hVVmVkcStJTUZuMHUvMW1KS2hZK1FtV0RE?=
 =?utf-8?B?OW84TXozbmVmeWlEREVtRmhTWXdXcmF6WlhjR1B0aW1ZbDNFc1VyeDZGS3l6?=
 =?utf-8?B?ZkRzbFBEYkZkNW56Tk1iWE5nUmtick1uUUgrUUhzbzZubi9icmVpNTBSSS8v?=
 =?utf-8?B?enZmbldkY2tyQXVDTTNudUR2eThaeFU5c0Vhckx2R1J1VjVkN1FvUW0vYzZk?=
 =?utf-8?B?U3QxMU1ldDJoZUltcDFybnl6andNS1dKVzFUY2pkL3VUSmJXb3BZcmNueDN2?=
 =?utf-8?B?Qi9FMFVhSm9TL1Bna1lYdWM1SEg4R2N3NFptTEVwS2xJRnc1MS8vbzdNN01N?=
 =?utf-8?B?ZUk0NUU0WFM0QTFyeWlxbDZEY09ZK2hnL0pXSy9mUmR5Q0R4Z0xGdU44c0ta?=
 =?utf-8?B?R3crMVR1TWNNc1NjUWx4Vk8xYkxycERBS3ZzcVBaWmRuK01kYWpqeE10aU8r?=
 =?utf-8?B?T3ptU1crcHN4RXZWRG1rd1V3UmdhT1V6TWVHY044SGtrclBoYVM5T2ppWnd1?=
 =?utf-8?B?VXp2TXV0RDVsUE1HVGZ3WS8rVVVLcXZJbVdBbVJ1eTRxZzl4QXZ6aXpGaVhv?=
 =?utf-8?B?Ti81QmlGWktKU2pPV3hHVjJTdG1aNmNKbE1tR3QwN2VFbDQ2QmkwMThmbmZt?=
 =?utf-8?B?UDF2WkE1OEd0SWsxQ3RpZDFOb0ZYc3RwYnNEdlFCTlZOaTU4Q05FdjBFTFhL?=
 =?utf-8?B?cUl5dE5JYmU3WGxqUklwNjBwUUREY1ZRNUNKN1dGVTRNdDJyeGphV3N3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1pSZGprb1RBZmMzU0tBU0RRS3c0QzNlUGxmNDZhNVlnYjJxNHhQekJWdmI0?=
 =?utf-8?B?Q3F6Q2N5NDY5MFNUVUVOdEljTXhNWFYyaFdMTGlZYjVWUDl1VjNGajRRTU9M?=
 =?utf-8?B?dG5oU1FST3dLNXhrWDhUTzN5QWpvcnR4K1cwWUl6RHRWNFkrTkx2NENJVC9a?=
 =?utf-8?B?aEFtelgvSmtlRUd5OUh6TWRyTno0Rlk5RzR1UDhzbmlPZHFVV01ISjYzZCtt?=
 =?utf-8?B?cWxVR0R1YmRkY3VIdG9rTWVSRkhZYUFvcHVNZlBRZU03bHVFaGQ0RHpwbTRT?=
 =?utf-8?B?NTcwTEpETkUzdmI5V2pxSjZWSFg1aTF3dDV0ejcrYWkyd2hZaGtXeVNma3RV?=
 =?utf-8?B?a212QnMzMGpHV3FCU05KbmJBM0R2L2Jxd2xoMmlPOVVvV290bUFjR1RIamo1?=
 =?utf-8?B?YmpTK3dObXgwRUphNGs0eHExaStJbzBZd0RjYzN0QUpCYzk5TkkxVGJDVXpY?=
 =?utf-8?B?ZXpoajdqNlYwT3NHanBObHY3S3R3cWtpbzBqTWpJeEhtdWJ1RXZLTkg2TlEz?=
 =?utf-8?B?b3VOMG5QZ3NLT29RSTJUejRrMkFJaWtaaXNvakEvUlU4MDU3YTNSMEdwakNq?=
 =?utf-8?B?OVpvRTl0VWVOdVlpNGh6djhxQTkwVUt1UXBhWW1iWDQ3WGpxcHhMcmw3UUNK?=
 =?utf-8?B?YzNPRWZVVjFNL2c4YWNIaTY0b2ZSVkJsNEJpSUpkbS8yZjcwK1FoQ2tpRG02?=
 =?utf-8?B?d093WHpvMzlYOGJLc2hpMmJLVmZ5dVFXY0piUE1yVllaZmF0bWFvQXk3ZXUr?=
 =?utf-8?B?VjErOGZITjd2Q3kyNEovWVIzdWoxZ3c0clRuVklndXo2TXJnZTdpL0JIS3pL?=
 =?utf-8?B?MGFKUEhZNVU3N0JlbDREdFVEREZhUFNHdXM0Zk85bk5EczQ1YjZrZGk1Yk5n?=
 =?utf-8?B?KzFSdnhmNXFEaFd4czZta2Ric0lzbHF2TWJoZUwyOUhlN1VsY0dQTWg1Uk4r?=
 =?utf-8?B?OUNsR1h2WVNEUTVuK0Z0RVBiQURwUDZoWFpUYTFMRmtmNXdENFpVT3RmMW5H?=
 =?utf-8?B?azhiMnJSUVVKaG53NHVxblk1cjBhbFkvUkpSaEMzZGduWHJoczkyZjlqQzNh?=
 =?utf-8?B?VVA0NUxKTWptbDIxaWVEV2RrU1ZINDRMSzFUWW9uVDBnSHVpVVhBZkN5czRL?=
 =?utf-8?B?SEVKUzVaelhOUE93NEYxT3ptSm52SWJNeGtReXlXRWFhczRFN2QwYjNZSmli?=
 =?utf-8?B?QkxEUkJTZzdPSmFURDlpZ1ZsMzR6THlBUUh3aGpiMGlNOVlPcitpejcyeVE1?=
 =?utf-8?B?enczb3dSN3Z1Qi9Udnp6SW5vYmp0K0Z2NjVzV1AraklyUytVV2lEVFdQa2ov?=
 =?utf-8?B?OVBPOXBDazlBcHh3ZUZDTUg1MmRMaXc3SzliVFNOdG1Fa0E5VFkyb2lVdzNy?=
 =?utf-8?B?YVB0b3g1QkN6QkNRZnI0Yld6VldWYTM0ZUowaWRFcE1NZUx2UGQwM21jcnJh?=
 =?utf-8?B?bjRxTUk0cGtYSUJ6VXpMY0hkMHlJRGRnVDVIZlE3OWc2MzBBSzlZdE9JNnpt?=
 =?utf-8?B?b2twSTBNL2MxblRiQ1ljNWlFVytZTzdVaVBKZ0tWdGJPa1RoYm1USWpaUFI2?=
 =?utf-8?B?M1gzYWJqbDFUZCt5RW5XcTg4UHNjNVY1WjdiN2EraVV4YTQ5SzZjLysxZ3pt?=
 =?utf-8?B?UVJyV2NUUFlPWEp0aW9VYjI0WnRMTVJUOFVIVDl5bWVKUzh5aUV5N2g0Nm9Q?=
 =?utf-8?B?QURMKzN5RWR5RVUyTjE2TXpxR2pTUGdQVklQR09nV0V0SmVmd004aG9RSmZT?=
 =?utf-8?B?NHViT0VuOUFpc0srOVB1U3hSTmcwMmFZTytEY2pEOGRjbWhoSEdBZmZxQk1F?=
 =?utf-8?B?K1h0cHNVZnpnN0xQVzE5RXNHdDA1U214aXlxa0tWR240c2dlbVlVWk85S0JP?=
 =?utf-8?B?WURSeVlORWNBRjFuc0JCdUJiaFRBK3ovQ25CbGREa29FRTB1RkdmV05BUVd3?=
 =?utf-8?B?SXk3RVZEbDRlVHgyeGhFeENndUZjODJGNUlIbHhWYkJUdmhXVXpjbFh1a0VE?=
 =?utf-8?B?UDNibEZaQUZvYUtFSnQrb0tMQ0NkOTBkNWpKUHVDUitVOHZTMm9tbmJ2dlMr?=
 =?utf-8?B?WVg3Q2FDQmJqWkVDRnk1cjU0MnR3c1BOeEpDcExUN0VlalBaSHJqNjRPaTV1?=
 =?utf-8?Q?wfGZKTAE61Lfyfk6hbULHO9jJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FCjnO89LNfD9g/U7WC5UA3d1MxLbIAEpT2FUQx7Lrgs6fODO0dnGAwF4EhxUUrY+Y60bazFsNS8bxhNalwhzAsBbtFChV+85ZmVA8QeqnbDusisVT/V92r1SvTU90olP/sOUMrlJWpqS4GlDoxFN7CmGFgcnw5kUc3Bqq4UDa7famhHHgiVHdDsXCykpxMkN4IUKgkhmRdZNg7QXBjTRdWdJbbCX84ETv+ULU7bhNCh9Ft8H1HQ7QeJ1aTeD66BiUpFQakbqkum9aILUjfSOfkUB1Lqd/tsRY4NjbMsuLxxPRYiHGqW+YCmYPxUAMl4HXdekDeDKYyR4a42zBK2vgHj88rXZJPkaCGs3cmchakuI8iaf9eUJgy/wDMy/NUDkP9W2mGtVA5KqrY+t4v1YMfy94nCQs6LZPbbV8SBZ2wgVFbrJOMeM1oXSyK4N2dTv397WYCI//q0FthKKwikf8a0QHDJAzbsC0JZ10oScTadNqNvZmRiaCf5kDQTeARsO7awjcklUyu4+ZWB3+bvl3+Suiqm7ohZnBHwXI8/JMK8kOliPGCKjXKlWB28P5WUsnwU9/sE2UUBt997mcmTjEaGeTXuE1B5bg3/U7JLGY5w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed48bde7-da6f-4e87-fdc1-08dce992fb3c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 01:21:07.2838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTZESXlGwqukWSArPUGWmXRi8Xx9bHVqotpWcRXfWMFUwLd0CnnbJPotw4i0KsDD4oUM8j6c9UtCu7h+ENEvbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_19,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=959 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110007
X-Proofpoint-GUID: WDGXNIBOgICUj4LVCDV_ZmwG-H9JIe0A
X-Proofpoint-ORIG-GUID: WDGXNIBOgICUj4LVCDV_ZmwG-H9JIe0A


>> +#ifdef CONFIG_BTRFS_DEBUG
> 
> It would be much better to utilize CONFIG_BTRFS_EXPERIMENTAL.
> CONFIG_BTRFS_DEBUG is now for pure debug purposes.

Yes, I noticed the recent patch that changed that.
Fixed in v2.

Thanks, Anand



Return-Path: <linux-btrfs+bounces-15485-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C1B02B0C
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Jul 2025 15:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FF77B8A70
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Jul 2025 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D776B27874A;
	Sat, 12 Jul 2025 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ra+8+K79";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ceRgb4SF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524EC2FB2;
	Sat, 12 Jul 2025 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752328407; cv=fail; b=rZ9ddtfMdY6p3zGhdaIfuPIBcqA+G1TdTgNoip+j5LwgYNch1W7HStnO48oNaP2VniDbRA+JaZqB8GyVvkpL3mfW4YgzUS17A7d+xvawjLTY2Ms1cLpmgsxLtXw9L1NIkGdt1AZ294Pe4sA8hHUMg7/6bsiNo4Vr5SZzQF+oUuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752328407; c=relaxed/simple;
	bh=Y0roWBKOyVK/5WQm5WE71j5hxvNE4qAPhkrp4+W+vJI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PjBhVErQxnR+a0qiih7qKtS6mSVjhDopN9g6ii/fhfp1a7WhvGnx9YArc13vDfku1wwdzYVC/1900HlVnOqIfYwHKhpHO4VGNDj9As6IBki5OJYZHPsQ3EoFaWb9py3EeQP3sY7DIZxem/l8x2f/SpA/1uU+HjEFvmWTal3bK+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ra+8+K79; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ceRgb4SF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56CC6f18009804;
	Sat, 12 Jul 2025 13:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JJ3efJyJKcFsJ698l7AAD3fN7QBKha8fs1s3u4rrVKI=; b=
	Ra+8+K79RtXdJzv9McCodk7Oj3iVlaEzDDBVzSwaSJrbT1DsWKyQxv0TrQmrOOrk
	AnrxzjHPMMIE802xg3nI/4+JSVPzogkci2I8FG9U1lohZKBvdZ3cY+Mbj2wRooGO
	tfSnjj4lYCgh+R2Chnvosqj41Hiv2QzPgxx5xIWFVlSGnlyltjDigY+9Q5esLcvi
	gdutYLBqR8HdPpJ5cEL+T2FVnlUp+SOMgYj5OrlKslM4BN9gjGJcC/Vg12rNTPkA
	WZMEgyKW319PJzFCtQtQKJnqi9A79Uhbo5xgPKjE2Pgo3i3x0eHqF4lJuzOibT+L
	nuQHYPwIFS+GV1pZsNKQyw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqhxw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Jul 2025 13:53:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56CA4GUN024100;
	Sat, 12 Jul 2025 13:53:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5748td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Jul 2025 13:53:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okIiRf4qEA4+DLVZbkF4BkxYaUL/2BSPS+FZUv71XwzWtZ8xLdum6pgcpOMaIVZIpxfbKAoDaA3qipFEROhqPf55X6XMHs3lcIT1wGmHkIGFH+lmSwmtCVrjgZ6W/z/f91qNY2WbqjS96Qgnby+BmcVMHMwYK2IfbcXIk0ejxGP9jmN3pzQQeKLQSeau4Gvya43wfCWO7NHXezA1lhUHhKtiSKzi8/hv7Bi5CZ/UaTBY41EpolKgyJBnnsi6+TUAaUtTgGgALm+U8QzQ7dgwOQnM6hA9u4e+yUGwZNZOqsF+H4kpQVRoF9mDjJmVDUbW20fhAlIbgWdj8mkGkcw/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJ3efJyJKcFsJ698l7AAD3fN7QBKha8fs1s3u4rrVKI=;
 b=I0xM/kNeg97mDeH2BYMuBBiGzXDSOTUqTwxv8uX3H6an3kpT/dAJ3SBWSZhpQujHAAbjeIHCur51IC5zZIzbmFG8NUvav9FmtRnrCbl9k3np71s6tvII7SEbrDbexCJxXAXNSTm2UaJGvqTQDS1f522bKkdUDd5OgYCo0DsRpkZ9LLSgVuGhLM/dOikzwi67qD/xr614+obLNLkNtXoFhQxZ0bOCG7oDAD9cw/iiQi460ry9ugQLSjNNgC77ksOzKrueI7jfZK0MomazQ/XR8XQlw3AZoQI3MZ5ydCZN8JS9trXPDEwA7KpxPxsJz31RxPJ7LhkfguWz3Cgp0S8Vtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ3efJyJKcFsJ698l7AAD3fN7QBKha8fs1s3u4rrVKI=;
 b=ceRgb4SF9ZTE/U8EsJUnFPyUDQAR7VADGK1SZPfhfn1BrEpfBh+OtUM1N5P/2INNhxCx/drZ1hv/aJmlgUCbT9ks8UXfRdsyUvhB0k/Yz8JZ4BKCDpCPG+zao7mp6n6z4PpX+VJtBiTuXkbeyIEYx4f0Kc3CVX6TI5BhR0X9xCo=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 PH8PR10MB6525.namprd10.prod.outlook.com (2603:10b6:510:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.30; Sat, 12 Jul
 2025 13:52:48 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%5]) with mapi id 15.20.8922.023; Sat, 12 Jul 2025
 13:52:47 +0000
Message-ID: <5275455d-3cc8-430f-90e4-533e6572ec97@oracle.com>
Date: Sat, 12 Jul 2025 21:52:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: btrfs/237: skip test on devices with conventional
 zones
Content-Language: en-GB
To: Johannes Thumshirn <jth@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250626131833.79638-1-jth@kernel.org>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20250626131833.79638-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::18) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|PH8PR10MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: e0f9c4f2-d1b2-4425-7dcf-08ddc14b6241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0o2Yml2Wk1JUktjNUFmQWZHRlRwbzRLa3gyekFlMFQ1WU9La2x3VmtkZ3p5?=
 =?utf-8?B?UlZoVmd0a1VPbFRCWE9ZbTVoRzZBM2RqcVhjTDc5ZFBVczFMaXNlS1VUOXQ0?=
 =?utf-8?B?cUJST3ZqOVo0Tm9GMG1NZ2ZYZjJsZ2FnWWRTc211QlFyTmZlUGNackhkN2Vk?=
 =?utf-8?B?cnhpY2N4b2RpNFkyaG5yV1lqa1drUGdpazJ4MmtVeDZISllTd1hCRHp4R2RZ?=
 =?utf-8?B?NWhPREQzUTNCRnRRRmdLQlVhYm43QTc5R2x2c2xHUFVGQU5tQUFIUmJnY2pM?=
 =?utf-8?B?RVlVcFVrYVUwbXFHTUYwVEdPWTIrMHRkNm9Ca0dvcWYySGRBZG1XWE5uM28r?=
 =?utf-8?B?L3YyT2d0aURMU3RBazUyRVVwSHFhSzB5NUNFTmZTaFpMN2JmbDNBQmpFcGcv?=
 =?utf-8?B?WjhmU0lxWDVQbElkQThHZTlBRVVRTHpIUGovWHoySHR3NkdyK3QyUzRBd1RC?=
 =?utf-8?B?dmhTcDNQenRSSEhGTEdEa2JlT290ZWVKNEhwd05CQVgxK2kyWXdGYXJMUnpl?=
 =?utf-8?B?S2hYRzhRMi9MZk9TK2o5a2xiV0c4ci9UV0lNbjZ3aWV5MUpXUFVNNkF4VWlR?=
 =?utf-8?B?OXJVc3RlRlpWakdJZk80alJ5aEs4elp3VG45amVPVE8vVDlsWDU5Vkt3VzY2?=
 =?utf-8?B?eVlhWCtiVmtRelpDNmdYUDRXdGJDZlJKQXBSUXl0akZEczF5ZVBSdUdINE1s?=
 =?utf-8?B?bmdRNHBzU09oczZ4NzJqY0U3UUVZRTMxcDhja3VNSFdOVFJwdTg1Wlc3SHd5?=
 =?utf-8?B?bk1KYUs0eGZ5S1RBbEdHVFhrMW0zVXN5TlpjVmtIZ0FvVGxqWVRHQ2lDVGU1?=
 =?utf-8?B?SmZpQW5KanZUaDIrTUIvRUtZVUtNQkc5WitDT2JzSzJzTG5pWk1KWlM5ZTNG?=
 =?utf-8?B?MzNHdStNbFRNNmloNk5SM2loK2paMFJLWWxiY2NTc3I4UzZCQURRK3NjY1V6?=
 =?utf-8?B?UmFNK2VVQi9EUmVrSDIwZUYvOGdlUmErTDRYY012T2JneVpIWS8xbXZtcUZZ?=
 =?utf-8?B?WUQrOGZEczhEam9hTEVaQWphSi83YkltUEp0ZUhwUUhxNkxTWFZsL3FJNU5N?=
 =?utf-8?B?S0tNSTQzYjJtVGpDTktaSHlrOG1ZZWlhK2xtZGF3SHdsdHVNelJoRVlPQ3Ba?=
 =?utf-8?B?d1pzT3NYSWNlenhWQkxJZld2ems2d0VQRkw5RjFrbDRMVXJxNitQdHMvV21p?=
 =?utf-8?B?bUdlN1FvYy91bHlZOURlVVROaXhiSVhKUHdDTWtwZkkzN1AwZjNJT3pITVg3?=
 =?utf-8?B?ZEMxUy9PZmVCbkNoTUxZdERzaEF4dlgvR2MxMjF3SGRhMmpCeE96SCs0M1RE?=
 =?utf-8?B?N2ExcVFaQmZNb0VLSTNyWEJmaEE4US9TQWdicEgxWjEzQUFaU1gyRDZ6Rm9o?=
 =?utf-8?B?Mi8xZElkQXJmbmpHN1B0aDlqNE96REtjMWxFTUZ4cEJMTm9wdjBFeThKenFw?=
 =?utf-8?B?eFl5T3NKTlUyQStSMEtuVS91TSt6eDhld2RUNW5PaXNCdTR6OFQ2VW8vM0tB?=
 =?utf-8?B?T0lHY2hkcG01ZHhNS1h5djFENVdmdUhjb0VSM2dJSDdPNEMyNFJuYkF4aHVy?=
 =?utf-8?B?aEVTNDA5ME5XLzdZVjFERmM1R1dEMWFpTEFPMHFTUEdGb29jOTNnejlxcjVp?=
 =?utf-8?B?ME54OW1RNCtIN3REbXB5YnZpYUNpWURiM2MzaFRNQVcrd1dBRXcyTTJlQ0pu?=
 =?utf-8?B?R2NGR3hwcktZOFhRbVgyZktZTm5nNDU3Z1daOHRpZWVXY0t5djdodTg5S0ZS?=
 =?utf-8?B?blpvK0ZwQWlISE4wdjVCb0JQL2NYYkt5WGtNRnExUDhRNW11aHM3YnhWbk9j?=
 =?utf-8?B?SlR5aE5FTlMra01LZmduRGxoMW5sMFRRbWphaUNTY3JnQjhJYkJFa1B4SkUv?=
 =?utf-8?B?aHljNEhRRzdrOGg4WmJEUGFlMDh6NHRnM2Z1Y3d5ZVcyZlRxbWp2OFBrM0hv?=
 =?utf-8?Q?VLVCOekQNu4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzBzZU5wZElzYXZ1Uk9ZbW5VMDVIVm5uMjY2QlhJcWZDTHpiM1IxR3dKcjE3?=
 =?utf-8?B?UnVqWHhvQjIxSGpZOUEyamIvTGY2dWhCK1ZMSFFCS0ZWdFBzalBGTkQ5Y2hk?=
 =?utf-8?B?MTc1SE5jSGRBWVZrUjFwNGczUTdiRnZsTWs2VzkzV1hpNVV1S2k2QXlEcWFM?=
 =?utf-8?B?MWd3NFU3SUdsOWpwK1pIZ2FiSkZWQmFTM29oemhEa0k0QjJZT1d6STNRdVN4?=
 =?utf-8?B?eVFXdmlGNkxvYjNrUUlyS0JzNVREUytRd0ZpSndWOXlSSWl5UjRMYmFWYWor?=
 =?utf-8?B?WEZsc2FxTFNGRTFUMk9aWWZZQUo5WXc2ZEFDQWRzRmhCTTR3V2FkZ0VhN2sz?=
 =?utf-8?B?c1RBQ0J6bVdOT2lhc090NWtjVlhKRnZJcFJGT3dOM2U1SVZoQlJudjVlUjNo?=
 =?utf-8?B?RTc1ekI5andIQlBnTG1qSVpIWmJkN1B5ZWlCSnA5QVMwLyt5OCtHT0M0dzhH?=
 =?utf-8?B?c3BQWUcrY2ZSSVY0bGdDVWNXM21yL2xoNSt3VGtTQVU4bmtXRUl3cFprUkcw?=
 =?utf-8?B?ZUdjUUFoSzRDTnVnNlFZY2U3WW15L1B3WHYvQ3RCWk5hMngvemV3TlpoMWJX?=
 =?utf-8?B?MkNyWWNLMkE4Y0o4bXVYd01TM3J3NmpWL2ZXQnNFUXp6bTlkWmVZQ0pEcG9F?=
 =?utf-8?B?eW1XSUlUa1FNRXVMRlVlamJuZVZqSUV0OG1TVnVXaDlSYnd0RmdjN2cvcVBx?=
 =?utf-8?B?SVNCTzJGbUhYWWdCZ1J1MEVBNHljc0w5dzVQTzBGakFIemRXR21uY0dUVzhu?=
 =?utf-8?B?eWUvblllRlNwWDMwVDhIWU1lcUUyN2ZicGZTMm1ZQlNoTTc1NFN6dFBVVHVL?=
 =?utf-8?B?RkV1bjdtTEZ6b1lwdktRdXF3NWVhcnN0NFdQTVZ0QlZtblFjWUkrc1VVUk8r?=
 =?utf-8?B?WW5UVHM2bVEyc0VIeXZJbjJ5QVpyMkM4ZjJBcVZjYkNDb1NDWUExdzJOdGk4?=
 =?utf-8?B?NEtCRjllMzdMSUp4bE9TWExhQXZTS2Jocmt0UEdzZlFSei9nZ3NxdWM0Nkxh?=
 =?utf-8?B?c3pnZExTTXdXTDk1TUROOUhESW56U3pyeCtTQkpVYS9maDNjM3FNZE5XMkRW?=
 =?utf-8?B?Z2MwUllGSEZ1WUkySEJMV2RnMHFWNmtzQzRzcFFSL0hDOXk2N1E2YmFaR2w3?=
 =?utf-8?B?K1dsdkMrVXNtUXJVYm1Od2NmQjlOalNHb1c4SVhUdmszWWk4TDVIS291Wnlw?=
 =?utf-8?B?VnlDb3lPb3BFdmVBNjNGNDdqYzdSQVZyU3pGVFIyTTl4anVtSW16dWFTTEFO?=
 =?utf-8?B?OHZSYVdMZlFpRkxoZkIxY2ozWGE5d2d6TzNjNjRwd1hoSmk3Y1YwajBjQUpp?=
 =?utf-8?B?Sk5SRWFDajlHZHd0WGtkdm9QQTFSWEtKUEVuZThFUlZXRmRDVjNuWUxmN0pB?=
 =?utf-8?B?OFlpMTZKYVpEbk5mZlQxa3o0WjcvOUUwZEpFKzY5cUlNMkdKcDlQVWl5Q3BC?=
 =?utf-8?B?RnB3TURQSGE3SGFJTER0NXl3d1FNdmkydHA5NTJZTlFPcSs5Q1ZpRm9VcDI2?=
 =?utf-8?B?RlYxcEdDQkt5Zy8wWnlMN054Y0NZdDI0RGNnMWp4TUhXVUdHdkoxTDFoNDJz?=
 =?utf-8?B?QTEwQ3pYY2lPWlh2a2JkOWFXQzRReWJ3djdzTm4rU0t0YTNDcmovNEExRzdP?=
 =?utf-8?B?a3ZsZFZqVXppelVEVjIwUDFrdmQ3b1AxTWVWSVNiWHAzL0tUaVlhbWV4RW5E?=
 =?utf-8?B?NkhJTktNcWhaaUxpMGJOdHJmK2ZVV1hvZER6NFJqcXhnOWRwRlRYN01sNlR0?=
 =?utf-8?B?emhjelFVQVpWQi9NendGKzFBQnVZbUgzdUFKK00rMUpLNWVYTTRYTHZsVTY4?=
 =?utf-8?B?WWZyK3h4QjVWclFOaGQvMm1kc2FSbTJZQ0pzcnhtTmZpcXAxSlM5TE9WUXRV?=
 =?utf-8?B?OWtUNzY1YkxhVkg0L0UvTkZ3WUNwb1U1TUJ0UmpxUU1NNGFVZ0Ivc0Q5VWV1?=
 =?utf-8?B?S0ZBcS91cFhlZ2U1b1krUXlQTlk4MFRSdXNJSlRIcEkvZkRXcFNEWm5nSU1j?=
 =?utf-8?B?QkNic1ZxS1dJZkI1NmJUR1Y5cGZ1NHRXaXFTd0J1MWlVT1dmRGFtK2NONEda?=
 =?utf-8?B?Z3dnL0ppS3hGYTM1YmlvSzRWL0tNRWtQbXo4a1d4cXFBZTJzNHlTL1NzNThs?=
 =?utf-8?B?d25QNFVmT3lad0h2MGRGRVUrWDlHRnRlTjJQNS9nSlc0T1VrRVhlZ0VRNGty?=
 =?utf-8?Q?7DoN9Cxa8YcuGXlVmX8TR0wzdHX3EPyJn1jZYlZ4M307?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zZu0gEm0UX1DYjBjRiNTFw0gH6aQKv1+TTFVCyG/rNv1SXna/ksNUFTCSzu0IrYfR9S1mOh8JefwSALEdpsxSrGV37/VbtqkQBWpQzDoLIxm1LspfC7sn/icuxglrUJ2sKvorOx2mANuzvLEeMk9lqu7KtyYrn6TIYvBxEmk+M8nauLIrm0OLXZGrYJl22MgDm61d46NDp62khm3nQSBTQHSZ1r4xVUYl5KdEOJNYaw0FmuE+5XEjcLvu6L0Dln7QGtEYiV88f7oEexzgIFGzExyBq0vyi0f9cZOwe3MLPWoxW/H27Qq04Ynbq6X2MNvjLYria/Tzx+ImRZhCBrQ4cQ/QGO5+/Y8VYV205gexpXVa45RRztmO15W1CaMOqPm0RYdQxwu4iDqTQqNTllYhatcynltpx53JMLmbHAvm0uHhUW6wL1B9Ar7cPx6EBmXn41ZoiaRoVFxDrEi+WPzVKOWqWFrZMGZGxPcmGJ/eXuMcpRIC/xQzLGycbIstvpe1UADrNaqMb+d81XsNNvW1OPK2LS7WJr/TFEY7l3XYLDWJLkP+BFZSAJ4n7c0Wqa7HP9PrlHG2+Dza0DEAZxbGUSHqCzuxOC4zqAUk3YF0YU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0f9c4f2-d1b2-4425-7dcf-08ddc14b6241
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2025 13:52:47.5851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oT08c95MV1tIedScwKFEUpTrTf4Hu7ocFfCQ2C4+OBfrR0g+c9GBUqRlw8tmOetHRmrs3vtm5+n6/DyiCOEGxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6525
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-12_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507120108
X-Proofpoint-GUID: ZFxhxYzBtfD9KGbjjZcRjo64t-XNaW3T
X-Proofpoint-ORIG-GUID: ZFxhxYzBtfD9KGbjjZcRjo64t-XNaW3T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDEwOCBTYWx0ZWRfXxRaic4RLb2fs 8eSue6CXTCYjl2scAiSpxwv8Tg+bQOCecbVRIHCxbreLta0GMtTurxqVR6zL0uWr/0FXCn1SOqe xr6nUeggD9nJC7k1/d+qgcJk/PdjS3qw6EhEul7QESMpT2c77J4izFoNTviaQAoekGllRvKAuty
 +MC03nbYnqhlDONRQAcDl+GxvjPluEZM3jRfxUBR0PHmdysNqmbNy88NxzJ1Ilvi+mzYItK7upG 2fSIfSEaG+V9HGNyTBf5CpXXN4/JhC8oFrcPfmytNOAbVr82U3VblHSV/OvxQqm7X2BRCMn7d7D lS/288QUP9stuofg32SVe6bwNZyRIfFJGtaVh6ueiaFMwoOJoIZRxUQX/kL9LXkVspWc6B6LMLk
 HaCh70bEHmrhB/Djxee+J44EoXthWub6btnSImGCLSAfvUQUV7BkhGc33RcdKdlZIuFJkMP3
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=687268ce b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=JF9118EUAAAA:8 a=KasFClbeaZD0xqL7aBsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22

On 26/6/25 21:18, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Skip btrfs/237 on devices with conventional zones, as we cannot force data
> allocation on a sequential zone at the moment and conventional zones
> cannot be reset, making the test invalid.
> 
> Furthermore limit the output of get_data_bg() and get_data_bg_physical()
> to the first address.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   tests/btrfs/237 | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/237 b/tests/btrfs/237
> index 2839f6e4..25ed7bcf 100755
> --- a/tests/btrfs/237
> +++ b/tests/btrfs/237
> @@ -28,7 +28,8 @@ get_data_bg()
>   {
>   	$BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK $SCRATCH_DEV |\
>   		grep -A 1 "CHUNK_ITEM" | grep -B 1 "type DATA" |\
> -		grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2
> +		grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2 |\
> +		head -n 1
>   }
>   
>   get_data_bg_physical()
> @@ -36,9 +37,13 @@ get_data_bg_physical()
>   	# Assumes SINGLE data profile
>   	$BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK $SCRATCH_DEV |\
>   		grep -A 4 CHUNK_ITEM | grep -A 3 'type DATA\|SINGLE' |\
> -	        grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2
> +	        grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2 |\
> +		head -n 1
>   }
>   
> +$BLKZONE_PROG report $SCRATCH_DEV | grep -q -e "nw" && \
> +	_notrun "test is unreliable on devices with conventional zones"
> +
>   sdev="$(_short_dev $SCRATCH_DEV)"
>   zone_size=$(($(cat /sys/block/${sdev}/queue/chunk_sectors) << 9))
>   fssize=$((zone_size * 16))

Johannes,

The test case still fails on a zone device with no conventional zones.
However, if we use tail -1, it works fine—with or without a
conventional zone.


$ modprobe scsi_debug zbc=host-managed zone_size_mb=256 zone_cap_mb=256 
zone_nr_conv=0 dev_size_mb=4096 num_tgts=2

$ ./check btrfs/237
::
btrfs/237 5s ... [failed, exit status 1]- output mismatch (see 
/Volumes/work/ws/fstests/results//btrfs/237.out.bad)
     --- tests/btrfs/237.out	2025-07-01 17:41:30.943699725 +0800
     +++ /Volumes/work/ws/fstests/results//btrfs/237.out.bad	2025-07-12 
21:39:03.756275219 +0800
     @@ -1,2 +1,3 @@
      QA output created by 237
     -Silence is golden
     +Old wptr still at 0x073338
     +(see /Volumes/work/ws/fstests/results//btrfs/237.full for details)


Following diff fixes the issue.

-----
index 2839f6e42797..7f460c1415bc 100755
--- a/tests/btrfs/237
+++ b/tests/btrfs/237
@@ -28,7 +28,8 @@ get_data_bg()
  {
         $BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK 
$SCRATCH_DEV |\
                 grep -A 1 "CHUNK_ITEM" | grep -B 1 "type DATA" |\
-               grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2
+               grep -Eo "CHUNK_ITEM [[:digit:]]+" | cut -d ' ' -f 2 |\
+               tail -1
  }

  get_data_bg_physical()
@@ -36,7 +37,8 @@ get_data_bg_physical()
         # Assumes SINGLE data profile
         $BTRFS_UTIL_PROG inspect-internal dump-tree -t CHUNK 
$SCRATCH_DEV |\
                 grep -A 4 CHUNK_ITEM | grep -A 3 'type DATA\|SINGLE' |\
-               grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2
+               grep -Eo 'offset [[:digit:]]+'| cut -d ' ' -f 2 |\
+               tail -1
  }

  sdev="$(_short_dev $SCRATCH_DEV)"



Return-Path: <linux-btrfs+bounces-13138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1260A91D4A
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 15:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1476166478
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 13:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C3A198E91;
	Thu, 17 Apr 2025 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hbmK2ZAc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h5eqjMU3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C64E219ED;
	Thu, 17 Apr 2025 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895182; cv=fail; b=G1hHP1NJlXYwPx++nv0Y6Kpv00FXveBX/8aq837xtu/GFFu8jF7SOAozzBE+Lpbj4GUEAqQs72IJOQxoEVQaMZGbcstFZgx6SKYwl5pARYcENbHPeho5bTSn+X/aaqi/ipH35Vr9mZm736t2LMfCCts7xg4TN3HXjIiBpkD3dBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895182; c=relaxed/simple;
	bh=AJTqJDS/XtfyjGCd/i2W+LBgQ1yC1pwU7TZyB9tIVHc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CQvgFZPN9+mXMa+/2L3k/bL01X7+c4/c31HjWGqqN2boYVBfoCrHIs7P8G7Y3iLiua9g8wiQIEwDqYTvi8qUojPqJvD1YnvcKf6siIu2ZdeETpsH3SLPkbsYQmv3M9KOrIcqJLKQPjUCXkF17zZ6FyuFk7YLvyTEoi1Mf7Y9GjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hbmK2ZAc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h5eqjMU3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HBpXg1016533;
	Thu, 17 Apr 2025 13:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HAjd/jnYCPOLv7qt377pAmgr8dqQ5Ty9rNthLV1ygKg=; b=
	hbmK2ZAcBtWLlX1454fUQTQdMqzzTLTMPrXlx+OR4Lc3dqCOZ2TXnPZU5+WTBsj9
	ao4Ad7Eh7tIBWWddxPh7cnjuOezz9pq8FxqT+rnGN1mTfDGcZmMpcPWYxNZ3X1kJ
	WbfS2iNi4glFL/kBO/5O9QmJMImTAEfZFpbokCQsJMEanFJxLziMooQhRy4SWGeF
	m5vE6lD4+5qn3KEiTndf7BJp18S4zpH/qoqM4VZAWHmQPviLk3082kvHXu33yM4C
	6HTLe6yKumF8qmPNQwMk8vR8h2bfb9lBdKYAh7FKvWsAURLDKx4EjWj1r9BAN3IZ
	L8Lum7PjrywXB48AvL9szg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46180wefyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 13:06:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53HC6EKP024658;
	Thu, 17 Apr 2025 13:06:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d53fnev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 13:06:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8NvewBe7m5g4d5dxaVxtyU7HPaQjsFkA/W9LwYGjJJoHB1iUmFDLt9iy3Elr7FIA5G71UTVSGheSTnrYqGwb8rifTyefo9KNQdSECeDYE2+B3chs5guADXtSdFbr8fHgv3AIu9TQb7VqFMnXvk8lKI5FbrN1VEeLE07j5EnrwDwY3clmHidJAo+2FZal6zEY7O4ya1RrPI3L8w1K5T+TCET6GxWMz7KnigEZR6GM0ibgUVhjF5gctpKjogSLpshUv+ea+Z3SMkq1TN2HO8PpgWFmyYkIlI9thfteqkNx30RS+mBC/8PRTwrAj8da6QfIrqA9uVaCTnSHyeYLb6hyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAjd/jnYCPOLv7qt377pAmgr8dqQ5Ty9rNthLV1ygKg=;
 b=Fphjk7YyMHkwzQMP9mx6KhcSbO/g8AESW9uyeAfybTPc7k4wzjG1tl2pufZ0E2TVSvYMeJ47NdpyIjzr6ly7+ukFJRw47IYr/hpFoBcY6ORXq+cWYPitl582RdfeOVTqENDAhDD9rDrFDiPL5bzyFLIbT9Wa3LmkJo3yh9ik6HYzHwYPCPPyN0/lUfB75E7IANkCLZZ8h9Fdhhwnzz9rDFJZcXsMFds7fk91GXZebg0LsVXT4s9MMyzAiwoByf4TphtLfW2XbQatA0xHl5Qo6NWZieTFcde6tOf68nkEdEEW+xCPR7mduFGwLQqINWXCbEwAiwCKOL6JwMmjFQ6neA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAjd/jnYCPOLv7qt377pAmgr8dqQ5Ty9rNthLV1ygKg=;
 b=h5eqjMU3SVjRzq13OxVkhTtYNJUDxNoX6qL4TrQ2xorcHEk4YdaTBGMrnyVDL3SUrAhzBdKw5nCciJWksHTBR+/uURU8TjG4yGj2Ebn33WLii9MpBxAA8s4Qc4aeQR2s5L9DfAb9dJ8UXM4e4fMKi/mGQnJu67mjC5fnpe9Rz3s=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 13:06:02 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::fea:df00:2d94:cb65%5]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 13:06:02 +0000
Message-ID: <dd3cc686-c5ed-4c29-9b3b-b373ed695795@oracle.com>
Date: Thu, 17 Apr 2025 18:35:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/271: specify "-m raid1" to avoid false
 alerts
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Filipe Manana <fdmanana@kernel.org>
References: <20250417102623.8638-1-wqu@suse.com>
 <CAL3q7H6SZ73LWuCJcnOLK-QToD8C6kOaEL3KOaPGenNd6Li4vw@mail.gmail.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H6SZ73LWuCJcnOLK-QToD8C6kOaEL3KOaPGenNd6Li4vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::18) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5138:EE_
X-MS-Office365-Filtering-Correlation-Id: 1184668e-28be-47e4-b2fe-08dd7db09ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TklvOVF3NXl2YWs4Tms3QjNycFZUaVJqckFjY2RXWGN3cUZCU0hCNE1uWi9v?=
 =?utf-8?B?SmE2eGxUSDZVMm9MY3NJaE8ybzJiZXZUMWRrZXgzM25KdmtPSzY1dFF2K3dI?=
 =?utf-8?B?RlJ6WkdWTlZiWHQxM25HR2d3emdadzUzWDI4aWsyQjJ0Y3BTN3FZOVhtbFhK?=
 =?utf-8?B?N2R1TnpSUzduVTRyQ2gwL2MzOE13Y1ZZSmhPMzJ4Wlp5NDFiZVdRSUtJc3Fx?=
 =?utf-8?B?OXlBUFVOSUNPNXVWQnRuTW1TMWFWRVhXdWRoaWI3bUFRUEFDTnF5L1NwRG1F?=
 =?utf-8?B?NWF3QUFKS3pXVkZiK0xpSXlEZGw1THZYdWg3TzBUcXdvYWpLQmt1TG05SWlo?=
 =?utf-8?B?OUdpQXR2aHJkLzNEazJwNElPVFI5Q0FHV1lORkI5WnNHQzFxUXU0ZUUwWDd1?=
 =?utf-8?B?OTFqOGVhckdwaXhHT0pxK2VkMUhHVGNWK3pxNjlYUnQ5dmxUd3p2dlRKZVBH?=
 =?utf-8?B?ekFOcEZuMW90QVhsT21kYy9rak41OTMySXVtUGNmYWN2andjYS9UbXU3YmM5?=
 =?utf-8?B?bjIxSkJjRjlZUEFwQitjcmNQd2tVclY0QktOYnhEc00rQ2J6MFMwTmIrZ1Vq?=
 =?utf-8?B?RlZqZERZdGdZTXF6WnFHUzZYSmJEcU93ZmpxQTJaK0dGS2cyOHJuSzdTN01w?=
 =?utf-8?B?SlVIRTh3LzhCcnhQd09QSEw0NWRmN2RpUXhyKzJmbnBGbGlBMjJvVXRnMHVC?=
 =?utf-8?B?aFZxVlVqQ1ZXQy96WnFMOHBGTjBvME8zTWpEU1VsM3V4dmZzYnhINzFMYnBM?=
 =?utf-8?B?b3VRRGlOcHczZm91OVNmV2dhRTZPN2Vobzl0Z2NJYUd0S1BhTWQvcWExMVp1?=
 =?utf-8?B?WkpCRjZ2ck9nakNIRHFDVlRHNW1QZUljNnNPVVZBdEVvRDZkbkFuLzVlRWc4?=
 =?utf-8?B?ajlQcWdhakVwSFZJWFVMUXRadEcyWjlMUHFaZkt5Z2xIUFV4YzlONHYyRnlB?=
 =?utf-8?B?Q0lEMGdobDJBc2dQeWE1YXBTSGFPUU9rSlBUemgvSDA1MG5MQ2pGakh1QW05?=
 =?utf-8?B?UmVxZmt5NjAwZFAxcVkrVXNHaWt3aWpmaUpsRW5xZmYxcnJ6b0xMMTBFRncz?=
 =?utf-8?B?OGYwTEpZWG9FakMwM1NRLzE1ODRJWlZvUXZNNjBxaFVJWDE3YjYwR2xxNzRG?=
 =?utf-8?B?MGZsQjR1aTI1RmlVUmpjekF6OFkrWTRkcmtlYk5JUzZvZmVlLytXMkozaFdZ?=
 =?utf-8?B?OEhwWEtNSHUvZDFmcEtNVEQ4c0xXNzJPM3l1RVliSTZnVkZMemFKTm5ic1Ar?=
 =?utf-8?B?NFhmZUROTDgzVERmS0UrVm03WjRHVHc4UmR5VE5aZUpCNGF6U1ZJaUI5bUdm?=
 =?utf-8?B?YW5lcWJXVkpad2lHQ1g3ZDFEdko5cW9vNk5ST2hUWHlUeTdjTzJHNEVMWi9J?=
 =?utf-8?B?andja1hxd0V4YUJjZUFRYlFUOE9YVjdZUG9HeTNzUGNzVHkxaGwvUUdpWks5?=
 =?utf-8?B?RnZtNVB3bnUvYVZRTncwdXdhQXZQdlNlUnE3em1nU1hyaVBqeUxLU0syWkRJ?=
 =?utf-8?B?cjJhL1Y1TnhJc1ZsS2ZVQXYwdzZEbUcwWnJhRjdkdnBteS9CU0k4bkcrcGZL?=
 =?utf-8?B?ejJoSjQ0YVNXNjgrSGZxcXJTK1htK3l2SHlFSzhlNU8vMXBBZjA5QUMxcVkz?=
 =?utf-8?B?VTJFUFE3YzVKU2dXU24vbEUzbytsQXg1d2x6NlYrYXJ0NTN0Z1ZXckErK29F?=
 =?utf-8?B?MjI5Y1NVTWUwWGNUMkt1cDhGSnJYNWtRZUtoUk0zR1JGc1p2b2hwM1JWS3dJ?=
 =?utf-8?B?cVhmMEJFMm0zRW43ZzF1SlBFcTBCZzdhMk5tU3E0Rm1GY09acExTNFRoRm10?=
 =?utf-8?B?N2owYTdBU1VJazU1MjhsRW1yaDZqSFJTcy8vdXVJUXhzZmtoaTkyMjNYN0tZ?=
 =?utf-8?B?aklBYjkrU2t5ZzlvSW9BQlNEcGdJZlc5RVdxY3VYVURBSWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWhKTVVxWWZjZ1NGSG44eWRJdnBKMFJaUmN3QXFVR3h1dW1GKzdhV3JQY1pS?=
 =?utf-8?B?QU1IM25CVGt3UlJLeC9EcldtcEl5LzIzeExCN1UwQXhVQXRIa0g5dFNhYnho?=
 =?utf-8?B?MzAxKzlDN2lGNldzMURESTY0QTFXTUgvVjZ1TUVnYXhKRnE5dXBzSVVtZTE1?=
 =?utf-8?B?dDdwdE50TmJhWG5NZVo0ZWx5UGpFYTI2QlBCOUJRQ293SWJlVkt5bitESlRw?=
 =?utf-8?B?a1E3SjIwajhSeVUzODVsNzF4NzM0L25aa0FEalhlcmhxNG5FZkZsUVZ4K0R0?=
 =?utf-8?B?QWswTWVGc3hOQ2gzOHN2TEp2L0tuaEJXNTljQ0UrdlZCK3l2RnhXb1grWDds?=
 =?utf-8?B?eWZoTEs5STlBK0drNnNFQTRJVmdxVUNqd0UzZWo4QzRJamwwc2pIVEZJM25E?=
 =?utf-8?B?bVBzRHVPZWNTVFA4ZStCbjE2eWVPd1FUb3dNYVhUQ0Y0MWp4UHg3Mkk0TUli?=
 =?utf-8?B?d2FGdysxeFdMK1QyYmduZ0lXUjdVN3ZnY1NhbFVuWHNuU3BSeUpqYkRUMk8r?=
 =?utf-8?B?ajVwbHA4Z2JXWDQvY01TWlVzdUN4NHdWdmlzejR5Sm5Ka0FGSjhIN3BtcTVC?=
 =?utf-8?B?dGRxRURHT05VV214UWYwc2w2MDVtVVlNVWRWZlhSQVdzekozT3MrU2d5Znd1?=
 =?utf-8?B?VU9tOWFxQTE1cTlvNmF6UUZyZW5LVlZzZXB6ZEdCTW1UMHh1NVQ5QzBGbGhH?=
 =?utf-8?B?ZWRMZG56YXlVM09qVno4R3k1aHlwa3E1SEhKNGFpWDUzTzNvTDNtMXJIRm9D?=
 =?utf-8?B?TGdudkowRTBvVFlqMHhJWm45ZTRuUEJ6b2hiV2R0K0krSnRXa3E2bXZRTXA1?=
 =?utf-8?B?NWRxYmlyVE5MQlNVNEwzWHoxNXVMUXRNcDN1VGM1Znp1RGV1ZmtnMUhONHV6?=
 =?utf-8?B?SkJ0bStGYVRVcWFOejNpYzdLenJDdEppN3VmU0ZXSUdBdjIySERuWWtDRGNj?=
 =?utf-8?B?ZWh4eVlyc1hoUjQ2bnNuUXlNVDM1Um55SXI1Q05nbUs3K0haV05wdGdHcUJo?=
 =?utf-8?B?ak9tdlNQQ2hvMWZISC9wVXN3aGh6K0wxTk8yNmVzaWJqR3Y2N3pMZ1YyNHZu?=
 =?utf-8?B?eE1MYzJJWmdaN2NaVU1YMlN4SW5sa0cybWhDS2d0QTg2NDlONFY3RjZuNFUz?=
 =?utf-8?B?MzFzNDFnV1BSMGgyQjUvV2lwWkNQaHk1SWUwZzJ3a3h4SGRha1llR3hvZzQ0?=
 =?utf-8?B?SldtUjJhMjNDVWhxREd6aGwvRDdLK24vUjZGajRKSUFlRzA4MXRYMzhZcTVO?=
 =?utf-8?B?ajVoeit5YUxmRENMZnhoWWVGSS9vaXhsOU9pVlBqZmhhUmNINjVzN0RpSWlW?=
 =?utf-8?B?SlJzbndPSzlXSXBhSFFGUXgrZTJSc01sWkFMU21lajF3TTJweVhiWkRZd0o3?=
 =?utf-8?B?VnExUkhDcXdqOW53d2UyeERlRUtqUExDMUNULzY1dGcvUE5Lb0VXNi9oREsz?=
 =?utf-8?B?UFpLTXFJNW1KTk9LcGxGYWdZYXkwdURxRldZN3A0VmFVcDRDdjQramo2Yity?=
 =?utf-8?B?ZnJOQzhUTkR0M2ZFbWNmZkZoOVNtRThhL2V5cTJGQThJWGdWSStLc2UwT0tS?=
 =?utf-8?B?a3NIcXJGbktTYmM4cWtCVkt6VTRmSXlRbm5XN0NKRGkrOW5UdDhoSjRFUDZ0?=
 =?utf-8?B?enhheVFVaGRuemVoclhVS3ZodVgyNERpSnRoTHJZSlUybWxMUnZQNlJRaGpj?=
 =?utf-8?B?OU9vRklzMlBXMExhOUtZcEZVT1o2dUxjRldkOG1aV1JGNHZMU2djU2NDSndC?=
 =?utf-8?B?eFIrbXIrZzVna3hidEdUcWxnTXJ6SHBpamE5NW1pdkFOWnZibjgvcytqTXJC?=
 =?utf-8?B?dzlaWjJualQ0L2FVVlhQb2tHaVlTc2lXWjlwZThFdndRQVVpRzFnenVOU2Mz?=
 =?utf-8?B?dGNWL0ZCbXpIdkFEamw3WndFbGZUMStDamVDUnlPQndvQW1uSFNXQUhzbzMy?=
 =?utf-8?B?am9zRElxc1VuYzByR05icGRoZ0c4dmlMNjc2UTFIdnA5eTZHVXE4NlhiL1J2?=
 =?utf-8?B?Z3JBLzJZRE8xblJsQkd0VWRWQm5Fb1I4Nk9yWktHeU5UZTYrOEdSQzFmU2ov?=
 =?utf-8?B?dE1CNmE4WXBYR1F5Y0U5RjVEZGV6RW1QaDhlREExaU1LSkczWVhRd2JoWUll?=
 =?utf-8?B?Wmdxd1pKMnNHVXRmWVBXZ1FVdkw0b2E1dUNwU0pEQmVZUmZXVEoxNVphVUIw?=
 =?utf-8?Q?9D8YjYZbt+oxKeQW8zvHOLX34YbihDLkcg7i8xRpB6yN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UIe3iCbZ/OYnJHK4HXt6FjCiqsCghMnRI+utcQsKIb1rIts8PdNwOwyXGBLOMN1Lxro9Ss3tgGRgWjlT11rtD2jBlld15ckXG/Lp4JxSyNWHQXeb8UquUQlfNqC2iNPErr/sFc+E0WuXgyobrGA6k9QFDvnO+1YUt26as+sjL54ktpifS94IZqR9D2Mo8PE3pdmmXux8wgy+OFkTdBKxK5SIlolzCyyb+Lk+yw4alqef//i1Nkw0WvmrZGa5hLvNmMGz5uqG3ewYWdBUfbODhTQanwPVMkL6uVO0BIatjQLFDMYg7s0xLWPOykrWCzeD0Bnb4q/MdoLH+WQq0C2pgkDGrdAwfkRDStU+mPn5hw5aBJ2y916YSXInDA9fuHsNXAfMnKqdg2xd7iFWg6miE+vbvLDoeaAd7kwZ0tYvzheGuPh1Zwy61jMv4S0vJlWGFF78Q0/1nn9Y673FO6I7WSSf0Z+6crvODPXmwq1xFsuIur4w6ZA7p5epomPLLczdjna+GrRPH/UjbnmyQLwlezcWAdtVeee02SCMu+707lbzakRAPNcaqJ1k4bXP7WC8hSJBsPt6rM0WU+CrBUBMdigdVIwYgTU8RfEF3qV//G8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1184668e-28be-47e4-b2fe-08dd7db09ae9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 13:06:02.8406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /hbAou3ksH0Ac2ImkIQYjyMrbyYQzVIbnklBYuTG4aagTnj+SxevT4HTh2EFlV7x9xYLNClDyIAvl25ABl8CYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504170098
X-Proofpoint-ORIG-GUID: RdRGZWKwO-S2tCp3Cg_-6s5meYVCasxl
X-Proofpoint-GUID: RdRGZWKwO-S2tCp3Cg_-6s5meYVCasxl

On 17/4/25 16:19, Filipe Manana wrote:
> On Thu, Apr 17, 2025 at 11:26 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [FALSE FAILURE]
>> Test case btrfs/271 will failure like the following, if the MKFS_OPTIONS
> 
> will failure -> will fail

Fixed. Applied. (for-next)

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand



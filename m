Return-Path: <linux-btrfs+bounces-13839-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230A3AAFFF9
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 18:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D653B5057
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675C627CCEB;
	Thu,  8 May 2025 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jUNHQcld"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053A8155335
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746720698; cv=fail; b=BF7Wz4L11qQKM7cZFdpyMH3UEAWdtGps2bEeQ3UMdkMKSzhQo9dZZ3cCJBtER6rBqujvoGIwwVy4Q8Q5nZvMGdZD0iPyCs0nQcqUASuPjqGj2JBIgSDfc2e4mSOzEgwogD+7yZ63PbHaj99w0P981NaMQkNiMPG3BYy74Knlm4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746720698; c=relaxed/simple;
	bh=nLngVFsGm8biiFJ7vIQRBzK7i9eKHaDb1N9z4CmEmF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Nd/zrQrkhg4yVz9W00FxLep8HmJksKGfZ3Avw6g7QFG8/Hk+zFWeRvi4Mh5tw+2kRWZ64CiJSKZ8kGPCCXxVNvEKDDOOyGc+1Xe8+yaEaeqo4WMhywfAanyaGAxzAYn0MatUu/0L2efaEpq2x8Fh2ULM5YJJCo+ns+TnQSVyvpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jUNHQcld; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548EtN2p020725;
	Thu, 8 May 2025 09:11:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=n6Tf2vf325lJOroECkzcrhEHUN1cNt3/iRBv5pxojlo=; b=jUNHQcldxqFh
	l6AYArEG+IH5/6sFkrsYrkLDsAtDBwaax0m4rz9WGb+EXwOe/RlUJ00XVf3MFACb
	maAHa7jEyfme0DivtBKuLxKEtt46pRnYcMtXMztMVn9ktMnQr33YV9JHOhThXXed
	xmQqeCbhtPrc0pYCP6ooZ0N6Luyn6dfB6Oua3UMEbwPKr6D5mnMCuQzI6QKxK4EI
	rWyVtB23jZJ13PIzrr06bsbDxv3gorkaimwMnKfTGdwC+NymRim4MwXx1PRV4zgk
	nNB8cp8pdydNFA3PSGBENsYWU0Rq574Rb/xlQqPPiIC9IzWtsuLtOOhsUSC90grn
	m2xpA7GA4A==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46gmfg48ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 09:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCHchXQWfMzoIWjFjPiUiydNa16k7Ixwm62C9MqIU2c4xm2jGvfHN5C20g2Z3x3NxO0zeZtDK8JRAPYs7XwT5SjIOwc7UeDLOOee+jbMA51Cu9TgBNScrw1FVY270suBJOrhW6g5IHVVapoNSa8yyMDXCnq9h+ahZhlK7+5/jkN57juX7oDej9VNvX5xcluWq+9p/FH43Vfir4EQC6DpapZ3SLrHWaHqt7oilyBCS867RubxagQAi6omx1T3AXd6mMUTVhz/cuA43UgIxR8I6hbiwMY2xdCSHAoZ43XlJmZnYQloHX4x5CpXgIYiAuOen2ynb1/4zWZ6O3C8x2ODRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6Tf2vf325lJOroECkzcrhEHUN1cNt3/iRBv5pxojlo=;
 b=j6lAtuMSJwPjZykzkMZQ1q4i5TVYOGtWKTeSxh8rvj2hCACp26cLNo86i9Za5zZrLVJIyEIYq0k3u1ilCKmlH00azMxzs6xi9Rjf/0szNAPNRwiz6icU6suFkv/0HSVb5vTaKXEk0U6eHcZsNRYd7UbrHhfUVDRMiZQoAMqNzoFpFL1yeHDIeeALKAqvbWFrZGFQyDrOypA48piy8zFGIYCMCSWtIEAHb8uP/+/agjq+UK6oUg6hcLFL4hNaRKQoSpLT1mdFCOEV6ciwn8zpQRDO6uZwAAXCfmAknem5MsyPv1FrsU7cSd16AWqzxpbbpP2TmzqeTUUZn37HQSwevQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by PH7PR15MB6501.namprd15.prod.outlook.com (2603:10b6:510:301::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Thu, 8 May
 2025 16:11:22 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::595a:4648:51bc:d6e0]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::595a:4648:51bc:d6e0%7]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 16:11:21 +0000
Message-ID: <80ba0638-e49b-498f-907b-24fb926a076e@meta.com>
Date: Thu, 8 May 2025 12:11:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: What is the point of the wbc->for_kupdate check in
 btree_writepages
To: Christoph Hellwig <hch@infradead.org>
Cc: Chris Mason <clm@fb.com>, linux-btrfs@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        linux-mm@kvack.org
References: <aBxJ8uBi5Cgz-CPu@infradead.org>
 <2d1a8e78-b57a-4726-a566-4d916a36be8f@meta.com>
 <aBzCrkI7Jfisdnaw@infradead.org>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <aBzCrkI7Jfisdnaw@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0005.namprd08.prod.outlook.com
 (2603:10b6:208:239::10) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|PH7PR15MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6491b6-3682-48ac-c8b6-08dd8e4af937
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TG5rUFNuRWdWTStRdVFNL2thTXJxYW91UWg5WWRNSkxrZFhMVlpVMVF5cW9w?=
 =?utf-8?B?dTVYYTZYWjNPNUhNcFdpNW9LRTRzVElKOWs2MU1tdEIwNm5ZUWZqRmI1VjJi?=
 =?utf-8?B?SHBMWkJBTzFlMzVoY0JOMEM5VllNVjBKaU82aERPclAvdG9qV2NQNTlPWDVj?=
 =?utf-8?B?aVgvQ1FEb1Rudmk1eEs4U2oyL1hGTkdGSEdiK3hGdld5VlpwSjNwRE5BdWxM?=
 =?utf-8?B?MlBCRlRvOGJOT1gxaWJra2ZuK3E2eW40OUhUcTVobW5FZmlHTlRoZDdYME0r?=
 =?utf-8?B?RmNnY3JzUHhZU1h2TkY1c1NqdlB5dGdVejdaWEVMK0VpN1dESmNYeVk4bWdE?=
 =?utf-8?B?VkxBYUhhV1V2eDNKU3BBKzAyYWk2eDVBWUJKN1lWY2kyamR5aHVEcTlsUE5i?=
 =?utf-8?B?WklRYkFCLzFLeHcrNUxOSmN5TlRWQnZXK0RLZUJRSzNHVjRwYVhZQ3FIWmVH?=
 =?utf-8?B?UUZoa0pQSFhia3ZLQTY3UjJJbC80U1lUS1FWUEE4RExJTkpRY2F2TWo4VFZI?=
 =?utf-8?B?RzlhU3BBWkcrVHZIQU1wZUc1ZFp0eWoyenczODBoTE1oMUIwYlpyMisyemZr?=
 =?utf-8?B?YnEvaFN3aEZPVXVNU09OdllxNGtuSEhCWHFaZm9saGpDUTVoeWp4MkN3eSt1?=
 =?utf-8?B?VytBQXlXK1M3UlZ1ZllLeHhHU2FIeGtjSzFZWnVXUHM4TXd0R05wLzV1NEI2?=
 =?utf-8?B?RnJmcWc2OFhLK2FZa1FPZjl2cmhOdXNoU0JPWlhlRlZ6c2krSlBGc3NkRTI0?=
 =?utf-8?B?S29xUXRjdlE3ZDVxaHlQUXM2QlRPejVGSm1pWlR4b1JpenN5eFFhbWtLUXpL?=
 =?utf-8?B?NHpXVDlzKytRWG96Q2J0cnI2cnV3aGc2VXNRQ3hKY1hVT21EbmJoVXlKVWR2?=
 =?utf-8?B?SVpUeW1tdnJrVG5qRFVHQzk2ejJQZ1JvQWtaNUl2b2srNVJwdjNYNFFtL3Rw?=
 =?utf-8?B?a1lOeWlaaHd2Q3pkVUJVRGZueFVhSWIwTXRjaWpoMW1SekVvZm9jOXVJanFn?=
 =?utf-8?B?WTQzU3FndnJNS3FmeU90cHFoVVp4VWx6cjZDdDdyVDhBUmpjR2xBTUZVSENz?=
 =?utf-8?B?RWl1SUFkT1U3cWU3aU5ZcUlVSVNZSFgyYWtSdFBKaHd6OVU2QUpDUjJHcmxB?=
 =?utf-8?B?ZjUvczNJcEcwZ0R1MndOTDUwSkVRYWhXVW5mQUFyalh6NzRyLzMwZXV6RmhG?=
 =?utf-8?B?WU1TMmdQYlZ5NWJTMXF4c1p0T1J5OC9KWkxaSU8vaVdJYVNJeGNRbGFpa0RH?=
 =?utf-8?B?REt0cFh4TnIwM1V3S3VyTXM2VU5pSDYyM1NEWDF1TXpOVGNjc2E3UW1OVkJn?=
 =?utf-8?B?Y1BaY0wybUVhb1VHb3N1akxJRWN3MktPRVN4blNuck1lWk5tT3Y1SUo0VXJt?=
 =?utf-8?B?bVB2ZjRJWkJ6enl6ODFFcEJtS2dhVG5wRUlRRHYyV3Vqck16eTYxOFZZYmgz?=
 =?utf-8?B?VFF0bVJvUDRqLzZMcU54UkRDTnJMaHZURzJzSk0vcWhsOHZzK1BzcjkyS2Rt?=
 =?utf-8?B?c3MwdFRuR3JWaHBiYWxUZ1BwSldka0QyelVXaG1uOGlFTC94V0JsSXBKYkR5?=
 =?utf-8?B?NkVJcnpWeFAvREJ2NTNuTDY1YjJCaHVZTGEwYnFTTjhqMStFOXNtOGhsRisy?=
 =?utf-8?B?LzJuSC9CRlpldEdNVmJrRVJVSnJHSHVtRENEWnpsVjhKTk9CNG1laWJ2SlM0?=
 =?utf-8?B?Qy9KalhJdmUxYUllK0cvREpOQ3NpK3BWM2daZ3ZyR1RvQTcva0t4WVd4c2VZ?=
 =?utf-8?B?VHhnMnozMVg5eldVSjBzTnk4SWpwQVByUGtxaVFmYVpDTWVyeEUweW5IRTFj?=
 =?utf-8?B?aUZLNElkNzQrOHdqc09hZGZLcnBVd1drYU9TRUpxbEZtcW1NUGNkWmRnOWQy?=
 =?utf-8?B?ZHJucFFrRWdzaFdQN1B5SEV1czltc2RnVGxNMkVObkZVYy9yK1FscEQyRjdn?=
 =?utf-8?Q?aDxxeDxxlC4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDA3NmxTQjRrY2tXMFVIeVFpSHZQYmFhK21kZXYwRkhvUk8zVHdGdkgrME95?=
 =?utf-8?B?SzNpb1hPYjZWb3RzNStvaWNTNU8yYXEyZFR1eXdSOGZwM3p3Y3c3c3A5Z3Uy?=
 =?utf-8?B?Z2lTR0lpeE9LbEpYSlJxam9xaHFxU2RLOEM1czRmU3NRbk9SMTVtY0lRV3B2?=
 =?utf-8?B?Wk1ZNGRGMjNUNjRWWW1kaEZDODdQNi9EK01FMTQrRFNaRkE1SzIwazNqY09i?=
 =?utf-8?B?emZRR3JGY0dlU0d1Q3RqWlhncHdwRERSQUlWbmVPUmlWU040ZVJrVkRvbTFK?=
 =?utf-8?B?azdsT2hmUk8vZDZuam13QUxwUHRkcUV2TDl2VllsYmppSmx6VWJXdXpTVTRD?=
 =?utf-8?B?MHI2a2dST2UzV2c5OHM1S2pjNkhBYnBJaTZVbzViRXdFRXJBMjZlRllqL0xQ?=
 =?utf-8?B?VWpKNURvUElSTmw3VTBWQVhRSE5sUC9TbjFhM2NUbE5tLzIrS1RkQnM1VzJy?=
 =?utf-8?B?VXNHQWd6RzdiSFRUVjl2WVFnVWdaV1l2Lzc0M1JORWN0UVEzV0ZkbWxCOE9m?=
 =?utf-8?B?TXlHYXZWWldEZW01TW4ydzhWbmFhWm14OGVFOG44VFZKU3BGWVRza05zWjRF?=
 =?utf-8?B?a2RqQnZ1Tzg4SHZFRG9pTXFrdlUwY2J1UjVMeUlxTmZJRm1MSEJTNUloamFJ?=
 =?utf-8?B?YUlxeTg1aFFGU25NdkRlY2hPQ1hBNy82NUpCMW1oNkZ6dGdHWmZSdlR3R0hx?=
 =?utf-8?B?c1JiOUVsbW1WMXNXYlkzcmhsL0wyei9uMHlVelZoRmwzbjMxc0o0eUlOemlO?=
 =?utf-8?B?aW9jZGlZSGNBWDFmQzQyZEJ2WHlnM0w5M0R4MDJZRm9PQTI3cE9FU0N3ZW5Y?=
 =?utf-8?B?bmVKcmJhemJOQ2toSytUcE02OGkxMFdlc2ZIV05ydHBldlZsTXpSODA1VkZ3?=
 =?utf-8?B?NzltN01hQkVBNUIySGN0Sko2V1ZtbUJJZjY1aERjc2x4NkhIVWxsb20xYUlQ?=
 =?utf-8?B?NU1ENnlkK2lqd0w0ZEJIYlZhSnh2L3V3aHBhOWRrTmN0SkhEOUhtelFKU3Ix?=
 =?utf-8?B?L1V2UHkrc2RucEpCUXMzd2I5cEhjZlJLVUZCWmxqNUZKYjF1OG5LemJmbFF3?=
 =?utf-8?B?Q3VQcEpqaGU1L3djOEcveTI3dGxMQVpHaDlpdVlCVWZTd0dqOWUzb1RsbFdR?=
 =?utf-8?B?ME9iMTNiUE9KOEZaZ1BCSjhuSHFVUWpwV1VTME5JT1FvMHdZb2V2aVdyK2hK?=
 =?utf-8?B?YTN0NGxkTHdDS2RJVjJpeEptb1l3cmludGJScnNSM01XWnYzNTYvbWY4dS9p?=
 =?utf-8?B?VnJaK2dwNFBkNmkvRlVqYVl6UkRVanIwRHoyWEJHSHhqUml4cWZzd3N6QnY3?=
 =?utf-8?B?ejRKK000b1Zab3U1eUdMSnhpa3BSc0hjWW9HTTE2TEJydmsvbWhSbHo0eGs4?=
 =?utf-8?B?ejFhU2pnTnFSOGRhNWg0MXFYRERYOW9pNmxGeFZ3K2NJY09EWFA3ZXkyLytN?=
 =?utf-8?B?TytXWlpsMTAzRXVET1dwY3NjdHNUSUlQeTcwUHhGMUtDQTdrVkpiQ09mRW9m?=
 =?utf-8?B?QmQzY1lGTGIrN2hNMnh2WHgrRWNVT0QwenpKNlhHbGZOSFIwTEhmYm5QR0RG?=
 =?utf-8?B?Q1lqeVZKMlY0TGNiTWVQdDZYZk8rUURTWmRYaVZYanZyeFdCU0kxVFo2TUMy?=
 =?utf-8?B?LzZBM3RaZEtmWVd6elJWQ0dETWNvK0t5bS8ydHFtWUhPVUxVREszQnFwMzB5?=
 =?utf-8?B?WTlYa0h2TW1sL01KQzFRbWtETzFJc0wwQ1ViZHdCUk1USmQvdDZ0T1hESmVU?=
 =?utf-8?B?MjMzdis5VjJ0OGJZNEhTN2Z1ZXJQQTAwZjl1Mjk5K0JxRk1WdFVReGlET1pZ?=
 =?utf-8?B?anR2OGJjdFhkQW1WbGVaU1JOanFwbmtkRlZ4R3BSdHkzWDFvbmJFRVk2N2hM?=
 =?utf-8?B?MEJNVjhaVzRQSGNWclBvVExIZ2J3UlZFUmREVDZKRUlhKzNyTFlZV21xWGxX?=
 =?utf-8?B?ZkpSeVBLTnZFOU0zb0RTejdLKzlFd0JjNmhORkwyRTZyK3luWi92WjdKc2Rt?=
 =?utf-8?B?UkFxbEVkU3dOb3hXblNDZWlncWFyL2lEK2pDQk14SHlZN3hxZmxrUHFvS2E4?=
 =?utf-8?B?OHlGUHlQU1VvMlFrbDRURzIyekFsWUsvWVlEYXplRXNBb1hQZmpCMGxWeTY2?=
 =?utf-8?Q?6PisObXrncNqdwLxN8dQIn2aW?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6491b6-3682-48ac-c8b6-08dd8e4af937
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 16:11:21.7945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vcii5irJ8l5EHrMVtWl9HWqx93qCjfYy/Cd/yHcxKbCFeE7XWSQ5t44PS/RIXwFE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB6501
X-Proofpoint-GUID: 8MF1phlEMxQQ5DFNcKcVYn7BPjCuDLqK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE0MSBTYWx0ZWRfX5VzZEc995ced IsNtWur5c2MsIu1Q6viHpyecO8Xp5JTA2qVIx6qiTUy/APMKjJoUTUdL3YKoTw3/mdCq72QvLQB JZsOyVjqtvv/sCnSotiOjUewrReWUkIIj6u08qKXgE/CyGz3xJlVeUj8KR4mQ4h/W7tiwvqpwdc
 ZqV5iI/z2ZV1FRiwmchj/iOkZVkYQBetWSxrn/N27j1Ma87UL+UIUnrwfXZtxrSkfEf/sR0KAGX WW7je43aFMrBT14T3mAdE0TgEiv046UfqT5BpO3TehmBGecyY2+exRGQvO6+lpiJZKIidwmn6qK YCQGVDwFyIJjTlwuz8qaJTscQPSWm5OxVAlRChdJNfVPTGPAiuUENZrJTD/Ss9WQVGXK3Mz7S5v
 lFtE0D8psuiBpQXhqY3YfQnh1EJ8cMFpCNwtj3d0Fy7oSHsyHoGsU7Su0KBipakMQmIVoj0C
X-Authority-Analysis: v=2.4 cv=VPTdn8PX c=1 sm=1 tr=0 ts=681cd7b0 cx=c_pps a=X8fexuRkk/LHRdmY6WyJkQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=WkyblDKLlRiQ5xv_:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=t0UnWl3wcZ8KkGTeN48A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8MF1phlEMxQQ5DFNcKcVYn7BPjCuDLqK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01



On 5/8/25 10:41 AM, Christoph Hellwig wrote:
> On Thu, May 08, 2025 at 10:33:24AM -0400, Chris Mason wrote:
>> btrfs can keep changing dirty tree blocks in memory, but once we write
>> them, we have to recow.  Between transaction writeback kicking in every
>> 30 seconds and us calling balance_dirty_pages on the btree inode,
>> kupdate was doing more harm than good (back in 2007).
> 
> I totally understand why you'd want to avoid background writeback.  I
> just don't understand why it singles out for_kupdate.
> 
>> Is the goal to get rid of for_kupdate?
> 
> At least getting rid of exposing it to file systems, yes.
> 
>> I wonder if we can just flag the
>> btree inode to exclude from kupdate, or keep it off whatever list
>> kupdate cares about etc.
> 
> Not having the VM do writeback on metadata but running it from a fs
> LRU was a huge win in XFS.  I'm not sure we have interfaces that keep
> data in the pagecache but never do any background writeback.  But
> if you are fine with treating all background writeback equal that
> would be exactly where I'd like to go to.
> 

I'm not sure how much dirty metadata can accumulate on XFS, but btrfs
isn't bound by any logs, so the only limit on dirty metadata is the size
of the filesystem and/or the size of ram.

If we skipped all background writeout, we'd end up letting metadata grow
until the full dirty limit was hit, which feels too bursty to me (please
correct me if I've got that part wrong).

Josef spent a bunch of time on metadata-in-slab and our own LRU, but
with the volume of dirty tree blocks, my memory is that he basically
would have needed to recreate a bunch of the dirty balance plumbing, and
decided it wasn't worth it.

I'd certainly be in favor of making balance_dirty_pages() and background
writeback able to integrate with private LRUs.  If it's already possible
that's going to be a much better solution than our !for_kupdate hack.

-chris



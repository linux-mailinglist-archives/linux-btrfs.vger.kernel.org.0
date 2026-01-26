Return-Path: <linux-btrfs+bounces-21082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0J7iJsHLd2mxlQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21082-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 21:17:05 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CE08CF52
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 21:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C3F03025A4F
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 20:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428B32D5408;
	Mon, 26 Jan 2026 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="IjrhF0zf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050B21DE8AE
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769458618; cv=fail; b=mjxobyPkUsVEsNrSqs8WpppQ9TU6YiV6NLBWx2JJk9cZFmm63ezcOmP5qJ272CCQlUf2PqEkGexBvy5nq9wL3U3M8ZTIfBXFWt8E7rMU6RbKAtjTFe/fHlTXUT/IR23LIpTIusUv1OYgeoh72OSvtfrN0sZKAq3EKuSTfNYORVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769458618; c=relaxed/simple;
	bh=1I99MLjbydWkQS63D645h6pH8SeKkY4ChJvBHSnzHgQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dJkWK6DsbDYqwS9ddQKePpg8Fe82q5CC4wCNq/Gx8MpmYfCfr7TL3fGKmnC3jT5T0aQ6QMTpMlBtLE3PZfdFf7Wow0q0D3CBnd52lSEn54DLyxCpQFFDH6ASqahe8KQCzA0PhosLUUyLDvbpCvTPOPp4CKbc3nYTASUZ8zCvFG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=IjrhF0zf; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60QIFKAY3269663;
	Mon, 26 Jan 2026 12:16:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=9r0exgPZc8Ct3AHkk7sNNbGKjjJQS0aYQkqrWuFoW/w=; b=IjrhF0zfAfpb
	QcNc53fArFCJS+4DybmuuLbjG0V59wEDRwUTgQ8o63C+8Udn9Cw2JgAmSvnKluKX
	VL4P0ycB8wkJQ9htxjQuHX9lGaIvVmG7Ad/dFrdP+EioVGqcqyaglFmLgDVc4JYJ
	qYkzQqeKYtSeCMaKf3aGqDBZSkDqgXgvI9RSv/QVCyQyTos58JFAg9kQQEYVQucz
	rUlqeDJz1R4Oxh8R67SQvcfHrlPFfjRt4lfpiixYpsw9+BqQOevtlfVkJD2hJ6Fv
	4oVlD1LtJ1FaMd6EvZPwDcLQ/fFdaI9aOwJtlccIdfyYG+3PsQaKq/UFfHPH6PJQ
	OO9NBSGjxw==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	by m0089730.ppops.net (PPS) with ESMTPS id 4bxdcvs8wc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 12:16:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wog0E3QLyoGrsvt8rcsdjS44XdVTYKdFUnypQBiUXPxEBtXH8VT7IBZflPUwfNMmbAfsFsXPOYhcFaJNdlFHM1BH9dN/2STUivoRTB2Aqkkjbv8wfAOLBd9n2YuPeXP8d8jRiF3E88olUMhIW80URVBLlE8KGgouOF6Pe1YkypTVC4v7dqb2HTq/oDW5o4dD3YD85vBOCChZRQlq33uHgtzi9Ej2Ed1obGwGMjw/53hQZKneJ/NqStQ8DGFxfUY47IPIaAENzRqOOKQaOGdCDjmrHV2J1toDvGRHaaX8lZRYtVqXxCM6mSI7jwv7qW21cj/damhM0wLTFksaPrp6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9r0exgPZc8Ct3AHkk7sNNbGKjjJQS0aYQkqrWuFoW/w=;
 b=kq3kKHSKbZiCbvJ9NdGq9q8h4b1naMgv7AaFZ4aEFc2my7b378mNLisOQxtIwMzreNppCAFEKczHXx/vj/xdRrDaBOTPGW4VF68zSfEGCgJnAyqzfsfU4Nn5yrXE95oolFjg+Wzmia4atMuo8RBintFQDkYYFnLqmCylCNL1CV0NYKmZ9WuKFfO/EEOpiZya8kl+lBANeUryk5gdAnRnIOhFfs4bjZ/+ZWmYMetF4UhO0ls6YJlR8s0uTIZXtQwIR38qpe0+ipqFMqv3N4EjbBjFgpQqK7a934gqLJ7X++SLjCbydlLH3lOsGwomQ3KfjbkkyDNrHZSGeWliNE7cGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by MW3PR15MB3836.namprd15.prod.outlook.com (2603:10b6:303:45::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 20:16:53 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 20:16:52 +0000
Message-ID: <f3b7b6cf-b4ef-4e4a-97c4-bd415f12695d@meta.com>
Date: Mon, 26 Jan 2026 15:16:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] btrfs: zoned: don't zone append to conventional
 zone
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
        WenRuo Qu <wqu@suse.com>
References: <20251204124227.431678-1-johannes.thumshirn@wdc.com>
 <20251204124227.431678-2-johannes.thumshirn@wdc.com>
 <20260125132120.2525146-1-clm@meta.com>
 <a4bf91f2-c68e-46e4-9fa5-0cf563e5ad4f@wdc.com>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <a4bf91f2-c68e-46e4-9fa5-0cf563e5ad4f@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0217.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::12) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|MW3PR15MB3836:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f571e8-50d6-423e-164c-08de5d17d82f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFlyRGxxSEIrWTdNRHB1N2lOV2Yrc1I2c3NCeXNnK0Z4T3dQd3hLTkVCY0F6?=
 =?utf-8?B?aiszMTFpaFJoS0ZkbGR4TWVTQ3lKSkc5V29EeFNYd0loZitnOGVocEF4NWt6?=
 =?utf-8?B?VDZDc2tHTHVoR2t2Ri8rbU1lVEV1YVVIQWp3WnVVWWZRTUVnbVdVajYwYXhh?=
 =?utf-8?B?Y1RSZ3NacVJFVlU2VkVnWlVlQldQSndxR1l1UStLYTZtMklIczlvUUF3K05w?=
 =?utf-8?B?a2IzalppbGtOdGhqNkVBMHNCNzJaSUFOYUNlS2lYVnMxS2NXb3JHb0VMcm1q?=
 =?utf-8?B?bXgxdjgzOGI2MGVvempUMng4WGdjQThpcHhWYU9tSEpCOGFTbjBIb3ZoblpP?=
 =?utf-8?B?YjZEMnR2YW5tamg5S3pvNzBEVTVqMzR4L3ZtR1MzNWlXOHVwRkllbkpubTVo?=
 =?utf-8?B?TnAxUzVkWXh2TGQwSzkyT0JabG8zcFhuUzNOam9CV0E1cGs3aXRaelRPMXVQ?=
 =?utf-8?B?NHAvU2gzaE1tNHpyWXJXN3BHbzgrVm1IUk4vZThpQWhvQkV0K2kzUTVKV0k3?=
 =?utf-8?B?bTVsTVhsTlZ3ODUvc05YbVIyazMwU01tcjR2MWhNdzgrd0g4c0ZqYXI0c21Y?=
 =?utf-8?B?akFPdGcrb29BWWdYa3FlclEwS0VLUEY1L0J3djY4ci80OVRmcnVwVGpNWVhu?=
 =?utf-8?B?YlRmTGx2cUh1KzBDMWNlSlVZS2RMZklHT0JYNjB2c3RFU2NUS3RlVmd2UC9v?=
 =?utf-8?B?NE5qMGhsSW5pMFpZMlZBZ2NBK0xwMmwvNGhLZXB2MlNHWUNjOGM3Wk1UZk11?=
 =?utf-8?B?TGU3bG4xZEZZV0JmSzhHV09pdEF5U0VrWVpiQWJnM2FSYTNWTWtPczAwaURJ?=
 =?utf-8?B?OElKWkFSYVgrRzdaZmVPNjhLeWJmdmhoUm1ya1AvS1lCWlpPdzhzUm5aSi9B?=
 =?utf-8?B?SlZ1dlRocmhqWEVob0U5VnZDaDhIcUxMRGFNdzJxb0c5M2JvbEpyblo2YzNw?=
 =?utf-8?B?M1pFbjN1cnhsZlRKQ0s3VnN0cnJhRFdPSVBzL0FQR0M2SEtXb3lDRW15ZWFa?=
 =?utf-8?B?d0tYWTFtaFRwTVdPVDhKN2hac0hadHpJNGpDVkk3dzNzTE9KUUZHUFRGS0U1?=
 =?utf-8?B?K1VnWDRhZ2Nhd2pCK25YMmtmcWY2eFRVdDl3ZEU4UHdISFI0cmNDRkhDRjR3?=
 =?utf-8?B?aUQvVUFTZ1Fhb0J5eEZwR2NSbzl0aHVDb2lsM09CMFZsNzhSNm1EUmhTTTVL?=
 =?utf-8?B?ZnZuVzRuamdxTStXTWV1OHRvR3pvY2xwVkdEUkhUcXYyakNqenVSaWQ2VHVl?=
 =?utf-8?B?UUtkay9WM214T1VVbzRkanM5bVE5dUhTOEluRTE2eU5lSGp1cDB1bnhQaEtH?=
 =?utf-8?B?NUhrQXRVQmgxZzY4a1VxMUZOZGZqU3VvQ3BBdkxER3E4a3htYjBGdWJBME1q?=
 =?utf-8?B?a1NvdzNMUzV5UmsvbENCVklQa0V0eWlVamE0TjIvTGlseXNxak9lQzU1Q2dV?=
 =?utf-8?B?WWh2QXl0WXVPMU1IR01XVE9IUy82dWNudk84dGt1Ykc4UC9mN2hwZHhjeC9R?=
 =?utf-8?B?cDRuZ3VoeVd6RS8rVGpQbFh5ZU9WUEY2dzhBN3F0U0ttcitlS09rTk9KTE9o?=
 =?utf-8?B?cDA3MmJZK05vV1NNL3lNYlRZWkdaY3V5SkIxUHFyRnZnbElRWFBZZDB3c2JC?=
 =?utf-8?B?ZEZORDBRdjA1MDMwM3phUWFuUDBkOElOd0J1QlpkaGY2LzJEaG5wcS92SWZZ?=
 =?utf-8?B?UVlNRTlxTmV0RXFseW1PUVh4eENNSUlKcC8rc1hXdDZoMzI0WVFobzAyRTFh?=
 =?utf-8?B?eVdVOE9iTGdDeGYwNWJkclk4MGVlQjZacUlDSTlxYVdJRytFZzI2aUlNV1p3?=
 =?utf-8?B?WVBqcHIxUlZycUFDei92eWRYSU81eDhiYWQ4Y0JSbmI1ZnpsVm5UMmoyVktR?=
 =?utf-8?B?QitzY3JRU1BwM1lRdkl4bHI2NjVRNExGcWlZZFJ3YWc1SXo5amJDZ0U3OFNR?=
 =?utf-8?B?bExvcEZNRWt2d3Y0WDdROFQvTFBOWGNqTytoWTBuemMvL2x0Vjg0eTFDZjRT?=
 =?utf-8?B?OGpMRlpHOXlVZy9MMmxMRHpENVlvdGN0UU1kamlwbWprZ0pMcnNyYTVjbytz?=
 =?utf-8?B?em84bFlsd2JMQ2ZXc1c1MFU3YXFGYmM5cVF0T2IxcXpaRWlRRk1JWlVubkxt?=
 =?utf-8?Q?gaMo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFpPeVB0MmdSTDdmQWN1QXNSdy90U21CYW84V2xQREZhTDJhNzNoOW91QlFu?=
 =?utf-8?B?c3liQlY3VFFCaGRyZG9JZWxMSHJDRmRFUHE0NTBURXBRa0JGcFNsSS8yZXhv?=
 =?utf-8?B?K2hoakd1Qnp4TmNYNzN3bDJzVUVOTFFhRHFNS0Y0M0Y3b0k1V1ljQmIyZ21y?=
 =?utf-8?B?UjBIYmtodzdYMHJpd0JJMkhXUEx6MlFmQ0VNa1ZMYzZya1hmTzRjdS9aVlZr?=
 =?utf-8?B?MXYzMXBwWkMwbTFGOUU3QVV6K1VpK3JFaW8vOTBSdGhXdWx2OVZxa041WUx1?=
 =?utf-8?B?QXJUeFNhUVI0TnRPZ2JBZ2F6M3BHcit0L0RsZmFoUXlxRjU0bzRObDVPdnRo?=
 =?utf-8?B?bGhxMUQrRVZtZ2FMcnZxTU1Fc1czRGw2WXFpazBhcVJOV3JJZjVBSHZJYkk0?=
 =?utf-8?B?aGhWMkdYTWx4RnhjSmxWUmtBOWJ1Z3RkcTdjbG5CNjB2OFhjQVV0VWpWN1N1?=
 =?utf-8?B?TndDcDR3MGRSWXIxcVErTG5PYmVkNkNpRXE5aWNUN1k3YzZ4aVE4NVNEYXNt?=
 =?utf-8?B?Vm0yOEJjTklybHlhMGR0UUZkRFAzMGs5MUl2SEJRRTRzVURZUTlRNkY5V1ZS?=
 =?utf-8?B?dmZqQ1QwakNXd0gvMzJTOFVSU3RHTTduY0pCdnhGS2dPeGNzYmE5eXptSmJ5?=
 =?utf-8?B?VEtiK2RWQ0dvQlhCcHFCU2JmYmovWkdXRVZod0lPUk04YkpkdzM5VGZGOGxV?=
 =?utf-8?B?N0VHODFsMi9xVnc2VVYyZmxJRThwR29tcUswNW5oV1huT0puck92SC8yMi9z?=
 =?utf-8?B?SzFmMitITXFTZVMyTGZGNUU3UmFBUEgzV0tBbDdGOE9lYmNtaWVIaWQyTXN5?=
 =?utf-8?B?MnJ1WGUzWGRrMDRVR1loUmZZQ0ZTT1lxMmlnaGhhdjl5Y2tweUQ1cUsyVHRs?=
 =?utf-8?B?WkxBN2lZc1kyL1p0eTBYb1M5OEMzRHFhMHFkQVBORTBoR00rSERWZVk2b0tj?=
 =?utf-8?B?bURyTFFpazJGRHFZNGJySFlEbUNnVmI5WnJxS0JGUmk5aXdMRk5waGJxdE5o?=
 =?utf-8?B?QU1LTzdwdDBUZkk3aWpyL1pQTFk1S1BycEFXejVldnZMSmIyQ2lSeXVhZEx4?=
 =?utf-8?B?cnkweWhvQldyYnZHRzFhY2Q0Q01IeE53R3pldzIvVnZjUUgwNUlQcy9UK2lP?=
 =?utf-8?B?S1BlNWtJVFdWTXZsMEFxY0xQL2diWUhZekNwck1RanNZcDZ2a0FGcVJzYWp1?=
 =?utf-8?B?VUNXTzhHUDZPd094NkF1VTY2aEJ4N2xyMlFiZ3lJMXB5dUpXKys5cmZsQ2Z1?=
 =?utf-8?B?d1RNT2pPU2lJaVlQWkVXMDR6T1FEZTBXb2hqeWdkU1hFK0wxcHBESHFVY3k3?=
 =?utf-8?B?TDBuT25yNVFmSGQ2Vm9jZEdEUkhEa3ZIeFhPaTU2RnpXMWtySlFtei9aK09Z?=
 =?utf-8?B?RGZZZFB3NEhWaFl4ZXlmVU5wT3FYRlZZY2VBYWNYREFNVFRYaFRIT2lGa1RV?=
 =?utf-8?B?TzFmV3JwWWt4OW9lblk1d0d1ZFRWdkRtaVFoYkU3V2VYbE5qY3Jsb3ZUOHpt?=
 =?utf-8?B?L1lsTXpmMW5lWkc1ZWozenFwY21Jd3Rxc0FLM3NhMjNiYW85VjZTcGNBVVBk?=
 =?utf-8?B?THAvWCtQOExPNFZtQS95VkNkZGw5NjN4NGVkV2ZDWERxZ1NWODFFL2dYWDVC?=
 =?utf-8?B?WXVSSXd5M3dtbjEyWHp4emV3UGt5YlZub0N4ZmxEQzZITnFTZnVscDdRRVNI?=
 =?utf-8?B?VCt4MVBUb3RrZWF1SFRwaWxwM2I4WGNCOFprZUpsZWluaHo3WlVIOUNwcTBU?=
 =?utf-8?B?RzFkS3JXRnJGU1MwcmpoT3FpOC9CRHkwVjRnL2lxbTh6SkF5dE5jYzNORUh6?=
 =?utf-8?B?SklTOXV2dTh0c0NFcmZlclRqQmpFcHlMdjdCaldleUF0Qkt4TTlnRkJxZk9U?=
 =?utf-8?B?TzBJRjJzWW9MT1lzcGFnVXNCZExtNmt1SUtLb2p5aHBNRG5MUks1cDFWSjN3?=
 =?utf-8?B?eFh5cEg1M0lsVzdBTlFKdHU5QzdHd3l4aHUvUzVWdkRrYWxNOU5GT0RTYW10?=
 =?utf-8?B?WUpOc05UdFFMbzR6ZmVmOENoZ3VrbVJGaC9FbWFzd3M5b2ovS3N3RDZrb2g1?=
 =?utf-8?B?QldGOXQ5TThuM2l6TjYva2FMYTZPYW45M3QzYitEQmdSTFFwS1F5c2tnYmto?=
 =?utf-8?B?aXYveHBROHJpZU1pZzU3dGM2eDVtbmNYZEtFNTlhOUhkSFlsWDBuWUVHMElk?=
 =?utf-8?B?WnVQRnQ2ZmNzZ3JNVDlhODlOWHNCT3RNRHNsSFRCOXJuRzZGSTZCWm90UXFL?=
 =?utf-8?B?cGw2WUl2dXpzQklqWm0vd0lNejAycHFndVh1dnRtc3JuaXM5RTVQVUlHODVj?=
 =?utf-8?Q?5GqkAwc9kcD+R8h4pO?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f571e8-50d6-423e-164c-08de5d17d82f
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 20:16:52.7673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqMW4JkvjzNvmm/UevFiHRBN4GMy0dBguKnHCae4p6M3IQ3ky2EtSHnEJsYE22Xr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3836
X-Proofpoint-GUID: 1vX1Zwz2_ZVOprsuvyIviGGVx36ETIWR
X-Proofpoint-ORIG-GUID: 1vX1Zwz2_ZVOprsuvyIviGGVx36ETIWR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE3MyBTYWx0ZWRfX4m5AOuwX7aj4
 8gL2vc7X5rfw1IfaURbGa38LcbV8q1nez5KTSufKKs3KOHbOpPHNMpBCJABIqxLpfqMzoCSuALf
 s9MF4Fj482L1Y/QYEqcxg9Zyhl/34fPZpMRCADWB8uLZk1eOwq6Tkfomsg0CVW9JYLsdzbXiDIM
 4gjSnMNuT3Y1jFtJoBCdkhEoyq7XM83toRE4HKN/kReLKtOPW6yzG+KJnHXBEGmobDaMa7/awm8
 GHFsvhmHZtpg6FV1fD3nN8hbHac6+lZ6TGlSXDiNefmvzf5ZYvr3cCxKyVmO01hhqxDKg0CGoo9
 cI0S2mnWSKEgo2VWkpciwen7ENj5HOYT+EcWaEkDEZsq/Zve4vfVPQw3YtA6XPJKx/xM6MlIux2
 33o4vKHdUynkB/4KiTc9pedt6B2Ad3qFugW2KSvx7pn+aneqCd1y9aX761a+x1OwxOPyNyyuyvT
 2YFJg5KjEUKj2mxoXaQ==
X-Authority-Analysis: v=2.4 cv=KqdAGGWN c=1 sm=1 tr=0 ts=6977cbb4 cx=c_pps
 a=Ul8IY3gNdN0J7lfmD5e20A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=JF9118EUAAAA:8 a=k8qfKn8cba0iGpfo6dsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21082-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,wdc.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 18CE08CF52
X-Rspamd-Action: no action

On 1/26/26 2:51 AM, Johannes Thumshirn wrote:
> On 1/25/26 2:21 PM, Chris Mason wrote:
>> Johannes Thumshirn <johannes.thumshirn@wdc.com> wrote:
>>> In case of a zoned RAID, it can happen that a data write is targeting a
>>> sequential write required zone and a conventional zone. In this case the
>>> bio will be marked as REQ_OP_ZONE_APPEND but for the conventional zone,
>>> this needs to be REQ_OP_WRITE.
>>>
>>> The setting of REQ_OP_ZONE_APPEND is deferred to the last possible time in
>>> btrfs_submit_dev_bio(), but the decision if we can use zone append is
>>> cached in btrfs_bio.
>> Hi everyone,
>>
>> I ran linux-next through some AI patch review, and this one was flagged.
>>
>> Apologies in advance if this is wonky, the text below is based on the
>> linux-next version of the commit and the mailing list has something slightly
>> different.  But I think the overall result is still valid, it doesn't look
>> like btrfs_split_bio() properly copies can_append?
>>
>> It still seems valid after the enum bit transition later in this thread.
>>

[ ... ]

> Hi Chris,
> 
> This indeed seems correct. Also for all the other "flags" (is_scrub, 
> is_remap, async_csum) but csum_search_commit_root, isn't it?
> 
> So the correct fix would then be:
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index d3475d179362..0a69e09bfe28 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -97,7 +97,13 @@ static struct btrfs_bio *btrfs_split_bio(struct 
> btrfs_fs_info *fs_info,
>                  bbio->orig_logical = orig_bbio->orig_logical;
>                  orig_bbio->orig_logical += map_length;
>          }
> +
>          bbio->csum_search_commit_root = orig_bbio->csum_search_commit_root;
> +       bbio->can_use_append = orig_bbio->can_use_append;
> +       bbio->is_scrub = orig_bbio->is_scrub;
> +       bbio->is_remap = orig_bbio->is_remap;
> +       bbio->async_csum = orig_bbio->async_csum;
> +
>          atomic_inc(&orig_bbio->pending_ios);
>          return bbio;
>   }
> 

Yeah, this seems right to me, thanks!

-chris



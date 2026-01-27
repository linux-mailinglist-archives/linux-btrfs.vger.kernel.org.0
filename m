Return-Path: <linux-btrfs+bounces-21129-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKMsLP4yeWmNvwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21129-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 22:49:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 161189AD3A
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 22:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 804E330226A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 21:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8736E2DB790;
	Tue, 27 Jan 2026 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ei3/Zoi2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A67E32D45C
	for <linux-btrfs@vger.kernel.org>; Tue, 27 Jan 2026 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769550584; cv=fail; b=taD7DR6oEWhndsnUxIbUd4OmTn5MiZ8gfJu+XAP/CxW7IugODE4S9fJUALzAJbhb7OWEB/tpQbBDvpb9b8lPSWzqMkEKvRMBO23xjCrnTvuj5iVoOJB5U54xSPOuvQTy2aQ/WUSkH7MW5MkwnzbNMswki63hIcqrLOdNAbzJxMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769550584; c=relaxed/simple;
	bh=dji2Xjq/8l9lUgL/QM2BJtANzb86giV+mtBeh1sjFoA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bTdMAu6Y9QBtdOH5D4EO1/shqWIQ1Tju/LDNo46dxSOhMqgUbM6MS7Poni2CQreeXPvsXIo0Rs8o3Qrh7b46cyuLnh8typnWxS1exe5cidvqGBe/Qb4J4uWi/ar0z0vCNQpqESktp9GGGKR94W+Z/KKKoE/e3nH1Xzu7M+CYOwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ei3/Zoi2; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60RKMjjJ2763841;
	Tue, 27 Jan 2026 13:49:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=KebZTc7RqNeOz7TiQxYbMnLUVU0m5JTPSIWNf7zYJTo=; b=ei3/Zoi2AY0v
	EU8yC1PVdbp1CmB0ieGOpkE8GQbDVC59EhiPkZqI+VYK9iPzdpcu8YAP9ZZjNwfy
	7syEsPK4x49Qh24/Dsm57SBma+w1Z8g2ZJoog2ruCvMBDF+p5ODc9ClKIaYG7iTT
	11Hh8sZYWfzPHfPoEsU3mQDSYBW9J0938TUyFndYT5/AQ8Yo/q6N+SQr+N0XXt+B
	qOmrANor/d9bUonj3z4HL7DbV6gzK0WiLkN0GlZcMX2A1XZPxNDIkD79E1tl6gUm
	3c2FJDbMsD5TBIRhJJsGED30n+Nb3U5v6V7KUafCSZnZvqu9Vb9uBnd2dPoaCddS
	FxoC0ENKMg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	by m0089730.ppops.net (PPS) with ESMTPS id 4by23vaje5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 13:49:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lUCW8U9YufmEea0ITKqbtkVgYEKCu9F2q8jAEOvE7bFoV52W3O5BpvroSvvuXrikaGJzaxiCNXlpZNuzhUbaPk4rjRS1fSRVm0zOeD4AoN3AgkBaeAYDhiLdF7GxUFKKS0jx84FjM8puvWW/00rOKvv4Sk/M0gdOv802ihYeUZ4t9r4oVK5bjZtyhrJinxaHLbNzZ13iH0PqxUn6XN2mJTNSCOFC85puU371Vu9x8/v48NgtCCyOn+hKmV+sgn8oSv7FsMK5khnsUjfqCfBDbxGEHCGGqlXlmlch0Gmt6Vm+oDbcqY4cNwlkqBLRHFbotYJPlohv4LH05N98F4+nrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KebZTc7RqNeOz7TiQxYbMnLUVU0m5JTPSIWNf7zYJTo=;
 b=YFrM+GvKuBNVkLhnjrIPvZiv1gWnxsek50WuyfIZhLm4hX9IvWEThCHNH/Q96WMPcEZVOd1Pfcj0r4U4q8VbIjexEEGYiUaF1sVNZuVkbCFyty+OdxqB33KKLiiek/kbI7fT/lSvnbVCYOKww7Y3ovgGZJiJGy4EiBPcubDn2awMu9XwYGWFo6jtbbIt2YQCMJT7zj7ULkpgc8+azcr8A8kCwiu8aKg6QBumCm2nLEh2WpLBMdl2nCoFYqAJ1tf+aG65BGd2EDeGQRUcV1yia4jUiQGAtiLLg+FEPDvECG40qiKYx/36Ea3GquzxHwO15u8KbGRvDFUiPAwxGGL+JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SA1PR15MB4951.namprd15.prod.outlook.com (2603:10b6:806:1d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 21:49:34 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5%4]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 21:49:34 +0000
Message-ID: <1e1bb52d-1d7b-4eb1-8a73-b051f4ac3ae5@meta.com>
Date: Tue, 27 Jan 2026 16:49:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/9] btrfs: get rid of compressed_folios[] usage for
 encoded writes
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Boris Burkov <boris@bur.io>,
        Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1769482298.git.wqu@suse.com>
 <9781beb3fa2948d125d16393d755c60096b855e8.1769482298.git.wqu@suse.com>
 <20260127202805.GA3504710@zen.localdomain>
 <a14a1533-ed6b-4c98-9ae8-c742efc7c28c@suse.com>
 <20260127212705.GA3548083@zen.localdomain>
 <749f28bc-d55c-4f9e-81dc-c5d307adce58@gmx.com>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <749f28bc-d55c-4f9e-81dc-c5d307adce58@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:208:52d::10) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SA1PR15MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ab52ac-7b13-4238-94c0-08de5dedf5ab
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anljY0tKRkpONncyV0dvTmpxeEVHZnVXNVF4MTZjd0t5QmVRS1N2YytvM1NK?=
 =?utf-8?B?NURPb3hwVE1vNzljYjhWSFUxQkQ5MlVmcUJLVkNZdm9YYndLYnhjUW5BY2do?=
 =?utf-8?B?Mm10Z2xsc01zRFowb00vYWl5cG52MmN6NUxEZzhMd2VSTEYrWUhEOTFSa0Vk?=
 =?utf-8?B?Q0JLdEY4M2F0WUxGTTBBMnpUdWtrMVg2UG9jV1NSMXBLTGFsTWZSbHVHT09L?=
 =?utf-8?B?ejhYWjJWemdZYUFpLzVDNlRMaXBuRGE3U243ajd4ajM5Rnlyb3pYY2QyUkJ6?=
 =?utf-8?B?b0pIcVhFTktDU2lIUjU1WEVuRzlYcEdrSDY0eW8wK0x6RFpJWDZnUE12TVF1?=
 =?utf-8?B?ZDNwZ2wzdUVJSXBVYjd0MzlQclpvRDg1aXN2N2p4WjNYUmcrYXVJN04zL3pz?=
 =?utf-8?B?Z3dmVk40eUx0cHVBbHZrdE5DOUUxRXB3N0lpZ0dXTjBJRTBOdm1SN0F4RTNE?=
 =?utf-8?B?TzdFZ3dKVU5nNnZ1MFRGV2oxR3FOYm5KWWVmVnBFVWlGMWtnN01IcjRScW1l?=
 =?utf-8?B?YzFNazhCNFFQK0RYajNETXNsZUdhVzRJT3oyamE1Z0NsQmh4OS8vMzhkUHU0?=
 =?utf-8?B?eXk4TFVENjZOblREcURQVVVrN2dXekFKSFlGaEpneEtmZ094blhzMi9SRTNq?=
 =?utf-8?B?UkxRZlIwYytHTU01SlppamdaaGJJOGtDU2ZVYktxTEptcGp2SEJieEs4L04z?=
 =?utf-8?B?cVh2RUI3WDBSMENTSk9mOFVKUXFpTUdoUXovWktETE9rYk1ibVVTR1JIZDNr?=
 =?utf-8?B?RitsaFkvTFJ1MC9YdWhYdERHK1pYNFNKVGhJNVYwRnZTUEZrNVcyZWNmQW9a?=
 =?utf-8?B?ZDdFU2ZoTkZIYnFDcFpJcHVCZUNDTjZzbFBLb3V1bis4ZElpazBsdk9GUHZ4?=
 =?utf-8?B?MEhoRTVVMk00NmthcjVjc241WC85aTZKamtNQ2liVVpRaHp0ek44U3gxR0h0?=
 =?utf-8?B?MmZvV3VvY3J4ek15ZDk1ajV4VnF0K0dFd1A2bGVhT3VXdS9iNVNBd2gvd2JG?=
 =?utf-8?B?RFFkeExWWkg3RUlmWjgxcGVtWWtvRUVQeFhBYTduaUd6Syt2UTNtNFZjamdt?=
 =?utf-8?B?UjJqcjk1OGZKV2ZEUzgxVnVxdTNDKzNKVC9MUTVzaHpuZEwxUTVwWml6Sk0z?=
 =?utf-8?B?WW5sQks5YjFFK3NRMWJEYVgyRCt4NTBIZzBHL1JUdkN4Q01EOVZCK3pOaG9n?=
 =?utf-8?B?bCtZd1pEODJuWEFrdVREa1hyVDRxUTd1T1N1Q0Nxck8rUGVWUVBiOW5NSVFR?=
 =?utf-8?B?VjhIVVhiTGM1VEJSb2poTjRET3VEZmdsUlh0YnpDOFptVzV5RVZucjNicWZQ?=
 =?utf-8?B?MWFlN0l4VCtnWGtUNXJlNGNFanFubmdzWWxPME9qVy9CeWlTbXhYMmNraUw0?=
 =?utf-8?B?aEUwU05OcldHaDVkVjlCZElUK1BvUG94UEFvNStPNWpTM0J0Q2hZNmlsdy9Z?=
 =?utf-8?B?UkFLV0VjMkRqMVowV1Mwdk05d1NMS3g5K3dwVFZZb0RPOVRyVHIyVUpEcFdY?=
 =?utf-8?B?cEhzOTJLZlRIdmYvZUFxdjQ4ZEtmNzN4emFuRmd6bEh1dkxDbzhVQUpOWDdj?=
 =?utf-8?B?bGgzM2hWbzVIOWR2VklPbXJaQUZvemJNUDVSVXQ5dGY0d1QzM3BtUTBYQlV6?=
 =?utf-8?B?YkYvekNLdEVmT0MyT0Z3c0FZNmpGaTM0N1hBK29ZeDdzd3p3WkhXOGZHaVBE?=
 =?utf-8?B?c2VyWG1PK25MODVMMmptZ2xsNDMydmZ4UW9HQTVjOVZ5SW5xRmFrMnZiV0hF?=
 =?utf-8?B?MXQrbzNRL21ITzRCNEkxOXlyNG9LaWxhU1M0RUVpM2NHTjR6eGRxSDFSQ1dm?=
 =?utf-8?B?ckZlbkRQMmRVT0plenNHUzIzb0xkK3VWZUhTeVI5QVU1WFdERXYyNDFBRkJL?=
 =?utf-8?B?QVVOcDArdUxEemsvZitjV2l2UWwvWlVHM3ZxQWo2Nm0yRFQ3eXRzdXZYaGRL?=
 =?utf-8?B?ai85WVYwZ3hNVGFLeDl1UkxLTlZVSmdMWFZMdktJSnl5Vld6YnJtYlNaT1hV?=
 =?utf-8?B?b1Y2bG16c0o5MGtPOVVGTGFhUW1uV29iYXQ2aHIvVDhPZTZ2ODRFYnVPY2F4?=
 =?utf-8?B?N2tjc3h5bDUwMitVdnRta1Qrc2R1MkFxWGFkbjZMVFdGTlhjdFV6T3YwVGZh?=
 =?utf-8?Q?L1Ka7SQX9xJrP28O/mhj2tdHA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWsvb2l1UW9CVGFGRTJyMGxMTzBOdkFDMnlNNWQ2YVNGWUYvNUxDZkhmeHUy?=
 =?utf-8?B?U1NIT3lSTWYrUkdMdk1jNHVBN0tzOUJIcFJMMHBRZGo1czBaVDRBdVp5Q0Vn?=
 =?utf-8?B?cnFDTFBTWGF0b2F2Vjhkc3JaU045cFBoMWJReVoyTlpRZnEzaUR1U0pINmpO?=
 =?utf-8?B?ZlZyTitKbkJQSGN2RUR2M3BSNTRXMHE4bXdDSmNDajRlbEttZ3JzTEpNZXZn?=
 =?utf-8?B?bmdoQXljR2VQSVltUWxxeHRsbEc2dThJNTNoVGlzN2crSVRQZXpPOERyUXkz?=
 =?utf-8?B?aWhweDdCWmoyazdFbjZuY2lyQ0hoMHZUMU1EQ3BTVmszNjFGQ0NacDN1Qzdt?=
 =?utf-8?B?M3VvRmFxa1pXM1I4V2dGT2hzYzcwajZlZTdGZkRmTDR2eUtZdUQ1MDVGbGcz?=
 =?utf-8?B?T2NRQnozcEFuUjJxRWJYVGZZbElPMXNVKzYzODVZUE1CYUJDNlpVMlBvRWZL?=
 =?utf-8?B?dEtndDAwNHN2ZjJVSHIvaGRoVlYrZlprU0wwTzVYZGRvTVJhRE40cFpFUklB?=
 =?utf-8?B?WklwRnJJajBxcmJkVXJHYkFLQ0l1Y1ZDQjNGcVEyQngvUE40VjZLL0tqUzVl?=
 =?utf-8?B?VjJjZ0pHU08yMzFqYmVoY01GZHBEUldGaXA0SkQ1cW4rWDladlB0YVZ5SEhP?=
 =?utf-8?B?VEh3UStENzVnN2pPTHZRQjZMcUFlTGlFdEZiUTk1K1EwMmNLTG9IQ2gza3Fa?=
 =?utf-8?B?NW1SbDFJN3pBRUNWbUZ6QmluNWJ3MWFiNnVPZWNPVXNES2FwcVdCbnlRNnVF?=
 =?utf-8?B?UkloWHRSOWNKMGZld0dBcUpoZzBkN3ZmMnBleG5Pb2RxMFBNdlFaMlRCWGVk?=
 =?utf-8?B?eEJNQUp1M2xIYitGcDFmWXVWZi9KNmMxSytNVDk4Y3ZOa0ZrRFB1eHZ5eksy?=
 =?utf-8?B?a1U1ejBpVVpUZEZlR3EyRUwvVXFjYXpUVG14eUNQemU0TlQyYzNpWk11QTVa?=
 =?utf-8?B?NTZzNXVUZTkrTU5NRTZGMnVEekQ3dTFVNDIxL0xFS0MzU3JTL1hSSXFEUTkx?=
 =?utf-8?B?R2czVDJIelhmR2hnZkRBZ3VwZUZtZVQ0WGo3YmJLbDhZaWxaU0ROVUdGVURE?=
 =?utf-8?B?VlJKTTFGd2tnSjhuSzdGUFJyREhLV0R2d3Vyd0wzOVJDR2E3azZKeTlQdGRz?=
 =?utf-8?B?OEl3bXZ4K0dwOXpIM2o4VEZIa3JqQXdLckl3b1JNTHBnM09wMFN0VUpmYUJ0?=
 =?utf-8?B?WjhXR0VZeXZVTFdwMUZpbGRYV3VPT3ZMaWpiazM0WFdyMnJwd2xXM0QrZk1H?=
 =?utf-8?B?K0YzcWpzWEJOaGVOYUhhRVdFckQ2UU9MTm40cXV5ZXRyNFFWbnBIL3JPR01u?=
 =?utf-8?B?WlY4Nnpxd2QzaG1WdFo4aWRIZGtSdGtEc2IrRGpCVnp1UTcxdnhFMEhIemJx?=
 =?utf-8?B?Tlk0Q3hJSlRjVVJJYldpdmNudUNoRTNoQ2NWcHBTMnNRUjVBOVJHZ3RDWXBO?=
 =?utf-8?B?TlRDVitCd0hacEdJcFpYVUlXNkgzaHFiMVdnd0VVeDg4TjhQbkp3Y0Nmblk0?=
 =?utf-8?B?OHpmT2gwRWlJalg4MkFsQ1BlNDgzTGFBcU1jKzkydzFsQ3lwRnE0MGh4ZUZW?=
 =?utf-8?B?VG9CVjh0NnhaUjZvOERlaG5ZUEFaS2dNQzNpOFRaanAzOE5ubGlvZnV3dzNZ?=
 =?utf-8?B?Tlh0UmlsWkNWNExmdGJ2c2dQbm5tUVZFM0xGb0NVRnRuNjRaV1pqTXVzZ1dX?=
 =?utf-8?B?NTBLVWlua0JvU2JVeFRKNnZuZzhmRTQzRWIxYjJMYnF2eEhwUjJIRnhsZitU?=
 =?utf-8?B?ZGgwWnc3ME1iZUdaZ2J3bEw4SU9aSmdSOTl2cHZGMUtadnIyWEpFMHh1cHE0?=
 =?utf-8?B?OE1paVFKaEJRY0xSaXJxOUkyRGw1dHluMXpYV3lIeEV3cldBeEIvTlkvRkgv?=
 =?utf-8?B?UUlNYWhXSUlvTlptUTRwQjRsV3FrdzZvdlRuSlJZQ2JSUWFYelZsbVdzNjBh?=
 =?utf-8?B?Vy9NTFQ4Y3VxYTBaM1Zia2tUaitDRDJuT1B6VzRPSUkxSm1JRnk4eHplOFov?=
 =?utf-8?B?TnVzbDVLc09SYXl4QW9TNTZBSVk0ZVRKLyt5cjFYVXBDWHkyVEhkeWxib0Z5?=
 =?utf-8?B?eUVOeDZCZERFSk12RGo2dkMyK1FMRkpkc2ZmTU12VFdLRUZQVjk0YjJBOXRN?=
 =?utf-8?B?QVZYYThEYnpvRkNGWThaeWM4Y05qQXBTZm5WODJlaS84YkZrbGJwSnh1TzZu?=
 =?utf-8?B?bWNvdDAvZHBsUEFRMjczMllSMnhJWm9aU0tQc21ub05qRWJuYmpLMXhCZHU4?=
 =?utf-8?B?WUdpZGJyMFhJZ3NlUEFpZlBXaFhSRzZGVGdZQldzY1EwOHM0TG4xTkVpSzRw?=
 =?utf-8?Q?s8rFvZzFYFhqwfR5wX?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ab52ac-7b13-4238-94c0-08de5dedf5ab
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 21:49:34.5092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KEh46C7Ra6LiAv4Dg50WTJcbcneGetf2U2c1254Z1tvPOYjP1zSsW5diQXRTNmj4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4951
X-Proofpoint-GUID: Sw8K3b__oGRzPzmtfQoPhaSB_OaGx3nt
X-Authority-Analysis: v=2.4 cv=KfXfcAYD c=1 sm=1 tr=0 ts=697932f0 cx=c_pps
 a=uhkaN0mRh0u8fl/99TXUBg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VbsJBzb2mFyldgmSeCQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Sw8K3b__oGRzPzmtfQoPhaSB_OaGx3nt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE3OCBTYWx0ZWRfX/j1wVXrHoXxW
 /e3uYdsMRTnKhQAcLvY3EhTdh1MrtJV0K347DK0vY/q4dVtEZIEIy4EcyviNRbiJlO2ApZTL81Z
 SjjTdOmBXj6LCtjbdRb4F0RWfOBXkT8MBYNYGx60oVwiHte7OiQXzJencCncpLKktGZ7KC7Ke+s
 duCXcZsCqDmxnQwHKqj+Vxte6Nh2v87xymFKU8NQwQkXUxfGn8DMChIk3Ju0sJ/8DZx5ZZvJAna
 PGySPxwLO63jkqnKsDqHFVWmt7Y/kD4kTlxGWzzbJKqqO3ulXZcgLjmFDGHj3SPG2S7si+oF9Pl
 sHRC7hRjbqsDdGvCRXoG7x8VynS81aVKKLdi1xFpRuz6crrRk598U/5qUrxlJ1JfstFTAR6MXgK
 UwZaNvbeb+qvrJ8obxFFaSUm5arSVAq76U0/pd/FRaxxmwRpSlwEZVM8ZqXIdg3eAAV9ydmI71Z
 uIUoMmSBpsOP2DRO2Sg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21129-lists,linux-btrfs=lfdr.de];
	FREEMAIL_TO(0.00)[gmx.com,bur.io,suse.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 161189AD3A
X-Rspamd-Action: no action

On 1/27/26 4:29 PM, Qu Wenruo wrote:
> 
> 
> 在 2026/1/28 07:57, Boris Burkov 写道:
>> On Wed, Jan 28, 2026 at 07:40:23AM +1030, Qu Wenruo wrote:
> [...]
>>>
>>> Wow, the AI review is better than I thought.
>>>
>>> Indeed caught two real and careless errors.
>>
>> I have been impressed lately as well. The main reason I fired it up on
>> your patches was that it found several interesting bugs in my recent
>> work as well.
>>
> 
> Can we have a public bot doing this? Or will it easily exhaust the quota?

That's definitely my goal, I want to get it running on any subsystem who
wants to sign up.  Roman Gushchin and I are trying to find the most
effective way to get this going.

The prompts are in the github link below, they've been tested with
google and anthropic, but I expect the other major models also work.

https://github.com/masoncl/review-prompts

-chris



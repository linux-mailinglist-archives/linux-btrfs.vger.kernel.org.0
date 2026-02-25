Return-Path: <linux-btrfs+bounces-21916-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LMWCkDenmkTXgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21916-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 12:34:24 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 944AD1968B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 12:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93EA030B0F32
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 11:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1FD2BDC03;
	Wed, 25 Feb 2026 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h1+0KuQW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="GLWzLe76"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EA5288C3F
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018995; cv=fail; b=HoWePMg5OhTl/0TYC6gS5AAdHJhLtyelhQkY+PSA04UccV9JniMr9iGnZubeUZe4ruq1mXiWyULRi98zfw1DaifeDWWPxHLdcZCXQEa4xyNN4oAbhKwCF73KS2fRQf0u/7V26xb1eMKiz30/Ffhy9LvwM67eqXIFQdBnOjtEEzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018995; c=relaxed/simple;
	bh=Kj/1A0qWb913ZLAxO6mNCJ6Ox2ProZzXEv/cZlC0mGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=erQMzBp7xIXgNOsSNucuENzomZVHw8mQ1uAcX5qv6GoWIKm2wK3wJPCZfhsH9EfJSNIvOimBavfVa7UJNDWAE4pFWQYL0tXeNzSp/MS3W/iDWpc2F7T0p4fvlM+BNqxpJtQCrxF7mICv2kG2wN8dcRvgrqJFId4YrTrpMiJ+liI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=h1+0KuQW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=GLWzLe76; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772018994; x=1803554994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Kj/1A0qWb913ZLAxO6mNCJ6Ox2ProZzXEv/cZlC0mGk=;
  b=h1+0KuQWTdIyOfJJgbam162dGRQEmdWp3hqd0k3gNwfkD0iFVnyvVwV2
   Dr9TmVEgNqSvnz/jhq+lgMG2gq05ZW03G5KKtqez4JFrRSEe8V1x+F8/M
   A3xTN71PmyanirT2kyC/ThD86OjYQVSeeeW8TEqQ2q6eSjEgogBx2rZ9G
   vx28WY7WjhwUmFq/0z79raKppoTURG9jbWYhQXlJWdWGF0T2jdw88eakl
   g/P8NRDVKczluqimeoDnaO5JYc5f+BUj9/llR5BB9ycQ6t1ndldVSaJi8
   n7D8LCtyoWSMUyqaieEfs6Moghk0ZUyjAKfN5vFFf44zBCPBBdXE2TSSb
   A==;
X-CSE-ConnectionGUID: E3LRHiLMQiKlY1ygdmSnOA==
X-CSE-MsgGUID: 11/UUorbSBeevH+F43HWIg==
X-IronPort-AV: E=Sophos;i="6.21,310,1763395200"; 
   d="scan'208";a="137843271"
Received: from mail-northcentralusazon11012000.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.0])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Feb 2026 19:28:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CoHlb04dae/sLkX5FnWueeUD1ZX+Qt02KDnpz0Y9IzuMtQm1LRvraKdgjiXcJouwvbPAT/8mD8HvkhgQDMHHTLAm4eU4AyUHS3+rPZ7UxxCUXSC1MI8KcWSBmN+8NSEeLDSfuxDF01Cz2fwN8y7d6kpQGHvAooplu79RMu+QsKWWqRNBoLpCCCdxWvSDZ8j61rG0KuZ1Y5GHxVC2GG5BCRkGB3JDcSZQlsnj/VKBeMSifZauU8Dkd89TpHSFW3Y8yDy61kgj3OpPRLLkbDPS5TQ4VtsPjC2YMT1SxkQGbVxg3gheQo5L06u0HpFbY0xAxIXb6EhOdXsMxS8wFwlxYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kj/1A0qWb913ZLAxO6mNCJ6Ox2ProZzXEv/cZlC0mGk=;
 b=RAhCiw0SPSYwpFPpb0VxMqI0ttwZ9wTxkAqa/0524oAYFMaW0kxpZNuJ2UknnMepJwN7qPSC15HMRO5Wq88JkmUOETOQSYqVc58nBKHFjrHsRggKtWZrIDyr3mXY22W0vcDYfJirlm48Eg5oXmqKAn8uNJr1W+GOzCCdgi1iR29udvuAhfUj1xnPts3ULwWRchQoC36CmIvpasE//2RvVGDExjVfox4NLrgZhSJHwtREtokGGUaV1QxNpiVX0dNvvkS1GkmDyWBajdB2UNguBCuhqXH+/1CX2Lqd8yDnD728/s0Vsqx0aXs5oHpi+9GqYiW/xE7v1CP5HD6JPpVrgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kj/1A0qWb913ZLAxO6mNCJ6Ox2ProZzXEv/cZlC0mGk=;
 b=GLWzLe76z0PDljHVVGWc9V5KduPEpZ8QIZDkkfI65VfR2u/wfZT6LWkX684zz2mziyaDaM9vKKunJLlcOEirbJawgXvyOxRI9Z+ugrk57pJ4qyZT9qwPYE+auy9wsvTjlKLBD+OJQ/36JqQKcLNthAuZ6hAGeDJMKV5s6eqCQco=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SJ0PR04MB7471.namprd04.prod.outlook.com (2603:10b6:a03:293::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Wed, 25 Feb
 2026 11:28:44 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Wed, 25 Feb 2026
 11:28:43 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Mark Harmstone <mark@harmstone.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "boris@bur.io" <boris@bur.io>
CC: Chris Mason <clm@fb.com>
Subject: Re: [PATCH] btrfs: fix potential segfault in balance_remap_chunks()
Thread-Topic: [PATCH] btrfs: fix potential segfault in balance_remap_chunks()
Thread-Index: AQHcpkKRHAyOZxUqbU6oVMSZ7MNGF7WTR0aA
Date: Wed, 25 Feb 2026 11:28:43 +0000
Message-ID: <cfa2d558-acd7-4b09-80fe-be51b9f2e8f5@wdc.com>
References: <20260225103535.18430-1-mark@harmstone.com>
In-Reply-To: <20260225103535.18430-1-mark@harmstone.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SJ0PR04MB7471:EE_
x-ms-office365-filtering-correlation-id: d67dc32a-c6ba-4446-c59b-08de746108b2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 6uLdkU1x1CZp7PLVNU/HMTKfPD2WMAtpe6jBV7MsFxBEDaQsaX3ajUCz/H1wjmAnGk2acNdGSbvM13RFJoG5S7NrQSyNzaYgzwfzVBtXdGFXDTmgiZ9A5TeQZX3nW2v/oou/dASbN5OCv0nDdnbqAmiLynpCgFNGvFpSQK0DiSWggaX4Jkar4NiS+HnOTKVd7Gb5DPw2wcN1ATD/52uV1XJhL5PMaSN//zL7GeNSEcBEkHTDIlNY59D65WGk7mRMbvLa2JvWdR90Fsc8B7glpvj8nQhU6u/KoTxBAT31Prn/j16TCc9Zw5vIuRN/BiTE+QYtVgJJdsBIafgbYOmLMdc0sPPnRYLF02xFQUmc1WnqMXlzn1UvwaGRcmhxg0qPyq48hQ2D/ny4gsbCE+G9ZQfDrQa9p0NPbl+YTrVTiw654KIZPll6bS5JTytAIsAN1p3I+VV/oqiPWn0R7ozobsVZOrTDPqja6eJ4rsb9XkU6lEiHHfmqYW+sgKmIn8qA7W+3veGOqMqy7fznwMOgA2AAt6P6rDI3W54UUW0HLCCzMO7CuqWU+l9SIw4Mk8If4EkjvH1OFCiDsxwrXTE8YjtH+1V15G6694qTUBSc5NewIg3AOXDX32PJHX5Y8PIfDm9fLqqSVZkUXU2yR62fLV1p7/grHj2OSRBkt7R3Inw6GePJFwDIsy0cZQly6SyoIv5iSBlYVc5nGtoXIaW2QAD0lQ8LLxKU56y9TqInAzQGRc8Fa5teGmf+qTmRWVpVnz+qBI1w2e5UtdaROym9DSp4YeLVDzP71zJ50F+qwU8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFVuM2F3MkxORStyUmFnWmRJRS8vZ0JqNkdpVTNIVE9GazVzUy95N01QY3Vk?=
 =?utf-8?B?NVFWWGJtMlJOdEtjM2hVTCtrSGxkZUFMWXZjamhvNjlCZ0hERDNVRHQvZGtU?=
 =?utf-8?B?QVpSOElwRmNTV3FQV2p1Smd2ekptbzlTRVRmcEhBWUpjS2hzN2lNamJDL0ky?=
 =?utf-8?B?QXVoMEFMQmxjR3RwM3hiVmxpVTl1SSt1WnhobmVBZWZwVUlBeFdHOW1Jakhq?=
 =?utf-8?B?QnhBRy9tK2orZWpML2tmQmM0ekZwSnpyT0syd2xJbEpTdmVKSkZFM2MwU2p0?=
 =?utf-8?B?dzkxK0ZUSnpPNGpNazg0NWdOZ1ZKUnBKclJSNW1FVjcvZWFTRlRzeHo4Q0Fs?=
 =?utf-8?B?WXpZcVZydzlEaW5wTEVOV0FNMFJQbnp5ZytsNDJuaVBzNWtDMHQwR0MrZGxw?=
 =?utf-8?B?cmdnUWZha3ludXR3Zm4ydjhXcGdIT1FuTjJhcUJUeStEV3ZjUnp5UnRnTE1D?=
 =?utf-8?B?RWg5Z2JUY2JGRkRsby9GM1JsRDVtd3pVME1XLytMR09LOWtCcVhzd0NaWDk5?=
 =?utf-8?B?cmFzcjRuSEZkT0pTVHFjTDN4MnUrNDZiRFBkeW5lOE1TUHlsK2c4aWZ1UUlx?=
 =?utf-8?B?Nkl6Z1F5amlYN1drZlcxaWdITkQyQklPT1JvYXNnK3ZZTTh1bHRXeHZxaVU4?=
 =?utf-8?B?engyWW1EelpKTEUwWGtFM3lVeFdwdGJhTllxTjR6RUo1VnZJcFBsaXRxZ2t0?=
 =?utf-8?B?bm5HVkpjcmNJdzlCQnJDMGkyTnlmbm84dDV5TjNJaVhiU1NhTVBtNlhEd1cx?=
 =?utf-8?B?dEY2bWhnLzBiTXRVWGUwV09Wd3NDazlDWnFoY0NieTM5a0ZUczNFWFI0UTg2?=
 =?utf-8?B?Y05DZmx0dG1KTXViYlh5Sm1tcWVWajJ0OW1oNWgrTmZVR09ZMFJONC9heHdp?=
 =?utf-8?B?eXNVTkQ5U096dCtSUkFBR0UyWlh4dk0vUnNkZVR2cnVZZ21Qckc2a0VGWVRt?=
 =?utf-8?B?TUh4N05Mdkc4MTFEbmMzZ1Nvd0tNRUFveTFqOWVqNVYwVFpLRlhFRVZKdE9r?=
 =?utf-8?B?U0J1T2FEblRyMEIwVS85bWR6elNNY1lZR0RHelRWZS9wdklVdnQyM0dQenhP?=
 =?utf-8?B?VEdLTFU1QTQ5SGpwOHVpU2tEcVhzQUlVK3ZUejZoY2k4dGV0Q01BaE1tYVYx?=
 =?utf-8?B?VEV3d0tya283UDdId1NhUERHdGVlS0pPLzdXNVNMMlVMUjR5bEh6bm1KbzJq?=
 =?utf-8?B?UjRGYXV4ZW1TMlBXUkx2THBpb1BFZFE4U0p4UEloKzdsMmxtMXBIb3FIeHhZ?=
 =?utf-8?B?Rkc4SEhpQ2k4UDFMWjNiSFFjRTVOWmg0TVo2ZWgzRnVzbFpoYkVQSG40SzZj?=
 =?utf-8?B?U1VuOU9MVVR3VHkwWS9EcHJoU2JJVnJFVHhvM29Sem1QbWdJY2hnZ2dpMytI?=
 =?utf-8?B?VWFZNHVSd2lTWFV4TDZDWlYzaitOdXRleUhTWSs3cGlMbGpSV2hjM1FsRFNB?=
 =?utf-8?B?aGpPZG9KVDZqR1I5ZWtqWkVBRGVUWCs5SUhKZ1ZmcFlrWlBIaDZzeDhDMUNa?=
 =?utf-8?B?VkVHVUQ5RVM2Q1hSWFlOYitFVmZ4VU9iVFdkcDBPYXhJZ2tOZ0RUZVdHVUNR?=
 =?utf-8?B?TlVDTlcrb2lxUkR0ZnR2RE9iblByYWJOQi9kQ0RtYXppOUlnVWhzMzhZQUFG?=
 =?utf-8?B?VWFMK01Za0pHN1h6aU01WWpIengwWGV5Q2M1ZzNUemJkek83Q1gzQll5RlRN?=
 =?utf-8?B?TlJJcnBIM2h1NCtNRXdZZ1VkZHJjZTVPM0h0VFAyWHY5aTdkQy96TmdHNENx?=
 =?utf-8?B?UnphanNnTmF5bnorclFPS3EvTkkrdVEwYVlzZW1mdlE2elpVZmxtYVBnamxD?=
 =?utf-8?B?dExOZjVkRXFLSGMwclVyZ3JFUitqVERmaVBCSDh3dVkyTGxYcDlFVnR1L2pa?=
 =?utf-8?B?WWwwMnlxbmw0ZlZXOCt2ZFRPT2wwcCtEMjZXaGtIZFE2TG9uOExQQ2pvclZL?=
 =?utf-8?B?SEUvSVJldE9hNDd0UnBiNE5nenQ1a1Joanl6a2VKNHVpaFJ3RERuTWVyTlZS?=
 =?utf-8?B?TDNaTC84SGlPZTU2ZW9CdkZEbDFMZ3M4bzI4ME0zWWovMm15YXFRakJCd1o1?=
 =?utf-8?B?VEgrWUtLMjFaWVg3TmtiNWhFWEtqV2lGZ1VBVHNYbU1lVlVzWUhyQzJ0bUc0?=
 =?utf-8?B?dlMwaTVMRnJmbXJvSDhPT3VjeDJPd3J2aFdEdmxKd1pTa0w1Nk94R3VNQmcx?=
 =?utf-8?B?a0I2bmszM0JiVk1hc0o2TU1wTTFCUk03akVPM3FZZG1vbmo2OExDZk5IeEdj?=
 =?utf-8?B?Tk1kL0dNRXdnKy80MXZaS0Q4WGpHUVQySTU3c09tN3ppZnpEbFE3YXYrSjFJ?=
 =?utf-8?B?YVIySjZUS29BOTNXbXFLckxkVG5XK1ZaS1hQajcrRVhyVVdmclRlbUZ4T1Bz?=
 =?utf-8?Q?kW/iGW+aGp+WMxejzL3rw9Xri0LsNGBi3Oabu/owhfL7k?=
x-ms-exchange-antispam-messagedata-1: CsA2yIaswPyiLTRTx9TpFAJpgCnMFugRLr0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9A25FCEB908C84C81D776DC35B5E922@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	engR/8Kg1F14AnkZY+3LXebhiV0oAz4nDP5h8CQO7rjREvmQKy3SXygEek4k3/sSFBCO3K54umeUStcvQihrpfgF1X5QUGn/f30DEcx8W9O0r+O4EmJZEzuHfkh1jLFHXIk539ypDYmSJUqoSgPvstz70SL3qxYVrmCnpytm4pgxZbxh0XX+/2T4x0ZPy1uOS7B1sAZG5ws5zNAkEmxUqV6WVAr1py2PQXyggXmOMEtSSob5T78H3dSx9Ga65vU+WqTz+yjm85hCXFIVQZs43YM/bGkn4GeIqjgvc8s1VhQ7YmgDsHJMqqZpDk1eo6WoCNxuAGOVJwCb4Liyj7cXYmZCRm4PPgAhfTbDyS+PbPZDiRGxdd+FhZ9lmMK6YHGpdP0X9rKMvjXIA7MTGQ+7LET2DG8QmN4FQClfyufqNJCYAEq4sgzFdzXMJiUy5A/xjOQOQgV/z0pQ0SRklnuWQ/A0drpli5qVxaQlOUP0D9T63Fv4errXIqQkAbIrvzD5NAHmnIadl3Q231FWZ3KJ87hguYIcvLe24VU0AqB1dRRYZnlhfbGqbybMw6l3R/uG8njSBx/AEDXoekg5UrmLPFw0onr2zPQbkqBupXmyXPUE1IZFw/17yzcaPjhOq4ck
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67dc32a-c6ba-4446-c59b-08de746108b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 11:28:43.9175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocRrVwaBr1d6hLi7NIlYQhTeLhV1xpv8TLeccXCj7EzHQCCICNjuJiLJk2M98v4cY7SnVTwrnT/lq+Zr7pazmnjSGVl1koHqwBzEs+Cn05Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7471
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21916-lists,linux-btrfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[harmstone.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim,fb.com:email]
X-Rspamd-Queue-Id: 944AD1968B4
X-Rspamd-Action: no action

T24gMi8yNS8yNiAxMTozNiBBTSwgTWFyayBIYXJtc3RvbmUgd3JvdGU6DQo+IEZpeCBhIHBvdGVu
dGlhbCBzZWdmYXVsdCBpbiBiYWxhbmNlX3JlbWFwX2NodW5rcygpOiBpZiB3ZSBxdWl0IGVhcmx5
DQo+IGJlY2F1c2UgYnRyZnNfaW5jX2Jsb2NrX2dyb3VwX3JvKCkgZmFpbHMsIGFsbCB0aGUgcmVt
YWluaW5nIGl0ZW1zIGluIHRoZQ0KPiBjaHVua3MgbGlzdCB3aWxsIHN0aWxsIGhhdmUgdGhlaXIg
YmcgdmFsdWUgc2V0IHRvIE5VTEwuIEl0J3MgdGh1cyBub3QNCj4gc2FmZSB0byBkZXJlZmVyZW5j
ZSB0aGlzIHBvaW50ZXIgd2l0aG91dCBjaGVja2luZyBmaXJzdC4NCj4NCj4gTGluazogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYnRyZnMvMjAyNjAxMjUxMjA3MTcuMTU3ODgyOC0xLWNs
bUBtZXRhLmNvbS8NCj4gUmVwb3J0ZWQtYnk6IENocmlzIE1hc29uIDxjbG1AZmIuY29tPg0KPiBG
aXhlczogODFlNWE0NTUxYzMyICgiYnRyZnM6IGFsbG93IGJhbGFuY2luZyByZW1hcCB0cmVlIikN
Cj4gU2lnbmVkLW9mZi1ieTogTWFyayBIYXJtc3RvbmUgPG1hcmtAaGFybXN0b25lLmNvbT4NCj4g
LS0tDQo+ICAgZnMvYnRyZnMvdm9sdW1lcy5jIHwgMTggKysrKysrKysrKy0tLS0tLS0tDQo+ICAg
MSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9mcy9idHJmcy92b2x1bWVzLmMgYi9mcy9idHJmcy92b2x1bWVzLmMNCj4gaW5k
ZXggZTE1ZTEzOGM1MTViLi4xODkxMWNkZDI4OTUgMTAwNjQ0DQo+IC0tLSBhL2ZzL2J0cmZzL3Zv
bHVtZXMuYw0KPiArKysgYi9mcy9idHJmcy92b2x1bWVzLmMNCj4gQEAgLTQyODgsMTcgKzQyODgs
MTkgQEAgc3RhdGljIGludCBiYWxhbmNlX3JlbWFwX2NodW5rcyhzdHJ1Y3QgYnRyZnNfZnNfaW5m
byAqZnNfaW5mbywgc3RydWN0IGJ0cmZzX3BhdGgNCj4gICANCj4gICAJCXJjaSA9IGxpc3RfZmly
c3RfZW50cnkoY2h1bmtzLCBzdHJ1Y3QgcmVtYXBfY2h1bmtfaW5mbywgbGlzdCk7DQo+ICAgDQo+
IC0JCXNwaW5fbG9jaygmcmNpLT5iZy0+bG9jayk7DQo+IC0JCWlzX3VudXNlZCA9ICFidHJmc19p
c19ibG9ja19ncm91cF91c2VkKHJjaS0+YmcpOw0KPiAtCQlzcGluX3VubG9jaygmcmNpLT5iZy0+
bG9jayk7DQo+ICsJCWlmIChyY2ktPmJnKSB7DQo+ICsJCQlzcGluX2xvY2soJnJjaS0+YmctPmxv
Y2spOw0KPiArCQkJaXNfdW51c2VkID0gIWJ0cmZzX2lzX2Jsb2NrX2dyb3VwX3VzZWQocmNpLT5i
Zyk7DQo+ICsJCQlzcGluX3VubG9jaygmcmNpLT5iZy0+bG9jayk7DQo+ICAgDQo+IC0JCWlmIChp
c191bnVzZWQpDQo+IC0JCQlidHJmc19tYXJrX2JnX3VudXNlZChyY2ktPmJnKTsNCj4gKwkJCWlm
IChpc191bnVzZWQpDQo+ICsJCQkJYnRyZnNfbWFya19iZ191bnVzZWQocmNpLT5iZyk7DQo+ICAg
DQo+IC0JCWlmIChyY2ktPm1hZGVfcm8pDQo+IC0JCQlidHJmc19kZWNfYmxvY2tfZ3JvdXBfcm8o
cmNpLT5iZyk7DQo+ICsJCQlpZiAocmNpLT5tYWRlX3JvKQ0KPiArCQkJCWJ0cmZzX2RlY19ibG9j
a19ncm91cF9ybyhyY2ktPmJnKTsNCj4gICANCj4gLQkJYnRyZnNfcHV0X2Jsb2NrX2dyb3VwKHJj
aS0+YmcpOw0KPiArCQkJYnRyZnNfcHV0X2Jsb2NrX2dyb3VwKHJjaS0+YmcpOw0KPiArCQl9DQo+
ICAgDQo+ICAgCQlsaXN0X2RlbCgmcmNpLT5saXN0KTsNCj4gICAJCWtmcmVlKHJjaSk7DQoNCk5v
dCBuZWNlc3NhcmlseSBhIGhvdCBwYXRoIGhlcmUsIGJ1dCB0aGlzIGNvdWxkIGJlIG1hZGUgd2F5
IG1vcmUgDQpyZWFkYWJsZSBpZiB5b3UnZCBoYXZlIGEgbG9jYWwgYmcgdmFyaWFibGUsIHN0aCBs
aWtlIHRoaXM6DQoNCmRpZmYgLS1naXQgYS9mcy9idHJmcy92b2x1bWVzLmMgYi9mcy9idHJmcy92
b2x1bWVzLmMNCmluZGV4IGUxNWUxMzhjNTE1Yi4uYmYzMTU2MjU4OTBkIDEwMDY0NA0KLS0tIGEv
ZnMvYnRyZnMvdm9sdW1lcy5jDQorKysgYi9mcy9idHJmcy92b2x1bWVzLmMNCkBAIC00Mjg1LDIw
ICs0Mjg1LDI0IEBAIHN0YXRpYyBpbnQgYmFsYW5jZV9yZW1hcF9jaHVua3Moc3RydWN0IA0KYnRy
ZnNfZnNfaW5mbyAqZnNfaW5mbywgc3RydWN0IGJ0cmZzX3BhdGgNCiDCoGVuZDoNCiDCoCDCoCDC
oHdoaWxlICghbGlzdF9lbXB0eShjaHVua3MpKSB7DQogwqAgwqAgwqAgwqAgwqBib29sIGlzX3Vu
dXNlZDsNCivCoCDCoCDCoCDCoCBzdHJ1Y3QgYnRyZnNfYmxvY2tfZ3JvdXAgKmJnOw0KDQogwqAg
wqAgwqAgwqAgwqByY2kgPSBsaXN0X2ZpcnN0X2VudHJ5KGNodW5rcywgc3RydWN0IHJlbWFwX2No
dW5rX2luZm8sIGxpc3QpOw0KDQotwqAgwqAgwqAgwqAgc3Bpbl9sb2NrKCZyY2ktPmJnLT5sb2Nr
KTsNCi3CoCDCoCDCoCDCoCBpc191bnVzZWQgPSAhYnRyZnNfaXNfYmxvY2tfZ3JvdXBfdXNlZChy
Y2ktPmJnKTsNCi3CoCDCoCDCoCDCoCBzcGluX3VubG9jaygmcmNpLT5iZy0+bG9jayk7DQorwqAg
wqAgwqAgwqAgYmcgPSByY2ktPmJnOw0KK8KgIMKgIMKgIMKgIGlmIChiZykgew0KK8KgIMKgIMKg
IMKgIMKgIMKgIHNwaW5fbG9jaygmYmctPmxvY2spOw0KK8KgIMKgIMKgIMKgIMKgIMKgIGlzX3Vu
dXNlZCA9ICFidHJmc19pc19ibG9ja19ncm91cF91c2VkKGJnKTsNCivCoCDCoCDCoCDCoCDCoCDC
oCBzcGluX3VubG9jaygmYmctPmxvY2spOw0KDQotwqAgwqAgwqAgwqAgaWYgKGlzX3VudXNlZCkN
Ci3CoCDCoCDCoCDCoCDCoCDCoCBidHJmc19tYXJrX2JnX3VudXNlZChyY2ktPmJnKTsNCivCoCDC
oCDCoCDCoCDCoCDCoCBpZiAoaXNfdW51c2VkKQ0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJ0
cmZzX21hcmtfYmdfdW51c2VkKGJnKTsNCg0KLcKgIMKgIMKgIMKgIGlmIChyY2ktPm1hZGVfcm8p
DQotwqAgwqAgwqAgwqAgwqAgwqAgYnRyZnNfZGVjX2Jsb2NrX2dyb3VwX3JvKHJjaS0+YmcpOw0K
K8KgIMKgIMKgIMKgIMKgIMKgIGlmIChyY2ktPm1hZGVfcm8pDQorwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgYnRyZnNfZGVjX2Jsb2NrX2dyb3VwX3JvKGJnKTsNCg0KLcKgIMKgIMKgIMKgIGJ0cmZz
X3B1dF9ibG9ja19ncm91cChyY2ktPmJnKTsNCivCoCDCoCDCoCDCoCDCoCDCoCBidHJmc19wdXRf
YmxvY2tfZ3JvdXAoYmcpOw0KK8KgIMKgIMKgIMKgIH0NCg0KIMKgIMKgIMKgIMKgIMKgbGlzdF9k
ZWwoJnJjaS0+bGlzdCk7DQogwqAgwqAgwqAgwqAgwqBrZnJlZShyY2kpOw0KDQo=


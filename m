Return-Path: <linux-btrfs+bounces-16869-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C73BFB5A011
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 20:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC19581781
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Sep 2025 18:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4168D280024;
	Tue, 16 Sep 2025 18:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hBBM73CT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="s7nv8taD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA67232D5A0
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Sep 2025 18:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045939; cv=fail; b=T1LnZs7uADj3e2TrsttNKPLW0d95QQ11s2OqKp076GmutQ7KgxAP52h/wJvn9o8XnwiVemJb3VKPW/uA3H1muW+702J9LV4cF4gKGMNmywsx/yd3u4nCEeKb4mbpY3NTEacvEKM/hl26J3K8YFXy3K8xYWbLrakE9khYhN50S9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045939; c=relaxed/simple;
	bh=hZXE5yCa3g/ujaex7QtWtTAFCvS0q9UEk0hbyNU0ut8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mGmPd9aO86P8DLjXcTZ8rSd5yVDMjD/lZ+twL3983t0/enMkifZ5I1om6bD5TWlH75FFZeVDJIIS8XDrnV41qGNVFQKhaPGP4k5igyS7sgj/lyS3CTIMlSZhA9MvadKFgBVc1N6Eo+e9UmnGI2dBggm9J7YdZgE4ch0yW+uS4HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hBBM73CT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=s7nv8taD; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758045937; x=1789581937;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=hZXE5yCa3g/ujaex7QtWtTAFCvS0q9UEk0hbyNU0ut8=;
  b=hBBM73CTDQhF/Fe3EjnsNAYy1dugmx+HMJOBCAE6wKwPFgpOZu4N+3uE
   1jE0A91ktj7WAmjhliwzcHWhK3uEvuOR6LTbtuLyJPzqQKKYfEeHJ89TS
   cjKxTHGfwFs0IjtDiu/sDMH2LK/DJ83qctoxz8HuxRf4x2fkX2F1twsu8
   neIoZjGze4SVEOuoyphYnSxOvqclXIJW5+jtWDxjsyKMzqptD51JovRQz
   nPGs7G3drw2BzxxNxKgExVD5BiwxoK/4Eyu2fm5OHC5lY4XMx7ZHrQLtl
   JhJC1FqaCmapHthfLGY0i5QifCarF+e0yZPhxP8iFiE0zGGerzGwljotj
   g==;
X-CSE-ConnectionGUID: V6xRbw+KRL+eL96s2HEQaw==
X-CSE-MsgGUID: DIb/1JJ5Txa1uMdho/cmng==
X-IronPort-AV: E=Sophos;i="6.18,269,1751212800"; 
   d="scan'208";a="123465602"
Received: from mail-westus3azon11010062.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.62])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2025 02:05:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENyPdr4mEoQ87aa/puyCOWGYF1Em6i744/YZeEUvzNjzXci4dn3SnfIfc5F9p5oKSBzGYLsxakRjs4q7AT3whru8byu/HspRyIkGspdUkJ1UEPSRRHk5bsK5VdZv7YuI4OKHyQVIuxhh1uUPodV176ic87Gr35kKB2oRgSIZl6flA+g32D9xYHzWgpdoEIBKoNU/B442HrenGysA1TlhFsnQUf4pawUkAHIvQepjP28WkvvnyaBiDkSkRuGReHeitgrf01HHb+kVBWynct+cWMW3CYOfvlT8hRcVLa5V9YCkrudwlOV6s6KwiKHqZCsb2PKhbD21pWkYYEUFdc3uQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZXE5yCa3g/ujaex7QtWtTAFCvS0q9UEk0hbyNU0ut8=;
 b=bQMDK/GUUdRRk9XbRPpUNG3jvkkGn34qraxaO930zJOX3IOO2kYsoWMJi7mP0hkqiVpTFxOeuwOaOrXkBbNLTGS2haD4/kN+Bcrsfs4rm8cvndUROhzP9/7vnFZfN5E96WhamaqkWMa1p4c3G01yKybvBsodDMaMHye2nB28xhlwgCTI7uMMJHTU7LYoRLC3T32ReeTfqyMf04OXaWXbp4Hly6bMh4+bfhRQrU3tlsxEw/wnLs1R36uL0UB5LDLZfyibZxxFju5Bnzzq/dNIqtLULteK2cKQQiggH5T8NHNr9DSFV3ftWiS05+XOFf5/ifYFHPXGhsRGTDLinL/ssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZXE5yCa3g/ujaex7QtWtTAFCvS0q9UEk0hbyNU0ut8=;
 b=s7nv8taDX0pCOfq8Br3xJlhDw1gyUwvWmbJ/iTxwdVTGbOBYBniXZgCV6qawOQQNRvoKqpEf/NfNtMz/mPyLoMvJtc9723X4ExBj6nY6aPtj6DnhisBlDiMwJ71WuEqWl7Uus8KYmpo4ZySWBIzK7zh4IvhF+gDLhBiZaFqjMuw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CYYPR04MB9049.namprd04.prod.outlook.com (2603:10b6:930:bf::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 18:05:25 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 18:05:25 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Yuwei Han <hrx@bupt.moe>, Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs
	<linux-btrfs@vger.kernel.org>
Subject: Re: performance issue when using zoned.
Thread-Topic: performance issue when using zoned.
Thread-Index: AQHcJWG554cLgRNI6kq+V/MRpm0fY7SSfW+AgAGm74CAAA0WgIAB6tOAgAAB6AA=
Date: Tue, 16 Sep 2025 18:05:25 +0000
Message-ID: <1c5e2ef7-f2e5-401d-8acd-0605b117dfcb@wdc.com>
References: <tencent_694B88D85481319043E0CE14@qq.com>
 <873c88ef-ee65-4e27-bc5e-156cf9e79aa9@gmx.com>
 <BD8FA84236613557+a3110e3e-3931-4ff7-a7ac-7347b9808642@bupt.moe>
 <c2d204fb-efa3-420e-b9d3-2ae45b17299c@wdc.com>
 <2F48A90AF7DDF380+1790bcfd-cb6f-456b-870d-7982f21b5eae@bupt.moe>
In-Reply-To: <2F48A90AF7DDF380+1790bcfd-cb6f-456b-870d-7982f21b5eae@bupt.moe>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CYYPR04MB9049:EE_
x-ms-office365-filtering-correlation-id: b88b7338-e34c-4f02-3240-08ddf54b9c83
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MXhnaE02TTFNNTQzNExyY3hHNFhZZnUrLzRxQTN0U2VZQzUvSnREQjZ3ajUv?=
 =?utf-8?B?MXhWeXFOc3VONG1TNlV2Q1J4Kzg2SWhDOWxvSzdJeGw2cVdxbkdkZEFRRE0z?=
 =?utf-8?B?RGwzcVVDNklFdHZ3MTZJVS9aaTFUSk1qejZtclRKQy9iSFE4N09oOHpaaEJy?=
 =?utf-8?B?dnltcFVQM2lPMW9kRUpRQnl4UC9aaUt2SlNjckJmaHo1UlkxbE1oSU1ZbFJQ?=
 =?utf-8?B?SHhkbEN4cm5WcXh5aTBUUmpwQ1d0V2xaZVhWYkZuaFdadWl2dlZZNjBJeVVF?=
 =?utf-8?B?SFBCaC9WUFVUbDVaTGg2V0UzRFRCd1NRTXFPREVIeTB2Sld5MHBEN0ttdllt?=
 =?utf-8?B?ZWxBeXlaRHo0WE9HRk9Zc2RURGI0ZGVnWk1YMldpTTZwcjhjamxRUnQzd0pp?=
 =?utf-8?B?R1BGeTQ1ZDFESmdiZTBMR0dXdzNIdFJnMmdnMlhoZko4V2wxeW1YYktGRDVp?=
 =?utf-8?B?SVJMOXkvOTNMV0JlcEN0eWFvQXo0TGVGVkdNSGtFSEFESlRMTDA2THpmcnhP?=
 =?utf-8?B?S3U4aTJCalJsblZ6VU9yTU11UUF4VzJEN01nS3VOK0hEK0NZTnM2STkxeXA5?=
 =?utf-8?B?VndEUmhjS1k4YnZKU0k4ZTh4YysyN0FJdDN0U3FlYVVOUVYyK293QnA3M0s0?=
 =?utf-8?B?bWtzTUhZV1FVcWdDT2ZzQmg0Y1ZFaDN3dW9mZ05CVlVrenJpdVhObzNXME1k?=
 =?utf-8?B?TXJTNWxLTCtOZzluODZackdGSzNJZnRIblR5dHB4RXNEdWd6WkNra0p0RU93?=
 =?utf-8?B?aU9ybUZJVGkwWWJWeXh0UGRxSWNyOUJhZWJLOEhkSFcxRUtUcjdpbk5odWJv?=
 =?utf-8?B?bHA4cm5yNGNrVDhLSExRdU1nbVRjdkNjZ2hLcUczL1A2UE95UkdNcjlIdE5I?=
 =?utf-8?B?cDdvWU93TGQ0aXNQRG92c01VQnZXSmJ0YWR5eHVJUlJkVHF4TzZLd0lGZDZ0?=
 =?utf-8?B?Z3hzNlFxZ21YNWd0aUN1ZDhwZ0MwUXpKQnR2NWRHNER1ZitJRG5YKzJXb05y?=
 =?utf-8?B?eFo2NjMxUWoxeXFLOTloWWgvV3BueTlmblhXS20wbmExVWZhOXpLLzZDUy9n?=
 =?utf-8?B?czB5TVMxcFFyTkFhVzZnS1VzSERlSlNSSW40VGNFd3ltcEttLzRkM1M0MHlZ?=
 =?utf-8?B?UXdRMUNIZnlIbHJqczU3UFZTVXp2bkpBcUprZEM3bVBwOHEwMWVHREZ2aEhF?=
 =?utf-8?B?clFUMWc5WUhnRUdtNTJFYkJ0SXRDbnFXbGdIRU5OSDJRWmpUUGtEcFRpbjUv?=
 =?utf-8?B?d05VTnhmRkJPSjNnSjAwR3gySytBZ0tqSi9KdmM5MEY2Smx1dERXUkVMSFJY?=
 =?utf-8?B?eXMwVDJ5RkRIcVExZ0hzNmFpMmtMM2tjdmwrbFRhMG1TYW01SkNLWlIxUjMv?=
 =?utf-8?B?SHpXZUszN0NPU2pCWmNpU2F2VGN2Yk43Q0pjdUNmSHRaMkdZcWt3d2IvVit2?=
 =?utf-8?B?bDZYRDh3TGRscXdHS1FkeElrYjl0WWx5NUptRmhnOUZpOGhWdmpYUTE3dm56?=
 =?utf-8?B?WFdDNkhJN3Vsc2haWWdzS1NpWGlzSVo4UFVTa1RDVTRrUG1ETlkrYTRRSkZZ?=
 =?utf-8?B?UWVubnd0bjhoMnJwaStTZ09PZWVJRlhRUGFWMG1BL2lRcldlQytFakc2ZHBJ?=
 =?utf-8?B?RzFaeGx0U3kxeFUyc2xrQzBPcGtCUXBKQVlhWmQzaTNGRlJpdHR5SjUzSlRV?=
 =?utf-8?B?cldsTUlpSEtpYUFRbnROOHJEZWFPOVZtN3l6ZkR3MSt2VXYrVVZscEFEa0th?=
 =?utf-8?B?QUg1ZkZ3b1kzeENEb3U2QkFNT2kzTXdKV2JXVFRvdUhRK05YMVFhQ1IxbXdS?=
 =?utf-8?B?c01HMVdISHR3cWx5aWlEa3B5MTh0ZDJ4bXBDa2pyQkNoWEJJSlNHTjUvODdN?=
 =?utf-8?B?UVlPUVo0ai85VkVwRG1iOWNmQkhKbmdkTnhkaUVMSE5ONGFEMUwwZjVpZCtO?=
 =?utf-8?B?LzNram9UcVIveFNFMmZNWmxMb0NYbkdUNDg4YlZOdWdNdEFyZlRvNzV2enhY?=
 =?utf-8?Q?3LJ+lau8MpZj56DIQt9jalcb9Z//q8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3FlUzB2NHV2d2FFNGVPZUFqSVhWeVJOaHh2a1dlU0JwSWJBR1dubzJWU3lL?=
 =?utf-8?B?MWV3L0l2Ukp6VEVqczkwNTN0VzEvd25ra2U4TkcyWjdRQnZ0cVZhR244cUF0?=
 =?utf-8?B?MzNhbnZBMkhsbmYrbS9CNmxkekZzYU5TVVBUc2FlMXYzSGE0enc2TXhOYUJE?=
 =?utf-8?B?ZVVYckk5YmEweHQ0VUFKeUlxaDgyL0dQd0ZxTWE3eTZ2Yk9GQmhVb0xKVGRB?=
 =?utf-8?B?MmFsMEg3M3MvN3ZsZlEwZURLT1ZHa3hQMkpFQTRwOU1oTkZ3T1BFZ2ZqclV5?=
 =?utf-8?B?TDdFcGErNjhqWTBqLzlwR25TQVlxTHljS25FUTh1Z0U3US9GSDhOdXhLUFJn?=
 =?utf-8?B?MmNGRWMvdlhpVWhxK2Y3Nmx3eVlIcjhYZzV1VmVXWFEvaTJCVlR0QW1ZL2E3?=
 =?utf-8?B?UkFEU2w1TzBtZVA3VEJzb2xUVFFjSUpLazJ5Y044ZWFsR3IzTEpYejA2STUv?=
 =?utf-8?B?ekU0OGo0SGxyS05aZzE5cmZvSnBzb0oxa3cvUHR5L0lPeVA4bVc2b2VmWDJW?=
 =?utf-8?B?bDA3MnVDUmwvREN0VVFMVUxGZkVDOEMwMVc4VktQS2tYSDNiT3Z6L0RNRStH?=
 =?utf-8?B?eUNxdi9nQnZWbk96NnBBOVlyYUlCOUEwWmRDSGJMaXVWYjF2VlJaenE5ZSs4?=
 =?utf-8?B?U1NyWXN2T1o0UEJpbUg5NHlxd3UyYTNwUXR4K1lBK3R3QWNIUXh4MjA5ODVx?=
 =?utf-8?B?d1puNDlJdWUwSitBeDZEVVN1RlhpZFMyd2hTREhRcVcwdGNHcW1tK3lYaW15?=
 =?utf-8?B?VmY0M0VtRmE2Z0puM1FhR2VpRDFvUEYwZDhaZmN6T3l1ZGtUaVVkRHJ3cG1J?=
 =?utf-8?B?S1BKUmFnWTBmR1VWejJmaHFRdWNrVHpuWk9reHZHbFZWdFVNd2M4SzNWbFY0?=
 =?utf-8?B?dHFkM05ZVjZRcGpGdFFtcUFNM05pVlRGR3JEQXVPeHlCT2M0K1J1WlI3eGx2?=
 =?utf-8?B?UDExSlA0YjRZeThDcyt5MEpzY0N2bzlJMGFxR1hSakpZb0JYTmZVSGxQZ3ZE?=
 =?utf-8?B?VEZ5TkFNYmovUEdzdGJzbkZ2RkdHUm9UYnFnNVNOUjg3N2ZNWW10S3U1Mm9Z?=
 =?utf-8?B?ZWxYSzFKTVA5R2d0aG4wWU8wWllCdFFJcnZLdFlDRkhsbm4za3Z3WGJ4U1cx?=
 =?utf-8?B?NVRVMDUwbk04ZDdTTm40anlvdUM0TUIrZjE3K1lndkRiWmI3WjV4ZGMzRGhM?=
 =?utf-8?B?Q3FzUzlHREMyL3p0a01JOEFsUHNJMENxNG42WjFiVmZjUnFIaDBlQk9DcG5F?=
 =?utf-8?B?OWhLcEJiZUEvM2hjSjFRcDdNK2NkRm4wOFVvL1l0VnM2Mi95M2F3dTRyK2lR?=
 =?utf-8?B?cDRaeG1NdW44ejlvdGFXVDRDMnJxeEVXQnljc1lxc2FrbDg4QTlZRlB1OUdv?=
 =?utf-8?B?VnpGVkZYNjVQdzNaRGNyd3lsN0NpWk9mZUZkdHhLYjliNUJiTWE3WjBOM2Nn?=
 =?utf-8?B?M1JEbkVjTU5RSlNWYkhHRHBDekVEUGlPdzB2R3FhZTZ5UEVmUkNSRFNhZUtn?=
 =?utf-8?B?bDdqL290UXZVb0xqYU1acGJBVUdUQjZPSzZ1ZTRjZGJXTGxaZGFTT09uaEFY?=
 =?utf-8?B?SjRRcGlXWlNlK0ptU25RVXpnTjhDeHM1eC9TWXBwTzN4bkVOMk5SWjhqeDZr?=
 =?utf-8?B?eTU3aEcram9xUFlMejZuZVJFcXg0M0ZpSTdJbkYzek9IRG1tem5BWHJsdlRG?=
 =?utf-8?B?VWdGdWlMOUQya0x1YXBINDNwb24rVm03QnVYNTB3RCtiMHIyaS9zYjFDa3VK?=
 =?utf-8?B?elF6TDAxVlJjaHUwZEJNVlZWNGRWNXFxVGJrU1FnbVhnai93bmVKYlNEMitU?=
 =?utf-8?B?UWZ6cUVjbW04dzJpMG1kWHZsSXNCL1FBWjI2VVllOXJiQ3YweXQwNEFYUWtO?=
 =?utf-8?B?dEsyY1dLZWd0c0Rwem5hQmF3SUROK1RoVWhhMnZWb1IrdVNUR1JtK01abUo2?=
 =?utf-8?B?RklyTlE3YVQ4SW9VOGVoZUIrMHpxd0FPMzdoenJXeWdJUm1EOVljVzRZd2Vu?=
 =?utf-8?B?dHoyNTZZdHQ3WmNOdVRDOXhWem1LSDIyTGd0VFRBa2hkcGhUTXJrSDJteFZy?=
 =?utf-8?B?UDZBYi96cXFMUkNLY1k0UjNmY3Z2bDdabm1qS3Zua1VuNzVkeWxZcC90QlVN?=
 =?utf-8?B?QzMvRjMyaFFwdzBjcmR6OFVpcTZPYXVlVWgzeURBbnRTRlVWQzFsU1pnM0NJ?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DC4421086E7CA4A811E50CE17F545F3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1k2TeI8/0o7ZrbkjJBZZdkuxEm1G/SB4+xGC/SnwlKK3ocPsa9JkHk271dcNX5jZdtlj7MWGvYq/oPAyie0JWk5YxN6lIrU4Q1lEly7FC/+xBft9jvrxM7zElQYUsqU5CPBivdIZBmDwJmahXuoYHQMWzWbO7TcOOg9Z7DLoRf60xGulWYyycw+OGrlNr4jKj5WH8TpNoIBTC1K2XSUGN3/J0hEmNOOa7afTEm7Ati/tJmis+hN4D404VQWvIeoKxpe4XAv7dnHzS65oUwhljjpef6qlWD50fzuNLhvWPlk1xnQR5NrUnx0RnVtJq7O24dTgOdbJeS9+TtzqnSUGa9zMamKScATj4pjYoRG/8o0RmkLA9WX4A9+X/wgiVyHRkdPvl7hcK3KR/eX6fvyll3WpHhvkbdggHQjqZLEwpCDpV7qXxH53zAOWOT3jdWQEIoNYUvnEI4f/CzVfJbgAi/+TgKDAip3fGNQOLXk7roRRnK82v7S5c5g+4FXVnhCI3FVLqBXytZFmweaDPnEAdaA5He0QxT88puVSjhB0rqybCVHWZlAvMfl4UWDk19fWI2gLmJ/34co26x5OTe2QQqfGYqRL2Kluw65V5xjc8WFzpGEaamLSE3RLvfoGFX1A
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88b7338-e34c-4f02-3240-08ddf54b9c83
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 18:05:25.3172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7u1anncLj84CB260Hq59YHSpTi6SqkEXIIpx/Q40fkJs9H85VpHZPbQ2qbsLwbm/Pu35bg7RLfnQRzv2dkAvS5idL0KVVoP65IEOOU/oYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB9049

T24gOS8xNi8yNSA3OjU5IFBNLCBZdXdlaSBIYW4gd3JvdGU6DQo+PiBUaGlzIGluIG91ciB0ZXN0
aW5nIGhhcyBib29zdGVkIHBlcmZvcm1hbmNlIHF1aXRlIGEgYml0Lg0KPiBzYWRseSB0aGlzIGxp
bWl0IGNhdXNlZCBrZXJuZWwgdG8gcmVqZWN0IG15IG1vdW50LiBBbnkgZml4IGF2YWlsYWJsZT8N
Cj4gW8KgwqAgMTguMTg1MDYxXSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkZCk6IHpvbmVkOiAzMTQx
OSBhY3RpdmUgem9uZXMgb24gDQo+IC9kZXYvc2RkIGV4Y2VlZHMgbWF4X2FjdGl2ZV96b25lcyAx
MjgNCj4gW8KgwqAgMTguMTg1ODQ4XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkZCk6IHpvbmVkOiBm
YWlsZWQgdG8gcmVhZCBkZXZpY2UgDQo+IHpvbmUgaW5mbzogLTUNCj4gW8KgwqAgMTguMjE3NDA1
XSBCVFJGUyBlcnJvciAoZGV2aWNlIHNkZCk6IG9wZW5fY3RyZWUgZmFpbGVkOiAtNQ0KPiBbwqDC
oCAxOC40NDkzNjJdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RjKTogem9uZWQ6IDM5MDIwIGFjdGl2
ZSB6b25lcyBvbiANCj4gL2Rldi9zZGMgZXhjZWVkcyBtYXhfYWN0aXZlX3pvbmVzIDEyOA0KPiBb
wqDCoCAxOC40NTAwODNdIEJUUkZTIGVycm9yIChkZXZpY2Ugc2RjKTogem9uZWQ6IGZhaWxlZCB0
byByZWFkIGRldmljZSANCj4gem9uZSBpbmZvOiAtNQ0KPiBbwqDCoCAxOC40NjY0MDVdIEJUUkZT
IGVycm9yIChkZXZpY2Ugc2RjKTogb3Blbl9jdHJlZSBmYWlsZWQ6IC01DQoNCk5vLCBJJ20gd29y
a2luZyBvbiBpdCENCg==


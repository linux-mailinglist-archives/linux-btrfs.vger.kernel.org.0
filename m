Return-Path: <linux-btrfs+bounces-12358-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83D2A66B94
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 08:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82E23A8A67
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 07:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FAF1EF374;
	Tue, 18 Mar 2025 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="br9gCyNt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UhVrRYed"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E871A08A8;
	Tue, 18 Mar 2025 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742282868; cv=fail; b=l6x8G7He9p6DClMBAy3USDzhJaFMhIsla1mFiq7JF4BMZelMxB28kKKWzSZv6EIuEkIF0psJKFW71LBPwakRO7Wd+gwCtAN2gOEykAiL3zpZVQJqfG7SPVvj4zvtRdJEBHoEUN4JTOD3ipzSpNU8C+4jEXRP8UAgysf7XORSDEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742282868; c=relaxed/simple;
	bh=5DYdUOTuGZ/uyYF/KuPNRmRLSxjKlFnytjlto1LLg2c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A3SSzmOw0Q01t6IdjKZTqKVVef0166Toa6Z0VRKeuWL5lYbEAvv9ETCkYAJZ845FUMEFf5gqPddsdZGkHL7NALIXK1dL2YbGEBg1F3ARX7bahy025fkosLGQSs8JaWWlUrA4B76FamUeN8w6479HvijNSX6k2r7XolztD5XYPHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=br9gCyNt; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UhVrRYed; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742282866; x=1773818866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5DYdUOTuGZ/uyYF/KuPNRmRLSxjKlFnytjlto1LLg2c=;
  b=br9gCyNtcZJWofgWke5amSugVihQh+fpIVsUhVNiu5jb2bwWNsdMee86
   hAHXG7UuahTRg24qZc/IxJpWN9Fy/vozmYohp4TE+Csj0dO8lg7bo/EkV
   JYot7ILtGqB+o8V6FNLCUom5lSBkBjv1UY9vEjAlo/YNbZWjb4eBN+57v
   xYFdQNI4eG6XsR02RL7vuaw63Qb8cQp3BERi4wF1pyLHJvINr2aNo0BYe
   lilvKv2zYXbuZjFDrvONhUXsfg57z0oW/AW494h9np3QSOm4sZB0SFa26
   rF7RH9bEUUYUDIEMc8v3RJ7eFMSyqsIgIZ6u4jvbP2ETXt969Pd0nz5km
   w==;
X-CSE-ConnectionGUID: 6N7bCaZ1S1GVbubD7CFRXg==
X-CSE-MsgGUID: qTgPLM/xQByZ9Kcfog5GHw==
X-IronPort-AV: E=Sophos;i="6.14,256,1736784000"; 
   d="scan'208";a="54972680"
Received: from mail-northcentralusazlp17010002.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.2])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2025 15:27:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjkx0ZM/q4m4X0d2I7p48UdfhVulggTozWNjxiZIQmZY9ZIRjD0MbpOrLANz22ryYGV/GyiiFFBAelGYzGnCeGgxjNsL0UReQGGMOU1J2cJpLmGIEHHPwi6WTl/I7Bb/g8rSL0QbN6XXcH1dCvbVF2lr55Sx1MVyHRn8IfKvTZS+QyDkz8ZyKoIcty9pso+ZDiNIM4+papdLwG/XFduqP/3Prf/03jth3v1plIZH0x00Ltkd6Ch4S5WhoIBnSXsITyN4sAVyekJCqLlOFsfcj9u04ylTrjv7LduLLn8YcxQyMCxlle5GexL3YFDecI1ytMW3WRCef4UamBcM82g8ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DYdUOTuGZ/uyYF/KuPNRmRLSxjKlFnytjlto1LLg2c=;
 b=b6kbfLtm33YNqUwoN2Q82abrZW5c0kikWSke/XkF1Pq9bpLIknV8fXayRxlKJK5Np+PO36p4jHYCEYM+ksKgJez8+VcVM3lvDN2GrVplAZnb0OjJOlg6hR9xpcQarAHBztFcxORTlZkvVXpDr35w41fqOIRMu0kXXQmZFDKSnsI8c5mQz0ADg19BRAnCyQ4AsfeieZxqpYsxr8YDAyyYcPt1Y/Il03dyXHLLxYb4VyGs5jRITmY34X0w+SW+eurS2xAravEQOVNz8eHbFlUQFzbk/DeruUV1CPjt8SMb0Kp0TBDJzbyZggeJ2PwWn3bbPsBZ4mo2zQSqo6Tb26TOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DYdUOTuGZ/uyYF/KuPNRmRLSxjKlFnytjlto1LLg2c=;
 b=UhVrRYedh8h0qam5UPUyvbLi8yQ4KitQKEDYW44JHIu7+zFtLBFoJ/pGkloF1RrlXTSxY/1auUn0/7GQu5fAbRjKKb3GgO9iS4LHd1NzJ2ALf07ckPXyiQuF//Doo9YUo3GMTOmNIV9+3w7rmU3GtPusb8OXsZ2ouWjLuth75MA=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by CH3PR04MB8873.namprd04.prod.outlook.com (2603:10b6:610:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 07:27:37 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 07:27:37 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "dlemoal@kernel.org" <dlemoal@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH v2 1/2] block: introduce zone capacity helper
Thread-Topic: [PATCH v2 1/2] block: introduce zone capacity helper
Thread-Index: AQHbl6EmUFwYupnomkKCqvipa+9FXrN4fy+A
Date: Tue, 18 Mar 2025 07:27:37 +0000
Message-ID: <773c2704-ebce-4460-8a22-ae9ecabd0057@wdc.com>
References: <cover.1742259006.git.naohiro.aota@wdc.com>
 <e0fa06613d4f39f85a64c75e5b4413ccfd725c4b.1742259006.git.naohiro.aota@wdc.com>
In-Reply-To:
 <e0fa06613d4f39f85a64c75e5b4413ccfd725c4b.1742259006.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|CH3PR04MB8873:EE_
x-ms-office365-filtering-correlation-id: 7df99ce5-f530-47d3-4db8-08dd65ee5c18
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a1VyQWUrbkx6SjZCNU5LOVRVSHpxVWZ1OGVhendpcTNVcnQxOWc1c0c3RTIv?=
 =?utf-8?B?NGZtejZ1dTZ5dnBvbS9KNXZkSk9nRm0rdXlqUTBXazlkdlZZaUp3N2svQm5J?=
 =?utf-8?B?NzJELzBWT0hwN3VOeFYyUHZQclIzS2w3MCtzU1lHTHRvTkZLVE1IbElDeXlL?=
 =?utf-8?B?ampwMzEwdXFmWlY0SFJrb2VoUWx0TFVDQzkyMlRFdkYzSmFGZTVzdGF3TU1G?=
 =?utf-8?B?WHpJYWVncTNQUHk0a2tOMVFDSWJXMjlBY2FPSEdBOE81cmpZWWtpZi9Idy9q?=
 =?utf-8?B?djFNWEZtSWd3ZEpnbU42T2pHRHFPZTBTazVJRE4yejhTMG05RFZuRHB1WmFE?=
 =?utf-8?B?d3pVU2hlKzI3cnQrUzlGVTMwWVprUjN0RXM0eUJsSUtmWWJYUUsycUh4VDQw?=
 =?utf-8?B?Y1dxYVhLNEFzWjVocUJqSHZMbGFERnhMaDdicGtUMkVVMHk1dVlTTHg3UFZZ?=
 =?utf-8?B?RWtkWDAyT3ZLZDFyQ3lXaE5xWWFoVnBsRXpXMEcxcDBBMzB1bWpvZ0pxdURk?=
 =?utf-8?B?UjFTdC9hRDZKcGxGQ25UaEE4NXVyR3hQcktBdVN0N2VUK3I3TDdDQ2lvS3Rq?=
 =?utf-8?B?U3BOWTRoMzZWOVRCcVJTbzZEWTdadGEvRkJTVGV0Mlpma0hhK09uK3lUNWNw?=
 =?utf-8?B?WFdPb2NkeXR2Q0lSaXpoYktZOFhUMGdqU0QwTlhsVm1YbzRvdHBhd1JlT1lz?=
 =?utf-8?B?UnR0TE1iUHJIakFHRU4vZTRJbUdPWldZb0ZUdmlZN1NPbWc3dTIrdnYzam0z?=
 =?utf-8?B?am5XV09SdEhuRGFOLzJKK3pVMTZkT1h3UDdWRWh5c2VOZElrSXY5dzNaQU41?=
 =?utf-8?B?alV2QjV0R2dTZnNkL2FrR3JLNDk0eEIvQmdIMzRGSXZsckhNL1BpbXlkT2dL?=
 =?utf-8?B?V011cHFaZUFBSTR0TXpUcjVKSHBjM1ZnTkhIMWhtNmppSTF1R1g1bnZiemM4?=
 =?utf-8?B?c2puOXhNcGRhM2hkaXcrNXZIRWloeWF2UFBsYjlkSER0YkgrajRLb1NVQW91?=
 =?utf-8?B?eVhHYlNwWFBLVjRhY0JSeUxhMWdGK29jZWg0cTlrVFBuWklweWt0enV5d2R3?=
 =?utf-8?B?b2hoeXlhd3JlVDZVd2c1enVESGdQNTgvQjR3UTAycERhd1JxazF2d25TU1dZ?=
 =?utf-8?B?SjhoZVRNOEtoVzhoRnNVSXNSWFZGZ1dQYWRxVUpkL0pDeEVKOWc2anNZbUVL?=
 =?utf-8?B?U3c0TDZpRHRZSnowT25oVjYxYmFSV0l3Rkh1YWZGbHNqTkd0dURTQU9XYzhu?=
 =?utf-8?B?WkdZK2lKdHEvb2VRSW54SVFkMGRUWGllWDMvOThEL0o4V3N3TDNIT2VzeHV5?=
 =?utf-8?B?Q0JlN0JqM2wrUUtreXFWUFRFeTA2T0Zjbm9BRHA0NjE2TkZXQUxYK0F0TlBT?=
 =?utf-8?B?MGhPZnhSRWVrZmpPMXdLek80YW10YzhsQmlDS1BFUmNjTUx6bUtmdTR4aytt?=
 =?utf-8?B?eW5OelFDSSt5N01sM2hmUWtTWXFnMXdZQmhOWTkwbFNhUU5WRmZQck8yZkox?=
 =?utf-8?B?ZVFZY0lzWDJvL0xhRDFzaDJxUXNhcXRVK3ZoTDNMaFhwVHpZaTdkdGxaUC9i?=
 =?utf-8?B?RFdMMEpEQU5LR0x5OEVvM3BIK2d4aytvdExncndqVmVQaVM0OVJDZkc1K2Z3?=
 =?utf-8?B?azhxeVpmbnZObXdXbndiMUp5U2MyemtEMzBCa3Z0SW16U1RpK2tBYkhRK2Z1?=
 =?utf-8?B?eHZISTNYLy91MXVwMFlDZkR4RU5yZnRDVVN3c2VkNXkrWitjNE9KS3l3L0Jq?=
 =?utf-8?B?dXlyR25SN0E5bnBaZkFTQmFqNVp6VlRYQVdNRHQ2WFJ0alRjSzBCb2ducHd2?=
 =?utf-8?B?ejE1eVl0M3lVREwxMUQxVDNhNkdHZ2NsWXpCb214WDdqcjBubCtoYnp0czJy?=
 =?utf-8?B?ZnNZY05mSHhVQS83T0lyRmo5VmNGUlFKNGRCQ2FmbFR1TkwvWUo3SWQ3Umtv?=
 =?utf-8?Q?MBt0VVQVOv3AMTqxqeKDcP1ih7jzY+XU?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anRmZnNHbTFpQ2pudVRONk5jVnVIRDZZa1NvVlFHSHdIeTd0VkJtakF1dVlu?=
 =?utf-8?B?RTRFbGVWMFo0Y1lzYTRsbDJrODFkT09mTEk5Z0Z1eTZKRENCMkhxT3dQS3Bx?=
 =?utf-8?B?VUszMWE5TStpM05xWEc2MTV0VEZNUkZQczBLMTR5U2M1MlJhQWVaTTdKdDVJ?=
 =?utf-8?B?eUVqbDg1VFhwQ1VjN3daUDQzMk41OGJLdzVzVmFsbU4yN3hjS2pZb3RwVDdG?=
 =?utf-8?B?WFYzUW05cnRRUmZ1OEpxcXZ1QUxtdnpZc2lvVS9raHBNanNDKzYzN3RUaDls?=
 =?utf-8?B?b29rMHpGQzV0WHFrMzdJelhrZTBOb0lqSi83YnMwOHMyUzZ3VG1LdXh4VEJX?=
 =?utf-8?B?VVpOZkJnQ3o5V1pMSXdISVdQUDA4Q1M5VjFiWlQ1MUh6L2M5K3B0WTltc1Jo?=
 =?utf-8?B?OVJXVjY0YmNLbTFQYXpkR2F6aW10QjdObkJaZFZmNE03UURwL05QbGcrVk5Y?=
 =?utf-8?B?bHZEcUF0ZEpGdGtzRmtUK0lKQWxQYkd4bm5yZVoxLzZLWW10YUNNRGJQNFVy?=
 =?utf-8?B?aTNsZGtzWWZjMlQ2ZVRkS0R0ays5TFV0cXBPZjh0RCt0bGU3K0JSbjFBTCtH?=
 =?utf-8?B?cFZJblJBSmsxWjJpUndjdjZFT1dwb00vRWh0R3psTGpVclNON01jcTlKSWxG?=
 =?utf-8?B?ZWZ6eTh1YStqYXYyTjdzUGR6UjlPVDRvWG9KMWpJQy9BRS9ERWZxbFV5N0VT?=
 =?utf-8?B?L0pxK0lRQXA3T1pQM1dSY085UnMzN3p1QVVGL0JsL29GZVJ5Wk9EeTQ4MVdG?=
 =?utf-8?B?S0J0Skc3dm1tR2UvaDBlNVlZeWxoVGUrWGJscFJha3Q1ZktJNVJoTGtqb0tu?=
 =?utf-8?B?WWd4MlUyeHg5M3pLam5zZzI3MkxiMVNoYzhweFQzbm05RUN3TTV2QVhnbzc3?=
 =?utf-8?B?TXNoOGFCenZocDVaaXhiRTNxMUlGRXZFd3NxN0U3UGw4ZmxENGo2b05IMENH?=
 =?utf-8?B?a21ub2ZSR0Z0eFRibmR4MjhuTTVFOGZHdGgvWjQxRXlrc2pWYXBMNFhqVm5T?=
 =?utf-8?B?MzBZcmp1NjU2RllFRGNrbWpiTXNPQnI0OXI0TzFKamRTU09qTVZ1RWw3dFJk?=
 =?utf-8?B?elFHZnRweUcwRXFRbUhJMjRGODVMUWJjNjh6ZjBCWHIyWlBWd25qbkhJL2Nr?=
 =?utf-8?B?ZElScmxVVDZGQW81UStKM0FwdWRXOWIxejhhazJUWk5ZUFFsbm9zWFArQTFB?=
 =?utf-8?B?NGVZOTNZZEM4c3hWQzFWOXE5d0tNZWlSajdRZFpQUnI0K2dRUXdhNm9Jc2dE?=
 =?utf-8?B?Q1VwSnVnMzBoRzNPUUlPZzNRTTlYQ20xeEFMSFh0Q2wybHQ3cXpuTm0yZFJn?=
 =?utf-8?B?YTJYVW1BeW51SjJQTjRpSHNPWkxjdThpbkVCT1d5dWN5VitvSHNxa1FuSWtV?=
 =?utf-8?B?ckFhbTZsZzQ5SHJpM1EwM0QvcllRc281azBEZitEbEtFU01Jdnl5SEJTYktH?=
 =?utf-8?B?QzFqYytiM3hXOVRBamVocVBCcUpkQ2h6eTBVMCtoN3RDWEducWduWS9ObGRL?=
 =?utf-8?B?SUQwbWwxUXFFTzJvbjFGREJ6cUVHZGlEdUxCYzFodWFZUFdTUXRsRFVISTZN?=
 =?utf-8?B?Z0wvb1RIWnVsRnVTYm5VaEl2b053QmFJbGl1QVhNaE56bjF1eTdFeU1teitx?=
 =?utf-8?B?V2xjeFk5WHBDV09UQVJlNWM0ZzZVWmsvMGRLR3dQeitlV1dhM3daRFJDR2ps?=
 =?utf-8?B?TUtQS082YTJVK212azBNRGVPZE43WWo4Ri8vYUlabm1xUld0R2JtZkNJVGx2?=
 =?utf-8?B?cHA4Ujh4K1NsUHpuNGNRbWhVZGZBNklSUjFsd3hhbEFOSGRBUEVNZ2V6Y2lm?=
 =?utf-8?B?aWJzc1RsYVorL3p2RlVUejgwSDVvZTVRd2tHK1QybGVJU1h6dEpRc2pLOEc4?=
 =?utf-8?B?V2owdERlbHRzOVlOOVhXcFdLWTYzTitiZDZkdStBazVFWkswS3JoUzJRbGEz?=
 =?utf-8?B?TEpjWmFLVVEzOWMyMm1LNlBNTWFweWpzTUR2ODBjaEFYbnRkWGpSRk1vN0pQ?=
 =?utf-8?B?Y3k0NjYvUXN2NlNTVjBtV2xVSUJWVTRHUVlIcUJZSW11ZTFlbVZGbHd6Z1gr?=
 =?utf-8?B?OHd0SXJzZ1RtOU4wVDRpTHljZ0VsV0ZRZHRWN2NjTlJnM0hwSW5UK3Ntc3ZK?=
 =?utf-8?B?L1JQUWN0c2UyMGdiUWRGZUhaWnhMbWlLSVpmZlU5cU1iSXh3OStTNnRZNkJh?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F53209063ABDFB46AA26FF6724585FC3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1gj+MZRKySDAHX3B+QLHYjXslYnHZRoRfkv9mkIEH4R83fKod3xa9ROc6ccnXCZ6HlE2CycsuqUM0D64Po6fB//cqiJcFVXh7KtDtCxr1V82yF1MEXmaUP1mf8Rr9WVXWlpkVUdZSpeP/KRHuCbgXXhDB9COibKM5lwJJkiq1x9j1cZDJEgBakydkvpTDdjx4lWWBATXC7E3y2m1uWTbfxZzzUGUQfXqRH6iZrcEGHOIKzM79uuMkhxONK+W9YQaOoa8VasucLQnJqP7OqIpu5XLqLx4O75ubnnPu5jtrVq99UzT/v2FSJv8Dp9pm4LNVebb/4u5ly48FxzDlTSCgHtGM+Q1U8NZPB2kEzG2chM3xRM/SIVDPDd8ZL7w7Ke0eP2PT0afFyIHszYINhFSWIsl+1dwAEySNafb+a/ilSRytXgElhIH0NGyf/Nr57hb86Kas00fj8QcdTFD8a0u6Tq2geCHiwzmu9gO4kqNZfjrH6y3H8bEHlLmZlRRBsabAgY1kIMvLubA6E35jtwjqVRROHm+EBHgaftX2CLS6oPaEMB96Dh1U4uOG/eFr6YM9ihkQ5q54k/Vnw4jlEQq4kpsHtqNKZK6zaN443xbg5FjTVNBNlOQa15nzav3Pt9Y
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df99ce5-f530-47d3-4db8-08dd65ee5c18
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 07:27:37.7919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FGpZvp+OARMjlpnavWnhArLTsXuIaiQ7iJ3+2ZLoRBSZbnmo+Mz7arUOqI9fyDNi0xDuQwcuvKSfLHeqfvI9doo07MNrgLi3t66kEUWXlsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8873

TWludXMgdGhlIG5pdHBpY2tzIGZyb20gRGFtaWVuIGFuZCBDaHJpc3RvcGgsDQpSZXZpZXdlZC1i
eTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==


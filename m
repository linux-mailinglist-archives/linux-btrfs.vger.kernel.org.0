Return-Path: <linux-btrfs+bounces-9586-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2979C6C73
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 11:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A7C1F23049
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 10:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63BF1FB8AF;
	Wed, 13 Nov 2024 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OoRGkwvU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xPWxDe5p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4899E1F9A8E;
	Wed, 13 Nov 2024 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492654; cv=fail; b=EuDYwicWfGXLM9mg2VbFR1I4YMww+aWuRqy/x1AjtyDtAhNn44kQ0k62Xl8oagoTVMGalwVp4wjqI825r1lEoDuph7g/d6tAVuL83sm+F6FekbBbJvwf3IRZopZDWwALp+sYdUck9eqQXKh89xFYz/iKWA+E8RxvnQp7OF10QBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492654; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=npHRY8gQ10+ws8KvAQKF1uSXClC32dzCAAv+ohX2yzQp/ke61wat0oPaXXpDXp6gYMaa7Y++3L6bWO4LRzz+cdoffgtgUv9URYKuJ5wejU1UoKFCAloGT3DrQD2FJVVWPb/sx4Guy3mA0/3RjV/iGBUdzCcUepo5DMJlcnQdq0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OoRGkwvU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xPWxDe5p; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731492653; x=1763028653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=OoRGkwvUhX1zKCbCmgj2oG2PbR/HErfR1yYAaV98Eq/sE4BywE/oCYGN
   6GUPrMPB2Fw06mQN6vrajET6T+g0wawPZEkOMvNFycv2Z0ykjOiFTprN4
   /32tvz7D7rEwS4UBkUtcW2axmk0ezv4woWtJANAvHBG3Rm/f6PWbMouLX
   5O/NiDXmenm1qONM+wE/45FWE+PpGVsJYVqddVtXRy7ET0Zwxf0S2iuxn
   PcnJSlT20i0lySg7XrQqxokxi9+h4C5Sft9PTkXfRbE1X9tSRZQnwU46G
   v6yHhRbtv+7ExByMO5tcbIvIHWxi5QzkGk7By/jxazl8irW55eZrwxRKT
   w==;
X-CSE-ConnectionGUID: 2QWwRB1FS9GgO0b3KD9TEw==
X-CSE-MsgGUID: W2OyYhdlSsOpGWJ+milu1g==
X-IronPort-AV: E=Sophos;i="6.12,150,1728921600"; 
   d="scan'208";a="32367900"
Received: from mail-westcentralusazlp17010004.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.4])
  by ob1.hgst.iphmx.com with ESMTP; 13 Nov 2024 18:10:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvKKhuLDC25SIH9zxOSwZXPLoaiUJR7v6/hKlQm9HsW+SGJ5hi00VOKZSDMA8wLDXcMO8hy8N3ufsoxdw27u6ws3ysHeP6T+DQc5iJSEwwBqxzOqFzNAj+7bzUXsXdFc4KmU55rrmGEXcAGGZ369oC9DoF86EduHWgNScnI+pIWGkDCTirKWXKKf7+12YRp49Vj+eWH4VeFFuxiI6TGImvy9aisKf9yaMYVbwufpzRqL6McfG4MHUnUNE6nNApBsBTi3rveL71JGL6SwWXk4NEFlou7k25IwjvrmJbOv8H3d27K03zDX9NUlHKWu/YjBM7ZvCmN4yWEk0hcfHHPFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=uiASQTHWryZ7NNnBuDnkxzkQRtHqtTK764xA1wo2psBTbzAdfreOhdZuLStaHGPAgBPApBAhP7wqVoimxkdV0zI1lqK5HTWaKtZKw5pXLJIAlgsuc7i70oVcS4JHoWDzEC5VyhZdDiu9wNQITYIxAPfbwLotruylUNY2+pe5CatApjVhFkgO8M9V3uhUoKDDXsxzEYwOEjR2rKoSAkjfj/R2P9li/RyUpnrigZPDhqkulJ+fbabcixDmtASXsnplBgQEpNFml5E4PpZFlSFMvI7FK0iY8P5xOV1y0pj15NJqfCO5X8c+VkgFAK45kTtd9XKaap+KA/Zh34BWssMakQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=xPWxDe5peqhfi9uMT6G9s7g/SjHyIsKGYZL7n60A2NJUIzSHBMEzNA+ZXr4fIa3ipIW9qtebkv90p6lEjmWw/7i+IushoOma2KE8CfK8MusvwAQkTt8SpPhvSd/HuohlDa8LQ/pZUWwXJZ4NiDdnzANXX9qx4/Te5JfA3tZBgRw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8474.namprd04.prod.outlook.com (2603:10b6:510:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 13 Nov
 2024 10:10:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 10:10:42 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Yi Zhang <yi.zhang@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: validate queue limits
Thread-Topic: [PATCH 2/2] btrfs: validate queue limits
Thread-Index: AQHbNaiCEag0ntRWSUeslzorY5CYXbK0/UYA
Date: Wed, 13 Nov 2024 10:10:42 +0000
Message-ID: <4f2a69d2-9d34-4d54-b08b-251e3c4e5a55@wdc.com>
References: <20241113084541.34315-1-hch@lst.de>
 <20241113084541.34315-3-hch@lst.de>
In-Reply-To: <20241113084541.34315-3-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8474:EE_
x-ms-office365-filtering-correlation-id: 08457e95-84e1-4bd0-6718-08dd03cb6ebd
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZkwzWVh1RWpDcG5pNDhGVHZxWDRSUk0rRWRNb1BYOVBwVFpxNk1JbmVUVkQ2?=
 =?utf-8?B?SHk4MUU5MjdhZHcwV0dlUFBISWVGTzdVWEhTbnBGL3Vjd1RkVFFiazdrSmg2?=
 =?utf-8?B?NjBSQzdTbjljYldsemFadnYrRzhVeUl2MzJWQjBGcGVhaEtBa1NLSnZDQmdZ?=
 =?utf-8?B?WGhlN3JWbUpDWC9OT2hDeHU1RHl3d1dXNFlZYnl3QzlqNzVNRThDeGYrdERT?=
 =?utf-8?B?VkloNXFoNjh3TFJIenRlclVrVVBvMHNCRmZEVFBoV3dWVU9YUHNKNlg1bEJk?=
 =?utf-8?B?RmQ3OTVIbm9IR2tkN21waWNNNnFHS0h4N3k1V0J2dTZIQkpaeWhTOHd1V2xj?=
 =?utf-8?B?N3p4VkpWTnBpYjMvaTNDdTBwTWovRVJ1YmhQRjVTckQ0WGRwNVJKaWNBUzRW?=
 =?utf-8?B?NWZLdWkvNGU3eDkxU0wwclRLbURUQkRXZjdGSHRKbjJuZDJ0c2M5UGpQT2ZV?=
 =?utf-8?B?akZTanBUY0RyWnVsZVhhbldVN0JCRWRwSlpNcTd1MWR2bm9sb05yU3pQaE1P?=
 =?utf-8?B?a0krRnN4eVNyNFVqd2dkeFc1ZVFxOUNlSVh4akNaZTVobGpQZjNheHpGajhY?=
 =?utf-8?B?eDF1UXBscnByeWtqU1dzMGc2QVk4RTJNbjdQWEdseThuYkhHMnkxZUFzTG5k?=
 =?utf-8?B?ZjBuNFowamN4KzNMd3VsUnVzQ0sxczFENjRaUGt4RjVRSytqbjFQall6UmRE?=
 =?utf-8?B?U3AwRE9iQjBuNCtPTDFzdE9nbVhIeDg4WmZuMWNwOTJESDVaV3FaNUZJcnBE?=
 =?utf-8?B?a24xY0FvRi9NUkwyNVExNE5VVCtCRWpKOHpuRUlOUUpUUll4NkUvaFI4cUNn?=
 =?utf-8?B?SXgrbzdacktqejhzWnVJY2xndW5pL0UzeDNGRTU5SjF3YmFBYXNyUUJVOWxu?=
 =?utf-8?B?enBwS243VGphdE1jYUtaa0dlbTJPaXZHbmFLWmFpNG4wTjVBRGdCaHFiZEZI?=
 =?utf-8?B?UG1CY3V3a1dzb3R4OEFJaVNtTVU1QkpFM3d0UlZFc0lsRVQ3NlNhZGliZ0l6?=
 =?utf-8?B?UTlFcStoVkdhVXVqZ3JVNFhVdjlaazhiOHUwQ0V2b0FBQUlHK2RQSG1aRE4w?=
 =?utf-8?B?WkZ3RDhTSk80T1JtcnN1Q2FXZjdBVWRVWklrdlVQbXNYbWdyeXZnaWpyeExw?=
 =?utf-8?B?bWZqU0trSnU0T2tLSkJYOGJhRWFxUGlhdVhySDI0QlNQdmFBVWdGZzJBbmdS?=
 =?utf-8?B?c09QRDBOK21rUXdIU2hwdXNSWTRyRndwcElxUDhqMVNFWHk5U2Q4SnNkbDZv?=
 =?utf-8?B?Y0xUMTNVb1Y3eEpZUDdzMXlUcUluVTFKc2h6Qmw4MkJPa2U3SEdLeHVrUmo1?=
 =?utf-8?B?ZnYzNzFoVzJORFBsWVVDRk5zdUNCNEU1VnY0Q1M0RndxWXM2MWhaUVgvUzN6?=
 =?utf-8?B?U08yWi82L1JVS3JlbDVVU0VnemhNb1BUWkpHVEk1Vk5UMjVKRnZpdG1ieGZ5?=
 =?utf-8?B?VkxrVXVWRS9tSEtrbUtJbE1BcVhpd3ZCaVIvWTNRUnhqc21QcEc0Ti8xRFRo?=
 =?utf-8?B?blRVcHNzY3R6dTBpL0IxMXYyVHR0QlhkL0ZlR0xhZ3VKSFVaSm9rclZ1RkJP?=
 =?utf-8?B?QmJQUGd6WlFmclNralRMQUtlcHhCRzVGd0xGcURGVlRyR296T1prME5rTXRt?=
 =?utf-8?B?TFhzcCtIM0JUeEl5aFVTZU5mcms4WjdNc05uUlo5LzBCb25QdndxLzlyNm1F?=
 =?utf-8?B?ME9YMFBDTW5OVi9leWRkSm9ub1NER0h1RzN4dGJzTTF4eWlZRXk0SjhINmhS?=
 =?utf-8?B?RGtCLzlxTllMVnQ2UkYybG1IRW94V3IzNFVkWTdCMnJuMGIyeGZ3bkhPdTBN?=
 =?utf-8?Q?X5y7OUiQ3zgSvQnlDP7Ni99TErqw1qSoif4Y4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFlaN09TN1NRVWR5dUFTRFN6N2FwODlEN25ZZStjMzFqc2VHRDk4RFh1bmdu?=
 =?utf-8?B?QWJaWW9QeUFCd0pieHhlZEVRY0dkY05sa3MzcGhPU2czanl1MnpGeS9tdGFW?=
 =?utf-8?B?U0pZVU5XZ3RtU21hWHBsNUYyYmY1elJvS1czdHdoK3ZvbGNvdnZEdUQvNm1S?=
 =?utf-8?B?WDZpMDNoMlhkY00xUmdPcnY1a1lwVlcvY2NMblFyZjdUc09xYm5OVDBLaExk?=
 =?utf-8?B?N0kveXAzMDUwSmhHWnB0UVV3aVU3Nk1sYnVmTEVsczRqUnhPa0MwMW9QUEp0?=
 =?utf-8?B?NkFvcFowNzI4dTNVTlhUdE5BMmpjREc2N014eWExQS9INzV4WEk5RktEeE9v?=
 =?utf-8?B?NW8rVXhYWVFDNS9ZMGRMYS9MTFB3dUNIMTVwSTBqeG5YOVNsOFpPNlBpM2l0?=
 =?utf-8?B?YWF4ampJb0x3TnFlUlVXY0taYTRJa203VEdGWkhpL1U1UkxkUFhTM1ZRNEJW?=
 =?utf-8?B?U1YySzc4aDJBLzhZMkk0dHppeU8yaExqdWZIck01SzFhZHJoeXN5RU8wSlA0?=
 =?utf-8?B?Q2IxY2JrSUJWeis2djFnRXM2ZCsySTBzZXBYd0M4SXJWT2xuWnZCT3N4TCtk?=
 =?utf-8?B?NUNCNnFIQkNnU24xY3R5UksvcmtaVXVrU0RNeFZFb2w2S1VFTkRMZmNUUk1Y?=
 =?utf-8?B?a2l0YThiRVhXVFhnaTE0VmxsS2VZK0RMQzRJb20vdXpJQlZNNE5PdEN0NGhW?=
 =?utf-8?B?WHpLWWFZUEhqNHNJQjMvWTBvK1c1TndGUlJRR3J3bWc0TjJvMDMrUTJocDc2?=
 =?utf-8?B?SzU0NVZ1akRlMnFFRCtKWXozc3JJRDRLS0ZWdlBVV28ybXhoUGttRzk2WjNk?=
 =?utf-8?B?VFNzMVVNcW1wTUhxMlR0d1BvK2twRit4cm9nNjl2a2JtdVBxYWp5NmY4a2xH?=
 =?utf-8?B?Q1hyRW1DNmVwNU80ejBRTy9vNFdMS3RzVVdYYk1JSXYzUmJhQ3FETHhjdWd5?=
 =?utf-8?B?VXRXL01DMXZEZnJ1czRUMVBZMis4UkdrOGRZQ3NMekd5ak56VzZRYXNTU1R4?=
 =?utf-8?B?N3E4cFFnenJNdkZTMmRyZDZHVUkxeGVoQ09pbFVWKzFDMkRhQ1pwUVBRVWhS?=
 =?utf-8?B?N1lTSGwrd1kwZWlJanpVUUNYWVB5Q3dmRmdBZ1o0VkpUcGc3OEF0RG5KUkwz?=
 =?utf-8?B?YmExeVBYZkZMZEEzM0tqSGNhQVFmN3VKQ2djRjY3T2krTXduM0E2Ui9KRlMy?=
 =?utf-8?B?ZlIwaEh0NzNaVHdxZWtac3VGS2pUTVorQUszdzlTajk3Yzlmc2ZydWo2SVlT?=
 =?utf-8?B?ZGsrWnhhcmNDeGdWY043LzNTd2RGWmZHTDI2M2EyaEpPVjFqVHg4QUNJS2Zm?=
 =?utf-8?B?REN6SEFLajdHcmQ1RDc2Z21ZZnNIcWxuYVJSOGdKeW5YanVkaGdkU2dsZVNq?=
 =?utf-8?B?QjRhZjB6TGxmWEZ2WFBZejRVckxKczVxcGxUTEt1NThxVlZkRVY4US9EcE9D?=
 =?utf-8?B?eFV3T0VMUnp0K1pCR0NXS0lkeTg2V2hVZHZCWVk4VHBrNW83T2lDZmUxQnhs?=
 =?utf-8?B?dkZjKzY1b3ZUUXd3azBlTEZTelMrMUgxY1J5Y3JBdEdXRU04eHdWekZ3SFJ5?=
 =?utf-8?B?QTc4TzgwOFJHdHRmaHFpcW1vWVdETi9SZm45ZDIyWXlVSXBBLy9PcUg2K2ZY?=
 =?utf-8?B?UkRTcmQzNERzQ1U0RUlDbkpxdGlaMnVCamVqWUdsMzd0dFN2OFE0dndGTzRK?=
 =?utf-8?B?SnFZeEx1ZUlSbGVzYm02T3dhMXVxZ3VEd3RGRW5KbWhVa3hSWHJaYVJNVXhO?=
 =?utf-8?B?ckxUOGRDOXgvNURqZTlnTnNCOVcyMS8zU1A3RDhwNTBObHdVeVg0OFdrOVQv?=
 =?utf-8?B?M0NXcjF4Tlh6cXRuTlc1N05IVjl6WE01RWJUc3hVMjdCWGNCM3IxbERxZHNn?=
 =?utf-8?B?ODExRXJBRks1YzNOMlFZMTkvZzRsRjJuTjdMQkRkY3JKMlM4V1czZWh1c0Zz?=
 =?utf-8?B?TnE5U1V0aU9ZTitSSlJUR0ZKb2tlYTQzdjNJbjU0NHFLbWNtUE9lSCs5L2lC?=
 =?utf-8?B?WkkzWFJZMC9xU0k3YTJYLzdrYXFycVRVNGlBTlhCTE5zM21vOTdQOEZpbWpX?=
 =?utf-8?B?UStDd1krSml2NitJeW8xYi9rTEpqR3lkRFBOVU03aFZscHE0cVFPUlA0WW5m?=
 =?utf-8?B?ZER3TFNjT1hjZ3VTdHlZRWkvMHJMT3gvQmMra0w1dXJZSTVuVkIyeVpkNEJE?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4150EEFCE0016345AD6C3A3EC07F734F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FzDmu/WZgcNXUKiZqAjVIMUqn1kOean7yZAcZvB5jQEukqmbFRZ5nDbOn6+YuPXUPWVMTULKXvizGlHF8qNKd8bZpZ6JM+oK69QHNohpLWROnCInHNxJY447t3blTN8IMU67Gq5uQ0wxk5jzyQU8h5/P1jJP2s/S/b8SsBlmHNNqOWHILRsjD9JR+5runcrxP5abSTkjQydaQadfO8N9LGj8LUnMyMqMREC1X3IhbJOpeD99hb1mfDzMiUljhuhKBDMD76+JNcr6HmwD1HTyf9ZgOF0lY20K8HFTxHFcGEsz3uot87AjaY4e3sdRjs2T+UCrvMiJp53ThTlYIWZG21wT55HI+GKCbc4ZdSqB8YmSxBE9x0zKrXQ1AxU1fN+lz2RDI+EBcsDNQxweMfnkXWFl1uaqEBABwcCTOXGVkyrPkzo55MueVo1IhpfPw4zM24r/Z/x4W95dDtkzM4x1BvIlsGUHeOz6J7A2qR1FC/i9NrzNyfsMZJJiF3EKAPZn5OkLSXuq9UBqVzNKvxshtT9+JcmMEH9juRXXY1U9fu+IE+ZSG5EzMMXbAyNgpa7YN2f/FUMtZCvyWs0kyfTDMuPOCVe16rMyZfvvr4dNtc4EFe5m6bbXnnDnWdCa/Fgi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08457e95-84e1-4bd0-6718-08dd03cb6ebd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 10:10:42.7192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qbSw0coZgPNnN3y2+DO2JzDzAQoCqDA5ByEif0vVfRKibhKKF0cJu2EBntEESFpXIGyWoHD1I4y3cal34o1n0RZrnNvqVw1Q44auJKP2jS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8474

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K


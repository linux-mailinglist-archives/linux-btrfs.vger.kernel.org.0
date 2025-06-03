Return-Path: <linux-btrfs+bounces-14417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66422ACCCBD
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 20:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1626B1894A31
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 18:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F52288C11;
	Tue,  3 Jun 2025 18:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HB3HmfnQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a0HhzN5/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6897288C0C
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748974633; cv=fail; b=iCK+3Vt3oGB18mcn2sIBR89ohvXzB3PzzHIhDVYqlM/4ad2P6adXyViZLdTnUs+IgAOuYBTnWRMdxWuy8X78ce2zxgYf/GcfsXLWRLWR/pUFGVair882ek365m/8tGd4ghn27iUMO4xXChlQpWeD5sLG4CTCUo+L2ZcX3G6P9C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748974633; c=relaxed/simple;
	bh=Sd/ZDgTlD8L3Fw8Ddj+akqtqBB+wtCckQjaNRH9l3vg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MyZ9TfWDqEJSQ0GFpDMzhh2KNcGvIkxoVkHWoPmhBe0tZYSzKOLG8HdP6UDpTCqk/iw9S0i4rNdhJP4vslsbb/4fQ5ZeKShSUlcEaA6jlwkn/bcPt5m3zFkWaKBtdBo3Aq7qdX8RDDcV3zVDgUzECyj7dXbc1qA7ZNcC22XyrLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HB3HmfnQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=a0HhzN5/; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748974632; x=1780510632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Sd/ZDgTlD8L3Fw8Ddj+akqtqBB+wtCckQjaNRH9l3vg=;
  b=HB3HmfnQmz534pBPmhNr851Ep378b6GVvixaPxlTIFpifvekzbrFznlt
   rxF7QjqlgkgfKPUJWNj2lWuqU/GUQuvWKZGZ1voL/Lo0Hfrz4dd27MKnO
   Ppey6KOei9r3Wb3iB6PBsIwAzCtydhIt0/WBGY6V/IZjlNZNxr/MnU2LR
   QSyNmeucHy8EsBgsvEtknx6GllfzkQMKDG3bNcwyBAFmBLhSuXYuYhnbh
   vQ7jrgvwsUoAtLzg5z45TC8Q5QQ7W+KFGttTUpxA1NOCy6iSbbxdl7NYv
   iu6rt4OdKJAFzm3LMwHD57kagAMr8qcUXs3rqlUCo/AuoR1ZUy0YQpc+M
   w==;
X-CSE-ConnectionGUID: uNBq3vHKR3yhiiw77HC6hg==
X-CSE-MsgGUID: N/JV3hDyRXSc61BFaDgMeA==
X-IronPort-AV: E=Sophos;i="6.16,206,1744041600"; 
   d="scan'208";a="89908514"
Received: from mail-southcentralusazon11012065.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.65])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2025 02:17:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgDvcDfQ9HocATslBf99ottlaFN/6z6LquPxpehEkVQzjpq+WXVR0IAJnaE5sTsepKe/yEwVpBiTV2lIyE5PDwD80othLGSUYLi1iIYYWTIBoncFXyc0B8ZmiUuxrxopjsiybDjNWkl5pC64IweWi3x+mj6Ne0b1ZtyUrwOJdCRMxav2/O82b115XPyAQqMEf44+YHaUzSAiCplspWoAARvZba6bQgaFC77GQzr3daGm1MXQlsLV9OvYe6DxNA1Dux1qGS1ceNxc5DR6siMM6vIA7rGCQ7ZAC4O6ivVUQ8onImieKg0IJNDBqBwE4+P+SmhLYMxJYKvC7a2FbEkEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sd/ZDgTlD8L3Fw8Ddj+akqtqBB+wtCckQjaNRH9l3vg=;
 b=zToZIZgV1dNpNQmFVt0HeTzBoTt2yPaNNHFWZPwEN7DbME+htl5j7/An8bR/MGq2CfLNK0lEQLLCz5cvtjTir09/d7fSjWZY7Nn8fnh2Iy6takPL7uKNvzXWNBdq30ICSl19jj7vkz9lKF97rp3O6tb6mjLc4Zry/gXMTipFQKjf9y6DHiz14dbcwRXym8mHWH66E0XK74ierKgs3sPYTyE/fGEFcIAdhIZnJ6Zcl1SNrGfiQsW52qM0PZn6Y9KDG219fLyb7CLHT05Gf22g+C7W2gqUfetBgqG+BCzaaOmbJq8BdsJdnhyX3GH4BJB7PIL+ho2fgmt9iXp5sfir5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sd/ZDgTlD8L3Fw8Ddj+akqtqBB+wtCckQjaNRH9l3vg=;
 b=a0HhzN5/hEiCeWR7Vvj9tsZTZT9dbIUuBEjo8lgfJ4nlzf4YUFoAKk8yFNSS5akRJdnz1k7FLJHYLhPtbrKzUK9RgbWCuwa0BRmhleM8KvjY65yztqfVNep7JKqLQUR/fSEo7hhRXaOs2vuGvhxgezAy1kKP8Pqv9CTa6kfLqJc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7319.namprd04.prod.outlook.com (2603:10b6:510:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 18:17:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 18:17:08 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: Johannes Thumshirn <jth@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>, Damien Le
 Moal <dlemoal@kernel.org>, David Sterba <dsterba@suse.com>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v4] btrfs: zoned: reserve data_reloc block group on mount
Thread-Topic: [PATCH v4] btrfs: zoned: reserve data_reloc block group on mount
Thread-Index: AQHb1E7CQ+uMfcGPzkSYlAgQ5OvrSrPxSvmAgAAtzACAAEYMAA==
Date: Tue, 3 Jun 2025 18:17:08 +0000
Message-ID: <7ab34e96-ff95-47d5-ba09-e235fb708a4b@wdc.com>
References: <20250603061401.217412-1-jth@kernel.org>
 <d8e6b335-a47a-4e31-afce-c7b9a87e6b43@wdc.com>
 <CAL3q7H7OOQF_VgBHtJ4iPHQ8Fbn=gu4-Wgb6Kn33PBoijwrS6g@mail.gmail.com>
In-Reply-To:
 <CAL3q7H7OOQF_VgBHtJ4iPHQ8Fbn=gu4-Wgb6Kn33PBoijwrS6g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7319:EE_
x-ms-office365-filtering-correlation-id: d158c2c0-6d37-49c0-4e83-08dda2cada4d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bFFpeWFmZWNkbWVNNVpsTFlYeXNaTGJZTEcrb0ZsZFp3NUVlN0Y0aXJyS082?=
 =?utf-8?B?bkRaMlRJSGNPcXZWUnlSdG1xakFWSHV0NDRTTGlCUUI0eTNXY3g0Tk9lbE5J?=
 =?utf-8?B?cW9hY3pSdTZXRWVLT0Y5aUVBWjQ4azVBL0VTS3EzYndEN2hPKzFMVXVyZ3lY?=
 =?utf-8?B?QzNaTU9pcnB2cUloNVFFaGZsT2Y4cnFaMTlPcUxFajMvSWxaQUFjVExzcjc0?=
 =?utf-8?B?QnI2VWFjUkFOUGlxa2lObXBLampHdVp1UFVFdkdXYldWTFVDWGZ1bVBnblVH?=
 =?utf-8?B?aVlzMEpuVEVzRUUrOWZYSXYyYzJCdnNVcTVGZWNOVWkxbXRJc3hyRFluNy82?=
 =?utf-8?B?VGFLMURIUGdONGZiQ3RuNUlwT0UxTStJbVVaTStSc1ZGM0Y2cEhrQkQ3bG9v?=
 =?utf-8?B?V0hBSk56ZE12MTRwQTNscDlYSmxIbjdJVmNlRXE5Njc3YmdSeDBJdnRLaFBQ?=
 =?utf-8?B?bkFZeDJBUWhnbjA2QnF1N3l0NUFxcnZrMm1Jc29wL1hYbTgrbExja0kzNkRa?=
 =?utf-8?B?SzJKZ2t2VEVxOE1pSHRzalNRdldhY1ptTmREa0EzNW4vMFRlc1V4eDRkWVBh?=
 =?utf-8?B?NWF6S2lHWmN6V21Md3lGL0JaSUUrckV1dEVTcmIzYkozYmxrY2o5djJ0WUp1?=
 =?utf-8?B?dmlTclllbkNqM0k3WUl3a0lMYVl3MTd0bTF4anozdlpkWTc2KzdEZy84OXZn?=
 =?utf-8?B?RUVIeElmOEpKbEVPT0cwUEl3Y3RCdXc4Zk5mMDhoUDFTbVdqeDVWSFVCakFJ?=
 =?utf-8?B?Z1NOMG5QYTJROWJKRnVlTGR0SG1MaU9scDFQN1VvWURWUi9nNXdneEZHYWxZ?=
 =?utf-8?B?T09ONTdETXphR2FVS0dIalkwZ3o0WnI1SE8rTmUrdFN3bDVJc3hscmJTbDE0?=
 =?utf-8?B?c2RHTCtCaGRJUm01N0xQRTd0RnNiZW1wVHVYOXc0R2dOS1BNVkpzdDhtRGxV?=
 =?utf-8?B?RVZjQjN5aVYrMFpRa1pQY0p1dWFZSmtUTlNVbERXWDF0amhtMlI3bjY0QlVy?=
 =?utf-8?B?dzlTbTBud0RVajY2S0h6aWtlTEdsVnR0bm9hbUxrbC8xeEhIKzhwQzVlTW1r?=
 =?utf-8?B?WkVqeDF5bnFJc0o4UWNsZVd3bHBGajhPOWdtMWxvU2liL2lrMEs3bm1kUys1?=
 =?utf-8?B?ZVhwV09UVlBvYlFhbXI3cTlXY1VOeXFOTVA0UmhnaThQbXFmVVV0YmRjYzRo?=
 =?utf-8?B?UVZGY1N3Vk9VaWw3WWZ3dFdLV0VWSFQ1alpHRWRCL3o0a0JFZUxEOTZDS1k2?=
 =?utf-8?B?bU9ZRUw3SzlxZW93VzlaeTdEeDBWa3NaOEFaaEU0Mmx6S3lWWmx2UHB5TVNW?=
 =?utf-8?B?czY2Q01HU0c4KzAxU2wvMFJGYmtUYklZakZyelZvRFFjMi9sR2NBYnlzbThh?=
 =?utf-8?B?YklpZXlubUs3ekpaUjFSSWhJZWt2WTQ3OGtqem45VXhTN2V6ZVFrMTB4UVEz?=
 =?utf-8?B?RmROVFJvL2FjMjRjZTFCb1NtNzdYUjBuQzJMbHNHUm4zMm02RVlzbGh1a1pB?=
 =?utf-8?B?R0lBakVjdlcvQ0ltbllaa0VLRkZnOGVOYjl3RDZqOHMyaGJUdVhwUE02T1NQ?=
 =?utf-8?B?QlRRc3JJOFZpZ1lva2pxR2JRSEM5bWdWR0QybGxRRWhjWGt0cFVoRFRqTjBM?=
 =?utf-8?B?R1NIUnlhTEMzamZlZHhoS3pzNy9aWk5FWklyVkpvU0k0Sy9jdXpSWXVYTSt0?=
 =?utf-8?B?SXE0ZDVZMnFNRWl3UDgxUEFsM3ZYNE1aVVBUNzVwakh6aHZMOUdUbmZDMFRF?=
 =?utf-8?B?aUNiRVJJenl1amRDUFVwOFZsNDlZckxJVUMzbHBGM0hkaEpORzdjdnBCUklD?=
 =?utf-8?B?dCtwZ3VyNUcrY1l4c1d4MHJKckhGdGgrRUQwR0wvSDlVSGlnK3ArM255VG93?=
 =?utf-8?B?aVhKdlRIdzZScWtQcUxKWDZVRWlKT09HR29oejNmZ0lCL0V2TGxTKzRKeUpL?=
 =?utf-8?B?TXk5VU9PVjZ6RENISHV0YWdaSDU5cXhRSmE2Mnd6bml3enpEV091TGlES0R4?=
 =?utf-8?Q?llu1RNU2iPjB6ogqbV9WopWKf86nrc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MFQyVzhsRXdNbzd0a3IrOHBZeWgrd3Mxb24rQ1g0dCtUZ1pmRkRydWpCNkhy?=
 =?utf-8?B?UENWWjRFSHZQcUhSS1BJT2RqRFg2T1Y1VUZqbzNMU0tjbjJpUjhvQXk3SWJD?=
 =?utf-8?B?cjIrRzg3dXpoUjBLOWdsL2g5QnE2Z0VhVDlXdnhyQ1dEc2pqemh2elNiZ0Ju?=
 =?utf-8?B?NFZxNTFic1VDVDJ0dkFLbThKTGx1dklQd0cvQ2IvU0hnZlFaTkpSZ1Fid3Iw?=
 =?utf-8?B?QUlrVmNnenVPNDR0SGlQSzRkL3NEOXBtalc0a3g5eDlsdHgrVnJRei9hOFJw?=
 =?utf-8?B?ZGRqUkdaSG5sU1RxRVdJeHZabWlZZ1ZNbUhBZ2lGdk9OVWE4d3JWcmRWamFG?=
 =?utf-8?B?VGR3Z2xqdGpKR01nRjZ5M3FqUTAxRlhmaE8wYWhOWEd1cllhUHVGMkQ1Q2Ex?=
 =?utf-8?B?d1FnWkdpYlJOY0NXSDRHVi90RU1nY2lodWNsVTBVZzFzaVB3V2dsNmhSaWFP?=
 =?utf-8?B?Ulg5ViszeUJIL01wUkUvNEV6VTVkYXhRZHFKSVlFN0FsMnNTZTgwSEJkVlll?=
 =?utf-8?B?M2ZFVHJHdWNOQjZlQVZIVmpUS01lSTVlWjUzU0xMYW9QY0EydGZ3TmdkR25B?=
 =?utf-8?B?cEk2d3lMUGt5cUVwSjAwZjJGbnI2SlFwcDFDWWZiT0NVZmx5Q2NwTGgxM1Qz?=
 =?utf-8?B?R3RUZHBDZFdOeGc3K2lYU3RLSkF3alRMUWFZM3VLWUlUOFRiN2pDakhyZTB0?=
 =?utf-8?B?QThobUFhQ3BkTlRSb3ZnSHpLdlFzWUp0RTJQZkYrRzlzTjJyMHdWUzFqSkN2?=
 =?utf-8?B?YmttbmJQQ25RNXlsZ3FQdUJJOCthTlNLVnVnWVIrSGlBMys3NExHbVBtTFNX?=
 =?utf-8?B?ZysxY3duSlRTdHdhOFduZ1luaGxHbXBPVk9IaUVrTUt4S3N4SlJXd2FoODhS?=
 =?utf-8?B?MzJodjd4SFNqYzZNR1krUnhJMVZaUmg4MmZIZ2VkTFhQNFNobHo4NytpUkNw?=
 =?utf-8?B?QU44cVBxMXFCR2NSd2dONjVPWXhQQzhzNm1tUTJKcUNVQkg1bW9UNjkwMTZq?=
 =?utf-8?B?M3dJKzlzN2Q3WkVwQnp5OFFsQ0h1dEtWcnFvR0dGeXBVUEI3YTc3OGJvSU5w?=
 =?utf-8?B?THEzQnc5NkJiQllGYVN5MkswVS9KZWl3aVU1WVRHSlBkdXBtOUtIWHlxVlAz?=
 =?utf-8?B?MmxpY0FDL1BEMzJpYlFpa2p6V2VMMlRtRHlkTkxPWHhMdVdCTWFaQnZEUEp2?=
 =?utf-8?B?NWlrVk1XWFNQbVNXY3ZXWW1pTzNad2hYMXZOM3RJMlZweVVYTlgySmVNbmUr?=
 =?utf-8?B?RjVBbWdOUXZBVzNEaEpwRnlPdW1laWdTYmVFdnRtT0VERVVYdlVPVzVDOW90?=
 =?utf-8?B?NFFJemJEUHJNRTBWUUI1a1Q3VS9SdktPU2lSVHhSSU9PZExVaEpjYUVxSHRx?=
 =?utf-8?B?d1JJQVhWRENmbThuKzFySlJtT3lTdDlKNWxiSG1KWE9WMG1JUjQ5TFFsU0c3?=
 =?utf-8?B?aEMyRUI2ZGkwS3kzNHEvWHprSUFNZmxpbUpMdHpPK0VuU0lGZ1ptcDhOMmYw?=
 =?utf-8?B?bEVLRkpMejBjQ0FZb0cvVExiamRvUGMvcXVoMzVqK0krcGpYVEszYXlvRy9k?=
 =?utf-8?B?UStSNU5sYjQrM2RzOGVnNTVjUWxOUmNGdDJkQVVSYmxyNlpOeW9McVZCckhz?=
 =?utf-8?B?aWxNNndpeERIYzBKUlFjbnJJQUY0UUkzRHJJQlFIUXh1dVRQKzVuSTV1Tmwv?=
 =?utf-8?B?WW5vbkdHK0V3QWVpL2FzaC8yNWFUaEhBN281RW81M0gzOVpSN3libU9QL3FD?=
 =?utf-8?B?NlNQSjdzWG15UHNwL3dFRFIzOW5TWVR5amNFRlUrckx0TjdJeGZPeGFDdkFm?=
 =?utf-8?B?cW8xYmlNcTBoc25WV0NTaFZONmZwZzJmMjNITCtSZVFEQ1h0Zlk4eS8xcXZY?=
 =?utf-8?B?KzZCZC9YSThJNzBESEZLZXBRT1RKVm01bzdqQUJaR3hRYXhWVFdNYk1Qc0Rh?=
 =?utf-8?B?ZmZhYWk5K2t4a2hkQlU0dDlERGJlaDYvcnZvaXNpNE1RRHIzSExnRnluZDBC?=
 =?utf-8?B?aEtnMXV2SWR2Ull6V3NyRXpJTHAwYzZZMFZDdWhvaldpODd5Mkd2RGwxcGVY?=
 =?utf-8?B?Y3gvWkdkUkI0Z2Y3RWM4S0xNOVc0MXRyeDRIQ21ZVDhQdUZyRjIrRHc2aUFz?=
 =?utf-8?B?TjBoR3hyaWszUUIxcm5XQUwra2xxZ3dQRWFkVDM3VGpjMjROd0FNUFVvMm5r?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <345D7C4B30456B41A6FFFC35BE191803@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ehMbRmK5qKP0vxodYrDQj8jZ6/5oJzZzj/G8fRT2HQeif0FPfcp/SnDE6U9EMzLQA4AMf/8Et2q0FkK9Wfven5fG375VbHk/eAGoQLhfkheWjfDnZvcgFGxl/jNV0lEtKwIdqkVpoa9ycn/e+hVa1fRepKHEHltTTqAtrVReYEhQcchEhzpJEwt2BH/tdO2548SSAbkpM10i2PDpssoqDjC9fO4EsTZifasWaE5K+5rZFhm72vtvr9BVyfo2TB6XYLF7zBRmXK9BUhftQRJCwGzp1DEbT0wXWA5n/FBApefakXwznwGpsBnxejUvjeP07GmH0y1sN+sCRajKo+OLj+TQp/2ml5yOUtAp50VjB1sG0jaavyVVMEASyJbILNXdTTWx7RqZHUy25ntY8u8GdSW5Q3FhsuZXZtMIlKosyMceKma5MXdO2tWoCO2L3Sp77cZf11kqKvPyzwPoS7Y8HsM3b6e4ZpIpgy/16CLjQ4Rauk+ejso9b8NuiQJBOXjnnuKBQdZtaZocUbeWIn5s1UCLGDdljZ2AvJ/LNLxWmjoNzQgwgEMCukNS/OlIeoREOfQO55S9v5A2csHLdSvuqR1osWfsFUUAgS7SunqfEpoESAZAPlKOuliaoWG2+yci
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d158c2c0-6d37-49c0-4e83-08dda2cada4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 18:17:08.6053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1s+piNJi+JDSxMMDgz/63woW0PcHexsFfOs21L36bRM/uBWJfrXpyOi2KHwRniEcRBhz+b8SXv7w75EXG1mMGiRB2iDS+AhrvzY8nnLcu38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7319

T24gMDMuMDYuMjUgMTY6MDcsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIFR1ZSwgSnVuIDMs
IDIwMjUgYXQgMTI6MjPigK9QTSBKb2hhbm5lcyBUaHVtc2hpcm4NCj4gPEpvaGFubmVzLlRodW1z
aGlybkB3ZGMuY29tPiB3cm90ZToNCj4+DQo+PiBPbiAwMy4wNi4yNSAwODoxNCwgSm9oYW5uZXMg
VGh1bXNoaXJuIHdyb3RlOg0KPj4+IEZyb206IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQo+Pj4NCj4+PiBDcmVhdGUgYSBibG9jayBncm91cCBkZWRpY2F0
ZWQgZm9yIGRhdGEgcmVsb2NhdGlvbiBvbiBtb3VudCBvZiBhIHpvbmVkDQo+Pj4gZmlsZXN5c3Rl
bS4NCj4+Pg0KPj4+IElmIHRoZXJlIGlzIGFscmVhZHkgbW9yZSB0aGFuIG9uZSBlbXB0eSBEQVRB
IGJsb2NrIGdyb3VwIG9uIG1vdW50LCB0aGlzDQo+Pj4gb25lIGlzIHBpY2tlZCBmb3IgdGhlIGRh
dGEgcmVsb2NhdGlvbiBibG9jayBncm91cCwgaW5zdGVhZCBvZiBhIG5ld2x5DQo+Pj4gY3JlYXRl
ZCBvbmUuDQo+Pj4NCj4+PiBUaGlzIGlzIGRvbmUgdG8gZW5zdXJlLCB0aGVyZSBpcyBhbHdheXMg
c3BhY2UgZm9yIHBlcmZvcm1pbmcgZ2FyYmFnZQ0KPj4+IGNvbGxlY3Rpb24gYW5kIHRoZSBmaWxl
c3lzdGVtIGlzIG5vdCBoaXR0aW5nIEVOT1NQQyB1bmRlciBoZWF2eSBvdmVyd3JpdGUNCj4+PiB3
b3JrbG9hZHMuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpv
aGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPj4+IFJldmlld2VkLWJ5OiBGaWxpcGUgTWFuYW5h
IDxmZG1hbmFuYUBzdXNlLmNvbT4NCj4+DQo+PiBVbmZvcnR1bmF0ZWx5IHRoaXMgY2FuIHJlc3Vs
dCBpbiBhIEZTIGNvcnJ1cHRpb24gaWYgdGhlIGFjY29tcGFueWluZw0KPj4gbWtmcyBwYXRjaCBp
cyBub3QgYXBwbGllZC4NCj4+DQo+PiBJIHRoaW5rIGl0IGlzLCBiZWNhdXNlIEknbSBub3Qgd2Fp
dGluZyBmb3IgdGhlIHRyYW5zYWN0aW9uIHRvIGJlIHdyaXR0ZW4NCj4+IG91dCBpbiBjYXNlIHdl
IG5lZWQgdG8gYWxsb2NhdGUgYSBjaHVuay4gVGhlcmVmb3IgbWV0YWRhdGEgb24gRFVQIGNhbg0K
Pj4gZ2V0IG91dCBvZiBzeW5jIHNvbWVob3cgd2hlbiBvbmUgY29weSBpcyBvbiBhIHNlcXVlbnRp
YWwgem9uZSBhbmQgb25lIG9uDQo+PiBhIGNvbnZlbnRpb25hbCB6b25lLg0KPiANCj4gTm90IGZh
bWlsaWFyIHdpdGggdGhlIHpvbmUgc3BlY2lmaWMgcHJvYmxlbXMsIGJ1dCBpbiBvcmRlciB0byB1
c2UgYQ0KPiBuZXcgY2h1bmssIHRoZXJlJ3Mgbm8gbmVlZCB0byBjb21taXQgYSB0cmFuc2FjdGlv
bi4NCj4gQW5kIGlmIGZvciBzb21lIHdlaXJkIHJlYXNvbiB0aGF0IGlzIGEgcHJvYmxlbSBmb3Ig
dGhlIHpvbmVkIGNhc2UsIGhvdw0KPiBhYm91dCBjb21taXR0aW5nIHRoZSB0cmFuc2FjdGlvbiBh
ZnRlciBhbGxvY2F0aW5nIHRoZSBjaHVuaz8gRG9lcyBpdA0KPiBzdGlsbCBjYXVzZSBhbnkgaXNz
dWU/DQoNCkFGQUlDVCB5ZXMuIEFuZCBpdCdzIGEgdmVyeSB3aXJlZCBjYXNlIHRoYXQgb25seSBo
YXBwZW5zIG9uIERVUCBtZXRhZGF0YSANCmFuZCB0aGUgbWV0YWRhdGEgYmcgaGFzIHRvIGJlIGJh
Y2tlZCBieSBhIGNvbnZlbnRpb25hbCBhbmQgYSBzZXF1ZW50aWFsIA0Kem9uZS4NCg0KVGhlIHBy
b2JsZW0gaXMsIGV2ZXJ5IGh5cG90aGVzaXMgSSBoYXZlIGhvdyB0aGlzIGNvdWxkIGhhcHBlbiBp
cyANCmludmFsaWRhdGVkIGJ5IGxvb2tpbmcgYXQgdGhlIGNvZGUuIEJhc2ljYWxseSB3aGF0IG11
c3QgaGFwcGVuIGlzIHRoYXQgDQptb3JlIHRoYW4gb25lIGNodW5rIGlzIGNyZWF0ZWQgYmFja2Vk
IGJ5IHRoZSBzYW1lIHpvbmUsIHdoaWNoIGFjY29yZGluZyANCnRvIHRoZSBjb2RlIGNhbid0IGhh
cHBlbi4NCg==


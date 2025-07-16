Return-Path: <linux-btrfs+bounces-15518-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D8AB06FB5
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 09:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89B918850F4
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 07:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D50828EBF1;
	Wed, 16 Jul 2025 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kY3C5n+M";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Amtpy3i0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6B273FD;
	Wed, 16 Jul 2025 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652662; cv=fail; b=uW83WcAqaQu/8/Ss2MKfsxbWOnXnvHSbRvH4QJMalmCBLwY7NG8hwN62ZVSdJ7IKNOx9cmUrwbl9xazQVyayirLisGvdPrS7yuwCua6aiKrqaniOTGitE6l7isuE69vcrXY4odPn7RlsP1DZ+EGUeYdVBWf41rWR6asIoK0+u7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652662; c=relaxed/simple;
	bh=VgdyUZOaUIpXhRsl51cRytQdxm1xkmNln/lPPMk9uZ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M674AbcXoN3R3XvPjpqau0wTLF05b4nyn+6yQh7rStbttkDCquvc9Y6r2NZxhgGM2qIGYf+f621s7MZdJl6hieDsRBjUgMvqCcwe0kYMP1r52ZL4W6h7kqdG2eZ1I2FQfJ9WNjXsJUMlMsqI1gYr3000uSuVEglrocC1JvHCV1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kY3C5n+M; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Amtpy3i0; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752652660; x=1784188660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VgdyUZOaUIpXhRsl51cRytQdxm1xkmNln/lPPMk9uZ0=;
  b=kY3C5n+MbGJtiVG8V+WDG58LCed1rNQ23rEd4uAR7QAau7uN2t0IGu4q
   5RHTc99rP8WOoMqroD0+MJsIyDj91VCUY40BZT/6cSaoDMmkGfwEjOKbx
   T4FokJOHOyFKqQXeaCOJr9PhmJIQKXNwMUWYMpX7GfYsykaZzfunXe0Bc
   Y8FGBgB5HgPJFRWJzhh0nKtOIBV6zx/bOpS8IBH97bdupzr0of79BjIAl
   7/bbTjyyWOfUPWstuwQy2f+4Cb+Ww4lV+G+KfRBZ/kQD9pzJWVmHi0CRL
   w44It4M0Zd+1puGA6fd01QcgRM5bhURE5g1RxPih/0m+o9MAH+rUlbPdE
   w==;
X-CSE-ConnectionGUID: rEffI9wJSJ2xk5zD0RYs7A==
X-CSE-MsgGUID: ZcaMOgQdSKqBgPgRvuQjRA==
X-IronPort-AV: E=Sophos;i="6.16,315,1744041600"; 
   d="scan'208";a="90280325"
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.52])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2025 15:57:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNww/Mm9PbtsK7L3TmSOgSIDI75pXM1vqB17Cz2zNUKbRm76biwl1i8THnGeiifyFlbe5E0w/HEbjgk7ZMoqgn5teTxTVW2IqMeOzCrPKsa7HHFl3GcE+xmeTaBpVRQJtEDDyzcC7IbidwN0ccsmNvs/hj7dsIh8i5VsydARSnBbj/oneo+fY7Sirsk7x+du1GWMNm8SYMZsO1wtgV5nFTgPwWV5mWv7UeVeSnlkVfD1JX+Gh8bPOxdHYQxWOpH2oh2jeawhcZCDm/hntPp1lM/mNFrJ++cteD4jqittQZ6OhLfrnJJB3T16oYZPsM3ZBqflyXPocBv+pzKxE5fOcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgdyUZOaUIpXhRsl51cRytQdxm1xkmNln/lPPMk9uZ0=;
 b=QrvNBlF3O8b1Qlv1H/0f7Ooq8qyjQv+jq51vyezBT9bEDeIhku2xXwUZvK5p0j3C1OwK5FmOSQIdMNssg2Zv96Y3Z58Ru/bWN1uGcqiPMuA1k4I8LbwZT7PlQFbeIyTo7WOoinaLKPnR9SoykeRMM0ZCNqgrOvdjdlyBafghTUMYTokHO8SNW7dqNo5t3CfUT1wKlj502/+CSCexloA6/CAjzuPpSJbRemWyHTeK+/Tkj871jOU8TVdxudWZEPs5m5P1CsXWwpCQZ/FmRZggTeykjeaamiF/lzGB9/dPZAYJ42qmHVoSuv422XqhIVw2c6A3TeWSegUIwN1fM8PBUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgdyUZOaUIpXhRsl51cRytQdxm1xkmNln/lPPMk9uZ0=;
 b=Amtpy3i0oEW1ig25CrYoyxeZOSedmf4H0FcyeSsaJnfPM4qIQ+QyMrrbUDka8jZzMdfXV5KtQjZihwfTFQZByWrGToyTNZ8ykMCgydgcQO92TR0YE/pSSYo6GFD2UFLA2xsYu930cSyPRfAlVnJyIvGXw4AiPMP+XR7djEnM9ro=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:57:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8922.028; Wed, 16 Jul 2025
 07:57:32 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Anand Jain <anand.jain@oracle.com>, Johannes Thumshirn <jth@kernel.org>
CC: Zorro Lang <zlang@redhat.com>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] tests: btrfs/237: skip test on devices with conventional
 zones
Thread-Topic: [PATCH] tests: btrfs/237: skip test on devices with conventional
 zones
Thread-Index: AQHb5pzbwB+LwHF43kKjW7+6wDjhoLQumzeAgAXmH4A=
Date: Wed, 16 Jul 2025 07:57:32 +0000
Message-ID: <9e7e864c-fd3d-4d50-87da-b8ded6765b9a@wdc.com>
References: <20250626131833.79638-1-jth@kernel.org>
 <5275455d-3cc8-430f-90e4-533e6572ec97@oracle.com>
In-Reply-To: <5275455d-3cc8-430f-90e4-533e6572ec97@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7184:EE_
x-ms-office365-filtering-correlation-id: a90bdb69-462c-4f8e-76a7-08ddc43e6b2f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|19092799006|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dUwvT0ZYZ2tZOTVxVXVqN1VTaThDM1piT1ZYNUY4VnpVUHJBbUFRcFpoQy9t?=
 =?utf-8?B?T0pjTHN4dlRXaU9wZVRtaWdJai9LSXNZeDBPQngvaGVHWUNFaGp4a0wrYjg3?=
 =?utf-8?B?WGFHdkhCTytjb09aUkF3eHM5STVrTm9Pa2ViVXFrMG9UWkVOZmNOSVlQVEQ0?=
 =?utf-8?B?bzZyZ3NvMjl6MFB0K1lqUkw1ZGhhQXlyaUdyYkpvdVZxS2FRMlZrS2ZYZVNB?=
 =?utf-8?B?N0VPT1ovOEozZ1ZpeDg1SnZyN0xId0ZkWjhQZ21zME9ZN2U1cGoyRWZ5b01k?=
 =?utf-8?B?N1Ezak9XUTBtTFZzZW1iZWZHeUNQMGlUekRWNmxlZEMvS0k3NE8yL1JIMkhW?=
 =?utf-8?B?N3Iwa0RTMTd3TUlVazc5UEJPMXJHUUFDTG1jRE5xTExXaytRcE1OckxuVUp1?=
 =?utf-8?B?ckU0R0pQZGc1bjVFaHJPM3hIVVByaUNZN0ZzTnVrSHpqVjU1a2NpZkdhU2pR?=
 =?utf-8?B?NVU4ZG5qdFA0MDliNE9lUlkrZHFLZjJTSDhqNmJJQzJFcjJyUU9kME5hZ0ZM?=
 =?utf-8?B?bTkwOVhsRTRtV05aSkJIK0R3ODBBQlZLZFB5cmN1MFV6Nm1hV3J1U2VlUyt5?=
 =?utf-8?B?ZDBFT2dBY09ocWJ3WGxGU3B3ZWpvcnZGVVVNeTE4eGppeUROMmU3emhVdmxp?=
 =?utf-8?B?c0lXdjlvd25LM2ZnWkVnZVdkRTBsK1MrSzkvMFFSb1dyNlY1a1p2cHNBRFB3?=
 =?utf-8?B?SWdBVDBkTGpqWVA0YVhVQmVCUkE4aVpkaUxvaDhuL2ZSc3hIeVBwNFNWeHNk?=
 =?utf-8?B?bW5RTTJjZjM0Z2k0YTlBaHNSYVBoL1lCNkh0TE0wOTV4K3lvSGFsMW03M3E4?=
 =?utf-8?B?K2JibjduRmVtVVVIYTZCQlFkaTlaMXVYQTJEOHVWL3p0QWhIV1Azd0U3Z0lo?=
 =?utf-8?B?TmFrb3RNM1Z6K0xvaldQNWM4TmY2QkRlNnJOYXJKT0hJYy9oVXhZTkNkV3d1?=
 =?utf-8?B?M28wclJkUHgySlZQQmZ4L3hZamlVaTgvU2NsSTIycGU0c0MyZzhuaUhlWkph?=
 =?utf-8?B?OGJCcVk3eWpvOTl4WjdqK0wxZFRTd3BlYW1DL1BTOWFYK0FQalRSUVBjWWhK?=
 =?utf-8?B?NEk2eDY0TisvcHdUbTZaemV0NFdRRWZvSjBnQVUvUmJ5QjdtMWtRck92aVYz?=
 =?utf-8?B?V0VwL2RTRmk4TXdVUE05U0pXbk56S1g2SHJKNEpoY2hEUkorelFqWTJUQklX?=
 =?utf-8?B?TVYzZkpIcXlTN0o1am1vWjRXREIzWmlISDU5R3hXTU9JcmN1TWRYTnlKTjFT?=
 =?utf-8?B?UmY4MnJwRWhlWTlaZE5RaGpNRUhPZVQzdnVZMkVjQWZxcUdsb3BqV3pHRHhV?=
 =?utf-8?B?b21EaGM0dnlWTlJRQXp2MXJ3a2k5Qm5udkY2M1VZcnR3ZmU4WW1TTWwxSXd6?=
 =?utf-8?B?RFpPSnpRZ2ZKbXJocTZhUmpycllvY08xRlROYzdrWTR6VGJ3U1E4Uk41SkUz?=
 =?utf-8?B?Um11Y2N4bGR0eUZPWFJuTGdQWk4xQ0hsZlBqdjYyRDhpRmNpcmo5Wmp3a1hH?=
 =?utf-8?B?K2t5bDQ2SmxmbW9odm1uVVUrdkFuTlcvTSt4ZWFjdzgwOWNCTXpjVmVHZXZt?=
 =?utf-8?B?MU1CeGRZOWpHb3ZLK3RENE45SnYwVnlxdXRmQ05nRTVnN3VPU2hiWDNZUEVR?=
 =?utf-8?B?aTY3b0t1ZUJQNit0Y3FSMXNDaVRRbU95OVlZM1RNSmsvT1BmNnprMWgrVFZY?=
 =?utf-8?B?ODNDMU1RYnVnbnRpRWVoWTRLQ0ExTjIrU3d4NENUejdPcC9MdXMvVS9yVnpl?=
 =?utf-8?B?bk12bWsxcWRSeFcrWTk0WENHb3ZEZ0JTNURNb3ljTVRTSWU1Nk9nTWlWUDRu?=
 =?utf-8?B?Vk1rd1FlVHpaRjVDVU1CNEMvWXdmMnZOeFJvem01amVSQjJYN3lCcGZlT253?=
 =?utf-8?B?aEVHYWJhcmNFdHkwaHRmdWs0SW8wQnRlbEpVSzZRUC9ibFFNYThNRGZxdjhW?=
 =?utf-8?B?R3FRaEpBbC90ZFg5MzRndDBLZFFScjhwTFJaN2loaERob2FVby9LZXd5R1g1?=
 =?utf-8?B?QmJBeldxL0d3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUdPY2xXdHdIYjIvVU4wWDVDWHFWYlArK3R6Z0R1ZkFvQXo1SERET0xTU3p4?=
 =?utf-8?B?NjV4Q0hod1VzTlN6cGkrR0xob1VKUUU0OGdjQy8zN3g0UmxHMTRNWE1kMzRk?=
 =?utf-8?B?OHVwQ2lsL0xabVcxYW9QMXdpbHp0dDk4OFdrN1RHaDRIODVpRitwWnVpOUJx?=
 =?utf-8?B?U2VQME0yM0pacy9XdTlmMzk1NWRJVGZiTGcxSjg0WWVMVHMvUFZ0dDJzazdG?=
 =?utf-8?B?MjBhbzBXRmRpdHBHWFhjdCtUdDNsMHRacXNRRkNDR01VRHM5S2I2YlJPcm9X?=
 =?utf-8?B?MytyUDgwUjBra0c1L0hCR1hycEdxSFZ3dy9wMHdocGN2enJLS3lWM21rMkE5?=
 =?utf-8?B?N3ZqdUZZVHExZ0xldmJXbTdoTko1blRNR00rSDFHdDBFSjBETmdlMmlTcFJO?=
 =?utf-8?B?RXhRRXJhQXlPQmdJdkhUMXJQaVhGdlVCaFZrS05aZUV1L2VVb0JSS3NnQXpj?=
 =?utf-8?B?N3phMmYzZll6T2VUL1Y5R2h3bU9GejNLaHE2Mkh2a3l0QytDcE5qVExtMGI4?=
 =?utf-8?B?YWZCY25TN21UcjdRUE4remkzT0FET3ptTWFwWFlmQm1IZjJReXVISXExaS9F?=
 =?utf-8?B?b0lnaHNoUi90dmd1NERqczY0WERXZVVLMGltejkzVWFNLzhQK0xBSXhyMDA3?=
 =?utf-8?B?RWtYNGluUU93QmlheFVtbnlteS9kWXdQeEZLekFZT3pwMndBdWxKZ1FJWjJ4?=
 =?utf-8?B?MVVPQjBWZ2w2Z2QrMkdycXRnSXFJY21qR2lpYjR1U2djcjNGWGp0TkYzWXA4?=
 =?utf-8?B?M0Q0Kys2QzdjQ21KWk9KZ0ducmFoOHRFc0dVSGg2bnRhQklVYTlCNlNqMzVY?=
 =?utf-8?B?ZkVFUC9LZFdmTG4ybnNmQ1M1L0Zkc1hONHZqRVVNSTlpTG1SY3YyenpnendL?=
 =?utf-8?B?M1ZhS2NBUi9sMHJWMnh2WmJrc3R3MTZyU3JaMGtWczFRemwzOW9iTUJLZHYz?=
 =?utf-8?B?RVRrSmdsSi8zWVdvK0tBdzNQLzZHbEZaY1RIVjJsMXAraDdmMVErT2N5Q3pz?=
 =?utf-8?B?cXF5ekhoczhRbGZIdlY3S3FPQzVXWTBSd2lRRS9lY081ZjQ5UjRPNjVyZGtk?=
 =?utf-8?B?NDdsU3RmcHRSNVRrbUtkRDgvZ3hVaFVHUE5CSS8rc3hNSUpaVkpubUVMSEJV?=
 =?utf-8?B?ZlVwbzNLcGFrVS80cHhVTnZHWEIvRDFTOFNhN3JLbHFNYjUzYlJZK09RTVMz?=
 =?utf-8?B?TnVtOGx3V3ZwVzJ5QXAzRmZuSWc0VUFMdEhOZURGbXBDRWk1bjdhMmxPOUxQ?=
 =?utf-8?B?a3FmUU5aQlY0Nzd2TUxlRXVnSThIMy9hS0Mxa0Q3Ukp1bUhkU0xSNmJDUzlw?=
 =?utf-8?B?Szh6ZEIvb3piZ3k1UmdYTnBUNDRxek4zUEpBRU5BTkZVdXF1ZzJ3Q1h0MjVE?=
 =?utf-8?B?dlJydjhBd2dBZUZMSlJiUkxmajlZWThlLzNrZDljT3E4VjZCVnFjRnZvSklX?=
 =?utf-8?B?U1lpaUVZak1hTmpndlpmOWRPOGNVTXVPRlIzdlVVODVyVmFjL1UyZkJab2NU?=
 =?utf-8?B?VDF3ODlGSVJVZUdEdzc2aU84TkVFMEErU05FTGFyWHdBTXg5aVduR3hmOW9X?=
 =?utf-8?B?NURtM1VOalBYTno1Mm5ZVXVPd0ZHUjlyc1g1NXdYZGlqQW84THoxcEZwMkNH?=
 =?utf-8?B?RHcvaUFsUUd3M0hoUWhOcFNJL1FPMFNwNmZDUFpaYTdudG4zM09iRGwxak1D?=
 =?utf-8?B?YUYvS1JpeldyMmVVOFB4ZnJKTllxdjJFcjMzU1loM2dKam5KVkErOXBveDFx?=
 =?utf-8?B?dGhta0d0OUtlc3VoQ2FoYlk3ZXovT2phNmx4SE1EYnpzMzBVSzVJNlB6TXVC?=
 =?utf-8?B?MlNVcnh3NGMxTnVRTE9SUGJGOGhpVG5FdXc5MkxydHV0dTJuUHo1UVZkQnBE?=
 =?utf-8?B?WENFR1lUdGRpaHZEdlczNWk4WFFlSW1yQ1A2N2V1eFRqOWlJOGFEaFBheFVW?=
 =?utf-8?B?blU5ckU0Z211bEM5RmF0NXF4M0VlYzFFZEVBcXZmMmoyWEU5UHVGYTZvRU84?=
 =?utf-8?B?aGlWclR5dzNueTJFcEs3NnBwZUw0a1FpZ1NXT0s5aXpoZDJkVDVNRzVwLzIv?=
 =?utf-8?B?K1Z6UmgvUVpYYWprMmNycW0wb0k1TXcxaURMREl4Nk1DUmE3Q2N5UjRZZ2xP?=
 =?utf-8?B?QktTcHRhNzdxTHNnaTN2ODllNFhObnN3bGRnV2pvQkhIbzhXQXhrV0doNnQ4?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B95037EA0B8E084AA5D85C636D7F1EDC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xWV/q3NYCOznDvYj7/cPnxVtr6vJ358Cc1yH8w4pHfG0NykYq2gg1n8QN3kOhiN3IM0dgDIpcJ6kBmMFro22mFWI41gBretOYqG5KA7iK/vBpJC4W4yl4nRtXO9uVwN8DZWPjTsWRTmdGMfyQFIGnMhVW1am5irRXZS69GfnMPc43GpJRw1euLiUrIeL7obb3/hQmcL2QOmssLfKkfOXQWGgwBXcWZu9SigqGapuveURwJxjTg3rOzHmktm1lPUyvYolzk4a7qahfDkWnnEvH7UrPqT5k6UR1E2svkBL4HGFzY8U/MJ5mpxbcnmIxpUqgrZoPU9gu+0qAFSu08kRNmqB6fC1aQH8vlwAqglB/aFdew4mFEAP6fsWipCajXB8XbnPl21bs3I67/aK7ZUS4AqF+rBUNNKVunxuuJs0MX0eGDdcAeNc38pGrJp+N57Bl/lMWtVDcQftIeCA/Q3U8msOpr8mdiO7nN1clOYxW1I0nsHl4Yv+aqPq0BVh2gzMhDrya6Mg9NHEyUJcZcwqAk5I0SZ971JlNha7uAE+/hxAsMprmQ+mXemtKBcCyWFCGSgS/yez080vtwVXgwtiXLzv/YcSwg1mgilVNnW1inq+XqLenDBAaSfTawnApx53
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90bdb69-462c-4f8e-76a7-08ddc43e6b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 07:57:32.1199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPUS7kabNq0vl8umbC5jBditEoTazfBVTQb0XkgMRWMH5YQTcI0EybZrzbUos6KbYA/v2PTuyspGi7/n1ahVB8c/BS2MHBInKGIgUBZj5Pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7184

T24gMTIuMDcuMjUgMTU6NTMsIEFuYW5kIEphaW4gd3JvdGU6DQo+PiArJEJMS1pPTkVfUFJPRyBy
ZXBvcnQgJFNDUkFUQ0hfREVWIHwgZ3JlcCAtcSAtZSAibnciICYmIFwNCj4+ICsJX25vdHJ1biAi
dGVzdCBpcyB1bnJlbGlhYmxlIG9uIGRldmljZXMgd2l0aCBjb252ZW50aW9uYWwgem9uZXMiDQo+
PiArDQo+PiAgICBzZGV2PSIkKF9zaG9ydF9kZXYgJFNDUkFUQ0hfREVWKSINCj4+ICAgIHpvbmVf
c2l6ZT0kKCgkKGNhdCAvc3lzL2Jsb2NrLyR7c2Rldn0vcXVldWUvY2h1bmtfc2VjdG9ycykgPDwg
OSkpDQo+PiAgICBmc3NpemU9JCgoem9uZV9zaXplICogMTYpKQ0KPiANCj4gSm9oYW5uZXMsDQo+
IA0KPiBUaGUgdGVzdCBjYXNlIHN0aWxsIGZhaWxzIG9uIGEgem9uZSBkZXZpY2Ugd2l0aCBubyBj
b252ZW50aW9uYWwgem9uZXMuDQo+IEhvd2V2ZXIsIGlmIHdlIHVzZSB0YWlsIC0xLCBpdCB3b3Jr
cyBmaW5l4oCUd2l0aCBvciB3aXRob3V0IGENCj4gY29udmVudGlvbmFsIHpvbmUuDQo+IA0KDQpC
dXQgaWYgdGhlIGRhdGEgaXMgcGxhY2VkIGluIGEgY29udmVudGlvbmFsIHpvbmUgYW5kIHdlIHJl
Y2FsaW0gaXQsIHRoZSANCndyaXRlIHBvaW50ZXIgd2lsbCBub3QgYmUgcmVzZXQgKGFzIHRoZXJl
IGlzIG5vbmUpIGFuZCB5b3UnbGwgc3RpbGwgc2VlOg0KDQotU2lsZW5jZSBpcyBnb2xkZW4NCitP
bGQgd3B0ciBzdGlsbCBhdCAweDA3MzMzOA0KDQo+ICQgbW9kcHJvYmUgc2NzaV9kZWJ1ZyB6YmM9
aG9zdC1tYW5hZ2VkIHpvbmVfc2l6ZV9tYj0yNTYgem9uZV9jYXBfbWI9MjU2DQo+IHpvbmVfbnJf
Y29udj0wIGRldl9zaXplX21iPTQwOTYgbnVtX3RndHM9Mg0KPiANCj4gJCAuL2NoZWNrIGJ0cmZz
LzIzNw0KPiA6Og0KPiBidHJmcy8yMzcgNXMgLi4uIFtmYWlsZWQsIGV4aXQgc3RhdHVzIDFdLSBv
dXRwdXQgbWlzbWF0Y2ggKHNlZQ0KPiAvVm9sdW1lcy93b3JrL3dzL2ZzdGVzdHMvcmVzdWx0cy8v
YnRyZnMvMjM3Lm91dC5iYWQpDQo+ICAgICAgIC0tLSB0ZXN0cy9idHJmcy8yMzcub3V0CTIwMjUt
MDctMDEgMTc6NDE6MzAuOTQzNjk5NzI1ICswODAwDQo+ICAgICAgICsrKyAvVm9sdW1lcy93b3Jr
L3dzL2ZzdGVzdHMvcmVzdWx0cy8vYnRyZnMvMjM3Lm91dC5iYWQJMjAyNS0wNy0xMg0KPiAyMToz
OTowMy43NTYyNzUyMTkgKzA4MDANCj4gICAgICAgQEAgLTEsMiArMSwzIEBADQo+ICAgICAgICBR
QSBvdXRwdXQgY3JlYXRlZCBieSAyMzcNCj4gICAgICAgLVNpbGVuY2UgaXMgZ29sZGVuDQo+ICAg
ICAgICtPbGQgd3B0ciBzdGlsbCBhdCAweDA3MzMzOA0KPiAgICAgICArKHNlZSAvVm9sdW1lcy93
b3JrL3dzL2ZzdGVzdHMvcmVzdWx0cy8vYnRyZnMvMjM3LmZ1bGwgZm9yIGRldGFpbHMpDQo+IA0K
PiANCj4gRm9sbG93aW5nIGRpZmYgZml4ZXMgdGhlIGlzc3VlLg0KPiANCj4gLS0tLS0NCj4gaW5k
ZXggMjgzOWY2ZTQyNzk3Li43ZjQ2MGMxNDE1YmMgMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL2J0cmZz
LzIzNw0KPiArKysgYi90ZXN0cy9idHJmcy8yMzcNCj4gQEAgLTI4LDcgKzI4LDggQEAgZ2V0X2Rh
dGFfYmcoKQ0KPiAgICB7DQo+ICAgICAgICAgICAkQlRSRlNfVVRJTF9QUk9HIGluc3BlY3QtaW50
ZXJuYWwgZHVtcC10cmVlIC10IENIVU5LDQo+ICRTQ1JBVENIX0RFViB8XA0KPiAgICAgICAgICAg
ICAgICAgICBncmVwIC1BIDEgIkNIVU5LX0lURU0iIHwgZ3JlcCAtQiAxICJ0eXBlIERBVEEiIHxc
DQo+IC0gICAgICAgICAgICAgICBncmVwIC1FbyAiQ0hVTktfSVRFTSBbWzpkaWdpdDpdXSsiIHwg
Y3V0IC1kICcgJyAtZiAyDQo+ICsgICAgICAgICAgICAgICBncmVwIC1FbyAiQ0hVTktfSVRFTSBb
WzpkaWdpdDpdXSsiIHwgY3V0IC1kICcgJyAtZiAyIHxcDQo+ICsgICAgICAgICAgICAgICB0YWls
IC0xDQo+ICAgIH0NCj4gDQo+ICAgIGdldF9kYXRhX2JnX3BoeXNpY2FsKCkNCj4gQEAgLTM2LDcg
KzM3LDggQEAgZ2V0X2RhdGFfYmdfcGh5c2ljYWwoKQ0KPiAgICAgICAgICAgIyBBc3N1bWVzIFNJ
TkdMRSBkYXRhIHByb2ZpbGUNCj4gICAgICAgICAgICRCVFJGU19VVElMX1BST0cgaW5zcGVjdC1p
bnRlcm5hbCBkdW1wLXRyZWUgLXQgQ0hVTksNCj4gJFNDUkFUQ0hfREVWIHxcDQo+ICAgICAgICAg
ICAgICAgICAgIGdyZXAgLUEgNCBDSFVOS19JVEVNIHwgZ3JlcCAtQSAzICd0eXBlIERBVEFcfFNJ
TkdMRScgfFwNCj4gLSAgICAgICAgICAgICAgIGdyZXAgLUVvICdvZmZzZXQgW1s6ZGlnaXQ6XV0r
J3wgY3V0IC1kICcgJyAtZiAyDQo+ICsgICAgICAgICAgICAgICBncmVwIC1FbyAnb2Zmc2V0IFtb
OmRpZ2l0Ol1dKyd8IGN1dCAtZCAnICcgLWYgMiB8XA0KPiArICAgICAgICAgICAgICAgdGFpbCAt
MQ0KPiAgICB9DQoNCk9oIE9LLCB0aGVuIHRhaWwgdnMgaGVhZCBpdCBpcy4gU3RpbGwgdGhlcmUg
c2hvdWxkbid0IGJlIG1vcmUgdGhhbiBvbmUsIA0KSU1ITy4NCg==


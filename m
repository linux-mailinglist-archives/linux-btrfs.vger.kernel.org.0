Return-Path: <linux-btrfs+bounces-19769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D803CC11F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 07:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED9EE301F016
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Dec 2025 06:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC3B33DEE5;
	Tue, 16 Dec 2025 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EGXackEa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oR6JIOfN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6630133CEB7
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Dec 2025 06:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866249; cv=fail; b=nJbFX3LsZrUljCGQS/hF8qUaZSSmU4Vp7LtDeaUkspPOPEoi6uVt4AFNa7PA/UcVxOj8NrkOHnAPfB1p4Mqu+V4UQqaSPIaFp985+kCAaDJXLid6Q7MiGVEecr3tr0qrJu8/vWhX3vFU9p9qa2oX2Z3FvKNPAPdvrc+XwYMn2T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866249; c=relaxed/simple;
	bh=brk6tLKReiEztvH6MQztX4uD1Nm0F4sSaN0xgulTXYo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mCgdqoHqWuoVYG6+mJG9/2D4NrtFrAkTc5ykST+cJDnKiGqBd460XKurNs88cNl0SahxhYo7IyDOrCoBwACux7Lw/MhVtsE6dKaynFUfflMkLhgp6v44dS7t1lHFkXApTkZnAVp3xDHyPfUrzH1TSMudW9eqbh+lg81eYBEu3YU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EGXackEa; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oR6JIOfN; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765866241; x=1797402241;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=brk6tLKReiEztvH6MQztX4uD1Nm0F4sSaN0xgulTXYo=;
  b=EGXackEaFI7uFmKUk2thB0uwJ/aoAu6U62Ay7ypiNRfmT8rjqNJo7C1O
   VSxizWtv9fsNHv4C/yeHm2OSdrzrYg1GSXWWbH7z9XtmkO5ojz4p3Ll7e
   xm+lGNVWL9ES6DRYjd+WatwGsHa9S6e/4z2yoqEBI46euDULlBhQhrEgV
   Wa6MxGWO5sE/NXoGmjU4+2J5tH4AmM5yDlLMiqB+WV0+tnlA4DT0ojtK+
   t3i/mwJHvZzXftW8GUTWcnPVl6qfB8tR6PUcW69DCoMBUpZ1t34J/PXdJ
   Ju58TC3dAnInRH4q1tvvivUmQk38omSqOyqUCwr4tW873o3k5xrmyKFMn
   Q==;
X-CSE-ConnectionGUID: OWDHo5RyRaCm/FiUAwPK2Q==
X-CSE-MsgGUID: WzYjj43WRkGOexhuPpIqmg==
X-IronPort-AV: E=Sophos;i="6.21,152,1763395200"; 
   d="scan'208";a="136589211"
Received: from mail-southcentralusazon11011071.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.71])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Dec 2025 14:23:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs4BoTePKk4sxFQnnngbggv98vNdK81jjPYsfSKqB7WzmHKc/esYxDh/F6wnGuFijTUUYu11yfAhOlkQlYVnGaqEoxuxx48KM+sEy9BIfb9+0c+gFuQr5Xe5wupL2AxO+bUnk9M56UIyf7IfBeXlLHuypwp5eknWw4KKgrEJxxXaKAcOe5yZEkEyITpuAjY0yOTSFNL3Cea9lxFl0sWCXmnVYSJOeroF6xY+qS+OpAUECsKTAh7KGDqR5RvrfbJpwvc2o35rBX6PyOB26Mj8d4d4ToeG5KAbNPpmFrqn1nli0RhlNa0GfLrov/h6IbwU/mCYZCYSCMlWYxgQuO5gwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brk6tLKReiEztvH6MQztX4uD1Nm0F4sSaN0xgulTXYo=;
 b=jhupx8jnTNmYXqX/kAjAooa3omaOZnapbWDdFRLK7hpJc6EabYb7nH15nlzbwzhp/pQEIRyWN+eNEMe4l9y3MvrU1++pX7UkEsDcBHRSllgCYpKGFSa/X0A+D81PXP2s7PceFo3M72yMOTcrlEIPQkQKU//ZsM324n3oYE6zxplxtUasCygObb9K1G61AshwQmuxRXf65kG0fBSVc8X4Qg1PiZ5R6fUlsjCSIRuYx6hjWvjz0+btAK/kOaqX7Xr+ifl+A1I8OiVJywHaQ6kOYM2ewIU/WsyRlG3IB1DgHtZMS50453gFjfVDe5Slj1jJUHyi+YOzDO8fmD54sWcP3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brk6tLKReiEztvH6MQztX4uD1Nm0F4sSaN0xgulTXYo=;
 b=oR6JIOfNipPQVES1RMy+a+Rw4Ch0bU7GUNe0i968hz1Yanux7A9xs3NMRZzs3eQ3wp5uk3/ckzKdlqY1kTqXFiSv6t01T1qoetAtHl08ElqFDNpx//D1/64PmSb3H93vedJEOh1RXfKs9YDYtCm9fgHVWmmzQ2QlA9UCGq2jads=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MN2PR04MB6448.namprd04.prod.outlook.com (2603:10b6:208:1a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 06:23:49 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 06:23:49 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: re-flow prepare_allocation_zoned
Thread-Topic: [PATCH] btrfs: zoned: re-flow prepare_allocation_zoned
Thread-Index: AQHcba8itXS3kkKJ3EWqeT7gL/y7f7UjB/gAgADFvoA=
Date: Tue, 16 Dec 2025 06:23:49 +0000
Message-ID: <a1bc2f6f-c029-4f66-9700-4ce3baa8f685@wdc.com>
References: <20251215103818.39805-1-johannes.thumshirn@wdc.com>
 <20251215183604.GD3195@twin.jikos.cz>
In-Reply-To: <20251215183604.GD3195@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|MN2PR04MB6448:EE_
x-ms-office365-filtering-correlation-id: 127d70aa-bc3e-4750-2bf3-08de3c6baced
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2NlMVpyRVJnWmVESUQ0VWxrMXdPdmRBeWVnakVrQ21ZZWxFbmp3c25vRzZK?=
 =?utf-8?B?T0M0THZCeGVWOGpTUUNXREpSVndBeEdCUkE0N0tydUxiOTM5aVdFR0o1Y01n?=
 =?utf-8?B?aUcxVW5JTWdrdTIwVU1ldW5icWxncHlINzY0UlIxczJUajZ2YTEvU3hHdUxP?=
 =?utf-8?B?V2szcGh2c3dpVnNrVnRXWWswNXRhUXNmRGpQRXlZVzJGTXJwQUxXWXlxbEM2?=
 =?utf-8?B?YnV4Wi9PVkVSVTd4Q21kS3Qva2ZUN24xWGNvL3Q1bVNDaEJ6ejQ1QWduZldY?=
 =?utf-8?B?QzdKeXpMeXFFa2ZaQmE4UXRTK0NXa0hMdFhGTStQRjFUdy81TGRWQUlITmhT?=
 =?utf-8?B?WVNySjdoUVpiSjMyUlNQSFYvSVYxS0VEQkxwcjQzTmNuaW91QjF6U2tnclpX?=
 =?utf-8?B?L3VQa3l4bEFBUEdLenBKWUVKQnlxZHJEdWVOOEZPUDBxV05kVHJ4TmVEcTZO?=
 =?utf-8?B?aDNhdzcrbGpwbU92WmI0enB2NUh3ZzY2MDhDUHlHdUdDODM0OVBnN3dSRGV1?=
 =?utf-8?B?WEpKU1Z0NFI3TXJxZmp1TVlJSmg5ZGExMWdPTm9FWmd0aTZ2V1V2OUN4WDl1?=
 =?utf-8?B?aDFiV1pnUDhvN08zT1o0a2J5QUgya2orcWNVL2c3V3FCeFBsTkpBclFTeU5F?=
 =?utf-8?B?Q092ZHBabTFGOUwwTE92L3ZBQVNia2NiZFlHNC81bkpXc3AzR25BZDE2Tm1h?=
 =?utf-8?B?TUJiUFVqbWZpTU1YRGdLK3d1YzI1K01xelFDaC95cHlHQXlTYlllYjJRQTY2?=
 =?utf-8?B?SDY1VWw3TW5lLy9tMHlabmhXaHJoRktuWTJMZTJvOWovbkpYUG5WSXRhR29W?=
 =?utf-8?B?UDJOeEdXTnd1aUp2eUxyTnlBeXlLQTFLcTEzMWhpZzlQRHd1RzZsS0NDU3V5?=
 =?utf-8?B?d3pweGNrTktmdUpIb1hKb1FvSDNaRE1nM3daZ2FYZHE3cVdrR0VpK2J5VzRS?=
 =?utf-8?B?SXVGbHU4QzRTYnVXcDF6UTdVYnBPTWpBcUFvNEQ2cWVTWTE4QzJ5RWhMeGJ1?=
 =?utf-8?B?Q0hzMmNLREF2SW52ZWJBVWFXNmI5c0Z6UWVrWkRpQjlNUDJYVzVoSWFGOFRD?=
 =?utf-8?B?YURJVkNZcGQ4Qmhvd05UelZmaWxxYkZOUUlPQ0pES3lOVkgyU1lrYkFIbkNZ?=
 =?utf-8?B?NCtRV0lkRllZSXpBY2Y2TDJkWktMdUpVakpIeGxDTlYvY0RMVzVHeURSS0VV?=
 =?utf-8?B?ZE5Sa1JWMDRMUThZUTVJdlJGVWRKbXJkd280SFU3WTRFUWsvS0dVODNEdE45?=
 =?utf-8?B?YVBNdi8xWmt4bVF2MTgwdGdIdnlHRENuUkR2TnVKS1gwSWhjTWk1R29QNW1I?=
 =?utf-8?B?a2dlTStrWGJ3WTk2ak5qeTVCL1N6R0UvTy9oZ1FoRUVnYWpKcFFZT28zL2xi?=
 =?utf-8?B?Ny83REdEa25OR3ZSNFcvekxMN1dvWThqa2pHaGlmUVgwZXlqQjliaWExb3Zq?=
 =?utf-8?B?eWE1YTNkWkJWbmEwa1ZGSC8yaTloZzlsM0hPbUlkNENHa3k5WGowSUIrWkp2?=
 =?utf-8?B?OHU0ZWxtLzJwTWxhU2dMczBCekIxMXUwR1NEL1BkSGxFQnh6U1BLenhYZ2lm?=
 =?utf-8?B?YWtoNk9VREtibnA1cGlyYUFRQTJTMU1JRGREZXBsWW5zcHEwTWJpNzdXMDFs?=
 =?utf-8?B?eUovUjFBSkRTU3RHRUMvUmZjN2dVN0pJeEtJQXV4NHVzL3hTVWNGcEg5ZURa?=
 =?utf-8?B?OEd1MXVBR1o4L3JBMW02am52YnBpTkN6RlJSc0ZSWWg4YUt4RGhhbitKMVVs?=
 =?utf-8?B?a011ajlWaXhpdHZUVHRyejlKMHlwbkw4MTlubzBHU1FXM1RyMGxYTGpsSmVj?=
 =?utf-8?B?aEJZTWZwWU9haHB2eFVxOHM3UFlQNlZwbThTeE9ONVF0QXRHa1RBTlBsMlVm?=
 =?utf-8?B?aVhwRE40UWVtS3NVcktlVy9xUExZbGZ6SzhCRkcxcU9zaDRUdEJKUDV4aFR0?=
 =?utf-8?B?MXpKUm1kQ3lKZzhWY0tiNmhyY3B5WG5vSWY5NzNBdkN3N1hBN1RZVEhIZ2xY?=
 =?utf-8?B?R0xCK0dDZGVlNjJ6SURvRWlpL3U5OTY5U3IwSlFsTldPc1Y1Qmd2Nm5IdDUw?=
 =?utf-8?Q?MJptPa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3dMT29TZUxwZ1dBeGRHN3JIVUUvZ1JEVHFLL2FHODc1eHNFdEt2eEJ1elEz?=
 =?utf-8?B?NU01MlhuMkdHRTRtNC9pckVoL1EwVnVkeVBxSEpkSTNnVWt0V0ZIenJ1Sldh?=
 =?utf-8?B?cHN2UERLYzBNbE8rNytISGF1K0prdzU1UXlxcDk3YXl4S1NTNWVaY1pSK2VQ?=
 =?utf-8?B?dmQ4djJjSlgvdmJwc2ttTUM4MXJhTlBZM0RyclI3dFNZeEliQk5ZWUZ0WkhJ?=
 =?utf-8?B?NCt0YWpjOE5WcElyTnYzcE9GZ0RyRm9tRFE4ZDJKN2lPcm44WkdNbFJ0QTZq?=
 =?utf-8?B?ZGkwTFNmMHVFTWJQcElpeTRUL3BiYXlBRlpTZm02UTRGZE9zTFJWS0RoOGxn?=
 =?utf-8?B?dGxjajVZQzRWMmtpUmRTSGRWL2NZWGtHVUU2eWxWdko3cTVmbjFSbXV2eFdP?=
 =?utf-8?B?YW9vVXVsQUcxdHkzZ3VUS05wMjd5MDJ6ZlpGY2tKNkI2RUFkNnZIVDVEaVdo?=
 =?utf-8?B?NSttMXFYNWlzUzcwN1FWWkJjT0h2eWRVN2pQU1llTTE4T2lTcXBEREtLL243?=
 =?utf-8?B?b2NFV09CaHNZUmc1RGM1c3JBTEw1d2dyOG9lVWcrOGJrS3VQOTd4aTJ1REtj?=
 =?utf-8?B?RnI1aldHWWVjUUZtdTF2YnQreGp2LzhZSDg0QkxYSEw2bytaSUVUWk5KNzAr?=
 =?utf-8?B?RGZMMjZyczI1cXZXY2p5eWZ0YTFHMGlDSVdscWxkcUFla2J4bFZPYzFJYVBN?=
 =?utf-8?B?SlA0VDRxL2o1ZjN4N0FYUzNFWTVOM29CSUFQaWw3MEt6dFR2V0ZVcWFhNjds?=
 =?utf-8?B?bU9BcEFKbzZQSmxOcnMzbEQ5U1JPeDlJdm1NUnFldDliaktncXI2RWZEMDdG?=
 =?utf-8?B?ME9vNGZ4RHNmR2xNQlFtUVFqYlBVdVF0RndBdW4zNlV1TVBTSEVlbTdvTGs0?=
 =?utf-8?B?dDk4eTI3WmNyYWU1ZEhqblZNYnQ2VWNMN0NpWXlvSWVXbnVLQlAyMHZZY1l4?=
 =?utf-8?B?VkJaT3RpYWRaWFYvb3BVZkFrZW5RNlQ0VWNaM2UxaThKSTcwaWNvTVQxRXVr?=
 =?utf-8?B?dUtOelBPSmZBWURDUUw0VkVEVkYrcEF4OEpicWtrM01PdFZsVkJEczJoWkpO?=
 =?utf-8?B?anZ3VWJDRGdoWkl3UWlHYitROC9JWkN4M0VrU1ArRzVTV2xReGxjdUNXTjFF?=
 =?utf-8?B?WEFOMVdZOUVGRUcrbzMwMllhU3gxQ29LRmpGRk5Kb3N3N2xvaVNkclFBWndB?=
 =?utf-8?B?Q1pNRFlCRWVjQW01MlBHTGVqQTRpM2lFK2RFOTg0aitlUFlYdER2eUZJdW5k?=
 =?utf-8?B?UTh5N3BNREl4Qy81SVFRWVFVeGwyNlB5T3lPN1JLOHIzd0R2a2xoRVJmRHhq?=
 =?utf-8?B?eVBNMmcydW9Zc0xYWnVra2h2cFRrNG8rVjVFRmNTYStsRWlTazVjRFBRTWcw?=
 =?utf-8?B?cFpUQm9UbXdOeldwWTdGejNhOTR4WTREeTExY082T3BVdDVCQVFPMkcwM0po?=
 =?utf-8?B?VFIzTVltY0lhTEo2ODR2Z2Qzb1R5YU54THBjYWF3dHY2VTByMzg2anJrV2t4?=
 =?utf-8?B?WDRRKzRVNk9hUWdyNmtCZ1p1OWpkeTYzaWE1bFRESGhXVU42V0FzU0swQTBT?=
 =?utf-8?B?d3JmaXVmQkhMRzJteHRES3lPMVhVcklXUkZ1a0F6aHd2WDBPM21kQTBxRDJy?=
 =?utf-8?B?cnBCeVVEaEF5Q0RkR3VpTW82YXhrdGtodENlaEgwMHNKQ2wyb1JYYzVOOW5G?=
 =?utf-8?B?aE90aTlGLy94RTIvenJ1Skkxc093Vk56TVR6dGhZL2lLSk1meEdabE4zbzBw?=
 =?utf-8?B?eXZtaE1ncjc2d0J0azZRSFF5MGlSL0E1SG9tSWdlZ1RnbGdub29URVR4Q2RQ?=
 =?utf-8?B?YjlrN1dKTDVtNUIrVUFadUxGTW9OZ3hiZ2lKdVJDK0ZWR2R5Q3c3WTExcTFY?=
 =?utf-8?B?NHpRVmJHMFpXeGVISWhIenJRK3BxTmlPWkFuMXpFeUViRUtmTEpQUmpZZnQr?=
 =?utf-8?B?aHUwRDhWWTB1RlBudldKQUZHR0tiVGZNWlo3anc0bzVRQnpsOVAxaURIaTM0?=
 =?utf-8?B?RVBidk1ZVngrQ0pVc0F1VVYzMFdXNHR6TzdvNUJwb3B0TjFCNDNpRXFyWWha?=
 =?utf-8?B?UmhONEZJWThvQStZQmZ4RHVkczg2ZTNHNFBnR0k5TTBFbW9zNzJoM0Nvcm9G?=
 =?utf-8?B?Y1FialdoeWtBcmtYeXc1c2syTGdwTXlOcyszMmJPMEJqd3piQTl0em9naSsy?=
 =?utf-8?B?RkpOVW1EU3hnb0xIUStUMEppblNWR1VmQ3Z1SkpyTnpFQUg4d1hOQ2gvN1lO?=
 =?utf-8?B?eDlCbUZVWCtXbHVHMnY4TkNEejNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57515104076AE44CA82CAB417A1AA87D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p9xGUBAhpmFJhd8DijBQ4Hayf6imo2ncK6+KrNNLAtzKlcxwyfauYryif1QEHUNFRNtdo1EGRmzgT8BkXfFT1tyP23ux2m5LrwJQ+VlP6kQ6u7uz3qWD48N2D+KrMCO3JQHmbPqoMZny2DUhu/DVmOrjHRY++nEwJS7rG5+SCyYPW779Y6puNSnKM2ctVYtgcXhBU0iG68/5goaijuTWB/CnhcDfl6FxSNI2/shVV+MW953yRfu3DUXiCJ0rom6TdsfY7UsM6xkvgVQVy1hbgdokkg1BGCkpXhzbk5H7Bw0/YZhFpawZNzRNsdGUXWbX3IlotCl9CPzNzNdZv9BgDOrjW0xQObe8XuUXPdFkeiHdR9xJDkKmHSXiv7K1bhvWJF9MReiyLHxMtQbzI57YwkYwZ/zV2PsItzLdC/zXyuLo3jeRoY9n6qcFQ5GKmR6UaZAtiiypYmPLl0zvBoug2UHLgb6iuAm25VxYo7JnjA1htp3KXgnj8WnYgYlZqMwsnv3LmpXZCS7fHrhPZfnLGWNl4ADqmQqkhU+erihTRhUWQlN1TOE4FuaV6McziUw4XnOeNHa4tuHT8QlGOY6wJsVIN77oMCXfTdntsYJFJuradK67D+Y/vKG4nrOVbJdY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 127d70aa-bc3e-4750-2bf3-08de3c6baced
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2025 06:23:49.3277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 57DDgZy79pN07D9ayqvnYXeLYh3dN/0+4m8n0v3usQ5ZHA8pjaHOYal3J5U9x7wKTB5pY8wNWzLZGOuSgTPCm3pv2GzwZ5coUpNjOM/5USo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6448

T24gMTIvMTUvMjUgNzozNiBQTSwgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPj4gKw0KPj4gKwkJaWYg
KGJsb2NrX2dyb3VwX2JpdHMoYmxvY2tfZ3JvdXAsIGZmZV9jdGwtPmZsYWdzKSAmJg0KPj4gKwkJ
CQlibG9ja19ncm91cC0+c3BhY2VfaW5mbyA9PSBzcGFjZV9pbmZvICYmDQo+PiArCQkJCWF2YWls
ID49IGZmZV9jdGwtPm51bV9ieXRlcykgew0KPiBNaW5vciB0aGluZywgbXVsdGktbGluZSBjb25k
aXRpb25zIHNob3VsZCBiZSBhbGlnbmVkIHVuZGVyICIoIi4NCg0KRml4ZWQgdXAgd2hpbGUgYXBw
bHlpbmcuDQoNCg==


Return-Path: <linux-btrfs+bounces-11514-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762BEA38A72
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 18:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C73B160B3C
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536062288FB;
	Mon, 17 Feb 2025 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k2sjrGo4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="b/wdyX+X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA2F2288F6
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739812376; cv=fail; b=uUIuKd1O7m6BDNxVq9IiEpCbP9/tsgK+MaKT2pUHEKekUs9lfIuWi+ZCQi6BEfBOzNdOcFcvOrnRRcUw4zp1Pup/qAHLGO3LhTgV+u/VHZH0Lu35QtxE/vOzvMRpM9oHoxR55ltjhCKOJlkTkVULtaIJkd/F7L4DRuHr1ep5OMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739812376; c=relaxed/simple;
	bh=E5qMXGiXPsPDf8ug8+XFa5wUAJLnzu5pHw6eLEcOsS8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MSHAK8yTB+QWrRZK3RlVfPlW/G4hcezDaRBXScLUGw4yFEBMp9kbT2kUUQw4r6EtWjwwiaNQXqzTBcgv8zFkIvbSAfDoHYqEtPS5ta9zNJHQHffiDgWaVsEbdEXlkHz1kcrGnmT+qt1g/IWpkD18/Aa2iV948JwDN7AfgCKFSBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=k2sjrGo4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=b/wdyX+X; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739812374; x=1771348374;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=E5qMXGiXPsPDf8ug8+XFa5wUAJLnzu5pHw6eLEcOsS8=;
  b=k2sjrGo4fPGRfA4hcbk7Ctcnue7+mQFlcutsap6o8Qas/2EG72SmwStk
   0Pj/IrF0MwKZz0g//xs9f9E31PQ9MYq0Sl95vHDfloT/47os7beP07JuJ
   tMCxqO71Q/ZZ9vrbXrYkJ4/+8rld4noh4ZVI5hgmDRl76jmzwS65TBNKJ
   c8BV1Zn5G43sLxtJD90xdWlEZdUsV1KUdPTiGGOvKBlpcjOBQjHapLYqo
   IR091pfY/+/xcJOd3GW/eKy6pzjI/EnbSJLb4K0hhaeTllBQzmCB3WIPM
   pZj3bF7MXALIVbY2kbDpmrt2Muj+GUhHhhPd84yHhMg3iFaPwIeC1Dru9
   g==;
X-CSE-ConnectionGUID: abVIEuJHSNyljqHKEl0LcA==
X-CSE-MsgGUID: 18p1sma6QbSISH2B3vM4gw==
X-IronPort-AV: E=Sophos;i="6.13,293,1732550400"; 
   d="scan'208";a="38671251"
Received: from mail-bn7nam10lp2045.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.45])
  by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2025 01:12:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbQoBrqdezPkANjfn2kXkP8hZ6f4528f/LcQTlBIK+wrYR9o+bB5JaKal2nnI4++k71CfayWAzmugn+XlPgWlIFWy+OK5KMyq+hqnnGL2Ywi8MtKtaIOXajiz6vItFa2vs52Nk/xrF8T8mMl5bYj+DIVMssKeva9Mt2+iWA0FVAQAm2mg2FrMcUzzVkEBmy9Th2CFKnO1sVAE+VnJtVlAxRSgdSBXtZalC6nV1Iu79Le7SoREofLmtzuE7ujacDt6g/+9ebnDSxAiglxnhM4ktgP8d1BXkxEEwS35xe2VJyde+x8s0GbmG1+4HxHjx1OF0LnEtGIQy2AQmaUHmX5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5qMXGiXPsPDf8ug8+XFa5wUAJLnzu5pHw6eLEcOsS8=;
 b=JICTtJmkAw5UNluaL4Km5unUK50hr/Smqrh6UTO+1xvTmuSZzK1DzNOrjU98j0aDb4mnp7tgkPVq7ewf6DS7IvW2vorZSJh7cG70tavXh0Ui+MneI+eH7jYiED+E2m11zCNRs44QRBOVQXAjg02fHSQhI0KzjtqgTaHZQ6eMgkrWaT5S4CTe+LDHMV7vKGXl+6WTfFgaUfVKOzN0/ew7KDCafc2MetESdQYGss8NASxfFkQvlcKRI5rq/+P5oNDrv7eqomBxq3jb+0dfS4VP9pez5niFmHauG+A4091tAs/zgv0b8uNe0ROEyobUk1hQTEDCkH3OA86BDhgahxttVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5qMXGiXPsPDf8ug8+XFa5wUAJLnzu5pHw6eLEcOsS8=;
 b=b/wdyX+XnFF5BiQXLe5up3IZj1t6zNP/q2B24RWh3QeEAzvDc3DN+aveb76BlVlTeXwRAv55GbVuJ64xmF8WG9WLqcALzqOlPIlrBciaM3+2OXl6xnZd2bygt55jHitcVbSj+2K7RSVMJpYZ4fUNh3IyXOK3W0xiL802GDcVVZI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB7104.namprd04.prod.outlook.com (2603:10b6:208:1ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Mon, 17 Feb
 2025 17:12:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 17:12:51 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/12] btrfs-progs: zoned: factor out SINGLE zone info
 loading
Thread-Topic: [PATCH 07/12] btrfs-progs: zoned: factor out SINGLE zone info
 loading
Thread-Index: AQHbgOUaldOrIlU8nEWOAZAF+WdF57NLvI+A
Date: Mon, 17 Feb 2025 17:12:51 +0000
Message-ID: <47145e0a-29f0-4bf7-ace6-97f226f73c15@wdc.com>
References: <cover.1739756953.git.naohiro.aota@wdc.com>
 <11de06f6243f4f048d19f105a170cbd6f8e5f4c3.1739756953.git.naohiro.aota@wdc.com>
In-Reply-To:
 <11de06f6243f4f048d19f105a170cbd6f8e5f4c3.1739756953.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB7104:EE_
x-ms-office365-filtering-correlation-id: 8a5cbaa4-6fbf-470b-8c70-08dd4f764f9d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDQyZlJhQjEwcEJkNFB2NndRU2tpdE94V1RNNis2RVhEQlFrWHVYcTlBZ3I4?=
 =?utf-8?B?TitsUjVVU21SYlNUMTFDWWl1N051V3NvVzNVd3NaU2FSQ0o4VFVSVmpudTg4?=
 =?utf-8?B?OWQvczhQWjkxUWd6WlJHS3ZTWnYxOWFWT2VaQTZPMDIycmRZY0dZYjlsbFRF?=
 =?utf-8?B?S0hDMExUa05KNVBEMFZ2eDJLdUUvQUIrZFVSc2N5aW1uUUQzNDRQR0hhT25N?=
 =?utf-8?B?ZHRWbkw4dExpRldoTU15dW1SaVNGdWtyQzVXbVUydGhuUEZQcWd1cVEwL21B?=
 =?utf-8?B?NWFKMGdvWVJYYjB6T2RaUEN5WWMyT1U3Znpzajk5QXNGdmYzOTFBYmQrelZ4?=
 =?utf-8?B?V2U5V3NyL1piWFZOZ0NHSHhTUEt2SzFCMC9RaFVldnl1MDFSRDc5bnJJNGFa?=
 =?utf-8?B?S25tOTNDNXNQTEJ5S2c1ZkwrSXVXbUdzaGwxQkx3RjVoRDBqSnBBOGpyUnpu?=
 =?utf-8?B?NEdvYmJuK1B1STYvQkI3YUNKYkE0OE9jQTZOUU9SOE9kZXdZUFJrY3owY3NP?=
 =?utf-8?B?enZZeFhXMTkwNzcwTE95OWFoSWhNUWlpck9GU2VyRll4K21PNU41ZWl4ci9i?=
 =?utf-8?B?OHo4SmVIUkRmblhvS0pydmJRVithemljYmlhSXJGa3R5ZklZTDhqWkZ0RUdV?=
 =?utf-8?B?N2ZpeXNSRnJVM0pBVEd3SDJodXczQVhCTWVUOTNHSnJPSTFUOTQ2ejFQYWhl?=
 =?utf-8?B?M2hMTE54VDM5NzIrRGFaR2RzU3dMT2dvVmp0TGNwMjB6RzlBM3ZwSG1vdmxB?=
 =?utf-8?B?LytFMG5yYXlvSE9sa1U0OUdpUVJzQlVFdkdSeVJpaTMxQWJtMFo5MGxQQnhO?=
 =?utf-8?B?bjRwMHlEZ0xJaWxrU1g2bTZXVThUMXBqSUgwQU1WYjRSdFFGM2RUM1Y0Z3lJ?=
 =?utf-8?B?T0NCNWVqeWNDSExBcS9RQUd1ZkVEcGxEbEQydXZ1a21ub3JVMGpDMkYwM1BG?=
 =?utf-8?B?Q3p0SzdUV1hEcUFjMEU1V1ZickROeS9FK2ZnZzdVZHJzd2IxTDc0clpFN2pH?=
 =?utf-8?B?amU5dnE1Y3cySWxBdy9uNEIzYkNEcnQ5dXlCSk54ZzBBa3ZQb1UyUWlGUGNy?=
 =?utf-8?B?VUVtOEY2UUFnZ0hsc0twVjFoNWRHUkJOdkhtOWV0eE9aUDh1dGp2ZTNocUli?=
 =?utf-8?B?UVBKT0lBU3NMenEzZnVORmswQUY0Rk9UZWFQcUtNald0L3V2MERlcGwxZXZz?=
 =?utf-8?B?MFFPNTE4NGJ0d3pBSlFwUUR6ekJ0ek1PRDNoZ0hhRmFKYTl6WGxTdjlyd1p3?=
 =?utf-8?B?TkhBRVNkZVpLNnh6UFNHS3hqNGJPTVdhOGpTYUh4Q2QrVUlpQUFoTTNoRlRD?=
 =?utf-8?B?ejN1djV1cW5WQWhpM2s5M1RYNmJZUDNHanBxYTZQaHZaNjIrdnFNSnFFbitD?=
 =?utf-8?B?SVF0UlNWTVgvN1pIYXp1WnlCcmY3NU5RYW16bFBVQ1M0TDVZZkozaHdkZDVG?=
 =?utf-8?B?eDVnUDBSbGREZlBzd0hmQzVQZjFMbndDcGYvMUh2UnNkVWNhalNmbE9EbHA3?=
 =?utf-8?B?SmtRamZZeEk1QUlyU3RYOWhYbld3WktZenJOK1JCOXQ0MUJhcnlNQnVCcldD?=
 =?utf-8?B?bm8yWGhmTnE1NFY3Q01neFluSzg3KzBqYXdTOGJjNFpzL0o5NU95dERSU09C?=
 =?utf-8?B?T0N6R1oxaUlIWjltTGFuTDFHUG5Xb2xpWi9kK1F6MzNqMEN3bllsK3FXUHBS?=
 =?utf-8?B?MmVGQTRIcHEwQmwwSmhvSDd0L3VURUJCcUpJOURORnBvTjJtYWI4M2F6VGh6?=
 =?utf-8?B?QWtELzYzWTcwc1ZuZkRRWjY2MGF1L01adGJ1THN4S2tEU0NTQ0ZOZ0FvdjZv?=
 =?utf-8?B?SWphUGRNMGdlWXpBV3hEYWdHRGxUWm9IbEtGaGg3d3FQT3FJN1ZaMUtnYVNk?=
 =?utf-8?B?ci9rSnNyck1qN1NTQ2o1bmxROEkwd2VJZVQ0a2RmMkdWSVEwS1NJNXhyeTk2?=
 =?utf-8?Q?pXdeNU5zbwgSDMiMMe+QExU7V4yVuI2w?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aUtsUi9KK1BJTmRvOFJoaWMxajZSOGRZK3hTZHRqZGtvL2p5NG50aEo5Vlg2?=
 =?utf-8?B?dE9OcUlaNEUzVXBrWXNkT1oxaEU5YytCYXI1T1BSMUliZlhHWTRkUkNsbmVz?=
 =?utf-8?B?WnBiNmt4aitaZGhyb2NzTHlPZVE5RytPMmRHWjlhc1pUSHVQZUhPWFF2czhr?=
 =?utf-8?B?SldMcTI2d25RVGp6WGVSNlFZa1lXejBxTTZxZU9ZQ1FqNTQzaXROOTVUZDJm?=
 =?utf-8?B?VkI2c2tINFZQSXRpd3gxQjJqVXpZQkF3VDRCQ1JLMzdJZk9EcVQxWW4vTldU?=
 =?utf-8?B?RTMybTJpTDlzRW9kWERMOUh2Um9RQ04wcXVIVXhVa2RSRWpNRGRkQ2txcFNW?=
 =?utf-8?B?cWhMQ2IvajBWRUVmRThpMzM1aWQ2RzA2b2NhMWRPQVQ4NTEvTmxXTkRaaWh1?=
 =?utf-8?B?SG1KRjA5L2NmZFBJMWpTWkNCOEs4ZmphdEIzWW82bGIyVUVERlJtU0lEVHF2?=
 =?utf-8?B?bnZKTUVJWXVyMWpJWU1vNm1pVERxNy9xeGZna2RXVzVYb2RHLzNGbVpkYW91?=
 =?utf-8?B?Zm1meUFocmpSb3BOQndPbXdCUVBzbHZtbjNRYmdqUUJkdVRmSEQrU0N0VVdH?=
 =?utf-8?B?anc1L2pEWTJQcGFtWXlQazZySENYemVUZG9pY2l0dDFGS2xXTWdpSVpNcGIw?=
 =?utf-8?B?N3R5Tmh4YjFxdGlyMzFmdVVJQ2puK2tpY0FYS3VRMjAxVUUwU0dYWVVILzBT?=
 =?utf-8?B?ZTFlb3hXWUY5U3RZZy9SWjZZUXV6V25pUFVCeWZVUFhSTnlweHplZXV1NmJK?=
 =?utf-8?B?QzA1K0VDd09ibmFhOUxPVUF4cXcwZFZiQVg4RjlGRUVDelZFeEVOcE4wcnJi?=
 =?utf-8?B?QVJMcC9DRDhYY1k4Tm4rNWpNaHBaaUtmVjA2N3prb0dlbkdNSDZRWWNoK0gz?=
 =?utf-8?B?UElyL3RVM0FtUy9iYXE3Vk8zSWsrNVJvTDRxV1Z5NnlXRkJnV2R1S0ZXVy9M?=
 =?utf-8?B?a0FWM2trSjUydE1lRUwxQVZ3UG15R29WQUU3Zk9DbXpwYVdiSDBjRERlL1VR?=
 =?utf-8?B?RjFhSC9UbElDeUR0eGlua2V2TUxwYUI5eC9KaVMxVHZENlNpeGFnSVh0QnlT?=
 =?utf-8?B?cExJY01zRCt6QkNmalY4Vm5rcGxzZFN3dFIycU1LSXkvTUxHNTVZNHJ0ZVJ2?=
 =?utf-8?B?ZWV2VWVtRHE3cFZJdlZsUjlCWDZCeE9qcDNuZnRNUHRhbnplbG13Qjl3LzVk?=
 =?utf-8?B?aEUycXgvMGY3T1k4ZDRvWDhhQnRNbTA2YjlDL1I4V2w5dWV6bHpsd3hCU2Vo?=
 =?utf-8?B?NHBENDFZY1pMUklpKzFxaFE4c0JvVXY2VFpJdW0rR3haVnJsWWNibE1VY2pq?=
 =?utf-8?B?ZmdpM3d1RUdZdXRyNzI3aFZQMjRKRHdQZVN5SXc3K3hBb25LcUQvKzQ0RXUz?=
 =?utf-8?B?bDZMNUJZYkJoaDV1c09kTHg0VVZYbEplQmg3dCtHNmgvNXV1VFhCcTh1c3du?=
 =?utf-8?B?QUFyWVVpMmdGeXdnZGF5dTJ4QnlmU0pxK3J1VDJjc1JlWW41L3UyN1cvUjRJ?=
 =?utf-8?B?eEZhTlQwKzBkLzB2R21lQ1NRNW5SbzJCU3Y5RzVGVm9RVjVqV2RIZnl4MU9V?=
 =?utf-8?B?akd1b3hhNlJYSFh1dlVYVFdYYTY1MnUxdEFpZHQzWGdJUzJNeGZLdFk4em1H?=
 =?utf-8?B?bDN3cGt0SEZaS1Vya1ZFZVpXTFp2Q2pKamhGYkV2V3NZNEg0NjJrbzEwNkFl?=
 =?utf-8?B?TDR2a254aThTTFVJWHVpUUhBMDFMNGxRRHhlRXlCSUJrWXZZcUxTQkhLOTlK?=
 =?utf-8?B?UVhTYjJsbmR1TUVTL2xwRFUwVnhBNWlpbFZOM3pNUnNMaTMyejhIWTFLWTlD?=
 =?utf-8?B?VmozRmkyS2xxeEgybm16UU9OajlEakRBSTREbGlFMlpRRDJmRUN4cUJhSytm?=
 =?utf-8?B?WldtMTlFZDlUcG1hQk1SQUsydHFWdkRUaS9kYU1pT295dXM5UGpYd1BIQ2da?=
 =?utf-8?B?L0VzaWYzcW9WcmpDZG1VQzNHUHVVS0JoMzhKVzV5S1FnMWUva3g4NjFpb1p5?=
 =?utf-8?B?dEFIYlN6L05lUW9VWi9kdHFQb1V4VzdseVZZRUFrNHJ0Y2FRS01zelhHUVlD?=
 =?utf-8?B?SUNGUGlIeUp2R0dVdS9JNklhSUVQTndkVTN0VGF6TkMrUnMyUjlWWTRTaEs3?=
 =?utf-8?B?RTVYNHQ5TmVJQktnTGE5TW1UNXNCTHRtcFNjUWZzRjNneXd5MTRaZDBodXJz?=
 =?utf-8?B?ZlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBC3D4A2C5A53F42B8E282F80EFF1D4E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iUk/EMCNCWZ7Nt0X63Vm2ppldu5nNmZOUoRl9x4VXPp5B+fCMSCJbbRG4qBOhkwQmhIfkCgN3+w32bB0L/nCbn3B3lPQ3MWVI+kgORZLWWCPBa/VK08YKGBkC5TY3FUup9gl8i++YrZjG/XXE1gFELpumQotBqCCG+5Az1ZDHfC7rVDNEZey1REOo3b+uySFeLztSDuBeWcllfap7q6iFnvVtLG2DeooJ36Y/cvVIqg//Ag1MSYwY22QR9TIMI2dKLEPIYF7+tAasVYtwRNHUhA5er0+np0hsabdHyKnPF9D4b3K0OWNiCZebJfdpdBSCmthj/ju0B7itXpKdm0TdooMwf7SVtqErePxYA7RSjrm6df6HKTKtdZo2JAX+FIKuwMLhbH5RjGDjMW9yz5ZZrzHatNXTJz6ly+K1s6OGvgoi2/lwiQtwhXbzZhnFLD1W/lpqIJQcOKwEc61q5GNWJvIL+D+D3jwr9qwXP1hOqx8on+zAsIpbigzGLuGck7eIwpR7YGgs1mqMguuQp4Tyr8efIFUO9FNlNvFZvI2HSWNDcLl3c7cmbz/iN+7vsF5q+m1UQcT31L5lhCcrzObXgW8q6fXUmGIN0PI1UdzsLoMI4zu9wMMbOfXGp2PGmQ3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5cbaa4-6fbf-470b-8c70-08dd4f764f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 17:12:51.6826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TUb5y7UBT6c5617JmjQeHz9pFjI+odlmwo+B9nsWuuabL9ophjVpwkpMCOPohGZTe2mCenTnSsLGtOZ8vdaFL8v9tP+2eP5gWq64U4yqZb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7104

T24gMTcuMDIuMjUgMDM6MzksIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gLQkvKiBTSU5HTEUgcHJv
ZmlsZSBjYXNlLiAqLw0KPiAtCWNhY2hlLT5hbGxvY19vZmZzZXQgPSB6b25lX2luZm9bMF0uYWxs
b2Nfb2Zmc2V0Ow0KPiAtCWNhY2hlLT56b25lX2NhcGFjaXR5ID0gem9uZV9pbmZvWzBdLmNhcGFj
aXR5Ow0KPiAtCWNhY2hlLT56b25lX2lzX2FjdGl2ZSA9IHRlc3RfYml0KDAsIGFjdGl2ZSk7DQo+
ICsNCj4gKwlwcm9maWxlID0gbWFwLT50eXBlICYgQlRSRlNfQkxPQ0tfR1JPVVBfUFJPRklMRV9N
QVNLOw0KPiArCXN3aXRjaCAocHJvZmlsZSkgew0KPiArCWNhc2UgMDogLyogc2luZ2xlICovDQo+
ICsJCXJldCA9IGJ0cmZzX2xvYWRfYmxvY2tfZ3JvdXBfc2luZ2xlKGZzX2luZm8sIGNhY2hlLCAm
em9uZV9pbmZvWzBdLCBhY3RpdmUpOw0KPiArCQlicmVhazsNCj4gKwljYXNlIEJUUkZTX0JMT0NL
X0dST1VQX1JBSUQ1Og0KPiArCWNhc2UgQlRSRlNfQkxPQ0tfR1JPVVBfUkFJRDY6DQo+ICsJZGVm
YXVsdDoNCj4gKwkJZXJyb3IoInpvbmVkOiBwcm9maWxlICVzIG5vdCB5ZXQgc3VwcG9ydGVkIiwN
Cj4gKwkJICAgICAgYnRyZnNfYmdfdHlwZV90b19yYWlkX25hbWUobWFwLT50eXBlKSk7DQo+ICsJ
CXJldCA9IC1FSU5WQUw7DQo+ICsJCWdvdG8gb3V0Ow0KPiArCX0NCg0KVGhlIGFib3ZlIGlzIG1p
c3NpbmcgUkFJRDAvMS8xMC4gV2hpY2ggb24gYSBub24tZXhwZXJpbWVudGFsIGJ1aWxkIA0Kc2hv
dWxkIGFsc28gZXJyb3Igb3V0LiBJIHNlZSBwYXRjaCA5IGlzIGFkZGluZyBSQUlEMSBidXQgSSB0
aGluayB0aGlzIA0KcGF0Y2ggbmVlZHMgdG8gYWRkIHRoZSBjYXNlcyBhcyB3ZWxsIGFuZCBlcnJv
ciBvdXQgKGZvciBub3cpLg0K


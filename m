Return-Path: <linux-btrfs+bounces-17043-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBF3B8F6B6
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 10:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A55417AFE8
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 08:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E452FCC1B;
	Mon, 22 Sep 2025 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DXvLEmUY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UOGBlgbN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C839EACD
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528653; cv=fail; b=lTH+HuC3vsSLxqNXhOj6J1rG7rfEl2awmng/W6RpO+SrQPfZX3DRIaF2uCQqL7se8X4C94fma8WQ1gVEL5nMrRvS6O3xLPAHw1QUBzEiPO6aYOpKcvjLSJ3IPh2vSrS2MzFrlncA8U7tPfB4lLvIrBJGpuiZzlB8Lx0z7jhilEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528653; c=relaxed/simple;
	bh=MTmgEclHWiDxivpFYrBC+z7/VKv73E05xuj2ufUUfNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oc2KXHMC4fhy//gK0eZDxb8W1ELgGaGrYaKKN1OPT9LbTtuMkbUb4gk3NnHqLN0EWyJMd7YLl7de8vhN7ozmqqZrYrL2wny0GDSGxDuC/cvfGTExBy1ccMSLupaScHstKkyG0QROZNAvyDeq2HxM4krpjrawOMZ/G49Ab38Jad8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DXvLEmUY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UOGBlgbN; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758528651; x=1790064651;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MTmgEclHWiDxivpFYrBC+z7/VKv73E05xuj2ufUUfNE=;
  b=DXvLEmUY8MoqZDkTW82woOd1wbV+qAomLrbgbv2O0WqEchcJZLohrGi2
   88IuOyfMpLyKqyRr/QOrwo7t+03BGIm2w9GMyY4Z8MgOLwCeeDNF9yekX
   SQJ9ozQjW5m8cCNpoHwtdu3O88LJvX3ZgLXwzKvKlfzCacY5yKEjWOBni
   wfTyMrSl3wqfxXnAxOKwqMcQL+OeqjOd1vAB386B7wYsnQQePZZ6iMHIP
   OnBijn0Vjt2VEIvEsFgfiIIcPxByKoMC/m9O60+TPtt57a993ZaFyhmQ+
   /B784uqTk1756Ky0GaW7u36YMBgDrcv3+c4/HobJ2dmsirwcxcJWn+2RU
   Q==;
X-CSE-ConnectionGUID: Syd2/izhRBCPM77MMHMyYQ==
X-CSE-MsgGUID: LgPwD6XRTcWJOD6ncemmuw==
X-IronPort-AV: E=Sophos;i="6.18,284,1751212800"; 
   d="scan'208";a="128001595"
Received: from mail-eastusazon11012014.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Sep 2025 16:10:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=te+YwVWFkeBo7tXLfYG1bAcGvNpjWowYmn3co2XRGPa2agWH47DyYMUQoWi30Q5Jr9sNvdofuNg3MZIa9a/FS8cZDv2cGeXmeACdBG9OIc8rQnDm0KU0Q7oE9nmE+nnCEsPn+bPGqhpc32RWzmlLpaJXwMik2GB+7hUONLfAQ0/hHHE9nJeCKGYnfSCiGodQC1Q0lNg/l62oCTqna0yPNrtgG5O9I1dpQHTJ0KmAsDP/U0XNXdm3BMFhsUnMlOUQexwYDuj/qdmkYbroOUElQchXsZ6cLgBqX8Lz5h2Uuy0wB0mv3VCrmQAF5pH1GI8xMdOe8ZfseCMw2pNm6Xc73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTmgEclHWiDxivpFYrBC+z7/VKv73E05xuj2ufUUfNE=;
 b=W7j6oPivQIWsXPpWu9WOrN9S8wy06sGvILC4BsK1xuyZjVY44xjGtD6F/0FM9drr6bkz6G2vKzSRUtsef9x+kL0BdcLhnfCsuSFepqrqhTmK2P6YV1wd+WexwZ3eP57OY1G/z332DjXIcxPvMCxIcMI5m3kTftvhdjZYgDkdFLYeVgc/cGOfPQD6RK4ST6n7Yo+IphPheBFHL4S6e6HMtXp1dFUrK3Bfwx1SAPi8w3756nSTJqsYC6GPY3Zy1W9XUnntNfo+W90n/mv5/OLfYXQ6Odx04Tl4NlqWvb4S0IEz+imCyKS99bgIuyBSPUNIolirOH8Sp0Tyj/JTsZGK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTmgEclHWiDxivpFYrBC+z7/VKv73E05xuj2ufUUfNE=;
 b=UOGBlgbN4qYeDb0fGbkKFlhOegbiEIJOFyqfKB6x1IkJxkOJPCzba+WpUmcpryVcOgd7pciPKx++KzTVI+BaAp9OvCj2tRoyqYNBbkVmJzPVX2N04cxai2DBIdUdxs+xFi05v7q//4eHG/d2ahwzyXxt5wVr/ZR4g8PU244LnLA=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BL3PR04MB8057.namprd04.prod.outlook.com (2603:10b6:208:348::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 08:10:43 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.9137.017; Mon, 22 Sep 2025
 08:10:42 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>, David Sterba <dsterba@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>, Yuwei Han <hrx@bupt.moe>
Subject: Re: [PATCH] btrfs: zoned: don't fail mount needlessly due to too many
 active zones
Thread-Topic: [PATCH] btrfs: zoned: don't fail mount needlessly due to too
 many active zones
Thread-Index: AQHcKIoycDwTtmMV1EuGqTdytacLCLSe302A
Date: Mon, 22 Sep 2025 08:10:42 +0000
Message-ID: <DCZ6CIRZP5KL.8U1RYLST6VJ3@wdc.com>
References: <20250918105119.41556-1-jth@kernel.org>
In-Reply-To: <20250918105119.41556-1-jth@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BL3PR04MB8057:EE_
x-ms-office365-filtering-correlation-id: 61511760-ec00-4270-eae2-08ddf9af864e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Uno4Z2pZVzBZb0E5WEVLYXo3OXVyaHV1ZW51VU5OUHZhVFRHelhrL21xNHZ4?=
 =?utf-8?B?VlNjMGVsRHI4TVkrdVpyYldSSi9iRnEzdm5Edk5FMUJmdDNKWDY3YWZvUlQ0?=
 =?utf-8?B?MmttRTBJNHZESzZDSDBzN1J4VjI0U0hjMGFQNXpyY3NNcDdFeExZL1ZvdW9C?=
 =?utf-8?B?T2k3NTk0YTZMYU1HSHh3RlhZOGh0SUJKOTR3QkhKOWVVUmFmZnY4OFN5NmZk?=
 =?utf-8?B?T2t1RXk5c3BUdDh0T0p5Y3VUYUs4STlCRWoybGxEVW80QWxGOUFvNXBZV3dq?=
 =?utf-8?B?cE1HS0hlUk9NVThXb0ZJNmpUZkQvb1JtUGlUc3djTXVpcFJYR3NMTUlMcXh6?=
 =?utf-8?B?ZTJaZ01hWEp3UHVTMHoyWGtCTjhjSVlBOTN1OW9VRTkxL1hSRjd0S1dSU25Q?=
 =?utf-8?B?L1JMOWVRZUJPNlZOMUcrWDcwWHlDS2kyaHNxK1l1TjNtUE5JTG1XN0h0eHh5?=
 =?utf-8?B?TEMrbW40M0FoSFcydlJTQU1YSzgrVFNrTXV2MWpVSHBFdktDM01PanUwbEdw?=
 =?utf-8?B?SDR0UDlyM3M3Y1pjZ0RvblpqaTZ0NnZzRjRuZUR3TExwTVJlOTQrUU1FenBK?=
 =?utf-8?B?eVliRkM1WldjUW9wVEVRU2VhMEsrc29ZNmFrMFZXMG10SmhLUmk3dkpYTnFJ?=
 =?utf-8?B?RHZGZ0kzL3NWVVNUakpEU2xlOHhucG1GNDZ0TDAxamdsbms5Yk1jRGU5Y05Z?=
 =?utf-8?B?K1JXRkxKcDk3WjU4QnJkOWZxUUhOdThvS3VUQXl5NWp1bVQ4NzBoWDlwOWkz?=
 =?utf-8?B?L043VU1SUUpXT0NCWDQ3elpPdXlVOHVVZEJoOHdQQkFQQVRuWG5zd1g1dVV1?=
 =?utf-8?B?VHFsSDNEUG1jZ2FBVEdDczFubTBINGFqTzVjR0JCbUV3dEVjalZ5U2wrTCs5?=
 =?utf-8?B?QmdDcUpYLzlVTlRGOHhBclBzRCt5UjdaRVJYZmFSQVczOFFkWTdEUnFuUjEv?=
 =?utf-8?B?dnVmRnZTaHVtZEZucDgvUTNGcDEvQVJJdXY4bU5aNjZTZlZnQUVHU1dVUmdH?=
 =?utf-8?B?ZU5GcW0vdmxHVmptZzFzYWc4S1pWS1IrL1Y1SWM0dFdFQUwvZXgxUGpCZVh6?=
 =?utf-8?B?a2lOMlRSZWdZN1BBTDcxaUhUZWFGd2xtWTJ5SzhSY3FmbU5EUU5UWWo4VVFw?=
 =?utf-8?B?NExDelliaHl4SlJNMktrbTZ3WU9WS2VXbDZBcjBQbHpPQjF1aUFuVFBMUHA5?=
 =?utf-8?B?NkllcTYwckY4eERSdlhSU1o4bkRRN2R2Q1RrWjJMUkFYRnpSTGtKQ2ZEbE1p?=
 =?utf-8?B?ZTJiVnI3SzFXNW1JYkNvZXE2d2FraGJtMFVWSHkzTnptUW04ZlJOYVBFMCs2?=
 =?utf-8?B?MzN3b3JWWnlpSm45M3ZyU3gzMUZXL1c3eDZhTjYyKzRWSkVmMmZkSXR2MnpJ?=
 =?utf-8?B?U2dmbmJLSm1vaE5KL0JGdlZaWkVwQ3ZLbDJuT2ZpL0Z2ZHVwRU83UkI1QXNQ?=
 =?utf-8?B?dVhYNzFocU5BVVhmWHl4OWhKdGtpYkZLZjB5WjJvY0lQcjNhdUUwMW1oNEtm?=
 =?utf-8?B?dG5wQXduM1BhWlVCZnJXT2VNTXphNU42anJpQjVtUDZRRTFFa2dlYlFWQ3RL?=
 =?utf-8?B?RTBDZzZ4Y011a2Zndmp6VWFTbzJLYWFvOFllRmR4UDBRNVlmaHVyREVRZkdC?=
 =?utf-8?B?M0gzZDM0VUpCSms5bzhOK2prZUt5WklQOGUwM012M0NSU1R1cnRQU1pNZ0da?=
 =?utf-8?B?ckh6LzVsTExTY1hWM2NZcjZrd2FQRWxKUGNWYVBaZHBMTHV5YXhxU3I3UHdM?=
 =?utf-8?B?aW9yR3FPUnlJUXJDNnl4NitzZ1QyRWFKcHR4eTVXQzI4RkFQY21UN3hFNE5k?=
 =?utf-8?B?V1JwOEIrVGRTckVVREh2NDVoZXQ4bDh2MkEyNnhjSEVvbnN4UExZRFZqMGNW?=
 =?utf-8?B?WUEzYjEzZ2oyY0tvTUxhSU0yNit5TlNQdVFVYThNYWFkZS9HM3J1YlpFdzhs?=
 =?utf-8?B?Q1pUMjEwRVZ1eWNNRlhOQXBmbW1HVHliY25Ub0wvTVA2anpmQWZFN1hudUJJ?=
 =?utf-8?B?N3ZRY2N3NHR3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yld1RzdlL3ZmNHlOQUN0OXZXOVJrT1pGVjZWMjYrRUg5VUlxeVZXQkxlM1hR?=
 =?utf-8?B?dmk0emtlN3gycndTWEQ5czI4TUZLTFVvY0t0R29JRzlwODM4QWh6SFB6M1Rj?=
 =?utf-8?B?Uk4xYTVLZEF4d3AvWDVBUjV3MllGSjE5OEpWY1g5Y3l1UnhpK3lIdDNycFFB?=
 =?utf-8?B?R0hvdCtLMlVkZHpJRmlRa25ZRjNWUmtub3NaSldhT0p5MlJFdnJkbjF6dmx3?=
 =?utf-8?B?UmY2UHVCNGxlNUJCekgwU2gwVGJCMEZJbEpqZDExZ3RQMFhqdVQ4b1JrYWFC?=
 =?utf-8?B?NkIrOWh5WU8xTTVLcG4zQzQ4MEdDaFgrcmE5d2gvbVM0SHk3OGo2cm45VEp1?=
 =?utf-8?B?L1dWVm9vTzFyK1RnWVNaWGhhWUlibUlIL2tReFRIOU9QQmFiemxMYUtkOGQ3?=
 =?utf-8?B?bFJDSTVKTVpRWGdHMEdLV3dDaWVIL09RWmdkV1FSMDVFb2NYOS9IWDRHVnQv?=
 =?utf-8?B?Y0tBZTdhU1Q5NFVFOVVCb3ROSWdEYklZZzlMT0N4Q2ZRTVBPcHQzRWRpWGJH?=
 =?utf-8?B?emFSb2IvQWcrdDVwLyt0S0RWbFJYNytla0UxRUhpTXdJU2kwcElwQVI4L3l6?=
 =?utf-8?B?dnV0SG1wNmNXaHBPaklnbXVGT1FHbHNzcEVUSHlMRFo1ZDJzWW02Wnl2TU1H?=
 =?utf-8?B?M0pVSmlqZkUxUTViZVl2cjVyYlpTaVNCQldYamJMWmtxWmV6aDRsdXpOYzVq?=
 =?utf-8?B?LzNyZVNhcHJEaC82djBZVUQ3QThRY2lyMzRBMUcwb1N3eWpKMUtvY3h2c1p0?=
 =?utf-8?B?NWVBRDJqMklQRGYrVGdSaWxhVVhISnVHWEZ0L1lwdTlkRzJlaWwwYU5HSHdZ?=
 =?utf-8?B?Nm5WT0pGeHpOZnEvQU42VVNjVFh3NXlKLytIcGFvZ1V1WnpDRWZmRGtXcno0?=
 =?utf-8?B?b0pDSmJpdzIzMXNnRHNsVlRmazFJb2lXUk4vVERCVzNISGw4Q1FmeHNRRmRm?=
 =?utf-8?B?WWRmS21XV3l0Nk9DditucUZEN1FaYmZwTCtQSjAySzdXYnJ5OVNPa3FTUnVM?=
 =?utf-8?B?YUs0ZWJxT253UDZGbkViL09XNm1wci9mb0RJRUFaL3pMMXBjejRrMDlseUw3?=
 =?utf-8?B?Nld4WFVObVhEQnU3VWd4L3cvblB0TEtIMlZOTktBOGoxREU0RWFWTmRIN0k1?=
 =?utf-8?B?N1I0ZTAzMHQ4ZmR5eHFqbzROM09XK0tTNFU3NXpLS000WDN5d0cyVTVEYlhG?=
 =?utf-8?B?ZGhuUVAzVTZqWVpBZFRHWW9oS29zUnEyanJqMGFIYThIdlBPVzhtdHZDNS8w?=
 =?utf-8?B?ekNMcEFpSStNN1dRWFVKUVVxek1ULzRDZjE1SU1vMlppRVp0dnFBaDFuQlpw?=
 =?utf-8?B?Z1JyVnM3QVYzSDRzclVPcWZHay9ZUmNDcTJiZmdETFUwVjZpSTBSdVJveG84?=
 =?utf-8?B?TW5aVWVuVDRuYTZ3b1kvUU5DTlgxOGJDRXl2MXJocll3N3VYdHNzaDFKTDN0?=
 =?utf-8?B?WWM5Y0tXZDQvWkhRb0ljWlNOQWhnemNIUFJJaFBZdzV4SE1sMTFkTm1tdlQr?=
 =?utf-8?B?eGtCa2NuMUNqVHhMTFQwZnV0RkVvT3ZEa2I1SW5seFYreEVmd2ZQN1Q1WTl3?=
 =?utf-8?B?OTQxclRyeXlrNnNMM0ZjKzl0V2RLNFF5Qm9rdjZ4ZmNWd1d2RmNMUVJQcEVp?=
 =?utf-8?B?L1ZhdFlpdWdvTi8yOEJiTEFJVlNFVUUyQVF5dEFsdm1XQXhaOTVXZU9UQ1Bm?=
 =?utf-8?B?cmswR3BrZkZNSGdsT3ZwdlFZMDNRK2Z0QWhzWk1WUWdNMGh6SVlnWnRpdXFy?=
 =?utf-8?B?U2ZSeDg5Ryt1Z1JVemM5OUJSUGkzYURnNTl4RCtpSGkxSncwcWowUGJDb2Vr?=
 =?utf-8?B?dlRPUU9nbTgzMXFsY0RjNG1yMHY1N05FZHNFQnE4Q2Z4b1o0R09wTGQzeThF?=
 =?utf-8?B?QnVXUmFXbitoMkxBLzFBbmtKZWZ3U2RoUU5SazZ1Kzg3VXRYeEdrdzRIVWE1?=
 =?utf-8?B?YXdJVjVRTnZodjEySEI4dXZ5WW8wZUtOUWI4dG9TODNOZEZUNFRMWG9TcUR4?=
 =?utf-8?B?UGRMeTNINHhibE5xeE1acmcraHJ3MU9GeUlQWllsMVA2OXcvNmdLamx4VVRR?=
 =?utf-8?B?cmkweGN5WUJuY2VmMEZ6dHc0Z2VXWjhPUU1GUlcza2htb1I2ZmkxWGk0VHRa?=
 =?utf-8?B?UXQrRm90UE53TXIwWENQc3NFS2FrZ0JTd1JVS1dFUytzb0tlb3FacEJrL0tk?=
 =?utf-8?B?anc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A47219138924154CAAE2B000CA3929DC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8x2a/njo0mhh7IhYu+zSNwjKgfM8oe3pAoA4qGC9AqKzFCfsI14ONnbbG8n1FtaZedCWQfCLJyIaK/t9gb/FREC3LO7VX2SoQZmExnXD8LPmP8M2VPRZLu6PLvuhOwIoJfp8HgCJOQv8y4Z6UU8QegYgImAvhXuyaPtRySMHjmS+4ZQHYyAgBOgFvAwVasnyaIxSLcmSDaweVW3NNhiGUhwjS8mi0rAWkaI6ZI7MYpOqD/Y4rmrwZrpfdb5XgWbDqSIwaNxeMKxlrPow5Sku/zvAk75P1ehxLk2rCRV2yWEOD8KLeNexXccc3fCEWnjTmNsQU5y1MGLIEIW+DrrXUU3OT05mwgNA16lRdk2ZxDgBOXGpbduUfwzqEUnocv94EB6Cy14vy7gj938f1MuzAEAAX1wbDY1YVnm5h/PExHcPgqn14Qv1FhqEXypkz2lfDZE4UbhDGLNwWJg9wXhg3B4egBqOF7KShXDxPlrxLPKoLiJwxWy9+qLXuCwSjdE+SYKnsS/AO2HADOakitqHO6Sl5RlSoBZJ2afmWL8tynMzlh4flw2ZltMG15DMS0EfG8tdGcytsEH6As87+1TObmFEey1d4Hcn3z7spc0NG6WepUa/itvaKaLO8d3Ng1Gv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61511760-ec00-4270-eae2-08ddf9af864e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 08:10:42.3970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IvUa9+JLmQxZpMg8j364rhEbbusQxwRYakKrjLnySo2g3E8ykPPjGzTNJMZi9U6M+M1tLJPROHPTKBrpvZEdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8057

T24gVGh1IFNlcCAxOCwgMjAyNSBhdCA3OjUxIFBNIEpTVCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdy
b3RlOg0KPiBGcm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMu
Y29tPg0KPg0KPiBQcmV2aW91c2x5IEJUUkZTIGRpZCBub3QgbG9vayBhdCBhIGRldmljZSdzIHJl
cG9ydGVkIG1heF9vcGVuX3pvbmVzIGxpbWl0LA0KPiBidXQgc3RhcnRpbmcgd2l0aCBjb21taXQg
MDQxNDdkODM5NGU4ICgiYnRyZnM6IHpvbmVkOiBsaW1pdCBhY3RpdmUgem9uZXMNCj4gdG8gbWF4
X29wZW5fem9uZXMiKSwgem9uZWQgQlRSRlMgbGltaXRlZCB0aGUgbnVtYmVyIG9mIGNvbmN1cnJl
bnRseSB1c2VkDQo+IGJsb2NrLWdyb3VwcyB0byB0aGUgbnVtYmVyIG9mIG1heF9vcGVuX3pvbmVz
IGEgZGV2aWNlIHJlcG9ydGVkLCBpZiBpdA0KPiBoYWRuJ3QgYWxyZWFkeSByZXBvcnRlZCBhIG51
bWJlciBvZiBtYXhfYWN0aXZlX3pvbmVzLg0KPg0KPiBTdGFydGluZyB3aXRoIGNvbW1pdCAwNDE0
N2Q4Mzk0ZTggdGhlIG51bWJlciBvZiBvcGVuIHpvbmVzIGlzIHRyZWF0ZWQgdGhlDQo+IHNhbWUg
d2F5IGFzIGFjdGl2ZSB6b25lcy4gQnV0IHRoaXMgbGVhZHMgdG8gbW91bnQgZmFpbHVyZXMgb24g
ZmlsZXN5c3RlbXMNCj4gd2hpY2ggaGF2ZSBiZWVuIHVzZWQgYmVmb3JlIDA0MTQ3ZDgzOTRlOCBi
ZWNhdXNlIHRvbyBtYW55IHpvbmVzIGFyZSBpbiBhbg0KPiBvcGVuIHN0YXRlLg0KPg0KPiBJZ25v
cmUgdGhlIG5ldyBsaW1pdGF0aW9ucyBvbiB0aGVzZSBmaWxlc3lzdGVtcywgc28gem9uZXMgY2Fu
IGJlIGZpbmlzaGVkDQo+IG9yIGV2YWN1YXRlZC4NCj4NCj4gUmVwb3J0ZWQtYnk6IFl1d2VpIEhh
biA8aHJ4QGJ1cHQubW9lPg0KPiBGaXhlczogMDQxNDdkODM5NGU4ICgiYnRyZnM6IHpvbmVkOiBs
aW1pdCBhY3RpdmUgem9uZXMgdG8gbWF4X29wZW5fem9uZXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBK
b2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQpSZXZpZXdl
ZC1ieTogTmFvaGlybyBBb3RhIDxuYW9oaXJvLmFvdGFAd2RjLmNvbT4=


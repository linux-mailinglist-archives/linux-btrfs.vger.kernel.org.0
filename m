Return-Path: <linux-btrfs+bounces-15716-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B90B13D7C
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 16:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12232189AF07
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 14:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198B826E161;
	Mon, 28 Jul 2025 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xe5TCY8z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gqv5vic0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8426463A
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713778; cv=fail; b=XO/HV5UkUtHsC5bej/K0NvzwMoiLRQ5siljoytNFhJf8z/rchXZWk5PEU2y+Exz9+OzrI9Z4x/5WGPSUfyJY6/d+JtYjJ84EU3De6EvbQM0MLvTY4N7ZiQWZMQ4RqG621c2/EERAAeEnInLr7qN259dN83fnNxxntWm73Kzk7q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713778; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yf1iOby0EYWAqiduu39n5pqun1IGrl9QZS7Z+1LqHTAcN6/mk1cDN7ZmmSCebZzTZUo+SBO8fm1ebHCnkR/jaaBgv/xQTeXew7SKv9kfqDY0DKTL/68ePTjE512uufHSBq8wIydqgc5/vlp7l4CljfhsxMjT/OqqVkOr0SmYxpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Xe5TCY8z; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=gqv5vic0; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753713776; x=1785249776;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=Xe5TCY8zxoI25yA8T75gBCzA0vI52u1TNKf8nkl90kNYnpT9rwOxs/1T
   X9kevYs2SnCbYObglBs4W8Xe6A6689/58dUzJ5RsTuwPq+3Tn/3o/Q/ep
   j9NFu9EVRe0wPfwkovLUY0MKSoC9JUF0GgEtO9e6R629Cbu6UOLzmXKBj
   89fx9eY/mneVVlZN9EaT6OtQ+dZzBbITylOx5juC3jSqRfMey0PDcoS8+
   5GcVpIc2kU98RS/wQhqT0kZbQd7vkNF154vf+hdUqSNmubnocrVuuvtcU
   KjIhcq6v66UtQZox2l5QAECyJKNXRSrMvWrfFYBVaXCYs/g/wDAnRP1ic
   g==;
X-CSE-ConnectionGUID: rpZHnPjzSeeiVSBotq/wSw==
X-CSE-MsgGUID: w4xV/g9XTe6J2kZbQYWUYQ==
X-IronPort-AV: E=Sophos;i="6.16,339,1744041600"; 
   d="scan'208";a="104025903"
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.69])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2025 22:42:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtHYGQ3jPLu5s78Tg4j9ItYWsnuw7SGMsg9nqUTEGBGaz/Yrj43/tnUPPjK9CQTZsbFmTpZBpmJNcDiTjkvl6McqgPxTNdi44CJh92cpt0zIcJR55VszMyGbjeIuDqMFJBC5Iu8QS/IAbRKVfyHrxsF6E0YLpSe5xh9fq7oC4J2Q0NmBPeRdF70AXzsLQnr3e9wDND4wZ/2rL+eKDFe1xcKE/pHxkz+pXAp0X8Wg1Z3YQcz7X6AXzrDk9o0wgMr6SSb1uewVB2EzVy/wbUDAq6QK9rGnsiUVnXEVTRJOI4OfG91Chm1+swbrfaIC8X+0EiGnRTAbdZGYOz0LKM8PmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=NHQQrkwngx56HoSOzmOZBCVZkoyLrC3hTZ5Ofn2E/kLBfk9Wu57oEvd7f1D/gFQbKpKPYE0lgUmXcrZc4M5gVIiO4KCTJe1UVsHUXqY7ZC6XJ8hDKu0YLP0qlDoopbTpw26bKSWPxJt9WY1wuYGpNDHN36dEWmIK7Ze8kNeaY3E1x1ZBpTKfYcpqKxceEv3UCVzOEYStOdEoXTszojUX7a+c+LcwRI3X4qo+DDerqTH8ToRuw0fow493BSwssCntAKEWoB051Y4OOGwnn0Lff3W117sbOidm6RDLcCPVoreDFLJN7JwKT5I/FThme6kfZyPwbV6kc4bkFh5RhvnRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=gqv5vic09N056OtGRjvoJhXJnGNB9uB7INPuaMly2k8eNDSWQSzLAk1EgzpcXMacvDB0g7xK5dPKb3wZM7Oc6tBFK9rotvR3rVwZoPcYbqzm6wjJyn911G9As/GEbQNynKH4MXs1sH3FrMjziVIXCyOfWDZrZKyqvI92mfpMQHU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7570.namprd04.prod.outlook.com (2603:10b6:303:a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 14:42:54 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:42:54 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: abort transaction on failure to add link to
 inode
Thread-Topic: [PATCH 1/3] btrfs: abort transaction on failure to add link to
 inode
Thread-Index: AQHb/6OYsYwEGpyDmkmWa2m/3GPPbbRHnIYA
Date: Mon, 28 Jul 2025 14:42:54 +0000
Message-ID: <af252593-c6f1-4ef8-9b0d-bd6a700799b6@wdc.com>
References: <cover.1753469762.git.fdmanana@suse.com>
 <dfa19dadfcb0df1f5ec2ec0a1b4f8d48b67c962a.1753469763.git.fdmanana@suse.com>
In-Reply-To:
 <dfa19dadfcb0df1f5ec2ec0a1b4f8d48b67c962a.1753469763.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7570:EE_
x-ms-office365-filtering-correlation-id: 5a58cc00-b524-4bb2-54e5-08ddcde50951
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bHkwcUNCKzlpQ1ZmNDNGWmRqZlhpUmtXV1EramhDZVRVS2hPek9layt4emtp?=
 =?utf-8?B?N0pjd2IvTkNJVElUdUtZUjZZZTJNbFpMMS9XRnNYWTFVcXFPWCtOT0ZwU0tX?=
 =?utf-8?B?dWFZYjEvR0h0VkJJTThuK3Y5NnBkdHVUN2pmcHRaYlVoRGN5SmFCMktWUWNJ?=
 =?utf-8?B?UkNycG85a09QM3FZbEw2K3BGSnYvRGZWV2U5WVpnM09Ta1lCVkMzMjVxQ2Rn?=
 =?utf-8?B?KzdpMDFhQzVKWDRhd0VQbnIrYXBGdzNtRkhPVVZ6TDJrRGh1VWhKaitaUkJ0?=
 =?utf-8?B?WTNnR1RWNUo5VnIxNmhVdndUY2Q4OExOdm9iaWJlNm0rYVM0R1Eya3pjbkEy?=
 =?utf-8?B?Q2REYVQ2YWZQYkNjRXgyTUkySytWUUF0eXhZTkZrcngzTGdTZW44UHhtTGdC?=
 =?utf-8?B?eEx5WlpQekk5VEg3RCsvOEZEUVhhMjBSLzZyaldHK3IvQ3VXWmhsZExvbWVH?=
 =?utf-8?B?c0QxelIrNGVHU29qbk1FWkZxb01VWWowM0s3aXUxczBCZlBxOGROR20rUHcz?=
 =?utf-8?B?eFNOMWJCR3VtN2ZkcnJmTkdZZlgxUjZCRDdwRlQyMTMwcGlubEw5UklYaHNL?=
 =?utf-8?B?b0UyMi9WT2ZIdjdMNGh3MHFscDVyZ29pK1RwWFJYcGZScUNDK1grbGthb2xa?=
 =?utf-8?B?bmkrYjNxRmE1Y29mL0xycW5XbGNBdVlZL0VnQlI0ZDByWTdBVnF1L05FLzhB?=
 =?utf-8?B?VTNjcHRpalhDbklYcm9UYXNNM095SldzS2R3VFdnbm9DS29uVDExbVByRVNN?=
 =?utf-8?B?UDBOa1RzYzZHZ01DM2dDMHlmeHREbHFHM0Z0ZG5lUFVDU0tmTXh4RnN5RERW?=
 =?utf-8?B?dDhva0NyV3N5ZWp1K1EzTU1IYjBMUG1xZGFQT0NZaGptSm1ubWdXVjdqbEJz?=
 =?utf-8?B?K3FQNHpDdUUxTHVncjNOV0xOMGh4ckVtYXY5Lzl4ZjdwdUhDWnluMUYzV3lj?=
 =?utf-8?B?YkF3YjRvR0NpZm84QjJ5ZXM5MlI0U29qelFSVDk3WlF0L05kV2pEMGE3dE4v?=
 =?utf-8?B?U1hJSHJ0S0UzR2tJeEJnei9jSUtHdG1Db1dOUnpHY3hVVkRpTU5tbXp4Zldn?=
 =?utf-8?B?bGdPK1V2SkIxWE13TVhQZ0ljL3U2dURHa2IvNmQ0eG0zTlI2N2N3Q3RxYmw2?=
 =?utf-8?B?QTBtMU51bTFtelV3dFk1ODhwakhHTXBuWHlrcDV2aC9mNXV1NDUxQjVrTDRx?=
 =?utf-8?B?dE9CcVhDYklxODRMU3E3RitDbEhFTkJHZ1pIK2lVazBCNnF3SHRMaFBrNGJI?=
 =?utf-8?B?aTdITHhLbEd4UFdpaW1UbE54d2lOWVlnSUlNWVlhQVc0SkJlZnJadlZYM2t4?=
 =?utf-8?B?RlZkWGJxeW5mNWRzRHdWWW1FZGtlMVFHWXNPNUVoeHZWQytHdGg4Z2haUkM4?=
 =?utf-8?B?ZjVCOWpoM2dtV1N0UWZBUCsvYTgzT0VhcVJrWWdOUlFqN0JRR3dBWi9LSHp3?=
 =?utf-8?B?cjFyWGVyQWlmZHFWWjBoQXo1QXhTUTlSdUxjYlBDb0JmZk5EZ28rMGpLSDNs?=
 =?utf-8?B?d3hCN0I3R1g0ZVZaWjhyMi9qcG1NUXN3QjZCTnA1ZkYxY0pLNngvVTY0RW1U?=
 =?utf-8?B?aVlyc1FXMUk3RHZ3eUJmYWhJQzNsYkNiZXZiUTUyWHdLZ25OQ0VQK2M1QVdh?=
 =?utf-8?B?a1VnWS9sOERqMGFHQjhPcko0WWJmd05hUVliSVZrZmRONldOS3lnK082eWlh?=
 =?utf-8?B?NzQ5VXRqRXcwN0dTZVljdkxKamR6Sm1lMFk4WkxjM21oYW8xYVdwaDhZdlhi?=
 =?utf-8?B?WFpuUUs0dTJsc0lqSFpkZzMwYlVnc1B4cmxVcUJUdTJERDN1S3p2dmhHbVY1?=
 =?utf-8?B?ZU5YU3J3VmdyMWl6Mzc4N3dIZ2szMnVGVDJWY20yZWM3ZU53Y08xL2U5b1dk?=
 =?utf-8?B?c1RJaGlBVHM0UW5ZWXA4QVlQZDNHTndadDZBY2dBb29DQ05mTWR0OXBLTVpU?=
 =?utf-8?B?WHBwczFwQnFxQUt5SFdHWi9VUHlwc2hxUFZFWmZpSURreXM0ZnovYUlRVm4x?=
 =?utf-8?B?ZU9jN3JsOWR3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1BMQlhGNFUxYjIzaGF4elRNRlhpUmFzY0g3WldPZ0d6YkxNb2U0eHZsdy9Y?=
 =?utf-8?B?NDI0ekoyaE8zcU9SbEpaNml0djJIbDBIS0I5YnpJTnZrVTdhdEtCc3hUN1Rz?=
 =?utf-8?B?N3BuWXcyL1ZYaXViTWpPUWJiN0UrcVdCL0lzZW5OUmdLazV6R1lVbjFSY25R?=
 =?utf-8?B?aFRsMEQyTXc1VHMwMlJDU3dBeFdGZ3h2M0FHcDdnOWczYTYvS3ZZSVJIeE8w?=
 =?utf-8?B?cHc0QU9hUVYzQ05VME0rcjZld0pvUkNBbTdSc1R2N0IvOGI5elArYThCcnAw?=
 =?utf-8?B?RDMrREt1SFYvSFFYelNkTFExQU5tVm1KSlhDVzNHU1ZKQ3ZvdkVXbitWZ3ox?=
 =?utf-8?B?V0JaNlMrN3pHTzdoOElUVzJCd1krcDhvclZRaTdkdzkra2xPNjROVXJ0MWpX?=
 =?utf-8?B?M2h0aDBiMWF4YldHYVVucnJlZFVWMmZJRWRJc1pSOW5oMHNyYkVEOVlFdmYw?=
 =?utf-8?B?elZsMEo5K3cyYjZIaElrSDJJZG9RWk5JZVpZb2hpTnpkSDNzZ3hhM3RjMzVC?=
 =?utf-8?B?a21CeFRRYnF6Z0FHSk12SWorRVhYb3U5eG1kWUlWc2ZCeDhtaElWcFNsV3pp?=
 =?utf-8?B?bG8vbnhtaG1odS9SNnJmaFBFaFlrWURhMHc2WUdNeWJiSlZCM0RldnJRNWRk?=
 =?utf-8?B?cVlueWhNV2RVZ3JvYTV1THIydTkrWmJMcUViTlg1SE9DbUFjeTNxWTBONXNk?=
 =?utf-8?B?WFBwNmtJc3RKTWIwNEg0WlhFdGFyWm5NQktHZUV1T2E3VkZMTWtNSGhTNXJv?=
 =?utf-8?B?bVZESE56VkF3SU1OWmY5MlZPdDVrYTViTDRhc3lJUXVkK3NLUVFHSnR1TVZK?=
 =?utf-8?B?OENPL3Z3UjlwYVFPYkc4T3VQNjdtaXRqVGQxT3FIK0lLRmNBTkpIOVhpQ1pt?=
 =?utf-8?B?OEJlRS9XNTVRSm1RRWRWV0czNWpLR3YyU3hISzlDU1c5T05waXJILzBWaWp0?=
 =?utf-8?B?d09NR2o4Ni9sWkdFWEJJaTljRm5CMjZLNVI3Z1drcE1qSGxsYlpWMThOU0ZP?=
 =?utf-8?B?ZGlZZWxkbDBlbitkRll5RnIwbEJ4NUdTM2t0aS9iSEloSklYL2pYVVFBRURF?=
 =?utf-8?B?ajVxeVlIdENzTE5YcGJDRFBtV0dRRFdEV3NZYjNadHd6dUJkYTA0R3A2cXNm?=
 =?utf-8?B?cEF4Wm8xaU5MTGkxaUt3TTQzNkRlSFptYnNNUDZEQ2xuMUFpOUZxUVNRZkdU?=
 =?utf-8?B?dVZFb1JnWkQ0WE1uQWVoaGwreFRQczNZaWtxNThLOW4xNTQ5LzhSWnhRVTlv?=
 =?utf-8?B?OXI5ZjJjWDJyMTZuR3dMMjg3d1lKUGpUaHptOWRTNzhnQkhjMWxxVGk2ZjFm?=
 =?utf-8?B?dXY1d1UxQlBJdUZRMWJvVmZUSlNyVEdCdEwwZDMzdHVuVW1iWWMzd0N1SHNV?=
 =?utf-8?B?VFRlbDBDUTd1ZWNYUDZJSWc1eENaQmpqOWtwK3owS040WThjK09ja1RnN1ho?=
 =?utf-8?B?QUgzbzRPZGdCdng2cGc0b3lSWEkzZFJFY1JuVC9yc3JoNVA3UjgwMlh4dzRK?=
 =?utf-8?B?dGtFRW44R1IwSVBNTEFHVzM1QW1xVVJkbnRXdGpHc1p3Vkd4cDE1Zng5TUlR?=
 =?utf-8?B?YVBjNUlDeHZSMHp5eVc3WDNFYXExR0pDMkVPS3pHRjd6QzBVUFE2SitJN1lF?=
 =?utf-8?B?SmdtcHRFRlFHYlJvc1pHdTRGUFZnQ0gvR3FBb0ZXK0lTSDRPUHFaVmtDbXRV?=
 =?utf-8?B?TDZnd0hTd2ZRY05PbjRxd1lJWWxCUGV1VXp5YlliQkt2K0t6dmpLZEJnbDVy?=
 =?utf-8?B?Y0tnVFE0L3BRdS9QRFk5YkxQS3NwT3dDNnV2SVRhdExvNVh1MVJGS3AwZjRx?=
 =?utf-8?B?cFhrSURMRFJpQ3RNUUJ3b1VXQmdtamppaWR5OEs5TW5vU2dkSHlDNHVlR01y?=
 =?utf-8?B?akcrVHcxUlFaemYvZ3FZOGNlelJuNlJoRmw3a1lsYTdGdHhXb1o1RHNaZ3FO?=
 =?utf-8?B?MG5VM0Q2VDhOTHE2cFVjbXRNcHJYVDI0cytaTU1NWTZZcFVteDYxMnBkUVVs?=
 =?utf-8?B?em5TWGRnZy9XVkhoL004NGYrbCtHQXp4Q3dPOWVWYTd2UmpVRTh4Mk5kNTJL?=
 =?utf-8?B?Ni9ZMWlWRklESTRhalpicmx4UUlZblF5YVA5SXFlY2Q2KzQvOW9Xai8vL0dN?=
 =?utf-8?B?VHhickVkQzhUbVlBVFpkSmFJVnBUODZmM1JHK0l2aXdWWXRGUGoxeUFTcm5W?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56C536A3DA3DAE47959F9C011835F0EF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R5L8Qu43K88DEw9m6z/MUy12PRw4mv1vFegdAUPDFpoeltNp/FKKKkerd6QOlo8+DiHS5aB4OsWRZeO8HozItOJGuPKDuFsOjw0CbKa2tTNIJjJOkjQhW61oilC8bnPaM9c0606KPHJskEv8f5k2pfQ57+oy170LsuQKWtFo7KW8GymVQGEz0K6N6YQxMbjjONbqjMQ5p8nlQkvhq4hb0JphE+fknGz7NB5vCYdm3wIQPXYM+kSmogQEfd2vN3YP5DntJXqHPfwn68we80JpL144G2OhGOyPEEVBprYRiPLofLI3ltMHP2/xWDrCZcwiajRIbKCAQt4WaXWpzfsM6CSRuwMpcGye27U2v89SksFSgwqHIWZ6BfUhWsu8wPvaIO5hazp9XxYQLupIp+xI/Hc4GCuoTa4L/+MQGAxL2n8c4CPHT1UEyD8kRZHumsizuHzxy9rDTE68VertUcX4agX++l8ZULYv+5mG1hdeRJBirCyfWA/9PD9uTDLzQyDOqur0GVFD+h9z2cedVdkVcbaGKfm7jXfaX1PzK1yUAudd1LypujYiaokNaD9HppprQAyVx7p6WgXnlm1VOGLO7if9M2ZfF8qqoCtkbI9NtPjpZKoY2Gsb+0CRISK2QrbU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a58cc00-b524-4bb2-54e5-08ddcde50951
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 14:42:54.3574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAJbhGQTEFByz1AygJdRv2UAxFjWHg7e6p7GLJByjJhPpNXMuwTOymYMtDfFW9DQk3rdpDLo314FrGGwIbuZxpgIjWyCsYdBiS2rKwNLsFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7570

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==


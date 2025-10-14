Return-Path: <linux-btrfs+bounces-17771-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CE8BD858A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 11:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2618D4E3E5A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595C02E5B13;
	Tue, 14 Oct 2025 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FDN6lM9/";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="miblOAwd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B915E2BFC8F;
	Tue, 14 Oct 2025 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432662; cv=fail; b=FK9hO8R5T+LUNA7rdJe3StbJZCRKklWjpen2VQxDGbwWw+C/OuRjtx7V2JsDpA24hMkZJQqVfwflDyo5ZUZBXwZq9vilr6AFyhdy+poxGlXrZ7SFTej453njvY5zzqVqIOpiw6+ypHIs2rF8IBlk3fvVmEm/lf7r2+Y26kxEVZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432662; c=relaxed/simple;
	bh=grVaK+NhQJbQr9eOAmkZc8m+abERKQaOtP4RTroXkOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i52ugJkj2GK0nlTwrLDLfd6RjUC6D/UQzwjBF1tXGEUvMaQVPTvLhXk/IqngwuC15TekVQzn0B228dlD4PkVcpdItAqlhiHOIccXtcLgiyKjX2JRm19MxixINrtZckHlA+xOrUY8O5MlMeSSAQsw8nooKiKkNiL0KxOFFi6/7hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FDN6lM9/; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=miblOAwd; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760432660; x=1791968660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=grVaK+NhQJbQr9eOAmkZc8m+abERKQaOtP4RTroXkOY=;
  b=FDN6lM9/MXXI+CutTg7zeey40+oQQfeIDV9eGASHJ1qCchZ+HWW2feVR
   PLpds3m3JXs/JgZglT2XIdGLmZvpRWYNqZ9Q3FgfVBb7kNGkZBM1eZV3+
   Q0hkIWSB2cpqCBNcArBCT/1dKcKibc9kxiYhW3ppIWKbJ5j4mIxA/+zH5
   P0RT5M0S27I64e2M68gC2Kkx5OsNafUpd9on7i0LKHzF4v+HMIngtSzGS
   BuI86kE7IOpLXMy54Z1U6/lwyNEEli7Rz8d4wGtc8tr8zm8GP+2+Da9Q0
   RHk4eTXXxUFEtm1io+keo+qY8BJpUmuWokZZIHBzN7eTOH01huc1eysQa
   Q==;
X-CSE-ConnectionGUID: DSBoHdUnQgmP/nV09Io8JA==
X-CSE-MsgGUID: H7M/5PM6T0Ov8j/ghCiwag==
X-IronPort-AV: E=Sophos;i="6.19,227,1754928000"; 
   d="scan'208";a="130181008"
Received: from mail-eastusazon11011054.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.54])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2025 17:04:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkJpCl5AcneKNNMOkuo2+im1juQWki8xo3FHXqtEQDXO6ODbBTpKDh0nwIE8TtIj8VfVeeqDYh3Mk405FFznZ6hxTs9rR2rvE0aZBHQMFttN4FsIJjC+c8Jk1uFhvEqC1Z1Q37Bw4W2rlge75cxhTv5ezMXsQ8qicGX3JakqBy+DnLbzA+6YdfHKn4cC4q36BwxmKgSTy8XLiwkAh+9y3hGo1xTaDMjFDuA0VJglkFA8kRS1bRpH6Sk0BkGbsOCdrIAoe8Wf+BQrpdjEUiOviH+cNV4dBxsN7jCTbOgzcNa/j+UEUGU6OF7Ph5lNkkjwZIcxBigQgIIrHrM2fipM2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grVaK+NhQJbQr9eOAmkZc8m+abERKQaOtP4RTroXkOY=;
 b=Fjy4V1xe7yIkeH+eoIsK4e0jY95UTza9TvhD2J8TaC2HLqjPpgB6s0nwIuexbkv8uZoQsHbYFShK7XCvLdmDvbvY6bs9jnCTdMzTigpZ2a1SYi8aNVxRk/oHNXRFYrhpxPrCVqkubOPR/jOYymFgT3XqdoSBY/Qcs3wYHhPFKdmTecA9cqK5L821mEciwjkqE0EbQe9EmfWWeYvORUUdWXWoWhL1JVbskdVGNPhirDp80QUFKdotxu880szjDj5LNUKRvVo7fp0LehlNytHsxFbULSvmpjtui1wrXPq2ReCDZt1aLmeDXAz4ev783in2L13EiHEqyYHO+kgNp7jjkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grVaK+NhQJbQr9eOAmkZc8m+abERKQaOtP4RTroXkOY=;
 b=miblOAwd1/Fhl8XMM5DhTWgcYx0KzDeWpiLieSs7QF7Vjhitbb+Q1LeO3YqY+jpxrdMb3sDl0eKUhwhzuaKLWo/RoxjYoNgugKS5+wEvdkoAcNrNhGei8bsp6bOLf0RQTT4k9rB9rB+ikEGjylrbch0f2Qb5P/6P4qgMRco0v24=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH3PR04MB9054.namprd04.prod.outlook.com (2603:10b6:610:175::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 09:04:17 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 09:04:17 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Zorro Lang
	<zlang@redhat.com>
CC: hch <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Carlos Maiolino
	<cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH v3 2/3] common/zoned: add _create_zloop
Thread-Topic: [PATCH v3 2/3] common/zoned: add _create_zloop
Thread-Index: AQHcPBiHuNDkQUy2cUuVSC0FTEWYYrTBWtaA
Date: Tue, 14 Oct 2025 09:04:17 +0000
Message-ID: <DDHXAL6EI91X.SKILMOTMNDQO@wdc.com>
References: <20251013080759.295348-1-johannes.thumshirn@wdc.com>
 <20251013080759.295348-3-johannes.thumshirn@wdc.com>
In-Reply-To: <20251013080759.295348-3-johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CH3PR04MB9054:EE_
x-ms-office365-filtering-correlation-id: 5ef2dea3-877b-40fe-fffd-08de0b00a7ce
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGpHSG5zejBHRHlHelpjSWNXNVMzMWdzdGZjM1FjQW1kOURJUXovQzNSVVND?=
 =?utf-8?B?cThXYlQ0ZkJ4Z0pIVzkrQ1JRTm5JMitKU2ttRXhGMGc4cGhHejhqRjZ5OEhV?=
 =?utf-8?B?SjhuMEsyQzJ4WWdwZzJsSXMyRXp4NVIxV2VvZU5UcXFiWEhPL1ZwRnJ5Mml3?=
 =?utf-8?B?SE9mK2d2VmdYTklVaGF1TDdvZG9xRUdZK1FXSmNwQ0lqektDZXJlelJ3RmJn?=
 =?utf-8?B?MmJhbElwdjFza3hWVStBQ0ZiMWVNS1FDckZ1aDhESmFpRFlKOUF2dGhoTG9Q?=
 =?utf-8?B?KzJuUThKZngrb0ZKTWR6R0hWRmRsdlRjVEFzRUczZU1MRlBOaVF1UDBRa1Fx?=
 =?utf-8?B?VTRNbk1IWkI1STNMRnJyWVdlZzljMXpkekxkWTRFNXE5Uk5pTzlBVU5vaFZX?=
 =?utf-8?B?L0d3cFFyZjRFVCtxcmlXTWpBclRLQ2xGbFN5b1Iyb2RwSzJIdjVHRnhacWR1?=
 =?utf-8?B?bUQ5SGFVSk14VUtmaExuVjJtR1M0QTZ0dVZEczFlQlNZallVamErSTZBMzlB?=
 =?utf-8?B?Y1hWRGxjaDdNWC91NDRHR1FldDJidmF2QlcrZFY3R0I3bzlOQW9mazVPWEt5?=
 =?utf-8?B?WGR5VlEwclF3cGpOOGJuOE9PQjNEQk1OVHpycmVnRjFIUnhtWHJVZncwSTFj?=
 =?utf-8?B?WHhIdllBWksvUUJjcVBTelBaT3hFcWJEbEtIVW4wUzlTYTFUL0dDWUlDYmRv?=
 =?utf-8?B?RWFwdEVSRm9XNm1HN0twdVJZYlFsa3FwdXpSazZKSWxsaHdNbHFkOUdiVlNT?=
 =?utf-8?B?YUVRQkVtd2R2TjdmRW9qeGRrbWhRaW4zd1dkWEJWekJ5Q2Y0UUdhYjhWN1FK?=
 =?utf-8?B?a2tMcW92MVJpY09GQlg3TGYyZmVaT0lvelphd2hpeFNVcXp1SnM2eGJHU3Vk?=
 =?utf-8?B?amNyUXBhNVlteXZJemJoTHk1bVJFekFaWEJwOUtqcnBSYU5KWExuZ3I3NVBE?=
 =?utf-8?B?ZFRDZ0k0UHJVWnB2VW00Y3ZzaEc1VjdTblM4bVB4UFVHWjhsajVENFFUd3RB?=
 =?utf-8?B?alRKc2dXcEd4ZTRVYVB0SDBJM3ZuWExrbDNGWGlYeXdxQ3JxOUZFQWpRTTdP?=
 =?utf-8?B?UjQ4NmhFVGZoaURzZWZvRlBtcHpXRmFQOXc4TGUxWTYzNnRzb04vV1dXNGhy?=
 =?utf-8?B?a2dmNkNqS3g4TFFCd2d2MlVRbkE2TmV2R29HYWFoNFZSRVAvclZhQlczcmh2?=
 =?utf-8?B?TWxaa2w2b1ZYd05FVTdMakg0emZmYUlmYmd6blNYWHI3aFo5L0pzYVFqME9Z?=
 =?utf-8?B?Tm9ENWFTQmtPUmFzN0wxSWVKeUpwT1ZnUVBWU2VvT09yeU5DaCtkYXpTUnNJ?=
 =?utf-8?B?aEpmOUdBMFhQaXkwMWtPSWFubXRtV2lLY2J5aU5nMUNiRmM1eHFhNTZBa0pn?=
 =?utf-8?B?NTMwQUlDd3llWnBIanovOVJVUkw2QVNvSUlETmNaM1RNeCtKNzd1QUdVclk1?=
 =?utf-8?B?QlB1NHZOM3U2RGZZMkM1RHZjcERORnpXNDNNZ2VYbHdOUUNYVlJLQWFiZzJN?=
 =?utf-8?B?eVdyMVUzWjM3bzhnb2IwbCtzV01JYzF4aEFYRUdDOTNHdjVwRkhNVDRBSFZ4?=
 =?utf-8?B?WElKR2IvMXZ4NTByS08wU0RaQ2dxbFpUMXhOQ0tSR1NJN1JUVmt2V2owTVpw?=
 =?utf-8?B?cVgyRG5pWUxNSEpXL0E0SUh3NkpLY2QwMlpYWW9GVGtKV1JsbEhSNTFTTi82?=
 =?utf-8?B?UFlvUVBjdXFrWHFSVFVhVlBFeFlrOUlEcDFhQ1N5YklUNlVtN29WeTArOG5Q?=
 =?utf-8?B?MU1VcUpjKzFvRXREWWFLQlRxMDJSSzVBdFFCUlJsRGMyVk1oNGhGV1pYV3ZS?=
 =?utf-8?B?VGdxUG1SbU9pSmRHTnRNM25CTDFiQlNWcDU4TFcrVXplRWwrOEovUDB5WTFl?=
 =?utf-8?B?ZEtoVnlxZlZaL3d6N3VoZFlTZDQ0WVVtUkZpZDIyVFgxTEMyWDZJSElTZS9X?=
 =?utf-8?B?RFQrWlR6UDkwWVJDaGhKMGFVUGUxTXdSRGZrOGltMmErNXlkVUZRYjJtWjQ4?=
 =?utf-8?B?ZjFvUHlsbWJrQkZDdkI1c0JraU1Qb3RJSy9oUG9uaUhPZUdlR2taNk9MM29W?=
 =?utf-8?Q?Lt5pjq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TklVcjlBYzd3REdySit5YlZWYWZyREY0SnlRWmlqV0t1YzZaL0hZK0UxaG9x?=
 =?utf-8?B?VVozRjBRdDZndlA3MzhRcGlXUlB6ZGh3N0xwa1A0cWFIa2VNZ29tL1JHRlh6?=
 =?utf-8?B?MFZuSDJJSlVBcmkzNFUzdGRNYisvbHdoOWIrSmVWdkFJOC93R1U5M1RiUEdF?=
 =?utf-8?B?MWJBYjVCMlJsNjhtL2dFM1pBei9HVGVabjRoTTBmazlsRnQ2OGtBa0E1L1dR?=
 =?utf-8?B?bFliQ3EvVHhmUEN4S1RSUGdGYnJINU5JKzRmc3NwZmR0OWwxS1BNZzQ5ZTdK?=
 =?utf-8?B?NXVEeDBRNmtYVHlKNXc0ancyV2pveTRqbG9kbUhqeGhYNzN1MGVibmdiOWNm?=
 =?utf-8?B?T08zV3F2dkM5WVVVMWt1WHozQWpSMEJTYTl0T1hFSUh2R2ZJVDVOazB5WGZW?=
 =?utf-8?B?Wk1iUXg4cFJrVXQ2VCtRVlQ2a2MrcXQwVWc2VFlRVW1CRlhld1REMk0rd1B0?=
 =?utf-8?B?enVVMy9YQ0U5MVI0RVpjQU9SRm5xekJleFRjdm1ITHNOa3Jwcm9qakYyVWdN?=
 =?utf-8?B?bURja3lXNWowNjloLzIwN3ZRZm82MytLR3h2MGZqR3pKeXF2Y3dVL1Z3ZXc1?=
 =?utf-8?B?bWJzNmFBcGVQRFlwemQ1ZXQ3VGtjSWo0NzFhdGsrSWtVd3ZTQjcyRThnaGJX?=
 =?utf-8?B?WlRJR0F5aWIxYXFkSmN4a3JnSm1jRWZPMmRIQTZyRDhWTDllM0RNREdFK3Rt?=
 =?utf-8?B?OWRDUWV0ZHl0K0FvRjJYZkIrTThjblQ2elNNMTJMbUR3RGFCWGt1NW9oL2Qv?=
 =?utf-8?B?aW1kR0pKWTVobG04cVk0aGwvZHM1aGRhQlVNR0pEMVRja3N3Qk0rQ1NrY1hk?=
 =?utf-8?B?eFVIV0lISUZHbWNUYXVnY0NxanVZNXRmWTZrWFI3Z2k5aUJIajhoV2VBWWhH?=
 =?utf-8?B?L1BzMmZBTm8xSHc5MmhoNS9ucnl5UkRDWlcxc053OWtEWEplOE1RTXZqci9x?=
 =?utf-8?B?VUhxU1lUUEZ4dnFRTkhvMlI5cUxnKzc5Ym9UQXVzRTVFVDZPUm5kdCs2YklP?=
 =?utf-8?B?RHhsUmgxQ1Q0MlJYOVFaUGpkRWxMWTJyVUhocTRSMlM2MWIxL3N5ejdjNkF0?=
 =?utf-8?B?Q1VTczIyeHQ2djFrRUZUTUNqbUN3Zm14bXFXVlEydGhBZkxuRTF0dG5zTC8v?=
 =?utf-8?B?ZzNEd0xiWVBlcnVoT2g1RlRuL2JZbW1DL1FCMkFGUC95OXFJMHdZV21NbTNS?=
 =?utf-8?B?WFBUTHoySGZsK1ArUXpkR1YrYVBpRWY5U25XSjVPUHhFM2RmSFV6NEF4TE9Q?=
 =?utf-8?B?NTVabmYxeGJCMUhLU0UrVXNDY0F0TnJtMVpjRFFPQ3VhZ3dxODh2YmlZMVk0?=
 =?utf-8?B?R1UxN0tsb0hqb05xM0xYVVhGNXNBR3Qwc3Z3cTNsTnRXa3RubEZDZHJONjFo?=
 =?utf-8?B?WXlLbEh6Q3pTWkczRXgzU21uZWtxVm81SUc5RTN1VEswU0lEZTVxL1FzcHBi?=
 =?utf-8?B?cUFMSis1aWV0aXFST1BsK3hqWWlRcmp4a0NrUEE0K0sxY3dKQmFsVXNBQ3VP?=
 =?utf-8?B?TXNVaStTMmJqQWdXMkxGdWtwcmJEUkthSTY5Qk5yWGNkUmJ1Q09GVVhib3hp?=
 =?utf-8?B?aHVSTDlXd3dpLyszZGVFaXFLZDJHSHcvL0hxRjF0bTJTU3Ivak4yYnhlVDlS?=
 =?utf-8?B?RTVweDYwcWpqcURHNGcwVDV1bFIrcXpsUW5DbzdBOGJpbGdoQ2xyRHQzc2lM?=
 =?utf-8?B?MnZ2RGxuYUR5cHlUbCt1UEVSMnFZeWtvbEpXQmdFMXoyZHV6OHhzclk2TzBN?=
 =?utf-8?B?VExXQy9iOTB6TVVPUnFnbEprVXNBVEhac01xZ1UxRElVd3NNTkxTYlllRTlk?=
 =?utf-8?B?NHhaR3BrNndFalV4OHd4UllIV0N3UDZSMGljOHpRYWxzZHZVOHVMQmZucWEx?=
 =?utf-8?B?UnE5Q0Q0ajR2NHFsY3BPalZZZjkzR1hoSHNqSnVTenExczQ2QkhEQlR2MGdo?=
 =?utf-8?B?VWJqRXp2SituM1FzdmI4VyswRDZXc0pSYTNyY0hPNXpJQ0E1T25JT21MQUlx?=
 =?utf-8?B?NlhIYWsvOU5hMjJGbFM1UXBxMytzOWZZUldJT2xTWGZjYVkxZEViVDVSR2hS?=
 =?utf-8?B?RmlqNit5TURYYTM4RDhHMnM1d1R2SzFVVCt1U05QVkVYamR5bVBFY3A0cmdw?=
 =?utf-8?Q?pmSMOa7MB6udxZJk5bDN3qRvE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF20E19FB89AFC4BBEE42C488EC950E5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rAnAHagtPqg9jxsvbUNHOjpp/HohEzgXejPeLQe5Qd7hXgonYC/9mItqEb+so1wZ67o7YXXsCrcr8tGlUEQwhIZdl8RMqW7SORr8IS7r1cfmKFX197s9r2PHUWuT/G2ZYDgn52tj7FeGyACoaBnbAl22uB6lkMA2y2hGSe1y/btiqqBG4RlKUBOm3/XPYccUAlPvoWpDYdLCtYlGOCXAlEzXiCSgHkMYRJuuqm6+/p+2gFPnUd8tIkYoVKv1XaOznZbIQZLss4qdiLOI+gtosieQCPRpoKCs69AktGADQvOi8SyAQWahbKXD0n8vrS25rocphaCSwjxNBwdTlCIkDyFHk/IwvbNuQ2LrEAI9NiwuEiXRTykWc4etpotpiJtoJQbFWdjTelfMjxIGhYrdTzI2eNWuUQUy4qOAIqodx7q/73S5iIux5ZYw+EII+qU/lBw+0FAkxHSYhRvRFQtV40NM8B/r4HUgBSKGspIu0fO95ZeNu43yLqAvSIVBtSUD90BR9M80bgqTADnh4Frx3yjapALsyLiHQ3V+r8Vx6s6qhzwuU9De6h62fDywshAF01uXJY4KByyllvDMEaF6vGF3UszJ6v/T+RIe3TSvpZWWfDDwJi0JWGwBZReIKakO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef2dea3-877b-40fe-fffd-08de0b00a7ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 09:04:17.5974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sF+x11ruyiBoyt3V7HtuyHNpuUEPBXlBbcv/Qh8ywY+oWE4ZOY3rmBpCXAJhXxk1Y/uWKR6uJMRZSLwcDA6rmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB9054

T24gTW9uIE9jdCAxMywgMjAyNSBhdCA1OjA3IFBNIEpTVCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdy
b3RlOg0KPiBBZGQgX2NyZWF0ZV96bG9vcCBhIGhlbHBlciBmdW5jdGlvbiBmb3IgY3JlYXRpbmcg
YSB6bG9vcCBkZXZpY2UuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8
am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+IC0tLQ0KPiAgY29tbW9uL3pvbmVkIHwgMjkg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNl
cnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9jb21tb24vem9uZWQgYi9jb21tb24vem9uZWQN
Cj4gaW5kZXggNDE2OTdiMDguLjU5YmViY2FlIDEwMDY0NA0KPiAtLS0gYS9jb21tb24vem9uZWQN
Cj4gKysrIGIvY29tbW9uL3pvbmVkDQo+IEBAIC00NSwzICs0NSwzMiBAQCBfcmVxdWlyZV96bG9v
cCgpDQo+ICAJICAgIF9ub3RydW4gIlRoaXMgdGVzdCByZXF1aXJlcyB6b25lZCBsb29wYmFjayBk
ZXZpY2Ugc3VwcG9ydCINCj4gICAgICBmaQ0KPiAgfQ0KPiArDQo+ICtfZmluZF9uZXh0X3psb29w
KCkNCj4gK3sNCj4gKyAgICBsb2NhbCBsYXN0X2lkPSQobHMgL2Rldi96bG9vcCogMj4gL2Rldi9u
dWxsIHwgZ3JlcCAtRSAiemxvb3BbMC05XSsiIHwgd2MgLWwpDQo+ICsgICAgZWNobyAkbGFzdF9p
ZA0KPiArfQ0KDQpUaGlzIG9uZSBkb2VzIG5vdCB3b3JrIGlmIHdlbGwgb25lIG9mIGEgbm9uLWVu
ZCB6bG9vcCBkZXZpY2UgaXMgcmVtb3ZlZC4NClNvLCBob3cgYWJvdXQgc29tZXRoaW5nIGxpa2Ug
dGhpcz8NCg0Kd2hpbGUgdHJ1ZTsgZG8NCglpZiBbWyAhIC1iIC9kZXYvemxvb3AkaWQgXV07IHRo
ZW4NCgkJYnJlYWsNCglmaQ0KCWlkPSQoKCBpZCArIDEgKSkNCmRvbmUNCg0KPiArDQo+ICsjIENy
ZWF0ZSBhIHpsb29wIGRldmljZQ0KPiArIyB1c2VhZ2U6IF9jcmVhdGVfemxvb3AgW2lkXSA8YmFz
ZV9kaXI+IDx6b25lX3NpemU+IDxucl9jb252X3pvbmVzPg0KPiArX2NyZWF0ZV96bG9vcCgpDQoN
ClRoaW5raW5nIG9mIHRoZSBjb21wYXRpYmlsaXR5IHdpdGggX2NyZWF0ZV9sb29wX2RldmljZSgp
LCBpdCB3b3VsZCBiZSBnb29kDQp0byByZXR1cm4gdGhlIGRldmljZSBuYW1lLg0KDQo+ICt7DQo+
ICsgICAgbG9jYWwgaWQ9JDENCg0KU28sIEkgdGhpbmsgd2UgY2FuIGp1c3QgZ3JhYiBhbiBJRCBo
ZXJlIGFzIGFib3ZlLCBhbmQNCg0KPiArDQo+ICsgICAgaWYgWyAtbiAiJDIiIF07IHRoZW4NCj4g
KyAgICAgICAgbG9jYWwgYmFzZV9kaXI9IixiYXNlX2Rpcj0kMiINCj4gKyAgICBmaQ0KPiArDQo+
ICsgICAgaWYgWyAtbiAiJDMiIF07IHRoZW4NCj4gKyAgICAgICAgbG9jYWwgem9uZV9zaXplPSIs
em9uZV9zaXplX21iPSQzIg0KPiArICAgIGZpDQo+ICsNCj4gKyAgICBpZiBbIC1uICIkNCIgXTsg
dGhlbg0KPiArICAgICAgICBsb2NhbCBjb252X3pvbmVzPSIsY29udl96b25lcz0kNCINCj4gKyAg
ICBmaQ0KDQpta2RpciAtcCAkYmFzZV9kaXIvJGlkIGhlcmUuIEkgdGhpbmsgaXQncyBlbm91Z2gg
dG8gcnVuIGEgd29ya2xvYWQgb24gYW4gZW1wdHkNCnpsb29wIGRldmljZS4NCg0KT3IsIHNob3Vs
ZCB3ZSBhbHNvIHN1cHBvcnQgY3JlYXRpbmcgYSB6bG9vcCBkZXZpY2UgZnJvbSBhbiBleGlzdGlu
ZyBmaWxlDQpzdHJ1Y3R1cmU/DQoNCj4gKw0KPiArICAgIGxvY2FsIHpsb29wX2FyZ3M9ImFkZCBp
ZD0kaWQkYmFzZV9kaXIkem9uZV9zaXplJGNvbnZfem9uZXMiDQo+ICsNCj4gKyAgICBlY2hvICIk
emxvb3BfYXJncyIgPiAvZGV2L3psb29wLWNvbnRyb2wNCj4gK30NCg==


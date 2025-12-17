Return-Path: <linux-btrfs+bounces-19835-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E438ACC7EA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 14:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD8ED3059DA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 13:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6865B35A937;
	Wed, 17 Dec 2025 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kZzxOXmT";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="F/eZd4pz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A235350A11
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765978637; cv=fail; b=BTeGZHgTs/sRzdvBL9aUhZFqm3IeuIbnE42O+eBqBPtZTyoeX0mlCUliLKg6WBAHis4MM+zLqrPAR4YsQjdrAmbhTCb2Cw5BxgmK7j2eNk6MYbMun2vigyHDZDjZm/pWuNLel98VV2nVrgRT0KextoMz/T26HQpbsu2pXJUTeGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765978637; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jfbcBmqEonCpBynoAVPuDUpOaN9dlmoyCPpQK8FsxTgv66U88CYle39D+WxHU5PxVGtzOPMKiafG+t0efe6NM3tuyC3zv3qiU8uqhnVUwa0ocM01pOG1zzUq0eAnq3ixaZoMfUPPhQla5VpqHeYJ3bLmsxnDZ+yB4zbIdz3jEk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=fail smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kZzxOXmT; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=F/eZd4pz; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765978633; x=1797514633;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=kZzxOXmTPyr2wNHwv1FA3cVkbRhP2kElZRZahpXvnqdS6dPMdV1z8jQf
   7QEtCPkU5Jx0yxrPVqqk0Xc4tP24IsPuPkK0IY5YKDSVal4DjjMyN5Jcs
   zc/jsZIor0M6eJUibYUR9QPCyKWeq5uPC3xoDmHU1FiNVhj2PpShcIRF1
   5qJ4eGUy8ZbNffapjVtwnXtHOouNnRX5gpf9OrhW0XFo0OcCm+0+s7mxz
   2KxdIgDggap9E/JuP0y4r2chnG3CUh5kdsRZVHytyPeFHXFjcgq3D7x10
   q9dAHgwSp8hn0YAPK4bNYQGg7GV8w+VTbEko0asr3smfY+7VJ+F704ffb
   Q==;
X-CSE-ConnectionGUID: dsIxMPr4Tou4vRyl5XHHDQ==
X-CSE-MsgGUID: pHspvJTgTBO22e5U27QZFg==
X-IronPort-AV: E=Sophos;i="6.21,155,1763395200"; 
   d="scan'208";a="136693630"
Received: from mail-westus2azon11012066.outbound.protection.outlook.com (HELO MW6PR02CU001.outbound.protection.outlook.com) ([52.101.48.66])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2025 21:37:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cThW0LvCfkxPlys84XrAymukBxpPNwft9Z1nFTafl+SInwtEUwUbgCTziL3RTWH6p43t0MKyRazklIH/Izn8QAJDbYpwh/ej4cZCiEil9az0MiDC62OmqUsyxAlCwpMnOcZX+CKMbeeN3OtBKb0bLyBTUN+zF8dlTsOMxU4BF/ThxgFn0nD/ouyyzpMg70Gp0yZFF5ZwQsOzHqgnSwUDXtGdbgvfvY9OfYFMUKBz7rk5PurAZHH633BepV/dBxQ5/gMMzz7IjZUFZhKN+kjkUAo5lqwO2LRe7Y8GSwNKtIGqk3YavdURR4J/mkSyHrXDabr5anTN6qQEZHxyIfVg1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=Co+jb6ua5SIe3cwMFfU3JXTarx2+OV+YexTxJz5Bh759sWoRVee1Vx0m0owB33BBux1c8O7+acjTorTtmDx95zcA6ujaUTqUKzsRGy5gqymA6cQTTlmqCplEN0DOYNGRujDgOEpXoRtpCwDS76koaSLuUoyMPDgLjejzI1DVjeGr8l7g+By5lNFvYaue65lDrbrBslTe3fS8CJ5/gXTqT5Jt3qWQ+HcovDDB7fjuYrrcO1VxZuwx5xeWSh4Dcmx5gy3f+TWPnVOIR8eXe77KpQJ2inHvsJzbE9bEv0tOvIkJ/kEyNmVYBqARMYE0dQlIHwlY7pxKkk/lWQqshzhcTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=F/eZd4pzj5iIUVkgq5i+uyi3I0mCCwho1F7S0GqctpA1yqGsEozhsIw80kddzOoAhEqfnMCHTAas6ukMpFm/YVaTKTAG8OcbWJTyEa+1lyl9TvB1Ik9oYbtfduDLqWrxQFNn+EGG0RECj4I9hX8ptsCOwZyZdXCkUp6Dd52ukEA=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by PH0PR04MB7701.namprd04.prod.outlook.com (2603:10b6:510:59::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Wed, 17 Dec
 2025 13:37:07 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 13:37:07 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: move unlikely checks around btrfs_is_shutdown()
 into the helper
Thread-Topic: [PATCH] btrfs: move unlikely checks around btrfs_is_shutdown()
 into the helper
Thread-Index: AQHcb1jOJIIFGpQM1U6qgKI/R3/ss7Ul1ceA
Date: Wed, 17 Dec 2025 13:37:07 +0000
Message-ID: <e6176cb6-2bdd-4416-8787-f84ad60f6a82@wdc.com>
References:
 <1a529e03fbbcf4fbb31192fe7be56e0f4650044d.1765977782.git.fdmanana@suse.com>
In-Reply-To:
 <1a529e03fbbcf4fbb31192fe7be56e0f4650044d.1765977782.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|PH0PR04MB7701:EE_
x-ms-office365-filtering-correlation-id: b30c066f-d5de-4c67-971d-08de3d715f83
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?SFhqUGxHemplRmZBYTZCTURST05FL3Y2eG1yM2haYitBVW96VndQUFZpQi9L?=
 =?utf-8?B?YnRUREVhRlZ3bEljNkFkNDJ4NmFsQytVVVJtSjFvLzA2MFFCVzZCVURVTys0?=
 =?utf-8?B?bEYrRXhGcUtycGNEdVoyZGhRQ0lMOUhvUzlLQjdkTXJFbm5IOW5xdkVGQXU4?=
 =?utf-8?B?TmJMTXBUWW9ZZm9SSlQ4MEgxWnBTcHVIU1FrRkluMFNkOUF3TW94N0l2WG5m?=
 =?utf-8?B?S3o0ZDh1VUxaaWZ2aUUzUFQxOWIyODJCaWhNR2pnNS9BU0V0Sk9CN3RUVi9l?=
 =?utf-8?B?VU9iZE9nNmFYcXlrb2tnenBZbFdQNFZqMWk3QlNKRWRDS3VMYTIvdDlyT216?=
 =?utf-8?B?cGlqcUtuUGNZZzVCdHFZd2N6WWZ1TDJHamJSakZvdzl3dmxJbTdjUFIwRjFE?=
 =?utf-8?B?Umkwa05oL2o2b2xnY2tpSEtWRlRGU2VQaTlhazVnT1pISVcvc0xtdHZ3TjIr?=
 =?utf-8?B?a05JZlkrMVd4b2Y1UDBYUjVZb29JR2VXcFdCczZ0TWJtVSswYWRqVGhoQlho?=
 =?utf-8?B?SjRrTklhMUtXUnhwTGIxcUxYSEVyUDcrUGtZUUtwQlZQM3hVSHZZb0Y5Y3Mz?=
 =?utf-8?B?Q29ydVF4WHlNQWprdm1sbCsrdWxocEVQT2x3Ymh4SjNiTm9lYmRzeERUS0Q5?=
 =?utf-8?B?R3kxeHlXcGFaUlRTUHZQMjZPZVpaT1I4RzEzT0JVMElOdzFhZTBPb2w5d2h5?=
 =?utf-8?B?azd4QmZ4Um5LYU0zSEJJdlR6ZkxrUzZhOXUyK1dsSGw2OUlKUlo4Nnh5TU1j?=
 =?utf-8?B?YVFNSWtmZXA4K0hkaTVTRTk4OHlvVjF6K1ZyQ0svU3V6Vk00L3VSczB0YjY3?=
 =?utf-8?B?QW02cC9KV2U3M1pDRmpxdEtiOVR4aXRqSUovR2p5Z1h2aFkyemRzOXNhV3U3?=
 =?utf-8?B?NUhQenJPTDdWK0JSVFh1N3VGOTIxYVIzalZ3OTkvMFlFV1dXYllOM1p4MEdU?=
 =?utf-8?B?bWtmYzVjeG9NN3ZMeW9PWVBrN3dXdS85UnF2d2YzWUVRNFlnWnlmRUt3Ujhk?=
 =?utf-8?B?MEZ0VTRGWXBOWDVXNkc0Q256YjVwb2ZkWVlVNHN3b2pyMHFScHZCWHFVVXl1?=
 =?utf-8?B?R3pHZmI4L3NOamdnTG5wTzJvdkNReHlYUzA2RTJaNnFNL3NRakNMWUlMaEYx?=
 =?utf-8?B?dUlTaHVXM1Qvb3VNeFo3ZlZ3OGZtNFp1TG15Z0psaGM2TjR6Snp2blpBUUky?=
 =?utf-8?B?TERybFJMZmZ0NzZ5bXlNSFhTN3pOSzgzWnU4clIydXd6RUNpRmYxTml5UTlI?=
 =?utf-8?B?N1pzR3pKd1hnVnFQMEJTNVdhRFcySGdtcnlsOHNiMi9kUEtsYldzdW9FZ0Vm?=
 =?utf-8?B?dk1tRDNZb25sRk5zZnRQbFppOFZ3S0RhSkJuU1ZmWEdKMFFidDZKVTdXYXRj?=
 =?utf-8?B?RG03MEpHWmMrNXBYSHRpdmUyT1c5SGxlYkU1UVcyR0RiZW44NG0vM0VJS1hi?=
 =?utf-8?B?WXVrQ2o5N2twZVdwQkpRV2NOYVBIcGZzZGdjejA5T3FnNjZuNVhPMVJXaEQ4?=
 =?utf-8?B?N0h5MDFiZEs0TWVOZmpvZFVGVTdwbGpiZnJNbDdQZEtUSTg1eDVFUFpJVEpq?=
 =?utf-8?B?NTNpV2Z1Um1vN2hsbDNOdXordU9POWRjYXp2TnZnQUhqRGE3ZzlhSXQ5WUN4?=
 =?utf-8?B?V1FzclNCZFhSNm9SZGlRU3l1Z3R4M0JTM0NzSXVmYXFjT3phcTgzZjZhYnBJ?=
 =?utf-8?B?NFA5TndlMmFuZDNheWFCRWl0aktmZjlXVnZLY3BtRG9GYTNhbkhMWGRmQ0VC?=
 =?utf-8?B?TnJjZFNoRkhtWkI2Yll5MEZ4dkhjWGU2Z1hrdisrRlBFT1F4UzlqVUx0Z0dw?=
 =?utf-8?B?SmdGc1BseUp6blZ6NTJNVXVJeTlOOGI2Q0tvOTFaQVY1ZStieXRla0N0Y2c4?=
 =?utf-8?B?V0FqSTYreXc2VkJDUTVud29HbStVRTd1OVFCSmRLSnpOa09EbjBjZW1laVRB?=
 =?utf-8?B?SHM5SU9TelVJN0NqYmtkakJNUUVtY25LTlJyRHV4YTRlNHNJeng1bmNBV0dY?=
 =?utf-8?B?c3k2aFJlekxUQ0VZTnFBdSs1eVRxVktmV3NwQVA2c1hVbm5SM2hrcFhGT1R0?=
 =?utf-8?Q?4fs99/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVk3RDZza1YvRFQrcjFleGtIeGhUMHBhUll3dDYzWEdzbmpRZTY4ZGxGb0No?=
 =?utf-8?B?dWRUTkhWQW94QzlqVFdyb2dPcmUwZ3Y2SXdtUkxUV1oyZFoxOEh2dDA1UFZQ?=
 =?utf-8?B?eVdIS0w2ZVZSYVlvem5vNmdTTG9aYXRlTS9yNWd0L1JlSXVJdHBsZlVhZHVa?=
 =?utf-8?B?YXdpalhqbFY3dS9JSTc4bHRZU3NoNGxhVXA1THprTytTL2UzSDFlaEQ0ZDdQ?=
 =?utf-8?B?ZytRcDdRdE1PUEVjZEViS2dCYmQ4b3JhbTRuR2NGcVJRNWMyTVF5YnY5eUdz?=
 =?utf-8?B?Y1YwdUNmaDA5eGVBdEdsYkJ4Vk50RElqYUhidk5KVFdDN3M0eW9RMXdyNmc2?=
 =?utf-8?B?eTFTMGZCaHhMdGEwSTdkNVFuaUFrSlZCK1FiWlpHMnJVZmRMUGlNUVM4T2k0?=
 =?utf-8?B?VmNxdXIzUmF4Q2ZpTEV6N24venVPdHRQbGZndDVGVVhmUmdVYTQ3SnVoRXNa?=
 =?utf-8?B?Q1B0MGRqZUVmM2tOUTVBTXh4clltdWJ4bTgrdndPRDhyODY1U1N6NG9XY3VG?=
 =?utf-8?B?UXJPNUlUMlFOaVZmVGpYVXdzcWNEOVp3TU83K2dQUys3eDJoT215R2pxSTdD?=
 =?utf-8?B?K0hnTVI1d0p3eGwvZWx0citVclhhbDQvb1dDdmF5VTVxU0YzeCtqNVhkZmVC?=
 =?utf-8?B?ZnkyUDhNeFY5U0VMYWJ0TGxlUVZWSHUyTnUxVkhlWjVjSmdrUU1MVVo0dDFH?=
 =?utf-8?B?YkJlY2ZIc3QyVG1lZXBXb3ZDdy9xSXkxNTVFbHZucUNDSmdUYlM5RkRyOHRF?=
 =?utf-8?B?ZUVEWkRLT0ZsRmVNSVN4Z2o4V1Y4aCtyOUIrZmFUSE5lQWNTUFBBcllzZWow?=
 =?utf-8?B?S1lFVi9zc3JjdzFqc1I0WU5rMHBNSC9TN3luSzM4Y1JJeDRXUWJhRDdJUjJa?=
 =?utf-8?B?ZmZubTlGaFZidURKbHZwUzUwd1BpTXIrUTZOUlF1NXhTWE9sZFpnY0lPbXJ0?=
 =?utf-8?B?akZTYTUwSnpuNFRIQU5aOE9rTEV0ZFdkU1lYUXpMM3pGMVBMZEJNcmtQRVdp?=
 =?utf-8?B?MHRVbUR1V2hvYXkwU21weFB3WHE3Z25WZHcwVHFKZVVLc0xjU3JOOGt0bHA3?=
 =?utf-8?B?MHdSSHZQUDkwbm9EZWxkWXJFVGQ4UCtIbk5GRTd3cVpoaWpKK0lyRXlzQ3FN?=
 =?utf-8?B?OEFFdUU1aDRLM0VjSjFxRHc0SG5kYzBOQlk1QVlyQytaYm5OdXpNRnI1SFNv?=
 =?utf-8?B?RXo0UzVScFNRQkg5RllFUHJidzBxVXV6U3VJd1FRa1VZclAxT2h3cTJ5UDhj?=
 =?utf-8?B?ZFdkYWJRNTBXczZrN3EwcjQyMk1wM1FHTDcyaTYwODJabTBxQnlsZ2JTYlVD?=
 =?utf-8?B?YkkyS1lzMC9mZDI2d2JhK1UxdXhZVEdFTm9MdXY2RWFNVlY1bnhJMExkNVpn?=
 =?utf-8?B?ZERtR3JqbTMyRDRJNTZsdDVFdDh5aGtEdFVKdUplM05FaGIxdzNSU1dsbncr?=
 =?utf-8?B?TW5QOWppdDA2bk45aExIRjJMSGdobkJUQkNzejdrdCtuTEJjeCtiLy9aWS9P?=
 =?utf-8?B?a1dKY2RJRGQxY3dwMmR0U0hyZG1LVmZmby9kWjVFZVc5Rnd1ZEp2d2s1MGNO?=
 =?utf-8?B?RjlYT2h6aEwxbS80ZWRhU2FVcGJqVEhmdEpRT3Myd0wzZ1pwV0ljeUdoK2hW?=
 =?utf-8?B?VDdwM09MWHFmOGFHUysrTld1UUhDeHNoZGJlUmV2NGYyUlF4bmdEQ0ROME54?=
 =?utf-8?B?b1hvd1J5dTNuR1pmS0c4L1Y0a1ZRWmRGVXpBY3U2K3hnKytLZGpNVnNnUlFs?=
 =?utf-8?B?eDFiaEpRRWRPYkFrclVKbkVmb2lHRmVDbWJnUGw0UDFGNzF0TnNPTjI5eHFP?=
 =?utf-8?B?R0lERC9FR0thVlhnNU1OeENUeVBRdTFXNlVLVFhZOGQ3bTF2TGladmI3Yzl5?=
 =?utf-8?B?L3FvNWV5cjF2SS8wOGt1L1NaVHFoYWhrQ2hvQlVHN2cvc2VLMWVtSy83WFZO?=
 =?utf-8?B?QzhlUHpqbUx5K3lDTUdrNVErL2haZ1VDWSs2YU5YM3c2VWFPOTBRN2FUbU9k?=
 =?utf-8?B?WjlObnZEUEdGbmhMM0ZpRzNqMk9RRTg0d2ZwN2ZOdTJuKzM4akNNNGRPRWxE?=
 =?utf-8?B?NjVrQkd2WjFTSTZHVGZUM1d6WGNmenJ6UEJHT2ZwcEk0dnpFakl5UHMxR205?=
 =?utf-8?B?NmZvOHJ5anlxRUV0eDQvQ2FiTS9KTTVBQ3JWKzE2N3NqZzN0YWpkSG5KTnlY?=
 =?utf-8?B?MEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1F2B5459D56444DBFC4FEBEA959031C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mFv7AhkawF+ijmQTtWHkgVfpXJwD05KBA6rZ3yHY4nrOAh+Kh6AY72dJMKsuDWBMrqDhkLIC29LEtD69PgaJxD29hppPDfc17MRuLfBRIzs2yHNU4m4f+Q//Ys+S3qAU7xAbDh6StzTT29dMu44sMjtMavFtmjhu10Q9pYZu1gXMpk4+ul+OV1cA4aWnzSGCsowSV2N5qSVjrNs1/OWGAeXgEs9ne9ik1YpOOOL4IABpbc21kA2hzCBhk69ut89FNJ6088upjFPoRx8d4fobS+FbCiFP4j8KKDxIi8hbQYLvCYXP3vT7ZNjZruQFxqfKB7za3+Vho+6egJL8iBMtlWNovu0fE2YhhDljvzsnBMF+tj+BlIkmHvS1HHRShogpYWPg1EGMm2arcnLce3UANSLeZn2DsWXj1u2ZF/N/FBLAkhgCURQ+I+UMyxSTffsWzHs6HjmD8sKnF5QK+MMiCiR6Pjp9uYrNQwZqiLR3Ng/SOP+uhmz+mmEjDlJwp8vsiA0zE5PEhxf1j23ML6Dp5/RlelchsjGL+Ce6bjms5MjMD5Np3BaD9E0TPXYkXEYEzZ0ns0zr9htJNZ+2J+DSJ0f9tJR0rcMMKblpLlLyeALOhCJjRE47xFHCEu7AckpM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30c066f-d5de-4c67-971d-08de3d715f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 13:37:07.5759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k1Nc38DMEr9TLc98AshxX4QoiJrCY12piDETpfag3DyvKRlvkHEcQRLb8+bz4T98dDGx6k87YD7oPTLKGPlKUhiDK9oWnygFds3c6u2pNpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7701

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==


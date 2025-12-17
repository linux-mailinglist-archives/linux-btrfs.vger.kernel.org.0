Return-Path: <linux-btrfs+bounces-19818-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E11C1CC648D
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 07:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D84FC3021F43
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 06:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B682132AAD5;
	Wed, 17 Dec 2025 06:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TShbnv9P";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WstJhSBr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DEB3254AC
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765953954; cv=fail; b=OVig8DpdteS1PYCgu0l54mEvsAGCVkbHEzmMv2/7E+0TSRq+lJGXhzdiSWWycMaF+cucpteLtBKyykx6OFP03uK/TyVR5W0FM4Sxhmakzm1dW3V1cbiIJ2lVpHFHwwm76tG/PfBc0AzznJPHGqY+fzhWOj4tIAcMbZaZTCFjfDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765953954; c=relaxed/simple;
	bh=Ak8pz0UbSiMFB7vRaxUmY+Yg3XqfmvBYTozrpTI4hbE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VrWdVbTjxTMjwf7u0E/cg4leJ25BDi0cT7JeqYQ1PKeyTszLCdTU6hcKVFT1wX6pWwEU19zfDoJZZXW0a284dBuo4KL0yYAbKJ4wgV3yd2B19J1VxzAkwxbwicQoj2WfMP4fSnBho5ohXgfzQHNhfY2/SWEn8BATqog26YdnhaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TShbnv9P; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WstJhSBr; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765953950; x=1797489950;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Ak8pz0UbSiMFB7vRaxUmY+Yg3XqfmvBYTozrpTI4hbE=;
  b=TShbnv9PvKvi280s3Gx9riYftgo8hShALrjUow0c8JxdYgx3IZ68Rs9y
   1hfvPzrVWIzejxqKp0d6USV17wcqeU1CuubsAbcVQIU0jlFNN3ISdN3sv
   J+89pLMn54fxPrCu/fyzASJmv9HLSm+ohdPHYTXwDMcswN29peeK+snwF
   WhTkz8Uc2gR2l5cFAttsTBMebiJ59L9l1MkxWpc+2v6BG/LMLVPrYQ6zt
   80MhqXW7JjspIdPLljkV0C4ogaCTzcm8Z9e8sFbcmyiU4meUf7AnsgRed
   a9WLP0hEqSiiqWE2IXV4HmJpOe5T7dR4f98lr4pKqrHxM5Qc5NUczfwHc
   w==;
X-CSE-ConnectionGUID: XgbvT2X1TzmrKvsI6nT6TQ==
X-CSE-MsgGUID: Qo5OpPh+QQG2n+13FEYp3w==
X-IronPort-AV: E=Sophos;i="6.21,155,1763395200"; 
   d="scan'208";a="138476143"
Received: from mail-westus3azon11012017.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.17])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2025 14:44:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yD4y4spZscBjxyBaa+BsNPnGhPAAgyeH84xvYm8dErDXRu7+HpsyEBbcz9//MXJ58Gm8LwsW7/B1x+xut6gur7HrzWPEWBoNdIt56/h7Cw+yXpgF4zwFO7j7YuoNc3ag8b/NTkyRQNhepMzOrEIl6GPfed/PP8lCcpzt+ss21gHOKgwOuZiY0odkQs6QalSLlXmzgWlLXuTpxS3XW2vcMZSKuC/0JUAyO1CA5MCodNOcXRIWOemX1OdptBnZGydi2zIPNDul8Xz/D/01a/8lLR7T+HrTg31fH2io5MkMpfIyDvMO5MK7VUZNeigTaDVrfc47F2cwHuJ2aV3UFLbfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ak8pz0UbSiMFB7vRaxUmY+Yg3XqfmvBYTozrpTI4hbE=;
 b=Qbu+5f929c1RdtOOcJiOSJQnZuRhZgLfrMb3194XP+SHKj3n9ij3xld6OLNlh6qsi2XqkEWN2MfJRJpX77Bq29u68CvgrXcnDD9lHMvWs1RUYm1Bu2dyCMQ0Pi8uAALVaB7eAn3Hi6ikaoCsBeI97HejZ0lZetbB8ompfU/v9M6AKmoHVoIXMNabttJiZT38YPCwXGekoILC3KHXIwmlMHguw/KtBF3ymX6dggmJ965V9gPzJlkaEMLLIrykz7hpZCKLQ0FoK73fn9XYBJJ8QjKXCxPl0w3RqGeHg9i8uvuf0ce6JpuRRJhGJMzji1fVX1UZQF1CnV/xtiRBO6kA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak8pz0UbSiMFB7vRaxUmY+Yg3XqfmvBYTozrpTI4hbE=;
 b=WstJhSBr23rgzbIGit7BAVkI589vmOsOWI8cNDNYG00IEOIVYL+nRd9qS0lRgZL6vjTQXlbMC/B3cfp5WXauS/ts70Qwi8IjZABPRcX7KNF2tO/t6X0r1RGd2P7iJ3SxFN91f4TgaH7vHShb75u3oTAJ2WmzLcplk69/tDajgMU=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SA0PR04MB7147.namprd04.prod.outlook.com (2603:10b6:806:ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 06:44:34 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 06:44:33 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/4] btrfs: some cleanups in btrfs_find_orphan_roots()
Thread-Topic: [PATCH 0/4] btrfs: some cleanups in btrfs_find_orphan_roots()
Thread-Index: AQHcbqqLxdDjhto09Ey5R+zACz1AHrUlY94A
Date: Wed, 17 Dec 2025 06:44:33 +0000
Message-ID: <02c884de-b6b9-4288-b8fd-eabd146df54d@wdc.com>
References: <cover.1765899509.git.fdmanana@suse.com>
In-Reply-To: <cover.1765899509.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SA0PR04MB7147:EE_
x-ms-office365-filtering-correlation-id: 10e74008-27a2-4256-a118-08de3d37bcc1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|10070799003|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXRtU0JGVEl4NXNzOE1LWVVmbFNtMTBNQnhTMzFrTzBPeGJoeHNZbjBRSE1w?=
 =?utf-8?B?a1loK1M2TThOdlNhencvVkN3bGJ1WFZOV3ZyRmVJMnMxdTBxeXB3U1Fja2hp?=
 =?utf-8?B?UnRlRGx5TEhHUEYxcWtUT0F3TkVVdUc0eEZFYVp0MkV2ampyV1djYWh4Q3Qy?=
 =?utf-8?B?enN1WUN5SXBMNXJ6b2t3K0FWWGxRcUJDWlNTaWhham5jTWpYekd6TmUyUGZW?=
 =?utf-8?B?TnUwV3NrWGVVQmNQKzRBWUdBUjNlTk9Va3VDZksxM0FDaGxTWFppMXJTYWdW?=
 =?utf-8?B?Sk1ieEYrdVBnRkJyYzNQV0dIUS91VWR0RTNrWlZEcklSSmpYVTQ4aHBydTlz?=
 =?utf-8?B?UE04VW02cDJjRlkva0R2MXlndjdHYzlXV3RVNUxsNDlBWVVFT24xTUxsMkFR?=
 =?utf-8?B?SmQ3NHpuQnJLZ2NmM012cytFSHN0TW5TVmRJck1lWTlrYzdIaHJ1UGlZb2M0?=
 =?utf-8?B?TDRUbUtmKyt1Mm5wVnhrM3NIcUZqVkJoeEl5OXNFTStoeFVBV1ZIaGVOSGlM?=
 =?utf-8?B?Mkw5RFhCY01MdWVTdStKNVB6T0Z2RjU3K2ZIdU9MUnlwcllHUVM5NGVUY3JF?=
 =?utf-8?B?MUt1YnNrMHMrVlNxVG8wVDVhZDdWUTRhckx5aTFwaFZNMWVQU2pEVHFMZ0tJ?=
 =?utf-8?B?eHFhSWlWWkRJL3EzRFRqcTZ2UU1CYlNuK2R3MjdMTjlzOTdHMDNEOC9QaFEz?=
 =?utf-8?B?OWtHRU1ocnJNYkxDM0tIZFczTC9WeVpRU2NUWjFXZjRYZWl0cVl2SG4xanRI?=
 =?utf-8?B?ZThzRjlYWFRoYndPcko0Q2xlQlVKOWp1OTVPR3MrR0ZFTW43WXVHUFdGbmV2?=
 =?utf-8?B?bXMvdW9UdGswb2dXdlFBUTN2NzN1dXBObGVMUW1lQ0J1bVVRN2w1NGFCK3BG?=
 =?utf-8?B?cXRqSHhsUnA1K2t2a3F5dk1Tb3hQKzFYSVFJaEZDaWZ5V0ZoOFpQR0xzb1VT?=
 =?utf-8?B?b2xQSnZ5eDRGZHRDOXJBL2owQXlqU2JKY0FkenJmMzY4M1pZa25kTGZ4YjBY?=
 =?utf-8?B?WGNtcGZsK1g4VmwzUXNWK20vOU1lWVk4aDV0d2dJUUNqL2FWR1pjc0lIVWpL?=
 =?utf-8?B?VHFjSk5ScWV4cUYxNkhwK04rRkFJZHV2TXd5ZDdTZHdNa3ZxWEtKenZXMTVw?=
 =?utf-8?B?TnExcmVJUHBKdW5MMmRmYjVpK3Z6U3hWNXEwckVNVTZUeVNSUFZzRWxFZlhO?=
 =?utf-8?B?STRKd0FWOTJPTlpyTWozMUVjQ0twbWFqRklrYjQ0L3pNRUpNWjI2aS9wbTNR?=
 =?utf-8?B?VGJZTGtUa0lpK2pGVXBhZUprMzk1RUFIR213UGFPOHlqajFBUjJQcHh1T28y?=
 =?utf-8?B?SDBySjQxa2FyTG15R2pSVSt1SHhGODR1Qmh0NUJqblhqY0QreHZ4cHA5cUw5?=
 =?utf-8?B?SDFCV3JIbmZHMks1OElwcmVOK29Tdkg1RzRsT2ozUzljc1UvUkJ3b0pSNXJR?=
 =?utf-8?B?VmZxRDFIS1FMZG5qYkJseWN1RTM1eEQyVk5CVzJkOVR4M2J3ZUZJL3FZWHJV?=
 =?utf-8?B?ckMyM3UvbE1sd1hjRE5GaWxPbUlCSUVZamZ4ZVZ0a0QvdlhpWTVZTGtPbXEw?=
 =?utf-8?B?NnhLMTRIS29SMmhKeVg4MWt0SmJLQW1hQ1YvSE9PMlNTTmhtMEZPT0s3alpK?=
 =?utf-8?B?ZnBId1FnYVBwVFpPNUJmZ0J0MkdHSEdWTGVRd2puR2tzV0V3UUdJWkJsQkZE?=
 =?utf-8?B?NGdhbzJHQ1RpODNISlNselZKbWh0S2d4SDlTRjMvd3FycDlkV3QzYS9mZHU3?=
 =?utf-8?B?b04rYm5mNzl6Q1Z1dlMydHJ2NVN5RnJ2bE9YUC9KaUtqZEh2U05aZHBvNFIz?=
 =?utf-8?B?V3o5NGx6RGRWa2dXM3RsZ3pVZVh1clVaMmVnREdRYmd4TVNiVTd5ZlZEaVg5?=
 =?utf-8?B?RkM2bmdJNUFBbHY1c3hnT21PL0UvMmVEdFlseXQ0MktwcllITDRzMk1welZz?=
 =?utf-8?B?Q2U2djdjR21wRGlwZ1BEVHAxWEJWM1pQN0JSVVFLRlNVUmVCcEhyeDAwTmdP?=
 =?utf-8?B?UGNpZDc2U2YzZVgyN1RsNVdLaUN3dkdoY2RIL2lqblJtQ0NhM0VHS1gxbDB0?=
 =?utf-8?Q?zGej5U?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(10070799003)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NEtKdGVNTk13ZUg5dXJiQ2I3NzMrZDQ2UW04aW1URnBXdHVkNlJ1eWVQTGd5?=
 =?utf-8?B?NUZoaXJKY2dZN0N0UmZFMjNwWmo3aVBHN3piZ1J4d2kvaHUzcVBWS1hudWRR?=
 =?utf-8?B?SFYvR0FpY1VnTEZxeCtvWDBTT3o3ZXlGZUl1d2ZsK2xrMnJjaWZxaXlkSUFH?=
 =?utf-8?B?WEhpRVdlbFlpR0xtSWdmdGpVZ3lHY2Y3STFQc29PaEkwRUNFSnpYc3JnWHNt?=
 =?utf-8?B?QmhTOC9ya1VvUVVYZ3M4WWdGVGRhV05lU3dKMWp6T01hQlBlZEZ6QUtheVlV?=
 =?utf-8?B?S3ZXV0p2Y3VOZFd4bFNzQ0h4dEtOV2paZUdadVRBWXQ2czNxVXN0cUF0WUZ4?=
 =?utf-8?B?NGl5RS91QnVhZkVXdVRNeVR1cnVaTlp6bjNKZmhnZ3hrenpCU2ZRRFlpOXVY?=
 =?utf-8?B?TkxuZll2N05hM09KK3VKUFRPVks5ZWdPREZzTmVjRFpTaVVYcnowejBjMDJh?=
 =?utf-8?B?ZU5Kcmh1cktXdy9EWStUNzRjZE5wZS80UDhwUVZyaS9PdCtFSzNrSGhuc056?=
 =?utf-8?B?Y1dBTjcrSTFRWVhweGw0cG9HUUovSGtMUlc3OGV5TFN1VUNYWkNuVjk3VHI2?=
 =?utf-8?B?ZjhQS2RXMWxiZ0cvL2ZxTnNydVlJWjI5ZnFONC84TTl0Y0VWaTh1NlYyb2kz?=
 =?utf-8?B?dWp1Z0x0RGVKT0s0U0grZy9FSW1vN2ZNRjRaeVBlc3RvNnpjbkNlWkxkOGlY?=
 =?utf-8?B?czRrLzRGVU9RaG1jOHNVcU5SRmxrekU0YnZDbjRMbWlWMUJCUnlndTQzclh4?=
 =?utf-8?B?R1cyb2xQSGZzVGp4Z0VRYmNjdnc1T3ljakdjeXNDNFhLNjJiME9aSy9EZldk?=
 =?utf-8?B?K1pTQ3crSVR0dHdzbi8xempZZ2xsRTFBY1hCWDJ0cklTN3MzNlYvTnhaVER1?=
 =?utf-8?B?MmdPSFNjY0RkWTRLUlZXZ0VySXVobDFOaWp0SjFrUFR0WlVROXJtVUpPVm8r?=
 =?utf-8?B?Y0UrZFIrM3FjcldnSU5JOElVQUM2OE1XNis4WUlWeGZJRFo2a1NNWDFFU0tQ?=
 =?utf-8?B?YitDWjlzTGNYNkUwRXB4VFpIRkZPeXdQZlFYYnhjZjFrcTZ1R1BQS1VlS3c4?=
 =?utf-8?B?ODdsRnFNNy93MjVSb1N6eU5VdnBPWGYyRFhMbGRkVzJrOVcrTDBQeDJFd0w0?=
 =?utf-8?B?S3hsWHA2QmdadENRZUZrWVV4K2d1WlNlbVpENWFDYlB5dnRiendvU3Ntc05p?=
 =?utf-8?B?ajlSRWNHKy9YTkJzS21OR0xHRmNDWHZNRVR6YUxEc3BMMER2YnJYZE5Fa3p1?=
 =?utf-8?B?bjNLUzJ0QnJEY3dIOUs1N1FvRElDL2Q2ZFM5ZnpFNlZ2R05kL2VMYXhSRmlQ?=
 =?utf-8?B?TTk0aE4xQ002VWs0NDhsUE40blNycWdJb3N4N3NUZno0TnNDRHJUZWFEZGNM?=
 =?utf-8?B?N05UWXFReTBiaVh2TWYvVFA0S2pvaitscGg1SHhUem5VVy9McGlNR0l5QnNv?=
 =?utf-8?B?eGdXZFE1TXVDZ3NlOWlobWRlckh4ajBRNWM3eEN1TjNET2s0QTZSR3ZvUXV1?=
 =?utf-8?B?UkgwanhkaXMva1hYWTJWdzlWT1VGa08yZTJMNG9HSUt6Y05mMm9iTE0zOHFW?=
 =?utf-8?B?ZGE4aXlzQlh5M0dOVFNYL3g4RXM1UHpHTDBUMFBnWlhlSVUrWjY5QkJOVDZt?=
 =?utf-8?B?em1wUXVvcmZzNTh3RkRkSXMremNaTklremxpRFU2VnA1ZERYbnBvdUZWQ1dD?=
 =?utf-8?B?Vm94MzJCRzVkNDZ0N1JTSE9wYWNGRXF4YzBtbzY5TDVwYWRMUnVoSDdnK3RX?=
 =?utf-8?B?MDNNTndXUXdIa1dHYXBiMFJZN1NTZ0NXUldWYTFOMmRLVDhVaGhzbWFlQUta?=
 =?utf-8?B?WXlmaE9lS3FvMjlTNXMrV0QzdTlyNkJpYzdncmJCZUVPd1JwM280RVFRSUl2?=
 =?utf-8?B?U0xoK2VJUmFML292cUQ3UEtOLzdNSGRsS2RXU0dSS1loMzFnRzNmM0txV1M2?=
 =?utf-8?B?Z0JhSmp1dWp3Y3JGUlRpMVdybGhuR3BPUkE0WWxoaCs5TG1LdkpyN1pPV1JP?=
 =?utf-8?B?bnZWV3BXdWFXVGlaV3QvaHd5azNTMU1MNEFmeGw0dDYzbDRhMmZ1NnN3NFZp?=
 =?utf-8?B?NStxOHl0VFp6Q25IOFk5MWY5NmlzYW5uZVFzc3B3OTR1MDh1RjM3K3p3YnBp?=
 =?utf-8?B?YW5GLzJLRmxWWURTVFVwYTUxNFpEZWpzbHF0VWlKdWVyOFVNSW5pUUNvRlpG?=
 =?utf-8?B?Y2pPTkhNOXNVQmJvQ2Y5ekZrRXRFQVREWURtZmlmMGJmdmM5SU9yMjVhTnhk?=
 =?utf-8?B?SEQ4dnNZQjFTQm4rYWxqZ1ZkL3d3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02E270C953625D4C8E3B5B83D8A4E587@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	20+QE/piFlT3RsrZqzWeofdU/nQiR2WVbP5849soDkT3RJM9XoxQU1uRrHa0LRYXGIty/UTba1/vPYxDnkz7nNM3yZG4oC+AgATLjIchw9phGnzvVprqr3vBTOlfqh23xTqe7az8yp4cAm/42aV69yk8f422AV7GCH3ZvYccclEWb3xuvbrpuGIVLHkoNQ8Fvm9V3kfYIAiWvHKgR0ZYAVdWejDiV5ZA1l1IVfFm42Y4tvgWn/cUUrIr46A7rykU2jXIyTPFigDZojm8Tc/eXQTUY88IEFntyWgh/16/GMKm+yIQ5/NvJ76Zm8VNjE/Wbc0xhPLjjGZzWw0DC/DPhxm5ly0JvBrM4nsYorGjhMt3ifMSyOnB4JC0tf7lVgQKzTlFpZ5JghcVP9OvR1Vd2ngpsNo+C3FfZaMDnJGabzhpGebwmUG8ybCnFBQGck6yMZhZ8fm/9MqS10h2G06DkEuf54r5+y+NTpgamJ7zzY8gd8KrXC1WmwTVkp9/b4C0nerw+B0j3m4IoNypGvCQGGpthUEC5aneVMCV/dKCsJRGWo+Wa6DfaZN/t5Jf9Eo9KWD5a2xwhfpMoLg3URTnvQa/UNcRYRQkQaS/E4WbEGUj4wESoZS2qlvBZ/bPynAI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e74008-27a2-4256-a118-08de3d37bcc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 06:44:33.1926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +va7rbauk0CZN+0X7z15GkW5V+S9PFs4yOyu1xGF3Hs90zsS5Oka8vx9RSfE3BYIJYRDrju9QdDAuLayFh1qTPN5JGf0HCycJywteAg9dxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7147

T24gMTIvMTYvMjUgNTozOSBQTSwgZmRtYW5hbmFAa2VybmVsLm9yZyB3cm90ZToNCj4gRnJvbTog
RmlsaXBlIE1hbmFuYSA8ZmRtYW5hbmFAc3VzZS5jb20+DQo+DQo+IFNvbWUgY2xlYW51cHMgaW4g
YnRyZnNfZmluZF9vcnBoYW5fcm9vdHMoKS4gRGV0YWlscyBpbiB0aGUgY2hhbmdlbG9ncy4NCj4N
Cj4gRmlsaXBlIE1hbmFuYSAoNCk6DQo+ICAgIGJ0cmZzOiB1c2Ugc2luZ2xlIHJldHVybiB2YXJp
YWJsZSBpbiBidHJmc19maW5kX29ycGhhbl9yb290cygpDQo+ICAgIGJ0cmZzOiByZW1vdmUgcmVk
dW5kYW50IHBhdGggcmVsZWFzZSBpbiBidHJmc19maW5kX29ycGhhbl9yb290cygpDQo+ICAgIGJ0
cmZzOiBkb24ndCBjYWxsIGJ0cmZzX2hhbmRsZV9mc19lcnJvcigpIGFmdGVyIGZhaWx1cmUgdG8g
am9pbiB0cmFuc2FjdGlvbg0KPiAgICBidHJmczogZG9uJ3QgY2FsbCBidHJmc19oYW5kbGVfZnNf
ZXJyb3IoKSBhZnRlciBmYWlsdXJlIHRvIGRlbGV0ZSBvcnBoYW4gaXRlbQ0KPg0KPiAgIGZzL2J0
cmZzL3Jvb3QtdHJlZS5jIHwgNDcgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRp
b25zKC0pDQo+DQp3aXRoIGFmb3JlbWVudGlvbmVkICJcbiIgZml4ZWQNCg0KUmV2aWV3ZWQtYnk6
IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCg==


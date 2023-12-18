Return-Path: <linux-btrfs+bounces-1036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4E681774E
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 17:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B5E1F22928
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FF44239F;
	Mon, 18 Dec 2023 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r0+NsfRK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZQ/ral4a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE083D556
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702916509; x=1734452509;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
  b=r0+NsfRKDZPjF17qqxGveSRZZlkXBW5XVdQgPPD+723lheFBLoR9fmYb
   +uWzGkDAD36rfZcbv+UrZHFQcHFpuAI12Aew30NOfHFkhPYXd19NChMJF
   rrzVN+1cC5cFzSWn98kFRS6FKuszCxeUCU2yMSN5u/Ml1Gq3CEvIAhz0Q
   TBERxD/8t82MB43GtyHOJE4u/G0MYKNaz685KxV7OhBS2y58K0tbHo5QG
   A4+g9hMBKbGzqKXGr+gk3H3Q813VslfsWtOFGpJ75v4GnZqkvOngEkbQH
   RnXbPGdBY5ALkBvJSEjXKuvJLo4YRTfzXR4mb1wLEL4/0as2Hae3xJ5Ar
   Q==;
X-CSE-ConnectionGUID: Sg6tHsRlRPaiLBG17JoBcA==
X-CSE-MsgGUID: G2D3b6JXTDWEe68WEvzdUQ==
X-IronPort-AV: E=Sophos;i="6.04,286,1695657600"; 
   d="scan'208";a="5208174"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 19 Dec 2023 00:21:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiZOSxGJdE2J0PG2/Tz/jrb1oZI5qBXrpsfFuxvQfSP04YfiDsfXijjhzkc+hF2sL5qLytL59nDpw/1nuJea1+RABIAFKBOcJwqj4ev8A2kejiBSjSEIJsC/nV37yvnTusQ+Twb4U26nwDmTp/kz8Ho2tTJ1st/pdilN4/SWU+5RRYN9mnt/Kv/hQIrkG4Uf8xrJQIte78fqKxHTfdTWMEEKtLVcW08YoeB+TF9zH4vl507LxBLU4XnBOStrfOgRzAMVzbqlk8fwXaGaQbAkq2+1ffhFifK64QAkGO4Nb/ha8Zx/WlH/v3ZDRygzC0kCJWt3JYBvnd4MWrnaB5iN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
 b=WSe7NlPhCoauFrt51dJ9zRPusbb7f1XaFP1b3vjy3NadUDbP6SSmQ5cdJpoL7DGKBp3GDSdrgHoH9xADk2ZPfC6n3EFEO3RZgYZli73rlzXw7zKptgMEhL9F+mfKJTHw5RhnCzKgJtfvNdduFUhiU4eDiPpD/6Unc5jJx8cRdnoOoSJfKSyltQJufgcALzzdPOZgXbt9mBtGTzsOCUGPStY4QEdk8sGr1zodd0wIhdZGPb016nExxsHGU1jRSxzLPIhm8SJnH4M/QuR6K9Pt7z9jNgyH1sH55tQeJnGQ3epzSMbJIYrjQHv2Vm05kuzAoi8ZvQy7a5TWiJrY+42RpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
 b=ZQ/ral4ao66QxChr1eTNMqy5ldpWJgKLekCi1qWgQguGHVjPSdyKNowY6S5eSu72Ajbj3FeCyMxmbCqGJFWWTOaarxLYUHe071CyczcNZX8LszlynnPaHYqC2iZHDyzpT8a5hnfeYvnuqwy8CkHxvCKBRXRC245BgQKL6QXIMVI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA0PR04MB7258.namprd04.prod.outlook.com (2603:10b6:806:d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 16:21:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 16:21:39 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: zoned: fix bandwidth degradaton
Thread-Topic: [PATCH 0/2] btrfs: zoned: fix bandwidth degradaton
Thread-Index: AQHaMcuGvPcjWBjdAUGW1SH9eQpYy7CvOPYA
Date: Mon, 18 Dec 2023 16:21:39 +0000
Message-ID: <d26ae81c-7dec-44ae-b5f1-82a5f30c80f6@wdc.com>
References: <cover.1702913643.git.naohiro.aota@wdc.com>
In-Reply-To: <cover.1702913643.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA0PR04MB7258:EE_
x-ms-office365-filtering-correlation-id: cfe97775-1cf6-4ee3-b787-08dbffe56a38
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 m/5PnNMho/f9OBt3ThIVv7Z09JQu/ZohSQz1xFIiMCAtkFyjOYpZXaeWRl1969u1G+57qdGEhm5objd9tmEfYHD7FMBT1x4/+SRPWMLkXCSkYa+NAeFB96smPi8H54ZYQwCXq0uUVJd1CZZ6zcblsZa/88lsi3dxl35PGbj0iSq7Odp6e2zUH4IHqZF2EOqrtmY7VV0MPCMnpKNb5uSm9FkRpfcqNdYeWwNJjY2sp0B5g6a8sNLc7zLl2uFyLMwwfpR1rjgQbuzwj3x3NkhyxZg2lkLfSel2Q6tKJu1EAyQxqD3EIo/wvayPI4OOi80/nc3Zzg+BiMYzZIYmYHVgk1LtjgMEwO3mcqKJ1LnQeZMFzoLwCykIcfEzPJesoI5+TannMiU8HbPZ26A6wyJ0XdZ/IDz1kL/dtF3SYCp/2+p3w0zAS6nXb7tm/94dSWsK3zG4EDWgMavFof1HZR87tzfXmfL7l6V3gJ2XerUmcn7HVgQr157xv/I5YVZrvArEZKR28aY47dtuix0n754Y1f0dyk7coOhHP1wQl9Vvqabb9lZcAsrI5C61hf+WtWxuE7z4kAgWpLbKh9KksTBXqvKgt1+PQavfMg1517nKsKfeLY7BQZ7P3WbnHc1Pnq5DxTbS6c0XEWZ4TCHr64YA8Bk3GzovNiTm2mh4VAhcK17Owll4upy8Wf07Lqo7B+kV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(38070700009)(66946007)(66476007)(64756008)(66556008)(66446008)(76116006)(91956017)(82960400001)(122000001)(38100700002)(558084003)(36756003)(31696002)(86362001)(4270600006)(2616005)(6512007)(6506007)(2906002)(316002)(8676002)(8936002)(110136005)(71200400001)(478600001)(6486002)(5660300002)(19618925003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFFUQzk4dUo1aXhZb1FmSmlDSUROSkJxekhnbGFZMWJXNkpiV2xZbTFyeDBW?=
 =?utf-8?B?WnoyMFMvYUQ1M29WemVsOUN3emhzbkRmdmE4Ym1SWGRIdEtacEpMb2F0MnMy?=
 =?utf-8?B?Z3BLZDJrdHRMWFRwMUhUU01KS3ZoNmRsQTc1VWFkdGF4WUozWHhjaCtVbnNF?=
 =?utf-8?B?a05PZ015by9HckpmaFZjR283bVNnY1AzYWNqUUpjekVJcTZtaXhpcEg4UEVj?=
 =?utf-8?B?d1VYdzlTa2FUa0ZtUHRMYk9TSnJYeGxMaWJJbWVxem9BNWw3OUlhV2R6amVw?=
 =?utf-8?B?djJuWk00ZEZjakNnZ04xek1FcUlpdnM0cW9EbVNWRVJrV2NXMEh1TFROaDUv?=
 =?utf-8?B?VjBnVmh5ckpvWWpLajVoUk9jVkQvVmcwVnE2VEY2M2VodXJxOGFtQ3FOc3Az?=
 =?utf-8?B?MUVUT1V0LzJMWXRqU3p6bDc5MkZZUThPNW5Cb3VXUXdHeW11Nm9zWUNOZWt6?=
 =?utf-8?B?dzlCVlFCcjNHVnlqYndZSXI0SlloWTgyTm1HMjltbWtLbHBTWWJpakV5SmtH?=
 =?utf-8?B?SVk4U0dndFZOVldMNVZKQWhxN0VRdkt4VHlCK0lpUUM1L3JjQzMzRTE2eTVG?=
 =?utf-8?B?dEhkcFV6Q1N2ZVJwb3NXZGNOWUp5Y2I3cmgrazdqK2psNW5Cc2RkYTZKaVg3?=
 =?utf-8?B?cWJ3REY0WGZZSTJ1M2RHY0dCVkVNeWFaZEhINVFwc0RvSXlwbG53ei9yV1hq?=
 =?utf-8?B?YVhBdDFHWWorS1RwZTVrUWxvaDVNMjhnOHFZWE5oYlVIV2p2SHRNMXFCYjUw?=
 =?utf-8?B?aENyZlcvY2pjR1BveEdJK1BmOGlRWVFXazNaVU9lcnBHNjc3MzVJUVBRcHJa?=
 =?utf-8?B?RHRadllsMzhLY2RjQjZQbWpDMHp0TEVEMTF2cGZOMlZ5MGM2V2VHTVU5NjFk?=
 =?utf-8?B?cWhpWEFYRFBxZEwybGREeUYvdnBpc2xIb0tHZ3RuL3N4TFk5QlAzbmdJalM2?=
 =?utf-8?B?ZU9VTTRKbExDeFV0UGR6K3lyZXBNMHVqOWxSVG12WUJ0c2duNUR5MjloYmdh?=
 =?utf-8?B?WEtWV1VaaTRaTWc3dWliZXoxK0JGN2dXT3FLczlHYTVhQmxwY1pITGlDRWpR?=
 =?utf-8?B?NFowR1doVkc5bC9SdFVlWFZpWittY3h4c3ZJWTQ0R0daZUFPUXQ2UWpZWGZs?=
 =?utf-8?B?d1V5SlhURzVTYnhVL2hCQXR6ZEJlN1VqZEZIalk1V0crMWlwV3o5U1dja0Ri?=
 =?utf-8?B?eTEwdnBxU08ybXJzcTVHVWJ5TTVrV3BlbVRoNWhhMFl0am5UdkxQN2FZaTVU?=
 =?utf-8?B?ek9aVWkxclI2bkNUckhwR08xNTFsK0dpSHRCZDlwOGozSjUvN3AzVnBUTVE4?=
 =?utf-8?B?ckwrcTByYVEvcHFUQmtDTTdYWXFkUi9iVHJVeWQzaFVaL2hpb1dYbEZDMnRw?=
 =?utf-8?B?U2ZNRTRad2YrbHh3VkgxbE5GQkxFTHlqVDkzaVFsaUxHTzQvNFV5WUx3eHZV?=
 =?utf-8?B?SG4vdk5yTVB6MURIRlRZVnROdWdraDVFS2Rsc3FVQ3Arcko2S0ZQc25ucHZ5?=
 =?utf-8?B?LzBvV3VsQkNQWW5GWVlFOHNsSVdNQU5tTzNPMG5JRVpRTEdMOTIvcGZvbFVp?=
 =?utf-8?B?Qi9sd3lzNTVHY3hzbFNGajBLekZnbEhHZXhveVVMY3RWODcxOUlGeWJoMGYr?=
 =?utf-8?B?UWxPNkRlWkN4K2JNV0pMNTN2NHMxVlNzaTZRVnM0NlIwSFlHdlNsQzVwcGlz?=
 =?utf-8?B?M0FOK1VkMW56ZVZWMGdHYXRQaUQ2dk4yZXRWN3NvWXhyUUUxRDRUTytYOVI0?=
 =?utf-8?B?QlRyYU04RGxvaERUbm1tclBIb1lrRmtqN204Tk5ZUXJKaGJVbWw4cEJyUnpW?=
 =?utf-8?B?MXZsR0JDd2l1R2dBWkRMUVZ1RDk2WnYzRms3bTJWRU11U2M5c3o5VExac3V0?=
 =?utf-8?B?TTNNdmVQQTFNcGxoR25zNWgzd3FoVFpTejNJYzhYMnZzYlYyY2RscmNZa2xI?=
 =?utf-8?B?a2pUcU5MS1JYN1E2OTlaOEhjQkVkUXJlY0ZHUDVkNWVhcG15cE1sWklTbXRj?=
 =?utf-8?B?MTJzc3o1SVpUMGN6RHQ2cVArdk5haTU2SndFT3FRTHNPRzdscGNHK0JCN0Nk?=
 =?utf-8?B?R3FMWSs4Ym5CWGNiTElQQUUzUVZ1QWZIUHNRWTNzOEt6YVRVM3RhRmlUczBh?=
 =?utf-8?B?ZHQ4RjhRQ0JQZXNlTElLVFVZVm1YZ3ZCMndSV2hWWEF3U1I4Q0RrYVFKU04w?=
 =?utf-8?B?M1g1dUYyeHNqcXhrU3ZKbjZTOEhlL25oa0haRjNDNHNTL1JTMkw1Q1VpaEds?=
 =?utf-8?B?QXBiTmdNVmQ1U1h4N2RoNUk0cnl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6232CDC08FD06E46B256B7CBE892644B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8b3zrxin1RuvuktVVcjvwUD4shPehvrC/2DgS5k9BceNom5Rl7Hj5y1yVSqvB2+7+MVFTuqnlXYLnmggYtm2jifMhZA3eSFbPlCYxDPveATdiwvCPbfP17JMTNAOeTFGaHAoB+aqLmimbOFgKA8t6JqKgNyo/CdRaTp43zNftIbUTuL6+hsdmPpQN02Spfe7NqHFSiNfjXE4P6Qrhq4KtxvdmegvG6gALdg/sUanSXByo0XSOUlmt73Ln03BJp2sn69UQUUH/LZNKS6V9vlPGPDboSQBRogUsrsmXGsuK6r3Qj0w0AaNu/s9B9W1NwIxBr7UMXX87vSV3irua1TD/YbUrynS5r45tNFnf629hSwRtaaLzQdHPp+aAnJWUmrzImPVASySgaCw+ZUxxZ5ypnwnyVrzO4BTDipBAdrOLuV/Ny/75W/kGMu/j9Bi/JUjhxvZmFx3gKmbY1rYLJqd+lgkVZJqqWYhPmR42qUeihpeC7Tk5WPRd3H0FE5z0vuHlY5+PV2zvjDYa0YZbJd+dJgcjNqU2VXBcVABx4B0kxGBrtH/JQdwt5w4h/UEvJ6K9aBfiJ0mcT2biqvgfPna0sp6fqFBT+A93JqL/vtL4NeWAjdmRQHTnlrTSd1kCMSk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe97775-1cf6-4ee3-b787-08dbffe56a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 16:21:39.7295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDsy929DqmoS7vHBX9eaMWWyzuAVqQHMVH6SgejkFG9YNuADYno7ufar0c7MWsX0NWebqx5q41+/5z06JQIYx5vvGcZypMFKGinWk4eg81E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7258

Rm9yIHRoZSBzZXJpZXMsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5l
cy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==


Return-Path: <linux-btrfs+bounces-11144-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8ACA21FCE
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 15:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF59F18849DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935C91D63CC;
	Wed, 29 Jan 2025 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lovtmQEw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vDewbIOr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0942167DAC;
	Wed, 29 Jan 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738162555; cv=fail; b=UzXCmwFm//VEJWdIeyn95tIINFtXRDebpshotNAVAM0YuDKoksouiZ89WQ4lumypUBmyFOWChfgb2F7O8nOciD8zNegHorW9AQHQDX2vsa3MSfXoUmYze2N2mTMpehAqixcUcrSJUIx7eNsXjAKx3joIbDhywARxzoqRvHGU980=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738162555; c=relaxed/simple;
	bh=5Vzd6tbE8iBXWn3e0Zck/r1kET6x7vi+A8nj1iEhwDQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=injM//H9J+qNwmi2Q29DtZjmPCwCyeomISKXgpRyJaQNShxG2x74h7fjAkFYx2mAZTHYZd9hbRfEPBZmBDznob5TCNro/qwzAk5LfBOeYf5zLUbdtxAB7C6LPhK3xUSAAkK5YM+ScaGYIi6i+SYswy8INY5iFV17hxt/3f4qRH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lovtmQEw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vDewbIOr; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738162554; x=1769698554;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5Vzd6tbE8iBXWn3e0Zck/r1kET6x7vi+A8nj1iEhwDQ=;
  b=lovtmQEwGKrWKV+Fw4OcHFFGXM3maPTceq5rixIdypQSs+N/MfvY90TH
   NQGEl56neO31plLo4povLiTJyReVtNfE6vuev1IGHAlnuCxgmQIgqLGgj
   A9l4dEdOK327NB0b9mCzRSuMpHqHyo+49ZTcqBt0zG0bxL2DHTIe9DRCD
   o07QbDl3zDQD0IdDud1AAQwPSZxgZ4qduC8w2EoTwA1y1vcSTTtSncSoL
   RAk7Y8Wsoh+BRftTMh4xkN6mV6KfK7LDkjIvR7KjKKxctVK6cf5JD46cX
   Wb6H9wVhMK52peMmrD6k2uGIO+1v2MIE5ewCZp/NMTirlfrv3TL1XTLYd
   Q==;
X-CSE-ConnectionGUID: wK9z7OkGRuydDZyoCEM2NQ==
X-CSE-MsgGUID: By1g/PEgRAWjkrZr7YO0pw==
X-IronPort-AV: E=Sophos;i="6.13,243,1732550400"; 
   d="scan'208";a="37082151"
Received: from mail-centralusazlp17010006.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.6])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2025 22:55:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dy1d5MJi8PpcHpvLAq950xtEaqcTwOiZ2HH20It8oeP+1RSkIO8v3Zn0QgZJG1T6RoyXITY7PG/6rbRd+aYIpMZE6EbBr3kfzD9Gk7DO4Bj2U5tytAyGZsDXcEQC8hwjL237HpWiGMQnudfbbjK9pxXuaKM1qk+KpSDMH+Zu8KYEeL+3NBiP/lkPyjY6JZrLLKQXuXumWJL6Sn0yOxi1tQwNBy3eWVJ1PBpfpw7eUicSN9+n/tpoNsVxyHZnVs6qKohe581HTK+mEWmkuo6Xp0Jl8nJH5bzWxeRAtOnKnb2IKCrHiWEo386uOM31C5olCJ9UtCRxZIA4C+6cIgWpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Vzd6tbE8iBXWn3e0Zck/r1kET6x7vi+A8nj1iEhwDQ=;
 b=yPIOiTCvMhrfiLAN35dZayX6Rs/pn4poaXFu6/PinG7iWiLu5IVHmJetIAhrkdGoGQC5lb+Rb4nXs0iQu1/8QcnuMhPWmIDZ7epjr1eIQrlgz8VHszXy3Gztw7RRr3v0wPAdYP3c6f+Lo5p61pgdCAoTEuuyss1Uf8lBaLcxXQuzd2nj4ar5/7Sucy5CLo9Q0lfBTpSjI+q1VoG13RS2ZvVoXMPiHtzZ4kPC2yVpwNI2CjkGQ9wo8HsKNVi1a2sYBwjSjPOvpOKJQ06aptZoOfWx5Le2izNJTU/pCFvAvfW5T4HNP9er5GVNUczjRTZCwXwszGoOyTppzjiqSscDpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Vzd6tbE8iBXWn3e0Zck/r1kET6x7vi+A8nj1iEhwDQ=;
 b=vDewbIOr4x0z9ojo+25PwNCDnxJagar5ACUmEslZAQsL3mYw2Y458IVgWi/5MkY9lyE80KRVT6wTAsBF4lU8RqOQNYldG1QuUynf4gSbXBVwtCz8EbsayOkAomWnNz9neeA9eE6Jw+DpNYc6MRIpy3WENS0GwnTnZKeQJ2vBybQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH7PR04MB9644.namprd04.prod.outlook.com (2603:10b6:610:252::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 14:55:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 14:55:40 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>, "dsterba@suse.com" <dsterba@suse.com>, "clm@fb.com"
	<clm@fb.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "kbusch@kernel.org"
	<kbusch@kernel.org>, hch <hch@lst.de>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [RFC 0/3] Btrfs checksum offload
Thread-Topic: [RFC 0/3] Btrfs checksum offload
Thread-Index: AQHbclgBeWHKAo6I/kGqcNmmsyoZKLMt1wkA
Date: Wed, 29 Jan 2025 14:55:40 +0000
Message-ID: <299a886d-c065-4b75-b0be-625710f7348c@wdc.com>
References:
 <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
 <20250129140207.22718-1-joshi.k@samsung.com>
In-Reply-To: <20250129140207.22718-1-joshi.k@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH7PR04MB9644:EE_
x-ms-office365-filtering-correlation-id: 4593a2ac-0888-4d30-b49d-08dd4074ffcb
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDVObVBjU1VVR2pSVDE1blR3RHltWWlrdDEwemNvYU1yRlIyT3g3L0N4NWNP?=
 =?utf-8?B?bVI1QVVqZnVEOUFUajlBVDJwN1NYSXVjVHZDdGJCUnVtc0pLYXJHNUxJdjV6?=
 =?utf-8?B?OWVCd0w4WjZzc21HQURtSHovclQ1RWZ1RHVjbE5scWtkVERYNVkzZnJmVXEz?=
 =?utf-8?B?L1pPeWpvVkcwaWhpSTlWQ1hIb0VJM3pBV2JNNHdOeHVZbktCYzlHZmxZMTE4?=
 =?utf-8?B?RGRVdTJya2xzc3Q5WFp5U0hEMVQ2YTFjcFZxWkVnVTZkNGMrSk9aM2JBOWVS?=
 =?utf-8?B?UVQzbFJ1WVEvT2VxZ2pSOG1SLzZHUVJvQzk3QlB5bUxETHdYUFdpT1BseDAv?=
 =?utf-8?B?aitJSS9NTWplaWVUOTlpUnhEdjRBSzg2NEJmYXNZNlpUdkszZk5hRjRLY0k0?=
 =?utf-8?B?T0pwd1YxUm8xVmZYeUQwUGxYTUR6N3ZURUNQcnUvV1JUa09aeTA2d3RicDYx?=
 =?utf-8?B?bXJjMHc1WHQ5U1M0SjJCemxrZTAwUE02S0ZiNlQzanNDNnJ6bW05QjczVThE?=
 =?utf-8?B?a0FiMFgyeGlhOHhkeHlBNFc0eS9kRmdWd2JXYmxGZEdCYnZmYXFYbldiMzhS?=
 =?utf-8?B?TThrazFMZkdMby9pUzdzT2N3ZllkYkxSTXo0U1VpZE9PazhCWFBqUUJRaFJo?=
 =?utf-8?B?SjdpM2svWGRaVmNlZzZHOW9zZVM0SjdSbDA4QTRIbWhWWWsrUGp2ZnlMWUwr?=
 =?utf-8?B?T0lvTU9Db09LcEJqMmdQcXQrMjdsV3o0SGVxVERHcXYzOXFxSXR5bFVLRUQ3?=
 =?utf-8?B?UGQxNWtKRmVRUXpDc0Z5ZUhzd0RHMzhocUpRdkZPMHFBN3lVaTBLNE5tRkpP?=
 =?utf-8?B?akVQdFI0dEtWTXo2QWZpaEJ6ekc2NFdKUWlGNCt1K0cxakEyeTNhbEcrMnJC?=
 =?utf-8?B?ZjNhWkZ4aG1wNlUyRXNFajR0NXYxNGxtek9iOVM2dE1MbXJ4TjhWQ3JiS3J5?=
 =?utf-8?B?QmNGaUFGS1l2cEd6V2tQajhaMy9vYmlXM2R6bjAyTFJiVVpEb2RHbXRxRDFk?=
 =?utf-8?B?c204cVJibjhIYitQcGxPaVNxUWs0b3gvT2xmQzNZc1g2K3BSd0x3NENXZThK?=
 =?utf-8?B?UWRsTFhCeW1uYnFwMFVYRDhDTGx0RTcybUE0aWM1blY2Z2tmMGV1SzBicFRK?=
 =?utf-8?B?QkpaeWtZVi9EaCt3Wk1uL2J5WG95ak9DL1gxV2ptTFYxYmcrYitUbmMzMVVm?=
 =?utf-8?B?ZlhSRitmVnFvYTVIKzNYUk9nVnJxVWhqUmk4L1k3M1BzSXBpblowZmlaWW1I?=
 =?utf-8?B?dXJOZTBEWU1LQlBpU0Uzb2tmVWxNSUNxbzI2ZmdaamppVS96c1lJZmtwVnBL?=
 =?utf-8?B?bkIrai91eU0zS3AxTXdRZTlqS2tTdjRIUXlaSlpheVpTeWtCZlBzWmJPdHN0?=
 =?utf-8?B?NmgwcTFSVFBKSVhVaWJHRVFaVmdpUjE0bVZEUVFta3EvK0NDWjB4a3RkbGlP?=
 =?utf-8?B?akhvRFJhS2dLWmRScFdONU9FL2VEbkxkQUFWRFJldjg3NUVoNk9RT2wyNjBp?=
 =?utf-8?B?RCtXZ3NPM0NWSjNhUWFSNUNzVE5kMkNBZ3dsWWd3cG8wU2puRzBiTmZpTUZo?=
 =?utf-8?B?R0NodXB0UEhyNHZsaWQ1U0hCOWZzVmNYSDVUYzcvSXdTNG9JMkZZRHpTblRx?=
 =?utf-8?B?TFZqYUlSYThpZGJxZEFlb3U0WnpJeW5ORnY0cGpZWnlFQWVWTXovbGNxTlBt?=
 =?utf-8?B?NVA3RjRTcm9zb3JhOVNSSkJ4Q1ZRbXBNT2FpYkhWamtKNEVvTTNTVEFNTjdl?=
 =?utf-8?B?c2VLU25XL0M5a3FRUm1SYnE1MlpGMnhJT1FGc2tZdnNkTlVSRFZiSUNXcWMv?=
 =?utf-8?B?ZzRBVEJQbjVXN3F1SHpzWnVDdUs5SUNCcVBkbTFxR2wvaUJtSmdRek9LSGp2?=
 =?utf-8?B?SWhuRk0yN0dxeDFsb1FUbmpCVk9XMGpDdFgzdDliU3o3SmxEdGxpMmlQcW5Q?=
 =?utf-8?Q?MJqJOkw2ePJLzIut8moIySPTz/ABj16d?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXpjSThYZCs1bVRRMVROdEM5dnVWanp6RnpuQnBaRnI1cmY1aWg4a0p2Z2Nz?=
 =?utf-8?B?ZitnSm5OMTlhbUpaUHE4M0lvUkNPUk1rTGR0SHpKeGJzaVdxRDVqd3IvNUNZ?=
 =?utf-8?B?K2V2b1V6WVkrRHRhVFFvVjdGSDJKS0xONDlFbTZOYThKUVB0bU9VRkNSM1ls?=
 =?utf-8?B?RElrR2FiMXlUOEovWmVXV3UxWTh4V1Y3R3lKbDBuQmtmK2ZCWmRMSVZEL1VF?=
 =?utf-8?B?cWQwNjN3SUhnRWZsWXl6ZjVFa1o1SytWWHRtcXRSMDBRZ0xQZFJzaGhBRHRV?=
 =?utf-8?B?ZmRMZmd1bHFEaHZaSUpjcVY1UGoydlk1RXE4UEdTMDR1ZjhtSmc1dDV3QnhN?=
 =?utf-8?B?akJFVCtBWmN6TmxPeGY4MDRaQUE3TWF4TVJPejhnTWl2dHpSOUYyL1dqbEc2?=
 =?utf-8?B?UGlid3M3V0lBem1VRVNqLzBKeTZpQ3pNSUV2THBtM2xnUXdVcitTTG1ocjNu?=
 =?utf-8?B?dncxdklFYXBEaHQxaHhBaGVPemZOQVNOWlg3ZWpySW5LQnlqcytVYis0dmxw?=
 =?utf-8?B?eXR6RUNuTHJhVW8xMzFtNklDY0RrRnhHMEN6TkFlbkoxMHlzMGdULytnMGpK?=
 =?utf-8?B?QVZwbUlNNlVFNWk0U2UrMWVZMmlFOXFWRnFIbUgzKzZiREwwTWJTN0c4Ty96?=
 =?utf-8?B?RGNHM3pLLzJTdlVBVDFnR05ndjZaRjdEVjdLZHppdXRXa3V2czVhL0dTTCtX?=
 =?utf-8?B?RW9DeVo5QXY0clJCNUpwa0gzQUduWVlXWGNPaitrYkt0Skl6aHZiZDBFd1lG?=
 =?utf-8?B?a0U2Qkoxbks0d3ZPNXVtMmUzcm1iTzZUZFVpSk5VZVR2THdFODNtbFhLZWFw?=
 =?utf-8?B?L09SNEg5RE1CQUlEOHg1N1A4VG5IZGtmVXpFbmgwU1FJWHpjWkVHMU1obm9j?=
 =?utf-8?B?RzMwYXllTGRwYndwWEdoWks3VG5yWmsvM3JHN1Nra0YvSThaM1RuTHZNT1NU?=
 =?utf-8?B?WFBCL0ltZkFhcW9sSWxxZlczNnk4RmtDcy9yb2tScHpVSVFWUVBEbFl0cC80?=
 =?utf-8?B?azZpRGFBRjU2WXMrZlNJUWlETFhBU2U0M3F1blJRdFRMNy9qS2dpcHpWNUZi?=
 =?utf-8?B?QXlPOWJuM3RJTklKTDk1STY1OS9heGZoekp3UTNxejhXUkxKcTJ5cS9QWnZj?=
 =?utf-8?B?WXNYd3NvaUplRmZ5S1NFWWk5Zjg0a3g1bmRJZVFHNGx1aW5zWWh5ajdUQzVi?=
 =?utf-8?B?SGpHemFQLzRuRHJmVlBWNW1JaXFESDJNQy9lcXJFMkQraEIvZHExbWRiUXhj?=
 =?utf-8?B?MjBKcVhhL3R0MkdFOVNBYlBWT3cyYlRBZzAxZnpqMVpvd0pNbjRqS2xiWSsz?=
 =?utf-8?B?elZvQW55M2lmYm9DV0l4K01iSkhObmg1MUsrcnliUWxDRTZsVHhWUmpZSUNB?=
 =?utf-8?B?UWx3NDZGQXJFUUNqelljR0E2Q0R4QnNqVkJtd0RMOHkwd2FCYkxtMGN5MXMv?=
 =?utf-8?B?cjhKQytnamNCZjlvcEY5MjFYekdxTW9OTGQ1dDNFa0wyb2hySGJkS1FQQjlW?=
 =?utf-8?B?ZFpwb3R0K0VvUEpkeFdBRDFUbWRvTk1hbzNkYjM5enVKRlBCQS92dTZVTXg1?=
 =?utf-8?B?K0tIVlRpem0wd05NRzZlcC9vdGxVdHRUQUloQld0ZThGd2hXMk03M1c0cllk?=
 =?utf-8?B?aWpuUHFVbWdnTStoSTZsdEhlQ3BGMGhraGg1NjBELzM0L0ZubVhjcE85WHV2?=
 =?utf-8?B?SE9UWE9Wa0JEUTRDSTZRL0lVVnQza2Q5QWlxMGxUUXN4bVVlRDBXUkEyanFt?=
 =?utf-8?B?SFlUdG9HYkV3S29lS1FReGVNYkovc1c0T0laNXdpR2xINy92a3diNW5XSHhN?=
 =?utf-8?B?UTJoelRZNExHdEY4QnQ2U29mcjVPWmFqSlZUK0RPY1MwZ1V6MG9tQ1R3Q09Y?=
 =?utf-8?B?MG5sZjMySG1nUVhvdmUyTVVIenk2Z3hIL3ZMWlhMemFvVlEvSndDSm5CaFU2?=
 =?utf-8?B?RFB0K090aWpJbDE4RUNNTHhTdDg1SWlZNFVtMG1NbHhiU3lzY1M2a2hqZVdR?=
 =?utf-8?B?VURVUVRUVFBpWTdRNW9IZjBvdUVFMUtkaTBQOTNXTWVKYWtyNmMzT0dsdkZW?=
 =?utf-8?B?V2RIVWh0MTE1ZEJSU2tZcmRqcnBDRTNQcDIyU1dNcVNQLzB5WUZBL1c2Z2ZB?=
 =?utf-8?B?WTlCQjUvYmFwUnB4Ti9JMTRrampVK25sbzdRU2I3L1VmaFNZSURXcnV0VW9U?=
 =?utf-8?B?MnJucXQ3V09ySWhrMmpCSUtqY2FiNVYzZERHc3Y4eG5lK0Y2S01NaWRVMi9m?=
 =?utf-8?B?MU94dzVaNHUvLzZsRkJFQ0dLampBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC6F3AA24547634BA080DEC0576D935E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sIjGJTQChj0+988B+i6KdxMPLwoxrkneYffYhNOGxFvd6yKfbj4vfzRcEF1teAIyEgX+EAQnSRiHH5SqiTAP8SKtQITCaM2AtfYWlRBWnWolwA8nEUvjIeX+5GTlj5lIyj4ex8Wnu9FA3AdzbAescS2mcKllwZazR1fWklwmJIjF5qO1d2PHvRiav+9vMg49gS3ns907PkvbMOvGR58OjU0xXXG02PXTp0kCklscAYRR/QLxjuGFtMtaCP/MNy3XuQgEypyheATsELHQETrmcg5fs/7bcwQBing0pyyTxZ1xUx/GlaUecy38uMoOFc/+Onp/F/dIFWb6SZQkhUPbosVyU7rmGZa4/FdyXangSKNluFkPvQBpOnUENTowm0HboJ6eUSf7Tdaqa9ZjNTgv6c/SCS6bypeD0hLJndh6ahlMrpgN/JKp3iIrXGFTmVLPJtns11++j0Ns85hjfuqSnVXqHjQPhYtIIHdX1VWXfMmh3fL84/w3bK/6txCPBQpJi3z/KX8JU/sMgn/4z/jnI4PwHjfOW6X2686OLuJjlsdkdaCxhhFBWnwMQBnLEdqPdFKVdHcEAi8F/KPHeNanL2nC6z2+1/Bg7gtbuEofm4TwpTBli7z8+U8AcWMTRCkg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4593a2ac-0888-4d30-b49d-08dd4074ffcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 14:55:40.7891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thH+xEU/HCMpJJdZFEMvAM3TIEHwtzw70k68mGttTMwxz2ibJJdx+rfvPZVt+jDVXCKz7Ub/0Scw3q4svRt4YWg0R32cdE/sxYZ86DMDHTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR04MB9644

T24gMjkuMDEuMjUgMTU6MTMsIEthbmNoYW4gSm9zaGkgd3JvdGU6DQo+IFRMO0RSIGZpcnN0OiB0
aGlzIG1ha2VzIEJ0cmZzIGNodWNrIGl0cyBjaGVja3N1bSB0cmVlIGFuZCBsZXZlcmFnZSBOVk1l
DQo+IFNTRCBmb3IgZGF0YSBjaGVja3N1bW1pbmcuDQo+IA0KPiBOb3csIHRoZSBsb25nZXIgdmVy
c2lvbiBmb3Igd2h5L2hvdy4NCj4gDQo+IEVuZC10by1lbmQgZGF0YSBwcm90ZWN0aW9uIChFMkVE
UCktY2FwYWJsZSBkcml2ZXMgcmVxdWlyZSB0aGUgdHJhbnNmZXINCj4gb2YgaW50ZWdyaXR5IG1l
dGFkYXRhIChQSSkuDQo+IFRoaXMgaXMgY3VycmVudGx5IGhhbmRsZWQgYnkgdGhlIGJsb2NrIGxh
eWVyLCB3aXRob3V0IGZpbGVzeXN0ZW0NCj4gaW52b2x2ZW1lbnQvYXdhcmVuZXNzLg0KPiBUaGUg
YmxvY2sgbGF5ZXIgYXR0YWNoZXMgdGhlIG1ldGFkYXRhIGJ1ZmZlciwgZ2VuZXJhdGVzIHRoZSBj
aGVja3N1bQ0KPiAoYW5kIHJlZnRhZykgZm9yIHdyaXRlIEkvTywgYW5kIHZlcmlmaWVzIGl0IGR1
cmluZyByZWFkIEkvTy4NCj4gDQo+IEJ0cmZzIGhhcyBpdHMgb3duIGRhdGEgYW5kIG1ldGFkYXRh
IGNoZWNrc3VtbWluZywgd2hpY2ggaXMgY3VycmVudGx5DQo+IGRpc2Nvbm5lY3RlZCBmcm9tIHRo
ZSBhYm92ZS4NCj4gSXQgbWFpbnRhaW5zIGEgc2VwYXJhdGUgb24tZGV2aWNlICdjaGVja3N1bSB0
cmVlJyBmb3IgZGF0YSBjaGVja3N1bXMsDQo+IHdoaWxlIHRoZSBibG9jayBsYXllciB3aWxsIGFs
c28gYmUgY2hlY2tzdW1taW5nIGVhY2ggQnRyZnMgSS9PLg0KPiANCj4gVGhlcmUgaXMgdmFsdWUg
aW4gYXZvaWRpbmcgQ29weS1vbi13cml0ZSAoQ09XKSBjaGVja3N1bSB0cmVlIG9uDQo+IGEgZGV2
aWNlIHRoYXQgY2FuIGFueXdheSBzdG9yZSBjaGVja3N1bXMgaW5saW5lIChhcyBwYXJ0IG9mIFBJ
KS4NCj4gVGhpcyB3b3VsZCBlbGltaW5hdGUgZXh0cmEgY2hlY2tzdW0gd3JpdGVzL3JlYWRzLCBt
YWtpbmcgSS9PDQo+IG1vcmUgQ1BVLWVmZmljaWVudC4NCj4gQWRkaXRpb25hbGx5LCB1c2FibGUg
c3BhY2Ugd291bGQgaW5jcmVhc2UsIGFuZCB3cml0ZQ0KPiBhbXBsaWZpY2F0aW9uLCBib3RoIGlu
IEJ0cmZzIGFuZCBldmVudHVhbGx5IGF0IHRoZSBkZXZpY2UgbGV2ZWwsIHdvdWxkDQo+IGJlIHJl
ZHVjZWQgWypdLg0KPiANCj4gTlZNZSBkcml2ZXMgY2FuIGFsc28gYXV0b21hdGljYWxseSBpbnNl
cnQgYW5kIHN0cmlwIHRoZSBQSS9jaGVja3N1bQ0KPiBhbmQgcHJvdmlkZSBhIHBlci1JL08gY29u
dHJvbCBrbm9iICh0aGUgUFJBQ1QgYml0KSBmb3IgdGhpcy4NCj4gQmxvY2sgbGF5ZXIgY3VycmVu
dGx5IG1ha2VzIG5vIGF0dGVtcHQgdG8ga25vdy9hZHZlcnRpc2UgdGhpcyBvZmZsb2FkLg0KPiAN
Cj4gVGhpcyBwYXRjaCBzZXJpZXM6IChhKSBhZGRzIGNoZWNrc3VtIG9mZmxvYWQgYXdhcmVuZXNz
IHRvIHRoZQ0KPiBibG9jayBsYXllciAocGF0Y2ggIzEpLA0KPiAoYikgZW5hYmxlcyB0aGUgTlZN
ZSBkcml2ZXIgdG8gcmVnaXN0ZXIgYW5kIHN1cHBvcnQgdGhlIG9mZmxvYWQNCj4gKHBhdGNoICMy
KSwgYW5kDQo+IChjKSBpbnRyb2R1Y2VzIGFuIG9wdC1pbiAoZGF0YXN1bV9vZmZsb2FkIG1vdW50
IG9wdGlvbikgaW4gQnRyZnMgdG8NCj4gYXBwbHkgY2hlY2tzdW0gb2ZmbG9hZCBmb3IgZGF0YSAo
cGF0Y2ggIzMpLg0KDQpIaSBLYW5jaGFuLA0KDQpUaGlzIGlzIGFuIGludGVyZXN0aW5nIGFwcHJv
YWNoIG9uIG9mZmxvYWRpbmcgdGhlIGNoZWNrc3VtIHdvcmsuIEkndmUgDQpvbmx5IGhhZCBhIHF1
aWNrIGdsYW5jZSBvdmVyIGl0IHdpdGggYSBiaXJkcyBleWUgdmlldyBhbmQgb25lIHRoaW5nIHRo
YXQgDQpJIG5vdGljZWQgaXMsIHRoZSBtaXNzaW5nIGNvbm5lY3Rpb24gb2YgZXJyb3IgcmVwb3J0
aW5nIGJldHdlZW4gdGhlIGxheWVycy4NCg0KRm9yIGluc3RhbmNlIGlmIHdlIGdldCBhIGNoZWNr
c3VtIGVycm9yIG9uIGJ0cmZzIHdlIG5vdCBvbmx5IHJlcG9ydCBpbiANCmluIGRtZXNnLCBidXQg
YWxzbyB0cnkgdG8gcmVwYWlyIHRoZSBhZmZlY3RlZCBzZWN0b3IgaWYgd2UgZG8gaGF2ZSBhIA0K
ZGF0YSBwcm9maWxlIHdpdGggcmVkdW5kYW5jeS4NCg0KU28gd2hpbGUgdGhpcyBwYXRjaHNldCBv
ZmZsb2FkcyB0aGUgc3VibWlzc2lvbiBzaWRlIHdvcmsgb2YgdGhlIGNoZWNrc3VtIA0KdHJlZSB0
byB0aGUgUEkgY29kZSwgSSBkb24ndCBzZWUgdGhlIGJhY2stcHJvcGFnYXRpb24gb2YgdGhlIGVy
cm9ycyBpbnRvIA0KYnRyZnMgYW5kIHRoZSB0cmlnZ2VyaW5nIG9mIHRoZSByZXBhaXIgY29kZS4N
Cg0KSSBnZXQgaXQncyBhIFJGQywgYnV0IGFzIGl0IGlzIG5vdyBpdCBlc3NlbnRpYWxseSBicmVh
a3MgZnVuY3Rpb25hbGl0eSANCndlIHJlbHkgb24uIENhbiB5b3UgYWRkIHRoaXMgcGFydCBhcyB3
ZWxsIHNvIHdlIGNhbiBldmFsdWF0ZSB0aGUgDQpwYXRjaHNldCBub3Qgb25seSBmcm9tIHRoZSB3
cml0ZSBidXQgYWxzbyBmcm9tIHRoZSByZWFkIHNpZGUuDQoNCkJ5dGUsDQoJSm9oYW5uZXMNCg==


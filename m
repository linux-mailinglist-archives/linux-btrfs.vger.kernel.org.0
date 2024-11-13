Return-Path: <linux-btrfs+bounces-9585-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 083909C6C71
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 11:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C12D828610D
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 10:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6211FB8AD;
	Wed, 13 Nov 2024 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KBBuS1sW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HichLeNz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCDA14EC59;
	Wed, 13 Nov 2024 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492639; cv=fail; b=IxGvCZ3Rr0gO8/5kR6265nsE8wHXxgT6LpoYKTmAMzvv++tfTfnEEYeJjz11HW9aRyyPKUEgtb8lPDTZrgJCIAeWP2s7OkX6K8NbR44jJMpLrsxFsmXd70LPi2q1+h34OvG0HeZRmuxUlZLDQgeO0/vj9oukZ0COQmPb9cir6go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492639; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UWz0VgZaHN2zAgW21e6a9QBc0HgK6c63w+J2D6jR36l+dE/xlTPyHFKZoTRNt+F1Uorx+IKAxswSZiXzfXMlQlyFNcGzqJIrWA67VEYetYVs69HzOAjT12NlsEBzRQoBL5uw2wC3l8DzSvYTD7KDcLwpu1mFeYwHYtf1BiNVDQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KBBuS1sW; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=HichLeNz; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731492638; x=1763028638;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=KBBuS1sWLoGGou5sNUvtW/V1rAcvNkXHFB5BHhR/e203ReaIGNkq15D/
   JYV0LQCK9vG2W3WWiRw1Q53rgfMdSyYbBtRM7WOMI1m8HfcW9meGUxL+T
   iuQOReVMJaXtNge1SPWEkzkg462kFxkN6vPs/fUCoYe8hZO/KoukhhbaD
   N8KdDTxjms6f8jJJKA1jiXrZC4P6EdG9BSqKulMrrmZOM8hszr+/phu/A
   EPP19+tfG20mlgcXp4ue3FMIzv50DX4hbIS2m6aTYJffjaeSwpuAURqm9
   /k1BeOYYelPvK1RWcP8/vqsBhWPilaRKASfbEKQ+nuSqzwilN6h0c/8pg
   A==;
X-CSE-ConnectionGUID: GwFdxee9Tv+c35cgYGosnQ==
X-CSE-MsgGUID: rbQue7FNT5WfM5xRf/dv0w==
X-IronPort-AV: E=Sophos;i="6.12,150,1728921600"; 
   d="scan'208";a="31456624"
Received: from mail-southcentralusazlp17012014.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Nov 2024 18:10:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBpnCMJqsgd4axswEuEsvVd9OTzfBgDPHBPR4jDNbgVJqLE8CUGWbjXk5CVO1nqLY6fpnUyUdWijms74cagBt7Y9gvliHf9MryKFJTu25Xhtxbej/qnho586VscYoB3pc0qZ9BD8aKwFmGSDuZcKuwFs5zeMalFxGx+uuwLOAbLb3Il5oBcbX/eKBX5b0t5qbIInovDT8CU9jJb1s1jcckx+U+4a/sz9GRvffpxHtRtlDskpfpNw121DhC67Y60+WsaxLn4J+dcC5r3XU04g/MLpQTap1gYKbPPFRYKJkVMkBmnqDS2YYJ0UoZUHmIlK0l7SWaUjmYh3/Xxpfl1Ilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=k9rZshJmgfdsuAxFxy/sdbufOvURnAHKVxYGII9cP1he02WWg8Hg2MTm7N1k2EVya/82X+zGEbxfwoao9cx66aqSVqBDiD6LFt+Jvq6pVmCsC+vGGBz55MHViHJGWVNnnnZBPY17BgFImDE9/ImIIb2qOxcjykzzuQLDZmgJDrsfhEG9XM5zu4EzxsmjbUlWIp+n+a3eYZugPGhjZdBYsh4+xyi5o6MxCBHBNIM4Huvql3YSy2aKqSiID24+OM8HNr/SFgKoMR4Eg0UsbaPiljpfzRfuyWPCk4hl/laPRjCiPf2MdkMWzeom7y+miAKX15X3H5WPJUPLDxsjW9qmhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=HichLeNzJtf0GTJfVUvwbrYvwGw855lgWy6bb7PaFjNR4jv953R3U9gkfwF/PCFJ9RF5QH0uQyqjgMe5W4xqeH/jg9rPLBE21XW4NmdHnOi98kWJO4C4vX5U5VemiSchZEpj+dM77e+5nFpdXgRZbUhx3uFQCf9rDtXmvMAWX/Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8474.namprd04.prod.outlook.com (2603:10b6:510:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 13 Nov
 2024 10:10:34 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 10:10:34 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Yi Zhang <yi.zhang@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: export blk_validate_limits
Thread-Topic: [PATCH 1/2] block: export blk_validate_limits
Thread-Index: AQHbNah/V6JYyXvUJ0GZA7fn11a3wbK0/T0A
Date: Wed, 13 Nov 2024 10:10:34 +0000
Message-ID: <0116aa45-3b1b-4b6b-a95c-80b16a328f56@wdc.com>
References: <20241113084541.34315-1-hch@lst.de>
 <20241113084541.34315-2-hch@lst.de>
In-Reply-To: <20241113084541.34315-2-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8474:EE_
x-ms-office365-filtering-correlation-id: 7caaa238-ff46-4ae9-2658-08dd03cb69ff
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N2RwbUYvTFRoNng1bzg0MWJmdFJCeWJnR0lpSGxNQ1BZSUJYekNnRDJaTFcy?=
 =?utf-8?B?VUtnV1cxcXordVY4THhYdFRNVkFQeXFuQ0xxN2lQbEt6SjdjemY0c25xTStC?=
 =?utf-8?B?a3FlQ0ZkaHBWKzZSdHA0YjVVNE1BNG5XdVgwZGU0d0Fzak4yNGw1WGtIM3J6?=
 =?utf-8?B?d3FRWjNFTzBiVHpPVmZ4QnZ4V2hxVUh0UzY3dktPOUl4aHErWjdBOFVtMFJH?=
 =?utf-8?B?SVQzVGk5SllXemVOOFN1Rk5RTWd0VlpwbHdkRFRGYzdwWG9mcVRqV1FTWGUx?=
 =?utf-8?B?M3BPenoxN1VMT3dtOXNPc1c4YWZ1VUVGb3hVQnZpYnFiNUJmbHZnVUVzZC8v?=
 =?utf-8?B?eHRvVXk5U1E2c2R3ekRFNU1qdng2dy9Vd3d6Wk5uWUZDNUVaM203WnlOMWxp?=
 =?utf-8?B?NkJ5TTRXVEZnZ0ptc3QvQ1Q4T21xZFZhZEN2a0tsUURkOHNtSWlkTUNuVjJ1?=
 =?utf-8?B?UGdVdWZEZkRQTDVMbGdZZTRnRjNjZ2l6OEdyN21xcVIvTnFJWlAwQjJiSG1l?=
 =?utf-8?B?VjJONXdtY0VwZkRWZUJQYlZKUWV2T2dqZ1FUQWYzVnp2dSt3K1F0T1hjUndT?=
 =?utf-8?B?eVUvT3hkdGRneHFjUTBUZXk3Q2psdVRkdkhaeHIrNlJQc0tTcVkva1hGeTJi?=
 =?utf-8?B?SlRtWEtwWmpNaWRxODZGbjZ0Vy9oRXgwdXBINmI3V2FPVThScWo2N0hJRTM5?=
 =?utf-8?B?YVZqMjkrZ01hRUg0YlBQWEYvc204Q0p1NTUzVGtMWFVKYWswZnMrSEdhQ3px?=
 =?utf-8?B?NFcvK0EvWGo4N3U0Y1V0dy9jOFpBS3VwMzFiUEFpV0VRb3pBTTNQUzEzSWFk?=
 =?utf-8?B?Yzh1SFNySUhNem5ha0txbUZNSEt2TkhGMXJyaXBSKy91Z1BIRDVFYmN3amNq?=
 =?utf-8?B?K05tNUx3ZUZ6TjFrbVhSMXRLME15NHlibVQ3emtHcXNHOTZpaXV1d3dUdFNs?=
 =?utf-8?B?cmhKbHk5OERmcUJJOE1qd013SWh0VVhjb3hPbjI5T3F4UnZ4K1NIalVDR0pF?=
 =?utf-8?B?MkR0RFdYT1FMVlM3eW03T2tWeTNTUkxGRFYzTnBUdWpBTVZOK1p5KzVqY3Bx?=
 =?utf-8?B?ViswVW93YXZZSmo0WHhIa1cvclhIT0Z5YlZhcExQQXlTSWtsRXp4ZlNEWE5W?=
 =?utf-8?B?Q29teXFNdFpNSDJLSStEWTI4VnBMNGVMNkRQNDNqRlJjUDh6eFlBSFJWaVZX?=
 =?utf-8?B?SUpDWmFqRm8rOW1WdWc1clVjYUdmVFN3VUpxN0dJUWh5NnRIWWxNbFhuaTl6?=
 =?utf-8?B?SkdZM1d1K2xEY2tSRjAyVW1zL2toZ05SWVNtUUtJWFJLTTdSNHBnQjBwUHFX?=
 =?utf-8?B?Tm83eWFLb2JobUdZTmhjNkp4cFRtWFBBSVBNaGZUYWlIaytUQ2g2K0FJL1N2?=
 =?utf-8?B?ODFaUTVNaTVzNGZMSnh5T3BKZ3pYSXpVSmxKZDBQVlhBeFVXSy9aWnUrVEpR?=
 =?utf-8?B?SmtDK2I1YWJUdWRhTExGOWdpYkRIaGJFRkZudXphS1JXeEljUUZ4dXRoL0xn?=
 =?utf-8?B?Uk9ZUzJDSy9NclRORXlIUjlUVXVsM29HZHNkUGxEQnhIWm9OQUYxSTVhYnZO?=
 =?utf-8?B?OWpPREgyZUoxeVFiOTRRenNHS3BnQ3lURnhYdVdZaFJSZnJaN2F1TlhpSUxY?=
 =?utf-8?B?L2Yrb2tYQU5seG1uUUF0SkNZOS9xdFppb1kyOVhDN3JkRHpaUHMwbnlTeFJC?=
 =?utf-8?B?Q2xHS3RTMk1VUHd4YVpLaVJSNmlOUkdJdXFXTHIyQkpPVHBOS2tCT20yeExO?=
 =?utf-8?B?ZzQ2TS9aV05DTmhxU3RuOEVaRHBQSEd4TTFub0NUTElYZm45YXR0NUJCZmM2?=
 =?utf-8?Q?n9iVVObsp2PUEtG2KeJ4jFRJKFVrLHNTkQj8g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VGhnaVYyd0FWQWJ5TFhsbm1MOTlteWMxZStTNVBveERqd1VoUDAraEVNM0dU?=
 =?utf-8?B?b2FpWUF3ZnV5VTNOVEcvTkg4VVhNejRqSXl1cTJwWGhacU9neHVwTExHUWFL?=
 =?utf-8?B?K2tqRXlybXFNZnlOcS9LTE42d1pJVWttUnFIT2JSdms3YUhwaGVmUlBmR0NE?=
 =?utf-8?B?RVBlYWxvamhTbWsrZXJxVEpmMUpMdTdZV2hoWW9kSXBsaEEzNGJ4dmVBNDVw?=
 =?utf-8?B?ZDFHbytLcGdtaVlkNWxPekVFcEd6SHJoZ0RGN3VkTXZtdUIrdmxGN0RZTkFT?=
 =?utf-8?B?R0F0YXVGV0tJS3lHV1d0RWdYZ2ovVk41MGJmeGFoVnhocS9jdzA5MjRXc29B?=
 =?utf-8?B?RmkvdUdqaDZ5UlRxWGdyaC8ybWRPQ2QwY1I2OUJBSGVPcDRWVC8xQ253QUtr?=
 =?utf-8?B?Q2VLcjdGbm1EMjQrUDNMVXRWRlhTbkxGVG5BckdIa0RDMS9sUlc1aWw5aE1L?=
 =?utf-8?B?MGxZNndnZGpxbVlkeGxyUXd5RjNWN01zdE81bHZadUs0aDNFaXVwTWhmTis1?=
 =?utf-8?B?MHovZWZWNXRUekNrQUFNZERUYzVVdlBEeGFpOHdMZklyZkorSFZRQVhEZXI4?=
 =?utf-8?B?bzlZNVBoL1JoSUQ0eGtmNm9JaE1kT0VCQ012a2F2bXFzZGFlenlidXNDanRx?=
 =?utf-8?B?VXFmSEZUdW5pQlNEL3Z4ZkF2ZVI3MVo1akQzSjJNYWtaQ1NISjF3ZnJDb3c0?=
 =?utf-8?B?SmN6aVVYaEloczhySUJ6OERnT3FwUHhoQXJKaUtWbjlrSmlWRys0MTBaTGxD?=
 =?utf-8?B?N2dlZ0ZGVWp3R1pyMitWYVpUTVY0dmN1M2h5aTJKV1JYRlFmWXBRRDUxdmZS?=
 =?utf-8?B?WXkzQk4yclpDdUFpN2UyekJjbGxDdG15RXY0aExZWTVoUzlCVllUVDRjbSt0?=
 =?utf-8?B?R1dlRmp6ODJ4N1B1bkg5ZHFXZHRtbjUwekk4NHJCWnQ3cVMrYmNobmVoZ2dZ?=
 =?utf-8?B?L1lTUWlqK2xueWVlSjNXTFl5Z050TGdVZm9QSHQxdkExOVpCZUx5TjU4WjY0?=
 =?utf-8?B?bkhKbVdHZGJJTWRDNlVJa2NyUVFvMmV3Zng3c1Z6N3lYamFiN3dpYVQ1WDJX?=
 =?utf-8?B?NExVdzRnS1BHUzBnWUlXQnN2OUdIS3ZIRkdadWZVT3R1bXR2T3Q5MStEa1ps?=
 =?utf-8?B?dFJ4UTlXK0FGTlY4Y3NBL1JBeVdUWFAvcXFnR3ZrUWlqMGpPbnBiQyt0cXhP?=
 =?utf-8?B?LzhnalBvN2lMbnlFOUZodkU4dVFEOVI3ZlJSY09nUnVra00xUU1pN1BvMFp3?=
 =?utf-8?B?YTE1c2FHK3kxOE1ZSHhXUmZlUE16ZVlqQlBpOVNxaGR3clAxZmNUdGNRT2RY?=
 =?utf-8?B?VlBvVFMrdjhFSTdzZ3ZZemZZcG5vWk9RQ29iVGNBQ1k3NURBeS9LV2FHRitt?=
 =?utf-8?B?Y25idU1ocDZ3ZjZkcE1GMzMvU25VbmJiT2UwUzNPSElLZ3hXTzZIRjlta0RD?=
 =?utf-8?B?bGg0ejdaYkNYQ2NsNUNJam1OYTBjZjliak4veGlhNnVxalFYd1NaWTFxMjhQ?=
 =?utf-8?B?NDhDVitTZVEzb2k1T0dGQ2E4djNqZXN0dkZacExSY0pza1dhcEsyejNuWXYv?=
 =?utf-8?B?S050Vm8zbUtkZ2gyZCtQZk5DT2xJT2FHeXg0OWlXYWpWU3RiQ1FUS1hLa3dS?=
 =?utf-8?B?RDJmRTY5TnZmVnFGbm5ndHFFSkhzMithWGJLM2F4WUllWkswVW9Idk9FUVZ6?=
 =?utf-8?B?bU80eWt3bzBYZGRQNjdYN2hVS0d0amdwMkFlTnQ3UG5wa2J5b0ZJZFNMZ25p?=
 =?utf-8?B?bUpaUGlubFF0azZHTFNLbFVrYm5kSE8rUjRjbk14TGZUVk5TSEo3S0t4WTBH?=
 =?utf-8?B?QTM1Ny9SRE9hZTduMllMellaS0FEcHIyRElGUVl0OWwxZ2ExSGJCMUJ3Q0E3?=
 =?utf-8?B?OWcvUXkwOUlNT3lPQlI1R3lEbHM5K0dDYUxQRDRKb0VoWTgydmdmK1liQWEy?=
 =?utf-8?B?ZXMySjB4V04vRnBkNkpUaHdLU0RhdlhYc0FFVGlmajF6QlJYNjN3QU1IOEVj?=
 =?utf-8?B?bStRVEZ1YVlxUXFob2RDV05QOGlnVlMzRlU4cWVrbjZDdVIxWkkvd0lWcjJz?=
 =?utf-8?B?V1Rzbmt6MHF1SWtxMmZ0bGg3WVhrK0RHRXAxK0FMTXY3MU15Vm1sTUhQeEJT?=
 =?utf-8?B?RG50YU01cWZxODh3NllscFpBbU9lSTFQZkl4dzExNzdNWmlXaFVMTFd0M0Rl?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F548AF18DC05DF4E8C51F9CBA70E4437@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kk+87mjpc6kJZd4hd2vwlVAQsvHjo9/S8WReiNJmPWmOOhJPwlZit4FY3SkrndOVqtgz43gtglvMpLYtHfMY3bvcYC76NRs7ApCeyweqB3rp3rcfUoXSE9/ninLpok4z0aFuIpEugpnQRMcR3kT6IMoWP0V4AfafxoqkxSInYhjCBoBupF89/ZwOJn4EWmMa67niAaWzQ6oWASxT9HI6SOzUvmibr9J4DyfKcN6Wy88VOwj3SBvH4yZVpZhz8csYY8TM9txA/Sc+ctIUVZxeH6FfkeWpBB+ha/UkxF1Q3tFWZTCkKj9LZNXcIVw4smzY+cvyrgo2++82oS2QQbYmIhzec9w1jIv0xktVKCeXKvm/FiANnd7vdWO0jTqnaS9LgbPxLUyCqnB/7p6qaXv4HocqXIbMJBvi+5w6cOFImVgVJCHFF2jlfeGukDwoUa5mzFYWv8F6fChVIYaOpTMT+gZI6LXQt+E6DIjUjHpf1IQk2UFTjlO2HpQ2zBUiVb6EFW97e/xzYIyDIZJMQkve6V3T+uZ0qpwGA1FBest33U0LkWVnpAvYfSD/qiusDxkvqILj3T8WX8ztgiHI7zhEGT8DiTTWOVByzbVcgmrPyAcPaXWoBX+Z6BKy6AoIabjK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7caaa238-ff46-4ae9-2658-08dd03cb69ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 10:10:34.7366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DkJnkVmbzb8GM9hcVhDeUe5Zq596zY3npf1z/DsLp0j4FMNtyrU5o/NJlLma1bhwbRn240v+qTukBCDM3p4bFRoxDXc17KJKCKNd2p7NuxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8474

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K


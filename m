Return-Path: <linux-btrfs+bounces-9636-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C3E9C8AAD
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 13:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D731F2469F
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 12:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98AC1FA851;
	Thu, 14 Nov 2024 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="azVh2FaG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mEU+yvuk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C81F8F1A
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731588487; cv=fail; b=JjVJivlHsWGNM/4zqm/0N+w3Uu6AhDGwzCyC2oZ9rIOFkNj6HBQ65bimjW+W30ngcqfyrWaV8mHWEsgvxdlQi8mNO1pbAWyVHAio+ZIouFXHDj983Exv5cHFhIppTXbWtWSZ0i5hwLnfcA3rWR5ZAdDEGEhry1wLPs8blaGqY3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731588487; c=relaxed/simple;
	bh=DVwWsSiLptHka4xm+B2diVIXP8PPYDV0XlmXo2X3Ih4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qW0xeZzMcX2ywSepHwJ7sJyXjlCbB8Ei0E6kvZvJSioNaiBkhmZni0aWImgUkMNmmm9A04WasNWqFm75UoAWPXzUqdyZFTama8Mk4v8BfbBPRhDdP+q6HUrbAUBrMtTMMVcyx2ig0E58U22HXpr+xNxqewliFBaHufbgxgkzq/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=azVh2FaG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mEU+yvuk; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731588485; x=1763124485;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=DVwWsSiLptHka4xm+B2diVIXP8PPYDV0XlmXo2X3Ih4=;
  b=azVh2FaGRH1/mmSK4vdR3VH5by/qOz4+MzV6iITZ5hgySnesLNFZPcVE
   5+VLWDzYRlSj4JM0K3Km6BLQzixRJkEikFHVXUxPb4WQFwXANa1AF9rrE
   Ds0nWfFJb5hBfp7cL78JuLyk6eSwcv42maFj7+w34hlzudakDYJtwkS+p
   E/xtv/gQifVhb2Lf7Qtuu/FRonWo77TInobqtbxW0NB9EqtQwQC7wQYSW
   js8clx+PhKS09l9irbqLRR5dUtidFrcP8+G2f6pO2yAfW2a1wvlunQbWs
   wnR0hNpnxUqdcG/2/VArXMLtVIXw+cU+oHw5XMK1sRW9lBlXCaDizKIlO
   w==;
X-CSE-ConnectionGUID: vGQE+g+gTT6WF2kaxljPBw==
X-CSE-MsgGUID: RXfr6QqhSdqnA1vUVOvM8A==
X-IronPort-AV: E=Sophos;i="6.12,154,1728921600"; 
   d="scan'208";a="31415789"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2024 20:47:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pX2pL35SrkTIK1G5A2721vHQa5KbbHQ0KR4NpxIM3OLvP4GQ5717sFCFOC3uOmfRwsClheg13hGsQIwz8rUcHwGu8+NMXdPStJoX/KYwsMz5Kkmv1pB0sTiHqzg9yw4X6EjDp6l2I+TVaVrzoCLdui+SSl8qLdLja8byxPOTXXYER7iYLe6/ttN0QsazhN48IQKiuTqJLNXurME68XLD6r9WUn2mc/ZKrPcOOvIRZwsINkrmSq82Vse5q8QUyv2XIGSTygC6IP/XX6uL73L3s4IDadj97OEaugsJkVJ7fBWLIpiOKCHNFC+0mavi0/SfKbFKZPB8swrOqGIICtzUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVwWsSiLptHka4xm+B2diVIXP8PPYDV0XlmXo2X3Ih4=;
 b=GWt8g/z9Jc4/VIa6IYyWIMpbO/h4xX5Uhnak5/JvjTDkxmnpGt7RxD4NuSbBWbtrH1kS7dlUCOx5hJ3pbUnPLq+xXklMC9tskPvIEQsRensmetEte/i/iTiy//hCLQF+1N5RTltEWkk16Yf+Mlp479CvuD0fl8n2hjNj9LlOHqXR4YCxaotH5Oht42sU2yYDRYvMtqWuON+3hClHJfHkivoJaGiv/x4inRsUhWme9P/MQVdyV/RHxAa0oIkYcc5hk/R1YIWt4hxN1BV3fnEp1TLdspQ4Jqw25DlZIco/Jlr4UUB3+R2H3hcXFWzUhQjm9ZfPi0KH7n0ny3tx+TGh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVwWsSiLptHka4xm+B2diVIXP8PPYDV0XlmXo2X3Ih4=;
 b=mEU+yvuktcJ4E3n3Pqsh8Uvc+PRVf47CRNHsAK4L679yi8wda5D/u3sq/nxeKjb1COtEdXyHhxhdeGGymZ9Mo0E9cUPFKkUOqKIpvQHXS2W2rLZAb1Gg6GCO+ZPcqWrgNH8y/3r6FN2jbmIDyFeCHo5t662oCyuwzMIH/YTVafY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6990.namprd04.prod.outlook.com (2603:10b6:208:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 12:47:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 12:47:57 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix deadlock between transaction commits and
 extent locks
Thread-Topic: [PATCH] btrfs: fix deadlock between transaction commits and
 extent locks
Thread-Index: AQHbNpIIxTbjvW0o1kC4SrMqIfjW9bK2ubYA
Date: Thu, 14 Nov 2024 12:47:57 +0000
Message-ID: <81295f44-d0c7-464f-a6d6-d23b757096d2@wdc.com>
References:
 <47f1eba1edf0ae59484c3ff1e8e3c4a4269a7444.1731587182.git.fdmanana@suse.com>
In-Reply-To:
 <47f1eba1edf0ae59484c3ff1e8e3c4a4269a7444.1731587182.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6990:EE_
x-ms-office365-filtering-correlation-id: ea906876-2666-4009-ad40-08dd04aa9088
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VEdBZDI3c01aUTExT1pibTg0U0dJYTRTeUZZV3dDL0V6OGpYWVhzYnl1YzQy?=
 =?utf-8?B?bzJjUGF6cVkzcGk2N2xBZ1gxOVk1bmh5STkyaFh2bFVEQTdBQUZxeVpNajk1?=
 =?utf-8?B?Slo0VWhQaWY2QklPOG5aVW5OUkhrV2lPQVlmaDFaUlJFNVpDY2hwbzgvMjYx?=
 =?utf-8?B?aDRvcWdpZ0NYUnQwMDJ1VnVyM29lSGN2bTdVNW1XWXlLakQzdTducUozVGxa?=
 =?utf-8?B?SHhiZkNJOHZRY1Q1Zk1qMWRVbnpMZEhqbEwwa0R5Umo2M1VIZWR5RjFTMXpi?=
 =?utf-8?B?Tlo5MjFzbW82Z25KTFlIbVF4U243QU8vc3M3aWlybU5PNm1vNXlaQ21raWFl?=
 =?utf-8?B?Q29hdTJ0UkNDV3NoK1NsQWdxRENNRU1iZXFoYU00RmpzblJ0c00xdVBObXFE?=
 =?utf-8?B?bng2VFFNR1E3MUNsMFVKM3FnWGNQcDJrR0t3THVGN2tBalF2NjFjT3BaUFhz?=
 =?utf-8?B?Ymd1K2NPRzVVTlRuUzNNNkcrYkFZb2VuNkpYYTlWQ1hUTTRFRW55SkR3NDE0?=
 =?utf-8?B?TGFuYWpoV05UcEpCc3JVQ1hIeHQvaFlBckw0QXNVNFUwK1pscExzbXRYdi8r?=
 =?utf-8?B?aTNab3RWWlRFVDNEUzk3M1dtOGs4c0kxTnNaT3poT0xtWVBINmFHUytKMzlD?=
 =?utf-8?B?U0hZUFRyV1lhUzZSZFkrRkpzaGRtVURHbW4rNHpBUG9mMWxkTzBsaHMrNzZW?=
 =?utf-8?B?dlJaSWJKS3BWU3BPWWNOWXBiZ21tWjU3ZWg3a1V6VUpwa0VBNGx3Q1JoL0ZQ?=
 =?utf-8?B?cVFUN0l6L0ZsUEVLclUzUmROYWlUd2xNTXVsaHc5ejNlejJJY0J5MTgrdnZU?=
 =?utf-8?B?eTgySFprdGk2aFNMSHkvNFdsclJ5bmluQVpQYWhaMXpDa2loM0ZwUnNTNWhC?=
 =?utf-8?B?b05EbUN0eWpEaVRPeXFxR2JNcjRTRHp0WVh3ajZVTEpZQjlYT2lSQXdKRXdK?=
 =?utf-8?B?YWMxampmSVY1SWlGWDBuVDdaRkltWitWK3FOVUhERW5vVnRFakh0MFJGSXI4?=
 =?utf-8?B?S3FZQXBpMXZab1ppdHlkVmxXNmtHcDhCR1NKdWhFVUVjbTJtTEVlOWkxc0Zi?=
 =?utf-8?B?QVBiZXFQc2hWVC8vZTRaMnBXWjVOTXkxWjgwVnJ0V01jbFdXendObjMyWEc3?=
 =?utf-8?B?YTB5WDlQaS85YUxQYUpadWpzNUcwOExFNjJ1MGh1Z09YbU5DY1B5am5EMmo4?=
 =?utf-8?B?UTVkN2ZZVzBHVUp2OWZDWnhqbTZqVnVCcFRQT1dIa3hsNnhaTXFUYmJvTGJO?=
 =?utf-8?B?Z3EyT2orWW5ncGQyUWZqOHpxTmtSSzYrZTh2WWFjMkJGZjY0eUNSMi8vSXpH?=
 =?utf-8?B?NUN0REQ4VUloQU9PbFNBWDJpeENBK2c1dy9PcytWRXJCWEtPYkx2cUNZUk9U?=
 =?utf-8?B?bE5OUFQzck93OWJHWFhubzBZWUMzN2Jjd1Uzemh4bXd3akhPTkpxckJvT1Vt?=
 =?utf-8?B?ZkEwQnlPRUZJRFh0bXdURVdnai9DNUs5RGd5WDg0WmE4UC9rb21PTjdpb0d6?=
 =?utf-8?B?MGlLdm5CQXFYRHdIUW82cjR5WnRBZHNta1grRi9ZNjBRS3V1R2ZvcmN5U1Bl?=
 =?utf-8?B?bFo3SGVJY1RhZ3R6bkpEK3R6OWdjbkRuZUs4Q3RpYjdVMXpnTU1LRk9sY1o5?=
 =?utf-8?B?eEZvSzZrc0ZqbE5tZWcrR3ZubEY4Wkt1QnZ1VXpOMzFFbkRrT3FGcDVhTC9m?=
 =?utf-8?B?QzlPcHhFSDlFQlFwRGJqWTJDM08xQXZITG9OR0hCOVpnWUI0TUlLNVNTM0xY?=
 =?utf-8?B?T05aamVJK0xRYTRmMSs0ZE9vVUhuTE5abDU5WmJLaDc2eTk5YzRUc0prajJZ?=
 =?utf-8?Q?ChOEd5zZrOf0aYa/z+NNgbUOTQU+tnXHFB2uI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzZYa2VzM3lsc3lGaWRUczVKOHBSbUNkbzlRaGJ4eGMxS0NGK1pGTzIrSzkx?=
 =?utf-8?B?S0VmQmxuUE8rK0lvVGNFYkh0d1hEdmltVzVjNVNBTzZqNm1rN0pVS3A0WEto?=
 =?utf-8?B?cDNZeldiRG9KNkFaRTVKd0ZvcHpwdWlCLytqWndnRzFpb0QrNjdQN1lKQU1t?=
 =?utf-8?B?VDNsU0ZlaENPTnNuem81Mmo2bWR1a2swOGpoT212UWZYQnhkSEtLa1pXODU1?=
 =?utf-8?B?VjFvT3BScEM5K3lwNTZuZTA2MkZWbWtWTFBJdXpFcVp1QzlialRlSjhzanV2?=
 =?utf-8?B?aWxVdU1ZUXMwazlscXBha1RsT1FUNXFFUnM4SXhQODhsU28yM0ZkSUwzd0ow?=
 =?utf-8?B?bGJkdnYyWmJGeGxwOHBEbVZ4c0JkRVZqNDd4cXNhUTZXMld2Wi9BZGxIVFlE?=
 =?utf-8?B?bC9BVzVkR3pnQ1pKb1ROV3lBeXBWSHh1Q1ZubmIyMjNCS0JsYjdjZTFlMzRz?=
 =?utf-8?B?S2d0bmZpbkZGcDdiVnBiUWM1M1BPNVZlNlBRV3QzaWU4eU52STNBdlhaM2N4?=
 =?utf-8?B?Z01aM3FadUU2VVVEMll3Z0lIb0tQdFIyZUh2MmJVSzJQTng0VG8rTWJuUmxk?=
 =?utf-8?B?NHVuYU10ZlB2ajlmZXF0T240QkxYRytkdVlUK0d3ejdNaEI4dU50L0Q5TkRp?=
 =?utf-8?B?RHRET01ocVVsQlAzMk1IWjVTa2tNUjUzZ3g2Y2ZQbDJKZFhwakIwaGd4K2xR?=
 =?utf-8?B?dWtCKzBxU1hrMHNTTUV6d0NJMlVBcXBJNjNvMjNSdFVqTG5XNlRSSCtVQWRh?=
 =?utf-8?B?NEFkcXY2aG9pUUcrVmlieTR2VzZIaUxwUUUzbENETVJCaVRjTkUwWVlJSmp0?=
 =?utf-8?B?bjZFcU5PM1FiaUtlbjQxK1RrNUhtUVAvOU9MWHZYK3dSUlk4UFU2YXZwdUdH?=
 =?utf-8?B?SUxCVUZ6UURncWVMRXJ2cVN0OG1LYTh1ejVUcys1NjBjMzBlWnpydlB0cEIz?=
 =?utf-8?B?VnB5UzJqRlNTNVZGcndqZGZQWktlcGNib3gvQjluTE5FQ1Q5NE9OdFdzSjQx?=
 =?utf-8?B?V2tzcVFjV3VWbmJ1Z1g4Q0JVenNraXZ1WW9vSkJISW02T2RYQy9yaWEzem5T?=
 =?utf-8?B?TEp4Wk1zMUdhTXBsU3lNVHVaWmpxSFMyNTYxeXdrRTVyclVKdnMyaUFJNm5m?=
 =?utf-8?B?MUhWR1hXeGVhNHJ0TVZBODVxY0tZYkJwTXQ0a2xvTUVhQmFwRXZYTzRweGU1?=
 =?utf-8?B?cEdDOU50eVo2cUs2VnhTRWI1RWp4ZG16RkFjOTY1S05tS00zS1pMUWszazlE?=
 =?utf-8?B?WVdUcjc4N1puOHVZL3d5QlhGcDJtdVVLWXdJaWI0eG9yckFLNytpOUhXeGJX?=
 =?utf-8?B?d2FKdUU2T0dsa0N4c2pSa1ZIWUl6bVNkWHhGWTN5WXZLNFVsdVNMZjFucGZ4?=
 =?utf-8?B?cmZ3UTcxWjZIMXBFK0pEdXVodzZ1UldINVovZnFDK201S2pud2dhQWllbkNB?=
 =?utf-8?B?S05CTE14MDlnbGFreUJCa1Z3YTJ2SVkwakpUWlVyYlR2SGJhenhjcGpsU0c4?=
 =?utf-8?B?NGFsUHBqa0Nyc2pqT0VXaWYvOTFRamh6azVWQjQxRzNhRVJkQkQrVVpVQjZn?=
 =?utf-8?B?TzZ6VnZsN2R1am5UT0RJdExyUlZpTjFJY1V5YS8xcnVCU3h3bUpFQzNFMmU5?=
 =?utf-8?B?ZFAwWkQ3a2JsYzRnTElLc1JVREpPSmdaNFBCdFpMaS80UHJxL3N0ZTQ1NXRt?=
 =?utf-8?B?dXovbTNweDZGM0FlUXM1dW8xbkR4dDh5MVkvcmlFakVua1VUc3JUTnhFNkUx?=
 =?utf-8?B?M1NxbFJibnp0UFAvN01SYkJMb0RGdXhGQ240eDJ1V3hHeVpnUkMyTGlZSWFU?=
 =?utf-8?B?SEZyb2Y3TGFZcE9mOHFDUisvZzdmSUlUUHV6NkRGdTdYV2F6Z0pzbTVoaXZK?=
 =?utf-8?B?ZktqVllRZkc4WEYwNTExWXpLKzhQVDJ2VS84NXcwNVFWWVAyVGFBT3lpSmlu?=
 =?utf-8?B?Y3RzWUdVOGczWDBjMDNZTjdEeXV2VWt5RitXZzkzTitNS1kwTjlROU5CTHdR?=
 =?utf-8?B?Y2MyY1ViakpjNHBDWFFNdFA4U3FRZkNtUDZWYll2YUVQeG05VWZSTTE4S0h0?=
 =?utf-8?B?Y0FidEpydHNTcUdDVi9QSTcvN0l6M2RRb015Zlp4bG5mV2QrRUVkL3lEM0Fy?=
 =?utf-8?B?dzVzcGZFS1NZZG5HTzdzOTN0QnpFcFpvcEV3WXEyTjY2emtwM0xHQUl2dmNt?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78A0D8BFC0CA1A4FB498254AA59CF841@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kZhc8VX8YoUSMe6lBytpc/Oh5aWBZcgd+z9JLTt3xNo+SqDyoifemJLk56vnjfCXUutKqSVEZ+JwNc5LkOXc3UJ1pDJGhFt1b0XA3sgysHULUztAh1hllIEhaNfZlnle27/QO8AAV0lOW/3Br2LQhHjQu3/HnW0JaP5VGIKKbTGNkk9E0ApRfXfdnoo58/4qZX8YaQGPVtt+OBLgFC3FQssYh+TPnrSMeJ4aMzoq4hTa3zr/5M8UkxjWcQhhULmvhdtmjScsMD6Q5n4ZghNHCOOWtsLM54QrscjypyWEJtIVk5RI7t4FPeMp3tmVN9x25lnT6jC/jCXUT3tcvfqSw2WbFTW4SnBIvdEWvr3D89X2BiPmBZokPK8Zl6z+/7uUUswfPQQ9MVl+KMfE9qfFrDMPnjFSwgujsEbInMP3RRLotcvy2G2LrOHDAPh6qDY8Qz6Y6kfyxkcjQ+hyrqP3ljigZfJSjJAB2JkWNlyEp3vOBcCYUpWBrZ4gX1Jj1EMD635PTqyeupdbJmUoee0mJmlM1DkPzhzY0ta8jTUiCDL8LBjCRTx3mM8j2KfR7yXFb+SxJYRaBfUs6shqO89lWlEgnb+tf6uXOscUi7I1Zz7rnRsUYUAOkxJk/zzMNAxh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea906876-2666-4009-ad40-08dd04aa9088
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 12:47:57.1895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gkFYDqVQhNoTkfJFs5YtN9A8BqbDAnjCDwvsg7JFxs3pbAEW+n4YuGOuRyF6m5OX37Fma7QwuRV1rykwZ8vMz+tkVReChjCkguH+brmSj7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6990

T2ggc2gqdCwgbXkgYmFkLg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5u
ZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=


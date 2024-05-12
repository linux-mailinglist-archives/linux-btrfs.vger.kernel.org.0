Return-Path: <linux-btrfs+bounces-4921-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2658C37B2
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2024 19:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F75F281407
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2024 17:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FED4AEE0;
	Sun, 12 May 2024 17:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q1QGlxzv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MxNkrCDO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF8D17BA8
	for <linux-btrfs@vger.kernel.org>; Sun, 12 May 2024 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715533820; cv=fail; b=Ue7d7oYYJ2i4jBPpRovquveVh36kPDKaBG6uYig/y7jUgRPrFGwN5DuUkMYyeB0iTCSTcOJGtpJ4emuYDJkQIcvlhK89nMXrLBTYxbBMCY7GFJF3z6Gfnip4jCW0Ew/IUTbDqmKj9/JryZ/UbrnUlyyJOlK2SlBDQ1R5sOrd9TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715533820; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SjDPdMqIfabFx7aTJmHKborlZ/jCCkUUdgPQX5NARTTv73cvb01mWipSq813qv9yu7Bi3g4hLcDli++lrGC/qTqVrzcTkREMq4HqODSHwJBlHLUHTXVK+KUNfkaWD+rCHtjQbTISiGDh28nNoTs7oqpoSm+XzHm1hD9DoY5gGrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Q1QGlxzv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=MxNkrCDO; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715533818; x=1747069818;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=Q1QGlxzvpJhbvJx0JuIt2jl49vdvFaaPNU69UCmBQYpa+36gdcW1Qs1f
   nQW7ucRqNWjH4bQVjToRLCWq9Ef9R9bLnghaXJRj1Jy8TqOOSPESTtH9h
   nDEWvyfg2A9w9H3IhdWHIX9urwf6h2ZKVYVrE72qE7Ie1+cLdFbhencAK
   I3tfxk41P1O7XKJwNVtw2JpuosiF6C2aeOIFRB3yylcnLNeMJ+KqiIeLp
   9F9V705NFx0wTKFnreWwCbzjtdPcQGogmypVF3mDGIHMmBiFrzmNMGYWn
   vzV4GzVYKzdpApaA/1y5NxWXH3N+npGROqNZaC00dq+DzuvauNlvAvPXF
   Q==;
X-CSE-ConnectionGUID: WMI0oBK8RWyM+gNTjM4yQQ==
X-CSE-MsgGUID: /nkJ2kfFRfeS4SvpGkmfZQ==
X-IronPort-AV: E=Sophos;i="6.08,156,1712592000"; 
   d="scan'208";a="16386957"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2024 01:10:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/V7m6chp+9+3FGioM+3AQF2qccVOqlXj0RygqanBvgY3/uwm9fwF665CCQDBB9ULZrJZOd3EoIP4j50m6ppcM9aIHb+9EHIzHJfcGhRIJYSEP0TmMkfYFZek4KXQqKE7oPnvuSdx2loUtrY9Q1K4rWi2g3yQXK/834kjOr7bqHGbDCAoruz10TcRDiFdrp7Ltpi/WY38hgboacNHr8pSUdpgyFzPd9ex/FV2mjnirWbEju+QvQtBqHmmYPa/97gAwt13PVAAHWgFrkPmWoc6eXGWJjq/46FoYj6W9zPHdNBYhhkpHQMRsiVvKjJuiWhd4pm8L+rTYad9z6zBdFIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=SxWoxKC/pvFv1jroS2+2K8oszskLztCdooQ7oY8gHedQHCChU9fjr1HqkzNSd89TXO7uzh+n1vS5MhKZDQWzlAyeNZpSQh/pd17PD83zeCGzR/G9jMKel2y+JISBxTS6Koyxxu96O/dmq3DyHDwba7m26u8xHryUpQx9p4b8zZq2l349EqyT8thsU+xL/9IOxSBqXTU6hya9CFey4tiddA6aTVvv7DbykTLUh8Znyfku5WKkI3x7dIpsJLfaaw18bOX2QnIHHccDk1TZwBKqsip3tOfw90YaCLkUpItH5B2t0vRA2xqj3+PP1HJFHa8FqcRyN6FdjDP9eTVgHWI1GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=MxNkrCDOppFIxjlDWn5NmRmNe4IKcRYZa+w1UGdqY0neK4MREyJ2xW8Z2jedJalTu62mVdMmkO94y5Bm2OUbARAdZdwt+2DnxIdOttgorjyhgq7T2sEI1HvOgOTgsKn9xxyHdme1B72vgvQysPmSg+pCO5dCkc0TaOiySipmVuQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ2PR04MB8897.namprd04.prod.outlook.com (2603:10b6:a03:547::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 17:10:07 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 17:10:07 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [PATCH v4 3/6] btrfs: subpage: introduce helpers to handle
 subpage delalloc locking
Thread-Topic: [PATCH v4 3/6] btrfs: subpage: introduce helpers to handle
 subpage delalloc locking
Thread-Index: AQHaozhfM1/9WrkpYkSvhsaBT/prrbGT2AcA
Date: Sun, 12 May 2024 17:10:06 +0000
Message-ID: <a6410733-5c72-4626-80fa-2199a2220b58@wdc.com>
References: <cover.1715386434.git.wqu@suse.com>
 <3e6312684916bdd2b3d9d4ad53a00cd4c9219cad.1715386434.git.wqu@suse.com>
In-Reply-To:
 <3e6312684916bdd2b3d9d4ad53a00cd4c9219cad.1715386434.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ2PR04MB8897:EE_
x-ms-office365-filtering-correlation-id: d0e1496e-5442-4b3c-0200-08dc72a65f62
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?TFJOL0c2TXlwWnJablRDUXB3ZDNGdjhsWkEybk5neWExWjc0eGUwR2VGLzdv?=
 =?utf-8?B?WFRTUU1QT1ZMNGUvTW9zTml4ZXhsY0cwNlJ2L1lSQlYrUDA4L1JtNWwrQlBu?=
 =?utf-8?B?SC9HK1ZVaUZYKzhXNnNXdGZEUER6MGtwcXZpajlnRmswMS9UYXFlNm9mKzNR?=
 =?utf-8?B?VVYySzRtRzZKeVE4ekhTU2tubmFzK1VvM1BZVWxCU09JdkhGZE9UREt2SW5W?=
 =?utf-8?B?Mis4QXdXYlZxK0dETk9UQkp1cERhYTVaSlY0NHRJR25ENnNtVFVPOU8vNkpk?=
 =?utf-8?B?SEFzaG5STXhaRTNRc1VNS211MWtqbzgvKzdHSEh2STFIVU0zN2ExdmcrMzNt?=
 =?utf-8?B?TVhnZnhFdjVicW10TmJuZWc5ZmRoZW9sRk1UL2RJSXN4K3dVNWZFanM3czRH?=
 =?utf-8?B?bVg2NjhmV1lTekV4eWh0aG56OGFHd1RmV1RWZ3RSVGxSZGNaL3BBV3JOQVRQ?=
 =?utf-8?B?Tlp4bE9lUmpBQ2t4T09yajlYWmIvdlpDRVFlVzhCajhTZldvWTZmVDBBQ1JV?=
 =?utf-8?B?STlaYXRRTktpYW1KbVVJYUVOTncrVzFVM0xkZWJTbHRuVlRGRWxPWHZmNnNX?=
 =?utf-8?B?dVYxU0NmSjZkSnNZUlROYlBMa1Y3QXVKVkxYZE1JdC9zWUxVVFlsWGd6SVR0?=
 =?utf-8?B?MWhOUkJBUDM5dlBDS0o1bXRxZVpYb1V3bnl0NENJekVkRlpqbEJBZ3Iwc245?=
 =?utf-8?B?TFhKdG45aklKUU5IZHlJMWt1ZEJZU3U3Um1TcTZ4TEh1MDlnYzNCZWcxc1Yx?=
 =?utf-8?B?R0c4QzRqVFdiMHVBNis0OVRPTHo0Uk5EZTlVSVEvdURCOC9TSUg0ZHVZYXo3?=
 =?utf-8?B?YTFiS2lLM3orMWU4MUlvcUZCWlBTYWE2SmZGUVZQR3E0SjlRVFg5ZnVMVFhj?=
 =?utf-8?B?RFlnRWhsUW5wMEtER0JkQnJQRG02RktIN2RDbzl3cmpXTWEvNm1BdE83djE0?=
 =?utf-8?B?V2QweFMzKzhCc2RGTzE5RkZXMTRKY2dHSW1Kam9QS0hJclFhYnZscVRLOHRS?=
 =?utf-8?B?K1QzdEpyN2pBcUtwZ3FnQm1saDA5ZkhObGtnWjBTMVZaeXdLUjlWajZRTHZX?=
 =?utf-8?B?U2FnS1BuQ1NIWDM3SjlyVkRzeHRReW9YYXJWQTVRdFYwNFliYVhIaTRPeHF4?=
 =?utf-8?B?SkliZmxTZUtQMVgrZTdHeEM1d2cxVCtWd3A2Q2JZcGxIV2ZZQ0tUcU43T2g2?=
 =?utf-8?B?VE01NlZMVkMzVUhjSW13MkI1bERhNjhlSkRLdnlaVmc4THprSHpwWWw4ejhi?=
 =?utf-8?B?TE9IZDlBN1l0UWVQZjc4VC9FMDhQTSt2ZGxFSVJGNyt6dUlGaFhBNGdxQkh0?=
 =?utf-8?B?Yzk1NllUb0V4RE1wODJpQXpQbnhMcWFSd2VMK1JOcVdEMmlnY3V5UUlaVUNa?=
 =?utf-8?B?Zjl5WkFZSjVQMU5rdmhHQW9mV1RxVi9aL3duOGNTcVBkd25rbzlKdlVSTU1U?=
 =?utf-8?B?Mkd6YVJpM3B0Y3R0aFJEa21qYzA3LzdFQ0F2RXFIQ0ZZd3ZkbkZwSWszMG5H?=
 =?utf-8?B?cm1UVUlKeVhRbEk5Skx3MWlEOTJCVVEwN3k1ZG1pRUlyZmx6em1DVWY0VU5O?=
 =?utf-8?B?U2E4M0JWNU1TTngwT0N0YXZja3M2NVJCblhTSkVHRzE3SGtiaGl4UmZmZERn?=
 =?utf-8?B?ZnJxcFFlTjZIOUtHd05VS2R3cEFXc3piVVZ3Y1ozR2FZRGgwSS9wS28wc1Jw?=
 =?utf-8?B?YXh3Qnd0Z1p2bnU1WEI4bGhWWTM1Zk9zWEZROUhJNDBGVDZydTRuU1k1K0ZT?=
 =?utf-8?B?Q2E1VGc3RlRZNmtjNzZQSHpod1hidFJGVThrZ1ZGYmw5MXErOWMvcStWNnRH?=
 =?utf-8?B?RTRZekR6L2JXSUZ0L0ptUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bTRUKzhQdmdnY0FJMHhhUnVlK21TZnpaUlR3bkd1ZjNYVXd2d1lsVVRrUW5B?=
 =?utf-8?B?OFN2aEo2LzRaaGx1TzNFTm1ZOXhQZVI3RzdwYzNkWU5OVndINTdHVzZQSTBP?=
 =?utf-8?B?bHFrU24rYWcrbG5kdjQ5UmtpWnBWN0djSkI1Wkx2NWZHc2ZFTnp0RGNiTVpV?=
 =?utf-8?B?dnlkbGJYQUN0N2psMnNjL3pxeHkzN096RlkxRno5R216cUI4cnpNTFp6WmFB?=
 =?utf-8?B?SldJSHZ4R1RXUFJ6ZVUrWjhwdGpwdHJyTjhqWVRNM1RSdnQvYms2VU9MRGlC?=
 =?utf-8?B?cEYvT0VJZkZ0am5jWEFFSkNhZSt6RXhma3BFVmo4UmUzcGJaZElKaWVTbThR?=
 =?utf-8?B?QnR0bzVrOGFKcStpOXh1UW1FYmtuNHJmQUhkT1FVdkQ4YytPRDBEY3BKRWhS?=
 =?utf-8?B?RVU3blgwN29WaUdpam5WK2thS1dTd1hxdTRxdUJEZWZaM29mOGNPdm05VWJj?=
 =?utf-8?B?bUlOUldWY1daV0FlS3h5ZE5JZVJCMXpvN2lJNWFSV1NseU1mUVRtbGFSZ1FW?=
 =?utf-8?B?eTJBMjZLSkRQQ0JKYitiellTTUFXcUpqaVVrRHNKYSszSFdidjFoUFJibzkv?=
 =?utf-8?B?dXNhb2x3OU1HM2RpMSszdFlmQlQveStzaER3RXAwUUlOSHdWanIxdUVGUXE3?=
 =?utf-8?B?a0NDMzlDcTZneU1od3hBTzJVOGo1cXoyQkcwaEY4MThodDlmOGhTVmEzZy8y?=
 =?utf-8?B?dlVaSDlZY1hndS9aL1BMaWorQUo2Y1Z2TVRTUGR1VjFYcEdKT2JzS2FSSXJK?=
 =?utf-8?B?cUh5UmJ1cmZOWDcwS04yMEVkTGVPYzBKbEgyekJrRFRYalpFRzBvQjRsNnVT?=
 =?utf-8?B?QjIvblF0azdkQnRxdmF6Y1ZzR3IxckxrY3RYRVZJY05XbWlqKzJtTUJzRmRH?=
 =?utf-8?B?b2Q3M3VpSWdydWUwMWwvQmZWdk1pSXR5YlBNamtSbEJTeXJ1ajAxMXlyWm16?=
 =?utf-8?B?blZBVG1vREpGNTNIV3hKWmZJTnBXT2UrOGdTN1RnZlBnNlBGcHk0YnE5ZFpX?=
 =?utf-8?B?NlJ1M0VHN3lrRHZzWFdvWm9tUjdsZ3J0MGt5dC82RFJTdkFIdGpadmFHQW04?=
 =?utf-8?B?Z3IvYnF3MlZ0YXJZRHNJWXFDTVI3Rnd0VjduUElwcE1UNkJpckNObmUxN2Zh?=
 =?utf-8?B?bGQxNUg2RGtIR25NOEhYNFVoL1VvQzJSdjczV3kwVkcvZlY4dVpXdXBrR0dl?=
 =?utf-8?B?c0VMd2xFYjlDcjloTFRQZng3YTFzREtMd1QrcXpBUWtNUUlodmNnN3ZPMkpR?=
 =?utf-8?B?ZHhRckRIbzFHaElhUjQyVTg5UHNsNDdiOWlGZHdtQkpkTkJ4OWFVcG0rNVNV?=
 =?utf-8?B?RjR0d1R3UUd4Yk1FWHpQZDF0azl5NkZkTXFEMDdsK1NtdHJjalZUakJGWUlK?=
 =?utf-8?B?SlRGcDU4Y0tVYUpSeTBmanBJVDgzdDFLdndmaVlkd2lSMHZRMENZWVQwdThh?=
 =?utf-8?B?MFZONjdPR0VlUEJwUHZxZkUvUjBLWEsvZVFBcVZaa2pNZDlIN1ZxKzBNdGcr?=
 =?utf-8?B?TkJQaFNOSDJEMjlhME5kaVViY0poQUI0Qi8vWXNjMzFXRVZmQkdBcXBaMFZX?=
 =?utf-8?B?Wm94RjlDQWRlRzBISXkzZUtkUGFaRHU4a3FvanNlZGF5MWhKZ3ZYbGN4N04v?=
 =?utf-8?B?T2grSlBvbjdxNTNtOVc4ZVlOYktTUlZ3T2h5c3ZrTEtXYm1wNlJyRzFCRUV3?=
 =?utf-8?B?bytmcDFsSnJra09admQySm81OENNQWdjQnVyMEcxTWYwWStWNXVJVTZkczVn?=
 =?utf-8?B?dnRsdEFHU25hZS9xZjdSNkVETzBydC9vUG55SFR0N3VTRkNBZWN6MzMxZTJD?=
 =?utf-8?B?Sk1SR0N3NE1pVmZrcGZCUm9tOG9aNVNmSTRWM0ozRGgrRi9PVU9vNGZIcTVr?=
 =?utf-8?B?YmllVHpJaWdQOEw0ZlNPaHA2MUlrOFVUK1h4SVVtcW9pb3VWdTRrVFJ4S1Uy?=
 =?utf-8?B?aVdMNGNIOGxxWWIxdnhrZFNLT01sNzZQVTJoMkRnT2t6MGxLWmkzVnhFMGsz?=
 =?utf-8?B?RDZzK0lPbEZHa1hBZXliWHdFcy9zZitMcDZTWlpwR3pkM3RJclg2ODFCQjZo?=
 =?utf-8?B?TDNLL0FPamFpakRLN01kcjg2L08wL1FISTROLzFlWUd1TzMwNGdYTnF6emQ5?=
 =?utf-8?B?U0dmcU1Ja091S1ZTNlhSZFhVaXByeXhnR3JGVFdYRW5zNTNWL3h6WGFJcWVt?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F981DE7EC04E7740886AFFA6F1A023FD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gurq+whGZrJ5pHIrmXQLYq/j9bgcRKyx5ug+ZTbnEN/Kx6Ktso3FDOP8pMwMC4JQqffzx0u3jXDT7bHZLJ/sjFrhwMOHwK78QjsXsKH0BgiPpvoVKw/ktjzJWiEPKY9NJs/LR0C9pBo53J4KoCcDtOrQc/xdqc0Yy+o/lGIMgk/rhhTXpJRq0gUGlT6rGKQmyiZTuUhdMqN4jRM/RhQokYnb8tfCAG+5HGJuzNietgAfx4R2iKxeqGpDzez+lcMDeZK3+NXu+k9k8kanqVOv9sQolRLykJ7Rs+AB29HGiQR+6+tI7P739UwOcJUlhQn3GIl7ZynGy/nHIhK7FACBfYZS7gdg4bKc5LDBy/0FPmJb2UcUn25mnsH8jBTr+5aGLaHFy848V4nkPK8HGn5g0Wp2EqBczpREBbfyq4phOQt+ArsHEwsHqPhLDNj4gP9y5zuu4UIzuc+UjM1Lqn29JdPFD+vq+PQkt8GZwrlLW2rLXjsV/Dwjy1UuFPKm6aQkbNcvl7Ol9R/xYwzD+wA5AWQEfC9M6MRc0Ov9Yl4Bvr5qwqCDRkRfglb825IhZdFpyvvmkwfUnio7tYGsYT5vw9kgETWSp6PTODdEAQg1dNX0uBA/3fYd0INz3dmHU1eN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e1496e-5442-4b3c-0200-08dc72a65f62
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2024 17:10:06.9787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WAU74duh3CC4rxten7lebuU9gWaqU5+EKYyteOeJMV/G5MiG1Dep8rXiJ9tfNEA/sbUgdNpJDkn/OCSeZ1CWoJlsptQtfPbp5eVnSG+AYsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8897

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K


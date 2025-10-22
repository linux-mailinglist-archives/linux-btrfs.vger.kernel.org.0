Return-Path: <linux-btrfs+bounces-18145-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45844BFA37F
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 08:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3631893455
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 06:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF5D2ED14C;
	Wed, 22 Oct 2025 06:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iTXEcba+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lTP1nwCA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FD3224225;
	Wed, 22 Oct 2025 06:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761114465; cv=fail; b=Mu8+7IFMCi/6hzs4d17PUuFNIkcXjZgZpTMha9zsRKRQDF5Ee9IPToMwyMZlCFVQuwtmV3yOtB7pTN0LQUowuTW1fdfjL2wN8sRcZKOdCbXtwFR6L8cZrvTygD29vbbCU5SXtA3fyiUKXoSPmpqYB2+6eH5ldvxCbrYk27wczA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761114465; c=relaxed/simple;
	bh=oR/VzZ1TXhcJ6mEXlo5WRSHXg/VMdAK/awvGwC7PWAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TGXkSJoaKmmHdFdPteY7AayHgcokQPW6h4pl+tZlGo7ekdeVVOec8SD8crSsBH8MLnOvamEG8wp9suz+OST+JkEyPZiLq2/CgdYr4Q83VWPhZNMp6cbbd29+1GkXDTuVB7HaQ95ksIrFVgWKc/NzGRylV5EuyPORHmUgCspy84M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iTXEcba+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lTP1nwCA; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761114463; x=1792650463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oR/VzZ1TXhcJ6mEXlo5WRSHXg/VMdAK/awvGwC7PWAE=;
  b=iTXEcba+BPBf+5AvmLnEidbsLCvNUKISn6g3T2+aZ5mZPSP0tUGkOS1h
   gfmAwvVZQxJMB+4nUPLtNFhYxbHaXSjjKcom8Odx8dmSr3YF51igrG+qH
   qw9KPGI4AoaD0pGgyBDlLlJwynUgr+PuqowRz4ncYuWNGij9K+qpRAyB/
   x/Y76cnS3fg74k7VwvqD8KTlcsoNrZLR4UX8vcXvz9eAQ58LPnS5uE4SG
   oHzy+noWdm+yMPPrdVvSuSbww5CehCRD0Q1f1cygZDu7r5kjIiPejipQG
   becXw7Cs4F7kOCjpvujn1pdim023swPPL24UGTWcmcbs9KT1sfhEYRjOn
   g==;
X-CSE-ConnectionGUID: VU8tUKbCQdmXynaAvmZH2A==
X-CSE-MsgGUID: py6J/tTRTsaJb2zuR9upEQ==
X-IronPort-AV: E=Sophos;i="6.19,246,1754928000"; 
   d="scan'208";a="134927668"
Received: from mail-centralusazon11010036.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.36])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2025 14:27:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=owKwcgC0+qXAhdW5r/oq8DFlRnefS0vNWQQl0nAon6hQlZxIy3/qY/lTu1e7uWLD3tH3+xKyoRYoaSq0jJACZ7YyUKbOOVg1Yl0juVLs44ihXepSJTg7eG1Ay5nLkgqITQmhnVPA8cO85g4u4NHzc4HO5bWPKvXo1/g++eLJaWorDE3OLrBDVz0P2IbaDH3JJN+S/SY1L5JbBd05pb5XL5nxEK5ye7r5/IeRMZWWuY7s4n+vky1uJsm2Qr5YIpsil/MtooNsvWSWus9m/WOJbHFgUVv37wNsHRe+3oB6xaf7AYVCC6uqy4auBmkpDaqnV0BQrDQLvFiYoDfeMVpSLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oR/VzZ1TXhcJ6mEXlo5WRSHXg/VMdAK/awvGwC7PWAE=;
 b=b5P2Tusfr2oGMt47fpPt79Yfht56YtBDAWN/0dTQdTxhWvZUBso0SJ5AFZ3MroH/zrSnXgoqTkSSq5v8XZq7gCe/UrfRbQkSUyHAsiITBP9ght84zkkoZZs6z8W7M+gDFpcToXpjXpAkssJVimiz9AjqgDlCDF1kyt6AEyZ7DKI0O2+lNL5pC/+749o7QM1SZCsyAs9TcTOutDQfyz2AfLAETfGjNxeVpj+p6iZ0cZMS7UBzKP8/2KKmTXbS+X6sgzf/TSYxe9m1hanhP6txWIGWwWsQ/Yt7VB12iwjetvqO14MUOOMfo0RKCKPpBNO0kKq7WR5xVcM65G+1qGGgDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oR/VzZ1TXhcJ6mEXlo5WRSHXg/VMdAK/awvGwC7PWAE=;
 b=lTP1nwCAamFRpw4bbv7HNX5+1rXoc/LRy6Z5CGRVlgv8wXSafHrY8N9I9soV4vLwgj0HBGHiyK2m1hDH2haV3/09VhxAcpznKjoKnZ6sL5/XnG3A21OA4yeoaItUUsctdvpvSSj0Kfme9iVzerga029ymXDxyT879YRO4NMsFcs=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by BL0PR04MB6482.namprd04.prod.outlook.com (2603:10b6:208:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 06:27:37 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 06:27:37 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>
CC: Zorro Lang <zlang@redhat.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Carlos Maiolino
	<cem@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino
	<cmaiolino@redhat.com>
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Thread-Topic: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Thread-Index:
 AQHcPrB98rc0Re5Mwk+pm/9ca/TvXrTGsiGAgAEQ1ACAADAhAIACowWAgAHH64CAAT8dAIAAH2aA
Date: Wed, 22 Oct 2025 06:27:37 +0000
Message-ID: <3c47abbf-1e0f-46d9-b8b9-5edc3d163a49@wdc.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-4-johannes.thumshirn@wdc.com>
 <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <0d05cde5-024b-4136-ad51-9a56361f4b51@wdc.com>
 <20251018140518.2xlpmmqajgaeg7xq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <8253d6b9-e98b-4a05-80c0-f255ec32ee38@wdc.com>
 <16e539fe-b9f0-4645-b135-3930df249eab@wdc.com> <20251022043514.GB2371@lst.de>
In-Reply-To: <20251022043514.GB2371@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|BL0PR04MB6482:EE_
x-ms-office365-filtering-correlation-id: 3be045a8-5c6b-4ed5-f0e9-08de1134183b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dEdWVEJqdTcxdUljbTVwaVpMeE5uWnI0OGxDaHdSYnpncFZHQXp4cG5Ydzc0?=
 =?utf-8?B?Znd4M0NOZy9wTDJBMWg1czczaFFMK2RxQWttMVBIVmNhd2FDVW5mMGVXVmZB?=
 =?utf-8?B?QmVMZFJRb1dsKzFtek53cjE0aUVpM3kxUFdKM09zNUR6YVdkdEhYMUkxamJE?=
 =?utf-8?B?c0xlWXN6ZnEvaElzUWRCdjI4TUNnK2UrdzN5dUpDUTdiRElnMmRsL3lDZE02?=
 =?utf-8?B?Wi9yblRQOHZYcVFwdVU1Z3p4aEJNRlE5NTA0Uk5HVEF4SjlMNUJ2TGFYaTFo?=
 =?utf-8?B?SDdIWG9SUmxrMFBHazBXbU9OVkZ5Qk5RTXNIMHRoVU5Cc0pPcWRnWVNKS3p4?=
 =?utf-8?B?TUVMUHpjcXRLNW50cnk2UXlXRGtDY25PSGtHYy9tZWUxc3BJSy8wd0ZEc2R0?=
 =?utf-8?B?MitXbnJNYnNxZ2s3aVRYKzdtSXoxbVlMUzRqQTZnVmNCNkM1U093U1hxVlRr?=
 =?utf-8?B?eitYWGp1cWxNUlo5WEdWWVY0K3pHK3BxdXpybDhCTWcvWUl0MUNKQXpaSm1i?=
 =?utf-8?B?Um9YdGZFZWc5YytRMEZXQUhFcTU0ZWJWZjVuSWs1OFlVZ1BINUd3OTJjYUk3?=
 =?utf-8?B?eGMxTnMvQUVPZko4MkZHNjErc2ZYTGowdEl4QklMM0FSamRUQllxdU5oWHhW?=
 =?utf-8?B?ZEhlZ004cy9ab0dYdW5zTlhkQUVpbjdLR2ZnTkdVa1RGQWJ0UlhDK0I2OXQ5?=
 =?utf-8?B?TTFCZWx4MEtmQUZORUpNdnRxbVFBYkxiNE9kVS9qOEVIdVpIakMxMzFRWm55?=
 =?utf-8?B?N2dFUzZINWQ3SmR3Um9mT2dVNExWd0d6eFNuWDU4MHJnVGpOTzNtYkZYYW4y?=
 =?utf-8?B?WjkyZWZFTjI4by9EdmFSbjRHUVZ2SlMrdWEvSkw1VFl3MUI0bG5wa2xudVFV?=
 =?utf-8?B?SzZ0WmVrRTlrdzhCeVZqM2VXdVo0WThQRkVnRHBtK2NYak5aTDIxbVFQUGtO?=
 =?utf-8?B?LzVlZ2dKWStaZW96WCtyT0ZuN3JNOWhoSm5wMFhhSTJucDZyYy9NR3pxdDRy?=
 =?utf-8?B?ZHVFYVFIQTJxdEdHSjI3Y2RWZ0ZHUTN3Mlo1V2x5R1FiUTdBd0p5cUptTGZv?=
 =?utf-8?B?aGxLMnpsSnlYTnk4VmZOeHJ6T2YzSjRtT1lrYnIxMEZhbDVwTkpGK0IwNkFy?=
 =?utf-8?B?SnNnWThoeDRKQ0xxcE5jeTVPdUd1azU2SnlBL2gwcXVPTnpvalhoNUZuVWZn?=
 =?utf-8?B?N08vZ2dZK2RLa1VKR2VMU29ZeHZlTFp6TXd6U2UvRWdwMFpHb0VGZnh3aVlJ?=
 =?utf-8?B?T1Z6N3pqMi9RN2FMQSsyUGNQWitHODloZVNPTHBmUE54TTFENm5ZN2k1YjhV?=
 =?utf-8?B?dWJXc3R4RnVGWDZRVThCR1NhWFZqa0pZd0FOZ3FHTDlIRDkxdURkTEFTZUxq?=
 =?utf-8?B?ckZ5bXZoNXZZVjdhMnlOMEovMUE5L1NzWTVqbTJHN1l3RzJaN1ZhT2pXd2Ft?=
 =?utf-8?B?L3R2WnlBdG42MU1XWjRkNy9qSEVXRzRBM0diUGdCZXViQTFBSEhUMDQ3bmdD?=
 =?utf-8?B?dmlpcXlBdGRxR3lLMzJXc1FBclB3bVFkRlFJTkxJaFkyNTBNamgrczYrYWVj?=
 =?utf-8?B?R1RDZUVNMkxBREhqc2pmeVcrVXpnZUdqOFk0a1I0RituYS9TSytRd2cxMzd0?=
 =?utf-8?B?TjZPcFRHY25ZdEFiNFo3U3lTbjZxckE4TzNpR1BLS2Urdkg0djYwbmVvdkhu?=
 =?utf-8?B?bkRpQ0M0QUZoOVEyclZxMFB5czVXc0dSaTAyMllqbGVTeENkLzR6OEFxSXBW?=
 =?utf-8?B?SHlTRmFUUzd3NnlBc09lOUFCNDR5aGYyczRlSDM1eGFZbHJUczk1bmQrdi9k?=
 =?utf-8?B?cUo3ekdaRnNzMXBTWW5PTzhXdGx2aXhyK1pMUU5CcFBtUVZzZGE5eEpFajdx?=
 =?utf-8?B?VUtzaTIxVE9mNHdIOTh5ZXBOM3BDb3ZjRmprN3NnMEV0MWxYZDFGR3hCUWxQ?=
 =?utf-8?B?dm5iMHhQalVGcFNpb1pHcVBhY0xTMXNvYy93bzlXVFFub2FHNzVZV21uZHBM?=
 =?utf-8?B?YTRSdVV2U0FaeHMrK20zSFBRd1NZK0o1ME9SRFU5aWM0Zm5oZ2JjcFpxT3du?=
 =?utf-8?Q?iMQ4u7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dXlhNUl0ZHZEN2FZQnM4RWU5QjdwaittbTdkTmN5aEJlSGRJZTFEVGZPbXcr?=
 =?utf-8?B?MXd3QUs3ZEhkZnZWSjdzVS9ud3lOb0QraHNNNERkZEFtbjR0TkExa0FXMVUr?=
 =?utf-8?B?eGhHMFM2WWEwYjlkVnpuNlBUU3NUMkdKZVBGN3BxWkxvQUtTMVRQVHdmZlFw?=
 =?utf-8?B?ei9La3RMdlQvZmpmeUQ3elYwK1R1NWNnSWpsb1dqTW04S2NSYVpEbnA2ckQ5?=
 =?utf-8?B?Q3hRMnh0R1ltUDdqbjZaV3dDelVEbnErSlNpaXJxYWY5T2V0bnVWTzFtNXZS?=
 =?utf-8?B?WSsvWFVXNjNEV0piNlV2NnhxQnlUUlZPdEhJZ2lmcWZNK0ZKbWNGMjcvRkZi?=
 =?utf-8?B?VlQ1QTJVZjVWWDRFcEo5NGk3MmEyMU5BeWp6dllpcjZ3N0xUVCtJMzJDL3ls?=
 =?utf-8?B?cGJmWWQwWUhkM29mckQxWmppWStieGRndko1bytEQldrQ2djbVlocys4azFz?=
 =?utf-8?B?UnVqeVkyU2huVkJSRzloREY4U3VQazByc005NG5DdkNvVFBHbE13dHV2N2c4?=
 =?utf-8?B?VDVBQjQ0aEF3Q0VsbXBLWkQ1Rmp6elhCWVdvTXp4c3lGWGFzenYzWFNJU3Qv?=
 =?utf-8?B?Rngva2w4M2ljc0pwc2ppY0dYM2F2dDl1NnI0ZDF5Mk5aZFV0R3hkWEpEY2hi?=
 =?utf-8?B?cGVBMVdoVEEvUnUrOUI1ak1TdkJVYjlBSVdzd2NDcGh3U3htUlpycDMvOHN3?=
 =?utf-8?B?Z3g2UE44b09NVngyWllWV24wR0o4RU1lUEJpSm5vUjE2TXdCcWtQczRsQWs1?=
 =?utf-8?B?VlpMdTVYamJ3dUxmWWEyMWJkWHZicWErS0pRUXNiYzk3N0FqN2xpT2VpeHZQ?=
 =?utf-8?B?RnBqdEVFUlBiNjJoWG5XWjBlTlJldWRvbHdibktaUDJkUFpQSnM0NlF6Tngx?=
 =?utf-8?B?TnFRL01xaEpzM2thYXFnL01La29xbGt1ZTR2aGZhR3Zib3ZSWWpxNWRVUnRP?=
 =?utf-8?B?Ny8wbDJtSktqRFdjbkNMZE45dWdDcGZKMVlHMERRM2xzUFRUVUFtMWVpQVZu?=
 =?utf-8?B?N0Y5ZzJpbW93dWxUaHlhZjZQNzJvazN4NVRwMkRCcjZ0aU9RYklJM1hvUnVH?=
 =?utf-8?B?Ym1GeEJmWWNQeXFFRWFoU3plRERRdC9nbDIwajRCdUg4aDZ0YmllU2pFM0Ra?=
 =?utf-8?B?VHVsVVZBcjNCdVpQemp3Z3dFcDlZalVqeWlzMEdtQlBhSlJYTE96T2pOSjlQ?=
 =?utf-8?B?TVBMcWtYT2VvYy90ZzcyeEJqcmtRU1ZYdXd5VEVmUUJEN1BQZ1NtV1FCTG02?=
 =?utf-8?B?WXRCTkNweVovbHM4U3NrSWlnbmFtWEo4b2JLb2FzTVgxWFlibjlEZjFlV1M1?=
 =?utf-8?B?Q0VEZytsLzAzMHREYjhoL3Fhamc2dlVxUU1Ya2pJZW1HZ3VHL3V5c3VqVmI0?=
 =?utf-8?B?NG5XMWUrb00rZXZidURWWi9KNGVVY1hZSUhnSHdBVlp5TDhnZGdwSnY0NDkr?=
 =?utf-8?B?WEhTSEdiT01Ba0dac1o0VllOU28wVndNcDdXMGU5eXVWK0VObkZUVzdoWEs5?=
 =?utf-8?B?M2M4alg2ZFlyTWdPa0VCTENTZElvaVNWbkdad0NhYVhHMTBGU2R1T0FlSnRC?=
 =?utf-8?B?MEtLTlJlSnFRUjE2REZaZlNrdU1XUE5kUXBUNm9ITDhVTStnbFFMWjREUGFU?=
 =?utf-8?B?TFlpS1F0MnNyNDNsbzA4U01xOGpzc0x1ekFuOHZVU2hrY0ZLelpLOVRmUENp?=
 =?utf-8?B?bGdSb2d0VTZOZlFDUGM0QXBIZVY5NHltenNTU2FPTlJxdEVLdmhNczB0NnN3?=
 =?utf-8?B?czRvOW84eS9ZRlB2NUs0cTJKTE5DM0g2WTExRkh0VjIzK2NyYWYybEwyd1Y4?=
 =?utf-8?B?WmtSYm5QQmMxZmxEemQweXpBRGZDSDFaZkpEQkljQzN4Rm9qS25HNTc1SERM?=
 =?utf-8?B?QXFSTzlscXpqeTZhNVhQRU1hZEVZWXkrcHdySTBGVWhxejRuUkxybWxFK1Uw?=
 =?utf-8?B?S1JiSlNFWS9EMlQwNjc5ZUtPWG1sR0VhNWJTSmhMbnhqNzlOSHpneDUraFpT?=
 =?utf-8?B?L3pLbG93OGhGZUtGb3l2WWFLcEJMWi8zSGRQajIrRFNzSlkyUGg3ay9TWGo4?=
 =?utf-8?B?cndOK2ZPRGhVc2tWTEhEd3NiZyt6SG13aVVIOVNsQnhKRS8rVU15YkxwckRh?=
 =?utf-8?B?TmNwNWNyVG9pTEptMFdvcFdlV1JOa1E2dlJNMWpZUm9tcStCLzRGV1QySU9v?=
 =?utf-8?B?enB0V0JYblNpL0ExSTFnVFY2T3FMa0tjMWhxK3h3MExSNCtRRS9oWSswUWhF?=
 =?utf-8?B?bHpGc2lqbFZWNWk1TTRZNDZzYTV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <175FFBE34CB2B54FA5F688970AC87D80@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1Np7+dfhm+IjSzjHMUw5iYkDR9mX2G3iibAeMIcaNh7I3xsMfTo6TNcRGGiE5sYh06t0+Ymv67C4drN3ooocNSCorbrCy1eLc7WETmg0bIgmSOMGcSJXcDlev6Y+KQy6g0Pw+1XweTA9qdRgRIQo7ofmMnFDXR0h3zlfXoMvt0xk0sf1CgxD6XamRLdMSdWnIN3Mc/R9KBRMx/tDcMDwDaaSA2hcsRyBpkOZBuFHx48r1oluKgueaWLK3qnov24e764JAEGlkeK7YU7o+YYMAiB6nakWiGEbdAXhpSCsWdkRPrCmixHmszSHDkK2te1jQfsYlLPETJbjXYcgW7zKKGP2whnXRjCE/VQ3VTT0sjCXVwaEQB5Z6s2iF4dGhQYA0GEchfmmqGX1H6aCEtcBWfpnKjTL4i6gYcwTJujAUyf2apZZjvXKOlHutwRAlCx4NCjiDS+wqq+Mmzc1gMv6f7PDtwnjFI20XKBzaPTk92LZif5W897I5Pm/yAC4MT7A49mjddbYGNhutgugFVisTBdN/icKUvKpqmg5ZgThGCLzMp8EL57gqpZ04cvfqpy36a8Dnr05f8NLHE4mumoybqXOSFjHUnuUr1bGbjY4ydJPAjnPfWUWut1mxJ04ZOdS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be045a8-5c6b-4ed5-f0e9-08de1134183b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 06:27:37.5586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqE8JpL0orBifxZEY3nwM3Cz1WsIoIJY9DvtUT1RkWaXld+q2mHijEkvMjn2h63OZialSJbrj5Iz+mtny2p4GVrfNlkhIEAxtTEed0k+PwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6482

T24gMTAvMjIvMjUgNjozNSBBTSwgaGNoIHdyb3RlOg0KPiBPbiBUdWUsIE9jdCAyMSwgMjAyNSBh
dCAwOTozMzowNUFNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBTaG91bGQg
SSBicmluZyB0aGF0IGhlbHBlciBiYWNrIHNvIGFsbCBGU2VzIGJ1dCBmMmZzLCBidHJmcyBhbmQg
eGZzIGFyZQ0KPj4gc2tpcHBlZCBhbmQgdGhlbiBzdGlsbCB1c2UgX3RyeV9ta2ZzIHNvIHhmcyB3
aXRob3V0IHpvbmVkIFJUIHN1cHBvcnQgaXMNCj4+IHNraXBwZWQ/DQo+IFNvIHRoYXQnZCB3ZSBu
ZWVkIHRvIGhhY2sgYW5vdGhlciBwbGFjZSBmb3IgdGhlIG5leHQgem9uZWQgZmlsZSBzeXN0ZW0/
DQo+DQpXZWxsIGN1cnJlbnRseSAyIG9mIHRoZSAzIGZpbGVzeXN0ZW1zIHdpdGggem9uZWQgc3Vw
cG9ydCB0ZWxsIHlvdSBpZiANCnRoZXkgZG8uIEJ1dCBvayBJJ2xsIGxlYXZlIGl0IHRoYXQgd2F5
LCBfdHJ5X21rZnMgaXMgdGhlIGNhdGNoIGFsbC4NCg0K


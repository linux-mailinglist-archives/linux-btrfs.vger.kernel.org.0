Return-Path: <linux-btrfs+bounces-6321-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A2592B26F
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 10:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C47328152A
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 08:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14E615357A;
	Tue,  9 Jul 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fWL4Cvvo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nyD9qpSz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97E96138;
	Tue,  9 Jul 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514690; cv=fail; b=as03DaGWznedXIH4kHujcovaHprbSLUqrfiSP7JIg/3OxMQgL0IKx57chDJRHyCgi1+VZYS5yYAeeZb5ywUW1bCgmR4e5k9owqVFANYysGirYGLzRxxanXIrZjN9fueEFhUBdQcMnluVU81iDus+bY4wAVJxKo1FiHtvsG9O8KM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514690; c=relaxed/simple;
	bh=aYrsN10lw5oiVCd+CCA8uB6dg4prtmBohLQKqmCEKMY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jJAjYShmRPPeDa3vcgR2qy5G/73PmZarXJAZ/xiWQMlGfF30UpruKUzCMQjte2kwwnQy0IWyFaMbJwKd7F1MgPMVF+0RlrA2R3L0Q9sae4H4NUxF4FOMiBunLy8Tu1l4GM+IyrLOHnMzTrKChvKtwI3sU4riVG6H6PebVf7bLWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fWL4Cvvo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nyD9qpSz; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720514688; x=1752050688;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aYrsN10lw5oiVCd+CCA8uB6dg4prtmBohLQKqmCEKMY=;
  b=fWL4CvvoSHkxNdsWHJ2xRW2pAd3mFQnt1kvjMMVDagAXdEM2wY6y2ICi
   fG/J08HUcNygu/wPwDWUKlq+NCI/duaZFAoVgdiWMXG/jO9ivLZgQFt6+
   lOE5WI0BLg+QPoSPbygsz3nxWxmAzY4zjQGMHWSG9JRUy6vGVOyRjSxvz
   VMXgGulPvnZbw9pUUJJXRk9D26x0whV6PxPoKuS1rHdAVYJOtxvZtPFiS
   8V/9NmIjM3kYO3rXtakuzsthG79VClVngWr0RIFvmHK63aBrbmNnkyUg3
   pymFtIaqOfj6w9QQzbDaWf7n2tY1D1t9NeOV5p37GJyD5ac/P1zz6rA1S
   w==;
X-CSE-ConnectionGUID: o8KZIymaR2acqIDQlvGlyg==
X-CSE-MsgGUID: RA+21npiReeW313ytts4bw==
X-IronPort-AV: E=Sophos;i="6.09,194,1716220800"; 
   d="scan'208";a="21223135"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2024 16:44:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYXfhW6U1vn/Aaf4byLPgd4ttNcnnkt8XxiGeOO/xmZfzpF6OBmoMljuM170p+qUrRMb4tFV50BWjSeVrilnfFHwN6fF7PMr5MWHe0n212HCONDPLjRLKLVACz4/98BfO7ffvF3trc2oCzYelDWLr/No1SpcFM5AIunqZ6otcTyeYx5GclrEscDJclsAksGmhfYIfJhjSQdLx2WuFuGmY2jRQ5RU9t4iUtxGJPoTbSaqh2EvzEpZIt5iXNp7kvmU8zlHezuhuJWlJnp4Mh8udyWutHYyEv9BHm0r9/TUx5WX0i4TD2KlUU3OFQWsNQqzoeGrob5jdZjEc2+8WQSPbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYrsN10lw5oiVCd+CCA8uB6dg4prtmBohLQKqmCEKMY=;
 b=LONRmzPAjcAgMaj73HN45VlXpcNNdSkDmnVdDL+2THynUUxSc51sXK/B+JPpqj52L3uWQffCO++XKKspUuvgYFADK+LQmgm5OwMevryrs8mpd56bahM+/5bKlkyhthctVJjJBzSxmVvoGxPECTxPXDdLanbcmp/EnwcZzatapUJjvVfYXhS9Qio+4R0gSrIDY97UuTpJhXRS5F0LSeyifU6OWKuczTlLcau6Ww/m5ORDsimU+ibxD8ksTVUsOsqr+rMl7iHKz9hAMqT98yWN99QqvFmV2Wneeyud+9WWaJtoXR6Nm7OeTzOtIN9U/oJ1M9YkssWewrXLApvsT961rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYrsN10lw5oiVCd+CCA8uB6dg4prtmBohLQKqmCEKMY=;
 b=nyD9qpSz8LCMRulWdh0tt5XHMDpkUm2H2tztx/55atBxsVY/D5NsYXtq9gQ34mTd5HUVCFaWRisWC9MA7OCWZzlk5/Kl61hH/jhK6Wx5LLTjE1kP9jVUjre138jqh85rJ10SWnUAM8KKeLnQasg9qsXjifGixdTIGkk1TfHnsGE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CYYPR04MB9031.namprd04.prod.outlook.com (2603:10b6:930:bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 08:44:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:44:39 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes
 Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Filipe Manana
	<fdmanana@suse.com>
Subject: Re: [PATCH 2/2] btrfs: replace stripe extents
Thread-Topic: [PATCH 2/2] btrfs: replace stripe extents
Thread-Index: AQHa0cnFYxZwEtx5nE+YH67cGV/QJrHt/NcAgAADdACAAARHAIAAEFEA
Date: Tue, 9 Jul 2024 08:44:39 +0000
Message-ID: <97d6c743-5828-4183-a39c-f9c9004674b4@wdc.com>
References: <20240709-b4-rst-updates-v1-0-200800dfe0fd@kernel.org>
 <20240709-b4-rst-updates-v1-2-200800dfe0fd@kernel.org>
 <4211723f-ddc9-4646-91c3-14a9a1769d22@gmx.com>
 <09f08d98-a615-4952-9949-daf4a7119b96@wdc.com>
 <bca6a8d7-b23e-49be-9cfa-f387aca82e60@suse.com>
In-Reply-To: <bca6a8d7-b23e-49be-9cfa-f387aca82e60@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CYYPR04MB9031:EE_
x-ms-office365-filtering-correlation-id: 2f6f1d31-9b5d-4cb7-a749-08dc9ff35e81
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eTlPd284UmhxbWljTVhGMkNLQjdLaytOeE1uTkFKOEkxYTdsR0N5M25VMzBt?=
 =?utf-8?B?R1Z4V1JYK0QyVEhYSHMxbDlMYnMxSkkxZm4wazBnNTlLdVhKc0V1WFh3MXZM?=
 =?utf-8?B?UlE5TVhwV25NRjVkSWliYjlIRXJZcDg5eC83WDRRUHNPMXFDc25xd3BGSWQy?=
 =?utf-8?B?OXFWMjJPdWNxenl3K2RkS0Zub09IY3FuUldobWMyTmlvNVoyQ29BV2RxeENz?=
 =?utf-8?B?Mk56a2FCUzNCMk9KRlJxRkt2MTdUeUdmVkZFTUh5dXlGWUlBaFI2YVFvQklp?=
 =?utf-8?B?WnhWM25PcS8zY3pMVkloVXBLUjdPUVlRYVkxTEljWXB2RklaREgwQWZ6TmpD?=
 =?utf-8?B?ajJMaG8wNkpYTGtiTzhQQmkxWXlFMm1hQmhZbDhIeitmNitBRDdXRm4raG9G?=
 =?utf-8?B?QWMyc3BrNExUOUFxYWdDL0l1akpZRmV3M0F1NEFNKzBFVTZsUWUxMEJUNUU5?=
 =?utf-8?B?by9ndEJTY0NybVBpOGlPM0xHZERhZGdyRXlTcWt0aENkOXFuYUpWUnB4aXNr?=
 =?utf-8?B?WktkZEJUNTNJUkRZYUF0Y253Szh2WTJTS0NFR0EvZXVqeVh2MTcybGUvd0cv?=
 =?utf-8?B?YlpmLzh6aGZNcmhQVFVrcVBRVWozVmdkeVpvOGQwcVF6SHZiLzBudmtMK1Fp?=
 =?utf-8?B?TGR0bllJRWtody9lTllidDJQZnNSejJiUE9ocnIzdUZpdWIxMVpLVVJQNVJW?=
 =?utf-8?B?VDljSG51cW82SnBtcmtxangvaE9tQjhJTU1jMERGQnVmN0V0N2lMaXgrNjE3?=
 =?utf-8?B?dzdsdHVFVFRIWWgvOVZtL1hIZTFiVm01aEhwLzlxdWVRcElrTDY5Y3ZweFBt?=
 =?utf-8?B?Qkd1bGpSa0E0SS9KRGJSbVpRSXExN240VFM2Lzg0ME1ZN2NCdzVGVmJYZ0hC?=
 =?utf-8?B?R1VqNVZOcFdVQ09zQmF0N2E3SXlsSUF0ejNwQnVHVjUvKzJKejdHSWJZdWpQ?=
 =?utf-8?B?cGkwdElXNFZBaG52NDNKZ0ZCczhYWEx4RU9vTUEzL1o5SDRtNkVCSzIzdjdZ?=
 =?utf-8?B?VXhCeXhYSEZIeGpRU0x4RDF3ck1FMUQzV0dhK3FyU25IT3A1Z3hiUERrU044?=
 =?utf-8?B?NmdUNGZ3MG5YTE5PcFAwSU1zeTRFRkxub0tha1dPNFVaMGhKa0dtWk9ydldS?=
 =?utf-8?B?MytEV3Z3QTBpelZJaTEwTmhTaFJ3cmROdHRzZkFObkJTSS9NSFcrWG04dUZM?=
 =?utf-8?B?MFVOM0lFZDJMTmNWaVNDbk9EOHpNbUNXS1NkZ240M3oyMFhFeWFLbktldUQx?=
 =?utf-8?B?clJvVzFLVGxFeWd2N0c2RHFjTlRiMnU3UHZRSVFYeWxZcXgyM0V0TGF3RjVn?=
 =?utf-8?B?Y0RlbG1WQnI5R0lpbXYrV2FaUi9ldmhZM1RXbnd4SmRScE5ValVLek1JdWFF?=
 =?utf-8?B?V3E0OTc3aXR5Q2ZYNXh0T0Vrc0RydC9JYTlRNUViS3BpR3ZKRmlqRktvMUpV?=
 =?utf-8?B?WkV3VEVEVUJwUXpLREIyaHdhTVNYdmNwWjMzUEZXVGorWHVWc1hVZXoyMEI5?=
 =?utf-8?B?d1YwMnlNcUw4TlNBWGwrRm4vWVlYMWoyZDA5VVpDbkxKUlhCL1N2cFJNbFRW?=
 =?utf-8?B?YWVhTjQwQm1PQTRzY1o1dktkRkNyQVh5YTI2dVhHOFdhUEp4eXZ1ZkVjaDk5?=
 =?utf-8?B?cjBKNGJ5d2FQSm1HK01LN1N3VDhCbFJZOXhzaFZseG9veFBDM3ptMHNZNlpj?=
 =?utf-8?B?UHhwenJpTkEzR1FBc0xkRDU2bDk5SHdBaFJrM0xGS1pvcDJjR04vc1NHY2hI?=
 =?utf-8?B?ZHdNTzZ5bDRLY25UTFllMWQyTFB1YW1lMStnejNoQmhra1VvTFNMcGlVYVJY?=
 =?utf-8?B?RjJkQ0JDb25CMHRDdEJHS01kQXB0TUs4OW96NTZrSkh0MGVmaTVGVHJ4NnhV?=
 =?utf-8?B?aW1wTVNNZUNqMlBqZVNOTXBEL1hTTnl4ekp6Y3VhNGJOTUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGthbXlYV3lSSER3TGFUS21QbjV2K1k0NnExOXVuZkdHRVNFSUEySDRQMzM5?=
 =?utf-8?B?MUdtbVE5SXp5eGczS2M3ci9pOW8zQllFSVVHZFFIYmtKelh4WVFhdllFMXQz?=
 =?utf-8?B?ZHAyV1NaTHBYbVZlU0Z2UVRIeXNxUjNwQTJiTjV2US95alpzWDRTT1d5NWZm?=
 =?utf-8?B?b0d0akhQYTJieFlJZnhaakM5TTM5L2VIMWE3cS9rVW54TnlrTi9kdjlFYlRw?=
 =?utf-8?B?anRrL1JxZGpnalZRVlJrMXc5WGV6QmU3enJXSmtpR2xCYzl0VjJyL3phRTBP?=
 =?utf-8?B?ZDNZMCs4MjJzSFYxK0dnd05tYUp2WE5JbWZKSTVxbzVxeGJUOUh3NXpKMlR1?=
 =?utf-8?B?ckZ2QzJ6Ykd2ek91VU5wMlBWVTJsNC9UbUVJUUNhZFZ1Ly9mRVBVUFBjU1E3?=
 =?utf-8?B?WXRsamJZUERsWWVHV0pkeElTMVhqbjhSWXowK2F0dGx6Q29tMEZiR202QU03?=
 =?utf-8?B?NVF3M2EzMTlHWGE5by83MURRTWV0UWZIK3dGeTlXdkl6M05jeTJoUTNpWnFR?=
 =?utf-8?B?WTJDV2xaRm9GZ0NqbXg0SlVSRkR2MDRzUDNKWXRuMjV2dzhkdUZlOUdDK3Uw?=
 =?utf-8?B?UGpOcHBaOXE3RDNIQ2srZlRKZDhvbjNyUXZrSmJCZWtCRFpOekJ6Vmt4cVBO?=
 =?utf-8?B?emREaHA3ZU1hNi9PR0R5MlBBMEd6SWxRUTJVZzBYNDdkRE5JR0hFUHJNUy9s?=
 =?utf-8?B?bENuNDBXMXFWMjVWYzVFWWJ0bW5yODRqSXhEcGRhYUxud1orRTlzSkVtL29w?=
 =?utf-8?B?c2ZzNDB1WlBLcWQ5bWtuRkNyMDRsbkY5ZjFvVndvSzZ2T2JzeDNhNGlSUkk4?=
 =?utf-8?B?VWZqemVvL1RSRUJ3cmJ4dllZRnpqL0hmelVmajM4T21kV05UUnVSUnlUNk9G?=
 =?utf-8?B?YmxhOGZEL3p4MjlCNy90cm5VRzFMYm00UmJ5MVQydXRVRDhCd3Q3TTc0TS9T?=
 =?utf-8?B?dE15TEVwRm5jd1plT3JCRU5MUkxoaDZ6dERtUnkwdjdNREJEWDRhRW9GOW8w?=
 =?utf-8?B?NGZIZDdJeEQxZGY0aFZFT0Z4MmwrWlJJUzdRT2dDcW8wUHY2a29jblluYlJx?=
 =?utf-8?B?Q0FJOVlSOHZzUGwxd2p3VTJtYXZrVS9zZmdhaG82Z0FQeEN4NHpMa2FvOWtm?=
 =?utf-8?B?MFM0Q2xpdEN2RjN0SG1EUzVBL0lMbEg0Nkhvc0ZpenpYdUZYcnBXSnkrOVl4?=
 =?utf-8?B?OGFEdzFJclV5WGQ0dzBlNDFpWjJ1SlJQUUU1YSthbTdWK0Zibm1VQ0ZaUG5t?=
 =?utf-8?B?NERLbmVVNkQ0WFlFRXRMa200TmxOeTBWeEo5M3JTanJMRDNjZmdUZzh0N2FO?=
 =?utf-8?B?NWwxdVZFOWNWTnNMbmhEU1FBK2VHeEZUMWQrVmhXRkdJMHVpUUxwa0pvNWJq?=
 =?utf-8?B?OFhTbVJXR1lyaDh5T3p3OUcxUmNDcWtCSER3cHhncEFpSk9uSEdaN2dHMGFq?=
 =?utf-8?B?Z3RBNHJVWGd1U3JiNWpWZ3dpNHhBb1hUSCt2ZW5OdjJUU2hNRk50NmlWSUFx?=
 =?utf-8?B?eTN2OXZySmlkNkxwaDRPQXU2REwrQXVhR1dEU0tuQnExcWJJTnZmT1pGd3VX?=
 =?utf-8?B?eFBhdUZwL2RqaDVkVWZNTzBUV0REUUFCb0JJNG5HcmtEeUU1N29RUzRpUGlV?=
 =?utf-8?B?YkRsYWNadlk1cTYvTU1yRzg1dTR2MVdxUFJGOXhTSlZXUk11MHdabEd4d2VE?=
 =?utf-8?B?YkM3NkFmTnV0WXBBUVA0d1B4SjUzRWtINGt4VUE4cmNlbUxvQm9Ua093OUFD?=
 =?utf-8?B?ckFpSzJrL3JHN01nU1NvL3FJbDE2a1FNa3NHdTg1R1lOeGRVN1pObk1NNXlP?=
 =?utf-8?B?VGZ2MlB3UUFveDdZT0Z4blh2K0lZSE42aUsxTjNKYmhWMHZKWGsrSUU2b250?=
 =?utf-8?B?cVk5Tks4TkpJWXRWN1J5cWxyK2hjb01nbmRDT1N5c1oxWjh6eG9rWmRCZUk3?=
 =?utf-8?B?djJoT04zb2N1K2FFTkdiYThQZm50WjFRYU90Qk95bkVaMXM2amJocW0rcFZL?=
 =?utf-8?B?YXFsVmp1WXJ5ZUpDV254WnBnZk83WmFTVjR0MWZyVEdORFA3M20zRWVBMnJM?=
 =?utf-8?B?MWNRRWl5bXNUK2x1WUJ3Q214cnVzbXljMktsTVdQUUk1eVRodnllRG4rMms0?=
 =?utf-8?B?MnNwKzIxRUkxdTRiS3RjNXc4VElQZW9EUzdmV0lmRTNkMVBqZExYb0ZzaTVZ?=
 =?utf-8?B?M2VXUTBpM0RjOVdUNGJkU0VZTVVuRFA4dy9UcmxLQXlnZnA3a0lLd1NSdlhG?=
 =?utf-8?B?eVlVQmNBV3h6U3NsT2N0T3RRaFZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21406F7517EA244DBF03BBECE87AB41A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H9Saax35R16RnFUz3G2aFl12W75YMRpZlOklrWYO8YQKuSX5aFXpyr4eBORVtfTQJprBNuFnNw9oEtbJTlGj/Z22i7nkj75zpXGWH8nZc9v4q+no3d3PVhyMnqJPM9SDQQJnogsxVTqhRK+5+gd4/HBA3oEDLoYRgjkgw+Bw931AJdtnovr9NNJLLQNWRiyhzci0yZxDHrjquTu3vdY00CgmJz+7hhM2tEZbPuA4f5VbHeZrKyUkpKFkp5OSzLRcQZVeowEo0KERNUXJxpM4/OjsbvPrOp38msqvwsa/mSMeoOlBctdMqUN2n8wYgV+f4A8nZaZYMFs8fSwYXuqLJNs0CX/vsJC62WwfLZQ3ZvfhR01eLWR48fd4j5AyPCVwvpOIlIelcBlf85EEZGzJma9reizOdolEuQ2YfAAJRmoQ1FeUnn9dccid8nIm4O8y38c88DoS98kkKCXCPLSax3ntLGC+QtnixllK5zeIxLswW+srYuPODAMH3ID4SV3xoYGwqsT9fqECBFpAW6LKPyGsA5+L74UcqXM35GCerjpTYw/7a4g5ATCeQkCMsCd3JyNCLMtu0/nNbQ7bdWBC2LKih9hYdMDrCRswuzU5PkkJQxdTSPy/fvuI+/SGnuss
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6f1d31-9b5d-4cb7-a749-08dc9ff35e81
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 08:44:39.0819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDRT6kRp+6fqMIcKBMrUha80wuoB/ur5zXkNFrmPWGImRnqHFfgPS8/XFU8DBYLxhMMq+9emoTHnMsF8cqRzIGr0vOjj50NVesotaXT83Pw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB9031

T24gMDkuMDcuMjQgMDk6NDYsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNC83
LzkgMTc6MDAsIEpvaGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+PiBPbiAwOS4wNy4yNCAwOTox
OCwgUXUgV2VucnVvIHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiDlnKggMjAyNC83LzkgMTY6MDIsIEpv
aGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+Pj4+IEZyb206IEpvaGFubmVzIFRodW1zaGlybiA8
am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+Pj4+DQo+Pj4+IFVwZGF0ZSBzdHJpcGUgZXh0
ZW50cyBpbiBjYXNlIGEgd3JpdGUgdG8gYW4gYWxyZWFkeSBleGlzdGluZyBhZGRyZXNzDQo+Pj4+
IGluY29taW5nLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4g
PGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPj4+DQo+Pj4gTG9va3MgZ29vZCB0byBtZS4N
Cj4+Pg0KPj4+IFJldmlld2VkLWJ5OiBRdSBXZW5ydW8gPHdxdUBzdXNlLmNvbT4NCj4+Pg0KPj4+
IEJ1dCBzdGlsbCBhcyBJIG1lbnRpb25lZCBpbiB0aGUgb3JpZ2luYWwgdGhyZWFkLCBJJ20gd29u
ZGVyaW5nIHdoeQ0KPj4+IGRldi1yZXBsYWNlIG9mIFJTVCBuZWVkcyB0byB1cGRhdGUgUlNUIGVu
dHJ5Lg0KPj4+DQo+Pj4gSSdkIHByZWZlciB0byBkbyBhIGRldi1leHRlbnQgbGV2ZWwgY29weSBz
byB0aGF0IG5vIFJTVC9jaHVuayBuZWVkcyB0bw0KPj4+IGJlIHVwZGF0ZWQsIGp1c3QgbGlrZSB3
aGF0IHdlIGRpZCBmb3Igbm9uLVJTVCBjYXNlcy4NCj4+Pg0KPj4+IEJ1dCBzbyBmYXIgdGhlIGNo
YW5nZSBzaG91bGQgYmUgZ29vZCBlbm91Z2ggZm9yIHVzIHRvIGNvbnRpbnVlIHRoZSB0ZXN0aW5n
Lg0KPj4NCj4+IEkgL3RoaW5rLyBJIGhhdmUgYSBmaXggZm9yIHRoZSBBU1NFUlQoKSBhcyB3ZWxs
LiBJdCBzdXJ2aXZlZCBidHJmcy8wNjANCj4+IG9uY2UgYWxyZWFkeSAod2hpY2ggaXQgaGFzbid0
IGJlZm9yZSkgYW5kIGl0J3MgdHJpdmlhbCBhbmQgSSBmZWVsIHN0dXBpZA0KPj4gZm9yIGl0Og0K
PiANCj4gV293LCBpdCdzIGluZGVlZCBhIGxpdHRsZSBlbWJhcnJhc3NpbmcsIGJ1dCBJJ20gc3Rp
bGwgYSBsaXR0bGUgY29uZnVzZWQuDQo+IA0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9idHJmcy9y
YWlkLXN0cmlwZS10cmVlLmMgYi9mcy9idHJmcy9yYWlkLXN0cmlwZS10cmVlLmMNCj4+IGluZGV4
IGZkNTY1MzViMjI4OS4uNmIxYzYwMDRmOTRjIDEwMDY0NA0KPj4gLS0tIGEvZnMvYnRyZnMvcmFp
ZC1zdHJpcGUtdHJlZS5jDQo+PiArKysgYi9mcy9idHJmcy9yYWlkLXN0cmlwZS10cmVlLmMNCj4+
IEBAIC01Nyw2ICs1Nyw5IEBAIGludCBidHJmc19kZWxldGVfcmFpZF9leHRlbnQoc3RydWN0IGJ0
cmZzX3RyYW5zX2hhbmRsZQ0KPj4gKnRyYW5zLCB1NjQgc3RhcnQsIHU2NCBsZQ0KPj4gICAgICAg
ICAgICAgICAgICAgIC8qIFRoYXQgc3RyaXBlIGVuZHMgYmVmb3JlIHdlIHN0YXJ0LCB3ZSdyZSBk
b25lLiAqLw0KPiANCj4gRGlkbid0IGFsbCB0aGUgYnRyZnNfZGVsZXRlX3JhaWRfZXh0ZW50KCkg
Y2FsbGVycyBleHBlY3RzIHRvIGRlbGV0ZQ0KPiBleGFjdCB0aGUgcmFuZ2U/IFRodXMgSSB0aG91
Z2ggd2Ugc2hvdWxkIGFsd2F5cyBoaXQgMCBmcm9tDQo+IGJ0cmZzX3NlYXJjaF9zbG90KCkuDQo+
IA0KPj4gICAgICAgICAgICAgICAgICAgIGlmIChmb3VuZF9lbmQgPD0gc3RhcnQpDQo+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICsgICAgICAgICAgICAgICAvKiBUaGF0
IHN0cmlwZSBzdGFydHMgYWZ0ZXIgd2UgZW5kLCB3ZSdyZSBkb25lIGFzIHdlbGwgKi8NCj4+ICsg
ICAgICAgICAgICAgICBpZiAoZm91bmRfc3RhcnQgPj0gZW5kKQ0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgYnJlYWs7DQo+IA0KPiBBbm90aGVyIHRoaW5nIGlzLCBqdXN0IHRvIGJlIHNhZmVy
LCB5b3UgbWF5IHdhbnQgdG8gZG8gdGhlIFJTVCBlbnRyeQ0KPiBzZWFyY2ggdXNpbmcga2V5Lm9m
ZnNldCA9IDAgb3Iga2V5Lm9mZnNldCA9IC0xLCBpbnN0ZWFkIG9mIGFuIGV4YWN0IHNlYXJjaC4N
Cj4gDQo+IFRoZSBrZXkub2Zmc2V0ID09IDAgc2VhcmNoIGV4YW1wbGUgY2FuIGJlIGZvdW5kIGlu
IHNjcnViX2VudW1lcmF0ZV9jaHVuaygpLg0KPiBBbmQgdGhlIGtleS5vZmZzZXQgPT0gLTEgc2Vh
cmNoIGV4YW1wbGUgY2FuIGJlIGZvdW5kIGluDQo+IGJ0cmZzX2ZyZWVfZGV2X2V4dGVudCgpLg0K
PiANCj4gQW5kIGRvIGV4dHJhIGxlbmd0aCBjaGVjayB0byBlbnN1cmUgd2UgYWx3YXlzIGhpdCBh
biBleGFjdCBtYXRjaC4NCg0KQWggSSBkaWRuJ3Qga25vdyBhYm91dCB0aGF0IG9uZSwgdGhhbmtz
IDopLg0KDQpDdXJyZW50bHkgdGhlIGFib3ZlIGlzIHJ1bm5pbmcgdGhyb3VnaCBDSSBhbmQgb25j
ZSBpdCBjb21wbGV0ZXMgSSdsbCANCmdpdmUgaXQgYSAybmQgdHJ5IHdpdGggdGhlIGtleS5vZmZz
ZXQgPSAwIG9yIC0xIHZhcmlhbnQuDQoNCg0KDQo=


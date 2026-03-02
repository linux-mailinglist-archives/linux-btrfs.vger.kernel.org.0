Return-Path: <linux-btrfs+bounces-22140-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI6jCjRmpWmx+wUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22140-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 11:28:04 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9644D1D6773
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 11:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 598BD309B225
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 10:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B153BA236;
	Mon,  2 Mar 2026 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D8yMB3VM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mZwZ6Y1e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC2A3AE703
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 10:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446770; cv=fail; b=qGgCJH712ItuVbN7YQaH6AYc2b+mlCdnW16aI2jgZy6e8CcEvl28SKIHlHeoaVJCNw3itw9GS7v2/IF8mqS6xYxvgScKwOOmAiZJjeXB/DiMdgBeCebfSrslLP6zhskxIW0SQgjM/GHJ0BE6ET7CUFOPIA0Ekjb97U41j2d1Obo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446770; c=relaxed/simple;
	bh=nF4Lo0D2B1PY8XKIPnd2OF1hIkcKfNGCtmtm8VOqAzA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KPtoS0BxEb/9DaByFgTQaIYjzha19yR1ZMFiJxT79bPRdN27RTKd6UjUfGSFakb4L0JQ2MuuAdC3mLzYsu2gcTGcgohZgXvox2XAU6HIItccKvCCxJr7+r8jGFE1aDlSButWgEJEq4jp7Y9sPylHJwje9xwlfr7O+lsVcxZ2az0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=D8yMB3VM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mZwZ6Y1e; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772446769; x=1803982769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nF4Lo0D2B1PY8XKIPnd2OF1hIkcKfNGCtmtm8VOqAzA=;
  b=D8yMB3VMrALS2pg5d5vTMP88gMCHkQteOkXjqw0yN+8BTWVwC9eht1wc
   U+IfhRXSj02M9yuOGTpmCWl4kLDxj9/9tRph+mh46IO/2CkRo95WbR76m
   sXGuthne5J40PP/dNvPfxJuGpON6m6mYXl0MxOc1d8cokP/5v6vLJwmgn
   8qOhcnwnNrAV8fhcfnySBRIOKb2cxfJgjMBTN+Mri+093tMWY3I33VRxh
   +bEH+5P9IrRh8dWp7P1MTPeQ+8obQzGASrs7vsGuwPpyKgq8bYbOvxWE2
   qqEd9X/5hCRrtA39nJbR9lPMl2nf23RNNNw5sTN17ngc2rNwQnl/ZpiBK
   w==;
X-CSE-ConnectionGUID: oMla6kspSbOpzsosBPgKAQ==
X-CSE-MsgGUID: AYEv7htKQyCdAG9bPsLSUw==
X-IronPort-AV: E=Sophos;i="6.21,319,1763395200"; 
   d="scan'208";a="141330854"
Received: from mail-westus2azon11010027.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.27])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2026 18:19:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRtUAiXbiqzr0IaTbViLeWD8tcDbZSD1BPEJqhHZ3cWxidJEzCFbMOBTKGX3MO9eOyCeVUxiF9LIw47XC09iOV3UW+hT2RCl5avU1PF7W7o+hooUdY13tqYeKWaZ8ebJG/vlz/Gy1fYHOpXsN2WNrqUnHBcOp6S6SgGkKWLj69eHACl7buma0HS8zi54hkryoGUImVKjeeX5yTCt+u7z/Bc3AOdo83s5UDO10+SuSg8J6yxYzu47LozzCqORjc0Ui5ZSZ0sZ/9gvmUXxSdNyrx7SqRA/7yBlioYfxacv7SkTKmKd9LeqtXV6o5iT8LvVp4wYBxHNoYS11tJrwkWBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nF4Lo0D2B1PY8XKIPnd2OF1hIkcKfNGCtmtm8VOqAzA=;
 b=A0o6aK13cstlLXtMuhGD0LT/4ikW6vpVB3N8hctGAeHKuVVi8X90L8ITVrQUJZLd/PhvnnnlLSRfukXFBZ4jDPHDx9ng2dbQaeLdoAX6V2+LZ6WP7TCu1xAWNVB7qtDDEa2QyGRluOitvZQgcEHpKZwGy3Mg3aS+2a9WREGPA1xH5M3b1pFjr3ZLMOCemhkxagZ+FqH+W2cU5OP4rgbYkrTpyhPuN9kcRSGt6RVoPHSHVspa/k/uJ9rHUxp3xw3eqiw87pm6SGKyfmcPiRtETFx1iTmb9hdSz2bul+0fQTpv2oQyvg0YO+u11HBMNqLA4b/aqOhHvyF+VUwV1QVvjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nF4Lo0D2B1PY8XKIPnd2OF1hIkcKfNGCtmtm8VOqAzA=;
 b=mZwZ6Y1eupO2b0Ok4g0We9XL2RDr4Segr6zQtsu7zcMXS2RYNGYGdafGUbzIVR4GbxdkCtMExlGLSv/RYioMtvWSb5FWxhkDTpZuORpp6FAjdI1J1DwksL1uRcq6An1mXiGL85csLMW3LEwJOFJxZhH2Bg8dtVFOGH6FNVCRMbQ=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by IA3PR04MB9332.namprd04.prod.outlook.com (2603:10b6:208:505::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.15; Mon, 2 Mar
 2026 10:19:26 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9678.014; Mon, 2 Mar 2026
 10:19:26 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: fix leak of kobject name for sub-group space_info
Thread-Topic: [PATCH] btrfs: fix leak of kobject name for sub-group space_info
Thread-Index: AQHcqXVWJiCBLHYKv0CVhN6oGErRzLWbCHUAgAAAt4A=
Date: Mon, 2 Mar 2026 10:19:25 +0000
Message-ID: <613fe925-b0db-408f-8086-74b2822e278e@wdc.com>
References: <20260301121704.45115-1-shinichiro.kawasaki@wdc.com>
 <CAL3q7H7KgBd7cKMSWLdu2pe-f8SRPCjOhPCvyHrVYDnjsDTr7A@mail.gmail.com>
In-Reply-To:
 <CAL3q7H7KgBd7cKMSWLdu2pe-f8SRPCjOhPCvyHrVYDnjsDTr7A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|IA3PR04MB9332:EE_
x-ms-office365-filtering-correlation-id: dba50005-a038-48eb-eb80-08de78452e6d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 iyMP+cD6n+MdmNJXbMTb0X0J8c9DYxQl36czwFAQuWBoPiAFWSR4OD5rTfamBFQ58FxVWQhJ15vCV0Ib4sxELLkuLuSsg3+yUkfuUlG6ulKq9Lo8FUVmd9IsjhrSla42/soTR+piEQ7DyH3+bLpFl4uIQl7cHS6edx6ULrZLF2UDKwrjXOqEvOEoA/oTNbhXGHsDEvPbWE4zbknzdcslD4Q/yx4w4KPsXTFUnHlMxSmDU72mCwaWNIfg5fMHcF1/TAuOBcUZiUdp44C5YPbE3IStgERXe0RjLuqg7bEvwY5a5QEslyV79gH9XCYGmiZHbDVJnSiVnvFOrxtvUcGFomiaBsWFNBn6ZMYoT50w4GN8ilhPw0yGAu+sOQITBatzTUEHdvau+0lDVMWnF610a+2nKkGbQbj1YrD3v/mzPxRS2JJBmZVHib4c5UzWr4GavrKTDkNbsahqOuvEkry1fe/LvALdXbJp0JAJkCdKAT6en01Yy9e5ExHSDcKotwj8n5Nly9fIDizo1zi3O5x7uBDpMdqultUFf53NlKudu6jGAUq/nkThfsVOSWfpyycOdBGjZzDqFiApf+GMC8V0qzrbXMSDwBB2aH/PGMsDPRjDecJxcQuds/L55ONKwnnWEVNr2yrikEpBC0/+mCa7N2kP2fwuV7re5j+p7PgF4EDxKRSpsbWS1uuFJPAMkXNwMoM6+7kvKcRvtbvyan3aJDozl4r10fB9GzTW9uYbaXKfCLqlWadUVQViuOWnHtAu++2s+Fpd0g/s02jk3CYEvyurwGOz+8/9wBvgQSJ9RXw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmdYTlV3UnNidUpVK2lwLzJGdFdaZmRHMlAyWXh4MVFxSDRZSURGclVYVllV?=
 =?utf-8?B?TlpSU3NlNndST2pvSlk0cEt0bXQ5SGxQSGZ0VXFVZE9OSFZXQTl4b2RkR0Rr?=
 =?utf-8?B?aXJwNzEvVUszYXdWelZ1aFcxeFdueit1djV5L1Z0TlZwRFgxYzlydUVMTENt?=
 =?utf-8?B?WTNUdUtGdTFMTEVJOGFSWDdDd1JmWVlVWllQZG45SHlUc2RLb3NZazhvR0Na?=
 =?utf-8?B?UFlBd3FVRHFGM1pVeGEzcFVEUytLYVFjRGhSRkdVZU5kVU03MU1YdXNHcU5Y?=
 =?utf-8?B?SGoxaWNaVFdBV2V3QXJGMmRaUnBZdlBWNExqMDFCYk8wbXhMZ01DckVpTk40?=
 =?utf-8?B?bkF3OWwweHorWUZMTFF1ZG5JbWlpbTNrejh0UDdPNHRpbU9VM3N4N1dRSCtE?=
 =?utf-8?B?Zm9manlVcFU1MENOMlZIOUtXSjY5VTlMQlRNNmJFWjVjQThSR3lMZ2RCd2g1?=
 =?utf-8?B?RkNvOXpwWitLQmQxVVZybTVHRjFqOFlDMHFHZis4RHJ2YnR0SUlpMzZndmR6?=
 =?utf-8?B?L1J2REthWWFNZDlvbC9wSjNWN3A0SXAyRWVHWDI4eUxlQkVvZjVBSUw1S2Fl?=
 =?utf-8?B?SVRTeTE0SzkzTjdQek9RckhiMXVza1d6d2VSYjVqZ2tsNUx2VEVhd3RHRkNJ?=
 =?utf-8?B?WDBUcjFaV0dsL3ZCRnZ5VURQbVlqLzhVejR0U0hTUitTczRLVThtNktrelZE?=
 =?utf-8?B?OUkrVkNDejIvcWhmQVZEMDRmQ2lMZXlidWh4MWlQdWZlMldQd2RxRlcvczVZ?=
 =?utf-8?B?R0Z2MmRSN09Pc003MTBka25rSWl2WHdaV0kvQVRzUGY2bTZ1L1hnTkt4cGdV?=
 =?utf-8?B?a1N5U2xCQjQ1WWg0YlJHTFpqclBZb2JnVjFaRE5XbUNNZnFrTWM5OCthZk9G?=
 =?utf-8?B?QXV1T0lzQm4zTEh3R1IrNE1UeVVqeHc2VWVzL3g3ZlJ3MlNkam94N2R4clZG?=
 =?utf-8?B?aldyQzRDYzdjVE1KVS9obUdxYXR4MU1RZ09RZHNmamlMdnpWS2ZVb1l6TTMv?=
 =?utf-8?B?c3U1Z1BoenBmSWh2YnUrbCtlL2ZLU3JmMEVqbGM5WVZMaTZEbWRvY01vRHA0?=
 =?utf-8?B?TmxyVmxpQnIwSXZZbnI3dU1zTDduK1JaUXVSMDZtNjhxQlBUaHVZTjRCbnRk?=
 =?utf-8?B?WUJFdmltNWxWaWNNOHJaZTIvUEQ1cUlyTG9KY0tURzlXcWVzYUkvOUdjaThN?=
 =?utf-8?B?dFNMMlMvV1d0djZ6VXB0c2xxbmxDa2x6N051VXpsOGRQLzdnU1lmS0cwaitV?=
 =?utf-8?B?TjRqeG1iZTBpOTArRG5HYlBQbEZlVE5LUURMRnc5MUh5aGRrNWJJN0lFZ0Z3?=
 =?utf-8?B?VkZkRE9VV2kzbUxuSTZ1OVlpQU11LzlDRmFzd3o0bzZWL1p0QWJkeTh4RUdj?=
 =?utf-8?B?TC93OXpuODYvOCs5QUhyc08vKytlQlBKMXZGcWhjTXBHM2IxOVp1U0toVCtX?=
 =?utf-8?B?RXhXM25Ka1VHK0tMRzFJdkdiVlBlekk4VENCc0h1UWJMai9TcTErallFaGhu?=
 =?utf-8?B?ZHJMVW15dGV6T2pMT2VrcXZXUkVLZDB4WUdhY3RPMGl6T0VSRE5mWjZPY00v?=
 =?utf-8?B?UnJ4bGNCbVR1bVJqVWxuT05BaWtRVno3aXVmMSs1MEh3alp2QU9pNFYrSXg5?=
 =?utf-8?B?MzErUkNyb2JUOWFWNExHaStKME5EL05IRWsrcHlCRFQxbjNnalhTbkpsNGhK?=
 =?utf-8?B?d3hmZjZRaC9MdndNdmVVQThlWW8vRkdraURjajlRRzJ2WkVsMU4zdTR5MEw5?=
 =?utf-8?B?bjVuSi9qRzJBdk12MWV5dWluQ0gxQkNuN0R5SEw4TGlNOEcwOG9qNFQ0Rk5Y?=
 =?utf-8?B?Y2xiaWZqUTNwV1FBTVM2dFJBL0NJQlNqOGpETUFwemphUXo3VkhWODhWUzZn?=
 =?utf-8?B?anoxeE5HSDFDVWMzbkhyZW00SkNzYXZsb2tpTmZFYms4TEtCRWVES2VzRzdV?=
 =?utf-8?B?REx0bTZTSGVVZjJ0ZVkyQ0RLekZ0RksxMVlwS3BORlZYVlpidFR4cHVSRThN?=
 =?utf-8?B?MFhBcHNoUjhab1V4R1NSRlF3SUxQZHVVN1NobjJ2NUdtS0dYS1hqKzJWalFu?=
 =?utf-8?B?dEhFejdoVkFjVk5rK2pjLzh5RS9ZZ0F4NlJrVHM0eHFyQlM1WksvYVYzZGNZ?=
 =?utf-8?B?OVRCTFhUN21jTEhEd21FYXNSZ01CcVJzNkVneVQxSlRUSTYvU09YdkhhbHVu?=
 =?utf-8?B?Qzk4Z2RKWWFMMGlQUHpOM0dQRG45RWtJZE4zajVHR0Jxb2RSY0kxYmV2SGlD?=
 =?utf-8?B?WW92ZFUwREcrVUUvcmlQbW02RE0rTGkxQ3pwanJKTU1SSkgrT0hLaEJ3dDVD?=
 =?utf-8?B?R2pTdW1vMUNLM09UQnNVNTZJcjFuS1puNmFHaEVuVEVnYVM5NzhTcWswdGlR?=
 =?utf-8?Q?r1E7Vf5M3kfKp3mwsjgWuMB9Xcwh+we6HGeS4aHifwY4/?=
x-ms-exchange-antispam-messagedata-1: z9r02SdKhY6+OZJPn/pXdftpINDAoXqnpL8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AA2C9D29EB817488B16AEA886F71861@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+a4BVre3nHmkCvVO55ONpmA21JtXfzKz3PoCfDMh03nFFYKG94sjFCQEwQn1S6jVedCBem8x48zkit7k8s3WylYJDW9UzTPjtkHRtVsRCSTfa7i956zc+KJNboX3sqXNolmktfQrpChYdxQXnEKAVu3QLF+DU8jQAkt0/1bNKTKAiydwv28yrOfLJTCoceGZITf58VFs5G0kV8yB2VDwWqLuCj6Yi6py3cj79z+ZboVOuxs6fJEhJQuHpS/Dm7Pc6VyBkSJueLmESYQXmvsQ2x8eM8/PTMRe4GSC92ahBqsbVaE2JcUTKkqH8F4/+bqysV5kCWuPgvT5ohgRbqhhaMsPDw5vIbTbYu5JMYEVWbVWHJSrlNgzjWhHGYvoUDzLKYCdCaLObhhrW1SRIPkej27J5LxB7eEmVlQkwWuELGTuy21cQ5o40DMJpgDdGEd02HUSl/JBhjtxVN23wIqwbEzyjaR6NHOk8IN01DbMoXilQQsz3q1RIrPYjS/uTCpZGLHxUQ0ddkTWuOMoHD5+MxUwg5xpQBy9VcerZClMMMaO1GP8mNCpxaltp5OhKJ0l5F0PRs3aim34xZQy29MfaMmsdDpKHdnHMrdfbbBJgqt7BhYS5b2f5WXixCKVfQbi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba50005-a038-48eb-eb80-08de78452e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 10:19:25.9707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdvXl1wZcD/kfiXFqmcO6dxib3lZjOWUrTVa28J7OqXsLC2TaumUkNNbzAiFQSlsFMFi43OY8Np0T1eDLvkUSKSi4YEWyMNwddZUYE0pAW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9332
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[wdc.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22140-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_REJECT(0.00)[wdc.com:s=dkim.wdc.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:-,sharedspace.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_MIXED(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:mid,wdc.com:email,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 9644D1D6773
X-Rspamd-Action: no action

T24gMy8yLzI2IDExOjE3IEFNLCBGaWxpcGUgTWFuYW5hIHdyb3RlOg0KPiBPbiBTdW4sIE1hciAx
LCAyMDI2IGF0IDEyOjE34oCvUE0gU2hpbidpY2hpcm8gS2F3YXNha2kNCj4gPHNoaW5pY2hpcm8u
a2F3YXNha2lAd2RjLmNvbT4gd3JvdGU6DQo+PiBXaGVuIGNyZWF0ZV9zcGFjZV9pbmZvX3N1Yl9n
cm91cCgpIGFsbG9jYXRlcyBlbGVtZW50cyBvZg0KPj4gc3BhY2VfaW5mby0+c3ViX2dyb3VwW10s
IGtvYmplY3RfaW5pdF9hbmRfYWRkKCkgaXMgY2FsbGVkIGZvciBlYWNoDQo+PiBlbGVtZW50IHZp
YSBidHJmc19zeXNmc19hZGRfc3BhY2VfaW5mb190eXBlKCkuIEhvd2V2ZXIsIHdoZW4NCj4+IGNo
ZWNrX3JlbW92aW5nX3NwYWNlX2luZm8oKSBmcmVlcyB0aGVzZSBlbGVtZW50cywgaXQgZG9lcyBu
b3QgY2FsbA0KPj4gYnRyZnNfc3lzZnNfcmVtb3ZlX3NwYWNlX2luZm8oKSBvbiB0aGVtLiBBcyBh
IHJlc3VsdCwga29iamVjdF9wdXQoKSBpcw0KPj4gbm90IGNhbGxlZCBhbmQgdGhlIGFzc29jaWF0
ZWQga29iai0+bmFtZSBvYmplY3RzIGFyZSBsZWFrZWQuDQo+Pg0KPj4gVGhpcyBtZW1vcnkgbGVh
ayBpcyByZXByb2R1Y2VkIGJ5IHJ1bm5pbmcgdGhlIGJsa3Rlc3RzIHRlc3QgY2FzZQ0KPj4gemJk
LzAwOSBvbiBrZXJuZWxzIGJ1aWx0IHdpdGggQ09ORklHX0RFQlVHX0tNRU1MRUFLLiBUaGUga21l
bWxlYWsNCj4+IGZlYXR1cmUgcmVwb3J0cyB0aGUgZm9sbG93aW5nIGVycm9yOg0KPj4NCj4+IHVu
cmVmZXJlbmNlZCBvYmplY3QgMHhmZmZmODg4MTEyODc3ZDQwIChzaXplIDE2KToNCj4+ICAgIGNv
bW0gIm1vdW50IiwgcGlkIDEyNDQsIGppZmZpZXMgNDI5NDk5Njk3Mg0KPj4gICAgaGV4IGR1bXAg
KGZpcnN0IDE2IGJ5dGVzKToNCj4+ICAgICAgNjQgNjEgNzQgNjEgMmQgNzIgNjUgNmMgNmYgNjMg
MDAgYzQgYzYgYTcgY2IgN2YgIGRhdGEtcmVsb2MuLi4uLi4NCj4+ICAgIGJhY2t0cmFjZSAoY3Jj
IDUzZmZkZTRkKToNCj4+ICAgICAgX19rbWFsbG9jX25vZGVfdHJhY2tfY2FsbGVyX25vcHJvZisw
eDYxOS8weDg3MA0KPj4gICAgICBrc3RyZHVwKzB4NDIvMHhjMA0KPj4gICAgICBrb2JqZWN0X3Nl
dF9uYW1lX3ZhcmdzKzB4NDQvMHgxMTANCj4+ICAgICAga29iamVjdF9pbml0X2FuZF9hZGQrMHhj
Zi8weDE1MA0KPj4gICAgICBidHJmc19zeXNmc19hZGRfc3BhY2VfaW5mb190eXBlKzB4ZmMvMHgy
MTAgW2J0cmZzXQ0KPj4gICAgICBjcmVhdGVfc3BhY2VfaW5mb19zdWJfZ3JvdXAuY29uc3Rwcm9w
LjArMHhmYi8weDFiMCBbYnRyZnNdDQo+PiAgICAgIGNyZWF0ZV9zcGFjZV9pbmZvKzB4MjExLzB4
MzIwIFtidHJmc10NCj4+ICAgICAgYnRyZnNfaW5pdF9zcGFjZV9pbmZvKzB4MTVhLzB4MWIwIFti
dHJmc10NCj4+ICAgICAgb3Blbl9jdHJlZSsweDMzYzcvMHg0YTUwIFtidHJmc10NCj4+ICAgICAg
YnRyZnNfZ2V0X3RyZWUuY29sZCsweDlmLzB4MWVlIFtidHJmc10NCj4+ICAgICAgdmZzX2dldF90
cmVlKzB4ODcvMHgyZjANCj4+ICAgICAgdmZzX2NtZF9jcmVhdGUrMHhiZC8weDI4MA0KPj4gICAg
ICBfX2RvX3N5c19mc2NvbmZpZysweDNkZi8weDk5MA0KPj4gICAgICBkb19zeXNjYWxsXzY0KzB4
MTM2LzB4MTU0MA0KPj4gICAgICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ni8w
eDdlDQo+Pg0KPj4gVG8gYXZvaWQgdGhlIGxlYWssIGNhbGwgYnRyZnNfc3lzZnNfcmVtb3ZlX3Nw
YWNlX2luZm8oKSBpbnN0ZWFkIG9mDQo+PiBrZnJlZSgpIGZvciB0aGUgZWxlbWVudHMuDQo+Pg0K
Pj4gRml4ZXM6IGY5MmVlMzFlMDMxYyAoImJ0cmZzOiBpbnRyb2R1Y2UgYnRyZnNfc3BhY2VfaW5m
byBzdWItZ3JvdXAiKQ0KPj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1i
bG9jay9iOTQ4ODg4MS1mMThkLTRmNDctOTFhNS0zYzliZjYzOTU1YTVAd2RjLmNvbS8NCj4+IFNp
Z25lZC1vZmYtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpIDxzaGluaWNoaXJvLmthd2FzYWtpQHdk
Yy5jb20+DQo+PiAtLS0NCj4+ICAgZnMvYnRyZnMvYmxvY2stZ3JvdXAuYyB8IDIgKy0NCj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2ZzL2J0cmZzL2Jsb2NrLWdyb3VwLmMgYi9mcy9idHJmcy9ibG9jay1ncm91cC5j
DQo+PiBpbmRleCBjMjg0ZjQ4Y2ZhZTQuLjM1ZTY1ZTI3N2Y1MyAxMDA2NDQNCj4+IC0tLSBhL2Zz
L2J0cmZzL2Jsb2NrLWdyb3VwLmMNCj4+ICsrKyBiL2ZzL2J0cmZzL2Jsb2NrLWdyb3VwLmMNCj4+
IEBAIC00NTQ4LDcgKzQ1NDgsNyBAQCBzdGF0aWMgdm9pZCBjaGVja19yZW1vdmluZ19zcGFjZV9p
bmZvKHN0cnVjdCBidHJmc19zcGFjZV9pbmZvICpzcGFjZV9pbmZvKQ0KPj4gICAgICAgICAgICAg
ICAgICBmb3IgKGludCBpID0gMDsgaSA8IEJUUkZTX1NQQUNFX0lORk9fU1VCX0dST1VQX01BWDsg
aSsrKSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHNwYWNlX2luZm8tPnN1Yl9n
cm91cFtpXSkgew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2hlY2tfcmVt
b3Zpbmdfc3BhY2VfaW5mbyhzcGFjZV9pbmZvLT5zdWJfZ3JvdXBbaV0pOw0KPj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBrZnJlZShzcGFjZV9pbmZvLT5zdWJfZ3JvdXBbaV0pOw0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBidHJmc19zeXNmc19yZW1vdmVfc3Bh
Y2VfaW5mbyhzcGFjZV9pbmZvLT5zdWJfZ3JvdXBbaV0pOw0KPiBUaGlzIGRvZXNuJ3QgZmVlbCBy
aWdodC4NCj4NCj4gVGhlIGtmcmVlKCkgc2hvdWxkIHN0aWxsIGJlIHRoZXJlLCB3ZSBqdXN0IG5l
ZWQgdG8gY2FsbA0KPiBidHJmc19zeXNmc19yZW1vdmVfc3BhY2VfaW5mbygpIGJlZm9yZSB0aGUg
a2ZyZWUuDQo+IE90aGVyd2lzZSBob3cgZG8geW91IHJlbGVhc2UgdGhlIG1lbW9yeSBmb3IgdGhl
IHN1YiBncm91cCB3ZSBhbGxvY2F0ZWQNCj4gd2l0aCBremFsbG9jX29iaigpIGluIGNyZWF0ZV9z
cGFjZV9pbmZvX3N1Yl9ncm91cCgpPw0KTm8sIEkgdGhvdWdodCBzbyBhcyB3ZWxsLCBidXQgdGhl
biBTaGluJ2ljaGlybyB0b2xkIG1lIGhlIGRpZCB0aGF0IHRvbywgDQpidXQgdGhlbiBLQVNBTiBj
b21wbGFpbnMgYWJvdXQgYSBkb3VibGUtZnJlZS4NCg==


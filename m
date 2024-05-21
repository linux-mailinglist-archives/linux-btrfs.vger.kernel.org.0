Return-Path: <linux-btrfs+bounces-5151-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE7B8CAC6B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 12:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860CC282513
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 10:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5DD73186;
	Tue, 21 May 2024 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LTgaGucD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EoYhzH7o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8256CDD5;
	Tue, 21 May 2024 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716288202; cv=fail; b=MKPb3juvLY2HhUU7puJhi7YcaR0XULlxy65AG2QH/Rzs0UvPA8UJq84mtmGRNyPvBM7VpNWbQX1Krd6+trCT56m4eHYj8dWiwUk1OtUfzMY+3iFyo5NiCZMOVO1jHviDO+svcy/W/VT2QHshsNhqjSQCLIa1zAkngd3RRbYZIBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716288202; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aII9zu0na9yxKrL1g2bssHYTPlu4rHuu+PIQzR1TDxzRLz5pCaHP+H+a6r6I7eT/NDdKCbxJz6FPV/Lxbjp6iF1PoYo0FQpgy9hF76AA72FmsRqpozkJryfknNpscaeTBg1UQuZXm+Th0My9F3cdnTIo+lGg5XnIiTpv+jcCEdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LTgaGucD; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=EoYhzH7o; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716288201; x=1747824201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=LTgaGucD9JBQs5A6RXV9/l4QmCIHu3yvH/OlZC3542kTx9byQA9I/PX7
   myGK3hKA12sJNOfG0QRFun7OXc83VIxOOwGgii3g/hVADTdBnR28V+IHg
   ++LNisM38Yt20ztpIgiYkmQaX9HSlIxox8yUt5/YCGmexU2rB7EsbnUrz
   cWKQdHmSy/gY1iPwwMZICG97nYHhYPNJtwiWQmCuLIvWG7r9LevhP0KHH
   3INocL+9If4oHDe/2wnZernpXXnUPN2lnvicCHF0dKl6Pp5fLHdAT9C/R
   NQHwgBJprAyDMqiitRvb5alAENDBMUXN4WsXc3QXFa6/S8VCVF+OmHj3G
   Q==;
X-CSE-ConnectionGUID: xN479A4fQA2LG6pjUN/suQ==
X-CSE-MsgGUID: h1rczoa3QMWPiu3hkRjdJA==
X-IronPort-AV: E=Sophos;i="6.08,177,1712592000"; 
   d="scan'208";a="16583361"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2024 18:43:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrm45eUOMJWo1bzCuxwvw9ujCcqoQpDTI7txISGyhOQeSLKBvOu+dIV9iG8J22odRXK1bXllyNKrwZwu1NvMawAJcCGVRCVGbv8xS5HVFnTk48Di8AkIEZIYUrz5UXKd9YEb8XLlcktJvGld7KDAWeGmixvPSUrIaTCZDqQy0VBkE6xGy7sKubgc/LuV9PUSKwH4KyCcWDlyicXlAgf4g10So+drn6RH/IHFNApxwetzkSN1IJna829gkhy6xeeEv260tLmYO4M19WAZNf1F6gCshg6cEbFBgLb0Kyp1+c8RYWwjOFv/5mlnv9KIuU4Ia+av0lUKOHkoXsTLW5J5Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=XeAJLjELmXHwHEb4KS4CpgjUmuseOYDjafGspuX0pS+mPOSUwMPBaGVU78sS2nUzMTzfYuBKB1pGl7V9XDMkz0gkZn2nmTaXJrf5y2ugURtudCca61sBajTffoaB/WDiuDL1y857yNOUmxtTEkBO+D16KWYBhF4v3GdFhP+HzT5Py23WomDcn0rB1ysinwTAb3M/CwM3L1qG0BI68X8Wyu/dSKlM6V9kh1UtgdS5Ufw9N2+wRJLZBwsKM7J2RghJgUYFlDKcQV1chPf/WgftE6GpAUKW1hjf8S2w3Iew90dCY7I8tThIJoLlMXr7ZB7XicsMYl2QFrHUgV2STbkiKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=EoYhzH7orlh8RA48nEywKATj6/UE0GWPOY3rg4lSDzqqkAW5ADHaglLw5GDjK7PBjbWS1lrHI/AA+IWEl+FOzhmpuUQV/cK874KhVzjrj9zLWxprnkz4lPtJH2CTLF9DnG3+JMMyiP0A6Y9eKibg9dxoHE6+gu2bJ5oPVtjrVDU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8681.namprd04.prod.outlook.com (2603:10b6:510:24c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 10:43:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 10:43:17 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Lennart Poettering <lennart@poettering.net>, Jiri Slaby <jslaby@suse.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] btrfs: re-introduce 'norecovery' mount option
Thread-Topic: [PATCH] btrfs: re-introduce 'norecovery' mount option
Thread-Index: AQHaq2VXdr3sAFUv/kCso+4vJGOKXLGhgJaA
Date: Tue, 21 May 2024 10:43:17 +0000
Message-ID: <57c63f57-fde4-4bd6-a556-c476e122a547@wdc.com>
References:
 <44c367eab0f3fbac9567f40da7b274f2125346f3.1716285322.git.wqu@suse.com>
In-Reply-To:
 <44c367eab0f3fbac9567f40da7b274f2125346f3.1716285322.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8681:EE_
x-ms-office365-filtering-correlation-id: f3e9e898-6805-4712-d62f-08dc7982d340
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?WjdqNGpUM29FUDM1VmhTYWhpb3JOcnhRNHFnczZDVDdxUzVSNDhnRmdJV0Np?=
 =?utf-8?B?SWpLeElhOElFSnR5WCtGSkU2alQ4bEoybzgxekRtblF4cFlHY2tTbUxnejI5?=
 =?utf-8?B?MFpsbjc0cEpldHFaZ3ltZmZ2UEExcm9VcHdhM2tqZlllT0x3aFhwcHF1LzQv?=
 =?utf-8?B?T0JnM3o2VEtCRE8vMmcyU2tQQWROTEFlSk5RcHJGUUVjdEkyWTNkVXJYVkNI?=
 =?utf-8?B?Y2RJRXZOMm56VmNCV1M0UmpySHl4NmZ6N2xmUm9DUDhSaTBhZHJsb0ozOEFs?=
 =?utf-8?B?NHptdkJBaG1FYmg4M0ZaR2FkcWFOOFFVOW9sQlRHUHNFT2F4cDZqSXJ1Y05L?=
 =?utf-8?B?Q3pEQXdvc1duSXlFMkVmSGphSDRtMHFUWkNXUm1hNmZqV2NNZ3A0dXd0ZDRJ?=
 =?utf-8?B?TzVBNG5OQldGclFxRkFpeGFFWnAwdkUyTkhqdnVPVGFSYWRhREluWjBwU0hM?=
 =?utf-8?B?cnc4U2kvQU5xOGxhbkZtcDBoeWQrWTZDbHFLVU5zV0d3eHljUm8yc2NudWsy?=
 =?utf-8?B?OWNFQjZQcTlHdkpXdkR5UVdGbGwyZEsrZFZiRWxxcXVxWGdiN3BPWmEwYkxx?=
 =?utf-8?B?NzQ1NldRdVp1RE4yVHcxNlNCbVpiVjdQNnk5M05Ic2lMeTBFS0VJeEtUVDh3?=
 =?utf-8?B?NlpSbUFyd0F6cGFEU0NiUW5jbmFkY3pIc2EwTUUzZTU4NWJmTFRPS2MrTGpr?=
 =?utf-8?B?RkFkYytTSHlDWnBvNUY4Yk5CT3ZHL1lOcGQzWW5jREVYY1d0M29FTm1zNSts?=
 =?utf-8?B?dXdWdGdpbUJiWk1sbmdVTTBBWlNmczBzeWl1bkZza0crSTlLeGRiVlVuN3Y0?=
 =?utf-8?B?U2xFVnFiV3VRai9pM1daR0xIWXIvYjBkb0piNUlqUzRrNVMvYVIxWWNYOHNS?=
 =?utf-8?B?RityQW9MY01ZaXJkVjJPSWhzRmt2REF3UHhpNDdwdmRla25ZUTFVNmdmWnFj?=
 =?utf-8?B?ZktCbDhMb2J3ZnhrU3hVM3RnWHJlZjIvQ0Q1NVdDTmpESUd2SVRlMm5zMEoz?=
 =?utf-8?B?WWMyMnk0QVJSRGFCN1E5NXl1SzFUMkZydG8zYTJpQndVZFVXelo2eFNnZXp3?=
 =?utf-8?B?V3RPWTZrdVBtTmNBVzdVRk5lcGp0NDVWVmZmR1VsMHZGSVVyQk9GRjB6aCtk?=
 =?utf-8?B?bE9KeXFnMFNZNFg4bVpYdjhPVUY5WW5KU3hSZUxuZHpkTFBxQW1RMDhRUE1S?=
 =?utf-8?B?QkNOdzFWTnZuaEhqTVgyMitPVGo1YzRzNERoMHN1dlhnaDhXcFhNb3Z4Visz?=
 =?utf-8?B?OUd5bzh4bno1enllZTRaYzk3cy9BRk1lOHUvVFlZS0JkNDNvaTJBRXdBd0dO?=
 =?utf-8?B?WE9qejZVUktTem0zNXY1V1g4NGFlMUcvUW9rTlg5MGVrYVQxSmlmK2IyOFBo?=
 =?utf-8?B?b0Y1NjBoMUdwVVhJL0h1TW1VUjBKQ0FjNUtMVk04dW1wU2ZaaUdVSmFMaTJp?=
 =?utf-8?B?YTBNOFczcUIrTGlQVlhBUTdPQllBaTBuQ3h5dlhNUjVYNlZNQWhBQnFlYkFM?=
 =?utf-8?B?TU9NNEd3aEJoRGRCdGR2emRlTC9BSXliU2lXZGYwTkFkNFppeE95WjZ1bDRI?=
 =?utf-8?B?b1JscGkrZStxRGg1SmRPMjBLVEludHpzSnhsN1NZVDlLL1VLMU9VaVRrNm9r?=
 =?utf-8?B?d1gxZ2txRXJhMlgwd0pTNHUrQjZiQ2VoeWR3cmZTYUtSUjlMRGRVUWF0MjRk?=
 =?utf-8?B?b0gzbXVMamZQendjYXR3aEZPbStIT2FabEVOaE4zZElhZWhYSVBMOGVXK3Uy?=
 =?utf-8?B?UVZBVjF6dzFDUFpZSU5wVXhtTytNcFFFQ3NZQUw2dzR3Y285UnpSbHNUaTZy?=
 =?utf-8?B?Q1lVemdEdkY2bHJXUHRDdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MTJDSDRhUUh6bDhDSy9oYm85dGlrNE95NWdyNjVOa0RnOFJicGZTQm9QcGVT?=
 =?utf-8?B?ekROU0pPS3JNbExtVkYyb1hvWjRiQUhFUjRLeTVLaDVYaTl2cmlzTzFUUlY5?=
 =?utf-8?B?SHZ3NEJIQk1zUWttdmxlbG0vM1Nac2tSM1JsYzYwSFlOTWFWMStRQWExMFY1?=
 =?utf-8?B?a3lkS3RKOEFyL2xYYzI5bnVsL2lVVlEreGFKeTFKY2RGSHp3MGVPK1NyYnAx?=
 =?utf-8?B?bVV5VUdhWkVENnJ1Z2VXWWp3aWVsVGl4T3FvTitsS3U5RW1LYklVN3pmK08w?=
 =?utf-8?B?KzFnSWtLc2dYOGxCMWFWKzhIZlQ1NHp3UzhhcXZycVU4bVVkMm5wdjdTb2M0?=
 =?utf-8?B?TExKd2ZDSTROd0l0OU1KTEhMeGpRemtuUUtweFo3MmZLRCtXa1Z2Y0pGR3Jl?=
 =?utf-8?B?cU94SE1BWWV1NlMzZjlrQTFEN3I0RThzTmsxK29tekt5KzFKbDI4dlRYK2hE?=
 =?utf-8?B?c1ZBMVUxOXoxbG45aW44OHNEN1cxbnQ2Y2ROV3NTT0tXdVVYcWQ1R3h1Zlh0?=
 =?utf-8?B?SnNtK04vZWhwOHk3ZUs2cURpbmZzSk5EWFB2V0QvZHkwVjJ3WVpOWDQvQVdl?=
 =?utf-8?B?Z2Y1M3R3emRQdVdxSmxQZ0k5cWFIWDVQaVRGUXVrc25hazh1ZmxsbTI2T3BY?=
 =?utf-8?B?T043MEx6eWZwMWowRWxYejVlZVlXckZBdUdiT3hVWWlmeXBmNlY3dEczQm5h?=
 =?utf-8?B?VXVXdVFOZHhyYkhYb0Fha2ZXSHBqWnFUSlZQQk5telE3UUduYnd1YzhNcjVi?=
 =?utf-8?B?WmZieG1RZkxXelB4MFgwdVlkbzJFSnRSVGtRTTVaZlBOa3VjYUEwdWRobUsr?=
 =?utf-8?B?SVlrelNVSmJQSnAydUJveCs1ME1QTXhoeUJYVG44WUEyRjEzVVpjZDJSKzFt?=
 =?utf-8?B?M2ZkZjcxbnhNMllab3o2S1ErdFB1OE9yZ2dObFlzYlRzeklEOWp5dHptTzB6?=
 =?utf-8?B?bVJkeUtuMnNBaWdVTW53TW1JVHl2OE9IMHNtdGo0d1RhcjJFVlhRRlNQZmpW?=
 =?utf-8?B?TkY0blY1UkJFbFhNSFFLaE44azJJVGxnbzdBU3dMbGFnMmdIMWEydWxtS3lF?=
 =?utf-8?B?cnpYM2dydTMxRy8ycmdrY1hlenFWdnlTRld4S0pjSHpuVGo5QklvSUM5bXh2?=
 =?utf-8?B?S28wN2VYbDB5Z0d4cjhvMnc5ZjBaRHJYclE0WldXVlFnVDdkYnFIb0pTcFo3?=
 =?utf-8?B?ZFVySjkvRFZvSTk2Tzd1azNFNVdMcXNURG9kRlZmVVdDRUdBYUV2alJsbEs1?=
 =?utf-8?B?eTZzb255VVIzamFwK3B4TGdyakRQL1BhQUNENGM0TC9FTld0OVpOWDQ1SC9s?=
 =?utf-8?B?YTJsL2tFZjlyMVljdWJkeXdZWWJyWHByZERJSDlNTDBZNGROTHoxRFZ5WnhB?=
 =?utf-8?B?ck9ucytsRHpnMThHcGhUaEEybHhqNGl2RTZLdlBNZWxFcFJTU0VvSDJ4eVlu?=
 =?utf-8?B?NjNkRHRBQWNodkk3VHBLSStkZEhINU4zeDh3eDUyZGRrVEkxbW9aMWxyQXlB?=
 =?utf-8?B?VlF0M2NiM1dOL0dvMUpZRUphSlp4SUlCeXJwWlViTFgyeUt0dkh6Unpia0hW?=
 =?utf-8?B?OCtxYkdvekE4U1QyRk53TXVOK3F0S2doM29XMlpzRXRsZ3Z6QytCdTNISHE0?=
 =?utf-8?B?T0xiWGpVRG15NVRyVGZsQldpZ3RlR3hHelhyZ2J1dnpZazhQSGdudE9qREp4?=
 =?utf-8?B?RERab2NZa0xDQzRvUnRoeGtaSkJJZS9uQmhpSGQwdkRrNDlCamdtMVFVaWJZ?=
 =?utf-8?B?bVFDTzFVbFprY1l5NEhuNk01RU5ISTM2ZHAvWHYzeWFwSXNqdFhqMnBia3Qr?=
 =?utf-8?B?dGVZRXVKSzQrSktiWldOQlY5amxzY3VyVEFCL1o3YkFlZzU4NjY3V2xBR01L?=
 =?utf-8?B?eXlLQ2J3MWcwbEF5S2I5LzlGc25ueFd3U3EwbXFGK1Rsd2Uwb1pWNk1QdXl3?=
 =?utf-8?B?YXlrZzJ5WkJNVlpWVjROS213d2Z1WC8xSWRNV3RrZ252dEFkZFNsTWgwSkNG?=
 =?utf-8?B?Y0E2cEVobWtWZ0FDaWwvaVNUSkZBdXllN0doQU0vTXJmRFhvSWg4MU1HdXhL?=
 =?utf-8?B?eUE0OTJ0WVpJQTBJS21MdEgzQkdzMjFUeVdKUHpPMWhoaHJEaFIyM3Q0K0RU?=
 =?utf-8?B?S2pDNEJqUFo2cnhmbHpFZ0haY2lEazk3YmVubnk3MjdwVjJrbXBpdVZmcG5V?=
 =?utf-8?B?RTRvdXF2cnJ1VHBPaTN0bVI0UlFLMWpreGg2ZE8vdC8zUGVLSGU4T0d1cWJr?=
 =?utf-8?B?YUh6MWk2a1NjbnlVSTZJWUhkVzBRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9DF6D72D064CD4CB6780CDA15634E2C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mk6anEXvLjNmgIjUNe9xlZsRVtDkJvzy4XdWD9FSVznfODjGYu55ajI5jfGJ4eEyBhhQ5RqYqpGh75tm4hsY225B43NnXVSR4dEvS2dUy5aA9dXS++XNpju17/lVQCw8f1rOCD0GPUZ0oQNX6ik6qhrpFhCxYdMbk+hEGhxemdg+u5no/39A11ZBbtZ5hHFabq5gkzasOv7zKD1vNLcaIOt6cCA39yO89e6bHkIEasNnTT+5vBFuCmPk4EMv0PR2iM8VAtsEMHBrrzbJ3Ggrz+xVnu8pXQeAGuPhb5FhFpb6ktGlbND5FongpCo85xnLDwqhfpDCu2t6C2qX3YzLDRfYcIL3AQ3Es/LVDXPrTWjqGXss/f9GG+RAzAvqX6NpyguUJ6M8oy7r9cUs8VDPk5IInv42FJZF1/shp452tymuEyrQd3ZCMuXS0YbpzOEMKOsQ4teeFX3aHnoTBjv8i2SJrM/s3MIQKRhYx+36TTp52rXQPydZz7itRd/T8lbFQRzYh344JMnw6bUoMaXvX9Cvhu2g2/iRf1PHm1K/28ySN7SRKHPx/j3Wx/I/sJqoCP3GXnoMS5E9IGJ74cC3g+FbR6b/aqxHkpxGvvk3xfRgTRB8tQuVHyEJOVx3FAoT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e9e898-6805-4712-d62f-08dc7982d340
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 10:43:17.6326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jeJNiGkDNi1RcOvhEmtlTSxDtDZlUwWkTu6dPv5I8zrIZG3J2sBTveE+mBsCrH+MKl9nwJTPjcW89v2LXZ6l6b0j54ifE0KNMyW0urH1y1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8681

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K


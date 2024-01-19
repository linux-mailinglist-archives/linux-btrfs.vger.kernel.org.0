Return-Path: <linux-btrfs+bounces-1571-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5825D832C5E
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 16:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF89828369E
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 15:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED7854BC1;
	Fri, 19 Jan 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r6N8tGMz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="l93gw4nE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC5954736
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jan 2024 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705678164; cv=fail; b=c65rov7/pk0abS8LmW0XqdalJ77K15GM6g/jqBoQrnl6PkSh6k/ITc/OSYcgXI5ZIYjQUFTEKQOSxXosMELiFLtO+OJqweoBKR3i/fK0MxkphMnwhsDL5iiX/ohWOTEsghDxOsPy+M/pncIUZMUb8zXw9taD1V2ihXXJhC6lbjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705678164; c=relaxed/simple;
	bh=rsbjo2VCwXGf0gPyKxUF3UPhIbVjjbRs1o7wiXiDRiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B5e1wfxoYuZVHffxVDFr7Qj0mnEqLvJVhE8bC7/VqITXdWpqBpZ6n1Z6hdAhpcCO5gImSPeA8T8bywKQkcIxt6p36oS2DIcE478piEA17XVlQCiierO3FioDEMzKn7M2EWcF+MhNrPonBTP1HvQcL7C/RSG68m8bMKTt2rczP6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=r6N8tGMz; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=l93gw4nE; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705678162; x=1737214162;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rsbjo2VCwXGf0gPyKxUF3UPhIbVjjbRs1o7wiXiDRiA=;
  b=r6N8tGMzXc1FqHKeRl7SZnJM2gCw+3uPCd6Z3CdFKIIjOh9c7r0t9+AG
   HjhP1T97rRNTWMC8VWzfhPTLpJ4QY6A2FZk9U5iWQhsl8AjSPFzjINVdU
   5pNuDI2EbbjTJo6lsbumqJgXCAnTXSgzrPE5aBAZcPC3FkRvlEXdtcg5G
   JNHlEDDhKzPy4tE0NbrI+5ZgY8Xzos4xi39oX4z1Zm/+2bjiRPlZJPjSM
   nXBeI93BbQkGTnU+zSHG9cs+kYO3StcxFtCqpVR2CNhKzlIe8I6BuiRf4
   PEEgErJ0plj7uNpH7HPBHvgGPYdB4emVHoycJuZs3z/6geMF+wTLz1jTo
   A==;
X-CSE-ConnectionGUID: ZZuS4+yEQfS1vZZXgPMCQQ==
X-CSE-MsgGUID: pKn0ypNcT6WTNIrAQTIVew==
X-IronPort-AV: E=Sophos;i="6.05,204,1701100800"; 
   d="scan'208";a="7359778"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2024 23:29:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmWcIbjjBTZQRGeVzzlc4KG2x6BxYB/3/24pFJW8suSikpj+ND9JoeUgX23XMKl5Ju8sqbvhNAg4uSySeXzOYmloExvVTaDqrAwOOz9qrwG5swAEtypCsUDCChId4qfayIuLy42Cf3Enc09t9TvQypIx7CuZiVBtIb9SKfxL+0YiP2gT7H6himsGsJX4okwthORe0dsZIIV2k30hxjcy31d0kjcMyFS2iHY/Wa0We70xCzjL330dbDWaNUSqZ7nCI8sZoOtqFfhqBmRQY12aqvSgR4ePeEn0eFNtfi2RPaRHX7f6ABuub/zSVCyPfapyBesOLUTXtMLOTjRWjkUKqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsbjo2VCwXGf0gPyKxUF3UPhIbVjjbRs1o7wiXiDRiA=;
 b=SoZ7HbhP8DUtg5cfFWyTNDoSU+5vUCtDm/EzSVp46mMYlUesxVlQ/+F4Sz+Yzm5eBEwL2suHy17FSKRjL2dFeaGkuGPgYz/ycTR1fabnV2MCoVliNTEMC8BxolPmCL0ftx85ATox9miEv6h9gxKpnwS59M3yavGdC7uiEH/pY/wipjcDPJJkuAqo6oo1ZLMc8YitxE/zwyYFZS0/fsdNuDEyYjK+s95jcFDNHaa+i31P7bHTziCvzUFtzYGFE4LMxC5iWV+j8WYTlKIDQnXLQo3hWHSn9pKROEGQUcMaltchULn0tGHe02LYUlzH32mH04e6/dXaPR+6+nbc5RQHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsbjo2VCwXGf0gPyKxUF3UPhIbVjjbRs1o7wiXiDRiA=;
 b=l93gw4nE89zhcT90bu5VTpVfjcng7FyyufGKt3MPUEBvQLHP9q4Jg/o73Jc9FeiK6i4hSyDeBmc8vkXR4sRra1xmKY0fnmjdH8yx8V8E+yXRwRWNCFRKftzMvQjU6Asc1MRIM9gyCP8Xe07HAu5+8LMqByWGGCQUDFLADAj/kA0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6384.namprd04.prod.outlook.com (2603:10b6:208:1b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 15:29:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35%3]) with mapi id 15.20.7202.026; Fri, 19 Jan 2024
 15:29:13 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "wangyugui@e16-tech.com" <wangyugui@e16-tech.com>
Subject: Re: [PATCH 2/2] btrfs: detect multi-dev stripe and disable automatic
 inline checksum
Thread-Topic: [PATCH 2/2] btrfs: detect multi-dev stripe and disable automatic
 inline checksum
Thread-Index: AQHaSewkBYn66+mlqUW7kt3xaMVKG7DhRKqA
Date: Fri, 19 Jan 2024 15:29:13 +0000
Message-ID: <fb44aa48-fd5d-4b3b-ae87-2ad0d9648b44@wdc.com>
References: <cover.1705568050.git.naohiro.aota@wdc.com>
 <7ce85c808b96be3c8352ffa03fedbaacf0dc6d27.1705568050.git.naohiro.aota@wdc.com>
In-Reply-To:
 <7ce85c808b96be3c8352ffa03fedbaacf0dc6d27.1705568050.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6384:EE_
x-ms-office365-filtering-correlation-id: b51f2b49-09fe-4140-a5fe-08dc19036414
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aefVskSse6UkQMVsLCX8Oy4yIG89RUxJxHVO0MGpfoPnY0mUtDR7p9fccVcrbCDDTEmHPnj7huH5QhPj7SyTjwTkRVwiHw8iOmlRmKiUyQWmU8CDY5Q/wNrg1gKUhDaUfOoIX+y8WFZI8rk1l3lLteYMtFBPPyecMQJRiin3V+VEyClROrcKADFM4UAKoUf1KMVr7Ros8eKKVj7pY6cI96kAVRi4uJ5km0WIHapuw5FQAUxaeBMFML+qP+vIrUQnPRX348aFiB89bSLMuqBpgfuRhH7ZqGAs10zOmPCxX7Vrqt8FR7BE4SC8PjOPefNqkKSwKQqHvqU6vSs4uXG/ihqOoTUwtMyqBBIST34/dT0Z1ivXDRrH6ZeOmZxhToC80GMR/9cOW7N5Lze9zVefNVCSWFkfPWGcXDJ+9iDREtxMH7a9N2sFtWJsPJJN+9YI3qlPYu4CCUeun6BZFj1Dir0lmfi4B2CQOnrM2bf/7Fc02scci8awb1I+32lbqrWYxp9eVlL/vh4STYIun+0y8Q08x6z4K+QsckVvvbe727pDWN7LvJ+PiFvrPxRbjJtX2cIuChsyGSIei6a8OB5c17FtYPGCRFErNX2LfuwY1UolsJebxxVZ8mZUl4z65gN1rw/me+eoExk6CYrl367pNAoCVZG3Dc8R4fPUkAH/V6rZYGlko5kDQJwgrhkoqM3h
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(41300700001)(6512007)(26005)(83380400001)(2616005)(31696002)(38070700009)(86362001)(36756003)(82960400001)(8676002)(4326008)(5660300002)(91956017)(8936002)(6506007)(122000001)(38100700002)(76116006)(66556008)(66946007)(64756008)(66446008)(6486002)(316002)(53546011)(4744005)(66476007)(478600001)(71200400001)(2906002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1VlUVErb1hRRUF6TEIvZUNhUHJIQWdKUWxzeVlSTXFRcGJ2Vmt2ZlJ0dGxz?=
 =?utf-8?B?eE4rZ2FtZjZ0YmMwdUxoRkwxcHo5TWVzWDQwQURibXRUa2FzVWF1QWxsczcr?=
 =?utf-8?B?bmRGWk9GbzdKSmRGMmV4a1JrUURGSllrQmdIejdEOHBrcHY5WUNYaTd1UjNK?=
 =?utf-8?B?UzR1dXFvSmFYNDA1NHUwQ0tlczdzZnFMV01CWWJHd0kwZnF6YXE0ME5uRmF3?=
 =?utf-8?B?Rkl4Nmx2bld3dlljb2xXSmlySXlmU3Y5NEpvSFdRV1NyWHRseUtiY0FuS1FF?=
 =?utf-8?B?YUVwV21SOS9GUGZVY09DVm01VmkxcWJwWnFsN1F6V214TmpTYks2NUhDQnhl?=
 =?utf-8?B?cGFxeHRVblE5WHN2TFVESHBXNlJSaWh2eXpyeHlsRS8vZmZ1K3l1aG5CWDZO?=
 =?utf-8?B?aW1SYnY5RlVadkhJSXlIbERkZkVQMktGOXcxTTExUk5hTlJmMzdKRzhWNk16?=
 =?utf-8?B?MUJya0V3Z3diMGpyR1lST2tpT25OZTZEMVdMZTNqcVprSDllakJpUUhBVUpP?=
 =?utf-8?B?emFsWU5pYm1IVlVhb2RiNnIrc0hXb0pXUUpPK2FyV3hnYmpyc2hKQ0RPVDFS?=
 =?utf-8?B?c2Q0MEhCVnlIMStuSVlYZTF3eWRoQlF2U2N2UitNY1JRbEhBcjhYNHdnR2c3?=
 =?utf-8?B?U0xtQ1FsWFZWV2o3TWtxcWZMVSs5enMyaVJwamdDY2xmZGdzRWp1NTcwU2th?=
 =?utf-8?B?c1RXY1lIRmRWQlBFcjEvVWhzMng4YysvOStGZ1pQdzh0TW1STllWeVRsNkhK?=
 =?utf-8?B?WXdRSkEvWmJBSTFrTEZkY25iQ3VOR21TYUprWkhBdWVEd01uYzNmUno4Qlcz?=
 =?utf-8?B?bHYxZXVITnJRWDE4K2R6eHdTU2hEbDROemJUakxBWnVNekFTNS9weXM5Z2RH?=
 =?utf-8?B?dWtOYUNya0ZOek1qVXNEMXBJOXJtbTkwcEh5VUJWcU1pSS85Rkk0RlplcTdu?=
 =?utf-8?B?R3dWVUlwMU1Ld1ZOOWRRNU1TZzBBRUR2ZisxVkVuZlBCRGhBT09xb2ZxWnFL?=
 =?utf-8?B?OCt2azdGbGFyK3dQd0x2ekpUenNCR2hKdHpiWHFhNUJqMlBTMk13RTgxczBt?=
 =?utf-8?B?UWdEekgzUStWN0t6TGpsWnhpOFJ0b3JWaWR3OVpuaVVDSkdIdjNYVFZlNmVC?=
 =?utf-8?B?Q0hDWTQvQWR1dEl3SDIvUGRuNUpKOU9BWHhHV2R2YzFabE5GQ0ZEYlpYVTJN?=
 =?utf-8?B?ZjE1d0JBVkFMajh3cURtWERiMlJtZ3QzeCsvTjE3MVVkWUg3KzJHcVcxbnE2?=
 =?utf-8?B?TkpuNFNKNWQrSXVkM0x1VUdWem14MDNMOFk1ckU4cmlyU0FiczhBSGpuYW8v?=
 =?utf-8?B?TFdoRHp4dXExMHZhY2Z2T202ak93eXcrV2JLeEJHRVB4L0hELzhycEZGcWo0?=
 =?utf-8?B?cnNscWVkY3dISGQxeGJkdVIzV0lWdjhxOTQ1dHhMb0NISlBoSEY1V0VVdk5X?=
 =?utf-8?B?TjZqK0pBR1JXWFFaeHNGSnhweXk3SU9vdDdGQjgyOHpEV1BZNnM0U1B0SzNq?=
 =?utf-8?B?NU0yUTRIS1RCSTRYKys3UW1QNzFKYlNMSGYyNWNlS0lQd3ArNWs5d2MvTXdG?=
 =?utf-8?B?K2E2eHhRd0x3WDZMbUN3dDV0WDBRbXVLODNkZjJua0JYMTYybHkybzVIN1VN?=
 =?utf-8?B?eGJ3MmdNYUJxNHhmUGhWN0JnSjRRSXNIYzYrUVZrNTYrckx5WlcvK1hvMUNP?=
 =?utf-8?B?R3pPaklqZTdIaWtnVFRYQlFXU2RpWUN1ZXB0Z2Z3VnROeVRiaWNoQUhFdGlF?=
 =?utf-8?B?cERPMTQrY2NtazlXODhOc3ZoNHhFTkdJbVBDaXovVThybkpta0NVSjAyblFs?=
 =?utf-8?B?Y2kraWZ4Y2NOcGJIN0hxOVVjNkovVDZGcXgrTll1ZE1FNFV4Ui9ORW1XSGRh?=
 =?utf-8?B?UmhpcDgyazBZOFZPSXRjYlVhLzFndFJWOG0rWUJsM0Z6NkFOV1lpMmpVam1B?=
 =?utf-8?B?eVlpWTA0UFFIc1hHcTRJNHdRRGVGVDM4SmNQcHY0Q0c1MlJGZnZyVkpYSmJY?=
 =?utf-8?B?ck94V1h2RUgyTXdVb3lOeFJ5UG5XUVFUZSt0bldVNXROVHd0U0kwNkc1ZzFP?=
 =?utf-8?B?V1QxM2JWNERSbVE1a053UGVHc0xna1BPYTI3VzJFejhGVGphZWdiQ0djUVRP?=
 =?utf-8?B?N2I4Si9TSTZNWXdCREllYWp3M0QvZ3Z5cTMvMzNLdGN4cVQyejVwVTNET0lo?=
 =?utf-8?B?TGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5293AACCA177864CB0F0504D5E92C5AC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uTBWMqQkdK+fGvei+Lk8Mxci8m2FS/elIUaTJh6EUKrbZib3lGObBVfk5+OPKwrk/PSjeLwiTNRiHy8NAyj/8UoVqLkgUkLYPSQInlJsreL8RAvRCSGHLnOutcjy5VB/TVTGr8iSp2zlltVN7GYpwovNWm3nydPfIEtt6jufoS34CRvyVGmGphWgW5mDpD2vNj9FHLxa2iLFe0NOaySyEvAuhetLd7YjNUP/bY+8dO/OiwO9ymo+ZGMG+aO6J3/rUK6k5K6F2dn0C8TFg2mfWogMD7GAZFWNVNeUHa/u6b6EiSKd1Nx4H0EvPL2L1vexM+1ALhoYpMYGxcUN1ZLoP/xWmWAFTLoVnyFUsKyO3eHPZOpx6AoQ+UrAkczLN3SKv7Hk12/Ag3qTp5jEmIGIYdnjCqCWDqwvgQNXlvJ//9i5gyiTlPF00+cs1F5TpRWecASkl6tExyAFQ1+UuKaoti5HjsI5RBxbtgGkquhyI43uMKKnNvjEk6WSd/8jQPz9ITI06qOTT0Ud7BtS2EFIXQlt+6Lf9jruI5NRlBKQD/2dws6xHYO1Yj2u0Go0cUpW6AP0NtHvzDZHiqXWgWtO78thazgC+rkShQC/BVd9tSBLs/FwlgJ8rA3RYKNqJT/u
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51f2b49-09fe-4140-a5fe-08dc19036414
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 15:29:13.4188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QtJN4SuNEEprqsV0m5pLevaJlb7J0b7yTeQbF1G9WZLmg/2ijsg1DcSD90ktpk9fyd2YYozE2E4v975puU/GK4cjD6zU8nlMTz+F08SXQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6384

T24gMTguMDEuMjQgMDk6NTUsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gK3N0YXRpYyB2b2lkIGNo
ZWNrX3N0cmlwZWRfYmxvY2tfZ3JvdXAoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmluZm8sIHU2NCB0
eXBlLCBpbnQgbnVtX3N0cmlwZXMpDQo+ICt7DQo+ICsJaWYgKGJ0cmZzX3JhaWRfYXJyYXlbYnRy
ZnNfYmdfZmxhZ3NfdG9fcmFpZF9pbmRleCh0eXBlKV0uZGV2c19tYXggIT0gMCB8fA0KPiArCSAg
ICBudW1fc3RyaXBlcyA8PSBCVFJGU19JTkxJTkVfQ1NVTV9NQVhfREVWUykNCj4gKwkJcmV0dXJu
Ow0KPiArDQo+ICsJLyoNCj4gKwkgKiBGb3VuZCBhIGJsb2NrIGdyb3VwIHdyaXRpbmcgdG8gbXVs
dGlwbGUgZGV2aWNlcywgZGlzYWJsZQ0KPiArCSAqIGlubGluZSBhdXRvbWF0aWMgY2hlY2tzdW0u
DQo+ICsJICovDQo+ICsJaW5mby0+ZnNfZGV2aWNlcy0+c3RyaXBlZF93cml0aW5nID0gdHJ1ZTsN
Cj4gK30NCj4gKw0KDQpUaGlzIGZ1bmN0aW9uIGFkZHMgc29tZSBvdmVybHkgbG9uZyBsaW5lcy4N
Cg==


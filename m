Return-Path: <linux-btrfs+bounces-15364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B21AFE0A9
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 08:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C8D1C272C8
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 07:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22F726CE21;
	Wed,  9 Jul 2025 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Tu0QYLAF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vmgg9yjC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBCA26C3B7
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752044386; cv=fail; b=c7lqZx3/S3WUyDr3Ae67iTJNIQQdfZokbkl3SoFLTBMvpe8sMXYRpRlFydLAw5LuAUl81GZT4PYTtakkY1Eb/IQH48UV1j3n20GcI1SZMEneNX0zhc/1aFglK92R8PCPu7KzJWG7r2EVwRCYdGAT44BtCVpsM8wr1uVhnYbSkjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752044386; c=relaxed/simple;
	bh=3mnt467EgW5YrgI1fvZycUQY3n0xVP2jUgqc3UrjueE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NlEziaWEOuMiFxKcWfPzQtWA0+y2UB80BpYPZYBWC3oiuOabQWS4+mm+p7IVv/3eLMk2Mzdii43w0piWZEoXt/AXC8/wxJtAluEoYQVe2CmWHxdyB6n1FBOhxXtc8eS9IvFoMpFqAWnw6eIeNUxeEJqF08LK3QT485sUE0iwXmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Tu0QYLAF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vmgg9yjC; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752044384; x=1783580384;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=3mnt467EgW5YrgI1fvZycUQY3n0xVP2jUgqc3UrjueE=;
  b=Tu0QYLAFpHWganYMuczEeBhRrqwV/We+fwgIyIgRVQNsSgKZGOjfNQZw
   ZF3iKY4w6Ci1CYX5/aqS6TjRNom/a7Qv0gPqCAL8qy+Obu/C8XnfSIy06
   +ka0or31/8l8224I4kErlEekdZHVS72vMlO15y4jd9UWd6wHchQzrw3kX
   +lcDLAl0LKXeP9JwBBOGfOkpDMnd/cPa9NsM8Zs522vCv3aj/ed0CbpVB
   Agmgu0KpXs/8jMXBvjjo4S7a7XwjixoN5BBDZMXofCBBd/dx+4PYbSJeq
   G7ENx4UlLHmDKgM8b/MKotsgQ3RkNYRiFDOiWcP9lmqJVorHWVkhpm4eC
   A==;
X-CSE-ConnectionGUID: i625OBIIQBi5Q1uto/YyBg==
X-CSE-MsgGUID: avr4sv+zQHi4EYMcs+gdGA==
X-IronPort-AV: E=Sophos;i="6.16,298,1744041600"; 
   d="scan'208";a="88078103"
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.57])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2025 14:59:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ocz9NEhLEwt8C+sgIo17Phchs8/zw/fX1v/g+FaZFwS6Y8pc2S127uCANiOnFZokZq4hD+UmkwcQUzklML9FNW34TL/4l2VuOlD08zgCRh9tBIJDX59t8IqjfvfISfd0v3mWW2RNg/SA6FKJuqQHL61koaPsNLhGsaljuvGQ/nm1aRS26gj+Muq9iEvQffJDQhkjMaau+smQwlb5sZ+JhhEfjBF2qQycyKXa4mci3XAhBpx07smKID3lwHeLb7awqOUQTkdql6CcBBKpFCg7FgqPz86w8bcrFN8PEqiH/GAmQVbkabOrzY5PHWzBMTjws2vu6/MtTHcU0R+NcBJTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mnt467EgW5YrgI1fvZycUQY3n0xVP2jUgqc3UrjueE=;
 b=ZRIbXeFYAFdOrCiz8bOWs29BAudX7k8yMDYRDVKyseOxXs4cyGsqocer8lLBakW44LH5RrdaCG0S8gAZ6k+dHaKR5+NCkQ4cYPpTbrK1qIml4fCIw7+R114kVMFhxjLsnpapGrD6/joYKJKg3kTMgdd2dng3UWBxs4tSGKdjZOlmWNJIgncE9haSm7YRWF1x44efJvOHTFvWqtJUCwvufGM200u3r2ZwhLvQ9AOMa6UjeIc5lfz5UnAms2pMWr+jiDOKyJT08GSwzbnqIt06eq+g8Fg50i5xloF4DyEbGW6A6EqAU+3JO5zj5rlYkHQEoh/2rd9pX0K/c0XTX+7s0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mnt467EgW5YrgI1fvZycUQY3n0xVP2jUgqc3UrjueE=;
 b=vmgg9yjCOD6IWPPrv6uiibTB9aLGSfjiLON2LUdiDPw1c0j/Pulqgibhn5jow0dFWTIY35iTT0Lq6ufC4HLvCocfluaa0XytkQEe/Lo0U4Zy3qe9Hd+ws7iEvW/goK53BibDFzTx3lbXLYsczxvVnSNiGfBhdaYGaVh16pSvqHM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB7581.namprd04.prod.outlook.com (2603:10b6:a03:32b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 06:59:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 06:59:36 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: use bdev_rw_virt() to read and scratch the
 disk super block
Thread-Topic: [PATCH 1/2] btrfs: use bdev_rw_virt() to read and scratch the
 disk super block
Thread-Index: AQHb8IbX7m1hTZG77Ea9LeE9HHpNjLQpXQIA
Date: Wed, 9 Jul 2025 06:59:36 +0000
Message-ID: <2d321494-47ae-4d46-ac00-5c4b49198a2a@wdc.com>
References: <cover.1752033203.git.wqu@suse.com>
 <595dc052bcf4f31e3c6b8dca33e1ae7a73496267.1752033203.git.wqu@suse.com>
In-Reply-To:
 <595dc052bcf4f31e3c6b8dca33e1ae7a73496267.1752033203.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB7581:EE_
x-ms-office365-filtering-correlation-id: ffce4637-742f-4652-51ab-08ddbeb62a8e
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WjZQSUxGR1hsUXBPOTNIUXR6cUtwbDZwNm1KR0VYOXBGTU0zQmpoU1NRR2lU?=
 =?utf-8?B?c3UxZ2sxRElYekhMVzNoN0ltNWVwaC9NM04zcW9Db0t3bmkrMXhaS2huQ2Yy?=
 =?utf-8?B?Z2k5MWFTVGdkV0RYMVZ4T3lrdnRHOXlqZG9ablNHTzZsTityYUIzK0tTT2pn?=
 =?utf-8?B?SzNIYTQ2cFhlSUJrVXBGRXNQWS80U01nekRkbzRIZGxXaFZzZW11RldOV1pP?=
 =?utf-8?B?ajIvS29oWTc0SS9QeHVBbW8vZ2JEa21IVUJhMjF0amRPN2JGRExyOHRRRUxO?=
 =?utf-8?B?MFdNdU41cU14a3EvNjVRQXpMdFZRYVFYTU92VTlWZkxsajNjQUtzY3NRNUU5?=
 =?utf-8?B?QVlnYVNKU1VHTVJIVFdDY0w4WkpuWndPRXRvUEtEcmZzRlVNYnE0MVdzYXM3?=
 =?utf-8?B?ZXRmZiswQTFtZkszamJrbmJNTWJsV0hmSGEyK2l4bUR6a2dDUUJXQVZtajRP?=
 =?utf-8?B?UG8rZUp2V1lQcFVvNHQ4NjE1cmJUWGdsN3lkQ09kV2pjQXFSOWxnbFBRVDRy?=
 =?utf-8?B?bmdON1NEak9NTE40MlJiL1JvQ2w0bzFudERNK1E1SWc2dnpHZlIzcWZyZVgy?=
 =?utf-8?B?VStpTzVPYWV1S0duSEs1bG5jaDJyc29BOE55QXgweFVLd0V5U2NGRXdlbHl6?=
 =?utf-8?B?WUsvM3VvUXFNblpZZUpVODV4U0xRRVBLSy8zcGpjTFY3UUdaSUFvWXJmUkFh?=
 =?utf-8?B?Mm9jbzhaVnZqZStQRS8wSDRVRlB5NVNKYVJqVUlZNEhseVUrYWlIcnlTQzF5?=
 =?utf-8?B?VURqV3JuV1YzWWRESUZldmVYQ3BJaVRqSVNBd2pqYXpidUtiRzFQeGhRUEFi?=
 =?utf-8?B?ZUZTanpjQXpWc1hOWXVGUDlqU0hxUnoycmpwa3dzNXlKQ1l0ODBTQW1GaDU2?=
 =?utf-8?B?ZlQ4MExJaGRac1lhZ2R0R2pnOCtZNlRNMFZqK1pmNTZHSURONzZPZ25pWVJB?=
 =?utf-8?B?ZlBWRy9mZmFhZS9LUGRYYndJZGVpVXdqNHdQWml5dEVhTkdZcTRqWEw1ekpz?=
 =?utf-8?B?RGcvUXVHaDYzeU84ODlDQy9vYVZsaUhrL0VCT3ZKSmRhbC9SampmSmpMZ3hv?=
 =?utf-8?B?N2oxbHVWS3VIbisvV3JQbHNFalJ6MnlCY2F2RnJ0aEJKVjF4ZExQU1NjT2pt?=
 =?utf-8?B?bmxCZ1JENVlIWk9XL2VwM0NXaUlLTFZvUXkwSUR3QU1NbUpOdkVoaDQ5S3pN?=
 =?utf-8?B?YlZRY3JRMHRWYkxlanRzd2wzanlBeDBuT29mZHltZHVBM00rU3pwWDR6VWlB?=
 =?utf-8?B?cXZQbElBMllxaldETE9UMlpnT0ZvYUliMUhDTFdtalBaMXVxVEJYYjY2N0J5?=
 =?utf-8?B?QVBVZU9LTlpoaTJOaHNSdGhQc25XQkxuY3Ard0VSQ1JEbHV4MldCTW1DMUpX?=
 =?utf-8?B?ZnNpWTR1dTBLWktEdUhvYUlFa3JsRmphT285bXhMTEdvT1FYaTdlTXlUejlP?=
 =?utf-8?B?TGI3anRSZ3V0STFXVUJ2VnJ5bG1scjYwcEdHejN4cUt0SjBVOG1CWkxlS3Bk?=
 =?utf-8?B?QjNYV2g4eC9vLzhZKzhmQjBBcWthZXQwdVpjZ0xsWjlMMm42UmhabUpIcDBm?=
 =?utf-8?B?RzBQWDJ4WDVWbnViaDc1SEdoWWRKTVVBcitMUlBZVWtNTmxOTXZxWFY4c0J0?=
 =?utf-8?B?eVc0Y294RVk4c1B6QThsbi9VQ3JUYXBqMGx1SGpGNlZ1cFNRUFRGYnZaaU1V?=
 =?utf-8?B?MVZPeTFCZld5bVdmWXI0SUY2dzhKUm9qdGtJN0Q4NjVGTEhVNHdHK0g4RU5W?=
 =?utf-8?B?LzNMVVpFU0JEWkxycWNuKzdXV3B4aU5rcXZhc2V1TGF3UHcvZGNsZzI3QU1o?=
 =?utf-8?B?ay9TQzBGTHVLRVdxTVVpbytFUnVDRmpqS0pVemZzZG1TVVNTSkJuY0Uvbk1s?=
 =?utf-8?B?VmFRaG45V2hKUkIxTUlTY3lWV2t6RWdSMUhDSGlLaTZwNWlQZkpRdjRqRHpD?=
 =?utf-8?B?NE9qYm9kQk1DQ05VMHIySWRXYlhYek1IbTc3UTdYeFRQVGhYNW9KMEV6dmhq?=
 =?utf-8?B?YlBZa0ZXazRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXZJbmxJL21vcHI4aXZpZCs0TS9XaVFjZ3d0dFdUT28xTHhWOWNMSWxDMDl3?=
 =?utf-8?B?OThMOUlkN3MvcEhXUEdnVk5hdFFpZ1BzT2pNcVIweTYybkZnWlY2QXZUVmpU?=
 =?utf-8?B?aUZoL0dGa2NjVmlaM1BnZE02RnNRU2p6NXh5Y0x5bGdvYUoyTzR2ejdhTG5K?=
 =?utf-8?B?c25semFidTdJRVVKa05YNElMOFBuSVB3WTRJNmFiNTFEdklzZWp0RFRaU3d4?=
 =?utf-8?B?ZTdFVHcrZ0o1UkVqQjlaYWxxN1NBRGpJRUhoRnlCYkRrMFlsZ3RVTmxiRkp4?=
 =?utf-8?B?TXJESldIR2hENzNicjY4TWFCWVhEODZzL1cybThqOUVzbjZBVTE1bmY0K3ov?=
 =?utf-8?B?MmpML0JUMzBVZ1hnREJJZjYzQ2RhamJtSkhDV3FRRk9rMWYvZTN0T1dDNVdU?=
 =?utf-8?B?MEdlcnhzdGtaR2lkeXRkL3Mrck9GQ2dBd21oU0tVdUZBSWt3Y1FOOHN5YWZ1?=
 =?utf-8?B?VEEyU0VKVG9OWjNhYlV2enN0ZEpnaUlBREJpazJ5Uk9QVm56M01CSy9UMW53?=
 =?utf-8?B?UkpxQzZkaFZYNndLa3FIK1pyUXZ3NCtWRmpJRGw1VFowYjcxWjMvRFFGS2VC?=
 =?utf-8?B?MldBYzFDRkk5aHU0WUROQWtrUjRkTWFKTy9nKzlsN2RWNGFnRTVvWTJmc0E2?=
 =?utf-8?B?QmJWbFVqRmsyTWxsb29wWmtnN29pVzNVQnR6b3orWFZYVHgxZ0ZkL1VrdVJl?=
 =?utf-8?B?aUFjMTJqSVExbVlaMTV5dlM4b2dyUmpUeGtQamdPV1QyYzNtNzJ0QlluZFZu?=
 =?utf-8?B?bXdja1Y1YkVxZVorVnFXcUVaWXUwUWpQbENIOStBdVBlNG9IdWtLK1pDYktT?=
 =?utf-8?B?UnNkS0Z5djJBQXZPSnA4L0FvMEcwNEpQOEJ0MittME8wQkJzOXF6R2I1RWRW?=
 =?utf-8?B?bjhhYlVGUlBORWxLQVdFOWFnM0ExUVJMYm4zYlRBclFicnU0OVdQTnRjOFIr?=
 =?utf-8?B?NTJDWHBUbFc4SHNJVGlqN25wdEsyRjZ0ckY2US9RYk5sMUdVN3JJc3J6VVIx?=
 =?utf-8?B?U1IxUXZtUGZRdWpUNUR3aTlFWTJ1Ym9TR0FVdmJtQXczaVlvZU9sc1ZnNFgv?=
 =?utf-8?B?eERKM2VFSHZxRWlIYXFlL285QlQ4U3FheEJnRTkvcVlhYVQxK2NZZFJzL1dM?=
 =?utf-8?B?bWFqY3h5UlBnYXZJM1I4WmFqZVRsVkV5RVFPM2IyelFWUjVsMXBnQWVFdDNC?=
 =?utf-8?B?dDIxbEN5QnJnN1VxdTlZMW40OG5ETFJPckVHR0x2R25CclovUE1pWlZneFBI?=
 =?utf-8?B?Vy9jOVRLdngzM1FlQXlZdnhUZVgwWHF0VkVYOFZHRE81K0hDVkJTVzVWRUFJ?=
 =?utf-8?B?dVp5ZjdEbW0yR05pV3VnU2prREcvT1FDTSt5R1JHd1lPelhaL0RqVnRLRC8z?=
 =?utf-8?B?QUFiQ2RkbE9aMmVFVHRtbzJBdi9tdGVxZHMzTUxUc2JwWndUSnd5Ui9kWExZ?=
 =?utf-8?B?QmpQTk5UczJXTTd3QWMvTjJ4cnlmY0kzR3FTZDdYN3E5WTZlWlVMR3lzM1k4?=
 =?utf-8?B?ckozOXhYVTBieGlXR1R4MU1Tb2JrQ3BaNlp4NlJOaVFadVJ4ZThzM01MdlNP?=
 =?utf-8?B?UmV0eVYzeS8zcWlTV1NaWlQxT2xUZ05uem5TSEcrNGswbUpEK1NRZVhPS0wz?=
 =?utf-8?B?NHZRa1lVRWs0UFVCa05tU0g1d2JtWHB3YStHRVYzTnBQaVJMS01LOG5wWWFs?=
 =?utf-8?B?Q2tBbGt5dmlKNFpGdXVHLzBUZFpXSVArZzU0V1NuVFJxZGxTM2daNnF0NEFl?=
 =?utf-8?B?TnQyakFQemYrTjdneTR4M1FKdjdONEliOHJ1UVo0VWIvdmZIU1B6M2VZdXFF?=
 =?utf-8?B?OVhXWGg2b3dCTzBJZ2xqWk9relFHaUlVOTRlODdXaDdhbXJYY3dzV0g5Qy9h?=
 =?utf-8?B?YXdselNXTkNSMTZWeG16S3I3Ym9wcldXSDBrdlE0RnNiYlR4V3FrYktWOW1E?=
 =?utf-8?B?eGpwbGJVbm4rdjR1RGhlTnQ3RGZIdjJCRThSVUQ4QitvcThoQzNvNnVKcnE2?=
 =?utf-8?B?VllBRUJyV0luL3FsY292c2NRMGhGN25rbGJKQ051Q3NSbjU2T3BkNmxlSHJG?=
 =?utf-8?B?Sjl0ejZHRXJ5ZnUvQWVXeS9NWGJwdzNYMEw5bjlJdER5b0dBWFdJTGI5eFJr?=
 =?utf-8?B?akhYU3VSUGw3bmlXRjZ1RXdYK3IxZlJIaUZvci96MlhERFMwMVdxdVV3Ry8z?=
 =?utf-8?B?dHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D62724F1F1F59141B4ED32000BA91D09@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xlnA6TxIniFR7K4ul7taWiABKBSbsSxWLqIMkz40gJ3TWU07AP/T4WrQ5QATey/t1o4693TNdNu2utpCxrjIxZqBYXnxIo7exNQRueGyglDhbwCLl5zQPTGKYv40NV1L3z+eHiEeYkBYGtJ6TCg/iOTm29REuM1XHu/nrchN3VACPy5wBTSikAN57YNck7mctJQP5ssFg5MPnaATQ07fyaxcRepETWEp2+0JtCceuQ6nLzmmUicHoYnMw/TtYuDDZtQZrIP/6AmK6n146EKENsn9UmzEsogfbyQtzKJfyHO8NrW/S5AQtr1OW+GT2DEf+PhzM8qSIs9/VFOArxHPpQ12FlVOnCGex/e/gq/ykPDMmhDgtFJwm3KPmPo3ndCuJ2ITLQH21Yw621tK/CAenIUsad3qeS/WLYlDQLF9PKIq/hNIayZTCtsPSETY6Qgmmg4HtLRMAq18ccicFDIgCP3gNgMvBIPtF9RHP25m/JXXoE4qxcuGFFr7Oz0r7nFHDUlVhfgc+hbTRSWdE4IDHwczZy2GSEAuCQXRnaDJBSRVoJ+AdsLM6C15qM8BOWq6KIk9DQ29WSiolqSAtaw9fvN3PoavOo6JYy3QbCPsPgeLy77P0cigaKQ10uPq5xNV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffce4637-742f-4652-51ab-08ddbeb62a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 06:59:36.3478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GFEYooCjX/3/+ctY0IyU91gj+vbcL077SJGWOZ7DtMKiwhLKFKqLJwtIrV7gFNmKc/4gj/ujNrKEMaSFUEddfkE0O3cY5NVeMteZIjP/8+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7581

T24gMDkuMDcuMjUgMDY6MDYsIFF1IFdlbnJ1byB3cm90ZToNCj4gLQkJZm9yIChpbnQgaSA9IDA7
IGkgPCBCVFJGU19OUl9TQl9MT0dfWk9ORVM7IGkrKykNCj4gLQkJCWJ0cmZzX3JlbGVhc2VfZGlz
a19zdXBlcihzdXBlcltpXSk7DQo+ICsJCWtmcmVlKHN1cGVyWzBdKTsNCj4gKwkJa2ZyZWUoc3Vw
ZXJbMV0pOw0KDQpOaXQ6IEknZCBwZXJzb25hbGx5IHByZWZlciB0byBrZWVwDQoNCmZvciAoaW50
IGkgPSAwOyBpIDwgQlRSRlNfTlJfU0JfTE9HX1pPTkVTOyBpKyspDQoJa2ZyZWUoc3VwZXJbaV0p
Ow0K


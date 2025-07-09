Return-Path: <linux-btrfs+bounces-15365-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A478AFE18C
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 09:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11401BC7FEB
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 07:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277EE271456;
	Wed,  9 Jul 2025 07:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LkLHrcQF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JRcc0hHB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862E78C91
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047027; cv=fail; b=UctH5p6KSmnrkdHT3ho2X1waFp9jWE3ozMwbZICo8oH3Q7BXmcC6K/2I+avl4D/Pg0cs2Fd3lDkXBgrinVaspgYxR0VzL3R5ocZPd2HFww3fgDJPQwDXH8SHlNd68S81H7my2Sl+VJy5PRim+3aqb8jGPNVuaPenYO0+BoXOVrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047027; c=relaxed/simple;
	bh=sIgOEFTqFIkkkdxt7F1s4KmZDBMqCMytS8jJwwhpOFo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RVMcBCKRr3j29ktyIBa+Cbb5JGr3mj1ZN+RJvgCdUGCN8YR5JdQ85KhPhwcgJtM+17Gobz9Ouhs1Osed7zg/IscUkJNWbmgcv9CdsIOgUu+H/AX8uo3+BL2bKMMcPND2/IhQ9Zgu8assv/iAHIkZVy1Z5VkMhM+qaIoM72l9bAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LkLHrcQF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JRcc0hHB; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752047025; x=1783583025;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=sIgOEFTqFIkkkdxt7F1s4KmZDBMqCMytS8jJwwhpOFo=;
  b=LkLHrcQF9dJWHhr89mlW9PDQPq4f26Hq+DRsbZlbEWZO/xi2NcMTRTXh
   l/88Koli5dfZjLzca+K5MVQYOss5pVVqZPC8vPVd+4UFmh04JM/FtS/GV
   98gvJYU2FycK2XVEFMP1tvWWQ5oziMhNfqXSJLl2zx9HCmroZIdz+O+xQ
   yjITLMNWsfMbtPIRS9JvdYyHq90VaETIbTtNmbz5QHQF967GR0V86zDkD
   A2wo/Hd25FmNVgqGlDN2yxJkHN+M6llI1GF/aRQN9I4NuvdqRGGfWv/Wt
   eXDIiCkQNpuMRUrFV/Xv3fEErjaog3Eu3EshdUiY6wnxyXQKtHYJsyLH1
   g==;
X-CSE-ConnectionGUID: 462n9No+RjOZ0wzzbT7QCg==
X-CSE-MsgGUID: KZmCkMzqR7KsCNsVw6Xc6g==
X-IronPort-AV: E=Sophos;i="6.16,298,1744041600"; 
   d="scan'208";a="85651648"
Received: from mail-dm3nam02on2064.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([40.107.95.64])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2025 15:43:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2OVn3a4SPlEsd0/xC2sGSB/fZ5NmicXyPAdBJ7rDRB72zq5omnv8SXbleUM5kqltMvJehKRPaXui7/YCwkAHTzXJzO1D+5seHGl3AKs4YT+oqRIrySV7vA2t/I2lQR/VEdNhiUlBpFXbDWkrrrGJT7vvgs0ugqymcpEWXGtpujnUmQehfupF10KwQrRh1/AvELomdF3h3Gk1MDKiX31ZiyNOToH54i2kmk2XmwF8iGVkx1k4qa8kHKR1JQD+dmKFq8p15WtZJqRKZHpcolrIK8rEp7+xtyBEHfXfYR4SiaUmAg1sWfIXb4rmnAQfGiTn5sWKqAAVR/onV7iD25o0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIgOEFTqFIkkkdxt7F1s4KmZDBMqCMytS8jJwwhpOFo=;
 b=D3J6pNKcdSD1vzCPCLtwOckDyL6nJjtNUUco5NimD4YEEHyAKfWuJadzOIcMLK5cdMXoyWkXZ73DdCQ1zrUXldgJkPurZ8VZP6M08GHVHAmT6an+DWh8kLy5nBbdu6TL4IhCjYnha79ZfEoJxQ3XOc7UVL2UGqsu2AkteO+Ym0y5NXVyRS16I4Dl82s5OkonHMJ6gnQzsqnE6Y8xA40fc6dESsalwnMjujQKm0apiVX6o1x8JzI5d/MV8AQqgZxyVKZXkPZK9j6yVllRzSH66lHWf0uvR3GFuYzRNVFEy+ViclJBKsQK0iu8GORrh3NlhT42COdo5nJBp5mHa1vAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIgOEFTqFIkkkdxt7F1s4KmZDBMqCMytS8jJwwhpOFo=;
 b=JRcc0hHBG9U49NgknofE2DYO8RhkBs1ZFgtcyirvdD+kGFu7pzAVSMVV+6rDBv/uEEKyOolKs3gXRuPUaVgRYAwlhwU0ByRUoSRJpX3TmqFQiuiGOyLGHM1gZem5R4E2r6NLPxwjIReyUX+xNyfVjok1cGzVZtgX6DIo7JJjAHo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by LV3PR04MB8943.namprd04.prod.outlook.com (2603:10b6:408:1a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 07:43:42 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 07:43:42 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs: do not poke into bdev's page cache
Thread-Topic: [PATCH 0/2] btrfs: do not poke into bdev's page cache
Thread-Index: AQHb8IbWqC92CFPqaESD+dF/YwAuerQpaVQA
Date: Wed, 9 Jul 2025 07:43:42 +0000
Message-ID: <d3fa291f-656b-4430-923d-567208146302@wdc.com>
References: <cover.1752033203.git.wqu@suse.com>
In-Reply-To: <cover.1752033203.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|LV3PR04MB8943:EE_
x-ms-office365-filtering-correlation-id: eb192038-84bf-4975-09c7-08ddbebc53b6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OFVrTWNaT0lSQ0htVGZaOGVmVEk4SjdqR3c4YjFJUnJHRzdDYlNaYVl1SVRx?=
 =?utf-8?B?d1A5VnBtdTlYaEp2MVZ2eGV3Umo1UE9EK2FSQWZEZlN3R2czRUlodzN4SEoz?=
 =?utf-8?B?MjMyTGJSVnEzMFZaS0IrSEV0QzJHWDdTTWlSeTNKNlYya1VhOHkyRXdvOXZV?=
 =?utf-8?B?eWEzWGxtSjgzL3pWTk5lQzVPUG00aXJwcllVR24xWnI2cFlQSWZMR0NhNW9p?=
 =?utf-8?B?VUcrdEJPL2dqSHpjdm1KQi80MVFxTkwwYXV2dEdxZWRzdUE2bDVnd1NlSEJ2?=
 =?utf-8?B?eitVdU5jRXFBZ25UUGJNd0xuK0ZNNE0vMFdCZS9renFDL290RG51VzVabm43?=
 =?utf-8?B?NWlOSDVQQXFoa1M3djZFa0kvZVZweW50TUIxV0Zvd0xxS1lBN2o1S1NDUUtm?=
 =?utf-8?B?RjlXSWExM2JvYTJwdS9qOExLMnlKUXltL0N6elY2RWdOc05uUVpMV2NwWGh3?=
 =?utf-8?B?anNkVUptTmcyV2ordnh0SmNmQlhvZVRRRjZDUmJaOFRKTWpSK0FHa2VTUzN0?=
 =?utf-8?B?L28vOVZwOTg0YW9zQndlbENNYVR6MnpXV3dzQkMxNkxQV2E5TG8yd00vKzE5?=
 =?utf-8?B?ajc4RDdXZVdXaVp2bTZWbVhOVlQrMnZ5eVA2bzB6Q3VOOXB1MWpXQmdkYUZp?=
 =?utf-8?B?TGRZVVlxVXFrSUF4ekhwcEJadC9CZE9yRittREVhbDUrOWVUZWpETTNMMS9r?=
 =?utf-8?B?UFBVZ2RUeEdWRnNYOUtNcEdpSE8yVzdnUWhpS0ZCL3E0M1dYYTB5TGg1WHpE?=
 =?utf-8?B?WlZ5OVdNdCtxL0hkTVMxZkpMQ1prQzZSN1YyblIxbXdJODgwZ3VNdFFvTTFt?=
 =?utf-8?B?eGNhQklUN0RPWTErN2VBMndqazhsa0cwSjBkWUN6SWRDcHJTSTZ3RWZtMlhJ?=
 =?utf-8?B?LzF2bXVRUUU3ZWsrN3czSHl6R0s5amt5SzJLSDJLMUYvajRXQkptLzFHa3Nt?=
 =?utf-8?B?aG5mN2lCeWt6ck9vRWZlV0Z4MEU3M1l6WlNydE5HL2JSWmF6RGRtNnVWZ3Ux?=
 =?utf-8?B?UTVhb0tSVURZT0R5aWFoaWtjOVI4cFBQSjdzL2RMeWxsR013bkF6US9TQWc3?=
 =?utf-8?B?R0NCUjBvQVliWkh3c2JqYmQyc1VoUEFzdVNRMTBrdjlzbU1tck9aTHI4TDNY?=
 =?utf-8?B?L1Q4clVEdzQ0L0JEdjh2ajdOUEgzR3VzSkx3SVF5cjlzcnYzUENqVjF1VHFV?=
 =?utf-8?B?VmZpbTZDN0VqSHZNVUFEZ2FxK21ZcGdNcHhiOFhmWjdJSzZ0czc2ZjErLzE0?=
 =?utf-8?B?Ym9OWlJhVE55TGFzd3N0NUg2Tzl4WVlJR1kwRmZTWVVxY08xbFBBWWNENHVl?=
 =?utf-8?B?OEFoUGh4elRKb1RtWER2aTl0QUZuYzBycm9MMnRBSEprRjRkYWZkOXNOK1Fv?=
 =?utf-8?B?bjlOOVBNbHd0WDhzMjhUSlRaNDJCUWZKVnJ1YllSSGt1WFhzWDJ3QjMxbU54?=
 =?utf-8?B?YXNHTVA2bmxjL3dXdGE1MXd0ZE0zamlZSzMrOHppM2ptbjNpQzJQNFdobW5K?=
 =?utf-8?B?WTFvNFhpY0RPK0cvb3VKWE9zUDcydHU1anJNOTgvNkgrQ1N4bk52OWd4VTFW?=
 =?utf-8?B?engwSTFIbzhqemlhRzFtbHhFNHZmbkpUSjhXcTk0anNLZHQzNDlFczhON0p0?=
 =?utf-8?B?MWc2NVM3amwrWjdPVTdYNmxISE5VNStOVURWOTVOT2JrRGp1SDBCMXlqbW5L?=
 =?utf-8?B?NmlkRzRua3FNTnNaSWVWM0s4ZnoxM1pqQTlRd2JQbWhISXhkeFpoQkIyYVM4?=
 =?utf-8?B?T0k0YnVJK3MwcGtYaW9QdGg5SERyTVFCaGdhVlpNV3g1S1dObTBES3JicVho?=
 =?utf-8?B?THdpZWRyV2VqWUZHb0VWMjJCU2ZXUU5qK2RudmtZL2lnVUQreSthZXBUN0l5?=
 =?utf-8?B?SmxEaXVBZXpDdUJzek90bzVGM3E3UFRpcWJGSVQvcUd0d2NhNGtRbnhFamxm?=
 =?utf-8?B?ZTFRTE51QkNaS2FuNXM0QzM5U1lQblhLZnNUT3ZrKzBXWm55VmFpc1JFbHpD?=
 =?utf-8?B?Y1dwcHBpSmZBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bllEMlRzdHVrVElacU1QK2FFVHhzaGZBS05TWlNQV3h5dVpsWjY0UG14OXJY?=
 =?utf-8?B?dXgrM01rZ1FLWnB3TEpBVFR1b28rSDU0THpnOS9BUnJnVEFlZ05ZVld2N0Jj?=
 =?utf-8?B?RXQwU1lJSktza0diOTRSYjFlSXExVWh6UTlaQmNHS2xzUngxVXpDekNFQkR0?=
 =?utf-8?B?L0VxQVlwcXB2NnpuMVZBZHZHdEtienpIcCt0Q2pmS3lDZXhkRUVwck4xZTUx?=
 =?utf-8?B?R1dEaExEVFMyM1R5WkNlZHlGei9Pdm9yVm1XaGViK0c4NGJyV1hFeS8vT3NL?=
 =?utf-8?B?dmZMdkdlOWJtK0xkNGtBTytQVDdya3lCVWpISDZabEM3MWtZOVdlaVRUZVFI?=
 =?utf-8?B?NW43VjhEc2YzM3V3NlZTZ1pSTGRqVXh1MUdpUTI2SnNlMmdhWWdTVkQ1Mjhy?=
 =?utf-8?B?U3BCWTJvdTlTWGxQZFhTc3JaYmNWVkI0bDNmeDVKcWJZbUhXeVA0eGxiWWNO?=
 =?utf-8?B?bVd2bWI5b3YvVWdUc3Q4Q3hJcG5ab0pkeTVPT1RiempkZXVKNDdSMzhucHNV?=
 =?utf-8?B?NTEzVm11dndrV0xuaGx5ZmN4MlJMaElPMWU4NlVSeU5OYU5DZHI1QnhuNjVl?=
 =?utf-8?B?Yi85TTZPMzgyaGdZOTZNcm1DN0tyUXphbmVISU9KemMwQzRlSUtUb1VkVEpY?=
 =?utf-8?B?Q3JJRHBROU02b3kyQUZEM0JMT25sQ2hKYkJnVTlKMWNTU25wRHpzUFRJWEJW?=
 =?utf-8?B?YXJCRmhGTTNHQjNCNGd2bFdnM1ZSZG44N3dkSWZNV3VIRmtUcmhaTVRQN294?=
 =?utf-8?B?bmRFT0k4czFLQXljRUpzU1hIODRiVUhJS3FvZmJZdmtqNEQ0dDhtZnFMMmxZ?=
 =?utf-8?B?TU4rUGZCbUowN29nSmpaa0pxRDhsWnRGaTgrRS83V1piTXZnSUowdVVHUHpz?=
 =?utf-8?B?N0lFWEJ5NDJMdmc3dkRLd01raFY1ZldqbmxJVW9BZFc1K2xObjNvdmVIZHYr?=
 =?utf-8?B?UkZkbS8xckdkYWRBTDJISkVKblBCZUpDcVY2eENqOFVCZS83MVJvZ0VmSzFP?=
 =?utf-8?B?L2ZhVGdzY085dDlWZUtGL3pqVXBMdjg3cEZISGR1ZHpnOTJ2NHkwWjVncUJU?=
 =?utf-8?B?N1o4dVZoVEk3bUJ3azNNNm5iL1ZGMzlGbGw4NDBhR045d1dEMlNNWCs0RmxB?=
 =?utf-8?B?ZjlFcFYvWURiMU5nbE00b3VVTGJuOFJpRTlJR3k1bmUwVzE4Y0lUS1d6NTdC?=
 =?utf-8?B?Tk9jOHVCTlJaMDVIRi9QV3E1bEhEMGNLOGpnMWFySTZoSk15YllCQXgrTmNY?=
 =?utf-8?B?eXZkUllXTnd5dmo4b3gvcFJ6ekpxVGJ4RitzUW5OR3drRlZiV0M3WFZLcXE4?=
 =?utf-8?B?eEhlbytHeTlmbk5VQmNQZ28zNkJKU2JiQ1dSeVRtM0VlRUJjcy9uMndmM0pa?=
 =?utf-8?B?WDcycHhzL2hrYXFFZGVkL0IybDU4U25uVFpSc0I1Mm1ZR1h0dk1IYUJ2RFB5?=
 =?utf-8?B?TXFUbTJHTXZNbzc1bWJ3SWUrQ3gwMTRGVWJLSVFmcVpDTytrcFRRNEw5bnVp?=
 =?utf-8?B?LzdEZjZXWkVscE83OTZTcWJNTnlEazBJSTNyVm5LdEpRdDN2UnlkcDU0S0N2?=
 =?utf-8?B?cHJuQWRlaS9VR0dCUUYyRXNVK1FTUFZYQ296TGs3emF4Tno1MlN1ZjBSN0h0?=
 =?utf-8?B?QVFEQis4aFdaWjZRSW9kU1dTeXkxdlpYVFIrN0VydjdNeGR3QTdPTFpqQ3hn?=
 =?utf-8?B?RjFOY1Q3Q2pjbkNweTBraW5rL2JIa0xabTBYbmU4S0hxR1lnWk11UFVNUzkr?=
 =?utf-8?B?dWRlbStsVEVMaVFoSnh0RHBnRlJvRmJBR2pPYytDRUx5eDFCWWFnNERVZzF5?=
 =?utf-8?B?K0FvK0FQN0lBcWJrd1doZW1wby9Db3o5YVlhTU5SVDFaeldEME1SZ2FPYWpT?=
 =?utf-8?B?dXU5ZGdoRDNEakRkREZ5YVZSK3NRckwrTU45NllTTHdZcWRZc091Sm9mMlAw?=
 =?utf-8?B?V3lkMjRPa1o5czI1bXZMZVhheTl4bDBKT2N0L0R4U3hhVzlOT1NRbk9iVVgw?=
 =?utf-8?B?VDl0T2RMZHFVVkZPTGRQU1hBOEJ5ODdwLzBNUTc2amgvTlA1aUJEdmNTellP?=
 =?utf-8?B?NkhMdmpGMGNKcXR6RmRHN0ViN1Y3Sm9ENDRhUUpzaS8xb2p5Q0pJSU1pNjJ3?=
 =?utf-8?B?U1ZXRXpmSUpoWjA5eitBYjRydjBFUjgyWkozbWhNdGQwNCswaTZNWlBLdGRD?=
 =?utf-8?B?blE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97293658398B9D438929191B7FCE2279@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lVvzLH8SdondLmydwx21Y1uWpya1tzZ39d/a8lt0fzKctvV3XyXZhEmzsk5jprMMX7HZXicBMl5dHL6p++uiqxZ6II8eIg3D08jVBeMgjLXd+y6Wz+NS5nDhwZklr9euoIHVqjZZ3XEJ++QcEd8RCAL1Buxa7EJxwYkMNMnGSNMyX5Rzszr9pQkuuKrVXyDjSrkC6HJAkYs1gCZsXqQEpk9wwwQPPiOx+cGrbBJCJXCQmk0vJaWY35djkfVBJxVZnvVjw2qkoW3NHyJ7apghMFIFOZ4U2V4rJVsji8gISW1Kr8/bGi4sI4HZRCozPRAbdu4cYj1fEwjqKmGmPwWxQ5NbyZ7NPcIU7D1Ja53LkqWVobwqzOq1AXMzx0V5PLyOQDtt3pt83X9C0nB6fUuMCuiAFEJm3olxe8pU3Ov+m0msEW6qcGZX8/2hCg6LD/BIKq17AQgRSsjpLORYbyZeXB+KmI3HPReNn2cDXj+xVHAPKD4cjCB3Rw2/XGsoVpQMjY5HtRWb5zD3CdLJUgWY04vnBzciEDyRNjsBRduGcVBIo4k78Qt5IXsOY53S7dllprAT3QCmojeENYo4MEIG060MTFsCxag1mIJ4idDDxX6lOXwfXzMIxiiUPJwAOWse
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb192038-84bf-4975-09c7-08ddbebc53b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 07:43:42.3561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m+A+Og/dVZDmVEYJJ6aEzG2yaMZIq0w8H25cNtlD8fMTZ8sL5qmRNzmD8aIw0DSwS+RZLJvvSEHy/e+9wVQU7/3KOhBwDgeo4l5yQ7AuzA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB8943

TWludXMgdGhlIG5pdCBpbiAxLzINClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpv
aGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQpJJ20gYWxzbyBydW5uaW5nIGl0IHRocm91Z2h0
IGZzdGVzdHMgb24gbXkgQ0kgc2V0dXAgKG5lYXJseSBkb25lIGFuZCANCmxvb2tpbmcgZ29vZCBz
byBmYXIpLg0KDQpUZXN0ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNo
aXJuQHdkYy5jb20+DQo=


Return-Path: <linux-btrfs+bounces-15330-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39715AFCE53
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 16:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8191884041
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150932DE1FE;
	Tue,  8 Jul 2025 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EbcXl2Pf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aLyxKbmT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB3D13957E
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 14:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986613; cv=fail; b=mi+htnm5u8FKnzFxvkRHxnFJeXD1b+YlQm/Iyul7VGteKHu+vnkcLs24xgFrPC9l4ZJ/x8m8bvQKfaBKJTch3OvBBmy29YlQ08jttK+UKuH9WJf2HNRFswPT6wBzcF6NrqFG39jVPEPvZZYKPDkzEBCwDlUApofZqySy0Io8xy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986613; c=relaxed/simple;
	bh=L6Pu+y4wHctFgUVNzCjNwuspma+UlQ140TmIoriilEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m3P+Qt4zPSZyNcIEefe5b6/tWWzIm6lW8+QsYDrkkdlc5dvvDmeJZAM8Flb8+/AWML/+pxQv3eszE2RTohRZVO6ARgPkZoLfQKra30A6WCCCFYxW+UHzvcfLrwJNq9Ao8lHxmUepOvptD/tWgdVuk5FQQtxRKLx7AdHrqZp6HRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EbcXl2Pf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aLyxKbmT; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751986611; x=1783522611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=L6Pu+y4wHctFgUVNzCjNwuspma+UlQ140TmIoriilEY=;
  b=EbcXl2PfO+JcIc0k1xuyd4LZQopYhjN66jcR2fBRZ4+kMXgqjfLqdg4z
   MBvjPd5Yn16d/gfiKmS7mTH+WWXr673qCV4fPB623EmGICYybGSE1p6vb
   X963jZQ749XlGXX/ZQnHe3FzLswTweawy8mhu1yTKnROpNKEw3pE9Cm8b
   FAnZS7pVR80kQiaYTahsli5ZY/V5MZccIiqwLD/VE83rlmmMci12KpS34
   H+o5RplxoEfZH2jiTlSUMk1qER/ZOK/QE4bnPshWFOSIJ6NQm3dnoIFdt
   h6cyqGeSddZI4ZQNmauq2Y6Pkfq2wuED8bG6re8OA3/RA2eNg4iqXRCrA
   g==;
X-CSE-ConnectionGUID: mWmcYxFBR+6/mmt6y3on1A==
X-CSE-MsgGUID: GKjd30HhSlaCpyQp82LmAg==
X-IronPort-AV: E=Sophos;i="6.16,297,1744041600"; 
   d="scan'208";a="86020997"
Received: from mail-bn1nam02on2069.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([40.107.212.69])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2025 22:56:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2NAxUO3vCh5H6wgh8UX+A/S+HDocaBLDAZCYEoQ7Hc9YCLfQXqA0oCOo53ZVK+r0vTirTO/Ijg2/Azk+uJmIA1nUG9l17Fy/Ye3qZV0AttnLlxEk+qRyo02aDpSo6nVF/ML6dPUGAbgwhgbrS/dkdPFIOloGgk5nYU7iRxBsQ2dO5Ql5hvDsbvW087646yufKSX7PAtp/+zrbSiYSELunN8LEeKQ+QBCveZgZjz/SHYXhJk8mdGfwbhaSm7NbcI3e0zhzSTJH9cZ9nJpDt99VsGpY3kgm3Cct4+pedEfdcX4fnbk3D2oP2qiWtrrk88Yt4TUNpd5d5HUug4L4qWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6Pu+y4wHctFgUVNzCjNwuspma+UlQ140TmIoriilEY=;
 b=zBrOrGQHeXDL39GaIkDsmd0IZ25Xaa6HX4Tuhxa1SkFI60UoryqiF3Ug+ftSS3bLTCqlKR7Yjr7X2hz0Q9FPMIPbthqMfVWjDUoSe99rwxFRaV0u43PuGn/KHa4KxSdd03NIGjFzzxqHtf3PTZIIaNo1Y6icnfZ8FhBrDk8b4LzXPDxl0IWsxGqwTja8OT521l63b1UTVeln1mXwP3183fRf0gi1Srx4cta3BxZKvnTqnQxedmf5JiI2J5VUknAXQSSVC0W7TNqcInln326HLCaSgIVkuGO3FHf/nl/gPbPh1Xfw7sLJp8i1bNpCOdLck0zSaujOx66NRuDshRGIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6Pu+y4wHctFgUVNzCjNwuspma+UlQ140TmIoriilEY=;
 b=aLyxKbmTzF3B1MEZY6x1aseluMmp3mjnLKqfeYxfpOiBkYY6f+EMoljozP3vUKjRG/ZQSdxYxLpkc59/qM5jLnF6WjvqfHEFpzlBw0qahxq8m7sPeex4nDls57fblCuuc6obmr1cBJfP4iejyPZMga8EC2e8efRRExtOxEZmfMc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB7032.namprd04.prod.outlook.com (2603:10b6:610:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 8 Jul
 2025 14:56:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 14:56:46 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, =?utf-8?B?TWFyZWsgQmVow7pu?=
	<kabel@kernel.org>, WenRuo Qu <wqu@suse.com>, Tom Rini <trini@konsulko.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] fs: btrfs: Do not free multi when guaranteed to be NULL
Thread-Topic: [PATCH] fs: btrfs: Do not free multi when guaranteed to be NULL
Thread-Index: AQHb7/xavzeiQRFefEKP419udcMFbLQoRdKAgAAEl4CAAAaqAA==
Date: Tue, 8 Jul 2025 14:56:46 +0000
Message-ID: <cce246dc-85f7-4bdd-9e0d-ac646c41af92@wdc.com>
References: <20250708-btrfs_fix-v1-1-bd6dce729ddd@linaro.org>
 <8780edf7-e89e-424c-8770-2d45ab8849d4@wdc.com>
 <43d86312-c109-4f22-9ea2-92725030f053@linaro.org>
In-Reply-To: <43d86312-c109-4f22-9ea2-92725030f053@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB7032:EE_
x-ms-office365-filtering-correlation-id: cafd3f85-a168-49f6-3379-08ddbe2fa94a
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eVEzSk1pYy9NalVJdE9VV3lOeGVpcktJdVJXcnhKeUlFSkJuZmhKODdRR2dq?=
 =?utf-8?B?UjJZV2dySnJOTGNhd1VwZTdvTlNJZEdlRkdYWFRDZzF4ZDRhVjhNc3F5bzdH?=
 =?utf-8?B?YjFJV3cwUm1EbWhRdnhhWmo1RWV0SzhTMU1mOFN2YWs1ZVc3bEtFOWdaUGd2?=
 =?utf-8?B?akRDOUNVQlZHVEdYYlp6NTRXcWJEZnBXUHoxSUFET241NGRyY2lZRHdRbGE4?=
 =?utf-8?B?MWQ1NmhGUjJPbGhNTnJ6cFNsQXpYUmlLbzVHSlFPQjlkQTRHMXg5YWc1ZG93?=
 =?utf-8?B?MDYwMDNtRm05REpUS2JCcUZjZC9aaW9HZmt2RVZPODlydmZ1SHFHYjFGeUhY?=
 =?utf-8?B?aFZXN2llNENZb3h0aUVyQTVLZVhJNDZ6ejdnbDQ0N3ZybkdaNndmTXVKcldT?=
 =?utf-8?B?bEFNUnVTNTFmWEpDS0ViZ1lFdjdDb2pBZHozZmNXcWJ3Y0JPZWgxeTRUblo5?=
 =?utf-8?B?V3NDSms0ZzdHVHlzUlhXVG44YzNkbk1Rc1pvRDliMDdzc0t5Rzl5VzVvSHJu?=
 =?utf-8?B?OGYvOGdIWkQ1OXViSWlGeFlhdUM3YmZ1cXJ0NWk3aVFKTXpTVENUbzhER3dq?=
 =?utf-8?B?aDVrQkR6N2VKRFh1N0YzckZQMmNIZlp1Ujl3RjFQV2NxSWpCVGhDWWxFVkZR?=
 =?utf-8?B?allaQ1hteG4xOC9GaURKclFIM2J6Z1d5V0xTSWgzUGdxamNaOFFUVkFYaGU5?=
 =?utf-8?B?OENBc01XZWorMnp4cTVONW5DQ2VxRExxQktLRE5xbFF2STMyK2krRXhVS1pO?=
 =?utf-8?B?R3pyekdrNGY2R1VwVllLZ1FOQmh4VnNkMGtSc1FFbzNEQWVGWGpxSlhodHpC?=
 =?utf-8?B?ekxFZTBNd3N0LzNla2ZibDgzVEllTy8rN2JhMzZyQ1VsVjRlUHJlcUVRcTA5?=
 =?utf-8?B?SjBnQXNYa01meUNDZGx5VHYvcHZ4bndTd1hObHVUTTlLUy9lZTl2RThDMEFB?=
 =?utf-8?B?NzF0bTM5TTN4VWlGek1QanVNcktkR3dLeTFTRTc5WEJLeXZSTkF6aWdLQXpw?=
 =?utf-8?B?N1VabmlBQXcyU25VYnZDWTE5bEh5OE5jTHh6N0FIbHN3THNoN3NDbTNWdjZh?=
 =?utf-8?B?d1pZRWNQY2JBR2dwYmd5ajhpM3VhOFowNjhSL3ljci9FeDFwWXRybXZqbFBM?=
 =?utf-8?B?N3c5NTB4S0d5Sk1ZYWlZVWpZMjVWQVVOR0IwU3d2cCtNaUx0TlpJaTNERlZB?=
 =?utf-8?B?YzA2Rk9ZUUlteDMzQ3dUeElRZ0dtaVJpOEVGVXRiWThwVCs1eldnc1NtQ1VC?=
 =?utf-8?B?ZGl0QU9id2RqcHRCbld6cjBqeEo2Uk4xeFFoWndiMnYybWk3cGowUnV6K2lD?=
 =?utf-8?B?VXJ0WHdUR1JRdVJ0aDlFN1NOOVc0OHlkL0krM1ZTY3I4NDA1dUlFVmpjcmlJ?=
 =?utf-8?B?Ums2R2pUTSswSWNHU09KdTJsMXA2RUhGdnhVZGJGK08vNkRUOWxKUUpLYXov?=
 =?utf-8?B?SWxqS0tCVGxHbE1pTXhCUFVJUkRoa3N6YU1aTEJORDE0dkhBWTdyTGhhbjdR?=
 =?utf-8?B?TEJiT3EyenptVGg0Wnk0WmhaUm1aODRUTlFJOEdNRnJOdm1SQVpmMlQzMk9p?=
 =?utf-8?B?dWppVDhYbjd6ZEN5M2FQa3hOWFM3dkMzVmZ3dDQxNXlNTTZ1ZlBBblRRQU0w?=
 =?utf-8?B?K2RvblJmTlo1OFhMbW40ZE4raFp3TVFkdXl4TFMwQnpGQW82RkdseGVMSnNP?=
 =?utf-8?B?T3hpYy80R0V3VlUrV1NZZXh5eFV2RHFvd2dnUEd6b3c0WFRXMUFyUmIvSmda?=
 =?utf-8?B?NW4raHZZQ1FqZXQwRE1JT2NSUzdVS3diQ0lpWW1jdTJyZUNNQ3FrZ1pPK3VH?=
 =?utf-8?B?UUlDaUd4KzlSNUFaOWczZDRvTVYzQ1hpWllLM1FkMjJraFhVR3IyTVZlUUlv?=
 =?utf-8?B?SUZoOHNDUUNIMWxRUXhTcEtNanRPVXg3Vzd4K1lYSFdHTlN5cThZejEvRys0?=
 =?utf-8?Q?5x/0EsMXWUQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkNLMUJFMzFPZlpXUVlKalhIOE8ycTJzdlZSdks4cjBaaHA2QVlQMFNzOGZz?=
 =?utf-8?B?cVYrVjEwc2tkU1V1VnpSd1gyRnZudldLMFkvdW5wWElyZG1vdm53TzhOU011?=
 =?utf-8?B?MkFLMkxBT2I3K1lkQmVRODVKOUtEYXNwNVRTaHRkM29qUldCWXJXZXlVSlJC?=
 =?utf-8?B?MXR3WDhOWGxjOE90Vm14djl4M1lyc2pHeXFBanV1TXFNRlBZVzBDVGFDQUlo?=
 =?utf-8?B?bDkzcmNSa2FlSk5FMXh6Nmp3aGlFK1JBLzNsb29LaXBUT0dkMXA1b2V0eU4v?=
 =?utf-8?B?WHljTlFMeHhPRkpNSjFaQ2Uyc2ZDWnJoS25LNm1nOGtSWFlXdXpMNjV6NXA0?=
 =?utf-8?B?NUxqUUtxdE9HZHpGbHljTDBxNmdFM2xjUUFleHF0RFJXZG42aVV1cWhFc3ow?=
 =?utf-8?B?MnN3RE9pajBrT3I5L0FORGN4T3BPQlQvL210a0pkUmhJczNmeUU5aitDMUU5?=
 =?utf-8?B?a1puYnpFL1pyaCtZMWJYa1ZXaWJuUVpad29UUzBsbDgxYWlSSlNvMTdyQ3pR?=
 =?utf-8?B?YzF2KytqMHk1SHdTamVjM0x2Um5yNHByNkYrZUlDVHI1MlI0Q0t5ZGlhZFJq?=
 =?utf-8?B?R3VXMEhVSEZGc215aG9aOTRpbm9Sc0dMcTNxUkZXOTh2OHJkNVZ2Qll2aExn?=
 =?utf-8?B?R280dTZxOGE5bmx6YVdJbVV1S3c1bXFVSkdHNXhsOG12akVsRXJ3ZzYwdEtC?=
 =?utf-8?B?bWFDb0I0VVA2UCt0c0dKQ2lycHFOQUVkKzNrUDZ3VlVwd01KRWtJQTU5VkJJ?=
 =?utf-8?B?aXZKVklCb2hZMWdkWC81N1dnbUhDYllaVVJJUmZsMWh2VFZGQ1FMQVFJT2I1?=
 =?utf-8?B?SndGUEM1NWp5TVYzdE1POWVXRVJ5R202YWg2VmIvcUdhNHExVXVvZit1cS9n?=
 =?utf-8?B?MC9hL296VnIvTmVRUWhZWC9YTFN3dzNxdlBXU3Y5SGYwRGxjdENpVDRsd1BU?=
 =?utf-8?B?NVdIalE5RVp4ZEJibmlFRWdva3kva1lqak81a0xCY1ZPNytPS0Zqam1qN3Y3?=
 =?utf-8?B?c3lRSTNhWXpFVm5SelNETEI2Vks0UjFTUE9PeUR1R0VxVW9NSjllNHlqSWpD?=
 =?utf-8?B?d3BpYkhaY3oxUFg1eStSeFdFTmtYUmUzWUJYNlowZXlKMnhZOGJaN3JtZFp1?=
 =?utf-8?B?dmZ5OVVnVjVJTi91SGRRZnhEd25qNjdJMGlFbFIzeGxUcUNxckxPUmZxaXJE?=
 =?utf-8?B?VXhteFZpZUQzQUpNbnBRRTl5NllRSWVyRlZKMytyMUhnMW1XTGlURmRPUFNC?=
 =?utf-8?B?R1VabG0vbFJOaG8zZFlFZHh3TTVMQVZXY01yUHhRUm4vVDMraU9XSXFIZ3lx?=
 =?utf-8?B?aHhYUE9GNzRjY3FDUWVUS00vNFN0UTArOUcvM0VUY0NPMUpBa3AvOE9kQmNq?=
 =?utf-8?B?N1YrYUlLeVQxUDJiYnU5bVJhSHpzTEJRdWxLTEhHTmcxYUZYWmxPbzlCUVND?=
 =?utf-8?B?YWxqQU0vWGxHU0grMEp4ZmZRTVBlZEgwbWFZbXZDaDBEYmIrSDFuN09ScTZG?=
 =?utf-8?B?c0YwWFExVG50OGsrdkFhaTYyS1dWUHVJSm1lQUU2MkJIcVljanNhRU56c3M1?=
 =?utf-8?B?azJGQ3pLb2ppYldFZnBkZkxyUWlEQlBQcWk1K0xXUjMra3hUWkU4K1QrS2lh?=
 =?utf-8?B?MU5HM2Z1Z0xGOEdkeVo2V0pNd3A3K1hteEhSTHdsWnFMMFVVb3BWTUJqRjFz?=
 =?utf-8?B?ZDY2ZzNDT3d4YzQxMTMralJUR1lOeHVnTWlsaHFJZjh3M1g2Y2dnR0hrbkdj?=
 =?utf-8?B?eU00cUdOUEduNC92Mm5aQnZNQnJvY2hNKy9UT2V3ZXl4bnQwbFdLbGZqOUJO?=
 =?utf-8?B?elNNZWlPUFdldUVNUlhza3JnUkl5bGxSNWZzNU80NENqK1JyVjZHQUdSb2ZK?=
 =?utf-8?B?OTFTMUt0bTcreXJsZzBkNWh6VFAwMlRkZlVmb043dXVHUUV4VTBWNWFsOVUy?=
 =?utf-8?B?Rm51Sng4U2JZWVNTZzZzbldmYzRtbGV3cmQvenIraWR6d1ZJS2V4YXV6M05V?=
 =?utf-8?B?M3RZSEtwNlVaZHoxRzNuOGJRYWp4cFl3Z1FVTDUrLzVmUk5ZbE9jdUdVQ3JC?=
 =?utf-8?B?V25JczY0R0V5a1hWcnN1Qno2M2pxOCtXZmZrdDJXd2x1ZklkR1NiVXdFVjh4?=
 =?utf-8?B?U09IRlRTMldlNEp0cU5GMkZtaXFVazR6VlMyRTJTZHdRaWNtOER5L2t6d2N6?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6023CC2A8832ED40A4AB7B8F495ACF8A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+UQPC5Ok9iRQKjepKUNQdtpMTB2/NG7DcSCfF6a61tjiguatKsiiSGlwfOV+HdtPpVUriIPe2yTRpj44plyFQLJoFuIFv4N+k/Jc7b5SEK6ePP62U4T93o+w9f2QWbU5pEnITcz6UYDKQcJ1MlN4PQ/oXRsEXUJiJFGJM23RJri86z0XdILsEv2acUa6tfLNFB20gdcGli4rEuf9t/PjrO6p/DLi6UIvqwmJ4WDjOKsxtNvoDx9mb4epT47I8HF8li5A1k3TYPZ3mKilA6slH/4VzgzHL5KAV+Ci8/BA7z0PVpxSH96YI5HBbK6/2gKxPB2ROLtQxsT9a6nVBdi7gonRBA/9rWlYsg3Y0wfdpUtSYcaBDoEtso9YabiayTYS17rxYkjqGxxXwATtpJbZaUKdcHYW1rD2mvJ2axns0ucstueVqAwQ4jznjt6+7xFgZoWyxg2Zg9hSem0GKzsleu5/9LE5miDXwjcTnZSpc1rc4bk7afZH2jsj8D3pHDMw9SZVQIWw8EA7UF2pnRD5AxEB9/MkwaLPBhbc4NY8fsO9PDiT36HqfiDVbostOmazDLt1ALWnqc9d5dC/oUTCRHhFYkRy6Zp7exphnR9WLiCjv2MO2oCgjoTXka//bv1a
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafd3f85-a168-49f6-3379-08ddbe2fa94a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 14:56:46.8967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qpNk5Ntukh61ECMyCNOc+oDNXamHOkZJX73Qt3r65219zuXRCArgZBfs+j8G4uAdPLQXiGRAsVT3S6kiL4yn2ICaxJ6HNXxXQ4TkV74shws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7032

T24gMDguMDcuMjUgMTY6MzMsIEFuZHJldyBHb29kYm9keSB3cm90ZToNCj4+DQo+PiBXaGF0IHRy
ZWUgYXJlIHlvdSB3b3JraW5nIGFnYWluc3Q/IF9fYnRyZnNfbWFwX2Jsb2NrKCkgaXMgImdvbmUi
IHNpbmNlDQo+PiBjZDRlZmQyMTBlZGYgKCJidHJmczogcmVuYW1lIF9fYnRyZnNfbWFwX2Jsb2Nr
IHRvIGJ0cmZzX21hcF9ibG9jayIpDQo+PiB3aGljaCBpcyBtb3JlIHRoYW4gdHdvIHllYXJzIG9s
ZC4NCj4gDQo+IG1hc3Rlcg0KPiANCj4gaHR0cHM6Ly9zb3VyY2UuZGVueC5kZS91LWJvb3QvdS1i
b290Ly0vYmxvYi9tYXN0ZXIvZnMvYnRyZnMvdm9sdW1lcy5jP3JlZl90eXBlPWhlYWRzI0w5NzUN
Cj4gDQo+IEkgYW0gbm90IHNlZWluZyB0aGUgY29tbWl0IHlvdSBtZW50aW9uIGluIG1hc3RlciBv
ciAtbmV4dC4NCg0KQWggT0sgSSB3YXMgbG9va2luZyBhdCB0aGUga2VybmVsIG5vdCB1LWJvb3Qu
IEdvdCB0aGlzIG9uZSB2aWEgdGhlIA0KbGludXgtYnRyZnMgbGlzdCwgSSdtIHNvcnJ5Lg0K


Return-Path: <linux-btrfs+bounces-14387-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0AAACB9D0
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 18:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF0F3BE268
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 16:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0010522173D;
	Mon,  2 Jun 2025 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="k/WmS6x+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CzbT8bvo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820AC770FE
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748882801; cv=fail; b=bXwPBQCRGIzn/MasWfUCtZApvatK6s/iFFN1sHcTpP31XkAAUEZRczXUbz7V3GfvYvUnByLct33Ehnqu8wRekC152Ui31WejW3+hj9AIcZ6zxzSfc8l8StV09taj6KI6zJfatJBfi0W5dLlZXancPADvyxOa4ebU0ikVBmmURaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748882801; c=relaxed/simple;
	bh=hEAXUzgCa/7VubU/kqVAqP1ACWLauPrFwp24h42a/Y0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FI4vrSIIexuuu0/ZhoTuuV20hFBgq1aENaQCzz2KHEQWEzTOACoXA83Pr95mYth5kvhQ5s5E6IYFmFjYwAT8cztY0YQR0Efwv+KWoBRPDFlaeuee9aEHUr2bWquVjJeWuce30X7qI+QpbT/GFUd0WbuM3qE+E4skbh3equKarbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=k/WmS6x+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=CzbT8bvo; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748882799; x=1780418799;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hEAXUzgCa/7VubU/kqVAqP1ACWLauPrFwp24h42a/Y0=;
  b=k/WmS6x+6BTG6X9rew3xhI6CdUZ41LUjFNEdv1iO021kee8Qggg5qQB+
   Alu2jDjuneJsHnfrcWdnjgCLLF2ld9KwRrA9uTq7wGJw6FWUuMCxY8XKO
   K8yj7pbhfpZCQVW5z5VTjdSrfIT7rclANTcC9+no3Efp1kDkoVRtCqVau
   hWQ7t3SKiGezfHBGs/pdCWpL0NyFQ8hQJ0N1bjxRe4FwtwLcRws+POIdm
   rzeSlopHgnt3kx6zjvJwzxZDPs1/6DWrfJFV0W9G+hz2xCZ06VERGj+aK
   nq6RBIccRwhZZ+sasK0xoePMJc5EgZfepk6ZRu0F/9LosqYjqj7PnqDQq
   Q==;
X-CSE-ConnectionGUID: dkgnrsE0Q6y3HkZyCiqXXw==
X-CSE-MsgGUID: mrOlxEZ+SqmTlDoW60k0Rw==
X-IronPort-AV: E=Sophos;i="6.16,203,1744041600"; 
   d="scan'208";a="88784961"
Received: from mail-co1nam11on2067.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.67])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2025 00:46:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiQkmpukfLllQQ4TDQo7STik5piZiNDfP5ziaer1n1ItRV+eChmSI4TdEdEvKOjQA8G2AJ2AsT0pRrJx8M+ZVB+Ryc8T3hRLkjdPY8Fo3SowHCRM+LQH9pZNRSiqZ/0PcMfEU2xFASh3ko7o9uSmUva8aMTo+7I9iZB7kltRxEVYNjbOMoDUbSV3yFup0jZQ61TkxiQTZCFYjpVVswEezv4IhoIPpUuiYhasykQDvrtKEoAw0VoCI8YKqbRW+/CkRcJSQtY+noUCmsMaIyNDZRQtUAGtzWrMmXlkFD2j/rLl4vv7cEIHKDnt5DZ30gZa1XQ58cx4pw66KcCDG2Z0eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEAXUzgCa/7VubU/kqVAqP1ACWLauPrFwp24h42a/Y0=;
 b=wihQKygJJsJ/a8Pwl/oLBI1i6NO//NqTSgkjAlQ8ob7QPlCH675WVnD2FW+TXL0yfNiiyzozDGNe4r5sRH5FMa38G2JvY9bdARy8+/eTIvqCkhC/9t1jz9OjURNLWTzTax2yHySdxzL62t1mdA0bWBbdekV6WmPaHO9HTvs2grWGuEXweyD33cu1TTpOeo1LzDzAK8Sedq9GgHpSNdOfyFqf7TguePeCx1njo9lqdEKGeFp1+TJSfetWeyIFQGPiriCeXpsHWgHi7v4zrZnD/fjqa8pFw6gyXqPwT8YzJAZq15Thg3F7C5nvlEOiM+JuEDoxcfJ1ug0rVZygjlzZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEAXUzgCa/7VubU/kqVAqP1ACWLauPrFwp24h42a/Y0=;
 b=CzbT8bvoHuSHoiyUFSvkuiN9omVEBIyvT5LkjT5K+5eGdZIeP2EwdGZRssKdR4l604gvicvg26PtFfa9XwYjku3ZzOvByZQRhv3ptHsukU/3CDzKchCm8Fbc0pLMVeiksno6Xyjjor5pF/Y+Gog8lhGuGgxQ8sQSdeejVp8x3Cc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6550.namprd04.prod.outlook.com (2603:10b6:a03:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 16:46:29 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8792.034; Mon, 2 Jun 2025
 16:46:29 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, Josef Bacik
	<josef@toxicpanda.com>, Damien Le Moal <dlemoal@kernel.org>, Filipe Manana
	<fdmanana@suse.com>
Subject: Re: [PATCH v3] btrfs: zoned: reserve data_reloc block group on mount
Thread-Topic: [PATCH v3] btrfs: zoned: reserve data_reloc block group on mount
Thread-Index: AQHb09pOFPjyRmTR3kOAMjnvbBHWtbPwEUuAgAACxoA=
Date: Mon, 2 Jun 2025 16:46:29 +0000
Message-ID: <7b04d71a-fe25-4d98-bb7b-25515be65177@wdc.com>
References: <20250602162038.3840-1-jth@kernel.org>
 <CAL3q7H4p4RQ46vCUJYREn3BgYa9SBY1eMeaGpyM=0Jz15WH35A@mail.gmail.com>
In-Reply-To:
 <CAL3q7H4p4RQ46vCUJYREn3BgYa9SBY1eMeaGpyM=0Jz15WH35A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6550:EE_
x-ms-office365-filtering-correlation-id: e782488e-ded5-448a-babc-08dda1f50602
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d05Mem8zeWpVS0Y4MkRCUFAwMnJIZlA1ZkI1dFV3YjNBSTdKbFRPRVZsZE8y?=
 =?utf-8?B?UGVGaS9rY3hwOGtXZ3gwc2JpZVREUkJHcDJyVHhPam8zV09TVndGT2xKd2lC?=
 =?utf-8?B?d0ZGeisvMUVWb2s2OXhJTENreFYzbGFsb2tYcnN0QTEySWZaWWhVR0dDU1pl?=
 =?utf-8?B?NVJlY1RXZ1Y0NWpmNjkzYVhabS9PamZWbk5TZGgvVkxBY25XZHVaeFFKZWdp?=
 =?utf-8?B?OEJ1N1RmRVpWRGtNQ01DZHJzMkdOcFY3MmhkMDIzNGsvbzFqeXdyV0NKYXNH?=
 =?utf-8?B?UlNNc1drSGFWVmlPdm55TVBxcnFSaFRIM1FhOFB0VkZpWGxmZDI5OSswWTh3?=
 =?utf-8?B?cDdyejBNaGhvdFdrUzUxbk5YNnZhSGFhWmZpZncvdFU5RU8yMldYRncrWWFC?=
 =?utf-8?B?czVDNC85RUVDc1FTR0l1RWVzTmN0K2w5ZENMRjBxQmQzU21lTjMwbFJscFpn?=
 =?utf-8?B?L0xXcGdkZTJoanlidmh4TVBTcjFxNUNMK2w3QU5iRGFYcWlSME4zdk9KUjc0?=
 =?utf-8?B?MHl1U3RZa1VJMnFNeTI0d0xwb2tUQ0dNcnZIcDRaNnl4bjF5cm1IbG9UVnFz?=
 =?utf-8?B?TnhIUHdXZXpITFF0eFV1b3hMQ01pV3F4ODJEWVpyTisyekdHY0o3dDRFMlBC?=
 =?utf-8?B?UXczYTN4aDN1RkluMUpyMXBqN0JobGhKeWJpMjIvL2NpZ3Vjd3JYbXJiWGZH?=
 =?utf-8?B?YmxENVhlVHFSK0ZGRTUyV0V5NmtrNGxJWkVkdUVVZ1BJSEhVemJKc3A3M3JU?=
 =?utf-8?B?MWpFMzhzdHc3WVZoL0FObGFwQkZKNGIrVStvdDZPWDc3YngzM0tTbW1HMmpS?=
 =?utf-8?B?S3dUeUxoL0xaSVNLRDdEWkdsWXVMMHZ3R0h5Qm52UE03T3pScC9QZFRZeXJq?=
 =?utf-8?B?OTc0blUzekVHMlJSVmFuR0RoTjBsWElwUGtPZHNTOTNyZzljMlNGQWFITTVP?=
 =?utf-8?B?Y1k4QmRDSHJtS0tZV2tpMzRFd1lPZldBWVNFb0x0Y0drOE9DempZWVNwZGZo?=
 =?utf-8?B?VkwvaCtCQm0rUnFvREZ2NGR6MGh2b3Q2bUhrOHJyOExEdWZLUG44WUVvYm1w?=
 =?utf-8?B?bHp5ZHhSM3hxTXFUTXZPUXpGMU43SkFrMm5GR0VQTGhBcHorVDB3WkdRVWE3?=
 =?utf-8?B?Smw5K2hOTjk5SkJUQkk2UENHTUlnQjNzUUFaeEZwanhIU2VmOWtSVnZMVXcw?=
 =?utf-8?B?VFp0VHQ2RVRuWmxmSnZnbXVvZjVObG5MMnlWN1p0UTVGZFpzblFFQ25JVHIy?=
 =?utf-8?B?NXRxbGNDSGU2UHpNMXpHZThIVldlY3FlZzFCdzlZUkFSU3kzekNScHYwNURK?=
 =?utf-8?B?R05VcVZjNU1WN2pEZW5oU1liWXQzQWRxWGhrWllxK3QrNWk1RUg2U0xSWlJx?=
 =?utf-8?B?RTJqVVA4V2tibzRjR3ljRGR1OVhTeHI4M284ZTR4OE4zSzFpVlh2cmJubUo2?=
 =?utf-8?B?SVRrbXk2cWlEdkFteTMwd2JsRndnT2xrMGJkZHlwMndhY3Rrbk83cGRSMUJT?=
 =?utf-8?B?VEtrcHZCTU5jSXRXc0lEaUZweTVIalJTUUF5VVl4Y1dnRU5SZzU3NEFDSjV1?=
 =?utf-8?B?cXZsbE1CcXJ4VGM0WUYwcUR4UTRwOFU3THNKdGxFbFZTRDN0dkpPN1pTcFVy?=
 =?utf-8?B?dStuSnpLNEI0cmliS3RlOENueGhmT3BYVE1VRUJCSFFDc05GcWFWZjAvSzc3?=
 =?utf-8?B?eitIWW96Ly9SOUU2aStadVZJNDNtY2JDWS9YbHEzc0haSTducUpkL3pGRita?=
 =?utf-8?B?bkxUcjNwdll5WHg3V3hRZ01wMEx2NEVWZHFNMXk0enRvMVZnVXBDQkJqM0pQ?=
 =?utf-8?B?ZU0xL3U0ellNUFRMVWZTOEFDay9CMSs0Ulp2U2NIL01DNFhEbGlZaVB2dVNl?=
 =?utf-8?B?bTRXakJscDYvTnJYOWdJYkl6MFYrS3J2OE5XcjJCcjZSZ0RSaURnOVB3QWZD?=
 =?utf-8?Q?yRZDEv/PK1Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1BLREdYc3hMeTdDU1ljOFV2eUsrTTNpajhqNlpiSGJSdlpFYjV6QTZqdDRO?=
 =?utf-8?B?U3FsK095N2xUMVFaTkFhbGRRT1dHVUNCVDdlZXk5YUV6WC9TS1lxUWZwYUZC?=
 =?utf-8?B?Nmd5N2RIWXVJbXZMUllqUjRKNWJkK0xkWVhtOFU2cWZKUUZNbVFXdmhDZVhP?=
 =?utf-8?B?NnMzMEdNcW1SODU3d2t4RVE3Q2J5dkUrR2VNMHhLeUYzdjRqMWwxc0dudVZ5?=
 =?utf-8?B?NXUwQUREMDUvdlo0eTN1TkNUNG4rV3I4RVdyTWVHajB4OE1sM2toVXhvSlRh?=
 =?utf-8?B?UE5DblFrTDNDaHJsTFh1b2NmWXg0T1JoYVEwVFZOK3hJU2x3ZVR2anhpa3NU?=
 =?utf-8?B?OTBZL3ZxMzE4cHhFdnV0UmgvM1FqbzNwNElkUkU4Wkg1bjV0WExac0Q5QytM?=
 =?utf-8?B?RVkwQXdTYW5VbGozeUozY1ppdm80T0dnZXJwZE1INk1DY2dIMHZMWC9SQ0Uz?=
 =?utf-8?B?WlRhMzBVYmlmZXA2dFlML2hIMG9jQUViU3Bwd3FyZzFoRHpBclROUHdTbXhZ?=
 =?utf-8?B?eUd2YTZUN3RtNEl6QVJwejZGWDRENUlrMURiU3BLV1VaMXRtU3FRb0J0NmRD?=
 =?utf-8?B?Yk93dW9IckVwaHUzbWIyeXlLUHFicDVVSEwwbUhtN3Z2UVBRQStKeVhaekhk?=
 =?utf-8?B?d0NnVGxPTlpwekxmWFhaZkZFUDJpZy90RVNCbDVMZVYrZ0xQVkttaWJvV3JU?=
 =?utf-8?B?TEw2Y2dmdmE1bFNYMFBtSXFyRFFZZWtTK3dzeU9Ta3ZFb2h1dEdUQTR4by9H?=
 =?utf-8?B?eG5MN0NrL0lCbm8rY1pLOUdXNC9OeHp4SDEzS1U0ZTIxUk9LQlZBMzNaSXlV?=
 =?utf-8?B?Sm1VUnNTSGZoa0p6SGtzTCtERFF1LzBubjkxRm9oeHpnWEY1ZktJdDl4eXFm?=
 =?utf-8?B?aVVCT094bXNUa3lLYUo4U1Q5cUloQWVpaEx6dVp6MzdqZ1ZDc2FQdjFCbGY2?=
 =?utf-8?B?MGdhY2Vtekk1YjdZWGZIRmJ6UDFtOXdEZVNKZTVCUEhnbmlOMTFtb0lKdkln?=
 =?utf-8?B?MDhLTjlhaGFmdmZpTkRUdUQ4dGZPUXlmczM2N3hZNlIwRmsxREo2TVdhSnVK?=
 =?utf-8?B?UkRyQktLcVh0NGJRdk9xVHdVVlpyaFBVcW85VlNhS0ZJUWV6MWcvZDFBN1Ur?=
 =?utf-8?B?UGpRMjhrMWVVbG05OUtHeGV1VEdSQnhjc1lLa1hrU3B5M1k2eDVjcmNZUlBH?=
 =?utf-8?B?VFJEcG9SQ3FGQ2RCWUsxM1lud0RneXVZZ08wSTI4ZEVMTnErT2RXZnNOa2ps?=
 =?utf-8?B?bkNITFA5YWhTZVRlc3drTXBvMU44TmZkcGxnRGlUNEdkeGtkRTkyV05QRW9V?=
 =?utf-8?B?NnBtRnJPeWhiQTFHcGczNmRIMkJxYjJ2QkJPdjVKd3d5eXRKeHBBanhZUEd2?=
 =?utf-8?B?TXdDdmlER1JtcFd4U2xodm1NVUZEYmVSdGsyZFJha0dTR292VFZsVHhCcExv?=
 =?utf-8?B?WTN4a250NWlNQVNMbGI3OXFuVGc0MVhsZ0hvazJRS1J5WTl4NTMwQVJmbXZ0?=
 =?utf-8?B?c0F3Uy8xb3MwbjBMdVE5U2U4N2lPVXpBeDkzZkxjTGEzN2FsdUFOTHRQOGpO?=
 =?utf-8?B?bjVyL1prS2JVdDhvR3JrMDJDWHhqVmU3Tzl0clI4clBXQTZkSTFGdEI5L0NM?=
 =?utf-8?B?Q1ZvQldnY213THFwVkw2ZGVBSEZTc0tEQXJZSkZtT3ZOUFg2d2VGOS9UeWlR?=
 =?utf-8?B?aStUaytmOVNQdEZydWlHWEl0V3BmTFJsYi9LMGlWckRKSEsrbEJKT1lzb2VZ?=
 =?utf-8?B?YUNRWmhVYWtPejExRnZlQkpTY1dhYUJ1cDl1T3Vqb0VQblYySkhQSmNPYStE?=
 =?utf-8?B?R0pVVktuUXFHb0s2VTJvRWpObnZyekYxckJmM1ZQekZ5bXZ1bUpOcVpkYTZl?=
 =?utf-8?B?TTJSZjlCL29JVmRLTC9nWXRuVTVFWkxnRnFVdlZrWG1qQTJIcmhDY2I3QVc1?=
 =?utf-8?B?Q0dTRzRDeWNucFF0QUw2L1JrWkhXbElyUFZpaEpQZFRrdzdGcHQwblRPWWNM?=
 =?utf-8?B?bXl6T0FUSEJFbWZ0TEF6b25MdzhSSlJvbzRITGhSWEhZQUZnc1hmSlpyYktR?=
 =?utf-8?B?eWtQK3c5a3FwTUZUViszUDMySUQyWjlKZ25ORnpncDVFSlhVUjVGUG5yaTBr?=
 =?utf-8?B?czU2ancwNklQRGxqSG5zMjVHSTR1MlM2RW5qZkQvRkY3SW10aGpZbldCTW1P?=
 =?utf-8?B?R25vYTNDZDFTdEtlaVdCeUF4MUNxdEN5SHhMYVpUcittTTVKVktLV2hXWEZ6?=
 =?utf-8?B?U05YUnI1b09VN0JuejRBdUZFOUZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <194379D00CA1DE4F92D5B660C56C39CE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	82VKZ8qzvZZKoxKcyFCV/tfQ1PqXekVxkx5X/NWxkpM79PZYPRpfGo8VS7vCG+FZ8wTmmTRhFl1qw+B5S/yJ3lQo23ccWxJCLo2X3jxOyjPxi+eaeBuCD5DpFsS3plZ3qBAUS0gycw35C3bhT6aRFct7q+or/zAajnmbqPHQt1UBF+FSnpvFs7AxsaJBpA/DuWZXY5fW7YLtDWyZNvhlHx46+33gBbhN2shhVk1KfKCNUqTzNAjsDd3v+yEro4qKvCa8McWfL6lz9A2XtLSNEhU2q8uSoHOJ514p8+mAZ6ayWAV02q+/zfB65MCWsPLQJ4B/Ds/yEggtAYfw0HCK9bONn6IvCT+tfe4WCj1KGyOrY59slEVTwmI2ZoMwG283fwl+At1agIudR9axMqoPWHK/siUNmn3HnUgMzwx0OaEcuHZr858FBTiVQwBpVRA/PGVwB5JYQQeeln32mZcTw/BQ47iMjCPSXF5sg01rC9DtXVJOI6gQ8Zo/kO/5+hTKCVSPHB8650pxnCrRIn3zq+n4tecGIIxtVgdbaTtt7YNBvqJb10vQ76LQZw/Parv7JggN1VQuK2L8hamtSZmuGsJS20d93aSFkYY+/P54JI2lCqfYZskdXKKF7eQALP/P
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e782488e-ded5-448a-babc-08dda1f50602
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 16:46:29.6085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VW9nTE9amRvvILiMHW0YPupCrfRadDp7CTvHiFeUUdP8qDxWOxknm9xAz7bts9s4u6lEbKHxSO60AeXfY6PlsGb7+cEfke3ACUeKuQtt/Yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6550

T24gMDIuMDYuMjUgMTg6MzcsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IEluc3RlYWQgb2YgZHVw
bGljYXRpbmcgdGhlIGl0ZXJhdGlvbiBjb2RlLCB3ZSBjb3VsZCB1c2UgYSBsYWJlbCBhbmQgYQ0K
PiBib29sZWFuIHRvIHRyYWNrIGlmIHdlIGFscmVhZHkgYWxsb2NhdGVkIGEgY2h1bmssIHNvbWV0
aGluZyBsaWtlIHRoaXM6DQo+IA0KPiBodHRwczovL3Bhc3RlYmluLmNvbS9yYXcvanJGdFVWRmoN
Cg0KTm90IHF1aXRlLCB0aGUgMXN0IG9uZSBpdGVyYXRlcyBvdmVyIGRhdGFfc2luZm8gdGhlIDJu
ZCBvdmVyIHNwYWNlX2luZm8gDQp3aGljaCBpcyBkYXRhX3NpbmZvLT5zdWJfc3BhY2VpbmZvWzBd
Lg0KDQpJIGNvdWxkJ3ZlIG1hZGUgYSBoZWxwZXIgZnVuY3Rpb24sIGJ1dCB0aGF0IHNlZW1lZCBh
IGJpdCBleGNlc3NpdmUgZm9yIHRoaXMuDQoNCk5vdGU6IGxvY2FsbHkgSSd2ZSBkZWxldGVkIHRo
ZSBsaW5lIGJyZWFrcyBmb3IgdGhlIHNldF9iaXQoKSBjYWxscyBhcyANCndlbGwuIFRoZXkgZml0
IGluIDgwIGNoYXJzIG5vdy4NCg0KVGhhbmtzLA0KCUpvaGFubmVzDQo=


Return-Path: <linux-btrfs+bounces-10899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EADCBA08F89
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 12:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010B018865F8
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 11:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3D620B217;
	Fri, 10 Jan 2025 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HfdHUAQ7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kbMQX0QF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664F22054EE;
	Fri, 10 Jan 2025 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508816; cv=fail; b=GQcTXUIFO9WVu6oI3lKccgGGGCgkjnB1YkqJMrDPiiCqSLGIx+GAEfNrDcRa7Spra68D4NGd0RHBpd6x6GafEvpwWzME/qi8ITc2Y5y/bUT8xTx4A9J21FBMFVRlQADQPy1mBkN4Pxz9tFnljmV4x5fVAHUtdmHLh4gY9m6gVkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508816; c=relaxed/simple;
	bh=Tj3pQFv9gieFssdsYc4yc1z2UFzfLssxS0yXY9KYDUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jazqPcBtf642Lt7SU7KzzKirVWzGhaxBOeXy5LGFF4hcGecjrUkPkfLeMULU36We5rjF5wof7nkHQ5Y0yuLt5ZEC9mg7/Ynp8r2yJ8cp16/OlUaqHP27leqg340PA4B9aDx9nLZ80Qz1V1IZinKUsydzp+0mlV1CokYlJ1ofelI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HfdHUAQ7; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kbMQX0QF; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736508814; x=1768044814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Tj3pQFv9gieFssdsYc4yc1z2UFzfLssxS0yXY9KYDUo=;
  b=HfdHUAQ7SJ9YXefThUvvAuJt/nC4eIlaNidSs0LYczVeQbvi3DRwID8T
   a7hAsqiCdwYyK0RbJSWYLE7Zx/uyJlsdusHaQC5yK8TVi09Z/rgc5YxTq
   ckD4MRNHZQxiL1Uz7HMkldxFHYZnF+30HIentC9eq+XkTfgtGfxXW4Hg0
   9mD2M/eGDXTCKij4LlYqPSSbY8FRQTp6yJVF7rgEmWgrjDtFuPWXM0Drr
   Pku9njsseGbj0sJm/cJIJXv+bYX0XwbOTNMs0+LE+S11PDchoUjJU05KA
   O6LRgumq+ALiYsjAZDoj23Nykqc1C7WUcaRnQLRZGFYULGOANr4L011g9
   A==;
X-CSE-ConnectionGUID: hsfXEsmLTE+ngs0hukbqKg==
X-CSE-MsgGUID: qaBurhaYQHGvnHsDoV9BOg==
X-IronPort-AV: E=Sophos;i="6.12,303,1728921600"; 
   d="scan'208";a="36839722"
Received: from mail-northcentralusazlp17013061.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.93.20.61])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2025 19:33:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZvkFhgdSyK8Fx4d6u8f8CD4VZ8Puzoa0/E/zZGKHIrxuoOFz77mbaDVIY4tZTQIKOFDQXmkuE1NCa1RPP3vSS5ma48uDcv8pJ9iOf3mSdPu0v7ibQBoW/Lb5ZaVZSXyrpWT9lH7mZ2PrK+LoMP+6aTgby9MJj/Z2Gzs8o3+rU3yFxWtRqmuvadI7xqimtQl0zTDfGKM2GDkVyOyCDLju2lmz5jrtq+ex5k2ChgJpMj7DwPHpgS0Pu8TFVTbBGfV0h4+8N3kU8wun8e3Wmr78LJ0JbKqJeakkTSFGQV7F4kceqgWdltTHh31uk7N/kcYRqoyBrVYk2N2kNZX+92W9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tj3pQFv9gieFssdsYc4yc1z2UFzfLssxS0yXY9KYDUo=;
 b=KvpQnGsiYT4rEHykX/ZyoHClhToLXeXVG6I8E9DU0Bs74MDitnZClLw6QKCaFjmkvkvK7so/o2QHqFtKFPWEG48217Vu+XSVcxurx8EC0Wv1X0BqUEN+LoQp+2jPqDGBy74ZXvirNnuqEk9DU4fKq4Wbw2UZHvRqyEIRIN2FcxRkKjLKrl/S7+RgpHcKs+e9/iwwkRWNKaMu5u/6TPyxCHF6D+/AsxKEX9B+DkaC9LzJDZ+yykm86shIOqRorrIBoLds0ZRE+X1mLOSKVVtuw8qsy33XVjpyGlD5azhOpeExIT6nnX8fisuHmi6HezSD/74KqGTOsJHhNuNPwp2jkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj3pQFv9gieFssdsYc4yc1z2UFzfLssxS0yXY9KYDUo=;
 b=kbMQX0QFSqGRysIo3GXhWDmhELpNiymijgOmQ0nM+6bLFUAbVzVZPNdnhsi2a0DcHRvb5H1Bzx4ddqz8/fcvG+9YI4grTapZ2M+/aRoaLWFOKgZR/EURzdHDvySmoz6O/2TpAED5JBl1BGWn85j4Prq31eCtNgyQ/YlUKVxKGfI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH4PR04MB9284.namprd04.prod.outlook.com (2603:10b6:610:22b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Fri, 10 Jan
 2025 11:33:31 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Fri, 10 Jan 2025
 11:33:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 06/14] btrfs: fix deletion of a range spanning parts
 two RAID stripe extents
Thread-Topic: [PATCH v2 06/14] btrfs: fix deletion of a range spanning parts
 two RAID stripe extents
Thread-Index: AQHbYQJh6qct7qtkWUWwqVa9En7wlLMOkwoAgAFR5IA=
Date: Fri, 10 Jan 2025 11:33:31 +0000
Message-ID: <e277500a-41dd-4f3e-be74-c23ad692a540@wdc.com>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
 <20250107-rst-delete-fixes-v2-6-0c7b14c0aac2@kernel.org>
 <CAL3q7H6=EVN9PokKxsf6MiOo2DRt3N=t2ikm9H7U1FxB+4udCg@mail.gmail.com>
In-Reply-To:
 <CAL3q7H6=EVN9PokKxsf6MiOo2DRt3N=t2ikm9H7U1FxB+4udCg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH4PR04MB9284:EE_
x-ms-office365-filtering-correlation-id: 25184151-a065-465c-a05d-08dd316a9c6a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TlhWRTI3aGRib0Zld0o0T2pVbUxiVklFTjBlQWtxMVdDUFhOMUUwck4xTWFR?=
 =?utf-8?B?V1drWk9WaEkxd1AvNFJ6TzAydm9TaDhtUjJkTlpZVC9uZUFPOXVaa09wOG1T?=
 =?utf-8?B?UG1qWUlvSXZ5WUpqanlhOFY4TVZVS1R1YjlDWDQyUWR1QkIwWFluYWltcWtt?=
 =?utf-8?B?U2h4T0ZoaEJGajQvbUxCejZ2NERmeW1VUUE3YlVDVnRPM0J5MXQ3MkxhbGZ3?=
 =?utf-8?B?ZUFpWDFVSktTOTJWSW84ejV6S3pjaVZsNmNQQ3pRUXcrc002NCtkNkJXWmNG?=
 =?utf-8?B?RUliSXNVdk8vb0xWWmlEODNHQ1I2LzZmdmVCRllkQU5kd3ErNWVOLzBQYWhy?=
 =?utf-8?B?VWFlRGtleit5SEJtby9MNGtRaFV0L05UNlpIeWhURGl3ZWFVODlJcGt5dHB6?=
 =?utf-8?B?SFJjQXplOGdiWUFUc0tWbkhMWDFzSThxY3dhWWdwYkw2M3ZPSm1QMngvTnBm?=
 =?utf-8?B?UWUrR2x6Z3A5WFpRYng4eC9qRzlEeGhta3hxVzJVcTZDa290cC9LMGh0dmJK?=
 =?utf-8?B?TzNNWXd5a1VoNHZUc2dvMlZCWHR3ZDBtZ2V5dVNZWklNRXhQNTgxdi85ei8r?=
 =?utf-8?B?UlNXcFN5UzN2VERLUFlQRElWZWtCVnloREJodFFybHRVZnQvQ05BUWVBb1dW?=
 =?utf-8?B?OVNQUDZkbVRTRVdmc0ZOQlFHYmxrTjBFNEE2MVllOW15UUxtYTQvQTZiT0tv?=
 =?utf-8?B?dzF5SEVlRTZvdnNkNnBBSTRlNVRpOFc4QWpMd2o0UVF4UnEzR2p1cjB4aVNh?=
 =?utf-8?B?eGFXY3IyOFl1VFVxQzMrVjRGQUZhMnFRb2FyQ2gxQThCTGtya2dOdFI5dERt?=
 =?utf-8?B?V0kxZmZOdXdBZ2wxaHBGeXBwc0ROWm52SURnMjZXc0tiNmVsQXRlMU1Vb0Ri?=
 =?utf-8?B?c1NLRENWNGVLV1d5NUpGL0Q5MWtQTGdkQmNnVXBvTTZaQnd3SW9JNWhUU0Fu?=
 =?utf-8?B?ZU1wcGxOWFVpd1V4bUVOTzdKYU5TN1FhNEg2dDhIYi9ENDUxK3hSSTJEUlRR?=
 =?utf-8?B?NEtiSEo2MzNBVmE1Yk5FSzZ0V1AwZmpaZFE3dnY0QVFNWlgzK1BlT1p6THZM?=
 =?utf-8?B?WTJmVW5nS2RmdHFIMlBnL1lQS0xuZEhFbDVqSWFYNXVPaGU5UjhzOHB0SDV4?=
 =?utf-8?B?TkFoY0UvN2ZyMGhDMlRiMkZhSTBmTzdWL3dBTWNOZGE1S2VzUDhYSWRzRnQ5?=
 =?utf-8?B?VlMxZUVpdHdrS2JreXlMbm0zYlF1UUVTK2x4czZpNE1talRZTnF6T0JmOWVi?=
 =?utf-8?B?eGNsRWxFV2N5Y3M2bWVTblRWTXNiRG1HK1JBaEJiTEduaFU4Vm1adHM1Z3Yz?=
 =?utf-8?B?UkIxcTROVHdKWFlrTHhDMEJiZkt2M1pxUStIS1NtbzRlWW9SOW9WWWJzdFZ0?=
 =?utf-8?B?eGplc1Y3L1AyL3hDaXgzL3ExbHpzSEtmb251eXJNbHdtVWpJWGVCckQ3MUVo?=
 =?utf-8?B?bEdXWEdPT1pHdVV2ZDd4Q2EzSUJDRHBBYXNIVVltcEw2cEZDV3lsZ1lGYmFD?=
 =?utf-8?B?aGljNjcxK3hnUCtMNVl4TG95Y0haRHl2ZG41L0lDTkxXamsvMTdiZG1vSkVo?=
 =?utf-8?B?Y01EOVBFei9yYVljbC9MTzBQdXh1MFBKeGIrZG8rbmdab1FsWFVDYVFnZ0ti?=
 =?utf-8?B?L0lCNEozU0J4WDNCaEdnS21OdzJELzlhSXB0NGZVc1BMV0VkVEhNemswQ2Y0?=
 =?utf-8?B?dEdCYnQ5UWtSRWo1NjRKOUR1eTRueGZVamkwMTM4RjVLK3NSMWxPTFB2NWtr?=
 =?utf-8?B?dFAydHFuVHgzUVgxOWkzSGtZaUVBWGdkdWFVT0RkeU15bmpJMk1EcTIrTUhU?=
 =?utf-8?B?RHdJbjZXRzFwTzJGd2lFWk9zZUNOQU55bFZZemJNSEpwR3AzQk96R3Y5aXV4?=
 =?utf-8?B?T1lZWktuT1A3dnZnMUJnU3dRVG93VEtRUHkwempMT0k0UkVERFZ5RVZ5U3ZH?=
 =?utf-8?Q?rkGvp4eDxYcNTIDz6HJ94vHMIF7dNglz?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZFFFanlIYVAzZFVGU2d2QjRnQURKQkszeWtucTVPc2ZkbHFTQVhkSDNVMUtR?=
 =?utf-8?B?ek84MkRkMGpLWDFFYVdBd2gvSGtpSzFYNjYvKytETU5YTjVXL1oyS2NJV1ox?=
 =?utf-8?B?SUVTTUZlOTFxYmRXdSt0eFljREJRSG96a1NBR2Q4Y1ZzWExRUEd5ZThPSjIr?=
 =?utf-8?B?eGkvTmUyMjRUeDB5Rmt3SVEvVTZDTnlKMk5IdXB3V3doOVRMUU9kQzRHOGg5?=
 =?utf-8?B?NUlvNXZ6L2NrcmhPeGQ0ZU1teWpwSGFhMWZQaHBmZ0dWa050YmNUaEdrL21S?=
 =?utf-8?B?T1ZpZlZEUWUzdUVPTVgzN0hyMFFDK0oyVzgyVTFLc1puSEROVDdoWnhya0dt?=
 =?utf-8?B?TWFtem52YUhLRjlWdktLeDJvQ2VlWWg0R21kKzAybklqSk5qUXl5Y0JvS09T?=
 =?utf-8?B?MjhTUUdWOERacU5zTjNXQVVOM0FrTkgyZHVpNlgyU0xzbHRRTjRvcTZtWWZm?=
 =?utf-8?B?SWxONDBGR01tSUduelNEdm5wUTFmbmtGekJYQ1FqZjVFWVRDT05Ca29oaHZH?=
 =?utf-8?B?WGNoS1RQNVd3alNJdkcybnFVQkRQQ0RmTmJTZkRxR3cydlo3R3ZrU1hacnlR?=
 =?utf-8?B?N2FKV3R4bkpzQlNob2ZtVG1hRHlEakg3TkFYK1p1eEFDbU5SREZKWHhHbzdY?=
 =?utf-8?B?enlNcGw3UFBKWjEyY0FoYlJlVytDbU1rK2FWTGpZNFdSOEEydC9BZUZmVWgz?=
 =?utf-8?B?UWhGeW40eXU5amJWUnZYdnB2Q29paHdjTjBxVDVTdHMyZ0ZxZW9DT1hlL01l?=
 =?utf-8?B?dkIyQ09YS3FrL09MZitURktRWEJvK1Q3YlNHcVJuMGNReUZiZkxhV1E2Z0xU?=
 =?utf-8?B?Qy9GZHBUYjFCdkdpTzd3bG1IYkJWcHd5WmQ1RnYrTERIOVRxdWcveTc4OW9M?=
 =?utf-8?B?NFBlOW1ZbDIwUUJVUkNEdU05QTJodG1hdXU1TU1uc1hKNHVxNWFBUGxQYXJY?=
 =?utf-8?B?Yy9oWkZOU3JrdmZXOWlRMGRvTS9VOXdNN0JmZ2k1bGp4dGtCalVjcjdIY0VB?=
 =?utf-8?B?QnNxMkZCeFRDUVpBbFRaeS9sWG5wZjNGUytRVVZ1a3c4WEIvazE4cStyRjZG?=
 =?utf-8?B?eUJmeGJ1ME12aUZ6VWhmTUFiQ0lxN0RYL2l0VC8yUE5HR1Exc0EzY1BNSGc3?=
 =?utf-8?B?dmxvWWJpNUJsVFFUN2hkRlh2bkpaV2xRTHArak5EU0E0TmovUkl4RmUxLzJQ?=
 =?utf-8?B?V2UyVE5HQUVzVEVlTkR1RUFGQ2t4VVF1ZmhlbGxxRnljZ3ByWEJHSWpZK0Vt?=
 =?utf-8?B?UWFaL0F6NGRycGt6ZlA2d3V4MDQ4Y2xUWXlSQnZEdjhOYkpNUHY5emdOSjVF?=
 =?utf-8?B?azZpS3FUaHIvL0xGK0RIR24yVUJUNkd0U3FSM2MwQkRMYVpJQ3BMVXlaMGUv?=
 =?utf-8?B?anJxRmd1RDFsdzFLUXdVeTNTektaWkQ3UTMwY0VOOTRjWHlRNyszZ2xLY1hv?=
 =?utf-8?B?YTFBT2c1QzJIa1NRaEVFWWl2SkQzeVcvQjhKaFVTYWFPYVRQZUdiUW9vR3k4?=
 =?utf-8?B?NXVYTldwMk9xQ1licjRablJNc3h1U2Q0RWFSL0ZlamxxZHloeWkzTFRTUjg5?=
 =?utf-8?B?anoyQjJpNzlObTRnTjgveXVPQ1BBWFhHTGdDb0lsRXZ5L0hNdzBuSE9HdkVv?=
 =?utf-8?B?T2pBMUcxMGNDc01RcWN0QWx6d0pDbjA1L1FwV1RRZjJiTzZxRVBLOEhSejNR?=
 =?utf-8?B?c0p1eUM2YVVWbENZd1JrU2JhclZZSmJGNXBCaUhIa05wT1NSTWx1SHU4S2pT?=
 =?utf-8?B?ajJxUjRDZnVCV0tvK09KY29EMURPdUJqSXExTERRMTlvdlB3dEt3STJlY1VW?=
 =?utf-8?B?YVdpeDVhT0QyM3BXUC9Ma1BMbjAzY3R1S2QzQ2xXOHJUM3BSaG9NSmxqZ0tT?=
 =?utf-8?B?NjJRaGFNamkvYWJ0VU5DZ0hPTmdPRjY2eHc4Wjk4bVMxa3BwQkMvd0MrY3Nu?=
 =?utf-8?B?Unhpb21VMXh0cEp4cnloR2M2ZDRQcEswdkpTUEdpOWVsZm5GMmk3UHBHb2tI?=
 =?utf-8?B?WHFmQlo4M2lhenNObXp2VkZBNUtmR2xMWTVrYm1iKys0d00yQndRR0lXKzFa?=
 =?utf-8?B?RjgvYWRCNWl1ek1hRmNsQlNQWXpmYzJlWVlDOURaeURyT0tFOWhGMXlEVzRQ?=
 =?utf-8?B?a3RhWUxvMCtFUGhQZXZqUVorM3dYY0Y0NFpOUmZYMlYvU24yaDlRY21WeW5R?=
 =?utf-8?B?M0JoYlNGZm11YXBNMVVNU0wxRm5ZdDQxT2swVU1ybi9CZkw4a21NbXZMNWFm?=
 =?utf-8?B?TmF4b0RFSG5lQ2dLRnB2WFRZb0d3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE56903DAC104B4EB5936BDECF26BB91@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VSYAVLI6z4tVSIq0p0eDzvGaeF9UOr0SGA7AuKxEn9SYruGM06ko6FEoP5WDfCznLqbDAWYszgHuirDclbX8BDZx+4Pw7KxmzTGyfDyMviJ8kVbuBv9vq8hVI55YOYq8DihDgetxthCvtsl0yOhXu+JuNqDO5putME0bKdvofFDdm30bhoZ7KAjkqs+IG5AnNk+g4jmyFR280ZWEUXS0LGqJ18MnGaErR5EXcfwCCdcB757nY+a17xzxQlJWobRlv1wlTe71ZfMPUbU6qECVqs7vcsP8eYl+Whdx1GFe5RtN5PQg2D6nEbmRYpGyZKaNzCKgw0HnBxSzJFA3BZTuGl+0awr/s8VUYT4sjr5/0j7HqKLBEqOFY6WNVhV03u4yTYcwxedxtwBfczgkJ2TzrXYP4zIM0McJgLj0MlqkpnCgqOEs48k30Az7WzZe0wFxl/KJEPKcOI/IpUBVuyzR1l5aSFDtxeMZ7722BOnmbAcfGGCs/eOWv6us3VCXFHmH0Kku+/bUhnMeJX4Hybsje8h4cMU5zTBvfBYVnqFvpmHBTg4C6JabfnZBfgPNEi0rAYfzrVA/LL29shUhmHU5PZYbA/3Srs9C1OfuWZhoznKV2SROBBIdddob4vcYvGUq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25184151-a065-465c-a05d-08dd316a9c6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 11:33:31.6561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSvpLzzHvIQlgiCaiTmrkEL1f3sh2DOQoPTdz26F3sKRtKO0v86A0QKItO/JHuSQ95sl0jchUpGUiIwzYzV7nyQLh4IsDVDvP+Y9JZoDFjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9284

T24gMDkuMDEuMjUgMTY6MjQsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIFR1ZSwgSmFuIDcs
IDIwMjUgYXQgMTI6NTDigK9QTSBKb2hhbm5lcyBUaHVtc2hpcm4gPGp0aEBrZXJuZWwub3JnPiB3
cm90ZToNCj4+DQo+PiBGcm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGly
bkB3ZGMuY29tPg0KPj4NCj4+IFdoZW4gYSB1c2VyIHJlcXVlc3RzIHRoZSBkZWxldGlvbiBvZiBh
IHJhbmdlIHRoYXQgc3BhbnMgbXVsdGlwbGUgc3RyaXBlDQo+PiBleHRlbnRzIGFuZCBidHJmc19z
ZWFyY2hfc2xvdCgpIHJldHVybnMgdXMgdGhlIHNlY29uZCBSQUlEIHN0cmlwZSBleHRlbnQsDQo+
PiB3ZSBuZWVkIHRvIHBpY2sgdGhlIHByZXZpb3VzIGl0ZW0gYW5kIHRydW5jYXRlIGl0LCBpZiB0
aGVyZSdzIHN0aWxsIGENCj4+IHJhbmdlIHRvIGRlbGV0ZSBsZWZ0LCBtb3ZlIG9uIHRvIHRoZSBu
ZXh0IGl0ZW0uDQo+Pg0KPj4gVGhlIGZvbGxvd2luZyBkaWFncmFtIGlsbHVzdHJhdGVzIHRoZSBv
cGVyYXRpb246DQo+Pg0KPj4gICB8LS0tIFJBSUQgU3RyaXBlIEV4dGVudCAtLS18fC0tLSBSQUlE
IFN0cmlwZSBFeHRlbnQgLS0tfA0KPj4gICAgICAgICAgfC0tLSBrZWVwICAtLS18LS0tIGRyb3Ag
LS0tfA0KPj4NCj4+IFdoaWxlIGF0IGl0LCBjb21tZW50IHRoZSB0cml2aWFsIGNhc2Ugb2YgYSB3
aG9sZSBpdGVtIGRlbGV0ZSBhcyB3ZWxsLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVz
IFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+PiAtLS0NCj4+ICAgZnMv
YnRyZnMvcmFpZC1zdHJpcGUtdHJlZS5jIHwgMjggKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9mcy9idHJmcy9yYWlkLXN0cmlwZS10cmVlLmMgYi9mcy9idHJmcy9yYWlkLXN0cmlwZS10
cmVlLmMNCj4+IGluZGV4IDc5ZjhmNjkyYWFhOGY2ZGYyYzk0ODJmYmQ3Nzc3YzI4MTI1MjhmNjUu
Ljg5M2Q5NjM5NTEzMTVhYmZjNzM0ZTFjYTIzMmIzMDg3Yjc4ODk0MzEgMTAwNjQ0DQo+PiAtLS0g
YS9mcy9idHJmcy9yYWlkLXN0cmlwZS10cmVlLmMNCj4+ICsrKyBiL2ZzL2J0cmZzL3JhaWQtc3Ry
aXBlLXRyZWUuYw0KPj4gQEAgLTEwMyw2ICsxMDMsMzEgQEAgaW50IGJ0cmZzX2RlbGV0ZV9yYWlk
X2V4dGVudChzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFucywgdTY0IHN0YXJ0LCB1NjQg
bGUNCj4+ICAgICAgICAgICAgICAgICAgZm91bmRfZW5kID0gZm91bmRfc3RhcnQgKyBrZXkub2Zm
c2V0Ow0KPj4gICAgICAgICAgICAgICAgICByZXQgPSAwOw0KPj4NCj4+ICsgICAgICAgICAgICAg
ICAvKg0KPj4gKyAgICAgICAgICAgICAgICAqIFRoZSBzdHJpcGUgZXh0ZW50IHN0YXJ0cyBiZWZv
cmUgdGhlIHJhbmdlIHdlIHdhbnQgdG8gZGVsZXRlLA0KPj4gKyAgICAgICAgICAgICAgICAqIGJ1
dCB0aGUgcmFuZ2Ugc3BhbnMgbW9yZSB0aGFuIG9uZSBzdHJpcGUgZXh0ZW50Og0KPj4gKyAgICAg
ICAgICAgICAgICAqDQo+PiArICAgICAgICAgICAgICAgICogfC0tLSBSQUlEIFN0cmlwZSBFeHRl
bnQgLS0tfHwtLS0gUkFJRCBTdHJpcGUgRXh0ZW50IC0tLXwNCj4+ICsgICAgICAgICAgICAgICAg
KiAgICAgICAgfC0tLSBrZWVwICAtLS18LS0tIGRyb3AgLS0tfA0KPj4gKyAgICAgICAgICAgICAg
ICAqDQo+PiArICAgICAgICAgICAgICAgICogVGhpcyBtZWFucyB3ZSBoYXZlIHRvIGdldCB0aGUg
cHJldmlvdXMgaXRlbSwgdHJ1bmNhdGUgaXRzDQo+PiArICAgICAgICAgICAgICAgICogbGVuZ3Ro
IGFuZCB0aGVuIHJlc3RhcnQgdGhlIHNlYXJjaC4NCj4+ICsgICAgICAgICAgICAgICAgKi8NCj4+
ICsgICAgICAgICAgICAgICBpZiAoZm91bmRfc3RhcnQgPiBzdGFydCkgew0KPj4gKw0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0ID0gYnRyZnNfcHJldmlvdXNfaXRlbShzdHJpcGVfcm9v
dCwgcGF0aCwgc3RhcnQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEJUUkZTX1JBSURfU1RSSVBFX0tFWSk7DQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICBpZiAocmV0IDwgMCkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
YnJlYWs7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAwOw0KPj4gKw0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgbGVhZiA9IHBhdGgtPm5vZGVzWzBdOw0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgc2xvdCA9IHBhdGgtPnNsb3RzWzBdOw0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgYnRyZnNfaXRlbV9rZXlfdG9fY3B1KGxlYWYsICZrZXksIHNsb3QpOw0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgZm91bmRfc3RhcnQgPSBrZXkub2JqZWN0aWQ7DQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICBmb3VuZF9lbmQgPSBmb3VuZF9zdGFydCArIGtleS5vZmZzZXQ7
DQo+IA0KPiBIdW0sIHRoaXMgaXNuJ3Qgc2FmZSwgaWdub3JpbmcgdGhlIGNhc2Ugd2hlcmUgYnRy
ZnNfcHJldmlvdXNfaXRlbSgpDQo+IHJldHVybnMgMSwgbWVhbmluZyB0aGVyZSdzIG5vIHByZXZp
b3VzIGl0ZW0uDQo+IA0KPiBJbiB0aGF0IGNhc2UgcHJldmlvdXNfaXRlbSgpIHJldHVybnMgcG9p
bnRpbmcgdG8gdGhlIHNhbWUgbGVhZiBhbmQNCj4gc2xvdCwgYW5kIHRoZW4gYmVsb3cgd2UgZGVs
ZXRlIHRoZSBpdGVtIGluc3RlYWQgb2YgdHJpbW1pbmcgaXQNCj4gKGluY3JlYXNpbmcgaXRzIHJh
bmdlIHN0YXJ0IGFuZCBkZWNyZWFzaW5nIGl0cyBsZW5ndGgpLg0KDQpHb29kIGNhdGNoIQ0KDQpC
dXQgd2hhdCBzaG91bGQgd2UgZG8gd2hlbiB3ZSBlbmQgdXAgaW4gdGhpcyBzaXR1YXRpb24/IERv
ZXNuJ3QgdGhhdCANCm1lYW4gdGhhdCBlaXRoZXIgZG9fZnJlZV9leHRlbnRfYWNjb3VudGluZygp
IHBhc3NlZCBpbiBhIGJvZ3VzIHJhbmdlIG9yIA0KYnRyZnNfcHJldmlvdXNfaXRlbSgpIHNob3Vs
ZCd2ZSBkb25lIG9uZSBtb3JlIGNhbGwgdG8gYnRyZnNfcHJlZl9sZWFmKCk/DQoNCg==


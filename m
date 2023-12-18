Return-Path: <linux-btrfs+bounces-1021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E9D816D36
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 13:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8923A1F2420C
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 12:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD9922066;
	Mon, 18 Dec 2023 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L44OXcPm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Wm7gvh10"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCA120B1B
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702900575; x=1734436575;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8vXQTJG1j9h9xvz2CDcM2b2YN+C13qZmYFKROe3yOKE=;
  b=L44OXcPmtMQOmn/jNPKJYbrkbtltXN6DzB3wCFBpRwwR8BFc13wMmVR9
   lOQJ/5Kv3nse3ZgtzwoHV78O+uG3tDkmxaUE1kLhS3ysj5BWEoCLmZWu1
   E2Ws/Ru5MUbGjFnngm2APpduusYzO+Yorq/mxJkjhhbD1MDZaqFsVWW69
   ECLoMsOGBQdjBy62jO0BsJrfSywvSGU08X8h7uRBl153irZVsUvvAjlmU
   Y4GPHfp2gd5JsHe18YOVARnYmhaA/VJiWAo2O0zQUyLM7pemjRobSTMMy
   L2d+h5C0o4GEPP+ke2UNrB3huddKRr1lY3HhMFXxjaWDqleFxwS8bfsB6
   g==;
X-CSE-ConnectionGUID: rmkIEjZQS525Ei89Kcy7sQ==
X-CSE-MsgGUID: Ue1oxouYSdWr7hTn23Gotw==
X-IronPort-AV: E=Sophos;i="6.04,285,1695657600"; 
   d="scan'208";a="5283388"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2023 19:56:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ci4esDvuLemL597zGWCZzqsdpMB+48RPFcQswn/JoxYJko/nC5v6iI7ojgDYaNGDi89+WSOrrFSwSb/Vu7AzLDdsaI9pA0sOgjjNeu7Fcu/WL3lQjwOicKUL4X715ySRAAx3dk4sjzP5umqYn+Ay+/x2qdiYG0aIfpp6s3M7/5Lel+vbPMeVclNon9Yb+wRCE509VNMrj9R4AJkXT36ReKiqkzjn6BvQgyWzheoEkYo8Mj5R0j7qQOb3XnbkNCZy8iZG6ReOFZFeTITlrhwXuntYHjJMTYDhHmw/Tbshi87lrsbc3GBFsODsjYGXkcw8FWjpfXZnwTo6isImksZp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vXQTJG1j9h9xvz2CDcM2b2YN+C13qZmYFKROe3yOKE=;
 b=CbwX6Ha4jGdB4la8SHcEOQoE8dCtT+TsAp5Zm2Jsa4Z3y4xS72255V4SBUOSD/QrLWlza6yf+up29kpiQsx7+PTC6tAf0qzjlbHQ/eqLSs880IF4ltisIvaVlaGK/uihVC89xugqQv6h3c40rikKERmIXf6jn9wMBxEaub14xR6RCm8PXzNWTgdxtIPlSSPZHEbDKRiw+8QnDH/IdUbBI6ZP7klH1KfNROc4xvDc460BUwyGf+Xn46qW0Z/rr8MYZKQ4uVPcr2YqIi4usceGPsAQltA9E3Yx7AiwK0Wz3N2TGUtcBs9J2dYVHFApPYC5NJpc/wMl5riN8X25SLlmAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vXQTJG1j9h9xvz2CDcM2b2YN+C13qZmYFKROe3yOKE=;
 b=Wm7gvh10YCMtdWRwKTBvzpjSi4CcD0qUcrrsIDV0LmJCW9kYJy4KZ8YwFeQmR4JVpETwOXCR2ME7CnaXTQOSbqHqIgJa47zCF9rUN76kxVELdgPGrSlIsC8Xm/vDuB/u7Uo8ZNynWE8mSd4QmxhtFcK06MPWGOoXDpbMI8Zy974=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6584.namprd04.prod.outlook.com (2603:10b6:a03:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 11:56:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 11:56:11 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Christian
 Brauner <brauner@kernel.org>, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 3/5] btrfs: split btrfs_fs_devices.opened
Thread-Topic: [PATCH 3/5] btrfs: split btrfs_fs_devices.opened
Thread-Index: AQHaMW2rBOie0PSJQEC2XqVmFOLuKLCu74YA
Date: Mon, 18 Dec 2023 11:56:11 +0000
Message-ID: <9326eff4-fc35-42e7-a381-973a9a3d5e80@wdc.com>
References: <20231218044933.706042-1-hch@lst.de>
 <20231218044933.706042-4-hch@lst.de>
In-Reply-To: <20231218044933.706042-4-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6584:EE_
x-ms-office365-filtering-correlation-id: df1cbe98-3bd7-4caf-b173-08dbffc05428
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0OtiE7lrGSpzktel8OVNS71Dk/0jQImx9gbQdVvHDqCQiOyEtIzz+wwGg/mKumwjamKYKpe6M1eJ6unVNKQjyvTKysUr/CRDSj0RnDgXYb6OrU2DkwtmCPbo/MwbxPb4WHsUWP8ELszAPPNaIhj3b5I0OCl6KIPwpZqbaQ9SqM9qaIWP+J9oyoPWNHsNE/tiqYjRRv+3gy31OSiUkz4BIP7jPxtTWaXrxmO0HuE7eE7S6XgL7g/h0hipDXv7VzWeMRvswaRkrdgLkv5U4Cu16ZCaf8o8MAh8gunwjVBEu8NkqEg5TNWcPHFDbbdWQK98LQxreuuDQMUuWg89D/ykygAv5fSPuwDEgWJbSWSLaedHjPMqXaSv8QAB5JOHa0elTv13l+hT3o12iNXYhmpepR6GwUhN6+CqU0weSiXMciI8PRwdcY8YCW5/I5Ef6oCqqEt0ZcgvZQpNyorgAcUy/9JlNbVovOzWFEH7BFZVhtlwfT80i9dj+JiKEanVF8rWx7/vrESNcto9sVGLkgfJX7zzug5HkOjWvZM/uNAgQE1QIQJILRCnVsr3bMQOxo5db4l2TeMB+Es1UZBHdfoogCys+mpA5kyu4FRXWfEHPKok2dJhp1bgkXBQC5ZA9l7CLQX4KruDFcRmvcpCFYtPQVqO1ssci+wWy0dmgNg4em8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(38070700009)(38100700002)(122000001)(2906002)(4744005)(31696002)(86362001)(5660300002)(2616005)(83380400001)(71200400001)(6512007)(6506007)(53546011)(82960400001)(54906003)(91956017)(110136005)(6486002)(41300700001)(36756003)(66476007)(66446008)(64756008)(66946007)(76116006)(316002)(478600001)(4326008)(66556008)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?emdIOEZ0VnFGN003YmJ1TjRtTWFCNWUrWWdKNkdBSUw5SWliaWI1QzU1MUo2?=
 =?utf-8?B?UVU1Y2FQK0M2RENvRE9Bcm0rYmtYeGZzblhMSXkrUzZldlVhejZSTkgwVnd3?=
 =?utf-8?B?T3RBWEZzZXJ5cmhCRXJianRtMVUyZnAvdVd2dHFUSTZVL29wdGcyOWxPaU80?=
 =?utf-8?B?MTBrTCtzZW1ndTFMRWNsb2lVREdacUQrdHpIQ2lkL0tUT1BrZDhDbXRhbXF6?=
 =?utf-8?B?R2ZsT0pyNk9tLzAzYlBNZGxqMHdIUjJNU3F3V3ZtK2M0UThoSUdsL3dIYWw5?=
 =?utf-8?B?Vm0zcWJSOUFXVTQwTk1jYmczMXZrV2s3VTcvcjBzR2ZHaHBKNDl3dGxzVEk0?=
 =?utf-8?B?VitsWTdsZkNKOWVaTUtFLzhBc2hyNFEzUW94bWlWQnpnVEdBMmdLWFhXQTcr?=
 =?utf-8?B?bjRIZDVXSCt1N3NTdFlnWVlLb2dzMFFGNlE3REtiYWV6cElOSjBVOWJxUnl2?=
 =?utf-8?B?d1UrYzRzZnk4NzMwUUlod2JHTjVoQ1VmMFdyWWY0YVAvcUZZcnJ5NkQvanJr?=
 =?utf-8?B?VFdvR0ErVmNQUzlWenhhNUdYdE5UWkNWTkhjVlhXQm1LblZNZHlraDc3RzNN?=
 =?utf-8?B?UnM3WEhCbkVTYjM2ZU8zV294UnBlV1N1UTdYalh5VkN2R1JRanhjOVNBTCtJ?=
 =?utf-8?B?Rm02NU9COVNITFBLSEx3YWt2SFlaODRReHRITnBwSXdYU0xIR1R5dkNmdDNO?=
 =?utf-8?B?OWFTVEU1UW9JTnlSazJ5ajdTZE1hTDZLVEhqaGV0VzdXai9rVFRneGJXMTJF?=
 =?utf-8?B?Qk1EU3JnSzVHWFdRMVlrVmdWWHNZMXV1cGd0aklrYmRHUys1SVBkUVVhc0Ju?=
 =?utf-8?B?QzNGRGFWWHV2N3owdm5NYXlDZ0NNWDgzUGU0YlQ0TlB5U2kzKzBJeStNZDZC?=
 =?utf-8?B?bHBKdjd2TkVPdE0wQzB4RmNuc2NCWEhUQ0g3YkJ0aU1uZ2w5R2g5Ui9jektu?=
 =?utf-8?B?QWIvbDhFQ1AxZFVSWnIycmJvNlNQWGpBNHJvd0dvUzdGdDZqN3p4UGZQblhI?=
 =?utf-8?B?NWk1ZzlVdzY4ODI5UzRmaHYzWWpINWp1MTU4dmZYVGpMQ0ZrcnUxZEM1aFp1?=
 =?utf-8?B?R3BzbFZRajJNTlZRM3AxV0JqMXBuVW5jckhoSWswT3RjNVVZcy9HQ244VmZ1?=
 =?utf-8?B?ckdVL2lYc3pYbHU4S1JScDdEZmtnS1UvV3Yrd3Q3ZkhZalQxQXk5dmJvbkZu?=
 =?utf-8?B?OWp5ZFNVMUNJd2h4aUZ3WHViajM3VHM4T3c5UEI0aklQZlB3azEwTHcyTXhj?=
 =?utf-8?B?QXFGOGZDSWR4RmtwWFMzSVh6NnF4L3Y2QTFySm9BaVRxTHhCWlBvR3ZrYXBO?=
 =?utf-8?B?TENEdHR2bzVXZVlKOEVVQTVzSzB3RjBSbVBQVXFMSlVUZGNaMTVLVlg1cEUv?=
 =?utf-8?B?UzdVazMwZnpJL28zK2hOTVNyVk1qVzQxUVJ6MmJKNjFDSGRKYUVESHRvcjkw?=
 =?utf-8?B?N1RxMFZvL0ZyTE9uZmJVVXNEazRuNlJlcnZTMVlOb1dFZUFBQVExVnZ5dWM1?=
 =?utf-8?B?Q1NoMk9TYmE0aU5VV2REVm44QU5GQVVTMGVrTjArUFpMMUpHSWZZOGx4QlQ3?=
 =?utf-8?B?SnozYXRnbGU3R0hxM2lXVGJMQWlTaWxZQWZvM1Z2NFB4RnhHZ0s4V3NtQitF?=
 =?utf-8?B?L2F3SkI5OG5iK0lLSklwOVZ5UnpWTWozb0FyUmovT0dXNXdHRHNLckVNSWNX?=
 =?utf-8?B?L3IzdE9qbHNTcGt0bERLRWlaR2JIa3RGMk00c2UrWFlNSk5ObERQRytkcmRE?=
 =?utf-8?B?NWdQaVlvVXdWVnlPTm5ZR1hSOUwzZEdCdzVkZFdzU0h4NTFJOHlkb2FYL1BM?=
 =?utf-8?B?T0RRdFM5TStZL004V2hJZU1QQ3M4VEJtTWkyRngveEtneE41QjRxdzJmaUJJ?=
 =?utf-8?B?bUJvWVZrUEFCRWNPQ0MrRFBRMUhlUWZqMSs5U1lEMVBGbHVwV2pyK2Y1MmNX?=
 =?utf-8?B?b3ljQWRFTmx1V3dhY0hyMFY3ZzdhNXliR082Y2JudUU0eVBSdGxONXNnL3A4?=
 =?utf-8?B?aFY1SkNvS0xkbTNFSThaVEdzM0RvYng0cFczQ2UzYW5nVW9lN0R1Q0RpWkJW?=
 =?utf-8?B?NnhkSlB2QnlkbWJ6M21WYlM0MWRnd1JwcGltWDlaaXBwL1R5TFFUZ0RoVFRn?=
 =?utf-8?B?bE10T2dTelRxaHJVYWFqRjVwazlLZkZpcmRqV3h4dXE0RTB5VzRBZlQ2YWxy?=
 =?utf-8?B?bnVtclZFdzlLUGFNVWsrZnE2QmtnUWQ5T1FsZXQrNURJUCt5NnNFZlY1RXAv?=
 =?utf-8?B?YUxpVEN6VVZNVHZwT0tVVDRETlBnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B13190260AF494F90135D8E47E67062@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O2BVwNoe0ejnSvjyLruengKcD+145rqY18PFIozatZ3UKO34RqrZa8NP1wk/x4lAP9cAphfKOCm/gjnjleLbNpUIR3f65x5A3imxo2gyZCkkvhWzpUoGao3vcJm4JdN7px3pr2qOYq63E/+dwi6r3bap9tojn+t2vpfGmmNsejJVPKWoYp0a7+z2oO3JXu2iwhFRvkPRh5VnEG7gGmgcsOGpy44slo6ZlrjmLtlAaIplPfZQpst6Y7Js+6/LYpb30VkydY3+U6T+IL3jXEIUlPhq5tPHkCI+GNj7Q7Yr5ITcl3d3Gxu/zGpmqy+Tb/OoDGkD8BGnhL4qMCy8MiB8+PAPw20dFRxMsoTNDZk17WHwZc8sXDorwDEjm3VsfEwbnWjqlOeuw/YTGN5bd3axN7kymDLk7HJldwmer7kMeZJXjiTE7K8qn2YenhSYVZtWiJLl9yYrPYcWhyYv9hIEAg9LQldHlRYPPY9LUpO2X5NOw2s9gTKPGTSB8HtEHyBRYP5MCoedflrIL6U2tgQ7FhnVr+Lnm6eVlNe/SZLJkfOPLl3Ui8vuIF/i6fqP93g2qjkrvB8d8Zac4exMezGogDO7OiLaKG02Taa6DJ37WhBZI+bbrXDtNC9ywOHridwi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1cbe98-3bd7-4caf-b173-08dbffc05428
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 11:56:11.3575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sLSuckwqTMlVIghoECAb7uaFMuETKLsKZGns2//XSx010S7Jgft0xC35zmIsR+/+NLie2cmeesykww6NDPDU6C5URfXNRLQlSu9wSz1Akmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6584

T24gMTguMTIuMjMgMDU6NTAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBkaWZmIC0tZ2l0
IGEvZnMvYnRyZnMvdm9sdW1lcy5oIGIvZnMvYnRyZnMvdm9sdW1lcy5oDQo+IGluZGV4IDNkMzVj
NGI5MmVmYjk0Li5hMTM2MjA1MDQ0ODk4YyAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvdm9sdW1l
cy5oDQo+ICsrKyBiL2ZzL2J0cmZzL3ZvbHVtZXMuaA0KPiBAQCAtMzU3LDggKzM1NywxMCBAQCBz
dHJ1Y3QgYnRyZnNfZnNfZGV2aWNlcyB7DQo+ICAgDQo+ICAgCXN0cnVjdCBsaXN0X2hlYWQgc2Vl
ZF9saXN0Ow0KPiAgIA0KPiAtCS8qIENvdW50IGZzLWRldmljZXMgb3BlbmVkLiAqLw0KPiAtCWlu
dCBvcGVuZWQ7DQo+ICsJLyogQ291bnQgaWYgZnNfZGV2aWNlIGlzIGluIHVzZWQuICovDQo+ICsJ
dW5zaWduZWQgaW50IGluX3VzZTsNCg0KQ2FuIHdlIG1ha2UgaW5fdXNlIGEgcmVmY291bnRfdD8g
VGhhdCB3aWxsIGNhdGNoIGV2ZW50dWFsIG1pc2NvdW50cy4gDQpBbHNvIG9wZW4vY2xvc2UgZGV2
aWNlcyBpc24ndCBleGFjdGx5IGEgZmFzdHBhdGggc28gcmVmY291bnRfdCBpcyBnb29kLg0K


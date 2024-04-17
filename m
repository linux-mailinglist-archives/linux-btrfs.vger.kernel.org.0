Return-Path: <linux-btrfs+bounces-4381-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B657D8A88E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 18:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FD11C22FAA
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1AE1494AC;
	Wed, 17 Apr 2024 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RKyyr4hB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DO/HaB/G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE514830C
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 16:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371399; cv=fail; b=hwgEuNeBDZrTzMefIii0qRVtyf/2OjGrNAiAVv1oQtFGpc4rdKsEHFNCunjNbKLiCyIyPoI8LYFSIB8IYn3cq3MGAbYFooLVmJ8mIKhud3e3HJ81etO7McIRon4byPnqhVJqB9oM8pW+OzRh8N3kDEsuefKlst6fSE1Z7QNY1BE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371399; c=relaxed/simple;
	bh=/LH8QATFBEv57KoTuaMKNxk9Kh04Z0Uy48gN2PAjEu8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rowBITBL1HCX2F9NhcA53dUrv3c6mAkqvM7b+JmmSFyGbto0eIT0L7kCzOPbG6ZGooe+fAGXCWNGRXdnD+og3bJ0tOZFC6X7hbrda9ETWFg1auzzx78qOUv/76mQOUM+8Pdab0BAT3lGWH9uSxush08IHaLvxcE+h1adwXzzaa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RKyyr4hB; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DO/HaB/G; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713371397; x=1744907397;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=/LH8QATFBEv57KoTuaMKNxk9Kh04Z0Uy48gN2PAjEu8=;
  b=RKyyr4hBvmmId1KsARcAvrfoSQVnllxlExCsbAO9nIsg6ARad4F4bFf6
   8nMlZaxpmL731B3AqiL/6gPJxfBEjqkcdAQfs/aLoWkxl/cOa/TsM5xss
   vezwrHDuOC7ZRD0wcsacfUXVV63SFtJfKXGnWQ0L6uNRz563xBXKkhLAp
   R34NK8wsJFCqBT06Wl6lKRNze7MqjwGghB/fXOJxK/vucNcTkkY8N17TT
   hCXPg5HQDHBezpV7VRUHMBOq9RTQ1C0MdvjmYT0jTvOv5OwpRrzd7Dtpq
   btVcTIHod+lbieywJ/iIoElkFiO/R+Er09Mae07pksz6KiOTB2Lsr+CKk
   Q==;
X-CSE-ConnectionGUID: 4lyo41LMQsW/jsO0hfL64Q==
X-CSE-MsgGUID: gxznDCCcTtih0BNiRLgX5Q==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14238969"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2024 00:29:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsgWYCifbf95qI/xhansE7EhlNJZOIkJYyhwQMXrGrUkf+K6+hnDUl5+GKDy0uZCGo5qx6324NPNmJ909CD5/1PEnET5WEXDvf4aUUngLRMgs5LZKUY+KA2U7agqoKQRoA2hGfOWszoGUeDLNHVg22fBFMmMiYD7EA/phtxoLv7cWhqKt5PZPB0l4SOK+0PImrwur52IU5CPeVGuSLkDmHWgZRlT/VrHYjN+nGPC0l8Hr+R5qUFj0S7cUbKK76YXuvp8YpMHWndiMQ0prGcgYW11g2VB3YczR6/R2p/8r7fijUICnAP2ZKyALahrf1VUV7ikS3XRq1sOc1qN/53ZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LH8QATFBEv57KoTuaMKNxk9Kh04Z0Uy48gN2PAjEu8=;
 b=SPur4Wf2h2MSAED8h/XG/jkz94xTLy/5876mtJrkz/pti3hc7v/ObtfjrG9t+QScPNHWbLxyJi+Z57yr0ke7bcLGj5eGWa+QWMQO7i+KY4I2Cx+/S/pAyubTnOKV+l7axkqO82Y3lUqSGDTu483PlyUM8qfut2b7+d0mITKxoTTCHj6Irqe8LgLrPGOHuhihUP9NIXccjLg2YM1j9edE0XwSmLeiNa4XGU1r9P1Ti+TnKRT6zmdAsq/A8Sz9r8ZlMHVnfRwV9E5HCb8am3w6DTkjxPYShiouiEiO1TA+n5wvcxbbt7DjNST8tM04AKWq5reU4rLdbTfTHCj8ocIUGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LH8QATFBEv57KoTuaMKNxk9Kh04Z0Uy48gN2PAjEu8=;
 b=DO/HaB/GYV9ap5PjhzFoc/FSjUJ100d5wiWXcrCk0ohVLkxWmFW6F35CMC9WU0pH6SCW2zkD5KOn0XvOdiKqoyou8NmPyohmNsjTgI1r3SPEu9SdfDtQs6ryXw5m5thOc4EmfNk4adgLjsadqT9muxWhNShP3tC6ti7rizV4yn4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB8166.namprd04.prod.outlook.com (2603:10b6:5:317::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 16:29:52 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 16:29:52 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 05/17] btrfs: lock extent when doing inline extent in
 compression
Thread-Topic: [PATCH 05/17] btrfs: lock extent when doing inline extent in
 compression
Thread-Index: AQHakNSwcbGrG1KWmUatHOfAIHd857Fsp0eA
Date: Wed, 17 Apr 2024 16:29:52 +0000
Message-ID: <5d8ff6d5-1703-4255-a442-16f9fdbecc41@wdc.com>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <99be1657b5273f3a9d24e53f6be9303b381a51eb.1713363472.git.josef@toxicpanda.com>
In-Reply-To:
 <99be1657b5273f3a9d24e53f6be9303b381a51eb.1713363472.git.josef@toxicpanda.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB8166:EE_
x-ms-office365-filtering-correlation-id: 41028584-9407-4da8-82e7-08dc5efb9b9e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IFWxn5/czEaiEG6bnEDxFwMtIOmcR8bbnv0mReKiQRjFSvVM4BVLkV7lv6wgAL75aPUTzuPk/OnoHyTZ0kqnZsLt13/h+1tI7vwI3E1azJalETAaXt6JMDnuO9gjOT/DlvmmR6Z8uDbVBJ49N78qOFEuIZDiaouBm2EwB1rLCKC6p1r9wAH77CLqQO2YL/OPFrTjkL9M0zfu/GHhuhhgT87Av/ESUWUWFsGmdZNIreWBYIWnfMojpdjBH6G/0qzPQJQQD+KiSLsdC+phy41oJT4/nH2MzjR6cvXg/sfM79xSRsGLITD7AWzjRDla/GHepZ3zQ5sElfThskO4FmEUY764LwyH5Zv82b/qcUpiY2+J/B2fx0YbIlFB3oN2xhv/+q2m5BBvO75Y/2oj2tAfJegYBb3sdSeKIBDlWtctazuKj3sTeZGXvWhfZd6U2OKbYgx+CxGV40DcR7blZ6PKV6z0e+CI0rck3zN1l569EwIboH43Y0umIuN/Fp8FYqeVGmHVc7stdzbeuB6x2eb19B3QrnLmuPUtP7gmTudoAelJW1XZvE7/Vd57EoYRuJwCXTyn+8xevXATE+VXZ/m/jSYUphoYPZWNfFPROaZIZj8doZlN7kYjEpFKYqwHr4WGGMFWcyH1uqk5pexLvAx7P7EeyZGUeOZEiVym/NbWxevZM8RHNaUbV4NYeGnHJnjEdVVjDnOBW4dQEFaXH+UsfRW78wA0Ytssc1lvJv3UmWA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K2pubWw0OGdlLy9xT0VrNm5LSG9jTTJ6RWF2OFVBNi9kb1RzdTlqTEthK0to?=
 =?utf-8?B?dTZyQzZjbklQV3Q1VXhOUmMwNE1aTU1FcE9Vdk9ucnpyMExxcEtpeWQ4dWgx?=
 =?utf-8?B?bHRyM0pBTjRmZWRueGc4eW5wa2VCMHpKWWRORGJubHdlQkR1NVNZekUzS2dj?=
 =?utf-8?B?ZmcrY3pYOUJGY2cva0U3aGt0QnhrYXNvcXpRMFNVMkZUdElNaHFPK2sybGRi?=
 =?utf-8?B?ZGw0d0JkT2UyelZCVWtkalZWYUpHeFB6VkJOZ1lkY2tDWUU2bmphbVg3ck52?=
 =?utf-8?B?NUczd2NvdXlOYTIrcncxT2dQcHVLSWRtWEdnM0tRZ21kSUdLUmtrRXVpcjYv?=
 =?utf-8?B?OXNGM1JkelhwWXkwVUp3eEhNZ3hvekFZMU5DdjlNSlQ1WVZIWnY4aGxVaTFW?=
 =?utf-8?B?aGpZOTlHNFNEOXJPQW56YW12VHBBZDFMVTg3UVc0b0ZxdEd4d0ZVRFFrYkdI?=
 =?utf-8?B?dE1xci8vdm9ZZm5VZGlUTzVEaEdnNW1VUjljRVQrQ21FSEl2LzlUdUtza283?=
 =?utf-8?B?ZmZNS09Sa01JRWM4dm5ERk54SWZTb3NOR1lkL2xscWlvQWdUT09kU2IyajRk?=
 =?utf-8?B?dXVzV1FqSFpTK01EZEd4K05QMk5RL2hiQlV1WTR3OU5BZzBOWEdJQk1NcFZ0?=
 =?utf-8?B?UUxFOTNZV0ZlVWdUL2d0Q3ZiOG1IMk1mTDJMT3ZxVks5NjI0M0NNanVaeVRz?=
 =?utf-8?B?WHdZUUYyenZLckJuWmYwTklIOElmSVRnS1ovT0Y2OHE3cFcvVkp1WVRUSG9K?=
 =?utf-8?B?VCsvem9ya0JpTlNOekJiVzQ1dkZZM1JkMWtucEpCOCtIMncxbHUzckZhN2FS?=
 =?utf-8?B?QWJPVkhaMC9KaGM5aHp5aC9QWnUvdFo1RVJGQzNnN2lDRWhGRzhQMGZvNldO?=
 =?utf-8?B?anUxZjBPa0VHdXFKbjcwOHhmMFRWWGNMRjZXM09MeG9pYkpTK1RpSXhzamQx?=
 =?utf-8?B?TmFHZGkzQ3JQZVFNNmQ5WFdhY0tuOENhUkJwOTFrWWU5TWl4NG16S2xGa1gy?=
 =?utf-8?B?YWZtbFdZSFVuWnZ2Mjlxemt5cUdMUGZycnFnZmtVcGJrcVZIWitLUVdBc2RX?=
 =?utf-8?B?M1JKckI4Z0thcmxoYU9JRzNURW1OZE1KS3lDR28zVHQ2RThkOE9XNEdlMjBI?=
 =?utf-8?B?U2hhU0RwRnhYWDlGSGFxeTlUbzdnYlBLQVExQ0lsWUVlejkrMlhIbkpDZlpQ?=
 =?utf-8?B?QzA4cTlhRGlPWkllN1FrVzNJYkRIeEZPRkpMUFRUSkpVYm9LemplMkFjTWtn?=
 =?utf-8?B?RElGblIvSklYVG9jMXdnQmY2NHpvVzNKbGpmS0hjZmphY2xTR3VqeFp5MEs0?=
 =?utf-8?B?RWtEcTBJZUg1TTJ6bDBRQkp2czllZldFcXF0R3VzRURzZ2NCYS9GbnErN1hw?=
 =?utf-8?B?N3VidlFRM0wyWkp6aEpWdm1DZnVMeGJjZVRyWnJuNFQ1bGhkQVZjZ3dwMU50?=
 =?utf-8?B?RmpRZWxtcTNlWDFyeXpZYzlPSWhXcHZISUlpM05XejJ3eTJjSG12SmpNdFcy?=
 =?utf-8?B?K0NjTXV4WWVtT3lCZHhOOHhDOEhFSHBxUzJ5SWlLeWJLZXhoM2dHU3FzVUZV?=
 =?utf-8?B?alhGeEJvTG95Slh2VE1XaU02TjFuYys4cmhuTUdPMW1xMjQ0MGRERFpaVGxw?=
 =?utf-8?B?RjJzY2o3UW8vZGhoeUs1MEhydU5vTU1JVUpCOEFwdUtBNnVpR3UvSjRzY0Zz?=
 =?utf-8?B?VEpaNW5qdHRSVFdHRElRQ25EdFFSNXV1RnVaYlc2N0tJRjBaYnJQWkNxSjhS?=
 =?utf-8?B?NDBpaEdLNFgzVWlodWxMS1NxT2ttZHJkZTNNLzNLeXlhcTg2eDBSWnd0cStC?=
 =?utf-8?B?QUg1dEYrdElTR3hvRlFBY2M2K3FzQWNXaUJxZzJDekU5N1NyQ0Z2VmVWUWR2?=
 =?utf-8?B?bzR5UHpwUGJzN05MdzRIRXl5a0d1ZlBXS0tBdUd4OGlDbWhRSkhOTDYxNzJ5?=
 =?utf-8?B?Y3E0ZExEcStFOVFUK2VOdm8zNDJyS285WEp6WGw1c2pKbUJndm5sK2pDYmEz?=
 =?utf-8?B?anE4SzFUTVZPd2x4Sm53ZEdjVHpYS2VWYWNWUHBXMkhHc3dlcFlXcWlhWGIx?=
 =?utf-8?B?L0NIWTBoUlJkc0NERERMckpGN1hvVkdoZmVEbjBRblJyMm0vdkdieGFIMzlX?=
 =?utf-8?B?NHlaL3dpaktlMkFLQjFKT0xCQ0tIaXJOS3A3c1Y1VnNzRDdmS1F0RzZieW55?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21E58DC59EF47F4BBCBFFCEC77C0ABFA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8O/It/yq13pQug9S+efN3wD4yvcaO2EQ/tRoRx98htbd4pc1BLx4O5SD1w3GOXf8U7LfubztvOS50eBPJf5WIBCyE7eilrp9vCIivIKEtEZwvMryr2tH9Jz+1QZ2XjXw8KnUfbY3TBrjgG8naF0z9LtrVDCIL7uBYQUwnJHcVpzWBTzyiT8drOyrUilxNJcAqj3JeOYNyPiEIP8tzbGZrp0pPor16BP6iTphYNC9bzzhl2ieJ9W/niY/yZyZ7sodx0WbV0n9kYz3TtgmMz9ST57L1o5hXNZ0UQDaKAeYOvMngJTYLdQAK867Ch9DDcwgfT2wlmKf9Xxh8FxYNlVKi4tC8W2JSp/E9QINJj+xw6HXAOFDVW23Orr+yHK9qlMNubsU+Ac138BQop6HUpIn/sL4Awwrrl+ktbps5cO7J1eShOsY7Z8XWQ2xnfi0R95YmEq5G5v+ciV6AfK1Gbb/tIYnhVvYNfhf93ZTWsLYsUwpGlfqu/EkUfq6SFcHbgd/eko5DRC7HRI3OZYnGTanOOUixzrToS1G59uIk6bSSQHMvLeVxA2h9WqLBpg++0LtY9Xl7seY7+ryhEDwrC4F+prrE3Xzfcyj/jLJkOkb7Q7X+joV4JnKGq2sE7D+Rjl9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41028584-9407-4da8-82e7-08dc5efb9b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 16:29:52.0376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UwhYzO8E8i9qMdxnLSQIs5CGdC5+VdNtzRdQqqRuNzZzVrITC9QE3WI1P9aK1rMnL+f3dVgynEKYMPJ3ETbXLIx31mQ0TYrtCta6vSc7/e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8166

T24gMTcuMDQuMjQgMTY6MzYsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiBXZSBjdXJyZW50bHkgZG9u
J3QgbG9jayB0aGUgZXh0ZW50IHdoZW4gd2UncmUgZG9pbmcgYQ0KPiBjb3dfZmlsZV9yYW5nZV9p
bmxpbmUoKSBmb3IgYSBjb21wcmVzc2VkIGV4dGVudC4gIFRoaXMgaXNuJ3QgYSBwcm9ibGVtDQo+
IG5lY2Vzc2FyaWx5LCBidXQgaXQncyBpbmNvbnNpc3RlbnQgd2l0aCB0aGUgcmVzdCBvZiBvdXIg
dXNhZ2Ugb2YNCj4gY293X2ZpbGVfcmFuZ2VfaW5saW5lKCkuICBUaGlzIGFsc28gbGVhZHMgdG8g
c29tZSBleHRyYSB3ZWlyZCBsb2dpYw0KPiBhcm91bmQgd2hldGhlciB0aGUgZXh0ZW50IGlzIGxv
Y2tlZCBvciBub3QuICBGaXggdGhpcyB0byBsb2NrIHRoZSBleHRlbnQNCj4gYmVmb3JlIGNhbGxp
bmcgY293X2ZpbGVfcmFuZ2VfaW5saW5lKCkgaW4gY29tcHJlc3Npb24gdG8gbWFrZSBpdA0KPiBj
b25zaXN0ZW50IHdpdGggdGhlIHJlc3Qgb2YgdGhlIGlubGluZSB1c2Vycy4gIEluIGZ1dHVyZSBw
YXRjaGVzIHRoaXMNCj4gd2lsbCBiZSBwdXNoZWQgZG93biBpbnRvIHRoZSBjb3dfZmlsZV9yYW5n
ZV9pbmxpbmUoKSBoZWxwZXIsIHNvIHdlJ3JlDQo+IGZpbmUgd2l0aCB0aGUgcXVpY2sgYW5kIGRp
cnR5IGxvY2tpbmcgaGVyZS4gIFRoaXMgcGF0Y2ggZXhpc3RzIHRvIG1ha2UNCj4gdGhlIGJlaGF2
aW9yIGNoYW5nZSBvYnZpb3VzLg0KDQpCdXQgaW4gYnRyZnNfZG9fZW5jb2RlZF93cml0ZSgpIHdl
J3JlIHN0aWxsIG5vdCBsb2NraW5nIHRoZSBjb21wcmVzc2VkIA0KZXh0ZW50cyBhbmQgY2FsbCBf
X2Nvd19maWxlX3JhbmdlX2lubGluZSgpLg0KDQpUaGlzIGRldmlhdGlvbiBzaG91bGQgYXQgbGVh
c3QgYmUgZG9jdW1lbnRlZCBoZXJlLg0KDQo=


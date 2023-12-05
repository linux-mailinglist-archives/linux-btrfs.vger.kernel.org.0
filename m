Return-Path: <linux-btrfs+bounces-611-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EFC804EA9
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 10:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C4728170F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 09:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F05F4AF88;
	Tue,  5 Dec 2023 09:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j36fS3ca";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Dr0u/MMm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C81E9A;
	Tue,  5 Dec 2023 01:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701769808; x=1733305808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=L7KMxK+FH8OV4oPi6O9r0O3o37UYnsnizBCuegFagIo=;
  b=j36fS3cac9NOL6v/xdkaaZbBOi9J/nvs/F7XWjacVQiBl+z1xUDRIB6t
   ysssj0YfRGJhsovZRam6rfLouebuNl4dE4nV64LyZHQ98fbZM4tOJpHQ6
   CesAV9PD1c4og/O7yWV1PJeWaLpx80yFFAx+5dKaEjq4bRs1ByRqFleq3
   eF25KB43/VjHyHdjufGcbBKEqI1tRbtBMferoI8XNfX9UPcxTafO+yWLh
   PsY6t8qhBiXFx383kJgWS7XRP9CEEgJviKv8Ux1QSPsw20Bxt/Rg34PqF
   oRJlVWFR5R+6vfaMWXLyTdOXf/OIBpLhMtAK7C6zllrz29dCV7FJRkJjg
   Q==;
X-CSE-ConnectionGUID: 3Kl7taJySbCjgqpXKcnsLA==
X-CSE-MsgGUID: v8TALEApQGaw9N8t3QtXyA==
X-IronPort-AV: E=Sophos;i="6.04,251,1695657600"; 
   d="scan'208";a="4032232"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2023 17:50:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPx1apTjPTvAWuPJ6Vka/VzOGHgXF+e7ryRdxNuUOzSMWZ1qIEM4yi5bJ5poOkHRfnXXqAUfHb3eme7d58uywpiRCERSCzPGCHtnu8W3k46TVET5f0VXhVg6vlSIKodmlpfMv14Ld4i4WrY8IOja/PtA1G/QI8QdbI56PlI+jRw/vwC7nw4sShRdahJ61GAGPaUd3Ge9f020GiJ1IXmYGWuC+W/Vc8bHHqJLtMGM0xOSceXPOwpExRZo3NPRB17s1soWL5AjzTd8/GMPTkjEHZ1O/rRKV0SEJQuHyPeiu4rdv7K1t1LX5026UQlJ5cxH3zBVCAyfBzkSRI8qdROHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7KMxK+FH8OV4oPi6O9r0O3o37UYnsnizBCuegFagIo=;
 b=F/LDOAJlG8QxVuONc+ZxNFNxuT3tU/QkCmdcU1PeBGCIxTgZb5Be0yi/VMqJM07Gth6C5UEpnbQ7LBr3xHx0+HgzL8LqKHCKUdLY+jgqaoed9EhFMwMK0q1zjMz+fYFERRc0iGHfvKgZaQPJnKXGGV8e4Zkwgs/0RabZBYX57O2kGkTQdQH7xI5qzURbmypJrtjKRwzhFrp7YZ6Qvb/kXwlUKHwSV0gvFhUHgL68JjFVt0L3bpBiJaynUR75PZy3I4cXVIrbcZUYr72hluKWap8k6b75JKrqQBilelBgLCUaa9SnR6oJIZdxwo7wPhOm6xNB5c+R1zrF6GgDklA7Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7KMxK+FH8OV4oPi6O9r0O3o37UYnsnizBCuegFagIo=;
 b=Dr0u/MMmOJHyrPuqTErKhAxmhcSAdm30JCnoCsCTwEQi1IILGjMrsLOOrJhGfwKl/8QXL5MlWTm7h2OBGxZyJojvDRzRKwAq2b3fax7Kbbd4ckZWFqOs+QTZQTJgriZNL/EUixUfSvrRjfl4XBsrsKn2R+Js1xyicpkj29cupes=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6712.namprd04.prod.outlook.com (2603:10b6:610:9e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 09:50:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%6]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 09:50:03 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: Anand Jain <anand.jain@oracle.com>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 7/7] fstests: doc: add new raid-stripe-tree group
Thread-Topic: [PATCH 7/7] fstests: doc: add new raid-stripe-tree group
Thread-Index: AQHaJrVWtGf0fekEHk2ihf4lfGTfhrCZScMAgAEppwA=
Date: Tue, 5 Dec 2023 09:50:03 +0000
Message-ID: <48f221f2-3374-434a-81fc-ed2459776063@wdc.com>
References: <20231204-btrfs-raid-v1-0-b254eb1bcff8@wdc.com>
 <20231204-btrfs-raid-v1-7-b254eb1bcff8@wdc.com>
 <CAL3q7H7oXb8N74u6xmio1Q8P7zb4oi+Ohc+7G6fnbLFiZYdOzg@mail.gmail.com>
In-Reply-To:
 <CAL3q7H7oXb8N74u6xmio1Q8P7zb4oi+Ohc+7G6fnbLFiZYdOzg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6712:EE_
x-ms-office365-filtering-correlation-id: 85425cd2-ca70-43cd-0fc0-08dbf5778dd2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 d25AeVKXjQatVe71U5J2tb9FUwc/uQR+vZLe+TpCNov7iBNmFhhwKUOH2e7IzB4NoggyY3McLtiTIBoxwyNkzIj4fVttlSeLE+xMtK9kZG4NWx+oX6Ai0xBl8E8hD5m1aoBhIKDgujRmuldSLNQ6RzJSQi/WII6GRYExoK8OS84bB54dTjfmm9xJOoeCuJX8G/vpr/zTCrGFOrIDSYUkdcIx1vk/Pf9xqmksDtepdJNyG/t3cQWQHo7hi0PGyeTA+kyXvBf6rxRcc9z7gkghDyiTcjgYrkWIuko6FwTHQbgWalj5ZiE1claEp6+lDs3DBzXZEZg8yQBw+pO+6/b5k/gmLtHrXKhujweK404gd9xYM08Nab0y8Z5Jazake6AEtgfyv1FsJ2A7JFUJeYyOxrf/I4IseMxxpMJb5dKonGHw7UYqxGUOHCyeSLw/1qnL8uiyB9yEio8eG0/d/HPhiHoF5XYUKrQEk9fLdevAGuyR0zqJGhBpec5UhfKtxaQcLmhVe2FRKGcJLr3TKTY0JtFK7ENLpZmzCQI0SJrwyV1MWq45gVXbnOQgJ6BjnvzWKQNgoiwFbcZ4KeTFm3gAncn4BmzKtyN8dB0d8FLkfgV5UTcrbR2OdqG9yhCmXT+UTge9X5nrIV/Qf3HcdF2i06gEq9OXHMBqHiOERPvblCuu3ffFWYmFoa5zg8LUkhKR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(83380400001)(82960400001)(26005)(2616005)(6506007)(31686004)(53546011)(6512007)(122000001)(38100700002)(71200400001)(6486002)(478600001)(66899024)(66946007)(76116006)(66556008)(64756008)(66446008)(66476007)(54906003)(6916009)(91956017)(316002)(8936002)(8676002)(4326008)(2906002)(41300700001)(36756003)(38070700009)(31696002)(86362001)(5660300002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1NwaDY1Y3hqNURuaTBlWTJqdCtBTWtxR0xhay9zRGp1dXdVdEpuVTJDME1i?=
 =?utf-8?B?cWlTSnhVWGFnVWRma0VUQml6ZWIzSGFjYnJzQ0NHeDJCNUREOThDQVBRalZI?=
 =?utf-8?B?NjRkZTRNUkwvSHFlZjNEZjk3eW1oWTl3UndyZlJ4SUpXaUtvQmsyY1JzbTIw?=
 =?utf-8?B?RHlNU3Rub2J5YkNPUjBJMURVSSszRFk4Z09DTEtDUUsvcTdxWHh2SWhRaG1t?=
 =?utf-8?B?cnJVakZUTEJ5Z1JOL3pHV05TZ2FIN2JzZUFFZis3SytJdmZ5MEk5SS9LZ1c2?=
 =?utf-8?B?eU9iMGNrajVVTlJhbVBNSjI1UE4rd3ExTmdoWlRQaFZ1YmFWL2t5SXB1NDRl?=
 =?utf-8?B?em4rSFFxV1NPdmhWTGI5NDVFTmZrYVRQb3dkUTZGQ3dFQU1nM01oYXhLSktM?=
 =?utf-8?B?S3NaTmRVTXFKRFJIWm1QUnpOQUsyY2RUb2dsTnlWaW5EVktpSys5by9VM0Iv?=
 =?utf-8?B?amtNNDVGV0VGbkRWS3lzSzJ4TTdLZ0RpRlRUbVJlempod21Wa2NuK3VJK2xD?=
 =?utf-8?B?aStmUDR3bTZZWDZxRm9QSmhQd2ptOEVQR2xiMkpIUk5vYklmWTFUT2h2S2Y3?=
 =?utf-8?B?U0hEZWtTbGl3bEVBYTFHS0FmaEM4a0Z6N2E1a2JsVm0yRDBJbUFFSmNNekRG?=
 =?utf-8?B?d05Xd003NVNXYm03Z0xTajdEdTcvMHF1WUR2R0NBbVMyQ0lVd2JZRmNPTG1I?=
 =?utf-8?B?RW1DQVNZRWMveU9FbEx0NllTb3RZaDQ0dmJ2QndZcDZNWjRERjFBREtKT2FR?=
 =?utf-8?B?SUlRNG8xOEQ3UXN5cmQrMnpxR0FQSDB6bG9heU5RWTJpZVVUajl3WXJUN1Zr?=
 =?utf-8?B?VnkrYWRHV2J5OUtIaHI0OGY3UnFSRDBwQU5lUjN2NkliUEJzL3hhUnYyZ3JF?=
 =?utf-8?B?TlVxcm93NUpMb0dRWnNyckNaQ3lJc3ltMkRuUVZjRnZ5UUhRR2svNlMybGZE?=
 =?utf-8?B?eVhTZjVkemZ5cWVuMlM1RVB0ZGI0b3VGMkdzaTQvanJsZUZ6WHljRFRoYXNQ?=
 =?utf-8?B?b0NqMTRxN0lWcUR0cDFxN1lGeWgyT0hVZ3psYnRaM2VNOWNrY3dZWEVsRWcr?=
 =?utf-8?B?RHM4RnpyVVY2eTEwMG93RHdsSXdnQldraS9zbWl0QllJWHdMT1Rxb2R0dGZJ?=
 =?utf-8?B?SEhuL2g1WXJMNmE5UjR3aDg5SDRiVmxHR2g0bXJsTnBneUNVamhvS3RzaDhk?=
 =?utf-8?B?S1hHTDBxTGRTTVdWZkVTL3ZyU0Z1NFhWVElKM0h1STFVQzdXd1VDbitOZzBk?=
 =?utf-8?B?WkhkU2tSbnI1NEhHNVN3UVRDZldzK3ZRdWRuWGZFeklMMktZRmhrOTM5eDBD?=
 =?utf-8?B?Sm1EdEp2Sk1aanhwZnNiMzM0VXYyWUtoMVBYUWsyYTZZMmpWbzJ2RWMzWENY?=
 =?utf-8?B?NWRFZGNuMy81UUk4dGZ4aG9zYUVnNjhweWI2c09lMDFKVnJsUEowYjd6RlNN?=
 =?utf-8?B?L1daVFNid1FvTFJSNTU0cnZWNGVlTUlpU1drNElsUW5zRmZoRk5ObUxhQjJW?=
 =?utf-8?B?UVRPM3FWREJpSWJiNFJZWGpLZjIyeHRkU1IxTm5zbFJ2N3pWMTNKNUpudi9n?=
 =?utf-8?B?b3daQWdHVUx2VDVMcWZqbXhqQTFmQVdpNVZRQTJvcU1tWTZqbVcvNHVWTzJr?=
 =?utf-8?B?UHoyWldOanhHbEJBeTBuKzhxdkY3a2w0RVlrVjdCcTl4emZ1SW91LytrSXhV?=
 =?utf-8?B?MUhHZDJNRm5BRnFBUjdBMFUzZWp5NnNvMFhZenNmK21Jd0JpUks0cVg2ZUtF?=
 =?utf-8?B?RWYvY2dEaUsrMEh2SUNTelNkeTVidE0vZ0xSTTdKSGFDTUhpOGZ2YXVwcUxz?=
 =?utf-8?B?L2ZXRVlyOXNiMjR3OThZbzkvYkFYZTNnN0Z3NkFaWW9RNGg0SnloWXVYL0RK?=
 =?utf-8?B?ZmVOMGhMb1JKWnh5Q2lKZ1JOV1J6bjdLOTZVOGIvTnlUZTg2bkszb1ZsN3Nh?=
 =?utf-8?B?U3NRNDJweDlsZS9jOFcySWExVVI3Zmh2bk5LSzIxQVBHbGNjNVJ3YVBpY0lz?=
 =?utf-8?B?eFdkRWJiWXplaDRKd3ZDa08yRm1uQTN6dEVsNW9EamYvTld0RmxjTmZZY1hB?=
 =?utf-8?B?K3hSUDgyd1E2b2xUTmNaMGxCY0FJVWVOYlBkRlJDMG1nbjJuaFpyNnBOOVJ4?=
 =?utf-8?B?Q0Vxc3QxRWFDaW9vUWJYREhlUHlGajBoMjRyZHlxWnVYMDh4UkZ0NFRIV01h?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87AD904283CB2E4DAE0A8DE4D148E3BF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5wtYRMIwwncXhXOJod4zr13mtIbBQ9gepq1O72t63/isSwC57dOH39kiHBm+3aWzOC48rh9p37zb7z7C4ddG4X2Fx/QXgfiOAZWrCUnOmfj54qsOPyaaL/2V6Ju57yYm1T6PJGQc1tlniClWxQwxky2Qov3WnewgVLgj3TQHtpy29WBUwNzWNXRXM05e4+Gcm9BDeujRTpwE8ZVkoIdCRag2nOlQPinf1l4tBm+TWSr0j9weAKAJ9roohwPh17ntoYMbNhzBLRD31+DG7P0BXATvD4cdomLNj0UaI+56ge+4Pq8EBQpWWw/WjYsCzO0hDMvJ8ExNodqOUw0+vM69hJVBXjDBc38ISC4n6nwcaX3YQYn58cKM2A4JhuWD1DI6XRB2Rn6XkcF2V/zffTsMIT3fht8lxylkK24AYqqnxCD09ojwjxG1uwaHwzV73rlB5lZ1U7IgHPKybTlqbp5nz6KkmkGpQFn0cd+PJYPlMMliTZn/h9CFjC4yY5JYiys2dI1ktrz2IPo4alzlPRwqyXPx3JIAIld2F2vwE2AvaJWx4UBw8KaRLU2sDFn2kJF66AoPI9lHIsJm+dmLqPvYF3zuQ9S34G25IQsRSiPcbAi04+6pAMzDsP7l4Bigsv/kxdTYepA4uajDX1o63u2FBnrdbVkoQ0IdIaSL3bGBLZdh/TCd3YzwcDQ88+1DR9a5VkuRN+tAnuBKbFkYnjY521EjU0SOuKYIDTj/slgRI18RDSnnp17gSQpe+LvZKrqehmobUqN1+dLVkTbUJyzNnBptP/zoBm99DPueafrlgi09ub2GMJhrHR7gs8sGkFqoe6NsXHykQ6hgi7KPYg2ibg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85425cd2-ca70-43cd-0fc0-08dbf5778dd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 09:50:03.1721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptiKofD6Yv0O3ns8chjpUhe2qJCsnuuHIJdl1aJhn7C7I2Xhvg8H1u0pjn6tRsV6ElXoIE1+0MFmQItPgUH1P30fhXi705ODyd84y3kUy/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6712

T24gMDQuMTIuMjMgMTc6MDUsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIE1vbiwgRGVjIDQs
IDIwMjMgYXQgMToyNeKAr1BNIEpvaGFubmVzIFRodW1zaGlybg0KPiA8am9oYW5uZXMudGh1bXNo
aXJuQHdkYy5jb20+IHdyb3RlOg0KPj4NCj4+IEFkZCBhIG5ldyB0ZXN0IGdyb3VwIGZvciB0ZXN0
aW5nIHRoZSByYWlkLXN0cmlwZS10cmVlIGZlYXR1cmUgb2YgYnRyZnMNCj4+IHdpdGggZnN0ZXN0
cy4NCj4gDQo+IElkZWFsbHkgdGhpcyBwYXRjaCBzaG91bGQgY29tZSBiZWZvcmUgdGhlIHRlc3Rz
IHRoZW1zZWx2ZXMsIGFzIHRoZQ0KPiB0ZXN0cyBhcmUgbGlzdGVkIGluIGEgZ3JvdXAgdGhhdCBk
b2VzIG5vdCBleGlzdCB5ZXQuDQo+IA0KPiBPdGhlciB0aGFuIHRoYXQsIGl0IGxvb2tzIGdvb2Qu
DQoNCkluZGVlZCwgSSB0aG91Z2h0IEkgcmVvcmRlcmVkIHRoZSBzZXJpZXMuLi4NCg0K


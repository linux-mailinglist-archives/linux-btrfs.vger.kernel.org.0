Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C88382829
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 11:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbhEQJX7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 05:23:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:65076 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbhEQJXt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 05:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621243353; x=1652779353;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wLMv0rXPR/swrrsDiefC6H9hzDFSp542JTxBobRJzfI=;
  b=VbX61qV0TYdu+7GDN/wVMxyvBCHgOaRvowuS4/NoMv2CDFStLRTNltui
   f/JA+zjIxJLr+Bdmmm7w7g7YWLatcXiysXkyDiseWaJT3g5WEZs0/zGnC
   nPlj6IaJnG0ZNEr6kRL0qdmIgL9HT62L1+ByQP3rOuP8BGIJ7Pey/8mWc
   uq663cygxEUxkRJ5lqbGbUGNlgiSSXEiJdV36USk2KXgfHai1qj+TS1Mo
   L8G3qg/ZRC5gm+5dq5mXEfTiGxduNRozkXAJZ7PVWnfccnJVbCAxWHaG4
   PYlS5LyEG8gb/6u+5BX2YW8az5+mHP4e2XikgtrCHFZFYgP/AWU5XIMXn
   g==;
IronPort-SDR: YSXg1PCdZBHPpPZnG+ZB+h011txLO2WCYYDGwgSw/E/ZcCWQAc9cNMWnGxPLlli8gUvlvhkkgr
 VZ1lZV7ZWmywGLy25i3KuXpbGYy5SxWAtyXu/q7pBjkaApmZ42MTRMeswBgjJomY/Xk5G12XCK
 NWwPzxBbfoGQydh/1FrhKMMNO54sLti/dmEy2OC/ujzyKXmReIC4jdwO1YTcCbBq8WvyXNZhZC
 vLcWQ+rT7RoVh/vm5M4VNvjXhqQIMRQ0H6ZO2Z0Xv74vYuILhqOaAO5ua19TdQK3TqBq0AbpCp
 k/A=
X-IronPort-AV: E=Sophos;i="5.82,307,1613404800"; 
   d="scan'208";a="173045940"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2021 17:20:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmMM8/Ky+GF80UViisJq+J9ElC5G8DSr3Z9rElHMf6zxlslTlR/UZyNWcnCeK+u9NZXq35nos1Ql3IX8W0VBfM9gISK2y3L0I90kPecuXf8MsjTfIcXnxcfD420G3DtrEWEV1qoDJtT17GrqVuswf+/apqhgAIH6MlT+iunQhDhrJ8ZNAGIApM2PwoXqW/P0XgUODC4IyfuiPXPA9lDs8xE5U8DxXMiXIyk/2O4/i/p8Vimrl0lHdRQ4611onAljBmDuaHhVHKsh5kHRe+F+iK5YgPHJ96UjSwC7gsFW8GdH+LQC5iTgF5AAxvvViC60UWKoE0+FUhMMzHjTWcrrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoMVC5Q1bSCcZ5TGtNpgvuvp0sBurbaDIoA7N6Q3500=;
 b=i965vZbHjIgUPZEhaP6ApsC8UoFP/SYzByv0fz5x2BQJXJd1A+Md3UGKbf/OnK1Vr9i3B/uPbH5GUo/q5Etsg30wttanpu+hp6H1Kmh0cAvFtqh5fuHomPFADVnHww7QAoBGhwyr2flj/HYeVO/5KoBhocsPwu5PVBivrlRRKwblvw4GqsGxvrfSYFHw0XykX0GiHqAWcA0O/h1pQjnGAFAcBgEYIWW0T4tJKlGiczSdKwVg99QOvSehdclhMqzskBX1JrKc/JNUAPrvXLXB4dZGMi3H/D+9CGiO7UzAkMEJzVebGz5H01xnvIP55HKrUIiknXizd/msiSySZSL+eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoMVC5Q1bSCcZ5TGtNpgvuvp0sBurbaDIoA7N6Q3500=;
 b=NIE8AiVCFM5rgy0OQKTpzk/MzYm4+pl/GY4PdB7YcL+00mSOvvSzYAhwO3iHPRFnFBl7d/sap1P8TSgOkqxTFMJsoFwpLYZGmM4Q+9kQUVhUpA9nsF/zWjtNMDjnvj3tFi9w0Zt1j0cWuBKQrc+TtEepXqm8ovbu0ADmKlftR3g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7670.namprd04.prod.outlook.com (2603:10b6:510:57::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 09:20:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 09:20:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: zoned: fix compressed writes
Thread-Topic: [PATCH 2/2] btrfs: zoned: fix compressed writes
Thread-Index: AQHXRzde03R8KYGMm0efltVC5jDu+w==
Date:   Mon, 17 May 2021 09:20:28 +0000
Message-ID: <PH0PR04MB74160EDEE8833D6027DC11AF9B2D9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1620824721.git.johannes.thumshirn@wdc.com>
 <52c1251218441dfeec909b34069d654aa45311c1.1620824721.git.johannes.thumshirn@wdc.com>
 <20210512144213.GS7604@twin.jikos.cz>
 <PH0PR04MB741608A91B3171D58DA902EF9B2D9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210517091237.GE7604@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:9ba:2a4d:8d47:65d9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49efd82e-5497-4fb4-eb0f-08d919150339
x-ms-traffictypediagnostic: PH0PR04MB7670:
x-microsoft-antispam-prvs: <PH0PR04MB76706257C643E22006C518219B2D9@PH0PR04MB7670.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9SWxoXEMyZ2jPxzzuXYb0WH44iIxe43SzBlV0xuJlgBlNLWxEF8jhQoxn0Xyc0jVpjwQBJTnFCyyGzPYSVOW7MAhSlqLcx56NKbLZcYm/fPkW+13/YcjRG9eG7ch54BgtBfzHE4QJDgBwG+PLimJsTVbZ0Uj8Y2S88J2yqxNtbIIbKqgXU+fyK8vbG07azDhfVo8VgV7R6zbx18d8ixw210gE19SDeb81LMplNvEy2g6zXFb4dTxBrS3iDpkyL9Z1i3Oyd2vi+MAfAHu+Q0T77A9i2LN1u6elv+WEEZEUEnvrADQn8nJ34nEppNsMXl5hZwLyJgiUl2ujjhvC+J0B1DdVtQB+6VAVBYKnHPzGmHnhW3NzFgb6GDm6nH0Nl4VQD08/5tjWcYMv9yfZHimQxQO/8mc5WzTWNhhMY1qDhG4ABKuvx7sYLF0NdygaGG+rZi7+2Ig+NPBWHmiwB1I/BD2pGQdwkgl5BFP/0ztn0B4z020SlILb6+zORJWiUJut66iZ6Bet4+SuMF/U9EgyR183X5TZGaZZAiewcscGsM/Wx2blPL3vRyXBJmXGd4Uf2B/4pGcrod1QP+NcfJ7t+aDK9jdbfMP8xcR7F2RE2Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(86362001)(83380400001)(91956017)(76116006)(66446008)(4326008)(64756008)(66556008)(316002)(8936002)(53546011)(6506007)(7696005)(66476007)(186003)(478600001)(2906002)(8676002)(71200400001)(55016002)(38100700002)(54906003)(6916009)(33656002)(66946007)(122000001)(52536014)(9686003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DIiuVoG4ea4wYZEoT/RRHw4RvYKyZW4Ccf8XC2pxHzRX5VHWTq3+2ZYURAHP?=
 =?us-ascii?Q?MCq/1sm9inyed2jOnRmo3+bh5X65hlVFZKFsd7W2i11IPgnp22+b7uEbrczY?=
 =?us-ascii?Q?AELhyPFABifbomlptC4a9lZ9T7H8SeycbyczMqWqzh/GXDQx8QQpjXAbbOp1?=
 =?us-ascii?Q?zv73zDmbKRD6Kem/gAIJ6ldNx0+K0LlYU/xroRiCPsfwELs+ixnUcM+054Xy?=
 =?us-ascii?Q?XF+KW58+St8rbsQwAyzVplLslaZ6K34erp7rROTE/oBzXtVP42x8HCft/P9s?=
 =?us-ascii?Q?2tXz3eJEiMNHnofmxLfTYCLcNbmuWR8WWLb4mIfffw5F5uGelfF5ZSsYdpvz?=
 =?us-ascii?Q?m2n3Xe4aXP8l77BZXNGe9WqkAZaG+WgP1htLkK6fzwqwtJORowNTbbyURdVA?=
 =?us-ascii?Q?u9IUW+TbH8V13MzRyyExYD1lGy9oRsW95eDgySomfd5TL+SEjQMI8P3hxTB/?=
 =?us-ascii?Q?pbQ/3VCgcvyJWF8oMdGrDLCPIgAx7SRAe1JVuWtNnyLXgGjj6KMSv2/lnDkc?=
 =?us-ascii?Q?rVX3zX5FSLHN8g141ZQEnBdHgVJS92zwqvdlzNf7BilTDjrNR8eU74EUAjGy?=
 =?us-ascii?Q?1gnSkmVfk4/xd/kCZN8eG1YsoEbxCRw7v4XrHSjK953wVng046jq/HLKwyea?=
 =?us-ascii?Q?X20nZMSHFAHXL+GNaxWPv3JGJ9QrgY4XGQ2WM1sAYEN25vvAPZ4HdOyFRfAR?=
 =?us-ascii?Q?RSK3/gTCUN1JJteAuH+FaaAhwNRbpyco9uZYz8JefkRRZaxP0vOTrKOYqJOP?=
 =?us-ascii?Q?4js9EfIAylOmTUJ53clO/HwVYCVulWSdFArGamSlIOnlVneKK/dNsLBonF0c?=
 =?us-ascii?Q?nJh7f4MgUrMXw0cLAG1F6IMinY9jkHskaWSI79HSRZF/Bg9J8L3i3yDRCy0+?=
 =?us-ascii?Q?kC6dDjBPbCssjZQHuncMFfFFwTMLMZVpJ+le2S9pqhTWMU173WwpT06VI05l?=
 =?us-ascii?Q?bxopmSEtKkXvosAUd+rfkokw229BLVcMO/t2IycyM0kTfz1bonj2gpzqrYz4?=
 =?us-ascii?Q?JFZWfzhIsKQbuxE5HCVNfXAuyQ4SAKZeIP9eSyuKLV3ZHqszJOuG4zprOlzb?=
 =?us-ascii?Q?sdFZEr5v3zV1F64xWvvzJbpcWhI5U6P/Y/PneyuhIrs9spuGM1/2pCJofVqZ?=
 =?us-ascii?Q?20dEr15D5WYMUw+UWg5okm/TZ02ODVwTJc7il1bLW18oD5wuBffHggR3CXHn?=
 =?us-ascii?Q?o+FhJSRVzhd7e4zjBsnIsOfAEltLH8MGklw0jdikrsNPFVNp6wzQ4KDFWvQc?=
 =?us-ascii?Q?x6Vn8rqwu+776nuzTEIvuDvH5UsO7fwicGv6K24YND5m6fO9pcoZergmcHXc?=
 =?us-ascii?Q?kR4+5PiVSVNic1thAcCtaox7gXxfrqAKrxXX1L5e7s2++TAro2QE7Jd19xxX?=
 =?us-ascii?Q?thbbCfFaatx+6Nbk1hVMt3A9XI2lUucxJElEF6ryB7fk0b9Upg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49efd82e-5497-4fb4-eb0f-08d919150339
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 09:20:28.6689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riJaUMj+Mz/AL3H/1KVd71OkBDM+qoVzoXmcFWN3L67VwE7XQYYPUGZ/nn6EatgtwZbAJioPAHc8LD7OQJHXGl8B0QuJ+UOd2lPnaEvFITw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7670
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2021 11:15, David Sterba wrote:=0A=
> On Mon, May 17, 2021 at 07:07:04AM +0000, Johannes Thumshirn wrote:=0A=
>> On 12/05/2021 16:44, David Sterba wrote:=0A=
>>> On Wed, May 12, 2021 at 11:01:40PM +0900, Johannes Thumshirn wrote:=0A=
>>>> +	if (use_append) {=0A=
>>>> +		struct extent_map *em;=0A=
>>>> +		struct map_lookup *map;=0A=
>>>> +=0A=
>>>> +		em =3D btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);=0A=
>>>=0A=
>>> The caller already does the em lookup, so this is duplicate, allocating=
=0A=
>>> memory, taking locks and doing a tree lookup. All happening on write ou=
t=0A=
>>> path so this seems heavy.=0A=
>>=0A=
>> Right, I did not check this, sorry. Is it OK to add another patch as =0A=
>> preparation swapping some of the parameters to btrfs_submit_compressed_w=
rite()=0A=
>> from the em?=0A=
> =0A=
> That would be another prep patch for the fix, I can't say now if this=0A=
> would be still suitable for stable.=0A=
> =0A=
>> Otherwise btrfs_submit_compressed_write() will have 10 parameters=0A=
>> which sounds awefull.=0A=
> =0A=
> In case the fix would have to be in one patch, extending the parameters=
=0A=
> to 10 would be acceptable, if followed by reduction cleanup (that won't=
=0A=
> have to be backported).=0A=
=0A=
OK, then I'll do that.=0A=
=0A=
> If you check the only caller of btrfs_submit_compressed_write, four=0A=
> parameters are from async_extent, and two are async_chunk, where=0A=
> async_extent =3D list_entry(async_chunk->extents.next, ...) so that shoul=
d=0A=
> be easy to reduce.=0A=
> =0A=
=0A=
Right =0A=

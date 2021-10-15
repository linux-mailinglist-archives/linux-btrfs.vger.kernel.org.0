Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3A742EFDB
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Oct 2021 13:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhJOLnb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Oct 2021 07:43:31 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:8583 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbhJOLn2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Oct 2021 07:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634298082; x=1665834082;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=JAGa4lVIP0AMn272ly21outPyMP/sCEMJ9zq8ciGKxY=;
  b=iqvKclLfktUC2qeRCSa9ar0KWL3dAGwGJoqvwImI97iz3DTA+XcTK5K0
   2RtOGmUq4IXIMIVXhE2r1ju7p+jd/w7ML4va5p4TuA/faLaAGt16DMXOY
   NrAdYKd0KNgt+BJqywSiuL358Ju+fiXgjYUW+Ph7t740s5Y4kcID389as
   VodZ76VNoFQw7M2Yn/wWgJNyBYzor7AW3EWyWCdNKHgUQL4lXLSToaag8
   em6vyOo2LrRQHQ468xrqTdcg8tm7OZhwiErYbCOH/zkW1vr3hrDCCwp56
   nxGkQTCHo54Xt2FQjDYn8H5efmkso6N2XQzkGLdgW4zS1YQ9+8knMazVs
   A==;
X-IronPort-AV: E=Sophos;i="5.85,375,1624291200"; 
   d="scan'208";a="181975020"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2021 19:41:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhrQc6cY/u8Ws0v3kI/5/YFnS9xZLpZp2vz1gqgioqlkE300/muLcW+p6K0OGjXT2glCkdyOeu2F3YN2SavjsvYL7wYZ0IvsB0q0ovWV3xynVXqzzKWhHqEE1d5c0yjtyN45+JZMij3j7mZjWw6L4oDo9TjvVHLcDTN2jxW6ba0Zh91hdtS/TNwvJvamtxPdzbWaqwCg/RblmeIieFAtk75udRLjukS9AMX8V3H9j3ojF8rPO9EpLFI+Lb56CPOzQXf1bqK/BV18V4aWfITTR7kvGcAxVKXtF/bUvp597gCN9SjwKBU3yfvA1sUlFd2+sYFZe6ecEgVxyFkxUtE9mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKyPC+sitSUoTdvlvxqizwFRvd7mSbw5eoD/Noj4M20=;
 b=LoZ6jXZjNtAsy5wjQCvCblj+JmCyD+FZirStdAy5YRnoKIiu5m+OdwGAQVwSsn6Y6Svk4bmwaYowGie1g+686bziTZtJVjbWfOBha3xpZ0qda5fSnxMbT5uMEhxRccDL4Y8jdyRJD+6gH9EGu90jVwNojHahVWMaAmMF2Tk6Be2Jbl46Kb1Kwa3NTuY8rBalh64IZrjI3mBWoN89jSa+1v96BDGGngs0M1dlS90iO+0oxxbOcFpRxlAJj53bu3h9Dx/Whyw9bidlzkyTVJ7tN0syhzW6NsqMVCthBfsT1FIxsvU5vnX4ae/aNnmV3q3U5vrKpihsIHFu21QXwJZMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKyPC+sitSUoTdvlvxqizwFRvd7mSbw5eoD/Noj4M20=;
 b=YjE+dAnYIYgqKSZRNu3csuFzYops8ebJQs1wyObUkhzms0OrgfMPeVpVugV2HmAS3vBRxD8ILqCxOr4M+fW8YQJyMGYgNDfVmMSgOjfBfWwhvaW3n1lSJ82WsT99tC8NrI94oSIO0y8lMRMPXZqEepHKFIGFRBBCF3axeMmJLws=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7496.namprd04.prod.outlook.com (2603:10b6:510:56::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 11:41:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 11:41:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Wan Jiabing <wanjiabing@vivo.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kael_w@yeah.net" <kael_w@yeah.net>
Subject: Re: [PATCH] btrfs: Simplify conditional in assert
Thread-Topic: [PATCH] btrfs: Simplify conditional in assert
Thread-Index: AQHXwbCaz3obs/f52kqrDQCLyWuaHw==
Date:   Fri, 15 Oct 2021 11:41:20 +0000
Message-ID: <PH0PR04MB7416FC5DCB8276A9E33DDAE09BB99@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211015103639.21838-1-wanjiabing@vivo.com>
 <20211015105154.GC30611@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b07b5a6b-c0c1-496d-b03a-08d98fd0b52c
x-ms-traffictypediagnostic: PH0PR04MB7496:
x-microsoft-antispam-prvs: <PH0PR04MB7496975A6470EAE19EC86E7E9BB99@PH0PR04MB7496.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oKFd23df/smAQdgyxUtHftogPd7McuXcK/KqkfNAZZIIQunFPr38j02reEipV78KQMfpA/b9GRIoVcyFe5tLLIMw2gY8UsUgQuh5mKFuTE5nrGl6GOtdlliJ92wvQtCKKFAf6RHxvAFIbt7s393N0LzsUSYkiwlwgkNg2SbWmKQbc6kXhUzolEuYzZpTQs8RZ9KwicnbuD32TeaJYm91IMij6tVBEqacHvMUj4IF811HFuUyfKX1Ey7bGa/2NuxrxO7fgAaA43n3QdNKaSCiZOwLwwk+29vqdxT478t917lWIRcRYHT75S0xdJQT4jDA7X84h8SSbX8hpc9KN65XC0pQxq8FM5RqMqB90/s1uVNKcLlmMhZsoKk8EUXMz41rTaDrBq+AItz3nyAYytBIqrJn9pb3JKD6SsKQeuKJaf4CokU9Csb7cSdOO5LFcKP6IksPadbOq17wfH91OU7590feAC2DsYYGoFascePZhALixioPIicL4n/TI3gtuuNWe0TgarQLPtIkcjlra6SP0UFSDLfedaaRquLbahEbEhF6v9ev7/CXSOpS1MAlRT4hJKVjQL+hq+YxAGLaLXn1m/nT/MYQqNMyJYqxsOZD4sAIF1DtWtH4HZYH8UALg5lfgtBg+U7PG0ltGD0d4C1zEtUYlz92q1I2LTPvc3Yp4/uk6EKMBvxxsykwn+xRUtfWySyKBE6mvam6ysZTPzHOrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(91956017)(64756008)(66946007)(5660300002)(2906002)(66556008)(66476007)(52536014)(66446008)(76116006)(55016002)(26005)(186003)(83380400001)(8676002)(71200400001)(86362001)(9686003)(8936002)(38070700005)(82960400001)(6506007)(110136005)(508600001)(4326008)(316002)(53546011)(38100700002)(33656002)(7696005)(122000001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bZj54DAKseVfAmONG2aucywfeYBr5rq9IIXG3wCJhUWU/NwXFxOx03vHtu5d?=
 =?us-ascii?Q?sEzF9xqR/62/tMk8/7v8ldRBfNHBOKslLnN1doWxdi/r/nC8/TdB1wWfjN81?=
 =?us-ascii?Q?udJKFhXS5H+/FLGvQsoLs6OCTfz6S3DfWhNItDXVW9f8+X2ztHarEWZaQNKF?=
 =?us-ascii?Q?q/59PL7LrgTKYPZEBjUVlNC6/nhjhBDyHK56Go+bckvdct9hnRS9a2tB8zgJ?=
 =?us-ascii?Q?jvI30IhVZ6z88z1NYBfQFouj+kGm32Pxz073jprgGOyeHaIaXKQjxYVK2av7?=
 =?us-ascii?Q?EY5D9HMDQFtyEGIj4iu2ubJtTQlCgxu2OJcYMiAcJkAanDBZHSWoZUMw+El6?=
 =?us-ascii?Q?8kVuWopjG176Ay2/upvJvibTt8V5gQQRTVHsCKq3Caby+UWwDhRwGq3m+4NV?=
 =?us-ascii?Q?SGk7oAtZuBuDArQKaI7sdb4VS32eFrUjlE7PKiLb75nHK3OcezODiULPOszr?=
 =?us-ascii?Q?3QeRdWt8uNLz0X+XmjV/zUR8h6Jn3qOpTPGQxNcn2U8ajvxLD2cRqLFjSN2r?=
 =?us-ascii?Q?0Fc3DdbHV4qn5wZ+GgTF3tTfOG+w+8xfaVm+Lp63k/tmWqHn+dCDfXnpbT2y?=
 =?us-ascii?Q?dANv6kgamthLe13Ks11LYOoC8qwb6jbQ0e1DukGMs5ah3l1j2AV+EoMSFQus?=
 =?us-ascii?Q?LTCHJN1AcxPRhU4Yb6QbsPgxNdfqAzopKXjSbmypukoasV+hgQirhXoLuNha?=
 =?us-ascii?Q?W9ViuAtdi95CHAT/wTccdJuzjZW0q0GVdiQGwKWGuhUkqEWpXVH29vLupb1C?=
 =?us-ascii?Q?X1CXHWMpORP57GbWM+Ggs1Yar9oU++MQroV/N8Fkxb6TyWP7ruZJlBLRxDmH?=
 =?us-ascii?Q?X7Yvdc9aMM0bGcAFJuLILTXimBEG4QMEz/tBZGE7HCkuwQ+u6nCtY/aCp91w?=
 =?us-ascii?Q?KOoAURf7jS3yr2u5zLsjp9Xg9E/2wdeoI3dl4zzdaFmdRzqo9U42e4Bxgl2G?=
 =?us-ascii?Q?QrZ/mg+zbDYih40PV7jfbrmSc5YW81WPdH+Qrdu5KG8ZjnS9wkCJ6QK/1wow?=
 =?us-ascii?Q?ZoN11RsMd5dY6BhcBpbleKUsP0iE2s+lqWaLZuhNYOgu2y8VFvNFGoGLqFuJ?=
 =?us-ascii?Q?keke1732PfWvlkzn8xT/oBIA6SW5hJwSc/44jbkiM7AFi3t4sJXvR005446p?=
 =?us-ascii?Q?7oLvIRtV6jeHWHlLoPWEkWQL9PArs86VcwL5OirZGdSAgcihxTZEfnnB2wZQ?=
 =?us-ascii?Q?bxDyWdWGEqsq01jxq+yxe+6Mnun3bCVgjG7R4W7RsovTrO8FE2qeaNnDVk2D?=
 =?us-ascii?Q?t7IhOe/YMG1RUI8hgWADN2ENGw59b7odQz/5JE5mAEdOWRvoIkpPQ6swvjCx?=
 =?us-ascii?Q?ccobxAr3nCwEJ3tXSSSCWooe?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07b5a6b-c0c1-496d-b03a-08d98fd0b52c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 11:41:20.3487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NclNwMlVgGa+vLz81Ry8K8+UecPTn4qO39cM0jP3tQFrqjOCzSC+9TxclWfc0pZKEZ906cCPrTZso882iKx3V9iNXZ6t9gdNm7aHut/nFIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7496
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/10/2021 12:52, David Sterba wrote:=0A=
> Adding Johannes to CC,=0A=
> =0A=
> On Fri, Oct 15, 2021 at 06:36:39AM -0400, Wan Jiabing wrote:=0A=
>> Fix following coccicheck warning:=0A=
>> ./fs/btrfs/inode.c:2015:16-18: WARNING !A || A && B is equivalent to !A =
|| B=0A=
>>=0A=
>> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>=0A=
>> ---=0A=
>>  fs/btrfs/inode.c | 3 +--=0A=
>>  1 file changed, 1 insertion(+), 2 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c=0A=
>> index e9154b436c47..da4aeef73b0d 100644=0A=
>> --- a/fs/btrfs/inode.c=0A=
>> +++ b/fs/btrfs/inode.c=0A=
>> @@ -2011,8 +2011,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *i=
node, struct page *locked_page=0A=
>>  		 * to use run_delalloc_nocow() here, like for  regular=0A=
>>  		 * preallocated inodes.=0A=
>>  		 */=0A=
>> -		ASSERT(!zoned ||=0A=
>> -		       (zoned && btrfs_is_data_reloc_root(inode->root)));=0A=
>> +		ASSERT(!zoned || btrfs_is_data_reloc_root(inode->root));=0A=
> =0A=
> The short form is equivalent, but I'm not sure it's also on the same=0A=
> level of readability. Repeating the 'zoned' condition check makes it=0A=
> obvious on first sight, which is what I'd prefer.=0A=
> =0A=
> Johannes if you'd like the new version I'll change it but otherwise I'm=
=0A=
> fine with what we have now.=0A=
=0A=
I'm fine either way, no strong preferences from my side.=0A=
=0A=

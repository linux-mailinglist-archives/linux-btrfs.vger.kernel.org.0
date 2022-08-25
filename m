Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3D5A0BB1
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Aug 2022 10:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbiHYIkr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Aug 2022 04:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbiHYIk0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Aug 2022 04:40:26 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA287EFD9
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 01:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661416811; x=1692952811;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hZJow4y8WUHvIYSaZM+EAa+NQh3n0HOiqfsvKK450J4=;
  b=W9gSMLyUKbiAqUOf6PRs5Sm3vEGwGk223jn1mLL8BHW8AWumN3ajt4Je
   E/UjPCt8D9JxYj9hHCTPQxWw+w8RpWBiQA12l0Q+nP4AAKGpZhLHChjOr
   F8WItK3IPlbMJva4+4jlc/c5nQ9hZql3dsQaYM6AOc5KA31tknZxmGlRa
   fWFMvi1MKxyFOfQ+PsH1/ZzcZOFNEolmNVeobJJerD1xwQwecyj/3rTsv
   RhWgl/JfsxVayNWKr0MldjLR0nHt1GW2MY17lJi5/TLxgRNqyAd0kzFHG
   vdIe2Rgsdm3oEPliVZglH4+kMKfcpE6hbsbGr5OMX/fRXcSybQgP0y3IK
   g==;
X-IronPort-AV: E=Sophos;i="5.93,262,1654531200"; 
   d="scan'208";a="209619340"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2022 16:40:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USiMkG13CyA+MLqYB9a5Usgb1eGg8nKD/QbCk1BYSxu0Fguhi7xQSryNsFhSlCOmsjFBCIUN3IUXSmlIj6hMOpEcoaCUER8OnnKwf29G3O36yp7g7/NxJ7iR5pa4sWpE2t0cwWCzVxAjq/CanZs70xlyTjMpoZmLSJ/rY8N6dkSCCboAR4cdUvXWq9gCqaip/pSAo6btNQjTmrce8ohZd9S3fsHjMVar3qqBJ2xmJBlxGVOmWX84t6BQ+QhfahT7f3cAqq7WLFejOQucRBd8S3SIJUNtQ687eW60E4DjQ6v0cwe1qUMSJ6N04fyk5BF/KE6/ZJjdQm6XWmbUzMSSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95ERTckjJz4bBG1/JJhNCJE5L44ACxaX/mpbzqsqyyg=;
 b=HB3rrw26CA9U6VRIrrT/0dli6AsL1pV7zUNlzkkO+fBQyOE6Jz+Gli/FDAPaqje7wBBy3iu1lcMJ4ywIW5z7F+0I+Mp0Rel7JhgoWDS1PvUlJSz0UyuWQxshJlF2wCKZIFSi5tazu8XkeZFXoSbO7ql2ckwf+WwmR0S693WDeSkAaRJhBkai4EqVbrNQCmcbxpOWq/RrMw3wCU4eiTF1nNP1DbsNmjRIGnJ1VSoKbdyXd06mTUj8MTUCQMjnqNTf5XtQKCOn8CffRHN+gpnzLBLEmfJWTsje4b0B/1j7+Tspc//HR+D8VrJYpvlt59aSZcRVwYajAipgNdZr4Gw2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95ERTckjJz4bBG1/JJhNCJE5L44ACxaX/mpbzqsqyyg=;
 b=Zz7IeovwfSGsZYvxhutEafZnTFO1xBD5DgODggJzuFWX04jV7gdB9Fri7L8JehnglhSiwXwZtv7MZ4+dI5YQBQ7JZNR5MFoVqI+iSyTXsbr/GuqzjF+tv8T0w2/fJWlMM4VtQxw/8G9GqTZoKK3NoktK9JeryiyNaMnv20sZvgY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4043.namprd04.prod.outlook.com (2603:10b6:5:b3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 08:40:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%6]) with mapi id 15.20.5546.023; Thu, 25 Aug 2022
 08:40:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Li Zhang <zhanglikernel@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] Make btrfs_prepare_device parallel during mkfs.btrfs
Thread-Topic: [PATCH] Make btrfs_prepare_device parallel during mkfs.btrfs
Thread-Index: AQHYt9NpDkp3mThM6UqLJhTeMttUdQ==
Date:   Thu, 25 Aug 2022 08:40:11 +0000
Message-ID: <PH0PR04MB74162C51700D05447DE485499B729@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <1661357103-22735-1-git-send-email-zhanglikernel@gmail.com>
 <c3dc352c-8393-c564-4366-42fb9ece021e@gmx.com>
 <PH0PR04MB7416B660C501F73F47E7D4159B729@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1ff7ddcb-0a95-d023-d346-e86cc6195afd@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f422036-93fc-466a-ca10-08da86756c8e
x-ms-traffictypediagnostic: DM6PR04MB4043:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H0qM54Yh2bFbRHml1j8QonbVClrmHyeBdX5B+bySkviSkClLpSvbfphkDdKacI0nbjeXOsmrjE/AyPDdsjwBHGvQqGKy8NIcA80BD4159s8kGWKjYq4VPSRnVQMQ46IX9vRS3vsxXD469JV8ZNBOERVIXZ5DRllhLhNpi+qQynHb71vvmZzRes9JLJGa9+E6fpj7HRBQ/aOLtP4ZCuexmHXet8/4QTik11J+PDPr+xqrhJ9BZiKB+fzT6/bb29f9UGuRjA5QgPLsOKnwWgS+D3zrK1pUZNIDvwSNqlVm5QqiZmup984jKjZhmSvbTEzTB6GaNdahNRdRTWXLMz837HxkOLy89hAmnt8cpipZWsv991GWpkzCZLLmxMEMDsMqABcnGn0RzkNYLlV5PUwy25CVyheqYLfYi2S4iMAmb1vzDumhF9U1aY5XBCP5aULrzi2qZo7TxGs6dSC2dJo7AZUJOM1KB+K5nHBO6nzBfwNW+fRKt8hN2LAWSY2GDMWnzMQAQD0ccyO0VpA6W9K6EzdRQvqHN4PtcC0gfdLx4EHvatMp1ja7qdSEoe4y/u40tTVkOKtsGY0H5MilD0+XH10WkYDguAG8QRIaxR+YKVClaRpu+QsG5oEM2voWclZ67/3NueTA8qeVOZYLpGED9EwBewa45toZrZypMhxnL8Fl2VuRmSKmkH4Tg+GwW2FDjg28C9I6L53xgLHjFJ5kdtXohEvC+q1dzTNQ2OtV+kG8QEnv9P2dmNKXNHRqPiHNpCrj/RzD/ebuuUix0d1PnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(478600001)(71200400001)(316002)(82960400001)(186003)(110136005)(38070700005)(41300700001)(53546011)(7696005)(38100700002)(66946007)(26005)(9686003)(122000001)(66556008)(66476007)(8676002)(6506007)(33656002)(66446008)(4744005)(8936002)(5660300002)(2906002)(64756008)(86362001)(55016003)(52536014)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hQQR/FL4VwlIX+4v98YFR/XMqM8nZ5ljPZ1ZQA4FT7nMfdvWeaCOY9suU3/f?=
 =?us-ascii?Q?0G5UD6NG7IKJ6+jT21DQ4m2weUN7vuw6qcsUGR/SiTZpg6J26iA3ZeuFNIQc?=
 =?us-ascii?Q?Rb192yeJUHB+mn+CbjoPVT8fiLGwt8ZicizNOxlFWWUatHCEzgKax/hqT2Gr?=
 =?us-ascii?Q?QCI2peDqRkxniKaTuuIZYbILRziuCkF6QqeeTzykQWCXdNTwrwN82pdEXoGi?=
 =?us-ascii?Q?7ap6e6cR+v+obTVRaCFAVtuw53ofHV4BMVE7vrFFVamqiOcDzO4gBxRSmSvy?=
 =?us-ascii?Q?Da/su1rQfhdM3WXXZvAs6dgoHPbhTiAnngdlvk27snU2h9hs620rzIFwWZj8?=
 =?us-ascii?Q?mWybT6KmdbPPo2xUx9wRbsTlxXsaEBtBgAlMmfeoM+kdizynF/5jj1n8FkjC?=
 =?us-ascii?Q?L2zIeyujf6kFKfQkb+ge2GRDgTstB+zzJPMMnSQJFkVCWaeCNbPMUad5cSTE?=
 =?us-ascii?Q?sXmvpBt92F3+ufL5S18gsmcDzsBT6lua8KfyZqMn/y/PeWApaHXloLS0vvEP?=
 =?us-ascii?Q?80ZWhylk+CRmvnztkDKUxKUDpYIMmM7aaZRUpTSBfygKp65HVB3vADahhZnX?=
 =?us-ascii?Q?0QqKl5qMrIzI+eYvv/ZfXYEVym8MXFLcPNOZHVLC+zy1E5Xu4MnYRwhP7hSN?=
 =?us-ascii?Q?7Q1QPZgHjta5waC6rcUe7yK2YoOXM19OURlz9gt5HIcwdsasuF/Mn5mzKNFY?=
 =?us-ascii?Q?9nmJQfo4ABQWveKnqk7/8FSHf0BrdZC7thV5LUT9Yy4Q86YRhaRR3/pDuZ8b?=
 =?us-ascii?Q?w2a6m7NyoWJqRJf3JW/Z0ayWVFnq6ukgHWrB5uMvf1zlbUOjptwcl/H1MWE4?=
 =?us-ascii?Q?ztBM3uRZvi9UkorZ2s3J93JCtHMWrAsxhQaif3pKIv2XNund0+t21enxkawU?=
 =?us-ascii?Q?I3QIJzLdwoyt9jLov4sYlK0uD+9FiuEBY0+emh0IcHFOTbSxdH00itZUcZaN?=
 =?us-ascii?Q?TfdveigW4K9eqJmXkWF5S9HpOzeSeASzci8efw/P4NtXn4ZyeN43ogmwtLJT?=
 =?us-ascii?Q?XklkdPjSyIZNaN6E/VcJRaajNeTcqktjIqD6Vg5LghBOMOygdOVTqfKANToz?=
 =?us-ascii?Q?XT8utmc7tDmsfVQK1UqpsMqi9dljCdmsB3k40Qk+Rt6vcu7Ym/slP9nG3xRY?=
 =?us-ascii?Q?V4imKiBjEEXDRJ0/Z67/h3U8gv6BbWIO20Wz0TBs1plhhU8OxcK5I2SwHg/e?=
 =?us-ascii?Q?ZfULRNRUZh3x6+gIRyzFAa2ZwpESrctnGo1pSGLMNOmJOlvzQLElGncKyW8P?=
 =?us-ascii?Q?3rme96MYrOQ4OhTntb05QzTM1VBA0gRiZfqmEiFTM4CRqN3fi9cnqyYgVmcW?=
 =?us-ascii?Q?/zReizURTyMEwe9gnL/Rk5pSphzm9lVNzFyXYqdxwEuwcNWz0OsmlBUyOddC?=
 =?us-ascii?Q?LQps6bI7DRJhmyZLl6+/zVSr3m3R1lslb86OjMF4Exyx06NRng5dY385Sdh4?=
 =?us-ascii?Q?siBHLWM69yA7nCBM0AgBg1ntNeJI2gzbWI4YsZVtBuaYgPDu3rLICh0UvWkz?=
 =?us-ascii?Q?YdkWz2rHZNudwIc2hpZfZbClJ8qyrZKIRGXRrM9zC/mLzS1nUNt067gi6UXo?=
 =?us-ascii?Q?//eessa5oLmM0tBdP49rOlRVCaNL64xvhK+fPVxHqIxDzbMxNaCY2WlVzSru?=
 =?us-ascii?Q?eA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f422036-93fc-466a-ca10-08da86756c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 08:40:11.6626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Me/D8+bY+BXA2+UegqSwG4+9r2622IHzeH7PyIwEaL11Yn18FZ1vjS/Hx5GPDly90RdWEa/EgekZ8T+TYwIC/jY+J/H9ZCRgYIt2TTmMF3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4043
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25.08.22 10:36, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2022/8/25 16:31, Johannes Thumshirn wrote:=0A=
>> On 25.08.22 07:20, Qu Wenruo wrote:=0A=
>>>> +			if (zoned && zoned_model(file) =3D=3D ZONED_HOST_MANAGED)=0A=
>>>> +				prepare_ctx[i].oflags =3D O_RDWR | O_DIRECT;=0A=
>>> Do we need to treat the initial and other devices differently?=0A=
>>>=0A=
>>> Can't we use the same flags for all devices?=0A=
>>>=0A=
>>>=0A=
>>=0A=
>> Yep we need to have the same flags for all devices. Otherwise only=0A=
>> device 0 will be opened with O_DIRECT, in case of a host-managed one and=
=0A=
>> the subsequent will be opened without O_DIRECT causing mkfs to fail.=0A=
> =0A=
> Just a little curious, currently btrfs doesn't support mixed=0A=
> traditional/zoned devices, right?=0A=
> =0A=
> So that O_DIRECT for all devices are for future mixed zoned mode?=0A=
=0A=
We need it in case of multiple zoned devices as well. The mixed mode =0A=
you describe above could actually work thanks to the zoned emulation =0A=
we have in place. But I've never actually tried to be honest.=0A=
=0A=

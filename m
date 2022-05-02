Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843D95176B4
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 May 2022 20:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbiEBSos (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 May 2022 14:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387007AbiEBSoc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 May 2022 14:44:32 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8161F27
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 11:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651516861; x=1683052861;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PyFbCoWs2aMnaiAePuJSQ46AvpP0oya/zWvoiqFzPDs=;
  b=jTqt0XtmW7LuRzpV75Ev7AIxL9w02UCbDzRZxWFlX7Tj9Cqk1s2IDpeS
   mMh1W6e0pqMZ6i5PL5K+4Lln2g1Yut8ny1AlibYTKhD3gSSovP8qNHszs
   P63F7EzDd2W2jub3fenRY/TaSrRQfjMw+Sce0JkHwKqD+S0vUwxDKo2TK
   YNnK//xVeEfG1i7prFr3Zg6GmtuUeqJKYyfwsrvrvlv7UI4hquSGAz3Ji
   LY4VbK8kktRig677WBCZPho2mDkZg+kGDEpI4+30uHtzG1emidN5zQMzP
   F+SkBQy3rMI1APtw8SRuZ5d5HQ9mJbMHiCOK/LpN6L/vjMNSAa9LKRevS
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,192,1647273600"; 
   d="scan'208";a="303572694"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 03 May 2022 02:41:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4wr5TmmBPatZB8poxDihBCv1BR5Gvk0FFYBXxzhS1FnkZB7mp67bnzW+kyCH05OazeeumasFzTJLHZcR4+Ypdiz38CgK4+TxSUiFA5C6IfKpOMpPNbIH3GqNZGU1jg6r/xZVg7EeXn36qeE+dX4HruDXu9aoKcMQVxYTps1Or2Fu7A7ffA+k/MuQuZUT4ICzX1u+EUjGIdpikmuJuZC5yUyEDTOKcLs5UzQVoj/YQdc8R4o+OMs9ecWwoJNIXVfWDdy+wRj6WY/K6d6l/oJ+Jsp1Ae3CRZtDjLcxy027w2ElCODabWKaO3JkWYzLVNiwjkIoz29QP8DW21P41pytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6x6wqR9kQSZRCBLEi/0+6pjrZiob2kYVhGnhYaHrhBU=;
 b=HinUJHQ6kU3IKzwzM1gRott+dDgaT9WgUYRqdpruJIuAxHaehls7uoJv9UUcBl0SyNuNVzb+Nve5hJhlxWIrwOu+0hGcXpYrD3vepoS07+i/w0G0hOc1vJviq1t1kOQu8JPT/Q49XxfGyFi0SUsyVlqzNtoiI+Nr8I+0PT5gnzP2MrmRJavz32xZ/uYMOSGrEAwDOSnYQi3sCaJKESTDAVjZa8niUFPX2VlHVvWw54ztf50jVYrU93zJvkfSt5fq4fM9eRztGZdLsqcTPzxk6hDomDTjb8zlvvp1uHyJDLfSD3UoF5OKuPrWqCog0EyIzsMA5xsCt4tkiu7IM85zEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6x6wqR9kQSZRCBLEi/0+6pjrZiob2kYVhGnhYaHrhBU=;
 b=uNaq0OKlQNxeKOiJ+UFfypc1E88ztTm6eBSOw0ar9gsVOUyW5zXlmzO12IGLWnSfDP+orvhPwKGyjFYX67YP8OBqxYx3UDYCB9kRTE3TaYvnI9eqXr0cAWuwV10gGKWoh0wj85t45/YVO9FE7oJplYdnvsGujmdj1fBQu78X2wo=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN7PR04MB4371.namprd04.prod.outlook.com (2603:10b6:406:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Mon, 2 May
 2022 18:40:58 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8db2:701a:a93d:9b93]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8db2:701a:a93d:9b93%9]) with mapi id 15.20.5206.024; Mon, 2 May 2022
 18:40:58 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Pankaj Raghav <pankydev8@gmail.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 2/4] btrfs: zoned: finish BG when there are no more
 allocatable bytes left
Thread-Topic: [PATCH 2/4] btrfs: zoned: finish BG when there are no more
 allocatable bytes left
Thread-Index: AQHYWxD5FfVKPjhGVk+n/ozX4eNRe60Gyc6AgAUoVoA=
Date:   Mon, 2 May 2022 18:40:58 +0000
Message-ID: <20220502183657.plnztir3ggozlzxm@naota-x1>
References: <cover.1651157034.git.naohiro.aota@wdc.com>
 <42758829d8696a471a27f7aaeab5468f60b1565d.1651157034.git.naohiro.aota@wdc.com>
 <20220429115507.l2zxgcj634nw2ytd@quentin>
In-Reply-To: <20220429115507.l2zxgcj634nw2ytd@quentin>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9859e93-b8ea-4b0a-b568-08da2c6b4ca3
x-ms-traffictypediagnostic: BN7PR04MB4371:EE_
x-microsoft-antispam-prvs: <BN7PR04MB4371906A4EC2AA03341E91628CC19@BN7PR04MB4371.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V3Es51qqYmFKKWl/3fWoEhQslRtMpC5NsSgvsV3sRZYJoE5J/K+YOVlnDvcwu7/dx0CoDVNj3WsY7h9zP3qsPPmu1MAZQVnCdz+dYwNHJLDxShRsES04okoTKi9rZg/jFA/1Kr3/DKfEL2R8fAHVqH9wlqG/CEUvbjQNNtndd09R5gxz+6z8BJ5UBJQ/bZvq8I1K3u+/n1AgwFL3qOOjQpD/54tnjiXLFobe/pRuY7o7x4Js4fWyIgf5am4/gWZCd6DV33EdP+u3nl2RK/yMQOHWVjR+akqHMK6nc3dsUj06RE6A9XMWwAmctkRqjry6EdTnqG4OWqP9sx9WbuU5yotjsJZn8ZfX0+DfSsDZhdQt08p/bUIj+HNPq+7xW1DQqKSytBqdR/tMFXeAMxVmbdvCnlKs4l5IopugPHRbePI/pCzVqRLstAJUdHVXExni8bw8AsmTYRHfLO2JvgKtdiuQGQIPvN0WRj7+Wvul/E802bEypK2TAJY8YHDnXZ1UFxwQOMroHFwMXvAko2RxBO/svvvvraE3RBQoBfWy+KgjkLOwG05v2I6cLcyz/oZDHNYe3fK4JeulhwqdxkdefOTnevfVlZXd/n+O1E02nNY1iCk1Eza+4AF10xThtbCYG49fdhr/hVeIYIdE/esUczuNoYb5kJ7MgzrjQ0xBSXzj+DUJOOzYEsz+3QZ8vSzi50YViMCV1bwEohoH6gDUVqJupMA2fQw88BEiwpRQO/I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(66556008)(86362001)(66476007)(1076003)(186003)(4326008)(64756008)(8676002)(66946007)(76116006)(91956017)(508600001)(66446008)(26005)(6486002)(9686003)(38070700005)(71200400001)(38100700002)(54906003)(82960400001)(6512007)(6506007)(8936002)(6916009)(316002)(122000001)(2906002)(83380400001)(5660300002)(33716001)(29513003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R4UPcMY8JbBtyPkR37Xf90FXxZWm0vMKC+DKJaW3qlpaP5bDk6pFYKHc5vq5?=
 =?us-ascii?Q?XHLECvqvgWm9naT26QSOq57sn9zcefb5DVQ9aB6uQqaYwlRuxLMkCdiMLr8j?=
 =?us-ascii?Q?7zv/7NSkRD2OoSUonHC7H7PNw7dx1NUtjRmN6FR/47nA/VKXyZo1sCmqVi1w?=
 =?us-ascii?Q?jQ50/v4t2UxuGzWN8GRtL+up+qF9jaiQUutgLmQqe4eVlWoodzNcr198exSg?=
 =?us-ascii?Q?BrPkPJ3beXM1HG3YBTFih/pUlz2eCuQJgYBHm1tIJzKhkgpZE98ZHwYsZE8S?=
 =?us-ascii?Q?kk9kqE2xMwvmgqoLJ6OwnUOG1sLpwNdDj9+Y5UnhbPlnrQIHMHr2wp60jM3v?=
 =?us-ascii?Q?PImmQcmhWBvrFafDEoApyI6awLeRzMEETSP/lUqHtIOhTUYU85sICirIT1rv?=
 =?us-ascii?Q?MVxYD1QkBYRmOzFhysbLMQc4mhAZZYWYiXh/tq0k+0bvcpvHmbV0+2uSUSTd?=
 =?us-ascii?Q?f9XeJ5PJ0XPJZfzPwk78C08/AHyoGauX+o+W4NXZ+rTqkc6Hd+f3BRoJ97qy?=
 =?us-ascii?Q?WEPin6f1apUxenghBictwCzq63YnG6Qmi1iWIB72/pVXXWpDl1vPe7BndIxb?=
 =?us-ascii?Q?ppAPuHhJTskZfO65zJD0DyJ0bMCuQTjrqVcC/tKgEU2gn/NLqSZwtvqst3ud?=
 =?us-ascii?Q?S9YUEXgVNSvbc5K3cb0NkhPDUFxze1z1BulJ60UTSRYSbFlakfcFZKHYKbQ1?=
 =?us-ascii?Q?IMNERDJnoybZvbGysRsCLWBH4rRITaJu8Tv6Athr0ZRlSXTAeflni0y49Hhh?=
 =?us-ascii?Q?FO6MMY4rlphAcWTLiiecjTwW4eRfZHiP1afRfQ6n88aYPOafCjwIXme3L//6?=
 =?us-ascii?Q?m2Q/mJgptTScfb/9jroO561ALxdQn2XThldVPV37F959jIirlKJ3nI72CZRq?=
 =?us-ascii?Q?Vl/BvFWJRKAss+NqqaempdkmGeCaRroaLxG703NroN72qSZVTgIjd8+5ODVS?=
 =?us-ascii?Q?h8MF3pFisvlNr3RBt0t4qKX2rtctYZR8LcGo+k188j6FRWGIg30J+ZvzhaY/?=
 =?us-ascii?Q?eyuC2YF2br3SVSTY1WIxwlMYJyCTf+lvUvUc78Xjz498YS/2Z5DwkmTyMQx5?=
 =?us-ascii?Q?6whzUBM6JbIQU88vHsvt6/znULqBk3Qn7RtB7XVwDW/Fm9gvkey+rYVp+5AC?=
 =?us-ascii?Q?kqA4QloTJcijiLlVQBAwySO1ugE11nvzU9ZAvEE62O6BzvdfqeEGd3THhYXP?=
 =?us-ascii?Q?/2wJElhJhOg0C9i8ttTbViF9zl6jQon2AfTmhl4XLFG8voDJLdfJy+HRGP4i?=
 =?us-ascii?Q?bPTQMq/EQH6xJMzWYO+fW8k02jfH5eRqbyY3lLBnI35R+QiKlnq8dVNU4UT6?=
 =?us-ascii?Q?JUAXidLsGiE3TbONy3zk22zbxyFghq52+LFNnH+dxuTqAsTsCs4Jkxbc3rD/?=
 =?us-ascii?Q?zNMl1d6TnTuOv7WXRly+peSsnL5t9Z9x2O6+XJbWhPmHWaGdQS88nONMWkTo?=
 =?us-ascii?Q?ZPFx8W21eYKpCZYAHOWIJIv0r1XcIMMzKJoBqGQcO68JmBhvvhW6Rt3Q4TLf?=
 =?us-ascii?Q?bDu9YDL6kexTi0SK6SSNliaiGaq5nSRuawl/rBxHqCJaw3RtKy85QaWSiW3K?=
 =?us-ascii?Q?Vd+aHMxF9yaKZf7N83SgW1hNel27pqTpVEsU4daQaM97GpIL/lNyL+u65jSr?=
 =?us-ascii?Q?7Z6ilndbWbcRHE69Ik9iZsK8FXOxdmYYdlDPQGjooFNVEIkQSJJBkAamgj4D?=
 =?us-ascii?Q?VSJx54rxjUyH4PgzZIrmJhDwW5VgF3hoDxzpNKqgTlwrlfsvupLVm+o7/59d?=
 =?us-ascii?Q?ayoDVFJnKa64N7vMr3wKEVydwMpEZfw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1289E43D3433274CBB820816959EDB41@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9859e93-b8ea-4b0a-b568-08da2c6b4ca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 18:40:58.4797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lx+nYwLT3uPxYE0wQcinCU0b4FAifB9ykjflTOMA0TO4m0jBtqFnA2uoZrueIWYGdte5T2wu7xRsEIjJ4HQ+Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB4371
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 29, 2022 at 01:55:07PM +0200, Pankaj Raghav wrote:
> On Fri, Apr 29, 2022 at 12:02:16AM +0900, Naohiro Aota wrote:
> > +++ b/fs/btrfs/zoned.c
> > @@ -2017,6 +2017,7 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devi=
ces *fs_devices, u64 flags)
> >  void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logica=
l, u64 length)
> >  {
> >  	struct btrfs_block_group *block_group;
> > +	u64 min_use;
> minor nit:
> Could you rename this variable to `min_alloc_bytes` or something else
> more descriptive?

Sure. It looks better.

> > =20
> >  	if (!btrfs_is_zoned(fs_info))
> >  		return;
> > @@ -2024,7 +2025,14 @@ void btrfs_zone_finish_endio(struct btrfs_fs_inf=
o *fs_info, u64 logical, u64 len
> >  	block_group =3D btrfs_lookup_block_group(fs_info, logical);
> >  	ASSERT(block_group);
> > =20
> > -	if (logical + length < block_group->start + block_group->zone_capacit=
y)
> > +	/* No MIXED BG on zoned btrfs. */
> > +	if (block_group->flags & BTRFS_BLOCK_GROUP_DATA)
> > +		min_use =3D fs_info->sectorsize;
> > +	else
> > +		min_use =3D fs_info->nodesize;
> > +
> > +	/* Bail out if we can allocate more data from this BG. */
> > +	if (logical + length + min_use <=3D block_group->start + block_group-=
>zone_capacity)
> >  		goto out;
> > =20
> >  	__btrfs_zone_finish(block_group, true);
> > --=20
> > 2.35.1
> >=20
> Otherwise the changes look good to me.
>=20
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
>=20
> --=20
> Pankaj Raghav=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC3F75EB67
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 08:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjGXGTl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 02:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGXGTi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 02:19:38 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5E1B9;
        Sun, 23 Jul 2023 23:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690179577; x=1721715577;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qhkqHkRGxJxMzYg/YFj/UIt9mQPFQOTDBdW5gTTuweY=;
  b=hwH8249LILD5qZq+xIagerNoiY50tx2bNephHczAR+1pSX7W/8rxe5uB
   SdqIundQre8HimB/fDCTg/+ktbID260TzBkFhok8JH/3YvuH8eVgdOcIA
   xu7GjIAhq/SxukJKNaA7XaTTNIrHVg8dvomajlC3fWQH9MJWjKyrrADiY
   k1MEvRT8V+A4qXBMWKUrdV/2ADZlYHs/ZMVZbvsr9gHnwHPW2iHC2yoYI
   gMSzXifuUVe6x5+7k305THgDg+c+3BZM9wfaacxa+KK0H2LqaTgd8Gp32
   033TGyRJX9qXcHkPqDDALZhgkriuy42u6V5wOBB7OGpGb1jpvgrP14pjV
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684771200"; 
   d="scan'208";a="343968010"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jul 2023 14:19:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxZKSycpxJeCKXcthigCkaNZKTbEnfdzfKUBq72LCKhoab77b296vpHDjBXLTn4eraM5hClRcJmFu6zD+1AoezfBaLBbsOtd0JGhkdjgRfLJg92jPszNYzSDq1gC6ScqYtQomMW6dSoJ3HD3Dc/hWH+3YEAwgoet95q7pnBreD3paiFDKBmIox5xFVMHSbIkmXq/emY2d1D3Yw6vFvJmHJE8WX2r30gnJEB4idb7538DhI17jcEI0S+cFeqHDWOxZlwz6HsxEp2AA7ui06xfJIkK6JbCIuAEljAhM5ikMLwZybAitk2grJai5Zquowos2PLxN6ta0TovmRPODsmH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9QBjVN0Z/Yy1NqVnQBDoIiKTJ0+D51hBG49I4gb55A=;
 b=Jx7vZ4PffqdOcbARtiREBsJnKGa+nAGXCcEI6+jailYIPDd9yaV+J+OYqByT0zd15gGORpGQXcRShG+KkVxcvBMUf8DJuDF2NOyjnMgoNN4WZhIczfu11HhJQ5yRIF8JjlkDx/eO07d3VTNobPZHr2EqPaQQlUEXc3uxg5zF41TxCZAfxmh08bAw6X9hYvQzNIEOKZdp/HZ40gjvLfnnsSxYxifgyjSHqxyn4ouI0Ih31+fa7v7Fupo6h1WwJp6FYA8a1nwFbJJDBgWEvQHMqbUO+n1O17FQbQYNUzIYM55onov9bjAf9F62hFD39iVrPeERGfmXEJhibdcVIzYAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9QBjVN0Z/Yy1NqVnQBDoIiKTJ0+D51hBG49I4gb55A=;
 b=hf3VXjBZN0vPKPGDgLDjrRJUk4RVysaAPUSZ7oSfisUPgUojQXa7MZOCRAb4okyYOzV6ur22mjUpT8V9tgvCiFQ9jxJZ4RzulE8Ugr0hXkS9mNQjPQ9It552QiCb3/zKCwFtRGM3MeZWFJGuxrnA42TrjVOjNxSt1vNOCDayv98=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH0PR04MB8386.namprd04.prod.outlook.com (2603:10b6:510:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Mon, 24 Jul
 2023 06:19:34 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::95cf:429a:bc0:991]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::95cf:429a:bc0:991%5]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 06:19:33 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Qu Wenruo <wqu@suse.com>, Zorro Lang <zlang@redhat.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] btrfs/294: reject zoned devices for now
Thread-Topic: [PATCH] btrfs/294: reject zoned devices for now
Thread-Index: AQHZvduepXjHXQCS10KL3UE3VgNq2K/IWmwAgAAXewA=
Date:   Mon, 24 Jul 2023 06:19:33 +0000
Message-ID: <verdmknndykomgl6fnuajto5kmv3gcpoqooauxjpvjzn3mdo6e@pe5f7sevy4yo>
References: <20230724030423.92390-1-wqu@suse.com>
 <20230724045530.mhtb3fnbdodpvfjb@zlang-mailbox>
In-Reply-To: <20230724045530.mhtb3fnbdodpvfjb@zlang-mailbox>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH0PR04MB8386:EE_
x-ms-office365-filtering-correlation-id: a81782e0-92e4-4cc2-4402-08db8c0df2a9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uT5nm7IYqgTks/1Mz6/AZacC8rvc7ttmLJjwGZT9fAEo7TUrhoxOdxtSD2sYiEzcwO04b8nCJZn1JgmTVjjuNHgLaW4kRbCsDeD+mAabDUkgxYaRYOphaNeiOjO5E8g2BjIoHyEjgd3FWTsjHIyGjUxqCk3iVVp8HykTPdBwaWsInLk/siWmrgcMKM7s1OhWjgA2Hvvl63pmVv14s8cVZFToMUWvEnY8nQBoNSsfbBAr9qMpYzInq+GcKn2Q1GI6+andgKHrQbo0Dtixg2nJ7gsj0vnMX4wqnic5+U6w+kUVteAU4FUo9bWTyebB1UR/2GYDwLb7hx4DN3oZg1syiI6jc/gt1J2lE3csB7g+NLvUnoC8pIL86ova5N4stIZfZp0JKGB941v3lZMXUp3jkL+GHx8aZ65KIRy5gJOMKI/+46btNLJGYC/3/VYYTYcmWBAtrASxle24KJPcoO0uiYt5saeHGKvKi39ns5oyxHvj2+ea6zRkIo8uacOyspWzQDL2cduI9uWqyaDzVQAmR3em5GERLI6jd1H7WTkIGNe8Quty2/Lj5zP0q/u1ZtXWrsq0EygLTDNJ8W7YrWX+M0lHalf55hBr7VilwByDGetVExjcErjUEnZYAqPflKiu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(2906002)(33716001)(38100700002)(478600001)(8676002)(6512007)(82960400001)(122000001)(9686003)(83380400001)(186003)(6506007)(26005)(5660300002)(86362001)(8936002)(71200400001)(6486002)(66446008)(76116006)(66946007)(66476007)(64756008)(66556008)(38070700005)(316002)(54906003)(110136005)(91956017)(41300700001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BuFLgkwbNLF22DfflifepOQKoOiRAaouOH/6R2wgfRqWnk3wPRshaz6VeBEx?=
 =?us-ascii?Q?5UlLYdthp/a9R3MDFCFo4Nyz+Bs/xnZvy0BRkjTZBUXzyHpn+T8CGp44GGXE?=
 =?us-ascii?Q?tGm1tR/0I5QYDOTYnqaMCuYa24E2p73RJyDOqsd29GEHxGxR6JGPZoxdOFIa?=
 =?us-ascii?Q?pfWYi2RKFy1fWa4rSqDri+odjdcdaIafgIw9wGHToUcDbqtyTlhENk63qZEE?=
 =?us-ascii?Q?azvZ2V1t4s32OGyXLENDcYZFg0235aR5I38zpqhzv11iQmeCqiQ/FHhhq//X?=
 =?us-ascii?Q?3ptkOK63VbHZth3FezZSQibBWiKBzo8XlsFmJBj8HzO4VJhuLXRmIwxVcPMS?=
 =?us-ascii?Q?BMS2no74l208kG0dyt/5eYOGyL9mtkWTaE5M6a9nRR0h0fD8abUU216aFBP6?=
 =?us-ascii?Q?TOSaU5ooGdr5pFLWCkjewPntxH0/fC0c7o/JhAmqznKIinlFKrEU0bhMB6G0?=
 =?us-ascii?Q?LpLVIDewZNR4/08DQShOtZ7RGE57ZyQiWOJF29yFHYZXVa0csea2FzQm7eoE?=
 =?us-ascii?Q?9BsnhhZOfalLW1bxDI4D4NWZi9plqEDkzV8vaHiORZ4SoT8vWX/hOkpc8Gak?=
 =?us-ascii?Q?LEIVvqfBpg+SX7ckEvin9fqkvQIENgcT1W2l9Kvbs9WRyR82d6hk6mI9Lf8J?=
 =?us-ascii?Q?fw4h+KWPdkagyC5JLot0sAmI+P8UhrhLBQZOchRPfNcOZZxrlG8p3WDMY8ot?=
 =?us-ascii?Q?MlwTkbALpRvYPMiMXLQ9FskLqcY00m7AWV4SKXjh92La8qY6Hw2WK7rGD7RX?=
 =?us-ascii?Q?Ui6UVykDKv5c6f/UYbuQlGRBs0ziQBOFv78nyPtedpyC9DtnuffNEwYf8K8f?=
 =?us-ascii?Q?DuymztHMzEBJYzgcaRw/SSnYqgQuLOrF6XKtdr1DNl/ydND6o0N0MprTxw2Y?=
 =?us-ascii?Q?+O6afk4EtTrOfchqJjGdYLnPu8YjJaqwxQuZcl7hUHKwQyzNEipEz2sUUhX0?=
 =?us-ascii?Q?IxDEmvsPZZFDcFQBal1mGMCg8V7uo/SAYvxHafClQluPdbbcSSeelBmc/Tua?=
 =?us-ascii?Q?33pwpRxCurURihjl6Fzvso7me7HsbZ/vDMMh+v0+MdAdWyPl9AniHxRghPHC?=
 =?us-ascii?Q?pdzRZLpQ435BpfDRtwqCGS0jmNttlXgNbdieDElv5xebtthsh2R6NGXBUHDi?=
 =?us-ascii?Q?8aFkscnv1Zhjat5O5nmDH4cQDBEP4sNT5AtXIiYYeueGD6oOH67BbTA++Foi?=
 =?us-ascii?Q?dac2ahldxIwxok34SNH0yPpWuP2pHvelX2bRkV5+OhnPbak17YQoCWZxTY+b?=
 =?us-ascii?Q?lW6YCAGxnpWXm3vxg+RBjdG45rhDArqYtuCH6wz6DxP/+ZnCLV+SgbUTnt8A?=
 =?us-ascii?Q?sEUte5yrAX/xfxBxJsiO9QZ3VM/aez0PpkY6RBvdsZWxdCRLeMqnArFi1rw4?=
 =?us-ascii?Q?IhQgeiugwt/mcoJgj91qOuEd4XywqMzzHEcau//8cQnA/TUnsXwh80I0tY/Q?=
 =?us-ascii?Q?gRRTd4y00wpoTqn7V7DZOBq43Vmbu2qs+Y8Hde1f5SXiNoy+/X/Ssl9vVRCN?=
 =?us-ascii?Q?nSqpG43gaOLPFu9bAvbWbzsJzTgx9eVHU0akdE8OwnvRl6dRLLoL/DyD5pW2?=
 =?us-ascii?Q?Ef0zYe5SKemDfufZnpmvgsLVaI6h0JyGnSPABlGbFeqXiaGkOU0cKxwcAyXM?=
 =?us-ascii?Q?Rw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <753DD62046C9404B9AA068277B647489@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DtCjcL7gcGLjdW+0loOuon/kpib4cbCEOtQFDJA4JI9gTO4GLq1m3a2+1XO1XqOFHq07Sq2zkCmGX4N/ljyc+sgxfpEL34UPSaKL7zKcacwIUXnt06Vc7wF/YjfGo9JybRPJyUOyWpK9aNB2LQYUKlMGkM8g4pISUZVdtejgR50+ZZ9ddrsfhVfEUArAmD6iX3CNZZRYwihjuIDDIyXXZrxdZy7Uoiy9rwa2RZoxdfEHFdCDQeY1dMm8CA2xq5LHboz/Pq3HvWjDsAnEptSWf7nbCyW6puj6GlrfFJBpxXj7mz+9u5B1TlvmpdSwzF5N9Jjv0MC7e8COU+DH/TgEkommC6TkwZzQ9vYQvaBcC/MxF/BdvuNXw/MVyz6cEHxc3M6QNHdC6pnNxwr9m3Hiz9YnNBf3XH2tz4i95DieB4F5QEeeeMEEe3vuZLuYelAXOcdCmcmdlrdivWYMzk6FkapjJO3L7RE7PYwOGNq4ndqM+OJOZR2swAFQEIfZiJPxV0O9D03SYCCnQwlzS2aZgyPsW0NjfnhjTOyRozAfNWJKv1zgGESZe5sMVa8qNDRmboYraK0X7auMOXFqzuhr4usmHVd6i8710+KdyM1qqEukKs7luPEQsZxH6XNw3EGzlRUZnE+IvsJ5sIHfigDOvcepgl1e6+tCF+uW8Za+PTOJ6qdL3wXuxyd7goL0xHr9h5lmTehgaRlu6ggvkFcXZQPjULQ11MgjPLUSgVPHWqKxX2ua6m2SO7kHVxBNFrnPrs53eCb/b8cD0ZnBugmDwu1yMK18rjgc6M0vUHXMbBngU3A0Qib+grdmQHkfuFVrD13eaRlnifxoLpQa1PW6Lg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81782e0-92e4-4cc2-4402-08db8c0df2a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 06:19:33.6697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACSAbB7bzD/vDtZ3TxSCbRMU9xcF1pjjD7wmiiU6+U0Ry9J03bOUXE9rZwdgdK4mbxgQOfhPtFH3hCapVEELjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8386
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 24, 2023 at 12:55:30PM +0800, Zorro Lang wrote:
> On Mon, Jul 24, 2023 at 11:04:23AM +0800, Qu Wenruo wrote:
> > The test case itself is utilizing RAID5/6, which is not yet supported o=
n
> > zoned device.
> >=20
> > In the future we would use raid-stripe-tree (RST) feature, but for now
> > just reject zoned devices completely.
> >=20
> > And since we're here, also update the _fixed_by_kernel_commit lines, as
> > the proper fix is already merged upstream.
> >=20
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
>=20
> Oh, good, you've sent this patch, ignore my reply to last patch.
> Looks good to me.
>=20
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Thank you. I didn't notice the patch had been merged.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

>=20
> Thanks,
> Zorro
>=20
> >  tests/btrfs/294 | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tests/btrfs/294 b/tests/btrfs/294
> > index 61ce7d97..d7d13646 100755
> > --- a/tests/btrfs/294
> > +++ b/tests/btrfs/294
> > @@ -16,11 +16,15 @@ _begin_fstest auto raid volume
> > =20
> >  # Modify as appropriate.
> >  _supported_fs btrfs
> > +
> > +# No zoned support for RAID56 yet.
> > +_require_non_zoned_device "${SCRATCH_DEV}"
> > +
> >  _require_scratch_dev_pool 8
> >  _fixed_by_kernel_commit a7299a18a179 \
> >  	"btrfs: fix u32 overflows when left shifting @stripe_nr"
> > -_fixed_by_kernel_commit xxxxxxxxxxxx \
> > -	"btrfs: use a dedicated helper to convert stripe_nr to offset"
> > +_fixed_by_kernel_commit cb091225a538 \
> > +	"btrfs: fix remaining u32 overflows when left shifting stripe_nr"
> > =20
> >  _scratch_dev_pool_get 8
> > =20
> > --=20
> > 2.41.0
> >=20
> =

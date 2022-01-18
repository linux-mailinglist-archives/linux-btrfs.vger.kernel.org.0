Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD312491E92
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 05:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiAREln (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 23:41:43 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:44419 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiARElm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 23:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1642480902; x=1674016902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OHTWMfdXtGy7V5UN1qghKXn0O7uUDhxizBV43CAk5g8=;
  b=KabODWB6/bagfbkf7XPrRK+xvIDvY/ZbX1j2fb+hzbd9ASnyTsPYgudW
   HEspFUzQxmPmUd8eeqjX3BKHyXyDgEqZdWs9Imh90R1u55984DQA29b73
   5HweRvJtJD7vo47fueVMuiU4kBdkojruBSLiJ1dfmWkmghExzGZ5z9JYn
   kjZUWsrkaJgBYSjQ9FnwnOlrGFoIKRlDVeVB0EJoORm33ete7noTkeQEK
   MVtNB1GCq0uPoypiIm3brR1bisfGnU/mOkF+Ybaqt9q4XWNQL0BpEeD9K
   E8wQ5RqMSu8+barWBuOydi30lwS3lx/xy1k02Z4GAB2vR92vQGWfG7EXN
   g==;
X-IronPort-AV: E=Sophos;i="5.88,296,1635177600"; 
   d="scan'208";a="302571689"
Received: from mail-dm6nam08lp2047.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.47])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2022 12:41:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/asTnPi6DhzXPh5MnQOowZjvgvDzsel5W/9KYnX7UYk8f79srB6EVgRQn7gsXRYxJEBm/nQ+3/S9U1tO0vSA5Qo5MkTmr9QAMsPKaOZ+aQT1WLoKxIOsyBPRs/qi0jDsnF97ckTYIY3SbtmR2BKH7I7+me5gM+1GIbQWl4D4q9f3MIh2VjM+rx1L30/wQTN6z6bqJ2L2KVFtqqk7Wdp0tDw0In7FFQsuoPf9S1graWMAYqIepXAy/Up4h/08EN8wW3uZDw92/Q8/c0gIyE4J+N/g8YtdgPkOjguB7znmqfGG3ZQE+lsEkuLc9pP0c2+SokvlTPoXCau9e4yQSTbXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxZL7Bx76XIYfd2jk/RJhnHtxpb/zsbhofybMn4gxiQ=;
 b=AGhdHkUaYL9WqVyMG8dhQPiSd099/FJeulY7BrJaLv6cqZQsvWFe9iY2fd0ZXhEvmG/Gv1QeC33YPjcake2sKt0vej/amvX//frz8ZSuc0rK6b1ojazDHiYFoZgG96SgWRv47ALAg5AI/HadinlDe+Ir/Aq7vv7rQLcOoA0Sgg5XTXCgZ9LWtp7n5GfzJHPsrjGBOO23Jvck2tVxlFmtGaeErnGXD/+j+EQjc0jxDjVErJGLsyALoNAGExwbrpcvMMwyRePQ2rUyUK1g6bms17EPx7wHUJWErlLl8lm8CGucDp4gH0hAQe9jLWVIP5G1VPOjyzrLfT9WXUxfRBHQxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxZL7Bx76XIYfd2jk/RJhnHtxpb/zsbhofybMn4gxiQ=;
 b=YaDapwr5OltZoXENn6IMLSiCjq29RWIqN35Whbn7EpkET40wDF8nCYlWIcwgh0i97WJtBmLjJRD2nhWhnnFN0ck9yY3OZQg2KB3VzEZbB2oLDHetr2E547ap5XT+k4wh/zOegMKKUzrTcCQS7wGYeZ4kK+eXxcOTmTc4OJNS+/s=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7472.namprd04.prod.outlook.com (2603:10b6:a03:294::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 04:41:37 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f908:8d4e:89be:32cd]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f908:8d4e:89be:32cd%7]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 04:41:37 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] btrfs/255: add test for quota disable in parallel with
 balance
Thread-Topic: [PATCH] btrfs/255: add test for quota disable in parallel with
 balance
Thread-Index: AQHYCz0qWOQ0vGk3ZkWwy4Gt62uqQ6xncyKAgADBvQA=
Date:   Tue, 18 Jan 2022 04:41:37 +0000
Message-ID: <20220118044136.vlud4jkq6u4bql6q@shindev>
References: <20220117005705.956931-1-shinichiro.kawasaki@wdc.com>
 <YeWie0i4ltdLPkdf@debian9.Home>
In-Reply-To: <YeWie0i4ltdLPkdf@debian9.Home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28264d10-66b7-4aae-576f-08d9da3ccff4
x-ms-traffictypediagnostic: SJ0PR04MB7472:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB747206F4433FB4D8746C40B1ED589@SJ0PR04MB7472.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J/PZDubbfE8PwuKlaHPYux3FIPtr1ZR+LHqnvgpjuE8jEknBEU6qxKL4xsd4KNGltWX1zQRZOy6Jvrjjx40LdVSYbv52EzAAbDX1cUM6F2SXQGDpV7OBCWJ2xKyZ341pWfqpX7EVil/POqDcdf9HcJjAd07PU2hr0GDVvuvlE5PfqNHHUylHb4m9pSZ62xdJBM9eDQgVQD66eQtRQKsUufCkjZjowM6WXiyvsJn+LjahEh8zcC3GQ4Pri3Os8kC/OD+JrajI9SxiiikSXFSlE4PvR/Vhc8IeEKqO3hXIhDd2lpLmBpbPzzG7L/C6edwgnG3AeuVlo6reFUDKvFj9/m68ZO5/Dqlxff/UE7+Lhfoi83Huxxgs/WwL0MYfsT50G3asoS7/ML6d1ejSfjKNh3KMAPg3iIi6kDqg3+dreJcLckkJ1EwyQUoy5izpmePYv4qNRf7ZonCh48Ok3UamtRKRvSCxG/urm0prqp465mdgNjNHSZl1yCnpgsguL4lN88f2ggJ9p2oA3w8euGf6pluL7asNR/mon3GT5bN6AdVPUL2G6+OeloosbihaDg+ugg6/D+UtwkSDot+kyGfnBy6EQ1DxY3AXjsG/edNiMD67B63XSoZ9phgnwaKostjcSkB4QHat+pOg5g/+ne5/4DcRhPz3GAq+XID1S3s+uu2ygvQ5TWwR6aM210d/ZOLKtF6qakqFjoIO2r4JiDMWKIXGcRl6AUaQ8Avg8I490y88qwS1YN7wzbaVqAnIovAqUGUIrHf5vWIkJLDTO/Hxwd6vA8HJ31PGo/naAvWS/xQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(8676002)(6506007)(2906002)(66946007)(33716001)(54906003)(5660300002)(44832011)(508600001)(186003)(86362001)(122000001)(316002)(82960400001)(38100700002)(71200400001)(76116006)(83380400001)(66476007)(8936002)(91956017)(66446008)(1076003)(66556008)(64756008)(6512007)(9686003)(6486002)(6916009)(4326008)(966005)(38070700005)(26005)(15650500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?080ix/N2aDFPOG/mCYYMscVEIkcBzqSn/hV6T0OhW7/7ZPEggM8XEZKBHwIS?=
 =?us-ascii?Q?my/90Tx358eFnK+4VI8PTsF2vLSAjZcrx9EO4/TiUwyv7wHyxSD300LqOtGF?=
 =?us-ascii?Q?cPK79a/44jdT+VeM0OozayJZzjgNXr3dS9alMfJtV7rUMQEBBlDCQcOj2hGQ?=
 =?us-ascii?Q?ql67be357+Uun67LJdAWKa//vo8In/tVmKFslUWhiY2+kc1Mc56kDdxMUCAh?=
 =?us-ascii?Q?mJgHNZ1t9k0+ctOBRhMD+KQJvAC0x1Flx3G7KUNLIuEQYAiOSCX+rh+xLd5f?=
 =?us-ascii?Q?AWVA6i27JSHWz8bTRvFyVp9+BCXqoivYVlCos627A9IJRUZSnmR7qTQf4l9f?=
 =?us-ascii?Q?lV3c7qhumliM8WitP4jtVR7huruBbUKuEWHW+t2xFQXyOlLiVf3K7GvI4xFF?=
 =?us-ascii?Q?BO4jREGuMI0Yc8GYcJ0e1FHx3kdGeNwpypvolI3VFbakd087zUZ8IKaGJ0YL?=
 =?us-ascii?Q?/8flfIJKOp1Zh0VWFcsyj3a6drphxv/FjJYf0yQroqxC1/jLE2vu4ONQyVul?=
 =?us-ascii?Q?zgmPZTjXoUzy01YwQkZMDC2AioUVs0JZm3904dbAKJxwTDjFtapSRUZHF5J3?=
 =?us-ascii?Q?ReThCecRx4iBkmZ/B800974SVBv6ibGax0NcE4qSvcu4z67TZfxYIrsF3+WI?=
 =?us-ascii?Q?PZ949dxjYguRBJK+uRhIoMc8XEHaM5ZX7KelRLRKMl+vtX8AvlZJim4BBXeb?=
 =?us-ascii?Q?jS0ASUibiggprwDf72DCtyXZrji7vGACtXeu7Cy22H1XLGnhLtM/D6vznczN?=
 =?us-ascii?Q?IbO3HxHm8qEt+BxWXF1PK6VNHly3Mf7kKB+2qyF/tz5r1rEkXfXiiVjfaKsq?=
 =?us-ascii?Q?RUi9iyKVT3n8HGBlDt5jI8TvET/CDH6ipPG3XQz2a6HNN/GVK7Gp6EICDvY2?=
 =?us-ascii?Q?1EE+3hDNxWR0m3ccHvb3AO9yr3dAd1fbaS13ZxVhCanOXKJVta5KAkes0H3s?=
 =?us-ascii?Q?5UrcTZ8IQ4Xa8m0MO7771M9N9GZju0sbjIawlBrmgG3pLOKnT6k5PXX3Td1c?=
 =?us-ascii?Q?SXfVvigUfjb1OhiXYoMwAwOp7U/wgd9T6jZ4Tnen13XHUs2Z7JbNsAkqUaTM?=
 =?us-ascii?Q?RJUPZScRHNgCYVNr0dWnpXvbrjiPGTr/m4fZSF98NfrlpHF24jFE0r/4suKt?=
 =?us-ascii?Q?uR5Vkjk1acrPmQWT3fZbAOYEU3dcK8R9gmfPDFP16rRKMDldMfgMpnJdKJdT?=
 =?us-ascii?Q?cyBQWuYNERDU3wk0rKowESEAKnRagbriujcwbdGXmRIID2lTrqeL8obxkeNC?=
 =?us-ascii?Q?oDqR26xR3ZmsPu8pkRb2o8I8O50pSiJCamkBVKOsW353XIl+Cu/YzaRhlXEF?=
 =?us-ascii?Q?ZGnLLIs/FRvibyG8qlhZFZKtUYUWPrMsxWrcdhCqIvT1VUomQNQY1G74a3fu?=
 =?us-ascii?Q?VRgExyiXyKK1tu/saBdZxvzToBZ6Ip8DA737+zz+HqUt6J1icDf7RuJiIPBW?=
 =?us-ascii?Q?HRGpSkMptn3ZcH8L4aNPJJpN9YIDoqmtNWxjT9HkuYQAsE1R44GmRuxJ012n?=
 =?us-ascii?Q?uIRWu2Lw1Sof2NKq09D+pLKFepPoJwBRbP68g32i4C2Bd7JiqoT+v2kbNov2?=
 =?us-ascii?Q?5AWpPF7EbXqCs+nmrCsgDW9nPnbp0eHMemgzLtnv4X2nBFnJ/lge+sTImOb1?=
 =?us-ascii?Q?FyW3nR78LQK5l72wfVUjyV/KzldXcTixguM8au9kch5TYHVwDXK+eDQA5Xzx?=
 =?us-ascii?Q?RU/vMRV82Esp+8US6+bFG7KahkY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7FF0C3B77DD2145A85D89455E699267@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28264d10-66b7-4aae-576f-08d9da3ccff4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 04:41:37.0645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+SZYVCRb27nyKbs3eGXGNQ6WVu7T+PdseRptugIQ4z6vmsAYvSaP/ogpJLdSPQTfPujhRawV9Kv4OGx1Eo3TSTj24/D6Swcqnz9Q0Xwods=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7472
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Filipe, thank you for your review.

On Jan 17, 2022 / 17:08, Filipe Manana wrote:
> On Mon, Jan 17, 2022 at 09:57:05AM +0900, Shin'ichiro Kawasaki wrote:
> > Test quota disable during btrfs balance and confirm it does not cause
> > kernel hang. This is a regression test for the problem reported to
> > linux-btrfs list [1]. The hang was recreated using the test case and
> > memory backed null_blk device with 5GB size as the scratch device.
> >=20
> > [1] https://lore.kernel.org/linux-btrfs/20220115053012.941761-1-shinich=
iro.kawasaki@wdc.com/
> >=20
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >  tests/btrfs/255     | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/255.out |  2 ++
> >  2 files changed, 44 insertions(+)
> >  create mode 100755 tests/btrfs/255
> >  create mode 100644 tests/btrfs/255.out
> >=20
> > diff --git a/tests/btrfs/255 b/tests/btrfs/255
> > new file mode 100755
> > index 00000000..16b682ca
> > --- /dev/null
> > +++ b/tests/btrfs/255
> > @@ -0,0 +1,42 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 Western Digital Corporation or its affiliates.
> > +#
> > +# FS QA Test No. btrfs/255
> > +#
> > +# Confirm that disabling quota during balance does not hang
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto qgroup
>=20
> Should have "balance" as well.

Yes, will add it.

>=20
> > +
> > +# real QA test starts here
> > +_supported_fs btrfs
> > +_require_scratch
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1
> > +_scratch_mount
> > +
> > +# Fill 40% of the device or 2GB
> > +fill_percent=3D40
> > +max_fillsize=3D$((2*1024*1024*1024))
>=20
> If the test requires some minimum size, than it should call
>=20
>    _require_scratch_size <size in KB>

This test case does not have its specific minimum size requirement. The han=
g
was observed even with a device which has btrfs minimum size 109MB.

>=20
> Also please make it a bit more readable by adding a single space before
> and after each *, i.e. 2 * 1024 * 1024 ... instead of 2*1024*1024.
>=20
> > +
> > +devsize=3D$(($(_get_device_size $SCRATCH_DEV) * 512))
> > +fillsize=3D$((devsize * fill_percent / 100))
> > +((fillsize > max_fillsize)) && fillsize=3D$max_fillsize
> > +
> > +fs=3D$((4096*1024))
>=20
> Same here.
>=20
> > +for ((i=3D0; i * fs < fillsize; i++)); do
>=20
> And here (i =3D 0 vs i=3D0).

Will reflect the comments above.

>=20
> > +	dd if=3D/dev/zero of=3D$SCRATCH_MNT/file.$i bs=3D$fs count=3D1 \
> > +	   >> $seqres.full 2>&1
> > +done
> > +echo 3 > /proc/sys/vm/drop_caches
>=20
> Why the drop_caches? Please add a comment explaining why it is needed.

I've noticed that this drop cache is not required. I referred btrfs/115 for
quota enable/disable test which has the drop_cache, and added it to this ne=
w
test case without clear reason. The hang can be recreated without this
drop_cache. Will remove it.

>=20
> > +
> > +# Run btrfs balance and quota enable/disable in parallel
> > +_run_btrfs_balance_start $SCRATCH_MNT >> $seqres.full &
> > +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> > +$BTRFS_UTIL_PROG quota disable $SCRATCH_MNT
>=20
> This seems very timing sensitive.
> It would be a better stress test if we do the enable/disable in a loop,
> say 10 or 20 iterations, while another process keeps running balance in
> parallel and then is killed after the main process finishes the loop of
> enable/disable quotas.

Thanks. Will implement this idea to v2.

--=20
Best Regards,
Shin'ichiro Kawasaki=

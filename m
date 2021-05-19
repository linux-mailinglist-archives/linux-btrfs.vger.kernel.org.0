Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CA63892B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 17:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354906AbhESPeO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 11:34:14 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:3788 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbhESPeL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 11:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621438372; x=1652974372;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CAEknvok+TLa8icnCwYEpOZeG+afHrAgzmK+t6Jqcaw=;
  b=RN2P/bm+btvmq/hpQk4si/p1Eo/le/tNRv9Xr3DwpDcZohty8rbVfBHx
   TMgWi/APIrRfajTk1sItXR61A2Sh3Oxrxf58q17no4kX5zXUxzELgyJ7r
   6AoI+MP5bNkp/LxvzeKKfnWPaXnE8FbE24PNxMbU3YgdFqOv9weq3gMO/
   le6Hd51mALS4XGNRmiCF/jV5epS5CEA9it3xInavcYGfF5jBaOnV+0yKH
   mNANoxrAuzyVDfuq8tIA9HvqqkS8//zpezj4U8byrC+Cx0JxigYlDu1UV
   xpouHgAZgJ4TFTgkd56ZcswzZkOnRGAW6vz2eOlOG3zR7XUiU57qFx+7F
   Q==;
IronPort-SDR: Dgf57Tk5nGEs5trmBctXlAPvNzF3FFKSDBhZXrPIXnOq132dKDtNHG+dr5qFAaTwTVxUsn41SE
 N+0F7jAs8Hkt5fyISRXbO2JusohlXeju3J7I6Ad+RF8uefPwuv4j4taJQY7hOaOdYIhUJWToFC
 FI7bu2/geRzfRd/RGtFy7QhWloOuHHxtH9vcyMC1AL+/5tHcd/m+Kx3i4T79LFm9ZMuBDYRhcu
 zqOpzH2BkCcMMtJIftp6htaZcwEd470vVi9zK3VczyIgMzfLdrmELOx2T0XpXlVf5Wp9nXQPP8
 gVg=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="169266481"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 23:32:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/+SV+BwSZLe2a4k8cidGfx3mNEBBAuqK2uTrduIVjw6APro3kzELUCeLJDetZVAfAMDFkv7W3Zj9woAjHV2sjQCpLQe2CG2fIlv0cJ3lhJ9ndsi3KNCnmIPbicf5DK0jDvYfsSAxPai7R2aosrwx8KSwlJydBNqw6iBYIvIek7+GjjmjIoyhR1Mkyt+WCc9Zt3uFRTEtVvzTNe2WdKWYmo+ZzfQKQMAN4xC2msBlP6EuKvfLoo4T1TZH3PxSMCwJfw1BLUwa0QNjDeXEb1k+khnj+GC9aVh4jFAmeWGqyEStuBcV/eVp62dd1dtLuf8YpTc66fizu4PgV4V/QW5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAEknvok+TLa8icnCwYEpOZeG+afHrAgzmK+t6Jqcaw=;
 b=BV0OtOusX98O6lJwCFHwTOrgul5lGq81f9SxAzdsxwyXJPZZnPaTWNICm7a2aBQ3tFPd/0e0jhiTfns5XJ9A1bIL9QQhJMC5MTKs+rlD0VPowuZjQgz6/2AeH/jGQZYiMiSCjWBp2j6zdvbGP5GwwE8cUQpjyzriaul0+mfpAarcgM+Ii/C7Jc2l/V4laFh9c8xu7mdOZya1Zp6RCH99roRj2IcaOKw7OAou578tcwPHFh8glzcsgWrr/t7G8vNWxUgziQ6FEAB/wnBUbxJgBVOSWOUhdb3xvgqMMdE+nGBWoUu9uiMrwRqP8cC2BKUFJpk/tjUs3iTKxvDINawaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAEknvok+TLa8icnCwYEpOZeG+afHrAgzmK+t6Jqcaw=;
 b=tPTh+4VYMuG6fTWWTJUr4ciiIAWluao16Dvn9xfPBPImtTNBQ8qZZqeoGDgCZm+ojtYYvFvJByvk0imn/kkHdZanXRDg6c13b381cuVXm5ZMgxJSY82e1jTiD7eD70R/ekFvYOnOP27WsFSYxuCwISQY7wYTevTy5D0EdtbP980=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7301.namprd04.prod.outlook.com (2603:10b6:510:c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 15:32:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 15:32:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
Thread-Topic: [PATCH] btrfs: scrub: per-device bandwidth control
Thread-Index: AQHXS/Vlei4t9RXqlEKyfFBHrG12jw==
Date:   Wed, 19 May 2021 15:32:48 +0000
Message-ID: <PH0PR04MB74165244AB3C1AC48DF8DF379B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210518144935.15835-1-dsterba@suse.com>
 <PH0PR04MB741663051770A577220C0C539B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210519142612.GW7604@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:95b:718f:422f:1ec2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bd29082-b158-4086-a98c-08d91adb5bea
x-ms-traffictypediagnostic: PH0PR04MB7301:
x-microsoft-antispam-prvs: <PH0PR04MB7301C90DEF14FF3BD093A1689B2B9@PH0PR04MB7301.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JnlIn4Xxi/ACZX9C2yPD4luDZ8qN1E6w6dHlKps1x+dbed74mvf0KY0OrPTWCjv92BMfArBkY/MGHrg4yMwk9PuPlqk/V9O2JfzBCHyF6g6+mp7FjC19ghUa5xSqa4aA2JvG5/7Kws1Vk6d8c2LBJ7QY3H/xCcxJqc3V0qsLPurdpIpfeC5Cb+iYz8XExCRcLJZYby+QA1a0OzaGfGFo5Vl271hpJ8hyMJQo8gnCKbi7EcmKRElB0IigKWTfMK5MJTFb8/puTxy+PBTaFxTIHpfVRpN1IwyifB2QdHw6DkQqe0Jlp1J80qOzsF/V2iEmIwQHwqKKxxp/y+R9tiXhWeh1hZfmnpRm3jAOT8K059MSxbchag8rCQVjT/6Npu5LTN3vKOlZPcoFO5oH2HkgdS66hmwDGxjwhQrKqWYiF7QHiushKTFmgXODYx3g5z/poDZhu+w3MGsviRkeYowGbGnpYhRv+ppvLE/T7D4ECuuMhv0OoH0nsVesMBUAK4ojCXtPXWlXefM6GdwwrbJJq6UhOFjIClR0geqlKnLzqSLgSOGgd8C0QRlDJUv5V37QP+g1XzsmrSOrQ5jr582tiCT+BfgPNKhrOfY4rLi2yGM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(122000001)(53546011)(66446008)(64756008)(5660300002)(6506007)(66476007)(38100700002)(66946007)(66556008)(91956017)(76116006)(6916009)(4326008)(4744005)(54906003)(8936002)(316002)(86362001)(71200400001)(2906002)(55016002)(83380400001)(52536014)(9686003)(33656002)(478600001)(7696005)(186003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nRxqOdzYD2rZMqMBYYGebs+t9DO2PldfeS6q7nKwS6nA11eYfSDaB5yfeAXV?=
 =?us-ascii?Q?UAApXm6VJHbbHifmMVdFLWExaeFtl6SL8A7FMJ4+yJMgY5BkPAU4HVnY3FzG?=
 =?us-ascii?Q?9OYZ9NPgrsuAfyJ03r+46YTHSixEcJ8oaInEIor3qce9ApY4eQUuYGCkhd0p?=
 =?us-ascii?Q?zwj6RG4H+2Wg74lrWuqK9534w2p+Sf2RnZvtgy+fW5/DrRxZapqUg4FJmu2C?=
 =?us-ascii?Q?rzlaIQmit6QhNIOu1EzsEoT4It5zwZsgT4B0qvOgDSraHWsaFHxoVtANJBxu?=
 =?us-ascii?Q?11PuTcl473M7CJLtU9E0hdb6F9yyqJwSc8nVaIvBskKiAUN5Ds+FSYCvaAYw?=
 =?us-ascii?Q?ylr67boEvczFXhE4zATU3moGFZUUrbQZUCrDR7BVkcATG54Q0XHdpXmTy8dS?=
 =?us-ascii?Q?nDgWs840+SM0fgtEiVHUdHg0avuajNclDnzwoAy0GaxScE/rccbqybZcLyg7?=
 =?us-ascii?Q?GgTuWgfLqwB12SLtmnoMzQzBC0elSH5tDl1GJFHiXdxJwb2QZnb+ZzYUttFz?=
 =?us-ascii?Q?alRBcElfDYVrtDh3nGkdJHlnSK1wO3JkMZ97hy2BgCKVzbKMUAFqeAA5y4M1?=
 =?us-ascii?Q?xGJjiGiRMXmQDhx0tagfuphLon1+IoyxqWzbEtxS7y9wIKV91Ic3S9gmEyGr?=
 =?us-ascii?Q?Rg7MAODX79SkOu99wlUnycOc4+o1GDez9vQR8TdBEDnqN+iN2vD7I/V0mNuj?=
 =?us-ascii?Q?d7tQQD0hTF2PRzvafO+jGC/DNbV0YghOVOogCBlMZIDfHfDPRS+czeiAMzP4?=
 =?us-ascii?Q?ctRC6OV9LbJyB/k7QkuvStYN1VI9dOvi4JKJnUV5FykMLGt0qF8sujhJMjbO?=
 =?us-ascii?Q?joEAenU+9FHD3/fA/4u48jtd4KhFeLC9Rs9TCP3qcxBMIMmU1M7xHQm3d61X?=
 =?us-ascii?Q?kTn8BHTpFPSzKUwKMKa5bgtMfn3xJcvyXvC7Sn2P2Uw6fdC7U3lWmTnWVAlK?=
 =?us-ascii?Q?tURdjyTbMY3kzBjG4jGQ1gFOIJC9v40zuCuANTz0x0C5QqS4j9Wb2nV5T3UZ?=
 =?us-ascii?Q?nIDi7UD443vvgpIMjTH0EQnfESJFnTUcJtNGvBhF5NHkuDflKWmmUlmFpOAM?=
 =?us-ascii?Q?NTCtIEs5pyOGpNOYXRsUVpRadL3Q5KNaO0n86GrI1u8/+xR14qjt9GN1QdeZ?=
 =?us-ascii?Q?kOac8FWjsHxQ2MJumNXD7Z/sxtq0oIjLYJA+1OJ7dGmGWD/Zow9QNxa3Or3i?=
 =?us-ascii?Q?vea5NEiCXCdNUBjoJlo9izdsFGVGuoW1RXpTy+0grmMt4wKJeezadSy9SjrU?=
 =?us-ascii?Q?9z+cCHMTD5n69qGLlz7FqKNw0KzzhkNl/FdXTcEaTzRrbwEnbFrib/Xw5Lb4?=
 =?us-ascii?Q?8p1Y4SJcfPv1TGrn+6xlHSShuwc3uXbKcm7WlAvQWpxK4ek33+Xlu7WtgOYN?=
 =?us-ascii?Q?u4rgV/ayeGbof12Zrp9GFp6vsPvXXJvepaRCDZlieNYNJOQ9aw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd29082-b158-4086-a98c-08d91adb5bea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 15:32:48.9929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BU7mFt5gW/CWoXh2s72YisJzXWvfSYuU9i17VdGyKRfgoqA885aXloxjmTG6E7gxup+giN2LKaOPqcdfQYEKPo6WvyLFddKTe1MUetnnwD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7301
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/05/2021 16:28, David Sterba wrote:=0A=
> On Wed, May 19, 2021 at 06:53:54AM +0000, Johannes Thumshirn wrote:=0A=
>> On 18/05/2021 16:52, David Sterba wrote:=0A=
>> I wonder if this interface would make sense for limiting balance=0A=
>> bandwidth as well?=0A=
> =0A=
> Balance is not contained to one device, so this makes the scrub case=0A=
> easy. For balance there are data and metadata involved, both read and=0A=
> write accross several threads so this is really something that the=0A=
> cgroups io controler is supposed to do.=0A=
> =0A=
=0A=
For a user initiated balance a cgroups io controller would work well, yes.=
=0A=
But for having a QoS mechanism to decide when it's a good time to rebalance=
=0A=
one or more block groups, i.e. with a zoned file system or when we switch=
=0A=
to auto-balance in the future I'm not sure if cgroups would help us much=0A=
in this case.=0A=
=0A=
But this can be my lack of knowledge as well.=0A=

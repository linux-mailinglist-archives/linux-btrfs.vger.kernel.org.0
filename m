Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0D17A172B
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Sep 2023 09:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjIOHVV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Sep 2023 03:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjIOHVU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Sep 2023 03:21:20 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FD610E6;
        Fri, 15 Sep 2023 00:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694762475; x=1726298475;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5i7u3AtOK3SPNqKV3OIVtWcWzY2V6slm1traqya7Pns=;
  b=THAC47WsQCJ59IxSoG6qd2rArZ/UeIDje2LjoWR5Fq650HjtmyUk0l/a
   mN+PFpG/PGEYMRnlmuixIbh5RDaf5lrFx9I8+Ml4QS2aUXfIC8+hPkkM2
   ks9Kjt9fBRiSNPJhgQRqy65HqO9Jf5cZRceMAc7P1RtZD1ls7NFs2SNHn
   I2upGNqlipPL7SEvLx9rNpb02JMiRQX1B0yj8kNPQO3LsBWrHKSopcrkk
   So/6juwBjShEIHKOpVbM2D5F8L9gQ0tvAPcINAkyNDK/G1GhHfm7W8Ir0
   tMXs+Ry2B1CuBe9HAB866waEeBN44PqBo7YNyx3m750YA8h85rXRiFHDJ
   w==;
X-CSE-ConnectionGUID: +VFeqynhQji1tQ340RbigA==
X-CSE-MsgGUID: P8j11m0oSE+QtAerRWah3g==
X-IronPort-AV: E=Sophos;i="6.02,148,1688400000"; 
   d="scan'208";a="349344129"
Received: from mail-dm3nam02lp2043.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.43])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 15:21:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bo02W1iA8UB3/paT4x7fsyW3JwQofsby9ro06c6PazeOKPtoYhpRlJgVGzy0Wu9oWU6WgYhLrBNwWlB1p1IKRcR2O0c9Oi1Z7zsogk2wauzKYRxksOrqoYFHzH8Dca41iSbqvHLevXIGuXWnhORG/CZVYyD/kdemkd15CkeQ/9Ndz+bbqJYY+imAxwfFkGToN6a4f2cz5tl2EqnFpJ3DCJABfxG210wynva866sAL+oup1hmbObh34imUna9ZgnQgzkQv8r7wgpLJBd00aOmVzwJgk5H/CXiOE35jsqVgpIfinz4zOLVroirSiCewwn2eW4XYETMtvesEEawMoFHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oydsMiotRx8i5kxMUsjaQ5DSRCu+rMpDtxSk0aZRWeQ=;
 b=JPF61OxCS/bQ1xRMqkgMud6lDe4bA8EMIxLqtktdEBxkGOQTQIpX1z6r7I1Lk5iXNk+i8uKYKfbxf7Ql+s/7WLso4PabAMfmJX1q3dwM5r2NOVFBO1xuijWy8iFYquKn5mXI6VeiEPIrg98nYVtEa3wOptCNW1+WouzPZiosnIl9FGzPfKvzbvRkiPu5Tzh1NziePPDeE6MNn+1cEw8vCvpqg1spT9IuMGEN3Fuswt4NC1LbVYvpJk5BbuVr4bCKEmRqFsGQ2dZq4l8O+frxp2SgmNfOMFXZpfMZeHDPXhEjbieVF61OZuSoGk5uwJv7pPWUzQnXYF59/fBpmYRBCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oydsMiotRx8i5kxMUsjaQ5DSRCu+rMpDtxSk0aZRWeQ=;
 b=VHEVEMlqLt/7r7/Pxk2lAR7HBX7rhf0jUEjnqMG9jt5mTF7ru3WI+4zx8GIcgaezPaNiswpvzva6+TkudzIOppbwMjkV8llg9YLzyS+lA16bFYQYYmIqJtFlGjynovqOMYSeTvBQuPec0mVfDQinvRdOQY0kAQ1OlCTAwnqtiJk=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7213.namprd04.prod.outlook.com (2603:10b6:a03:291::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.8; Fri, 15 Sep
 2023 07:21:13 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::a62d:8dbc:ce77:8809]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::a62d:8dbc:ce77:8809%6]) with mapi id 15.20.6792.019; Fri, 15 Sep 2023
 07:21:12 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] btrfs/072:
Thread-Topic: [PATCH 0/2] btrfs/072:
Thread-Index: AQHZ56ICM8pgXXE8LEC5oQ0F5/WthLAbeyQA
Date:   Fri, 15 Sep 2023 07:21:12 +0000
Message-ID: <jgscnhsbs5f6bpvn2j6vbpvvkioa33ffyihp4o6nkb7e7yug7b@pmbl2igecj2f>
References: <cover.1694760780.git.naohiro.aota@wdc.com>
In-Reply-To: <cover.1694760780.git.naohiro.aota@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB7213:EE_
x-ms-office365-filtering-correlation-id: 2996bebf-b065-4be8-74ba-08dbb5bc5765
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EII0w1Z/VhPG0/ai6HQ0EBTD4tVYwOcKnH5czEcEB7fv+2g9m7sOMKszpXNJ4yZAyZ77Pj7KBGC59yhV0TjHVPK+l6I2xt3B24bv4NHIUtT0lcxMZ9bqD8fEy3711h5IExsmLC/9ursKCh2AiCrclv7ejJGKupFD0ibaX2LOOU6VXt/Vc1PQTlpitkl35+7pMIJKjjN/9mcD2PusEqrxQ18OoUUm9CAdCLGmLZsWOnXQt96PyhUTW3hRkqVcO5iwJMRw7JKXRGiDIubyCWqwEkBVuVVwzTZm3lKr8wqGalQ+DO1lLSMLPSljYnU1o8I9eA/jcIHw9kj3Biy7dvkeIvgJ2jC6M7VNEFlP6cCE59sHCuJNmQEBN6rde5J8Iq4Pd79QtwZuCDLae2Kb0bSenKI4miVl0D0P/JSWVQzxl8Wgho/yApgOCP4dXmYDIyU+dnsfcpS9m2kGGkMdxAF0ari3JQ4yugTNG/NrZOcoSBB+5CgPROgpf8R650KjrNhuLm8bq6LLgE1owN7ueOH0+/ZfnElHe7lf++tDHIClq+tJjs4pCtKtjAeGOciwjf8hjqj8LnkGWoNajePHKNMyEnO12HI50Arz9HGkEvvpv1mvrShL+KlcjB9V4efk1eoV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(136003)(376002)(39860400002)(346002)(1800799009)(186009)(451199024)(71200400001)(6486002)(6506007)(122000001)(82960400001)(38070700005)(86362001)(38100700002)(26005)(2906002)(4744005)(6512007)(9686003)(478600001)(83380400001)(6916009)(4326008)(5660300002)(91956017)(450100002)(8676002)(41300700001)(8936002)(33716001)(66446008)(66946007)(316002)(66556008)(76116006)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YsarU83B8246QCmSyMNMo1VZk1AjfdZQQ6qAsbH7IbbXuOCyMW/3mXQQT73+?=
 =?us-ascii?Q?s3+oJRuIENePIRnLhfkgrBcKtNIPXWyx9hXDR9RSfUf72NA9Tma+8pm8RLcr?=
 =?us-ascii?Q?LiAnucf48sqYricDidWH9S+GvB17K+LTS3jxFAEypfGX1huurroNhGu6bGXq?=
 =?us-ascii?Q?kyO+OMo04Gp61z9YdIR4S+Jdq5raqjq4Nhoxaetfg8SOEVbwQ7n6vs/ktgsi?=
 =?us-ascii?Q?9E9W3VkY9/P93dHrQYWArMdTjVUCkxfWqat7f+kDKRCIFWLdr+XgG9a3+94R?=
 =?us-ascii?Q?XxfV0jcfFFadUzBTytftvXrFfAx7dZ4krKOJZvKAXW5qD4ei7pL0KciVMsUi?=
 =?us-ascii?Q?LTNGsPR3yDcLbXg56ceL+5Pz2gkZJ7iU18L1N1dExp45mActU+EievtNmtuK?=
 =?us-ascii?Q?Ye/fj/Yzh/kEh6FbRYiK4vj4lAPY4NW+y0kxiwfeTccijJaJ5nRl8bNb1BAC?=
 =?us-ascii?Q?Vg3w+jr3CrLIhuQMS5QAnV+yyrt1gZXwCppHMfI1tc7F5C3PeJkfrA8v/8ah?=
 =?us-ascii?Q?7TC+AEJ/5P5Vu/39tSZuCAPKzxx+8snSh9pYzTFLK973PCTG2mlN6yltu2EO?=
 =?us-ascii?Q?CgjQsy5qPz13ffwhMNvlwtaWxepf50HfNmJas+niZ4LkT1ok1HiHn+3iEIl3?=
 =?us-ascii?Q?jOpNRLQKcCcn2MEgl8OQu+odTT11cBZJCQtFGuK6ZXY0pipYwC/H1mhquWEN?=
 =?us-ascii?Q?LgX6/BdXGJfRzBIj1sO36kYx919M+TtqSAYvGxLciPwx9ZjSDSpJ814+BZPn?=
 =?us-ascii?Q?PhARDI3Hm2w7VG3Tz/1SDHe3pM9YshcAyrPtDR8Lp8OtHKBp0DyVBpIcJQM6?=
 =?us-ascii?Q?Dmgt5bd2hviu6w1BzmCaxYR5ThzYYSXVcDoROOj9/1zDzO4evqQiGL4mum8d?=
 =?us-ascii?Q?exc2jlY2iYmdCkkxsXTsVJKWMSU2kksLNx2E8n1g795mjoZkPd/gDmydbZ/i?=
 =?us-ascii?Q?7cpWQ2BYW9x1irGTeNnBSAzOnRt5vNAUxg9fwtr3twL21ItkpVGZZR352YqO?=
 =?us-ascii?Q?CBOxuxkJQzQB0r7UGxRKMgku6nY7T8v/m49WlsSo5kReTRFsE+UWIwCJ8Cz0?=
 =?us-ascii?Q?pA0BxnQq7JbyKOUtGaf/9vrITJySrFN/oMeC47/72pwhMJQPb4caEyfxxcQB?=
 =?us-ascii?Q?m5pEo5zwzX8EsVQbLJMxMpJICeSAHHIcpLCzOXgmQpft1lNwRZ8+ub9kvy3X?=
 =?us-ascii?Q?6fbZRQfc3GLS+K2z3XJQDi7nguD8vvjH3+jq04I1cjFePYH5l7FS5Bu45G6d?=
 =?us-ascii?Q?Clw0jIbqgonb3qvG83XUjs3FqNvYHytI/hiwuDhZDDfbLvwcFPt9VO2LbG0v?=
 =?us-ascii?Q?g4UWaBjOqfJWUFWSCmnwhzWbXx+YGBbCeTqxPLFXUkinVEbe3deDUmJp1z1M?=
 =?us-ascii?Q?ySHH+MzQuoAuKzXPdq79hF0nBk99Cg4eZ9TnGkPgylLuKwH+KTE99JWpQ0MC?=
 =?us-ascii?Q?zIiCcI9vZb3vDSRCTq3LOrbDUaMFtl0DVbpTjyq38+2Tut+MLDuYS/BleuWN?=
 =?us-ascii?Q?w3Oj9/07zJ3f7tttpJA+rPZxYpTiG2d0Z4/3QAH7gpLxJczzSNb6JrvgtWuB?=
 =?us-ascii?Q?HfnJV9xveA7fsmmm+uyx084uL9rcKBG4icHOvKUJzosJS+zwFcrKRbRADTMN?=
 =?us-ascii?Q?6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EE40B2927B45C24B93B85FC19EB08A4C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fhd3C6kuN66UdoUV2iYKbh1nTQymkeLDtrTTo9EoC/s0qfoAKTGBE/9+kWkiW2ygWovt2x1Ew1CaqMmnSAltZ/GJDMaV3dtJYjaOncZhDZ7POivtmfIVx9ZCOS7NmRRVlrr0Z1pCHkGuA2kgk6tEW9ukRUymqBLHtOHuBEy4Jfhm7tHjWf6bqhmOsGQlHImvEMa+mkmYvANBoStb2tZQt0ADePacWr10/OnJMBQdV1Z4fg/Q015ENYa+tBuxFbfn0jKt5tYw+zNJsX/d5PaINmm6gDqJejvgLzUgKHLHQEibp2Yna1BYdigupDH6SWzVgIt9t7JfgnXGOoiuVKKdcwiKMGAWsD6nYgYzdEeORT62LlU6YoaYTeabHeshTyrjQY7HfOFSqqrtwQbSOKycCbRcxm8xLzZk5leDOs+QQXZ14iqCIq8EMjzhACweX1iIjgJohvTc+rQ50Etni9vs4dbIvXPgk43fstpcBSoehvhS9cVMO+hjLJppohQrZQmcRrHvDnaPNpOz/oMB13PJSi+OfnjItlxhxciADzpsIOdN90hL9kvM/AO5qTuv3vX+PFlB4z+bWdJwufOCC5QMHWNJPs4C4+tqwot8aQDfXgXuE6HzVN/jwYz4DGksy1q54w/Zs12my9k/8bPKpcZtc6H7PkiFaLNJVk5BWT4t0CbvUqi3REJKjM7DpljFXII9dsdJ3sS2XLSRYPG/HFPO+zppY7t4G0U0gbsOsYfdBecUYzsrFXhFhBe2D5bpVC/vvgFuwWXgF7tScq1d6/RB2Q==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2996bebf-b065-4be8-74ba-08dbb5bc5765
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 07:21:12.7766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lYozkMTYI9lDWirgErPSdApr0W7l5i/ZaSYnIp3XFfW6MkIn6ZX7lM0BR0S39iPaxym0uuSZJDaLcy6fhcM7ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7213
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 15, 2023 at 03:57:58PM +0900, Naohiro Aota wrote:
> Running btrfs/072 on a zoned null_blk device fails with a mismatch of the
> number of extents. That mismatch happens because the max size of extent i=
s
> limited by not only BTRFS_MAX_UNCOMPRESSED, but also zone_append_max_byte=
s
> on the zoned mode.
>=20
> Fix the issue by calculating the expected number of extents instead of
> hard-coding it in the output file.
>=20
> Also, use _fixed_by_kernel_commit to rewrite the fixing commit indication
> in the comment.

Oops, I forgot to write the subject except the test case number. And, even
that test case number is wrong... I'll send v2 with proper subject lines.

>=20
> Naohiro Aota (2):
>   btrfs/072: support smaller extent size limit
>   btrfs/072: use _fixed_by_kernel_commit to tell the fixing kernel
>     commit
>=20
>  tests/btrfs/076     | 29 ++++++++++++++++++++++++-----
>  tests/btrfs/076.out |  3 +--
>  2 files changed, 25 insertions(+), 7 deletions(-)
>=20
> --=20
> 2.42.0
> =

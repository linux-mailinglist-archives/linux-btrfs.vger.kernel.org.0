Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7873E5F04BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Sep 2022 08:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiI3GTp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Sep 2022 02:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiI3GTn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Sep 2022 02:19:43 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7137D61;
        Thu, 29 Sep 2022 23:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664518773; x=1696054773;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8CROzHJ7uWC10gY+h44Baojo6B38tDTFCMbPKgkqMJI=;
  b=iaOpiY+RhPs/KqA9nAE9BrrVsuPTlgob8YWvHn2GUiny+Q80A9yb8bCZ
   ugefkAeVQgQ6IxNKq+zlxEfqwk9Aypra9pdZ6ct2RjLKgnCjn9gNrHfws
   pd9DwgUmA6UiW61+JbjY/6sDIF7LOP4vaY+itgNtUTk9r1yO2YPOe8uUg
   sh5vVQAyZsEKlH1DZBb21vSTrl5t/7yJbVDYHlmRePEB5EGPdeKt9Xr3x
   hzMUAU3D3zhzP5zCtahNKC6woecJ02GiNV3sNgYPLhgxbqBenlph0+f0j
   aPc2qmGqEOxIx1SJaMsM3NpwZqy9La4AD9a3J9hiRlJV7x9UKCVGe825L
   w==;
X-IronPort-AV: E=Sophos;i="5.93,357,1654531200"; 
   d="scan'208";a="212647776"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2022 14:19:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2o+4A84es6EfaybuTCsRnVPpbatM8xKVWWUSbTMfcIEz2lvGb5VGDMQVs0qCBx+dJ0nA2uX0UuE6KhJEPDa2ND8vR/JXPbWldwqY1OuB56dRHmnl+ZqdvHGToZLxNOO7ezZ75HHNXfIac36yFg281h8+UyBuSqsx726L2mRyvCS0JBg1I3Z+x8huAPDBywtjSa41kpnbSD1LSqRMbjiwW/VuI43kxWt/Gvtv+ZXNoQjBanHWAOOyQOTkbyBlhsd/fy04CFmGPkHPljB7cGQEVz0w1Cipnv/E2135z/SikMvj/K2PTxId+eMgkmpm4KWAEudgEURZ/tgv/xZeT2Rvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeVztM0NXWALHfTLPBMxVPkRWHuaa3VDP/cpDc0ZO+4=;
 b=mc2+tc4+BOI7JvX0c7KYR2I6AnlCiHPj71GUVbTUylrPB1TSq8gI+jWQEX665+y/grHhfO6aqQsk/9zrE/f9jNUVL/slQlhNp3H4tl4gEHfxCQq9mGiVLS5bEhA0i0r7DtPSAeITSRnWdS30htXHG624gJ5ud83k4UpaPmrm9dbffpC5dkVkjTaWXmjmHljkZgb1kYxA5JWWKubVP6olUSmUS5ivwQMsJ4JOMzQPC7q3IS+67l4pa05p8FMkyQTwgRP7v21vFXfMsryGKlYhxOpd8VjiWX/2TACU8IJ63uA/vQpadKrmk7X0kzE82EDQPk11CWdvybzn+tFPmFH9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeVztM0NXWALHfTLPBMxVPkRWHuaa3VDP/cpDc0ZO+4=;
 b=vA7XPK4wwduKk60+Zpr3d8GldR2Cgw7yFa5um48B5bqTDRRxUMwPDB7iU/3N1VDwF3NTxPz3xrdbA2E1yFYLCRxuVinKMNyvvAb4uWiwI2Wg8KTdQnWFS0Ctn4yEvC5cakVlbXY6u4V5HgRaKNnHbzg8LPHewkVplnorHl+Na5U=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB6153.namprd04.prod.outlook.com (2603:10b6:5:12a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Fri, 30 Sep
 2022 06:19:29 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::11a7:2daa:ac81:48da]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::11a7:2daa:ac81:48da%9]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 06:19:28 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Zorro Lang <zlang@redhat.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] common: introduce zone_capacity() to return a zone
 capacity
Thread-Topic: [PATCH v2 1/2] common: introduce zone_capacity() to return a
 zone capacity
Thread-Index: AQHY07qxkqqwrCW/oE27PJQvPT+AOa313WuAgAGkTQA=
Date:   Fri, 30 Sep 2022 06:19:28 +0000
Message-ID: <20220930061926.pdej5mnfunj37sow@naota-xeon>
References: <cover.1664419525.git.naohiro.aota@wdc.com>
 <b148b071bb11828f4a4c6600331cc8464a1895f1.1664419525.git.naohiro.aota@wdc.com>
 <20220929051507.aonami57xnhnixan@zlang-mailbox>
In-Reply-To: <20220929051507.aonami57xnhnixan@zlang-mailbox>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB6153:EE_
x-ms-office365-filtering-correlation-id: ee804f7b-a435-4eca-9b12-08daa2abbb0b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m2tzqzDmOw01k6Jrnp6aKeguKq7rMMFCvidxYdiB4qPSH3lCyMSGsRl9eyt66+XXwPv/kfpRX1A77VtIGxoN2AxcnEbgKPqXWuvBoUk00VPoPj0gJSWxo+woeq94hTaqTqd4SaFOSWfopm9t5FK2t9tB4CVRL+SS0QMc5AOllMng7lFqWQZx3Jr6NmuLsAgMVrQ4Dg02JoWy/3WMDQ1MQslkh9xfmad+ZJYD1/8RZEDYc17OD1OH8iOMI5s0AjGwxE2IxNfwkw3pfzyvW5IclFgCvm4Y8EY+2kRv34oKTrInHvJD8ZzvENp+6pJ/dO/0uBzbtblpels3mj1YQyZo5OalNvx76x52Vr0TLc/0z3JmpBB6SFPYep+d9V9pi5yPCxSNvzs4tJYSA4wRxUVc6ume6MLI8ul+ZwIdeoRRkIMirXiPVHvIxwbQROdoxbTYTnnknQHffhPkv4eL5nPNCF3le9EqLwekozqScrrnlW/+J61CtsuD/mqQih7sIegDVrNI8D6pn2QEJBT/TshL5K8lvk+5iaRRFLR2FUPHphX2q6qM6m1nDPrP9SaWbgLD4fbgdi5T3H3XmrEMF9hPECJ9P6Z1LUMiulRmbh+7MZI8W5YrT2lx1cHDXdaQ5q0iuiIBxrUtRYtHnsSq6t3OMS7ToNMGZfqvsGH0BtlQmBqkLroUci0hzwjYukFM3V1V9qBKTCKk1m7YP0q72CLNwEqUb2zvn9kZPJ1fW/Juvqe23jP0OU/ACo4MloYlg6QUe3zJFjg45CX91CaSNNXwVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199015)(71200400001)(6486002)(66446008)(2906002)(4326008)(6506007)(316002)(478600001)(54906003)(38070700005)(82960400001)(38100700002)(8676002)(76116006)(66946007)(33716001)(64756008)(91956017)(66556008)(86362001)(41300700001)(8936002)(6916009)(5660300002)(122000001)(83380400001)(186003)(1076003)(6512007)(9686003)(66476007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mXbN4zdGl8YjWWGoFmgBTSjA1AyzyKU7RzVr2+s2rk3yQRu3X96yHKLq27UK?=
 =?us-ascii?Q?dH1XT0a+atkJukMiixRmA+zjfxK8U6nctEu0gPKcuvvRMv8zlrYdY14l39/5?=
 =?us-ascii?Q?GamTbMXhfbGIGdDGHWaVAIkPfRydEzENNAd+COnVDxNWBKw5uIUWnh66QBJZ?=
 =?us-ascii?Q?IENLnH/KnKDm643qNIuxmqZK5IgWBUwx9ukemJhpu8Tc2rqYeDt5b/KHnkSV?=
 =?us-ascii?Q?QxuJB4OUX8ZiS3tGyhxciVz8doY8IlrBnXcVkfhfQY3thq8806aM6mh8mEOR?=
 =?us-ascii?Q?ctvDi7KYjzMTu7dQvugbUTE3pyUKhW6G8S1ASFZLNTEU9Jqfk8D22RtyaX4P?=
 =?us-ascii?Q?Fp/L9bNKA4aFwQJowjmUFrTbNsKqxD/H4xCmKEJkLh479An97o+x/gbHznDZ?=
 =?us-ascii?Q?eZwQ9HwWf5du2eRUkTcoz3T2NJTG2UneZA9SnCszJhhULD+NnDZCtFPRoFxU?=
 =?us-ascii?Q?6Y5nvto0x8YMjnA78JQ5PKYz2YnHszG5HzgrC/4KnJFbz5/0OptQqqzKRH0e?=
 =?us-ascii?Q?cGlGC6DMH9cwjwjwjoGHcrobDYE6Ahzm+lhOlzkAX0mKHPtbOunH5SjDMKkn?=
 =?us-ascii?Q?cUuIP6+y7kGAntXg+Zs+oz6N5P1yqSD3qwoyCRKekXSaA/MxhiWD0NQWHwsU?=
 =?us-ascii?Q?nVqPMSyP5gBLm68dC66FTsPhTDaBvAl2aSVE4E+Wp3JSwgcafPmuf6WP5emJ?=
 =?us-ascii?Q?g7QKcSVP2dFlgbpHlhFSEVJCjU6iplVynWHB4+/XEEzws/FP1+6lGDfYN4IT?=
 =?us-ascii?Q?VgdtW7vMXWgIKmqN8DH8qkhqysdwqvkpI2tz4IblQRnXxGs4W3zMsd2Y7zbd?=
 =?us-ascii?Q?nSnk+awDP6aVNuSrl3XiuEsUgeRI7AC9DD/GdEnK6RHaQb+faSp6DEsneH1O?=
 =?us-ascii?Q?LuMv1A0RqLpmCGu8/1FOSTZwPfIVdn0BYlOsP2lQojmOBc01UmVQ4mD7+OXV?=
 =?us-ascii?Q?7GSC1cR9GThTZ2CxO67k1TKRcmOFG4g0AVVHCFHtgKuCH8blpDpL7/NXYIV5?=
 =?us-ascii?Q?Cv0jnx1UKVnrfSSEGgyUgezeOdckbtIvsfN4xayqWjirEYNL2CFvlH2LeavO?=
 =?us-ascii?Q?rIQzURg/B8YooDYRYEPlSEjIj3yfnR9IZ4EfN1CYjxe6wyjMn2Ie7ws87N1T?=
 =?us-ascii?Q?yKiH/P6x5L5lsRqxc1Tvoec+MSZOduEgtLN2YeYNrVdcL+Axf6Rs/P3Jcrdr?=
 =?us-ascii?Q?+jvaRYnYU7mSowecJRabveKqJzfXKK1rGdMeg5r5ez92OZjiS7GV5p+k4orF?=
 =?us-ascii?Q?lCUHqImBtdyoLWgo6VjrMs5rBBPnJovy12k4gN6/agM7toPoM76LyZ721+oQ?=
 =?us-ascii?Q?Pa0Jqk67R5BUjWSD6iT0TbsutKNdRpeYI7EmnU/r2DfyVWnGa0ZSvbygZCnR?=
 =?us-ascii?Q?k0Zql750CpleB0Q7MfwIM6UBd2dhpMH5NaHSYQr/5B7h/BJxBelVSVD8kzgJ?=
 =?us-ascii?Q?2UfuR/xBfPSBw72buYATEs9s+mXPP8a6hyVno8JDvL5cR/An1gem2jAYVays?=
 =?us-ascii?Q?Z5+p0tl3FSwVR6Otfg1y/ezHZElNGhIJ1TUWnZ6ghTYi7B6xGlrb8m7//2ak?=
 =?us-ascii?Q?5esxt4Jk30f6ko/KYhqnCrMRTtQqX+pY1ltqpnfk7pz2CxPbTB7xzoJV1goz?=
 =?us-ascii?Q?zQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E65239466DB4E64BBDF847CF547ADC89@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee804f7b-a435-4eca-9b12-08daa2abbb0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 06:19:28.7085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /urtQDKIj2R6Lm6o6J0qJh5SjPOJZtV2aAOmrR/2OiGXi3Q7yEKG6Y/Nx3QqZy1aET/cdkhQ5yRe5tdH3QEdaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6153
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 29, 2022 at 01:15:07PM +0800, Zorro Lang wrote:
> On Thu, Sep 29, 2022 at 01:19:24PM +0900, Naohiro Aota wrote:
> > Introduce _zone_capacity() to return a zone capacity of the given addre=
ss
> > in the given device (optional). Move _filter_blkzone_report() for it, a=
nd
> > rewrite btrfs/237 with it.
> >=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  common/filter   | 13 -------------
> >  common/zoned    | 28 ++++++++++++++++++++++++++++
> >  tests/btrfs/237 |  8 ++------
> >  3 files changed, 30 insertions(+), 19 deletions(-)
> >  create mode 100644 common/zoned
> >=20
> > diff --git a/common/filter b/common/filter
> > index 28dea64662dc..ac5c93422567 100644
> > --- a/common/filter
> > +++ b/common/filter
> > @@ -651,18 +651,5 @@ _filter_bash()
> >  	sed -e "s/^bash: line 1: /bash: /"
> >  }
> > =20
> > -#
> > -# blkzone report added zone capacity to be printed from v2.37.
> > -# This filter will add an extra column 'cap' with the same value of
> > -# 'len'(zone size) for blkzone version < 2.37
> > -#
> > -# Before: start: 0x000100000, len 0x040000, wptr 0x000000 ..
> > -# After: start: 0x000100000, len 0x040000, cap 0x040000, wptr 0x000000=
 ..
> > -_filter_blkzone_report()
> > -{
> > -	$AWK_PROG -F "," 'BEGIN{OFS=3D",";} $3 !~ /cap/ {$2=3D$2","$2;} {prin=
t;}' |\
> > -	sed -e 's/len/cap/2'
> > -}
> > -
> >  # make sure this script returns success
> >  /bin/true
> > diff --git a/common/zoned b/common/zoned
> > new file mode 100644
> > index 000000000000..d1bc60f784a1
> > --- /dev/null
> > +++ b/common/zoned
> > @@ -0,0 +1,28 @@
> > +#
> > +# Common zoned block device specific functions
> > +#
> > +
> > +#
> > +# blkzone report added zone capacity to be printed from v2.37.
> > +# This filter will add an extra column 'cap' with the same value of
> > +# 'len'(zone size) for blkzone version < 2.37
> > +#
> > +# Before: start: 0x000100000, len 0x040000, wptr 0x000000 ..
> > +# After: start: 0x000100000, len 0x040000, cap 0x040000, wptr 0x000000=
 ..
> > +_filter_blkzone_report()
> > +{
> > +	$AWK_PROG -F "," 'BEGIN{OFS=3D",";} $3 !~ /cap/ {$2=3D$2","$2;} {prin=
t;}' |\
> > +	sed -e 's/len/cap/2'
> > +}
> > +
> > +_zone_capacity() {
> > +    local phy=3D$1
> > +    local dev=3D$2
> > +
> > +    [ -z "$dev" ] && dev=3D$SCRATCH_DEV
> > +
> > +    size=3D$($BLKZONE_PROG report -o $phy -l 1 $dev |\
> > +	       _filter_blkzone_report |\
> > +	       grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
> > +    echo $((size << 9))
> > +}
> > diff --git a/tests/btrfs/237 b/tests/btrfs/237
> > index bc6522e2200a..101094b5ce70 100755
> > --- a/tests/btrfs/237
> > +++ b/tests/btrfs/237
> > @@ -13,7 +13,7 @@
> >  _begin_fstest auto quick zone balance
> > =20
> >  # Import common functions.
> > -. ./common/filter
> > +. ./common/zbd
>=20
> I'm a little surprised this line doesn't report error :) Anyway, it shoul=
d be
> common/zoned as above. Others look good to me. With this fix, you can add=
:

Oops, I forgot to run this one. Thank you for catching this.

> Reviewed-by: Zorro Lang <zlang@redhat.com>
>=20
> > =20
> >  # real QA test starts here
> > =20
> > @@ -56,11 +56,7 @@ fi
> > =20
> >  start_data_bg_phy=3D$(get_data_bg_physical)
> >  start_data_bg_phy=3D$((start_data_bg_phy >> 9))
> > -
> > -size=3D$($BLKZONE_PROG report -o $start_data_bg_phy -l 1 $SCRATCH_DEV =
|\
> > -	_filter_blkzone_report |\
> > -	grep -Po "cap 0x[[:xdigit:]]+" | cut -d ' ' -f 2)
> > -size=3D$((size << 9))
> > +size=3D$(_zone_capacity $start_data_bg_phy)
> > =20
> >  reclaim_threshold=3D75
> >  echo $reclaim_threshold > /sys/fs/btrfs/"$uuid"/bg_reclaim_threshold
> > --=20
> > 2.37.3
> >=20
> =

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCFE04AEBC4
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 09:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbiBIIDb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 03:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiBIID2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 03:03:28 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Feb 2022 00:03:31 PST
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C17C05CB80;
        Wed,  9 Feb 2022 00:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644393813; x=1675929813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hVh7azU9A85eY0WV12FYNF6zxNXqXscuVltmwROsJYc=;
  b=inzsxC1NgYDgCpX1L9qLL8ObBrNMSLqcgEqPsTbn5cAOIOUi9jOomiie
   LQYSogw54yiftned9YPCI0u3LfEuQhDXmoypTgbK8jpVzHkg8amrTZKn7
   8qSQkb5p4egAlvRbpmTs3i3+aoLWiZ6yo3iBac0ZrNhfumL78BnJeXsoQ
   nPuKxZwIHcUcrXDwkkTbTPtH7P/Qg4Q76xy8WY3YrdDY9NPPkGp/i7tV0
   8SY9LglkBJ050wag1oGnJlKOrXKr1IhIusXVqFMzKong466on7JJsCnMh
   3gEEKe/XfDEC4doZJ2vjI8nyuG2ABM/8sylCxMvfhBEC/kWn+Ooghb/tz
   g==;
X-IronPort-AV: E=Sophos;i="5.88,355,1635177600"; 
   d="scan'208";a="193470465"
Received: from mail-dm6nam08lp2046.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.46])
  by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2022 16:02:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkMMNnGgSM33VTGbrhJvMayplyqbAMfV5Fss9zSmCb2ncYmSnL2dTRijuKqgOxrE+WdVbpZEn7RXVBmCSkNPAcX4X+OQHEYuyV0DJMUNLLn3Ly9+mdR5xTNuJ+VGyQB+P48CtGggqEBR4OEJXEcqeASsmMwPvoUJMWjsqjs6rmbnXWOPErBG0luSqPFR40Fyziv3G5fhNPwfpk/zKI+Fes0OOH/NcwenWm4pyY0r8prGo+jb/X6CmAEA5XyLUMVZc4tWY9ErdRtOl/axRCkfxMP25vYTUsZOlQ9UG6DH7URmeO+MqDUJ4Jyukm1PL2uZemHBjYZbF2P6LRdQnmtQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EXDrMRjGCJEbaE1r7bTY3YJRTR6HkBhneN1O5+XROU=;
 b=VKXHxbOvb7VGM5VO6K//F1YfM/K+qFvmbAeFSrOVtyS+UH3s9fyU62aBb9T0sjYJnF7FSDuRNvVTsMmwAafi77ZVdNlrlpuA4QNuIzcQJQztCIabftSFzf2DwnMF0IuD1dJR8+T71MkSEz3a10rlFTAf56MBJiFtXM6RjpooItN/loIHAt8eb99HPIctz9kmXHHfWFJYNzC2nZMt11nJQ26Q8kPBYZH+bPes+RxAPmOVnOSO6995GAzJaBRq8O5rDKAraf98BRxsdHp96k518PwC9zgEy4n1xSUif7jBp8Oki4WIxdoXHvkPLvjNMrQ64FqnnjEaHFLpFcfl0RpjVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EXDrMRjGCJEbaE1r7bTY3YJRTR6HkBhneN1O5+XROU=;
 b=rH4k+9A1+Bd7R7ZqZbb5tSnckSzeh6ZfRMuYTZfSMcS8w7StcyFtXMd0wEqv80gHpooHTdpCrc5uk9+3cgpWMEIzazwA4Khkzkbtj/VD0Vwl7Lqrt2S+uXozvIO5Eomnnnzyl3Wyl8/6MyZlITr8qMCAPrGjrpAnV2+ccJiELWc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MWHPR04MB1214.namprd04.prod.outlook.com (2603:10b6:300:7b::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Wed, 9 Feb 2022 08:02:24 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::8c78:3992:975a:f89]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::8c78:3992:975a:f89%6]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 08:02:24 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH 7/7] generic/204: do xfs unique preparation only for xfs
Thread-Topic: [PATCH 7/7] generic/204: do xfs unique preparation only for xfs
Thread-Index: AQHYG9A7DH6qtXZ+rUmBDTKacgfQtKyKaHGAgAB2q4A=
Date:   Wed, 9 Feb 2022 08:02:24 +0000
Message-ID: <20220209080223.3n33nnzs5froke4q@shindev>
References: <20220207030958.230618-1-shinichiro.kawasaki@wdc.com>
 <20220207030958.230618-8-shinichiro.kawasaki@wdc.com>
 <20220209005739.GF8288@magnolia>
In-Reply-To: <20220209005739.GF8288@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f31ea3c-ad12-436d-4671-08d9eba281eb
x-ms-traffictypediagnostic: MWHPR04MB1214:EE_
x-microsoft-antispam-prvs: <MWHPR04MB121425DF492D202E9486A3EAED2E9@MWHPR04MB1214.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uG0TbAfBLDC3XziwPedtVz8GlWYQN32rAeBTGFc4nNjTx+1iWPvoLObq/N1kJ5NoISjc44hEaZfRfqLjxtE70mA58xg23UpGd6FrTf44b0NJACuy7Rf+pUjmcaQpP1lJ27uYAEB0w1b/HhH1PQKjQwQgQ+F23l4aHphp/VjBqzzhc6Vqt/8Dsh3Gse7KrzaJGb100ETkpD93D5+1qQmDI3afIQiqU45W1/UUlt04YlWIO93cmOpVoKTy2Fz1ARO3mIOzUBLvEbQkPQQmZ7Fp/dD/bhaQygf+67758sJcTcGOnYVn+4dEl4vdGPQO+SwO1b57OvAlOIhRbBYd2TMARHGJp0Ur0OHPQ3ZKsGhbsdvev5jydmxzxDTWILYUva1Pbi/EtSoKxgKU7Iok3iIAomr++SSA6ToAe8o+v4ebur017K7K0laQ+vlWVnV9a9ZKYRimJXxiAJNJ/vTDvKy7sUD/mAr+Xw1WYEn4ZcR5B9r1YGYLjS6+uKHqN/chNfkX+PujehoBaPlzSkGwEUPdQ32Zlu4eM/uE+9z4tmr4gcQsusLQOCwt9EY4GHo/OTAEu1sRQWzKZDdxAUMaK3vvHb0DsUrga+NC6vF6YWW7ij4+fBh56igKUVH+GUMez69uO+3hjQf1T4PDe+UcFEViVGH7VoEvadotU5VV2QyXJ3g5KFiUrB0fb8yNwArV1r5RtdeQpZpIbkD4YQLSEu3Dil0ojq4VuM20PGc6TsshOXk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6506007)(54906003)(1076003)(6916009)(508600001)(86362001)(2906002)(4326008)(316002)(122000001)(9686003)(6512007)(44832011)(83380400001)(76116006)(71200400001)(33716001)(82960400001)(66946007)(66446008)(66556008)(38070700005)(66476007)(5660300002)(8676002)(8936002)(38100700002)(91956017)(64756008)(6486002)(186003)(26005)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?h3aV5ksNW+inpzrtzBeFlsdWBVJeAfumrdq6VrHrKSiNVbYPNZFKIosWFIGe?=
 =?us-ascii?Q?4tlNmVFTelw8KBTrF2NV36i0d52MKtsP0MbRxGbiXd/dCuDG4rmvevcNVwie?=
 =?us-ascii?Q?aZTzV++VngFYwXVkVPpXRZYwUi2ekhTThWa8TiZH3hzwuo4sr+JT5I9mrcuz?=
 =?us-ascii?Q?kc00b5/VkF2gHxJ1h1FCtPmbK0u6HkiHS/jVY+LpbFgafV7N4+aM8vjykuIk?=
 =?us-ascii?Q?iRKHkVSw2vdwt7mbQvfTZ2iTlxOAE/PhA8CL81ZXcns6nRopkvY9Cb/TLZZD?=
 =?us-ascii?Q?bHn3hBhIHnHXrR3DWIzPzwtsPmTLMZVyQ1zbPH2J07hHEt47i7IrOrkEayd+?=
 =?us-ascii?Q?7c1J5a+NbbmF07T0iQ4GLXCJHoXSfw7GGFuHeBKdyFNeGunbVIFYlYknUAia?=
 =?us-ascii?Q?dbThs9q1vMNrBDLEyu9Z22GKn9khx8vNFdXihNsGZM5WizzuFWauDDbNS3Jg?=
 =?us-ascii?Q?jsVIYbmCsLoZdTWteIUdMwZKKymZ2vIKL6Gch+JF2IitDamYHXN9GlwM6n1N?=
 =?us-ascii?Q?Wwo7VoSyU9uKmd0gmGcLN0taLRKtYIyVab1KNLTItMw1jfJnr32B/sZglAd2?=
 =?us-ascii?Q?FrzDV3K6BTyInmgQXu9WmZciM1wrmwbjiYfOe6Q8JG5RtyfXPr0taZSjJc8r?=
 =?us-ascii?Q?NejgBwy4TRyKf7OA5PszXxCFniT6/WDqa2sHrTNDEwfOXH2CNyTjjUJmb98X?=
 =?us-ascii?Q?hagzgf06azP8mmiYm/hpKRQhpOJzngziYfbQN/nO94A8OCPArNIyTbl1icTs?=
 =?us-ascii?Q?+klhcItxb1S0+sAGRYf2+xnO7EmzemDlEpIfHJInR7ZCTj0uq7f7Tur0S5ca?=
 =?us-ascii?Q?ZHeYKT/WBGRZiyfWAsMfWPfbjhmIR5RxT/qKUH6McypRkWER+NXO+BIB0MgR?=
 =?us-ascii?Q?E5VPyL1E8fGY2iis3trHMxkdQrkBp/2CzpOxXFZhefhrawKv31i3KJMEUmir?=
 =?us-ascii?Q?PVVoXXyKEFln6kBMwC1cNusj24uSErSwtSREjxup3hQA501psJ6tQhdVj8fl?=
 =?us-ascii?Q?fdnqI9qnt5uUFihNKp1eacTRs3HVCvV4JuzCiQ5J1TdxhQyeZnbByQD/zW66?=
 =?us-ascii?Q?GGdsK40aZFz6zURiA2bHvcte5WS1GLEJJWu6jwDOLz2icjtcqwxED8RhgYaC?=
 =?us-ascii?Q?h5hkR4mjVTX4T5dsmCmuYhbWCVL0hYlqKfO9+VYtgUX3aTrSNXlzQxrOTUSG?=
 =?us-ascii?Q?CsdgvfZ+a/Yr35f5oKG0zkq4IKCKxottBi0qQZ08Va8RGo0HFmIacrabU4w0?=
 =?us-ascii?Q?AjDbQN5rdbCyw2RzNbnAwqOaDw+7cFl1xqkQuJ+tJWPRFF5UEuU2WzynQxM4?=
 =?us-ascii?Q?dQugLxu3zfdGL+SPMfGrcmh2iS5SGT0DlwiR5qdIfOswrlRXGz+EbGyMqBKN?=
 =?us-ascii?Q?I2oiItOFXnseFBlo+MxnqyuV2VTd6nDglB6cMu7RJSye2k+OpPHgxR32AT7Q?=
 =?us-ascii?Q?QlS2sjLeWKBwnlUX2EVpseG1u/Q9gXpq4EvUcbLT9qpq5K67Hgl9T12YECmY?=
 =?us-ascii?Q?bRvVwSFsCPHv+CHLlU5KwplYeRxHLsEj78Foj/Qj2wR7YzZDWZ00rCwk5brx?=
 =?us-ascii?Q?72ZAkGTWfyrObdsJjEKn3OnI10qbzo0/n2fZ9rtzx38yKVDiZa7znmVc7mdB?=
 =?us-ascii?Q?nzFZ2XpK+ZJegVJwc5TsOg/thfxD6uDXWp4LTeUJoKccW6zq+cR8pmN+NI6N?=
 =?us-ascii?Q?u9RPlwZ+NohTSDqthkCp8g/f7Ng=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A9A430E86EFFCC45AD98282362608D47@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f31ea3c-ad12-436d-4671-08d9eba281eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 08:02:24.5763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uH8X4FoqWkG7v0POMBm9gIXbPlfGXdiNqFmBL6TFJ2A7iBzJChSp1qpaE4O1TrvD9vWE//5DJxIYtnURFKuRVTbdSJO22iAVRSwPyRzrtxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1214
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Feb 08, 2022 / 16:57, Darrick J. Wong wrote:
> On Mon, Feb 07, 2022 at 12:09:58PM +0900, Shin'ichiro Kawasaki wrote:
> > The test case generic/204 formats the scratch device to get block size
> > as a part of preparation. However, this preparation is required only fo=
r
> > xfs. To simplify preparation for other filesystems, do the preparation
> > only for xfs.
> >=20
> > Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >  tests/generic/204 | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/tests/generic/204 b/tests/generic/204
> > index 40d524d1..ea267760 100755
> > --- a/tests/generic/204
> > +++ b/tests/generic/204
> > @@ -16,17 +16,18 @@ _cleanup()
> >  	sync
> >  }
> > =20
> > -# Import common functions.
> > -. ./common/filter
> > -
> >  # real QA test starts here
> >  _supported_fs generic
> > =20
> >  _require_scratch
> > =20
> > -# get the block size first
> > -_scratch_mkfs 2> /dev/null | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
> > -. $tmp.mkfs
> > +dbsize=3D4096
> > +isize=3D256
> > +if [ $FSTYP =3D "xfs" ]; then
> > +	# get the block size first
> > +	_scratch_mkfs 2> /dev/null | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/nul=
l
> > +	. $tmp.mkfs
> > +fi
> > =20
> >  # For xfs, we need to handle the different default log sizes that diff=
erent
> >  # versions of mkfs create. All should be valid with a 16MB log, so use=
 that.
> > @@ -37,11 +38,15 @@ _scratch_mkfs 2> /dev/null | _xfs_filter_mkfs 2> $t=
mp.mkfs > /dev/null
> >  SIZE=3D`expr 115 \* 1024 \* 1024`
> >  _scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw \
> >  	|| _fail "mkfs failed"

Hi Darrick, thank you for valuable review comments.

>=20
> Getting back to why generic/204 calls mkfs twice --
>=20
> The first time is to get dbsize (aka the data block size) and the inode
> size.  AFAICT neither mkfs call add any mkfs options that would change
> the block size, so I wonder why we need the first call at all?

Oh, this question looks valid. I think both _scratch_mkfs and
_scratch_mkfs_sized handle block size and i-node size options in MKFS_OPTIO=
NS.
So the first call does not look required.

>=20
> Would the following work for g/204, assuming that _filter_mkfs some day
> provides correct output for dbsize and isize?

Thank you for this idea. As you suggested, I removed the first _filter_mkfs
call and $dbsize option for _scratch_mkfs_sized. With this change, I tried
some MKFS_OPTIONS variations for mkfs.xfs (-b size=3DX, -i size=3DY), and
observed the test condition of g/204 ($files) is preserved. Will revise the
series with this fix approach.

>=20
> _require_scratch
>=20
> # For xfs, we need to handle the different default log sizes that
> # different versions of mkfs create. All should be valid with a 16MB
> # log, so use that.  And v4/512 v5/1k xfs don't have enough free inodes,
> # set imaxpct=3D50 at mkfs time solves this problem.
> [ $FSTYP =3D "xfs" ] && MKFS_OPTIONS=3D"$MKFS_OPTIONS -l size=3D16m -i ma=
xpct=3D50"
>=20
> SIZE=3D`expr 115 \* 1024 \* 1024`
> _scratch_mkfs_sized $SIZE 2> /dev/null > $tmp.mkfs.raw || \
> 	_fail "mkfs failed"
>=20
> cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null
> _scratch_mount
>=20
> # Source $tmp.mkfs to get geometry
> . $tmp.mkfs
>=20
> --D
>=20
> > -cat $tmp.mkfs.raw | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
> > +
> > +if [ $FSTYP =3D "xfs" ]; then
> > +	cat $tmp.mkfs.raw | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
> > +	# Source $tmp.mkfs to get geometry
> > +	. $tmp.mkfs
> > +fi
> > +
> >  _scratch_mount
> > =20
> > -# Source $tmp.mkfs to get geometry
> > -. $tmp.mkfs
> > =20
> >  # fix the reserve block pool to a known size so that the enospc calcul=
ations
> >  # work out correctly. Space usages is based 22500 files and 1024 reser=
ved blocks
> > --=20
> > 2.34.1
> >=20

--=20
Best Regards,
Shin'ichiro Kawasaki=

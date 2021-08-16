Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D94D3ECE87
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 08:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhHPGTx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 02:19:53 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11563 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhHPGTw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 02:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629094761; x=1660630761;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CZXluSnS+AqFYpUA0V6AIvqUvEmHP3zWQTkCXOdKfsg=;
  b=al27X0XnhxaO0/LPc5pXGOZimHUSR3q1WgUEGVWo0XTp3xhiRPTrVqcH
   QR5uv/2OhrJAClax7OaDsrdvrVTBbXdnFjNoSPgHjyVXvfwEDY1BeJxZ0
   8ni8dnOr4RQM1vmSmCAG2mTv1hd/1m0yvIuQhHOw4WsfSr0rULuQxUWDv
   nS+hMjCkI5E7e5XOHw5/AKFlkzRhDqjsKp+v6RjjkAAbQYnXi/dkzp94F
   oXjw/aSLM1gfJ3dlcALn8wEhRk3yvn1+taTd6BwPLMeujC6yedanvGUAJ
   0KKZOMxK1Ew40o7x/NCHbrBH0IrfbeD1weq7nlkiQUtkwH+THlFA0thoF
   A==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="288927876"
Received: from mail-mw2nam08lp2173.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.173])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 14:19:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnxJUf97ox1ee/eNvsAjZ0bAXduwgw8toS06ES1+usfq3vwqQ8j+BcR6kei1Tpce0WzP3PoUwNYs1EqB3xY3DFM6FwQ60h+P3vyrwFB97XEdUhkKtN8AscF6D4D/XHfoSjpMLNm0FRt9SJKeyXUNv5NL0E444vuvmHQkoFpQAn01eO0NEh5mUKYyZtIyQO7gx1Oh7cycVS538rGsW0Xhf0NF9GWiXwCtVvpj8neYNvr1hxio0/zU4ILiQsOvBcpgeva7ErMWjyswW0snGUTNKEN27XjvDXn6t35byKSsRvAUsB2lyPIXozLEiH9hd9A5vATVy+Qq8UjZVgA8ivafwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v15C/8jeJ/72YoFP7JqTTvhhDGFLAvlcFyR1mGTHF6w=;
 b=EuSrcq2bXidUdfVlNodG4vCgS0OJeQEjzkEtRvnlGcMBBtQoYdhqNDPlP1HK6XoBMtS5q+kjffBG5AhYXeSGPnNE6NxVqvxBOuOd4QIcWhWVVs4JY502052fTsXBFXF36PDxJ9pelN4UocG/S/K9vnjqmERh5Eu6D2EM9etkSGyV/hkWvuPwsyZRe8MsoW6gswyWNrQcXQxYUuNuN/N9JQ00MbTyTo2IZBVIzHUOE4tmCflMSPzvWNcTzmQa1IJftWDPRagNTlTYke5Aa754t6iyCBqe9DCv6E51ej/Ylc10uPYhT8h6TYT5D3Rcv+X31Wp9Qf3BCnuCAwlV8h//Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v15C/8jeJ/72YoFP7JqTTvhhDGFLAvlcFyR1mGTHF6w=;
 b=sjItjtkzZZx+sU/5m3QWGbLmN2/s8u1K9ANJhv4ha+JtEjIZnhWfc6X/u8dcJbTwY6AJQl9QPKL28zZkeFaKAG5hOLwk4yG9hNfo+FZxEqI+SDisceqemfxlvHxe8WDC49JN+g9CkX/6dQxncf7fnhtFgk28UE58N0AqIXsrBFg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8359.namprd04.prod.outlook.com (2603:10b6:a03:3d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Mon, 16 Aug
 2021 06:19:20 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b%6]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 06:19:20 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Eryu Guan <guan@eryu.me>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] fstests: generic: add checks for zoned block
 device
Thread-Topic: [PATCH v2 8/8] fstests: generic: add checks for zoned block
 device
Thread-Index: AQHXjsNnE27y25uimkm1aMRr3bwEZKt0tIiAgAD7O4A=
Date:   Mon, 16 Aug 2021 06:19:20 +0000
Message-ID: <20210816061919.ae3kokcz6ksiq2xs@naota-xeon>
References: <20210811151232.3713733-1-naohiro.aota@wdc.com>
 <20210811151232.3713733-9-naohiro.aota@wdc.com> <YRkwp1l/qVjg7x9m@desktop>
In-Reply-To: <YRkwp1l/qVjg7x9m@desktop>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: eryu.me; dkim=none (message not signed)
 header.d=none;eryu.me; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9ec5949-f276-4fd5-4a5e-08d9607dc8ee
x-ms-traffictypediagnostic: SJ0PR04MB8359:
x-microsoft-antispam-prvs: <SJ0PR04MB8359BF7A9CF0AE9AF191107B8CFD9@SJ0PR04MB8359.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xBCJdgrI1UgNynk9FWeqgfnthRPDkN5BVfQk3z3Jg6zaXZy2IcjefImFyq1at3vnUiKobNGrOIhtgnZ6/Kf72BnF8fpI0k1LU/uiX8+GiFDS2KSwIY5IUxc6STYCzHm7czOnfBkxY4Sz/fnI8wfeAdtIae67D0oXVVelocC0jX7ZZSFEQksqL/xvYkzgtbr9DhlwtTsKsJ3DLkYXBIl0BKk4HvHIj/58rPbGSDwh9mRk1xB6tWELEuvtaaW3Y5BbtW3hIibYU7lfH/+GlRNK6IEZNjjpi7HvX+q9pOkg+psRSWRs3fIlPPI3PNtffrSEN5pGsCW8AuSLJJwlupwP+vFhfnBjKXAuSrA7f1APfkieQ16nmGIGqb1E3ogMUdnlSSYrwhBgrWHNtR6A1IIK7S71gawUhXqC1DRMW0eP56vSofMab40b1RQyOBtHbhHkJ5YjPgvINg+BRpFseBunYQzJTitBSoWgg+4LX0mKKMK3AIKSh0l+nSWZxKJpMIHTKpRI0Zcf66sXVN0lgwvKNYWcHgbcZGtfMc2lNBYZ/qVPlLGQjFQQQYZTh0ZhMz4epg5JJjM1NXshHgSwUc2s2fycx+K04+Y/x+1zBD62qyroDN8rcyxbGM7Gn46EQ+BxKs0sp3TutgqBaoHwrmwISHYV58mq0dBRp0xihE4q+uhkDZd2Hi8SK/WOGXJEE2k2mV8q0hQZ7UpVGWB0qztDftiXpH/RqEApZyTKzASIuec=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(376002)(366004)(39860400002)(136003)(396003)(4326008)(186003)(54906003)(86362001)(5660300002)(6916009)(6512007)(38100700002)(1076003)(2906002)(122000001)(9686003)(8936002)(26005)(478600001)(8676002)(64756008)(71200400001)(83380400001)(33716001)(91956017)(38070700005)(316002)(6486002)(76116006)(66476007)(66946007)(66446008)(66556008)(6506007)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3v8HCy1xPx8ZB0AEfnUh0e3ZZRxA1pUIk8mdzOgKLvSSMQvkubrtemssIezI?=
 =?us-ascii?Q?ikw0fk3KGnT57AJXKKJb0HvvwdnoLMKkg0TRGw66H82lhc5j799ufDUY4I2I?=
 =?us-ascii?Q?W5/uCIP64uFVbleQ4fpDSV2woZZ6N7MGtiNwJiwFbMDVR68NO/bbMVdqCVEK?=
 =?us-ascii?Q?gc43uBelzDMioM19Bul0pfMdyKMaP0UjrMDNB/MANpwMQy2ZCACU9X9ETqcy?=
 =?us-ascii?Q?Wz0AS6mkMJ3+XJ9jz1kp+rUhG+qj9cOvbHDZFHJ1xcnYFS4O/rmusZnQMg+5?=
 =?us-ascii?Q?Tq6dwbqqxtS1oWW6dg/m9RR0yNoUWmkOhO40KOe7CQaIGW3spCGwgmveicXx?=
 =?us-ascii?Q?a9v9udUXJ9uMoZmC4orPsnj072jL/zVK3fdMFJBsp0CM+uIb/XvMNtFc5P9S?=
 =?us-ascii?Q?5Z9O4WHQrZBSPrpLPMYMrvG0FyvIU2t+VhXXOBoaACo2RbQtmekzwGXtZ1zp?=
 =?us-ascii?Q?ydAmwv8o32ZNy8JNzajcyhN0gXBRuls95brLxyS3tDoVeg2CqeGI2IKmO7Kp?=
 =?us-ascii?Q?oE/Nj4T751NQHPQZvocMOwOP9mu++bQGCrmTc0pU0Y5ivboEKn9gVP6J5UiT?=
 =?us-ascii?Q?k8hPr0FLQYcTzk7pe69DkWPUfgVzziVWS4rpmmZJPemkiu5qvvA41JBsYTPT?=
 =?us-ascii?Q?fo/Wrmv4Q5TLYIGr+9EW2hSh/OPW1AjgKsmyMF+kPcaggtHehOLsb1cNfb83?=
 =?us-ascii?Q?j3bM09sh8dH6DCoSPjhtvC9WpNku1cBDpnZcBTozJJzcVoKUP6BLkgmF2/7l?=
 =?us-ascii?Q?Ez5bXzRxyJ7xgGuHha8JNSfit/IJ86PEaKD/VuvCgyzQ0UvG/ySMG/0a6mSK?=
 =?us-ascii?Q?F37vi/8chNnqmTvMs8Ul5bF/OMyIU4Byk64Net84KcEV4e/hVudwpxIZsUAa?=
 =?us-ascii?Q?wcwbmvqBs1wqCi+rjd/yEwFYqjxjoW/qBPI4l/I12bKz0u3LqmooQ172xY8F?=
 =?us-ascii?Q?fYVTWlSDqxT8BB7TsB/hFzuHFdLPolm5veJdNeLSoRRKNNhXjmbCb9vII8mA?=
 =?us-ascii?Q?Lx+Dohyxd1NLyYZsPa0uZUECnROwdeSG3auzWxky7bx+Hx2QeGiHJOKjyYZG?=
 =?us-ascii?Q?Wr1SNKPxJV5uek8g5tII0OYjJESNvDLWlIGOGNQtASoIWV454uQW9AgJim4Q?=
 =?us-ascii?Q?g5/bOmPbzdvyHgT6gANnIeaq3vSfszjDX/PC6Tpj30Q9Zc6v/Zd3Uyyk//50?=
 =?us-ascii?Q?SSzsjnIPZbfVhQMLwJs85iM65oEMjF9ro2bUs1n/SoDv+cCOIwuE+lQ4AJQo?=
 =?us-ascii?Q?GD2MznZmgCu+ylq57RlUiWiayChOFfaJ4XBu6dvIitrgJMNwqPe2xqX0lbhB?=
 =?us-ascii?Q?GLt3GBcS9iib9EjQTIKUsYluDU7uLlf+yMnRI7huQl4ZHw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5FFF4DDA54C2D4BB3A07588A2BEF0FB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ec5949-f276-4fd5-4a5e-08d9607dc8ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 06:19:20.6798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ifvv82DSfZ4fBsrJ5HjXwkqoJFrjrKzFmM7HSQJTnSzr7G3OtqTuHXscNT14ZTiYAg6/SEh48P0zj02UNhgxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8359
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 15, 2021 at 11:20:07PM +0800, Eryu Guan wrote:
> On Thu, Aug 12, 2021 at 12:12:32AM +0900, Naohiro Aota wrote:
> > Modify generic tests to require non-zoned block device
> >=20
> > generic/108 is disabled on zoned block device because the LVM device no=
t
> > always aligned to the zone boundary.
> >=20
> > generic/471 is disabled because we cannot enable NoCoW on zoned btrfs.
> >=20
> > generic/570 is disabled because swap file which require nocow is not us=
able
> > on zoned btrfs.
> >=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  tests/generic/108 | 1 +
> >  tests/generic/471 | 1 +
> >  tests/generic/570 | 1 +
> >  3 files changed, 3 insertions(+)
> >=20
> > diff --git a/tests/generic/108 b/tests/generic/108
> > index 7dd426c19030..b51bce9f9bce 100755
> > --- a/tests/generic/108
> > +++ b/tests/generic/108
> > @@ -35,6 +35,7 @@ _require_scratch_nocheck
> >  _require_block_device $SCRATCH_DEV
> >  _require_scsi_debug
> >  _require_command "$LVM_PROG" lvm
> > +_require_non_zoned_device $SCRATCH_DEV
>=20
> I think in generic/108 and generic/570 we should only check zoned device
> if FSTYP is btrfs in in generic/471. And also need comments to explain
> the reason to do so.

Hmm, I don't think the FSTYP restriction is neccesary for generic/108
and generic/570.

Generic/108 won't work on zoned devices regardless of file system
type, because it tries to create LVM on SCRATCH_DEV.

Also, generic/570 tries to create swap directly on SCRATCH_DEV. So, no
file system code is related here. And, swap cannot be work on zoned
devices, because it will do random write IOs. My commit log was
misleading on this point.

I'll add comments anyway.

> Thanks,
> Eryu
>=20
> > =20
> >  lvname=3Dlv_$seq
> >  vgname=3Dvg_$seq
> > diff --git a/tests/generic/471 b/tests/generic/471
> > index dab06f3a315c..66b7d6946a9f 100755
> > --- a/tests/generic/471
> > +++ b/tests/generic/471
> > @@ -37,6 +37,7 @@ mkdir $testdir
> >  # all filesystems, use a NOCOW file on btrfs.
> >  if [ $FSTYP =3D=3D "btrfs" ]; then
> >  	_require_chattr C
> > +	_require_non_zoned_device $TEST_DEV
> >  	touch $testdir/f1
> >  	$CHATTR_PROG +C $testdir/f1
> >  fi
> > diff --git a/tests/generic/570 b/tests/generic/570
> > index 7d03acfe3c44..71928f0ac980 100755
> > --- a/tests/generic/570
> > +++ b/tests/generic/570
> > @@ -25,6 +25,7 @@ _supported_fs generic
> >  _require_test_program swapon
> >  _require_scratch_nocheck
> >  _require_block_device $SCRATCH_DEV
> > +_require_non_zoned_device "$SCRATCH_DEV"
> >  test -e /dev/snapshot && _notrun "userspace hibernation to swap is ena=
bled"
> > =20
> >  $MKSWAP_PROG "$SCRATCH_DEV" >> $seqres.full
> > --=20
> > 2.32.0=

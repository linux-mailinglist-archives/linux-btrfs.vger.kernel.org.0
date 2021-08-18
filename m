Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3336C3EF83E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 04:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhHRCwG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 22:52:06 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13556 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbhHRCwE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 22:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629255090; x=1660791090;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sdjJzTcq5+AwyjCP9mkC+BFsvLj7jPAZC6YT8Yv1/g8=;
  b=D423b/EQ4+IYimwK/tSCy4blacMak0Z22p7bOB2xYC/d+Gp3exRlaKbr
   6Ad1t08HwiNLPdmXdME3M58SoehiQAALUX4wOL8lFNC4KiCK/mi1AXcrT
   uPUv776FLsPCk5mpPrKPJVfzVqenEB5sU0Ts+GOKj4loKKKol9WTg/ai/
   KkbrbaFCyPfkUDcVgOKrPT6lBdysrhSqUSnQh5xz0dQYxzBRTFBUx4XRM
   ntj6eVeeh7P96dhIMrzSqzBxFa9y7CT7Tkjgtsb7va2a2iwit/2HarBH9
   T2mupXoFfdMVzqHeWpVsGDVJ0BW9JBgauzn3RG3E25thdJjYpQZ8Hsk0U
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,330,1620662400"; 
   d="scan'208";a="178163653"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2021 10:51:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsJdhMCtNlC9ffjqve4uTmK61uj1iXCemNNfQ5Se3f5Ohj4RJFqhL4LjKVmYz6n/px9fmVXVGp22nbBYcEm8jG3XH+flFWvTcOK+PgiHE7HWrF0vDI9OZHu7hA4J4HQuKL7g1vaS1OV90Uv9GQoVw2A/jfIAvKWPDSz/nR8WmnJo3JmL0vyL7i6xZYP9CpubkgJY208VxWJmBsWiRyg6Pof/wdbRwm35QQydNoX/YKWNxG57XKqwD3MFtizJMS+pNok1TMocZRjJWbshpkMTPPGW5cQlA+wnJ9yf9Xx0HKZbIQiMPBNU8Kr/Z+sm1fOu+0bxx7fDPPhnDXIExtCEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9/E0eFqhbAm3Hqa7pBh7ieAsRJb0ZHzf20Yc8JOqMI=;
 b=IRKBhIS/VabNftDTFdNXeeE9aYoel+MhM0YTA8V2T5moeDaK7eoGHuDad2HaJM2ronvFJBYp4aLUe1/IYs/WMCT/cZ7p0JgLCiXe1mw7pXmxa4vmOV13m+0C2V4Plwmwv3TPZ4CCKVNNJYTBk0L7MTrPxVtmtsIk2peohPDGQOnZtZXJAkAFpDGtkfLjXDlcIYJGUFP5NmP7pZwqqmThfvntHyH/mEgcHraQ1CjQbXRAUwsgAM+KlHyn6BENedDET9mu6xaClwrDvuIpdqYD+qOMpJdukN2ELmYwi6LWIJSEreeYDp1LIk88XC/JE/R+01oHkC6FJykCbiy1QZbJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9/E0eFqhbAm3Hqa7pBh7ieAsRJb0ZHzf20Yc8JOqMI=;
 b=riqQIxFJbbIUUSBUE2UjnZQjr0IQvLwg3n9rQHXvw/yFlaZN0WPytt5uTJdwTe+M27crEk9Um0BQtTkFlHt80ATbEbaG2eJTvCROZTXRHoLFidjuqozooPO+K4fVlmC3B9QBG+FeO813nn+M0t3JcZkO4QPYLojBuO8c0nOeg4A=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8421.namprd04.prod.outlook.com (2603:10b6:a03:3d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.22; Wed, 18 Aug
 2021 02:51:28 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b%6]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 02:51:28 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] common: add zoned block device checks
Thread-Topic: [PATCH v3 1/3] common: add zoned block device checks
Thread-Index: AQHXkpLLlfmHMqGM2UiXRawIJPVchat4YswAgAAv74A=
Date:   Wed, 18 Aug 2021 02:51:27 +0000
Message-ID: <20210818025127.f7et3krwhf3tqya6@naota-xeon>
References: <20210816113510.911606-1-naohiro.aota@wdc.com>
 <20210816113510.911606-2-naohiro.aota@wdc.com>
 <20210817235954.GA12612@magnolia>
In-Reply-To: <20210817235954.GA12612@magnolia>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7390537-b187-4db9-4f4e-08d961f31372
x-ms-traffictypediagnostic: SJ0PR04MB8421:
x-microsoft-antispam-prvs: <SJ0PR04MB84210D9198F488830FC0D7098CFF9@SJ0PR04MB8421.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4kLR0QTANECIEEYcbiLW49ZhC3+/FQDETZ9Rg36gjbsw1gnIeMYysecAAb0Tzc/6SxzZQi3BFIBB9oIMrwVWiEFdHyyadVbvhSe2Oh1Eh6/2y/BlNPT7pVJGAnxqNXHUT1mvCSFsT+WqGAXy0yh8nMdGtp5eR45WGAHU1nczvnPIso2E2sBUg5Mem0ZdTVyngHnePJkARg0C27GVlM6mZsMXc1WqywQ0QSfiaokJgE1AXzccFyExnal7fHixSkClXxvgudmQhoASP19Qk50LWYfBc7qtACfjqeRdKnanapeYCX7vlqbEqeITCFEowiOpwr4O5ZnGYvh3qH3i5SbkyHRAbH58p0dGOX7wF1qDRdYGcBHH/GJ9AyguWT1QOKOp61RAIWq7O5zxTTUpdW5KZ8FMiJ9VDlUoWbqOJLCApQ9GCsW+kYcQbjk+qHuY6F9BFNtiHc/kIV0STRzN4XV0+a8QmMkENedl7ETUz1uKrGWemx8TbXWq8Kk1NWzhVlko2aydvPOxRbNVOc+SqGRJ6tfCaHGpWgTkDSQFU9PLM7EO3s4P0GCTcVRO2siufsyPgs8PjjTpmh0j42IzIV6GWjoAbWR98KPdKg/zTA1dffmHW+QG2Vx4erGkcNkFtNjdERfC8L6QRv73556goG3GKmqT8uJuCUCHm5ev72sKsZDxnr2yDN/SeZ1T+Is97QMEnBkHB1IYWAygZhPUqiWuQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(8676002)(66946007)(66446008)(8936002)(66476007)(76116006)(64756008)(2906002)(38070700005)(66556008)(6916009)(6512007)(9686003)(316002)(6506007)(33716001)(6486002)(54906003)(4326008)(508600001)(5660300002)(91956017)(38100700002)(83380400001)(186003)(71200400001)(122000001)(86362001)(1076003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XsbYc59Esi/qSBv6fTEeYux5YSFFUjU/QZ72EtF6Bn8IN7iiwgwhuBKr9K+x?=
 =?us-ascii?Q?y8cUGnLumek6+AZFyQBbdF3eqfj0evUeyN+N3v1xVZQajTgqFtxtFISDxLS+?=
 =?us-ascii?Q?hH+ZcQMVwxLHOD8mBqwYVpP66ku8zvtUSVUgLsJZ7dduJLWQJo1Z1I/Zomef?=
 =?us-ascii?Q?MTVOdkB2FSOhHxL49jQJ+eWJ+xvsC+sFcA1cQkK/zd5vIuCvgndbNrgV2D7+?=
 =?us-ascii?Q?dIT3dLWAhp0aVluxjSw2R0LB2kK6aoImI43GmCSjVez2rVakHqLGmnLfn+Zw?=
 =?us-ascii?Q?tbfAzjCOLe4TOBH8hH40qHQrTSJrhpx462gsqDDenXK5Kf99QbFJ0Q7l1MeH?=
 =?us-ascii?Q?Cdi8W6VWSMFK51f2YsmbzyT+/UufxpDyv40CZfdFXqnPYwCHpdpQUKyDBS82?=
 =?us-ascii?Q?AsCN0YcMRZPlwIp5luN7ugaux1DHAL7CWXO4O/CbpyFJbTg8QRbm5MfAShQC?=
 =?us-ascii?Q?/oWRv4FtT8NulYPfNr0hhZRI2MgKxp1XIjfBt1R3etBj3xGFgquCEmLREnXX?=
 =?us-ascii?Q?DfmvNPsTFzMdF3F0qlKt9JERb8BGF7BxIDBVokPo4/cjoJ3sA1esytCBINOJ?=
 =?us-ascii?Q?mRK18158VCHvwc9FfJ5wpR2/zsOAbE5UX0tJVfuyq3LlpFORkTlMsra9OF+X?=
 =?us-ascii?Q?TC6hOQZ701qZaVCKKFvi4bhb3hEWs4ms2xMyFK7JjgR8Gl0/yiW3t9xVTAJY?=
 =?us-ascii?Q?0GxQx8KB76sh8hAR2EIS74LovkdlLj3HfVfGRvByVUPal/V11LayLWFREOKR?=
 =?us-ascii?Q?R9UhodxiuBEbGr9BFmUpOI0aBLIcfOl154QYvq9YWzga7DZ7zEAhDcrnAgSv?=
 =?us-ascii?Q?FsNs49FQIHfeS//ZoqjYNoz+5WSx2ARY5GrYyV5qXp72Lh0+7BkO/dfbHkaM?=
 =?us-ascii?Q?gHunQf4RIqWvMt9d2DvTKENpMRSrlUEOucEwP0BCu4IZ34cAsop1U0VeuDM2?=
 =?us-ascii?Q?vRXPWAVaptEGf4Ln8rMpkIRfMkJPgfjxIIUiHmMiE7m5tosXvZD+iqoUKBEn?=
 =?us-ascii?Q?fKnXeO6pyYyf2Q15iguFFquWWDlX99dcryEmqi2JNxSWUYWQ/Jt1B7SAIfH8?=
 =?us-ascii?Q?lmLWEgobirYpd9EKZ3yFMa28y6WlfnjEAfdBMggukMN5HPiWRxBIUqOimPmS?=
 =?us-ascii?Q?UqSp5INn73ZbPiq52YjQlF2e6atU8kGKzaH/ZXUwUv0QY0kZCOjoGIfFdHDC?=
 =?us-ascii?Q?186ZzchaaP0i38KW3uwmmgEhjbyqgRJ+kI/IHoD4MUXxuYNLuvOCQRLUOoCU?=
 =?us-ascii?Q?Cp0DCichYcgmNqNSTeRmWTmIiZZHy3OVxhX9Xu4XCoM1iiiVzyQMrk09P3kI?=
 =?us-ascii?Q?nbDDmw0lryBtnE7Gr+oRNuoIzR+hAb+sMBtFvI4U5mGeyQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <78C20272AC34E74DB13C0F9C832CDD1B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7390537-b187-4db9-4f4e-08d961f31372
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 02:51:27.9915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: is7F3IXCnU+XuZb7usBwZ07kHfrsun6S3e9Y43pKcpkMJe/pLFsxYOiqoBHjTG4MYh5nl/aeUQpyA1dC0hhGIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8421
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 17, 2021 at 04:59:54PM -0700, Darrick J. Wong wrote:
> On Mon, Aug 16, 2021 at 08:35:08PM +0900, Naohiro Aota wrote:
> > dm-error and dm-snapshot does not have DM_TARGET_ZONED_HM nor
> > DM_TARGET_MIXED_ZONED_MODEL feature and does not implement
> > .report_zones(). So, it cannot pass the zone information from the down
> > layer (zoned device) to the upper layer.
> >=20
> > Loop device also cannot pass the zone information.
> >=20
> > This patch requires non-zoned block device for the tests using these
> > ones.
> >=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  common/rc | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >=20
> > diff --git a/common/rc b/common/rc
> > index 84757fc1755e..e0b6d50854c6 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1837,6 +1837,9 @@ _require_loop()
> >      else
> >  	_notrun "This test requires loopback device support"
> >      fi
> > +
> > +    # loop device does not handle zone information
> > +    _require_non_zoned_device ${TEST_DEV}
>=20
> Is this true of loop devices sitting on top of zoned block devices?

True. For example, with setting up a loop device on a zoned device
(/dev/nullb1).

$ sudo losetup -l           =20
NAME       SIZELIMIT OFFSET AUTOCLEAR RO BACK-FILE   DIO LOG-SEC
/dev/loop0         0      0         0  0 /dev/nullb1   0     512

We see "nulb1" as a zoned devcie (host-managed), but loop0 as a
non-zoned device.

$ lsblk -z /dev/loop0 /dev/nullb1
NAME   ZONED
loop0  none
nullb1 host-managed

> If so, then the rest looks good to me.
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks.

> --D
>=20
> >  }
> > =20
> >  # this test requires kernel support for a secondary filesystem
> > @@ -1966,6 +1969,16 @@ _require_dm_target()
> >  	if [ $? -ne 0 ]; then
> >  		_notrun "This test requires dm $target support"
> >  	fi
> > +
> > +	# dm-error cannot handle the zone information
> > +	#
> > +	# dm-snapshot and dm-thin-pool cannot ensure sequential writes on
> > +	# the backing device
> > +	case $target in
> > +	error|snapshot|thin-pool)
> > +		_require_non_zoned_device ${SCRATCH_DEV}
> > +		;;
> > +	esac
> >  }
> > =20
> >  _zone_type()
> > --=20
> > 2.32.0
> > =

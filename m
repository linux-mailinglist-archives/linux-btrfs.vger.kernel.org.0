Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BBC3ECE6B
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Aug 2021 08:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhHPGII (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 02:08:08 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:17926 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbhHPGH2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 02:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629094017; x=1660630017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=y9XLj5gbGW2nTNMRYSKrY7tuDNti3fEwcG59ZYfRVSI=;
  b=Ut8eLNdrkEnfwpUgcvrqvOyGKlJmVxRrv8PNEMI0g94AORDkEp+scL2m
   aX67bht2/wcWyWyVUoyQ/WF8CNXfn6gUwmQNwt5HBPOTWotTwdGiNAvp0
   duJOhnweq3cYfRcPLS9eTcq9nGwOVMVuMCQKeHbxjHwa1UZPiYjGpUvNu
   ACgWux0DaN04rMcUPXsnQR4sIqMbspu8F638f8ZAkm57BIiEsS2U4Qi5a
   j7HU3rOCTluRbHl6HabiRHPQcUBujR8r/0H7qEbcLpRrM6kVouUwziXE7
   y5Yxaqm5/dU1yh/DjNR+HmbWmsDEcRYemCiiDH2PWklrLLx1QyrDlUArp
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,324,1620662400"; 
   d="scan'208";a="288926952"
Received: from mail-mw2nam08lp2174.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.174])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2021 14:06:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4p1LruHMGkpm4XZLU754OirYCTqIuSDulYhflNg87xRX76fo9KagV2ifxOYko7DVSNdfoK91taRAkkPF06rbSidow2SE7ZBG5UMMeiPtAgNkGX2+eLVFDvbm7FYuTLwEbzi4Nkb3Al6w8h6f+D9DmQAIi0cntpKq7nLX7n9OIzoTyqukuhKt2lyV4uyjSBZVUkZvaItA9Jg7b9+dvMSrO0N/ENHVoMN+d1+ytzV9UXH93bg/dz4uiFIstMx6tDHtKBdyyjB1151yHIWaXAMGCZq2dPY/zXRnyH01Y/0tOG2pcLX+kluuUsRc2tjS/k/rzxmBtRqlHY35B5Lx4Kosg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3EpmysbYrb5Rf1rfHUGoTHUcO3eAOAycfXKjRRL570=;
 b=GPSnLQLf+U5NPod4cIp1JrFdz0uSwNiOfI2mI2+ii/akypErCisrj94UOyaeGNuDeT53ONLFqkitiMuwNki9QiClGAI1RVdvbzLjpI0CJ8KlwfG7q+Fndx8QIQRChpP+ShHuS6zq8MdQg0mxCnXHK8GDgYiiSD4I0Wk3O/xtfd2JZCZ7kqm7DXoMrVX7nWFpNc8MVm5AacAS4vLhMZJ7mTX4ltdwH668W9nI1m4HORMOjntUj0Lv2ANi7qKSlYqsAE6/dgh0yBPuY2b5+wWliISFcYp8e86whBc1guQWsB3ITLjsotg3UaEVuXvtgFzL7Cy1TmPaOLAT74sNIpImMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3EpmysbYrb5Rf1rfHUGoTHUcO3eAOAycfXKjRRL570=;
 b=GOsPHPi2t4zC7oVsSMqAb3mICwpLMZ9zd1HbRDH8a0SWChf37cWNle9lprLO6sJQLDUNc12czZV5PLvy6Q7drsxa4+5GCD5PevuHFo7wibuoErHQru/cWNGRvp5Sx5aoNjxkZipwxl+/cYOGrYaF5XUw/0uXeMCkB3p2pHxdw6A=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8376.namprd04.prod.outlook.com (2603:10b6:a03:3d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Mon, 16 Aug
 2021 06:06:50 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b%6]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 06:06:50 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Eryu Guan <guan@eryu.me>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 5/8] common: add zoned block device checks
Thread-Topic: [PATCH v2 5/8] common: add zoned block device checks
Thread-Index: AQHXjsNjims4RDIp2kCN7bDTZTcH6at0qhgAgAECLwA=
Date:   Mon, 16 Aug 2021 06:06:50 +0000
Message-ID: <20210816060650.t42isw3iljbc2j2j@naota-xeon>
References: <20210811151232.3713733-1-naohiro.aota@wdc.com>
 <20210811151232.3713733-6-naohiro.aota@wdc.com> <YRkn5uj9Yp/W3hYF@desktop>
In-Reply-To: <YRkn5uj9Yp/W3hYF@desktop>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: eryu.me; dkim=none (message not signed)
 header.d=none;eryu.me; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 895c4408-c027-4c25-5c90-08d9607c09d5
x-ms-traffictypediagnostic: SJ0PR04MB8376:
x-microsoft-antispam-prvs: <SJ0PR04MB83764E74E5CA91110679169B8CFD9@SJ0PR04MB8376.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XJ4BZgYRZgcEAzZxsxhBdXhzbNaxHZbOsnReSaBVX8qcLMGcj5g7+bOPtoxb91CBoZtuadxHlhEWRN2k6ScK7oDfdydO1Zzb5h/No5LavdEMKQo4/dQz30/BNRuZUVWdgryUPSXRNM1ye4j+lllrvBIq4k9m8iB8K1AsmNsTYNeBjajJewqpietmTnQ3pJRu4jGbXuIR1IrGQDZSQftc48kdMJTXKfdnyl/RzQNNInnhbmT8lvn2kODC6fzyRJhzDe+zjGPvs9SjkERHcHk0a6kOLF2svk2VI9e7n00F4t6DGQ+KZFuKRrkJvD7kiXIDRSHGdMx3NEZm/c1lwKuSBLNo8hNE6B13u1PcHuXUmV+Gs97sTpNJEn5G7ubSH0nXKM6mLr9ryOS2s1SehOGSno2RKDeXHSvH4dTDgZjPQwJTR+eAZewdAgdvJhU6S7Xtflb378usO7xvWF5grLiooc6cWx3BSPQIHhiwpI7bQVWaNuLaVaQT+xNaANTK79Zv+jUgCCoKN06ucp9aD4Qyb/LiIh4acXnoK6PLInjt05tg97xuRObRlF9kJR7IaBWKz2Bk+dzWiEdSzVvfvJ7QQrJ9yl5WGSxHDh5fw8+6b34vO9V+6YAMeW0ePvaovDBlj3qyfbEPjRTDMSW/ZqcpJgJGgFxsxEO7iiCzmO1QIom1IwZgnWv2RZ43iTtRjuLU29gvUbTJRnkPpy9832cB/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(26005)(6512007)(9686003)(2906002)(1076003)(8676002)(33716001)(66556008)(66476007)(64756008)(186003)(66446008)(4326008)(71200400001)(76116006)(66946007)(8936002)(91956017)(6916009)(54906003)(86362001)(478600001)(38100700002)(6486002)(6506007)(83380400001)(5660300002)(122000001)(316002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fzQ28tBT/kUlzhEKdYiWkW8b/4ZLv7uazmmm1KsKTskm7MLt5qxweX2WvDFr?=
 =?us-ascii?Q?tAmKhqM0f7nOEpF4ILZoOOg6KavW5lC9XV3YNVN0jXejNOEBi6lGCHeaDb0e?=
 =?us-ascii?Q?PEVySt3N3B6M9FXqRGiSEB5sjfcf8dJ05CvohwI0AhR/nPby67jTF4qdOFz+?=
 =?us-ascii?Q?p8ntG5JuDMlj3392jJreDABlvBhqzKB++DxSN3dsINXWipwUJslNxD0zMxVF?=
 =?us-ascii?Q?4tQUHqCkNTdQicM2bkHv/QoIxldhKSCQswdU6m7FFIyVZvA5HGzokdeRTNjk?=
 =?us-ascii?Q?WtmAqpXrlH1ZJDsUG9HLM+kghuXsY33aC2VNtUTIi47cV+NmjfWZtBX+spQg?=
 =?us-ascii?Q?0Cx6e0ZQcr+mvMlGtfaNzcsNk3JVF0xrBkyDjALacya4fIMcbnRUk1czJ0mB?=
 =?us-ascii?Q?VFg/SkDKyJiG38rwfXjv3G7rtJ0o2i+TPZc7Ib/hfqNzjo8xgvtOiAu0BaPQ?=
 =?us-ascii?Q?hFECbJxtz12cKAv2xfQTH9Gn0sa8YpMb+HYj60jzt0sjuXdXQLzfBDRxxxwE?=
 =?us-ascii?Q?Dyu0I+HS60mgIsFMfFplaCqo42tOt+4LDvzjc3WUbbz+LXG3yvOi1fyrpaWs?=
 =?us-ascii?Q?j3CiSxrYwL2ZRq5U1526bnk7vUYiHjNLVjmirfeoVzZer63Ug8Ha+pMJdZK3?=
 =?us-ascii?Q?bdZp3nU2yjahy89jiJDczN7vtUw/6/hUCx/TVs/v78JDgsD/JpqWcDQma7tY?=
 =?us-ascii?Q?yOibRl7b0pK/83cfZnY32HyrkiFK4ZmGGrKUeM85F9Dc8mOY6nScOtgHyave?=
 =?us-ascii?Q?5bWET9rqk3diCbgbSKF6nRlzATwJQiVR9ZPkqpI2BSXO3wep13oG/eq5/hnD?=
 =?us-ascii?Q?k2inG9Z0uwUM88Z9wTGkROX9lueGuttUFUE2XNh0Uh1wp2ISwhG5DqlZR0cJ?=
 =?us-ascii?Q?zHwg9inik2Xzl5NnWj0N2jCssMk2IpCiTFj1k6mTeEaSzO59oiyMmj6wuPvX?=
 =?us-ascii?Q?R8VMgdM6crrNUvUt81OTxzvlPnqh86OsLueLlyYjHYrDJEvd4eZWsrPL7UEA?=
 =?us-ascii?Q?mBnbeXyz+1C56+qtfGw+ksaIlhmaUx5BW5PJNzZeAlfKX5O5VKYuaLh9uTEk?=
 =?us-ascii?Q?AdPP/Z0ZXWr6p/7bSL4VTKDTcPjoPVLvJkniwWN/sDHwdJ03G0JkDeZUrXmt?=
 =?us-ascii?Q?HK7Q0i20DcHk3X6lwUoh6DhqFAU4dFxX3iM2cNNa9NubHd0wKWkM3xSHp2j2?=
 =?us-ascii?Q?xHA9WWzi/BXG6a4q/I5sDIMSZDSqPGJt/sQB0DfXSZJJJKynLSsXAhf9Stbd?=
 =?us-ascii?Q?s9zFGDKRjAJsp/bFzir5Y1BmXH4LYRT2YtBFA3tk02BuDNWSw7R066wDx3jh?=
 =?us-ascii?Q?8eA0wV515YtYGrMK4hkqry1F5y+zmE2lUR+ecHGofRMEbQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FFE9CA6874BD7A49BC46A22B6F98157A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895c4408-c027-4c25-5c90-08d9607c09d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 06:06:50.5739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pHZUu7v2LAo76qwQ9E+9jMGQGnjiq+XYCEbTgXkA+5V+RjDvvbds1bZHhIDwDnQZdng67CU1oR9nwahRrv9C9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8376
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 15, 2021 at 10:42:46PM +0800, Eryu Guan wrote:
> On Thu, Aug 12, 2021 at 12:12:29AM +0900, Naohiro Aota wrote:
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
> >  common/dmerror    | 3 +++
> >  common/dmhugedisk | 3 +++
> >  common/rc         | 7 +++++++
> >  3 files changed, 13 insertions(+)
> >=20
> > diff --git a/common/dmerror b/common/dmerror
> > index 01a4c8b5e52d..64ee78d85b95 100644
> > --- a/common/dmerror
> > +++ b/common/dmerror
> > @@ -15,6 +15,9 @@ _dmerror_setup()
> >  	export DMLINEAR_TABLE=3D"0 $blk_dev_size linear $dm_backing_dev 0"
> > =20
> >  	export DMERROR_TABLE=3D"0 $blk_dev_size error $dm_backing_dev 0"
> > +
> > +	# dm-error cannot handle zone information
> > +	_require_non_zoned_device "${dm_backing_dev}"
>=20
> We should really do the check in _require rules not in _setup()
> functions. Please see below.
>=20
> >  }
> > =20
> >  _dmerror_init()
> > diff --git a/common/dmhugedisk b/common/dmhugedisk
> > index 502f0243772d..715f95efde29 100644
> > --- a/common/dmhugedisk
> > +++ b/common/dmhugedisk
> > @@ -16,6 +16,9 @@ _dmhugedisk_init()
> >  	local dm_backing_dev=3D$SCRATCH_DEV
> >  	local chunk_size=3D"$2"
> > =20
> > +	# We cannot ensure sequential writes on the backing device
> > +	_require_non_zoned_device $dm_backing_dev
> > +
> >  	if [ -z "$chunk_size" ]; then
> >  		chunk_size=3D512
> >  	fi
> > diff --git a/common/rc b/common/rc
> > index 7b80820ff680..03b7e0310a84 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -1837,6 +1837,9 @@ _require_loop()
> >      else
> >  	_notrun "This test requires loopback device support"
> >      fi
> > +
> > +    # loop device does not handle zone information
> > +    _require_non_zoned_device ${TEST_DEV}
> >  }
> > =20
> >  # this test requires kernel support for a secondary filesystem
> > @@ -1966,6 +1969,10 @@ _require_dm_target()
> >  	if [ $? -ne 0 ]; then
> >  		_notrun "This test requires dm $target support"
> >  	fi
> > +
> > +	if [ $target =3D thin-pool ]; then
> > +		_require_non_zoned_device ${SCRATCH_DEV}
> > +	fi
>=20
> I think we could move all check here, based on $target, e.g.
>=20
> 	case $target in
> 	thin-pool|error|snapshot)
> 		_require_non_zoned_device ${SCRATCH_DEV}
> 		;;
> 	esac

I see. It looks far better. I'll do so.

> Thanks,
> Eryu
>=20
> >  }
> > =20
> >  _zone_type()
> > --=20
> > 2.32.0=

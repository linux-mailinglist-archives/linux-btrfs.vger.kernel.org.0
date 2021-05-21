Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA26038CFFC
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 23:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhEUVjO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 17:39:14 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56498 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhEUVjN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 17:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621633069; x=1653169069;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5rGZ2fuDWDw7hzCoQKYXjVmez/4rltT6j+/0uXyd2hs=;
  b=dz5C4ueCzkjvDNmYID5LYekpYc6h21SovFGS2l1M8aO/oa3H1yuy6j0f
   sTPvJaeCYA+N4vCNvQT9KECVJzzTmBOo7aeN52dQUee+RBvoC4mi3UWQk
   b9HgDwO8n5wHYUbgZpx+hzuYRQOQBzTIMqwQo3PvG9Nox7Hin682iaHfc
   WQ9eJHuS6ZPt67JtseGeQMThwZtIqYxr+mK0OlU5brBNuvVqPTi/7kEwV
   /xRtfBp7FIRMJZV+LIfCNDVzZ9C+lpFAHfT1vZPrzCMFoeYNQ/fz+xHW7
   SKnms2z9Jns6zRYY9QyL61ueHHEnSlleV8KOx0iU5wOPbcjWKkIx4BS+x
   Q==;
IronPort-SDR: 5e1d4FdS73JOE9hvxlM4B1I/4e0ejUN1PrPOTuyKGevMV5lJUft77S2GWThkY7wBaXZkDlSm9k
 ZDfxRP/ad8Npjjv6fhVGrL44/blhIFRADi8DwS3IEPVeTQ2rXW0HHCcx09zttDoB5rpsUbk6Uj
 /gYJWl3v9511bWo9sI1VfaNC0wIwOW+2Sa0w8XkQcI+Avt5LwvW5HqutgccBXZAQdrcleOW1S5
 ieQXzN21fpe6lFQAQvO7ncYHc2bi0YrTf4TMSJerkgCHAVtUYIoWlAq0m8mAbt/KEipj7HzzyO
 8qY=
X-IronPort-AV: E=Sophos;i="5.82,319,1613404800"; 
   d="scan'208";a="169048317"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2021 05:37:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/VK5xdIZxR476F+gohQxaUwkiuEqjcWPWKJ5BKtV30RPJZgMkcAETI2C7Q9y+rsu7L4ySeZX+Sq5se9Oa582JfFTeF5stfMkbUV0aLRtt70RAyOSAGl7lw8erp26T03oTV9FSMNgNzREyzrsmNmgOWVVVcGyacAqXFZNTM/J8zsEdhUMDk+byip9yRBD8wsPvSOudyQtbouHX0cbfcPlouPhzx5c2dIwnx9fe8dT0gYEADRs+TfRSj1jodp1qB2uokz2/x53ICPfwlQvtdFFKN1QfXpzULNa8Mh+oOsFP6M7xrAgmqDleKLHU+nGHRiinZa+vpMgOuG3hSg4tWtng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rGZ2fuDWDw7hzCoQKYXjVmez/4rltT6j+/0uXyd2hs=;
 b=FTKgTzLiYk9uKCCQDaeXjFNSSXPMKOmuPM/souvctvfS7rcuacKu0L6229s2mLpAfLiUThZck/QlJJIsgbhQaBmdvxaZDdvTM2GHRTUKMjdKEL3Y4gVbXPeS+JjQ5fTXSkeZOw6nA1qr+0b5m+jH/PiL5uVIv3klVpspXFbSN61y0V0Kn1S022TNmLugCckIDDvQd7KbFKZSbbjaOaxkdv0v9D0iH+eD5WRRLGygUJwGA01jQSuv9L38w0hpP9GAOWyTZfj339slzfIE4Ot/cS0VVD4JjWLW32cXfp/Duq4t5h9Abk6ghnRzLzJojKJoHewwQdIqVCLHdGc/guExIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rGZ2fuDWDw7hzCoQKYXjVmez/4rltT6j+/0uXyd2hs=;
 b=IgC+TGDDuG5SfrzgaNyEd7W49wKC7mNShet8uRFd3Dl+miIlb9+//ML7SzKPdaTrB6MYOEzqrDuV3ZwmYtVDu3sqS9GLsL5XXgqM9TzoFqeCTEoebkXXT0BF35JXcaTwmDf1RPdo3wKHtvbVjc0ipBo9PuRAy/VreDRmrkjaFFA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6584.namprd04.prod.outlook.com (2603:10b6:a03:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 21:37:43 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 21:37:43 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Thread-Topic: [RFC PATCH 0/8] block: fix bio_add_XXX_page() return type
Thread-Index: AQHXTUCZbkdV5W8mbU+6O2TFfy2HFA==
Date:   Fri, 21 May 2021 21:37:43 +0000
Message-ID: <BYAPR04MB496577D8AC414B1FFD44722486299@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210520062255.4908-1-chaitanya.kulkarni@wdc.com>
 <PH0PR04MB74169D71E3DCB347DFCBFCB59B299@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1111a66-8af0-4877-fadb-08d91ca0aaa9
x-ms-traffictypediagnostic: BY5PR04MB6584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6584C5DCD38BC8F46161501C86299@BY5PR04MB6584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zlG+dYzRoToioy656WOx/BGMC5I1IdpcDO/zBr4jpA6H3gujp9arzQLTb4FCE0IJ0AMjIPnvTckfXvtUsLOftoBiBHa6xnfyjUfDFrnOwQlueW3I5TCH+JZetADZyxMOhocuW1CLNLGDjNr+Ytxaf6DawKLELxZjVG9SLxmMqA1tZhEv5CWqbgLJMq1JXzUIQbc3OJTRe4D7YYNFePwvm162U+qdc6vRy+h4NNj0vt81PAZwxdYGcBQEHDnwhCzt1prpMBpuIRLYW4PEw6fL/qI7qflYXYD6dsc08W1ZnCgGjRnbJuhRZlQO7wni45/oxW5Y82kOhBs1isHkhZxGnU+kZnzhcVGfSTqrvfEBfJjgQhUwekWhKGJq3e+GnRKqidi06TBYiNKSj9NotKFh4bS3n11bNzi6Rkl1OmGqw5WKiAURIsdWmlM306Mi0SrlegZWXCe/peGnkEAqjugWJX5DjIeEJ+K7oqKN7rIok6aB1nbOZ8wEq6AobgRmnJKKRcwpesM73sW6jHDUiGuLHQnq+PjLsy47MJG7e4lfsPLr5xSXxyseuJa1t8tDxrpwyZ7zR/9h0HZbuOiBzpHoOhmCScT75x8v2j/9D4Q1lcg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(366004)(136003)(346002)(376002)(66556008)(66476007)(64756008)(7696005)(66446008)(26005)(66946007)(55016002)(6636002)(86362001)(33656002)(2906002)(8936002)(53546011)(76116006)(6506007)(71200400001)(122000001)(5660300002)(7416002)(38100700002)(52536014)(6862004)(4326008)(316002)(9686003)(8676002)(478600001)(558084003)(186003)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YKjvSNnec8zy1b0aBytGDRmBigtlEL5AWPHOvE1nW1UAJrP9vYTULdm1+Y1L?=
 =?us-ascii?Q?sxbzrZP49het/BvKKAEahTp41d/S9hyH3922VH6Okm9MDW3phRKbeIAxTQMJ?=
 =?us-ascii?Q?Xo+0bHAQPEQuhUCWjgDU+mPwK+ynFc1ne4+F9TgtUtcjw/ohpBjtPu+6WCXf?=
 =?us-ascii?Q?yCoByQkceUa/LfljUDej9Xuf/xPfDx+42Xw+SmXOKgzu5t/VYm64x98YqgBQ?=
 =?us-ascii?Q?vK3wIBBTaRca/Pmms/pdi5y0ZEYqVLiJa/ZR4T16QrgGbbkif11FL2rxzaMk?=
 =?us-ascii?Q?aXsB2QoiDJ1LTnGZp1fUogABK3A/qZ/Z0fR6Y5jgZ7mYyf3cCpmlOJlM1zSB?=
 =?us-ascii?Q?cyB8DW1HRzX/UifkWmVPY6AT4XfzcXO4FWDAAZKO98HhHPfa2Hix2/wACPAd?=
 =?us-ascii?Q?+tKZZVaRJP6WBVS1M5mun3hWaqAdA1hcQ50rtaNd1mQYujL3GQRk+tZ7OEsx?=
 =?us-ascii?Q?+J8qeqND00Vdk5AC2+2wVw8+0StRtkzFQGd8DIQhQREitD1PMIFvLSmvqAJ+?=
 =?us-ascii?Q?whuUfrnqENfXDbHBsOgwpz2L3MrTlhwlEkm7hwIy/C9AmKy79RB+Oz+Amt3q?=
 =?us-ascii?Q?Wsxzilsy4RzxtMBUIe+3lOW8Y4uOx4dZcLuL++nTmcL3QrwCbAn/hS4T2sg6?=
 =?us-ascii?Q?TvHztzPkD/Fo/rc1oCsjV33OY54dvIruc6MpIlvL6+u4h06mdRRfJlaz8KvN?=
 =?us-ascii?Q?HxymjBnHtrqN2KsfzWMKBEsGJAKIvpC6gmNjOkQw1c1A70LCNXVlzZj76840?=
 =?us-ascii?Q?o8jMYCHIE8DVOmJA7B3mXsY+GJl9g+U6U9jFquUnqOrFMl0m/S0q88GiyXo1?=
 =?us-ascii?Q?FAJjzu5H2th5x6aEwrMbn2lqnCdzdX9i7WKgJ/s2iVgCjX00b/fqciCRW33U?=
 =?us-ascii?Q?lyJDem92TpuZ8Q0nS1PV9feFQF0Es+6i1Lj3uu8q7CbMlJuI3ltNZU81qqHl?=
 =?us-ascii?Q?a2DU7KK/X64iV7GbUrjfuZnwrUEo3J/Bp/hTKMKE6ni1XmBW8LZeC8soiZyw?=
 =?us-ascii?Q?e0UQBy22QVuJBYqUhq5xKSLet949WkSBdF2i6k3/3tClDfOnSG5esRAIUIiq?=
 =?us-ascii?Q?7Gjfpi8lSL0iCP11TWHkoOI8L70V5ydzeM/m2+YKPhOHLS0/+owpCfkc4+aY?=
 =?us-ascii?Q?eZh5el1DxWZKYnglCywKD0IY24LaBJcxqD2oNoACWrYOnTNUFpASZxpqoFiG?=
 =?us-ascii?Q?il30Nqv81t/LIkajONue3YYtfQXwbcbrXzB2VvOTqjbEqnIp4U0TIOvRZlZd?=
 =?us-ascii?Q?b0Hy8DJUwznsRXxCB49OOGSN69c2Pz+OkX4ZFlSW7oMLBJBTCosT4nVzGAf9?=
 =?us-ascii?Q?jXExqMPCxXoA9X5utiACv991?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1111a66-8af0-4877-fadb-08d91ca0aaa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 21:37:43.1498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CYwKC2sFgq0SqOD7hL74zJyWo1hhfp4FyRfqRD4Zy7qs+vnij4Ut3mN24hhHiUN7X+RZkzu5XnTt0Bc362y30utIlrROJN40vDQyqnDcWdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6584
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/21/21 03:25, Johannes Thumshirn wrote:=0A=
> I couldn't spot any errors, but I'm not sure it's worth the effort.=0A=
>=0A=
> If Jens decides to take it:=0A=
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>=0A=
=0A=
It does create confusion on the code level which can result in=0A=
invalid error checks.=0A=
=0A=
=0A=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79AE2294BA
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 11:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbgGVJUL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 05:20:11 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:52722 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVJUL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 05:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595409611; x=1626945611;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9S9JFW2mrfrAUzQ2jVOmz8AyBxBIGOaAnjIjIseORqk=;
  b=EWkCsfIExKMD5N/RQRCjKiG2EjuIsdsA/ohEVCBe/1s2ak/LW79pDKUy
   3cnGAHPlAB6S1HkhDIXyBvngIJymh/yupOUdrjwqtdeBG0BFGXTFtNxhy
   9nxAzsognnkGX8VJiHcpDH7xJUxFwUCPxBGvKSFd4fZkqbHTbYGzM6Ws0
   WpvecRgbOHMREbrfI9IScV6XZZb1Hy5yor2B/Qeu/WwMbe9R0b4JQYa0p
   j9/1Wh1ysza96kfhP00TExtw+I8P+ySe/w2NCPRNREV3fYA2C1DKCfsgs
   q+3AM/dvc28gZxK0FfNd85mLif+bCGCz6vGOOWJSz/ozdQTE0umZmDYjx
   A==;
IronPort-SDR: CN+bgB+S400bIZEJT5gVFcH9CWoC3u9WuvcyvntGKi26w3rA4rkUP/REVPFeb2YZOnIOFlc3f6
 Ai8VhCP6TgeN6sLdSli1zT0YNLw9CuNlGIsdrzDIPFCAAJ+T3BkBUVCXPv3ChGPcUpj8opyfYG
 lpbhknpJKSBTdVQDf6rtCjc+15ckf20kxC9O3tn5mJzbX3jL54Oo7+twx1paodpWY+CQ9c9Ie5
 aZL/0o0kA1x4BirnFH2Fph8KdkKrGHnjkpumnJDfeWYVro0Vd0YWbFGFZLskRF3CbYmVVEOL8o
 Aa0=
X-IronPort-AV: E=Sophos;i="5.75,381,1589212800"; 
   d="scan'208";a="147401963"
Received: from mail-bl2nam02lp2052.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.52])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 17:20:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHDikGc3aV8WX6Mv3yW0fDym0bGuxLrLMdyDs4fQJsHHrewvihigKideOC4GOIKjpmraZDmOXDEJVLqfm369RIHKHyXi1gHrETHstEYgbQGt0LH6fBxZ+tUOmsE6AAL+OpV7et4P9ElZCNH6Xgokp76a008iIefgXipgbVV4NUGUYwNLlnP310M/1U7+1KvBIYJGLQJF0cO/gDtqAO4YPQhnpP673dB0SmEJOU1GttjZT+fa0NwR3tNXUUZQtqI2ajmCiwkqVUiDoDWsqUvLejhE3v7Io4A1Z+KaWRurZYVnPP8AhDnwDSrmVPODmNh5rYmYo+pMUagImazomxk06w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBYs7QLlRuFHyvCXcAEuiTUt96C/D8zKvE+q9tK79bM=;
 b=iJQcuIsvZVxb1MV6w4ZSkwd9yB7KWMWTYpJj44XVmDosqvUVysKVmtCrgoz1et2s8NVofse09gZCe8qj/xMPE7tCkisKmun351L2Uc1Udva3ahsDOSN7XKes5CFPQ/9YBoJY5k/4rKCehqZ5bpcC7ittEeo4wF1H0jOh0KVpkCZC5b3z/ZAoKyT7BjNeiIOeAMmgNaVK+RTcqlEhe7OmI0sq1JtlQLWYCQY9XngvBtYJa+rZ+H1p/1nzgwqqoDgqynSFc1u/t6B3hR7ql3j/fjkwMlFz9BnjUSB6to4JJhNYu4jW38Yo+BmYtyZ+m86YyOt61XBf0TG4X3tDHoLOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBYs7QLlRuFHyvCXcAEuiTUt96C/D8zKvE+q9tK79bM=;
 b=pYhglkb94BDXXXpoyIGiPki7B58IZ+3iVz6mbwspho+VAuVyAvPhmwfNJk2BLJmICeEG9i8JOdv/Cyuu9VYnFQQ19bphlEW/DHLRkv2SmEiFipP+6Z4GgTEY9FbWt+D5pI+RvHRe6lKV0MPUNpQvaFbcDWTSFLqBOGBKeHm/T3Y=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2144.namprd04.prod.outlook.com
 (2603:10b6:804:f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 22 Jul
 2020 09:20:08 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 09:20:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/4] btrfs: Don't opencode sync_blockdev
Thread-Topic: [PATCH 4/4] btrfs: Don't opencode sync_blockdev
Thread-Index: AQHWX/9w8oJKCpVMIEWL6In3tff8tQ==
Date:   Wed, 22 Jul 2020 09:20:08 +0000
Message-ID: <SN4PR0401MB3598C025490C82DCA8AC408E9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200722080925.6802-1-nborisov@suse.com>
 <20200722080925.6802-5-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d4331ef1-38ae-44f5-939a-08d82e206db1
x-ms-traffictypediagnostic: SN2PR04MB2144:
x-microsoft-antispam-prvs: <SN2PR04MB21440084A7F473C91183B11B9B790@SN2PR04MB2144.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cO/R8edrYKXYLQRm7BwOk0f81YvA/QEuL6JVo0tyj0F4JOrKcScCxrADxyHWvCqVF6Dqk6qAAfwO6XgWOdGRcSRTcZEjv6C1M6cGL80ztCYcc7UqdgYGDEmYxL4S7I4s7qTCBte28zyIMQcpY1f/tA7wpXiC0w4IAJt3junHqU5F+u7FL4r3mXQ0Nc41IUbEg1nizPYmQcX6XifaM464V2gjZ9CFrRN5sZjEsw6VOQ/2U5aFesuCdYoa0DrcQQnCX4HbfVzWrHJLrce+rZRvSvYFtH7jW/lLSU6g5ZgZHyUZyEg9xrqzxcYmcVbWW3Y0Azb036kaCHlcyJcYiN55Aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(8936002)(76116006)(71200400001)(91956017)(2906002)(8676002)(66946007)(66476007)(83380400001)(66446008)(64756008)(66556008)(316002)(5660300002)(558084003)(55016002)(9686003)(33656002)(53546011)(6506007)(110136005)(478600001)(86362001)(186003)(26005)(7696005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Fi8zV5YzkW0YhrQTeEPDJEDfoPCQhg7lLoHgcxJpNSn/huPNjmNFI7F2J4HhlckhrSFD91urUJmSLkM/53E4ntEZaTnhz2Yun5oIPqpt7q1Vic5CAJtLgT4BzSRsG/y7kYI6L+TaLnX+Gw/CXXWuMD/o0OMw0PkUPUoXS0+DzcW+KCHHgfrkSQElBIckS+I8PBH/0NTHGHX28QtqnwiuxPnCkylndENu2US+13C7493OFp9pqtCVjuqoDzOJp5r1zyO69SPy/Cq45SYjjmmv5iu6/JBIM5L/v/QxSwIt0r/ZNVUVrykzUtic60KNgGCLkPb9J/nEEbb6MVww9bGPhY3JAnhP5/9+tLFdEoffOb90AQBusdLPuMcBfV45LDj5IDeQN1VxdXbVSTJHYXXCnnwjnbpFFIMkCMyfmlVPlVSwoOnYyuq2dTxIAG4hKD6089VXwae3QSrIljg9AhNjBHaS4EoXJmZeC6amELdj0a8E6Wbv9cCAwdHw3oH9mAck
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4331ef1-38ae-44f5-939a-08d82e206db1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 09:20:08.5651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+y4WQ5Jf36iSsaKzdlY7t0u/8g14eBQYUNhf7wEbVZHYKUFntXYyaz0AG7qdllTlOuensllCmSomQVVtlBBKR1iDbuOTYLfOvWjiIPwnp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2144
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/07/2020 10:09, Nikolay Borisov wrote:=0A=
> Instead of opencoding filemap_write_and_wait simply call syncblockdev as=
=0A=
                                             sync_blockdev() ~^=0A=
> it makes it abundandtly clear what's going on and why this is used. No=0A=
  abundantly ~^=0A=
=0A=
Otherwise:=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=

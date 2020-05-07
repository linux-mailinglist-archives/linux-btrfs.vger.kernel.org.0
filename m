Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB4D1C83A4
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 09:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgEGHlZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 03:41:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20562 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgEGHlY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 May 2020 03:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588837285; x=1620373285;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8qbQMF7wqRpaBxmpXtceACF15rdCvv74pNn9nfRNru0=;
  b=ojZ0lzpiPwYowZocPO+NXnLPhlCy35bTcjuWMJ/0dqNqE9PXNKrXloe4
   +5Kk2noC45DCuV0yfDOXo0yBzgHiifgRE5OJIuCqU9zg7Cpe8I864SKrc
   ilOEHA08cwsUW1p31EnfSI6X5Mzi5mi35zjdS87/lqTMgGGmextNuJR10
   hboXnlpdIU0MXRWKu1P4NA/4wRVoAppE/XmxGYXWrenP2WEF9EZiL1PhH
   mppo7JaxIzLYVT0fdfIGBLXI7aa1wC5SNMfqLcIZzY0Lr8ai8rYzit0E+
   SePDjQWnHEh0/4l44oqT98oAcMRwrqp7Hw1qAacv82OsNcBwSKJosz7fM
   A==;
IronPort-SDR: 3TO40cWUJoDQFxF8n/vNZwWpRmWoob6S6rPXDn1nZuV4IXcFY7CTp41L3Ltm6XgVRSMcefERta
 hxJ3EHnesECKroahJip8IXrWVUDkjF8NDY7Q9ogD6iq4nODW4RlqevRBqi0kaeiAeLEHg7fbGJ
 3EkUoaZM95Jd9GOm5Dvq1V9Fz4X/gf49cQzukGlheCAvTlarZB/A19r+20TXBi4X9sQSNGhvqF
 +LEuyUoI7ADPXbQlimTTTvJ3T47WUgglHaWhbYdBuzR+Es+so42x+5XWmyE7sCjTMewHer/lKr
 Q14=
X-IronPort-AV: E=Sophos;i="5.73,363,1583164800"; 
   d="scan'208";a="141457671"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2020 15:41:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS496nh+CcH3Iz/iawOD6nplaiygEai4mszVTmdrlSM6DPq3Qh9U9eQNO1v99DjEwdEZVXWVXxCWyQEYUw4L2hzyg0U2z3W1VGROtYFkSodp91c/l9sbT/a7NR7yYEMjhdzzwZvHauTq5UX6teLnGxXoHWErEkBUoDFF8OESMUYvDSjtXpco+/vr5ANnwF3ls0k0m4PvJezrn4R53igVRrESC5Tk4+MYWQ9/a9Zi8mPZbaEr40+6EoSC9ljQRrtb7IyKaOLhwhtluKSQ2HQHLYg1aezi0TXeb0pZv4195fDqoBQZPvVGQFGnXuyiNfy271R795GlqK4pg77t1O6zJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5mWyfUFeOOOYXTbGzwXzociigcSrOwOa069pDMqh+4=;
 b=jb6A/NTIcMXQBQQE/KjTUHAxTKYtb0d5jMX/bmLzeBQY1U4WqSDuV7uWoMxEzaUBQAn6P2l5c/CYwVS/8JeIkZmuGKSnBODSHXHF1/5xnKqIYwaygYSD2D+xf0a/f1SP+DznN5CGz8tBWwj0WxZOLM/YGxs1edHUNxclz/I06OyJqk/+HwRqJ6nPQwXVqqJuvSTH8IApN0BZ5WxNBjyM9b21dgkvlwa5SG2oEVBSJH05s4CAFt6tpetnneao1ATPlkfvGoNQG++dV8O0WJVgPQA8Rw4u1MEoJWWtumQ7as9d1we4FFHeRx+83rh2JSgYzDEsCxdDMeqBnb+wXEaSRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5mWyfUFeOOOYXTbGzwXzociigcSrOwOa069pDMqh+4=;
 b=IAzSMohcg2mFXDnUY4ZqUh1meQXRiTnMzH7rEmkeD3D0cu7ozyP3IyeENtmToW+Tz7CRrHuJRghuK99DZU1plwdFlVuRSsLkpDU14K2M3UMjZkaXpQsEhX1us/3ZIFu6QWQgR96e0s4j30g6rQXK9o4y6Le90Q+14u5oh/dtV58=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 7 May
 2020 07:41:21 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 07:41:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 02/11] btrfs-progs: block-group: Refactor how we read
 one block group item
Thread-Topic: [PATCH v4 02/11] btrfs-progs: block-group: Refactor how we read
 one block group item
Thread-Index: AQHWInCBjUiXawU6Z0i8TlfFRK8ocw==
Date:   Thu, 7 May 2020 07:41:21 +0000
Message-ID: <SN4PR0401MB3598B6A1AAE042F567A9F3459BA50@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200505000230.4454-1-wqu@suse.com>
 <20200505000230.4454-3-wqu@suse.com>
 <DM5PR0401MB3591BD0FCE7A13C5145BB7959BA40@DM5PR0401MB3591.namprd04.prod.outlook.com>
 <20fe631b-5650-f6a5-2cf8-5603ac7dffc5@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1b806b62-3c15-40f1-9974-08d7f25a0970
x-ms-traffictypediagnostic: SN4PR0401MB3598:
x-microsoft-antispam-prvs: <SN4PR0401MB3598C802567541624B4754CC9BA50@SN4PR0401MB3598.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: parbT77ZN5L+GJkfDeh6Om4GNY2me5BEVAhzDR2gKkOZ9lqPMawh9BNX8PCGHLqeBAwkwlDgNAOID89b05vv4HL1PHBtbyJYyzWDRfvcdOzngAXSXtUl5OYGrIWWmx4As79JgVaVoQPTMt8yRCEOvmJs37J7GN2ts9wj/O4qwG876mo+VXTG9zAhw7CY0UXvg9Hn82vUF/amM01uRbRe2sHGIbdPynxfmNgTOUxvCf5yIVWIaxlB6RBqCjGhyXAgE4S0vg3DKIBmtKuFF0KBKLWxk03uhzVZvsCAdTlUEUR3WXoE5TQZkuq12ezMyRM0ZvHXPY+aGANWfFEhtRnrvQXvd7yKvkogOZ8Potvo2GukrINgiQqKJrpBg53uyDGumF1BzSvw27b6qAlp35GBRRhWl98fpG4wKUcB/KvbiVMZmLv9L8zHRpa4SDzi4o/txXCP6V8xmKzf0m5Xgh4tc2F8gqARvAOyVB+ak6X++dYQRmTu6k3N5mCp35Cy3zONtY26zyjy2pbyDLZw3cdOJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(33430700001)(66946007)(52536014)(76116006)(91956017)(7696005)(9686003)(66446008)(8936002)(66476007)(71200400001)(316002)(55016002)(64756008)(66556008)(186003)(86362001)(33656002)(110136005)(8676002)(26005)(53546011)(2906002)(5660300002)(6506007)(478600001)(558084003)(83320400001)(33440700001)(83300400001)(83280400001)(83310400001)(83290400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7EE62W7yZhG8YHQStw7qZVkPchaeCoD3p1qmRCnn53wfI8Pnvdp6WK5MnFMwtrVeZJpdJ9AKBg980EypdQ2tBjSyn4ayDUVgkgWF4zudaSD0N1Sr51dqtieMlPpTYiqa09yN4XRd6mWIzq8FOvmgBafXKvWYZNw3YUJVTlY8EeyQeEWCo675Uo7TAx0TIJWfnC5mBrKtGtY6uAf+ugeo9E76DdK5jG1DaB/6ljyGJ7YK16MLYkxY+6QshyTPVcBD2KGAoJW+CbF9he4x9rM1HypvMHR0ZDq9vYV/Gjl9ikdJn9nyLTCoRYUxDiejFoft5RsKhnyu1ocRJDC81H8H1EEIi7dbszt6tpCNwt+TbLzuIB4toN/pBEZ5Pm7gjUfTnht1rk5+Xm6THviSiTg9ljheJVKNk0SGQLGkrtVAydocuNMDC2morYNfjMvxpOynaLtKhTsNmLe2X89uBHE9ST2wR4MUKzRL7BBTrtPKagv5hXgvkV4r2ITqRuAi8RVUjQ9ps2Tw3ol4Q52RpeUQ3H70PovtbK6ZdiZUFGH/zRhHEBS2c4jBQvEvjFoaFf7iYLo4vp3yv27EsGQ/v/erQoBAiUufolAN/6zEbHd5+vwEEIJiBQzdqMjS3pkhbWV0TpM2lN40a7WfNESxsjISMjMncEUpyVG8TAxRmVvg7YOCZ9J2RfPsVrtJIHJJwI2egeNdAg0NNqsCMI/zp8Oa0AacKN0cl1qZeGIYmIMI8FvE1+V2xd8HQSx2t3cjKrlCSq6+KK9iZe5x6zWHOX2sbENDJT91EyO5zZOtDvUOihI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b806b62-3c15-40f1-9974-08d7f25a0970
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 07:41:21.4018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vG6O+vLXbEC4rqokij3eT80FoOlfde2pBJW+0IxIqH0VS4zBC30/LWKyN+Igco/Hfv+VCsoZAvS7aA6yODKZqSJ9PuJOsjkht83RtwhoZCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3598
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/05/2020 00:52, Qu Wenruo wrote:=0A=
> It looks like the sentence is not clear enough, what I mean is, after=0A=
> read_block_group_item(), there shouldn't be any key->offset user, but=0A=
> use block_group->length instead.=0A=
=0A=
Ah ok, that makes more sense then.=0A=
=0A=
Thanks,=0A=
	Johannes=0A=

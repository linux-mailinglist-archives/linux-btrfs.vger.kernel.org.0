Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E4C6B951
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 11:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfGQJcX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 05:32:23 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90]:20009 "EHLO
        esa9.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726438AbfGQJcX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 05:32:23 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jul 2019 05:32:21 EDT
X-IronPort-AV: E=McAfee;i="6000,8403,9320"; a="5005986"
X-IronPort-AV: E=Sophos;i="5.64,273,1559487600"; 
   d="scan'208";a="5005986"
Received: from mail-os2jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2019 18:25:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMjul56Rwatvm1/7VZQH1ljLrAaSQAx58wn+hR63G+nDJuFeQKRmOQqGoNsyPIJO4dle/TdKxXTtgfsLdlXQPZL8ScVWuFncesTV5WaTLvEC0uktHBdYfWFdBPcDmq1DjO6TqORVUMcssPItEpOMZciDkDfiR+tXmdJyLcfneS2sd9ZThyR7ivoiJEeTLG3Dknh55blwsKMEZ+zwjqiWsW7TWdAAUhsT2lBEjved+do3TvTXa1syDz5AkNEdx2QSmO1GyMDxBFHaZ4sig49P+z6s6j2Za3LsZdO/U5twDiHpjg9JU5/iRvtQyBbl5x1xjOZRAJEVO28QgoIUN6BOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cd5n2BkHefyojGj9m32Xcla1ST/AUaMj07gVckrK278=;
 b=XxPBhcJ5iLu/m4YO+4lpn7cdd3MtjEvB6PTnNHHz80ZLEM4J7NCy4r5NDcsW8VufRFxT20uuwGi7KxTxT6SRcrvdvCTpJrwNcB5DN3AmAENg64VUhNWFib9HCp15MAVYUnGRgLkm84FQxRimyyk5gnjHzf2LZGSM7GOXcXG9JGJDk50tbNmXbXzHsY2Q5EAkmTUyYIH6/wYxGK5UOIaKP4yDKh+YDICJZFaYYPtgQQ3Vi+0qrgFNvzriNK33KxtWrrKd3+hpBg9idvCrnZSN3y6KEuZq4QsP3pryEMUMHMC93neuQSScUCKoD5lpA0dLFp0Ac6DGqmUCcAPtw7Ye7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fujitsu.com;dmarc=pass action=none
 header.from=fujitsu.com;dkim=pass header.d=fujitsu.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cd5n2BkHefyojGj9m32Xcla1ST/AUaMj07gVckrK278=;
 b=HgUNUpPf5hUFJVVMQq1kIec/EZ5EjtdgjqdpZMy8LZUbUK1LzoMu5Y9JLsKifgoX+nuseiUlF9Qronrj5qFP/2sNbMe2Cgwk9a/LIwPmJqpuxbTrD7J+YhI+Zz8iJcNh8O7musAxcEkaAmpE10bWGif0OnR+FlGT2ZF2u5FRdMw=
Received: from TYAPR01MB3360.jpnprd01.prod.outlook.com (20.178.136.139) by
 TYAPR01MB2367.jpnprd01.prod.outlook.com (20.177.105.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 09:25:09 +0000
Received: from TYAPR01MB3360.jpnprd01.prod.outlook.com
 ([fe80::20e1:b513:392e:a434]) by TYAPR01MB3360.jpnprd01.prod.outlook.com
 ([fe80::20e1:b513:392e:a434%7]) with mapi id 15.20.2073.015; Wed, 17 Jul 2019
 09:25:09 +0000
From:   "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>
To:     'Ulli Horlacher' <framstag@rus.uni-stuttgart.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: how do I know a subvolume is a snapshot?
Thread-Topic: how do I know a subvolume is a snapshot?
Thread-Index: AQHVPC3JZtmICxXfsky3dqj1ADsOS6bOeZaAgAAI5dCAAAMKAIAAAqnw
Date:   Wed, 17 Jul 2019 09:24:09 +0000
Deferred-Delivery: Wed, 17 Jul 2019 09:25:08 +0000
Message-ID: <TYAPR01MB3360C39F7D6DD45215A6D7C6E5C90@TYAPR01MB3360.jpnprd01.prod.outlook.com>
References: <20190716232456.GA26411@tik.uni-stuttgart.de>
 <f47ad813-9b91-a61e-7f4c-378594ee84ea@knorrie.org>
 <TYAPR01MB33604A6035BF09518027AE12E5C90@TYAPR01MB3360.jpnprd01.prod.outlook.com>
 <20190717090638.GB3462@tik.uni-stuttgart.de>
In-Reply-To: <20190717090638.GB3462@tik.uni-stuttgart.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 8d64b748dd0943e7b28e4cf22296f76e
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=misono.tomohiro@fujitsu.com; 
x-originating-ip: [180.43.156.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0983167-afc2-4deb-b933-08d70a98a9ec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:TYAPR01MB2367;
x-ms-traffictypediagnostic: TYAPR01MB2367:
x-microsoft-antispam-prvs: <TYAPR01MB23679B9053170D100C9DCE04E5C90@TYAPR01MB2367.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(13464003)(189003)(199004)(52536014)(6436002)(81156014)(33656002)(25786009)(71200400001)(8936002)(8676002)(81166006)(55016002)(486006)(305945005)(7736002)(3846002)(446003)(476003)(11346002)(9686003)(256004)(66556008)(53936002)(85182001)(71190400001)(6246003)(6116002)(66476007)(74316002)(2906002)(66946007)(66446008)(76116006)(26005)(76176011)(186003)(7696005)(86362001)(478600001)(6506007)(102836004)(4744005)(110136005)(2501003)(66066001)(316002)(99286004)(53546011)(68736007)(5660300002)(229853002)(14454004)(64756008)(777600001);DIR:OUT;SFP:1101;SCL:1;SRVR:TYAPR01MB2367;H:TYAPR01MB3360.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H63CMbBNdq9Dawh+z6cygDMBQW+iJUUH52qMQtOMANX1tuhbqD1HNtigru7SUEIx4mK5xP/mDJD6NmvGbJP5hWu8BV7frlh3qDtgknHYO/VafK3JLmNpK5yHTtahdiJOEffjxuqrFmlqkP4kZvPnLpsG+Fg7klMRumuJwH4oyiVg986YnWNHBl0kaPIzizS1tUIiss9Y1hXMLtrAbxmA3mYUIOcMBnAH75GyrHjk2GSk6TlhpEptK6PqSQMQL+HQteCuCh+EP/RwJSI2b93xgwKGz3iG2G2KsK/9Gfb4CW/Z9LgQoAvB7qFZBXbxsEhn/8ndhAQtMbG9QMB/mCy41gQcs8COzWHAWsfmtBiVzZ0xr6dWV1wKOEnqWq0l8QEw7xSJyXgbG268A9SPAEPTwLbAiSMuR0Id4mIhjztUdRw=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0983167-afc2-4deb-b933-08d70a98a9ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 09:25:09.7525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: misono.tomohiro@jp.fujitsu.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2367
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> -----Original Message-----
> From: linux-btrfs-owner@vger.kernel.org [mailto:linux-btrfs-owner@vger.ke=
rnel.org] On Behalf Of Ulli Horlacher
> Sent: Wednesday, July 17, 2019 6:07 PM
> To: linux-btrfs@vger.kernel.org
> Subject: Re: how do I know a subvolume is a snapshot?
>=20
> On Wed 2019-07-17 (08:57), misono.tomohiro@fujitsu.com wrote:
>=20
> > FYI, this problem should be fixed in mkfs.btrfs >=3D v4.16 since the
> > top-level subvolume also gets non-empty UUID at mkfs time.
>=20
> root@fex:~# lsb_release -d
> Description:    Ubuntu 18.04.2 LTS
>=20
> root@fex:~# btrfs version
> btrfs-progs v4.15.1
>=20
> *sigh*
>=20
> root@fex:~# uname -a
> Linux fex 4.15.0-54-generic #58-Ubuntu SMP Mon Jun 24 10:55:24 UTC 2019 x=
86_64 x86_64 x86_64 GNU/Linux
>=20
> Can I use/install a newer mkfs.btrfs or do I also have to install a newer=
 kernel version?

Only newer mkfs.btrfs should be fine here.

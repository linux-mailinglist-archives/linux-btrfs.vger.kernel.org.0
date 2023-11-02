Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E40F7DEC25
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Nov 2023 06:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348515AbjKBFLM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Nov 2023 01:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348509AbjKBFLL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Nov 2023 01:11:11 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01on2069.outbound.protection.outlook.com [40.107.107.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839A8FB
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Nov 2023 22:11:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Btcf2pNGG9EQ6kgIMpFxAbyHdzNJC2/3yfLKxcNgnEZTbEK6KWoGhZaINBaRWSeDiOluWhGVDgqhocAwg1TrYaehJ1BA/ykDYV1E3ijhvWkXwEK5NJb6pX7UwNK9ijbWLkmTpuDMRdJ4rN44mXRvMQMYNB83Nmafkf2FsMgjHw860Y7rFO5HpbIOaPDg85susietLuYVh42b4+JNhbEkjCM555zASecv7DZRL1gblgbhHT4rMxjj6UcpXvuu499IMmd/mzHYEcq89cxmQh5q+5b82eGdyvsoAmKD5XrGQRrYi+4S5tTuBZEQuwIAwJTPbOEkg4NNBdYOkkmEVvvbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Dzq/uxYWg3z5D7k/clewfrvvh0MrC8NgcTgAfe5Xcw=;
 b=VHr8OBysyVga2bik8XMzujWH9jQrGge7OKaYwj1l28qw6UqR223VQXEu2Ez0vnws19wDUM0sByv+FI7ffVzgXw9jU8149e4tVlnRP04GQXXtQ8+Li3zGV2FAiNq1gB2VsvxNEkHa8C4ijzo3Lf9v0g2bc615mxDKDcPmVoacBdPNq4zjwdKGqanOtUq9LQ/AwJwslas8E7pZax3IzR/llYxuK3B8FGNCMQ/htOIhpNPOd+wOmbzjkmTXz81EbEsQ9gdV2sZiVxmVu9tCFO5f5/1+quSLNoGQeuSGOJBv1X07G96aP0CrIM5SC+WMTzRA3E/fKHwasCujcHwBGFIuFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Dzq/uxYWg3z5D7k/clewfrvvh0MrC8NgcTgAfe5Xcw=;
 b=IpORN1ZeMaoEwitO4UnHNhD7QSQ53Yk3fIVYq0ytQ3jCfGUu3i+y5EUtW7bDIimZEmaUovbOfMXlmrYS7ZVy4nt2WEgxAG/DA/7vL/K/ECUqY6nKADiTeg9ovnBrQeq37sLUzhiRqgtRna8joAKRECKCPClgCBjx5oLHSkFnRMA=
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com (2603:10c6:10:4a::22)
 by SY4PR01MB5643.ausprd01.prod.outlook.com (2603:10c6:10:1c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.20; Thu, 2 Nov
 2023 05:11:01 +0000
Received: from SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::6c25:3e00:c30f:b330]) by SYCPR01MB4685.ausprd01.prod.outlook.com
 ([fe80::6c25:3e00:c30f:b330%6]) with mapi id 15.20.6954.020; Thu, 2 Nov 2023
 05:11:00 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Pedro Macedo <pmacedo@pmacedo.com>
CC:     Anand Jain <anand.jain@oracle.com>, Roman Mamedov <rm@romanrm.net>,
        Remi Gauvin <remi@georgianit.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: Balance on 5-disk RAID1 put all data on 2 disks, leaving the rest
 empty
Thread-Topic: Balance on 5-disk RAID1 put all data on 2 disks, leaving the
 rest empty
Thread-Index: AQHaB4Iw7vBVArYT4kivX21vPbBia7Ba/7AAgAACKICAAgk8gIAI1voAgABzNoCAAC/6oA==
Date:   Thu, 2 Nov 2023 05:11:00 +0000
Message-ID: <SYCPR01MB4685B23E1FA74D65A3859BDE9EA6A@SYCPR01MB4685.ausprd01.prod.outlook.com>
References: <erRZVkhSqirieFSNm0d1BF5BemFMyUSCjGKT73prpKS7KDydKhqAvNqA7Eham7bQXmmh0CCx0rep6EAKKi_0itDlOf94KZ1zRRZfip_My4M=@protonmail.com>
 <16acffd1-9704-9681-c2d4-4f5b8280ade0@georgianit.com>
 <20231026021551.55802873@nvm>
 <de06dca2-9611-4fde-a884-0f4789f7b48c@oracle.com>
 <21245ede-7ef3-40ad-828f-91f6845e9273@pmacedo.com>
 <ZUMFvRDAragUzhlY@hungrycats.org>
In-Reply-To: <ZUMFvRDAragUzhlY@hungrycats.org>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYCPR01MB4685:EE_|SY4PR01MB5643:EE_
x-ms-office365-filtering-correlation-id: e97d0392-591d-49f8-0540-08dbdb621aff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vt03FJmrKnBrMKluoYRGsxZBOjXuc17L30vacddRwf/mPS6ri4zNr620/ZhG/xmJCorHtRH1heIr/2IWH99XACLHofP6iqCy0lnzpvd6z8uNyPBiyeG+kCUCRvoIXoLG6eRiTI4faOAlIxA5hDROh4rmzl+JzzdpGEwtU9hTRDV1RpciuPd6IuN6QswTHF2pMSzoeen4pyPp5la/qTvux+3rPgCRkCWQvGSsyTwrxZxMrhxVcLWZlYMN0/KqprjgUOCYuXCBma3UUbgpYqeMg+g6GJssY//uYCOefP9PkCrbg1iB5VzfSRqZL2ojLl8z7Ad18Z1rMWis7YTAN4Ea+rh033l4D+eO1Ei+4oiDNCd0H3uVLwrx/Vg8hgrNUywbCSXbpPXH8dwKukA6l+ncQuampe4aG1MS5wAsNp7yHO2Eoj/nXj7e48eVEa9LI3zGYsx4VEx9laOJFkK+m8S05bguwnJZ34O/J42tg9QirF2M24fHcKtJloxj1FyUMGV9LxMRR7MbTsri3CUpzqlAbQGBBDj7nz26E5uwBOhorR+wV912XmWAyZfgpOeu+Tuo7Skbo54cjYN+e4j8I4dzsc0OeYc6Tq0ctoBEhRsCvUkFeVollIN1tbfIwm6bDy3y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYCPR01MB4685.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(346002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(5660300002)(52536014)(66446008)(54906003)(64756008)(8676002)(4326008)(8936002)(478600001)(38100700002)(41300700001)(4001150100001)(2906002)(33656002)(55016003)(38070700009)(316002)(66476007)(66556008)(66946007)(76116006)(110136005)(53546011)(26005)(83380400001)(6506007)(9686003)(122000001)(7696005)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WwZI+RSKL4KapiFGsKJ96XNFdASYG2iI365MN+yYTlWjYVugwI+EIYSg4H?=
 =?iso-8859-1?Q?dwNevdE0EWH5bTtJXRrXtK59FHChh2Ajcj9DpwVPr4uKXieoRtaHQMMFG6?=
 =?iso-8859-1?Q?Nk75cpUAEIIO7yQv2BqN35tXMAc7iOPTzi2FT1xFhRDHUnIUt/bDh7SETh?=
 =?iso-8859-1?Q?SIL7V10D+8TU1ZhrzqfnYNTf0Op9YeJcZzxeOYgd6twzi/CSJAy/TmuvUX?=
 =?iso-8859-1?Q?dm7yGvlNB4kYCgbIctXAQj05rezF2EJZTt+x9MphEHuZ7qHeQRalTFENvt?=
 =?iso-8859-1?Q?q6yg8TYROG50JomJQ+WvOHwjn0ZZg5FwrN/pjq7PK5JUrhGa02C4ujar/I?=
 =?iso-8859-1?Q?QgE1JQlBi/sX1K1i0uwzGEgCqFJCDW7KVHcNefGpwEhussJpPDbyKekOWD?=
 =?iso-8859-1?Q?7BW+Ge00/E0p9c8kvuJgl8uhXJAWO6PmvBi/ta33q7egc/t1JKYTFaHbPG?=
 =?iso-8859-1?Q?uJsOpYnsJR3TboJkuDqxrZoiiTVflrQP/9u1zT/ldcPkEQwhbnWGS6yyo3?=
 =?iso-8859-1?Q?15dyC9FyIHIRTtPETW5BkmZZIPEbDuwfCBHTpHdaYwwZ1as3ox6pRuo1EU?=
 =?iso-8859-1?Q?MbF+iDZrM5yVi3Tmu1MQ9QUsGPZu7VvAFnv4qhd4cUgSs+GYGjI4ju1y0/?=
 =?iso-8859-1?Q?D3jEMkzTEOECP2VOodEqSoNaQ8Hrlyx8EJFE+RbUOx0ZfG8tOVAucUlvqj?=
 =?iso-8859-1?Q?VVteGsJe5h/gpsD0e0Hvnsej/vmvUU1+gcxh7AYp4/13gQMLZSIUSDtc45?=
 =?iso-8859-1?Q?TftE95gg6DLifTB78kVJYTGLELVtCmm2b/GLaTPd/PQaPjlkOuKPXwAhx+?=
 =?iso-8859-1?Q?tKD2wdIzikfAN6lFjnmzn70fUr5YlH6vCI/qtnDayGnglAfgJDnRGwHosW?=
 =?iso-8859-1?Q?xXxCMIzLQKDUsud/9xgQcOuZdH3cEIQb3/8jRxVKPot/Y1CzZ16uBvnZRQ?=
 =?iso-8859-1?Q?TTa7NU1Qu1KKo5QxqxUVb20KmNrAhAYsBxpOde2ujt+HDm0CQd1U0PPh8S?=
 =?iso-8859-1?Q?HsySjQ2C3SOUMpDvrddSFEcv2SlmticA7SN/ZSnoKkgZzBEAaHBwV40vPX?=
 =?iso-8859-1?Q?JL1wlgRMU8DV5InYYStE5qv26vqh/ZBtistCb/1wlyL9WQOq9pdIIsG6TW?=
 =?iso-8859-1?Q?leYwrWgX3akeNJL49Q/Pxfz/fWFRTs4xUCZoqn3qGa5Vndfqr4Kkw2yaIf?=
 =?iso-8859-1?Q?00somXucy8c1kBwr4DwnUbDG2JdRZ01a0Wiibtp3iHCGjvV16Gz2OZ7FJR?=
 =?iso-8859-1?Q?Me1iSZFCz4/TB3MjQFxR4jDNVEw9zGMHT99xqy9qMW90yS8qB9511Fa6kR?=
 =?iso-8859-1?Q?oBC4DisHmd1F2G6GRpvQQDRAM/FWklf1Ah1+kc/XIQ1Kvba5RgY0vgXit7?=
 =?iso-8859-1?Q?Xowdm/VF0iNyCllNAQCY1oTLhFpYDgOGKYQf3hrlqhxWx7DlUZJ1ACdAPS?=
 =?iso-8859-1?Q?btsnkh0EKWTSOiCc9Avy8IOSe6IEIufRfU40jIVTOTQmi/XYbPobYvKTc5?=
 =?iso-8859-1?Q?/0Q3gE8qYECzHEwBGmT3A4ZdtCq7R7CZv+N4qCepuMXsKd/yVWWzHt6ZXr?=
 =?iso-8859-1?Q?M76Muaf6wQN8gZAyKQdLzkF79Olj2si/sleDyFIRb3RiWFLzjfpvW5i0Ro?=
 =?iso-8859-1?Q?ALLXTJpThgJE4iKf1mIEL2mCJ/Ushx+tMg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYCPR01MB4685.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97d0392-591d-49f8-0540-08dbdb621aff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 05:11:00.8751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jiw5FFlbrzKIsHoJSNc8pk8TUaAuB0zvjKqNhDkjytBsCyY0z5DDeTle3v0Haj1rJWAgXmo795BEr3JBgzSB+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4PR01MB5643
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> -----Original Message-----
> From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Sent: Thursday, November 2, 2023 1:13 PM
> To: Pedro Macedo <pmacedo@pmacedo.com>
> Cc: Anand Jain <anand.jain@oracle.com>; Roman Mamedov
> <rm@romanrm.net>; Remi Gauvin <remi@georgianit.com>; linux-
> btrfs@vger.kernel.org
> Subject: Re: Balance on 5-disk RAID1 put all data on 2 disks, leaving the=
 rest
> empty
>=20
> On Wed, Nov 01, 2023 at 08:20:56PM +0100, Pedro Macedo wrote:
> >
> > On 27.10.23 06:21, Anand Jain wrote:
> > > On 10/26/23 05:15, Roman Mamedov wrote:
> > > > On Wed, 25 Oct 2023 17:08:08 -0400 Remi Gauvin
> > > > <remi@georgianit.com> wrote:
> > > >
> > > > > On 2023-10-25 4:29 p.m., Peter Wedder wrote:
> > > > > > Hello,
> > > > > >
> > > > > > I had a RAID1 array on top of 4x4TB drives. Recently I removed
> > > > > > one 4TB drive and added two 16TB drives to it. After running a
> > > > > > full, unfiltered balance on the array, I am left in a
> > > > > > situation where all the 4TB drives are completely empty, and
> > > > > > all the data and metadata is on the 16TB drives.
> > > > > > Is this normal? I was expecting to have at least some data on
> > > > > > the smaller drives.
> > > > > >
> > > > >
> > > > > Yes, this is normal.=A0 The BTRFS allocates space in drives with
> > > > > the the most available free space.=A0 The idea is to balance the
> 'unallocated'
> > > > > space on each drive, so they can be filled evenly.=A0 The 4TB
> > > > > drives will be used when the 16TB dives have less than 4TB
> unallocated.
> > > >
> > >
> > > Correct. That's the only allocation method we have at the moment. Do
> > > you have any feedback on whether there are any other allocation
> > > methods that make sense?
> >
> >
> > IMHO, based on the frequency of this question appearing here/on
> > reddit/other sites, perhaps allocation by absolute space used?=A0 It
> > should fit the expectations of most folks that if you have free space
> > on a disk it will be utilised, plus has potential performance
> > implications by always using as many devices as possible to write to as=
 long
> as they have any space left.
>=20
> That is how allocation works with striped profiles:  chunks are allocated=
 using
> space from all non-full drives, in order to use space and iops optimally.
>=20
> For a non-striped profile like raid1, it's not possible to use all the sp=
ace
> without filling the larger devices first.  As the large devices fill up, =
their free
> space becomes equal in size to the smaller devices, and it's always possi=
ble to
> completely fill a raid1 array of equal-sized devices.  If raid1 distribut=
ed data
> across the small devices at the same time as the large devices, it would =
run
> out of space on small devices before running out of space on the large on=
es,
> so significant space on some devices would be wasted.

I was always under the impression that space was allocated from the empties=
t drive(s) on a percentage basis. Was that ever the case and has since chan=
ged? That seems like the most optimal way to do it.


Paul.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0051C231B
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 06:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgEBEss (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 00:48:48 -0400
Received: from mail-eopbgr1360058.outbound.protection.outlook.com ([40.107.136.58]:37117
        "EHLO AUS01-ME1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbgEBEsr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 00:48:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUHVgH1zZ7KxPWqZ/MTJjK5pdvRa+Eioa43kxwGOaU2kkoIRiVGepjEL+QCiAvjZeOws8+bKA5orqX/f0X8hoo51HbnzOWrw7eitFusflVK1HpboFjvOA91gxa8LoH5NlOrtc6q7qXhgb5qE52kZ5rH364CPTAbZ7hDQegrRZBBkqsKMKe89peFXwRjwAAD8zH+lzBxr2eW4hY8mHWummgDYSHBp+hqNqhH858TiE6kJmqV32A4uFg0GdIPffWpxHHd61H5L7Eq+2T2vHGouUWtrd8udqdB1CWYXy+jLAhqzcn14Pmyuu94Q+5o9bkRYHga1K2/mrqp+rOKGliMfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU0crN+JPscgiPy/7Yq+4ybhIEsEoitA1/QbIj5yWsM=;
 b=BYu9SwLmX9r1ejWAvuZbomXt16Z+2iT2MXQQnJtUdr4QrK5YaFaKkI8lTFM+AmjUokq/Mon54cGaulzOFBuJ2zfh0vwMjcNiNagClenTcsWwnxwj0M+f6faYEBHgwa4W+hAE3j9qm5U/jc85E/gzqkH741d3pOcnnx+cP6q/TMImXfmbZjjbY+c8yu8Yg569eUP6Eon8XuP1fcroMnHLUWcfEP4KKHCWm6wFIYtClwgDqzHWcL1gopQWoFTg+BlH8NF1YwJzZ2iZKRVtu2oN4n1kpQQH+SD0uH0YQc5TJ72P5FHvPMmqKC0Tct1zuYUU72RD0cslUchs66xNecfBIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU0crN+JPscgiPy/7Yq+4ybhIEsEoitA1/QbIj5yWsM=;
 b=IDMKigR68JGYkEsHzBaSoC5rRiZeAScN8ZJohhVrkLc6k+BpgOAx0NSJtv8nwTa45tmwXfLR5iJm12BcooVtsGI2bcGMJHjcK3f2mpK4UCWafHkGrNT/qE9ET0O3KKiAmg8Qst0sE/vYbS4ZoRjqrKxN2SytO/4YAHXQBipT8Tc=
Received: from SYBPR01MB3897.ausprd01.prod.outlook.com (20.177.136.214) by
 SYBPR01MB4010.ausprd01.prod.outlook.com (20.177.137.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Sat, 2 May 2020 04:48:42 +0000
Received: from SYBPR01MB3897.ausprd01.prod.outlook.com
 ([fe80::995d:971d:a82:4664]) by SYBPR01MB3897.ausprd01.prod.outlook.com
 ([fe80::995d:971d:a82:4664%4]) with mapi id 15.20.2958.027; Sat, 2 May 2020
 04:48:42 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Phil Karn <karn@ka9q.net>
CC:     Jean-Denis Girard <jd.girard@sysnux.pf>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: Extremely slow device removals
Thread-Topic: Extremely slow device removals
Thread-Index: AQHWHxU9fUjJyg1lIUuFsK5nfSW3n6iR9/GAgADoaACAAUbYgIAAEiCQ
Date:   Sat, 2 May 2020 04:48:42 +0000
Message-ID: <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net> <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net>
 <20200502033509.GG10769@hungrycats.org>
In-Reply-To: <20200502033509.GG10769@hungrycats.org>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umail.furryterror.org; dkim=none (message not signed)
 header.d=none;umail.furryterror.org; dmarc=none action=none
 header.from=pauljones.id.au;
x-originating-ip: [60.242.55.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f78e3ff8-4153-4816-b704-08d7ee541712
x-ms-traffictypediagnostic: SYBPR01MB4010:
x-microsoft-antispam-prvs: <SYBPR01MB40104C97E1A6F7FCA83C79199EA80@SYBPR01MB4010.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 039178EF4A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYBPR01MB3897.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(366004)(8936002)(5660300002)(4326008)(86362001)(508600001)(71200400001)(9686003)(186003)(55016002)(8676002)(26005)(66446008)(76116006)(66476007)(66556008)(64756008)(66946007)(53546011)(6506007)(7696005)(3480700007)(33656002)(52536014)(110136005)(54906003)(2906002)(21314003);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mytdp2ZCO/6XPs+mLqOf+zskHC6Xe70nTiAjCv6NO4aGMyV5IXoQC2zw6sHxPfI0GM8piPgykUGFdSFxnSs2sTrXr8sc7jHVYwjb/kzJW9A8+fLGTgGDB5bHCOYFLn3re9EqtgZ4SAkkX3LR0mcx6qnPnsrqGOecMdSigmN3Np2+Qir8fAtmSE8nS/ODXuOV2MxoCBAsugRBAcJfdbSN7UMsszKYvLjcD5+NiPHR3xs56TwOB0j2sITb6x+70fqORVyC2Il09njm7++7EtQA2T1wWiMN46se2hUvMpCy3jbbE9SLjPICl/VGtY8rzCKDa1VyvI92KtrFvx7MhG5IX0Delcsf6i7b3BH/iWYaidHrUZ29Uw+Ex0qBr0HvPCDtKih4pjRV48OD+OkOgPDp/V97thzCzExEH62aRfWibAgxZefTk0A7j2OwjyqQX6EP2bhLtq5XJCx3WJLu20KzUBuIDUsJFxcmgellHX0J6fKXetABkePVB2MyuIFXrjdm
x-ms-exchange-antispam-messagedata: R7q2eMgqwKyFNPC5DrM4y4avUiFNn+aUskS2iEwWTXJjCff6Y4Qz41lWmgXiv1+lKDiKUxQOPpM/Blwzd89ioQvQpi57ieECogtpK5Ob3LBXsd39TWWrmt9NsxIQUOG9p1dJWNgTJncPR5l59VZSs1WCKeOn5K6kzf1fJCoSDgmktR2T/A373oJvZrlgIWP5HqD4JKQPglDgPrBkIInTEUW6cPdl4fcwpJ8rp+DfNuuYogrYwh47RkhJ2S4vTUATbGZTy6ijItGBBPZTZkpRsfaAWgFnQwr4PCZcnmLDkMq1Bl3a61Jk1XUSWC/TzqU/ia5s/kkfrUwUM5atWgqK0j5lrqY8ux2AQJnLcbwK4Yo5uD/B1bacObhWVze3ds59v3ZMCEN2cvw2Oj5raI71yc0L/UlZ8hbhvg6/rLiCBBApF4zRD22Nb0JaTo/EP5prsO8/YRLyvDzsTYFQrLZjcuOsBpUdOiiYJtxrSisguf9Qpirws4e1Rk+qDchxPTo1rXsRUaVDHpBshShTBU8ZFTz5z1HllowDUFXs2B35985YaOEf7QfHf9sGEu5dIRwBKrd2KLLsxzFSkFN1GHeV6bgFHa3hDO7Sj2lG9p9SgnuriudLvd1QeXvA1RETRWwQd3SgJzSODGFVazu6aKUJIdHyIH2CQ7ZM5jBuL4jeGddubAPdw2sCMT2/JuGuu6Z1cGeaED7Q7XJgJrcU89YtUHe9rG5PVcbthRXjX7H3OWbWIwVtXATkXsJSJuTovInuMfhvcn8dc9hzrH5v/uzX2IiCBPQiEr8xZjJDcqz8ijw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-Network-Message-Id: f78e3ff8-4153-4816-b704-08d7ee541712
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2020 04:48:42.6641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X+Botq6XelsXq5gqzqgEzH0455Zh47ykMxZkxSNVtQE6kFSVGbGDxPpU6ZAWpFsw/zKXAKyZeU3fHyzenNS2aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB4010
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> -----Original Message-----
> From: linux-btrfs-owner@vger.kernel.org <linux-btrfs-
> owner@vger.kernel.org> On Behalf Of Zygo Blaxell
> Sent: Saturday, 2 May 2020 1:35 PM
> To: Phil Karn <karn@ka9q.net>
> Cc: Jean-Denis Girard <jd.girard@sysnux.pf>; linux-btrfs@vger.kernel.org
> Subject: Re: Extremely slow device removals
>=20
> On Fri, May 01, 2020 at 01:05:20AM -0700, Phil Karn wrote:
> > On 4/30/20 11:13, Jean-Denis Girard wrote:
> > >
> > > Hi Phil,
> > >
> > > I did something similar one month ago. It took less than 4 hours for
> > > 1.71 TiB of data:
> > >
> > > [xxx@taina ~]$ sudo btrfs replace status /home/SysNux Started on
> > > 21.Mar 11:13:20, finished on 21.Mar 15:06:33, 0 write errs, 0
> > > uncorr. read errs
> >
> > I just realized you did a *replace* rather than a *remove*. When I did
> > a replace on another drive, it also went much faster. It must copy the
> > data from the old drive to the new one in larger and/or more
> > contiguous chunks. It's only the remove operation that's painfully slow=
.
>=20
> "Replace" is a modified form of scrub which assumes that you want to
> reconstruct an entire drive instead of verifying an existing one.
> It reads and writes all the blocks roughly in physical disk order, and do=
esn't
> need to update any metadata since it's not changing any of the data as it
> passes through.
>=20
> "Delete" is resize to 0 followed by remove the empty device.  Resize requ=
ires
> relocating all data onto other disks--or other locations on the same disk=
--one
> extent at a time, and updating all of the reference pointers in the files=
ystem.
>=20
> The difference in speed can be several orders of magnitude.

Delete seems to work like a balance. I've had a totally unbalanced raid 1 a=
rray and after removing a single almost full drive all the remaining drives=
 are magically 50% full, down from 90% and up from 10%. It's a bit stressfu=
l when there is a missing disk as you can only delete a missing disk, not r=
eplace it.
It would be nice if BTRFS had some more smarts so it knows when to "balance=
" data, and when to simply "move/copy" a single copy of data.=20


Paul.

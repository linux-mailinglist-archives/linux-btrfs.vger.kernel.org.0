Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0D3421EB5
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 08:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhJEGNL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 02:13:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:58656 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbhJEGNK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 02:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633414280; x=1664950280;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=3z1xVT4AjVI9UjoH2jW1Cf7/LDGMjWC/IXUeEKjzBOM=;
  b=RLD2jyw8eDvF8u/9YqmdqDX6XuFuL5KFO1CaxJmtYYaC7xW6lxM7X04U
   zMAUVbxyb6xsO78ptMzOAEUeeTDg75SzQFniSCMSs7aOAw1sbs9afs49m
   mXTv5xpB+wEb48CgVpSofQ5693SgpeahLDWRSLyMq7AffyfnIwDR8E2qs
   E0UXxhCMZgxzQjwl77ZMTGf2MtC6h6VLTUU5Eh/HWsvZqzH8lMUy46OEQ
   vd7einCGC7MpvTFeZ13n7bM2ePjsuSuWQkcLSlN0uwFXiJdyu7+jaSSHU
   oNJWcEUTRvxEKk0SROuamCafUFqbo5Be+SZnqK9njz7Md+3or7HNPMBdp
   w==;
X-IronPort-AV: E=Sophos;i="5.85,347,1624291200"; 
   d="scan'208";a="180914179"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2021 14:11:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lf/1BYz2mYyVGIvf3virktPgTKKfnrxZQH+Ccymmg9KeDl89dQAHglTEfqMghaROsXv1onu3QvGdp9PxJYDlsysHQ3gO+xoFdqx9jODlZpXYmZV4NWmT04rpXWiOr3v7E8ROfg/gqiokAGYJrsxFQ0tRRdUlAXStPNMwJjH/suExjQXh8dJDJ1LHiuvK+EPL5pQQjJX6in8c1Mq1jIQqQnYyZKstRp0wVnkh1RT88fNktF0DENNqr9zTFHVsIIALt+m3j+ZfOxJ77eT4ov1ncZWRRc7krJiCjX6fmxPK3/wtsHXgAYioq8dPUGiP3USxf96/mbUi8B268BlLCepWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3z1xVT4AjVI9UjoH2jW1Cf7/LDGMjWC/IXUeEKjzBOM=;
 b=BFdxXHrpD3dwbquCPNi9OUjWpBZ0n0YoZ8gdg3vmSli8r4v6fyZIPI4KhcsfmtIHwJrb9lEEXPNLJYatvP3LPYaU6/+E9YtpRVwmjGMXa1gtHL+EiyPnjKS7YfYUWl/IlFPMfmZNUf52RwqkQCGdt9YeNexSHmhyT3NPMfaFjrt9FKOcBHUkrD85dz+o05XoE/c/vbvQQ0uz3FQ0BBp8uEpkfqYCGJMOe3Wfvrpf8W/UQOF3y9PbIquNFKTYRd9729UCKb4+NOPVPlh0SH1AMSIDaNbX9gky88WO4+UQMnnnT4iaCw5Fpj/eRNR7RjQGXnZSqurzyocpCc8f8zMIVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3z1xVT4AjVI9UjoH2jW1Cf7/LDGMjWC/IXUeEKjzBOM=;
 b=P5XBnH1uT+iGrbS1kCVi7Kt9EBx9KL0xmX0jwUTMzciMMQa9IceuNKa13NiQO/Uci7nAMXuSlo5ZKZhti+J6IYXZorRIOEqsiUjG9iyU8p7eEXaCPBqgX/oHxmm5GL2temiQ5DFYt99inJBAZMAAQUR1MUu3lTowiz1zaex58cU=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7775.namprd04.prod.outlook.com (2603:10b6:a03:3ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 06:11:18 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555%8]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 06:11:18 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/5] btrfs-progs: use direct-IO for zoned device
Thread-Topic: [PATCH 0/5] btrfs-progs: use direct-IO for zoned device
Thread-Index: AQHXs1ZmcoYKRsLonk+Yign1+z8S5Ku4bQaAgAHehwCAAIWOgIAJJ9WA
Date:   Tue, 5 Oct 2021 06:11:18 +0000
Message-ID: <20211005061117.evmfdzr6z3g5zzdx@naota-xeon>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
 <20210927215139.GJ9286@twin.jikos.cz>
 <20210929022422.mynjvx4angtb3vfi@naota-xeon>
 <20210929102223.GM9286@twin.jikos.cz>
In-Reply-To: <20210929102223.GM9286@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc389333-eed8-4297-b5d0-08d987c6f259
x-ms-traffictypediagnostic: SJ0PR04MB7775:
x-microsoft-antispam-prvs: <SJ0PR04MB7775435C1E9604C15BCDA3398CAF9@SJ0PR04MB7775.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vTsz5EV8QFuJWhoEF/1//GqyUKGX+o9r/n2oxrrniePvVuQoxV40AJi13WjctzFZ7zTBaU1JcrxRYY7hxYQdjWvxsOwXkiQK/KI5H/EVx9Ie1YPDs83P8QJjK2f/5PhpMP//48LCwcrouFh3gcwIjqnPZwiL7pZ0CdCM6/JO8R0IVvBvQHa7sj+NqYPipZBJ4xCbTRraeA9uwVNk0ywvl6crJtnLuhoYGoB0oIWvca+T02cVedTi+RBFOy4yWp0cnceSIHquJXAqK2reznhpTaE1Fg2Y0PPHf+eqAlVmREEbm3wSodhNSZXNl7D4UlI14AcqYwPl+19s9jnWJdpoLFnA4wi87zOAYX13NF+V4rm/lGr5XKxJt/Y7IpJmkF8PjEcz7mr5MJh/XazQraVzVoTPP2Hkry4Exk5qXmAbbopW+3Ys3uT42zfwKx2LXqvMe6KgGSMoplETfnHFNury6mSxGyTPgbaa+zM33bivXmgJtHMl6tuidcZk7aJBwnC6x+YEup9dABnKreLS8kuARNFUz5z6dyj9LxXXNJj+AC8GMsO5m2CxQ4pzIrAznQfuQO+WXWQtsAF4bfiD/p2GGeb/JNnC276mhLtpqnMJ0KT7naNTulWoryHXRwA5OdBtrDTjtWuxqRh2R8XxjU/bJRSZsLTFWsAbDn7EGz5uzcLB2TrMAi9VPkqTtNDCBHmZ7CdnGqflJRAiQzu6ImiOfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(186003)(83380400001)(2906002)(110136005)(6506007)(26005)(86362001)(38070700005)(316002)(38100700002)(6486002)(9686003)(66476007)(64756008)(66446008)(5660300002)(66556008)(508600001)(1076003)(91956017)(76116006)(8676002)(122000001)(71200400001)(66946007)(8936002)(33716001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?syVaOOqwCGzjhFmFu9fEMlNvFRyoKEgbeCZA99dFprM83ECiztmHcsiDrpB1?=
 =?us-ascii?Q?8eLq18O+TDoiJWdoYjpTW6qDblHCVQ7VRe9QULdbK+Ag0w5RFONlCHUjFTZ8?=
 =?us-ascii?Q?AgvS4riZlRgKW1kBmTJEBdF6zi5eYjBDWiHqVEQ1nbLa62If+ILNQd+g+4a+?=
 =?us-ascii?Q?sgofkNoHUL2Gilethl3KKk0B8UOc2/MYg8wq9RA6axbftYzi82UVlslK6St5?=
 =?us-ascii?Q?bIS9xniIJGzkosWUUalEP4BX/5UqN2r7xKnJRw5fopQKlZmNJHSINkJjj+Yz?=
 =?us-ascii?Q?cLqjHI6a/Ac0eGQgqLVxXRNjASpVBS+DGZH26e/LsDNQLFJW82obM2X1X+zB?=
 =?us-ascii?Q?xlWTPiHd15XT4NzUq9jIHpC+N34Z77LRTn2XjVH/2VpLZuKaHAN+gau+QKRu?=
 =?us-ascii?Q?O/7qkyChzLQWulua803DlcWWyFLzgVOC+splF2+H2pfCqOhw8BUfepgUTJ0h?=
 =?us-ascii?Q?3YWtqD3+5hN+bAbk9Tqx4VmNJdXgTQ9dStNj9k31pG1+7t9wjlubkwOCeudt?=
 =?us-ascii?Q?+eFTKlUSWaLgP0BNZLV67wFumqYgwiYugNVMus1jwxRTKlZptdAJDoYmi+00?=
 =?us-ascii?Q?JPDsLaQYfxXZUaDjgLb3kXrMOww8IXbz6ixdPgJae3pOmAON3t5BVrpCRMm/?=
 =?us-ascii?Q?hhXaL+N+hGJ9NZKwUHpAL3RNvYm11Xurjd0dlVwQ+avkag5wFTRp/VOa70o1?=
 =?us-ascii?Q?xFbll+yeTU4khnuqU1zIa2U3Hc0esGFlB53p7FYFjgAPeh7SFXMvH/d0WuNa?=
 =?us-ascii?Q?6JXrGVq3IwD4Eb0gZCCsGuNBnwBbzKedrXBmt4NiEPtnm4OYjuoGs3f4c8PA?=
 =?us-ascii?Q?0uuh4np0hVl+bZGErG9xBwrlb8us7rrIQI+ZkGcuREvBbNvWehLhba79EqoI?=
 =?us-ascii?Q?9LJBQ+zkMgmhVxU5ZIh+s+JbdUACUsakl1TVh3DZS7Af/fEaIp85YC4qjtaO?=
 =?us-ascii?Q?qlre7t/mq+5fNs0Y/NcO/yr9RbyHyRahUcoA8PVmfiTcgBShrkwbgkIbvhhY?=
 =?us-ascii?Q?fy1aPPhcg6IvNmB2N24Lt+VrnWmakOym6IbKJcHGCnH6m0INKDy+RqvOdnB9?=
 =?us-ascii?Q?ve9QRzQatLhoPrFaKD/rdB5dr8lhCHgL9lwEj/WHZ8Hzqi8O5zqgh7KRB0VS?=
 =?us-ascii?Q?xOSlmcpTFizHMf/DF8cdy5C02U1KG/IIMX8wpOXD6o0r5naV5bzW125tmzyW?=
 =?us-ascii?Q?PKrLqXvr+WixXfVZHwCJocdGuzbqqFYNcEeXb/oLK2HA1s3/HCCxZtZPVhsi?=
 =?us-ascii?Q?4yeTQ/IcE/VU9nPD4Vb3o6V/f+0Fe2vdvAi2RH+nUIYxVg3R1ZuKE5G3N98l?=
 =?us-ascii?Q?9ltQ5kk0dgAyIM3UGQv6tmhujyI0C02h0kvr3+zut/NW8Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5569F1B6440E2E41B8ADB630D05BC357@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc389333-eed8-4297-b5d0-08d987c6f259
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 06:11:18.7481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g1jmhXTySoZQvuxiP7q5f0zFzfD64Yqzk66b9kdo1DyQglGXP5JW/O6afCIKw6ojZnV8gi1MlAYQEcSarVDwUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7775
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 29, 2021 at 12:22:23PM +0200, David Sterba wrote:
> On Wed, Sep 29, 2021 at 02:24:22AM +0000, Naohiro Aota wrote:
> > On Mon, Sep 27, 2021 at 11:51:39PM +0200, David Sterba wrote:
> > > On Mon, Sep 27, 2021 at 01:15:49PM +0900, Naohiro Aota wrote:
> > > I was doing some btrfs-convert changes and found that it crashed, rou=
gh
> > > bisection points to this series. With the last patch applied, convert
> > > fails with the following ASAN error:
> >=20
> > It looks like eb->fs_info =3D=3D NULL at this point. In case of
> > btrfs-convert, we can assume it is non-zoned because we do not support
> > the converting on a zoned device (we can't create ext*, reiserfs on a
> > zoned device anyway).
>=20
> That would mean that extN/reiserfs was created on a zoned device. One
> can still do a image copy to a zoned device and then convert. Even if
> this is possible in theory I'd rather not allow that right now because
> there are probably more changes required to do full support.
>=20
> I've just noticed that ZONED bit is mistakenly among the feature flag
> bits allowed in convert. Added in 242c8328bcd55175 "btrfs-progs: zoned:
> add new ZONED feature flag":
>=20
> BTRFS_CONVERT_ALLOWED_FEATURES must not contain
> BTRFS_FEATURE_INCOMPAT_ZONED.

Oops, I thought I did not list BTRFS_FEATURE_INCOMPAT_ZONED in the
ALLOWED_FEATURES list. I'll fix it in the new series.

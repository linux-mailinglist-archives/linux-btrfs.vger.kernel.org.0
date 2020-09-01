Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C61525911B
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgIAOpP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 10:45:15 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45773 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgIAOpE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 10:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598971512; x=1630507512;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NTHYkGylvuwyoH8TwRwMFaoyxojSN2VG5KUDlN7O7g4=;
  b=S0Irv2Ve5nIUVcE4qv9vjV45oJOki6KQtHCubu5XYtzpxdbv55U2KKFy
   3p1rAoolwFQOUMWBd876X6doEciAYd7MCXDNTCrc19w4c8DUyj/KMFZwg
   peqLIHRWxRi9b4bcIaykvs4QewjelaOsCjfTjjYu4QEaJrschZGZdBWHu
   8sAgd9xnnV3nsztCB7jcZIpwETaRXQanuBb7BwRT+rFfLU/z8Gc+2jdbm
   HOH64QB1B9J9m3zRNNQslVolVuFmBaOQ8s6A7CM2oO72SpkPSJnfRxKU5
   E1+ySzdt8mVeDl5FmwOtygnQy/Oa0UEFNcUBfhE4ONsiTu+wt7kPtKbsU
   w==;
IronPort-SDR: oqFX0O2dAp3VtFJVuY6AMznCpz7GWr4bFAVSim5cdS1Eem9CLreu7VsnW9roTkSU/lNvk9mLge
 wucemnWAcY5yZLUwDw24/rqRUHEoTyQkkXbgsxE8LYzBeMXsbazr0vmDdiUP5OodgC9R4zoUoA
 Qob7gvisTJFuNK9qSckiXhsbxpGz+YiQwP4kP+/YQQ2bEm3RPF+PuxO6bXcjrlNCuYQi8hQIET
 LYENUuNsQucLEbC5xdvhRmDBgftuCHkLgvWY7BTivANiOPRVyuwC6h2LnTdLl7I/qKswnoqUBz
 egU=
X-IronPort-AV: E=Sophos;i="5.76,379,1592841600"; 
   d="scan'208";a="249580551"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2020 22:45:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vmty9NhkwMyBIuNQkDtM+dHxeoQZFu2v9XYhDWs1iqx52cEYe5LqEOGYbYcncj11vCb45OgBKrqWJmrpSKV75EQLamTb8lxPz51qrOUCVfm4Jb6BgcwBV6lxeh/Pn1T816Nu36Zt+ZaiMP4nPrA1Ig6uGHp3IizBblBFr6Pmbh0AS4MpKTtPCljeXdlO4waFrmoI3IWw2f/9g32EqPGuf5g3O5MVaK79naJk7ehjHpaNWr4XnTNrdFE0ggf+zpcbX7tzu0FjMvwZ6mGUtfEq6kLDZUhZNVI03a5ezHbljAmoEPyIdJ9X7iHTU5Owvq2XMnfVVJzLw5COXz7RsoXLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTjscjp3YkQ09EuKgkMekqLljGpxekEb3qWv62Xqll0=;
 b=P2Hvzxph+ZVHHb1dCGJlbYJP3KEhCTDQUdAHSDd273N3ahjOyNX1RighlMkw4iy738haxH6r5Dni3fdg9RBNizeBX4NYq6ML9K8yIWdMf+y3fB02YYPUuq0ln4pULTP3dGsHuJcbWLrheZ3TIPhTNZt3qqRyiwvP+QP6BtCYkSqm5Vw9LHEaCaiKGzodaT4ds/aopAh99U2Q72uhf/JkFq3uEdlYI43FPKACoNUNIH8i4LaWLzELCEcYOxt6HaYtiIAzNj3KTXfSVudFJuXWwe2S82U8ZIoEZ6omdJtKhiLI+K0gLUD9KqbO+QXDAAM6GgfXOBocrUfoBCrRI70gQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTjscjp3YkQ09EuKgkMekqLljGpxekEb3qWv62Xqll0=;
 b=Vjk5Dz+GAXS1+0P8UjbMxkYwewEhv0Ayx6kDh8VBCfX3DaGRAqfSRRJ2QtTkAPvpY1W+FHUs19B/fOWPjWzNfTuxUvXoUKVevnziPxy9xeA3uxVFaiSN1lG2gWGuan7FaOflqBWA8cAZBwWxe3fbj9KPhkm/2v7UJV/52kFYjHE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2239.namprd04.prod.outlook.com
 (2603:10b6:804:15::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Tue, 1 Sep
 2020 14:44:58 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Tue, 1 Sep 2020
 14:44:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Thread-Topic: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Thread-Index: AQHWgGDIsm2Q9fFDf0qcho+qy+MPJQ==
Date:   Tue, 1 Sep 2020 14:44:58 +0000
Message-ID: <SN4PR0401MB3598F35FDA34EF5DE377C2CE9B2E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <CAL3q7H6PqGagcRXoGswKhxyOJoFc23c7_1tTu183xCCiEPC5RQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:bd07:d1f9:7e6b:2014]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7b11ca0-8068-428f-100c-08d84e859998
x-ms-traffictypediagnostic: SN2PR04MB2239:
x-microsoft-antispam-prvs: <SN2PR04MB22399E3B759B30A554EBE76F9B2E0@SN2PR04MB2239.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N65Q8e2yy32KoO2kq0gSGqx2XnYsPEMfJXbWHDhimkDEEtmkHSgmKw9rMr0z9gzXVJhPquT5TTYcPDCYQjPIrGOVBVHvs48U2nBQKlyX/FHBIEEOIJ5MS5ycsPE9xt2ZA+CLfx8W4DFvPYyFgyfn7vgD6dbZ904vC2mZoXEJkd0qZeCPhkJfeR0ODSV4nAcT+nW7zaK+6dzkvyQokHBGA97J+cTslR1uXdSIF3OxdbP7A3Cb81tbUrPYXR2XyCijOlxcOTKhonZoM2/iPQt+aGPvTxsPCTG7je4oMgnWTnnLvF9yez266LM6FV26EsE8RKmoQBiTLoSZFHEJxA0YlJpRvT6wYULQK2y6n8MPOyjniv7moyakwqPVjjUNevRo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(4744005)(5660300002)(71200400001)(7696005)(8676002)(54906003)(8936002)(9686003)(6506007)(91956017)(66556008)(86362001)(64756008)(52536014)(66446008)(4326008)(55016002)(33656002)(186003)(316002)(83380400001)(2906002)(6916009)(66946007)(66476007)(76116006)(478600001)(53546011)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +nVxzKSsclp9gsbnufBXPf7BBEIceJs2vBJ1haznrwh/1R7LAt1XvpMpJTWVTUE88xt5RwG9m1HrYHidMQiR0gRuPOwKkBvAVmh4RV/C1LuIjAmbDOsi+DRlkkrEA0LqZukUYIuf5OeOI/vlpGeKJBouQAab4eqepg52BygkcVaTXry5X/5z91uqumD69XvDjo4h9sXELU/DKlWmny/OMSqldCSUePuZmn/kMDL+zH+kKgEPX8Zyse9XMMz7hW6RZT3T/LU/X4xdj0lw3Zw3Ji88vNscwGry+VNvrKfg6IIUqzlFatLhhhbPdIK3cSVrZpsiskK/UQ5huGug4C4lfxI+bvmW4YIo2zsdeUqx0G9nbgUJmlckhEss9Ko7jfKDSwIl8CI3CKuMNMLKWy96oPR7Y7PJgYtILM73MIxY0xYPeSy54B5tybwJ9MuNFirR3r2NjKXykUQE8nvIPeJJfBY2RFtO+g/84nt+GpJaN2hZziw9ajYd9PYAarvIlwhECrBxwsjlw7UZZfEtEkgb/n/NRtSVR8+cQz+yIxo6SPD7zuyFbEBY8XpoNx2cg7Fb5fakQH5XxtRZAQvza85CuFLot8RBny4nQT+5f+dSEa42Pvtjxs7Dc7/pCrfBi2NKeFm7uokaCIhjUks3nphemmvAxnRbU0evnM7K8dMkBqIf7KnycMhr7TKHUnDBquuYs0/KtUtg1kUHvlyPbo8y6w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b11ca0-8068-428f-100c-08d84e859998
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 14:44:58.5832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TcPytxRWgudSLpRfIEQMiktv983rYIfpvp9Owzm9prEI8Imts33c0/pEqysb3lvbFz9DkcNgoJMbHbdK181Kb+bzqoXvYnSizHlWT+XoWEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2239
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/09/2020 16:37, Filipe Manana wrote:=0A=
>> +               iocb->ki_flags |=3D IOCB_DSYNC;=0A=
> =0A=
> This should be set before calling generic_write_sync() above,=0A=
> otherwise we don't do the persistence required by dsync.=0A=
> =0A=
> I have to be honest, I don't like this approach that much, it's a bit=0A=
> fragile - what if some other code, invoked in between clearing and=0A=
> setting back the flag, needs that flag to operate correctly?=0A=
=0A=
Yes I don't like it either. =0A=
=0A=
I've compared btrfs to ext4 and xfs and both don't hold on the inode =0A=
lock for (nearly) the whole xxx_file_write_iter() time, so I think =0A=
the correct fix would be to relax this time. But I haven't found any =0A=
documentation yet on which functions need to be under the inode_lock =0A=
and which not.=0A=
=0A=
Any input is appreciated here.=0A=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179FE1A72F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 07:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405492AbgDNFZC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Apr 2020 01:25:02 -0400
Received: from mail-eopbgr1360089.outbound.protection.outlook.com ([40.107.136.89]:13824
        "EHLO AUS01-ME1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726552AbgDNFZA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Apr 2020 01:25:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWqCrDKnVaP2nAkXvtqiBwiDw2CR4EIL/zQUaSBmgydxUJ+uTx70zT0rQabAh4/UZQlAa1TlrLNG1x3D0sP76oY4wjw7FWZz8hDpaOWuvvhg1X81MrYT15QciqxQ0m6b8eyaOLchqGqW2BugxBylDBrfVknCuuUAsiykKZSJh3iVOr4bnO5JHBdvxqFXKf6//DCkHzpay34AEpCxAqDkVNKAMRreFXcNcnB7B2B+XUhuHyvPBd6JydDb5z4XfMdy3vb/wkA0j3AhqOfcHjH9HajHUc6ShKDzv7g/6Z9SZxJA7mVyOj/kqMMZMI/Yt8Pz2AZeK2cBfmTgXfuLbbWcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8y5DOPHWrlH36xON0o6vFrsNfA2xV+vvZ9UfHAKSFY=;
 b=Ufc5H75bLig7bqOu9vnWaAQk+og8hhW8LiCvZ+PxIerleMg85nH2jXlQdBqvagjp26H4B0FwRLMkGEa+UaPWN08iGFfwIO6f0oGhqLQsh4+7J9+yI+/Y3i1T45m4xlCYIKfQgJRKtFEInNdFEl7PNHPaP26OU7d7Rrl/0Q9BgNzrkiRAj1TOcTh60RbQPLW8bjU6haPInqBpIgQcjXsVQBVPIV5C3rSYFCFJBfQG1y6tnlV4AMCf2YbMVQcaTdcQ2et4Z6E2mGqfKMOJyH3zK1bD86quxR/4cUKlE2D96RrIsFY6W3uuNjZgQ5IwquNQkKtvqCcBYxahULukfaDQQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8y5DOPHWrlH36xON0o6vFrsNfA2xV+vvZ9UfHAKSFY=;
 b=m8jnUyW3zUzNGO9ttpUg6EQuL0aTM2SepzYfTH7yCjzkbYX2JNKTclbUBc4HiJcD1AowFI28HpvIAYw1OUflg+g5TpEZPaScHfAKATgKMQ9FIgS0DovFLrVdZ8gJOVqjSzxPb/UVklnSGm5afm+IZgYAbHaaqPEPZU71NKYtHnM=
Received: from SYBPR01MB3897.ausprd01.prod.outlook.com (20.177.136.214) by
 SYBPR01MB4987.ausprd01.prod.outlook.com (20.178.194.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.24; Tue, 14 Apr 2020 05:24:57 +0000
Received: from SYBPR01MB3897.ausprd01.prod.outlook.com
 ([fe80::995d:971d:a82:4664]) by SYBPR01MB3897.ausprd01.prod.outlook.com
 ([fe80::995d:971d:a82:4664%4]) with mapi id 15.20.2878.023; Tue, 14 Apr 2020
 05:24:57 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Goffredo Baroncelli <kreijack@libero.it>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: [PATCH] btrfs: add ssd_metadata mode
Thread-Topic: [PATCH] btrfs: add ssd_metadata mode
Thread-Index: AQHWCyPyrAVs+dijZkOOeChAwp/e4qh4Iy+Q
Date:   Tue, 14 Apr 2020 05:24:57 +0000
Message-ID: <SYBPR01MB38971513AF598BFF169A676A9EDA0@SYBPR01MB3897.ausprd01.prod.outlook.com>
References: <20200405082636.18016-1-kreijack@libero.it>
 <20200405082636.18016-2-kreijack@libero.it>
In-Reply-To: <20200405082636.18016-2-kreijack@libero.it>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=paul@pauljones.id.au; 
x-originating-ip: [60.241.229.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b90bf609-58e4-473a-cb28-08d7e0342ba1
x-ms-traffictypediagnostic: SYBPR01MB4987:
x-microsoft-antispam-prvs: <SYBPR01MB498707895D0BF4457BC0F63D9EDA0@SYBPR01MB4987.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYBPR01MB3897.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(136003)(39830400003)(376002)(346002)(366004)(66446008)(64756008)(508600001)(66476007)(66556008)(52536014)(6506007)(316002)(110136005)(71200400001)(86362001)(76116006)(53546011)(186003)(7696005)(5660300002)(33656002)(55016002)(26005)(66946007)(81156014)(8936002)(9686003)(2906002)(8676002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: pauljones.id.au does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0lr31RZPT+emsLY8g53wUxHZWaDRjrFoehGHaeDUBPFT/0Qry3PoxjsAnDZWrvGFrZnolpXKfAEMIL7suGFF1SNK4A8yNh8BPcxUwcMIbxBPR+IrVRcbb2D5KnraRLrLNopeCesUq9h/nqIjFhq/MxUDqZ9KBtxJrGrjRK/iucLHGhnJ3DA+qyoCeY6HQv1HqOF4INENcHlfm2ep2RGLrffon0skeEb7fhau62nIO0EqcUAvzZZSCemCquElUCRMWIpfJhn96PFDYNUSwILyH6s2FPyRqv3Pu3JHzJWin5aA1rvulJ9c/iQZ7UrAHpXnltOqHm/S0TTotojqZ4EFsqQXs1gJhzXHoEaPfU/WBS7B25o7XsBnOHCWoWAMVmOgEQhMpqncWgUj7zH4keR5oVz+9pGBMmHma7Yrktke/xAo4Gipi90hhmdmrMFwwXUX
x-ms-exchange-antispam-messagedata: akGyK7G8Xul93TFPdCOwvBGOvIsiA1XqEsY0oXX0vNbb44yr5NEQbx0bQJ7sXEcdCjGuRakpyxhZLscgeYHJwfRZdcm7lhll/099gEDLCxyc+2lCBqmM0Wu2lij9bQJmJb/zeTdiTy5QEA9RF4GmIg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-Network-Message-Id: b90bf609-58e4-473a-cb28-08d7e0342ba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 05:24:57.0579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08elP8VyHqJOfqDQRerz6VtbAdPaFMaQyAjGsn/rmi+NlvIX0F5BwW66SdPvtrYmpLUotkvR30D/+mbk8CF7gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB4987
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> -----Original Message-----
> From: linux-btrfs-owner@vger.kernel.org <linux-btrfs-
> owner@vger.kernel.org> On Behalf Of Goffredo Baroncelli
> Sent: Sunday, 5 April 2020 6:27 PM
> To: linux-btrfs@vger.kernel.org
> Cc: Michael <mclaud@roznica.com.ua>; Hugo Mills <hugo@carfax.org.uk>;
> Martin Svec <martin.svec@zoner.cz>; Wang Yugui <wangyugui@e16-
> tech.com>; Goffredo Baroncelli <kreijack@inwind.it>
> Subject: [PATCH] btrfs: add ssd_metadata mode
>=20
> From: Goffredo Baroncelli <kreijack@inwind.it>
>=20
> When this mode is enabled, the allocation policy of the chunk is so modif=
ied:
> - allocation of metadata chunk: priority is given to ssd disk.
> - allocation of data chunk: priority is given to a rotational disk.
>=20
> When a striped profile is involved (like RAID0,5,6), the logic is a bit m=
ore
> complex. If there are enough disks, the data profiles are stored on the
> rotational disks only; instead the metadata profiles are stored on the no=
n
> rotational disk only.
> If the disks are not enough, then the profiles is stored on all the disks=
.
>=20
> Example: assuming that sda, sdb, sdc are ssd disks, and sde, sdf are rota=
tional
> ones.
> A data profile raid6, will be stored on sda, sdb, sdc, sde, sdf (sde and =
sdf are
> not enough to host a raid5 profile).
> A metadata profile raid6, will be stored on sda, sdb, sdc (these are enou=
gh to
> host a raid6 profile).
>=20
> To enable this mode pass -o ssd_metadata at mount time.
>=20
> Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>

Tested-By: Paul Jones <paul@pauljones.id.au>

Using raid 1. Makes a surprising difference in speed, nearly as fast as whe=
n I was using dm-cache


Paul.

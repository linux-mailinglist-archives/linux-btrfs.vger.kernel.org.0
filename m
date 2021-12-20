Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C73547A569
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Dec 2021 08:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237717AbhLTHb6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 02:31:58 -0500
Received: from mail-sy4aus01on2069.outbound.protection.outlook.com ([40.107.107.69]:26533
        "EHLO AUS01-SY4-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232273AbhLTHb5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 02:31:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuMrqrl1Ul32jsdQp0P+JenMV4WaYB8ipkakDl5yQaWRzBu3gRzHcFr7fKgVRaNSF0RZ5UXUtjHBYIyvMrilr2BHox8YwiDL7F2dwfRipxQyx8o/X938XI8lpR28EUCLqH/VVwmqHYTeG0iaeRv0cVJ7c4c34zkv/72LljgeNMGECA9H6Hf+wcthYRbnIsWPnE7vLxPQSSjJT3v13iTZGGAHppQHNbhFZkmDUUdhg4GjYAT0FltvZHfjeBwM3ieRzlucj4qtMy5EaXruj5fey5fSK4UlQpuqwbvMOZTwHGX7F2AlY03q2EiD2mr1Ash7NozfRISOlEZuFeJc6wNjsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCvqR5ns7BnH8+od2fgLpe/94f7jDBDY1iqyKoSIDUY=;
 b=Mj4TLzMOb2mmuHp1oeNtb8ge6vRZotS4u/vEUtZl1QOBlNrJmCuS5xCkRvoh5ZtrGkYPZL1t6QPmYhuLNdse8hwcsFy43TOWgbm3sm02jYb1um7nKrgjd2DSJKVVJ34No3PAXwaqXsJ49Q6+xnYQw7iX0umz76C6oTua7EeczN0ZCVY70lqXRA2ZBGlpNbIHxmszG+QfzjkN1FC3UCzdfat4J/p9wW1VYTDsZT9xEtyejXOammnDs0lxbiiwzdRJPeOKM1WtWA5VGX9XgstPqknD0L/W89iOj3AW8f0UnqOJ4T0F939yOgY24fHA1yMv+3HsSsbng00TfROx2QXn9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCvqR5ns7BnH8+od2fgLpe/94f7jDBDY1iqyKoSIDUY=;
 b=KuZha3ri42NdMhwMJ4qHKfDFCaWjMEg8F1x2W4/+7fONdS3AvZzdFAcPjIW1DDGzRCo/G+BncRolMSvDTATWbsTfi4gGRNbfwDnNH44frZ4PwT5qIwF2cfH36dZ3julJk0EIvmu1k/jbrYBA0L8+luMNt96YXZH60SztpBQ3WVw=
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com (2603:10c6:0:2b::11) by
 SYBPR01MB6240.ausprd01.prod.outlook.com (2603:10c6:10:106::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Mon, 20 Dec 2021 07:31:54 +0000
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::1140:be98:7c93:495c]) by SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::1140:be98:7c93:495c%6]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 07:31:54 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: Unexpected behaviour(s) when moving a filesystem
Thread-Topic: Unexpected behaviour(s) when moving a filesystem
Thread-Index: Adf1ceX7GW+PKTnDT+6go3Dwaa8qOAAAWXIw
Date:   Mon, 20 Dec 2021 07:31:54 +0000
Message-ID: <SYXPR01MB19187E122FA3609B87EEA89B9E7B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
References: <SYXPR01MB191829975D48C8CE863888A19E7B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
In-Reply-To: <SYXPR01MB191829975D48C8CE863888A19E7B9@SYXPR01MB1918.ausprd01.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7715e589-62de-4221-dd89-08d9c38acc16
x-ms-traffictypediagnostic: SYBPR01MB6240:EE_
x-microsoft-antispam-prvs: <SYBPR01MB6240BE76986C426824FB15239E7B9@SYBPR01MB6240.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 86eq+TkqgGGqbRDZ0if0M4xSlZBLuo7YBNkEYXhpp7dAkasysTKsxIzc6F4y+8UTK6U9q/XsJCER3d6nEXyKXvXKJBORsdQEbOAe4z5MGAuI2wl2JprBNEzgyP2JU+XU8PI6PaoqQvSYErDtJNMqbQdsHpZO/Xudb04TOzSp3q4ga9uyK96NfGaRz4DsEz1IHWCeELIVi3GE9yM7tyw0ueDeX+1RxmR4R3+mb1N7Ob9p5MqCBt73JXv46j261EJfZP1wD3JJuA8YmXYB/si74rkfe69F4was0jJcxpPYLGNi5Di/uy3LSweiy9CvNUMIEFZCvzshsi/HMnIaEdDiBVwJAwUZP4AMb29gk6FiGfh4LzVXNjPs0SSd43YK21teakLEmr7gr9VKU65AWo8dBgB2OUgQ7+2NmnnUE2uDGkaE79dXH3hqK7IQzFhiijUbJWKVFK8SMjzoLP1uwQrpYZM75KpjYXubJXfq3f8CbO20Hpyxbag5RphYy9D8h5OIF0CfEauBlgS1L3rYY7X0LvUBS9FYoe27MdVBY1s1/0haKcIJkduMsCM9Z4VVwbGP3q5urRxqCiF+9KgLjiD4qc8YnOaAnUC/lsV5sttn5daHXzuBzCcvHG1nghm7aow+qL52aKCFFhRAo02+z1jKzhmRkp1s0f4KPR8bSAC7gwSED+nEGSA48VrXLc8oTasEh+o1N2nNZz1yeoz6H/ZUvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYXPR01MB1918.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(186003)(8676002)(64756008)(66446008)(66556008)(38070700005)(53546011)(8936002)(66946007)(38100700002)(66476007)(76116006)(52536014)(5660300002)(86362001)(110136005)(122000001)(9686003)(6506007)(316002)(33656002)(71200400001)(2940100002)(83380400001)(508600001)(55016003)(7696005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fOi3Gkg6c+Ip14XHSZSsV3QMSLT5VdnONotr0c/wWodDpDY5xxCNt3EOS7zK?=
 =?us-ascii?Q?011k2r5T8bnrZqSRxdhkj0aue39JYVr7oU250LkkhUBs4KDOyWX0cG8AGkm7?=
 =?us-ascii?Q?cZ9HuI25Eb/6PHLIgDQIn5V5NDbSCGsuRaRIBbqmsSOGahh8L50VZTrKzce5?=
 =?us-ascii?Q?Wi3W2yQ2MBS9WiUNp6qro2SaFmpaFP9Jvg7+8SFK95rMoVwsayFiq4IA1yFg?=
 =?us-ascii?Q?nJ++zh4ACUm/H0PdefW2jeF5RsMU8040ESGdTYYAwFJ4VR/pbko2RBINNhfP?=
 =?us-ascii?Q?l90qKb4PGyxDk6KfwgL77vYuEZvYJuwQBk/Q+Xe2kHiMy1CEWDNBkCIOR87R?=
 =?us-ascii?Q?mkvl3F1R9T6TTzWVndKrQOdt71p7SB2qRpKYogOSAc3UXLeBubtf3Syix9aQ?=
 =?us-ascii?Q?shdljgCsQZcBxYZkBOG655pDp9eaCRHpIMnbTPGVtal6gPqDQkUrwf1j0uI/?=
 =?us-ascii?Q?yDgFbWSQWYxnIkLqZyQZaPLx0GPTccSwjL9JWMwm+ymDKtcckm88VNUSPsBi?=
 =?us-ascii?Q?CE53uTch7mGaYQKkIMKi42gps0K0uoj+D9iFNHyLPVJ1sMz5LyJV/tyDRLKB?=
 =?us-ascii?Q?1wNqrmt0YhwBsv4F7JRMl9yN20SH/TNUoCf2Chan1DRrBDTcg+a33p4lLhOq?=
 =?us-ascii?Q?Ywxgl/6gWv6EWRHjLBhFRkEreKBnxBElXe2kCI5/pbUfpyNJw32NFSc1omWR?=
 =?us-ascii?Q?mWjDMW7zDUg/QrNDh36VL05UQ42qUxC6SYcNWhdHoKpuG40+vle9Iok0gph3?=
 =?us-ascii?Q?qDPr0GblUvKw/Q7HV3/dbMGFR5ln7XeVhwXbmbCuVB0S39H4BdSZSm8BmdJv?=
 =?us-ascii?Q?zk2ZJO03TkMtYzZsFaaMehdqIYf1AaKDgO8LMEwtMltQ8AfNpxdG83LbD5ft?=
 =?us-ascii?Q?HhtZ75kDCG9Y9tCG/nZCLvRJutXVY3nnCV46QhliL7U20A/NSdZZkOwWi/sO?=
 =?us-ascii?Q?8Tk/H+Tq4Y6VWR800L7wv1PL54+qC83T0ybN246VOxLMIlTAATtKH9tRgCVn?=
 =?us-ascii?Q?VePrKn054BN11Cy7+SGuz9znuwvflIPDPm2gYE7iSORjDd34p1m7af3xyP7r?=
 =?us-ascii?Q?V8sRTIaDUQeXPG3vCjR+MWLolswqffI3hc/0Sju7fdLcxnGsZnq+fq3YCcbl?=
 =?us-ascii?Q?CTCuvscZCrF3/tQfirDvOwYHBebS97pBb0/FHgeKD5KtHrQSSZeJNwJqnyJW?=
 =?us-ascii?Q?JeU6T7HXwazu+Lcvfj0LkdUskmPdtu1glHn9z6QfJZJxL5HPHwWq2wM5QqVe?=
 =?us-ascii?Q?G3XG5TlffTFwGIICLEG8/WV9IXOpDsp1wUDvvh+W/VEu2UulkEcXqEX7LLpm?=
 =?us-ascii?Q?VAgFfPq3fm4Dk6OU6ZfFDs0du757z4daOlY1MeSPSuoCFiqUDIGF7Kpr7XOs?=
 =?us-ascii?Q?e+NCKj8udA6YbwPeulmzKgCnrVEKhACnmJ3ZOgZ+w3Vc6aQsbkzOUyPwvY5C?=
 =?us-ascii?Q?DNyAfBD66em8c+HOZ/18Fdg4wGuW6e2Dmvrxa+5TXEA2ZWfIBdTe5mo4Kqbg?=
 =?us-ascii?Q?h+euzhdIXSinS4GenDOYJcSyVUSshpPx3Epyhfv/ytidURW6AxGRFACXf1zA?=
 =?us-ascii?Q?OJAYkOaKqMrr7Ay3e/eRy7XzE6ASiw5spjvt9Yiae8qX+Lxp1XZkXaN30/qQ?=
 =?us-ascii?Q?cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYXPR01MB1918.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7715e589-62de-4221-dd89-08d9c38acc16
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 07:31:54.5652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVol4tCkr3NhntBI37SbAE6vC7L/+yzP1LPD9LDWKCFHxP0nAOtDzcc0WXnB7sEhrXNBw0YWq53HWIqKihYkiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB6240
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> -----Original Message-----
> From: Paul Jones <paul@pauljones.id.au>
> Sent: Monday, 20 December 2021 6:21 PM
> To: linux-btrfs@vger.kernel.org
> Subject: Unexpected behaviour(s) when moving a filesystem
>=20
> Hi,
>=20
> I have a RAID1 filesystem which I am trying to resize (only one raid copy=
 on a
> particular disk). Original size is 180G, on the same sized partition. To =
do this
> online my plan was to move it to a temp disk, repartition the original, t=
hen
> move it back.
>=20
> Label: 'Root'  uuid: 58d27dbd-7c1e-4ef7-8d43-e93df1537b08
>         Total devices 2 FS bytes used 29.86GiB
>         devid   17 size 40.00GiB used 34.03GiB path /dev/sda1
>         devid   19 size 180.00GiB used 34.03GiB path /dev/sdc1
>=20
> 1st problem:
> The temp disk has 40G available, so I tried to resize to fit that. Even t=
hough
> only 31G was used, my first "btrfs fi res 17:40G /" resulted in a RO remo=
unt
> due to out of space. I doubt that is supposed to happen right?
> After a reboot I did "btrfs bal start -dusage=3D40 /" followed by resize =
which
> worked the second time (without deleting anything).
>=20
> 2nd problem:
> server ~ # fdisk -l /dev/sdh
>=20
> Device         Start       End  Sectors Size Type
> /dev/sdh1       2048  94373887 94371840  45G Linux filesystem
> /dev/sdh2   94373888 115345407 20971520  10G Linux filesystem
> /dev/sdh3  115345408 199231487 83886080  40G Linux filesystem
>=20
> server ~ # btrfs rep start /dev/sda1 /dev/sdh1 /
> ERROR: target device smaller than source device (required 195292208640
> bytes)
>=20
> I've now resized the devid to 40G which I'm quite sure will fit on a 45G
> partition right? I think the source size check should be against the file=
system
> size, not the partition size. I'm sure I've done this before without resi=
zing the
> partition, or is my memory wrong? Too bad if it's just a raw disk which c=
an't
> be resized.
>=20
> Anyway, I'll just use the much slower add/del method to get the job done.
> Thought the devs might like to know about these slight issues.


Just found another weird issue: trying to replace devices that don't exist =
on the filesystem gives no output and returns success:

server ~ # btrfs rep start /dev/sda3 /dev/sdh3 /
server ~ # echo $?
0






Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0433A472518
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Dec 2021 10:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbhLMJk6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Dec 2021 04:40:58 -0500
Received: from mail-me3aus01on2086.outbound.protection.outlook.com ([40.107.108.86]:52100
        "EHLO AUS01-ME3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234730AbhLMJjU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Dec 2021 04:39:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkF7yyPNM46lBbBEp4xxAXK3Con6/0qoRb4AC6EjBmABE30vEU92kcOESXjrtMBfT002w5Ntbs2mj3OAvmRHhrlKCUEVLvSReDnGaL9qD12GveaM1/1ruMI5WBhA5kTnBoSIA8ee8RlTLcyazKv3X+C9EdVZMlkOWuQDlvwlciG3a9ZzLm5bzp1YBObZ0vtPGzg34FGSIl6m4MtJ4Un3o/kEVLGzmgc8U5DnbnIgMQWJLn+XVKhYIFrnPEiUQBxS8V42pnafjLKxQlb8M8+NGjGOgxV6nIoZ4r01Ofj4KPF9vVEjbGQNcORUghjh8W3hFQG4pjYco2xXRwyYYqIMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YwKanYqqwvGVyd6Ej/kG+lpje/3U2qwhH8u8rZEJpw=;
 b=iMWxYEdGZKTN82addkCrH+nfe7JAeY5Uj9CLIBRwhbdo/++lH/z8Sx4TMoOsK1SxlndirIR9+nr4s7QtO3YPVsQnSSStv8uVTZH1IuskLrzr26jG55vectSj6GPe/gja9kMPYNdvrremLJDPsea+gu8jntQUXHffNTPqV/qR60r146vKJlI8t9d/iwwSmw2U1jgxFKpHoZG+gtAJ+mhZXZVO8XixS04Hl5ShaePOlc0krhzUHIezftL3BRiHBdWXW4lTMWSP3JuJCrZ6Ww3tbHfBzr8FG1QRTbWoDEM1N1A4gnSTZL2J2/4BpVKzzzRE3s/OsRekCAMrg1coxnHoVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YwKanYqqwvGVyd6Ej/kG+lpje/3U2qwhH8u8rZEJpw=;
 b=BIFadNQGqRd3rJNJRpQlki9J0MeSdrKSVZ3Z8G6Z+JW1XY0rLllgYN2Hi3/3ziG6AN/HY2SM6qsPeZrq+SgLsLYnudT/GP/m+Tx18Wd7To2imnDAZE4WqOie3Ito53Y/utQOu8QNz9pVzKZq+pT467BWU9tYWoMTS2PnPu8kDhM=
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com (2603:10c6:0:2b::11) by
 SYBPR01MB5583.ausprd01.prod.outlook.com (2603:10c6:10:e5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.16; Mon, 13 Dec 2021 09:39:15 +0000
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::4893:8e29:82ec:1dc5]) by SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::4893:8e29:82ec:1dc5%4]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 09:39:15 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Goffredo Baroncelli <kreijack@libero.it>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: RE: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Thread-Topic: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Thread-Index: AQHXyO1coPsLuEqH1EKv7+lQTcu8sKwwd1IQ
Date:   Mon, 13 Dec 2021 09:39:15 +0000
Message-ID: <SYXPR01MB1918689AF49BE6E6E031C8B69E749@SYXPR01MB1918.ausprd01.prod.outlook.com>
References: <cover.1635089352.git.kreijack@inwind.it>
In-Reply-To: <cover.1635089352.git.kreijack@inwind.it>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pauljones.id.au;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6da2852-5656-428c-5fb7-08d9be1c6d78
x-ms-traffictypediagnostic: SYBPR01MB5583:EE_
x-microsoft-antispam-prvs: <SYBPR01MB55838CEF4D1F9E89F098A90B9E749@SYBPR01MB5583.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aDjU2rduAfQR2P2kfBXpzi2CeJniEiR+2WiBAWsmDltv0po2CUHAW1gdx7TSx2obN1vYWNt1etdLzyNdDS9IlPnEWLyQU47IQk9qI3gEm42PXS7DLjbu99+9qgKGSrfOlPxlBqeloHEiIpPLrWF3gV5t8ptFBga1qApdipz6BnEZP8qRghVLijZCo3MdS41xEPUCiaM86VJriE7xnLa72CFfoBa6I5aM3uS9BIcdnaFJNhfXCLJZZCgtHiLjN7Plt0/uniqnRtrkpJxbrtDDHJpzxJzuHMU8V/MQT0sLzUNRjlGA+l/4Sd+Q6FMjce6njDFq3iZsHjw25spItaswYV7qiVS6jeXLTYx3phnwbxwhWCpzScJU66KIdSmaGqftVONUSSnm8CKKl715TQ2XKeBmy0Ic0Srx2jo6QCA9LTv6irFcZRcAR8zPD+C3Qe7IuqTdupPqsD0j24T93TakxDav19Fh67F45mZ7ZJTRrN7wxBgy8+w5yNOs4PpBjbOuv+iVXNur0ZXnFVOSOb7LR/ZeT0TE0oHaoubAUm9ttdM+cMo6ThcMZruCBeGoNT8appzN2wF+tUfPKoiEvQpAclpU02gN9UmHaBbS/ObkB81OM+QkHNBiRWb4pT2+q0GbXWy9gfn+V8rAk8AHoFrXxpb9AWHkZ91POGnyDjEF8p+X18wRqMgFN2H2jaI8aQ3wS9w/28mb+lQyc4NhQ5aG4+1IUjcFESQQNy4Kq9yL8wSyEs4aTE+8acWJT6oj1J7fOdquqIKkxdtvXu9/oPTCRSr4lb3b8PXwB8hhLEe6SUg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYXPR01MB1918.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39830400003)(366004)(396003)(966005)(52536014)(508600001)(38070700005)(76116006)(4326008)(54906003)(66476007)(64756008)(66946007)(8676002)(316002)(9686003)(110136005)(66446008)(71200400001)(6506007)(53546011)(83380400001)(5660300002)(66556008)(38100700002)(55016003)(33656002)(8936002)(86362001)(122000001)(7696005)(2906002)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/UfER6iBW5OW9+k8BasT9S3ZA7/Z5l6M1DC7QxdAMlKbukj0t2+QkAefczFa?=
 =?us-ascii?Q?9ue2JeD3aklxDYFawXlGfTtilT3EaVFg2WL5Utfl/mhdDMrc0PxdUV4z2Hhr?=
 =?us-ascii?Q?wPcZNhzoq+YrcJyVfiN6wMfNlixaXCoea6myibB42nkqdk9fyn5DoDNf1vab?=
 =?us-ascii?Q?SmouJ3GiXhO3Ynjs/evuED5ugMJ/iacWn/3hNiwqVOzDpVI71DE/kZ6Yo+i3?=
 =?us-ascii?Q?f3DvLv3kdFEcVRtYALMK+SgUjWuELkMlTN3kbtV+Y1OjUShdQchythXZA5M/?=
 =?us-ascii?Q?raixV7LRniLXRqPXIGJtKGh82xzCJWzUkesk6MEOdbe/dPWdzRhJwLgaeL0P?=
 =?us-ascii?Q?GD27zUfUFUQNQxdW0DMx58exJ/36D/npC0H2uk96bSY3qpeQlvgJrkYPMUsd?=
 =?us-ascii?Q?5PICZSEr2g75RzYTHSez3y2bn20tRClTT1yAOSI3IfkUjDDf9ppOYSKg9Inb?=
 =?us-ascii?Q?OCb16iwVvLliPKL/efaGMyu5hNPRchtcqQP9/CU4PDlfb2UWv9BT14b6s1Cf?=
 =?us-ascii?Q?BdUCJCulDL3aWwtxkMzG4+pFDFmuwGqF+WGJ4yMRARTFpJ14afSLzhId9Y+v?=
 =?us-ascii?Q?r0js7OjEB52hapdH9uz2vzW18cSnrRSdmTgWdKhl+ZlWXLhBUm2TITReQvvr?=
 =?us-ascii?Q?pqn9wlvz2x575zmO6sUFagBm4j7iHruqVcnLabkE5l6XjTuHZBVI3SGWJblj?=
 =?us-ascii?Q?pLZ6RmLDw3uZQ6ikT9xmfejt7jIPA8+JCogv7ZvGGSL5K/b/82nlzLs210Hz?=
 =?us-ascii?Q?Aq2F42Gg0ZHW471zbXteDpn3E5ezg5llpn86wfDOlvDvBUIcuV51PbEoBc++?=
 =?us-ascii?Q?Pxvp8cGyd2cqJ4BgEBiSVosps7rSWIvPwXEDIcJDW/sBoQULh5Eb2KByuAYc?=
 =?us-ascii?Q?KJMsmlAkAwtZP7J2MblJ58HjKUCRMfQwGsIhqZ3d3cCHpd8+KF6BAW7N0yEB?=
 =?us-ascii?Q?zqHWouJcWQ7wzCdcWtQRsX1AOTAwzOlVH4k+f0CWuD/owZe1+rORuwmOcIoI?=
 =?us-ascii?Q?PAhh0Jqgurb/F3at0kdudSsqKgAlvLjL2HcDlJ6/ujrh0OG5+77/iXf5bb8U?=
 =?us-ascii?Q?ZRG57kTdWzpgNf9jpo9lv+vw+aW3NZOUO6xoJUHn78zhdRD36vKB6jgbnNvC?=
 =?us-ascii?Q?7kWCkEo+nIjhrFxXEK/g2XqHGaAlWAQHo8cW4w2Uz7Lkn9WRbnuv8/9jStPF?=
 =?us-ascii?Q?w1/PqM5OxaWE/bQ+WCfmZj5OrVdo9uZNejCGcuDL95XU2OG9D5hzjCQGbr/C?=
 =?us-ascii?Q?FUyFp1WpB55+enQLR50wB1I5EYbandMFkbMG0ZfRCJN7z/H4+neBRP6CYOjv?=
 =?us-ascii?Q?nJlUAAtAgglVOfP4gYFlqsiHtJ91vULE87TkXrqUbZdqTunh2WButQ9/Evox?=
 =?us-ascii?Q?nd3gihhYkF2wi6HnZ4oL4P0j0NcVipngXCXINBBURbCD8ROBuE1nc1FaQqHM?=
 =?us-ascii?Q?mymBxhCtln3qwFpJaahSdA4Z2B+P421O97xlalX14NPnNMFuqJkyepYi32Zi?=
 =?us-ascii?Q?TDeHnUPdQo090zTlJYSls//M1tca5VcSEpKN4wP1M7ZQE2oEmMwaDzMCOU0O?=
 =?us-ascii?Q?sqbki6JaGktNSEWgbdvgXXloLpDsO0Paf0nRRUBS6Q8VToEIY2mkUp5Ut0FS?=
 =?us-ascii?Q?ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYXPR01MB1918.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6da2852-5656-428c-5fb7-08d9be1c6d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 09:39:15.3613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOT8lExU5G26gYeFrGMU8VryN2lzEIbRACP4lgGiH4HPyaq+sm6fOrGJP/jMgO7pnVCfD+vXng8le5IZF1WaZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBPR01MB5583
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> -----Original Message-----
> From: Goffredo Baroncelli <kreijack@tiscali.it>
> Sent: Monday, 25 October 2021 2:31 AM
> To: linux-btrfs@vger.kernel.org
> Cc: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>; Josef Bacik
> <josef@toxicpanda.com>; David Sterba <dsterba@suse.cz>; Sinnamohideen
> Shafeeq <shafeeqs@panasas.com>; Goffredo Baroncelli
> <kreijack@inwind.it>
> Subject: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
>=20
> From: Goffredo Baroncelli <kreijack@inwind.it>
>=20
> Hi all,
>=20
> This patches set was born after some discussion between me, Zygo and
> Josef.
> Some details can be found in https://github.com/btrfs/btrfs-todo/issues/1=
9.
>=20
> Some further information about a real use case can be found in
> https://lore.kernel.org/linux-
> btrfs/20210116002533.GE31381@hungrycats.org/
>=20
> Reently Shafeeq told me that he is interested too, due to the performance
> gain.
>=20
> In this revision I switched away from an ioctl API in favor of a sysfs AP=
I ( see
> patch #2 and #3).
>=20
> The idea behind this patches set, is to dedicate some disks (the fastest =
one)
> to the metadata chunk. My initial idea was a "soft" hint. However Zygo as=
ked
> an option for a "strong" hint (=3D=3D mandatory). The result is that each=
 disk can
> be "tagged" by one of the following flags:
> - BTRFS_DEV_ALLOCATION_METADATA_ONLY
> - BTRFS_DEV_ALLOCATION_PREFERRED_METADATA
> - BTRFS_DEV_ALLOCATION_PREFERRED_DATA
> - BTRFS_DEV_ALLOCATION_DATA_ONLY
>=20
> When the chunk allocator search a disks to allocate a chunk, scans the di=
sks in
> an order decided by these tags. For metadata, the order is:
> *_METADATA_ONLY
> *_PREFERRED_METADATA
> *_PREFERRED_DATA
>=20
> The *_DATA_ONLY are not eligible from metadata chunk allocation.
>=20
> For the data chunk, the order is reversed, and the *_METADATA_ONLY are
> excluded.
>=20
> The exact sort logic is to sort first for the "tag", and then for the spa=
ce
> available. If there is no space available, the next "tag" disks set are s=
elected.
>=20
> To set these tags, a new property called "allocation_hint" was created.
> There is a dedicated btrfs-prog patches set [[PATCH V5] btrfs-progs:
> allocation_hint disk property].
>=20
> $ sudo mount /dev/loop0 /mnt/test-btrfs/ $ for i in /dev/loop[0-9]; do su=
do
> ./btrfs prop get $i allocation_hint; done devid=3D1, path=3D/dev/loop0:
> allocation_hint=3DPREFERRED_METADATA
> devid=3D2, path=3D/dev/loop1: allocation_hint=3DPREFERRED_METADATA
> devid=3D3, path=3D/dev/loop2: allocation_hint=3DPREFERRED_DATA devid=3D4,
> path=3D/dev/loop3: allocation_hint=3DPREFERRED_DATA devid=3D5,
> path=3D/dev/loop4: allocation_hint=3DPREFERRED_DATA devid=3D6,
> path=3D/dev/loop5: allocation_hint=3DDATA_ONLY devid=3D7, path=3D/dev/loo=
p6:
> allocation_hint=3DMETADATA_ONLY devid=3D8, path=3D/dev/loop7:
> allocation_hint=3DMETADATA_ONLY
>=20
> $ sudo ./btrfs fi us /mnt/test-btrfs/
> Overall:
>     Device size:           2.75GiB
>     Device allocated:           1.34GiB
>     Device unallocated:           1.41GiB
>     Device missing:             0.00B
>     Used:             400.89MiB
>     Free (estimated):           1.04GiB    (min: 1.04GiB)
>     Data ratio:                  2.00
>     Metadata ratio:              1.00
>     Global reserve:           3.25MiB    (used: 0.00B)
>     Multiple profiles:                no
>=20
> Data,RAID1: Size:542.00MiB, Used:200.25MiB (36.95%)
>    /dev/loop0     288.00MiB
>    /dev/loop1     288.00MiB
>    /dev/loop2     127.00MiB
>    /dev/loop3     127.00MiB
>    /dev/loop4     127.00MiB
>    /dev/loop5     127.00MiB
>=20
> Metadata,single: Size:256.00MiB, Used:384.00KiB (0.15%)
>    /dev/loop1     256.00MiB
>=20
> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
>    /dev/loop0      32.00MiB
>=20
> Unallocated:
>    /dev/loop0     704.00MiB
>    /dev/loop1     480.00MiB
>    /dev/loop2       1.00MiB
>    /dev/loop3       1.00MiB
>    /dev/loop4       1.00MiB
>    /dev/loop5       1.00MiB
>    /dev/loop6     128.00MiB
>    /dev/loop7     128.00MiB
>=20
> # change the tag of some disks
>=20
> $ sudo ./btrfs prop set /dev/loop0 allocation_hint DATA_ONLY $ sudo ./btr=
fs
> prop set /dev/loop1 allocation_hint DATA_ONLY $ sudo ./btrfs prop set
> /dev/loop5 allocation_hint METADATA_ONLY
>=20
> $ for i in /dev/loop[0-9]; do sudo ./btrfs prop get $i allocation_hint; d=
one
> devid=3D1, path=3D/dev/loop0: allocation_hint=3DDATA_ONLY devid=3D2,
> path=3D/dev/loop1: allocation_hint=3DDATA_ONLY devid=3D3, path=3D/dev/loo=
p2:
> allocation_hint=3DPREFERRED_DATA devid=3D4, path=3D/dev/loop3:
> allocation_hint=3DPREFERRED_DATA devid=3D5, path=3D/dev/loop4:
> allocation_hint=3DPREFERRED_DATA devid=3D6, path=3D/dev/loop5:
> allocation_hint=3DMETADATA_ONLY devid=3D7, path=3D/dev/loop6:
> allocation_hint=3DMETADATA_ONLY devid=3D8, path=3D/dev/loop7:
> allocation_hint=3DMETADATA_ONLY
>=20
> $ sudo btrfs bal start --full-balance /mnt/test-btrfs/ $ sudo ./btrfs fi =
us
> /mnt/test-btrfs/
> Overall:
>     Device size:           2.75GiB
>     Device allocated:         735.00MiB
>     Device unallocated:           2.03GiB
>     Device missing:             0.00B
>     Used:             400.72MiB
>     Free (estimated):           1.10GiB    (min: 1.10GiB)
>     Data ratio:                  2.00
>     Metadata ratio:              1.00
>     Global reserve:           3.25MiB    (used: 0.00B)
>     Multiple profiles:                no
>=20
> Data,RAID1: Size:288.00MiB, Used:200.19MiB (69.51%)
>    /dev/loop0     288.00MiB
>    /dev/loop1     288.00MiB
>=20
> Metadata,single: Size:127.00MiB, Used:336.00KiB (0.26%)
>    /dev/loop5     127.00MiB
>=20
> System,single: Size:32.00MiB, Used:16.00KiB (0.05%)
>    /dev/loop7      32.00MiB
>=20
> Unallocated:
>    /dev/loop0     736.00MiB
>    /dev/loop1     736.00MiB
>    /dev/loop2     128.00MiB
>    /dev/loop3     128.00MiB
>    /dev/loop4     128.00MiB
>    /dev/loop5       1.00MiB
>    /dev/loop6     128.00MiB
>    /dev/loop7      96.00MiB
>=20
>=20
> #As you can see all the metadata were placed on the disk loop5/loop7 even=
 if
> #the most empty one are loop0 and loop1.
>=20
>=20
>=20
> TODO:
> - more tests
> - the tool which show the space available should consider the tagging (eg
>   the disks tagged by _METADATA_ONLY should be excluded from the data
>   availability)
>=20
>=20
> Comments are welcome
> BR
> G.Baroncelli


I've been running this patch series since about V4, works really well. Woul=
d be nice to have it merged eventually.

Tested By: Paul Jones <paul@pauljones.id.au>


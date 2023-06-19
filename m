Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4358D734B08
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jun 2023 06:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjFSEPW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jun 2023 00:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFSEPU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jun 2023 00:15:20 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA25127
        for <linux-btrfs@vger.kernel.org>; Sun, 18 Jun 2023 21:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1687148118; x=1718684118;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YP2Xhu+2kuUwo/RjKKdXBS6SVKE+7K5aLIxp5b0ykFQ=;
  b=e3tuVtCZyz6pvKxlINvQpjayBFC6DJD5Zlesef8pG/9KIrniCfM7Vg0e
   0XpYCQHqE7/6r7sUY3sCkeMv0ga1bae3/lWc8yE7ViQbCoP85IRUfAE9X
   xnwYi0chF6FD3v2JAqY7MhKh5C1FcDP20hrwr5fa9oi2qNSadD4MbdH42
   PtKdKhKbI8vrJDw6kTOeTGvSf8MC6BW+nKbgJEGE4DYQpVIee6JUBq3iy
   NJdSFG24K3Ns+scAsZhAw1g6fA2aeyb6PctVzPmO1iMKE0jhuerWHLpht
   pBvnntsjgjtx5VrnEjpNpVfniY42hNpw2d8/trCMLsx5vi0PKh41GhOEC
   w==;
X-IronPort-AV: E=Sophos;i="6.00,253,1681142400"; 
   d="scan'208";a="340926136"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2023 12:15:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvEM38E6x5XxS7VjMjmMZYPstd4q9soETxay9Oilyu4QQUQkxrEcHmGOFS9WSBKRbjJgSjp3TLNCzyU2Z6fmPfyF0NDUeSxZbsOwMU3RTBLUsN0C2smBdyS9qKyAWAed0gxWmXmQY7Q71WER26nyS5jHkIrQMuK8Py3fqjf3xDsZs1Fed6vQ8xDC7f3XszWnvZm3zoV5U85GHCp/Xr7MdJ0k2MfbYqHXcOCUyO47SZPJdJ9L9lQx1xHX9spham7B4k2MD1DpLx0OP7ZDlgkpISeQBg56UqoR4BnAxI5qxTr42syo3KfARdyGXFXtWz5A8C/VLpjEGo9ZKYkP4Acxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKXMSQm8tak2CiGAuI2uLd4KX/bBC2yT1WULVCcrUqM=;
 b=e2BhMhFXmlE8bG11IVYjhQp5Qxb88racYkYUC2y06EL1cp8BAaGed26gHVP26XZ72OFIS+ok3dy9AaU8k0OLcHPrulF08aTXYvlR1aZaIDDVsELE2/Q19/mLtQWObniAJh94U7fBejzkDlnJGHxIBZeXbe0mTgyxYzBb2gY/x5Sps6t9bwiEXIES8ph+QM+nUUKCOtzbZ/97GqCAbPEFriMxkth/IuRILuULDpJLQ/rC4ZpTJmFKRn290xuLIKq6m/i0I9CqgjPNVFti2WgUptkszoTKtgxEVJSlTHejJv+N69RU2nufuERLdMc1t6yjDxqjjEtK7xcrAUZxoGikjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKXMSQm8tak2CiGAuI2uLd4KX/bBC2yT1WULVCcrUqM=;
 b=PsmS0i6evK3CfMeJ+0ktdCKNHYbkDhcCpboNMXRpuRoEgMGdPZgqWsLZFUDXgRgtn1aqN4XxfFzUMHA/ornEvh2t2RyUlaS6VgJ6OwbCKbvyhJ4sFgVpt/smtxAe2pEc9YB6PTzDrchtnpmpQJwGQaRLq8OobUoin/MHnlX3SQ8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8490.namprd04.prod.outlook.com (2603:10b6:a03:4d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 04:15:15 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 04:15:15 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Qu Wenruo <wqu@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: add trace events for bio split at storage layer
Thread-Topic: [PATCH] btrfs: add trace events for bio split at storage layer
Thread-Index: AQHZokKysOz38KKFQkqwG5koi1xzya+RhMUA
Date:   Mon, 19 Jun 2023 04:15:15 +0000
Message-ID: <dlewtrufotjdnlj5bszhj4aj7a3exk7ag5dbm3f4e3z3mjbj7w@7r4c746p5suo>
References: <dd9a8794a1da2a4f3e7c47cc4df42ef972568ce4.1687133480.git.wqu@suse.com>
In-Reply-To: <dd9a8794a1da2a4f3e7c47cc4df42ef972568ce4.1687133480.git.wqu@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB8490:EE_
x-ms-office365-filtering-correlation-id: d22115a8-d149-4c78-e465-08db707bc89a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMdrRdWQHg6Ih04kCP3OcPus4cUSlDyrAT8iYykYE9WaiIkFdXBQl6JdIqTWFB2iHStT8OTrUJ8aT8XWvaNL6pTF4Zr92Tj9mBqc9SK23ybNKT/QrCT1bHWM/+odsLFawS4ZtFw8vFi5l1CiKWvJM0vG3lb4lmjI5qRRiDZW5ZrwCZdIFvZkG+3bcgCGmeYj86MljwsUBcCoOle6CSiPmpbqfAzPtuhS+PnZoiibuVSs5eVkleJ4My6uRLsQyceJwoJjrvU+9aDdbss7kJrZ2kgGBYP+unxJgcQ0C/MJFi8x9Wl+2yNLEQlhzBA+cO5nZ+T4Wc31qwBzrq6Mn3mSK1dr10ROwNNRBdVNarQQbkk3zbCsj0Cp3POqxc6wW+WPw/zKsYE9vXMRs+0DWaA1TV+QBAo1seI0aedXGvgsHXsWExIkiLSd3S3dd5mospPTD7Hha+TY76u7go5YSRuyjsYBTSf9lo97mLO4m/l0VySJy+iOZPueMGmd+uB4+gyvstcs8WZwQS6yKZnGw3NbzQ2rYNQCDMWkI5uXTRoCxfwPjGBUQP14i4bEhpcCG5aQdbjDbxkj3bjDE8k0g4m+XkRkFZtdqKfOYXCgofsSu9cXLLOamkXgy3c3jld9i2rU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(91956017)(82960400001)(86362001)(83380400001)(2906002)(38070700005)(122000001)(76116006)(5660300002)(4326008)(54906003)(66556008)(186003)(66946007)(8936002)(8676002)(64756008)(66446008)(66476007)(26005)(478600001)(38100700002)(41300700001)(6916009)(6512007)(9686003)(6506007)(6486002)(71200400001)(316002)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IU2S8umoNoGu/7cF7eo+EcdnBGEMckK5gDHdlLMmZMoaz7+GGCbQ+QlPWymY?=
 =?us-ascii?Q?Tn5fQFIK4AKnrx/Bp+IajgAO1HRBCy4ShVA3Qe4Qlkkml0aWbEZHjBVs2idw?=
 =?us-ascii?Q?inCxOABU8Q55GlMcY/ricOFexMAld+cTy+MIpKnulTiX7clLXOaTMnSFiWPo?=
 =?us-ascii?Q?1H4YCs6dWQ6yM74XFst3tG0OeiYl+6l9fbz8lxWMmdk5PSjTg9P1N5AFysbV?=
 =?us-ascii?Q?v23FnoRr9gw03Mh3CXEqcIV7ha08kN2Tlg5Rt/KRL8rm+xoutdI3FHvIDy75?=
 =?us-ascii?Q?4Ij3tQCEZj3PVkjOgDyscNldXzslP+9rDF3nqlBcjldA3av9ZutGBcvVadAZ?=
 =?us-ascii?Q?2yVhhKDqFclNwzi5OIgZT60YUkrMLsGddIWXe674m5sz5tNraplWX+oM4iUw?=
 =?us-ascii?Q?W0Z8ZnwvOXPEpT4c0Y8WJeDiHhWssApj3q9wWhtUVeh44GpIrkC0AZNIWocH?=
 =?us-ascii?Q?hH81Y0loD6UcgsAApPtq+jBy8l/ixiMisf95pBLEhbZmqHCZQiA98n3BgUI+?=
 =?us-ascii?Q?G3UcRbJZ44aAqoLHyjCYq3hye239Y6XByDOt5cLNAdn32jHZ1QZUUpG4av0O?=
 =?us-ascii?Q?ooX5HpBeR5AQ8lL63Z13ZAtyys6KkLaeOUtwBnE3igFpnUPXWjspE7rIJhof?=
 =?us-ascii?Q?xCu4cnEq3cbxHUrtuE17wNp+rFrSJei4xrHdhjoPTIJ/gk92XEjkokC8ANBn?=
 =?us-ascii?Q?wKR8dn3uOTPw4R4Uc0Wd0sf5tqc26y3xRbfa/LmZZhX8JDVxQxju7o6iBH+O?=
 =?us-ascii?Q?6T78ScZozAyDBKYuPKLtD/+jVbKL8iiJ54pmwgyc11szoKqRXqfhahU8mDoL?=
 =?us-ascii?Q?yIZ+9bwTHrWV43NFqQofssUB2xC7v1fGus8wIRrwp6zl+uViSfgGaKqMap4M?=
 =?us-ascii?Q?zLrZwjjpnbrYwqGd4FHFyQwvqAdd0u9b17B9+R2r1YvSDp49j0ckcRrI2zHf?=
 =?us-ascii?Q?WKp0rzt7wFSItc2tn7pfbrfVnNtyVwLrKJ7GUK3iLCFFDhiQ/IcQ7iujXyi8?=
 =?us-ascii?Q?o16uof55njtoL9815II3WVRQxO41alf+314GNIRHgp1NMRc6i6HQ1iRqfkST?=
 =?us-ascii?Q?zb61uVZp3EAlOq8U5IXDXLsK9dYRPmv0Jv0V+6EIVcafLh0Pd3JwXke65WJl?=
 =?us-ascii?Q?iVzQID95LsKCNpVJYHYfH63QvQzw9J4y1wL4okB6/LnHljyR/RLOcPph3cPI?=
 =?us-ascii?Q?2Dw4mnqCPirdEEf5zGqzuC7aDazaMxv8vihvdB60v/GgNFvGKn7cy3vJr3ce?=
 =?us-ascii?Q?dJIzZrUzeuWyIZrtKpgsdSQZPkvmym3pmXUWIEjqq6mcXeLW4MzHyCEImMT9?=
 =?us-ascii?Q?0olL2Y+/JFMCVWmkFOQTsRUcihTH+a/ZEP8dQHT9jU9vcnoXl9oiAI+uKqRU?=
 =?us-ascii?Q?U3bxNhFxPfLe0hg/1AISM/lBguBqXKz6301ioTBMhztDxm7DWCml56muHKIi?=
 =?us-ascii?Q?Unz7BjpA4d/y5do9sg+922vv1uCPMRheiCDxX6rLvAq5aIwBSF3PYMU1mL7n?=
 =?us-ascii?Q?3nfHrlLc43sLgO+p85jPMNyE/nZJmAkgXB7d9q4Hv5NSazNu7VTKKOKDMR5X?=
 =?us-ascii?Q?U3l0NFBqI0E0vKWc5b7bUxk39/ID11WoTY7xLpTTi15dUq4TX22qrFaPbA1F?=
 =?us-ascii?Q?Cw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE447706DACC204AA52F983D92A27894@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cubcfTtD1Ppc/sfgSgMRese3SsTFlY6YwTITx2rGHOcfo0OjXOCu6ZQ0L/HQVfqcSO3w/58nLvmZOL031oNiaVkI4N/lZ0HqnTEhN0S9cUv8Qwe1mKJjccvPZK9yaiq7fIV0fW1VMD/CvmktnX7WrxPn4bW0QuPbvsYAWfp6sINe8lXWi6o3tK9o36Ho4MaQKS/ldowEDCPg40jUsrC6GR0/v6s2JAhQNRiC1/2FVEikn90sZ6g5PDPqVf7OB7Bs29RwFmQ/HDgndGBHyX5zRo6TXVLlLIh43lzFYB3pFqc/kfC8E4XxY6KmZJqYJ2jQK0KNa1ZLvC9YjuHXpeBLXHqbiFQjJCoWpmLX6uK3S1MA/HHlTMdK93tWht4mt6+buJHjsgf4v83cq6+7sygiTXNroTvq0xYW1ygx1S8Otge0Kkxn8JTyG2ock6GMQ/cbW5dVginyuoTGnC3EXHNnVfj/VM1kLlMqOYIaWT7x5e4dbqzcTI95wO9mwNv6B/76Ak/KaNIR2rDvE6v+6nOlzH94hFT1zcyVzdr+yb3CrNMyoEwV5A/Xww4lUPirjtvFR9ZFEnFQad+NbH4ko1l3bzk4bip2my4xY4ResPut2AxU+JSSMaKku2swRhmd293trHBH7ZxD/8Tuaxfx1fg3xbas3tltedljdyyDGJ44dKs6/Cy/v8SL7QRFze8us0jcV5UYIRaYjJaJkCZDnKoz1YG1kQMDztB5EdjiEYeWmErjGt6vINdHLCVxdDpQypNqE4eDn1xNVDAaMdCe5DM5yjkNlt+tOS2uHFKQDJMLbnpMiOq6MDiNBSSfBOSoeCBd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d22115a8-d149-4c78-e465-08db707bc89a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 04:15:15.1501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 964JDz8HpQ1qs7EO+aR8A0TwRwXAd39ysscXHmc5PMM5ox/th55EQ/oiw1oCRphiUlNngYw4Ft+exJEBpoqWVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8490
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 19, 2023 at 08:11:37AM +0800, Qu Wenruo wrote:
> [BACKGROUND]
> David recently reported some weird RAID56 errors where huge btrfs bio
> (tens of MiBs) is directly passed to RAID56 path, without proper bio
> split.
>=20
> To my surprise, there is no trace events around the bio split code of
> storage layer.
>=20
> [NEW TRACE EVENTS]
> This patch would add 3 new trace events:
>=20
> - trace_initial_bbio()
> - trace_before_split_bbio()
> - trace_after_split_bbio()
>=20
> The example output would look like the following (headers and uuid
> removed):
>=20
>     initial_bbio: root=3D5 ino=3D257 logical=3D389152768 length=3D524288 =
opf=3D0x1 mirror_num=3D0 map_length=3D-1
>     before_split_bbio: root=3D5 ino=3D257 logical=3D389152768 length=3D52=
4288 opf=3D0x1 mirror_num=3D0 map_length=3D131072
>     after_split_bbio: root=3D5 ino=3D257 logical=3D389152768 length=3D131=
072 opf=3D0x1 mirror_num=3D0 map_length=3D131072
>     before_split_bbio: root=3D5 ino=3D257 logical=3D389283840 length=3D39=
3216 opf=3D0x1 mirror_num=3D0 map_length=3D131072
>     after_split_bbio: root=3D5 ino=3D257 logical=3D389283840 length=3D131=
072 opf=3D0x1 mirror_num=3D0 map_length=3D131072
>     before_split_bbio: root=3D5 ino=3D257 logical=3D389414912 length=3D26=
2144 opf=3D0x1 mirror_num=3D0 map_length=3D131072
>     after_split_bbio: root=3D5 ino=3D257 logical=3D389414912 length=3D131=
072 opf=3D0x1 mirror_num=3D0 map_length=3D131072
>     before_split_bbio: root=3D5 ino=3D257 logical=3D389545984 length=3D13=
1072 opf=3D0x1 mirror_num=3D0 map_length=3D131072
>=20
> The above lines show a 512K bbio submitted, then it got split by each
> 128K boundary (this is a 3 disks RAID5).
>=20
>     initial_bbio: root=3D1 ino=3D1 logical=3D30441472 length=3D16384 opf=
=3D0x1 mirror_num=3D0 map_length=3D-1
>     before_split_bbio: root=3D1 ino=3D1 logical=3D30441472 length=3D16384=
 opf=3D0x1 mirror_num=3D0 map_length=3D16384
>     initial_bbio: root=3D1 ino=3D1 logical=3D30457856 length=3D16384 opf=
=3D0x1 mirror_num=3D0 map_length=3D-1
>     before_split_bbio: root=3D1 ino=3D1 logical=3D30457856 length=3D16384=
 opf=3D0x1 mirror_num=3D0 map_length=3D16384
>=20
> And the above lines are metadata writes which didn't need to be split at
> all.
>=20
> These new events should allow us to debug bio split related problems
> easier.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/bio.c               |  4 +++
>  include/trace/events/btrfs.h | 51 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>=20
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 12b12443efaa..204c30391086 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -669,9 +669,12 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbi=
o, int mirror_num)
>  	if (use_append)
>  		map_length =3D min(map_length, fs_info->max_zone_append_size);
> =20
> +	trace_before_split_bbio(bbio, mirror_num, map_length);
> +
>  	if (map_length < length) {
>  		bbio =3D btrfs_split_bio(fs_info, bbio, map_length, use_append);
>  		bio =3D &bbio->bio;
> +		trace_after_split_bbio(bbio, mirror_num, map_length);
>  	}
> =20
>  	/*
> @@ -731,6 +734,7 @@ void btrfs_submit_bio(struct btrfs_bio *bbio, int mir=
ror_num)
>  	/* If bbio->inode is not populated, its file_offset must be 0. */
>  	ASSERT(bbio->inode || bbio->file_offset =3D=3D 0);
> =20
> +	trace_initial_bbio(bbio, mirror_num, -1);
>  	while (!btrfs_submit_chunk(bbio, mirror_num))
>  		;
>  }
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index c6eee9b414cf..1e6d87abd677 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -31,6 +31,7 @@ struct extent_io_tree;
>  struct prelim_ref;
>  struct btrfs_space_info;
>  struct btrfs_raid_bio;
> +struct btrfs_bio;
>  struct raid56_bio_trace_info;
>  struct find_free_extent_ctl;
> =20
> @@ -2521,6 +2522,56 @@ DEFINE_EVENT(btrfs_raid56_bio, raid56_scrub_read_r=
ecover,
>  	TP_ARGS(rbio, bio, trace_info)
>  );
> =20
> +DECLARE_EVENT_CLASS(btrfs_bio,
> +
> +	TP_PROTO(const struct btrfs_bio *bbio, int mirror_num, u64 map_length),
> +
> +	TP_ARGS(bbio, mirror_num, map_length),
> +
> +	TP_STRUCT__entry_btrfs(
> +		__field(	u64,	logical		)
> +		__field(	u64,	root		)
> +		__field(	u64,	ino		)
> +		__field(	s64,	map_length	)
> +		__field(	u32,	length		)
> +		__field(	int,	mirror_num	)
> +		__field(	u8,	opf		)
> +	),
> +
> +	TP_fast_assign_btrfs(bbio->fs_info,
> +		__entry->logical	=3D bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT;
> +		__entry->length		=3D bbio->bio.bi_iter.bi_size;
> +		__entry->map_length	=3D map_length;
> +		__entry->mirror_num	=3D mirror_num;
> +		__entry->opf		=3D bio_op(&bbio->bio);
> +		__entry->root		=3D bbio->inode ?
> +					  bbio->inode->root->root_key.objectid : 0;

Can't we use show_root_type() here?

Other than that, looks good to me.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=

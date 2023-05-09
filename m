Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2326FCDCD
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 20:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjEIS3V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 14:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEIS3T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 14:29:19 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5018107
        for <linux-btrfs@vger.kernel.org>; Tue,  9 May 2023 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683656958; x=1715192958;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=BztUoYL/eaepAJ0LjGhveheP6tQ/LPJN4nExkoqbn/k=;
  b=Ky6nwQeVDfY//c+HG7gIJpaH8XLOOeGjSibyDOMVCN/VeJxUYafcNnak
   7grCKf91YREO3sZzWRgJAzlW9IKUO0Dt4UWKY3vEOKgOQ6aHvqWfUu36m
   mLhqcS3/CA/RE/Q4rbj/3ztxhl2u+3xtXKDz79xubY7gLweRLhDeFsSjd
   cQ1C8XmuUIScnLpl6oeVJLHq7uQBNdPPAcT2uEuuHPSuNlYs09YYMnuxg
   2fRly86YhZ9Mk+n0cwWsgv7fNM03OhTkEAFyayfcMnQcxciEkVhQQ/fUU
   ItLHNOIlcDPfsl3MQ+Tv3fe2MWCkZ1Fi3m/TD44CgtZqrgMQ4Rv9lKXpH
   A==;
X-IronPort-AV: E=Sophos;i="5.99,262,1677513600"; 
   d="scan'208";a="235235476"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2023 02:29:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnPIU/efiRIIjXtkU77jzQFnnDdyBsYRk302p/tvHjgQThV04GtSI2/d28p+0Jz1AgUYpA/9JnTKiifkoPKDubvfGwAb0UmY4kvkiUVyJz6uPlApmp95ym/OR4D0RV0jdgM4FVbvBYVGF4xQO5A4gS82qsIuk3XcJ3O8IRtfZsITVdtvu3RBAChYPSqil9cRzHx8GqD35+mNR5VvW7pPPj0xMMSGDSOezmn2SkgCNd1uH1qMUvGBmzWgONXBmO9YNBeVqdhxJyyHI1Loz4wjs4S2ac1wepCr6z8KUtm/jGwLhfiZ7QR6Eb1iewGEFrJB3CZ7ehvKGkPSZSEQF1NweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vera7nO7M71C77DZNGvhOBQBxFdQijO4Kyu3laPFgMY=;
 b=jCzCPBmHmDFlcLEhSAkLVwjfTHm0K/AeMrziKIQWnNaFte1YVyAVgFJ93LrHY9qEVgczhKdz2bvgsCY1yAmw3JbTmkvWZQp0qCkRcxBAbPYEc3NUUTEO2Ogi0cnRfiYaCf9vu3HmjZ3MFVmVN6IZM+FwrhwQlCNBJwoiS7rGg7Ui/uydfbXvENEC0uQ8afBPyZqGl5cEIRsBgn6kFrYEdsXw0v0qHOHzVOtfxUuSdhi13xe07XDjLMzFhGBf4a8Sj11ibrbLnommUkYs+yuXS64lv4NFVYF6Y3zS+onyHy0cbaAr5QOBBwn3LGjeXdslY+ufqrVVOvhJSDEDEK8bYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vera7nO7M71C77DZNGvhOBQBxFdQijO4Kyu3laPFgMY=;
 b=K4f/wu1L2AISK863yEebAT2Uua4ihk6LuYq1jxuI39uo3FEjDfPBoZJIzAnY69Cx86imq2E56Jpt/ZUrPXzPovJARGlOjpVaLM++RxboU2iYT9R1whQL4UubBEzr9ZDJJPIwRXQBxZEPUxwdyxiuHoZ/XbIgN4+hAeAvnZIK6NE=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB7050.namprd04.prod.outlook.com (2603:10b6:5:242::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Tue, 9 May
 2023 18:29:16 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::b52e:3dc8:52f:b0cd%7]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 18:29:15 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH] btrfs: zoned: fix full zone SB reading on ZNS
Thread-Topic: [PATCH] btrfs: zoned: fix full zone SB reading on ZNS
Thread-Index: AQHZgqQoUX9kurJh40mMgmNliEZiNQ==
Date:   Tue, 9 May 2023 18:29:15 +0000
Message-ID: <1932c39db3905ca491009e9956afe511d7b4767c.1683656399.git.naohiro.aota@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.40.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB7050:EE_
x-ms-office365-filtering-correlation-id: 1a9237c9-2d27-40ac-f845-08db50bb4b27
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: enrenxeb/ru8aQaV6msSGfDQzVEtF4o2z9udYqqAsC8k110lxeB9aKO0u1TowQQwCvy3lnJORO3yXnR3BvSAgSCHPRgWizYTRJDOfFxrFSGMoWVdyB3HXOLPrI/LZi5VSB9q56X030Uo28tDUjE1FM5cwywaiSYojBm19wJwHb7G/Efx9McdMLR1M9YJGNKT5l5K3Ed2jAxq4YZ/H/WHKLFp4y549tNTP4LdcT7+LZQTFMtvGEPznaFUcYsRZn9N0e1abXorKxBuulU47lsoYmu6OGwy7+jRvz8unfBu5QrXpzz+1V6rrpCsesWNmTFWNMcHYNXXmhQd9YZWYKNPGqz/sYPDpMdBeKkqWzAJ77AxNFqDliDmoI6dMctIY1xgqR8jPdO45Pwus2VrwSep90EnkVXbElURmnVDrFBhgYsJACJAOWdTwf+yJGxxKkfxjQHrHFFcMRhRK8Kh9C3t/Kp1HLZl0+WnlD28fOSrx8Pl3jlyf8L2khwq2Ex4WvrVH4r40lgR/kgH7H8++MeMEyVuzn2i2dFaaVHxB/DdXsw0odd4G+GX/m6GQ/LUxH6DYGCjGKL+cdLa5YLd5XGPcg+jBY0/6Li4ul0AJ6b2M8I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199021)(66556008)(66476007)(66946007)(91956017)(71200400001)(76116006)(6916009)(4326008)(66446008)(64756008)(8936002)(8676002)(5660300002)(26005)(478600001)(316002)(41300700001)(6486002)(6512007)(6506007)(2906002)(2616005)(83380400001)(186003)(122000001)(82960400001)(86362001)(38070700005)(38100700002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1Ng8+aDP4J+22y2v2ATkxdgVBh4Pnn/OXyrsCOVHk489XPhyuMpJTArSBX?=
 =?iso-8859-1?Q?wR/xRAcgpaqL330LNJYoe+HbAleUPRl3ln6EcqenUTF1ZdT2yvlzMiS7CV?=
 =?iso-8859-1?Q?bc962WMuDtyxbOhjQ0fnUh28udkh7OgdV5Iasg+pwxG36NZQeq3i5kCv+W?=
 =?iso-8859-1?Q?Kosfrtw4NYU8YJut1HnPKB7WoTziRLRRtmQLvflswuz7/9vj9ZJyUnAbQm?=
 =?iso-8859-1?Q?lwd3YG6ZhPLrrXbza46lVH8+wVmEFrmBEOZPQU7e7lU/3nVvkgxueBKiIK?=
 =?iso-8859-1?Q?9UT/Yn/RZ0rAZcPz9Fyj6pqgey2w/RtiwgrhYEr+K7kS9kfiZ3FoCwHJJG?=
 =?iso-8859-1?Q?EKv15Fz5zsz6bm+GSnn7fdTAW/2QabRPg/PrVSGYJtcsuPaAxH19UGooRd?=
 =?iso-8859-1?Q?VYxQRdWpev0i/Xo4PoZD1cRRqgPQL6oOlBLi1GoNN/NXwqrABge3iXVBDU?=
 =?iso-8859-1?Q?kfHfPVP7nBP5EwFyp/Fs/mILW6z8GU/n19lTM2loGLaNQM8aUuf8zowXYI?=
 =?iso-8859-1?Q?4riRE717HAkWbMqWU7TFdtK4Cm5DXPjLpGgZjBhTt5tixQhs9e60GcCedJ?=
 =?iso-8859-1?Q?26h+ZpFRA7YKSZzetp2eIhF8g40rnDFq0TAende3tAWnS6fhIDi0AfwJvY?=
 =?iso-8859-1?Q?n4LHXMDuzPd0+CpQlG3C3sDnk8/snt01zEU811rtQyXDcYZ2nkZ4G/ufQx?=
 =?iso-8859-1?Q?fXZ8GLrtjbebC+lmDTAZGaY+trONCAOnipsPkrt2GWC4OuIdTdIqm/VaQO?=
 =?iso-8859-1?Q?ExRdZGXPhjYROwWgb8jzJ+zGV4Mw8W3yyJaXecVqyGhUOMxyCdkq6lnMXj?=
 =?iso-8859-1?Q?ouZ8JDO9IlRyLyWjvI7OewsTlPJ0Whi08LWGB8jfMZmgZ6Kr+31na73ISY?=
 =?iso-8859-1?Q?l+SutUv84TESBZaBEfaNA2XuNqBZLYbg1YQ7twNAqkcGlG54O3OyVE5nCw?=
 =?iso-8859-1?Q?ckhfF6T7SQldSr65iIqT1iEbxPr5+769phZ5tgoTQ8bhXIjCn1/he7rDKl?=
 =?iso-8859-1?Q?DZ/wozqBdcIVjCTGVWVf2FoAGsznFUBpIYe9fNJQntagcnS+bc9XjzHKDs?=
 =?iso-8859-1?Q?LjtqLhLV8rjf6E8pOlG3UhIf8XtgcDztwbH4R8/fOBoLwd3EqJNV8DY0Pl?=
 =?iso-8859-1?Q?+C3PXhXcJCWtgmIwXexGxOET9u2cVpjHaN0uBbyv1QV3Oep1S3nG8Pjbhp?=
 =?iso-8859-1?Q?GN2eCM0dTmYPAeO17T//xPDL4UH/7uHNcS3//Xnr99OtusP2dhFINPPNdY?=
 =?iso-8859-1?Q?6D3HaFHkZI6+SwkMQxuN3ANlICUzpJAciS8hhVysqLMFl9FQvWafw/WsHV?=
 =?iso-8859-1?Q?Wro7zt44jzvSU37qU/87ATM1feHvr2rxRjIdba6Ju2ijqAYKN7RTBYv3FD?=
 =?iso-8859-1?Q?dYsickeavqIAqIqLK8kuUAgBLUBhgRse25af/15Z7tCqZyP0SQHXCJNSGN?=
 =?iso-8859-1?Q?NF6ZVuYK3CC60d7g4VUWr3CTBHdpdLwDgh8k3MeFFj6/FT5CemLi8IHaAM?=
 =?iso-8859-1?Q?hR+S6KjBED/I86XQsFjpLWBknAekNSXJAB6QYb6Ao6B882/tsUNC7O67i+?=
 =?iso-8859-1?Q?lEqo8GU2Kz+ljIVSgGR2YVqzGrhkkvHsvzEMsr3FKFGeb/YjOb/lywMiqd?=
 =?iso-8859-1?Q?pdF4KhaZ7WwFoDRrN7ozGUxm7D57rOAzUi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: l/6mGPqv0baEln2iiN3DJDp2F1kz2iFfZWBk3G63III5Og32FKIZGBxcbGix9pleSRzslBwwGRd13PgaatbQkECB0jA5DAk0mup9CJzSLTmGEKrUSfPEtfAQ3e+P5J5/akR7vdVjpkGOvwpWRaqhNV7V7zY+sch0DiZRr6oX0L31i0rmkj186Uw4VoQTi3ehUJFrNsrtbfI4so/Oy5XsEZ7FgpHu8vqj7H9c7qgS7CvtYERIx/mnRvnl2TKcYhVA87pMHq28uV/OI+MaEX1zs243TSFTxGnPPOzWhyioxuKAQTXtlikQ0SpA91nsSFylbXJjrEfLmsz4qnQD+pqC1JMPCQiQCYY8iZezU+AE9rOLP9IeWHJUJn+kE6bsu7DgVmo8z9Gy8OvjmRzSv/nE0vbhO585YUfiECWPMhmemamsVbMiaJ7DmSjL1wcKisq8mx3oLOowQ602iJvZFg0GYIA50jqtV8EEokt93kRxOuffxA6sa2VOm63zM1RF8rg9d0bbHxZ6gLXLQ2Klwj0/uybP6E5Hr+47OQre7g+RxLOc9/v7HqV3WzAsT5mR6X3a9/oaCH6STn2CbmC/FfuACrNWBpkLj3EAnLFXkZraH8EptbYUPSdRmL9iavFePTCvC9TMLm0Nf2zn6Mg17KihXpyyFpwQOsOW+v7vXdBtFMqHa5AB1zFOWhlyq40Es896n5ef0VRsi+bw2SIwj+UxQypXIW4UDKI60fw3VbkZDf6joV4XRdZKaqu8rdgHe2J6mx55/BMzXIL+PPYK4d+i/g==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9237c9-2d27-40ac-f845-08db50bb4b27
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2023 18:29:15.2556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NN5TREiRq8qlgd5wQStBrxyH/4BqxZCU6yssCDjm8+NfoIjjwF5uUm+WYqmyrcMYDrRCrqZXezWkHdvReunQrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7050
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When both of the superblock zones are full, we need to check which
superblock is newer. The calculation of last superblock position is wrong
as it does not consider zone_capacity. Fix it.

Fixes: 9658b72ef300 ("btrfs: zoned: locate superblock position using zone c=
apacity")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e3fe02aae641..cd1fee22998c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -122,10 +122,9 @@ static int sb_write_pointer(struct block_device *bdev,=
 struct blk_zone *zones,
 		int i;
=20
 		for (i =3D 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
-			u64 bytenr;
-
-			bytenr =3D ((zones[i].start + zones[i].len)
-				   << SECTOR_SHIFT) - BTRFS_SUPER_INFO_SIZE;
+			u64 zone_end =3D (zones[i].start + zones[i].capacity) << SECTOR_SHIFT;
+			u64 bytenr =3D ALIGN_DOWN(zone_end, BTRFS_SUPER_INFO_SIZE) -
+				BTRFS_SUPER_INFO_SIZE;
=20
 			page[i] =3D read_cache_page_gfp(mapping,
 					bytenr >> PAGE_SHIFT, GFP_NOFS);
--=20
2.40.1

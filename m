Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84BE52A677
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 17:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350075AbiEQPY6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 11:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350006AbiEQPYc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 11:24:32 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FA95001A
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 08:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652801068; x=1684337068;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=C1NTuiC0lXbI9REMoGxFdqH8TSTYfk1bgKRqgOWqbNU=;
  b=dkYfZCofmkd3tskbVQJXV3eYotI+FpvjmLlVCFYOLAyYzVPDlLknF+hz
   j3snKruqe4j1tZjIXr7ZcAslvfVhVRPKYtzUkcPY//WOocr4LjLvbF9Pi
   pty91nEcVAzYIK9Yq2qeiChg54MRu81eAHhvnGqsfWJ0qPGGmlLj5B6Q0
   RLhBUWQQ48js/7uqNi+x4j3/InelznG6xZEXG3NrEMjd6NqEP6s+QCCZu
   AG1lcMqGc7kkH47LEnzUSaD//WZEzEvWiv5TZecAUx5qOVg3cARxcl5H8
   oomfMwdxnqHkJ4ooJdhBbldhHPct6Lh0DSisH/F1HqG6fNWXJxsDURGqr
   w==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647273600"; 
   d="scan'208";a="312550626"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 23:24:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8CGCCA+EW075c5CMXLoIcN3lNae5xrsqCFitw7AdvZ0KQ1bwDAHWJ2u1GmxxKrYwNoy2C7vVwp4rUTD8VJyEXikFzSdcf5B8VVmR8x0E3p4MqRQ9a+oHt1f3J+sr75zWQJeswgHvzoV3BSIAuEL6PZuRIfXha8dlyg/D6PNEXxFxegFLwYbZ5XVguC8J7TGZKUfQj8A1lKIC1tdmx+YJ3A1GLe8kF37O32vvUcOKfy6CCbHQchPmmIP9Ugloe8xc0y7NbnxpnH/xQ8ODL2CmxujOBvpZt+lcY+TKoP5f13xmqsZnsWocJ2BXEQEG79brLnOwQa6vLFS2cN3p5yp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSWO7AcpzUZX04RpjAiDKxvM8+TWZib+ArD3fey+eS4=;
 b=MN3fes1moXbW3H3cLe3plwGSRef44FtMOnVE3SBu5N8S++0QKFR8or1dF1oS/TFzoEGZd04PlK2/dSN52tNiv0S8USs6PFU7AQ5X4QeoosNe9QoNknwXibBrjkeMasJ3qSXD1hdUvlo/YV8ujWocR0Xij4CXKKY+6m1tdTL3RehpGU4wjeuQaNhgTCCUKGFgkCw2urOcaV6vCIfB9MEH6X584e8KdKc9U+A0fOZ6FqwgrRSShjBUg8GWl4J+YNJJ6WqJFJEpclTcMu+JnDl1WGD3u0jUR+WcyAlBo72rjuge2R75OVbzLERFPInLFuLHBLDkB7LM8en6YOSJUHciDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSWO7AcpzUZX04RpjAiDKxvM8+TWZib+ArD3fey+eS4=;
 b=bQ4h/bPNl3Six9krjlTx9dv1+X7b2HoAlvto4quJe73THy6bx27T8Va4OqOEIpEvEdgYjQYXX1BUkKWSQqBFjHDIXYBumCkxhSRZv3H56gDLY90+1iJe9L7C933Og2aYn0xbwfEtfES1GCMs6EmuPK5QWCtQu4naMi76E1ErSTs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4091.namprd04.prod.outlook.com (2603:10b6:5:af::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 15:24:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 15:24:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 09/15] btrfs: factor out a btrfs_csum_ptr helper
Thread-Topic: [PATCH 09/15] btrfs: factor out a btrfs_csum_ptr helper
Thread-Index: AQHYaf2xXu+HKgbNN0+LYj7YkoWr/A==
Date:   Tue, 17 May 2022 15:24:26 +0000
Message-ID: <PH0PR04MB74165799E9088993A3DC984C9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8860e609-f812-4399-6625-08da38195476
x-ms-traffictypediagnostic: DM6PR04MB4091:EE_
x-microsoft-antispam-prvs: <DM6PR04MB4091161CE076B6B45DD819D79BCE9@DM6PR04MB4091.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: spZdGqb1U+zeuxJX8gWN5xEfc0wCjUqp7XgNVeZFp9fq9i91yIiCjejpCoYZcy1f2u5F6udnxB+o5yjb46nfEoCS0cbbEcHqhro+olkfvbbxARYida/xTX5eVODowZ/YOqutIh1MUUQ615t3T9FiJVEAgL8Mo4Rr7poZ7Ma7vi++XzjhhFCmhMF5lOaHjIk0eAO/fYyp0YPldPV5eWnHkWU4cebds2Mzx1bCrPf7aNdPpSB6EULls3rw55fQXUjIO3Evh+ibscNnxxVUnFB9ZHaAl4MSiLT+4MBlsp8fI3SPCh5031POKUm1rZmxnPEr7jdSAdR+OjZM6QWUpajexGi9QfRAyoSAbEv0Ww3PJqhSTqdfC/VZ/GZsB9vt9XSYJimuSAzjJLAfCNLpnvJSLOykjkiO2ZbrMDovd1anp8hB2EDTF0v2A9c7k1kjDD6Xi1POMB3kd2nDIk2sjnK+xlTmmcgbazMC+YLscZLPAXwIGffsVcW73xIlof7CaEU6rEW2/Rj534074zkifj/KRCSlWDmmZnEL5SHIVi0uPetHpIZchd+UlySyvXlQRbU4g6CSzphKkq5+NUZ7penX0EmRa3XXt5qNOM5A6+Msvo6FEbwegUfv5pPGTFbV3bJmiKW2rX3gEuKUY8TF75+MVWjnHD/goX6DsNEO/VsBbkzTkBaMNbs8zFLYO7SH8VkPX8DGm+J95c1utcQM9jG35g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(7696005)(54906003)(33656002)(91956017)(38070700005)(53546011)(86362001)(316002)(508600001)(122000001)(110136005)(6506007)(71200400001)(2906002)(186003)(5660300002)(55016003)(52536014)(66946007)(66476007)(66556008)(64756008)(76116006)(4326008)(9686003)(66446008)(8676002)(8936002)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RE+e9Dhlw/+jYHRWUgMC7aT0D3U449+MgTvxOGzElYjKb2H4ZzX4nE2Tpit2?=
 =?us-ascii?Q?Y0qQeZj7TByECEkyD1waz+xe70X+bgLnpEbHC7QGmzyNZdba3LjNsb2aI6iK?=
 =?us-ascii?Q?QiMipQyjVz1EMm9+t/p8MSgqe/PxLAxEfJjCon51XCi9M/mhNpF8hJ2s8ci6?=
 =?us-ascii?Q?H+PROQAJVPXcvSxFn6Vpm3PZKOrtuRhyS8p0ffbEBord1oAXuv7cIw6eI9cp?=
 =?us-ascii?Q?5iHQUrasz8H3PXnMdogrtVJCr/nwbs9Jxt8YFZzskx8wn62rvGew0PDCusoA?=
 =?us-ascii?Q?j5yyGJr6oSqCE4yCIi4NoK2my+kMDqCQK461A1uR5WG6BmTIHaSDNAHeTfrY?=
 =?us-ascii?Q?g4lF9ub9bGkdbGrt7zTWoiJWUV0h3WF1qVGpXVcswrfhhu5UEb1ZmQtACfyd?=
 =?us-ascii?Q?azJJZYMMYzGsVcW0pMFMAMpmmebgzef/rIJc3NuPhqVvOcTYZmprv0erXYD7?=
 =?us-ascii?Q?sg4kC1iJeXJ1yWt5XR2iYbUSBucIigcxMNx/ZKCGPDKvu3A/9zhdxdD/v/c3?=
 =?us-ascii?Q?amo4IsZdmPspd72OEjxw5f98IQfDNdYYgahp9FroUajnQUhkb/zDqnsG5SQ0?=
 =?us-ascii?Q?s3tGVXDsOcNajmTnJqJWmL0kaSAYooCRp910C9FVN6lMTbzbiEpiBfNIE6e+?=
 =?us-ascii?Q?1znXkarUvhfVI4CIkI9RuFYFUilCa0tXM0rJDGy6tY4kbgkxOU0+8WFDt+oX?=
 =?us-ascii?Q?AnyBTMZ4hS76+BXDCCMiNgiHFxya9V0ibyA6CfK2GJA5bOIPVZr3uWoTawUI?=
 =?us-ascii?Q?qYzAIDWK27t4TMUr1TGNQBQf8NW6TJfCUYTNzRNyGIjHSRmFusud8pwbRL5W?=
 =?us-ascii?Q?iSSKs8NMUDpPLzXG8QIy5RhAbclTD4y/TddwdThhgbHreZZNK/ZIU0MycNu0?=
 =?us-ascii?Q?ljLEP7vSo4l9lw7tApW1wU0NGb2lRUrapGuvMElTZ01UVvNRzaGtePm6APMP?=
 =?us-ascii?Q?l8qhtMLLeeSsKgPGYcGDwrgH01SjanmnO2Nu9RywVIcYYMuwQ0Od68Kjm3O8?=
 =?us-ascii?Q?fwJi4p979m/mvndCSQQr3BwyGyF9vv8sRGl7Hm2GdB9s4KKRo+RNVviI7sBK?=
 =?us-ascii?Q?K+BWAG+Pyyw0khpr3wSjKNGPW5He5PN2oXphFyvJvEEE71eYYxZFZUoa4A/A?=
 =?us-ascii?Q?5VEDl7pWItZhONPs4PL95b1zNLL/g1Wj7woYQnBZX772wPg/qN473MuMW1G7?=
 =?us-ascii?Q?lTxdKOE8z2pzJTq/ukh+Z9/O6QSo6xwHdh4zuUkajup1hRdAjot4gjIbg/RG?=
 =?us-ascii?Q?iWe1J/d3dCCqWxfdvUW/9Mab+mNC1IXm+TLH9M7tayHekZRkxuFrKHGY0nc8?=
 =?us-ascii?Q?u2MYqGSouToN2pK1W7vhj1IFv5ExZ59RT4kDejmR3Ol10Epp0YoM0gNww6d8?=
 =?us-ascii?Q?IaJrVySe+CG9e2lE+CTSjNtgWWO8aE78EnXwrC5Ac//2B9xNYS5TFMuzJY+c?=
 =?us-ascii?Q?Xiy61WHchq99AG7i0odSGDjt6/ICe5Gm5tEW8EiWwCXzEOEQTfFo3w5cYSaw?=
 =?us-ascii?Q?pbXRAozhA4l7S+2Oh7b1EN0bhtOmk5tGEITn7Jb9DUa5hIFRJioO1AOy8iqi?=
 =?us-ascii?Q?UHbD0w9Sn7aJtyPgXx/JMCK3vuXj45j007u2o+2CTMiYnrprVxuMO/gU3lVv?=
 =?us-ascii?Q?ZiJ9NGWe8JZs9K1q9ZdSu6TsvmUzzNFjBhg+gSXWZUYK/aFcG9YaQVos/IFM?=
 =?us-ascii?Q?I0BEpPt3tyhwUu6DBNxpjtrtDee/sg4D3o8dv+EFQMOWzcBcTsM5yyYiJDgT?=
 =?us-ascii?Q?HHwclTuaV3hugS+NIVH4gTjkNOh97HJI2EQT9Pt6UU96+LtLu5N/c8YKPLWV?=
x-ms-exchange-antispam-messagedata-1: 9S/N7/LarwdwvXqAm889qigFlDEOdOuHMaSnzNoyS6K+pXW3fAHz53RB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8860e609-f812-4399-6625-08da38195476
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 15:24:26.8573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wnfax/wmgdL1cQApnwBaNgYdzJemJKJfJozr+z7vB0PTYIWHdYgy0VVmNWDtsHt6tSEAMy62/ZAt0J3vL+533JADIxH3FTd7eeM+/aluYU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4091
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/05/2022 16:52, Christoph Hellwig wrote:=0A=
> +static inline u8 *btrfs_csum_ptr(struct btrfs_fs_info *fs_info, u8 *csum=
s,=0A=
> +		u64 offset)=0A=
> +{=0A=
> +	return csums +=0A=
> +		((offset >> fs_info->sectorsize_bits) * fs_info->csum_size);=0A=
=0A=
I guess a local variable for holding 'offset >> fs_info->sectorsize_bits'=
=0A=
wouldn't have hurt readability and the compiler would've optimized it away,=
=0A=
but that's just me nitpicking.=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

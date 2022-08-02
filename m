Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B955878AA
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 10:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbiHBIFG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 04:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbiHBIFD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 04:05:03 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228D23AE73
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 01:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659427501; x=1690963501;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GtKqjYoVLLlyQ76e3daPCfd7pgtrmpJjAvkR25fNSMs=;
  b=iHUPDCgDsgwU3K8jgStDO/+uQwRG/2uHtxIGZxNWKKR+ipO8kEfp3E40
   cXIc22eiz2A7BeJh66kdhVhY47Qp4fJa9HAQKE8pgJbvpKIi9xRFXOmzX
   nqWNtCMhyQTSzAcu//tEGAcR4rhUus7GWmV/NSDxZvRUjvvU88i3oYk7q
   Py2LbWkc1J42Za/VMNuxGJpPKTLfiBqdAxn4fWmPCW0a0ik1viTKk7sMe
   q87gs4d8wYBR6QzAmz/TY2H+92DyIUyywW67d1PYIatAEiY6j7L8xs0nz
   dctaSKj4YwDAhUehaShHpJgTMFqqrOOH6dFKHIEvrg8HMhlavEL9HfjXR
   w==;
X-IronPort-AV: E=Sophos;i="5.93,210,1654531200"; 
   d="scan'208";a="212525286"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2022 16:05:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1rKasDA8iza9AqCeymum+pxN6pVMphk6Y8xvjkQTvP19DYtgYRdARxq6741s5Rc401SPbQneSRVfaXlpFFsjOPu4Fv9E7PI8v9xRd207do0EsHrDOKQq6NETU/48Q8tqTmk786SiW8l27hQdsG4ANJ1gWaZdZ4SQ3s660acQJejDOqEZxQsQcGblqBqYWBFtwjy/5GzBsG0vZmkT7ZIVN12rx7Dn/vDlwrVM1HgleW/ZshewO4irxHbktQnRERksfgEvR7sysQM96UUpAcWHv5+6gukmKz1LIg700j/UFM61XNdfN0PhY7FrUZdwbTEFQFYeKBPCM5tNzjtqdJbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtKqjYoVLLlyQ76e3daPCfd7pgtrmpJjAvkR25fNSMs=;
 b=Hmciy9rE6OwgDW8q63tEFt4G73/0azuvpRXnO5ykP/9/i7spkiFKHQeQaic5I4j3h46vzcypTq0qurAcBtAdAcq23ODTIno7nNHGF4qspcxQEeicIFu34dNDWcxznoReJ4QXnxLi4gsMC80CHM+MyM7driCJXuGavq35SGT92oRSO5SefJhI842Dwj7ochmkcDiBtB8B3tXxlf+FugY329BC+q/WqEkJdk7c5EqaCQHx5QXPqD9lhnppfkynH9XhMZ5NpfA6Kco+dWlWZ70O1RK2MOqzZ6F+Gh9DKY/jV9lcQ5a3uwpHjgxFZikOnsv71gKkDoanX1LKeJuXnH92BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtKqjYoVLLlyQ76e3daPCfd7pgtrmpJjAvkR25fNSMs=;
 b=TVlcUIB7DHeJng7xzaAW2VuqUtDkmNdkaa6wvQhuYX6aTNWemiZDIQbJgwLEb+oXlC4lb/fcOe0zfEEnMrAjTa/X+VAPQZmyqoQj6pZpHLshZpgLV5u7JY/s4On137m8zv+TYGIOsqyCRxzHIXY4C8cznh/oysxdef13gPzDxUg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB7033.namprd04.prod.outlook.com (2603:10b6:5:22a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Tue, 2 Aug
 2022 08:05:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 08:04:59 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] btrfs-progs: avoid repeated data write for
 metadata and a small cleanup
Thread-Topic: [PATCH v2 0/3] btrfs-progs: avoid repeated data write for
 metadata and a small cleanup
Thread-Index: AQHYpkTwWd77x5eIVUW4m3egw5pSzw==
Date:   Tue, 2 Aug 2022 08:04:59 +0000
Message-ID: <PH0PR04MB7416920769E0F9FF573040C59B9D9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1659426744.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 930d90e8-dc89-4416-9387-08da745db23e
x-ms-traffictypediagnostic: DM6PR04MB7033:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZXsFwta6iM2cUMBf6mGN8n3K1DUBl1F1+4iSsnoSlOYkL3eSbdJvqPJ1c/685fSwk/YDktI/islBpUBnlNFgTfhe/L7wbM0OIAflFZ7B+/enxLYUUGokLRqjCwzje6m+253YS3AoaCAmIFVpyw7BN68ErbsS6k8quM5Hn5x5r0qwgsfzOMertkKYgoXVjyRP4/HRBz3Gb4minrRVsQLf79kEbRuh5DWWEWui3eYTCUWWfj39xplL2qX1ZvMgWLSAU6N1WR3thDAZ33d3fbjQJPGNKchDenzxEf5lbI9AhWcRqmGzrwEMdp1KRoLA91pNoMuTwmp33YJkzmZWkozY1bQ/bKdGCEjappVjXpKjjRw+KnnTo3lLtXQVy9KrKwF7DXm4brbWN3K/COmUAb4xMIveh3CK4HF0tCifEpScOoU39jIMFzVyvrdOOpea38XpCflm1IyqUSGu8CqaGPQDmXpXjaWIEmXD7iEBYbKRnbJt1grKyRdcks/xHtlkxDuMKQRQ2aln8+WhckxsF3zwmf5Dp/iG3jJeoqBoLBqX2snR7SxUtBBSyxIWFre2ImOqybKcxZsHYtioO0RqLn8VCxxl9DuuOIBpkOaTTpcSeD3XvkGHQuiLiHbpJlBSP2HaSMF3ukW8uU7xAo20d0rpmc9F6NSkLCDzMOKRgvlTrWNarsL7fGvjSNWx5rUKpBqXcVtgk4a5dJ+S2tyt3nIQXDzwfiV5/UtqPVmg6OUf2pbQoMRKGFid0yaiQVxH6BtOvqsPsoGztyBsJnA1QMI1NoxQsKIyrknfq5GT8KTrb8sggqyoNLW91oCWwmXgpJB+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(478600001)(71200400001)(38100700002)(41300700001)(9686003)(186003)(316002)(2906002)(7696005)(6506007)(53546011)(33656002)(83380400001)(55016003)(110136005)(76116006)(8936002)(122000001)(66556008)(66476007)(66446008)(64756008)(38070700005)(52536014)(66946007)(86362001)(91956017)(5660300002)(8676002)(4744005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8IHacFKu+6/cW3ik2AZ1F6HmZ6YmA3YnalQbQl8jxhrUGNlRPqiQpukKRbJv?=
 =?us-ascii?Q?Zo63kjs4HwIsJv5fqM+NvGHxOycU1ZienkVS1+Q01GMzNW57URleObEImRsJ?=
 =?us-ascii?Q?rL6EiQNPS49iHoVhxTqj0H9SkaCd39mlgHiOrnKSZ4/ZhAcWxEx2GCo/+LTv?=
 =?us-ascii?Q?slp5CjkzLQGg5UksNKO3Spg6LIC9nNHZPROiRns2F2uM/ImpjUC4KJa+Nx5H?=
 =?us-ascii?Q?dIjL0i5SO39uqWtCb/9iLF/jkqbkt+kH8b5I2Hj2cu+9KAxQejtetNLIQfGZ?=
 =?us-ascii?Q?xxclxoBCJtcFZAvGjUNNiO25zjDJb8TaZt/zft72akeS1sVHTwpXCFVxbmqL?=
 =?us-ascii?Q?jTOI/BO7qR3zweta+1s0L8SQg/mRUDMmU0wXy0vPLgxRLwC28PDU/VNQFEmk?=
 =?us-ascii?Q?k4k5wEY9fIRn0/Qcint7SnUFaKdi1FuOFJIkuom82UhznOZFyPDqWrB1QuRn?=
 =?us-ascii?Q?XUM65hrW2eUYd2zg4TektbI9zFreBymVwRyoH0cfbzTVpH6vwTW8Pmjr2BV7?=
 =?us-ascii?Q?wDwzPFFV55NXGpmTPfwncU3A33l1zxze04bfuVipFfX0Abqyuw6KlLlNVO+s?=
 =?us-ascii?Q?N6+l2CwCi7qF86bUeXJQFWH9ePgqclMwhPaWkUkk1D/BDeZsv2xzTXJIEThd?=
 =?us-ascii?Q?6rG6NDoCCfXlzzRcmrriKcRSd/7nlCjdsrsfNG7aR2IJIEP1lA7AzLDahgnC?=
 =?us-ascii?Q?+D6umOPpjiuoudF7W+wxDwtrFuX7WPf2C5nLsHGfqllb7chVITq09vCHiykY?=
 =?us-ascii?Q?oXZjSBATtAfOGFu2tXrD43VNAMichgQOCACeE6oDEFjeDXnANbDqBTdxHYVD?=
 =?us-ascii?Q?Sp5aKn4mYos3UAGfE5MhMC13znzfcb8aerz405SSe/h/epDtrKSA5/EYfeB/?=
 =?us-ascii?Q?W+Mfwdgv7K6viGTpvc1c22j0sMTt2oYZPWtAdQfQ/Tg9Iwb+5dBKcN8Uq5Vb?=
 =?us-ascii?Q?hupUayuE3x9Eu/rULCq+whOh70FHF/ikFFQu34l7BxNS7W/1KSh7fbzLrVQn?=
 =?us-ascii?Q?2tmtSwWduIFnFvLZzyX0S0f1aJv9OAsnuLHWZ69H1vnAJhMROkmiK7gnXHpd?=
 =?us-ascii?Q?d73/LT/MKO5oV+SXiLYofUOlxaalgnU+dkvP2xEXIFvLwnJeZiCXWVJGDQLR?=
 =?us-ascii?Q?K4zHQHbpAm4aYtrmGNUFoEXBkgNjXL1JQ9t+sIq/sngxYKkWxi1F1pNlhWmb?=
 =?us-ascii?Q?65muDWnM1hTL3zjiqF9u37Eew6bimuzamCcBEAnJ9wZ8oOAtsj5mPZk9qevB?=
 =?us-ascii?Q?KNwmUsPqyFXEYxM1UgQt+cr9DbubWEykHwc8UGWZzLugMdpROMnON8rPeNXc?=
 =?us-ascii?Q?ImXnzC1HGmW79JLOIolIJQNUDOUgI7clN0j77F75twV+0WoASK+BYDiIibeE?=
 =?us-ascii?Q?wrGWZ9QdOTGZkdslGQLqG5i4qFPwUkxnnyTu1HmJtcYQ3vi9wSTZWXnUOgvA?=
 =?us-ascii?Q?AY04frzuWMUo+3bEpU7DXXhx01YkDmrUF7V1/U+Qnlq28f0/J+4gaomS87Le?=
 =?us-ascii?Q?uYOhiuChSBmP1NNObmHshSxnzJl9/5sLuOYBWXlRGlHQRaG8HWjkZuGIqdjb?=
 =?us-ascii?Q?EbNt97ZcRLKRVAkEGTTYBFWIjo+6kFw3l7dPWCuIljRcsa1zdOSyhl1ZmXO9?=
 =?us-ascii?Q?g82YZYUBxwLpO7ain5obGDpis4FGh+NvP15XpdSkCrDLcVz8TezaCG1tOnhc?=
 =?us-ascii?Q?1H4Ejk93sojCavNVU/V7bRdsc8E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930d90e8-dc89-4416-9387-08da745db23e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 08:04:59.7103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KdkwQNNfid/aXHUEw1B158ez9ElXPubZje59o2Am19sjKZLbwFyzLyMenfWWAF6WEl8OH2XFAiAn9EaVR+5RkF6h4VGvEOt2aTB8zptqbIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7033
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02.08.22 09:53, Qu Wenruo wrote:=0A=
> [CHANGELOG]=0A=
> v2:=0A=
> - Separate the fixes from the initial patch=0A=
> - Fix a bug in BUG_ON() condition which causes mkfs test failure=0A=
> =0A=
> There is a bug report from Shinichiro that for zoned device mkfs -m DUP=
=0A=
> (using RST) doesn't work.=0A=
=0A=
Nit, it's without RST.=0A=
=0A=
Anyways, for the series:=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1870564F2C
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 09:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiGDH5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 03:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiGDH5l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 03:57:41 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31CFA46A
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 00:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656921458; x=1688457458;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Nc819EFZiGYatepsYvE5fq1eOrPYz1CoFol5BbmycWr9aWQp/wSU2gSB
   dEkuzy8jGrSk2qe4PeLaFRG1evrkhBaF8MURuAtTlJaMztRnySInkIZkZ
   f3m8h53kNPdJymBZStwvGGU4LoEnVpncm8PX69Td9MfMbWrnT54uQSwVH
   nrICkOawmbZ0weVnFkGnkDyV6NDCO0n9jseurON5OR/LcQfAO5GhXJnJs
   GSCEQ8Kgs9FKkvCHg8Nf8kn16IeLw/0J63L1OWHGXkRqLUHWv1S+Ej4LM
   914Q7TXTP/oJyNkNpiSCsVqPXvKDNBMA6VudzoG+sqY4vviIDcKQXZzux
   g==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="204745412"
Received: from mail-mw2nam04lp2177.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.177])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 15:57:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jY8HmNi41oW6ekCZ7pxGGXxWQvIqWd/tpSgT6jLbiRUFlm4ZlJS0vzCkRYBg+cMxOk3KVu1CmQM5zHNScChUiMXU0HZi4WDTXaOTxTUdXJA83x+2H6qOpx12caQisA4R3I5kGpZeG1vKpY63hPjjuPZIxlUqz7oBf17tLe03xMj+1Xt3meBSpXZXSuxVeXCPDg8hNU2KWhlju22oxyhMCgGbMX/HFyk4azO+zIMjQJEqWiDOdYj4XdJ7htlTjwbQsRKMbCAL+6o+dRqonOOsjJVDfEn+iQP1uZrJTAUod6Y2dsYGNS7EqAG9U8iq6hwE8rsqnAZhH3TheBYZb558IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bU0IsuRWktg0ID5rz1sNRZdDY0P6h3igHDI47HTcQfTkQeFJ3LMDQAx9ZiFR9h04Y2tsBv7D6zbExVlsxYuPLpLkppBpaqUuJZWuzEpHr3bb9hZcsO1nzWvDA7JlrobgDwXvINIwiVoon1Ha7SuryKi0wdr3yRzQjtrI4idgQIcX++L/T5bthHY6+FG6D4OGpwA3YuXUHpHh9mccBCsKNEpBq4sKz/UVqWpL6CRgjSRNWcc/1NBK+0e0GZhKOVeW8jaX6YgnEEu681gAwnYEEu0/d6Id5kIevKV1wTMeU4dyTw6YBBX/SPexwh3ViNEor3sEVH9o00hNmcFCK5G+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=U5Jnw+UTEa8Cj+LnA//lOJQ03vOL2FkSGikJXpxwvppvbo444PLGotQRbYtExNXwUECqbFV6muE1j24eXE+XhwYSWRlvGZ6HpkLmZ03mrqpBJ/3p605UhDdggq4Bqan4znfzZnl6DbCX5xXrwBFnTRv1YhINlC9uksPuyno/6OE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6002.namprd04.prod.outlook.com (2603:10b6:408:55::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 07:57:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 07:57:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/13] btrfs: zoned: revive max_zone_append_bytes
Thread-Topic: [PATCH 02/13] btrfs: zoned: revive max_zone_append_bytes
Thread-Index: AQHYj2LHZWVXGfLPhk+1MqfkduoC2Q==
Date:   Mon, 4 Jul 2022 07:57:38 +0000
Message-ID: <PH0PR04MB7416F04AD640AC27739C6A679BBE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <687ec8ab8c61a9972d6936cdf189dc5756299051.1656909695.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c9975b7-7adc-42d9-36f0-08da5d92dd36
x-ms-traffictypediagnostic: BN8PR04MB6002:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XGJuzV31tVSzziyXy5gQ+Szh0g49m0JgDOaaTds0KaKmzyjv4i9t16BvUuR+Lv9Gtmngk9Edo/GTeeCTKjge2NLgKbFmKiZxO/XbXeHVTa0ZnjMdPM69tXomD+zyXWNzGfrQPYLd0ZJWSSRGtctq7+mDpUwMlG4Rth/OxqlU3C6Jf7z4lNTZfOvlp5YG4QTyPEpNwrWf00lBYlnYo2nYAHdQdYGU5j0ptPgCMk9Fm8UkpLgCaXoZ4httMIRVKWAJvqn4toX/c4W8AG6hkTklXVo2BHAPys2zBs2PFRanVegENIRE+flz4H7jROfHO/ZAh2MWaSVeeItRRiTkXrIXgf7UTEZQEYXCkhUcdItVQ4j1qHjSY3Po+3WzBaf+5BV3yRI8mLb7AzlHOhH8W2ruxbQICaXFhkN42wM6h1n/7S5qw+bXAAK61WfuJ/t2RRb1+d83HdSc7kAuKyJE6t9HUKsVknser1csuGMqINCANSNQwomE8OP1iI/WHrDkBvDHUdo7FamGfm//FXcUembVXUgsWJnfzVnPRpHBDapZsswXJ0/6mZQIzu9FID/6TZJLqVYPsjLjWLlSRW38uoyii5OWYAOsZDodBU2OsvWQTJtflx4ejUqCra3FNeOBXw5/LYJm0fkpKFfXQrwm3j+dqTlSrq+CINqVYCFmmPo6BqusEDYayZvuHaZLP2asUzj7ENTRWW+DSLGzIIxDWrcjQs4fOMOke1Pn57e2y8x40cPgvfUdY3FIuGLP5eH+GnvrqSlJquftBjutlMuDlHjYWwrWC9Fxy2pAVgD/NsjVsk50nS94YFW+d0zjLhKAvQmD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(2906002)(110136005)(38100700002)(19618925003)(186003)(41300700001)(55016003)(8936002)(7696005)(316002)(6506007)(558084003)(52536014)(5660300002)(82960400001)(122000001)(86362001)(33656002)(66446008)(66946007)(66476007)(76116006)(91956017)(64756008)(8676002)(66556008)(38070700005)(4270600006)(9686003)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LNUmY1PqsTpIrKt5LX433ZeqhyTVJLwmIOtcRGjEYo2C3bWZLfyCv6m2TP2+?=
 =?us-ascii?Q?jLuybNEDsibDcF3CQDLmZw9D9F6EHf6Q/2u1C+NfdTAnzDywxtdIJPBxv3qB?=
 =?us-ascii?Q?tP8rfY3LqGKzgzG30SyokVuj1KZHgoVuEctoCFtKlTOsY3i/snQMiYEMDeO5?=
 =?us-ascii?Q?geEQzI10ff0iBteousaDHbzlRDDvPFWsKjg0DY3zx6EzSJfK2/nEaKTO2baL?=
 =?us-ascii?Q?hqiSqxYn3qBhKqu44PTC4i0++Mgtf7l3alF9qmMXXvQlO7VMt7UuFx37Xy6P?=
 =?us-ascii?Q?5m5+S5rLsASfH0fARpjBMGYIDX5JF8p+UxCxuKCnAHvCzUnxaTxnm6Ta3fKd?=
 =?us-ascii?Q?pcfLxw6sMfTHWQP7uF0beRW1awx9pCpHLYrXewRsxcEQpKiGfcuZ0NT7at8X?=
 =?us-ascii?Q?eiFvsN+gD61mcTDnf2qXlnEz7w/ZiAETTvJ/tvyHu3/iD4PUPpAzk0+jKpsR?=
 =?us-ascii?Q?HEEvKB9WfreM+orsSEJp73gFKmDClnmk/SG/xfDr2Towmil1hsUpHX8+N3wz?=
 =?us-ascii?Q?HycZo9B4Nm+Mcp5S3+mpwt+iUOM8wV9y0n2CbdAFwA4rGHL6arEaNO7nXoAw?=
 =?us-ascii?Q?XccKX2YRCzDRzFAHKHIrze5/+qE49C4c6Nv59mOwiuxVIBb+SCbJnrgES/Ex?=
 =?us-ascii?Q?pBEBXIbN6N2vYV7duDxZ5/TEuyQe9Xl7cM8zKHH/vZgS/RiFPxiBV/jyJ/9+?=
 =?us-ascii?Q?G7HPhAZLc9JnMDx88mM9T6Uyw20zHqIqKPl0gcHtAYrO1WsXA/xM89opPxUW?=
 =?us-ascii?Q?RdrhVtKlD0t1MhOoj08Ul8wVhEcUpT6yMtdWDDCFaB2HZX4Lg2vIgHXg/1DQ?=
 =?us-ascii?Q?d19J2TTzdLqC4RvhmKgHJawNzEhjMjwR6O5b9Aq/79VJSr5Cw2iCTarny3Cr?=
 =?us-ascii?Q?M3tO5VWrvbC4D4ODEkFon5IEG3isuaAo5duR1XW5k5ymiSPZLHODGdKUoiuk?=
 =?us-ascii?Q?HHq/1iKBnyUnZPNIvO6UIZuVoU7P48aqxzd10vMN6vaI6ZmbkQRhbb71jQ5/?=
 =?us-ascii?Q?KpUf4IGffwvqPiCSHiUIv1JuG4IM3+eqmiUP2HO5Oxz6Ow6qMvLyYKVTLgHs?=
 =?us-ascii?Q?lJzQuTsvNupMHR7RC2RiX5jmqeqi5MpRFyuU2mrbUIWsoHPHWv588drsA0E3?=
 =?us-ascii?Q?Y1i7nwBwxL+N8OglNvVoYpA94hE0cPOXI4wEt+GAp18Uh+4neGotNOZI+EKd?=
 =?us-ascii?Q?jOUE3hbr8yGH6825r5zKcMMPDddHcHwPk6K05+U8PU+xTu88ik3sPckMBArS?=
 =?us-ascii?Q?REJq2/gCHs+DcxlTOMPc8jbt+ck0DzASzP9rlumxHdIkEK3sV1Gdnvh0E2Tb?=
 =?us-ascii?Q?bbP7hYJpGMkm0Kt1y/bpwzCZawVbKQDtfMYbeXu11HDi+I8A0td4Kb5QtBjd?=
 =?us-ascii?Q?QGsMhAL1GntzFQeKxyeCykVmI/REdGdbqBvYtqRDcnJsH2a698ZRFON46KD4?=
 =?us-ascii?Q?94AODp5hG64Yt9OYvqOQ5X9XuYSwzW3P+fF6BW2hXdN2MsmUhvLGMVUlha28?=
 =?us-ascii?Q?zyxp5H1z6y3wDqBytZjK6g2OT/Ic0EvzOY73Va+ZVEmWHSjO7ZtO3WHCRMUO?=
 =?us-ascii?Q?TnMK4pltxEvdBEtaTYtlfePj79wMk2PaDw1u6CqXbXgb7fybwd/b5jJxVDsg?=
 =?us-ascii?Q?100cqfp7pHgYFLcO83yDGzYpmC1gVILifiKPjbywAnTPb5idXj/6jJQZjS4Q?=
 =?us-ascii?Q?Ya17+Uw8Bvg+P0/rMSCgI5BjuuI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9975b7-7adc-42d9-36f0-08da5d92dd36
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 07:57:38.4116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FaNlRE8XAtH38dXqBbHW5mWDlFnNS49KlZpwlvF/B43f2/uJmU/G4TxAw0/dsPRFP/jHJ4MJXhMLydsIDTVNhUZa48Ab1tW3OXpBPBzCC3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6002
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

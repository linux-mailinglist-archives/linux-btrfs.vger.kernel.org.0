Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4357D5B9C76
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 15:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiION6y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 09:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiION6x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 09:58:53 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A879924F
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 06:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663250332; x=1694786332;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=NCZJyIh4OHjtXhkVtrODir0LxtUCTU8f11Esua07vgCJk51ErmExymk5
   VQ4J5gOzF8/QcrnzUxOCBJrQDPVED+EwvDSYsQ7eUXWToTGNzAf6ZnTER
   3nZ8kpNU7sD2i+oqED65Hlvbai5yFFCVAmDSZSiI1zGScw79lBlTYZh7f
   0EXERHueGDuwDXLIgjyCl3jjuJ2w9JWMNugNY1qm7SSd3TTdkkCB5POy7
   C/w+z0c28E29Ed/jLZ7GpdRXdfISOaJCry+SN/uEVjIgxL7Zjv6sNpSVt
   x9aX9DcQqpUKDlYhFASBFz0qgWXgUbRpsMGMvZVxArQIZekbVw4SQGaDK
   A==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="209838171"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 21:58:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAlX9P8o++2JQ3gyogaAg4EdMqZ2APHaf+UAL799jAQuMxYe5QEyvJS1plxTAINwTWv3JMsum95optcu5nYt5X7nNcJZS/07AEXpufI99UqaxR5hO3OJsPTt3cEo/ZkNg9qgn091g3y/4ymkjhQs7zDo+S8xwEaeCa0ttv96ZhXz/XfnzuIVzonSNHJpUm/FRg2g+n0H1Qp2jDplo8I9Xja4bU916kg0cyRglpvqds17w2W+iy9NT3yoFCYCf7el6y5B+16Cxu3IrDbe75OxwLzMl/ufPN7dDye4neVys6C8cTrR93yjWBeUBoBdKZgEdZmyub0qnUm59gjEx3DeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FTQIUypWyEfIPdIhl2lZM8SAgH6ZUH38H3Rz6CUOamydmG5V7FPwzZC4A6SqXbJNspfnhy+I9NEjJCWE3/Mp3kKJ9KThURi1kcUJuFjRuw5oT0Rpi11J9AbtOHuDdMW9NPWNZsY9s6Q8tqS+rlj761+K0uK5lK//chCYCbK6aBN85BZoVCCAHrE2G/b313PKpgLGHH4MK5vsNpmADyOz49A6y5YiUyT7MHUKebyasmA9MfTSUJv+i8QE03aiBqGkNSuKolK2lKbCOZeUYsODCnxDCHSR0wIbeWx+qhMhsvl/SbE+8dVg+Lz9KF87VlUTciUt4bIuN3BVmkAt5qR77g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=EDAQNzTkNWVT4QUPjNruokcaXY06DJWPNYU52uSUW7JL5nAmfCMJNqC1G9/E2BWAEMXcF5YlbEgDPaZWvEL+oOeTTVgo1NcEQVNOcWWmOwuVBWiTNWaQC1+PKUCqFCC932MKb/eQKknHpch2cIbg9UJjeKi4pZw/+MNMIC3/qGs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4283.namprd04.prod.outlook.com (2603:10b6:5:a3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 13:58:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 13:58:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 05/10] btrfs: move btrfs_zoned_meta_io_*lock to
 extent_io.c
Thread-Topic: [PATCH 05/10] btrfs: move btrfs_zoned_meta_io_*lock to
 extent_io.c
Thread-Index: AQHYyI7dTVJCQx4mxk6Yi39idMyBlQ==
Date:   Thu, 15 Sep 2022 13:58:49 +0000
Message-ID: <PH0PR04MB7416545E4CEB2BE94BC4A9C99B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196746.git.josef@toxicpanda.com>
 <c9a72140be961732e8fbd473af3e3b0ec7126dda.1663196746.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB4283:EE_
x-ms-office365-filtering-correlation-id: 74b2bc1d-baf3-4fd1-68d9-08da97226a2e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qTxwaVIsvZPmxK1XCrZ0GnB7q2Cgd9Q6b3HCutx+kJMAyuqHIXdrXi2dmYVMuKoyJrddwejDnFebaHlPYG5G/2hJlA69IXr7doA909rkqHvnjluxx4mFQBdWsQcOSbciDpA/r0lGynf5Ls9nm8gfdpGa9K8fJ3rD2eMk5waZsQz8DtzWDrztguhItvz+yYkvTosjalgPdwv4gmRXbbkNxzg2DlVZyr5qvPIVvpsm9iJzD3hL18FYYmPj57+eSrKkvAWz09DpMB8eeKapqlMdT3mL+DmNH2Ve+anBZcD22wy08Qkvni0nAPgi2E9MkxB4moSBqshZk0APGhHxvbgANjrnMolgaYm8yDud9cfo9ZtOZKiQoKLGSq/SynNApxsjUzLaSZ1rSgGzcrqTZ2jElHqEfR+/uTWrtpP3hmilFwZQAOD3g2/sCYUkPiKn8c9xLqH2Dyds28E9kYXUwhfoUmiSD+B2lWITzJd/B8/PAf6Tnnk3mLtnsUuazSzqVhMraxSOJsozdCmPuC1kmioVS6jOjW7H5rz08oOIM8/byznk306cq2MuEP66UFqsgdJxFtjSTIJotVJ74sG36CDNq02LU6c8BSVfihdevhHDon7bxzySVHAJxPDd/rEgD1wjdaEs66O+IuwkANWue9JB5XMMwkQbWUo0ep2By6v/i8thbwVlEm7jaJeP89/eEzd1Y3oLfFQdnoz6+gapf8vh/4CPp3VklSUA4Lz2vTokc8zHcRygEPgZEDjn4orjqO6EXEoQASCwPxxW50aQMqx/lg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199015)(9686003)(478600001)(66556008)(66446008)(110136005)(2906002)(4270600006)(8676002)(8936002)(66946007)(55016003)(316002)(558084003)(122000001)(38100700002)(186003)(38070700005)(64756008)(52536014)(6506007)(66476007)(86362001)(7696005)(5660300002)(71200400001)(33656002)(91956017)(19618925003)(82960400001)(41300700001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uYI/TeQ9QpUuS9Ge/TclBoLquPp6fU+yHB3RA8Cef1XBMvuAdp4QK1h1OQVa?=
 =?us-ascii?Q?bZlHUl1ws4mvCokuig3kV/ASLYLRBWU5uhSZYL/Ebn1H0N6njON9/eetfDpa?=
 =?us-ascii?Q?M/0yVGXEMLO8V9ADjsnls6ySXRx6wn/z9JMKfnxl0oUOnAa8lG1p465L40rF?=
 =?us-ascii?Q?6IPvW+sp6j+3U45+C+z9IZNNNoKuYM1xyRxI2rvCiGTEXj5JhfjvdlIx+aCl?=
 =?us-ascii?Q?jzsDCfNjWJic41YqyAN9YNnzeDik30MoibyDFNZUXwMoMJI1R9gjMGfZM3O7?=
 =?us-ascii?Q?HjR3viNpsJgdxvec4/tERAn/lweXv1sXYPVGFK7FFaUK/im67B2mXPN7F882?=
 =?us-ascii?Q?MQyOmx6VfgqPzxEwzZtTVOu140KLc2muORrPqmls5bqSC6KL71z09SqXK1nz?=
 =?us-ascii?Q?jkin8SwT+kQ2IpQPnCy4YUemaPSnKuSM371QS8IEO4yjAz8LpfF73GN0l9QU?=
 =?us-ascii?Q?IO5r51QC7gu3wFCVGXuYw/Ut8TFefRfmndJM5Rx5xZoLkyloYgv/z5UY0Dwj?=
 =?us-ascii?Q?5EJGV7Dd6n/x9q5BJSdsor5X/MquNzcKQYAULzXXETDrL2KYc5tbTTkthNGN?=
 =?us-ascii?Q?toNm9VqLozOEIDr55ArwqUtMHKeqoT/tkDRA/PsSKx0t5FjuhiCDChf5s3vr?=
 =?us-ascii?Q?p04n0pQoZuQR2s77oLQgg3j3tXi9vufvM4RFZt9ZXgFYAFiIrN0JK3ZRXpOK?=
 =?us-ascii?Q?OE4FxfXcXbfOFbBTf70ghIGM8TVjMEgnX1VFxnJ8pIIPmQsivbGC7slr8i57?=
 =?us-ascii?Q?ES8LYLIYu6kYCbO73H1yuKDSlPee5Blch/kml6HO2cG0Yg9oiLkiURb3SsH7?=
 =?us-ascii?Q?y9XC5JqXIlkCe9mwr68Wov4y32NEhMq+80dF0UVzV2lZP4zDtf3iVpnc4he2?=
 =?us-ascii?Q?tRZLEX080kyWU9X/Zatgi4t6/hLDnFAwCEw8WhK/R922CwCjIcr/7VvdAcib?=
 =?us-ascii?Q?NCIAOosaL7HfKdT23ONYDJk5JNQi6+mWCiIjjrqNAF5kq+s2kWyFMhDAZ14E?=
 =?us-ascii?Q?IwF2qGBpCg/ncooH1DRSeY+1ehhNv9VUbx9gqhKgVeiKHin+5C8UNxEq2cq6?=
 =?us-ascii?Q?cXCYkzfN70U+NDKeZEly9/UP79Yg6YOKyl3R33f+vZXgCHJQftjKKUOa+TkB?=
 =?us-ascii?Q?cgDU/N0S8PK1rjVT9LiWXLsQO8wt/JlmEW0lK6oPxYmdZaHpkrrh1K75OcA2?=
 =?us-ascii?Q?2H9NKuPo+7MGe1Xpo3NJrdJPfWSJkOJLe2JaeBmeS1hepxw9OIZ5K6S23hp3?=
 =?us-ascii?Q?fEByrLqh68mbdxLs0PEeOzmMW+WIPA0hozd5tMnh2Ynf3LRyk5mv8pk6sFdi?=
 =?us-ascii?Q?eDJIfGpQ4pUrVISGac9yiXCzuUfNwfiXJkcorwv+jT4Yuemg5zrkWmibLQby?=
 =?us-ascii?Q?E1XgnIJu/IgT/THClVdvtiDoTYa7bDbVlGVkxdMq4G3Gx4aNi/IbF+XJMt6Z?=
 =?us-ascii?Q?DXnf2ZGnKEs5r7i6XE+MstVpOkUjQePciky+lC7uyjIYloR2jEe+Qe5ruyaQ?=
 =?us-ascii?Q?oyH8PbaksWcZ6kvtG6xlm/ZE3C+5AGHBTBzZNQVncWCQy1j2GRC6FHtmCH/+?=
 =?us-ascii?Q?+2VQsH3SNjlc2uggueNUu/pa+kBDC7rRNpDs9YgJfWAIq8uFfP/Z0hdSwayL?=
 =?us-ascii?Q?Zj+6FGg5DC4AUVpPefXgxRTf5BmzfdE8pUTVCgc/98kcpVJ435vld3hq/0V2?=
 =?us-ascii?Q?bNx+1w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b2bc1d-baf3-4fd1-68d9-08da97226a2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 13:58:49.1830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /oTDRAY4G9kokwPuHyE/t4aLsUz6rsuw3oZoRtDI3oG+CpqKRGJdMgeVz0PlmnffE51RG2cTG0Hf3LVNGsaCccFbY97r5FOeVXVaBOCZWT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4283
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

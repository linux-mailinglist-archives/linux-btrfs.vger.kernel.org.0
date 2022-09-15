Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0F85B9D20
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiIOOae (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiIOOac (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:30:32 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A7B6FA2F
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663252230; x=1694788230;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=rPhaNC5vZd65ega5lzCcht/c8JNmk9g/VFaXt/1wqTJOdk4BwFrBDbDJ
   VckYewDTDDIjRdp3ONJfUwBNTgx1wK/4THwojA9X6+eF40rk+EYHfHl9T
   R4UNHuxCuG2cEp5HHY04bMd2uNJnam/MordOwXyzJrwA2oMAKzm97gPCX
   koCqg+aWLYPUKgINGbSOeGGhIcx/VIqc49t8kv2cIJ5bDn2lqo1RgUQ7s
   fLAwiG5vd29H90acr+Xmew7hT5rHd15eVqM1+Rz/ljZJbN17JruWUTVP8
   kmiwe6ziXk7TGj1GbbP3gUuRkCBsMX4GZaVitA3vbBoAwnlU8QXERS+9U
   g==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="211439812"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:30:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtXDkE54VWdupT25pLE6HH1+5gmvy6Rnw9Tgb2vCOzwIy5B/fQhD/ZfUc8VzwvANAX0xIzp5kE3JE2wyledSX/0yD3JfOcf1CZJZuWgV10muJ/rKI9X+G7HkmStr8tTJe6q4vkn1/JMaERj4NhOwA7m78V3eS8kTKmt/mAcEkCKu1OoUM5YKQ7ObfVNxmmIKA1qNW94hct2AcvIZdXuU2GdRD6ZOH6cf5tzH0PqIjUZ3gnaHpsenU1kC6iuNuRrLs2gF+Cgh0+qnpZ0zQhFltbXuJOeL2bA58NDpB2hvnO5xBcvsllvLLKV3mZGy8rrrs/FFNYBZ8K+Kdtkm06wZDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=eCiuZFRsw/n3yyxB1upVs2uc44KHSkPhaVMyxKkYkPfNyAEfhSvXJxT2amJaah+UaKjoftsloE/UVwTZgFwT9QWCXrLEX82uur0FmCrh2OdnHT1AXZohYnQyeStvFu07BUMyQaIgijUN/e5pG+KZ8TtwggDR0yMWmAXJgJk80yWPDqgmFEUZENdG/CAtsABwSogAbEx5OY2F2BnUHyAVoTLO0JwBqyaZPkypnISSN1QxySjKF4+9f8EJgsJhQXc/ZcywQfoEMNGimEAnNmXSOtB7ZbCUNAZSWvr7Dssi3rg8omfDFTOLEPNGMK3uY3NzZYLwFkPPnwW3GgSsNdpHlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=hnS1jwZ0dB5IZsCFMDvOipSfzdT0ACvqwWB+4AYuLwAnZ1WmVrsLeP8e1yiGdcDlJ9sQ1U69L4An+UBvg59Bbbvit3liJhaIbqb/PZ6NDwmlPO4mNEIFrwTDJBTcF2phZflaP5xtjXmzb8l/1iv2JW+PWfSBuSysCdMTP2r7GQE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5535.namprd04.prod.outlook.com (2603:10b6:208:e5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 14:30:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:30:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 17/17] btrfs: move the btrfs_verity_descriptor_item defs
 up in ctree.h
Thread-Topic: [PATCH 17/17] btrfs: move the btrfs_verity_descriptor_item defs
 up in ctree.h
Thread-Index: AQHYyEvB+SFfncA+z0SuIH3i31UA3g==
Date:   Thu, 15 Sep 2022 14:30:20 +0000
Message-ID: <PH0PR04MB74166D577C3E8D5E8E47A78B9B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
 <f86d4f92429b1efe41664e67405ce6266d7d2ea7.1663167824.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB5535:EE_
x-ms-office365-filtering-correlation-id: 7a0f5611-a59e-4955-4775-08da9726d14a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVVlqEPoeLV5FPZ97VPO+alLxrXDV10c8W4gwUBv+dXM+kmaMNKW1KdKlMmUo3BvN8lPnUTOR6E+132eTAuCIUBDwR5RyOP7AOCDvTIh5m/+AVGuMy/is1ITiB0IQkbSnLPNdWWaCd+F8UWsahLQ6yfD2wLHlTT7Db809VvUAhp3y6pA6jPDyT66KaA4T0Kk22EYHNkJxUDYTlzEy785rIa0XPgj3ZGKXOl3iZfGdQgngqqCXqtXRTn325eKhmPn7FxWGNydhfV3LvZ7zVBEL1pfML0fA4i53zrLyG9lhugMtuDQ0Bh0TqLb5PkPt8UcDT9SpdOiJUWhVFIQ3PUNIynGjDKKY+uQDvh4K+hh2u43V8XVySVXAGhIW9yjTrjLNj/gWnOLnXh7cQcEgT/304/Tb2W+OlU9sLtIy/3Rc4IZrc8B7nApVvXvOKBoT2/HFYZ8oAgNPeDRoL/CdmEBWfqPyHUiOaQraxc5q+vNquLKuhfFTYSXJcTg/PCT7vVq3Jm0RuSULSlZJg3Gn9aY10KqC4YvtePgry8Y0NXhxu9ud6JeuCy7hJbXwim0JVgkM4VSsizFysHXRwmCgQSHeICtx9DIuuwcRX8+fpUtL32iJrBfOsKSl1AyVde/JIBdSbEMoyfLO2xng6jD1ShcXOVvTkXsPduwPu6qTTltuQpIuCa1+hd3oGn9eCB3E8ug6R1wARab2frGXdtug9kucvq5HTlBOLhPoYW/rTZ4ZC9BwKSHxaxuhqge4DwlmJ7qDR2H/Z5Ef3JkGV9jTAIMgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(366004)(451199015)(86362001)(7696005)(6506007)(8676002)(38070700005)(41300700001)(8936002)(66476007)(5660300002)(64756008)(66446008)(52536014)(76116006)(558084003)(66556008)(66946007)(478600001)(91956017)(33656002)(316002)(110136005)(2906002)(186003)(82960400001)(55016003)(9686003)(71200400001)(38100700002)(122000001)(4270600006)(19618925003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VSD93q4sBbKGE/qPU29pLDSKQwA+5ZQ0seu5mbuLCxLZh+QmqOxB6EEOlRPG?=
 =?us-ascii?Q?hnEz5ozGq7RbrF89khNCNIe0bE21Fk+7SgGk1zr6ghN5M4JIvMHeWXp1JbDp?=
 =?us-ascii?Q?EsjJZWATM9aUKEW1xQ21q4KUrFPNTyASmKLa4JdUg8QhgW8IlQJgL8gPLK45?=
 =?us-ascii?Q?LiplKrCKLjvZYOvyg36llrUIOwHoSpPTbVJtfJ1RrXTUw6JvKVZIL2nD9sDg?=
 =?us-ascii?Q?Qr5XEF5nr12qpfRjhzyno52P5aAetxfCkwf1snQr6ys6LV9nK/81XglrCEa+?=
 =?us-ascii?Q?9imnHuqpHl7DsP/0UmbG8ksQrpuXoyycL5NyOfOao2KwhpFrFeQ2QKFoR+oY?=
 =?us-ascii?Q?Xsd3UL68VuID1qdgtM12LHSNzFmWHmAfuraGPEl8DfOpTVIPQyH+nQHtqOot?=
 =?us-ascii?Q?Kby4oCJu2pueeiriwJJq7PcR0qAl8g7jbFtWSy8UIBo5rNGc/B1Jwjiha4ld?=
 =?us-ascii?Q?cxeJiv6eFfTdZGpqcU7N9aD4w+5bk8ajqK6z6So6t6nf7O6E1yzIQ9QIAc2j?=
 =?us-ascii?Q?uzHP7zd+oEJr9kI9GP594yUJXR5TSsiPfyGxvsayHQ6fcumh3uw0N2smphFk?=
 =?us-ascii?Q?k24KJlRVMIQ0TFZ7RbhZ+iYl26B+H66UWmZ6fgKS48s0YgrtEDnwiJ48MfSl?=
 =?us-ascii?Q?rywb2v1gsJwryEskKYitq9oVqZwT0quTkKC/IMC3UQWdXKKCYKHX5HfsJsUj?=
 =?us-ascii?Q?QPEI4bOL4eNV4bRzcTUmI3PDzoIN8okiNrFMtmHF7t6N4XPK8fbu2djqCLvw?=
 =?us-ascii?Q?6BKOBr7rWE8o6YbJTGf8o6CY72FLI0CdXW6DBQ/EKZVk9TibknoOQBcRWPW7?=
 =?us-ascii?Q?miX+tz+iIermF/G+qIn2G64rp5SpqggJUtYyGfd2BcRqJvokglmnAn/1Gkdq?=
 =?us-ascii?Q?FhifZH98IrjF3QT7p2tFlyazVyvJLkON8aIFz17lwLTaXgXpPa73RNt6ZkB+?=
 =?us-ascii?Q?sKMXswD3ApPY/RdDedyEOZ3s4WmYC3dAeqUpLFSPwEJpoOJMjnbXndhWpwqv?=
 =?us-ascii?Q?V3kDQHktga8SI9dfiBfyMBBp7gcycQWtO/4vd+cO7xr+1k241WTD3ESTDLlX?=
 =?us-ascii?Q?6RF5jL5zvl0Jh+4FknliJ95rPVoxex2r+3ltqY0VPsV7dd7n9cBWqIyMps9R?=
 =?us-ascii?Q?QtSIRmN9FRt/m7s5dWVYRUqqgxyy7TO4WMnRWZYADHiF4XSdv4YJNMMSnbmt?=
 =?us-ascii?Q?NGBGgULPRiAc67+IynqCrNqBWjvlhWVJFWMj8wSGXJEDND+IsvknkdWm9fi3?=
 =?us-ascii?Q?kwFfDtG9zXRBjJG+Pax0lCq3c6mpm7D3BG9Ew1+N4Yf6rB/1MI1cZVL/qdZe?=
 =?us-ascii?Q?8uGAj+rAOfxhz0pfg47+8mOkv8ZfQEZ8vCtnBVp5ePO45D839DKxj3vQhD33?=
 =?us-ascii?Q?eeHXDDJJ5cNAdlt/2kiJVMhg/UHHv3PuLcTCh6RBj/yj9R8BMwBEVOC8TVSw?=
 =?us-ascii?Q?LNrxD71F0yQDdnlMT6ql1/wY32Bm3blHXYuegiCRhPsPDt4h/YJBXw1Xub7m?=
 =?us-ascii?Q?QuAV05Yne1Ayev2gS9ZWNmEdjQAz4OdeN4xOC7u1aJgFyuLpRF2SlKJJFCKu?=
 =?us-ascii?Q?H4pKaOdqbTxtmuHOR0HgnkRo7UpKNSPf4vRNKrc4sLG8nJP4N31fEYHdeePV?=
 =?us-ascii?Q?7M/WjbUhwBUBQoQNX+I3u94Ln3QwN5Lx5nD+PZTc05ciRiGqDmcLo7n2q5mg?=
 =?us-ascii?Q?ofZnDOUVi5l//t18wp7X0XYjHeo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0f5611-a59e-4955-4775-08da9726d14a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:30:20.1578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tD9EbXgFWeW5vCzUSyIGChghvUmwBtq7omLCDmjLsTMuRUQXAASeoVoVUSoSOptGqVMt5FrNezxEvMXOHfGt1ZdsLjQ25q61O9xiNDKGw1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5535
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

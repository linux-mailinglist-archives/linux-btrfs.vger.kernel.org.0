Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015845B4621
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Sep 2022 13:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiIJLyf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Sep 2022 07:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiIJLye (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Sep 2022 07:54:34 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3C01C6
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Sep 2022 04:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662810865; x=1694346865;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=OhgiLOaOD0IIXv1CazYn/KKhSYuUD0sMExo21JcYXdln5/P1bKTMvCVM
   nywFv9pJzn0yWZxINZq64jHf1eVDYWYxfPYy7OhfyTna0QsYofMhfEV3i
   7lslJqT4aQjfTMoT2ugYzhrnuuqInhHBatBRgj5PdNII1EUIh+TD0Ex5w
   bO/nSkFFgl0f1m/Ba6Ee3Yh0En3ym72R4FvUqgLmw66FcXsTCTAP89LWD
   ziGrzs+CXH0TcIxfUT8dST01EUO/3PgAs6cOakX+2Tow10m6NE+by2GcA
   9HE2oCqP7fIGdka2/8hFk+eQevtpdpbCyh5+gYyuzqvsQLtP74A7YUKOL
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,305,1654531200"; 
   d="scan'208";a="211002871"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2022 19:54:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ua8UY2zNALKJKkPwnFYbGm0YPj/9hvuyQz5SXEUW0wC6Sg0UOX5JxJg4JxEevSpLJ6WlhBVIhJhx0YbQHNb3xyr4bfUwL2ChOyu/YgsvCsFBR4TULQCrH3EPhlwLUbD450DnlxBiGpZn3uUOJzJ6q1ax0hZhDUB0oij5OvxY1Sxui/AJKROnvnJb/6dUXNIoAU1h/RwxSyF3IbJRXfXte65nefeQo0V2Ts+1hO/y3c3v8k2ix6hOLsovv1nH2dblEERvSKBI8itbOmd7tplEp6GAQDZyeCeniNi2xESdEQ5NlLELoaEI8cCEWcQfAKjRZ7RG66ihuLZHWJCyTlxRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WfUOOD8W6ngtDMveJemviaWlhOHwXTCQVRlOEPvAHN2rXogObdOo8/8VzcEDZk5cgd3NtdnanWJVdSwBHT9PXVa/oUZS8f28pz/CBzlK2pTz+L7StWK7svPKnWAUWywY2feM+A0WwAY8DGgnMYz6WXrr47q0TXErNQ1oHIinqNo7W0QBtj3FhF9Ec1SKk74Q/ZIcVCfxjCfuyQkMt6q/LT84vOhYqYNiVoKT3as8nmGrZ49dIYyM9NvN2SbUly7w2uyXpH3AiEQYxZCFD4E2reTuhMEokLJLln4fOW/uCmg0y/z95eKQ6eycRNDwWEJ4W0UfaHjlBLbXP4Iirb6fTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IODLx/bOh/asLxB/HmUbtz8VD8oPFsuIVhVRYJqOPfK6u9x/FrthLmoyDfmQWKzQ/JiZnMcYRrifLnjalmElQ1F0d5ialyxkv9+RhowT5BNPNO7Qu+16OOBaLLqD+yyhaAKhDr5AMVjc6r1ub/txs6K2UjLC6SRmO6jeLFxhLcY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6967.namprd04.prod.outlook.com (2603:10b6:610:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20; Sat, 10 Sep
 2022 11:54:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Sat, 10 Sep 2022
 11:54:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2] btrfs: zoned: wait extent buffer IOs before finishing
 a zone
Thread-Topic: [PATCH v2] btrfs: zoned: wait extent buffer IOs before finishing
 a zone
Thread-Index: AQHYxBnP/X/X2RCmv0aAdoNyd64+Fg==
Date:   Sat, 10 Sep 2022 11:54:18 +0000
Message-ID: <PH0PR04MB74169655A15A9861A84D89709B429@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <3c6d8c45b61b6977f3bb2e5f8534ca844e291d90.1662706550.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH2PR04MB6967:EE_
x-ms-office365-filtering-correlation-id: 5c57ac36-56df-47ae-0c95-08da9323311c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FV++IN4agsZJ37lgx1KKrSSmMD2T7FpoOk75IEC/WqgNXe5NS6/z1YlTkUtzMtmJaCHsub0Ftliw/hMtFKAlZYGB5ZCAHwcPH+N1IGeRUp+Gr5cx03b/gZD8Jom6pCAU8zc8UfLswjAO//Wo0ZcK0d2hVoj51ipXyzQif9oI3hx7mdEdfuxDTGnlLs3zjBpA/Unjy+aHFI8eTFsHqtV/jSGq34yYeOaAcL3dQ2qFGc60jg4ndKtjANRgkQ6YEvso+3i5xxnv3x6JOOshDIio65IOVx53lCOBuWZK5jKFOlV+r+ge9BaNV7C51ItRYQ/WC8MYYlOp/zR+I2qDjWIAFDTEH58xc+5xssNJNygEMloTJjN/z8mCYrniU1OGS4chVkUGGh2rK7jdG8oZsKipMV7DvG5U2Xf0oOAQhH5tyTuYzYFG7BgBzH4yPYGSuUZ1yEbL8UHq1GO+I7x5ySN+qkMtuPHC/4iFKSM9Oot0DkS6a3U0xa3R3qSK0tsjo/8+VGhwNpe40xIXOCMh/GbkzGXacl+hER+YJwSs5+dwv8MJNU+LzooeXlnbf+Z9ab8tG+bfMKEZdfVL0bZoOdozVvVNWdFWS4lenSqzpgGtqdOReaAcu6elJalzksDpl0ZwmGqpIskTXXpMPD6/cSU+ztpQdKd8Y9BrDvpl00lJRwQwOLS78cqNWpXEx1R4HaeQgC4C3LMnOvuvZ9xQkuvp6w6sYN8GqAKdhIacOxynKyuVobtApqU0zAi3gb282BoF89Bx40OTuzcMwyVb7iRaeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(52536014)(5660300002)(8936002)(91956017)(55016003)(316002)(110136005)(41300700001)(7696005)(6506007)(71200400001)(8676002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(478600001)(2906002)(33656002)(4270600006)(9686003)(19618925003)(186003)(558084003)(38100700002)(122000001)(82960400001)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qWNPzpkOzKun+mi7kYVXUxKU/9KUX8m093umkfBxCznECOxAZbIA3exuu94g?=
 =?us-ascii?Q?eLD8z5o/VKt9OIAGvUhaSDWwPZIa9nRlJhI4hWZyQIoazjNJepSAwbzUr2Vk?=
 =?us-ascii?Q?8fVRlZk8uJ1PtGmROjUPUhf86vdo1SGwPaTjqxaWdtN0ewjUXf/gnDnIH1o/?=
 =?us-ascii?Q?QAxw3h6trt87KDVA1q/aU042iD9ubVGVzf1uYjA/ue0ztCkgkKWzcJcA/rTW?=
 =?us-ascii?Q?HmW4MDt4kteruocisXg7XUNue44D5Wqz3JAfgkPkDHxzU0JxyVClEo2Jo9d6?=
 =?us-ascii?Q?W/uxovdhmu43Vp77JWoZSzK9lOxaeu/Rw1ghz2M23EWUB8oA+Z5gfmJ6gtdz?=
 =?us-ascii?Q?l+q+2xGVXUAyrRWYAaXzj95pjqkP0uNi7oC+cf0PyRCgU1UwG4RBfrJjWrl8?=
 =?us-ascii?Q?g+fwznYbt5yHr4WPOK1zx5Gu2MhptYKWiRWnCov2ZGnxc+3Hd8QHSK9tdwPc?=
 =?us-ascii?Q?DlSoykBo/D3UB2TbRZy8YprNle9CZvSRRM2+hozcH9IoFkLKqu3DW9t2jLyi?=
 =?us-ascii?Q?JIF1UmegXNjbosOD/ww/1USW7yjVZNzsGO338+ykWmVEtOMdFna0Z+171+uH?=
 =?us-ascii?Q?HvNnX6zeK9q7dlwkeHSWA5y9MwrmkcmsfnZs/dnfGTD7cMfFhYla1Ov7dDtR?=
 =?us-ascii?Q?PflOGkdRstUT79V18/Ce160gzDUDbLS6WKkmWS9729WCD3wzIMcoPtf8AMVi?=
 =?us-ascii?Q?bLfNowfTOzLo3bmUZaWF38cMQr516VYEyvwQiiV8KRoemE+eG+Ajf2zbWTZQ?=
 =?us-ascii?Q?oy7adWKJrQyQW79K1gMIfcHgqBK0Bsodc5Ud1WPaNXfyDxLNPHcTWanvLkZB?=
 =?us-ascii?Q?63VvSvvKlAx9hxIL5YSuJlHoE0Ya9bqQz/gFF4DJ1+7A08KpLLOxcOgded6p?=
 =?us-ascii?Q?mu9ctBiXRskrH9MmYZaj1b/t3jAYHzk08iKkrp1igRdgFD+aI+xkBqXuz0Nz?=
 =?us-ascii?Q?VOcnAUvy1F7i+N6YdGlQ/hDXu3iQWXi/8KbiXkPPRkT92Ii47EYaYWKjuJ9r?=
 =?us-ascii?Q?QKzj9qhIUJh9BG2aHuEOKtYCdL3t8x8+R7A6gSfVUvaJRLDLKlCf/9oDqx5r?=
 =?us-ascii?Q?daVDapFZXoIJCZzGj4RGBvqQav0XaimvCtoCHjQ8Ohf8jYfhXzzihcLnGFLl?=
 =?us-ascii?Q?0psGGTQhnwu6AkP1z/yrcLFFq+FcSM+jPccCex5HP6s1z47qmfqThijSa3Zm?=
 =?us-ascii?Q?S2LhjAGlZaHq3GIxfY+et81ll5SatVbAMBz37+AvALYvZvgO2MtOv0aLwBGw?=
 =?us-ascii?Q?79ABJWuNVNxK/BlaYZG70abBJZHV4EtA0M3tJNox89y1Ah5wbI61LSxZGsx3?=
 =?us-ascii?Q?5FcgKow3qBAG/wrpqZtIxWVS/cD3xRsXO1VkjCUSQuFmeDhblhyqLTvY7XL1?=
 =?us-ascii?Q?ZRg/jOVipi8vB1wSkj/rkYQE9INqFXQDGd2EhSTVW9T1tQptJEI8xMN2pECY?=
 =?us-ascii?Q?XKvjzhzB9eN0QCJzqCRr9Yg0+zbCVcS7jU5bUD35DMCWkghxaOY7G0GZ8+Me?=
 =?us-ascii?Q?LeL19PTaduuc08NNB7dZg8C5dwjoJ+q2jmuIhzji8VrzYEFPaP9LQIYO5a21?=
 =?us-ascii?Q?0v2KIxfuYpz5KiJiYzKuEs4Ltf6DiN9wPQHyS6VhpKTXFxE9j+YtcDv+xlAA?=
 =?us-ascii?Q?I68HrjkAxfTJJU6FLR+D2rLrq83ZXJTY91wag6Mt5ebKtWKIO43+yZYbRgce?=
 =?us-ascii?Q?bM/hSM1g8zZSePA2YESoUEMViGM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c57ac36-56df-47ae-0c95-08da9323311c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2022 11:54:18.3094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4u88VzCNgbpzeAH0TYKnZjvrcTFf8kifEh406iJv6AoLXAwB9RCnsF/UwGo9mOV/OMGyONIBHcxtoHC9IqhLJM7MBqLIVkkcOZDL0G/hfT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6967
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

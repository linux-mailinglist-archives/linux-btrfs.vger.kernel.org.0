Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9395B9CB4
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiIOOP5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiIOOP4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:15:56 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D1158B7A
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663251354; x=1694787354;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=w6x3GWS6buoYWEli5SpdxC6yO8vKkcsWyCAF7GEa908=;
  b=JWBOmYbFwn4TwRDOdfWeSJohCUMQbr5gCu/Z4qcrMOkH7AAclORI45BP
   tEMRzYJmk41HDFtIckgDLkmzM3osfxnLIOoA8PBw00OmHzV2pQN1izYWV
   l26FktgSh23kFXubRP+/3fd53WgspLPR3c8b+gR8Q/+UO7iHSZnNMYpQr
   LjgU1qlRwXxGAHgU17b53cTRnTs2i9UtJPbUdOLTsxZPLEHMmAdU6V9kl
   0l/y5Bq71Qpv+MEEmeTi87iHp+dsKZKWfxvS32idP89OEMEqhPy94x/OJ
   Cwl/Jl6cZIjLfrVPhhsLVOLjiKqbIELOYdaiEKthEO4l/eiJIi911jNZS
   g==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="211891358"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:15:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvKl7QFvtq2JrN4qzYLIcxt3cPDh42/K5dchmjpSWqyPibZ2UuRAZdzRxbdb7AYW1TWmymTjXkKrM7AnecH8Y521x7TipTr/gS330GVfHPNora85bfYkkrk+LRndQWq8C05aBC7z/yIqhrT7DN14HrVLEQxMi+GD80WkRcs23DKFUFZrbsQZUnEoX6vswNt/iGgr8ugplOK+r++P10pBBBA0umI8a2/eRLh6o9U6Kl83Yrw6SpPZEfF2k5cTbgPgnl/mgp9G8M/TnsACxFLrPzeoQHVvhdt4JD9wtOSUzpmWE/2OoQAe7fuVb3lkjykZ+x05nYheFhFV8Lvmzo/OMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6x3GWS6buoYWEli5SpdxC6yO8vKkcsWyCAF7GEa908=;
 b=LskTR70SKbYb2i+hbnLBz7e9wtFibflFZ0gdjg5gEMBWifd68C2e/HGxroYVXdQypUp65/asjDZoHT0STyCBivEMOJfc9jN/wXadKl/RpwZiCgJdggH2kLmRI2gCVLRwxn0oYOQ/jaq0r8mEPMyc1SxUUydYEPTa/PkHb3Uu9GC+4wx6AvvKH7P/9FsKYF5qfiEx7ZmjhYmLY3MaBKgaHTK3xG5sZEc5qlM7+ZCx8c69HwcxpoQ/OnO4sSCiJcIg+G/XVwNpwGw5ipKUZ9SA3cvaFbQM2OWmm2KVK+56HhIJKsa/k1UGMlFX3Nud8uQL8WXO63sPCNDcnOTRQP2qWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6x3GWS6buoYWEli5SpdxC6yO8vKkcsWyCAF7GEa908=;
 b=0NuO0lGug5gyVvXPUS/s3sHZw4S7GpuY+CMwfDuZ14mt4PAwDyWtTbyE/+YsPnuIVyiMGCEKeX7WRGbAoJVnAYHTeaWr865r94jQqjjcJayAmOxXXKpBuhxxjZt6oZedXOd+1HMeYpXzoanftc2M/A5joGxgcqO2Q9OT+aHccQ8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6860.namprd04.prod.outlook.com (2603:10b6:5:24c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:15:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:15:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 06/17] btrfs: move maximum limits to btrfs_tree.h
Thread-Topic: [PATCH 06/17] btrfs: move maximum limits to btrfs_tree.h
Thread-Index: AQHYyEvIOkvSKiG2/kS3+CIGFAr82A==
Date:   Thu, 15 Sep 2022 14:15:51 +0000
Message-ID: <PH0PR04MB741677BFFCF155BC0A2F4E7F9B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
 <e0640b40762be99c72f7bfbb295431d405624f1d.1663167823.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6860:EE_
x-ms-office365-filtering-correlation-id: 949699cf-d46d-4d57-7862-08da9724cb84
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2i6DLkxVShN7o3aYvLoxOjaV5WzbriOSmI2xviN2u4Tv+Af9I7k5ayo9UcAqQ06Fqzo8WThmNuM9enMjvNkOSs2D+ySMakOkSSdO8fhYlnB1m3NdDU7nonaYPnzvBh24oSLQTF4sCZmwqsu5OmsyDBpmsc4Xm0WAHV1xJAEZQ9r+/7d1Z7a038WMM8XvzVS73KaZRyNxPyloxHhWoPii4mtm0NBBU/ABxwI6cX5ie+8+2O8Xdz6LGlGJLi1PVP96svz/16VVbLRxc7xsgYAU6v5r4vySejrHC8IYP6I5CiJWvxqN9QkWB2tYSmqwHMvQZFZUqJ+Ap0Sp4x5Qn+WzlcLm6Q4D3MZm+ZhnbtiYoRaEDhJMbm7MVs6L1j1GdQhYr4Zm4mOU5kDTxCryJKZURdos/S6FWQfoBe28O27Zb+F4jd66CR5XRBqCm7w5Jnu4d6n5Twjs8GE7JVNiUCHMIJKEpwoLdbSZj/V9HPeOrGif0e/Sx5T+VPdRvKatNQC2p6U3zAz6MO69T+zvmWpKxlpSYL/sLKYj4UqahCduqGIhCWC7QiW8NzRRziP2p5yfNM2tfy+vZPAqpaeiKSZfV069AYyovD9xmy4PFSMeIHHxYCZb2QWKCYxIUkLcfaxVgcU52r457xBO/WUqrYGyY25PLb4DArvJj/QO9kF/8QYiIKOQfdsImUZU73Ov6UJrkwaCAGG46qCInkrGxoVfJA8yIweN+8Cdpqlvgbsc0bhLL/oV0CTMf7HWw6pYd7JmRGTFbkLmSdUr0qsEgVl5uw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199015)(478600001)(2906002)(55016003)(41300700001)(71200400001)(38070700005)(8936002)(64756008)(66556008)(66446008)(66476007)(66946007)(76116006)(86362001)(82960400001)(5660300002)(52536014)(558084003)(38100700002)(122000001)(8676002)(91956017)(33656002)(316002)(110136005)(186003)(7696005)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XvnEyKHlGeT/kTCoPR7WJXW+TFatTpnx+EnLXj2N6O7UOtXmz/6Gibe35hOP?=
 =?us-ascii?Q?k/7jB2zslat1Kt0MHDGxviE23h2IXe8OUFSSTFAHjuCb6KXGbAqUctV2wKYM?=
 =?us-ascii?Q?kqjfv/iP15OhL8VzGGzFaS3XQfjLPfmOX1BSN8aJuQNsVB1UOxDD9vfzeLap?=
 =?us-ascii?Q?7L410uEIJq8UwqKkXvwrav7NV/58wxz2OKaqMQCwFV7HvJTNve89w/6N4H2E?=
 =?us-ascii?Q?EsyZgZTNtcOQ3H3L4MqDHFO/OriqrxNFL/8YPTnB3Pv6Ikv6Fj0AaGMdd9Wi?=
 =?us-ascii?Q?hn+GqJVzEb52Qw3AoJb/8PbHQNJIneZzXqVQJ57492nbwEP5JAK8UJdnG9aq?=
 =?us-ascii?Q?FKQt+I5Rvzlu+Jo30UpOIAq71VfejMfl9dDAsHDPGql0wem+pO/wGXCOe35k?=
 =?us-ascii?Q?U5JZWmSFxmCqzrzY5G7ZR7FF7D8I63CCEJmkvPNIcAd39jQ/lm8SG1XSspiH?=
 =?us-ascii?Q?uBbbU/c/zQ8stP/zBh14MGIlVcTHCbIF2PoRUZ0Z377BhcbLoCd1J3ewmPNT?=
 =?us-ascii?Q?2sHGMQzxB47MLugLWTBIrX8a9iXE9J+hhs3Bi1Xa4ARzfqczi3Kqea7Ng7i0?=
 =?us-ascii?Q?e3RZ5+7i5wo7REIt6xksnMhtWpenYjOQG5odggAmyToYKJsRJxiZKfdd+D+G?=
 =?us-ascii?Q?UjdtpKjSJ7jnmEvIp0qySQrX2huipuHbLMivgTXhxe1Ro6Xis1kShqCychyJ?=
 =?us-ascii?Q?v5dZVlVwRTWm55V+MC774Jup9zuPOra86JXLQPd4xNvcN4FHnW1I5Z4+W81P?=
 =?us-ascii?Q?W9R/kJxSxXgLsC1s/+F7LKcPzc7Qij4NWH14RiVgg+Wbx7Wh6IOw4zjC2Stz?=
 =?us-ascii?Q?awL2oO7yFxBMK9CIygFtGZrZTrii/zUOL0feDxeaf+4ou9HAs6D0u9UMXaPS?=
 =?us-ascii?Q?61hOuo6Ijxu9DFR3UH/1mzpNFmMbuJiQLB6oOhxY4omCz/LG9kYyGRyW0FWJ?=
 =?us-ascii?Q?N4qucHrgA8qGqk4+2RLtKUR8nnMAAUjxuBIH7gmW6KThQ77UkELzmBfuM2oA?=
 =?us-ascii?Q?gb8IjzxMYty5WMtFEQ7UZTPi395y5WljV+HYt4LILeDfDrXtggvOqCZBJhm+?=
 =?us-ascii?Q?QQasBbtXgq5lZxkH5u/1+wtmqSTAego87QO/MAeb7msaCzl5rfEsWPWfXVYW?=
 =?us-ascii?Q?/ZcRL09uZQ8X70RzIgcf9NCnaamZZz0kBylAcoR2QzLp5xge/XA+hLIoB2NV?=
 =?us-ascii?Q?prjaSU97Gsmle+75c0MhlgwAts519nMIArH7bD4BasvUWCflS/wmJ5OWCQz9?=
 =?us-ascii?Q?Unbht/cKpb+VowifYOPl/I0D6wi6WSLhVnT+kMU9jY+NrznicJhTTyLz6qjt?=
 =?us-ascii?Q?+D6aXkZ9jaYSn+wO1mrW0VIeyau2+WdAa8gjm0iM7Lq0tDTZ1GF6WjKH0b/q?=
 =?us-ascii?Q?j4RJPpT+qESE7vetLM2JKpJ3A5HkZBeGKqjkd1C3loxKkiKeeVIt85UQqmci?=
 =?us-ascii?Q?xTs34K3O2eajYR09dQPkk2wYsH33qxcR+FqTP1Buh4CrFrTBZf+OCOUoha9f?=
 =?us-ascii?Q?TjPwWuO0xoiSZ7AAHEUa78Mbix0eGxDRjdqdlNzHwpzN0snAICEUve8nzx/e?=
 =?us-ascii?Q?gnghybVrDKN69T4VKkKkr9iM1M6epyeqb4jQqOVZx86mnjKjdXnA7rN0/sdz?=
 =?us-ascii?Q?vq4UlafuVZOG09EZwPL1rjknKzi1l8T1T5GImvqYXTlraCqghjfchBYImsw4?=
 =?us-ascii?Q?Xu7EwqapGfPrTeF7iiwB51Q69g8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 949699cf-d46d-4d57-7862-08da9724cb84
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:15:51.4951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXzXgLiE43ZVpk0qbTQV+w9YbZWjg2eftjJbhfao9c4YBHpuE0WVrtEP35amC65KVte5Qj963vai8JZxGshSarl/aBPDcIvDTpHGyQ/yydo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6860
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
In case the David approves the other 'move to btrfs_tree.h' patch.=0A=

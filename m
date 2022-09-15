Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3275B9DBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiIOOvg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiIOOve (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:51:34 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B5543315
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663253493; x=1694789493;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=TRJIjGH0Q46NWKxNprM6YhfII7Sc6+4lp/zeHFApLZRdYbC66SNc2YHq
   hNCBIIBFLjp4GHj5mBHx+aFyOZ0F8DL6vphFGT+yPz4eYnY2YISgR3f7Z
   M3x3RkJDuLvae3oGIxYIuHchSoYlrXqnH7K3nnGg0e6pAp+2SZj/Uo8Xf
   biWeN6KAeJ8JX70fIAtHyXJQB6Yx7yK80vac+qXgs47qNlUNIfmEmA0Pn
   FA6FuSu8P5PnX7iNpgXiUB7V4ARCFEYNMuy4T8AZvCGaN2KUnzq+ZakCZ
   4hwqsS/MnCtYmlX+UzcAtDY0bIQaLfvExOWM+c0fM54kN+V/6dshijlhT
   g==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="211441684"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:51:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYlFg0yWy4IVz4/y1Ig3lHDJA0gtC8Uyd8V8fGd+MYL4WkhcaJcPcnbvEuaQi07sJToMlNE7UMufZQQI6udyCA/HAOmfMbwwccfD4RkGiTP+A7gphSTedvwzqaL1fZK7Hh99yXjY/++3/06eVl+QXc0EfF+/ZyPtlKXiQXd770yjtYjv+vKvR6mgcdk1GQtyqJjtqQSQmtBw0T4It2uStJOtrvZFlSuBCDsUN5NsOBKIqQBogLn2S0c7X+I+5Y5xObW4JZUg1k5OGO+8Ba/HHZUZ1s4uQMw8qpUUE5A2//Vs+UfF9LUIJ3Gzf5zBR7G+zes9vGPU9D+uYJWxf5HgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=bWr1vmJYLwe5jH5YZG/3CgdxOC2yY0vxUzWwvUkAl65h9q5hrjlf8XqmbPfugSJW3tf4lUMiGDJHTdcGV9bhTW+KtVczA5YzJlStR+HxZ2wBuylt7B4b6vMUNrBqbtkloQzP6H2/1s0yF6rzQVmNox28gSQY9oyxhj1JRa1jyaYG2/Rwx+hkI3s2oyUATA3airnERz8Sc6Rvl4FlspPWJ2CTDIZBm7NF5+apjReTJGDrinHn3dXTpYi6mnVBJDJW2w0XrXS3DQJUSQ+SIRP7C2DQ7XekYeUDLyQYdsjjKRtrH07eNQTFY635q4na3Y+NVickU6SMeWMUX4U7BFs+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ORoUFE+gUhG9kKwpQnkOWRFK5pj5dcWszBnvr0SRXqXlw8dVNYtSj7/WInKrbH4zHifS3+9wVmyxMblF0Xm7VPGg09QRJVoEN3ku8CxTyYAoW1h3SrvJ7xRAVy8LGlMF5gQ9CzdZBRi63ofgd+VSrRqUWpqljFIKall4wbshgWI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5923.namprd04.prod.outlook.com (2603:10b6:408:a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:51:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:51:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 12/15] btrfs: delete btrfs_inode_sectorsize helper
Thread-Topic: [PATCH 12/15] btrfs: delete btrfs_inode_sectorsize helper
Thread-Index: AQHYyI59ZQFnhd94REasldIIBFo9+Q==
Date:   Thu, 15 Sep 2022 14:51:30 +0000
Message-ID: <PH0PR04MB74165892F0FE059493BC4EBF9B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
 <030e2b0b061a8ae57037f810ae3bfb2b4c9b0f4d.1663196541.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB5923:EE_
x-ms-office365-filtering-correlation-id: 575da0c4-705d-4db9-a852-08da9729c651
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hxNf5rqd2FNMJ7QwI2lWGdPdeSXklPYH1Im+T4uYq0/oRvRO7F/jEoIxmeDWomc78Au6AnTO0X1RjwsGxgoqEKnn07C9Wtr1u9+ybAmKD0OR4/xrAHA/VU2wpE7aHeGUzjRHTjG/dx4xD9BRXQUQxELSdMgCFwZh24fmpH78pX0ZHHnC5sAZJ7epIDzOO/mtohqqwEW2GqFc5K7xgZgtfst6fuQmOwByMDTT5KagbbNuQeoT6LA1zI8VdUK63MRQLZVwUv97XxVPAz7L2AgfvSGUI2YYnguOUWiRTZ+DceojEEUO7HbJIF2tMmD48QrvWMOsg+ZAWKOMFqmIrX5hUILPdH+ywLnjlwKtPXMWnSElP5YhZMqx4B1O+8ST+YCO6i6XIOOYXDUdouNLLIHb/VTdgiCjgfUZuJ2HHnrtA0w67TmTMhhuFjwW5FlkEUz+YYISXaNDolVPjXqI2FzO8Z+ozS4A0+xVCiMgb3A755KQs+NaIxUPOqtHoE6oY+VbhX5pbp2pf8+oLUmQJAs1K0pox6rhoCdoPYqsKzphTFgRWE/OXEA8GgHLLRLJ6U9TSPKiwhepwrgqrm5mhCcvc5AUvKcjKupQeuFMZxhM2ZMgSiEQudMHJzDH10u0vCf604gDhvAoH34gdpFPYllmv9PXQZ2JMFQnyssZ08ILPxyE1Mje6gGZTiEKrSmBo6uZ1Mu/qoLAgMobE2E+GK1bfarOpyvmol8Fje/G7OFpmYc4pnNLA7QhH3X2g1bVU6r4IKSeLAFTvcO4hyuY0Kjprw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(52536014)(8936002)(19618925003)(5660300002)(316002)(41300700001)(2906002)(66476007)(66446008)(66556008)(8676002)(66946007)(64756008)(91956017)(76116006)(82960400001)(6506007)(38070700005)(110136005)(122000001)(7696005)(71200400001)(478600001)(55016003)(186003)(4270600006)(9686003)(33656002)(38100700002)(558084003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QgCoOsPe4qyu7+rRPzWkVGnv+5pu9YhOR86+UkV+hAOkd9nAJYfFyfvteW2D?=
 =?us-ascii?Q?4FeTR9KPVVLsB0xkNdFCDuB474jNPmPSiWw/C2NoL938FckXHjEDgq1gkigU?=
 =?us-ascii?Q?epM5QzAlzd2eEka/XRJPpxbmAK/KwQYA629BcEv1GuSN+zq1dtwFlcwQgZ3z?=
 =?us-ascii?Q?x0+CaDjnqjETA7VsYmhGKS4Hl/5N28cWdCw9p77ni/Y66X0LR+LZAeCiwo37?=
 =?us-ascii?Q?4PusBhCw1y5ImHeZZGhgYgoaKXNftsBZwfAgzLFGi/8JT6MaeRG6Imr7wgVv?=
 =?us-ascii?Q?XTe1ndW0n/YJ1ug0okTQOxF+ek+gb02q2BQhFl59jA3D7APotZThpsZrX7U2?=
 =?us-ascii?Q?7zr89PpCfyFXDAjjSa6d4PGsqLoQjIUXl/t0NOkiChDSv37qk/mYneAHszn5?=
 =?us-ascii?Q?FqXNH2SpbwGrjGT7Li9i2sY01HDPmaUyYnTjtLB1h/odFgxEOwAQWwcSnnZU?=
 =?us-ascii?Q?DVqDq76pAR6b0hZfLije+njzgGm6aeDRaKlX70XJomXClFFdfINN6alyhRYn?=
 =?us-ascii?Q?18Jan5sBixBBV/F9Qe1gBuo6mrWWtKSLxrXcczAbmLhZQNStyIrr9u7AmMhK?=
 =?us-ascii?Q?e9p1Hpl/2Cxz1IMDvUEbF4indMN5F0nXwhGFZCWOs6JX+C5YIQglyPMLT+Oa?=
 =?us-ascii?Q?Q971m/WXuKb6WbzNbVR2ovZwknYJAhc6JCXQsS/6Cd9UVgodgk6PtGLmSguF?=
 =?us-ascii?Q?o1jjFcXZ5JiWJGNJfWbhdZ7YqFUxmZXkUQkcpVav3V2CrT4GVc5YHFuo5Qfz?=
 =?us-ascii?Q?M09Fkf6DkHL4g8bdtCguGlOiKzjNbiuzsjqNaIbROlVafzP4qlc3la5tyZVJ?=
 =?us-ascii?Q?8+o6ShOi+q3MWeq94OMxjHXy9duVdm849MjGEEH896+PLtLvRkYpp7ZwccFO?=
 =?us-ascii?Q?8CF7znMhdrxCXNtxWiWdUbC9yAihAoQ+nA0oQ4WTAlxB+Z+b4BPiV+NGl1Ea?=
 =?us-ascii?Q?DO7WkkxID9hxrf+bF0nlqV8pCqGsYHL5sm4gH9CiyoG/cqo96OCCCsCk29Xi?=
 =?us-ascii?Q?qHwWCUmivEO4V0d27L/FfA3dqyh+PlKKwrKfB450rF1C6RzNZl4+jNq1LdgC?=
 =?us-ascii?Q?eQ3spEXUBvQ7v9174QBJrf5fRoi/fGlrnFHJSp6gwN8SlyxLq/mC+9CPIEJX?=
 =?us-ascii?Q?q0TscNUA+JZjTg7Jgtg5ZXm6ha/CELlVTcCIX8Bo8LusAhvA3tAMwfeZgin1?=
 =?us-ascii?Q?PDK1DIS0kHwIrIjtFpEQ7CIaIhObzeOLuLHlUURPEVOjYmTCoQH4iuWnq7gi?=
 =?us-ascii?Q?K2vknv8t9VkWirIzmC1NqFP7s1I/LBxHaRLuZ/7MusJn8nLtBRL6bemzp7HH?=
 =?us-ascii?Q?xRm5D6SBOMzdpt6QiGAyzMeWyvq6s0dQu+BXOVP8+E3hl9h/Xj0U8ZpgP+jm?=
 =?us-ascii?Q?0V5NTKrMbOOOIYd2q8KQD9F+7kM98gcECDHrPTPVJaIxSxx4nw4/8RsDBzCk?=
 =?us-ascii?Q?Cypakw+TrxusmXazcbxqLiPTulRZ2H/luiN4M05hrF96wWQNzNHGYaTY6OCN?=
 =?us-ascii?Q?ZgUgltmJz8IVrgQw2Q5S3igDc8cQcVjNbC21tu6pB1UbJRRD92OY4tjrt4HK?=
 =?us-ascii?Q?yK5X2wE3VZ+xGxeLEmxVicgm8rOh3PNjs/lWCEGreyeLIAE3HJUxRyncm73+?=
 =?us-ascii?Q?FG9gJaitufv6qVzhMqfv5sc50KPaZA1KApnzSeP0Niez4xvTxxX4NYllUcN0?=
 =?us-ascii?Q?dKn9lp10KpR2rv7bCb2bBhfUYHI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575da0c4-705d-4db9-a852-08da9729c651
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:51:30.2883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2M4aYctX9Mb4LX1Bp4fdbOnWYt8w6cKSvfQuQjD6xre6VIZx7AoD7Rjymw9Gu4PCqxyjNsrZ4veFzOgXG8VXTOEsONv+S41NDY+j/BhyQ7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5923
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

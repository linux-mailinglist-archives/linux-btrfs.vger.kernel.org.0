Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE2C5B9D16
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIOO2A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiIOO1x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:27:53 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2CE240
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663252071; x=1694788071;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=lRaYynJ7ZzH0RevP1tOyqR5nEHawplX7D1Ie9EYNFauIb2DEcV/X8gF7
   y1HvqeHygUwr9g5o/zbIOKQlyNYBUPQxQnd/Z/U53JRqi39VFX8tgVHoV
   v3aRibwJNVrbGFdGqC9k2K0uMQhQT3Dtxrkpo45Ahi7+3iJMUGl/fZK7g
   9sUlhGxhOqukqSqVxg5WT+iwlbzLaNz/14wZN0us6SoLv8Z/isV5Kg7Nt
   JubvZsSUjmzUSmHXzOGxKn/xepMBwgB4C3MTI5wkw9TlFaj9Qy0LYuCc8
   ggHC1r6xeA5XSAqOHoKE+HHTZfw4K0+JkYsRTtw9b9xuaZew0jHD1Utuj
   g==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="211439670"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:27:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+T+0kPaAjUZ13mENQ/+IIduGdt7Ns4bd7kK8LIjDAnpWDoeYP2ifQNPcCzb4hRb1fgnVXCrBXRLBe/HGSmf5mEjf1q10JFiefdS0FkjRI9ktddPyExi9BJOrMOX0AccmWOtU6+FQq5zG598YVhxbnBT+/1bteLrVQ4T3gOjdyt1p6WseQkoxIQzbo7+UuCCMBq9NVoHLE5bbj2Yp7KMQbG5vQ1/2gXywpl5tRcUzCHR72rgkoPMisFpH/g1beNGtTdAae5wUpIeShuGkpLskBYi8z9O4a5QbF2iXqXfmZO4G75gWovwGehRDDWTcKu5X+XEhKuXNYM1NOicV4Nizg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Fd2QBL24Cqm7b/+NITnTQ4phz8sGplwVrcKxLXVekcxTR+pl1k8QmNTBW+mDEECkNmmDPAChKH2pPI5+Rzqpexy8SnTqE64DNDUUkURfvFwfF3wXE79yzqszlV2gZuY1pt00FmKm2iPhzh+bafsn2rJXgSOpnSnUJXcF2VuShOtuCgwNSi+iJQU6L96rx/CzAiqrDOIKwSjysqaR2wkZDHadTgHgga3HMW7dOQ4UYAV8s7MPtKKl1gfQcCdf6+Hs2Z0BNlapvLKhOBI22TquDaPD7BA3OuS3PjNiLaE72/Cxkbwo/+9OcxOUMNY9NTIS68Afhltskd2cjzRba1icuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jGE9AzTWR1T8lNzBrAcfL/LmTQZQNFtxEdaSVCYdju47DnXMTqg7X/CRsUxiAs4+ZkG9fo4wgaGWR4wzD1JlFWwGMhr4h6qT2gHmy7m5n7bO2zOGVK3v192WGS419PrAnFaUy7auUnIOqu0vAg3jV6sy1vRGdH1nq6dOOO5NLjw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MWHPR04MB0415.namprd04.prod.outlook.com (2603:10b6:300:7d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 14:27:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:27:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 15/17] btrfs: move free space cachep's out of ctree.h
Thread-Topic: [PATCH 15/17] btrfs: move free space cachep's out of ctree.h
Thread-Index: AQHYyEvAr90WSY0Up0yTfCqgyIB++w==
Date:   Thu, 15 Sep 2022 14:27:50 +0000
Message-ID: <PH0PR04MB741626C944CC1F30D49034B29B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
 <d74e617ece68c21850260393cdce86ad5ae33ee9.1663167824.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MWHPR04MB0415:EE_
x-ms-office365-filtering-correlation-id: cb9f355f-8a4f-448b-382e-08da97267806
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IkdeyTQ53NS2TtmVI8Af24MYP+wTyibQGsUIw/N0ywT10TSGDq9lDauE4jHPvWG1hFf4vmolD9CBSZUoV+NKcgEXO40sRXFVHf4VN0zOc+ovTgexhdpeDP8BxtW5ZPx6tVJYe+qe4zxRBZD6s9V/lB3+n8JXEqNucg/NaYpJckMh5zVsslZCHUuGWIXP6piUD69i1DBvS6ogdjoMGPPRne0UaNz/K13ve4ksfftI3t7a/pMoYswEQg3EeyWXW3yEUc45O5qrc+9rZEgY22Y9lx2VvNTLv2kc0m/3YA09AtFXaSGVPOesMb4nLGUIrL1Byj91OQSH6k9xkf8h2DAcCRB7HcZlOxBlJdd3EcmHtlHpjjXJGrjt00zQGYq9n5rWKdR8Dj5ZL58hPLvSpAHi/uskhcn2nM+x2l6pykdiIh1Uws/jRWxrdEEFzMFBvPNP+zMn2pjb8HHBRu/ujI4npn0wIgD069I54pZZc+eZRsOh3xfikdJzkkwh/rL1wWBgtRn/mA3XdFFzq0tCe7nKXcWTWPgrRfwPSXNjLhQuZjP9YxqDn6qMk8+/S4gCw1kpk2o1s0hGbq9nh37ayRiPBxKL+3PV1FRCi62QpbHe6sVucDG9MrYa8MrfE9ubvzZpxhWHrf+A6SEKDBMtmpccvX3OUjigcTYNCQqz/TjWXj15bFayAEVERmfJ9PeBDVmvSRgh++V6uhFdtI8pq76GXEgEBqbf3XqjZf+rCGQBGp5knhIizrJqJMQYd4h6/P1HPqjT0NxC7Di3qLnhal42Zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(8936002)(66946007)(41300700001)(122000001)(71200400001)(7696005)(9686003)(55016003)(6506007)(4270600006)(478600001)(8676002)(91956017)(66446008)(186003)(19618925003)(38100700002)(82960400001)(2906002)(52536014)(86362001)(64756008)(5660300002)(66556008)(66476007)(316002)(38070700005)(558084003)(76116006)(33656002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zF9JErMF9josmrgEqrabj6n486LCRT7wM6t1pNS8Vkv/9sklxkYbfiuMA1zo?=
 =?us-ascii?Q?xA4gsBH2o/d19uMjhwDcgkItcxf9sA05x3QOuW+nioMTAPnx4t7YUZPv86Xi?=
 =?us-ascii?Q?1qCqKwo2m/vtBMh6QYtxZUmo/F4w6hp1NY1PyEbBRHpSM/C9hfWs6fEL2fLb?=
 =?us-ascii?Q?Ps9aAV/QnCDj/3m2zs02XpOzCFOhTK2xULTHeHXnoKoZ0L7cDmsx2n/ySIAO?=
 =?us-ascii?Q?1Rw5wJ5RhoAGRqb5Sdy2RLO1FX3ypa9K+OZ7eokzNK3Lac53FPvMQ6ElISA+?=
 =?us-ascii?Q?gMtdCRmyhUN3QKI3DtPz0nPWvcK4K61oZzREOti2KVdwuN030DHGXeb5rYPu?=
 =?us-ascii?Q?B/QPrVdyyK6xco01ut+9RPfNdp9/8pAXPWnEY0E0o1tcPpkqyOw4fCZVRLij?=
 =?us-ascii?Q?ncmTjT+R9DpyZAc/yaao2pUhdizVi9TrHhWrCZF7J/9ItWECcyldsAE+azRS?=
 =?us-ascii?Q?7l4tjRtPkvKLmQ0pG5VBLAxuZ+/11909+PakNhpprBRskw6UuzXSUVz2GIBa?=
 =?us-ascii?Q?Ra9SIk7LMw1cflEXEIH5iZwFxrk4lju1f/wsJ9gzhH3YmJGo2yWsEAfXouPr?=
 =?us-ascii?Q?436kZZyz6OOhOHkdf29cE0wjKkWqFVqnqAcdpMjjnno6dCAOGwltoLt8zVwS?=
 =?us-ascii?Q?JJiHH8p8mujmnHL1sLQYr/hxpKmizbYfHpZuhNa8KPn5r+rZodLPukEJID7S?=
 =?us-ascii?Q?YuDOutD1mgdTHMG4gH80UJObvkeDPBm5i+SXA+f2lCp+S/KZ3fGeqvDH5iIm?=
 =?us-ascii?Q?6OyCzcO0RMfBLzUCb5L0++4oGu10NqWjm+9S/aqcoIH7r2yAjQYisImPLym6?=
 =?us-ascii?Q?QfaBjLFWu0uPNqH637tiHpUgDnSScZtVQqwFYCx3Xma7EzdjgSQ5/NRAcoqB?=
 =?us-ascii?Q?0cSNIh++GszD8hng0nHr+HinmJ/zU16iEJgJ1HeJU+jX9Jz8UtJDaU2Lm5hs?=
 =?us-ascii?Q?Uyn8vHtydcEMlUC4WNDvT5YZIm3tFOyXZeILE1T7Uuuh4G0vtpUIO7UvdEOk?=
 =?us-ascii?Q?iHZdPrVPev4FDxQOO4PC+fm68Dt1/dckC16R0q4T3iEPOXXpPT26abqMMqWo?=
 =?us-ascii?Q?eyCVHFyxmPv6pAH4HDVaR20q/SsgDHxVThBg+wNQaOfpou0zGj7uuwZhZwqd?=
 =?us-ascii?Q?q/yJSWZSYVsBi1BAIlyYOpZl9Zwnq58kzKq29APtvfn+AiEDoyPkqadARCRF?=
 =?us-ascii?Q?q+CsqwKiCq4x99wW6FFlodr7QcirFfxWYWbg0kX4xJ9HASATceK/aIAEdcOZ?=
 =?us-ascii?Q?shvi7Z/KMy87JrqAYh04jbZ4icAiNy3PtOpx8B1p1DpLjldpCWIGThdgoZju?=
 =?us-ascii?Q?FNsrA+Y1zCFFBiCW3ZnkjnLf6sLXEhR4gq+4csWHCtuRL7DV6XPFGypi8Wc9?=
 =?us-ascii?Q?A/GcGuYEIbqeLtXS8Mp4X2bXj2Ic0GyXhSVajl6mbUU68gAvXKZecAPxNlBH?=
 =?us-ascii?Q?pnEFOg2X3qdMuzy1fWdVJGsHrUUgWCJvtjq5r3S4ggf4xUFaFSqFYkTNBTbc?=
 =?us-ascii?Q?4KjVkoUKbhUPNmQTNosIicoArzlB9SO1sm7M3vxQwkCN+ac471HDQ9bSlrZ9?=
 =?us-ascii?Q?xqQ8Q/7SkN6dp5a1DOM+GjIaG4XkELmVPPhtyXjg153dR7Jq6LaZtjraOAG6?=
 =?us-ascii?Q?JklPEPfQUftTGbzDsAG8Wh6ZV6LK2Wl+SSfVZuCcAUY4sb6E+FIH8Yfz/0mV?=
 =?us-ascii?Q?+f2dTvm56FvsDKojczlKM7Vz1bk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9f355f-8a4f-448b-382e-08da97267806
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:27:50.3946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PzRl95IijJITrybh4PznizcpbZKydmLHfmeCNAanfPDerJ+aK/aSHGzb9p8fwVhew+WWMSul3ZNHUaDCR0gkOAXwv1CaOfi+Yb31iFG2DKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0415
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

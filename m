Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F071C56C93F
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 13:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbiGILka (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Jul 2022 07:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGILk2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Jul 2022 07:40:28 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1877691DD
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Jul 2022 04:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657366822; x=1688902822;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jQ16gH1ESqCcHfas7iuYN5oSd3Ob5+0QBCPkPDl/TVI=;
  b=LJrMAVasrwA082IM2cbX/8DVIWZa1Vb7dp3k8uAAkHj6k/TOZzn2ly7m
   LH+UtJBwaJh0N8KVpAQ7LPD2T8a/lTuWMrPIXfgj/jgU8ui3czJz+WinP
   I70ZdLfbRKu/CKNGqn+tk2eDYhHqbFiJaDCa9j0FqyVp1tSYeoLY8Yz8V
   nExcBLgt62zOtXh+mWm6RyTuVJBItz9zjtfp9E8qiAeSKN1rhNN5ZPeH3
   ifPxmq2GoExx4pMHh1sMbAIJ11738SFYH/Q/yuMS9rWg/OrhaMQc3IE4r
   6t9g13OA7hzG4a51xoK5cJSxjEpb0PWAwwGxlE0JTvUoepzIKkNVE4Tz3
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,258,1650902400"; 
   d="scan'208";a="205248991"
Received: from mail-mw2nam04lp2171.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.171])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2022 19:40:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAIz1ru7sXhWCv0e/vNe0ESA2mD7Sr0QeCDENXbaSOX2DAqHhXUd4s1Cta7pwLIiLrYuGvOD4NfoF7sCX2dnwjKpownS9NA4JfaQt0WbiRSFMZSrQm4yXZL06g3U+U0/34Owmi8VlAqItTwBVDY71hUA+gBvDEMD3R7w0m0Js8nQMuh3k5Lel27e5fDZ+YEYt6mrIFx7UsVj+owLQ1Neb3r58A6iL59Jicu8JAvulpC17RD3vzVQbNgshctOBCOsG4gI3mQrtbSQt2q2eOedFvjiM51pyK/ptggG3ZxlfGM07D1/i5UuebJZ+kM8FvqCbadhDFmI4jkGa49DGTJ8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPu35HOjRPVqp04yB7fybJ+1aBFpY3HOViXThPkrZTY=;
 b=g2wPnbGsBhxYyJb08CBdwfW35l0vM20z6n0n6yZb7jIg9T10+r1S5K49D+fxgKnjYboOXTUNt2secYV3kp234yIItURQVtoxxvVlrnu4grmkvZihCyxmEJGPps2yaLjVzN+frwXMFgQBei2m8Ir9s+6aivbht/ufa3IhrwMsvilbRGSvnoYpwTohgMiYoEcphtK+XPUloHLnzLXOYrijAvYj/EDxi61G+l9+fag00sdfW8lHFXwqD6NwAcfkMwWNoWyEP4PFIabORUgEVGRpTV5vCA0kWBLZQEL2Nmv1oPop2E74oiyqh8QOdALrGKbjszjK4pvjwplPqIua+tAbjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPu35HOjRPVqp04yB7fybJ+1aBFpY3HOViXThPkrZTY=;
 b=RynlKkJ4MVJWh/FxIbRUaVdDUqw6ZoLfKOhabAUkS0SJhaRrs7e+lyBbFwRW2B2vs6JVKoOO0EQt5zK3AOSjQCbeholr36rRyZTWTZzuvRKtBAWo0rJ2poWEvIv857rISpYQb9IEU0muCyElfC5vo9J0gVB4dgEy5zI86zWiD6Y=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB1109.namprd04.prod.outlook.com (2603:10b6:404:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sat, 9 Jul
 2022 11:40:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.023; Sat, 9 Jul 2022
 11:40:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Cleanup short int types in block group reserve
Thread-Topic: [PATCH v2 0/3] Cleanup short int types in block group reserve
Thread-Index: AQHYkjT6FWrv0FEhwkGQH1wxxtkOwQ==
Date:   Sat, 9 Jul 2022 11:40:21 +0000
Message-ID: <PH0PR04MB741610D00DF6BDFB00D432BD9B859@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1657220460.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fafebda4-6ca9-4ae5-d379-08da619fce1f
x-ms-traffictypediagnostic: BN6PR04MB1109:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h/jTwEFzivQ1VAxAqFDf2nbz5ShiwySzzay0UHMQDPgPAGWgK6b11GxIU42yXFm9dQQlHiwnrRLEnytxwxc39HL/7dznrI2M4jHvalSP5/CmuM6FzAe7YmcGvHzIMPCtGQifj3EnSxE/MaY5lcsC0gSGFK/7OHYyO6BXfiYL6m+E4B3o4WZEeoKnGnv7TpwnrMmF+q6EH7Cc2wlm3S51fYNf7GV/8fypZDTfJNraBjQZR3gIPdIHSa4Ho6140pVlGGTwEbS0ArychktTc45Lqdx5gG8mpTDvjDGgs5traq+Yoxf+OZQ4dKNfpfg8NRL4bBhEE1tevPyCs5EtJtbHAOGsuNkI3aVQQ15WZ9shEGoNqh8JAOa10quYYZA+lah48N6xv6v5EoiWXlZOCHLpsXAtwBHc7u4LCGkwpTqGnd2Uz7xEAtbhWHioXIqKXukYqH/zQpK9NuSE2yQsUvrC/jmLLfiLWTPPh58q4jQ4kYtUZzWM+yt8EuHx0RXhEgf4s1lBI2lxOhvjdxNh07XEUi74Mv74n4esKGCOahNnfa2jVVP0JdmqbYMABHGRdUgw1F2FD+SFOhVvDe+3CJ3pcCbaA/8AyF5Uzupf5BDEbyStNBdgVJ8c/hXTRslzKtvMidPqUCHSl9aAT5mUclT/G8Vv5xNLh5yeK5Q4JhX5iSDstpphVLPCLNYgiBahZpk51Sk5EGeeTg7nZWGcXJ8E2XSq02Z5lsxnuubrDRsyRpNqGihTgDOD2DN259JfgMaOb1tml4KZTpQcsYVhiwmUW7tDA3xMdxFfB24lbZ0MPwWKK6t9DHGMyvsg7hJOA11U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(33656002)(41300700001)(66476007)(66446008)(66556008)(91956017)(86362001)(66946007)(83380400001)(4744005)(64756008)(8676002)(52536014)(38070700005)(5660300002)(478600001)(8936002)(71200400001)(76116006)(2906002)(186003)(82960400001)(110136005)(55016003)(38100700002)(122000001)(316002)(9686003)(6506007)(7696005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9xxSxbGGHevz0GPfZ7T4pQBletXLvdOtuL34LTZl1gzQu/fmN0CNvzp1jsSz?=
 =?us-ascii?Q?UFRoGFCxiL0+1qeMTN7FYtY1TSDKjQnqTEqDG9o2y/WAJBJMFcxMPK5kdWIo?=
 =?us-ascii?Q?AqHNpS9Gc6UW/qs9Ayt7msjbWvVRwXizn4e7/XKQx3JxJBi/b3FcL9hTOtiX?=
 =?us-ascii?Q?dBB+DkrL/Wqo/x15BmEpWYMqivnVSW2bkcrgimLoaRT+ZG7Wj49OuBWJzLyw?=
 =?us-ascii?Q?5E4hdN8beDrbza4s1a6zpsE+casRsN2y+VxyBgqW7p8O9omW0yFttr3wyGIU?=
 =?us-ascii?Q?tLjt7CMzBPff17oE6HZXIodEGpvpvOBmWy58R8oEnUAr9tl5bHN7VRANbsp9?=
 =?us-ascii?Q?DuzySoBHNbiKnCFJmuJuzehtODx+7NpsiG4YqvxfgI7w8BHjI9kb1sllpbso?=
 =?us-ascii?Q?NQkqZjeHoqg6u9Bagu2bF/JuW3dmukV4cfz1IqgBMrFCElPWtmu8JIIqJXij?=
 =?us-ascii?Q?2HVFomZNY2I5JN4a6Po8IKKZVmBKcvDJ+s5VV9SyXB/m97AejT41RCP1BN/f?=
 =?us-ascii?Q?UJkTSEHkd9HnXAfRAU9/KwQK5HhMB5o55b4EUP8W+vTudJrlLYAQ1L3H/nvg?=
 =?us-ascii?Q?Qknyo+NGq6db66cuI/82Yco8v6/9ayyxI+LFJECvyE/CIdHsNGLBD3cAmFUn?=
 =?us-ascii?Q?Qd1XoWJVhngd9NUTw5TNmIrUZpVNb96rgv4kEUM32JE0qdM5y2W2q+WsPcIT?=
 =?us-ascii?Q?geFgQUc3LDgoO/PiQNBJ/Sk3EJFM6PxVcSs6T+vR+TluBIxQuk4vGaZy5tto?=
 =?us-ascii?Q?og4rLZY7iNd5M9oNRPoly2YKS1gHFG9A04nh61KZs+y4cGAv0Vin25GBtY+L?=
 =?us-ascii?Q?BB+ZEOTDWRC5eeFpHBNS2rlMJna5O0UM23htdQuM9TdkDGimYgd7DNmaXoBv?=
 =?us-ascii?Q?9AlbYhtXhh21+vbAgteaFlsQYHJO5rF2mZ8zjAzTJLXeFqTL1abKifVg9k8l?=
 =?us-ascii?Q?h4csQ5MlBb3PqBqYePnS+Ifn4SHs6sYkMKPaxDIpewWZtpQE8Hu33ZKjOqsV?=
 =?us-ascii?Q?u7z4YKDjmeM/mMpGuo4z5KNt2/JDWW+SZ0xgVaKRM3w79fMmOBOseEOlRYHD?=
 =?us-ascii?Q?kAxwmD1SYgvpPhs5TwS21ZxjHYiPwyAz1OGXfPvnkAB5HCH3S8nQ78ryQGav?=
 =?us-ascii?Q?xOp9iJhqH6K/qp0gXPy0zZIHlNmEgeKdPtKr3KK6qiml+QhXrkh5Z+kcPwX1?=
 =?us-ascii?Q?6IFqrpRg/2ZD1ch362aHsjkOKfbqSUEwI5bao3FjmJc5M4GaGLRD4mU5F4W2?=
 =?us-ascii?Q?EOP8a9NWESy7f0Guf6eCQJunqTOYav8jtnqSkbuGGesUyO8pEe/KoShOnhGa?=
 =?us-ascii?Q?+k0mBXQanGUqhfuYaaT8SoUqvf941VYbMtA3Vjj9MuyL5dLn/47rwuLrY5yM?=
 =?us-ascii?Q?/Hzn1170WNpFQh/43H75ROCddPYNpeFm6Ush4ajDD81ZVh47dWd4x9mNJi1L?=
 =?us-ascii?Q?hmMo4WS7AoYpgSSmaoZN5V4grlVZr0gu/B1rRQKQYYbJqsLKhpRLN5o4AdOj?=
 =?us-ascii?Q?Dvbm/4Gjv6RDP23gm4/a3QdNcANPPrTPOzivbJIiKUl8qSeRUXcmLqRUq55p?=
 =?us-ascii?Q?K/wef8d3nJaW23a41fqsvs9E/jAiqzm2sNa5z2S+SgxStQDWukTPIYLd+eK6?=
 =?us-ascii?Q?ccgVA9LGLMQuAiHIQbz/uawZthg68IGYifQ5lU9kA82HFGmfNCn2/qHWHQ5w?=
 =?us-ascii?Q?jwvi997hpMPifbdsO+A+UY8Sy78=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafebda4-6ca9-4ae5-d379-08da619fce1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2022 11:40:21.1763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8diOn+MN7Gc10O30+eyMROSCoC0CQlQnl8vVEWYS1xXSVYT8k9hrj5HsCfgvpqhulic0k/Q/Jy+caOUjfWn7N3l8wEa6BymWjXdnOjTxLYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB1109
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07.07.22 21:08, David Sterba wrote:=0A=
> Using the short type in btrfs_block_rsv is not needed for bool=0A=
> indicators and we can make the structure smaller.=0A=
> =0A=
> v2:=0A=
> - fix true/false typo in first patch=0A=
> - use named enum for block group type=0A=
> =0A=
> David Sterba (3):=0A=
>   btrfs: switch btrfs_block_rsv::full to bool=0A=
>   btrfs: switch btrfs_block_rsv::failfast to bool=0A=
>   btrfs: use enum for btrfs_block_rsv::type=0A=
> =0A=
>  fs/btrfs/block-rsv.c   | 21 +++++++++------------=0A=
>  fs/btrfs/block-rsv.h   | 15 ++++++++-------=0A=
>  fs/btrfs/delayed-ref.c |  4 ++--=0A=
>  fs/btrfs/file.c        |  2 +-=0A=
>  fs/btrfs/inode.c       |  4 ++--=0A=
>  5 files changed, 22 insertions(+), 24 deletions(-)=0A=
> =0A=
=0A=
Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

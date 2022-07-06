Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA74567EEA
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 08:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiGFGsZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 02:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiGFGsX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 02:48:23 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E161E2B0
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 23:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657090102; x=1688626102;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=SvVMD3Ppxf7li5fVea8QlXO00WQ1cEeS+xwMK8REWYLmToz0sa+Ymhkd
   uGcnGDSBPzWvGGDYHfJrhPtdlobAdp2g7PiZu0P1dlBJj6ksMfE08QT8b
   ENyWjr2udS2xpxEP3eOm89WKc6kfoxjSPqbRhToTkAIvITXGvv2t4dY+x
   pD0iHnt6pOepWxQsr4L/P0mPXvytGf4TkcvdruzUcJbyfVkE+crGrAtLT
   +X0xJ9RuvsZkSpHNXJ9Mv7Ge1aCUyOISA0htBpvUUvQgZYSbhQsLAN7on
   pATPNdz6I9CdBBimNjh/2OV8qt3N4hNXtO6lsyEHvJ6CP/uqO2WBunp8o
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650902400"; 
   d="scan'208";a="203610323"
Received: from mail-dm6nam04lp2043.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.43])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2022 14:48:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZY454rrMVD2wIY0MDXEUlAePgs7rE77X8+tjvx2QB8laqb0kh1Dojf3aV5vR6JzhsSLIXN2eCzjRBToiztICDm6aDvJOFSEy532VJpctAZoK9jopQ9wndRvYhuhKquqhvDzOWNKUfupL8EOHPqMfKgUOzgHY5Gcrvunx5r2dznrDU0uKsMjpnX30Lgg2StUUwG3Kyhn4k4z0m0MJYq3FlxnhAhBywTH01/B0qE2Gpw0Fk0hqIBUwIBnr7XM/OgKO8Id/cS+TpmAV7PSUaK5edLtmfXe0prRYUJln03kUORpyfLOrfyxL1+5zjsjwGbsw78Maj7dMBR12crgmwsOjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=PqMv96sog9i70+dWGI7Uhw6+WsJKSZe6Ag0A5dQiORs4nThMca/88uFnLUwz0azHrl+TUFekewHc6wXwr6r10AZMe8t9ghoDCRo/12aXGOr8cYyyD8uKk8u3RNah1pch4gw4SfXq6PJQcMESfCQRQatYnoxA3JuQBpv+jm+0QNxErlb2pkFLNeCe+NnEjQeD5YNze4+FRIOnBStIWPCFnnBEfuEp8L3UMuwE/WjpZXjgDhzvOIKzutiU0Y+G8ueffXgKHXyD6aftvaR9zev2yVZE6VAcKEbgkgM6nS3XHuayV6Byjx+kg2UUGmszUaTMNt4U7f8tvW1YTy+wjSLn2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=kqgexnc9F8RXfpyFISXJWNcajxD3yCUdOZpWiLfWA1sw2qCp3AM5MlHQJ+Of9DmkDh3hzO/Hrmq9/2r4syh//2KI9xiDg95JdrYfkc9pHBiHKUt0k7yGujTCq+96nefK4ddoSMCzcUIXBUICWmLWDzwz7570DBAGmT4bK8ptsVg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7964.namprd04.prod.outlook.com (2603:10b6:208:343::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 6 Jul
 2022 06:48:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 06:48:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/7] btrfs: pass the operation to btrfs_bio_alloc
Thread-Topic: [PATCH 3/7] btrfs: pass the operation to btrfs_bio_alloc
Thread-Index: AQHYj4JGTTFe2OPSXUW6JA0sB9QChg==
Date:   Wed, 6 Jul 2022 06:48:20 +0000
Message-ID: <PH0PR04MB741683F435D6024FAAFEC5DE9B809@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220704084406.106929-1-hch@lst.de>
 <20220704084406.106929-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a27655b-6252-4804-c01b-08da5f1b838c
x-ms-traffictypediagnostic: BL3PR04MB7964:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g+5rQH6Efz/O8byvUVOTHfSTVIe7kboO0wFT6yXWRfe3+wp+zEYQgM+Ix8vfYCrpGQGbTlQP65aik3rynKVJJqYK4403sYu1UE6L/+9kTTe3JUMjMW6V7Nq75yFPs1sOA0rHvY1upxGXy72HsJAlXH/3jIeuf5LdXIYL3xti+2O+3F/RveaUabsXiE5Tql0dryFnkHatyOBqW691v3OKcpa1NzRA7PG3V7Rdtc5PvFZFuJLwhbR8JrJmaG/OLBMPtUGOh0esC3Sj4MD9jD70pCGCD2j+Q2WuhOhnHQ5OnLHH5gZaGciNSJnhNUmvsGOFeCjQB99VcGN0Ynl4YRtwpiliv/f51mNiefh924COXyZPvBMBkZxe3oMtYvP7PAKjlU8/thC3EHBXM2MJztKYlzbwZZUrB7tvlIAeSPI4pMDRZPgeAVsNOnRPQ1xSLpZ6XhWmWxb6Rmns7ZyKg3+kYIFtof0a161ALW97H8uuFYp4Nf5HA3deYZoV2a87Ez6INjqihnypLSsM07qnkKPF2MYBxq5nempm9qMIb7KpecZGP4JJJJgrHPC/bQsGZYWb9Ip7vO9xf0hkI+cJXmMskegIwjxaEuiVizIV+HyjbwMJQX9Ky4q0ZIlt/VI9ZYR49MdUxIAEA96bCZDfvZCNwLn4w00s9yoRKkSBgWuZe9+TwJiJYrzRFPNaXSbAk49n5idBy2sA1xYqWibFy2/uR30ErgATHAKNa/99Gmg/6AhHLPbfJNU6yZfyXr1+Vz0Jl/X8Xv4RBWu1aDrOLbhLcftSyAW7JvTPITcPBLhh2pnFLzVQvLCoa69DBXqpquM5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(186003)(71200400001)(4270600006)(55016003)(91956017)(26005)(19618925003)(6506007)(41300700001)(2906002)(38070700005)(110136005)(316002)(7696005)(122000001)(38100700002)(52536014)(8936002)(558084003)(82960400001)(5660300002)(86362001)(66556008)(33656002)(478600001)(66946007)(4326008)(8676002)(9686003)(64756008)(66446008)(66476007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N+G2t+T6uwEmgynXLqdjSl9g69oTHHnmMx355mBrMcIRxWboMW6KzT6ZSt3T?=
 =?us-ascii?Q?SbIjTbN4nFCKKkEB60wGbdc333ZE/kubYlNFzaIdxKFQY5OUc5ngX7TIZIh8?=
 =?us-ascii?Q?gH55CtsgKqjhUsxYrNetBcAJGKZaQVq1Opg8bs4In2B/9BMBoZWhVbvehB4+?=
 =?us-ascii?Q?7jWO9ZOH+1Tn+RWRhVNAUqsvbEkMdvLWMFcD70BTI7HQrODT+Y9H2Lr4BX/M?=
 =?us-ascii?Q?dUXZJK1oZicBMzsvlp+1UiVqZUqeb5J5JbFijbmb1jMLTENKTUQz0qFWajiB?=
 =?us-ascii?Q?Mvf83HrcyjPAOJMRI8ZKW0g+R/2UOzCiSkC0nmZhR7KMXicCI2IjTCyyHhEE?=
 =?us-ascii?Q?v2aJtiHmfCtstwD4N4F8ojJxFy/aOzvUXVLL4APKQxXqxMMnDg+5bCLHMOfl?=
 =?us-ascii?Q?uKA6PTc1SiiJL9JdL+rUFHK/9l3f76FhgpVNeem30RoL8EQs0tkm5C7tHfwH?=
 =?us-ascii?Q?5i4r2rJM+v+y2+/5V3dcZbL0+e4qr004yREEAAUQRjji/9TvGrnD/6ffoP12?=
 =?us-ascii?Q?JP6kKX9T65faOEqBViX2RqLL35RYYBgw9JBY0CXY+5MLmkSfOxzh7dHXO0xg?=
 =?us-ascii?Q?mnFioTnUCINVMmuzu34mkAk5HQdtF0eRzAsFYxWstIFXsuNSbnaKEUqXOrB+?=
 =?us-ascii?Q?19I9OfLYCaGJ2GevyxFCH2MJhruxguBhxW4MTfBJROoKlIxIYDlQlhHYYTMb?=
 =?us-ascii?Q?ophvawVCO6PR5zzagD7LNk8xQIL/l1MpSAEW3twoQ/MdOwAmHVdGXWkUuTE7?=
 =?us-ascii?Q?esWwR/JzseVSIFwjKfdlCzlqdtKy9PWK6YkdcOFIqCnUd4smUj5l5RDzSGqA?=
 =?us-ascii?Q?C/I8v8md/2L6sHYfxLoJjq8S4t8hd1I8e0ey/TSteyIVNv+rct1yfNwOEbLo?=
 =?us-ascii?Q?hy957FG+opBk2ffVp2sPJJDHyJmjDdR3z336XdHaLj8+FKZ/5h/vUdAt70l/?=
 =?us-ascii?Q?EbLHB0fFwiNZ31uu25CAUmmx5ThDV16MGnzwu+gYLReQcyUGYy6pAygt2gAY?=
 =?us-ascii?Q?fEEuEZH3toxi1tcOL3jnOIGWMazlr6Mi2/o9uhBeIyoapdJaQ0vCAyfKg6aD?=
 =?us-ascii?Q?0uZdEftHDVvW5pPDBKmY+R0SI89h5ICdM+Osz3iYE9onfK0pxV79xXLiG8r/?=
 =?us-ascii?Q?a1UPVB6AqbQkg4D5hkCIXt441R5FtHSTXC1aSzzt/6jQcbzXyonhQbGdqnXw?=
 =?us-ascii?Q?KYnSdOOVkX7hdlt4V3Ivp12y/DgY3RqDx0yiI8XVreIpBkQzECWdNjMyI1Yh?=
 =?us-ascii?Q?uXBsFeugoTNjvLhvCu0muL6Hj6XwH6p4i2+J9jEgJj2CwG2E96vEmzg+gwIw?=
 =?us-ascii?Q?e8a/0LU/H4+q8e21y21FRd4zY3OJXduO8Hml1R17tnA8r/Ct3hb1kv0CL09o?=
 =?us-ascii?Q?uEyOZjiU7bR4eBG7TuD3p0k9OINaCqA2tnDb+xUDiZxN8E4tszyNHg2cJYYc?=
 =?us-ascii?Q?OK/ySav9RRzslUzrFC0Isdiw2Behtyi3vRgIrFvrQSr6tjJ/p4Y0bsDrKX5U?=
 =?us-ascii?Q?AT2U70FPZUjtJbNb14DTGeMAQGzRigkUhfJlxxfCJ+JMHlkpF0j2nMkSCvcQ?=
 =?us-ascii?Q?Fde5M9vO8itjtAK01SL8ysxPYLg5PBd4h9MIKAgVus2och2AhGTKAdnLRntu?=
 =?us-ascii?Q?fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a27655b-6252-4804-c01b-08da5f1b838c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 06:48:20.1830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gramkshmOs5+n+MdRpsUZ9akkhnzvTM/D0IPb045ddS7ZZA3U/R0J479/d6BLPJ+GGdEVBun7/twdoo6OpQXtyFxPxDHycxmkHcoG+ikbCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7964
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

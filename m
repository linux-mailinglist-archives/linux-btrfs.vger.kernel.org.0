Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0595167C8
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 May 2022 22:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348820AbiEAUah (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 May 2022 16:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244899AbiEAUaf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 May 2022 16:30:35 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF0A43EDF
        for <linux-btrfs@vger.kernel.org>; Sun,  1 May 2022 13:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651436828; x=1682972828;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=BfZBCTk+v1eLWB6TmhZPrF/j1ahph0cA0DqJLy8SJJoKHIh6y4Oa2/kW
   EXoqeY3kMc7X0vTFgOm7aieSZu8WGL2acJ5POdvlkAJ8S9/8XXm0kc8VZ
   Hj18/dJsp2X+JfWv/VnlNFQZG6jd1c6D2weHMk1CqTF2b648lasR7PbDv
   JMA4swA/dXxzTJeiLhPqAanc8OOai9V6Go3IYaSTz6x70roksXbb6/02j
   lpX3oek71DP3+5ayxal4gijBKjV17zBb6sRl+uimHiImMWX8YVIi3kNnC
   2oK/U3kYzoT617gfzNF9Vf+vWM/KhZ/TWTZ6w7t+EnoAWCfbdxchk+/he
   A==;
X-IronPort-AV: E=Sophos;i="5.91,190,1647273600"; 
   d="scan'208";a="199287017"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2022 04:27:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEjUSeydEJpaLV5fjpj26m/9nil52dlNK+QOZ/DThA2hD0Pnot6PFs9s5kckZj0iK+Ntvp6MsReAEnC9wYfv9LRPLq32tipCgJzvmDT7I8OmEvFyMH23CgXYCWrFWP546BsfIWJb9vrWQF9mdMAwxSAIi616hwL6qvHzFLrmxrdMKfEzZxy5bbRw3iEF/dHTfjxmRat8GrFVwgw65sctEnbCFal+l1m4i5Pu0XNRo3tBAW+eIDk8Rdwa5RvLqqroxIcUJvJ6Ogbj8qyBgJo/zBQQwGAWy2Sl9EISKEOg2qJ1yLsWZ/loVX/+CP8vh98wNxbRuKoEIjM6p4vDcjqeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=AFy2LlKfx4nB8KpavLyZ2IJMkW0AFqZbS0QCGsloH0O81UzjjL9wjDS8eXaTcbbqVVL4n7BMSV/ahAwFcjcz9zGgt6eINiohGLL9KfVYQmgiaeUXqsBMkqiUf+ii/gRnnbYFNbhG9yj5MEEfbBpBHUja4g721KKzEfXA6dNkWCrKXVDgGE49+BfIH1sdy8DMtuZX2OMVyMCfbh/orxYjvBGqh900mnf9pv3Vol35BXANSjKHA2VKkMBjzNh5YX6TJFUtSFGcCHq6EgZFbxvlamvVVr1nVP9HMAU8elCmtGDk926QxI1G/43vvT7jIUZ1/HH02Dxzh+0iMRa3wSWmhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=x7H5f0G8gmf5kc0s2f1tpSzG3FEq0icmcPS9GAB96VgGSk2CiDiyXPf+bc8U6aIYUUCCwbHLr/WHJda1EdVfI5crsNHezZj9KUY3eMU9TPN8LmuKTV9oDIgGY5vwefD7DfKjpr5wiOgLoe/mqKiTanBETCMrtAE1M0Fh0+iyNIc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6689.namprd04.prod.outlook.com (2603:10b6:a03:228::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Sun, 1 May
 2022 20:27:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5206.024; Sun, 1 May 2022
 20:27:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 6/9] btrfs: open code extent_set_compress_type helpers
Thread-Topic: [PATCH 6/9] btrfs: open code extent_set_compress_type helpers
Thread-Index: AQHYW/dpMjC/sxJ0CEydttq1uuLMCg==
Date:   Sun, 1 May 2022 20:27:08 +0000
Message-ID: <PH0PR04MB7416C5635170D0F5AABB00AB9BFE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1651255990.git.dsterba@suse.com>
 <fafc7bad921737290f418866b119ea7e2c727edf.1651255990.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efef8999-bde5-48dd-cb97-08da2bb0f6ed
x-ms-traffictypediagnostic: BY5PR04MB6689:EE_
x-microsoft-antispam-prvs: <BY5PR04MB66896367EDB016A3463198129BFE9@BY5PR04MB6689.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 70CwMfVRyqmw7Co/mrJ5ai2c2H7EfKetm/zbD5lx6vTTL1WB8llhvY6hggm++wTihT7vuN/n580qAsUq1BegOqTrXSD38A8bzbp94GOmDga1grQYYPzNmOQ1XBZDbP+NavbfWQK6TSw1c/ZFWInTIwVmMcf4oPaYSUWFyoue4ao6NywYoVW8gAYBDGR3ck2vFyl/tGnXTepzgpgkeHjADKeue8+ihT7StHQZWK9OyFSbsEHN2ljKDIboGObxcMkkdlOPE3ZWVeJJh89DGjjhXlz1AR5F0jLAsagb9j5+OvkEe8S7VYTb9forOCfJg8ROs7m1itNZa5l0ri9myPE+XnvSd17fwYd2PQGfArC2JXFFXHNGVGnleA4CtbzbUlt3cEvdmqUViuyk1HdeLfyRkwyIraqIcGL1d4GYiNujsKAvk0J8DbwGsH4JAg29oNCDGmte2JJMSwOY8JhNvZfEkMdnGrRDVla/3qYBpRTRNAFnVEfJGrWCyRgle5vikKLZAjBrEGsOGO7ovAcwYi/CQC91GmeHB3sT+1qVjJfCJS5AKX58kSEJMyI6n11410B1E4CbLUthJ1inX04HehBK5VmNJuph11k1B5ZcAs3lUUTv2+PSqDbxxqx/9JYe+SvNBpcQu9FrAdcG1ueca92LbG7N8yAtWX+0ePOVb+wKB4kk9QKpdp8XV1GW+1Tqge+OhyRYLwTHn7KONnP40R3pNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(26005)(110136005)(38100700002)(52536014)(38070700005)(2906002)(6506007)(122000001)(82960400001)(86362001)(4270600006)(71200400001)(186003)(9686003)(508600001)(7696005)(19618925003)(558084003)(55016003)(5660300002)(8676002)(91956017)(76116006)(8936002)(33656002)(64756008)(66476007)(66446008)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UgCnOUIPIjjiXTPdi9IQalRvCsnD3MU98mC++SQS75nIzr7yNKHNe3/98t9Q?=
 =?us-ascii?Q?7zWNBJjfeBT+mNTZrIuhGwv+xccVlAf57TIABPECkAyjjA/GoOptBzPWyKJL?=
 =?us-ascii?Q?Krs5/sywR9hlzMvUxHiZ0zskD906PyGNFQ5qafuiabskvbsIcADy0PJH7qXm?=
 =?us-ascii?Q?zzNKuEFBYECY/6dzdKL6jViS5lDVBD5/6FzP4cimY3FKnSw9KxQfsdk/oD4a?=
 =?us-ascii?Q?P430tFJrNnmhTwQa1Y7H8L7i2noWu2csliVZ+Dd8+yuEnFFrqRjJOinKX1PE?=
 =?us-ascii?Q?5Zq4c+C8CoXKG0s/l7lOH53kL+sYbpUgvQlv3ptHUZwvhBIOFZ6JguDQZ47X?=
 =?us-ascii?Q?/LkaSnh51mh82LsBoiX+EkLG27KUvLBXoiqpp+tlqmc06NFqktsw7LAvj0sy?=
 =?us-ascii?Q?ZMFvSw6Ac9kKD9zoRKVrD1PeUmf2Xi4Lc9gC/DzJU0f5PBU0NtvOLRQi6VJw?=
 =?us-ascii?Q?UdjYUwdn72/yUJOfOllPj5+kAiHDvTI3E89AFkImTiM28LFLdegnU5I3uyW8?=
 =?us-ascii?Q?DX01j9GxiB1H22+VtsXr+HedM4ePJjvxVvzooL5JW70xzrzCucqKh1j/5GE8?=
 =?us-ascii?Q?tUEZUYQW4V9t5aNyTlNScRMs5/eJcaU7mgpsRwLIfsW6ceDg8BFXetBlP9VI?=
 =?us-ascii?Q?Q1IyxK+GaoJnFOwDBtIVFGYDIgmhHFkzSiNj7l3ROL7zFs6m1WoT3Zvvc3O6?=
 =?us-ascii?Q?3+bBV9sLT8vZY/aGMV36vC5giWtTh38Dty1rECwAyxj/lF8bOutjuqel7lNB?=
 =?us-ascii?Q?DYBX/Fw0d1w2T20UEzXRaQ9B7ZATPZQ5QsXMaMRK9Dn655bIayxEcZsHFhVK?=
 =?us-ascii?Q?Yz29XIAiyBd8kp0Zf7B9zSK3XtsIaR1/E6LvNyfX+5mwX6tRPRXeexohz8n7?=
 =?us-ascii?Q?D+Lk/ohYn+i2GaTwzw/hGDScGu2S/AY0EPQQ0ZTghKlw+R1XBPZ91mRINWJC?=
 =?us-ascii?Q?6j6mAUTfGHUhaBacERngBpdcQrC4/RkG5ZBESHYw+XisIb8N3QgMZYmK8O3f?=
 =?us-ascii?Q?9fHx4E+kV5qCpm2a/zpdgHYvhiJjITguknq6RGqNdTtRfAdJh6UE404u0SBV?=
 =?us-ascii?Q?i2IJENhd6ov4VDySJgeNjJmnAVfigEmAF+g8krXLgBigHZjHUUr9hQoMwVme?=
 =?us-ascii?Q?H2oiDH/dnoe0E7ndJ3o3N+ka+rZDfxCEkDvwpEnX31+vb4HiqGwvUkKkIRxR?=
 =?us-ascii?Q?Duv40gVROtX7VbMA6R5vceIn/HF8CANCJPjPIdpj4a2R1M2WGxjcqiieLTxX?=
 =?us-ascii?Q?EHM6O7Mw6y4Fsb5Wbpg6GXDAnpcN5kJLV8WZ63Gc8rttXj6inzRE4gL+tkHK?=
 =?us-ascii?Q?FAC2Lu4CUItIwmAQw3dn/7gU7//LSmkIVMx1ZUg7doL8rdAIUf62z87xOJpW?=
 =?us-ascii?Q?o5Q1LCDamitbMxXWtuvSVGsB0+EvQH3a9470RxgCd3u8xPoEA16zBTbktEzy?=
 =?us-ascii?Q?hsdntk03vHVwZaLh8EPD50yYwkSHQi7UNfxDX8LfrY3ZWXmYFecGD5WoR3XL?=
 =?us-ascii?Q?in87C/hzsd/2WC3LIT0yT80emB+oY4Kr1tuRBoT2jwXp5rdyIeEEZgYfX91p?=
 =?us-ascii?Q?saYSnm0vvPE/FHFYfhHnrIhfH65/7nyiHfVRnb/cp6jlmLUKu6J1HS1FpgOQ?=
 =?us-ascii?Q?/MWHSH0oEIzbHlLOI1hAGZMg1Za9sJYGsgF95CjyrLPfOGBoj2I/Q74seZgq?=
 =?us-ascii?Q?zEfGy+6M1AT7GSxqSAEGyeglm/S4MHWPpNKlpuSy7NXvYFARv5Bdjhzs5ltO?=
 =?us-ascii?Q?En5nPGyCFvXhjCAUrygSrzr6IahsBq4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efef8999-bde5-48dd-cb97-08da2bb0f6ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2022 20:27:08.2739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZptKftTIPAtU0ZsMdyEwzBoOtEhIhMWJIfZyt6MaCmGV9P9sbAu/OgajVQ/WKD+m7uzM2md85wBoKaeZuKpgWjvuWNNADdgX+h7e9qpFq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6689
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

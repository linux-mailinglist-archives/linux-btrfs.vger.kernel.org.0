Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFD254F4AC
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jun 2022 11:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380339AbiFQJzy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jun 2022 05:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiFQJzx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jun 2022 05:55:53 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976964F1D0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jun 2022 02:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655459750; x=1686995750;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=qZNrQ7j4NA/Kso6/Nz548D8qkroSsPLlLEIRHNH/3lB/xOMZtXjCEAyJ
   aclG8LDkBS4xFUigqzgZ1mPdYR3oCa3kns9/k0rJvuwVaZ7MaE1lezvAA
   7GpWnrAZum6oqjylfixd0c74bYd0DFZzYVbJqaOr2YdeKuqy0xfeMUlsU
   V4Gtpsw+KnnBtMVdUzV2BGXhKYdb+dzlIc3fddk2monCCVK+fIc/Nzglc
   fTwtjST/GxOQx5yez2OK5VuCzCCUxrkEAAA93fLupFcLFaYL+FlcxOeLD
   lcMqdlFWJhsbNiIY5kh+iGJwX67dGfcriMFLKKTDh5L7u/bWZMsBDxpQ7
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="204178639"
Received: from mail-dm3nam02lp2046.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.46])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 17:55:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KC7boxm8hE1F2VZelAvUmtjCyYSSZOsxkkB8WWEfrKNhrgJJouzYBlMz0yhWoY5BfodXoUdbsBA9/4xwgH/WOpkp/jzpSKl57ZcCm5Z2ZOs4u1z+gggErP2XWs3TQVisJRPuAeHmTfPPJU0wPVL4xMybtnC8SGJSpme4ZJ1k3iG5YUxiTQqn7aNyZH7iW2SnNLG+58sQb47DBiNJP9lda0GLZOyPD9QoJKrklrehnn1Rg/r6uPkoRAs93fB6lO7eVKZXfhOShIYjzSpSox/KXzH3xHKai5S2X1vYoBQmih7tguzKqXyJeNKCaq2A4V3D1gQO6jdUS72moDq1sxKSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=N4r4C+ZNYBnbJTuRGjNJSPfCb5Hs86yM4JbzPH/9ATOBPpJ2xXaGM4XmF9GKcd8SSCtnZYAy3VjzRMZYzVShENtMnlygYvHNYHeHMY0GH4gmHa2wjTe6aAPgPMq9w/nbLgz/YBLU5tJRatPYJQKoLoLl+uJoYOqYsODbxfQLzxmTyhySsaQG0Sf372uUaZxjY5sl9EmRvQASICbUHTsqBTwUZTAt5riF7MxvHcMQ3CuUrMzTM6F8d298uDxWC1RaeEcBFLpF1Aa+icwXVIep5C/aZREAr1KNlc4w2E+TFe89HDhU79dOwbFqxwkXjYSQ/HjA1rjDsOACXSnghErRkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=fsdFn3OVxdtHVZI2Q1u6gT8HObj6kfdDs0PgqhLmKrr9Xppk+GdA+BTw5Bn6DLCfBUCPfNiDBl5cCTbouwXV28tz1uNPWF41t2IfthsOK55qkTHmKns/fXnESEgtdRRb1CjebikYk9L9FwOgqWrUZVaAwfE6/uOiC2F31YPYltM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB3973.namprd04.prod.outlook.com (2603:10b6:a02:b8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Fri, 17 Jun
 2022 09:55:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4c0:544:ac07:fe6d%7]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 09:55:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/5] btrfs: remove the btrfs_map_bio return value
Thread-Topic: [PATCH 3/5] btrfs: remove the btrfs_map_bio return value
Thread-Index: AQHYgMrLP9HS2TY0mEaJfOQpZ2sbcg==
Date:   Fri, 17 Jun 2022 09:55:47 +0000
Message-ID: <PH0PR04MB7416A08C103CACBC34066BCB9BAF9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220615151515.888424-1-hch@lst.de>
 <20220615151515.888424-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 834e1b1f-69c1-404f-9379-08da50478d68
x-ms-traffictypediagnostic: BYAPR04MB3973:EE_
x-microsoft-antispam-prvs: <BYAPR04MB3973D22114DB74EAD0A76C3F9BAF9@BYAPR04MB3973.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fb/RM0sNmLS5YRLQVb8pw0EOI+uO/2XW+PyrLR9BOLvvPsruP971veofF2SFETMV+MloAxWIuDcqSi/YDw0Y3jUcG/EUPOn3nIuOVLgbT5HokUvB6HyKHuGpDqGUJdjg8vmliQaX5Pr0cbYK3L/w4Cs7tY9Y0qJYHo295FttSOUYFSv5WTMPZ57sRtk1lZY9EYaB5HZL5f2DsopxoNq8d8DTXtdQoaOk0mMhVbXZVQrn2GHFlcj1ilcuIyBeIiK1apGXmxhOLs40YbUt0ETTxA79e5DDayPVLWMMisi6HHRpaaOR3HDCP/i2ypACQN2Ue7mgScK1MR9xEhbKPWHOqRNXJuFbikvxs61l48EJ7p/kFSqTMettHGx6opiD7mee/E4MEGwJgGTlbACTe7cvBBg00DPd3dMmOodAeSEjOgetEWr3coLEc3mFZTY8YXXAWyBum2yxLyMmNQfG9ZSZC6SUEkfKiSMUrfQ4jQMRje0wkir8ZCJgKP6U5o3hwgJmOcL91gacpw4WOVC19+RJJFkIo8HRgQ3NqW0iI7cZeN2Xgkt+f8f0HU4C3XdNvzz4XWcMzctANQ4ByVnaxM+LgNYp94oxyZciw67L/gjy9a3v792xP/FpW26Uw1bhdm4ZT9mPQB2Lui3McOsrABl6W/xd91e7/BCGMmhHvpWc1VP3MHdvEJfDGlNV7LK4NN7hXvRuG0tekNwFGcvsqKT6gQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(110136005)(66446008)(64756008)(55016003)(498600001)(38070700005)(66556008)(558084003)(4326008)(7696005)(122000001)(76116006)(186003)(91956017)(2906002)(66476007)(8676002)(33656002)(6506007)(82960400001)(4270600006)(8936002)(52536014)(38100700002)(19618925003)(86362001)(5660300002)(9686003)(66946007)(71200400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bcdk1vl1XWCTWyhtulGqnCbfaM6PjvWeDXc4EY5/HaUMwALWSkHpHalfWSrD?=
 =?us-ascii?Q?3MzwFiWnWin6SK1ghGvf2AUokofEnM2JHv5+OEIinDETTlacWHm2RiZBRrQR?=
 =?us-ascii?Q?ZFoKcZjH846+hc+9oMRw8olqSIUNKqWmgYzv4bQ6F0JNM1YrLs78wX1C62mt?=
 =?us-ascii?Q?ypjI4acrEuE0TmmY9fQu8aJPKBolHUAp3KSvoHltHN+wSr1fMdoi7kd4Ntwa?=
 =?us-ascii?Q?Lpo9HtUqrS4oDASy3t00tvLHMuxVAXTtdF1e6Ixr4LwXQ+lRG3kmpvYozqpF?=
 =?us-ascii?Q?vVJb/bQYDcLzJZIdplmwgNGyaiHKO3mXl6nH+PtJ4sC8O5Pg1Eo7DgyECtJk?=
 =?us-ascii?Q?RDwlcdG37zQMhzXRxJU5SzxURz0zE8PXlaOxaosTDV8fCteQZi17NLywBTtA?=
 =?us-ascii?Q?1fH+jmlWIWjPkFvifVEL5emCBn3OWM/k33Zvk1JTm0yjY2fl2zAmZxWYho5B?=
 =?us-ascii?Q?RUuuoSnKjSKjQNJ4xF/N55fJwNUuIHL63oWrlA44+G7jagy8u8FIj3KVetNi?=
 =?us-ascii?Q?bh3fmJx4HtQ1vz7mxt0xwAHkN5xI2tRhFEYrMoTPQNDVLt6KcgKejdlYeU+o?=
 =?us-ascii?Q?PTq8xs53Q/KLrSFTXbRtcetfrroODhQDz9fAFEUtn5Pss5UJZ7tM5pR6m5iG?=
 =?us-ascii?Q?TD+HHokUD0Zn8Pxmwok+dARm9cDm36jPVp5Ti0/2h0QMy864rJDhSu7S8WKh?=
 =?us-ascii?Q?QS32Uo18RoHi5PrNMb603QZd1VW64Jc1oOQj424LDxie3SWDpnfQNwAGBo2k?=
 =?us-ascii?Q?zoXNVUGsg7LuA3YDWavreFbujWh6m6Zwwz3ro2yEUKNoSULF8p6D+2dO2A3a?=
 =?us-ascii?Q?I9mEaDfkZowBZ8Y6nFpVzdj762ueatsJg0tQ9EaKHrzXxxgL9qniwwKS+SOB?=
 =?us-ascii?Q?evR6UAJHPbXOzrkyrqRbRQDy7Bh5FRB4ILC8og1yZgZ0aws2u4/G/73DqJJ4?=
 =?us-ascii?Q?A0KqXWRzOcZJkLEYMIZR1uWzjFQ5Z8TpR7q+2mL5qAon6EhMeIQr8bG5ku4P?=
 =?us-ascii?Q?KUgZCbbqDXCVlhoApRYuKg3v4Qjm3b0ghGYt4wy1OcjFJa+zrVna98aQvAf+?=
 =?us-ascii?Q?xpUUBDdZIjGWI8K6g7i7bpfltYrsShRgjTP9jCfKvAsmprkiwjhR+OGT3xNK?=
 =?us-ascii?Q?4ovgD2iFhonF2fE0EINSu2EAoUqZXHtrSULW8ZNFGd6tRk1FgP3kP4hNufUT?=
 =?us-ascii?Q?8fcFvzmCslADz74iQjF5AuVPWwzziwYyH6QygNELqRz//KultKoJEMXhuwo8?=
 =?us-ascii?Q?QbPgrufGZ3fWlRaCVbnakvgyFmnH29E+0q+UQXo9LX3hIrjYJkrCGLq/Imch?=
 =?us-ascii?Q?3cDYnJJupGXdJpPqecW9ateoI1OQ5o9r/mhZt4V4iLcgg1HZK9s1Obe8c5k/?=
 =?us-ascii?Q?yN2CFWjSut2wlWGSkus9A3HrhIVss3qVbBb2Y1QkAY/6cXa3/RGSR0lPwc8Y?=
 =?us-ascii?Q?SAKsf9G2DcksUsjYxx/sJabObRspvZYxDYu0avfRN7AKfA7jhKED3Z23i33x?=
 =?us-ascii?Q?VlRhStA7ATHYfsmv+pIcXumjxLXxEv0jkgqbi7gbNOdO64tTsnls3fIo88gm?=
 =?us-ascii?Q?PFk02xQHLTWxjsNjQ7yqJ6adaGTXjC5hAfj/QDxe1RvZQaEaFDJGhjzxdjuT?=
 =?us-ascii?Q?GCfFWnsBZQavyINM9BfTeDXfVOajAieDYEsIEPU13fzi9w5kejUI85S2WVaG?=
 =?us-ascii?Q?59mf3FeUIIc4fZg38kiV0lXEEtAb5pu1s5AaXn7TXdLlBPeOyhFW0E0wVKCU?=
 =?us-ascii?Q?ETOXw+ku6utos0I53VQsRlD8GLaNA27KxSSlaGsIJo4M0xSNNWoWBKJp0f59?=
x-ms-exchange-antispam-messagedata-1: fq2jDKa3NLenU2ZpBmoZCkB5ADQ/JLDI2Gocj4De69vrdLdCJE4pHlSW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834e1b1f-69c1-404f-9379-08da50478d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 09:55:47.1048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7stLpEglCXsdBe5ALszFUqsCjndcTI1XHxfIkgZzTaek2gXveMbm7MQfi8aL8wS4xmPpElmpdYRn8Tkg/Or+OFPMD0WZKrdK4pERv4astU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3973
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

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF9D567F8B
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jul 2022 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiGFHHo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jul 2022 03:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiGFHHm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jul 2022 03:07:42 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D8F2678
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 00:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657091261; x=1688627261;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Vplo7ujE0ny9IUnEDjfGoYtcj6ecG0uzxLqGlW5p1Io=;
  b=BpqsK5aVYHt3YlP9tUw0dAeLf8IKlNe2aFhixa/JGS+BtQOf/dlQs99X
   Lz3+GNzzlYFPO8f9qtw4BuY3WpzsXp6lLzdF27NPpBmDYFFrzEczyiPz4
   05AvHsUtZtwtcGeFYVu6fx4HA2Bdezb7PlRlMI+ZDvFKtvRa8435HvWUY
   /lzZJ+C0MjUyqpqNepCOEcPkGbSC4NYb0+vBHeska7d6Xtf8uEtEDjQwZ
   dtq+RJFi7bZqkF7mjvNLjY7jlKt48A3U8jRQgzTUpf5UXuOpPDvUjyGQa
   oxbmqdpGPvMBgo3LZt6OZvhggU1G674kikyfdYwEEhzhLHShoTNQFYoWM
   g==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650902400"; 
   d="scan'208";a="209850171"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2022 15:07:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M84/iSrdvkhF4t7Y0RnCqdzACynG7thVlHbF2NjvKv1rkK6FI77mNdFSTiclWrl4KBm19SIwXvBbgEE+GtZW3AfEuObGfQpvEXh00p7yCUzoW7tcSOiXr5+/elYVbHyxl13st5Mopg9SbpNOnm+9afiYEXkL5RLXGEE0C8DfcGh71ZwdTuFXO6NM6z4E3fpQR1RUcH7wy7xPCPFf8bsznRwvZu3jfcJIGL5PZL1f6NQv8HsT4HA5jPEVHdNhSMsDbF517boOT9ZMWlMksghzzFjdXbTsZ3Fxfz8GKAkHZXvJR0Bk5ERQZysnPyjLizwDHDSMdbssF/b0mzrEqV7xKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAO888r7GbbF93Gz/Be2Kb9oZOaC0mAFx5n7Gpr97AI=;
 b=kazYJoAJSrMI9wwXMisL0LUUnOu49YoxnvdtphDXsH/PsdDthfbj5wagAKkYq4SsXmICMxK8uKn8fu/qoNUAcEuVggp0iJ3/z7nLhEuJGI0Pm0w8czjD7ZsIhcxobGWB1Efn3o05Qy5NiJ8k4vIw87PX4LrbqbHAJ28e/ARc93n81z8Nr8ceTgn1FgRHU1zh2fDneXYceX1GXGbUPffqQ02EUR18/Z1Pygiiv3dCgB/UBFBf5SGXC0Ap5sBgch0xlwOan9Tq9Ku2sQPAImG+h+JelkIwDqmPUSz4iVHGuD+FxiStFlyhCUH8mKjztEPWlw0dUk5PIBq4JsS5oOhGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAO888r7GbbF93Gz/Be2Kb9oZOaC0mAFx5n7Gpr97AI=;
 b=xzqvUA9mNFVbdf4GVUXuz5fL7Llxqq+OE6jlZIbMtdSFgIrhDWJKhFZqoRnggc6PVczxDFfutE+h2XWFfgd8rV4rcvDhYpFmo5W7lCrQi46FY8CXs15+LtVLNA6T5DQcp1ySblORrnQ2bSMEn0CGziNeD4HS9zkGK1dfNft+xzU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB5228.namprd04.prod.outlook.com (2603:10b6:5:101::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Wed, 6 Jul
 2022 07:07:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 07:07:38 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/7] btrfs: properly abstract the parity raid bio handling
Thread-Topic: [PATCH 4/7] btrfs: properly abstract the parity raid bio
 handling
Thread-Index: AQHYj4JJgVohuX0M90KMiq8L9IQGSQ==
Date:   Wed, 6 Jul 2022 07:07:37 +0000
Message-ID: <PH0PR04MB7416CFEB8FE90B2228EC7A4B9B809@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220704084406.106929-1-hch@lst.de>
 <20220704084406.106929-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 926ac71d-6cd7-4be9-f689-08da5f1e3592
x-ms-traffictypediagnostic: DM6PR04MB5228:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B6YmHOnRrJloWwWywqnWCu9728uzogeBWfZE0H+NH+UO3Rs3N7nMmqPXSX3ey5Jhm2kLHE5VeK9xvnt724x0bHAkjD+Cz4mbyZx1R0TVrEToNsbjNWkP73gWvIhIcv04iD6qseFT4+Vmjxu0U/eqksmlE9udJKM7BY162ICUWwsg8lX/xt8QKClNTByY1fu/BPmnHsCfONjxWRzIHarALVJiF48N7qs0DX2y1NgtutSKBzrEUKHXOcLw/wqYQADq9hzEDfjB7G7xTfzBvyPiNSAFuEV93vrgx7kBnx7NQ+V6r27bLjFDhndVmAVnDe49VivtsMrKB+RjIGxjrccHFasGXQWj3Ow3Tkm1k9VfYJuqrmUriXj6mZVNhtlQzvk+IKZlGFuDralbIhy8Dy2AAIJnNe13IQEyfHlVdgojQeXcwqpx5SEB7nSokBrUkSZuutnu76uJi7si/FJThY83P8OhEsPVEprKOBXvxwkRJJ48xEiY6+Xzvno9wHHDz3d5B/6HsufGO5iQ3PLo5S8doXRVYtR8BPJzx2mQFH/AZyi8gZ4Q0tN3GMc5LXKnFlDYwfhucocjGA6e9hEgCSdC/4h4NAWM3WwKjmk3PYu2HaH5q5XAOkieFj8Bgb2V3K7tH+L0/MoyPe5JOezP140MSVT1H2h1cJVbfJ1/EBKr+EsE2TlJqGxDGYWKGnIE/lHAVYH5GCV95PFmBxvCjtpwOWt0yUEsA2XTBBLqQRZ7vbqQAGzgNacvMfhHd8TQbnXUGnO+NRAZIMyIGto28kGmrlo++JlCE6FvL8H4c82iZirpOAUicJFxOT+vMLrxWAjP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(110136005)(316002)(53546011)(26005)(7696005)(6506007)(9686003)(186003)(33656002)(558084003)(478600001)(71200400001)(38100700002)(2906002)(86362001)(8936002)(5660300002)(122000001)(76116006)(8676002)(4326008)(64756008)(66446008)(91956017)(66946007)(66556008)(66476007)(41300700001)(55016003)(52536014)(38070700005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0DSY1yWAWDsLbJ9ZG4mZECvQWeMWqKHKT9dTmg/NRVu4MzBbEaygTbsGSUMD?=
 =?us-ascii?Q?PAESeybqMeGnTooYZG5uF7zJIvLeN9opGKQgEjxTp9gRVM/b5ku7MCaJvWzW?=
 =?us-ascii?Q?XbWOMjrIQZrbNzz9dANV6ZzmTbLB1Hm641nj6J4RUAIds1SagrItnBytl7XJ?=
 =?us-ascii?Q?+6T4jFvGVzK9xYPKISbNwY3N79sXzpQ0DDYt1IltG5QPptKooDdOu3lhiRFK?=
 =?us-ascii?Q?+cymYuplYX97XBlFzRXmElOp2rYTc0wnvoQnL03Oy+/bS5wUsV9m6im+iI1x?=
 =?us-ascii?Q?Z/QT/thmViRJ+tav37voDu5tKGocXXve71r8z/FDPdzZsp+Fv8wJFUltsvoe?=
 =?us-ascii?Q?L5FV52eB80zyW+B1VbaxMbAGeToLhVU2+VCWCCn65e+pbcYsk2dzQULse0Pi?=
 =?us-ascii?Q?7lkspxq1104L3+AbKeKaAJfi9qzfnimviL5303GlbPFa780e9pAyp98c5O9V?=
 =?us-ascii?Q?W2eItFcul+H3QbJwxGwkcLfss8WqAzg1kgvE7JP7UFhDsBBO8V1cge6nr4To?=
 =?us-ascii?Q?ri18UlCDUdFuV4urDJ+yFqeNYspHGuLrcqcUsGsVLBltAaLPDMblbVZKPMDk?=
 =?us-ascii?Q?THN+x/6No0NgCf5ht6kDy5UNAA8Sylp9iosfEF8v+5iUBYWSIAiDMx1S/nTq?=
 =?us-ascii?Q?+tFL4m+TamnpF8ypUM1FXwmv0Bw6DfVAaPB6WT8NE+0Q68+xJnJFALJlZWNI?=
 =?us-ascii?Q?W+9OJuqBEeVYK7CUWVCYDBPzAJCMzDkOLvwD+gFE9ciPTM54A52xuooUbk/W?=
 =?us-ascii?Q?KmFDeoq7saCwB7wggaQhXhrmWog1XB/J1M8XCA3VDpH0uCZwN4MKD6gjblB+?=
 =?us-ascii?Q?0cV+tZalcgQTItsO8L5+nPagvMrktpXPesdZd24/y91ilDF6cfUawXr64q+o?=
 =?us-ascii?Q?zaxdjGMKWCpbMeLi8jxYfKFZ3NP2pXe85CW0WUzhVHIBEDuSrHhJKsrSme2v?=
 =?us-ascii?Q?hdD19s8PbJRlHD4PC4pPQAdJbOyHg6SWKXQRL/Q8PkWP9aC2MkCKMpyLypa3?=
 =?us-ascii?Q?PNpFNHF8oGkJEnBfoMJqzESyLLt4w8Etw8gd9UZ0UHmMtrPaUzsH2Ed6fFuN?=
 =?us-ascii?Q?S+hw/mkLYPI9f62mf/eUIFS3/eOT8byaluUydqyr00gzslfZrT/A6Ie77mt+?=
 =?us-ascii?Q?s+fPJlpvTETSd/cYmBfkC+J3GksAx0myuwi1+6PZezqDPKs2XCRr4tR+KMRm?=
 =?us-ascii?Q?O4cAkFG6AyRXXkoMEhOTTq227x5atQ5LMNX0oGwW5z2vMjJ/YBC0/aqN4Wmg?=
 =?us-ascii?Q?0MI1wdxAZ8yNRH9Yxuu12OOLzg3pTdiWhDQqSaIDTMBbg/9r3/AZX25LAUzb?=
 =?us-ascii?Q?SxFgdID3yGZCbiWk7jQyNf4UkPJE8heqRKS++7m5555nOm5aT7iraoyO7K0u?=
 =?us-ascii?Q?sTDV7HZFZsSLPpXLZtibpGO087cAhaRSDle+mWEVazRkHZiT6Z5vbVp3POUm?=
 =?us-ascii?Q?rrt6UZ0yecoya97li4WpGSuhOt/20fqCblL9rES28Y9YtkDq0KV3+0hfAOkB?=
 =?us-ascii?Q?WyKo1nrZ+0PR4TGdchw9L6LAOsYtMm1b5bt5IXBpUHZWspg7uSpdAiSm/17D?=
 =?us-ascii?Q?025drcbUPWH5LxvOGivsyjDYYPxZr5L0G9JeuY+/E0Aj+Y+6gUG9FKFdTkK9?=
 =?us-ascii?Q?dA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926ac71d-6cd7-4be9-f689-08da5f1e3592
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 07:07:37.8515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ugF0zy6gDMO6CgPapluoxw0iqmcpeT/R4fCJoIeKJ5Z+69vsc4V8ehGCFPJILthd998j6REQR8IVxlNzqwWLkkB/EynTH6Qeo1Oinx+6p8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5228
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04.07.22 10:44, Christoph Hellwig wrote:=0A=
> The parity raid write/recover functionality is currently now very well   =
                                                   not? ~^=0A=
=0A=
For the rest of the patch, I don't know the raid56 code enough to feel qual=
ified=0A=
for reviewing it.=0A=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9718552A5D8
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 17:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349781AbiEQPSo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 11:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349759AbiEQPSn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 11:18:43 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E88927FCF
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 08:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652800723; x=1684336723;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=V3vm6tc/AsZ7pqXXTtON7m2AG6djxV0MWHAujOmmzrP3+ysVyEYQ66rc
   8JK4wq3Erwt9m76mp1yjz3EJQlHJVzJIwkhh/4V+pyrqdDZUa0jvgHFQC
   OqrHBRVa/CrLr6SH/xoMAUwWjfTVDnKxXMQnLcVOjK4H65y0yLHhGLR0R
   iDaMBM7HDWnWoJlqPEnDg/1bWaRftgv1dkBnnpyBJpIGcZDjhM186MKxh
   l3kjj667p5YdgBxcqWPSJxvwZjQPQ7cDBXG8ybxoDvrYFtBNskwifIwP4
   CyCjauGJuFkaPbMcJ7wgeqmuZS3PRPO1Wj0qvicXYIgrJMR+0eCde/9KA
   A==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647273600"; 
   d="scan'208";a="201428264"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 23:18:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEgruIFFaaXUxzEOQGE9nUeEAVN9Ij8u6D73a6tDpon64RAVUoMTs8g0K7Svpk8/pmkk4+H5hA1pm2Kv1OjkmkzIeG6ttSDCT8FiQREN6J5Pyrc/UhC+76OQHeQeQIAjTBzKOas9mqtrT00xSQhy8oSUUikACU/7k95Vh1dchWVzs72v15cbwA8eUz5+vg3GQ1gZyfSZuYZMgmmRDOFWcgYAiLKxE8DaICPE+orf6VVaGtcGrmygiYLAWI8IP9tpus1miSpJdyEUPgTI/XJKmSDzzuSbdl23yvrZnyIvUu1blQAB9K63I1hPg26S/DTP2G/Ax+VrrhgenX4ZyPeaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=SExa4AVEisRd9/5RxEe6L4q58bMAyfw3KJ2jusme1IeE9aATUxXvg9Z0FETBfUGa8ZUyn8MSoV7OGSx0wh9bH/OyS1yVsu+k4OJ+yTredol1WRKmohJRHV4JcFMEnfrmoHVPbmilIZI5LHCf2BqyYulmsUAjqMTHdcoisAzeTDSLJejpnrt/7SZBkRXBTqvHR7NBgJRnOchoe99wRF/ueCS0e44hqzLj0n0rWPlW0SWNrNGc5OrOxnGSWpLEdWYZU5TDmWg5kUR4nHakKci4CcbOsFvPvsxB8RhmODtvcgjRlLyuzib7zJlM2Xt02144yXbYsccRaLt+ZycN16Koaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CWW5oiNThez91gGWzXPBeCJ8NnejokgHVm+quTlRVIfAHZAwE3kCaBSfiKTdUB/YaJ1NQ3rfVm2PU9OZzMElo/tNulJMdAjYrKbwNc8WbX3tr6ZL9OuoJYWx3pMXZIcnwvzZNw9jsNB+Vd0BzliErNMuh97VutW3znCUjFfc13s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8402.namprd04.prod.outlook.com (2603:10b6:510:f1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 17 May
 2022 15:18:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 15:18:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/15] btrfs: make repair_io_failure available outside of
 extent_io.c
Thread-Topic: [PATCH 06/15] btrfs: make repair_io_failure available outside of
 extent_io.c
Thread-Index: AQHYaf2f7X8GLdzJK0uLxgJecUXVZQ==
Date:   Tue, 17 May 2022 15:18:39 +0000
Message-ID: <PH0PR04MB7416A631B3CA56E94B3099D99BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220517145039.3202184-1-hch@lst.de>
 <20220517145039.3202184-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7303bf4-90ab-4bef-0bca-08da3818854e
x-ms-traffictypediagnostic: PH0PR04MB8402:EE_
x-microsoft-antispam-prvs: <PH0PR04MB8402F1DE91F2D6377E3BB9669BCE9@PH0PR04MB8402.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wDNNmPlxM3lH/K6UQy5Dp+wpPZN926EGsH7fTHzjs7/USfGpeM+lV9Th/mWUp6yAUOjRK9jaYCPULW9k5e0SYHFrGvKGxuN/gSgZOW04hfCwsMUmi2yruf1+3W8T0O9Xwjz0/hSCx18SzQ91X2MWUzXitJQxf0i21n0NzYU2q288zs6BKUmsOld+f9ypD3Buz7RpqKm3x4R44JUjzyR4iNmpMmMzo4hYK8C96gKrn6F3ZiiA3iEpBC/7xNdCEp3ZJm/B/K52iMs+m8bUEUcGkMtGs3QgkQwKeyqOJAFrya3QQYy5yyQ/Fu+mSqVWDUda5VVG7o2HXsspffr84E/By8u+Iqr8eAMVtyZ2XpH5KbF7CULFkagddUKMsdQ2BtfrHH6VzGjMr9WiYNkrYrCBcgYF6kzyem/IUS1eFkN/XgrWnD4Z9w6XiKSm8tspunljttvwqE1xLE/vUJwkzbij079VXxAwXTWi3DrAkfl5WTx8uIuuvqYwF3jdUOb2SkSdze5ipF0BN0PBrNV1j0fbtb4774hhkdgWg6EJQ6HkDe3T5kEBCkEkYxFPb7M1Zpg6Qs2FzRI4Bk1CNacrnFbvrUCFqh/tjoa+KJVbcv31ODFf4/9ZY/abiF9OF9VTMLoRydKulJxQOX4HjsTkEzggTzSj9DhXhthe5k6hFOHie/BbWcIMr+0DcmkZNoGbUnKNWB8262KkdqjVj686Y00rIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(38070700005)(86362001)(54906003)(186003)(82960400001)(66446008)(66556008)(66476007)(508600001)(122000001)(5660300002)(55016003)(558084003)(4270600006)(66946007)(52536014)(7696005)(8936002)(110136005)(71200400001)(6506007)(64756008)(316002)(19618925003)(38100700002)(76116006)(33656002)(4326008)(91956017)(9686003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3Wrc9a0XJ0fIFS+50BGEj7LjTUclymA+wgslSOEfO3hQyUo7U7ghcYgd8KTp?=
 =?us-ascii?Q?JkJDDrNgZBXlc5bokK9SsmkCOMLlk8H6x319ubV+gh+9DImfuUCWrqhUO7OO?=
 =?us-ascii?Q?B3oJlDsccbdg7rcrRwfc9LT/6wdDdwe++RPuZ+BlLl2eQGKq1YJXw2cTeZNL?=
 =?us-ascii?Q?RZdU9PLczfkyBn7pGET3DtHOIA+wTkGHcikKpVo5btkyYXZAqgqk/3YKr7Ou?=
 =?us-ascii?Q?ZaWBuxP6oHSvB4RiBJb4obJ3OEsD52phqxD95RAOo0G2NhwjDE+Nj3E64F0C?=
 =?us-ascii?Q?XjOLy7GvUBRUhIT+T+upabNGh3TudPkmyK3pOqbYKGpsndhA2N5Wrd4ywjG/?=
 =?us-ascii?Q?Jh+a53lUEmGwqSmtTHpvAQf+XjXtSUiFbTLJx/943XO/2FUwASAfN/06Hwn+?=
 =?us-ascii?Q?17PIoWIuiIghY4+KarZSLF38BX5SSWEkWuY/nTdetiwsPmLDNK3h12szyl2/?=
 =?us-ascii?Q?ab563DbP13GukWHC2yjVZJOuyRfbkoyYV/qJ1bvYD9x4OxYFXZDPSeNvbJ1A?=
 =?us-ascii?Q?MfQ8TskadtNwWldac14kWPOf5nh8UoqmSKjVsezldnsOOf/aFezZXvD1JH+S?=
 =?us-ascii?Q?acZMyTki+Z58yzbzfDlCMrusEgW9JdH0olESvBkjO2k2wbxsS0eQT5Qp0ipJ?=
 =?us-ascii?Q?j7WUk0RvutCkwGxwxbH68KwuTQyRfvIku83MWJxr0ko3e3noLE4rR697DPOx?=
 =?us-ascii?Q?GGCfHy86MNrA8j6ctdWycTgTnZdvndoNIAXVI6gsDlXYwJqEGBu0CY3ImRfq?=
 =?us-ascii?Q?QbtAyLup8xIgg78EvsH+Rx65+V6NG1B63Q7BjrayC73gDyDPUVAhIFXJT2RM?=
 =?us-ascii?Q?Y/W/e/1ROoe8tTE2Tp8BV4e/4F5ZNGkfKDTu4gL6hJM5PGVhZdwv8kCrrmHn?=
 =?us-ascii?Q?oGNYNU/nZg+TKx+yfwlnjC6OMW5uxMGdDfQGYVx1UtPb8Bnj68WA5D+lXGYf?=
 =?us-ascii?Q?st3z27fM1BTlRDs2yw7/xBXFA76hJ1IRCv1TynU9dRIZ0aY61uejy9bwi5VY?=
 =?us-ascii?Q?RRegh8c5qCQ5sufU/8hN92+P/7HEy+acU3JY5RIa4Nvke7PFSYeLgtJRz/Fs?=
 =?us-ascii?Q?KD7pso1VzX8LrlI6J7GWehNr3+XqFu8RUoMG+8vC8KwJ3W0izvWr1aQUFEzp?=
 =?us-ascii?Q?HNSqHObYLx//qhUorwXvAoMjfTiI0zIt2Ajyi4UZawZ+AYgbnfAIQfg6yrcF?=
 =?us-ascii?Q?K4LVUitZutplXyApN0jowXhmgG2Op5RlcTtse6FTOwpIHZOtNVafd4Zricgw?=
 =?us-ascii?Q?Zawz+lc0Xpn34uJS31l3gXF4avB7dxHpBonpFJjCUjihdbJaIKKX2vlJceu2?=
 =?us-ascii?Q?rQlb/BDpMxNizESX2XHoWTF4spi+Db24GadNECVFO40sM9ojfGA+pH8++K7V?=
 =?us-ascii?Q?yc8ReDrkCQ8T7SQnB6lML6iC8wO//n8f3+LBBywTmiqzDck9rzZf+J7QC2U6?=
 =?us-ascii?Q?QoIe/4zDd8+7//xyzWOH0L/aM6AF/d+M8E9DuGzdbLXgkCfrw8oFXCl3Ivo2?=
 =?us-ascii?Q?ZWJhKJ8Oirx/7hWaqz38FFea4d012h0KuZy0/QKPo5IZQoqZfvxgk6b09wHl?=
 =?us-ascii?Q?VvSYxAmbaHC+MCwrX5BGPmxzID36yhf/zkSdlpRXvPpdBwz9TzUobq8lIPLd?=
 =?us-ascii?Q?vTiXsFn4kokR2eMvDmz7s3nQDvyNa3EVornGquTE7nLxOqoGPbFvk/mNkvcW?=
 =?us-ascii?Q?G6ireidtwJzptYQqyCeJlBS+SEW1EmxmE9fQL6vuT0j1rbsezwsr/W+vtrFf?=
 =?us-ascii?Q?ICMM5xMdrQoyiGrvGmv3ZQSygXlRZ2q8hdkv9FQnz5Rfj8pqHN17H8PMTHzx?=
x-ms-exchange-antispam-messagedata-1: 3jKq2ZCNwdtNS/D2JTWx3vrDWRPAYn41IVFz4XB0L9rnHNC8eD8d/cdt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7303bf4-90ab-4bef-0bca-08da3818854e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 15:18:39.2732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FcLGy6xsCCRGJDCN7/K5OYVSKf+nV9FljUsdvgTRFNI6B1wNlmvAyUTXG+0WIjLcJxNua+BL8wL8i+d8y6lCCmZfjtQK/g45TWyOejRKTzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8402
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

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62461C77C9
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 May 2020 19:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgEFRZB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 13:25:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53611 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgEFRZA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 May 2020 13:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588785915; x=1620321915;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Qcj5yX1cSUjuXyKRlZRB/0nKmk/ZHYNmZbXB2QYpeVw=;
  b=RQdEkn5w3LDREAPQ5Fx8mHVouVIOURMgkAJWGl6fG9SUOtI1OSMwzTcu
   +UJD9qVYxeWkPptfO6RugQmEudxupwsywzvkEi5gKFSQISE6gskgUK8RG
   83KdcDsWdTUCsbzIzdfqMoeQWsKTwOAwOX8rPAWHUFY9Df7ggd6iA7Hdf
   bBMKqiCPQ9/3F+xT7n6u31qDuaxQX82bSt05u/DjrBijvVmKuhbZkk7Tu
   oufD5GB+NQOayD6Dpqe5je6COA00VOXEr0FHw/MCWPOkNdyoOGn8p/wZo
   IX1DIk0cGm+2u7WUEvuzCbT7cq68vTyIauUwcg5Pio9a3Hbxu8yrHiZ7u
   g==;
IronPort-SDR: MXIcEUALob7nmM/O/n0yMMYMSgCaeQu/HuooY1vY542h8D1bftClZO6nToWoARCwfY5+qp7Om0
 /0yDYdUDEIJVcnw261ku7TkQXrVuxD4cA+HbukMtKKfyLCNSvqITBJ608qCejz6MNPFOVe3ov1
 yXLjQi39IowV0ABGDXKY4XOdjXiOv89b+R7gcwzCtlGCFrbCx7eL7Mkc0bd7d5YNnZA9Uo/B+d
 sLxQaAem3D6cCS+tsu+kN5N4jejke7l3I1lz3BEbSjODonLN4A55iuFNqng/oxy/yhYubU5lCE
 9JE=
X-IronPort-AV: E=Sophos;i="5.73,360,1583164800"; 
   d="scan'208";a="239692664"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 07 May 2020 01:25:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPyFvTwhRJAStorrFQThvr5xlF3n2yRr8whTMlLRLfdDDk+HcNmKOrmEUuKVOKZ07CyLhmR01dY48gqKbTocueWigwvvx11fS+y9mhzeeQNpVd6/S54CW5gJpcV/5e82FXrcjVJK93Q+MGkxCvlH/iaTIrc409meIHDT3dlbrXjEVqRD4nY6LqZSqkyaNmMop/u8Wnv2PVE9O8TCDMOKXKtwQDLDTLqnDj0n7jHrtGYFTxYiXtHVxAidhGTP6elyoQTaKI2TvgRk+EH4d70hzgKTOWNKqsaqepngBBXopGUzEraUemo7CV0NGmoXLcgKWICEsIZhxkx9kmCNRs+9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qcj5yX1cSUjuXyKRlZRB/0nKmk/ZHYNmZbXB2QYpeVw=;
 b=byQ8NLB3SHCpahHxFiVsdhtfttPv5K83CZXo1WgY94RXoZJp1pGg3u4LQ4OxbQEK7mbrNyGu3b8aHRMgkBwnyMAeVWP9uEAFPM8y4P7HhIs1o1U5FD83vVHD84j382HSFRulSvh7nNv+5yc098l9FMp1niLaM3DXJD2zuNYod4Cnb0T2eJKDNIsfreFIpMKExX5EKE3Lp/g3WpbSc2hpA9kuDPAdkqTo5d5rElCZUZ8bnNW5u+ydjQUw1WeR/n4HovEq6qDPIl3kGg52GM7nXGEqj8qKC2Y5C+gQ3OChKFcfI5ubDhU3ybX1nSjyi3Efop1f5fMp/9ILSRLF7J1gNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qcj5yX1cSUjuXyKRlZRB/0nKmk/ZHYNmZbXB2QYpeVw=;
 b=SDb/apizDijRyOYswq14rXKxD/e6T8K4A86YJzR7G+DOvS9oz27UH2G7R8DxUrIT5EjGf7VbnIpWiB7F0RmAyzLGCnrE4YakbOynKYDXNTTFO4rzj07eBH/lJAMVqlyf59VtF0SUHvXrdZQbXi2VdiS/OJHlmL8DprFBYFMepKk=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM5PR0401MB3528.namprd04.prod.outlook.com (2603:10b6:4:76::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 6 May
 2020 17:24:59 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::3c00:be66:e289:10f7]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::3c00:be66:e289:10f7%7]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 17:24:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 01/11] btrfs-progs: check/lowmem: Lookup block group
 item in a seperate function
Thread-Topic: [PATCH v4 01/11] btrfs-progs: check/lowmem: Lookup block group
 item in a seperate function
Thread-Index: AQHWInB+QG/pF9M4V0+Aajb8JshFiQ==
Date:   Wed, 6 May 2020 17:24:58 +0000
Message-ID: <DM5PR0401MB35919BB2506B1D57A9114F649BA40@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200505000230.4454-1-wqu@suse.com>
 <20200505000230.4454-2-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e269a9aa-27dd-41b6-f8ac-08d7f1e26707
x-ms-traffictypediagnostic: DM5PR0401MB3528:
x-microsoft-antispam-prvs: <DM5PR0401MB3528B95CCD20E5A9A149FA279BA40@DM5PR0401MB3528.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03950F25EC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(33430700001)(66446008)(64756008)(66556008)(66476007)(33656002)(66946007)(5660300002)(9686003)(55016002)(316002)(8936002)(478600001)(76116006)(91956017)(186003)(8676002)(2906002)(26005)(19618925003)(4270600006)(33440700001)(558084003)(71200400001)(86362001)(52536014)(110136005)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CRwbmdEijloWA2AZcHvViGDMHxKGYhyGC0S5NWPMO2z7s8OoLPFXZQdzGtbfoiFUmDoJevvxu4M//d9yAsJrQ2+6/glJa5qgCzdhbtacy0x6Xgu5lgg1LxgZ53TVMWNJBq9ji5vecBoqNeoII3AiX9JVPt9zloGrPmLr9DulV6lw2jJoegY4/Inq9kCKQngd0qoekxobB/QEndEbHEyx/Jac6W/Z/Fie9RE4cMt3HXLYJjNGQ4k9hlPDxCoKwXJPa/CB9A+GuOS7od94mSKA6aEl9x+yknoyjIjGSZfFvz/yx7DrWMmNOE6GUuIlF1HRSoe8to9kX1sFwgEU8ypVh7i5kHG6W/ezruTkg0bTbLNAMF+rL3HiZTkZdO1SJZ/Iv5FHXCIP7FGbv22l27QWf1mwVLGy7ubraKu8uBXOjizYpXHZ4cMuaNdUWFygd8Y6CvZNqT/We59JOexJNqcn0Hw4JoKXWn9KKlHdFYbW64CKiecVGGbcY+BjKH7V9S0EUFbk09K+n2ytYWaAxdA48w==
x-ms-exchange-antispam-messagedata: dK0/yXaiJpTip/ctR3kLIvNrdC3IFR+57uArn6MI6lHgB4Vaq26ioinrC1LPGCTFnUz4GACYrJwhXyyluD/zo1G5V+dBvMOWDUEFhvlL+VFKnrHayy8icI2TMGW3CHw59huRq89XmotozEJLWET/gDHd+XjX5uyI07/X1ik0G52DEtoWFfftpx2pmggq/xwuTQMNCzjm5xJS8qiB6jeI7rJpxhbKXmsYrP49SJcvNev7BJAmk9kt2iXkyqDls7p9eGpY6dE98krUiw/KzFxdRIQVcx1yhkliO13zVrF0HNCkXjrkXVFHrgN1HDwbuKy6zUvfZW8iMkHT7uBV7oJZLLu939RTtNIjBGitTV/brYTnLmv6BLGD50YmuiXqCs4l4lgkHoX/OZ7oi5gXntg+kVFRHVw4rc/JB5nZ7PWH3ynN7vawllljYjBDcLl6wMfsE1J0ueRIzYOrNc16IBMI/T2w/gh57e+k0FL+199+8BKnwHnIQafmR1jrYQz25SPDsMQgI8lNJzloOJB0F7rkO5XajKC6qsDh6JZpNdgIUoCtnaZ10TWWlTEtr7HRdZnQs+P8owrGlq+fnY3vnPqNe2KKQce+qqucuc8Or560RwloH6DOfqdYohurziINJC+5SI8ZQW7KMnJT+9RlfjJ9DL+K/aEdjB4IVSCSV3l1GbCMl+hwuMpZBfkhboxclPb9ycSCUzMNSSO/GNdgeukKXI1jQ/VKjW729nHDCYlGduTkh1exRwaSxkkJb6TfpVuxqF1rWpYi2bJZf6b3JKKp+slbCfJe3RBJ9ctfvCsMDQ8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e269a9aa-27dd-41b6-f8ac-08d7f1e26707
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 17:24:58.8193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /A2KlZPsLV7L3Qez9W77i5UhOYMeX8KpTtZgr1D9/DFz404SOoTj+VIGaK2qhG/tpqrypeXE7XV0lu0gm8XIKrSkjxXvuQ6t34T5REbjALo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3528
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks reasonable,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

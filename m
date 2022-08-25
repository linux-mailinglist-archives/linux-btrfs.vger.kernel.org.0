Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC6B5A0B2C
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Aug 2022 10:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239333AbiHYITB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Aug 2022 04:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbiHYITA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Aug 2022 04:19:00 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBBDA5705
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Aug 2022 01:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661415539; x=1692951539;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=EW+ONLgnatnGRBiRazSRs2LSNGZTDfTi+00jdN4JoaD8OsJ6R+2QFCET
   2Q3+OQ6f6plA/fDCDTxLPSh3k1ze7sd5/Yv0XvQXMU7cJ/xRImX/O43Sb
   5GuAenEL3xGbVepqfsQ7hXxoCwQpPVcyKbcn3Syc1T11Ty+MO5UrecNNy
   PmzkLgfEWDuZ0gmBQvkqOCfLo7nXhaEP/eKRmLv9LQiLmL/fxEmYxJZh3
   tPzGRmruI/fsJTgTvXixOutCJEgDHYqHs8Hg6mlMyRpvTEAyUbxmszbi1
   vAr0bnsWuhEZwFhQsAJ7Zg348A/a6ptdZZpXF2/lKZLHp/KwebBkk/ZkV
   g==;
X-IronPort-AV: E=Sophos;i="5.93,262,1654531200"; 
   d="scan'208";a="321721237"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2022 16:18:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DL5xTW/wEphdmk8wRlaoR9NUdeq4bdrdpzhC6ztL9jIeQqLF/03BGjwk5tR654ggaYKo++7+ry+8JVgLoXzH3sjZI/GZ3XcirfcU/Q42pxi+OgYr0As4EeFzy86k5hRr9AfaSt6uk2zSIYZwyy2utHiEXzVpPyU07xtgrozKT8WigAMWwdT2EyOQLUtRQpwBBqNgS0NXSmW/vK6J3pdkEk97EGaaJ81e8bN95j1cy0Q2JFyqcfT9uFGud9gos5Zzb+jo+DLfRVGirhlrgnTQRlnbJSMgt5KoY1A5Z4QvYd8QNovvVtliOsEppz6WIyxvXWA18GzrQp8C2knPpygeeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IroA5WmMIwp9jFNjSI5+l7OEH34258OCcvMdRNubM4mgVT2WimkZMY7AS/o9pi5ixM1YKewnCYbIgxkP2lYGlo2+dnyiFAp2QbhJOFdC0Bq/ldFCDTdlLcejKszgUYdatBTvatYyd2hwE/O9iQHmacmdNArMmHQz9W96xuwyai/I6MsjuRi4JQeoXsmKPQMBtDPHiz5DzgQYJekjX+DvKXy1mJ1hhQpCXb/B7/hyGOq9IQvDlfKKOCszohS077jd4kEyCYdczr0kbWiznS3HgQA9rv5Wrzk1Yp54Dc3JRbpwGALABwuXZZfha2XU8BHtXLFpckk5GGVwLMRx9RmpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=pnt5ALotEFZsgzpElZE9z7o5KR+v8dkzCLFeoJ/08tQh0wp5ML71gyvu2PeLKR3S/xl9h2R6HW2UCM3D6/7nGkJTjodmV7OnuMZl2Yz4j35eR8IpPXIA5v57HEA3yuaI29Lkmd8B6UBV19/KEeIrWNjCQYEo+6mvdj6iseF4Qmg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM5PR04MB0317.namprd04.prod.outlook.com (2603:10b6:3:76::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Thu, 25 Aug
 2022 08:18:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%6]) with mapi id 15.20.5546.023; Thu, 25 Aug 2022
 08:18:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] btrfs: dump all space infos if we abort
 transaction due to ENOSPC
Thread-Topic: [PATCH v3 2/2] btrfs: dump all space infos if we abort
 transaction due to ENOSPC
Thread-Index: AQHYuFGmCCYkUZskx0GxiGX8D91F0w==
Date:   Thu, 25 Aug 2022 08:18:57 +0000
Message-ID: <PH0PR04MB7416F993C430128D26AE42539B729@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1661410915.git.wqu@suse.com>
 <81564013f3f6a7997f9e2ca13f2a42431c0a55eb.1661410915.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddc0a256-8678-4d5e-ebd3-08da867274e2
x-ms-traffictypediagnostic: DM5PR04MB0317:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xeYmxOmBOFjokz7FXuE6taJkDPKlwE1/ObABNvrzGOECRTjfwQVszC3+Al7jaCrDfDpJtzy/hzB6F37G9/ywDSWRESGrTnTUEGEHqTx+GfpCHubUhZ59vaCJzv2Zb35duvbPjGI0asHpo2IJ7JHLch21CtXo1GD0TpvnU0GAZyFOXzdiQrycmIc3alkUXtuZigCRDugMZF7batzROXTBM3NtcefewzBjm7gPCchYJ+COXNdKA2LBxs4/popRX+deyV3v19l/qpd58HxWoq8oUpAG/6vYP9OsFiIw0UJqlhnmn95zffnAXOusX8YeZ+zsGqgfV/yhPkcTAueYSLJDRK4LahsXGWxpsWmnRL9QFAc03VYHSiffmNHw1VVOnVnsq6EGkrHVtUuJZjFAluly3gYa3gayL1piTxmAUwQzA8XsKs0npXHyC2Mg3qEJDx6vdq6MwnC5OzYV5E/J2e8/y+8HRpVSeuSzz7yY5OIbdP4brBuZUVAnRZtBqqwrEEN90qCQ8LqosDefcGlde4tg0C2GtxHbMxq1xaeDPHiZVL7d1D/D0n+Yr0oK7Eb+QE5mfSd7MiBXl39TTETZhZbnXo5wz+kfzwvkIx6LYSkgg9VH4XleQwR9811ZmVNBW0P3ELcigZUIU8xq7+42iVMhr67tU3uPjbArIWCcRK6zuZ4GHBW766iWhGIdbZ9khe3CMpfMK0YZpqaqjh0v0AXg08+0L7+4AhPBWksKq0gpMUqKpSP7HnEfLrQZs5P7wnMhZjANZzD2ybHG2nrWbJKffA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(66446008)(558084003)(76116006)(122000001)(86362001)(38100700002)(64756008)(33656002)(66946007)(91956017)(8676002)(66476007)(38070700005)(66556008)(82960400001)(110136005)(71200400001)(26005)(186003)(4270600006)(9686003)(41300700001)(6506007)(478600001)(7696005)(55016003)(5660300002)(316002)(2906002)(8936002)(52536014)(19618925003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3qwMgc4rkUPvsZqXQkziJwvG15VxXZfwVNr72DITRJO1Zg5vE8PdfFvSnmSp?=
 =?us-ascii?Q?6dBKdsCMzNcOKXstCFyh7+A80Xhmmey09brArObGAkllJHVRkhZe7woNNXsl?=
 =?us-ascii?Q?fZO5Iq5KusEJeJfjIfXjUUOvBqXUJU9pwGqq+vBmEe6lyzi+uOndMCz3eVQe?=
 =?us-ascii?Q?VCkLlTjZy1GMR9rNobi46jf23jwyEDEk75HlBk48FaYLcCHnwwBqYJkeueLD?=
 =?us-ascii?Q?qsrwQKpaeHwSJU4hsuMATBTvCiZ4u4/k9xa88Z8f+c6E9a9h7rFK4q/hHhVl?=
 =?us-ascii?Q?FytmIH2xmCaaRpxM6Sj++BVHobZkOOakBn9AjVYTDSXTYxR4AVj66vc/K+3Y?=
 =?us-ascii?Q?AjUDyVLoItg0yqSSFu0v2/PPBVQy+2Lxk3BbEx6oWO+bh5u4kR2Bv91Fh20x?=
 =?us-ascii?Q?3Y7jnCNglpCFCIqXYsOmo5Ztnsxn5T+d6RMERemvKUZueNFytWAhqRG+ZL+J?=
 =?us-ascii?Q?fQESRNFdkQhxo01UQvS9Czw+27HwWmS5I93bRUSyPqxRCdzTYi/XaBDIqUb7?=
 =?us-ascii?Q?eZo/rMBQOQTfIGvveLXRZbjlQS4OMNtnrN9RKF9BJldy4gArKXmIKZgotknD?=
 =?us-ascii?Q?CywcIqZbg/3dbrUl1rEzOdA1A+muWI6ATp0Xg475NFnqkSX5fWz4TjtTX8g+?=
 =?us-ascii?Q?gfK4PcL/6QVNUE4bPzJw82xLV3SZHzpsGmWALgzviQjdtLWBKDPF5JfESeEu?=
 =?us-ascii?Q?k4yuUmOg2hfE0B7D/E9XgcFf0dLTPQ2vvSUYlccBs1s2N87EEGMkrMwlLQcH?=
 =?us-ascii?Q?gpr13rS50W0cRW1naXPX29VSMXfjlROgu+fCH1g4REOA1+HCv0sPGfygYMEb?=
 =?us-ascii?Q?SZXNUsFxYyIRcD1hYivkgJsIzF7Kec+jPtUUx4tmR+ft6KL/W6BlCJJfApIr?=
 =?us-ascii?Q?aD4mSLRQ+T75HnZEEXDwMW48yVTgRmSWa40+HiQEamaGSQ1CrcF35yWjpejt?=
 =?us-ascii?Q?d6MYwn6qartzfi4xxk1E0BAMEYmJAtRqvsapTcGwpkgUcuQ2pWYRnvRq3Dc1?=
 =?us-ascii?Q?EiTxqfO7YsFJp8h+exx65kUVF0+kgA4swRYsptmQYWnJ9NE0rIxNRVEsWKRZ?=
 =?us-ascii?Q?Xm4lz6u0KjsDtSad8Sxnwf/WC+n2rnnwcTQAHZCs4EKzsjZY6eu2BRJ6kwJV?=
 =?us-ascii?Q?8I36NIgebLsatnbKewcNV79D1rjgZJD6aK0kjUlPFT+UdQEhXNSwziVJMZB3?=
 =?us-ascii?Q?APwseJ30U7efConUZrniOpURNf8GM3bRZdykEC/1lQaetaR2n09zter88zDx?=
 =?us-ascii?Q?eCGhKforpO5QxxwCOpf9AF9c+7LBxBsuSnnQhsC2FRhzOejeL9HajhDvYgqN?=
 =?us-ascii?Q?MVISv+VtrMgKPYrlGx1dG1KWSEMkvKGrq+JvgUNd6QlqOqt8RRd7gAXXWilZ?=
 =?us-ascii?Q?Yw6PrU+xC7oE1O0S/YPfyYlhsL6rsqdKaVnpLqcBL8qLBW/98r7r1zdTvt4R?=
 =?us-ascii?Q?CEv3/s2Da4yHdD7ghMqLYX6eemjL713bcT/v2iwpVHa1GYW1tHmUFoxVLBQ/?=
 =?us-ascii?Q?LMGa7+zL7e+8vDnURQaUB3ELHIIE78imueydsuwogUJrgwXpBjsZFtLtmehV?=
 =?us-ascii?Q?fdAZvR/resZVSHbxT7PZerpBXUYQW0P7C5+BmYnb8UKoz1aZy/WjCxfc5fKk?=
 =?us-ascii?Q?cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc0a256-8678-4d5e-ebd3-08da867274e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 08:18:57.1299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mN2NqfH3WCcJWL5lfSPU3GXUQ/nRTHEaBbkVAqVOq17d6p0Nd2mQCNPCrWC9pLHudEnEA+5nRGNNBkmzPdUIJ0nBenhwcxLEVi4fceoJS9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0317
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

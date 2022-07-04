Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECD1565729
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 15:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiGDNat (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 09:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbiGDNaS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 09:30:18 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4791EA
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656941073; x=1688477073;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=O+yuNNfvA5hcgGLp/qYC7C3z5zWzTFr57ZHIb5h71Vo=;
  b=D9cjBfeBIwayCWRXRDerirzbtVbY78u3umuDUcrJqsCxHlNYwK5n3sq3
   yYCuIcFE3/lyWmtOkL4UBd2mpQPeYEjcNpQWkKLJoBXjbLjEcxAH6+hOu
   ySiZj5nsd11VxkFjjirCDIOedssxmHRv1nDlITj1YffVIAL/Wn7GPlMWU
   lBcTEUZEW9JVXN6SR+Hq/JlqvGprQLXqmjPDwvOqj5sVRfwbWNTL/PHps
   jQdp/se+Hk4zmTfftLPiwMmhtjxa5NpYxvKULnkJbTJEMmn2VyKqKv48h
   y+PePdOn3yriNtsbXJk9y7xxzxyCOzNHPkhS11D3SdQ+5+i7TSmOcJZkJ
   g==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="209660884"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 21:24:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGQ07mVrWplR+p2+U8p+dpQKkaFXUn8QtLJcGKpQLgxQxW6eDAMsEI0lp4mdWlZ3taxNilXAfbS3y83lBoU1KqnYRPEuirGOn4c70U/25z6Oh66whc3XZGl/QF28q6bidJkDHkRpX7uSHqT0cbeHhZEbOU4N+dsyozBJh8gE2jqALT8Q9rlIerCMRj27a73j8xlK+vtAzeWljSayD2OqJ0iLlAcGS03/nFGZjgf00c/sKpGEunVZ4kJukjiShamiCgNfVUAW31jiE1ZjlpOFDiomo02vJHDQc2pyhSILyKSDENYaa4ZAgoJn7OjflHdJzgz74z9BRRSBXQ0nPqv1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vQN2wLIdKpDOYbnatDcFPOncTQq0KyViqH11CjaJAI=;
 b=FvA/NjtyQa2KL3hfnSPeK8MCEisHpTQ/wq/sJ45GR//oenLJ7uPBZkYNGAFuAIa3AQouTO4w8yM/EWJ4pmkZGW0t21t0FQ8EXCjquWLrgNWR7AEMb6Vi5zyV1I4e9TByVwzFHO9/xC6xbOWpBXQVawqHFC2wne+9Uf7IEtC4dUSi1EU9a0Cvc8nFE6wdVhdZrV6xohOZ9tSSqIYazycL0zgyoIq5PU7aQTf++z4XjIwyqRP5KG49ARmB7nVtz9ZKuDLq7xv8sRP5xtTUnjoOcKmiegVuPe32mrhF1Rw//MHtCk/pyjg4A44cfX079yDNjzTpd8FSoGZpH3LE5kmjeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vQN2wLIdKpDOYbnatDcFPOncTQq0KyViqH11CjaJAI=;
 b=Ccoyu2uMk37wpLLZXaPUOzkLXSS9br75tJqWEqm6hDSUbjkIx2t0LPnssIGmU7cKOnzzK7STzMfGTWkCxdf8+vvpb8jgXRlfEGbWz1dR24pqqo2JpmqQo8mDi+KRsmQeEJj7bAcrNMpGMc0FJccbiWQw4ISCr03r2L8oVgRhdLg=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH2PR04MB6492.namprd04.prod.outlook.com (2603:10b6:610:6e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Mon, 4 Jul
 2022 13:24:25 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9865:ab44:68b:5d5e]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::9865:ab44:68b:5d5e%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 13:24:25 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/13] btrfs: zoned: revive max_zone_append_bytes
Thread-Topic: [PATCH 02/13] btrfs: zoned: revive max_zone_append_bytes
Thread-Index: AQHYj2LAS1r2U+g+C06tvnLQGOBNma1uGu4AgAAZDQA=
Date:   Mon, 4 Jul 2022 13:24:25 +0000
Message-ID: <20220704131026.xwcswo6n5pewzjjf@naota-xeon>
References: <cover.1656909695.git.naohiro.aota@wdc.com>
 <687ec8ab8c61a9972d6936cdf189dc5756299051.1656909695.git.naohiro.aota@wdc.com>
 <SA0PR04MB7418687C061CAD8104CDE8BF9BBE9@SA0PR04MB7418.namprd04.prod.outlook.com>
 <YsLVBP/a3B50sl3t@infradead.org>
In-Reply-To: <YsLVBP/a3B50sl3t@infradead.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9741dcd0-1d3e-48ba-459c-08da5dc083bd
x-ms-traffictypediagnostic: CH2PR04MB6492:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KFMDUGm4U6/lilg8KdMZ9EcaKrMYH2xnO5rZrhy0OukvcUyDab7JADvgCNZE6pWU5m/n0FeAuea0YcIOZ2M0QBQHDRffQ3KVTmgG361BvV5lGh8VlAja0yXNqqW/IRUVWL1kAnzlFAObtsGeLeksIx4sMfH3Yw82+b3ICO1+aN78tw3bEvUrbyLCXDJs5/3uJuvd5OgKSru7gpwbO/+5RhlPhSozX8vBW3GJy1P3ihTohjUF1pAaEEioUDDkNIGe1lpMcIxQGmcK/o4KVGjZ3mjWjAVjLHqynwgNmgxz673z4BT/duXOjAg5Td+SV0/+T8VItykS1Vx1ZebBsaQdOwo5Kkr8WyBhmIojpiuM0TFekVyjm8/dgoB4sw7BKUHsrmpOdQ5TUlO+Qv9EJ50zvohF0IbXMVUqrwkb+t7T/aXZby+9Xbvf8/DNZ/oYVOSuqPvBNDkatLew7EcWtYgVQEbOdh/4xzlRj/4z23yaR+y68hT2dafnxks0tqNNXLn9fNxvW+iCoIXcAo+G7OHkSTgT2tXLjmjUsM8KGbYqUC8kk3nedgq7rK4i/gSfuugOAneUDcXS1+ukxsSo6//0VKjJ/Va+xHcmPqzJc+tLtV/EWg/80waly4+Ag//OunNLG3TO6OLnF65EMxl16+jkqFIg/SbyevozN+hYPZB1HU2cnXO9rv5koHtLyZrcqS0w5qNv41SAjDyRvFSHZ2ZaBKDDyU++dXCuqGFQ99faCt9N+o9kujJSRIvRWiwB8TzYyXl+E4qA90YNmAepJ+ssIE6tu1sfKszqzlsRlgC611NjIoYMKXG+QI39RFP8j4ab
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(2906002)(66476007)(316002)(41300700001)(6486002)(5660300002)(8936002)(478600001)(1076003)(91956017)(64756008)(66556008)(76116006)(66446008)(66946007)(86362001)(4326008)(8676002)(71200400001)(186003)(6506007)(38070700005)(82960400001)(33716001)(54906003)(122000001)(4744005)(6916009)(26005)(38100700002)(9686003)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AySpaN18lDdW4YfYbGjoUamAV8B4PjjElyXTP53gjOMST0AAKF7idMZLJl8x?=
 =?us-ascii?Q?5QQc1xlXl0UUQlaqLxASuFqGPQ3BwqUS8x2Mh+tPLUFJd33uIoISN8YDWk1K?=
 =?us-ascii?Q?dGLJ0e0YOkhmMnRK1z/pPK+KvPMECUsxN47Npws1OD/mqxKNsSEYzPpn2DmS?=
 =?us-ascii?Q?78XyS/3rg/rNwz5Sq19I5uMyw6Xwn26U3KE/KwoADyuh2QV6i2e8nxahJNy2?=
 =?us-ascii?Q?+go80zgQH1O0Jhb20gXZEl+WOxq5KkLwxQyFF3lVrbeyT9KmZOiSB5ZQJtGI?=
 =?us-ascii?Q?BfllgIDXBZmoW0hnydIn+a5KprEpIyFxthqH/74uC8EzPh3pr/ZZG/YoGUhU?=
 =?us-ascii?Q?9H08ROUx9gc/k8b0X1xubi/sex0DCZ3APXe1veB2uFd73X2BBGHCcrZ+hjS4?=
 =?us-ascii?Q?+Py+TcchH9yZ53t8stWa7j+OPOM2hq55ArkpCtaWmc6sLZrjavpV7M8yq4ZG?=
 =?us-ascii?Q?G0JFWFGGzYZ4pKCdVqde2CCt7iy25raQGMPZ1/MqtrBl1fG66b0v80eSrJQm?=
 =?us-ascii?Q?O1Vs5wYi6ixWPwPX/sv+0N3Jk71NtO6QMoEZK+R6V1p10gCBcmljJPZfKzuA?=
 =?us-ascii?Q?AAktPi4azjsBy2DjqaMuBOLPCWwCzkTv6aJQ2woNqOENH61mM/9qm08yu/TC?=
 =?us-ascii?Q?QoSjEFMeJcdCtQGKnhvASS+voDNrIKty4R25g3g48sdhHiTRhd5k6jiWlDHO?=
 =?us-ascii?Q?HiAjzrkIaZt6xcKQ+eTqIWKHV7odziFareP2+P2m5sPufCv81WzqhX7UB5hR?=
 =?us-ascii?Q?BK9EnpyZPsigPl3/9OTbRPy6AaHEGap8NM0a8y4IxluxODyNqxbHgTfZq/xW?=
 =?us-ascii?Q?kacuWWd6lSb7b8/0dxGtiIewZD1U9lWS9+BwjDEg6MizrYoXw2t99GcffAb8?=
 =?us-ascii?Q?r1o7V9Ekbgpz+FNF9Oo5ND2pmldKishoQyRY4H2srWiDOOq7XeCjJ7hLJSQh?=
 =?us-ascii?Q?473jymFdtKT73xwnDMuBSoM6S7SlFNQkM5cBCyro5KgQTmkS6TDpS9PDHb3t?=
 =?us-ascii?Q?HqehORMs4o4rYnqP2KJ/07XZiqH6nuCx2GTw0NcrJcGalPVhZUFOQ5IXGw37?=
 =?us-ascii?Q?zySQIEuB3kZ0YmK8ALAqSfQt1g1LaxXhFuY9RtGPFxarOQlpXrlfjxDAu0Lq?=
 =?us-ascii?Q?ql3w5ME7TBGzXxajhM7sm6xw6FUpGC93hpk0rES4HI6ID3ZkIHVW+xrcBwuc?=
 =?us-ascii?Q?NpEDdWp8RYH+TQqDMRnBY5qb/f65bG5hLoEgeVsGXK4t8wIXh2nxrtXHnpv/?=
 =?us-ascii?Q?AH933EzRZKV/js1Jn/00wg9up5yt34lH5EwQLrU4ZyJCITJ3Ey5vBqcxr2cS?=
 =?us-ascii?Q?gAkmSfYW0pz/YYkQ76cgHRg9T7/XYqXCQNJsU+2Vv/uEXxsxlCLlKCNVWIbc?=
 =?us-ascii?Q?p7ubIsRg8U6BQJ0mn2oronQOVvN6shsxF+jSwDRO23odYAaIxxNSBU0sKJst?=
 =?us-ascii?Q?NoxlTJo2xi0alS26SnAhWXOjVaPzV2KDbkC8piEWfgg5N+fFJTv8XoG539LQ?=
 =?us-ascii?Q?CLFboxy1rOjHbtKdCdLoSFTKiBjbUZt8Ipnf1DF4TqWJxR4NxndHTy++RCcG?=
 =?us-ascii?Q?Aeez6vmqX/fgjLM2Y0sdbWPvNdLrFvabqUYGaZ5imiCkwtTsXgV25ma4bVw0?=
 =?us-ascii?Q?Wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D07723D4474D34E884422AD715C3E62@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9741dcd0-1d3e-48ba-459c-08da5dc083bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 13:24:25.1045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0/LtgHZpH0g/o9ds535gMQZvlwfQoOxYWJDDvnhFFmaOcc+oUnWso0aznZLSdSpTzLNtx+c4JOpXjs63fV/OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6492
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 04, 2022 at 04:54:44AM -0700, Christoph Hellwig wrote:
> On Mon, Jul 04, 2022 at 09:33:32AM +0000, Johannes Thumshirn wrote:
> > > @@ -723,6 +732,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *=
fs_info)
> > >  	}
> > > =20
> > >  	fs_info->zone_size =3D zone_size;
> > > +	fs_info->max_zone_append_size =3D max_zone_append_size;
> > >  	fs_info->fs_devices->chunk_alloc_policy =3D BTRFS_CHUNK_ALLOC_ZONED=
;
> > > =20
> > >  	/*
> >=20
> > Thinking a bit more of this, this need to be the min() of all=20
> > max_zone_append_size values of the underlying devices, because even as =
of now
> > zoned btrfs supports multiple devices on a single FS.
>=20
> Yes.

That min() is done by the one above hunk.=

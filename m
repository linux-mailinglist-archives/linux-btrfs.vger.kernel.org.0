Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37823572E6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 08:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiGMGth (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 02:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiGMGtg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 02:49:36 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A3B2BB20
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 23:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657694975; x=1689230975;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=gfZxKSl1vtxy4bQj0/r73y9XR+0Q1lsn3guvMNtx2PXooScDvU9jh0ly
   MDBGPBsF+ZMdX7sO24fx+nFnR6ehL/e4LOi0qIRoYu/5GOrAXxoHqwFTR
   MCl92xodi2IarmTBsFMFMvBzvxvrhE0Z6vek4vtSEGm6dEZkZuRRBBYz8
   70Pu6hoKByQKKRgOVeGPjhUcMpftz0y6h8Xc5iIr8bjXKsc/GaQ75rRwx
   R+q1OaqRzKjw5e8EX3oBTT/aP16scwmotNZc3RZVKpErc+NxB3Oj6QJbM
   LMk2vYToQIAhKqEx4cKbn9zVa3o3aVeKV6D3Ez5m38rjbwFADgYvZSN1e
   g==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650902400"; 
   d="scan'208";a="204213950"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2022 14:49:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDRG8zoA4A4Om4J3rV6BZN5iJIaBjK5absf7PCCFfVayv1/qKWDRYGj31K7YSvCfwDML5yrDImYK75WIKRLYp5BNAjNgpF5I9XpsXdoHfburZbayVfjJ3/1x6osANOoR/ioBEa1RE2ZQz7K1mYUeM+7guHemT2bzPJqLXRp33qLYSErt231Rt91Dc6taxEY98/QrZilueahAXMkKpj8KTpMrdY9lzsZSC0nUw58fc2t5hM3T52jZbadJhQvSR+4mYt6k/K/AYGk6cLP7BWWWuobaaYZn25q964Z8n5gi4zuRdCgskhJcQ5YsKyTG8XPkWnrfwdyYAsy31l+QTkCifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=c4Xx8dkl0uPabBKB9hVeqCaoRv0qUM3ytdY8CocicE9KodRCAyb6tCzrIfOFFmXSJtSt+mUGx7jyGqMohHzjkWEsyJUUiDj/FZB5fYrDD1f+f2wT4wOPmSHv0gNjpEAbledi4P9ba+OgczTxaMmAwtDhLZYJULdWIgdaBmwA/3NUmChsdFNMbFwQlMEELm/K7Z8EWoHXWzqpbHXKXu6G7QjocE8mAf1uWdyP8RzpNG482vZ1uA9geyHB2cKEx37GquDlinEuolvdQfTBgZDwgSvBDcfGNUTcyBY1UE0pJPB5J19TXWqjpVgfDM5vDAOB0NVSxy/UvCV+Bb8D2ARMFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Oje6Uc4pjCBk4qmkdGesClz+E0Q6Jlazisr0CP+/meAfoLVOj6bDqnLkK09JiOO2ds7+NNIZneGmM8gX4goIrC3YnOXTbCG8WDi3/KixTGxhCtTtDBZKfcI3RezVLGWtPFqvfe331Ubv4J/ULuwkaJrmoId9LDtT0vhjwocvDhw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN4PR04MB8413.namprd04.prod.outlook.com (2603:10b6:806:200::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 06:49:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d54b:24e1:a45b:ab91%9]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:49:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 09/11] btrfs: simplify the submit_stripe_bio calling
 convention
Thread-Topic: [PATCH 09/11] btrfs: simplify the submit_stripe_bio calling
 convention
Thread-Index: AQHYln/PUSJ49qQQrky4iOzA9Ugg2w==
Date:   Wed, 13 Jul 2022 06:49:33 +0000
Message-ID: <PH0PR04MB7416B72EF3A21BBDDAF49F4F9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220713061359.1980118-1-hch@lst.de>
 <20220713061359.1980118-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f72f986d-6c05-4e88-ebc7-08da649bd7d8
x-ms-traffictypediagnostic: SN4PR04MB8413:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wiLIFKG/VDp/wq1wBcunk9lOU94cCCCnoI1Mzno1Byz2XKWCQUbKNystGLjgh8GUaxFKbl0SvNEeWWtEhNxX0YHqGEOrROuiWcACb4HqmPUPZl4Q4yzBpPHmWG56jfM/PUgPbQqycZhtRgbLwNdhEOrKg0fxGohLaVGhjtdHx7CpBIMbpE0a6022/XiqsUr6ngkmTu+EtD/IKXCqOtx9UF/nUFQG3aR2LZ4tOKs/r5cRwP9LUmjO2ucDzmRwE63/P33S2h8ls3SnqRxuuepV/0WpN8hoR6x62KjMRjibOYuO+E4V5FzyPRN40JSpHzJJWijVUvB/9dkHhoHG4w9ebEuUdHKR4JusOI4XyVInyzi84CfK26GOc5X4yJCEJM//hLRvhp8BC48Vl85XcVnudcK99n22zlaDNmawC30ElGxinvwwNSR8HTZzo/UD/S1P5pjpWdRiYB/5FAHNV/hjSkXut7xc9VbJEVBaHHXShahPxoSOi2GvSsPzU6e6pGvVFUXL/5Ti1CeIi/x1hoIlWy3VWoJA0zVocruDsXzWzYGWlGZSGI9vaCA8e4lQUsQaGfNOyrhAVIGhwy1xko+C7E3LNa6beBLaqbV5Rnztkp7rkuGO8z4B4YjrvIIVcCZuVOHauNyZNEHMJVGvRazLBPR9BYx+c4xDru4ir5slBW0hWUFeaRY4hgwKA54jIclvky3/OL7SxvvNWbx8G/iYsKSIGisgAnlHL5ukZp0/BbE73sLCJnweaXnWnKUpw+zNy5/2/9rZaq7bJ6/+kiveTM9kUW4nESbFGtMJgT0MOaTqPgfJfNWe0vCNTomrMdxE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(26005)(6506007)(558084003)(86362001)(9686003)(5660300002)(82960400001)(7696005)(2906002)(33656002)(38070700005)(8936002)(4270600006)(478600001)(52536014)(122000001)(19618925003)(41300700001)(55016003)(186003)(38100700002)(64756008)(54906003)(316002)(76116006)(91956017)(66946007)(110136005)(66556008)(66476007)(71200400001)(66446008)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?trmOXEJm7wmqw6Chb95uBH4Adhdyr0fuUeslYnrhtrVylNLV8B7v5hwyjoOh?=
 =?us-ascii?Q?2Ohf9dXnY/TyYyL3bGJ9ubehKjtTQX+hVzbztlVmKoR3gEMDVjFO74n/WUGu?=
 =?us-ascii?Q?a3pQAQQn3DgD8hWLulzE0uSyl1H3uwbgF6y8jODKZAvSYdLaTe8lCyQjGW6d?=
 =?us-ascii?Q?avlk8R46zV5IKSyWkOAtxVk3xpqT/H5mgSn3E4VhDPVHVwMlbb7fIFRsq2T1?=
 =?us-ascii?Q?kdqrcfFuYViOl8ujEn6oVuMDHG4zL+wPL1GN9dYTCHK9ipg9H26OfVXoMRpK?=
 =?us-ascii?Q?6pX5MKCh83KSJVpL1WBdRs3qrginWsI5ivZEUly9ov+VmxRsdZNXXF5m/GJ1?=
 =?us-ascii?Q?s+s2vuFd3Ioix8SVc7EQZKyrrUnUnw2PGnf3eL4GkyljbLrEjJ+Bxk4BDU4B?=
 =?us-ascii?Q?SCpJ2j5a2yrnfLuCdZ+mLk2kXF9nFVPa5YNyTghmOgaTHo7nQdw32KTH5yQ9?=
 =?us-ascii?Q?Rbpidj4ygHwGkR+yoJmq0wRb044qHotf5DWmbOsO3K52mLZLtTplrp/OZUGX?=
 =?us-ascii?Q?IEdVU4iqyWFACKQiGQeNxV/ikc7aVl3YLBWJ9XP/38Fw25T2brWhhx1cjRpi?=
 =?us-ascii?Q?i/qPtD/EcQjRwsG7YFoBQR9b1GsODyQ8DjVeVqNvCHem6Ug2gKsS0ZCnuOqF?=
 =?us-ascii?Q?uoS9xslSEUTjNuRtd5VUH0017Yh4628ay3cJMGnPv8OwgAfVebROnJCDxCw7?=
 =?us-ascii?Q?ln4w9vhnJmfogAnM2HE5BeAgG/ZldTWvSdDi6CJq1NHNvd4pX1mK71Z+n7Jf?=
 =?us-ascii?Q?qscn+E6xf/nfV8OEaYR6kPN/kuaHRLRWSJKqZ31J7pUIuuBjkgOSacy0ZakR?=
 =?us-ascii?Q?92gRpvxnlUd1Li26P2ztfGu9GDmKS2Q7nq4myNzv11mBUVUFdJpiuEk8PoHn?=
 =?us-ascii?Q?HRWxDh7mLbH5zxa5567WGEa+tdQL6My7NUvF8tMTKxjwMjQobdhdGC57fSwL?=
 =?us-ascii?Q?KtJh+WATdk0eav7wTK68rcPelwZDWr7SMi9ZCP4Mw11DbRhcrdpzc00AqEUf?=
 =?us-ascii?Q?sAHh0NV41hyCnrp75lJXOeNvcdyruRDp81LVreeW2lkedmpRVAwWHEhmJy0n?=
 =?us-ascii?Q?/0pSfZFMGZcJH5N5q6mUykQgbSg8V1w+iIQ7AHjXfCPO0Z69HTwaLAogGzSN?=
 =?us-ascii?Q?UrAMR/o4YYWlRq/PbyK1wqLovrfraRctCNve19ZZHWiDaTPX4fuIViwVg40M?=
 =?us-ascii?Q?uzntUb32PufPuhdz3auJkIkDl3ybZI9vUwh6TmELqzP06oaaQmiEDBM85rl4?=
 =?us-ascii?Q?rHZxLdxOoAjqCwCELk4DnuWSDav1TJUod2kM9s+oEm8piEIjIb+azOOCg6YP?=
 =?us-ascii?Q?WRCZri2UxxmL6O0OoZFVvyFJY7psGGOMcBfVWAVsY28POi9BunCxz5ENe4U3?=
 =?us-ascii?Q?qU8OUniwDz2Mf0oht68mo4C/fzfFrfk3eAQ97L23rcebbNFnxkPPB7fGltJ0?=
 =?us-ascii?Q?sowrwXTvB8xAtj3WKob+Wt4ku3JsHRkC0R2jjtjm+BRps+7P2nHFeluckOIP?=
 =?us-ascii?Q?jhsVmBRGalOSDC6gT18LvnFKl8eESB7mdvh5nORJ5t/HNwIx3jyXY4++DsKQ?=
 =?us-ascii?Q?GNrOCgV0ouvBe62UjKPs5PinGCLdYT+cgCe92lg/niAg64Vr4XyBBN78myqo?=
 =?us-ascii?Q?Os+EToINb4pHnE3komIqxdo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72f986d-6c05-4e88-ebc7-08da649bd7d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 06:49:33.0217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQP5KOwNTr3wtNd2R3Eqd4zlW+puPHoBxe7zGuSVQKHEpR2Ex6cXNF3y2KUsV8Fhu1mR6EXR4qJjj1qoyfRfxqMxzx9imWYwG261b5I2uk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8413
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

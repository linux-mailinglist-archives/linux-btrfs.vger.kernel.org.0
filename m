Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0CA5B9DA0
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiIOOpl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIOOpj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:45:39 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF72491DF
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663253137; x=1694789137;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=gjr4ORgzUss7Jt3Nt5nJcEw94y0CCkCGx7iZdnj2VrEJrRs7+ZcXZ8FE
   paYPn/lW3k+eECg3bkKEUVwv56QQH7bjQGBq1AVdQXcfkrdd5A9wyar5k
   7qmTJNW/MlDETLMdmCIzWzt2nFIaRFyrscf9ieGJ4OcRaOmB081R4nmsh
   d0obaMJJFW3xbIF7xNhXErnRtbrnDXwSBMrbxa4zq/NAtpGubp0II/kte
   AyIK2ujYFf3feGOXQ3R3jwxW35xrS3oq8x5JI8JVpe+SlnR4/s0gk+iAv
   cvFynv2hlT8aMdXaclkPRoOj21Wi5SqAwJ0D0uvK0iiX7Ip9nVj0tgAOm
   A==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="216610918"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:45:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIT5FZobZ+NXVghowAUGgMfkIHxyiElgSH9KrNz5x1Vbp0f4SvpZxztl3dOPzpYPRd6GIUeJ6zpOIuUdhpUIxkyCECTiGD6Lezj0sqLBZl9/ltQEa+05bZvGiuX5+CpmEiAIyy7/eMpD76OzjG2gq0L9n9koH+qBkFz6+mV6CcMGQ977a6aYbIMMp7Hfw63o41KN2Xri1nkoxpfLlYCS+W4NkeCP36eRLFbMfVkCJDk96FPe2gWVk6bG64f0qL5GdDwAi9zdnXAYoz8WKKyJisSd/gEmJv/hd3FtDmkhRDu+yTvtTvXi2EFNsrpQi+xiPT5y9bn5bluQtd0jmts99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=A8wxfQd+H9lBC3urttBMC3b7xgDHg+cuna3L7MUugqi27pGVS7NWqu6VBYYwHm+rQgzxvnn/2ufdleXXppbdB4ofrq02JAEBQ23LZ2xFkEsSGl9g2bpGMKtLKH6BmSdbK/q/bbfbq0bYRtwNAiDufsbBP1VxzzEQP1ztrNNT/uovaEF3xZGBu47sZtXwV72NPXLicdaNCNWU6qXo9+rxxeH2q76W0z8W6QFVpdtKA1XDQwlbw5JXonhA8fTg5+nwoh+xKMW39M05wLlp4+v/o1RmKxeNj5Z5zpi7zPoL0aY8Dm+zldFZ4NdqKlMllWZXZQI1te1kEIes+diksfpcWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=qdUW134PErhKC328nMsMXaLoWVzcFowLj1LDcGr4P95WPowaftbqGQ+bN8KAus2SJH0hJuTjPGDw95UlBOdH1BTn+W31lpOtaxb9scAnfql27yLjKujk7QsRVa3aE4FSUC2qYDzs8xRm6bY8AOAqzheNHgtBamLfTOOK2QYY2ho=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8170.namprd04.prod.outlook.com (2603:10b6:208:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 14:45:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:45:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 06/15] btrfs: move static_assert() for btrfs_super_block
 into fs.c
Thread-Topic: [PATCH 06/15] btrfs: move static_assert() for btrfs_super_block
 into fs.c
Thread-Index: AQHYyI5/c4ic9Z+b10Swt/TZOLYH5Q==
Date:   Thu, 15 Sep 2022 14:45:34 +0000
Message-ID: <PH0PR04MB7416F05017E03E9412D587679B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
 <6b462dc4d7ceffe2ba9141f46bf28350be7c7f4a.1663196541.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8170:EE_
x-ms-office365-filtering-correlation-id: f9b969fb-53e9-4eb1-3433-08da9728f250
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ksW7QDdbxW/JOSNVyiy9Q4fkRSq3ROZ/hOHHnpcr7rfHorTTxBow0SjheZCZ2SAEm1y1xPlrako0mOJYeJRwVf5gq2M4OGT/jBJNaE/2Rp7KSG7ISeKkVLUNbye4xrflq9EB7QO9uI0nZEvc8TyKSrfHOTYj/hlvY5feHCOlDlPZ8GsEb9helaELYUHG7nZiQTeM7ilOKnBnseObifk84SUfCNYLxZr3dVKE/cW++80jgnU0Tf2vEWC7KS2MWIY3xiNcEWLiIEYN5mFQCd1SK3G3OUq9UwxkY4mbFWgVkpBgjo/iZ4SfuTYi5hKoMy/boRm9HjBi1x2k4sdX7vm4WKov/XRBtBP4lVrWaVP9k6I9k4G9AjSwYzYHhVnmNqupZ6WF5ga/5Ir8uvI5fqFdwd9AwG5yKC04zACpsofavaegOjOsivMBNOvl0KKaTbtv3gjop+YsDSMe/0uv6gmm1UuIrV90hyXfmJ/P3RL7UBNy4Xk+V+B+zmETXWw6YWnvRa8zwfN5ZaIT07OXLLvD737jAIl4qdlAOdI6KVfB8/7/k5gPz2Xu0yQV4F9uAyAxMcD69L4QhX1xvDeRiRTlZJJpHt2NDVwbguGM5oII4oTKqWSCJgTY+XoVY+pE9vMWPDWZiR9tkRC4XdtL614oNjDhHUxGGCnKu50w/2wSvb1sXSzFLMV6OxYAZuYMzMozArwZT/5dmJ+s7qr6u3Dh1NwQRuolSIHjUB04jvfZABf32oBSbXhlSRVIS36rLO/6R+1VmercxpK8s67DX5b77w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(451199015)(478600001)(4270600006)(9686003)(558084003)(41300700001)(19618925003)(6506007)(38070700005)(86362001)(82960400001)(7696005)(186003)(38100700002)(122000001)(8936002)(8676002)(110136005)(316002)(5660300002)(52536014)(33656002)(55016003)(71200400001)(66476007)(2906002)(64756008)(66556008)(66446008)(91956017)(66946007)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?14bvDvd5qSXXKuYjENbxayklkvCj7/ZNo/sgV6GHeRsusYhHinyc3svtDt26?=
 =?us-ascii?Q?Kf8KQIPHfcNLjOQ3UV+EdUavwrO0c/XSWJJHQtFytpGPCyngE9cKdoulnxAG?=
 =?us-ascii?Q?un49PyhAybHjRdZG48lm9hbvnh0pgvZQrMZ+rIx2/y6GhjSDgHb+rrCWh5zO?=
 =?us-ascii?Q?TXSKTU6xl+lM79/BF0f924IWxuPFqQuEE19UL1NNFQaNxbuFkrjPgrUruxyx?=
 =?us-ascii?Q?iWUf/wi3QCQpu3rjNNvWPxF/Nf8idd6rafjvXE6XhVJEWY0lH8sAt65UzOG7?=
 =?us-ascii?Q?QeYpTzgIMjyGRQI1/lX7MyElUqAMNmRTcaHDpV6VhjeSB4xvYk8HJ3Nw7Ysc?=
 =?us-ascii?Q?xtgxC+k51+Zj5CFmUxE5Zz5P16QuljpRhkToSHPjhZ4N5qiNd65C60U++vhN?=
 =?us-ascii?Q?z+YRHvfHBFTVdrUhG9OTtzOCq/OPhUUpaso2RxEntgVS30B1ecXCDC04wULI?=
 =?us-ascii?Q?G8AA4Xsw+wD/tU0jyrq6ZEvMG2sbONnbLYV2g+IoBsyDbLKKxKHaO0rBW0/n?=
 =?us-ascii?Q?TqcCAM6ukhaUiI20JK2oB1J9FerfepGMLRy0XAhcwmQNALjkycWzMuvh0twr?=
 =?us-ascii?Q?a3Jn9QmT02oGbVMiYMlvh/aigGrHho6Qw7o7wLVP2IfR8f4p1Rt0tDZFIjHQ?=
 =?us-ascii?Q?Q76qVZaVw6gtbVQRKvq6dOYJQog+Q+mJHy9XKgCQed2+tZh7VFITaSJ1kQ+o?=
 =?us-ascii?Q?mKgx0omI3U64+A02SUEMuqVkbC1iIvgNIAdLMdo2ArFgofQtaIhVCa8907hT?=
 =?us-ascii?Q?kLxjYIPlzKNl5uCCGuBCWtCudacwlP4ABREt3tJGtNtm0GJFunbwz9Wf5RVr?=
 =?us-ascii?Q?KJG6ZPw8DBIUsmi5G3D3dRsCOK6e3/V6Z7PPXkpykbBqEwhm+Mfj5JM/Jgsh?=
 =?us-ascii?Q?xht01+jCTr+jAqj5oyoyNvw5RYofmJ0FUGcPs0RqGcVBM9NyZh9lQ4/7Hx91?=
 =?us-ascii?Q?K9xyoKMR+z/skejt8X2T+aAi8Woo4TVac4YjqQIjM//xZByW6hyXP52ITK9R?=
 =?us-ascii?Q?Mlss/yJwEw5HkBLzLuyE3V0BFwrHcgWscMK6Mk/lzqLJ/7FTnk/YPW1q0vNt?=
 =?us-ascii?Q?ie+wsbTDnQnRMwV1H5Ab2Tq7nWiGYrO9V1yUvcm6JqXvgR2sI64zT9TVtypc?=
 =?us-ascii?Q?WlZlzrLZc8MhjkWkiFeRX8GK4sbezrQXhzt5mcbbIKumFco6L4Zouy4Mg4OY?=
 =?us-ascii?Q?uWNx6cwSBn0Qd7tFLifcxXiNcAGVx0s17S11/uk3zn/aF/6LucQ8DHm20oB/?=
 =?us-ascii?Q?XrHqJ8mAV2Mtf2Qqr1HGDlcIp9jP8WVNyosQdm6edhgd59ohbA25pnIo4dDM?=
 =?us-ascii?Q?A/rSmiBEnEfp9PITs7VM441jQRvafGUjnWAiYySx/7dp2FS/Jg6pph+05odH?=
 =?us-ascii?Q?n73WqchFaby1nV8vDcjrvisP5XzdZXBLhhNLT9+qL+9f4USf8eGsVbXlke3/?=
 =?us-ascii?Q?lN+ext3t+XEKCue3E8w27HmJUH9FDmBSSL7e2SRyWlUMURCVAvVPh36HjYFE?=
 =?us-ascii?Q?3J7+v3rXi1ENfcyhTiXtnzkwEk6WsQFV64xE/SP0sBqSJLSWMsIO2tYL3LyT?=
 =?us-ascii?Q?iA84RjNOvAa0yDupPa3uaiCN7Hz+XIopgmBMPja5/VYsll/4ozj4yt7fziBd?=
 =?us-ascii?Q?yoE2t12L7Ejc7R4REHee7J5oxx1MhR1VzsfjZkAvbNsjp7lfzw109HkqJGfB?=
 =?us-ascii?Q?LddXYa1SPbGn1UafBD69RADwxso=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b969fb-53e9-4eb1-3433-08da9728f250
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:45:34.6018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84WVcBROneywBkSbkmHQV+V3p3Lz7nIVR7J86+DbAAhtnxZejI+rxJS+UZN8HLLnr1S/WxiQ8nlpJMxnihrSityDQad5jcfLlxnIbc129p4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8170
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

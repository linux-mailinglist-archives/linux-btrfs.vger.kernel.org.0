Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAB35B9DBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiIOOwc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIOOwa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:52:30 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ECC7391E
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663253548; x=1694789548;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=kK6Nq62vpL6ngeZcFrxV2LCGDFiy743deleU4A7Kz0oam+qn4D5JVWM3
   O5+USxYz4WVbW85gtzDL1Xy48YViWz5FEzaALk5tcjZhxsrErJ2OZ+Kna
   uPMbyIFX14W5dRql6CF5WLcsNgFe8iOMyBUnfzKDw0JXMWpDcEDnbmjpK
   hqGFw2UzCVsQYOsVpvw2MJnQhKK9UsQ94LCZdVNtbz+TkiXF8W6KQxSbC
   YDbC6yx9LevpCs4lrR+0SulVotuNfgny3BHqGzFWSj+xp5wKq/uVO16d1
   UjXX2dOAnbkh2e6bh047M/w24Wn5rE8ix5MCgqioZEA+BK1CHL6ZQLMl5
   A==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="323547015"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:52:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbmRmX/FMKz5GAgkShzuBPQxx69JUxAhSRXPtSu/97ncSh13+jFxSCTJ2od2C/8GH6Qib9ATLwF+SnKDunJgsuGgW4d12+YPzNw8AF6KYNhRTt+rUVd/hMl6x61WkeTxk5AyDvinr39jzlDgqQSXgNftbk+bywKI9mprI2LPG0V4ld5Z591cLdZI/kx3DwFGvsFTuXxSVFGMeAuDBfwIpdsCLCgyqQiASf5BkCtap1cobVmAmhTDyaa5OD9hYXMrGdGOVB+DNFXTDFET9xy2cj9ag8AwmHM7botyy8gtLAdNxgObAOiMOZbJmpNM8BK9LvNf1Y2zuhQkVady7CddJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=a+AOJaOdzmmthuIKKP8OeYn3y1LufYqi4TUTaCklTAP/tXmR5Ct+jLpWjntz8HSJ+znYt/jYJVe/PJrCngz+/kMDS0zyHl9e9+USaQ343IaJkd6kbU/uGJ/XX87BIFlRzoeXnxLA4OKO9MgUzJp1snUBfXL/fxAXzYdPb/GQU63TwIEPweZHacS6d0mVEYC+TuvrjTXkAAdcVleGEQ9WqGaVIRp7m1dlSul0mXv5W9vvTR+DYYNvxrV2Tjpau2nhSZ0lbx5jA/TNFRAq+r1xsuueb6ECjpcn3OI2BhWvWoTckVBto7oPX4zm2euUT2Iuky1cK7urKnlzVZ0lWePIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=m8yTng1WTjThwfQwH6hAegl3N+TP9emenfgldoIVcG4BfT2fUApSYC7ANfgWaGNnlsz3oWPsP4SsuZSsOisM9AUK9LAoSoqb3hyRSWOOV5JD0VfwGvlKs8qeV0Hpmw+wCM5fr0yn0KRrW9jXdWcdT1zI5v0HfHxtOpEOoYsgv/I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5923.namprd04.prod.outlook.com (2603:10b6:408:a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:52:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:52:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 13/15] btrfs: delete btrfs_insert_inode_hash helper
Thread-Topic: [PATCH 13/15] btrfs: delete btrfs_insert_inode_hash helper
Thread-Index: AQHYyI6HR8F+xKIG1UmJeea4SY8Qqg==
Date:   Thu, 15 Sep 2022 14:52:26 +0000
Message-ID: <PH0PR04MB74168915643EE51A5E3159C89B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
 <36293c3f222b706b007147efbba1f793793ae0cd.1663196541.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB5923:EE_
x-ms-office365-filtering-correlation-id: ba059ac0-789e-4fce-522d-08da9729e78e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5KLdwiUd0Hg7bsgSrfd4r0y+EhiwqwTr4rBlm/8NZphnOBS0qdnyih7Bv0lcDw/ApBIoUT49ZMX4o1VURUYylI+3QeTwM7bv7q9vziPt96fkx1pRS4Gbd0puVE2nZmAvtdwL1XTDVvV5bk9tc1XWHSMatfF0lRM2HQkwwt38L27WC4nNzr5uoy/LS/mm+qBcVMTHfrxn0FNQcfd1tGXuke6amI5x6A1XS6hp7vw9dCp5fQ+jA0W8UDOfDg7RzqHkUDf77gR1zGfOUGgTSj5RozS1ScOVdxBIPfgzGLQscvmbXWZG62j9WzDp4Oxw/xdilKD5+SxWWv2+yBQrgtqyfwkahZo/+obNHpTS2Fpk4g1ShWto2Bbp8uQKP0wOIM7QBLgqvVEpg/1jBuoJJ/KXAVjVx38+p7pA14Abwc2Rz3eINMDbAV99Ig+1T6Yf93v7A8a2HA3uA5Ob0/5m66t+hdMXi+lyc1UwTidD6gOkBxXhS4RVcfcM4zdo73UmFTH9L3/wUUKCL9Pb0km4q0KolyrwTRniEaF09AawOh/0L5sKU5/xvOrSOwb1i4KwnOkkJRPNA2S8V0PubiwTP+7lYh4a8loMdlts9Sis+db6SocYczSHJn/qLN7b8W8mlowIcqrHalFezapm5i5w15xuMLxTStPhJ1vGvWkygAmOX3VTZScHb/pUpBBK++uvWs0IH1nfEcB8S211IOMcJmUOC9uh8vDacKxBQ6cwzveXeNo73CSYTCpJR4c2YCQtLU7mWssWW9+FCetZm7k+0Z2wtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(52536014)(8936002)(19618925003)(5660300002)(316002)(41300700001)(2906002)(66476007)(66446008)(66556008)(8676002)(66946007)(64756008)(91956017)(76116006)(82960400001)(6506007)(38070700005)(110136005)(122000001)(7696005)(71200400001)(478600001)(55016003)(186003)(4270600006)(9686003)(33656002)(38100700002)(558084003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b+OQiSTQ+AQL5e/x0fDH0buWCU+Fag68w6OXcda3/Jd57fiJMyIk5FFX62I0?=
 =?us-ascii?Q?cI5H+L51OVR2dA/l2NSI6WcEjGiuSehzzp7uKQbFpSPBdWwm8zXBHh4cKqLe?=
 =?us-ascii?Q?QbVDUZUza8+cU9KDDGfDnhw126wJoeZsVQo80Y98d0MUkiVuyHCzFybtCYG9?=
 =?us-ascii?Q?yiF9Btw25tN83JsTb35mbXmWE9nWI31JRQiyzmeqCdcbM3m2EJ0g/+KnnHDZ?=
 =?us-ascii?Q?Oh21k1VYyHM3PjlyESRW3EmP2cnRwFkRZMreG4ciXUhVQ6rQLBQjocN9BSsZ?=
 =?us-ascii?Q?wZsLgL3i53k+Gj6l6YNJ8eP9FaXK1J7CdXKdcrqsfkzz0TkV12KureG6qX7A?=
 =?us-ascii?Q?pcY5/zb1DbXqDf8kt2qT5J4Qn0OPZYDy61V75UGQcR3hPTiiIvafQHTwJrwl?=
 =?us-ascii?Q?nUrJo0RsLTatmEgbglk2mXz9VtP98Q98djicCLOETRKEdi4dxzFdk2uwdatL?=
 =?us-ascii?Q?Pfm3FbplFhSJ83adJnpqoJjrqhsvb3lcmmZ+QWYFbi6tRUmZG52OUclWEkbb?=
 =?us-ascii?Q?I5I9uTujn3Z1uE8rkSmmheOPV79TBN57CzhVYXkBb2mhFFkjWPFAkimxvo5A?=
 =?us-ascii?Q?TOA3598WQi0ue/ZxKqqv9rRJBfObeUjF8oicbih9Zvip5KtbdoX9Us68dGz9?=
 =?us-ascii?Q?6EYEQl+nz+giw+AiqQiosoeeyfPQnIomn0WJNcluPI69AmqWXRM17thFcsz3?=
 =?us-ascii?Q?YrzviFu8BQ/iAyL1I1usujdISdyY5OVpZWxaqnLrHT5ggTNt4psOae6/uzWc?=
 =?us-ascii?Q?/HiKwENrEMzgT7YUJWIelJFW+s6hnh0CHiSImLCmYS6tSIxKscwGdFHtSqHB?=
 =?us-ascii?Q?iglFfnjZjMC5fZUWJ3kRL6mgOgmaforLQS1b8BH7VvOLVBGgUwLt/Jiv0A3H?=
 =?us-ascii?Q?EPVXTFVkx9RQehZE0KQBWaoamCyo+2axhuuAUm3WpAEACnNIP/jxbKqi2xer?=
 =?us-ascii?Q?BHbtSoKXSHHs5qX9JhT3Xo6kNCxDlzBXaZqSPN8P5Qj54nYKE+h3OmOVIgJX?=
 =?us-ascii?Q?Q+agUfP5XhiJLuogPOKozAe/0MUEtVrFLbbEECx+2nhetPvIeffH7MEYD4oe?=
 =?us-ascii?Q?vH7G5xmO262piZ01S4NJiS+rDXubIg20awFMbDwEgHDfttT7ZHPZROkVbbiI?=
 =?us-ascii?Q?ZscEnpsWqSl4qgKQXULJFmKqgt3fmXh1F3hEg/GfnTC0x8X5vSDozFkpYeiT?=
 =?us-ascii?Q?cYgtaE9H7W5KgSJ1DlGuubJPko/db2BuStO0b45zngalnf522NLfLOTVgvTJ?=
 =?us-ascii?Q?RWA8t/1PPaX3nH9ZBAGAoFCuUy5l1658BbUxg7nw15f6uT/sqy+nQx8280NH?=
 =?us-ascii?Q?53QWTM6BSkOU3ZAVgAyo7DzD2QmYHuMnPrwe/NvmIIE2+DJefqsDNWbbZywt?=
 =?us-ascii?Q?XqfCYgr+8tvXIZhN64vXm5phbK8qWeZrUHiqiI5wtWJhzWKTV7OUtru/lsiF?=
 =?us-ascii?Q?tuSUMQyBCiL7tHW4CljRUEfP6LKzxLRTeCgTYtZCpFc3xe6c3HxhVBLmS9+e?=
 =?us-ascii?Q?NkRUBPmVbTNXMcJCpUtB/6SeEpWjdkcl8JbjDuzetmbPMyaHvgO4at2gzAM2?=
 =?us-ascii?Q?Boi4wc3dZSs2FO67S3fBmEOX3sebYxm404MDLj97BQffFKG8RD4rDqo4E55F?=
 =?us-ascii?Q?W2ENcSieANc3eY7mjzS4H7IU9hHLZiNcNxv+y6eMNaZYDYJwk1Yie0rRgqmj?=
 =?us-ascii?Q?nraoDkV6Ei8kIAxRyqEjCo8jazk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba059ac0-789e-4fce-522d-08da9729e78e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:52:26.0195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hgPzVaBLIRX1EtPyOJuJSe7/d3nZ9PxczOjQD/Kf5ifPMly10B9t1JG1DhhZGAnzRdXFXuAe5+ue8u07VuehLb2CTDWNwzCUQ92lrq+7UZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5923
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

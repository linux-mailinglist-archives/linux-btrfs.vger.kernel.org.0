Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F0553F80B
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 10:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbiFGIUQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 04:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbiFGIUA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 04:20:00 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87EC82157
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 01:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654590000; x=1686126000;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=XL+hxpkxZY3n6qY4gKuuHmr0hw47YNYk6f4jLjU1v6Z6kq2niEcaJrDl
   cOJ3EYEAi9by3pf2ZF0ItHkgSin1yn4/+lknvfVRLkOAQ0mFuYZvhT2xy
   +wIgo4yYPEsA5wWeCagURKpQUhb2q9JllbdaJznftyNW344nEdIAZacZy
   L/bncYL6xfNzQlrL5vleeOpUbCbXkYa30VEVGS+sMR265+dfesadxGvUl
   NrdPhtlQsECkkXn2kUl8nGSDBo7mwjT8ByZRXLBHoLUzPtwttgnbfCqmk
   60VDG42NfflqKh95OncZzAbPPdOLD5zlGBfHgYJ+A1kO5jwbDpllpUKQ+
   g==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647273600"; 
   d="scan'208";a="203244475"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2022 16:19:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mxnj+VVie/IppS483JrkoblT3FqTpZYqnDnlgtw1UUEj5X+yPJd0RESLXJhH/xbEtEiNY4ajboNDEX0njweof8Q3ZjNO38pZTB+WbECx0FTWmdWJwnkxPSVXT67woPBYpxPJ/X2A+INR99jtBOO96KCTqsoWpH6N92T31FnpqrmNRFlJW5kbKUa46tcc2MOazUulH5M6RD+5dIMn9DWYycIbqyS+BQb9y5qzk5Go589oVHt/4qBDaREqgKpmA4zk6zFSLx7GtmUmQHjt2hhB9ZugpvRajh5TdPmhISCeMJ+W/s6ZBSbLLBK21yA2wRODY/CM+33PkFp0x9SS3ad7/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VQz66gXQnl+Hj8+hkS5OlMsN3ZvuXIbfgCgnHY+lWMWzIrp+nopSysSz1y8dSly8u5oserqEKoBiNUEJFU3PF2BvJdWK9h4rOf9pYyRapN+CZ97yKMF6GmpQKQ6qHfN7XxAJ+s7MxuYvHURAB0UwD53gZhzCnBWSIXRm39sNNCNl4CuIQMcw+Kzj/TEiIy2qiW117S48AH+hARh5Lmz7i4sRrobs6svs1DSYF9PkKAyP5ifAqkrilU/ZBHJk2nAOkbuIB/oQlqu/E2W3+NfQEiQYX7Hc5os5SSgeGVzVRuDNcDgfL8NuMKP34KQ+9lEEETdLFmMS2UZDEVqecr06yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=JvjoZbZmPsIVKyUKot/qCMaDPFTxspIIf06eEvPAju1Rmlo4vCPjXVjuk9sM7BqDb84k3uq4YxneUt0guTg46ilqoEEra50DOwxyhiOpB1mQ2j34EL1OdnbIg64jvCYjc2br8JHlbVoAJDcCQS+TpdvZ++Fy8QhKJT6b7xYx5f8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB3817.namprd04.prod.outlook.com (2603:10b6:5:ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 08:19:55 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 08:19:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] btrfs: zoned: fix critical section of relocation
 inode writeback
Thread-Topic: [PATCH v2 2/2] btrfs: zoned: fix critical section of relocation
 inode writeback
Thread-Index: AQHYej1sMiT0Yk2tREmvRZqpuggrqQ==
Date:   Tue, 7 Jun 2022 08:19:55 +0000
Message-ID: <PH0PR04MB7416783650533BB8EAE694439BA59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1654585425.git.naohiro.aota@wdc.com>
 <668df7d610ddae48ffd260ae08f433cc3b3d7ecd.1654585425.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8c66d04-1ab2-47a9-9728-08da485e812f
x-ms-traffictypediagnostic: DM6PR04MB3817:EE_
x-microsoft-antispam-prvs: <DM6PR04MB3817C27EB8449C55BABB6E8A9BA59@DM6PR04MB3817.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IV3BlpZsfMs5QXb6rSoM25LjHCkEQ48iHCR5eUL8l7quUIvlUCNFv6wKGy9TnNF+C+JF377fQYftj8Oan8aNJoyN6bJAyvhlXI9pwQgNJZZM7xUa4joEK55ieP3Dw1zjv0q4lerprTSlYELeN3C5iJGs9g4JAs4qSf7qlGtZ903Rx/mBhUCTAui4+LMU7n5tbOKJCdM0VXi6E10IVSg40BFozDtWc3qO2rnBHl+EPjKixxPe4tsIrJ+RfqKEcCbgPLD8OIJN2N2QJT2nnPPnRdWeIpvVbF+WuCaAh278nnO8etkRaS20EexQlb/ITzIzsrBa0K52qb3des47hmIuv5zzutuwaHJpTqBKWp8RvBSYx5tsJgJ1Z3VDLrSQOt/iuaNYvCmB3clbFmJTCY7Oq83p74/QzwkF0oXXtDJ9++UaYKS9DLWABEdggtYnmID7tjSGZ1GH3l4NqmKteuBWvh/qKHmUZsvZ5J2I/8LYfWknJt1Yse9Uoaz++fyuK0lpr2UhqXu0Zsa5Kmw/iBiE2TYQuRKeWvqkprfOJQbhEcvhbWzPOdiKXNcstvIPDicLY5sB7vAhi04YBPgVnkCTg4knzcaZruON7ahRTetuqxibt32icpR6WlT1oQDohrFMgYhUzLJS+zIldgy6jaYI31ogYoIUebHOcdL86gvPoz4uLaZLli7pmJCZ57Uy33jNtMQrfB/GDu4kkgYIeLOerg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(2906002)(122000001)(82960400001)(38070700005)(33656002)(4270600006)(5660300002)(19618925003)(38100700002)(9686003)(71200400001)(316002)(8936002)(55016003)(186003)(86362001)(558084003)(52536014)(6506007)(66446008)(91956017)(64756008)(8676002)(66476007)(66556008)(110136005)(76116006)(508600001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zYrD5eJMGNpjTYmCcx8if1iwOYYpP/TcgfjXjDGV8bleBX9vXTCis+HI5zrd?=
 =?us-ascii?Q?Blt27E5xtGr/OGsKr4xalLeki3Hc+7hzZBhPb9bASTRYgQV1XTCyBXPht0CO?=
 =?us-ascii?Q?ALnXdtHerv1WXfMMRiK+VOaF7mw+8cqJ7Qbhrk/S5FNjnCT740degVrEpNk5?=
 =?us-ascii?Q?fAI+NTIvn2E2fncDsM4cOozDu4zoNwIRGHVned02HDUaUv0mpF9ifa7Xd74y?=
 =?us-ascii?Q?S4ic5VDQNstlWBwIjc8EKlWONobOJXY389xKN1kDgJn6YUQxuJL1SuvS3skS?=
 =?us-ascii?Q?wgSxF4srGu0GdtqWzyuFtahxzn6VCH2mMeo/bPx6KjSEDasujnGY0Z3WLeqT?=
 =?us-ascii?Q?0tTaagWLLH+3zvfNiGo4ViHF/PTllz+Fzi73R9pf4GB3xmb8L0nmTsiwBr+3?=
 =?us-ascii?Q?OEy3udrzNZxT8zaPN1tsc7hDsdWuxRh9hrMWKTRxk1UJ9gz1A9mfuleMNg9R?=
 =?us-ascii?Q?Jg6yZZ0JXlTmi4+mhmLwWrRs9jLeG1aN/mP5nnFdrH6Dg2d6BY+uXNupOGnk?=
 =?us-ascii?Q?ypcnbtFE3d+wUxlKen+u2Et8oYojUGLDQy9p3Zk2rs18TfHidaYFCH65RXJy?=
 =?us-ascii?Q?1OB2YtZbhSZQs4/28NlIjDjpihE0NGmIXhPoiZdhAdjT/JgPTS11iZ/tmoW1?=
 =?us-ascii?Q?JBktydcqjGO8D0oYoeSw1pw2NvoB4Jdeib0UE85mqPzK7jWX/B3E+ZMGbu2+?=
 =?us-ascii?Q?EVJ1RBLtjBHItbIZl8V4tdmWGMAVYa0lh9rvdRWuczkdFxDg9BFWsmB1iVNb?=
 =?us-ascii?Q?w/BuYNE86WMbEFh/WYSmk7ZKhDMJHWuilYQznQ+FBu3ExG3FtOfoM6PbTfOc?=
 =?us-ascii?Q?N99nbk8/Ig2pZ9w+oPWYqtnPlqfJQzrjrNFHqcMc9Nl7G4vSUEHv28ehxbtt?=
 =?us-ascii?Q?HJPaOZCeZObLtmGqOXOEMy97cyOlhy4TqEHv3PPE4PVpGRWDtJIn7Lf/OqpB?=
 =?us-ascii?Q?pDidQwIul0oc8GxvDROfIMkCjvRvs1skKrnuSRoaUZLMfi3dSfXqU3ub2qTW?=
 =?us-ascii?Q?lGwGISPXKmCr1D8Ayir95Zm81BkO6Dz73zSk+oYMzWozQqItVBdDTjvopVRG?=
 =?us-ascii?Q?iNeTK6Jj+fOPG4KAO4Q/O4vn8Gxqf4lD2cUFkIJYwmdrlvkN7f+5kjGQX2yT?=
 =?us-ascii?Q?6oLnc3UP502PIZ0ZmnNda7oww48tHc9xornAo1kuEAEwHadeCCPJ7xsR/rbW?=
 =?us-ascii?Q?ES3Whc9RN9m6Kn57XDtfywXJKfI7/0Wi/OzV9U6ZsM4r2uEpwn2So1vwwbmW?=
 =?us-ascii?Q?j5oEswKIlRqBGH0ryqmCohVwAarJLH0Wcg4iZLyR2P2SGcZsH5gPAZKe0j4I?=
 =?us-ascii?Q?S0HDRDgx/kNxKQJ2+OIMxUlwRYgt6ccMISAIVFAuSPS7Vr0wJ4OnIGXCiyMa?=
 =?us-ascii?Q?N912fNGaN2jwVv5FW7cclZ7YLMbkMO9/pQHwOfCwYQTTptN/Yn2qGlNmihlo?=
 =?us-ascii?Q?SBeAARuVJ9CHn/QClCSXI6+eqNCQjw72QrwhclFsnTjBBNGdvPi0MJQUX7u3?=
 =?us-ascii?Q?4eKfbbl7NkJ9FkqRy3CJvmKMvZ1fypWxXHqIRIP37OPYFJ0I3FB0zp/PG9/V?=
 =?us-ascii?Q?b4kkVeUmuBOq11joQrrSWQxbZu3/7waFUDYFYUWY/dGvwoAnlqa0v1v2Xnvj?=
 =?us-ascii?Q?Ew2Zu+RuD7RE25BeQcgDmx/Fv+cGFNNvHd6ifz5EV9fkbvZXxCPs56n+LixL?=
 =?us-ascii?Q?cXvfxUrgkDMCpGnglX6AFRwC1c41K/Oqzhn4EMI/b1DV8skgJeBo6AoDTUMk?=
 =?us-ascii?Q?PkKhewdpKB8Jt+w8YD/kI3MVlByZfQ1VksJzdiiybQUosqotMzj0sPeAI/+w?=
x-ms-exchange-antispam-messagedata-1: b5EDFk8pSS0d30vOPhKRNbKDMdE2OcMGjzk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c66d04-1ab2-47a9-9728-08da485e812f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 08:19:55.7538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qn/YOXXXnVnA1K5hXMns5OH4ZpIPn4JHHrZMK8jirplYHM4fl5B4BHYbxWGBHHLA+bf0D02jVK/7zqQVyHm7BzbCdVr1JgV1WKw/4yaBYFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3817
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

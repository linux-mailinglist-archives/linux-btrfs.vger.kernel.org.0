Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89285745CF
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 09:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbiGNHVr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 03:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiGNHVq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 03:21:46 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5B712D16
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 00:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657783305; x=1689319305;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=GxSLrpfot2STtGpLpa7mvy7h8XS2x94vFby2VYwFY2nZx7tvttnKRfDd
   9TiEaCerl8w6CnlZNuga0Ek4A/djJGAjMB7thM4lGh6Ve55C4d6rNa//g
   lxhIKx+cq+oAMdr6lVuZ51InaT4DvAgdzJxv3ZY+E+HrXtB+mS6AfFuD1
   Ffd2Uv7oxvVP5apDz6qcdkV/6M8vPl+GCGAc91SfPmNcPUP3fxHocykKJ
   kvnaMgyMKBOX6sKyB49ogm+BmGnYXvhcgFuN1ygHh0Swhssv2nwG1/YYC
   CmHrzXOsKPv64wXpWd/vwazUSoxJrZtJEo3m1TI3+V8HX1RHMT1BFvAQO
   w==;
X-IronPort-AV: E=Sophos;i="5.92,269,1650902400"; 
   d="scan'208";a="310028628"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2022 15:21:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gj7sItLaY2IAyG/mBJWA8YlfQ+x2VYdxGf6bPL9++0jQXF3cN2/VOoTs1KPxzmgq/jkxysyyPDAq63apBOmNGSHs+b59y+a0dQJfxKBCkftVRRQtAY18TvtT3cGecFpaYjvWmstg/XPJFRQPDlOb9FvyWHokshvW9dK3AUvvlYHXTuZo0e6/XUa6VzITS13N3phALnKd1P3S+vbQnVMDYWuVF71hNaYMq0HYgicdkW2z2yBFnoA3yJvdpDzcTMkUFlJ+5F5+yYltpilck0mT0Fst+PKdIYzIy7Gj3X4h1Wp04HLLrkg4jsWt2+abGxJfNI5lZ+yuGbGdWJjLTPpj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ZmxNr6PY3OzDXlJPsAPTC+D9Q3G1jTL6e7LuQhfDFJqVheErsprSrxUgv2SbjvNH3smZWn97dljrErlu+Pht2grHTUSAA5vV321E0vl+QEJPogJOv7Lbamt480VUSW0FHu6TExPDvwzi/E7Z/S3u5lRJi/ZrVmfwcaRJIUvPN22duB6jS+rU+0tGGQS4OPROAI3k1xOc+6Lq8DPYR/lhDUs+ybPo+giaChbHXgasxJgJe+V9nus1dSNSIpP0dewrQqUncRD4Oo1oo6Oi/UuRcv25K59pSohulmG1nWaaEeWqefyPlEW6NAxLU/b4igUINmx2Rj7YjV+QtH5ON6muQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FocNBEmdXUWMT2viZAEO8/hQpo4fvLcYUHGLZlVAoHe4bsytIwMtpVZrPYVchA1A3m/HWp5nCCdosNh959+H52YW+aRN46nIiHp4J0DhWUyzsLGmvyiIEVhv2gj6G/nDh+5JtzCuGZEoCbBSOSA2mKEooa/stlz/w+9Y/05OppQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 07:21:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.014; Thu, 14 Jul 2022
 07:21:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 2/5] btrfs: convert block group bit field to use bit
 helpers
Thread-Topic: [PATCH 2/5] btrfs: convert block group bit field to use bit
 helpers
Thread-Index: AQHYlxl5G1bmEjpI7UKyU27r6gniKg==
Date:   Thu, 14 Jul 2022 07:21:43 +0000
Message-ID: <PH0PR04MB74161FADE4479B0CDFBEE6AA9B889@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1657758678.git.josef@toxicpanda.com>
 <2d97c27f8441f0ebbcadd8b22a628ed94b16cf6b.1657758678.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90f893bc-5abb-4ad2-2e03-08da656980a8
x-ms-traffictypediagnostic: CH2PR04MB6522:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W/QQxwd1/s5Tg3hlR0dd4yY/CTsTcyw0pJAGeQmtsHeBA24wGidHFSrHrEw5y9kaMMxpEjoXiMmA+e79N7/g625fo5682MGrME4b9q6EcylSQtK9BGTJv990tfWo0hdFUgsSYDd+tx93Y4CptlqZPPb4sAnhrMTh0aYYVanRP0TdHyCbYczJpVhFVG+MghNQ+YAO8vhnlUFecYOeeaTbxQBvoaGeeiW9SGgU+GG05bpbuD1nI9x801MbVAN1PKs+pAZG33LbdwJL3RvUyYG6feGYV5JRON4kRc+VN46n2xLOpPQTcxTsIJSkv4JbOvhSPNU5CYVTc9sT0aI51WvwH/OepiPt7ieody0owBdyHDyJ6seDN2z7dlzpCdW6DA6Mh41l8Ho2KBqmYFMAT4ZStiNMiM5wefqUrWotzOKOpXHtC0cLl7lQrksK/lXyA7jZyohhjpJB2pEfS03n3sKBMg5HWlBoqrOvZDvG1tzuBcLW+YJ1hYGezP/s83PrMd5bo28wbckvIGVOVzxQApW3pK520cp6uJJcOlUaWfb6Jbmq809Z04VtlO65Qg526uqvKXyRz1m8CXehqCEY+Be6+pBzzEjND4LZs4PpyYS8CQM0mnuNUaBYeRqiVTJ+DCrPrN0txFUveTV1IV25lZ9lWM0D/M9QW3rIBqfENIVIb0/73GammqlwCO8Bf8VMz2hwWFBCOzeEAGBVJM1+xK1ccRlZTiLuPvQzQu+tRgdnyHy/Re5M+KMhg3W4i3V7qR9NCYwJlZltkdQigA1m2CUTq6ndOyt5MjPmiaRlvgUBii8SNC+pXi9vUrnhUx79S6AY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(33656002)(38070700005)(82960400001)(66446008)(186003)(8936002)(86362001)(122000001)(38100700002)(5660300002)(52536014)(558084003)(19618925003)(55016003)(64756008)(66556008)(478600001)(41300700001)(2906002)(66946007)(4270600006)(316002)(26005)(91956017)(76116006)(66476007)(6506007)(8676002)(110136005)(71200400001)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Jgqc8I3G9iU73pdm89xX0Nef9RLfoeLldH0anIy1EHq1dySyN3PrUEqnmvpA?=
 =?us-ascii?Q?fMRMqKvItuiRWiGJxVJ5yT4bOAfrOghMMU3l20FzLId01gTfPgYriLwthiw8?=
 =?us-ascii?Q?EYi8ObuLhUbfIgTcY/oMi7rp9Hg/0bHIziTHIQ9x85LooNM2i4G3sNRBsKJE?=
 =?us-ascii?Q?m08DzIAA/P+o083CB66PggHuOIwt9Gie7oB/z2EoWfHC/Z2+84q46PmY2hPQ?=
 =?us-ascii?Q?vbV31HiNrag5zRa9vlwtO2KdUg4uYI7rHjWVLVab51nal5Of1zt5EpzMAED7?=
 =?us-ascii?Q?BypRoPPniboa2SqKlJUyuBuih7uRixbD4VVd6q7aXr5oVZPvJvsGCMPO7rCP?=
 =?us-ascii?Q?MCw/8PvCHRXdIyj5swDcjhHPiHlV59NoLVmxcIcI4J7QqED4O7F7Q03O3XQc?=
 =?us-ascii?Q?jX9KmHsjKHp9xrbGquEgArzaQyPhrHT6pALwYdp08+uE3flZ5csyrbwbHZT+?=
 =?us-ascii?Q?f/UwA/RFc2vkEWRsKmcpIPIVbVgU0GU+9EcIC5Z0Gd2V6AMwv19D/9hBo3tn?=
 =?us-ascii?Q?u2jedxuYzyuv/ZbLF7Y1NuzhK8MRszCb3ImpGypthNqUou6MRMmxUO8aDi0y?=
 =?us-ascii?Q?6vZGVwB64a2SpDnfiEkcINogTLtBGM8pdD6Nh1FGfdTOvChJvrOOlEWUyeJk?=
 =?us-ascii?Q?0DQbbmM85j44OcMfY6PoEVhw/ki010oGpgf/bkjrF4O2sB7me/dZfRZSpFMw?=
 =?us-ascii?Q?IqgPMkeEKiFh1XPvGAgF+8ITXQ7W14IqDf545H2RdGDh5zJtW9vFbe8m96dI?=
 =?us-ascii?Q?KW1/guzCq+7zZmFJFSogF5V3n1YDUahWFjXEYgrmZD6qHBMxDncHxrEB/3dM?=
 =?us-ascii?Q?ozhNIrZMGIq249aXek3Rle8AmLBaFSpVWKKrohtQ3IhqSmlGhjmTRUngV6/0?=
 =?us-ascii?Q?AL2g6G0pB//sZJnByG2IL1U7jhHKzZSXux9Tvf5EAvOt8bKnljxDNxjD1te8?=
 =?us-ascii?Q?LCNY/bbLAW05NBJRqW0C34ufeePDaYpAtlYPY85UlFb+id/wgK3i5+wJpjvz?=
 =?us-ascii?Q?tcSHlfIKTWfiuEIovs58STHrAt+2jhTBR+Q9LkNSlTxiUmM3CAdM9BVI4UlH?=
 =?us-ascii?Q?whQh7aP+b87ZmC9wwkChF9/MORcak/3VJBdX2YkAv7d3eKXe9kPnNEyLIGKo?=
 =?us-ascii?Q?D4JZFzni4JaWu6TjdlnuAnghiJWZ63mZfoQVixCOnSyUs6gI0Ojxrr6ymyKn?=
 =?us-ascii?Q?9AcpHNQbQCLzM3v05wEfJQGLl1xKQQVN0AHvoXpdp2CcGczjMJWw5Kipf1sw?=
 =?us-ascii?Q?Sk3NCSrAoL457aw8GCVAsc8QVHkS5clDlCblPB/7ercZ4H5OiHMOJ0ZPuTtS?=
 =?us-ascii?Q?UWiyyXTRViTSUlZJY9jzPoEU8tZKtIfBtB4arbBXO6Lmsce6UfrLa1Qw5mEu?=
 =?us-ascii?Q?fNKZdAqo3J1bKqP0qvfiXvK2xfuJ2Zc9clPQ82B8KORAwHna1J+h02dDz+KL?=
 =?us-ascii?Q?H4kRLKQB5gYRIZdzYOD77o2gXQs5qdWF4nNNvTNfE423Z8/DUK0PS/CSNfJ+?=
 =?us-ascii?Q?yF+C7x17xA08S6Rq2M0FHtVqYr6pUpTmImpbsnloTpF1AUnBnHp1vvQDNIRM?=
 =?us-ascii?Q?xbCX84sOiXteBz9GlqNz9teVrcjHwaKoNIiZ1BIRc5wqZDHOd0XxAr55a/FY?=
 =?us-ascii?Q?TapFQpRHW+IeaJU7T93lBqg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f893bc-5abb-4ad2-2e03-08da656980a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 07:21:43.0667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGZNhJj2S1Rcg3BijpBd7vFQxuDwvvPJ0E/ZUyJaVtYLjBU/xU5wEYYh0gf7OjW9LApQn2U3PujrteTI4PPP4X8jHzmQWuFdTYaCatVpbCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6522
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

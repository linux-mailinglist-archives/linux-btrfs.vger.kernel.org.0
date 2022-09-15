Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122E25B9DC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiIOOx4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiIOOxu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:53:50 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3F470E6F
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663253629; x=1694789629;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=mIjiRub9Yml+iQR+I1Emg6L4MR9Pqf5oqybYPQgON6BUNeBOfN2uVfol
   55vjdLcHjVLwp2/fPEvjOlZ/OwzPEdUBt2TLKHoVaK3nYw3i2csOCX9mX
   NcNVrodZ5ttS5ZmM2yNfx9CBOP+mT/5OTiC7+sETzl8SI9d/J8MKMDIP1
   KgxRRhwEG7BnWlgk/feCaAc4uVjLb1xw3SpFMDGUPyYZwZpp3U0a6ehCL
   bPYoRtqlVc62cxDuHjuUoeBuzla5cq0eHPaVJ1r1zFwk8xGu+gMAlHQup
   uDElHjj+YwDMwj6VwQUqukguvm/DnHFf5F2sgd/Fwx4MBxmY6PKlZPJlJ
   w==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="211894492"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:53:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfWRIbUV8pfjji/Fzn5zMieTzXi4je02asBXqopogJ4mdK1DTylAu59/7ca267yRETt7Lh30pNPx5tUY64X8C0lppAab5qnuuFd0g1RjlSn2Fd8fbdInSC8vlAjtwDwkMIvl66S/7r2XG9/Xc+qeTNQEfgpfOttBjYAisSiDsJTvM91KyQXYWX2kfr18BGjPa61+yJjc8NVBfV+IpFBEr5mnO+kx60cKmm/C/eelng/FHgcxceI/hzNqjjwFPh5M99dcq1TnztR7gQAqj0aH5E/eCZ7HwxRinMrc1Cg4uCygm2FD7YSPApyyjOEGmt05MLWF9l82DtSrvYTzkKA7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=a2d0COEMiv54C0XFgty6U4FyZrGgKA9bue+5rImYSxbHosHUwM6oqIf0DjdIhLSUnf/O6N28WBfhBTHAd0UZ7Vm/ERbEKqfTPNGI1up7kQjW0qQQhm703OrEpZTiQLvejKNsBidAP+JU6akWhr3zy9uoKRQdoe/PXkzJsrp6zwxGypQP38BX4IDY5v4chDIj+n+ZaNTzBJOlw8Q/rtoQl5cj4WT1HwYTnbPj3AZXPYKoKTV9CVHb1itOT307KrqYx44kAc9dGreJba8t1yh3fvCJagPXoV9tliqWijzvQAeWkuQC2JkUA3QUZRZmkhEut7N2AR6wopWezlq16WNsFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=tprNI2lY/a46BD/e2QrAln0N53vKxyCfEpQUyIULFW1BtWUxYsDWqVcy3BN0xLdMK5sgGvC5I/DOBeud56ACXIJiHfBg9p321mftqtRc3Thx3HbIHKsH+Zq75VmpTWGqNlfuxdEk43cKB/lCPX+fZuTR8xzI5MTemZ46fctO7lA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB4142.namprd04.prod.outlook.com (2603:10b6:805:36::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 14:53:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:53:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 14/15] btrfs: use a runtime flag to indicate an inode is a
 free space inode
Thread-Topic: [PATCH 14/15] btrfs: use a runtime flag to indicate an inode is
 a free space inode
Thread-Index: AQHYyI59Kc60aCjBKkKLsk5J2ZWQUA==
Date:   Thu, 15 Sep 2022 14:53:47 +0000
Message-ID: <PH0PR04MB7416F155CDE38C5C9CD7D5599B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
 <d8e32fa383bfa555cf49c9b184c45699bdc84ea3.1663196541.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN6PR04MB4142:EE_
x-ms-office365-filtering-correlation-id: 1554cb08-ad73-4656-679a-08da972a17fc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8xp0dY7TBtmU1qzh20+QNut7KSBvb1c4UarrdyxdvILlUjv9ogEYoRJGC047eBCgUc0C5elSRBU89Cdc/F1Igr5xKOAb6G2D5XyBDJUbpr9humBwlecpZuIAaTiCFW7ysSG/IOuyRL/1WUW4Mjb7IvJ/8bxN9wGjv2MkZXhgE2la88S6yR98Xyw93W46fElM0fZBI/gLhw2ZSCtcQx3Qdeiiz6g9sKRyQCQh6FNWbgDLgn2raoLAsQFpPmvbU6IIy45nE/C2+wEq1WbDOsKQ1uAc+rcrK4pCbBqdhAqJzBHFGH84eJP0kw0Y4AWmGd/xRbe5O4Kuy0uwEvk4B98y9D8797xgV4gWcJxi25JRDCTw8WSSxeWcx24WK6+lXveqznmTuPxwDMnoDPCxWMiiFk1PlhnKji6KcIc8n/l2vQ0B6kKLnCGSe2El+o7Tl9xTA6H+XA9urU5zVeOpD/1nz8ojeMmAY0+ipPanuanimeNyYSPDiwz6EIWeNUKQCb39iwu3SajVSIzVAV6Ix5mSlT8AKwJTBTjc16yxEZxvyqnaN8kcfI5v9iF/KuewV6rMog/n+kjFS2LEF+REvIFpHwNwog4rWix9I2D5MgRY2tM4poapuQxENlhboKYz6qadlzzVccznjIAZQeJtcKavFMSh3iMW3ZI3Ge6YF7F3uxLOEDSB+a5cIM44SPn/sSpn0NXHyiFgzXdWH0h2TS9ivfbqaGFziomr1MxEiICRmwIkpIfqtpGxH6Qm/EK/It+fd0AyAT/zMfcl4rijdBTnpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199015)(8936002)(66446008)(122000001)(5660300002)(8676002)(76116006)(41300700001)(66476007)(7696005)(64756008)(6506007)(9686003)(478600001)(186003)(71200400001)(110136005)(38100700002)(38070700005)(33656002)(55016003)(4270600006)(82960400001)(558084003)(52536014)(2906002)(91956017)(66556008)(66946007)(86362001)(19618925003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jiniGjlCsxbedx9dNZQ9ssu6Z7kT4US5YCF2iZmOIo+Pf0RyRbh2l9WgOxHY?=
 =?us-ascii?Q?Ft4BmvF6Bikjs6y8Y6okJY3d1hoTxURMHvrZ1dD36GJ7Oa+HPLQL1MPcYQ7u?=
 =?us-ascii?Q?E/qbZ2UdrCjkv14iO7ihOgyGRIWjiTwQtWsVnlstQ1HRjRkFijnhkPmmaKjl?=
 =?us-ascii?Q?cwbrOus2Z3Y0fiksTrgimIN29WWmgocHq6otP7+yWBjBmCkQ/x5OLhyd+fLE?=
 =?us-ascii?Q?QOZC9k3QMztaPj3SURrLX+gQosrzHMglZHDtFG0dk4ogJhrgeQQz+4lE96mT?=
 =?us-ascii?Q?W3eam4CO8GH1MAGT7gXpwQKopaHHSpQCHrHs/p55/ulKDJevbpY1RvaqVAGF?=
 =?us-ascii?Q?ErFb+d+Taz6hGTqpPrSpFjO/wuQJhFW29iiMwVBzMj2Ee+AsRvYP5+aqJ4h4?=
 =?us-ascii?Q?+fr3NFBjM1fG8YHf5wkYszIEptp618pxQR3CtVvwwDBa5H6bt2WneqvuNawK?=
 =?us-ascii?Q?UW1ZLIUQjpMQb6jefMvBG2NPuZY81A/IL7abRk0d4LyfuIUQSjbzHJ31zwJC?=
 =?us-ascii?Q?Ai9pp5oko4u1jM1pYIfEKX9DO40UsiJhVt2LTwZUtHhnSGlQORJab7BWjPhw?=
 =?us-ascii?Q?GCYN056eF9j7FHqm3M1XNMRP3svpRUW62BrhRbA86zeDX7p+J4TWh4mO+J6p?=
 =?us-ascii?Q?xsJ75UvN75aCIs4sKcs4orEJBSyAJXisPdIoPH6gmLnlLnH9q4vspt1aT5jy?=
 =?us-ascii?Q?GrT2xJ+BP+E8UCBFPHl8AjekAhOVmK6QUHTg57T7Y1bWcCGoQXR4RfOGGlGw?=
 =?us-ascii?Q?CvUSd1U+bjA2/MkX0/4JPeAfg5eaACbR3wMycW0GsGffbGizKPkNANL9OT0m?=
 =?us-ascii?Q?ReWrWg4OkKuHUcuoSb6BGo9qITfSiILc+pGUUyWxMZitsCNIxy5rujrNFIEc?=
 =?us-ascii?Q?XzPQWXfkeFOnHQ7ApZ3UY7sDfG9I9HJlrH7fysoWzPP8oQLKaRw+WOGa3aUE?=
 =?us-ascii?Q?GZneGuAFRymX+kfqTPOT+2rabrhRo2IlMXfePj/v4eQdQIOAdEj9kC28GdrR?=
 =?us-ascii?Q?GDn1ylbUsr6TXBo5/zE8713Wu6i/kpm8nziLplPnFEVHUyv9TgrlWdYkIcjf?=
 =?us-ascii?Q?5ltM/GMKQQWJqELlOQ+O7tkpHqgiiM8MYhIm/OAvcNfK4+FhgrhFmlHux+Is?=
 =?us-ascii?Q?+ykzy65ZZWjxAnw5EohTfAcfbSwwqnTsSghXEVw4b/jYxaxQgPvow8Iw8j6y?=
 =?us-ascii?Q?MKiiJpHhsmtm3HdKXEZ7wPK+hn20+Z7h1OHQrYdIgLPriK5S8lnS3goa3VHS?=
 =?us-ascii?Q?t57R4N3+uJEDS4N3s26R6U9ambtzrtnMEpG206+h/0KtHYK262TnBwFwsVJ1?=
 =?us-ascii?Q?sKnaALCrY1ZpGvikB0hVHSodkNu0W+oT01UlE6UUIhcQ5aUKdjcaPhJvWC/G?=
 =?us-ascii?Q?1mUWr/bYPryCq9ctSUSlre+7KLzgSMfdgxs415MapVI/cOuDgJkh86dnDkJG?=
 =?us-ascii?Q?9GYkZX/dfpOAGEhyTUoNpDW+LGz1o3jR6r5R4XGQTCVL85Z09Vvu4ak9D2RF?=
 =?us-ascii?Q?gBY/TJ2HuV2csyJWifWDKpy+fNtNUeWhzovNogVB8vlg2T0WNB/qHa5QeA7c?=
 =?us-ascii?Q?p0EiV4fyp96DypvvsmwI/HxAnptyZdTSg4qsiJ8h4kq1biyi/O5raTcpbxjI?=
 =?us-ascii?Q?LkTaObNGqwvZ48QHOPvh4BO3WK1yhFgD2E5kDx2Dvhi9EP1zMSsVPi/6ps0I?=
 =?us-ascii?Q?7ornKQB0TVqdk26CVX7mdVdv1K0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1554cb08-ad73-4656-679a-08da972a17fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:53:47.2871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/5INv7wWy9N2Ir+s+kX3/WKKzV3Ggx3Xlu9rS0YGpcoD+rBAOSvfKAYVOLQ56VSMbXj4GLP3lNy3L9nLPZd08TmTpLQASmzMP7AxQuDo5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4142
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

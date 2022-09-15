Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0895B9C6D
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 15:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiION4U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 09:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiION4S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 09:56:18 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2786A659E0
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 06:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663250177; x=1694786177;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=MQrgT731dZk2ZWJESgr2mK37EQ41NzS67aedfTfRP5CyZ6k1KTIYE5a5
   2CbhIqCtbYsdbnaI/caOcKqfMw4GMa8Tk4gP1W5C8mUEKS3ATaPNDxXJ9
   0wqrR8Ub7V/MGJ/oKULdAzLNq3Lp353gCGEsrXbEvK9viIsO2+AjPeJo/
   HSD3VCXgE51cFuRsCfm6DMrpf0VMyt5PZZh9ooFdmQIiU+bI3/S7W2oyZ
   a9AAVDW94YegTnc0bxXQwhp01TVL/IbjBUI0ux8UvAWfmGUd9OYiFCtX4
   ZzK7EytzvElC9uYi7oz6RPGSTWR7fNsc4ZUoFXDBvsJzVVo4WIjWPpkQx
   w==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="216606086"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 21:56:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnPned7NJopr39zbP6HjUlG2fS2FQf+fe83vVQ12Tlah0uxTELFzOOzmFUOEcvNb/xdWgtJ6vqe2iztB19qkRTQrcKdHDYgGuKh8YNTUho9VJqz1De+Ugli4Cf200Bh7mmUca4ZSa4Pi5OC0UKhu0XL0+58Da3Iv7mPuKrIb+yZx4J4vRzBcVPQDS+ugrjWPn+bN24JtecwDNQxmVSxU9r+/+uDqp+C3T+iizUln7C/qa1FPRMYBNs+DeWcWwp48S4SBlmJz7cjnLVAK0tTf/g4PHokfjjpzMuz/f43vxkPhGgWqkUeGDJEcymG0dwg0HeTkAQf/rHUX6lBbWP3xOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=eF105XBe2jPU5bMtzv2v/24t8Gzhj5H7+Wr+Kd3Q+++6qm6Tp2cAZ4SyhkFbGL32wCNxaFiEJ4B0d16p0RXVEK5bd4sXs5KJuRR/zSsg3w0oiV0XKLIVN19IiQkE8tjepGbSRwZR7V9XCROD3builtuDbeE6LmTEGDwsw+53lzenrq8dxRuS5AZuSbN84JqILobSWXPNe7blJutIkgAduyG//0N6dgAgsM8ncYAGxu/xHSMaCV6izRzEswysdAhmFsKDgP21C3BVjstBGLBKBnk0JeOK3viJGsZa+E8QOPUKGvzc6y+ITpqzLRAvirRV29T7JwAXA3aRJGZFVNx8YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YxwhnIrbq8d10Rhyta510+opFreMoeDAxf1ej9TUP3YI2wFEu47OBrPwDQSo9dXz0gJ1muEKGWyN6Pwv138RqItsAZqRo/N9Ezichkq/HjAp/L8SAycf2MlhJCeasOrj1UkckALDyiTdjGb5PVnGgjiLMn6/bG7EZkOm0zEsEgU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6108.namprd04.prod.outlook.com (2603:10b6:5:128::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 13:56:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 13:56:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 03/10] btrfs: move btrfs_can_zone_reset into extent-tree.c
Thread-Topic: [PATCH 03/10] btrfs: move btrfs_can_zone_reset into
 extent-tree.c
Thread-Index: AQHYyI7bDIcYhdC/gUGlEh0RJVBSOQ==
Date:   Thu, 15 Sep 2022 13:56:15 +0000
Message-ID: <PH0PR04MB7416038552BE49CE12059F419B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196746.git.josef@toxicpanda.com>
 <ee8a825f6de91a3b8ee7d4594cc62e8c4e71057c.1663196746.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6108:EE_
x-ms-office365-filtering-correlation-id: 782d46ca-e38a-487c-241d-08da97220e55
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qnrKzGOl/vVgzMYLCUpQPxd8v5MpJySzMahtl6Pz5xk2STcVjv6UHNq0aF5VJguzgEFI4Vj15FicWXrJ79AUjloBXFl7bPmh9EWHxx5f2bHjekk8kcxpO5yzYLaI6nXXcBx3MEYPTAEgtLWOJRrIY770g+m+aO5Z07uVaNyLC9UXgYSgzSP7bMVy5N+jPl58LhM6B/v0JnZIG+gyaxK2jSs9oSpNYtJoHc/q4/kwYIEOdq4p9oJtbd47WC1o2gidxVCdJvxPnc5bSFL3ayVkV0JEaFdt3/o+BaW2ovBx2TwXaHFnDfYadPdFuDkJWfLkxC/7QGF1K1SyjuyWO7A2xpVhdFWDJGPyjkjRWoEzZVMfevlbVuUocw3851PYCnfM3NYZ0OZQPf3o9pG7WVdY+9typk7ICj4k6B12n237mbhygO+WJqQL0pxZuYVvKeZsMe2Vjt/ksPyxujyX1hXUpXrGTpsF+f9orvSj3WRxDiCRHbe7Syq/iGG7j1V/HNpXRZifuTNVq8scFgbWZAOwhU4J/oWbHrcezwmf/imJuGWb/lTh2m5VvlEPBxh5ZnPtiuyjk1TyitYnFnOPc6QSYf2gp9n6JLqDPm98LJFr3fFarjWkIWi1J6AhVUz8rsi9jYTS0M9SGeEc9HfAlbqazZOhldADSGsyT/0o4WJjZuUEMBhZuN4mBWVhx92/dT2Du9nUHRCBTFOPRHyBvVlbBGOZGdXl+lp6A84BADqbB18Z5URJ/b68TDzt7TDNSRcjmMZdsS3nU+ZdOhtCpw7VxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199015)(9686003)(7696005)(4270600006)(55016003)(8676002)(6506007)(186003)(19618925003)(66946007)(66446008)(66556008)(66476007)(91956017)(86362001)(110136005)(38070700005)(76116006)(64756008)(478600001)(558084003)(33656002)(71200400001)(41300700001)(2906002)(5660300002)(52536014)(316002)(122000001)(82960400001)(38100700002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4nqUl2gltnBx6tobv+YpCwh4uHI3vF3C9caz9Gfa2kIR9Her8sspOmzvetmT?=
 =?us-ascii?Q?p/pDe9OBLdNg76tJJd0xdd8UlllSFp17CdVArCkqgD2CD82JbANln+iu0bgY?=
 =?us-ascii?Q?c0xvZEpW0xVH/+439Q9F93zhhPVOpk4QDn3VmtOWcY9VizOm4BNxNXgNb4LH?=
 =?us-ascii?Q?YSxL9ttcRGGULcmR0hFmtJgX9dk3STH/DmXVCYE3RvfWI5pEw/OIx57Rb8nK?=
 =?us-ascii?Q?+QOwfXM/VvCQV2vGBXsBIYuzdhFQXwAm9KzkrGciqJHybLgg8NdqcFlb71l1?=
 =?us-ascii?Q?KjIa22EsxZ2479iLZoAehYubEFy9mGv79OidMLbTZSn33ZLrRojG/3Cn/6Wf?=
 =?us-ascii?Q?JeDcwX3vrhR6tHQvbYJMhsIS1uOLptcxQUR2++Su6GCognAS9ZickRtM6FZp?=
 =?us-ascii?Q?GSnst1Ai36G2DyMrG3aQKAj9oTx8NRnu5fNxAuPWqep6HTyh+1OdgLvaHPvu?=
 =?us-ascii?Q?zzWcafvtH8zeScjNU6N0SNjVsANH2XJ2wTkdE4r+hOHBw3uzMTGu3CB+Dchh?=
 =?us-ascii?Q?22eSEHzLumFVtPy3jDprfBf0mODClnY6jfqC0V0HsQIZ+qfQsLRAE3jo/m2Q?=
 =?us-ascii?Q?AncJLKa2taLFQfPzQRzceTKxXCQkwYk0T/jQIJ7vIYgLoi6XAjoU7AIXgdt4?=
 =?us-ascii?Q?YPB8BcEAqQemvfnIal3Xe65T1KmKm+uNZcdj6TEvyD+5fbfPgm9qjDS/Pivf?=
 =?us-ascii?Q?PbOLn+3dapsMLzZpguDMQA9ynpaeqkAAWu3Mly3KkErMiqng2k6068YzPjpA?=
 =?us-ascii?Q?J3P5sbwubc9+HCCurVUrLugDT97T/Fp/4a7JdRbCdKK0cjwU+d9+jAgzQrI3?=
 =?us-ascii?Q?/CbhZ7EiQvzSdKSBNberMuHp351wBL0qhDXXU3ArrzCHR0+h3BemwWiWLBRF?=
 =?us-ascii?Q?/zQHmO+uvct2bfVue3/jiia2ZQJRQzU462XygO3otTAJ09hBbEzxCMoKm6qW?=
 =?us-ascii?Q?S7iveuHQdN2DIeAWUf7qRCc5PshoeKzZ1TR5vHeQgCh8wwmQV9EO/yC8FJZG?=
 =?us-ascii?Q?uXNOkV/o2aXpSnQ60xsBFYZoJh+7gVOCDSzSXzjRc/7R5u9ga4Gas0WviQn5?=
 =?us-ascii?Q?towsHEn7WwgIzOGh04NSiBHo2Ik7yyL2H8FcRDfgD8J0pXEGIw1SqvHPFIrW?=
 =?us-ascii?Q?uJxuT0wf4jt+7gif7c5qsmvAmHDykFiWr9AI7muyVJ7ebNzltZLKMiuojYGw?=
 =?us-ascii?Q?s/VG1NnmbXlRtAlOK4Ycg9skopL6r6LRZd8cKbHdij0ziwGfJ5n6l7EhURjp?=
 =?us-ascii?Q?4rbreulCjLtyzChzB8URZHRIMPEPPNS7wZTf5+MRSZ5hXY0dfIqPfRysqH3X?=
 =?us-ascii?Q?9gH1wQhI0OVOqMpxvg7XYqLjV9ZbrK6acwPq6d95wZNYjYAqq8F+clI2qW31?=
 =?us-ascii?Q?qCqHkeB4FPLhHdElk/UraSLAnlfWUEp42D8rtN9irY3rH5F55bCirm/OMt2m?=
 =?us-ascii?Q?uy/aRUsOvcsbtsiCiH1bjc0zYZvfEOpJUzreHpmAxRhJGHzQv3CsybbFXwUz?=
 =?us-ascii?Q?ZuB0Yy7pAV2A979JYkkfnnQOcs55Jx4S63wo/twmKGb4DS/eCcpnTkFtMJRe?=
 =?us-ascii?Q?0/cUTCjyJAWly1rYewL4wZuLIV0pS4980r8YWg2Yt7znQwWiTvQ2pKHGmuif?=
 =?us-ascii?Q?u3dfFnFUdPvCog6CNx6wdEgcVT3jQ2sDEWI+bDWVEEjNYQ5Uh9DLwa2T0z34?=
 =?us-ascii?Q?CDWC2w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782d46ca-e38a-487c-241d-08da97220e55
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 13:56:15.1333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GypX/3TR262fjZVu/kJEG3qXNRRxi0pU1whV2A+J7X9jDie3f3Ns8RF8VsR33V0gf1CEy7powo1gmGJATZtnTxXIrbQvfXoMxnn9FGOlctY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6108
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

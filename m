Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B425B9D1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiIOO3y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIOO3u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:29:50 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F152D1F1
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663252189; x=1694788189;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=NJC2tbsstkvsJEq17L7dmut86EU3bwr/N2gz/DgzbE0wgO7oU18ZpZ8C
   +se0DwuS26ntEGtVHgNPyZAsTsIUXGchwRuP2gOQ2bfuZPhy/2znbsWoe
   lFreDdJpmMfw3A4tvEQeLrFPIQyZQxrUqSMpL7EyQmY8Srmun1LeyDQHe
   rHkI11tzJUi6N/Gvx82AOMSywFuOx9zvimijESEV7OKTsCObyAVZQrxHP
   HJiJoiRcv3IM3vBBeRWm9RPkqdnhcMPxrBKF8hCm5hA612jyzXgb4TY3g
   +Hku7aLrSjhjLnC1MLd9mZm+CqRQfv6dpXWDXJm9C20THdHDcSW4y7atD
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="211892390"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:29:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BTRAe5h/TqOYShuEN4C5HYva2s/sB9ZhqVO72BZ/1F4OqcmVhP+aKeQrlvkHc6qawgYFRfZxkro60t8ORhpfTRWH/2KDMja8aQEzJyIygI77JxLJ8mcz807UT5TFrxDi4VnVyf3eh78wjSFZ4bPrIPMZF7gqDVFPjN9PGccS9O1tq47tPM0ij8SkP2QocGE+2uLBhjK69EziH41SY2qOM5+wb66wi8dlTnBgujnhdljoJDvWeWMm+Ez1zKkQ8iCCDhX3CXcKtmWRCufR9Pf/If/f6K00tTMwK1D7n4PnIYdF6g8MfaY0BcEWe4K9RPe5ZiPnKP5FkBFqekV/e0UxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IDVXO/CqbxGscwDSrHhAL3DvXgxzjrhLM8QQYfFfRMWRxj8gnt2FrPRRfL2OIVh+vOa4Nxgeg9pXdp967PxXKDkmQ4yFlk2A/+6xUZkmH/NHCuh2uCpwMAS8YK7/UApWZ1vz6Nw5MvzKm811mzJoihcUroKGFsnG48WgmFntKrt+HwdTUMA7SBJGdSQKIVj/DyuHkTyRgZEu49Xwep8LLAFNRAwDl3Zfcrhy0Lh9JifDlV356LBuLtqNAZwBhhWGJqMrq+k0PdF6F97h/nDEeWN1HgCAAw2IWsJkTTtFSTGbr3eLhuJk70DcW3Ue3wiboAjQ54uLYtfDxO7uOKjm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VOA7pRIUQS48MlV25sXAwplMCVnxeRDcPdhoJaMd5P7aU8NxaBYurM6KqzUqDBmLh3df8yPQlN2bsoyp8e+/Uj8hihs+eOmaTWIorBZhoCzLISR9tXlIPn9XzkF4kDm9VbchBwIKWKRxo2HaDO2Xj4yecSoODw0VnA6ybTjMAFY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN6PR04MB0565.namprd04.prod.outlook.com (2603:10b6:404:91::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:29:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:29:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 16/17] btrfs: move btrfs_next_old_item into ctree.c
Thread-Topic: [PATCH 16/17] btrfs: move btrfs_next_old_item into ctree.c
Thread-Index: AQHYyEu5c/WzHHw0gU2Q1KYw39KAnQ==
Date:   Thu, 15 Sep 2022 14:29:47 +0000
Message-ID: <PH0PR04MB74164422DCDCCFDDB739ED559B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
 <6b4e55458868b7d8f7b61be137fe9f9d7860dea1.1663167824.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN6PR04MB0565:EE_
x-ms-office365-filtering-correlation-id: 1f2665fd-ab5b-428c-2215-08da9726bd8d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rVX+Uc+093ug/JwnEZ1ZCXas5WP+pRqJQx31T3v16zoxEcM1c6ypl1PE5oX1gzWk3v/G7AemKvv4wXEwre2aCAfJO2CqAb0Q0mwhYbTx9J+75EEuIS1xpQZjQqxWeDr1xsU3IQckHPvB8gWlzX1NTPW69+M7f0ZN0h63ITiqtZ0bFmEd6GytnP6jnxYi1c9N6M7u1hD4uP/ocOFHX+YcthLN0J949gSeTq/8NYo6NoIWuapWs/BSAVNVOsKqvk9P5cu5YfBv17ycXJ2gYhkPfPlHEZm+UKRY5mQiCFzn7uVl09o5R0OKGlr78Ekg7g0dtooRHvtwU8qdncFE0XmlbKzraCnBqvKiOIu0Pk5QbHOsNsBaG8gd2YrKCFZ04HriqIl0DBsWS531ElH/YfjGJt03T7U/eHvPIy+QkzQ19az8/aW9QoXYDL3WWAl7HX0OMSCgKuXgXBz17wgp2QFQtED1OMOfNu0j9lhJ5CKROvOKnQkSkJ2mpZjeS26KOMXc/MapbcKvtRU5VM5VSixCcBzzK8lrVbaZ99yHJuBRcw2F/0GroQsGbNH9Km9vXUqZtfcBn46bNylPFcjpWiirEOEr3xJ35ViM+OX9D9HDsGI4mxz0DWyGhV9cBXFBny4OrIGwb6tkLBDx0BgpazGc44pKdWn5yi8HF5dvenpsy3YeGGbCUcSVw/l3zjnvdh/Z/YHBcx9fJ4VXFrX31MikyPq1jXERrYyhdDCLTkMqnU9dXgQLA9Y3eV9jM4h5CLxRnNlK+g5pOz+eWxWHru9QVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(478600001)(110136005)(316002)(91956017)(71200400001)(66476007)(19618925003)(66556008)(6506007)(8936002)(9686003)(76116006)(2906002)(82960400001)(5660300002)(8676002)(41300700001)(64756008)(86362001)(66446008)(52536014)(4270600006)(66946007)(7696005)(33656002)(558084003)(55016003)(38100700002)(122000001)(186003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7b5CELXmneQfZVG3t+bLhK7AQcjGPKsEd8djSZU5yu7SQOJBsS+0jAS9Bs1U?=
 =?us-ascii?Q?Q1Q9Lyk19RDotbdTolPRuuelevWHzNrUv+8j2RStnx2QcHCD4fiPABLrCzId?=
 =?us-ascii?Q?McTi6C/emM5yKeT/M04KeVgOkOmAZRJpQLr3vtbKBWhBe7pnMeM3Q1vIzd5I?=
 =?us-ascii?Q?kYAbc0Sr2vRxg8xiTy1iqWjlNbfV81GVfCYneI4RiGv5+ccbJbTHkzUIvkq6?=
 =?us-ascii?Q?gayvk2Edtscjx9qUNuaWzM//dz2+V8irraesQPZ9nnQtgJlV7Fd1xisYrApP?=
 =?us-ascii?Q?/pVGKWzbu+LpVRhVj+HSpjbAmQg5uS2rQ7BaplvKKiS8lFKoEcUU/IqLGUq7?=
 =?us-ascii?Q?idyOWqSaCT7iKMuxc71vqGBnjzm4589cw2RsWgbczzHPsJ110RLWp1FI+7bt?=
 =?us-ascii?Q?Od/bTliZRQ8hGzFW7thuVQmFjPKXRn7N4i2snUSxwLQc2szJC3i4c2LSEOdQ?=
 =?us-ascii?Q?9mRPQM7dZBeWqLdDl6GUO/2OfYM3DZKTafW+uj6EfSSkOLrIaJ9ts4PI5EIu?=
 =?us-ascii?Q?7z2EWpMJtd0hFlBc+nIE+MTcWedoS98tLX6eQjolh/Nf6agTTBVpW3gAjj65?=
 =?us-ascii?Q?b2bpIrZr5Kq2mE5eltlmfKf3VqICoxrQoCvY5zDbdoGTBKXU15mSXTdzpyoC?=
 =?us-ascii?Q?1m4njhoMZKDjoBX9KcPG2a1VRBeuXTeapBxJy9dbT1SfAQnk7B8TGIbQSKJK?=
 =?us-ascii?Q?mZ7z7xBG8zWiWgGtx9WWJRKpm0UK7w/0pSDSgEdNoV26RLowRezZIwhX3AaK?=
 =?us-ascii?Q?KCXcjXpeg9VQbu2TToVeoqmRWPwRKobYNU+YqD7YHex6kfItXyKOKa/ZH9hi?=
 =?us-ascii?Q?3FpmbsGNP6lVQr/gC2zlw3rstBNvIzb+NOqMkHMgFI5YhJytCoGgGYq6Hs31?=
 =?us-ascii?Q?PcuZPSLP6Gl3Fdl940w/ERP6wJS8dqtmKvh3qGrRHuAZ3so/rUM9nosl0bnM?=
 =?us-ascii?Q?qw+9dIM+hQ6Y8IrH6k5o//oChZxSqijDGvmaaurBPOnK/is+sH2E4Bt3y84q?=
 =?us-ascii?Q?HPWJAsm57a5FefxlI+G0mDzaDcEkbmY+I04KJ2OXcxwI66dr67omXcbaz2Jl?=
 =?us-ascii?Q?PgVMqovbgS+jVcQwzDhJhdvtO27nQxKKt1eKy1vJSzA1HMcJjFR/QXNNZMmG?=
 =?us-ascii?Q?Zq5hn4WFivClMxGx5Rp3Hp/xv7OVB4H8rZqFvxFta2rw2XSCP+Y1OTd+lT+c?=
 =?us-ascii?Q?MHqTEpMZwDTD91sQPbVR9Enk135RaQiGxXHtj5PXU2d264FuqsINR/iqKRfb?=
 =?us-ascii?Q?ilmuMOQKkjy9bneZP+bLY8tarJZMqeOUQ2tPaKPFIo5RZjv48NV24rdxZhXN?=
 =?us-ascii?Q?CoChtlLlW7ukkyLSVRjPmR/2LHtduXVau2yOPIL8LRGoATh+rrloItTueIg4?=
 =?us-ascii?Q?RzGWpJM+ahGmJAeMFVGUmh8vm6z8pSgWgxQLFc69ttDq94NwMv9C9hY4aZ7q?=
 =?us-ascii?Q?h+wuCqTItuKGvuGbCmlDK6PsurO1ovLBA9vmxza+V35JPw0dpiW7+W8a/5VU?=
 =?us-ascii?Q?3zN9wgvYKrxfGJnqDmYHboN5WXrYIvOu7H2vHmNL1jlR73Ha1G5aUVajK6l2?=
 =?us-ascii?Q?siXIGbMVcNHlQfcBRKqs5UouKJr6KCX1YwJ1rXwdyJk4HxeDKcT90M3UVPLg?=
 =?us-ascii?Q?WqTntsvQixJWLRzYgB+o9j0b+uiEcYRA0ze4NjDQXJHB5Zubs7fkEADPsyoh?=
 =?us-ascii?Q?VdqarnWputzMHMHq3oQRyxhq3hE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2665fd-ab5b-428c-2215-08da9726bd8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:29:47.0415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qU4cWuTlgmK2VlUbK387XZp8s9wsv90QQt71sXb+gJJniI2fkAZQeuKiMNEk8ps4mVM+YvD4i1o3/dc5tyONrYfXiI2ABpIPknlLRuVhu40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0565
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

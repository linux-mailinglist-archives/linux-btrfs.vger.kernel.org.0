Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989F75B9CB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiIOOQg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiIOOQc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:16:32 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6CF5A882
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663251391; x=1694787391;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=QqDkInGSCj+ue2pLjjf7tUt+SbTc66Ks3b6qKZVUMxABZM4QwFBq2WPZ
   bmUD3wWUtd3NNmFYZwg8fB44OtOa+naOEk3OdCuS6p/7SNTv8m9zGVYZb
   UGWSWXhFC+Ki/1nNrrLnUoqSt55dvj4S2NURTj0In1aQTAgULLgIYRYr9
   Qi9etxdsnxv1Xnm/ecR6yQ2jjLSHnHSiqooHKpTyza1s4+2aMVXoB/ZAp
   onswRshjStxHEoLu7wg7DpTZC0UorAycWr2Qr2X5RoTHMyOy2Zh1E4zJ9
   ETdiEwSd+exoWubhujkHNZ3BhrusNzL1f4qu3ZQaTN6Qm5Daou4vx7Ay0
   w==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="323543884"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:16:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnpN+27rWTgbDJjy2RQncjgQIEDN82N/tMPW9ObB/14P9jA4+F5us2qbTNUtb6Mx1Cu4vU2xwqmRK7mF+X49gWbMU1fx+Ixyf1sEunApwmKvkmj0H++gP04/7EGtiAT5M/79kFlOszS6gghBaSwjxPwgJAt/EsDc4e73prseGn72Qbm3UvPa/Oo3umjYfgbft2H5cyXHmb22skhtwhnx4Uk+pilB15xioOPnmu7vrP5HDSpRJbekIriNNJrvwo5jZ1SwdQBu8y9T8c2w+pXH/ofsSn4zQHy8eyRX+O0TMg0IUJ0mf3AL7TF7ba9VpfoeS6LhCxTM2eAcbtLAWmHufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=PvZdWMafUA+cDB2PgwZav7SCQL7oz1mue0U2vj0Q9azFZ2dIg0YwO+C0kEXrOoxXoUiViRGbVMxBTBsWmI3tCgF+Ko+0sP0R2lUcadB5qKn7e3tMGPgrYA8KXlGZ9EdtUKQx4hpq0c6iiTcOKDwbNh3wTw+52e+Ozd7Cu3FCEhf8gCNUv3Y38JZPrJM0KqYCSodBGqVolXMyCKJMpulR1aB9Fh+TYPUBLDF37fnHOQdysA1Ga6zosSS0GOoB09ENMfW2tgo5ejGG9MuYXFzEFcpVKzUQ9oEMDlCxM3F3Z/xEU1pv3naswRBjESKF3t0yF9fVJmytCujDZ/OHlaDZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=TN3c/ImQSuzg+vn0nnCUbRVm09iHi7wSclJP3XfOFhSoaI/9WxfG4GwfUBaK82WdnuYDj2YxdiyHYXDJLj2t+9nGObx7wOmKda4Gu+LC763vHgZ3RIVFZyOFTQ3GIq/aRFwbQxZDLGYov5fxMivHCPV6ms1FDch38H3YU9s7ook=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6860.namprd04.prod.outlook.com (2603:10b6:5:24c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 14:16:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:16:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 07/17] btrfs: move BTRFS_MAX_MIRRORS into scrub.c
Thread-Topic: [PATCH 07/17] btrfs: move BTRFS_MAX_MIRRORS into scrub.c
Thread-Index: AQHYyEu5eaSSgqXcnUWptxXB1CHqBA==
Date:   Thu, 15 Sep 2022 14:16:28 +0000
Message-ID: <PH0PR04MB74168465AE6852F923AAD3809B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
 <37fa62e6907f1eff71e2c77b9dadb324a408d9a2.1663167823.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6860:EE_
x-ms-office365-filtering-correlation-id: 6fd0ba66-0d53-4a11-5964-08da9724e19e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WsGhZzke7narlmK478TVobSv3ZBneRhzbtUHdaFXs1yrQtDOJtZOp9SnYbGCHy1kvMxCrsVcwhI8ChOZU0FwA3OnM4XdlKPePXR40jzzIQeJuCnu6PxCwMqiWQ7Yk9IQIJMtTYV23g4Uh1v1PkSxKWHHELfcNx1BSAmqDkk+d9ZFsMQcSyapFRVh9Atuc1YjoFBy7IQKNzGpQrY4PJ0nj9MLmIvIYMCvY9tTE8rn9gH8Mf9p54nmDWQZhMwOyjUPIDYd/z8bxQs8WSwswAnhCDnqLRCs6G+I6pJTLQIhuK7WISgHXlZaj8WjKPnEyrSwHHrYLZ7IeZRRLh+WGLoRndtp7Z8Pmscbc+UXeBpv1lMKCc4Cx79oB2mdG0CQF6XINeQGqhuwX5cf/Lfn/aYQn7FxSqTa7V7UtT7HsS1l+VxPQ+//90pAvLiAzr5nUFOhgxIrftwQQ9OvpiELzNE2CvXr4tWvx3g9gn4DsCeG/8rBfoDs4fSdJa8PjYTHQa3/oC74JxIxpREt9TS7Yxzwi1yLuNObfwOjArYTquh2b3BacVKHMp/ltH7llv8xveOqbaJfleOXUcoCJffKD8OKwLfOOZzhQZqj0/n8GEMN7L0lcWJzGU/6tXkPiDLfiVsQeekLU3bnv/85q7Sfkkqg3bjTEukSLuHMppA/3YU0MYIs4koCuKhDgs/w3J4nDUDSyfY9UWXMITxYVCtIi/vu2DAZl2+24RLdIP0HqD6d6aWZ4b8fIig6gV8j44CEJGGyP4WzyIoeRkFPf63NW9e/wA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199015)(478600001)(2906002)(55016003)(41300700001)(71200400001)(38070700005)(8936002)(64756008)(66556008)(66446008)(66476007)(66946007)(76116006)(86362001)(82960400001)(5660300002)(52536014)(558084003)(38100700002)(122000001)(19618925003)(8676002)(91956017)(33656002)(316002)(110136005)(186003)(4270600006)(7696005)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nK91J5h6ZgbyTR3TwhBZW88rA0JTLyhj6SPb8peZAZYH3wCwaN+BpPXQkhuc?=
 =?us-ascii?Q?CkOeLdhpsoIpZzbXVNU/InklCLzP8+tDLIXl4WDPu/8ExRvJSuruwtd+ZUTl?=
 =?us-ascii?Q?alJZDrk1htuqUuLhDMfgRryyqAeqWynG6xnfeRTMKizqlwy5rMX2T7OJvp7U?=
 =?us-ascii?Q?GQcxMpmRwwQjAXLTeIjejRss5nXFC7yuV7D0TcyGv6QnlPfyh0dl/jsbzCsP?=
 =?us-ascii?Q?me/Sm3osy2nzJNYrechJ1Hm5qEeP2hRqwrF2e3d7hj17jKre0cgW/HFUJ7wJ?=
 =?us-ascii?Q?X7V1EZNtB5R4wO+NoHgswcFHlIdHoMWitsJdrLcVl0Bs2rkey3ks2Ix4GtKO?=
 =?us-ascii?Q?hjvM6ITJqJg6kZk6fpzt6vqSyeReGwqP/g1Zj7qf69qWI0uZ1rBQf8mG1vKi?=
 =?us-ascii?Q?Eg8/25FyBC/lWHLUAtFM46mGBOUhda6KFn9YMW7lXlPOKMgMX14eVROfabGb?=
 =?us-ascii?Q?g2UKMAqzUBFOZD1MaatKyXP7J0ZYV49WC1IScpbbCMxiRSRHsV50N4Z33MuL?=
 =?us-ascii?Q?YOMMi2d5Y6ZSu4ResM+T81Fp5+6M97WlUi5ftmuvdeFB4SsgnlC8LHyAnUpM?=
 =?us-ascii?Q?uSE8ACAZ2uLX9nG4tuAcr/yScs4wDLgfUgFj1Lauh0R5nQM3aSf/sXaXZc9p?=
 =?us-ascii?Q?iqtCXhEimN+avQiPVU1rPkCf/ItbidoeiqWTerTjq3/6yK5/I4NhvV+5Fyev?=
 =?us-ascii?Q?/GyeuQrKuadWazVr4SjyI4gP9xfjBc+bC/nf6Q+rNmPMyMVS6orIHd/vMszK?=
 =?us-ascii?Q?UlcKgTRiC6YxWCkdYvGWlrK4639AqSnWYMsoYwuUX+zga321NaIQ5WljjeTH?=
 =?us-ascii?Q?hIepWjC5nVpNSReOmrxsMIBPWkOScntGzGWI23qWdJ45SNeIf/3zEtg8Mtd8?=
 =?us-ascii?Q?XUBWSx+JskqDlRnDPNRlEUebEPCP9Mj75Y9x9CVNN14JGOK11XgRcZ3BZZp8?=
 =?us-ascii?Q?+D4XfdLnVJVXNjCxekTtK64ynHJgrPQHcM7u2uZ8ibgaNPOsid+7+v8mIAtx?=
 =?us-ascii?Q?tgHektCDkNZ/eipF9xb5f2hGxkdz31ZcpF2rCGGDykrNUBAd9bZONRTjfPNZ?=
 =?us-ascii?Q?qqDZP2rWxyJucHO924pi+IZKDzO72VcYIUZZos62oTiC/pO3fHYE9KoVh3aU?=
 =?us-ascii?Q?a9IcFjnkhny23dV3Q6eKfM+FXk3dE6rNtZXyK6LgJU9y0QCGSVU6ayopL+a6?=
 =?us-ascii?Q?yCtxzIXd73f876v+xKm62Lfnp/qygSiKUQWpAYpW48ZQ4YI4HffMfgfdZShW?=
 =?us-ascii?Q?uaoh4AvrCxvtcYWEH0SXLiECBuhk9ajCmSsE1LklhQXeFgvSZfJEYz1MX+/s?=
 =?us-ascii?Q?4w/BaTUbC4Z54Ebvj2NAmLSPVe27t3fY/4XRcYKQxS1CN3braYgT1dP9pmBf?=
 =?us-ascii?Q?1YoGuNZ42GzRPXfCKIXxZ62kbDFAZkvQ29+5lP3nlvrZgUp4Y6Ouz5jDh0Kb?=
 =?us-ascii?Q?D/3IYL7ly9nfzhWwJ4cty6JfZhP8I1gsuWhYd90U0ymMUbUun5j1Rx9wF4b1?=
 =?us-ascii?Q?4g8x2OlicXqQoT+XKvpWU9LJxEojN8IicPezkkAzE+fnupaHBBSrt1ZTvBdg?=
 =?us-ascii?Q?9aJ5jA7M56UixqV/HjP48Zo0/ST5MjAAxtcIflcsK5N+sJfvqWwhrekwuDyZ?=
 =?us-ascii?Q?jwJxmciGZ9XpeKRBxi21iiBu8whn4Zg2rM7bfi80RaopnfnS87H8KuA1Ww5e?=
 =?us-ascii?Q?Ny8WcxpDAogCohtb0ALMxR+649w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd0ba66-0d53-4a11-5964-08da9724e19e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:16:28.5725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PgSMOoERWgq30CXBeE2YDTzLIn037HSi12xv1EMHld6GOY/EmYMQ5xAvaUI0b1K6zkxB1X3j0GJgU5yOjiXym42q0Vh6ZWds1mG3S19Fbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6860
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

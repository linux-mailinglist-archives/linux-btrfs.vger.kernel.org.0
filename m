Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F41B22E7C4
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 10:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgG0Ich (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 04:32:37 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:5914 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0Icg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 04:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595838756; x=1627374756;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=R9vzeYKE1dllldq8805tGR5E3yzsKcdQZgzZADtoRhY=;
  b=M56TDAb2OajtVa6L+2wxlEbVucZsZeRjFHcBSWfNPvxRvJ28APXk9yga
   mN6UelOY7OXdZ1CeHRjomGOE+kqCMTWiZp7Suv66F7d3/8vtlve1PXXL6
   Fyz/lSOObj76LElCdpIFmTqOI86IOkwillZDNHZsJz5aNFhOr0+3W8RlV
   fhKdFbPxEfuJG0xsFpSuPJSDNExpZFbkf9AHrl9K0IsiIWn1UdLWXbkKy
   MyEIPOxaty9kZxeve6aRFhWQ/39Xq6R/3O0xr0drQ/CVqwde4jDrXo7Cx
   D1KL72M8BF0q7IJB/4Qv8oBAJs+r+NOUIcEHl7xS1PiGfblxgRPu1SZb5
   Q==;
IronPort-SDR: a49H5D1NchDmpNoR7rpTYd2lvliwX5R5tp1C29ZZEa+JmtCERqsklTwR6wjVld7e7N93JqmyKB
 HLGgV6yyStWRDas07skhMGCgXWcW0Z50SksjgorljwrBYTe/A2YS26D7PXZ2fWgdOxbmkpbrZQ
 7+J1V5pkEOVa81Wj97UZJfDQJwlyIf/G5/fwX7bopGXvBM+ouUKOaPNOkHHxvnYyz6sk74gDIU
 e6/+Ru6JikCoowg8Rq6iFthZyG7o9ovJhccchaCFrW5m5+uu+RSg+CRiWdtY5+SfypmgNDaTQd
 WaY=
X-IronPort-AV: E=Sophos;i="5.75,401,1589212800"; 
   d="scan'208";a="144710840"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2020 16:32:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtgrpJO7DW51MstfAbyJxIXwn2nGCy328GB0R6iKhohb8gYRSxTiKqVjiCyTk3SP/aRS6Y0loBrhBcFEV69mnBp596IL9R+c+mHj7yu5omB7vz2pA9ZYz7LxwDUWNXcsIBTvYovWHnzYi+rOHDyFkJZmL9OgzstUQnhiMFVTqdpUCVUX5gNDwkt9ADf1X7cgEjcJo/Mpw8BIz0cbLKmmrRcTIRzV26FiAl7rTt1+3m4MmaJMfnI5X9l4346mo7FqaZ/fIRSAs4iBzb1ockkCdEwAxFapWQ7i8dHKR6qN4qRng6gTrKwkNcS9wNZMCHaKIyI8Ud6cK/QNmy9oj2cTkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppcvDe39UX2evVHn3BIMm5uRKml1UzcBcFnviaUiYZc=;
 b=KX4q0B7VJHqyGuQFf1pgdjHLD7vfdfmX0Koufm4b2MiJy1bKhWFwNBhXRpqTHGYFOoqxygk8DjGLqeKXTlFduhWmJsjsQN4Xnt97so7s7KG3t0fi4Jry+Vj4PCyY21/vkiCSVs6I0oCLRXmL+hp24nVrAMB9HJLj2RYedcpuv0tVe63AyfQIawxjmz3mtfEWcmSgcEMKCtoZ46VHBx/PT2cYWNPtIqmXDuNgc5w016fRW77t7I+102D66v4oh56Hta+YcdBK9cpwpDoJJwTtZWPrdHVMUr9Da0yFnICXAeEZZy/BgfLUyZqtgtN1rew8uaWE0JSqv6hfFgYaHEvOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppcvDe39UX2evVHn3BIMm5uRKml1UzcBcFnviaUiYZc=;
 b=f5ll2Nxu8636k/f9innKNR3RVAIy7ragHmQyvdF9tK6Z8E8/zEhB3qeLhqRj5SNB9brjZ9lwtkBVuehWqEWOuN7YhnrTEF45Irx7Y9zTNPMiPbiZxIlHGq1w4rAHKMCJK+TAAdbpo6GTzNPOEv9n68mgcvdpXPFgHMlbHkLt/Tk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3680.namprd04.prod.outlook.com
 (2603:10b6:803:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Mon, 27 Jul
 2020 08:32:34 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::2880:af03:9964:fa17]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::2880:af03:9964:fa17%6]) with mapi id 15.20.3216.031; Mon, 27 Jul 2020
 08:32:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: do not evaluate the expression with
 !CONFIG_BTRFS_ASSERT
Thread-Topic: [PATCH] btrfs: do not evaluate the expression with
 !CONFIG_BTRFS_ASSERT
Thread-Index: AQHWYdlWIgU4V39oDkGcadYkfiF0AQ==
Date:   Mon, 27 Jul 2020 08:32:34 +0000
Message-ID: <SN4PR0401MB3598B7F1B3FC35DD384383699B720@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200724164147.39925-1-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 63120a9f-8334-4e3d-6bc8-08d832079c9b
x-ms-traffictypediagnostic: SN4PR0401MB3680:
x-microsoft-antispam-prvs: <SN4PR0401MB3680114D91F1052B5314D68D9B720@SN4PR0401MB3680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AWW3PZH/9XV1wRQVyqVemReZqhpwJqOTT2EcAi1uj1wmJrktRcTq32J71Bg8JIiO1fXjBd/cHhssYLZJip/JJuRP395GZKQbobd29rdY2w2kEmyQM6oOKdahHauBelxrlMaMFpzDw208/9YFaZGPUg5Y/rRgFtVY63GxUnixVYX0MT2DZPRyO16eqSZ5D9qUXPEQr8tYT1XLhLbM1rMn32OquJLRYH5jOO3Z6/hFb3quPG8p4ogxoBD7Z1KLsfdoaZzSmGgKYE9iw2LXl07aMX7lFdjIs1My7yukuyOG85+Gp/uu2sf+OQ/ksFk4t9qvaHhCclqLC0hzNFhuye097g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(366004)(396003)(376002)(136003)(91956017)(4744005)(52536014)(76116006)(66946007)(110136005)(86362001)(478600001)(316002)(71200400001)(8676002)(26005)(8936002)(186003)(9686003)(55016002)(2906002)(33656002)(83380400001)(66476007)(5660300002)(64756008)(66556008)(53546011)(6506007)(66446008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tyuQdO7fTQE7x+2c4xZmhfJZOnSYlvMvGeSH5MhoyGJmsC3Ey8bKqfRvGLVSf51jQ2mdaNc6on0y2c+Y4JO4jmjwxyxVxtrneH0Kx9Wo7nHUHk8dXeR7nufmLZqaUgpUwYaaA9iPQxr1mlvQ6y2b04SwNFHNpZp6eVvMlI8yC7c/+b1X43UrT8IbTzvum3IJktYJTL2hHs2MJOaI9wX/eP3UdcX/vpBqznV2Z5YXnmBMu8Oldbex8gA2jr0dJQONV+PRfcdTy2X7s8Otidh/zvEQwy9Dvba47nOhSpJKK2Ub2MQLkqJg8TuoDxLzajVcSIvQzAnSm1HVeQ00E2avE3MmiER9MPY0wNby+pem7S9VtZujWFhL9KqLkgP8l+/AYUORXv8p+8e5bVZk+O5KHo+q5z0yLB1RjwojAwBjf+ctyXiFbgx02OYDPxgKWKIK4X6097R4OyayVLUDPuB8SQSZwjqpYPRJ9RSvPSD1KtucM0uslRXqPsNonTnuDXu6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63120a9f-8334-4e3d-6bc8-08d832079c9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 08:32:34.5746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cbyIPYumpP0ye3SY6Uiq2IWwJTXXjBP+EZa1nSqeHhyjO50KKowAHWCTvHRWs7gvbtgAE123bEGV7mCPtY/9Ih8TF4wkr94m81aNKc7/Bcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3680
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/07/2020 18:41, Josef Bacik wrote:=0A=
> While investigating a performance issue I noticed that turning off=0A=
> CONFIG_BTRFS_ASSERT had no effect in what I was seeing in perf,=0A=
> specifically check_setget_bounds() was around 5% for this workload.=0A=
> Upon investigation I realized that I made a mistake when I added=0A=
> ASSERT(), I would still evaluate the expression, but simply ignore the=0A=
> result.=0A=
> =0A=
> This is useless, and has a marked impact on performance.  This=0A=
> microbenchmark is the watered down version of an application that is=0A=
> experiencing performance issues, and does renames and creates over and=0A=
> over again.  Doing these operations 200k times without this patch takes=
=0A=
> 13 seconds on my machine.  With this patch it takes 7 seconds.=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=

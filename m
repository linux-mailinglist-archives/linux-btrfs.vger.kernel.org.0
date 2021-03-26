Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD0E349F40
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Mar 2021 02:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhCZB52 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Mar 2021 21:57:28 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:50068 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbhCZB5G (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Mar 2021 21:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616723826; x=1648259826;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6eYfh+M8ONyK5qzse6ByrZstBdMq0cYDvYzq4d9ei1M=;
  b=fLifX0Itp3T+JrjwTlFo47MyS0koNzvbu940NqwSxnuHbWD7ewza4o4G
   030WKBNvS7zbw1Uayi3C/LeXPIfoC8uRZ8wNzFjD+ZtOEsSyh0kjhhudy
   rRvS/FvZCZ66lB+XJcvR7obUlLZLKxyqpmuuFXSU0iCDnzJmTsvQcOgDv
   litZHAdHr+TdjF7w/guORJP5R0bCKZUi7bBekw5enNTpKTfeeyx+scHyz
   2+m9PG3hKX2b33orGUsY9YySqSNF+FbX4jntbbfjCJ4r8ofKIG1ZsPjte
   0KB+wp78xZYk5FEdjWol6N6psZG/bIVmlk4VxsWlEGXV7zYg1GwB/Ngr3
   A==;
IronPort-SDR: CFEmuXnS3NINeb10pzcg2PjKbKQHWyxu4gEEeJFXdQEiB4Obd/q+Q6z/qiKD37aExJTVLzeqdh
 +IVQRR05+lU/a2+CzQyB42M1hH9VqTyVrjf1LN1KKHw/36Lr8Zufr6puT/5OPxhFfMeD0Usbi9
 SVsjo47UGL1O7oGy4SXJ0wQGY1K8/Yr3QgJMjmJoNGPxGvnEftoEbzbzyZqw45QRJmKv2qsadV
 HKPL2JniV9FDpAeBLEfTgv3G0m3SoqHNvAxO58zFvRSz2wevR1pWYHiR1IGWKlcaKFvsj+hqZN
 aMU=
X-IronPort-AV: E=Sophos;i="5.81,278,1610380800"; 
   d="scan'208";a="162987809"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2021 09:57:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2eejkhRz5y3WCSoT7aK0OD4ixPUT2qB0+bZOAY3crbGgZUEiNGJr760JDYHfzGQ7joWy4gc2If2oFmTQbZ1ZKBHilnwTIl8rs1+Z3QBXv3Vb6nLgfET9oSk/J4FYSJPVgPfUwAckFN0eGTRWjPLovSSjrNKo9BrfMpKeDpapBjU7tN/GtPA9lkaiboEqv6V62+04RJCPrE/pG5Kyjb41bROUOH7nEeZvzo9EaKSKZ6NHh4V0VmjxX8g58J/ng7je4tDpk+r0vXGczjf3XPmhppNXVGr0TuJEZZG8eHqyyynHUIkZxd+ivJlC1FOqgOx4rtj1m78ZC7TNUn0PaDpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSADr30jp9G2cPp4HBqsJDU0b6rQoqTCtrVUyO7lQ1U=;
 b=a4fv1iL1P0OOnGRSm46rGN+xfZcfRlbrmYu3tJN0VZ6lrqssba8te4ZYfa9+DmoZM/ghDWcGgnhFXUdEyrh2h6UeVQZnfogaY0qqvsToLdmFwzpTBpqWKcUPbUXILvuk/jW3J72oknzAIHZEf56BcY84BwxFtd6+paqhmx0XvPb3fRUkxxhJwwIEZAksEP5lm6D/krpDEjqRTw2AMnv3or5xqJkP8a1H9gHOMU6UA1cYlhF+UKOBiurX43mjGORh2s9j2W3xgUJC8UPksAdu/6NKengAUR62Gkc2Lli7teYeTYnJZa2jx7YZD3rdfmwKouRzCTQ5nF11yB26pUUa8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSADr30jp9G2cPp4HBqsJDU0b6rQoqTCtrVUyO7lQ1U=;
 b=i6BBlO/dejbWxf1yCtDGP8VOuQlszsTXJu/RruTOvf+56FLEo8w6Bl3sQlRAMFaXlJ3dpS/k6Srz0I+VJeJfUVxCLeIMcRRr3tV0OdI5ojFoORA3qy22+3mOpzFFr6U7bReQx94uaKS9o4qFV3A2gz4MmkHnBcGmbKeZNVc5tY8=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6671.namprd04.prod.outlook.com (2603:10b6:208:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 01:57:03 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3955.027; Fri, 26 Mar 2021
 01:57:03 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: Re: [PATCH] btrfs: Fix a typo
Thread-Topic: [PATCH] btrfs: Fix a typo
Thread-Index: AQHXIdu3cC4ZaCmB50ysG/cZWNsDRw==
Date:   Fri, 26 Mar 2021 01:57:03 +0000
Message-ID: <BL0PR04MB6514411579BFB2381548A291E7619@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210326005932.8238-1-unixbhaskar@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:2c1b:956d:a4c2:114c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 923850e0-1d1d-47d8-0250-08d8effa73e7
x-ms-traffictypediagnostic: MN2PR04MB6671:
x-microsoft-antispam-prvs: <MN2PR04MB6671F47736C72628C3FF5553E7619@MN2PR04MB6671.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wo1I1QLplS/imvxixlkgdrBQtV02/4K04ydkzCOZi5oIwxkoOH4obB/Ra4QWKoxoZ8zK4IEEYuAolHREsbAr9nCCxNTRjJQe0xZlfngKueP1A9RESDUIfrta45JPgCj7ZFVWPyBKQ+8DZ6OvjdM57GK/tBc8GiNgV0rW37gVK5XmYN2NlTqj78CFYcZbFMdyoreEuL6uin3s6PiKO/YuXg7kcIBGG+E9D0qPHwGyoTOfhocgqAA7G2eu1+Nt0kJPtpYmBIf9T8uclW9jFsjeImBpUTCxsOGJ1oqRGMq8t+OQ1d9ONLX0fDKwEw5huk5RwgEgCHolAOyTJH8viNA/IJniz5VvIaIpi4fMRevUhrne0yGLrrOnvXC2XrmXehVwXWYAaqXDcf3t7MzXNZ+5qVT8mdloDLwZdteFcxzTjcIZt9E79J79zL8VALrecpk0ITe/FdMsr7/BVryiZLB5k/R37Q0d+joyZtI2z8wHiCMt7NNLbMkhrMa1XHwaylOad8Y8Ccx0/8YNQC2ABbzQ7TsGxlxCesCgMeDwHDPv9yXJV3SzPOngyg/VMNsRJZuwMlirvmtYpeyY2k78vbSPpc4wasnxL8g+qXWrrksptBfObRfEQljoueQcpU43D5QHLhhBWs34SByOvdpg2jXS4EBtJD5RgoKgJdYD63obvLI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(38100700001)(86362001)(52536014)(5660300002)(83380400001)(66446008)(91956017)(76116006)(4744005)(66946007)(33656002)(66476007)(64756008)(66556008)(6506007)(9686003)(110136005)(2906002)(4326008)(8936002)(478600001)(8676002)(71200400001)(55016002)(186003)(53546011)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ccaoYDALnmf4ELKJhzzt8TlvxKEYGE5Ar+8H+V0RQyUioS5QeG63zAiGqzqT?=
 =?us-ascii?Q?fQbMgJPltrlKacxWewOEI73QocOuIR4nPdP5y/CTS4kNGesa5HXRyllIhiHS?=
 =?us-ascii?Q?qlLsKpndYoSMaYa+XDzlqspIqjE+8VTfCVhvcFUuRaUz0PErX2YJ3/H3x2Dx?=
 =?us-ascii?Q?w6Wi35RglSytZaTlE9XH8b7BEdEscxlWf70MfAGYiN8+cl29CVaEZQe7oLza?=
 =?us-ascii?Q?bHPtt+LHQxCY8hMPI676jlTi0NFR2c1Mhg0scySj+OOCWgXJO7FYxUWkUiHZ?=
 =?us-ascii?Q?7V5yY+jsitXsTYiFA8VWP2mhnekmFgq3SS7C49htUYNQd5xGzlL8IHkCGZNx?=
 =?us-ascii?Q?7HJEnEAIqj/QOaFtYvusFsxrjp3WzeuWeXQt/mHOkvQ6K5bxLnD7+u5luF9/?=
 =?us-ascii?Q?WwIjY9CVM0WUKzRkbvSrS24XCzwJIihgWsdvQSNV3ii19xgyPQcR7UG2aEry?=
 =?us-ascii?Q?yPqZpEA7Pw/DXXOBPQxnOApwAlm8LNxQkjTGp/bnBKpYmcNBrsFFuYDHZwTq?=
 =?us-ascii?Q?NDGK1+n4tKLnKYQu9jM8PPSS/xn/ND32nRUMawX9O8R4wGzCQmlTJCMLg9Oe?=
 =?us-ascii?Q?oL5UeCzFSR0eJiipuICGVBqo3xpRUWFi8VHgM2Bnry1AUxCzKjNOsTQ1r7ft?=
 =?us-ascii?Q?uO4byGAGH7/766nsQ3znV+WtAQadet7LE+uGWvvc+494n+fqf9uNfoIV0KgT?=
 =?us-ascii?Q?nyH2cJqdXy+QPCC+/6lFwSfiFkPJpyqMWUYvrcHl/7tx2k36DC2DUil194bt?=
 =?us-ascii?Q?u5dc+cm3K4drpj+o8Ixn+tLhie5aOQLIrQTDgD/O3yb170koqxW37LbmzbS6?=
 =?us-ascii?Q?BNkvp813khWAuezukKOPdBh3gbU7A8WQjHhQA0gbr4E4exKzxu9PJraDt5rQ?=
 =?us-ascii?Q?takVZ5WtcNo+9DxeG2+KTnlhxKu7moqmLv83o1QlPESfCg1VTtrQqNvhohB4?=
 =?us-ascii?Q?e5+j+1iXI0yMhStbCtOgpU3inW23wJ+nQ4UKp5xdko2as7yzKqN5oIX4Dl3p?=
 =?us-ascii?Q?1V2xn9oe1FJbVaarP9IuZSWgnI3k5gjQ9kNXfvOljcx+RltNVXH7e6voIq16?=
 =?us-ascii?Q?2khsw1UZ76qhp2e2dr5bqFpnuO1uz6sTpyajnN2LTlN7VDVh6eCP+quYcXsm?=
 =?us-ascii?Q?fnt6BMaWYz5X4DjYOgapZGKTDHFaDIZIeTD9zng47TbloEWFSjztOXxBQuzf?=
 =?us-ascii?Q?sirBXawBWCLzhcm4sUUtygZgKl6bsapKyDe5EOfHdth+yIBzfSHyfpvWEjv0?=
 =?us-ascii?Q?2d5mPfaLKyHgjnxVlSPmZBhjNdWopU2M4T1Yb+sS/yJIRs9aVLBzOof5AcVW?=
 =?us-ascii?Q?yduSV9tziEZo059UEDt/yP5cEfLSa2sWm6obyjSjaT0/K18JBggcJNXAQsAO?=
 =?us-ascii?Q?jNrfJXaCOi8k8uNavgtb7mS1sEpFOyDofe/u4Is+JDcO4sg/vQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923850e0-1d1d-47d8-0250-08d8effa73e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 01:57:03.6385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15+iiS6FXbPfZNgWO8qRsxIkRIFm5qCJC23wXXr4HFc8U+axK5EMfiYkudzxw4MH3NwPEqgt+ohWEwjTZyN83Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6671
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/03/26 10:02, Bhaskar Chowdhury wrote:=0A=
> =0A=
> s/reponsible/responsible/=0A=
> =0A=
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>=0A=
> ---=0A=
>  fs/btrfs/scrub.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c=0A=
> index 3d9088eab2fc..14de898967bf 100644=0A=
> --- a/fs/btrfs/scrub.c=0A=
> +++ b/fs/btrfs/scrub.c=0A=
> @@ -2426,7 +2426,7 @@ static void drop_csum_range(struct scrub_ctx *sctx,=
 struct btrfs_ordered_sum *su=0A=
>   * the csum into @csum.=0A=
>   *=0A=
>   * The search source is sctx->csum_list, which is a pre-populated list=
=0A=
> - * storing bytenr ordered csum ranges.  We're reponsible to cleanup any =
range=0A=
> + * storing bytenr ordered csum ranges.  We're responsible to cleanup any=
 range=0A=
=0A=
If you are at fixing typos, you may as well fix the grammar at the same tim=
e :)=0A=
=0A=
We're responsible to cleanup... -> We're responsible for cleaning up...=0A=
=0A=
>   * that is before @logical.=0A=
>   *=0A=
>   * Return 0 if there is no csum for the range.=0A=
> --=0A=
> 2.26.2=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=

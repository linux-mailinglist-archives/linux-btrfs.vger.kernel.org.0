Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F0036E85C
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 12:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbhD2KFu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 06:05:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33799 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhD2KFt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 06:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619690701; x=1651226701;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Bll28tavSuzJfPiLvXgRj2hvIIPIzKi3wXxPfIshQ6I=;
  b=hxjvD21Bn83M8Nkl6JQ3ORXLMuzm8nnRwQviq7roMZ2qyTho+0JIbvCz
   6V/lgIhL/N5usNAvm6EJ15RMz1h8W3rHzgPWE0E9YYjJ6lh0H1Sq+Foav
   SrW9Olvu374Yw/hWs1DL/4vgPOxRD+o1T6JoSN1wSIFiLRlURrFmSiG8S
   C2qca/jq7hHpzqW5KNWbpOo94KFC5FHZaqRQiJWtmiBNK/gZ7TNs+BUy0
   9KGnM9uzBSp1ezMxXzPU9WmhB09y6R963tFQcL7CqrcxuuxhRx2iPsxDb
   XUwccVtH8S9w6sumozX50Wc5dPIWQVHoKy+DYUKs9ylF4T5kAcgw/J6Gy
   g==;
IronPort-SDR: fRmsu+F7aKxn3S4LrriTkTQ7TrURC+xdM4WxfBEcCdU1+KuPAUHShMbh4nrY4Wu2ny7HrG8tMv
 J4yEV9LD4jN1J1YonhknKDQkB7LaHz03oCO6wm8QW8a90GWuPSkZ9MpEC1BvynnCWO9ePZbnWx
 eyEax79w4S2Y0+5oinOYUA4Oip3hXIwNQ8ioide9qnagYp0TiKz/lihaHO118xqVnSyYhxtc83
 FRId5y2buH75knaIFMjPd0IjMQkXc9lvpAtlOPS7xhZdR4ZB+ImDnpA54IVJIS1Y86copQGqgQ
 zrU=
X-IronPort-AV: E=Sophos;i="5.82,258,1613404800"; 
   d="scan'208";a="171187782"
Received: from mail-dm3nam07lp2044.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.44])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2021 18:05:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWJ3yNnFpKNKV0QkvY3u55uU8c6IO2cAYPlTRFo3is78arQ7d6UEMcO+tPhZYZYcigaM3dpqCwQ37YBt70ZdjNjrrn9zzmBwdXiaRWD7f1o53MMNTI7Gdiza06IhGiTEevHgDL9ffLHgwvCeJirK4WMfEhGUVEUS+8yVmd8xOqLDlDIBiQP22NGzvZg9PVZdEDQ7Bqyq1KFUNEJaT61VSgEQ+9hWy42AvLCRmDR3hAdcIm46KFxaeRNieDSRWZ/ie8rPVRj3L6tpMhOQZv7h/2IM/bRvir6Rsrxct8L5yG5LIiE6pbAvLn9ZIkyiFzqaurDOD7XhYcV14mIey+obAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bll28tavSuzJfPiLvXgRj2hvIIPIzKi3wXxPfIshQ6I=;
 b=FOM+17TdgC7ZunV+6U0rYlLM0osRbQCe2w0R9bOPs5MNe/ZYsiunHLyLGB4pZCJUt7NemxbkR4lTxiUAQDK3PrF68HZmtCiesFSxeqlGZb1K6aAMzI9CnciZdUwB3UGVFl+a9XAIicL4W6OUH744vLDGYSkuSGknfVFq8Z/Z6DZ7BDzX0+AwZxl7PV6dUkb2D6v3sRQrr/KsSfmT1a3xt1ew+uSUIwokHbRc0oW9786C4Uorl7Vq63qtVVQC8H3SaffbfabBielrcPr09N7I7voTzcYYAqwW+bWwK2KrUmG14koVEYjdbpqmXJut33TI4tXatGIuWCLHVNF65qZsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bll28tavSuzJfPiLvXgRj2hvIIPIzKi3wXxPfIshQ6I=;
 b=w7PlZj3Dt0K1xq9i2yY1rbss+XD0gySI8QCh607RclpDiS4GguKGVbWxclvCKcLKC/j1/LOFsCiwfg3QgXnPO1TtY3g61UYiprPF6hQFaPImu8KHJT+90TiX0bI9Meh5Rq8c9x82JHVTAmEGdQnbKF2BzHT+kMAvk8EjAgX/6v0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7189.namprd04.prod.outlook.com (2603:10b6:510:1e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 10:05:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 10:05:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     Eryu Guan <guan@eryu.me>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v2 2/2] btrfs: add test for zone auto reclaim
Thread-Topic: [PATCH v2 2/2] btrfs: add test for zone auto reclaim
Thread-Index: AQHXPAr5+g9ID+tNhUSGHsEH/npFvg==
Date:   Thu, 29 Apr 2021 10:05:01 +0000
Message-ID: <PH0PR04MB74163147612C69B1CD2D1FA39B5F9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210428084608.21213-1-johannes.thumshirn@wdc.com>
 <20210428084608.21213-3-johannes.thumshirn@wdc.com>
 <CAL3q7H4z=eePUYbOgOVZhMCp+u8m8bbvKfU5nNqq3rd_8YNm1g@mail.gmail.com>
 <PH0PR04MB74165CF0E16A53B38FF4AEEF9B5F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H6rQt=ecHN=Q3xh0tGsq5fmrkQaCApeusyvYYj0xDjp7g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8a994e9-b5aa-45f6-5f93-08d90af640b1
x-ms-traffictypediagnostic: PH0PR04MB7189:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB71892915F3F31259EDD20FB79B5F9@PH0PR04MB7189.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MUBZXm0sd/lV+znLb8lv6eF5h3G4Itt2k113jTFYS8dlmk30aXk49bPKsulk+XQGQaFHirNLHrUKAtb8sUWWQ7XL/SkiPLHuNrBgzMT99O9BxJhLyWmrlBTi/MQp3brLrQBsSZ64u2qd79t4FjMlm3vkY9HLYvo2oK2yu6bL3X9HiRKAfY2Z9JYU5fCzJldNXLNF3tAgfn/RZ5lhJcNebydaKv1am8obHexCZtbhKDgqtoIqmqXICkJfHdTuDRuj63PqABxWRPv9MMCYVnXJl/zgz//4Lp6Z/jSxUsW/QIT7GQSSOn0DxrYaCQTKUz4q1MgYdog6EOK+CbxnCjeMDct9vyWFkyacBq6tp5K05nDTzox6BuFTVx0M4yNHWL+GgytBVeXgVG6w4bpH+O3jZapOorfpMyy1vSYEclLsptGFKqsUXIh8UPrW1vDwGcYCDDTsbRu4yKEtbN9PfXZ4/Mbz3U0A6oJyyt8wMJzzGoeZcYbYDl66oUzL9KvWeCOOey2HQArw+Ac86smU89tUOjMAaBlHPtiy3Bo2YqIovxR8dDnnqBoI/S9CaYsaFkKdBKTtbLBH8M8DjCki6ByD2oknBJhOnsCVEg+uLovND8s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(33656002)(54906003)(5660300002)(86362001)(186003)(4744005)(316002)(66476007)(478600001)(76116006)(2906002)(9686003)(55016002)(8936002)(8676002)(4326008)(64756008)(6916009)(66946007)(122000001)(83380400001)(66446008)(38100700002)(26005)(71200400001)(66556008)(6506007)(53546011)(7696005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Kw9C1Z19/2m4aZypIinmqqu/T4tkeyMUgLTFoMavURLN0T2wRkPexlEl2egz?=
 =?us-ascii?Q?XjZeLKnbSz/Qz+owL2EqViwl0G0gpKMsHRITzGkmUl1CBVBQq10E7Xl+ra85?=
 =?us-ascii?Q?JpBS868VTH3+G5k8mo0sL2+SJu+WYoZDu+qgfw5V9PJNpaqvKp9IFkDvPT39?=
 =?us-ascii?Q?7jARYBdzMUtn40HoYQ6EXg5NP1XFZZlSG8LOKkcKq/WwgYoUmXbckyWn6IEv?=
 =?us-ascii?Q?UfpzZN3EAM1goLj4fKKRST/GKSGc24+QCda8jky/g+hPh0k51bX+CQjRKx6G?=
 =?us-ascii?Q?6elJHhD/MnGy7vNemVKlybqhC94HGcZC8MBPbCF6X44YWKDQ12Emrey36Vom?=
 =?us-ascii?Q?5Pud8UOSQqchjn5jPILIQFLGnayLAmvszjt8JOpZDRbEJO6QcS4a3qoZH0qv?=
 =?us-ascii?Q?Lp2mrXWhkPKtBpxYPilc8AN3i5xh3gzX8BqWny2Sa5v5nO+ML1VRm01Hgt+U?=
 =?us-ascii?Q?I3oLV6mEvpVvNt4f5AQiIf9puy1ce8Kx88UrIrhUy75Qi1iVvXhAw+WLGU6r?=
 =?us-ascii?Q?QVmx7rsyTG6Ct8WNnR9P8Nod/vD+ewp43f6egqp+3nSTtHY0LXWo9zOjxAFh?=
 =?us-ascii?Q?qZZ+MJXNjAZlMVxJGrXEUXrY1yIYVWsoG1rYfJPtO3AGeYbLtcXrJ/GuAZN9?=
 =?us-ascii?Q?j6S0LSLlsSgGku7eAqYxdXlBXr1IjMshhwZPB0RuzAImlyr4Csj8+T4UnEdJ?=
 =?us-ascii?Q?MmSjVaYE72swlSItwdoy5bAUdQ5dGUNlHGbpgpf0zonUeQ0XKu8oDQyycsh5?=
 =?us-ascii?Q?yXb8PWqxtXZumwkWt18iFr1BmRnJ6L4+sOzdfSM6+et+o8emfwWsfUO83Woz?=
 =?us-ascii?Q?KWAIvBMxjE3AeQBH61mIEsy8DdSwaNT6FZYrOjVvdwvSpEZOWStnhriAkKgK?=
 =?us-ascii?Q?gEqR2ncg1VpLu69Cvaghh8E6vKbZaQgcehqsf908n9auKPJNQgQBEd92m0El?=
 =?us-ascii?Q?bpq8gBb/2Q1vWZf7825KuJpCahOhL0xM+8ZioQLWj4FYKBA7xkr6biJOo9Ef?=
 =?us-ascii?Q?BShTy3QB645XNS5qgKaTpNNlpnOfa2JhOF5W0yTZwfJ1QiWTwWLMjk8Fu44w?=
 =?us-ascii?Q?i+yUBMmx8JNB/qSUp9FUJiFRinWOXUD0PfuhrCzDUkEnV5vCAgEyz5iHo9sO?=
 =?us-ascii?Q?MhMs+d5rM6LhIVAZ/RIjh9C0grNhaoWe93gFyjE2I/ZpwQSYR/fbo3PD0sFj?=
 =?us-ascii?Q?/eMRKguBRDdteGwacz9WzO1zwUSJr6/BIHXjMUXsl5UJZKZoAedSPgLwLuCV?=
 =?us-ascii?Q?hdWq3QMMM5heQh/O1TN9U5WMdIJyfm0AgoXHGz/AfOatFY6mEI448rHKU4x3?=
 =?us-ascii?Q?3X7Dz/i62Rmvb03hXlkxcjR+JQenzX1dOWg0IDEWH015Dw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a994e9-b5aa-45f6-5f93-08d90af640b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2021 10:05:01.1571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8jYXvOhJPwSGf82qj1x+eXy0rsC5AV/wFGhLRaRCm0SwCxsW9kk6NdG2Kurs7B7e7+ekWH5A4buCPgVWeSsho5Q2782P3um8OTeVIWgdUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7189
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/04/2021 11:56, Filipe Manana wrote:=0A=
> On Thu, Apr 29, 2021 at 10:44 AM Johannes Thumshirn=0A=
> <Johannes.Thumshirn@wdc.com> wrote:=0A=
>>=0A=
>> On 28/04/2021 11:24, Filipe Manana wrote:=0A=
>>> The use of _fail is usually discouraged. A simple echo would suffice he=
re.=0A=
>>=0A=
>>=0A=
>> Need to do echo + exit here, otherwise there will be errors in the shell=
 script.=0A=
> =0A=
> Errors? I don't understand, what kind of errors?=0A=
=0A=
=0A=
For instance if the block group isn't removed, the dump-tree call will retu=
rn two=0A=
block groups and then this calculation will fail:=0A=
new_data_zone=3D$(get_data_bg)=0A=
new_data_zone=3D$((new_data_zone >> 9))=0A=

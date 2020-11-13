Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5572B23ED
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 19:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgKMSlD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 13:41:03 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:8671 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKMSlD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 13:41:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605292862; x=1636828862;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Qat3INg+eO3cAJY2mqB8RRMibZNkQifrnbybTS57g5I=;
  b=gHEAKi2SoSH3f+w/W9jQCjpZ+mhzZs8uXnWqWnsum++X9Vq7uI4B+6xI
   btJxq/vs1wukp4xfkE29zHzNIVr3N5qFH2IKiTueTQCHvR3vkmRM3Mj2+
   F5M5fH4nURC50cgTEyvYyIXiQlqrw0crw+PgDaSP9zUWVBy77IufZwd28
   nCJyI0Q22FMU9VZPDpMLLZOjwGZKDhemSoZ6CgXG/B+j1UhMN2RKw8e+G
   yyUmvGoKiieAUvpQVxfxbkWnOJqpLftqwWlT+UnAx9yJMgS4U6Jz7B6K/
   D/DrdJ/4CZpMUYT5G2NNqKM4YMWSs04H98mEoWv623Vewvev660/25UeC
   g==;
IronPort-SDR: KpUaESGAPKgBZuur0/3ekqcgFYN3WoM+2R4Pig5p/h40E5Rkuc9yoq65nmCmNxSf1XxqiL9Dde
 HjOZQ7xbVGnkRp/goBmuxuR3a/KCUIyJKtyQhqIpHjLqPSIlhPFuZN5qDsJQ4d2lqjPFXE1EAm
 03QCFX0Ldbk000H1Q4sUP393Cnb6gIr7+9RP54IDwRprV0jql+6pKlq2epZlaQQuGputKdR6yb
 2ytDpYhrFgXtNhy4D8IPrctczaFiq1FLCp696RL5tLKUHPPnJXAuzmdcQ2foE6FRsqPCbMIHhd
 ZVY=
X-IronPort-AV: E=Sophos;i="5.77,476,1596470400"; 
   d="scan'208";a="152683216"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2020 02:41:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLNT0UraEXKr4Yo9O1p/LLCnlQFa+Yj3zaHsriHg/VjRrTjr/5+67f8ISbMzEnQUmDy6DzACV7I/kh+rfd2oralRHsl30L0fkMgXh4Kwe1sKIFibyAQrvPlcfKPzhW+LvVQZhm5RYcYtyUWQQJFireteSAo2n0mUen9zKVkgMp2SOB0uraNgcaPsNI12Dwv5yCNFuCyNNElUHP+xr2ucSQ8qgMgzGt7JXZPEBO8e47JyabUc2laIdHnxju5TSagbG7cZH0Ge5JHvaZHGihJl3ag0DI3QCCWwmSnI0AlW1jdcOlTsedHN/8zXEeGBbjYNROm8lzZJMYsUITT3Vz2jlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6o+dZbNfPsiW4LmnXIME3Ql5ydnfiqNzgVOJP9TGmg=;
 b=GxOM3Vnm8myNNa5tOTLOjGaoMsjHY+k9PDXbgusYiAG/FXwwNM4yAoDRVhbPcKv9S2KrBI+ke8Igh85dOHxVrn83UrCyqDVnRrFwF+l/T2BN5ydeqZLxMrNPhSbENXBUg7jl5CsBVl4c40KlaEYsEZ13mpfwnWnUJ30kkXb5SxtT3O9xN+QM+SpgtMvyjd39mTM1EfrjlAkyepIMzAwb34FQbUf82x9AS3oeTwLBol6P2HMT5wz5XAOPcL1s6TaTLjyGzdPpf80EdzocDIYGHK2LtvA+QVd/Nz1WbktN/tRR8uLeBWNvH/5qqAyL6nxLhUtLW0tHpBbMu2nQE1ibcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6o+dZbNfPsiW4LmnXIME3Ql5ydnfiqNzgVOJP9TGmg=;
 b=rWYYJvRv9U39RQsfMWdhM7+IYDyZ1zF6Zl1dl8y8hTkJH+YLM8LIvI5g20GB0SCYkzuJPnpMAWhjDiPZBpKb7vFNdDUfO4nELStHgU6pHXEOvRYNy+Xs2YuqjqoPrOq45svkgHwTWnrZwp+XFeE2MoAnsfgWvnpXLr0R66Ge3HQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7593.namprd04.prod.outlook.com
 (2603:10b6:806:14b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 18:41:01 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 18:41:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Anand Jain <anand.jain@oracle.com>,
        "syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com" 
        <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>
Subject: Re: [PATCH] btrfs: don't access possibly stale fs_info data for
 printing duplicate device
Thread-Topic: [PATCH] btrfs: don't access possibly stale fs_info data for
 printing duplicate device
Thread-Index: AQHWuOtRAaZijNInYk+P8NzKw4BntQ==
Date:   Fri, 13 Nov 2020 18:41:01 +0000
Message-ID: <SN4PR0401MB3598F534EF6AFF1A2405341C9BE60@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <2bb63b693331e27b440768b163a84935fe01edda.1605182240.git.johannes.thumshirn@wdc.com>
 <3454d885-21db-199a-76bf-0da6f9971671@suse.com>
 <SN4PR0401MB35987501AB13F33A9498D85D9BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20201113165305.GE6756@twin.jikos.cz> <20201113165741.GF6756@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:145b:5101:50:d2f1:5b43:2e89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 158ef2b9-1499-479e-75e8-08d88803ab3e
x-ms-traffictypediagnostic: SA2PR04MB7593:
x-microsoft-antispam-prvs: <SA2PR04MB75937376F18A84035A6BE1099BE60@SA2PR04MB7593.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P8Ti05DI2Qlrjce0N9LD21pxUu8qut53IUAnGMRoI6ZftCouj0dqgTlTgXwpZ2aTZ5QrhVNAe4Bf96rJNB20AZibvSZ1OFZd60E/9zSDNaLkyyLZaiTBlwi0h2TeWrJ/anuqBGolPdQMqt0/wvMY7IoNtAVo/SkXBI7Lq/VMsgKv6FkXFtueXpK8z2UPVp5d8PjdbGposR6XkbasO+QHRi4ptfyHNEvM1hRmac+bBegI1dpCCscG2wYXH6jcnev+6lm3D0FG9YyZF/c8RfJ69LlnlweAWIobZQlUQO+qqtvS+9cdnqB4sk9I1C/tKoxkNgaxMNvJFQJAas0At7F1Tg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(4744005)(83380400001)(76116006)(64756008)(86362001)(66556008)(5660300002)(66946007)(8676002)(33656002)(66476007)(66446008)(52536014)(91956017)(186003)(316002)(8936002)(9686003)(7696005)(71200400001)(53546011)(6506007)(110136005)(478600001)(2906002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: QTX1IrKM0v8mPiWcsYtYBARjbncyfKwWbY7/cqwyhqk/JcAG+H+pguKlXp0k71JEbPB76dH/zpkNvTuByxpgTAgY8XN8e+4NkKy+jKnAynFMQSsvKHfhLxEf2Ke4JJLbEQRZURxE4aGZwdGIOZRp5hZSEH0OuSHZG1k4L4aOLUAc0wCDWmrqEGnBYXg+NoZ2SIolft9hXPCENbosqOpXymGWZYcwdkLof8gDWJdgs+XhMTjimmELNVckTMh2Z0JtkP6NTeiRw/WHRyPslmyijql6jjdrytCfzrU8f3KLefVQiE/eWbqK67RyyHc7t0Tj5FuiiRdIvLb7w3r3ZwCSvYo1a+Jtp+V8Irl2JqsutIzKbRjyWtXspuOmumd+ckPLOIu9rhssXTvW41GPeYXafBskaWHrtYg31x7nLOG8DAPLrpwZPkzZRSikovxfgLrTpEnyrvJV36fJCnp+Q4EwaOTJ8fXUWVnor6iJaOgObieq0dLsecVZShY/HPCaTAI+K5Q0lG1Cq1BuWXQKXwTpIV6g1qFzCVatGPJhBMxs2CXwMJSkyXsIayC7Dp+QyIdoIUmC1shNoJI4kB7IoLrecjBqe7Y5uRuf8D6fvXkiDCziKeO+6E2ByYlqHUu4u+nxL1B1Fo2RSDq//LHSmdkC1UyCCrQxKB3Loc4eBKW8Tp/JDsA+Z9exnuO+hW9rex7xJUOKOzF9b7RbG1m9vZpNIA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158ef2b9-1499-479e-75e8-08d88803ab3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 18:41:01.0664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMHyeuvmFmqRdcU7Tu56VyGDs/E8VlBnYhnvr7QUhxxMVkG6Kn3z8bzCrPUzQOfX99rUTs9vGfq22Juk3L1MIfAJwI3NG3cLg69Lu7NEgQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7593
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/11/2020 17:59, David Sterba wrote:=0A=
> =0A=
> --- a/fs/btrfs/super.c=0A=
> +++ b/fs/btrfs/super.c=0A=
> @@ -240,9 +240,14 @@ void __cold btrfs_printk(const struct btrfs_fs_info =
*fs_info, const char *fmt, .=0A=
>         vaf.fmt =3D fmt;=0A=
>         vaf.va =3D &args;=0A=
>  =0A=
> -       if (__ratelimit(ratelimit))=0A=
> -               printk("%sBTRFS %s (device %s): %pV\n", lvl, type,=0A=
> -                       fs_info ? fs_info->sb->s_id : "<unknown>", &vaf);=
=0A=
> +       if (__ratelimit(ratelimit)) {=0A=
> +               if (fs_info) {=0A=
> +                       printk("%sBTRFS %s (device %s): %pV\n", lvl, type=
,=0A=
> +                                       fs_info->sb->s_id, &vaf);=0A=
> +               } else {=0A=
> +                       printk("%sBTRFS %s: %pV\n", lvl, type, &vaf);=0A=
> +               }=0A=
> +       }=0A=
>  =0A=
>         va_end(args);=0A=
>  }=0A=
=0A=
But this does not help us at all. If fs_info is not correctly initialized b=
ut=0A=
the pointer is non-NULL we get the KASAN splat syzkaller is reporting.=0A=
=0A=
Just try your patch with KASAN and the reproducer, it will crash within one=
 =0A=
minute. Been there, done that.=0A=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C853B13B8
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 08:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFWGLS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 02:11:18 -0400
Received: from mail-me3aus01on2068.outbound.protection.outlook.com ([40.107.108.68]:8479
        "EHLO AUS01-ME3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229665AbhFWGLS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 02:11:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7Aeja29Njnbz3iTm2zAYT1oz5iiZt5fLuWR9cgSJUSaHPcFqEGdkqBM8GVYaqGOhdRJcBEeCBRcUE3M6hWMLX+qcEXTyInMMyhx08xg+0oDXYaNsmxi8fKvUrE+NcbuMH2IZ4K2AdK1M7y3Ji8HKwNYIiOSQo1PGCSCzxqycSAcrPA6yrMRM9rvM1f0xDSoA5lZgKdmLyy9oxhsBNBa2fMvQGoTGoSLbTSdXqHgiqET9yO8q0EGiU67z9TnMqZ3jy6b574X2QCyDK6N9A7WYcvPVb84EmyUJVHIz+iFPlMJW8AelVqC8WkKwHzmfNYkZFX4wJbpktdVhzWk5m8a1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb0/rfGjg7qRQHEgRg/yapKWUYgBYt7jVXFVPTqHTcs=;
 b=nklnQlrhPPH3LOvpuGUZqodeIGOaN5VuQBe6wuXjcTQY7OOgG0ZoLZJpz7LSObuZvLMOGLb8ZUwybTnn/5p+Ya4eXkyV1hZgOfuKjbukPCzf+H0UPv30hD6RjFjQhvZqgUUjpjQDaW9Rx6oiUwlaUtgEdmQKm8rz2TKkbT+jP+F5ubfhpnQcJtFlzDcj/aPFUrwhEYwh3l5nboDFTzC8AplGYcYHO+gFFLbEcHkzi9SNMOq2289wy92A2um1glTPDX/LiaslxRVlUS8A2C4I507zTDg9y94lAHY3NhhZ5nauFlhiCxVBnNCsNPwINxh+serWev8dYKn7lIUSKX9w8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pauljones.id.au; dmarc=pass action=none
 header.from=pauljones.id.au; dkim=pass header.d=pauljones.id.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oakvillepondscapes.onmicrosoft.com;
 s=selector2-oakvillepondscapes-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb0/rfGjg7qRQHEgRg/yapKWUYgBYt7jVXFVPTqHTcs=;
 b=H1VVFKoOe1F1HjR7KKTPPXYXPpHQNaePF+FQ+DWDYRCfDNhHd1FUKxAhVU+7YNauvoeqaPJHgOzrgyRSU1GU5xYyRD+NXENvtTbsFn0m/2Hqwm6GTYmAogqsfBfJwWCm4NwrdXOWsi5GwV8ZJBVo2IV4zwWnQSaTVzvPb6+kJkY=
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com (2603:10c6:0:2b::11) by
 SYXPR01MB1007.ausprd01.prod.outlook.com (2603:10c6:0:b::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Wed, 23 Jun 2021 06:08:58 +0000
Received: from SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::5c09:faee:58ba:65b6]) by SYXPR01MB1918.ausprd01.prod.outlook.com
 ([fe80::5c09:faee:58ba:65b6%5]) with mapi id 15.20.4242.024; Wed, 23 Jun 2021
 06:08:58 +0000
From:   Paul Jones <paul@pauljones.id.au>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Asif Youssuff <yoasif@gmail.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: Filesystem goes readonly soon after mount, cannot free space or
 rebalance
Thread-Topic: Filesystem goes readonly soon after mount, cannot free space or
 rebalance
Thread-Index: AQHXZMpevWC96VF9tUqaU1trL8NahashGMmAgAAIrUA=
Date:   Wed, 23 Jun 2021 06:08:58 +0000
Message-ID: <SYXPR01MB191839844E7C773F755E110B9E089@SYXPR01MB1918.ausprd01.prod.outlook.com>
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <20210623053240.GJ11733@hungrycats.org>
In-Reply-To: <20210623053240.GJ11733@hungrycats.org>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: umail.furryterror.org; dkim=none (message not signed)
 header.d=none;umail.furryterror.org; dmarc=none action=none
 header.from=pauljones.id.au;
x-originating-ip: [124.171.130.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be5eba14-b9c6-42cd-a17f-08d9360d639e
x-ms-traffictypediagnostic: SYXPR01MB1007:
x-microsoft-antispam-prvs: <SYXPR01MB1007015E843BAEC4A02462299E089@SYXPR01MB1007.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5R0YHOnBIVEDU6zzxB0uyLEiDUVJJbP6EZxYofdZZGwuLG/0OSLNIbtV239+Nn6fXu/Y7Yn3t+1prwNtTff8EJnCepzpRPuT2mzXWX6f0LJrZYsx7mzf2kC6sP/XOAzjLHyXvyanaV+wp8fqu3IWTUlgPXX6V//gbfIuEKXewYPjlTJ8CJzPwT2VI+OxwJc+CnEPgFocNjIW5OfScBjTqf5RaOsYe0yBkIPB98KfuSA4a2gspqJvSmwRbiw5LFmaKHbyR5AYfmsSoiZtiSBPI2QEqONiuwvuhTtosBso3d6ajV/flSb0006926Sndzwh4oI+D4ksrVanmE+sCNKiRSIGbuQEQ/OQ4ZDcyWmfvmpicfK77msaUHck9aswi04wrt7s+EnEOWSH0+h90ibSnbl3uzpIdcXbDB8LbcOtHsl8dJNPVnHudZNKg24YgIVWYc+hIHAIXaFZprXB8ZTzWPWVFiWU2b8efVUoLJqoHpN8zktVAt6f6mrcMZ7A3pOp3jXFulRhCgW6pWr69cw4gcNtLpZgCRI0BIM+PEcOO2ZPbagToHuZ4tsofAhlEZ2ds5ta2WD2t/O9fz8wXDBHoYwdAwJCRFJIfMQixPOXsQg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYXPR01MB1918.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(396003)(39830400003)(4326008)(478600001)(66476007)(8676002)(66946007)(33656002)(76116006)(86362001)(316002)(110136005)(5660300002)(64756008)(8936002)(66446008)(52536014)(66556008)(71200400001)(4744005)(6506007)(2906002)(53546011)(26005)(83380400001)(7696005)(9686003)(38100700002)(122000001)(55016002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rTX6LdzSBWhv++PUK3wOOguCWJvDzHcFHqZrJ8hDYAqtxPMf4VqhP44aW0HN?=
 =?us-ascii?Q?3uYaWeBBufxq5sV96pehPkU68bc7mwdRIvuXbUGpFGaxAZy2PGIiwQ6tAhZr?=
 =?us-ascii?Q?Dau5aBMScngyJJUkEClrJTp23IxnsR0ciVydxl5CVGOygAx/UePJELQb5duZ?=
 =?us-ascii?Q?yonrbWK2pYEqlkUnYGy5YIPn5DPePYwfzGjJeJOYM+KPT8D/0/K1fuHUGZzS?=
 =?us-ascii?Q?UHXD1UDAmdGMf0UP07Oou6+ZKVzAmp0r/NNvUbXjnY9H76BxvHhWnVeICQZy?=
 =?us-ascii?Q?7sihGK+ugZLYRAFe4RZpgNO0dQ3B7X1jOA7G5kasiTq4+RH09m4CYJ8aQviH?=
 =?us-ascii?Q?abmO0mIQY602YZnL12ZVh7uWOdMo8tnpDB8afK0z1dWgTt4eEG9PsMPAZVsn?=
 =?us-ascii?Q?RxVwVo+dE7X+VzMYvwHKE02a5ZI+6p58U+yAhBJMV3IR2jDOvCF7wj2v2kkz?=
 =?us-ascii?Q?ba7PMDfdUUjbiAR1x22hNnbMw7AYvQRasF2NW3Y9RiaovbUYoPTaZO0ko63i?=
 =?us-ascii?Q?Njwn5XE0bKmX6jgDosyK2ZlKnHdy2U+WChymgVEvgQDh3U3e11cW2kvo5YR+?=
 =?us-ascii?Q?O/KpMaW2I5nno/N69c3TzypLsyJXG51AhytXIdgBaulfw3UkO2CIOR4558M5?=
 =?us-ascii?Q?2bxB3od7GQm7Ix7e2fbVz8aHm7KRKB9kKfzJSVN/p0J5y96dbnrYikRImGl9?=
 =?us-ascii?Q?RPhrurXeP5vwb2x94Z55dnf8+PEYl3ETqEOMNdCMbNbYhBB4h6Xf32V1h7lh?=
 =?us-ascii?Q?Up+oR2M10yX7Ip6zC73eGGiiWaayRi3NHVRsU+UZ1CY8RJsWowz5T3XjNEHE?=
 =?us-ascii?Q?k1f2VrG0y0UrhbsNFBY82GjbpUOfkJRY9oWTKaBAlwPvKrXhQrqFG1o+2rZ/?=
 =?us-ascii?Q?JOboxxYKRQLkNnEYCwKOia2H2qLNifj+I4fYkh8OGfh1ehMsaKmhurjVpCN6?=
 =?us-ascii?Q?PewdTbo99u6btiFAofgarYpGP16auqFsCF0CGGBaY178Wu6CgZ0sZBaFawav?=
 =?us-ascii?Q?cX3Joccmnq2fCrGHjiUGB2xUZ7W/lTkhd7HM+mmKpcvpTVJcOihzxLdCx6Tc?=
 =?us-ascii?Q?rcX2kCpPQQtszkxjVlAJ0xIx6pz4P6w/0z0MstmqnWs46o5EMUYM7T5q2ta6?=
 =?us-ascii?Q?XQdJ7fcySS1vOM+a8ZEDIC6GmNg57TfnlsOOi3Pa6LjE9eT0GBHIcfL1px/0?=
 =?us-ascii?Q?wJXh+Hp+FpqoyDWnpsN+ji/hxTYvsX0K1R6Ltx8E2GYS80yUAapR7bQKKWbO?=
 =?us-ascii?Q?3XmyHP3jGQ/kW43DORFZ5BW+6uSXhFybKFpTTulPfkzZsHZVpisCDPgMM7ci?=
 =?us-ascii?Q?GYChNhwtzO47T4EQWehwT3R6?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: pauljones.id.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYXPR01MB1918.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5eba14-b9c6-42cd-a17f-08d9360d639e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 06:08:58.2241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8f216723-e13f-4cce-b84c-58d8f16a0082
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dk5uneRyQnRltfqIzh0qV9FCW6Tu+GnojgmgCd7U6JVCcn2pi0esNIhqTVW3DwOM/Sh0gQIawMV1C2YibjzrjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYXPR01MB1007
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> -----Original Message-----
> From: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
> Sent: Wednesday, 23 June 2021 3:33 PM
> To: Asif Youssuff <yoasif@gmail.com>
> Cc: linux-btrfs@vger.kernel.org
> Subject: Re: Filesystem goes readonly soon after mount, cannot free space
> or rebalance
> =20
> You might be able to recover by booting a kernel with a patch to delay
> startup of the btrfs-cleaner thread, thereby preventing the snapshot
> delete from restarting immediately and breaking the filesystem.  I haven'=
t
> tried it, but it was my plan B if reverting to 4.19 hadn't worked.

Yes, I had to do that and it worked nicely. I don't remember the details, b=
ut I just commented out the part that forced a RO remount. The cleaner thre=
ad would still run and fail, but at least I could add two drives to my raid=
 array for long enough to fix the problem.


Paul.

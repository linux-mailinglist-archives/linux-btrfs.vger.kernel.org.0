Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFBF4C610F
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 03:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiB1CUf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 21:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbiB1CUe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 21:20:34 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F596C1D6
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 18:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646014797; x=1677550797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VYaxAqHPeqasZSIo386rcvs3xNUjePaqGyxRv9iwDNI=;
  b=ferf43jB8qtE5y+jd59EPgB+dGXGphNAcYZfbJJggzpzxwgJ6+vK9on9
   aj02/gNsD9TEmL9hYYdNSl1KI8F18jEXiWucz6m8K8kpCg9e/hFgzbzjI
   ylgnyCoOUNscw0W8Pn4suswYZxo6G6Zf38TPrj9zXN5i8Vopg1CP/ApdB
   dL4NFhkBnZSo7p6uL8799S9kvV+c39Yc7epTMRg5sZBanwjjehBZJ2j6j
   PF48vUMYPeVIcEcTQX2dgmR0wmRyBWbrKu2nWTXogwb02tn6fvYWnPdGK
   9QGDTt+2MrZNHXPw4wwZVaWggRHI9szegKh5LI8geTbPdQHwCO9SsUmeX
   g==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643644800"; 
   d="scan'208";a="195037425"
Received: from mail-dm3nam07lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2022 10:19:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzLnyYZFpiqlkPM/p/Yhh21Y7FSpx+QMmsp5UxJM1nJUGSy+hj83W84ng5c9j5Emx8LGpE7Bm1MhEjJrtz8868IRuyPPvD5mLqrEmFx7r7eaniHI2oh42ssY4Q29e0I7w7gZ7jOwz1/7tTEfqR2yWmWGb4D9rCjJbpPxaoOr26ug2JzpBrve0McI9qQiZoANJkICbaZ1z7MdtDKFkjF8jyNJfXnEMA3DHegb24yfuQQ21lj7tMFxlnLSTpXUWmhkUahtobYWtQDkZKdCpNZxSaa4AYObo7wydLhDgnXWOC39RctDb6Y1lmoajMH4KEMHHw2qoHBwinNaWSq6jf6rQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpqVflyAJhAOYGJBsO/J0Dzjl17LGDSgC1PBihKeZCc=;
 b=KnkG1JgoMz7zZ3ZzKVdgtPA6dY4SFmLNDjXTXjet5y5k9PkJOZER0wiqcF7RHI7dI9/xZZM48uI/3y+G77kI8NXGAtgcUSTLX7X15oUaz9Og2WEAosudZL7/4Yah0eZZq7ERYfXqIIeFsi1Fx3aiGpV6BhEFR7xO+evl77eAfscWrwM0lxTfdl7Mndb/IDvLhuir9Zwp4D0R3pl9wGIHsYvGAEXRaOXCgCKaTCajXpDf8vheuaGZf/x3kWct4YGLbEL47Y5xIho6chjRlmDrguQDfXA1EQtzuH8hJ4znnAORd16mNd5Bsc30sXGA9XRe/g72C4+UX1XkgYazmbC70g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpqVflyAJhAOYGJBsO/J0Dzjl17LGDSgC1PBihKeZCc=;
 b=UfU/4esNyAcEnRefYy7rmiugqTayzMdKYI+E9y/D2ux5eTPLtdSKHw2FmlFxXfsbONa1S4gOlZNg2pAj2i2SlNaGTrRdNcaK2BKt+kkKpEEiJxO4iLngJT0Y5hU6qXQeIjFeaUtE/0e/mfvgH3mRBbkzkL6OED0LmAe/wzGHxjE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB5436.namprd04.prod.outlook.com (2603:10b6:5:104::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Mon, 28 Feb 2022 02:19:55 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b13a:2b9b:b0a2:d17]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b13a:2b9b:b0a2:d17%8]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 02:19:54 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sidong Yang <realwakka@gmail.com>
CC:     Filipe Manana <fdmanana@kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v4] btrfs: qgroup: fix deadlock between rescan worker and
 remove qgroup
Thread-Topic: [PATCH v4] btrfs: qgroup: fix deadlock between rescan worker and
 remove qgroup
Thread-Index: AQHYLESx6VZOcyiJXUaOTZPJZJNso6yoOs4A
Date:   Mon, 28 Feb 2022 02:19:54 +0000
Message-ID: <20220228021954.daq6lf65pycax6et@shindev>
References: <20220228014340.21309-1-realwakka@gmail.com>
In-Reply-To: <20220228014340.21309-1-realwakka@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5d0bd10-bee5-4e6a-db22-08d9fa60cf30
x-ms-traffictypediagnostic: DM6PR04MB5436:EE_
x-microsoft-antispam-prvs: <DM6PR04MB5436266706A586FD068560EDED019@DM6PR04MB5436.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NXYMxqCCYGe52QlEFvMMWiFXUtYpkzMaaSXg7xej+dfOHF7ZZiTPW7krv4V+Le7gMNJdAaeAoSHKkdAanuBwWn+v1Ew8BUnj9uZhbM56gr/5jf5Kb/A3yQnkX/8JJ9Mses/nC1YnLRahfUpef1cvkoCkzPI711cj8OpXKEB+NHqqUX3ma2a/0NZuhSxNvOv3UELuGl5i4H4jeo8AjxgC4AEj7O5L7IjovTkHMP15wKgvAQP5XDvswWtjaKDhIj2lYSJpOUtOUVnw6CNILtqF7bMErii319+gIwjWT3Kvk7uCYvQ4oMHwMT8P+775DF0aTamDHt5HpOeqGr9c7lJXAc2Xu9Tuqkp0OGGMQ5z+uswgb07gYc5epw/iUKt2GC0S34jiatMCes6KH010jBRSagU1zwWYXHxXUd/pKZENaBYqk6Nu2sQ35LI4MnQyUTLXfDZUmqctL/O2dZoTSQHcWBNAzNxsE/INuB6kvl5hy/OkENoK7E7do6XCJT+VBcXsGlBofM8HeADE8z59W1k1arsW/OQ+22oB9KF9/tIm2vVwenumDhUvhMMD6mJrznyBHrjiQ2ZRBUj3T0Rk5jdKmtWOc0A45iYSfK/oK+HvfybRvMdhrgzYI13BE3WqfYjqRkYLCbfn7C8qvqPkNz9k/zchnr5IQkubSOJUmGFTtlS7bQyVX51b5U8gUYZ+d4dlwcbpjB+46R5e2StqLVSJ0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(82960400001)(44832011)(5660300002)(86362001)(8936002)(38100700002)(316002)(6916009)(122000001)(54906003)(91956017)(38070700005)(76116006)(66946007)(8676002)(66446008)(6486002)(71200400001)(83380400001)(4326008)(66476007)(6512007)(66556008)(6506007)(186003)(26005)(1076003)(508600001)(2906002)(33716001)(64756008)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i56uYpii8teKmNoP/iCtMXeCS8KQxqQAItieDCCMtGPEsqUDfpcH11VYjM6G?=
 =?us-ascii?Q?SSkhXgALQTfUV1W5hH8KVQmiOfrxDdjAE2QwVmA27uFWv0uXNAl3AmCSjOFM?=
 =?us-ascii?Q?etZiwFTW/hfxgnfpt99uDBO9+EV2R84EUm2GhvkBaSzX4qFjU1LcgTmGeO2H?=
 =?us-ascii?Q?FGJzMZQONJAH3QynmICDUffuaS8F0oW+WzL3t5hOjfYqINF3f8wgBa5d8+vb?=
 =?us-ascii?Q?rIQL7Q0d0b7sVtQVfUEUDeyLS+6KCKDRynl0MewNvaUQPvxIAOWzJhWq7Y4v?=
 =?us-ascii?Q?BBPUu59Vg2k7DOwsvVjQfnpxoE6sfHQawritWUlKoEFv2NEHigxSHRpWFOyJ?=
 =?us-ascii?Q?6dQWuerbGFIH4zUt1VkBDYXGTIkRFRHCdEovxYXk1/rTXXk/+u0Ps1w+OYhD?=
 =?us-ascii?Q?ubShbBp0Jem3ieTCtjvEJWxB3IoanqDzOuXFI/gC0LHvQP3jcLY6+1mO8UI3?=
 =?us-ascii?Q?6+vFxXCrbsttQLgZ6q4QvYs3oCSkRexKENYVWfJGXG/VMKh6Vn2xju/sKUjK?=
 =?us-ascii?Q?gIbdEu3zB84hBi6BeXn/D3G6frbuPbtfLANjxCX9+YG5DtiiMUgzpL3RI4X3?=
 =?us-ascii?Q?9+Xy5V72T6Pz7TN48sa/9IaLGlO0oFzSVwZjk6fplerHvV2ZxkgnziTcCA76?=
 =?us-ascii?Q?1VuOpdhgGoNX/VsyI5DWpGu9qiB+Emzlbs4ZuRCd2+RZE0wZL9soBT749HiL?=
 =?us-ascii?Q?LVQjeh+xpJxBGYWBdUmup4HJ/yyygvnqxlCrXy/Jgj+ofc6B39FRrtZxtt6J?=
 =?us-ascii?Q?noY+Y+yZ32KQ1I2cPPVM1VvsczWo+bejzSskRgAsYL5EY5c8Ufcs/Ca/FzsI?=
 =?us-ascii?Q?bcLeqqgsYBFYoxvge4W50i9X4VASlpzGUN330ZBrpNoSmvi5M428HZmNMUws?=
 =?us-ascii?Q?myttRKeYYb5O5oVw//t4CAPvhTiK5R/IWF+kX7EvEmjp0IQGBiNOjqnkb8Pi?=
 =?us-ascii?Q?FHNaMU7nV0yzKErGYSWlhkBh1bFsYZ6Q83O0+qRYH51IBJ5uACFgfzP5C6My?=
 =?us-ascii?Q?R0kgT3lWmBAIciq9yW3tXfBO6lbVwDdS4HWTw3gpgsrYcpH8tP+UtSzojTQm?=
 =?us-ascii?Q?rK/m7h5ZiNNv6wVZxz7QvKJ7p9sr1SkOp929EgMWJ9w6QdUxoccxOyDRxisK?=
 =?us-ascii?Q?yLgtsxxbE89s1SJudstlmcK1l/3QgqUeVNjXW4EtzX67JrCBPDq9NDQNxbWd?=
 =?us-ascii?Q?DtS67NyKaH571LYupS3d7ysp4neP8X/xUzJLvxPfTgKTAlsZ/MoINPra/h/n?=
 =?us-ascii?Q?8B0gahpjVAu5JtCI5q+b+Yn3+NAW1v8QE3Qn+pnJqnv0+O70ZLnNU4cExnx2?=
 =?us-ascii?Q?qkP7dbPg119mIrUhSAqHeXtFReWbxjvujv/6g1DckqHfFfKhf99fIq95thhs?=
 =?us-ascii?Q?5e/jkvvd1bQKiCRMQxB9YTVp60lFIhCPc6QDd0uKHyF8GV2n54TUEx4LVdoq?=
 =?us-ascii?Q?mNNrcPVHV3Qe/Dwad1VKu9SglYnP1yphEzbKY6kKJT/Y+bxJEuoJrdys29Dg?=
 =?us-ascii?Q?QTzdFXfwlLDkFQT/WOKImKhHtkYCj1z+nTdhEGNOMZfoIeN9lRYxDCAge3/p?=
 =?us-ascii?Q?oVP1aIrWFiz+o9dFQwEHZxBDJ0pS2YQ8lGSBBbwkl92eQFepxrH4wVa5sAk+?=
 =?us-ascii?Q?avdJAK8xPiWSx6swruJUq89flOWUBCg7wxker/Y7Ga9Bjt0K7SFAf14IThWs?=
 =?us-ascii?Q?b85BbqlvVQkxHXwgfPH54PMd/Hc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <77C5A8E49A88E845845BEBC1B4EB5878@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d0bd10-bee5-4e6a-db22-08d9fa60cf30
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 02:19:54.7651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k7s9f+Auegx57WPH/+f94yooQlNqC+mMBC1bBQo15Ml9qMnDeFJ0i7JrAD00fdHFIhar/n/cUkqYhhu2+/YGhRcqypZ51igjcQPjj9CNEvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5436
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Feb 28, 2022 / 01:43, Sidong Yang wrote:
> The commit e804861bd4e6 ("btrfs: fix deadlock between quota disable and
> qgroup rescan worker") by Kawasaki resolves deadlock between quota
> disable and qgroup rescan worker. But also there is a deadlock case like
> it. It's about enabling or disabling quota and creating or removing
> qgroup. It can be reproduced in simple script below.
>=20
> for i in {1..100}
> do
>     btrfs quota enable /mnt &
>     btrfs qgroup create 1/0 /mnt &
>     btrfs qgroup destroy 1/0 /mnt &
>     btrfs quota disable /mnt &
> done
>=20
> Here's why the deadlock happens:
>=20
> 1) The quota rescan task is running.
>=20
> 2) Task A calls btrfs_quota_disable(), locks the qgroup_ioctl_lock
>    mutex, and then calls btrfs_qgroup_wait_for_completion(), to wait for
>    the quota rescan task to complete.
>=20
> 3) Task B calls btrfs_remove_qgroup() and it blocks when trying to lock
>    the qgroup_ioctl_lock mutex, because it's being held by task A. At tha=
t
>    point task B is holding a transaction handle for the current transacti=
on.
>=20
> 4) The quota rescan task calls btrfs_commit_transaction(). This results
>    in it waiting for all other tasks to release their handles on the
>    transaction, but task B is blocked on the qgroup_ioctl_lock mutex
>    while holding a handle on the transaction, and that mutex is being hel=
d
>    by task A, which is waiting for the quota rescan task to complete,
>    resulting in a deadlock between these 3 tasks.
>=20
> To resolve this issue, the thread disabling quota should unlock
> qgroup_ioctl_lock before waiting rescan completion. Move
> btrfs_qgroup_wait_for_completion() after unlock of qgroup_ioctl_lock.
>=20
> Fixes: e804861bd4e6 ("btrfs: fix deadlock between quota disable and
> qgroup rescan worker")
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

Thanks. Looks good to me.

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Best Regards,
Shin'ichiro Kawasaki=

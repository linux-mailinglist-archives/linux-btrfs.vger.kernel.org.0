Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E5938FAF7
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 08:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhEYGeN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 02:34:13 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:54752 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhEYGeM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 02:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621924363; x=1653460363;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=P/0JRK/zHbNpz7oEzZbcgBaxyyYM6R8N3uaoafzAPQA=;
  b=eQhD19Q70YgxvsNrmTUYpLTfbztXRG8dOHOUmCM3LbfyqHCAeW/Cm/9E
   V0tBImWZPlc6qYZukpHD03Z+x9482kD/ec9NC3eShd9AvZ2+qMRR023K2
   ExPO0V/4sD9p8Bm44WTNO7Ohz/S9WGHNYMZ6LedQ3+vUdH6oHdZ/oZR5Z
   T4TfAnXzHadn5nFybjEb5umLXtm22rY6X/Zn/Zv8d1rhcb1VIUqvbjDfE
   XlpHQ856eBRj+flgxe/aXOjCjM5jcJVYyatQGeJkrTMmWbi87hsKj1twK
   jJ4cS15eU59Wu4k+zTZyFsNCwDqcidnj5HBj9gRvyUYt8pjxBxZOgbLnc
   Q==;
IronPort-SDR: BVtQtZYajZayxTUosm+kOV8iR/JyutzYiqino9eJFxcE+v0hcLikUdRtzfSa+LZdI7BqOc+Uvx
 XUui12PeooPmqUdQrsTPibCJoiTp0tp9Wj7O/3iO6IFVItFoCv3DmifT307udrCtfmsHs1hHZJ
 EfuK0YmrMluLZrFEajsM9IpkXX8wvNXygp+gwXBrW1lybqKVd0gWB2W11A6DAzCLcL7ldtvu3l
 iBq4yjd9Icnu0HDTf7M3KEHI4EKThYTDPFvMOwUlDBavuqdiydVAm0q/ilO9cQ3RCTFaKI6Pos
 i70=
X-IronPort-AV: E=Sophos;i="5.82,327,1613404800"; 
   d="scan'208";a="280623073"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2021 14:32:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e45X1wJPdlkP0Gt0ldDJo/KdflaOhQ+a8fi+6jTaTu8adYxBrZlOcFgzpI7duU3NYcELhmj5r/BHbwoRUuYO3kUG0DQnRPEA84AOPfIsdI57yov1HRTAy1IPhWMKlePV8BktqzFGtSYTeB0OUnAxXT9ZQtFPW77GpP7+i2j0RMAbCXQysbCjChXR2/r6aV0/4IB5irIwn5sR6N/vObycUWKkYkWD9AZXMaxza44KfC4GowZfMokz0yt1/Zmw1pDqiCgb+gybJLQk5XlZ9MhCKtAUyfD4PklpCsseXq7O+OX8Yoyw9x+o59f/uFJ1WNEMAomehuC7AZA9g0VaBTObXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4STYudLIYsnF3HLmIhIWn1BOT/rUSMJNaTsfl+ecCP4=;
 b=ntS28T6iNM2k9kp97xr9K4+0O3Ps4LXuFLoH9qPBPjiNnyrpmrOgDzuU4uLHfwlZO2cXXLT29fZOUhBxtrg2bIqbUoIokSZOsBdLHSziMjL5E8ZG+HWbu1LMnQf5eCyUkTJgfvOhjkucRib8+NA04Lr2plB0SWHXNIb2/8uShZBIXjYEDOsYBTDyLG/yunTrA+fJlFhwq9X+c8k+x2xKqEgYCxIbbNuEmSzpqCFVuXliU6UAZzpVWSlP2ecBKkqhadyJXYzhf+ddC+NMJFsGtKbSV1Vwd97A59npCiVKR3TrPChD7Dcke6RwPKJ8MUHHXqQ5lRVyNiCegwuunYIO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4STYudLIYsnF3HLmIhIWn1BOT/rUSMJNaTsfl+ecCP4=;
 b=pV9YFOIukvUzwpCnDmAFMHNu85nSi5vP6xq6Ug6fbzZq0kA1vhp+7aoIKpH227bx5OBuZW1s7IBrCgM/DeEN0UoGlFixsEA6yoqxcXFxFaZ+RHE78RVp3FiLbmcswC0be9CJEe/85obX9RjPTApva0lmjYccQQZUbUUiB7PqCXc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7176.namprd04.prod.outlook.com (2603:10b6:510:c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Tue, 25 May
 2021 06:32:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 06:32:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs: fix a bug where a compressed write can cross
 stripe boundary
Thread-Topic: [PATCH] btrfs: fix a bug where a compressed write can cross
 stripe boundary
Thread-Index: AQHXUSo0J/0S457n7UiBT2alqMw1PA==
Date:   Tue, 25 May 2021 06:32:41 +0000
Message-ID: <PH0PR04MB74169FD52F228ABDB4B052779B259@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210525055243.85166-1-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38b08630-1f7d-48a1-d98b-08d91f46e601
x-ms-traffictypediagnostic: PH0PR04MB7176:
x-microsoft-antispam-prvs: <PH0PR04MB7176FFB11DCAA94E4E0317A89B259@PH0PR04MB7176.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KN95gvklhiZIhXRiNe/0yVzV7iJyn2DdWvNr5BTFZnadaVtv9EDyTL2Z/2bKRLJSKbP0GFoQlL46m9bmHiPuqMp2njw9cmvGAJFIwB4fzSiJ5modie+g0ulzpL1fl8eKBr2dD74H9K+0vsydCdOJMAK8NY5LDkZBR5J/Rk6CEpOdm5TMRsyfQQpO2DpV4pH+fdzOrd6sUm6oEdpsoKrSM+c5187p6TBUy9t8lrQEeCGynp/5/sh90PyJnbqJtQUUhaFYDxed6W+VGBuQbdkYksgobfGBq+4NXMz1UA0+PQgEuC20rg9LHvV1BCFTIC2fvCTvFVBLSdvlCVGjZQDJC5SdqQE/tjo9gztF2V3teycSuH9wLOwy/cIeMdigkMb46ClglLmC9If9gYWf5DOJl4FIfFSKTu4UNjrITe+E3sVxPqfMdKzjODX3csf4IxAIYqyJ3xWXg1rWNxc42l83CKF2avNqJN1Er1Z1924sgXRLqt7IkvepKXUjqmYCPytHNxO4Ig/6FFH8jNfK80DG7SWzxDPPZj1hIw5Jid15EF6s+u+gT/HuwMjY2NRzqRhgeDe/UrAgviwAAiZjOkP/9LkYTsHBVC7fOAXsCQZVONc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(38100700002)(71200400001)(5660300002)(4326008)(8676002)(55016002)(33656002)(8936002)(122000001)(86362001)(186003)(76116006)(83380400001)(91956017)(53546011)(6506007)(66946007)(478600001)(26005)(66556008)(66476007)(2906002)(316002)(110136005)(52536014)(9686003)(66446008)(64756008)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AWcep0S6JGVL7uiPdtKQYm1ZWOW9EwCHY0GD9HMPQAXawmiBRaS9rF/JF102?=
 =?us-ascii?Q?3lmSWe6krGAzud38r4NWZDuci+xUCycRleYgFHw0Yh64rvTSedZkuSAjGMHS?=
 =?us-ascii?Q?AMPFfWhAMhTzhjj/FMQ8ZpFb7c1dpee+WxK1RE+ocpMbMX11nerevPUDlUXj?=
 =?us-ascii?Q?wYKKc7bOyTTwWxi6+8XUZtfdSB+DdEroCiW6So7fSZASqwElej/futKHHbUe?=
 =?us-ascii?Q?5MDeOYP4nn3dUxNTEHv2RtqItxV7ud4R0QEfgKctTF7BxNKl/Y+ezd4Gjiyi?=
 =?us-ascii?Q?T50Tc6InLgwEavymR21zh6+36Vv5+W0mybc2Qk5zNpCFdg9F3+iKrc3yIZ8z?=
 =?us-ascii?Q?DqH9pDm7d2xsMyV6kzlmQU9/KyLZiOyyD/WKY+MC0r1L8+cxqoknGYO3FzhW?=
 =?us-ascii?Q?TPOxZ8yWxih1vzWKk4kPwgzsg48pgM1y34/seYpOe9obCFX7gbX0k+hhdSDz?=
 =?us-ascii?Q?Fs5q+ngMtY1OWPVbg1q16bBn+MatxYRck2OIgtuGz3KeQV+lRDsY78lMP+TZ?=
 =?us-ascii?Q?5olIayBZTDVmtRefEPyqflZ8mz5ZaFcAlhD3BzBzCo1LCUWOA7K4bXGN/5HQ?=
 =?us-ascii?Q?G6RPrYY4uobQAKp8Y0JNqF8XnRv3xHOKZbZtKxYpGVWxXC0gWScfVCUTGstI?=
 =?us-ascii?Q?t8sycqLoML3nGsHt3t30cHT08/D5G/GNiV1MEiKLgq5zNnu8ALq2Y/GzWg8U?=
 =?us-ascii?Q?VlmV4X8RY4AVkoXa3dLZrB365Wo3o0w69/fDRLG5oU+n1N9qWNnvgBldWYF9?=
 =?us-ascii?Q?3bVeuVOdPLCMEOjEJYpZW/C9+SI9TgyBGU+K5/Iuta6IV5niuBaPmh6KHSix?=
 =?us-ascii?Q?HU/ScnOmngCMBFtznfa0h6oS0MyvCLhR63eYqT6jVKriMZHe7BLLI8MIDpvO?=
 =?us-ascii?Q?4dkw1ounXAcmeiSdDEhpSE9GBgig4EaXWQ8b06byEp1Y+OQavTdcITHGT6+r?=
 =?us-ascii?Q?tzrP9Ba1zuQkTwLpAsG0WczEVAwG1ke4AlzQsfIXqCUm2fvRe2ZVn0JmmUEq?=
 =?us-ascii?Q?Jyr/eaZSxSF0wrT+SQfGdX53R8dzxsGZ0nGmxwoGcJWgJhy6AXnnpx/nxo58?=
 =?us-ascii?Q?tCyo34tkB+opDMCmtEibVU7AQ51W52FICTM+g1/RWDEZqg1ba/in8KWHtAmV?=
 =?us-ascii?Q?+p/shFXh6OyNQiPSCCbk+Fgbr5EbaEcpgvDJBFbF3fDA/WYfPuORuYADf+0j?=
 =?us-ascii?Q?iPAnF4BBU/WGnPo01lpQZxDGRlR17d/DM9osfVt8Hr+pnaFLalhtmikI/dV2?=
 =?us-ascii?Q?TchHaX7z3p/Um5LKiKM6zW7AD4XuZMzzBbazc6r1i7YCJWykenKEj4bNMC5J?=
 =?us-ascii?Q?Bfaut0p6XI2KEpSPcF5ppWPKFWOIbFvr5Xng4lYM8HRkoA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b08630-1f7d-48a1-d98b-08d91f46e601
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 06:32:41.4985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FArbLLvNK8xjv3giGZ+7M3bW9Vj/ToK9nmY6GUu92jNCa7w6k6kucwGUn2c9f42epWoPiYjO2btNt9hfFyrNsujZTyemgCubvIep5v9LUsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7176
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/05/2021 07:52, Qu Wenruo wrote:=0A=
> [BUG]=0A=
> When running btrfs/027 with "-o compress" mount option, it always crash=
=0A=
> with the following call trace:=0A=
> =0A=
>   BTRFS critical (device dm-4): mapping failed logical 298901504 bio len =
12288 len 8192=0A=
>   ------------[ cut here ]------------=0A=
>   kernel BUG at fs/btrfs/volumes.c:6651!=0A=
>   invalid opcode: 0000 [#1] PREEMPT SMP NOPTI=0A=
>   CPU: 5 PID: 31089 Comm: kworker/u24:10 Tainted: G           OE     5.13=
.0-rc2-custom+ #26=0A=
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/20=
15=0A=
>   Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]=0A=
>   RIP: 0010:btrfs_map_bio.cold+0x58/0x5a [btrfs]=0A=
>   Call Trace:=0A=
>    btrfs_submit_compressed_write+0x2d7/0x470 [btrfs]=0A=
>    submit_compressed_extents+0x3b0/0x470 [btrfs]=0A=
>    ? mark_held_locks+0x49/0x70=0A=
>    btrfs_work_helper+0x131/0x3e0 [btrfs]=0A=
>    process_one_work+0x28f/0x5d0=0A=
>    worker_thread+0x55/0x3c0=0A=
>    ? process_one_work+0x5d0/0x5d0=0A=
>    kthread+0x141/0x160=0A=
>    ? __kthread_bind_mask+0x60/0x60=0A=
>    ret_from_fork+0x22/0x30=0A=
>   ---[ end trace 63113a3a91f34e68 ]---=0A=
> =0A=
> [CAUSE]=0A=
> The critical message before the crash means we have a bio at logical=0A=
> bytenr 298901504 length 12288, but only 8192 bytes can fit into one=0A=
> stripe, the remaining 4096 bytes is into another stripe.=0A=
> =0A=
> In btrfs, all bio is properly split to avoid cross stripe boundary, but=
=0A=
> commit 764c7c9a464b ("btrfs: zoned: fix parallel compressed writes")=0A=
> changed the behavior for compressed write.=0A=
> =0A=
> The offending code looks like this:=0A=
> =0A=
>                         submit =3D btrfs_bio_fits_in_stripe(page, PAGE_SI=
ZE, bio,=0A=
>                                                           0);=0A=
> =0A=
> +               if (pg_index =3D=3D 0 && use_append)=0A=
> +                       len =3D bio_add_zone_append_page(bio, page, PAGE_=
SIZE, 0);=0A=
> +               else=0A=
> +                       len =3D bio_add_page(bio, page, PAGE_SIZE, 0);=0A=
> +=0A=
>                 page->mapping =3D NULL;=0A=
> -               if (submit || bio_add_page(bio, page, PAGE_SIZE, 0) <=0A=
> -                   PAGE_SIZE) {=0A=
> +               if (submit || len < PAGE_SIZE) {=0A=
> =0A=
> Previously if we find our new page can't be fitted into current stripe,=
=0A=
> aka "submitted =3D=3D 1" case, we submit current bio without adding curre=
nt=0A=
> page.=0A=
> =0A=
> But after the modification, we will add the page no matter if it crosses=
=0A=
> stripe boundary, leading to the above crash.=0A=
> =0A=
> [FIX]=0A=
> It's no longer possible to revert to the original code style as we have=
=0A=
> two different bio_add_*_page() calls now.=0A=
> =0A=
> The new fix is to skip the bio_add_*_page() call if @submit is true.=0A=
> =0A=
> Also to avoid @len to be uninitialized, always initialize it to zero.=0A=
> =0A=
> If @submit is true, @len will not be checked.=0A=
> If @submit is not true, @len will be the return value of=0A=
> bio_add_*_page() call.=0A=
> Either way, the behavior is still the same as the old code.=0A=
> =0A=
> Reported-by: Josef Bacik <josef@toxicpanda.com>=0A=
> Fixes: 764c7c9a464b ("btrfs: zoned: fix parallel compressed writes")=0A=
> Signed-off-by: Qu Wenruo <wqu@suse.com>=0A=
> ---=0A=
=0A=
=0A=
Looks good, thanks.=0A=
And sorry for breaking it.=0A=

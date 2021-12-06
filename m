Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE33468FDC
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 05:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237228AbhLFEhU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Dec 2021 23:37:20 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20122 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237190AbhLFEhT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Dec 2021 23:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638765230; x=1670301230;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rP9yk73TjFWTjk0SqGjSeMEuPGCBxI1nAnySy0tG2Sk=;
  b=ZGm7b7ccP/h+CrBA42tm9BC+A/6PPbg6AC+cJNS9XQNkLqEB2aEtHJyG
   7z1GobEBJAHATP8PFNLJTNUGsO15Dbevbmv74DxW/SmDuDn7IZjsuFgBd
   Fppxzd+3fmeqEy/dXa+hCeAMLYHuIydtOx/7Cjnyo4BUvGfAf1uBCRzUR
   5B1mbbiIl0LrTB48mqBSVwgvPrLhM53f4GIij/VBJTjbkrlXiIag+Jlfi
   OEe9Mn/wKfKmAu27U824uknfkJ/1KMQkwiShAnp37S3bzJe9kvkZgLTtE
   Yz5b3op0JzIPy0Mvb6fomN/WowX4X8+1NjsQN7Ai97Yidc8x7ah9dcxoI
   g==;
X-IronPort-AV: E=Sophos;i="5.87,290,1631548800"; 
   d="scan'208";a="187530016"
Received: from mail-mw2nam08lp2177.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.177])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2021 12:33:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iA7/c0Sy6E02Q2Ob3alpa3Ruwnyi1C2yGDhW/Cyi3H3NB7H16ZcjlxVI1XqF92IsNAw+P9FXl0elNy3ZhqF/NDtf8SzS19k/SYDtCIxMZvsKg9YII0nn0+91kmGgcb5gyVkYNd6zEWctgn7qr1W3jIyKrv/xVTpVe4H/SW3zEozDv0AugmweB9GRc6l9l1AF1ZzYKuMwb7Q/kBgsK9ifMmAD5YLptFL2LHG8wUNQUo4pJeGv3vTuulG6QqY0hxYFWHyYVT1Sb2Yh5SYXx2PJFV5MLnxbGiMt4Q8ruENo2Joo2DDhFCRXGfHBqwuvUxbQa7IjYUbDdQvCtDsLATJAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOcLlxYRUlJzAJK8nDeM3AP78VinjyovaoisC94c1VI=;
 b=VuN3dctsuPtKdB62WB6ZjgA+f6WDUaDNZ4TPhqrNwl1UtNNHY0aDkkF8k/AJp55zn4/e3zCgq19r/T8RrqZHuZWoGOQ5I0Apwz/M0e6e7g/pyh2y9hoie4c9z4+O7EgTEC6CLQAK3My+E49zx8GdkxkCDg5PrAf2bfbrqxotTOAgKUKBZMhaOJv4xV4f+tDxO0KfWWQML+JSKbqu7ewqRq2DuWq+dznbXbmKvnqjYzgaAbLQll95inqKzuDR0oqibha6USK7PU+HcL16RUHxKSh0idHmlweAmKD3yseqSkZ2n4F81fuxp80ab5ZEz8VxVX3BFSjSvxm/8k9EKhSsvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOcLlxYRUlJzAJK8nDeM3AP78VinjyovaoisC94c1VI=;
 b=xo+3a2dYD3p/wU0M+5X0Z/c8DGpLc3sI9a5elvj3bHJqOH4Wjur2s4x8oK5XbHUcL0X3ByEQ6ZHWE9rOuncMR+DAp5wANQ0YJtokXFXfQj47DMYFWFhqbDuufraaYve4tn+TGu/wbMkYTGloR2S1kuLCOMvdR/Qmr2xghgBEScI=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8231.namprd04.prod.outlook.com (2603:10b6:a03:3fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Mon, 6 Dec
 2021 04:33:49 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::4d43:a19:5ad0:74ca]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::4d43:a19:5ad0:74ca%9]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 04:33:49 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: free zone_cache when freeing zone_info
Thread-Topic: [PATCH] btrfs: zoned: free zone_cache when freeing zone_info
Thread-Index: AQHX6Datl1TXqb2vXUO0pElUbUJN46wk5H4A
Date:   Mon, 6 Dec 2021 04:33:49 +0000
Message-ID: <20211206043348.bwpxodhx35cu6jye@naota-xeon>
References: <2dbe65bc10716401b0c663b1a14131becff484dd.1638529933.git.johannes.thumshirn@wdc.com>
In-Reply-To: <2dbe65bc10716401b0c663b1a14131becff484dd.1638529933.git.johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 71315c91-48cb-422e-1627-08d9b8719986
x-ms-traffictypediagnostic: SJ0PR04MB8231:
x-microsoft-antispam-prvs: <SJ0PR04MB823114CB2D654BC1AC8DF3938C6D9@SJ0PR04MB8231.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ONQX+CmQqCil/TUpb/fmoY7tx3oNd1bWclORj/AbZj4R1GEWCq0Oi1nmOg0Cdw3dimxMHmSRZnSgNQbQ8W/B+iHVE4s86yHuTs2AUS/cJYAl8vF/T4wTmUZMPnDHffgC3S2C8aQOejbiIBNPcvFjiZICpSSC9OqoQxbrfwgfvd7r3LBiytHeZNm7Ni1+12E8y8qcf2Y1jDiFZ6nwCOnSqHjeRCLJAZX+dGDyNWfYszbzctF4YycotHP7IaS9iHJ/MoOdlPoF0mCw/5ve6e1DGJ65uX62JnWH9dsmK6K/20fFfKF5RoKmh/1+3zb7krYScrjFKxhI7Kk7R9yD74oatb5qYFUBloteU9RBOaUN9hr8XYhtdubNtcEadYdLfYRoBoIumYWhKyKgv5rYfPX0ZzpSsVnNGv21u7WT0Tu8DFMqHOxShfwo0DU6mhVvvRY7g+wUyenf1loAKt7YRyHg9RmO1VQ0Fw5qnyV3yW8wMXR2TbHqfPq5zs8DHx+aiGOgI2SpLX8ajyNZzNoLKuPIHBCBav1IbiUo1hGn///u/nHb+Sf/4BOjUUCHTPEEYtoEB9oYPGo16dDB+SnIezFw1F6Tiq+2Zgya5hZu6YbZCEkhmVOUcyhsoygguRJc3PoZA3uMgWnkMLfihMf5wUOEWP5YlCPIk21Fv+es0qtuhMASfP3t99LRzd9+Qs2XnfqTKnjNB14j1xP8Yic84PDQ7jViBgHfK3nCC9it5Znly8I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(38100700002)(122000001)(8936002)(6862004)(1076003)(316002)(508600001)(54906003)(6486002)(33716001)(82960400001)(4326008)(2906002)(38070700005)(6512007)(91956017)(186003)(66476007)(6506007)(71200400001)(9686003)(64756008)(66556008)(6636002)(86362001)(66446008)(76116006)(8676002)(66946007)(5660300002)(26005)(505234007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3qVVUnIczc9WpZRtWeXhrNrTlv4JhYf4As9mgY8+Dvk6Ipy4BpZ6BOXZJBy2?=
 =?us-ascii?Q?xCVog+VgFpHf7ULDSJzYiWUH/Hxna+c/r7b7Nj0nJySW7cqr+ZeuyFxsiMoD?=
 =?us-ascii?Q?NBMN9ZsXKMgneS9IC+QVdvWRf6wdO4DhGvuw/Ny/vxBiN5Rpl3XK4+ih4uOB?=
 =?us-ascii?Q?GHLxkWQZytlYfQZnxqZpjOMHfABJPjgqYbHlQ6aTqrZlyaW4/DCQI+aJf6ko?=
 =?us-ascii?Q?m6WbGHpOJ58e8lXEMgrWnnM1urIfjjh+w1C8nv3zLIL7rrDVVcKMEEt1ocbF?=
 =?us-ascii?Q?pRQBebb2j5M5iiljPJY0fBX2IUd49VYGowMSiDF6Rm/gebu1dJB9h2qrGSF+?=
 =?us-ascii?Q?/l0PTXgCbp+4I8noVmmlNMPR00t1NuZ/uOt5BRke/psCQB0hJNSYU7XRxOqv?=
 =?us-ascii?Q?bsZZNpJYyGf9HiKHUHE/fSPq1c9OXYVtItvTZIfgHdoDWKTRiUKn/6/1/fdY?=
 =?us-ascii?Q?M2ioPlZJtkv651RsFpB/M3pQxLzExUk1/Do1Clbmuvw/zXWn3YwhdNgiYcCG?=
 =?us-ascii?Q?h/HhYkJUGA4FBMuW1B55fQY7Kl8gv/4X4k6EgX3AqI65fXMibRbttrG33o0N?=
 =?us-ascii?Q?SGRxdCEmd+aBm00DaYe+rJIYvnv6LpSGRTuvEY0DQjiTSYPFKt6PKBhzKSKF?=
 =?us-ascii?Q?R77NzE8YrYQFO4nb2mR77SNsaC++upKAqbTHyhjt3Yz+R1RXm4l2l3Q8n9se?=
 =?us-ascii?Q?Oe1sTE9qyF05kSAXKqvKEzWtvZ81Xx3DcMFc4AzZs26pvAlHYahfuD8BqSJg?=
 =?us-ascii?Q?A6f+OxsjJW5CVjMzab/tVC5U9BXKWWUv3A4Dm52KRisQS3odzvypEn27D0OB?=
 =?us-ascii?Q?1FqVF+AOY77d/AQpYmMtJDyG+HfXkGvEBFnGKyBgZymXm6Fsuksu+J5OBYMu?=
 =?us-ascii?Q?3v31DNHtlsyvEKHCzDe10nuaj0kPRK55g9fNLJkAAHal7CXtl6S4QLW3ITD0?=
 =?us-ascii?Q?Hz7oH5oHMRDH3PzGW0xuztl+YRoUoVaJH/ajKgYscMvmc6DKuiwPw71m6/Tk?=
 =?us-ascii?Q?Vp/oyTK6mJE6UirFTfO7CkEHm2Fohb6mSris9bJQeirRy17WRyhUUDXttBnR?=
 =?us-ascii?Q?1s8Rve6GtSdCL7+/7twbAoi/XvS88rnmoXH46/2jVx5Gd58KrraHnMxZdX9u?=
 =?us-ascii?Q?Ixijli9hRoPcjtY+qGq6AVmdhDu3s29hM0X6d7FBB9+V+6xy0R8o2g5hj3uT?=
 =?us-ascii?Q?MYpeZdVEnTiUkyqzzEoIdnHR0lcswZawP0WiiR2ofSPq4C3k/mZzlN6fPNAk?=
 =?us-ascii?Q?KbHC/Rktf+XavHoml7Q+Yj1M9260IGFUFzEckKrmDThWeNQrnxgvcje1jibd?=
 =?us-ascii?Q?ZffObf6y3IYAzn/plEShCP7QmwaZ5r1MOcJDUkjUISDnBZ9n7Bpq3+w7b3AX?=
 =?us-ascii?Q?qyqqjuNoCSRJercCjkGPfo5Y+eZXs5IT+k9esieB65KEAiBeYE4xPPRE0+wh?=
 =?us-ascii?Q?iN6TEx1cw/BMYLLOX9sJ6w4sfnJVRRTtcV5IrrizdiizeHrUSRMMTWOSffor?=
 =?us-ascii?Q?YiWt/zdJrehnA1L0MrL2neDEiXCwt1h926O7k7QN389k5H7wX2nF8yv/KBAg?=
 =?us-ascii?Q?g96xDySYKStUHQA8S6qlSil6RLF5MZAa8c9Pkfr4MVzQuyJLlXEruuUZPbyx?=
 =?us-ascii?Q?4bSUZ/nMRc/4MuR+xkGPhEE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D887CBE044446C49AC41C0E7465DD6CF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71315c91-48cb-422e-1627-08d9b8719986
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 04:33:49.3982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utHmJ6PyN34SiSCbyBpLuLoAuPJFgucriCedGLogncjRnrfxKd8CSiqVznb8V9/kIQ/LGh6wtqZvViiFpSa00g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8231
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 03, 2021 at 03:12:27AM -0800, Johannes Thumshirn wrote:
> Kmemleak was reporting the following memory leak on fstests btrfs/224 on =
my
> zoned test setup:
>=20
>  unreferenced object 0xffffc900001a9000 (size 4096):
>    comm "mount", pid 1781, jiffies 4295339102 (age 5.740s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 08 00 00 00 00 00  ................
>      00 00 08 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<00000000b0ef6261>] __vmalloc_node_range+0x240/0x3d0
>      [<00000000aa06ac88>] vzalloc+0x3c/0x50
>      [<000000001824c35c>] btrfs_get_dev_zone_info+0x426/0x7e0 [btrfs]
>      [<0000000004ba8d9d>] btrfs_get_dev_zone_info_all_devices+0x52/0x80 [=
btrfs]
>      [<0000000054bc27eb>] open_ctree+0x1022/0x1709 [btrfs]
>      [<0000000074fe7dc0>] btrfs_mount_root.cold+0x13/0xe5 [btrfs]
>      [<00000000a54ca18b>] legacy_get_tree+0x22/0x40
>      [<00000000ce480896>] vfs_get_tree+0x1b/0x80
>      [<000000006423c6bd>] vfs_kern_mount.part.0+0x6c/0xa0
>      [<000000003cf6fc28>] btrfs_mount+0x10d/0x380 [btrfs]
>      [<00000000a54ca18b>] legacy_get_tree+0x22/0x40
>      [<00000000ce480896>] vfs_get_tree+0x1b/0x80
>      [<00000000995da674>] path_mount+0x6b6/0xa10
>      [<00000000a5b4b6ec>] __x64_sys_mount+0xde/0x110
>      [<00000000fe985c23>] do_syscall_64+0x43/0x90
>      [<00000000c6071ff4>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>=20
> The allocated object in question is the zone_cache.
>=20
> Free it when freeing a btrfs_device's zone_info.
>=20
> Cc: Naohiro Aota <naohiro.aota@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Ah, I forgot to do that.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

> ---
>  fs/btrfs/zoned.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index c917867a4261..fc9c6ae7bc00 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -612,6 +612,7 @@ void btrfs_destroy_dev_zone_info(struct btrfs_device =
*device)
>  	bitmap_free(zone_info->active_zones);
>  	bitmap_free(zone_info->seq_zones);
>  	bitmap_free(zone_info->empty_zones);
> +	vfree(zone_info->zone_cache);
>  	kfree(zone_info);
>  	device->zone_info =3D NULL;
>  }
> --=20
> 2.31.1
> =

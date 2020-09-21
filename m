Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65043271E5B
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 10:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgIUIwE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Sep 2020 04:52:04 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50037 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgIUIwE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Sep 2020 04:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600678323; x=1632214323;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BiPkVdsXYkkVceJzZwe0mwhUUd97jddedOoSRPWIVHg=;
  b=aEjrkdbgKAaAMsFg3gEO08VH0pjT8mqVHpfGv6mVs4UlGl8OSPWd6T6h
   0rwaEKmIYHQYEKlOc+ZeK+pZrJ7JG8LgsrHCLAYKH3TFoSsNhVGYuwPwb
   PpWSyNy/jUWg6+Zh/NUJUCtvahWwVTvYv+T690q1/T0LiN839J6QxbOov
   WI05NJWtxx8Oe359uD9SdA7md8izrTMN9p1rMdwju0eNrWhIssMBKDa8i
   VTgv1ApRy0dotzKhvUpvXxox9BAAS3+L/nXXyaOQwleV/7I9U2gCOrrvF
   AAptxziLFzMs0FWgmUGNsZ4KuV1hCcvCXTnkW4EcTWva59zSsph1y1zj+
   A==;
IronPort-SDR: 6cBIXqT17JyeQHhEhY4T+9xZmUfVBYUaj4nCfBnEBidaFxGKTKrjWD+jTnTTEEpm1n5691zZpW
 CsTppmG9TjgCe6PajBTgOxMwz6xNlvVtsd2mwdNzV++C7nE0MNNtzA1fy7ZoMP21YmgdRuC7lk
 fopUeQV5UceVWxFaHaLp6fK7yc5kSI3F90FRYcilRCqSQvEAOYyv6s2eydIStoJgdZMEe3JDJs
 yXHdOxzM5nZ3arar2YMJGjSYyKMh55fAmY6Ke2XCwao4cyLO1hDahEG4F3+dj8AMlaF3NHfrfD
 Kno=
X-IronPort-AV: E=Sophos;i="5.77,286,1596470400"; 
   d="scan'208";a="257578911"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2020 16:52:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Toy+dkesx76wIfy/v1k0FcJs6ocxEBP6o1khnbLldMZcL0bmG+EvmXn3vKqyRf4wijueyaqntBsIf5fOm4q9QIm0PnKsJPn/NE0T1P+We4Z8FbiNQi9XKHj14Fnk/TmL3dewk62hilLZmMhd1PnuRtlkFwJIK9YMiby0gTfidxtK2a3pmb1jjEGOGgyfCFnqWUdwR4ApFHSXTnpWzcfMRuFbczzobCO6u1s2uMd3paRLdktTy2kZ74Mj21lq8Mni0XoP2wwKSLnwP8U6+iPyGqayrXoSFWlN1cA86P2c+E4Jx6BhGedg15+nVxkl6bm+7ufY0ogSR9OAhUVe+kdobA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeJIpx+O44KAVDWPBS2Olmvq2olQ7bvScsf7gcRbRlk=;
 b=Ff8EZ5pQC3/xk2EezRdlVWInmR4M3SHkbRIIaHP1xOL04XU6nGMJy4RWFRnIXPmfT6Vt3zuYl4zGVqttdDIxHsbnPgC+T59XzpSQgBlSUuMyEQvAj7GMsBZggCNbv4bv83ICe5wZCvpZ55PMAlYDomw0+0SRN51+WimqxPIO0pbHnGNcBCbQHVb2+8nWUzZD4dUGgtihaHqf4lU8d4V5H+3bzPC71FZQvo3N2jgEaCw/VSazMHURTlTkIT0Cpa5v0UKNtg8MiASS3e2cyIfGioqXOoNkixA888ifc+W7hU3oTpC4Evhe/6/Ve61dsl4niqGtP3LELW0fusA259jbrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeJIpx+O44KAVDWPBS2Olmvq2olQ7bvScsf7gcRbRlk=;
 b=k9/HmrPnSfOKKX8vkQPFDhis54LEnIkOMVN37m2NMUIdg8Pvr7cGHM6+qwOfB5vAF5rmqiIJjIvZ5Qdus6f2uDniyL7LmPldcuWgVglMaVmuTxUvQTo3KV4a5+hFs2euDjY2YAjUDe3sn9H1MlcYmqOX9bE5TLMOU6guA34xXkM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4239.namprd04.prod.outlook.com
 (2603:10b6:805:36::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13; Mon, 21 Sep
 2020 08:52:01 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Mon, 21 Sep 2020
 08:52:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "qiang.zhang@windriver.com" <qiang.zhang@windriver.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Fix missing close devices
Thread-Topic: [PATCH] btrfs: Fix missing close devices
Thread-Index: AQHWj/EE9ACKFguCd0uLvl8x/+Qkug==
Date:   Mon, 21 Sep 2020 08:52:01 +0000
Message-ID: <SN4PR0401MB3598AD645D54CF397612EE429B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200921082637.26009-1-qiang.zhang@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 576d59a0-15a8-47f4-add9-08d85e0b9b2c
x-ms-traffictypediagnostic: SN6PR04MB4239:
x-microsoft-antispam-prvs: <SN6PR04MB4239545116ECCAA13B3A25119B3A0@SN6PR04MB4239.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5QUT0nk1SU5jw8AMJmkmP+UOiLD7ovCOstkgCGWJ327J5C+1tGhijRmgbPCMFFjwTp74chZ7+9F2TOdVqqSFIZNx/AADEAsEa4WS+mGmvmu4/JVSN+oo05GPEo4W4D0HQUklImzSqZIj629+lDxwsOrOKFUwB8FoV02Z4PqWS9WhXZ7EOrCeLWXe4zOC8ZuzwjH3CWTCBX2bvXRTMBAsSPzJCoCNwwfj6UJDkhBdoN7vKsskZmMLnRPZ81aftYfxRFzthumCBLWsUTTRxNoV4M3gl1uWWwU9J8UlVhw6N0xHmhP9x5OWa248TvIWTvNi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(4326008)(2906002)(76116006)(91956017)(86362001)(66946007)(66476007)(66446008)(4744005)(64756008)(5660300002)(52536014)(66556008)(71200400001)(110136005)(9686003)(54906003)(53546011)(6506007)(7696005)(33656002)(186003)(26005)(316002)(55016002)(83380400001)(8676002)(8936002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MmLm1yRwmhNofAFs7+S+7ohLKzsTuXG9bgKW97jABFsSNPaeXs6RmIWfSpyViE8QqA3L7XHdDMdQrVO1uuZMkvC+77vrKnQ7odwq9ry9YT7STbSK3L06SWG9w75xSz1HwBbhewOd0SKCpyyfzk3wkvbmP3aU0Cbb5sLqmzSha8cGJP5KCEnlF5xN54vR3h1sz4+q8p8RQbhvKRPEiW62tplKSUkzLkFp9/fLvVRTE29iJucfk2mWLvmfa782v0B6XxwxiT9etGPq/4XuVM8mu1pWgwrFZthRYRsXLTKyRXunj5f/SZIgUaufECA9/9ohGELUdT94hV/fYWO2aBc0L3KhhOq3LOvvJwAT2CgAHQOhShC9K9HV/Zs3/EEQKe52qgd8RVDbyVpMcRfyA6n3wupk0PgSMEmOrk3YHvlKqMbZMvDAFGZK8ln484k+QNirKrKknFIheE3kR9kLE9O76JcsJ7OAaqeovoSV2XsEqlvVgu25KTtz2inOrh5i88S1T/7yDyANEJ87w13arRDz5ww84MMhM2CcoZmFBgOgReGqw6uUFbNX48IC90+c3+sug9kNdwyvp1ii5NzhWqeujUkEXK3FI8SeI2K8azm2t2keClDjW0rkvLtiPuw+Icym4FUE8qVfKuu//YUH9FWPHw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576d59a0-15a8-47f4-add9-08d85e0b9b2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 08:52:01.2363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SV9z/cYMBdm3mgL4odYgtuXoUd2KReWZcOWyJQekM/tp4Z95JAlOm6zvSGcyqxwBa/Av47hblsQIcmK3lf2Pgtv4eQXiOIAya2ZF6PSKtto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4239
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/09/2020 10:27, qiang.zhang@windriver.com wrote:=0A=
> From: Zqiang <qiang.zhang@windriver.com>=0A=
> =0A=
> When the btrfs fill super error, we should first close devices and=0A=
> then call deactivate_locked_super func to free fs_info.=0A=
> =0A=
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>=0A=
> ---=0A=
>  fs/btrfs/super.c | 1 +=0A=
>  1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c=0A=
> index 8840a4fa81eb..3bfd54e8f388 100644=0A=
> --- a/fs/btrfs/super.c=0A=
> +++ b/fs/btrfs/super.c=0A=
> @@ -1675,6 +1675,7 @@ static struct dentry *btrfs_mount_root(struct file_=
system_type *fs_type,=0A=
>  		error =3D security_sb_set_mnt_opts(s, new_sec_opts, 0, NULL);=0A=
>  	security_free_mnt_opts(&new_sec_opts);=0A=
>  	if (error) {=0A=
> +		btrfs_close_devices(fs_devices);=0A=
>  		deactivate_locked_super(s);=0A=
>  		return ERR_PTR(error);=0A=
>  	}=0A=
> =0A=
=0A=
I think this is the fix for the syzkaller issue: =0A=
Reported-by: syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com=0A=

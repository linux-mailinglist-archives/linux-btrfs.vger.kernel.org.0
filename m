Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDF9C16B6A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2020 01:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgBYAXr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Feb 2020 19:23:47 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41130 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgBYAXr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Feb 2020 19:23:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582590261; x=1614126261;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=M5wa4t0sX4k2it6KvkShxVzT6Mof0fG0A3sBmOTXipc=;
  b=UO7YgFZqGucFpDFl7xGz+upd8hCPcrMRqrC1VjfbiDHEY/5aeVMsxtEq
   mMaM4rDzbBt/FbN1HDwZ/h9IftHuYAobQcnLDtvqEp0w9dxpf6RjoKZMB
   e9GH5Y29DD82QR72I6cBp0zu1fuqP3oneId7E3hdcwtQOqLUiSS44DJse
   85EvS0AsoPxJ2J+lDxjayhyvoV17fLFo6BSQxfvNSJx+Vwrz2QwwyGVEe
   cg6ka5WI2o2vSM1AO4xtcxbNDICheZDBZEcx3FxdY5LJatPMNTBRea5et
   bv00E7q7vuivTlKyBzgdsMW9YK1VoWP6VixVWjpwBZyhxwL2vleb5AOcK
   w==;
IronPort-SDR: S+P1c3LIZ8EXPxH5M7KcqAoxroYG2wL7nebAOxvu9R3a/eBVCpQP+ESIbfX7YQlMDngYTHgehM
 FPKEz1oiunRw9yAw7a62b+4i13U35RRqMlteZuKJDYfTvb3vhSJIANcczcQhLx8XbbdJJTGDJ4
 TNuTj0rFEhLpdit8wb+k3K2Lkh9merkD8EOF0nWmL87wdSn1wCYPahMz8XXVMldWojpG43rjef
 45CT5XcPX1TLOBUzT9Q2Ep3FoF1zfQDjhuOd7KoGEiUx5DdoY7nbIzLuAXJ9Kp3GmTTLdtOvf/
 sJQ=
X-IronPort-AV: E=Sophos;i="5.70,481,1574092800"; 
   d="scan'208";a="232529335"
Received: from mail-sn1nam02lp2057.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.57])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2020 08:24:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0jA3XKOL+tmHwdX2dvPxJfpBhaOF2/baN/57hOganFfwExdocD7j0eB4F5Rldlio/DF0JEPMDVnIJj7HnwRlHoEuOMcEuX8jkzCSa1ekUVbmf/Ymx3pcrCgy9zJasReKm4DFTCsCreJReC9QGLQOxPJZ0nUE0vKeTwDSJPIWlyGQEcOvn1+29sCmeqByoty3wpzjmDF9jxrj6wfcNrt2aakFKL1JbM3K2ciaJ0Yewktj9fB4o+HuL9NclWK5ILlea+2ZTc+QDffoxI4gdi16DPJsKXsompbZ1REc6BJSptT0ewraByMf2lCT91UBbtE0E9Li7aAAch1tlfL6RK57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+COaaEBA019WR4NN3rkLsSmTc/wBUVRGYyvS62UIZg=;
 b=OFulzBpjXKdHoG8Pqx/LTIgfHLp8fK1VauyYTnVm+1l+QNMpEPIXi5swceen4UmC6Zpcc9MSoX5f1jIcfyY7lffql6Pp59optunW0lGUJ0mLLEa5acnpY4KWX+uRIy0BapHYrsigONzhsap9b/YyFpzYb7/zRvy1A6//tttsnr7gR0W+92nOl8pdRsazDjsoZLGjksJSM8j47W1lni0cvBe/8B1SsaDJ+MzZQjw3RvTnKUEbwx30bxew7avOgyx32DsXtjPMtxHb065XBoaJgEhwmfb0RrAoQ7u1ViMVgB0dXWoCTivNpMhpm1UaBZGmfVRXWFdHDHS5BpTx7ptyew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+COaaEBA019WR4NN3rkLsSmTc/wBUVRGYyvS62UIZg=;
 b=FRBXAlAdaksYQJfoB6Mt9y+5ag0MUsoBAUmbqhAT0UrYP1iVYif0mkF8ASJLLSGD6QIVUEPHOpGNf21EnBLiQ7bKxXd8BhKpa+9YOoooNGHgN6ZuZp3TrYDUfavNAZxjdYZSczmRvCKJArKhAXLuwUcPLWPzsCEg2EzE0HEF7MA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3709.namprd04.prod.outlook.com
 (2603:10b6:803:48::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 00:23:44 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 00:23:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Fix memory leak on failed cache-writes
Thread-Topic: [PATCH v2 0/5] Fix memory leak on failed cache-writes
Thread-Index: AQHV4oZpxF/89/7YtUyR/3LulYl7tQ==
Date:   Tue, 25 Feb 2020 00:23:44 +0000
Message-ID: <SN4PR0401MB3598FFD979457FF00ACE9B819BED0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200213155803.14799-1-johannes.thumshirn@wdc.com>
 <20200218165026.GS2902@twin.jikos.cz>
 <SN4PR0401MB3598373E76D2D63694F8DB3C9B110@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200224174934.GB2902@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [199.255.45.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06250358-7d59-4f1e-27d6-08d7b988f91f
x-ms-traffictypediagnostic: SN4PR0401MB3709:
x-microsoft-antispam-prvs: <SN4PR0401MB3709DEB6096BC3E233F6AE6A9BED0@SN4PR0401MB3709.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:425;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(8936002)(81166006)(81156014)(5660300002)(66446008)(8676002)(53546011)(4326008)(6506007)(7696005)(86362001)(26005)(52536014)(71200400001)(186003)(55016002)(33656002)(64756008)(6916009)(91956017)(76116006)(2906002)(316002)(9686003)(66556008)(478600001)(66476007)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3709;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 76eBT8PsUEZFBxvDyT5E4k6aY8efawPHx9EuJl8e1jcVfQd+ypN+Ak3tpzUiUhLrFpsIB/aZN7HnJy1dWeBSZblEMbI6GG64ujSfH7rF7oed2FdCicz/HgdRh2Sopzav+CpgWv4RkqSEUOGwUBZswmma3AbQ157YM6BTFUhCepSpKxUZrMRsmMjqfJD4gOm/g3Ay0YjNSkvFc7PjhWFTTN5ZxkRk4HPb8zxH5eTld6ETFuI6ux2kHPZvyXBJV+1y5gERJxj5oB1D9VFERZ3U74p9m5ivnggFeFm3sxkR7VbX9yfDRBKk/zMLMdA02oMqpeXXMl6XMt2+FUltPlj3/QPycHUGVanc6Nd2Z8Vme7bQd3ToD/4mfSOGJr436aVhCQfra1pzy/VGRV+I+++84ctiGaTk2zMg835OXcA2axISF1VPlzpqagGKNKac34S+
x-ms-exchange-antispam-messagedata: QLuR8Maxe39uV3gcIgjBsk6WAqe3NYstzt5kyut5hlHTEGRcg3FfQMKKBe7piJeUsmLMWOyirFTa8uAUia8Ufvp9DI9aiVmRh9Sm3dpiGKvkxkmnZ7efTxysvOiOZUm08BwvsJxLumNDj5w24NCJGw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06250358-7d59-4f1e-27d6-08d7b988f91f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 00:23:44.0864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/8VzRDIt0lQSB0ZNXNe15sEcNHekV7aWhnkC7u2V+nO6hubJBmkoQdUxMTsDHqk4SSF+lscFMVt9BiUZq8qTZ5PyYxQ8FhwdTzBuxO4cFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3709
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/02/2020 09:50, David Sterba wrote:=0A=
[...]=0A=
> So it was test btrfs/125 but I can't say for sure which patchset causes=
=0A=
> it, there are several reports but unlikely to be caused by yours.=0A=
> =0A=
> btrfs/125               [14:07:58][ 9038.483946] run fstests btrfs/125 at=
 2020-02-18 14:07:58=0A=
> [ 9038.894197] BTRFS info (device vda): disk space caching is enabled=0A=
> [ 9038.897644] BTRFS info (device vda): has skinny extents=0A=
> [ 9039.553603] BTRFS: device fsid 853f4928-5113-48fe-b4e5-b2d1f1af15bf de=
vid 1 transid 5 /dev/vdb scanned by mkfs.btrfs (29881)=0A=
> [ 9039.557424] BTRFS: device fsid 853f4928-5113-48fe-b4e5-b2d1f1af15bf de=
vid 2 transid 5 /dev/vdc scanned by mkfs.btrfs (29881)=0A=
> [ 9039.561587] BTRFS: device fsid 853f4928-5113-48fe-b4e5-b2d1f1af15bf de=
vid 3 transid 5 /dev/vdd scanned by mkfs.btrfs (29881)=0A=
> [ 9039.581158] BTRFS info (device vdb): turning on sync discard=0A=
> [ 9039.584130] BTRFS info (device vdb): disk space caching is enabled=0A=
> [ 9039.587021] BTRFS info (device vdb): has skinny extents=0A=
> [ 9039.589100] BTRFS info (device vdb): flagging fs with big metadata fea=
ture=0A=
> [ 9039.595079] BTRFS info (device vdb): checking UUID tree=0A=
> [ 9039.706233] BTRFS: device fsid 853f4928-5113-48fe-b4e5-b2d1f1af15bf de=
vid 2 transid 7 /dev/vdc scanned by mount (29923)=0A=
> [ 9039.711721] BTRFS: device fsid 853f4928-5113-48fe-b4e5-b2d1f1af15bf de=
vid 1 transid 7 /dev/vdb scanned by mount (29923)=0A=
> [ 9039.715946] BTRFS info (device vdb): allowing degraded mounts=0A=
> [ 9039.717785] BTRFS info (device vdb): disk space caching is enabled=0A=
> [ 9039.719914] BTRFS info (device vdb): has skinny extents=0A=
> [ 9039.723260] BTRFS warning (device vdb): devid 3 uuid a55e3334-e24b-422=
0-93a2-9aaec7286042 is missing=0A=
> [ 9039.726785] BTRFS warning (device vdb): devid 3 uuid a55e3334-e24b-422=
0-93a2-9aaec7286042 is missing=0A=
> [ 9040.189984] BTRFS: device fsid 4d1f43bd-2b49-4905-a219-25dc10f1b5fe de=
vid 1 transid 249 /dev/vda scanned by btrfs (29951)=0A=
> [ 9040.211252] BTRFS info (device vdb): turning on sync discard=0A=
> [ 9040.223781] BTRFS info (device vdb): disk space caching is enabled=0A=
> [ 9040.225777] BTRFS info (device vdb): has skinny extents=0A=
> [ 9050.252423] BTRFS info (device vdb): balance: start -d -m -s=0A=
> [ 9050.256160] BTRFS info (device vdb): relocating block group 217710592 =
flags data|raid5=0A=
> [ 9050.389701] btrfs_print_data_csum_error: 6540 callbacks suppressed=0A=
> [ 9050.389706] BTRFS warning (device vdb): csum failed root -9 ino 257 of=
f 5357568 csum 0xb5d704296aa5f2d5 expected csum 0xdbbbd8326f9b86ac mirror 1=
=0A=
> [ 9050.398381] BTRFS warning (device vdb): csum failed root -9 ino 257 of=
f 5361664 csum 0xf2f7aa2e723d427e expected csum 0xdbbbd8326f9b86ac mirror 1=
=0A=
> [ 9050.398899] BTRFS warning (device vdb): csum failed root -9 ino 257 of=
f 3424256 csum 0x15e7d27c0f4b4f20 expected csum 0xdbbbd8326f9b86ac mirror 1=
=0A=
> [ 9050.403918] BTRFS warning (device vdb): csum failed root -9 ino 257 of=
f 5365760 csum 0x25464d4ee302ec50 expected csum 0xdbbbd8326f9b86ac mirror 1=
=0A=
> [ 9050.408525] BTRFS warning (device vdb): csum failed root -9 ino 257 of=
f 3428352 csum 0xcd1278f31a795b3d expected csum 0xdbbbd8326f9b86ac mirror 1=
=0A=
> [ 9050.412556] BTRFS warning (device vdb): csum failed root -9 ino 257 of=
f 5369856 csum 0x045d00c41342cf48 expected csum 0xdbbbd8326f9b86ac mirror 1=
=0A=
> [ 9050.417133] BTRFS warning (device vdb): csum failed root -9 ino 257 of=
f 3432448 csum 0xab3b271dc78f0131 expected csum 0xdbbbd8326f9b86ac mirror 1=
=0A=
> [ 9050.425859] BTRFS warning (device vdb): csum failed root -9 ino 257 of=
f 3436544 csum 0xa1e70b1d4d61d53f expected csum 0xdbbbd8326f9b86ac mirror 1=
=0A=
> [ 9050.430432] repair_io_failure: 9 callbacks suppressed=0A=
> [ 9050.430435] BTRFS info (device vdb): read error corrected: ino 257 off=
 3424256 (dev /dev/vdd sector 196512)=0A=
> [ 9050.430464] BTRFS info (device vdb): read error corrected: ino 257 off=
 3428352 (dev /dev/vdd sector 196520)=0A=
> [ 9050.430473] BTRFS info (device vdb): read error corrected: ino 257 off=
 5361664 (dev /dev/vdd sector 198376)=0A=
> [ 9050.430681] BTRFS info (device vdb): read error corrected: ino 257 off=
 3432448 (dev /dev/vdd sector 196528)=0A=
> [ 9050.430762] BTRFS info (device vdb): read error corrected: ino 257 off=
 5357568 (dev /dev/vdd sector 198368)=0A=
> [ 9050.430805] BTRFS info (device vdb): read error corrected: ino 257 off=
 5369856 (dev /dev/vdd sector 198392)=0A=
> [ 9050.430853] BTRFS info (device vdb): read error corrected: ino 257 off=
 3436544 (dev /dev/vdd sector 196536)=0A=
> [ 9050.432557] BTRFS info (device vdb): read error corrected: ino 257 off=
 5365760 (dev /dev/vdd sector 198384)=0A=
> [ 9050.469621] BTRFS warning (device vdb): csum failed root -9 ino 257 of=
f 13959168 csum 0x774317b489e76165 expected csum 0xdbbbd8326f9b86ac mirror =
1=0A=
> [ 9050.476527] BTRFS info (device vdb): read error corrected: ino 257 off=
 13959168 (dev /dev/vdd sector 206720)=0A=
> [ 9050.501930] BTRFS warning (device vdb): csum failed root -9 ino 257 of=
f 16351232 csum 0xa735bf811aa10b77 expected csum 0xdbbbd8326f9b86ac mirror =
1=0A=
> [ 9050.512917] BTRFS info (device vdb): read error corrected: ino 257 off=
 17608704 (dev /dev/vdd sector 210392)=0A=
> [ 9050.708681] BTRFS error (device vdb): bad tree block start, want 39059=
456 have 0=0A=
> [ 9050.708684] BTRFS error (device vdb): bad tree block start, want 39075=
840 have 0=0A=
> [ 9050.708699] BTRFS error (device vdb): bad tree block start, want 39092=
224 have 0=0A=
> [ 9050.708700] BTRFS error (device vdb): bad tree block start, want 39108=
608 have 0=0A=
> [ 9050.713287] BTRFS error (device vdb): bad tree block start, want 39059=
456 have 0=0A=
> [ 9050.727830] BTRFS error (device vdb): bad tree block start, want 39059=
456 have 0=0A=
> [ 9050.727849] BTRFS error (device vdb): bad tree block start, want 39075=
840 have 0=0A=
> [ 9050.727854] BTRFS error (device vdb): bad tree block start, want 39092=
224 have 0=0A=
> [ 9050.727876] BTRFS error (device vdb): bad tree block start, want 39108=
608 have 0=0A=
> [ 9050.730601] BTRFS error (device vdb): bad tree block start, want 39059=
456 have 0=0A=
> [ 9053.133149] BTRFS info (device vdb): balance: ended with status: -5=0A=
> [failed, exit status 1][ 9053.200709] BTRFS info (device vdb): clearing i=
ncompat feature flag for RAID56 (0x80)=0A=
>   [14:08:12]- output mismatch (see /tmp/fstests/results//btrfs/125.out.ba=
d)=0A=
>      --- tests/btrfs/125.out     2018-04-12 16:57:00.616225550 +0000=0A=
>      +++ /tmp/fstests/results//btrfs/125.out.bad 2020-02-18 14:08:12.8560=
00000 +0000=0A=
>      @@ -3,5 +3,5 @@=0A=
>       Write data with degraded mount=0A=
>       =0A=
>       Mount normal and balance=0A=
>      -=0A=
>      -Mount degraded but with other dev=0A=
>      +failed: '/sbin/btrfs balance start /tmp/scratch'=0A=
>      +(see /tmp/fstests/results//btrfs/125.full for details)=0A=
>      ...=0A=
>      (Run 'diff -u /tmp/fstests/tests/btrfs/125.out /tmp/fstests/results/=
/btrfs/125.out.bad'  to see the entire diff)=0A=
=0A=
OK it need some time (up to approx 150 runs of btrfs/125) to resproduce =0A=
this failure but I can re-create it.=0A=
=0A=
I've seen it once without the patchset applied as well though (a.k.a =0A=
HEAD =3D=3D 480be04e7fdcddfed86fd59bb668a134b6d7393e).=0A=
=0A=
I have to verify that though not that I'm seeing ghosts.=0A=

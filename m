Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB37A258EEA
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Sep 2020 15:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgIANMQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Sep 2020 09:12:16 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:5577 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbgIANLb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Sep 2020 09:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598965890; x=1630501890;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ta3z8iYmnsznRfXjk/RJ76EpONJehK8YAROOphBOAss=;
  b=FCHHm7m8fKD6eufSwbfrwjt7Dsrmbvnkbtpx53Uj46O9FoBaQfN5uICr
   FL6ReTa0NG/DbVXTjUG+0qHGotJEB2GlzSbDATo/m1aRc4L+mjUf+vqj6
   GfPycj5yk+arqwPMGvf9/uE0LhsJAYgkdDcr5qqYvmJ513X8oTJo22akQ
   2NqK8Cx82ST6I2K6ITBVSPzNVbtqBtof37GQ4hLsPJp27iWhXfqmdCGbJ
   oc4Fh3oJ/JoFttQqimHDYAVtQ3RIGB/3KgaqSXS21JmHLRl4itoCQGCmC
   rmlrZyYEnDoX8Eyjh8Ck37seLBS7sr4/+U+cnpmZz6sHN/Ik71vKztIiO
   A==;
IronPort-SDR: uRZu5f0LqkmkEcmss3ZzWcFxpx5UJb5fhsI33w8Bj26WlCY1SdROz61tLgmtPK5pZY2uYRrDEV
 acT2JoqahVIRUqXq+w8W/EGbYk1rD1M/A5SuFYDPSSosFbfAjCC5lx2OvHNp75S7Q1YFyJGYHM
 Dw3SnhzBJ4Xk+h8VMB5TDRFXIt4KQPEjXch/xtg9OEOxS0Yw8VUhebOUnpmfDo9q1DxFrN+SRd
 8KoO07nr4KWsJjhKLR4EjkTJhOM/4qIt28yChItOiNntCUHG5+e8CWOgM5DoMBfWVAUQFVfSUT
 KOY=
X-IronPort-AV: E=Sophos;i="5.76,379,1592841600"; 
   d="scan'208";a="147539902"
Received: from mail-sn1nam02lp2059.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.59])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2020 21:11:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AN2KIaFdjwP+4JNGBZ/fwWR1vLLj7G0UwZJFdIAiEaUiRKGJSexkmsLDdMWjRFVyShC4I3hZq5CeiNIYUF6XST/DGYcK0cn6y+v0rJNMkZo3UCmWk1ZEMhENq5gvQ6oUTAnYFt9/yG4c2j15HvD16r8igLHV23wmDIY5bWPbgi9CQK4M47nG1Rqal7hVjWeA4pfgmzFa/mjn84dQmSfT8TbuOfkB7UpTb1FrDPujYBl1J7ie9nQTLbteUTG2U+ZdPytEQaPzZsTrgSmvpAu5zDPAETW8EDNX5J7GxkDBFppFaWB+KsTutl7INWfKC9KjFmzco+/Fnoy/ke/GtohDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrtVHdBPnpdyrWKuAm7JhxBx0EqksbKYYjYYZVUP0fM=;
 b=c+j9SGVDX2UqjQX0H9wgDl68IfKI9+IhvGFkC7aH0AqSkV/pmXkJvo7ShsuwGCY0r1n3WacnQuCgMI7z4fjor6fFiRof+W10mNeudRsyHTk2vFzJssPVSABLS/NBgYgz9sbv1bpxEeY4fqQgHVB0/8zMJcDtj6L4iSRvbbNgdZ2BM733RUNf2kwmac0NaXYBWLpvHWwAbARlTFcy8bO1+JljyX8E/6XujYTi3l99A2CPCkYQEYYtyVSqw5AjBWhLFHU01Zc6iDqjAw+BC1qMzT3UEYj+GVrTxYSDnoQWjHNsLnPSmGa1cvtxM6n3uk6wHHO8aSegaxB5MvDUve6SsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrtVHdBPnpdyrWKuAm7JhxBx0EqksbKYYjYYZVUP0fM=;
 b=kR9+kMaFX3azHdbxGg+UiUWgozlo91Nt/PzJLiRRhFhmMRvoDxpwFxOt+aDbTGRC0BLQdvrkwj3jeKuZZCovLs52j0/NKNx5A1eVbILWKv3ALRZChoAzyF/o2e33HHazuWqs5Ok3XhLFpp1kPyCShE+kawlkl5sV4Xcjpw9e2DU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3967.namprd04.prod.outlook.com
 (2603:10b6:805:49::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 13:11:19 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Tue, 1 Sep 2020
 13:11:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
CC:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Thread-Topic: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
Thread-Index: AQHWgGDIsm2Q9fFDf0qcho+qy+MPJQ==
Date:   Tue, 1 Sep 2020 13:11:19 +0000
Message-ID: <SN4PR0401MB35989CC472A7D5FF5278A5239B2E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:bd07:d1f9:7e6b:2014]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b49e75e0-ae97-466c-bbcb-08d84e78847f
x-ms-traffictypediagnostic: SN6PR04MB3967:
x-microsoft-antispam-prvs: <SN6PR04MB3967958258FEB4074EE429559B2E0@SN6PR04MB3967.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OHXZHUtcXeOuP+tE/IZSMZxy015fzdiz34msLudjxa9P7FK4vuTvL27WWHOy+Z2FfXrssxdGxYtoC0o/BtyZdevjwnm+TMMIV9u+7iu7/H03Lib0DhOMbZGqQGlzRhu+SYgWr7//3prJTqS4csrKc8H0itv6C5NfUx9/Zc7yArMLFDECFmwIeP6b/lbYiymi9d1esxV1rdSvaArEGlV7GbZqn7cwf35ccVfH43TlAWYfwGTNxrW2gzpIpR3aaR3of2i5gPvO9qkjLr9kYrc/d44dkufe6BNc6ER0fIZD/zJ+MmOknHVStZ8Na0JmDH4Hfu7NJvGEvEq11OqG0GD7d2gHAQiuvhWAtv5RNqzGfV5reRXEtA1xn3TYKk5Lf2Z0wPPld9qLF0VAdmumwbRehA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(66446008)(9686003)(478600001)(33656002)(83380400001)(71200400001)(4326008)(66476007)(966005)(64756008)(66946007)(8676002)(66556008)(76116006)(186003)(53546011)(6506007)(91956017)(8936002)(2906002)(55016002)(6916009)(52536014)(86362001)(54906003)(7696005)(316002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: XZEEN3V3O1N2Xlf2jKoFDtxDeoSNqB+cWpInfN+mhsi7FSJFwWLRMYoSjluvdc2XzrKmS5PN6u9mCuBW0gKAY4Y/OmxMNAf6OaY7oHcDT9KQjB283yKRYgrUdJBAnIp6DXk+5ZwYyq9ImgAHBP1j7ORjIs3a9sKwfw6/0+8o+vGwLxqAx/uQKwWVzYhKo62pIK/Mdm5wHfsuBx8u2lreVDr7JIrNPtTA3djaDMwvfUid3DBz+NzCrvBTMPoL7iwZtBKlDGllIZJ7krBZkTx4Pavz60TOpIP3CmcqhYbahWlWhni8SiEGbLo9bZ5n22Vst9McWr/JxJg5FkvMdXq5f86LEt95T23EIEWMokYmmDNXfiMbColYtpM/ry73xsske55hu9QKuJIH6mRR4gxO16oH4J2ORxt4dXE8vKHfo69Yzq9xD1nxKT3EL8l26C5ukU8+ITQyRxAnx83319B8snF5UZerhDrnLnM+hjfAyjg1gE1ob4sDg+CRa6QqPQe7QUaMpBCbnMAwKUmBBPRVa5AzN4iBzDapq6pi0i1MCPifMnLwjQXDMo838/fVyIcSQ/nSQ03jR7tNeR6Tdwq+6izGPTZoM5CLBEaCQlw03obhXdv3MofL2u2MZPCrx8f26D0iyBvw+YX8XyWwKND5jD/QKrmgL0RSO7Py8kJFEh2myMl8y+phR40kNlGxPJXqXdf4JfxwBWGlOw2SXtA2Ug==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49e75e0-ae97-466c-bbcb-08d84e78847f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 13:11:19.7531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lGjvffGyEAF9UR6AGqy7YNxqAsRi9sh1uCvLZiB8p6XYASm5CuotAfQ+aHTLeUYn65hXRPkAHfh/ipnREaH0tsMhvYN7IcW/PYHfGb24vpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3967
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Oops forgot to Cc Goldwyn=0A=
=0A=
On 01/09/2020 15:07, Johannes Thumshirn wrote:=0A=
> Fstests generic/113 exposes a deadlock introduced by the switch to iomap=
=0A=
> for direct I/O.=0A=
> =0A=
> [ 18.291293]=0A=
> [ 18.291532] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
> [ 18.292115] WARNING: possible recursive locking detected=0A=
> [ 18.292723] 5.9.0-rc2+ #746 Not tainted=0A=
> [ 18.293145] --------------------------------------------=0A=
> [ 18.293718] aio-stress/922 is trying to acquire lock:=0A=
> [ 18.294274] ffff888217412010 (&sb->s_type->i_mutex_key#11){++++}-{3:3}, =
at: btrfs_sync_file+0xf7/0x560 [btrfs]=0A=
> [ 18.295450]=0A=
> [ 18.295450] but task is already holding lock:=0A=
> [ 18.296086] ffff888217412010 (&sb->s_type->i_mutex_key#11){++++}-{3:3}, =
at: btrfs_file_write_iter+0x6e/0x630 [btrfs]=0A=
> [ 18.297249]=0A=
> [ 18.297249] other info that might help us debug this:=0A=
> [ 18.297960] Possible unsafe locking scenario:=0A=
> [ 18.297960]=0A=
> [ 18.298605] CPU0=0A=
> [ 18.298880] ----=0A=
> [ 18.299151] lock(&sb->s_type->i_mutex_key#11);=0A=
> [ 18.299653] lock(&sb->s_type->i_mutex_key#11);=0A=
> [ 18.300156]=0A=
> [ 18.300156] *** DEADLOCK ***=0A=
> [ 18.300156]=0A=
> [ 18.300802] May be due to missing lock nesting notation=0A=
> [ 18.300802]=0A=
> [ 18.301542] 2 locks held by aio-stress/922:=0A=
> [ 18.302000] #0: ffff888217412010 (&sb->s_type->i_mutex_key#11){++++}-{3:=
3}, at: btrfs_file_write_iter+0x6e/0x630 [btrfs]=0A=
> [ 18.303194] #1: ffff888217411ea0 (&ei->dio_sem){++++}-{3:3}, at: btrfs_d=
irect_IO+0x113/0x160 [btrfs]=0A=
> [ 18.304223]=0A=
> [ 18.304223] stack backtrace:=0A=
> [ 18.304695] CPU: 0 PID: 922 Comm: aio-stress Not tainted 5.9.0-rc2+ #746=
=0A=
> [ 18.305383] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014=0A=
> [ 18.306532] Call Trace:=0A=
> [ 18.306796] dump_stack+0x78/0xa0=0A=
> [ 18.307145] __lock_acquire.cold+0x121/0x29f=0A=
> [ 18.307613] ? btrfs_dio_iomap_end+0x65/0x130 [btrfs]=0A=
> [ 18.308140] lock_acquire+0x93/0x3b0=0A=
> [ 18.308544] ? btrfs_sync_file+0xf7/0x560 [btrfs]=0A=
> [ 18.309036] down_write+0x33/0x70=0A=
> [ 18.309402] ? btrfs_sync_file+0xf7/0x560 [btrfs]=0A=
> [ 18.309912] btrfs_sync_file+0xf7/0x560 [btrfs]=0A=
> [ 18.310384] iomap_dio_complete+0x10d/0x120=0A=
> [ 18.310824] iomap_dio_rw+0x3c8/0x520=0A=
> [ 18.311225] btrfs_direct_IO+0xd3/0x160 [btrfs]=0A=
> [ 18.311727] btrfs_file_write_iter+0x1fe/0x630 [btrfs]=0A=
> [ 18.312264] ? find_held_lock+0x2b/0x80=0A=
> [ 18.312662] aio_write+0xcd/0x180=0A=
> [ 18.313011] ? __might_fault+0x31/0x80=0A=
> [ 18.313408] ? find_held_lock+0x2b/0x80=0A=
> [ 18.313817] ? __might_fault+0x31/0x80=0A=
> [ 18.314217] io_submit_one+0x4e1/0xb30=0A=
> [ 18.314606] ? find_held_lock+0x2b/0x80=0A=
> [ 18.315010] __x64_sys_io_submit+0x71/0x220=0A=
> [ 18.315449] do_syscall_64+0x33/0x40=0A=
> [ 18.315829] entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
> [ 18.316363] RIP: 0033:0x7f5940881f79=0A=
> [ 18.316740] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 =
89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48=
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e7 4e 0c 00 f7 d8 64 89 01 48=0A=
> [ 18.318651] RSP: 002b:00007f5934f51d88 EFLAGS: 00000246 ORIG_RAX: 000000=
00000000d1=0A=
> [ 18.319428] RAX: ffffffffffffffda RBX: 00007f5934f52680 RCX: 00007f59408=
81f79=0A=
> [ 18.320168] RDX: 0000000000b56030 RSI: 0000000000000008 RDI: 00007f59317=
1f000=0A=
> [ 18.320895] RBP: 00007f593171f000 R08: 0000000000000000 R09: 0000000000b=
56030=0A=
> [ 18.321630] R10: 00007fffd599e080 R11: 0000000000000246 R12: 00000000000=
00008=0A=
> [ 18.322369] R13: 0000000000000000 R14: 0000000000b56030 R15: 0000000000b=
56070=0A=
> =0A=
> This happens because iomap_dio_complete() calls into generic_write_sync()=
=0A=
> if we have the data-sync flag set. But as we're still under the=0A=
> inode_lock() from btrfs_file_write_iter() we will deadlock once=0A=
> btrfs_sync_file() tries to acquire the inode_lock().=0A=
> =0A=
> Calling into generic_write_sync() is not needed as __btrfs_direct_write()=
=0A=
> already takes care of persisting the data on disk. We can temporarily dro=
p=0A=
> the IOCB_DSYNC flag before calling into __btrfs_direct_write() so the=0A=
> iomap code won't try to call into the sync routines as well.=0A=
> =0A=
> References: https://github.com/btrfs/fstests/issues/12=0A=
> Fixes: da4d7c1b4c45 ("btrfs: switch to iomap for direct IO")=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  fs/btrfs/file.c | 5 ++++-=0A=
>  1 file changed, 4 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c=0A=
> index b62679382799..c75c0f2a5f72 100644=0A=
> --- a/fs/btrfs/file.c=0A=
> +++ b/fs/btrfs/file.c=0A=
> @@ -2023,6 +2023,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *=
iocb,=0A=
>  		atomic_inc(&BTRFS_I(inode)->sync_writers);=0A=
>  =0A=
>  	if (iocb->ki_flags & IOCB_DIRECT) {=0A=
> +		iocb->ki_flags &=3D ~IOCB_DSYNC;=0A=
>  		num_written =3D __btrfs_direct_write(iocb, from);=0A=
>  	} else {=0A=
>  		num_written =3D btrfs_buffered_write(iocb, from);=0A=
> @@ -2046,8 +2047,10 @@ static ssize_t btrfs_file_write_iter(struct kiocb =
*iocb,=0A=
>  	if (num_written > 0)=0A=
>  		num_written =3D generic_write_sync(iocb, num_written);=0A=
>  =0A=
> -	if (sync)=0A=
> +	if (sync) {=0A=
> +		iocb->ki_flags |=3D IOCB_DSYNC;=0A=
>  		atomic_dec(&BTRFS_I(inode)->sync_writers);=0A=
> +	}=0A=
>  out:=0A=
>  	current->backing_dev_info =3D NULL;=0A=
>  	return num_written ? num_written : err;=0A=
> =0A=
=0A=

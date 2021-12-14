Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31410474264
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Dec 2021 13:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhLNMVx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Dec 2021 07:21:53 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:36532 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhLNMVv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Dec 2021 07:21:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639484511; x=1671020511;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eiFCdoBTu/Gyvs7DKNEwHDJL376i9zHKtvJsg17Mi90=;
  b=OLxSBim6ieQPmseCaCMUkbcDki+TW+dLZsmhfZctAZptkgIHqNBwqL3v
   il6pEM4w5+UKIGZu3zzqQU9DRYuicEGYuYvWKj0xewzcweHk+vY4tWk2+
   L5Su9IQHsWIywV0fwld/QE7KtIQA6VG0VPfPlCcSPDhGGdM9Lt6D1kpbC
   H1AYuCEDp+7KuEJpSjJEhneWExwiI8z4eHFM7+9ET7SVPEsIABVqGCWto
   93KdJfa1njMub74izLNUpx39z34e9fz9VL5mSL/R9id+fNa17+NyK4zEw
   LHtWSdiyq2nc40u8zonjQl00J+j73wwj6FSzor61/to3ltaeZV/DDFafh
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,205,1635177600"; 
   d="scan'208";a="188206517"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2021 20:21:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYJWgqQvi3xfthF3c8mHMck+2Um6m8nzQKKVph75MiOo1pUiYRd4ZWZQs9+heJL72/Lw49spmlccUi9hTuLF4kTEtQtHQA+lYMVIcrPbLpHoPuv8dFhO+d9FRVe+m+EO2EY+QG3GpolxKOtaVOsCX+QBeUCZMvyb0WxjXM/8ycUosXxqUjmaJuN5qOMI7XXpFlg9aIDB4PaaX8flzGzUR9uvco1zKbRxDaI4aABks9dL5F7kexSIwEui7zXLxP+g+n9a5NZ6qZ8Uapl7QkT3CnOWKenzYLHmNtyGpQZh0mLEL9us1TCqGJgckBPGnPIm1uYoKLADKOo3CKh0Q0eNDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3kBHBadrM9alZgpnj1xMY80CR1O753mgTooougz/Dc=;
 b=dDQKidWgz3HIQKNgDKGgkw4eqCL2tIpyb+TSZP8TThmE34AtZe1iU005MquTJJcibzp/P7gFLd5YlP+r9+7WMUqA4kC673gBQuL2kAs7sgLeec7sDPHFnRE6NIOb/cKZ8VUyWjYnpndBfnszVtJTJW4vS+42klAqSQkJc2/moYbWtdMzG82su7fJNZzfb0WfxhXxXEPn3HpSxms2/YbrHKUpfk/lH7NCjxtKaRYPVNMv8LzvSSYqcixzU0c7T1dlZomNYMkpVj1d0JtTJwcJwRVi01W3is33NKXH2W2alhtGOSF+atGbBTPtSmCO9oL/teWCnRJrU8pHDFimoe5a4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3kBHBadrM9alZgpnj1xMY80CR1O753mgTooougz/Dc=;
 b=njjdg5D97/FoFFLczmSdKdMIblubRHgEbk/be+U6Tkcsk/yg1rjMLnlKTZeYaVZZG4UU1gERkfWrFM9PppL/3N8GtVakQxmIAfdAJgeKVuZivY8u8bUSje+xD23on+MeiwimBo6bRyganPfztfd4KnGld4qr6rQZZrBv2ut8IKk=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8292.namprd04.prod.outlook.com (2603:10b6:a03:3f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 12:21:50 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7067:b7ba:4fdf:d3af]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7067:b7ba:4fdf:d3af%5]) with mapi id 15.20.4801.014; Tue, 14 Dec 2021
 12:21:49 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Thread-Topic: [PATCH] btrfs: ensure pages are unlocked on cow_file_range()
 failure
Thread-Index: AQHX79OicLLdJYq/w0OUjXttGMYXaKwwNMwAgAG14oA=
Date:   Tue, 14 Dec 2021 12:21:49 +0000
Message-ID: <20211214122149.hw62eqzl5qd3kpzs@naota-xeon>
References: <20211213034338.949507-1-naohiro.aota@wdc.com>
 <YbcdCsSVfZ4MAsXs@debian9.Home>
In-Reply-To: <YbcdCsSVfZ4MAsXs@debian9.Home>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 106b61ae-39e9-4a90-cf80-08d9befc4df5
x-ms-traffictypediagnostic: SJ0PR04MB8292:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB829215D271F89867245E19F68C759@SJ0PR04MB8292.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lwauowopH0mRduckfHXGcvWZGtC8yDfajG+FCQm6l98D3dcOjNIJU2iLRtZKV32javjnp+mrZ1CxDCVC0TZMkxai96izeP3BzbYO3To7bVMEW9dj60QuXo2LoI97i+im98EAQM98e9mV35+zwozyANk9RCoaWdiGVkoGzPnDi03TqE36tTxGDVVeoxTnfh2Q6qsbdXKRW6KTOf1j+Tx5a00Ob+pGG0nT8lTl5+GrDA62d4XOKJ0TTwFIPy3Gx83mD6SR8p/WMFzGfHqDBRE27WgITTsfB/JpGs3IO15abq5YzsxO0Xpa35Y/4muU3F8LT/HvuL8Ho2e7Qb2/ymHppfKvGB25NBJZ2y5E0tERblMfzDcpNu4wBKnCCBtCOh1gjG1x/h8eCajDbu6QGlI2PDRfPVw1zlvpx43w9NKKVu2NuFeUYjU4+IUw4qywTSpD04LYcotjLAfck6H+UFZKeuh/DbRTfkzkrfrOcb8ZgJqOkR0s2pzMF1wIV2vMHK65FjKuXU1XXrgnNiLai6dGXHJtkQxNwPM1PIf7kT8RTm1onw64NRVoXKVd/iQdXWH3HExCe5UJcWFnTZlRTgVCiK/rGhRC/8qKC95IERfjZMyPieXISHOfgca355Tnr1BS5YsCZ9iPcKyrPeRU2nhF4DxBlsk4PDGpksOaViT1X3koz6ijQMB0b5QoMS39rU4fO/UQYEZStTqVyHZV0ENN5M6WHveppKk5H0Xu4jk8URph1IfyMVUcRTY4rdT/TdGdw+mfrmTxOXQlmwcEKLiDSz2+wDXbdkaRVulTjqOiyOY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(82960400001)(6506007)(9686003)(64756008)(66556008)(66476007)(38070700005)(71200400001)(6486002)(966005)(91956017)(66946007)(76116006)(6512007)(186003)(66446008)(26005)(6916009)(86362001)(508600001)(8676002)(2906002)(5660300002)(83380400001)(316002)(8936002)(1076003)(33716001)(4326008)(38100700002)(54906003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nKLcCrKr07b4Af6JFw7+/GFzTAWctRceaEmiRM36WuR6BhVjzqagPaLz1y8e?=
 =?us-ascii?Q?L2jhG+sxdQXcvTUaKvXMs4vZnvx2uZcxGWaZSqoEgmV39V5R1Z0NljmZcbYR?=
 =?us-ascii?Q?PQq9KXRDPg/JR8qA/NJLXJeRKJLMD9AcDWdH1HB0GLzRz/Acp0MNW+q+OI2q?=
 =?us-ascii?Q?SWiTWlwp5/6UpU8OFy1DHGGMTjwwoc4OVg3EMIZbYRD4Drm8+M2BY0ibDOJY?=
 =?us-ascii?Q?yKzUzvFohVkT8G54n2HW6eh1B8jUd3p26hYqrzrRtute5g4op0I4zLOii/it?=
 =?us-ascii?Q?yj4Fe9BWLJQmFG/vHrzOjywUac0RfdE5FvyINvdeLOIAgNRdt8Qv0gE4KjEw?=
 =?us-ascii?Q?j/JnHJX5No+/SUHMlLNSc6ETd5vXXV0ft2+nnPyFIsALDaY3wcTgQelb1j3g?=
 =?us-ascii?Q?MaYgLZy18ToauR7LFgu/+MXpzqwI4rVvsC6aywVN197v5BdsxY2xt7bOY+hV?=
 =?us-ascii?Q?iQwzWTSMYl8d6Rx1DS6XcbVHsRLcBy/M/0RLm/A+V2ei/1jsXVWSKmYSkcBj?=
 =?us-ascii?Q?hQquENu0n/0m3dmnQ7EzX3HBAtFGhjVIauFjNf3YzMn6dUP79mHOFZZaIwjx?=
 =?us-ascii?Q?Wk8R8NjKkc7fjdksjOMFEcNEzL8I2wEzdqz2dgGFd6p1XtKhZYDmFKx1jlNw?=
 =?us-ascii?Q?5IPo9c7TUia3f9ptcmnjuNlNkYqDdesE0fm/6LI1tUYvsGCKNwB5h+7+KDzo?=
 =?us-ascii?Q?MUoQX0tm+dO8Mvp26AI4v4vIDIVlroNx8A8AaOEC++yYeWr7BSkGPGpom1Nr?=
 =?us-ascii?Q?kWale4QSysGjP5l6Q/U0gTEMPgHn46v7s+VkYGv5dfFg5WvlkrQWqxuhjTHo?=
 =?us-ascii?Q?KhCgOnuq5hEK23KEX+xVkxxPHe8Df9RlKPHVXihzs9fJ3L5iMw5AcpV7X+F/?=
 =?us-ascii?Q?oNsAVCegZfjYxVCmvL8abhJvG+lV/PkWxJvzydMJHXs/CkAePkWuL3XmbrN9?=
 =?us-ascii?Q?tRxOjH5jDjXtodYMFpIlX8pMP5ZV7zWxYeEBrK5ot6r5t9PHR+otN8l/3IMv?=
 =?us-ascii?Q?B4YAGfBMUkmSB9LngHmnWfOgpjspom+OSDCbzby7zIoa0DhfPlIFhpY2ORbN?=
 =?us-ascii?Q?08lt/ruLMZpdUJSWOylr6wbzPnQ07+uAjnwbQY30tyEu7VNwWeqkl+Jbrnui?=
 =?us-ascii?Q?tnhig39zYQZDGoXZX5OPgVo6n04zV3MY2r5j79T2Fdc4yJKw3lS44lJFuBFM?=
 =?us-ascii?Q?qfXqxIbBgs3ewp5s2VprkSMU7Ic5xTYHHrXI3/k9tnNzSuEzU2AxE1rAxNht?=
 =?us-ascii?Q?OVGw4W4YBcCrDRfIxj4JukRh/8EvXxa1c85TyDvC3AW+27NLzLllHVLsKqaa?=
 =?us-ascii?Q?mvO1BVsF94KbpNVZO8TjA9fmofbo7SsrDx5DzETqvpaZ9bf2Kw4rfcj4o4wd?=
 =?us-ascii?Q?WnJFErj2LN4gKAujyQmQRSk4s4TdIhzl7xQCfGvtpWo4IAVsmR17yba2n0f2?=
 =?us-ascii?Q?t8yZEKE9lDSk18VBvWwpaZGwvapl3a9ykivarj41QYJLoyhjeWcxjTjt2xaC?=
 =?us-ascii?Q?5K3tnKG44VmnrK0zYrCgERqntetVGwFM/SBx6dIFKTqN4QlVAzjYgAqCSPEP?=
 =?us-ascii?Q?ry5ouVL6MXi8KRryGn0D8tKGFd2WGcp/8HQsdqUI6IS5uG+vVvwLVP/Fi0e1?=
 =?us-ascii?Q?jHAXy90Eae7SLmeTZiP3Huc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F88ADF628084EE429B353F8954FA6B6A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106b61ae-39e9-4a90-cf80-08d9befc4df5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 12:21:49.6752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ROgl2ILtAAfynD6pFXgqkxo+jjwsotq6lHse6FwV594hLFfCH2/Ms4qbKF3m9o6oIDNtbWxj1H3sNiJcX/AVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8292
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 13, 2021 at 10:14:34AM +0000, Filipe Manana wrote:
> On Mon, Dec 13, 2021 at 12:43:38PM +0900, Naohiro Aota wrote:
> > There is a hung_task report regarding page lock on zoned btrfs like bel=
ow.
> >=20
> > https://github.com/naota/linux/issues/59
> >=20
> > [  726.328648] INFO: task rocksdb:high0:11085 blocked for more than 241=
 seconds.
> > [  726.329839]       Not tainted 5.16.0-rc1+ #1
> > [  726.330484] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
> > [  726.331603] task:rocksdb:high0   state:D stack:    0 pid:11085 ppid:=
 11082 flags:0x00000000
> > [  726.331608] Call Trace:
> > [  726.331611]  <TASK>
> > [  726.331614]  __schedule+0x2e5/0x9d0
> > [  726.331622]  schedule+0x58/0xd0
> > [  726.331626]  io_schedule+0x3f/0x70
> > [  726.331629]  __folio_lock+0x125/0x200
> > [  726.331634]  ? find_get_entries+0x1bc/0x240
> > [  726.331638]  ? filemap_invalidate_unlock_two+0x40/0x40
> > [  726.331642]  truncate_inode_pages_range+0x5b2/0x770
> > [  726.331649]  truncate_inode_pages_final+0x44/0x50
> > [  726.331653]  btrfs_evict_inode+0x67/0x480
> > [  726.331658]  evict+0xd0/0x180
> > [  726.331661]  iput+0x13f/0x200
> > [  726.331664]  do_unlinkat+0x1c0/0x2b0
> > [  726.331668]  __x64_sys_unlink+0x23/0x30
> > [  726.331670]  do_syscall_64+0x3b/0xc0
> > [  726.331674]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > [  726.331677] RIP: 0033:0x7fb9490a171b
> > [  726.331681] RSP: 002b:00007fb943ffac68 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000057
> > [  726.331684] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb=
9490a171b
> > [  726.331686] RDX: 00007fb943ffb040 RSI: 000055a6bbe6ec20 RDI: 00007fb=
94400d300
> > [  726.331687] RBP: 00007fb943ffad00 R08: 0000000000000000 R09: 0000000=
000000000
> > [  726.331688] R10: 0000000000000031 R11: 0000000000000246 R12: 00007fb=
943ffb000
> > [  726.331690] R13: 00007fb943ffb040 R14: 0000000000000000 R15: 00007fb=
943ffd260
> > [  726.331693]  </TASK>
> >=20
> > While we debug the issue, we found running fstests generic/551 on 5GB
> > non-zoned null_blk device in the emulated zoned mode also had a
> > similar hung issue.
> >=20
> > The hang occurs when cow_file_range() fails in the middle of
> > allocation. cow_file_range() called from do_allocation_zoned() can
> > split the give region ([start, end]) for allocation depending on
> > current block group usages. When btrfs can allocate bytes for one part
> > of the split regions but fails for the other region (e.g. because of
> > -ENOSPC), we return the error leaving the pages in the succeeded region=
s
> > locked. Technically, this occurs only when @unlock =3D=3D 0. Otherwise,=
 we
> > unlock the pages in an allocated region after creating an ordered
> > extent.
> >=20
> > Theoretically, the same issue can happen on
> > submit_uncompressed_range(). However, I could not make it happen even
> > if I modified the code to go always through
> > submit_uncompressed_range().
> >=20
> > Considering the callers of cow_file_range(unlock=3D0) won't write out
> > the pages, we can unlock the pages on error exit from
> > cow_file_range(). So, we can ensure all the pages except @locked_page
> > are unlocked on error case.
> >=20
> > In summary, cow_file_range now behaves like this:
> >=20
> > - page_started =3D=3D 1 (return value)
> >   - All the pages are unlocked. IO is started.
> > - unlock =3D=3D 0
> >   - All the pages except @locked_page are unlocked in any case
> > - unlock =3D=3D 1
> >   - On success, all the pages are locked for writing out them
> >   - On failure, all the pages except @locked_page are unlocked
> >=20
> > Fixes: 42c011000963 ("btrfs: zoned: introduce dedicated data write path=
 for zoned filesystems")
> > CC: stable@vger.kernel.org # 5.12+
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> > Theoretically, this can fix a potential issue in
> > submit_uncompressed_range(). However, I set the stable target only
> > related to zoned code, because I cannot make compress writes fail on
> > regular btrfs.
> > ---
> >  fs/btrfs/inode.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >=20
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index b8c911a4a320..e21c94bbc56c 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -1109,6 +1109,22 @@ static u64 get_extent_allocation_hint(struct btr=
fs_inode *inode, u64 start,
> >   * *page_started is set to one if we unlock locked_page and do everyth=
ing
> >   * required to start IO on it.  It may be clean and already done with
> >   * IO when we return.
> > + *
> > + * When unlock =3D=3D 1, we unlock the pages in successfully allocated=
 regions. We
> > + * leave them locked otherwise for writing them out.
> > + *
> > + * However, we unlock all the pages except @locked_page in case of fai=
lure.
> > + *
> > + * In summary, page locking state will be as follow:
> > + *
> > + * - page_started =3D=3D 1 (return value)
> > + *     - All the pages are unlocked. IO is started.
> > + *     - Note that this can happen only on success
> > + * - unlock =3D=3D 0
> > + *     - All the pages except @locked_page are unlocked in any case
>=20
> That should be the unlock =3D=3D 1 case.
>=20
> > + * - unlock =3D=3D 1
> > + *     - On success, all the pages are locked for writing out them
> > + *     - On failure, all the pages except @locked_page are unlocked
>=20
> And that should be the unlock =3D=3D 0 case.
>=20
> Otherwise it looks fine.

Oops, thank you for catching this. I must have screwed up while
rewriting from "unlock !=3D 0" style (which is technically correct).

> Thanks.
>=20
> >   */
> >  static noinline int cow_file_range(struct btrfs_inode *inode,
> >  				   struct page *locked_page,
> > @@ -1118,6 +1134,7 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
> >  	struct btrfs_root *root =3D inode->root;
> >  	struct btrfs_fs_info *fs_info =3D root->fs_info;
> >  	u64 alloc_hint =3D 0;
> > +	u64 orig_start =3D start;
> >  	u64 num_bytes;
> >  	unsigned long ram_size;
> >  	u64 cur_alloc_size =3D 0;
> > @@ -1305,6 +1322,10 @@ static noinline int cow_file_range(struct btrfs_=
inode *inode,
> >  	clear_bits =3D EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW =
|
> >  		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
> >  	page_ops =3D PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
> > +	/* Ensure we unlock all the pages except @locked_page in the error ca=
se */
> > +	if (!unlock && orig_start < start)
> > +		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
> > +					     locked_page, clear_bits, page_ops);
> >  	/*
> >  	 * If we reserved an extent for our delalloc range (or a subrange) an=
d
> >  	 * failed to create the respective ordered extent, then it means that
> > --=20
> > 2.34.1
> > =

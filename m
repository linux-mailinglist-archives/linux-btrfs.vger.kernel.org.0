Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514C041BCAF
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 04:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243765AbhI2C0F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Sep 2021 22:26:05 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26498 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243226AbhI2C0E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Sep 2021 22:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632882265; x=1664418265;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=BwQer88BH3iMsTGH0BH/3ZE+DTFQLOSpTILl1NKpylI=;
  b=ojcqTYK4ieu669x9yy5V+wB5qn0p+Yk9nOcMNe2aEBe+p0axmUBTzGhF
   iK1WDCo0trdzibDRmSL3Bf3LJZVo7SzrmkuLvJYnLDfNhjbNpX1JneIpY
   P6X5dW+aJHTxXIBF9eWMv37Yab5407BT1VcbV5xWWi2GaJL87hVBDhlIP
   PxpJ9Nm6FWFMXP1oCXU5YC5nVuhrI9Ra3VyQfva33511BIUZWAyYoX862
   7R95Od2Gje+oInqeZ2L8OANnPFe5Dm54FhXpSALPk2sYPVPGy40GvsvBS
   djj8ROz2mmC8NqEMfZ1+zVyzXvkO0YGhoYfn63hBN4lCnQBm2jgV24wxg
   w==;
X-IronPort-AV: E=Sophos;i="5.85,331,1624291200"; 
   d="scan'208";a="181857567"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2021 10:24:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nw62G9bziIK49dWctKHD5HINS/5+KQcC5n3bvy5wh9dueNTpPW0jspzK/IxADCOCvrznYFN2ZPNm+oO0O4pwC0PNp+a42xHqZee0KP8n8uzl33knZbaWj4oxl3enClKNUQAwWcvmebLTv6K1De5vOPPEitD28lK9PsCfcLEgB6JhJY3qlxuOcL0RYEk5g0K/uKgziOpDMJBPdONg2lJ4vZPhCwV5aZVS73ss4V3oSPfc+SETL92sFHvypOik0QrsbovizfwWpnT3Nml3PtwnpeV8cSLr9XvDriOIPt4yezqygUu4V8hcFvLUmUVlgZmXQ0qA2vJSmLMUTOQxtzMWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=W+mXB6y04XxGTITTJLd+mIZ1cGKXMMDKhfo1M8kRNSM=;
 b=QBXLgmUWA9JednDhEJ7SD3kz29geSiX9JNOqyAHlaibjK0n1S8/nLJRs5rWjAoZsw2Gl6Iz85FBWt6iL0GQ8nZEYJYVd721VjVJuYyKJFKARIF0RR8AQ5TxxEQOiqzLo4cotOrc37D9q41jC819tnbhlNVpqI0lDOoi4BetuGggSnjB6b4Y22Bwx6gT1EaTCJNUCj2oMUV9nio1pB5XXEiv7jR9wRiDBwf7KiCVe0rtK9eatzEfVhEWFo8qZqe61AeOAZdptORxkF/TRMd5vcoyOXR6DoJDk/PvBTOv8gRM7qjO8xq+Oflfs6BJmfPomKuiN5lBBWRLmSYGjvPBvig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+mXB6y04XxGTITTJLd+mIZ1cGKXMMDKhfo1M8kRNSM=;
 b=tyCc6z41uJ8CW4ar9+cJS+N4/KySgyg4bEneIWHzn+bukaXVfuPF+VCnggHbHSqgyT1ATFNhno7ZDj57Q/Q/wg+wIQbp5oEbaLeao/jMw/VH5HOhmJ/AmBOzQ2Dedqk/PrCOb5lCVdJzE+jZLNSIWHhwNOIrAUI3KEjpkCAR/a8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7854.namprd04.prod.outlook.com (2603:10b6:a03:3ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 29 Sep
 2021 02:24:22 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555%7]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 02:24:22 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/5] btrfs-progs: use direct-IO for zoned device
Thread-Topic: [PATCH 0/5] btrfs-progs: use direct-IO for zoned device
Thread-Index: AQHXs1ZmcoYKRsLonk+Yign1+z8S5Ku4bQaAgAHehwA=
Date:   Wed, 29 Sep 2021 02:24:22 +0000
Message-ID: <20210929022422.mynjvx4angtb3vfi@naota-xeon>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
 <20210927215139.GJ9286@twin.jikos.cz>
In-Reply-To: <20210927215139.GJ9286@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d323d3f6-1884-4a33-3ffa-08d982f04012
x-ms-traffictypediagnostic: SJ0PR04MB7854:
x-microsoft-antispam-prvs: <SJ0PR04MB78543F6B94846BC2EF2AA0F48CA99@SJ0PR04MB7854.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2QatTn49tKixt1oPwWK7SA0DyP8bnT/7+ZsJ9fGioKl9qro4AGYp9xXtqAk80RMnE8k2k8Pvdr30R8LBi3A7+C/tgjN7AUqOaVI9ECzKbWmt88dIQTNaXe1TQpt+N1dlkk0FWElSKCpt8OjRBbA2s3jcOsK0NXtV47gTf5H/zSdvd3KQn+KMLKv8ne9nhklqdoqEA7++tkBlMHfKTJ496ndDDgFYRMBNWWNOFeJkHx6bsICdMTifr20syZgvoXsmW0ECQxLyaBUJ+0ycwpmd06iSefFLAoCoS3he4ndsRj42E32tzUX2//Yg/HhX8/SEzawgg0kRB00viafsx+KFi+ZCp+vvWFL0qn/UDOzANBZrkhPBs/yq29Qs6oogOfdJOy20BHeqgkRmU04aSfUVww+ARHfWNhccgOve7DnIPwnwM1WCHxqcfZlltkLHn8i32o7/pep22ov4kT6Ap4gkMm4B0cHx2kWSGrn6n4rnTXjmkSB/a6BCWR7vObC6mxvErXkq0e4L57o0ka2t5U8clc+UgM5g0tgPqQmHt3TD9kHZ7E437Q4dmVBdbd8HQnFBcvQ4b9rXAMeSGclzjKxAn7pAqtgEwr8JXHEz8KokaazDn76QC1cECKrRL8UjQ3XaXpNYSU3K4p2d6ikqKOaAYB+kc8YITv56vWjP9/FeSA6x45CMEwn4xiE0cA7agOEtz7KXEQq3WQucmSjZu0BlOqBgU48/dnrYUrAC1XnmOEe+K9NWLT2fgAvhz0/rT3xSNg6wK+uBcs/PL6ur3R6FWHF81uLKUuux3iB/woUs4Gs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(122000001)(38100700002)(8936002)(8676002)(316002)(110136005)(186003)(6506007)(26005)(83380400001)(64756008)(66446008)(66556008)(66476007)(9686003)(6512007)(1076003)(5660300002)(66946007)(2906002)(38070700005)(76116006)(508600001)(86362001)(91956017)(33716001)(966005)(6486002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jo5sDqMXTdcr4j/GoVqMOMsDpavMRBC78PdDxxRbDgnQfzbuRrfyCleR2/Ae?=
 =?us-ascii?Q?/4FjCvslpbFoc8H3USdGSjn8IM7duETZXZqdRVcD5LCX0Njec4qlVnMi1ul0?=
 =?us-ascii?Q?5IbVAD58R6hZCWgHG2xZp+ThJ1HRJJ7nrqduCycOfMfAHFYzEjS9JXSEkVWJ?=
 =?us-ascii?Q?d5vgBr9x58j/qTYzwUnkLRzXfc5xmD/dOQ++ap75OOmOAFImTxXuJjC1vJ+O?=
 =?us-ascii?Q?tiCFFiZpYPpHmoevmwMElCyNU/cEfpV6W4O+y4GyHabdcthrXHRh9+bjqWBF?=
 =?us-ascii?Q?HGzUCmQeSiNofUdUrMPuFbMzWNHqsvL8B+gC/RpiddxWn8n0FNv7RtayLsWq?=
 =?us-ascii?Q?EKA4ci55ixbELNzqurhbcodeaAEi+Aa9M3lg73RO+F6SbhzOkpnjlx0JO284?=
 =?us-ascii?Q?EGhkejz5T5Jn8K0HQdgZaO+VQ7iZ2lAtTuISBMvOSqqeXbsjhZ7Iis28rqgn?=
 =?us-ascii?Q?w8zt8QfVTItwl7hjy0XGQZ+oHmNNLUhgzjpNhEFmxmahRJETiw2RRCnpzxea?=
 =?us-ascii?Q?s2AkvS/+KCFVog3Mm44E5phcCx9+iE/L6qkjfAAUSaYxBBSxw5VRpMz2IB3j?=
 =?us-ascii?Q?KcvC+inH8ErVlvg7i61T+/ehHA6jR0QdCrE4ZXIXfBHkQjQLh6Y0Fl/unFlc?=
 =?us-ascii?Q?5IFoeqMqAOA8gQQ4qLxcnRHBTmX6PyNRGSYzwDAvgbDX/+V+YBbfZxGgObXx?=
 =?us-ascii?Q?S6AsfGd9BQKwCKSFvOZxsXaRbuGWHPGgm+mWjBhkkC5E8XvZSw0G1j2g9VDq?=
 =?us-ascii?Q?Vkrinnp2GEzm8Tm652aUO4ELPxwPwGC7JMjgL/nOV9nuXOO0cUW40z5JYnQQ?=
 =?us-ascii?Q?rNS9yy2ElgJatlMFnYpa7LHWwq8K4uPz4kBqXt7MfZcbyW44RGkWrskRIrP3?=
 =?us-ascii?Q?uDheex0zFfJpvgk3DxDPMVHZ1yWuCM83zkr3Xzto3PoTCQ3bbfiEc5lg8y+r?=
 =?us-ascii?Q?ZeNXpakFUSA/YX+tr3wbJcwErbu2BGcLt9sRph3QG+S/qykgmPPKVKyOaqJW?=
 =?us-ascii?Q?BO+WhbxrmiLV0P93alJmPITQjrKTrtKkjw4kpCE2JQyYxjK9pcqTdGFh7ivN?=
 =?us-ascii?Q?/4Zq4Bw52xw5QzTvwjaczjBSUMf4trdB6wvjw1n2G5haNZFcj1HE9PJmdD6x?=
 =?us-ascii?Q?hJv9XCsXl5bxcgFpfGxYo0ouhdyujyL4j3PhpGVwaxxzo19dTkqaD1NV7pCW?=
 =?us-ascii?Q?RbvQJJKl4KniBa01XUEqxKNrILIL7UZ/ZRKDam2OByRztaADxzyyKDpGtvhX?=
 =?us-ascii?Q?o5StrGNV+cwCqKTfsKlRaoEpRMFBRGBlWXqV7INkhdg+FNl184IIXk42xD9X?=
 =?us-ascii?Q?C2UrtaKgq1FcpHXOTSa5D+jpbKM9fHoGME3wch5fTzajRw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ECC3F22A26B5A84DA483B2E75C1465C8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d323d3f6-1884-4a33-3ffa-08d982f04012
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 02:24:22.6752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qnTAx+4erYXS5ScG/WdUSw3PIs1mhUKIl75cBhMJzoZPOTmR+/YPQFkWVouYKM/YabjDwNN0cKXg8m9M+nAAUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7854
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 27, 2021 at 11:51:39PM +0200, David Sterba wrote:
> On Mon, Sep 27, 2021 at 01:15:49PM +0900, Naohiro Aota wrote:
> > As discussed in the Zoned Storage page [1],  the kernel page cache does=
 not
> > guarantee that cached dirty pages will be flushed to a block device in
> > sequential sector order. Thus, we must use O_DIRECT for writing to a zo=
ned
> > device to ensure the write ordering.
> >=20
> > [1] https://zonedstorage.io/linux/overview/#zbd-support-restrictions
> >=20
> > As a writng buffer is embedded in some other struct (e.g., "char data[]=
" in
> > struct extent_buffer), it is difficult to allocate the struct so that t=
he
> > writng buffer is aligned.
> >=20
> > This series introduces btrfs_{pread,pwrite} to wrap around pread/pwrite=
,
> > which allocates an aligned bounce buffer, copy the buffer contents, and
> > proceeds the IO. And, it now opens a zoned device with O_DIRECT.
> >=20
> > Since the allocation and copying are costly, it is better to do them on=
ly
> > when necessary. But, it is cumbersome to call fcntl(F_GETFL) to determi=
ne
> > the file is opened with O_DIRECT or not every time doing an IO.
> >=20
> > As zoned device forces to use zoned btrfs, I decided to use the zoned f=
lag
> > to determine if it is direct-IO or not. This can cause a false-positive=
 (to
> > use the bounce buffer when a file is *not* opened with O_DIRECT) in cas=
e of
> > emulated zoned mode on a non-zoned device or a regular file. Considerin=
g
> > the emulated zoned mode is mostly for debugging or testing, I believe t=
his
> > is acceptable.
> >=20
> > Patch 1 is a preparation not to set an emulated zone_size value when no=
t
> > needed.
> >=20
> > Patches 2 and 3 wraps pread/pwrite with newly introduced function
> > btrfs_pread/btrfs_pwrite.
> >=20
> > Patches 4 deals with the zoned flag while reading the initial trees.
> >=20
> > Patch 5 finally opens a zoned device with O_DIRECT.
> >=20
> > Naohiro Aota (5):
> >   btrfs-progs: mkfs: do not set zone size on non-zoned mode
> >   btrfs-progs: introduce btrfs_pwrite wrapper for pwrite
> >   btrfs-progs: introduce btrfs_pread wrapper for pread
> >   btrfs-progs: temporally set zoned flag for initial tree reading
> >   btrfs-progs: use direct-IO for zoned device
>=20
> I was doing some btrfs-convert changes and found that it crashed, rough
> bisection points to this series. With the last patch applied, convert
> fails with the following ASAN error:

It looks like eb->fs_info =3D=3D NULL at this point. In case of
btrfs-convert, we can assume it is non-zoned because we do not support
the converting on a zoned device (we can't create ext*, reiserfs on a
zoned device anyway).

But, I also found a similar issue occurs with "mkfs.btrfs -f -d raid5
-m raid5 /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3" in
read_extent_from_disk(). Let me check which is better to ensure the
fs_info is set or to check if it's NULL.

> ...
> Create initial btrfs filesystem
> Create ext2 image file
> AddressSanitizer:DEADLYSIGNAL
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D18432=3D=3DERROR: AddressSanitizer: SEGV on unknown address (pc 0x0=
00000496627 bp 0x7ffe5299e4d0 sp 0x7ffe5299e4b0 T0)
> =3D=3D18432=3D=3DThe signal is caused by a READ memory access.
> =3D=3D18432=3D=3DHint: this fault was caused by a dereference of a high v=
alue address (see register values below).  Dissassemble the provided pc to =
learn which register was used.
>     #0 0x496627 in write_extent_to_disk kernel-shared/extent_io.c:815
>     #1 0x470080 in write_and_map_eb kernel-shared/disk-io.c:525
>     #2 0x411af9 in migrate_one_reserved_range convert/main.c:402
>     #3 0x411fa5 in migrate_reserved_ranges convert/main.c:459
>     #4 0x414088 in create_image convert/main.c:878
>     #5 0x416d70 in do_convert convert/main.c:1269
>     #6 0x41a294 in main convert/main.c:1993
>     #7 0x7f7ef7c2753f in __libc_start_call_main (/lib64/libc.so.6+0x2d53f=
)
>     #8 0x7f7ef7c275eb in __libc_start_main_alias_1 (/lib64/libc.so.6+0x2d=
5eb)
>     #9 0x40ed04 in _start (.../btrfs-progs/btrfs-convert+0x40ed04)
>=20
> kernel-shared/extent_io.c:815:
>=20
>  811 int write_extent_to_disk(struct extent_buffer *eb)
>  812 {
>  813         int ret;
>  814         ret =3D btrfs_pwrite(eb->fd, eb->data, eb->len, eb->dev_byte=
nr,
>  815                            eb->fs_info->zoned);
>  816         if (ret < 0)
>  817                 goto out;
>  818         if (ret !=3D eb->len) {
>  819                 ret =3D -EIO;
>  820                 goto out;
>  821         }
>  822         ret =3D 0;
>  823 out:
>  824         return ret;
>  825 }=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E52735C7F1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Apr 2021 15:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbhDLNuI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Apr 2021 09:50:08 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24966 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbhDLNuH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Apr 2021 09:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618235389; x=1649771389;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AOgKgrhI1PsbOM+ccB/UAbIyAk9krXgoDd4ixwddpMs=;
  b=KOVvnTwabqauFTizntM9P1/O1SNwLLrYcl8trRcJuR2FxzkWKnjEOAcZ
   Xw56C0nrIyWeQvSaDqRsadk22FI5KoODpVY8YBussp2AM7cHxDfBc/t5L
   2JgN7fBECDgAlelnBS4wTwzooNKC91omYUXon4YK5JveZ/UXGaQUaPvIC
   6A07pwRJ9V8ydHkAQLUcIhv2i5ca0n0lqackDc1CyI6EiKIjcEVSmc7wh
   QZO6PmoKecWm9NuKMnuMbWIeycIOLvQCmaQMLl3BCTroB2IbcWWQ7tEWa
   DCKfOdQykZRvDjOEZa+Yr8NGxjqrQwm6pOyeNx7Mw0x1/JafBt/Jvqq1L
   w==;
IronPort-SDR: F6qduJYAGVJZ5r7mIwZUMUMuzccQeDSatLElMhKgFjg1ipnNHyW6usgupIPAQhyCdndxq7e2OZ
 5d02OQXVuUldVIFa3iVDWoPdmrAVSsg7QSZu9zVutn2dZ5LOPKjZW/KT2TWlOfa2fQTaJskntn
 z5UPAgN16hNIRZCVOmuYCuwrs5NihZdu0hTyTbZefdTz8ksufaNBM06tmV4wH4LxazpqeX6LlO
 EHxYxcXUkzR1PSAfLv5GaB6PbYhLiPG0bJaj8B/6pLyDlgkQrPYYhuogcZP/L70n2hcCF9Z5US
 iR0=
X-IronPort-AV: E=Sophos;i="5.82,216,1613404800"; 
   d="scan'208";a="164489479"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2021 21:49:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekV7Bp591/vDuphGkI6K/SztRzPG46GRpwMtNvsJEhsGnGrbse2N5QGxPWc2HTK6Ibyn3NxLDkngg6nYP9Lf3ey0Zdubhpu9SDDRuUx2/4unlWhpn1ItacrwOEz2KpnUAvc8SgGsSvt4Q3wsqNoTWrBgFIwOqamgXdYeIpUdvcleWEP5dx0zX9PGTxiM1CFtltlsblj7wiPd6L90+LHjBsvRq2Kf2sTJi8XDARaWI2ay+9g1WF8AtADv6ML0j2LPLJOo3Illm8RlTzK/vrp/ebhhqKlJZLwYWvjeg9E9AauiZWC8ormNW79AhLNadY5aNchOf504fFqIup4gwIusCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ghk5Y4qQ/uOF633B8TeZ0YRFNGAsH9vJKu4zFGTBwQ=;
 b=OiQRXXLF7oh+vtPP1ea20XMvaSGiK7tU9vlN7jpc6l3bUwHZR26LcrDtEYGSMeiAGN8XK8dmQNenDJHeBaVzgFgxRRsFycDbTK8rp5f5xliTGbUu1GCwnYAqrA+5Fu9vgpD9Sb0s/uFaU5VEBjKTyoC26kpW1jX6olZFmDBpxp5Iw+ZDZpDA4AllAzzVpJESMYJ4bYfyAT3ggYA68a0XeyjCGt+++SWuU2z6/BzrfVUbQ/jlT9kh2L3MCmeOEcH45T9kpTF/8Cw/ru9/Lgar/uXDEmnYMp6ceJ+fgCBrKY4LUjnvcuZZkaf9tVsLFqf96WtAXUCy1Y5aTtrifkdlNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ghk5Y4qQ/uOF633B8TeZ0YRFNGAsH9vJKu4zFGTBwQ=;
 b=vphmIUIoMehwzKNN5PyHGUFQYsIWjdIyuRh90S2OiwKoNo55Ao9d0J106BbkODrQju+SU5XHqaHmK7+6ktvMUqavJ1xf5uKQfpZVvscGvz0sM4GAhope1zhD/wdSWIGy1n0g4f+ujppfMmH8m/Orm4aJCzIfV5OnGU0nnu5HNrQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7287.namprd04.prod.outlook.com (2603:10b6:510:1c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.20; Mon, 12 Apr
 2021 13:49:46 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 13:49:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 1/3] btrfs: discard relocated block groups
Thread-Topic: [PATCH v3 1/3] btrfs: discard relocated block groups
Thread-Index: AQHXLS6OQPw38ZTTm0ORPeiHMuNyDw==
Date:   Mon, 12 Apr 2021 13:49:46 +0000
Message-ID: <PH0PR04MB741605A3689AA581ABC6CF3E9B709@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1617962110.git.johannes.thumshirn@wdc.com>
 <459e2932c48e12e883dcfd3dda828d9da251d5b5.1617962110.git.johannes.thumshirn@wdc.com>
 <CAL3q7H4SjS_d5rBepfTMhU8Th3bJzdmyYd0g4Z60yUgC_rC_ZA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34a75a2d-5691-4180-9e21-08d8fdb9d555
x-ms-traffictypediagnostic: PH0PR04MB7287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB72875A09C72769FA4C1E6CE69B709@PH0PR04MB7287.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BOf1PQrawUX23Ni21IM3APD0bp7UBHvNHFE8o0j+bkeqFYISwnYY4mQfx0P53u1cSz6TQqJ9A3J5KrDWOVMkg6+7lJSGvtEK00ucW+JEc1+LffUIxOM0yLuPoAnHHMR8J9PI+i5TRC99KC6XbzxK6pIInAtqKHeO57jpvhZ/8q/Tj8zoTYgNGTR8cENTUzjcrMx15ShNoMJo1Sau/3P2d8FOKSq6MkFVXkp+gORKO1uquV3q+wIZgLqRMtRpjOILw5shIWoMyLkBdkQIMzgY9zG0DVbjEryx5iqYEZoi4492f+hkn+czkkd8hMtvTOcZSTEqk+JhjEgqa/oVvZo7u/Z81mVsbLH66GSiBUKlisbsB2p2tf92uomzAD0Wmxu6F5o1CZgpmsPkV53j6P9MCzNFSP+20hhPs7DS2g3P4z+DBFiecuglHoivcRuUeYkmqNhCLkqwz8KOgNCZtaTkFZDjGq9eQF5qS9oAPeWUbzUrODw3FYGEJAd+EWGDx2Wm04w8XPdSMaN3njci/olR9fPfpkFiiuGv4RSf4i/IKirnmILjoDmqm92n9WNMhcMKJYKITUPF/BnRGoXLTdCm9gcOa2tfv4Xknn37ThIqKUw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(86362001)(186003)(52536014)(64756008)(5660300002)(2906002)(54906003)(38100700002)(4326008)(66556008)(76116006)(83380400001)(71200400001)(26005)(33656002)(478600001)(66446008)(66946007)(66476007)(6916009)(7696005)(55016002)(9686003)(316002)(8676002)(6506007)(8936002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?p5EwvgdvLPPCgXGgLP9/qcXH6dmfJbDqW9dZjTrs0AhEFMlkOCAJ866FbfIa?=
 =?us-ascii?Q?/noP9NoHA4nqBqxYVmUAdCGcMJoxNKkprA4Dm0OYr51y1JlBvFGkjOSAhVsB?=
 =?us-ascii?Q?c16PWQVmL5T7gp6NhiXA4md6AD0V8XF/rvjmZaHXXtCMzfk2/tPZRWJV2aQw?=
 =?us-ascii?Q?LDAKaBQJy+SPX8NKH5qYA6tWCDxibOgFmcgsoaMJdSuKValDtMH3HTT+8d7j?=
 =?us-ascii?Q?1HdlR0B8m5ANSOQPPujXp4Rqr6wmiYBzYpqZkaSUcZ6odD+qTeB18eQ6Keb8?=
 =?us-ascii?Q?+V9N0NjBEeRBtENS2uNNiOM7VUThrp6R2m/OywQbLo87tCuLSlrJZ4CBrKKS?=
 =?us-ascii?Q?43U/l0EfE4ISkGgkatlsZ7mhsYuS0fYix4j43Mj87OnRF8OyMCRHi3gn6848?=
 =?us-ascii?Q?xuGzct0nFojMB5iX9pBslx37mNSo4FDjtSEOPzaJWtgVEANG3y9Qy1LPb/8V?=
 =?us-ascii?Q?28ZYW01evubRFTUiDl01LqPFWwu7A7kMEwNTweSr+rSErSe7jNH824u12aqF?=
 =?us-ascii?Q?+pa+SuClOoZWRkS2B6PDIi0y0hRq70cKUoJY81PtNeKmcyEIn9PQczbHCk5i?=
 =?us-ascii?Q?v+skodAf8y3TH9/3VGQpO2+LED7srm4Dv6d7CUlNmhJ3fCjFBkU1TpVLX75J?=
 =?us-ascii?Q?IuPwV/TUhZjCEpqDm+lPEN7yJ8bDUsKMmOtkfw6mFADErQbH9WgUFx5egnVH?=
 =?us-ascii?Q?689FkS25cFtuwQ8jOKpXjDl+GUeOUNbGbP4nQfxZod607Zrrb6NWW+eAErQ9?=
 =?us-ascii?Q?n3zySEGkOsW1OIupPUsguNNhhb2pnlD8/xQHpm/Dn/XY2yoVaTl9QtDppkoQ?=
 =?us-ascii?Q?MUPv3jOtytMvCxnz6HMzbo6/8ILhz/R2Oowf4YiVRiOv/F9+8VMcYu/Uk5bN?=
 =?us-ascii?Q?WX0Er9NU/hURocSOlKs+By9sg5Wbwh0jpNgBWMCqVjo737nwit2WBJwy8sAq?=
 =?us-ascii?Q?gJlJP8dsOnEJY5ug1Y4bmW+wFN92JNzVBfWE9gtnsulaBc+CJBrgXMiImZYm?=
 =?us-ascii?Q?pZhqRsRAHlw/fNk+Geh7sJFLx2sR5lhVe/MPiH1ifBi5V4bGQr73B44v8hx1?=
 =?us-ascii?Q?GK2vd5iyRU5ZQXk2XKlipcdbfzDv6nkHSKKHBzpt3kzWMzXmqJ9V5O3u/9eI?=
 =?us-ascii?Q?I+mRyzpGC6CO72AzLvqJwRwTSGjefJE9rCjcfEnMp2MsdOcCSFytZZVOZ+8u?=
 =?us-ascii?Q?6hKPfeXaTlzp0aBeEVNzt/wZIDvGqpOR2VxH1vpcfY9ioGWDOXIUI5tKZMre?=
 =?us-ascii?Q?4Q7v7SJFXhFZ9fQo3dknC215bAYquU9KrkHUzceo4wmwMJ1oHzQkV36Aqq+T?=
 =?us-ascii?Q?rioUSQtH+91tP+vjkknm2k2u/dFLhfFble2MJR+ztSJX5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a75a2d-5691-4180-9e21-08d8fdb9d555
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 13:49:46.1446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pntcRf5aoJylVwT76SsoqULorQuwU+lrEwQGwbxa0O6Usn2D+ljrAws4xPeyBzpgNdBIZZO7Cpu8VCQfsP7jIQrTlKSqWkj+HZ6KznB4+b0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7287
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/04/2021 13:37, Filipe Manana wrote:=0A=
> On Fri, Apr 9, 2021 at 11:54 AM Johannes Thumshirn=0A=
> <johannes.thumshirn@wdc.com> wrote:=0A=
>>=0A=
>> When relocating a block group the freed up space is not discarded. On=0A=
>> devices like SSDs this hint is useful to tell the device the space is=0A=
>> freed now. On zoned block devices btrfs' discard code will reset the zon=
e=0A=
>> the block group is on, freeing up the occupied space.=0A=
>>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>  fs/btrfs/volumes.c | 13 +++++++++++++=0A=
>>  1 file changed, 13 insertions(+)=0A=
>>=0A=
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c=0A=
>> index 6d9b2369f17a..d9ef8bce0cde 100644=0A=
>> --- a/fs/btrfs/volumes.c=0A=
>> +++ b/fs/btrfs/volumes.c=0A=
>> @@ -3103,6 +3103,10 @@ static int btrfs_relocate_chunk(struct btrfs_fs_i=
nfo *fs_info, u64 chunk_offset)=0A=
>>         struct btrfs_root *root =3D fs_info->chunk_root;=0A=
>>         struct btrfs_trans_handle *trans;=0A=
>>         struct btrfs_block_group *block_group;=0A=
>> +       const bool trim =3D btrfs_is_zoned(fs_info) ||=0A=
>> +                               btrfs_test_opt(fs_info, DISCARD_SYNC);=
=0A=
>> +       u64 trimmed;=0A=
>> +       u64 length;=0A=
>>         int ret;=0A=
>>=0A=
>>         /*=0A=
>> @@ -3130,6 +3134,7 @@ static int btrfs_relocate_chunk(struct btrfs_fs_in=
fo *fs_info, u64 chunk_offset)=0A=
>>         if (!block_group)=0A=
>>                 return -ENOENT;=0A=
>>         btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);=
=0A=
>> +       length =3D block_group->length;=0A=
>>         btrfs_put_block_group(block_group);=0A=
>>=0A=
>>         trans =3D btrfs_start_trans_remove_block_group(root->fs_info,=0A=
>> @@ -3144,6 +3149,14 @@ static int btrfs_relocate_chunk(struct btrfs_fs_i=
nfo *fs_info, u64 chunk_offset)=0A=
>>          * step two, delete the device extents and the=0A=
>>          * chunk tree entries=0A=
>>          */=0A=
>> +       if (trim) {=0A=
>> +               ret =3D btrfs_discard_extent(fs_info, chunk_offset, leng=
th,=0A=
>> +                                          &trimmed);=0A=
> =0A=
> Ideally we do IO and potentially slow operations such as discard while=0A=
> not holding a transaction handle open, to avoid slowing down anyone=0A=
> trying to commit the transaction.=0A=
> =0A=
>> +               if (ret) {=0A=
>> +                       btrfs_abort_transaction(trans, ret);=0A=
> =0A=
> This is leaking the transaction, still need to call btrfs_end_transaction=
().=0A=
> =0A=
> Making the discard before joining/starting transaction, would fix both th=
ings.=0A=
=0A=
Note taken.=0A=
=0A=
> =0A=
> Now more importantly, I don't see why the freed space isn't already=0A=
> discarded at this point.=0A=
> Relocation creates delayed references to drop extents from the block=0A=
> group, and when the delayed references are run, we pin the extents=0A=
> through:=0A=
> =0A=
> __btrfs_free_extent() -> btrfs_update_block_group()=0A=
> =0A=
> Then at the very end of the transaction commit, we discard pinned=0A=
> extents and then unpin them, at btrfs_finish_extent_commit().=0A=
> Relocation commits the transaction at the end of=0A=
> relocate_block_group(), so the delayed references are fun, and then we=0A=
> discard and unpin their extents.=0A=
> So that's why I don't get it why the discard is needed here (at least=0A=
> when we are not on a zoned filesystem).=0A=
=0A=
This is a good point to investigate, but as of now, the zone isn't reset.=
=0A=
Zone reset handling in btrfs is piggy backed onto discard handling, but=0A=
from testing the patchset I see the zone isn't reset:=0A=
=0A=
[   81.014752] BTRFS info (device nullb0): reclaiming chunk 1073741824=0A=
[   81.015732] BTRFS info (device nullb0): relocating block group 107374182=
4 flags data=0A=
[   81.798090] BTRFS info (device nullb0): found 12452 extents, stage: move=
 data extents=0A=
[   82.314562] BTRFS info (device nullb0): found 12452 extents, stage: upda=
te data pointers =0A=
# blkzone report -o $((1073741824 >> 9)) -c 1 /dev/nullb0=0A=
  start: 0x000200000, len 0x080000, cap 0x080000, wptr 0x0799a0 reset:0 non=
-seq:0, zcond: 2(oi) [type: 2(SEQ_WRITE_REQUIRED)]=0A=
=0A=
Whereas when the this patch is applied as well:=0A=
[   85.126542] BTRFS info (device nullb0): reclaiming chunk 1073741824=0A=
[   85.128211] BTRFS info (device nullb0): relocating block group 107374182=
4 flags data=0A=
[   86.061831] BTRFS info (device nullb0): found 12452 extents, stage: move=
 data extents=0A=
[   86.766549] BTRFS info (device nullb0): found 12452 extents, stage: upda=
te data pointers=0A=
# blkzone report -c 1 -o $((1073741824 >> 9)) /dev/nullb0=0A=
  start: 0x000200000, len 0x080000, cap 0x080000, wptr 0x000000 reset:0 non=
-seq:0, zcond: 1(em) [type: 2(SEQ_WRITE_REQUIRED)]=0A=
=0A=
As a positive side effect of this, I now have code that can be used in =0A=
xfstests to verify the patchset.=0A=
=0A=
Byte,=0A=
	Johannes=0A=

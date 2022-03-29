Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0C24EA69E
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 06:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiC2EfQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 00:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiC2EfL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 00:35:11 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8164710C2
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 21:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648528408; x=1680064408;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wN/E2VKxDFlB8Xcx2zZtQrv8kxwLcWrokKYTiNFAjAs=;
  b=d+LZkCn414vVhvZOSXWHoryL9epfm1oXXVPiEV4iVyZe1q++ytu6SDUL
   YA4/8eHG5XxfyRvTUtKvlAuFZo8I7xcPWsBFsEtROL6rmEaSiLlOlNYtB
   VDxCJ7u17zl9R12ZLY6glCOXexFhuLS6hv//uJFNZmtHO2Z1y+xr+igHy
   D0wHUJMUNF4ZGDBII/RCD/xd6oTEzEi6n6E9vnXjtseuQbo/xcHUfrMuS
   bdI2e+kRLMAVnH7dOkTpQvy91WxWmLqKRfrWPDMtW4Pa5hCGaHb8ow6bL
   5CbzJ2kqUFUtW2l7pfAy6GVrl/0DsRyNGYBSzNADU0zIlX0r8zEBXu4Zd
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643644800"; 
   d="scan'208";a="197420448"
Received: from mail-sn1anam02lp2044.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.44])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 12:33:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXVqomUCE6lGqMDDgWEIi5ubj3i32ZHDY5Bd+oZkD8lvp6bgjk1BNeWM0/uK+ho5p+aRGQWEO03CH8N32Q5OwGYCLnHiXMXou/t2q83CnmwGY+xQRxaxrMiRBRKpslo/arPuSwhH02ALAGuDctrBCfsoW/pViXHLHcAXhqCcvdkQZ9iTFo9z1g2WtrjqHqAlOvUz4BFEwGqIXB41Rr4g0OTD7GH+pFmTpcvyJsSf/Wif2GwJVlFy6F9j5oedn77LYAai9cKEAyYEmS7E8w1oGZs4RZ5OkEQD5iopx91IIP6u6J2eCHnQlgu/kCnXw3WHxWngmyLzBPtpZzJLOxzhbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3vMu1TZmrXzUgukh7VQP66srCw9D5jnDlU4bLf0nQA=;
 b=FRRmg1ScKgBc9Jfz5StZsz6IGdlkiSA73DfHCAmKKgoe35o5DafmgJ5q+OifCDLp/a3wzjEHCJFq8/ZUiVO2Scu537V+NnIyIiVPdsTn+/G/OnklpkAFlfY+dE9DcYH9N1DZCYuUD9GJ1kJEqcOXg5rh5Khx8PwXbw2bwZk++lpmIOQsvniLsu5eottMGUGjvptm/ALB18FKNqoTowWe5UkcD1P1nal0aQrfQVly8triWb8OIrZMPE9eABZRZnA7izBLfYBTNu/tMwd51u0+3ybITSl/evTeXtrAVtVKEnRXzgMWpXe2IHGGzQWJaXpdh+TLrugZbdhi2iCOvRnydA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3vMu1TZmrXzUgukh7VQP66srCw9D5jnDlU4bLf0nQA=;
 b=RDO66Ip01kNSJ1U6XxG7LjJ0DojOJ+OFnGL5JSR1ET/u4sSIefUjrPn58lItD3+o2i4a6Oodmgob8DUFQkYDfVf8GGrApjh9iCQObBr4ij6JtX4FjRs29rd3Wu8fiAU9XTmAXJXl5YZsI9jycXpdXGB3mpXuL3eGmAFYTW/eD+c=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BN6PR04MB0530.namprd04.prod.outlook.com (2603:10b6:404:92::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 04:33:21 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 04:33:21 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>
CC:     Boris Burkov <boris@bur.io>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
Thread-Topic: [PATCH] btrfs: do not clear read-only when adding sprout device
Thread-Index: AQHYPYAIHm/MMGpi4kCI69yVOdu43azMJXqAgAEj24CAB2TcgIABIwsA
Date:   Tue, 29 Mar 2022 04:33:21 +0000
Message-ID: <20220329043320.bak6zyigz2g5facj@naota-xeon>
References: <16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io>
 <20220323005215.22qkdgherdyrocuq@naota-xeon> <YjtkE6DkhV0V0gXq@zen>
 <9770fbd0-e122-6892-4149-45bb6f988961@oracle.com>
In-Reply-To: <9770fbd0-e122-6892-4149-45bb6f988961@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59fe9d74-d9da-4eed-a009-08da113d419c
x-ms-traffictypediagnostic: BN6PR04MB0530:EE_
x-microsoft-antispam-prvs: <BN6PR04MB05304E6C001331D5853906EB8C1E9@BN6PR04MB0530.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W6BTra6R8rGdr+CifuKTBEymEkidAPus6owGTyICJ1/59pQvciMN10oVAI8wa1dR/dO7/og85XbPXxDqnp0otb8Q5jurFCTqfZt9oK435Cj25GqS9vDfnZ+PX9IakjHUoja6p6omjkOPdOxp+9r9grOPINU91rm/BLSs7G1GmXeILmn4n48WHo67gC9pterQcxEmzPmui1DBqNxXYHEBlpydVn//JOE2Q9fUZQJIE1JPnflCq7m5aQGf4kOqpkz2unWmnWt+rcoAzx9lYUAR37iwXtWgYDWvgHZTK/VV726cokxzli5uDOBYMEpbO5BGBHJPlEHi9rUWH5vpX23ZtEJDTYldRMjiJBjBfbiy5gzvSxYJE5ayO7uXmyVzvEA5fAjaO/kHPh2xIpHRC6kej/wEkp5jdaHzcokeGz3kydH01A/azXWuucGv3zMyX0ttMlL7vA284rsCQLllAodfO6nGJ3kssQzZosRNa6kYPrUbcU/ToZu6wiDzpFRdjHzR7lad2JqwFWN6P0Ga1Lx5A4csL3WKDZLpCXp0YDf1gJi42JCwPeljeXD2YMC4DWU1R0s6uRVOjUmL7CXonSXaIEyIR05FYzWXb16n6tGHnRhyjkplALVoKslhJSFEbcu0kUqCxUrLlSGOUv6cyTn2csOBe6OUaMZjESj8bOHBrc2fjlOsHHnnJeFWhzeRbdd/Myl3QJ/Qyky1UnsPsV6LZAviybtJTILdCVerrdSkb5paq2oHlkR+3zl7HiYSEVcK0QFIM6tMKN2eCN/W9B626xGsBdEniCXnc/zb+n9oAyQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(8936002)(6486002)(122000001)(966005)(38100700002)(82960400001)(2906002)(316002)(508600001)(83380400001)(6506007)(53546011)(9686003)(6512007)(86362001)(33716001)(38070700005)(186003)(26005)(1076003)(66476007)(91956017)(66946007)(66556008)(76116006)(66446008)(71200400001)(6916009)(4326008)(8676002)(5660300002)(64756008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?arw/3kTf40wRH3Mi2CVd+FJwDi/luqKprcpzokpKON1xIiJGJmHg0pE1fFkF?=
 =?us-ascii?Q?aLwCGjp2TrbXi8YZCq5Sb0WQk+qWlxjD+8PzYl1vi5k+gaSvue5beHhw5Yga?=
 =?us-ascii?Q?86Mw2KPZVlzSHpdMA5rHFdn3oSygmxRlEXbIMGaEYo9CHcG/h6SVB8f1HesO?=
 =?us-ascii?Q?1K3SmQV0WR0OtCZsANxSGbg1zPZcV+NBSpL+NRwHockPxmAxC8Oh4CV109cY?=
 =?us-ascii?Q?h70hLiHtuvsmzkurC++RexnQf0VNUnWDzw/M1uP+pC6eVRotqYqupLauvFwH?=
 =?us-ascii?Q?OYYndSFcPWgWouIkUD6bMi2ZflPA7mIVz87sB6oqjDP719I1C4yDhK5YgjLy?=
 =?us-ascii?Q?nNODq6b63JuCgcEO+bcUq5HTTbXAKMlImsCyO7zsqlptKrb6wALI3xzGAd8B?=
 =?us-ascii?Q?uCYetBLsOFk8iz7uCGaeLSzK4GBYnrcImSHMjCiEZs06ssmzExYdsH7StQMo?=
 =?us-ascii?Q?shy9P/qrLw5q8PoAHfTKQx5iFMHRLOqgHtNqaAZLriSppCdEPjqUwulqtCNB?=
 =?us-ascii?Q?6NMWeYqeR8uKT9f6SO9Eh109gNDwSCkT9lwJ/z/JMQwcFvVGXv/b+TFjaKJ+?=
 =?us-ascii?Q?1A4M92erLZWP0zcq3jL9kJIQkUrFtJwm6adkxExEyv5mOqQ9rXeOGAVcmFn1?=
 =?us-ascii?Q?h22+H9MyNeCFnYYKoJVkGu7Lg0UXYyPya3HdRjla761aBgb6hO72XUoOzoEd?=
 =?us-ascii?Q?VmuU7IAFSv3sMr79dkGUbXpc4HQMVmlc+NnfRIsMl1LaZJHmC9bSfMgFDzC7?=
 =?us-ascii?Q?mfUNhRp4/xWCs15IzjeP+C1hIdUq5zt9BbICnBQXKAJ74LyIMq8Fj00/+GXY?=
 =?us-ascii?Q?bzDkVe0u2Ni6oDC1dL32YxST26jprgJFaw/uIuRTbZnfKBIwziHxCOfTMPmg?=
 =?us-ascii?Q?Z9+DyJxhOd8MGf5v9qsrpf/jP/WPclXaxFlgjJ88D3I7zPENEYf+K3JXW5Gf?=
 =?us-ascii?Q?p6NiYkZQiq/90lRSFYdgNzlAeXy4FToZyoMALeUQMwKNZvNzFWetylp8Aiq9?=
 =?us-ascii?Q?SKXwvKEJYAaNNjiSerkaDmVPXCWRnTw13Xr2l8gv7VAqMsBehinyllkXYwc1?=
 =?us-ascii?Q?7yw2U530nTm6uoPIi5qQkdZDlLvyar99wwjfyTt9VhGFeymxbYZ0xvZjh877?=
 =?us-ascii?Q?w0V/ruEO9MqOFyxpYKGp2gd31Lu8Erz2pxOX7f/ZULE7cFHjF7ZrPA4PFD9O?=
 =?us-ascii?Q?3XZMC3WOyHvoyxcZ952msKdWzeczSUeS/zM6Sus8BRByd6SFMzhN44l+7Hhs?=
 =?us-ascii?Q?xhTCR3393XwNgavmbFO3ZyDrhC5T/QzOguGxxtrHQCyFJx/1XMKXO+XSY9y3?=
 =?us-ascii?Q?UzTDDchAp8zefAw9+coKcTZ7SCkOiOQZKaLq0ze5MDZPkmYy3xrnBfrZyMaU?=
 =?us-ascii?Q?geefUa436KrEZlc0chkIaeH39Vfew9Rcx+O9MaNGRTAz3f7EUADIWul6HVmT?=
 =?us-ascii?Q?T/bIbjDTN3dp23ntLFQwTH7jCkgvs3jZLCs0ZEbbP9l9g0fdqLn3foUjxfN4?=
 =?us-ascii?Q?N1M91HPY8IN5cvSBehnF1COxZv5dndikHe+JAElwCotmK/IjFlIVdCS9GD3/?=
 =?us-ascii?Q?fI2slP6qxZaUd5SsRTae4ORNlFFCUFLerysgDiTq8fRK/G/7dooeFKIlq4JE?=
 =?us-ascii?Q?LWoCY6aBQfJ+c9WGYLGUaoejErCi+9P0sWytk8hc0sf8h+NHGQqRyo9ZAS6a?=
 =?us-ascii?Q?5IYiag1HrHSuczHfq0YfDeE9YbvPQxXkSYiG/eyotm6q44LicZenLLJOehMh?=
 =?us-ascii?Q?Al//AOh0cs54/f6RT7n668l3RH7/qZw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DDF3C91A77E0024B880A77FFDB90202D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fe9d74-d9da-4eed-a009-08da113d419c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 04:33:21.6870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 24FBuJ62lkxXN3qjOQDlpz89xWIsZk8+cREGwSp5UCAUubt2X1ghYGWYmv3QOuzmkhe+9Uc5s9HMk5QLvr7bug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0530
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 28, 2022 at 07:11:39PM +0800, Anand Jain wrote:
> On 24/03/2022 02:16, Boris Burkov wrote:
> > On Wed, Mar 23, 2022 at 12:52:15AM +0000, Naohiro Aota wrote:
> > > On Mon, Mar 21, 2022 at 04:56:17PM -0700, Boris Burkov wrote:
> > > > If you follow the seed/sprout wiki, it suggests the following workf=
low:
> > > >=20
> > > > btrfstune -S 1 seed_dev > > mount seed_dev mnt
> > > > btrfs device add sprout_dev
> > > > mount -o remount,rw mnt
> > > >=20
> > > > The first mount mounts the FS readonly, which results in not settin=
g
> > > > BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device a=
dd
> > > > somewhat surprisingly clears the readonly bit on the sb (though the
> > > > mount is still practically readonly, from the users perspective...)=
.
> > > > Finally, the remount checks the readonly bit on the sb against the =
flag
> > > > and sees no change, so it does not run the code intended to run on
> > > > ro->rw transitions, leaving BTRFS_FS_OPEN unset.
> > > >=20
> > > > As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPE=
N and
> > > > does no work. This results in leaking deleted snapshots until we ru=
n out
> > > > of space.
> > > >=20
> > > > I propose fixing it at the first departure from what feels reasonab=
le:
> > > > when we clear the readonly bit on the sb during device add. I have =
a
> > > > reproducer of the issue here:
> > > > https://raw.githubusercontent.com/boryas/scripts/main/sh/seed/mksee=
d.sh
> > > > and confirm that this patch fixes it, and seems to work OK, otherwi=
se. I
> > > > will admit that I couldn't dig up the original rationale for cleari=
ng
> > > > the bit here (it dates back to the original seed/sprout commit with=
out
> > > > explicit explanation) so it's hard to imagine all the ramifications=
 of
> > > > the change.
> > > >=20
> > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > ---
> > > >   fs/btrfs/volumes.c | 4 ----
> > > >   1 file changed, 4 deletions(-)
> > > >=20
> > > > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > > > index 3fd17e87815a..75d7eeb26fe6 100644
> > > > --- a/fs/btrfs/volumes.c
> > > > +++ b/fs/btrfs/volumes.c
> > > > @@ -2675,8 +2675,6 @@ int btrfs_init_new_device(struct btrfs_fs_inf=
o *fs_info, const char *device_path
> > > >   	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
> > > >   	if (seeding_dev) {
> > > > -		btrfs_clear_sb_rdonly(sb);
> > > > -
> > >=20
> > > After this line, it updates the metadata e.g, with
> > > init_first_rw_device() and writes them out with
> > > btrfs_commit_transaction(). Is that OK to do so with the SB_RDONLY
> > > flag set?
> >=20
>=20
> It is ok as the device-add step creates a _new_ sprout filesystem which i=
s
> RW-able. btrfs_setup_sprout() resets the seeding flag.
>=20
>  super_flags =3D btrfs_super_flags(disk_super) &
>  ~BTRFS_SUPER_FLAG_SEEDING;
>  btrfs_set_super_flags(disk_super, super_flags);
>=20
> Thanks, Anand

Yeah, I see that point. I'm concerned about an interaction with the
VFS code. With this patch applied, it is going to do file-system
internal writes (updating the trees and transaction commit) with the
SB_RDONLY flag set. Doesn't it break the current and future assumptions
of the VFS side?

But, it's just a concern. It might not be a bid deal.

> > Good question. As far as I can tell, the functions don't explicitly
> > check sb_rdonly, though that could be because they expect that to be
> > checked before you ever try to commit a transaction, for example..
> >=20
> > If there is an issue, it's probably somewhat subtle, because the basic
> > behavior does work.
> >=20
> > >=20
> > > >   		/* GFP_KERNEL allocation must not be under device_list_mutex */
> > > >   		seed_devices =3D btrfs_init_sprout(fs_info);
> > > >   		if (IS_ERR(seed_devices)) {
> > > > @@ -2819,8 +2817,6 @@ int btrfs_init_new_device(struct btrfs_fs_inf=
o *fs_info, const char *device_path
> > > >   	mutex_unlock(&fs_info->chunk_mutex);
> > > >   	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
> > > >   error_trans:
> > > > -	if (seeding_dev)
> > > > -		btrfs_set_sb_rdonly(sb);
> > > >   	if (trans)
> > > >   		btrfs_end_transaction(trans);
> > > >   error_free_zone:
> > > > --=20
> > > > 2.30.2
> > > >=20
> =

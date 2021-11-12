Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F318844E2D0
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 09:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhKLIM2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 03:12:28 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25359 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhKLIM1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 03:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1636704576; x=1668240576;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=HFRDpGgdVOCfYJL/xx0rrMxoEcJbIi6JDaJzK0fGzow=;
  b=NivVmtAyGOp1v31/0BZcWZXh8USfatsGxxiks6aEhenv5ToWEAqNC9F5
   rqwG+wp8BQOfnHXTGXt18kUi350cOlhB7zkLTfgvLAt/PHTVq0+S63awJ
   9skA18p57TvlxXLIPJG1UlehsJL3JOF/mQNbFqg1jxUa1Xo16l7xbAbDX
   mangFfvCSGelHdXAv7m8ReD9JNRO/zPlb6CNQOBWoRXg9xzgJgBvi4q0d
   uhTa9qi4dmV/KBbCR8ed193rEgfQT5iYLkX8NcZBl1EMbg+kq9FtbO/uU
   0Ik9nAa8I2njO6jvK8cpmCuMxLAnXFkx9eBbQD2XSPN1iefhS/43T2RB1
   g==;
X-IronPort-AV: E=Sophos;i="5.87,228,1631548800"; 
   d="scan'208";a="190229790"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2021 16:09:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsxjkiVdsx46Ruxp1aUVoxvgLC147l1IUOI0rmCrwjWCkvpy/bn5+dOt0xcNM2nGfGNOGzQXkQ5oyHEaml4DCLBmSfaR79qWKo7tPh6jZN3H4qlux4iGgcBBnjVueH4HRdSHwuNj6Xs6Apmv13OFCBz2djbsfLbHWdbYtdMn6x8babcxpIptOEF1D/V85AfEObgQzi+yu/+O4BHE/OD9C+8ZzhLMiiE6lwHAam1PMIOWsLcWHp/EJqVDcGtH6uD0OyR+C2FMi3jKUpTfPawTRVCWtAPtjPrzX0tINgFgAo9cmKBbqfiCohCicR3kC628QKwZFLzz16KVS1dsPqIWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBGSQ9xDvB27xfxFoWojzQuu0eYdc+H5+jPelh2L4Uo=;
 b=GExoKKXc3Pf8yTLxI4eVHzONb/G68EZUhT2rIbV1egEoU57Q5CnprVdoQTKFfKbw35Dh4VMzGis2172ffYYbd+o4/JEhbLjYRwoGoEFoD+b8AXKTH2BjthKwrg3jfKhBQfLXvp/hZM9j2ElkQ8EL4CKG3Yfjc849avak42tVMbSQywYwyFjOYjjtrZ4oy0o3FvIDYmD9tqTzfdWbjOT+vXD6ThjIPQknNHRVzYWFNHVqHCW+0CfaDhKs78JAgj6XebtTJRhY0pEXUVgvnncUp8ZCK4Ki0MYPE0fiVKwCcEnJuFrkBt0PGVmofdsRepbljGZlghs42MHGcKY5tS70TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBGSQ9xDvB27xfxFoWojzQuu0eYdc+H5+jPelh2L4Uo=;
 b=kdDTY0YYki29EQ0DlU6lKkghQ7pEl8MNKZvBA5MG9Ainj5rZYVE6R3DO3mFkOhGwSy5tw/7QrIMGjVvdoki7TRphiO+lfmDHo8RhKP53J1E+TOMAzC4G4eOAf9UxIkdYrHkndBQ2VLzx2pqwmVXRsPZihtH8cF4TYyfYHvs/N+E=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7822.namprd04.prod.outlook.com (2603:10b6:a03:3ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 12 Nov
 2021 08:09:34 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::4d43:a19:5ad0:74ca]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::4d43:a19:5ad0:74ca%8]) with mapi id 15.20.4690.017; Fri, 12 Nov 2021
 08:09:34 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: cache reported zone during mount
Thread-Topic: [PATCH] btrfs: cache reported zone during mount
Thread-Index: AQHX1rsNIfSkp8A/OEe2FKWcLDQshqv+SUYAgAFCg4A=
Date:   Fri, 12 Nov 2021 08:09:34 +0000
Message-ID: <20211112080933.vipqbcbvdwl6payy@naota-xeon>
References: <20211111051438.4081012-1-naohiro.aota@wdc.com>
 <20211111125514.GC28560@twin.jikos.cz>
In-Reply-To: <20211111125514.GC28560@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a3ba9f4-197a-49ce-c8e2-08d9a5b3c36b
x-ms-traffictypediagnostic: SJ0PR04MB7822:
x-microsoft-antispam-prvs: <SJ0PR04MB7822C187411A0F78AA59BE958C959@SJ0PR04MB7822.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ygo88ArDWMMrVQFSoEKWIBHE8uLLNSLi4Ca157y7oXtgBMILY2IQBM3EodDvw5Qg99Mx2i6+eeDOvBFASK4KnxkRh9NNQFcNmMHMgtXmq6IPtRt6NITtTD3tK31u9uENlE91Y9s/PRDkHf377JVh81NRY/fPWkubrjQs405FNHish48nBYvWOtMASRuuklDIjYzQiSsPIzT0pvx+g28QrHn+ulanQREXkzbOrBJ487hKKVvV/EwBVmOGVtfFs6lga97IhUEvIbeKaJ/LaHE97tcGZI8I8KjFbCi4f/mL93vpOXMK4GrVk5h8b9GQ9sXnz/qhh02QuHOi74ZuYE98Tls1cs3ojUKzY9XN97f/EdfRNQYmBN+9JhCecVjFhiIDFCvUI2d9FDRWhnuGfhKrXkxtIIAJf3U7GWfrxW0eElak+woeV9BtNJn39aQAHRatl03jJOs8XqV9TiLu/4VezZks2iSvdmh+d9Hi4gU5mmWCtSw5P1Ok0yIJaQ2M82v4YpDM2nL5uQknIIEcYBnTU+LfkZPUzzY+rlh1/hk/A0hvBUbrvn0pmCDGBPQsjLGOt0R9v76eS+s8DJ5s7yqeomE311Br2hUsUfNvvXKUL9HZa8rKLG99Fqo8OMz1zhsCVciETqnN1QdjrbUBVgdJrsl+bEY4mxS2ysPnYAUGBTy4gr7DW3SejsC+HkuzzwPMmZFgE30yQOd6hyEDeKD8YeqFAiW3HoAitVl9L8pwbzCVrNHDbBDP6zGiqLnqK8xse68qndqPS/d+S7sqspeD/JcL6asOY2lofS/7r7ocq+c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(110136005)(38070700005)(33716001)(1076003)(86362001)(5660300002)(82960400001)(66446008)(8936002)(6512007)(83380400001)(9686003)(66556008)(186003)(6506007)(508600001)(6486002)(76116006)(966005)(66476007)(66946007)(2906002)(316002)(71200400001)(38100700002)(91956017)(26005)(8676002)(122000001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?taj4vQUknLnlMNc2WjHy7lzqEgt942lOUW5Pa8kkrdKiIZAzpqHgzn7so5YT?=
 =?us-ascii?Q?AZBZFVbsBX2qhhgzN0o/V53HRkOuIvsysr3Jz7uGc7RWC+Wucz0oGi8GcxVK?=
 =?us-ascii?Q?jdiIOh/Dbi1+hyHHbXxEPc/Ir8g773aM8mV+CQRxu752E6dlyRjpdAk8gvRF?=
 =?us-ascii?Q?Gq/gnLEfdZ77oEduR3u3xtG9w+VhJhH8ErH0ZEQT2VWmNdzofDvat92EGdEV?=
 =?us-ascii?Q?aQi1rfcu/CoyBpWffyXoKCGFjGEBW24cldcdGaIoXvfx21jfEAuhjeOztA15?=
 =?us-ascii?Q?jy3JlO5NCmcSy5L3Tp/BtjOPk/awb5awYV+7XObZzq9liYHCpJi00/r95+eb?=
 =?us-ascii?Q?KU1rMI6LGfuaRg6OegjVhZkhzd7NhUPDhj8HnEzkep9TcUeaOGrqHS0XXWo+?=
 =?us-ascii?Q?AazLHQ7whHlLypVdVvoGoUHdQAsBkUCVylypY0u/6NRCTQtlL0xZrudMBEIN?=
 =?us-ascii?Q?d8w8AYBVlIbEbAiF8kgfEdnZpN9b9P8peIOYkMueye1+jS5edo4Wr+jaevN0?=
 =?us-ascii?Q?npn2IL5Ul+SB0BA4bGGyvx1LH+8sgrWbd/AdLmG6r7E6S9ScMyklNQx2qVsV?=
 =?us-ascii?Q?LvUgNiqK/FaSjKNy6HtfpaFiSOioAVs3kklF9Yw9kFj3Oq/T0r077mY3hJv5?=
 =?us-ascii?Q?ffwd1ioSHvsRvOtqWRD7e64ZqAMEaMbX+5Lx/K3JZF4D+qRmj3zzp3Vteyo3?=
 =?us-ascii?Q?VXmhNAFWi/+d1FxYRSMOeoY7iTMjEl41DxCgLM/OrjDEFdLnGtCdYt5g6Xx0?=
 =?us-ascii?Q?8A/uHwmHOqVngwhd2A4DMNou9+KIDz7DnV8KFYJReEACsoddOHPoaZtuW32i?=
 =?us-ascii?Q?gL/U740FFo9FM4OSW46+KIHTI6IxvIF98KtmdiI8zRDuh3ft2Oz0TUb9XwN9?=
 =?us-ascii?Q?5Dssc2KkL1npclKM7J/nBrBN3Jil1tMpCHoDJtTRk4CejaBNEY7U+XYtLGTc?=
 =?us-ascii?Q?9vPG8gjS/d26jyAUW8NWH3sxLR52fK8t5XeA4v2V7rCmtJRKWq1BhxnJ/kZV?=
 =?us-ascii?Q?EvnsIwQ57UrBXLaaHcVVLbF+advV7lWwuMOpYrlANMWqv4bBnagnxLON5O+5?=
 =?us-ascii?Q?rTBbboEyRfaR216+XpAML0gHtB4Am/EqIa6sA8r4SRt++iu/9GjGH+pFW+Eu?=
 =?us-ascii?Q?aazCVpJwGzQ2M/gDuVJi1LpAyH1uVHpw0xBVKAeWPC9bxATH7GzLUagLTWU6?=
 =?us-ascii?Q?X+Iq+aRLuSokRjJjiNEn9sQ8Ayroo9OF7iLVofdYQnjz0R71DfY72pz4KbGY?=
 =?us-ascii?Q?9Mhy+yKt0TK/8XLuMNBSt5DVY8CAE6Z56S5p0mjgncmFjPkscePnKHa1nyYj?=
 =?us-ascii?Q?yqek39XrKr6diVtd3pvIcg5u8UWIJRXdhd1DzG5lEdtJMsKCatTF/xWBqLoQ?=
 =?us-ascii?Q?pVv1Xn8FjFJycIgZQ47v3g1XcZ1Zr2XmOLS51/4YzQWl1mY+dJCZaMHJfgzU?=
 =?us-ascii?Q?ejI8qsV8Tl8azMF0gOFEa/PphATnY42ptXBSWoBj/WTXV/Z+le5Fl+vHvsOR?=
 =?us-ascii?Q?Jv+sL9bIDynrlLpPjHkjj3nQSACuJw8V2LdwQjI3OksqJkmOLZECPGvGE1aO?=
 =?us-ascii?Q?L+D0Mx3XGlkZIq3VgHxey04cg2UDhE02qU5FQ50MCI48RZsS6UXjmwXgG2cR?=
 =?us-ascii?Q?1cWz9OYgca46kvOh6+V8EmA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2CE919AA3EC8CC4FB307BDFD842C7931@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3ba9f4-197a-49ce-c8e2-08d9a5b3c36b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2021 08:09:34.4552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/4xqVb0Qg0rFxhEBhgAHDw8xrW3JIQC6PwSNhKIMuCI2ByN9sVgL8vnWyGJdOHmJstbnqbfvxgUDVUZ2lYPwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7822
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 11, 2021 at 01:55:14PM +0100, David Sterba wrote:
> On Thu, Nov 11, 2021 at 02:14:38PM +0900, Naohiro Aota wrote:
> > When mounting a device, we are reporting the zones twice: once for
> > checking the zone attributes in btrfs_get_dev_zone_info and once for
> > loading block groups' zone info in
> > btrfs_load_block_group_zone_info(). With a lot of block groups, that
> > leads to a lot of REPORT ZONE commands and slows down the mount
> > process.
> >=20
> > This patch introduces a zone info cache in struct
> > btrfs_zoned_device_info. The cache is populated while in
> > btrfs_get_dev_zone_info() and used for
> > btrfs_load_block_group_zone_info() to reduce the number of REPORT ZONE
> > commands. The zone cache is then released after loading the block
> > groups, as it will not be much effective during the run time.
> >=20
> > Benchmark: Mount an HDD with 57,007 block groups
> > Before patch: 171.368 seconds
> > After patch: 64.064 seconds
> >=20
> > While it still takes a minute due to the slowness of loading all the
> > block groups, the patch reduces the mount time by 1/3.
> >=20
> > Link: https://lore.kernel.org/linux-btrfs/CAHQ7scUiLtcTqZOMMY5kbWUBOhGR=
wKo6J6wYPT5WY+C=3DcD49nQ@mail.gmail.com/
> > Fixes: 5b316468983d ("btrfs: get zone information of zoned block device=
s")
> > CC: stable@vger.kernel.org
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/dev-replace.c |  2 +-
> >  fs/btrfs/disk-io.c     |  2 ++
> >  fs/btrfs/volumes.c     |  2 +-
> >  fs/btrfs/zoned.c       | 78 +++++++++++++++++++++++++++++++++++++++---
> >  fs/btrfs/zoned.h       |  8 +++--
> >  5 files changed, 84 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> > index a39987e020e3..1c91f2203da4 100644
> > --- a/fs/btrfs/dev-replace.c
> > +++ b/fs/btrfs/dev-replace.c
> > @@ -323,7 +323,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btr=
fs_fs_info *fs_info,
> >  	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
> >  	device->fs_devices =3D fs_info->fs_devices;
> > =20
> > -	ret =3D btrfs_get_dev_zone_info(device);
> > +	ret =3D btrfs_get_dev_zone_info(device, false);
> >  	if (ret)
> >  		goto error;
> > =20
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 847aabb30676..369f84ff6bd3 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -3563,6 +3563,8 @@ int __cold open_ctree(struct super_block *sb, str=
uct btrfs_fs_devices *fs_device
> >  		goto fail_sysfs;
> >  	}
> > =20
> > +	btrfs_free_zone_cache(fs_info);
> > +
> >  	if (!sb_rdonly(sb) && fs_info->fs_devices->missing_devices &&
> >  	    !btrfs_check_rw_degradable(fs_info, NULL)) {
> >  		btrfs_warn(fs_info,
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 45c91a2f172c..dd1cbbb73ef0 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -2667,7 +2667,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *f=
s_info, const char *device_path
> >  	device->fs_info =3D fs_info;
> >  	device->bdev =3D bdev;
> > =20
> > -	ret =3D btrfs_get_dev_zone_info(device);
> > +	ret =3D btrfs_get_dev_zone_info(device, false);
> >  	if (ret)
> >  		goto error_free_device;
> > =20
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index 67d932d70798..2300d9eff69a 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -213,6 +213,9 @@ static int emulate_report_zones(struct btrfs_device=
 *device, u64 pos,
> >  static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
> >  			       struct blk_zone *zones, unsigned int *nr_zones)
> >  {
> > +	struct btrfs_zoned_device_info *zinfo =3D device->zone_info;
> > +	struct blk_zone *zone_info;
>=20
> Variables should be declared in the inner-most scope they're used, so
> zone_info is in the for loop
>=20
> > +	u32 zno;
> >  	int ret;
> > =20
> >  	if (!*nr_zones)
> > @@ -224,6 +227,32 @@ static int btrfs_get_dev_zones(struct btrfs_device=
 *device, u64 pos,
> >  		return 0;
> >  	}
> > =20
> > +	if (zinfo->zone_cache) {
> > +		/* Check cache */
> > +		unsigned int i;
>=20
> and u32 zno should be there.
>=20
> > +
> > +		ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
> > +		zno =3D pos >> zinfo->zone_size_shift;
> > +		/*
> > +		 * We cannot report zones beyond the zone end. So, it
> > +		 * is OK to cap *nr_zones to at the end.
> > +		 */
> > +		*nr_zones =3D min_t(u32, *nr_zones, zinfo->nr_zones - zno);
> > +
> > +		for (i =3D 0; i < *nr_zones; i++) {
> > +			zone_info =3D &zinfo->zone_cache[zno + i];
>=20
> Creating a temporary variable to capture some weird array expresion is
> fine and preferred. When the variable is not declared here it looks like
> it could be needed elsewehre so it may take some scrolling around to
> make sure it's not so.
>=20
> Both fixed in the committed version.

Thank you. I think I messed up the location while I was moving the
code around. I'll take care.

> > +			if (!zone_info->len)
> > +				break;
> > +		}
> > +
> > +		if (i =3D=3D *nr_zones) {
> > +			/* Cache hit on all the zones */
> > +			memcpy(zones, zinfo->zone_cache + zno,
> > +			       sizeof(*zinfo->zone_cache) * *nr_zones);
> > +			return 0;
> > +		}
> > +	}
> > +
> >  	ret =3D blkdev_report_zones(device->bdev, pos >> SECTOR_SHIFT, *nr_zo=
nes,
> >  				  copy_zone_info_cb, zones);
> >  	if (ret < 0) {
> > +}=

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D23638250A
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 May 2021 09:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbhEQHIY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 May 2021 03:08:24 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34058 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhEQHIX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 May 2021 03:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621235227; x=1652771227;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vCXUE6VOBZ3p5c9qQG7POp1pve3EnkzkzmIx6ldr4eA=;
  b=oP2QQQbhuqVgkzZzJsS+o/aAd9w2TjUC5lD4O5Z0VYuDno/ctkd28zE9
   NGH7D8dcIZxcl/NrebYvm31VokoMbVy0D3IZEPX2VhBrlzIiJ9ZfPoxvN
   8T8ZTEBQdUoBQSEksAAvTHYCoBNKDK6ZLGrWRqrFB82wfWiJx7JiiddPX
   lRY5Z9JvdE+Ct6h5u40XZWVw+rEmM90gMxQeIJ7UCdFql4cxJ3Zs3s+0t
   8IjmlExzaABS6AleXd2/HHzU4DS87Exfj/Phf/K/J0g6vGrahfBQ5bCBB
   dH9xZUo0LWLcIrMNT6YDmvsRb6enDBEJPpVnuPxZB3VaV5aZ5Xozz50wE
   g==;
IronPort-SDR: UCdAQBqjxIJNqc7rru178t9AH1qSy2ay00OiV0FBWmYP3nABJqFfKMPOjhSpVKiq6U4L5tZfdw
 55QP0VnNPDNQjIHu06/BeZUihAzVD9Sskt7iub2wYzIAIfgKW79oUjB8dbzJoqbC5TNkf87ia5
 TIaRpAQYizd2+o5Z7H2mSIVbCAomSpf4q1BpZc8LLR9W2xah3sPjwnHh3BnW1BjIHL8hipX4+x
 HK19Mts8Ne4Dm+J8l67Dpyr1EJ9GCttYRt5SHgSyLkZ3k0a57078P0VVEqBn9NFNlak7R4rZd0
 5+I=
X-IronPort-AV: E=Sophos;i="5.82,306,1613404800"; 
   d="scan'208";a="167733549"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2021 15:07:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hncmZmKCxl55ucGxXQ4qRV5E5uf7RIivXBmQ0/eOeyc+UstEgQrDoDC9r18+qkGh85fKA7efjoJlRFSHctnlBA+1sgFOpD9EfcVyZyiVB2NkQntTynJhO0XjCJyYQojl+wJZfQ6cEIchyjqUOALq6vmwMdPmncjGd5UONKaFh/PgoidU4yKLgaHR/48U6Y2M8vwDmMaDAhQ1RXHCRqzSi5AfM2TK8oMaHY7EuicL6AZDie7m26Xg1OyNzsGsLT1BwtZo3Jf0N2Otf3dBNhNztaszO7LbyvJ31VsEIg9qIPvWEv5yW59Ba7TexsGQiFnyiCvT9qxzie99FTaPIRhHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpdTBMV7SIW2Rj2PEL4vHQgOReLWCCo7X4KIZlvnBM4=;
 b=CYQoiLqBBRbtQ6L1UvsKY2iztRmkluZ+syyvr/+sVq1pYtU/i4L7XZB6hzxU/USRTHs9vWFKxWLvP6+2ygjsCDNPX6CCzrvojqQ4PRt5cq5oRbgLaYEydXxvo8qB8K40zOACTCukdfxbC0Yavrdy1i0+W3hGiP1/6Lcv3GmuQQpui3z+pOJnVi2t6PsQzAVVsnCkNLaPOMOi8sNzFLQO/B1e3hfd/pWyOgfx+/KN6Gp9/NuX7+5j1CO1oScP/2wyO1TRLlkuZ3SuHK2KkcEoF45+m1KJR1MO43tDpQ9pJ8RyJDA07O2S3rDbTxr2yj9bMH2IM7USMuTfYeZrGbN/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpdTBMV7SIW2Rj2PEL4vHQgOReLWCCo7X4KIZlvnBM4=;
 b=T5N1PPnA6bB+12Gb0KwTvVSEz6iygVNo/+jUGHqgs4Tf0GFPK3UzpZUgUhWGxPoSP9G/61PClHC09Xtc+JklrQ/h6oQU7tYhkm5lgcA5+S0onNo1ZMQbpDzR2W0N/TS8co999/yvL4zrPAONDH1kxJVTLh2iCsgGOtnOlGs22qY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7222.namprd04.prod.outlook.com (2603:10b6:510:1b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 07:07:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 07:07:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] btrfs: zoned: fix compressed writes
Thread-Topic: [PATCH 2/2] btrfs: zoned: fix compressed writes
Thread-Index: AQHXRzde03R8KYGMm0efltVC5jDu+w==
Date:   Mon, 17 May 2021 07:07:04 +0000
Message-ID: <PH0PR04MB741608A91B3171D58DA902EF9B2D9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1620824721.git.johannes.thumshirn@wdc.com>
 <52c1251218441dfeec909b34069d654aa45311c1.1620824721.git.johannes.thumshirn@wdc.com>
 <20210512144213.GS7604@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:9ba:2a4d:8d47:65d9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 167b7d72-9ef1-4c89-4554-08d91902600b
x-ms-traffictypediagnostic: PH0PR04MB7222:
x-microsoft-antispam-prvs: <PH0PR04MB72223558E575A6C395CA86919B2D9@PH0PR04MB7222.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HFOD22iQKGOQv7Kt446Am4eezlMw1cyD7X0DdgTQLAgbALvTzZcsX0bWcXSvyyvpICouse3rHo6pgqU8aJyrtA6T6pAYfQIJDCTzhcjaWWZcB7tmiuRwWlHcEgFqdhkHE+e/pd/Qtu4Dgb9l+G04LzCpU0dnefU3iBjYtfOlp6wX13w3hzBP2uiFiD58vJmZMX0VGUUFOof+CfARbwCIjCya49kwXLkAVcp32Er8YfyC0+AjyxXVwNBMcbulTewZWLBBXZoXquqJ7PvV44Jz5LICw2n+//yzQviJN168tDJSA3huoL+cCwbx44+skmlQ1YNcnCOBI33I3+eZHJkjiiYI3+SneFP2zfm6h+Es+fxvQcqQY19IlNihwpt/pQ4BYSVeE9c72QX702NC7V9h3CiBuEzv3TMxXBfe44xq9Ok1xIYYZ77jaBktDSxEA4AHMSUbSK+6paM3f9fWZGrSoZ92GqYnkygmWEt3mTC0LePMvld9agdqEgdNs1fumBjY+cko/VElVVyHYZl7TF2ifDcR75ucy/6VxjouNk50D7nsVESEjVZeo32ErWZQMsUAPrtNZ1qqE3+FWVPwnjlGG7khgUJIHb6or580teNkVSY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(2906002)(8936002)(7696005)(6916009)(4326008)(52536014)(6506007)(66476007)(53546011)(71200400001)(86362001)(5660300002)(66556008)(122000001)(76116006)(91956017)(66946007)(9686003)(33656002)(316002)(38100700002)(83380400001)(55016002)(478600001)(64756008)(66446008)(54906003)(186003)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WKq84hLyuIahK4UJORD9uRWzOdmt4BLV8v6VHAKUp++7kUUkCKHihj5MX3jN?=
 =?us-ascii?Q?nHoHZDjR/oGIcsGPsILqhkn9HfgOWzv6UvyjPyAhxM+0xLjEV/wYTZ0D4feo?=
 =?us-ascii?Q?1rXBl1QdaOFERT+tFO102P32ZoedHmVwKi9nF7HKUovLMrUpGfIel7DjgJJH?=
 =?us-ascii?Q?SrhYinhTLIPCEkv/SMkAUq3DVT3OczyB+sGVVbAir9ESIRS8vrU9EW41bvlN?=
 =?us-ascii?Q?kXb2H1BOTZZfFzV54yvtjbBtlATndmRY5L69yKvTRiyDUvzZfZF+rfONbROy?=
 =?us-ascii?Q?wwdxfG6DhFltcEaza4+XVZyv6J5LDMr5eO0YmTVpdQ3M/NVkzBrVLkdFNtAW?=
 =?us-ascii?Q?p0ri5DjS389nr+ZoSU26W/r01Dz3rFrG6+rGOZPG/RA/94cYjCglQbpVGnTu?=
 =?us-ascii?Q?+/frtq4rwE07YSNShtlsbAwBmg2plKReXAOtEizfa57MyyBh5aOC8FRabY2l?=
 =?us-ascii?Q?fkHQhjriCGxF1Y38TpCdLGd74dLpy6A8ly4YRldvsrSuJsvabZtltlnL3aTh?=
 =?us-ascii?Q?x1m21zSGhsklum5AMCrAtukqat4iJ5CagU6xv6Ki4w7VX4gAinYw/JmDqJ2R?=
 =?us-ascii?Q?NZagQot67iwsmOnyLLSEcBhJ8Wn2d/Dd9HSGlznZXqaHvr5quKjnmpea8Hal?=
 =?us-ascii?Q?FuFRMu1pK77pD0DTO0O8rnZz0KX6sG2a3t0v2x6KqZZmeXBVLwR+vyp0l1kh?=
 =?us-ascii?Q?rLl+yc7M2jWfPBBzpgyh52sWHN6LUZ8ckgua1Lh589cw/ZgKn4HxZeLzq79C?=
 =?us-ascii?Q?k4QINrpc8UJQgVeuw9QHBUahjEXzkSZRETfGabz1jihC+0Y627ARAOGG/FwG?=
 =?us-ascii?Q?GvyvSPTdnK996WeoD4BtA/zm5F+KdTCdQY0GmTFR3vbpd3pClWuGJTgW6rc/?=
 =?us-ascii?Q?FVaihXQfIJAt0C6ahT5hHHzBZ84iIUORBvWI9xjKsSNWi5VgmyNMLUJUveYm?=
 =?us-ascii?Q?KFdmgQGuZOubvvyyVm/ExRz4fBI8Pa3/Thp49M5zqf65Tj/8bOYmc5djuZbo?=
 =?us-ascii?Q?Gb3bl9XzrLlWb+R8DLltY/0UF7ZmwMtgCY7QIlvDQScVCQvG7xMmyrWCcu0j?=
 =?us-ascii?Q?LiVUFXlDIR0C6koXjmpCEnNxOXOcT4DKMMXQYGWgCywlI5Aml46wvPW8vshJ?=
 =?us-ascii?Q?tN3yElCmsbc6RbPnFQjJKmuWeGwkx4K+IBYNtGCF9X9zzxU92tFFDsXd99Ec?=
 =?us-ascii?Q?sVOEec1GswRTml7QKaHaV8tkFm9Z5lpFM+fVpO6dx4jHpyOfUXPrA7G7ny3r?=
 =?us-ascii?Q?HdyuxyAltZ/3p5LEMFFh6RxIGZHRmFoFZbN4+3sSK2Ry9VZTNdm7KhXVcmRD?=
 =?us-ascii?Q?bhY21BV4UIrrIEK9EFh6EaRBZVT+iNSc3ZXJUI0DJg/31sBAUnnxF5MUS53i?=
 =?us-ascii?Q?htjJ6VY8EotkrgDuxAJDuggWG5XD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167b7d72-9ef1-4c89-4554-08d91902600b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 07:07:04.0471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLqR8ekW6wPDWTBGFYxslJ0HQZbzbQNRrVP1Bk5YiF3WFwC0PPr4GZ84OrNN3xZEOKtCmoAYD6IxaKDV4AWYobGkvlXWE7MvLsEy0NGeAis=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7222
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/05/2021 16:44, David Sterba wrote:=0A=
> On Wed, May 12, 2021 at 11:01:40PM +0900, Johannes Thumshirn wrote:=0A=
>> When multiple processes write data to the same block group on a compress=
ed=0A=
>> zoned filesystem, the underlying device could report I/O errors and data=
=0A=
>> corruption is possible.=0A=
>>=0A=
>> This happens because on a zoned file system, compressed data writes wher=
e=0A=
>> sent to the device via a REQ_OP_WRITE instead of a REQ_OP_ZONE_APPEND=0A=
>> operation. But with REQ_OP_WRITE and parallel submission it cannot be=0A=
>> guaranteed that the data is always submitted aligned to the underlying=
=0A=
>> zone's write pointer.=0A=
>>=0A=
>> The change to using REQ_OP_ZONE_APPEND instead of REQ_OP_WRITE on a zone=
d=0A=
>> filesystem is non intrusive on a regular file system or when submitting =
to=0A=
>> a conventional zone on a zoned filesystem, as it is guarded by=0A=
>> btrfs_use_zone_append.=0A=
>>=0A=
>> Reported-by: David Sterba <dsterba@suse.com>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>  fs/btrfs/compression.c | 44 ++++++++++++++++++++++++++++++++++++++----=
=0A=
>>  1 file changed, 40 insertions(+), 4 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c=0A=
>> index 2bea01d23a5b..d27205791483 100644=0A=
>> --- a/fs/btrfs/compression.c=0A=
>> +++ b/fs/btrfs/compression.c=0A=
>> @@ -28,6 +28,7 @@=0A=
>>  #include "compression.h"=0A=
>>  #include "extent_io.h"=0A=
>>  #include "extent_map.h"=0A=
>> +#include "zoned.h"=0A=
>>  =0A=
>>  static const char* const btrfs_compress_types[] =3D { "", "zlib", "lzo"=
, "zstd" };=0A=
>>  =0A=
>> @@ -349,6 +350,7 @@ static void end_compressed_bio_write(struct bio *bio=
)=0A=
>>  	 */=0A=
>>  	inode =3D cb->inode;=0A=
>>  	cb->compressed_pages[0]->mapping =3D cb->inode->i_mapping;=0A=
>> +	btrfs_record_physical_zoned(inode, cb->start, bio);=0A=
>>  	btrfs_writepage_endio_finish_ordered(cb->compressed_pages[0],=0A=
>>  			cb->start, cb->start + cb->len - 1,=0A=
>>  			bio->bi_status =3D=3D BLK_STS_OK);=0A=
>> @@ -401,6 +403,10 @@ blk_status_t btrfs_submit_compressed_write(struct b=
trfs_inode *inode, u64 start,=0A=
>>  	u64 first_byte =3D disk_start;=0A=
>>  	blk_status_t ret;=0A=
>>  	int skip_sum =3D inode->flags & BTRFS_INODE_NODATASUM;=0A=
>> +	struct block_device *bdev;=0A=
>> +	const bool use_append =3D btrfs_use_zone_append(inode, disk_start);=0A=
>> +	const unsigned int bio_op =3D=0A=
>> +		use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE;=0A=
>>  =0A=
>>  	WARN_ON(!PAGE_ALIGNED(start));=0A=
>>  	cb =3D kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS)=
;=0A=
>> @@ -418,10 +424,31 @@ blk_status_t btrfs_submit_compressed_write(struct =
btrfs_inode *inode, u64 start,=0A=
>>  	cb->nr_pages =3D nr_pages;=0A=
>>  =0A=
>>  	bio =3D btrfs_bio_alloc(first_byte);=0A=
>> -	bio->bi_opf =3D REQ_OP_WRITE | write_flags;=0A=
>> +	bio->bi_opf =3D bio_op | write_flags;=0A=
>>  	bio->bi_private =3D cb;=0A=
>>  	bio->bi_end_io =3D end_compressed_bio_write;=0A=
>>  =0A=
>> +	if (use_append) {=0A=
>> +		struct extent_map *em;=0A=
>> +		struct map_lookup *map;=0A=
>> +=0A=
>> +		em =3D btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);=0A=
> =0A=
> The caller already does the em lookup, so this is duplicate, allocating=
=0A=
> memory, taking locks and doing a tree lookup. All happening on write out=
=0A=
> path so this seems heavy.=0A=
=0A=
Right, I did not check this, sorry. Is it OK to add another patch as =0A=
preparation swapping some of the parameters to btrfs_submit_compressed_writ=
e()=0A=
from the em? Otherwise btrfs_submit_compressed_write() will have 10 paramet=
ers=0A=
which sounds awefull.=0A=
=0A=
> =0A=
>> +		if (IS_ERR(em)) {=0A=
>> +			kfree(cb);=0A=
>> +			bio_put(bio);=0A=
>> +			return BLK_STS_NOTSUPP;=0A=
>> +		}=0A=
>> +=0A=
>> +		map =3D em->map_lookup;=0A=
>> +		/* We only support single profile for now */=0A=
>> +		ASSERT(map->num_stripes =3D=3D 1);=0A=
>> +		bdev =3D map->stripes[0].dev->bdev;=0A=
>> +=0A=
>> +		free_extent_map(em);=0A=
>> +=0A=
>> +		bio_set_dev(bio, bdev);=0A=
> =0A=
> bdev seems to be used just to set it for the bio, so it does not need to=
=0A=
> be declared in the function scope (or for one-time use at all)=0A=
=0A=
Oops that's a left over from an earlier version.=0A=
=0A=
> The same sequence of calls is done in submit_extent_page so this should=
=0A=
> be in a helper.=0A=
=0A=
Sure.=0A=
 =0A=

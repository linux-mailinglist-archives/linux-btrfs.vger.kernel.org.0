Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E0714D8B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 11:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgA3KMS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 05:12:18 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:16564 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3KMR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 05:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580379137; x=1611915137;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=K8nXV0XKOKV7jIQNpRnHeJZbvx3mtbBphp1yvqgP79M=;
  b=NTaOBqCErvt19SUksmtN0g9q7D1tZZ7gS1MV3EfBg3A34NDuzQ2Oygn6
   BXb+/uSRjcQC1D56DlhOReUl4rpJNjqo6s4jldgTW86VmUajpkqBDgSWz
   2hBne51WNbisOWkHWJYC2ojMXyd5aYCjMP5v1/M9jO0J2td58Ar94oUiU
   tMhd8let3nhWG4dPJu9SmdlLC2XcTpIUJJ8kyVKgPI2evf1Czm0UbfNHu
   k2ca5fSS0QHtK9GapK3mNhpOtHFmsak5kdOVuHlIuaIK7fTwP4wZ0c1lF
   JV1cojSfGp9QpnS4xpk2rAfnGuBc119xp8pkuvcU4PzqT+0r+0CGojlBz
   Q==;
IronPort-SDR: HFasKXQWWUmVkfNz2B0otfT+5ydpka4MeDxOYW1BqPib/1sxws6/XfLUw/qAMwYnRjIsqodJVL
 bfSi6n//PH7affY1y9OkcvngOGX2y/w2TfvQ1xy28WguiBL2D+zOsssRFcYJyYtxluRU1jPxQ2
 SvrXewhGC7mLsOs6OjphHvFuL9EIDp1D0viZcc7I5Ocndcl7RFT9I/3Z4N/zhuQ1gvBoUXEUv8
 zdS9RI3KYAEIXq1zC6sXcoAxClr4+OTXavTZW2X/dcz8dKvb7iWGuVcr6CRQk3NHuDAS/uH3u7
 K3I=
X-IronPort-AV: E=Sophos;i="5.70,381,1574092800"; 
   d="scan'208";a="130200417"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2020 18:12:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULro4ZDDRifKUp9TMa6EQwSAd0T0C+HSmIBGvBN/U8ZSFNLCDurwlooqofoUuAEah69+I0mCZqIPH1sjFbjONkjH3zjXWKy1q7tWKeD/mbakGWo1vgof2F0MfzCOYcKapX5BmuUim9MJhDjJFvSxKDCGEGU1iOlVKyGIcRA4XjO3EpP/M1j45ZsPezJTPkijrjoRmb0q7Q0QFZEKD3xE/tFWst7ptOHoX9HaWjmGDJ6JhOBv4+YcA6nMpn7RWMKnLAxji4/zyIB5RWnnWqtVcWzTjRPbTGpZD9k+GRWZ8a3CZgaSJNKYApURol0peusRdM49uFU06OJmnZpNSUoqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFam17TYRggAI3bdKsiIs0ziAfEFk/mPMNcpohffl9c=;
 b=eLVWjVufflwkFbxlJsGy/msRnoPNcnQr0TjnsntOX83aaMutjqN5/yhkzJk0xTbvmI4Y7MtwGe7s3m5WiH6a6Y/5jvtmX0wE3q6x9tQKcozGQPXEsET7I2H4zIHuUX13yF+zyXaUELbBYtbrpd0htD6RQ7nT54pw1spLVqf7Jv1Al2qKS3jhhKbvjC7ZEXxsdgx/JqQULmGCnpyqLLXshx2Sjiawzr6vYILJ2cDFlfnL5bnhVfY/pwRI7qmFZaAtmd1xhGW1zzE5B3LRvO7EQLtzzxm8S0WFQwJdbAL/lopUBzCtSpTVagC8cnYelF8gixKTJt5FF0zBOLnxjqrVBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFam17TYRggAI3bdKsiIs0ziAfEFk/mPMNcpohffl9c=;
 b=DRJBbGZNVEFBOAQzfxsNzt1HOAXW8/yRv2RjqJzM4f/rDmzRq/rsDavhOZif/UnJN2Xg5PAtOuzyNJUFLY/r5e/d8T0SCXjGGevZLa7diifVP6NnlNn7zam17MyrcV0GGx+ofFqx99ZGG1XM6DWLxxTXm69co10CBxs/vWAZ8kc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3632.namprd04.prod.outlook.com (10.167.133.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Thu, 30 Jan 2020 10:12:14 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2665.027; Thu, 30 Jan 2020
 10:12:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v3 1/5] btrfs: remove buffer heads from super block
 reading
Thread-Topic: [PATCH v3 1/5] btrfs: remove buffer heads from super block
 reading
Thread-Index: AQHV1SrLs4QVSfI/Q0WYz1ueOYQ+nQ==
Date:   Thu, 30 Jan 2020 10:12:14 +0000
Message-ID: <SN4PR0401MB359834468ED8C85C8E2395839B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200127155931.10818-1-johannes.thumshirn@wdc.com>
 <20200127155931.10818-2-johannes.thumshirn@wdc.com>
 <20200128114747.GA17444@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 647e48da-5b4f-4fc5-8189-08d7a56ce0ff
x-ms-traffictypediagnostic: SN4PR0401MB3632:
x-microsoft-antispam-prvs: <SN4PR0401MB36328DA43B42D807D8BC21EE9B040@SN4PR0401MB3632.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02981BE340
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(199004)(189003)(86362001)(81166006)(7696005)(81156014)(2906002)(6916009)(64756008)(76116006)(316002)(66556008)(66446008)(66476007)(9686003)(71200400001)(8676002)(91956017)(5660300002)(52536014)(55016002)(66946007)(478600001)(186003)(26005)(8936002)(33656002)(4326008)(54906003)(53546011)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3632;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lM71IvScyAIHz4tO5OuanUcSSluqGOGLzmJc8f+sncRzrdrQjE/5fbPqTMDvtIUrwwommULcC4a59eqOjYXHW3xFqq3kb6zFDiJq8b82HvVmA4JiPbQpRi3LVv9hyjx7GGH8/gymgwsrJbSf736bW9jKabNg8XbSNuu3iWkZA4TcyphpmYyMK8wSwoCZp1Xby+L9qd/+XBMofpMo39Yvi/CwvcJrXAL+ucrqXO7aM4Rzf3NE8nPPizQs+DD2tt195VsdTAmmZiQ1abyTkek5xO8YkjQEiECXQIn1UW3Fh+yJsHMpMO9Faotz1D1FiTPLL4B4z3jfjURvPRDshHP1SHzNRRPGdipH5iR8CCWVKyYVUkwufgdxkfx9YQb4ITRncsZTyMMrwgn/6QGOmvGT3D0Rv6BKzn5fbCtQapO4iAnBhGP3meoLEHtixqV0Lg+o
x-ms-exchange-antispam-messagedata: fFX2GB9nXy4XucUAc14B/rpDVZ2zJUZX583ItsQfujG2gkJW6wh74DPjwh9P8tuxclo54Y1B+5qc5mVPqUMHEoinYLRI1gkIeDk/NFtPbqVHSjvDpb9ZzaXhbUz+JBHrpY2tRatFZPlRnrStdS9bWg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647e48da-5b4f-4fc5-8189-08d7a56ce0ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2020 10:12:14.4627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6h5TZEerq+mKhxfrsa6yn7FKkHiUaDwFJZhwWyh+1BqZV7DQWcztDEqlaE0hudd4Oq2XjTSRE+GMqXsC+RryrX8kzYVZhDTzXe9XZFjlHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3632
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/01/2020 12:47, Christoph Hellwig wrote:=0A=
> On Tue, Jan 28, 2020 at 12:59:27AM +0900, Johannes Thumshirn wrote:=0A=
>>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);=0A=
>>   	struct btrfs_root *tree_root;=0A=
>>   	struct btrfs_root *chunk_root;=0A=
>> +	struct page *super_page;=0A=
>> +	u8 *superblock;=0A=
> =0A=
> Any good reason this isn't a struct btrfs_super_block * instead?=0A=
=0A=
No not really.=0A=
=0A=
[...]=0A=
=0A=
>> @@ -2873,8 +2880,9 @@ int __cold open_ctree(struct super_block *sb,=0A=
>>   	 * following bytes up to INFO_SIZE, the checksum is calculated from=
=0A=
>>   	 * the whole block of INFO_SIZE=0A=
>>   	 */=0A=
>> -	memcpy(fs_info->super_copy, bh->b_data, sizeof(*fs_info->super_copy));=
=0A=
>> -	brelse(bh);=0A=
>> +	memcpy(fs_info->super_copy, superblock, sizeof(*fs_info->super_copy));=
=0A=
>> +	kunmap(super_page);=0A=
>> +	put_page(super_page);=0A=
> =0A=
> Would it make sense to move the code up to here in a helper to=0A=
> simplify the error handling?=0A=
=0A=
There is btrfs_release_disk_super() already but David didn't like it's =0A=
use here.=0A=
=0A=
> =0A=
>>   =0A=
>>   int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,=
=0A=
>> -			struct buffer_head **bh_ret)=0A=
>> +			struct page **super_page)=0A=
>>   {=0A=
>> -	struct buffer_head *bh;=0A=
>>   	struct btrfs_super_block *super;=0A=
>> +	struct bio_vec bio_vec;=0A=
>> +	struct bio bio;=0A=
>> +	struct page *page;=0A=
>>   	u64 bytenr;=0A=
>> +	struct address_space *mapping =3D bdev->bd_inode->i_mapping;=0A=
>> +	gfp_t gfp_mask;=0A=
>> +	int ret;=0A=
>>   =0A=
>>   	bytenr =3D btrfs_sb_offset(copy_num);=0A=
>>   	if (bytenr + BTRFS_SUPER_INFO_SIZE >=3D i_size_read(bdev->bd_inode))=
=0A=
>>   		return -EINVAL;=0A=
>>   =0A=
>> -	bh =3D __bread(bdev, bytenr / BTRFS_BDEV_BLOCKSIZE, BTRFS_SUPER_INFO_S=
IZE);=0A=
>> +	gfp_mask =3D mapping_gfp_constraint(mapping, ~__GFP_FS) | __GFP_NOFAIL=
;=0A=
>> +	page =3D find_or_create_page(mapping, bytenr >> PAGE_SHIFT, gfp_mask);=
=0A=
> =0A=
> Why not simply use read_cache_page_gfp to find or read the page?=0A=
=0A=
right=0A=
=0A=
> =0A=
>> -	super =3D (struct btrfs_super_block *)bh->b_data;=0A=
>> +	super =3D kmap(page);=0A=
>>   	if (btrfs_super_bytenr(super) !=3D bytenr ||=0A=
>>   		    btrfs_super_magic(super) !=3D BTRFS_MAGIC) {=0A=
>> -		brelse(bh);=0A=
>> +		kunmap(page);=0A=
>> +		put_page(page);=0A=
>>   		return -EINVAL;=0A=
>>   	}=0A=
>> +	kunmap(page);=0A=
>>   =0A=
>> -	*bh_ret =3D bh;=0A=
>> +	*super_page =3D page;=0A=
> =0A=
> Given that both callers need the kernel virtual address, why not leave it=
=0A=
> kmapped?  OTOH if you use read_cache_page_gfp, we could just kill=0A=
> btrfs_read_dev_one_super and open code the call to read_cache_page_gfp=0A=
> and btrfs_super_bytenr / btrfs_super_magic in the callers.=0A=
=0A=
Sounds like a good idea, I'll have a look into it.=0A=
=0A=
> =0A=
>> +	bio_init(&bio, &bio_vec, 1);=0A=
>>   	for (copy_num =3D 0; copy_num < BTRFS_SUPER_MIRROR_MAX;=0A=
>>   		copy_num++) {=0A=
>> +		u64 bytenr =3D btrfs_sb_offset(copy_num);=0A=
>> +		struct page *page;=0A=
>>   =0A=
>> -		if (btrfs_read_dev_one_super(bdev, copy_num, &bh))=0A=
>> +		if (btrfs_read_dev_one_super(bdev, copy_num, &page))=0A=
>>   			continue;=0A=
>>   =0A=
>> -		disk_super =3D (struct btrfs_super_block *)bh->b_data;=0A=
>> +		disk_super =3D kmap(page) + offset_in_page(bytenr);=0A=
>>   =0A=
>>   		memset(&disk_super->magic, 0, sizeof(disk_super->magic));=0A=
>> -		set_buffer_dirty(bh);=0A=
>> -		sync_dirty_buffer(bh);=0A=
>> -		brelse(bh);=0A=
>> +=0A=
>> +		bio.bi_iter.bi_sector =3D bytenr >> SECTOR_SHIFT;=0A=
>> +		bio_set_dev(&bio, bdev);=0A=
>> +		bio.bi_opf =3D REQ_OP_WRITE;=0A=
>> +		bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE,=0A=
>> +			     offset_in_page(bytenr));=0A=
>> +=0A=
>> +		lock_page(page);=0A=
>> +		submit_bio_wait(&bio);=0A=
>> +		unlock_page(page);=0A=
>> +		kunmap(page);=0A=
>> +		put_page(page);=0A=
>> +		bio_reset(&bio);=0A=
> =0A=
> Facoting out the code to write a single sb would clean this up a bit.=0A=
> Also no real need to keep the page kmapped when under I/O.=0A=
> =0A=
=0A=
Yup, will be doing=0A=

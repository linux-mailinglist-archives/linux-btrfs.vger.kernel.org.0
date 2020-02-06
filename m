Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6451153FCF
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 09:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBFIRY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 03:17:24 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17387 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgBFIRX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 03:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580977042; x=1612513042;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BkVMhsVl0xmqBllqBa3+rhSvpvM9Kd/BkyT4ySugfGw=;
  b=FVdWsFAflVlhJQLDeMskKTCBCtUyOs8UJohqiwW0iRfadnoYRj23REd5
   9Qv8WwfbNN1tCd6ICIc+imK5lMI2b0o+rUs9KEsfOkrhx+Vdpl1lBYLdL
   yik8gFiUiWXSHhzgSWCjRKZ41DNnTZOKIbFnUzuMRM6aS7kjDgS7YT6fF
   jS9MIRhz55yHPydUeJsRsB/SLuU3nMh8u/YNEqk2zQj5ElED1e8XkIfyI
   xmV6jAzBKDzIyVLT7TheKswwa3KIavEsF7Ceq/bI6eC+/Pa6bd1ui5Eja
   vj5i0pY2eJHUnfq/wyN7JtRBTn7U1t1GPVSh8efotTpOe+WTuSUCFqUJZ
   w==;
IronPort-SDR: OksjOTM1HCX1itHDGMZn2aNntrQ6emjYuzyUoeyvYP28TqVC8vsW8raiZNPsiwnIGRQK5KkNuQ
 zuDq+5Zn3vuotKGFLW5eSmSszxF2xEGB0S3aq/efAD6QAuTM9A60lnJQylUYiqkSQKStCC/ORa
 4l2R9TXFu83q28MbArzMRBAim0G2Wvhwl/1IU1x5Q+8bRcwivks0CmPGu9uotGPlYL24ym8BlJ
 C8B/MBuPKAJZD7SDBEnDvTNDR0NtbyfdjphaiIAk95N16qB5qfaL1WIvOSjDzEc7U5QP+CXm0U
 raw=
X-IronPort-AV: E=Sophos;i="5.70,408,1574092800"; 
   d="scan'208";a="133581489"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 16:17:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHCw9lLetWbO8XZwnsU9DeE62io+2cQUvH+HsJ4otA2l6YetK5K7fbfOiuOGEsPCu7dPSamoBcKh2fC4kd2A+2uA8KfGQqqxkELPFyhNIg61gdrgzdaHyNfDeDWmFpfPAym6fljvamV89isRdmHvKHOXqvJB2BSNqy0zc0SleAOJUkCSJ1a9mMd+FKyu2hiix7mVybps+EVa8Td8sOHp08P6NDpH6gWxngUf4ZUHgarK2KS68708sXWPWePiaiNWS6UDeVqs8AMDWySvMS/XTl7m73GC+3r9eGOLTty/toLeOh98q3fDMqMf29REZaN6knAGjqpEAIR9ogiIGfuDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8xREJSs5NA5dY7eKLu6GbBoLE+5cs95p71BKx9IlEk=;
 b=aPLZojWkxi606MZn+LGPEKrvjgSRdWCz0thPnuIMwUJWN1Sh5QXEAHIMBuDcFJiXE1BrlACsMxaRP5HZUQ2ONCy0Nj2diT7NAiA6E7zWrFOQ8jAmf0IdVs1+FM/wyGPxD21C1spgRl/pBsC+x1FTtJPtD0BpTo8FsUJ9GMeBOzk6B98x2Bb7XNAVUXYp1iAyPJi0cftv2kQmydCUqqTW5gOAWBjo2LKnoMbTNU0F4ChaMDE0BoGq4YItrkVsCmDnLi+GjTwYKXko10ebksMRKZZzpTwk3K1gggC9IIL5qE4dElmqhfmPFWFdMlVDC0FnGPY/Mp0cKOuSqshenp7iBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8xREJSs5NA5dY7eKLu6GbBoLE+5cs95p71BKx9IlEk=;
 b=z5RfSA8MfMyY/chiEkA/ra0DXmZk1JHtROQfOIbeTOGUm0/ZWs211wuFd4CJBb1whT9I5I5xc9IoEQ8w2yY/zloxmp5cz51cE9yviHMCHd2S+qbqDp9tzvQRKXAo95C1+a10Oj7dfHrNquykxnhLlBqE6PI4RgdW6a5/tBa4C4g=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3678.namprd04.prod.outlook.com (10.167.139.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 08:17:20 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Thu, 6 Feb 2020
 08:17:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] btrfs: use the page-cache for super block reading
Thread-Topic: [PATCH v4 1/5] btrfs: use the page-cache for super block reading
Thread-Index: AQHV3DH3mC4sQyE5G0ifuyrJtqLY6Q==
Date:   Thu, 6 Feb 2020 08:17:20 +0000
Message-ID: <SN4PR0401MB359854D81C504BBE28B8B2EB9B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200205143831.13959-1-johannes.thumshirn@wdc.com>
 <20200205143831.13959-2-johannes.thumshirn@wdc.com>
 <20200205165319.GA6326@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a4006aa-a734-4fd5-b371-08d7aadcfc9e
x-ms-traffictypediagnostic: SN4PR0401MB3678:
x-microsoft-antispam-prvs: <SN4PR0401MB36787AB8FFC27998A75647F39B1D0@SN4PR0401MB3678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(189003)(199004)(54906003)(2906002)(26005)(186003)(8676002)(33656002)(8936002)(71200400001)(6506007)(81156014)(53546011)(316002)(81166006)(4326008)(66446008)(55016002)(66476007)(66556008)(64756008)(76116006)(91956017)(6916009)(9686003)(66946007)(478600001)(5660300002)(52536014)(86362001)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3678;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +WQgxiOv3RUBzZ65i+j7fRrBIGtA9T09YF7dWA0Sn/i2vaEFlblBkzJ0ygVNCggJLgnrEu0lfePBy0sY4DdUNpV9ljhBjoBZ4Yg2kuZV48AX/IpIRpLuyZooWbtkDIaaFmyDzebgDUB3XHGK9R+Qf9ig0z91nTakOEMfDJNwIdUCbsXMe0DdCZP9veu/DVDKQLgdMDWlq02KfqsOXuCdlHAhFSplJ+9yihUf6p5Hnz5xsMZE58gFZSvmV97apbq0q+EZFcrY4P46ptaAIZTnbTmB2mPk2tLPdtKfPGPBo3znvSJKUCI8HkLIQtg607Afv0TtFKoeCOymngon6bUJrUijDKiNf+Vyt6hkM+iueM+qF4VssZgWPCLYQD0nVBE2AeNFyQfeg37Mg7hpibP6QgOd2kzJATM4ACIpPeXnmtK3Szkuw066QV+IpTRkWyAI
x-ms-exchange-antispam-messagedata: OQ0hRVLQP3lmFa1eOUv6XMrcKzVq1G0zYh3gx5IFrXl4uQmEuz4o2a4iYV2aaomhVXzS3fuSQ8GkzdN+gJW/vlh9Q2i2HAWXu71Gf5Bz/44UP9qX0IIKwspQVO5yEmLM1KYfhJSrWrsE6BBign/GqA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4006aa-a734-4fd5-b371-08d7aadcfc9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 08:17:20.1951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NZZUurjHXLpEemam9EOqOhDhmLKkuSapzjOm9T8GrAXtvPN8jyygWb486dNswre1WBOuWQFHb9bmTZmbrpFX0hBSMLl39GY7CXtrf8ZDkM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3678
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/02/2020 17:53, Christoph Hellwig wrote:=0A=
> On Wed, Feb 05, 2020 at 11:38:27PM +0900, Johannes Thumshirn wrote:=0A=
>> Super-block reading in BTRFS is done using buffer_heads. Buffer_heads ha=
ve=0A=
>> some drawbacks, like not being able to propagate errors from the lower=
=0A=
>> layers.=0A=
>>=0A=
>> Directly use the page cache for reading the super-blocks from disk or=0A=
>> invalidating an on-disk super-block. We have to use the page-cache so to=
=0A=
>> avoid races between mkfs and udev. See also 6f60cbd3ae44 ("btrfs: access=
=0A=
>> superblock via pagecache in scan_one_device").=0A=
>>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>=0A=
>> ---=0A=
>> Changes to v3:=0A=
>> - Use read_cache_pages() and write_one_page() for IO (hch)=0A=
>> - Changed subject (David)=0A=
>> - Dropped Josef's R-b due to change=0A=
>>=0A=
>> Changes to v2:=0A=
>> - open-code kunmap() + put_page() (David)=0A=
>> - fix double kunmap() (David)=0A=
>> - don't use bi_set_op_attrs() (David)=0A=
>>=0A=
>> Changes to v1:=0A=
>> - move 'super_page' into for-loop in btrfs_scratch_superblocks() (Nikola=
y)=0A=
>> - switch to using pagecahce instead of alloc_pages() (Nikolay, David)=0A=
>> ---=0A=
>>   fs/btrfs/disk-io.c | 78 +++++++++++++++++++++++++---------------------=
=0A=
>>   fs/btrfs/disk-io.h |  4 +--=0A=
>>   fs/btrfs/volumes.c | 57 +++++++++++++++++----------------=0A=
>>   fs/btrfs/volumes.h |  2 --=0A=
>>   4 files changed, 76 insertions(+), 65 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c=0A=
>> index 28622de9e642..bc14ef1aadda 100644=0A=
>> --- a/fs/btrfs/disk-io.c=0A=
>> +++ b/fs/btrfs/disk-io.c=0A=
>> @@ -2617,11 +2617,12 @@ int __cold open_ctree(struct super_block *sb,=0A=
>>   	u64 features;=0A=
>>   	u16 csum_type;=0A=
>>   	struct btrfs_key location;=0A=
>> -	struct buffer_head *bh;=0A=
>>   	struct btrfs_super_block *disk_super;=0A=
>>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);=0A=
>>   	struct btrfs_root *tree_root;=0A=
>>   	struct btrfs_root *chunk_root;=0A=
>> +	struct page *super_page;=0A=
>> +	u8 *superblock;=0A=
> =0A=
> I thought you agree to turn this into a struct btrfs_super_block=0A=
> pointer?=0A=
=0A=
As stated in the cover letter, I lost track of the TODOs ;-)=0A=
=0A=
>>   	bytenr =3D btrfs_sb_offset(copy_num);=0A=
>>   	if (bytenr + BTRFS_SUPER_INFO_SIZE >=3D i_size_read(bdev->bd_inode))=
=0A=
>>   		return -EINVAL;=0A=
>>   =0A=
>> -	bh =3D __bread(bdev, bytenr / BTRFS_BDEV_BLOCKSIZE, BTRFS_SUPER_INFO_S=
IZE);=0A=
>> -	/*=0A=
>> -	 * If we fail to read from the underlying devices, as of now=0A=
>> -	 * the best option we have is to mark it EIO.=0A=
>> -	 */=0A=
>> -	if (!bh)=0A=
>> -		return -EIO;=0A=
>> +	gfp_mask =3D mapping_gfp_constraint(mapping, ~__GFP_FS) | __GFP_NOFAIL=
;=0A=
>> +	page =3D read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, gfp_mask);=
=0A=
>> +	if (IS_ERR_OR_NULL(page))=0A=
>> +		return -ENOMEM;=0A=
> =0A=
> Why do you need the __GFP_NOFAIL given that failures are handled=0A=
> properly here?  Also I think instead of using mapping_gfp_constraint you=
=0A=
> can use GFP_NOFS directly here.=0A=
=0A=
OK=0A=
=0A=
>>   =0A=
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
> =0A=
> Also last time I wondered why we can't leave the page mapped for the=0A=
> caller and also return the virtual address?  That would keep the=0A=
> callers a little cleaner.  Note that you don't need to pass the=0A=
> struct page in that case as the unmap helper can use kmap_to_page (and=0A=
> I think a helper would be really nice for the unmap and put anyway).=0A=
> =0A=
=0A=
There's btrfs_release_disk_super() but David didn't like the use of it =0A=
in v2 of this series. But when using a 'struct btrfs_disk_super' instead =
=0A=
of a 'struct page' I think he could be ok.=0A=

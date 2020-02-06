Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC6154007
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 09:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgBFIUU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 03:20:20 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38902 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgBFIUT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 03:20:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580977219; x=1612513219;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=stZLc1XOs49Ze0xS/2eEnk9BMPDcJk70XmYGmaKirNM=;
  b=Cu/zNtkQ6NZA2KEdIdaJ55U1ndv0alSCPt4UsyVZfE+C0QUb/QvE3rWg
   zWd2aQihpFx49Gw8vwH76Aq3BXOltq482Nk0DxbuHn6x9NkXAdtjoK1nz
   ff5MNlbKsjboM/DiBUhY6LvWRCSeTjpHyqyap4oezP3cnP1QhBj93iaiO
   1cJ7k76768Kyt6I5Mn1UHlk/ygf0yoiZSQMvZI9PuSvO81qTYVD6CX0mS
   d1oxTShXHzJjMN3Zb4UFe3wQj6TvkGb5G/M2pD/sDUASTE8YWqLDfj4uS
   028QGDA1e4vvNhGKBBrESz33ur+g5R/Dpwg/qbu2J+cCGcTf4Il4H83fo
   g==;
IronPort-SDR: yg/joTeLE/YU9mp4cGtpBlRwLc47r5plR9lhAm8aRUp0ympS3GAxFZzdkYXiMm1HCsASjpQ8hz
 bd5Eyr2DLsAyj8YIYcIiOak1Sy1eQyXSWpsn0+r3WlELhs4uJug8lWyYv6OTTIeC4Auc+SlB60
 yiXSZh/jpnMrMN9vkssag5zcMFiA4kdzFK5IMup42ltLV2AWgbjrf0GHAx+WXtvYWk8GbEz9SP
 Ahu0qGV/ORuePhOxyCiJhWwJxCetXLE5XdoaAyEfbjKB+04633jWION7VtbsvGmvR7Zq1PG/iM
 A2o=
X-IronPort-AV: E=Sophos;i="5.70,408,1574092800"; 
   d="scan'208";a="129233335"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 16:20:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FE2V/h/qBaM+TI0RqOvMYxQJdHRipQUEmm+rQRz2feC+QpNbXV/rcBD5YE5hN5ah45P12TWR4d0OG3w+7m0ZzH7g93o/c8J6hchkTQojKzD+0JXlpNk+IaFHgRLEo31U1H84qLgzkhgsjvx5e/bnbpa95wfbsLxoGgC3+TZCl2pCCURDoZf9LUsrGI+eSiG0Xy5VpIqarqas1t+W60KWnLs7OzoggxEh04aCRybt6sksJzdWcqg7b5fjKN+tGsXCT/6fDoRwqXGr8zQFIDuinWlPG6aG3qQjB3o9LWifybaN2yAB8wm963326/RQaUwm7wBi2cAnya7Hjz196/9hpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgiZPCfQcdMIDOFDryjkCyXmvuQHUY/FoFr4O63SsBc=;
 b=hRTH0mgYmQ5nCsCilrhojBKPDFtOWJgjDYtq2hjzqAWZuTK1yr2CKEHaeAA9g5sF9oQGkkfxpBjW9uMVfQrSrEkSUCY1F4vflE1x+LEV1KTzvo+cJNb5dYbIJXOZKOMSHdZux2erSGxKtcR7d0W3tsaAknowzhh4Flgvjzs+W3w/Oe8P/HYBP9But1HjWMI50/uHUUqsaBGhx+xWgYl1g0W/K0uqfNP39BaDHVsqGvzd9qGdRAjIwxJXxEmr8wSorcYSgiba8PLA/vnk5ZcaRzqf0Nyt1ZzSkFegOw7kzTIYQLvg68NEjFBBj4tlgi+mDPBbSiPyLuNzmAb5mAZsLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgiZPCfQcdMIDOFDryjkCyXmvuQHUY/FoFr4O63SsBc=;
 b=d8mKSpmBQ2hxbiTGXWwLQgb3eSeBDBthEAS9id7SLoom/ky5iZswc5bI2w0Wnjgqj/ibASCBXTci9YUGw+QdSxrb7sKpBQ0u76FGsW1FVDydpWictwk3dEo0LHI/5VKanjy7GOMuH5PrwJGZVRTU3h0tRV75QQDypA8arwJS/90=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3678.namprd04.prod.outlook.com (10.167.139.156) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 08:20:16 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Thu, 6 Feb 2020
 08:20:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] btrfs: use BIOs instead of buffer_heads from
 superblock writeout
Thread-Topic: [PATCH v4 2/5] btrfs: use BIOs instead of buffer_heads from
 superblock writeout
Thread-Index: AQHV3DH4TNBI3u/6K0C9PnMIQNMzdw==
Date:   Thu, 6 Feb 2020 08:20:16 +0000
Message-ID: <SN4PR0401MB359893900DDE52857064A2CF9B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200205143831.13959-1-johannes.thumshirn@wdc.com>
 <20200205143831.13959-3-johannes.thumshirn@wdc.com>
 <20200205181605.GA11348@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e3a88d30-29f1-4858-ea29-08d7aadd65d5
x-ms-traffictypediagnostic: SN4PR0401MB3678:
x-microsoft-antispam-prvs: <SN4PR0401MB367887D9FAE663AA2FC82A419B1D0@SN4PR0401MB3678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(189003)(199004)(54906003)(2906002)(26005)(186003)(8676002)(33656002)(8936002)(71200400001)(6506007)(81156014)(53546011)(316002)(81166006)(4326008)(66446008)(55016002)(66476007)(66556008)(64756008)(76116006)(91956017)(6916009)(9686003)(66946007)(478600001)(5660300002)(52536014)(86362001)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3678;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DxiWs1CPjNd7FJ1ghN7ElP6z4JxxpBqcvva182NqZ+RpwOlSqY6wCbgjBHrrovBopTstl1LuYmiLomIpWMxjdTlXkIevglwYAq3c/9+ahNta6rTnai3EmvDKLVg9RCd5+KIJyBiZ3OgOEB7hvmdavTr3okz4z4u8r9MxpO+3+bBRqWd2+/j+sT18U9+huWCZjDkJqyhcqWF7Afzrp0EP1DIh2gRTpIxWRV4c0I+zLKNUg8/W88+K9L4vhGkeVmqws9NNiqU7sIo89Hixn94x15Qf2qR3/wq5j1AfvzJKxef5vvKv8emJTLTrASu66LBo1TAaxYPOPYF3gJohmq+LgQli++3/lgUnlCPL1g9CpBe7qc+T4iU1pHYs3kgXrKTVL7l1roeBMiv7Dnlf+9HztMEq9BY+ZzCn+6KscCCkR+oFNe8quhnRgfAhllKOVcPn
x-ms-exchange-antispam-messagedata: Jf97i8XzejSZkazIXOE30xPB60dFv0nUaaljlvCaF1P97JbP+9dbotz90KWPRQmDoKahGRVxR9IWXv24hkF867ypmiCXAAAebW6513qkBdWflr+9BNmG8sXdJpQ+3eTW6oKe+vrIZiE4H53Q29mJ7Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a88d30-29f1-4858-ea29-08d7aadd65d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 08:20:16.8117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tZ80FQy7669JBdtcf7k7/QdIXi9nQ11VtygaPBnp7aIv7NfXcbQVApRv6w08DX6Ys/2OLrngY29F4nhRQSwE4HkKFTuVkOyQKuozTrd+BjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3678
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/02/2020 19:16, Christoph Hellwig wrote:=0A=
> On Wed, Feb 05, 2020 at 11:38:28PM +0900, Johannes Thumshirn wrote:=0A=
>> +static void btrfs_end_super_write(struct bio *bio)=0A=
>>   {=0A=
>> +	struct btrfs_device *device =3D bio->bi_private;=0A=
>> +	struct bio_vec *bvec;=0A=
>> +	struct bvec_iter_all iter_all;=0A=
>> +	struct page *page;=0A=
>> +=0A=
>> +	bio_for_each_segment_all(bvec, bio, iter_all) {=0A=
>> +		page =3D bvec->bv_page;=0A=
>> +=0A=
>> +		if (blk_status_to_errno(bio->bi_status)) {=0A=
> =0A=
> Nit: this could simply check bio->bi_status without a conversion.=0A=
> =0A=
>> +			btrfs_warn_rl_in_rcu(device->fs_info,=0A=
>> +					     "lost page write due to IO error on %s",=0A=
>> +					     rcu_str_deref(device->name));=0A=
> =0A=
> But maybe you want to print the error here?=0A=
> =0A=
>> +	gfp_mask =3D mapping_gfp_constraint(mapping, ~__GFP_FS) | __GFP_NOFAIL=
;=0A=
> =0A=
> Same comment on the ask as in the previous patch.=0A=
> =0A=
>> +		u8 *ptr;=0A=
> =0A=
> I'd use a typed pointer here again..=0A=
> =0A=
>> +		ptr =3D kmap(page);=0A=
>> +		memcpy(ptr, sb, BTRFS_SUPER_INFO_SIZE);=0A=
> =0A=
> With which you could do a struct assignment here and very slightly=0A=
> improve type safety.=0A=
> =0A=
>> @@ -3497,9 +3506,23 @@ static int write_dev_supers(struct btrfs_device *=
device,=0A=
>>   		op_flags =3D REQ_SYNC | REQ_META | REQ_PRIO;=0A=
>>   		if (i =3D=3D 0 && !btrfs_test_opt(device->fs_info, NOBARRIER))=0A=
>>   			op_flags |=3D REQ_FUA;=0A=
> =0A=
> Question on the existing code:  why is it safe to not use FUA for the=0A=
> subsequent superblocks?=0A=
> =0A=
>> +=0A=
>> +		/*=0A=
>> +		 * Directly use BIOs here instead of relying on the page-cache=0A=
>> +		 * to do I/O, so we don't loose the ability to do integrity=0A=
>> +		 * checking.=0A=
>> +		 */=0A=
>> +		bio =3D bio_alloc(gfp_mask, 1);=0A=
>> +		bio_set_dev(bio, device->bdev);=0A=
>> +		bio->bi_iter.bi_sector =3D bytenr >> SECTOR_SHIFT;=0A=
>> +		bio->bi_private =3D device;=0A=
>> +		bio->bi_end_io =3D btrfs_end_super_write;=0A=
>> +		bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,=0A=
>> +			     offset_in_page(bytenr));=0A=
> =0A=
> Missing return value check.  But given that it is a single page and=0A=
> can't error out please switch to __bio_add_page here.=0A=
=0A=
Good question, I guess it's saver to always FUA the SBs=0A=
=0A=
> =0A=
>> +		bio->bi_opf =3D REQ_OP_WRITE | op_flags;=0A=
> =0A=
> You could kill the op_flags variable and just assign everything directly=
=0A=
> to bio->bi_opf.=0A=
> =0A=
=0A=
Then I'd still have to deal with the NOBARRIER mount option here so =0A=
op_flags is nice to have for readability.=0A=
=0A=

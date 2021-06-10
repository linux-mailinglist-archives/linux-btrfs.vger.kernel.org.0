Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502613A2596
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 09:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhFJHi7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 03:38:59 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:16806 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhFJHi6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 03:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623310621; x=1654846621;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tVWlwllX2LhzjuFX4rCgiBC+Uv+xqxmC94mjBIiQsEA=;
  b=kCVS1nvcXsZyGj47gs7wq0OiGfAUn00oyEBNTm2+wNoOSp1GV1R79QJW
   oVKHKEug41CMRJ0kvw0hQMqLqC8CPhYSIGc6kv8crds5KnPNm8k/3Vuz4
   5oJNoq5V2v2qNWsHnCKDrHeebf1N5px64SLYr3vDlUBRBA2eOEC9jUEGT
   vFClPI8b9V2EbWaYLJ6k9hjxJlOefmKcgz9sjxd3fLpscPpXnUXiFyDvp
   LiCTiy3Hir4jGKlEa+55RPbmIt+tWAO1lVlcuJ6suYIkiPMTCkSLgipdG
   8l+Lue+5LZYudOW6ePZ6YZ6qSmpwtyTj4dcITCXq0MHObeW1q8bLYZXNB
   A==;
IronPort-SDR: K42RP+YJd2qTdb7sMdZlbsg47cdWaFz+WPfVpbT6uTe2RcbT+DCHR0G1jNRMn/U2vjgBy9a7uJ
 MtN0oTVrQ39zMTZLr1XGgMh5Jd+qWyTDga9spcUh/om42elzwAMtaufXFTPn5pFYlLTAEFbw3I
 /KNbHnsiNAy9y8nW32LLvB0nIE7Ij0NP87C3sygqVDKWLVORQ5CnK+gdO2yPl2yEv11jIs/JT1
 qFiF1PAWsfgAwiBVj4dJaqUKXxz0pYbtoovpbhaOObKktMSCQKfI1mSRRSkMe8oNJ7n8HzVcKE
 Qds=
X-IronPort-AV: E=Sophos;i="5.83,263,1616428800"; 
   d="scan'208";a="171421687"
Received: from mail-bn1nam07lp2048.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.48])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 15:37:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QL6Hbnxt+r8XnUAuP/eueBt4pHbUPwdH4Li4DYpMEj1tvw7GEJ6Uhc4FoNTpPJRGTDoYekDsf1UbTi28VTqu9MNKNxQ+KWvFUMMzmVwXR5VMKLkbuPiEjLoMsSiT9DATfzocY9kGI5GVRbTPbcyyuGlbp56VYWRu7CR/511+EilBrTGod0R/i2LCFvNThjVfBPzbQbru6tKZ4OorxzADPIlUazi/pK3fPgF8CgidD66Q0ud0Z8P7QmKGwvzbSddwQCv9FpMzoW3CvO0Dcdc4Rm7TrvG+DTXYqYa/4K7YEX7b7UCAqKmFcIYpVdLqcq90mm6EMY2+miIXm/M+/hh3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4k9GDI4Kxsx4olbC9mMzPjo4+xwVgVZxdQ0wv5Eh+8=;
 b=PF3zZdAzqewU62v/U31AsnlQi+etfJN2u7oA+iakgTqxVd4KaWKzVNT2P/f68c2nu2g7/XiPz6fd/6IQss3CXPnEaLC9mYLztTm8rz4QYJf2l2yxDIfBvf6OEppG/+I4QmHXAGoy2qQ4hCLkQnvLN0LhJnx4YMfWFE68jN5kO41VaQWJ1vviylqTWQTj8hDa+fWicXfF1qXUd+3WmUDCbGQBsYLRU+WR8Kya1KFD5X2tiF5Ln9eLsXGn3jLNhh6VMhLahvq3y0gLCGIommNUZ8XW7ufKntlIyjqvtuOJuyiCwi3iQHjadvS4i05SP4+M60SoIldljziGxJZ7mHTv3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4k9GDI4Kxsx4olbC9mMzPjo4+xwVgVZxdQ0wv5Eh+8=;
 b=xT/ETV/BFiR21XPqhXfK+QQ26Hx94ghh/yaHxmlfgeu8YFEji0rcbJcSMIUghxo5XpVPBn+Bq5l03VmEKoukPEOYM0+ojME58jQGMuHapGm1K4hXabhAKpv2Agw6VaSLapGRA7QmegGp1gljW36vCPcEcg7olmZRWC1Zf+VsyOU=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB0810.namprd04.prod.outlook.com (2603:10b6:3:f5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20; Thu, 10 Jun 2021 07:37:00 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 07:37:00 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
Thread-Topic: [PATCH v2 2/3] btrfs: zoned: fix compressed writes
Thread-Index: AQHXS/w7IU+fudj4aUGr535tkQGBcg==
Date:   Thu, 10 Jun 2021 07:36:59 +0000
Message-ID: <DM6PR04MB70813C91EEB7952FC3EF917EE7359@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
 <1220142568f5b5f0d06fbc3ee28a08060afc0a53.1621351444.git.johannes.thumshirn@wdc.com>
 <9464ea87-6d50-9015-a6f5-c7b3d61458ca@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmx.com; dkim=none (message not signed)
 header.d=none;gmx.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f2e47d6-000a-4272-4904-08d92be28861
x-ms-traffictypediagnostic: DM5PR04MB0810:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR04MB0810628B1BC12B4A6AF9C9B1E7359@DM5PR04MB0810.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +qmiY9+uHBlIjtUFsrXJQAUuEuxaPjSxDlTcKGO5ulByIS75uKWV4b8H0RDN/ThyKkbV7CNVm0vLYeT3nACymCTYKtZdEVAC4HIdssEOto0IV0ftTG4EkXjV5UViCBRg/iMW2nMDS+LAKJhtrlKk65w/lc7oFI8znq7h8J53uMBeotD/HFJGD4X6fjT+iPINThiTsDyXsfWsT4b5OCs4UTIOxQHLYqh5Ox7lwumnXoFeNqMAVPEHBDQFuv8v8rfuafWIpwvRtWgoAgjIbqYhiJcTSX587jXdIKpSUnlDW8Shx4rrYrxtn2A9kI6beaIoKj+Zu0kZbPAxZDslACoJoy8qVv2DxiZaXsRaz8EIQDFGV4mK7PylOd/RavM7hmgUdsapFC+L48PRjrpKD9w8VDgQ06pcXNp3/b1L5guTibuKJA1XagZIFQ5s5346nD6oDOjp3Rc9hu/ChU+GhEl6P5SVbZjyq/aTnxd2MI3HlQcbNrOiFW6pLtcFqvTOkafa9QW66nXyTjgu0ZzJPekCPsZrs7F/bj/LWguf+ylYH4Ymd0CKOnuiYVHqccrOLmW5Cp03Is+LHEF5YGpgWtXXpYR4ZgAtMfyB7cWAY9PIq7Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(110136005)(8676002)(6506007)(316002)(2906002)(91956017)(52536014)(7696005)(8936002)(122000001)(478600001)(186003)(38100700002)(71200400001)(55016002)(9686003)(66446008)(86362001)(83380400001)(66556008)(76116006)(66946007)(26005)(5660300002)(64756008)(53546011)(66476007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?am40N3VBYUZTYXJEcDR0MTlrTkM5U3ZtY3NDY21XYnZuVzF3QktBdUgz?=
 =?iso-2022-jp?B?TzdJbHhLZ1dYME5oTDZpODBWa254eE81Y0JybE5vU0lTNlR6WFdRc3VK?=
 =?iso-2022-jp?B?YWFvWDg3eUJuaE8zTjcvTE9ONFVnZ3RlSW5RbitpT1kxdENTZ2xFNk9s?=
 =?iso-2022-jp?B?Y0JPMHVpWUNwUi9TSk1NU201TytBaHpHNms5UUNuYjF3Wnpab252MmRn?=
 =?iso-2022-jp?B?aVVMdWhVRFRhdkJIdmNLUmVvN0tXcmQ2aXdSdWNTK2M0VDVwWXFVd2Jt?=
 =?iso-2022-jp?B?bG1EV3hWYiswdzRFYSs0Um1YS1dTdytFb2FKeVFTcENMN3EvMENQek9R?=
 =?iso-2022-jp?B?WXVBT0lETUxFM2xkSXRjNTBWQ0s4M1pkVVh4UGl6Tm9RTnd3bmxXbnds?=
 =?iso-2022-jp?B?blltM1RBb2xJQjlZQkhsWjV5bkk4L3F4N1hmYmtZbGx5VUt2eVhqdlpM?=
 =?iso-2022-jp?B?WjRVN1VCV2c3ZUw2SUE2RzdtT1Z2OHh1M25Gd1p4V2lqRCtHMDlsT08v?=
 =?iso-2022-jp?B?OFkyYjZNTExwdDYwTldJQTVyQXUySjdTV25FV0ZOQW5nZ0hYRW9VZmZq?=
 =?iso-2022-jp?B?YXM5dFkwQXBON3lmNXZoZnozcjg4TjVOdzZGUFFUems2ejNqU21RckRZ?=
 =?iso-2022-jp?B?RFVacVl1bS9JZURwY3Y5SC9Zdzd3aHVLbGthQWJoa3JpeTh4V1Z2STZX?=
 =?iso-2022-jp?B?MDVTMEhUK2dTbGVvYTBIN2w4WDl2UDZ3dEZ4RzNGSEJSU1dPbFVzaWh6?=
 =?iso-2022-jp?B?Q01FdTEyQU1jbWYyVmJJZCs5QlI2M1ZmT2hkbjhkSWpoTWxyeTNBUXV5?=
 =?iso-2022-jp?B?WitYRDFmbXkwbGNsaDVYOUhON1ZpZ0x6R1lOU29KR3FHTWdMRjRJQWJu?=
 =?iso-2022-jp?B?em94c21abWpZdHNIbzloanB6SHZnNVcrVzdHNXpscWM1eVJuMjFiVTVU?=
 =?iso-2022-jp?B?SXl6ZXc2eU5TdzBIMzN0UkpqUXZHeVJNTWNqWU1FMGFoS3NzR0tHWGxC?=
 =?iso-2022-jp?B?OWo2RDZjVjRiNTlJRUdrbmYrUGNxMVFqV3JBdE1xU3NISGhRdUhHSG43?=
 =?iso-2022-jp?B?cUZlcDU4OUx2RjZtS2RKdzhRaktLKzZXOHZadjlWZmdrSksycXpSWjdz?=
 =?iso-2022-jp?B?ekRhRW0vMlphVDFsR1JYem5kZ1h2UjhKV3k5ckN5ODdpMGd2M0pDd1M5?=
 =?iso-2022-jp?B?M0tnNlYweTdCMUo4N0tKUmxyQmZzQ0RSVTNzS3ZxMXpqcnFuTGkxait0?=
 =?iso-2022-jp?B?WlU2U2wyZXpsTFBqMUN6TGJOSU9rOFVLa1hjUzFKdnl4NFg3VlBKSUMy?=
 =?iso-2022-jp?B?Zndsb09TczJ3di9XZHg1WkJFeU82aGoyNWZOTEZXUDI3M254Z29pQktU?=
 =?iso-2022-jp?B?M044Q2xNTnpZMkxBWFNuMTViYWY4NEVNbTdTSk5iOGFaTUdHSjZGWlln?=
 =?iso-2022-jp?B?OTU1ZUxraVRRc1NzZTVXVHRtR2VyYXV1c242RnhJQnByWEhvWVIrTnk2?=
 =?iso-2022-jp?B?WmxIdmg2T3IrQkQ3blc2UTVpdkJYb0d0WXllSmxLSS9kSzhycWhxN2N5?=
 =?iso-2022-jp?B?OCtJc0laa09ucTVFcDJJVjJtYTlRb0pjb3g4Y0o4TWFQcE5DQy90d3kz?=
 =?iso-2022-jp?B?dkIzeE81eHBEYTBuY3lKbEJUdlZWcVNISzBET2JHZmVvTE9GOUNSaEFO?=
 =?iso-2022-jp?B?bEVtNTdVcVd3Qm8xOVYwOHdBWUhVMC9yTGlpNThRWkZuZlRoVm11MFlz?=
 =?iso-2022-jp?B?aElBN2FUd0oxQlNsRzg2Y1o5MkV6R3A3UTlGemN0QWdWK283OFVIcGN5?=
 =?iso-2022-jp?B?R2NyZjlGYUd4aUNyK3dmM0xOZW1uVnJrOEgzYXFvbGFKVTJobWU3YS9V?=
 =?iso-2022-jp?B?a01BZ3YrNllKdzNudDZpMi9nRm1CVUNIS2VoTFpicjRqbVNRN2RKQ3Nz?=
 =?iso-2022-jp?B?SzFDQ0FOM0NDQUxrSHo4RTY3aGNpdz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2e47d6-000a-4272-4904-08d92be28861
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 07:36:59.8982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f/x0JmcFQ/NTz0g2cinM/8x1IFFrNWW7098JuJk0vELdzSY6WZ2pzCvDlVmSGdf3J1E9WbhJoaflEeEfuLVfOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0810
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/06/10 16:28, Qu Wenruo wrote:=0A=
> =0A=
> =0A=
> On 2021/5/18 =1B$B2<8a=1B(B11:40, Johannes Thumshirn wrote:=0A=
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
>> Fixes: 9d294a685fbc ("btrfs: zoned: enable to mount ZONED incompat flag"=
)=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> Now working on compression support for subpage, just noticed some=0A=
> strange code behavior, I'm not sure if it's designed or just a typo.=0A=
> =0A=
> So please correct me if possible.=0A=
> =0A=
> [...]=0A=
>>=0A=
>>   	bio =3D btrfs_bio_alloc(first_byte);=0A=
>> -	bio->bi_opf =3D REQ_OP_WRITE | write_flags;=0A=
>> +	bio->bi_opf =3D bio_op | write_flags;=0A=
>>   	bio->bi_private =3D cb;=0A=
>>   	bio->bi_end_io =3D end_compressed_bio_write;=0A=
>>=0A=
>> +	if (use_append) {=0A=
>> +		struct extent_map *em;=0A=
>> +		struct map_lookup *map;=0A=
>> +		struct block_device *bdev;=0A=
>> +=0A=
>> +		em =3D btrfs_get_chunk_map(fs_info, disk_start, PAGE_SIZE);=0A=
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
=0A=
This variable seems rather useless...=0A=
=0A=
>> +=0A=
>> +		bio_set_dev(bio, bdev);=0A=
>> +		free_extent_map(em);=0A=
>> +	}=0A=
>> +=0A=
> =0A=
> Here for the newly created bio, we will try to call bio_set_dev() for=0A=
> it. (although later patch refactor this part a little)=0A=
> =0A=
> So far so good.=0A=
> =0A=
>>   	if (blkcg_css) {=0A=
>>   		bio->bi_opf |=3D REQ_CGROUP_PUNT;=0A=
>>   		kthread_associate_blkcg(blkcg_css);=0A=
>> @@ -432,6 +458,7 @@ blk_status_t btrfs_submit_compressed_write(struct bt=
rfs_inode *inode, u64 start,=0A=
>>   	bytes_left =3D compressed_len;=0A=
>>   	for (pg_index =3D 0; pg_index < cb->nr_pages; pg_index++) {=0A=
>>   		int submit =3D 0;=0A=
>> +		int len;=0A=
>>=0A=
>>   		page =3D compressed_pages[pg_index];=0A=
>>   		page->mapping =3D inode->vfs_inode.i_mapping;=0A=
>> @@ -439,9 +466,13 @@ blk_status_t btrfs_submit_compressed_write(struct b=
trfs_inode *inode, u64 start,=0A=
>>   			submit =3D btrfs_bio_fits_in_stripe(page, PAGE_SIZE, bio,=0A=
>>   							  0);=0A=
>>=0A=
>> +		if (pg_index =3D=3D 0 && use_append)=0A=
>> +			len =3D bio_add_zone_append_page(bio, page, PAGE_SIZE, 0);=0A=
>> +		else=0A=
>> +			len =3D bio_add_page(bio, page, PAGE_SIZE, 0);=0A=
>> +=0A=
>>   		page->mapping =3D NULL;=0A=
>> -		if (submit || bio_add_page(bio, page, PAGE_SIZE, 0) <=0A=
>> -		    PAGE_SIZE) {=0A=
>> +		if (submit || len < PAGE_SIZE) {=0A=
>>   			/*=0A=
>>   			 * inc the count before we submit the bio so=0A=
>>   			 * we know the end IO handler won't happen before=0A=
>> @@ -465,11 +496,15 @@ blk_status_t btrfs_submit_compressed_write(struct =
btrfs_inode *inode, u64 start,=0A=
>>   			}=0A=
>>=0A=
>>   			bio =3D btrfs_bio_alloc(first_byte);=0A=
>> -			bio->bi_opf =3D REQ_OP_WRITE | write_flags;=0A=
>> +			bio->bi_opf =3D bio_op | write_flags;=0A=
> =0A=
> But here, for the newly allocated bio, we didn't call bio_set_dev() at al=
l.=0A=
> =0A=
> Shouldn't all zoned write bio need that bio_set_dev() call?=0A=
=0A=
Yep, bio->bi_bdev must be set before bio_add_zone_append_page() is called.=
=0A=
Otherwise, there will be a crash (first line of bio_add_zone_append_page() =
gets=0A=
the request queue from bio->bi_bdev). I wonder why we do not see NULL point=
er=0A=
oops here... Johannes ?=0A=
=0A=
> =0A=
> I guess since most compressed extents are pretty small, it's really hard=
=0A=
> to hit a case where we need to split the bio due to stripe boundary,=0A=
> thus very hard to hit anything wrong.=0A=
> =0A=
> Anyway, since I'm working on compression code to make compressed write=0A=
> to follow the same boundary check in extent_io.c, I can definitely=0A=
> refactor the bio allocation code to add the zoned needed calls.=0A=
> =0A=
> Thanks,=0A=
> Qu=0A=
> =0A=
>>   			bio->bi_private =3D cb;=0A=
>>   			bio->bi_end_io =3D end_compressed_bio_write;=0A=
>>   			if (blkcg_css)=0A=
>>   				bio->bi_opf |=3D REQ_CGROUP_PUNT;=0A=
>> +			/*=0A=
>> +			 * Use bio_add_page() to ensure the bio has at least one=0A=
>> +			 * page.=0A=
>> +			 */=0A=
>>   			bio_add_page(bio, page, PAGE_SIZE, 0);=0A=
>>   		}=0A=
>>   		if (bytes_left < PAGE_SIZE) {=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=

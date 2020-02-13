Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D05B15BB44
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 10:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgBMJM0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 04:12:26 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:36286 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729532AbgBMJM0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 04:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581585167; x=1613121167;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OSUAKj3+DBBkIZj8xesOWlN0ny2l80wXftNXkR2VgX0=;
  b=SnVZrIjF3yXp0kUp+wGiKYy0rv2EBauTbWUDNc7ffUv6A21TKTIONjfD
   osStde6qpa0CUyX2ivXawtoHUSRyc7HPAUHFJ+mkul6utU60EeL3YKonC
   e1zLz7RVMrIKLTuBhlFfC7aNsSYjFzcNzW/CEgNcr3mWvWuPs+DL7tzP5
   fUiT54ZxI89SV7wrxHK3Vyh+CbVPxmWDNB5zteWmDhiST8LnhC5yI2Wuh
   gZtq5hQuZG+hUX+Ea0iTp0E+2XPtsh4IKc7W4Y2+r0PvEkIo9SfcH1qdE
   U/bN2mytAVrOKaAyOymICVubc5BO53PwF8mUdkMnp8Prk1QlfQBBNFkqz
   Q==;
IronPort-SDR: NbY4w1AVtu3M79IXMVHKI4eTlCHgULkYQs3JknRiRTPjjnUvxRPmGs883NimuTkl2jhWY+gHEd
 R04zxfLntPw/ZV1WE/uZvELvmRpWIZIyCVxlltpb5Ahpx/+0E89ZVv/KmeEAcG4NnRKQEuLm8J
 qvDNx0Vvl9l7Qwe00BjvOIA+9XCTyYhRQKsfAeKAzVrQeQNBegQxH2ayrbXZ57sl7h9PxjbScZ
 ibD9wsxhQqkNLn9wwK2UtWbVlUUhSTflw2vz7bdJPRsl88jeSgYx/ajOAxgyw71o1ZelOhsDpi
 q1k=
X-IronPort-AV: E=Sophos;i="5.70,436,1574092800"; 
   d="scan'208";a="231561068"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 17:12:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Izg2A7offPiCBhDTvO4Ttdbqss05NkrcJ2CBIc5Vmt2Q8RwME2gyvI7CKWRRdTcUp4J6IwSy6GoEeeMt4Q1nTyUMR8bESeLaLR7geP9shJ/nBRcXTnifxsjEgNxjeNtQXE9VMpcr1zRoGiTAKS0sODRYmRBFIdR9gtu4c2EH5usEzX+YgGqnzCcoO0cirekEVc9ilzdfwPafFchLRpXfZXGAjby3QLMw2k4En0Dy3Y6luwfQz6vOle63GZ4sCafTqM2O32SvrTjgKRGPxlBHgOPqqJmuHPQP7Xhrc7SOLGWx3osZ9jVMuYUUOnaf4sjTsn9u75kItBHQ0QL15VH6zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2egPfXX61iySC3jgWxk6p+1daCS/nbtBxYVMos0asMM=;
 b=iVX70NH1OIZtYChRsfiO+HDjAxZAwf+sdpuGTUG4j9CUsd9IeYKhWpFUvWKFGwxNS2R+9BlHrwCbqdlWLg2PLs3b5KWhR5s+Ead8o5KB8SSdVFEBZQU9Wr1/fU5rwCoK4V4EP8J1b1Ho5ILIvtseJ+cy7FRTab4iA1MHPy/4SBQ6IAT6IyfqqGMoyZ7Q2Wu5XOXb94lvjbeCxHxivxyBdZ0KQj3SsE1261ub7ACg8ThMnTiHnuDz8Ejvrq8F8xTq1su3oyqQ0o+1o8e3vUGMcIyYHKSqUI6u+PI2JqSVgO/UoFx5KEIx6OWDJgXuHDWKcAi4MIjOuVuBqjxdGBAAVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2egPfXX61iySC3jgWxk6p+1daCS/nbtBxYVMos0asMM=;
 b=xlTsKxBDRMSxoQcdCHCkd0ALG8my6WIahZYPAKlP+dGtkh/VQwI1Qstf076xbM1QVBX8J51pHfqaO3uoY1yFsr0mrVvsxskCYpROBZcc1Hy9bDStNYVAdWOHHPvltb/DCR/dvWplYmiBI1hNomWu0bErpz0QH4H5m1UuLisW4rs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3677.namprd04.prod.outlook.com (10.167.129.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 09:12:12 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 09:12:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v7 8/8] btrfs: remove buffer_heads form superblock mirror
 integrity checking
Thread-Topic: [PATCH v7 8/8] btrfs: remove buffer_heads form superblock mirror
 integrity checking
Thread-Index: AQHV4XR5VppMFBxD10aR/QITGfFyNg==
Date:   Thu, 13 Feb 2020 09:12:11 +0000
Message-ID: <SN4PR0401MB3598F0A0FFA77EC36AE5BE179B1A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212071704.17505-1-johannes.thumshirn@wdc.com>
 <20200212071704.17505-9-johannes.thumshirn@wdc.com>
 <20200212170608.GN2902@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9907cf77-e1e3-47b8-b69b-08d7b064cf77
x-ms-traffictypediagnostic: SN4PR0401MB3677:
x-microsoft-antispam-prvs: <SN4PR0401MB3677AD64456F7B7855174E229B1A0@SN4PR0401MB3677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(33656002)(316002)(8676002)(66946007)(2906002)(55016002)(76116006)(91956017)(9686003)(7696005)(8936002)(26005)(66476007)(4326008)(5660300002)(53546011)(186003)(6506007)(478600001)(64756008)(66556008)(71200400001)(86362001)(81166006)(81156014)(54906003)(66446008)(52536014)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3677;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BzmN4PjnjCJSi4/eiBXst8Yz2Q5hgK1LLQ2TfxO0Y8rY6uthydhWvoENx0eEaI+/ExTZAviSovJlorR6R6P25KN5b2I4ZUDWn34xfdRRJ3g+Oy6HKR9m3QviJ8i5luPMOTHp/7bVVmyxHlL5CF3DEmqUWLEwLFBXz9t82cx+6Wi87CpYP5c63JdH6sjLg4JjrIhVr4eFfx85sJVuBBi6hEHHSmcW/BvTajWJq+iJa5fPTrIfzZoyxW0Arx9nltVTt8r0IEggXn2eBrPPTejyzfFLx4RXcOC4PHL9L1vw+IFvRsJ3VXFlmDtvZgFbm/SIDrU2orNGEcVSniCaj6TRH+hyanF7U3Ei/EOp53NzAuXw3MjifX3rH/ythHf8h4K4Ci9dEQhCGzDaGhKoxHtUgF8o2sNIWLESoe0klSC7kV4sapiBvHWLtEtT9rBRbMuP
x-ms-exchange-antispam-messagedata: M+a6L4lW/mkZnZALQN8ScvshzPvVEcns4YrfHU9lwIKg3XdYABmIKilm7V3qKdVfTzGHn5U9eDuOFuHZ3E9VgQ8QD7oEdAVWBDCLZDMOyi3RsEeJrwCdPTIZt1St4d5jUgrGeiQOuxEotFKOULi5Ug==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9907cf77-e1e3-47b8-b69b-08d7b064cf77
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 09:12:11.8952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vNAkarPsICU6JKoAi792QP9DKDW2cBSI6EuKzycT0k/iZG70Cp3LDqcotvoC9AkKr8C8XWRKhkcPhQ328y7XR4oZLwc0n6434puwjjO0A+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3677
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/02/2020 18:06, David Sterba wrote:=0A=
> On Wed, Feb 12, 2020 at 04:17:04PM +0900, Johannes Thumshirn wrote:=0A=
>> @@ -762,29 +761,45 @@ static int btrfsic_process_superblock_dev_mirror(=
=0A=
>>   	struct btrfs_fs_info *fs_info =3D state->fs_info;=0A=
>>   	struct btrfs_super_block *super_tmp;=0A=
>>   	u64 dev_bytenr;=0A=
>> -	struct buffer_head *bh;=0A=
>>   	struct btrfsic_block *superblock_tmp;=0A=
>>   	int pass;=0A=
>>   	struct block_device *const superblock_bdev =3D device->bdev;=0A=
>> +	struct page *page;=0A=
>> +	struct bio bio;=0A=
>> +	struct bio_vec bio_vec;=0A=
>> +	struct address_space *mapping =3D superblock_bdev->bd_inode->i_mapping=
;=0A=
>> +	int ret;=0A=
>>   =0A=
>>   	/* super block bytenr is always the unmapped device bytenr */=0A=
>>   	dev_bytenr =3D btrfs_sb_offset(superblock_mirror_num);=0A=
>>   	if (dev_bytenr + BTRFS_SUPER_INFO_SIZE > device->commit_total_bytes)=
=0A=
>>   		return -1;=0A=
>> -	bh =3D __bread(superblock_bdev, dev_bytenr / BTRFS_BDEV_BLOCKSIZE,=0A=
>> -		     BTRFS_SUPER_INFO_SIZE);=0A=
>> -	if (NULL =3D=3D bh)=0A=
>> +=0A=
>> +	page =3D find_or_create_page(mapping, dev_bytenr >> PAGE_SHIFT, GFP_NO=
FS);=0A=
>> +	if (!page)=0A=
>> +		return -1;=0A=
>> +=0A=
>> +	bio_init(&bio, &bio_vec, 1);=0A=
>> +	bio.bi_iter.bi_sector =3D dev_bytenr >> SECTOR_SHIFT;=0A=
>> +	bio_set_dev(&bio, superblock_bdev);=0A=
>> +	bio_set_op_attrs(&bio, REQ_OP_READ, 0);=0A=
>> +	bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);=0A=
>> +=0A=
>> +	ret =3D submit_bio_wait(&bio);=0A=
>> +	if (ret)=0A=
>>   		return -1;=0A=
>> -	super_tmp =3D (struct btrfs_super_block *)=0A=
>> -	    (bh->b_data + (dev_bytenr & (BTRFS_BDEV_BLOCKSIZE - 1)));=0A=
>> +=0A=
>> +	unlock_page(page);=0A=
>> +=0A=
>> +	super_tmp =3D kmap(page);=0A=
> =0A=
> I beleve the same reasoning applies here regarding kmap, it's the bdev=0A=
> mapping and we won't get a highmem page.=0A=
> =0A=
=0A=
Ah damn it my bad and __bio_add_page() as well. Can I send you a =0A=
follow-on patch to fold in?=0A=
=0A=

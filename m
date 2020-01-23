Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2F1A146EA0
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 17:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgAWQpb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 11:45:31 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58988 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgAWQpb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 11:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579797932; x=1611333932;
  h=from:to:cc:subject:date:message-id:references:
   mime-version;
  bh=QoQbSqKducREnLsr7nNcTcKDqao8rTT7fYYrPvHBp2Q=;
  b=AE3mn5/8ofFArjyUwGsOtSEFJUh912YmzqpdwZ/o+AOEIEOou6shkuUf
   cUnIn5tIII1+qqIVrVK4Y8e1A6Z/b9ccR0songv/WhvA8iSa1St+Yx+LE
   Gkc9+tZ6D9tWHC4xEmkH4iIK82MJssuw1jmnza36OrStVvVvUlg5Zs5Hx
   V50rebIDtIEm9W+Y34QIoOSFsR/Ve5OyNuYZJWomXZt+MsMjnGReu6vcF
   Hf4XDhsMvKbAi/CAM/7CMD3SeM+lH2pNef0nRBenZ8TUQJiifDN/Ux+Zc
   AV2xQ6Fh7XyaETcS1x6T2YVz0WYMPe0PHgSU9+mlZ9sB3rhTDDCsoNHB4
   w==;
IronPort-SDR: r0Iyrs8Q86G/o5hTX2K8p+3ypW/aVL2FLa/eJUS9Cgp8wEOpEyu27Jkee7yCu57PyvGnCDHX26
 MeK1v6s+0JN9VAgWvdIkg0uhqAtbKDAqYVJPojo0mHlXp3UMWCW42YkcuKu7mHYrWJkZ8GIZnb
 EPr0QPgZOUI3Uknc0qUsLN7iz8E5Xu17Tq4VQVOlF7pouCqrZB2Nx6iHfC4QMDJO7Zt59lE/k+
 MJl+y0eBJaK2FruWCPIQbVSewfp8zhH4Bv1SlF/a7/Vlsrb+EYiKdqPveUwnRrVDo23GG/wAZH
 DOs=
X-IronPort-AV: E=Sophos;i="5.70,354,1574092800"; 
   d="scan'208";a="128855676"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2020 00:45:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIOrGPfqk6SqfUWXejr+Ep4FCLtImhrFertfGxm6wx/wwyesILsEVUPlwXsoP+f1nMLm4LevLflGypGZzPArFmLYwzodPAXQCkSrttNwdS8yit3BfcTsIkuw22X/+CyMq/p1eMRYjjQYw1JUK4KL2q4fSzRdF5YvS/MLdDbXHCWg9N9hX0pv6KljVEvebJi1BhbFudglrzr3r6qhb9w/ibbT+0CJqF1uHth0oVOVNo9XuPE/7yjwfzjZfiLHy/MjuHLlp/0TmLjcFyzDyYe0AsF3A2okNIkw8TynGRIdMuFRHdqCBOGtIpmgsL3Gocb2GLuQnTW2e2QpcKVrQkO9uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogRsG5h4/OMuxyq7QlC5cRhBdf7QJkaD+xCl210tQHs=;
 b=i2WtZcBrHW3czbuNcZ2rIbRCuFVWQE0amhiTAb5XMNKN0lrItB/3mUhYrDqJDrN+4V5jGlqDtsICZZL+O43MFuEZaepdFDT4Uf3iCcAi4RYZm4tK84eq0GC+ScSLaa80mHFEX28dfiiGiLZTatZrl4pSpZE71YzV8B9CTaWF+5MslOZZocS5XUs9dy2c0v/n7DiXbxjV4wGEkLEPcTfZDA+NSD5fWwXXYzifqVQUhZsfu8GGbHrbzM/T2KUaHMq7po/ugJuGAKKY8d7/IAdpIvhGbU7O5R7IwSizgQ5bW+mtf5DdLEfjPsREiNu72l2rK9yo6w5SB+LMam7lIPnVeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogRsG5h4/OMuxyq7QlC5cRhBdf7QJkaD+xCl210tQHs=;
 b=XB+N4yaiRgVFnrIEPLVTsHaDIdMh1EJuM4fhxYqRpyeiflaOr9fV+fPVKtlsOpnAL8kysEvHzESvAfDHfMqh+0hqN1VB6SocwrxL14BkElPsiUUauQxeKiz9W8w3s5Uy41bHUnsBnQXEaMstgGfq5vUtd1xjGjq/qbJvI+xuiKU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3664.namprd04.prod.outlook.com (10.167.141.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.25; Thu, 23 Jan 2020 16:45:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 16:45:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] btrfs: remove buffer heads from super block
 reading
Thread-Topic: [PATCH v2 2/6] btrfs: remove buffer heads from super block
 reading
Thread-Index: AQHV0cXHkUCI/FABkEap4YMcvpYhNg==
Date:   Thu, 23 Jan 2020 16:45:28 +0000
Message-ID: <SN4PR0401MB359865C6D227012D2E71CF5B9B0F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200123081849.23397-1-johannes.thumshirn@wdc.com>
 <20200123081849.23397-3-johannes.thumshirn@wdc.com>
 <fa80a24c-e174-ec21-9228-8ff5fc415c72@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9403f53a-509e-4fa3-9f38-08d7a023a734
x-ms-traffictypediagnostic: SN4PR0401MB3664:
x-microsoft-antispam-prvs: <SN4PR0401MB36645534C9FD5FDDA6A0606C9B0F0@SN4PR0401MB3664.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(189003)(199004)(5660300002)(110136005)(478600001)(66556008)(9686003)(55016002)(316002)(8936002)(91956017)(76116006)(66946007)(66616009)(8676002)(81166006)(2906002)(86362001)(52536014)(4326008)(66476007)(81156014)(7696005)(64756008)(186003)(33656002)(71200400001)(26005)(53546011)(66446008)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3664;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w7vznY71orzF2vrJVo4O7pXxJFazm+8yWIaRxopWM2pZcwxBE2GmSYphQFaxkqKdj3RjDXwBCJji2uz/CcE3vDPu8eEHxqeDGWmU5uXSdGGdRkvgUumcXBQVgtKyhneExGRu6K40eNmo9AIOgYsLz3hIfwpUNatzq7/2Zf0YsQW+C+1WKbzry/Nbl04ncHaMEAserTNQWDQv9xCKgj5lVRhx2fOERNgXWozyxW5xU0AgAQnyQeIpV56gUutQmEyyHOo5Sg3L6sYvJmOJ57WYn5y9XZALaUB2iPgXKDmE/WeouOUUKnhnABj3cuJPfewhT2OaMwWY3e4SNRlpU8hEK+kROoBuVNbV5QTbOhouQYyUVs8wPIkuaMMsrZfc/tXhZIzs1bdIr41BDE08/bfs6g5jwSzgQbz4OQdjfgciEKT3etraQiQfjN9t+DTgGW7W
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_002_SN4PR0401MB359865C6D227012D2E71CF5B9B0F0SN4PR0401MB3598_"
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9403f53a-509e-4fa3-9f38-08d7a023a734
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 16:45:28.4818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hupuBH+J5Oa2Rgc4aCFsIF7JVW14eKZqUoJmu7u579RdcBAWnaLoTZ0qazvLDSGdlboj89vOW3yG1VDWoMY70FDqam6FcV8zb1ug6IYvCAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3664
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--_002_SN4PR0401MB359865C6D227012D2E71CF5B9B0F0SN4PR0401MB3598_
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable

On 23/01/2020 15:14, Nikolay Borisov wrote:=0A=
> =0A=
> =0A=
> On 23.01.20 =C7. 10:18 =DE., Johannes Thumshirn wrote:=0A=
> =0A=
> <snip>=0A=
> =0A=
>> @@ -3374,40 +3378,60 @@ static void btrfs_end_buffer_write_sync(struct b=
uffer_head *bh, int uptodate)=0A=
>>   }=0A=
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
>> +	if (!page)=0A=
>> +		return -ENOMEM;=0A=
>> +=0A=
>> +	bio_init(&bio, &bio_vec, 1);=0A=
>> +	bio.bi_iter.bi_sector =3D bytenr >> SECTOR_SHIFT;=0A=
>> +	bio_set_dev(&bio, bdev);=0A=
>> +	bio_set_op_attrs(&bio, REQ_OP_READ, 0);=0A=
>> +	bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE,=0A=
>> +		     offset_in_page(bytenr));=0A=
>> +=0A=
>> +	ret =3D submit_bio_wait(&bio);=0A=
>> +	unlock_page(page);=0A=
> =0A=
> So this is based on my code where the page is unlocked as soon as it's=0A=
> read. However, as per out off-list discussion, I think this page needs=0A=
> to be unlocked once the caller of=0A=
> btrfs_read_dev_one_super/btrfs_read_dev_super is finished with it.=0A=
=0A=
As I don't have an answer to that yet, I just gave it a try (see =0A=
attached diff) and it instantly deadlocks on mount. So either I did =0A=
something wrong or holding the lock until the callers have finished =0A=
processing it is a bad idea.=0A=
=0A=
Thanks,=0A=
	Johannes=0A=

--_002_SN4PR0401MB359865C6D227012D2E71CF5B9B0F0SN4PR0401MB3598_
Content-Type: text/plain; name="disk-io.c.patch"
Content-Description: disk-io.c.patch
Content-Disposition: attachment; filename="disk-io.c.patch"; size=2406;
	creation-date="Thu, 23 Jan 2020 16:45:27 GMT";
	modification-date="Thu, 23 Jan 2020 16:45:27 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2Rpc2staW8uYyBiL2ZzL2J0cmZzL2Rpc2staW8uYwppbmRl
eCBhYzE3NTU3OTM1OTYuLjdhZmFjOTZiZTE3ZiAxMDA2NDQKLS0tIGEvZnMvYnRyZnMvZGlzay1p
by5jCisrKyBiL2ZzL2J0cmZzL2Rpc2staW8uYwpAQCAtMjg1Niw2ICsyODU2LDcgQEAgaW50IF9f
Y29sZCBvcGVuX2N0cmVlKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsCiAJcmV0ID0gYnRyZnNfaW5p
dF9jc3VtX2hhc2goZnNfaW5mbywgY3N1bV90eXBlKTsKIAlpZiAocmV0KSB7CiAJCWVyciA9IHJl
dDsKKwkJdW5sb2NrX3BhZ2Uoc3VwZXJfcGFnZSk7CiAJCWJ0cmZzX3JlbGVhc2VfZGlza19zdXBl
cihzdXBlcl9wYWdlKTsKIAkJZ290byBmYWlsX2FsbG9jOwogCX0KQEAgLTI4NjcsNiArMjg2OCw3
IEBAIGludCBfX2NvbGQgb3Blbl9jdHJlZShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLAogCWlmIChi
dHJmc19jaGVja19zdXBlcl9jc3VtKGZzX2luZm8sIHN1cGVyYmxvY2spKSB7CiAJCWJ0cmZzX2Vy
cihmc19pbmZvLCAic3VwZXJibG9jayBjaGVja3N1bSBtaXNtYXRjaCIpOwogCQllcnIgPSAtRUlO
VkFMOworCQl1bmxvY2tfcGFnZShzdXBlcl9wYWdlKTsKIAkJYnRyZnNfcmVsZWFzZV9kaXNrX3N1
cGVyKHN1cGVyX3BhZ2UpOwogCQlnb3RvIGZhaWxfY3N1bTsKIAl9CkBAIC0yODc3LDYgKzI4Nzks
NyBAQCBpbnQgX19jb2xkIG9wZW5fY3RyZWUoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwKIAkgKiB0
aGUgd2hvbGUgYmxvY2sgb2YgSU5GT19TSVpFCiAJICovCiAJbWVtY3B5KGZzX2luZm8tPnN1cGVy
X2NvcHksIHN1cGVyYmxvY2ssIHNpemVvZigqZnNfaW5mby0+c3VwZXJfY29weSkpOworCXVubG9j
a19wYWdlKHN1cGVyX3BhZ2UpOwogCWJ0cmZzX3JlbGVhc2VfZGlza19zdXBlcihzdXBlcl9wYWdl
KTsKIAogCWRpc2tfc3VwZXIgPSBmc19pbmZvLT5zdXBlcl9jb3B5OwpAQCAtMzQxMyw3ICszNDE2
LDYgQEAgaW50IGJ0cmZzX3JlYWRfZGV2X29uZV9zdXBlcihzdHJ1Y3QgYmxvY2tfZGV2aWNlICpi
ZGV2LCBpbnQgY29weV9udW0sCiAJCSAgICAgb2Zmc2V0X2luX3BhZ2UoYnl0ZW5yKSk7CiAKIAly
ZXQgPSBzdWJtaXRfYmlvX3dhaXQoJmJpbyk7Ci0JdW5sb2NrX3BhZ2UocGFnZSk7CiAJLyoKIAkg
KiBJZiB3ZSBmYWlsIHRvIHJlYWQgZnJvbSB0aGUgdW5kZXJseWluZyBkZXZpY2VzLCBhcyBvZiBu
b3cKIAkgKiB0aGUgYmVzdCBvcHRpb24gd2UgaGF2ZSBpcyB0byBtYXJrIGl0IEVJTy4KQEAgLTM0
MjYsNiArMzQyOCw3IEBAIGludCBidHJmc19yZWFkX2Rldl9vbmVfc3VwZXIoc3RydWN0IGJsb2Nr
X2RldmljZSAqYmRldiwgaW50IGNvcHlfbnVtLAogCXN1cGVyID0ga21hcChwYWdlKTsKIAlpZiAo
YnRyZnNfc3VwZXJfYnl0ZW5yKHN1cGVyKSAhPSBieXRlbnIgfHwKIAkJICAgIGJ0cmZzX3N1cGVy
X21hZ2ljKHN1cGVyKSAhPSBCVFJGU19NQUdJQykgeworCQl1bmxvY2tfcGFnZShwYWdlKTsKIAkJ
YnRyZnNfcmVsZWFzZV9kaXNrX3N1cGVyKHBhZ2UpOwogCQlyZXR1cm4gLUVJTlZBTDsKIAl9CkBA
IC0zNDU3LDExICszNDYwLDE0IEBAIGludCBidHJmc19yZWFkX2Rldl9zdXBlcihzdHJ1Y3QgYmxv
Y2tfZGV2aWNlICpiZGV2LCBzdHJ1Y3QgcGFnZSAqKnBhZ2UpCiAJCXN1cGVyID0ga21hcCgqcGFn
ZSk7CiAKIAkJaWYgKCFsYXRlc3QgfHwgYnRyZnNfc3VwZXJfZ2VuZXJhdGlvbihzdXBlcikgPiB0
cmFuc2lkKSB7Ci0JCQlpZiAobGF0ZXN0KQorCQkJaWYgKGxhdGVzdCkgeworCQkJCXVubG9ja19w
YWdlKGxhdGVzdCk7CiAJCQkJYnRyZnNfcmVsZWFzZV9kaXNrX3N1cGVyKGxhdGVzdCk7CisJCQl9
CiAJCQlsYXRlc3QgPSAqcGFnZTsKIAkJCXRyYW5zaWQgPSBidHJmc19zdXBlcl9nZW5lcmF0aW9u
KHN1cGVyKTsKIAkJfSBlbHNlIHsKKwkJCXVubG9ja19wYWdlKCpwYWdlKTsKIAkJCWJ0cmZzX3Jl
bGVhc2VfZGlza19zdXBlcigqcGFnZSk7CiAJCX0KIApkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvdm9s
dW1lcy5jIGIvZnMvYnRyZnMvdm9sdW1lcy5jCmluZGV4IGY0YTZlZTUxOGYwYy4uOGJiMmY5ZGVh
ZDYzIDEwMDY0NAotLS0gYS9mcy9idHJmcy92b2x1bWVzLmMKKysrIGIvZnMvYnRyZnMvdm9sdW1l
cy5jCkBAIC03MzQ0LDcgKzczNDQsNiBAQCB2b2lkIGJ0cmZzX3NjcmF0Y2hfc3VwZXJibG9ja3Mo
c3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwgY29uc3QgY2hhciAqZGV2aWNlX3BhdAogCQliaW9f
YWRkX3BhZ2UoJmJpbywgcGFnZSwgQlRSRlNfU1VQRVJfSU5GT19TSVpFLAogCQkJICAgICBvZmZz
ZXRfaW5fcGFnZShieXRlbnIpKTsKIAotCQlsb2NrX3BhZ2UocGFnZSk7CiAJCXN1Ym1pdF9iaW9f
d2FpdCgmYmlvKTsKIAkJdW5sb2NrX3BhZ2UocGFnZSk7CiAJCWJ0cmZzX3JlbGVhc2VfZGlza19z
dXBlcihwYWdlKTsK

--_002_SN4PR0401MB359865C6D227012D2E71CF5B9B0F0SN4PR0401MB3598_--

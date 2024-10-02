Return-Path: <linux-btrfs+bounces-8439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E87398E09A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 18:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E510C1F28092
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 16:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519731D0E24;
	Wed,  2 Oct 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eHyeaabN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474641D0DC3
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886236; cv=fail; b=XFUkRQSHjik1muM9Iq/T0HXod8KdYoakSc16OsqyE09wqpvzUwGhx5cCSUJMn3TMOYbUzDZ4B6VZU337v0n0iVj0A1JH8lhOJLWSjLYsRk/5DbyOqNKKFtucQRoxynCuD7FoCBTyHrWhMMRom+1Oyr5BSJ1AjEAfeqe9sT5Ti/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886236; c=relaxed/simple;
	bh=QmNYmOG4uWGzEA1O2opnWyjnhvf4iSlkQT+eDaqYlEU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Q93LleWzbj8agYedZuJ46hFKvnAcupXWmSzZLz/2RZJ4m08Az8ns3XepPRXc461BzrT07bfHOYR3Z0eDDF4ni1F/CgyXhhd/g01sa+aMV2rUtyBGRsDqSWNiXlxtIxF+Gv7QOYyLyUrC7OaylRxIPkmY9OrTgCy7taQp7VXqQHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eHyeaabN; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492GMApN002739
	for <linux-btrfs@vger.kernel.org>; Wed, 2 Oct 2024 09:23:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:references:in-reply-to
	:mime-version:content-type:content-transfer-encoding:content-id;
	 s=s2048-2021-q4; bh=9PtwBWE20xTDxv1s/AavDD2MwIVsqusdiDkegio/Gxg
	=; b=eHyeaabNLd+w6DvzBigjrUx4i5ioX2b2FKG9O9xpbh6yssbBmFkCWB4CRpT
	4zfBYsjwuYpSPWWgzz/zPWY5PB2dwlDge38aUErCMGKecNM8QPSesKm+vinP4lzy
	uQ52VfeBXEPjE22mpV2oPPlatD10QOKqm1M1u9v6nW+N4RO4l6jP7Ob8Nwxt/eVO
	rwXdECNRkeKLcjKszDxIGIUsPyrqdqI+96zORd4fKMuFU2a1GLbXjYz1DUKnZPjz
	aeasaHvFHhGR42nOzrAqoU4/rOkoL3yXsb2OzHECj2MaqxaSisulQLlWdMCNQgIw
	FU2F3cAEsQZzz+edr2YH3bzFokQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4219ms00e2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2024 09:23:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZ/BbV1hcD/YDmBsm1ckQ6mz5RzRDbz8I07XMIaJrBymXWKyKY8cFlwrJInUXN6Fu4EzYU0YLtPXNTQ78EG03W2n9/vDr7vD/1dfB1ZO2SuuxLqNrlfCMXtyqIv7Y1sJONmjfCc5/e6yRZ3/ElJ7/Zw87DjJhlbKFlgIXI9s8XkPm7PhqyO8lTOfeJ1thFSHrTySaHTHvZ14p8TuUkiJzp/qhBKNdfvkthFYxLZxyioQJD32xysLa4TY0hEMBFUY1lUJtqduqxcEkykpR1EUa3yeYQ1T+H8PULiqIdAS7hVzFPzeSWvzHweBeUzsLJfDUv/hBnOwOyjgM/jTP0SCiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzLwCA89s7t8lW8ptcdCdhWiN0uZGjSVzz/SGdplY5s=;
 b=pteM9sLBFty9NmHyF2h4Mfy6V8EoL1F82nyw9I/IlWgzgPHYwfwdDL+HVW7RQE2CIdUE1OUVU1bb+p/VteYCvcPVNj5EVSe7CQlDEsU+bYL4jsrKd1pY7YVfse3/JNzRv1U+ZscZ1CohWQR4NQYTSLtmrpiQMtzjHHmx90B6iYLt6zb6I+I9P/PGt/mJBId5BPniwUCRqEjnQfjdMjsTCw9k+SpEc64vo16YjMP1MNrNNIJT3DuvrSqNE5WqGJJAnM3kwcbonXc3otYzhV6uvcpRvwaL/XszKsRKdh79nf5VAghkUgBOEVcLfE65Gcp1jf3lLR5gwVh3+3awqkLRLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com (2603:10b6:a03:4c0::15)
 by PH0PR15MB4431.namprd15.prod.outlook.com (2603:10b6:510:83::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 16:23:49 +0000
Received: from SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8]) by SJ2PR15MB5669.namprd15.prod.outlook.com
 ([fe80::bff4:aff5:7657:9fe8%4]) with mapi id 15.20.8005.024; Wed, 2 Oct 2024
 16:23:49 +0000
From: Mark Harmstone <maharmstone@meta.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3] btrfs-progs: add rudimentary log checking
Thread-Topic: [PATCH v3] btrfs-progs: add rudimentary log checking
Thread-Index: AQHa1sSspxvgCt+1sES4tNhLmAmP2rJ0C9cAgAAViYA=
Date: Wed, 2 Oct 2024 16:23:49 +0000
Message-ID: <4c742586-3eaf-4301-8a3e-333c3e032f6c@meta.com>
References: <20240715143830.2067478-1-maharmstone@fb.com>
 <CAL3q7H6xfZMa7htN3ebD7RZBYh2uJmcH4JvYcmjXRd6RaKTyug@mail.gmail.com>
In-Reply-To:
 <CAL3q7H6xfZMa7htN3ebD7RZBYh2uJmcH4JvYcmjXRd6RaKTyug@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR15MB5669:EE_|PH0PR15MB4431:EE_
x-ms-office365-filtering-correlation-id: 0a60f993-d32c-4f68-c41f-08dce2fe98e2
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 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
 =?utf-8?B?U3NObjNydkh0M01xeFdUZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR15MB5669.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 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
 =?utf-8?Q?Y09o=3D?=
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR15MB5669.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a60f993-d32c-4f68-c41f-08dce2fe98e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 16:23:49.4253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xmuGCgvbynFkmwdIXejtjEvaf4cd9UA1aqN6NiuVfDyH28Tt0ZeYxEzJWdVg91gPskkQFdvbjxxp29Gz7YVIgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4431
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <32D7FD4B9D4F8146A83E4F146294F2AD@namprd15.prod.outlook.com>
X-Proofpoint-GUID: hoGOeqIDVh5aK-r0iw-2Z2H_kWdYL7c-
X-Proofpoint-ORIG-GUID: hoGOeqIDVh5aK-r0iw-2Z2H_kWdYL7c-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_16,2024-09-30_01,2024-09-30_01

Thanks Filipe, I'll look into it.

Mark

On 2/10/24 16:06, Filipe Manana wrote:
> >=20
> On Mon, Jul 15, 2024 at 3:38=E2=80=AFPM Mark Harmstone <maharmstone@fb.co=
m> wrote:
>>
>> Currently the transaction log is more or less ignored by btrfs check,
>> meaning that it's possible for a FS with a corrupt log to pass btrfs
>> check, but be immediately corrupted by the kernel when it's mounted.
>>
>> This patch adds a check that if there's an inode in the log, any pending
>> non-compressed writes also have corresponding csum entries.
>>
>> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
>> ---
>> Changes:
>> v2:
>> helper to load log root
>> handle compressed extents
>> loop logic improvements
>> fix bug in check_log_csum
>>
>> v3:
>> added test
>> added explanatory comment to check_log_csum
>> changed length operation to -=3D
>>
>>   check/main.c                                  | 304 +++++++++++++++++-
>>   .../063-log-missing-csum/default.img.xz       | Bin 0 -> 1288 bytes
>>   tests/fsck-tests/063-log-missing-csum/test.sh |  14 +
>>   3 files changed, 306 insertions(+), 12 deletions(-)
>>   create mode 100644 tests/fsck-tests/063-log-missing-csum/default.img.xz
>>   create mode 100755 tests/fsck-tests/063-log-missing-csum/test.sh
>>
>> diff --git a/check/main.c b/check/main.c
>> index 83c721d3..eaae3042 100644
>> --- a/check/main.c
>> +++ b/check/main.c
>> @@ -9787,6 +9787,274 @@ static int zero_log_tree(struct btrfs_root *root)
>>          return ret;
>>   }
>>
>> +/* Searches the given root for checksums in the range [addr, addr+lengt=
h].
>> + * Returns 1 if found, 0 if not found, and < 0 for an error. */
>> +static int check_log_csum(struct btrfs_root *root, u64 addr, u64 length)
>> +{
>> +       struct btrfs_path path =3D { 0 };
>> +       struct btrfs_key key;
>> +       struct extent_buffer *leaf;
>> +       u16 csum_size =3D gfs_info->csum_size;
>> +       u16 num_entries;
>> +       u64 data_len;
>> +       int ret;
>> +
>> +       key.objectid =3D BTRFS_EXTENT_CSUM_OBJECTID;
>> +       key.type =3D BTRFS_EXTENT_CSUM_KEY;
>> +       key.offset =3D addr;
>> +
>> +       ret =3D btrfs_search_slot(NULL, root, &key, &path, 0, 0);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       if (ret > 0 && path.slots[0])
>> +               path.slots[0]--;
>> +
>> +       ret =3D 0;
>> +
>> +       while (1) {
>> +               leaf =3D path.nodes[0];
>> +               if (path.slots[0] >=3D btrfs_header_nritems(leaf)) {
>> +                       ret =3D btrfs_next_leaf(root, &path);
>> +                       if (ret) {
>> +                               if (ret > 0)
>> +                                       ret =3D 0;
>> +
>> +                               break;
>> +                       }
>> +                       leaf =3D path.nodes[0];
>> +               }
>> +
>> +               btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
>> +
>> +               if (key.objectid > BTRFS_EXTENT_CSUM_OBJECTID)
>> +                       break;
>> +
>> +               if (key.objectid !=3D BTRFS_EXTENT_CSUM_OBJECTID ||
>> +                   key.type !=3D BTRFS_EXTENT_CSUM_KEY)
>> +                       goto next;
>> +
>> +               if (key.offset >=3D addr + length)
>> +                       break;
>> +
>> +               num_entries =3D btrfs_item_size(leaf, path.slots[0]) / c=
sum_size;
>> +               data_len =3D num_entries * gfs_info->sectorsize;
>> +
>> +               if (addr >=3D key.offset && addr <=3D key.offset + data_=
len) {
>> +                       u64 end =3D min(addr + length, key.offset + data=
_len);
>> +
>> +                       length -=3D (end - addr);
>> +                       addr =3D end;
>> +
>> +                       if (length =3D=3D 0)
>> +                               break;
>> +               }
>> +
>> +next:
>> +               path.slots[0]++;
>> +       }
>> +
>> +       btrfs_release_path(&path);
>> +
>> +       if (ret >=3D 0)
>> +               ret =3D length =3D=3D 0 ? 1 : 0;
>> +
>> +       return ret;
>> +}
>> +
>> +static int check_log_root(struct btrfs_root *root, struct cache_tree *r=
oot_cache,
>> +                         struct walk_control *wc)
>> +{
>> +       struct btrfs_path path =3D { 0 };
>> +       struct btrfs_key key;
>> +       struct extent_buffer *leaf;
>> +       int ret, err =3D 0;
>> +       u64 last_csum_inode =3D 0;
>> +
>> +       key.objectid =3D BTRFS_FIRST_FREE_OBJECTID;
>> +       key.type =3D BTRFS_INODE_ITEM_KEY;
>> +       key.offset =3D 0;
>> +       ret =3D btrfs_search_slot(NULL, root, &key, &path, 0, 0);
>> +       if (ret < 0)
>> +               return 1;
>> +
>> +       while (1) {
>> +               leaf =3D path.nodes[0];
>> +               if (path.slots[0] >=3D btrfs_header_nritems(leaf)) {
>> +                       ret =3D btrfs_next_leaf(root, &path);
>> +                       if (ret) {
>> +                               if (ret < 0)
>> +                                       err =3D 1;
>> +
>> +                               break;
>> +                       }
>> +                       leaf =3D path.nodes[0];
>> +               }
>> +               btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
>> +
>> +               if (key.objectid =3D=3D BTRFS_EXTENT_CSUM_OBJECTID)
>> +                       break;
>> +
>> +               if (key.type =3D=3D BTRFS_INODE_ITEM_KEY) {
>> +                       struct btrfs_inode_item *item;
>> +
>> +                       item =3D btrfs_item_ptr(leaf, path.slots[0],
>> +                                             struct btrfs_inode_item);
>> +
>> +                       if (!(btrfs_inode_flags(leaf, item) & BTRFS_INOD=
E_NODATASUM))
>> +                               last_csum_inode =3D key.objectid;
>> +               } else if (key.type =3D=3D BTRFS_EXTENT_DATA_KEY &&
>> +                          key.objectid =3D=3D last_csum_inode) {
>> +                       struct btrfs_file_extent_item *fi;
>> +                       u64 addr, length;
>> +
>> +                       fi =3D btrfs_item_ptr(leaf, path.slots[0],
>> +                                           struct btrfs_file_extent_ite=
m);
>> +
>> +                       if (btrfs_file_extent_type(leaf, fi) !=3D BTRFS_=
FILE_EXTENT_REG)
>> +                               goto next;
>> +
>> +                       addr =3D btrfs_file_extent_disk_bytenr(leaf, fi)=
 +
>> +                               btrfs_file_extent_offset(leaf, fi);
>> +                       length =3D btrfs_file_extent_num_bytes(leaf, fi);
>> +
>> +                       ret =3D check_log_csum(root, addr, length);
>> +                       if (ret < 0) {
>> +                               err =3D 1;
>> +                               break;
>> +                       }
>> +
>> +                       if (!ret) {
>> +                               error("csum missing in log (root %llu, i=
node %llu, "
>> +                                     "offset %llu, address 0x%llx, leng=
th %llu)",
>> +                                     root->objectid, last_csum_inode, k=
ey.offset,
>> +                                     addr, length);
>=20
> This is causing some false failures when running fstests, like test
> btrfs/056 for example.
> There it's attempting to lookup csums for file extents representing
> holes (disk_bytenr =3D=3D 0), which don't exist.
>=20
> Also this change assumes that for every file extent item we must have
> a csum item logged, which is not always the case.
> For example, before the following kernel commit:
>=20
> commit 7f30c07288bb9e20463182d0db56416025f85e08
> Author: Filipe Manana <fdmanana@suse.com>
> Date:   Thu Feb 17 12:12:03 2022 +0000
>=20
>      btrfs: stop copying old file extents when doing a full fsync
>=20
> We could log old file extent items, from past transactions, but
> because they were from past transactions, we didn't log the csums
> because they aren't needed.
>=20
> So on older kernels that triggers a false alarm too.
>=20
> Thanks.
>=20
>> +                               err =3D 1;
>> +                       }
>> +               }
>> +
>> +next:
>> +               path.slots[0]++;
>> +       }
>> +
>> +       btrfs_release_path(&path);
>> +
>> +       return err;
>> +}
>> +
>> +static int load_log_root(u64 root_id, struct btrfs_path *path,
>> +                        struct btrfs_root *tmp_root)
>> +{
>> +       struct extent_buffer *l;
>> +       struct btrfs_tree_parent_check check =3D { 0 };
>> +
>> +       btrfs_setup_root(tmp_root, gfs_info, root_id);
>> +
>> +       l =3D path->nodes[0];
>> +       read_extent_buffer(l, &tmp_root->root_item,
>> +                       btrfs_item_ptr_offset(l, path->slots[0]),
>> +                       sizeof(tmp_root->root_item));
>> +
>> +       tmp_root->root_key.objectid =3D root_id;
>> +       tmp_root->root_key.type =3D BTRFS_ROOT_ITEM_KEY;
>> +       tmp_root->root_key.offset =3D 0;
>> +
>> +       check.owner_root =3D btrfs_root_id(tmp_root);
>> +       check.transid =3D btrfs_root_generation(&tmp_root->root_item);
>> +       check.level =3D btrfs_root_level(&tmp_root->root_item);
>> +
>> +       tmp_root->node =3D read_tree_block(gfs_info,
>> +                                        btrfs_root_bytenr(&tmp_root->ro=
ot_item),
>> +                                        &check);
>> +       if (IS_ERR(tmp_root->node)) {
>> +               tmp_root->node =3D NULL;
>> +               return 1;
>> +       }
>> +
>> +       if (btrfs_header_level(tmp_root->node) !=3D btrfs_root_level(&tm=
p_root->root_item)) {
>> +               error("root [%llu %llu] level %d does not match %d",
>> +                       tmp_root->root_key.objectid,
>> +                       tmp_root->root_key.offset,
>> +                       btrfs_header_level(tmp_root->node),
>> +                       btrfs_root_level(&tmp_root->root_item));
>> +               return 1;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int check_log(struct cache_tree *root_cache)
>> +{
>> +       struct btrfs_path path =3D { 0 };
>> +       struct walk_control wc =3D { 0 };
>> +       struct btrfs_key key;
>> +       struct extent_buffer *leaf;
>> +       struct btrfs_root *log_root =3D gfs_info->log_root_tree;
>> +       int ret;
>> +       int err =3D 0;
>> +
>> +       cache_tree_init(&wc.shared);
>> +
>> +       key.objectid =3D BTRFS_TREE_LOG_OBJECTID;
>> +       key.type =3D BTRFS_ROOT_ITEM_KEY;
>> +       key.offset =3D 0;
>> +       ret =3D btrfs_search_slot(NULL, log_root, &key, &path, 0, 0);
>> +       if (ret < 0) {
>> +               err =3D 1;
>> +               goto out;
>> +       }
>> +
>> +       while (1) {
>> +               leaf =3D path.nodes[0];
>> +               if (path.slots[0] >=3D btrfs_header_nritems(leaf)) {
>> +                       ret =3D btrfs_next_leaf(log_root, &path);
>> +                       if (ret) {
>> +                               if (ret < 0)
>> +                                       err =3D 1;
>> +                               break;
>> +                       }
>> +                       leaf =3D path.nodes[0];
>> +               }
>> +               btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
>> +
>> +               if (key.objectid > BTRFS_TREE_LOG_OBJECTID ||
>> +                   key.type > BTRFS_ROOT_ITEM_KEY)
>> +                       break;
>> +
>> +               if (key.objectid =3D=3D BTRFS_TREE_LOG_OBJECTID &&
>> +                   key.type =3D=3D BTRFS_ROOT_ITEM_KEY &&
>> +                   fs_root_objectid(key.offset)) {
>> +                       struct btrfs_root tmp_root;
>> +
>> +                       memset(&tmp_root, 0, sizeof(tmp_root));
>> +
>> +                       ret =3D load_log_root(key.offset, &path, &tmp_ro=
ot);
>> +                       if (ret) {
>> +                               err =3D 1;
>> +                               goto next;
>> +                       }
>> +
>> +                       ret =3D check_log_root(&tmp_root, root_cache, &w=
c);
>> +                       if (ret)
>> +                               err =3D 1;
>> +
>> +next:
>> +                       if (tmp_root.node)
>> +                               free_extent_buffer(tmp_root.node);
>> +               }
>> +
>> +               path.slots[0]++;
>> +       }
>> +out:
>> +       btrfs_release_path(&path);
>> +       if (err)
>> +               free_extent_cache_tree(&wc.shared);
>> +       if (!cache_tree_empty(&wc.shared))
>> +               fprintf(stderr, "warning line %d\n", __LINE__);
>> +
>> +       return err;
>> +}
>> +
>>   static void free_roots_info_cache(void)
>>   {
>>          if (!roots_info_cache)
>> @@ -10585,9 +10853,21 @@ static int cmd_check(const struct cmd_struct *c=
md, int argc, char **argv)
>>                  goto close_out;
>>          }
>>
>> +       if (gfs_info->log_root_tree) {
>> +               fprintf(stderr, "[1/8] checking log\n");
>> +               ret =3D check_log(&root_cache);
>> +
>> +               if (ret)
>> +                       error("errors found in log");
>> +               err |=3D !!ret;
>> +       } else {
>> +               fprintf(stderr,
>> +               "[1/8] checking log skipped (none written)\n");
>> +       }
>> +
>>          if (!init_extent_tree) {
>>                  if (!g_task_ctx.progress_enabled) {
>> -                       fprintf(stderr, "[1/7] checking root items\n");
>> +                       fprintf(stderr, "[2/8] checking root items\n");
>>                  } else {
>>                          g_task_ctx.tp =3D TASK_ROOT_ITEMS;
>>                          task_start(g_task_ctx.info, &g_task_ctx.start_t=
ime,
>> @@ -10622,11 +10902,11 @@ static int cmd_check(const struct cmd_struct *=
cmd, int argc, char **argv)
>>                          }
>>                  }
>>          } else {
>> -               fprintf(stderr, "[1/7] checking root items... skipped\n"=
);
>> +               fprintf(stderr, "[2/8] checking root items... skipped\n"=
);
>>          }
>>
>>          if (!g_task_ctx.progress_enabled) {
>> -               fprintf(stderr, "[2/7] checking extents\n");
>> +               fprintf(stderr, "[3/8] checking extents\n");
>>          } else {
>>                  g_task_ctx.tp =3D TASK_EXTENTS;
>>                  task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_=
task_ctx.item_count);
>> @@ -10644,9 +10924,9 @@ static int cmd_check(const struct cmd_struct *cm=
d, int argc, char **argv)
>>
>>          if (!g_task_ctx.progress_enabled) {
>>                  if (is_free_space_tree)
>> -                       fprintf(stderr, "[3/7] checking free space tree\=
n");
>> +                       fprintf(stderr, "[4/8] checking free space tree\=
n");
>>                  else
>> -                       fprintf(stderr, "[3/7] checking free space cache=
\n");
>> +                       fprintf(stderr, "[4/8] checking free space cache=
\n");
>>          } else {
>>                  g_task_ctx.tp =3D TASK_FREE_SPACE;
>>                  task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_=
task_ctx.item_count);
>> @@ -10664,7 +10944,7 @@ static int cmd_check(const struct cmd_struct *cm=
d, int argc, char **argv)
>>           */
>>          no_holes =3D btrfs_fs_incompat(gfs_info, NO_HOLES);
>>          if (!g_task_ctx.progress_enabled) {
>> -               fprintf(stderr, "[4/7] checking fs roots\n");
>> +               fprintf(stderr, "[5/8] checking fs roots\n");
>>          } else {
>>                  g_task_ctx.tp =3D TASK_FS_ROOTS;
>>                  task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_=
task_ctx.item_count);
>> @@ -10680,10 +10960,10 @@ static int cmd_check(const struct cmd_struct *=
cmd, int argc, char **argv)
>>
>>          if (!g_task_ctx.progress_enabled) {
>>                  if (check_data_csum)
>> -                       fprintf(stderr, "[5/7] checking csums against da=
ta\n");
>> +                       fprintf(stderr, "[6/8] checking csums against da=
ta\n");
>>                  else
>>                          fprintf(stderr,
>> -               "[5/7] checking only csums items (without verifying data=
)\n");
>> +               "[6/8] checking only csums items (without verifying data=
)\n");
>>          } else {
>>                  g_task_ctx.tp =3D TASK_CSUMS;
>>                  task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_=
task_ctx.item_count);
>> @@ -10702,7 +10982,7 @@ static int cmd_check(const struct cmd_struct *cm=
d, int argc, char **argv)
>>          /* For low memory mode, check_fs_roots_v2 handles root refs */
>>           if (check_mode !=3D CHECK_MODE_LOWMEM) {
>>                  if (!g_task_ctx.progress_enabled) {
>> -                       fprintf(stderr, "[6/7] checking root refs\n");
>> +                       fprintf(stderr, "[7/8] checking root refs\n");
>>                  } else {
>>                          g_task_ctx.tp =3D TASK_ROOT_REFS;
>>                          task_start(g_task_ctx.info, &g_task_ctx.start_t=
ime, &g_task_ctx.item_count);
>> @@ -10717,7 +10997,7 @@ static int cmd_check(const struct cmd_struct *cm=
d, int argc, char **argv)
>>                  }
>>          } else {
>>                  fprintf(stderr,
>> -       "[6/7] checking root refs done with fs roots in lowmem mode, ski=
pping\n");
>> +       "[7/8] checking root refs done with fs roots in lowmem mode, ski=
pping\n");
>>          }
>>
>>          while (opt_check_repair && !list_empty(&gfs_info->recow_ebs)) {
>> @@ -10749,7 +11029,7 @@ static int cmd_check(const struct cmd_struct *cm=
d, int argc, char **argv)
>>
>>          if (gfs_info->quota_enabled) {
>>                  if (!g_task_ctx.progress_enabled) {
>> -                       fprintf(stderr, "[7/7] checking quota groups\n");
>> +                       fprintf(stderr, "[8/8] checking quota groups\n");
>>                  } else {
>>                          g_task_ctx.tp =3D TASK_QGROUPS;
>>                          task_start(g_task_ctx.info, &g_task_ctx.start_t=
ime, &g_task_ctx.item_count);
>> @@ -10772,7 +11052,7 @@ static int cmd_check(const struct cmd_struct *cm=
d, int argc, char **argv)
>>                  ret =3D 0;
>>          } else {
>>                  fprintf(stderr,
>> -               "[7/7] checking quota groups skipped (not enabled on thi=
s FS)\n");
>> +               "[8/8] checking quota groups skipped (not enabled on thi=
s FS)\n");
>>          }
>>
>>          if (!list_empty(&gfs_info->recow_ebs)) {
>> diff --git a/tests/fsck-tests/063-log-missing-csum/default.img.xz b/test=
s/fsck-tests/063-log-missing-csum/default.img.xz
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..c9b4f420ac23866cd142428d=
af21739efda0762d
>> GIT binary patch
>> literal 1288
>> zcmV+j1^4>>H+ooF000E$*0e?f03iVu0001VFXf}+)Bgm;T>wRyj;C3^v%$$4d1wo3
>> zjjaF1$8Jv*pMMm%#Ch6IM%}7&=3D@^TvKIIdYjZ@t7T($M|Hz%Cr>ZwJ6sj_bRsY^a*
>> zIr#q#U>$p<Go1bOhu5#Q<?@08{(UO6n<sqYIY$<RXz3}#&sBuS|AUrsgQ{%?z1>tr
>> zW^k~hR~HJs$P?zuw_V+%>i2AU4x-C~^RmH%0#2o7VY;D>d@D<+CC=3DJ4l?Bs2d@5yC
>> z&pKh_V}nG$A*f{hGHlfKeT*E3NA1Q(Nt;TxvV6m2A_RVpD=3D`*t<8b6_KTom1S=3D|eG
>> z>OMhPCcl7*3tYx)YhtFm-3)~e_SPBasmqw|$jnE_-QZfatuNh^bkJ5yW{ZX7NmD)i
>> zLKCQYs5y!To5G>tIYzSNigXu|<l&x%JzxMA5aW-t+nod|B!efqr+_#STUo@Xu>wY=3D
>> z*;zh8-nLPC+GYq6HU^A<Qjkh41{(MMB=3Dp?8i7|;p<cL9o>Q7;56uclyq=3DuCMb1GmZ
>> zuq5@iwv1^<TQdlj9#Xdq$Vj!1d~GO$P#HmKmPt*t2iPme{8~y6{{T++2nv+X7)Fnf
>> z`$pgevh)w!LR&hx2a|{sW@ac43(Sl>??<SGJB`t-nDXvSDSY*87<ziAenKb9p4UlP
>> z*(x(s)OBgD_f*R-*yBUaiD3U<uhy+{P{T&x@o^!9gXa@=3DKts_p@u`Tb)rQcu{)tzQ
>> zhCXcu`CGkyKuQRy(M0c#fPDWJwyhC`w2mizWqVSf=3D=3DSk-nywG!nJzNT5aM0tVb}Va
>> zK?^BQbY*CPLeJtG``VF4F@BVWBpSVWDFk`J!cOhagXH=3DGB1GApQ?zsg8%y=3DJ$Fgl1
>> z)+=3DjFc)g}pALW^HG}wkoY7fOfbZ274b~+dEoA?l%Xzz`P-F)vb1^UziIz|no!02bS
>> zWPfo?`TiKe8aIuiPilXte381GZ4tQc6=3DY*KS0rehLE^7!W+MOr0AEFmQgw<KSH}Ix
>> ze4qlov3aIg5e(Oh1%CwTZN^`UI!7g(U;iDFt(>e4XDB-M)l0stJd3pf<XujqB2}MW
>> z6EY1#$l>s;T1IYy#{A9ljl@Ba_*dh)Qfq@8Y1A#q%p|d;USrIAZ*n1`%ho*!-RYOY
>> z4j%X?D?CoiaW8A*7aue82GA9jmMGg6Bv&mO#v6uKVw1V~Uu01wXbz(RJN_|xw{`8K
>> zSfdyQCJOdIwdN%h+Jr{$9!6otgQ8^`lkU4u;5wJlsy#P<D{Nc39m@=3D*OHZ533tvD<
>> zfb=3Dc>-IWOj%>%mQ@Ja!#!QIOVuluA}ecSFg;*v@<bR@g*YX>1-?kl9WGes{ulrRWq
>> zTCW@Om{iybhK+m8SiS%n^)Kgk21T`IEW#){Czvz;Fix;5bdkB$BFXimx9iBaRZ9r=3D
>> zV(H0OD8mK94(j^6gF8)|^i-78H`hR#ebBvFq}>vK6-ni7j1S>*viG^nA7<~Bn2KW0
>> zw%D36qxTcpO;c2bYwf)K?p#^LFL4Ifq8?kP?#;(Jo8*(twFPRBj*u~h%Ej$X6JI2E
>> z<L5)YZY#@aM-2sxodox#)=3DG1ycE6A6j?am&HLbKPv@FI{(HAJ#D*V@xG^U`bnRtH<
>> y%w+Y9$G2sBKv@6)0000tuOhH&%TnS10pSUNs0#q29h=3DIr#Ao{g000001X)@}7Iu~Z
>>
>> literal 0
>> HcmV?d00001
>>
>> diff --git a/tests/fsck-tests/063-log-missing-csum/test.sh b/tests/fsck-=
tests/063-log-missing-csum/test.sh
>> new file mode 100755
>> index 00000000..40a48508
>> --- /dev/null
>> +++ b/tests/fsck-tests/063-log-missing-csum/test.sh
>> @@ -0,0 +1,14 @@
>> +#!/bin/bash
>> +#
>> +# Verify that check can detect missing log csum items.
>> +
>> +source "$TEST_TOP/common" || exit
>> +
>> +check_prereq btrfs
>> +
>> +check_image() {
>> +       run_mustfail "missing log csum items not detected" \
>> +               "$TOP/btrfs" check "$1"
>> +}
>> +
>> +check_all_images
>> --
>> 2.45.2
>>
>>



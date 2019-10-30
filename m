Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77111E95E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 06:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfJ3FRn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Oct 2019 01:17:43 -0400
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:51616 "EHLO
        m4a0041g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbfJ3FRn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Oct 2019 01:17:43 -0400
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.147) BY m4a0041g.houston.softwaregrp.com WITH ESMTP;
 Wed, 30 Oct 2019 05:16:44 +0000
Received: from M4W0335.microfocus.com (2002:f78:1193::f78:1193) by
 M4W0335.microfocus.com (2002:f78:1193::f78:1193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 30 Oct 2019 04:59:26 +0000
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (15.124.8.10) by
 M4W0335.microfocus.com (15.120.17.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 30 Oct 2019 04:59:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VK5UnyD90TzwUlQHG5KulaB/wJ49AS+ACDa9gKNqkWJo0/Lndp9mc0fc8CHh7tyfEO/Jv3CmenpwokGbGz20jHziSvA7bu4J36jyoJlhiIdKLhIyS2N9mxCCL63sy9b+oGDEMKQxja52ld7Hl2QKikof8u0FIRSw5imFrhKQRxRmC03UDF+KTm9l5wm3YkkmL8+lp2xSkPQ1M6+LNza8h2njCg6JDHZu9C55wbMqD8wR+xIEATcBVVW5nzZUpBdjZTiBPVRO82Unxzh3OJ7pH/iKPBpjK9f+TDTOITVW/x6VlEy3xx697eU66XV9WtkF2C2R5fYQuwlIvwdNLedIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZbNEjbKadyI1qi0MzNBeaTMLfCmKkZQLbz4QJRoJa+Y=;
 b=XYzxlZXesGOemILQZVOqHyf5vMlu+RgpSyqSfL5weqEIAFXDVOa317CNcUCubFxoi1aNIEcoh0bBaAxsWnUSbHr6F49jnhEbcB2Ke+WVX3sgVgCqa/dWiSl8evsvHcJ3dQ+A04dnHxuYNKl8Iu9HbAkulHoC+I7CcFfiDeCxmm7PlJjgAxmdiLz+36SBIHqkW4Wmg25QIId27YHoxTMtWItql7BKxdhfR5dBZEEkJ/cPrYaLwCK+CdDI9zKedvMOiJJDKSJFCvz8Xc8druE9r1R2ajIjWKX/YwUslRPSMUu3p4wnHaSc4RoQpow3U09VipnB+AWD/AY/DjBKiHS9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3235.namprd18.prod.outlook.com (10.255.136.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Wed, 30 Oct 2019 04:59:18 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::5c5:8dae:70ef:a254]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::5c5:8dae:70ef:a254%4]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 04:59:18 +0000
From:   Qu WenRuo <wqu@suse.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Johannes Thumshirn <jthumshirn@suse.de>,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3 2/3] btrfs: block-group: Refactor
 btrfs_read_block_groups()
Thread-Topic: [PATCH v3 2/3] btrfs: block-group: Refactor
 btrfs_read_block_groups()
Thread-Index: AQHVjt7HZQL0OeXcO0OfmoT1bxccMw==
Date:   Wed, 30 Oct 2019 04:59:17 +0000
Message-ID: <c1f08098-5f90-70c5-6554-9a9cf33e87be@suse.com>
References: <20191010023928.24586-1-wqu@suse.com>
 <20191010023928.24586-3-wqu@suse.com>
In-Reply-To: <20191010023928.24586-3-wqu@suse.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR01CA0067.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::31) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [13.231.109.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64cc52c8-98cd-4f2e-693d-08d75cf5ea13
x-ms-traffictypediagnostic: BY5PR18MB3235:
x-microsoft-antispam-prvs: <BY5PR18MB3235B3856154F659DB25504ED6600@BY5PR18MB3235.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(189003)(199004)(64756008)(31686004)(305945005)(66616009)(71200400001)(2351001)(66446008)(66476007)(478600001)(71190400001)(8676002)(81156014)(7736002)(102836004)(66556008)(6436002)(81166006)(99936001)(3846002)(6486002)(8936002)(5660300002)(25786009)(66066001)(52116002)(76176011)(6116002)(229853002)(386003)(6916009)(6506007)(99286004)(86362001)(5640700003)(256004)(14444005)(316002)(36756003)(6246003)(2906002)(476003)(31696002)(54906003)(186003)(14454004)(2501003)(446003)(66946007)(2616005)(11346002)(486006)(6512007)(4326008)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3235;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GTeWdHkHdJmgsHD9xEVGENALifP1VGlUCjewsYYrWbvoMpY2sSxVcH2GWZmRlb6rQi/tlKAk+cG4+VSdcRRO5HNkO66jonq9d0RWpm59Vjm8Lh2WkPIIMXHGVwWxRN91t9XsYEhz8qwklyC4PiXTN2srDAFX0WgRS2obI4xccfQgmsl3NNg3GtIpbfPhaC1vssX/cqproAdrqzgZYfWGQllELL15WNEpoeyWZroklau223Qs0uIRNPhMG0uIN6lEkIzpXAe/nfAspKjxXfZHFB1tCvbC+tNcrH9Zv4y7vnsC8UwMg8qtzXwPIkw2JR1m+bGVt0uRWfiPq9VMwty9z3lf/4TJNlz3MxiTU1s69Nfk3qjXyw9970shVXBfJP3Qc1EYY2ULpD6NQmuMEU2AEkyegylsIj7IvbZ1R6tmcyfuevwy4CPaP+NRZz2GSGJj
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="bqkvOhihuCR0n76ksIrKFqmHQqTb1xTfR"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 64cc52c8-98cd-4f2e-693d-08d75cf5ea13
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 04:59:17.6668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iU4+7XfSmRW17Jogx782GY1n8xyzb8sMB0u6Ygh0XZZlLy80WOg7aJ+jGXaLbp7L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3235
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--bqkvOhihuCR0n76ksIrKFqmHQqTb1xTfR
Content-Type: multipart/mixed; boundary="ZYezXOXolj6E4qWRUIa6RMOEo4pOrDmxl"

--ZYezXOXolj6E4qWRUIa6RMOEo4pOrDmxl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2019/10/10 =E4=B8=8A=E5=8D=8810:39, Qu Wenruo wrote:
> Refactor the work inside the loop of btrfs_read_block_groups() into one=

> separate function, read_one_block_group().
>=20
> This allows read_one_block_group to be reused for later BG_TREE feature=
=2E
>=20
> The refactor does the following extra fix:
> - Use btrfs_fs_incompat() to replace open-coded feature check
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>

Hi David,

Mind to add this patch to for-next branch?

Considering the recent changes to struct btrfs_block_group_cache, there
is some considerable conflicts.

It would be much easier to solve them sooner than later.
If needed I could send a newer version based on latest for-next branch.

Thanks,
Qu

> ---
>  fs/btrfs/block-group.c | 215 +++++++++++++++++++++--------------------=

>  1 file changed, 108 insertions(+), 107 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index c906a2b6c2cf..0c5eef0610fa 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1687,6 +1687,109 @@ static int check_chunk_block_group_mappings(str=
uct btrfs_fs_info *fs_info)
>  	return ret;
>  }
> =20
> +static int read_one_block_group(struct btrfs_fs_info *info,
> +				struct btrfs_path *path,
> +				int need_clear)
> +{
> +	struct extent_buffer *leaf =3D path->nodes[0];
> +	struct btrfs_block_group_cache *cache;
> +	struct btrfs_space_info *space_info;
> +	struct btrfs_key key;
> +	int mixed =3D btrfs_fs_incompat(info, MIXED_GROUPS);
> +	int slot =3D path->slots[0];
> +	int ret;
> +
> +	btrfs_item_key_to_cpu(leaf, &key, slot);
> +	ASSERT(key.type =3D=3D BTRFS_BLOCK_GROUP_ITEM_KEY);
> +
> +	cache =3D btrfs_create_block_group_cache(info, key.objectid,
> +					       key.offset);
> +	if (!cache)
> +		return -ENOMEM;
> +
> +	if (need_clear) {
> +		/*
> +		 * When we mount with old space cache, we need to
> +		 * set BTRFS_DC_CLEAR and set dirty flag.
> +		 *
> +		 * a) Setting 'BTRFS_DC_CLEAR' makes sure that we
> +		 *    truncate the old free space cache inode and
> +		 *    setup a new one.
> +		 * b) Setting 'dirty flag' makes sure that we flush
> +		 *    the new space cache info onto disk.
> +		 */
> +		if (btrfs_test_opt(info, SPACE_CACHE))
> +			cache->disk_cache_state =3D BTRFS_DC_CLEAR;
> +	}
> +	read_extent_buffer(leaf, &cache->item,
> +			   btrfs_item_ptr_offset(leaf, slot),
> +			   sizeof(cache->item));
> +	cache->flags =3D btrfs_block_group_flags(&cache->item);
> +	if (!mixed && ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
> +	    (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
> +			btrfs_err(info,
> +"bg %llu is a mixed block group but filesystem hasn't enabled mixed bl=
ock groups",
> +				  cache->key.objectid);
> +			ret =3D -EINVAL;
> +			goto error;
> +	}
> +
> +	/*
> +	 * We need to exclude the super stripes now so that the space info ha=
s
> +	 * super bytes accounted for, otherwise we'll think we have more spac=
e
> +	 * than we actually do.
> +	 */
> +	ret =3D exclude_super_stripes(cache);
> +	if (ret) {
> +		/* We may have excluded something, so call this just in case. */
> +		btrfs_free_excluded_extents(cache);
> +		goto error;
> +	}
> +
> +	/*
> +	 * Check for two cases, either we are full, and therefore don't need
> +	 * to bother with the caching work since we won't find any space, or =
we
> +	 * are empty, and we can just add all the space in and be done with i=
t.
> +	 * This saves us _a_lot_ of time, particularly in the full case.
> +	 */
> +	if (key.offset =3D=3D btrfs_block_group_used(&cache->item)) {
> +		cache->last_byte_to_unpin =3D (u64)-1;
> +		cache->cached =3D BTRFS_CACHE_FINISHED;
> +		btrfs_free_excluded_extents(cache);
> +	} else if (btrfs_block_group_used(&cache->item) =3D=3D 0) {
> +		cache->last_byte_to_unpin =3D (u64)-1;
> +		cache->cached =3D BTRFS_CACHE_FINISHED;
> +		add_new_free_space(cache, key.objectid,
> +				   key.objectid + key.offset);
> +		btrfs_free_excluded_extents(cache);
> +	}
> +	ret =3D btrfs_add_block_group_cache(info, cache);
> +	if (ret) {
> +		btrfs_remove_free_space_cache(cache);
> +		goto error;
> +	}
> +	trace_btrfs_add_block_group(info, cache, 0);
> +	btrfs_update_space_info(info, cache->flags, key.offset,
> +				btrfs_block_group_used(&cache->item),
> +				cache->bytes_super, &space_info);
> +
> +	cache->space_info =3D space_info;
> +
> +	link_block_group(cache);
> +
> +	set_avail_alloc_bits(info, cache->flags);
> +	if (btrfs_chunk_readonly(info, cache->key.objectid)) {
> +		inc_block_group_ro(cache, 1);
> +	} else if (btrfs_block_group_used(&cache->item) =3D=3D 0) {
> +		ASSERT(list_empty(&cache->bg_list));
> +		btrfs_mark_bg_unused(cache);
> +	}
> +	return 0;
> +error:
> +	btrfs_put_block_group(cache);
> +	return ret;
> +}
> +
>  int btrfs_read_block_groups(struct btrfs_fs_info *info)
>  {
>  	struct btrfs_path *path;
> @@ -1694,15 +1797,8 @@ int btrfs_read_block_groups(struct btrfs_fs_info=
 *info)
>  	struct btrfs_block_group_cache *cache;
>  	struct btrfs_space_info *space_info;
>  	struct btrfs_key key;
> -	struct btrfs_key found_key;
> -	struct extent_buffer *leaf;
>  	int need_clear =3D 0;
>  	u64 cache_gen;
> -	u64 feature;
> -	int mixed;
> -
> -	feature =3D btrfs_super_incompat_flags(info->super_copy);
> -	mixed =3D !!(feature & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS);
> =20
>  	key.objectid =3D 0;
>  	key.offset =3D 0;
> @@ -1726,108 +1822,13 @@ int btrfs_read_block_groups(struct btrfs_fs_in=
fo *info)
>  		if (ret !=3D 0)
>  			goto error;
> =20
> -		leaf =3D path->nodes[0];
> -		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> -
> -		cache =3D btrfs_create_block_group_cache(info, found_key.objectid,
> -						       found_key.offset);
> -		if (!cache) {
> -			ret =3D -ENOMEM;
> -			goto error;
> -		}
> -
> -		if (need_clear) {
> -			/*
> -			 * When we mount with old space cache, we need to
> -			 * set BTRFS_DC_CLEAR and set dirty flag.
> -			 *
> -			 * a) Setting 'BTRFS_DC_CLEAR' makes sure that we
> -			 *    truncate the old free space cache inode and
> -			 *    setup a new one.
> -			 * b) Setting 'dirty flag' makes sure that we flush
> -			 *    the new space cache info onto disk.
> -			 */
> -			if (btrfs_test_opt(info, SPACE_CACHE))
> -				cache->disk_cache_state =3D BTRFS_DC_CLEAR;
> -		}
> -
> -		read_extent_buffer(leaf, &cache->item,
> -				   btrfs_item_ptr_offset(leaf, path->slots[0]),
> -				   sizeof(cache->item));
> -		cache->flags =3D btrfs_block_group_flags(&cache->item);
> -		if (!mixed &&
> -		    ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
> -		    (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
> -			btrfs_err(info,
> -"bg %llu is a mixed block group but filesystem hasn't enabled mixed bl=
ock groups",
> -				  cache->key.objectid);
> -			ret =3D -EINVAL;
> -			btrfs_put_block_group(cache);
> +		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
> +		ret =3D read_one_block_group(info, path, need_clear);
> +		if (ret < 0)
>  			goto error;
> -		}
> -
> -		key.objectid =3D found_key.objectid + found_key.offset;
> +		key.objectid +=3D key.offset;
> +		key.offset =3D 0;
>  		btrfs_release_path(path);
> -
> -		/*
> -		 * We need to exclude the super stripes now so that the space
> -		 * info has super bytes accounted for, otherwise we'll think
> -		 * we have more space than we actually do.
> -		 */
> -		ret =3D exclude_super_stripes(cache);
> -		if (ret) {
> -			/*
> -			 * We may have excluded something, so call this just in
> -			 * case.
> -			 */
> -			btrfs_free_excluded_extents(cache);
> -			btrfs_put_block_group(cache);
> -			goto error;
> -		}
> -
> -		/*
> -		 * Check for two cases, either we are full, and therefore
> -		 * don't need to bother with the caching work since we won't
> -		 * find any space, or we are empty, and we can just add all
> -		 * the space in and be done with it.  This saves us _a_lot_ of
> -		 * time, particularly in the full case.
> -		 */
> -		if (found_key.offset =3D=3D btrfs_block_group_used(&cache->item)) {
> -			cache->last_byte_to_unpin =3D (u64)-1;
> -			cache->cached =3D BTRFS_CACHE_FINISHED;
> -			btrfs_free_excluded_extents(cache);
> -		} else if (btrfs_block_group_used(&cache->item) =3D=3D 0) {
> -			cache->last_byte_to_unpin =3D (u64)-1;
> -			cache->cached =3D BTRFS_CACHE_FINISHED;
> -			add_new_free_space(cache, found_key.objectid,
> -					   found_key.objectid +
> -					   found_key.offset);
> -			btrfs_free_excluded_extents(cache);
> -		}
> -
> -		ret =3D btrfs_add_block_group_cache(info, cache);
> -		if (ret) {
> -			btrfs_remove_free_space_cache(cache);
> -			btrfs_put_block_group(cache);
> -			goto error;
> -		}
> -
> -		trace_btrfs_add_block_group(info, cache, 0);
> -		btrfs_update_space_info(info, cache->flags, found_key.offset,
> -					btrfs_block_group_used(&cache->item),
> -					cache->bytes_super, &space_info);
> -
> -		cache->space_info =3D space_info;
> -
> -		link_block_group(cache);
> -
> -		set_avail_alloc_bits(info, cache->flags);
> -		if (btrfs_chunk_readonly(info, cache->key.objectid)) {
> -			inc_block_group_ro(cache, 1);
> -		} else if (btrfs_block_group_used(&cache->item) =3D=3D 0) {
> -			ASSERT(list_empty(&cache->bg_list));
> -			btrfs_mark_bg_unused(cache);
> -		}
>  	}
> =20
>  	list_for_each_entry_rcu(space_info, &info->space_info, list) {
>=20


--ZYezXOXolj6E4qWRUIa6RMOEo4pOrDmxl--

--bqkvOhihuCR0n76ksIrKFqmHQqTb1xTfR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl25GJsACgkQwj2R86El
/qia0wf+M93mpRt5bMLC2NQ2fwxUBkMiBBXkuO0OuHwuqOEKXPZ0dYfgAhennyTb
OaNpEeJnKO0O5UWreR+nfZAN8+PrfcfihfXj3jGQldXgpbkWbrA975TaQBGM+hM6
wHMQwJB+RTwg+DaNm0VT8bSZ72cQ7o5XFFgrgQX92tQOjC8wxQMZc1EcDHJE8cqN
/m+6dInbD8gjxTucTFJh3ooizF6rMgd1zpWYVCCDB/DJoR0igTBS88XDt3V932oF
35NywlD/NyDjlgGTYH4rF6RWUtZw3QQPITHgAx2iwFm2a1dRMG1b+sWGsVrJQU6k
YRLs48ZM+oMhRfgJpWZTMcK0y3i6Ng==
=yfMC
-----END PGP SIGNATURE-----

--bqkvOhihuCR0n76ksIrKFqmHQqTb1xTfR--

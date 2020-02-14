Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF315D271
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Feb 2020 07:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgBNG6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Feb 2020 01:58:12 -0500
Received: from m9a0013g.houston.softwaregrp.com ([15.124.64.91]:38445 "EHLO
        m9a0013g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbgBNG6M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Feb 2020 01:58:12 -0500
Received: FROM m9a0013g.houston.softwaregrp.com (15.121.0.191) BY m9a0013g.houston.softwaregrp.com WITH ESMTP
 FOR linux-btrfs@vger.kernel.org;
 Fri, 14 Feb 2020 06:57:31 +0000
Received: from M4W0334.microfocus.com (2002:f78:1192::f78:1192) by
 M9W0068.microfocus.com (2002:f79:bf::f79:bf) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Fri, 14 Feb 2020 06:56:41 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (15.124.8.11) by
 M4W0334.microfocus.com (15.120.17.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Fri, 14 Feb 2020 06:56:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYcIDs8jfASS9ZVpIDUV0t/8DnqmpgEbN7p8kC1X7jpkV10/Q+P2Fnvx71lRMf8TblKM1vzgWjbvvJUD9jFP5oIgXcebMsZODLks2QbKEvIlceW/tLd2N2Q6pHE7CIHHe0U60R5YtAFY5JyHQyBe1Ab9aCyaLQyzLhm0GMpCz4ccHxIF0OLGyiT3hnFxBT8GeajR3xulf9D3gw5A/3O5PA7Dfig0aSoAAHgXcLF5/WvvSlzpkeGiKDDGxBKju5UJm4JE4TEfVzz69rmOGPKWT2dOP8QLoUKtBBzpKryLVJbkaUv5vutIocF+IkUGwyqMwth+bMuVvBO5Om0XnYRauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72dX/p4256K9UgV9RMO5WFQ7H7RXcKgLQxwhhPIy2AM=;
 b=lA5ulywXbUp/qhZRgvof0C+JVYuHBlWZD3LxCChVEJuBDd4iZ+RNkb14LXinWnX3JVocHaJU6FERz6mch0bTCeqfNbqImte0Rk4O9GxNUjWU7J+MYZpYGma354VTcJKtFNDtNF9wIVj+Q0ErynGRgN8imYqJzvvgRijFcy46Pp2gXknHYAJlSvoyIwD4xeZUWheEbK+PT1jS1d7QARjnccAR/lGezN6HxSQkhs2MxX4pV8q2BQNJ4KcLfrhmvR458+ZR7fdERhaLBYt+g6NtkizQHfN18MBnSxthMyt0SRZlP45PqZDv276bz49js5pZ4eik6tnhSO3m5O9rbh+KTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=wqu@suse.com; 
Received: from BY5PR18MB3266.namprd18.prod.outlook.com (10.255.163.207) by
 BY5PR18MB3233.namprd18.prod.outlook.com (10.255.137.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 06:56:40 +0000
Received: from BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd]) by BY5PR18MB3266.namprd18.prod.outlook.com
 ([fe80::d948:61b9:971a:facd%7]) with mapi id 15.20.2707.030; Fri, 14 Feb 2020
 06:56:40 +0000
Subject: Re: [PATCH 3/3] btrfs: relocation: Use btrfs_backref_iterator
 infrastructure
From:   Qu Wenruo <wqu@suse.com>
To:     <linux-btrfs@vger.kernel.org>
References: <20200214063302.47388-1-wqu@suse.com>
 <20200214063302.47388-4-wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <2592af1a-89e0-4c93-11c2-292025710447@suse.com>
Date:   Fri, 14 Feb 2020 14:56:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <20200214063302.47388-4-wqu@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="eLrqhbmOMQiSLovBr8mp36NV9EDSJ6IK6"
X-ClientProxiedBy: BYAPR07CA0042.namprd07.prod.outlook.com
 (2603:10b6:a03:60::19) To BY5PR18MB3266.namprd18.prod.outlook.com
 (2603:10b6:a03:1a1::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (149.28.201.231) by BYAPR07CA0042.namprd07.prod.outlook.com (2603:10b6:a03:60::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Fri, 14 Feb 2020 06:56:39 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afadcd37-7ef7-4376-4c95-08d7b11b0a8b
X-MS-TrafficTypeDiagnostic: BY5PR18MB3233:
X-Microsoft-Antispam-PRVS: <BY5PR18MB32339FE26E5CB039D42847CAD6150@BY5PR18MB3233.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(199004)(189003)(186003)(86362001)(16526019)(26005)(2906002)(31696002)(478600001)(6666004)(31686004)(30864003)(52116002)(33964004)(2616005)(5660300002)(8676002)(6486002)(316002)(956004)(16576012)(81156014)(235185007)(81166006)(8936002)(6916009)(6706004)(36756003)(66946007)(66476007)(21480400003)(66556008)(78286006);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR18MB3233;H:BY5PR18MB3266.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4EnAWv6uW5EZ0159UUUe5vaI4zkgh7cDMm6P55Ko6Q4sXMFjkflA9GVkPcArcFnsROe0O86doDfNiedDxGCI+A91nTrUnzTPl68hwwwzJ9et3587Zp3h3odyH36qaWUbyCrHbSClMqzXa0fnPv5EtCLvQJFwED8W1ruccs7HPbJd1oKfumK2rZVIBY4/8EPKrEQ+lapn5UJRGH2q1E5VT6ZTlx0rOaLSTZE06VWUcK78WL4ugBALnx4umLQIC8Ji0wG0SrZU2Sm2UX1/4yjMBNiZBpi1bGxkRALbSdY/2XVNW+IrQ4zjVWsFYG+7n8F7iYeLUeldDdKv6nyvPG+Oz/XGYEcQVP/UpgzTGoyNYeCcnhpgt5KgVsz/DDxpguUTy4GlRDPSKGQdFvgWPMxAJhtxZQmdP5kDggj+SD8M3EzclfMt2H7ssL0T8D+lknQqO2tNYEMvSv4BLVIf4PQYMAYEsa9jom8+PjiIkhZko5oWz9ZmD6gPkbNlQN9k1q/dt55oOg6G2Fe3yur4l5Si2Fbi4zB3piS/rhgnBtviUaQ=
X-MS-Exchange-AntiSpam-MessageData: O+OW6H4tDOla3D7Ij2LqJIXpP/yL+7PqTcofwc5HcYV0GxptA2n7R6H7naQC1N+CD9DJEv59LJRKxCn8bLL6gq9C2Uxz/QYFoNhliWloDN0rTnl4UJjwjcmGdA7B3IGbrX09i8VXLWpVEwnydKD9Nw==
X-MS-Exchange-CrossTenant-Network-Message-Id: afadcd37-7ef7-4376-4c95-08d7b11b0a8b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 06:56:40.0836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CyAHIJkjrEgu0+wuvtA5vRgxRfTux1bHrE4qJd5ATVdMcAilKw+FSwWHIQkUe39L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR18MB3233
X-OriginatorOrg: suse.com
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

--eLrqhbmOMQiSLovBr8mp36NV9EDSJ6IK6
Content-Type: multipart/mixed; boundary="O6tvTqr7EmgXIVwMnt66NeKArVVNH3oEm"

--O6tvTqr7EmgXIVwMnt66NeKArVVNH3oEm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/2/14 =E4=B8=8B=E5=8D=882:33, Qu Wenruo wrote:
> In the core function of relocation, build_backref_tree, it needs to
> iterate all backref items of one tree block.
>=20
> We don't really want to spend our code and reviewers' time to going
> through tons of supportive code just for the backref walk.
>=20
> Use btrfs_backref_iterator infrastructure to do the loop.
>=20
> The backref items look would be much more easier to read:
>=20
> 	ret =3D btrfs_backref_iterator_start(iterator, cur->bytenr);
> 	for (; ret =3D=3D 0; ret =3D btrfs_backref_iterator_next(iterator)) {
> 		/* The really important work */
> 	}
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>

There is a memleak at error handling. btrfs/101 would cause OOM.

Will update to address this problem.

Thanks,
Qu
> ---
>  fs/btrfs/backref.h    |  20 +++++
>  fs/btrfs/relocation.c | 193 ++++++++++++++----------------------------=

>  2 files changed, 82 insertions(+), 131 deletions(-)
>=20
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index b53301f2147f..016999339be1 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -150,4 +150,24 @@ int btrfs_backref_iterator_start(struct btrfs_back=
ref_iterator *iterator,
>  				 u64 bytenr);
>  int btrfs_backref_iterator_next(struct btrfs_backref_iterator *iterato=
r);
> =20
> +static inline bool
> +btrfs_backref_iterator_is_inline_ref(struct btrfs_backref_iterator *it=
erator)
> +{
> +	if (iterator->cur_key.type =3D=3D BTRFS_EXTENT_ITEM_KEY ||
> +	    iterator->cur_key.type =3D=3D BTRFS_METADATA_ITEM_KEY)
> +		return true;
> +	return false;
> +}
> +
> +static inline void
> +btrfs_backref_iterator_release(struct btrfs_backref_iterator *iterator=
)
> +{
> +	iterator->bytenr =3D 0;
> +	iterator->item_ptr =3D 0;
> +	iterator->cur_ptr =3D 0;
> +	iterator->end_ptr =3D 0;
> +	btrfs_release_path(iterator->path);
> +	memset(&iterator->cur_key, 0, sizeof(iterator->cur_key));
> +}
> +
>  #endif
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index b1365a516a25..21e4482c8232 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -22,6 +22,7 @@
>  #include "print-tree.h"
>  #include "delalloc-space.h"
>  #include "block-group.h"
> +#include "backref.h"
> =20
>  /*
>   * backref_node, mapping_node and tree_block start with this
> @@ -604,48 +605,6 @@ static struct btrfs_root *read_fs_root(struct btrf=
s_fs_info *fs_info,
>  	return btrfs_get_fs_root(fs_info, &key, false);
>  }
> =20
> -static noinline_for_stack
> -int find_inline_backref(struct extent_buffer *leaf, int slot,
> -			unsigned long *ptr, unsigned long *end)
> -{
> -	struct btrfs_key key;
> -	struct btrfs_extent_item *ei;
> -	struct btrfs_tree_block_info *bi;
> -	u32 item_size;
> -
> -	btrfs_item_key_to_cpu(leaf, &key, slot);
> -
> -	item_size =3D btrfs_item_size_nr(leaf, slot);
> -	if (item_size < sizeof(*ei)) {
> -		btrfs_print_v0_err(leaf->fs_info);
> -		btrfs_handle_fs_error(leaf->fs_info, -EINVAL, NULL);
> -		return 1;
> -	}
> -	ei =3D btrfs_item_ptr(leaf, slot, struct btrfs_extent_item);
> -	WARN_ON(!(btrfs_extent_flags(leaf, ei) &
> -		  BTRFS_EXTENT_FLAG_TREE_BLOCK));
> -
> -	if (key.type =3D=3D BTRFS_EXTENT_ITEM_KEY &&
> -	    item_size <=3D sizeof(*ei) + sizeof(*bi)) {
> -		WARN_ON(item_size < sizeof(*ei) + sizeof(*bi));
> -		return 1;
> -	}
> -	if (key.type =3D=3D BTRFS_METADATA_ITEM_KEY &&
> -	    item_size <=3D sizeof(*ei)) {
> -		WARN_ON(item_size < sizeof(*ei));
> -		return 1;
> -	}
> -
> -	if (key.type =3D=3D BTRFS_EXTENT_ITEM_KEY) {
> -		bi =3D (struct btrfs_tree_block_info *)(ei + 1);
> -		*ptr =3D (unsigned long)(bi + 1);
> -	} else {
> -		*ptr =3D (unsigned long)(ei + 1);
> -	}
> -	*end =3D (unsigned long)ei + item_size;
> -	return 0;
> -}
> -
>  /*
>   * build backref tree for a given tree block. root of the backref tree=

>   * corresponds the tree block, leaves of the backref tree correspond
> @@ -665,10 +624,9 @@ struct backref_node *build_backref_tree(struct rel=
oc_control *rc,
>  					struct btrfs_key *node_key,
>  					int level, u64 bytenr)
>  {
> +	struct btrfs_backref_iterator *iterator;
>  	struct backref_cache *cache =3D &rc->backref_cache;
> -	struct btrfs_path *path1; /* For searching extent root */
> -	struct btrfs_path *path2; /* For searching parent of TREE_BLOCK_REF *=
/
> -	struct extent_buffer *eb;
> +	struct btrfs_path *path; /* For searching parent of TREE_BLOCK_REF */=

>  	struct btrfs_root *root;
>  	struct backref_node *cur;
>  	struct backref_node *upper;
> @@ -677,9 +635,6 @@ struct backref_node *build_backref_tree(struct relo=
c_control *rc,
>  	struct backref_node *exist =3D NULL;
>  	struct backref_edge *edge;
>  	struct rb_node *rb_node;
> -	struct btrfs_key key;
> -	unsigned long end;
> -	unsigned long ptr;
>  	LIST_HEAD(list); /* Pending edge list, upper node needs to be checked=
 */
>  	LIST_HEAD(useless);
>  	int cowonly;
> @@ -687,14 +642,14 @@ struct backref_node *build_backref_tree(struct re=
loc_control *rc,
>  	int err =3D 0;
>  	bool need_check =3D true;
> =20
> -	path1 =3D btrfs_alloc_path();
> -	path2 =3D btrfs_alloc_path();
> -	if (!path1 || !path2) {
> +	iterator =3D btrfs_backref_iterator_alloc(rc->extent_root->fs_info,
> +						GFP_NOFS);
> +	path =3D btrfs_alloc_path();
> +	if (!path) {
>  		err =3D -ENOMEM;
>  		goto out;
>  	}
> -	path1->reada =3D READA_FORWARD;
> -	path2->reada =3D READA_FORWARD;
> +	path->reada =3D READA_FORWARD;
> =20
>  	node =3D alloc_backref_node(cache);
>  	if (!node) {
> @@ -707,25 +662,28 @@ struct backref_node *build_backref_tree(struct re=
loc_control *rc,
>  	node->lowest =3D 1;
>  	cur =3D node;
>  again:
> -	end =3D 0;
> -	ptr =3D 0;
> -	key.objectid =3D cur->bytenr;
> -	key.type =3D BTRFS_METADATA_ITEM_KEY;
> -	key.offset =3D (u64)-1;
> -
> -	path1->search_commit_root =3D 1;
> -	path1->skip_locking =3D 1;
> -	ret =3D btrfs_search_slot(NULL, rc->extent_root, &key, path1,
> -				0, 0);
> +	ret =3D btrfs_backref_iterator_start(iterator, cur->bytenr);
>  	if (ret < 0) {
>  		err =3D ret;
>  		goto out;
>  	}
> -	ASSERT(ret);
> -	ASSERT(path1->slots[0]);
> -
> -	path1->slots[0]--;
> =20
> +	/*
> +	 * We skip the first btrfs_tree_block_info, as we don't use the key
> +	 * stored in it, but fetch it from the tree block.
> +	 */
> +	if (btrfs_backref_has_tree_block_info(iterator)) {
> +		ret =3D btrfs_backref_iterator_next(iterator);
> +		if (ret < 0) {
> +			err =3D ret;
> +			goto out;
> +		}
> +		/* No extra backref? This means the tree block is corrupted */
> +		if (ret > 0) {
> +			err =3D -EUCLEAN;
> +			goto out;
> +		}
> +	}
>  	WARN_ON(cur->checked);
>  	if (!list_empty(&cur->upper)) {
>  		/*
> @@ -747,42 +705,21 @@ struct backref_node *build_backref_tree(struct re=
loc_control *rc,
>  		exist =3D NULL;
>  	}
> =20
> -	while (1) {
> -		cond_resched();
> -		eb =3D path1->nodes[0];
> -
> -		if (ptr >=3D end) {
> -			if (path1->slots[0] >=3D btrfs_header_nritems(eb)) {
> -				ret =3D btrfs_next_leaf(rc->extent_root, path1);
> -				if (ret < 0) {
> -					err =3D ret;
> -					goto out;
> -				}
> -				if (ret > 0)
> -					break;
> -				eb =3D path1->nodes[0];
> -			}
> +	for (; ret =3D=3D 0; ret =3D btrfs_backref_iterator_next(iterator)) {=

> +		struct extent_buffer *eb;
> +		struct btrfs_key key;
> +		int type;
> =20
> -			btrfs_item_key_to_cpu(eb, &key, path1->slots[0]);
> -			if (key.objectid !=3D cur->bytenr) {
> -				WARN_ON(exist);
> -				break;
> -			}
> +		cond_resched();
> +		eb =3D btrfs_backref_get_eb(iterator);
> =20
> -			if (key.type =3D=3D BTRFS_EXTENT_ITEM_KEY ||
> -			    key.type =3D=3D BTRFS_METADATA_ITEM_KEY) {
> -				ret =3D find_inline_backref(eb, path1->slots[0],
> -							  &ptr, &end);
> -				if (ret)
> -					goto next;
> -			}
> -		}
> +		key.objectid =3D iterator->bytenr;
> +		if (btrfs_backref_iterator_is_inline_ref(iterator)) {
> +			struct btrfs_extent_inline_ref *iref;
> =20
> -		if (ptr < end) {
>  			/* update key for inline back ref */
> -			struct btrfs_extent_inline_ref *iref;
> -			int type;
> -			iref =3D (struct btrfs_extent_inline_ref *)ptr;
> +			iref =3D (struct btrfs_extent_inline_ref *)
> +				iterator->cur_ptr;
>  			type =3D btrfs_get_extent_inline_ref_type(eb, iref,
>  							BTRFS_REF_TYPE_BLOCK);
>  			if (type =3D=3D BTRFS_REF_TYPE_INVALID) {
> @@ -791,9 +728,9 @@ struct backref_node *build_backref_tree(struct relo=
c_control *rc,
>  			}
>  			key.type =3D type;
>  			key.offset =3D btrfs_extent_inline_ref_offset(eb, iref);
> -
> -			WARN_ON(key.type !=3D BTRFS_TREE_BLOCK_REF_KEY &&
> -				key.type !=3D BTRFS_SHARED_BLOCK_REF_KEY);
> +		} else {
> +			key.type =3D iterator->cur_key.type;
> +			key.offset =3D iterator->cur_key.offset;
>  		}
> =20
>  		/*
> @@ -806,7 +743,7 @@ struct backref_node *build_backref_tree(struct relo=
c_control *rc,
>  		     (key.type =3D=3D BTRFS_SHARED_BLOCK_REF_KEY &&
>  		      exist->bytenr =3D=3D key.offset))) {
>  			exist =3D NULL;
> -			goto next;
> +			continue;
>  		}
> =20
>  		/* SHARED_BLOCK_REF means key.offset is the parent bytenr */
> @@ -852,7 +789,7 @@ struct backref_node *build_backref_tree(struct relo=
c_control *rc,
>  			edge->node[LOWER] =3D cur;
>  			edge->node[UPPER] =3D upper;
> =20
> -			goto next;
> +			continue;
>  		} else if (unlikely(key.type =3D=3D BTRFS_EXTENT_REF_V0_KEY)) {
>  			err =3D -EINVAL;
>  			btrfs_print_v0_err(rc->extent_root->fs_info);
> @@ -860,7 +797,7 @@ struct backref_node *build_backref_tree(struct relo=
c_control *rc,
>  					      NULL);
>  			goto out;
>  		} else if (key.type !=3D BTRFS_TREE_BLOCK_REF_KEY) {
> -			goto next;
> +			continue;
>  		}
> =20
>  		/*
> @@ -891,20 +828,20 @@ struct backref_node *build_backref_tree(struct re=
loc_control *rc,
>  		level =3D cur->level + 1;
> =20
>  		/* Search the tree to find parent blocks referring the block. */
> -		path2->search_commit_root =3D 1;
> -		path2->skip_locking =3D 1;
> -		path2->lowest_level =3D level;
> -		ret =3D btrfs_search_slot(NULL, root, node_key, path2, 0, 0);
> -		path2->lowest_level =3D 0;
> +		path->search_commit_root =3D 1;
> +		path->skip_locking =3D 1;
> +		path->lowest_level =3D level;
> +		ret =3D btrfs_search_slot(NULL, root, node_key, path, 0, 0);
> +		path->lowest_level =3D 0;
>  		if (ret < 0) {
>  			err =3D ret;
>  			goto out;
>  		}
> -		if (ret > 0 && path2->slots[level] > 0)
> -			path2->slots[level]--;
> +		if (ret > 0 && path->slots[level] > 0)
> +			path->slots[level]--;
> =20
> -		eb =3D path2->nodes[level];
> -		if (btrfs_node_blockptr(eb, path2->slots[level]) !=3D
> +		eb =3D path->nodes[level];
> +		if (btrfs_node_blockptr(eb, path->slots[level]) !=3D
>  		    cur->bytenr) {
>  			btrfs_err(root->fs_info,
>  	"couldn't find block (%llu) (level %d) in tree (%llu) with key (%llu =
%u %llu)",
> @@ -920,7 +857,7 @@ struct backref_node *build_backref_tree(struct relo=
c_control *rc,
> =20
>  		/* Add all nodes and edges in the path */
>  		for (; level < BTRFS_MAX_LEVEL; level++) {
> -			if (!path2->nodes[level]) {
> +			if (!path->nodes[level]) {
>  				ASSERT(btrfs_root_bytenr(&root->root_item) =3D=3D
>  				       lower->bytenr);
>  				if (should_ignore_root(root))
> @@ -936,7 +873,7 @@ struct backref_node *build_backref_tree(struct relo=
c_control *rc,
>  				goto out;
>  			}
> =20
> -			eb =3D path2->nodes[level];
> +			eb =3D path->nodes[level];
>  			rb_node =3D tree_search(&cache->rb_root, eb->start);
>  			if (!rb_node) {
>  				upper =3D alloc_backref_node(cache);
> @@ -993,20 +930,14 @@ struct backref_node *build_backref_tree(struct re=
loc_control *rc,
>  			lower =3D upper;
>  			upper =3D NULL;
>  		}
> -		btrfs_release_path(path2);
> -next:
> -		if (ptr < end) {
> -			ptr +=3D btrfs_extent_inline_ref_size(key.type);
> -			if (ptr >=3D end) {
> -				WARN_ON(ptr > end);
> -				ptr =3D 0;
> -				end =3D 0;
> -			}
> -		}
> -		if (ptr >=3D end)
> -			path1->slots[0]++;
> +		btrfs_release_path(path);
> +	}
> +	if (ret < 0) {
> +		err =3D ret;
> +		goto out;
>  	}
> -	btrfs_release_path(path1);
> +	ret =3D 0;
> +	btrfs_backref_iterator_release(iterator);
> =20
>  	cur->checked =3D 1;
>  	WARN_ON(exist);
> @@ -1124,8 +1055,8 @@ struct backref_node *build_backref_tree(struct re=
loc_control *rc,
>  		}
>  	}
>  out:
> -	btrfs_free_path(path1);
> -	btrfs_free_path(path2);
> +	btrfs_backref_iterator_free(iterator);
> +	btrfs_free_path(path);
>  	if (err) {
>  		while (!list_empty(&useless)) {
>  			lower =3D list_entry(useless.next,
>=20


--O6tvTqr7EmgXIVwMnt66NeKArVVNH3oEm--

--eLrqhbmOMQiSLovBr8mp36NV9EDSJ6IK6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl5GRKQACgkQwj2R86El
/qgG4wgAnHdDcvIhhyoiSSc09fwUALGFzHvV3Yq97eg7spLGK4S+m/6X4GcB1ydR
EvQSNAHlqX0y25z+n0RHol7TmO6ueK9jQtHkJzVp37Siz+dN3yPiEJi//tyFD2bE
mmTWKmEbkLUG0/gQ3AAMQqKNK4ZGvs7IGtubQgXxdT8WmAxpVxjUbENYyDTYWcRP
gfGut7PXtXd6jS4nrlvs4yaDjAdcIOlW3tz2bHU4u3XyZelNm2WYdJ2N9IY3Yzon
d5ybz8v6dTXkxCS0qvvRW+kMvZXPHkg7Wg8/4IiiY569gbCwfKH7fVp5sx9NrPE8
tYoKzAxLRMN7sUYWUQsb323E4Uj7pQ==
=jp7D
-----END PGP SIGNATURE-----

--eLrqhbmOMQiSLovBr8mp36NV9EDSJ6IK6--

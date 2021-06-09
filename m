Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D6C3A0BE7
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 07:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhFIFkc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 01:40:32 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:51495 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230222AbhFIFkb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Jun 2021 01:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1623217113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1AqaLXNWrgfWQFp+tYJYKob+ahWXAoqSpfUdBch+gDE=;
        b=SEOkLpjqR/hBUJ3AQpj+IcJn3CXheV/lqaMyMoiV3T8PrX7a5U6QW2iptbllcZiqjPG/bj
        3s/XwDerN86rI7J8dNVlkMpIqp6Ol3GrxdKdQkHtdz0yHLVIj8QNFQnucvSLadQbv7zNj1
        sOPY35DbVi5hTi6FhS7HaPCKJC4Nqsg=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-21-VRmNBU2RN1aIbrb9b2-DUA-1; Wed, 09 Jun 2021 07:38:32 +0200
X-MC-Unique: VRmNBU2RN1aIbrb9b2-DUA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDp9uOcwknCK/v0M1N/ELJjdTLP0u7bsJbHIUSIyPe+0Gi0PTmV7ye9hgAjfG+815jjyl+I72Y0M853HjmBST7zLqr9V/3xWS/XaoDEhYOb35rR2jf1D8PsDkGfxMbT6Nw4GCuyWNydU0RJfRM1gNzd0rx8kNAUkbI6hWcgxh9yQy2lct9AIYEortLi4kPFOW0iUJ2ikCdweXFb3uawLbW2UFZRO2CAw9zimVLpzBbgzEjGMZf2hCCd9vKfAN5btN8PjKociAlkDO7QuYwaGtW0is1q0e1etu7GNqYSvPxYa9lTIgUVE2Upwuejd6iF+TUmCzIsNmrVurCv7sPfnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4RlWl3tf22h1c+SboSX3U//P9S2V3PgMJd/5HdRGxs=;
 b=QwDAefPiYK4uk/DhG4wXxSRxF7SnWlze3nnc7Qqt+32CkR6lZswvRxMPmPcZZepvR7PZbhHqznG6Tj6Ijf3Plo9JxDodJlzyOdYndZrBRXDUdP6uzYMNudQmcm9W941onVSRn4NF3509ix3g4q0xN+w78wt5vWlTquiM+ol8bONcKWJnat57CFGBtZz8WoD0BUhymEd4z593Y1q192iLfTn7lK5I9oaa0WM36m01SYJLQAPjgGY3hbM/TNpvo+qijX02iP+sbJ7G2d26/QPyc9vUk2AVc19jX4Ht2LSaLSrsbBLw3wd4cd30bCynevxBCLr7QOyDy+/Dqwaie+gYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB5959.eurprd04.prod.outlook.com (2603:10a6:20b:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 9 Jun
 2021 05:38:31 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%7]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 05:38:31 +0000
Subject: Re: [PATCH v3 06/10] btrfs: defrag: introduce a helper to defrag a
 range
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210608025927.119169-1-wqu@suse.com>
 <20210608025927.119169-7-wqu@suse.com>
Message-ID: <d0d273d9-9f2f-ce5d-0396-e67caa6c7d41@suse.com>
Date:   Wed, 9 Jun 2021 13:38:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210608025927.119169-7-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::16) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:1d0::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Wed, 9 Jun 2021 05:38:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92d6c21a-48f9-4325-00aa-08d92b08d0df
X-MS-TrafficTypeDiagnostic: AM6PR04MB5959:
X-Microsoft-Antispam-PRVS: <AM6PR04MB59591A295B89BE1551CE6E7CD6369@AM6PR04MB5959.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LAVZtVqd6asscDdzOqevw1VU87PwleDskzriE4Xur5xCoXg5MaDSbylEEmPJgcKHZvsmKs0Vbl3IPbg/VdjqvPt9MY7OA35TyJ/x2q5FGg4Impke7KC84QKTvJ1F4luzGVmOeWO8AQuQKyjPPbOqkovF/fvQUlzwjx9YlrJ/F9OSLZR2T0SgiyBnINcBgdWDDg04JaxBlBycicVOYVYFeBDi3Ya10DWAXmvoKWRrWrv/sG/QvlD7UtGE2ghDxQKs/3ejulkxnXnjltsYI6oRiUM4a4bVGrNs0vuC/6BFus7T3f0aFgR4naI+B4cJe+u5Dtz3D/tLhjOPTuduDEZpw6Zv+A3z0sbD+G6WQfmKAS9KoVo3UzvUfuk4bPHwN/7cgIXTbTIPHqqzpoEZ+mxhWvOlsgIFYcdXr0RhFY5okauItWT/sP/DQuEQziMTwhGJr5Zm29bNEG0uDtgT6lDp+N0jsTjF23m4VaAQbno6ci4Enifrb88gRTL/H7pTGro7LMEbe10f/UNYCFE1YQPR+0MXwdPwP74389AAeQxC2N8VTENAHuAzuhrOxdZG2glmE0srAcqC40z91Rm7UUEhUJBgfiai0k2NuM1ODI1vxdFV7pvQMNv8U+iXWk3iNmZEGqu+Mmhcqw0vRt8Iwq0pxQcyQdIZi8nObTDUjQVjbD8t5yFYaXt6z6+LeyXf7COl5tqbLKIaSc5+PhOU/6M1Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(136003)(39860400002)(376002)(186003)(86362001)(2616005)(6916009)(6706004)(956004)(8676002)(478600001)(31696002)(66476007)(38100700002)(66556008)(66946007)(16526019)(26005)(36756003)(6486002)(31686004)(2906002)(83380400001)(6666004)(5660300002)(16576012)(316002)(8936002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kLqXXln6kHJaFzSisde39gtDrAT/2SfnQAMr4DZPhkAkw08JlP7MqQpHLdmL?=
 =?us-ascii?Q?tvI5KXeTtm+OiYWn1BH0/bYYI5rdDU7Z0dV3IE3xH2sccVjHaBN1jNXlNCLC?=
 =?us-ascii?Q?6vN5jhithyJBnP9SP4qHrhHhXP4vDyRX7EY+GgQKgsBiziUiq4y68dKZeJAj?=
 =?us-ascii?Q?rM/u5Q0R4sGjmfMEBGzj4sg9CB6/q84KsSuLfvI9YfbjC68PoSVz71dnDvs7?=
 =?us-ascii?Q?h0z9lMnwYzWjNIsAcdVnXH0rz2Q3Nx/lnSlj2JxGpgOKzbeAr35Kwsy4QWWK?=
 =?us-ascii?Q?S0nGK5/KiH7/fZJ2nBHsAvy5FEAk/EpX0tGQ+qdV2OJuhlapxvkkdH68YZpn?=
 =?us-ascii?Q?A9BRe3JwSl+lBdUF2O0A7H47u2MZEDX1wQJ8Fc8xaULT1dob/20ZteyShu2G?=
 =?us-ascii?Q?5nmRFeJCO87pXbKbcKQ5Vko2Sdboo6xNuK+LmHyW59UNvqarwLHHUiyE2T33?=
 =?us-ascii?Q?XcsX5OSmZcKwrv4h/627/mW2SE57fp/BqQxWHWYvV/cn8Uhnd7mnXp1PAw9y?=
 =?us-ascii?Q?M1gRZjf3bneDrdwtTf/xoo3nXqEnsjz4M4om56aOHtLKqK9DILCU89uVIabZ?=
 =?us-ascii?Q?dvb/+Hi/v87b/cH+WfuXpDs1Kj9w5MF+IB5R1OWLQ1aqhEG+3xoJSouPhQYf?=
 =?us-ascii?Q?2Hmecif8KSW/2fxKozXq1xeOjtMaAOk8nWxCS2ZMxCSH9ocKi9+G9oOVxiNV?=
 =?us-ascii?Q?++CqGc6Y8RZ6m2uGJbywYgecLzIjBE5niUYzNbKqNPeR734IaGbiLkvnzJYY?=
 =?us-ascii?Q?BTEOscP6ZOiGkRnejMsjvYe7HpLE0wIo6J+QJlz6isqP/9+1LbkHkWHmtOu6?=
 =?us-ascii?Q?2DkICTwvCr+25BeXJ7j7Rk1f41AWbTnzWtaA6+b7O+kGqxP4DpaWTBg7iVpo?=
 =?us-ascii?Q?lxgAiRL1DdiGvyOVqMT1YBzhfG2dEUsaaMI3uh7fXBn+eY21eTV+qapf/ybM?=
 =?us-ascii?Q?k9u8E0fk2Jl6Ooeiu+Y/k9WrCRFv2yVjNCIYb5O+9lknQsmt2RJsibFZ8gvc?=
 =?us-ascii?Q?tEGhZJJQfh5Y2N88DSGz/lgxQtLtISO4ZZMNGz2ky/QGVZ+hLL9J/J0Ugow5?=
 =?us-ascii?Q?UbGLt9OsFyCEm+kw91/mZs1XkCxYVzK/kwO2lAeYMkMXEoSeYjOl5Z8IobXc?=
 =?us-ascii?Q?rPewUbt44/hgM9FmAIdRPW2utK8pfnywyOmudXP+yEXgcAEkb2PxhMOQ97uU?=
 =?us-ascii?Q?pIHlFDj5+vlTLtgF3vDga1EXByuh2A28AbuJB/HvStgNahFAsTfe9fXAPy60?=
 =?us-ascii?Q?kmZjw1WMXveuG4INI+fgkCtuF6rZv0bzNB973f7oSRTScu8aLRRTKM/OEVio?=
 =?us-ascii?Q?sI/nliyGyBx/ZI1kfNa4rBYe?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d6c21a-48f9-4325-00aa-08d92b08d0df
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 05:38:31.5595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMMmMYe1DjJi8OnyLGMc7JmeohJQepmkv65eppxAh+t6hRTFcmgSWWoWyc7KPZr5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5959
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/6/8 =E4=B8=8A=E5=8D=8810:59, Qu Wenruo wrote:
> A new helper, defrag_one_range(), is introduced to defrag one range.
>=20
> This function will mostly prepare the needed pages and extent status for
> defrag_one_locked_target().
>=20
> As we can only have a consistent view of extent map with page and
> extent bits locked, we need to re-check the range passed in to get a
> real target list for defrag_one_locked_target().
>=20
> Since defrag_collect_targets() will call defrag_lookup_extent() and lock
> extent range, we also need to teach those two functions to skip extent
> lock.
> Thus new parameter, @locked, is introruced to skip extent lock if the
> caller has already locked the range.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/ioctl.c | 94 ++++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 87 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 42e757dfdd7b..8259ad102469 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1033,7 +1033,8 @@ static int find_new_extents(struct btrfs_root *root=
,
>   	return -ENOENT;
>   }
>  =20
> -static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 =
start)
> +static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 =
start,
> +					       bool locked)
>   {
>   	struct extent_map_tree *em_tree =3D &BTRFS_I(inode)->extent_tree;
>   	struct extent_io_tree *io_tree =3D &BTRFS_I(inode)->io_tree;
> @@ -1053,10 +1054,12 @@ static struct extent_map *defrag_lookup_extent(st=
ruct inode *inode, u64 start)
>   		u64 end =3D start + sectorsize - 1;
>  =20
>   		/* get the big lock and read metadata off disk */
> -		lock_extent_bits(io_tree, start, end, &cached);
> +		if (!locked)
> +			lock_extent_bits(io_tree, start, end, &cached);
>   		em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, start,
>   				      sectorsize);
> -		unlock_extent_cached(io_tree, start, end, &cached);
> +		if (!locked)
> +			unlock_extent_cached(io_tree, start, end, &cached);
>  =20
>   		if (IS_ERR(em))
>   			return NULL;
> @@ -1074,7 +1077,7 @@ static bool defrag_check_next_extent(struct inode *=
inode, struct extent_map *em)
>   	if (em->start + em->len >=3D i_size_read(inode))
>   		return false;
>  =20
> -	next =3D defrag_lookup_extent(inode, em->start + em->len);
> +	next =3D defrag_lookup_extent(inode, em->start + em->len, false);

Here the fixed false parameter is causing another hang.

As defrag_check_next_extent() can be called inside=20
defrag_collect_targets(), which can be called with extent locked.

Will fix it in next update.

Thanks,
Qu

>   	if (!next || next->block_start >=3D EXTENT_MAP_LAST_BYTE)
>   		ret =3D false;
>   	else if ((em->block_start + em->block_len =3D=3D next->block_start) &&
> @@ -1103,7 +1106,7 @@ static int should_defrag_range(struct inode *inode,=
 u64 start, u32 thresh,
>  =20
>   	*skip =3D 0;
>  =20
> -	em =3D defrag_lookup_extent(inode, start);
> +	em =3D defrag_lookup_extent(inode, start, false);
>   	if (!em)
>   		return 0;
>  =20
> @@ -1390,12 +1393,13 @@ struct defrag_target_range {
>    * @do_compress:   Whether the defrag is doing compression
>    * 		   If true, @extent_thresh will be ignored and all regular
>    * 		   file extents meeting @newer_than will be targets.
> + * @locked:	   If the range has already hold extent lock
>    * @target_list:   The list of targets file extents
>    */
>   static int defrag_collect_targets(struct btrfs_inode *inode,
>   				  u64 start, u64 len, u32 extent_thresh,
>   				  u64 newer_than, bool do_compress,
> -				  struct list_head *target_list)
> +				  bool locked, struct list_head *target_list)
>   {
>   	u64 cur =3D start;
>   	int ret =3D 0;
> @@ -1406,7 +1410,7 @@ static int defrag_collect_targets(struct btrfs_inod=
e *inode,
>   		bool next_mergeable =3D true;
>   		u64 range_len;
>  =20
> -		em =3D defrag_lookup_extent(&inode->vfs_inode, cur);
> +		em =3D defrag_lookup_extent(&inode->vfs_inode, cur, locked);
>   		if (!em)
>   			break;
>  =20
> @@ -1548,6 +1552,82 @@ static int defrag_one_locked_target(struct btrfs_i=
node *inode,
>   	return ret;
>   }
>  =20
> +static int defrag_one_range(struct btrfs_inode *inode,
> +			    u64 start, u32 len,
> +			    u32 extent_thresh, u64 newer_than,
> +			    bool do_compress)
> +{
> +	struct extent_state *cached_state =3D NULL;
> +	struct defrag_target_range *entry;
> +	struct defrag_target_range *tmp;
> +	LIST_HEAD(target_list);
> +	struct page **pages;
> +	const u32 sectorsize =3D inode->root->fs_info->sectorsize;
> +	unsigned long last_index =3D (start + len - 1) >> PAGE_SHIFT;
> +	unsigned long start_index =3D start >> PAGE_SHIFT;
> +	unsigned int nr_pages =3D last_index - start_index + 1;
> +	int ret =3D 0;
> +	int i;
> +
> +	ASSERT(nr_pages <=3D CLUSTER_SIZE / PAGE_SIZE);
> +	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(len, sectorsize));
> +
> +	pages =3D kzalloc(sizeof(struct page *) * nr_pages, GFP_NOFS);
> +	if (!pages)
> +		return -ENOMEM;
> +
> +	/* Prepare all pages */
> +	for (i =3D 0; i < nr_pages; i++) {
> +		pages[i] =3D defrag_prepare_one_page(inode, start_index + i);
> +		if (IS_ERR(pages[i])) {
> +			ret =3D PTR_ERR(pages[i]);
> +			pages[i] =3D NULL;
> +			goto free_pages;
> +		}
> +	}
> +	/* Also lock the pages range */
> +	lock_extent_bits(&inode->io_tree, start_index << PAGE_SHIFT,
> +			 (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
> +			 &cached_state);
> +	/*
> +	 * Now we have a consistent view about the extent map, re-check
> +	 * which range really need to be defraged.
> +	 *
> +	 * And this time we have extent locked already, pass @locked =3D true
> +	 * so that we won't re-lock the extent range and cause deadlock.
> +	 */
> +	ret =3D defrag_collect_targets(inode, start, len, extent_thresh,
> +				     newer_than, do_compress, true,
> +				     &target_list);
> +	if (ret < 0)
> +		goto unlock_extent;
> +
> +	list_for_each_entry(entry, &target_list, list) {
> +		ret =3D defrag_one_locked_target(inode, entry, pages, nr_pages,
> +					       &cached_state);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	list_for_each_entry_safe(entry, tmp, &target_list, list) {
> +		list_del_init(&entry->list);
> +		kfree(entry);
> +	}
> +unlock_extent:
> +	unlock_extent_cached(&inode->io_tree, start_index << PAGE_SHIFT,
> +			     (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
> +			     &cached_state);
> +free_pages:
> +	for (i =3D 0; i < nr_pages; i++) {
> +		if (pages[i]) {
> +			unlock_page(pages[i]);
> +			put_page(pages[i]);
> +		}
> +	}
> +	kfree(pages);
> +	return ret;
> +}
> +
>   /*
>    * Btrfs entrace for defrag.
>    *
>=20


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A16A2EBA4F
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 08:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbhAFHEZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 02:04:25 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:28134 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725562AbhAFHEY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Jan 2021 02:04:24 -0500
X-Greylist: delayed 497 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2021 02:04:21 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1609916595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4WXxULKx9N1piIk5SfAGNtDRY4vrP9pY+FLXPdFbrgE=;
        b=M2eZao1fJMsEYkQ4wsJ+KOPvPY0MXXMx0ztNDEJsnXRlnmC6DzDwP1nOs+4TZfLow1TtEp
        knPzxp7ZtiUCgn0hibqplO1cETXW2lbiXkvFWDa3VqEuObvGEj69s5qO74zk8KQDta3Y0U
        LmhLzZWOnEelVLsRJ8UfVPODu29aXlI=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2113.outbound.protection.outlook.com [104.47.18.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-21-fH6x_GwvMlKBqodIGzUzEw-1; Wed, 06 Jan 2021 07:54:57 +0100
X-MC-Unique: fH6x_GwvMlKBqodIGzUzEw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hu4mP9M7+Hk0iBIiDcwXNtAfVpviZo183qrh1dytmlbDo5fNmw+dxGEa6viB/DrQenzQTBsfs5SEBXfvbBZf3GeaCplUdTp0mQeVQQuGSNMD8bIbhhM06zBpUToxHggyuqX0BH4sLV44xWZ41SrlqbnIdZ5qPODPGv3vPKcM5Dp84Sfz39UaywoYoxcLb0VkejKtrrwvfiK6ipXagrCDr3pPevTsbBD5ATtYLlMedBZzHPauQ1aKDTuNRBP8l2wObIs0tjd13uSSRGiTDJHemF9pBW0X2iO7FN5eKJZkXz56yVKXcfUaX8BRxpGzSc3QMWXe55c4GmmxuVjFX/orGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TTME+yoSgARBlW/R9Y4fbamPAzbQwXvZqMPIeHZ9hk=;
 b=kOKVVn5qlF1V6gL2xIioq4G5rF9fCjWW7zRy9A5XERCoWJIUEiq5v6Z0hJMG2BGonPqGb1s6GbtGr678+bKaBymdwen+o4JtzD/Je7qKd6NTdFEn4JHCnaRs5d+b6UyXa0DReZ8aJqImDDHbT72TMwv+oabz8pFXv8ctd2hiz+FZGKe/WX31kCpuhs2L04NuGBM36bWv4CJr7GWfGg2lYE/jDqr9NcTgdTSemFygcXv2AQrEtjBIxvTpkPo9nI3dPIXK010egaIKVinjFa3ZLw8ZUs9lO0uBPvEobgoyYy3YA/aaCojXqby1/EG8fD0KiGU8WT2cmft1VTbWWFHDSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PA4PR04MB7822.eurprd04.prod.outlook.com (2603:10a6:102:b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 06:54:56 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709%6]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 06:54:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210106010201.37864-1-wqu@suse.com>
 <20210106010201.37864-9-wqu@suse.com>
Subject: Re: [PATCH v3 08/22] btrfs: extent_io: make
 attach_extent_buffer_page() to handle subpage case
Message-ID: <844a6c6b-c5e9-c0c8-0177-fe3ae015c108@suse.com>
Date:   Wed, 6 Jan 2021 14:54:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210106010201.37864-9-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR13CA0103.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::18) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0103.namprd13.prod.outlook.com (2603:10b6:a03:2c5::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2 via Frontend Transport; Wed, 6 Jan 2021 06:54:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 212dfe02-8770-474b-c649-08d8b20ff9fa
X-MS-TrafficTypeDiagnostic: PA4PR04MB7822:
X-Microsoft-Antispam-PRVS: <PA4PR04MB782294F6701783769927CA44D6D00@PA4PR04MB7822.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4i77AUdA4D3PFxdsCe9Ws3Ma74dl/gZqRFxx1cHW+X4DLKma5bTq6jfmakpQZzkMXfUK4+fVNsp21YOiCw6gKl/2UjynU22Ab4WOJr9GmBbFmvXfjkiSHiLxcp+YiwpMFyvBftGDv4nLDqBObLoxKGGkXX9CDiZCy/6ivMzFR0XfS2WWHXyIVh5zIYo8UjLntAzSh/mBWv/hJWRhot6YQdmtvYrZgcA2FFpJsrXa+yq+Ka1/gBMgh4SqF2U+0r58N3u2wAcBKgsYjt2Jpu+IzPYznS6D4hhh1CR9MOp/+7nQqpl4xeZuaKciYhtXfm3AU3ReK/ta9zDNQ0qOZhWVhDuxA6/kh7umuGRts+vUmrBiHfrF9td6jFodrXeBSfHXJlybJLwiGrHkFFV5z3g8ixQI5mB7qF6T85kvKrwyisSFMdnGtUU5CTR/te3tPAy8FsROPSfWiP1t2LfToH1iqF3qRHg9tpwKsisX94M6G5mw8kVbzRYj0Tap56sWrmgW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(376002)(366004)(396003)(39850400004)(86362001)(31686004)(31696002)(2906002)(6666004)(5660300002)(478600001)(8676002)(66476007)(2616005)(66556008)(956004)(66946007)(6916009)(6706004)(186003)(16576012)(6486002)(83380400001)(26005)(16526019)(8936002)(52116002)(316002)(36756003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5hcYhe1Qjynmb5a/qCMO/uBV2ZKrfUixk09Z1iS/DI2EwslATry6aIw23Fr4?=
 =?us-ascii?Q?LEUEBzGV/Zf31d+nH09fef9zJJGytnXSMNRqLc4enLxnGZKFZ5DtB18ONnQM?=
 =?us-ascii?Q?W/IuiJzD/QxsEG173Rb9BX/O3DkouA8dum8o+4KmWytdFNfuVFGK92b6w5V6?=
 =?us-ascii?Q?y2ElhA3QfZ4BrcK8hqPM47YfYuT44HgJMpN6iypMLSChiuf4z7sbPyL1TvcW?=
 =?us-ascii?Q?/GNJi4/A3PQO5nokdVSEZeLfnm44/KLzpbYN7mQM/HdOmZ/P99XKjayFivU+?=
 =?us-ascii?Q?T4kKMGNheRBPJaTwqrk8+bSdTBF3RyKwemON/xCNkB4rMhVyhr9LScOY40k5?=
 =?us-ascii?Q?E2sZeRFYvUOuQ+aBFG8z/VefPozAAfam1Ame3hxYSKZgTT4YG8Nv8REslZI+?=
 =?us-ascii?Q?5foD6D8sl7UPZCjUf174U1zQcswlqLwuE3g/mLjHwcGIET/weXKyVajcJTdr?=
 =?us-ascii?Q?BjVqrxGSQ2HOK9IdCM5N+KZuaa6JUwnDYV76YXDuSBtI1ZZ4PY5PQfYB5Ukk?=
 =?us-ascii?Q?f3xESIlsIe+kE2StsRLO2h6lp2NBwgJET7Yolczu5Q/95czM8vYVyJKE4xLO?=
 =?us-ascii?Q?Fi55M+JIfeDCHZGbkZYktpOpPJabGUveY6U1j92SGC3CZAh/+YNlRPvihmwO?=
 =?us-ascii?Q?RGcYRzZxYrBlvgiG0IfM3hnoQjP/lwNXr/aOACG/f9f6co8Uo1HCBEeummvd?=
 =?us-ascii?Q?etAAoOo/VhqIVfpcgiJgqJVhhsktzR+35UvX0S9TmX41PhtHOUnyEff6Bw7c?=
 =?us-ascii?Q?g+IeHzgzyKf7ihEz9Kg601ZrrgQkeLLnWhbkmHlR4U6xxNA9KOolsJuSzjMy?=
 =?us-ascii?Q?k+z4aebBbi7592IIFXoeT0pEaa2BF58ipwutsWeFEGwd+pEourrWn7Kz3+n0?=
 =?us-ascii?Q?pABiT4Dq2IuoX0dQE3qflufyr0rrFXShlIf1Ipg9epuDYbND9XIGtU1xRkr2?=
 =?us-ascii?Q?KMVRu3bZNljxqbzrQ4i8EL+Me+zMA31prmp4gZdUx1G8t7uKmpphq5D5SVLt?=
 =?us-ascii?Q?OXxW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2021 06:54:55.9716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 212dfe02-8770-474b-c649-08d8b20ff9fa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZjwYPRn+jj/HeLjVJ0b4PVVa1LlS1zvF3o07QdPgt5RocyjRFAN3ZnTlisWuBfB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7822
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/1/6 =E4=B8=8A=E5=8D=889:01, Qu Wenruo wrote:
> For subpage case, we need to allocate new memory for each metadata page.
>=20
> So we need to:
> - Allow attach_extent_buffer_page() to return int
>    To indicate allocation failure
>=20
> - Prealloc page->private for alloc_extent_buffer()
>    We don't want to call memory allocation with spinlock hold, so
>    do preallocation before we acquire the spin lock.
>=20
> - Handle subpage and regular case differently in
>    attach_extent_buffer_page()
>    For regular case, just do the usual thing.
>    For subpage case, allocate new memory and update the tree_block
>    bitmap.
>=20
>    The bitmap update will be handled by new subpage specific helper,
>    btrfs_subpage_set_tree_block().
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 74 ++++++++++++++++++++++++++++++++++----------
>   fs/btrfs/subpage.h   | 50 ++++++++++++++++++++++++++++++
>   2 files changed, 108 insertions(+), 16 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index d60f1837f8fb..2eeff925450f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -24,6 +24,7 @@
>   #include "rcu-string.h"
>   #include "backref.h"
>   #include "disk-io.h"
> +#include "subpage.h"
>  =20
>   static struct kmem_cache *extent_state_cache;
>   static struct kmem_cache *extent_buffer_cache;
> @@ -3140,22 +3141,41 @@ static int submit_extent_page(unsigned int opf,
>   	return ret;
>   }
>  =20
> -static void attach_extent_buffer_page(struct extent_buffer *eb,
> +static int attach_extent_buffer_page(struct extent_buffer *eb,
>   				      struct page *page)
>   {
> -	/*
> -	 * If the page is mapped to btree inode, we should hold the private
> -	 * lock to prevent race.
> -	 * For cloned or dummy extent buffers, their pages are not mapped and
> -	 * will not race with any other ebs.
> -	 */
> -	if (page->mapping)
> -		lockdep_assert_held(&page->mapping->private_lock);
> +	struct btrfs_fs_info *fs_info =3D eb->fs_info;
> +	int ret;
>  =20
> -	if (!PagePrivate(page))
> -		attach_page_private(page, eb);
> -	else
> -		WARN_ON(page->private !=3D (unsigned long)eb);
> +	if (fs_info->sectorsize =3D=3D PAGE_SIZE) {
> +		/*
> +		 * If the page is mapped to btree inode, we should hold the
> +		 * private lock to prevent race.
> +		 * For cloned or dummy extent buffers, their pages are not
> +		 * mapped and will not race with any other ebs.
> +		 */
> +		if (page->mapping)
> +			lockdep_assert_held(&page->mapping->private_lock);
> +
> +		if (!PagePrivate(page))
> +			attach_page_private(page, eb);
> +		else
> +			WARN_ON(page->private !=3D (unsigned long)eb);
> +		return 0;
> +	}
> +
> +	/* Already mapped, just update the existing range */
> +	if (PagePrivate(page))
> +		goto update_bitmap;
> +
> +	/* Do new allocation to attach subpage */
> +	ret =3D btrfs_attach_subpage(fs_info, page);
> +	if (ret < 0)
> +		return ret;
> +
> +update_bitmap:
> +	btrfs_subpage_set_tree_block(fs_info, page, eb->start, eb->len);
> +	return 0;
>   }
>  =20
>   void set_page_extent_mapped(struct page *page)
> @@ -5063,21 +5083,29 @@ struct extent_buffer *btrfs_clone_extent_buffer(c=
onst struct extent_buffer *src)
>   	if (new =3D=3D NULL)
>   		return NULL;
>  =20
> +	set_bit(EXTENT_BUFFER_UPTODATE, &new->bflags);
> +	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
> +
>   	for (i =3D 0; i < num_pages; i++) {
> +		int ret;
> +
>   		p =3D alloc_page(GFP_NOFS);
>   		if (!p) {
>   			btrfs_release_extent_buffer(new);
>   			return NULL;
>   		}
> -		attach_extent_buffer_page(new, p);
> +		ret =3D attach_extent_buffer_page(new, p);
> +		if (ret < 0) {
> +			put_page(p);
> +			btrfs_release_extent_buffer(new);
> +			return NULL;
> +		}
>   		WARN_ON(PageDirty(p));
>   		SetPageUptodate(p);
>   		new->pages[i] =3D p;
>   		copy_page(page_address(p), page_address(src->pages[i]));
>   	}
>  =20
> -	set_bit(EXTENT_BUFFER_UPTODATE, &new->bflags);
> -	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
>  =20
>   	return new;
>   }
> @@ -5316,6 +5344,18 @@ struct extent_buffer *alloc_extent_buffer(struct b=
trfs_fs_info *fs_info,
>   			goto free_eb;
>   		}
>  =20
> +		/*
> +		 * Preallocate page->private for subpage case, so that
> +		 * we won't allocate memory with private_lock hold.
> +		 */
> +		ret =3D btrfs_attach_subpage(fs_info, p);

Although we try to preallocate the subpage structure here, it's not=20
reliable.

I have hit a case just minutes before, where we still try to allocate=20
memory inside that private_lock spinlock, and causes sleep inside atomic=20
warning.

The problem is, we can have a race where the page has one existing eb,=20
and it's being freed.

At this point, we still have page::private.

But before we acquire that private_lock, the eb get freed and since it's=20
the only eb of that page (our eb hasn't yet being added to the page), it=20
detach page private.

> +		if (ret < 0) {
> +			unlock_page(p);
> +			put_page(p);
> +			exists =3D ERR_PTR(-ENOMEM);
> +			goto free_eb;
> +		}
> +
>   		spin_lock(&mapping->private_lock);
>   		exists =3D grab_extent_buffer(p);
>   		if (exists) {
> @@ -5325,8 +5365,10 @@ struct extent_buffer *alloc_extent_buffer(struct b=
trfs_fs_info *fs_info,
>   			mark_extent_buffer_accessed(exists, p);
>   			goto free_eb;
>   		}
> +		/* Should not fail, as we have attached the subpage already */
>   		attach_extent_buffer_page(eb, p);

So here we can not rely on any result before we acquire private_lock.

Thus I guess we have to pre-allocate the memory manually and pass the=20
pointer in.

Why I didn't hit the bug before sending the patches...

Thanks,
Qu

>   		spin_unlock(&mapping->private_lock);
> +
>   		WARN_ON(PageDirty(p));
>   		eb->pages[i] =3D p;
>   		if (!PageUptodate(p))
> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> index 96f3b226913e..e49d4a7329e1 100644
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -23,9 +23,59 @@
>   struct btrfs_subpage {
>   	/* Common members for both data and metadata pages */
>   	spinlock_t lock;
> +	union {
> +		/* Structures only used by metadata */
> +		struct {
> +			u16 tree_block_bitmap;
> +		};
> +		/* structures only used by data */
> +	};
>   };
>  =20
>   int btrfs_attach_subpage(struct btrfs_fs_info *fs_info, struct page *pa=
ge);
>   void btrfs_detach_subpage(struct btrfs_fs_info *fs_info, struct page *p=
age);
>  =20
> +/*
> + * Convert the [start, start + len) range into a u16 bitmap
> + *
> + * E.g. if start =3D=3D page_offset() + 16K, len =3D 16K, we get 0x00f0.
> + */
> +static inline u16 btrfs_subpage_calc_bitmap(struct btrfs_fs_info *fs_inf=
o,
> +			struct page *page, u64 start, u32 len)
> +{
> +	int bit_start =3D offset_in_page(start) >> fs_info->sectorsize_bits;
> +	int nbits =3D len >> fs_info->sectorsize_bits;
> +
> +	/* Basic checks */
> +	ASSERT(PagePrivate(page) && page->private);
> +	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
> +	       IS_ALIGNED(len, fs_info->sectorsize));
> +
> +	/*
> +	 * The range check only works for mapped page, we can
> +	 * still have unampped page like dummy extent buffer pages.
> +	 */
> +	if (page->mapping)
> +		ASSERT(page_offset(page) <=3D start &&
> +			start + len <=3D page_offset(page) + PAGE_SIZE);
> +	/*
> +	 * Here nbits can be 16, thus can go beyond u16 range. Here we make the
> +	 * first left shift to be calculated in unsigned long (u32), then
> +	 * truncate the result to u16.
> +	 */
> +	return (u16)(((1UL << nbits) - 1) << bit_start);
> +}
> +
> +static inline void btrfs_subpage_set_tree_block(struct btrfs_fs_info *fs=
_info,
> +			struct page *page, u64 start, u32 len)
> +{
> +	struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->private=
;
> +	unsigned long flags;
> +	u16 tmp =3D btrfs_subpage_calc_bitmap(fs_info, page, start, len);
> +
> +	spin_lock_irqsave(&subpage->lock, flags);
> +	subpage->tree_block_bitmap |=3D tmp;
> +	spin_unlock_irqrestore(&subpage->lock, flags);
> +}
> +
>   #endif /* BTRFS_SUBPAGE_H */
>=20


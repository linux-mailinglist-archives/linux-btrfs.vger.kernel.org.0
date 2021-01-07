Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65162EC7C4
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jan 2021 02:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbhAGBgh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 20:36:37 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:22675 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726341AbhAGBgg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 6 Jan 2021 20:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1609983327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KXw8lS+rMSJaQ8gTr5HucdP6ZMIKILmHNYfW3jCe5Go=;
        b=mv7GQ0t72hNOVrlaWlEJp7eW2fRmNv6qsgmCMo1onpVq5vqTDX8AGT4h9jBrBtL+5sCDTS
        dijG2P5iaHIcZR11HDWbcR3DrnOEZCAT107mDWQutFzXAaQ93jo1sZ3UJTCQPs7/xc5KpI
        CByxcouWwLZxWM5D/lO2lf1psYSPmc4=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2105.outbound.protection.outlook.com [104.47.18.105])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-10-hZRMgrkFNMaScFWhmlJOXQ-1; Thu, 07 Jan 2021 02:35:25 +0100
X-MC-Unique: hZRMgrkFNMaScFWhmlJOXQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mkkml0Wq8aFsq0qeg2zhLBHW2/+tbeYwfi26NbpTemujvRZ8jBG05Qp4D5zSPvN/rHyN5xXnXbHlSq0+AoQZQiwb05TfkyN8C2Pe6hynjXEqUI2GhOSh61Su+gua5SO21ZyeXiVXhkQxa9AFH9eznU33AgcRda5nFpqDdycGW5Sh7fQ93R28poHVscMJC4iMR5PEnpB+1YVCRsvDEGl0IgV+Q40azasddBgOFs208KyM3tN54+1ulyzPAze18iXDkdX72Y8d6+eh0D+z9JqogokQDsEQG7ah7YR6RcMEIdJRvSnOa1yFhdOMT0JuYQuHhsAzJKw32BN79ezU/hwGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6fkYjWR+f8YRBKr7juJIClupCGWcf/Et4iecS6S6O4=;
 b=JatZ27SJc0TAnwvb1aes3s6QCJHRRVn5Sk8jHgFd/qnNgjma9+EC3iebG1xL3lKeBaHeI+Joo8Rerj/s5XPckcRV6w68fmuthe9wi8nHMz2q9hPrFNuDLcWsV9aS2gVQCxl0gzWdkDRn4bq5n/Kd93kJi14eMQ0hU7OXPnIkfp9Ivj85IwdGHvnVJ7CRqAe5VCrUVPbnA9vyx30Y8hw82pu6g7EdWj+c7ure9GupqqR7a3mKep8i9cOM9KwcSTiA7F3a8sYZxhdge09r1LaWSx7GaoSTKEH7nRp9tHexP5QSPqAyeEs0RVal++JSXsoEXd3XfQovYurc4P7E5aqOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (20.182.212.83) by
 PA4PR04MB8029.eurprd04.prod.outlook.com (20.182.186.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Thu, 7 Jan 2021 01:35:24 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::397a:950:d8c8:d709%7]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 01:35:24 +0000
Subject: Re: [PATCH v3 08/22] btrfs: extent_io: make
 attach_extent_buffer_page() to handle subpage case
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210106010201.37864-1-wqu@suse.com>
 <20210106010201.37864-9-wqu@suse.com>
Message-ID: <32601c1c-339f-4798-8917-61a865f8d7ee@suse.com>
Date:   Thu, 7 Jan 2021 09:35:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210106010201.37864-9-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::10) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:a03:33e::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 01:35:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a59d450-93c5-4a1f-eb56-08d8b2ac813d
X-MS-TrafficTypeDiagnostic: PA4PR04MB8029:
X-Microsoft-Antispam-PRVS: <PA4PR04MB8029EC4F82CCE9CD421CC52DD6AF0@PA4PR04MB8029.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRQsRX3juPztg23DADdDtkC5h12ILLglBOL3fsxx3pBCJpj8K2Q5OLtUeg4X/5zwxw+7TSOhY9uxGhSVHVC5zDXpUkxy+2PELWEzlR7ZGBby49j/VeBojg32AAAeBeXVNmWMaueCb3xe/P24c96nzroDlSEgk/g/9SqM42GgbGdCdHkJLeiuKN0XrRoSpKYKP0lWFtOtitDmTnikAixalYDVY4oHqcNci+z/8xuNmIEbTnTEtaMggt+NACoSZR5BioUX7dwBd77rOAkFkaxVFljs+Y8lfCX+7A6+wJRtH6vcXHH5gjlObVWL4Fr+QWaWllFQbmjR2fHpzO4fdffPlHvMMm7+WDByg4i74hl+EbhLTo+WOowhneQu+tuNn6a958gPj1mHcxfgGEuAJZahWT51O/ObsMynj49FVeAkk6sH8VrHyZcT3cVaf8hrkRyrXJGTNoSAeICZhAIIDSpYRS+yMp8G39aZ6StQBRbBlmGf9XKzR+r3k+5s9a3d+JYx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(396003)(376002)(346002)(366004)(6666004)(6706004)(16526019)(2616005)(6916009)(31696002)(2906002)(83380400001)(8676002)(8936002)(478600001)(52116002)(5660300002)(6486002)(31686004)(66946007)(26005)(66476007)(66556008)(36756003)(956004)(186003)(86362001)(16576012)(316002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EHTcKYk6m8iBTuY0+2tEsMcH4NMw5K+XAkZg+I7/C6voijTsvMsE8G5ZWZey?=
 =?us-ascii?Q?KIsOPOPPiLc5X4ijl7m6KVM/sBfpMA4ipOuFJhPbJOyLtd4rqsgK5dHWB5dB?=
 =?us-ascii?Q?M8O/lyOXcPXsIXCTbe0wYaHFYcyaOTllF1SWZQ0zzA2qIkCoWr+/nfGfadEh?=
 =?us-ascii?Q?CpjfxwpLr9gCDpqvZvPpKV8HZ5ImNTfClqdgPA+QWrYB36NmYhWaA0MmikZy?=
 =?us-ascii?Q?BofBYukJdCu2G3b3vxzE7tnUB2LOCqgSTqdnptP9SEN7BbYeUdOr8QWtzLGw?=
 =?us-ascii?Q?hXTpomWI318hs+uoT12HLz5MtYk07nfFfNnj9+v5YGwCZ4DDlS8Di3gaJ6Tz?=
 =?us-ascii?Q?FGZCs46ZoCmUV6GvNL4lWD4LRpMozxvqYNRMlN0hmngMTyXQuneNfYSpiIqZ?=
 =?us-ascii?Q?hLZmeWPgdgP4Az0wa3MZvkc1849wrnPmDJ0UkFKcbJ2beBAfBwOAg5fF6/ne?=
 =?us-ascii?Q?bb8SOlqnUpWp7jr4fw+qDaWD4ypmOD6ayWbCD/xMuwTnkArYuQMvp6Iy0BFU?=
 =?us-ascii?Q?KkMUvv6UiJKZwdIyiC/+Zzj/vL2KINHmE1iq0nWvZ39QXumg7yQqyuYUR3OF?=
 =?us-ascii?Q?ZwxFS5ZipnzBc5YoSHtWK4dvj8oR3TCI/MJAKq/qNqzhsjVhyfp1kN9A43QC?=
 =?us-ascii?Q?rG6iS2jjH62e7sjhduVwqMqV+/Q3WjSNNVBjECr+Qu5TZNUo2wNsI8T/0fLX?=
 =?us-ascii?Q?VAtNSHZSi0LN0zu/BLl2hMUS91LkiOHNLhaiem73/J/Hnx31DLXH/k7YO+F4?=
 =?us-ascii?Q?pmeLWYtrUvXYGHXFa3svVp4yo8/ki67oqdVljDPWJqQOK5Gh9cROo3tQ5Ba2?=
 =?us-ascii?Q?g6+4IgUizrV8xJq5zwVRK9SuG61Yyy+p5UsxJIxlSugNgCrSW64rEp5p5qcW?=
 =?us-ascii?Q?UWhbqtVqfSElwulcdU4ndzi9F7XGt2q9Z7jN8Il0mKEfl6zTGX8u52vwV8mG?=
 =?us-ascii?Q?+oDl8Tcg/5sMzSlZNW7/X4v5ULou3JAfGeVZatlcaA6SuEQqS+6b/BedSd4Z?=
 =?us-ascii?Q?t8NI?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2021 01:35:24.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a59d450-93c5-4a1f-eb56-08d8b2ac813d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LK+LB2trUj2R5Tls6H2MYuwa39qFuoEjoJJIGy++RnCvwZW2sqIOUE29mZ+Z210z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8029
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

After more investigation, the idea of using subpage structure to record=20
tree blocks bitmap may not be a good idea.

The main problem is the synchronization for the bit and extent buffer,=20
which have different lock schemas.
I'll try to use radix tree only to do the check, other than relying on=20
some extra bit.

Thanks,
Qu

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


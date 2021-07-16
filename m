Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A10F3CB39F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Jul 2021 09:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbhGPH5m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Jul 2021 03:57:42 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:41782 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236973AbhGPH5k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Jul 2021 03:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1626422085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q7riacJxx2Wi0YduWGjTJYW/Gz52kJtvoaH9CUkylGg=;
        b=WX+vCqlLuDdYfewjVYS9xCNeu5RCRxWFXyBgoTU8gHe/gC52sdM4WMG/+xpt+VXI4Dg6rl
        OJSVKKo3NJTF+BkPfV1+K1z8MmWbVQlsotNYDO26NKVGFQ38Ld5gB4aLSCBr4VM8ii6gQN
        dbu5Q7+wv0j3/9MUgcCB3C1I49pyPmI=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2058.outbound.protection.outlook.com [104.47.9.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-39-twPllQpAOUWVFJszRbnLzw-1; Fri, 16 Jul 2021 09:54:44 +0200
X-MC-Unique: twPllQpAOUWVFJszRbnLzw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqWdCDGJFMsmxByN/1yPtNEsIydH/NIXI2umnWeXt12hEw6dJCdXF5YLUxxxFpwYxXcKzQ7sxY1EhgwW4Ym0uVVGcnO0tq0mGUwSEKrckvv9kwhWjl9GGyBMcTDhMSUNssp8rNpgVC2gquiblS3dvuSvKrJ3Dui4LvbFSuMDkM8CBV0gdEH1OupQ5PNsUpFb3w7cJeK+B00fLvr57hhtz9pDewPtrIbm9ZGWm85nuu8+bVrWx/yMFcsJRTYVEAua+De85avO7iIjz8mjrCDfmyBPC0Y60860mm22h4AIr1YXu9ZrWxEXf6opSLkdz1Mn2R+nzOjPjE5CHJL+juewpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDAOPMk4XzXGhrxdDHtisRGd0AyK7tjpxay8PbXifUg=;
 b=gBCCWVX5prPZ1tMeeIRE9dN92RHMmfzkWq11QXk3IPA8jPMnFi9yAQWYNbINX1RCV7bI/CcwqftmoHPIv449kfi8mYwfc5vrjSsb08UzQpQAK4Pnwy7u8qKPZ7fbsNXyIISv+6WaYH/yKBTpQ74tduQEAbKBg/ndDpObk1BHX3hZVC3uOgyET8yVyBleoegZrvsiWEuma0C23SA5YDsLVhOBPTaxD5pdEWzvqMzGhKHjVm0wiR/cibt7m8m5GBWwK6k7SnlsHDThDVYPZBmMH/W7OVqa/UPfHTQw/BlJn4nr02S1S4qmfLZoyHIUXEtWqVib3Z6X9FGCKvLAwKrO1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR0402MB2787.eurprd04.prod.outlook.com (2603:10a6:203:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 07:54:42 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 07:54:41 +0000
Subject: Re: [PATCH 07/27] btrfs: add subpage checked_bitmap to make
 PageChecked flag to be subpage compatible
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210713061516.163318-1-wqu@suse.com>
 <20210713061516.163318-8-wqu@suse.com>
Message-ID: <ea8930f6-037f-0076-0de5-67b82e70c338@suse.com>
Date:   Fri, 16 Jul 2021 15:54:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210713061516.163318-8-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::15) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0250.namprd03.prod.outlook.com (2603:10b6:a03:3a0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Fri, 16 Jul 2021 07:54:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aad04fd2-1843-4db1-c280-08d9482ef79f
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2787:
X-Microsoft-Antispam-PRVS: <AM5PR0402MB27876F5E5BFE8D548683804BD6119@AM5PR0402MB2787.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ncg+IIl/g1DKDi915zBRqgdJQugi3H+wT36Oq++Br82OcXqWbgDE1Y99eUHl4eqCeu1vPjuDjB2cfBGvcBzNcF76wiCJcNKKo0TfsxcQcW5XDIR0kGTXFUDV8Ff98eiaGW/RYSjBP8KNpFPFG3xIEGO2QDiBMAxvuK42mh6479OZGGNq0dIcdEgOZ5YgQEvFKpwq6EwzxPePS6Kq0vrZdH7bswmtTJXBSe8y3gvFBs+ZIdcZ/2uSNm/rPVOPSq3Z15GI5T99COFgxe5E1LT6UEsF4PZTt16hAGBz+ysXg1i57yIM0+m4EQHrJY+63vTH1Lle7t8FnAPmgj7ZVjNKxsfFNbqsS66UVYQK8uAxiebWsbOB6hxLoTQ9sQTbtaQcGhAFcgInyvwKM3lDBe5bb3lqGtXvlKMHS4zbNgYeT0OBTCqv2kCU+3JgoR39++jFIXODg0Hqfv4qQnP+XiwvgQCrK1rN+iCjfgT0H364+Y83JAvmByndIdE1dUX+aI0Hqsw9xjWZ8Aq7Mbj5vi3bz92scNrtws+XAIwLVqrLpwsIG/r2t1H5MjpmSdo9NDyy0T+4DMNm8Ae1sIDqRoZ3A9siuZxD1M91fx0q3jQQAWHUopYT7UG3ehoUdrXrtP0hzzaYaZBpWErE/ElBeifX0RWSjhObh+yxbOjYqS/nz7w1ClxmSZPs1OwaZXRRnNdKZZxRKx7JdCq876xfMY79KhL8K2DkSkLUxPqIDZuZQbo3zGUst4MNjnri+vEwzfBh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(6706004)(2616005)(6916009)(16576012)(8676002)(956004)(83380400001)(2906002)(66556008)(8936002)(66476007)(66946007)(30864003)(86362001)(26005)(498600001)(6486002)(38100700002)(36756003)(186003)(6666004)(5660300002)(31696002)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MCJUXaHYRfbgiYQ2wsL6QyrceXtg/v00OAcqrnnpk4YxXButNe5qmChNBkN7?=
 =?us-ascii?Q?mJfWyddYsd5bCbCRP3ry7CBKsC8gC/PVohVf1lw9uR2d2loidTgdMy1FpeEW?=
 =?us-ascii?Q?ukZQh1k0Msr0SWkxL45HBcmXe2CeXxmhDtF+eoJfogAyAhvWxDDWyt2zk7j/?=
 =?us-ascii?Q?QGx+FaSugCKqTpHwyoaQrDM1lbqc7xWKsrmrGVQzCP1tqGaOVlLIAsu3v2IT?=
 =?us-ascii?Q?GDZfMhUKgogioNfTM0nl3bWNj4N4Jxp4FKtNOuBQLvzCyshrHd9sPMFOvQGv?=
 =?us-ascii?Q?F8JSWQGVOrSt2zmroaOZ1WNF+Z2iwEtSSKOBRsRKNhm+oANHcFCokbvZ4vHc?=
 =?us-ascii?Q?T7WokbN9ExNv17feWgZ99hCDewba4v4axrzz5CMQIh8ugX/dmUez4OLsvwk5?=
 =?us-ascii?Q?Rwo5et8FgyWAlvdU/y34qWssw6MXESw+FXRHlSEyAsIoHJKAeWt9Aex6/F0W?=
 =?us-ascii?Q?8gSsfUXylcQ9sS/6rvkPLlpKrVmGJw6kFpIt4PYkjXvy1OzWUlyFl5Ma0+Jg?=
 =?us-ascii?Q?wXSckNlM1cXoVzNrz5rNDa7WMvRfa0R+CfXnUGirabuqQTFQtXwsZcsch4rt?=
 =?us-ascii?Q?0dVW10ivOGMlL6dpXpKUG0D5fqGaiXcMV5TL8rakG7LLFKCVAfTCzKYkwafc?=
 =?us-ascii?Q?MBJedI6WcbAc/e2HtaC1sfCaWjL77jtoKxxhfMh+2eJB3xLnY9Rhlym+NVJr?=
 =?us-ascii?Q?LRBwY3RXidaR/rZo0uJHdfNx9nzo2up25MDQ7PUcNYnGAnw4ITQmdBmpCVd8?=
 =?us-ascii?Q?3DRZ3sUs9mqGE/1ajOAzMxjOnT5LVJ2NWzxTwDGRwxcIjp+PGhjsJX0R6HgU?=
 =?us-ascii?Q?looOlk+fYxxEjW4G5BYHwINJklj9bXE9EGcyfBU3+A6jhGdHCwBE6tqdLPrU?=
 =?us-ascii?Q?vwlSiS8g8+HERhSPYh38s5SnnJKBw/aqTxzd5BFqQ5y4SKs2snWFVpn+6gwm?=
 =?us-ascii?Q?tQx8pczKYgUS40+VndsJIZKvL587cQtaM2TmWLoQvfYo2fn3h16qo1bOQWjY?=
 =?us-ascii?Q?Jhf6izo65pgguts1LtB0Z1AzNY2BihAv8Y8+w3Kdn4Uxy/9X8SGoQEkxABM4?=
 =?us-ascii?Q?+fUVAq5Xj+OCNiKsE/SIWplE6BiZ/FjUkff70Avfd9XpSCDGbISUdkjlMoEC?=
 =?us-ascii?Q?dcb+8oLCFjCkkV0AFAGRKm6cZyPRtMNKJskclfxW8dca/hdcQBZBfhgYuKSI?=
 =?us-ascii?Q?qfUxuNPIflfDX15klHjjQ8Q3bcxe/GKZOovdu8XRx5XO/7hU2heu3MsN9oPp?=
 =?us-ascii?Q?henWSlOw/0bUr9lwfLiwUiNoTn2rOW+o1bTszhXxYM3AtF+l6uWVoAK70Wta?=
 =?us-ascii?Q?l7Zw5sBMf14c+bK7EnGI7ag9?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad04fd2-1843-4db1-c280-08d9482ef79f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 07:54:41.3228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pY7TTl5A8rEaFw1wO/51bALuYpNSSFo54h5Rrz5ByqcS5SHOswpZcGSexidThTfJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2787
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/13 =E4=B8=8B=E5=8D=882:14, Qu Wenruo wrote:
> Although in btrfs we have very limited user of PageChecked flag, it's
> still some page flag not yet subpage compatible.
>=20
> Fix it by introducing btrfs_subpage::checked_bitmap to do the covert.
>=20
> For most call sites, especially for free-space cache, COW fixup and
> btrfs_invalidatepage(), they all work in full page mode anyway.
>=20
> For other call sites, they work as fully subpage mode.
>=20
> Some call sites need extra modification:
>=20
> - btrfs_drop_pages()
>    Needs extra parameter to get the real range we need to clear checked
>    flag.
>=20
> - btrfs_invalidatepage()
>    We need to call subpage helper before calling __btrfs_releasepage(),
>    or it will trigger ASSERT() as page->private will be cleared.
>=20
> - btrfs_verify_data_csum()
>    In theory we don't need the io_bio->csum check anymore, but it's
>    won't hurt.
>    Just change the comment.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/compression.c      | 11 +++++++++--
>   fs/btrfs/file.c             | 20 +++++++++++++++-----
>   fs/btrfs/free-space-cache.c |  6 +++++-
>   fs/btrfs/inode.c            | 30 ++++++++++++++----------------
>   fs/btrfs/reflink.c          |  2 +-
>   fs/btrfs/subpage.c          | 31 +++++++++++++++++++++++++++++++
>   fs/btrfs/subpage.h          |  8 ++++++++
>   7 files changed, 83 insertions(+), 25 deletions(-)
>=20
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index f08522e8b4cd..be81e34fbd56 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -29,6 +29,7 @@
>   #include "extent_io.h"
>   #include "extent_map.h"
>   #include "zoned.h"
> +#include "subpage.h"
>  =20
>   static const char* const btrfs_compress_types[] =3D { "", "zlib", "lzo"=
, "zstd" };
>  =20
> @@ -296,8 +297,14 @@ static void end_compressed_bio_read(struct bio *bio)
>   		 * checked so the end_io handlers know about it
>   		 */
>   		ASSERT(!bio_flagged(bio, BIO_CLONED));
> -		bio_for_each_segment_all(bvec, cb->orig_bio, iter_all)
> -			SetPageChecked(bvec->bv_page);
> +		bio_for_each_segment_all(bvec, cb->orig_bio, iter_all) {
> +			u64 bvec_start =3D page_offset(bvec->bv_page) +
> +					 bvec->bv_offset;
> +
> +			btrfs_page_set_checked(btrfs_sb(cb->inode->i_sb),
> +					bvec->bv_page, bvec_start,
> +					bvec->bv_len);
> +		}
>  =20
>   		bio_endio(cb->orig_bio);
>   	}
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 0831ca08376f..ccbbf2732685 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -437,9 +437,16 @@ static noinline int btrfs_copy_from_user(loff_t pos,=
 size_t write_bytes,
>   /*
>    * unlocks pages after btrfs_file_write is done with them
>    */
> -static void btrfs_drop_pages(struct page **pages, size_t num_pages)
> +static void btrfs_drop_pages(struct btrfs_fs_info *fs_info,
> +			     struct page **pages, size_t num_pages,
> +			     u64 pos, u64 copied)
>   {
>   	size_t i;
> +	u64 block_start =3D round_down(pos, fs_info->sectorsize);
> +	u64 block_len =3D round_up(pos + copied, fs_info->sectorsize) -
> +			block_start;
> +
> +	ASSERT(block_len <=3D U32_MAX);
>   	for (i =3D 0; i < num_pages; i++) {
>   		/* page checked is some magic around finding pages that
>   		 * have been modified without going through btrfs_set_page_dirty
> @@ -447,7 +454,8 @@ static void btrfs_drop_pages(struct page **pages, siz=
e_t num_pages)
>   		 * accessed as prepare_pages should have marked them accessed
>   		 * in prepare_pages via find_or_create_page()
>   		 */
> -		ClearPageChecked(pages[i]);
> +		btrfs_page_clamp_clear_checked(fs_info, pages[i], block_start,
> +					       block_len);

Currently btrfs_subpage_clamp() can't handle any page whose=20
page_offset() is beyond @block_start + @block_len.

This leads to rare crash in generic/269 and generic/102.

Will also update btrfs_subpage_clamp() to handle such case in next update.

Thanks,
Q

>   		unlock_page(pages[i]);
>   		put_page(pages[i]);
>   	}
> @@ -504,7 +512,8 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, stru=
ct page **pages,
>   		struct page *p =3D pages[i];
>  =20
>   		btrfs_page_clamp_set_uptodate(fs_info, p, start_pos, num_bytes);
> -		ClearPageChecked(p);
> +		btrfs_page_clamp_clear_checked(fs_info, p, start_pos,
> +					       num_bytes);
>   		btrfs_page_clamp_set_dirty(fs_info, p, start_pos, num_bytes);
>   	}
>  =20
> @@ -1845,7 +1854,8 @@ static noinline ssize_t btrfs_buffered_write(struct=
 kiocb *iocb,
>  =20
>   		btrfs_delalloc_release_extents(BTRFS_I(inode), reserve_bytes);
>   		if (ret) {
> -			btrfs_drop_pages(pages, num_pages);
> +			btrfs_drop_pages(fs_info, pages, num_pages, pos,
> +					 copied);
>   			break;
>   		}
>  =20
> @@ -1853,7 +1863,7 @@ static noinline ssize_t btrfs_buffered_write(struct=
 kiocb *iocb,
>   		if (only_release_metadata)
>   			btrfs_check_nocow_unlock(BTRFS_I(inode));
>  =20
> -		btrfs_drop_pages(pages, num_pages);
> +		btrfs_drop_pages(fs_info, pages, num_pages, pos, copied);
>  =20
>   		cond_resched();
>  =20
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 2131ae5b9ed7..f0a84fe7dc80 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -22,6 +22,7 @@
>   #include "delalloc-space.h"
>   #include "block-group.h"
>   #include "discard.h"
> +#include "subpage.h"
>  =20
>   #define BITS_PER_BITMAP		(PAGE_SIZE * 8UL)
>   #define MAX_CACHE_BYTES_PER_GIG	SZ_64K
> @@ -417,7 +418,10 @@ static void io_ctl_drop_pages(struct btrfs_io_ctl *i=
o_ctl)
>  =20
>   	for (i =3D 0; i < io_ctl->num_pages; i++) {
>   		if (io_ctl->pages[i]) {
> -			ClearPageChecked(io_ctl->pages[i]);
> +			btrfs_page_clear_checked(io_ctl->fs_info,
> +					io_ctl->pages[i],
> +					page_offset(io_ctl->pages[i]),
> +					PAGE_SIZE);
>   			unlock_page(io_ctl->pages[i]);
>   			put_page(io_ctl->pages[i]);
>   		}
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index b524deadb5c6..5c29d131a574 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2757,7 +2757,8 @@ static void btrfs_writepage_fixup_worker(struct btr=
fs_work *work)
>   		clear_page_dirty_for_io(page);
>   		SetPageError(page);
>   	}
> -	ClearPageChecked(page);
> +	btrfs_page_clear_checked(inode->root->fs_info, page,
> +				 page_start, PAGE_SIZE);
>   	unlock_page(page);
>   	put_page(page);
>   	kfree(fixup);
> @@ -2812,7 +2813,7 @@ int btrfs_writepage_cow_fixup(struct page *page, u6=
4 start, u64 end)
>   	 * page->mapping outside of the page lock.
>   	 */
>   	ihold(inode);
> -	SetPageChecked(page);
> +	btrfs_page_set_checked(fs_info, page, page_offset(page), PAGE_SIZE);
>   	get_page(page);
>   	btrfs_init_work(&fixup->work, btrfs_writepage_fixup_worker, NULL, NULL=
);
>   	fixup->page =3D page;
> @@ -3257,27 +3258,23 @@ unsigned int btrfs_verify_data_csum(struct btrfs_=
io_bio *io_bio, u32 bio_offset,
>   				    struct page *page, u64 start, u64 end)
>   {
>   	struct inode *inode =3D page->mapping->host;
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
>   	struct extent_io_tree *io_tree =3D &BTRFS_I(inode)->io_tree;
>   	struct btrfs_root *root =3D BTRFS_I(inode)->root;
>   	const u32 sectorsize =3D root->fs_info->sectorsize;
>   	u32 pg_off;
>   	unsigned int result =3D 0;
>  =20
> -	if (PageChecked(page)) {
> -		ClearPageChecked(page);
> +	if (btrfs_page_test_checked(fs_info, page, start, end + 1 - start)) {
> +		btrfs_page_clear_checked(fs_info, page, start, end + 1 - start);
>   		return 0;
>   	}
>  =20
>   	/*
> -	 * For subpage case, above PageChecked is not safe as it's not subpage
> -	 * compatible.
> -	 * But for now only cow fixup and compressed read utilize PageChecked
> -	 * flag, while in this context we can easily use io_bio->csum to
> -	 * determine if we really need to do csum verification.
> -	 *
> -	 * So for now, just exit if io_bio->csum is NULL, as it means it's
> -	 * compressed read, and its compressed data csum has already been
> -	 * verified.
> +	 * This only happens for NODATASUM or compressed read.
> +	 * Normally this should be covered by above check for compressed read
> +	 * or the next check for NODATASUM.
> +	 * Just do a quicker exit here.
>   	 */
>   	if (io_bio->csum =3D=3D NULL)
>   		return 0;
> @@ -5083,7 +5080,8 @@ int btrfs_truncate_block(struct btrfs_inode *inode,=
 loff_t from, loff_t len,
>   				     len);
>   		flush_dcache_page(page);
>   	}
> -	ClearPageChecked(page);
> +	btrfs_page_clear_checked(fs_info, page, block_start,
> +				 block_end + 1 - block_start);
>   	btrfs_page_set_dirty(fs_info, page, block_start, block_end + 1 - block=
_start);
>   	unlock_extent_cached(io_tree, block_start, block_end, &cached_state);
>  =20
> @@ -8673,9 +8671,9 @@ static void btrfs_invalidatepage(struct page *page,=
 unsigned int offset,
>   	 * did something wrong.
>   	 */
>   	ASSERT(!PageOrdered(page));
> +	btrfs_page_clear_checked(fs_info, page, page_offset(page), PAGE_SIZE);
>   	if (!inode_evicting)
>   		__btrfs_releasepage(page, GFP_NOFS);
> -	ClearPageChecked(page);
>   	clear_page_extent_mapped(page);
>   }
>  =20
> @@ -8819,7 +8817,7 @@ vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   		memzero_page(page, zero_start, PAGE_SIZE - zero_start);
>   		flush_dcache_page(page);
>   	}
> -	ClearPageChecked(page);
> +	btrfs_page_clear_checked(fs_info, page, page_start, PAGE_SIZE);
>   	btrfs_page_set_dirty(fs_info, page, page_start, end + 1 - page_start);
>   	btrfs_page_set_uptodate(fs_info, page, page_start, end + 1 - page_star=
t);
>  =20
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index 9b0814318e72..a7de8cfdcac0 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -138,7 +138,7 @@ static int copy_inline_to_page(struct btrfs_inode *in=
ode,
>   	}
>  =20
>   	btrfs_page_set_uptodate(fs_info, page, file_offset, block_size);
> -	ClearPageChecked(page);
> +	btrfs_page_clear_checked(fs_info, page, file_offset, block_size);
>   	btrfs_page_set_dirty(fs_info, page, file_offset, block_size);
>   out_unlock:
>   	if (page) {
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index a61aa33aeeee..b8a420cb1683 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -468,6 +468,34 @@ void btrfs_subpage_clear_ordered(const struct btrfs_=
fs_info *fs_info,
>   		ClearPageOrdered(page);
>   	spin_unlock_irqrestore(&subpage->lock, flags);
>   }
> +
> +void btrfs_subpage_set_checked(const struct btrfs_fs_info *fs_info,
> +		struct page *page, u64 start, u32 len)
> +{
> +	struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->private=
;
> +	const u16 tmp =3D btrfs_subpage_calc_bitmap(fs_info, page, start, len);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&subpage->lock, flags);
> +	subpage->checked_bitmap |=3D tmp;
> +	if (subpage->checked_bitmap =3D=3D U16_MAX)
> +		SetPageChecked(page);
> +	spin_unlock_irqrestore(&subpage->lock, flags);
> +}
> +
> +void btrfs_subpage_clear_checked(const struct btrfs_fs_info *fs_info,
> +		struct page *page, u64 start, u32 len)
> +{
> +	struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->private=
;
> +	const u16 tmp =3D btrfs_subpage_calc_bitmap(fs_info, page, start, len);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&subpage->lock, flags);
> +	subpage->checked_bitmap &=3D ~tmp;
> +	ClearPageChecked(page);
> +	spin_unlock_irqrestore(&subpage->lock, flags);
> +}
> +
>   /*
>    * Unlike set/clear which is dependent on each page status, for test al=
l bits
>    * are tested in the same way.
> @@ -491,6 +519,7 @@ IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(error);
>   IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(dirty);
>   IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(writeback);
>   IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(ordered);
> +IMPLEMENT_BTRFS_SUBPAGE_TEST_OP(checked);
>  =20
>   /*
>    * Note that, in selftests (extent-io-tests), we can have empty fs_info=
 passed
> @@ -561,6 +590,8 @@ IMPLEMENT_BTRFS_PAGE_OPS(writeback, set_page_writebac=
k, end_page_writeback,
>   			 PageWriteback);
>   IMPLEMENT_BTRFS_PAGE_OPS(ordered, SetPageOrdered, ClearPageOrdered,
>   			 PageOrdered);
> +IMPLEMENT_BTRFS_PAGE_OPS(checked, SetPageChecked, ClearPageChecked,
> +			 PageChecked);
>  =20
>   void btrfs_page_assert_not_dirty(const struct btrfs_fs_info *fs_info,
>   				 struct page *page)
> diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
> index 9aa40d795ba9..6fb54b22b295 100644
> --- a/fs/btrfs/subpage.h
> +++ b/fs/btrfs/subpage.h
> @@ -44,6 +44,13 @@ struct btrfs_subpage {
>  =20
>   			/* Tracke pending ordered extent in this sector */
>   			u16 ordered_bitmap;
> +
> +			/*
> +			 * If the sector is already checked, thus no need to go
> +			 * through csum verification.
> +			 * Used by both compression and cow fixup.
> +			 */
> +			u16 checked_bitmap;
>   		};
>   	};
>   };
> @@ -122,6 +129,7 @@ DECLARE_BTRFS_SUBPAGE_OPS(error);
>   DECLARE_BTRFS_SUBPAGE_OPS(dirty);
>   DECLARE_BTRFS_SUBPAGE_OPS(writeback);
>   DECLARE_BTRFS_SUBPAGE_OPS(ordered);
> +DECLARE_BTRFS_SUBPAGE_OPS(checked);
>  =20
>   bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_=
info,
>   		struct page *page, u64 start, u32 len);
>=20


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB2039BB56
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhFDPAr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 11:00:47 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:50796 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229809AbhFDPAq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Jun 2021 11:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1622818739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qg2yrJGNc8EB0Lni++qFmMyiwCsmAIe2RwLNILPgNE8=;
        b=f8FavqTAsVLFYCVbpvzt0YGgoiB3UkDeTBi8vzTjVRDv9eZ2340btJNqWL1K9dnU8rYYzc
        9ml2zprV4B3zVIo/8ufVZFxFNlFvNvtFtUZuk9xbh/2na0JobHSAWBCYu8XtOEk5UWZMKD
        FqL+RYeExT/k5wX+33BdJKb7KAAau5Q=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2171.outbound.protection.outlook.com [104.47.17.171])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-33-1XPhubLXO5q7FQwYgzB7sA-1; Fri, 04 Jun 2021 16:58:58 +0200
X-MC-Unique: 1XPhubLXO5q7FQwYgzB7sA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBXaxahBPgLwGWPB6JgOBamAjcxsYJEkyYUmfx0KHDetstT/jT1P3zLcYo4CvBFBMH5U8HUVj/8R0urswohVctLuSwUKOxIIqrddBbRe+PgqXKrGnztW3cm9gBxDsGyRoGgjJdInvqVFEPuomvVKlGT5FK3qZl3VDTf1sezfWgoOwNe3q+Z3jfjMhAAjOZDhtvptT6pC7yPG8bHGnK9F2OV91kfrRzh3uXvC+3uBypM5SlTM3Uvk4kiqlc+tib9hKj6XkdGKoRlpOTiAHmJKqhQ64dDpfloe51kgqxF/kkSWe7PlA0lJHZ/p19+U0yFM9swp13ytITW8MSB3aqzrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDURT6ESGLHEKrI+FZ9O9YmZ80rJys96VdnT5WAoxrI=;
 b=GF5yY+vkXIOGhaTatOOVZz+v7j5TD8gbB0/IFnKKh2yakokvrR1LNf8tGxdcmwJaiRLZtu2jHfrNayf9ilm/UxHV3yW7vuoBB/Yz9hh31SOi/fvyzt3QQi4um0ZdJNlDza5kUQ2qDYsMb5DP6FNuqNJAQ80+52UV0wLs4HYJHSkLardT3e2nI32SaZypkfDi1wQTjMcc2NlUGGq9sV/qRYsiemgg1ZipTmtbxja0ZctPZZgTC++QwzFulJvcaVuw/nu4/8s4QDhhwkHuQMgargWzN9FARvTuGuwdEzmYjIPLf0E5QXkeAyW+WWCNQrgh25Hq0fZ5Bl0+IboPxriQJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB4967.eurprd04.prod.outlook.com (2603:10a6:20b:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 14:58:54 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%9]) with mapi id 15.20.4173.030; Fri, 4 Jun 2021
 14:58:54 +0000
Subject: Re: [PATCH v4 14/30] btrfs: make __extent_writepage_io() only submit
 dirty range for subpage
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210531085106.259490-1-wqu@suse.com>
 <20210531085106.259490-15-wqu@suse.com>
Message-ID: <45b86276-1342-2ae0-134f-69085ec80294@suse.com>
Date:   Fri, 4 Jun 2021 22:58:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210531085106.259490-15-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0317.namprd03.prod.outlook.com
 (2603:10b6:a03:39d::22) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0317.namprd03.prod.outlook.com (2603:10b6:a03:39d::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Fri, 4 Jun 2021 14:58:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d70cf70d-7d72-4aae-17f9-08d9276945a1
X-MS-TrafficTypeDiagnostic: AM6PR04MB4967:
X-Microsoft-Antispam-PRVS: <AM6PR04MB496719DB97F0F23F427293C7D63B9@AM6PR04MB4967.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmGupr0LsNHTUX2BcOYQqnVydjqkNt8BokYkjVR+yVlQCLgHCDbIkPiTYVCQJKwywlQvFmGL8o2dOXmkBBdVPm7cy992/hISbQGIRa1bIctI8wsbFgFtK3bIHwHEOnmPjRfIXQK2SDFJP0vvzzyze1tMP3PErB0VRtlIZzU+fi4esz5nc5Y8G5zvzaOIq5g9w9O5MHBs91mSGHzXzyMZ1KfZwADqsmbyZ9gos1AFPmnPo4t/sGK6jgNpaYU8LNDCq+CL7BGBZcHxgk/wjeLKKG2pFfjJO2MlRdQgpHCc7ZHw7RJ+ihKKzDfx/wPjODYJGc3VM775udREeo47IPZ9a1BvbwKbXERGFqqcBmZSvFSLcSu+mPUeItTT5Zy0Wk3QPyP5kzdr7qWfJKXNOYKdP5ew6XVEg8tnp2c6xypA51GNYFIMRwjsjq9qSrmqcrn4JCWPWd35MGEzIFMdYc9weoKuY8jNJSlsJbkfBl8pvzQoWbzvT2w22YxyY9gyZnD+SzNmBXq3fyUS0yH2mkRrQAZopuw+fEmbfc/PJ2S1YxAPHl1XPbj46PI00lqK8G1d1dhwbARWmQVDgS8gpGp8tpqjt6b64jcnyeEyaLAK+LsOcGZcDlBwrFq9iijKvg29ZvFguOodUTlHvfyJ4lW+NKvNH1hCq5MdGycc/87cdpp6SfGKPUdT1R7gH+Obapt2ii9sFXAbT6m3MeUVPI2GCvKSdOgfJGRmyoDb+Al+yAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39850400004)(376002)(396003)(346002)(6916009)(6706004)(478600001)(83380400001)(2906002)(5660300002)(6666004)(38100700002)(956004)(16526019)(186003)(26005)(16576012)(316002)(31686004)(66946007)(66556008)(8676002)(66476007)(2616005)(86362001)(31696002)(8936002)(36756003)(6486002)(14143004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RbU6/WgMjX0DvWb8mhpQFm0SJai3YB5bZHwwFRgVfrBVlYt/IC7OFn7FVGkE?=
 =?us-ascii?Q?+onVH6h0Zf7bTnYx0ozeynVHOJ3EXJYdYW/pP1nNjt0ey7vgvzX6j3QWR3QJ?=
 =?us-ascii?Q?UNZQ7fN9a4lVMlAXfWZ30/FO0/aKrVkSeE05YSA7t8VAWoMxPTvp5fsWY5bL?=
 =?us-ascii?Q?LBkrQIBVZvnK0QEjHY80e0T87O15tDWYaHHkh8wKoFQpA2kdXieWJCnFBBHm?=
 =?us-ascii?Q?/3fleQEhgVYsNkaK42r6tKc9vKnX/pRFimyBpmO1CRZ8SdzoCV6kIak3skfV?=
 =?us-ascii?Q?ZeieQtsiTg8y/tpr0bKedFxGLJqzmPP+SZ4nnKFdl02zLKIN0fU2earHXwqc?=
 =?us-ascii?Q?WSYXnImBMrOasOy8Y6wqOQkTmolIf5yy4awMaDuUhH5v6RsJq4jWJWTKAFDo?=
 =?us-ascii?Q?HK/B8jVjJtB0LtZ0AVKZSwShTji728/IHrYztYfdm0KQkcGjJASJ2SfNbhD2?=
 =?us-ascii?Q?QWuX5uqZROVRo1JwsPmfos4V2l/x2AiQroAkuPE2erZTFX9IrbHQIN4A9gyj?=
 =?us-ascii?Q?oJaHYD9i/SvEtHByAJ0riX4OXDWxT+itFeMek17C2q/umgprtRZblC6nXQs/?=
 =?us-ascii?Q?Gw5kANHBFAKM+FT7teLxOmmA3p5iP2Q46aEjBJ9E57SfU4hmh2Ju1RNZkeYb?=
 =?us-ascii?Q?A80jOmIAsUyAQPJDgHTnyKIGOgVa7ic2bM+VDm1yvjxj0n3IBeDC711yCsyf?=
 =?us-ascii?Q?zBMfdejpujn+w/UE4U96or3m/u/CE7N4GyxfGNVRH4LRANTwpbsDlsBfJI48?=
 =?us-ascii?Q?QKhd82q7KEoS7Gcs1ImBwBsmECqiRMqHu7rNFKrLHRe/nH3fSFBjpRdkDkyD?=
 =?us-ascii?Q?+qv4EevN0qZUbR5CDLPqOpFKSaDYCLjlojZBbscE5DDET05Otz1npXF2i3WQ?=
 =?us-ascii?Q?VSbckX+4qIoX9/ZZLAwDxOOWjJ7cH0/Jz4k2JAQmDYXQRDB4vao1fBkkjS5S?=
 =?us-ascii?Q?GkivoFcfgb0X+VNOiRePVsfmo6tM7hgyL1/d+wbvFcmxzc1YaR2TUKhauDmt?=
 =?us-ascii?Q?HtpwLVmtwHwi+D0/wmuxZAmvuyl8Jlzmfxbl05z9LFoMVyO1CR29909NVWjt?=
 =?us-ascii?Q?WOocrK1DU9JWcqPDswdF4u4W/ue+S2QvmW0EEF6TY9ESPydfEcttlgLyjTQ8?=
 =?us-ascii?Q?cYo8LZc831R6vwWWRQdhXncokxKUeyKqW/xL3aequSkdQIkcDug+PtfDenSj?=
 =?us-ascii?Q?vCSJD89bgDQbIxT9Uf1a1Zrg/GGtaP8MDTckIOzas57OqO1vcuxWAsQxQDV1?=
 =?us-ascii?Q?JST0fG+t6ZHDjzGhsReKvg1MRhokozpY0gV1YppdOB8P8hf1LRw7VOmUChqi?=
 =?us-ascii?Q?X/SqT+UYRdRzoNu9GO7Q08tp?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70cf70d-7d72-4aae-17f9-08d9276945a1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 14:58:54.5210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUugfrMJiyXv0QDEudqGLaxy37gsuORqxokYn7+Kscnbl/HDIJ1SuyyYXxXDgscJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4967
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/31 =E4=B8=8B=E5=8D=884:50, Qu Wenruo wrote:
> __extent_writepage_io() function originally just iterate through all the
> extent maps of a page, and submit any regular extents.
>=20
> This is fine for sectorsize =3D=3D PAGE_SIZE case, as if a page is dirty,=
 we
> need to submit the only sector contained in the page.
>=20
> But for subpage case, one dirty page can contain several clean sectors
> with at least one dirty sector.
>=20
> If __extent_writepage_io() still submit all regular extent maps, it can
> submit data which is already written to disk.
> And since such already written data won't have corresponding ordered
> extents, it will trigger a BUG_ON() in btrfs_csum_one_bio().
>=20
> Change the behavior of __extent_writepage_io() by finding the first
> dirty byte in the page, and only submit the dirty range other than the
> full extent.
>=20
> Since we're also here, also modify the following calls to be subpage
> compatible:
> - SetPageError()
> - end_page_writeback()
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 100 ++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 95 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 439aace2f5e0..1909979d41de 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3783,6 +3783,74 @@ static noinline_for_stack int writepage_delalloc(s=
truct btrfs_inode *inode,
>   	return 0;
>   }
>  =20
> +/*
> + * To find the first byte we need to write.
> + *
> + * For subpage, one page can contain several sectors, and
> + * __extent_writepage_io() will just grab all extent maps in the page
> + * range and try to submit all non-inline/non-compressed extents.
> + *
> + * This is a big problem for subpage, we shouldn't re-submit already wri=
tten
> + * data at all.
> + * This function will lookup subpage dirty bit to find which range we re=
ally
> + * need to submit.
> + *
> + * Return the next dirty range in [@start, @end).
> + * If no dirty range is found, @start will be page_offset(page) + PAGE_S=
IZE.
> + */
> +static void find_next_dirty_byte(struct btrfs_fs_info *fs_info,
> +				 struct page *page, u64 *start, u64 *end)
> +{
> +	struct btrfs_subpage *subpage =3D (struct btrfs_subpage *)page->private=
;
> +	u64 orig_start =3D *start;
> +	u16 dirty_bitmap;
> +	unsigned long flags;
> +	int nbits =3D (orig_start - page_offset(page)) >> fs_info->sectorsize;

Embarrassing bug here.
The right shift should be ">> fs_info->sectorsize_bits".

But more ironically, it masks the extra bugs, now the function just=20
check the bitmap bit by bit, skipping the more bugs below:

> +	int first_bit_set;
> +	int first_bit_zero;
> +
> +	/*
> +	 * For regular sector size =3D=3D page size case, since one page only
> +	 * contains one sector, we return the page offset directly.
> +	 */
> +	if (fs_info->sectorsize =3D=3D PAGE_SIZE) {
> +		*start =3D page_offset(page);
> +		*end =3D page_offset(page) + PAGE_SIZE;
> +		return;
> +	}
> +
> +	/* We should have the page locked, but just in case */
> +	spin_lock_irqsave(&subpage->lock, flags);
> +	dirty_bitmap =3D subpage->dirty_bitmap;
> +	spin_unlock_irqrestore(&subpage->lock, flags);
> +
> +	/* Set bits lower than @nbits with 0 */
> +	dirty_bitmap &=3D ~((1 << nbits) - 1);
> +
> +	first_bit_set =3D ffs(dirty_bitmap);
> +	/* No dirty range found */
> +	if (first_bit_set =3D=3D 0) {
> +		*start =3D page_offset(page) + PAGE_SIZE;
> +		return;
> +	}
> +
> +	ASSERT(first_bit_set > 0 && first_bit_set <=3D BTRFS_SUBPAGE_BITMAP_SIZ=
E);
> +	*start =3D page_offset(page) + (first_bit_set - 1) * fs_info->sectorsiz=
e;
> +
> +	/* Set all bits lower than @nbits to 1 for ffz() */
> +	dirty_bitmap |=3D ((1 << nbits) - 1);

This is a bigger bug, from now on, we're searching for the first zero,=20
after @first_bit_set, not nbits.

This would lead to later @first_bit_zero smaller than @first_bit_set if=20
we have a small hole in the page.
> +
> +	first_bit_zero =3D ffz(dirty_bitmap);
> +	if (first_bit_zero =3D=3D 0 || first_bit_zero > BTRFS_SUBPAGE_BITMAP_SI=
ZE) {
> +		*end =3D page_offset(page) + PAGE_SIZE;
> +		return;
> +	}
> +	ASSERT(first_bit_zero > 0 &&
> +	       first_bit_zero <=3D BTRFS_SUBPAGE_BITMAP_SIZE);
> +	*end =3D page_offset(page) + first_bit_zero * fs_info->sectorsize;
> +	ASSERT(*end > *start);

And then triggering this ASSERT().

I'll send out a diff upon this patch, after extra tests are done.

Thanks,
Qu
> +}
> +
>   /*
>    * helper for __extent_writepage.  This calls the writepage start hooks=
,
>    * and does the loop to map the page into extents and bios.
> @@ -3830,6 +3898,8 @@ static noinline_for_stack int __extent_writepage_io=
(struct btrfs_inode *inode,
>   	while (cur <=3D end) {
>   		u64 disk_bytenr;
>   		u64 em_end;
> +		u64 dirty_range_start =3D cur;
> +		u64 dirty_range_end;
>   		u32 iosize;
>  =20
>   		if (cur >=3D i_size) {
> @@ -3837,9 +3907,17 @@ static noinline_for_stack int __extent_writepage_i=
o(struct btrfs_inode *inode,
>   							     end, 1);
>   			break;
>   		}
> +
> +		find_next_dirty_byte(fs_info, page, &dirty_range_start,
> +				     &dirty_range_end);
> +		if (cur < dirty_range_start) {
> +			cur =3D dirty_range_start;
> +			continue;
> +		}
> +
>   		em =3D btrfs_get_extent(inode, NULL, 0, cur, end - cur + 1);
>   		if (IS_ERR_OR_NULL(em)) {
> -			SetPageError(page);
> +			btrfs_page_set_error(fs_info, page, cur, end - cur + 1);
>   			ret =3D PTR_ERR_OR_ZERO(em);
>   			break;
>   		}
> @@ -3854,8 +3932,11 @@ static noinline_for_stack int __extent_writepage_i=
o(struct btrfs_inode *inode,
>   		compressed =3D test_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
>   		disk_bytenr =3D em->block_start + extent_offset;
>  =20
> -		/* Note that em_end from extent_map_end() is exclusive */
> -		iosize =3D min(em_end, end + 1) - cur;
> +		/*
> +		 * Note that em_end from extent_map_end() and dirty_range_end from
> +		 * find_next_dirty_byte() are all exclusive
> +		 */
> +		iosize =3D min(min(em_end, end + 1), dirty_range_end) - cur;
>  =20
>   		if (btrfs_use_zone_append(inode, em->block_start))
>   			opf =3D REQ_OP_ZONE_APPEND;
> @@ -3885,6 +3966,14 @@ static noinline_for_stack int __extent_writepage_i=
o(struct btrfs_inode *inode,
>   			       page->index, cur, end);
>   		}
>  =20
> +		/*
> +		 * Although the PageDirty bit is cleared before entering this
> +		 * function, subpage dirty bit is not cleared.
> +		 * So clear subpage dirty bit here so next time we won't
> +		 * submit page for range already written to disk.
> +		 */
> +		btrfs_page_clear_dirty(fs_info, page, cur, iosize);
> +
>   		ret =3D submit_extent_page(opf | write_flags, wbc,
>   					 &epd->bio_ctrl, page,
>   					 disk_bytenr, iosize,
> @@ -3892,9 +3981,10 @@ static noinline_for_stack int __extent_writepage_i=
o(struct btrfs_inode *inode,
>   					 end_bio_extent_writepage,
>   					 0, 0, false);
>   		if (ret) {
> -			SetPageError(page);
> +			btrfs_page_set_error(fs_info, page, cur, iosize);
>   			if (PageWriteback(page))
> -				end_page_writeback(page);
> +				btrfs_page_clear_writeback(fs_info, page, cur,
> +							   iosize);
>   		}
>  =20
>   		cur +=3D iosize;
>=20


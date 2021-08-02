Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19EE3DD3AC
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Aug 2021 12:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhHBK2A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Aug 2021 06:28:00 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:40968 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233308AbhHBK2A (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Aug 2021 06:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1627900069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OFC4Et367TNgnYLg7hoYuYldvPcmDDK6bynSB8JPywA=;
        b=R+RePmaJQoTl3LPG+LoFZCmgey3Z2A2nsRvcpiRVN69UGcJbaDZEr7ENHMYhhDxWa49T1r
        Oix+X+4r9I4x9LOM0HMXLEmDLiCQWpfejIIvuw6odAVUNGjz6CTJ/vg7dyyz8uL/hhBI4P
        kTRW2uxKhSHiB4IiJJuS8K8zJwgHKD4=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-22-5YF_tAV2PgykIp_sfyyExg-1; Mon, 02 Aug 2021 12:27:48 +0200
X-MC-Unique: 5YF_tAV2PgykIp_sfyyExg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kA8j6WXj3dPthrh/dLcVkag4Xrwzieyl+K/ULwgwWjhtqcZLKvpss8ddvKy19CtuU5mg1tuLWzuU2guj0xBCZM1zaZdFVHygraz8akuhMnI2KvmhtGp42JtRnyfaPxM2PpnmJk0asgM7wOBYcqas/UVtbOKR2Yn9Vf/SKGx7FIxFQymKPYNqYDgbaFF4pjUPx4wvmFGI2Xt63pTLsl/4MtTnvlLM9ytLspwPl2bpB31Je+bVu2z72WElAxrrspKR3rYHcFn8J06UNEM3qp71ilh8BVlz+OZaOAZmR7vZzoN7RRnu5OJRUJDU0YBZTwttxUw8K8oia5rLokJ6GWA7Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZIISmCHQXnnTX/S+sNvKq33Tlxri9a4p1ZXs8S8GA8=;
 b=IBeVy40SRIdlHPwALKqx8L/pIaaK2PcQif1FkGJlO9IfJvSfLSThcymnY+cQvnnKLYoivy4O+jLjDfVovTC7RppKQUoOjv4i+Ai1htBG1geJ1CuKX28fFkifJ5PAc81h0uOO/yAI0WlEzLihihnDGuIY9JZxnZ19gofMBQuHJVZtXazKsrAWIl4zo1zEuf/3mq9c0x9nUKW/dNWWPjLWaC4bVzXVz3qpqvyNNQJoPJhQ4hJPOiuQq1tuThNSjwg2tNDvdeAIM6YAlZg10NNSsbr9nVhyAp5MP2jx3lT0J+oZ+7ccJxcOAM9xQvYngTeRih0VPXPQuEar1mi6VHtRKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB8167.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 10:27:47 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 10:27:47 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210723060657.198883-1-wqu@suse.com>
Subject: Re: [PATCH v2] btrfs: unify the error pathes in __extent_writepage()
 for subpage and regular sectorsize
Message-ID: <3c7d2da3-5038-3737-bf9f-c31106ca7767@suse.com>
Date:   Mon, 2 Aug 2021 18:27:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210723060657.198883-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0155.namprd05.prod.outlook.com
 (2603:10b6:a03:339::10) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0155.namprd05.prod.outlook.com (2603:10b6:a03:339::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.10 via Frontend Transport; Mon, 2 Aug 2021 10:27:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 834169e2-95c0-4fca-37ea-08d955a02bfa
X-MS-TrafficTypeDiagnostic: AS8PR04MB8167:
X-Microsoft-Antispam-PRVS: <AS8PR04MB81679646E64AA084860A502BD6EF9@AS8PR04MB8167.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXU2TPZCGC3DAhIMmdleF9Q4+LkBjdMkGLg5d19h13+zTFQtpEetcPms18r0KpH/8nMZZhAn9pVJT7a2AFqel8mAetNQi9PLZzZBwX8v0OWt5teGHbOnwFtsTITMG2B5eKQyWa5mXzVeEekUJFO96pFxqEw7QxYC/fHbJ5WILvwMNHYJwgzLF6IqGMJd4IPKM+ynq0558Pf274/mTe9iJXrZBOiHzbZjQTnfXHC+4CCWimcz5eD7sdw3T8yDhgonuiX1U379PI/hxe2XrB7EiWHlflr+tlmqH1ORXbxKsBLh3ZUzZMB9ORjou/gfX8o1mtu9FT7ShNLacIN+BCa45yFCUHcM+3po4gRTNJD5dlUXa7zyCkpeHGp4/1+n6C4z5I6nvAsDy+o39RZMceevRVBmsf582kxz+VCAjZuSMNZ9ktK/6EPEUKr1mOrXVTjVbKRjKMgE5idKLNOlWSxRWEap1ABQRMXhuacOnv6GGTAPzD07g18r94m4N2BQEFQvOvCJJ0kqlwEj4+DfCOEoDa/rzBfnfnOuUDr0EGF4VD4H7ipm7i6OILStBF9FjSFHUnpphVU0MO3HyaQ5GzAGRMe3LFlS9R7FM27mpgGyHP1kUZvIaOXAgEXIYuj7EmVeocH3K5s/fmMMALiK+csH6FuSuLPfj7Iy1Buy2UpACDjNCeClI8CnjWDSGRcJOXrzz6SVcptzI75UX6d7vOCkVsRMH6IIj/bEWH8KjeFwb2hCx1RAUhcFNjHaiylwVsjn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39850400004)(366004)(396003)(38100700002)(478600001)(31696002)(6486002)(6916009)(6706004)(2616005)(956004)(2906002)(86362001)(316002)(6666004)(186003)(66476007)(66556008)(8676002)(8936002)(66946007)(26005)(36756003)(83380400001)(31686004)(5660300002)(16576012)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6TCDEa3bUq81RqXWzHI87h2rnN92aJfmhNtycMsgxkkogtQdU3m79t9ou4GX?=
 =?us-ascii?Q?So0suyICR9cRVN8aDo9cMsXGrlrsGt4DCA6RL5Vb2lxXpfJQPgHt5o9dIPi7?=
 =?us-ascii?Q?qYwJW4Xouwn0PY6O3Ac18zSJd9o6/7CTGRUS5dLAConf8m/sinOYMULGVfbI?=
 =?us-ascii?Q?xi9f7mGUiPRKKTuJ21sofZZYcdqhGGJN6OkVLhvALFDOcmMhPMOHGm2/XBAr?=
 =?us-ascii?Q?HmEVcyJ+aAIqbblrV4pZbYTRGEJw50V1ft68Qgh8BoGQiMLL/UWEmd3QzVb+?=
 =?us-ascii?Q?uNmcWdOjtgtb/MT0cGQZV5lEA/XYD+HdKhhtAJDVsTu8gPHsdXVYxW3hxF6T?=
 =?us-ascii?Q?iw2/0iboeG22Ut4YFRDXr6EQ7CacjO36ReaCrq1aPARbrOzgBoB4sqIMePbv?=
 =?us-ascii?Q?UxkqVrj1kZ+k/Gg97VoNbRbQHSnyBx4/v5nSFvbUDa3JS02+Fdbe2vSmf0HB?=
 =?us-ascii?Q?qaEES1cuoInYq2rhH6FZ6hIDk3/pw2DYXJZuMrikR7Q5cp/5biUfheb1rlX4?=
 =?us-ascii?Q?jHCdo2aw14Uz6aPyMcZlKubJNx4CstLCw1x2AuPLBi4qyhP+k2Wc9+o53pbj?=
 =?us-ascii?Q?WpLhfaINLFwYdCWfxOEQ7SwVfvLEsK1JvuG7djqnwDKQs7gl8IkBe5VnQrTa?=
 =?us-ascii?Q?4Mdwp43PfMD2hvkwOJSggJX3FfFC6Hdz+GPLfcWwi9ltdtPeiICO5BxpEhE+?=
 =?us-ascii?Q?VHcNL3fHKAJh1AKDl/k24vdA9CmCFn7gpKck2YAWKnuUl2pSQoTMHrUG3JRv?=
 =?us-ascii?Q?ZqdTv7ioDSpM31ZBuD71MjqMpod/rX3sP6sVjeHGvaE2kVX6yUMcuEtCXYbj?=
 =?us-ascii?Q?rlzpdFXj+txfKsib7vdkizYLppfqfLtyw+2Fh/cNiRRXDq/R6qr8Qty2Q1Uu?=
 =?us-ascii?Q?w68eZhwzNYkV/gjvqXgQCTdXgEXVeRb7tm7up+CWqo/lUmsfoTLSYr71NcNE?=
 =?us-ascii?Q?hLkN3ut4NstIxpgwvaaDzzkvRlmu9Ia8NMsOXSza1B/OMUj7cY5SwloY5pl0?=
 =?us-ascii?Q?6am/rrT4A/3FD4K2F1xGvWa8Zic2AGznJpuz+1yl7FPS7ZmnftzdyiHGCtzx?=
 =?us-ascii?Q?Wrz1p7OsPv0XzGFaueohi9knYTom/Ka1jEOSTwUBubbIzjDFYkHP07/jNfIH?=
 =?us-ascii?Q?yzs5hDQrh1rqugqVmlgR1L2LLGSnx2+cmiPdLp9wq42RcHxuAQMzXbLQgFxC?=
 =?us-ascii?Q?hQO0LgR9MmZz8LkcYu386wb/QhiB55T8lybJSfmGf3UoimmLTknXJ33CEV6m?=
 =?us-ascii?Q?R0MTeWnFMY4Ezr6pMstzelNNdPXKRwuiFNQJQqCc+7AlI/qY8C63pBBSfBFr?=
 =?us-ascii?Q?XY2zCTYoeS8NxDaFnj1141wA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 834169e2-95c0-4fca-37ea-08d955a02bfa
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 10:27:47.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9a9E81B2d1ba0kAHhhFFLJx5FibjtaGExwaLXyEt+z1WxPmck1Y25hZxfxIl1qp5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8167
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/23 =E4=B8=8B=E5=8D=882:06, Qu Wenruo wrote:
> [BUG]
> When running btrfs/160 in a loop for subpage with experimental
> compression support, it has a high chance to crash (~20%):
>=20
>   BTRFS critical (device dm-7): panic in __btrfs_add_ordered_extent:238: =
inconsistency in ordered tree at offset 0 (errno=3D-17 Object already exist=
s)
>   ------------[ cut here ]------------
>   kernel BUG at fs/btrfs/ordered-data.c:238!
>   Internal error: Oops - BUG: 0 [#1] SMP
>   pc : __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
>   lr : __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
>   Call trace:
>    __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
>    btrfs_add_ordered_extent+0x2c/0x50 [btrfs]
>    run_delalloc_nocow+0x81c/0x8fc [btrfs]
>    btrfs_run_delalloc_range+0xa4/0x390 [btrfs]
>    writepage_delalloc+0xc0/0x1ac [btrfs]
>    __extent_writepage+0xf4/0x370 [btrfs]
>    extent_write_cache_pages+0x288/0x4f4 [btrfs]
>    extent_writepages+0x58/0xe0 [btrfs]
>    btrfs_writepages+0x1c/0x30 [btrfs]
>    do_writepages+0x60/0x110
>    __filemap_fdatawrite_range+0x108/0x170
>    filemap_fdatawrite_range+0x20/0x30
>    btrfs_fdatawrite_range+0x34/0x4dc [btrfs]
>    __btrfs_write_out_cache+0x34c/0x480 [btrfs]
>    btrfs_write_out_cache+0x144/0x220 [btrfs]
>    btrfs_start_dirty_block_groups+0x3ac/0x6b0 [btrfs]
>    btrfs_commit_transaction+0xd0/0xbb4 [btrfs]
>    btrfs_sync_fs+0x64/0x1cc [btrfs]
>    sync_fs_one_sb+0x3c/0x50
>    iterate_supers+0xcc/0x1d4
>    ksys_sync+0x6c/0xd0
>    __arm64_sys_sync+0x1c/0x30
>    invoke_syscall+0x50/0x120
>    el0_svc_common.constprop.0+0x4c/0xd4
>    do_el0_svc+0x30/0x9c
>    el0_svc+0x2c/0x54
>    el0_sync_handler+0x1a8/0x1b0
>    el0_sync+0x198/0x1c0
>   ---[ end trace 336f67369ae6e0af ]---
>=20
> [CAUSE]
> For subpage case, we can have multiple sectors inside a page, this makes
> it possible for __extent_writepage() to have part of its page submitted
> before returning.
>=20
> In btrfs/160, we are using dm-dust to emulate write error, this means
> for certain pages, we could have everything running fine, but at the end
> of __extent_writepage(), one of the submitted bios fails due to dm-dust.
>=20
> Then the page is marked Error, and we change @ret from 0 to -EIO.
>=20
> This makes the caller extent_write_cache_pages() to error out, without
> submitting the remaining pages.
>=20
> Furthermore, since we're erroring out for free space cache, it doesn't
> really care about the error and will update the inode and retry the
> writeback.
>=20
> Then we re-run the delalloc range, and will try to insert the same
> delalloc range while previous delalloc range is still hanging there,
> triggering the above error.
>=20
> [FIX]
> The proper fix is to make btrfs handle errors from __extent_writepage()
> properly, by ending the remaining ordered extent.
>=20
> But that fix needs the following refactors:
>=20
> - Know at eaxctly which sector the error happened
>    Currently __extent_writepage_io() works for the full page, can't
>    return at which sector we hit the error.
>=20
> - Grab the ordered extent covering the failed sector
>=20
> As a hotfix for subpage case, here we unify the error pathes in
> __extent_writepage().
>=20
> In fact, the "if (PageError(page))" branch never get executed if @ret is
> still 0 for non-subpage cases.
>=20
> As for non-subpage case, we never submit current page in
> __extent_writepage(), but only add current page into bio.
> The bio can only get submitted in next page.
>=20
> Thus we never get PageError() set due to IO failure, thus when we hit
> the branch, @ret is never 0.
>=20
> By simplying removing that @ret assignment, we let subpage case to
> ignore the IO failure, thus only error out for fatal errors just like
> regular sectorsize.
>=20
> So that IO error won't be treated as fatal error not trigger the hanging
> OE problem.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> For the proper fix, I pupose to change how we run delalloc range.
>=20
> Currently we call writepage_delalloc() for every page we're going to
> write, but it only really get executed for the first page of a contig
> range.
>=20
> I hope to change the workflow to something more like async cow:
> - Run delalloc range
>    But keeps all the page still locked
>=20
> - Submit pages for the delalloc range
>    Set each sector writeback and unlock the sector after adding it to
>    bio.
>=20
> So that we can know exactly the delalloc range is, and where the error
> happens when submitting bio.
>=20
> The only down side is btrfs_invalidatepage().
> Previously btrfs_invalidatepage() can invalidate a page which is covered
> by ordered extent, but not yet being added to a bio.
>=20
> Now we have to wait for the writeback to finish before doing
> invalidating.
>=20
> Changelog:
> v2:
> - Make error handling in end_extent_writepage() to be subpage compatible
> - Update the commit message and add new comment for why it's safe
>    to remove the @ret assignment
> ---
>   fs/btrfs/extent_io.c | 51 ++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 44 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 248f22267665..543f87ea372e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2789,8 +2789,14 @@ void end_extent_writepage(struct page *page, int e=
rr, u64 start, u64 end)
>   	btrfs_writepage_endio_finish_ordered(inode, page, start, end, uptodate=
);
>  =20
>   	if (!uptodate) {
> -		ClearPageUptodate(page);
> -		SetPageError(page);
> +		const struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> +		u32 len;
> +
> +		ASSERT(end + 1 - start <=3D U32_MAX);
> +		len =3D end + 1 - start;
> +
> +		btrfs_page_clear_uptodate(fs_info, page, start, len);
> +		btrfs_page_set_error(fs_info, page, start, len);
>   		ret =3D err < 0 ? err : -EIO;
>   		mapping_set_error(page->mapping, ret);
>   	}
> @@ -3795,7 +3801,8 @@ static noinline_for_stack int writepage_delalloc(st=
ruct btrfs_inode *inode,
>   		ret =3D btrfs_run_delalloc_range(inode, page, delalloc_start,
>   				delalloc_end, &page_started, nr_written, wbc);
>   		if (ret) {
> -			SetPageError(page);
> +			btrfs_page_set_error(inode->root->fs_info, page,
> +					     page_offset(page), PAGE_SIZE);
>   			/*
>   			 * btrfs_run_delalloc_range should return < 0 for error
>   			 * but just in case, we use > 0 here meaning the IO is
> @@ -4071,7 +4078,8 @@ static int __extent_writepage(struct page *page, st=
ruct writeback_control *wbc,
>  =20
>   	WARN_ON(!PageLocked(page));
>  =20
> -	ClearPageError(page);
> +	btrfs_page_clear_error(btrfs_sb(inode->i_sb), page,
> +			       page_offset(page), PAGE_SIZE);
>  =20
>   	pg_offset =3D offset_in_page(i_size);
>   	if (page->index > end_index ||
> @@ -4112,10 +4120,39 @@ static int __extent_writepage(struct page *page, =
struct writeback_control *wbc,
>   		set_page_writeback(page);
>   		end_page_writeback(page);
>   	}
> -	if (PageError(page)) {
> -		ret =3D ret < 0 ? ret : -EIO;
> +	/*
> +	 * Here we used to have a check for PageError() and then set @ret and
> +	 * call end_extent_writepage().
> +	 *
> +	 * But in fact setting @ret here will cause different error paths
> +	 * between subpage and regualr sectorsize.
> +	 *
> +	 * For regular page size, we never submit current page, but only add
> +	 * current page to current bio.
> +	 * The bio submission can only happen in next page.
> +	 * Thus if we hit the PageError() branch, @ret is already set to
> +	 * non-zero value and will not get updated for regular sectorsize.
> +	 *
> +	 * But for subpage case, it's possible we submit part of current page,
> +	 * thus can get PageError() set by submitted bio of the same page,
> +	 * while our @ret is still 0.
> +	 *
> +	 * So here we unify the behavior and don't set @ret.
> +	 * Error can still be properly passed to higher layer as page will
> +	 * be set error, here we just don't handle the IO failure.
> +	 *
> +	 * NOTE: This is just a hotfix for subpage.
> +	 * The root fix will be properly ending ordered extent when we hit
> +	 * an error during writeback.
> +	 *
> +	 * But that needs a much bigger refactor, as we not only need to
> +	 * grab the submitted OE, but also needs to know exactly at which
> +	 * bytenr we hit an error.
> +	 * Currently the full page based __extent_writepage_io() is not
> +	 * capable for that.
> +	 */
> +	if (PageError(page))
>   		end_extent_writepage(page, ret, start, page_end);

Well, it turns out, this end_extent_writepage() is causing more problem=20
than I thought.


If we have some page layout like this:

0		32K		64K
|/////|		|////|
\- Extent A	\- Extent B.

When Extent A get submitted and IO failed, the page will have PageError set=
.

Then Extent B get submitted without problem.

But since PageError is set, we will call end_extent_writepage() for the=20
whole page.

Which will call btrfs_mark_ordered_io_finished() to cleanup the ordered=20
extent.

If btrfs_mark_ordered_io_finished() happens before the endio of Extent=20
B, it will finish the Ordered IO for extent B, now ordered extent B will=20
be removed from the io extent tree.

Then the bio get submitted, we will call btrfs_csum_one_bio(), but since=20
the ordered extent B has been removed, we trigger a BUG_ON() inside=20
btrfs_csum_one_bio.


This means, we should not mix the IO error with submission error.

In __extent_writepage() what we're really doing is just bio assembly and=20
submission, we should not bother if the IO failed.

I will craft a proper patch mostly for the commit message and error analyse=
.

But this really show one thing: immature error handling is more buggy=20
than we thought.

Thanks,
Qu
> -	}
>   	unlock_page(page);
>   	ASSERT(ret <=3D 0);
>   	return ret;
>=20


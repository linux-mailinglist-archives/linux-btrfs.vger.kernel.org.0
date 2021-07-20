Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2892E3CF8CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Jul 2021 13:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhGTKqv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Jul 2021 06:46:51 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:56633 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237388AbhGTKqf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Jul 2021 06:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1626780429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=anJZ58gz4h76sZxzpO+9vDT8UOAsOIyKuf87DUWDHJs=;
        b=JwMximchXxcNBCzL4sC7vLlYCr8hQfxAH3D2VGgYQSroaRGAnL+v/Gl4lmPuoP3SGsj+zR
        XlGe/SeydyhnLRp0MarEZMy1BxVBTWGnOFs2jpwD0uItawsT0p/ohAv9R6hBuGn02Yrhqi
        Gr+rT/IVeAucEQKqaHGp1OXhWUoDkgI=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2058.outbound.protection.outlook.com [104.47.14.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-13-JGWBYQX2PtuoGqpA46cIdA-1; Tue, 20 Jul 2021 13:27:07 +0200
X-MC-Unique: JGWBYQX2PtuoGqpA46cIdA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCPTtzj8UehJXSMddeFQHv3zZSBgzvuFYaAZTMOc2iOJao2RXpOHp1JO/JIYJ9MWdbxT8tOhxKde7oT0Efh48+LygZKphC2bREknHMF2eutSWagMP3v45On4eTXwiJCuATtpHTmEU40GZ/hjvX89xc6IpOVk2+dF/Hsy+/S5V2ffFnqhzOlESknlyqDn+upSSOdLEQBXuNalskeYPGN2vEtp9fJ8pn2ovzkPwYraTC6irx+D2qCSO7gcbcl05ubRYoSXrwGxfxvoMgxFSbusMF6jBaqvUQnAaPB3evs8njLwjlG6YvMjOD8plD+pvdtfCUzWlk9YWP2pMLuz8oGiyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8u1snGhGQLllmODy8AbWMxRlX9R+LxrBjq0HWR9ExE=;
 b=GCtopG/s8DDofuaTmGaRGo9pskJTzylONiW+nrT6bx40QYM//okk/zWkNj51icRcxoCwlfqq4N1hBuMczecJZ0GPMzkOhoxM9R6UU/D5g4SpGbnCd9Bg2Id/A71ihJFBQ0dLcm6n0/itSSqqlio/xu5ddpkAUZ/XA6PD5BV5TToVsMn5Bo7V9WZNDvv02ASakgDoaGBMKgWuSoYOjqTu5S/cgj6jawscYeqmpYm/E4wygHEjRCunJDzTnexFm+FXrvU58cIhAPuVEvgDTO/GtkDIxdGt3AK4gOgImu0kSkxg3jOa0fGn89EFcKerQM6QHXyReHlWT785rMjXPoReeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB5814.eurprd04.prod.outlook.com (2603:10a6:20b:a8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Tue, 20 Jul
 2021 11:27:07 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::816b:1f6a:c279:1b65%3]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 11:27:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210720065645.197453-1-wqu@suse.com>
Subject: Re: [PATCH RFC] btrfs: handle the added ordered extent when bio
 submission fails
Message-ID: <a1857df6-a37b-f164-2bee-a9bb7cda3857@suse.com>
Date:   Tue, 20 Jul 2021 19:26:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210720065645.197453-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::11) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0246.namprd03.prod.outlook.com (2603:10b6:a03:3a0::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 11:27:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc37ecbe-cff4-4ab9-cd23-08d94b714e5e
X-MS-TrafficTypeDiagnostic: AM6PR04MB5814:
X-Microsoft-Antispam-PRVS: <AM6PR04MB5814DE2E3F7991B2DDF124F5D6E29@AM6PR04MB5814.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3r6wTck/IIsUZ/P63fKGcgBeEYjdqM1lXCpxUp1b9NlCnMkQnbRyH1UQ6ahfFu6MdETNmBq/OksZAQRg631rU0ow+ynm+WBJJgWqzfzGcntbjacSC6ASOtgTWzJBfWZ4mi/j7DX002dg6Uyd109LhOVLA/1kXOPC76HYzpNTL795wZAwBTobvYVGDpdiMhAls3PTx4I49taBqhM7DouQG5jNzC9uCDzJUuBeEOillOY1VJA5a58LH9LtAdtXxILQ70xXDr0ZhV1MwglkaJFxbEkTRlunWr2gDUXQ2gD6lzqWue0xaMkGE8z6Fiku/8oZefD68N/I0mGHm56cxcJkBvclYeJhyihGtl/ljpmc6qvNUboxJEmqOZqVNeh0e5NlVbQJab8O1fPYg26ni9E9xl//xfiu16ttpi06pbTKMXJa3wWH6gXrX5Y8tYw7GEN7ekzjMpcJ4l0qDpoWCUxShRaWqXYogr6K1WwNC2crIf51Hj8pgtI0RyMg0gE8Kb2ClrnnAvfJEU45I3fhcVjBueY2btF6EPMTWKFyWlPeVcWXpsuYCiN4aJynk3BLebUxH5+eSXKz3Fjh97hZHGhBPsBP6bmQVOFTRnIJLYIKSGhzauB29jhmjv64IgQWXaLxVbkZj+HvHG7u32nq9wxnfYbsIzqbEuzvNj8SZn9JRE8g86CnLPskLpI42AGHqD11gS+74Spmfw0ClT3YaW6mXHeTUCwOVitLKN3vu+eH0yl+cCjUDvRQUn+teQPw3DB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(396003)(366004)(376002)(39860400002)(26005)(31696002)(316002)(6666004)(8936002)(86362001)(16576012)(186003)(83380400001)(6706004)(2906002)(956004)(2616005)(6916009)(66476007)(66556008)(66946007)(8676002)(478600001)(5660300002)(31686004)(38100700002)(6486002)(36756003)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s02Sr8EX00BOd4QQVyHzF7ewkt7GMieYBAgezjHL0qmeEF1r+i458Y/hJEYe?=
 =?us-ascii?Q?zM+Pt5wdPiXisFXmruFFKl0Ya3QWsFDi6DCK391tunvdf0wX8wUeZoGYmoGr?=
 =?us-ascii?Q?nI07IdYKfXoN08s1edRnhSzM2EifjLLXv0YVBgcjvksD401zsr48ecb00yf6?=
 =?us-ascii?Q?IlJFgK24WSCCMRYTy5W23wM22p64Tza1b2fwi5O1LXVi7HhisSEXU4IgR9U0?=
 =?us-ascii?Q?7rp56RLYuLUCl++5rwaVEM8egYitOILzhKhZVYf7iN7r7hfnJU4HmHs4TbIU?=
 =?us-ascii?Q?IRF0k+Tx9uG2iQEScnMOIHHMUtgiaR+hwzbZUvSGlhFFryRGK+biUXTiy65s?=
 =?us-ascii?Q?IqSkJREusMta3rTtEw8oAEKJiet0D9hIItmAn7kqYil9VlWO/C7bKEEXLprY?=
 =?us-ascii?Q?x5aAN44IfJIRoy3FlP3MU4wOC4tbBl6owWqigpJavQU0lUUfpXALn2Om9xhp?=
 =?us-ascii?Q?n0VtNjSg70Q7yhR8OYH2hjk8lOHJ0VBGlcNWO+R2IRRqqebt42hLkWm6gfSw?=
 =?us-ascii?Q?JXn4PAU1005Q4HbJoitg/5pWy25CYeT+eix+tg5xa9f+A0vsOd6qA+FIzYyo?=
 =?us-ascii?Q?Fk67p3qa+4J31a0Eu9rkwIgtoGm2TuopEhx8ZR3UDpx4zw7U0MdvO09MuMra?=
 =?us-ascii?Q?+SeKkDGp9To2ZMiK0oqeG+P6CTnqvCp7jk2Yi3IBZLhbtzfEJPwq+VRKBdWv?=
 =?us-ascii?Q?fYvjY8GlOPq530RTOn77fJM1v1BYXAkVlhUzGs0nZwcs847arF7gMtuF0NmA?=
 =?us-ascii?Q?/zHz/2wx0w4PlNhqNgWGGCODtIky2HOiFFGvSEXUFyeKVJXCImIL0kHXhJXB?=
 =?us-ascii?Q?GaGEbiMrKS1IG6rTPNORbK5MKfpkifLPowyQ1yM1WWA1WUt+5m/tf+PwTYMK?=
 =?us-ascii?Q?3l0A4euG3unG7zucEKccuGXfOAZ+RiiamD2mJKss+PRalkzITw0UkwcQG8+w?=
 =?us-ascii?Q?1DkneyXUj3KrvdKeIWIs5ZALrJz2PZb18zMWZ22YVqwPrdQmYA6nP8o1TiWg?=
 =?us-ascii?Q?noQ+IAapndFBgCTPYpKyRs0Vv/c6NBhpDSEL8HFpPTl5CMT3sNSbu0KOUJKX?=
 =?us-ascii?Q?l8/UTKXK/DmAWng4RYte6yW0AdI6zTezFiwjMnfhCwCigqgnPpMnmd07sUlr?=
 =?us-ascii?Q?kzC8OpRpJaM7jqTlDUV4I+XjhEh0EhpbvDDBd/rkWKFyMpKSA7jretta7H4L?=
 =?us-ascii?Q?8wD5l6//TrvGGMiJM7pHMZwiTs6oGq/TDE8erudmlnMyDsmamq1+NeA2kx/1?=
 =?us-ascii?Q?1Xu9rocDcqqJlqDFVDo5HgRpjJrQ3krLjHuZDaYlXUxjuMTJUz5BFlpq+vq8?=
 =?us-ascii?Q?XHYZcoEp1nro2lX2/vV/Gxgh?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc37ecbe-cff4-4ab9-cd23-08d94b714e5e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 11:27:06.9352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfI6omqc93zXgvXlrGToNTxMSL6gwBzahuj6wovzA3imx9gMHZwTOGW6AdtcVmGk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5814
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/20 =E4=B8=8B=E5=8D=882:56, Qu Wenruo wrote:
> [BUG]
> There is a strange bug that when running "-o compress" mount option for
> subpage case, btrfs/160 has a random chance (~20%) to crash the system:
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
> However if we disable v1 space cache, the crash just disappera.
>=20
> [CAUSE]
> The offending inode is in fact a v1 space cache inode.
>=20
> The crash happens in the following sequence:
>=20
> - Writing back space cache for inode 1/257 (root 1, ino 257).
>    The space cache is a little big in this case, 983040 bytes (960K).
>=20
> - Run delalloc range for the free space cache inode
>    Ordered extent [0, 960K) is inserted for inode 1/257.
>=20
> - Call __extent_writepage_io() for each page
>    The first 3 pages submitted without problem.
>    But the 4th page get submitted but failed due to the injected error.
>=20
> - Error out without handling the submitted ordered extent
>    Since only 4 pages submitted and finished, the ordered extent
>    [0, 960K) is still there.
>=20
> - Retry the free space cache writeback with some update
>    Now inode 1/257 have its contents updated, and need to try writeback
>    again.
>=20
> - Run delalloc range for the free space cache inode.
>    Ordered extent [0, 960K) is going to be inserted again.
>    But previously added ordered extent [0, 960K) is still there,
>    triggering the crash.
>=20
> This problem only happens for free space cache inode, as other inode
> won't try to re-write the same inode after error.
>=20
> Although the free space cache size 960K seems to be a subpage specific
> problem, but the root cause is still there.
>=20
> [FIX]
> Fix the problem by introducing a new helper,
> btrfs_cleanup_hanging_ordered_extents(), to cleanup the added ordered
> extent after bio submission error.
>=20
> This function will call btrfs_mark_ordered_io_finished() on each
> involved page, and finish the ordered extent and clear the page Private
> bit.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
>=20
> Current version works and will no longer crash at btrfs/160.
> (Although still need some polish, as the delalloc space for v1 cache
>   inode is not yet properly cleaned up)
>=20
> But I'm not sure why we never hit such problem for v1 space cache write
> back, and not sure if this is the correct way to go.

OK, after more digging, it's a subpage specific problem.

The offending code in fact lies at the ending part of __extent_writepage():

done:
         if (nr =3D=3D 0) {
                 /* make sure the mapping tag for page dirty gets cleared *=
/
                 set_page_writeback(page);
                 end_page_writeback(page);
         }
         if (PageError(page)) {
                 ret =3D ret < 0 ? ret : -EIO;
                 end_extent_writepage(page, ret, page_start, page_end);
         }

If by somehow the page we're submitting is marked error, then we error out.
The caller will just stop submitting the remaining pages.

This looks correct but in fact we should just continue submitting, and=20
it's exactly what non-subpage case does.

For non-subpage case, one page only contains one sector, thus we either=20
add the page into previous bio, or submit previous bio and allocate a=20
new bio, and add the page into the newly allocated bio.

We never have the current page submitted while we're holding it.

This means, even for the dm-dust/error injection case, that PageError()=20
branch will never be true, and we always return 0 (if no other error=20
happens).

But for subpage case, we can have part of the page submitted, and the=20
endio will mark part of the page error.

In that case, dm-dust can easily make __extent_writepage() to return=20
error, and stop submitting the remaining part.


Thus to properly fix this problem, I'm afraid I have to remove the if=20
(PageError()) branch, ironically, to fix a bug...

Thanks,
Qu



>=20
> Should we just error out if we failed to write back v1 space cache?
>=20
> Anyway, send out the RFC version to make sure if the fix is the correct
> way to go.
> ---
>   fs/btrfs/ctree.h       |  3 +++
>   fs/btrfs/extent_io.c   | 15 +++++++++++++++
>   fs/btrfs/inode.c       | 41 +++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/transaction.c | 11 +++++++++++
>   4 files changed, 70 insertions(+)
>=20
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index e265a7eb0d5c..8c32f2119790 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3194,6 +3194,9 @@ int btrfs_writepage_cow_fixup(struct page *page, u6=
4 start, u64 end);
>   void btrfs_writepage_endio_finish_ordered(struct btrfs_inode *inode,
>   					  struct page *page, u64 start,
>   					  u64 end, int uptodate);
> +void btrfs_cleanup_hanging_ordered_extents(struct btrfs_fs_info *fs_info=
,
> +					   struct btrfs_inode *inode,
> +					   u64 start);
>   extern const struct dentry_operations btrfs_dentry_operations;
>   extern const struct iomap_ops btrfs_dio_iomap_ops;
>   extern const struct iomap_dio_ops btrfs_dio_ops;
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index fff1a4d8fe25..cfbed849b598 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4137,6 +4137,21 @@ static int __extent_writepage(struct page *page, s=
truct writeback_control *wbc,
>   		ret =3D ret < 0 ? ret : -EIO;
>   		end_extent_writepage(page, ret, page_start, page_end);
>   	}
> +
> +	/*
> +	 * We may have ordered extent already allocated, and since we error out
> +	 * the remaining pages will never be submitted thus the ordered extent
> +	 * will hang there forever.
> +	 *
> +	 * Such hanging OE would cause problem for things like free space cache
> +	 * where we could retry to write it back.
> +	 * So here if we hit error submitting the IO, we need to cleanup the
> +	 * hanging ordered extent.
> +	 */
> +	if (ret < 0)
> +		btrfs_cleanup_hanging_ordered_extents(fs_info, BTRFS_I(inode),
> +						      page_end + 1);
> +
>   	if (epd->extent_locked) {
>   		/*
>   		 * If epd->extent_locked, it's from extent_write_locked_range(),
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e8af0021af78..05d392315f3b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3211,6 +3211,47 @@ void btrfs_writepage_endio_finish_ordered(struct b=
trfs_inode *inode,
>   				       finish_ordered_fn, uptodate);
>   }
>  =20
> +/*
> + * Cleanup any added ordered ordered extent from @start.
> + *
> + * This fucntion should be called when ordered extent is submitted but b=
y some
> + * how the bio submission hits some error and has to error out.
> + */
> +void btrfs_cleanup_hanging_ordered_extents(struct btrfs_fs_info *fs_info=
,
> +					   struct btrfs_inode *inode,
> +					   u64 start)
> +{
> +	struct btrfs_ordered_extent *oe;
> +	u64 cur;
> +	u64 end;
> +
> +	ASSERT(IS_ALIGNED(start, PAGE_SIZE));
> +	/* Grab the ordered extent covers the bytenr to calculate the end. */
> +	oe =3D btrfs_lookup_first_ordered_extent(inode, start);
> +	if (!oe)
> +		return;
> +	end =3D oe->file_offset + oe->num_bytes;
> +	btrfs_put_ordered_extent(oe);
> +
> +	/* Finish the ordered extent of the remaining pages */
> +	for (cur =3D start; cur < end; cur +=3D PAGE_SIZE) {
> +		struct page *page;
> +		u32 len;
> +
> +		page =3D find_lock_page(inode->vfs_inode.i_mapping,
> +				cur >> PAGE_SHIFT);
> +		if (!page)
> +			continue;
> +
> +		len =3D min(page_offset(page) + PAGE_SIZE, end + 1) -
> +		      page_offset(page);
> +		btrfs_mark_ordered_io_finished(inode, page, cur, len,
> +				finish_ordered_fn, false);
> +		unlock_page(page);
> +		put_page(page);
> +	}
> +}
> +
>   /*
>    * check_data_csum - verify checksum of one sector of uncompressed data
>    * @inode:	inode
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 14b9fdc8aaa9..05d786401374 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -313,6 +313,17 @@ static noinline int join_transaction(struct btrfs_fs=
_info *fs_info,
>   	if (type =3D=3D TRANS_ATTACH)
>   		return -ENOENT;
>  =20
> +	/*
> +	 * TRANS_JOIN_NOLOCK is only utilized by free space cache endio.
> +	 * Normally it only happens during commit transaction, but it's
> +	 * possible that we error out and abort transaction.
> +	 *
> +	 * In that case, the endio for free space cache may get no running
> +	 * trans.
> +	 * Stay cool and just return error for the only caller.
> +	 */
> +	if (type =3D=3D TRANS_JOIN_NOLOCK)
> +		return -ENOENT;
>   	/*
>   	 * JOIN_NOLOCK only happens during the transaction commit, so
>   	 * it is impossible that ->running_transaction is NULL
>=20


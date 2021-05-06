Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45752374FD0
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 May 2021 09:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhEFHL0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 May 2021 03:11:26 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:34638 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233070AbhEFHLZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 May 2021 03:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1620285026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hw8NYVsHGyOY69N7+vvj6LoYA1yX5/iODPVZz8GmTjI=;
        b=JM9Gg42At8t6rmHNlVMp1PCDWhub2CI/gbEdWoF+kLaGOLBylg0ACbz2hIuZq6lPg64OGG
        Vt4lfIFH5b+YXastUCLlkcTLEy5aP2untb8TB7uaA1JljpedmG9pazbC2bL3brK6e0GeIt
        vpG35f7pZj1UqT1VVONrswqbdVSoOKw=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2052.outbound.protection.outlook.com [104.47.12.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-32-0sU1NinMNoWzSTu0MaGAhg-1; Thu, 06 May 2021 09:10:25 +0200
X-MC-Unique: 0sU1NinMNoWzSTu0MaGAhg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4JrlSRH/txY5tLVPqFlIFBTyLGVSjxKYAGXikxePlSIjZQlsKvYvbdf70kHdRyDdL6heC72uadcFJdw1tVqfctTpZDX5lNGmCc3gWfVibE6c13ct2ENIFqWzfbpGyiFFAtk5DXUUHX58KeQ/ICWzbuLYbbDREs69BOzrJT2UTvDPJc74hJvGCStvtwt7KJeeukjry8x8RaCWEQvcbK7PZZ4SKeySsxr4xtBgJK4/CLvrDTY+/lIjAo2od8ISjnJRE7o+cUlq0Tuh1EN0DpIyovMtG3D4cSQq7cl6K1+KMchTi+4rt6VrXIA2gQCHIID9g+gKTIQ9bG7qRHzwjI3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hXaaXuGU51ciciiq/5ECdIZuKJT74dPwNdKRlb9gm0=;
 b=kcm/I1GlDy5ODOlTYjFMXVdjbgdVeJhM7H3jQmUDPFRh7sqMuC0p7ro8mXYxqdVjV0dKb4fYhhm8S6BRCXXeplR7+m8sqxQch4fbeNwxcjaqNXrMTT3meiPoL2TwAsY55/4hSFmLoTqU79lfDSM369eD8X+6DJFzXLVdAFrmOPc3JB6z1vMy8JqcA+QsRo5Ts8sM+G9doP/oCJRmqINrPQcb7ZSDKWLUVPdcy2pk9jAbqpELF5y0obDGj4b/wXvFEVmOdErzgso1zgujn8H1Hgl/4qrvEsHUlczFRnDVvvBV+CUzRcrzbuSJYc2/qsATS021F3k+tbF9REsbaqiLKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6817.eurprd04.prod.outlook.com (2603:10a6:208:17e::21)
 by AM0PR04MB6882.eurprd04.prod.outlook.com (2603:10a6:208:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Thu, 6 May
 2021 07:10:24 +0000
Received: from AM0PR04MB6817.eurprd04.prod.outlook.com
 ([fe80::fc9c:2fca:af75:ad83]) by AM0PR04MB6817.eurprd04.prod.outlook.com
 ([fe80::fc9c:2fca:af75:ad83%8]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 07:10:24 +0000
Subject: Re: [PATCH RFC] btrfs: temporary disable inline extent creation for
 fallocate and reflink
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210506070458.168945-1-wqu@suse.com>
Message-ID: <e20dcf9a-63b0-2a59-61a0-e9528c9b2e81@suse.com>
Date:   Thu, 6 May 2021 15:10:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
In-Reply-To: <20210506070458.168945-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::30) To AM0PR04MB6817.eurprd04.prod.outlook.com
 (2603:10a6:208:17e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR03CA0055.namprd03.prod.outlook.com (2603:10b6:a03:33e::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 07:10:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac75a5ae-88ff-4045-2461-08d9105e04da
X-MS-TrafficTypeDiagnostic: AM0PR04MB6882:
X-Microsoft-Antispam-PRVS: <AM0PR04MB68826AEAB8E40E1DBA23C08AD6589@AM0PR04MB6882.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0PM90r9hS/TyX6xRzOZefk5Mi5Oba9kQGRc+bLD4+3yr2ZuGZzRx1kg48P/eoZvTfOhd0Tk+zPhepJv21G16f7L0Z/tbQ9eXlsySfS02ixpt4jxtibB+GYHq9tVnCbRMHfe5+qV6PmMiIZ5MBTKSa9yw2rK+FPGERJquZHcjNd2HP/aWyzWTTe4B2WW1/3KXT0XbviF5ZIdAVgm7ghjKfHXYcJ+Na59v0fHN5G5zFibM+6C2hO4ZGnhiRrcVlrAZ93TueHi8XIb1f0dZ/TW24wkT4MPJIaiFo6X8llWI3RohSNm7D5vTJ7hwrJvc1dytjSp6BjhI1Op96h4DT2CGnYR75gfZw0cIwWLGzrTSGZ04NI4Gh5kOn92kVPBbgRCU4w3am1m+k1MG5VWa6MXZ7od1iwEWsVYMETQai9W34s08lQ+VX6Sgub0Pdab3qXLCQhnUQIrWiLmNfmHPqLY/rvgsG1x05gyi4CCKEwPpWWaLYeh+sRskvdkyMXSYoizWxam54mKpb/sMvikv9t6Wo9J+UNnLjSIvumPu1rhMeI21KpOfC5H/LoPq5PDmYQUcBdeafpy/FS+pPfTmwFLmZG/WBMGv10E62Q1WUGDL68M9qILyuJJM88L5KjkxRW3zuDfip5l+QGsObhgRyS08TMnWqT87W9oWG3k5rXqtNIpim1/xA0AMfp67J0ZjbU1GogNalVo/Uymd1aLiWJdYTFc2GpVlXxctismGkzFR28=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6817.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(136003)(376002)(396003)(26005)(2906002)(186003)(16526019)(2616005)(52116002)(956004)(83380400001)(6486002)(5660300002)(6916009)(66556008)(66476007)(316002)(6706004)(16576012)(31696002)(30864003)(478600001)(31686004)(8936002)(8676002)(86362001)(38350700002)(38100700002)(36756003)(6666004)(66946007)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mh3RrPpIIY4InBjzMMH8q/HE6K89JXGJhIH6YATGk2R6ROpLoFTGrdAPyXl2?=
 =?us-ascii?Q?KxtQWazRtMEoR79BQfUgHK7su1Y2SLoGSc1Tx/iN1Tam+md5j4WqajuSA/2f?=
 =?us-ascii?Q?6TVnVRlZQzGuETSR16ec4rlsKqqVDi/dBWl4SH8uLZlRtoS/p/PJGiUelMxX?=
 =?us-ascii?Q?yvgEWYBo6475GFnyUVHee1rC4LwptMb1Fr7DEFJEMCklOlx4/rkGkW1wuon4?=
 =?us-ascii?Q?vtT37hKbfUtQJXoZdKIc0lZYzJ9in7/U497HNz1oTU2I6Xt3ipzCHw6eYzoi?=
 =?us-ascii?Q?7Rl2tBZAXmIMwy5+1jFLBTzBBcBgWSoUe16cfzkeuqd0R5cCsSSplZSE3ppR?=
 =?us-ascii?Q?zEgb/RosVDdKgT7qXJLMy5Too82fOwTnJH86HJ0JdM3t8YxGLXuIMyHt5DWs?=
 =?us-ascii?Q?AvwYU9UlcGWTOsE0izLCztBbkLIb357tBdjpucQewhMEMu3fi0Rx/4glpscA?=
 =?us-ascii?Q?g3FNH5hNKfwB/8YcIXQGsA5dpi0lEA3YberSC2ktHyiCcWxAHcoaJu/lm24u?=
 =?us-ascii?Q?12oy5NIdDWF4fNL3hlWZMmlFvvFih1doIYSynXqOvdDQ6WuD9c+o+jL6xiJY?=
 =?us-ascii?Q?GeweZi9a4Ua8YxMvCJipr0ZAWN1EqFwtzZAuOFrUbohEUrhpL1WgKIsNHUgk?=
 =?us-ascii?Q?A8xpv8o28LoOsEV79RCjUdmoGoWmbDCb57Y1bFqyOHB/OrI8Vk7MUhwpYXPe?=
 =?us-ascii?Q?YVm1ncRECi7ISxqm+LXf9jBxletHg8v2emKYEv1sAFlPI8hpWuN5AGTKFcDh?=
 =?us-ascii?Q?lkEA3ru/b1iiEHsFEjF1FjLFcwwnX4wAPGqvlVt+BVA1VLTpiuyJ4+rmUGTI?=
 =?us-ascii?Q?4pi3x6dsQva86n6UlTTSG6vMpVXxqc2ZWhQZx7AD863pJMrIke97cS6YEhZ9?=
 =?us-ascii?Q?7td+9Ieb3ydZcON1qfxeYn0FkG9BlOa26C9qnU9woWL6k4sivZDluMwjqFGG?=
 =?us-ascii?Q?xhk1WvkLlQO7bNbsqeeUB5PqfSkY8HeGI7PGvbD9yyG3VWUWbZW9DNktf8h8?=
 =?us-ascii?Q?BZwPsryyssoL50sJmRxl/ve5Si8D4Q62/9P95ekaxGlfekas6cR2RNvJTt2n?=
 =?us-ascii?Q?ZkRtqyZJ5RxFHAScza7fGMu6Aq+czeNvH/Cl3r5ytcsPUeRfxNbYBaC0mnb3?=
 =?us-ascii?Q?9BcgFzCqfv7ClXbmFq6Zxeke6/KikZM1KvRwNXEVHn6xbb2JeZ5IqVFni164?=
 =?us-ascii?Q?oU22evfz+4sDnV/ZXSkdiBPG45eSAVHHke4uYkfmpBjxXh5bdj4MH2djYrqY?=
 =?us-ascii?Q?bViTG3NfGzrgpsD8svBdHk2qXArCXUsLdKIuLn7nhCNk8zaDzneaOwLJDSul?=
 =?us-ascii?Q?9z7p/Fz7UsRwgZsRt+54UGYo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac75a5ae-88ff-4045-2461-08d9105e04da
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6817.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 07:10:24.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DumLGM/13SRUXouq30dEG4vR0CkJc5lfyKAsJLqaLQyaZxt4VXFrX5KlcNIiPK1T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6882
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Some typos fixes:

On 2021/5/6 =E4=B8=8B=E5=8D=883:04, Qu Wenruo wrote:
> Previously we disable inline extent creation completely for subpage
> case, due to the fact that writeback for subpage still happens for full
> page.
>=20
> This makes btrfs_wait_ordered_range() trigger writeback for larger
> range, thus can writeback the first sector even we don't want.
>=20
> But the truth is, even for regular sectorsize, we still have a race
> window there operations where fallocate and reflink can cause inlin
         "where operations like "

> extent being created.
>=20
> For example, for the following operations:
>=20
>   # xfs_io -f -c "pwrite 0 2k" -c "falloc 4k 4k" $file
>=20
> The first "pwrite 0 2k" dirtied the first sector, while inode size is
> updated to 2k.
> At this point, if the first sector is written back, it will be inlined.
>=20
> Then we enter "falloc 4k 4k" which will:
> a) call btrfs_cont_expand() to insert holes
> b) do the mainline to insert preallocated extents
            "main loop"

> c) call btrfs_fallocate_update_isize() to enlarge the isize
>=20
> Until c), the isize is still 2K, and during that window, if the first
> sector is written back due to whatever reasons (from memory pressure to
> fadvice to writeback the pages), since the isize is still 2K, we will
> write the first sector as inlined.
>=20
> Then we have a case where we get mixed inline and regular extents.
>=20
> Fix the problem by introducing a new runtime inode flag,
> BTRFS_INODE_NOINLINE, to temporarily disable inline extent creation
> until the isize get enlarged.
>=20
> So that we don't need to disable inline extent creation completely for
> subpage.
>=20
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
>=20
> I'm not sure if this is the best solution, as the original race window
> for regular sector has existed for a long long time.
>=20
> I have also tried other solutions like switching the timing of
> btrfs_cont_expand() and btrfs_wait_ordered_range(), to make
> btrfs_wait_ordered_range() happens before btrfs_cont_expand().
>=20
> So that we will writeback the first sector for subpage as inline, then
> btrfs_cont_expand() will re-dirty the first sector.
>=20
> This would solve the problem for subpage, but not the race window.
>=20
> Another idea is to enlarge inode size first, but that would greatly
> change the error path, may cause new regressions.
>=20
> I'm all ears for advice on this problem.
> ---
>   fs/btrfs/ctree.h         | 10 ++++++++++
>   fs/btrfs/delayed-inode.c |  3 ++-
>   fs/btrfs/file.c          | 19 +++++++++++++++++++
>   fs/btrfs/inode.c         | 21 ++++-----------------
>   fs/btrfs/reflink.c       | 14 ++++++++++++--
>   fs/btrfs/root-tree.c     |  3 ++-
>   fs/btrfs/tree-log.c      |  3 ++-
>   7 files changed, 51 insertions(+), 22 deletions(-)
>=20
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 7bb4212b90d3..7c74d57ad8fc 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1488,6 +1488,16 @@ do {                                              =
                     \
>   #define BTRFS_INODE_DIRSYNC		(1 << 10)
>   #define BTRFS_INODE_COMPRESS		(1 << 11)
>  =20
> +/*
> + * Runtime bit to temporary disable inline extent creation.
> + * To prevent the first sector get written back as inline before the isi=
ze
> + * get enlarged.
> + *
> + * This flag is for runtime only, won't reach disk, thus is not included
> + * in BTRFS_INODE_FLAG_MASK.
> + */
> +#define BTRFS_INODE_NOINLINE		(1 << 30)
> +
>   #define BTRFS_INODE_ROOT_ITEM_INIT	(1 << 31)
>  =20
>   #define BTRFS_INODE_FLAG_MASK						\
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 1a88f6214ebc..64d931da083d 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1717,7 +1717,8 @@ static void fill_stack_inode_item(struct btrfs_tran=
s_handle *trans,
>   				       inode_peek_iversion(inode));
>   	btrfs_set_stack_inode_transid(inode_item, trans->transid);
>   	btrfs_set_stack_inode_rdev(inode_item, inode->i_rdev);
> -	btrfs_set_stack_inode_flags(inode_item, BTRFS_I(inode)->flags);
> +	btrfs_set_stack_inode_flags(inode_item,
> +			BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK);
>   	btrfs_set_stack_inode_block_group(inode_item, 0);
>  =20
>   	btrfs_set_stack_timespec_sec(&inode_item->atime,
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 70a36852b680..a3559ce93780 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3357,6 +3357,24 @@ static long btrfs_fallocate(struct file *file, int=
 mode,
>   			goto out;
>   	}
>  =20
> +	/*
> +	 * Disable inline extent creation until we enlarged the inode size.
> +	 *
> +	 * Since the inode size is only increased after we allocated all
> +	 * extents, there are several cases to writeback the first sector,
> +	 * which can be inlined, leaving inline extent mixed with regular
> +	 * extents:
> +	 *
> +	 * - btrfs_wait_ordered_range() call for subpage case
> +	 *   The writeback happens for the full page, thus can writeback
> +	 *   the first sector of an inode.
> +	 *
> +	 * - Memory pressure
> +	 *
> +	 * So here we temporarily disable inline extent creation for the inode.
> +	 */
> +	BTRFS_I(inode)->flags |=3D BTRFS_INODE_NOINLINE;
> +
>   	/*
>   	 * TODO: Move these two operations after we have checked
>   	 * accurate reserved space, or fallocate can still fail but
> @@ -3501,6 +3519,7 @@ static long btrfs_fallocate(struct file *file, int =
mode,
>   	unlock_extent_cached(&BTRFS_I(inode)->io_tree, alloc_start, locked_end=
,
>   			     &cached_state);
>   out:
> +	BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLINE;
>   	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
>   	/* Let go of our reservation. */
>   	if (ret !=3D 0 && !(mode & FALLOC_FL_ZERO_RANGE))
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4fc6e6766234..59972cb2efce 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -666,11 +666,7 @@ static noinline int compress_file_range(struct async=
_chunk *async_chunk)
>   		}
>   	}
>   cont:
> -	/*
> -	 * Check cow_file_range() for why we don't even try to create
> -	 * inline extent for subpage case.
> -	 */
> -	if (start =3D=3D 0 && fs_info->sectorsize =3D=3D PAGE_SIZE) {
> +	if (start =3D=3D 0 && !(BTRFS_I(inode)->flags & BTRFS_INODE_NOINLINE)) =
{
>   		/* lets try to make an inline extent */
>   		if (ret || total_in < actual_end) {
>   			/* we didn't compress the entire range, try
> @@ -1068,17 +1064,7 @@ static noinline int cow_file_range(struct btrfs_in=
ode *inode,
>  =20
>   	inode_should_defrag(inode, start, end, num_bytes, SZ_64K);
>  =20
> -	/*
> -	 * Due to the page size limit, for subpage we can only trigger the
> -	 * writeback for the dirty sectors of page, that means data writeback
> -	 * is doing more writeback than what we want.
> -	 *
> -	 * This is especially unexpected for some call sites like fallocate,
> -	 * where we only increase isize after everything is done.
> -	 * This means we can trigger inline extent even we didn't want.
> -	 * So here we skip inline extent creation completely.
> -	 */
> -	if (start =3D=3D 0 && fs_info->sectorsize =3D=3D PAGE_SIZE) {
> +	if (start =3D=3D 0 && !(inode->flags & BTRFS_INODE_NOINLINE)) {
>   		/* lets try to make an inline extent */
>   		ret =3D cow_file_range_inline(inode, start, end, 0,
>   					    BTRFS_COMPRESS_NONE, NULL);
> @@ -3789,7 +3775,8 @@ static void fill_inode_item(struct btrfs_trans_hand=
le *trans,
>   	btrfs_set_token_inode_sequence(&token, item, inode_peek_iversion(inode=
));
>   	btrfs_set_token_inode_transid(&token, item, trans->transid);
>   	btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
> -	btrfs_set_token_inode_flags(&token, item, BTRFS_I(inode)->flags);
> +	btrfs_set_token_inode_flags(&token, item,
> +			BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK);
>   	btrfs_set_token_inode_block_group(&token, item, 0);
>   }
>  =20
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index e5680c03ead4..48f8bdd185de 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -701,12 +701,19 @@ static noinline int btrfs_clone_files(struct file *=
file, struct file *file_src,
>   	if (off + len =3D=3D src->i_size)
>   		len =3D ALIGN(src->i_size, bs) - off;
>  =20
> +	/*
> +	 * Temporarily disable inline extent creation, check btrfs_fallocate()
> +	 * for details
> +	 */
> +	BTRFS_I(inode)->flags |=3D BTRFS_INODE_NOINLINE;
>   	if (destoff > inode->i_size) {
>   		const u64 wb_start =3D ALIGN_DOWN(inode->i_size, bs);
>  =20
>   		ret =3D btrfs_cont_expand(BTRFS_I(inode), inode->i_size, destoff);
> -		if (ret)
> +		if (ret) {
> +			BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLINE;
>   			return ret;
> +		}
>   		/*
>   		 * We may have truncated the last block if the inode's size is
>   		 * not sector size aligned, so we need to wait for writeback to
> @@ -718,8 +725,10 @@ static noinline int btrfs_clone_files(struct file *f=
ile, struct file *file_src,
>   		 */
>   		ret =3D btrfs_wait_ordered_range(inode, wb_start,
>   					       destoff - wb_start);
> -		if (ret)
> +		if (ret) {
> +			BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLINE;
>   			return ret;
> +		}
>   	}
>  =20
>   	/*
> @@ -745,6 +754,7 @@ static noinline int btrfs_clone_files(struct file *fi=
le, struct file *file_src,
>   				round_down(destoff, PAGE_SIZE),
>   				round_up(destoff + len, PAGE_SIZE) - 1);
>  =20
> +	BTRFS_I(inode)->flags &=3D ~BTRFS_INODE_NOINLINE;
>   	return ret;
>   }
>  =20
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index 702dc5441f03..5ce3a1dfaf3f 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -447,7 +447,8 @@ void btrfs_check_and_init_root_item(struct btrfs_root=
_item *root_item)
>  =20
>   	if (!(inode_flags & BTRFS_INODE_ROOT_ITEM_INIT)) {
>   		inode_flags |=3D BTRFS_INODE_ROOT_ITEM_INIT;
> -		btrfs_set_stack_inode_flags(&root_item->inode, inode_flags);
> +		btrfs_set_stack_inode_flags(&root_item->inode,
> +				inode_flags & BTRFS_INODE_FLAG_MASK);
>   		btrfs_set_root_flags(root_item, 0);
>   		btrfs_set_root_limit(root_item, 0);
>   	}
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index c1353b84ae54..f7e6abfc89c0 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -3943,7 +3943,8 @@ static void fill_inode_item(struct btrfs_trans_hand=
le *trans,
>   	btrfs_set_token_inode_sequence(&token, item, inode_peek_iversion(inode=
));
>   	btrfs_set_token_inode_transid(&token, item, trans->transid);
>   	btrfs_set_token_inode_rdev(&token, item, inode->i_rdev);
> -	btrfs_set_token_inode_flags(&token, item, BTRFS_I(inode)->flags);
> +	btrfs_set_token_inode_flags(&token, item,
> +			BTRFS_I(inode)->flags & BTRFS_INODE_FLAG_MASK);
>   	btrfs_set_token_inode_block_group(&token, item, 0);
>   }
>  =20
>=20


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D991D40A6B0
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 08:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbhING0H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 02:26:07 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:52718 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240054AbhING0F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 02:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631600686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UzLKQJRwzI6ANLko70lQTZGVgwMjIR8CkQvcVs8IUCA=;
        b=BDxsWSgq+Gv06FF1bKHsP9Yg4FayEx/eIu0njXBymSHyjGQZI+QC8PEEX29vzAwcggO7Yw
        HkN+R7OB3hKT/SE2FD9QqkCaMXzpaU3SFCrng1vyPgTsj6IDWYrwO8260EcytvdHpq9FYA
        So7G3z4+rWbSTPXRNEbrhglogOkgZDQ=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2058.outbound.protection.outlook.com [104.47.0.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-dO9imHOdM-KO9DV4V9E5ag-2; Tue, 14 Sep 2021 08:24:45 +0200
X-MC-Unique: dO9imHOdM-KO9DV4V9E5ag-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTWwcCS87pcUXftbH15vs8GBry1CUnZshykbQo8THGVL9iGM6hHh1B83apCXS3PpB8sE5Hw5m0kMbgWGz34wkiH5vEX84hDSxnAW1gJSVDVKdHkUdyFQBp9i4GFPih1vA9k8n8BTphtmwsjS/K/0FMPGqMQp+XrPeVMpFMmRkTGd4BJVkTJvGtVn1Of7fq1VxwtBu6oxCQtcRY4Y5cqBsWllZXi1rN4qj+TCXMKGdCgUxlP2uUnqWQ7iey2Eh1V1kD3xek8HLi5W2DPbi9rp60QVhT7CdhNmi0PR4SuQJrYTgF9/eZoTLtxwej+4cnfFCyKpLvkgQY0kYGvUmh0frQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QIVJdAsgELO09TwNTv+9sYB0JpRK5VUyFgmJdKM+W1k=;
 b=k6Sn3L6iY+hrz/ijOvf+HlLgQXf7jhxRJ/jAFvVKMj3dcZtF7XTNerX9/a/BISJWlz0jJ/kOyzg/d+6XbL+86i7Yos4K00FHN1pGQH+rQRMpGXz8vWKV+tPC3ec/4/M+FYZkmYwvWkJFkeyL+o1su1GTgtB884Pa1PPrFdzSjr+2t0SLTmxy/xEcaI1Ouxh15ExGG2H682YXV6f2j08tAzzaM89xmoBijEWc0NUO5Szpn5RvYwoJ5eUU92SGQ5QAte2XAYV3HudBe3VNjjzp35AYwk1Cm747JDtSaogGZkxz1oaKNI1oH3OO6cJgiv/TNt9Q+Ydr2BxNDIAiixHx1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM6PR04MB5080.eurprd04.prod.outlook.com (2603:10a6:20b:2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Tue, 14 Sep
 2021 06:24:44 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::78e1:ab2a:f283:d097%5]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 06:24:44 +0000
Subject: Re: [PATCH] btrfs: unlock the original extent buffer when error
 happens in __btrfs_cow_block()
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
CC:     Hao Sun <sunhao.th@gmail.com>
References: <20210914055523.33220-1-wqu@suse.com>
Message-ID: <c25b92c4-b965-cf27-9d86-196eaae091d4@suse.com>
Date:   Tue, 14 Sep 2021 14:24:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210914055523.33220-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:a03:80::20) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR11CA0043.namprd11.prod.outlook.com (2603:10b6:a03:80::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 06:24:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e642aedb-644a-4956-b86f-08d977485772
X-MS-TrafficTypeDiagnostic: AM6PR04MB5080:
X-Microsoft-Antispam-PRVS: <AM6PR04MB50805034A640C2D547DAFEB8D6DA9@AM6PR04MB5080.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBwV6T32bajCo2Taj4kzC1CySe5fFHQicYXfhBaDjjq1NpHwfXBwQq2GM1FMJkHT//BKK8PCmtN6huxxbbXHZM42dc5LM7nQBq4s3O159b6NYcJsNZEGWa6rjt/U2OLQAwfAi52lsc2n8B4GjwxNk7AJQFbsM8HIUBBfGo8FiDd6C9+m9Mg/b6VGo2zd9cYmZiOLW4kds8BjG/drDlpNkO1PxzsVcdyHNsINk66lPHMaOZA6RRFT28XEqaO5n/rDVarqkjUQ37pAjlkvAOrPBsWD9bzAYQ6PNIiViD6yzKy9rNcGLaxq93WbRQPX/HmL20nMhsiEz7vTceNaTkHz0LfsEOrZ4bR/4UBQwwYFa/UdtMEhW3XJfi3o73R85x60ajZ9yKuKMRfGhi1/Fmmm6FoePFCx/PNo8dsNZZ6ygLHbkAtQRyZi1XHdX3dHqmNC3xQRHcw9NImJ+IXPgb9egU1GaFcTeiOdgj+iKmic63/xBOr8AfJx5tN0yTYrN7ULc4fbvb45FW+Pj4Gzh51NY40ZpsDufNHqbX1OdWK9jcpzkDjoP40YmExswRZa7/Km1DpNCK8S9W8dytgszC9c2MCRxKjQ8f+GH1MF/MTJN9M4WBfWPmIt8+Qtukvcf55I4alxtO08GKNaq5REdC1cZXP6OF3FPPHFGD6OLZDoEx0APotuFwA1CjBETBxpwuMnLnbGcZscUc2fhEi8aZBZ6nh9fxvgu3BUwL79+myN/yUZxOlVrq4AX6PeKV4mbncN0u397f7oJTn/EkM6W0AJSbgxYbq2ourZf2CCts523110NmlRR6yPRDNVet0LKuhp0dXGKaPvKAPdIiXTliCg8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39840400004)(366004)(136003)(346002)(396003)(4326008)(38100700002)(31686004)(36756003)(186003)(6916009)(6706004)(66476007)(956004)(2906002)(6666004)(66946007)(2616005)(66556008)(83380400001)(478600001)(966005)(8936002)(8676002)(5660300002)(86362001)(26005)(16576012)(316002)(31696002)(6486002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8+cJcOG6syR6BZhHnE/PjCW8XzSHYOMSNgYCHaNb6hP98UWMOcJ/8mY+otUH?=
 =?us-ascii?Q?5QYrMgvKMIr/YBcCTe3tKxzxFMPjLKq+ukvizOY0nJI0HEWezQ5BDJ79oWw0?=
 =?us-ascii?Q?meltgHDF/oIYQJs7vAr8ruHznHgD8US/UYAVHZIKV8Co4JKaYCPEOGiU5uR6?=
 =?us-ascii?Q?fvaQNEXn/Mte3ixzIDeNBCFFhgJKZDxixgr3Ay4/rZx8beInBWt97bS/pdA7?=
 =?us-ascii?Q?OIuOLXV4djr61snrXsAtkj9Mf1KCHnEJaUNwbkwrQdcgg2l69rLs4fMrcEdV?=
 =?us-ascii?Q?qDOsVlUhnUo6oxK68TZu424EaK7uG/zp+aw9SnBOK5L4sau0Td+kECFH9lhx?=
 =?us-ascii?Q?Xavzt4O6QAuUJuwfeeGfyw1mvHASm669jTw0QDg5dhxYjIegs0h8XIsVsoRY?=
 =?us-ascii?Q?UO0wlndqBkJX6BEGzGPSYJHvlGPWuY8bU7iyf8KCWb4k0E/ieExhOLXoXzIa?=
 =?us-ascii?Q?nHWisF414bT3r56YGLVuLfudWkeOG2ycfpWWLJy/L/75BFe9w7elfpvhp0Ij?=
 =?us-ascii?Q?8ObAr0lb1uvodSXVcWl/jhL+rlJWbvudvbe4yAtE+LkF1cyoWNAjtiXVDT2S?=
 =?us-ascii?Q?q7A6EPnGoXS/ZnDFkRJBTCv7CvxkP8fWIhQL0sADBJzsBdsMUGljCzzPR3IP?=
 =?us-ascii?Q?Ogh99s75jyTyVkTxih8Iiwxv32raq/mIXIytvpZqIU1eIEbE4aCgYJ+/sYRC?=
 =?us-ascii?Q?UoqHFu+RrTDCjS96azvdcBCQDUi8m9RhHc7inrow0eCjTscR3dc0qBN7nbSb?=
 =?us-ascii?Q?+idSysTr2Z01z8+YcZ/gnQIrRRf3+cwAAGVJSRDpdjMYP8aFkPpTLpRYS9ub?=
 =?us-ascii?Q?7fSZKzg/oLQPY5lCtAa4OLBl2Bv7oVK7A4NtW0jyshbz/dvYkjjBpwPYRqRD?=
 =?us-ascii?Q?PAJ/CIYtyFtJlAV/35XQe5GvPYjd61iGTmuw+t8jFNByBtKe8AnVyqTrwBS1?=
 =?us-ascii?Q?tYJyu+JO9yI49m7hms2BsgRW8q35D6Pu4pJ9eBSRKhBAaczIf/8hCaCOxD/N?=
 =?us-ascii?Q?qub93iIEcigMAbex9Wm3ROROZ+y7OLN/4+vXUxdqfoAXj+amK8O8/jahwt/F?=
 =?us-ascii?Q?KMb0boFqLU5jtFR89n/PWv5ozpDGA154p13/HPxiIjF9hW6EgvPfsMrDHnvr?=
 =?us-ascii?Q?hpjJHSG0xhyoYoAA5YkubIHByXMgsE7I10qDpFXlDb21Fz9eXw0JPaW4yFhY?=
 =?us-ascii?Q?4w4U5S0SzdBHIE8rhnMALyh8zRwcvt+WytZDD8sac/0ITbzVUpiP62grlAYx?=
 =?us-ascii?Q?tORd2RVjmqJHnbYP15dLAJvMA50zlFXI03Gnc5pqIts13/mWCxnG5Pwx8Tm5?=
 =?us-ascii?Q?xKjaRpFIqmiAv/n2dwPisePR?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e642aedb-644a-4956-b86f-08d977485772
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 06:24:44.0303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5xxtMnI/FLZqmEPoY/JF7djGOp06WE8SO3r++HyXSvI4R+tpAnv4cZPhTVhllsw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5080
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/14 =E4=B8=8B=E5=8D=881:55, Qu Wenruo wrote:
> [BUG]
> There is a very detailed bug report that injected ENOMEM error could
> leave a tree block locked while we return to user-space:
>=20
>    BTRFS info (device loop0): enabling ssd optimizations
>    FAULT_INJECTION: forcing a failure.
>    name failslab, interval 1, probability 0, space 0, times 0
>    CPU: 0 PID: 7579 Comm: syz-executor Not tainted 5.15.0-rc1 #16
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>    rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
>    Call Trace:
>     __dump_stack lib/dump_stack.c:88 [inline]
>     dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
>     fail_dump lib/fault-inject.c:52 [inline]
>     should_fail+0x13c/0x160 lib/fault-inject.c:146
>     should_failslab+0x5/0x10 mm/slab_common.c:1328
>     slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
>     slab_alloc_node mm/slub.c:3120 [inline]
>     slab_alloc mm/slub.c:3214 [inline]
>     kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
>     btrfs_alloc_delayed_extent_op fs/btrfs/delayed-ref.h:299 [inline]
>     btrfs_alloc_tree_block+0x38c/0x670 fs/btrfs/extent-tree.c:4833
>     __btrfs_cow_block+0x16f/0x7d0 fs/btrfs/ctree.c:415
>     btrfs_cow_block+0x12a/0x300 fs/btrfs/ctree.c:570
>     btrfs_search_slot+0x6b0/0xee0 fs/btrfs/ctree.c:1768
>     btrfs_insert_empty_items+0x80/0xf0 fs/btrfs/ctree.c:3905
>     btrfs_new_inode+0x311/0xa60 fs/btrfs/inode.c:6530
>     btrfs_create+0x12b/0x270 fs/btrfs/inode.c:6783
>     lookup_open+0x660/0x780 fs/namei.c:3282
>     open_last_lookups fs/namei.c:3352 [inline]
>     path_openat+0x465/0xe20 fs/namei.c:3557
>     do_filp_open+0xe3/0x170 fs/namei.c:3588
>     do_sys_openat2+0x357/0x4a0 fs/open.c:1200
>     do_sys_open+0x87/0xd0 fs/open.c:1216
>     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>     entry_SYSCALL_64_after_hwframe+0x44/0xae
>    RIP: 0033:0x46ae99
>    Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
>    89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
>    01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
>    RSP: 002b:00007f46711b9c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
>    RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
>    RDX: 0000000000000000 RSI: 00000000000000a1 RDI: 0000000020005800
>    RBP: 00007f46711b9c80 R08: 0000000000000000 R09: 0000000000000000
>    R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000017
>    R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007ffc129da6e0
>=20
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    WARNING: lock held when returning to user space!
>    5.15.0-rc1 #16 Not tainted
>    ------------------------------------------------
>    syz-executor/7579 is leaving the kernel with locks still held!
>    1 lock held by syz-executor/7579:
>     #0: ffff888104b73da8 (btrfs-tree-01/1){+.+.}-{3:3}, at:
>    __btrfs_tree_lock+0x2e/0x1a0 fs/btrfs/locking.c:112
>=20
> [CAUSE]
> In __btrfs_cow_block() we could have a case where buf =3D=3D *cow_ret, th=
is
> is the common call pattern in btrfs_search_slow().
>=20
> In that case, before we return we should unlock the original buffer.
>=20
> As in the btrfs_search_slot() call site:
>=20
> 			if (last_level)
> 				err =3D btrfs_cow_block(trans, root, b, NULL, 0,
> 						      &b,
> 						      BTRFS_NESTING_COW);
> 			else
> 				err =3D btrfs_cow_block(trans, root, b,
> 						      p->nodes[level + 1],
> 						      p->slots[level + 1], &b,
> 						      BTRFS_NESTING_COW);
>=20
> btrfs_search_slot() expects btrfs_cow_block() to unlock the original
> extent buffer @b.
>=20
> As btrfs_search_slot() only puts the cowed tree block into path @p, thus
> if btrfs_cow_block() fails, there will be no one to unlock extent buffer
> @b.
>=20
> [FIX]
> Add unlock_orig check for all error paths in __btrfs_cow_block().

The patch is causing btrfs/010 to hang, it looks like there are some=20
non-error path that we shouldn't unlock the original buf.

Will update the fix soon.

Thanks,
Qu
>=20
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CACkBjsZ9O6Zr0KK1yGn=3D1rQi6Crh=
1yeCRdTSBxx9R99L4xdn-Q@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/ctree.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 84627cbd5b5b..5cbbeb8384c7 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -415,8 +415,11 @@ static noinline int __btrfs_cow_block(struct btrfs_t=
rans_handle *trans,
>   	cow =3D btrfs_alloc_tree_block(trans, root, parent_start,
>   				     root->root_key.objectid, &disk_key, level,
>   				     search_start, empty_size, nest);
> -	if (IS_ERR(cow))
> +	if (IS_ERR(cow)) {
> +		if (unlock_orig)
> +			btrfs_tree_unlock(buf);
>   		return PTR_ERR(cow);
> +	}
>  =20
>   	/* cow is set to blocking by btrfs_init_new_buffer */
>  =20
> @@ -436,6 +439,8 @@ static noinline int __btrfs_cow_block(struct btrfs_tr=
ans_handle *trans,
>   	ret =3D update_ref_for_cow(trans, root, buf, cow, &last_ref);
>   	if (ret) {
>   		btrfs_tree_unlock(cow);
> +		if (unlock_orig)
> +			btrfs_tree_unlock(buf);
>   		free_extent_buffer(cow);
>   		btrfs_abort_transaction(trans, ret);
>   		return ret;
> @@ -445,6 +450,8 @@ static noinline int __btrfs_cow_block(struct btrfs_tr=
ans_handle *trans,
>   		ret =3D btrfs_reloc_cow_block(trans, root, buf, cow);
>   		if (ret) {
>   			btrfs_tree_unlock(cow);
> +			if (unlock_orig)
> +				btrfs_tree_unlock(buf);
>   			free_extent_buffer(cow);
>   			btrfs_abort_transaction(trans, ret);
>   			return ret;
> @@ -479,6 +486,8 @@ static noinline int __btrfs_cow_block(struct btrfs_tr=
ans_handle *trans,
>   			ret =3D btrfs_tree_mod_log_free_eb(buf);
>   			if (ret) {
>   				btrfs_tree_unlock(cow);
> +				if (unlock_orig)
> +					btrfs_tree_unlock(buf);
>   				free_extent_buffer(cow);
>   				btrfs_abort_transaction(trans, ret);
>   				return ret;
>=20


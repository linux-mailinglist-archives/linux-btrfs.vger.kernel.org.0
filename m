Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C4E4BF40F
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 09:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiBVItt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 03:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiBVItt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 03:49:49 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2122.outbound.protection.outlook.com [40.107.215.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7838D3AEF
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 00:49:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtDBij1LTeqEvXKTrvNce40Zf1/VuzQpOddPvNgNDRHMGG50aiZtsmRN4EuBRoRVdPi5nlJS4T6N/1DtRKihkD4eJXz3IHtaibRl1qizDAPu63OfI96ii2CtEJzydXa6L0ESYOmjHcK7WgDglcp/AQe5BBuIQ5zy2l8n7QzvNNoJreaMDqVOHSPKSdSDlgBuADOXiIPBxDw1psSc3OZoWiDt9VYUy5dYv4sHc+eJ3KAi+aRB+Fst594UBL48PxsW30phytvDiQTAjHS1UqcXMsk9eUJx4ECW4aLO5nfWI9J5NcLSapOk+1pFHAt5XmtLl8QC4+IXIR3bo8HuzzrEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xsmfp21sWUG26fnbpr+UXFL0LyghuwAQNqVyOPuOWU=;
 b=P6r1uxxf/v9IHo+58xZiO7CkmzCKXmD6EjzAVJ2XNCfCAxUP0bYM8iUF0QAYVdXjqvzSTcUJwpMu0nexs7roA/dHjcYTN9389srARNoUu0MTHOv2uEeCHVFnKoij5DzWrIRA87WpBS3V36EEMO/hwiSae2I/5amMNzAF3MHvEAdAPZ/IGqXafchMVfeJhTT0Ixp5YKljIcnq1uCham8/nabFRD9QvsXO+pH+J/JcibdWfDt5s2JzM1QgO6OUu8GCXa1EOHzcnmy5YTr2HXLmPfbQDio+ipGuxc2fj/jfux1osAmjxazDuZhS6D0SXrN6vJTgm5qhl30cNu7+1HE8hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=damenly.org; dmarc=pass action=none header.from=damenly.org;
 dkim=pass header.d=damenly.org; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=damenly.org;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SG2PR02MB3020.apcprd02.prod.outlook.com (2603:1096:4:60::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.26; Tue, 22 Feb
 2022 08:49:14 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::c486:ec5b:3c1f:82d9]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::c486:ec5b:3c1f:82d9%6]) with mapi id 15.20.4951.018; Tue, 22 Feb 2022
 08:49:14 +0000
From:   Su Yue <l@damenly.org>
To:     Su Yue <l@damenly.su>
Cc:     linux-btrfs@vger.kernel.org, Wenqing Liu <wenqingliu0120@gmail.com>
Subject: Re: [PATCH] btrfs: tree-checker: save item data end in u64 to avoid
Date:   Tue, 22 Feb 2022 08:48:55 +0000
Message-ID: <tucrz3pk.fsf@damenly.org>
Content-Type: text/plain; format=flowed
X-ClientProxiedBy: HK2PR0302CA0006.apcprd03.prod.outlook.com
 (2603:1096:202::16) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4403bcfe-23b9-427e-5e7a-08d9f5e033e3
X-MS-TrafficTypeDiagnostic: SG2PR02MB3020:EE_
X-Microsoft-Antispam-PRVS: <SG2PR02MB30208031AE470E873D76F424B43B9@SG2PR02MB3020.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vh01exJGmjFFw4YqE02c4fVHU6ymUhzo/pLd3zNw5GmmkLzW7xPWYqihIHRoVfsVo3KH+7S8zEoGtS9siFeyFv7nFN/dI4xWtm2I0U6J4Mh6F0szpOO4zK31L2sb7CGkctTU+trRnvTHt98iuXD3aeZhjYCFHBPK21GwqUC5lgZzAli3AvSw9TopoSK+z3zBdt71mCaWVA9wU1GtfQNib0bhHXCTkk1V5MtRxCqUWwAlxEaj+kqzjWm3GrCP3amVpLzWMd28E6EofLEmN5pIVK7cFCo8Qn8kCy9EKadX7Q/iKe8NBDMMDV02Gfyq1RecoFoM5Vh8p47VgkzSFw/jr1YNXxhZmj0TYxfo/nPWw/3u3p32RMLNYJPX3/v27c2rm7uaeQ2IvDl1lmilVQJ0m9PCHOWs/86inNeCTu4gGdX3D4m7OxBZyNqLSshPX60IIa8Zd6+QumK6HZmEBPnRfrDv0Llx3WP+jdhd6viq5FFMn/CZLjRuzqQi7pNGaLKgNSCp/dwyKWQSd/sBTFQlsdHw8XAWm7qWef7DYHsyoGUeh1rHzWens5BVKdKGNSboq1TvqXmlhrJLD5IL1+NzZnxXJsmV8N7WuNy+OWZyhbrQiGiVhLXyCcRu+zim1gey9akJ3BVaLz5kT9wJA5DU1kGzN7+h46PP9xnnTt+e88cQUKKN3P2S4cYcXBlXenVDWYFMcLRcmQjM+fnr9KulyMXJVbFYhMRdkbxdYmS9T2cie6qWAlv6z8gka0up60ScgPewAKkDkuFZP6gshLdEfbpGArkhKv9CGRoDDdU7yH//32KSXX6Vb/+Bwuv4CHmVx/PZE9TAvJm4BOQpLK8exQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39830400003)(376002)(366004)(136003)(346002)(396003)(34036004)(2616005)(186003)(83380400001)(36756003)(26005)(2906002)(4326008)(6486002)(5660300002)(966005)(316002)(8676002)(66946007)(66476007)(6666004)(6916009)(8936002)(38350700002)(6512007)(86362001)(66556008)(52116002)(38100700002)(508600001)(6506007)(49092004)(781001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?svNXaAtIvq711w5n9spS4tl8cmLtwXfExGL16jRiyo0+EWh1Z31/GZt7gc2/?=
 =?us-ascii?Q?bRsmYdEYdo0dHrKs1VebXfyYASeuxFrpRHe5UNlIo2p4remlhOHymSMXD6Nt?=
 =?us-ascii?Q?QVG4posGgqVFKwxwDRFeJmsQGfbhqEYErI8TBzp1nNc3eNfA1UnFnil2aG3i?=
 =?us-ascii?Q?m/Z7rB+rlkjr6/a0rJy9mmJGaWd5t3DrvREjod00JwE3/AWdjrwtsJo7f2Im?=
 =?us-ascii?Q?YHrZcUZYJ2k4i2svpXCBut695U4S2p0wBiMnsYrPAs6afPffy96eEQrVwhgZ?=
 =?us-ascii?Q?I9rNIpIbHTQQaa8pljxGPTl30RyeB2x6br87KYj4dTBlRmkSRRT7+ZSE432P?=
 =?us-ascii?Q?mVUmmTHNJyjW/LNXbeQzxuXCTIb92y2B6AMX2dzl6i1f5/weutYW4oo1WX6/?=
 =?us-ascii?Q?ZaJcupym/vmS87DWn2kPQMgH9v/Esx8h6y5ghJ3fqNwA8zf8opjyjQ0CGKvj?=
 =?us-ascii?Q?8bP2sd9tZW1ByLOShEsAHleL+bidjjuvvuBKxW5m3wL07C32luoNq4Ez13nr?=
 =?us-ascii?Q?mOptsbHZFIggFHD507bYvAJFdkzfYI4dyprwLo7FsX7AkI8QdYOnRCARC275?=
 =?us-ascii?Q?UE0khaQzU4y9dhBIAr6mh/mUSFiWlxXAor/VqbLP6G9A/+KE8+/ZDbQ7L/s6?=
 =?us-ascii?Q?nQ6PNvcvtuPwY+aHJJ7f7CN8nUBrUW/ZrSyBSqYFVTGQETOhy3iF7PMQ3Jcw?=
 =?us-ascii?Q?f5pcB2duIt13DvZYMjIYikILs02/cm8ced069gexHmlbYLF6IXhjZra9Orh1?=
 =?us-ascii?Q?l36vLv74ENNtAYTjRhx7RApc+AhuV4TeC3hwf7OEH1Eh+eyKXXjjldtyog1K?=
 =?us-ascii?Q?MoybcJY6QZEUVKpmTj+YQVC23qaVKZpHNqrsEH5Ao0MnoWj3noQKtLvZgJOI?=
 =?us-ascii?Q?fJLJCnfbJTCXKZwqOALeRzwy2a5DRg8hceVlXyVTbfnd+Ey01ceps7YBqpdz?=
 =?us-ascii?Q?L2fR5oJL8pxe60g5/CAd7v6DP5VErrifCGXSmGGimQ6kivS4y+6sn9T5sdnM?=
 =?us-ascii?Q?LmegvWWATm5FT56UgXfYil0w54rd8xIHFa6W+asW3a/kciTMB02ydmvq6oBC?=
 =?us-ascii?Q?BIy9aoxR1oIqepGeUbnQwjhs85l/f5DN+tyt49UT0Q7kaMKVlDSMbgb/95ox?=
 =?us-ascii?Q?rhoOrG95uYsjLc57RWrgV/aYKEsrQLm/3s0o+WYcXEyH6VdGRK/Eu+PhGNQT?=
 =?us-ascii?Q?cIon30Df+gL7eiPg5B4rD5T5KAw+iK7LtIvKi8ZGxb9M0Xm5NZdq6m8yyhrP?=
 =?us-ascii?Q?yGPxbSSmQQikYBUGmPSNWBWWCCQojqdp6+mNxbnBTRhSxDTBmGeVZ8jLE2eZ?=
 =?us-ascii?Q?XOrhRoln21+9WkzdZGftVRTjmYqysw+47qqcDvmce90VaWN8sHazCF7GQiwH?=
 =?us-ascii?Q?q5wllA+mJgpMOsPCfH+wqhpXJttbb+O47DIQtGBsFjhwHIEsfKX6150QuCfQ?=
 =?us-ascii?Q?T6sqcNwdms83kk5vfotPcg+Vfm4xTMtFxJb5nphgdDRcj5cZt3ueX33vImk1?=
 =?us-ascii?Q?pAw/ofpTIleOdRhja/WC9wBOFhGrnnF4hN61I+DObcGI5BYjSL0Tu8wRUkwJ?=
 =?us-ascii?Q?y7FQS73wrbHv96loIRk=3D?=
X-OriginatorOrg: damenly.org
X-MS-Exchange-CrossTenant-Network-Message-Id: 4403bcfe-23b9-427e-5e7a-08d9f5e033e3
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 08:49:14.5403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 9b63ded7-95a0-4379-9afc-fbbce95c751b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7LizfvxQyTH/ZGD2lMc3HuZjwK5QuodqT43+Mj6VCy8WP98oPM/3JNlevWjM9mL5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Date: Tue, 22 Feb 2022 08:47:08 +0000
References: <20220222084207.1021-1-l@damenly.su>
User-agent: mu4e 1.7.5; emacs 27.2
In-reply-to: <20220222084207.1021-1-l@damenly.su>
Bad habit to stroke 'ctrl + k'. it should be "to avoid overflow"



On Tue 22 Feb 2022 at 16:42, Su Yue <l@damenly.su> wrote:

> User reported there is an array-index-out-of-bounds access while
> mounting the crafted image:
>
> =======================================================================
> [  350.411942 ] loop0: detected capacity change from 0 to 262144
> [  350.427058 ] BTRFS: device fsid 
> a62e00e8-e94e-4200-8217-12444de93c2e
> devid 1 transid 8 /dev/loop0 scanned by systemd-udevd (1044)
> [  350.428564 ] BTRFS info (device loop0): disk space caching is 
> enabled
> [  350.428568 ] BTRFS info (device loop0): has skinny extents
> [  350.429589 ]
> [  350.429619 ] UBSAN: array-index-out-of-bounds in
> fs/btrfs/struct-funcs.c:161:1
> [  350.429636 ] index 1048096 is out of range for type 'page 
> *[16]'
> [  350.429650 ] CPU: 0 PID: 9 Comm: kworker/u8:1 Not tainted 
> 5.16.0-rc4
> [  350.429652 ] Hardware name: QEMU Standard PC (Q35 + ICH9, 
> 2009), BIOS
> 1.13.0-1ubuntu1.1 04/01/2014
> [  350.429653 ] Workqueue: btrfs-endio-meta btrfs_work_helper 
> [btrfs]
> [  350.429772 ] Call Trace:
> [  350.429774 ]  <TASK>
> [  350.429776 ]  dump_stack_lvl+0x47/0x5c
> [  350.429780 ]  ubsan_epilogue+0x5/0x50
> [  350.429786 ]  __ubsan_handle_out_of_bounds+0x66/0x70
> [  350.429791 ]  btrfs_get_16+0xfd/0x120 [btrfs]
> [  350.429832 ]  check_leaf+0x754/0x1a40 [btrfs]
> [  350.429874 ]  ? filemap_read+0x34a/0x390
> [  350.429878 ]  ? load_balance+0x175/0xfc0
> [  350.429881 ]  validate_extent_buffer+0x244/0x310 [btrfs]
> [  350.429911 ]  btrfs_validate_metadata_buffer+0xf8/0x100 
> [btrfs]
> [  350.429935 ]  end_bio_extent_readpage+0x3af/0x850 [btrfs]
> [  350.429969 ]  ? newidle_balance+0x259/0x480
> [  350.429972 ]  end_workqueue_fn+0x29/0x40 [btrfs]
> [  350.429995 ]  btrfs_work_helper+0x71/0x330 [btrfs]
> [  350.430030 ]  ? __schedule+0x2fb/0xa40
> [  350.430033 ]  process_one_work+0x1f6/0x400
> [  350.430035 ]  ? process_one_work+0x400/0x400
> [  350.430036 ]  worker_thread+0x2d/0x3d0
> [  350.430037 ]  ? process_one_work+0x400/0x400
> [  350.430038 ]  kthread+0x165/0x190
> [  350.430041 ]  ? set_kthread_struct+0x40/0x40
> [  350.430043 ]  ret_from_fork+0x1f/0x30
> [  350.430047 ]  </TASK>
> [  350.430047 ]
> [  350.430077 ] BTRFS warning (device loop0): bad eb member 
> start: ptr
> 0xffe20f4e start 20975616 member offset 4293005178 size 2
> =======================================================================
>
> btrfs check reports:
>   corrupt leaf: root=3 block=20975616 physical=20975616 slot=1, 
>   unexpected
>   item end, have 4294971193 expect 3897
>
> The 1st slot item offset is 4293005033 and the size is 1966160.
> In check_leaf, we use btrfs_item_end() to check item boundary 
> versus
> extent_buffer data size. However, return type of 
> btrfs_item_end() is u32.
> (u32)(4293005033 + 1966160) == 3897, overflow happens and the 
> result 3897
> equals to leaf data size reasonably.
>
> Fix it by use u64 variable to store item data end in 
> check_leaf() to
> avoid u32 overflow.
>
> This commit does solve the invalid memory access showed by the 
> stack trace.
> However, its metadata profile is DUP and another copy of the 
> leaf is fine.
> So the image can be mounted successfully. But when umount is 
> called,
> the ASSERT btrfs_mark_buffer_dirty() will be trigered becase the 
> the only node
> in extent tree has 0 item and invalid owner. It's solved by 
> another commit
> "btrfs: check extent buffer owner against the owner rootid".
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215299
> Reported-by: Wenqing Liu <wenqingliu0120@gmail.com>
> Signed-off-by: Su Yue <l@damenly.su>
> ---
>  fs/btrfs/tree-checker.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 9fd145f1c4bc..aae5697dde32 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -1682,6 +1682,7 @@ static int check_leaf(struct extent_buffer 
> *leaf, bool check_item_data)
>  	 */
>  	for (slot = 0; slot < nritems; slot++) {
>  		u32 item_end_expected;
> +		u64 item_data_end;
>  		int ret;
>
>  		btrfs_item_key_to_cpu(leaf, &key, slot);
> @@ -1696,6 +1697,8 @@ static int check_leaf(struct extent_buffer 
> *leaf, bool check_item_data)
>  			return -EUCLEAN;
>  		}
>
> +		item_data_end = (u64)btrfs_item_offset(leaf, slot) +
> +				btrfs_item_size(leaf, slot);
>  		/*
>  		 * Make sure the offset and ends are right, remember that 
>  the
>  		 * item data starts at the end of the leaf and grows 
>  towards the
> @@ -1706,11 +1709,10 @@ static int check_leaf(struct 
> extent_buffer *leaf, bool check_item_data)
>  		else
>  			item_end_expected = btrfs_item_offset(leaf,
>  								 slot - 1);
> -		if (unlikely(btrfs_item_data_end(leaf, slot) != 
> item_end_expected)) {
> +		if (unlikely(item_data_end != item_end_expected)) {
>  			generic_err(leaf, slot,
> -				"unexpected item end, have %u expect %u",
> -				btrfs_item_data_end(leaf, slot),
> -				item_end_expected);
> +				"unexpected item end, have %llu expect %u",
> +				item_data_end, item_end_expected);
>  			return -EUCLEAN;
>  		}
>
> @@ -1719,12 +1721,10 @@ static int check_leaf(struct 
> extent_buffer *leaf, bool check_item_data)
>  		 * just in case all the items are consistent to each 
>  other, but
>  		 * all point outside of the leaf.
>  		 */
> -		if (unlikely(btrfs_item_data_end(leaf, slot) >
> -			     BTRFS_LEAF_DATA_SIZE(fs_info))) {
> +		if (unlikely(item_data_end > 
> BTRFS_LEAF_DATA_SIZE(fs_info))) {
>  			generic_err(leaf, slot,
> -			"slot end outside of leaf, have %u expect range [0, 
> %u]",
> -				btrfs_item_data_end(leaf, slot),
> -				BTRFS_LEAF_DATA_SIZE(fs_info));
> +			"slot end outside of leaf, have %llu expect range [0, 
> %u]",
> +				item_data_end, BTRFS_LEAF_DATA_SIZE(fs_info));
>  			return -EUCLEAN;
>  		}

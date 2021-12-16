Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47080476D76
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 10:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhLPJc0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 04:32:26 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:60623 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230199AbhLPJcZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 04:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1639647144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V3fa+phxK9Lwon3Nx3wWUeOi0VK36S+58ETtETuoqH8=;
        b=deOixgb/1QZKGn+DjMxy3efZKSR21Eyu94CUBmTzMTr7kpwyaD7oK/Tt7AqdLVkvmjIqfl
        aX7bqjrZxMtCLvgc6rusQRwyNrtVa8wfDtysx8erUzQr2DMqX7vBChDiGxYAm22YUhq4FA
        ZHJe+bdqFEf8HA5XOi7YNSKCG9YRWPg=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2055.outbound.protection.outlook.com [104.47.5.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-17-vsm5mLc5OXeCAI2ZgWjicQ-1; Thu, 16 Dec 2021 10:32:22 +0100
X-MC-Unique: vsm5mLc5OXeCAI2ZgWjicQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxWPC15Ve7mFlZmgwsYeCe09v5uxfMfsZPLzp+Prm79UlKmO7NI4+gG58r1Ptn4zqYt4NCavZMxmQuR2GLBhy8x8b3XAf2axQlSTWgsrs5EtmE1yiCEETh2rg6NApDVHh0qeoa9XaGBQgh1TrJcau0jKh+ikW4bEpIz3xPCfHeC5j3pfWfJwi1F/avUjsM4zW5xRoV1s2xClrTjc/bJeHPGXqTInnBR8MrKPCk2Omc5FELRorGgsecQncM3YoxdkD3YWzmLvJWFXQBbISKij6WkFXL3xxoLzKdal5FfN7u25flMDSOi1fDkeYnqr7ogrO0BWA5XSt0KmODnFcW6vPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3fa+phxK9Lwon3Nx3wWUeOi0VK36S+58ETtETuoqH8=;
 b=NxVuTPHQSo9vcyoTem4RAomGPvPFWxDJV6zq0w/cba0WJQSPcCfSJJfMdF59/RpS92BEdz0p8e23l9ZWSxWq+IxDweJkAGXtO+0enIwOBXFVOj621Xp7MaDoIW0yipcoeG6WKtCNXrGgt5A3nKXg6RaB0FvyDvMhxBHxG5fJHDxxR6EKplMlsHbX3QWT+1B71cMJ32myBJNy7wAsUnJ4YA4qajjPp1ClyKYz/O3r4JuHt7Oji67L0C5dboi5qjfUfTa+ojumuyqNpn8BDhUZTNJNEt2Xj1uOIh1s8oyjT5hw3lDGT3Zz6TQmcJgZT41v8Xeh9VI2drOUotOiyIXl4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DU2PR04MB8678.eurprd04.prod.outlook.com (2603:10a6:10:2dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Thu, 16 Dec
 2021 09:32:21 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e%5]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 09:32:21 +0000
Message-ID: <7cd18b3c-e6bd-f5fc-3c6f-92da2f65cd3b@suse.com>
Date:   Thu, 16 Dec 2021 17:32:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH RFC] btrfs: reject transaction creation for read-only
 mount except for log recovery
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20211216091441.53270-1-wqu@suse.com>
In-Reply-To: <20211216091441.53270-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0111.namprd03.prod.outlook.com
 (2603:10b6:a03:333::26) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5084c6bb-fc76-4a0a-7014-08d9c076f596
X-MS-TrafficTypeDiagnostic: DU2PR04MB8678:EE_
X-Microsoft-Antispam-PRVS: <DU2PR04MB867850C12E6172BC9EA14393D6779@DU2PR04MB8678.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bShHY1WZhPhGedYiIy/b4hBihktzbjwX97btrs+lbh0hMqrtlAYajBdpFGVXqe2BoatRmS1oq/66e7yXLei4Bz/40x0qhJv5hgFRNY36cU1EZVh8F58EUhfJkUEoAWB7Af0h3292a8st5Amtkzzy3BPouJj483z3iyXMdCD7Ec5imgaUqZQL0q1MoA8uBGip9lgxTmIEkiNCsLZ16lPwdEoB/wHfUaXflihYHrkbEMYdtvPwixsM/kKgCU+t1YeFdwM7wxPlFkPSNbHY5Ui8IaWCz1Mr5O1dJ4ikbWRtBjR5e7idWLCL5L4+PAflmmzoeb2luoGRO92ueCUCRAeQwIobqLLyt0s/o0wMMfwn8M2LJlIbnQCAeIyR9DwJkmZiqMytrKXx1I2w0ugVmX7cOq/FxohcjM/wZ0ODAGDBYHFjzARlVeJ5/a9SMyl22OBxajVuNKl93FC7u1Zx9t1zliUrPToOve8UiMODar7WHxhLcnQYpiwRhLL8euRe5Nys3T1HqO3IU9GeR4KzeOsHnrWq5l/Goqnkn4SRk92I2nPOI7mA6WQtF5vz5quhDSh36P3SlKH3S2dw2c464ueEweTo8Er02CFbdbhYQCtp11AL/apkZWbs0Rtqq+u4Nl8XL310p2R6JTqPhiIQleII6hMT6qzK4tuOOyMtzQBcVaxFNdvY7m0ELNytVLCpFmz6JdBJSsUc6f4XUgXRsxMPBStWiauParPJQNVAW9H3mDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(66476007)(5660300002)(66556008)(8936002)(2906002)(36756003)(86362001)(38100700002)(6486002)(31686004)(66946007)(31696002)(2616005)(316002)(186003)(53546011)(6506007)(6512007)(26005)(8676002)(6666004)(6916009)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2RZbW1sZ0wrcU9Mcmo1YVhkUUI3UWFnQ1Y3aUdGdnlXWHlxTnJwODg3MlEx?=
 =?utf-8?B?RmNaN3dmaUQxKzJNSGpnNHlTMEkrc1YvZDZJNmprRnRJWUlFQm5LUzAyL2h0?=
 =?utf-8?B?eExoWDdvUHZjNzFvZVg1bnB0aEwwZms4ZlNmbSsySmNkME9PQnc5dHFZdWtp?=
 =?utf-8?B?NWFOb3BIUlhJMkJIRGIzcVpiL045RUUreGY1OUJPTVpSWDV3bml4aFNOZm1n?=
 =?utf-8?B?UitxOXhxYkhYVnpEM0VSVVlER2JvTUtLdEhzOHd4V2xVNHI2QTcwejk0OUcz?=
 =?utf-8?B?RXJwSUp6UGVJMzRrc1NLcUV3allsdUk5SUFid2pjcVM4Z2RRdTBuWHU1K1FZ?=
 =?utf-8?B?SWFQZkhLZWhLTkFuSTBVdEl4RDltU0VyOUhSRE1meEQ4Zk5KTnkvcjJqV2dO?=
 =?utf-8?B?V3pYWnFUR3UzN016SEgxcVhpMnBOTkZqQTNTV2I3KytROHUvbERNQXR3RVRw?=
 =?utf-8?B?QzVwQWFsM25JSmJEVjhjSmFpTjc0ZlBSSWl2c2Z2cytlUTl3dVZKVHQ4amtu?=
 =?utf-8?B?WVFvcnczQU9qR3FFWjR1dUhiSG83YXdrbVdZUkNrem44WVdPc0U4STkxd21o?=
 =?utf-8?B?djdoQUkzR0Z0aUpSdmtpK1l5WjdEdFl2NVMwcDJJdnBrcmEvZThnTGlRZkQy?=
 =?utf-8?B?czMyYkdUWXh1c2VXTmFkK0VENWdia284NW1sRlh5Ti8yRHJNVXdXYm0wVmhF?=
 =?utf-8?B?Y25MeC9SblNVY2pTYWt3SG0xNlBIRm5QM1h2Tlo1Ykh1VnhWUVZkaFRCeW1p?=
 =?utf-8?B?bFRPaUVLaXJzcmhiN3I4TGkyYmh1NW9DcmhaUnJER3hQa3VrZzljaFdHcmlJ?=
 =?utf-8?B?TGJEd1ZsTC9Nd0l1bktOQ3dud0VITzZBNDBUTkxaT24wczB6M2VqME1QKzB6?=
 =?utf-8?B?aU9FRFZpNkxidGdJM1B5Wk9GWXc3ZFlaZ0Z4bHdzdER1MGc2UWg2YUExWFZM?=
 =?utf-8?B?NkhvcjhpNHpsTktTdEFWMWQ4QTQ5ZjFXZ005UGtPT2lZbTBNamlPVksxeDZT?=
 =?utf-8?B?NkNRby9QSGlwSzZjNWJlNlVLTENzYUU4Z2lmeG03aGJHV0NUUGxrSGl3cTV6?=
 =?utf-8?B?RFpnM0JqSlplbklIUjFJb0JpQjFHcGNybk44cGQ5bHY0UmVzSnFSeUFSTkZt?=
 =?utf-8?B?M0R2bnJobEtlQlB1Qkkzc3NFbWNzcXphWFdrUFRDZXpFdVQxNkwxbURXcWJM?=
 =?utf-8?B?SDVmYVRDWGJZUHdIaDFhZXdpak1LeWJ3Z05ROW9JQ09VOU9JL2IzWWZvbzIy?=
 =?utf-8?B?em1EQ1pxdE1YbGwzb3JFSUxueVF2dXg0a0xjRFNBL2VFcHZtWW9EZ1N3WWhG?=
 =?utf-8?B?UmZSMjI4WE5xRUVtRWRibk5wODBFYlJUZ0pLd250NDIyTmpVRkJSOS9FUGF0?=
 =?utf-8?B?NHd2cWlONjBQVWtHVnNxak5LZ1A0OEROK1UyVHJkOU5VYVB4ZTBQSkx1SUVz?=
 =?utf-8?B?Y1hBR1JPWjk5dXZKdnE5NWV2VzQzREp1UkdQZitMTkh2QjZJcWxSc3AyenVV?=
 =?utf-8?B?THRJemkrZUZ0QjZVeDlFTEw2Y1l1b3g1UldSeGZSbXcxRmxsMEJMMyt4ejl2?=
 =?utf-8?B?N2ROaHlHKzBlcFAwS2FlWm84aHZHQVhydUw3cWFqNldQRW5ZYUh2M3JXdWZo?=
 =?utf-8?B?WEkwN1VOSmJoN0xweEs3TXJ4Qi83WjEyWU1Hc0Z6eVQ4TzNOemhGM29lQzVO?=
 =?utf-8?B?RVltSEd5Y1MyWkFhMTB4Wkxoa0FKdmdOa2NWUTU2anVuYWR1c1NKRG5PUG1J?=
 =?utf-8?B?MnhiWmJUZmxZWXdnV1EwRHpqenBiWVVOS0VKN05qc1l1NUVROW12L2RXYVZW?=
 =?utf-8?B?TjZTZERmeWR4Kzl4K2ljTm5SSGlYQ1lCWCtkQ01XL1VLTGZUMFFnVExoOVRq?=
 =?utf-8?B?THVFa29xWlVMQXhYem1kcHBPVFpYcURDSDh2Z1JZcmtlWEVraTRqYmprN1pp?=
 =?utf-8?B?a3JxWTh3S21VTTdzRlhkbEZ0N1NxczFEKzNZNm9XcE9TWUhCMCtBREQ1QjYx?=
 =?utf-8?B?T3ZVRWtnbWwwTFlMbnVsSmE4akRhaHBleEE4eWxsaEU2VlpxK051UkhRNU9w?=
 =?utf-8?B?empIUCtNY2tnZTJDaDdzVU81VGRRM2x5UnZmOGRBVEM0YzhrUkZVV1ZFSUE4?=
 =?utf-8?Q?omIg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5084c6bb-fc76-4a0a-7014-08d9c076f596
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 09:32:20.9836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3GvGSnokct/fEnZA/Bzzof4Rga3f5safQNGNZCbexb2MAuwAQz3epz1mHq0L1yT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8678
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/16 17:14, Qu Wenruo wrote:
> [BUG]
> The following super simple script would crash btrfs at unmount time, if
> CONFIG_BTRFS_ASSERT() is set.
> 
>   mkfs.btrfs -f $dev
>   mount $dev $mnt
>   xfs_io -f -c "pwrite 0 4k" $mnt/file
>   umount $mnt
>   mount -r ro $dev $mnt
>   btrfs scrub start -Br $mnt
>   umount $mnt
> 
> This will trigger the following ASSERT() introduced by commit
> 0a31daa4b602 ("btrfs: add assertion for empty list of transactions at
> late stage of umount").
> 
> That patch is deifnitely not the cause, it just makes enough noise for
> us developer.
> 
> [CAUSE]
> We will start transaction for the following call chain during scrub:
> 
> scrub_enumerate_chunks()
> |- btrfs_inc_block_group_ro()
>     |- btrfs_join_transaction()
> 
> However for RO mount, there is no running transaction at all, thus
> btrfs_join_transaction() will start a new transaction.
> 
> But since the fs is already read-only, there is no way to commit the
> transaction, thus triggering the ASSERT().
> 
> The bug should be there for a long time. As I can still reproduce the
> crash at v5.10 kernel.
> 
> [FIX]
> Currently I choose to separate the log recovery code transaction with
> other transactions, and reject all other transactions if the filesystem
> is mounted read-only.
> 
> But I'm not sure if this is the best solution, thus this patch still
> requires for comments.
> 
> There is some alternatives I can thing of:
> 
> - Don't start new transaction in btrfs_inc_block_group_ro().
>    We have btrfs_join_transaction_nostart(), but even with that we still
>    can't ensure there is no new transaction started and committed after
>    we called btrfs_join_transaction_nostart() and got -ENOENT.
> 
> - Allow btrfs to commit empty transaction without writing any thing
>    If we know this transaction contains no dirty metadata, we allow
>    it to be "committed" even on RO mount, although no real data will
>    be written to disk.
> 
> And even with current fix, I'm not 100% sure if we won't get a crash if
> we run read-only scrub with frequently ro/rw remount.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/block-group.c |  6 +++++-
>   fs/btrfs/transaction.c | 14 ++++++++++++++
>   fs/btrfs/transaction.h |  5 +++++
>   fs/btrfs/tree-log.c    |  2 +-
>   4 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 1db24e6d6d90..13391d562189 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -2546,6 +2546,9 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
>   
>   	do {
>   		trans = btrfs_join_transaction(root);
> +		if (IS_ERR(trans) && PTR_ERR(trans) == -EROFS)
> +			return 0;
> +

Here I should still go through ro_block_group_mutex locking and 
inc_block_group_ro().

By this, we don't need to change the BUG_ON() call.

But the core idea is still the same.

Thanks,
Qu
>   		if (IS_ERR(trans))
>   			return PTR_ERR(trans);
>   
> @@ -2621,7 +2624,8 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
>   	struct btrfs_space_info *sinfo = cache->space_info;
>   	u64 num_bytes;
>   
> -	BUG_ON(!cache->ro);
> +	if (cache->ro)
> +		return;
>   
>   	spin_lock(&sinfo->lock);
>   	spin_lock(&cache->lock);
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 03de89b45f27..306eaeb41ec9 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -591,6 +591,13 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
>   	if (BTRFS_FS_ERROR(fs_info))
>   		return ERR_PTR(-EROFS);
>   
> +	/*
> +	 * If the FS is mounted RO, we only allow transaction for log recovery,
> +	 * no regular transaction can be started.
> +	 */
> +	if (sb_rdonly(fs_info->sb) && !(type & __TRANS_START_IGNORE_RO))
> +		return ERR_PTR(-EROFS);
> +
>   	if (current->journal_info) {
>   		WARN_ON(type & TRANS_EXTWRITERS);
>   		h = current->journal_info;
> @@ -781,6 +788,13 @@ struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
>   				 BTRFS_RESERVE_FLUSH_ALL, true);
>   }
>   
> +struct btrfs_trans_handle *btrfs_start_transaction_log_recover(
> +			struct btrfs_root *root, unsigned int num_items)
> +{
> +	return start_transaction(root, num_items, TRANS_START_LOG_RECOVER,
> +				 BTRFS_RESERVE_FLUSH_ALL, true);
> +}
> +
>   struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
>   					struct btrfs_root *root,
>   					unsigned int num_items)
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index 1852ed9de7fd..24a743d91eff 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -106,8 +106,11 @@ struct btrfs_transaction {
>   #define __TRANS_JOIN_NOLOCK	(1U << 12)
>   #define __TRANS_DUMMY		(1U << 13)
>   #define __TRANS_JOIN_NOSTART	(1U << 14)
> +#define __TRANS_START_IGNORE_RO	(1U << 15)
>   
>   #define TRANS_START		(__TRANS_START | __TRANS_FREEZABLE)
> +#define TRANS_START_LOG_RECOVER	(__TRANS_START | __TRANS_FREEZABLE | \
> +				 __TRANS_START_IGNORE_RO)
>   #define TRANS_ATTACH		(__TRANS_ATTACH)
>   #define TRANS_JOIN		(__TRANS_JOIN | __TRANS_FREEZABLE)
>   #define TRANS_JOIN_NOLOCK	(__TRANS_JOIN_NOLOCK)
> @@ -201,6 +204,8 @@ static inline void btrfs_clear_skip_qgroup(struct btrfs_trans_handle *trans)
>   int btrfs_end_transaction(struct btrfs_trans_handle *trans);
>   struct btrfs_trans_handle *btrfs_start_transaction(struct btrfs_root *root,
>   						   unsigned int num_items);
> +struct btrfs_trans_handle *btrfs_start_transaction_log_recover(
> +			struct btrfs_root *root, unsigned int num_items);
>   struct btrfs_trans_handle *btrfs_start_transaction_fallback_global_rsv(
>   					struct btrfs_root *root,
>   					unsigned int num_items);
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 69f901813ea8..42369fa9a038 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -6478,7 +6478,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
>   
>   	set_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags);
>   
> -	trans = btrfs_start_transaction(fs_info->tree_root, 0);
> +	trans = btrfs_start_transaction_log_recover(fs_info->tree_root, 0);
>   	if (IS_ERR(trans)) {
>   		ret = PTR_ERR(trans);
>   		goto error;


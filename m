Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DA1476ED0
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 11:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbhLPKZj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 05:25:39 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:50876 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236003AbhLPKZi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 05:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1639650337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQkyVg+smlNywGqBD6etrl6iqQq2Ue5H9LiB73a3YAA=;
        b=P4KIM+QlSQYuzNSJyDdQEw50oUgh2IS0Z+Ugp4ZaLuRssuGxO4NnWM9Cj/G401t29HAFjN
        xJanzvDSs6NlxhwxQG++eEb1PMCUR68DgBr3/tWRoBvnHz7OkkTiMZFvxnuc7yJzOEu8QR
        1EC/UQIlJVaNBro4SZe8Vg9nhlCXlSY=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-41-Arw8OugEOLqviHf7mQ78WA-1; Thu, 16 Dec 2021 11:25:36 +0100
X-MC-Unique: Arw8OugEOLqviHf7mQ78WA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBPTspuuuyXhjxSLZdHm2c0DLJR+iNiVJAhQLlEOfELq1bkEcrOYl0KCTpqkMgnOQC1iGhfH2f82po3eg9KevhCVVRsXtEbEqkTUSvx4+A/oTx0/6+cTOvnjrrZAtMw+b2tLDsiB4DPqBn3cLiXnVIH3vFvEXQJIeSH/8pZDZzI/fZJFwBCy0/qZSuOu4muuMQEHH7gT14OGq63g6N5DDY2MrDvYltXDbH+wTocxCt08OGoww3Req5ji/PGLqoqbGggsY9dWUbGaNCeqSRr1j5V9C70EMVjsIuzKdy4P76e9BxFmHNuvJ2zTfmB48P5EDzobC5IYmjhz8Nhl9gWoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQkyVg+smlNywGqBD6etrl6iqQq2Ue5H9LiB73a3YAA=;
 b=BLB7axC53P/PM6A5usLSn4yILX3FiXW+6yk7luLZbJFFcKF2+SgRqLRqQ+dTk59TPG86cgtBGPZszWdJtytYouH3Yz4XZ/a86WwVk2KYugcoxe93wdJzjvmOyothBbgegrULeWDh2pmWbXWbSimDqWjJpks2hSBi/r5NY0vxdPqR+aDPAbvO+4gUuJIrHETAZFmm3XfdLDnFNZiBUn6ZZ12h8Kdh8h6YtZpDKYNPSsES7C//HmL1gXS3+qkNeADoe3u5ElhwiotlZiLRykN1ST1QDDAaYumPbw48MzwyhE1A7QfHPmGn9/J52ofljWWyOSjiU7fcxTlUQfazn4muTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DU2PR04MB8999.eurprd04.prod.outlook.com (2603:10a6:10:2e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 10:25:35 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e%5]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 10:25:35 +0000
Message-ID: <2a3876e3-e646-caae-96ca-55f1d5c1cac4@suse.com>
Date:   Thu, 16 Dec 2021 18:25:26 +0800
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
X-ClientProxiedBy: BYAPR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:a03:54::27) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66621020-f6df-452a-ded5-08d9c07e6561
X-MS-TrafficTypeDiagnostic: DU2PR04MB8999:EE_
X-Microsoft-Antispam-PRVS: <DU2PR04MB89990476EA92A3BB78098A56D6779@DU2PR04MB8999.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MhhCmjv0BNCU/Scor9E2c8FkRTKjx0NfTkjEBLvTtB2tIxVlChbRJC2ZthwMGZ7T5cqntihPAX4OiPABGZ5kdIQEWfOyGqTE2MnnvHoqAPN40NRXg+f5yE8G6sFvL0L4F2bBqYO3dI0WJuBw6qgk5zao8GynUlLatqC9C1eRy3IBo0APeUEMYKyPcUv0QQJGhc4iwD4MnbTiWq16EUj//ILFQj6xttoFuqBod2W2gL7lvgZyzf5mK7UtazqsUSQCLUW/IbJ4h9S8lt24o5/LgIuv5p4unMYz3hvVRPh3mxIWsvsTTe335ftPIkTM+LICX1mx/jz0e3VPys4JAkwgPC/TOpHd6kPBH2UAYSgjIFfEgZJcwSCMVZZiIgh7x3JtXJdP3lM7T8H4IleEemxOrXPVIObL/yf8tJtqsSMKmQUJwPKTdkGJiEMLVEEuD0r7PUa2E9d2FrWHHqunA4q6BnbTbG3rBCnCgr6YGIfU5rX+Q9F+GZxhwr1etKA+kTKmEYhN+5AolxFZRZIUvfG6kwnCUpBCXJA4FhalEZ9lBHWWN3O750tmFHgX1ASkEXIwmKba2aIpnOtD60j04SL3oli33KI7adE0I0QCgWHfL0wvlicRwYRVyI+CrF/4b8IsEYNya/Z5M1q62oqQLw/Ht5pBuAoPEGPWqUa/puLpa2KRYFfwR4xIUfWDBuKR/jCt9u8/KpFxjCNDkFnfhU1C2dNnR2ap3BbBosG/H4i6Xg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(186003)(31686004)(66946007)(86362001)(6486002)(38100700002)(6506007)(36756003)(2616005)(8676002)(53546011)(508600001)(8936002)(6916009)(66556008)(2906002)(31696002)(6512007)(26005)(6666004)(66476007)(83380400001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnVpd3U2M0R0UTNwU0hXbjhCNDZ0eERScEN5TWY5ZmQyUTIzN090K2hPKzhH?=
 =?utf-8?B?b3R2WE04SXZsVnhmaHJnZDY1SnRoODU3cjNuVFlYU3B1QW12elV2SlB0d1Bj?=
 =?utf-8?B?clhndGlVbHNnc1NTdFpzQkRTbnZkVU1KdjFaY29zK2RHdHkreEdRNENjNFlX?=
 =?utf-8?B?RDZacXpYMG5wOW81MTY2K1Y2SEphTzlsRHAvQkRoMkJlWEVzTGg5U054aDI3?=
 =?utf-8?B?RUpQdlB6STVlMXBEWGZQWTRESXVrTzMyNEJVMVVVK0hRRm9KSU9RQk9Ba29I?=
 =?utf-8?B?SWpXMzRVYk5rWHVzOWh2SUhrZkZ0T1ZPa3B1YStSU0lXZng4S2RTVmsrOUNY?=
 =?utf-8?B?dDRaYjI2RWtBTmdDdUh0cHlQMHJQYmQvcGVVNkZSRFpxdG80MWpIOGVIY3NG?=
 =?utf-8?B?YnBoaFJCUm5WSU9BZWZFL00rQUUvUU1ldC9kdzQ2R1hOTFlvc0QyN3lNUG9H?=
 =?utf-8?B?ejA1cG41SituTGF3NHU5dmVCdVA5cEpjMktwckhwNkRaUXg5dXVQNFFDcTUz?=
 =?utf-8?B?c3VCZVMxVzRpaU5RZ3Vhc2VqQnRZQnhqak5COE5Lc0R0N05NVGkxZ2NPTWJh?=
 =?utf-8?B?Vkd5QlNyWTA3eXZ2OVJnYmliblFzWXhSWDZzMno3R0FpRHRWd2xWZVRXWThn?=
 =?utf-8?B?TjVIZVp4SlRpQVdLT2pjWFhhUVIrVHVaZmZ3WjFYc1NkNDFSOVdaOVpveFVn?=
 =?utf-8?B?QS92cG5wQkJiM2gyZTRadXh6VWxNRm9rWXhnYkVwZk14YTN3UlFHMTVIbE54?=
 =?utf-8?B?ZVZtMFJtWGNpZHgrTHdZQTBUd0c3Yk9Ba056RW45NjA2K2pXZGRHS3ljT29X?=
 =?utf-8?B?RndpeG5TL1JsaTZVN1BNTlBqTi9TeGJBejlqUWxxZUtyQ2V4WWIwTmhneWpk?=
 =?utf-8?B?TDB5dVp1QnZCdldwVFFKeVM5WTNXNmNROGdBU203Y01WVnNoM2R6U1ZCK3Aw?=
 =?utf-8?B?VHJtSGE5MTVnc1FUcGZ1bVFrd0VMWENBUm5hUnQ5aFVNMEdlVXNudG1lY0hs?=
 =?utf-8?B?aUJGajl3dU85T3VJaXl6dWNxU3NRVGJYK0tUaTV2TmtEaXdDaElPMjJFNEJB?=
 =?utf-8?B?Y21GVlFEbW9xQkNDaFdReGVsVGhDK0pFM1hYN0dNeWJZMEVHdmhUY0pEMFQ0?=
 =?utf-8?B?M05OdmJYZVFOcWY2OUxhcW93eFI2SnlnS2l1NlUxY1l1TEhuNlZNd2VMNUdN?=
 =?utf-8?B?NThXQzZ0WjkzRm5GN1E0TlJJL2ZwdGtkSjdkdGRtTXRaejBoNFU1WFNEV1o0?=
 =?utf-8?B?Vy8wOENSNHBxSXVhRSs4dmZxTkZaZk9MdStVYXJsbDR6R3dTZFR3YTl0SlZj?=
 =?utf-8?B?b3VtVEIrY3ljd2d4WFdLSkhhMVM3KzFFTUpEVnZVWlRLN3ZpcUkvRzUrZkZn?=
 =?utf-8?B?aytRYXdJUVQ3NVJRd25sZnNXUEVkd3RaakhScjIvMEt3NUhGUFpnV280YWZK?=
 =?utf-8?B?SXVlMFcrdTVIQVAxZXFoN2tJKzNhdm1mVGZFQ3RsRjJXclRoSm5xRzRxR0l1?=
 =?utf-8?B?R25XaTkrM0JWTkpaQVFXSzJFNmdDTHhTbXVQTkp3dm5rNFJ0em1odFNUN0VQ?=
 =?utf-8?B?b3lkNWdLRUkzbWRmY2FSQThqS3Zrc055TWxHYy8zOEs0b1AveUl1YUFkSG8z?=
 =?utf-8?B?Z3JHUzBoOVhWN29ndng5YjcvWDFvbXUrQXFBRHo0dlRxSHdoNlU0a3d1VDFM?=
 =?utf-8?B?Y1hrREJpdExiTDNhVGdEN1JEbTh3aGlrY084MWx6R3dmOUNDalJPR2tYdlk3?=
 =?utf-8?B?ZC96WDhqeFk3UmxZOVErRTBTV1BGOE4rUFBCdGorYVFhRXh5VDdkalVJcFVB?=
 =?utf-8?B?SkZTRmVxeWsrTXJPeUMwczB2VlQxK2JMU1c5YXNEdy80cGh5Z1ppOTlXcVY3?=
 =?utf-8?B?dE9yVGk4MXdBSG53aW5CNEhqdmZrWmZZUlNDMWMxbWVpMUVsQ0NMZ0ROYndZ?=
 =?utf-8?B?c3FlUlpEUmxHSWtKSkg2RzNVMU9MWllIZU1zOHlTYU1xTG9sL2ZoMyttTks2?=
 =?utf-8?B?OW45VU9uUkRhUFlVM0N1VEtNeFpPSytWVzVtMVp6OXlxYkRMRENtaEdyc21W?=
 =?utf-8?B?ZlQ3WGZFZnZUelNSUzRXWHRUWjgzY0FJSnlqSnhiUTk0UTl3UWR0Y1B0UEZI?=
 =?utf-8?Q?F5t8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66621020-f6df-452a-ded5-08d9c07e6561
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 10:25:35.0534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2dPK9JFQwCkxNeJ/7TluPRuwnaPqoaThWbRs29bpm6uFso+9O0OkQzIyl9DyHJi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8999
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

This seems to be a better solution, after more testing with this patch.

There is another call sites which would need transaction start on 
read-only mount, adding new device to seed device.

If there is an hole, there will be more holes, and I don't think 
creating so many special cases is a good idea.


On the other hand, for such empty transaction method, we only need to 
make sure such transaction is always empty, and then can clean it up 
properly.

No extra impact on log recovery nor seed device.

Thanks,
Qu

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


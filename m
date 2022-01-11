Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B0348AAED
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jan 2022 10:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348269AbiAKJ4S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Jan 2022 04:56:18 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:27403 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237268AbiAKJ4R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Jan 2022 04:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1641894976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3a2vil/0KsFbPG8hClv/FzhtD/ugiNzA3GhjBCGgx8Y=;
        b=P546ZUUUWrlc70Q6C3VHJZ4+NIyNyBdjc6wOzZxKffzeiTSlIDtZUGXDSH6ulv8F/C9GIQ
        vo0o3HpYklnWEtYOR+gVA1nDTfpjhEZBHTyDxw05tCcyX/RPml0c5Ip3K15fxWM29rt2bB
        2nxr7bOYvCMKb5/z+NOw30aVbIWNeU0=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-10-Ood_sKhKMNaoCWNHgV-m8w-1; Tue, 11 Jan 2022 10:56:15 +0100
X-MC-Unique: Ood_sKhKMNaoCWNHgV-m8w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xt0nXrXR9BeCAztBR0n0m2kmqeHggcDgl8ZRx5tQCwMZQ1r64fCu11Ad9HUKrCsIs6Exzf/MdrCIkFjio4rNeQ5o3ifJTvL4AR6cvY9UGKiXT3WiGQgdJvWvXyjX7ikgcOSP75EiRXPRHHGaQENwFovgmhAra4XQD+7yX4ZcmntC4t05zsQreTRorxBWMSIDKoZoowlvq/hYWNUqhP1Sg7dMJDDIJxmwaJQ/xEl1+orBDaWVEXrv6aIMvwPS7jHCCpiurXzlxmY4QeBwFRVlwNZkBJ1OH3ql92yvuLvgVNMTRZAX0qEa8AW3UnEMO/x4WMffM9o1xbMYABUnGNY72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3a2vil/0KsFbPG8hClv/FzhtD/ugiNzA3GhjBCGgx8Y=;
 b=WQGW8D08jh+fwOllmNRyq5yY/GyoeFaMo0EdzyBpqKA2Pg6kz+VeP1rhrlEta/8JTf94Y91WkvjHePIvJV+3xdMUDU++WfeD7Bh/CC2MHxpCrRdHNI7HoZZXuEacnXvDv7nvExDx8d0y/sd/N/t+fl24SqIIK56Lz04pTiwBpjotH4PC+jde9JgEVZaYYZk0jZCNyVCmsKo2Cp8defWooGQqY/sT9CB3A6kL56XuhLhhzvzOOEsAGDcBGnfPgMCWel/aCfT2ZKSvhG6/xqjF/ExX6jdqNJn3dz2fTRiMaq6O+leANDnX5RtVGAmch7evH8e4JKjUYvsEdzOwPdCGnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 09:56:13 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e%6]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 09:56:13 +0000
Message-ID: <42641239-a6d6-f840-8247-7d6d950b4478@suse.com>
Date:   Tue, 11 Jan 2022 17:56:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 1/3] btrfs: use dummy extent buffer for super block sys
 chunk array read
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20220111023434.22915-1-wqu@suse.com>
 <20220111023434.22915-2-wqu@suse.com>
In-Reply-To: <20220111023434.22915-2-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f2aa753-d74d-4b5e-299c-08d9d4e89a25
X-MS-TrafficTypeDiagnostic: DB9PR04MB9451:EE_
X-Microsoft-Antispam-PRVS: <DB9PR04MB94516BD87261A8F450CAC9DDD6519@DB9PR04MB9451.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hQ7SPl9KUo2KMWJCaysxADTxB3bp2tf2ouTvOYp0C+pcCjrCgHICgKBM5RoXwrE4C645a3yd0D4/5WivClNMRBKU79Xjn4EPbV/k58ebmSZwj737FiGHkAtgOYkuk4uRkWUPw8pxu0EAlaESyT1MFi8UGtgngWYx00BZJ2seAicxRBnEII+t9QWSpUi7G6q5fJP33nuhunzSBwtJ7Jbg+U96QZ5mRD/QtTyx96caqTQyTostNiqpRiuLEAkXWFoafleMb0+blJLvHuS3EId2Zld0Pe3WTImVNV4iiMWsTURCbWQcXpOZqqeM0aexh25Lxst6AKpY5J0zSJzMVLRRQfLtTh0aMsz4EFJk81rlnF5gC9gsNKE6aWt48LxiDlDgsJAqMyR6FT+1ycS3zep5wyZ4wPlSs1YE91TmOPlZ7FUg+BM8puvon2Hh9oFwWlzlwZvTtCZRCD7tPNpeDvmM2Ii3vbYqtcCV3Z5UETU2/v0kHO5IL2rZMgI3ctklHWXnieQ+APG/rOWKU/ODLZqCgsjd+AQClB1BD0/2WIWGWS86u7hP45vsthu+w6RXhNfGJtadCqZiWEcrgUtiswm6EHdXuvVYSFemEVvqU+6ZBFA/GLf63h98PUzXPZouu72kZAqKOYEd6CdB4+gyiZKfwfK5TYwoYVU3W6AsasznOlUjUn4Fuy6NmwF0NvfdUhEVLlzrlCXwpwxCZrqnRaIyeYgEVCJrK9U9Ah0QpTM7RE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(2616005)(86362001)(83380400001)(8676002)(6512007)(6916009)(6666004)(31686004)(36756003)(66476007)(31696002)(66946007)(53546011)(66556008)(508600001)(186003)(5660300002)(38100700002)(8936002)(6486002)(2906002)(26005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ZRSFJGY3gzWW9EbU1PVzU2SFJyTnZDa24vMUkxTnBTa1RZc0hGNkpPOTQr?=
 =?utf-8?B?cW9BOGdBT2hVK2hkWCtCMGcyV3V5YW54WU85aXRxYnQwb3dBVVh5eVNwbCsz?=
 =?utf-8?B?RnFqSTVTTHBxT09JMXVqMjRVbWdrMXRWU0JhOThyazNwbEdXczJwTjNQU00w?=
 =?utf-8?B?b3RDVTQ3L1lVbHlPRkt3djBMOVNRMDBVYURVRGtKOEpFUCs2cXhBNkJPUzBl?=
 =?utf-8?B?eVQ1V2grclFsZ0tOZGNqOW8zMGx0b0s4NUVaMVdpWDBMaEZDTzFNVW5WbVR3?=
 =?utf-8?B?czBrZTM2aXBhNGRPRk1vQVk3NzZHa2xRL3VrbTZKSVk0THZDN0pzbDJBU2pE?=
 =?utf-8?B?aXh2L3ROenU5dVFITzlYT1JkdWpPdW1tK2tsaG1meXVXVVdhZldlUFlFQmFk?=
 =?utf-8?B?ZE5kektGeTNPQkNvejYydEIrVmRRTjYrRjRzN2UrZGh4enMyV1IzZENxbndZ?=
 =?utf-8?B?REx3bDFUR0RSNW9DZ1EwN2Zmb1JQVUQ4RTdwS21FcXVqY0gwZkV4TGJpQi9n?=
 =?utf-8?B?dDNWcis0ZDBFVlBYdnFsYlM3dERVd3BHU0cxOCsyVnRiWFZqL0pLVEJsMDNZ?=
 =?utf-8?B?TklsNDN1bStJNnZNQmVoSTRmdUtZVXZHWGpZRFp3VnZ4UzJmWXlOU3h0V2lM?=
 =?utf-8?B?aXZEZzhXOWdHb1VBNDlXNVMzK3JqNWRHN21NWmprc2pzWjAyQWNXN2pObDdQ?=
 =?utf-8?B?bHUzSm1xMzc2OCs0bno2Z0VUUVBxbnJraU5wdXR1ZldvS2V0ZGxtVHplaEd5?=
 =?utf-8?B?RC9HT0FLVUhhM0xBcnl0RHlzc2dHS3pEQ2dvaW5MZ1ZFZ0xjY2FhTkZVR3ZB?=
 =?utf-8?B?RWpCYnZuWDcvejlFK014ZHZJRzYvK0JEbnMreC82ZHRoVjV5TVdUVk5vcnlv?=
 =?utf-8?B?WE90MEhHWUVUekpuamVFVUxQVkZqSzNrZmVzekZYZXJidlRTTmU0ZzFOMEhK?=
 =?utf-8?B?QjZ1aFRGcEYyKy94Slp1bmY5QzZvbENrTUtyd3c4Y0YweC9PbldraUZTRTFM?=
 =?utf-8?B?Z3RjMmpNTFdlQWpnZzRCOHI4SUtsc3Y3ODlUQ0ZhQ25aUnlpSlljeE4vTVpj?=
 =?utf-8?B?UitCWkxMZmhYQyt5U3FSV1JZaVFxNHFMUnhHY0w0djRYOXYyRmQ1bWZtN2Yy?=
 =?utf-8?B?bW1jYm5CVFZWKzVKNHhXYU1nR3ZSSEpRVENPRVlWc2xyN0pLbGx4bnB6TVFS?=
 =?utf-8?B?N2JKSnM5d3ZxUHhPdEFCR3o1dzlSREFHSjRJVXd0Qkt4VWxWUUU2Mm1oRFhN?=
 =?utf-8?B?dEZrQnd2ZE5iTWhNMjFSakNNMi9FcHdZc0cxMTV3NnpvcldmVVB0eG1kZHVG?=
 =?utf-8?B?TlBpeFkxd2w0YmFYQlJEWEM0WWJIdk5XVzdTSUFvbVlQWCt4QW01Qi9BZXk0?=
 =?utf-8?B?V09XWURQV292OWlhSXRMVmE0RW9Eak8xdHltZkNzRmRqUTY2SXZZOEpGRExN?=
 =?utf-8?B?K2dZSTVDWTBvU0JmMUhud1ljZjlaNi9QMVFyeXk5TFk2cGtUdlhoZ2l1VXo2?=
 =?utf-8?B?R2NNd2J6RGNXajlzL3pseHI4OElQYUhOdzZrazVraWxrcDZiZFhtR3hUbnpO?=
 =?utf-8?B?L0IwWTRDcEtpeElWaGEzYmJFaVd6bkx2Z2RSc3lieGkxTkZqc2x3eHUwSkpE?=
 =?utf-8?B?TXQ1NGRQbkR5aDh1eU9YeGw3K1JOSUh6Szc4TDlBSVptelFhUmp2bVBvdi9v?=
 =?utf-8?B?NGlqUnptYTdRWlN6WFlPZTFKMHBLY1d6d0FPYVJDVnlQMVVNUll5aWxYUzJp?=
 =?utf-8?B?aFdsWmJaQmdQRWpWMlQzL1Z4b2I4TExKK1Nyb0h6SEE4ZTd3Q05KMFBPczNU?=
 =?utf-8?B?VURpN3NkZ0txWC9WcjVLaVk2cUdZbG96VnczR3c3eHlXdUFZRkRjTzJJZWFD?=
 =?utf-8?B?cmV1eVZVMVE4Nk9xam1xNXc3dGhYWDVJQkRydUZzN3VnMk85R2p3VEYrSnMy?=
 =?utf-8?B?UnhCN0x0d3J6SGJyZFc4NHNsRmpSYzVZWXhtUGJwMmozYzdqV3JRWmJYZUJy?=
 =?utf-8?B?NmhZOUZVeTVndVk1TzNrMzMwMXlrejRtUkpzV0s5RUlKUjNpU3BsbFdyRlc1?=
 =?utf-8?B?dUtpdVNldEtwRVFSL1NmOVRzU1Q0VVozYjRRNXEvTmZyUy9ldXNFN240eWZI?=
 =?utf-8?Q?Esfw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2aa753-d74d-4b5e-299c-08d9d4e89a25
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 09:56:13.6087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5FEVTQJOqTSe+aJ5jSVHiQr4eDYnjRQy+HIJDTuhv1xAto3OMFlMXfoMeDXY48P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9451
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/11 10:34, Qu Wenruo wrote:
> [BUG]
> During test for 16K page size with 4K sectorsize and 64K nodesize, btrfs
> will reject the mount with the following dmesg:
> 
>   BTRFS warning (device dm-1): read-write for sector size 4096 with page size 16384 is experimental
>   BTRFS error (device dm-1): tree block crosses page boundary, start 65536 nodesize 65536
>   BTRFS error (device dm-1): failed to read the system array: -22
>   BTRFS error (device dm-1): open_ctree failed

The message is not caused by this reason, but the wrong boundary check 
in the 2nd patch (which is already fixed in v2).

> 
> The rejection only happens with sectorsize=4K, page_size=16K and
> nodesize=64K combination.
> 
> For sectorsize=4K, page_size=16K and nodesize=16K (default) case, it
> works fine.
> 
> [CAUSE]
> The problem is in how we read sys chunk array.
> 
> In function btrfs_read_sys_array(), we allocate an extent buffer and
> copy super block into the extent buffer, so that we can use various
> extent buffer helpers to do the work.
> 
> But the problem is, we're calling btrfs_find_create_tree_block(), which
> will do all the validation check, including the page boundary check for
> subpage cases.
> 
> [FIX]
> In fact, we only need a dummy extent buffer, without all the checks for
> a real extent buffer.
> 
> This patch will replace the btrfs_find_create_tree_block() call with
> __alloc_dummy_extent_buffer().
> 
> By this we can:
> 
> - Set the extent buffer size to BTRFS_SUPER_INFO_SIZE
> - Avoid the unnecessary validation checks
> 
> Also since we're here, remove some stale comments on setting the eb page
> uptodate, as now set_extent_buffer_uptodate() can handle dummy eb cases
> without any problem.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/volumes.c | 27 ++++-----------------------
>   1 file changed, 4 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b07d382d53a8..00c7f5cf4b52 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7373,7 +7373,6 @@ static int read_one_dev(struct extent_buffer *leaf,
>   
>   int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
>   {
> -	struct btrfs_root *root = fs_info->tree_root;
>   	struct btrfs_super_block *super_copy = fs_info->super_copy;
>   	struct extent_buffer *sb;
>   	struct btrfs_disk_key *disk_key;
> @@ -7388,31 +7387,13 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
>   	u64 type;
>   	struct btrfs_key key;
>   
> -	ASSERT(BTRFS_SUPER_INFO_SIZE <= fs_info->nodesize);
> -	/*
> -	 * This will create extent buffer of nodesize, superblock size is
> -	 * fixed to BTRFS_SUPER_INFO_SIZE. If nodesize > sb size, this will
> -	 * overallocate but we can keep it as-is, only the first page is used.
> -	 */
> -	sb = btrfs_find_create_tree_block(fs_info, BTRFS_SUPER_INFO_OFFSET,
> -					  root->root_key.objectid, 0);
> +	ASSERT(BTRFS_SUPER_INFO_SIZE <= fs_info->nodesize &&
> +	       BTRFS_SUPER_INFO_SIZE <= PAGE_SIZE);
> +	sb = __alloc_dummy_extent_buffer(fs_info, BTRFS_SUPER_INFO_OFFSET,
> +					 BTRFS_SUPER_INFO_SIZE);

This is not good for 64K page size, 16K sector size.

It will cause crash in generic/205.

As later set_extent_buffer_uptodate() will use eb->len to set the page 
uptodate, using subpage routine.

But 4K is not aligned to 16K sectorsize, and will trigger an ASSERT().

Thus we need to use alloc_dummy_extent_buffer(), without "__" prefix here.

The patch has been updated into github.

Thanks,
Qu
>   	if (IS_ERR(sb))
>   		return PTR_ERR(sb);
>   	set_extent_buffer_uptodate(sb);
> -	/*
> -	 * The sb extent buffer is artificial and just used to read the system array.
> -	 * set_extent_buffer_uptodate() call does not properly mark all it's
> -	 * pages up-to-date when the page is larger: extent does not cover the
> -	 * whole page and consequently check_page_uptodate does not find all
> -	 * the page's extents up-to-date (the hole beyond sb),
> -	 * write_extent_buffer then triggers a WARN_ON.
> -	 *
> -	 * Regular short extents go through mark_extent_buffer_dirty/writeback cycle,
> -	 * but sb spans only this function. Add an explicit SetPageUptodate call
> -	 * to silence the warning eg. on PowerPC 64.
> -	 */
> -	if (PAGE_SIZE > BTRFS_SUPER_INFO_SIZE)
> -		SetPageUptodate(sb->pages[0]); >
>   	write_extent_buffer(sb, super_copy, 0, BTRFS_SUPER_INFO_SIZE);
>   	array_size = btrfs_super_sys_array_size(super_copy);


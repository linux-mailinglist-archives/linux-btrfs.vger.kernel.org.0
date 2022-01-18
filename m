Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22674918F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 03:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346519AbiARCtI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 21:49:08 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:31558 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343821AbiARCl5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 21:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1642473711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VqPqiyfmQv5XNxR2wYOw465jXwCR8WYY+tn3IBme24A=;
        b=DXP4s+pMtyRy96tJODdmpAJh3lVRchptmBe9ogCoN2oArBZPfRAebtMNSCOnZrsJb9GUvQ
        dYMJNI5+qAFBZU9x5lGs4JZdFp9qp8MSVVhWLBXxhOBUsckQdsYKj6WiWSrwaKm5R7aGN4
        vNLNzHwUpTtD5id6G5aRUjSjF9sCAoM=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-lh3yjVJmMtu1CATwSHZuFA-1; Tue, 18 Jan 2022 03:41:49 +0100
X-MC-Unique: lh3yjVJmMtu1CATwSHZuFA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WThYEWQgJa+iJ3glCw2QFz/40CGPUAqnuPh+hqg+7rd713NA3FrVjG8UQq93N+bgR2egUFY/4piR9xaPdWXcehuxkbWiJ8lDNFwEFdn1+iiSWzSkbN5RXEaXrWk5WYibQad70OlXRe1+qLgsPxwTcSD2/4AnSim2g5sVdIV8yOWlM+AZY10uRx3vScA5GuDS5WoNTnkgcwKYVZxjTNSSlD1YdeZb0uT0CX3N/mrLBGadnvA0n8FENWx4WNYAipmeSaCTv6O9pKI2zeSs/rXEVGqc7uw6435kpMUcDE2N8r2ro2dssRgoUcNQ+seKPpnFkHx7lDyxZ+D564dGMIFOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqPqiyfmQv5XNxR2wYOw465jXwCR8WYY+tn3IBme24A=;
 b=Zm5PqRXFiHYY7Nc2t59v0Pf7LXHqPdC9Ic/YUJSYmHZ8IJee9p6N6eXDDKzk1Nv77rZqPnwDIRv8BxEbul8Th7+ckgb3zYH6EYJEa4DdV/R61LfFEpsT1JI/374XMufFCgwG8keFCT12RDdU+SqL1/aQw13sOv+LkszM6Bl7uwFiaZdL5byBZ+tw5xg112R5ElbUWbExHRirHjlAzqqvZi97qju9Ykrgoibr8Th51wG6tAlzQKweM0zmsscevhYYw4CgeEI0xWykA+O+y6mAjydO0vs6A3R5oQ4oHgpu9WMglF1G3Jrw+a0RrbHMbJnaKUZGqZylkSetupjyuOakIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by AM0PR04MB5844.eurprd04.prod.outlook.com (2603:10a6:208:12a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 02:41:48 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 02:41:47 +0000
Message-ID: <74c5c722-263f-8338-be05-e1ea8e94c620@suse.com>
Date:   Tue, 18 Jan 2022 10:41:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] btrfs: defrag: fix the wrong defragged number of sectors
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20220118021544.18543-1-wqu@suse.com>
In-Reply-To: <20220118021544.18543-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:254::10) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16e5ffb9-ebfb-4d59-5426-08d9da2c1269
X-MS-TrafficTypeDiagnostic: AM0PR04MB5844:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB584476960D908E8419527AB0D6589@AM0PR04MB5844.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9ixGHcAhj+4CT/CMdAfZ18C3tDBKOS5RrDoe3VWxOezMVQ3U2iBTM+Ge8jqCsKiAxKWN6cOHiw8XH2Triyndu83LY30Kk1Ra9mVGyiz1uYmj8MLz6naFPwJaBOuUIzLbB0Ob933saiNlLa9e/dF+137s5OsY5dQ+uA+rGaziZmtm3ZKP+AI8Du7wyqO84F4wjCFF2jNk5+8prDGVWDClYwOuj+LTrqYWhQSoMVY1RpY+TiOpZ1d/bh1oC9K3F3/YkDtEVy6tzv0B4e78JnL7tctawHcZASgBEBNGE7m/wRkgyRU/4nockxFzgr7dFAWuH+pz1XW3cHvXw4125FkR5BuncolyAeWscBM7ONuchBDiJ+g+JLZI+NsJnc8nr403i6cEqfaeDK2qz+eyreNb6JzAzhPPHF3k5n7sB0EEakY3XNd+Xa1gg7qE8g4PAtaPMMoQskYa7/5y/pgUxZSfAfEAp9tl+vKpncqTe2Ncnbjwp2ggSH2fxViF1GN2azoX6tw6I37yImNJTRO6u+Oy15aLoLCXvA1wjIhAzCGklW2Ksg+9OtEk3QjqmZAvRlm+/4b8P++niWZ3AZFGOqpSPP8rGE1Bl1eDPkfzI2b3FpXlfVymBOnhTq84OkxvCEcu7MPbMZy4rOzJd78SDRipfn9+/4fch9jwRTn3cPW4+poxfPhBZnwPLzYzjo1W5JTURcVgosX3VR3D8SNRNvKdVQLHqNZ66ftS7eeUpla2/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(38100700002)(66476007)(31686004)(66556008)(508600001)(53546011)(6506007)(186003)(2906002)(6512007)(86362001)(26005)(36756003)(83380400001)(8936002)(5660300002)(6916009)(6486002)(6666004)(8676002)(316002)(31696002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFN4Tmc5NnhiVlpoTEF2cENKVWM3QUhSTFRmZFhwWWI2bUxlNXlzOFlKSXgz?=
 =?utf-8?B?ZWlWdHhjOG4vRy9YWThUU2FwdWhlSkpQNTgvQ3R0bnZIY09MOHNLWm9zNGQx?=
 =?utf-8?B?RkVCNmVIUFJQT21VRkd4Lzk5Q0JXcDBoSG5ZSGdrU3RZL2FxL0t1MkVVV1My?=
 =?utf-8?B?TkVIRmhXbjE1eitEOUFxZVBoWENDdWwzUnFCNXV0SU00ZlZ0d0YxUERHaHdF?=
 =?utf-8?B?M1h2ZE03TWtvalJrbFo1ajVmaWk3RENGQ2hsSE5EL01Xamg0ampHNFhPUlRB?=
 =?utf-8?B?VEhWb3pDbFZzVHVPOEtBSk44WldrMTY5Y3prelYwQ2lEWHQwWVhubUxUejl6?=
 =?utf-8?B?cWxLd0JGRHpZTWkwZlFhTUlsZy9Vcy9CblRtYWprSU9EUEVnMitDdmlzUzNZ?=
 =?utf-8?B?aDhVYk51RUFMNFdwcmplNlZQMUExMVgvK2NkQ2xWTld0VEhJZ0lNdUJoZ0dx?=
 =?utf-8?B?TkM4R3daNGR5WHhReUFxYm9XWUhJWnVuR1NjZnoya1FPNlg1b2JsakJTZVVE?=
 =?utf-8?B?L1h4K2xxWk9TNG1kdW55eDlkcG9LNHVmREJIQ3lXOCtUbjlncUhNdXltdVJJ?=
 =?utf-8?B?WmlTa1ZwdFE4aEpWbyswNmVqRE1JT3phTEN3ZnVBSGpmbmFWcnovL04rbkth?=
 =?utf-8?B?QjZvdmNRSHJHQXZxcHFtUE9NSTlBNWY1OERHelRHdHlvV2JDK0U2c2Zjc2da?=
 =?utf-8?B?NWcxclo5RlhjV0F6dXpGOHJ3SW9YR29ma0hEcGNVZzk3V1V5ZWJacktGcVpD?=
 =?utf-8?B?Wjc1WmNuQU5XMDFDT1ZtMERnbVVoS1R4WjJKcy9yYmg0Q0dSanFEYVhKN2sz?=
 =?utf-8?B?bngwYTJ6OWd4QmdxYmxqQ3U0d0I2TjlYakNSNDk3MUd2TlBFTVA2NE9ZVUx5?=
 =?utf-8?B?QjBFbE5Vdzg4dVFpL3JuQ3lmS1dMdDBnbDFBeFZoQmFXTE9BZnlpRCsrTHFH?=
 =?utf-8?B?RXh4YXpvWERvZk10SEswcFphRlZXWUZnR3dhSEQvaGUwNjJ2WDFKNzZDYzVn?=
 =?utf-8?B?ejRyU3JsWVRiWkVEREsvQVVHQ2NmVFhWY0p3dHZHODVvTUtJOUNMZGZ2QWtW?=
 =?utf-8?B?M3NrQWtLZ1F2S0puOUl3Y1FQc3NzcHRrSmJWZFJiZ3ZUd25xWG0zOEFadURn?=
 =?utf-8?B?UHh1UzRZelExM0ZQM1Naa1BPcVlzTWZlZllwSzJhQVgxeXZ3Uzg4N2lkVWx5?=
 =?utf-8?B?N2R5ZFd3K1pET2ZNSVlvMlFleEpWRjZ2QVVIcXNiZFF4eW1oZGpmbjlHMkFh?=
 =?utf-8?B?SGNPanpnN0sweTB5QVYrMENhUmJIWm16VkRnTDd6YjhvTjZaQnEvZlZXTVd5?=
 =?utf-8?B?cTBtaVlIZ3ZJdHhUWElyNnh3enhnREVNOEdRVi9GajlpVW5IWExuQ2tCZXRx?=
 =?utf-8?B?VWUzQXU0UEsxOTVLb201NmlWVnZjRUNEUER3WDVOcFBqY0szZHIrcDB2RzdZ?=
 =?utf-8?B?ci94d2dkc0JGVFc3NnlxaUw5UnhwYzk2VHNubk80dkU0RFJNeGJrQlhlZFI5?=
 =?utf-8?B?RXZUNFdQRVNiU0VtQ09sclZvYW5rQ1ZMbk1ySGM2NE9SNFYweDBETGRKUUo1?=
 =?utf-8?B?elJrUmZoMHNBVG5mZTN2UUJ0MERIb2NtMGVmZWpTVkozM3dXN3Nuak93MUhK?=
 =?utf-8?B?OXJtem1RVzV5YjdUWmc3TUU4VWl3UHg3ZDZDOHJGOHVUZ0dIQXhXNENZQlJz?=
 =?utf-8?B?ekdhT1U5UWtlaEVEZXA5NFJSZzFzWHd0aVlzNUdjTVJoeXFQMHFoSnZOMUV5?=
 =?utf-8?B?S0FuZmFzNy9FOGJvSXhhbDFCaFZFZEVPTUJpTjBjZzBXUVFwWENSRHh0alli?=
 =?utf-8?B?RHg0TFRTa1E1bXdrZGV6NFZOTDA0QTdpSUl4WmhkS21tS0ZjOU03eTY3SExm?=
 =?utf-8?B?UnBPOUM1c2xzL1Ixc2pwUjBySEhqMFdxaXIzcjhhWTNUd2ZKWFJuQVQrdnFt?=
 =?utf-8?B?eG9GQUdnd3YrVEovci93MDlEbk9HQ0pQYW16SzQ4RDlqS3U3QjdWZTRwZmxQ?=
 =?utf-8?B?OHYreTJ0T252T1pRM2lQS3Q4L2MzZ3hKdWIyOGVKK1lLWVVPdUg5Y1h2ZENT?=
 =?utf-8?B?RW5IQkdUOVVmZHhaZXlPNEorQytzMjd3cEtyQ1plU1RrL0MvUFBKNWlaOG8z?=
 =?utf-8?Q?PsTg=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e5ffb9-ebfb-4d59-5426-08d9da2c1269
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 02:41:47.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W06yO8HulLcYzgtpmTr49xyUYc2epuO8t9LsPWZOjxZTUkVbcwGkiHWvQM9wGWyq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5844
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/18 10:15, Qu Wenruo wrote:
> [BUG]
> Since the recent rework on btrfs defrag to support subpage, the number
> of defragged sectors is no longer reported in sector size, but in byte.
> 
> Normally this is fine and defrag ioctl won't return the number of
> defragged sectors anyway.
> 
> But it will change the behavior of auto-defrag, which has re-defrag
> behavior based on the defragged sectors.
> 
> Furthermore, the refactor changed how we report the number of defragged
> sectors.
> The refactor no longer reports the real defragged sectors, but just the
> initial scan, which can report more bytes than the defragged sectors.
> 
> [FIX]
> Fix the problems by:
> 
> - Pass @sectors_defragged to defrag_one_range() and update it in the
>    real loop where we defrag the file
> 
> - Properly calculate the @sectors_defragged using number of sectors, not
>    number of bytes.
> 
> Fixes: 7b508037d4ca ("btrfs: defrag: use defrag_one_cluster() to implement btrfs_defrag_file()")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/ioctl.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 6ad2bc2e5af3..d1f036aba36a 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1343,7 +1343,8 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
>   }
>   
>   static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
> -			    u32 extent_thresh, u64 newer_than, bool do_compress)
> +			    u32 extent_thresh, u64 newer_than, bool do_compress,
> +			    unsigned long *sectors_defragged)
>   {
>   	struct extent_state *cached_state = NULL;
>   	struct defrag_target_range *entry;
> @@ -1398,6 +1399,8 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
>   					       &cached_state);
>   		if (ret < 0)
>   			break;
> +		*sectors_defragged += entry->len >>
> +				      (inode->root->fs_info->sectorsize_bits);
>   	}
>   
>   	list_for_each_entry_safe(entry, tmp, &target_list, list) {
> @@ -1462,10 +1465,10 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>   		 * accounting.
>   		 */

Just lines above, there is a clamping using @max_sectors against 
@sectors_defragged.

And that is the root cause of the extra IO.

As @sectors_defragged is returned in bytes, while @max_sectors are 
normally just 1024 from auto-defrag, this means later calculation of 
@max_sectors - @sectors_defragged always underflow if we defragged any 
bytes, rendering the whole @max_sectors limits useless.


Although my refactor slightly changed the policy (like no more adjacent 
check for previous extents), it shouldn't cause that huge change in IO.
Thus it's really the bad @sectors_defragged causing the bug.

Will include this part into the changelog in next version, and to be 
extra safe, will change the @max_sectors check against 
@sectors_defragged using max_sectors <= sectors_defragged, just in case
we exceeded the limit by somehow.

Thanks,
Qu

>   		ret = defrag_one_range(inode, entry->start, range_len,
> -				       extent_thresh, newer_than, do_compress);
> +				       extent_thresh, newer_than, do_compress,
> +				       sectors_defragged);
>   		if (ret < 0)
>   			break;
> -		*sectors_defragged += range_len;
>   	}
>   out:
>   	list_for_each_entry_safe(entry, tmp, &target_list, list) {
> @@ -1484,6 +1487,9 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
>    * @newer_than:	   minimum transid to defrag
>    * @max_to_defrag: max number of sectors to be defragged, if 0, the whole inode
>    *		   will be defragged.
> + *
> + * Return <0 for error.
> + * Return >=0 for the number of sectors defragged.
>    */
>   int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>   		      struct btrfs_ioctl_defrag_range_args *range,


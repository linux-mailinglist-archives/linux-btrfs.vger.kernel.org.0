Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E4347FC7F
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Dec 2021 13:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhL0MIt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Dec 2021 07:08:49 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:28545 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231964AbhL0MIs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Dec 2021 07:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1640606927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fwDinCPdtjR0EISI+MuSdCIJtcGJ55mjMRHdu72OL4w=;
        b=DKJgR2k2Z0E8RlJFuMpHfL4Kdpv1+pPZ2ioB14Js99NidLGoGgXiuHV4jjLbe1GW5Rl+Za
        jvWxIGEPmHqzmEYXH68iCvOm3WTf1jxhM7UUz0KGgtyxiajy8k+3G9SY8lCSsgDdvw4rVj
        UFn3pitaUgnWnxC/8pTBQxfqUc/GXUc=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2050.outbound.protection.outlook.com [104.47.10.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-x-2bSSM6OR6HJpHi-4F55g-1; Mon, 27 Dec 2021 13:08:46 +0100
X-MC-Unique: x-2bSSM6OR6HJpHi-4F55g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpXgX2LugYhGDSjjqIv0tCcoh27eQ4UoVJgNIEOmZMSUYXSvd77mp4YWKjz9AcIRt2uMrGa8D508fWsbGFxCqVrNldU/FQEFcrD5W9fMs4uQTNBS8K9DERgblTlegxYM5Jjpf//YECZ/6gq1kxLWUUMyR7lpoK8ep9wGKDWTrfDPdR6WnqGbqwx92VM1f0zYqrJfSb1IR8Ik1g18moPBFFnWfpJcTaXQ74NGcz08aU7efHXaSTbvG+68yoFt5Eacip+8pUmB0z5PQSzmG0DElMxZFJyJzwqOYlFO/Gir3olSYrqGtPosHom0rkq0z8/qcC+d+zpxmQbbF0ASPuNe1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwDinCPdtjR0EISI+MuSdCIJtcGJ55mjMRHdu72OL4w=;
 b=c1zRBJYgmMWDTwCpaif3A05DLORwKylJhSUXjsWC+pKwuZmXaN460zb2z83C/1JTn/DGpjmTgAzfkeTe6UOt6XzHj20BBwJB0wGj7T78AOSVTUDGPpVL2zqRmyhXaZ/9ETk3Q7fH06DY2CebsDSC6nQ9qdPRBUUQmvXKtkni9iGqMNrLjCEdgg2koilVkXpLfGnuYGt6LIEApO4R16oGLgz9arR7Zw+xRgIT6gwl7bWR/01rLwnidmNLmx7g/cfafxGf+SkzExSpiowxHeYsQ0HKlypWtGzPVQx+jpAae9qKrobftn+oei30FXn+Pc9/L8cX9ReEzrH6V/3cUGeK0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PAXPR04MB9423.eurprd04.prod.outlook.com (2603:10a6:102:2b3::7)
 by PAXPR04MB8894.eurprd04.prod.outlook.com (2603:10a6:102:20d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Mon, 27 Dec
 2021 12:08:45 +0000
Received: from PAXPR04MB9423.eurprd04.prod.outlook.com
 ([fe80::830:e01a:7a86:6caa]) by PAXPR04MB9423.eurprd04.prod.outlook.com
 ([fe80::830:e01a:7a86:6caa%3]) with mapi id 15.20.4778.016; Mon, 27 Dec 2021
 12:08:45 +0000
Message-ID: <992b3b8b-d3d5-f5fd-28f4-afcf667ff0c5@suse.com>
Date:   Mon, 27 Dec 2021 20:08:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] fs/btrfs: fix a bug that U-boot fs btrfs implementation
 doesn't handle NO_HOLE feature correctly
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     u-boot@lists.denx.de
Cc:     linux-btrfs@vger.kernel.org
References: <20211227061114.54326-1-wqu@suse.com>
In-Reply-To: <20211227061114.54326-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To PAXPR04MB9423.eurprd04.prod.outlook.com
 (2603:10a6:102:2b3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bac111e1-5d05-4aef-a468-08d9c931a169
X-MS-TrafficTypeDiagnostic: PAXPR04MB8894:EE_
X-Microsoft-Antispam-PRVS: <PAXPR04MB8894DF63823BF621A701B3AED6429@PAXPR04MB8894.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xYO74uKD8dO2WHFTtFRaB/F932Y103x0I5zzxRtNtesLIBcZoV01cEs+pAyNRRArw/3Wg/76OpVqjqSvcw2fKYWg45kXS1EH/8R1VUWnsRMdJR8CRYio+FM2wfjujx2pn0mJTct+VxzTLfXz1Ido43QNI1ao03MxP+8U/pg1lFZYicMnRgmJjh2sgcIEYYo+L5gt1ISXjqprfyinlGz9UOABaitpDJ5BBu7c6hXkh+QZN7EhyLqhsgciJVPiX2jk1ZY4XhxjX/KEYFNnbRd8k3KMScwYkzxcgCOa/Iooa0ZrZs0NCXV/XFhJvlUbnN28OiVt6Z9bA5aOO3i9ee2mHy+BWp6OrtdZqM/kYz3/dM2EvwMZMSzP+22lSItvYJ9EiL12nM8aepQc0WcE9ozuQbq1MQb361iVohSE220f3rKAHtwuK3IZ0USqXVk5s+wGpttSlcZIwDk3oWnkXn8z/+5e1Lpv5UlGKi7uRZjsMEZ5XHBjfZMHGOYDfa96H/vgvn+l+YT/mw1t01ei1WlADTCCyWa5iy8y5Ui3fbUz+vjkAPfZ5wxnVrCodax66F7mWVDCYckQnw5KcQa3qrD6ZQ6sY08rULpvlT1651etfPxM33FZGAwMIT9u+l4g6aPGHPCl8u4iQCuOR4e7fQFF/WUVJnM7MGlAW7dOCKo/giLgyBfqlxz0yd3p2a8i4hxxs5LlXUTxatGOdcV09wpPoo3Y0nAcn/9xM9oj2xS7RSTL9+7nwCwczAHOOogqqoonleHkMOQiI312FwEODS76gwr3K7JUy/w3UpYb277nO9ESJtZwtUqHbwkz9yVkXVh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9423.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(66476007)(31686004)(316002)(6486002)(2906002)(4326008)(6506007)(6666004)(66556008)(66946007)(186003)(8676002)(5660300002)(8936002)(36756003)(26005)(53546011)(31696002)(2616005)(508600001)(6916009)(6512007)(38100700002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkZTeHVqL3VsMVpVelNVRXBSeElzNFdOOEdweWFhelJwelNGYlpQU3Ircith?=
 =?utf-8?B?SEVObkJIczVpcnEvUDRJbTNVWEtLK2FRM04zVVlrVTU2UHRKYWJ2bFM4d3pF?=
 =?utf-8?B?b0QvWmFtRGNxNDNBYkF1YytYWmNJQlFDVDlxaHprdGZvK2tQd0lZbkpaL3hr?=
 =?utf-8?B?Zm1DMmdMT3ZvZlQ1K1huaWFNTEh2MzdMS2dRVkdTMjJvTzdBRU9qU3kvdU1o?=
 =?utf-8?B?cFJSU1FGMWZveUNidWJScjl6cXdMUU1kRGZBeGo1c2xUdEtMaXZRZktnMkk4?=
 =?utf-8?B?L2JtWlFhUGRER2dvdEFhUis0RkZiTnhBSTFFMGxBWm5GWEJIOHpXVVdQS3Rn?=
 =?utf-8?B?MEZWWUFnVmkrTExKVmZNNDFtdXE1ZktoaHc1QUM4emJKNU9ZU2NIYzBQQ0ty?=
 =?utf-8?B?RHZQMUs5RGgzSWhLYmRKVmR1N3ZzbmYvaVZGWEpTam9lSy9BVEtuemJhRjBW?=
 =?utf-8?B?aXJieEVoMndlcllXNW1NTSs3blNaR1ZnTjdqcGFNdjVXV1c3NGQyZElVSEg3?=
 =?utf-8?B?anZBNld3aUVrUW5KMjVvOGxmVENLK1drK25HOHY3VysvME4rRnZsOTBuUFhO?=
 =?utf-8?B?UnpQK1QrdWI5R3l2b1pHV3hsckpnT2FEcjQ0Z1daT1Z4ZTlUK2kwZ2pkUCtl?=
 =?utf-8?B?cXM1bEFTaGl0U0RROXhJTC9VZ1pDSmFmSDZWSjFxL2VET2FxbXdyb25kSWQr?=
 =?utf-8?B?NStNTGxyUDlVdVZwNGVLc3Ruald6QzlycEtMVlBxTUJkTnZQbndBcUxBbmVw?=
 =?utf-8?B?ajVkY2VOS2E4a0pCUWpYZStNeUpNd01oTG01S3F1Z2dlblE0TEI5dWVid080?=
 =?utf-8?B?aStLcEJ3MkoyWEJab3V0V0Ixbk5relB6SFlWOTh5MCtuUlNVNXZKZVpYejIv?=
 =?utf-8?B?bDZDVU0zNlFPckdPc0gvdHdLOXpTcW9nbVZ3NXo2dzVkSWE2MjVrQ1lSM3Jn?=
 =?utf-8?B?YkVJcEZNbUN0Q1JxcmZobjR5dTNxNjJEQ1pLc0h3d2oydlV6VUFERTZOd1lv?=
 =?utf-8?B?SElvYmd2dFphUkh4WU9FaFR0WklNdnQzMjFqUHRNMS9nU3pWK2FuK1ZXUCtI?=
 =?utf-8?B?U2NyK1phdzFlNVdNRjRZTjIzSXU3SkxTM2d1SE1YOVVRdWJsdnl0ZXB2M3VJ?=
 =?utf-8?B?L1FZMzlNYmlqLzQyZGM0bXJFc0h5ZHFrVkRPSTM3bW9WZGVWVWVmY1VmdUwr?=
 =?utf-8?B?M1VOc1ZkQ0pzWUtoTFNMUmI3WStBZmF5eXRXT0VWLzBGV3JmYXN1cDBOTTA3?=
 =?utf-8?B?a0laSjFLWVZRUTBPODkzci9SQ3Z4UGVtZW4xb0xkL29FYVVnY1RJNEhEQnAx?=
 =?utf-8?B?aEhORzY1SEhJQ3hoNTIyTW1TQ0VoM3BFVmdlUmgxYVBiV0UrTE9UQzl5NzFt?=
 =?utf-8?B?U3ZBMXU0b0JsK09uZFBsRGFFWTQ3UVRKRUFFLzVzaXV0Q3NYVHdJZVRjOFdw?=
 =?utf-8?B?eDExdXArYzl0YmdGaE5vRkNJOUtPYTlhNm00SklRekNyYzF6VVY2d3lNdzhm?=
 =?utf-8?B?Yk05MzVVVzkyUm5hUTJWeTZKd1ZDVXluNlZLdHpjODhVMDlQWGNyR1RhbnlD?=
 =?utf-8?B?MjZ6OE5Wejljc01mck9PZkNWU3pJQmhITGZraVl5NFVsV2Y1UGwwWEUzTFEr?=
 =?utf-8?B?dExocWFBMnVPTEx4N0llOVJCYXBkdXUyOUd5b2JuQ1U1eWxUdjdEUzZqS1dj?=
 =?utf-8?B?Qmc1bVNVYlFKTFI0SFU4UE5FRDZVcnRyaFV3ZGx0d1dFQVZoOXJUMFZjbGZs?=
 =?utf-8?B?WmxCYW01bzFMNEZaZWhXOTBzY0llT0wxcHFNL2daSmlJcG5NZS9vcUtKME1j?=
 =?utf-8?B?TzR3SVM5U2xhS3FSdG0remR3NUw0emV6TmFSRUVDVjhBK2ZkaHVSQ2xWY1NG?=
 =?utf-8?B?WFhOdEhocDA0SDhIVFQ1d081VFdqeGxGVFRma0NuYnF6LzhoZ05xVkdxL0Np?=
 =?utf-8?B?L2UzMzYrRnN2b043Ym9mZEZYWVdpd1REN21pQTdwbTB4QWIxWVNOTStBSWk5?=
 =?utf-8?B?ZjlwQUJHMFhyVFdFR25FVzcrWnppNWoxQnlJRndzbndFVGs3dVl4WS9Pci8z?=
 =?utf-8?B?ckxoQWMydy80UURSczZsVkZvTWJrNkhvMTNoYzlCV2JUNTE0UlNBNVlxVXRV?=
 =?utf-8?Q?zj+o=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac111e1-5d05-4aef-a468-08d9c931a169
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9423.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2021 12:08:44.9336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxEGU8R1HBdeCThuCNkgWJRQ9flTOBAgmbcM53JLMuaEPU/c91cC2zWu2NgezlTa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8894
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/27 14:11, Qu Wenruo wrote:
> [BUG]
> When passing a btrfs with NO_HOLE feature to U-boot, and if one file
> contains holes, then the hash of the file is not correct in U-boot:
> 
>   # mkfs.btrfs -f test.img	# Since v5.15, mkfs defaults to NO_HOLES
>   # mount test.img /mnt/btrfs
>   # xfs_io -f -c "pwrite 0 4k" -c "pwrite 8k 4k" /mnt/btrfs/file
>   # md5sum /mnt/btrfs/file
>   277f3840b275c74d01e979ea9d75ac19  /mnt/btrfs/file
>   # umount /mnt/btrfs
>   # ./u-boot
>   => host bind 0 /home/adam/test.img
>   => ls host 0
>   <   >      12288  Mon Dec 27 05:35:23 2021  file
>   => load host 0 0x1000000 file
>   12288 bytes read in 0 ms
>   => md5sum 0x1000000 0x3000
>   md5 for 01000000 ... 01002fff ==> 855ffdbe4d0ccc5acab92e1b5330e4c1
> 
> The md5sum doesn't match at all.
> 
> [CAUSE]
> In U-boot btrfs implementation, the function btrfs_read_file() has the
> following iteration for file extent iteration:
> 
> 	/* Read the aligned part */
> 	while (cur < aligned_end) {
> 		ret = lookup_data_extent(root, &path, ino, cur, &next_offset);
> 		if (ret < 0)
> 			goto out;
> 		if (ret > 0) {
> 			/* No next, direct exit */
> 			if (!next_offset) {
> 				ret = 0;
> 				goto out;
> 			}
> 		}
> 		/* Read file extent */
> 
> But for NO_HOLES features, hole extents will not have any extent item
> for it.
> Thus if @cur is at a hole, lookup_data_extent() will just return >0, and
> update @next_offset.
> 
> But we still believe there is some data to read for @cur for ret > 0
> case, causing we read extent data from the next file extent.
> 
> This means, what we do for above NO_HOLES btrfs is:
> - Read 4K data from disk to file offset [0, 4K)
>    So far the data is still correct
> 
> - Read 4K data from disk to file offset [4K, 8K)
>    We didn't skip the 4K hole, but read the data at file offset [8K, 12K)
>    into file offset [4K, 8K).
> 
>    This causes the checksum mismatch.
> 
> [FIX]
> Add extra check to skip to the next non-hole range after
> lookup_data_extent().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This bug exposed another missing link, that we don't have good test
> coverage in U-boot btrfs.
> 
> This is partially caused by the fact that, btrfs-progs code is not
> designed to read file contents, but just to check the cross-reference
> (aka, btrfs-check).
> 
> If we really only want read-only support in U-boot, and don't ever plan
> to add write support, then I'd say the btrfs-fuse project
> (https://github.com/adam900710/btrfs-fuse/) is more suitable for U-boot.
> 
> As that project already has full fs content verification selftest along
> with extra multi-device recovery tests.
> And shares the same code style between btrfs-progs/kernel.

OK, things are not that bad.

In fact, the btrfs_read_file() implementation in btrfs-fuse has the same 
naming, same lookup_file_extent() (just a little naming different than 
lookup_data_extent()), same parameter list.

Just without the unaligned sector handling (handled by FUSE, and it may 
also be unnecessary for U-boot too), and already have the correct 
handling for lookup_file_extent(), thanks to the selftest.

So this already means, it can be pretty easy for U-boot to take code 
from btrfs-fuse part by part, without huge refactor again.

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 2c2379303d74..d00b5153336d 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -717,6 +717,14 @@ int btrfs_file_read(struct btrfs_root *root, u64 ino, u64 file_offset, u64 len,
>   				ret = 0;
>   				goto out;
>   			}
> +			/*
> +			 * Find a extent gap, mostly caused by NO_HOLE feature.
> +			 * Just to next offset directly.
> +			 */
> +			if (next_offset > cur) {
> +				cur = next_offset;
> +				continue;
> +			}
>   		}
>   		fi = btrfs_item_ptr(path.nodes[0], path.slots[0],
>   				    struct btrfs_file_extent_item);


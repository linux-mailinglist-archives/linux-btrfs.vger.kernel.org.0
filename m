Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E36245422
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Aug 2020 00:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgHOWMw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Aug 2020 18:12:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43258 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbgHOWMu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Aug 2020 18:12:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07FDZLkq152132;
        Sat, 15 Aug 2020 13:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=OYdBQfkRbSCEshi2I/1r4XvVgzalqZN/nTTUNiWT6iI=;
 b=o7RJgOUMlLxKvkG1NnNvt1NN9QOS4x8AS2pnfhlgqtd130W8Xmf1+9ws9/qLELSGSvQk
 0xCTysvQ3MojtDbbRfUjplTbtTidC5HmJC5Ci0s/BNSQml9tJoBoCpAFQ3m7vK4rBJQf
 AjxcjKhcgOOqcbf8jcmK/K8TEZmbpcb/R6jrmD/LYo4/+YszamGlJyzgZecPaeLQawFx
 6F7TW+sWFdZZ2NXJYt0VaTaZghHflcsdco2T2BJ8dJQimgbSj0Nmccv5434nYyNDTIxd
 vCfc9U3H51yu34q+geqMxCO3nOQ0uA374FmII0YJogOdlvL3RX7VBJtSMz5sICveFmF3 bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32x8bmrwa8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 15 Aug 2020 13:38:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07FDbnn8168729;
        Sat, 15 Aug 2020 13:38:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32x5r8b9bm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Aug 2020 13:38:06 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07FDc4Aa030470;
        Sat, 15 Aug 2020 13:38:04 GMT
Received: from [192.168.1.145] (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 15 Aug 2020 13:38:04 +0000
Subject: Re: [PATCH 1/2] btrfs-progs: convert: Ensure the data chunks size
 never exceed device size
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Jiachen YANG <farseerfc@gmail.com>
References: <20200624115527.855816-1-wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <60a0f996-fcd0-4188-3e58-1f0acaae5192@oracle.com>
Date:   Sat, 15 Aug 2020 21:38:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200624115527.855816-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9713 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxlogscore=999
 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008150107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9713 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=2 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008150106
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Before this patch the converted ext4 was failing to mount due to 'beyond
device boundary' error.

After this patch

# ./btrfs-convert /dev/sda7
create btrfs filesystem:
	blocksize: 4096
	nodesize:  16384
	features:  extref, skinny-metadata (default)
	checksum:  crc32c
creating ext2 image file
ERROR: data bytenr 1644167168 is covered by non-data block group 
1644167168 flags 0x4
ERROR: failed to create ext2_saved/image: -22
WARNING: an error occurred during conversion, filesystem is partially 
created but not finalized and not mountable


Any idea?


On 24/6/20 7:55 pm, Qu Wenruo wrote:
> [BUG]
> The following script could lead to corrupted btrfs fs after
> btrfs-convert:
> 
>    fallocate -l 1G test.img
>    mkfs.ext4 test.img
>    mount test.img $mnt
>    fallocate -l 200m $mnt/file1
>    fallocate -l 200m $mnt/file2
>    fallocate -l 200m $mnt/file3
>    fallocate -l 200m $mnt/file4
>    fallocate -l 205m $mnt/file1
>    fallocate -l 205m $mnt/file2
>    fallocate -l 205m $mnt/file3
>    fallocate -l 205m $mnt/file4
>    umount $mnt
>    btrfs-convert test.img
> 
> The result btrfs will have a device extent beyond its boundary:
>    pening filesystem to check...
>    Checking filesystem on test.img
>    UUID: bbcd7399-fd5b-41a7-81ae-d48bc6935e43
>    [1/7] checking root items
>    [2/7] checking extents
>    ERROR: dev extent devid 1 physical offset 993198080 len 85786624 is beyond device boundary 1073741824
>    ERROR: errors found in extent allocation tree or chunk allocation
>    [3/7] checking free space cache
>    [4/7] checking fs roots
>    [5/7] checking only csums items (without verifying data)
>    [6/7] checking root refs
>    [7/7] checking quota groups skipped (not enabled on this FS)
>    found 913960960 bytes used, error(s) found
>    total csum bytes: 891500
>    total tree bytes: 1064960
>    total fs tree bytes: 49152
>    total extent tree bytes: 16384
>    btree space waste bytes: 144885
>    file data blocks allocated: 2129063936
>     referenced 1772728320
> 
> [CAUSE]
> Btrfs-convert first collect all used blocks in the original fs, then
> slightly enlarge the used blocks range as new btrfs data chunks.
> 
> However the enlarge part has a problem, that it doesn't take the device
> boundary into consideration.
> 
> Thus it caused device extents and data chunks to go beyond device
> boundary.
> 
> [FIX]
> Just to extra check before inserting data chunks into
> btrfs_convert_context::data_chunk.
> 
> Reported-by: Jiachen YANG <farseerfc@gmail.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   convert/main.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/convert/main.c b/convert/main.c
> index c86ddd988c63..7709e9a6c085 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -669,6 +669,8 @@ static int calculate_available_space(struct btrfs_convert_context *cctx)
>   			cur_off = cache->start;
>   		cur_len = max(cache->start + cache->size - cur_off,
>   			      min_stripe_size);
> +		/* data chunks should never exceed device boundary */
> +		cur_len = min(cctx->total_bytes - cur_off, cur_len);
>   		ret = add_merge_cache_extent(data_chunks, cur_off, cur_len);
>   		if (ret < 0)
>   			goto out;
> 


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A39B93081B
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2019 07:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfEaFfQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 May 2019 01:35:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43956 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaFfQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 May 2019 01:35:16 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4V5SWYF076937;
        Fri, 31 May 2019 05:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=LB7lB7UjsA5dL9Ef7C/dlpIHcSyyBWMxuJF33R4M9pI=;
 b=Q50ZRt/avYOqFwa1wSZM5Q1AMN3nDdwulbiTufPcrY2AmXSlw8Sf5HBcFPXU/kL8lcH/
 vZphLRI0smmGQnkzuzBzwAbbS7SgibOxW9WQrKie0//kWHUMZ0TxxgROhsgcMZ/gLcja
 rxOV34LY162aAbaP+dbpITIyAeHDR1KJeFvd0ESAI15I4EU05QFdIZhvcyLXjP+iBblZ
 gupjgREcPLl87NS2rA3xrKYm1kRxUyBgPfFN2GNRD3b8F8jVrfs+uhqPAlRG8t1VG7PD
 cuz6Ju7WcIFkm+GAXiZnNtEPH+jgHdLwufDKQZKasoM8eA81Dz1wZjjFZI/05QRGb5PV +Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2spu7dv9a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 05:35:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4V5XRZ9016527;
        Fri, 31 May 2019 05:35:10 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ss1fpesm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 05:35:10 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4V5Z9Iu013999;
        Fri, 31 May 2019 05:35:09 GMT
Received: from [192.168.1.147] (/39.109.145.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 22:35:09 -0700
From:   Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH] btrfs: trim: Check the range passed into to prevent
 overflow
To:     Qu Wenruo <wqu@suse.com>, dsterba@suse.com
Cc:     linux-btrfs@vger.kernel.org
References: <20190528082154.6450-1-wqu@suse.com>
Message-ID: <3ee71943-70f3-67c9-92ed-3a8719aee7f8@oracle.com>
Date:   Fri, 31 May 2019 13:35:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190528082154.6450-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905310036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905310036
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/28/19 4:21 PM, Qu Wenruo wrote:
> Normally the range->len is set to default value (U64_MAX), but when it's
> not default value, we should check if the range overflows.
> 
> And if overflows, return -EINVAL before doing anything.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

fstests patch
    https://patchwork.kernel.org/patch/10964105/
makes the sub-test like [1] in generic/260 skipped

[1]
-----
fssize=$($DF_PROG -k | grep "$SCRATCH_MNT" | grep "$SCRATCH_DEV"  | awk 
'{print $3}')
beyond_eofs=$((fssize*2048))
fstrim -o $beyond_eofs $SCRATCH_MNT <-- should_fail
-----

Originally [1] reported expected EINVAL until the patch
   6ba9fc8e628b btrfs: Ensure btrfs_trim_fs can trim the whole filesystem

Not sure how will some of the production machines will find this as,
not compatible with previous versions? Nevertheless in practical terms
things are fine.

  Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   fs/btrfs/extent-tree.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index f79e477a378e..62bfba6d3c07 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -11245,6 +11245,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   	struct btrfs_device *device;
>   	struct list_head *devices;
>   	u64 group_trimmed;
> +	u64 range_end = U64_MAX;
>   	u64 start;
>   	u64 end;
>   	u64 trimmed = 0;
> @@ -11254,16 +11255,23 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   	int dev_ret = 0;
>   	int ret = 0;
>   
> +	/*
> +	 * Check range overflow if range->len is set.
> +	 * The default range->len is U64_MAX.
> +	 */
> +	if (range->len != U64_MAX && check_add_overflow(range->start,
> +				range->len, &range_end))
> +		return -EINVAL;
> +
>   	cache = btrfs_lookup_first_block_group(fs_info, range->start);
>   	for (; cache; cache = next_block_group(cache)) {
> -		if (cache->key.objectid >= (range->start + range->len)) {
> +		if (cache->key.objectid >= range_end) {
>   			btrfs_put_block_group(cache);
>   			break;
>   		}
>   
>   		start = max(range->start, cache->key.objectid);
> -		end = min(range->start + range->len,
> -				cache->key.objectid + cache->key.offset);
> +		end = min(range_end, cache->key.objectid + cache->key.offset);
>   
>   		if (end - start >= range->minlen) {
>   			if (!block_group_cache_done(cache)) {
> 


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADA7DA500
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 07:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfJQFKI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Oct 2019 01:10:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42502 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfJQFKI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Oct 2019 01:10:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H59JLS050758;
        Thu, 17 Oct 2019 05:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=YM61pq3TjYQlREegj1flwuaQr3U4sGLSw325oUzqivo=;
 b=CPymaaaD90Z0P6Gt4DopOlZOThpyb8ryHsSJJqNGGggAEuVZ6yvryCxIbQ0f415d0klS
 NWUFW9eEZkRzCcRjsgdMIRiUdRklyD1neIKBJAXYjyAxpw0O6yi0OCXKnRS0J2+79Rm8
 5LqTKl+JH/6gYsFyJr/b+jb56A6glYKX5LQTZKcBOqJM10cPAP0X/y9/xr7BvtJq7VLE
 KrS93tjCwRlbqAG5RZt4/6Ysx5K3sbl/JomAL9bqekQ31jIfR6YURr48b6gVVkQ5Xm7I
 WKhj/AmNEDbnUNFHq+JArwzzPrgUUm5LZn6s8bijQyQKVp5PhxQeRlXRs7TP5yn6ZZy5 Jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vk6squqpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 05:09:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H59Eu9144370;
        Thu, 17 Oct 2019 05:09:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vp70p7c0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 05:09:18 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9H58kfe030309;
        Thu, 17 Oct 2019 05:08:47 GMT
Received: from [10.190.155.136] (/192.188.170.104)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 05:08:46 +0000
Subject: Re: [PATCH v2 2/7] btrfs-progs: Refactor btrfs_read_block_groups()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20191008044936.157873-1-wqu@suse.com>
 <20191008044936.157873-3-wqu@suse.com>
 <fd4f3e1c-fd98-6550-6284-f1456e0332ba@oracle.com>
 <566f2d81-8454-d4f5-6e73-adbd0ddedf28@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d831e08f-2d40-a650-a7c3-166348e7ab46@oracle.com>
Date:   Thu, 17 Oct 2019 13:08:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <566f2d81-8454-d4f5-6e73-adbd0ddedf28@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170039
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170039
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10/17/19 12:33 PM, Qu Wenruo wrote:
> 
> 
> On 2019/10/17 上午11:23, Anand Jain wrote:
>> On 10/8/19 12:49 PM, Qu Wenruo wrote:
>>> This patch does the following refactor:
>>> - Refactor parameter from @root to @fs_info
>>>
>>> - Refactor the large loop body into another function
>>>     Now we have a helper function, read_one_block_group(), to handle
>>>     block group cache and space info related routine.
>>>
>>> - Refactor the return value
>>>     Even we have the code handling ret > 0 from find_first_block_group(),
>>>     it never works, as when there is no more block group,
>>>     find_first_block_group() just return -ENOENT other than 1.
>>
>>
>>   Can it be separated into patches? My concern is as it alters the return
>>   value of the rescue command. So we shall have clarity of a discrete
>>   patch to blame. Otherwise I agree its a good change.
> 
> No problem.
> 
> What about 3 patches split by the mentioned 3 refactors?
>>
>>
>>>     This is super confusing, it's almost a mircle it even works.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>    ctree.h       |   2 +-
>>>    disk-io.c     |   9 ++-
>>>    extent-tree.c | 160 ++++++++++++++++++++++++++++----------------------
>>>    3 files changed, 97 insertions(+), 74 deletions(-)
>>>
>>> diff --git a/ctree.h b/ctree.h
>>> index 8c7b3cb40151..2899de358613 100644
>>> --- a/ctree.h
>>> +++ b/ctree.h
>>> @@ -2550,7 +2550,7 @@ int update_space_info(struct btrfs_fs_info
>>> *info, u64 flags,
>>>                  u64 total_bytes, u64 bytes_used,
>>>                  struct btrfs_space_info **space_info);
>>>    int btrfs_free_block_groups(struct btrfs_fs_info *info);
>>> -int btrfs_read_block_groups(struct btrfs_root *root);
>>> +int btrfs_read_block_groups(struct btrfs_fs_info *info);
>>>    struct btrfs_block_group_cache *
>>>    btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used,
>>> u64 type,
>>>                  u64 chunk_offset, u64 size);
>>> diff --git a/disk-io.c b/disk-io.c
>>> index be44eead5cef..8978f0cb60c7 100644
>>> --- a/disk-io.c
>>> +++ b/disk-io.c
>>> @@ -983,14 +983,17 @@ int btrfs_setup_all_roots(struct btrfs_fs_info
>>> *fs_info, u64 root_tree_bytenr,
>>>        fs_info->last_trans_committed = generation;
>>>        if (extent_buffer_uptodate(fs_info->extent_root->node) &&
>>>            !(flags & OPEN_CTREE_NO_BLOCK_GROUPS)) {
>>> -        ret = btrfs_read_block_groups(fs_info->tree_root);
>>> +        ret = btrfs_read_block_groups(fs_info);
>>>            /*
>>>             * If we don't find any blockgroups (ENOENT) we're either
>>>             * restoring or creating the filesystem, where it's expected,
>>>             * anything else is error
>>>             */
>>> -        if (ret != -ENOENT)
>>> -            return -EIO;
>>> +        if (ret < 0 && ret != -ENOENT) {
>>> +            errno = -ret;
>>> +            error("failed to read block groups: %m");
>>> +            return ret;
>>> +        }
>>>        }
>>
>>
>> As mentioned this alters the rescue command semantics as show below.
>> Earlier we had only -EIO as error now its much more and accurate
>> which is good. fstests is fine but anything else?
>>
>> cmd_rescue_chunk_recover()
>>    btrfs_recover_chunk_tree()
>>      open_ctree_with_broken_chunk()
>>        btrfs_setup_all_roots()
> 
> I'm not sure if I got the point.
> 
> Although btrfs_setup_all_roots() get called in above call chain, it
> doesn't have any special handling of -EIO or others.
> 
> It just reads the extent tree root.
> 
> Would you mind to explain a little more?

  sure.
  The above thread is in the call chain of the command
     btrfs rescue chunk-recover [options] <device>"

  And as the its return error code is being changed for the same problem,
  so a separate patch not part of the bg-tree changes would make sense.

Thanks, Anand

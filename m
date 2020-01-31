Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A807D14E7F4
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 05:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgAaEms (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 23:42:48 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34182 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgAaEms (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 23:42:48 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V4cutt150583;
        Fri, 31 Jan 2020 04:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=nrX0vf3BqwNIzOW2oq9eGK92NNO8nomahj4puuomNFM=;
 b=qg7cWqQMixmyxvAiE3XY2U4D0yixxOMPo8g4Jen9OzPaXKX+MVCTAhgUlg+Sh5lZcm17
 DinfGQiJT/Rk9mL5gpNCfoki8Iik/SMVnXu/Nagbc9CIl2KuhHdbpwsRQFH5pL0P5KDw
 zCl71jiJMZPtcwUZnsUB6MNNFX3FQU3BINqAbBy8ZZO95FtNA637xasCt2VxFz8zeAmm
 er0Mflcpzh/WERZyLLeTjWgXXgDg0bJKTFW49lf2PhoGrVthk6toCVLGIS/iT5eYYYsT
 4XRTAq+AGJzgAgF+JsGvCBTOEbmD+UFQuOBS96xnGLUFwBqJlwc5/TkYc21m/WFCdUb8 PA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2xrdmr04mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 04:42:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00V4eCaU049390;
        Fri, 31 Jan 2020 04:42:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2xva6pmvf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jan 2020 04:42:37 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00V4gaYK013036;
        Fri, 31 Jan 2020 04:42:36 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jan 2020 20:42:36 -0800
Subject: Re: [PATCH] btrfs: Allow btrfs_truncate_block() to fallback to nocow
 for data space reservation
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, fdmanana@gmail.com
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Martin Doucha <martin.doucha@suse.com>
References: <20200130052822.11765-1-wqu@suse.com>
 <CAL3q7H4ODcwn7LVm=P3BBL7zd3wGRB_Vtr_KNk_2MysNNwgqcQ@mail.gmail.com>
 <8341b76f-bcbe-f2b9-d8b0-cfcd0006a47c@gmx.com>
 <CAL3q7H6Ueu0v8tzozci-dj4s3rTGx78jAGUrcYomZPAZ+6_MsA@mail.gmail.com>
 <35516074-f0fb-e0b4-bfc4-8b69f5fd9fb4@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <84bdee2d-8c72-cd1f-0018-a712d61b5a88@oracle.com>
Date:   Fri, 31 Jan 2020 12:42:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <35516074-f0fb-e0b4-bfc4-8b69f5fd9fb4@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001310040
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9516 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001310040
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30/1/20 7:02 PM, Qu Wenruo wrote:
> 
> 
> On 2020/1/30 下午6:46, Filipe Manana wrote:
>> On Thu, Jan 30, 2020 at 10:36 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>
>>>
>>>
>>> On 2020/1/30 下午6:02, Filipe Manana wrote:
>>>> On Thu, Jan 30, 2020 at 5:30 AM Qu Wenruo <wqu@suse.com> wrote:
>>>>>
>>>>> [BUG]
>>>>> When the data space is exhausted, even the inode has NOCOW attribute,
>>>>> btrfs will still refuse to truncate unaligned range due to ENOSPC.
>>>>>
>>>>> The following script can reproduce it pretty easily:
>>>>>    #!/bin/bash
>>>>>
>>>>>    dev=/dev/test/test
>>>>>    mnt=/mnt/btrfs
>>>>>
>>>>>    umount $dev &> /dev/null
>>>>>    umount $mnt&> /dev/null
>>>>>
>>>>>    mkfs.btrfs -f $dev -b 1G
>>>>>    mount -o nospace_cache $dev $mnt
>>>>>    touch $mnt/foobar
>>>>>    chattr +C $mnt/foobar
>>>>>
>>>>>    xfs_io -f -c "pwrite -b 4k 0 4k" $mnt/foobar > /dev/null
>>>>>    xfs_io -f -c "pwrite -b 4k 0 1G" $mnt/padding &> /dev/null
>>>>>    sync
>>>>>
>>>>>    xfs_io -c "fpunch 0 2k" $mnt/foobar
>>>>>    umount $mnt
>>>>>
>>>>> Current btrfs will fail at the fpunch part.
>>>>>
>>>>> [CAUSE]
>>>>> Because btrfs_truncate_block() always reserve space without checking the
>>>>> NOCOW attribute.
>>>>>
>>>>> Since the writeback path follows NOCOW bit, we only need to bother the
>>>>> space reservation code in btrfs_truncate_block().
>>>>>
>>>>> [FIX]
>>>>> Make btrfs_truncate_block() to follow btrfs_buffered_write() to try to
>>>>> reserve data space first, and falls back to NOCOW check only when we
>>>>> don't have enough space.
>>>>>
>>>>> Such always-try-reserve is an optimization introduced in
>>>>> btrfs_buffered_write(), to avoid expensive btrfs_check_can_nocow() call.
>>>>>
>>>>> Since now check_can_nocow() is needed outside of inode.c, also export it
>>>>> and rename it to btrfs_check_can_nocow().
>>>>>
>>>>> Reported-by: Martin Doucha <martin.doucha@suse.com>
>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>> ---
>>>>> Test case will be submitted to fstests by the reporter.
>>>>
>>>> Well, this is a sudden change of mind, isn't it? :)
>>>>
>>>> We had btrfs/172, which you removed very recently, that precisely tested this:
>>>>
>>>> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=538d8a4bcc782258f8f95fae815d5e859dee9126
>>>
>>> I didn't notice the nodatacow mount option. Super duper big facepalm.
>>>
>>> All my bad, especially feel sorry for Anand.
>>>
>>> With nodatacow mount option there, that test case in fact makes a lot of
>>> sense.
>>> Sorry again for that.
>>>
>>> Anand, mind to resubmit it to generic group?


  Lets restore it step by step. Patch sent to restore.
  You may like bring it to generic.

  Tested-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand


>> Why the generic group?
> 
> Since all other fses should have the same behavior.
> Either it supports COW, and get disabled by that chattr, and go ahead.
> Or it doesn't support COW, the truncate should go overwrite directly
> with or without that chattr +C.
> 
>> The nodatacow mount option is btrfs specific, and most filesystems
>> don't support chattr +C (ext4 for example).
> 
> We can just ignore the chattr call for unsupported fs, and go ahead
> without any problem.



> Thanks,
> Qu
> 
>>
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Even though there are several reasons why this can still fail (at
>>>> writeback time), like regular buffered writes through the family of
>>>> write() syscalls can, I think it's perfectly fine to have this
>>>> behaviour.
>>>>
>>>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>>>>
>>>> So I think we can just resurrect btrfs/172 now...
>>>>
>>>>> ---
>>>>>   fs/btrfs/ctree.h |  2 ++
>>>>>   fs/btrfs/file.c  | 10 +++++-----
>>>>>   fs/btrfs/inode.c | 41 ++++++++++++++++++++++++++++++++++-------
>>>>>   3 files changed, 41 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>>>>> index 54efb21c2727..b5639f3461e4 100644
>>>>> --- a/fs/btrfs/ctree.h
>>>>> +++ b/fs/btrfs/ctree.h
>>>>> @@ -2954,6 +2954,8 @@ int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
>>>>>   loff_t btrfs_remap_file_range(struct file *file_in, loff_t pos_in,
>>>>>                                struct file *file_out, loff_t pos_out,
>>>>>                                loff_t len, unsigned int remap_flags);
>>>>> +int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
>>>>> +                         size_t *write_bytes);
>>>>>
>>>>>   /* tree-defrag.c */
>>>>>   int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
>>>>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>>>>> index 8d47c76b7bd1..8dc084600f4e 100644
>>>>> --- a/fs/btrfs/file.c
>>>>> +++ b/fs/btrfs/file.c
>>>>> @@ -1544,8 +1544,8 @@ lock_and_cleanup_extent_if_need(struct btrfs_inode *inode, struct page **pages,
>>>>>          return ret;
>>>>>   }
>>>>>
>>>>> -static noinline int check_can_nocow(struct btrfs_inode *inode, loff_t pos,
>>>>> -                                   size_t *write_bytes)
>>>>> +int btrfs_check_can_nocow(struct btrfs_inode *inode, loff_t pos,
>>>>> +                         size_t *write_bytes)
>>>>>   {
>>>>>          struct btrfs_fs_info *fs_info = inode->root->fs_info;
>>>>>          struct btrfs_root *root = inode->root;
>>>>> @@ -1645,8 +1645,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>>>>>                  if (ret < 0) {
>>>>>                          if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
>>>>>                                                        BTRFS_INODE_PREALLOC)) &&
>>>>> -                           check_can_nocow(BTRFS_I(inode), pos,
>>>>> -                                       &write_bytes) > 0) {
>>>>> +                           btrfs_check_can_nocow(BTRFS_I(inode), pos,
>>>>> +                                                 &write_bytes) > 0) {
>>>>>                                  /*
>>>>>                                   * For nodata cow case, no need to reserve
>>>>>                                   * data space.
>>>>> @@ -1923,7 +1923,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
>>>>>                   */
>>>>>                  if (!(BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
>>>>>                                                BTRFS_INODE_PREALLOC)) ||
>>>>> -                   check_can_nocow(BTRFS_I(inode), pos, &count) <= 0) {
>>>>> +                   btrfs_check_can_nocow(BTRFS_I(inode), pos, &count) <= 0) {
>>>>>                          inode_unlock(inode);
>>>>>                          return -EAGAIN;
>>>>>                  }
>>>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>>>> index 5509c41a4f43..b5ae4bbf1ad4 100644
>>>>> --- a/fs/btrfs/inode.c
>>>>> +++ b/fs/btrfs/inode.c
>>>>> @@ -4974,11 +4974,13 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
>>>>>          struct extent_state *cached_state = NULL;
>>>>>          struct extent_changeset *data_reserved = NULL;
>>>>>          char *kaddr;
>>>>> +       bool only_release_metadata = false;
>>>>>          u32 blocksize = fs_info->sectorsize;
>>>>>          pgoff_t index = from >> PAGE_SHIFT;
>>>>>          unsigned offset = from & (blocksize - 1);
>>>>>          struct page *page;
>>>>>          gfp_t mask = btrfs_alloc_write_mask(mapping);
>>>>> +       size_t write_bytes = blocksize;
>>>>>          int ret = 0;
>>>>>          u64 block_start;
>>>>>          u64 block_end;
>>>>> @@ -4990,11 +4992,26 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
>>>>>          block_start = round_down(from, blocksize);
>>>>>          block_end = block_start + blocksize - 1;
>>>>>
>>>>> -       ret = btrfs_delalloc_reserve_space(inode, &data_reserved,
>>>>> -                                          block_start, blocksize);
>>>>> -       if (ret)
>>>>> +       ret = btrfs_check_data_free_space(inode, &data_reserved, block_start,
>>>>> +                                         blocksize);
>>>>> +       if (ret < 0) {
>>>>> +               if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
>>>>> +                                             BTRFS_INODE_PREALLOC)) &&
>>>>> +                   btrfs_check_can_nocow(BTRFS_I(inode), block_start,
>>>>> +                                         &write_bytes) > 0) {
>>>>> +                       /* For nocow case, no need to reserve data space. */
>>>>> +                       only_release_metadata = true;
>>>>> +               } else {
>>>>> +                       goto out;
>>>>> +               }
>>>>> +       }
>>>>> +       ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), blocksize);
>>>>> +       if (ret < 0) {
>>>>> +               if (!only_release_metadata)
>>>>> +                       btrfs_free_reserved_data_space(inode, data_reserved,
>>>>> +                                       block_start, blocksize);
>>>>>                  goto out;
>>>>> -
>>>>> +       }
>>>>>   again:
>>>>>          page = find_or_create_page(mapping, index, mask);
>>>>>          if (!page) {
>>>>> @@ -5063,10 +5080,20 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
>>>>>          set_page_dirty(page);
>>>>>          unlock_extent_cached(io_tree, block_start, block_end, &cached_state);
>>>>>
>>>>> +       if (only_release_metadata)
>>>>> +               set_extent_bit(&BTRFS_I(inode)->io_tree, block_start,
>>>>> +                               block_end, EXTENT_NORESERVE, NULL, NULL,
>>>>> +                               GFP_NOFS);
>>>>> +
>>>>>   out_unlock:
>>>>> -       if (ret)
>>>>> -               btrfs_delalloc_release_space(inode, data_reserved, block_start,
>>>>> -                                            blocksize, true);
>>>>> +       if (ret) {
>>>>> +               if (!only_release_metadata)
>>>>> +                       btrfs_delalloc_release_space(inode, data_reserved,
>>>>> +                                       block_start, blocksize, true);
>>>>> +               else
>>>>> +                       btrfs_delalloc_release_metadata(BTRFS_I(inode),
>>>>> +                                       blocksize, true);
>>>>
>>>> I usually find it more intuitive to have it the other way around:
>>>>
>>>> if (only_release_metadata)
>>>>    ...
>>>> else
>>>>    ...
>>>>
>>>> E.g., positive case first, negative in the else branch. But that's
>>>> likely too much of a personal preference.
>>>>
>>>> Thanks.
>>>>
>>>>> +       }
>>>>>          btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize);
>>>>>          unlock_page(page);
>>>>>          put_page(page);
>>>>> --
>>>>> 2.25.0
>>>>>
>>>>
>>>>
>>>
>>
>>
> 

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD3C17C0E8
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 15:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgCFOwK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 09:52:10 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42927 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgCFOwJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Mar 2020 09:52:09 -0500
Received: by mail-qk1-f195.google.com with SMTP id e11so2492439qkg.9
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Mar 2020 06:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bls35MS/M6CGE0z8RpD9ZAw9yKG7y9d4SRDG83XFO/I=;
        b=FrioQXbeq6kTNmu9km/Qz2KkoGKf5Qtm4QcR+KTwdEK7k/v/CjDqklnb0QJlm5te2u
         gO5Xh1tR0iNJUO7EXqNMLUfBziWpgHUz+LjpjOtLdbvJE/EpGt+Nzv/NywbuvuiC7q0+
         r3t3388kjIp1baf6DIcNnaFb9Df8fD14+YgW3aCUNRl7Q14q+kjOcKtr0G9nrn1eZ25R
         ScUIV3uZBr24m/lZ2HQ9CIXPhgv08R0B1b4dLx1pW/XNsqjVJ7qmhJ9e6wSpK/jd+rE+
         7pfjLole9Gickgabfj7Jd/ikmyQp9986KLeKGkoVRQQBbubcmtCUxosoah6oR/Dy+udn
         wVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bls35MS/M6CGE0z8RpD9ZAw9yKG7y9d4SRDG83XFO/I=;
        b=N7OfzDCPmkpCJ4JzCQ3Mj5vVsf1PxBqIO2x6aCVnQ1YOrkO5Wp0PNMM9eaJc5ueK/I
         TAnAqK7cMOUYCzDUieVZCcMO9KDYp6KVOw7ac9RhacX/7Gr1g1I7bHtDWJTWpQrMNh9L
         IFyGfdnsU5ji7DWPDWL/9/UQvlWBT4IJ0mJ7boNOqnI0jutJtSJ5vOP9tjZO4peWzxQQ
         NLSsdPcqTg//BkKJH+X/iLUqDnwh/sD+n0YmskaeSp10KK0lURn/j7kW9QjOcZ7KYnRP
         DUj9H6gIQA80QOC504To3RpQRwe+niT5FccfNVFcyh28J61ijMeSDHJzstTSOdVt4x2q
         NlYg==
X-Gm-Message-State: ANhLgQ0xn2+JtxL179CC3DCJ40jbyWjNIXr1TZxk/SWs5hKO4Ij3rVAs
        BJ5QxilZY15VOG+SnhLlFeiI0Q==
X-Google-Smtp-Source: ADFU+vvlQFTwRbL5o1630Xazwj/+V5EuSptvarbSAc+uUudo86vzQELIQhV3l6lYDNFxNW1HQaAZXQ==
X-Received: by 2002:a37:9a8b:: with SMTP id c133mr3205531qke.132.1583506327756;
        Fri, 06 Mar 2020 06:52:07 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n46sm2147300qtb.48.2020.03.06.06.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 06:52:06 -0800 (PST)
Subject: Re: [PATCH 4/6] btrfs: use the file extent tree infrastructure
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
References: <20200117140224.42495-1-josef@toxicpanda.com>
 <20200117140224.42495-5-josef@toxicpanda.com>
 <CAL3q7H69_tEsV2WGu9Y6ZgB_1gy9WKPB5iR9XiWaUGiU6C871A@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <dfa3dbad-81f0-2c3a-00ae-a991a7254118@toxicpanda.com>
Date:   Fri, 6 Mar 2020 09:52:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H69_tEsV2WGu9Y6ZgB_1gy9WKPB5iR9XiWaUGiU6C871A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/6/20 6:51 AM, Filipe Manana wrote:
> On Fri, Jan 17, 2020 at 2:03 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> We want to use this everywhere we modify the file extent items
>> permanently.  These include
>>
>> 1) Inserting new file extents for writes and prealloc extents.
>> 2) Truncating inode items.
>> 3) btrfs_cont_expand().
>> 4) Insert inline extents.
>> 5) Insert new extents from log replay.
>> 6) Insert a new extent for clone, as it could be past isize.
>>
>> We do not however call the clear helper for hole punching because it
>> simply swaps out an existing file extent for a hole, so there's
>> effectively no change as far as the i_size is concerned.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> ---
>>   fs/btrfs/delayed-inode.c |  4 +++
>>   fs/btrfs/file.c          |  6 ++++
>>   fs/btrfs/inode.c         | 59 +++++++++++++++++++++++++++++++++++++++-
>>   fs/btrfs/tree-log.c      |  5 ++++
>>   4 files changed, 73 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
>> index d3e15e1d4a91..8b4dcf4f6b3e 100644
>> --- a/fs/btrfs/delayed-inode.c
>> +++ b/fs/btrfs/delayed-inode.c
>> @@ -1762,6 +1762,7 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
>>   {
>>          struct btrfs_delayed_node *delayed_node;
>>          struct btrfs_inode_item *inode_item;
>> +       struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
>>
>>          delayed_node = btrfs_get_delayed_node(BTRFS_I(inode));
>>          if (!delayed_node)
>> @@ -1779,6 +1780,9 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
>>          i_uid_write(inode, btrfs_stack_inode_uid(inode_item));
>>          i_gid_write(inode, btrfs_stack_inode_gid(inode_item));
>>          btrfs_i_size_write(BTRFS_I(inode), btrfs_stack_inode_size(inode_item));
>> +       btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
>> +                                         round_up(i_size_read(inode),
>> +                                                  fs_info->sectorsize));
>>          inode->i_mode = btrfs_stack_inode_mode(inode_item);
>>          set_nlink(inode, btrfs_stack_inode_nlink(inode_item));
>>          inode_set_bytes(inode, btrfs_stack_inode_nbytes(inode_item));
>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>> index c6f9029e3d49..f72fb38e9aaa 100644
>> --- a/fs/btrfs/file.c
>> +++ b/fs/btrfs/file.c
>> @@ -2482,6 +2482,12 @@ static int btrfs_insert_clone_extent(struct btrfs_trans_handle *trans,
>>          btrfs_mark_buffer_dirty(leaf);
>>          btrfs_release_path(path);
>>
>> +       ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode),
>> +                                               clone_info->file_offset,
>> +                                               clone_len);
>> +       if (ret)
>> +               return ret;
>> +
>>          /* If it's a hole, nothing more needs to be done. */
>>          if (clone_info->disk_offset == 0)
>>                  return 0;
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index fd8f821a3919..21fb80292256 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -241,6 +241,15 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
>>          btrfs_mark_buffer_dirty(leaf);
>>          btrfs_release_path(path);
>>
>> +       /*
>> +        * We align size to sectorsize for inline extents just for simplicity
>> +        * sake.
>> +        */
>> +       size = ALIGN(size, root->fs_info->sectorsize);
>> +       ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), start, size);
>> +       if (ret)
>> +               goto fail;
>> +
>>          /*
>>           * we're an inline extent, so nobody can
>>           * extend the file past i_size without locking
>> @@ -2375,6 +2384,11 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
>>          ins.offset = disk_num_bytes;
>>          ins.type = BTRFS_EXTENT_ITEM_KEY;
>>
>> +       ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), file_pos,
>> +                                               ram_bytes);
>> +       if (ret)
>> +               goto out;
>> +
>>          /*
>>           * Release the reserved range from inode dirty range map, as it is
>>           * already moved into delayed_ref_head
>> @@ -4084,6 +4098,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
>>          }
>>
>>          while (1) {
>> +               u64 clear_start = 0, clear_len = 0;
>> +
>>                  fi = NULL;
>>                  leaf = path->nodes[0];
>>                  btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
>> @@ -4134,6 +4150,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
>>
>>                  if (extent_type != BTRFS_FILE_EXTENT_INLINE) {
>>                          u64 num_dec;
>> +
>> +                       clear_start = found_key.offset;
>>                          extent_start = btrfs_file_extent_disk_bytenr(leaf, fi);
>>                          if (!del_item) {
>>                                  u64 orig_num_bytes =
>> @@ -4141,6 +4159,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
>>                                  extent_num_bytes = ALIGN(new_size -
>>                                                  found_key.offset,
>>                                                  fs_info->sectorsize);
>> +                               clear_start = ALIGN(new_size,
>> +                                                   fs_info->sectorsize);
>>                                  btrfs_set_file_extent_num_bytes(leaf, fi,
>>                                                           extent_num_bytes);
>>                                  num_dec = (orig_num_bytes -
>> @@ -4166,6 +4186,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
>>                                                  inode_sub_bytes(inode, num_dec);
>>                                  }
>>                          }
>> +                       clear_len = num_dec;
>>                  } else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
>>                          /*
>>                           * we can't truncate inline items that have had
>> @@ -4187,12 +4208,34 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
>>                                   */
>>                                  ret = NEED_TRUNCATE_BLOCK;
>>                                  break;
>> +                       } else {
>> +                               /*
>> +                                * Inline extents are special, we just treat
>> +                                * them as a full sector worth in the file
>> +                                * extent tree just for simplicity sake.
>> +                                */
>> +                               clear_len = fs_info->sectorsize;
>>                          }
>>
>>                          if (test_bit(BTRFS_ROOT_REF_COWS, &root->state))
>>                                  inode_sub_bytes(inode, item_end + 1 - new_size);
>>                  }
>>   delete:
>> +               /*
>> +                * We use btrfs_truncate_inode_items() to clean up log trees for
>> +                * multiple fsyncs, and in this case we don't want to clear the
>> +                * file extent range because it's just the log.
>> +                */
>> +               if (root == BTRFS_I(inode)->root) {
>> +                       ret = btrfs_inode_clear_file_extent_range(BTRFS_I(inode),
>> +                                                                 clear_start,
>> +                                                                 clear_len);
>> +                       if (ret) {
>> +                               btrfs_abort_transaction(trans, ret);
>> +                               break;
>> +                       }
>> +               }
>> +
>>                  if (del_item)
>>                          last_size = found_key.offset;
>>                  else
>> @@ -4513,14 +4556,22 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
>>                  }
>>                  last_byte = min(extent_map_end(em), block_end);
>>                  last_byte = ALIGN(last_byte, fs_info->sectorsize);
>> +               hole_size = last_byte - cur_offset;
>> +
>>                  if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
>>                          struct extent_map *hole_em;
>> -                       hole_size = last_byte - cur_offset;
>>
>>                          err = maybe_insert_hole(root, inode, cur_offset,
>>                                                  hole_size);
>>                          if (err)
>>                                  break;
>> +
>> +                       err = btrfs_inode_set_file_extent_range(BTRFS_I(inode),
>> +                                                               cur_offset,
>> +                                                               hole_size);
>> +                       if (err)
>> +                               break;
>> +
>>                          btrfs_drop_extent_cache(BTRFS_I(inode), cur_offset,
>>                                                  cur_offset + hole_size - 1, 0);
>>                          hole_em = alloc_extent_map();
>> @@ -4552,6 +4603,12 @@ int btrfs_cont_expand(struct inode *inode, loff_t oldsize, loff_t size)
>>                                                          hole_size - 1, 0);
>>                          }
>>                          free_extent_map(hole_em);
>> +               } else {
>> +                       err = btrfs_inode_set_file_extent_range(BTRFS_I(inode),
>> +                                                               cur_offset,
>> +                                                               hole_size);
>> +                       if (err)
>> +                               break;
>>                  }
>>   next:
>>                  free_extent_map(em);
>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
>> index 80978ebfdcbb..56278a5b69e4 100644
>> --- a/fs/btrfs/tree-log.c
>> +++ b/fs/btrfs/tree-log.c
>> @@ -830,6 +830,11 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
>>                          goto out;
>>          }
>>
>> +       ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), start,
>> +                                               extent_end - start);
>> +       if (ret)
>> +               goto out;
> 
> So while working on making ranged fsyncs for the slow patch (inode has
> the 'need full sync' flag set), I uncovered more cases where we end up
> with missing file extent items.
> 
> When doing a fast fsync, we log only the extents in the given range,
> but we log an inode item with the current i_size of the inode.
> So after a log replay we can get missing file extent items.
> 

For this case I think we need to not just log that current range, we need to log 
anything that was changed leading up to that offset.  Range fsync is just an 
optimization, in the !NO_HOLES case we need to make sure we're still leaving the 
fs in a consistent state, so if we have any modified extents that lead up to our 
range those need to be logged as well.  Thanks,

Josef

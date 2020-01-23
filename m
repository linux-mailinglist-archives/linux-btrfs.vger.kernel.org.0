Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB78146953
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 14:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgAWNks (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 08:40:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39457 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgAWNks (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 08:40:48 -0500
Received: by mail-qk1-f196.google.com with SMTP id c16so3405022qko.6
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jan 2020 05:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pyqM6+FXhk0/dMP3uj46VSR97YwPcdKXEZ+4JMVkNhc=;
        b=OE05zdUA8MQA/XpsnO9k7LJuoFMBZDHvzOSDd1B5ApuOQ3xhAq5IJt/Vm9zWjFgaq/
         gnMJYRNT3Epul6BQAuljBq5TGo1xFKXeIDywd6He1gWOiLIyzOdS5Fayq4DQyi5KQKGW
         E1GARa3PnQHEyi/NUXkL1y05x3WLiAYztdSVObUvlZbTUSLeumdIyo2mGBByB//NZMk6
         CybRa1yHOM00FwthcdEucyJd7WoPfo3qJ2TbPq7qbzuvGItWeirNQlXzhibBrYkj8ogP
         Pobo0J/BlTBB5inNcqrWIVPLd7QZLyR3W1ODI5YW+zGeyfyZUeF1T9wtd5TNcjxsRn8d
         ADcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pyqM6+FXhk0/dMP3uj46VSR97YwPcdKXEZ+4JMVkNhc=;
        b=h66CwVpDb3JtfFmIIcL8HJD8MCwjxCDpp/3QFESvkv3bMXSzmoz7uJB/03j/MYMikv
         ohrIFaiTKZ7yPHsdmqwU8EejJj9vU57Ne0jSk79S2zDbKOJycfpYl34/nwqVt4SER8E+
         mX4VqJYoVZHpfUh+j0O49Xz5OHdavZchVBNtYyOWDUOsdn65K0UrWtP2IKGQTFZh4DlX
         2jr2vABxWa5/uBps46M2jAk8OKT+CfF7H3WTIyV39ZEOm7hzo8R0DQqol7mPuzKXilzy
         MDT6P3mjZp9GJ/tAwB1ZIn6ueXT6cqWHjeu1jMsGQt5TuGTVl5dhf5xF/7hHTdgZ4GBy
         BMgg==
X-Gm-Message-State: APjAAAX7zO+NlzAIpzlsw9VrSYOqzRaM92igevYbBkDSzDNL0rVOP+dX
        wFMmOMLUqAgWPy2iKZpfjNXkghNYGUN8Mw==
X-Google-Smtp-Source: APXvYqzWTZAuEKFSIH2JonJxsJCLudRUjx0HdyePBmvc+ip2i3iOwDFJgmrGcNMje/q1pfQUqzrn0w==
X-Received: by 2002:a37:e505:: with SMTP id e5mr14364991qkg.324.1579786846430;
        Thu, 23 Jan 2020 05:40:46 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::7e55])
        by smtp.gmail.com with ESMTPSA id a19sm873981qka.75.2020.01.23.05.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 05:40:45 -0800 (PST)
Subject: Re: [PATCH 11/11] btrfs: Use btrfs_transaction::pinned_extents
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200120140918.15647-1-nborisov@suse.com>
 <20200120140918.15647-12-nborisov@suse.com>
 <b98bb8f2-2f3f-748b-793a-b9772f9f3569@toxicpanda.com>
 <3396ff95-dbc0-dd91-8c91-4509933e3a30@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6f66366c-08f9-b8a1-ec94-0f9108a00542@toxicpanda.com>
Date:   Thu, 23 Jan 2020 08:40:44 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3396ff95-dbc0-dd91-8c91-4509933e3a30@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/23/20 3:54 AM, Nikolay Borisov wrote:
> 
> 
> On 22.01.20 г. 22:21 ч., Josef Bacik wrote:
>> On 1/20/20 9:09 AM, Nikolay Borisov wrote:
>>> This commit flips the switch to start tracking/processing pinned
>>> extents on a per-transaction basis. It mostly replaces all references
>>> from btrfs_fs_info::(pinned_extents|freed_extents[]) to
>>> btrfs_transaction::pinned_extents. Two notable modifications that
>>> warrant explicit mention are changing clean_pinned_extents to get a
>>> reference to the previously running transaction. The other one is
>>> removal of call to btrfs_destroy_pinned_extent since transactions are
>>> going to be cleaned in btrfs_cleanup_one_transaction.
>>>
>>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>>
>> I'd prefer if the excluded extent changes were separate from the pinned
>> extent changes.
>>
>>> ---
>>>    fs/btrfs/block-group.c       | 38 ++++++++++++++++++++++++------------
>>>    fs/btrfs/ctree.h             |  4 ++--
>>>    fs/btrfs/disk-io.c           | 30 +++++-----------------------
>>>    fs/btrfs/extent-io-tree.h    |  3 +--
>>>    fs/btrfs/extent-tree.c       | 31 ++++++++---------------------
>>>    fs/btrfs/free-space-cache.c  |  2 +-
>>>    fs/btrfs/tests/btrfs-tests.c |  7 ++-----
>>>    fs/btrfs/transaction.c       |  1 +
>>>    fs/btrfs/transaction.h       |  1 +
>>>    include/trace/events/btrfs.h |  3 +--
>>>    10 files changed, 47 insertions(+), 73 deletions(-)
>>>
>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>> index 48bb9e08f2e8..562dfb7dc77f 100644
>>> --- a/fs/btrfs/block-group.c
>>> +++ b/fs/btrfs/block-group.c
>>> @@ -460,7 +460,7 @@ u64 add_new_free_space(struct btrfs_block_group
>>> *block_group, u64 start, u64 end
>>>        int ret;
>>>          while (start < end) {
>>> -        ret = find_first_extent_bit(info->pinned_extents, start,
>>> +        ret = find_first_extent_bit(&info->excluded_extents, start,
>>>                            &extent_start, &extent_end,
>>>                            EXTENT_DIRTY | EXTENT_UPTODATE,
>>>                            NULL);
>>
>> We're no longer doing EXTENT_DIRTY in excluded_extents, so we don't need
>> this part.
>>
>>> @@ -1233,32 +1233,44 @@ static int inc_block_group_ro(struct
>>> btrfs_block_group *cache, int force)
>>>        return ret;
>>>    }
>>>    -static bool clean_pinned_extents(struct btrfs_block_group *bg)
>>> +static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
>>> +                 struct btrfs_block_group *bg)
>>>    {
>>>        struct btrfs_fs_info *fs_info = bg->fs_info;
>>> +    struct btrfs_transaction *prev_trans = NULL;
>>>        u64 start = bg->start;
>>>        u64 end = start + bg->length - 1;
>>>        int ret;
>>>    +    spin_lock(&fs_info->trans_lock);
>>> +    if (trans->transaction->list.prev != &fs_info->trans_list) {
>>> +        prev_trans = list_entry(trans->transaction->list.prev,
>>> +                    struct btrfs_transaction, list);
>>> +        refcount_inc(&prev_trans->use_count);
>>> +    }
>>> +    spin_unlock(&fs_info->trans_lock);
>>> +
>>>        /*
>>>         * Hold the unused_bg_unpin_mutex lock to avoid racing with
>>>         * btrfs_finish_extent_commit(). If we are at transaction N,
>>>         * another task might be running finish_extent_commit() for the
>>>         * previous transaction N - 1, and have seen a range belonging
>>> -     * to the block group in freed_extents[] before we were able to
>>> -     * clear the whole block group range from freed_extents[]. This
>>> +     * to the block group in pinned_extents before we were able to
>>> +     * clear the whole block group range from pinned_extents. This
>>>         * means that task can lookup for the block group after we
>>> -     * unpinned it from freed_extents[] and removed it, leading to
>>> +     * unpinned it from pinned_extents[] and removed it, leading to
>>>         * a BUG_ON() at unpin_extent_range().
>>>         */
>>>        mutex_lock(&fs_info->unused_bg_unpin_mutex);
>>> -    ret = clear_extent_bits(&fs_info->freed_extents[0], start, end,
>>> -              EXTENT_DIRTY);
>>> -    if (ret)
>>> -        goto failure;
>>> +    if (prev_trans) {
>>> +        ret = clear_extent_bits(&prev_trans->pinned_extents, start, end,
>>> +                    EXTENT_DIRTY);
>>> +        if (ret)
>>> +            goto failure;
>>> +    }
>>
>> You are leaking a ref to prev_trans here.
>>
>> <snip>
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index 9209c7b0997c..3cb786463eb2 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -2021,10 +2021,8 @@ void btrfs_free_fs_roots(struct btrfs_fs_info
>>> *fs_info)
>>>                btrfs_drop_and_free_fs_root(fs_info, gang[i]);
>>>        }
>>>    -    if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
>>> +    if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
>>>            btrfs_free_log_root_tree(NULL, fs_info);
>>> -        btrfs_destroy_pinned_extent(fs_info, fs_info->pinned_extents);
>>> -    }
>>
>> What about the excluded extents?  We may never cache the block group
>> with one of the super mirrors in it, and thus we would leak the excluded
>> extent for it.  Thanks,
> 
> btrfs_destroy_pinned_extent didn't touch EXTENT_UPDATE (excluded
> extents) before so my removing this call doesn't change that. E.g. if
> there is a bug here where excluded extents are not cleaned up then it's
> not due to my code.
> 
> On the other hand I don't quite understand your concern w.r.t pinned
> extents. Can you elaborate?
> 

Sorry thunderbird ate my followup, we drop the excluded extents in 
btrfs_free_block_groups() if they are never cached, so you are fine here.  Thanks,

Josef


Return-Path: <linux-btrfs+bounces-9111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BC19AD9C7
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 04:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2BB283396
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Oct 2024 02:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFC914A4CC;
	Thu, 24 Oct 2024 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="DuSQju5P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B9E1482F2
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Oct 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729736432; cv=none; b=WePWgU5Bkjb8ID7KHs46hFETWFGzKzU+RZPfKvps1lXxsMHu4EGJ0vsWJy+UuYcBIrT4PnVATpM3fiLJBnBh/cGKmzfY66sM8ZbzBYIsASG9Yq71xNz/yroVvrYHzxeFAYO29hZ4qaHl3dgDuS0mfS3c3fWCh9YLB553LU0Ss5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729736432; c=relaxed/simple;
	bh=YDGBFNo0nn+4gKGkoebbInhlRlemYBX/UvEnEq4YsR8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=myVW0G+25PZgl6O9ooAgBVQKKXYYi+ODH0tlvOTWM2ehwEWhXvyePnuGw1eWm2lm1cNSpsSQasIDsJqaZ63iqManyKFbKBmzcZqVC5Jlap9jha0qy+Yf9520xCwp5nJwnEHLkS+kfJyVlp+s6eN3Dwh/4zegcZxl+0643dsVzEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=DuSQju5P; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Subject: Re: [PATCH] btrfs: reduce lock contention with not always use keep
 locks when insert extent backref
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1729736428; bh=YDGBFNo0nn+4gKGkoebbInhlRlemYBX/UvEnEq4YsR8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To;
	b=DuSQju5P76bH8tE2geG76dK4PMegcvXO1NieYMnb/pi2iHYo0RKQLs9IoowAzH2EG
	 Q8wsAm/4MVAGgjhQcriAuuQwRXtQi4Mjhz2zvvU0a6tnxciPms1dkuX+CMWn7UZKIk
	 JQm5GfwNFtatcZ5d6nXNuk6v5gZ9TNiIyr+JjWmc=
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <20241023063818.11438-1-robbieko@synology.com>
 <CAL3q7H7T4QY0mP_mFQOaQarY+h70mksgiMvnQ8VxKN9CohNZ-Q@mail.gmail.com>
From: robbieko <robbieko@synology.com>
Message-ID: <5725ac02-8e95-bc57-148f-2e500f53003a@synology.com>
Date: Thu, 24 Oct 2024 10:20:28 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAL3q7H7T4QY0mP_mFQOaQarY+h70mksgiMvnQ8VxKN9CohNZ-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0


Filipe Manana 於 2024/10/23 下午6:34 寫道:
> On Wed, Oct 23, 2024 at 7:39 AM robbieko <robbieko@synology.com> wrote:
>> From: Robbie Ko <robbieko@synology.com>
>>
>> When inserting extent backref, in order to check whether
>> refs other than inline refs are used, we always use keep
>> locks for tree search, which will increase the lock
>> contention of extent-tree.
> The line length limit is 75, you're using about 50 characters per line.
> You can make the lines use more characters which makes things a bit
> easier to read.
>
> On the other hand the subject is kind of too long and phrased a bit oddly:
>
> btrfs: reduce lock contention with not always use keep locks when
> insert extent backref
>
> I would suggest something like:
>
> btrfs: reduce extent tree lock contention when searching for inline backref

Ok, I will modify and send a new patch again.

Thanks.

>> We do not need the parent node every time to determine
>> whether normal refs are used.
>> It is only needed when the extent-item is the last item in leaf.
> in leaf -> in a leaf
>
>> Therefore, we change to first use keep_locks=0 for search.
>> If the extent-item happens to be the last item in leaf,
> in leaf -> in the leaf
>
>> we then change to keep_locks=1 for the second search to
>> slow down lock contention.
> slow down -> reduce
>
>> Signed-off-by: Robbie Ko <robbieko@synology.com>
>> ---
>>   fs/btrfs/extent-tree.c | 27 ++++++++++++++++++++++++---
>>   1 file changed, 24 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>> index a5966324607d..7d5033b20a40 100644
>> --- a/fs/btrfs/extent-tree.c
>> +++ b/fs/btrfs/extent-tree.c
>> @@ -786,6 +786,8 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
>>          int ret;
>>          bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
>>          int needed;
>> +       bool keep_locks = false;
> There's no need to use this variable, we can use path->keep_locks directly.
>
>> +       struct btrfs_key tmp_key;
> Please move the declaration of tmp_key to the block where it's used, see below.
>
>>          key.objectid = bytenr;
>>          key.type = BTRFS_EXTENT_ITEM_KEY;
>> @@ -795,7 +797,6 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
>>          if (insert) {
>>                  extra_size = btrfs_extent_inline_ref_size(want);
>>                  path->search_for_extension = 1;
>> -               path->keep_locks = 1;
>>          } else
>>                  extra_size = -1;
>>
>> @@ -946,6 +947,24 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
>>                          ret = -EAGAIN;
>>                          goto out;
>>                  }
>> +
>> +               if (path->slots[0] + 1 < btrfs_header_nritems(path->nodes[0])) {
> Here place the declaration of tmp_key, since it's not used outside this block.
>
> Everything else looks good, thanks.
>
>> +                       btrfs_item_key_to_cpu(path->nodes[0], &tmp_key, path->slots[0] + 1);
>> +                       if (tmp_key.objectid == bytenr &&
>> +                               tmp_key.type < BTRFS_BLOCK_GROUP_ITEM_KEY) {
>> +                               ret = -EAGAIN;
>> +                               goto out;
>> +                       }
>> +                       goto enoent;
>> +               }
>> +
>> +               if (!keep_locks) {
>> +                       btrfs_release_path(path);
>> +                       path->keep_locks = 1;
>> +                       keep_locks = true;
>> +                       goto again;
>> +               }
>> +
>>                  /*
>>                   * To add new inline back ref, we have to make sure
>>                   * there is no corresponding back ref item.
>> @@ -959,13 +978,15 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
>>                          goto out;
>>                  }
>>          }
>> +enoent:
>>          *ref_ret = (struct btrfs_extent_inline_ref *)ptr;
>>   out:
>> -       if (insert) {
>> +       if (keep_locks) {
>>                  path->keep_locks = 0;
>> -               path->search_for_extension = 0;
>>                  btrfs_unlock_up_safe(path, 1);
>>          }
>> +       if (insert)
>> +               path->search_for_extension = 0;
>>          return ret;
>>   }
>>
>> --
>> 2.17.1
>>
>>


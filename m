Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6806A27CF06
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Sep 2020 15:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgI2NXp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 09:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgI2NXp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 09:23:45 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C95CC061755
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Sep 2020 06:23:45 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s131so4247676qke.0
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Sep 2020 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D5yBZEzoeGn8DTHIiiSgtUvz6i9SDjHR8YcaHjfeCVY=;
        b=LHHrmt8Z/Tlv29NwuH9sU48JduXH+DkoQ/TOgZ3Xxbuhg/2rzKPDvjKXNVsYPKy3EK
         RfrzK7yOdY91U1iYfJEAsdGNT32xgXcVrm3wdkI0gg+jMe2YmcSi+9Sq7+pc4fsDKYW/
         6ZxxvhuhGFtNFfx9O7cXQDisLx/Z0j1X4uxRvlY9JVsFkBDZVsRgBhAEwV/vSTJuGwzd
         N4dB0uJFOUXdPVskekHjc5nCMCXh26YDjWvgWZwRTBSG6vagK9ovGiXvD1+qlQ3EwIAT
         3jR7AtdCBdVbjU3Rqp3H2Uu7L1GodcjNNco+HJWGBgY2JlXPHGvKugZpLc9fvHxQT58E
         sXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D5yBZEzoeGn8DTHIiiSgtUvz6i9SDjHR8YcaHjfeCVY=;
        b=Z4TGXpGReW+f0ODPuHOISvUrK6LWf70vf1OwiAgF6ZQCXHkfQYiblvP9AolhQwEDec
         z393uMDHDdaVLc0EgkQ63+EOexHQmJ/RDJsLePy/kZO5DHiNWCRJDi0XQ5R/4bEGlAho
         iNekqqepDIQWYFYC2IYssyTR/ctE+vN4rpm3p526kleCyt6/ZFy1eg6A80Bb+Q7Vvk43
         hIHyNSXCk18wAf+SKJ2ZX9EglbyDlsbh4G1Hdip/NiwqZ1mX8uzwWbTKI+eChWyvOqQc
         +eFRpKUcdQ7tdg88iCvr9SjVKRZ8uivmBe9GDxKAuMDorfpZ5i7XMi+a5bVhF8nZclXq
         /TRg==
X-Gm-Message-State: AOAM531cr5reD7MZdldzjTWV6QNSej3oUuxyINzXVxzMJk6DseW00J+T
        U2umSEmCX8cL+81rjZNVoIArEA==
X-Google-Smtp-Source: ABdhPJyb84TxCZRjof5EIw+MfGkwOjS31P/IiDbbJtiHp43aNCvcB+rfxrly9SQgp3mf+STyT8DD6A==
X-Received: by 2002:a37:7486:: with SMTP id p128mr4422329qkc.33.1601385824328;
        Tue, 29 Sep 2020 06:23:44 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c13sm5553083qtq.5.2020.09.29.06.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 06:23:43 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: cleanup cow block on error
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
References: <1f84722853326611d5d0d6c74e7af75be7b5928d.1601384009.git.josef@toxicpanda.com>
 <CAL3q7H66bd6S-p5f4g7bmk2jMYemGRkQM3km=LKRkzuBbeug+w@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f7047495-0c79-7d8b-2782-defc3b7ff85f@toxicpanda.com>
Date:   Tue, 29 Sep 2020 09:23:42 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <CAL3q7H66bd6S-p5f4g7bmk2jMYemGRkQM3km=LKRkzuBbeug+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/29/20 9:19 AM, Filipe Manana wrote:
> On Tue, Sep 29, 2020 at 1:55 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> With my automated fstest runs I noticed one of my workers didn't report
>> results.  Turns out it was hung trying to write back inodes, and the
>> write back thread was stuck trying to lock an extent buffer
>>
>> [root@xfstests2 xfstests-dev]# cat /proc/2143497/stack
>> [<0>] __btrfs_tree_lock+0x108/0x250
>> [<0>] lock_extent_buffer_for_io+0x35e/0x3a0
>> [<0>] btree_write_cache_pages+0x15a/0x3b0
>> [<0>] do_writepages+0x28/0xb0
>> [<0>] __writeback_single_inode+0x54/0x5c0
>> [<0>] writeback_sb_inodes+0x1e8/0x510
>> [<0>] wb_writeback+0xcc/0x440
>> [<0>] wb_workfn+0xd7/0x650
>> [<0>] process_one_work+0x236/0x560
>> [<0>] worker_thread+0x55/0x3c0
>> [<0>] kthread+0x13a/0x150
>> [<0>] ret_from_fork+0x1f/0x30
>>
>> This is because we got an error while cow'ing a block, specifically here
>>
>>          if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
>>                  ret = btrfs_reloc_cow_block(trans, root, buf, cow);
>>                  if (ret) {
>>                          btrfs_abort_transaction(trans, ret);
>>                          return ret;
>>                  }
>>          }
>>
>> The problem here is that as soon as we allocate the new block it is
>> locked and marked dirty in the btree inode.  This means that we could
>> attempt to writeback this block and need to lock the extent buffer.
>> However we're not unlocking it here and thus we deadlock.
>>
>> Fix this by unlocking the cow block if we have any errors inside of
>> __btrfs_cow_block, and also free it so we do not leak it.
>>
>> Fixes: 65b51a009e29 ("btrfs_search_slot: reduce lock contention by cowing in two stages")
>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/ctree.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>> index a165093739c4..113da62dc17f 100644
>> --- a/fs/btrfs/ctree.c
>> +++ b/fs/btrfs/ctree.c
>> @@ -1064,6 +1064,8 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
>>
>>          ret = update_ref_for_cow(trans, root, buf, cow, &last_ref);
>>          if (ret) {
>> +               btrfs_tree_unlock(cow);
>> +               free_extent_buffer(cow);
>>                  btrfs_abort_transaction(trans, ret);
>>                  return ret;
>>          }
>> @@ -1071,6 +1073,8 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
>>          if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state)) {
>>                  ret = btrfs_reloc_cow_block(trans, root, buf, cow);
>>                  if (ret) {
>> +                       btrfs_tree_unlock(cow);
>> +                       free_extent_buffer(cow);
>>                          btrfs_abort_transaction(trans, ret);
>>                          return ret;
>>                  }
>> @@ -1103,6 +1107,8 @@ static noinline int __btrfs_cow_block(struct btrfs_trans_handle *trans,
>>                  if (last_ref) {
>>                          ret = tree_mod_log_free_eb(buf);
>>                          if (ret) {
>> +                               btrfs_tree_unlock(cow);
>> +                               free_extent_buffer(cow);
> 
> The tree here already has a node pointing to the new buffer ("cow"),
> so we shouldn't call free_extent_buffer() against it.
> For all the previous places it's fine.
> 

We still need to drop our ref for it, just because the tree is pointing to it 
doesn't mean we hold the ref for it forever.  Thanks,

Josef

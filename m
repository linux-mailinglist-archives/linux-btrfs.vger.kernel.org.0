Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AF728FA16
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Oct 2020 22:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbgJOU0W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Oct 2020 16:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732254AbgJOU0V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Oct 2020 16:26:21 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11629C061755
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Oct 2020 13:26:20 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y16so6233471ila.7
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Oct 2020 13:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jLR9Rvs3aeHVyWIzhI/hTGFxLOA4ehYS5ZT9VP2YxFg=;
        b=wjTV3VQSavTnlV1Eb7tGPJTZM3qe4xPcWWH+M9lqnK0g6x5B7BVNw9t9Zfk44jWIQi
         pNOzrug9GbixxO4KmXUxKKWORnL/ejpYDIE5zYG7oqz7tpGkd6d0lvLNhm5J+7FFZRwY
         K/3B+mo0JeEgKD7+8nHQOxUu7m86FbB7VgSwhpLtdZpv5pyYVJvyJCnJ2pjsTTDqpiir
         pJENQJ8FgTDMp9VYzmqUX5cq99rtCVe5hugHwin5EZmVvm7DEYtqUPjcFBlJvLCEwQNl
         /GtKps+Xxx3CSSZjEVpUWvsltmryDIFzfXObuZPrknIz6B1Zy8lpORl4LytM+Vos/rPm
         bl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jLR9Rvs3aeHVyWIzhI/hTGFxLOA4ehYS5ZT9VP2YxFg=;
        b=tJxsWVAc5BKOhmvrMJIAfwQW3fUJc23IJ6wR2G+2tIZ0dEv7OA5rypdMxtxtfAgayy
         iJIPLuBY1Q+J/aDBUd7l5oMW5KIYy/8Pb9Urivc0EDiT96dV/CGsuUlRD7TYoY0RkGb1
         vNmVqB4MSFK2j7BCDHTpmjQRUTAoAsp0lOEQh4hV/xTVOL1dTWaGj6efRVFX3ABGboJu
         9V8jsUn10jnBn2LlpFTc1miF63GhCD8EpWIsFcbZSMFONIWL8/4olkvSeVx+UtyypCRk
         hQtIl6Nq9TEf178RaPENqT0ljMFkyxS4vaeXKG2IyuONB+bqqkR0BR8CJBtPH1NWEmsG
         JObQ==
X-Gm-Message-State: AOAM532zK0Rv/XNNw3omfrWTWpSU7ySzqjf3bPKQrc42POEhTyWHaoGT
        IuzkGJhIeIUFDW2Mnre3gJF9ONuaZKcTZQ==
X-Google-Smtp-Source: ABdhPJwo6T6eLQYiI/f4aKjJ73qgj1SQEqLFP5s9KbaKqWFBqzzMnxp9RBwuyNbF8aV3cymJaYqtbQ==
X-Received: by 2002:a05:6e02:808:: with SMTP id u8mr276977ilm.214.1602793579167;
        Thu, 15 Oct 2020 13:26:19 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d1::117c? ([2620:10d:c091:480::1:982e])
        by smtp.gmail.com with ESMTPSA id l7sm65446ili.82.2020.10.15.13.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 13:26:18 -0700 (PDT)
Subject: Re: [PATCH 2/6] btrfs: only let one thread pre-flush delayed refs in
 commit
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1602786206.git.josef@toxicpanda.com>
 <10113ed0453832382bc350f15758f871db43b5d9.1602786206.git.josef@toxicpanda.com>
 <e68e524c-8e51-5381-79b9-bd7fd30a13aa@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <93459148-83d6-e5b6-f819-811833158750@toxicpanda.com>
Date:   Thu, 15 Oct 2020 16:26:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <e68e524c-8e51-5381-79b9-bd7fd30a13aa@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/15/20 3:35 PM, Nikolay Borisov wrote:
> 
> 
> On 15.10.20 г. 21:25 ч., Josef Bacik wrote:
>> I've been running a stress test that runs 20 workers in their own
>> subvolume, which are running an fsstress instance with 4 threads per
>> worker, which is 80 total fsstress threads.  In addition to this I'm
>> running balance in the background as well as creating and deleting
>> snapshots.  This test takes around 12 hours to run normally, going
>> slower and slower as the test goes on.
>>
>> The reason for this is because fsstress is running fsync sometimes, and
>> because we're messing with block groups we often fall through to
>> btrfs_commit_transaction, so will often have 20-30 threads all calling
>> btrfs_commit_transaction at the same time.
>>
>> These all get stuck contending on the extent tree while they try to run
>> delayed refs during the initial part of the commit.
>>
>> This is suboptimal, really because the extent tree is a single point of
>> failure we only want one thread acting on that tree at once to reduce
>> lock contention.  Fix this by making the flushing mechanism a bit
>> operation, to make it easy to use test_and_set_bit() in order to make
>> sure only one task does this initial flush.
>>
>> Once we're into the transaction commit we only have one thread doing
>> delayed ref running, it's just this initial pre-flush that is
>> problematic.  With this patch my stress test takes around 90 minutes to
>> run, instead of 12 hours.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/delayed-ref.h | 12 ++++++------
>>   fs/btrfs/transaction.c | 32 ++++++++++++++++----------------
>>   2 files changed, 22 insertions(+), 22 deletions(-)
>>
>> diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
>> index 1c977e6d45dc..6e414785b56f 100644
>> --- a/fs/btrfs/delayed-ref.h
>> +++ b/fs/btrfs/delayed-ref.h
>> @@ -135,6 +135,11 @@ struct btrfs_delayed_data_ref {
>>   	u64 offset;
>>   };
>>   
>> +enum btrfs_delayed_ref_flags {
>> +	/* Used to indicate that we are flushing delayed refs for the commit. */
>> +	BTRFS_DELAYED_REFS_FLUSHING,
>> +};
>> +
>>   struct btrfs_delayed_ref_root {
>>   	/* head ref rbtree */
>>   	struct rb_root_cached href_root;
>> @@ -158,12 +163,7 @@ struct btrfs_delayed_ref_root {
>>   
>>   	u64 pending_csums;
>>   
>> -	/*
>> -	 * set when the tree is flushing before a transaction commit,
>> -	 * used by the throttling code to decide if new updates need
>> -	 * to be run right away
>> -	 */
>> -	int flushing;
>> +	unsigned long flags;
>>   
>>   	u64 run_delayed_start;
>>   
>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>> index 52ada47aff50..e8e706def41c 100644
>> --- a/fs/btrfs/transaction.c
>> +++ b/fs/btrfs/transaction.c
>> @@ -872,7 +872,8 @@ int btrfs_should_end_transaction(struct btrfs_trans_handle *trans)
>>   
>>   	smp_mb();
> 
> Is this memory barrier required now that you have removed the one in
> btrfs_commit_transaction ?
> 

I had it in my head that we needed it for ->state too, but we don't, I'll fix 
that up.  Thanks,

Josef

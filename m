Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6173A6E37
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jun 2021 20:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbhFNSaD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Jun 2021 14:30:03 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:35624 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbhFNSaC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Jun 2021 14:30:02 -0400
Received: by mail-qk1-f179.google.com with SMTP id g19so6607694qkk.2
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Jun 2021 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vWVm9h97jgh8oflc7Ozw1eQyqZgIV4dqogmVnibPWDU=;
        b=FH59FZYapr73holjF51Rf3cSZ65iF8XzEfGZz40PjZIRs/FTsUaoSfZuH4N3QXerco
         ysr7HtpnONE6Lz4xSuaJxmAHlT+2+E5kBX6NFPXd6onkmzlreVuLsSPVNaIySe7ng3Tz
         Wi5sLaCLDXMNDhxAslzIRhPm6uHM7ykpWQjp4BljSb/SZgz7thrTE4ILHiVSHyORM7oX
         SXQylDvMmAKjgyQdHWTEJdMSwAcXhEqIiiHDnOGRlTauphiM2WYfBDcUBtug/szQpmE0
         CR3aWuAP+Ut3dusLhNJCBxoOuI3L90e1HfI8kxuG3LXQU9p97mr3G1Zr37SVMaU/uWTe
         Qojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vWVm9h97jgh8oflc7Ozw1eQyqZgIV4dqogmVnibPWDU=;
        b=TOX6xbfcZDozWOK6acRmlkSFclTii+C8mKeE4Dpfd+yfIqvqOhu9g3DqhQHpGLVdko
         OwBpOG9rwcIe5tUh3QfsN4nhNXPXkELwMpzN97slFtcESATuTCFX0Mp8ii/DXN9mqWFD
         2HkG/rCQi0Q9lB+b8t5Fz46jTtRVyifFQcuiv/LJmh5fGiTkXy1q5AiLS6INY3EggifC
         1UC2mLsFhLuXtqdHazpV1B4DUk0cap2G8wwePoc9Do/PM0rC8zshDCKZWyVOkyMFrntA
         xOgSemtLEs7OLjojbqFo3XlCMJwLM8spfubOpn71vNzUXmFP876J9bf8lxqTPhlGxHxf
         AtCg==
X-Gm-Message-State: AOAM530Yd4OT0iqu/S9bPOFGPgm/5KXqrDJPVXAoSTfD0HNypkRrcNQk
        yGp//4KpuxZd7K3yHEmBj2HbmD89YkeVUA==
X-Google-Smtp-Source: ABdhPJyPyOIFyFQ+gh/o3WxHXf0pPpJX7B3efXXMe4k2egoyvqTPHoHDDiEtgsfhow44M0ZKBS8AhQ==
X-Received: by 2002:a37:b7c1:: with SMTP id h184mr17666025qkf.65.1623695219113;
        Mon, 14 Jun 2021 11:26:59 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1287? ([2620:10d:c091:480::1:a94c])
        by smtp.gmail.com with ESMTPSA id i3sm3886619qtm.48.2021.06.14.11.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 11:26:58 -0700 (PDT)
Subject: Re: [PATCH 1/3] btrfs: rip out may_commit_transaction
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1623421213.git.josef@toxicpanda.com>
 <65fd69e8e230d0d61e70ebade4d6cfe355d3b436.1623421213.git.josef@toxicpanda.com>
 <722a8ca7-08c6-e949-c314-04819eeca779@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <77931a14-3937-0de4-149c-c6ce5a0b6bef@toxicpanda.com>
Date:   Mon, 14 Jun 2021 14:26:56 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <722a8ca7-08c6-e949-c314-04819eeca779@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/14/21 8:17 AM, Nikolay Borisov wrote:
> 
> 
> On 11.06.21 г. 17:23, Josef Bacik wrote:
>> may_commit_transaction was introduced before the ticketing
>> infrastructure existed.  There was a problem where we'd legitimately be
>> out of space, but every reservation would trigger a transaction commit
>> and then fail.  Thus if you had 1000 things trying to make a
>> reservation, they'd all do the flushing loop and thus commit the
>> transaction 1000 times before they'd get their ENOSPC.
>>
>> This helper was introduced to short circuit this, if there wasn't space
>> that could be reclaimed by committing the transaction then simply ENOSPC
>> out.  This made true ENOSPC tests much faster as we didn't waste a bunch
>> of time.
>>
>> However many of our bugs over the years have been from cases where we
>> didn't account for some space that would be reclaimed by committing a
>> transaction.  The delayed refs rsv space, delayed rsv, many pinned bytes
>> miscalculations, etc.  And in the meantime the original problem has been
>> solved with ticketing.  We no longer will commit the transaction 1000
>> times.  Instead we'll get 1000 waiters, we will go through the flushing
>> mechanisms, and if there's no progress after 2 loops we ENOSPC everybody
>> out.  The ticketing infrastructure gives us a deterministic way to see
>> if we're making progress or not, thus we avoid a lot of extra work.
>>
>> So simplify this step by simply unconditionally committing the
>> transaction.  This removes what is arguably our most common source of
>> early ENOSPC bugs and will allow us to drastically simplify many of the
>> things we track because we simply won't need them with this stuff gone.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/ctree.h             |   1 -
>>   fs/btrfs/space-info.c        | 155 +++--------------------------------
>>   include/trace/events/btrfs.h |   3 +-
>>   3 files changed, 14 insertions(+), 145 deletions(-)
>>
> <snip>
> 
>> @@ -1238,31 +1128,12 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
>>    *   If we are freeing inodes, we want to make sure all delayed iputs have
>>    *   completed, because they could have been on an inode with i_nlink == 0, and
>>    *   thus have been truncated and freed up space.  But again this space is not
>> - *   immediately re-usable, it comes in the form of a delayed ref, which must be
>> - *   run and then the transaction must be committed.
>> - *
>> - * FLUSH_DELAYED_REFS
>> - *   The above two cases generate delayed refs that will affect
>> - *   ->total_bytes_pinned.  However this counter can be inconsistent with
>> - *   reality if there are outstanding delayed refs.  This is because we adjust
>> - *   the counter based solely on the current set of delayed refs and disregard
>> - *   any on-disk state which might include more refs.  So for example, if we
>> - *   have an extent with 2 references, but we only drop 1, we'll see that there
>> - *   is a negative delayed ref count for the extent and assume that the space
>> - *   will be freed, and thus increase ->total_bytes_pinned.
>> - *
>> - *   Running the delayed refs gives us the actual real view of what will be
>> - *   freed at the transaction commit time.  This stage will not actually free
>> - *   space for us, it just makes sure that may_commit_transaction() has all of
>> - *   the information it needs to make the right decision.
>> + *   immediately re-usable, it will be pinned, which will be reclaimed by
>> + *   committing the transaction.
> 
> So you remove the explanation about FLUSH_DELAYED_REFS, yet it's
> retained as a distinct state in data flush. So perhaps it should also be
> removed from data_flush_state, given that transaction commit, by
> definition, runs delayed refs so we don't need it as a discrete step
> during data flush ? If I'm wrong then this state requires an updated
> rationale.
> 

Oops forgot to pull the flush_delayed_refs thing from the list, I'll put that in 
a separate patch.  Thanks,

Josef

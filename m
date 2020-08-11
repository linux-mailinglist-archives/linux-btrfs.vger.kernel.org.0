Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5DF241C57
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 16:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgHKO1u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 10:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgHKO1u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 10:27:50 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42674C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 07:27:50 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t6so6029382qvw.1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hRwKjDZLgG8LDoeC/Od5/Vd2amtyZrXxLX8rGLH2LrM=;
        b=Tce4nryLT7RalMWl3CCD7KI+U+SeUa9lV5bBuY8BB6WfYrrxpHnGvgeTsoNs1+GOIX
         8QOr8XZyWVO2h8WBXPI8NiIETqCSO+2b1Y3dnD54+aW1KP+ohm0xWcmIHd761xyTq1R6
         7EiAidLT4Tn9cMvpNirPZnDW7E4ZlGdp4lw+IKUsICU7kWkM2x4JTU7u1RLwSRNdAAqe
         HsM3gWMBZJqqYoFwtvtxVgs4jEoHknVIDi3QU4PktkuxrHbam4KQgiKkhvYzgUA71GSm
         rugOx9UtQgryBnJGbSXkPl69yaTs9znt9dw8NmiftyeouFzSETH0uzgL4fKXM+LtKyQ2
         6aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hRwKjDZLgG8LDoeC/Od5/Vd2amtyZrXxLX8rGLH2LrM=;
        b=qmqS3uK/hzOAQ7ChOq/LuPLKxnjwX5e54KW7uR3vp5ATXhxeG2sWtLL8hNf+hTPnkN
         IQaLr0y5dJU8AqFJ5IMMf6A1k6vtTP+vfzJZ+Vk2qmCx4Zp2BKFoQBmfsxM1WpNkvp5l
         hSBYHjvykedPv9B3iJc5QfCJvK0slDwPkgwdzEjl6wrs9u5WjnNgrftQWUtPKDpFTA0n
         +aHPYDDjgx2Sm/lsTYoq/pO51MS+jk/a6wsxk+l5q3nj1gyLJL7fsx/QTQqrIOyNklFU
         pmZ0sqzEsJ1c/fKsA61Wptl0uW7U2I2c5qA8oP1pFKmxBftTl+845DCEFjqmGqQSwLob
         5o6g==
X-Gm-Message-State: AOAM530bmDTpFDCaUPZSPmXlAJoSS/hs7/HNu8uHCMM5mJZ932AePOsY
        IAGxHXI2ne+wBqdg4oOgyS42WoUk1PW5Eg==
X-Google-Smtp-Source: ABdhPJzZPN/xKB1LgMxJX5s8RYAnXMGF5hgeMNM8GZcKwal32uSxRGGZh1lPVtiys1jZ/KEadaZefQ==
X-Received: by 2002:a0c:d44e:: with SMTP id r14mr1528787qvh.105.1597156069249;
        Tue, 11 Aug 2020 07:27:49 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b131sm17950221qkc.121.2020.08.11.07.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 07:27:48 -0700 (PDT)
Subject: Re: [PATCH] btrfs: check the right variable in
 btrfs_del_dir_entries_in_log
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
References: <20200810213116.795789-1-josef@toxicpanda.com>
 <CAL3q7H4T-orhnnJrNxNqTXOXHm8c0jnqRf3GX3LuOV+9ZXjD4w@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <dad7d1e7-0e1a-412f-9ec1-7ab188ea38aa@toxicpanda.com>
Date:   Tue, 11 Aug 2020 10:27:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4T-orhnnJrNxNqTXOXHm8c0jnqRf3GX3LuOV+9ZXjD4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/11/20 6:14 AM, Filipe Manana wrote:
> On Mon, Aug 10, 2020 at 10:32 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> With my new locking code dbench is so much faster that I tripped over a
>> transaction abort from ENOSPC.  This turned out to be because
>> btrfs_del_dir_entries_in_log was checking for ret == -ENOSPC, but this
>> function sets err on error, and returns err.  So instead of properly
>> marking the inode as needing a full commit, we were returning -ENOSPC
>> and aborting in __btrfs_unlink_inode.  Fix this by checking the proper
>> variable so that we return the correct thing in the case of ENOSPC.
>>
>> Fixes: 4a500fd178c8 ("Btrfs: Metadata ENOSPC handling for tree log")
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/tree-log.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
>> index e0ab3c906119..bc9ed31502ec 100644
>> --- a/fs/btrfs/tree-log.c
>> +++ b/fs/btrfs/tree-log.c
>> @@ -3449,11 +3449,11 @@ int btrfs_del_dir_entries_in_log(struct btrfs_trans_handle *trans,
>>          btrfs_free_path(path);
>>   out_unlock:
>>          mutex_unlock(&dir->log_mutex);
>> -       if (ret == -ENOSPC) {
>> +       if (err == -ENOSPC) {
>>                  btrfs_set_log_full_commit(trans);
>> -               ret = 0;
>> -       } else if (ret < 0)
>> -               btrfs_abort_transaction(trans, ret);
>> +               err = 0;
>> +       } else if (err < 0 && err != -ENOENT)
> 
> Why the check for ENOENT?
> If any of the directory index items doesn't exist, the respective
> functions return a NULL btrfs_dir_item pointer and we do nothing and
> return 0.
> I'm not seeing anything else that could return ENOENT either.
> 
> Other than that it looks good.

I missed this too until I tested it and things went wrong.  It's because 
btrfs_lookup_dir_item() can return -ENOENT if the dir item isn't in the tree log 
(which would happen if we hadn't fsync'ed this guy).  We actually handle that 
case in __btrfs_unlink_inode, so it's an expected error to get back.  Thanks,

Josef

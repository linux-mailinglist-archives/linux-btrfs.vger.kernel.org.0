Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF3C419D8B
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 19:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhI0RyE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 13:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbhI0Rx7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 13:53:59 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADEEC061714
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 10:52:21 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id a13so11679693qvo.9
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 10:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xDstKhbwOzNVWD585CPPnkFrTwI/GqAGZnWJfclHzoQ=;
        b=yQjugjR12wp+fPTM3b5hyZD0qjIFpUGc9oB1nfevhKm01lRrM2nUzUcFznSzfDWOI2
         x8i+iaZkSAewFfKMPUfIeMQR9YV3LKOTcXUWxdN7AmAvvxDrBdDqhpf0hPMr2lJKAGOM
         i4OGbrIHpyagJv4nGwR0B4dxSjzFicKVKK3Qx9ozkpHr82AD2i1rljeGYkfITg78V99W
         AwPHqS2y/8sq+8klgY09HsP99Y2+6yZX+Jp12hMJyH8R5Y1Ov9W/RmiafIRu5h6mqz8C
         nnVbHzIluKW7vT99MdenLpIMs6eSmZ6tTnsGGZ6gNMMZChDF/gB+gu9pK0VfYGf3WpsZ
         XtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xDstKhbwOzNVWD585CPPnkFrTwI/GqAGZnWJfclHzoQ=;
        b=xYR2fC4dsmo7fG0KbJy7zde63ZakToLOluqAufD6RTenuyZ1ZSsci3bYJP2/w2Q2yr
         wbMOoNshuU0KlryjeyVSl5hhkSirp1Vt0oyFPxWwLSAV4u6VIhJiWnDD4LvxPKueFRw3
         +KqvTICcEzip/bcsDeVF9kY4Y2uA+jnEpnb4L7RBYA2tPX5YfhCswDpzWZpRxpSr34ih
         wIelaPMEBtI0/sScPAn16SlxNSnMR97nb0umPj4KmKhFsnB0X7XCkv+rt39O+pdXUKM3
         YY2ZiV+qq9eEUtL4LXTkIULnxuT5cKcfV2N/MiGQnSbfB97Nxi8vLxUrtTqLLbsnoV/w
         eooQ==
X-Gm-Message-State: AOAM531QC0Vg+s2f4e0k7ODcDJiOkpKAPIC2MoXOpyHKV7Lvet2+xzwb
        9Dt4p8oF9r1tYo3Q9SYL3yg4Rg==
X-Google-Smtp-Source: ABdhPJyPdYBHIqx5fFNmwaDyEVFNjNb+CcRwS+PHVQtHYNkK3v5+NjV1Q2IfPxgIlGvmi5NgGpiRjA==
X-Received: by 2002:a0c:ed31:: with SMTP id u17mr1294273qvq.40.1632765140151;
        Mon, 27 Sep 2021 10:52:20 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::1159? ([2620:10d:c091:480::1:ba44])
        by smtp.gmail.com with ESMTPSA id o15sm13043367qkk.129.2021.09.27.10.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 10:52:19 -0700 (PDT)
Subject: Re: [PATCH 2/3] btrfs: add a btrfs_has_fs_error helper
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1621523846.git.josef@toxicpanda.com>
 <a4bc9de04778cf6aa038f5164d01cf467de32ed5.1621523846.git.josef@toxicpanda.com>
 <20210525153414.GA7604@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <58051805-d45d-bcae-9178-f7f4f3995a30@toxicpanda.com>
Date:   Mon, 27 Sep 2021 13:52:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210525153414.GA7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/25/21 11:34 AM, David Sterba wrote:
> On Thu, May 20, 2021 at 11:21:32AM -0400, Josef Bacik wrote:
>> We have a few flags that are inconsistently used to describe the fs in
>> different states of failure.  As of
>>
>> 	btrfs: always abort the transaction if we abort a trans handle
>>
>> we will always set BTRFS_FS_STATE_ERROR if we abort, so we don't have to
>> check both ABORTED and ERROR to see if things have gone wrong.  Add a
>> helper to check BTRFS_FS_STATE_HELPER and then convert all checkers of
>> FS_STATE_ERROR to use the helper.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/ctree.h       |  5 +++++
>>   fs/btrfs/disk-io.c     |  8 +++-----
>>   fs/btrfs/extent_io.c   |  2 +-
>>   fs/btrfs/file.c        |  2 +-
>>   fs/btrfs/inode.c       |  6 +++---
>>   fs/btrfs/scrub.c       |  2 +-
>>   fs/btrfs/super.c       |  2 +-
>>   fs/btrfs/transaction.c | 11 +++++------
>>   fs/btrfs/tree-log.c    |  2 +-
>>   9 files changed, 21 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 938d8ebf4cf3..3c22c3308667 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -3531,6 +3531,11 @@ do {								\
>>   			  (errno), fmt, ##args);		\
>>   } while (0)
>>   
>> +static inline bool btrfs_has_fs_error(struct btrfs_fs_info *fs_info)
>> +{
>> +	return test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state);
> 
> This could also get the unlikely() annotattion, similar to what
> TRANS_ABORTED does. Which means this inline would have to be a macro eg.
> FS_ERROR or similar.
> 
> 

Yup I'll do that.

>> @@ -4372,8 +4371,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
>>   			btrfs_err(fs_info, "commit super ret %d", ret);
>>   	}
>>   
>> -	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state) ||
>> -	    test_bit(BTRFS_FS_STATE_TRANS_ABORTED, &fs_info->fs_state))
>> +	if (btrfs_has_fs_error(fs_info))
>>   		btrfs_error_commit_super(fs_info);
> 
> This is not equivalent change, previously it also checks for
> STATE_TRANS_ABORTED, this was added in af7227338135 ("Btrfs: clean up
> resources during umount after trans is aborted") . So it should be kept
> in place or there may be a bigger problem when the filesystem and
> transaction error bits get out of sync, I haven't checked.
> 

We had this because sometimes an empty transaction would be aborted and we 
wouldn't set FS_STATE_ERROR.  With the patch

   btrfs: always abort the transaction if we abort a trans handle

we no longer have the case where we have TRANS_ABORTED but not FS_STATE_ERROR 
set.  Now TRANS_ABORTED simply keeps us from printing multiple transaction abort 
messages, while FS_STATE_ERROR tells us there's been a problem.  Thanks,

Josef

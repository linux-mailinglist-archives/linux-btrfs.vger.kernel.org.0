Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED39119178
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 21:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbfLJUFc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 15:05:32 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46445 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfLJUFc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 15:05:32 -0500
Received: by mail-qt1-f196.google.com with SMTP id 38so3926596qtb.13
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2019 12:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=w3hcQIixNJoanH48JscfQYinvbyEIfHOY0XASRkBE/Y=;
        b=dJOuphUILqibUHrAj9o3Jz6IIgh/3s+qbPKd9uePJZfY+j9tyGsqcJPVGQRNrDzvgN
         2mVaZZh0p8SLLHInEf7Obmj6J9KH0QEHNL/y8J4zJIMbCL3Kk2BGUF9j7Mbm48NK+LXx
         R1UXtpbN+8oi1Xoz83CBzrBxFGsWIHh2EU2woZkDyJnjnLTQuRmKRD4A4weFYFoOie5k
         VMvHUEKB/EzT/0ctC98jQlk4ARCJXxR4xhRc8DFAED9NNzgLX/15vw6isIIjUovYcH4B
         +Kl03919+YulaSWWeLXUtYpgqChGuI0LNrhIrziUwhC8YY2VO1eqnLC9UMQj53GUe8Ye
         ioUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w3hcQIixNJoanH48JscfQYinvbyEIfHOY0XASRkBE/Y=;
        b=U+caX+/HKToNOEADavvt0WKaNsnbDLu17QCPu61/VNWkpLjZLg3tanXhxsWjIpU410
         V4tKZippzKyuLQRQGZW8B9W/emJSdVMViybniUrRulqWLlJtEgBpIyNXF8It/8NKdwpG
         polEqCm772h0kJaysTyEpa8+eKj3HPri7x4U6AUoYZQ+VocV/ouzZsjCGDAHy+fmfi6d
         AnwQ/QbAMSB5j5CDj3L5JsrjGJIZXGaXzLc5UvupBKAt+PeQPszpTjZIFKpyI7Z6PubD
         +QcId7Wz3+jVCim/bcmH5H20jL5e4wbgGvrtG74nK52wQMF2+A0BQhA9rXOdWzk5/Uv+
         8nCg==
X-Gm-Message-State: APjAAAXl8k3Um+NKDrvK1B6lmxRqe2K1N9Tp7mnNkLm23jHqZqNgmRGZ
        uN5W15IrvnNDGFJFa7qF+QB6pQ==
X-Google-Smtp-Source: APXvYqxRBjCPFDyvRGCO+QzJCPlKVa+pyQdtIt/x/bDUkl7mGJJO82U01xt3WCsEZcrKA+9xSLA68A==
X-Received: by 2002:ac8:641:: with SMTP id e1mr32040916qth.319.1576008331334;
        Tue, 10 Dec 2019 12:05:31 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u52sm204128qta.23.2019.12.10.12.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:05:30 -0800 (PST)
Subject: Re: [PATCH 1/5] btrfs: drop log root for dropped roots
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20191206143718.167998-1-josef@toxicpanda.com>
 <20191206143718.167998-2-josef@toxicpanda.com>
 <5e60e26f-8993-ca16-2a93-48d5948ed961@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <802950f7-b762-920b-7747-cfc18ff64e24@toxicpanda.com>
Date:   Tue, 10 Dec 2019 15:05:29 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <5e60e26f-8993-ca16-2a93-48d5948ed961@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/6/19 10:03 AM, Nikolay Borisov wrote:
> 
> 
> On 6.12.19 г. 16:37 ч., Josef Bacik wrote:
>> If we fsync on a subvolume and create a log root for that volume, and
>> then later delete that subvolume we'll never clean up its log root.  Fix
>> this by making switch_commit_roots free the log for any dropped roots we
>> encounter.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/transaction.c | 22 ++++++++++++----------
>>   1 file changed, 12 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>> index cfc08ef9b876..55d8fd68775a 100644
>> --- a/fs/btrfs/transaction.c
>> +++ b/fs/btrfs/transaction.c
>> @@ -147,13 +147,14 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
>>   	}
>>   }
>>   
>> -static noinline void switch_commit_roots(struct btrfs_transaction *trans)
>> +static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
>>   {
>> +	struct btrfs_transaction *cur_trans = trans->transaction;
>>   	struct btrfs_fs_info *fs_info = trans->fs_info;
>>   	struct btrfs_root *root, *tmp;
>>   
>>   	down_write(&fs_info->commit_root_sem);
>> -	list_for_each_entry_safe(root, tmp, &trans->switch_commits,
>> +	list_for_each_entry_safe(root, tmp, &cur_trans->switch_commits,
>>   				 dirty_list) {
>>   		list_del_init(&root->dirty_list);
>>   		free_extent_buffer(root->commit_root);
>> @@ -165,16 +166,17 @@ static noinline void switch_commit_roots(struct btrfs_transaction *trans)
>>   	}
>>   
>>   	/* We can free old roots now. */
>> -	spin_lock(&trans->dropped_roots_lock);
>> -	while (!list_empty(&trans->dropped_roots)) {
>> -		root = list_first_entry(&trans->dropped_roots,
>> +	spin_lock(&cur_trans->dropped_roots_lock);
>> +	while (!list_empty(&cur_trans->dropped_roots)) {
>> +		root = list_first_entry(&cur_trans->dropped_roots,
>>   					struct btrfs_root, root_list);
>>   		list_del_init(&root->root_list);
>> -		spin_unlock(&trans->dropped_roots_lock);
>> +		spin_unlock(&cur_trans->dropped_roots_lock);
>> +		btrfs_free_log(trans, root);
> 
> THis patch should really have been this line and converting
> switch_commit_roots to taking a trans handle another patch. Otherwise
> this is lost in the mechanical refactoring.
> 

We need the trans handle to even call btrfs_free_log, we're just fixing it so 
the trans handle can be passed in, making its separate is just superfluous.  Thanks,

Josef

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A25AB1196A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 22:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfLJV2W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 16:28:22 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42661 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfLJV2V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 16:28:21 -0500
Received: by mail-qk1-f195.google.com with SMTP id z14so7451444qkg.9
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2019 13:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/L/5QX//HRkjbAacrLv6IIOCp7rhs9szsOaUlKVylaE=;
        b=lfu/6RIHHo6DK8TOcu6QUqSqXKLmng/3v4iIYC8KYkViuR9c4EukLoTNdd82h5QJfl
         87iL9wsGPrcUavQ6cdyqEbp3y0Ll2Z8eb3t7+00fjmP5rSesa9f3hx8Rumj9Btm+IAAA
         T3aAf77rgkFTefcd3nq4t6+D8wbqC69WeH6zSrl+B7otadHu7aROUrZ8xxUbQX1YKUwz
         884exsenZYWsQDfLC7W1YmQvwJ2IhL/GXh5ti2KFA0I/SyikXrEYOeUm1GsbJWR5lK5m
         Rv1jKQ4R+4KnTJiFj9aIVwpEKqwipFA+KF4diQD8Z2/cgux7yB7+WJpHzP/i1BztPD77
         +9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/L/5QX//HRkjbAacrLv6IIOCp7rhs9szsOaUlKVylaE=;
        b=Mdy0+J/esAGYe6owm9E+VUG/BLrZOBtAcjuP/gYPA+8oTQg2GjBCL9R5yYGLQJeYpJ
         q901iuIc0aO6fTK0iFU7ipL37W+A+8vMRgzIWDkBiyR3Mtcg9ehPUhwC6wlU9nRFdXkV
         96WB2gwLwg+0ZZDlwkbxfJWwnP7dIa5fWVqYmzwV0jSMoIQPWE74MhkEgIFygvl8uE8h
         ECBk8DkclK8uVCg0ebDLiiaRmbdfeGUi6rMFZ1Btxs8mxUeifWZV67/YcxEXNTkNmjKn
         27700u2k/RFj7Sj+7CN7uK6RLbyeoMYZ0g0Ov0SGc5eVIgJy14Pz6sIQKu9qQwUu2hd4
         0dsw==
X-Gm-Message-State: APjAAAXJgEH4GGHSxfXQKk3JUG3CWKovuUyrjjsOmKNVn4+zyhPX6lEU
        Fremoc6fCNdJgeQMZTLd19BYvg==
X-Google-Smtp-Source: APXvYqyV8Q9y3HDbJwzL73veflEJODcxyXq5FOY1Vz9mwVgpoB0QlC+Gi9/TW0nxtIB+ZDWa0Mkyfg==
X-Received: by 2002:a37:6716:: with SMTP id b22mr14356960qkc.109.1576013299920;
        Tue, 10 Dec 2019 13:28:19 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d25sm3193qtm.67.2019.12.10.13.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 13:28:19 -0800 (PST)
Subject: Re: [PATCH 1/5] btrfs: drop log root for dropped roots
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20191206143718.167998-1-josef@toxicpanda.com>
 <20191206143718.167998-2-josef@toxicpanda.com>
 <5e60e26f-8993-ca16-2a93-48d5948ed961@suse.com>
 <802950f7-b762-920b-7747-cfc18ff64e24@toxicpanda.com>
 <85a03cbb-d096-bfaf-b841-141d63a4f134@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9392b4c1-4b7e-b5fb-dafe-0a1a45e0d319@toxicpanda.com>
Date:   Tue, 10 Dec 2019 16:28:17 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <85a03cbb-d096-bfaf-b841-141d63a4f134@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/10/19 4:19 PM, Nikolay Borisov wrote:
> 
> 
> On 10.12.19 г. 22:05 ч., Josef Bacik wrote:
>> On 12/6/19 10:03 AM, Nikolay Borisov wrote:
>>>
>>>
>>> On 6.12.19 г. 16:37 ч., Josef Bacik wrote:
>>>> If we fsync on a subvolume and create a log root for that volume, and
>>>> then later delete that subvolume we'll never clean up its log root.  Fix
>>>> this by making switch_commit_roots free the log for any dropped roots we
>>>> encounter.
>>>>
>>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>>> ---
>>>>    fs/btrfs/transaction.c | 22 ++++++++++++----------
>>>>    1 file changed, 12 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>>>> index cfc08ef9b876..55d8fd68775a 100644
>>>> --- a/fs/btrfs/transaction.c
>>>> +++ b/fs/btrfs/transaction.c
>>>> @@ -147,13 +147,14 @@ void btrfs_put_transaction(struct
>>>> btrfs_transaction *transaction)
>>>>        }
>>>>    }
>>>>    -static noinline void switch_commit_roots(struct btrfs_transaction
>>>> *trans)
>>>> +static noinline void switch_commit_roots(struct btrfs_trans_handle
>>>> *trans)
>>>>    {
>>>> +    struct btrfs_transaction *cur_trans = trans->transaction;
>>>>        struct btrfs_fs_info *fs_info = trans->fs_info;
>>>>        struct btrfs_root *root, *tmp;
>>>>          down_write(&fs_info->commit_root_sem);
>>>> -    list_for_each_entry_safe(root, tmp, &trans->switch_commits,
>>>> +    list_for_each_entry_safe(root, tmp, &cur_trans->switch_commits,
>>>>                     dirty_list) {
>>>>            list_del_init(&root->dirty_list);
>>>>            free_extent_buffer(root->commit_root);
>>>> @@ -165,16 +166,17 @@ static noinline void switch_commit_roots(struct
>>>> btrfs_transaction *trans)
>>>>        }
>>>>          /* We can free old roots now. */
>>>> -    spin_lock(&trans->dropped_roots_lock);
>>>> -    while (!list_empty(&trans->dropped_roots)) {
>>>> -        root = list_first_entry(&trans->dropped_roots,
>>>> +    spin_lock(&cur_trans->dropped_roots_lock);
>>>> +    while (!list_empty(&cur_trans->dropped_roots)) {
>>>> +        root = list_first_entry(&cur_trans->dropped_roots,
>>>>                        struct btrfs_root, root_list);
>>>>            list_del_init(&root->root_list);
>>>> -        spin_unlock(&trans->dropped_roots_lock);
>>>> +        spin_unlock(&cur_trans->dropped_roots_lock);
>>>> +        btrfs_free_log(trans, root);
>>>
>>> THis patch should really have been this line and converting
>>> switch_commit_roots to taking a trans handle another patch. Otherwise
>>> this is lost in the mechanical refactoring.
>>>
>>
>> We need the trans handle to even call btrfs_free_log, we're just fixing
>> it so the trans handle can be passed in, making its separate is just
>> superfluous.  Thanks,
> 
> Actually no because callees handle the case when trans is not passed
> (i.e. walk_log_tree and walk_(up|down)_log_tree. If passing valid
> trances changes the call logic then this needs to be explained in the
> changelog. And there is currently one caller calling that function
> without a trans - btrfs_drop_and_free_fs_root in BTRFS_FS_STATE_ERROR case.
> 

Yeah, it's clear that NULL is used only in the error case.  I'm not going to 
explain the entirety of how the log tree works in a basic fix for not freeing up 
a tree log when we should be doing it.  Thanks,

Josef

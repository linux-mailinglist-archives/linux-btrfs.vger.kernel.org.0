Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF4B11952C
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 22:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfLJVTX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 16:19:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:56158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728386AbfLJVTV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 16:19:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41CE5B172;
        Tue, 10 Dec 2019 21:19:20 +0000 (UTC)
Subject: Re: [PATCH 1/5] btrfs: drop log root for dropped roots
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <20191206143718.167998-1-josef@toxicpanda.com>
 <20191206143718.167998-2-josef@toxicpanda.com>
 <5e60e26f-8993-ca16-2a93-48d5948ed961@suse.com>
 <802950f7-b762-920b-7747-cfc18ff64e24@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <85a03cbb-d096-bfaf-b841-141d63a4f134@suse.com>
Date:   Tue, 10 Dec 2019 23:19:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <802950f7-b762-920b-7747-cfc18ff64e24@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.12.19 г. 22:05 ч., Josef Bacik wrote:
> On 12/6/19 10:03 AM, Nikolay Borisov wrote:
>>
>>
>> On 6.12.19 г. 16:37 ч., Josef Bacik wrote:
>>> If we fsync on a subvolume and create a log root for that volume, and
>>> then later delete that subvolume we'll never clean up its log root.  Fix
>>> this by making switch_commit_roots free the log for any dropped roots we
>>> encounter.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>>   fs/btrfs/transaction.c | 22 ++++++++++++----------
>>>   1 file changed, 12 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
>>> index cfc08ef9b876..55d8fd68775a 100644
>>> --- a/fs/btrfs/transaction.c
>>> +++ b/fs/btrfs/transaction.c
>>> @@ -147,13 +147,14 @@ void btrfs_put_transaction(struct
>>> btrfs_transaction *transaction)
>>>       }
>>>   }
>>>   -static noinline void switch_commit_roots(struct btrfs_transaction
>>> *trans)
>>> +static noinline void switch_commit_roots(struct btrfs_trans_handle
>>> *trans)
>>>   {
>>> +    struct btrfs_transaction *cur_trans = trans->transaction;
>>>       struct btrfs_fs_info *fs_info = trans->fs_info;
>>>       struct btrfs_root *root, *tmp;
>>>         down_write(&fs_info->commit_root_sem);
>>> -    list_for_each_entry_safe(root, tmp, &trans->switch_commits,
>>> +    list_for_each_entry_safe(root, tmp, &cur_trans->switch_commits,
>>>                    dirty_list) {
>>>           list_del_init(&root->dirty_list);
>>>           free_extent_buffer(root->commit_root);
>>> @@ -165,16 +166,17 @@ static noinline void switch_commit_roots(struct
>>> btrfs_transaction *trans)
>>>       }
>>>         /* We can free old roots now. */
>>> -    spin_lock(&trans->dropped_roots_lock);
>>> -    while (!list_empty(&trans->dropped_roots)) {
>>> -        root = list_first_entry(&trans->dropped_roots,
>>> +    spin_lock(&cur_trans->dropped_roots_lock);
>>> +    while (!list_empty(&cur_trans->dropped_roots)) {
>>> +        root = list_first_entry(&cur_trans->dropped_roots,
>>>                       struct btrfs_root, root_list);
>>>           list_del_init(&root->root_list);
>>> -        spin_unlock(&trans->dropped_roots_lock);
>>> +        spin_unlock(&cur_trans->dropped_roots_lock);
>>> +        btrfs_free_log(trans, root);
>>
>> THis patch should really have been this line and converting
>> switch_commit_roots to taking a trans handle another patch. Otherwise
>> this is lost in the mechanical refactoring.
>>
> 
> We need the trans handle to even call btrfs_free_log, we're just fixing
> it so the trans handle can be passed in, making its separate is just
> superfluous.  Thanks,

Actually no because callees handle the case when trans is not passed
(i.e. walk_log_tree and walk_(up|down)_log_tree. If passing valid
trances changes the call logic then this needs to be explained in the
changelog. And there is currently one caller calling that function
without a trans - btrfs_drop_and_free_fs_root in BTRFS_FS_STATE_ERROR case.

> 
> Josef

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BB3403964
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 14:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348853AbhIHMCt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 08:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349298AbhIHMCo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Sep 2021 08:02:44 -0400
X-Greylist: delayed 155606 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Sep 2021 05:01:36 PDT
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9CC061575
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 05:01:36 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 660C99B850; Wed,  8 Sep 2021 13:01:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1631102493;
        bh=fN19oJCM3efmGyxAtApJhe0LVE/Xe4JUIbWzDC+NLew=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=N9xj7luoORX29FysM9bwg4BCMXeBCbKv9RVLpCGQPiONJvKUe7IOjRkHBY1dh08QK
         DR9gGJTQZgfNwkvQMGRAgagGqAigZ8/qWea9CcwbNFFNVE4EOkTEqqk3jU5KnP4O+T
         2ZFvu77nJNZrnF9cavTwoHGfYtXx0kzNZyuW6fnpGXv7NHMTt0rY+OfhOza+ZCvnLG
         3Z6d4sPvEj5ywKUT3NURbclBm57tGElwzrqcrqSMmF0RkUgVFz5E2DRxKkkfTK3VVk
         Q+ceE+kBGEW752rI3vcpfO1pt0mYLs636HAvDWF1ZaSCj8D1ck+4m1orj1ecyu0gQv
         sqH5nI04tyd/w==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-6.8 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 944399B6C2;
        Wed,  8 Sep 2021 13:01:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1631102469;
        bh=fN19oJCM3efmGyxAtApJhe0LVE/Xe4JUIbWzDC+NLew=;
        h=From:Subject:To:Cc:References:Date:In-Reply-To:From;
        b=OUInebBu+p9ab4zTHsFW1zbNAU1zDVcs529umxNVMhvYjoQq/A3wwdM3xl28+4pc9
         eaR6OiZaRNDrlremDQdhIxNmBulgrJUCLp9f6+ET6NSQPd9sl6w7vaX/rPZqvYkL0T
         vp8AcC4cxSV7c0gy0RSwbW4gTgC2yHqR0bvwEs8mXRtpC9otrwta6Dp9T3t6Km7Sqw
         crZmMsGlIFfibypq4k2dtXnjV5IwReAI9V3Y7KnWrZni3a9EAAGgeE7WsbbSM6rk0H
         kG3MQDr3G7YVGCY5LKFdK1xbwwp9L0nf1u2v2jg2U3RMA7c50r6dcA9up3gEnOR+Z2
         YO3MuXPmA/0WQ==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 2A19D294598;
        Wed,  8 Sep 2021 13:01:09 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: [RESEND PATCH] btrfs: Remove received information from snapshot
 on ro->rw switch
To:     fdmanana@gmail.com, Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20200403134436.9095-1-nborisov@suse.com>
 <CAL3q7H4jnds5wjX5hWB=T5x_zHkTBMSYCc2ePgVG0mW6vG5Y4g@mail.gmail.com>
Message-ID: <cf9b5224-2f0a-2302-7f5a-f8f8edc003c2@cobb.uk.net>
Date:   Wed, 8 Sep 2021 13:01:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H4jnds5wjX5hWB=T5x_zHkTBMSYCc2ePgVG0mW6vG5Y4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 08/09/2021 12:32, Filipe Manana wrote:
> On Fri, Apr 3, 2020 at 2:45 PM Nikolay Borisov <nborisov@suse.com> wrote:
>>
>> Currently when a read-only snapshot is received and subsequently its
>> ro property is set to false i.e. switched to rw-mode the
>> received_uuid/stime/rtime/stransid/rtransid of that subvol remains
>> intact. However, once the received volume is switched to RW mode we
>> cannot guaranteee that it contains the same data, so it makes sense
>> to remove those fields which indicate this volume was ever
>> send/received. Additionally, sending such volume can cause conflicts
>> due to the presence of received_uuid.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>> Suggested-by: David Sterba <dsterba@suse.cz>
>> ---
>>
>> I've been carrying this patch in my tree for around 2.5 years. It stems from
>> multiple reports on the mailing list about people changing the RO->RW mode on
>> a received snapshot and getting unexpected behavior. AFAIR this patch resolved
>> that.
> 
> I agree with it, and this sporadically causes problems that get
> reported on the list.
> I spent a bunch of time back and forth with a user that ran into a
> problem caused by switching snapshots from RO to RW.
> 
> So I would like to add the following paragraphs and Link tag to the changelog:
> 
> "
> Preserving the received_uuid (and related fields) after transitioning the
> snapshot from RO to RW and then changing the snapshot has a potential for
> causing send to fail in many unexpected ways if we later turn it back to
> RO and use it for an incremental send operation.
> 
> A recent example, in the thread to which the Link tag below points to, we
> had a user with a filesystem that had multiple snapshots with the same
> received_uuid but with different content due to a transition from RO to RW
> and then back to RO. 

Should btrfs-check be enhanced to detect subvolumes with duplicated
received_uuid? Presumably the repair would be to change all of them to
new UUIDs (or maybe keep the oldest one unchanged?).

Graham

When an incremental send was attempted using two of
> those snapshots, it resulted in send emitting a clone operation that was
> intended to clone from the parent root to the send root - however because
> both roots had the same received_uuid, the receiver ended up picking the
> send root as the source root for the clone operation, which happened to
> result in the clone operation to fail with -EINVAL, due to the source and
> destination offsets being the same (and on the same root and file). In this
> particular case there was no harm, but we could end up in a case where the
> clone operation succeeds but clones wrong data due to picking up an
> incorrect root - as in the case of multiple snapshots with the same
> received_uuid, it has no way to know which one is the correct one if they
> have different content.
> 
> Link: https://lore.kernel.org/linux-btrfs/CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com/
> "
> 
> 
> A few comments below as well.
> 
>>
>>
>>  fs/btrfs/ioctl.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 40b729dce91c..39840b654600 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1873,6 +1873,7 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
>>         struct btrfs_trans_handle *trans;
>>         u64 root_flags;
>>         u64 flags;
>> +       bool clear_received_state = false;
>>         int ret = 0;
>>
>>         if (!inode_owner_or_capable(inode))
>> @@ -1917,6 +1918,7 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
>>                         btrfs_set_root_flags(&root->root_item,
>>                                      root_flags & ~BTRFS_ROOT_SUBVOL_RDONLY);
>>                         spin_unlock(&root->root_item_lock);
>> +                       clear_received_state = true;
>>                 } else {
>>                         spin_unlock(&root->root_item_lock);
>>                         btrfs_warn(fs_info,
>> @@ -1933,6 +1935,31 @@ static noinline int btrfs_ioctl_subvol_setflags(struct file *file,
>>                 goto out_reset;
>>         }
>>
>> +       if (clear_received_state) {
>> +               if (!btrfs_is_empty_uuid(root->root_item.received_uuid)) {
> 
> This could be combined into a single if to reduce indentation:   if
> (clear_received_state && !btrfs_is_empty_uuid(...))
> 
> Also, there's here indentation weirdness due to using spaces instead
> of tabs, and checkpatch complains about it:
> 
> ERROR: code indent should use tabs where possible
> #80: FILE: fs/btrfs/ioctl.c:1996:
> +^I        if (!btrfs_is_empty_uuid(root->root_item.received_uuid)) {$
> 
> ERROR: code indent should use tabs where possible
> #83: FILE: fs/btrfs/ioctl.c:1999:
> +^I                ret = btrfs_uuid_tree_remove(trans,$
> 
> ERROR: code indent should use tabs where possible
> #84: FILE: fs/btrfs/ioctl.c:2000:
> +^I                                root->root_item.received_uuid,$
> (...)
> 
>> +                       struct btrfs_root_item *root_item = &root->root_item;
>> +
>> +                       ret = btrfs_uuid_tree_remove(trans,
>> +                                       root->root_item.received_uuid,
>> +                                       BTRFS_UUID_KEY_RECEIVED_SUBVOL,
>> +                                       root->root_key.objectid);
> 
> If we reach here, we should have reserved one additional metadata item
> when starting the transaction.
> And add a comment about what each item is used for - 1 for updating
> the root item in the root tree, another 1 for removing an item from
> the uuid tree.
> 
> Also, we can use root_item there instead of root->root_item.
> 
> Other than that, it looks fine to me.
> 
> Thanks.
> 
>> +
>> +                       if (ret && ret != -ENOENT) {
>> +                               btrfs_abort_transaction(trans, ret);
>> +                               btrfs_end_transaction(trans);
>> +                               goto out_reset;
>> +                       }
>> +
>> +                       memset(root_item->received_uuid, 0, BTRFS_UUID_SIZE);
>> +                       btrfs_set_root_stransid(root_item, 0);
>> +                       btrfs_set_root_rtransid(root_item, 0);
>> +                       btrfs_set_stack_timespec_sec(&root_item->stime, 0);
>> +                       btrfs_set_stack_timespec_nsec(&root_item->stime, 0);
>> +                       btrfs_set_stack_timespec_sec(&root_item->rtime, 0);
>> +                       btrfs_set_stack_timespec_nsec(&root_item->rtime, 0);
>> +               }
>> +       }
>> +
>>         ret = btrfs_update_root(trans, fs_info->tree_root,
>>                                 &root->root_key, &root->root_item);
>>         if (ret < 0) {
>> --
>> 2.17.1
>>
> 
> 


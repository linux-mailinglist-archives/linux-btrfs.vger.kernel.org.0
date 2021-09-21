Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF430413D64
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Sep 2021 00:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhIUWQA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 18:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbhIUWP7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 18:15:59 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671CAC061574
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Sep 2021 15:14:29 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 193F89B9CB; Tue, 21 Sep 2021 23:14:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1632262464;
        bh=bQejuG1QYVBtRLRNTE1zbJuQ3ziyAqp/rF5XILddukg=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=VnXW13rScq2OVqU5JtmxjkDLtZxNV+XG7uMIoDjZ4hXjSh5Pez0kH7BFlPXRSjubQ
         RtdD7PjRa/FEB5m3BM+VFgGXxXWiv3yp5dqVEkri2+LpfOiSP6rKZJ5xPlPGtrHgU+
         UEv0o924hDn5YrL6FQXnImjjygKr/CQm+3SXael1EfOqt/6cVz7PCfmThWul48k99c
         IvI44bJ9uVLBcidF1FGzifXGNurNnJwxvWibKBLfrN6q4OxyMWvMYKQACwWwHNidm+
         FEY1qyc5XgezsxD9Khuy6jNPlJwziS/ad6rdDo9V6VduN32AFHIZ2K04vtgp45w2kO
         klT7CKgxbFJdg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-4.9 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 75CC89B9CB;
        Tue, 21 Sep 2021 23:08:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1632262132;
        bh=bQejuG1QYVBtRLRNTE1zbJuQ3ziyAqp/rF5XILddukg=;
        h=From:To:References:Subject:Date:In-Reply-To:From;
        b=qKGUk3fk2pYzor3vhsl7esV5eo6RKJ9tK6DQDz8T0zAe4LmXbdGbkltV5FGzg/aBJ
         OqkRH2ftXUYqvQ33mpFY0VaKyjIiv9anqzap0pIiPuJ6rR0KBDkhGKjtuxghEdPO4e
         GB+EgylfcOSU9XrdZ0ABa+1F6ixfGpMYiOL8a5J1xgmYPUSId6G1IwfeLQFyeEF035
         ouLdt3qXDZh1MnDxVW/tIGyytWCAkN/hxzxDD2HOa0Eu3L+K3wg8PyVEJM/YkTvLbc
         IuWU5j8PYE5R+a98d5W5/Apu/6m6AGD1wpv9VJOC9tMITCM3g+Lblkd/iLU2Kjeq6M
         VXRuP7hok2Eaw==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 56E6F2A0511;
        Tue, 21 Sep 2021 23:08:52 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210914090558.79411-1-nborisov@suse.com>
 <20210921185124.GQ9286@twin.jikos.cz>
Subject: Re: [PATCH v2 0/8] Implement progs support for removing received uuid
 on RW vols
Message-ID: <3d22cf5f-672b-8129-ce68-2017070d5c01@cobb.uk.net>
Date:   Tue, 21 Sep 2021 23:08:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210921185124.GQ9286@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/09/2021 19:51, David Sterba wrote:
> On Tue, Sep 14, 2021 at 12:05:50PM +0300, Nikolay Borisov wrote:
>> Here's V2 which takes into account Qu's suggestions, namely:
>>
>> - Add a helper which contains the common code to clear receive-related data
>> - Now there is a single patch which impements the check/clear for both orig and
>> lowmem modes
>> - Added Reviewed-by from Qu.
>>
>>
>> Nikolay Borisov (8):
>>   btrfs-progs: Add btrfs_is_empty_uuid
>>   btrfs-progs: Remove root argument from btrfs_fixup_low_keys
>>   btrfs-progs: Remove fs_info argument from leaf_data_end
>>   btrfs-progs: Remove root argument from btrfs_truncate_item
>>   btrfs-progs: Add btrfs_uuid_tree_remove
>>   btrfs-progs: Implement helper to remove received information of RW
>>     subvol
>>   btrfs-progs: check: Implement removing received data for RW subvols
>>   btrfs-progs: tests: Add test for received information removal
> 
> Patches 2-5 added to devel as they're preparatory and otherwise OK as
> independent cleanups.
> 
> Regarding the rw and received_uuid, it's choosing between these options:
> 
> 1) ro->rw resets received_uuid unconditionally
> 
> Pros:
> - safe as it does not lead to unexpected results after incremental send
> 
> Cons:
> - unconditional, so it's too easy to break the incremental send usecase,
>   which is the main usecase, if that' for backups breaking the
>   continuity is IMNSHO serious usability problem -- and main reason why
>   I'm personally looking for other options
> 
> Issuing a warning when the ro status is changed by btrfs-progs is only
> partially fixing that as the raw ioctl or it's wrapper in libbtrfsutil
> will happily destroy the received_uuid. There's no log or other
> information that would make it possible to restore it.
> 
> Note that received_uuid can be set to any value using the
> BTRFS_IOC_SET_RECEIVED_SUBVOL ioctl, as long as the subvolume is
> writable.

How about...

Add a --force option.

ro->rw with received_uuid non-zero fails without --force, but displays a
message something like:

"Subvolume is a received subvolume (received_uuid
a0fd481e-ac7f-f14f-8bec-f09e3e096344). Setting the subvolume read-write
would remove the received_uuid and prevent the subvolume being
referenced in future btrfs receive operations. To avoid this, take a rw
snapshot of the subvolume instead of setting it rw. If you are happy to
clear the received_uuid, specify the --force option".

Don't bother to explain about the BTRFS_IOC_SET_RECEIVED_SUBVOL ioctl
but at least the received_uuid has been displayed if the user wants to
record it. Maybe even log it in a kernel message - I presume this will
be a fairly rare action.

> 
> 2) don't allow ro->rw if received_uuid is set, it must be cleared first
> 
> As mentioned above, the received_uuid can be changed or reset (setting
> all zeros), but there's still the condition that the subvolume must be
> writable.
> 
> After 'receive' the subvolume is snapshotted, updated from stream, set
> received_uuid and set rw->ro.
> 
> Reusing the SET_RECEIVED_SUBVOL can't be used as-is, the subvol would
> have to be rw first. Which is a chicken-egg problem.
> 
> The safe steps would be:
> 
> - (after receive, subvolume is RO)
> - set it to RW
> - clear received_uuid
> - either keep it RW or set RO again
> 
> This would be the single "clear received_uuid manually" and it would be
> up to the user to knowingly destroy the continuity of the incremental
> send.
> 
> The fix here is that the above steps would have to be atomic from user
> perspective, inside SET_RECEIVED_SUBVOL, eg. based on flag. And we'd
> have to add a btrfs-progs command somewhere.
> 


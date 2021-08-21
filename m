Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F3B3F3B19
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Aug 2021 16:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhHUO7L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Aug 2021 10:59:11 -0400
Received: from eu-shark2.inbox.eu ([195.216.236.82]:40350 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhHUO7L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Aug 2021 10:59:11 -0400
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 29BBB1E0069E;
        Sat, 21 Aug 2021 17:58:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1629557910; bh=oIZA21wV2tUy5ufxpd7VmolA6g/CrZDuhc3o3LUGyDs=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=CtQwJsXyUSDFt2jeayJGxQqNRMg25L9DylBPIKdtoWXWVv8HUsx7LWHA6Q56HpUmE
         cnlzoCZVzrXw77FcaOzb4WoU+IbrDA+OEQ34CaIS7of8Nc7azTUhwzqMOFtVbdI4LW
         O4BP6m3KH5KQGiWUfN53yrL4ctlEf/UwFm67O1t8=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 21AD81E00699;
        Sat, 21 Aug 2021 17:58:30 +0300 (EEST)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id JfXuHY2RxGM8; Sat, 21 Aug 2021 17:58:30 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id E3B341E00692;
        Sat, 21 Aug 2021 17:58:29 +0300 (EEST)
Received: from nas (unknown [49.65.73.48])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 6722C1BE009C;
        Sat, 21 Aug 2021 17:58:28 +0300 (EEST)
References: <cover.1629396187.git.anand.jain@oracle.com>
 <8b8e72c87d0ee97da1b2e243a24b68d84d0ac3b9.1629396187.git.anand.jain@oracle.com>
 <y28weeg4.fsf@damenly.su>
 <4b891418-b8d1-6e3f-ae71-b1dface98ae2@oracle.com>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH RFC 2/3] btrfs: consolidate device_list_mutex in
 prepare_sprout to its parent
Date:   Sat, 21 Aug 2021 22:57:44 +0800
In-reply-to: <4b891418-b8d1-6e3f-ae71-b1dface98ae2@oracle.com>
Message-ID: <sfz2etf4.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6NpmlYxOGzysiV+lRWe8dgs0s1MpUens5eG/zhpagn/yLV36cwhSEAzE7mEFM2A=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Fri 20 Aug 2021 at 16:53, Anand Jain <anand.jain@oracle.com> 
wrote:

>>> @@ -2366,6 +2366,8 @@ static int btrfs_prepare_sprout(struct
>>> btrfs_fs_info *fs_info)
>>>      u64 super_flags;
>>>
>>>      lockdep_assert_held(&uuid_mutex);
>>> +    lockdep_assert_held(&fs_devices->device_list_mutex);
>>> +
>>>
>> Just a reminder: clone_fs_devices() still takes the mutex in 
>> misc-next.
>    As I am checking clone_fs_devices() does not take any lock.
>   Could you pls recheck?
>

Hmmmm... misc-next:

https://github.com/kdave/btrfs-devel/blob/e05983195f31374ad51a0f3712efec381397f3cb/fs/btrfs/volumes.c#L381

--
Su
>
>>> @@ -2588,6 +2588,7 @@ int btrfs_init_new_device(struct 
>>> btrfs_fs_info
>>> *fs_info, const char *device_path
>>>      device->dev_stats_valid = 1;
>>>      set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
>>>
>>> +    mutex_lock(&fs_devices->device_list_mutex);
>>>      if (seeding_dev) {
>>>          btrfs_clear_sb_rdonly(sb);
>>>          ret = btrfs_prepare_sprout(fs_info);
>>>
>> the erorr case:
>> if (ret) {
>>     mutex_unlock(&fs_devices->device_list_mutex);
>>     ...
>> }
>
>   Right. I missed it will fix.
>
> Thanks.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7119E24D6C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Aug 2020 15:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgHUN7Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Aug 2020 09:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgHUN7X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Aug 2020 09:59:23 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0A2C061573
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 06:59:23 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id j187so1400328qke.11
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Aug 2020 06:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sw7LbWJB8mPYez36+okeMOYsjQ+y+KcO2l5WAt+IhtA=;
        b=kSy6m1FqRcsNkvW9G7J7kcF90NEMWfP7Bn+5LYbcUlPPwd6/ZZ2t95eRU4ZNh+EdmS
         Wik/LpootT7mGMLD5Lt2q4vp90cQst4xHGsFKwGC0Fl48yLVrlPVz+Fj5laMlVg+qVBQ
         VREorgCmFRAUYCTrlOCkmSHPaH+GqWn2UZMd1Ngcwc4Dj+xcD8RvgoN2AVj4A9Y80bFD
         uVbTbBwVNs4VNXODUAz5AI9HVWqfX6EtiVRwnWPsTkutBxT59WIxNN1F+tS50jJEX1sk
         xeGT1sft7ahzpwShqvl3+FfFhpyOTtHHiTbSNQ5tHZRukUU+A9aMFyT0EDU4Lk+2Jfi/
         kaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sw7LbWJB8mPYez36+okeMOYsjQ+y+KcO2l5WAt+IhtA=;
        b=J+Ke867tluSHsPS1HsZTNJHgkLdzoPcq3FrFLM3jcXAtswVNh8XC9I75dMd9ErTVMf
         6/X2CrpnCjMmgHSIN4q6gxNu0ulqS9XRMGebFpPFseitAmdf8/0lR4RM6n7tFbF+ihFU
         2F4BD6TD00vX13lw87zfZkS+JimnS3SckoSMG6WfLRSFXQfuZRolrxh5nYTGfLXuiSlr
         8YB+sxek51l49WBl17lbRLxsp/iUE1vtnWFXGAWDJ+R0OPTJOV4FChhaFcnsL1ZxzXrt
         i6q0EXtSvYrpR5B8OilyOXvNuEbO1tvSjwbll/ixbwM5mqNXqXbUP4X8AzOfKOxkKnGg
         wBTQ==
X-Gm-Message-State: AOAM530gv1Xu8eBgfvrbatnGJ6Oa2ix7So/LgpUWAhPAG8e4ylwjKla1
        oK0ZEN5CEFDE8T0l/Q0T9vBDYO5B0uH462GO
X-Google-Smtp-Source: ABdhPJzqxFlIxrnGDRuFHSQNSCVRjuTr7/D8fIkq0WhEZYbzk/Bgm7NFtdrquZ667sGngLeLqIdvAA==
X-Received: by 2002:a37:a44b:: with SMTP id n72mr2822725qke.448.1598018362206;
        Fri, 21 Aug 2020 06:59:22 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 128sm1788874qkk.101.2020.08.21.06.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 06:59:21 -0700 (PDT)
Subject: Re: [PATCH 1/2] btrfs: free fs roots on failed mount
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1597953516.git.josef@toxicpanda.com>
 <9c6e581e607954968d08179961bb20a62491a655.1597953516.git.josef@toxicpanda.com>
 <7bb2214b-5b1f-4e96-f2fd-4715ea5a6de6@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <410d3d2b-0b79-68ca-c3c1-a9ebd2ee1933@toxicpanda.com>
Date:   Fri, 21 Aug 2020 09:59:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7bb2214b-5b1f-4e96-f2fd-4715ea5a6de6@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/21/20 3:31 AM, Nikolay Borisov wrote:
> 
> 
> On 20.08.20 г. 23:00 ч., Josef Bacik wrote:
>> While testing a weird problem with -o degraded, I noticed I was getting
>> leaked root errors
>>
>> BTRFS warning (device loop0): writable mount is not allowed due to too many missing devices
>> BTRFS error (device loop0): open_ctree failed
>> BTRFS error (device loop0): leaked root -9-0 refcount 1
>>
>> This is the DATA_RELOC root, which gets read before the other fs roots,
>> but is included in the fs roots radix tree.  Handle this by adding a
>> btrfs_drop_and_free_fs_root() on the data reloc root if it exists.  This
>> is ok to do here if we fail further up because we will only drop the ref
>> if we delete the root from the radix tree, and all other cleanup won't
>> be duplicated.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/disk-io.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 814f8de395fe..ac6d6fddd5f4 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3418,6 +3418,8 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>>   	btrfs_put_block_group_cache(fs_info);
>>   
>>   fail_tree_roots:
>> +	if (fs_info->data_reloc_root)
>> +		btrfs_drop_and_free_fs_root(fs_info, fs_info->data_reloc_root);
> 
> But will this really free the root? So the newly allocated
> data_reloc_root has it's ref set to 1 from
> btrfs_get_root_ref->btrfs_read_tree_root->btrfs_alloc_root and to 2 from
> being added to the radix tree in btrfs_insert_fs_root().
> 
> But btrfs_drop_and_free_fs_root makes a single call to btrfs_put_root.
> So won't the reloc tree be left with a refcount of 1 ?

It's a global root, so it's final put happens in btrfs_free_fs_info(), 
we just need to drop the radix tree ref here.  Thanks,

Josef

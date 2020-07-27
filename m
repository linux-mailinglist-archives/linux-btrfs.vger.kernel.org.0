Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF81622F3F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 17:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgG0PhP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 11:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbgG0PhP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 11:37:15 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294DFC061794
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 08:37:15 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 2so11503122qkf.10
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=d/IpmXSPD9MOihmSHDRnsHxKSUajT0veLjOXoNkovIA=;
        b=ONd+cpcOdzcJ2xUflBsWAMOc+bq5y/7mMRe2dDKbJKRu6sdzJ4Fd10icmBkCz+ztED
         6uNEStcEC3APOI9WSMA2IOlOm6/1q1ckH9lnb498lNZ+gf1utudacU57WN4I8OGZbsx5
         PHdT5LLn1IiaDgXpM56uEwew8TRDCArcAorXM1J6O200ACMOA7ZqP3KJ6DkhWvuU0xa+
         GOvo5bMExydM+/6rAEqZ3W6NkZRVXyCfVRkI4CmNbESw4oVWGA6t0keYvhtSZPuIHJsa
         c13tI8cQ6X/rpYHhPkkhsY9nLCwThkmEZjjAwXQI+GUc/uMreLKrnMQ7QmHiwK2MO3+r
         cCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d/IpmXSPD9MOihmSHDRnsHxKSUajT0veLjOXoNkovIA=;
        b=NoEQRZ7yf4h0g/+T+Hc+lrRadALdKSfN3a2dIv1LcN+tKt7Vo8Pi5S1tBHMU4pw16h
         7HUTckcqpuMq8E1Ii77efafUqwo3i+24O5SSOIvyRMQkGh6tKKe3RBI4Cp9ml0Ij/9/N
         vjtwXRWVFo5BJUDUZqKfc6aBG8jNxRjX6Z3QLlI0aEL/t/AI/mAKb04N2O8EuGKIc63P
         t+ouJ2HXGfFVAIWgZ0YdAf09IG+RldtdmZ+HmRvpusjoh8R/yn64BOwCBY9if1qiZFlk
         NasbKMo+4JqoNz/dAjQVnWsblHJpb/7dr8+W6Nmi1/a7RvSy0NgF8GctAApb7abYCbVh
         zIFg==
X-Gm-Message-State: AOAM532uT+6dOd6mS4UefaloI0irzuPcNwIRNTosH3K9ueQIfVK5/NE0
        CZUqTmCfW5CLXSpcO55kwQQa2w==
X-Google-Smtp-Source: ABdhPJysIAPNv0rsksYURYX8YC/y2VuuNrtKjwxrIUXsF6UUuOXO2mCVpwKmGwnSloO6tjqq8oxkew==
X-Received: by 2002:a37:bf82:: with SMTP id p124mr21433864qkf.188.1595864234038;
        Mon, 27 Jul 2020 08:37:14 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k48sm15965303qtc.14.2020.07.27.08.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 08:37:13 -0700 (PDT)
Subject: Re: [PATCH 1/2] btrfs: free fs roots on failed mount
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200722160722.8641-1-josef@toxicpanda.com>
 <20200727141947.GN3703@twin.jikos.cz>
 <b8a83f87-752d-98a5-3674-fde808b77af4@toxicpanda.com>
 <20200727151717.GO3703@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <50965693-e130-0222-4fb9-9378e78989e7@toxicpanda.com>
Date:   Mon, 27 Jul 2020 11:37:12 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727151717.GO3703@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/27/20 11:17 AM, David Sterba wrote:
> On Mon, Jul 27, 2020 at 10:33:32AM -0400, Josef Bacik wrote:
>>>> @@ -3441,6 +3440,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>>>>    	btrfs_put_block_group_cache(fs_info);
>>>>    
>>>>    fail_tree_roots:
>>>> +	btrfs_free_fs_roots(fs_info);
>>>>    	free_root_pointers(fs_info, true);
>>>
>>> The data reloc tree is freed inside free_root_pointers, that it's also
>>> in the radix tree is for convenience so I'd rather fix it inside
>>> free_root_pointers and not reorder btrfs_free_fs_roots.
>>
>> We can't do that, because free_root_pointers() is called to drop the extent
>> buffers when we're looping through the backup roots.  btrfs_free_fs_roots() is
>> the correct thing to do here, it goes through anything that ended up in the
>> radix tree.  Thanks,
> 
> I see, free_root_pointers is used elsewhere. I'm concerned about the
> reordeing because there are several functions that are now called after
> the roots are freed.
> 
> (before)	btrfs_free_fs_roots(fs_info);
> 
> 		kthread_stop(fs_info->cleaner_kthread);
> 		filemap_write_and_wait(fs_info->btree_inode->i_mapping);
> 		btrfs_sysfs_remove_mounted(fs_info);
> 		btrfs_sysfs_remove_fsid(fs_info->fs_devices);
> 		btrfs_put_block_group_cache(fs_info);
> 
> (after)		btrfs_free_fs_roots(fs_info);
> 
> If something called by btrfs_free_fs_roots depends on structures
> removed/cleaned by the other functions, eg. btrfs_put_block_group_cache
> ti could be a problem.
> 
> I haven't spotted anything so far, the functions are called after
> failure still during mount, this is easier than shutdown sequence after
> a full mount.
> 

Yeah I'm always loathe to move this stuff around.  I actually think we can end 
up with the case described in close_ctree if we get an error during log replay 
on mount.  I'll rework this some more.  Thanks,

Josef

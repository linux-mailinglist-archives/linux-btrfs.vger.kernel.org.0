Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9E7460C76
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Nov 2021 02:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbhK2Bx4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Nov 2021 20:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhK2Bvz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Nov 2021 20:51:55 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6650DC061761;
        Sun, 28 Nov 2021 17:48:11 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id l190so14322151pge.7;
        Sun, 28 Nov 2021 17:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PZFVEKzLMaakoF4ZFRaJITpkB/YxMw/med03y+uwvx8=;
        b=KygBPuc9oFq83fAyMQZ9xULp7x0dqJwx6yGl/S4AV9VoUFOS2D92B+/6WkLEsR+fj+
         bQ9L4yujTzj0XkdAR4sFhIHkmwmcNwJO389t8qH2bTiW2qqBoayfXSJd/ceLC06fAAFR
         ZYQ57jk/7Z+xLTJeLH9gXG+nlweSpgYlDL0m1MKPUl25APk/s9L3AaunQFOEf9ey4Iwl
         wllKUianpyoG1hrvyAKngiXFS+4zIpIeLZ2wLyuvrqAgw+4VoM9TPwNl6KIDvQ39G9FF
         h4teylmbdPEaGY7x4iTXRPG3cAs2RQPTbEPHRBTh+h5MHpLp6Avw+kbSi1KH3/SUNNMO
         7CUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PZFVEKzLMaakoF4ZFRaJITpkB/YxMw/med03y+uwvx8=;
        b=nW51Tc/zn+3G941Z6kNlqpe/lxNF4YR1ku8amq4Q8nWcCz3F0wEFkvyIwocy2mk1Er
         LIVMFJKcO+ZrUozkv3D8opRlvTNUoA6yEkixRkPeufRvBBn+SlU+ZhqQYRG7FkTV+uec
         J1N4Qk6t4Y2Myj1b3BOQxCWiQYHavibB680ha+8TLI6B6aNo5Z1oltFSLX4spzjd1L9z
         ZfV5thcOV2fsuedB+eY5NRupI7pR4X+m7emdBJ+zSlPXc6BQFLa/C2k3uRxdgnXYM+4b
         F8VPBEjtDF+tzC3Rv02Ck7lKQZP8SsOy2GJcV8Phmz1FE73j0irN/YB46M9yfdWyyhi0
         nB3Q==
X-Gm-Message-State: AOAM5308it3oQksYLHxN32hV/k5EHg4Cz0+9S2fVei8gZx//AmTIh8bH
        +58c68ZeQZKoCjTKhdXwHJDtyQxkbRo=
X-Google-Smtp-Source: ABdhPJx4sOmD6pkSbGW77BWHX04vnEyLbtKiFd04tRccxhK3NxqynosC3YiYDn8HuzwQdyqvr6Wf/g==
X-Received: by 2002:a63:3dc9:: with SMTP id k192mr18801997pga.543.1638150490827;
        Sun, 28 Nov 2021 17:48:10 -0800 (PST)
Received: from [10.132.0.6] ([85.203.23.178])
        by smtp.gmail.com with ESMTPSA id z7sm15280963pfe.77.2021.11.28.17.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 17:48:10 -0800 (PST)
Subject: Re: [BUG] fs: btrfs: several possible ABBA deadlocks
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <44b385ca-f00d-0b47-e370-bd7d97cb1be3@gmail.com>
 <YaQgFhuaQHsND/jr@localhost.localdomain>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <f0ea2d7e-c82d-6749-6e90-48661f5e1dfd@gmail.com>
Date:   Mon, 29 Nov 2021 09:48:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YaQgFhuaQHsND/jr@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/29 8:34, Josef Bacik wrote:
> On Sat, Nov 27, 2021 at 04:23:37PM +0800, Jia-Ju Bai wrote:
>> Hello,
>>
>> My static analysis tool reports several possible ABBA deadlocks in the btrfs
>> module in Linux 5.10:
>>
>> # DEADLOCK 1:
>> __clear_extent_bit()
>>    spin_lock(&tree->lock); --> Line 733 (Lock A)
>>    split_state()
>>      btrfs_split_delalloc_extent()
>>        spin_lock(&BTRFS_I(inode)->lock); --> Line 1870 (Lock B)
>>
>> btrfs_inode_safe_disk_i_size_write()
>>    spin_lock(&BTRFS_I(inode)->lock); --> Line 53 (Lock B)
>>    find_contiguous_extent_bit()
>>      spin_lock(&tree->lock); --> Line 1620 (Lock A)
>>
>> When __clear_extent_bit() and btrfs_inode_safe_disk_i_size_write() are
>> concurrently executed, the deadlock can occur.
>>
>> # DEADLOCK 2:
>> __set_extent_bit()
>>    spin_lock(&tree->lock); --> Line 995 (Lock A)
>>    set_state_bits()
>>      btrfs_set_delalloc_extent()
>>        spin_lock(&BTRFS_I(inode)->lock); --> Line 2007 or 2017 or 2029 (Lock
>> B)
>>
>> btrfs_inode_safe_disk_i_size_write()
>>    spin_lock(&BTRFS_I(inode)->lock); --> Line 53 (Lock B)
>>    find_contiguous_extent_bit()
>>      spin_lock(&tree->lock); --> Line 1620 (Lock A)
>>
>> When __set_extent_bit() and btrfs_inode_safe_disk_i_size_write() are
>> concurrently executed, the deadlock can occur.
>>
>> # DEADLOCK 3:
>> convert_extent_bit()
>>    spin_lock(&tree->lock); --> Line 1241 (Lock A)
>>    set_state_bits()
>>      btrfs_set_delalloc_extent()
>>        spin_lock(&BTRFS_I(inode)->lock); --> Line 2007 or 2017 or 2029 (Lock
>> B)
>>
>> btrfs_inode_safe_disk_i_size_write()
>>    spin_lock(&BTRFS_I(inode)->lock); --> Line 53 (Lock B)
>>    find_contiguous_extent_bit()
>>      spin_lock(&tree->lock); --> Line 1620 (Lock A)
>>
>> When convert_extent_bit() and btrfs_inode_safe_disk_i_size_write() are
>> concurrently executed, the deadlock can occur.
>>
>> I am not quite sure whether these possible deadlocks are real and how to fix
>> them if they are real.
>> Any feedback would be appreciated, thanks :)
>>
> Hey Jia-Ju,
>
> This is pretty good work, unfortunately it's wrong but it's in a subtle way that
> a tool wouldn't be able to catch.  The btrfs_inode_safe_disk_i_size_write()
> helper only messes with BTRFS_I(inode)->file_extent_tree, which is separate from
> the BTRFS_I(inode)->io_tree.  io_tree gets the btrfs_set_delalloc_extent() stuff
> called on it, but the file_extent_tree does not.  The file_extent_tree has
> inode->lock -> tree->lock as the locking order, whereas the file_extent_tree has
> inode->lock -> tree->lock as the locking order.

Okay, thanks for your explanation :)


Best wishes,
Jia-Ju Bai


Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1A422473F
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Jul 2020 01:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGQX4O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 19:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgGQX4O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 19:56:14 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0D8C0619D2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 16:56:14 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e12so8961297qtr.9
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 16:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ndnzUdwtPCs19ca/9tlZ8MxX5n0vIriZSv2oDDbnuHA=;
        b=MVmM2pXc80WqurgqeeIgGY8yum/ihp2VAoJ5Wf7vPACu4w87LJpRwdElumc6gxuFe5
         N2n7HvXikoUNtZHlcsygpgvxyVDHuUhOIRXmy9UptqYMR5GI99y5/RLyrvVfp51V6hzn
         xu5pLaHFOqBC68oIj0eQ+ePOfbt8Wy1KWgm6wErt0ZLqcNhtouCqtTZwAfuAFNizmfEA
         VqBg/X9zZ1NAmc+wA6UOq5i1bLspE3ezmuVbAPKATgKHwxyO7R3Aj8wyZ3SSpiRCKoUG
         tJ/JggDzrS0EVRREaxnM8unKkygFCBRNRBiOod+7zj6lV4qEmOs80gXi61iZLo1mmFa0
         KWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ndnzUdwtPCs19ca/9tlZ8MxX5n0vIriZSv2oDDbnuHA=;
        b=CY1bMDfhEu1FuKTosntWJFpnQ9MrJ6qHIBQBNDNma8O3IfWxWSZ5rBGaaCpOpkbpkT
         +SEjbeOMFQ7/CFhvp9Gw/Je4kuAU8ZMSNEJMzwkL+ckYUm9GVQAsnYFUr5pywCMj+t5i
         BU880l++YhY3TAA3rE9cVKh3FLVBS6qNypsBQ6h9DLxRwEkbnpyGRGpvAynOlyFtvLMy
         xEmIPJAFkPGpZ2llvnxB2N2cAaS0MSvp9RsU2vWZAfbtVPTodll34aJkKgyhzKZn2Fwi
         Jgi+ip7J6IFRf1UecpJPl8//Ft83ILiEKfHvQ4DycuxwlMUpslEjxTONhXYJHJWXMORy
         giNg==
X-Gm-Message-State: AOAM5320l3af0UmR8xZj1Ra66Wpl1COq15QG3cG7/gXNmPnRAnJxok8A
        Npxn8y1Sx52LYRN7WIQx1m4XEtN7GgB5OA==
X-Google-Smtp-Source: ABdhPJwsgTKF9tUiPEIpesA+gnbfx39634RTww5CJYlwgdvNcVg2+V/b/lm5l89KBbHK1P89wYIfbQ==
X-Received: by 2002:aed:2864:: with SMTP id r91mr13130350qtd.311.1595030172528;
        Fri, 17 Jul 2020 16:56:12 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h16sm11353001qkl.96.2020.07.17.16.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 16:56:10 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: qgroup: Fix data leakage caused by race between
 writeback and truncate
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200717071205.26027-1-wqu@suse.com>
 <9b03ca60-e56f-442c-7558-3ca1b2b1df77@toxicpanda.com>
 <dcc47e7f-53e0-e832-0e39-e8c1d82e318e@gmx.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3ba9208e-0f85-a7d3-e6e2-17a1dac1de2e@toxicpanda.com>
Date:   Fri, 17 Jul 2020 19:56:09 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dcc47e7f-53e0-e832-0e39-e8c1d82e318e@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/17/20 7:38 PM, Qu Wenruo wrote:
> 
> 
> On 2020/7/17 下午11:30, Josef Bacik wrote:
>> On 7/17/20 3:12 AM, Qu Wenruo wrote:
>>> [BUG]
>>> When running tests like generic/013 on test device with btrfs quota
>>> enabled, it can normally lead to data leakage, detected at unmount time:
>>>
>>>     BTRFS warning (device dm-3): qgroup 0/5 has unreleased space, type
>>> 0 rsv 4096
>>>     ------------[ cut here ]------------
>>>     WARNING: CPU: 11 PID: 16386 at fs/btrfs/disk-io.c:4142
>>> close_ctree+0x1dc/0x323 [btrfs]
>>>     RIP: 0010:close_ctree+0x1dc/0x323 [btrfs]
>>>     Call Trace:
>>>      btrfs_put_super+0x15/0x17 [btrfs]
>>>      generic_shutdown_super+0x72/0x110
>>>      kill_anon_super+0x18/0x30
>>>      btrfs_kill_super+0x17/0x30 [btrfs]
>>>      deactivate_locked_super+0x3b/0xa0
>>>      deactivate_super+0x40/0x50
>>>      cleanup_mnt+0x135/0x190
>>>      __cleanup_mnt+0x12/0x20
>>>      task_work_run+0x64/0xb0
>>>      __prepare_exit_to_usermode+0x1bc/0x1c0
>>>      __syscall_return_slowpath+0x47/0x230
>>>      do_syscall_64+0x64/0xb0
>>>      entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>     ---[ end trace caf08beafeca2392 ]---
>>>     BTRFS error (device dm-3): qgroup reserved space leaked
>>>
>>> [CAUSE]
>>> In the offending case, the offending operations are:
>>> 2/6: writev f2X[269 1 0 0 0 0] [1006997,67,288] 0
>>> 2/7: truncate f2X[269 1 0 0 48 1026293] 18388 0
>>>
>>> The following sequence of events could happen after the writev():
>>>      CPU1 (writeback)        |        CPU2 (truncate)
>>> -----------------------------------------------------------------
>>> btrfs_writepages()            |
>>> |- extent_write_cache_pages()        |
>>>      |- Got page for 1003520        |
>>>      |  1003520 is Dirty, no writeback    |
>>>      |  So (!clear_page_dirty_for_io())   |
>>>      |  gets called for it        |
>>>      |- Now page 1003520 is Clean.    |
>>>      |                    | btrfs_setattr()
>>>      |                    | |- btrfs_setsize()
>>>      |                    |    |- truncate_setsize()
>>>      |                    |       New i_size is 18388
>>>      |- __extent_writepage()        |
>>>      |  |- page_offset() > i_size        |
>>>         |- btrfs_invalidatepage()        |
>>>       |- Page is clean, so no qgroup |
>>>          callback executed
>>>
>>> This means, the qgroup reserved data space is not properly released in
>>> btrfs_invalidatepage() as the page is Clean.
>>>
>>> [FIX]
>>> Instead of checking the dirty bit of a page, call
>>> btrfs_qgroup_free_data() unconditionally in btrfs_invalidatepage().
>>>
>>> As qgroup rsv are completely binded to the QGROUP_RESERVED bit of
>>> io_tree, not binded to page status, thus we won't cause double freeing
>>> anyway.
>>>
>>> Fixes: 0b34c261e235 ("btrfs: qgroup: Prevent qgroup->reserved from
>>> going subzero")
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>
>>
>> I don't understand how this is ok.  We can call invalidatepage via
>> memory pressure, so what if we have started the write and have an
>> ordered extent outstanding, and then we call into invalidate page and
>> now unconditionally drop the qgroup reservation, even tho we still need
>> it for the ordered extent.  Am I missing something here?  Thanks,
> 
> As long as the ordered extent as been started
> (__btrfs_add_ordered_extent()), then the QGROUP_RESERVED bit is cleared,
> either freed for NODATACOW write, or released for COW writes.
> 
> IIRC this recent change is suggested by you, and that paved the road for
> this fix.
> 

Yeah I had it backwards in my head, this looks good to me, you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

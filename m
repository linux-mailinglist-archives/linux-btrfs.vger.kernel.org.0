Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079BD223F9D
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jul 2020 17:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgGQPah (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 11:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgGQPah (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 11:30:37 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480F9C0619D2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 08:30:37 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id h17so4403907qvr.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jul 2020 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3qRTvKUYTNge7vmE3EOwKlujh92Tlv3Z2E+G5tSvZhg=;
        b=zInZvJwL2y3rE5YFIHWAHivaITLrH7UvRH0Tl/MBDTwR+MHEqKA6U7jEWutTe9+5PE
         6yhTEC5m53hIrEssp7+frmPx+vEqer7BacKDicLkv7OFvBS6+IlzJhAmKKl8G8GCk1Lr
         avdFcgr3eZIgWeHkBxPt1wCvtXc125rjVBfs0suirHo5BJuURxO/4s82RsN2nJxnvTP8
         1kgFehRzx0VhbZnuIuwr4TJ85EwKs9J+i3Otrx4Fp2rdufH3xNIuF1daIBQopCS75bW9
         tM1btCQqIuZG6ZaS5QnpmaQO4y6bI0quOunSvPa6VI3B0GZNeLk3JknD+BZfvhKJG17i
         NW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3qRTvKUYTNge7vmE3EOwKlujh92Tlv3Z2E+G5tSvZhg=;
        b=qFlE2BFbgVtI4zb8OJn0tv7t/Xax+KmvQJ8boJnd8wmfbuPcHRy6bIPIcVA1EnSvgg
         uFXCAOFOFVnZ1Ikt/36cLRQpu+WzKD7I/0fISIDSu02WzeIpM80+gkCE4E8yPJNYiEOh
         11bVwiB2i5ExZrz7t4Fo3HMq2tzuksMPzTnF3IsEjStS9hOHHwOFyLh89sFnz6qpAmhy
         Ir89vV9USoBxTqqe2zqDzCZHH48jQmKqgNhvTytYKUqCSi5OzKwdNX07NddPSgWiPXma
         9dKZvGT8VB7GJ0slUGiYaJXaOeOzKqXV7ztdDvWnLAj5Aipon1QnoPv6BTqggiV2ohuw
         ovow==
X-Gm-Message-State: AOAM5305S5Tn4f3Ztqzcq9WsMO+T3pNGvX5m39B+VVmgOGZmsBktDq5N
        tDqKbD65O/03T5qw2vbk0lwP0KQN6TxUIA==
X-Google-Smtp-Source: ABdhPJysl7JpD2TmU3KXm5btWx1tZ8uOwGOAFD7rZXNzmJKBHLdUJKZVNJcPn/xLFcgi0qt+df/KwA==
X-Received: by 2002:a05:6214:13f4:: with SMTP id ch20mr9590742qvb.73.1594999835842;
        Fri, 17 Jul 2020 08:30:35 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 130sm10693919qkn.82.2020.07.17.08.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 08:30:34 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs: qgroup: Fix data leakage caused by race between
 writeback and truncate
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200717071205.26027-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <9b03ca60-e56f-442c-7558-3ca1b2b1df77@toxicpanda.com>
Date:   Fri, 17 Jul 2020 11:30:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717071205.26027-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/17/20 3:12 AM, Qu Wenruo wrote:
> [BUG]
> When running tests like generic/013 on test device with btrfs quota
> enabled, it can normally lead to data leakage, detected at unmount time:
> 
>    BTRFS warning (device dm-3): qgroup 0/5 has unreleased space, type 0 rsv 4096
>    ------------[ cut here ]------------
>    WARNING: CPU: 11 PID: 16386 at fs/btrfs/disk-io.c:4142 close_ctree+0x1dc/0x323 [btrfs]
>    RIP: 0010:close_ctree+0x1dc/0x323 [btrfs]
>    Call Trace:
>     btrfs_put_super+0x15/0x17 [btrfs]
>     generic_shutdown_super+0x72/0x110
>     kill_anon_super+0x18/0x30
>     btrfs_kill_super+0x17/0x30 [btrfs]
>     deactivate_locked_super+0x3b/0xa0
>     deactivate_super+0x40/0x50
>     cleanup_mnt+0x135/0x190
>     __cleanup_mnt+0x12/0x20
>     task_work_run+0x64/0xb0
>     __prepare_exit_to_usermode+0x1bc/0x1c0
>     __syscall_return_slowpath+0x47/0x230
>     do_syscall_64+0x64/0xb0
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9
>    ---[ end trace caf08beafeca2392 ]---
>    BTRFS error (device dm-3): qgroup reserved space leaked
> 
> [CAUSE]
> In the offending case, the offending operations are:
> 2/6: writev f2X[269 1 0 0 0 0] [1006997,67,288] 0
> 2/7: truncate f2X[269 1 0 0 48 1026293] 18388 0
> 
> The following sequence of events could happen after the writev():
> 	CPU1 (writeback)		|		CPU2 (truncate)
> -----------------------------------------------------------------
> btrfs_writepages()			|
> |- extent_write_cache_pages()		|
>     |- Got page for 1003520		|
>     |  1003520 is Dirty, no writeback	|
>     |  So (!clear_page_dirty_for_io())   |
>     |  gets called for it		|
>     |- Now page 1003520 is Clean.	|
>     |					| btrfs_setattr()
>     |					| |- btrfs_setsize()
>     |					|    |- truncate_setsize()
>     |					|       New i_size is 18388
>     |- __extent_writepage()		|
>     |  |- page_offset() > i_size		|
>        |- btrfs_invalidatepage()		|
> 	 |- Page is clean, so no qgroup |
> 	    callback executed
> 
> This means, the qgroup reserved data space is not properly released in
> btrfs_invalidatepage() as the page is Clean.
> 
> [FIX]
> Instead of checking the dirty bit of a page, call
> btrfs_qgroup_free_data() unconditionally in btrfs_invalidatepage().
> 
> As qgroup rsv are completely binded to the QGROUP_RESERVED bit of
> io_tree, not binded to page status, thus we won't cause double freeing
> anyway.
> 
> Fixes: 0b34c261e235 ("btrfs: qgroup: Prevent qgroup->reserved from going subzero")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 

I don't understand how this is ok.  We can call invalidatepage via memory 
pressure, so what if we have started the write and have an ordered extent 
outstanding, and then we call into invalidate page and now unconditionally drop 
the qgroup reservation, even tho we still need it for the ordered extent.  Am I 
missing something here?  Thanks,

Josef

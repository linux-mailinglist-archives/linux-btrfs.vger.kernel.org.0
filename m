Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2BD22F1A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 16:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbgG0Odl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 10:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732857AbgG0Odf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 10:33:35 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FE2C0619D2
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 07:33:35 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l23so15428369qkk.0
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Jul 2020 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ysAP66s9e/dAJ4juObsZTFNY4yDmtALaavR2R+f1xmc=;
        b=AFUar6QzEJ0oIVxupeTt7TgZBluyhBfLj9ElRjt+5RVyxUNCPy5NJkM8SVjN8kslnv
         20R97MWDla+UCQR4V+l6dbpAhNIUVdExcMy/sj/M7nP4LTZQ/VhtrHC4o4UtqbzC0MlB
         RFlYxYBWPfIKQaGQlivBI2Kz60s+35fLW/GkgMSzakqbIR246MSzF67nRn3r2D7PBOQk
         BNRvl4G+tkGF2o66BrePXeuJVAvwzksrLnVrqdqFZlCAJp1SbpEfMd4VBmlzTYvPujJ8
         QjtODGxacV9PZWbG75G51xQVXMxZsiA8G2AYMOdRRHGKoc8cMSvB8BqNgB8dMBJpvmIU
         dxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ysAP66s9e/dAJ4juObsZTFNY4yDmtALaavR2R+f1xmc=;
        b=g4vX8gpxTo/tH/YorG8TzAq37UazUaisXgwfH7dSpq79gdZC+v5LNcC/DqCQZibStp
         mmrFE9+lkfqcBnozEv8WmZC2Qc4DV5ofgI7mZrOWltmWUzDtQU+86hRwjBO62ga4Xq40
         u1YHfjdlDo0dvnZje7auJ5r+X/LfviFWyfNZFwEaW97HUR7s2FszzOQuDW3/qREwJnKI
         j/AEiATU5pyNk5p5tD4fBZr5FXlGtEbh1Ck2QyftRHx+ac4i3Y80vU3m7pBVpn7KroKw
         19nHEKm/9zpY6r6RGRp6AqHiIqPbRMLs5AftqU75gGWutcsUFnNXYhiGXFczrWwlTE45
         6eJg==
X-Gm-Message-State: AOAM532wTNSB0spKaCtH3yMerC2jjmiL7oSnk9e8oBP5xd1Uzd8tg/aH
        C/h53VmRAFrgmo0Yogfvf8v9cj6CkZulTA==
X-Google-Smtp-Source: ABdhPJwYPJI11FZBYX3Qro4sKE9qjyRrnYLWG8NoNLJmIPAegQBZ1l7uWoSDq90kpGw7/jZTcGIPfA==
X-Received: by 2002:a37:6c7:: with SMTP id 190mr5058626qkg.163.1595860414705;
        Mon, 27 Jul 2020 07:33:34 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q68sm19196712qke.123.2020.07.27.07.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 07:33:33 -0700 (PDT)
Subject: Re: [PATCH 1/2] btrfs: free fs roots on failed mount
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <20200722160722.8641-1-josef@toxicpanda.com>
 <20200727141947.GN3703@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b8a83f87-752d-98a5-3674-fde808b77af4@toxicpanda.com>
Date:   Mon, 27 Jul 2020 10:33:32 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727141947.GN3703@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/27/20 10:19 AM, David Sterba wrote:
> On Wed, Jul 22, 2020 at 12:07:21PM -0400, Josef Bacik wrote:
>> While testing a weird problem with -o degraded, I noticed I was getting
>> leaked root errors
>>
>> BTRFS warning (device loop0): writable mount is not allowed due to too many missing devices
>> BTRFS error (device loop0): open_ctree failed
>> BTRFS error (device loop0): leaked root -9-0 refcount 1
>>
>> This is the DATA_RELOC root, which gets read before the other fs roots,
>> but is included in the fs roots radix tree, and thus gets freed by
>> btrfs_free_fs_roots.  Fix this by moving the call into fail_tree_roots:
>> in open_ctree.  With this fix we no longer leak that root on mount
>> failure.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/disk-io.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index c850d7f44fbe..f1fdbdd44c02 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -3421,7 +3421,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>>   fail_trans_kthread:
>>   	kthread_stop(fs_info->transaction_kthread);
>>   	btrfs_cleanup_transaction(fs_info);
>> -	btrfs_free_fs_roots(fs_info);
>>   fail_cleaner:
>>   	kthread_stop(fs_info->cleaner_kthread);
>>   
>> @@ -3441,6 +3440,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>>   	btrfs_put_block_group_cache(fs_info);
>>   
>>   fail_tree_roots:
>> +	btrfs_free_fs_roots(fs_info);
>>   	free_root_pointers(fs_info, true);
> 
> The data reloc tree is freed inside free_root_pointers, that it's also
> in the radix tree is for convenience so I'd rather fix it inside
> free_root_pointers and not reorder btrfs_free_fs_roots.
> 

We can't do that, because free_root_pointers() is called to drop the extent 
buffers when we're looping through the backup roots.  btrfs_free_fs_roots() is 
the correct thing to do here, it goes through anything that ended up in the 
radix tree.  Thanks,

Josef

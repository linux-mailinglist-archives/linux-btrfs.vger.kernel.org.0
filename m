Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A589E2A861C
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 19:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgKES3R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 13:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgKES3R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 13:29:17 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A23C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 10:29:15 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 12so2094638qkl.8
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 10:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=DU4DkwGWJf7f38OBQ6CNv+cBvGZEPRo+TkkHlUqdZ70=;
        b=Rl7cCDctpPInymeI12gGFrUGySt5+22X8mV+/BoAIe6XhhOv+l2iq9zeuG0/DmWotg
         ERNdUOV21OXJHkhpcLQqnlC8IoQwpJJOsS8VRpPTVQ0USPyjfoUnPpctbjIrvLzQo7KT
         vziqHuR6W9Ji3Y/Ztxfu1qixXZ59ADwzuCz4HMQ9ry3Yy4mF1bTneWPLgQjL1wAH3SvF
         K0DD9Be5svYY5j/AtyEHr6IDNN8YsSDYor4DHQJq+Cxc+eVlC8Uj7OmtEElz+D8DScQq
         NQnwag67CHEa2ZjZCKhpwEF57S8cX0/kocNPgucKji0Ke8M7ag2L0K9vhgyKIVgYNeBb
         9qQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DU4DkwGWJf7f38OBQ6CNv+cBvGZEPRo+TkkHlUqdZ70=;
        b=XnH5D99FiwQDzRpbSkwmdvv5cO0zzFJfWnDbOILlbFmYFQvdQFw2v2jTnFcZb6wbrv
         1Vv5zG/aHEMI+N6hiipfKiLyRTRyFNF6PfANEC69t7Geb3VpLam4wfVUWN+6w65G//8S
         z63ALD8Lf6ZwJlkLqPXuW4vQujxd8LzGSXKS14OXcQINPTKglQB7o3RvkcZ7tGaEs0mo
         cXBS0dDgCORokbCDHc3wdXuvaq9vMnrDwdCX1RzPrLA2wW6EprnzeFi+VTAuSr1fHkay
         JJcWv91AqfR8RNWwxkIlqFY+Sbf64HNhkDZ6x3wDNg34IdVos9JRWDebGZPRbsjtubbb
         Y9Yg==
X-Gm-Message-State: AOAM532TJ6r8RGM8VUUuIv1RfyDTJjpQrF8A9E0uNRdLQYzrL2oJFiKt
        3e+Cdhf01mHe/jOXx2O05fbcw25DM8lRbFGK
X-Google-Smtp-Source: ABdhPJz5HAV8YkDdQ21kAnPs4ZiQ9E/5r9xMBHcb3rGEvgDPr1jt0XuNMc6h4a27T8cZJKO7jcqQEA==
X-Received: by 2002:a37:a857:: with SMTP id r84mr3498184qke.11.1604600954360;
        Thu, 05 Nov 2020 10:29:14 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p48sm1142649qtp.67.2020.11.05.10.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 10:29:13 -0800 (PST)
Subject: Re: [PATCH 1/4] btrfs: fix missing delalloc new bit for new delalloc
 ranges
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1604486892.git.fdmanana@suse.com>
 <7f215e2509aa557504a5d352ff4371f2e2606f59.1604486892.git.fdmanana@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <196ad815-4fd4-6218-83a2-0c5f44ce3940@toxicpanda.com>
Date:   Thu, 5 Nov 2020 13:29:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <7f215e2509aa557504a5d352ff4371f2e2606f59.1604486892.git.fdmanana@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 11/4/20 6:07 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing a buffered write, through one of the write family syscalls, we
> look for ranges which currenly don't have allocated extents and set the
> 'delalloc new' bit on them, so that we can report a correct number of used
> blocks to the stat(2) syscall until delalloc is flushed and ordered extents
> complete.
> 
> However there are a few other places where we can do a buffered write
> against a range that is mapped to a hole (no extent allocated) and where
> we do not set the 'new delalloc' bit. Those places are:
> 
> - Doing a memory mapped write against a hole;
> 
> - Cloning an inline extent into a hole starting at file offset 0;
> 
> - Calling btrfs_cont_expand() when the i_size of the file is not aligned
>    to the sector size and is located in a hole. For example when cloning
>    to a destination offset beyond eof.
> 
> So after such cases, until the corresponding delalloc range is flushed and
> the respective ordered extents complete, we can report an incorrect number
> of blocks used through the stat(2) syscall.
> 
> In some cases we can end up reporting 0 used blocks to stat(2), which is a
> particular bad value to report as it may mislead tools to think a file is
> completely sparse when its i_size is not zero, making them skip reading
> any data, an undesired consequence for tools such as archivers and other
> backup tools, as reported a long time ago in the following thread (and
> other past threads):
> 
>    https://lists.gnu.org/archive/html/bug-tar/2016-07/msg00001.html
> 
> Example reproducer:
> 
>    $ cat reproducer.sh
>    #!/bin/bash
> 
>    MNT=/mnt/sdi
>    DEV=/dev/sdi
> 
>    mkfs.btrfs -f $DEV > /dev/null
>    # mkfs.xfs -f $DEV > /dev/null
>    # mkfs.ext4 -F $DEV > /dev/null
>    # mkfs.f2fs -f $DEV > /dev/null
>    mount $DEV $MNT
> 
>    xfs_io -f -c "truncate 64K"   \
>        -c "mmap -w 0 64K"        \
>        -c "mwrite -S 0xab 0 64K" \
>        -c "munmap"               \
>        $MNT/foo
> 
>    blocks_used=$(stat -c %b $MNT/foo)
>    echo "blocks used: $blocks_used"
> 
>    if [ $blocks_used -eq 0 ]; then
>        echo "ERROR: blocks used is 0"
>    fi
> 
>    umount $DEV
> 
>    $ ./reproducer.sh
>    blocks used: 0
>    ERROR: blocks used is 0
> 
> So move the logic that decides to set the 'delalloc bit' bit into the
> function btrfs_set_extent_delalloc(), since that is what we use for all
> those missing cases as well as for the cases that currently work well.
> 
> This change is also preparatory work for an upcoming patch that fixes
> other problems related to tracking and reporting the number of bytes used
> by an inode.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

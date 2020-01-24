Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62260148669
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 14:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388273AbgAXNxv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 08:53:51 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46687 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387970AbgAXNxu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 08:53:50 -0500
Received: by mail-qv1-f66.google.com with SMTP id u1so895540qvk.13
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 05:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=C8VYO9aiESI6aPWyK7Xv5xsgJiYlrWz5zanS6hnhLGk=;
        b=KUfOhH4k86yVSGZuZsy83AZyk49ARhb/I1Yhm3D8yVWGXkOyiBvppbByF31SGPm11n
         woNn2EAuvL0JZhk4ep4u+I0zXcSp9B65X6AL2OgIsqZoNBsoMuQYXmQykJ3S9wX23xiW
         xngcpyw2rO9ePrPWsAItsbrS5ICIHBFOjm/SjQeRMKNiK9lD0N0DRniosYK42LSX1MmR
         UeYxRo4kHGH8XQUMOlz60pCc78401ZpuOkzVfJIbnHQNi4Aarggzt4QUZjymNqFRE5yz
         rPrN/ieyyYfQ/Y686xJ+wWrVDqBX7JtqUAY2JQ5zUD9XBqip82XdPWIKTGGemPRKUsyP
         z3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C8VYO9aiESI6aPWyK7Xv5xsgJiYlrWz5zanS6hnhLGk=;
        b=IhZ43y0hDJh1lnHd7LXgCGr5ZUWrj+zP1aUKtJh1icwKY7JWs614kHXNeowgfmtvJW
         PxVVyamjhQ0UzbmniOU4PSY1AfZkXEacAymlUq3cAgzkKuramrnJWSeGQ6JOFXymgCeG
         Jv4MgXwi/c/0icMAOJYRy2KK69pZQM7MqR71JQ+8suHqfuLYTaMrBDphZsqAiBbW2Rie
         JktMZ8aeIHsa6EiEO/gk+LfLlib9XRpWcrSgV20a/JzANIvMzfQeIlr/SKp+a41+Szd2
         YiIu9noVYza5++Dti9WAbHZa4AvIMUSmxi9JbWJyJtN7Xex/UZvF38IKseLynsAMnjQc
         ApxQ==
X-Gm-Message-State: APjAAAVrty+ZgYt/DoJTf6YIj2Sna07M7TjM9z+jQVcny7ncL44LjFoE
        4Ru+Y+FzX0sSf15nUt9YKUWEUDWaDjzUEQ==
X-Google-Smtp-Source: APXvYqwniWRlR6zwAU1oo/eng9IYa2ZQs7EDBsZnk58NQr64peYlBbC2B230g/ZcvB76xayK2fy0ew==
X-Received: by 2002:a0c:ffc9:: with SMTP id h9mr1371558qvv.50.1579874029473;
        Fri, 24 Jan 2020 05:53:49 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::68b4])
        by smtp.gmail.com with ESMTPSA id w21sm3385856qth.17.2020.01.24.05.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 05:53:48 -0800 (PST)
Subject: Re: [PATCH] Btrfs: send, fix emission of invalid clone operations
 within the same file
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200124115204.4086-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <3fe3ac4e-30d3-3b26-38f7-5920ebdbd053@toxicpanda.com>
Date:   Fri, 24 Jan 2020 08:53:46 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124115204.4086-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/24/20 6:52 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When doing an incremental send and a file has extents shared with itself
> at different file offsets, it's possible for send to emit clone operations
> that will fail at the destination because the source range goes beyond the
> file's current size. This happens when the file size has increased in the
> send snapshot, there is a hole between the shared extents and both shared
> extents are at file offsets which are greater the file's size in the
> parent snapshot.
> 
> Example:
> 
>    $ mkfs.btrfs -f /dev/sdb
>    $ mount /dev/sdb /mnt/sdb
> 
>    $ xfs_io -f -c "pwrite -S 0xf1 0 64K" /mnt/sdb/foobar
>    $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/base
>    $ btrfs send -f /tmp/1.snap /mnt/sdb/base
> 
>    # Create a 320K extent at file offset 512K.
>    $ xfs_io -c "pwrite -S 0xab 512K 64K" /mnt/sdb/foobar
>    $ xfs_io -c "pwrite -S 0xcd 576K 64K" /mnt/sdb/foobar
>    $ xfs_io -c "pwrite -S 0xef 640K 64K" /mnt/sdb/foobar
>    $ xfs_io -c "pwrite -S 0x64 704K 64K" /mnt/sdb/foobar
>    $ xfs_io -c "pwrite -S 0x73 768K 64K" /mnt/sdb/foobar
> 
>    # Clone part of that 320K extent into a lower file offset (192K).
>    # This file offset is greater than the file's size in the parent
>    # snapshot (64K). Also the clone range is a bit behind the offset of
>    # the 320K extent so that we leave a hole between the shared extents.
>    $ xfs_io -c "reflink /mnt/sdb/foobar 448K 192K 192K" /mnt/sdb/foobar
> 
>    $ btrfs subvolume snapshot -r /mnt/sdb /mnt/sdb/incr
>    $ btrfs send -p /mnt/sdb/base -f /tmp/2.snap /mnt/sdb/incr
> 
>    $ mkfs.btrfs -f /dev/sdc
>    $ mount /dev/sdc /mnt/sdc
> 
>    $ btrfs receive -f /tmp/1.snap /mnt/sdc
>    $ btrfs receive -f /tmp/2.snap /mnt/sdc
>    ERROR: failed to clone extents to foobar: Invalid argument
> 
> The problem is that after processing the extent at file offset 192K, send
> does not issue a write operation full of zeroes for the hole between that
> extent and the extent starting at file offset 520K (hole range from 384K
> to 512K), this is because the hole is at an offset larger the size of the
> file in the parent snapshot (384K > 64K). As a consequence the field
> 'cur_inode_next_write_offset' of the send context remains with a value of
> 384K when we start to process the extent at file offset 512K, which is the
> value set after processing the extent at offset 192K.
> 
> This screws up the lookup of possible extents to clone because due to an
> incorrect value of 'cur_inode_next_write_offset' we can now consider
> extents for cloning, in the same inode, that lie beyond the current size
> of the file in the receiver of the send stream. Also, when checking if
> an extent in the same file can be used for cloning, we must also check
> that not only its start offset doesn't start at or beyond the current eof
> of the file in the receiver but that the source range doesn't go beyond
> current eof, that is we must check offset + length does not cross the
> current eof, as that makes clone operations fail with -EINVAL.
> 
> So fix this by updating 'cur_inode_next_write_offset' whenever we start
> processing an extent and checking an extent's offset and length when
> considering it for cloning operations.
> 
> A test case for fstests follows soon.
> 
> Fixes: 11f2069c113e02 ("Btrfs: send, allow clone operations within the same file")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

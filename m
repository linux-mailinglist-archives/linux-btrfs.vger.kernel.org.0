Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5165F155BA2
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 17:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgBGQTo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 11:19:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34419 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGQTn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Feb 2020 11:19:43 -0500
Received: by mail-qk1-f194.google.com with SMTP id a23so2759858qka.1
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2020 08:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Tu2M+zdOmXIXH+oQ5HS1H5xhr6HV6EoOHxKzHUS7y0Y=;
        b=SFb3k8POGezsPK4S+/CrCFjoJB33NZxJE752O9q7km1LWZnWtM12eg9QpqegWfkQ9o
         8I8zny0sABxnBJKP3SYb55O739mzunEM47W9bGiDmw4rvyUHVGckfrfyCIaDoHpFDmBQ
         Aeupl3VY5LUEyarTTLtkkpYIA8Dq9ApKdkc/dXJ4JVobsnLSL0h4Celzhh8y1b9spnor
         wmUVphne11BwbxZPp2opgmXJN2v7/ZsOoLLmJki9jdytOEJy/sidv/uXTD8dqZ0jpglJ
         YHJiPDdm5t8kmT5mMv7wDHi3MzD2+To4+NwY8BwV4645LCJHINxdJF5aKCQQeLAXqSCI
         FxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tu2M+zdOmXIXH+oQ5HS1H5xhr6HV6EoOHxKzHUS7y0Y=;
        b=AaQFHcMUXJCIl/tdjMgs18tw7cZ8cIT2JQXSYJz0r5LPlFOULFYE52KUt7GlznIJ4v
         8PS0eNR5i2wQZN2zmw0URQ/9xo2UTmuAElmDzGaq8cfmsXUIWsG0ucI658uwNpHMThlV
         n8YVr9YswVEH11S+Qbfofx8zymXfZdFiAEr7J7Z9qexgujTfP+prvGCPQFI3pD4iYPDy
         KldtqUBFQA9MMdSlKcVfmo/vm94QD+t7b4QsezQEl+jA7PazcR2bxavNx1olNmwVogQe
         xhZC1HuS/E9jPSK7oyTs4X3/5sMctiXqsB5C5vs0SCzjgREFuVrbT2R1f7WtDlybBvTA
         UFtA==
X-Gm-Message-State: APjAAAXPsf65Xp5vClKedCTAR2GkmacHetO9XddLphgCy7l6Wa9GbL4L
        gEGe6dHUUIB6lBwxS85f0M1NAcfvPt4=
X-Google-Smtp-Source: APXvYqwW/E6tOydKiuqs8hFgm5YTSI5RRlhENBkuERZw+JHwmAW4lvo/MbjRs04X/3iCLSeswvPIgw==
X-Received: by 2002:ae9:e910:: with SMTP id x16mr7969653qkf.90.1581092380911;
        Fri, 07 Feb 2020 08:19:40 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s26sm1616853qtq.22.2020.02.07.08.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 08:19:40 -0800 (PST)
Subject: Re: [PATCH] Btrfs: fix race between shrinking truncate and fiemap
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200207122309.17209-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <749c0bca-b740-e163-e937-94277efd3d4a@toxicpanda.com>
Date:   Fri, 7 Feb 2020 11:19:38 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207122309.17209-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/7/20 7:23 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When there is a fiemap executing in parallel with a shrinking truncate we
> can end up in a situation where we have extent maps for which we no longer
> have corresponding file extent items. This is generally harmless and at
> the moment the only consequences are missing file extent items representing
> holes after we expand the file size again after the truncate operation
> removed the prealloc extent items, and stale information for future fiemap
> calls (reporting extents that no longer exist or may have been reallocated
> to other files for example).
> 
> Consider the following example:
> 
> 1) Our inode has a size of 128Kb, one 128Kb extent at file offset 0 and
>     a 1Mb prealloc extent at file offset 128Kb;
> 
> 2) Task A starts doing a shrinking truncate of our inode to reduce it to
>     a size of 64Kb. Before it searches the subvolume tree for file extent
>     items to delete, it drops all the extent maps in the range from 64Kb
>     to (u64)-1 by calling btrfs_drop_extent_cache();
> 
> 3) Task B starts doing a fiemap against our inode. When looking up for the
>     inode's extent maps in the range from 128Kb to (u64)-1, it doesn't find
>     any in the inode's extent map tree, since they were removed by task A.
>     Because it didn't find any in the extent map tree, it scans the inode's
>     subvolume tree for file extent items, and it finds the 1Mb prealloc
>     extent at file offset 128Kb, then it creates an extent map based on
>     that file extent item and adds it to inode's extent map tree (this ends
>     up being done by btrfs_get_extent() <- btrfs_get_extent_fiemap() <-
>     get_extent_skip_holes());
> 
> 4) Task A then drops the prealloc extent at file offset 128Kb and shrinks
>     the 128Kb extent file offset 0 to a length of 64Kb. The truncation
>     operation finishes and we end up with an extent map representing a 1Mb
>     prealloc extent at file offset 128Kb, despite we don't have any more
>     that extent;
> 
> After this the two types of problems we have are:
> 
> 1) Future calls to fiemap always report that a 1Mb prealloc extent exists
>     at file offset 128Kb. This is stale information, no longer correct;
> 
> 2) If the size of the file is increased, by a truncate operation that
>     increases the file size or by a write into a file offset > 64Kb for
>     example, we end up not inserting file extent items to represent
>     holes for any range between 128Kb and 128Kb + 1Mb, since the hole
>     expansion function, btrfs_cont_expand() will skip hole insertion
>     for any range for which an extent map exists that represents a
>     prealloc extent. This causes fsck to complain about missing file
>     extent items when not using the NO_HOLES feature.
> 
> The second issue could be often triggered by test case generic/561 from
> fstests, which runs fsstress and duperemove in parallel, and duperemove
> does frequent fiemap calls.
> 
> Essentially the problems happens because fiemap does not acquire the
> inode's lock while truncate does, and fiemap locks the file range in the
> inode's iotree while truncate does not. So fix the issue by making
> btrfs_truncate_inode_items() lock the file range from the new file size
> to (u64)-1, so that it serializes with fiemap.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

I've been wanting to do this for years anyway.  We should probably go and see if 
there's anywhere else we're modifying file extents without the extent lock in place.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA1F212412
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgGBNE3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729055AbgGBNE2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:04:28 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB819C08C5C1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jul 2020 06:04:28 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id a14so12590220qvq.6
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jul 2020 06:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1NTSYWg47uLSkIoOnKOkxNo4RPvGm/51T+oP2oL6xrk=;
        b=BZpwpYZXDMj3d0ZSVCrXVbBQDoIVJsimYz24m+DU0EObpVjUC6MaZ45dKK0hcLHOkQ
         ywZoKyY+hgPcSvy31WvDTDsG2Q96/LASkCtS79gAdKtPCZpRNd2Ho2kPDpPRPvoQTOXj
         jaHKfMEX7qFzFiWNnTNx7N9yfqwQQUAYI2MscHD7B3zlz+HsSCbkVzVNIKfuSJeJF2P7
         SZoOCIGmuPoWFRoi6oLnMwgQxzRhnjfC0EvYo02iUM3h65RJ9YcFiWf/IM22OdPejHC5
         oy/5zKH84ybk+Bc+FrXYwdXZhzG1SZr0vQhz+LRY4jP/m52jDtM2wVOTfHmBVCRvGnaK
         aETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1NTSYWg47uLSkIoOnKOkxNo4RPvGm/51T+oP2oL6xrk=;
        b=WE4t2o3+/4aZRk83bSiHjWqcEyuXUw77gT54DLBnDPU/wgCLuKNqkudHK5QzjiY5zd
         Wt1T0D0rzx7vwkSj1UOdol6uV/y65yBtiJwhfDMfWJ/oGC3kEmiPSxc8w86Z3N7T5o5W
         r4mXEDzTkK+uqdrS9BHjgb0ko/880qkV5obqRscEKEW5um2LlbKtGyXA+dBaQVvLj+tJ
         XBfIfgldex/HN1HufTEIUlEBCJ+ZWHQ5p8rcSBZaxS7df0IZgOt8dunPOE/aNoG0kKGK
         2+dgrMyHRbEVjYdq+zue/Bw452WcX8DWi0V+9D277LOITLb230IFK1vgQpOMOKTTEriS
         wmZw==
X-Gm-Message-State: AOAM531ptEwKTcRyOi2YAz9JOd5WMmYGzVtJkX8KCRXaI42WfwVHj6oJ
        hbvrML7bimlvxWbNTmHwjVMO93VURSJ9Eg==
X-Google-Smtp-Source: ABdhPJwR4J+SM4xvWgNnKqFDXaSBBpnAeLScCjsfn4+xh0eHzekNDV0oziQ8UzMSVWImk6OyfJJXHw==
X-Received: by 2002:a0c:e789:: with SMTP id x9mr28252208qvn.135.1593695067445;
        Thu, 02 Jul 2020 06:04:27 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x34sm891557qtd.44.2020.07.02.06.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:04:26 -0700 (PDT)
Subject: Re: [PATCH 4/4] btrfs: remove no longer needed use of log_writers for
 the log root tree
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200702113240.171572-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ae10a30c-636b-65d7-5da0-f9a5d0c8fab1@toxicpanda.com>
Date:   Thu, 2 Jul 2020 09:04:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702113240.171572-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/2/20 7:32 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When syncing the log, we used to update the log root tree without holding
> neither the log_mutex of the subvolume root nor the log_mutex of log root
> tree.
> 
> We used to have two critical sections delimited by the log_mutex of the
> log root tree, so in the first one we incremented the log_writers of the
> log root tree and on the second one we decremented it and waited for the
> log_writers counter to go down to zero. This was because the update of
> the log root tree happened between the two critical sections.
> 
> The use of two critical sections allowed a little bit more of parallelism
> and required the use of the log_writers counter, necessary to make sure
> we didn't miss any log root tree update when we have multiple tasks trying
> to sync the log in parallel.
> 
> However after commit 06989c799f0481 ("Btrfs: fix race updating log root
> item during fsync") the log root tree update was moved into a critical
> section delimited by the subvolume's log_mutex. Later another commit
> moved the log tree update from that critical section into the second
> critical section delimited by the log_mutex of the log root tree. Both
> commits addressed different bugs.
> 
> The end result is that the first critical section delimited by the
> log_mutex of the log root tree became pointless, since there's nothing
> done between it and the second critical section, we just have an unlock
> of the log_mutex followed by a lock operation. This means we can merge
> both critical sections, as the first one does almost nothing now, and we
> can stop using the log_writers counter of the log root tree, which was
> incremented in the first critical section and decremented in the second
> criticial section, used to make sure no one in the second critical section
> started writeback of the log root tree before some other task updated it.
> 
> So just remove the mutex_unlock() followed by mutex_lock() of the log root
> tree, as well as the use of the log_writers counter for the log root tree.
> 
> This patch is part of a series that has the following patches:
> 
> 1/4 btrfs: only commit the delayed inode when doing a full fsync
> 2/4 btrfs: only commit delayed items at fsync if we are logging a directory
> 3/4 btrfs: stop incremening log_batch for the log root tree when syncing log
> 4/4 btrfs: remove no longer needed use of log_writers for the log root tree
> 
> After the entire patchset applied I saw about 12% decrease on max latency
> reported by dbench. The test was done on a qemu vm, with 8 cores, 16Gb of
> ram, using kvm and using a raw NVMe device directly (no intermediary fs on
> the host). The test was invoked like the following:
> 
>    mkfs.btrfs -f /dev/sdk
>    mount -o ssd -o nospace_cache /dev/sdk /mnt/sdk
>    dbench -D /mnt/sdk -t 300 8
>    umount /mnt/dsk
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Lol oops, did I leave it like that?

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

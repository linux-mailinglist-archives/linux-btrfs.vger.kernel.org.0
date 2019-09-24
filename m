Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8C9BC935
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 15:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440956AbfIXNxp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 09:53:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43645 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfIXNxo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 09:53:44 -0400
Received: by mail-qk1-f196.google.com with SMTP id h126so1787129qke.10
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 06:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d6LBwq62XbjOYBzay2wfOTQgO/PNLesBz5q6Ewi+6Q4=;
        b=ed5uQEJwZTyE0PtV6xY8iSLPjLAbfTRCJPVApxamt90LH9uR6+QxHMWksUIfT4nWdC
         WlAcMuHfpxzENG6oGRzRVNVNCNwfLKhWt1B7r7Os3vk3cDY8Y39NyAwOB6lnyz/ChQG7
         jDPqoVB426mmi34YqC+nAgmhXeKPD8tQUXiWbdRvMTYh4aEjUkyniSwyFUuwo2/EcqVm
         TXR+oOmgzMX5d8pwWfwf9MZNV53BnbhLdKqNXOp3BTIDkyFe6ml4Px5qQjUZqfH5J2D/
         Azq0FZhMYVjeME6+bVE+4H9wjai6CY8L38GKT2L3MkC7J7xD7Iav16sGU1RVtcMuwss8
         fiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d6LBwq62XbjOYBzay2wfOTQgO/PNLesBz5q6Ewi+6Q4=;
        b=k2ADghDK9LUqyK382OaJS9fE6tvN9TRxH3k75vxUcVOkhme5zpjDgCCSpAzIc7duQy
         qIN0jx8rwJgEnsmZxNe11RHlPiG5miVYZ+s3c9t2ZLIeJMopWZwbSk74z7Vz6pEs0jLS
         M5Qejb2d+6wvYF1q65J9CY8QJRuoUr9Yo/a/Yza1Xnf1+m7tYU3WeC+kejUIaXnC/wQK
         ztvJKc5iPB3CX6x7ybyDJS72npKfY3WdqY6aygfhQlOosIpwtmTZeNeURJS0GpkvCeWR
         f13+RVFegXlnLk6BVcE5Zzq8RtS9Qln2hySt7rO+wVpOQv5dkQuZ6dQj0z0A1aWTJkwa
         LMpA==
X-Gm-Message-State: APjAAAUyj67+O+zjAjyTD13+0wNw8Xvd8GMFTK/LitPhJCpyRsvUiSg7
        b5rgZV6ueS8A2A0dtoj746epZA==
X-Google-Smtp-Source: APXvYqz76ZeThw0P5pmjoP6WMz08lykCFYV2+ACLmRppcgKRml5dQsHzjzfNl6axQqu50+Veh8L1Dw==
X-Received: by 2002:a37:804:: with SMTP id 4mr2336019qki.97.1569333223212;
        Tue, 24 Sep 2019 06:53:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::b7c9])
        by smtp.gmail.com with ESMTPSA id x59sm1114549qte.20.2019.09.24.06.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 06:53:42 -0700 (PDT)
Date:   Tue, 24 Sep 2019 09:53:40 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix race setting up and completing qgroup rescan
 workers
Message-ID: <20190924135339.2we3mcdlc22sczhx@macbook-pro-91.dhcp.thefacebook.com>
References: <20190924094954.1304-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924094954.1304-1-fdmanana@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 10:49:54AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There is a race between setting up a qgroup rescan worker and completing
> a qgroup rescan worker that can lead to callers of the qgroup rescan wait
> ioctl to either not wait for the rescan worker to complete or to hang
> forever due to missing wake ups. The following diagram shows a sequence
> of steps that illustrates the race.
> 
>         CPU 1                                                         CPU 2                                  CPU 3
> 
>  btrfs_ioctl_quota_rescan()
>   btrfs_qgroup_rescan()
>    qgroup_rescan_init()
>     mutex_lock(&fs_info->qgroup_rescan_lock)
>     spin_lock(&fs_info->qgroup_lock)
> 
>     fs_info->qgroup_flags |=
>       BTRFS_QGROUP_STATUS_FLAG_RESCAN
> 
>     init_completion(
>       &fs_info->qgroup_rescan_completion)
> 
>     fs_info->qgroup_rescan_running = true
> 
>     mutex_unlock(&fs_info->qgroup_rescan_lock)
>     spin_unlock(&fs_info->qgroup_lock)
> 
>     btrfs_init_work()
>      --> starts the worker
> 
>                                                         btrfs_qgroup_rescan_worker()
>                                                          mutex_lock(&fs_info->qgroup_rescan_lock)
> 
>                                                          fs_info->qgroup_flags &=
>                                                            ~BTRFS_QGROUP_STATUS_FLAG_RESCAN
> 
>                                                          mutex_unlock(&fs_info->qgroup_rescan_lock)
> 
>                                                          starts transaction, updates qgroup status
>                                                          item, etc
> 
>                                                                                                            btrfs_ioctl_quota_rescan()
>                                                                                                             btrfs_qgroup_rescan()
>                                                                                                              qgroup_rescan_init()
>                                                                                                               mutex_lock(&fs_info->qgroup_rescan_lock)
>                                                                                                               spin_lock(&fs_info->qgroup_lock)
> 
>                                                                                                               fs_info->qgroup_flags |=
>                                                                                                                 BTRFS_QGROUP_STATUS_FLAG_RESCAN
> 
>                                                                                                               init_completion(
>                                                                                                                 &fs_info->qgroup_rescan_completion)
> 
>                                                                                                               fs_info->qgroup_rescan_running = true
> 
>                                                                                                               mutex_unlock(&fs_info->qgroup_rescan_lock)
>                                                                                                               spin_unlock(&fs_info->qgroup_lock)
> 
>                                                                                                               btrfs_init_work()
>                                                                                                                --> starts another worker
> 
>                                                          mutex_lock(&fs_info->qgroup_rescan_lock)
> 
>                                                          fs_info->qgroup_rescan_running = false
> 
>                                                          mutex_unlock(&fs_info->qgroup_rescan_lock)
> 
> 							 complete_all(&fs_info->qgroup_rescan_completion)
> 
> Before the rescan worker started by the task at CPU 3 completes, if another
> task calls btrfs_ioctl_quota_rescan(), it will get -EINPROGRESS because the
> flag BTRFS_QGROUP_STATUS_FLAG_RESCAN is set at fs_info->qgroup_flags, which
> is expected and correct behaviour.
> 
> However if other task calls btrfs_ioctl_quota_rescan_wait() before the
> rescan worker started by the task at CPU 3 completes, it will return
> immediately without waiting for the new rescan worker to complete,
> because fs_info->qgroup_rescan_running is set to false by CPU 2.
> 
> This race is making test case btrfs/171 (from fstests) to fail often:
> 
>   btrfs/171 9s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/171.out.bad)
>       --- tests/btrfs/171.out     2018-09-16 21:30:48.505104287 +0100
>       +++ /home/fdmanana/git/hub/xfstests/results//btrfs/171.out.bad      2019-09-19 02:01:36.938486039 +0100
>       @@ -1,2 +1,3 @@
>        QA output created by 171
>       +ERROR: quota rescan failed: Operation now in progress
>        Silence is golden
>       ...
>       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/171.out /home/fdmanana/git/hub/xfstests/results//btrfs/171.out.bad'  to see the entire diff)
> 
> That is because the test calls the btrfs-progs commands "qgroup quota
> rescan -w", "qgroup assign" and "qgroup remove" in a sequence that makes
> calls to the rescan start ioctl fail with -EINPROGRESS (note the "btrfs"
> commands 'qgroup assign' and 'qgroup remove' often call the rescan start
> ioctl after calling the qgroup assign ioctl, btrfs_ioctl_qgroup_assign()),
> since previous waits didn't actually wait for a rescan worker to complete.
> 
> Another problem the race can cause is missing wake ups for waiters, since
> the call to complete_all() happens outside a critical section and after
> clearing the flag BTRFS_QGROUP_STATUS_FLAG_RESCAN. In the sequence diagram
> above, if we have a waiter for the first rescan task (executed by CPU 2),
> then fs_info->qgroup_rescan_completion.wait is not empty, and if after the
> rescan worker clears BTRFS_QGROUP_STATUS_FLAG_RESCAN and before it calls
> complete_all() against fs_info->qgroup_rescan_completion, the task at CPU 3
> calls init_completion() against fs_info->qgroup_rescan_completion which
> re-initilizes its wait queue to an empty queue, therefore causing the
> rescan worker at CPU 2 to call complete_all() against an empty queue, never
> waking up the task waiting for that rescan worker.
> 
> Fix this by clearing BTRFS_QGROUP_STATUS_FLAG_RESCAN and setting
> fs_info->qgroup_rescan_running to false in the same critical section,
> delimited by the mutex fs_info->qgroup_rescan_lock, as well as doing
> the call to complete_all() in that same critical section. This gives
> the protection needed to avoid rescan wait ioctl callers not waiting
> for a running rescan worker and the lost wake ups problem, since
> setting that rescan flag and boolean as well as initializing the wait
> queue is done already in a critical section delimited by that mutex
> (at qgroup_rescan_init()).
> 
> Fixes: 57254b6ebce4ce ("Btrfs: add ioctl to wait for qgroup rescan completion")
> Fixes: d2c609b834d62f ("btrfs: properly track when rescan worker is running")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/qgroup.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 8d3bd799ac7d..52701c1be109 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3166,9 +3166,6 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
>  	btrfs_free_path(path);
>  
>  	mutex_lock(&fs_info->qgroup_rescan_lock);
> -	if (!btrfs_fs_closing(fs_info))
> -		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> -

Can't we accomplish the same thing by just moving this down into the "done"
section below, and adding the complete_all under the qgruop_rescan_lock?  That
way avoid all this extra code?  Just delete the above and have 

done:
	mutex_lock(&fs_info->qgroup_rescan_lock);
	if (!btrfs_fs_closing(fs_info))
		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
	fs_info->qgroup_rescan_running = false;
	complete_all(&fs_info->qgroup_rescan_completion);
	mutex_unlock(&fs_info->qgroup_rescan_lock);

Or am I missing something?  I don't see a reason why update_qgroup_status_item()
needs to be done under the qgroup_rescan_lock.  Thanks,

Josef

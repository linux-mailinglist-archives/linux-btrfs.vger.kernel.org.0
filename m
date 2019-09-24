Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0066BCA68
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbfIXOjJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 10:39:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:45632 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbfIXOjI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 10:39:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 39192AC93;
        Tue, 24 Sep 2019 14:39:06 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F1918DA835; Tue, 24 Sep 2019 16:39:26 +0200 (CEST)
Date:   Tue, 24 Sep 2019 16:39:26 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Btrfs: fix race setting up and completing qgroup rescan
 workers
Message-ID: <20190924143926.GV2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <20190924094954.1304-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924094954.1304-1-fdmanana@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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

Added to misc-next, thanks.

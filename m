Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBDBBC9CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 16:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfIXOHF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 10:07:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:53852 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727005AbfIXOHF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 10:07:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D28D5AEC1;
        Tue, 24 Sep 2019 14:07:02 +0000 (UTC)
Subject: Re: [PATCH] Btrfs: fix race setting up and completing qgroup rescan
 workers
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20190924094954.1304-1-fdmanana@kernel.org>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a257514b-dd6a-ed01-f10b-3b198bf92aa7@suse.com>
Date:   Tue, 24 Sep 2019 17:07:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190924094954.1304-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24.09.19 г. 12:49 ч., fdmanana@kernel.org wrote:
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

Why do we need both the RESCAN flag and qgroup_rescan_running having
them both and having btrfs_qgroup_wait_for_completion rely on
qgroup[_rescan_running just makes it easier to screw up. IMO it makes
sense to remove qgroup_rescan_running in this patch as well and the code
should only use RESCAN flag.


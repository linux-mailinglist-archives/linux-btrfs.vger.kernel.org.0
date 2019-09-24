Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12DABBCA06
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 16:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441275AbfIXOTL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 10:19:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35630 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395526AbfIXOTL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 10:19:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id m15so2345463qtq.2
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Th93hwSj7XinqphnH5Rv6NLeTw9R2ID2MI+F/1AEmiI=;
        b=1eByxYZWlBn7Jm0/8Er0n7m2SvnpoopCAfySPITbjP3wMt3g4TOMggWdxMW0fi05y4
         z4yXhKCjLBf4/CcRCULu/UqW7nZGJXquK/yqqAuQ4Nnr1kK2gZU8X6FtsiQqiXc/MQDd
         mUBZoAWk8WSMmGScjaDftmGZ5C1Xc4gKZXq/ckhTtOXS/B+Q0li9n8eulNKN82xmMaGC
         UOo4a0WKTLl+1kiTm6oggcQisrFRktfjQVoF65nGj4eJb9I1uNGtIpsZJSksZHgPDy6k
         fvpqqx+JNrPrYkR5EbKmKhE8rZHqDxDgnHKzAz9phwZshbhTsCcFN9SmX0trhES/snaD
         sY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Th93hwSj7XinqphnH5Rv6NLeTw9R2ID2MI+F/1AEmiI=;
        b=IP1J0fq/wQ6nvDs3qhZd7GR2bzWZUNSqZTpDBWSBetYuAkXbI4+PZhddBFIjg65l1q
         gitzoGqDf8AUZoAxUArqXlF+W8JGoLgfQOZbGdZmmFn+5zDa5gFSCK5oRbtxfeYmm38C
         HUc7mibudK7VvskreTGjg6SeVSGH/4JODwGcx+LWWTykHdaAr58ZTu3WvUB4u/YlqOz7
         7gz8DNlXHXBwTFJoBR5zuUnJi1S82cvkpinFNf2Mb9nwzg6b0kFnso3NsVKfGYIjJD3M
         RflYgO+0KEfrnEFphng+6DYIERnXsPCeOPNtlCiRrXiAUUQcjVruqPv3hSTipvW6G25i
         2IYA==
X-Gm-Message-State: APjAAAVGcdB8yugA8lQpVUKBNnSnCcJIDWQmkdzQgYAmdIR4mbvmtYZ8
        JOK2eIu3Y0VvLDTVzAXw/t7KvA==
X-Google-Smtp-Source: APXvYqy9l3yvj2gGxz7VVJ0Zu5Cog5pd9fdTYv0FTOBRlM69+iiuAqPLM8uVY6PMLMmGzMc9iJtP7Q==
X-Received: by 2002:aed:3c27:: with SMTP id t36mr3115833qte.388.1569334748629;
        Tue, 24 Sep 2019 07:19:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::b7c9])
        by smtp.gmail.com with ESMTPSA id d55sm1458384qta.41.2019.09.24.07.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 07:19:07 -0700 (PDT)
Date:   Tue, 24 Sep 2019 10:19:06 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] Btrfs: fix race setting up and completing qgroup rescan
 workers
Message-ID: <20190924141905.ihfe4yvqgbmzxk7l@macbook-pro-91.dhcp.thefacebook.com>
References: <20190924094954.1304-1-fdmanana@kernel.org>
 <20190924135339.2we3mcdlc22sczhx@macbook-pro-91.dhcp.thefacebook.com>
 <CAL3q7H4=b3XLn_U35EtLK+1JV0VYjwau4nVSmT50LOwp9yczZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4=b3XLn_U35EtLK+1JV0VYjwau4nVSmT50LOwp9yczZw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 03:12:56PM +0100, Filipe Manana wrote:
> On Tue, Sep 24, 2019 at 2:53 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Tue, Sep 24, 2019 at 10:49:54AM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > There is a race between setting up a qgroup rescan worker and completing
> > > a qgroup rescan worker that can lead to callers of the qgroup rescan wait
> > > ioctl to either not wait for the rescan worker to complete or to hang
> > > forever due to missing wake ups. The following diagram shows a sequence
> > > of steps that illustrates the race.
> > >
> > >         CPU 1                                                         CPU 2                                  CPU 3
> > >
> > >  btrfs_ioctl_quota_rescan()
> > >   btrfs_qgroup_rescan()
> > >    qgroup_rescan_init()
> > >     mutex_lock(&fs_info->qgroup_rescan_lock)
> > >     spin_lock(&fs_info->qgroup_lock)
> > >
> > >     fs_info->qgroup_flags |=
> > >       BTRFS_QGROUP_STATUS_FLAG_RESCAN
> > >
> > >     init_completion(
> > >       &fs_info->qgroup_rescan_completion)
> > >
> > >     fs_info->qgroup_rescan_running = true
> > >
> > >     mutex_unlock(&fs_info->qgroup_rescan_lock)
> > >     spin_unlock(&fs_info->qgroup_lock)
> > >
> > >     btrfs_init_work()
> > >      --> starts the worker
> > >
> > >                                                         btrfs_qgroup_rescan_worker()
> > >                                                          mutex_lock(&fs_info->qgroup_rescan_lock)
> > >
> > >                                                          fs_info->qgroup_flags &=
> > >                                                            ~BTRFS_QGROUP_STATUS_FLAG_RESCAN
> > >
> > >                                                          mutex_unlock(&fs_info->qgroup_rescan_lock)
> > >
> > >                                                          starts transaction, updates qgroup status
> > >                                                          item, etc
> > >
> > >                                                                                                            btrfs_ioctl_quota_rescan()
> > >                                                                                                             btrfs_qgroup_rescan()
> > >                                                                                                              qgroup_rescan_init()
> > >                                                                                                               mutex_lock(&fs_info->qgroup_rescan_lock)
> > >                                                                                                               spin_lock(&fs_info->qgroup_lock)
> > >
> > >                                                                                                               fs_info->qgroup_flags |=
> > >                                                                                                                 BTRFS_QGROUP_STATUS_FLAG_RESCAN
> > >
> > >                                                                                                               init_completion(
> > >                                                                                                                 &fs_info->qgroup_rescan_completion)
> > >
> > >                                                                                                               fs_info->qgroup_rescan_running = true
> > >
> > >                                                                                                               mutex_unlock(&fs_info->qgroup_rescan_lock)
> > >                                                                                                               spin_unlock(&fs_info->qgroup_lock)
> > >
> > >                                                                                                               btrfs_init_work()
> > >                                                                                                                --> starts another worker
> > >
> > >                                                          mutex_lock(&fs_info->qgroup_rescan_lock)
> > >
> > >                                                          fs_info->qgroup_rescan_running = false
> > >
> > >                                                          mutex_unlock(&fs_info->qgroup_rescan_lock)
> > >
> > >                                                        complete_all(&fs_info->qgroup_rescan_completion)
> > >
> > > Before the rescan worker started by the task at CPU 3 completes, if another
> > > task calls btrfs_ioctl_quota_rescan(), it will get -EINPROGRESS because the
> > > flag BTRFS_QGROUP_STATUS_FLAG_RESCAN is set at fs_info->qgroup_flags, which
> > > is expected and correct behaviour.
> > >
> > > However if other task calls btrfs_ioctl_quota_rescan_wait() before the
> > > rescan worker started by the task at CPU 3 completes, it will return
> > > immediately without waiting for the new rescan worker to complete,
> > > because fs_info->qgroup_rescan_running is set to false by CPU 2.
> > >
> > > This race is making test case btrfs/171 (from fstests) to fail often:
> > >
> > >   btrfs/171 9s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/171.out.bad)
> > >       --- tests/btrfs/171.out     2018-09-16 21:30:48.505104287 +0100
> > >       +++ /home/fdmanana/git/hub/xfstests/results//btrfs/171.out.bad      2019-09-19 02:01:36.938486039 +0100
> > >       @@ -1,2 +1,3 @@
> > >        QA output created by 171
> > >       +ERROR: quota rescan failed: Operation now in progress
> > >        Silence is golden
> > >       ...
> > >       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/171.out /home/fdmanana/git/hub/xfstests/results//btrfs/171.out.bad'  to see the entire diff)
> > >
> > > That is because the test calls the btrfs-progs commands "qgroup quota
> > > rescan -w", "qgroup assign" and "qgroup remove" in a sequence that makes
> > > calls to the rescan start ioctl fail with -EINPROGRESS (note the "btrfs"
> > > commands 'qgroup assign' and 'qgroup remove' often call the rescan start
> > > ioctl after calling the qgroup assign ioctl, btrfs_ioctl_qgroup_assign()),
> > > since previous waits didn't actually wait for a rescan worker to complete.
> > >
> > > Another problem the race can cause is missing wake ups for waiters, since
> > > the call to complete_all() happens outside a critical section and after
> > > clearing the flag BTRFS_QGROUP_STATUS_FLAG_RESCAN. In the sequence diagram
> > > above, if we have a waiter for the first rescan task (executed by CPU 2),
> > > then fs_info->qgroup_rescan_completion.wait is not empty, and if after the
> > > rescan worker clears BTRFS_QGROUP_STATUS_FLAG_RESCAN and before it calls
> > > complete_all() against fs_info->qgroup_rescan_completion, the task at CPU 3
> > > calls init_completion() against fs_info->qgroup_rescan_completion which
> > > re-initilizes its wait queue to an empty queue, therefore causing the
> > > rescan worker at CPU 2 to call complete_all() against an empty queue, never
> > > waking up the task waiting for that rescan worker.
> > >
> > > Fix this by clearing BTRFS_QGROUP_STATUS_FLAG_RESCAN and setting
> > > fs_info->qgroup_rescan_running to false in the same critical section,
> > > delimited by the mutex fs_info->qgroup_rescan_lock, as well as doing
> > > the call to complete_all() in that same critical section. This gives
> > > the protection needed to avoid rescan wait ioctl callers not waiting
> > > for a running rescan worker and the lost wake ups problem, since
> > > setting that rescan flag and boolean as well as initializing the wait
> > > queue is done already in a critical section delimited by that mutex
> > > (at qgroup_rescan_init()).
> > >
> > > Fixes: 57254b6ebce4ce ("Btrfs: add ioctl to wait for qgroup rescan completion")
> > > Fixes: d2c609b834d62f ("btrfs: properly track when rescan worker is running")
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  fs/btrfs/qgroup.c | 33 +++++++++++++++++++--------------
> > >  1 file changed, 19 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > > index 8d3bd799ac7d..52701c1be109 100644
> > > --- a/fs/btrfs/qgroup.c
> > > +++ b/fs/btrfs/qgroup.c
> > > @@ -3166,9 +3166,6 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
> > >       btrfs_free_path(path);
> > >
> > >       mutex_lock(&fs_info->qgroup_rescan_lock);
> > > -     if (!btrfs_fs_closing(fs_info))
> > > -             fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> > > -
> >
> > Can't we accomplish the same thing by just moving this down into the "done"
> > section below, and adding the complete_all under the qgruop_rescan_lock?  That
> > way avoid all this extra code?  Just delete the above and have
> >
> > done:
> >         mutex_lock(&fs_info->qgroup_rescan_lock);
> >         if (!btrfs_fs_closing(fs_info))
> >                 fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> >         fs_info->qgroup_rescan_running = false;
> >         complete_all(&fs_info->qgroup_rescan_completion);
> >         mutex_unlock(&fs_info->qgroup_rescan_lock);
> >
> > Or am I missing something?  I don't see a reason why update_qgroup_status_item()
> > needs to be done under the qgroup_rescan_lock.  Thanks,
> 
> Clearing the flag must be done before update the status item,
> otherwise commands like btrfs-progs 'qgroup show' will
> think the qgroups may be consistent and print a warning (since they
> scan the tree and inspect the status item).
> 

Ahhh ok, thanks,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

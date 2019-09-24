Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0F1DBC9F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 16:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441246AbfIXOOs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 10:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfIXOOs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 10:14:48 -0400
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA3A12064A
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 14:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569334487;
        bh=TO1cIkv3Q+4sFFHPkfElmNY8JE3NGNmQvQA35PGvxsg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zW7vLih/Cz21hU5UoPdlN6jux42Il5j7ziEOL40G0y+YL/zjbGLz2lGfSrh1OAeWp
         nnxxjSue1wJOxn3f8d4L3xgXZwFB2LKAFd9b/BEsOMRqX6FpAXJdVXKWludXGN6SdE
         QY+guUTJMTwW0fD/n2RKZ+0GevJlxdrQF+1X1yU0=
Received: by mail-vk1-f170.google.com with SMTP id s196so426305vkb.9
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 07:14:46 -0700 (PDT)
X-Gm-Message-State: APjAAAXYgEXnmUIhUNoLiJ99ycNIvyyQvEf8jA2hM3oSwO6POXQ3W+QQ
        JC+vuLKUDfOjTtpvTAgvTtAnsWDfyL/kKo6Edyk=
X-Google-Smtp-Source: APXvYqynYEqrNCWKCUywESiJxW0WtAzZmpqMSEsepjHYyrW04oCZ8P9sKC/VgyYjhr0JOt+CF3x3aO+GvI5zFUcyxco=
X-Received: by 2002:a1f:6681:: with SMTP id a123mr1574052vkc.81.1569334485982;
 Tue, 24 Sep 2019 07:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190924094954.1304-1-fdmanana@kernel.org> <a257514b-dd6a-ed01-f10b-3b198bf92aa7@suse.com>
In-Reply-To: <a257514b-dd6a-ed01-f10b-3b198bf92aa7@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 24 Sep 2019 15:14:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6wSfuTeKAe8npoSG950ix7YBR=mK7WD4SdsC9mBUWaww@mail.gmail.com>
Message-ID: <CAL3q7H6wSfuTeKAe8npoSG950ix7YBR=mK7WD4SdsC9mBUWaww@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: fix race setting up and completing qgroup rescan workers
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 3:07 PM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> On 24.09.19 =D0=B3. 12:49 =D1=87., fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > There is a race between setting up a qgroup rescan worker and completin=
g
> > a qgroup rescan worker that can lead to callers of the qgroup rescan wa=
it
> > ioctl to either not wait for the rescan worker to complete or to hang
> > forever due to missing wake ups. The following diagram shows a sequence
> > of steps that illustrates the race.
> >
> >         CPU 1                                                         C=
PU 2                                  CPU 3
> >
> >  btrfs_ioctl_quota_rescan()
> >   btrfs_qgroup_rescan()
> >    qgroup_rescan_init()
> >     mutex_lock(&fs_info->qgroup_rescan_lock)
> >     spin_lock(&fs_info->qgroup_lock)
> >
> >     fs_info->qgroup_flags |=3D
> >       BTRFS_QGROUP_STATUS_FLAG_RESCAN
> >
> >     init_completion(
> >       &fs_info->qgroup_rescan_completion)
> >
> >     fs_info->qgroup_rescan_running =3D true
> >
> >     mutex_unlock(&fs_info->qgroup_rescan_lock)
> >     spin_unlock(&fs_info->qgroup_lock)
> >
> >     btrfs_init_work()
> >      --> starts the worker
> >
> >                                                         btrfs_qgroup_re=
scan_worker()
> >                                                          mutex_lock(&fs=
_info->qgroup_rescan_lock)
> >
> >                                                          fs_info->qgrou=
p_flags &=3D
> >                                                            ~BTRFS_QGROU=
P_STATUS_FLAG_RESCAN
> >
> >                                                          mutex_unlock(&=
fs_info->qgroup_rescan_lock)
> >
> >                                                          starts transac=
tion, updates qgroup status
> >                                                          item, etc
> >
> >                                                                        =
                                    btrfs_ioctl_quota_rescan()
> >                                                                        =
                                     btrfs_qgroup_rescan()
> >                                                                        =
                                      qgroup_rescan_init()
> >                                                                        =
                                       mutex_lock(&fs_info->qgroup_rescan_l=
ock)
> >                                                                        =
                                       spin_lock(&fs_info->qgroup_lock)
> >
> >                                                                        =
                                       fs_info->qgroup_flags |=3D
> >                                                                        =
                                         BTRFS_QGROUP_STATUS_FLAG_RESCAN
> >
> >                                                                        =
                                       init_completion(
> >                                                                        =
                                         &fs_info->qgroup_rescan_completion=
)
> >
> >                                                                        =
                                       fs_info->qgroup_rescan_running =3D t=
rue
> >
> >                                                                        =
                                       mutex_unlock(&fs_info->qgroup_rescan=
_lock)
> >                                                                        =
                                       spin_unlock(&fs_info->qgroup_lock)
> >
> >                                                                        =
                                       btrfs_init_work()
> >                                                                        =
                                        --> starts another worker
> >
> >                                                          mutex_lock(&fs=
_info->qgroup_rescan_lock)
> >
> >                                                          fs_info->qgrou=
p_rescan_running =3D false
> >
> >                                                          mutex_unlock(&=
fs_info->qgroup_rescan_lock)
> >
> >                                                        complete_all(&fs=
_info->qgroup_rescan_completion)
> >
> > Before the rescan worker started by the task at CPU 3 completes, if ano=
ther
> > task calls btrfs_ioctl_quota_rescan(), it will get -EINPROGRESS because=
 the
> > flag BTRFS_QGROUP_STATUS_FLAG_RESCAN is set at fs_info->qgroup_flags, w=
hich
> > is expected and correct behaviour.
> >
> > However if other task calls btrfs_ioctl_quota_rescan_wait() before the
> > rescan worker started by the task at CPU 3 completes, it will return
> > immediately without waiting for the new rescan worker to complete,
> > because fs_info->qgroup_rescan_running is set to false by CPU 2.
> >
> > This race is making test case btrfs/171 (from fstests) to fail often:
> >
> >   btrfs/171 9s ... - output mismatch (see /home/fdmanana/git/hub/xfstes=
ts/results//btrfs/171.out.bad)
> >       --- tests/btrfs/171.out     2018-09-16 21:30:48.505104287 +0100
> >       +++ /home/fdmanana/git/hub/xfstests/results//btrfs/171.out.bad   =
   2019-09-19 02:01:36.938486039 +0100
> >       @@ -1,2 +1,3 @@
> >        QA output created by 171
> >       +ERROR: quota rescan failed: Operation now in progress
> >        Silence is golden
> >       ...
> >       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/171.out=
 /home/fdmanana/git/hub/xfstests/results//btrfs/171.out.bad'  to see the en=
tire diff)
> >
> > That is because the test calls the btrfs-progs commands "qgroup quota
> > rescan -w", "qgroup assign" and "qgroup remove" in a sequence that make=
s
> > calls to the rescan start ioctl fail with -EINPROGRESS (note the "btrfs=
"
> > commands 'qgroup assign' and 'qgroup remove' often call the rescan star=
t
> > ioctl after calling the qgroup assign ioctl, btrfs_ioctl_qgroup_assign(=
)),
> > since previous waits didn't actually wait for a rescan worker to comple=
te.
> >
> > Another problem the race can cause is missing wake ups for waiters, sin=
ce
> > the call to complete_all() happens outside a critical section and after
> > clearing the flag BTRFS_QGROUP_STATUS_FLAG_RESCAN. In the sequence diag=
ram
> > above, if we have a waiter for the first rescan task (executed by CPU 2=
),
> > then fs_info->qgroup_rescan_completion.wait is not empty, and if after =
the
> > rescan worker clears BTRFS_QGROUP_STATUS_FLAG_RESCAN and before it call=
s
> > complete_all() against fs_info->qgroup_rescan_completion, the task at C=
PU 3
> > calls init_completion() against fs_info->qgroup_rescan_completion which
> > re-initilizes its wait queue to an empty queue, therefore causing the
> > rescan worker at CPU 2 to call complete_all() against an empty queue, n=
ever
> > waking up the task waiting for that rescan worker.
> >
> > Fix this by clearing BTRFS_QGROUP_STATUS_FLAG_RESCAN and setting
> > fs_info->qgroup_rescan_running to false in the same critical section,
> > delimited by the mutex fs_info->qgroup_rescan_lock, as well as doing
>
> Why do we need both the RESCAN flag and qgroup_rescan_running having
> them both and having btrfs_qgroup_wait_for_completion rely on
> qgroup[_rescan_running just makes it easier to screw up. IMO it makes
> sense to remove qgroup_rescan_running in this patch as well and the code
> should only use RESCAN flag.

No, they are both needed. Otherwise the issue fixed by the commit
mentioned in the second "Fixes:" tag is re-introduced.

>

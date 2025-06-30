Return-Path: <linux-btrfs+bounces-15119-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD18AEE509
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 18:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3731C166518
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 16:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4605290DB2;
	Mon, 30 Jun 2025 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piJ250dI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B9E28CF5C
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751302447; cv=none; b=Qk7kpbadf7z8PaMirklbmeAXnq3qhRHGcPbGxpFZSt2oSHJfTx6MOpkx+jmdREkGI5e9Hy0/GblB+LrnVDjhEzUP5CZbiFGY3IMzQvJRvqfPLUTifSrLfK/7mTQvW/5W0D+KaZiR0gClpGTxlE4NEq09psogVb/UXiJEI3g1PZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751302447; c=relaxed/simple;
	bh=uBaj65g979G14vNGqe3S6E69vn4gPXWbbnP20DLnM/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsNqBFseRptCzJVa1LxDLryt40bXPHdm3WDTvUpwaZqMwjIb9xI9lSEwcMJLetVGvCL5yJF/uPLFrEC0bNlTa/14/9BP6P4wOd3Y4wQUqQy9itf/mczccSQV8DO4Xi9AuyFOmoSxWMjpLA1jIew/yAy39evKVLf98AOdZ8poFIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piJ250dI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B389EC4CEE3
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 16:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751302446;
	bh=uBaj65g979G14vNGqe3S6E69vn4gPXWbbnP20DLnM/A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=piJ250dIpEsoU7Ntq+r+COTbl3xXdu6WtYPM6wUzpLYFWZLiU0I81v0NkZtVYkaBW
	 zOt+IrWRQB/NZqL522S8Q2ydkZ05fUYQtsS+bv5s5sCMgsoeBlYXcb2v1An956hNLE
	 pypqcfoZhxqWYk89Du8pkkVqDmnJlbF0nDVghOYId32ul3X6SPSuO5fCdBYEsMjpJH
	 cA1V6Mf9IxaysAZtgnXMiobpOTYctPVeYENhH3RDZGw962JWv3EO8vVjohWHXo1V29
	 lgdgGK8Zx4EBx9uCTtiPdSE2HVZMUk3zDMObOyufnucQVe/NZCim+asqIVZpBYN+nM
	 gRliKlZFsqIpQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c60f7eeaaso7943900a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 09:54:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YwuTbySEcfZDhmgGWP3OdtHZFS2oQoLvB8LLCCsI7zK9sJ3+9R3
	r8BqU85nLndd3+jRvlHSwq8djH5lSdsTB8ChPgbFRhjdDdFiRzjXm6u+HddwFsbZxO48q2w11yz
	v0bBiZU3juidIgjD7lLDuC7mP3DzcKUU=
X-Google-Smtp-Source: AGHT+IES/aRwxMTEmdRlff1L7FnlM/tECDetspxLDvQ5o6eHQmsm/D+L+5zU23IHtkUQjKL0pwYs90uguszDLB8QP30=
X-Received: by 2002:a17:907:3cc2:b0:ae0:a88f:61fa with SMTP id
 a640c23a62f3a-ae3500f8663mr1399674866b.28.1751302445161; Mon, 30 Jun 2025
 09:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751288689.git.fdmanana@suse.com> <19f775a9f256c4a5146cc97b7f521464429c81bc.1751288689.git.fdmanana@suse.com>
 <20250630163242.GA61133@zen.localdomain>
In-Reply-To: <20250630163242.GA61133@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 30 Jun 2025 17:53:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4g-WNhksrGXT+hsYhHfvize9hdWJa8v4Er3F83Lkb55A@mail.gmail.com>
X-Gm-Features: Ac12FXwc4DkKJZ4621N2AmAluPZNIpcmG8TOGPB42bg4QmXxzw67U08POHYJnQ4
Message-ID: <CAL3q7H4g-WNhksrGXT+hsYhHfvize9hdWJa8v4Er3F83Lkb55A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] btrfs: qgroup: fix race between quota disable and
 quota rescan ioctl
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 5:31=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Mon, Jun 30, 2025 at 02:07:47PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > There's a race between a task disabling quotas and another running the
> > rescan ioctl that can result in a use-after-free of qgroup records from
> > the fs_info->qgroup_tree rbtree.
> >
> > This happens as follows:
> >
> > 1) Task A enters btrfs_ioctl_quota_rescan() -> btrfs_qgroup_rescan();
> >
> > 2) Task B enters btrfs_quota_disable() and calls
> >    btrfs_qgroup_wait_for_completion(), which does nothing because at th=
at
> >    point fs_info->qgroup_rescan_running is false (it wasn't set yet by
> >    task A);
> >
> > 3) Task B calls btrfs_free_qgroup_config() which starts freeing qgroups
> >    from fs_info->qgroup_tree without taking the lock fs_info->qgroup_lo=
ck;
> >
> > 4) Task A enters qgroup_rescan_zero_tracking() which starts iterating
> >    the fs_info->qgroup_tree tree while holding fs_info->qgroup_lock,
> >    but task B is freeing qgroup records from that tree without holding
> >    the lock, resulting in a use-after-free.
> >
> > Fix this by taking fs_info->qgroup_lock at btrfs_free_qgroup_config().
> > Also at btrfs_qgroup_rescan() don't start the rescan worker if quotas
> > were already disabled.
> >
> > Reported-by: cen zhang <zzzccc427@gmail.com>
> > Link: https://lore.kernel.org/linux-btrfs/CAFRLqsV+cMDETFuzqdKSHk_FDm6t=
neea45krsHqPD6B3FetLpQ@mail.gmail.com/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Boris Burkov <boris@bur.io>
>
> > ---
> >  fs/btrfs/qgroup.c | 26 +++++++++++++++++++-------
> >  1 file changed, 19 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index b83d9534adae..8fa874ef80b3 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -636,22 +636,30 @@ bool btrfs_check_quota_leak(const struct btrfs_fs=
_info *fs_info)
> >
> >  /*
> >   * This is called from close_ctree() or open_ctree() or btrfs_quota_di=
sable(),
> > - * first two are in single-threaded paths.And for the third one, we ha=
ve set
> > - * quota_root to be null with qgroup_lock held before, so it is safe t=
o clean
> > - * up the in-memory structures without qgroup_lock held.
> > + * first two are in single-threaded paths.
> >   */
> >  void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
> >  {
> >       struct rb_node *n;
> >       struct btrfs_qgroup *qgroup;
> >
> > +     /*
> > +      * btrfs_quota_disable() can be called concurrently with
> > +      * btrfs_qgroup_rescan() -> qgroup_rescan_zero_tracking(), so tak=
e the
> > +      * lock.
> > +      */
> > +     spin_lock(&fs_info->qgroup_lock);
> >       while ((n =3D rb_first(&fs_info->qgroup_tree))) {
> >               qgroup =3D rb_entry(n, struct btrfs_qgroup, node);
> >               rb_erase(n, &fs_info->qgroup_tree);
> >               __del_qgroup_rb(qgroup);
> > +             spin_unlock(&fs_info->qgroup_lock);
> >               btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
> >               kfree(qgroup);
> > +             spin_lock(&fs_info->qgroup_lock);
> >       }
> > +     spin_unlock(&fs_info->qgroup_lock);
> > +
> >       /*
> >        * We call btrfs_free_qgroup_config() when unmounting
> >        * filesystem and disabling quota, so we set qgroup_ulist
> > @@ -4036,12 +4044,16 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_in=
fo)
> >       qgroup_rescan_zero_tracking(fs_info);
> >
> >       mutex_lock(&fs_info->qgroup_rescan_lock);
> > -     fs_info->qgroup_rescan_running =3D true;
> > -     btrfs_queue_work(fs_info->qgroup_rescan_workers,
> > -                      &fs_info->qgroup_rescan_work);
> > +     if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
>
> could this be one of the helpers like !btrfs_qgroup_enabled() or maybe
> even better !btrfs_qgroup_full_accounting()?

Yes, that's fine. I'll update to that when pushing to for-next:

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 98a53e6edb2c..5f1b4990f56f 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -4015,7 +4015,12 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
        qgroup_rescan_zero_tracking(fs_info);

        mutex_lock(&fs_info->qgroup_rescan_lock);
-       if (test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags)) {
+       /*
+        * The rescan worker is only for full accounting qgroups, check if =
it's
+        * enabled as it is pointless to queue it otherwise. A concurrent q=
uota
+        * disable may also have just cleared BTRFS_FS_QUOTA_ENABLED.
+        */
+       if (btrfs_qgroup_full_accounting(fs_info)) {
                fs_info->qgroup_rescan_running =3D true;
                btrfs_queue_work(fs_info->qgroup_rescan_workers,
                                 &fs_info->qgroup_rescan_work);


Thanks.

>
> > +             fs_info->qgroup_rescan_running =3D true;
> > +             btrfs_queue_work(fs_info->qgroup_rescan_workers,
> > +                              &fs_info->qgroup_rescan_work);
> > +     } else {
> > +             ret =3D -ENOTCONN;
> > +     }
> >       mutex_unlock(&fs_info->qgroup_rescan_lock);
> >
> > -     return 0;
> > +     return ret;
> >  }
> >
> >  int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
> > --
> > 2.47.2
> >


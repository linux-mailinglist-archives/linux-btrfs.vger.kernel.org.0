Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B48A2DD837
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 19:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgLQSWr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 13:22:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbgLQSWr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 13:22:47 -0500
X-Gm-Message-State: AOAM533FK/HoAIIyvbl84Dz9suWcKgEySLlt6rNo/x7KBvtnJq9z8RYO
        USa6H5zcOI9RF+ySM9+LFe1A5UhOKjBPiHD8p3c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608229326;
        bh=pmPnFhGInMDISAg+AivaRlXmIdM3BAhnxdXZFk+sAlk=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=q/2drk9Wgc9pVOSJJhbSpTbNBV+T7Neplfs/mEF3yI79daJ07zLnWC2EvwkBuPZlq
         XRDWurKhxjkOnCzD53zq08/bSRwbMbnD+dADIRB5MWCtxb6M/2lTeSFQAPFN3gHjBt
         EkfBHplDEKyLs9fRQc3087Q5Asej+wBG39N6smGIZReMLHYMAz6ba2bMv4mxdgI3IE
         sN7u3QpDHXCdI80RO9qJH71ahvo0TpNA3B8Mu/vLaUWxLTCMLCheY19NEYhMWiAUgA
         S0nR2CG99W2fjROVGSbrqv75k715rDDJd8xIkt14PVcXPQeycQwSA9ekg6oEykOuuq
         YXrmxYOuTV9SA==
X-Google-Smtp-Source: ABdhPJxWmdA3SH55EHqPeFbYIkpIh7G7gaC1tzWhO0Q/ItpUeK0Jb0OKG0IQDQQP2N7xsHE27gNGivZMb21hvupJ7c0=
X-Received: by 2002:ae9:e8c5:: with SMTP id a188mr510305qkg.479.1608229326047;
 Thu, 17 Dec 2020 10:22:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1607940240.git.fdmanana@suse.com> <21e034b59ba97c7f39086e77e08250dcad172717.1607940240.git.fdmanana@suse.com>
 <20201217174403.GW6430@twin.jikos.cz>
In-Reply-To: <20201217174403.GW6430@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 17 Dec 2020 18:21:55 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6uX5UbHba7r9G60wqOZozC1EOaq-OB1Tw3_JUTuYb0zw@mail.gmail.com>
Message-ID: <CAL3q7H6uX5UbHba7r9G60wqOZozC1EOaq-OB1Tw3_JUTuYb0zw@mail.gmail.com>
Subject: Re: [PATCH 1/5] btrfs: fix transaction leak and crash after RO
 remount caused by qgroup rescan
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 17, 2020 at 5:45 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Dec 14, 2020 at 10:10:45AM +0000, fdmanana@kernel.org wrote:
> > +static bool rescan_should_stop(struct btrfs_fs_info *fs_info)
> > +{
> > +     return btrfs_fs_closing(fs_info) ||
> > +             test_bit(BTRFS_FS_STATE_REMOUNTING, &fs_info->fs_state);
> > +}
> > +
> >  static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
> >  {
> >       struct btrfs_fs_info *fs_info = container_of(work, struct btrfs_fs_info,
> > @@ -3198,6 +3204,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
> >       struct btrfs_trans_handle *trans = NULL;
> >       int err = -ENOMEM;
> >       int ret = 0;
> > +     bool stopped = false;
> >
> >       path = btrfs_alloc_path();
> >       if (!path)
> > @@ -3210,7 +3217,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
> >       path->skip_locking = 1;
> >
> >       err = 0;
> > -     while (!err && !btrfs_fs_closing(fs_info)) {
> > +     while (!err && !(stopped = rescan_should_stop(fs_info))) {
> >               trans = btrfs_start_transaction(fs_info->fs_root, 0);
> >               if (IS_ERR(trans)) {
> >                       err = PTR_ERR(trans);
> > @@ -3253,7 +3260,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
> >       }
> >
> >       mutex_lock(&fs_info->qgroup_rescan_lock);
> > -     if (!btrfs_fs_closing(fs_info))
> > +     if (!stopped)
> >               fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
> >       if (trans) {
> >               ret = update_qgroup_status_item(trans);
> > @@ -3272,7 +3279,7 @@ static void btrfs_qgroup_rescan_worker(struct btrfs_work *work)
> >
> >       btrfs_end_transaction(trans);
> >
> > -     if (btrfs_fs_closing(fs_info)) {
> > +     if (stopped) {
>
> Thinking aloud, this is slightly different as it uses the cached status
> of fs_closing but there is mutex lock/unlock or transaction start/end
> between the checks so the status could change.
>
> But as the flow goes, we want to get fresh status in the while loop.
> Once it stops because of the fs_closing or remount request, the
> following code does the qgroup status update, wakeups, even tough this
> means one more transaction. Remount needs to sync anyway and this should
> be no problem.

Yes, that and the fact that the rescan calls
complete_all(&fs_info->qgroup_rescan_completion) before it logs the
reason why it finished.

So it would be possible for remount to stop it, then remount
completes, and then the rescan worker logs that an error happened
instead of logging that it was stopped - it's a very big stretch for
that to happen, but an error message would be confusing from a user's
perspective at least.

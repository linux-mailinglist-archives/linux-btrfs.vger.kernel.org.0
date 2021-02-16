Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851C831CC4A
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 15:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhBPOmx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 09:42:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhBPOmf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 09:42:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4F6264E02
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 14:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613486515;
        bh=itnIz3sjHP/DZGz2W2DM6QkhAXFVXZlL+hEn8fkP600=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=Pn1LEZcBY6yn4CmfXWswukc0w15a3cB/pyXwgKwiVgImR7F2VfASOyDvWvJIFYHkE
         m+S1Mp91CBwJwkPsYaqHmLY51fn858ER0eWDQEs5yV61HEtn49xpQczEXR4kh/kTPp
         9JsJSQnc74SCpLymrR+Q6K1tE7l4fmsDv9WefA7X6aT/Bl7aWPQ+Pp7bqtz+uFFnVJ
         WYkcIak5QYOfyySDxVsxgBHX7BLUPVs3CnARVdrIniy9ZBsTnxqZtNk0HTsVRIzalh
         0nrv79Z9fiJW3chZ96eomhdQ+4Dd2MHcLvfXwxGUtnIUeWKxoEtXA5Wiq9jXhKC/+F
         HymNYGKDHj8Kg==
Received: by mail-qk1-f178.google.com with SMTP id w19so9496346qki.13
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 06:41:54 -0800 (PST)
X-Gm-Message-State: AOAM530Hqm6io0XE64KKdjGleJhOMKVN8cRL3iolQwwztTVQvaBoTmeG
        V9+W0YtqGBlRTCDnDYUfEQLDytj0Zq3sOVceThc=
X-Google-Smtp-Source: ABdhPJwKM/KbjET2EE2+kS6CaUUTCUi2L0M2Ln4B8qxWzQ+TCyZbbDCBYlr/bvIvHkisl8nyusT0fTeS1Se7f2uKO24=
X-Received: by 2002:a37:65d8:: with SMTP id z207mr19620201qkb.479.1613486514096;
 Tue, 16 Feb 2021 06:41:54 -0800 (PST)
MIME-Version: 1.0
References: <94663c8a2172dc96b760d356a538d45c36f46040.1613062764.git.fdmanana@suse.com>
 <20210213090416.926A.409509F4@e16-tech.com> <CAL3q7H45VddXz+OVcFG8uDM2WJJsdCn0VuTVfJAb28HzU78J6w@mail.gmail.com>
 <20210216142324.GO1993@twin.jikos.cz>
In-Reply-To: <20210216142324.GO1993@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 16 Feb 2021 14:41:43 +0000
X-Gmail-Original-Message-ID: <CAL3q7H562aEiLRGTZKQdSRpaf8oAnLCN6yfitTomaOfMVKmKLw@mail.gmail.com>
Message-ID: <CAL3q7H562aEiLRGTZKQdSRpaf8oAnLCN6yfitTomaOfMVKmKLw@mail.gmail.com>
Subject: Re: [PATCH 5.10.x] btrfs: fix crash after non-aligned direct IO write
 with O_DSYNC
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Feb 16, 2021 at 2:25 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Feb 15, 2021 at 11:05:33AM +0000, Filipe Manana wrote:
> > On Sat, Feb 13, 2021 at 1:07 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
> > > > This bug only affects 5.10 kernels, and the regression was introduced in
> > > > 5.10-rc1 by commit 0eb79294dbe328 ("btrfs: dio iomap DSYNC workaround").
> > > > The bug does not exist in 5.11 kernels due to commit ecfdc08b8cc65d
> > > > ("btrfs: remove dio iomap DSYNC workaround"), which depends on other
> > > > changes that went into the merge window for 5.11. So this is a fix only
> > > > for 5.10.x stable kernels, as there are people hitting this.
> > >
> > > It is OK too to backport commit ecfdc08b8cc65d
> > >  ("btrfs: remove dio iomap DSYNC workaround") to 5.10 for this problem?
> > >
> > > the iomap issue for commit 0eb79294dbe328 ("btrfs: dio iomap DSYNC workaround")
> > > is already fixed in 5.10?
> >
> > Quoting the changelog:
> >
> > "commit ecfdc08b8cc65d
> > ("btrfs: remove dio iomap DSYNC workaround"), which depends on other
> > changes that went into the merge window for 5.11."
> >
> > All the changes, are (at least):
> >
> > commit ecfdc08b8cc65d737eebc26a1ee1875a097fd6a0   --> 5.11-rc1
> > Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Date:   Thu Sep 24 11:39:21 2020 -0500
> >
> >     btrfs: remove dio iomap DSYNC workaround
> >
> > commit a42fa643169d2325602572633fcaa16862990e28
> > Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Date:   Thu Sep 24 11:39:20 2020 -0500
> >
> >     btrfs: call iomap_dio_complete() without inode_lock
> >
> > commit 502756b380938022c848761837f8fa3976906aa1
> > Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Date:   Thu Sep 24 11:39:19 2020 -0500
> >
> >     btrfs: remove btrfs_inode::dio_sem
> >
> > commit e9adabb9712ef9424cbbeeaa027d962ab5262e19
> > Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Date:   Thu Sep 24 11:39:18 2020 -0500
> >
> >     btrfs: use shared lock for direct writes within EOF
> >
> > commit c352370633400d13765cc88080c969799ea51108
> > Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Date:   Thu Sep 24 11:39:17 2020 -0500
> >
> >     btrfs: push inode locking and unlocking into buffered/direct write
> >
> > commit a14b78ad06aba0fa7e76d2bc13c5ba581a7f331a
> > Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Date:   Thu Sep 24 11:39:16 2020 -0500
> >
> >     btrfs: introduce btrfs_inode_lock()/unlock()
> >
> > commit b8d8e1fd570a194904f545b135efc880d96a41a4
> > Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Date:   Thu Sep 24 11:39:15 2020 -0500
> >
> >     btrfs: introduce btrfs_write_check()
> >
> > That's probably too much to add to stable at once, plus I'm assuming
> > all required iomap dependencies are in 5.10 already (it seems so,
> > unless I missed something).
> >
> > Usually we don't add patches to stable that didn't go through Linus'
> > tree either (there were 1 or 2 very rare exceptions in the past I
> > think), but when a backport depends on so many patches, and not all
> > from the same patchset, the risk of getting something wrong is
> > significant. That's why I opted to send this patch, which is much more
> > simple.
>
> Agreed, in this case the backport would be too big, just the diffstat
> between b8d8e1fd570^..ecfdc08b8cc6 is
>
>  5 files changed, 213 insertions(+), 240 deletions(-)
>
> This fix is minimal and suitable for stable as an exception. You did not
> CC stable@vger.kernel.org so you'll need to send it again. Please CC me
> too in case there are some questions from stable team. Thanks.

Ah yes, my usual script to send patches suppresses all cc by default,
I missed that.
Ok, sent again. Thanks.

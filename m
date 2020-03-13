Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C32184567
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 12:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgCMLBs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 07:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgCMLBs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 07:01:48 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65E1420746
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 11:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584097307;
        bh=lckVNZIsNC5bNXXtHYBIAc43LYKljUOCMhn3isM8UbA=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=xQqVhU8bSid3Pobezb7GGCU8ZEenIoSL0Yxg1pB3EozRd7ZOsJlGIYEDzHMYRUxo4
         egjw7K7X7jiY7mFl2OUkn/ZW5NnPCgsMyky0X4nkXRc4gtGls00puxpI3Cq7WTW70V
         GzYoKvegWTFgJ/q+YlRKx0f/S/aPpxdOkJ7O9pIc=
Received: by mail-ua1-f48.google.com with SMTP id o16so3349076uap.6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Mar 2020 04:01:47 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0SsnW3faBlbHq/BnanS7EdDYS06FUrgxasVUhIXPSis0YdZyzC
        UZ8+IaWsX2xXeUZI1snOdPe43xyxy1N3UbRFNmE=
X-Google-Smtp-Source: ADFU+vuoAlrP1CNdWfANiHYvzQwsfl1xTM3JZKDn3zmYsOsYGHJv+6aMW1SwNvzHKW3SR9lqtf4QGwWRjWRozt1fKZg=
X-Received: by 2002:ab0:2789:: with SMTP id t9mr7893815uap.83.1584097306175;
 Fri, 13 Mar 2020 04:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200309124108.18952-1-fdmanana@kernel.org> <20200312203324.GI12659@twin.jikos.cz>
In-Reply-To: <20200312203324.GI12659@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 13 Mar 2020 11:01:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H42gkjx83Eqd1sfvtqOcj0k4BjLLr-k-C=mA2COcw1dEA@mail.gmail.com>
Message-ID: <CAL3q7H42gkjx83Eqd1sfvtqOcj0k4BjLLr-k-C=mA2COcw1dEA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Btrfs: make ranged fsyncs always respect the given range
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 12, 2020 at 8:33 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Mon, Mar 09, 2020 at 12:41:04PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > This patchset fixes a bug when not using NO_HOLES and makes ranged fsyncs
> > respect the given file range when using the NO_HOLES feature.
> >
> > The bug is about missing file extents items representing a hole after doing
> > a ranged fsync on a file and replaying the log.
> >
> > Btrfs doesn't respect the given range for a fsync when the inode's has the
> > "need full sync" bit set - it treats the fsync as a full ranged one, operating
> > on the whole file, doing more IO and cpu work then needed.
> >
> > That behaviour was needed to fix a corruption bug. Commit 0c713cbab6200b
> > ("Btrfs: fix race between ranged fsync and writeback of adjacent ranges")
> > fixed that bug by turning the ranged fsync into a full ranged one.
> >
> > Later the hole detection code of fsync was simplified a lot in order to
> > fix another bug when using the NO_HOLES feature - done by commit
> > 0e56315ca147b3 ("Btrfs: fix missing hole after hole punching and fsync when
> > using NO_HOLES"). That commit now makes it easy to avoid turning the ranged
> > fsyncs into non-ranged fsyncs.
> >
> > This patchset does those two changes. The first patch fixes the bug mentioned
> > before, patches 2 and 3 are preparation cleanups for patch 4, which is the
> > one that makes fsync respect the given file range when using NO_HOLES.
> >
> > V3: Updated patch one so that the ranged is set to full before locking the
> >     inode. To make sure we do writeback and wait for ordered extent
> >     completion as much as possible before locking the inode.
> >     Remaining patches are unchanged.
> >
> > V2: Added one more patch to the series, which is the first patch, that
> >     fixes the bug regarding missing holes after doing a ranged fsync.
> >
> >     The remaining patches remain the same, only patch 4 had a trivial
> >     conflict when rebasing against patch 1 and got its changelog
> >     updated. Now all fstests pass with version 2 of this patchset.
> >
> > Filipe Manana (4):
> >   Btrfs: fix missing file extent item for hole after ranged fsync
> >   Btrfs: add helper to get the end offset of a file extent item
> >   Btrfs: factor out inode items copy loop from btrfs_log_inode()
> >   Btrfs: make ranged full fsyncs more efficient
>
> Moved from for-next to misc-next, thanks.

Btw, Josef's reviewed-by tag is missing in the changelog of patch 4
(however there's an unusual reviewed-by tag from you).
Thanks.

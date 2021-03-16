Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241F633D9EE
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 17:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbhCPQ5T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 12:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237015AbhCPQ5L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 12:57:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E3D665090
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 16:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615913831;
        bh=bTEvjlALyI0V8xAKYiWSrjnhWhTtluov4IW572G/WkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d+W6hxeyQDsmS8o45viGOi+PQK08jBzjRRs2zZHOCo6kFmQskwICqWX4aRyV04xuP
         EhVNblpHTowKjjQah9qzPH+XtbBkMucunsfCnrmFLs97Bwpu11WZ+1F8ShrNJLiCox
         nuSfXoL09hZjvCj1lToU45OTiwFiFXFTeeXGr72zOvZUE3Y0yoOcfyfxDT+jfZUP9e
         wHQTqZ879/w2qvouNp8OYiKA8PChlmHNcE//AV1ErA6HdL/9Ihtr/NJeEa58wYwm1g
         +ftKUUKWh2Pt9FHs0mkGrD2LMwAHjKFO0Ems7yEyHo+3Xk2ZqrGFCcjou48Pk7DSmU
         YjtgCmuJfhDpQ==
Received: by mail-qk1-f174.google.com with SMTP id b130so35910901qkc.10
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 09:57:11 -0700 (PDT)
X-Gm-Message-State: AOAM5309DU3P0n6zXEseVow4AjpS06yXttWT9G8JTOEAF3ontH9XuFpO
        jB0AYEQukfYjCEAzva3ndNYdCRuZUizEDp0qNzE=
X-Google-Smtp-Source: ABdhPJxes9eYe4C8hjFrATHAkS+w+NcWYGn0ch3EcRwTo3RpL1JkZicDxmIolUJSzZs+ttxftKsi2Egl86rXGVvJ+IA=
X-Received: by 2002:a37:a44:: with SMTP id 65mr474168qkk.479.1615913830382;
 Tue, 16 Mar 2021 09:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1607940240.git.fdmanana@suse.com> <d18713e258daa60e986e6ee7c22b4479e0d396c4.1607940240.git.fdmanana@suse.com>
 <b19f4310-35e0-606e-1eea-2dd84d28c5da@synology.com> <CAL3q7H6=VRoBdSnMn03wAYpeBVaD0XoE3FO7ioxEGogHF_LYbA@mail.gmail.com>
In-Reply-To: <CAL3q7H6=VRoBdSnMn03wAYpeBVaD0XoE3FO7ioxEGogHF_LYbA@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 16 Mar 2021 16:56:59 +0000
X-Gmail-Original-Message-ID: <CAL3q7H795DMNeuUmpYP0bWG-c9-0hfgN+nx-H-vvhWxmXbRo1w@mail.gmail.com>
Message-ID: <CAL3q7H795DMNeuUmpYP0bWG-c9-0hfgN+nx-H-vvhWxmXbRo1w@mail.gmail.com>
Subject: Re: [PATCH 2/5] btrfs: fix transaction leak and crash after cleaning
 up orphans on RO mount
To:     robbieko <robbieko@synology.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 16, 2021 at 11:43 AM Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Tue, Mar 16, 2021 at 6:49 AM robbieko <robbieko@synology.com> wrote:
> >
> > Hi All,
> >
> > The patch delayed find orphan roots.
> > Move to after orphan cleanup with tree_root.
> > I think this will cause all orphan items to be deleted
> > when orphan cleanup with tree_root.
> > Afterwards, find orphan roots cannot find
> > the subvolume being deleted.
>
> Not entirely able to parse what you are trying to say.
>
> I suppose your concern is that the call to:
>
> btrfs_orphan_cleanup(fs_info->tree_root)
>
> which now happens before calling btrfs_find_orphan_roots(), results in
> the orphans for roots being accidentally deleted and therefore cause
> no root deletions to happen later?
> If that's your concern, than it does not happen because
> btrfs_orphan_cleanup() skips deletion of orphan items for deleted
> roots.
>
> I've just created a test case to verify it's correct, for RW mounts,
> RO mounts and remounts from RO to RW:
>
> https://pastebin.com/raw/zSZjgn48
>
> I couldn't find any regression.

Ok, I figured out what you meant, and the test was not checking the
btree was deleted, only the orphan items.
I just sent a fix and an updated test case.

Thanks for the report.


>
> Thanks.
>
>
> > >   out:
> > >       return ret;
> > >   }
> > > @@ -3383,10 +3384,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
> > >               }
> > >       }
> > >
> > > -     ret = btrfs_find_orphan_roots(fs_info);
> > > -     if (ret)
> > > -             goto fail_qgroup;
> > > -
> > >       fs_info->fs_root = btrfs_get_fs_root(fs_info, BTRFS_FS_TREE_OBJECTID, true);
> > >       if (IS_ERR(fs_info->fs_root)) {
> > >               err = PTR_ERR(fs_info->fs_root);

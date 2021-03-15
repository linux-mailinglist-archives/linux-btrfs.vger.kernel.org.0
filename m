Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA6633AF4C
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 10:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhCOJxA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 05:53:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhCOJw7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 05:52:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30EC964E90
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Mar 2021 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615801979;
        bh=J9iGRcqyBxq5h3/HIDQbQSe4RUtUqhCy6YBymuscTJo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VfGEObldPGo4RfB+0C1o7KBzLANiXvK89XxLitxnmvFM7m+SmpVbYgKc3zgi3hhQK
         JaF5SDNXQ/txoe52FnJVUa9kNkv8R8Ca5OfU1u4JQmq4Jk+K0KfjcP0cqrsfQfK8aE
         F1pLJvm5H/+Ky35Iwgqn7Y8BhKjAE5DRCz35vc+vUBHeasXmxaxIMv35mQ3+ko4xV3
         nsGmNId9K9zqFAETHn0QP+1mgGO4XO/mnBOH9evWjz/N7RgR6MQRk5rKERox7FGO7e
         KJ9T4k47Qk8tJYdhmtI+BLsnar04R1qLaL6Z8EQ++GY78C3drcdZUuan2Ddt3H+vso
         It6t7sAOrVF/w==
Received: by mail-qv1-f42.google.com with SMTP id l15so7440588qvl.4
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Mar 2021 02:52:59 -0700 (PDT)
X-Gm-Message-State: AOAM532P/2r93cSeUCrHPzZ8cXM/yT3R4a0ecuk4zM3FKQUSEotW/HKO
        LuUADbaVI1NquIdq9wdI1LfU5mJqU8KEzz5Rvfk=
X-Google-Smtp-Source: ABdhPJzukrTLkhrSxjc5cbkErzN343+WUds4H6B6YWjqj+JCgcJRmMjWYucTCdhu6fB8/ZAI79pmEN8gEP60ac6tYVU=
X-Received: by 2002:a0c:a1c2:: with SMTP id e60mr10006820qva.41.1615801978141;
 Mon, 15 Mar 2021 02:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615472583.git.fdmanana@suse.com> <08ccdf842ceb0e05bccbdd087b9ef48efc4144db.1615472583.git.fdmanana@suse.com>
 <20210313152637.1D83.409509F4@e16-tech.com>
In-Reply-To: <20210313152637.1D83.409509F4@e16-tech.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 15 Mar 2021 09:52:47 +0000
X-Gmail-Original-Message-ID: <CAL3q7H48AaKOkiLFCdE5LrJoS1vABBiRrp2oanniJM6L-2ZOTQ@mail.gmail.com>
Message-ID: <CAL3q7H48AaKOkiLFCdE5LrJoS1vABBiRrp2oanniJM6L-2ZOTQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] btrfs: use a bit to track the existence of tree mod
 log users
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Mar 13, 2021 at 7:31 AM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi,
>
> It will be more easy to backport for heavy i/o load if we put this patch
> before '[PATCH 3/9] btrfs: move the tree mod log code into its own file' ?

Only bug fixes and fixes for serious performance regressions are
backported to stable kernels.

This patch is neither of them. It's a cleanup.
It mentions that replacing the memory barriers with test_bit() may
provide a slight benefit. If it does it's such a micro optimization
that I doubt it causes any observable effect on any workload.
Even if it does, which I seriously doubt, it's still not a candidate
for stable backports.

>
> And this patch can be merged into one with the following
> '[PATCH 6/9] btrfs: use the new bit BTRFS_FS_TREE_MOD_LOG_USERS at btrfs_free_tree_block()'?

They do the same thing, but for slightly different cases. So I prefer
to keep them separate for ease of review.

>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/03/13
>
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > The tree modification log functions are called very frequently, basically
> > they are called everytime a btree is modified (a pointer added or removed
> > to a node, a new root for a btree is set, etc). Because of that, to avoid
> > heavy lock contention on the lock that protects the list of tree mod log
> > users, we have checks that test the emptiness of the list with a full
> > memory barrier before the checks, so that when there are no tree mod log
> > users we avoid taking the lock.
> >
> > Replace the memory barrier and list emptiness check with a test for a new
> > bit set at fs_info->flags. This bit is used to indicate when there are
> > tree mod log users, set whenever a user is added to the list and cleared
> > when the last user is removed from the list. This makes the intention a
> > bit more obvious and possibly more efficient (assuming test_bit() may be
> > cheaper than a full memory barrier on some architectures).
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/ctree.h        |  3 +++
> >  fs/btrfs/tree-mod-log.c | 11 ++++++-----
> >  2 files changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 50208673bd55..90184ee2f832 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -580,6 +580,9 @@ enum {
> >
> >       /* Indicate that we can't trust the free space tree for caching yet */
> >       BTRFS_FS_FREE_SPACE_TREE_UNTRUSTED,
> > +
> > +     /* Indicate whether there are any tree modification log users. */
> > +     BTRFS_FS_TREE_MOD_LOG_USERS,
> >  };
> >
> >  /*
> > diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
> > index f2a6da1b2903..b912b82c36c9 100644
> > --- a/fs/btrfs/tree-mod-log.c
> > +++ b/fs/btrfs/tree-mod-log.c
> > @@ -60,6 +60,7 @@ u64 btrfs_get_tree_mod_seq(struct btrfs_fs_info *fs_info,
> >       if (!elem->seq) {
> >               elem->seq = btrfs_inc_tree_mod_seq(fs_info);
> >               list_add_tail(&elem->list, &fs_info->tree_mod_seq_list);
> > +             set_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags);
> >       }
> >       write_unlock(&fs_info->tree_mod_log_lock);
> >
> > @@ -83,7 +84,9 @@ void btrfs_put_tree_mod_seq(struct btrfs_fs_info *fs_info,
> >       list_del(&elem->list);
> >       elem->seq = 0;
> >
> > -     if (!list_empty(&fs_info->tree_mod_seq_list)) {
> > +     if (list_empty(&fs_info->tree_mod_seq_list)) {
> > +             clear_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags);
> > +     } else {
> >               struct btrfs_seq_list *first;
> >
> >               first = list_first_entry(&fs_info->tree_mod_seq_list,
> > @@ -166,8 +169,7 @@ static noinline int tree_mod_log_insert(struct btrfs_fs_info *fs_info,
> >  static inline bool tree_mod_dont_log(struct btrfs_fs_info *fs_info,
> >                                   struct extent_buffer *eb)
> >  {
> > -     smp_mb();
> > -     if (list_empty(&(fs_info)->tree_mod_seq_list))
> > +     if (!test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags))
> >               return true;
> >       if (eb && btrfs_header_level(eb) == 0)
> >               return true;
> > @@ -185,8 +187,7 @@ static inline bool tree_mod_dont_log(struct btrfs_fs_info *fs_info,
> >  static inline bool tree_mod_need_log(const struct btrfs_fs_info *fs_info,
> >                                   struct extent_buffer *eb)
> >  {
> > -     smp_mb();
> > -     if (list_empty(&(fs_info)->tree_mod_seq_list))
> > +     if (!test_bit(BTRFS_FS_TREE_MOD_LOG_USERS, &fs_info->flags))
> >               return false;
> >       if (eb && btrfs_header_level(eb) == 0)
> >               return false;
> > --
> > 2.28.0
>
>

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6451C33D358
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 12:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbhCPLtz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 07:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237473AbhCPLtm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 07:49:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBBFB64F9E
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 11:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615895381;
        bh=IsSIn2jVtiK4WuKRLaAWKyXZLxgljonJdWiQ/LbKh6k=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=YaOqkW5qkXYH4hIO63g5ukmh248tuXkWRmAbZGngSqUkd3iQu/ASjWTPMVSYWbTvz
         I6qCzinW65SiGXRgTJCbRh7R/8seEv91ViylBAhvS1+uotI4dmEq0IDXfFr8A3sajq
         WNsoHZWyyLBCsLkBeQ65YWphtdjAe+XgJ3nRQwAPUlr1kxvwJ/tdzAaakwDM/v96ck
         nhmqu00fpp/EI0eg6D/SIKs6C66rJnZ6pu1nktyAbeMwCSfgAlbZc9XbjbFN/KbwNi
         5BgNSkaKXc+CR+9Tr4JF8khCcAJdZtv6SlEnZWzznmeHLdTevy097kXV/FOGpnO7SD
         6nXT/vwdXc5PA==
Received: by mail-qt1-f179.google.com with SMTP id 73so11349418qtg.13
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 04:49:41 -0700 (PDT)
X-Gm-Message-State: AOAM531eHSFYT6NgGAU4KgQz09EKEma9Fd2jp3Mn7s9BneKkK1HjUI2Y
        hwbDnMUo/W8VoQElubkdUy4A/jn/1Jh26V2X9P8=
X-Google-Smtp-Source: ABdhPJyzt5vzcLnr0muAI1kwrF5HR52U40cTO3jk625Pd++Gh24IPC9YFNK/l6awlqH1JHNO1rx3jBB2i2snpaZQGdQ=
X-Received: by 2002:ac8:73c5:: with SMTP id v5mr26614080qtp.259.1615895380947;
 Tue, 16 Mar 2021 04:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615472583.git.fdmanana@suse.com> <d9d8cda5b3ab2a262d4d66e9fe8abd75912f252f.1615472583.git.fdmanana@suse.com>
 <20210315192857.GB7604@twin.jikos.cz>
In-Reply-To: <20210315192857.GB7604@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 16 Mar 2021 11:49:29 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6XCJbz7=Q5=Kfy=NSJvqZP7bPuWSCZffFhfFw_kkJXSQ@mail.gmail.com>
Message-ID: <CAL3q7H6XCJbz7=Q5=Kfy=NSJvqZP7bPuWSCZffFhfFw_kkJXSQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] btrfs: always pin deleted leaves when there are
 active tree mod log users
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 15, 2021 at 7:31 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Mar 11, 2021 at 02:31:06PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When freeing a tree block we may end up adding its extent back to the
> > free space cache/tree, as long as there are no more references for it,
> > it was created in the current transaction and writeback for it never
> > happened. This is generally fine, however when we have tree mod log
> > operations it can result in inconsistent versions of a btree after
> > unwinding extent buffers with the recorded tree mod log operations.
> >
> > This is because:
> >
> > * We only log operations for nodes (adding and removing key/pointers),
> >   for leaves we don't do anything;
> >
> > * This means that we can log a MOD_LOG_KEY_REMOVE_WHILE_FREEING operation
> >   for a node that points to a leaf that was deleted;
> >
> > * Before we apply the logged operation to unwind a node, we can have
> >   that leaf's extent allocated again, either as a node or as a leaf, and
> >   possibly for another btree. This is possible if the leaf was created in
> >   the current transaction and writeback for it never started, in which
> >   case btrfs_free_tree_block() returns its extent back to the free space
> >   cache/tree;
> >
> > * Then, before applying the tree mod log operation, some task allocates
> >   the metadata extent just freed before, and uses it either as a leaf or
> >   as a node for some btree (can be the same or another one, it does not
> >   matter);
> >
> > * After applying the MOD_LOG_KEY_REMOVE_WHILE_FREEING operation we now
> >   get the target node with an item pointing to the metadata extent that
> >   now has content different from what it had before the leaf was deleted.
> >   It might now belong to a different btree and be a node and not a leaf
> >   anymore.
> >
> >   As a consequence, the results of searches after the unwinding can be
> >   unpredictable and produce unexpected results.
> >
> > So make sure we pin extent buffers corresponding to leaves when there
> > are tree mod log users.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/extent-tree.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index 5e228d6ad63f..2482b26b1971 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -3310,6 +3310,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
> >
> >       if (last_ref && btrfs_header_generation(buf) == trans->transid) {
> >               struct btrfs_block_group *cache;
> > +             bool must_pin = false;
> >
> >               if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
> >                       ret = check_ref_cleanup(trans, buf->start);
> > @@ -3327,7 +3328,27 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
> >                       goto out;
> >               }
> >
> > -             if (btrfs_is_zoned(fs_info)) {
> > +             /*
> > +              * If this is a leaf and there are tree mod log users, we may
> > +              * have recorded mod log operations that point to this leaf.
> > +              * So we must make sure no one reuses this leaf's extent before
> > +              * mod log operations are applied to a node, otherwise after
> > +              * rewinding a node using the mod log operations we get an
> > +              * inconsistent btree, as the leaf's extent may now be used as
> > +              * a node or leaf for another different btree.
> > +              * We are safe from races here because at this point no other
> > +              * node or root points to this extent buffer, so if after this
> > +              * check a new tree mod log user joins, it will not be able to
> > +              * find a node pointing to this leaf and record operations that
> > +              * point to this leaf.
> > +              */
> > +             if (btrfs_header_level(buf) == 0) {
> > +                     read_lock(&fs_info->tree_mod_log_lock);
> > +                     must_pin = !list_empty(&fs_info->tree_mod_seq_list);
> > +                     read_unlock(&fs_info->tree_mod_log_lock);
> > +             }
> > +
> > +             if (must_pin || btrfs_is_zoned(fs_info)) {
> >                       btrfs_redirty_list_add(trans->transaction, buf);
> >                       pin_down_extent(trans, cache, buf->start, buf->len, 1);
> >                       btrfs_put_block_group(cache);
>
> This has been added in d3575156f662 ("btrfs: zoned: redirty released
> extent buffers") 5.12-rc1, so it is a regression but otherwise it sounds
> like it's not related only to zoned mode. I'm not sure if this is
> relevant for older stable trees because of missing
> btrfs_redirty_list_add, possibly with some tweaks. Please let me know,
> thanks.

It's not related to zoned filesystems at all.
I just happened to reuse that if branch for the zoned case because it
does the same thing I needed to do, and the call to
btrfs_redirty_list_add() does nothing for the non-zoned case, so it's
safe.

I.e., it's the same as adding the following instead:

if (must_pin) {
  pin_down_extent(trans, cache, buf->start, buf->len, 1);
  btrfs_put_block_group(cache);
  goto out;
}

I opted for the shorter version by ORing the two cases.

But yes, for pre 5.12-rc1 the patch will not apply and the above code
would be needed.

Thanks.

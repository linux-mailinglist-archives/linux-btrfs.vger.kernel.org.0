Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB7A3E14F2
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 14:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240601AbhHEMmY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Aug 2021 08:42:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57146 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240237AbhHEMmX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Aug 2021 08:42:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B7C682023E;
        Thu,  5 Aug 2021 12:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628167328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EcgIpp6yHesVRZAG+1C2S1VFxcDRdcX9vwHvL851WI8=;
        b=WS+JGOl2HBKu179VdmfudiGalYReN2vGF4b9T3zP1q3m7Ns8M06BRqMShF52C505R6jtOq
        CFR36StFVmFQMdYGYKfMOiEccCxlfOC1CbWE2GuYtilZGLJYRLG2SDYm9k4PB9FGsNWkAE
        gfUeejhnkgJs1mOjwBtLdRMM5MH/zVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628167328;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EcgIpp6yHesVRZAG+1C2S1VFxcDRdcX9vwHvL851WI8=;
        b=7KcMOggPJPDdp1Q+oHxtbtVB4WZPht19ZVY8dR3zw/xSd8rnpzuOeSBfxP2YYgxr+HL95H
        e9Cigkn4CFKGyuDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3074613D4B;
        Thu,  5 Aug 2021 12:42:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LCIZOZ7cC2EiRQAAMHmgww
        (envelope-from <mpdesouza@suse.de>); Thu, 05 Aug 2021 12:42:06 +0000
Message-ID: <b3ffa270ab94417ba3f1755b1c9c8562800e5534.camel@suse.de>
Subject: Re: [PATCH 6/7] btrfs: tree-log: Simplify log_new_ancestors
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     fdmanana@gmail.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Date:   Thu, 05 Aug 2021 09:41:49 -0300
In-Reply-To: <CAL3q7H7Ch+yQ6MzhHEHjpAOTKtYUsRByi-jgyQrp-dXEF6Ucgw@mail.gmail.com>
References: <20210804184854.10696-1-mpdesouza@suse.com>
         <20210804184854.10696-7-mpdesouza@suse.com>
         <CAL3q7H7Ch+yQ6MzhHEHjpAOTKtYUsRByi-jgyQrp-dXEF6Ucgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2021-08-05 at 10:00 +0100, Filipe Manana wrote:
> On Wed, Aug 4, 2021 at 10:07 PM Marcos Paulo de Souza
> <mpdesouza@suse.com> wrote:
> > The search_key variable was being used only as argument of
> > btrfs_search_slot. This can be simplified by calling
> > btrfs_find_item,
> > which also handles the next leaf condition as well.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >  fs/btrfs/tree-log.c | 40 ++++++++++++----------------------------
> >  1 file changed, 12 insertions(+), 28 deletions(-)
> > 
> > diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> > index 567adc3de11a..22417cd32347 100644
> > --- a/fs/btrfs/tree-log.c
> > +++ b/fs/btrfs/tree-log.c
> > @@ -5929,31 +5929,30 @@ static int btrfs_log_all_parents(struct
> > btrfs_trans_handle *trans,
> >         return ret;
> >  }
> > 
> > +/*
> > + * Iterate over the given and all it's parent directories, logging
> > them if
> > + * needed.
> > + *
> > + * Return 0 if we reach the toplevel directory, or < 0 if error.
> > + */
> >  static int log_new_ancestors(struct btrfs_trans_handle *trans,
> >                              struct btrfs_root *root,
> >                              struct btrfs_path *path,
> >                              struct btrfs_log_ctx *ctx)
> >  {
> > +       struct btrfs_fs_info *fs_info = root->fs_info;
> >         struct btrfs_key found_key;
> > +       u64 ino;
> > 
> >         btrfs_item_key_to_cpu(path->nodes[0], &found_key, path-
> > >slots[0]);
> > 
> >         while (true) {
> > -               struct btrfs_fs_info *fs_info = root->fs_info;
> > -               struct extent_buffer *leaf = path->nodes[0];
> > -               int slot = path->slots[0];
> > -               struct btrfs_key search_key;
> >                 struct inode *inode;
> > -               u64 ino;
> 
> Why are the 'ino' and 'fs_info' declarations moved to the outer
> scope?
> They are only used inside the while loop's scope, so I don't see a
> reason to move them.

You're right, I will keep them in place for v2. Thanks!

> 
> Thanks.
> 
> >                 int ret = 0;
> > 
> >                 btrfs_release_path(path);
> > 
> >                 ino = found_key.offset;
> > -
> > -               search_key.objectid = found_key.offset;
> > -               search_key.type = BTRFS_INODE_ITEM_KEY;
> > -               search_key.offset = 0;
> >                 inode = btrfs_iget(fs_info->sb, ino, root);
> >                 if (IS_ERR(inode))
> >                         return PTR_ERR(inode);
> > @@ -5966,29 +5965,14 @@ static int log_new_ancestors(struct
> > btrfs_trans_handle *trans,
> >                 if (ret)
> >                         return ret;
> > 
> > -               if (search_key.objectid ==
> > BTRFS_FIRST_FREE_OBJECTID)
> > +               if (ino == BTRFS_FIRST_FREE_OBJECTID)
> >                         break;
> > 
> > -               search_key.type = BTRFS_INODE_REF_KEY;
> > -               ret = btrfs_search_slot(NULL, root, &search_key,
> > path, 0, 0);
> > +               ret = btrfs_find_item(root, path, ino,
> > BTRFS_INODE_REF_KEY, 0,
> > +                                       &found_key);
> >                 if (ret < 0)
> >                         return ret;
> > -
> > -               leaf = path->nodes[0];
> > -               slot = path->slots[0];
> > -               if (slot >= btrfs_header_nritems(leaf)) {
> > -                       ret = btrfs_next_leaf(root, path);
> > -                       if (ret < 0)
> > -                               return ret;
> > -                       else if (ret > 0)
> > -                               return -ENOENT;
> > -                       leaf = path->nodes[0];
> > -                       slot = path->slots[0];
> > -               }
> > -
> > -               btrfs_item_key_to_cpu(leaf, &found_key, slot);
> > -               if (found_key.objectid != search_key.objectid ||
> > -                   found_key.type != BTRFS_INODE_REF_KEY)
> > +               else if (ret > 0)
> >                         return -ENOENT;
> >         }
> >         return 0;
> > --
> > 2.31.1
> > 
> 
> 


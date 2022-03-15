Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDFB4D9221
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 02:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344197AbiCOBPo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 21:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbiCOBPn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 21:15:43 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2741FA5C
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 18:14:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id t2so14323375pfj.10
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 18:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j/gkhAI2Mzuff+aU5tNp5iJjpj2MT9YkjOKy0xQiGXw=;
        b=Gg6mq1mMmJCulzq8mo1BqF5tLArT5EFiwQ8Ge/rKc5vzVUJ+yjAegHRWf46hRl7LA5
         ZyX7yMCnJnvr3kphjiW0Uqm5RArTDAF3dw+4QNSMO/LMEjmJIpyTyykaPRgmtP/ljnOS
         FtYBpT0bGWhnd/44zcFSIBLFU5aFJLYnCPma5b2SUgHeZeTgaX6Tz/Sv0t5FH/EpVv0t
         QEMynwtjrjRbvyfreNgp7CD96MeKa6OhlyLyZghYlZyHlFJan1BOcdE/MB1KlBD/yIYr
         p2R/9BkkgPGkhM7DnnicKXupUqyRd6f1WVUZDVdy65RKfvX/Pke6D7edM3vthQOjNHUB
         UV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j/gkhAI2Mzuff+aU5tNp5iJjpj2MT9YkjOKy0xQiGXw=;
        b=VYBDJtINhEoJR9yd4EiiTXEtZ7KfO1fggh8qqs373U4fWox7mqN63vPjbjWiCkncAO
         XjTXS4FcV7YhCFqe1pT9jKGMvU0o1DIa5uWwzSmFXqXDDuHCnQO/yzFbMmGlqsDYiVql
         qlgnk1icVGJGN62Nn4H202toZFxU7OSxVJUR9aan8hfCNqaJZ7wIVt2Zc9zIJxqdRaZY
         yAYqEcwOC6n1Gh5nFTSntoVCkeFEq6Lp1SORlLOo13Wo1QRjAtET371BLWjL9uQj/ZRP
         Nx5sK3cMK0L2EnvPfTm8gLDaFgd7bETD3rYYpBBroU5Ne35FmE3bs6cFvI/Pt/U26rXr
         XkWQ==
X-Gm-Message-State: AOAM530OL6D6+Q+r6FJCWKCkA6et07l0PWIJrdnMFjuSSw7ImvowhpHb
        G3K4QreVcrKh5MTyn5XZueWcXQ==
X-Google-Smtp-Source: ABdhPJy4LkPPbJZttM0GId2zy8Vs2Gkoo8eBSEQfuwT7ebbqLbQHuysSTG2/c0IRFtZzv94efDpRlA==
X-Received: by 2002:a05:6a00:174f:b0:4f3:fe06:61b5 with SMTP id j15-20020a056a00174f00b004f3fe0661b5mr26283304pfc.50.1647306871335;
        Mon, 14 Mar 2022 18:14:31 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:46f5])
        by smtp.gmail.com with ESMTPSA id g18-20020a056a000b9200b004f783f5e890sm15699640pfj.156.2022.03.14.18.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:14:30 -0700 (PDT)
Date:   Mon, 14 Mar 2022 18:14:29 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 13/16] btrfs: allocate inode outside of
 btrfs_new_inode()
Message-ID: <Yi/odcN1e3QUiWU0@relinquished.localdomain>
References: <cover.1646875648.git.osandov@fb.com>
 <24d8818e1152a8fb31e2d78239ce410d2a0f8cd4.1646875648.git.osandov@fb.com>
 <CAL3q7H5ACv3ej1=7P2y7mA1vCJoAcHkCqro6_VBuAUxeaw25rw@mail.gmail.com>
 <Yi/a7a4C9zT/c+KR@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi/a7a4C9zT/c+KR@relinquished.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 14, 2022 at 05:16:45PM -0700, Omar Sandoval wrote:
> On Mon, Mar 14, 2022 at 11:33:51PM +0000, Filipe Manana wrote:
> > On Thu, Mar 10, 2022 at 4:56 AM Omar Sandoval <osandov@osandov.com> wrote:
> > >
> > > From: Omar Sandoval <osandov@fb.com>
> > >
> > > Instead of calling new_inode() and inode_init_owner() inside of
> > > btrfs_new_inode(), do it in the callers. This allows us to pass in just
> > > the inode instead of the mnt_userns and mode and removes the need for
> > > memalloc_nofs_{save,restores}() since we do it before starting a
> > > transaction. This also paves the way for some more cleanups in later
> > > patches.
> > >
> > > This also removes the comments about Smack checking i_op, which are no
> > > longer true since commit 5d6c31910bc0 ("xattr: Add
> > > __vfs_{get,set,remove}xattr helpers"). Now it checks inode->i_opflags &
> > > IOP_XATTR, which is set based on sb->s_xattr.
> > >
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > 
> > There's some leak here Omar.
> > 
> > misc-next is triggering tons of these on dmesg:
> 
> I reproduced the "page private not zero" messages on misc-next, but not
> on my full series, so it's probably some mistake I made when splitting
> up these patches that doesn't exist in the end result. I'll fix it.

Yup, this patch needs:

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ff780256c936..d616a3a35e83 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6143,7 +6143,8 @@ static int btrfs_new_inode(struct btrfs_trans_handle *trans,
 	 */
 	BTRFS_I(inode)->index_cnt = 2;
 	BTRFS_I(inode)->dir_index = *index;
-	BTRFS_I(inode)->root = btrfs_grab_root(root);
+	if (!BTRFS_I(inode)->root)
+		BTRFS_I(inode)->root = btrfs_grab_root(root);
 	BTRFS_I(inode)->generation = trans->transid;
 	inode->i_generation = BTRFS_I(inode)->generation;
 

A later patch does this correctly. For the sake of git bisect, I fixed
this and sent out v4.

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0CC727BD3
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 11:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbjFHJqu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 05:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjFHJqs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 05:46:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210A8213C
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 02:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1EF464B4C
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 09:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230C7C4339B
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 09:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686217606;
        bh=1tnyt+TyZOzY2t0ayhGDi2rOrqxFqLmJMZilOkPAhOs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DdcIyfNk1ghMNLaNcW7yeoBb3W3GQphqPdViq37hsQoqKJckFSbGebx1cwATcSQti
         27hC8wc1iDcm0TqgcX/NDfv7VmLGaJ3SbsrtBKDZ7Af8ZqTjWkcLwMhdjx9uU5hOXV
         HGu65DY7GiWl3Cag2YNoEXLAKZge7g5OsUAXbXnOeZck2k/FkEoQf/lTU7/Twxs7is
         9BNVO771UzP9a+ioaA1MFDgUX15th8xHhAX3CFJQOixFiBfK3FZ5sdf9djQ40vceWk
         bggqAkFm7r1bJOiruCuZ5jhXzmtTEYFwyON9/IrNeNaHM5N/nvtfh6JMKOO3PG18HQ
         vVdcbnp126HgQ==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6b2b6910facso200936a34.1
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jun 2023 02:46:46 -0700 (PDT)
X-Gm-Message-State: AC+VfDw0X9G2ewlVh+I2RzGL25iUgzXPgQOb1IQEsNCM2MK59YGSHQcQ
        8BH0dA2h+8Pvy77Rm+Bf9nMV3k6KiQgox2U9T+s=
X-Google-Smtp-Source: ACHHUZ4gWIXNxtrZoMpgoO2uQrGsRuWaZbO1l/GgdVXeOhUvq5HMYwAma2BucmVL35sqVRUjQqRlW1kxTBDsckg/WJ4=
X-Received: by 2002:a9d:7b57:0:b0:6af:9d30:4ba8 with SMTP id
 f23-20020a9d7b57000000b006af9d304ba8mr5332289oto.26.1686217605245; Thu, 08
 Jun 2023 02:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686164789.git.fdmanana@suse.com> <3dfd1a4c01795433444b45268da1ae75563642c1.1686164820.git.fdmanana@suse.com>
 <4c9456f8-1ea5-a5b5-855a-65d3c9ffdf1d@gmx.com>
In-Reply-To: <4c9456f8-1ea5-a5b5-855a-65d3c9ffdf1d@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 8 Jun 2023 10:46:09 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4SnrVrFVG9FhSsJc5ie8JbHFnMcFbnJn61h5RDv9dvdA@mail.gmail.com>
Message-ID: <CAL3q7H4SnrVrFVG9FhSsJc5ie8JbHFnMcFbnJn61h5RDv9dvdA@mail.gmail.com>
Subject: Re: [PATCH 10/13] btrfs: do not BUG_ON() on tree mod log failures at push_nodes_for_insert()
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 8, 2023 at 10:02=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> On 2023/6/8 03:24, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > At push_nodes_for_insert(), instead of doing a BUG_ON() in case we fail=
 to
> > record tree mod log operations, do a transaction abort and return the
> > error to the caller. There's really no need for the BUG_ON() as we can
> > release all resources in this context, and we have to abort because oth=
er
> > future tree searches that use the tree mod log (btrfs_search_old_slot()=
)
> > may get inconsistent results if other operations modify the tree after
> > that failure and before the tree mod log based search.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/ctree.c | 14 ++++++++++++--
> >   1 file changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 2971e7d70d04..e3c949fa136f 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -1300,7 +1300,12 @@ static noinline int push_nodes_for_insert(struct=
 btrfs_trans_handle *trans,
> >                       btrfs_node_key(mid, &disk_key, 0);
> >                       ret =3D btrfs_tree_mod_log_insert_key(parent, psl=
ot,
> >                                       BTRFS_MOD_LOG_KEY_REPLACE);
> > -                     BUG_ON(ret < 0);
> > +                     if (ret < 0) {
> > +                             btrfs_tree_unlock(left);
> > +                             free_extent_buffer(left);
>
> I'm not sure if we only need to unlock and free @left.
>
> As just lines below, we have a two branches which one unlock and free @mi=
d.

mid is part of the path, so we shouldn't touch it at this point.
It's released by the caller doing a btrfs_release_path() or btrfs_free_path=
().

Those branches unlock and free mid because they are replacing it in the pat=
h.

Thanks.

>
> Thanks,
> Qu
>
> > +                             btrfs_abort_transaction(trans, ret);
> > +                             return ret;
> > +                     }
> >                       btrfs_set_node_key(parent, &disk_key, pslot);
> >                       btrfs_mark_buffer_dirty(parent);
> >                       if (btrfs_header_nritems(left) > orig_slot) {
> > @@ -1355,7 +1360,12 @@ static noinline int push_nodes_for_insert(struct=
 btrfs_trans_handle *trans,
> >                       btrfs_node_key(right, &disk_key, 0);
> >                       ret =3D btrfs_tree_mod_log_insert_key(parent, psl=
ot + 1,
> >                                       BTRFS_MOD_LOG_KEY_REPLACE);
> > -                     BUG_ON(ret < 0);
> > +                     if (ret < 0) {
> > +                             btrfs_tree_unlock(right);
> > +                             free_extent_buffer(right);
> > +                             btrfs_abort_transaction(trans, ret);
> > +                             return ret;
> > +                     }
> >                       btrfs_set_node_key(parent, &disk_key, pslot + 1);
> >                       btrfs_mark_buffer_dirty(parent);
> >

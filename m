Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EFD6E4533
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Apr 2023 12:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjDQKan (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 06:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjDQKam (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 06:30:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1623B1FC3
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 03:29:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7738621E5
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 10:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39609C4339B
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 10:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681726763;
        bh=zntXQSrKzFvgi9ovtqjUXbDn5f/IEiOR0XbFZR4xORs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g9rviCHG3ALoiCqt6oddUQCZcpDsBWQGYTL00hJkoNFoS8GlYS/tvhdXBXEAXX8Y1
         8gYkavBwf5JeyOXe6vt5Be7zz/vxjGVFKVvSCRIepPUeeh4CYhDlcEeLkKzCWvF/cm
         W2dC6cWiyR194bVW8FSXRTRPkAoT6zEZ858pD4hsb5HMtqGvZ2wqdNLs6DXGz1dQyG
         GYJ+yB0uCUYRuOn3Pv1ynZ6zYpZvUspb1NOQuneeQ0nFOJjvvrr43ShEkTw9NGarYW
         hd2DeIfpdtlPOBwx8DzCb66o1mWvTd9P3Ge7zml6ROvql7VeY4YuJVf4QNDjtHaCe+
         QLZAIaCCeOHGg==
Received: by mail-oo1-f51.google.com with SMTP id e24-20020a4ae0d8000000b0054101f316c7so566596oot.13
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 03:19:23 -0700 (PDT)
X-Gm-Message-State: AAQBX9cNVoqeKWSKUMePtt2dhb4LNsUbDRLSAcHhXNbMG1fuv0/VAjvy
        eSS9MEn8HdNu+5tjghzE0qJxZZG8l+Eau017FSk=
X-Google-Smtp-Source: AKy350aib9v9v8JO/H48+52dtcKSciFeqVY+Usf/hFnEUrrW/9Z5qdmpN5DYrlpgShKhppOcD03zp0Irtz9du6Gu2eg=
X-Received: by 2002:a05:6820:1aa0:b0:546:e85c:8bba with SMTP id
 bt32-20020a0568201aa000b00546e85c8bbamr354926oob.1.1681726762352; Mon, 17 Apr
 2023 03:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <e6eaa082d536fc5223eae4627bc7dc6369e257d9.1681295111.git.fdmanana@suse.com>
 <20230414035734.6DF7.409509F4@e16-tech.com> <20230414114340.57ED.409509F4@e16-tech.com>
In-Reply-To: <20230414114340.57ED.409509F4@e16-tech.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 17 Apr 2023 11:18:46 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6CoXvJGdf9Af4qQPyhwP-3gDPDOLNtK3YWqw1HV28rHw@mail.gmail.com>
Message-ID: <CAL3q7H6CoXvJGdf9Af4qQPyhwP-3gDPDOLNtK3YWqw1HV28rHw@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: fix btrfs_prev_leaf() to not return the same
 key twice
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 14, 2023 at 4:44=E2=80=AFAM Wang Yugui <wangyugui@e16-tech.com>=
 wrote:
>
> Hi,
>
> > Hi,
> >
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > A call to btrfs_prev_leaf() may end up returning a path that points t=
o the
> > > same item (key) again. This happens if while btrfs_prev_leaf(), after=
 we
> > > release the path, a concurrent insertion happens, which moves items o=
ff
> > > from a sibbling into the front of the previous leaf, and an item with=
 the
> > > computed previous key does not exists.
> > >
> > > For example, suppose we have the two following leaves:
> > >
> > >   Leaf A
> > >
> > >   -------------------------------------------------------------
> > >   | ...   key (300 96 10)   key (300 96 15)   key (300 96 16) |
> > >   -------------------------------------------------------------
> > >               slot 20             slot 21             slot 22
> > >
> > >   Leaf B
> > >
> > >   -------------------------------------------------------------
> > >   | key (300 96 20)   key (300 96 21)   key (300 96 22)   ... |
> > >   -------------------------------------------------------------
> > >       slot 0             slot 1             slot 2
> > >
> > > If we call btrfs_prev_leaf(), from btrfs_previous_item() for example,=
 with
> > > a path pointing to leaf B and slot 0 and the following happens:
> > >
> > > 1) At btrfs_prev_leaf() we compute the previous key to search as:
> > >    (300 96 19), which is a key that does not exists in the tree;
> > >
> > > 2) Then we call btrfs_release_path() at btrfs_prev_leaf();
> > >
> > > 3) Some other task inserts a key at leaf A, that sorts before the key=
 at
> > >    slot 20, for example it has an objectid of 299. In order to make r=
oom
> > >    for the new key, the key at slot 22 is moved to the front of leaf =
B.
> > >    This happens at push_leaf_right(), called from split_leaf().
> > >
> > >    After this leaf B now looks like:
> > >
> > >   -------------------------------------------------------------------=
-------------
> > >   | key (300 96 16)    key (300 96 20)   key (300 96 21)   key (300 9=
6 22)   ... |
> > >   -------------------------------------------------------------------=
-------------
> > >        slot 0              slot 1             slot 2             slot=
 3
> > >
> > > 4) At btrfs_prev_leaf() we call btrfs_search_slot() for the computed
> > >    previous key: (300 96 19). Since the key does not exists,
> > >    btrfs_search_slot() returns 1 and with a path pointing to leaf B
> > >    and slot 1, the item with key (300 96 20);
> > >
> > > 5) This makes btrfs_prev_leaf() return a path that points to slot 1 o=
f
> > >    leaf B, the same key as before it was called, since the key at slo=
t 0
> > >    of leaf B (300 96 16) is less than the computed previous key, whic=
h is
> > >    (300 96 19);
> > >
> > > 6) As a consequence btrfs_previous_item() returns a path that points =
again
> > >    to the item with key (300 96 20).
> > >
> > > For some users of btrfs_prev_leaf() or btrfs_previous_item() this may=
 not
> > > be functional a problem, despite not making sense to return a new pat=
h
> > > pointing again to the same item/key. However for a caller such as
> > > tree-log.c:log_dir_items(), this has a bad consequence, as it can res=
ult
> > > in not logging some dir index deletions in case the directory is bein=
g
> > > logged without holding the inode's VFS lock (logging triggered while
> > > logging a child inode for example) - for the example scenario above, =
in
> > > case the dir index keys 17, 18 and 19 were deleted in the current
> > > transaction.
> >
> > fstests(btrfs/080) had few frequency(<1/10) to fail after this pacth is=
 applied.
> > but it is yet not clear enough.
> >
> > # cat results//btrfs/080.out.bad
> > QA output created by 080
> > Unexpected digest for file /mnt/scratch/20_40_30_986878191_snap/foobar_=
63
> > (see /usr/hpc-bio/xfstests/results//btrfs/080.full for details)
>
> fstests(btrfs/080) failure happened without this patch too.
>
> the next info update may take some long time, because of the low reproduc=
e
> frequency.

That test sporadically fails without the patch yes.

Also, more important: the test does not exercise at all the function
changed by this patch.
So you can save time and skip doing that pointless info update on
frequency failure...

Thanks.

>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2023/04/14
>
>

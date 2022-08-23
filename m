Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEF359D3A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 10:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242683AbiHWIWI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 04:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243541AbiHWIVV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 04:21:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6A66B644
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 01:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8754B6123D
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 08:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F5EC43145
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 08:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661242352;
        bh=M6pnjTZGmOcyj+caPNIAesHSjd5dj1UU12n+COgTxG8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YYi3L7+U/Q5J3AxoM6lgE3Y/louUQdFLSix4Gp/jR2RhEZOIUajWN41bEPlgx4Chg
         Q51K/qj0S7uHq6vcWwFflTjuveEKvUy0uIvH2mSrYOr60akgd4ferx/056RnjxXzNd
         skCjS13OZXtrQn8s4Lr7Jr7BhFryenizlyrkzcfWyebojWeI+zzcD8IvTtq/V4LUmR
         m9Waxigfjowim30nKqW+oYfc6X1vFvd3ptWMBD6e9hoN5HOkKfB+p68Z/qv5vF4GE/
         YMYGjOEsG0pPONJbufBIbEG6VxyAKDQr2Wj9PS3J2gFfSGuisT9vEFrYXHtqhn0Tk9
         8fXbePSTGM3bQ==
Received: by mail-oi1-f177.google.com with SMTP id t140so6330854oie.8
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 01:12:32 -0700 (PDT)
X-Gm-Message-State: ACgBeo2ELiB7HUDOTvN1pHDVDB6n00qLPkuBp3ZvXkU+L/MktEtyCdlB
        5pFd4yK4bYobu8Y44Czean+ncmzqYxpLhtZ+nno=
X-Google-Smtp-Source: AA6agR6jt/Yg5zRNq94XmSXX7yNUVXRR5V3emaTiQeZzmOVmbWQ/trTBYXRvYZQceqenI15aierJAvxINyLKmqRWlKE=
X-Received: by 2002:a05:6808:308c:b0:343:53c7:fbbb with SMTP id
 bl12-20020a056808308c00b0034353c7fbbbmr875009oib.98.1661242352064; Tue, 23
 Aug 2022 01:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661179270.git.fdmanana@suse.com> <f070919ec910b3682dd22742151a60f9e4c95cbf.1661179270.git.fdmanana@suse.com>
 <54b0975b-dd84-7ce1-07bd-4e2839735cbd@gmx.com>
In-Reply-To: <54b0975b-dd84-7ce1-07bd-4e2839735cbd@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 23 Aug 2022 09:11:55 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7wkPA_XqGOWBEmKgfZK7LN_0sFjTZKdB8u4Gi9dmU3Kw@mail.gmail.com>
Message-ID: <CAL3q7H7wkPA_XqGOWBEmKgfZK7LN_0sFjTZKdB8u4Gi9dmU3Kw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] btrfs: fix silent failure when deleting root reference
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 23, 2022 at 12:47 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/8/22 22:47, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > At btrfs_del_root_ref(), if btrfs_search_slot() returns an error, we end
> > up returning from the function with a value of 0 (success). This happens
> > because the function returns the value stored in the variable 'err', which
> > is 0, while the error value we got from btrfs_search_slot() is stored in
> > the 'ret' variable.
> >
> > So fix it by setting 'err' with the error value.
> >
> > Fixes: 8289ed9f93bef2 ("btrfs: replace the BUG_ON in btrfs_del_root_ref with proper error handling")
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Thanks for catching this,
> Qu
> > ---
> >   fs/btrfs/root-tree.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> > index a64b26b16904..d647cb2938c0 100644
> > --- a/fs/btrfs/root-tree.c
> > +++ b/fs/btrfs/root-tree.c
> > @@ -349,9 +349,10 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
> >       key.offset = ref_id;
> >   again:
> >       ret = btrfs_search_slot(trans, tree_root, &key, path, -1, 1);
> > -     if (ret < 0)
> > +     if (ret < 0) {
> > +             err = ret;
> >               goto out;
> > -     if (ret == 0) {
>
> Just a small nitpick here, since above if (ret < 0) branch will call
> "goto out", we don't need the "else" branch.
> The old "if (ret == 0) {" should be good enough.

Yes, it's not about correctness. It's just my preferred style.
I find it more intuitive to have a single if-else that tests the same
variable instead
of having it tested by two distinct if statements.

>
> Thanks,
> Qu
>
> > +     } else if (ret == 0) {
> >               leaf = path->nodes[0];
> >               ref = btrfs_item_ptr(leaf, path->slots[0],
> >                                    struct btrfs_root_ref);

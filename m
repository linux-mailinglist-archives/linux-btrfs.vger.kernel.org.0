Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D3D68B5C0
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Feb 2023 07:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBFGrL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Feb 2023 01:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBFGrK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Feb 2023 01:47:10 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9726218B28
        for <linux-btrfs@vger.kernel.org>; Sun,  5 Feb 2023 22:47:08 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id r9so8939571oig.12
        for <linux-btrfs@vger.kernel.org>; Sun, 05 Feb 2023 22:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BdWp/xbAoW7foQ2b5fLnzPWVXYVhGIizYwrcFiu54l4=;
        b=VQSpwsX3hhLi6aXT/5Gpcy71/sFki4hVbc8wNXm1kRQvwNQU3mCgxpRoOldomitW3U
         JywsbRMUrWyll6GEl7HTteV+7FnzqrPnS4PRlI60wE2+NM+47Nf90w8GRtjFAG8xKj+l
         b9JB5zuSr31r+LObErZmIAciULcFty4prLwqwtrYR+690qENdylzGpcGHWswJvEKWVhe
         Q56jPZhGotCC4UQQrAEtfRPRl2kLcFGs+4r3bfN655FoQwfT+47LsKCvVUNhxpR3O6oT
         LzdMVD61Sspse010UEmngOs8wu/oRUPnrbs7PssQZgm/X0Vr0O9bAem+laTUoGlCZo5V
         9Vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdWp/xbAoW7foQ2b5fLnzPWVXYVhGIizYwrcFiu54l4=;
        b=B79JaU4Uha3edMcZeaxpKMGkw2yBUTNXyfkADzaTJsJtINM4erU8w0Jladv/AsnIVW
         tcMaPPsoxYjTnAPO6fFuri3lmKqWi2QOm1cthrtKcKCtX4zYxptqcqow73/OJzHIDAOi
         eU63igDKMPcufBVAx9i0YQLBrFz05mTVxawRhWHAw8qd8VSNe3/XrYLLxySrFU70+GMp
         s5y5q6ZyAayaJ6gH1tSQyidBNo8oJ2TPirTG/cizrxo+HXLDfAByKPI4y+Bu3NWV0dmM
         gpiw9FyrH+6hg1duzHRp2Ig+GbH0WItsa8R2sNzYp7L7o5f+3cEb6vNNLT9I06/O1eCZ
         Gqiw==
X-Gm-Message-State: AO0yUKUQNL1hn9X1Pidqq4wE0yLBaO8K6kf5vACqy9FgYj4NPXAA6t9V
        d8Cb+rpCIotfnTAR3+7rWzzjCzLuj64GUSbxpZJZvIdI
X-Google-Smtp-Source: AK7set/HuujIgoOhqHIXOdTsJ+0m0rTbuAvXcHhTwohWhcJ9WClNXtkOjhvUzbLGBVemk9XEsbQqQAw/nJiqpPiOY5Y=
X-Received: by 2002:a05:6808:df4:b0:37a:c14e:afc2 with SMTP id
 g52-20020a0568080df400b0037ac14eafc2mr898074oic.61.1675666027925; Sun, 05 Feb
 2023 22:47:07 -0800 (PST)
MIME-Version: 1.0
References: <10fd619ccbe568df4344b6b1d93f061bc493d396.camel@scientia.org>
 <9a49ccb8-9728-029f-be0e-75ccb8e211d0@gmail.com> <3c77c6306ece13559de514940074ac70b4fc882a.camel@scientia.org>
 <a134a22a-80f2-91a5-f0a1-21145c487118@gmail.com> <bcb9bfe78715e98ea758df3723daa8f9afb2f20a.camel@scientia.org>
In-Reply-To: <bcb9bfe78715e98ea758df3723daa8f9afb2f20a.camel@scientia.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Date:   Mon, 6 Feb 2023 09:46:56 +0300
Message-ID: <CAA91j0XNV68cuVmue7tuQDMZv7NirwWiJp1ntb1B9fKoSMKt-g@mail.gmail.com>
Subject: Re: back&forth send/receiving?
To:     Christoph Anton Mitterer <calestyo@scientia.org>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 6, 2023 at 7:31 AM Christoph Anton Mitterer
<calestyo@scientia.org> wrote:
>
> On Mon, 2023-02-06 at 07:16 +0300, Andrei Borzenkov wrote:
> > You stated that copies are on different media which means there is no
> > previous snapshot to apply changes to. If I misunderstood you, then
> > you
> > need to explain what "all being on different mediums" means.
>
> There are 4 HDDs:
> master
> copy1
> copy2
> copy3
>
> - Files are added/removed/modified on master.
> - Once new backups shall be made:
>   - a new ro-snapshot from the actual data-subvolume on master
>     is made, e.g. with the name of the current date
>   - that snapshot is then send|receive(d) to each of the copyN HDDs
>     - for the first time, this will obviously be non-incremental
>     - subsequently, the most recent common parent subvol on copyN and
>       master will be used with -p
>     - eventually, older subvols will be removed on all the HDDs;
>       on master of course only, if the respective subvol is no longer
>       needed for updating any of the copyN HDDs
>

OK, that's not exactly "all on different mediums", but rather several
(independent) chains of incremental snapshots, with each chain on a
different medium.

> Figured that's a pretty plain and common backup cycle using btrfs, so I
> didn't explain it any further in my original post.
>
>
> At a certain point in time, the scenario I've described in the original
> post occurs and e.g. master breaks or shall simply be replaced with a
> new HDD.
> Thus, a new master is needed, either the new HDD, or maybe one of copyN
> (just as described in the OP).
>
> But at that point, at least that was my understanding from the
> discussion some months ago, I cannot just e.g.:
> - send|receive from copy1 to new-master, continue there (on new-master)
>   to add/remove/edit data, make a new snapshot and then *incrementally*
>   send|receive back to the copyN HDDs.

You can always incrementally send, there is no problem. To actually
receive *and apply* incremental stream you need base snapshot (or
identical copy of base snapshot) to apply the changes to. So if you
make copy1 your new master, there is no way to continue incremental
send/receive to copy2, copy3, ... because copy2, copy3, ... do not
have snapshots present on copy1.

Same if you would copy/clone copy1 to another HDD.

> or alternatively:
> - send|receive incrementally from copy1 (which would then be the "new"
>   master) to copy2 and copy3.
>

See above.

> Being able to do so, would be the request of this post ;-)
>
>
> I mean the data should all be there, isn't it?
>

You need data at the exact point in time. According to your
description each of copy1, copy2, ... captures different points in
time.

To implement what you want one would need cross-filesystem support for
computing changes (compute difference between snapA on copy1 and snapB
on copy2 and recreate snapB on copy1 to get a common base snapshot).

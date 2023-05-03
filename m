Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36446F586F
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 15:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjECNBS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 3 May 2023 09:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjECNBR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 09:01:17 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A98DF
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 06:01:16 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-760ec550833so378376439f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 06:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683118875; x=1685710875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ew/7WH0nHS2Qs3ouKlDwP4gC7WZEOxH7zr7K9pR58cE=;
        b=XFLdxz53niXHhfgzSYFRAGRO+GMALn/rpWEZb/WNZMlqrpKel7P28Z4wU14qvdwEo8
         VdM4p7W77LvllNt8crjlUlFOgV0RZSzhgBzUzXjJtG51ZKCZ7VJMtVmk87HwSK0GkO36
         A8y6ZyFEzx5ipHmAfXgjLgpwJfHH16xuqn5NZfOp17AYzqo+fEIlWgJ014bgpeFWg3ao
         LTx5P6XIUktJFz58bOUh25G/iVAngxr7pnbZlcEK7E8+50q5f4hsMgmxO5q7PWErDaOi
         sAhrydZJpChLKMAwHcmBkmHdAKSRSrMv8COUhSxaP+Rfyq7qWDJ70eBnFiZ6zjCK7THH
         BztA==
X-Gm-Message-State: AC+VfDwOf9BZVbbmK/xvLID14sRLfuQ7hYIV8iSFA0cwPexgwD0WVn5U
        e8Vta2BsipyuKYYjnyPodaqkpUJZXhY1fA==
X-Google-Smtp-Source: ACHHUZ68j1Hj+/PpEg+MozW3A5tBQ1hyZm6JuqBiTwxqkXF5GeKny6QXPjdzuye+J8DZagyHFlwDcw==
X-Received: by 2002:a5e:d718:0:b0:766:5445:2690 with SMTP id v24-20020a5ed718000000b0076654452690mr15914649iom.14.1683118874737;
        Wed, 03 May 2023 06:01:14 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id g21-20020a05663816d500b0040fc9a4dc31sm9534241jat.38.2023.05.03.06.01.14
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 06:01:14 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-760ec550833so378373639f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 03 May 2023 06:01:14 -0700 (PDT)
X-Received: by 2002:a5d:924c:0:b0:760:f816:280b with SMTP id
 e12-20020a5d924c000000b00760f816280bmr14020546iol.8.1683118873805; Wed, 03
 May 2023 06:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhfkvwo=nmzrJSqZ2qMfF-rZB-ab6ahHnCD_sq9h4o8v+M7QQ@mail.gmail.com>
 <CAL3q7H5yKd1=WuZaU-s7hQ-MwzWONsOtVNoA6cjpLW0-3DDEEQ@mail.gmail.com> <CAL3q7H7FyF6YYuMbz0GTBb9G3WYxy9Pr9xQ11rde7jR3zVXuwA@mail.gmail.com>
In-Reply-To: <CAL3q7H7FyF6YYuMbz0GTBb9G3WYxy9Pr9xQ11rde7jR3zVXuwA@mail.gmail.com>
From:   Vladimir Panteleev <git@vladimir.panteleev.md>
Date:   Wed, 3 May 2023 13:00:57 +0000
X-Gmail-Original-Message-ID: <CAHhfkvzQaRtxBqSKodAj2Gy21TMRC_fOd0cq9ECcxnU4QeuV_w@mail.gmail.com>
Message-ID: <CAHhfkvzQaRtxBqSKodAj2Gy21TMRC_fOd0cq9ECcxnU4QeuV_w@mail.gmail.com>
Subject: Re: 6.2 regression: BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET broken
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, 3 May 2023 at 12:49, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Wed, May 3, 2023 at 1:37 PM Filipe Manana <fdmanana@kernel.org> wrote:
> > Are you able to apply and test a kernel patch?
> >
> > If so, try the following one (also at:
> > https://gist.github.com/fdmanana/9ae7f6c62779aacf4bfd3b155d175792)
> >
> > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > index e54f0884802a..c4c5784e897a 100644
> > --- a/fs/btrfs/backref.c
> > +++ b/fs/btrfs/backref.c
> > @@ -45,7 +45,8 @@ static int check_extent_in_eb(struct
> > btrfs_backref_walk_ctx *ctx,
> >         int root_count;
> >         bool cached;
> >
> > -       if (!btrfs_file_extent_compression(eb, fi) &&
> > +       if (!ctx->ignore_extent_item_pos &&
>
> This misses a:
>
> .. && ctx->extent_item_pos > 0 &&
>
> I've updated the gist with it:
> https://gist.githubusercontent.com/fdmanana/9ae7f6c62779aacf4bfd3b155d175792/raw/3f41c8486eb73a038f026c8bfe767bd763a016c9/logical_ino2_fix.patch
>
> Thanks.

Yes, it works!

The first version of the patch seemed to work too.

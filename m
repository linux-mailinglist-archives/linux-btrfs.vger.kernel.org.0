Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6415401F6
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jun 2022 17:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbiFGPBK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jun 2022 11:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239963AbiFGPAw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jun 2022 11:00:52 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8069AF5051
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jun 2022 08:00:51 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id i201so10139701ioa.6
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jun 2022 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBwHHdIwINEnVLyDksnFHABsH8TPC++cZC+9ooXKlDc=;
        b=50+SzPbYf3lq73QUgsikIjrMdVbJ75vXoKQEn+/ZVD8o0fDEfIqm8tnUW6dn2i8Z7z
         Nrfze7VYPXp12D8H7qWQ0yl1dTRdskmqEVPI3YhvTff1mCdko2epEgH8OotWn4orc7J3
         /46brg2LzxTK7KB2sOQX+7CmENaeiBHnmH89JMXw13BJYsPZoPyfLMLv3UsLz0jCE/Sd
         9ieaixWbT8JqvKZCFK0zm7WhqN+vSFWOLxuuKb2XETlgCzOLshtDGoBXZo3FOj3nKDrl
         tvgmcNI5hQUp7GGH9JdCnE/eTBM5SY2fcxRUd6GmdtkRyRCA/WzJ3mPiz9G3sX3F5hFV
         eR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBwHHdIwINEnVLyDksnFHABsH8TPC++cZC+9ooXKlDc=;
        b=LuyA/vce4a0veUQtTRof+y2seSax6Mgr8+SR4XOpdx8W63MI7ZVOcAev9MR0+3FWku
         y5nSfpb1WZ3JgOuFPtNEpM/XOQWXEKdra2gOzuvq6cWo1JmKbGjQ5yaoGueLh7+fDiC0
         PnJqdtp078Oj3vlodf65lI1mXsMf4w9HiFBYEAFmzH/dfDfg1LpU3d0UMJ0GYt1rBQRi
         hH2vD2itGizoNDiEvx2k+6oLwZuQSbUDjNiiPKbKOrUMBMcmN8JsWQPDIg6UkccctWhc
         38Sinwi6cZ/torF2XaRG6THh5Z2VdDZDg9ydn0eesTLR2n9BAo62AVR8uZ7vvZOjrKDS
         YIgg==
X-Gm-Message-State: AOAM532NJdqPtPKmw0cu6laCynPCLm3mbp/huidmXz54D55uaG4HFp95
        q5R2RJsDNXF7ocPg7gteAsPJE0rSPbW3qDLFkInsrgYI388=
X-Google-Smtp-Source: ABdhPJzBdMD9zwJqI784CfUFFpM9pRyteqK6rUYkiL5spHh6UenZ3zU8QwS87vc0E+lgSFn7U0U4bQZDIqZQIJHadJQ=
X-Received: by 2002:a05:6638:22cf:b0:331:a5b9:22f2 with SMTP id
 j15-20020a05663822cf00b00331a5b922f2mr6796992jat.218.1654614050768; Tue, 07
 Jun 2022 08:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220606212301.GM22722@merlins.org> <CAEzrpqdCpLsTqwBZ_W2sFZn9+uTrL88V=Cw6ZQe3XV0FxRO8nw@mail.gmail.com>
 <20220606215013.GN22722@merlins.org> <CAEzrpqcn_BRL7p3gPmS5OVn5D-m8hMB-5JcAHwEHwKpxGxOMqw@mail.gmail.com>
 <20220606221755.GO22722@merlins.org> <CAEzrpqcr08tHCesiwS9ysxrRQaadAeHyjSTg3Qp+CorvGz6psQ@mail.gmail.com>
 <20220607023740.GQ22722@merlins.org> <CAEzrpqcStzdJt-17404FhAZKww2Y1o7tu6QOgtVGziroGE0pCw@mail.gmail.com>
 <20220607032240.GS22722@merlins.org> <CAEzrpqc8f3HzxUG0Ty1NQoQKAEEAW_3-+3ackv1fDk68qfyf6w@mail.gmail.com>
 <20220607145347.GU22722@merlins.org>
In-Reply-To: <20220607145347.GU22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 7 Jun 2022 11:00:39 -0400
Message-ID: <CAEzrpqe2F=SYUheMXUkgFGVdXMr1MobSxCwWz=t8jAUD2t7yJQ@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 7, 2022 at 10:53 AM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Jun 07, 2022 at 10:51:35AM -0400, Josef Bacik wrote:
> > Hmm weird, I think I spotted it, give it a try again please.  Thanks,
>
> scanning, best has 0 found 0 bad
> checking block 15645485137920 generation 1601075 fs info generation 2588170
> trying bytenr 15645485137920 got 99 blocks 1 bad
> scan for best root 164629 wants to use 15645485137920 as the root bytenr
> Repairing root 164629 bad_blocks 1 update 1
> we're pointing at an empty node, delete slot 2 in block 15645485137920
> kernel-shared/extent_io.c:664: free_extent_buffer_internal: BUG_ON `eb->refs < 0` triggered, value 1
> /var/local/src/btrfs-progs-josefbacik/btrfs(+0x311a0)[0x5555555851a0]
> /var/local/src/btrfs-progs-josefbacik/btrfs(free_extent_buffer_nocache+0xe)[0x555555585a63]
> /var/local/src/btrfs-progs-josefbacik/btrfs(+0x8bb02)[0x5555555dfb02]
> /var/local/src/btrfs-progs-josefbacik/btrfs(+0x8c1ac)[0x5555555e01ac]
> /var/local/src/btrfs-progs-josefbacik/btrfs(btrfs_recover_trees+0x446)[0x5555555e0c4d]
> /var/local/src/btrfs-progs-josefbacik/btrfs(+0x8475a)[0x5555555d875a]
> /var/local/src/btrfs-progs-josefbacik/btrfs(handle_command_group+0x49)[0x55555556c17b]
> /var/local/src/btrfs-progs-josefbacik/btrfs(main+0x94)[0x55555556c275]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7ffff78617fd]
> /var/local/src/btrfs-progs-josefbacik/btrfs(_start+0x2a)[0x55555556be1a]
>

Sigh I had that thought and then didn't type it.  Try again please, thanks,

Josef

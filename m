Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1043C4F6CB9
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 23:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbiDFVcM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 17:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbiDFVby (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 17:31:54 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9974D2B4DE0
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 13:38:18 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id x4so4424345iop.7
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Apr 2022 13:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VEJ7lrqXMS5R3HROuj6nb5Ngf2w184uL0BeTdHRc/hs=;
        b=MMspGQsWgAUtCa4fBB8yU8Bf/ad69PV7GaqPAH9wB8GSAC2e9XjmCiFyHDr4MmAKs/
         ENLdAkkZxDT3hECtlrxzKRVIXldT636nLDU6cuwLR0bheJGNOsM+oNZ7rzJFdo26S0dt
         FB9OTVq/C0IEpcm3aZcBt+jsIqdhPblKzB0xiyDFIgDGhHqkuwH496fB/WXRJoS/jnHP
         2gcRQP5NGEt76voQrwzjZaNyLedIvKGG3LverZU5/EriUPZLLkUOCKSC+QeLH1ZjcaTF
         U7/Rgcjj7Fu0kc7B5xmWUp61jNOt5drloJkmiWu7u0K0rAMeVJ4LvcuRjb6tS28pWVzi
         YkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VEJ7lrqXMS5R3HROuj6nb5Ngf2w184uL0BeTdHRc/hs=;
        b=BUGA4Jy7+g+JHt/Hpn8K4G1lqfHRDBWvEj+SHHbQpR5O3U584lHlG5ycmeEGULlVFc
         dNMzLVTxkRSf4ocLFYftYC4HzMHhoMvMQY5O3GZGxUbj25KUXMp97BwsL+voZbkDwfZV
         wqoaRzTgrrmAU0GFAzb9Frj3kriWudN3WjBimvM2RxlSajximXupb4HGYmV1zbZOLXm9
         fMQiqvI9WYtkr5ov4GflaNDJW0DyYiBWclxyTLxK4aPDHeHxfDzJj0UFx9epoeotaefi
         6fC220uyWhxc710K39CV/jkYARSa0Lp/160QtTeX97PUsPqP/5n9qJ3oN8Ylst0owj8K
         jB/w==
X-Gm-Message-State: AOAM532DS1sqaUMD2ESjEMJd4slO25ARL3kexJsDOL1uuoA8oMAjBIAY
        rLIKaw1b8KASmbJLrq/VZtt6/265HEmgjpMs4EDQyjE+/L8=
X-Google-Smtp-Source: ABdhPJzoTltEMeTN9Q1CgMIXjr7urGyIYutA7WFkRJVtNh/G3p+lcOEDOqDrIxulsDKMMDppz95KvqP7jXg4/ckwvwM=
X-Received: by 2002:a05:6602:168b:b0:646:3bbb:7db4 with SMTP id
 s11-20020a056602168b00b006463bbb7db4mr4924443iow.134.1649277497888; Wed, 06
 Apr 2022 13:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220406003521.GM28707@merlins.org> <CAEzrpqesUdkDXhdJXHewPZuFGPVu_qyGfH07i5Lxw=NDs=LASQ@mail.gmail.com>
 <CAEzrpqfV9MgU_XbVxpnv05gKnKXQRnHy_BrSYddDfNLZFqi2+g@mail.gmail.com>
 <20220406031255.GO28707@merlins.org> <20220406033404.GQ28707@merlins.org>
 <CAEzrpqfnGCvE36-r-0OkN7yoA7j9XPCNqQVOnLrgA+cQZNoR3A@mail.gmail.com>
 <20220406185431.GB14804@merlins.org> <CAEzrpqd0Pjx7qXz1nXEXubTfN3rmR++idOL8z6fx3tZtyaj2TQ@mail.gmail.com>
 <20220406191636.GD14804@merlins.org> <CAEzrpqf0Vz=6nn-iMeyFsB0qLX+X48zO26Ero-3R6FLCqnzivg@mail.gmail.com>
 <20220406203445.GE14804@merlins.org>
In-Reply-To: <20220406203445.GE14804@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 6 Apr 2022 16:38:06 -0400
Message-ID: <CAEzrpqdW-Kf7agSfTy_EK6UYUt2Wkf53j-WTzKjSPXWYgEUNkw@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 6, 2022 at 4:34 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Apr 06, 2022 at 03:53:34PM -0400, Josef Bacik wrote:
> > Alright so it's up to you, clearly my put the tree back together stuff
> > takes forever, you can use --init-extent-tree with --lowmem if you'd
> > like, I have no idea what the time on that is going to look like.  You
> > still may run into problems with that if your subvols are screwed, but
> > then I just have to do the work to put subvols back together.  I
> > *think* the --init-extent-tree thing will be faster, but let me know
> > what you want to do.  Thanks,
>
> Thanks for sticking with me all this time.
> So, it was pretty quick before it failed:
>

Ah yeah I should have expected that, can you pull and re-run the same
command?  It'll tell me which root we need to target next.  Thanks,

Josef

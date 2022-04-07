Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE4C4F70B8
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 03:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbiDGBWW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 21:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240593AbiDGBU3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 21:20:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28B3B98
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 18:18:30 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id dr20so7701729ejc.6
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Apr 2022 18:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDgPnLYf/Z4QXYHUHX52HmP8pyE8AFGc06IAx2Hksh4=;
        b=Ka68Lw7LflqqKotfxi4lHLl1rdwe8k/LYau4VkSF0XhoKH9LdAepn0nk7xOipR02yi
         GNLCBDcZVjzei4yhAIQhNUMG6Prxp4x6CneCy049+1Otxvp23tdbYFrxtCBvZ/ZpQ6fj
         qOwVjj9tqd2GUOObbVBOTxaGKvrBGG1DlR5Fh7RsIAteEMGXVCLNTJUQIF7uM19Qij3z
         afnWqjxFiNIkK22as1hYnkjiTR10z+pC0vITTKJcI7OzgzcQKi9VJmbGQpURqEF74S1k
         suYvoxcSISWsKt8FjKNb8CE5k68NiAKlWxuOGrH6Hgl4jE+NZq+pxyGH4ohIaCePP9vq
         LLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDgPnLYf/Z4QXYHUHX52HmP8pyE8AFGc06IAx2Hksh4=;
        b=6RZrtV440vRp/N1odNAJbElGEPgYoaj7Y1hpw9Z9CrALoxaW4uBR5K9gcVeoiB/mlv
         4sr76MskfUm+i3qc/1Hpp+91NxTg5cQ7GC2r7atH6wRqOOrYyPQAGQXG5N7Co7/7jXur
         odHk3cGxqShGebUfQEmtCxdfm/UsThq1D5C8ZGlj+d7146py5hgnwZKVJn0NgqsSr+l6
         5wk8Lg/N8PC5iP3OG3poiff/WO0Q2rEwDAM2SGRjxN3o9oL9Yo2+o/XQ86oRfP4sYPFr
         tR1reRCcHicLhQPlroEw+aWWZNZQOo4keGmyK98qAdlyJ6Ko6h3vrmaVQRhtcGlNxHw9
         Teug==
X-Gm-Message-State: AOAM5310pL6n/gr6mLixrzeFYAf/nPwAv3tKDaQm3fGK6TheZFALpr7h
        xrc7mykGshhp5UxqWcPeVigNAoZdXhsF8fqLrEwi3CdF1bw=
X-Google-Smtp-Source: ABdhPJztitVW/rPs+iCbAksm7V0L7qs3XPhBPVx8BaCugYvXLTwWrofQxO9y81RL+U7jBfhJGdlvPjo8U/MCUsktp70=
X-Received: by 2002:a17:907:1c9e:b0:6e0:2fed:869a with SMTP id
 nb30-20020a1709071c9e00b006e02fed869amr10774694ejc.122.1649294309175; Wed, 06
 Apr 2022 18:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220406033404.GQ28707@merlins.org> <CAEzrpqfnGCvE36-r-0OkN7yoA7j9XPCNqQVOnLrgA+cQZNoR3A@mail.gmail.com>
 <20220406185431.GB14804@merlins.org> <CAEzrpqd0Pjx7qXz1nXEXubTfN3rmR++idOL8z6fx3tZtyaj2TQ@mail.gmail.com>
 <20220406191636.GD14804@merlins.org> <CAEzrpqf0Vz=6nn-iMeyFsB0qLX+X48zO26Ero-3R6FLCqnzivg@mail.gmail.com>
 <20220406203445.GE14804@merlins.org> <CAEzrpqdW-Kf7agSfTy_EK6UYUt2Wkf53j-WTzKjSPXWYgEUNkw@mail.gmail.com>
 <20220406205621.GF3307770@merlins.org> <CAEzrpqekB7GZ7wytx-Q2D7AnidBwVK2P5sc-NcBww0J666M5oA@mail.gmail.com>
 <20220407010819.GG14804@merlins.org>
In-Reply-To: <20220407010819.GG14804@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 6 Apr 2022 21:18:17 -0400
Message-ID: <CAEzrpqcFRaq9vrfLi_VcxWi9ZQGj+LgpXr5xwzw-2vWYHM6vJg@mail.gmail.com>
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

On Wed, Apr 6, 2022 at 9:08 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Apr 06, 2022 at 05:05:25PM -0400, Josef Bacik wrote:
> > Yup that's what I needed, the csum tree is screwed, and actually the
> > reinit stuff won't ignore the csum root if we're also init'ing the
> > csum root which is kind of annoying.  I updated the btrfs-find-root
> > tool to do the tree repair thing for the csum root, you can run
> > ./btrfs-find-root /dev/whatever so it'll fixup that tree, and then you
> > can re-try the btrfs check.  Thanks,
>
> Different output going back and forth, expected?
>

Yup it's iterating over all the blocks, so it's going to find
different slots in different blocks that are fucked.

You are having a lot of ones we can't find good matches for, depending
on what those look like I may need to adjust the code to simply delete
slots we don't find a good match for, which will be fine since we're
going to clear this tree anyway.  But let it finish and we'll see how
the repair goes and I can do that if we need to.  Thanks,

Josef

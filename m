Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE1A4F6CF1
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 23:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiDFVj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 17:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238050AbiDFViv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 17:38:51 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCB5FFE
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 14:05:37 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id 8so2845152ilq.4
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Apr 2022 14:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ON85b9n3yvWeGkAZ1Z0X6eQHDgLkDGCCNiAQBbgKmDk=;
        b=fSuFrJ33VcgnZ01zENvXUjrAtet6jKvVGQU3HqvLIjBF5NkpQ/ZL5XYvd4B8Vv3wbr
         F59l5XbCWfV8qH4FoY68HbC3H/YDM6J0k8bVmr9j8iSdSj+YXrPHF4Oltr5Hjd765tKC
         yU8+4eUx26YLqYtczXQym9yn7xoiZBx8bmnrkitidWk+UbZe8MK3vz6ukrFjYhB8NBd7
         OlFONmhUZ7jYKcm2Nb6vpfaWhph33BsjZ6I9DcBloSfyLxu+5WxBKwHG3Tbi8oXoQ8ZU
         zRFqXCcDz5xSQ6cO3qUc5u3dHFZDWWJiZA6q+pn+8UNpRiQ1ReSY36Ah72+CJN21NA3R
         OvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ON85b9n3yvWeGkAZ1Z0X6eQHDgLkDGCCNiAQBbgKmDk=;
        b=6684sCTWKTzI0/hSWAHBN8ta9v7LmFti6guJM+rDQCzoB6ifM4JUqVoCinnfy0YfGR
         WvgxGI0IMv0EP5JTzrDvO88ePZKMjTXYqcPYZygFffqACSdzbvv8IFXBwWSt8Wkis3aq
         WoPKwa3d8fggN1e+1JULywkiBLsqJ2mO6Xkd1aFlR1VcnOSKKzZx9c2GN2fBpMOXAavl
         D7Gu3FORldj16VrWjMD7H4imzeakJa6T1sd00nd31DA3LkcjPVXvp+2BSyVnDly/GUGu
         guPojRoKi9el7j0daYXJSDtt7MEnGHWop8NrmaCDmOhPR99VAk826Gxx5hgZbg1aJhGu
         q2NQ==
X-Gm-Message-State: AOAM533BmclrUrjBjY8CmImvHHNLhfsU919unHtmhfHHG9a98vvnq/au
        wJV6pSytgQfAexu4qodgtSp6+MuzGkgWQSL4ihsrcvODY4Y=
X-Google-Smtp-Source: ABdhPJxrBoaf5v9iPaK3GxhCKBtVSQQeQtSKrPsDXWw4+KTarJyM90pZoreLefCorh6M6S7LR5pHIDA34SoGRIX8Xvg=
X-Received: by 2002:a05:6e02:170a:b0:2c9:f038:7f2e with SMTP id
 u10-20020a056e02170a00b002c9f0387f2emr5121950ill.127.1649279136383; Wed, 06
 Apr 2022 14:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqfV9MgU_XbVxpnv05gKnKXQRnHy_BrSYddDfNLZFqi2+g@mail.gmail.com>
 <20220406031255.GO28707@merlins.org> <20220406033404.GQ28707@merlins.org>
 <CAEzrpqfnGCvE36-r-0OkN7yoA7j9XPCNqQVOnLrgA+cQZNoR3A@mail.gmail.com>
 <20220406185431.GB14804@merlins.org> <CAEzrpqd0Pjx7qXz1nXEXubTfN3rmR++idOL8z6fx3tZtyaj2TQ@mail.gmail.com>
 <20220406191636.GD14804@merlins.org> <CAEzrpqf0Vz=6nn-iMeyFsB0qLX+X48zO26Ero-3R6FLCqnzivg@mail.gmail.com>
 <20220406203445.GE14804@merlins.org> <CAEzrpqdW-Kf7agSfTy_EK6UYUt2Wkf53j-WTzKjSPXWYgEUNkw@mail.gmail.com>
 <20220406205621.GF3307770@merlins.org>
In-Reply-To: <20220406205621.GF3307770@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 6 Apr 2022 17:05:25 -0400
Message-ID: <CAEzrpqekB7GZ7wytx-Q2D7AnidBwVK2P5sc-NcBww0J666M5oA@mail.gmail.com>
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

On Wed, Apr 6, 2022 at 4:56 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Apr 06, 2022 at 04:38:06PM -0400, Josef Bacik wrote:
> > Ah yeah I should have expected that, can you pull and re-run the same
> > command?  It'll tell me which root we need to target next.  Thanks,
>
> Not sure it helped.
>

Yup that's what I needed, the csum tree is screwed, and actually the
reinit stuff won't ignore the csum root if we're also init'ing the
csum root which is kind of annoying.  I updated the btrfs-find-root
tool to do the tree repair thing for the csum root, you can run
./btrfs-find-root /dev/whatever so it'll fixup that tree, and then you
can re-try the btrfs check.  Thanks,

Josef

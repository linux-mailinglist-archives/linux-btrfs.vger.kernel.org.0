Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1B15277ED
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 May 2022 16:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbiEOOCY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 May 2022 10:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiEOOCW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 May 2022 10:02:22 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764841D332
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 07:02:21 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id i5so8909104ilv.0
        for <linux-btrfs@vger.kernel.org>; Sun, 15 May 2022 07:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JydOfHk6egw7RDtwuRmsumr6YAl774p/LcclqHia21g=;
        b=oNvu+LFqPqBbwi3NFCscOkq1EUWYUZBUsNQKDJL5k6v68O1ML31SnjEUZI31iXZ0TR
         Rdt1bTfFYWov6euLmt4JBS8oSZOjmgwdTj83U7Eyv1BxtlqSK5RMsBJFoH3Qda2iM/5N
         nG1TeLpwLdJXGT+eiQircb9bDDg73+3Wb85dc6cU0v+ppyJCP6PPc9pLLXP7935C/D64
         oavPfm4/Nq56BKnjdOttsX3emW5Rb1qnQFAfI/l0F7FPC/Qg1VjABOe9bjmrptB5Io9/
         KRo86WokjxUX76rb2eDLVHQppG0Diqgwqzbv8hZgY4j8b9jUhoJPF4iI4mA0iYnKY8v9
         G63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JydOfHk6egw7RDtwuRmsumr6YAl774p/LcclqHia21g=;
        b=PIS9+Nl+F7SL/T8CBEtODe+GsjcIgKECrhD3mBDA/VBr2l7AWnMoVTuWVP/Qys1iE4
         dzDg/U//HQ07Vh5gDzjtObwixCzqWinhBO0+JUHjrciw2RMw9mCzx4OnhDU4ok3Gsvnr
         uhBimbKDiidXwCPFWgzXta1Uj2ZCeTu796KYcjde8PzH8MPlvXUC6XqAQxo/9wvZKZtA
         QnhNqhuRIduIOB9jd84/12VwqkSFh0ChuvVpVfM3fp+82r/c5/z0gmq7lYJ30cpR60lG
         kWUmiRa9vFG+UYwmOqZJMSkQT7u/D/jeT0Pgg1PY+aiLuFDvahZSRsCW39XBE/ZzCEvE
         BtuA==
X-Gm-Message-State: AOAM531MsWw7MHj72aCicI56P3DDXKj58/O4oxCVuuMsbTWaDnfehVA+
        CYA3pMTVAVh0vlgW6gljgva8gMxkSy5wlIzeHWu/mR7r09Y=
X-Google-Smtp-Source: ABdhPJzJ/J51ALc1sQgo2quReiiajgC6vt5/XfXUNLTOAIU/J6msk8ybPncqfE0PbTo/2eBTZUbp/mtYk9lEufTHKVc=
X-Received: by 2002:a92:d2ca:0:b0:2ca:ca3a:de89 with SMTP id
 w10-20020a92d2ca000000b002caca3ade89mr6998990ilg.127.1652623340747; Sun, 15
 May 2022 07:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220511000815.GK12542@merlins.org> <CAEzrpqcPdf8kNjywtGY-OKDAm-87o+1QDh0qX+0mOSV3D4WEqQ@mail.gmail.com>
 <20220511014827.GL12542@merlins.org> <CAEzrpqfzXn0sZNVDud4UfysxvF4mgbq_a_ToJioDFz2wE-d3Rw@mail.gmail.com>
 <20220511150319.GM29107@merlins.org> <CAEzrpqcT0fObDa8XFWtvzeqCKom42t5o+xE9atmFjWyHCHmb=g@mail.gmail.com>
 <20220511160009.GN12542@merlins.org> <CAEzrpqdO4FX0A1b9xYycJQuMsvzUegSLcze4hpkMOD9dn2F-pQ@mail.gmail.com>
 <20220513144113.GA16501@merlins.org> <CAEzrpqfYg=Zf_GYjyvc+WZsnoCjiPTAS-08C_rB=gey74DGUqA@mail.gmail.com>
 <20220515025703.GA13006@merlins.org>
In-Reply-To: <20220515025703.GA13006@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 15 May 2022 10:02:10 -0400
Message-ID: <CAEzrpqfpXVBoWdAzXEYG+RdhOMZFUbWBf6GKcQ6AwL77Mtzjgg@mail.gmail.com>
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

On Sat, May 14, 2022 at 10:57 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Fri, May 13, 2022 at 12:16:02PM -0400, Josef Bacik wrote:
> > Once Sarah is asleep I'll look at the code, we can probably make this
> > go faster, but you've got a lot of data so I expect it's going to take
> > some time.  Thanks,
>
> It's still running on my side, almost 4 days. Is there any way to know
> whether I'm close to 100%, or not really?
>

The fs based refill isn't snapshot aware, so it's going to search
everything constantly which is annoying.  I've got some time this
morning, I'll write up something different.  THanks,

Josef

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A9F437BC0
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Oct 2021 19:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbhJVRUs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Oct 2021 13:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbhJVRUs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Oct 2021 13:20:48 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67275C061764
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Oct 2021 10:18:30 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id r184so8496392ybc.10
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Oct 2021 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rAXB6AO/GRdtUgRfmfyh2ADeiBB2+eCt3CGpSoLu7zI=;
        b=G+0hXVbkPI/eg9vLJe2V9DraCG+h4GtRDYWzvMe4yxf2nUufAB1kTYAan/dNXHblbd
         n3yslO5PwRKFVftGs0hdyb52I/lfrVGsuVZc8Og4L3t1N2r8s7trE7IcIh1j3qcerIQV
         nkP1GFFaotrY9OvwpIsx9gIvhZhKEdzTFV7PGJ5tPu0Cs9DOpT49iYH52Yppu55Sa1kg
         DY51t9Nw1Y8QepOh1r/aCqRHbZ3MwdacnIGDYRZgO9VwH7MvTCNRw50wsYVgnNChO8UL
         o2YpMMg6NZdguC/wagW9e5vBELK3m0oTSNQZEi/zIvMZE35GgNjKaQkpt9RrXtOobTj+
         8TgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rAXB6AO/GRdtUgRfmfyh2ADeiBB2+eCt3CGpSoLu7zI=;
        b=WHYD7pUO2C+7uwwT/o4hBfxQqieVEgI5OcB34mXoYgdJjKDWkLRtewVZoRDcnPYi60
         1A7qVhGXSPP8tal8cnszKCdnwg4MnE1gPNNb3VnqgJ6ys7yKdnVIIuU88iHf/+DzoA7T
         mL4wuIom26zgFkGHgQ4S4L2ClineMQlImbPkEMBhtwPoITLpNXhqpl8zKcT1aZqRXgS7
         wPYt16V/jE+O2K2pbLh2kro45gFwA+akcECFAdbkC7P488u1i8D7pv34Ne6GoMX7slwG
         0ZkD4qIdPsiKmvB3GRXahWNvnnEPF+bCQC3+zLpEb/HbE57MGB3LDToK7VgYLhBqdUQj
         bkoA==
X-Gm-Message-State: AOAM530+7+FiAanO0tvF5gfNRerAfxQzqqreCwRjEI1rl/Olr4WM6Piy
        VoP3K/GclrKmOJghEWYi46JmlznlgVc7zHtPx44N1g==
X-Google-Smtp-Source: ABdhPJyIHpgYkpBIleq3K+Fb96KOSGDUmUxJQkIiAXPopf4+cWol/ImYO+2B/gqbICIAQ/GM3Oqms0It4+2On5RE1ZE=
X-Received: by 2002:a25:4d83:: with SMTP id a125mr1065444ybb.277.1634923109586;
 Fri, 22 Oct 2021 10:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com> <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com> <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su> <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su> <CAJCQCtS-QhnZm2X_k77BZPDP_gybn-Ao_qPOJhXLabgPHUvKng@mail.gmail.com>
 <ff911f0c-9ea5-43b1-4b8d-e8c392f0718e@suse.com> <9e746c1c-85e5-c766-26fa-a4d83f1bfd34@suse.com>
In-Reply-To: <9e746c1c-85e5-c766-26fa-a4d83f1bfd34@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 22 Oct 2021 13:18:13 -0400
Message-ID: <CAJCQCtTHPAHMAaBg54Cs9CRKBLD9hRdA2HwOCBjsqZCwWBkyvg@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>, Su Yue <l@damenly.su>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 22, 2021 at 7:43 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> I also looked at the assembly generated in async_cow_submit to see if
> anything funny happens while the async_chunk->inode check is performed -
> everything looks fine. Also given that the extents list is empty and the
> inode is NULL I'd assume that the "write" side is also correct i.e the
> code in async_cow_start. This pretty much excludes a codegen problem.
>
> Chris can you add the following line in submit_compressed_extents right
> before the BTRFS_I() function is called:
>
>  WARN_ON(!async_chunk->inode);
>
> And re-run the workload again?

I'll look into how we can do this. I build kernels per
https://kernelnewbies.org/KernelBuild but maybe it's better to do it
within Fedora infrastructure to keep things more the same and
reproducible? I'm not really sure, so I've asked in the bug
https://bugzilla.redhat.com/show_bug.cgi?id=2011928#c41 - if you have
two cents to add let me know in this thread or that one.

Any other configs to change while we're building a new kernel?
CONFIG_BTRFS_ASSERT=y ?

inode.c
849:static noinline void submit_compressed_extents(struct async_chunk
*async_chunk)
850-{
851-    struct btrfs_inode *inode = BTRFS_I(async_chunk->inode);

becomes

849:static noinline void submit_compressed_extents(struct async_chunk
*async_chunk)
850-{
851-    WARN_ON(!async_chunk->inode);
852-    struct btrfs_inode *inode = BTRFS_I(async_chunk->inode);

?
(I'm looking at 5.15-rc6)



-- 
Chris Murphy

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FBF4364B2
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 16:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhJUOvN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 10:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUOvK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 10:51:10 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2200CC0613B9
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 07:48:54 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v200so762879ybe.11
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3LL34yWxWyQ1H9uT7CS94EDIv7hnYR0661N+LGgm02Y=;
        b=bJeqF6ymq9hIy3Dq4d9Z7S4P+jtLv4loDbCAa/JZ3LIdST/jYEo6PK9NITtesC7rju
         i4CIdgH1OzLvXayFn8V+43jTSELSBHAO18s6zsaowWn7bf44lQo3NkcTOL949qkEMvbF
         QExe5qguQ+19tvGSJ4oFbuuXle5Bt5kg87uNNZ3K3RjrC4j5glL1QbCAU8WbnBKAc7pE
         MQGFg4gYA7NGQFwNE3b+DXLmS40GF5Uo0atBKFNO42XYF8yhW+7KI787mBoQsBqcFLD2
         09oMR2yzCjhTiKTMe0iyj8jTVg/mmGISYkUtxYYGnJe42ynwMBYKb9bsONr7fDWy67w9
         JrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3LL34yWxWyQ1H9uT7CS94EDIv7hnYR0661N+LGgm02Y=;
        b=Ah14tYIiVF2tTKBG8kJbA9KRwILMqNgAM3PbVdWKJ9WKwbnlzAdFw0GkGkPX3xKZA2
         H+9eqvql+/ESpGDyioUviwgtes76USX+zAkD7lVMdmb8jTSnoLUV7xDnAAw+xGSFacA/
         RMV8zzMnsFECKNINov2cxoH+cGUevE4mLdEyYCR+0WwNS4XmXPtQjQnGz+RsDRZ/csbD
         /qEXLLpGsS/TwUKJTJjCKi9Q7a2Awc7io/3T5Los326Jkr4EsD5crxaKE407LS4wR7YL
         JuNFe7dmtpIkQBJFxgrh37iszdyf/blOaW8UHd2sz0raNtHNg2aoKfFMflR7/XcisgRK
         wr3A==
X-Gm-Message-State: AOAM533ElL1wcyfMQbYwcEM8qxurUJBR+xIgE2Y6AdhdGvtBnfnsp0dw
        u90JyNwuXrZfWQuIAHpPTvSxRU/+iihfoxFNcUnpQQ==
X-Google-Smtp-Source: ABdhPJxvDv2ZRHWAzy3lkO5bRKFiAp9cGarmXyOvujZI3hQzfGg21iKkCHSWKzVttgulvzi/Vqk7t/4aA771TPjsNXY=
X-Received: by 2002:a05:6902:102f:: with SMTP id x15mr6373566ybt.341.1634827733385;
 Thu, 21 Oct 2021 07:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTqR8TJGZKKfwWB4sbu2-A+ZMPUBSQWzb0mYnXruuykAw@mail.gmail.com>
 <debf9d63-0068-84db-dcd4-1d923742f989@gmx.com> <CAJCQCtSsLSwtNTrUKq_4Rs0tauT45iSA1+AkGWnS9Nmkb=0oWg@mail.gmail.com>
 <9b153cca-2d9a-e217-a83f-1a8e663fc587@suse.com> <CAJCQCtTAHmvwmypAgnLVr-wmuJpOxnmXzpxy-UdHcHO8L+5THw@mail.gmail.com>
 <e18c983f-b197-4fc5-8030-cc4273eda881@suse.com> <CAJCQCtSAWqeX_3kapDLr8AzNiGxyrNE7cO_tr3dM-syOKDsDgw@mail.gmail.com>
 <b1fccb42-da8a-c676-5f0b-1d80319e38ca@suse.com> <CAJCQCtSRxFuU4bTTa5_q6fAPuwf3pwrnUXM1CKgc+r69WSE9tQ@mail.gmail.com>
 <eae44940-48cb-5199-c46f-7db4ec953edf@suse.com> <CAJCQCtR+YQ2Xypz3KyHgD=TvQ8KcUsCf08YnhvLrVtgb-h9aMw@mail.gmail.com>
 <CAJCQCtQHugvMaeRc1A0EJnG4LDaLM5V=JzTO5FSU9eKQA8wxfA@mail.gmail.com>
 <CAJCQCtT12qUxYqJAf8q3t9cvbovoJdSG9kaBpvULQnwLw=rnMg@mail.gmail.com>
 <bl3mimya.fsf@damenly.su> <e75cf666-0b3a-9819-c6ac-a34835734bfb@gmx.com>
 <CAJCQCtT1+ocw-kQAKkX3wKjd4A1S1JV=wJre+UK5KY-weS33rQ@mail.gmail.com>
 <CAJCQCtTqqHFVH5YMOnRSesNs9spMb4QEPDa5wEH=gMDJ_u+yUA@mail.gmail.com>
 <7de9iylb.fsf@damenly.su> <CAJCQCtSUDSvMvbk1RmfTzBQ=UiZHrDeG6PE+LQK5pi_ZMCSp6A@mail.gmail.com>
 <35owijrm.fsf@damenly.su> <CAJCQCtR3upV0tEgdNOThMdQRE+fGH60vcbTeKagzXsw1wx9wMQ@mail.gmail.com>
 <y26ngqqg.fsf@damenly.su> <CAJCQCtScczmps7+NfNEObqOnsU64QHhjRRy0Fmj7W8z=ZJNK0g@mail.gmail.com>
In-Reply-To: <CAJCQCtScczmps7+NfNEObqOnsU64QHhjRRy0Fmj7W8z=ZJNK0g@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 21 Oct 2021 10:48:37 -0400
Message-ID: <CAJCQCtQuuzrzLDDZZ0jExeZ6RbDXH3wF7WFq02W77REMn4YJNA@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Su Yue <l@damenly.su>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[  287.139760] Call trace:
[  287.141784]  submit_compressed_extents+0x38/0x3d0
[  287.145620]  async_cow_submit+0x50/0xd0
[  287.148801]  run_ordered_work+0xc8/0x280
[  287.152005]  btrfs_work_helper+0x98/0x250
[  287.155450]  process_one_work+0x1f0/0x4ac
[  287.161577]  worker_thread+0x188/0x504
[  287.167461]  kthread+0x110/0x114
[  287.172872]  ret_from_fork+0x10/0x18
[  287.178558] Code: a9056bf9 f8428437 f9401400 d108c2fa (f9400356)
[  287.186268] ---[ end trace 41ec405ced3786b6 ]---
[61620.974232] audit: audit_backlog=2976 > audit_backlog_limit=64
[61620.978698] audit: audit_lost=1 audit_rate_limit=0 audit_backlog_limit=64


So it's at least 17 hours later since the splat. Is it worth sysrq+c
now this long after? Or should I set it up like Nikolay suggests with
kernel.panic_on_warn = 1? Maybe I should also put /var/crash on XFS to
avoid problems dumping the kernel core file?

--
Chris Murphy

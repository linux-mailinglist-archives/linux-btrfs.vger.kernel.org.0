Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB2F436496
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 16:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhJUOpi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Oct 2021 10:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhJUOph (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Oct 2021 10:45:37 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91095C0613B9
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 07:43:21 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i9so717093ybi.8
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wFWrVIJDZD8vZFQTWAClmJbfkrkgyN/qsMxYu8dWu4g=;
        b=jl8qnuLOVY10Do7q1dI4m6b5rOQN34xyhiHJHjJy3qwZxKu/4gMA+s/yHnOSGUkCdY
         gAurSrPnkaZ99jaSa1xQmnaSLmWu8qPffpIHbYzx8mq3fCpKGUZL3/o0kwceYmEZ+lDC
         pa2eTKoyO+0eb5BJrbCEJImLl8PPP7fJEWwt3/nQBw9Z+jg1+LmcwtAb0Z14rLXRIJa7
         EpnBTxnKxiWfMULwkPI320rO6OJGkA8NyUqJY74MF8svp5ncEarS5od7uylh8UDygSC6
         dX37ekYyGtrO3hRkkpk8aytyfX/keLz+bNMKDuM82L1QBP+N7RMtbEMpfRv5BIokzK7X
         0LEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFWrVIJDZD8vZFQTWAClmJbfkrkgyN/qsMxYu8dWu4g=;
        b=xEH0TmMMl2+K3fVKhEVDg0r48v4WuJZZARf3fhtU/j1Hkma+qrSNDdHRYaaTUsxoot
         qsyJQ11BdXpFjsneKwzn7eHHBT1kwwYV5MHdQQEZ3dw3s9kT2aEDPuO4B+NJnaRd6GLh
         aCxi+QubyU02XjjPUkukTkLLLA9HM7nWZiTw1KJbqinXeStcd/2V9BfnHYATr1L1bSG5
         IlP8rQia0TPc+uow2HdGDDiFKE4i8BAbtNKEfi3RlXpfMUy0O++p/0UErLvzttHpUvgt
         /4VkwSoCCdOHy2ZCLrbbzRfsy1k0wojoGHZ1S+QmxZYPIMILOFO916bANXZf91LFCaD7
         myUg==
X-Gm-Message-State: AOAM531MaOFAAH9QSqMtfxDDw3FKlZ49nMnnOIRGtmJgNbPp4P+Hz3K5
        3xdl3I4lsvGVgdppliuKLx+AZ8d75QxvTHjyta3mGg==
X-Google-Smtp-Source: ABdhPJyCrOxmtKtyVV/g65CcVHlrNB1QEAsH84o5K64sQx01yVsfZJ99dtqaWWyV8hK4wvFpe9DzdpKixOF0neeTaP0=
X-Received: by 2002:a25:4d83:: with SMTP id a125mr6584084ybb.277.1634827400793;
 Thu, 21 Oct 2021 07:43:20 -0700 (PDT)
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
 <y26ngqqg.fsf@damenly.su>
In-Reply-To: <y26ngqqg.fsf@damenly.su>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 21 Oct 2021 10:43:04 -0400
Message-ID: <CAJCQCtScczmps7+NfNEObqOnsU64QHhjRRy0Fmj7W8z=ZJNK0g@mail.gmail.com>
Subject: Re: 5.14.9 aarch64 OOPS Workqueue: btrfs-delalloc btrfs_work_helper
To:     Su Yue <l@damenly.su>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 20, 2021 at 8:34 PM Su Yue <l@damenly.su> wrote:
>
>
> On Wed 20 Oct 2021 at 19:55, Chris Murphy
> <lists@colorremedies.com> wrote:
>
> > On Tue, Oct 19, 2021 at 9:10 PM Su Yue <l@damenly.su> wrote:
> >>
> >> Dump file and vmlinu[zx] kernel file are needed.
> >
> > So we get a splat but kdump doesn't create a vmcore. Do we need
> > to
> > issue sysrq+c at the time of the hang and splat to create it?
> >
> Yes, please.
>
> BTW, I ran xfstests with 5.14.10-300.fc35.aarch64 and
> 5.14.12-200.fc34.aarch64 in several rounds. No panic/hang found,
> so I think we can exclude the possibility of the toolchain.

It's really weird. I was given a vexxhost aarch64 VM to play in and
try to get a vmcore for you guys, but nothing I did triggered the
splat. Then a colleague tried it, same hosting company, and was able
to reproduce it almost immediately. Same distro and kernel. So I don't
know what that means, if it's possible this the provisioning of the VM
could end up on different hardware, and it is some aspect of the
hardware that's resulting in this issue.

But anyway, he will be able to get a kernel core dump soon, and maybe
that'll tell us what's going on.


-- 
Chris Murphy

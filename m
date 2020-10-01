Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790FB27FFB6
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 15:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbgJANGA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 09:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732229AbgJANF7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Oct 2020 09:05:59 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF69C0613E3
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 06:05:59 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id d20so5129787qka.5
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Oct 2020 06:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=q1eU55WaiYq5ihsh9bOPBHwp2S1wxvI9ryjmDJ2+rFo=;
        b=ucw3RiPgMjc04+dk/EjJ22ZmGSReRMg/WD2i57bu9XH0sC1jQ+Y7BscCnd8XKX+smW
         Y0tAxswDDFAc5ujTcgf/pt/AeZ9ZObjowOx2r0ccf0QVA1FCHy6mtXzegCkhliJcsioA
         4FS8bJXA0eAN84GYt93cHrZsQ2w0nX20c8KFVO/2UqKAdVe+Z0vMxZLju+ICVgeu2o+S
         dm+0YaOqqGU8oE8SXMpgUHZqzXjiTPIcH3WKy5rlHEVuHCATkT3QMebuw4qkRNywnTer
         +tiOWryzz6wRfaFBlsap+A6mapVVS/6mxo8dqs2zZA2jCOiDvkn9XjoWsI5wajp+NqVG
         ud5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=q1eU55WaiYq5ihsh9bOPBHwp2S1wxvI9ryjmDJ2+rFo=;
        b=UH8feHzZJL8jmqH36GGbtKCOa8yIrSYd/FDCjJskS7e+tl5gPkbqAHvKHTt3j5CDI7
         2J7UJc/uIaSFdGdB7RhxWCXGaorxtmLL1I3dg8Tdno1xbIcf/viwIc6SbiC2ySmnP0SE
         mRHEh3BUi+P7D54Wf4aSjiunJeokUNhNveNSr45pZivbXNRtAOwY3SU7owdxIMcIoZNC
         gFjXayrT15ZPj08Xa4HGbmTaYCQ3GBlvmQIyeME9qDNa2UtDzPH0hxDJRl9Ldfojbewg
         ba/P4xLQ9Yfu1flyYdJ/XaHB38utK6WhmM9BuHt92QSMVhJqoh1fqWZPmE+qsXiwWafg
         jgEg==
X-Gm-Message-State: AOAM532nE/7+Ko3N5OtBBzpX0XddKmrqbF6AjG7W0/Iw7KbPasCce3Cx
        2JVIHCgEcssPH4kAwATxFIl3cHaQG252bfdXMD+Dmg==
X-Google-Smtp-Source: ABdhPJxoNi3A0iIn8S36y2UPdzAdaXTwkptOY34WGlEaili7XJhcivxY9F7KBM3sH3737tehdlfk+KAbWNHNcrMqpiY=
X-Received: by 2002:a37:a785:: with SMTP id q127mr7355005qke.256.1601557558431;
 Thu, 01 Oct 2020 06:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001fe79005afbf52ea@google.com> <20200930165756.GQ6756@twin.jikos.cz>
 <20200930180522.GR6756@twin.jikos.cz>
In-Reply-To: <20200930180522.GR6756@twin.jikos.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 1 Oct 2020 15:05:44 +0200
Message-ID: <CACT4Y+b6ctH447Hy9JuP1hF5MSV368WAB2tXz8xfi-5ZM-=tOg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in btrfs_scan_one_device
To:     dsterba@suse.cz,
        syzbot <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 30, 2020 at 8:06 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Wed, Sep 30, 2020 at 06:57:56PM +0200, David Sterba wrote:
> > On Sun, Sep 20, 2020 at 07:12:14AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    eb5f95f1 Merge tag 's390-5.9-6' of git://git.kernel.org/pu..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=10a0a8bb900000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ffe85b197a57c180
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=582e66e5edf36a22c7b0
> > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
> >
> > #syz fix: btrfs: fix overflow when copying corrupt csums for a message
>
> Johannes spotted that this is not the right fix for this report, I don't
> know how to tell syzbot to revert the 'fix:' command, there isn't
> 'unfix' (like there's 'undup').

Hi David,

I've added "unfix" command:
https://github.com/google/syzkaller/pull/2156

Let's give it a try:
#syz unfix

Thanks

Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549C128C36B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 22:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgJLUzw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 16:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgJLUzv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 16:55:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF226C0613D0;
        Mon, 12 Oct 2020 13:55:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id c20so4166354pfr.8;
        Mon, 12 Oct 2020 13:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=//NcQlq5UsHGgbWgeHzty5MaRuyItJz9yI1g6VbhS+U=;
        b=Dib6y0SBrim3s4+CNlW2upCAfeDyiE+FCezdLI2j6DZQhSyguR+u/pchuOutRzSUG6
         ow5YygHC7KiOvtE5663dR0t5lNMtCgl03lz6JgiQYzb5ZpD3HxRbSCiXK4zZ4ZYWccvG
         41U5D1E2MeisrnXi/Pi2GJLlPNI6Xt768+UdX7gut7ixx1WDqa5Fpgw0Vh2yj0xMa0xo
         aNIcPnk2ahclhHWxpJLwNsNa60Wa5ajqUpRILEOepyJT73PeFszlRkYiuWtDAM2GfJKd
         TX9Kv3F+4ZOfVKumZwBELSAih4LASxud4JomMP2Pd5S2OPrXhpKLQVAVmkS/G1eepgho
         VEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=//NcQlq5UsHGgbWgeHzty5MaRuyItJz9yI1g6VbhS+U=;
        b=nAOZlyuQYhlopBKF87weeADfvMsYnJjaOpjr+bw9d0a8Loz9cER7i2Ygw/vRgaG3k/
         AeHGzEotnB/zKMT+dmrszN8NCQ6cC8Ztyb/NHS0zlqLJFOIuvdJJJA5z9d3MclYBbMXa
         NNDRElh0yWXFx3+fxl6MRxBTDXrO+o6epU9Z/UfWQ0x4yO6ew0TGpeNP8EkoMNvnlsI7
         MkBs49LtlQXmBXWUXx0AOQHCnTuPFDq8oLCy4DX62YhMHH9SqsgwO2M4Tn4SNnrDbH3L
         gqjhfPUwMgX9h/pGx+fIQkZOBe+QXLXohZiDuEIRuh/kXv7YyrkdQHAhTAw50rSY+SCG
         XiFQ==
X-Gm-Message-State: AOAM533AHhqDXX0yprXMCN+agBQwoURpjHEL/Bun3XPBofXLEGB4mySg
        0PFnW2g0wSz3IOcqtEO4ggI=
X-Google-Smtp-Source: ABdhPJw7IzKtBl/6dTB18wnt+mjwQ6+cZU8+NWOJI1xHslHIEVyW0NBKljqP4uMyOVDWgdVNNxTbsw==
X-Received: by 2002:a17:90a:fa48:: with SMTP id dt8mr7946949pjb.108.1602536151279;
        Mon, 12 Oct 2020 13:55:51 -0700 (PDT)
Received: from thinkpad (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id r16sm24932904pjo.19.2020.10.12.13.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 13:55:50 -0700 (PDT)
Date:   Mon, 12 Oct 2020 13:56:50 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     dsterba@suse.cz, Dmitry Vyukov <dvyukov@google.com>,
        Chris Mason <clm@fb.com>, dsterba@suse.com,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Cc:     gregkh@linuxfoundation.org
Subject: Re: KASAN: use-after-free Read in btrfs_scan_one_device
Message-ID: <20201012205650.GA1180751@thinkpad>
References: <0000000000001fe79005afbf52ea@google.com>
 <20200930165756.GQ6756@twin.jikos.cz>
 <20200930180522.GR6756@twin.jikos.cz>
 <CACT4Y+b6ctH447Hy9JuP1hF5MSV368WAB2tXz8xfi-5ZM-=tOg@mail.gmail.com>
 <CACT4Y+bQdT_eOcE-jOJQQFR_xi14YwBQUosuUTNq1t-k5JSFJQ@mail.gmail.com>
 <20201001133546.GV6756@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201001133546.GV6756@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 01, 2020 at 03:35:46PM +0200, David Sterba wrote:
> On Thu, Oct 01, 2020 at 03:08:34PM +0200, Dmitry Vyukov wrote:
> > On Thu, Oct 1, 2020 at 3:05 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Wed, Sep 30, 2020 at 8:06 PM David Sterba <dsterba@suse.cz> wrote:
> > > >
> > > > On Wed, Sep 30, 2020 at 06:57:56PM +0200, David Sterba wrote:
> > > > > On Sun, Sep 20, 2020 at 07:12:14AM -0700, syzbot wrote:
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following issue on:
> > > > > >
> > > > > > HEAD commit:    eb5f95f1 Merge tag 's390-5.9-6' of git://git.kernel.org/pu..
> > > > > > git tree:       upstream
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=10a0a8bb900000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ffe85b197a57c180
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=582e66e5edf36a22c7b0
> > > > > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > > > >
> > > > > > Unfortunately, I don't have any reproducer for this issue yet.
> > > > > >
> > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com
> > > > >
> > > > > #syz fix: btrfs: fix overflow when copying corrupt csums for a message
> > > >
> > > > Johannes spotted that this is not the right fix for this report, I don't
> > > > know how to tell syzbot to revert the 'fix:' command, there isn't
> > > > 'unfix' (like there's 'undup').
> > >
> > > Hi David,
> > >
> > > I've added "unfix" command:
> > > https://github.com/google/syzkaller/pull/2156
> > >
> > > Let's give it a try:
> > > #syz unfix
> > >
> > > Thanks
> > 
> > VoilÃ ! Unfixed:
> > https://syzkaller.appspot.com/bug?extid=582e66e5edf36a22c7b0
> 
> Thanks!

the problem is that btrfs_kill_super() frees *fs_info while it is still
being referenced by btrfs_scan_one_device() on behalf of another
concurrent mount syscall
a very simple and dumb fix is to remove that printk that references
*fs_info:
https://syzkaller.appspot.com/text?tag=Patch&x=123537fb900000
but instead, i think proper synchronization is needed here
any advice or pointers would be highly appreciated
tyvm!
